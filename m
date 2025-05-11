Return-Path: <linux-wireless+bounces-22834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD1AB2666
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 05:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AB818997AA
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 03:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689321898E9;
	Sun, 11 May 2025 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pKfUL1U3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AE16F288
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746935569; cv=none; b=j3ILKN6+SO5RngGUyYJnfBR8ZBo+MdFyrWHLHrAkg2rRFafi7Wx/T4JQ5ahSG2Rwe4WIl2nR+UK5xUUJ9Xex2H7gD3A+pRcot/zOZL7GIjNAUZ91N2aOd6+QabUmbVEe1DifruoOsgrzOYyQGqbc46mRxzcK73+sTMLzIPGNdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746935569; c=relaxed/simple;
	bh=Yw4z3/riwLR6+k74P4GWOVJhiBd68CrSvKPUs8zQ3Js=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOVC1dcHQPaS2P5LY+NtbJFSX5atb4/3vKJymiems4OjiW2elANn7vowKh9CKEqa6R37ZUnYiuFxmvQ3Oaj5DwgyRN08dD1NWYbsxOief+FLWb3wN9duKHjahGxCFqPpDvQZO//Yh210QGl8PoPjqoSCwbj7A6Av/6pZlw+Aqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pKfUL1U3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54B3qilQ73302899, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746935564; bh=Yw4z3/riwLR6+k74P4GWOVJhiBd68CrSvKPUs8zQ3Js=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pKfUL1U3Qygvh20gWazKxQTftDFBGApLYlsMmS68XooXul1SASoaKdjEza1Ah7AHD
	 hn10hkybg+VkVbdhR0DmmT43ewuXvLG5Tpp5ydbIoZx9wieUI5hHGrjhtd1QaEOlST
	 UWWW1O9CUCNAHkUXQZZh7SltPMOR9JwqrClunh6r5N7R3PfneKvVlx6QwdNCsedkEb
	 m6sy5VW6JLYNuPrX3qeuTRSjCydYCukUrMy/EbWlU1vHnQZnS8RhARBTedPW2L7hVu
	 7qB2GCsYGQmzoN0ywOWpBExZSyT9o1i3FXPoNSAi18cLBLYA193/hyeUJg7ICfY+TC
	 aTaX7Bj4WZMvQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54B3qilQ73302899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 11:52:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 May 2025 11:52:45 +0800
Received: from [127.0.1.1] (10.22.224.86) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 11 May
 2025 11:52:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/6] wifi: rtw89: mcc: introduce calculation of anchor pattern
Date: Sun, 11 May 2025 11:52:15 +0800
Message-ID: <20250511035217.10410-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250511035217.10410-1-pkshih@realtek.com>
References: <20250511035217.10410-1-pkshih@realtek.com>
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

