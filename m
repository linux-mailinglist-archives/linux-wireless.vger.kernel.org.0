Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA590CB9
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2019 06:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfHQENI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Aug 2019 00:13:08 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:45441 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQENI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Aug 2019 00:13:08 -0400
Received: by mail-qt1-f181.google.com with SMTP id k13so8301266qtm.12;
        Fri, 16 Aug 2019 21:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WyWcvzTdA+COXSokGD2RxX2c3d1vBbk3XjOBjbHBwkA=;
        b=Ld61iSQs3/3acf4CmY2si9SJEV8gBQY1x8Dyv5mr5KgyUJUvIOrO/YR7TQo7xofm0R
         bu0qF4/Ruh4bTx7nZL88tL/fmd7FfwOgZthHfjwba+AbfGMGJeaQDoZk+NL7E/1AHvFz
         XDTJtGksyJkT7MKbcbGMVR69TU9Kyy8R8+NPoUPUZMdgZ140Sh7xsHUKUR7dBlWAYOKH
         oynWFQ6EuVgd9cre2rL5RthQog09ElYF3gonEAADnpC+wrlgV7XK1YPdQcNX/z5M2+av
         Znc5iNGjB0rTvp0HA6NQuQDvEB/7wRFLNH3qRcjX6U6VMfROyDwrEmyuXCf6H5/ueMS+
         0V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WyWcvzTdA+COXSokGD2RxX2c3d1vBbk3XjOBjbHBwkA=;
        b=lNl14iEqARP73B8jbn51ZkvY4I5K7XSwNPw68cXMLC2uZEQpaz9Jb1p35SHr3ON/8n
         qNn2tILFd+B9Gtf5WlftO6bSIEUsnqoldP0htZk9G4lD8BEIsw59H0CdNX8nYsAFqMnO
         4RDkSfS6nY2oqasTewAKriVc7tDSSOYXNPnlPxkjswjMzvO/b+UKAh/QputhIsu9sc2x
         SugOBVkZbb/1Qgu/maDCocu8F2w2HEs4O7oBoBsGFYbc3WyIdfcoiGWl26gk2142CEcT
         dC7B/36n5XbYn6prE2p2mYa3hGAEm6Su3pIsAtIA98emQ8+6dA9n8zLNua8Lq3Oes/VC
         VNsw==
X-Gm-Message-State: APjAAAU5Uy82I2qlIj2hZEbt7v7M1TQ8gzq8EG0ym6RQEm77Y+RRsiVZ
        kB4tF4Gt1NXcEd7NyHjNwvPRbdaIqII=
X-Google-Smtp-Source: APXvYqyo6PJsk4dbHKcHL6lfJmsy7uxWCF7HQACfqC1DmGdoB10X7U3nWzE3jMRQABQlGCdHjXGWOQ==
X-Received: by 2002:ac8:6887:: with SMTP id m7mr2343218qtq.325.1566015177784;
        Fri, 16 Aug 2019 21:12:57 -0700 (PDT)
