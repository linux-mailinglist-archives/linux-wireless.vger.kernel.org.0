Return-Path: <linux-wireless+bounces-36649-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KBzLwkRDGr6VQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36649-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:28:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 432ED57911E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 09:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 501C830A0C88
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 07:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D563D6461;
	Tue, 19 May 2026 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gBHAWm59"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E73D349C
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175474; cv=none; b=uObMx3B5W5xEXzDJf+Sa4VwzhPOjN+GYq2rOp+9OXASWr/liALbnE1LTX/hkb7gGCLAxi3pEFtdRRtjfkO4XsFde5lqgQsDmIvvkjWDgi5j1iucuBVrPsdbhNWNpcYkMflXvWF9iTyjIlIqZvh1o41044ENg34VdFxlHtlQmt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175474; c=relaxed/simple;
	bh=7IQfH24EzbVSysR/boRCqNPCEggZ1AYwVhiRqTSwTG8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EP3DsUz0WqPxDIso7VLSzJeJ9VYc4SCFyD/165FDTGDGGnNH56pcqnnO3r9LDBhoOyBuTS71h31vm/9hKx/z9sWI2MyftF/oqa2uKq/Pxz0i/z8j1k3TWXKIqr7LwvOzJZjL1EIau7G6ulMV3h09/9FO1RNNPxJiw9c1ynuIFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gBHAWm59; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64J7OSSH02916505, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779175468; bh=N7miYF4+SVqWW5XC+spmp9mPf+fv1hA2w9LDfo6atFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=gBHAWm594OvWZz+vbbXoRvKY5Z+Xhe5jrOsxd72ajsGiBZhXB3Urw7V0pF0mzX156
	 tov2BV6L2jRZuaCDGAABhxEwk6BcquoE4GyQbh7pjbPREvKRaR79BGm52o4ecOnJQQ
	 lDOddA4mrpF517SaSHC5poKa6rgCgN2Lo2DabJih23cmU6WFiNsgNtuf6jmXing47T
	 6aCjFQDX92sPuSTfqLc6z/BHMvRtuQfyg9a6kdw0Oy5jVrCnap7HDYpZ61kyYL5Bj9
	 Cvg7+UppFfE7yTZ3pTUtNAXtqKLNABt6cFfSm9gHoSZ6g0Tjutxwj7vsANxoUZ2hlK
	 8slC5Xy7PISow==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64J7OSSH02916505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 15:24:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 May 2026 15:24:28 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 May 2026 15:24:28 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 19 May 2026 15:24:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <wenjie.tsai@realtek.com>
Subject: [RFC rtw-next 1/2] wifi: rtw89: usb: add hw_info sysfs attribute
Date: Tue, 19 May 2026 15:24:14 +0800
Message-ID: <20260519072415.25746-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36649-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 432ED57911E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johnson Tsai <wenjie.tsai@realtek.com>

Expose the device's Serial Number (SN) and UUID from EFUSE through a
read-only `hw_info` sysfs attribute on the USB interface device.

This hardware identification information is essential for user-space
applications to uniquely identify, track, and manage specific Wi-Fi
adapters. For example, in automated factory provisioning or device
management systems, user-space tools rely on the EFUSE SN and UUID
to bind specific configurations to a physical adapter. Currently,
standard wireless APIs do not expose this low-level hardware
information, making this sysfs node the only viable and necessary
solution for user space to extract this data.

Relying on debugfs or setuid binaries is unviable for production
environments, as explicitly requested by Valve (Steam). Steam frequently
runs inside unprivileged containers (e.g., Flatpak) where debugfs and
setuid binaries are inaccessible. Furthermore, many end-user systems
disable debugfs in their kernel configs, and strict access controls
(SELinux, AppArmor) block it regardless of permissions. Since Steam
installs as an unprivileged user, setuid deployments are impossible.
Consequently, exposing this data via a world-readable (0444) sysfs
node is the only functional approach to ensure reliable, unprivileged
access across diverse customer systems.

Example usage from user-space:
  $ cat /sys/bus/usb/devices/2-3.1.2:1.0/hw_info
  SN: 36 42 00 01 23
  UUID: aa ec 2b 7c 0a 55 47 27 8d e0 b3 0f eb cc bb aa

