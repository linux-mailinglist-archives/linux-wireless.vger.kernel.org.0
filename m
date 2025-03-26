Return-Path: <linux-wireless+bounces-20832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB2A70EC4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 03:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3037189AA54
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C053AC17;
	Wed, 26 Mar 2025 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZGGffwii"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BAD86344
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954844; cv=none; b=BJ40jPfFpUK9zKvdeSxTcc4Mk97yFIITIAxty+AQI+2GeO0g6Ii0IDhZwcScPii667oGCHzBWtdm6GOnW57t4Uq1QgV6vDzhXNxzQFqtaT6Ckx2Zay+NSHNXv93GDTtPILQMs9nQ0/ryaxvT6gNmj0w8vjyzJPCOFtwzVa0D83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954844; c=relaxed/simple;
	bh=r7lp7rRoqU3m8IKlkicN5HbOY5yntECrkL8LwIG8T0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rf3Zyto0kLmo04Z/iM5y+za11bdRV+SuSfOCB7b8ePLKmKXm8NMZM4dg+K7d/o6+f7x8LKM+A8K4Q/tDiSI5IYMC1SnV8eGoA3SX1rMCESry/y7kVnhYp+Txldursybvf6/+d4HSIlCYLivo6Af5dHUaw+T61GtUKJe6V62BMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZGGffwii; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52Q27KSd81407267, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742954840; bh=r7lp7rRoqU3m8IKlkicN5HbOY5yntECrkL8LwIG8T0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZGGffwiiiSltfCrcfJ3dIjxMgrStzrpEiu2llBPwN7/8OaA3sY/AxmYJeuZhcU4Jb
	 dmu1dp5/PpWV4zk8ntmZ+iKLj6iEDeh3KstGFexFmnJ2H/jn1HHfKkod083wX7gpwy
	 pTwdSGR6r7Ctd58GLK8syCVPPhhmH2wkIecXaBw/0KHlue0IaHdv83+i6hewQhcBXd
	 BOg2AyATN34EX1rVvzx8yrNKpTObyoeiVD2r4IJHGu9UdKdEtipxK1RRDPLZnVqrPQ
	 Zyx6CV+cXd9BgKwQLbv8DcKDtkR63+V8SpKCPo3YAGKZmfCORVa9EC8LfFX/FArYq3
	 b/par9FIiYzTQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52Q27KSd81407267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 10:07:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Mar 2025 10:07:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Mar
 2025 10:07:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 07/12] wifi: rtw89: acpi: support loading dynamic SAR tables and indicator
Date: Wed, 26 Mar 2025 10:06:38 +0800
Message-ID: <20250326020643.14487-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250326020643.14487-1-pkshih@realtek.com>
References: <20250326020643.14487-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Support to load dynamic SAR tables with ACPI RWRD method. The content
format of a single dynamic SAR table is basically the same as static
SAR table. However, it's able to carry multiple dynamic SAR tables at
one time. And, its header contains one more field to describe how many
dynamic SAR tables are filled in the content. Either static SAR table
or dynamic SAR tables can be supported, but not both simultaneously.

Besides, also support to load indicator of dynamic SAR with ACPI RWSI
method. The indicator will describe a target dynamic SAR table, which
should be followed currently, by antenna. It can be changed at runtime
according to platform mode. For example, tablet mode can use different
SAR from normal mode. So, track indicator configuration if dynamic SAR
is configured.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - Different CID expects different number of indicator fields, so don't
    use a single fixed struct for this.
---
 drivers/net/wireless/realtek/rtw89/acpi.c | 133 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h |  12 ++
 drivers/net/wireless/realtek/rtw89/core.c |   2 +-
 drivers/net/wireless/realtek/rtw89/core.h |  13 +++
 drivers/net/wireless/realtek/rtw89/sar.c  | 106 +++++++++++++----
 drivers/net/wireless/realtek/rtw89/sar.h  |   2 +-
 6 files changed, 246 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index b937832b0f7a..d66515def211 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -688,25 +688,158 @@ rtw89_acpi_evaluate_static_sar(struct rtw89_dev *rtwdev,
 	return rec;
 }
 
