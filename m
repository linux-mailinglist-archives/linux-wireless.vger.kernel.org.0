Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCC43E12AD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhHEKbZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbhHEKbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:31:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E6C061765
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 03:31:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t9so10103039lfc.6
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GCz8VghwWMAz9oUJUmO8qp9qmqaKvRvMgArRh6FY3ac=;
        b=qnjpEdJxP08hVHqyyCviZ9qzxhpqIbEdXs88KAENW+dk364qQJrBDtE5z5e6cIeaFU
         7juZgX/CpclawYCfdTVYmkiNT4uB7d5+un1v0JG+hSDPcxDU6TLssHgQvpwFDuF4BPMS
         ojjMUnbWIYTGl9HRKJz4GUzYfP4zYNtZw4gtQQxwZgG6N/04d7ROxilIyH7ampnHuUGe
         sx0Y8rUiZakhfJK6oPpg1+5nSoKghT3gw1r9dln/nB+nKUWrgbBIKt1CoehFI1N6W5VN
         thKX8ynhfMHG6hMiElk3I3Nwrz29RV8NDaWCjaZ+2dHfFpzWsTLM7j3ISVRpHBRzfyp3
         HS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GCz8VghwWMAz9oUJUmO8qp9qmqaKvRvMgArRh6FY3ac=;
        b=XJhemgr8HJTzaOfURuHYzTbucFrwZOUeJS8f1jY6cRnM4dEnB6Jaq/i6Ap6seeCWc/
         eSN5Qt5PleBLRltvMircPFsuluI6MlRvFvjiL9Yzz746QhSghos2ORsw3NRfDelRiqTk
         agF9u/5fkEuDTSaWfzn52YeOiha1rK3Qv536sSzrJAL7a16KjrdKjrPg6OGy12gtjFK2
         ZO+eATX0WYFHrkXUuUbF51mU3sNXpCRMavR3lpRXqc7PmaiynVDpUzxpkS1DqXB2TtL5
         A7x7KeCBX4DWYdAyoLkhQq1NeoSh/uwy/JmM1kGS0dBqME6HnKmudyVvFyDVtuGbT5me
         KYIw==
X-Gm-Message-State: AOAM5321qipkK8GSATexpneTDzLle/pwXk1r1dBDTz8VU6ofqKVEK6TX
        Vsa8CtHwlZzyjFy6Pi2byLk=
X-Google-Smtp-Source: ABdhPJwpBgv4hD6yMX9o7sF/vge/a3oxktDKYc5FBQBn1gqlHY88Wy4G3xvRGzwTyjNHUwV7klaWsg==
X-Received: by 2002:ac2:5d2d:: with SMTP id i13mr3199029lfb.12.1628159466540;
        Thu, 05 Aug 2021 03:31:06 -0700 (PDT)
Received: from [192.168.2.145] (46-138-65-182.dynamic.spd-mgts.ru. [46.138.65.182])
        by smtp.googlemail.com with ESMTPSA id d18sm362104ljc.64.2021.08.05.03.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 03:31:06 -0700 (PDT)
Subject: Re: [PATCH v3] brcmfmac: firmware: Fix firmware loading
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20210805093023.3465081-1-linus.walleij@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9316a403-e755-3870-6393-62f20792af44@gmail.com>
Date:   Thu, 5 Aug 2021 13:31:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805093023.3465081-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

05.08.2021 12:30, Linus Walleij пишет:
> The patch that would first try the board-specific firmware
> had a bug because the fallback would not be called: the
> asynchronous interface is used meaning request_firmware_nowait()
> returns 0 immediately.
> 
> Harden the firmware loading like this:
> 
> - If we cannot build an alt_path (like if no board_type is
>   specified) just request the first firmware without any
>   suffix, like in the past.
> 
> - If the lookup of a board specific firmware fails, we get
>   a NULL fw in the async callback, so just try again without
>   the alt_path. Use a context state variable to check that
>   we do not try this indefinitely.
> 
> - Rename the brcm_fw_request_done to brcm_fw_request_done_first
>   reflecting the fact that this callback is only used for the
>   first (main) firmware file, and drop the unnecessary
>   prototype.
> 
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Stefan Hansson <newbyte@disroot.org>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Rename state variable to "tried_board_variant".
> ChangeLog v1->v2:
> - Instead of using a static variable, add a context variable
>   "tested_board_variant"
> - Collect Arend's review tag.
> - Collect Tested-by from Dmitry.
> ---

Combining my previous comments together, I rewrote it like this:

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
index adfdfc654b10..4198ca9d898c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -431,8 +431,6 @@ struct brcmf_fw {
 	void (*done)(struct device *dev, int err, struct brcmf_fw_request *req);
 };
 
-static void brcmf_fw_request_done(const struct firmware *fw, void *ctx);
-
 #ifdef CONFIG_EFI
 /* In some cases the EFI-var stored nvram contains "ccode=ALL" or "ccode=XV"
  * to specify "worldwide" compatible settings, but these 2 ccode-s do not work
@@ -658,6 +656,21 @@ static void brcmf_fw_request_done(const struct firmware *fw, void *ctx)
 	kfree(fwctx);
 }
 
+static void brcmf_fw_request_done_first(const struct firmware *fw, void *ctx)
+{
+	struct brcmf_fw *fwctx = ctx;
+	struct brcmf_fw_item *first = &fwctx->req->items[0];
+	int ret = 0;
+
+	if (!fw)
+		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
+					      fwctx->dev, GFP_KERNEL, fwctx,
+					      brcmf_fw_request_done);
+
+	if (fw || ret < 0)
+		brcmf_fw_request_done(fw, ctx);
+}
+
 static bool brcmf_fw_request_is_valid(struct brcmf_fw_request *req)
 {
 	struct brcmf_fw_item *item;
@@ -702,11 +715,9 @@ int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
 	if (alt_path) {
 		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
 					      fwctx->dev, GFP_KERNEL, fwctx,
-					      brcmf_fw_request_done);
+					      brcmf_fw_request_done_first);
 		kfree(alt_path);
-	}
-	/* Else try canonical path */
-	if (ret) {
+	} else {
 		ret = request_firmware_nowait(THIS_MODULE, true, first->path,
 					      fwctx->dev, GFP_KERNEL, fwctx,
 					      brcmf_fw_request_done);
-- 
