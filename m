Return-Path: <linux-wireless+bounces-35001-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONQ1HZKg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35001-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CF426965
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8117E3009573
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E2E377006;
	Mon, 20 Apr 2026 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UFEFHYs2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04382BDC0F
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656516; cv=none; b=j8z4H8p7r4FSi5omsUTSdkK0eEwSvQOkJSZri9mQL3xqa8BIlHIaLl4ErMU93zpxTY+OMGfXQYB81h/PILPhPPgenXMFQeecFk2nbpC5hqJ1t8wbwlanlfwCoetqwdoGURT4B7DsUd1ShRXSohd09yv8/ATIvGF7WbUwtvgdOsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656516; c=relaxed/simple;
	bh=jsEORz2emb7wwUp5Q5IBimH1Bj3vhLC+X1xaIzEjTBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jexv3v5cP7p0Y86VIdeykm9sVU9YV+Qu6/jgZryC88kPp3XAzaGbfYISeZWZi65DJZU5E790PeLR02zjdVkWKKgx9Zwoz/WIdZTSlENDKCuxftBXTmLXRQyZX8Z86yABq8PkIKyv32t27RGP2lEm1y/j5+iZo4OW64GIdOymJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UFEFHYs2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3fpvU7426824, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656511; bh=B/yjK8mo0xznXaPIKfTsqAmr5/2IXULMtWbq4CtLRgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UFEFHYs2q3vHPWeME10HZu9ZY8fJcgGfZCfn1TvxbbM4SLbFjyR3gZfIj2EObV+AJ
	 rt3LW3XT6vvFb9gVwq43OFaPAWi1l9hHerl6WOm/cPajDZ0Pkf1HGgHLmnNbP3AGRH
	 xLaOna041G4OvhWXDtxbePL/TEPKXwUqUSsQTX+VZnMauI18BwtAYC2376P1L0pHM8
	 DBRoGdNglrZhXcgrHMskcu5eVHK4beEN+ddP3cCOsPQ8TIJG6BR7X2Jc3HoIieKWk/
	 qJCDrGNJIJAiwf8Vi7MUYwac1ohnvsvdh938fkwJKmDcnQqS5vftUiTsDh9OZRaLdI
	 Nchg9WaXfYXDg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3fpvU7426824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:41:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:51 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:41:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 08/16] wifi: rtw89: add IO offload support via firmware
Date: Mon, 20 Apr 2026 11:40:43 +0800
Message-ID: <20260420034051.17666-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-35001-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 094CF426965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yuan Li <leo.li@realtek.com>

Offload register write operations to the firmware to improve IO efficiency.
Instead of the host performing direct bus access for every register, the
operations are now encapsulated into firmware commands.

This implementation allows the host to aggregate multiple register write
actions into a single command buffer. By batching these operations, we
reduce the number of individual transactions on the bus and minimize
per-transfer overhead, leading to faster overall IO performance.

Add a support_fw_cmd_ofld field to the chip_info structure to control
whether firmware-offloaded batch writes are enabled. Enable it by
default for RTL8832CU.

Co-developed-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Eric Huang <echuang@realtek.com>
Co-developed-by: Johnson Tsai <wenjie.tsai@realtek.com>
Signed-off-by: Johnson Tsai <wenjie.tsai@realtek.com>
Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |   2 +
 drivers/net/wireless/realtek/rtw89/core.h     |  82 ++++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 347 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       |  57 +++
 drivers/net/wireless/realtek/rtw89/phy.h      |  30 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |   1 +
 12 files changed, 515 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c9c4ec1d93af..7fe979e47ad5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -6302,6 +6302,8 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	u8 band;
 
