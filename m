Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0768260E6BE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Oct 2022 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiJZRr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Oct 2022 13:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiJZRr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Oct 2022 13:47:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07249ACF5B
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 10:47:26 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b25so11150603qkk.7
        for <linux-wireless@vger.kernel.org>; Wed, 26 Oct 2022 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJB6JvCmDF2zNnl3JrsoWyT5ZWUpdYUP7gW3M0Wu2uM=;
        b=aOqnHIFDamU/Sy5zjeH+4JH94uTtLKkW0VH52ZyLKFYh7olGvlLM8b/qKMYakLYW1L
         Pch92OYEPfCR/407hvpoQLv/QAbhHG5j8HHM16Xhs91kb9qxtKXowvLRYo4pJACeCRcs
         Ebi6i4pL3B7ByvMk2jh12l6nIyYqCf6nHXdVMDPHSGPMzizZ4v0AHNgFFWrZ4sb/gC+b
         J/9f5F61M4rPJkQfA+g65TPazdIxB+J9utC+wldGO9tFedhij7oynhEDnXMEqLNHspf8
         76kvFg6lRz+1CaI6PV9GJsyxkmkxOBquRxz1hW6M7cE6hUNRe0RBfzN8Eae2sD91nciq
         EuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJB6JvCmDF2zNnl3JrsoWyT5ZWUpdYUP7gW3M0Wu2uM=;
        b=g/ANTgoaIEk1+IApCd/Izotdm2M01cCHSQ0LBrggpv6BEVk6VieD8+epfwdVpKCfX2
         v1NtMyCpxNRXONhDlpsSt9s7pWf8SKEENUEqLOHo5NIxrkBOhu5At6G3ktaENjPC0/lP
         898SaK5rLFZlHoo/FzPo2puqIrGwrPuKwu+D6fl1/RofdKuKUGfLEhcuGD33oVcQTRDs
         NsxxBGdWEUEUzNKzErV37rfjHAqMK4pGqtz93b460YFEKDZrSWZ2bLTdol5qcEv1MmKa
         Hq7wLSaVewoXf54Mz0DJ5j8rLsQAFyXfdnLEYuH3k5xeB95d7UyIjEHSXuluBUhZdxCJ
         8FTQ==
X-Gm-Message-State: ACrzQf0Ysk8I9gFb72Ich5XLO3/Im5V2CfTXZPopEQgmjmKLQsatGxqt
        emRtEOX/bjdYAZ+eMlQPJn4=
X-Google-Smtp-Source: AMsMyM6zUY22VlzGsS9pqbH3EaYxsjLoHSjruQrFfd/PXOPZ+GFpr0ODeq7oNPBzvZGMZGch2KH3fQ==
X-Received: by 2002:a05:620a:c12:b0:6ee:d3d0:fe20 with SMTP id l18-20020a05620a0c1200b006eed3d0fe20mr31088607qki.470.1666806444911;
        Wed, 26 Oct 2022 10:47:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r11-20020a05620a298b00b006bba46e5eeasm4494688qkp.37.2022.10.26.10.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 10:47:24 -0700 (PDT)
Message-ID: <e7b7879d-6488-2993-ea3e-98b0718a0c87@gmail.com>
Date:   Wed, 26 Oct 2022 10:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: iwlwifi: intel ax210: module fail load firmware: Failed to start
 RT ucode: -110
Content-Language: en-US
To:     Florian Schmidt <florian@fls.name>,
        Greenman Gregory <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <91cad7f52fe275bf567cf5aa7aa6f7c0@mail.infomaniak.com>
 <28dfa897c38286b1cf9ae30631fb7438@mail.infomaniak.com>
 <59fe5bdc361fed71103ee159cdb5ab64@mail.infomaniak.com>
 <f351b0a31b536e7a29d63937a242d5de7e2552ca.camel@intel.com>
 <4077a7705bb86501a9cbbce86fe1ea8c@mail.infomaniak.com>
 <cba07be4-1afc-649f-a172-19f76d726232@gmail.com>
 <79d2434a0160d0c9b677b8144459beca@mail.infomaniak.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <79d2434a0160d0c9b677b8144459beca@mail.infomaniak.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/26/22 10:37, Florian Schmidt wrote:
> On 2022-10-26T18:04:33.000+01:00, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>>   On 10/26/2022 8:56 AM, Florian Schmidt wrote:
>>
>>>     Hi Gregory,
>>>   
>>>   Thank you for having a look at this. The .pnvm file was present in my test as shown by my original message:
>>>
>>>>     md5sum /lib/firmware/*
>>>>   787381c60d907f81a3ddadc5c990a82b ./iwlwifi-ty-a0-gf-a0-71.ucode
>>>>   d93cbdcc4bb5be69aac128e2fe291359 ./iwlwifi-ty-a0-gf-a0.pnvm
>>>>   33d13d236512466e71c81257209a356f ./regulatory.db
>>>    
>>>   I just ran the test again, ensuring I have the .pnvm you mention and the result is indeed the same.
>>>   
>>>   Any other ideas to solve this are welcome.
>>   
>> The driver indicated it wanted to load iwlwifi-ty-a0-gf-a0-72.ucode,
>> which you do seem to have based upon the listing above?
>> -- 
>> Florian
> 
> Hi Florian,
> 
> Indeed, my first log seems to load -72.ucode when my dump show a -71 file, that's strange. I must have mismatched some test, sorry for the confusion. During my tests, I've actually tried with many different firmwares (I think I've done all the compatible firmware I could find), tested both with and without the pnvm file and many kernel versions, it always seems to fail. The suspicious thing to me is that during my tests, I've confirmed several times that the same sets of wifi card, kernel and firmware work well on my intel desktop.
> 
> Below are the logs from my latest test today with firmware -71 and the .pnvm from git.
> 
> I'd be happy to help debug more, but I have zero visibility on the firmware so those register dumps just mean nothing to me. Let me know how I can assist with this.

I am not familiar with ax210, but have worked quite a bit with the 7260 
chips (iwlwifi) and errors like those typically occurred when the PCIe 
end-point device, that is the ax210 is not able to do PCIe inbound 
accesses into your system's memory. Now in your case it could be that 
the inaility to load the appropriate ucode results in ... you guessed 
it, the ucode not being loaded which causes the timeout to happen.

Can you tell us more about your ARM32 system here? What PCIe host 
bridge/controller does it use, do you have an IOMMU attached to that 
PCIe host brideg somehow?

Thanks!
> 
> Florian
> -------
> 
> root@BV1-27109:/lib/firmware# md5sum /lib/firmware/*
> 787381c60d907f81a3ddadc5c990a82b  /lib/firmware/iwlwifi-ty-a0-gf-a0-71.ucode
> d93cbdcc4bb5be69aac128e2fe291359  /lib/firmware/iwlwifi-ty-a0-gf-a0.pnvm
> 33d13d236512466e71c81257209a356f  /lib/firmware/regulatory.db
> 
> Linux BV1-27109 6.0.1-xilinx #1 SMP PREEMPT Wed Oct 12 09:15:44 UTC 2022 armv7l GNU/Linux
> 
> pci 0000:01:00.0: [8086:2725] type 00 class 0x028000
> pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:00.0: BAR 8: assigned [mem 0x80000000-0x800fffff]
> pci 0000:01:00.0: BAR 0: assigned [mem 0x80000000-0x80003fff 64bit]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0:   bridge window [mem 0x80000000-0x800fffff]
> Intel(R) Wireless WiFi driver for Linux
> pci 0000:00:00.0: enabling device (0140 -> 0142)
> iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
> iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-72.ucode failed with error -2
> iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
> iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.36
> iwlwifi 0000:01:00.0: loaded firmware version 71.058653f6.0 ty-a0-gf-a0-71.ucode  op_mode iwlmvm
> iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
> thermal thermal_zone0: failed to read out thermal zone (-61)
> iwlwifi 0000:01:00.0: loaded PNVM version a982b33e
> iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
> iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
> iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (delay=0ms).
> iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
> iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-a0-71.ucode
> iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
> iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
> iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
> iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
> iwlwifi 0000:01:00.0: 0x004D9C78 | data1
> iwlwifi 0000:01:00.0: 0x01000000 | data2
> iwlwifi 0000:01:00.0: 0x00000000 | data3
> iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> iwlwifi 0000:01:00.0: 0x00052ADD | tsf low
> iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> iwlwifi 0000:01:00.0: 0x00066975 | time gp2
> iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
> iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
> iwlwifi 0000:01:00.0: 0x00000420 | hw version
> iwlwifi 0000:01:00.0: 0x00489002 | board version
> iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
> iwlwifi 0000:01:00.0: 0x00020000 | isr0
> iwlwifi 0000:01:00.0: 0x00000000 | isr1
> iwlwifi 0000:01:00.0: 0x48F00002 | isr2
> iwlwifi 0000:01:00.0: 0x00C0000C | isr3
> iwlwifi 0000:01:00.0: 0x00000000 | isr4
> iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
> iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
> iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
> iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
> iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
> iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
> iwlwifi 0000:01:00.0: 0x804792D6 | umac interruptlink2
> iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> iwlwifi 0000:01:00.0: 0x804792D6 | umac data2
> iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> iwlwifi 0000:01:00.0: 0x00000047 | umac major
> iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> iwlwifi 0000:01:00.0: 0x00066ABB | frame pointer
> iwlwifi 0000:01:00.0: 0xC0886244 | stack pointer
> iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> iwlwifi 0000:01:00.0: IML/ROM dump:
> iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> iwlwifi 0000:01:00.0: 0x000080F1 | IML/ROM data1
> iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> iwlwifi 0000:01:00.0: Fseq Registers:
> iwlwifi 0000:01:00.0: 0x20000000 | FSEQ_ERROR_CODE
> iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> iwlwifi 0000:01:00.0: retry init count 0
> iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
> thermal thermal_zone0: failed to read out thermal zone (-61)
> iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
> iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
> iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (delay=0ms).
> iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
> iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-a0-71.ucode
> iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
> iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
> iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
> iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
> iwlwifi 0000:01:00.0: 0x004D9C78 | data1
> iwlwifi 0000:01:00.0: 0x01000000 | data2
> iwlwifi 0000:01:00.0: 0x00000000 | data3
> iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> iwlwifi 0000:01:00.0: 0x00053473 | tsf low
> iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> iwlwifi 0000:01:00.0: 0x0006722F | time gp2
> iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
> iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
> iwlwifi 0000:01:00.0: 0x00000420 | hw version
> iwlwifi 0000:01:00.0: 0x18489002 | board version
> iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
> iwlwifi 0000:01:00.0: 0x00020000 | isr0
> iwlwifi 0000:01:00.0: 0x00000000 | isr1
> iwlwifi 0000:01:00.0: 0x48F00002 | isr2
> iwlwifi 0000:01:00.0: 0x00C0000C | isr3
> iwlwifi 0000:01:00.0: 0x00000000 | isr4
> iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
> iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
> iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
> iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
> iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
> iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
> iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink2
> iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> iwlwifi 0000:01:00.0: 0x8047E792 | umac data2
> iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> iwlwifi 0000:01:00.0: 0x00000047 | umac major
> iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> iwlwifi 0000:01:00.0: 0x00067375 | frame pointer
> iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
> iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> iwlwifi 0000:01:00.0: IML/ROM dump:
> iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> iwlwifi 0000:01:00.0: 0x000080EF | IML/ROM data1
> iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> iwlwifi 0000:01:00.0: Fseq Registers:
> iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
> iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> iwlwifi 0000:01:00.0: retry init count 1
> iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
> thermal thermal_zone0: failed to read out thermal zone (-61)
> iwlwifi 0000:01:00.0: Timeout waiting for PNVM load!
> iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
> iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired (delay=0ms).
> iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
> iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-a0-71.ucode
> iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> iwlwifi 0000:01:00.0: 0x002002F0 | trm_hw_status0
> iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> iwlwifi 0000:01:00.0: 0x004DAEA2 | branchlink2
> iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink1
> iwlwifi 0000:01:00.0: 0x004D1336 | interruptlink2
> iwlwifi 0000:01:00.0: 0x004D9C78 | data1
> iwlwifi 0000:01:00.0: 0x01000000 | data2
> iwlwifi 0000:01:00.0: 0x00000000 | data3
> iwlwifi 0000:01:00.0: 0x00000000 | beacon time
> iwlwifi 0000:01:00.0: 0x00050982 | tsf low
> iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> iwlwifi 0000:01:00.0: 0x00064743 | time gp2
> iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> iwlwifi 0000:01:00.0: 0x00000047 | uCode version major
> iwlwifi 0000:01:00.0: 0x058653F6 | uCode version minor
> iwlwifi 0000:01:00.0: 0x00000420 | hw version
> iwlwifi 0000:01:00.0: 0x18489002 | board version
> iwlwifi 0000:01:00.0: 0x8004FC12 | hcmd
> iwlwifi 0000:01:00.0: 0x00020000 | isr0
> iwlwifi 0000:01:00.0: 0x00000000 | isr1
> iwlwifi 0000:01:00.0: 0x48F00002 | isr2
> iwlwifi 0000:01:00.0: 0x00C0000C | isr3
> iwlwifi 0000:01:00.0: 0x00000000 | isr4
> iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
> iwlwifi 0000:01:00.0: 0x004D9C78 | wait_event
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
> iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
> iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
> iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
> iwlwifi 0000:01:00.0: 0x8047E792 | umac interruptlink1
> iwlwifi 0000:01:00.0: 0x804792E6 | umac interruptlink2
> iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> iwlwifi 0000:01:00.0: 0x804792E6 | umac data2
> iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> iwlwifi 0000:01:00.0: 0x00000047 | umac major
> iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
> iwlwifi 0000:01:00.0: 0x0006488D | frame pointer
> iwlwifi 0000:01:00.0: 0xC0886244 | stack pointer
> iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
> iwlwifi 0000:01:00.0: 0x00000400 | isr status reg
> iwlwifi 0000:01:00.0: IML/ROM dump:
> iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
> iwlwifi 0000:01:00.0: 0x000080F3 | IML/ROM data1
> iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> iwlwifi 0000:01:00.0: Fseq Registers:
> iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
> iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
> iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
> iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
> iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
> iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
> iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
> iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
> iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
> iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
> iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
> iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
> iwlwifi 0000:01:00.0: retry init count 2

-- 
Florian

