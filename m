Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A36E156238
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Feb 2020 02:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBHBJH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 20:09:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45014 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgBHBJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 20:09:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so978888qkb.11;
        Fri, 07 Feb 2020 17:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=28dfEiPeN3Ez+VZ5o7L7ZjAdzJ2tj9Hb8zEewBoWApo=;
        b=cvbx9bUOaFpuKRVuBAXUB7EjUuPmFqkM2K8cxG068Sjq8/vVCT2+gX2GGY/lEQYh8r
         9vJpoHlMQN9oLBsctx+SAUaKZWFTGEFc6nE535Uk7YCn4lN9Fa8R1N6IBWjAskQHzMSH
         1N18r5XG8AjzWLnvL+CcKDPY9VAf6tJGbTtvC49j4jwQghaaPCitgASIo/KaVnUWLVYJ
         3Qzw4Q5cgw6B3//RyDO8GNWsu5WGRPEET4dAMUdPjkORgA/7V7xbA9Abt/DGV9iPRRC2
         40TZFnUxm4qhGgbldSurw5UkrCgE3LabKDOlgtvvhjzFbbDdLtVwWR4COBwjEBzUloac
         tPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=28dfEiPeN3Ez+VZ5o7L7ZjAdzJ2tj9Hb8zEewBoWApo=;
        b=F0GqeBL/97yznHq2CB3cvBidI0Tx+tlFQ0wS5C+EsCUzrmzOUcElXhEKR00emUM9m+
         HiC9JOPnRwbqIA/nuWmo6cXOeEVBAg/idEpjLVZcn+wFuPOctyR+NSg2vi69VboZ/Ome
         9ZztxIOWew8J/SlovMq8DbidHuBE64tOlE9WhqtIv1kiRY/qbIYASNI4zb3Z86srXuOO
         RlrS2yYvwCcouotnqL5i3H7Kld0jkWFE5qYKNqVjswA2zsRQsbXOTjuIxIrhA/Bw9JGa
         JbE8m5qxg4RXC8vmwziz8U4gLzJA8UA0jJQZCmRblmvIlicF4efGiYZ7o4dhPfDropQG
         qWTA==
X-Gm-Message-State: APjAAAV9Ur/rQqZZyR62CLDdlcCUpwTyxwE/h1lVpq5nnjKbDrRIYljy
        v6Ar7nK30Mk200OipYfCS5V9CnX1
X-Google-Smtp-Source: APXvYqxw24ARtzuei9Gu3Q+U23FnlD8HWXMfHTtUmvK5jjHUzFlz/upZCtGye9ptHfhT/wPNPQw4fQ==
X-Received: by 2002:a05:620a:110c:: with SMTP id o12mr1641209qkk.66.1581124145865;
        Fri, 07 Feb 2020 17:09:05 -0800 (PST)