+	rtwdev->io = rtw89_fw_cmd_ofld_alloc_and_get_io_ops(rtwdev);
+
 	bitmap_or(rtwdev->quirks, rtwdev->quirks, &rtwdev->chip->default_quirks,
 		  NUM_OF_RTW89_QUIRKS);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8618a7c30ee0..6a8ad5d91130 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -27,6 +27,7 @@ struct rtw89_phy_calc_efuse_gain;
 struct rtw89_debugfs;
 struct rtw89_regd_data;
 struct rtw89_wow_cam_info;
+struct rtw89_fw_cmd_ofld_info;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -4569,6 +4570,7 @@ struct rtw89_chip_info {
 	bool support_tas;
 	bool support_sar_by_ant;
 	bool support_noise;
+	bool support_fw_cmd_ofld;
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
 	bool rx_freq_from_ie;
@@ -6202,10 +6204,26 @@ struct rtw89_tid_stats {
 	bool started;
 };
 
+struct rtw89_io_ops {
+	int (*pack)(struct rtw89_dev *rtwdev);
+	int (*unpack)(struct rtw89_dev *rtwdev);
+	void (*do_udelay)(struct rtw89_dev *rtwdev, u32 us);
+	void (*do_mdelay)(struct rtw89_dev *rtwdev, u32 ms);
+	void (*write8)(struct rtw89_dev *rtwdev, u32 addr, u8 data);
+	void (*write16)(struct rtw89_dev *rtwdev, u32 addr, u16 data);
+	void (*write32)(struct rtw89_dev *rtwdev, u32 addr, u32 data);
+	void (*phy_write8)(struct rtw89_dev *rtwdev, u32 addr, u8 data);
+	void (*phy_write16)(struct rtw89_dev *rtwdev, u32 addr, u16 data);
+	void (*phy_write32)(struct rtw89_dev *rtwdev, u32 addr, u32 data);
+	void (*write_rf)(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			 u32 addr, u32 mask, u32 data);
+};
+
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
 	const struct ieee80211_ops *ops;
+	const struct rtw89_io_ops *io;
 
 	bool dbcc_en;
 	bool support_mlo;
@@ -6227,6 +6245,8 @@ struct rtw89_dev {
 	struct rtw89_rfe_data *rfe_data;
 	enum rtw89_custid custid;
 
+	struct rtw89_fw_cmd_ofld_info *fw_cmd_ofld_info;
+
 	struct rtw89_sta_link __rcu *assoc_link_on_macid[RTW89_MAX_MAC_ID_NUM];
 	refcount_t refcount_ap_info;
 
@@ -6688,6 +6708,38 @@ struct rtw89_tx_skb_data *RTW89_TX_SKB_CB(struct sk_buff *skb)
 	return (struct rtw89_tx_skb_data *)info->driver_data;
 }
 
+static inline int rtw89_io_pack(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->io->pack)
+		return rtwdev->io->pack(rtwdev);
+
+	return 0;
+}
+
+static inline int rtw89_io_unpack(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->io->unpack)
+		return rtwdev->io->unpack(rtwdev);
+
+	return 0;
+}
+
+static inline void rtw89_io_udelay(struct rtw89_dev *rtwdev, u32 us)
+{
+	if (rtwdev->io->do_udelay)
+		rtwdev->io->do_udelay(rtwdev, us);
+	else
+		udelay(us);
+}
+
+static inline void rtw89_io_mdelay(struct rtw89_dev *rtwdev, u32 ms)
+{
+	if (rtwdev->io->do_mdelay)
+		rtwdev->io->do_mdelay(rtwdev, ms);
+	else
+		mdelay(ms);
+}
+
 static inline u8 rtw89_read8(struct rtw89_dev *rtwdev, u32 addr)
 {
 	return rtwdev->hci.ops->read8(rtwdev, addr);
@@ -6703,21 +6755,36 @@ static inline u32 rtw89_read32(struct rtw89_dev *rtwdev, u32 addr)
 	return rtwdev->hci.ops->read32(rtwdev, addr);
 }
 