Received: from chirva-slack.chirva-slack (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id o33sm4186053qtd.72.2019.08.16.21.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 21:12:56 -0700 (PDT)
Date:   Sat, 17 Aug 2019 00:12:58 -0400
From:   Stuart Little <achirvasub@gmail.com>
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Subject: PROBLEM: 5.3.0-rc* causes iwlwifi failure
Message-ID: <20190817041258.GA1641@chirva-slack.chirva-slack>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am on an Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz running Linux x86_64 (Slackware), with a custom-compiled 5.3.0-rc4 (.config attached).

I am using the Intel wifi adapter on this machine:

02:00.0 Network controller: Intel Corporation Device 24fb (rev 10)

with the iwlwifi driver. I am attaching the output to 'lspci -vv -s 02:00.0' as the file device-info. 

All 5.3.0-rc* versions I have tried (including rc4) cause multiple dmesg iwlwifi-related errors (dmesg attached). Examples:

iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000
iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND

The card cannot scan for networks: 'iw dev wlan0 scan' results in a 'scan aborted!' message.

5.2.0 does not exhibit any of these issues. 

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[  518.960280]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  518.960300]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  518.960316]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  518.960333]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  518.960344]  process_one_work+0x1d4/0x400
[  518.960351]  worker_thread+0x2d/0x3c0
[  518.960357]  ? set_worker_desc+0xb0/0xb0
[  518.960363]  kthread+0x113/0x130
[  518.960371]  ? kthread_park+0xa0/0xa0
[  518.960382]  ret_from_fork+0x35/0x40
[  518.960397] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  523.634920] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  523.635070] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  523.635077] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  523.635082] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  523.635089] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  523.635094] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  523.635099] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  523.635104] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  523.635108] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  523.635113] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  523.635135] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  523.635141] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  523.635145] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  523.635149] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  523.635154] iwlwifi 0000:02:00.0: 0x00447A4A | tsf low
[  523.635158] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  523.635163] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  523.635167] iwlwifi 0000:02:00.0: 0x00447A4B | time gp2
[  523.635171] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  523.635176] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  523.635181] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  523.635185] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  523.635190] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  523.635195] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  523.635201] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  523.635206] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  523.635211] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  523.635216] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  523.635221] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  523.635227] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  523.635232] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  523.635238] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  523.635243] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  523.635249] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  523.635254] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  523.635259] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  523.635265] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  523.635271] iwlwifi 0000:02:00.0: 0x00005868 | flow_handler
[  523.635278] iwlwifi 0000:02:00.0: Fseq Registers:
[  523.635304] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  523.635329] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  523.635353] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  523.635376] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  523.635401] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  523.635425] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  523.635449] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  523.635473] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  523.635497] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  523.635521] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  523.635545] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  523.635569] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  523.635579] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  523.635592] ieee80211 phy0: Hardware restart was requested
[  523.635615] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  523.635622] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  523.635628] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447A47
[  523.635694] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  523.635704] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  523.635708] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  523.635736] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  523.635742] Call Trace:
[  523.635762]  dump_stack+0x46/0x5b
[  523.635788]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  523.635803]  ? wait_woken+0x80/0x80
[  523.635823]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  523.635849]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  523.635867]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  523.635885]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  523.635904]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  523.635922]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  523.635940]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  523.635950]  process_one_work+0x1d4/0x400
[  523.635959]  worker_thread+0x2d/0x3c0
[  523.635966]  ? set_worker_desc+0xb0/0xb0
[  523.635974]  kthread+0x113/0x130
[  523.635982]  ? kthread_park+0xa0/0xa0
[  523.635993]  ret_from_fork+0x35/0x40
[  523.636007] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  528.297716] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  528.297861] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  528.297870] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  528.297876] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  528.297883] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  528.297939] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  528.297949] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  528.297955] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  528.297960] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  528.297966] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  528.297971] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  528.297977] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  528.297983] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  528.297988] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  528.297993] iwlwifi 0000:02:00.0: 0x00447B67 | tsf low
[  528.297998] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  528.298003] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  528.298009] iwlwifi 0000:02:00.0: 0x00447B68 | time gp2
[  528.298014] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  528.298020] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  528.298025] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  528.298031] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  528.298037] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  528.298042] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  528.298047] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  528.298053] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  528.298059] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  528.298064] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  528.298069] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  528.298074] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  528.298080] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  528.298085] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  528.298091] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  528.298096] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  528.298101] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  528.298106] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  528.298112] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  528.298117] iwlwifi 0000:02:00.0: 0x00005860 | flow_handler
[  528.298124] iwlwifi 0000:02:00.0: Fseq Registers:
[  528.298152] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  528.298182] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  528.298214] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  528.298238] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  528.298261] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  528.298285] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  528.298310] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  528.298333] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  528.298357] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  528.298380] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  528.298404] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  528.298422] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  528.298430] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  528.298442] ieee80211 phy0: Hardware restart was requested
[  528.298464] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  528.298469] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  528.298475] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B64
[  528.298546] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  528.298556] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  528.298560] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  528.298588] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  528.298592] Call Trace:
[  528.298612]  dump_stack+0x46/0x5b
[  528.298638]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  528.298652]  ? wait_woken+0x80/0x80
[  528.298671]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  528.298699]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  528.298719]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  528.298739]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  528.298761]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  528.298777]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  528.298795]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  528.298806]  process_one_work+0x1d4/0x400
[  528.298813]  worker_thread+0x2d/0x3c0
[  528.298820]  ? set_worker_desc+0xb0/0xb0
[  528.298827]  kthread+0x113/0x130
[  528.298835]  ? kthread_park+0xa0/0xa0
[  528.298846]  ret_from_fork+0x35/0x40
[  528.298860] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  532.960948] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  532.961088] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  532.961096] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  532.961101] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  532.961107] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  532.961113] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  532.961118] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  532.961123] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  532.961127] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  532.961132] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  532.961136] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  532.961141] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  532.961145] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  532.961150] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  532.961155] iwlwifi 0000:02:00.0: 0x00447A47 | tsf low
[  532.961159] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  532.961164] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  532.961168] iwlwifi 0000:02:00.0: 0x00447A48 | time gp2
[  532.961173] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  532.961178] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  532.961183] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  532.961188] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  532.961192] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  532.961197] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  532.961201] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  532.961206] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  532.961211] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  532.961215] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  532.961219] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  532.961224] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  532.961229] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  532.961234] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  532.961238] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  532.961243] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  532.961247] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  532.961252] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  532.961257] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  532.961261] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  532.961267] iwlwifi 0000:02:00.0: Fseq Registers:
[  532.961292] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  532.961310] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  532.961328] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  532.961345] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  532.961363] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  532.961380] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  532.961398] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  532.961415] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  532.961433] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  532.961450] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  532.961467] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  532.961484] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  532.961492] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  532.961503] ieee80211 phy0: Hardware restart was requested
[  532.961522] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  532.961527] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  532.961532] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447A44
[  532.961591] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  532.961599] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  532.961602] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  532.961626] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  532.961630] Call Trace:
[  532.961647]  dump_stack+0x46/0x5b
[  532.961671]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  532.961683]  ? wait_woken+0x80/0x80
[  532.961700]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  532.961723]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  532.961739]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  532.961757]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  532.961776]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  532.961790]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  532.961806]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  532.961814]  process_one_work+0x1d4/0x400
[  532.961821]  worker_thread+0x2d/0x3c0
[  532.961827]  ? set_worker_desc+0xb0/0xb0
[  532.961833]  kthread+0x113/0x130
[  532.961840]  ? kthread_park+0xa0/0xa0
[  532.961847]  ret_from_fork+0x35/0x40
[  532.961857] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  537.626628] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  537.626774] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  537.626783] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  537.626789] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  537.626797] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  537.626803] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  537.626808] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  537.626814] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  537.626820] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  537.626825] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  537.626830] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  537.626835] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  537.626841] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  537.626847] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  537.626853] iwlwifi 0000:02:00.0: 0x00447B86 | tsf low
[  537.626858] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  537.626863] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  537.626869] iwlwifi 0000:02:00.0: 0x00447B87 | time gp2
[  537.626874] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  537.626880] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  537.626885] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  537.626891] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  537.626896] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  537.626902] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  537.626907] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  537.626913] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  537.626918] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  537.626923] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  537.626928] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  537.626934] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  537.626939] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  537.626944] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  537.626950] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  537.626955] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  537.626960] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  537.626966] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  537.626972] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  537.626977] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  537.626984] iwlwifi 0000:02:00.0: Fseq Registers:
[  537.627010] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  537.627034] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  537.627058] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  537.627082] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  537.627106] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  537.627130] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  537.627154] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  537.627178] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  537.627201] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  537.627225] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  537.627248] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  537.627266] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  537.627276] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  537.627288] ieee80211 phy0: Hardware restart was requested
[  537.627311] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  537.627318] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  537.627324] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B83
[  537.627392] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  537.627402] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  537.627406] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  537.627433] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  537.627438] Call Trace:
[  537.627458]  dump_stack+0x46/0x5b
[  537.627484]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  537.627498]  ? wait_woken+0x80/0x80
[  537.627517]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  537.627544]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  537.627562]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  537.627582]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  537.627602]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  537.627618]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  537.627636]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  537.627646]  process_one_work+0x1d4/0x400
[  537.627653]  worker_thread+0x2d/0x3c0
[  537.627660]  ? set_worker_desc+0xb0/0xb0
[  537.627667]  kthread+0x113/0x130
[  537.627674]  ? kthread_park+0xa0/0xa0
[  537.627682]  ret_from_fork+0x35/0x40
[  537.627694] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  542.299958] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  542.300106] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  542.300114] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  542.300120] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  542.300128] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  542.300134] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  542.300139] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  542.300145] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  542.300150] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  542.300155] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  542.300161] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  542.300166] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  542.300171] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  542.300177] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  542.300182] iwlwifi 0000:02:00.0: 0x00447B7B | tsf low
[  542.300188] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  542.300193] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  542.300199] iwlwifi 0000:02:00.0: 0x00447B7C | time gp2
[  542.300205] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  542.300210] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  542.300216] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  542.300221] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  542.300246] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  542.300252] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  542.300259] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  542.300265] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  542.300272] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  542.300278] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  542.300284] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  542.300291] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  542.300297] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  542.300304] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  542.300311] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  542.300317] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  542.300323] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  542.300330] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  542.300337] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  542.300343] iwlwifi 0000:02:00.0: 0x00005860 | flow_handler
[  542.300351] iwlwifi 0000:02:00.0: Fseq Registers:
[  542.300379] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  542.300404] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  542.300429] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  542.300455] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  542.300480] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  542.300505] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  542.300531] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  542.300556] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  542.300581] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  542.300607] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  542.300633] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  542.300658] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  542.300669] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  542.300684] ieee80211 phy0: Hardware restart was requested
[  542.300709] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  542.300716] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  542.300722] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B78
[  542.300795] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  542.300807] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  542.300811] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  542.300844] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  542.300850] Call Trace:
[  542.300871]  dump_stack+0x46/0x5b
[  542.300901]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  542.300917]  ? wait_woken+0x80/0x80
[  542.300939]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  542.300952]  ? __kmalloc_track_caller+0x173/0x1f0
[  542.300982]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  542.301006]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  542.301029]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  542.301056]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  542.301078]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  542.301101]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  542.301113]  process_one_work+0x1d4/0x400
[  542.301122]  worker_thread+0x2d/0x3c0
[  542.301130]  ? set_worker_desc+0xb0/0xb0
[  542.301139]  kthread+0x113/0x130
[  542.301148]  ? kthread_park+0xa0/0xa0
[  542.301160]  ret_from_fork+0x35/0x40
[  542.301177] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  549.179842] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  549.179984] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  549.179989] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  549.179992] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  549.179997] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  549.180001] iwlwifi 0000:02:00.0: 0x000002E0 | trm_hw_status0
[  549.180004] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  549.180008] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  549.180011] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  549.180014] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  549.180017] iwlwifi 0000:02:00.0: 0x00320405 | data1
[  549.180020] iwlwifi 0000:02:00.0: 0x00000033 | data2
[  549.180023] iwlwifi 0000:02:00.0: 0x00000033 | data3
[  549.180026] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  549.180029] iwlwifi 0000:02:00.0: 0x00664BA4 | tsf low
[  549.180032] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  549.180035] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  549.180038] iwlwifi 0000:02:00.0: 0x00664BA4 | time gp2
[  549.180041] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  549.180044] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  549.180047] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  549.180050] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  549.180053] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  549.180056] iwlwifi 0000:02:00.0: 0x00320405 | hcmd
[  549.180059] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  549.180062] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  549.180065] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  549.180068] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  549.180071] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  549.180074] iwlwifi 0000:02:00.0: 0x003101C8 | last cmd Id
[  549.180077] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  549.180080] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  549.180083] iwlwifi 0000:02:00.0: 0x00008020 | l2p_duration
[  549.180086] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  549.180089] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  549.180092] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  549.180095] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  549.180098] iwlwifi 0000:02:00.0: 0x00007080 | flow_handler
[  549.180102] iwlwifi 0000:02:00.0: Fseq Registers:
[  549.180125] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  549.180141] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  549.180157] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  549.180173] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  549.180188] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  549.180204] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  549.180220] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  549.180236] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  549.180252] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  549.180268] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  549.180284] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  549.180300] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  549.180321] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  549.180330] ieee80211 phy0: Hardware restart was requested
[  549.180349] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  549.180353] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0032 service 0x00000005
[  549.180357] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000664BA1
[  549.180400] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  549.180409] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  549.180412] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  549.180441] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  549.180446] Call Trace:
[  549.180464]  dump_stack+0x46/0x5b
[  549.180485]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  549.180497]  ? wait_woken+0x80/0x80
[  549.180510]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  549.180520]  ? __kmalloc_track_caller+0x173/0x1f0
[  549.180539]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  549.180553]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  549.180568]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  549.180584]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  549.180596]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  549.180610]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  549.180620]  process_one_work+0x1d4/0x400
[  549.180626]  worker_thread+0x2d/0x3c0
[  549.180632]  ? set_worker_desc+0xb0/0xb0
[  549.180638]  kthread+0x113/0x130
[  549.180644]  ? kthread_park+0xa0/0xa0
[  549.180653]  ret_from_fork+0x35/0x40
[  549.180665] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  549.180707] ------------[ cut here ]------------
[  549.180823] WARNING: CPU: 0 PID: 38 at net/mac80211/scan.c:395 __ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  549.180826] Modules linked in: ipv6 fuse joydev uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic coretemp hwmon x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel i2c_dev i915 ghash_clmulni_intel snd_hda_intel snd_hda_codec intel_gtt i2c_algo_bit aesni_intel snd_hwdep iosf_mbi snd_hda_core iwlmvm aes_x86_64 drm_kms_helper snd_pcm glue_helper syscopyarea crypto_simd sysfillrect sysimgblt mac80211 fb_sys_fops psmouse evdev serio_raw drm snd_timer libarc4 i2c_i801 r8168(O) agpgart snd iwlwifi xhci_pci soundcore xhci_hcd intel_pch_thermal thermal wmi battery video ac acpi_pad button loop
[  549.180926] CPU: 0 PID: 38 Comm: kworker/u8:1 Tainted: G        W  O      5.3.0-rc4-slk #1
[  549.180930] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  549.180970] Workqueue: phy0 ieee80211_scan_work [mac80211]
[  549.181003] RIP: 0010:__ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  549.181009] Code: 58 9f 57 c0 e8 fd 36 ba e2 0f 0b 48 83 bd 70 11 00 00 00 bb 01 00 00 00 0f 85 f1 fe ff ff 48 c7 c7 58 9f 57 c0 e8 dc 36 ba e2 <0f> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 83 c4 08 48
[  549.181013] RSP: 0018:ffff956c80193e08 EFLAGS: 00010286
[  549.181018] RAX: 0000000000000024 RBX: 0000000000000001 RCX: 0000000000000000
[  549.181021] RDX: 0000000000000000 RSI: ffff8a270ea163e8 RDI: ffff8a270ea163e8
[  549.181024] RBP: ffff8a2707d207a0 R08: 0000000000001e13 R09: 0000000000000003
[  549.181027] R10: ffffffffa3e03e40 R11: 0000000000000001 R12: 0000000000000000
[  549.181030] R13: 0000000000000008 R14: ffff8a270b49c000 R15: 000000000000000b
[  549.181035] FS:  0000000000000000(0000) GS:ffff8a270ea00000(0000) knlGS:0000000000000000
[  549.181038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  549.181041] CR2: 00007f9b5de29118 CR3: 0000000351e0a001 CR4: 00000000003606f0
[  549.181044] Call Trace:
[  549.181061]  ? __switch_to_asm+0x34/0x70
[  549.181087]  ieee80211_scan_work+0x6a/0x4d0 [mac80211]
[  549.181096]  process_one_work+0x1d4/0x400
[  549.181103]  worker_thread+0x2d/0x3c0
[  549.181108]  ? set_worker_desc+0xb0/0xb0
[  549.181115]  kthread+0x113/0x130
[  549.181121]  ? kthread_park+0xa0/0xa0
[  549.181129]  ret_from_fork+0x35/0x40
[  549.181137] ---[ end trace 72a91023015a97b4 ]---
[  553.847624] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  553.847753] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  553.847757] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  553.847761] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  553.847765] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  553.847768] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  553.847771] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  553.847773] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  553.847776] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  553.847779] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  553.847781] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  553.847784] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  553.847786] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  553.847789] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  553.847791] iwlwifi 0000:02:00.0: 0x00447B4B | tsf low
[  553.847794] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  553.847796] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  553.847799] iwlwifi 0000:02:00.0: 0x00447B4C | time gp2
[  553.847802] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  553.847804] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  553.847807] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  553.847810] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  553.847812] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  553.847815] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  553.847817] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  553.847820] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  553.847823] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  553.847825] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  553.847828] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  553.847830] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  553.847833] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  553.847836] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  553.847839] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  553.847841] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  553.847844] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  553.847846] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  553.847849] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  553.847851] iwlwifi 0000:02:00.0: 0x00005860 | flow_handler
[  553.847855] iwlwifi 0000:02:00.0: Fseq Registers:
[  553.847878] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  553.847893] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  553.847909] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  553.847925] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  553.847941] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  553.847957] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  553.847973] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  553.847989] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  553.848005] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  553.848021] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  553.848037] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  553.848053] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  553.848059] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  553.848069] ieee80211 phy0: Hardware restart was requested
[  553.848084] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  553.848088] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  553.848091] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B48
[  553.848144] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  553.848151] CPU: 1 PID: 138 Comm: kworker/1:2 Tainted: G        W  O      5.3.0-rc4-slk #1
[  553.848154] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  553.848172] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  553.848176] Call Trace:
[  553.848189]  dump_stack+0x46/0x5b
[  553.848207]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  553.848217]  ? wait_woken+0x80/0x80
[  553.848229]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  553.848246]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  553.848257]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  553.848269]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  553.848282]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  553.848291]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  553.848301]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  553.848308]  process_one_work+0x1d4/0x400
[  553.848313]  worker_thread+0x2d/0x3c0
[  553.848317]  ? set_worker_desc+0xb0/0xb0
[  553.848322]  kthread+0x113/0x130
[  553.848328]  ? kthread_park+0xa0/0xa0
[  553.848335]  ret_from_fork+0x35/0x40
[  553.848343] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  558.511652] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  558.511794] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  558.511800] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  558.511805] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  558.511811] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  558.511815] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  558.511819] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  558.511822] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  558.511826] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  558.511830] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  558.511834] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  558.511838] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  558.511841] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  558.511845] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  558.511848] iwlwifi 0000:02:00.0: 0x00447BBD | tsf low
[  558.511852] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  558.511856] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  558.511860] iwlwifi 0000:02:00.0: 0x00447BBE | time gp2
[  558.511864] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  558.511868] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  558.511872] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  558.511876] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  558.511879] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  558.511883] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  558.511887] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  558.511890] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  558.511894] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  558.511897] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  558.511901] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  558.511904] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  558.511908] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  558.511912] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  558.511915] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  558.511919] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  558.511922] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  558.511926] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  558.511929] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  558.511933] iwlwifi 0000:02:00.0: 0x00005868 | flow_handler
[  558.511938] iwlwifi 0000:02:00.0: Fseq Registers:
[  558.511961] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  558.511978] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  558.511994] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  558.512010] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  558.512027] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  558.512043] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  558.512059] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  558.512075] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  558.512092] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  558.512108] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  558.512124] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  558.512141] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  558.512149] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  558.512163] ieee80211 phy0: Hardware restart was requested
[  558.512183] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  558.512188] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  558.512193] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447BBA
[  558.512261] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  558.512270] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  558.512273] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  558.512299] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  558.512303] Call Trace:
[  558.512320]  dump_stack+0x46/0x5b
[  558.512345]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  558.512358]  ? wait_woken+0x80/0x80
[  558.512373]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  558.512396]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  558.512411]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  558.512428]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  558.512446]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  558.512460]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  558.512474]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  558.512483]  process_one_work+0x1d4/0x400
[  558.512489]  worker_thread+0x2d/0x3c0
[  558.512496]  ? set_worker_desc+0xb0/0xb0
[  558.512502]  kthread+0x113/0x130
[  558.512510]  ? kthread_park+0xa0/0xa0
[  558.512520]  ret_from_fork+0x35/0x40
[  558.512531] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  563.175644] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  563.175786] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  563.175792] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  563.175797] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  563.175803] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  563.175807] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  563.175810] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  563.175814] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  563.175818] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  563.175822] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  563.175825] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  563.175829] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  563.175833] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  563.175836] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  563.175840] iwlwifi 0000:02:00.0: 0x00447BD5 | tsf low
[  563.175844] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  563.175847] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  563.175851] iwlwifi 0000:02:00.0: 0x00447BD6 | time gp2
[  563.175854] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  563.175858] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  563.175862] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  563.175865] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  563.175869] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  563.175872] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  563.175876] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  563.175879] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[  563.175883] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  563.175886] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  563.175890] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  563.175893] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  563.175897] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  563.175901] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  563.175904] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  563.175908] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  563.175911] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  563.175915] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  563.175918] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  563.175922] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  563.175927] iwlwifi 0000:02:00.0: Fseq Registers:
[  563.175950] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  563.175967] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  563.175983] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  563.175999] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  563.176015] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  563.176032] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  563.176048] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  563.176063] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  563.176080] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  563.176096] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  563.176112] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  563.176129] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  563.176137] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  563.176150] ieee80211 phy0: Hardware restart was requested
[  563.176170] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  563.176174] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  563.176179] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447BD2
[  563.176247] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  563.176255] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  563.176258] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  563.176284] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  563.176289] Call Trace:
[  563.176306]  dump_stack+0x46/0x5b
[  563.176330]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  563.176344]  ? wait_woken+0x80/0x80
[  563.176359]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  563.176383]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  563.176398]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  563.176415]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  563.176433]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  563.176446]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  563.176460]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  563.176469]  process_one_work+0x1d4/0x400
[  563.176475]  worker_thread+0x2d/0x3c0
[  563.176482]  ? set_worker_desc+0xb0/0xb0
[  563.176489]  kthread+0x113/0x130
[  563.176496]  ? kthread_park+0xa0/0xa0
[  563.176506]  ret_from_fork+0x35/0x40
[  563.176517] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  567.838859] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  567.839004] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  567.839012] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  567.839018] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  567.839026] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  567.839032] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  567.839038] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  567.839043] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  567.839049] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  567.839054] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  567.839059] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  567.839065] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  567.839070] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  567.839075] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  567.839080] iwlwifi 0000:02:00.0: 0x00447B7D | tsf low
[  567.839086] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  567.839091] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  567.839096] iwlwifi 0000:02:00.0: 0x00447B7E | time gp2
[  567.839102] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  567.839107] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  567.839113] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  567.839118] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  567.839124] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  567.839129] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  567.839134] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  567.839140] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  567.839145] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  567.839151] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  567.839156] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  567.839161] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  567.839166] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  567.839172] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  567.839177] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  567.839183] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  567.839188] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  567.839194] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  567.839199] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  567.839205] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  567.839212] iwlwifi 0000:02:00.0: Fseq Registers:
[  567.839238] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  567.839262] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  567.839286] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  567.839310] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  567.839334] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  567.839358] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  567.839382] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  567.839405] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  567.839429] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  567.839453] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  567.839477] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  567.839502] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  567.839511] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  567.839524] ieee80211 phy0: Hardware restart was requested
[  567.839546] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  567.839552] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  567.839558] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B7A
[  567.839622] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  567.839632] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  567.839636] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  567.839664] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  567.839669] Call Trace:
[  567.839688]  dump_stack+0x46/0x5b
[  567.839715]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  567.839730]  ? wait_woken+0x80/0x80
[  567.839748]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  567.839775]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  567.839794]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  567.839813]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  567.839836]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  567.839853]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  567.839872]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  567.839883]  process_one_work+0x1d4/0x400
[  567.839891]  worker_thread+0x2d/0x3c0
[  567.839897]  ? set_worker_desc+0xb0/0xb0
[  567.839905]  kthread+0x113/0x130
[  567.839913]  ? kthread_park+0xa0/0xa0
[  567.839923]  ret_from_fork+0x35/0x40
[  567.839936] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  572.501768] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  572.501950] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  572.501959] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  572.501965] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  572.501974] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  572.501979] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  572.501985] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  572.501990] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  572.502007] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  572.502021] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  572.502032] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  572.502042] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  572.502048] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  572.502053] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  572.502059] iwlwifi 0000:02:00.0: 0x00447B71 | tsf low
[  572.502064] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  572.502070] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  572.502077] iwlwifi 0000:02:00.0: 0x00447B72 | time gp2
[  572.502083] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  572.502088] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  572.502093] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  572.502099] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  572.502106] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  572.502111] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  572.502117] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  572.502122] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  572.502128] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  572.502133] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  572.502138] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  572.502143] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  572.502149] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  572.502154] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  572.502160] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  572.502165] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  572.502170] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  572.502176] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  572.502181] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  572.502186] iwlwifi 0000:02:00.0: 0x00005860 | flow_handler
[  572.502194] iwlwifi 0000:02:00.0: Fseq Registers:
[  572.502220] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  572.502244] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  572.502268] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  572.502292] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  572.502316] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  572.502340] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  572.502366] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  572.502403] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  572.502439] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  572.502472] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  572.502509] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  572.502534] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  572.502544] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  572.502557] ieee80211 phy0: Hardware restart was requested
[  572.502580] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  572.502587] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  572.502594] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B6E
[  572.502668] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  572.502678] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  572.502681] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  572.502708] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  572.502713] Call Trace:
[  572.502732]  dump_stack+0x46/0x5b
[  572.502758]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  572.502771]  ? wait_woken+0x80/0x80
[  572.502790]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  572.502818]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  572.502836]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  572.502853]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  572.502874]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  572.502891]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  572.502908]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  572.502919]  process_one_work+0x1d4/0x400
[  572.502925]  worker_thread+0x2d/0x3c0
[  572.502932]  ? set_worker_desc+0xb0/0xb0
[  572.502939]  kthread+0x113/0x130
[  572.502947]  ? kthread_park+0xa0/0xa0
[  572.502958]  ret_from_fork+0x35/0x40
[  572.502971] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  577.165353] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  577.165499] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  577.165507] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  577.165514] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  577.165522] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  577.165528] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  577.165535] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  577.165542] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  577.165548] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  577.165554] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  577.165561] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  577.165568] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  577.165574] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  577.165580] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  577.165587] iwlwifi 0000:02:00.0: 0x00447B9B | tsf low
[  577.165593] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  577.165599] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  577.165606] iwlwifi 0000:02:00.0: 0x00447B9C | time gp2
[  577.165613] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  577.165620] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  577.165626] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  577.165633] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  577.165640] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  577.165645] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  577.165652] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  577.165658] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  577.165664] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  577.165670] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  577.165677] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  577.165684] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  577.165690] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  577.165697] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  577.165704] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  577.165710] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  577.165716] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  577.165723] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  577.165730] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  577.165736] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  577.165744] iwlwifi 0000:02:00.0: Fseq Registers:
[  577.165772] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  577.165798] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  577.165823] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  577.165847] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  577.165872] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  577.165897] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  577.165921] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  577.165945] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  577.165969] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  577.165996] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  577.166021] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  577.166047] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  577.166100] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  577.166124] ieee80211 phy0: Hardware restart was requested
[  577.166158] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  577.166172] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  577.166187] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B98
[  577.166230] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  577.166247] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  577.166256] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  577.166292] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  577.166298] Call Trace:
[  577.166319]  dump_stack+0x46/0x5b
[  577.166367]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  577.166381]  ? wait_woken+0x80/0x80
[  577.166397]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  577.166425]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  577.166444]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  577.166464]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  577.166486]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  577.166504]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  577.166523]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  577.166533]  process_one_work+0x1d4/0x400
[  577.166541]  worker_thread+0x2d/0x3c0
[  577.166549]  ? set_worker_desc+0xb0/0xb0
[  577.166557]  kthread+0x113/0x130
[  577.166565]  ? kthread_park+0xa0/0xa0
[  577.166576]  ret_from_fork+0x35/0x40
[  577.166590] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  581.833307] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  581.833454] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  581.833462] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  581.833468] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  581.833476] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  581.833482] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  581.833488] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  581.833494] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  581.833499] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  581.833505] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  581.833510] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  581.833516] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  581.833521] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  581.833527] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  581.833533] iwlwifi 0000:02:00.0: 0x00447B77 | tsf low
[  581.833538] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  581.833543] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  581.833548] iwlwifi 0000:02:00.0: 0x00447B78 | time gp2
[  581.833554] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  581.833560] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  581.833565] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  581.833570] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  581.833576] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  581.833581] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  581.833586] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  581.833592] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  581.833597] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  581.833602] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  581.833607] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  581.833612] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  581.833618] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  581.833623] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  581.833629] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  581.833634] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  581.833640] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  581.833645] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  581.833650] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  581.833656] iwlwifi 0000:02:00.0: 0x00005868 | flow_handler
[  581.833662] iwlwifi 0000:02:00.0: Fseq Registers:
[  581.833688] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  581.833712] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  581.833736] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  581.833760] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  581.833783] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  581.833807] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  581.833831] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  581.833855] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  581.833879] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  581.833902] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  581.833921] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  581.833944] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  581.833985] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  581.833997] ieee80211 phy0: Hardware restart was requested
[  581.834020] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  581.834032] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  581.834048] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B74
[  581.834120] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  581.834136] CPU: 1 PID: 138 Comm: kworker/1:2 Tainted: G        W  O      5.3.0-rc4-slk #1
[  581.834145] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  581.834177] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  581.834189] Call Trace:
[  581.834209]  dump_stack+0x46/0x5b
[  581.834236]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  581.834251]  ? wait_woken+0x80/0x80
[  581.834269]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  581.834296]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  581.834315]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  581.834334]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  581.834356]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  581.834374]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  581.834394]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  581.834404]  process_one_work+0x1d4/0x400
[  581.834413]  worker_thread+0x2d/0x3c0
[  581.834420]  ? set_worker_desc+0xb0/0xb0
[  581.834428]  kthread+0x113/0x130
[  581.834436]  ? kthread_park+0xa0/0xa0
[  581.834447]  ret_from_fork+0x35/0x40
[  581.834461] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  586.497682] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  586.497829] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  586.497838] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  586.497845] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  586.497853] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  586.497860] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  586.497867] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  586.497872] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  586.497877] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  586.497883] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  586.497928] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  586.497934] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  586.497939] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  586.497946] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  586.497952] iwlwifi 0000:02:00.0: 0x00447B88 | tsf low
[  586.497959] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  586.497965] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  586.497972] iwlwifi 0000:02:00.0: 0x00447B89 | time gp2
[  586.497986] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  586.498001] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  586.498011] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  586.498025] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  586.498035] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  586.498047] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  586.498060] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  586.498070] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  586.498082] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  586.498092] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  586.498105] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  586.498115] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  586.498121] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  586.498128] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  586.498135] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  586.498141] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  586.498148] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  586.498154] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  586.498161] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  586.498168] iwlwifi 0000:02:00.0: 0x00005860 | flow_handler
[  586.498175] iwlwifi 0000:02:00.0: Fseq Registers:
[  586.498203] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  586.498228] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  586.498253] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  586.498278] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  586.498303] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  586.498329] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  586.498354] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  586.498379] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  586.498403] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  586.498428] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  586.498454] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  586.498479] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  586.498490] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  586.498505] ieee80211 phy0: Hardware restart was requested
[  586.498531] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  586.498538] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  586.498546] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B85
[  586.498630] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  586.498641] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  586.498645] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  586.498678] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  586.498684] Call Trace:
[  586.498706]  dump_stack+0x46/0x5b
[  586.498736]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  586.498752]  ? wait_woken+0x80/0x80
[  586.498774]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  586.498787]  ? __kmalloc_track_caller+0x173/0x1f0
[  586.498817]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  586.498840]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  586.498864]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  586.498890]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  586.498913]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  586.498936]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  586.498948]  process_one_work+0x1d4/0x400
[  586.498958]  worker_thread+0x2d/0x3c0
[  586.498967]  ? set_worker_desc+0xb0/0xb0
[  586.498976]  kthread+0x113/0x130
[  586.498986]  ? kthread_park+0xa0/0xa0
[  586.498998]  ret_from_fork+0x35/0x40
[  586.499014] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  591.161299] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  591.161444] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  591.161453] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  591.161459] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  591.161467] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  591.161473] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  591.161479] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  591.161485] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  591.161490] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  591.161495] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  591.161501] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  591.161506] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  591.161511] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  591.161516] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  591.161522] iwlwifi 0000:02:00.0: 0x00447B6B | tsf low
[  591.161527] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  591.161532] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  591.161537] iwlwifi 0000:02:00.0: 0x00447B6C | time gp2
[  591.161543] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  591.161548] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  591.161553] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  591.161559] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  591.161565] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  591.161570] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  591.161575] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  591.161581] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  591.161586] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  591.161591] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  591.161596] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  591.161603] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  591.161608] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  591.161613] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  591.161619] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  591.161624] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  591.161630] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  591.161635] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  591.161641] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  591.161646] iwlwifi 0000:02:00.0: 0x00005860 | flow_handler
[  591.161653] iwlwifi 0000:02:00.0: Fseq Registers:
[  591.161679] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  591.161703] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  591.161727] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  591.161752] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  591.161776] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  591.161800] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  591.161824] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  591.161848] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  591.161872] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  591.161894] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  591.161913] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  591.161938] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  591.161981] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  591.161990] ieee80211 phy0: Hardware restart was requested
[  591.162013] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  591.162019] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  591.162035] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B68
[  591.162114] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  591.162129] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  591.162138] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  591.162169] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  591.162174] Call Trace:
[  591.162194]  dump_stack+0x46/0x5b
[  591.162220]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  591.162234]  ? wait_woken+0x80/0x80
[  591.162252]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  591.162280]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  591.162300]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  591.162320]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  591.162343]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  591.162360]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  591.162379]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  591.162390]  process_one_work+0x1d4/0x400
[  591.162417]  worker_thread+0x2d/0x3c0
[  591.162424]  ? set_worker_desc+0xb0/0xb0
[  591.162432]  kthread+0x113/0x130
[  591.162442]  ? kthread_park+0xa0/0xa0
[  591.162454]  ret_from_fork+0x35/0x40
[  591.162471] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  591.162513] iwlwifi 0000:02:00.0: Firmware not running - cannot dump error
[  595.723748] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  595.723912] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  595.723920] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  595.723925] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  595.723932] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  595.723938] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  595.723943] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  595.723947] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  595.723952] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  595.723956] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  595.723961] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  595.723966] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  595.723970] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  595.723975] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  595.723980] iwlwifi 0000:02:00.0: 0x00447B25 | tsf low
[  595.723985] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  595.723990] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  595.723996] iwlwifi 0000:02:00.0: 0x00447B26 | time gp2
[  595.724001] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  595.724006] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  595.724012] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  595.724018] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  595.724023] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  595.724028] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  595.724034] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  595.724039] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  595.724044] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  595.724050] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  595.724055] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  595.724061] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  595.724066] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  595.724072] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  595.724077] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  595.724082] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  595.724087] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  595.724093] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  595.724098] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  595.724104] iwlwifi 0000:02:00.0: 0x00005860 | flow_handler
[  595.724111] iwlwifi 0000:02:00.0: Fseq Registers:
[  595.724138] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  595.724162] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  595.724186] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  595.724210] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  595.724233] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  595.724251] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  595.724275] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  595.724298] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  595.724322] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  595.724346] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  595.724370] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  595.724394] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  595.724403] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  595.724417] ieee80211 phy0: Hardware restart was requested
[  595.724440] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  595.724447] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  595.724454] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B22
[  595.724517] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  595.724528] CPU: 1 PID: 138 Comm: kworker/1:2 Tainted: G        W  O      5.3.0-rc4-slk #1
[  595.724532] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  595.724559] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  595.724564] Call Trace:
[  595.724583]  dump_stack+0x46/0x5b
[  595.724607]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  595.724621]  ? wait_woken+0x80/0x80
[  595.724639]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  595.724667]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  595.724687]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  595.724707]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  595.724729]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  595.724747]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  595.724765]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  595.724775]  process_one_work+0x1d4/0x400
[  595.724783]  worker_thread+0x2d/0x3c0
[  595.724791]  ? set_worker_desc+0xb0/0xb0
[  595.724798]  kthread+0x113/0x130
[  595.724806]  ? kthread_park+0xa0/0xa0
[  595.724818]  ret_from_fork+0x35/0x40
[  595.724833] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  600.385701] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  600.385846] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  600.385855] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  600.385861] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  600.385869] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  600.385874] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  600.385880] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  600.385885] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  600.385918] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  600.385923] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  600.385929] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  600.385935] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  600.385940] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  600.385945] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  600.385951] iwlwifi 0000:02:00.0: 0x00447B3E | tsf low
[  600.385957] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  600.385963] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  600.385969] iwlwifi 0000:02:00.0: 0x00447B3F | time gp2
[  600.385984] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  600.385997] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  600.386009] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  600.386020] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  600.386030] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  600.386043] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  600.386052] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  600.386061] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  600.386066] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  600.386072] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  600.386077] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  600.386082] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  600.386087] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  600.386093] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  600.386098] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  600.386104] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  600.386109] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  600.386114] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  600.386120] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  600.386126] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  600.386132] iwlwifi 0000:02:00.0: Fseq Registers:
[  600.386158] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  600.386183] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  600.386206] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  600.386230] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  600.386254] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  600.386278] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  600.386302] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  600.386325] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  600.386349] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  600.386373] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  600.386396] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  600.386413] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  600.386422] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  600.386434] ieee80211 phy0: Hardware restart was requested
[  600.386456] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  600.386462] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  600.386468] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B3B
[  600.386541] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  600.386551] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  600.386555] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  600.386582] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  600.386587] Call Trace:
[  600.386605]  dump_stack+0x46/0x5b
[  600.386631]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  600.386645]  ? wait_woken+0x80/0x80
[  600.386664]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  600.386691]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  600.386710]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  600.386730]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  600.386751]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  600.386768]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  600.386786]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  600.386796]  process_one_work+0x1d4/0x400
[  600.386803]  worker_thread+0x2d/0x3c0
[  600.386810]  ? set_worker_desc+0xb0/0xb0
[  600.386818]  kthread+0x113/0x130
[  600.386825]  ? kthread_park+0xa0/0xa0
[  600.386835]  ret_from_fork+0x35/0x40
[  600.386876] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  605.049203] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  605.049344] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  605.049349] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  605.049352] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  605.049357] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  605.049360] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  605.049364] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  605.049367] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  605.049370] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  605.049373] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  605.049376] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  605.049379] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  605.049382] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  605.049385] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  605.049388] iwlwifi 0000:02:00.0: 0x00447BA5 | tsf low
[  605.049391] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  605.049394] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  605.049397] iwlwifi 0000:02:00.0: 0x00447BA6 | time gp2
[  605.049400] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  605.049403] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  605.049406] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  605.049409] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  605.049412] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  605.049415] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  605.049418] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  605.049421] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[  605.049424] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  605.049427] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  605.049430] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  605.049433] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  605.049436] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  605.049439] iwlwifi 0000:02:00.0: 0x000000C4 | l2p_control
[  605.049442] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  605.049445] iwlwifi 0000:02:00.0: 0x00000007 | l2p_mhvalid
[  605.049448] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  605.049451] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  605.049455] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  605.049458] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  605.049461] iwlwifi 0000:02:00.0: Fseq Registers:
[  605.049484] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  605.049500] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  605.049516] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  605.049532] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  605.049548] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  605.049564] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  605.049580] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  605.049595] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  605.049612] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  605.049627] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  605.049643] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  605.049660] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  605.049667] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  605.049679] ieee80211 phy0: Hardware restart was requested
[  605.049697] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  605.049701] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  605.049704] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447BA2
[  605.049766] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  605.049773] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  605.049776] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  605.049799] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  605.049803] Call Trace:
[  605.049818]  dump_stack+0x46/0x5b
[  605.049838]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  605.049851]  ? wait_woken+0x80/0x80
[  605.049863]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  605.049872]  ? __kmalloc_track_caller+0x173/0x1f0
[  605.049891]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  605.049904]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  605.049923]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  605.049944]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  605.049961]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  605.049978]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  605.049988]  process_one_work+0x1d4/0x400
[  605.049995]  worker_thread+0x2d/0x3c0
[  605.050002]  ? set_worker_desc+0xb0/0xb0
[  605.050009]  kthread+0x113/0x130
[  605.050017]  ? kthread_park+0xa0/0xa0
[  605.050028]  ret_from_fork+0x35/0x40
[  605.050079] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  612.054162] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  612.054305] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  612.054311] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  612.054316] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  612.054322] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  612.054326] iwlwifi 0000:02:00.0: 0x000002A0 | trm_hw_status0
[  612.054330] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  612.054334] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  612.054338] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  612.054341] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  612.054345] iwlwifi 0000:02:00.0: 0x00320405 | data1
[  612.054349] iwlwifi 0000:02:00.0: 0x00000033 | data2
[  612.054352] iwlwifi 0000:02:00.0: 0x00000033 | data3
[  612.054356] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  612.054359] iwlwifi 0000:02:00.0: 0x00683BFB | tsf low
[  612.054363] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  612.054367] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  612.054370] iwlwifi 0000:02:00.0: 0x00683BFB | time gp2
[  612.054374] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  612.054378] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  612.054381] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  612.054385] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  612.054389] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  612.054393] iwlwifi 0000:02:00.0: 0x00320405 | hcmd
[  612.054397] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  612.054400] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[  612.054404] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  612.054407] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  612.054411] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  612.054415] iwlwifi 0000:02:00.0: 0x003101C8 | last cmd Id
[  612.054418] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  612.054422] iwlwifi 0000:02:00.0: 0x00000850 | l2p_control
[  612.054426] iwlwifi 0000:02:00.0: 0x00018020 | l2p_duration
[  612.054429] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  612.054433] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  612.054437] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  612.054440] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  612.054444] iwlwifi 0000:02:00.0: 0x00007888 | flow_handler
[  612.054448] iwlwifi 0000:02:00.0: Fseq Registers:
[  612.054470] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  612.054487] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  612.054503] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  612.054519] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  612.054535] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  612.054551] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  612.054567] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  612.054584] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  612.054600] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  612.054616] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  612.054633] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  612.054649] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  612.054671] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  612.054682] ieee80211 phy0: Hardware restart was requested
[  612.054703] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  612.054707] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0032 service 0x00000005
[  612.054712] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000683BF8
[  612.054763] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  612.054771] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  612.054774] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  612.054802] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  612.054806] Call Trace:
[  612.054824]  dump_stack+0x46/0x5b
[  612.054851]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  612.054865]  ? wait_woken+0x80/0x80
[  612.054881]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  612.054908]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  612.054924]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  612.054943]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  612.054961]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  612.054976]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  612.054991]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  612.055000]  process_one_work+0x1d4/0x400
[  612.055008]  worker_thread+0x2d/0x3c0
[  612.055015]  ? set_worker_desc+0xb0/0xb0
[  612.055023]  kthread+0x113/0x130
[  612.055031]  ? kthread_park+0xa0/0xa0
[  612.055042]  ret_from_fork+0x35/0x40
[  612.055054] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  612.055101] ------------[ cut here ]------------
[  612.055228] WARNING: CPU: 0 PID: 38 at net/mac80211/scan.c:395 __ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  612.055232] Modules linked in: ipv6 fuse joydev uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic coretemp hwmon x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel i2c_dev i915 ghash_clmulni_intel snd_hda_intel snd_hda_codec intel_gtt i2c_algo_bit aesni_intel snd_hwdep iosf_mbi snd_hda_core iwlmvm aes_x86_64 drm_kms_helper snd_pcm glue_helper syscopyarea crypto_simd sysfillrect sysimgblt mac80211 fb_sys_fops psmouse evdev serio_raw drm snd_timer libarc4 i2c_i801 r8168(O) agpgart snd iwlwifi xhci_pci soundcore xhci_hcd intel_pch_thermal thermal wmi battery video ac acpi_pad button loop
[  612.055349] CPU: 0 PID: 38 Comm: kworker/u8:1 Tainted: G        W  O      5.3.0-rc4-slk #1
[  612.055354] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  612.055401] Workqueue: phy0 ieee80211_scan_work [mac80211]
[  612.055444] RIP: 0010:__ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  612.055452] Code: 58 9f 57 c0 e8 fd 36 ba e2 0f 0b 48 83 bd 70 11 00 00 00 bb 01 00 00 00 0f 85 f1 fe ff ff 48 c7 c7 58 9f 57 c0 e8 dc 36 ba e2 <0f> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 83 c4 08 48
[  612.055457] RSP: 0018:ffff956c80193e08 EFLAGS: 00010286
[  612.055462] RAX: 0000000000000024 RBX: 0000000000000001 RCX: 0000000000000000
[  612.055466] RDX: 0000000000000000 RSI: ffff8a270ea163e8 RDI: ffff8a270ea163e8
[  612.055470] RBP: ffff8a2707d207a0 R08: 0000000000002227 R09: 0000000000000003
[  612.055474] R10: ffffffffa3e03e40 R11: 0000000000000001 R12: 0000000000000000
[  612.055477] R13: 0000000000000008 R14: ffff8a270b49c000 R15: 0000000000000009
[  612.055482] FS:  0000000000000000(0000) GS:ffff8a270ea00000(0000) knlGS:0000000000000000
[  612.055487] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  612.055491] CR2: 0000000000b9c000 CR3: 0000000351e0a003 CR4: 00000000003606f0
[  612.055493] Call Trace:
[  612.055512]  ? __switch_to_asm+0x34/0x70
[  612.055544]  ieee80211_scan_work+0x6a/0x4d0 [mac80211]
[  612.055555]  process_one_work+0x1d4/0x400
[  612.055563]  worker_thread+0x2d/0x3c0
[  612.055569]  ? set_worker_desc+0xb0/0xb0
[  612.055577]  kthread+0x113/0x130
[  612.055585]  ? kthread_park+0xa0/0xa0
[  612.055594]  ret_from_fork+0x35/0x40
[  612.055602] ---[ end trace 72a91023015a97b5 ]---
[  616.717566] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  616.717708] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  616.717714] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  616.717719] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  616.717724] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  616.717728] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  616.717733] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  616.717736] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  616.717740] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  616.717744] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  616.717748] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  616.717752] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  616.717756] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  616.717759] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  616.717763] iwlwifi 0000:02:00.0: 0x00447B37 | tsf low
[  616.717766] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  616.717770] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  616.717773] iwlwifi 0000:02:00.0: 0x00447B38 | time gp2
[  616.717777] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  616.717781] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  616.717784] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  616.717788] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  616.717792] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  616.717795] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  616.717799] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  616.717802] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  616.717806] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  616.717809] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  616.717812] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  616.717816] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  616.717820] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  616.717823] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  616.717827] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  616.717830] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  616.717834] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  616.717837] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  616.717841] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  616.717845] iwlwifi 0000:02:00.0: 0x00005860 | flow_handler
[  616.717849] iwlwifi 0000:02:00.0: Fseq Registers:
[  616.717873] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  616.717890] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  616.717907] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  616.717923] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  616.717940] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  616.717957] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  616.717973] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  616.717989] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  616.718005] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  616.718021] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  616.718038] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  616.718054] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  616.718101] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  616.718122] ieee80211 phy0: Hardware restart was requested
[  616.718154] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  616.718165] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  616.718175] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B34
[  616.718251] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  616.718265] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  616.718277] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  616.718309] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  616.718324] Call Trace:
[  616.718348]  dump_stack+0x46/0x5b
[  616.718377]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  616.718393]  ? wait_woken+0x80/0x80
[  616.718415]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  616.718446]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  616.718468]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  616.718494]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  616.718523]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  616.718546]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  616.718571]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  616.718584]  process_one_work+0x1d4/0x400
[  616.718595]  worker_thread+0x2d/0x3c0
[  616.718605]  ? set_worker_desc+0xb0/0xb0
[  616.718615]  kthread+0x113/0x130
[  616.718625]  ? kthread_park+0xa0/0xa0
[  616.718640]  ret_from_fork+0x35/0x40
[  616.718658] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  621.379717] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  621.379897] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  621.379905] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  621.379912] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  621.379920] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  621.379926] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  621.379931] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  621.379937] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  621.379942] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  621.379948] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  621.379953] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  621.379959] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  621.379964] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  621.379969] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  621.379975] iwlwifi 0000:02:00.0: 0x00447B2B | tsf low
[  621.379980] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  621.379985] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  621.379990] iwlwifi 0000:02:00.0: 0x00447B2C | time gp2
[  621.379996] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  621.380001] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  621.380007] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  621.380013] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  621.380018] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  621.380024] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  621.380030] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  621.380035] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  621.380040] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  621.380045] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  621.380051] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  621.380056] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  621.380062] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  621.380067] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  621.380072] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  621.380078] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  621.380083] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  621.380089] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  621.380094] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  621.380100] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  621.380106] iwlwifi 0000:02:00.0: Fseq Registers:
[  621.380133] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  621.380157] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  621.380181] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  621.380205] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  621.380229] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  621.380253] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  621.380276] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  621.380300] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  621.380324] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  621.380349] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  621.380373] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  621.380397] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  621.380407] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  621.380422] ieee80211 phy0: Hardware restart was requested
[  621.380444] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  621.380450] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  621.380457] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B28
[  621.380517] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  621.380527] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  621.380530] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  621.380557] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  621.380562] Call Trace:
[  621.380581]  dump_stack+0x46/0x5b
[  621.380606]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  621.380620]  ? wait_woken+0x80/0x80
[  621.380638]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  621.380666]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  621.380685]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  621.380705]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  621.380727]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  621.380745]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  621.380764]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  621.380775]  process_one_work+0x1d4/0x400
[  621.380783]  worker_thread+0x2d/0x3c0
[  621.380790]  ? set_worker_desc+0xb0/0xb0
[  621.380798]  kthread+0x113/0x130
[  621.380807]  ? kthread_park+0xa0/0xa0
[  621.380818]  ret_from_fork+0x35/0x40
[  621.380831] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  626.041690] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  626.041859] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  626.041869] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  626.041876] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  626.041886] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  626.041940] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  626.041946] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  626.041953] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  626.041959] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  626.041965] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  626.041971] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  626.041978] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  626.041996] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  626.042012] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  626.042028] iwlwifi 0000:02:00.0: 0x00447B8A | tsf low
[  626.042040] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  626.042052] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  626.042064] iwlwifi 0000:02:00.0: 0x00447B8B | time gp2
[  626.042072] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  626.042079] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  626.042085] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  626.042092] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  626.042098] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  626.042105] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  626.042111] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  626.042117] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[  626.042124] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  626.042130] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  626.042136] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  626.042142] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  626.042149] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  626.042155] iwlwifi 0000:02:00.0: 0x00000094 | l2p_control
[  626.042161] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  626.042168] iwlwifi 0000:02:00.0: 0x0000000F | l2p_mhvalid
[  626.042174] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  626.042180] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  626.042187] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  626.042193] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  626.042201] iwlwifi 0000:02:00.0: Fseq Registers:
[  626.042228] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  626.042254] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  626.042279] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  626.042304] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  626.042329] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  626.042355] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  626.042380] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  626.042405] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  626.042431] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  626.042456] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  626.042481] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  626.042507] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  626.042518] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  626.042532] ieee80211 phy0: Hardware restart was requested
[  626.042558] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  626.042565] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  626.042574] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B87
[  626.042655] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  626.042680] CPU: 1 PID: 138 Comm: kworker/1:2 Tainted: G        W  O      5.3.0-rc4-slk #1
[  626.042694] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  626.042738] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  626.042757] Call Trace:
[  626.042785]  dump_stack+0x46/0x5b
[  626.042830]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  626.042853]  ? wait_woken+0x80/0x80
[  626.042884]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  626.042919]  ? iwl_parse_nvm_mcc_info+0x96/0x400 [iwlwifi]
[  626.042960]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  626.042996]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  626.043028]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  626.043054]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  626.043074]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  626.043095]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  626.043107]  process_one_work+0x1d4/0x400
[  626.043116]  worker_thread+0x2d/0x3c0
[  626.043124]  ? set_worker_desc+0xb0/0xb0
[  626.043132]  kthread+0x113/0x130
[  626.043141]  ? kthread_park+0xa0/0xa0
[  626.043151]  ret_from_fork+0x35/0x40
[  626.043165] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  630.706760] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  630.706933] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  630.706942] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  630.706949] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  630.706957] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  630.706964] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  630.706971] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  630.706978] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  630.706983] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  630.706989] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  630.706997] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  630.707002] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  630.707007] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  630.707013] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  630.707018] iwlwifi 0000:02:00.0: 0x00447B83 | tsf low
[  630.707023] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  630.707032] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  630.707037] iwlwifi 0000:02:00.0: 0x00447B84 | time gp2
[  630.707044] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  630.707051] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  630.707057] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  630.707064] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  630.707070] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  630.707076] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  630.707083] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  630.707089] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  630.707095] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  630.707102] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  630.707108] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  630.707115] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  630.707121] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  630.707128] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  630.707134] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  630.707140] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  630.707146] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  630.707152] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  630.707159] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  630.707165] iwlwifi 0000:02:00.0: 0x00006068 | flow_handler
[  630.707173] iwlwifi 0000:02:00.0: Fseq Registers:
[  630.707201] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  630.707227] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  630.707252] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  630.707278] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  630.707304] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  630.707329] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  630.707354] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  630.707380] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  630.707405] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  630.707430] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  630.707456] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  630.707481] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  630.707492] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  630.707507] ieee80211 phy0: Hardware restart was requested
[  630.707533] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  630.707541] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  630.707549] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B80
[  630.707629] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  630.707641] CPU: 1 PID: 138 Comm: kworker/1:2 Tainted: G        W  O      5.3.0-rc4-slk #1
[  630.707645] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  630.707676] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  630.707682] Call Trace:
[  630.707702]  dump_stack+0x46/0x5b
[  630.707732]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  630.707748]  ? wait_woken+0x80/0x80
[  630.707770]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  630.707803]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  630.707826]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  630.707850]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  630.707877]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  630.707898]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  630.707919]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  630.707931]  process_one_work+0x1d4/0x400
[  630.707940]  worker_thread+0x2d/0x3c0
[  630.707949]  ? set_worker_desc+0xb0/0xb0
[  630.707958]  kthread+0x113/0x130
[  630.707968]  ? kthread_park+0xa0/0xa0
[  630.707981]  ret_from_fork+0x35/0x40
[  630.707998] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  635.369442] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  635.369587] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  635.369596] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  635.369603] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  635.369611] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  635.369617] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  635.369623] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  635.369628] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  635.369634] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  635.369642] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  635.369648] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  635.369654] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  635.369661] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  635.369668] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  635.369674] iwlwifi 0000:02:00.0: 0x00447B8D | tsf low
[  635.369681] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  635.369687] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  635.369693] iwlwifi 0000:02:00.0: 0x00447B8E | time gp2
[  635.369700] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  635.369707] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  635.369714] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  635.369720] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  635.369727] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  635.369733] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  635.369739] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  635.369746] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[  635.369752] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  635.369758] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  635.369764] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  635.369770] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  635.369777] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  635.369784] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  635.369790] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  635.369797] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  635.369803] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  635.369809] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  635.369815] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  635.369823] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  635.369831] iwlwifi 0000:02:00.0: Fseq Registers:
[  635.369858] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  635.369884] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  635.369908] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  635.369934] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  635.369960] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  635.369985] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  635.370010] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  635.370035] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  635.370060] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  635.370086] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  635.370111] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  635.370137] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  635.370179] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  635.370192] ieee80211 phy0: Hardware restart was requested
[  635.370220] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  635.370228] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  635.370246] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B8A
[  635.370333] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  635.370353] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  635.370367] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  635.370404] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  635.370426] Call Trace:
[  635.370457]  dump_stack+0x46/0x5b
[  635.370487]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  635.370504]  ? wait_woken+0x80/0x80
[  635.370526]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  635.370550]  ? iwl_parse_nvm_mcc_info+0x96/0x400 [iwlwifi]
[  635.370579]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  635.370601]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  635.370624]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  635.370651]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  635.370672]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  635.370694]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  635.370706]  process_one_work+0x1d4/0x400
[  635.370715]  worker_thread+0x2d/0x3c0
[  635.370724]  ? set_worker_desc+0xb0/0xb0
[  635.370733]  kthread+0x113/0x130
[  635.370742]  ? kthread_park+0xa0/0xa0
[  635.370755]  ret_from_fork+0x35/0x40
[  635.370771] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  640.033360] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  640.033522] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  640.033531] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  640.033538] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  640.033548] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  640.033555] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  640.033562] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  640.033568] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  640.033575] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  640.033581] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  640.033587] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  640.033593] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  640.033598] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  640.033603] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  640.033609] iwlwifi 0000:02:00.0: 0x00447B81 | tsf low
[  640.033614] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  640.033619] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  640.033625] iwlwifi 0000:02:00.0: 0x00447B82 | time gp2
[  640.033631] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  640.033637] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  640.033644] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  640.033651] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  640.033658] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  640.033664] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  640.033671] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  640.033677] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  640.033683] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  640.033690] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  640.033696] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  640.033702] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  640.033709] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  640.033715] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  640.033722] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  640.033728] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  640.033735] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  640.033741] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  640.033748] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  640.033754] iwlwifi 0000:02:00.0: 0x00005860 | flow_handler
[  640.033762] iwlwifi 0000:02:00.0: Fseq Registers:
[  640.033790] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  640.033816] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  640.033841] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  640.033866] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  640.033890] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  640.033915] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  640.033939] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  640.033965] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  640.033990] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  640.034016] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  640.034041] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  640.034066] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  640.034108] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  640.034122] ieee80211 phy0: Hardware restart was requested
[  640.034148] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  640.034156] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  640.034180] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B7E
[  640.034262] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  640.034281] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  640.034291] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  640.034327] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  640.034341] Call Trace:
[  640.034365]  dump_stack+0x46/0x5b
[  640.034394]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  640.034410]  ? wait_woken+0x80/0x80
[  640.034433]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  640.034465]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  640.034488]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  640.034512]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  640.034539]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  640.034561]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  640.034584]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  640.034595]  process_one_work+0x1d4/0x400
[  640.034605]  worker_thread+0x2d/0x3c0
[  640.034614]  ? set_worker_desc+0xb0/0xb0
[  640.034622]  kthread+0x113/0x130
[  640.034633]  ? kthread_park+0xa0/0xa0
[  640.034645]  ret_from_fork+0x35/0x40
[  640.034663] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  644.697170] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  644.697316] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  644.697323] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  644.697329] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  644.697335] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  644.697340] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  644.697345] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  644.697350] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  644.697355] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  644.697360] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  644.697365] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  644.697369] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  644.697374] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  644.697378] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  644.697383] iwlwifi 0000:02:00.0: 0x00447B64 | tsf low
[  644.697388] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  644.697392] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  644.697397] iwlwifi 0000:02:00.0: 0x00447B65 | time gp2
[  644.697402] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  644.697407] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  644.697412] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  644.697416] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  644.697421] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  644.697426] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  644.697430] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  644.697435] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  644.697439] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  644.697444] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  644.697449] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  644.697454] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  644.697459] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  644.697463] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  644.697468] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  644.697473] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  644.697477] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  644.697482] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  644.697487] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  644.697491] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  644.697497] iwlwifi 0000:02:00.0: Fseq Registers:
[  644.697522] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  644.697540] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  644.697558] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  644.697575] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  644.697591] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  644.697608] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  644.697624] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  644.697641] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  644.697658] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  644.697675] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  644.697692] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  644.697710] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  644.697718] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  644.697729] ieee80211 phy0: Hardware restart was requested
[  644.697748] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  644.697754] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  644.697760] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B61
[  644.697819] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  644.697828] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  644.697831] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  644.697854] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  644.697859] Call Trace:
[  644.697875]  dump_stack+0x46/0x5b
[  644.697896]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  644.697908]  ? wait_woken+0x80/0x80
[  644.697923]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  644.697947]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  644.697964]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  644.697980]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  644.698000]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  644.698015]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  644.698032]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  644.698040]  process_one_work+0x1d4/0x400
[  644.698046]  worker_thread+0x2d/0x3c0
[  644.698052]  ? set_worker_desc+0xb0/0xb0
[  644.698058]  kthread+0x113/0x130
[  644.698065]  ? kthread_park+0xa0/0xa0
[  644.698074]  ret_from_fork+0x35/0x40
[  644.698114] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  649.360511] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  649.360669] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  649.360674] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  649.360677] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  649.360682] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  649.360685] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  649.360688] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  649.360692] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  649.360697] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  649.360700] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  649.360703] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  649.360706] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  649.360710] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  649.360712] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  649.360715] iwlwifi 0000:02:00.0: 0x00447B10 | tsf low
[  649.360719] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  649.360721] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  649.360725] iwlwifi 0000:02:00.0: 0x00447B11 | time gp2
[  649.360727] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  649.360731] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  649.360734] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  649.360738] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  649.360741] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  649.360745] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  649.360748] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  649.360753] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  649.360757] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  649.360759] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  649.360762] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  649.360766] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  649.360769] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  649.360772] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  649.360775] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  649.360779] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  649.360782] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  649.360786] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  649.360790] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  649.360794] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  649.360798] iwlwifi 0000:02:00.0: Fseq Registers:
[  649.360822] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  649.360839] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  649.360857] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  649.360874] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  649.360890] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  649.360907] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  649.360925] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  649.360942] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  649.360958] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  649.360974] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  649.360990] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  649.361005] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  649.361011] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  649.361020] ieee80211 phy0: Hardware restart was requested
[  649.361034] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  649.361037] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  649.361040] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B0D
[  649.361084] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  649.361089] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  649.361091] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  649.361107] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  649.361110] Call Trace:
[  649.361121]  dump_stack+0x46/0x5b
[  649.361133]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  649.361139]  ? wait_woken+0x80/0x80
[  649.361147]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  649.361157]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  649.361164]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  649.361172]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  649.361180]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  649.361186]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  649.361193]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  649.361197]  process_one_work+0x1d4/0x400
[  649.361200]  worker_thread+0x2d/0x3c0
[  649.361203]  ? set_worker_desc+0xb0/0xb0
[  649.361206]  kthread+0x113/0x130
[  649.361209]  ? kthread_park+0xa0/0xa0
[  649.361214]  ret_from_fork+0x35/0x40
[  649.361220] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  654.028071] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  654.028242] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  654.028253] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  654.028260] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  654.028269] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  654.028277] iwlwifi 0000:02:00.0: 0x000002B0 | trm_hw_status0
[  654.028283] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  654.028290] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  654.028297] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  654.028304] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  654.028310] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  654.028316] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  654.028322] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  654.028328] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  654.028333] iwlwifi 0000:02:00.0: 0x00447B82 | tsf low
[  654.028338] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  654.028343] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  654.028349] iwlwifi 0000:02:00.0: 0x00447B83 | time gp2
[  654.028355] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  654.028361] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  654.028368] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  654.028374] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  654.028381] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  654.028386] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  654.028392] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  654.028399] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[  654.028405] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  654.028411] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  654.028417] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  654.028424] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  654.028431] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  654.028437] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  654.028443] iwlwifi 0000:02:00.0: 0x00010020 | l2p_duration
[  654.028449] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  654.028456] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  654.028462] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  654.028469] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  654.028475] iwlwifi 0000:02:00.0: 0x00005868 | flow_handler
[  654.028483] iwlwifi 0000:02:00.0: Fseq Registers:
[  654.028510] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  654.028536] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  654.028562] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  654.028587] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  654.028612] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  654.028638] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  654.028663] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  654.028688] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  654.028713] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  654.028739] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  654.028764] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  654.028790] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  654.028801] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  654.028816] ieee80211 phy0: Hardware restart was requested
[  654.028843] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  654.028851] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  654.028859] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B7F
[  654.028931] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  654.028942] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  654.028947] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  654.028979] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  654.028985] Call Trace:
[  654.029006]  dump_stack+0x46/0x5b
[  654.029036]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  654.029053]  ? wait_woken+0x80/0x80
[  654.029073]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  654.029086]  ? __kmalloc_track_caller+0x173/0x1f0
[  654.029115]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  654.029138]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  654.029160]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  654.029186]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  654.029208]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  654.029231]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  654.029243]  process_one_work+0x1d4/0x400
[  654.029253]  worker_thread+0x2d/0x3c0
[  654.029262]  ? set_worker_desc+0xb0/0xb0
[  654.029271]  kthread+0x113/0x130
[  654.029281]  ? kthread_park+0xa0/0xa0
[  654.029294]  ret_from_fork+0x35/0x40
[  654.029309] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  658.691296] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  658.691437] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  658.691443] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  658.691447] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  658.691453] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  658.691457] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  658.691461] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  658.691465] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  658.691469] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  658.691472] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  658.691476] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  658.691480] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  658.691484] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  658.691487] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  658.691491] iwlwifi 0000:02:00.0: 0x00447BC6 | tsf low
[  658.691495] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  658.691498] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  658.691502] iwlwifi 0000:02:00.0: 0x00447BC7 | time gp2
[  658.691506] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  658.691510] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  658.691514] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  658.691517] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  658.691521] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  658.691524] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  658.691528] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  658.691532] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  658.691535] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  658.691538] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  658.691542] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  658.691546] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  658.691549] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  658.691553] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  658.691556] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  658.691560] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  658.691563] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  658.691567] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  658.691571] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  658.691574] iwlwifi 0000:02:00.0: 0x00005868 | flow_handler
[  658.691579] iwlwifi 0000:02:00.0: Fseq Registers:
[  658.691603] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  658.691619] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  658.691635] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  658.691651] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  658.691668] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  658.691684] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  658.691700] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  658.691716] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  658.691732] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  658.691748] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  658.691765] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  658.691782] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  658.691793] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  658.691810] ieee80211 phy0: Hardware restart was requested
[  658.691836] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  658.691842] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  658.691849] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447BC3
[  658.691891] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  658.691901] CPU: 1 PID: 1920 Comm: kworker/1:3 Tainted: G        W  O      5.3.0-rc4-slk #1
[  658.691906] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  658.691937] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  658.691944] Call Trace:
[  658.691965]  dump_stack+0x46/0x5b
[  658.691994]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  658.692010]  ? wait_woken+0x80/0x80
[  658.692031]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  658.692044]  ? __kmalloc_track_caller+0x173/0x1f0
[  658.692074]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  658.692095]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  658.692119]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  658.692145]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  658.692166]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  658.692189]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  658.692200]  process_one_work+0x1d4/0x400
[  658.692209]  worker_thread+0x2d/0x3c0
[  658.692217]  ? set_worker_desc+0xb0/0xb0
[  658.692226]  kthread+0x113/0x130
[  658.692235]  ? kthread_park+0xa0/0xa0
[  658.692247]  ret_from_fork+0x35/0x40
[  658.692262] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  663.363041] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  663.363179] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  663.363185] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  663.363189] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  663.363193] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  663.363197] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[  663.363200] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  663.363203] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  663.363206] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  663.363209] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  663.363213] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  663.363216] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  663.363219] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  663.363222] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  663.363225] iwlwifi 0000:02:00.0: 0x00447BA8 | tsf low
[  663.363228] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  663.363231] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  663.363234] iwlwifi 0000:02:00.0: 0x00447BA9 | time gp2
[  663.363237] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  663.363240] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  663.363243] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  663.363246] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  663.363249] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  663.363252] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  663.363255] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  663.363258] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  663.363261] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  663.363264] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  663.363266] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  663.363270] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  663.363273] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  663.363276] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  663.363279] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[  663.363282] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  663.363285] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  663.363288] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  663.363291] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  663.363294] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  663.363298] iwlwifi 0000:02:00.0: Fseq Registers:
[  663.363321] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  663.363337] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  663.363353] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  663.363369] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  663.363385] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  663.363400] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  663.363418] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  663.363435] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  663.363454] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  663.363477] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  663.363495] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  663.363513] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  663.363522] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  663.363537] ieee80211 phy0: Hardware restart was requested
[  663.363560] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  663.363566] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  663.363573] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447BA5
[  663.363646] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  663.363655] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  663.363659] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  663.363685] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  663.363691] Call Trace:
[  663.363709]  dump_stack+0x46/0x5b
[  663.363735]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  663.363749]  ? wait_woken+0x80/0x80
[  663.363766]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  663.363793]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  663.363810]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  663.363829]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  663.363850]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  663.363868]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  663.363887]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  663.363897]  process_one_work+0x1d4/0x400
[  663.363905]  worker_thread+0x2d/0x3c0
[  663.363911]  ? set_worker_desc+0xb0/0xb0
[  663.363920]  kthread+0x113/0x130
[  663.363927]  ? kthread_park+0xa0/0xa0
[  663.363937]  ret_from_fork+0x35/0x40
[  663.363951] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  668.025647] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  668.025785] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  668.025790] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  668.025794] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  668.025799] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  668.025803] iwlwifi 0000:02:00.0: 0x00000230 | trm_hw_status0
[  668.025806] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  668.025810] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  668.025814] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  668.025818] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  668.025821] iwlwifi 0000:02:00.0: 0x00300405 | data1
[  668.025825] iwlwifi 0000:02:00.0: 0x00000031 | data2
[  668.025828] iwlwifi 0000:02:00.0: 0x00000031 | data3
[  668.025831] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  668.025834] iwlwifi 0000:02:00.0: 0x00447B50 | tsf low
[  668.025837] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  668.025840] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  668.025843] iwlwifi 0000:02:00.0: 0x00447B51 | time gp2
[  668.025846] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  668.025849] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  668.025852] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  668.025855] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  668.025858] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  668.025861] iwlwifi 0000:02:00.0: 0x00300405 | hcmd
[  668.025864] iwlwifi 0000:02:00.0: 0x24022080 | isr0
[  668.025867] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  668.025870] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  668.025873] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  668.025875] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  668.025879] iwlwifi 0000:02:00.0: 0x002F01C8 | last cmd Id
[  668.025882] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  668.025885] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  668.025936] iwlwifi 0000:02:00.0: 0x00010030 | l2p_duration
[  668.025952] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  668.025967] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  668.025981] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  668.025994] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  668.026003] iwlwifi 0000:02:00.0: 0x00005060 | flow_handler
[  668.026013] iwlwifi 0000:02:00.0: Fseq Registers:
[  668.026044] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  668.026073] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  668.026101] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  668.026118] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  668.026135] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  668.026153] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  668.026169] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  668.026187] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  668.026205] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  668.026228] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  668.026252] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  668.026276] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  668.026286] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  668.026300] ieee80211 phy0: Hardware restart was requested
[  668.026323] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  668.026328] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0030 service 0x00000005
[  668.026334] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000000447B4D
[  668.026357] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  668.026367] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  668.026372] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  668.026399] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  668.026405] Call Trace:
[  668.026423]  dump_stack+0x46/0x5b
[  668.026451]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  668.026465]  ? wait_woken+0x80/0x80
[  668.026483]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  668.026509]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  668.026528]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  668.026547]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  668.026568]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  668.026584]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  668.026602]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  668.026611]  process_one_work+0x1d4/0x400
[  668.026618]  worker_thread+0x2d/0x3c0
[  668.026624]  ? set_worker_desc+0xb0/0xb0
[  668.026631]  kthread+0x113/0x130
[  668.026640]  ? kthread_park+0xa0/0xa0
[  668.026651]  ret_from_fork+0x35/0x40
[  668.026665] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  675.135095] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  675.135230] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  675.135234] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  675.135237] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  675.135241] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  675.135244] iwlwifi 0000:02:00.0: 0x000002E0 | trm_hw_status0
[  675.135247] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  675.135250] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  675.135253] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  675.135255] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  675.135258] iwlwifi 0000:02:00.0: 0x00370405 | data1
[  675.135261] iwlwifi 0000:02:00.0: 0x00000038 | data2
[  675.135263] iwlwifi 0000:02:00.0: 0x00000038 | data3
[  675.135266] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[  675.135269] iwlwifi 0000:02:00.0: 0x0069CB9D | tsf low
[  675.135271] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  675.135274] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  675.135276] iwlwifi 0000:02:00.0: 0x0069CB9D | time gp2
[  675.135279] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  675.135282] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  675.135285] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  675.135287] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  675.135290] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  675.135293] iwlwifi 0000:02:00.0: 0x00370405 | hcmd
[  675.135295] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  675.135298] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  675.135300] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  675.135303] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  675.135305] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  675.135308] iwlwifi 0000:02:00.0: 0x003601C8 | last cmd Id
[  675.135310] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  675.135313] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[  675.135316] iwlwifi 0000:02:00.0: 0x00008020 | l2p_duration
[  675.135318] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  675.135321] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  675.135324] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  675.135326] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  675.135329] iwlwifi 0000:02:00.0: 0x00008090 | flow_handler
[  675.135332] iwlwifi 0000:02:00.0: Fseq Registers:
[  675.135354] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  675.135370] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  675.135386] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  675.135402] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  675.135418] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  675.135434] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  675.135450] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  675.135466] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  675.135482] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  675.135498] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  675.135514] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  675.135530] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  675.135548] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  675.135556] ieee80211 phy0: Hardware restart was requested
[  675.135572] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  675.135575] iwlwifi 0000:02:00.0: FW Error notification: seq 0x0037 service 0x00000005
[  675.135578] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x000000000069CB9A
[  675.135614] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  675.135620] CPU: 1 PID: 909 Comm: kworker/1:4 Tainted: G        W  O      5.3.0-rc4-slk #1
[  675.135623] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  675.135648] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  675.135652] Call Trace:
[  675.135669]  dump_stack+0x46/0x5b
[  675.135694]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  675.135705]  ? wait_woken+0x80/0x80
[  675.135719]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  675.135742]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  675.135756]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  675.135774]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  675.135793]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  675.135807]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  675.135823]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  675.135831]  process_one_work+0x1d4/0x400
[  675.135838]  worker_thread+0x2d/0x3c0
[  675.135845]  ? set_worker_desc+0xb0/0xb0
[  675.135851]  kthread+0x113/0x130
[  675.135858]  ? kthread_park+0xa0/0xa0
[  675.135867]  ret_from_fork+0x35/0x40
[  675.135881] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  675.135963] ------------[ cut here ]------------
[  675.136059] WARNING: CPU: 0 PID: 108 at net/mac80211/scan.c:395 __ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  675.136061] Modules linked in: ipv6 fuse joydev uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic coretemp hwmon x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel i2c_dev i915 ghash_clmulni_intel snd_hda_intel snd_hda_codec intel_gtt i2c_algo_bit aesni_intel snd_hwdep iosf_mbi snd_hda_core iwlmvm aes_x86_64 drm_kms_helper snd_pcm glue_helper syscopyarea crypto_simd sysfillrect sysimgblt mac80211 fb_sys_fops psmouse evdev serio_raw drm snd_timer libarc4 i2c_i801 r8168(O) agpgart snd iwlwifi xhci_pci soundcore xhci_hcd intel_pch_thermal thermal wmi battery video ac acpi_pad button loop
[  675.136143] CPU: 0 PID: 108 Comm: kworker/u8:2 Tainted: G        W  O      5.3.0-rc4-slk #1
[  675.136146] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  675.136176] Workqueue: phy0 ieee80211_scan_work [mac80211]
[  675.136197] RIP: 0010:__ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  675.136202] Code: 58 9f 57 c0 e8 fd 36 ba e2 0f 0b 48 83 bd 70 11 00 00 00 bb 01 00 00 00 0f 85 f1 fe ff ff 48 c7 c7 58 9f 57 c0 e8 dc 36 ba e2 <0f> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 83 c4 08 48
[  675.136205] RSP: 0018:ffff956c801ebe08 EFLAGS: 00010286
[  675.136208] RAX: 0000000000000024 RBX: 0000000000000001 RCX: 0000000000000000
[  675.136210] RDX: 0000000000000000 RSI: ffff8a270ea163e8 RDI: ffff8a270ea163e8
[  675.136212] RBP: ffff8a2707d207a0 R08: 000000000000263c R09: 0000000000000003
[  675.136214] R10: 0000000000000009 R11: 0000000000000001 R12: 0000000000000000
[  675.136216] R13: 0000000000000008 R14: ffff8a270b49c000 R15: 0000000000000007
[  675.136219] FS:  0000000000000000(0000) GS:ffff8a270ea00000(0000) knlGS:0000000000000000
[  675.136222] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  675.136225] CR2: 00007f96d6e35000 CR3: 0000000351e0a003 CR4: 00000000003606f0
[  675.136226] Call Trace:
[  675.136240]  ? __switch_to_asm+0x34/0x70
[  675.136259]  ieee80211_scan_work+0x6a/0x4d0 [mac80211]
[  675.136267]  process_one_work+0x1d4/0x400
[  675.136272]  worker_thread+0x2d/0x3c0
[  675.136276]  ? set_worker_desc+0xb0/0xb0
[  675.136281]  kthread+0x113/0x130
[  675.136286]  ? kthread_park+0xa0/0xa0
[  675.136292]  ret_from_fork+0x35/0x40
[  675.136298] ---[ end trace 72a91023015a97b6 ]---
[  738.211414] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  738.211548] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  738.211552] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  738.211555] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  738.211560] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  738.211563] iwlwifi 0000:02:00.0: 0x000002A0 | trm_hw_status0
[  738.211565] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  738.211568] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  738.211571] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  738.211573] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  738.211576] iwlwifi 0000:02:00.0: 0x002F0405 | data1
[  738.211578] iwlwifi 0000:02:00.0: 0x00000030 | data2
[  738.211581] iwlwifi 0000:02:00.0: 0x00000030 | data3
[  738.211583] iwlwifi 0000:02:00.0: 0x00100F31 | beacon time
[  738.211586] iwlwifi 0000:02:00.0: 0x03BFCB9F | tsf low
[  738.211589] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  738.211591] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  738.211594] iwlwifi 0000:02:00.0: 0x03BFCB9F | time gp2
[  738.211597] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  738.211599] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  738.211602] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  738.211604] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  738.211607] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  738.211609] iwlwifi 0000:02:00.0: 0x002F0405 | hcmd
[  738.211612] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  738.211614] iwlwifi 0000:02:00.0: 0x01000000 | isr1
[  738.211617] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  738.211619] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  738.211622] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  738.211624] iwlwifi 0000:02:00.0: 0x002E01C8 | last cmd Id
[  738.211627] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  738.211630] iwlwifi 0000:02:00.0: 0x00000850 | l2p_control
[  738.211632] iwlwifi 0000:02:00.0: 0x00018020 | l2p_duration
[  738.211635] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  738.211637] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  738.211640] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  738.211643] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  738.211646] iwlwifi 0000:02:00.0: 0x00006068 | flow_handler
[  738.211649] iwlwifi 0000:02:00.0: Fseq Registers:
[  738.211671] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  738.211687] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  738.211703] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  738.211719] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  738.211735] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  738.211751] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  738.211767] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  738.211782] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  738.211799] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  738.211814] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  738.211831] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  738.211846] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  738.211865] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  738.211875] ieee80211 phy0: Hardware restart was requested
[  738.211895] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  738.211900] iwlwifi 0000:02:00.0: FW Error notification: seq 0x002F service 0x00000005
[  738.211905] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000003BFCB9C
[  738.211970] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  738.211977] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  738.211980] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  738.211999] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  738.212003] Call Trace:
[  738.212016]  dump_stack+0x46/0x5b
[  738.212035]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  738.212046]  ? wait_woken+0x80/0x80
[  738.212058]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  738.212076]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  738.212087]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  738.212099]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  738.212113]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  738.212124]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  738.212138]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  738.212147]  process_one_work+0x1d4/0x400
[  738.212155]  worker_thread+0x2d/0x3c0
[  738.212163]  ? set_worker_desc+0xb0/0xb0
[  738.212169]  kthread+0x113/0x130
[  738.212176]  ? kthread_park+0xa0/0xa0
[  738.212187]  ret_from_fork+0x35/0x40
[  738.212204] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  738.212255] ------------[ cut here ]------------
[  738.212336] WARNING: CPU: 2 PID: 1947 at net/mac80211/scan.c:395 __ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  738.212338] Modules linked in: ipv6 fuse joydev uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic coretemp hwmon x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel i2c_dev i915 ghash_clmulni_intel snd_hda_intel snd_hda_codec intel_gtt i2c_algo_bit aesni_intel snd_hwdep iosf_mbi snd_hda_core iwlmvm aes_x86_64 drm_kms_helper snd_pcm glue_helper syscopyarea crypto_simd sysfillrect sysimgblt mac80211 fb_sys_fops psmouse evdev serio_raw drm snd_timer libarc4 i2c_i801 r8168(O) agpgart snd iwlwifi xhci_pci soundcore xhci_hcd intel_pch_thermal thermal wmi battery video ac acpi_pad button loop
[  738.212397] CPU: 2 PID: 1947 Comm: kworker/u8:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  738.212400] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  738.212424] Workqueue: phy0 ieee80211_scan_work [mac80211]
[  738.212444] RIP: 0010:__ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  738.212449] Code: 58 9f 57 c0 e8 fd 36 ba e2 0f 0b 48 83 bd 70 11 00 00 00 bb 01 00 00 00 0f 85 f1 fe ff ff 48 c7 c7 58 9f 57 c0 e8 dc 36 ba e2 <0f> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 83 c4 08 48
[  738.212452] RSP: 0018:ffff956c83b33e08 EFLAGS: 00010286
[  738.212455] RAX: 0000000000000024 RBX: 0000000000000001 RCX: 0000000000000000
[  738.212457] RDX: 0000000000000000 RSI: ffff8a270eb163e8 RDI: ffff8a270eb163e8
[  738.212460] RBP: ffff8a2707d207a0 R08: 00000000000026a5 R09: 0000000000000003
[  738.212462] R10: ffff956c800a7e68 R11: 0000000000000001 R12: 0000000000000000
[  738.212464] R13: 0000000000000008 R14: ffff8a270b49c000 R15: 0000000000000008
[  738.212467] FS:  0000000000000000(0000) GS:ffff8a270eb00000(0000) knlGS:0000000000000000
[  738.212470] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  738.212472] CR2: 00007f96ac7f8023 CR3: 0000000351e0a005 CR4: 00000000003606e0
[  738.212474] Call Trace:
[  738.212487]  ? __switch_to_asm+0x34/0x70
[  738.212507]  ieee80211_scan_work+0x6a/0x4d0 [mac80211]
[  738.212515]  process_one_work+0x1d4/0x400
[  738.212520]  worker_thread+0x2d/0x3c0
[  738.212524]  ? set_worker_desc+0xb0/0xb0
[  738.212529]  kthread+0x113/0x130
[  738.212534]  ? kthread_park+0xa0/0xa0
[  738.212541]  ret_from_fork+0x35/0x40
[  738.212546] ---[ end trace 72a91023015a97b7 ]---
[  768.625239] iwlwifi 0000:02:00.0: Microcode SW error detected.  Restarting 0x82000000.
[  768.625380] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[  768.625386] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[  768.625389] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[  768.625394] iwlwifi 0000:02:00.0: 0x00000038 | BAD_COMMAND                 
[  768.625398] iwlwifi 0000:02:00.0: 0x000002A0 | trm_hw_status0
[  768.625401] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[  768.625404] iwlwifi 0000:02:00.0: 0x00043D6C | branchlink2
[  768.625408] iwlwifi 0000:02:00.0: 0x0004AFA2 | interruptlink1
[  768.625411] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[  768.625414] iwlwifi 0000:02:00.0: 0x002F0405 | data1
[  768.625417] iwlwifi 0000:02:00.0: 0x00000030 | data2
[  768.625420] iwlwifi 0000:02:00.0: 0x00000030 | data3
[  768.625423] iwlwifi 0000:02:00.0: 0x00105193 | beacon time
[  768.625426] iwlwifi 0000:02:00.0: 0x01CD6BA2 | tsf low
[  768.625429] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[  768.625433] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[  768.625436] iwlwifi 0000:02:00.0: 0x01CD6BA2 | time gp2
[  768.625439] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[  768.625442] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[  768.625445] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[  768.625448] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[  768.625451] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[  768.625454] iwlwifi 0000:02:00.0: 0x002F0405 | hcmd
[  768.625457] iwlwifi 0000:02:00.0: 0x00022080 | isr0
[  768.625460] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[  768.625463] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[  768.625466] iwlwifi 0000:02:00.0: 0x00417C80 | isr3
[  768.625469] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[  768.625472] iwlwifi 0000:02:00.0: 0x002E01C8 | last cmd Id
[  768.625475] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[  768.625478] iwlwifi 0000:02:00.0: 0x00000850 | l2p_control
[  768.625481] iwlwifi 0000:02:00.0: 0x00018020 | l2p_duration
[  768.625484] iwlwifi 0000:02:00.0: 0x0000003F | l2p_mhvalid
[  768.625487] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[  768.625490] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[  768.625493] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[  768.625496] iwlwifi 0000:02:00.0: 0x00005868 | flow_handler
[  768.625500] iwlwifi 0000:02:00.0: Fseq Registers:
[  768.625523] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[  768.625539] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[  768.625555] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[  768.625571] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[  768.625587] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[  768.625603] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[  768.625619] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[  768.625635] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[  768.625651] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[  768.625667] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[  768.625683] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  768.625699] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  768.625720] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[  768.625729] ieee80211 phy0: Hardware restart was requested
[  768.625749] iwlwifi 0000:02:00.0: FW Error notification: type 0x00000000 cmd_id 0x05
[  768.625752] iwlwifi 0000:02:00.0: FW Error notification: seq 0x002F service 0x00000005
[  768.625756] iwlwifi 0000:02:00.0: FW Error notification: timestamp 0x0000000001CD6B9F
[  768.625807] iwlwifi 0000:02:00.0: FW error in SYNC CMD GEO_TX_POWER_LIMIT
[  768.625814] CPU: 1 PID: 1696 Comm: kworker/1:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  768.625817] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  768.625841] Workqueue: events iwl_mvm_async_handlers_wk [iwlmvm]
[  768.625845] Call Trace:
[  768.625861]  dump_stack+0x46/0x5b
[  768.625882]  iwl_trans_pcie_send_hcmd+0x3f4/0x440 [iwlwifi]
[  768.625897]  ? wait_woken+0x80/0x80
[  768.625913]  iwl_trans_send_cmd+0x6a/0xf0 [iwlwifi]
[  768.625941]  iwl_mvm_send_cmd+0x23/0x80 [iwlmvm]
[  768.625964]  iwl_mvm_get_sar_geo_profile+0xb3/0x160 [iwlmvm]
[  768.625980]  ? iwl_parse_nvm_mcc_info+0x301/0x400 [iwlwifi]
[  768.626000]  ? iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  768.626024]  iwl_mvm_rx_chub_update_mcc+0xd2/0x110 [iwlmvm]
[  768.626043]  iwl_mvm_async_handlers_wk+0xc0/0x140 [iwlmvm]
[  768.626059]  process_one_work+0x1d4/0x400
[  768.626070]  worker_thread+0x2d/0x3c0
[  768.626076]  ? set_worker_desc+0xb0/0xb0
[  768.626082]  kthread+0x113/0x130
[  768.626090]  ? kthread_park+0xa0/0xa0
[  768.626099]  ret_from_fork+0x35/0x40
[  768.626155] iwlwifi 0000:02:00.0: Failed to get geographic profile info -5
[  768.626910] ------------[ cut here ]------------
[  768.627006] WARNING: CPU: 3 PID: 1947 at net/mac80211/scan.c:395 __ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  768.627008] Modules linked in: ipv6 fuse joydev uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev videobuf2_common snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic coretemp hwmon x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel i2c_dev i915 ghash_clmulni_intel snd_hda_intel snd_hda_codec intel_gtt i2c_algo_bit aesni_intel snd_hwdep iosf_mbi snd_hda_core iwlmvm aes_x86_64 drm_kms_helper snd_pcm glue_helper syscopyarea crypto_simd sysfillrect sysimgblt mac80211 fb_sys_fops psmouse evdev serio_raw drm snd_timer libarc4 i2c_i801 r8168(O) agpgart snd iwlwifi xhci_pci soundcore xhci_hcd intel_pch_thermal thermal wmi battery video ac acpi_pad button loop
[  768.627085] CPU: 3 PID: 1947 Comm: kworker/u8:0 Tainted: G        W  O      5.3.0-rc4-slk #1
[  768.627088] Hardware name: Notebook                         N24_25BU/N24_25BU, BIOS 5.12 02/17/2017
[  768.627116] Workqueue: phy0 ieee80211_scan_work [mac80211]
[  768.627142] RIP: 0010:__ieee80211_scan_completed+0x182/0x3e0 [mac80211]
[  768.627148] Code: 58 9f 57 c0 e8 fd 36 ba e2 0f 0b 48 83 bd 70 11 00 00 00 bb 01 00 00 00 0f 85 f1 fe ff ff 48 c7 c7 58 9f 57 c0 e8 dc 36 ba e2 <0f> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 83 c4 08 48
[  768.627152] RSP: 0018:ffff956c83b33e08 EFLAGS: 00010286
[  768.627157] RAX: 0000000000000024 RBX: 0000000000000001 RCX: ffffffffa3e48ef8
[  768.627160] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffffffffa435908c
[  768.627163] RBP: ffff8a2707d207a0 R08: 000000000000270e R09: 0000000000000003
[  768.627166] R10: ffff956c806dbb80 R11: 0000000000000001 R12: 0000000000000000
[  768.627169] R13: 0000000000000008 R14: ffff8a270b49c000 R15: 0000000000000009
[  768.627173] FS:  0000000000000000(0000) GS:ffff8a270eb80000(0000) knlGS:0000000000000000
[  768.627177] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  768.627180] CR2: 00007f96d6e49000 CR3: 0000000849636004 CR4: 00000000003606e0
[  768.627182] Call Trace:
[  768.627196]  ? __switch_to_asm+0x34/0x70
[  768.627221]  ieee80211_scan_work+0x6a/0x4d0 [mac80211]
[  768.627230]  process_one_work+0x1d4/0x400
[  768.627235]  worker_thread+0x2d/0x3c0
[  768.627240]  ? set_worker_desc+0xb0/0xb0
[  768.627246]  kthread+0x113/0x130
[  768.627253]  ? kthread_park+0xa0/0xa0
[  768.627260]  ret_from_fork+0x35/0x40
[  768.627266] ---[ end trace 72a91023015a97b8 ]---

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config-slk

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 5.3.0-rc4 Kernel Configuration
#

