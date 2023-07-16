Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A548755032
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jul 2023 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGPSCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jul 2023 14:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPSCD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jul 2023 14:02:03 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F8E183
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 11:02:02 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1ba4460f0a4so1383033fac.0
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jul 2023 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689530521; x=1692122521;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hveRhlHKLVhBofa0icj6Nh/dnnkswxKpp5UZkIZAyU0=;
        b=Izz4wfJCfHFBkvAIrt+sQaWCvlI4gy2YUEwIxqU736scZScjtlRmTU2Qcz8c2jKRo3
         3bmQBXOi536M/8uKoSSNPbiahZhtUi3pehAWj2p102iaMyxpIpTwRofy+fmwGDoXqy6F
         mCxkWHOiqf0DRYakauCwzJ/efPQokFAfKd/7KXXfLsr9rCUmnTfJFb+sn9hte0CtRonm
         11V5S/Q+r1KCbn3cbyysejfM7H2aBzhMYI/s5aMVeyM1fZyTpWJmCHQD9vkkEAWaeY+u
         Pq7cVm9qysr57rD1yFRN8mrULSQKfMUyfNs0CGVTyPFUKce5WMfkU67xgGjCn6+5NgDD
         knQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689530521; x=1692122521;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hveRhlHKLVhBofa0icj6Nh/dnnkswxKpp5UZkIZAyU0=;
        b=TX6j6kVaDv9TomQuVy1F5+EhzIjCZWFXe7twVnLRfbkLzbZZyxbArztezcef4bndpV
         WSCsALp6j2KxDLILJWSAvMvt/ALhcQxw/QRqd7o2SL7O+hLCF2wutDicx3H7YMwekOj+
         mdWBTpFBMLnie/ytL5vpJwIkXAR8y8XyubfRNkQeFNIvMD1T/H8nSbR7adW14O3zn0ow
         PnSBA1lJnnc3KLL1/OMCP+TuPuU8JazxddJhY5LEqAegYyzdMNASpqTBMJx3sf8DHGGy
         h20y3ehwmBuq8TxjlXWzdd0zShRBdJkKYT2JjnYNvxNbJACC0XcC7wFt7REXm6ERpMOn
         KuDg==
X-Gm-Message-State: ABy/qLY5t02xjjz5Sdu3K9upWucvBCPxIw+zB0+4Unn7uk0bMvHgJt2L
        uxp5HbIBZGEyNcWmDBWZ+kIFC1vQVYY=
X-Google-Smtp-Source: APBJJlG3MJlJHuLPmrx4kp7xR234Asd+99BPR/5JXHWNSI+vut5zx2Pfx/TgGR/5U1+2F+c0K381JA==
X-Received: by 2002:a05:6870:960d:b0:1b0:3a8c:a807 with SMTP id d13-20020a056870960d00b001b03a8ca807mr11328059oaq.14.1689530520744;
        Sun, 16 Jul 2023 11:02:00 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870c38400b001b36699bd5fsm6315601oao.35.2023.07.16.11.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 11:02:00 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <09b6e6ab-5db4-ceb6-3590-f1a729f234d5@lwfinger.net>
Date:   Sun, 16 Jul 2023 13:01:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] RTW88 firmware download issues - improvement, but not
 perfect
To:     Sean Mollet <sean@malmoset.com>, linux-wireless@vger.kernel.org
References: <491EE697-0DFE-433A-97EA-F7D40E9FE0A5@malmoset.com>
Content-Language: en-US
In-Reply-To: <491EE697-0DFE-433A-97EA-F7D40E9FE0A5@malmoset.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/15/23 08:23, Sean Mollet wrote:
> I’m attempting to debug intermittent firmware download issues that occur with rtw88 on an RTL8821CU. I did not have these problems with the Realtek OOT driver (using morrownr’s version).
> 
> Based on GitHub issues I’ve found, this same problem seems to also occasionally occur with other chips in the family, including PCI-E ones.
> 
> Example dmesg including some telemetry I added to narrow down the issue:
> 
> [   28.486954] rtx88: Loading firmware rtw88/rtw8821c_fw.bin
> [   28.492907] rtw_8821cu 1-1.5:1.0: Firmware version 24.11.0, H2C version 12
> [   28.988012] check_hw_ready failed
> [   28.991624] rtx_88 failed in download_firmware_validate
> [   28.998626] rtw_8821cu 1-1.5:1.0: failed to download firmware
> [   29.012373] rtw_8821cu 1-1.5:1.0: failed to setup chip efuse info
> [   29.018749] rtw_8821cu 1-1.5:1.0: failed to setup chip information
> [   29.029496] rtw_8821cu: probe of 1-1.5:1.0 failed with error -22
> 
> It’s failing in mac.c, in the call to download_firmware_validate. The register contains 0x4078 instead of the 0xC078 that is usually present after a download.
> 
> Comparing this to the OOT driver, I noticed that the order of operations at the end of the process is different. In rtw88, lte_coe_backup is restored before checking the register. In the OOT,  it’s done after. Another difference is that the check loop in OOT has a much larger count and a larger delay. I applied both of these changes to rtw88 and the failure rate decreased significantly. It is still non 0.
> 
> I happen to have a nearly ideal test lab for exploring this problem in that I’ve got a factory full of embedded systems with the RTL8821CU chip attached to an automated boot/provisioning system. I can make a change and deploy+test on 10s or even hundreds of devices in a few minutes.
> 
> I don’t have chip documentation, so I’m shooting in a dark a bit here. My suspicion is that this is a race condition either in the rtw88 driver or in the hardware or the interaction between the two. It also seems to be exacerbated by high IO on the host CPU during driver loading. I’m further exploring the differences between the OOT driver and rtw88’s handling of firmware download, since I’ve never seen this happen with the OOT driver.
> 
> References:
> 
> https://github.com/morrownr/8821cu-20210916/blob/main/hal/halmac/halmac_88xx/halmac_fw_88xx.c
> Line 205 restores the lte_coe_backup. The equivalent of the check in download_firmware_validate happens inside the call to flfw_end_flow_88xx on line 201, the opposite order compared to what
> Line 666 sets the check loop, equivalent to rtw88's download_firmware_validate function to 5000 cycles and the delay used is 50 uS on line 678.
> 

