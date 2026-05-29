Return-Path: <linux-wireless+bounces-37105-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHSxApRGGWrHuAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37105-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 09:56:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 577F75FEDEC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 09:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9638731D95EC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA27333F5A4;
	Fri, 29 May 2026 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AdViOqe7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1233ADBF;
	Fri, 29 May 2026 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041067; cv=none; b=nSPUbEfs6XjQ0EoNWIRutIX0vhvXwTGnqKkE1ptrRZ9nM0Rk9+L5L+1ua08xXq/zCfhpRReJ6rw9jo1wYL/0SmdBwngLEEppVKMaxaa+ksAWMutuDEi62XVXEtiHEtGdMI390wdrdWCQNxbldq8vLweQug9HyqjoIAaJ045wuE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041067; c=relaxed/simple;
	bh=HpM0byGT3x8yrjw9BfQvceqkiws23ktUi0BRJBKCDp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EX97W/sRnwvSU7F2XK4HeS7qqkjZR5YVK/tJrEMmzZTzjltkFHD5sBrSx8fWax270/dz4T4pBf+VQagod6oRcptTHvGv2KZJCni3fVsFPQSfpldCf0k62cBDyoJw3Kl4GT1s0t45FWjsf+dO6tofQDBEMQCrq9het3tmk/qLdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AdViOqe7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64T7p4ixD3998941, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780041064; bh=AYcWJ3Zk9IS0OuDL8K02VMN0z1RZh9OxdRduNw7+NXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AdViOqe7HzEWfm+igLiE/z5Zrmr+0kMjLX4GpOK8pbLOrOfP/mkUr+ED0GbVOSXxA
	 GUu+6vo7zOL4V4q71fibn9PX1FLKeRPNrcVtXcGj8b0bUUdt2tSXh3kTSN68usMKKt
	 w9XfAVCaLhFiOn5pL9VQLCBa9QrOeSy5BI8AYsncfbL6VrmpDg0MwxpnuOndl0Xx3P
	 Xps2nCfnKrOgoJoWFyhFMFOQIhZaGP3KyWrP5KRnviha6141Dd9rmgsbkGnJphlvop
	 tygR6xMtaZTKN4B9MrW4c0z2eMsV5kbTbQ2oVpeGJb/xQuLnlzVR7FWAQYW7ybknio
	 4EpBlbVrmkjhg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64T7p4ixD3998941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:51:04 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 May 2026 15:51:04 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 29 May 2026 15:51:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <driver-core@lists.linux.dev>, <johannes@sipsolutions.net>,
	<mh_chen@realtek.com>, <wenjie.tsai@realtek.com>,
	<charlesl@valvesoftware.com>, <sabae@valvesoftware.com>
Subject: [PATCH v3 rtw-next 2/2] wifi: rtw89: usb: add serial_number and uuid sysfs attributes for 0x28de:0x2432
Date: Fri, 29 May 2026 15:50:32 +0800
Message-ID: <20260529075032.16807-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260529075032.16807-1-pkshih@realtek.com>
References: <20260529075032.16807-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-37105-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 577F75FEDEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johnson Tsai <wenjie.tsai@realtek.com>

Expose the device's Serial Number (SN) and UUID from EFUSE via two
read-only sysfs attributes, `serial_number` and `uuid`, on the ieee80211
phy device under the `rtw89_usb` attribute group.

This hardware identification information is essential for user-space
applications to uniquely identify, track, and manage specific Wi-Fi
adapters. For example, in automated factory provisioning or device
management systems, user-space tools rely on the EFUSE serial number and
UUID to bind configurations to specific physical adapters. Currently,
standard wireless APIs do not expose this low-level hardware
information, making these sysfs nodes the only viable solution for
user space to extract this data.

The attributes are gated behind a new RTW89_QUIRK_HW_INFO_SYSFS quirk,
enabled only for the VID 0x28de / PID 0x2432 device via the
dev_id_quirks field in rtw89_driver_info.

