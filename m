Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7282BA2CE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 08:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKTHCQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 02:02:16 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:60599 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgKTHCQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 02:02:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605855735; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+pnwU6HI584Xc2VX0RecTeCQhWm+0kb3jt1sQFwbk6U=;
 b=MtxFdckY2R7VOIQegLBvti2/IypMPloIS2k/KEEJbGIWWtADw4yOxjJYJkxCajdsaj6BcmOu
 mwJcwcF9YXZV3XZIUkf3f2OCj5if8lptV9rdhsdMs37uysvAoSdvy0iIy3VOI/HRs4Y2KI9e
 mOS+rfTCe8JF+6/6Y6aW0eLER7s=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fb769d97ef0a8d843424fd7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 07:01:45
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3695AC43464; Fri, 20 Nov 2020 07:01:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7358CC433ED;
        Fri, 20 Nov 2020 07:01:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Nov 2020 15:01:44 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        ath10k <ath10k@lists.infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>, kuabhs@google.com
Subject: Re: [PATCH 1/3] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <CACTWRwtcd2rdE-JQTh0t=Xwu9Vv-2He2M4wVDXbbiV1FOyNq7g@mail.gmail.com>
References: <20201106100708.4609-1-cjhuang@codeaurora.org>
 <20201106100708.4609-2-cjhuang@codeaurora.org>
 <64e072a168c12f58847a5ee16bfdb7e47576284f.camel@sipsolutions.net>
 <00c810b30b91397e562ca54475940afc@codeaurora.org>
 <CACTWRwtcd2rdE-JQTh0t=Xwu9Vv-2He2M4wVDXbbiV1FOyNq7g@mail.gmail.com>
Message-ID: <02fee7badc98864c5a51f91604f7a416@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-20 04:25, Abhishek Kumar wrote:
> Hi,
> 
> Johannes has some good comments, apart for that I have some nits.
>> > And wait, I thought we agreed to remove the index? Now I'm confused.
>> >
>> Using index in SET operation doesn't add burden to userspace and 
>> kernel,
>> but it provides some flexibility so userspace can skip some certain
>> ranges.
> 
> I agree with Carl's comment, we do need the frequency index. If the
> frequency index is provided, then the order is not important which
> makes the data more clear or the set_sar_spec function needs to parse
> the frequency ranges (and ofcourse userspace has to populate that as
> well). If the frequency index is not provided, then the driver has to
> assume that the userspace is not making any error in mapping of the
> power and desired frequency.
> Other reason is, might be a bit unlikely, but if in future there are
> new subbands, then it gives a flexibility to the userspace to
> explicitly provide the band for which it needs to set the power for.
> 
>> + *     used with %NL80211_CMD_SET_SAR_SPECS. The message contains 
>> fileds
>> + *     of %nl80211_sar_attrs which specifies the sar type and related
> 
> typo: fileds .. you mean fields
> 
I will fix all the spelling errors and send V2.

> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