+static const struct rtw89_acpi_sar_recognition *
+rtw89_acpi_evaluate_dynamic_sar(struct rtw89_dev *rtwdev,
+				struct rtw89_sar_cfg_acpi *cfg)
+{
+	const struct rtw89_acpi_sar_recognition *rec = NULL;
+	const struct rtw89_acpi_dynamic_sar_hdr *hdr;
+	struct rtw89_acpi_sar_rec_parm parm = {};
+	struct rtw89_sar_table_from_acpi *tbl;
+	const struct rtw89_acpi_data *data;
+	u32 len;
+
+	data = rtw89_acpi_evaluate_method(rtwdev, RTW89_ACPI_METHOD_DYNAMIC_SAR);
+	if (!data)
+		return NULL;
+
+	rtw89_debug(rtwdev, RTW89_DBG_ACPI, "acpi load dynamic sar\n");
+
+	len = data->len;
+	if (len <= sizeof(*hdr)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "invalid buf len %u\n", len);
+		goto out;
+	}
+
+	hdr = (typeof(hdr))data->buf;
+
+	parm.cid = le16_to_cpu(hdr->cid);
+	parm.rev = hdr->rev;
+	parm.tbl_cnt = hdr->cnt;
+	parm.pld_len = len - sizeof(*hdr);
+
+	rec = rtw89_acpi_sar_recognize(rtwdev, &parm);
+	if (!rec)
+		goto out;
+
+	for (unsigned int i = 0; i < hdr->cnt; i++) {
+		const u8 *content = hdr->content + rec->id.size * i;
+		struct rtw89_sar_entry_from_acpi tmp = {};
+
+		rec->load(rtwdev, rec, content, &tmp);
+
+		tbl = &cfg->tables[i];
+		for (u8 regd = 0; regd < RTW89_REGD_NUM; regd++)
+			tbl->entries[regd] = tmp;
+	}
+
+	cfg->valid_num = hdr->cnt;
+
+out:
+	kfree(data);
+	return rec;
+}
+
+int rtw89_acpi_evaluate_dynamic_sar_indicator(struct rtw89_dev *rtwdev,
+					      struct rtw89_sar_cfg_acpi *cfg,
+					      bool *poll_changed)
+{
+	struct rtw89_sar_indicator_from_acpi *ind = &cfg->indicator;
+	struct rtw89_sar_indicator_from_acpi tmp = *ind;
+	const struct rtw89_acpi_data *data;
+	const u8 *tbl_base1_by_ant;
+	enum rtw89_rf_path path;
+	int ret = 0;
+	u32 len;
+
+	data = rtw89_acpi_evaluate_method(rtwdev, RTW89_ACPI_METHOD_DYNAMIC_SAR_INDICATOR);
+	if (!data)
+		return -EFAULT;
+
+	if (!poll_changed)
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "acpi load dynamic sar indicator\n");
+
+	len = data->len;
+	if (len != ind->fields) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "invalid buf len %u\n", len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tbl_base1_by_ant = data->buf;
+
+	for (path = 0; path < NUM_OF_RTW89_ACPI_SAR_RF_PATH; path++) {
+		u8 antidx = ind->rfpath_to_antidx(path);
+		u8 sel;
+
+		if (antidx >= ind->fields)
+			antidx = 0;
+
+		/* convert the table index from 1-based to 0-based */
+		sel = tbl_base1_by_ant[antidx] - 1;
+		if (sel >= cfg->valid_num)
+			sel = 0;
+
+		tmp.tblsel[path] = sel;
+	}
+
+	if (memcmp(ind, &tmp, sizeof(*ind)) == 0) {
+		if (poll_changed)
+			*poll_changed = false;
+	} else {
+		if (poll_changed)
+			*poll_changed = true;
+
+		*ind = tmp;
+	}
+
+out:
+	kfree(data);
+	return ret;
+}
+
 int rtw89_acpi_evaluate_sar(struct rtw89_dev *rtwdev,
 			    struct rtw89_sar_cfg_acpi *cfg)
 {
+	struct rtw89_sar_indicator_from_acpi *ind = &cfg->indicator;
 	const struct rtw89_acpi_sar_recognition *rec;
+	bool fetch_indicator = false;
+	int ret;
 
 	rec = rtw89_acpi_evaluate_static_sar(rtwdev, cfg);
+	if (rec)
+		goto recognized;
+
+	rec = rtw89_acpi_evaluate_dynamic_sar(rtwdev, cfg);
 	if (!rec)
 		return -ENOENT;
 
+	fetch_indicator = true;
+
+recognized:
 	switch (rec->id.cid) {
 	case RTW89_ACPI_SAR_CID_HP:
 		cfg->downgrade_2tx = 3 << TXPWR_FACTOR_OF_RTW89_ACPI_SAR;
+		ind->fields = RTW89_ACPI_SAR_ANT_NR_STD;
 		break;
 	case RTW89_ACPI_SAR_CID_RT:
 		cfg->downgrade_2tx = 0;
+		ind->fields = 1;
 		break;
 	default:
 		return -EFAULT;
 	}
 
+	if (fetch_indicator) {
+		ind->rfpath_to_antidx = rec->rfpath_to_antidx;
+		ret = rtw89_acpi_evaluate_dynamic_sar_indicator(rtwdev, cfg, NULL);
+		if (ret)
+			fetch_indicator = false;
+	}
+
+	if (!fetch_indicator)
+		memset(ind->tblsel, 0, sizeof(ind->tblsel));
+
+	ind->enable_sync = fetch_indicator;
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index 68a3433dd41e..b03e4af6555e 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -89,6 +89,8 @@ enum rtw89_acpi_sar_rev {
 #define RTW89_ACPI_SAR_ANT_NR_SML 2
 
 #define RTW89_ACPI_METHOD_STATIC_SAR "WRDS"
+#define RTW89_ACPI_METHOD_DYNAMIC_SAR "RWRD"
+#define RTW89_ACPI_METHOD_DYNAMIC_SAR_INDICATOR "RWSI"
 
 struct rtw89_acpi_sar_std_legacy {
 	u8 v[RTW89_ACPI_SAR_ANT_NR_STD][RTW89_ACPI_SAR_SUBBAND_NR_LEGACY];
@@ -112,6 +114,13 @@ struct rtw89_acpi_static_sar_hdr {
 	u8 content[];
 } __packed;
 
+struct rtw89_acpi_dynamic_sar_hdr {
+	__le16 cid;
+	u8 rev;
+	u8 cnt;
+	u8 content[];
+} __packed;
+
 struct rtw89_acpi_sar_identifier {
 	enum rtw89_acpi_sar_cid cid;
 	enum rtw89_acpi_sar_rev rev;
@@ -148,5 +157,8 @@ int rtw89_acpi_evaluate_rtag(struct rtw89_dev *rtwdev,
 			     struct rtw89_acpi_rtag_result *res);
 int rtw89_acpi_evaluate_sar(struct rtw89_dev *rtwdev,
 			    struct rtw89_sar_cfg_acpi *cfg);
+int rtw89_acpi_evaluate_dynamic_sar_indicator(struct rtw89_dev *rtwdev,
+					      struct rtw89_sar_cfg_acpi *cfg,
+					      bool *changed);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 2088c6f4a98e..869728922def 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3617,7 +3617,7 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 	rtw89_phy_antdiv_track(rtwdev);
 	rtw89_phy_ul_tb_ctrl_track(rtwdev);
 	rtw89_phy_edcca_track(rtwdev);
-	rtw89_tas_track(rtwdev);
+	rtw89_sar_track(rtwdev);
 	rtw89_chanctx_track(rtwdev);
 	rtw89_core_rfkill_poll(rtwdev, false);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f36546505b0d..0789a943074f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4666,10 +4666,23 @@ struct rtw89_sar_table_from_acpi {
 	struct rtw89_sar_entry_from_acpi entries[RTW89_REGD_NUM];
 };
 
+struct rtw89_sar_indicator_from_acpi {
+	bool enable_sync;
+	unsigned int fields;
+	u8 (*rfpath_to_antidx)(enum rtw89_rf_path rfpath);
+
+	/* Select among @tables of container, rtw89_sar_cfg_acpi, by path.
+	 * Not design with pointers since addresses will be invalid after
+	 * sync content with local container instance.
+	 */
+	u8 tblsel[NUM_OF_RTW89_ACPI_SAR_RF_PATH];
+};
+
 struct rtw89_sar_cfg_acpi {
 	u8 downgrade_2tx;
 	unsigned int valid_num;
 	struct rtw89_sar_table_from_acpi tables[MAX_NUM_OF_RTW89_ACPI_SAR_TBL];
+	struct rtw89_sar_indicator_from_acpi indicator;
 };
 
 struct rtw89_sar_info {
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 8bf5b5d9ef37..120cf2088c9e 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -92,6 +92,21 @@ static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static const struct rtw89_sar_entry_from_acpi *
+rtw89_sar_cfg_acpi_get_ent(const struct rtw89_sar_cfg_acpi *rtwsar,
+			   enum rtw89_rf_path path,
+			   enum rtw89_regulation_type regd)
+{
+	const struct rtw89_sar_indicator_from_acpi *ind = &rtwsar->indicator;
+	const struct rtw89_sar_table_from_acpi *tbl;
+	u8 sel;
+
+	sel = ind->tblsel[path];
+	tbl = &rtwsar->tables[sel];
+
+	return &tbl->entries[regd];
+}
+
 static
 s32 rtw89_sar_cfg_acpi_get_min(const struct rtw89_sar_entry_from_acpi *ent,
 			       enum rtw89_rf_path path,
@@ -106,9 +121,8 @@ static int rtw89_query_sar_config_acpi(struct rtw89_dev *rtwdev,
 				       s32 *cfg)
 {
 	const struct rtw89_sar_cfg_acpi *rtwsar = &rtwdev->sar.cfg_acpi;
-	const struct rtw89_sar_table_from_acpi *tbl = rtwsar->tables;
+	const struct rtw89_sar_entry_from_acpi *ent_a, *ent_b;
 	enum rtw89_acpi_sar_subband subband_l, subband_h;
-	const struct rtw89_sar_entry_from_acpi *ent;
 	u32 center_freq = sar_parm->center_freq;
 	const struct rtw89_6ghz_span *span;
 	enum rtw89_regulation_type regd;
@@ -127,10 +141,12 @@ static int rtw89_query_sar_config_acpi(struct rtw89_dev *rtwdev,
 
 	band = rtw89_acpi_sar_subband_to_band(rtwdev, subband_l);
 	regd = rtw89_regd_get(rtwdev, band);
-	ent = &tbl->entries[regd];
 
-	cfg_a = rtw89_sar_cfg_acpi_get_min(ent, RF_PATH_A, subband_l, subband_h);
-	cfg_b = rtw89_sar_cfg_acpi_get_min(ent, RF_PATH_B, subband_l, subband_h);
+	ent_a = rtw89_sar_cfg_acpi_get_ent(rtwsar, RF_PATH_A, regd);
+	ent_b = rtw89_sar_cfg_acpi_get_ent(rtwsar, RF_PATH_B, regd);
+
+	cfg_a = rtw89_sar_cfg_acpi_get_min(ent_a, RF_PATH_A, subband_l, subband_h);
+	cfg_b = rtw89_sar_cfg_acpi_get_min(ent_b, RF_PATH_B, subband_l, subband_h);
 	*cfg = min(cfg_a, cfg_b);
 
 	if (sar_parm->ntx == RTW89_2TX)
@@ -502,18 +518,27 @@ static bool rtw89_tas_query_sar_config(struct rtw89_dev *rtwdev, s32 *cfg)
 	return true;
 }
 
-static void rtw89_tas_state_update(struct rtw89_dev *rtwdev,
-				   enum rtw89_tas_state state)
+static bool __rtw89_tas_state_update(struct rtw89_dev *rtwdev,
+				     enum rtw89_tas_state state)
 {
 	struct rtw89_tas_info *tas = &rtwdev->tas;
 
 	if (tas->state == state)
-		return;
+		return false;
 
 	rtw89_debug(rtwdev, RTW89_DBG_SAR, "tas: switch state: %s -> %s\n",
 		    rtw89_tas_state_str(tas->state), rtw89_tas_state_str(state));
 
 	tas->state = state;
+	return true;
+}
+
+static void rtw89_tas_state_update(struct rtw89_dev *rtwdev,
+				   enum rtw89_tas_state state)
+{
+	if (!__rtw89_tas_state_update(rtwdev, state))
+		return;
+
 	rtw89_core_set_chip_txpwr(rtwdev);
 }
 
@@ -608,7 +633,7 @@ static void rtw89_tas_history_update(struct rtw89_dev *rtwdev)
 		    rtw89_linear_to_db_quarter(div_u64(txpwr, PERCENT)));
 }
 
-static void rtw89_tas_rolling_average(struct rtw89_dev *rtwdev)
+static bool rtw89_tas_rolling_average(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_tas_info *tas = &rtwdev->tas;
 	s32 dpr_on_threshold, dpr_off_threshold;
@@ -634,9 +659,9 @@ static void rtw89_tas_rolling_average(struct rtw89_dev *rtwdev)
 	else if (txpwr_avg < dpr_off_threshold)
 		state = RTW89_TAS_STATE_DPR_OFF;
 	else
-		return;
+		return false;
 
-	rtw89_tas_state_update(rtwdev, state);
+	return __rtw89_tas_state_update(rtwdev, state);
 }
 
 static void rtw89_tas_init(struct rtw89_dev *rtwdev)
@@ -717,29 +742,28 @@ void rtw89_tas_reset(struct rtw89_dev *rtwdev, bool force)
 		    "tas: band: %u, freq: %u\n", chan->band_type, chan->freq);
 }
 
-void rtw89_tas_track(struct rtw89_dev *rtwdev)
+static bool rtw89_tas_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_tas_info *tas = &rtwdev->tas;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	s32 cfg;
 
 	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_TAS))
-		return;
+		return false;
 
 	if (!rtw89_tas_is_active(rtwdev))
-		return;
+		return false;
 
-	if (!rtw89_tas_query_sar_config(rtwdev, &cfg) || tas->block_regd) {
-		rtw89_tas_state_update(rtwdev, RTW89_TAS_STATE_STATIC_SAR);
-		return;
-	}
+	if (!rtw89_tas_query_sar_config(rtwdev, &cfg) || tas->block_regd)
+		return __rtw89_tas_state_update(rtwdev, RTW89_TAS_STATE_STATIC_SAR);
 
 	if (tas->pause)
-		return;
+		return false;
 
 	rtw89_tas_window_update(rtwdev);
 	rtw89_tas_history_update(rtwdev);
-	rtw89_tas_rolling_average(rtwdev);
+
+	return rtw89_tas_rolling_average(rtwdev);
 }
 
 void rtw89_tas_scan(struct rtw89_dev *rtwdev, bool start)
