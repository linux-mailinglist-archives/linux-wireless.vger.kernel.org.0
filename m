Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D91554A2
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGJ3A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:29:00 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44691 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgBGJ27 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:28:59 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0179SpEa018568, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0179SpEa018568
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 17:28:51 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:51 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 17:28:51 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 17:28:50 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
Subject: [PATCH 5/8] rtw88: sar: Load dynamic SAR table from ACPI methods
Date:   Fri, 7 Feb 2020 17:28:41 +0800
Message-ID: <20200207092844.29175-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207092844.29175-1-yhchuang@realtek.com>
References: <20200207092844.29175-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Three tables RWRD, RWSI and RWGS are defined to support SAR power limit
proposed by Realtek. RWRD describes main power limit values that can support
more than one mode, tablet, lid close and etc. RWSI is used to indicate
which mode is operating, so driver must apply SAR power limit corresponding
to the mode. Since each country (geography) has some different SAR power
limit values, RWGS is introduced to adjust power limit mentioned in RWRD
if stack hints driver that regulatory domain is changed.

RWRD contains customer ID, SAR enable, table count and SAR power limit.
With different customer ID, the formats of RWRD, RWSI and RWGS are
different, such as the number of fields in table and precision of power
limit value (in Q-notation). By now, two customer IDs are supported, RT
and HP. 'table count' indicates total number of tables corresponding to
operating modes, and selected by WRSI.

To validate RWSI and RWGS tables, we check if read length and sizeof() are
equal. But these checking statements depend on RWRD's ID are little
verbose, so I use two predefined values, rwsi_sz and rwgs_sz, would be easy
to understand the code.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c |   2 +
 drivers/net/wireless/realtek/rtw88/main.h |   8 +
 drivers/net/wireless/realtek/rtw88/sar.c  | 301 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/sar.h  |   1 +
 4 files changed, 312 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 23cbb00e16b1..039703f1ccb9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1449,6 +1449,8 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 		kfree(rsvd_pkt);
 	}
 
