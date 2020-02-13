Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A8A15CD9C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 22:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBMVyy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 16:54:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36926 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgBMVyy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 16:54:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so8481400wme.2;
        Thu, 13 Feb 2020 13:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:references:subject:to:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=/H25Ntzq5GhZEzxDEWAUk2cWpXoHsQi11PWiKlH9h+Q=;
        b=XIiVq9sNfiYBWhXPTTeOa3mYbejzfH7yYAutDvrsHNEnutkNt7xRJTbj8dw1e54jc+
         Bu7ps6byEMh/oKpRo7PRH8jaC92i5V3dn+cu8EDfJUXaLK8pAeFZerZULXNQTMgc0cPU
         SDR6OCQFjdSWNEXqeHbSEU9Oh4ka2EWhB64frK701HPWWfxc5oXi13oZtG0FHMZx91y4
         mlesPlyk6jxf29dyfo/RrVnt5k2vykmvfZHi4HX3sh+VsxQR46jth8O1aQr1KD/IZOhN
         8QPx8d47FliACI/KeJcEC43OLzGKBthKQn8tBc/RT30BtbVQv9tO9FqI7T2cMObVz02W
         Fvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:references:subject:to:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=/H25Ntzq5GhZEzxDEWAUk2cWpXoHsQi11PWiKlH9h+Q=;
        b=lZybpdNvnfs5VFJiErWZF/FqXoA71yjAGvPQjSxSk17ZACYzusSrePiiERi08JIqPe
         FXQp/2pXoayQmThDWHbPYr+XpvtCWXaFykKP8NAj0QJmkEvQuaIBdVErp4pGi6oM4EU4
         rOuQi6418BXcCUQchKuwZktZOF3nlMw9bsqrRVnWhB2+Pwd2ux65vSG0dCTDjAXfC2Jd
         2v8fXiCKYzJp39MbYLW155DhWUl++jVYI7lEQF15xTjVq1USNiJRESB55gdXFRDtg/hh
         l2lcs9FRhb1qoq4ytgnWM94mKx/C4j7oW+57hUUp3RM6ChAUmZ2u+9NaBgZ9GxpsD30r
         3zLQ==
X-Gm-Message-State: APjAAAVcacbIcLPGsQa7VmPXa0PLUMy+GdHnM37GGamzhMOz+wP7ouPC
        0lvZP3NIorQ6mBslEGehXno=
X-Google-Smtp-Source: APXvYqyVMW6smrU7FD6oXdtce0CP9biKgdLpKNSQz+uQRf7dSWWgjiJm71lhuPW7eYKvWtgD3yw2AQ==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr117151wmi.37.1581630892601;
        Thu, 13 Feb 2020 13:54:52 -0800 (PST)
Received: from supervisor.net28 ([46.53.250.234])
        by smtp.gmail.com with ESMTPSA id s139sm4805306wme.35.2020.02.13.13.54.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 13 Feb 2020 13:54:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Cc:     linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <op.0fudjzcyhxa7s4@supervisor.net28>
 <20200211214705.GD16391@atomide.com> <op.0fuie5cdhxa7s4@supervisor.net28>
 <20200211232425.GE16391@atomide.com> <op.0fu85owhhxa7s4@supervisor.net28>
 <20200212150722.GF16391@atomide.com> <20200212162131.GI16391@atomide.com>
 <op.0fwkyxvihxa7s4@supervisor.net28> <20200213041112.GL16391@atomide.com>
 <op.0fw0oas5hxa7s4@supervisor.net28> <20200213161157.GN16391@atomide.com>
Subject: Droid 4 WiFi firmware loading error
To:     sre@kernel.org
Date:   Fri, 14 Feb 2020 00:54:50 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Arthur D." <spinal.by@gmail.com>
Message-ID: <op.0fx4hozhhxa7s4@supervisor.net28>
In-Reply-To: <20200213161157.GN16391@atomide.com>
User-Agent: Opera Mail/12.16 (Linux)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello.

Some users have reported that they have issues with WiFi firmware
loading on Droid 4. The fragment of dmesg for the issue follows
at the bottom of this mail.

With the help of Tony Lindgren I have found that the root of the
issue was Bluetooth firmware loaded before WiFi driver (wlcore).

Now we need to change the kernel to make it load Bluetooth firmware
only after WiFi firmware is loaded. So the bug will not be triggered.

