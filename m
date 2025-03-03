Return-Path: <linux-wireless+bounces-19714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D6FA4C54F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 16:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A493AFCBB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DB213E89;
	Mon,  3 Mar 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z3zHj7fU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19011030.outbound.protection.outlook.com [52.103.64.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A062190468;
	Mon,  3 Mar 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015931; cv=fail; b=XVo9FqZPet9XJznG/otvyyry2rSJlzAwAQXghXBtM/8L/JQTnQkvd2oae8DhGorgR6xCqa5OgphwaVapR9w0Ip8pRdQcN4TrsKoQwb4oDxAgI35/F1jVDkOEc0DqYtaAe0ANA9k08AO4hHaMDljWobl640wGBsVdsqiyW/ao0ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015931; c=relaxed/simple;
	bh=hgBGjEsS2cLYzfDez1gTvjNSrMncENP3q4ww0hsy21U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z62LAUHxboEfF21dSk25eeWAzmn5qE7pZKNK6hXFj5GxCKWHhxr4a+qXiI1LFH9SJblbpGkU01VWt9UCzFW3bTsFmhB1+BCzyO+UocPNzdcHQJOzknkXC1YjnlTdTxEEClORjZvgEbeXHpiTlZOAyixeUuVPD4ut091lPHssNRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z3zHj7fU; arc=fail smtp.client-ip=52.103.64.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovh00ngawho1xpJXEXYXTxhGbBUVwYrSPq43VAO/PLfDJm5d0i8ajHS4ksVFk2mo2X1+SAObbE4razHruYmjODmED6jLu2A6d6jpqhxYGmSOL76t+wvDbH39UHbSuh8n6HfphQGsAqnHbIO+G4AaZ5GQsayvOnssKSMhKJz6yGRghs4lSLmW8DzpyRP+ZfsmiYb67/lmHPvZibMAxXaKqg1TT90hFqaR/tkgDcpTtgWvg+fNGa/v20NXYw28ZMIkfJPmFiCV6P8ZIWSvGDpMwsiGnUVPZlpkY7qAFShi2Ba60AmWOAJ+bhsjLrIh9GDEIDwkmj6c4mPshRBe7H/9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDoQ4KW/NKQnkDdQmWgUQbRcWdLgMaMP+ig+9/Nn+Bo=;
 b=Q8LbcxF+ZrfizKaiRwpVA4vMlwcI6s6COUqTUtn7qfVd7+4lI9H7zSlsZ5cuef3eMgNrldmXAru4v2dd7qkqeWqB6SFxZK3fdExJw/x04WdL9DFQk2NJoFdmb1PUxIUo8MIBmlvDu9tz7ubdsjtSwk5j6T1Hu2qvEirsg8O7GO4Nis9672g8uO7fH1W9ird5lqW8vwi/l/dl061PF4lDA4lE77Kz+M1dao449FpV3vo38lugGFWj/Ou4vrpBv9opFAescl7yeD+jsmdrEoL1Ch04R+XDA9X2C4Q3M9lqZ6ERyR9zvOGnd7tXHurenYLEodBhM+O+RpVViGLXyR4/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDoQ4KW/NKQnkDdQmWgUQbRcWdLgMaMP+ig+9/Nn+Bo=;
 b=Z3zHj7fUPOPFJvKSTaBVpbYUm4ubRdkIPjOx1xNQAYz4Yx3upX0Dr10p6W0E+9ZxlyiJ/5/oPbbE1r36hBhKlXGYtPaRfm5jJw3fWPc5Sf5jQ5Gh81AYAUFtAugMUZ6LU9yTBEbFp99gOPfGRIdlztSEAUABtgne0fnNOGAhFU9V7y5+iDnIn8ElaP10fVDmYgb+nKTlteMYbx7dqx/uhJHP7uT1kxzUO0LrvwPIAUZmU1GYjA9Y0YKcapc29E2hOV7Qijw0PAszU7SDgp0c0etTy5vFbm2+QIb/juJ220cggusGIIsiqd/h8C9yLIoweDI6EshL2GYQVsZKsYIu8A==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by SEYPR01MB5766.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 15:32:06 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:32:05 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: johannes@sipsolutions.net
Cc: jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 1/1] wifi: ath11k: move ATH11K_FIRMWARE_MODE_OFF to ath11k_firmware_mode
Date: Mon,  3 Mar 2025 23:31:56 +0800
Message-ID:
 <TYZPR01MB55561DF4543A0265B47A58CDC9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20250303153156.8619-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|SEYPR01MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 4534c8ad-6e12-48ac-591b-08dd5a688d8b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|15080799006|5062599005|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IqiPK0K3r4ao15WLmWacRhJ9Q+csDYLmhdaIsaoZ2PMnQzdAa2nfqIgWZVLP?=
 =?us-ascii?Q?jGvOIYTd5V+I8zFIoSzUNb+sq4RTqqF54vEiASd8FKGEwXVFbuU4U5I8Y9Zb?=
 =?us-ascii?Q?auRR9x4g3ab7jsQMUC4nVSRy2ybMYOCTx7udOWjfDHDZY1V7Lrsz9rlzpmQR?=
 =?us-ascii?Q?eeWWlC0UNs6HVUxwtWuvLHxIEcK0nZKlLgYkmU2K9sSfd5A6/NFxDWde1boi?=
 =?us-ascii?Q?ajaB1jWto9ivOOG8cX492ciC49vYN39J3TlpkfUfnIkTBscGUDdx6SU1/re2?=
 =?us-ascii?Q?XXYWFpNlnWBU/Qw16p0hDr8E9CPibabtbNPbQ6jZK1X9h33BhhvODxdf/RQp?=
 =?us-ascii?Q?5Sv3wO8QiXaj1V7KbQc888aQFZZPTC1joR7V4kQdj1BMTRAz2XQwlgIWxsc6?=
 =?us-ascii?Q?DslOfltrIeVv7QCNT2K66bft/pZJlaGks7F///xLdFioWm7oj8WvfU2O79y5?=
 =?us-ascii?Q?S7zdqAWvfQhKZzcEhqcEBjpK4W1HmPC2yj6ZNFJU9bVXED7q1q7mpMD4A4cd?=
 =?us-ascii?Q?wy2mIuTSOb9jdRCFFtZjF0UlMQyGszgWKAKdOvYaRTq1a/mCjn011LvWZYok?=
 =?us-ascii?Q?pzv2t7I/RRjQTvWpPpAtCCYZlKpuc5itsA0jEsekkolsIZc77xBax/Ih0t+o?=
 =?us-ascii?Q?nA+2+htHW0DHU/f17J1XSIpVFqPr4DVe1QM771j1EyRMhC/NGyZHQnEgM9EE?=
 =?us-ascii?Q?AQLcIpdmM9DIp+2tyodlCZWI0NSjvKkJkoLCQB/waDRRvIZe6nx3FH2YftII?=
 =?us-ascii?Q?8C5hU4JiWHcslYuu67YPv7jCHycqibionrtaud6QZDAPSvoTjvN5Zd0GIN2f?=
 =?us-ascii?Q?RnAk3qzOEj5VxmTnRoZAO2QzDOF4S8/tQjLqvX45juyZ3bcj+uF5mNKDdpsq?=
 =?us-ascii?Q?mu+31OmNW/2q2FOhN1JONGez9ysgopxnnO45NJCSmzRd83NxzL9gtPhjJ0KK?=
 =?us-ascii?Q?dey5TgjNRhBMffL9heyV8WykwNyt2VmGpZ+7VQLKs1kZ5gSyBObi3NkU5wus?=
 =?us-ascii?Q?Q+IyRhmCuM5pw24Tqsj63nCx8vOsjwGdWNvKAHToEE62SLn5YJ2GGgloKr4a?=
 =?us-ascii?Q?zTl4EzyPtcLqmTxR+JBBUu6QBB+0n8Sh+arRrbVuqW9V+Sr1GUc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6crJc9x1TW5fQ+NqyawOBBPj9VgaUO/+LPmHfvVk7F0gc1NWm0kFeJ0vEvm3?=
 =?us-ascii?Q?+5jg36o9ftsnLvYZPCA+UtBaI/cSSZGUnMFy8zwYg/d+gFAXJKelqmWxufJ6?=
 =?us-ascii?Q?S2B3sDJ8RTsW6Tdr4QWFiE76YBpwpMzZfZC/gOso33oV2P0t9XNf7Y0p1hnq?=
 =?us-ascii?Q?JLO+dfX2/uyIG3m261SOVWrl5MDArPyk/hTxMyhimVo+lSfl6NN8PhK7GliD?=
 =?us-ascii?Q?L0mJ6ttrUwJlJQk4w3+hbI/0UZlCjkXgKn/20rPeRiKvQ6kt/YLaqSvU1JnO?=
 =?us-ascii?Q?6tgklTmJ+DGb6s9Cxjyv1FZmQzYTVb2U9hrwMgjCM3a6E1GN8kQcyExRHACN?=
 =?us-ascii?Q?l8GGp2aGA9JkPVs0+mS/GSOM8BDnQCpm+PR7zLtgc0iGjnkyVOkJA5fGjpjG?=
 =?us-ascii?Q?GegG4DiMQB4EQBhikFVHjTKCXXRjhipXYHamgzXtdR7TFrtmGyrsOryJkqvv?=
 =?us-ascii?Q?E5ID6NkKEPbTH4VMsgTnXHRGc/6cQFpIqqJW5ysdOkS8hJMmw/BMOwnlEORL?=
 =?us-ascii?Q?So1ghIMEb+IG8hR569Q3HfK2uJ2Wj5ACxxN6EbUlW/jLHg9rQ7aP9+gyuROl?=
 =?us-ascii?Q?A8IEjSHU7KCatqOPB7+GCHdk8WymOVkYKPRrQtnnRzDMPxif4S5ZWeTNqMty?=
 =?us-ascii?Q?wNFm0QaDBtrT4pQvhkuqAJfaWfFOQ+E1MeoiBhFbMoCg84XLyA0SbHERqBPz?=
 =?us-ascii?Q?J+H3xKwvg84bWhjD67dLH022m3KbPSSmpLSuh/qD+nmIvSWDyUA/VPvLwBxM?=
 =?us-ascii?Q?YHzhq+FR4HWmQGeZJnA15kmGSyMONPj31bLo6wa8ybHOTXyBgn7GoB8Sd2i+?=
 =?us-ascii?Q?KXgjjhfLjCRxbzzNScwAyMVAg8ifNYcK1+JECJV+IKLGMkG4ei5L7C7XsKaR?=
 =?us-ascii?Q?f7N4x8ttG0i6cjWSITmKqGvqKtFbFMH9TPAz5Tw5tWP8eKb/dXWw59u0kqr6?=
 =?us-ascii?Q?io5Be4WBLGlvOwMUtTeCoM5fbsVlY1QL51rve2RVc3maEAgH+pPh79BGYI23?=
 =?us-ascii?Q?p7Lizlam6mFS9dtY4Qn1Hhkx+/Fx2C0Kzp/whf5cjx0f+RnaS7x2H9dKlbWX?=
 =?us-ascii?Q?7zj2+vegyTOJD2JsdKHL+BgdmXp2TBBv+rsHtq0DLVKgsxImWTN4B2zuMkFl?=
 =?us-ascii?Q?zyil1C96UIg1QYnWuwhaW45nBGEkeULPyrWzk8KWDHGD3o/n1jsA2RRaQPVr?=
 =?us-ascii?Q?v9VRjNgZkwJfBfQqwKhxLlQW+lAScMnGQA2w/y6hbrv5cg/u07qGNxjOQ0Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4534c8ad-6e12-48ac-591b-08dd5a688d8b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:32:05.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5766

Put it together with other modes.

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/net/wireless/ath/ath11k/core.h | 3 +++
 drivers/net/wireless/ath/ath11k/qmi.h  | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a9dc7fe7765a..bfa2e8b21b5f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -158,6 +158,9 @@ enum ath11k_firmware_mode {
 	/* factory tests etc */
 	ATH11K_FIRMWARE_MODE_FTM,
 
+	/* power off */
+	ATH11K_FIRMWARE_MODE_OFF = 4,
+
 	/* Cold boot calibration */
 	ATH11K_FIRMWARE_MODE_COLD_BOOT = 7,
 };
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 7e06d100af57..5e8fd22bb9a0 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -36,7 +36,6 @@
 #define QMI_WLFW_FW_INIT_DONE_IND_V01		0x0038
 
 #define QMI_WLANFW_MAX_DATA_SIZE_V01		6144
-#define ATH11K_FIRMWARE_MODE_OFF		4
 #define ATH11K_COLD_BOOT_FW_RESET_DELAY		(60 * HZ)
 
 #define ATH11K_QMI_DEVICE_BAR_SIZE		0x200000
-- 
2.40.1