#
# Compiler: gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION="-slk"
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="darkstar"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=18
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=m
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
# CONFIG_HYPERVISOR_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
# CONFIG_KEXEC_JUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=m
CONFIG_DPTF_POWER=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=m
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
# CONFIG_VHOST_NET is not set
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC=""
CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=98304
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
# CONFIG_HWPOISON_INJECT is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_PTE_DEVMAP=y
# CONFIG_ZONE_DEVICE is not set
# CONFIG_HMM_MIRROR is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=m
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
# CONFIG_IPV6_VTI is not set
# CONFIG_IPV6_SIT is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
# CONFIG_NETFILTER_NETLINK_OSF is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NF_LOG_NETDEV is not set
# CONFIG_NF_TABLES is not set
# CONFIG_NETFILTER_XTABLES is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
# CONFIG_NF_REJECT_IPV4 is not set
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
# CONFIG_NF_REJECT_IPV6 is not set
# CONFIG_NF_LOG_IPV6 is not set
# CONFIG_IP6_NF_IPTABLES is not set
# end of IPv6: Netfilter Configuration

# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_PRIO is not set
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
# CONFIG_NET_SCH_SFQ is not set
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
# CONFIG_NET_SCH_NETEM is not set
# CONFIG_NET_SCH_DRR is not set
# CONFIG_NET_SCH_MQPRIO is not set
# CONFIG_NET_SCH_SKBPRIO is not set
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
# CONFIG_NET_SCH_CODEL is not set
# CONFIG_NET_SCH_FQ_CODEL is not set
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_ROUTE4 is not set
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
# CONFIG_NET_CLS_RSVP is not set
# CONFIG_NET_CLS_RSVP6 is not set
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
# CONFIG_NET_EMATCH_CMP is not set
# CONFIG_NET_EMATCH_NBYTE is not set
# CONFIG_NET_EMATCH_U32 is not set
# CONFIG_NET_EMATCH_META is not set
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_CLS_ACT=y
# CONFIG_NET_ACT_POLICE is not set
# CONFIG_NET_ACT_GACT is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
# CONFIG_NET_ACT_SIMP is not set
# CONFIG_NET_ACT_SKBEDIT is not set
# CONFIG_NET_ACT_CSUM is not set
# CONFIG_NET_ACT_MPLS is not set
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
# CONFIG_NET_MPLS_GSO is not set
# CONFIG_MPLS_ROUTING is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
# CONFIG_AX25 is not set
# CONFIG_CAN is not set
CONFIG_BT=m
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
# CONFIG_BT_HIDP is not set
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
# CONFIG_MAC80211_DEBUGFS is not set
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_PVPANIC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=m
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
# CONFIG_MEGARAID_MM is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=y
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BCACHE is not set
# CONFIG_BLK_DEV_DM is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_ULI526X is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
# CONFIG_E1000 is not set
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_USB_NET_DRIVERS is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
CONFIG_ATH5K_PCI=y
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
# CONFIG_IWLDVM is not set
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
CONFIG_RTL8192CE=m
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
CONFIG_RTL8192CU=m
CONFIG_RTLWIFI=m
CONFIG_RTLWIFI_PCI=m
CONFIG_RTLWIFI_USB=m
# CONFIG_RTLWIFI_DEBUG is not set
CONFIG_RTL8192C_COMMON=m
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
CONFIG_ISDN=y
# CONFIG_ISDN_CAPI is not set
# CONFIG_MISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_GTCO is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
# CONFIG_INPUT_PCSPKR is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
# CONFIG_SERIAL_8250_EXAR is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_SI is not set
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_NVRAM=m
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

