Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2632F8E34
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Jan 2021 18:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbhAPRTu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Jan 2021 12:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhAPRTs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Jan 2021 12:19:48 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A889C061573
        for <linux-wireless@vger.kernel.org>; Sat, 16 Jan 2021 09:19:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d22so2028821edy.1
        for <linux-wireless@vger.kernel.org>; Sat, 16 Jan 2021 09:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OIQ2hIw4MURTdf4mxNPiO/9JsHTiYR3gp94qggMm6fE=;
        b=EMFuAOkQM4SORJbYPAzHa7sPfUlm3xj02g/SSdYR2wjdLwFdm/A/N+qAG71Dezdces
         s7zpJDG3SikpIbdCkWylJP2jakKz9pi8DSYyp+2lpiWBcGD0fe7GWM7CI0PfepcOGQpX
         8X7mQsipkfKuuG1kGaMthCeXQ3iGOp6C84z88Wf2S4UFhC6qciybbkSKgsbV2M9ltlm/
         JR/CRABAYPPwzCAkMOrGNVL+MFRd+BDNXwduciweZaWYB21pkl8kNhR64rNzj1gacmby
         l2iJavzVnSLYjd5zW9YE1bpc92YPXUPJ/+6jhk+GZWUFSynTK7oElJnvE7otINUmzVQG
         ryLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OIQ2hIw4MURTdf4mxNPiO/9JsHTiYR3gp94qggMm6fE=;
        b=P+nY+039HCh7AAgjqGavek6XuuoNUM92jM/gRRZ3o19RRo4t79s+s30XBi3i+3hfNP
         OYFVS+J1bF3wqz2yEDHaB4y0inoTQxMrJPNAgFsapoYHV0osLPN9ldADNlPqSIBjF4c8
         Z+PUwLJjzgCaf/JljkLTlgM0l6jHPcJJSFQKtsshT859q+f+tnKNSJ25u+qZ3sOzcimM
         y02LyjOqvgCyIigjaJA2mVAiBCI4IrGbukofScMsDeTdugAeIG/uN1xdCPdOu48jzoti
         kXei8SWQTWzX6iCB1TmRP+ptTbvwpJPIUWzsle7Nxp3iZQFrrezf5pHSn8HxV5NdwRpW
         N0ug==
X-Gm-Message-State: AOAM532Vl2ph0Joe4WYT36E/ydfEMvM+8tpFGlwh9Ct/cH83cpBj9yli
        yBX5mFricxG/wQFIu2JFW2wcu1DGp94=
X-Google-Smtp-Source: ABdhPJy0njrkxKNMHQpX1MvEvPpmVD8Sf6bjycAbLJP1XLtNO7UOMvF8JC3Wfi5jQbepc4WvS5Kscw==
X-Received: by 2002:a05:6402:1286:: with SMTP id w6mr14305371edv.351.1610817547012;
        Sat, 16 Jan 2021 09:19:07 -0800 (PST)
Received: from [192.168.50.4] (iskon3635.duo.carnet.hr. [31.147.110.51])
        by smtp.gmail.com with UTF8SMTPSA id x6sm5163897ejw.69.2021.01.16.09.19.06
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 09:19:06 -0800 (PST)
From:   Davor Saric <davor.sharic@gmail.com>
Subject: [BUG] iwlwifi failed to load on boot, various kernels
To:     linux-wireless@vger.kernel.org
Message-ID: <76f8642b-f220-0427-62dc-0fdc6b7eefaf@gmail.com>
Date:   Sat, 16 Jan 2021 18:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hello,

I am on Arch linux with Kernel 5.4.85-1-lts. I have also tried recent
kernels and behaviour is the same. I have the issue that after boot
there is no wifi card initialized.
I have error in dmesg: iwlwifi: probe of 0000:06:00.0 failed with error -110

I have to reset it with following:

modprobe -r iwlwifi
echo 1 > /sys/bus/pci/devices/0000\:06\:00.0/reset
modprobe iwlwifi

I see that you mention that disabling Fast boot in windows 10 fixes the
problem. I did that but I do not have problem when doing a reboot from
windows 10 to arch linux. I have problem that when I turn of the PC
while I am in Arch linux and then turning it on tomorrow again and boot
to Arch Linux, my wifi card doesn't initialize.

On 44.415273 I have reset the wifi with above script:

dmesg|grep iwlwifi
  iwlwifi 0000:06:00.0: enabling device (0000 -> 0002)
  iwlwifi: probe of 0000:06:00.0 failed with error -110
reseted -> iwlwifi 0000:06:00.0: loaded firmware version
36.ad812ee0.0 op_mode iwlmvm
iwlwifi 0000:06:00.0: Detected Intel(R) Dual Band
Wireless AC 8265, REV=0x230
iwlwifi 0000:06:00.0: base HW address: f8:34:41:00:77:15
iwlwifi 0000:06:00.0 wlp6s0: renamed from wlan0

Do you have any idea what is the cause of it?

iw reg get
global
country HR: DFS-ETSI
           (2400 - 2483 @ 40), (N/A, 20), (N/A)
           (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
           (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
           (5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
           (5725 - 5875 @ 80), (N/A, 13), (N/A)
           (57000 - 66000 @ 2160), (N/A, 40), (N/A)

phy#0 (self-managed)
country CN: DFS-UNSET
           (2402 - 2437 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40MINUS,
NO-80MHZ, NO-160MHZ
           (2422 - 2462 @ 40), (6, 22), (N/A), AUTO-BW, NO-80MHZ, NO-160MHZ
           (2447 - 2482 @ 40), (6, 22), (N/A), AUTO-BW, NO-HT40PLUS,
NO-80MHZ, NO-160MHZ
           (5170 - 5190 @ 80), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW,
IR-CONCURRENT, NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5190 - 5210 @ 80), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW,
IR-CONCURRENT, NO-HT40PLUS, NO-160MHZ, PASSIVE-SCAN
           (5210 - 5230 @ 80), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW,
IR-CONCURRENT, NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5230 - 5250 @ 80), (6, 22), (N/A), NO-OUTDOOR, AUTO-BW,
IR-CONCURRENT, NO-HT40PLUS, NO-160MHZ, PASSIVE-SCAN
           (5250 - 5270 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5270 - 5290 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
           (5290 - 5310 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5310 - 5330 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
           (5490 - 5510 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5510 - 5530 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
           (5530 - 5550 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5550 - 5570 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
           (5570 - 5590 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5590 - 5610 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
           (5610 - 5630 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5630 - 5650 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
           (5650 - 5670 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5670 - 5690 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
           (5690 - 5710 @ 80), (6, 22), (0 ms), DFS, AUTO-BW,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5710 - 5730 @ 80), (6, 22), (0 ms), DFS, AUTO-BW, NO-HT40PLUS,
NO-160MHZ, PASSIVE-SCAN
           (5735 - 5755 @ 80), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5755 - 5775 @ 80), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
NO-HT40PLUS, NO-160MHZ, PASSIVE-SCAN
           (5775 - 5795 @ 80), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
NO-HT40MINUS, NO-160MHZ, PASSIVE-SCAN
           (5795 - 5815 @ 80), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
NO-HT40PLUS, NO-160MHZ, PASSIVE-SCAN
           (5815 - 5835 @ 20), (6, 22), (N/A), AUTO-BW, IR-CONCURRENT,
NO-HT40MINUS, NO-HT40PLUS, NO-80MHZ, NO-160MHZ, PASSIVE-SCAN

Regards,
Davor
