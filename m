Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042213E5D80
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 16:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhHJOVK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbhHJOSP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 10:18:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCF7C0617A3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Aug 2021 07:15:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y34so11846840lfa.8
        for <linux-wireless@vger.kernel.org>; Tue, 10 Aug 2021 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a4oFtEVPbza7qQQMxbXRmKEMuNSffRzIRThdUynQb7g=;
        b=Vm2BGOHITzkJrZyZ9XOmry/vNcru8xQMy4t9xn/lJBEiuvmtD8GVPihfX23Trq4NaA
         gXu/YRYPZddpVtchnpErco0ZF9Vra5yDa22/WJ0yl7Sj+ysUm6eHYH5+ZDi6cNsdtqSi
         CT+IAgtbipvnJ8WtuQH/ip8hVWYJhIw0EQd59FNmDLvV1CjAqnKtG7jN/LWVl6b8FrdD
         m4gSY02fS0enDMwh+9NKD0rMyh4w6sHis3wThfFwoINJg18BAGvXz+PshXhaCZ2TBQt2
         hThHLCy05hmqKXW+QzH2sfgz76VxaFi7MF1yHdN5M3a3+fNRb4saWHjAUCGEJZSfTyHd
         pmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a4oFtEVPbza7qQQMxbXRmKEMuNSffRzIRThdUynQb7g=;
        b=clWiwGd+al9GFHb4rblCm6E+zCrsf+UYslIAuENpS9rY49QE47BTuvQYlLvZMEm/+o
         GMc6D1RRRXqO1/ZmmibJ6Yr82/mPO+5qsLr811WqQEXqn5YXY6vVi+LeisEZTR6GexdR
         hxgy0G3DQY+tx5WKjjyxyirrXkFPNAkX25kDhjZHKoXh74pZ5PMCj78obLCMrrI9TgRN
         sLO3eDuoSid9NA5dcRbU97Hk2Z3Xq4jB96jEpvgxsVMT+SlZmHagfJmE39DV7qL1SKtV
         fsOQ3zS+RSiCz2wlUiP6a+vnUz/U2923fBUEKseYyTmuCUQSVB2NYDa31x5JR+SR4pTK
         T1Yg==
X-Gm-Message-State: AOAM533/rehC/CmCJ2/FAXsS5oW9cplOD511aR1yZwpC50RbKXZIsbrN
        uDPVYFXZhlgFC26+rLmRZEA=
X-Google-Smtp-Source: ABdhPJwfFw96LVzL/wJnhYf4mcCw4chIbADGCMFm/h8vTM1YKXRe5frdkqaUwealgFN0XvEquOt58g==
X-Received: by 2002:ac2:55a6:: with SMTP id y6mr1248989lfg.65.1628604953613;
        Tue, 10 Aug 2021 07:15:53 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id s1sm161303lfp.77.2021.08.10.07.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 07:15:53 -0700 (PDT)
Subject: Re: [PATCH v5] brcmfmac: firmware: Fix firmware loading
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210808180510.8753-1-digetx@gmail.com>
Message-ID: <8be6341b-8f18-c46e-dab5-b2ce0e9be3ee@gmail.com>
Date:   Tue, 10 Aug 2021 17:15:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210808180510.8753-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

08.08.2021 21:05, Dmitry Osipenko пишет:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
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
>   the alt_path from a dedicated brcm_fw_request_done_alt_path
>   callback.
> 
> - Drop the unnecessary prototype of brcm_fw_request_done.
> 
> - Added MODULE_FIRMWARE match for per-board SDIO bins, making
>   userspace tools to pull all the relevant firmware files.
> 
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Cc: Stefan Hansson <newbyte@disroot.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Kalle, please apply it with this tag. Thanks!

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