Any ideas on how it should be done?

P.S. When I do "rmmod hci_uart" on Droid 4 device, I get something
like endless loop of error reporting from kernel. The fragment of
dmesg can be downloaded from https://dropmefiles.com/wCPMF
I'm not sure where to report this one.

--
Best regards, Arthur D.


[   15.951904] ------------[ cut here ]------------
[   16.028137] WARNING: CPU: 1 PID: 23 at
drivers/net/wireless/ti/wlcore/sdio.c:78 wl12xx_sdio_raw_read+0xcc/0x15c
[wlcore_sdio]
[   16.211669] Modules linked in: omapdrm drm_kms_helper cfbfillrect
syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea
snd_soc_omap_hdmi wl12xx wlcore mac80211 panel_dsi_cm libarc4
sha256_generic libsha256 sha256_arm cfg80211 joydev mousedev evdev
pwm_vibra snd_soc_audio_graph_card ff_memless phy_generic
snd_soc_simple_card_utils phy_mapphone_mdm6600(+) led_bl cpufreq_dt
gpio_keys pwm_omap_dmtimer connector_hdmi omapdss omapdss_base
omap4_keypad drm matrix_keymap drm_panel_orientation_quirks cec
omap_mailbox omap_sham omap_aes_driver omap2430 ohci_platform ohci_hcd
ehci_omap ehci_hcd st_accel_spi st_sensors_spi st_accel_i2c st_sensors_i2c
st_accel st_sensors industrialio_triggered_buffer kfifo_buf omap_des
libdes crypto_engine omap_crypto wlcore_sdio omap_hdq wire cn
phy_cpcap_usb musb_hdrc cpcap_adc udc_core cpcap_battery usbcore
usb_common rtc_cpcap cpcap_pwrbutton cpcap_charger phy_omap_usb2
industrialio snd_soc_cpcap leds_cpcap atmel_mxt_ts hci_uart btbcm lm75
[   16.211669]  leds_lm3532
[   16.226989] systemd-journald[105]: Compressed data object 989 -> 808
using LZ4
[   17.050018]  hwmon led_class bluetooth ecdh_generic ecc libaes
motorola_mdm n_gsm snd_soc_omap_mcbsp snd_soc_ti_sdma snd_soc_core
snd_pcm_dmaengine snd_pcm snd_timer omap_wdt watchdog snd soundcore autofs4
[   17.144073] phy-mapphone-mdm6600 usb-phy@1: Waiting for power up
request to complete..
[   17.255035] CPU: 1 PID: 23 Comm: kworker/1:1 Tainted: G
W         5.5.0-00039-gadd2f906e747-dirty #23
[   17.657806] Hardware name: Generic OMAP4 (Flattened Device Tree)
[   17.657867] Workqueue: events request_firmware_work_func
[   17.861297] [<c0112b88>] (unwind_backtrace) from [<c010cafc>]
(show_stack+0x10/0x14)
[   17.861297] [<c010cafc>] (show_stack) from [<c090753c>]
(dump_stack+0xb4/0xd0)
[   17.861450] [<c090753c>] (dump_stack) from [<c013aaf0>]
(__warn+0xd0/0xf8)
[   17.861450] [<c013aaf0>] (__warn) from [<c013abbc>]
(warn_slowpath_fmt+0xa4/0xb4)
[   17.861450] [<c013abbc>] (warn_slowpath_fmt) from [<bf1bf418>]
(wl12xx_sdio_raw_read+0xcc/0x15c [wlcore_sdio])
[   17.861633] [<bf1bf418>] (wl12xx_sdio_raw_read [wlcore_sdio]) from
[<bf525074>] (wl12xx_get_mac+0x150/0x324 [wl12xx])
[   17.861938] [<bf525074>] (wl12xx_get_mac [wl12xx]) from [<bf410380>]
(wlcore_nvs_cb+0x250/0xad8 [wlcore])
[   17.862121] [<bf410380>] (wlcore_nvs_cb [wlcore]) from [<eccfdb00>]
(0xeccfdb00)
[   17.868988] ---[ end trace b49285f1f3a91e50 ]---
[   17.868988] wl1271_sdio mmc4:0001:2: sdio read failed (-110)
[   17.869079] wlcore: ERROR couldn't get hw info
