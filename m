Return-Path: <linux-wireless+bounces-7815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564178C8EF9
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 02:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B41B21301
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 00:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F863D;
	Sat, 18 May 2024 00:45:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from pv237.mxout.mta2.net (pv237.mxout.mta2.net [178.33.242.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663C637
	for <linux-wireless@vger.kernel.org>; Sat, 18 May 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.242.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715993103; cv=none; b=AQ/IHXOpX/FWeKaO8c5Lc3iam9Za7a3OR7bkyI/XhWT/YzzsMBEgA7eBuphYOGfFK86rDkA/R4K4K3Fqv6GivrhtiJgvPctUd7WvVfh8bKkod4Ncsn4raxHBdUjs1tXbroLVzVfOxwM1Q/IXkD42OcplL5KbiOnQE8nocJCB96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715993103; c=relaxed/simple;
	bh=1Sd3Ix+y1hWAfFq1pSpE2cOVQpwQd6cLe5vG5XXSZIY=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=UbWYGJxTp0Ni9L4YgmuMh8K4443aIqaiqnxzJ8cMRd2PAsz0Bc5BVrl3NeCd+Ey4kV8NilDvv31HQPVI9OvQAG07C5k4OlTgl4o/cZrjw3KponQMwytfTFX79ZI/zFeqoXHZ5mSKnzY66yd8ImDuRK3XaPCtjrywjNF+ttBa+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=bounces.elasticemail.net; arc=none smtp.client-ip=178.33.242.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounces.elasticemail.net
From: Larry Finger <Larry.Finger@gmail.com>
Date: Sat, 18 May 2024 00:43:51 +0000
Subject: [PATCH v2] linux-firmware: Add ordinary firmware for RTL8821AU device
Message-Id: <4un2zu7ofgoz.76eagbFcUhFoEANVDT3_qQ2@1EHFQ.trk.elasticemail.com>
Reply-To: Larry Finger <Larry.Finger@gmail.com>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, Larry Finger <Larry.Finger@gmail.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-Msg-EID: 76eagbFcUhFoEANVDT3_qQ2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

This firmware was extracted from the 20210708 release of the vendor
driver for this device. The firmware corresponds with the latest
release by Realtek.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
Changes
v2 - Changed address to linux-firmware@kernel.org
---
 rtw88/README          |   3 +++
 WHENCE                |   1 +
 rtw88/rtw8821a_fw.bin | Bin 0 -> 31898 bytes
 3 files changed, 4 insertions(+)
 create mode 100644 rtw88/rtw8821a_fw.bin

diff --git a/rtw88/README b/rtw88/README
index 2bdb04bd..469db2f7 100644
--- a/rtw88/README
+++ b/rtw88/README
@@ -19,6 +19,9 @@ except that the device cannot be waken from the wireless NICs.
 
 Currently supported devices with corresponding firmwares:
 
+RTL8821AU
+    rtw8821a_fw.bin
+
 RTL8822BE
     rtw8822b_fw.bin
 
diff --git a/WHENCE b/WHENCE
index ee39f893..1a496a67 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3226,6 +3226,7 @@ Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
 Driver: rtw88 - Realtek 802.11ac WLAN driver for RTL8822BE and RTL8822CE
 
 Info: Sent to Larry Finger by Realtek engineer Yan-Hsuan Chuang <yhchuang@realtek.com>
+File: rtw88/rtw8821a_fw.bin
 File: rtw88/rtw8822b_fw.bin
 File: rtw88/rtw8822c_fw.bin
 File: rtw88/rtw8822c_wow_fw.bin
diff --git a/rtw88/rtw8821a_fw.bin b/rtw88/rtw8821a_fw.bin
new file mode 100644
index 0000000000000000000000000000000000000000..89181109691c610c1e33d809051c5bef64180713
GIT binary patch
literal 31898
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
bp=|mvzQFUx@#fR_pdt9f!1YphpwIsYf7wRI

literal 0
HcmV?d00001

-- 
2.45.0


https://1EHFQ.trk.elasticemail.com/tracking/unsubscribe?d=6h-KUIvpWltTDYE_28K1Tr1vZnE8ckxj9Tjv6rC6tevsIEnkm8IaHKHwhQlIhZThcu6dhgVDGULso4JOZXP23oiWoi4gBzMGYbyeemsbYzI40

