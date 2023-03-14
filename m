Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357FC6B9FE2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 20:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCNTjL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 15:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCNTjK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 15:39:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D846B3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 12:39:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso10925735wms.5
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg.ch; s=google; t=1678822745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wMbimBz0PMgsbpz6KW/uvP39idCjZOAkO2f3jMaNc7U=;
        b=M1N6xkKgD0q9Mv0EsEZJzV5zOQvHh7K4nZIGYHRRe38PFRVEr5LeY6hBuLziHn7C6M
         0BLWItUxOC7h/weA41LpckvsFyroekG3Z4foLsFzYB6thqTAhdJlwy0j2QMrNMiQXwVx
         Q801G4IGYV73c2A/0HYVAGXki4tbY4BIZIIZWmkb/AwvH7JYdM7T0U7L8N5Uz4LZGBXn
         ZHpKskrVHRt9zaIimisEyicr1tMzvtf2ik0VuQw1qAnc/Ea7BiF19Z3qffqTNK1fdxWA
         FSFq4S52/WCsuhRu95mbRWBkTgIwWi6G82fPyb2xx+3OQ53hSvt/3dvzqMXUXyi5rHGA
         fEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678822745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMbimBz0PMgsbpz6KW/uvP39idCjZOAkO2f3jMaNc7U=;
        b=sUvjMPE4uIypr73xR+Lv1TeDZFMRn6yR2CofXbird1uwKueAYJpoq6YdG3xFV5w5Uf
         S27D0VMO7jGdWTSLqHkxKnDvofITj30g/0teoAZkiXQoTDgymEW9sSNimQIIqinp7MKA
         5lcEmbZ+HpTkjQkIKHg9J7saTAzn2rr3TaLNAHcCJq/tGloChBbYpWzIMcK4I0pWY2bp
         q+ucRijv6qHvXKJwTcs3DjUiE6bjXv0YTSHORYbdLePilRwTMR8xlpocWLXlmChP9hD0
         RabVeWfkPlXlqZA9oqHi64fDZhSevLXgxKjw8Ye2bKE9ErA5km57NTdCNdUmlQlY+Syp
         4K2w==
X-Gm-Message-State: AO0yUKXaTCOHTe/SUGIeEEhrCJlKNxGXXCAbY+7MMJl0CFbUEiQMucFH
        Ge+KG7ucE7U6PgjzyW7zrCBHEY8mRu0+UzFAS516jA==
X-Google-Smtp-Source: AK7set9PAUgXakfRqDGWBPDTo3mEyHOrUlMZiOOcc8UB/zYA7PFw9ydty9cey9yUke39AYU1WgRI5sZNLWN6FI4SOT4=
X-Received: by 2002:a05:600c:a:b0:3eb:5824:f0ec with SMTP id
 g10-20020a05600c000a00b003eb5824f0ecmr4469246wmc.2.1678822745273; Tue, 14 Mar
 2023 12:39:05 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Tue, 14 Mar 2023 20:38:49 +0100
Message-ID: <CANnVG6=a3etRagG+RaSEH-b4_nfzxpEKffQtuMWrttrbgjunZQ@mail.gmail.com>
Subject: wifi breakage due to commit "wifi: brcmfmac: add support for
 vendor-specific firmware api"
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey Arend

I recently bisected a user-reported WiFi breakage on the Raspberry Pi
3B+ to your commit
https://github.com/torvalds/linux/commit/d6a5c562214f26e442c8ec3ff1e28e1667=
5d1bcf
https://lore.kernel.org/r/20221129135446.151065-4-arend.vanspriel@broadcom.=
com

On our end, the issue was reported here:
https://github.com/gokrazy/wifi/issues/3

As of Linux 6.2.6, this seems to still be unfixed, so I wanted to
check in and see if you could take a look please?

Thank you.

Here=E2=80=99s a dmesg diff between the previous commit (da6d9c8ecd00) and =
the
broken commit (d6a5c562214f):

--- /proc/self/fd/11 2023-03-14 20:28:20.167241380 +0100
+++ /proc/self/fd/12 2023-03-14 20:28:20.167241380 +0100
@@ -1,5 +1,5 @@
  Booting Linux on physical CPU 0x0000000000 [0x410fd034]
