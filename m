Return-Path: <linux-wireless+bounces-20601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD7A69EC5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 04:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5DA1896F7D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DA1EB1BD;
	Thu, 20 Mar 2025 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iPLpg4Xp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F51EDA3B
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441279; cv=none; b=pbSWLWVW7WzIu0Cw0eXPfHJzCb7Bhb/2ic6rXLfkkZpdxYU/L5LbOvsfKAP2LbPzRnjNzEzgW7g8OVvSI4k/IsxWLpcgaJmvMzVJIuspMX4lCk0IqgP4nBQECdz4WRq2UfrJfqQmR55i07X/nd7AmFsOMupRj+pKHvqqOurVT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441279; c=relaxed/simple;
	bh=9R25HcfGxGAo8K3ONSIrjV6ektvazrNJA6/o4l5T7aY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl9Xvk6jhCCukeDwtzbpBKcu1RIQumP0PDTSQOBId+XNis0kbqz6kSiu+zvzzgQr5qne3bg4Jzh+emkvbeXjCo6yIlUynStaNYardK/fkkJW6IOCrcJ56HA2zqiRnB6p22PmZkyCdE+tLjy/3zw8/hAETNnGedJ1gbklpSSvbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iPLpg4Xp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3RsuA61750926, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742441274; bh=9R25HcfGxGAo8K3ONSIrjV6ektvazrNJA6/o4l5T7aY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iPLpg4XpYmmoHrRpUBPCl7zq0hK4lzI62Dh8w4xycJ14+6Jop7ofQ6GsYvkdZ/TVi
	 z4NerrCsuz9nQAURtMOCfwkZmSxNYM2r2dOoEsLt1GY6yGu+tnpmKCS2VKdGmBNoj1
	 OWsSbEJ2DBDvOwvzsL0PqbtPgLFyK1aCwfpQSLmFFSF0IHcH7xmpNm4ymFFA+JvYBY
	 kWEyyMCpDB8cqbrsaHd5k3DGhuBI7YOhmr6WPmNsupGbK2wr0VSY9stY4tlXP1NPlY
	 JRBBBTgQiA69uMDV51tooNZSPS7BANfaGsAGblnxOCQiVld9ebRl3ErSbZSW5yDBvG
	 FYAWF9zDtujiQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3RsuA61750926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 11:27:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:27:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Mar
 2025 11:27:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/12] wifi: rtw89: acpi: support loading static SAR table
Date: Thu, 20 Mar 2025 11:27:06 +0800
Message-ID: <20250320032712.20284-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320032712.20284-1-pkshih@realtek.com>
References: <20250320032712.20284-1-pkshih@realtek.com>
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

Support to load static SAR table with ACPI WRDS method. The format of
a static SAR table is like the following, where according to header,
antenna number could be either 2 or 4 and subband number could either
contain 6 GHz or not. And then, an entry of it describes a TX power
limitation with a given unit, which is also based on header, for the
antenna under the subband. Though things can be determined by header,
still not all combinations are allowed in content. For the recognizing
flow, there is a list of allowed combinations.

               +--------------------------------+
               |             header             |
               +--------------------------------+
               +---+---+---+---+---+------------+ +
             / |   |   |   |   |   | ...        | | \
               +---+---+---+---+---+------------+ |
      antenna  |   |   |   |   |   | ...        | |
      number   +---+---+---+---+---+------------+ |   content
               |...|   |   |   |   | ...        | |
               +---+---+---+---+---+------------+ |
             \ |...|   |   |   |   | ...        | | /
               +---+---+---+---+---+------------+ +
                \                              /
                          subband number

Following the format above, try to load a static SAR table and normalize
its content into SW structure. If any recognized is loaded, SW SAR flow
is then set up with source from ACPI.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.c | 342 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/acpi.h |  61 ++++
 drivers/net/wireless/realtek/rtw89/core.h |   2 +
 3 files changed, 404 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index 97b069062ec8..b937832b0f7a 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -365,8 +365,348 @@ enum rtw89_band rtw89_acpi_sar_subband_to_band(struct rtw89_dev *rtwdev,
 	}
 }
 
