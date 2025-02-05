Return-Path: <linux-wireless+bounces-18480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D53DA28152
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 02:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDD03A4319
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 01:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB2D22A1E2;
	Wed,  5 Feb 2025 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VaLMnD2n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD002288F8;
	Wed,  5 Feb 2025 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718917; cv=fail; b=AXkR6pj5dWgxEuWiyeNiUkD4hGl7APMwNYrRiaYcyeWovCh43+kpj1/rf06tajN5c25tk8uMIlZKAZPpn+2zD1Gp7SRsELNiTfXo5SbEmo50lpFbkfjUNxA+ZPK3PNqPwGF13wIEDNK819YqQvRXFNl7mzao07xxvXmO1bFW8S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718917; c=relaxed/simple;
	bh=Fdx2imCppWR5jfb8O9DgjGOhldvR6gWJUptT/jGt+jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rt8K6/fT6+tcSQGX2fUE0EB6iMTOScljm/CeSomklgIMI3+uWkkEGQNazKVHMbP7lH2r4yzi8lKNRNw5elauN29CxCodcHs9W4AB0u2ZmELz/PV4hZY5QDawYl39HkjtwywCoMp9md9YNxUjIJL69qkGzewYgCrm7akalj3cqoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VaLMnD2n; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNyyv/efoL+Vt70CaFQEA6V/1EmYsLYYPvM617FiJgFXDiofi1uC1jODs3wGPiW/K2nw/8dl30WTTUhKWMHke2jeIwhretrZQBFvhvv/ouZ8hJIIqVMtxcLxIUtURk+b7wFGz95WVoZ6GA6jLoxYFCQqFC2DVfgYhTxe3sJlec80PvKckNx4Cz0U7yP9SDY1C1/Cay6oZf+/MqcAt2B4FgHJe09WKKAt8oRJO8ZOK11w7EBaZcEy960j3hxtYP3WmEazyFp9LkvrRNkrcibeDQKxbm/LlbRwxuVj8J428MTSubBm89lptGyunokFIM01Y1IDw2z1/WelNTEEl2wMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vLnoBGgEYqWy3ndxuKzmd15YfpkdBp/vfRCMAWel+8=;
 b=ajHCgfZbbydWfwk3mwOkAOjE6hkvGs3Etd8MhQtJ0/Z07lyibhxwf4knh0Ah0MCp8zE/Ta379OchfnWjcgf3g4U/ckBo8qAQ6skvfwPLEuqseUN+dzsHvhYKDgKlPDakdY0zeoWwMd+SWHpCRellr5yVMzxikjjRt9udef29QeNsuUjHLHH2KfIQvJ+0ej5bJsDfSjRDI3C+mVRs6riFqx4BvIniYtk+r8+gBONgo6hjnq6m1MoRe1grEvtKDt9gfbW+c0t5jg+IBmZC4dJHt9CF87RzltzSudkZ0nfo0IuVqRTScbaVbL0VCKme1EFZuPCpQ3YGCSQoMZp+3IMs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vLnoBGgEYqWy3ndxuKzmd15YfpkdBp/vfRCMAWel+8=;
 b=VaLMnD2npvnn0n4wXYmkTuIushRD+nao0/vZO8RfmsEVzBmnKVaZnhJDdAxFz194VEzDjZoJj+WnQdD6SIWWmlIfCJxS0ZBX+qPMfipr8to9pvr5PdBjCeJkop6amtwFAjpfOl2tZyQE7NO8mqSUbtIKhiybQLGJaURwqAPqCkdNnLZyqsAz7Zf38/4w327aCKpmAZXfgeF3Gh0vGjuj6useevxsyXe4rsZCjUZwMODWVAsqWpuHNYmt2GSrW5uwI99sOjN/nYhtLZbPio0tEs5sIREgJH98oR3nEcw0L5Fzbt1v+7wgwOgGGB/sDaYVnWY1xcHinRNR37cJE8ctbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by AM9PR04MB8841.eurprd04.prod.outlook.com (2603:10a6:20b:408::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 01:28:35 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 01:28:35 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v2 2/2] wifi: mwifiex: Fix HT40 bandwidth issue.