In the cases that two MCC roles' TBTTs are too close or too far, original
MCC pattern calculation logic will lead to a result that both roles might
not cover its TBTT with sufficient time. Introduce a new calculation logic
called anchor pattern for these corner cases. It allows to choose one role
as anchor to put its TBTT in the middle of its duration directly. For now,
a P2P role has a higher priority to be chosen as an anchor. Then, if able,
another role might need to depend on courtesy mechanism to take time from
anchor.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 105 ++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index e09541ceb504..67acdcc1f535 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1185,6 +1185,107 @@ static int __rtw89_mcc_calc_pattern_strict(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static void __rtw89_mcc_fill_ptrn_anchor_ref(struct rtw89_dev *rtwdev,
+					     struct rtw89_mcc_pattern *ptrn,
+					     bool small_bcn_ofst)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u16 bcn_ofst = config->beacon_offset;
+	u16 ref_tob;
+	u16 ref_toa;
+
+	if (ref->limit.enable) {
+		ref_tob = ref->limit.max_tob;
+		ref_toa = ref->limit.max_toa;
+	} else {
+		ref_tob = ref->duration / 2;
+		ref_toa = ref->duration / 2;
+	}
+
+	if (small_bcn_ofst) {
+		ptrn->toa_ref = ref_toa;
+		ptrn->tob_ref = ref->duration - ptrn->toa_ref;
+	} else {
+		ptrn->tob_ref = ref_tob;
+		ptrn->toa_ref = ref->duration - ptrn->tob_ref;
+	}
+
+	ptrn->tob_aux = bcn_ofst - ptrn->toa_ref;
+	ptrn->toa_aux = aux->duration - ptrn->tob_aux;
+}
+
+static void __rtw89_mcc_fill_ptrn_anchor_aux(struct rtw89_dev *rtwdev,
+					     struct rtw89_mcc_pattern *ptrn,
+					     bool small_bcn_ofst)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u16 bcn_ofst = config->beacon_offset;
+	u16 aux_tob;
+	u16 aux_toa;
+
+	if (aux->limit.enable) {
+		aux_tob = aux->limit.max_tob;
+		aux_toa = aux->limit.max_toa;
+	} else {
+		aux_tob = aux->duration / 2;
+		aux_toa = aux->duration / 2;
+	}
+
+	if (small_bcn_ofst) {
+		ptrn->tob_aux = aux_tob;
+		ptrn->toa_aux = aux->duration - ptrn->tob_aux;
+	} else {
+		ptrn->toa_aux = aux_toa;
+		ptrn->tob_aux = aux->duration - ptrn->toa_aux;
+	}
+
+	ptrn->toa_ref = bcn_ofst - ptrn->tob_aux;
+	ptrn->tob_ref = ref->duration - ptrn->toa_ref;
+}
+
+static int __rtw89_mcc_calc_pattern_anchor(struct rtw89_dev *rtwdev,
+					   struct rtw89_mcc_pattern *ptrn,
+					   bool hdl_bt)
+{
+	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
+	struct rtw89_mcc_role *ref = &mcc->role_ref;
+	struct rtw89_mcc_role *aux = &mcc->role_aux;
+	struct rtw89_mcc_config *config = &mcc->config;
+	u16 mcc_intvl = config->mcc_interval;
+	u16 bcn_ofst = config->beacon_offset;
+	bool small_bcn_ofst;
+
+	if (bcn_ofst < RTW89_MCC_MIN_RX_BCN_TIME)
+		small_bcn_ofst = true;
+	else if (mcc_intvl - bcn_ofst < RTW89_MCC_MIN_RX_BCN_TIME)
+		small_bcn_ofst = false;
+	else
+		return -EPERM;
+
+	*ptrn = (typeof(*ptrn)){
+		.plan = hdl_bt ? RTW89_MCC_PLAN_TAIL_BT : RTW89_MCC_PLAN_NO_BT,
+	};
+
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
+		    "MCC calc ptrn_ac: plan %d, bcn_ofst %d\n",
+		    ptrn->plan, bcn_ofst);
+
+	if (ref->is_go || ref->is_gc)
+		__rtw89_mcc_fill_ptrn_anchor_ref(rtwdev, ptrn, small_bcn_ofst);
+	else if (aux->is_go || aux->is_gc)
+		__rtw89_mcc_fill_ptrn_anchor_aux(rtwdev, ptrn, small_bcn_ofst);
+	else
+		__rtw89_mcc_fill_ptrn_anchor_ref(rtwdev, ptrn, small_bcn_ofst);
+
+	return 0;
+}
+
 static int rtw89_mcc_calc_pattern(struct rtw89_dev *rtwdev, bool hdl_bt)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
@@ -1238,6 +1339,10 @@ static int rtw89_mcc_calc_pattern(struct rtw89_dev *rtwdev, bool hdl_bt)
 			goto done;
 	}
 
+	ret = __rtw89_mcc_calc_pattern_anchor(rtwdev, &ptrn, hdl_bt);
+	if (!ret)
+		goto done;
+
 	__rtw89_mcc_calc_pattern_loose(rtwdev, &ptrn, hdl_bt);
 
 done:
-- 
2.25.1


