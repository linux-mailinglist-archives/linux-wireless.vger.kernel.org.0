Return-Path: <linux-wireless+bounces-20481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69762A668F5
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 06:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7D13B40E8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 05:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2AA1CAA95;
	Tue, 18 Mar 2025 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vb4A9hou"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1A1C5F30;
	Tue, 18 Mar 2025 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274517; cv=fail; b=q8u6tumFWnKqu9ex/3hV+Hi2T79YyeWtSBUNxRniUCFwGD7rEbSrCPtcI9gvg3zGBCZYhPfFXK+tXrhRWIboAVy5MLHNmV9WRu9o6cUhACireIjFxN7iC8mW5MXMkWFIbMsJ6JUAvXwuoFbZz0/AcjxK9CGepdQ+HZptt84L8Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274517; c=relaxed/simple;
	bh=4utiGzq7qVDgO/uyMSbaP4NrNnGOeZeb8EIcrSu5LWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5J8G6PCT2Yr81PxlVXTIZCF+DegtsbLN+bxjhLYWFMuH+mY0JkMAf+QiUJACXw5AmjPMLfyKRkYR9mRqGPDjfzLYBgyPW7gZJ7tgUX0Zq9Pg/2d6DhqVWnigEuuJbP1RHHc9h/3ECbkqfU0ktf9bpoknyb+IuGcbFxAYdiCs98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vb4A9hou; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZt+c2/Kqv0i2t8tISZAe0HiomH8NOuia41FGcMzv7OpJATM0FYwJ1gvG2wpGD9foUZkmSh2kFw73Pgqnmgy1xj+zzJ+0LpFhsUvq7tLIVYm8y6A+dLPQ3OjEGeT0B6QYVie2IeqAtOeFCNYzIBuFPnD8/fs1NCvTaC4IGZkLS00VerqbVz17K4IMHGLwTI7nhsI8ahqEL4izq9/ZUXtf6ENfm3777Trhr4H9nFWvYg47cFt9sc0HHC42qyioPbOiSjBeKGu0oePJLSSZjmP9pPuuqkb6uAEfMxzU02vKq55+u30msiTpQ2KL4ImlnVvbessICUyyFjH7gjZ6E6syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9YkaJ5aLHrdo2aibQ+lAsq1CbVsh1uieLut6Q9GSb0=;
 b=EkntUxG6gK6M46Oeo3pkmtBidw1MfJpX0Z5VEH/6EwAstCLwVmnx5ZxnINV9EsiSmUARLK+46iswCayJQjdlticSJ059J5zoIEKfcQv5eG7UKWKZrSdgQl2NCLPPgaCnyi43hFz3oxqG2E/kZLUSkHEQT0r+rceP2sI7I2b7d4s3pRhbuXGJvjmnHlse+nph/1VATxGMLi3g6sMnUQWceuUruzu6r5i0Boas6yjCMNRt/eJbpRyWKDVpA5DOgPy0OAzNtOSbL7refPkz132WQWtTlyvcSCE7RgziHw+RcxrduHVqF/9vFM4ahFPgij8rivW+WILHxMwTbxkIiKR4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9YkaJ5aLHrdo2aibQ+lAsq1CbVsh1uieLut6Q9GSb0=;
 b=Vb4A9houXKN9VcoZxSxtuaVRm+/lDy/oFXu/o0vck95oF0RODfjvMbqMl88HPl6Xp24FMNDPRYK+/rc+07EuLoMY9dz3dSAwS1LxSKxDyUX28qkMk183ki1snWgYA96g0P3Q9dT5HBZHBl/79fOdkwz8UVRaSe+65or4zO+mADxV3qH6VxPdClobjjLXMc5eUcADC7M7wsXXakghQ8KE2mF/jv5J63Cp2dsOTumtSS6GJUbhkceSnz4jFYPvaWYUohHZGWTWVn3+c5qXWHTbkdGB3Z2e/XbafsEF5Ju9vBRtVlEp0nWoH5cVS+TBB2YNA2vYQMy7OmqbepXToazQsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by AS8PR04MB8022.eurprd04.prod.outlook.com (2603:10a6:20b:28a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:08:33 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:08:33 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v4 1/2] wifi: mwifiex: Fix premature release of RF calibration data.