User-space scripts can easily iterate over bound devices to extract
this information:
  for dev in /sys/bus/usb/drivers/rtw89_8852cu/[0-9]*:*; do
      dev_id=$(basename "$dev")
      echo "--- Device: /sys/bus/usb/devices/$dev_id ---"
      cat "$dev/hw_info"
  done

Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
Hi maintainers,

We are submitting this RFC to discuss the most appropriate upstream path for
exposing hardware-specific IDs to unprivileged container environments.

1. Given the strict environment limitations (Flatpak, missing debugfs, LSMs),
   is a read-only sysfs attribute acceptable for this specific hardware data?
2. If exposing this globally via sysfs is not preferred, would it be acceptable
   to restrict the creation of this node to specific vendor VID/PIDs only?
3. If sysfs is strictly a no-go for this use case, what is the upstream-recommended
   method for an unprivileged, sandboxed application to retrieve eFuse data?
---
 drivers/net/wireless/realtek/rtw89/usb.c | 51 +++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index c6d55e669776..53dcb84af5c0 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -1059,6 +1059,41 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev *rtwdev,
 	usb_set_intfdata(intf, NULL);
 }
 
+static ssize_t hw_info_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct ieee80211_hw *hw;
+	struct rtw89_dev *rtwdev;
+	struct rtw89_efuse *efuse;
+	ssize_t ret;
+
+	device_lock(dev);
+
+	hw = usb_get_intfdata(intf);
+	if (!hw) {
+		device_unlock(dev);
+		return -ENODEV;
+	}
+
+	rtwdev = hw->priv;
+	efuse = &rtwdev->efuse;
+
+	ret = sysfs_emit(buf, "SN: %*ph\nUUID: %*ph\n",
+			 (int)sizeof(efuse->sn), efuse->sn,
+			 (int)sizeof(efuse->uuid), efuse->uuid);
+
+	device_unlock(dev);
+	return ret;
+}
+static DEVICE_ATTR_RO(hw_info);
+
+static struct attribute *rtw89_usb_attrs[] = {
+	&dev_attr_hw_info.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(rtw89_usb);
+
 int rtw89_usb_probe(struct usb_interface *intf,
 		    const struct usb_device_id *id)
 {
@@ -1118,10 +1153,16 @@ int rtw89_usb_probe(struct usb_interface *intf,
 		goto err_core_deinit;
 	}
 
+	ret = sysfs_create_groups(&intf->dev.kobj, rtw89_usb_groups);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to create sysfs groups: %d\n", ret);
+		goto err_core_deinit;
+	}
+
 	ret = rtw89_core_register(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to register core\n");
-		goto err_core_deinit;
+		goto err_remove_sysfs;
 	}
 
 	rtw89_usb_start_rx(rtwdev);
@@ -1130,6 +1171,8 @@ int rtw89_usb_probe(struct usb_interface *intf,
 
 	return 0;
 
+err_remove_sysfs:
+	sysfs_remove_groups(&intf->dev.kobj, rtw89_usb_groups);
 err_core_deinit:
 	rtw89_core_deinit(rtwdev);
 err_deinit_rx:
@@ -1154,12 +1197,18 @@ void rtw89_usb_disconnect(struct usb_interface *intf)
 	if (!hw)
 		return;
 
+	/* Clear intfdata immediately so any concurrent sysfs show waiting on
+	 * device_lock will see NULL and bail out safely.
+	 */
+	usb_set_intfdata(intf, NULL);
+
 	rtwdev = hw->priv;
 	rtwusb = rtw89_usb_priv(rtwdev);
 
 	rtw89_usb_cancel_rx_bufs(rtwusb);
 	rtw89_usb_cancel_tx_bufs(rtwusb);
 
+	sysfs_remove_groups(&intf->dev.kobj, rtw89_usb_groups);
 	rtw89_core_unregister(rtwdev);
 	rtw89_core_deinit(rtwdev);
 	rtw89_usb_deinit_rx(rtwdev);

base-commit: 7076af642955693935e60bc94546d105fb0395ca
-- 
2.25.1


