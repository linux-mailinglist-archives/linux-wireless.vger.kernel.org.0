Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18E514E356
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgA3ToP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 14:44:15 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:35801 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgA3ToP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 14:44:15 -0500
Received: by mail-il1-f176.google.com with SMTP id g12so4135402ild.2;
        Thu, 30 Jan 2020 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AsHysUzz35VUzNfhyJLvwCw0cKuHK0TPagQM9CrhcfE=;
        b=qJL+RzKpd19iGZl3zupV/oViVpK+hxuX6wCspLd3Bt36LeJV9g6l+jx76ZMMmoqU6a
         fDOeYBDQhvbgtpVejaKMqLh+K3J/52eerOd/VKrnoGJEcBa+ge2r9tvJiNDhhPTJEOph
         u1dUqfmmkhr0yIL6NGpUzkj0Jzusq3i+ZfzkiRi9yXJXMzwGPRp15VdtPQfc5tNJXx3w
         pj5mzykaxZd1N/lCOfBI++oMZ+Fr5Gn3Oe+Lj+6tofo0hjWWOprPoYRiGb1J5g++3exW
         mRRNLdS4z9s7VUBam8LQVL3+Wv7PzbtUBL2SYyIR5+N6Ya0p6rv/8TzhfCPKPjMNuwVW
         pcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AsHysUzz35VUzNfhyJLvwCw0cKuHK0TPagQM9CrhcfE=;
        b=HB6NHgShT3hy28mRq+QPHxZUcka+Xn7UFsqsQ8RMil8n/suESZwOIuf943AIUTew5d
         mlJjm3ISkNOZhtkdunBVqTwcXQRycQXo3VOWcL6aNBpT9nko9sHsNqHfXyTeUaWOzh8j
         QGKXVy7fh/xvZD0AQV5kcjKqjDYbSJNbJ1d4qegPc2K7mgfTlE8NMjxouZjPhQfJrhBg
         4Xrucm4IGBrdZiKK0/9wfm/njH1vOKk/GUIIIyddJlJi1hBalOp3mHDsPnurcvtXVqLb
         MhvirknkaYpi7ZHOKqYF9A32u7n7tQE4/1Wqq7X0ZkdWMZpZzOjhZZQf6/4io5n5UCeb
         papA==
X-Gm-Message-State: APjAAAUvvYh3mtd42tXIMEB6hO9vn31N2yFVoEpXKKHxhsiKtycSDeRG
        7AgYmJreswgHkRtQ5YyEgL9rKpFJpy6MBkYo/ZY=
X-Google-Smtp-Source: APXvYqzm8TgIXIxwMXUzdTXrE+XOvZPOBsZwAGw8ACeHNAXIyk1AZaauS+TKRswRDLQHpaJDnq7cJfm5ue7JKmWLYr4=
X-Received: by 2002:a92:58d7:: with SMTP id z84mr5699591ilf.179.1580413454466;
 Thu, 30 Jan 2020 11:44:14 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 31 Jan 2020 00:44:03 +0500
Message-ID: <CABXGCsOn=W+grZcZBybY8FkQBL_WH_OH6mQgGHKj3ojJbL-Osw@mail.gmail.com>
Subject: Microcode SW error detected on Wi-Fi 6 AX200 (rev 1a)
To:     linuxwifi@intel.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi folks.
During Wi-Fi operation, the following entry in the kernel logs was noticed:
Microcode SW error detected. Restarting 0x0.
Start IWL Error Log Dump:
Status: 0x00000040, count: 6
Loaded firmware version: 48.4fa0041f.0
0x00000034 | NMI_INTERRUPT_WDG
0x0000A2F0 | trm_hw_status0
0x00000000 | trm_hw_status1
0x004F8E3C | branchlink2
0x0000DBBA | interruptlink1
0x0000DBBA | interruptlink2
0x004F7FB6 | data1
0x00000002 | data2
0xF0000008 | data3
0x02001D26 | beacon time
0xC9CE631E | tsf low
0x00000113 | tsf hi
0x00000000 | time gp1
0xCEE30220 | time gp2
0x00000001 | uCode revision type
0x00000030 | uCode version major
0x4FA0041F | uCode version minor
0x00000340 | hw version
0x00C89000 | board version
0x80A0FC0F | hcmd
0xE6FA0000 | isr0
0x00400000 | isr1
0x08F80002 | isr2
0x4CC1FFDC | isr3
0x00000000 | isr4
0x0542001C | last cmd Id
0x004F7FB6 | wait_event
0x00000094 | l2p_control
0x00000020 | l2p_duration
0x0000000F | l2p_mhvalid
0x000000C7 | l2p_addr_match
0x00000009 | lmpm_pmg_sel
0x00000000 | timestamp
0x0000E080 | flow_handler
Start IWL Error Log Dump:
Status: 0x00000040, count: 7
0x20000070 | NMI_INTERRUPT_LMAC_FATAL
0x00000000 | umac branchlink1
0xC008CC3C | umac branchlink2
0x8048D0E6 | umac interruptlink1
0x8048D0E6 | umac interruptlink2
0x00000400 | umac data1
0x8048D0E6 | umac data2
0x00000000 | umac data3
0x00000030 | umac major
0x4FA0041F | umac minor
0xCEE30231 | frame pointer
0xC0886284 | stack pointer
0x0010011D | last host cmd
0x00000000 | isr status reg
Fseq Registers:
0xE0000101 | FSEQ_ERROR_CODE
0x00290008 | FSEQ_TOP_INIT_VERSION
0x80050008 | FSEQ_CNVIO_INIT_VERSION
0x0000A503 | FSEQ_OTP_VERSION
0x80000003 | FSEQ_TOP_CONTENT_VERSION
0x4552414E | FSEQ_ALIVE_TOKEN
0x00100530 | FSEQ_CNVI_ID
0x00000532 | FSEQ_CNVR_ID
0x00100530 | CNVI_AUX_MISC_CHIP
0x00000532 | CNVR_AUX_MISC_CHIP
0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
Collecting data: trigger 2 fired.

lspci detect Wi Fi device as "04:00.0 Network controller: Intel
Corporation Wi-Fi 6 AX200 (rev 1a)"

$ ethtool -i wlp4s0 | grep firmware
firmware-version: 48.4fa0041f.0

Full kernel log is here: https://pastebin.com/gtpyTaeM

I hope it helps fix the problem.

Take this opportunity I wanna ask is it normal that kernel logs
flooded with such messages:
authenticate with 50:ff:20:04:c8:dc
send auth to 50:ff:20:04:c8:dc (try 1/3)
authenticated
associate with 50:ff:20:04:c8:dc (try 1/3)
RX AssocResp from 50:ff:20:04:c8:dc (capab=0x1811 status=53 aid=1)
50:ff:20:04:c8:dc denied association (code=53)
authenticate with 50:ff:20:04:c8:dc
send auth to 50:ff:20:04:c8:dc (try 1/3)
authenticate with 50:ff:20:04:c8:dc
send auth to 50:ff:20:04:c8:dc (try 1/3)
authenticated
associate with 50:ff:20:04:c8:dc (try 1/3)
RX AssocResp from 50:ff:20:04:c8:dc (capab=0x1811 status=0 aid=1)
associated

Thanks.

--
Best Regards,
Mike Gavrilov.