Date: Wed,  5 Feb 2025 09:28:43 +0800
Message-Id: <20250205012843.758714-2-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205012843.758714-1-jeff.chen_1@nxp.com>
References: <20250205012843.758714-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0086.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::39) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|AM9PR04MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 13157038-490b-42d7-6c75-08dd4584687e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZsCm3BqQT5QPu+JYl/52QKMqmDXNXzekqm7cKVcpcI9ZdKulVHKihw3+RsWu?=
 =?us-ascii?Q?Uf4pY9mg3f4JUJ4jC98J1c1YeT0SAgAoPX+THVSpWRCUswzKGdBF5i+SQ62u?=
 =?us-ascii?Q?KkIBzYcpf8cKQTU+I4SB6xFOxiDy3/d0fJsx3KmP/L04FSZxhNJN3LHjbcTS?=
 =?us-ascii?Q?V+PSbFfyK2E5Ia2SwyToPwMnCYsYQWjvLqgZoPRGEE2ls+XXE0BdiEtl705R?=
 =?us-ascii?Q?z7MBnOov0irrC5c+E5nlZAhrLXpJqXp2nXJI+Ln2vAuGUSBOjS/zAU2fZCXp?=
 =?us-ascii?Q?Htz5AYXpp0ChGtLiDHi98yPm5ltuWAXW9L3PYAQq/55/t/rpstQOyXoF6jIL?=
 =?us-ascii?Q?jkOUhUlbRiTChgoMxbGD8rZMuBU4yzgRPXu5YAuhU2jCxI1Z0elyM5AonqE3?=
 =?us-ascii?Q?kz5XnQbuzAgaZti3MlcXmGw9AXAOxxfpizw75iSEFAaYzcO6s7tG4r65DQG+?=
 =?us-ascii?Q?ONrRo3GkIZmRni8VNBH/aD/nkemXwVzu0ddWSngRAeX+5NZ8Y76PfTBiWRQC?=
 =?us-ascii?Q?A7xOBoZVrswv1Uv1vLpOW7hNV/2C/ZHfwSxq231Q0iVbl57GVaZYIzgfGgf3?=
 =?us-ascii?Q?bY9UHL14EoQ9QlzEbnQpOmi+BGPBTm8aWdEyMZxjXl4JkmjZo0dTg19BCV/v?=
 =?us-ascii?Q?fBgfkB1r7Cjy+lexI88EFBX9AK1EiywlKA07gWERAzcAAj7AVY6dfuEOXMbz?=
 =?us-ascii?Q?f0mlz7ZHgoMbbLnp1LgPb/WqOwL6uDE734rAsVe7wWm1Y2ugoSVpjmMJGljA?=
 =?us-ascii?Q?CmxtmObYsBLldk1H1oQKTC0vbmiospiEeO5YWaCVCslmwi0r4ihVwpistEYI?=
 =?us-ascii?Q?MXkoalNEnj8wevkCzkykaGvhbdSlqFg4f3mS4wq2RKsWnPKI9/edJY/1uTbo?=
 =?us-ascii?Q?YT2C5xdctzfWNeb2WFvWChwkSt4eUxQ/pynpVLb0kJKzsoLjprrYB1PsJ2wg?=
 =?us-ascii?Q?LPfc72e4XEjEEpIJjQAbcgwz4ATmhx4zSw7CA1Glsaicj1IqlB+Xmkwkot5v?=
 =?us-ascii?Q?OBTIrwfyjouliwxV1mX3C9vENa9oMOo/sdAjoAyydp89v18Sadeav7BdTOiJ?=
 =?us-ascii?Q?XT6iiqHTUNP+b6Zf2fIb9HqNFOcj/CWs7KW6YITIVzH1dV/Ig+JD8BfRg1Xq?=
 =?us-ascii?Q?lD0hOCHd6ZXVdPteZJFlT3EIRYI1kLq7EM2C/dkXiTmiYDVppNqnmfjQLf3c?=
 =?us-ascii?Q?UHC5XfZ68rhnsVpAbQOd5HISc0B7p4uUWlHv2lHTCbOailbv4maFTCktQH3I?=
 =?us-ascii?Q?33jdA4CiZWnkiHFagNpwL23zfMAtA9jRKSamyq3xw7NmZZZStbcyiwxiPRWp?=
 =?us-ascii?Q?v48cKgmRmCcRwPZyhqsMBdkRbbx3yDp4l9Ort+9Y6eoLPil1ri2wfvCHmn7m?=
 =?us-ascii?Q?wPWK8Ut0y8sAVL3VEYH+SSh8sjUumL7rTVVOo/SBn1PacDYfmkQThDGssqqi?=
 =?us-ascii?Q?ql6GkOEDBrhEnCbjSqTPdkvnoQjxz5fJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jV8fb6rM7gOQ7JNK3TsuoTH3fit9x+FRGI4G2s7h9N+njrZXHwOK7vQ87DRX?=
 =?us-ascii?Q?LhVeCb/xaWAXrQV7GecTQ7vn4/yO1eCGeFjfHT7NuqTDdsF6G7CIIPNoX1uH?=
 =?us-ascii?Q?O7B5qtpI2If4y0GQXHOXgXa9FE0BfkqnuG51tH6Ukb3s8ArV0aiJn7wjm9lo?=
 =?us-ascii?Q?EZXiq4d7mbKXiKJkkuucXc0f4ckiIkyGP3kB507SrKSn/b45t/iNYeDy8Pam?=
 =?us-ascii?Q?eIFX+/3YEj0O/lJKJeQ+726pJJhZui/kZ4pWd1ELLMBdHtR6EPB1eRZywrex?=
 =?us-ascii?Q?VyAVT8rA4TsCpMpUTvsydHI6rPes32JBB1gsH5pP+pa/oDlsTMXC/S+EAz+2?=
 =?us-ascii?Q?4EmRoBcAPb/H2NDLC+VD/2i1V5d3mOe0xdjBcEio+hhseEycpDlRKp9bG0pB?=
 =?us-ascii?Q?59qEpuX13xBXBCoWv1RcJVBvNfIIuEnBc7bUDZh/PEojr4zD9YsGYe3ZhSHD?=
 =?us-ascii?Q?Sub/ez9pDOjX7ugPTegDN9HfG4fzs9LCmHkCWHhVe9csGGTivUINekKc8n99?=
 =?us-ascii?Q?ijaIWfBs9kNGTNpfOvuO98Z1fP6CZo+k12T134IQ10FIMgIOg7hPD9O/wOHG?=
 =?us-ascii?Q?ZT/Nx3K3dAbfu0EHgGFOM/RCK2oaN5G4htBH7d7cDlyrod4YQAmfCEald0cP?=
 =?us-ascii?Q?VH0EvyEzz8L1dM4repnkHA9RpxtiNbKWnAJ1J4sEC0S20Uwy/R/GkgLvsf4s?=
 =?us-ascii?Q?o3apEln41UU6UHQf75O2fWZSI9wg8Md8ih3JAXpZlUZPxoiH58ALp752Ifmf?=
 =?us-ascii?Q?LHYXTl3rvkYGARBuvN06e1HXZZIciS0i2UDHBOKQJHQ7X5LBlCdUD/FAB6zw?=
 =?us-ascii?Q?L766JPE/y+u/6npifSHehg57dnIn6+ZgHNaivd6Nps9YNbJ2Mueh/DSOGLLY?=
 =?us-ascii?Q?Ifti49vqmbdZOIQRU47tgzR0+qzEph4hRyzxYe0bbaKVq4tT7nmMlEERkxy5?=
 =?us-ascii?Q?E96yRvlaKeVzsP08Ton3NYWyDwFjExQ7BT2xFw2U7VG4/mkpxyZcxv4Qhjh5?=
 =?us-ascii?Q?33tb4y6luQZPLRVehGb7iDF/kk3e+PQC2i8cgR582egDSl14iVkzp/IgSqq0?=
 =?us-ascii?Q?SCWzKFr/8KnL6Uo0/tx6ql7EJt13GXTaSAnysUZTRpAeIIs91/fpTgSYGoCc?=
 =?us-ascii?Q?U4r2Hyg3Dx9MS+312vtx8SwnKfQoz5nA8No8U0xZ8GY6sHZ9+gcAQs+7KLya?=
 =?us-ascii?Q?aAzRg17rtKsN2Bg1kh1CA2sR3CZxb8ZCmek3191dqxxIqNP4ehtx8FDiGoKQ?=
 =?us-ascii?Q?4VEFEUrZbtHy3e3bu+hYKkx/y63JhGUC7Hz7QI4FH1XnSwOY4qcmET9q4ka/?=
 =?us-ascii?Q?33d8GfTAsll0qKkQXYeKNecSA+KDMcSTYUTkaQFEa96JmvjtfzMBlY37vkyT?=
 =?us-ascii?Q?NmxfOpMj51NGWGipOa24PQgGgOFB9PitYdItp4D5QC/gm2/SsnyX+YqDstYb?=
 =?us-ascii?Q?pNjjnmGskBhO6CkQcI+YsFcEEX2CDlqbpFDXfFsGFjdisBICQz9MD8FmV4OL?=
 =?us-ascii?Q?fBv1eEqWJGPAlFGtNzu1A52uQgIddvS6n/4aUpjm2DyUWno1IgordAaa/8jW?=
 =?us-ascii?Q?aJMTcQg86BOEH1+wH2vnKINXdGiVV2IOVa8RXW9w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13157038-490b-42d7-6c75-08dd4584687e
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 01:28:35.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkem90Z37TQfS5MBbo6GxrArZODJGMs3uo3q9s3ZREDHArr+nCnGFjVDm71YMDoq20QTJGE0qQg9dhPs8wjVDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8841

