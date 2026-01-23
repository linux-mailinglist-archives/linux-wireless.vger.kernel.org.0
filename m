Return-Path: <linux-wireless+bounces-31098-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI6jIdfRcmnKpgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31098-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D1B6F33C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 02:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02A3030120C1
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 01:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A20B2C236B;
	Fri, 23 Jan 2026 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Rv2jdCtn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1430322B9C
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132500; cv=none; b=fG97lu8YufxfCTdo5P8VMHgCHVKMNHKkCJvpsyIt0MToOW5G523QdJ2l3iNCAKZUAzftpObYeh/v6cwrtQgoRKDlwM2DRcbAVhUnxOwLMYe0uAg2wvzK0YHPWxHpViKzpPc4cH+V7tkKPnV06ldwxUY2YM93raZyn0+FODoy7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132500; c=relaxed/simple;
	bh=0DakfOy3kliINT0KP7ZjiD28ABVST7fvseB8JveMvCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcToTQH6tQ4H725332zXLv6Hf3H5kpD1Ifozo/8S1iizCecaEAB5j0txhAL3qsvGHOG86s+nKOVFQs4jDP+gOMqlJLAPWfmQD6Kif5Wj5fUJBWzsGiYAS76M6gUotmpQhFfFnzMK2LV4JGiPPn44tpAJlIQkpy69ng6h2N1IYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Rv2jdCtn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60N1fJGL12206875, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769132479; bh=2JwwinVVZiclJKsnoTE70F4HBuXkVoKGSoFoVYYsc+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Rv2jdCtnvjlXifMk1qK3YFkIbizYWc/rpkrY/Hmin82UsZ3r0mnP7cslsORb2LmPU
	 LzR2VADkDFwzuip1s83mA9+X8gukeq2Q6A/oeYjk0x5il+To1nJhFumjL7r1/ICGtH
	 IY/BVrO3o+6xYz5GIqZsovrpd8UpbLTOST+IC53uYqDUjAGaQoGwRs54W+dp36nS5k
	 7wB85BAcLIfkk8DFmYstuuApRnQDQwAAMYZvCzM/DmzkJr6L5XG5aUcsh2XRi0yDG3
	 wcjl3yRGTQbTmuhIrahWpMMwqLrmRMym/QKTLLhU++wij9hcpYHeQQOV/88V3sTZbX
	 gXWGIfarmjrKQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60N1fJGL12206875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 09:41:19 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 23 Jan 2026 09:41:17 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 09:41:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/11] wifi: rtw89: 8922a: configure FW version for SIM_SER_L0L1_BY_HALT_H2C
Date: Fri, 23 Jan 2026 09:39:54 +0800
Message-ID: <20260123013957.16418-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260123013957.16418-1-pkshih@realtek.com>
References: <20260123013957.16418-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31098-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0D1B6F33C
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

After FW version 0.35.97.0, 8922A supports SIM_SER_L0L1_BY_HALT_H2C
FW feature. It allows to simulate FW L0/L1 crash under PS mode.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4c50c0166d4f..9e88fd6d735a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -922,6 +922,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__DIS_FW_FEAT(RTL8922A, ge, 0, 35, 84, 0, WITH_RFK_PRE_NOTIFY, G),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 84, 0, RFK_PRE_NOTIFY_MCC_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 84, 0, ADDR_CAM_V0),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 97, 0, SIM_SER_L0L1_BY_HALT_H2C),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
-- 
2.25.1