Patches for the rtlwifi, rtw88, and rtw89 drivers should be addressed to Ping-Ke 
Shih <pkshih@realtek.com>. Any patch for a driver in drivers/net/wireless/... 
should be sent to Kalle Valo <kvalo@kernel.org>. Cc linux-wireless.

The subject line should be "wifi: rtw88: ......"

There is no signed-off-by tag. This is essential.

This commit message is not appropriate. There is too much detail on how the 
sausage was made. It should state what the problem is, and a little about what 
was done to fix it.

Your first reference is to the vendor driver, which is a totally different 
beast. I would say no more than "The vendor driver was consulted for ideas." If 
a specific change was made based on the vendor driver, then describe it.

When fixing a bug, you need to add a Fixes tag. See 
Documentation/process/submitting-patches.rst in your kernel source free for 
instructions. You should also include "fixes" in the subject, and likely add a 
Cc for stable@vger.kernel.org. That will ensure that the fix is propagated to 
stable kernels.

Your mailer sent HTML mail. For patches, it must be plain test. In addition, 
your mailer line wrapped a couple of lines, and the tabs at the start of lines 
got changed to spaces. It took a lot of work to get the patches to apply to my 
rtw88 repo.

> diff --git a/mac.c b/mac.c
> index 298663b..d595711 100644
> --- a/mac.c
> +++ b/mac.c

These files are not found in the kernel source tree. You are confusing the rtw88 
files with the kernel source. Any wifi patches should be based on the current 
wireless-next tree at 
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git. 
Repository rtw88 is fed from wireless-next, not the other way around.

> @@ -794,15 +794,15 @@ static int __rtw_download_firmware(struct rtw_dev *rtwdev,
> 
>          wlan_cpu_enable(rtwdev, true);
> 
> -       if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
> -               ret = -EBUSY;
> -               goto dlfw_fail;
> -       }
> -
>          ret = download_firmware_validate(rtwdev);
>          if (ret)
>                  goto dlfw_fail;
> 
> +       if (!ltecoex_reg_write(rtwdev, 0x38, ltecoex_bckp)) {
> +               ret = -EBUSY;
> +               goto dlfw_fail;
> +       }
> +
>          /* reset desc and index */
>          rtw_hci_setup(rtwdev);
> 
> diff --git a/util.c b/util.c
> index ff3c269..fbd6599 100644
> --- a/util.c
> +++ b/util.c
> @@ -10,11 +10,11 @@ bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target)
>   {
>          u32 cnt;
> 
> -       for (cnt = 0; cnt < 1000; cnt++) {
> +       for (cnt = 0; cnt < 5000; cnt++) {
>                  if (rtw_read32_mask(rtwdev, addr, mask) == target)
>                          return true;
> 
> -               udelay(10);
> +               udelay(50);

You have increased the maximum stall time from 10 msec to 250 msec. Do you 
really need to lock up a CPU for that long? This is a place where you should 
document how long it actually takes, if it really is more than 10 msec. On my 
rtw8821ce card, the longest it took was 6.25 msec. The USB device will likely 
take longer, but I would be interested in your worst case. FYI, I changed 
check_hw_ready() to read

                 for (cnt = 0; cnt < 5000; cnt++) {
                         if (rtw_read32_mask(rtwdev, addr, mask) == target) {
                                 if (cnt > 50)
                                         pr_info("hw_ready at count %d\n", cnt);
                         return true;
                 }

                 udelay(50);
         }



>          }
> 
>          return false;
> --

Thanks for working on this problem. I hope we can get the submitted patch into 
good shape.

Larry