+	rtw_sar_release_table(rtwdev);
+
 	mutex_destroy(&rtwdev->mutex);
 	mutex_destroy(&rtwdev->coex.mutex);
 	mutex_destroy(&rtwdev->hal.tx_power_mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b4e9e18f89a5..bf5e66930424 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -46,6 +46,10 @@ extern struct rtw_chip_info rtw8822c_hw_spec;
 #define RTW_MAX_CHANNEL_NUM_5G 49
 
 struct rtw_dev;
+struct rtw_sar_rwrd;
+union rtw_sar_rwsi;
+union rtw_sar_rwgs;
+struct rtw_sar_read;
 
 enum rtw_hci_type {
 	RTW_HCI_TYPE_PCIE,
@@ -1522,6 +1526,10 @@ struct rtw_fw_state {
 
 struct rtw_sar {
 	enum rtw_sar_sources source;
+	struct rtw_sar_rwrd *rwrd;
+	union rtw_sar_rwsi *rwsi;
+	union rtw_sar_rwgs *rwgs;
+	const struct rtw_sar_read *read;
 };
 
 struct rtw_hal {
diff --git a/drivers/net/wireless/realtek/rtw88/sar.c b/drivers/net/wireless/realtek/rtw88/sar.c
index f15366ce1046..d81a6511f138 100644
--- a/drivers/net/wireless/realtek/rtw88/sar.c
+++ b/drivers/net/wireless/realtek/rtw88/sar.c
@@ -187,14 +187,315 @@ static int rtw_sar_load_static_tables(struct rtw_dev *rtwdev)
 
 	return 0;
 }
+
+#define ACPI_RWRD_METHOD	"RWRD"
+#define ACPI_RWSI_METHOD	"RWSI"
+#define ACPI_RWGS_METHOD	"RWGS"
+
+#define RTW_SAR_RWRD_ID_HP	0x5048
+#define RTW_SAR_RWRD_ID_RT	0x5452
+
+#define RTW_SAR_RWRD_CHAIN_NR	4
+
+struct rtw_sar_rwrd {
+	u16 id;
+	u8 en;
+	u8 count;
+	struct {
+		struct rtw_sar_limits chain[RTW_SAR_RWRD_CHAIN_NR];
+	} mode[0];
+} __packed;
+
+struct rtw_sar_rwsi_hp {
+	u8 index[RTW_SAR_RWRD_CHAIN_NR];
+} __packed;
+
+struct rtw_sar_rwsi_rt {
+	u8 index;
+} __packed;
+
+union rtw_sar_rwsi {
+	struct rtw_sar_rwsi_hp hp;
+	struct rtw_sar_rwsi_rt rt;
+};
+
+enum rtw_sar_rwgs_band {
+	RTW_SAR_RWGS_2G,
+	RTW_SAR_RWGS_5G,
+	RTW_SAR_RWGS_BAND_NR,
+};
+
+enum rtw_sar_rwgs_geo_hp {
+	RTW_SAR_RWGS_HP_FCC_IC,
+	RTW_SAR_RWGS_HP_ETSI_MKK,
+	RTW_SAR_RWGS_HP_WW_KCC,
+
+	RTW_SAR_RWGS_HP_NR,
+};
+
+struct rtw_sar_rwgs_hp {
+	struct {
+		struct {
+			s8 max;		/* Q1 + 10 */
+			s8 delta[4];	/* Q1 */
+		} band[RTW_SAR_RWGS_BAND_NR];
+	} geo[RTW_SAR_RWGS_HP_NR];
+} __packed;
+
+enum rtw_sar_rwgs_geo_rt {
+	RTW_SAR_RWGS_RT_FCC,
+	RTW_SAR_RWGS_RT_CE,
+	RTW_SAR_RWGS_RT_MKK,
+	RTW_SAR_RWGS_RT_IC,
+	RTW_SAR_RWGS_RT_KCC,
+	RTW_SAR_RWGS_RT_WW,
+
+	RTW_SAR_RWGS_RT_NR,
+};
+
+struct rtw_sar_rwgs_rt {
+	struct {
+		struct {
+			u8 max;		/* Q3 */
+			s8 delta;	/* Q1 */
+		} band[RTW_SAR_RWGS_BAND_NR];
+	} geo[RTW_SAR_RWGS_RT_NR];
+} __packed;
+
+union rtw_sar_rwgs {
+	struct rtw_sar_rwgs_hp hp;
+	struct rtw_sar_rwgs_rt rt;
+};
+
+struct rtw_sar_read {
+	int rwsi_sz;
+	int rwgs_sz;
+};
+
+static const struct rtw_sar_read sar_read_hp = {
+	.rwsi_sz = sizeof(struct rtw_sar_rwsi_hp),
+	.rwgs_sz = sizeof(struct rtw_sar_rwgs_hp),
+};
+
+static const struct rtw_sar_read sar_read_rt = {
+	.rwsi_sz = sizeof(struct rtw_sar_rwsi_rt),
+	.rwgs_sz = sizeof(struct rtw_sar_rwgs_rt),
+};
+
+static u8 *rtw_sar_get_raw_package(struct rtw_dev *rtwdev,
+				   union acpi_object *obj, int *len)
+{
+	u8 *raw;
+	u32 i;
+
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count <= 0) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"SAR: Unsupported obj to dump\n");
+		return NULL;
+	}
+
+	raw = kmalloc(obj->package.count, GFP_KERNEL);
+	if (!raw)
+		return NULL;
+
+	for (i = 0; i < obj->package.count; i++) {
+		union acpi_object *element;
+
+		element = &obj->package.elements[i];
+
+		if (element->type != ACPI_TYPE_INTEGER) {
+			rtw_dbg(rtwdev, RTW_DBG_REGD,
+				"SAR: Unexpected element type\n");
+			kfree(raw);
+			return NULL;
+		}
+
+		raw[i] = (u8)element->integer.value;
+	}
+
+	*len = obj->package.count;
+
+	return raw;
+}
+
+static void *rtw_sar_get_raw_table(struct rtw_dev *rtwdev, const char *method,
+				   int *len)
+{
+	union acpi_object *obj;
+	u8 *raw;
+
+	obj = rtw_sar_get_acpiobj(rtwdev, method);
+	if (!obj)
+		return NULL;
+
+	raw = rtw_sar_get_raw_package(rtwdev, obj, len);
+	kfree(obj);
+
+	return raw;
+}
+
+static bool is_valid_rwrd(struct rtw_dev *rtwdev, const struct rtw_sar_rwrd *rwrd,
+			  int len)
+{
+	if (len < sizeof(*rwrd)) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"SAR: RWRD: len %d is too short\n", len);
+		return false;
+	}
+
+	switch (rwrd->id) {
+	case RTW_SAR_RWRD_ID_HP:
+		rtwdev->sar.read = &sar_read_hp;
+		break;
+	case RTW_SAR_RWRD_ID_RT:
+		rtwdev->sar.read = &sar_read_rt;
+		break;
+	default:
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"SAR: RWRD: ID %04x isn't supported\n", rwrd->id);
+		return false;
+	}
+
+	if (sizeof(*rwrd) + rwrd->count * sizeof(rwrd->mode[0]) != len) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD,
+			"SAR: RWRD: len(%d) doesn't match count(%d)\n",
+			len, rwrd->count);
+		return false;
+	}
+
+	return true;
+}
+
+static bool is_valid_rwsi_idx(struct rtw_dev *rtwdev, const struct rtw_sar_rwrd *rwrd,
+			      const u8 index[], int len)
+{
+	/* index range is one based. i.e. 1 <= index[] <= rwrd->count */
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (index[i] < 1 || index[i] > rwrd->count) {
+			rtw_dbg(rtwdev, RTW_DBG_REGD,
+				"SAR: RWSI: index is out of range\n");
+			return false;
+		}
+
+	return true;
+}
+
+static bool is_valid_rwsi(struct rtw_dev *rtwdev, const struct rtw_sar_rwrd *rwrd,
+			  const union rtw_sar_rwsi *rwsi, int len)
+{
+	const struct rtw_sar_read *r = rtwdev->sar.read;
+
+	if (r->rwsi_sz != len)
+		goto err;
+
+	if (rwrd->id == RTW_SAR_RWRD_ID_HP &&
+	    is_valid_rwsi_idx(rtwdev, rwrd, rwsi->hp.index, RTW_SAR_RWRD_CHAIN_NR))
+		return true;
+
+	if (rwrd->id == RTW_SAR_RWRD_ID_RT &&
+	    is_valid_rwsi_idx(rtwdev, rwrd, &rwsi->rt.index, 1)) {
+		return true;
+	}
+
+err:
+	rtw_dbg(rtwdev, RTW_DBG_REGD,
+		"SAR: RWSI: len doesn't match struct size\n");
+
+	return false;
+}
+
+static bool is_valid_rwgs(struct rtw_dev *rtwdev, const struct rtw_sar_rwrd *rwrd,
+			  const union rtw_sar_rwgs *rwgs, int len)
+{
+	const struct rtw_sar_read *r = rtwdev->sar.read;
+
+	if (r->rwgs_sz == len)
+		return true;
+
+	rtw_dbg(rtwdev, RTW_DBG_REGD,
+		"SAR: RWGS: len doesn't match struct size\n");
+
+	return false;
+}
+
+static int rtw_sar_load_dynamic_tables(struct rtw_dev *rtwdev)
+{
+	struct rtw_sar_rwrd *rwrd;
+	union rtw_sar_rwsi *rwsi;
+	union rtw_sar_rwgs *rwgs;
+	int len;
+	bool valid;
+
+	rwrd = rtw_sar_get_raw_table(rtwdev, ACPI_RWRD_METHOD, &len);
+	if (!rwrd)
+		goto out;
+	valid = is_valid_rwrd(rtwdev, rwrd, len);
+	if (!valid)
+		goto out_rwrd;
+	if (!rwrd->en) {
+		rtw_dbg(rtwdev, RTW_DBG_REGD, "SAR: RWRD isn't enabled\n");
+		goto out_rwrd;
+	}
+
+	rwsi = rtw_sar_get_raw_table(rtwdev, ACPI_RWSI_METHOD, &len);
+	if (!rwsi)
+		goto out_rwrd;
+	valid = is_valid_rwsi(rtwdev, rwrd, rwsi, len);
+	if (!valid)
+		goto out_rwsi;
+
+	rwgs = rtw_sar_get_raw_table(rtwdev, ACPI_RWGS_METHOD, &len);
+	if (!rwgs)
+		goto out_rwsi;
+	valid = is_valid_rwgs(rtwdev, rwrd, rwgs, len);
+	if (!valid)
+		goto out_rwgs;
+
+	rtwdev->sar.rwrd = rwrd;
+	rtwdev->sar.rwsi = rwsi;
+	rtwdev->sar.rwgs = rwgs;
+
+	rtw_dbg(rtwdev, RTW_DBG_REGD, "SAR: RWRD/RWSI/RWGS is adopted\n");
+
+	return 0;
+
+out_rwgs:
+	kfree(rwgs);
+out_rwsi:
+	kfree(rwsi);
+out_rwrd:
+	kfree(rwrd);
+out:
+	return -ENOENT;
+}
 #else
 static int rtw_sar_load_static_tables(struct rtw_dev *rtwdev)
 {
 	return -ENOENT;
 }
+
+static int rtw_sar_load_dynamic_tables(struct rtw_dev *rtwdev)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_ACPI */
 
 void rtw_sar_load_table(struct rtw_dev *rtwdev)
 {
+	int ret;
+
+	ret = rtw_sar_load_dynamic_tables(rtwdev);
+	if (!ret)
+		return;	/* if dynamic SAR table is loaded, ignore static SAR table */
+
 	rtw_sar_load_static_tables(rtwdev);
 }
+
+void rtw_sar_release_table(struct rtw_dev *rtwdev)
+{
+	kfree(rtwdev->sar.rwrd);
+	kfree(rtwdev->sar.rwsi);
+	kfree(rtwdev->sar.rwgs);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/sar.h b/drivers/net/wireless/realtek/rtw88/sar.h
index 632de7ed58c3..16ceae5bf79e 100644
--- a/drivers/net/wireless/realtek/rtw88/sar.h
+++ b/drivers/net/wireless/realtek/rtw88/sar.h
@@ -6,5 +6,6 @@
 #define __RTW_SAR_H_
 
 void rtw_sar_load_table(struct rtw_dev *rtwdev);
+void rtw_sar_release_table(struct rtw_dev *rtwdev);
 
 #endif
-- 
2.17.1

