Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F32FE1C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfD3QrU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 12:47:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3QrU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 12:47:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10D7560E5A; Tue, 30 Apr 2019 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556642839;
        bh=R4IGVmcE3UIUAHmTtuGZTpZKMslbpzU2dDkhFV1XtF8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Xh8tEa3C+dwlIi3+bBr5zGz6xRK0yUGxJfe4Wigk4Rqi5iSSUO4qJueyZRWuadHJ0
         00HDMtli4dcfmHTs3/VBrePXHwI93+Yx8PUJl3859088/qznauZ+C2Vf68HFDhUTAi
         +QXiwwohJsWQ7sCuiXFEpEbEjbN7Go9yF75sJjCw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0777360A42;
        Tue, 30 Apr 2019 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556642838;
        bh=R4IGVmcE3UIUAHmTtuGZTpZKMslbpzU2dDkhFV1XtF8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=m2NLGcLio9iwszKVxCeoll1CqVACC/ez3TtHubIH7XFhZqBpFeO7MozpFSnCFDpD3
         uWQTADEd8pRtdh5+nv6EkHVNagFwMo6eImm7XlrE/m6sYA+nk1vZSrvQ/USgiBwD8n
         KA9Wuo3zTs6sKYs4pxAHwdKzzOAuGLuOv3vqflLU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0777360A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     yhchuang@realtek.com, linux-wireless@vger.kernel.org,
        johannes@sipsolutions.net, pkshih@realtek.com, tehuang@realtek.com,
        Larry.Finger@lwfinger.net, briannorris@chromium.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v9 00/14] rtw88: mac80211 driver for Realtek 802.11ac wireless network chips
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <87sgtzwtst.fsf@purkki.adurom.net> <20190430155808.GA3019@redhat.com>
Date:   Tue, 30 Apr 2019 19:47:13 +0300
In-Reply-To: <20190430155808.GA3019@redhat.com> (Stanislaw Gruszka's message
        of "Tue, 30 Apr 2019 17:58:08 +0200")
Message-ID: <87v9yvo2y6.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> On Tue, Apr 30, 2019 at 03:40:02PM +0300, Kalle Valo wrote:
>> > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> >
>> > This is a new mac80211 driver for Realtek 802.11ac wireless network chips.
>> > rtw88 now supports RTL8822BE/RTL8822CE now, with basic station mode
>> > functionalities. The firmware for both can be found at linux-firmware.
>> 
>> This looks very good now. I did a quick review of the driver and had few
>> netpicks but nothing really blocking applying this. So I have now
>> combined these patches into one big patch and pushed it to the pending
>> branch:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=284d1e4e3311cfe67c1c57ccc275ff0f5666aeea
>> 
>> I appreciate if people could do a quick check and make sure that I
>> didn't do anything stupid when folding the patches.
>
> I've build pending branch and done few quick tests on Realtek
> 8822CE device. Everything works ok.

Thanks so much for this, I now feel much more comfortable merging it :)

So this is manually applied to wireless-drivers-next:

e3037485c68e rtw88: new Realtek 802.11ac driver

And it should be in tomorrow's linux-next build, let's see what kind of
reports we get. Greg, feel free to delete the corresponding staging
driver from your tree (I forgot the name of the driver already).

-- 
Kalle Valo
