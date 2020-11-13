Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA12B178C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 09:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKMIvb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 03:51:31 -0500
Received: from z5.mailgun.us ([104.130.96.5]:28947 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgKMIvb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 03:51:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605257490; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RF0wHTRZby5rp7VKsagZrnKuUVTCouTD9qsmlKCOI44=;
 b=OSMtwgGBRjITUiVd0p93OJ6hWr6f7+aG3QGhFW2IN2MrfLVW9WYzVYJohpa+EThtumx3Urwe
 g0x+nFMs+MLb7tBo3CJhiwLbnZiWp9lVg4JNdqXsrqfUg7SqKAKiS0TRgO6yK6W9nUIPXjDr
 j9FIGp1HmIMR+u6oKdIZENmaEBE=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5fae4906309342b914c7d7d0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Nov 2020 08:51:18
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ACF87C433F0; Fri, 13 Nov 2020 08:51:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36914C433C8;
        Fri, 13 Nov 2020 08:51:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Nov 2020 16:51:17 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, kirtika@google.com,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH v2] mac80211: reject/clear user rate mask if not usable
In-Reply-To: <0e60e4cdc036a5ef7394848d212a6e3f499c386f.camel@sipsolutions.net>
References: <20170308132022.4216-1-johannes@sipsolutions.net>
 <07179008e9369bc81e152009ca85191d@codeaurora.org>
 <5decc452-7b2a-db1d-c5eb-04ab6bb61553@broadcom.com>
 <4b8f37fde23262547edb6ed4635cf89b@codeaurora.org>
 <cfee0b47ad026c74a105d3adf2923357bbc5e96e.camel@sipsolutions.net>
 <83dd20def685d303106f285400367b6e@codeaurora.org>
 <798cea679ae1df5a2ab9b59dd81c8e2b3ca2d6e3.camel@sipsolutions.net>
 <30e2e578983e4df447e0c26c5bba0aba@codeaurora.org>
 <0e60e4cdc036a5ef7394848d212a6e3f499c386f.camel@sipsolutions.net>
Message-ID: <256c487bb8c8c191a88d806e6125296e@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-13 16:35, Johannes Berg wrote:
> On Fri, 2020-11-13 at 16:35 +0800, Wen Gong wrote:
>> 
>> > I guess if we really want to redefine the user rate mask to not apply
>> > to
>> > control frames, then we can relax this?
>> >
>> Yes, for AP mode, it is hard to calculate the usable rates over all
>> stations.
>> But for STATION mode, it can set 54M because AP support it, so it 
>> should
>> not reject it.
>> If add a check for nl80211_iftype of ieee80211_vif in
>> ieee80211_set_bitrate_mask, it can
>> solve this like this:
>> if (sdata->vif.type != NL80211_IFTYPE_STATION &&
>> !(mask->control[band].legacy & basic_rates))
> 
> 
> That would forgo the check completely - we'd still need to check 
> against
> the *supported* rates.
> 
yes.
It can add check with supp_rates[band] of ieee80211_sta for 
NL80211_IFTYPE_STATION type.
for others, check with sdata->vif.bss_conf.basic_rates
> johannes
