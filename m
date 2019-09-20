Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16472B8B7E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395007AbfITH0g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 03:26:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390633AbfITH0f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 03:26:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B9AD61424; Fri, 20 Sep 2019 07:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568964394;
        bh=d7+TO87VIfvfu2IGyuveLnzDXAVHKUpPohwqSfGdOh8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oDxPp3VVRNyNCu062+U5G1c2iSoxcFqvmu4aBcUGMJLAzjAW6JfysoismdSMH+MhY
         SRdDPKdsp3cGbseGRC74pOnL6+0CoKykwLe8+fTFh5+Hg5/JpvW9WV8fhUzaz6S4Ms
         6ZYAONXZeghql7nY7deglu/sl5lHr4fC4m0OaoF4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA1E3601D4;
        Fri, 20 Sep 2019 07:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568964393;
        bh=d7+TO87VIfvfu2IGyuveLnzDXAVHKUpPohwqSfGdOh8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fE90PylC996qSdmvr8XlEB5njvm5OyJRZzJ2wLBpXLCxlnPC5I4kv6sc9Limjy1Sx
         MYCEQxJ+QLyioHcNXB5Lnlec4h7AahRUX8cHBOwXUyyZ5x3Iv5XMID5WnBuEAPFxvQ
         tsMkv7aHgVT+l8CUJ3JV2F0xh3CDPW+hUUokypW0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA1E3601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 05/15] rtw88: pci: release tx skbs DMAed when stop
References: <1568617425-28062-1-git-send-email-yhchuang@realtek.com>
        <1568617425-28062-6-git-send-email-yhchuang@realtek.com>
        <CA+ASDXOMao9uucGxa6C0Q99pFvAtKTptreeshbfKqiELDKUH0Q@mail.gmail.com>
        <F7CD281DE3E379468C6D07993EA72F84D18DC62E@RTITMBSVM04.realtek.com.tw>
        <CA+ASDXP_7FVEaQrE1V=rX0Vieu8GGWj+it7p4F_8XeRNniEWkw@mail.gmail.com>
Date:   Fri, 20 Sep 2019 10:26:30 +0300
In-Reply-To: <CA+ASDXP_7FVEaQrE1V=rX0Vieu8GGWj+it7p4F_8XeRNniEWkw@mail.gmail.com>
        (Brian Norris's message of "Thu, 19 Sep 2019 17:35:56 -0700")
Message-ID: <87tv97ctsp.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Tue, Sep 17, 2019 at 7:10 PM Tony Chuang <yhchuang@realtek.com> wrote:
>> > On Mon, Sep 16, 2019 at 12:03 AM <yhchuang@realtek.com> wrote:
>> > >
>> > > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> > >
>> > > Interrupt is disabled to stop PCI, which means the skbs
>> > > queued for each TX ring will not be released via DMA
>> > > interrupt.
>> >
>> > In what cases do you hit this? I think you do this when entering PS
>> > mode, no? But then, see below.
>>
>> I'll hit this when ieee80211_ops::stop, or rtw_power_off.
>> Both are to turn off the device, so there's no more DMA activities.
>> If we don't release the SKBs that are not released by DMA interrupt
>> when powering off, these could be leaked.
>
> Ah, I was a bit confused. So it does get called from "PS" routines:
> rtw_enter_ips() -> rtw_core_stop()
> but that "IPS" mode means "Inactive" Power Save, and it's only used
> when transitioning into idle states (IEEE80211_CONF_IDLE).
>
> Incidentally, I think this also may explain many of the leaks I've
> been seeing elsewhere, when I leave a device sitting and scanning for
> a very long time -- each scan attempt is making a single transition
> out-and-back to IPS mode, which meant it may be leaking any
> outstanding TX DMA. And testing confirms this: if I just bring up the
> interface, run a scan, then bring it down, I see many fewer unmaps
> than maps. Doing this enough times, I run out of contiguous DMA memory
> and the device stops working. This fixes that problem for me. So:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>
>
> I wonder if, given the problems I've seen (the driver can become
> totally ineroperable), this patch and the previous patch (its only
> real dependency) should be fast-tracked to the current release.

I agree, this sounds like a serious problem. So I'm planning to queue
patches 4 and 5 to v5.4, if it's ok for Tony.

-- 
Kalle Valo