-static inline void rtw89_write8(struct rtw89_dev *rtwdev, u32 addr, u8 data)
+static inline void rtw89_raw_write8(struct rtw89_dev *rtwdev, u32 addr, u8 data)
 {
 	rtwdev->hci.ops->write8(rtwdev, addr, data);
 }
 
-static inline void rtw89_write16(struct rtw89_dev *rtwdev, u32 addr, u16 data)
+static inline void rtw89_raw_write16(struct rtw89_dev *rtwdev, u32 addr, u16 data)
 {
 	rtwdev->hci.ops->write16(rtwdev, addr, data);
 }
 
-static inline void rtw89_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data)
+static inline void rtw89_raw_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data)
 {
 	rtwdev->hci.ops->write32(rtwdev, addr, data);
 }
 
+static inline void rtw89_write8(struct rtw89_dev *rtwdev, u32 addr, u8 data)
+{
+	rtwdev->io->write8(rtwdev, addr, data);
+}
+
+static inline void rtw89_write16(struct rtw89_dev *rtwdev, u32 addr, u16 data)
+{
+	rtwdev->io->write16(rtwdev, addr, data);
+}
+
+static inline void rtw89_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data)
+{
+	rtwdev->io->write32(rtwdev, addr, data);
+}
+
 static inline void
 rtw89_write8_set(struct rtw89_dev *rtwdev, u32 addr, u8 bit)
 {
@@ -6862,13 +6929,20 @@ rtw89_read_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 	return rtwdev->chip->ops->read_rf(rtwdev, rf_path, addr, mask);
 }
 
+static inline void
+rtw89_raw_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+		   u32 addr, u32 mask, u32 data)
+{
+	rtwdev->chip->ops->write_rf(rtwdev, rf_path, addr, mask, data);
+}
+
 static inline void
 rtw89_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 	       u32 addr, u32 mask, u32 data)
 {
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
-	rtwdev->chip->ops->write_rf(rtwdev, rf_path, addr, mask, data);
+	rtwdev->io->write_rf(rtwdev, rf_path, addr, mask, data);
 }
 
 static inline u32 rtw89_read32_pci_cfg(struct rtw89_dev *rtwdev, u32 addr)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 089c9071b58f..4c10f069e242 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -11344,3 +11344,350 @@ rtw89_load_rfe_data_from_fw(struct rtw89_dev *rtwdev,
 
 	return parms;
 }
