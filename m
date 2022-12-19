Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C0B6510D0
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 17:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiLSQ6c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 11:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiLSQ6a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 11:58:30 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DDA1149
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 08:58:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p36so14544066lfa.12
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfgA94o+L+JwjyMViM+dmuBfOj+sR9+fodgHjNCDPIc=;
        b=XDka8hwiCmIKbWq5boFWICWXRCSKzosi6lL8keuCg9VWNfPQvwFGBLMgmFufwRSoUy
         AFAFg9yiaXdmTaVEi7JhxCCASNlMEINY0AIOffjsoaJGp56adNMHg1zV30nbOUaEJdWo
         WDB799peblpbl/lafk2nSwz0jPhIhdtpN8LnM19IYwbebLaYNyasaNcYJU0/PPR6543i
         yU+w9UuYVxWMFs8S6hYrNqfCzxojTwdANPcK2hN2UfF59DjJfIbo3WDhdM5L7U7NqvUf
         KeLgj/ffdpwZFkUJRACvhM+fteSA8xW3Eq7hBBTSo5Xn7nACdm/mWMNDap3QDLw0OVOO
         G4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfgA94o+L+JwjyMViM+dmuBfOj+sR9+fodgHjNCDPIc=;
        b=r5kqMJR7LFDt54f2fCVlX0VTZ7wtn9kPOqCA2+gJ46t6lbH68z/4ONr0RcBabWGTR+
         GVVhQJnlKqXWB/bEHX2zEspVX2RGNAoybGZhpRxZj2LEFj+8Ir3rjK4nQJ5C3S22y0Ps
         Fkyiwl2SEoqaY0gK7Gy0aTwgKHgbojc/cWh6CZwASF9fguych1IW/HK4+srWn+6LlZ0c
         nKCcp4AqCx4u5fjzKNLr5w0mOsHRYHlxK2lzuwwEmig5l83g/5FbJNTLL6R8scLIIyui
         Ow8X5SORdFMSHmIXa0igiTfzP2q4TVX8VLRFWiZRwCAvWGDxSMlL6ujgILLqW0C4BVZV
         Uomw==
X-Gm-Message-State: ANoB5pk19Mkd4PUXFsJHGL8nBGEO6rnGcZUslF+HyHqCSyl7z/cMGWj3
        56cZndNkmFbmkAIwsy36KCA=
X-Google-Smtp-Source: AA0mqf7ih3veFH79UTf8fW7NHTFJRcjsag3lqu4MD9/wldbwzcgyHoNDfaJJwaSpnNzLaxXZXaatOg==
X-Received: by 2002:a05:6512:2a8f:b0:4aa:8811:4c59 with SMTP id dt15-20020a0565122a8f00b004aa88114c59mr13176126lfb.28.1671469108359;
        Mon, 19 Dec 2022 08:58:28 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id 7-20020ac25f47000000b004aac23e0dd6sm1152531lfz.29.2022.12.19.08.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 08:58:27 -0800 (PST)
Message-ID: <812120ff-2fcd-e05e-7748-6a731e782811@gmail.com>
Date:   Mon, 19 Dec 2022 19:58:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/8] brcm: update bcm4329 firmware file
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com, linux-firmware@kernel.org
References: <20221207230556.383935-1-arend.vanspriel@broadcom.com>
 <20221207230556.383935-3-arend.vanspriel@broadcom.com>
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20221207230556.383935-3-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

08.12.2022 02:05, Arend van Spriel пишет:
> bump version from 4.220.48.0 to 4.218.248.44. Version numbering
> scheme is obscure but this is a more recent firmware file.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  brcm/brcmfmac4329-sdio.bin | Bin 253748 -> 246791 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)

This firmware version doesn't work on any of NVIDIA Tegra tablets
supported by upstream kernel, tested using next-20221216. Please revert
or fix, thanks!

Faulty 4.218.248.44 kernel log:

brcmfmac: brcmf_wcc_attach: executing
brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2),
device may have limited channels available
brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4329/3 wl0: May 25 2012
17:57:45 version 4.218.248.44
ieee80211 phy0: brcmf_c_set_joinpref_default: Set join_pref error (-52)
ieee80211 phy0: brcmf_setup_wiphybands: rxchain unsupported
ieee80211 phy0: brcmf_construct_chaninfo: get chanspecs error (-52)
ieee80211 phy0: brcmf_setup_wiphybands: brcmf_construct_chaninfo failed
(-52)
ieee80211 phy0: brcmf_cfg80211_attach: Setting wiphy bands failed (-52)
ieee80211 phy0: brcmf_bus_started: failed: -12
ieee80211 phy0: brcmf_attach: dongle is not responding: err=-12
brcmfmac: brcmf_wcc_detach: executing
brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed

Good 4.220.48.0 kernel log:

brcmfmac: brcmf_wcc_attach: executing
brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2),
device may have limited channels available
brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4329/3 wl0: Sep  2 2011
14:48:19 version 4.220.48
ieee80211 phy0: brcmf_setup_wiphybands: rxchain unsupported
