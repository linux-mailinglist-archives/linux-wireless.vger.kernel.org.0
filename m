Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C565EF915
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfD3MkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 08:40:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfD3MkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 08:40:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 293B860CED; Tue, 30 Apr 2019 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556628007;
        bh=7mf8R+wloTYKEFYFECtYgf/wzc7DlLLmper1FgnjV2A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dF1oz6eawgPAqtnEnoH9M36VTKzH/55fAAeK7+Lb+T0iCak6cR8kFh0Pvq+ELgWNC
         JKB28UpBD80uKv4Frf5wLF3+iXth1KgcmjGUF6A9N7QsNZdHJ226r+FBuWFMD3FnsB
         66eFPxe9ibrik12vp+F2QUF0ol3mJ1LRJFkd6r5Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 701EC60247;
        Tue, 30 Apr 2019 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556628005;
        bh=7mf8R+wloTYKEFYFECtYgf/wzc7DlLLmper1FgnjV2A=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aXLGY7hgGPFXE5/dLVeSa5fYRhud5y/DGFKepqaQE4hlwsaE/0XiIbZSoN1/C6kBN
         HKdSQqWrdzugO50mMF/J3/w+eVKbaGfEHPALOYzmjpQadOlBDtP7+3IsMH1S9WP9Q/
         YFUKQCr5B5xM2YqUuwYdPcfVilp4TOYUikJKIPPo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 701EC60247
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <pkshih@realtek.com>, <tehuang@realtek.com>,
        <Larry.Finger@lwfinger.net>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 00/14] rtw88: mac80211 driver for Realtek 802.11ac wireless network chips
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
Date:   Tue, 30 Apr 2019 15:40:02 +0300
In-Reply-To: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:49:50 +0800")
Message-ID: <87sgtzwtst.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> This is a new mac80211 driver for Realtek 802.11ac wireless network chips.
> rtw88 now supports RTL8822BE/RTL8822CE now, with basic station mode
> functionalities. The firmware for both can be found at linux-firmware.

This looks very good now. I did a quick review of the driver and had few
netpicks but nothing really blocking applying this. So I have now
combined these patches into one big patch and pushed it to the pending
branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=284d1e4e3311cfe67c1c57ccc275ff0f5666aeea

I appreciate if people could do a quick check and make sure that I
didn't do anything stupid when folding the patches. I'm planning to
apply this to master branch still today evening so that it makes to
tomorrow's linux-next build, and I can get it to net-next before the
merge window starts on Sunday.

Yan-Hsuan, during review you have received very good comments from a lot
of folks, I recommend you go through all of them and send fixes as
follow up patches. I can then apply them after the merge window.

-- 
Kalle Valo
