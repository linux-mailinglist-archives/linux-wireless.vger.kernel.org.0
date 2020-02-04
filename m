Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C740151531
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2020 06:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgBDFA4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 00:00:56 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:33799 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgBDFA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 00:00:56 -0500
Received: by mail-io1-f52.google.com with SMTP id z193so19472352iof.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2020 21:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6ivCmFFC7PjiDA7Y0YmSnWezwLJYGM7h1yYdjY0fAfE=;
        b=I2zfnp3YLX/DmPQ9tDXYyRj9VDTxPH9gJ2FxhxQeA0lRXeaj8xc6Z/bQmDpzSHBpo/
         frfpXZL+KFi+sBFJVPIKd1tPK8AFkqKsNGJhEcheMGS0MA4yrHfk40wQ8PFvN0r7t6I/
         0eD1SEyeIk5s3UhjuhSvjJyJDVZZb0ApjRjUwCgiAS/i5DL1KczGgkC4idtdZolm4poS
         saCZgG3ildAzt6+jFLwkJj5VF1o+YYv1pnPMkPzlyUnb3Dp9+m6GBXNQErSUVbkaYSlf
         9F6YpHnYiE1PuSBsM3Y1EjDxgig/AAuL8IeOwRiqC+xASGOA3H7+2WzQ/3HTeft7ymD9
         VYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6ivCmFFC7PjiDA7Y0YmSnWezwLJYGM7h1yYdjY0fAfE=;
        b=gp3iL6wHh0Cx6T14cpAax+dwilJMycxhxFhtz5/9XFasA5gR240jhZ2JfOBSV9cdaH
         +q2/vWRp08Px4mjMRI7UvP8Ei3lX4+dEqT8liLF5GsYbd+1kJ+Q3VDh9bva6tzkwqiYx
         qwRy28J3eKPtzcFpmEDKfjEKU6betWSVceqQo28TNe2gNmV+gUevgWRa2FWB29uvKzB2
         3ZKmdbbO3gHrjUcAR68mTBbX3xi15w9zg5znPo8IRsRD6VWkXZdCqHBjsZOt6a8tRxkB
         qnrwLq3YQfQVa92KG7fQjtkdbGvPfVopz/+7wWnXNlfv0tLyXIR7FtqH9TDWsGBCi25e
         uMDg==
X-Gm-Message-State: APjAAAWP2IN3FHl/cRhBFCeLkxxK87cf784b6PZEnJBrFrnSW8v+6d92
        PWeR4q/vVRJWqTbthNHCxd/vrCx8eZiGndvCBRDTmekbDDo=
X-Google-Smtp-Source: APXvYqwxXBqCOFI0USJVd9evR0gkNiOSLii1a/BUmGjBZ170E+BB48l63fkXxkfGnV2qwmHjMnLDY4LRoP+o5DNrEfc=
X-Received: by 2002:a6b:ef15:: with SMTP id k21mr21373092ioh.302.1580792455152;
 Mon, 03 Feb 2020 21:00:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Mon, 3 Feb 2020 21:00:54 -0800 (PST)
From:   JH <jupiter.hce@gmail.com>
Date:   Tue, 4 Feb 2020 16:00:54 +1100
Message-ID: <CAA=hcWQuz9QTvbRJgFXBbYrB9RBmWajCJ=oD49DyEaLw91t2bQ@mail.gmail.com>
Subject: Failed to can wifi Invalid Sched_scan parameters
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     connman <connman@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here is more debug information:

# lsmod
Module                  Size  Used by
option                 45056  0
usb_wwan               20480  1 option
usbserial              36864  2 option,usb_wwan
mwifiex_sdio           36864  0
mwifiex               282624  1 mwifiex_sdio
evbug                  16384  0

# dmesg | grep mwifiex
[   34.511371] mwifiex_sdio mmc0:0001:1: info: FW download over, size
258680 bytes
[   34.788787] mwifiex_sdio mmc0:0001:1: WLAN FW is active
[   34.873196] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x242 error, result=0x2
[   34.880490] mwifiex_sdio mmc0:0001:1: mwifiex_process_cmdresp: cmd
0x242 failed during       initialization
[   35.143577] mwifiex_sdio mmc0:0001:1: info: MWIFIEX VERSION:
mwifiex 1.0 (14.68.36.p60)
[   35.152105] mwifiex_sdio mmc0:0001:1: driver_version = mwifiex 1.0
(14.68.36.p60)
[   59.004255] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[   85.976707] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[  166.949603] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[  409.846886] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[  709.774170] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 1009.659982] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 1309.572448] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 1609.481624] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 1909.370729] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 2209.279569] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 2509.170356] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 2809.085551] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 3108.989242] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 3348.887201] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 3375.844143] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 3456.825648] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 3699.809750] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 3699.952233] mwifiex_sdio mmc0:0001:1: info: trying to associate to
'Centaur24GRouter1' bssid 68:ff:7b:3e:d4:24
[ 3700.025358] mwifiex_sdio mmc0:0001:1: info: associated to bssid
68:ff:7b:3e:d4:24 successfully
[ 3706.132761] mwifiex_sdio mmc0:0001:1: info: successfully
disconnected from 68:ff:7b:3e:d4:24: reason code 15
[ 3717.123970] mwifiex_sdio mmc0:0001:1: info: trying to associate to
'Centaur24GRouter1' bssid 68:ff:7b:3e:d4:24
[ 3717.441578] mwifiex_sdio mmc0:0001:1: info: associated to bssid
68:ff:7b:3e:d4:24 successfully
[ 3723.543587] mwifiex_sdio mmc0:0001:1: info: successfully
disconnected from 68:ff:7b:3e:d4:24: reason code 15
[ 3727.794640] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 3736.782236] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 3763.809277] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 3844.811545] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 4087.803951] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 4387.748929] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 4687.718771] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 4987.705092] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 5287.646353] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 5587.643812] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[ 5753.760955] mwifiex_sdio mmc0:0001:1: info: trying to associate to
'Centaur24GRouter1' bssid 68:ff:7b:3e:d4:24
[ 5753.838800] mwifiex_sdio mmc0:0001:1: info: associated to bssid
68:ff:7b:3e:d4:24 successfully
[ 5754.162917] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
[ 5848.971534] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
[19611.826761] mwifiex_sdio mmc0:0001:1: info: successfully
disconnected from 68:ff:7b:3e:d4:24: reason code 3
[19654.931976] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[19686.885717] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[19713.896301] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[19794.907957] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[20037.947625] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[20337.974674] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[20637.962485] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[20716.944299] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[20743.951609] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[20824.989582] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[21068.022269] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[21367.979313] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[21667.945929] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[21967.964944] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[22267.953450] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[22567.955314] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[22867.961508] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[23168.000460] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[23468.005767] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[23676.996473] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
[23703.958751] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters

Where is the WiFi driver? Please let me know if you need more debug information.

Thank you.

Kind regards,

- jh


On 2/4/20, JH <jupiter.hce@gmail.com> wrote:
> Hi,
>
> I am running kernel 4.19.75 on iMX6, the WiFi was working most of
> time, but from time to time, the connman could not get WiFi be
> connected due to following error:
>
> [23703.958751] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
> Invalid Sched_scan parameters
>
> What does that error means, in which circumstance it occurred? How can
> we prevent it?
>
> Thank you.
>
> Kind regards,
>
> - jh
>