+
+static int rtw89_fw_cmd_ofld_pack(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_cmd_ofld_info *info = rtwdev->fw_cmd_ofld_info;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	info->pack_level++;
+
+	return 0;
+}
+
+static void rtw89_fw_cmd_ofld_flush(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_cmd_ofld_info *info = rtwdev->fw_cmd_ofld_info;
+	struct sk_buff *skb;
+	int ret;
+	u32 len;
+
+	len = info->cnt * sizeof(info->cmds[0]);
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "alloc skb fail\n");
+		return;
+	}
+
+	skb_put_data(skb, info->cmds, len);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC,
+			      H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_CMD_OFLD_PKT, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send cmd ofld\n");
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	if (info->accu_delay)
+		fsleep(info->accu_delay);
+
+	info->cnt = 0;
+	info->accu_delay = 0;
+}
+
+static int rtw89_fw_cmd_ofld_unpack(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_cmd_ofld_info *info = rtwdev->fw_cmd_ofld_info;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	if (info->pack_level == 0)
+		return -EFAULT;
+
+	if (--info->pack_level != 0)
+		return 0;
+
+	if (info->cnt == 0)
+		return 0;
+
+	rtw89_fw_cmd_ofld_flush(rtwdev);
+
+	return 0;
+}
+
+static int rtw89_fw_cmd_ofld_enqueue(struct rtw89_dev *rtwdev,
+				     const struct rtw89_fw_cmd_ofld_arg *cmd)
+{
+	struct rtw89_fw_cmd_ofld_info *info = rtwdev->fw_cmd_ofld_info;
+	struct rtw89_h2c_cmd_ofld *h2c;
+	u32 base_off;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	if (info->pack_level == 0)
+		return 1;
+
+	if (!test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
+		return -EBUSY;
+
+	if (cmd->type != RTW89_FW_CMD_OFLD_DELAY &&
+	    cmd->src != RTW89_FW_CMD_OFLD_SRC_RF &&
+	    cmd->src != RTW89_FW_CMD_OFLD_SRC_RF_DDIE &&
+	    !IS_ALIGNED(cmd->offset, 4))
+		return -EFAULT;
+
+	if (info->cnt >= ARRAY_SIZE(info->cmds))
+		rtw89_fw_cmd_ofld_flush(rtwdev);
+
+	h2c = &info->cmds[info->cnt++];
+
+	h2c->w0 = le32_encode_bits(cmd->src, RTW89_H2C_CMD_OFLD_W0_SRC) |
+		  le32_encode_bits(cmd->type, RTW89_H2C_CMD_OFLD_W0_TYPE) |
+		  le32_encode_bits(cmd->rf_path, RTW89_H2C_CMD_OFLD_W0_PATH) |
+		  le32_encode_bits(info->cnt, RTW89_H2C_CMD_OFLD_W0_CMD_NUM) |
+		  le32_encode_bits(cmd->offset, RTW89_H2C_CMD_OFLD_W0_OFFSET);
+
+	if (cmd->src == RTW89_FW_CMD_OFLD_SRC_RF_DDIE)
+		base_off = 1;
+	else if (cmd->src == RTW89_FW_CMD_OFLD_SRC_RF)
+		base_off = 0;
+	else
+		base_off = cmd->offset >> 16;
+
+	h2c->w1 = le32_encode_bits(cmd->id, RTW89_H2C_CMD_OFLD_W1_ID) |
+		  le32_encode_bits(base_off, RTW89_H2C_CMD_OFLD_W1_BASE_OFFSET);
+	h2c->w2 = le32_encode_bits(cmd->value, RTW89_H2C_CMD_OFLD_W2_VALUE);
+	h2c->w3 = le32_encode_bits(cmd->mask, RTW89_H2C_CMD_OFLD_W3_MASK);
+
+	if (cmd->type == RTW89_FW_CMD_OFLD_DELAY)
+		info->accu_delay += cmd->value;
+
+	return 0;
+}
+
+static const struct rtw89_io_ops rtw89_raw_io = {
+	.pack = NULL,
+	.unpack = NULL,
+	.write8 = rtw89_raw_write8,
+	.write16 = rtw89_raw_write16,
+	.write32 = rtw89_raw_write32,
+	.phy_write8 = rtw89_raw_phy_write8,
+	.phy_write16 = rtw89_raw_phy_write16,
+	.phy_write32 = rtw89_raw_phy_write32,
+	.write_rf = rtw89_raw_write_rf,
+};
+
+static
+void rtw89_fw_cmd_ofld_phy_write8(struct rtw89_dev *rtwdev, u32 addr, u8 data)
+{
+	struct rtw89_fw_cmd_ofld_arg cmd = {
+		.src = RTW89_FW_CMD_OFLD_SRC_BB,
+		.type = RTW89_FW_CMD_OFLD_WRITE,
+		.offset = ALIGN_DOWN(addr, 4),
+		.mask = RTW89_W8_MASK_OF_ALIGNED_ADDR(addr),
+		.value = data,
+	};
+	int ret;
+
+	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
+	if (ret)
+		rtw89_raw_io.phy_write8(rtwdev, addr, data);
+}
+
+static
+void rtw89_fw_cmd_ofld_phy_write16(struct rtw89_dev *rtwdev, u32 addr, u16 data)
+{
+	struct rtw89_fw_cmd_ofld_arg cmd = {
+		.src = RTW89_FW_CMD_OFLD_SRC_BB,
+		.type = RTW89_FW_CMD_OFLD_WRITE,
+		.offset = ALIGN_DOWN(addr, 2),
+		.mask = RTW89_W16_MASK_OF_ALIGNED_ADDR(addr),
+		.value = data,
+	};
+	int ret;
+
+	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
+	if (ret)
+		rtw89_raw_io.phy_write16(rtwdev, addr, data);
+}
+
+static
+void rtw89_fw_cmd_ofld_phy_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data)
+{
+	struct rtw89_fw_cmd_ofld_arg cmd = {
+		.src = RTW89_FW_CMD_OFLD_SRC_BB,
+		.type = RTW89_FW_CMD_OFLD_WRITE,
+		.offset = addr,
+		.mask = MASKDWORD,
+		.value = data,
+	};
+	int ret;
+
+	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
+	if (ret)
+		rtw89_raw_io.phy_write32(rtwdev, addr, data);
+}
+
+static
+void rtw89_fw_cmd_ofld_write8(struct rtw89_dev *rtwdev, u32 addr, u8 data)
+{
+	struct rtw89_fw_cmd_ofld_arg cmd = {
+		.src = RTW89_FW_CMD_OFLD_SRC_MAC,
+		.type = RTW89_FW_CMD_OFLD_WRITE,
+		.offset = ALIGN_DOWN(addr, 4),
+		.mask = RTW89_W8_MASK_OF_ALIGNED_ADDR(addr),
+		.value = data,
+	};
+	int ret;
+
+	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
+	if (ret)
+		rtw89_raw_io.write8(rtwdev, addr, data);
+}
+
+static
+void rtw89_fw_cmd_ofld_write16(struct rtw89_dev *rtwdev, u32 addr, u16 data)
+{
+	struct rtw89_fw_cmd_ofld_arg cmd = {
+		.src = RTW89_FW_CMD_OFLD_SRC_MAC,
+		.type = RTW89_FW_CMD_OFLD_WRITE,
+		.offset = ALIGN_DOWN(addr, 2),
+		.mask = RTW89_W16_MASK_OF_ALIGNED_ADDR(addr),
+		.value = data,
+	};
+	int ret;
+
+	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
+	if (ret)
+		rtw89_raw_io.write16(rtwdev, addr, data);
+}
+
+static
+void rtw89_fw_cmd_ofld_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data)
+{
+	struct rtw89_fw_cmd_ofld_arg cmd = {
+		.src = RTW89_FW_CMD_OFLD_SRC_MAC,
+		.type = RTW89_FW_CMD_OFLD_WRITE,
+		.offset = addr,
+		.mask = MASKDWORD,
+		.value = data,
+	};
+	int ret;
+
+	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
+	if (ret)
+		rtw89_raw_io.write32(rtwdev, addr, data);
+}
+
+static void rtw89_fw_cmd_ofld_write_rf_ddv(struct rtw89_dev *rtwdev,
+					   struct rtw89_fw_cmd_ofld_arg *cmd,
+					   enum rtw89_rf_path rf_path, u32 addr, u32 mask,
+					   u32 data)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	*cmd = (typeof(*cmd)){
+		.src = RTW89_FW_CMD_OFLD_SRC_BB,
+		.type = RTW89_FW_CMD_OFLD_WRITE,
+		.rf_path = 0, /* Set rf_path to zero in rf_ddv */
+		.offset = chip->rf_base_addr[rf_path] + ((addr & 0xff) << 2),
+		.mask = mask,
+		.value = data,
+	};
+}
+
+static void rtw89_fw_cmd_ofld_write_rf_dav(struct rtw89_dev *rtwdev,
+					   struct rtw89_fw_cmd_ofld_arg *cmd,
+					   enum rtw89_rf_path rf_path, u32 addr, u32 mask,
+					   u32 data)
+{
+	*cmd = (typeof(*cmd)){
+		.src = RTW89_FW_CMD_OFLD_SRC_RF,
+		.type = RTW89_FW_CMD_OFLD_WRITE,
+		.rf_path = rf_path,
+		.offset = addr,
+		.mask = mask,
+		.value = data,
+	};
+}
+
+static void rtw89_fw_cmd_ofld_write_rf(struct rtw89_dev *rtwdev,
+				       enum rtw89_rf_path rf_path, u32 addr, u32 mask,
+				       u32 data)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool ad_sel = u32_get_bits(addr, RTW89_RF_ADDR_ADSEL_MASK);
+	struct rtw89_fw_cmd_ofld_arg cmd;
+	int ret;
+
+	if (unlikely(rf_path >= chip->rf_path_num)) {
+		rtw89_warn(rtwdev, "unsupported rf path (%d) in fw offload\n", rf_path);
+		return;
+	}
+
+	if (ad_sel)
+		rtw89_fw_cmd_ofld_write_rf_ddv(rtwdev, &cmd, rf_path, addr, mask, data);
+	else
+		rtw89_fw_cmd_ofld_write_rf_dav(rtwdev, &cmd, rf_path, addr, mask, data);
+
+	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
+	if (ret)
+		rtw89_raw_io.write_rf(rtwdev, rf_path, addr, mask, data);
+}
+
+static void rtw89_fw_cmd_ofld_udelay(struct rtw89_dev *rtwdev, u32 us)
+{
+	struct rtw89_fw_cmd_ofld_arg cmd = {
+		.src = RTW89_FW_CMD_OFLD_SRC_OTHER,
+		.type = RTW89_FW_CMD_OFLD_DELAY,
+		.value = us,
+	};
+	int ret;
+
+	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
+	if (ret)
+		udelay(us);
+}
+
+static void rtw89_fw_cmd_ofld_mdelay(struct rtw89_dev *rtwdev, u32 ms)
+{
+	struct rtw89_fw_cmd_ofld_arg cmd = {
+		.src = RTW89_FW_CMD_OFLD_SRC_OTHER,
+		.type = RTW89_FW_CMD_OFLD_DELAY,
+		.value = ms * 1000,
+	};
+	int ret;
+
+	ret = rtw89_fw_cmd_ofld_enqueue(rtwdev, &cmd);
+	if (ret)
+		mdelay(ms);
+}
+
+static const struct rtw89_io_ops rtw89_fw_cmd_ofld_io = {
+	.pack = rtw89_fw_cmd_ofld_pack,
+	.unpack = rtw89_fw_cmd_ofld_unpack,
+	.do_udelay = rtw89_fw_cmd_ofld_udelay,
+	.do_mdelay = rtw89_fw_cmd_ofld_mdelay,
+	.write8 = rtw89_fw_cmd_ofld_write8,
+	.write16 = rtw89_fw_cmd_ofld_write16,
+	.write32 = rtw89_fw_cmd_ofld_write32,
+	.phy_write8 = rtw89_fw_cmd_ofld_phy_write8,
+	.phy_write16 = rtw89_fw_cmd_ofld_phy_write16,
+	.phy_write32 = rtw89_fw_cmd_ofld_phy_write32,
+	.write_rf = rtw89_fw_cmd_ofld_write_rf,
+};
+
+const struct rtw89_io_ops *
+rtw89_fw_cmd_ofld_alloc_and_get_io_ops(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_fw_cmd_ofld_info *info;
+
+	if (!(rtwdev->hci.type == RTW89_HCI_TYPE_USB && chip->support_fw_cmd_ofld))
+		return &rtw89_raw_io;
+
+	info = devm_kzalloc(rtwdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return &rtw89_raw_io;
+
+	rtwdev->fw_cmd_ofld_info = info;
+
+	return &rtw89_fw_cmd_ofld_io;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index db252d45e498..4d94a7195708 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3115,6 +3115,59 @@ struct rtw89_h2c_trx_protect {
 #define RTW89_H2C_TRX_PROTECT_W1_CHINFO_EN BIT(0)
 #define RTW89_H2C_TRX_PROTECT_W1_DFS_EN BIT(1)
 
+enum rtw89_fw_cmd_ofld_arg_src {
+	RTW89_FW_CMD_OFLD_SRC_BB,
+	RTW89_FW_CMD_OFLD_SRC_RF,
+	RTW89_FW_CMD_OFLD_SRC_MAC,
+	RTW89_FW_CMD_OFLD_SRC_RF_DDIE,
+	RTW89_FW_CMD_OFLD_SRC_OTHER,
+};
+
+enum rtw89_fw_cmd_ofld_arg_type {
+	RTW89_FW_CMD_OFLD_WRITE,
+	RTW89_FW_CMD_OFLD_COMPARE,
+	RTW89_FW_CMD_OFLD_DELAY,
+	RTW89_FW_CMD_OFLD_MOVE,
+};
+
+struct rtw89_fw_cmd_ofld_arg {
+	enum rtw89_fw_cmd_ofld_arg_src src;
+	enum rtw89_fw_cmd_ofld_arg_type type;
+	enum rtw89_rf_path rf_path;
+	u32 value;
+	u32 mask;
+	u32 offset;
+	u16 id;
+};
+
+struct rtw89_h2c_cmd_ofld {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+} __packed;
+
+#define RTW89_H2C_CMD_OFLD_W0_SRC GENMASK(1, 0)
+#define RTW89_H2C_CMD_OFLD_W0_TYPE GENMASK(3, 2)
+#define RTW89_H2C_CMD_OFLD_W0_LC BIT(4)
+#define RTW89_H2C_CMD_OFLD_W0_PATH GENMASK(6, 5)
+#define RTW89_H2C_CMD_OFLD_W0_CMD_NUM GENMASK(14, 8)
+#define RTW89_H2C_CMD_OFLD_W0_OFFSET GENMASK(31, 16)
+#define RTW89_H2C_CMD_OFLD_W1_ID GENMASK(15, 0)
+#define RTW89_H2C_CMD_OFLD_W1_BASE_OFFSET GENMASK(31, 16)
+#define RTW89_H2C_CMD_OFLD_W2_VALUE GENMASK(31, 0)
+#define RTW89_H2C_CMD_OFLD_W3_MASK GENMASK(31, 0)
+#define RTW89_W8_MASK_OF_ALIGNED_ADDR(offset) (0xff << (((offset) & 0x3) << 3))
+#define RTW89_W16_MASK_OF_ALIGNED_ADDR(offset) (0xffff << (((offset) & 0x2) * 8))
+
+#define RTW89_FW_CMD_OFLD_NR 125
+struct rtw89_fw_cmd_ofld_info {
+	unsigned int pack_level;
+	u32 cnt;
+	u32 accu_delay;
+	struct rtw89_h2c_cmd_ofld cmds[RTW89_FW_CMD_OFLD_NR];
+};
+
 struct rtw89_h2c_fwips {
 	__le32 w0;
 } __packed;
@@ -4606,6 +4659,7 @@ enum rtw89_fw_ofld_h2c_func {
 	H2C_FUNC_MAC_MACID_PAUSE	= 0x8,
 	H2C_FUNC_USR_EDCA		= 0xF,
 	H2C_FUNC_TSF32_TOGL		= 0x10,
+	H2C_FUNC_CMD_OFLD_PKT		= 0x13,
 	H2C_FUNC_OFLD_CFG		= 0x14,
 	H2C_FUNC_ADD_SCANOFLD_CH	= 0x16,
 	H2C_FUNC_SCANOFLD		= 0x17,
@@ -5737,4 +5791,7 @@ enum rtw89_wow_wakeup_ver {
 	RTW89_WOW_REASON_NUM,
 };
 
+const struct rtw89_io_ops *
+rtw89_fw_cmd_ofld_alloc_and_get_io_ops(struct rtw89_dev *rtwdev);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index bde419edf744..3f9d306ff1ca 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -576,30 +576,48 @@ extern const struct rtw89_phy_gen_def rtw89_phy_gen_ax;
 extern const struct rtw89_phy_gen_def rtw89_phy_gen_be;
 extern const struct rtw89_phy_gen_def rtw89_phy_gen_be_v1;
 
-static inline void rtw89_phy_write8(struct rtw89_dev *rtwdev,
-				    u32 addr, u8 data)
+static inline void rtw89_raw_phy_write8(struct rtw89_dev *rtwdev,
+					u32 addr, u8 data)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 
 	rtw89_write8(rtwdev, addr + phy->cr_base, data);
 }
 
-static inline void rtw89_phy_write16(struct rtw89_dev *rtwdev,
-				     u32 addr, u16 data)
+static inline void rtw89_raw_phy_write16(struct rtw89_dev *rtwdev,
+					 u32 addr, u16 data)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 
 	rtw89_write16(rtwdev, addr + phy->cr_base, data);
 }
 
-static inline void rtw89_phy_write32(struct rtw89_dev *rtwdev,
-				     u32 addr, u32 data)
+static inline void rtw89_raw_phy_write32(struct rtw89_dev *rtwdev,
+					 u32 addr, u32 data)
 {
 	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
 
 	rtw89_write32(rtwdev, addr + phy->cr_base, data);
 }
 
+static inline void rtw89_phy_write8(struct rtw89_dev *rtwdev,
+				    u32 addr, u8 data)
+{
+	rtwdev->io->phy_write8(rtwdev, addr, data);
+}
+
+static inline void rtw89_phy_write16(struct rtw89_dev *rtwdev,
+				     u32 addr, u16 data)
+{
+	rtwdev->io->phy_write16(rtwdev, addr, data);
+}
+
+static inline void rtw89_phy_write32(struct rtw89_dev *rtwdev,
+				     u32 addr, u32 data)
+{
+	rtwdev->io->phy_write32(rtwdev, addr, data);
+}
+
 static inline void rtw89_phy_write32_set(struct rtw89_dev *rtwdev,
 					 u32 addr, u32 bits)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 84bdd39b3ceb..5750038b0ba7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2639,6 +2639,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.support_tas		= false,
 	.support_sar_by_ant	= false,
 	.support_noise		= false,
+	.support_fw_cmd_ofld	= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_from_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 1d4f1df524a1..bb63b5efbe82 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2376,6 +2376,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.support_tas		= false,
 	.support_sar_by_ant	= false,
 	.support_noise		= true,
+	.support_fw_cmd_ofld	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_from_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 5e8738bb2dc2..a71d01d5be7e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -972,6 +972,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.support_tas		= false,
 	.support_sar_by_ant	= true,
 	.support_noise		= false,
+	.support_fw_cmd_ofld	= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_from_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 0d980fcd22d4..9d6a13f569f8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -812,6 +812,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.support_tas		= false,
 	.support_sar_by_ant	= true,
 	.support_noise		= false,
+	.support_fw_cmd_ofld	= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_from_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 40db7e3c0d97..b3f3eb365d19 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3169,6 +3169,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.support_tas		= true,
 	.support_sar_by_ant	= true,
 	.support_noise		= false,
+	.support_fw_cmd_ofld	= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
 	.rx_freq_from_ie	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 8f6cf64271e8..d2ff55b23f95 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2973,6 +2973,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.support_tas		= true,
 	.support_sar_by_ant	= true,
 	.support_noise		= false,
+	.support_fw_cmd_ofld	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_from_ie	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index a3890e863423..564d4baa59e7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2986,6 +2986,7 @@ const struct rtw89_chip_info rtw8922d_chip_info = {
 	.support_tas		= false,
 	.support_sar_by_ant	= true,
 	.support_noise		= false,
+	.support_fw_cmd_ofld	= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_from_ie	= false,
-- 
2.25.1


