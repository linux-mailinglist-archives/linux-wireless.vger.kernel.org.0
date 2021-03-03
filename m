Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9E132C108
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhCCVQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbhCCDpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Mar 2021 22:45:19 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4730EC061356
        for <linux-wireless@vger.kernel.org>; Tue,  2 Mar 2021 19:44:00 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h4so15294794pgf.13
        for <linux-wireless@vger.kernel.org>; Tue, 02 Mar 2021 19:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cw/C/Hp7HXpJXE9ozrgzF5uT1arcWJuzdAxoWKlNXWo=;
        b=lqFd5FLdAPXOLXB5MLYLDnNE+fSkq99jG4SIH+8xSXMrmrb5zlhq89PylNTI0vKivu
         1LyCkzip84PbeEDHhlC55z42T1YDjAYfefvxjq7jH6ZRdJMMHku7S6MrrFyKPgm37P+p
         kByeEDG09WILgDKclVyO6YbRkiRT89JPb6sIwIEW0B0ALqFGhPcLVOtGFPE9lfumgRV7
         3S4TcRbYqiHrDrpNIT76MOl1het5MTS9B5QJNA2qq1+yeA1Of5nTix+bD7MNNFYUwDES
         PiCSU98nGUfM5s2lZB9cvoD6laZkeTybJOX8VJcfFFk/vcZTOpoljpdEWe/YMAcakdgw
         N1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cw/C/Hp7HXpJXE9ozrgzF5uT1arcWJuzdAxoWKlNXWo=;
        b=sqZ9iYellrYVZDYOilEfpE7ex+685pbJCYKIrmZ2TUxDpVOBac+PMdQ8e7sethKDzs
         1MVXlRH121bszRQaCWoKo+C7GH9MRPx4b0YYQewwWGJWsxWDiRR/ZvYEgrSSAz45uYv7
         nh6bF1Tfcl3sKLmtSG/jK2ViuVGN9n0JKkuub0Cy+5z1FYX3BJozFrep/Du+mtvznUDw
         uFRu3DcpJh1tJDPqhB4W8GpkN3LG+7HKN3ZSnwR3r5QJtzcr+6KuoacssIx1W3WIaLwP
         VS9Q+XSCu4KbbL38op3qUyMLarqm+7lwYvQngn++GM9xMsVWCJzWOveSqDOVAfIEU1Og
         gUCA==
X-Gm-Message-State: AOAM531SV6IlhW9BxZFsQ8o8HLRaHbTsZlAjTE6ene959cSAYGSj10rB
        Z5AiODjiIv17U2JVTD+fXaiEfn2OInLnmGdK0yAkjQ==
X-Google-Smtp-Source: ABdhPJyoQV88wz5yLA12azfLH2/Krg0NW2h0WaEugR+3SKDVT8A8bS547AYyhx3WJgupw8dt7lDDuQ==
X-Received: by 2002:a63:5ec3:: with SMTP id s186mr20743396pgb.179.1614743039551;
        Tue, 02 Mar 2021 19:43:59 -0800 (PST)
Received: from localhost.localdomain ([218.255.1.14])
        by smtp.gmail.com with ESMTPSA id iq6sm5201646pjb.31.2021.03.02.19.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 19:43:59 -0800 (PST)
From:   "Eric Y.Y. Wong" <eric.wongyeungyan@gmail.com>
To:     linux-wireless@vger.kernel.org, lorenzo@kernel.org, nbd@nbd.name
Cc:     ryder.lee@mediatek.com,
        "Eric Y.Y. Wong" <eric.wongyeungyan@gmail.com>
Subject: [PATCH v2] mt76: mt76x0u: Add support for TP-Link T2UHP(UN) v1
Date:   Wed,  3 Mar 2021 11:43:52 +0800
Message-Id: <20210303034352.25051-1-eric.wongyeungyan@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two variants of TP-Link Archer T2UHP V1, which are US and UN:

https://www.tp-link.com/us/support/download/archer-t2uhp/
https://www.tp-link.com/hk/support/download/archer-t2uhp/v1/

From the driver source code provided by the vendor:

https://www.tp-link.com/hk/support/download/archer-t2uhp/v1/#Driver

eric@eric-VirtualBox:~/src$ grep -n USB_DEVICE.*0x2357 DPA_mt7610u_wifi_sta_v3004_rev1_20140529/NETIF/common/rtusb_dev_id.c
45:	{USB_DEVICE(0x2357,0x0105)}, /* T1Uv1 */
46:	{USB_DEVICE(0x2357,0x010B)}, /* T2UHP_UN_v1 */
47:	{USB_DEVICE(0x2357,0x0123)}, /* T2UHP_US_v1 */

