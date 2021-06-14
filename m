Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F4C3A6AE3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jun 2021 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhFNPuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Jun 2021 11:50:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13997 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233975AbhFNPuS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Jun 2021 11:50:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623685695; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=I+vZpbpKLEzGLLxZf9Yk3xMUZoRm0OPY8oqK1zrBVKE=;
 b=GbeggcpdkvaMhtLl49rhSKOPkyJ9rA2aODLxCbzinAsdkpMF08BH9rKknDmj3CaRmyz32aCr
 cjJy5sc+fvQdMwmtCCy5uv/Oig3Sj+hrv6RgO1Ejsdh+C77gMc4wfGYTy7ux+QyLR58dTmLG
 cR014ZJxwmagMbJ9ikHRzjNN7fg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60c77a262eaeb98b5ec0b788 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Jun 2021 15:47:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21551C4323A; Mon, 14 Jun 2021 15:47:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92522C43460;
        Mon, 14 Jun 2021 15:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92522C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wlcore/wl12xx: Fix wl12xx get_mac error if device is in
 ELP
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210603062814.19464-1-tony@atomide.com>
References: <20210603062814.19464-1-tony@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        Raz Bouganim <r-bouganim@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org,
        Carl Philipp Klemm <philipp@uvos.xyz>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210614154750.21551C4323A@smtp.codeaurora.org>
Date:   Mon, 14 Jun 2021 15:47:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote:

> At least on wl12xx, reading the MAC after boot can fail with a warning
> at drivers/net/wireless/ti/wlcore/sdio.c:78 wl12xx_sdio_raw_read.
> The failed call comes from wl12xx_get_mac() that wlcore_nvs_cb() calls
> after request_firmware_work_func().
> 
> After the error, no wireless interface is created. Reloading the wl12xx
> module makes the interface work.
> 
> Turns out the wlan controller can be in a low-power ELP state after the
> boot from the bootloader or kexec, and needs to be woken up first.
> 
> Let's wake the hardware and add a sleep after that similar to
> wl12xx_pre_boot() is already doing.
> 
> Note that a similar issue could exist for wl18xx, but I have not seen it
> so far. And a search for wl18xx_get_mac and wl12xx_sdio_raw_read did not
> produce similar errors.
> 
> Cc: Carl Philipp Klemm <philipp@uvos.xyz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied to wireless-drivers-next.git, thanks.

11ef6bc846dc wlcore/wl12xx: Fix wl12xx get_mac error if device is in ELP

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210603062814.19464-1-tony@atomide.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

