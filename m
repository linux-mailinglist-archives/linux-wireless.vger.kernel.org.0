Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998F63F860A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 13:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbhHZLES (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 07:04:18 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38516 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241842AbhHZLEP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 07:04:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629975808; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ze1gvytwG+YzCSkkrIuM/rcE4EjC+1fQocjTQr5++38=;
 b=GRjhLnKRTmoI87uPIWfQQ8s5kTQhjcPVaLS8orQFV4kr7mKQNJ50BskF9i9jEejGN+2lvbTN
 GDxPaxMYIHef7KckNPJAqti857QRrNdxzF5osYQSR9BcAaNyhantqekhzOg1ZZQYDyj9GqSk
 k7LZLboGB3SzpK4L3oX2v3KyMAw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 612774e040d2129ac11752bf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 11:02:56
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A8C5C43617; Thu, 26 Aug 2021 11:02:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EF8CC43460;
        Thu, 26 Aug 2021 11:02:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Aug 2021 19:02:55 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/8] cfg80211: add power type definition for 6 GHz
In-Reply-To: <4ab79bd421d021a2199c71471f60fefb97f317ad.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-2-wgong@codeaurora.org>
 <b6ba152ce1efde5863cae53a94728e8472ba53c0.camel@sipsolutions.net>
 <4ab79bd421d021a2199c71471f60fefb97f317ad.camel@sipsolutions.net>
Message-ID: <3fea8f33ea9c341fbe0e4c1443a2c378@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-26 16:22, Johannes Berg wrote:
> On Thu, 2021-08-26 at 10:20 +0200, Johannes Berg wrote:
>> >  struct cfg80211_chan_def {
>> >  	struct ieee80211_channel *chan;
>> > @@ -684,6 +685,7 @@ struct cfg80211_chan_def {
>> >  	u32 center_freq2;
>> >  	struct ieee80211_edmg edmg;
>> >  	u16 freq1_offset;
>> > +	enum nl80211_ap_reg_power power_type;
>> 
>> I'm not sure why this should be in the chandef, there's no way that
>> anything in cfg80211 is ever using it there, at least in your patches.
> 
> Does it even *apply* to a channel? What if I'm connecting to two APs on
> the same channel (two client interfaces)?
> 
this is one copy for each connection, each client has its own 
cfg80211_chan_def.
also it can be moved to struct ieee80211_bss_conf.
> johannes