eric@eric-VirtualBox:~/src$ lsusb -d 2357:
Bus 001 Device 003: ID 2357:010b TP-Link WiFi
eric@eric-VirtualBox:~/src$ sudo modprobe mt76x0u
eric@eric-VirtualBox:~/src$ sudo sh -c "echo 2357 010b > /sys/bus/usb/drivers/mt76x0u/new_id"

[snip]

eric@eric-VirtualBox:~/src$ ifconfig -a
enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 08:00:27:74:d9:ee  txqueuelen 1000  (Ethernet)
        RX packets 78  bytes 16146 (16.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 75  bytes 8413 (8.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 56  bytes 5496 (5.4 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 56  bytes 5496 (5.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlx18d6c71b6e3e: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.106  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::21c7:2d90:e47d:ee48  prefixlen 64  scopeid 0x20<link>
        ether 18:d6:c7:1b:6e:3e  txqueuelen 1000  (Ethernet)
        RX packets 37  bytes 5345 (5.3 KB)
        RX errors 0  dropped 7  overruns 0  frame 0
        TX packets 77  bytes 10513 (10.5 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eric@eric-VirtualBox:~/src$ dmesg | tail -n 30
               12:51:25.551584 main     Log opened 2021-03-01T12:51:25.551572000Z
[   46.855763] 12:51:25.551995 main     OS Product: Linux
[   46.855838] 12:51:25.552075 main     OS Release: 5.4.0-66-generic
[   46.855897] 12:51:25.552150 main     OS Version: #74-Ubuntu SMP Wed Jan 27 22:54:38 UTC 2021
[   46.855971] 12:51:25.552207 main     Executable: /opt/VBoxGuestAdditions-6.1.16/sbin/VBoxService
               12:51:25.552208 main     Process ID: 898
               12:51:25.552209 main     Package type: LINUX_64BITS_GENERIC
[   46.858699] 12:51:25.554921 main     6.1.16 r140961 started. Verbose level = 0
[   46.863116] 12:51:25.559319 main     vbglR3GuestCtrlDetectPeekGetCancelSupport: Supported (#1)
[  140.687550] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[  140.838279] usb 1-2: New USB device found, idVendor=2357, idProduct=010b, bcdDevice= 1.00
[  140.838281] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  140.838283] usb 1-2: Product: WiFi
[  140.838284] usb 1-2: Manufacturer: MediaTek
[  140.838285] usb 1-2: SerialNumber: 1.0
[  178.374187] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[  178.378370] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[  178.417507] usbcore: registered new interface driver mt76x0u
[  178.557165] usb 1-2: reset high-speed USB device number 3 using xhci_hcd
[  178.720436] mt76x0u 1-2:1.0: ASIC revision: 76100002 MAC revision: 76502000
[  180.156077] mt76x0u 1-2:1.0: EEPROM ver:02 fae:04
[  181.190558] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[  181.225560] mt76x0u 1-2:1.0 wlx18d6c71b6e3e: renamed from wlan0
[  188.660826] wlx18d6c71b6e3e: authenticate with d0:17:c2:e0:d7:9c
[  189.447781] wlx18d6c71b6e3e: send auth to d0:17:c2:e0:d7:9c (try 1/3)
[  189.618282] wlx18d6c71b6e3e: authenticated
[  189.619008] wlx18d6c71b6e3e: associate with d0:17:c2:e0:d7:9c (try 1/3)
[  189.715268] wlx18d6c71b6e3e: RX AssocResp from d0:17:c2:e0:d7:9c (capab=0x1011 status=0 aid=8)
[  189.734720] wlx18d6c71b6e3e: associated
[  190.233239] IPv6: ADDRCONF(NETDEV_CHANGE): wlx18d6c71b6e3e: link becomes ready

Signed-off-by: Eric Y.Y. Wong <eric.wongyeungyan@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index a593a7796d23..f2b2fa733845 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -32,7 +32,8 @@ static struct usb_device_id mt76x0_device_table[] = {
 	{ USB_DEVICE(0x20f4, 0x806b) },	/* TRENDnet TEW-806UBH  */
 	{ USB_DEVICE(0x7392, 0xc711) }, /* Devolo Wifi ac Stick */
 	{ USB_DEVICE(0x0df6, 0x0079) }, /* Sitecom Europe B.V. ac  Stick */
-	{ USB_DEVICE(0x2357, 0x0123) }, /* TP-LINK T2UHP */
+	{ USB_DEVICE(0x2357, 0x0123) }, /* TP-LINK T2UHP_US_v1 */
+	{ USB_DEVICE(0x2357, 0x010b) }, /* TP-LINK T2UHP_UN_v1 */
 	/* TP-LINK Archer T1U */
 	{ USB_DEVICE(0x2357, 0x0105), .driver_info = 1, },
 	/* MT7630U */
-- 
2.30.1

