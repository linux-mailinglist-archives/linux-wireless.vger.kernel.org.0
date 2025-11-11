Return-Path: <linux-wireless+bounces-28822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71350C4B34B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39B1A4E53F5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7DC347BCA;
	Tue, 11 Nov 2025 02:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="tQ1G5rUT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A3E2BCF43
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827945; cv=none; b=JOPidbzxgK2Gyv/RDwm7jpbeTXL4i+m9LvuMndH3odU9YXf/oOEjhhCDMkWrbRUH6QpCczNFpIppsSu6Y7+hZGu+N3Dj4tUhS/dDfADOvfRgKqhnes+VVSR1c0w0sjmPvKysdESs52IfBc1CrR5cHaeYDUbSPUj6HCgT34OAYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827945; c=relaxed/simple;
	bh=mD11fOAmVlhCCcOvWHinJNV+V5hP8wyEVieN44jl+Ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uctUzyex5CDWl8a8W2Ki4srcVN9jQ3+cJWK0LlmR8HhonyJt+dN7qeGDdw0uqpuucRlcTCehhgT/fw8s/jBnXDardm2OvHt7QHJqE8jCNqs2oc5w1wz9ZMPc320oIXWhx8EU5Bg1lQtD6eHrgY8eHNuqvBs8rxxfOolrLqlqadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tQ1G5rUT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB2PfEG22922203, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762827941; bh=n9FfXrAUx8POBE8KWgKe/mLZJyJpiX5iZVPSjihyPL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=tQ1G5rUTCx4ckvDrrY0yGl77PSdn8bFep6Giyia0lghVPi9J/gRI2ld2vCkSiNWxW
	 Ih5i/r57ZMv3uLItMw/Hr/FebOQiD+ACfE1r01eBUvpAsqJvDZvz5jZQ8CFqG+ATYc
	 wqo8qLatXd5RGq1+00bR5rQzUuVypzsb7b7S7agwXKTqIp1YJbbhRs9+T0cQ0ZEJTR
	 HSwP6frWgdOoshtTTGJ1EINy+uDZ3Q46Xza/a89rci3FWUWyvRUzDQc+fc4vlVdM9R
	 QmXjmLuy7EO9BybxM/yESSESyU9qPf0mjpag+tJnVIj8q71Ue9ZGHVSAWRHrqsBfjr
	 LOua9aS2fEaBg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB2PfEG22922203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:25:41 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:25:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:25:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH v2 rtw-next 3/8] wifi: rtw89: debug: add parser to diagnose along DIAG_MAC fw element
Date: Tue, 11 Nov 2025 10:24:47 +0800
Message-ID: <20251111022452.28093-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251111022452.28093-1-pkshih@realtek.com>
References: <20251111022452.28093-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The rules to diagnose MAC have a common header, and a cmd field is used
to know the exact command and its format. The rules with the same tuple of
fields {sheet, seq} can be seen as a set of compound rules, which treat
it as positive rule if just one of the rules is positive.

Take EQUALV rules as example, if value of {addr, mask} is equal to
predefined value as field val, a rule is positive. Fields addr_name_offset
and msg_offset are offsets related to textual messages for human readable.

Format of common rule header (8 bytes)
 +-------+-----+--------+-----------+-----+---------+
 | sheet | cmd | seq[2] | io / band | len | rsvd[2] |
 +-------+-----+--------+-----------+-----+---------+

Format of rule command is EQUALV (equal value) (24 bytes):
 +------+------------------+------+-----+------------+---------+
 | addr | addr_name_offset | mask | val | msg_offset | rsvd[4] |
 +------+------------------+------+-----+------------+---------+

Format of message:
 +-----+----------+
 | len | string[] |
 +-----+----------+

An example of output:
 Plain(Ignore)/Rules/Positive: 115(4)/86/81

 Where, Plain is total rules written in firmware element.
        Ignore is the ignored rules, such as USB IO, but current is PCIE.
        Rules is number of set of compound rules.
        Positive is number of positive Rules.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 299 +++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 3dc7981c510f..1264c2f82600 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -87,6 +87,7 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv disable_dm;
 	struct rtw89_debugfs_priv mlo_mode;
 	struct rtw89_debugfs_priv beacon_info;
