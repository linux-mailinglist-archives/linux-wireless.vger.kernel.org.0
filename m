Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4269CE1381
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 09:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbfJWH7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 03:59:32 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37701 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfJWH7c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 03:59:32 -0400
Received: by mail-wr1-f48.google.com with SMTP id e11so12209104wrv.4
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2019 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=r0RtMaAJfKh9LVjhRK+nYZysC5XNNEbRc9Spy6ynwko=;
        b=ErlbGc4P8e1BFd7quUKGv6/Pt0ShW+JiYePzlcZ813C0ql8QCzALmI1QPcc55ZjBLk
         Yn2f4goveKuG3QiX8i0uerdO2+TzQsTOjSku1Pthq+hF7YNFnlnIao0E9kQT16MejVvg
         MX/bUH1lxnWbPptQMmOOv6Htd/6Id42AJYshElEMhNHTOU5V4ET4Pw/kh5bMJprAnhZR
         TyL99z9QexVdfFKQPdbD/scZurnDemz7hJmSEKC7eVnHkd8pw5M4xmPME2uC73hrqLcG
         6LfrMSHwo6R42nCnxMms0GTpRc/gpzytrGV1/RsDVQf22h+BbZ44RRHGzBXG2wb3NCLv
         rtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=r0RtMaAJfKh9LVjhRK+nYZysC5XNNEbRc9Spy6ynwko=;
        b=tWZyVZoEkglWgMS2aNE4oSnjzQuCkh956VgRB2lTwl6hhxrwXXdpVwfWDaIuzdYAaf
         Wm4IyA5U6KYfZ0gmAQhg9SyZJr6X/peaSY8zcg3n9u4swm9xwrvuibQjeEOU9c+McXJt
         verd4ngM+5xzEExpWFa9p+a1WUiPBgAN5f/nsKJn8fmNYxT0VVhfajj1+1zL3WPdqgSf
         2VX43mZRKNl/CbohgioVoo9UkPcChqyfZCUNWWLkgj0o7EKylJHoiqLuKB6yPyE2AHvl
         sJQA2yKhQ0FS4vsWG3mkO6J8OIkMCG7WK0syUSC+I8R9iFfQRgyB/ShFyD84C7qkxUVG
         4INA==
X-Gm-Message-State: APjAAAVH+o6cwD+AiTzccbGQVmLQymfF3sE0htcXT+HIuiQqRX86Kwdc
        5Gs75L31gVinV5Y70k8GRCqGUqPH
X-Google-Smtp-Source: APXvYqz0TO0s1lD0wHIkzGsoWzFf/bHSKMRSgfUDV3ShW3COywDbtgYuh8u8uO9l137/2d9baoma7A==
X-Received: by 2002:a5d:6203:: with SMTP id y3mr7132948wru.142.1571817568199;
        Wed, 23 Oct 2019 00:59:28 -0700 (PDT)
Received: from [192.168.1.80] (223.199.28.109.rev.sfr.net. [109.28.199.223])
        by smtp.gmail.com with ESMTPSA id o18sm23733599wrm.11.2019.10.23.00.59.27
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 00:59:27 -0700 (PDT)
From:   Vincent Ravier-Glazman <vincent.ravierglazman@gmail.com>
Subject: Bug - QCA6174 firmware crash on ath10k_pci module removing
To:     linux-wireless@vger.kernel.org
Message-ID: <74f6b652-8933-9a0a-faa3-42ee07ce51f6@gmail.com>
Date:   Wed, 23 Oct 2019 09:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I was experiencing issues when trying to get hibernate work: about more than half time, my computer was freezing on hibernate. I've finally found the problem: the ath10k_pci module. If I remove this module before hibernate, no more freeze. Just have to modprobe it on thaw, my wireless connection gets back  itself and I'm good to continue.

I've also checked dmesg, and rmmod ath10k_pci causes a firmware crash:

[ 1983.338397] wlp2s0: deauthenticating from 44:ce:7d:34:fb:ac by local choice (Reason: 3=DEAUTH_LEAVING)
[ 1983.345358] ath10k_pci 0000:02:00.0: firmware crashed! (guid 0263f381-ffa9-4f00-bec5-a320c2789234)
[ 1983.345362] ath10k_pci 0000:02:00.0: qca6174 hw2.1 target 0x05010000 chip_id 0x003405ff sub 1a56:1525
[ 1983.345363] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
[ 1983.345657] ath10k_pci 0000:02:00.0: firmware ver SW_RM.1.1.1-00157-QCARMSWPZ-1 api 5 features ignore-otp,no-4addr-pad crc32 10bf8e08
[ 1983.345867] ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 ae2e275a
[ 1983.345869] ath10k_pci 0000:02:00.0: htt-ver 3.1 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[ 1983.347874] ath10k_pci 0000:02:00.0: firmware register dump:
[ 1983.347876] ath10k_pci 0000:02:00.0: [00]: 0x05010000 0x00000000 0x0092E4DC 0x4DE697C1
[ 1983.347877] ath10k_pci 0000:02:00.0: [04]: 0x0092E4DC 0x00060130 0x00000018 0x0041A760
[ 1983.347878] ath10k_pci 0000:02:00.0: [08]: 0x4DE697AD 0x00400000 0x00000000 0x000A5C88
[ 1983.347879] ath10k_pci 0000:02:00.0: [12]: 0x00000009 0x00000000 0x0096C09C 0x0096C0A7
[ 1983.347880] ath10k_pci 0000:02:00.0: [16]: 0x0096BDBC 0x009287BD 0x00000000 0x009287BD
[ 1983.347881] ath10k_pci 0000:02:00.0: [20]: 0x4092E4DC 0x0041A710 0x00000000 0x0F000000
[ 1983.347882] ath10k_pci 0000:02:00.0: [24]: 0x809432A7 0x0041A770 0x0040D400 0xC092E4DC
[ 1983.347883] ath10k_pci 0000:02:00.0: [28]: 0x80942BC4 0x0041A790 0x4DE697AD 0x00400000
[ 1983.347885] ath10k_pci 0000:02:00.0: [32]: 0x80947BA7 0x0041A7B0 0x004050A8 0x0040E074
[ 1983.347886] ath10k_pci 0000:02:00.0: [36]: 0x809BDECC 0x0041A7D0 0x004050A8 0x0040E074
[ 1983.347887] ath10k_pci 0000:02:00.0: [40]: 0x8099638C 0x0041A7F0 0x004050A8 0x00000000
[ 1983.347888] ath10k_pci 0000:02:00.0: [44]: 0x80992076 0x0041A810 0x0044FD68 0x0046FFE8
[ 1983.347889] ath10k_pci 0000:02:00.0: [48]: 0x80996BD3 0x0041A830 0x0044FD68 0x00000000
[ 1983.347890] ath10k_pci 0000:02:00.0: [52]: 0x800B4405 0x0041A850 0x00422318 0x00005002
[ 1983.347891] ath10k_pci 0000:02:00.0: [56]: 0x809A6C34 0x0041A8E0 0x0042932C 0x0042CA20
[ 1983.347892] ath10k_pci 0000:02:00.0: Copy Engine register dump:
[ 1983.347899] ath10k_pci 0000:02:00.0: [00]: 0x00034400   1   1 3 3
[ 1983.347913] ath10k_pci 0000:02:00.0: [01]: 0x00034800  20  20 151 152
[ 1983.347921] ath10k_pci 0000:02:00.0: [02]: 0x00034c00  47  47 46 47
[ 1983.347928] ath10k_pci 0000:02:00.0: [03]: 0x00035000  16  16 17 16
[ 1983.347936] ath10k_pci 0000:02:00.0: [04]: 0x00035400 1061 1061 84  20
[ 1983.347943] ath10k_pci 0000:02:00.0: [05]: 0x00035800   0   0 0 0
[ 1983.347950] ath10k_pci 0000:02:00.0: [06]: 0x00035c00  18  18 18 18
[ 1983.347960] ath10k_pci 0000:02:00.0: [07]: 0x00036000   1   1 1 1
[ 1983.347986] ath10k_pci 0000:02:00.0: could not suspend target (-108)
[ 1983.440187] ath10k_pci 0000:02:00.0: cannot restart a device that hasn't been started


Here are also the messages on modprobe ath10k_pci:

[  708.534013] ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
[  708.803707] ath10k_pci 0000:02:00.0: firmware: failed to load ath10k/pre-cal-pci-0000:02:00.0.bin (-2)
[  708.803714] ath10k_pci 0000:02:00.0: firmware: failed to load ath10k/cal-pci-0000:02:00.0.bin (-2)
[  708.803719] ath10k_pci 0000:02:00.0: firmware: failed to load ath10k/QCA6174/hw2.1/firmware-6.bin (-2)
[  708.803887] ath10k_pci 0000:02:00.0: firmware: direct-loading firmware ath10k/QCA6174/hw2.1/firmware-5.bin
[  708.803890] ath10k_pci 0000:02:00.0: qca6174 hw2.1 target 0x05010000 chip_id 0x003405ff sub 1a56:1525
[  708.803891] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
[  708.804164] ath10k_pci 0000:02:00.0: firmware ver SW_RM.1.1.1-00157-QCARMSWPZ-1 api 5 features ignore-otp,no-4addr-pad crc32 10bf8e08
[  708.865444] ath10k_pci 0000:02:00.0: firmware: direct-loading firmware ath10k/QCA6174/hw2.1/board-2.bin
[  708.865588] ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 ae2e275a
[  710.036149] ath10k_pci 0000:02:00.0: htt-ver 3.1 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1


I run Debian 10 (4.19.0-6 kernel) on a MSI GS60 6QE laptop. I've already installed lastest firmware from here: https://github.com/kvalo/ath10k-firmware/tree/master/. However hw2.1 hasn't been updated for a while, and I can't figure what makes hw2.1 firmware files loaded instead of hw3.0 ones.

