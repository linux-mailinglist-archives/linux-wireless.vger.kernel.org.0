Return-Path: <linux-wireless+bounces-31797-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HAiKejBjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31797-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB0133365
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F3DC3014FD6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401B1DA62E;
	Fri, 13 Feb 2026 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MdPdWxhh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792626ED45
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963429; cv=none; b=Pyx63ACs9JAbPjXaddzjCnBtMNdniHca1fpokTX9yM8NFrz+JdgUsZD9qvTtwI8bzQmdSe9jV26HMbtSn2V0BB/H9kfqISqYM941XM/GodHLzYo1g/kQV5dOnttDv6Dm5w1OptP9anSYRMygC+eY0IdxFqac9ZfktsLWhGn8Llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963429; c=relaxed/simple;
	bh=MFXj09s0BoVTwTk+YBfEWCkw7L1pyKd3vT3EoCPr414=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZmpoqJK8AicPfIiEKqnVReKV6mIWFei7x2PB5T7omrfNUwqBP6zQnn2fT5KQo8kLCsA8IrL6AabK7EpwBuw/y2Au7G+BHhaYZq5aCQQfgD9vT8roiFyPluC5Nmlr8D3wZWxoxJBULOrq76ToGYXZAjT6Wgta2ThxbzlkvbleSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MdPdWxhh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6H2dtC1418849, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963422; bh=60f4kLod1QoPTfNJ1FMj1JrHQ0r6yXI68g6VWCbMY14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=MdPdWxhh5f1XyGnyYgk7qr+gpmS1sO84JjOYfLyIGTKN+T7fSFdyOG9dXfJxkZkCz
	 xMGqKk16o3g9UWX2x/AgyoenBOiq8e00E9a1j5xbpRE4GbK17GjAIV+s0s0FkmylKz
	 J7dREzTtVwplLTdgjR6xLssI9pbKYSFysxZTciIVQcg82f0PCplV7fo0pBHxgd9ju9
	 XjOISVhCc8dbyJ+OB1uADD9S8NDluFAVM+du8tDFx6GPHcu4tVJtxP+g873qEddmu/
	 LTqdFj93g4W2aDbr3XwnHwWuXZsJRbc+JWGdDBDkSnv2HVeAxPF9vhJs+DvF9P9MiC
	 IjCO405B3r6BQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6H2dtC1418849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:02 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:02 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:02 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/12] wifi: rtw89: add general way to generate module firmware string
Date: Fri, 13 Feb 2026 14:15:43 +0800
Message-ID: <20260213061552.29997-4-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31797-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1ADB0133365
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Module firmware string depends on max format of the firmware. When max
format is 0, the module firmware string will be like XYZ.bin. However,
when max format N > 0, the module firmware string will become XYZ-N.bin.
Originally, when one chip updated its max firmware format from 0 to 1,
the module firmware string also needed to be changed. However, did not
need to do for other cases, e.g. from 1 to 2. It's a bit inconvenient
to always remember that from 0 to 1 is a special case.

So, add a general macro to generate the corresponding module firmware
string based on max firmware format.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h      | 9 +++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 2 +-
 7 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d1f58bf953a9..1ad1fd2a1f6f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4152,6 +4152,15 @@ struct rtw89_reg_imr {
 	u32 set;
 };
 
