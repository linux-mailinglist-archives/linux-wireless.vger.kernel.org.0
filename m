Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB536BB76B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 16:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjCOPS3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjCOPS2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 11:18:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A806869F
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 08:18:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd5so43058112edb.7
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678893504;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfZHzj/wsQclFWTf+DL3DeRG3j8CkEJI7j1SZfPWfxQ=;
        b=cm2E9gYTDzsHFHSYCIwBLopwkiXXSV7r7BgeNw6sjaiGofS36DenYzsIQjwi7rExz9
         iwq2ixicFjvs+0iwPdsURdk6QrsRegt3HZ7jDcDKT3CJqb9SxDuik65vZJegDxpRuG8X
         aKIt6TmbtgNa5XCZuVigNPjdw05SjB8ECinFgJBiMDpvDVbvoOjNk2xrRSs5nODDO3w9
         59AKUpjfpueBz2/gw7d99N7PR9/wvNN2LZs2yQ4mN00Wnimbsyf9i/K1lVjKYDDfpa03
         KWqh0iyW/4O07icOmVLDBEoL514fwvAaCFK6WOHBbcb0Pc9yC5vqbleustWMq0lsU6eR
         8HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893504;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TfZHzj/wsQclFWTf+DL3DeRG3j8CkEJI7j1SZfPWfxQ=;
        b=6Yr+U6b/zwtONNMlwF8U3Kjb9TCq4nEpxTt9IGBdZsmzuzjfzSgsD9gi2ke1l6NM7Y
         BjF/Z+JfEo/GC+ZsmzasgpbQUnt6CbXsAyg0SWiRdniCxUd7XhUtmWR9eL0ja+a4ezBB
         ylI6gNmbWSpfo2IRXPA80rc3/navq69EoNLbXcwnUhuEhkHWNkjvxP8rBfQuyxBM8ViG
         oqRsAcz0Kzd8xB2XFZ3vV0rv8ksbZhe7HcJ34vEaxb8U3pyUZSzy4dx8WBFbqqHSUX07
         NVSZ0AesFZ2Tz0BcNNQgPb6HkgxVJxblZu41EZjMyKJiZO/GuOez2O1EnS2rUIiPK3SB
         9zZg==
X-Gm-Message-State: AO0yUKXUlJ5YlOu/caCwXfWBZ3ItLhx+fO0S7a4z2v/p1VgiUBuwDPHX
        H8Ir3HkyvFH9pI3nHJY7GuTA2T1137c=
X-Google-Smtp-Source: AK7set8odPzwLqHeg/krRTag2E48Ng/0JfrAMEIIwxn9D3xNIHQzFnFFeJy7GZMLvnMtAtfnM+oQSQ==
X-Received: by 2002:aa7:d90c:0:b0:4fd:20ee:225d with SMTP id a12-20020aa7d90c000000b004fd20ee225dmr3001420edr.24.1678893503599;
        Wed, 15 Mar 2023 08:18:23 -0700 (PDT)
Received: from [10.22.80.110] ([147.231.236.32])
        by smtp.gmail.com with ESMTPSA id q11-20020a5085cb000000b004bd6e3ed196sm2557586edh.86.2023.03.15.08.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:18:23 -0700 (PDT)
Message-ID: <d42ceed7-7d2b-e6a5-ab1c-98a49bd3dd2c@gmail.com>
Date:   Wed, 15 Mar 2023 16:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     gregory.greenman@intel.com, linux-wireless@vger.kernel.org
From:   =?UTF-8?Q?Martin_MOKREJ=c5=a0?= <mmokrejs@gmail.com>
Subject: linux-6.1.12: Error sending SCAN_CFG_CMD: time out after 2000ms.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
   while fetching a few GB over iwlwifi I crashed the network card:

[    5.053666] Intel(R) Wireless WiFi driver for Linux
[    5.054087] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[    5.057853] firmware_class:__allocate_fw_priv: firmware_class: __allocate_fw_priv: fw-iwlwifi-8265-36.ucode fw_priv=(____ptrval____)
[    5.057868] firmware_class:fw_get_filesystem_firmware: iwlwifi 0000:01:00.0: loading /lib/firmware/updates/6.1.12/iwlwifi-8265-36.ucode failed for no such file or directory.
[    5.057873] firmware_class:fw_get_filesystem_firmware: iwlwifi 0000:01:00.0: loading /lib/firmware/updates/iwlwifi-8265-36.ucode failed for no such file or directory.
[    5.057878] firmware_class:fw_get_filesystem_firmware: iwlwifi 0000:01:00.0: loading /lib/firmware/6.1.12/iwlwifi-8265-36.ucode failed for no such file or directory.
[    5.058278] firmware_class:fw_get_filesystem_firmware: iwlwifi 0000:01:00.0: Loading firmware from /lib/firmware/iwlwifi-8265-36.ucode
[    5.058281] firmware_class:fw_get_filesystem_firmware: iwlwifi 0000:01:00.0: direct-loading iwlwifi-8265-36.ucode
[    5.058284] firmware_class:fw_set_page_data: firmware_class: fw_set_page_data: fw-iwlwifi-8265-36.ucode fw_priv=(____ptrval____) data=(____ptrval____) size=2436632
[    5.058601] firmware_class:__free_fw_priv: firmware_class: __free_fw_priv: fw-iwlwifi-8265-36.ucode fw_priv=(____ptrval____) data=(____ptrval____) size=2436632
[    5.058683] iwlwifi 0000:01:00.0: loaded firmware version 36.ca7b901d.0 8265-36.ucode op_mode iwlmvm
[    5.059671] iwlwifi 0000:01:00.0: Detected Intel(R) Dual Band Wireless AC 8265, REV=0x230
[    5.059847] thermal thermal_zone1: failed to read out thermal zone (-61)
[    5.081156] fbcon: i915drmfb (fb0) is primary device
[    5.081251] Console: switching to colour frame buffer device 240x67
[    5.083303] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    5.126857] iwlwifi 0000:01:00.0: base HW address: cc:2f:71:6f:46:bd, OTP minor version: 0x4
[    5.203543] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'

...

[557856.042722] firmware_class:device_uncache_fw_images: firmware_class: device_uncache_fw_images
[557856.042736] firmware_class:uncache_firmware: firmware_class: uncache_firmware: regulatory.db.p7s
[557856.042744] firmware_class:__free_fw_priv: firmware_class: __free_fw_priv: fw-regulatory.db.p7s fw_priv=000000002503378d data=00000000b09ec70a size=1182
[557856.042770] firmware_class:uncache_firmware: firmware_class: uncache_firmware: regulatory.db
[557856.042776] firmware_class:__free_fw_priv: firmware_class: __free_fw_priv: fw-regulatory.db fw_priv=00000000f955dd7b data=00000000e06d7efb size=4492
[557856.042791] firmware_class:uncache_firmware: firmware_class: uncache_firmware: iwlwifi-8265-36.ucode
[557856.042811] firmware_class:__free_fw_priv: firmware_class: __free_fw_priv: fw-iwlwifi-8265-36.ucode fw_priv=00000000cc3440cd data=0000000064888650 size=2436632

...

[1751744.805221] (NULL device *): Loading firmware from /lib/firmware/regulatory.db.p7s
[1751744.805222] (NULL device *): direct-loading regulatory.db.p7s
[1751744.805223] firmware_class:fw_set_page_data: firmware_class: fw_set_page_data: fw-regulatory.db.p7s fw_priv=0000000012eed5af data=00000000cc9f4798 size=1182
[1751744.805225] firmware_class:cache_firmware: firmware_class: cache_firmware: regulatory.db.p7s ret=0
[1751744.805425] (NULL device *): Loading firmware from /lib/firmware/iwlwifi-8265-36.ucode
[1751744.805427] (NULL device *): direct-loading iwlwifi-8265-36.ucode
[1751744.805428] firmware_class:fw_set_page_data: firmware_class: fw_set_page_data: fw-iwlwifi-8265-36.ucode fw_priv=0000000085577a0e data=00000000293f1e77 size=2436632
[1751744.805431] firmware_class:cache_firmware: firmware_class: cache_firmware: iwlwifi-8265-36.ucode ret=0

