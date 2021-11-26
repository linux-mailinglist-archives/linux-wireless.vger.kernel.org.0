Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91E45EBA8
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377148AbhKZKfV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 05:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377345AbhKZKdV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 05:33:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CDAC061746
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 02:20:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso7264703wmh.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 02:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=htHMI/IfeacFab0PI+tHJpaR3p/uUXIhLoo8ycBlalA=;
        b=D8kok6+fJaatQa6jG2GJNdQQN4NSxGj+lYC0VRGnnkVG/tynRH7b1hBbOS3qO/BHsj
         X1hiRPi7EEaa71RtzxZmtJQkDj980Wh2orpU+eTlheYKs+qm1hqvf28I8l58Kyr3ddSe
         ZpTEHgGLjCjsQUoEMzm89dygYpAsiT64cEBZLI+ulXs9KEfwSLZGDz6xxPML36waj8Bv
         kgYqvAaSGFmq/vjqc6/Y0MVNLY9BRog3dIK024vxo7JInCvuw7g2w/gzhta+4Z+pZetl
         zQ7xHNolJHKSPgQ/3SwqUJ3W1BV3JP9myLEyKNRPZjDZAYSNl8xyaVVaolQ4bLToz4lT
         TgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=htHMI/IfeacFab0PI+tHJpaR3p/uUXIhLoo8ycBlalA=;
        b=Gn8cjSFRQhK6poMxW+wz8Ls3w262zNq42yJQbUwE8vWgwuFKE79kcRXdhKu31VF49n
         HzhIt41NRCzo5oL3dBm7xxuOQ7DW4hFQcBlh8GaAUjtXMCwp6iOfgehmbExIBKmmvVsS
         JjDrTfRIt4xqIoLKg4DHDOsPRjaCQ+AzQkl/1/lF+KbChI479zJxSYLCd92IIE6pMxpB
         wDzqszH4WesCwsdofrKaNNNktEVc7p3zxW+odRNS5JoP6TxYts53MIexsAj/DouIJZJn
         EK9AB6yzN18ArkzULQyaJ6gAi9hQkXhQlV2p009ozKCXXhs4dC1RrJWityl4vH9sTRoT
         JzWA==
X-Gm-Message-State: AOAM530oG2XWPOmfkx6/wDcHhtSJ63jfgRc2aTOEyE3Ct9Gp3GzYVO2n
        RFV8MlgypZ1SMxEEtosBkCfBwOizPlCt4YBht0E7gVPaj68rCA==
X-Google-Smtp-Source: ABdhPJyGCo/fIJlneUBnMJeQzFdmuE2djELEIOqKBK9u4SE25XDzmw5lnYzgchpvqsm6HsZGKCrNCBhZok3PWdkUlXI=
X-Received: by 2002:a1c:e918:: with SMTP id q24mr14573362wmc.108.1637922049639;
 Fri, 26 Nov 2021 02:20:49 -0800 (PST)
MIME-Version: 1.0
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Fri, 26 Nov 2021 11:20:39 +0100
Message-ID: <CANh8QzxPWN7uHGYaU1rpMF+J=vqjbLs+o325UcQc54+6OWiVHw@mail.gmail.com>
Subject: [REGRESSION] mwifiex: mwifiex_get_chan_type noisy and possibly
 incorrect after kernel upgrade
To:     linux-wireless@vger.kernel.org
Cc:     Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

After upgrading an old system using a SD8787 wifi module from kernel
4.4 to 5.4.143 I started getting error messages in the logs
    mwifiex_sdio mmc2:0001:1: CMD_RESP: cmd 0x23f error, result=0x2

The same error occurs on 5.15 too.
With Android userspace this occurs every 3 seconds but can be
reproduced with a Linux userspace too using the wpa_cli "signal_poll"
command
(Android polls that command via wpa_supplicant)

root@hw-test:~# wpa_cli
wpa_cli v2.8-devel
Copyright (c) 2004-2019, Jouni Malinen <j@w1.fi> and contributors
...
Selected interface 'mlan0'
Interactive mode

> signal_poll
[  143.963217] mwifiex_sdio mmc2:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
RSSI=-5
LINKSPEED=65
NOISE=-75
FREQUENCY=2437
WIDTH=20 MHz
CENTER_FRQ1=2437
AVG_RSSI=-5

Firmware version is 14.68.35.p66  (latest from linux-firmware git)

The 0x23f command is HostCmd_CMD_STA_CONFIGURE and was added in 4.16 by
    28bf8312a983 ("mwifiex: get_channel from firmware")

I don't see anywhere in the code defining the 0x2 result code.

The error occurs during processing of the netlink
NL80211_CMD_GET_INTERFACE command which is part of
wpa_supplicant's nl80211_signal_poll()

Kernel side callstack is
nl80211_get_interface
    nl80211_send_iface
        mwifiex_cfg80211_get_channel
                mwifiex_get_chan_type
                    mwifiex_get_chan_info
                        mwifiex_send_cmd(HostCmd_CMD_STA_CONFIGURE,
HostCmd_ACT_GEN_GET)


In addition to the log spam the result is also potentially incorrect
since when the command fails a 20MHz channel width is assumed.
The connection still works correctly however

Regards,

Martin