+#define RTW89_MODULE_FWNAME_PLACEHOLDER_0 0,
+#define __RTW89_GEN_MODULE_FWNAME_FMT(placeholder_or_ignored, strfmt) \
+	__take_second_arg(placeholder_or_ignored, strfmt)
+#define RTW89_GEN_MODULE_FWNAME_FMT(maxfmt) \
+	__RTW89_GEN_MODULE_FWNAME_FMT(RTW89_MODULE_FWNAME_PLACEHOLDER_ ## maxfmt, \
+				      "-" __stringify(maxfmt))
+#define RTW89_GEN_MODULE_FWNAME(basename, maxformat) \
+	basename RTW89_GEN_MODULE_FWNAME_FMT(maxformat) ".bin"
+
 struct rtw89_fw_def {
 	const char *fw_basename;
 	u8 fw_format_max;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 89c759a2b5f4..0ea125ef21fa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -18,7 +18,7 @@
 #define RTW8851B_FW_FORMAT_MAX 0
 #define RTW8851B_FW_BASENAME "rtw89/rtw8851b_fw"
 #define RTW8851B_MODULE_FIRMWARE \
-	RTW8851B_FW_BASENAME ".bin"
+	RTW89_GEN_MODULE_FWNAME(RTW8851B_FW_BASENAME, RTW8851B_FW_FORMAT_MAX)
 
 static const struct rtw89_hfc_ch_cfg rtw8851b_hfc_chcfg_pcie[] = {
 	{5, 343, grp_0}, /* ACH 0 */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 32644c40ae28..0d5ec9755783 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -15,7 +15,7 @@
 #define RTW8852A_FW_FORMAT_MAX 0
 #define RTW8852A_FW_BASENAME "rtw89/rtw8852a_fw"
 #define RTW8852A_MODULE_FIRMWARE \
-	RTW8852A_FW_BASENAME ".bin"
+	RTW89_GEN_MODULE_FWNAME(RTW8852A_FW_BASENAME, RTW8852A_FW_FORMAT_MAX)
 
 static const struct rtw89_hfc_ch_cfg rtw8852a_hfc_chcfg_pcie[] = {
 	{128, 1896, grp_0}, /* ACH 0 */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index c2e14a9dfc73..b687ddaa839e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -16,7 +16,7 @@
 #define RTW8852B_FW_FORMAT_MAX 1
 #define RTW8852B_FW_BASENAME "rtw89/rtw8852b_fw"
 #define RTW8852B_MODULE_FIRMWARE \
-	RTW8852B_FW_BASENAME "-" __stringify(RTW8852B_FW_FORMAT_MAX) ".bin"
+	RTW89_GEN_MODULE_FWNAME(RTW8852B_FW_BASENAME, RTW8852B_FW_FORMAT_MAX)
 
 static const struct rtw89_hfc_ch_cfg rtw8852b_hfc_chcfg_pcie[] = {
 	{5, 341, grp_0}, /* ACH 0 */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 0acdf64395f0..c86b995a7cb1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -14,7 +14,7 @@
 #define RTW8852BT_FW_FORMAT_MAX 0
 #define RTW8852BT_FW_BASENAME "rtw89/rtw8852bt_fw"
 #define RTW8852BT_MODULE_FIRMWARE \
-	RTW8852BT_FW_BASENAME ".bin"
+	RTW89_GEN_MODULE_FWNAME(RTW8852BT_FW_BASENAME, RTW8852BT_FW_FORMAT_MAX)
 
 static const struct rtw89_hfc_ch_cfg rtw8852bt_hfc_chcfg_pcie[] = {
 	{16, 742, grp_0}, /* ACH 0 */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9f0dd6a3956f..e62a7288c8aa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -18,7 +18,7 @@
 #define RTW8852C_FW_FORMAT_MAX 2
 #define RTW8852C_FW_BASENAME "rtw89/rtw8852c_fw"
 #define RTW8852C_MODULE_FIRMWARE \
-	RTW8852C_FW_BASENAME "-" __stringify(RTW8852C_FW_FORMAT_MAX) ".bin"
+	RTW89_GEN_MODULE_FWNAME(RTW8852C_FW_BASENAME, RTW8852C_FW_FORMAT_MAX)
 
 static const struct rtw89_hfc_ch_cfg rtw8852c_hfc_chcfg_pcie[] = {
 	{13, 1614, grp_0}, /* ACH 0 */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 1c9db283cff9..36ef36110602 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -18,7 +18,7 @@
 #define RTW8922A_FW_FORMAT_MAX 4
 #define RTW8922A_FW_BASENAME "rtw89/rtw8922a_fw"
 #define RTW8922A_MODULE_FIRMWARE \
-	RTW8922A_FW_BASENAME "-" __stringify(RTW8922A_FW_FORMAT_MAX) ".bin"
+	RTW89_GEN_MODULE_FWNAME(RTW8922A_FW_BASENAME, RTW8922A_FW_FORMAT_MAX)
 
 #define HE_N_USER_MAX_8922A 4
 
-- 
2.25.1