- Linux version 6.1.0-rc7-01766-gda6d9c8ecd00 (gokrazy@docker)
(aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #81
SMP PREEMPT Wed Mar  1 20:57:29 UTC 2017
+ Linux version 6.1.0-rc7-01767-gd6a5c562214f (gokrazy@docker)
(aarch64-linux-gnu-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39) #82
SMP PREEMPT Wed Mar  1 20:57:29 UTC 2017
  random: crng init done
  Machine model: Raspberry Pi 3 Model B Plus Rev 1.3
  efi: UEFI not found.
@@ -29,7 +29,7 @@
  Fallback order for Node 0: 0
  Built 1 zonelists, mobility grouping on.  Total pages: 238896
  Policy zone: DMA
- Kernel command line:
video=3DComposite-1:720x480@60i,margin_left=3D32,margin_right=3D32,margin_t=
op=3D32,margin_bottom=3D32
dma.dmachans=3D0x7ff5 bcm2709.boardrev=3D0xa020d3
bcm2709.serial=3D0xe33b7b2a bcm2709.uart_clock=3D48000000
bcm2709.disk_led_gpio=3D29 bcm2709.disk_led_active_low=3D0
smsc95xx.macaddr=3DB8:27:EB:3B:7B:2A vc_mem.mem_base=3D0x3ec00000
vc_mem.mem_size=3D0x40000000  console=3Dtty1 console=3DttyS0,115200
root=3DPARTUUID=3D60c24cc1-f3f9-427a-8199-2e18c40c0001/PARTNROFF=3D2
init=3D/gokrazy/init rootwait panic=3D10 oops=3Dpanic
+ Kernel command line:
video=3DComposite-1:720x480@60i,margin_left=3D32,margin_right=3D32,margin_t=
op=3D32,margin_bottom=3D32
dma.dmachans=3D0x7ff5 bcm2709.boardrev=3D0xa020d3
bcm2709.serial=3D0xe33b7b2a bcm2709.uart_clock=3D48000000
bcm2709.disk_led_gpio=3D29 bcm2709.disk_led_active_low=3D0
smsc95xx.macaddr=3DB8:27:EB:3B:7B:2A vc_mem.mem_base=3D0x3ec00000
vc_mem.mem_size=3D0x40000000  console=3Dtty1 console=3DttyS0,115200
root=3DPARTUUID=3D60c24cc1-f3f9-427a-8199-2e18c40c0001/PARTNROFF=3D1
init=3D/gokrazy/init rootwait panic=3D10 oops=3Dpanic
  Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
  Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
  mem auto-init: stack:all(zero), heap alloc:off, heap free:off
@@ -245,13 +245,13 @@
  Console: switching to colour dummy device 80x25
  vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_ops)
  mmc0: host does not support reading read-only switch, assuming write-enab=
le
- vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops)
  mmc0: new high speed SDHC card at address aaaa
- vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_ops)
+ vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops)
  mmcblk0: mmc0:aaaa SC16G 14.8 GiB
+ vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_ops)
  vc4-drm soc:gpu: bound 3f004000.txp (ops vc4_txp_ops)
- vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops vc4_crtc_ops)
   mmcblk0: p1 p2 p3 p4
+ vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops vc4_crtc_ops)
  vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops vc4_crtc_ops)
  vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops vc4_crtc_ops)
  vc4-drm soc:gpu: bound 3fc00000.v3d (ops vc4_v3d_ops)
@@ -269,11 +269,11 @@
  cfg80211: Loading compiled-in X.509 certificates for regulatory database
  cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
  platform regulatory.0: Direct firmware load for regulatory.db failed
with error -2
- ALSA device list:
  cfg80211: failed to load regulatory.db
-   #0: vc4-hdmi
  mmc1: SDHCI controller on 3f300000.mmc [3f300000.mmc] using PIO
- VFS: Mounted root (squashfs filesystem) readonly on device 179:3.
+ ALSA device list:
+   #0: vc4-hdmi
+ VFS: Mounted root (squashfs filesystem) readonly on device 179:2.
  devtmpfs: mounted
  Freeing unused kernel memory: 9216K
  Run /gokrazy/init as init process
@@ -284,6 +284,7 @@
      TERM=3Dlinux
  mmc1: new high speed SDIO card at address 0001
  usb 1-1: new high-speed USB device number 2 using dwc2
+ EXT4-fs (mmcblk0p4): recovery complete
  EXT4-fs (mmcblk0p4): mounted filesystem with ordered data mode.
Quota mode: none.
  hub 1-1:1.0: USB hub found
  hub 1-1:1.0: 4 ports detected
@@ -300,12 +301,14 @@
  Bluetooth: HCI socket layer initialized
  Bluetooth: L2CAP socket layer initialized
  Bluetooth: SCO socket layer initialized
+ brcmfmac: brcmf_fwvid_request_module: mod=3Dwcc: failed -2
+ ieee80211 phy0: brcmf_attach: brcmf_fwvid_attach failed
  Bluetooth: HCI UART driver ver 2.3
+ brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
  Bluetooth: HCI UART protocol H4 registered
  Bluetooth: HCI UART protocol Broadcom registered
  hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
  hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
- brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Mar  2
2020 23:30:41 version 7.45.202 (r724630 CY) FWID 01-72f6ece2
  uart-pl011 3f201000.serial: no DMA platform data
  Bluetooth: hci0: BCM: chip id 107
  Bluetooth: hci0: BCM: features 0x2f
@@ -316,7 +319,4 @@
  Bluetooth: hci0: BCM: 'brcm/BCM4345C0.hcd'
  Bluetooth: hci0: BCM: 'brcm/BCM.raspberrypi,3-model-b-plus.hcd'
  Bluetooth: hci0: BCM: 'brcm/BCM.hcd'
- Bluetooth: hci0: unexpected cc 0x1003 length: 1 < 9
- Bluetooth: hci0: Opcode 0x1003 failed: -38
  IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
- IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
