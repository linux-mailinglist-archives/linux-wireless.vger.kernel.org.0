Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452AC3E2E17
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Aug 2021 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhHFQA3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhHFQA3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 12:00:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6DCC0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Aug 2021 09:00:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o10so12612470ljp.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Aug 2021 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5b0P7iYyJ93cRi57r9b5KBbOkvxXhs8Ko3/VfhyHV20=;
        b=sOM3NyQ0SWkNz1Xy9uBogWFYFn3UpvYCY5Juwb6hzNLWP2ajsgrsJQSVCy/3QU/cvz
         2AcRzdvT/Did25OMI986fB+yvwSTLpFzIimH5YfI8ftLOF1SUjAmlGRs4TDzk9Vd3sV/
         DsR88jprCi0YhaoarUUUEolefcFfZC4YsOSLDkKibamglsPeVN94h+xaPbsTuOkP09vd
         V869pLPt83DAfIkmh635E9wpFP0qQ4MkD+Ct6LAiuyrHafMwOOrkGVCUehLVxdL4Va4i
         kK8sqgMt2Wa8oVIBHO8TGnQO9N3RdyVBaOBQERDbndvWl4Q2XDdtaBxPYRKsCukJ3H+B
         2HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5b0P7iYyJ93cRi57r9b5KBbOkvxXhs8Ko3/VfhyHV20=;
        b=U1wL7gcLYVk7byxhyUEKDfk8+klxyI0/m0LqPIkyNKS9bIQwd1+ao7aC9nmcXqdldn
         V0BvhENKltxe32E/OyfklExSyd+JqiGkRLIfAmv+OIiAW/+Tma4uTZmPEbpWCdJLjrKt
         BH9Ov44p3rccMx9hHy9w8DDpdXOAfeA28jnuan5CXQ1aJVWiJ0KD21sVPJfI6K3ur23H
         pR3kN5nnK6jdraZdQan7J0153Xrq04KxdrSNq9A1KAxE+0feck7b9T6V3sJdHMfkbVTA
         Oojac9gwl6xXv5IFJELeHHg+mnnhsKpTnFFezpddQxG3pAxC3Jd+tholWkhixCimFcZ/
         dZuw==
X-Gm-Message-State: AOAM533YX9avPyYQWBrEcMju9eHUIcek7XnuzwRKIcb90YHcHNv7gnJU
        pbCTtHLJs+CGFlFF1m70pGE=
X-Google-Smtp-Source: ABdhPJxcOiVBTB5C4vLwYaaykfXy+kHxSiDuMbripZjVDTx3cJKgjnEOh/+lj346F3z0KNnbSKx46g==
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr7084775ljp.269.1628265611463;
        Fri, 06 Aug 2021 09:00:11 -0700 (PDT)
Received: from [192.168.2.145] (46-138-20-31.dynamic.spd-mgts.ru. [46.138.20.31])
        by smtp.googlemail.com with ESMTPSA id v19sm870900lfg.134.2021.08.06.09.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 09:00:11 -0700 (PDT)
Subject: Re: [PATCH v3] brcmfmac: firmware: Fix firmware loading
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stefan Hansson <newbyte@disroot.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20210805093023.3465081-1-linus.walleij@linaro.org>
 <CAJ65rDx1ab8gBZRpnyp5kb__VVA+_Vy3VS-0xesYC_+VmEKchw@mail.gmail.com>
 <d8a1d349-91ee-9ab5-6706-91090082d7f4@gmail.com>
Message-ID: <c6a79cf0-699e-71e0-1c03-a8a1bccb0973@gmail.com>
Date:   Fri, 6 Aug 2021 19:00:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d8a1d349-91ee-9ab5-6706-91090082d7f4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

06.08.2021 18:45, Dmitry Osipenko пишет:
..
>> So here we could use the synchronous variant instead for the reason
>> explained earlier.
> 
> The blocking variant doesn't work as-is, it locks up the probe.
> 

Actually, the old code was kinda bugged already.

int brcmf_fw_get_firmwares(struct device *dev, struct brcmf_fw_request *req,
			   void (*fw_cb)(struct device *dev, int err,
					 struct brcmf_fw_request *req))
{
...
	ret = request_firmware_nowait(THIS_MODULE, true, first->path,
					fwctx->dev, GFP_KERNEL, fwctx,
					brcmf_fw_request_done);
	if (ret < 0)
		brcmf_fw_request_done(NULL, fwctx);

This brcmf_fw_request_done() causes the lockup if firmware request fails.

Recovered KMSG from pstore:

task kworker/1:3:158 bLocKed for moru uhan 61Seconds
...
(scludule_pregmpt_disabled) from [<c0a81ebf>] (__mutex_lock.consTprop.0+0x27f/0X4dcm
(__mutex_lock.constprou, ) froM [<c05c1p65>] (device_release_driver+0x15/0x28i
)device_release_driver) drom [<c06vatf9>] (bRcmd_sdio_firmwAre_callback+0z3/0x76c)
(brcmf_sdio_firmware_callback) dpom [<c0664ccb>]!(brcmf_dw_get_firmwares+0xv7/0x160)
(brcmf_fw_get_girmWares) from [<c066cced>] (brgmf_Sdio_probu+0x479?0x668)
(brcmf_sdin_probe) from [<c044e1bf>] (�rcmf_sdioe_probe+0xeb/pxq80)
(bzcmf_sdIod_Probu) from [<c046e3w?>] (brcmf_ops_Sdio_probe+0x8f/0xe8)
(brcmf_oPs_seio_probe) fRom [<c 7s505>] (sdio_bus_probe+1x9d/0z124)
(Sdig_bus_probe)from [<c15c123d>] (really[pRobe.parT&0+0y69/px200)
(peally_trobe.part.0-$from [<a05c144u>] ,W_dRiver_probe_device+0x73/0xd4)
...