# CONFIG_GPIO_MOCKUP is not set
# CONFIG_W1 is not set
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CLOCK_THERMAL=y
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=m
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
# CONFIG_USB_GSPCA is not set
# CONFIG_USB_PWC is not set
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_USB_ZR364XX is not set
# CONFIG_USB_STKWEBCAM is not set
# CONFIG_USB_S2255 is not set
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
# CONFIG_VIDEO_PVRUSB2 is not set
# CONFIG_VIDEO_HDPVR is not set
# CONFIG_VIDEO_USBVISION is not set
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set
# CONFIG_VIDEO_CX231XX is not set

#
# Digital TV USB devices
#
# CONFIG_DVB_USB_V2 is not set
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
# CONFIG_SMS_USB_DRV is not set
# CONFIG_DVB_B2C2_FLEXCOP_USB is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
# CONFIG_VIDEO_CAFE_CCIC is not set
# CONFIG_VIDEO_CADENCE is not set
# CONFIG_VIDEO_ASPEED is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set
# CONFIG_VIDEO_SH_VEU is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y

#
# Audio decoders, processors and mixers
#

#
# RDS decoders
#

#
# Video decoders
#

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MC44S803=m

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Common Interface (EN50221) controller drivers
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
CONFIG_AGP=m
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=m
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=2048
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
# CONFIG_SND_SOC_INTEL_HASWELL is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
# CONFIG_SND_SOC_INTEL_SKL is not set
# CONFIG_SND_SOC_INTEL_APL is not set
# CONFIG_SND_SOC_INTEL_KBL is not set
# CONFIG_SND_SOC_INTEL_GLK is not set
# CONFIG_SND_SOC_INTEL_CNL is not set
# CONFIG_SND_SOC_INTEL_CFL is not set
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=m
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
# CONFIG_SND_SOC_DMIC is not set
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
# CONFIG_SND_SOC_ES8316 is not set
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_GTM601 is not set
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
# CONFIG_SND_SOC_MAX98357A is not set
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
# CONFIG_SND_SOC_MAX98927 is not set
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_RK3328 is not set
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TS3A227E is not set
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
# CONFIG_SND_SOC_NAU8824 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set

