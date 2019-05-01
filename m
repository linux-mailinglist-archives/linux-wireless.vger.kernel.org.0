Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7A105B5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 09:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfEAHJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 03:09:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfEAHJl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 03:09:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DBE5060A44; Wed,  1 May 2019 07:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556694579;
        bh=fKxQwV17HEWHZyZ9KayURg2up7pJe+kFtkZokaywfEQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DDWnhpKp6YyBYPqNMDN4R9hnQNuEcdctKLAUxgiRyd6ApRDBjLezpi1n5A1WR2nnd
         Yq0ZCqW072SiC2xhvdppMdIEBgS6AH95wlrY0dfeAjY2TelKwNH1xprmQmSxf8vG1r
         bqPb5k6GE8oXPoSerKGpCeSuySluSv7hr6DI68Ec=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B12B9602F3;
        Wed,  1 May 2019 07:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556694578;
        bh=fKxQwV17HEWHZyZ9KayURg2up7pJe+kFtkZokaywfEQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nL1sm5KT1aArpBLWYtFnOd9QPGB6tuJbBiMt7VVacE4fCW3wua6h5vg278hwL0vUb
         Dy1/KqXi6Le9RLUY/Gl3p9t/wTQOJHO9/9qXHsI8bUASPYWpzUmIUMKzju2n7rvYMl
         F8bjMGO06zDx4nAUyOYZeIfJ5DvXa6KUY/ZCmpwM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B12B9602F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stanislaw Gruszka <sgruszka@redhat.com>, yhchuang@realtek.com,
        linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        pkshih@realtek.com, tehuang@realtek.com, Larry.Finger@lwfinger.net,
        briannorris@chromium.org
Subject: Re: [PATCH v9 00/14] rtw88: mac80211 driver for Realtek 802.11ac wireless network chips
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <87sgtzwtst.fsf@purkki.adurom.net> <20190430155808.GA3019@redhat.com>
        <87v9yvo2y6.fsf@kamboji.qca.qualcomm.com>
        <20190430174234.GA16336@kroah.com>
Date:   Wed, 01 May 2019 10:09:34 +0300
In-Reply-To: <20190430174234.GA16336@kroah.com> (Greg KH's message of "Tue, 30
        Apr 2019 19:42:34 +0200")
Message-ID: <87muk6odld.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Tue, Apr 30, 2019 at 07:47:13PM +0300, Kalle Valo wrote:
>> Stanislaw Gruszka <sgruszka@redhat.com> writes:
>> 
>> > On Tue, Apr 30, 2019 at 03:40:02PM +0300, Kalle Valo wrote:
>> >> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >> >
>> >> > This is a new mac80211 driver for Realtek 802.11ac wireless network chips.
>> >> > rtw88 now supports RTL8822BE/RTL8822CE now, with basic station mode
>> >> > functionalities. The firmware for both can be found at linux-firmware.
>> >> 
>> >> This looks very good now. I did a quick review of the driver and had few
>> >> netpicks but nothing really blocking applying this. So I have now
>> >> combined these patches into one big patch and pushed it to the pending
>> >> branch:
>> >> 
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=284d1e4e3311cfe67c1c57ccc275ff0f5666aeea
>> >> 
>> >> I appreciate if people could do a quick check and make sure that I
>> >> didn't do anything stupid when folding the patches.
>> >
>> > I've build pending branch and done few quick tests on Realtek
>> > 8822CE device. Everything works ok.
>> 
>> Thanks so much for this, I now feel much more comfortable merging it :)
>> 
>> So this is manually applied to wireless-drivers-next:
>> 
>> e3037485c68e rtw88: new Realtek 802.11ac driver
>> 
>> And it should be in tomorrow's linux-next build, let's see what kind of
>> reports we get. Greg, feel free to delete the corresponding staging
>> driver from your tree (I forgot the name of the driver already).
>
> I'll be glad to do so if someone also tells me what the driver's name is
> as well, I don't remember either :)

I checked it now, the directory is drivers/staging/rtlwifi. Here's the
commit adding the upstream driver, in case you need that in the commit
log:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=e3037485c68ec1a299ff41160d8fedbd4abc29b9

-- 
Kalle Valo