Example usage from user-space:
  $ cat /sys/class/ieee80211/phy0/rtw89_usb/serial_number
  3642000123
  $ cat /sys/class/ieee80211/phy0/rtw89_usb/uuid
  aaec2b7c-0a55-4727-8de0-b30febccbbaa

Cc: Elliot Saba <sabae@valvesoftware.com>
Cc: Charles Lohr <charlesl@valvesoftware.com>
Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v3:
 - use  dev default group (dev->group) instead
v2: 
 - add sysfs entries in /sys/class/ieee80211/phy0/rtw89_usb/
 - add ABI Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
v1: RFC
---
 .../ABI/testing/sysfs-class-ieee80211-rtw89   | 24 +++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  6 +++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 10 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |  6 ++-
 .../net/wireless/realtek/rtw89/rtw8852cu.c    | 12 ++++-
 drivers/net/wireless/realtek/rtw89/usb.c      | 52 +++++++++++++++++++
 6 files changed, 108 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ieee80211-rtw89

diff --git a/Documentation/ABI/testing/sysfs-class-ieee80211-rtw89 b/Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
new file mode 100644
index 000000000000..7dfdce08a42f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
@@ -0,0 +1,24 @@
+What:		/sys/class/ieee80211/phyX/rtw89_usb/serial_number
+Date:		May 2026
+Contact:	Johnson Tsai <wenjie.tsai@realtek.com>, linux-wireless@vger.kernel.org
+Description:	(Read) Serial number burned into EFUSE of the RTL8852CU-based
+		USB Wi-Fi adapter.  Only present on devices that set the
+		RTW89_QUIRK_HW_INFO_SYSFS quirk (currently VID 0x28de /
+		PID 0x2432).
+
+		Format: %10phN (5 raw bytes printed as 10 lowercase hex
+		digits, no separators).
+
+		Example: 3642000123
+
+What:		/sys/class/ieee80211/phyX/rtw89_usb/uuid
+Date:		May 2026
+Contact:	Johnson Tsai <wenjie.tsai@realtek.com>, linux-wireless@vger.kernel.org
+Description:	(Read) UUID burned into EFUSE of the RTL8852CU-based USB Wi-Fi
+		adapter.  Only present on devices that set the
+		RTW89_QUIRK_HW_INFO_SYSFS quirk (currently VID 0x28de /
+		PID 0x2432).
+
+		Format: %pUb (RFC 4122 UUID in lowercase with hyphens).
+
+		Example: aaec2b7c-0a55-4727-8de0-b30febccbbaa
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4c638c2bdc4f..5547888d7e67 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3618,6 +3618,9 @@ struct rtw89_sta_link {
 	u32 data_tx_cnt_lmt:6;
 };
 
+#define RTW89_EFUSE_SN_LEN 5
+#define RTW89_EFUSE_UUID_LEN 16
+
 struct rtw89_efuse {
 	bool valid;
 	bool power_k_valid;
@@ -3628,6 +3631,8 @@ struct rtw89_efuse {
 	u8 adc_td;
 	u8 bt_setting_2;
 	u8 bt_setting_3;
+	u8 sn[RTW89_EFUSE_SN_LEN];
+	u8 uuid[RTW89_EFUSE_UUID_LEN];
 };
 
 struct rtw89_phy_rate_pattern {
@@ -5376,6 +5381,7 @@ enum rtw89_quirks {
 	RTW89_QUIRK_PCI_BER,
 	RTW89_QUIRK_THERMAL_PROT_120C,
 	RTW89_QUIRK_THERMAL_PROT_110C,
+	RTW89_QUIRK_HW_INFO_SYSFS,
 
 	NUM_OF_RTW89_QUIRKS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 7bb1264bcaef..3861cce42b1b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -621,6 +621,15 @@ static void rtw8852c_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
 	gain->offset_valid = valid;
 }
 
+static void rtw8852c_efuse_copy_sn_uuid_usb(struct rtw89_dev *rtwdev,
+					    const struct rtw8852c_efuse *map)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	memcpy(efuse->sn, map->u.sn, sizeof(efuse->sn));
+	memcpy(efuse->uuid, map->u.uuid, sizeof(efuse->uuid));
+}
+
 static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 			       enum rtw89_efuse_block block)
 {
@@ -640,6 +649,7 @@ static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 		break;
 	case RTW89_HCI_TYPE_USB:
 		ether_addr_copy(efuse->addr, map->u.mac_addr);
+		rtw8852c_efuse_copy_sn_uuid_usb(rtwdev, map);
 		break;
 	default:
 		return -ENOTSUPP;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index 8585921ac6c4..b1d7c354c18e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -13,7 +13,11 @@
 struct rtw8852c_u_efuse {
 	u8 rsvd[0x88];
 	u8 mac_addr[ETH_ALEN];
-};
+	u8 rsvd1[8];
+	u8 sn[RTW89_EFUSE_SN_LEN];
+	u8 rsvd2[29];
+	u8 uuid[RTW89_EFUSE_UUID_LEN];
+} __packed;
 
 struct rtw8852c_e_efuse {
 	u8 mac_addr[ETH_ALEN];
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 8f89f9a31455..81ee96b0a048 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -39,6 +39,16 @@ static const struct rtw89_driver_info rtw89_8852cu_info = {
 	},
 };
 