Date: Tue, 18 Mar 2025 13:07:38 +0800
Message-Id: <20250318050739.2239376-2-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::12) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|AS8PR04MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: fc44b462-ea9d-4b59-2bbb-08dd65daee4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MxUwUkk25r8/TzbCeCD3nKeOIDmULU2XtRDiFJTCmY88QwWj4kU1mXwY2j3A?=
 =?us-ascii?Q?05xSX+9NnYafD/K32X8LUtkPbJjhSFy3Z/b6P7+W58FxAo2HH72ER11oHYKR?=
 =?us-ascii?Q?hGPjIPHkz2cC8QDSzLyBq8eRSKtuVuoQbWk8pyFYGn1GyN2yASvqiVNEl/AD?=
 =?us-ascii?Q?5bzu5vnxFAZaAV5BsltmFVCCk+KTvL3C+kEbLfYsGhXtfkAsUQ3hJaCdlbsG?=
 =?us-ascii?Q?/SS11JTae3Pcr1RVxmc+NmyibJprlqYB92YmTBaje+Gtqbg0j8Owr1VBzQA9?=
 =?us-ascii?Q?2sMKcnHC4Xyr5zVjU0OcjvZT9RnYOaF/GPQkLEwEjrdLyZxBOq+yUK2dp9WX?=
 =?us-ascii?Q?QAaxXGXzrbypU4SLpBCa2odK+8wOTYNccyP/bTXBfkD0OE5w2tleLHnfJdhO?=
 =?us-ascii?Q?7Vlys1tvDCCzCS4wQAE0Vazs4F76+ikO9bvbXlFQwHZYXKcH+vIwZ6i0/jS5?=
 =?us-ascii?Q?L+Ds0LjDBL8USoROSpFwa4Z5y5/YexQNvVq7/CLyDGlqDekQFtiH1i2vKjtr?=
 =?us-ascii?Q?cPunMICGi6yD6/RBe2tDnkSHEQE3ylsQjcOwpSObzNjk/G5bHGeqE4aE+tfP?=
 =?us-ascii?Q?gYS58EvbQDmpPsWW7uzlu7UID8wPMKbjPUe/y3DU1Xu0QkMwcVlhmrgSJTiz?=
 =?us-ascii?Q?2Tvghv34AUR35yZzRKIl0TAAOdeJxwS3ftvGM/WbvlHlltCJg8r01JX++hw7?=
 =?us-ascii?Q?GaOTb5Pqxst0AJeFUm8NHTBZO9XaLbBYODt6PqO1F2HBHoxoJBNDsPcGCRqc?=
 =?us-ascii?Q?n3yuL2b8ZI2RYkS4OjWq09YjQuHGQ/7KMqXzh2PY1NSEPw6GVR9JqUY83ZsM?=
 =?us-ascii?Q?+QE7uiX7V7cyxlYuFpwYYxTad+SiZtfkvzeSYzSHL5Pq+aHPf0zUxIwLbfqv?=
 =?us-ascii?Q?BmeMrk5YiyYK+GC4u98hcBYId61JIHecr5ToTQgDKAZ38koFBMH5qpe3Ybmb?=
 =?us-ascii?Q?zQgObC6mwsQdvZZUwRanFJEJSSzR1UaXR2m9r9JfyBSv8IAMTNsJxNw1To1r?=
 =?us-ascii?Q?iYgq4sB/aC9hr/faD/CvX+Ne6WxaCKpjKRhEWqICcIwkJ0XhTxMPFswjIrW2?=
 =?us-ascii?Q?uexbkBQqwFiFzTUiNTG5QiZBYGtj7U0hoe/RkL4PAS+bZHTBs4sZnf12xJEx?=
 =?us-ascii?Q?5hvFbmf5jdaHZYRqmYsgAyHAExT9JHVE+9+rFijmrdDb2uH91Hh9VU4UM5jU?=
 =?us-ascii?Q?TNFJTJTOivMij4/Mji/k273qONKIu5ZV+Piu5AzBvSiPaMY0yHXRa85Ifgeo?=
 =?us-ascii?Q?k2m86lu3eJS7nn9WtM4Z2GXvmwIS0E2Ke/1XKj9gLYsO4NDQ4Eiijrcgu7hw?=
 =?us-ascii?Q?awg3oCETmjVb1J/8Gl/4u0eKsvgNNhbOpu6P7T3F0J/IOukewihc6vCNPGp0?=
 =?us-ascii?Q?HQNv6gVfOFPu0d8N1SsGp28LCffMbNoWbzmiWNXYtlKyY/L7BN77T3g7bhKt?=
 =?us-ascii?Q?p7mMZX33S8LMijmVmdL/YuqxjRM27AIj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nAAxJHvXRtdyFC7fDlGFXaPxS9sfouyL1P+wYS3vzYUA1/Q1WUPRmGjumARD?=
 =?us-ascii?Q?9lZ8ZGS11C1e9FmBVgJqaolEWldmAAQXt8DubQhhhAQ3AKWLX6Y+mKvYNkiZ?=
 =?us-ascii?Q?vsMfQ2QmPqUX4VrinngC7mjhwKMyoA6Xy90SHxi0S88sk3qseKx4aJ/iEhh2?=
 =?us-ascii?Q?z+R1bOdoRHFSKoCQO8QQrDENyz7KRyNQu0+rZLmM4fVIriL3KOqqcXD7CiAM?=
 =?us-ascii?Q?nsqUoFgUjlUE/ZEt89TVteTmjw4lAZtmh9IhzVng+cdUZemnwHSXrWx0Ihad?=
 =?us-ascii?Q?tNZfW1Znh7oJEBpJTfHCNlHi77m8tCNnpPtFhHveU5jKBJcmloIPx7r5D4If?=
 =?us-ascii?Q?5i288wko8LwHxEpnVZMtD0yviC/zZ0gE9ExuYAfdr9Nrz+Y+256YTiv/SKUR?=
 =?us-ascii?Q?W77kn/cnb6JCqy/Kmi9V6VwBsFylrlW+FE0BAF5/aXC14wY/1rGp/PDupPYN?=
 =?us-ascii?Q?yFyfAR00IrN0VZQ/i2jG98NssuVP5jsrA4qcNz8zd1XPGTL3lZyBPmBV3KW3?=
 =?us-ascii?Q?e9e5cWhTU0jVb0DtwV1UD0u6cAhXoVKCGqVf/ecbv+HXPoUVDFQGxM2jMCpR?=
 =?us-ascii?Q?qAkcVc1XiEOK2VaJQ45ROjaLC81u8p4A1rmpHvweC66a/0V6Py85r3u0CDoe?=
 =?us-ascii?Q?3igQX0It/G2PEkm99B/J1mTbnxjQ/IhJZJDUnXJlsW3WblirHPcaiJ/ijzbk?=
 =?us-ascii?Q?S61ZtMTlxcLgOmhpML/Ugd7CKp8zIsImsf8q5nYEwCc2M75baKGYCs9RQSWk?=
 =?us-ascii?Q?GMJUH4ovqHz3nIp5wiZbOhCM4PtB5DUjvEi7AqXoaOopy8itLtj1pVY7SzP+?=
 =?us-ascii?Q?RvQ8Kr/3ScQmh+PfoiJvWfdoQQ+C9Pq7yDL+P3JHcaMtMM1N4wz8zvUcE3Ws?=
 =?us-ascii?Q?0DnjaHMU+wT5GCr0pv1MFzjNN9vaTWIOjXR90vwI30jC79mx1RTHtzm0FWfb?=
 =?us-ascii?Q?etw0/P4iuCcky3xxtr8TC7IcDYDiclaHVkPoS7XbYW8ynhEh4qcn93TH1ODi?=
 =?us-ascii?Q?e2knC490tskehVo13p3oNA60HsiJUEwP+UN9Xb0l1/U18lqhGLoYX9gSHZCc?=
 =?us-ascii?Q?7LIaBVWFNci3GJSNQFLtIonqDaEjSWYoOaON1GK1985dia1UhhQO9lLszyt0?=
 =?us-ascii?Q?NvNslIBzppimGdY1fd/TvnMO4NVOHGr9vKhXnQ2honuQNB5IsXUjC9gMqjlN?=
 =?us-ascii?Q?GOqW+e6pR2l0CFnEf9QbJkBMNRFCP1LK6k4jv5Ky9z9Y8B+st4iCS9/SjVez?=
 =?us-ascii?Q?n0RpU7IbLMAmD19NH6ujS5ux9Tovk8eZuFnRXcKQaoIivjFhDeh/z7Dt/7zW?=
 =?us-ascii?Q?M0JGHYMbxNHHIrlfyCgGH0hItwdvJWd5cbabkizC5c4HcV5qBePrBJL2tFZM?=
 =?us-ascii?Q?PVcwkrTy+PVAa/IetXmMxdoIUnpDH0vPhhK12aeYY1+M3DISGX7+WBeEnE4n?=
 =?us-ascii?Q?gPXXj75Tenx0GJaEThcoDgHqw5NHQPHLPHnIGlh7xLkhcQC7s7IiAiy3ZXdL?=
 =?us-ascii?Q?xyQCiFeinBIh4bUSlB984QKVUCTpwE50eLB5m8hrt/UdjbPm5R2QgPHJJk9c?=
 =?us-ascii?Q?F0trnETSlDw98nDz2d4LfgWUII6DCKHI+H+Wj8qz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc44b462-ea9d-4b59-2bbb-08dd65daee4c
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 05:08:33.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjI1lKsrTC7yM+NEthok0ILvE4Z2s8zqUTpNEQo4vBCcYJz4Cvk9Bv/M1p11RA6tYosYVXogX9f8iicLBPppvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022

This patch resolves an issue where RF calibration data was being
released before the download process. Without this fix, the
external calibration data file would not be downloaded
at all.

Fixes: d39fbc88956e ("mwifiex: remove cfg_data construction")
Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c    | 4 ----
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 45eecb5f643b..b07cb302a00c 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -691,10 +691,6 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 
 	init_failed = true;
 done:
-	if (adapter->cal_data) {
-		release_firmware(adapter->cal_data);
-		adapter->cal_data = NULL;
-	}
 	if (adapter->firmware) {
 		release_firmware(adapter->firmware);
 		adapter->firmware = NULL;
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index e2800a831c8e..c0e6ce1a82fe 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -2293,9 +2293,13 @@ int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init)
 						"marvell,caldata");
 		}
 
-		if (adapter->cal_data)
+		if (adapter->cal_data) {
 			mwifiex_send_cmd(priv, HostCmd_CMD_CFG_DATA,
 					 HostCmd_ACT_GEN_SET, 0, NULL, true);
+			release_firmware(adapter->cal_data);
+			adapter->cal_data = NULL;
+		}
+
 
 		/* Read MAC address from HW */
 		ret = mwifiex_send_cmd(priv, HostCmd_CMD_GET_HW_SPEC,
-- 
2.34.1


