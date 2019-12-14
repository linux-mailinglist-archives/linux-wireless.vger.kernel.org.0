Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0257B11F3A2
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2019 20:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLNTT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Dec 2019 14:19:58 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:45623 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfLNTT5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Dec 2019 14:19:57 -0500
Received: by mail-lj1-f175.google.com with SMTP id d20so2360506ljc.12
        for <linux-wireless@vger.kernel.org>; Sat, 14 Dec 2019 11:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yS8XqeE3iEBTCbi74fmw1F28QSTY+PLpAeY3MYKmO4c=;
        b=rtukWSfQFNKQhVy4gGv3x22FGysi0Dw1gPuMkDhmxZh3A6mVRJMxcErSFa4E69AKyy
         rDpD9D9Cj8e30WsecHiLBQl8hfDKCVP5NyO8/wvbOKRM96ux6f0i4hMy5g6khIQxo9H6
         U/dyoMxrkGnTjRw0v1dmd9OFmEy0JVEXwD8UJ92NWy+x4HKoJwgd3Z155Ll1c1GpfI6j
         1Da6rQL3mnmetj7j/odais7rIxAp0oftDyaoqljHlrr1qIT9AbYY4S36sga3+9C+2I5a
         ipb4lGmEf/HCcDCV+7Vdz4QFasAicPAzTFWsErrKXHkopPT3MLU8ogmUJwD7rqiyt8Cm
         Do9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yS8XqeE3iEBTCbi74fmw1F28QSTY+PLpAeY3MYKmO4c=;
        b=r0YKucrewlcPs5MqtiOS9LuGVKgnDlnkLIp4/2nZpmg6NxzWhpFkHSjdk9D99ZFgZx
         hioYOZEIo5lcbdQNWmZ6d5hUb0ztkYuKN3LBnPC9oSWlRuHb/uKfd0beSZZYtKXSIB41
         d3qWWoAuk6KpNKPMbEQKDySq0/wKIqSQj+1EXb9/Xi2MbxwJkn4d54u8l+J3DmAO7cic
         nwau8sfqSegHtuOZ1i/vcCq2j5GvfNbgO4oSURlpWHLYWndaTU+tgEKdln7lasN73IR1
         hzcRcUP5Q42hvb+WY4FBmzNnyv1SlfmKsrXTa9rKqxKsYG7Fd01aL6DmilMqfMhV76DH
         11MQ==
X-Gm-Message-State: APjAAAUe5b7XIP5X8tZkt6D3+MQGyRnRRheL84f/PRRg3lyEiX2+Nlp0
        VWS1StXKjmVoarSYa7uT1Hwvh5nJc3mcQo2UCdgQ3LPSLYs=
X-Google-Smtp-Source: APXvYqy8lnPhnHCliTy3b8mrOHDTlZSYpdQVReggi9V7JA19mgzMHJrfCfXsEiPF0/ylGFRb9yz0nnrsrnss5o8395c=
X-Received: by 2002:a2e:241a:: with SMTP id k26mr13698486ljk.26.1576351194353;
 Sat, 14 Dec 2019 11:19:54 -0800 (PST)
MIME-Version: 1.0
From:   Joshua Kwan <joshua.m.kwan@gmail.com>
Date:   Sat, 14 Dec 2019 14:19:43 -0500
Message-ID: <CAGiaAZUyOgx=jyohEaeOizKswMSdeHCipLu0YuDHnFxXboR7QA@mail.gmail.com>
Subject: Can't load iwlwifi (8086:02f0) on 5.5-rc1, works on 5.3.0-24-generic (Ubuntu)
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

I recently upgraded to 5.5-rc1 built from the Ubuntu Kernel PPA (which
I understand to be fairly unpatched/unmodified compared to pristine
upstream) in order to fix my sound. While the sound now works, sadly,
in the upgrade I lost the ability to load my iwlwifi module!

Hardware is a Thinkpad X1 Carbon 7th Generation. The PCI ID of my
wireless adapter is 8086:02f0. On 5.3.0-24-generic (vendor kernel),
this is what dmesg | grep iwlwifi prints as a reference:

[    7.791908] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    7.804163] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ
Version: 43.2.23.17
[    7.804392] iwlwifi 0000:00:14.3: loaded firmware version
48.4fa0041f.0 op_mode iwlmvm
[    7.860649] iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC
9560 160MHz, REV=0x354
[    8.006416] iwlwifi 0000:00:14.3: base HW address: 4c:1d:96:a0:c5:30
[    8.023767] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0

On 5.5-rc1 (which fails):

[    8.140324] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    8.150945] iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-Qu-b0-jf-b0-52.ucode failed with error -2
[    8.150975] iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-Qu-b0-jf-b0-51.ucode failed with error -2
[    8.151116] iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-Qu-b0-jf-b0-50.ucode failed with error -2
[    8.151141] iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-Qu-b0-jf-b0-49.ucode failed with error -2
[    8.155520] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ
Version: 43.2.23.17
[    8.155725] iwlwifi 0000:00:14.3: loaded firmware version
48.4fa0041f.0 op_mode iwlmvm
[    8.240468] iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC
9560 160MHz, REV=0x354
[    9.272022] iwlwifi 0000:00:14.3: Collecting data: trigger 15 fired.
[    9.272102] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[    9.272105] iwlwifi 0000:00:14.3: Status: 0x00000000, count: 42564272
[    9.272107] iwlwifi 0000:00:14.3: Loaded firmware version: 48.4fa0041f.0
[    9.272109] iwlwifi 0000:00:14.3: 0x9DC25054 | ADVANCED_SYSASSERT
[    9.272111] iwlwifi 0000:00:14.3: 0x9ABFE4CE | trm_hw_status0
[    9.272112] iwlwifi 0000:00:14.3: 0xBF62E9F5 | trm_hw_status1
[    9.272114] iwlwifi 0000:00:14.3: 0x3C4E0EF1 | branchlink2
[    9.272115] iwlwifi 0000:00:14.3: 0xA62A1DFF | interruptlink1
[    9.272117] iwlwifi 0000:00:14.3: 0xFDEBB789 | interruptlink2
[    9.272118] iwlwifi 0000:00:14.3: 0x5E33DFE0 | data1
[    9.272119] iwlwifi 0000:00:14.3: 0x5FD237F8 | data2
[    9.272121] iwlwifi 0000:00:14.3: 0xA3F2C470 | data3
[    9.272122] iwlwifi 0000:00:14.3: 0xBFD1BC6E | beacon time
[    9.272124] iwlwifi 0000:00:14.3: 0xF5B7610B | tsf low
[    9.272125] iwlwifi 0000:00:14.3: 0xDEAFACD3 | tsf hi
[    9.272126] iwlwifi 0000:00:14.3: 0x7AE1B300 | time gp1
[    9.272128] iwlwifi 0000:00:14.3: 0x87253BC5 | time gp2
[    9.272129] iwlwifi 0000:00:14.3: 0xA2837B4D | uCode revision type
[    9.272131] iwlwifi 0000:00:14.3: 0x8E36CD8C | uCode version major
[    9.272132] iwlwifi 0000:00:14.3: 0x6281C883 | uCode version minor
[    9.272134] iwlwifi 0000:00:14.3: 0xF8DE3096 | hw version
[    9.272135] iwlwifi 0000:00:14.3: 0xC07D59B9 | board version
[    9.272136] iwlwifi 0000:00:14.3: 0x2B71FB5C | hcmd
[    9.272138] iwlwifi 0000:00:14.3: 0x4670B088 | isr0
[    9.272139] iwlwifi 0000:00:14.3: 0x00C2F402 | isr1
[    9.272140] iwlwifi 0000:00:14.3: 0x9C939489 | isr2
[    9.272142] iwlwifi 0000:00:14.3: 0x116CE4CE | isr3
[    9.272143] iwlwifi 0000:00:14.3: 0xB26C65D1 | isr4
[    9.272145] iwlwifi 0000:00:14.3: 0xFDAC8241 | last cmd Id
[    9.272146] iwlwifi 0000:00:14.3: 0x0F74E449 | wait_event
[    9.272148] iwlwifi 0000:00:14.3: 0x6ED578B5 | l2p_control
[    9.272149] iwlwifi 0000:00:14.3: 0x02F9334E | l2p_duration
[    9.272150] iwlwifi 0000:00:14.3: 0x0BA78446 | l2p_mhvalid
[    9.272152] iwlwifi 0000:00:14.3: 0x87B815C5 | l2p_addr_match
[    9.272153] iwlwifi 0000:00:14.3: 0xEFD34063 | lmpm_pmg_sel
[    9.272154] iwlwifi 0000:00:14.3: 0x1DFFA239 | timestamp
[    9.272156] iwlwifi 0000:00:14.3: 0x61610219 | flow_handler
[    9.272192] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[    9.272194] iwlwifi 0000:00:14.3: Status: 0x00000000, count: 7
[    9.272196] iwlwifi 0000:00:14.3: 0x201013F1 | ADVANCED_SYSASSERT
[    9.272197] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[    9.272199] iwlwifi 0000:00:14.3: 0xC008CF5C | umac branchlink2
[    9.272200] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink1
[    9.272201] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[    9.272203] iwlwifi 0000:00:14.3: 0x00000003 | umac data1
[    9.272204] iwlwifi 0000:00:14.3: 0x20000302 | umac data2
[    9.272206] iwlwifi 0000:00:14.3: 0x01300202 | umac data3
[    9.272207] iwlwifi 0000:00:14.3: 0x00000030 | umac major
[    9.272209] iwlwifi 0000:00:14.3: 0x4FA0041F | umac minor
[    9.272210] iwlwifi 0000:00:14.3: 0x00005D08 | frame pointer
[    9.272212] iwlwifi 0000:00:14.3: 0xC0887F58 | stack pointer
[    9.272213] iwlwifi 0000:00:14.3: 0x00000000 | last host cmd
[    9.272215] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[    9.272229] iwlwifi 0000:00:14.3: Fseq Registers:
[    9.272232] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_ERROR_CODE
[    9.272236] iwlwifi 0000:00:14.3: 0x00000000 | FSEQ_TOP_INIT_VERSION
[    9.272239] iwlwifi 0000:00:14.3: 0xDCDA1061 | FSEQ_CNVIO_INIT_VERSION
[    9.272242] iwlwifi 0000:00:14.3: 0x0000A384 | FSEQ_OTP_VERSION
[    9.272245] iwlwifi 0000:00:14.3: 0x5EE79C84 | FSEQ_TOP_CONTENT_VERSION
[    9.272248] iwlwifi 0000:00:14.3: 0x9E5D2851 | FSEQ_ALIVE_TOKEN
[    9.272252] iwlwifi 0000:00:14.3: 0x8DD48FB2 | FSEQ_CNVI_ID
[    9.272255] iwlwifi 0000:00:14.3: 0x2617CF5E | FSEQ_CNVR_ID
[    9.272258] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[    9.272263] iwlwifi 0000:00:14.3: 0x01300202 | CNVR_AUX_MISC_CHIP
[    9.272269] iwlwifi 0000:00:14.3: 0x0000485B |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[    9.272320] iwlwifi 0000:00:14.3: 0xA5A5A5A2 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[    9.272354] iwlwifi 0000:00:14.3: SecBoot CPU1 Status: 0x5c78, CPU2
Status: 0x3
[    9.272355] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
[    9.272359] iwlwifi 0000:00:14.3: Firmware not running - cannot dump error
[    9.284071] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110

I have not tried with a pristine upstream kernel near 5.3.0 yet, I can
do so especally if you can point me to any specific version to help
with potential bisecting. I'm happy to jump on IRC for a debug session
if anyone would like that, I can also keep going via email. Let me
know and thanks!

-Josh
