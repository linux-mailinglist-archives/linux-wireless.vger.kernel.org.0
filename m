Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573943F9230
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 04:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbhH0CDF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 22:03:05 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:35110 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhH0CDF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 22:03:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630029737; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=01sQCPM90oT/9Y0DVA/AYmIOOSIUjqYBOT5kYLBRkUA=;
 b=mZtakYgfaieBhXBfPAeiVYvTejtSDPyHWta6AjDJ9VmuKMr7ol9yJGr9hdxyC07aIgt39Mv/
 kVP7gS6eJ2wRMaVrIDZTnYtD0OygIZm3QJ53etpiwapMiCLu2Iur77lemCEFPwoMH03qGJ0F
 0WVyZoaJL1Ga3NJJjMA1KzRT2J8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 61284793fc1f4cb6929e39ff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Aug 2021 02:01:55
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CFE0EC4360D; Fri, 27 Aug 2021 02:01:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6754EC4338F;
        Fri, 27 Aug 2021 02:01:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Aug 2021 10:01:54 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <e75ee4e160d6ec09d9c5f131f882d2e9d8eb49cd.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-9-wgong@codeaurora.org>
 <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
 <fe21853e8c9a73632e0ca860eef00296@codeaurora.org>
 <5c85b2bcfbffb617c5aa3f55e7ae94a1ab4df743.camel@sipsolutions.net>
 <f86091b72422d194a2e59b1f6d27a69b@codeaurora.org>
 <e75ee4e160d6ec09d9c5f131f882d2e9d8eb49cd.camel@sipsolutions.net>
Message-ID: <6cf1f6ee76f675831ca506d188c58850@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-26 19:10, Johannes Berg wrote:
> On Thu, 2021-08-26 at 19:00 +0800, Wen Gong wrote:
>> On 2021-08-26 18:57, Johannes Berg wrote:
>> > On Thu, 2021-08-26 at 18:50 +0800, Wen Gong wrote:
>> > > >
>> > > it is memset here i this patch:
>> >
>> > Oops, missed that.
>> >
>> > But is that really a good place for it? Doesn't really seem to belong
>> > to
>> > assigning a channel context - maybe put it into set_disassoc()?
>> >
>> it is correct.
>> you can see it is place together with "drv_unassign_vif_chanctx(local,
>> sdata, curr_ctx)"
>> in ieee80211_assign_vif_chanctx(), it is for disconnect.
> 
> Yes, I know it's *correct*, but that doesn't mean it's *good*?
> 
> Look at that code - it does nothing with bss_conf. Nobody is ever going
> to look there.
> 
Yes,
seems it is better do memset() in ieee80211_set_disassoc().
I will change it in next verion.
> johannes
>> 