+static const struct rtw89_driver_info rtw89_8852cu_valve_info = {
+	.chip = &rtw8852c_chip_info,
+	.variant = NULL,
+	.quirks = NULL,
+	.dev_id_quirks = BIT(RTW89_QUIRK_HW_INFO_SYSFS),
+	.bus = {
+		.usb = &rtw8852c_usb_info,
+	},
+};
+
 static const struct usb_device_id rtw_8852cu_id_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03a6, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
@@ -53,7 +63,7 @@ static const struct usb_device_id rtw_8852cu_id_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x991d, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x28de, 0x2432, 0xff, 0xff, 0xff),
-	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_valve_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2c7c, 0x8206, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35b2, 0x0502, 0xff, 0xff, 0xff),
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 67ebf2d9bb7d..aafa8b9e93df 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -1150,6 +1150,56 @@ static int rtw89_usb_switch_mode(struct rtw89_dev *rtwdev)
 	return rtw89_usb_switch_mode_be(rtwdev);
 }
 
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct wiphy *wiphy = container_of(dev, struct wiphy, dev);
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	return sysfs_emit(buf, "%*phN\n",
+			  (int)sizeof(efuse->sn), efuse->sn);
+}
+static DEVICE_ATTR_RO(serial_number);
+
+static ssize_t uuid_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct wiphy *wiphy = container_of(dev, struct wiphy, dev);
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct rtw89_dev *rtwdev = hw->priv;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	return sysfs_emit(buf, "%pUb\n", efuse->uuid);
+}
+static DEVICE_ATTR_RO(uuid);
+
+static struct attribute *rtw89_usb_attrs[] = {
+	&dev_attr_serial_number.attr,
+	&dev_attr_uuid.attr,
+	NULL,
+};
+
+static bool rtw89_usb_group_visible(struct kobject *kobj)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct wiphy *wiphy = container_of(dev, struct wiphy, dev);
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	return test_bit(RTW89_QUIRK_HW_INFO_SYSFS, rtwdev->quirks);
+}
+
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(rtw89_usb);
+
+static const struct attribute_group rtw89_usb_group = {
+	.name		= "rtw89_usb",
+	.attrs		= rtw89_usb_attrs,
+	.is_visible	= SYSFS_GROUP_VISIBLE(rtw89_usb),
+};
+__ATTRIBUTE_GROUPS(rtw89_usb);
+
 int rtw89_usb_probe(struct usb_interface *intf,
 		    const struct usb_device_id *id)
 {
@@ -1171,6 +1221,8 @@ int rtw89_usb_probe(struct usb_interface *intf,
 	rtwusb->rtwdev = rtwdev;
 	rtwusb->info = info->bus.usb;
 
+	rtwdev->hw->wiphy->dev.groups = rtw89_usb_groups;
+
 	rtwdev->hci.ops = &rtw89_usb_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_USB;
 	rtwdev->hci.tx_rpt_enabled = true;
-- 
2.25.1


