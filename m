Return-Path: <linux-wireless+bounces-31803-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMUFOwTCjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31803-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D213338F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 937BB3010609
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3011DA62E;
	Fri, 13 Feb 2026 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="klTVIgY9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761C1DE8BF
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963459; cv=none; b=DdSI95COGYnThDARvp7M+zO1z0e5P8/LAXit6WfPqR3mLsSFcniLjoYg++TO0FeVOvIn1VxVbPTV7rQIjb/pMgf8WAjKLq2WwmkTARPDBTbuoQMWCu6NrKksVz3mzvfS33D1N6f9VyJlaKdH4dPK38VA8ho+YCPRZ5i9s4PvZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963459; c=relaxed/simple;
	bh=8KKyC37ns5M/mbCApzGAnEvYNc6HR3Z4AXH2iNN9UbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhMpJ2N1gLILgKiMCGs2ZcdW3/VCj+pS1MRzOhCMDDyzzxrpgBL67LLAluLDWkbvc9OrctTM+zCIv+kz1NSWWL1bh4IibbjFbDQtbiqSasBBcy6C+l2LgjRYNj08d3mkbEE5cOW2zQ/2BbS+oyyBt1BXHMWeJ4ajVr5TbuuiD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=klTVIgY9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6HZUa81419677, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963455; bh=NyBCH/jJmDDTTYe7ksF7A1d6/hW6ykSgpF5aoPEdAOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=klTVIgY9zIOof2zykNzPseBvr7jy4cKjMHCjMVozeBcY4OHbpilkgjdP5mr2twYW7
	 C/GDHexOs428F4ff6DGd4E94Kj4kgDM23g0FUi4Fr/LkaN4CUwQPMzfQqftuu9zD0H
	 ZPi1/xw8VypPrkJ2im4BkLbHvBpxpbPTwvyS1Q2GEr4ncfvCne5KGfpezAekl3PoHO
	 3uaxoF8W8gCpYz+ttmUfmXSotYyH1FUHQdQeS3svogrfSt/bPWmvJZNNsmjnDOJGem
	 N/UxURVGe4QNtp1SbRKhwWFi7EqL5iFz0xx89IeLSO+XiokmBS3nUPWybjjkO8ONpD
	 G04OPUpETbOOQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6HZUa81419677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:35 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:35 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/12] wifi: rtw89: rfk: add hardware version to rtw89_fw_h2c_rf_pre_ntfy_mcc for new WiFi 7 firmware
Date: Fri, 13 Feb 2026 14:15:49 +0800
Message-ID: <20260213061552.29997-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213061552.29997-1-pkshih@realtek.com>
References: <20260213061552.29997-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31803-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 852D213338F
X-Rspamd-Action: no action

The RF calibration in firmware needs proper hardware version to select
corresponding logic, so add the field to H2C command accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 +
 drivers/net/wireless/realtek/rtw89/fw.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index bfa5cac24d88..67154e666ba2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7371,6 +7371,7 @@ int rtw89_fw_h2c_rf_pre_ntfy_mcc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	h2c = (struct rtw89_fw_h2c_rfk_pre_info_mcc *)skb->data;
 
 	h2c->aid = cpu_to_le32(hal->aid);
+	h2c->acv = hal->acv;
 
 done:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 80d260eb08cd..57e3b464c0a2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4881,6 +4881,8 @@ struct rtw89_fw_h2c_rfk_pre_info_mcc {
 	struct rtw89_fw_h2c_rfk_pre_info_mcc_v1 base;
 	u8 rsvd[2];
 	__le32 aid;
+	u8 acv;
+	u8 rsvd2[3];
 } __packed;
 
 struct rtw89_h2c_rf_tssi {
-- 
2.25.1