This patch addresses an issue where, despite the AP supporting 40MHz
bandwidth, the connection was limited to 20MHz. Without this fix,
even if the access point supports 40MHz, the bandwidth after
connection remains at 20MHz. This issue is not a regression.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/11n.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 66f0f5377ac1..4ae0b4aaa09a 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -308,7 +308,7 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 	int ret_len = 0;
 	struct ieee80211_supported_band *sband;
 	struct ieee_types_header *hdr;
-	u8 radio_type;
+	u8 radio_type, secch_offset;
 
 	if (!buffer || !*buffer)
 		return ret_len;
@@ -401,13 +401,15 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 		chan_list->chan_scan_param[0].radio_type =
 			mwifiex_band_to_radio_type((u8) bss_desc->bss_band);
 
-		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
-		    bss_desc->bcn_ht_oper->ht_param &
-		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
-			SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
-					  radio_type,
-					  (bss_desc->bcn_ht_oper->ht_param &
-					  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
+		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
+			if (bss_desc->bcn_ht_oper->ht_param & IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
+				chan_list->chan_scan_param[0].radio_type |= (CHAN_BW_40MHZ << 2);
+				secch_offset = bss_desc->bcn_ht_oper->ht_param &
+				IEEE80211_HT_PARAM_CHA_SEC_OFFSET;
+				SET_SECONDARYCHAN(chan_list->chan_scan_param[0].radio_type,
+						  secch_offset);
+			}
+		}
 
 		*buffer += struct_size(chan_list, chan_scan_param, 1);
 		ret_len += struct_size(chan_list, chan_scan_param, 1);
-- 
2.34.1