+static u8 rtw89_acpi_sar_rfpath_to_hp_antidx(enum rtw89_rf_path rfpath)
+{
+	switch (rfpath) {
+	default:
+	case RF_PATH_B:
+		return 0;
+	case RF_PATH_A:
+		return 1;
+	}
+}
+
+static u8 rtw89_acpi_sar_rfpath_to_rt_antidx(enum rtw89_rf_path rfpath)
+{
+	switch (rfpath) {
+	default:
+	case RF_PATH_A:
+		return 0;
+	case RF_PATH_B:
+		return 1;
+	}
+}
+
+static s16 rtw89_acpi_sar_normalize_hp_val(u8 v)
+{
+	static const u8 bias = 10;
+	static const u8 fct = 1;
+	u16 res;
+
+	BUILD_BUG_ON(fct > TXPWR_FACTOR_OF_RTW89_ACPI_SAR);
+
+	res = (bias << TXPWR_FACTOR_OF_RTW89_ACPI_SAR) +
+	      (v << (TXPWR_FACTOR_OF_RTW89_ACPI_SAR - fct));
+
+	return min_t(s32, res, MAX_VAL_OF_RTW89_ACPI_SAR);
+}
+
+static s16 rtw89_acpi_sar_normalize_rt_val(u8 v)
+{
+	static const u8 fct = 3;
+	u16 res;
+
+	BUILD_BUG_ON(fct > TXPWR_FACTOR_OF_RTW89_ACPI_SAR);
+
+	res = v << (TXPWR_FACTOR_OF_RTW89_ACPI_SAR - fct);
+
+	return min_t(s32, res, MAX_VAL_OF_RTW89_ACPI_SAR);
+}
+
+static
+void rtw89_acpi_sar_load_std_legacy(struct rtw89_dev *rtwdev,
+				    const struct rtw89_acpi_sar_recognition *rec,
+				    const void *content,
+				    struct rtw89_sar_entry_from_acpi *ent)
+{
+	const struct rtw89_acpi_sar_std_legacy *ptr = content;
+	enum rtw89_acpi_sar_subband subband;
+	enum rtw89_rf_path path;
+
+	for (subband = 0; subband < NUM_OF_RTW89_ACPI_SAR_SUBBAND; subband++) {
+		for (path = 0; path < NUM_OF_RTW89_ACPI_SAR_RF_PATH; path++) {
+			u8 antidx = rec->rfpath_to_antidx(path);
+
+			if (subband < RTW89_ACPI_SAR_SUBBAND_NR_LEGACY)
+				ent->v[subband][path] =
+					rec->normalize(ptr->v[antidx][subband]);
+			else
+				ent->v[subband][path] = MAX_VAL_OF_RTW89_ACPI_SAR;
+		}
+	}
+}
+
+static
+void rtw89_acpi_sar_load_std_has_6ghz(struct rtw89_dev *rtwdev,
+				      const struct rtw89_acpi_sar_recognition *rec,
+				      const void *content,
+				      struct rtw89_sar_entry_from_acpi *ent)
+{
+	const struct rtw89_acpi_sar_std_has_6ghz *ptr = content;
+	enum rtw89_acpi_sar_subband subband;
+	enum rtw89_rf_path path;
+
+	BUILD_BUG_ON(RTW89_ACPI_SAR_SUBBAND_NR_HAS_6GHZ != NUM_OF_RTW89_ACPI_SAR_SUBBAND);
+
+	for (subband = 0; subband < NUM_OF_RTW89_ACPI_SAR_SUBBAND; subband++) {
+		for (path = 0; path < NUM_OF_RTW89_ACPI_SAR_RF_PATH; path++) {
+			u8 antidx = rec->rfpath_to_antidx(path);
+
+			ent->v[subband][path] = rec->normalize(ptr->v[antidx][subband]);
+		}
+	}
+}
+
+static
+void rtw89_acpi_sar_load_sml_legacy(struct rtw89_dev *rtwdev,
+				    const struct rtw89_acpi_sar_recognition *rec,
+				    const void *content,
+				    struct rtw89_sar_entry_from_acpi *ent)
+{
+	const struct rtw89_acpi_sar_sml_legacy *ptr = content;
+	enum rtw89_acpi_sar_subband subband;
+	enum rtw89_rf_path path;
+
+	for (subband = 0; subband < NUM_OF_RTW89_ACPI_SAR_SUBBAND; subband++) {
+		for (path = 0; path < NUM_OF_RTW89_ACPI_SAR_RF_PATH; path++) {
+			u8 antidx = rec->rfpath_to_antidx(path);
+
+			if (subband < RTW89_ACPI_SAR_SUBBAND_NR_LEGACY)
+				ent->v[subband][path] =
+					rec->normalize(ptr->v[antidx][subband]);
+			else
+				ent->v[subband][path] = MAX_VAL_OF_RTW89_ACPI_SAR;
+		}
+	}
+}
+
+static
+void rtw89_acpi_sar_load_sml_has_6ghz(struct rtw89_dev *rtwdev,
+				      const struct rtw89_acpi_sar_recognition *rec,
+				      const void *content,
+				      struct rtw89_sar_entry_from_acpi *ent)
+{
+	const struct rtw89_acpi_sar_sml_has_6ghz *ptr = content;
+	enum rtw89_acpi_sar_subband subband;
+	enum rtw89_rf_path path;
+
+	BUILD_BUG_ON(RTW89_ACPI_SAR_SUBBAND_NR_HAS_6GHZ != NUM_OF_RTW89_ACPI_SAR_SUBBAND);
+
+	for (subband = 0; subband < NUM_OF_RTW89_ACPI_SAR_SUBBAND; subband++) {
+		for (path = 0; path < NUM_OF_RTW89_ACPI_SAR_RF_PATH; path++) {
+			u8 antidx = rec->rfpath_to_antidx(path);
+
+			ent->v[subband][path] = rec->normalize(ptr->v[antidx][subband]);
+		}
+	}
+}
+
+static const struct rtw89_acpi_sar_recognition rtw89_acpi_sar_recs[] = {
+	{
+		.id = {
+			.cid = RTW89_ACPI_SAR_CID_HP,
+			.rev = RTW89_ACPI_SAR_REV_LEGACY,
+			.size = RTW89_ACPI_SAR_SIZE_OF(std_legacy),
+		},
+
+		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_hp_antidx,
+		.normalize = rtw89_acpi_sar_normalize_hp_val,
+		.load = rtw89_acpi_sar_load_std_legacy,
+	},
+	{
+		.id = {
+			.cid = RTW89_ACPI_SAR_CID_HP,
+			.rev = RTW89_ACPI_SAR_REV_HAS_6GHZ,
+			.size = RTW89_ACPI_SAR_SIZE_OF(std_has_6ghz),
+		},
+
+		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_hp_antidx,
+		.normalize = rtw89_acpi_sar_normalize_hp_val,
+		.load = rtw89_acpi_sar_load_std_has_6ghz,
+	},
+	{
+		.id = {
+			.cid = RTW89_ACPI_SAR_CID_RT,
+			.rev = RTW89_ACPI_SAR_REV_LEGACY,
+			.size = RTW89_ACPI_SAR_SIZE_OF(std_legacy),
+		},
+
+		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_rt_antidx,
+		.normalize = rtw89_acpi_sar_normalize_rt_val,
+		.load = rtw89_acpi_sar_load_std_legacy,
+	},
+	{
+		.id = {
+			.cid = RTW89_ACPI_SAR_CID_RT,
+			.rev = RTW89_ACPI_SAR_REV_HAS_6GHZ,
+			.size = RTW89_ACPI_SAR_SIZE_OF(std_has_6ghz),
+		},
+
+		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_rt_antidx,
+		.normalize = rtw89_acpi_sar_normalize_rt_val,
+		.load = rtw89_acpi_sar_load_std_has_6ghz,
+	},
+	{
+		.id = {
+			.cid = RTW89_ACPI_SAR_CID_RT,
+			.rev = RTW89_ACPI_SAR_REV_LEGACY,
+			.size = RTW89_ACPI_SAR_SIZE_OF(sml_legacy),
+		},
+
+		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_rt_antidx,
+		.normalize = rtw89_acpi_sar_normalize_rt_val,
+		.load = rtw89_acpi_sar_load_sml_legacy,
+	},
+	{
+		.id = {
+			.cid = RTW89_ACPI_SAR_CID_RT,
+			.rev = RTW89_ACPI_SAR_REV_HAS_6GHZ,
+			.size = RTW89_ACPI_SAR_SIZE_OF(sml_has_6ghz),
+		},
+
+		.rfpath_to_antidx = rtw89_acpi_sar_rfpath_to_rt_antidx,
+		.normalize = rtw89_acpi_sar_normalize_rt_val,
+		.load = rtw89_acpi_sar_load_sml_has_6ghz,
+	},
+};
+
+struct rtw89_acpi_sar_rec_parm {
+	u32 pld_len;
+	u8 tbl_cnt;
+	u16 cid;
+	u8 rev;
+};
+
+static const struct rtw89_acpi_sar_recognition *
+rtw89_acpi_sar_recognize(struct rtw89_dev *rtwdev,
+			 const struct rtw89_acpi_sar_rec_parm *parm)
+{
+	const u32 tbl_len = parm->pld_len / parm->tbl_cnt;
+	const struct rtw89_acpi_sar_recognition *rec;
+	struct rtw89_acpi_sar_identifier id = {};
+
+	rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+		    "%s: cid %u, rev %u, tbl len %u, tbl cnt %u\n",
+		    __func__, parm->cid, parm->rev, tbl_len, parm->tbl_cnt);
+
+	if (unlikely(parm->pld_len % parm->tbl_cnt)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "invalid pld len %u\n",
+			    parm->pld_len);
+		return NULL;
+	}
+
+	if (unlikely(tbl_len > RTW89_ACPI_SAR_SIZE_MAX)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "invalid tbl len %u\n",
+			    tbl_len);
+		return NULL;
+	}
+
+	if (unlikely(parm->tbl_cnt > MAX_NUM_OF_RTW89_ACPI_SAR_TBL)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "invalid tbl cnt %u\n",
+			    parm->tbl_cnt);
+		return NULL;
+	}
+
+	switch (parm->cid) {
+	case RTW89_ACPI_SAR_CID_HP:
+	case RTW89_ACPI_SAR_CID_RT:
+		id.cid = parm->cid;
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "invalid cid 0x%x\n",
+			    parm->cid);
+		return NULL;
+	}
+
+	switch (parm->rev) {
+	case RTW89_ACPI_SAR_REV_LEGACY:
+	case RTW89_ACPI_SAR_REV_HAS_6GHZ:
+		id.rev = parm->rev;
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "invalid rev %u\n",
+			    parm->rev);
+		return NULL;
+	}
+
+	id.size = tbl_len;
+	for (unsigned int i = 0; i < ARRAY_SIZE(rtw89_acpi_sar_recs); i++) {
+		rec = &rtw89_acpi_sar_recs[i];
+		if (memcmp(&rec->id, &id, sizeof(rec->id)) == 0)
+			return rec;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_ACPI, "failed to recognize\n");
+	return NULL;
+}
+
+static const struct rtw89_acpi_sar_recognition *
+rtw89_acpi_evaluate_static_sar(struct rtw89_dev *rtwdev,
+			       struct rtw89_sar_cfg_acpi *cfg)
+{
+	const struct rtw89_acpi_sar_recognition *rec = NULL;
+	const struct rtw89_acpi_static_sar_hdr *hdr;
+	struct rtw89_sar_entry_from_acpi tmp = {};
+	struct rtw89_acpi_sar_rec_parm parm = {};
+	struct rtw89_sar_table_from_acpi *tbl;
+	const struct rtw89_acpi_data *data;
+	u32 len;
+
+	data = rtw89_acpi_evaluate_method(rtwdev, RTW89_ACPI_METHOD_STATIC_SAR);
+	if (!data)
+		return NULL;
+
+	rtw89_debug(rtwdev, RTW89_DBG_ACPI, "acpi load static sar\n");
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
+	parm.tbl_cnt = 1;
+	parm.pld_len = len - sizeof(*hdr);
+
+	rec = rtw89_acpi_sar_recognize(rtwdev, &parm);
+	if (!rec)
+		goto out;
+
+	rec->load(rtwdev, rec, hdr->content, &tmp);
+
+	tbl = &cfg->tables[0];
+	for (u8 regd = 0; regd < RTW89_REGD_NUM; regd++)
+		tbl->entries[regd] = tmp;
+
+	cfg->valid_num = 1;
+
+out:
+	kfree(data);
+	return rec;
+}
+
 int rtw89_acpi_evaluate_sar(struct rtw89_dev *rtwdev,
 			    struct rtw89_sar_cfg_acpi *cfg)
 {
-	return -ENOENT;
+	const struct rtw89_acpi_sar_recognition *rec;
+
+	rec = rtw89_acpi_evaluate_static_sar(rtwdev, cfg);
+	if (!rec)
+		return -ENOENT;
+
+	switch (rec->id.cid) {
+	case RTW89_ACPI_SAR_CID_HP:
+		cfg->downgrade_2tx = 3 << TXPWR_FACTOR_OF_RTW89_ACPI_SAR;
+		break;
+	case RTW89_ACPI_SAR_CID_RT:
+		cfg->downgrade_2tx = 0;
+		break;
+	default:
+		return -EFAULT;
+	}
+
+	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index 1f5d732c33c0..68a3433dd41e 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -75,6 +75,67 @@ struct rtw89_acpi_rtag_result {
 	u8 ant_gain_table[RTW89_ANT_GAIN_CHAIN_NUM][RTW89_ANT_GAIN_SUBBAND_NR];
 } __packed;
 
+enum rtw89_acpi_sar_cid {
+	RTW89_ACPI_SAR_CID_HP = 0x5048,
+	RTW89_ACPI_SAR_CID_RT = 0x5452,
+};
+
+enum rtw89_acpi_sar_rev {
+	RTW89_ACPI_SAR_REV_LEGACY = 1,
+	RTW89_ACPI_SAR_REV_HAS_6GHZ = 2,
+};
+
+#define RTW89_ACPI_SAR_ANT_NR_STD 4
+#define RTW89_ACPI_SAR_ANT_NR_SML 2
+
+#define RTW89_ACPI_METHOD_STATIC_SAR "WRDS"
+
+struct rtw89_acpi_sar_std_legacy {
+	u8 v[RTW89_ACPI_SAR_ANT_NR_STD][RTW89_ACPI_SAR_SUBBAND_NR_LEGACY];
+} __packed;
+
+struct rtw89_acpi_sar_std_has_6ghz {
+	u8 v[RTW89_ACPI_SAR_ANT_NR_STD][RTW89_ACPI_SAR_SUBBAND_NR_HAS_6GHZ];
+} __packed;
+
+struct rtw89_acpi_sar_sml_legacy {
+	u8 v[RTW89_ACPI_SAR_ANT_NR_SML][RTW89_ACPI_SAR_SUBBAND_NR_LEGACY];
+} __packed;
+
+struct rtw89_acpi_sar_sml_has_6ghz {
+	u8 v[RTW89_ACPI_SAR_ANT_NR_SML][RTW89_ACPI_SAR_SUBBAND_NR_HAS_6GHZ];
+} __packed;
+
+struct rtw89_acpi_static_sar_hdr {
+	__le16 cid;
+	u8 rev;
+	u8 content[];
+} __packed;
+
+struct rtw89_acpi_sar_identifier {
+	enum rtw89_acpi_sar_cid cid;
+	enum rtw89_acpi_sar_rev rev;
+	u8 size;
+};
+
+/* for rtw89_acpi_sar_identifier::size */
+#define RTW89_ACPI_SAR_SIZE_MAX U8_MAX
+#define RTW89_ACPI_SAR_SIZE_OF(type) \
+	(BUILD_BUG_ON_ZERO(sizeof(struct rtw89_acpi_sar_ ## type) > \
+			   RTW89_ACPI_SAR_SIZE_MAX) + \
+	 sizeof(struct rtw89_acpi_sar_ ## type))
+
+struct rtw89_acpi_sar_recognition {
+	struct rtw89_acpi_sar_identifier id;
+
+	u8 (*rfpath_to_antidx)(enum rtw89_rf_path rfpath);
+	s16 (*normalize)(u8 v);
+	void (*load)(struct rtw89_dev *rtwdev,
+		     const struct rtw89_acpi_sar_recognition *rec,
+		     const void *content,
+		     struct rtw89_sar_entry_from_acpi *ent);
+};
+
 enum rtw89_acpi_sar_subband rtw89_acpi_sar_get_subband(struct rtw89_dev *rtwdev,
 						       u32 center_freq);
 enum rtw89_band rtw89_acpi_sar_subband_to_band(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index de0734c44985..f36546505b0d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4645,6 +4645,8 @@ enum rtw89_acpi_sar_subband {
 	RTW89_ACPI_SAR_6GHZ_SUBBAND_8,   /* U-NII-8 */
 
 	NUM_OF_RTW89_ACPI_SAR_SUBBAND,
+	RTW89_ACPI_SAR_SUBBAND_NR_LEGACY = RTW89_ACPI_SAR_5GHZ_SUBBAND_3_4 + 1,
+	RTW89_ACPI_SAR_SUBBAND_NR_HAS_6GHZ = RTW89_ACPI_SAR_6GHZ_SUBBAND_8 + 1,
 };
 
 #define TXPWR_FACTOR_OF_RTW89_ACPI_SAR 3 /* unit: 0.125 dBm */
-- 
2.25.1