Received: from chirva-slack.chirva-slack (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id z185sm2204636qkb.116.2020.02.07.17.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 17:09:05 -0800 (PST)
Date:   Fri, 7 Feb 2020 20:09:03 -0500
From:   Stuart Little <achirvasub@gmail.com>
To:     Johannes Berg <johannes.berg@intel.com>,
        emmanuel.grumbach@intel.com, Luca Coelho <luciano.coelho@intel.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, linuxwifi@intel.com,
        linux-wireless@vger.kernel.org
Subject: PROBLEM: Linux 5.5 fails to load firmware for Intel(R) Dual Band
 Wireless AC 3168
Message-ID: <20200208010903.GA1366@chirva-slack.chirva-slack>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am on an

Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz

with an Intel wifi card:

Intel(R) Dual Band Wireless AC 3168, REV=0x220

The machine is running Slackware 14.2 with a custom-compiled 5.5 kernel (from source; commit d5226fa6dbae Linux 5.5).

The issue:

Booting into that kernel results in failure to load the wifi card firmware. The relevant dmesg portion is attached (these are all of the lines containing 'iwlwifi'). 

I have checked that it breaks between

def9d2780727 Linux 5.5-rc7 (good)

and

d5226fa6dbae Linux 5.5 (bad)

I will attempt a bisect to track down the precise faulty commit, but this is all I have for now. Please let me know if I can provide more info short of the bisect.

P.S.

I have checked that the very latest commit at the time of this writing (41dcd67e88688afbeb3b2bd23960eed5daec74e7 at Fri Feb 7 20:07:29 EST 2020) is still broken on this machine.

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg_iwlwifi_snippet

[    1.210208] iwlwifi 0000:02:00.0: loaded firmware version 29.1654887522.0 op_mode iwlmvm
[    1.218505] r8168: This product is covered by one or more of the following patents: US6,570,884, US6,115,776, and US6,327,625.
[    1.223892] r8168  Copyright (C) 2019  Realtek NIC software team <nicfae@realtek.com> 
                This program comes with ABSOLUTELY NO WARRANTY; for details, please see <http://www.gnu.org/licenses/>. 
                This is free software, and you are welcome to redistribute it under certain conditions; see <http://www.gnu.org/licenses/>. 
[    1.230349] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.230500] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.231808] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    1.232080] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.232486] hub 1-0:1.0: USB hub found
[    1.232640] hub 1-0:1.0: 12 ports detected
[    1.233280] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.233440] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.233690] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    1.233883] AVX2 version of gcm_enc/dec engaged.
[    1.234067] AES CTR mode by8 optimization enabled
[    1.234279] hub 2-0:1.0: USB hub found
[    1.234446] hub 2-0:1.0: 6 ports detected
[    1.277853] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 3168, REV=0x220
[    1.297761] iwlwifi 0000:02:00.0: Can't parse phy_sku in B0, empty sections
[    1.297916] iwlwifi 0000:02:00.0: Failed to read NVM: -61
[    1.298063] iwlwifi 0000:02:00.0: Collecting data: trigger 16 fired.
[    1.299371] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[    1.299521] iwlwifi 0000:02:00.0: Status: 0x00000040, count: 6
[    1.299673] iwlwifi 0000:02:00.0: Loaded firmware version: 29.1654887522.0
[    1.299829] iwlwifi 0000:02:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN       
[    1.299983] iwlwifi 0000:02:00.0: 0x000002F0 | trm_hw_status0
[    1.300132] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[    1.300291] iwlwifi 0000:02:00.0: 0x0004171E | branchlink2
[    1.300442] iwlwifi 0000:02:00.0: 0x000446B2 | interruptlink1
[    1.300595] iwlwifi 0000:02:00.0: 0x000446B2 | interruptlink2
[    1.300747] iwlwifi 0000:02:00.0: 0x00000000 | data1
[    1.300895] iwlwifi 0000:02:00.0: 0x00000080 | data2
[    1.301041] iwlwifi 0000:02:00.0: 0x07030000 | data3
[    1.301190] iwlwifi 0000:02:00.0: 0x00000000 | beacon time
[    1.301341] iwlwifi 0000:02:00.0: 0x00001451 | tsf low
[    1.301491] iwlwifi 0000:02:00.0: 0x00000000 | tsf hi
[    1.301642] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[    1.301793] iwlwifi 0000:02:00.0: 0x00001452 | time gp2
[    1.301943] iwlwifi 0000:02:00.0: 0x00000009 | uCode revision type
[    1.302094] iwlwifi 0000:02:00.0: 0x0000001D | uCode version major
[    1.302245] iwlwifi 0000:02:00.0: 0x62A39462 | uCode version minor
[    1.302397] iwlwifi 0000:02:00.0: 0x00000220 | hw version
[    1.302548] iwlwifi 0000:02:00.0: 0x00C89200 | board version
[    1.302701] iwlwifi 0000:02:00.0: 0x00110188 | hcmd
[    1.302852] iwlwifi 0000:02:00.0: 0x00022000 | isr0
[    1.303003] iwlwifi 0000:02:00.0: 0x00000000 | isr1
[    1.303152] iwlwifi 0000:02:00.0: 0x00000002 | isr2
[    1.303301] iwlwifi 0000:02:00.0: 0x004000C0 | isr3
[    1.303448] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[    1.303596] iwlwifi 0000:02:00.0: 0x00110188 | last cmd Id
[    1.303746] iwlwifi 0000:02:00.0: 0x00000000 | wait_event
[    1.303897] iwlwifi 0000:02:00.0: 0x00000080 | l2p_control
[    1.304047] iwlwifi 0000:02:00.0: 0x00000000 | l2p_duration
[    1.304197] iwlwifi 0000:02:00.0: 0x00000000 | l2p_mhvalid
[    1.304346] iwlwifi 0000:02:00.0: 0x00000000 | l2p_addr_match
[    1.304496] iwlwifi 0000:02:00.0: 0x00000007 | lmpm_pmg_sel
[    1.304652] iwlwifi 0000:02:00.0: 0x16070617 | timestamp
[    1.304798] iwlwifi 0000:02:00.0: 0x00341018 | flow_handler
[    1.304966] iwlwifi 0000:02:00.0: Fseq Registers:
[    1.305139] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ERROR_CODE
[    1.305306] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[    1.305475] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[    1.305652] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_OTP_VERSION
[    1.305822] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[    1.305995] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[    1.306175] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVI_ID
[    1.306356] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_CNVR_ID
[    1.306524] iwlwifi 0000:02:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[    1.306695] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[    1.306870] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[    1.307135] iwlwifi 0000:02:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[    1.307402] iwlwifi 0000:02:00.0: Firmware not running - cannot dump error
[    1.319717] iwlwifi 0000:02:00.0: Failed to run INIT ucode: -61

--ew6BAiZeqk4r7MaW--