As a workaround, I've created scripts to rmmod ath10k_pci on hibernate and modprobe it on thaw.

Other informations:

lspci -k

02:00.0 Network controller: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter (rev 20)
     Subsystem: Bigfoot Networks, Inc. Killer N1525 Wireless-AC
     Kernel driver in use: ath10k_pci
     Kernel modules: ath10k_pci

modinfo ath10k_pci

filename: /lib/modules/4.19.0-6-amd64/kernel/drivers/net/wireless/ath/ath10k/ath10k_pci.ko
firmware:       ath10k/QCA9377/hw1.0/board.bin
firmware:       ath10k/QCA9377/hw1.0/firmware-5.bin
firmware:       ath10k/QCA9377/hw1.0/firmware-6.bin
firmware:       ath10k/QCA6174/hw3.0/board-2.bin
firmware:       ath10k/QCA6174/hw3.0/board.bin
firmware:       ath10k/QCA6174/hw3.0/firmware-6.bin
firmware:       ath10k/QCA6174/hw3.0/firmware-5.bin
firmware:       ath10k/QCA6174/hw3.0/firmware-4.bin
firmware:       ath10k/QCA6174/hw2.1/board-2.bin
firmware:       ath10k/QCA6174/hw2.1/board.bin
firmware:       ath10k/QCA6174/hw2.1/firmware-5.bin
firmware:       ath10k/QCA6174/hw2.1/firmware-4.bin
firmware:       ath10k/QCA9887/hw1.0/board-2.bin
firmware:       ath10k/QCA9887/hw1.0/board.bin
firmware:       ath10k/QCA9887/hw1.0/firmware-5.bin
firmware:       ath10k/QCA988X/hw2.0/board-2.bin
firmware:       ath10k/QCA988X/hw2.0/board.bin
firmware:       ath10k/QCA988X/hw2.0/firmware-5.bin
firmware:       ath10k/QCA988X/hw2.0/firmware-4.bin
firmware:       ath10k/QCA988X/hw2.0/firmware-3.bin
firmware:       ath10k/QCA988X/hw2.0/firmware-2.bin
license:        Dual BSD/GPL
description:    Driver support for Qualcomm Atheros 802.11ac WLAN PCIe/AHB devices
author:         Qualcomm Atheros
alias:          pci:v0000168Cd00000050sv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000042sv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000046sv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000056sv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000040sv*sd*bc*sc*i*
alias:          pci:v0000168Cd0000003Esv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000041sv*sd*bc*sc*i*
alias:          pci:v0000168Cd0000003Csv*sd*bc*sc*i*
alias:          pci:v00000777d000011ACsv*sd*bc*sc*i*
depends:        ath10k_core
retpoline:      Y
intree:         Y
name:           ath10k_pci
vermagic:       4.19.0-6-amd64 SMP mod_unload modversions
sig_id:         PKCS#7
signer:         Debian Secure Boot CA
sig_key:        A7:46:8D:EF
sig_hashalgo:   sha256
signature: 96:8B:8B:91:CB:0A:DE:55:50:A8:CE:4B:78:0B:83:AD:FF:37:73:E8:
50:3B:04:95:CC:78:CC:B2:2B:30:DC:2B:F0:0B:2E:91:01:DD:2C:40:
8F:26:F2:20:59:54:28:D3:44:D8:0A:6F:EC:1A:B0:29:1D:06:90:E7:
16:54:8A:E9:08:07:03:AC:7B:6F:AB:61:E4:92:7E:60:B6:8C:1A:DB:
F2:9A:41:75:88:6F:8A:6C:CC:AB:A0:9C:66:68:FC:75:FD:21:D7:2F:
2D:00:80:48:69:E6:D4:B0:1E:15:5B:DF:FF:6D:10:25:55:BD:40:47:
D0:20:16:93:56:B9:71:E7:63:14:6D:E4:50:92:CB:64:F0:DF:7B:B7:
53:F2:BA:F7:B4:DA:2B:53:1F:F5:DB:55:80:43:B2:C0:9C:95:EC:C3:
E0:31:62:9F:A5:C4:1B:08:3D:00:FE:F7:ED:BD:BE:56:3F:87:25:20:
8D:C0:38:47:EC:11:23:22:9F:0A:D9:20:7B:4C:C6:CC:04:0D:35:11:
AE:A0:D8:A6:57:03:DC:7E:07:57:64:FE:60:1A:7E:60:4E:2C:B2:4E:
80:6D:F0:F3:17:4B:5D:B9:2E:F5:01:D5:E4:82:13:B7:9A:33:F0:0C:
         F7:ED:AE:7F:FF:F6:2F:DA:D2:36:76:F0:76:83:19:EE
parm:           irq_mode:0: auto, 1: legacy, 2: msi (default: 0) (uint)
parm:           reset_mode:0: auto, 1: warm only (default: 0) (uint)