+	struct rtw89_debugfs_priv diag_mac;
 };
 
 struct rtw89_debugfs_iter_data {
@@ -4361,6 +4362,302 @@ rtw89_debug_priv_mlo_mode_set(struct rtw89_dev *rtwdev,
 	return count;
 }
 
+enum __diag_mac_cmd {
+	__CMD_EQUALV,
+	__CMD_EQUALO,
+	__CMD_NEQUALV,
+	__CMD_NEQUALO,
+	__CMD_SETEQUALV,
+	__CMD_SETEQUALO,
+	__CMD_CMPWCR,
+	__CMD_CMPWWD,
+	__CMD_NEQ_CMPWCR,
+	__CMD_NEQ_CMPWWD,
+	__CMD_INCREMENT,
+	__CMD_MESSAGE,
+};
+
+enum __diag_mac_io {
+	__IO_NORMAL,
+	__IO_NORMAL_PCIE,
+	__IO_NORMAL_USB,
+	__IO_NORMAL_SDIO,
+	__IO_PCIE_CFG,
+	__IO_SDIO_CCCR,
+};
+
+struct __diag_mac_rule_header {
+	u8 sheet;
+	u8 cmd;
+	u8 seq_major;
+	u8 seq_minor;
+	u8 io_band;
+	#define __DIAG_MAC_IO GENMASK(3, 0)
+	#define __DIAG_MAC_N_BAND BIT(4)
+	#define __DIAG_MAC_HAS_BAND BIT(5)
+	u8 len; /* include header. Unit: 4 bytes */
+	u8 rsvd[2];
+} __packed;
+
+struct __diag_mac_rule_equal {
+	struct __diag_mac_rule_header header;
+	__le32 addr;
+	__le32 addr_name_offset;
+	__le32 mask;
+	__le32 val;
+	__le32 msg_offset;
+	u8 rsvd[4];
+} __packed;
+
+struct __diag_mac_rule_increment {
+	struct __diag_mac_rule_header header;
+	__le32 addr;
+	__le32 addr_name_offset;
+	__le32 mask;
+	__le16 sel;
+	__le16 delay;
+	__le32 msg_offset;
+	u8 rsvd[4];
+} __packed;
+
+struct __diag_mac_msg_buf {
+	__le16 len;
+	char string[];
+} __packed;
+
+static ssize_t rtw89_mac_diag_do_equalv(struct rtw89_dev *rtwdev,
+					char *buf, size_t bufsz,
+					const struct __diag_mac_rule_equal *r,
+					const void *msg_start,
+					u64 *positive_bmp)
+{
+	const struct __diag_mac_msg_buf *name = msg_start +
+						le32_to_cpu(r->addr_name_offset);
+	const struct __diag_mac_msg_buf *msg = msg_start +
+					       le32_to_cpu(r->msg_offset);
+	bool want_eq = r->header.cmd == __CMD_EQUALV;
+	char *p = buf, *end = buf + bufsz;
+	bool equal = false;
+	u32 val;
+
+	*positive_bmp <<= 1;
+
+	if (u8_get_bits(r->header.io_band, __DIAG_MAC_IO) == __IO_PCIE_CFG)
+		val = rtw89_read32_pci_cfg(rtwdev, le32_to_cpu(r->addr));
+	else
+		val = rtw89_read32(rtwdev, le32_to_cpu(r->addr));
+
+	if ((val & le32_to_cpu(r->mask)) == le32_to_cpu(r->val))
+		equal = true;
+
+	if (want_eq == equal) {
+		*positive_bmp |= BIT(0);
+		return p - buf;
+	}
+
+	p += scnprintf(p, end - p, "sheet: %d, cmd: %d, Reg: %.*s => %x, %.*s\n",
+		       r->header.sheet, r->header.cmd, le16_to_cpu(name->len),
+		       name->string, val, le16_to_cpu(msg->len), msg->string);
+
+	return p - buf;
+}
+
+static ssize_t rtw89_mac_diag_do_increment(struct rtw89_dev *rtwdev,
+					   char *buf, size_t bufsz,
+					   const struct __diag_mac_rule_increment *r,
+					   const void *msg_start,
+					   u64 *positive_bmp)
+{
+	const struct __diag_mac_msg_buf *name = msg_start +
+						le32_to_cpu(r->addr_name_offset);
+	const struct __diag_mac_msg_buf *msg = msg_start +
+					       le32_to_cpu(r->msg_offset);
+	char *p = buf, *end = buf + bufsz;
+	u32 addr = le32_to_cpu(r->addr);
+	u32 mask = le32_to_cpu(r->mask);
+	u16 sel = le16_to_cpu(r->sel);
+	u32 val1, val2;
+
+	*positive_bmp <<= 1;
+
+	rtw89_write32(rtwdev, addr, sel);
+
+	if (u8_get_bits(r->header.io_band, __DIAG_MAC_IO) == __IO_PCIE_CFG)
+		val1 = rtw89_read32_pci_cfg(rtwdev, addr);
+	else
+		val1 = rtw89_read32(rtwdev, addr);
+
+	mdelay(le16_to_cpu(r->delay));
+
+	if (u8_get_bits(r->header.io_band, __DIAG_MAC_IO) == __IO_PCIE_CFG)
+		val2 = rtw89_read32_pci_cfg(rtwdev, addr);
+	else
+		val2 = rtw89_read32(rtwdev, addr);
+
+	if ((val2 & mask) > (val1 & mask)) {
+		*positive_bmp |= BIT(0);
+		return p - buf;
+	}
+
+	p += scnprintf(p, end - p, "sheet: %d, cmd: %d, Reg: %.*s [%d]=> %x, %.*s\n",
+		       r->header.sheet, r->header.cmd, le16_to_cpu(name->len),
+		       name->string, le16_to_cpu(r->sel), val1,
+		       le16_to_cpu(msg->len), msg->string);
+
+	return p - buf;
+}
+
+static bool rtw89_mac_diag_match_hci(struct rtw89_dev *rtwdev,
+				     const struct __diag_mac_rule_header *rh)
+{
+	switch (u8_get_bits(rh->io_band, __DIAG_MAC_IO)) {
+	case __IO_NORMAL:
+	default:
+		return true;
+	case __IO_NORMAL_PCIE:
+	case __IO_PCIE_CFG:
+		if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+			return true;
+		break;
+	case __IO_NORMAL_USB:
+		if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+			return true;
+		break;
+	case __IO_NORMAL_SDIO:
+	case __IO_SDIO_CCCR:
+		if (rtwdev->hci.type == RTW89_HCI_TYPE_SDIO)
+			return true;
+		break;
+	}
+
+	return false;
+}
+
+static bool rtw89_mac_diag_match_band(struct rtw89_dev *rtwdev,
+				      const struct __diag_mac_rule_header *rh)
+{
+	u8 active_bands;
+	bool has_band;
+	u8 band;
+
+	has_band = u8_get_bits(rh->io_band, __DIAG_MAC_HAS_BAND);
+	if (!has_band)
+		return true;
+
+	band = u8_get_bits(rh->io_band, __DIAG_MAC_N_BAND);
+	active_bands = rtw89_get_active_phy_bitmap(rtwdev);
+
+	if (active_bands & BIT(band))
+		return true;
+
+	return false;
+}
+
+static ssize_t rtw89_mac_diag_iter_all(struct rtw89_dev *rtwdev,
+				       char *buf, size_t bufsz)
+{
+	const struct rtw89_fw_element_hdr *elm = rtwdev->fw.elm_info.diag_mac;
+	u32 n_plains = 0, n_rules = 0, n_positive = 0, n_ignore = 0;
+	char *p = buf, *end = buf + bufsz, *p_rewind;
+	const void *rule, *rule_end;
+	u32 elm_size, rule_size;
+	const void *msg_start;
+	u64 positive_bmp = 0;
+	u8 prev_sheet = 0;
+	u8 prev_seq = 0;
+	int limit;
+
+	if (!elm) {
+		p += scnprintf(p, end - p, "No diag_mac entry\n");
+		goto out;
+	}
+
+	rule_size = le32_to_cpu(elm->u.diag_mac.rule_size);
+	elm_size = le32_to_cpu(elm->size);
+
+	if (ALIGN(rule_size, 16) > elm_size) {
+		p += scnprintf(p, end - p, "rule size (%u) exceed elm_size (%u)\n",
+			       ALIGN(rule_size, 16), elm_size);
+		goto out;
+	}
+
+	rule = &elm->u.diag_mac.rules_and_msgs[0];
+	rule_end = &elm->u.diag_mac.rules_and_msgs[rule_size];
+	msg_start = &elm->u.diag_mac.rules_and_msgs[ALIGN(rule_size, 16)];
+
+	for (limit = 0; limit < 5000 && rule < rule_end; limit++) {
+		const struct __diag_mac_rule_header *rh = rule;
+		u8 sheet = rh->sheet;
+		u8 seq = rh->seq_major;
+
+		if (!rtw89_mac_diag_match_hci(rtwdev, rh) ||
+		    !rtw89_mac_diag_match_band(rtwdev, rh)) {
+			n_ignore++;
+			goto next;
+		}
+
+		if (!seq || prev_sheet != sheet || prev_seq != seq) {
+			if (positive_bmp) {
+				n_positive++;
+				/*
+				 * discard output for negative results if one in
+				 * a sequence set is positive.
+				 */
+				if (p_rewind)
+					p = p_rewind;
+			}
+			p_rewind = seq ? p : NULL;
+			positive_bmp = 0;
+			n_rules++;
+		}
+
+		switch (rh->cmd) {
+		case __CMD_EQUALV:
+		case __CMD_NEQUALV:
+			p += rtw89_mac_diag_do_equalv(rtwdev, p, end - p, rule,
+						      msg_start, &positive_bmp);
+			break;
+		case __CMD_INCREMENT:
+			p += rtw89_mac_diag_do_increment(rtwdev, p, end - p, rule,
+							 msg_start, &positive_bmp);
+			break;
+		default:
+			p += scnprintf(p, end - p, "unknown rule cmd %u\n", rh->cmd);
+			break;
+		}
+
+next:
+		n_plains++;
+		rule += rh->len * 4;
+		prev_seq = seq;
+		prev_sheet = sheet;
+	}
+
+	if (positive_bmp) {
+		n_positive++;
+		if (p_rewind)
+			p = p_rewind;
+	}
+
+	p += scnprintf(p, end - p, "\nPlain(Ignore)/Rules/Positive: %u(%u)/%u/%u\n",
+		       n_plains, n_ignore, n_rules, n_positive);
+
+out:
+	return p - buf;
+}
+
+static ssize_t
+rtw89_debug_priv_diag_mac_get(struct rtw89_dev *rtwdev,
+			      struct rtw89_debugfs_priv *debugfs_priv,
+			      char *buf, size_t bufsz)
+{
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	rtw89_leave_lps(rtwdev);
+
+	return rtw89_mac_diag_iter_all(rtwdev, buf, bufsz);
+}
+
 static ssize_t
 rtw89_debug_priv_beacon_info_get(struct rtw89_dev *rtwdev,
 				 struct rtw89_debugfs_priv *debugfs_priv,
@@ -4478,6 +4775,7 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.disable_dm = rtw89_debug_priv_set_and_get(disable_dm, RWLOCK),
 	.mlo_mode = rtw89_debug_priv_set_and_get(mlo_mode, RWLOCK),
 	.beacon_info = rtw89_debug_priv_get(beacon_info),
+	.diag_mac = rtw89_debug_priv_get(diag_mac, RSIZE_16K, RLOCK),
 };
 
 #define rtw89_debugfs_add(name, mode, fopname, parent)				\
@@ -4524,6 +4822,7 @@ void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 	rtw89_debugfs_add_rw(disable_dm);
 	rtw89_debugfs_add_rw(mlo_mode);
 	rtw89_debugfs_add_r(beacon_info);
+	rtw89_debugfs_add_r(diag_mac);
 }
 
 void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
-- 
2.25.1