...

[1850241.685691] wlp1s0: Connection to AP 5c:83:8f:57:c6:8e lost
[1850242.151209] wlp1s0: authenticate with 5c:83:8f:57:c6:81
[1850242.151218] wlp1s0: 80 MHz not supported, disabling VHT
[1850242.160689] wlp1s0: send auth to 5c:83:8f:57:c6:81 (try 1/3)
[1850242.162983] wlp1s0: authenticated
[1850242.169260] wlp1s0: associate with 5c:83:8f:57:c6:81 (try 1/3)
[1850242.172278] wlp1s0: RX AssocResp from 5c:83:8f:57:c6:81 (capab=0x431 status=0 aid=4)
[1850242.175409] wlp1s0: associated
[1850242.362482] wlp1s0: Limiting TX power to 7 dBm as advertised by 5c:83:8f:57:c6:81
[1850273.849845] wlp1s0: disconnect from AP 5c:83:8f:57:c6:81 for new auth to 5c:83:8f:57:c6:8e
[1850273.999898] wlp1s0: authenticate with 5c:83:8f:57:c6:8e
[1850274.008772] wlp1s0: send auth to 5c:83:8f:57:c6:8e (try 1/3)
[1850274.010400] wlp1s0: authenticated
[1850274.023510] wlp1s0: associate with 5c:83:8f:57:c6:8e (try 1/3)
[1850274.025975] wlp1s0: RX ReassocResp from 5c:83:8f:57:c6:8e (capab=0x11 status=0 aid=105)
[1850274.032079] wlp1s0: associated
[1850274.258179] wlp1s0: Limiting TX power to 18 dBm as advertised by 5c:83:8f:57:c6:8e
[1850285.555455] wlp1s0: Connection to AP 5c:83:8f:57:c6:8e lost
[1850286.001040] wlp1s0: authenticate with cc:46:d6:a1:42:e1
[1850286.001050] wlp1s0: 80 MHz not supported, disabling VHT
[1850286.010557] wlp1s0: send auth to cc:46:d6:a1:42:e1 (try 1/3)
[1850286.012979] wlp1s0: authenticated
[1850286.019206] wlp1s0: associate with cc:46:d6:a1:42:e1 (try 1/3)
[1850286.023280] wlp1s0: RX AssocResp from cc:46:d6:a1:42:e1 (capab=0x431 status=0 aid=1)
[1850286.024511] wlp1s0: associated
[1850286.280797] wlp1s0: Limiting TX power to 1 dBm as advertised by cc:46:d6:a1:42:e1
[1850306.599229] iwlwifi 0000:01:00.0: Error sending SCAN_CFG_CMD: time out after 2000ms.
[1850306.599246] iwlwifi 0000:01:00.0: Current CMD queue read_ptr 99 write_ptr 100
[1850306.849788] iwlwifi 0000:01:00.0: HW error, resetting before reading
[1850306.856785] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[1850306.856786] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: -848496667
[1850306.856788] iwlwifi 0000:01:00.0: Loaded firmware version: 36.ca7b901d.0 8265-36.ucode
[1850306.856790] iwlwifi 0000:01:00.0: 0x9BEE9C80 | ADVANCED_SYSASSERT
[1850306.856792] iwlwifi 0000:01:00.0: 0xB32DBEBB | trm_hw_status0
[1850306.856793] iwlwifi 0000:01:00.0: 0xB3561E78 | trm_hw_status1
[1850306.856794] iwlwifi 0000:01:00.0: 0xAF617C9E | branchlink2
[1850306.856796] iwlwifi 0000:01:00.0: 0xA08D8E00 | interruptlink1
[1850306.856797] iwlwifi 0000:01:00.0: 0x0F25AD31 | interruptlink2
[1850306.856798] iwlwifi 0000:01:00.0: 0x8D5AF344 | data1
[1850306.856799] iwlwifi 0000:01:00.0: 0x67B8D66E | data2
[1850306.856800] iwlwifi 0000:01:00.0: 0xDEAA08BA | data3
[1850306.856801] iwlwifi 0000:01:00.0: 0x139BABF6 | beacon time
[1850306.856803] iwlwifi 0000:01:00.0: 0xB159C4AA | tsf low
[1850306.856804] iwlwifi 0000:01:00.0: 0xA7B467AE | tsf hi
[1850306.856805] iwlwifi 0000:01:00.0: 0x9C0AB03F | time gp1
[1850306.856806] iwlwifi 0000:01:00.0: 0x7E0765B7 | time gp2
[1850306.856807] iwlwifi 0000:01:00.0: 0xDA2B2092 | uCode revision type
[1850306.856808] iwlwifi 0000:01:00.0: 0xD363DE4D | uCode version major
[1850306.856810] iwlwifi 0000:01:00.0: 0xD0259BE0 | uCode version minor
[1850306.856811] iwlwifi 0000:01:00.0: 0xCF6F01F5 | hw version
[1850306.856812] iwlwifi 0000:01:00.0: 0xA7BA4540 | board version
[1850306.856813] iwlwifi 0000:01:00.0: 0x412E3405 | hcmd
[1850306.856814] iwlwifi 0000:01:00.0: 0x7F2BE997 | isr0
[1850306.856815] iwlwifi 0000:01:00.0: 0x7718E110 | isr1
[1850306.856817] iwlwifi 0000:01:00.0: 0x60731843 | isr2
[1850306.856818] iwlwifi 0000:01:00.0: 0xA9D7C2D8 | isr3
[1850306.856819] iwlwifi 0000:01:00.0: 0x5B3A8EB0 | isr4
[1850306.856820] iwlwifi 0000:01:00.0: 0x12F0626B | last cmd Id
[1850306.856821] iwlwifi 0000:01:00.0: 0xDFC7B2E8 | wait_event
[1850306.856822] iwlwifi 0000:01:00.0: 0xBA5C8BC5 | l2p_control
[1850306.856823] iwlwifi 0000:01:00.0: 0x82DBBFD9 | l2p_duration
[1850306.856825] iwlwifi 0000:01:00.0: 0x1BDA8D29 | l2p_mhvalid
[1850306.856826] iwlwifi 0000:01:00.0: 0xF2C0BEFF | l2p_addr_match
[1850306.856827] iwlwifi 0000:01:00.0: 0x2EC97760 | lmpm_pmg_sel
[1850306.856828] iwlwifi 0000:01:00.0: 0x08E5AABB | timestamp
[1850306.856829] iwlwifi 0000:01:00.0: 0xA7AF1005 | flow_handler
[1850306.857019] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[1850306.857020] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 868140955
[1850306.857022] iwlwifi 0000:01:00.0: 0x24455402 | ADVANCED_SYSASSERT
[1850306.857023] iwlwifi 0000:01:00.0: 0xCF35C3C1 | umac branchlink1
[1850306.857024] iwlwifi 0000:01:00.0: 0x06C3D59D | umac branchlink2
[1850306.857026] iwlwifi 0000:01:00.0: 0xCDE7E4BA | umac interruptlink1
[1850306.857027] iwlwifi 0000:01:00.0: 0x3B533A56 | umac interruptlink2
[1850306.857028] iwlwifi 0000:01:00.0: 0x99662AF7 | umac data1
[1850306.857029] iwlwifi 0000:01:00.0: 0x919E1B99 | umac data2
[1850306.857030] iwlwifi 0000:01:00.0: 0xCE8BE8BF | umac data3
[1850306.857031] iwlwifi 0000:01:00.0: 0xCEAB8D16 | umac major
[1850306.857032] iwlwifi 0000:01:00.0: 0x6617A3E7 | umac minor
[1850306.857034] iwlwifi 0000:01:00.0: 0x9E1F0699 | frame pointer
[1850306.857035] iwlwifi 0000:01:00.0: 0x7E66C27E | stack pointer
[1850306.857036] iwlwifi 0000:01:00.0: 0x92604F16 | last host cmd
[1850306.857037] iwlwifi 0000:01:00.0: 0xA7F53EC6 | isr status reg
[1850306.857180] iwlwifi 0000:01:00.0: IML/ROM dump:
[1850306.857181] iwlwifi 0000:01:00.0: 0x00000000 | IML/ROM error/state
[1850306.857198] iwlwifi 0000:01:00.0: 0x00000000 | IML/ROM data1
[1850306.857207] iwlwifi 0000:01:00.0: Fseq Registers:
[1850306.857257] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | FSEQ_ERROR_CODE
[1850306.857328] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | FSEQ_TOP_INIT_VERSION
[1850306.857399] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | FSEQ_CNVIO_INIT_VERSION
[1850306.857470] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | FSEQ_OTP_VERSION
[1850306.857541] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | FSEQ_TOP_CONTENT_VERSION
[1850306.857611] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | FSEQ_ALIVE_TOKEN
[1850306.857682] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | FSEQ_CNVI_ID
[1850306.857753] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | FSEQ_CNVR_ID
[1850306.857824] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | CNVI_AUX_MISC_CHIP
[1850306.857895] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | CNVR_AUX_MISC_CHIP
[1850306.857966] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[1850306.858037] iwlwifi 0000:01:00.0: 0xA5A5A5A2 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[1850306.858042] iwlwifi 0000:01:00.0: Collecting data: trigger 2 fired.
[1850306.858044] ieee80211 phy0: Hardware restart was requested
[1850308.216606] iwlwifi 0000:01:00.0: Queue 0 is inactive on fifo 2 and stuck for 2500 ms. SW [99, 100] HW [162, 162] FH TRB=0x0a5a5a5a2
[1850312.365240] i915 0000:00:02.0: [drm] *ERROR* Atomic update failure on pipe B (start=75242 end=75243) time 218 us, min 1431, max 1439, scanline start 1422, end 1442
[1850314.256923] iwlwifi 0000:01:00.0: Failing on timeout while stopping DMA channel 8 [0xa5a5a5a2]
[1850314.516530] wlp1s0: HW problem - can not stop rx aggregation for cc:46:d6:a1:42:e1 tid 0
[1850320.170194] wlp1s0: disconnect from AP cc:46:d6:a1:42:e1 for new auth to 5c:83:8f:63:3b:7e
[1850320.310721] wlp1s0: authenticate with 5c:83:8f:63:3b:7e
[1850320.319605] wlp1s0: send auth to 5c:83:8f:63:3b:7e (try 1/3)
[1850320.325429] wlp1s0: authenticated
[1850320.329214] wlp1s0: associate with 5c:83:8f:63:3b:7e (try 1/3)
[1850320.332665] wlp1s0: RX ReassocResp from 5c:83:8f:63:3b:7e (capab=0x11 status=0 aid=15)
[1850320.333966] wlp1s0: associated
[1850320.512013] wlp1s0: Limiting TX power to 14 dBm as advertised by 5c:83:8f:63:3b:7e
[1850352.049852] wlp1s0: disconnect from AP 5c:83:8f:63:3b:7e for new auth to 5c:83:8f:57:c6:8e
[1850352.250813] wlp1s0: authenticate with 5c:83:8f:57:c6:8e
[1850352.260057] wlp1s0: send auth to 5c:83:8f:57:c6:8e (try 1/3)
[1850352.265962] wlp1s0: authenticated
[1850352.269200] wlp1s0: associate with 5c:83:8f:57:c6:8e (try 1/3)
[1850352.272558] wlp1s0: RX ReassocResp from 5c:83:8f:57:c6:8e (capab=0x11 status=0 aid=105)
[1850352.276404] wlp1s0: associated


Does this help?

Thank you,
Martin