@@ -792,3 +816,45 @@ void rtw89_sar_init(struct rtw89_dev *rtwdev)
 	rtw89_set_sar_from_acpi(rtwdev);
 	rtw89_tas_init(rtwdev);
 }
+
+static bool rtw89_sar_track_acpi(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_sar_cfg_acpi *cfg = &rtwdev->sar.cfg_acpi;
+	struct rtw89_sar_indicator_from_acpi *ind = &cfg->indicator;
+	const enum rtw89_sar_sources src = rtwdev->sar.src;
+	bool changed;
+	int ret;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	if (src != RTW89_SAR_SOURCE_ACPI)
+		return false;
+
+	if (!ind->enable_sync)
+		return false;
+
+	ret = rtw89_acpi_evaluate_dynamic_sar_indicator(rtwdev, cfg, &changed);
+	if (likely(!ret))
+		return changed;
+
+	rtw89_debug(rtwdev, RTW89_DBG_SAR,
+		    "%s: failed to track indicator: %d; reset and disable\n",
+		    __func__, ret);
+
+	memset(ind->tblsel, 0, sizeof(ind->tblsel));
+	ind->enable_sync = false;
+	return true;
+}
+
+void rtw89_sar_track(struct rtw89_dev *rtwdev)
+{
+	unsigned int changes = 0;
+
+	changes += rtw89_sar_track_acpi(rtwdev);
+	changes += rtw89_tas_track(rtwdev);
+
+	if (!changes)
+		return;
+
+	rtw89_core_set_chip_txpwr(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 2d30e0d8be1f..038a5c0d1e09 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -31,10 +31,10 @@ int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz);
 int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 			    const struct cfg80211_sar_specs *sar);
 void rtw89_tas_reset(struct rtw89_dev *rtwdev, bool force);
-void rtw89_tas_track(struct rtw89_dev *rtwdev);
 void rtw89_tas_scan(struct rtw89_dev *rtwdev, bool start);
 void rtw89_tas_chanctx_cb(struct rtw89_dev *rtwdev,
 			  enum rtw89_chanctx_state state);
 void rtw89_sar_init(struct rtw89_dev *rtwdev);
+void rtw89_sar_track(struct rtw89_dev *rtwdev);
 
 #endif
-- 
2.25.1