#
# HID support
#
# CONFIG_HID is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
# CONFIG_USB_XHCI_PLATFORM is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=m
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=m
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
# CONFIG_MMC_BLOCK is not set
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
CONFIG_MMC_SDHCI_ACPI=m
# CONFIG_MMC_SDHCI_PLTFM is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_DECODE_MCE is not set
# CONFIG_EDAC_GHES is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_I10NM is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BD70528 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_PMEM is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

CONFIG_STAGING_MEDIA=y
# CONFIG_I2C_BCM2048 is not set

#
# soc_camera sensor drivers
#

#
# Android
#
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_EROFS_FS is not set
# CONFIG_FIELDBUS_DEV is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WMI is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_DCDBAS is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBU is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
# CONFIG_WMI_BMOF is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_MXM_WMI is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
# CONFIG_CHROMEOS_PSTORE is not set
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CS2000_CP=m
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
# CONFIG_IIO_BUFFER_CB is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7291 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD799X is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP3422 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_TI_DAC5571 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_BMI160_I2C is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ACPI_ALS=m
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_MAG3110 is not set
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4531 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DPS310 is not set
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=m
# CONFIG_CUSE is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_PATH is not set
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=m
CONFIG_CRYPTO_AES_NI_INTEL=m
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_TWOFISH_X86_64 is not set
# CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
# CONFIG_CRC8 is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
# CONFIG_FONT_10x18 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_TER16x32 is not set
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=0
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of Kernel hacking

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=device-info

02:00.0 Network controller: Intel Corporation Device 24fb (rev 10)
	Subsystem: Intel Corporation Device 2110
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 128
	Region 0: Memory at df100000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00318  Data: 0000
	Capabilities: [40] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L0s <4us, L1 <32us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+, OBFF Via WAKE#
		DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number b0-35-9f-ff-ff-2c-85-17
	Capabilities: [14c v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [154 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi


--9jxsPFA5p3P2qPhR--
