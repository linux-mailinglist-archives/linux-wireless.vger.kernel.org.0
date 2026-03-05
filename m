Return-Path: <linux-wireless+bounces-32534-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SUzVIQyYqWm7AgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32534-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:49:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E73213D5E
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 15:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 158E330741C9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7843B530F;
	Thu,  5 Mar 2026 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IhkcxU8Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25ED3A7F6D;
	Thu,  5 Mar 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721754; cv=fail; b=cpaJs3v2n34sPnmmuOAiUJTpQumsBuPX+p2Jg8cCsxPJMEf3gMRhADg2uePZnGjbSGFrGdWeP4Tz8alLRdYAms3q73F7fk+MdB8PP1qlU2ygPX6cbR6thVFnVrhwvQKWbwPrwA69VeC72RbNc9UoPYxnVRMd/Trzhs5XR5vDiwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721754; c=relaxed/simple;
	bh=QtmjBQg9OF3bZTbZJjEkwaDjrcq3XlUeG7bPrbEAgGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=skUnnB7O+cHQshnNDQ51FVzL5bCMOZKGZg5PBROsLuNaiv4MtKuyU8ZeDGlZ62aYjiGDMIIfxk53ZveQgWzYn7OLnGXw4tEyTPfuuD0+a0GeMmWhCcRuKj6QO1BUedah3eKNXR16Qfr4XdvU8qZNXkV4Zlx9SbC4g8djM4Xu4B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IhkcxU8Y; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKaqcVDtrO9iBpXxPsK0LLg1cPElXwu6jNy24l15NBoC0GeHLZJO6ywLisohhJwdAjPng+xqGyPdwVtIuOu/31Fal8i8rkB2CDEOn0qrxM28a2cevNaocouR45k1QzNr9JfPK7LTFKxKzKKk7ReMDHOHOmlcC790zzGOCFm2ZPyD45KWET9lIOehdVVCm6rZGzNrn4I4/KMddax6BMktAULi7OAorOY1JJnUcn8/+U5DRdBl6yGDHQZmGDTDyA1fbcy15mubYuRjWDffMnbBrOWevBENt5WcgIxXzqFey0akLZAdY/ov6NeiLL/9uAD/tQP/jNR+O/x4b0kdj8Gi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD1V/1GFGfEwcchTl2GkizB5FvKTZk+FLjeXXKuxbE4=;
 b=O/fkPAy1tNRAI7i0KJVKOZq5OWwa+6A1/SXEAacfuOqgobmpHEZKELHvb6lqEcqzd5YWcGgS+4FmenR7vNM9MBum7Y9ZfYnQV5TPHyZWHhJghwIKLHa5KBMeFXlU7lNagIwydJ8RgTd/kv8mBvS418mSWrSbXOC4c0u1NIjw0OrHMysKOUHhDJAON+3+WeATe0nBSiwkP9N93baWpE3Huhh5DY4V2Lti/IivW/uuu8EfStm9xwTcobY6sSqGBKneHCYoLYA8aT2h9oQgaVDmkmSZ10p0rjiRZlvAjG8KH7WTHz17Ghzc8H9jicAfX0+gJIvA4PyEB2JeOOZ2AM6kVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD1V/1GFGfEwcchTl2GkizB5FvKTZk+FLjeXXKuxbE4=;
 b=IhkcxU8YqmGUEt6bEj+XZWOa/vhss1vGF7TOnAFMcwnSyxpDdm36q2t7QTH4dpG7uzpTJOGxdEd68vzj+oVXqYX+jxcOEyHDYv5ae7w5FYcdHnikVR2dvConEFkz+ybWNwve11k+h0zzXADqDdxm2bgesJpangBaFFulQwRiWCMlPgjYpEXv/Y5B2SaOn8eNpk9HCB3kvryfOK/L9IXPTeUyLpKLLbmsjroEj7XQvyFUupc19Lt0JQrzu2Q0BHiSQIYfkxde5rtLKB8kkDYnN+r5yEyYWhIIN+TtKjZqltwkroEQYg7hbcO58BxHFLC6p7FfsO9s+MaPbAbgFqyIng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by AS4PR04MB9313.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:42:17 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 14:42:17 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	wyatt.hsu@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v10 11/21] wifi: nxpwifi: add firmware command and TLV definitions
Date: Thu,  5 Mar 2026 22:39:29 +0800
Message-Id: <20260305143939.3724868-12-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
References: <20260305143939.3724868-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::9) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|AS4PR04MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: b493173a-0e2b-423b-9a82-08de7ac56611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	cWlOEG5DX2625krXYMXHDGc2yhyGlFwM9+bkMC353U0Pw84t6/laWV2Cy956bsSiGho1sz3H99WFF85OlwzFysYNH+dy3POE/kZV2OQdAmUdVx/D0VNAjXk7vRwOyt1z+uKrahakvmQ+P48mtyvK43CwdKAs+3PPsgGhYaApKNGEQ+kkdZD7cVAsC/G4uZYVxOBEj70GpSW9iF1bWa+I6d9b2fFVEarrwDwwlSmjJZdXul6vzLDXTNQbEmbhFbvLa0pROIAsXK7zJQO1lBbwoEEf30euNNR8pnVLPtnsPiCpea3tS/DFEpYECOwvitXY6ivmlpArXt3ii59qP4TMHNHNHBuGSzE/zKcUcwd4RqQv5FWarw0ACkMA8x0ERD+hC0/c+v5Biu01xYkFgiPxWVOT6fj7u5KDY+z5HcROGySZQsVnAdWW+5ZEoYk8aM2W0I/ypHsg90OahcoO6qkBtAW4c8NFN42qqV2aeHH7CtYHaoHuAC4H6fr6ZyvcEEQ1bLdmdWKlwUopLRNoRZgj9biWFOL+lYCkB0vUkTpwi83QXU9Cm2k86zzGtsqKzF5SNolBEF+YA0b3Tm6fotqRUpkgrtE/VnNWnUjlc3gZ4vI7zYj+YXbvurqjDRQlyqUqpSo18Q51/9moTAcVRbTS9xew5NcwnuwJwIoMrVe40x6WqBSDd56VmpMKNP2wO8TXI03UsB4cHqV8METbhWG7fnwzlq9IvpM1Kjv90XtXzqGnfy3uFyRazZA5dfuxJN3PV0IdPw4QHWUK/KKX5aOA4xiVKq1oMo9IR8lMP9TMkJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FU+vbftrlzNwAvTla3ErXuYyrsKOjJ8bYsHll/ayTyev1cO7QtWdLo+Lb+BV?=
 =?us-ascii?Q?xPOfjzWS4BWA8bR4Mo1B7UwkwoiJ2x1TdV96JNhLFuCJMyOP2Uero4ZJvU80?=
 =?us-ascii?Q?HpppTC78zEPHW/BVc1p4rBcJeqX80V5wZivME1W+LcyvvjPNsxN6GhEtKGWC?=
 =?us-ascii?Q?vihlphJf1k85o9WGtKG0xGXgXT3FXFSDnumLNB1AuX0KoUSRwm0L8++jyJDl?=
 =?us-ascii?Q?8naAQGwBeO9/6prs3IisRdiWlvQfXcyKh1RwraGrk/lMwi17jmqCEwEK5aum?=
 =?us-ascii?Q?4veiM17G/uNb4Ceg22N32qpYDFrXRUFbvBLp6hAv0C6fO+8cugJN6fHlZwO9?=
 =?us-ascii?Q?PALZgthG6XybH2TFplr0maytYMeerAqpeMmSC2GgMqAX9loPqVdxF3hSZju0?=
 =?us-ascii?Q?JkNt8p/6MUcb6ROjbt0e59SE9wpvgGhMctCBwL6UVzQkqs7/EYSEHZU6KLep?=
 =?us-ascii?Q?3YuxjE9SvqKpvXigIPqsmAkDDGHeTn2qt60oBfrE1DFX/RvXeKVGVY09/a6B?=
 =?us-ascii?Q?rzgCXxeSBI/2qkDmwWWF2wp5CySrFrzkR0CO7bnEAo7RlX3RzNpIczJHkbAG?=
 =?us-ascii?Q?Nk3HVCR04xPHuorTRnNt3Gicnj52Xpf/jaIuI+7vND+0cL/o4TqfrSKHyfT4?=
 =?us-ascii?Q?/8r6q3jtCXfmPVsRggl0DYaVGKVZmO01vjKFzyKp0NjFS8hWPSnAC6RzBfKm?=
 =?us-ascii?Q?jaj7FeqX6CT17e5efzBpFzaW9UJz0yL6HWpmVpbycASos4bEVNMRVPe+YnwB?=
 =?us-ascii?Q?twCz965j/hjUSaO1AaLKIfuQDOGQmMxXT2bTSred93ZK9+dy1GVHP4KDQKES?=
 =?us-ascii?Q?GjAcdqsItg9rHEyH1njP1uGJH75UujwbBlTCMgzywYmD9eSETE9rCHFZsfEn?=
 =?us-ascii?Q?COhOUs0+ri2/24Ul1ecthIzMFowtR0+rPHUbUFih2C2uBNOJQR0I4BVqx16A?=
 =?us-ascii?Q?HEA5ObgwIrIISUsC2SPtmkNDx1EkxpnBdR0AGv7EF1xMKCcd0QcSSA1myG4a?=
 =?us-ascii?Q?gG2gWT5ICd4cwjujoXmQSGrFI1rwa7JO1jPLWV0i2TNbHk+eqelGPIyeiAAv?=
 =?us-ascii?Q?gntBjG2Ge3GiB60wSzJ/0ID4Ro5Cj8I1Iglqb7qeQpBG4/pLXALSQ/fL0EHP?=
 =?us-ascii?Q?7u+S3ixkQb/1if1Lw0JYSzn1exExI+a0ivYL3wh07hAetOjk1k2cxqZBCZvJ?=
 =?us-ascii?Q?9t+oFP8JQ9sc354u2G/cy5JJXQuliL0KgOmvU8iEuC8s4jRc5IjEDn5CRqWC?=
 =?us-ascii?Q?M2qvWfInLdjB4YvvktCNHEiPe7HiH2WqDkzP4Tadr/GtuKnbuuanT4XvSU+n?=
 =?us-ascii?Q?mm8aCAnoatZBs7VVbjB2G4b4McKUhEt/eqc/DmoRMHbHXR6x3ZEAfy29QGBn?=
 =?us-ascii?Q?75z7JwjY51mhS7oQ7+GYJqi/AjzpwcW8HvjHKV8aDmryyvKgf8J4YbebU954?=
 =?us-ascii?Q?kaRPLAUf4jYNBO+HaAgKt6JAtFCynisQ5bqFETzHs2HIIYjUz4Lpfx2Xdks2?=
 =?us-ascii?Q?uC7lGkZp3AS+0jgP098v51NqOA2naMJ/cDq0FNdSTn1VSOUKaaq+1/5H8uz2?=
 =?us-ascii?Q?QRE9Uh5ZtQha5GvJp7aDtKP8A8Co5FuJVY11REDyclpEyb2pKmACbtbBj29A?=
 =?us-ascii?Q?wphbwF8I3NDQ3uB4P06dOoYYNUzk0DuUMtGOrf86BCGqVxY2XEydw3Pdwc7C?=
 =?us-ascii?Q?Jb4I7h1Ny/AjfZKontkUSPG2vkCxPEOZwmc7QDjOvQWsPEkkdys8tnVe2/ZS?=
 =?us-ascii?Q?WiRWd3A19A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b493173a-0e2b-423b-9a82-08de7ac56611
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:42:17.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMRCytjok017OKagZVtWIKk423DjBAclT+4q1UvZx7ZcY0kjyGx9IonS+k9XbAam0Zw6l8P871AfH7djW2CdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9313
X-Rspamd-Queue-Id: 86E73213D5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32534-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.chen_1@nxp.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add fw.h to define host command structures, NXP specific TLV types, and
related constants used for communication with the firmware.

Define host command IDs, result codes, TLV type values, and data
structures for command payloads and firmware events. Provide macros for
advertised firmware capabilities and feature flags.

Provide the foundational definitions for firmware interaction in the
nxpwifi driver.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/fw.h | 2373 +++++++++++++++++++++++++
 1 file changed, 2373 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/fw.h b/drivers/net/wireless/nxp/nxpwifi/fw.h
new file mode 100644
index 000000000000..0e5eeb115847
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/fw.h
@@ -0,0 +1,2373 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * nxpwifi: Firmware-specific macros and structures
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_FW_H_
+#define _NXPWIFI_FW_H_
+
+#include <linux/if_ether.h>
+
+#define INTF_HEADER_LEN     4
+
+struct rfc_1042_hdr {
+	u8 llc_dsap;
+	u8 llc_ssap;
+	u8 llc_ctrl;
+	u8 snap_oui[3];
+	__be16 snap_type;
+} __packed;
+
+struct rx_packet_hdr {
+	struct ethhdr eth803_hdr;
+	struct rfc_1042_hdr rfc1042_hdr;
+} __packed;
+
+struct tx_packet_hdr {
+	struct ethhdr eth803_hdr;
+	struct rfc_1042_hdr rfc1042_hdr;
+} __packed;
+
+struct nxpwifi_fw_header {
+	__le32 dnld_cmd;
+	__le32 base_addr;
+	__le32 data_length;
+	__le32 crc;
+} __packed;
+
+struct nxpwifi_fw_data {
+	struct nxpwifi_fw_header header;
+	__le32 seq_num;
+	u8 data[];
+} __packed;
+
+struct nxpwifi_fw_dump_header {
+	__le16 seq_num;
+	__le16 reserved;
+	__le16 type;
+	__le16 len;
+} __packed;
+
+#define FW_DUMP_INFO_ENDED 0x0002
+
+#define NXPWIFI_FW_DNLD_CMD_1 0x1
+#define NXPWIFI_FW_DNLD_CMD_5 0x5
+#define NXPWIFI_FW_DNLD_CMD_6 0x6
+#define NXPWIFI_FW_DNLD_CMD_7 0x7
+
+#define B_SUPPORTED_RATES               5
+#define G_SUPPORTED_RATES               9
+#define BG_SUPPORTED_RATES              13
+#define A_SUPPORTED_RATES               9
+#define HOSTCMD_SUPPORTED_RATES         14
+#define N_SUPPORTED_RATES               3
+#define ALL_802_11_BANDS \
+	(BAND_A | BAND_B | BAND_G | BAND_GN | BAND_AN | BAND_AAC | BAND_GAC)
+#define FW_MULTI_BANDS_SUPPORT \
+	(BIT(8) | BIT(9) | BIT(10) | BIT(11) | BIT(12) | BIT(13))
+#define IS_SUPPORT_MULTI_BANDS(adapter) \
+	((adapter)->fw_cap_info & FW_MULTI_BANDS_SUPPORT)
+
+/*
+ * Map fw_cap_info for default bands: shift 11ac flags so bits
+ * 11:GN, 12:AN, 13:GAC, 14:AAC match driver layout after >>8.
+ */
+#define GET_FW_DEFAULT_BANDS(adapter) ({\
+	typeof(adapter) (_adapter) = adapter; \
+	(((((_adapter->fw_cap_info & 0x3000) << 1) | \
+	   (_adapter->fw_cap_info & ~0xF000)) \
+	  >> 8) & \
+	 ALL_802_11_BANDS); \
+	})
+
+#define HOST_WEP_KEY_INDEX_MASK 0x3fff
+
+#define KEY_INFO_ENABLED        0x01
+enum KEY_TYPE_ID {
+	KEY_TYPE_ID_WEP = 0,
+	KEY_TYPE_ID_TKIP,
+	KEY_TYPE_ID_AES,
+	KEY_TYPE_ID_WAPI,
+	KEY_TYPE_ID_AES_CMAC,
+	KEY_TYPE_ID_GCMP,
+	KEY_TYPE_ID_GCMP_256,
+	KEY_TYPE_ID_CCMP_256,
+	KEY_TYPE_ID_BIP_GMAC_128,
+	KEY_TYPE_ID_BIP_GMAC_256,
+};
+
+#define WPA_PN_SIZE		8
+#define KEY_PARAMS_FIXED_LEN	10
+#define KEY_INDEX_MASK		0xf
+#define KEY_API_VER_MAJOR_V2	2
+
+#define KEY_MCAST	BIT(0)
+#define KEY_UNICAST	BIT(1)
+#define KEY_ENABLED	BIT(2)
+#define KEY_DEFAULT	BIT(3)
+#define KEY_TX_KEY	BIT(4)
+#define KEY_RX_KEY	BIT(5)
+#define KEY_IGTK	BIT(10)
+
+#define MAX_POLL_TRIES			10000
+#define MAX_FIRMWARE_POLL_TRIES		300
+
+#define FIRMWARE_READY_SDIO		0xfedc
+#define FIRMWARE_READY_PCIE		0xfedcba00
+
+#define NXPWIFI_COEX_MODE_TIMESHARE	0x01
+#define NXPWIFI_COEX_MODE_SPATIAL	0x82
+
+enum nxpwifi_usb_ep {
+	NXPWIFI_USB_EP_CMD_EVENT = 1,
+	NXPWIFI_USB_EP_DATA = 2,
+	NXPWIFI_USB_EP_DATA_CH2 = 3,
+};
+
+enum NXPWIFI_802_11_PRIVACY_FILTER {
+	NXPWIFI_802_11_PRIV_FILTER_ACCEPT_ALL,
+	NXPWIFI_802_11_PRIV_FILTER_8021X_WEP
+};
+
+#define CAL_SNR(RSSI, NF)           ((s16)((s16)(RSSI) - (s16)(NF)))
+#define CAL_RSSI(SNR, NF)           ((s16)((s16)(SNR) + (s16)(NF)))
+
+#define UAP_BSS_PARAMS_I            0
+#define UAP_CUSTOM_IE_I             1
+#define NXPWIFI_AUTO_IDX_MASK       0xffff
+#define NXPWIFI_DELETE_MASK         0x0000
+#define MGMT_MASK_ASSOC_REQ         0x01
+#define MGMT_MASK_REASSOC_REQ       0x04
+#define MGMT_MASK_ASSOC_RESP        0x02
+#define MGMT_MASK_REASSOC_RESP      0x08
+#define MGMT_MASK_PROBE_REQ         0x10
+#define MGMT_MASK_PROBE_RESP        0x20
+#define MGMT_MASK_BEACON            0x100
+
+#define TLV_TYPE_UAP_SSID           0x0000
+#define TLV_TYPE_UAP_RATES          0x0001
+#define TLV_TYPE_PWR_CONSTRAINT     0x0020
+#define TLV_TYPE_HT_CAPABILITY      0x002d
+#define TLV_TYPE_EXTENSION_ID       0x00ff
+
+#define PROPRIETARY_TLV_BASE_ID     0x0100
+#define TLV_TYPE_KEY_MATERIAL       (PROPRIETARY_TLV_BASE_ID + 0)
+#define TLV_TYPE_CHANLIST           (PROPRIETARY_TLV_BASE_ID + 1)
+#define TLV_TYPE_NUMPROBES          (PROPRIETARY_TLV_BASE_ID + 2)
+#define TLV_TYPE_RSSI_LOW           (PROPRIETARY_TLV_BASE_ID + 4)
+#define TLV_TYPE_PASSTHROUGH        (PROPRIETARY_TLV_BASE_ID + 10)
+#define TLV_TYPE_WMMQSTATUS         (PROPRIETARY_TLV_BASE_ID + 16)
+#define TLV_TYPE_WILDCARDSSID       (PROPRIETARY_TLV_BASE_ID + 18)
+#define TLV_TYPE_TSFTIMESTAMP       (PROPRIETARY_TLV_BASE_ID + 19)
+#define TLV_TYPE_RSSI_HIGH          (PROPRIETARY_TLV_BASE_ID + 22)
+#define TLV_TYPE_BGSCAN_START_LATER (PROPRIETARY_TLV_BASE_ID + 30)
+#define TLV_TYPE_AUTH_TYPE          (PROPRIETARY_TLV_BASE_ID + 31)
+#define TLV_TYPE_STA_MAC_ADDR       (PROPRIETARY_TLV_BASE_ID + 32)
+#define TLV_TYPE_BSSID              (PROPRIETARY_TLV_BASE_ID + 35)
+#define TLV_TYPE_CHANNELBANDLIST    (PROPRIETARY_TLV_BASE_ID + 42)
+#define TLV_TYPE_UAP_MAC_ADDRESS    (PROPRIETARY_TLV_BASE_ID + 43)
+#define TLV_TYPE_UAP_BEACON_PERIOD  (PROPRIETARY_TLV_BASE_ID + 44)
+#define TLV_TYPE_UAP_DTIM_PERIOD    (PROPRIETARY_TLV_BASE_ID + 45)
+#define TLV_TYPE_UAP_BCAST_SSID     (PROPRIETARY_TLV_BASE_ID + 48)
+#define TLV_TYPE_UAP_PREAMBLE_CTL   (PROPRIETARY_TLV_BASE_ID + 49)
+#define TLV_TYPE_UAP_RTS_THRESHOLD  (PROPRIETARY_TLV_BASE_ID + 51)
+#define TLV_TYPE_UAP_AO_TIMER       (PROPRIETARY_TLV_BASE_ID + 57)
+#define TLV_TYPE_UAP_WEP_KEY        (PROPRIETARY_TLV_BASE_ID + 59)
+#define TLV_TYPE_UAP_WPA_PASSPHRASE (PROPRIETARY_TLV_BASE_ID + 60)
+#define TLV_TYPE_UAP_ENCRY_PROTOCOL (PROPRIETARY_TLV_BASE_ID + 64)
+#define TLV_TYPE_UAP_AKMP           (PROPRIETARY_TLV_BASE_ID + 65)
+#define TLV_TYPE_UAP_FRAG_THRESHOLD (PROPRIETARY_TLV_BASE_ID + 70)
+#define TLV_TYPE_RATE_DROP_CONTROL  (PROPRIETARY_TLV_BASE_ID + 82)
+#define TLV_TYPE_RATE_SCOPE         (PROPRIETARY_TLV_BASE_ID + 83)
+#define TLV_TYPE_POWER_GROUP        (PROPRIETARY_TLV_BASE_ID + 84)
+#define TLV_TYPE_BSS_SCAN_RSP       (PROPRIETARY_TLV_BASE_ID + 86)
+#define TLV_TYPE_BSS_SCAN_INFO      (PROPRIETARY_TLV_BASE_ID + 87)
+#define TLV_TYPE_CHANRPT_11H_BASIC  (PROPRIETARY_TLV_BASE_ID + 91)
+#define TLV_TYPE_UAP_RETRY_LIMIT    (PROPRIETARY_TLV_BASE_ID + 93)
+#define TLV_TYPE_ROBUST_COEX        (PROPRIETARY_TLV_BASE_ID + 96)
+#define TLV_TYPE_UAP_MGMT_FRAME     (PROPRIETARY_TLV_BASE_ID + 104)
+#define TLV_TYPE_MGMT_IE            (PROPRIETARY_TLV_BASE_ID + 105)
+#define TLV_TYPE_AUTO_DS_PARAM      (PROPRIETARY_TLV_BASE_ID + 113)
+#define TLV_TYPE_PS_PARAM           (PROPRIETARY_TLV_BASE_ID + 114)
+#define TLV_TYPE_UAP_PS_AO_TIMER    (PROPRIETARY_TLV_BASE_ID + 123)
+#define TLV_TYPE_PWK_CIPHER         (PROPRIETARY_TLV_BASE_ID + 145)
+#define TLV_TYPE_GWK_CIPHER         (PROPRIETARY_TLV_BASE_ID + 146)
+#define TLV_TYPE_TX_PAUSE           (PROPRIETARY_TLV_BASE_ID + 148)
+#define TLV_TYPE_RXBA_SYNC          (PROPRIETARY_TLV_BASE_ID + 153)
+#define TLV_TYPE_COALESCE_RULE      (PROPRIETARY_TLV_BASE_ID + 154)
+#define TLV_TYPE_KEY_PARAM_V2       (PROPRIETARY_TLV_BASE_ID + 156)
+#define TLV_TYPE_REGION_DOMAIN_CODE (PROPRIETARY_TLV_BASE_ID + 171)
+#define TLV_TYPE_REPEAT_COUNT       (PROPRIETARY_TLV_BASE_ID + 176)
+#define TLV_TYPE_PS_PARAMS_IN_HS    (PROPRIETARY_TLV_BASE_ID + 181)
+#define TLV_TYPE_MULTI_CHAN_INFO    (PROPRIETARY_TLV_BASE_ID + 183)
+#define TLV_TYPE_MC_GROUP_INFO      (PROPRIETARY_TLV_BASE_ID + 184)
+#define TLV_TYPE_SCAN_CHANNEL_GAP   (PROPRIETARY_TLV_BASE_ID + 197)
+#define TLV_TYPE_API_REV            (PROPRIETARY_TLV_BASE_ID + 199)
+#define TLV_TYPE_CHANNEL_STATS      (PROPRIETARY_TLV_BASE_ID + 198)
+#define TLV_BTCOEX_WL_AGGR_WINSIZE  (PROPRIETARY_TLV_BASE_ID + 202)
+#define TLV_BTCOEX_WL_SCANTIME      (PROPRIETARY_TLV_BASE_ID + 203)
+#define TLV_TYPE_BSS_MODE           (PROPRIETARY_TLV_BASE_ID + 206)
+#define TLV_TYPE_RANDOM_MAC         (PROPRIETARY_TLV_BASE_ID + 236)
+#define TLV_TYPE_CHAN_ATTR_CFG      (PROPRIETARY_TLV_BASE_ID + 237)
+#define TLV_TYPE_MAX_CONN           (PROPRIETARY_TLV_BASE_ID + 279)
+#define TLV_TYPE_HOST_MLME          (PROPRIETARY_TLV_BASE_ID + 307)
+#define TLV_TYPE_UAP_STA_FLAGS      (PROPRIETARY_TLV_BASE_ID + 313)
+#define TLV_TYPE_FW_CAP_INFO        (PROPRIETARY_TLV_BASE_ID + 318)
+#define TLV_TYPE_AX_ENABLE_SR       (PROPRIETARY_TLV_BASE_ID + 322)
+#define TLV_TYPE_AX_OBSS_PD_OFFSET  (PROPRIETARY_TLV_BASE_ID + 323)
+#define TLV_TYPE_SAE_PWE_MODE       (PROPRIETARY_TLV_BASE_ID + 339)
+#define TLV_TYPE_6E_INBAND_FRAMES   (PROPRIETARY_TLV_BASE_ID + 345)
+#define TLV_TYPE_SECURE_BOOT_UUID   (PROPRIETARY_TLV_BASE_ID + 348)
+
+#define NXPWIFI_TX_DATA_BUF_SIZE_2K 2048
+
+#define SSN_MASK                    0xfff0
+
+#define BA_RESULT_SUCCESS           0x0
+#define BA_RESULT_TIMEOUT           0x2
+
+#define IS_BASTREAM_SETUP(ptr)      ((ptr)->ba_status)
+
+#define BA_STREAM_NOT_ALLOWED       0xff
+
+#define IS_11N_ENABLED(priv) ({ \
+	typeof(priv) (_priv) = priv; \
+	(((_priv)->config_bands & BAND_GN || \
+	 (_priv)->config_bands & BAND_AN) && \
+	 (_priv)->curr_bss_params.bss_descriptor.bcn_ht_cap && \
+	 !(_priv)->curr_bss_params.bss_descriptor.disable_11n); \
+	})
+#define INITIATOR_BIT(del_ba_param_set) (((del_ba_param_set) &\
+	BIT(DELBA_INITIATOR_POS)) >> DELBA_INITIATOR_POS)
+
+#define NXPWIFI_TX_DATA_BUF_SIZE_4K  4096
+#define NXPWIFI_TX_DATA_BUF_SIZE_8K  8192
+#define NXPWIFI_TX_DATA_BUF_SIZE_12K 12288
+
+#define ISSUPP_11NENABLED(fw_cap_info) ((fw_cap_info) & BIT(11))
+#define ISSUPP_DRCS_ENABLED(fw_cap_info) ((fw_cap_info) & BIT(15))
+#define ISSUPP_SDIO_SPA_ENABLED(fw_cap_info) ((fw_cap_info) & BIT(16))
+#define ISSUPP_RANDOM_MAC(fw_cap_info) ((fw_cap_info) & BIT(27))
+#define ISSUPP_FIRMWARE_SUPPLICANT(fw_cap_info) ((fw_cap_info) & BIT(21))
+
+#define NXPWIFI_DEF_HT_CAP	(IEEE80211_HT_CAP_DSSSCCK40 | \
+				 (1 << IEEE80211_HT_CAP_RX_STBC_SHIFT) | \
+				 IEEE80211_HT_CAP_SM_PS)
+
+#define NXPWIFI_DEF_11N_TX_BF_CAP	0x09E1E008
+
+#define NXPWIFI_DEF_AMPDU	IEEE80211_HT_AMPDU_PARM_FACTOR
+
+#define RXPD_FLAG_EXTRA_HEADER BIT(1)
+/* channel number at bit 5-13 */
+#define RXPD_CHAN_MASK 0x3FE0
+/* DCM at bit 16 */
+#define RXPD_DCM_MASK 0x10000
+
+/*
+ * dot11n dev_cap bits: 17:20/40MHz, 23:SGI20, 24:SGI40, 25:TXSTBC,
+ * 26:RXSTBC, 29:Greenfield.
+ */
+#define ISSUPP_CHANWIDTH40(dot_11n_dev_cap) ((dot_11n_dev_cap) & BIT(17))
+#define ISSUPP_SHORTGI20(dot_11n_dev_cap) ((dot_11n_dev_cap) & BIT(23))
+#define ISSUPP_SHORTGI40(dot_11n_dev_cap) ((dot_11n_dev_cap) & BIT(24))
+#define ISSUPP_TXSTBC(dot_11n_dev_cap) ((dot_11n_dev_cap) & BIT(25))
+#define ISSUPP_RXSTBC(dot_11n_dev_cap) ((dot_11n_dev_cap) & BIT(26))
+#define ISSUPP_GREENFIELD(dot_11n_dev_cap) ((dot_11n_dev_cap) & BIT(29))
+#define ISENABLED_40MHZ_INTOLERANT(dot_11n_dev_cap) ((dot_11n_dev_cap) & BIT(8))
+#define ISSUPP_RXLDPC(dot_11n_dev_cap) ((dot_11n_dev_cap) & BIT(22))
+#define ISSUPP_BEAMFORMING(dot_11n_dev_cap) ((dot_11n_dev_cap) & BIT(30))
+#define ISALLOWED_CHANWIDTH40(ht_param) ((ht_param) & BIT(2))
+#define GETSUPP_TXBASTREAMS(dot_11n_dev_cap) (((dot_11n_dev_cap) >> 18) & 0xF)
+
+/* AMPDU factor size */
+#define AMPDU_FACTOR_64K 0x03
+/* hw_dev_cap : MPDU DENSITY */
+#define GET_MPDU_DENSITY(hw_dev_cap) ((hw_dev_cap) & 0x7)
+
+/* httxcfg bits: 1:20/40, 4:GF, 5:SGI20, 6:SGI40. */
+#define NXPWIFI_FW_DEF_HTTXCFG (BIT(1) | BIT(4) | BIT(5) | BIT(6))
+
+/* 11ac MCS map (1x1): stream0 supports 0-9, others not supported. */
+#define NXPWIFI_11AC_MCS_MAP_1X1	0xfffefffe
+
+/* 11ac MCS map (2x2): stream0/1 support 0-9, others not supported. */
+#define NXPWIFI_11AC_MCS_MAP_2X2	0xfffafffa
+
+#define GET_TXMCSSUPP(dev_mcs_supported) ((dev_mcs_supported) >> 4)
+#define GET_RXMCSSUPP(dev_mcs_supported) ((dev_mcs_supported) & 0x0f)
+#define SETHT_MCS32(x) (x[4] |= 1)
+#define HT_STREAM_1X1	0x11
+#define HT_STREAM_2X2	0x22
+
+#define SET_SECONDARYCHAN(radio_type, sec_chan) \
+	((radio_type) |= ((sec_chan) << 4))
+
+#define LLC_SNAP_LEN    8
+
+/* HW_SPEC fw_cap_info */
+
+#define ISSUPP_11ACENABLED(fw_cap_info) ((fw_cap_info) & BIT(13))
+#define NO_NSS_SUPPORT 0x3
+#define GET_VHTNSSMCS(mcs_mapset, nss) \
+	(((mcs_mapset) >> (2 * ((nss) - 1))) & 0x3)
+#define SET_VHTNSSMCS(mcs_mapset, nss, value) \
+	((mcs_mapset) |= ((value) & 0x3) << (2 * ((nss) - 1)))
+#define GET_DEVTXMCSMAP(dev_mcs_map) ((dev_mcs_map) >> 16)
+#define GET_DEVRXMCSMAP(dev_mcs_map) ((dev_mcs_map) & 0xFFFF)
+
+/* Clear SU/MU beamformer/beamformee and sounding dimension bits. */
+#define NXPWIFI_DEF_11AC_CAP_BF_RESET_MASK \
+	(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE | \
+	 IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE | \
+	 IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE | \
+	 IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK)
+
+#define MOD_CLASS_HR_DSSS       0x03
+#define MOD_CLASS_OFDM          0x07
+#define MOD_CLASS_HT            0x08
+#define HT_BW_20    0
+#define HT_BW_40    1
+
+#define DFS_CHAN_MOVE_TIME      10000
+
+#define ISSUPP_11AXENABLED(fw_cap_ext) ((fw_cap_ext) & BIT(7))
+
+#define HOST_CMD_GET_HW_SPEC                       0x0003
+#define HOST_CMD_802_11_SCAN                       0x0006
+#define HOST_CMD_802_11_GET_LOG                    0x000b
+#define HOST_CMD_MAC_MULTICAST_ADR                 0x0010
+#define HOST_CMD_802_11_ASSOCIATE                  0x0012
+#define HOST_CMD_802_11_SNMP_MIB                   0x0016
+#define HOST_CMD_MAC_REG_ACCESS                    0x0019
+#define HOST_CMD_BBP_REG_ACCESS                    0x001a
+#define HOST_CMD_RF_REG_ACCESS                     0x001b
+#define HOST_CMD_RF_TX_PWR                         0x001e
+#define HOST_CMD_RF_ANTENNA                        0x0020
+#define HOST_CMD_802_11_DEAUTHENTICATE             0x0024
+#define HOST_CMD_MAC_CONTROL                       0x0028
+#define HOST_CMD_802_11_MAC_ADDRESS                0x004D
+#define HOST_CMD_802_11_EEPROM_ACCESS              0x0059
+#define HOST_CMD_802_11D_DOMAIN_INFO               0x005b
+#define HOST_CMD_802_11_KEY_MATERIAL               0x005e
+#define HOST_CMD_802_11_BG_SCAN_CONFIG             0x006b
+#define HOST_CMD_802_11_BG_SCAN_QUERY              0x006c
+#define HOST_CMD_WMM_GET_STATUS                    0x0071
+#define HOST_CMD_802_11_SUBSCRIBE_EVENT            0x0075
+#define HOST_CMD_802_11_TX_RATE_QUERY              0x007f
+#define HOST_CMD_MEM_ACCESS                        0x0086
+#define HOST_CMD_CFG_DATA                          0x008f
+#define HOST_CMD_VERSION_EXT                       0x0097
+#define HOST_CMD_MEF_CFG                           0x009a
+#define HOST_CMD_RSSI_INFO                         0x00a4
+#define HOST_CMD_FUNC_INIT                         0x00a9
+#define HOST_CMD_FUNC_SHUTDOWN                     0x00aa
+#define HOST_CMD_PMIC_REG_ACCESS                   0x00ad
+#define HOST_CMD_APCMD_SYS_RESET                   0x00af
+#define HOST_CMD_UAP_SYS_CONFIG                    0x00b0
+#define HOST_CMD_UAP_BSS_START                     0x00b1
+#define HOST_CMD_UAP_BSS_STOP                      0x00b2
+#define HOST_CMD_APCMD_STA_LIST                    0x00b3
+#define HOST_CMD_UAP_STA_DEAUTH                    0x00b5
+#define HOST_CMD_11N_CFG                           0x00cd
+#define HOST_CMD_11N_ADDBA_REQ                     0x00ce
+#define HOST_CMD_11N_ADDBA_RSP                     0x00cf
+#define HOST_CMD_11N_DELBA                         0x00d0
+#define HOST_CMD_TXPWR_CFG                         0x00d1
+#define HOST_CMD_TX_RATE_CFG                       0x00d6
+#define HOST_CMD_RECONFIGURE_TX_BUFF               0x00d9
+#define HOST_CMD_CHAN_REPORT_REQUEST               0x00dd
+#define HOST_CMD_AMSDU_AGGR_CTRL                   0x00df
+#define HOST_CMD_ROBUST_COEX                       0x00e0
+#define HOST_CMD_802_11_PS_MODE_ENH                0x00e4
+#define HOST_CMD_802_11_HS_CFG_ENH                 0x00e5
+#define HOST_CMD_CAU_REG_ACCESS                    0x00ed
+#define HOST_CMD_SET_BSS_MODE                      0x00f7
+#define HOST_CMD_PCIE_DESC_DETAILS                 0x00fa
+#define HOST_CMD_802_11_NET_MONITOR                0x0102
+#define HOST_CMD_802_11_SCAN_EXT                   0x0107
+#define HOST_CMD_COALESCE_CFG                      0x010a
+#define HOST_CMD_MGMT_FRAME_REG                    0x010c
+#define HOST_CMD_REMAIN_ON_CHAN                    0x010d
+#define HOST_CMD_GTK_REKEY_OFFLOAD_CFG             0x010f
+#define HOST_CMD_11AC_CFG                          0x0112
+#define HOST_CMD_HS_WAKEUP_REASON                  0x0116
+#define HOST_CMD_MC_POLICY                         0x0121
+#define HOST_CMD_FW_DUMP_EVENT                     0x0125
+#define HOST_CMD_SDIO_SP_RX_AGGR_CFG               0x0223
+#define HOST_CMD_STA_CONFIGURE                     0x023f
+#define HOST_CMD_VDLL                              0x0240
+#define HOST_CMD_CHAN_REGION_CFG                   0x0242
+#define HOST_CMD_PACKET_AGGR_CTRL                  0x0251
+#define HOST_CMD_ADD_NEW_STATION                   0x025f
+#define HOST_CMD_11AX_CFG                          0x0266
+#define HOST_CMD_11AX_CMD                          0x026d
+#define HOST_CMD_TWT_CFG                           0x0270
+
+#define PROTOCOL_NO_SECURITY        0x01
+#define PROTOCOL_STATIC_WEP         0x02
+#define PROTOCOL_WPA                0x08
+#define PROTOCOL_WPA2               0x20
+#define PROTOCOL_WPA2_MIXED         0x28
+#define PROTOCOL_EAP                0x40
+#define KEY_MGMT_EAP                0x01
+#define KEY_MGMT_PSK                0x02
+#define KEY_MGMT_NONE               0x04
+#define KEY_MGMT_PSK_SHA256         0x100
+#define KEY_MGMT_OWE                0x200
+#define KEY_MGMT_SAE                0x400
+#define CIPHER_TKIP                 0x04
+#define CIPHER_AES_CCMP             0x08
+#define VALID_CIPHER_BITMAP         0x0c
+
+enum ENH_PS_MODES {
+	EN_PS = 1,
+	DIS_PS = 2,
+	EN_AUTO_DS = 3,
+	DIS_AUTO_DS = 4,
+	SLEEP_CONFIRM = 5,
+	GET_PS = 0,
+	EN_AUTO_PS = 0xff,
+	DIS_AUTO_PS = 0xfe,
+};
+
+enum nxpwifi_channel_flags {
+	NXPWIFI_CHANNEL_PASSIVE = BIT(0),
+	NXPWIFI_CHANNEL_DFS = BIT(1),
+	NXPWIFI_CHANNEL_NOHT40 = BIT(2),
+	NXPWIFI_CHANNEL_NOHT80 = BIT(3),
+	NXPWIFI_CHANNEL_DISABLED = BIT(7),
+};
+
+#define HOST_RET_BIT                       0x8000
+#define HOST_ACT_GEN_GET                   0x0000
+#define HOST_ACT_GEN_SET                   0x0001
+#define HOST_ACT_GEN_REMOVE                0x0004
+#define HOST_ACT_BITWISE_SET               0x0002
+#define HOST_ACT_BITWISE_CLR               0x0003
+#define HOST_RESULT_OK                     0x0000
+#define HOST_ACT_MAC_RX_ON                 BIT(0)
+#define HOST_ACT_MAC_TX_ON                 BIT(1)
+#define HOST_ACT_MAC_WEP_ENABLE            BIT(3)
+#define HOST_ACT_MAC_ETHERNETII_ENABLE     BIT(4)
+#define HOST_ACT_MAC_PROMISCUOUS_ENABLE    BIT(7)
+#define HOST_ACT_MAC_ALL_MULTICAST_ENABLE  BIT(8)
+#define HOST_ACT_MAC_DYNAMIC_BW_ENABLE     BIT(16)
+
+#define HOST_BSS_MODE_IBSS               0x0002
+#define HOST_BSS_MODE_ANY                0x0003
+
+#define HOST_SCAN_RADIO_TYPE_BG          0
+#define HOST_SCAN_RADIO_TYPE_A           1
+
+#define HS_CFG_CANCEL			0xffffffff
+#define HS_CFG_COND_DEF			0x00000000
+#define HS_CFG_GPIO_DEF			0xff
+#define HS_CFG_GAP_DEF			0xff
+#define HS_CFG_COND_BROADCAST_DATA	0x00000001
+#define HS_CFG_COND_UNICAST_DATA	0x00000002
+#define HS_CFG_COND_MAC_EVENT		0x00000004
+#define HS_CFG_COND_MULTICAST_DATA	0x00000008
+
+#define CONNECT_ERR_AUTH_ERR_STA_FAILURE	0xFFFB
+#define CONNECT_ERR_ASSOC_ERR_TIMEOUT		0xFFFC
+#define CONNECT_ERR_ASSOC_ERR_AUTH_REFUSED	0xFFFD
+#define CONNECT_ERR_AUTH_MSG_UNHANDLED		0xFFFE
+#define CONNECT_ERR_STA_FAILURE			0xFFFF
+
+#define CMD_F_HOSTCMD                BIT(0)
+
+#define HOST_CMD_ID_MASK             0x0fff
+
+#define HOST_SEQ_NUM_MASK            0x00ff
+
+#define HOST_BSS_NUM_MASK            0x0f00
+
+#define HOST_BSS_TYPE_MASK           0xf000
+
+#define HOST_ACT_SET_RX              0x0001
+#define HOST_ACT_SET_TX              0x0002
+#define HOST_ACT_SET_BOTH            0x0003
+#define HOST_ACT_GET_RX              0x0004
+#define HOST_ACT_GET_TX              0x0008
+#define HOST_ACT_GET_BOTH            0x000c
+
+#define HOST_ACT_REMOVE_STA          0x0
+#define HOST_ACT_ADD_STA             0x1
+
+#define RF_ANTENNA_AUTO                 0xFFFF
+
+#define HOST_SET_SEQ_NO_BSS_INFO(seq, num, type) \
+	((((seq) & 0x00ff) |                        \
+	 (((num) & 0x000f) << 8)) |                 \
+	(((type) & 0x000f) << 12))
+
+#define HOST_GET_SEQ_NO(seq)       \
+	((seq) & HOST_SEQ_NUM_MASK)
+
+#define HOST_GET_BSS_NO(seq)         \
+	(((seq) & HOST_BSS_NUM_MASK) >> 8)
+
+#define HOST_GET_BSS_TYPE(seq)       \
+	(((seq) & HOST_BSS_TYPE_MASK) >> 12)
+
+#define EVENT_DUMMY_HOST_WAKEUP_SIGNAL  0x00000001
+#define EVENT_LINK_LOST                 0x00000003
+#define EVENT_LINK_SENSED               0x00000004
+#define EVENT_MIB_CHANGED               0x00000006
+#define EVENT_INIT_DONE                 0x00000007
+#define EVENT_DEAUTHENTICATED           0x00000008
+#define EVENT_DISASSOCIATED             0x00000009
+#define EVENT_PS_AWAKE                  0x0000000a
+#define EVENT_PS_SLEEP                  0x0000000b
+#define EVENT_MIC_ERR_MULTICAST         0x0000000d
+#define EVENT_MIC_ERR_UNICAST           0x0000000e
+#define EVENT_DEEP_SLEEP_AWAKE          0x00000010
+#define EVENT_WMM_STATUS_CHANGE         0x00000017
+#define EVENT_BG_SCAN_REPORT            0x00000018
+#define EVENT_RSSI_LOW                  0x00000019
+#define EVENT_SNR_LOW                   0x0000001a
+#define EVENT_MAX_FAIL                  0x0000001b
+#define EVENT_RSSI_HIGH                 0x0000001c
+#define EVENT_SNR_HIGH                  0x0000001d
+#define EVENT_DATA_RSSI_LOW             0x00000024
+#define EVENT_DATA_SNR_LOW              0x00000025
+#define EVENT_DATA_RSSI_HIGH            0x00000026
+#define EVENT_DATA_SNR_HIGH             0x00000027
+#define EVENT_LINK_QUALITY              0x00000028
+#define EVENT_PORT_RELEASE              0x0000002b
+#define EVENT_UAP_STA_DEAUTH            0x0000002c
+#define EVENT_UAP_STA_ASSOC             0x0000002d
+#define EVENT_UAP_BSS_START             0x0000002e
+#define EVENT_PRE_BEACON_LOST           0x00000031
+#define EVENT_ADDBA                     0x00000033
+#define EVENT_DELBA                     0x00000034
+#define EVENT_BA_STREAM_TIEMOUT         0x00000037
+#define EVENT_AMSDU_AGGR_CTRL           0x00000042
+#define EVENT_UAP_BSS_IDLE              0x00000043
+#define EVENT_UAP_BSS_ACTIVE            0x00000044
+#define EVENT_WEP_ICV_ERR               0x00000046
+#define EVENT_HS_ACT_REQ                0x00000047
+#define EVENT_BW_CHANGE                 0x00000048
+#define EVENT_UAP_MIC_COUNTERMEASURES   0x0000004c
+#define EVENT_HOSTWAKE_STAIE		0x0000004d
+#define EVENT_CHANNEL_SWITCH_ANN        0x00000050
+#define EVENT_RADAR_DETECTED		0x00000053
+#define EVENT_CHANNEL_REPORT_RDY        0x00000054
+#define EVENT_TX_DATA_PAUSE             0x00000055
+#define EVENT_EXT_SCAN_REPORT           0x00000058
+#define EVENT_RXBA_SYNC                 0x00000059
+#define EVENT_REMAIN_ON_CHAN_EXPIRED    0x0000005f
+#define EVENT_UNKNOWN_DEBUG             0x00000063
+#define EVENT_BG_SCAN_STOPPED           0x00000065
+#define EVENT_MULTI_CHAN_INFO           0x0000006a
+#define EVENT_FW_DUMP_INFO		0x00000073
+#define EVENT_TX_STATUS_REPORT		0x00000074
+#define EVENT_BT_COEX_WLAN_PARA_CHANGE	0X00000076
+#define EVENT_VDLL_IND			0x00000081
+
+#define EVENT_ID_MASK                   0xffff
+#define BSS_NUM_MASK                    0xf
+
+#define EVENT_GET_BSS_NUM(event_cause)          \
+	(((event_cause) >> 16) & BSS_NUM_MASK)
+
+#define EVENT_GET_BSS_TYPE(event_cause)         \
+	(((event_cause) >> 24) & 0x00ff)
+
+#define NXPWIFI_MAX_PATTERN_LEN		40
+#define NXPWIFI_MAX_OFFSET_LEN		100
+#define NXPWIFI_MAX_ND_MATCH_SETS	10
+
+#define STACK_NBYTES			100
+#define TYPE_DNUM			1
+#define TYPE_BYTESEQ			2
+#define MAX_OPERAND			0x40
+#define TYPE_EQ				(MAX_OPERAND + 1)
+#define TYPE_EQ_DNUM			(MAX_OPERAND + 2)
+#define TYPE_EQ_BIT			(MAX_OPERAND + 3)
+#define TYPE_AND			(MAX_OPERAND + 4)
+#define TYPE_OR				(MAX_OPERAND + 5)
+#define MEF_MODE_HOST_SLEEP			1
+#define MEF_ACTION_ALLOW_AND_WAKEUP_HOST	3
+#define MEF_ACTION_AUTO_ARP                    0x10
+#define NXPWIFI_CRITERIA_BROADCAST	BIT(0)
+#define NXPWIFI_CRITERIA_UNICAST	BIT(1)
+#define NXPWIFI_CRITERIA_MULTICAST	BIT(3)
+#define NXPWIFI_MAX_SUPPORTED_IPADDR              4
+
+#define NXPWIFI_DEF_CS_UNIT_TIME	2
+#define NXPWIFI_DEF_CS_THR_OTHERLINK	10
+#define NXPWIFI_DEF_THR_DIRECTLINK	0
+#define NXPWIFI_DEF_CS_TIME		10
+#define NXPWIFI_DEF_CS_TIMEOUT		16
+#define NXPWIFI_DEF_CS_REG_CLASS	12
+#define NXPWIFI_DEF_CS_PERIODICITY	1
+
+#define NXPWIFI_FW_V15		   15
+
+#define NXPWIFI_MASTER_RADAR_DET_MASK BIT(1)
+
+struct nxpwifi_ie_types_header {
+	__le16 type;
+	__le16 len;
+} __packed;
+
+struct nxpwifi_ie_types_data {
+	struct nxpwifi_ie_types_header header;
+	u8 data[];
+} __packed;
+
+#define NXPWIFI_TxPD_POWER_MGMT_NULL_PACKET 0x01
+#define NXPWIFI_TxPD_POWER_MGMT_LAST_PACKET 0x08
+#define NXPWIFI_TXPD_FLAGS_REQ_TX_STATUS    0x20
+
+enum HS_WAKEUP_REASON {
+	NO_HSWAKEUP_REASON = 0,
+	BCAST_DATA_MATCHED,
+	MCAST_DATA_MATCHED,
+	UCAST_DATA_MATCHED,
+	MASKTABLE_EVENT_MATCHED,
+	NON_MASKABLE_EVENT_MATCHED,
+	NON_MASKABLE_CONDITION_MATCHED,
+	MAGIC_PATTERN_MATCHED,
+	CONTROL_FRAME_MATCHED,
+	MANAGEMENT_FRAME_MATCHED,
+	GTK_REKEY_FAILURE,
+	RESERVED
+};
+
+struct txpd {
+	u8 bss_type;
+	u8 bss_num;
+	__le16 tx_pkt_length;
+	__le16 tx_pkt_offset;
+	__le16 tx_pkt_type;
+	__le32 tx_control;
+	u8 priority;
+	u8 flags;
+	u8 pkt_delay_2ms;
+	u8 reserved1[2];
+	u8 tx_token_id;
+	u8 reserved[2];
+} __packed;
+
+struct rxpd {
+	u8 bss_type;
+	u8 bss_num;
+	__le16 rx_pkt_length;
+	__le16 rx_pkt_offset;
+	__le16 rx_pkt_type;
+	__le16 seq_num;
+	u8 priority;
+	u8 rx_rate;
+	s8 snr;
+	s8 nf;
+
+	/*
+	 * For: Non-802.11 AC cards
+	 *
+	 * Ht Info [Bit 0] RxRate format: LG=0, HT=1
+	 * [Bit 1]  HT Bandwidth: BW20 = 0, BW40 = 1
+	 * [Bit 2]  HT Guard Interval: LGI = 0, SGI = 1
+	 *
+	 * For: 802.11 AC cards
+	 * [Bit 1] [Bit 0] RxRate format: legacy rate = 00 HT = 01 VHT = 10
+	 * [Bit 3] [Bit 2] HT/VHT Bandwidth BW20 = 00 BW40 = 01
+	 *						BW80 = 10  BW160 = 11
+	 * [Bit 4] HT/VHT Guard interval LGI = 0 SGI = 1
+	 * [Bit 5] STBC support Enabled = 1
+	 * [Bit 6] LDPC support Enabled = 1
+	 * [Bit 7] Reserved
+	 */
+	u8 ht_info;
+	u8 reserved[3];
+	u8 flags;
+	u8 antenna;
+	/* toa_tod_tstamps: [31:0] ToA, [63:32] ToD (ns). */
+	__le64 toa_tod_tstamps;
+	/* rx info */
+	__le32 rx_info;
+	/* Reserved */
+	u8  reserved3[8];
+	u8 ta_mac[6];
+	u8 reserved4[2];
+} __packed;
+
+struct uap_txpd {
+	u8 bss_type;
+	u8 bss_num;
+	__le16 tx_pkt_length;
+	__le16 tx_pkt_offset;
+	__le16 tx_pkt_type;
+	__le32 tx_control;
+	u8 priority;
+	u8 flags;
+	u8 pkt_delay_2ms;
+	u8 reserved1[2];
+	u8 tx_token_id;
+	u8 reserved[2];
+} __packed;
+
+struct uap_rxpd {
+	u8 bss_type;
+	u8 bss_num;
+	__le16 rx_pkt_length;
+	__le16 rx_pkt_offset;
+	__le16 rx_pkt_type;
+	__le16 seq_num;
+	u8 priority;
+	u8 rx_rate;
+	s8 snr;
+	s8 nf;
+	u8 ht_info;
+	u8 reserved[3];
+	u8 flags;
+} __packed;
+
+struct nxpwifi_auth {
+	__le16 auth_alg;
+	__le16 auth_transaction;
+	__le16 status_code;
+	/* possibly followed by Challenge text */
+	u8 variable[];
+} __packed;
+
+struct nxpwifi_ieee80211_mgmt {
+	__le16 frame_control;
+	__le16 duration;
+	u8 da[ETH_ALEN];
+	u8 sa[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le16 seq_ctrl;
+	u8 addr4[ETH_ALEN];
+	struct nxpwifi_auth auth;
+} __packed;
+
+struct nxpwifi_fw_chan_stats {
+	u8 chan_num;
+	u8 bandcfg;
+	u8 flags;
+	s8 noise;
+	__le16 total_bss;
+	__le16 cca_scan_dur;
+	__le16 cca_busy_dur;
+} __packed;
+
+enum nxpwifi_chan_scan_mode_bitmasks {
+	NXPWIFI_PASSIVE_SCAN = BIT(0),
+	NXPWIFI_DISABLE_CHAN_FILT = BIT(1),
+	NXPWIFI_HIDDEN_SSID_REPORT = BIT(4),
+};
+
+struct nxpwifi_chan_scan_param_set {
+	u8 band_cfg;
+	u8 chan_number;
+	u8 chan_scan_mode_bmap;
+	__le16 min_scan_time;
+	__le16 max_scan_time;
+} __packed;
+
+struct nxpwifi_ie_types_chan_list_param_set {
+	struct nxpwifi_ie_types_header header;
+	struct nxpwifi_chan_scan_param_set chan_scan_param[];
+} __packed;
+
+struct nxpwifi_ie_types_rxba_sync {
+	struct nxpwifi_ie_types_header header;
+	u8 mac[ETH_ALEN];
+	u8 tid;
+	u8 reserved;
+	__le16 seq_num;
+	__le16 bitmap_len;
+	u8 bitmap[];
+} __packed;
+
+struct chan_band_param_set {
+	u8 radio_type;
+	u8 chan_number;
+};
+
+struct nxpwifi_ie_types_chan_band_list_param_set {
+	struct nxpwifi_ie_types_header header;
+	struct chan_band_param_set chan_band_param[];
+} __packed;
+
+struct nxpwifi_ie_types_rates_param_set {
+	struct nxpwifi_ie_types_header header;
+	u8 rates[];
+} __packed;
+
+struct nxpwifi_ie_types_ssid_param_set {
+	struct nxpwifi_ie_types_header header;
+	u8 ssid[];
+} __packed;
+
+struct nxpwifi_ie_types_host_mlme {
+	struct nxpwifi_ie_types_header header;
+	u8 host_mlme;
+} __packed;
+
+struct nxpwifi_ie_types_num_probes {
+	struct nxpwifi_ie_types_header header;
+	__le16 num_probes;
+} __packed;
+
+struct nxpwifi_ie_types_repeat_count {
+	struct nxpwifi_ie_types_header header;
+	__le16 repeat_count;
+} __packed;
+
+struct nxpwifi_ie_types_min_rssi_threshold {
+	struct nxpwifi_ie_types_header header;
+	__le16 rssi_threshold;
+} __packed;
+
+struct nxpwifi_ie_types_bgscan_start_later {
+	struct nxpwifi_ie_types_header header;
+	__le16 start_later;
+} __packed;
+
+struct nxpwifi_ie_types_scan_chan_gap {
+	struct nxpwifi_ie_types_header header;
+	/* time gap in TUs to be used between two consecutive channels scan */
+	__le16 chan_gap;
+} __packed;
+
+struct nxpwifi_ie_types_random_mac {
+	struct nxpwifi_ie_types_header header;
+	u8 mac[ETH_ALEN];
+} __packed;
+
+struct nxpwifi_ietypes_chanstats {
+	struct nxpwifi_ie_types_header header;
+	struct nxpwifi_fw_chan_stats chanstats[];
+} __packed;
+
+struct nxpwifi_ie_types_wildcard_ssid_params {
+	struct nxpwifi_ie_types_header header;
+	u8 max_ssid_length;
+	u8 ssid[];
+} __packed;
+
+#define TSF_DATA_SIZE            8
+struct nxpwifi_ie_types_tsf_timestamp {
+	struct nxpwifi_ie_types_header header;
+	u8 tsf_data[];
+} __packed;
+
+struct nxpwifi_cf_param_set {
+	u8 cfp_cnt;
+	u8 cfp_period;
+	__le16 cfp_max_duration;
+	__le16 cfp_duration_remaining;
+} __packed;
+
+struct nxpwifi_ibss_param_set {
+	__le16 atim_window;
+} __packed;
+
+struct nxpwifi_ie_types_ss_param_set {
+	struct nxpwifi_ie_types_header header;
+	union {
+		struct nxpwifi_cf_param_set cf_param_set[1];
+		struct nxpwifi_ibss_param_set ibss_param_set[1];
+	} cf_ibss;
+} __packed;
+
+struct nxpwifi_fh_param_set {
+	__le16 dwell_time;
+	u8 hop_set;
+	u8 hop_pattern;
+	u8 hop_index;
+} __packed;
+
+struct nxpwifi_ds_param_set {
+	u8 current_chan;
+} __packed;
+
+struct nxpwifi_ie_types_phy_param_set {
+	struct nxpwifi_ie_types_header header;
+	union {
+		struct nxpwifi_fh_param_set fh_param_set[1];
+		struct nxpwifi_ds_param_set ds_param_set[1];
+	} fh_ds;
+} __packed;
+
+struct nxpwifi_ie_types_auth_type {
+	struct nxpwifi_ie_types_header header;
+	__le16 auth_type;
+} __packed;
+
+struct nxpwifi_ie_types_vendor_param_set {
+	struct nxpwifi_ie_types_header header;
+	u8 ie[NXPWIFI_MAX_VSIE_LEN];
+};
+
+#define NXPWIFI_AUTHTYPE_SAE 6
+
+struct nxpwifi_ie_types_sae_pwe_mode {
+	struct nxpwifi_ie_types_header header;
+	u8 pwe[];
+} __packed;
+
+struct nxpwifi_ie_types_rsn_param_set {
+	struct nxpwifi_ie_types_header header;
+	u8 rsn_ie[];
+} __packed;
+
+#define KEYPARAMSET_FIXED_LEN 6
+
+#define IGTK_PN_LEN           8
+
+struct nxpwifi_cmac_param {
+	u8 ipn[IGTK_PN_LEN];
+	u8 key[WLAN_KEY_LEN_AES_CMAC];
+} __packed;
+
+struct nxpwifi_wep_param {
+	__le16 key_len;
+	u8 key[WLAN_KEY_LEN_WEP104];
+} __packed;
+
+struct nxpwifi_tkip_param {
+	u8 pn[WPA_PN_SIZE];
+	__le16 key_len;
+	u8 key[WLAN_KEY_LEN_TKIP];
+} __packed;
+
+struct nxpwifi_aes_param {
+	u8 pn[WPA_PN_SIZE];
+	__le16 key_len;
+	u8 key[WLAN_KEY_LEN_CCMP_256];
+} __packed;
+
+struct nxpwifi_cmac_aes_param {
+	u8 ipn[IGTK_PN_LEN];
+	__le16 key_len;
+	u8 key[WLAN_KEY_LEN_AES_CMAC];
+} __packed;
+
+struct nxpwifi_gmac_aes_param {
+	u8 ipn[IGTK_PN_LEN];
+	__le16 key_len;
+	u8 key[WLAN_KEY_LEN_BIP_GMAC_256];
+} __packed;
+
+struct nxpwifi_ie_type_key_param_set {
+	__le16 type;
+	__le16 len;
+	u8 mac_addr[ETH_ALEN];
+	u8 key_idx;
+	u8 key_type;
+	__le16 key_info;
+	union {
+		struct nxpwifi_wep_param wep;
+		struct nxpwifi_tkip_param tkip;
+		struct nxpwifi_aes_param aes;
+		struct nxpwifi_cmac_aes_param cmac_aes;
+		struct nxpwifi_gmac_aes_param gmac_aes;
+	} key_params;
+} __packed;
+
+struct host_cmd_ds_802_11_key_material {
+	__le16 action;
+	struct nxpwifi_ie_type_key_param_set key_param_set;
+} __packed;
+
+struct host_cmd_ds_gen {
+	__le16 command;
+	__le16 size;
+	__le16 seq_num;
+	__le16 result;
+};
+
+#define S_DS_GEN        sizeof(struct host_cmd_ds_gen)
+
+enum sleep_resp_ctrl {
+	RESP_NOT_NEEDED = 0,
+	RESP_NEEDED,
+};
+
+struct nxpwifi_ps_param {
+	__le16 null_pkt_interval;
+	__le16 multiple_dtims;
+	__le16 bcn_miss_timeout;
+	__le16 local_listen_interval;
+	__le16 reserved;
+	__le16 mode;
+	__le16 delay_to_ps;
+} __packed;
+
+#define HS_DEF_WAKE_INTERVAL          100
+#define HS_DEF_INACTIVITY_TIMEOUT      50
+
+struct nxpwifi_ps_param_in_hs {
+	struct nxpwifi_ie_types_header header;
+	__le32 hs_wake_int;
+	__le32 hs_inact_timeout;
+} __packed;
+
+#define BITMAP_AUTO_DS         0x01
+#define BITMAP_STA_PS          0x10
+
+struct nxpwifi_ie_types_auto_ds_param {
+	struct nxpwifi_ie_types_header header;
+	__le16 deep_sleep_timeout;
+} __packed;
+
+struct nxpwifi_ie_types_ps_param {
+	struct nxpwifi_ie_types_header header;
+	struct nxpwifi_ps_param param;
+} __packed;
+
+struct host_cmd_ds_802_11_ps_mode_enh {
+	__le16 action;
+
+	union {
+		struct nxpwifi_ps_param opt_ps;
+		__le16 ps_bitmap;
+	} params;
+} __packed;
+
+enum API_VER_ID {
+	KEY_API_VER_ID = 1,
+	FW_API_VER_ID = 2,
+	UAP_FW_API_VER_ID = 3,
+	CHANRPT_API_VER_ID = 4,
+	FW_HOTFIX_VER_ID = 5,
+};
+
+struct hw_spec_api_rev {
+	struct nxpwifi_ie_types_header header;
+	__le16 api_id;
+	u8 major_ver;
+	u8 minor_ver;
+} __packed;
+
+struct hw_spec_max_conn {
+	struct nxpwifi_ie_types_header header;
+	u8 reserved;
+	u8 max_sta_conn;
+} __packed;
+
+struct hw_spec_extension {
+	struct nxpwifi_ie_types_header header;
+	u8 ext_id;
+	u8 tlv[];
+} __packed;
+
+/* HE MAC Capabilities Information field BIT 1 for TWT Req */
+#define HE_MAC_CAP_TWT_REQ_SUPPORT BIT(1)
+/* HE MAC Capabilities Information field BIT 2 for TWT Resp*/
+#define HE_MAC_CAP_TWT_RESP_SUPPORT BIT(2)
+
+struct nxpwifi_ie_types_he_cap {
+	struct nxpwifi_ie_types_header header;
+	u8 ext_id;
+	u8 he_mac_cap[6];
+	u8 he_phy_cap[11];
+	__le16 rx_mcs_80;
+	__le16 tx_mcs_80;
+	__le16 rx_mcs_160;
+	__le16 tx_mcs_160;
+	__le16 rx_mcs_80p80;
+	__le16 tx_mcs_80p80;
+	u8 val[20];
+} __packed;
+
+struct nxpwifi_ie_types_he_op {
+	struct nxpwifi_ie_types_header header;
+	u8 ext_id;
+	__le16 he_op_param1;
+	u8 he_op_param2;
+	u8 bss_color_info;
+	__le16 basic_he_mcs_nss;
+	u8 option[9];
+} __packed;
+
+struct hw_spec_secure_boot_uuid {
+	struct nxpwifi_ie_types_header header;
+	__le64 uuid_lo;
+	__le64 uuid_hi;
+} __packed;
+
+struct hw_spec_fw_cap_info {
+	struct nxpwifi_ie_types_header header;
+	__le32 fw_cap_info;
+	__le32 fw_cap_ext;
+} __packed;
+
+struct host_cmd_ds_get_hw_spec {
+	__le16 hw_if_version;
+	__le16 version;
+	__le16 reserved;
+	__le16 num_of_mcast_adr;
+	u8 permanent_addr[ETH_ALEN];
+	__le16 region_code;
+	__le16 number_of_antenna;
+	__le32 fw_release_number;
+	__le32 hw_dev_cap;
+	__le32 reserved_1;
+	__le32 reserved_2;
+	__le32 fw_cap_info;
+	__le32 dot_11n_dev_cap;
+	u8 dev_mcs_support;
+	__le16 mp_end_port;	/* SDIO only, reserved for other interfaces */
+	__le16 mgmt_buf_count;	/* mgmt element buffer count */
+	__le32 reserved_3;
+	__le32 reserved_4;
+	__le32 dot_11ac_dev_cap;
+	__le32 dot_11ac_mcs_support;
+	u8 tlv[];
+} __packed;
+
+struct host_cmd_ds_802_11_rssi_info {
+	__le16 action;
+	__le16 ndata;
+	__le16 nbcn;
+	__le16 reserved[9];
+	long long reserved_1;
+} __packed;
+
+struct host_cmd_ds_802_11_rssi_info_rsp {
+	__le16 action;
+	__le16 ndata;
+	__le16 nbcn;
+	__le16 data_rssi_last;
+	__le16 data_nf_last;
+	__le16 data_rssi_avg;
+	__le16 data_nf_avg;
+	__le16 bcn_rssi_last;
+	__le16 bcn_nf_last;
+	__le16 bcn_rssi_avg;
+	__le16 bcn_nf_avg;
+	long long tsf_bcn;
+} __packed;
+
+struct host_cmd_ds_802_11_mac_address {
+	__le16 action;
+	u8 mac_addr[ETH_ALEN];
+} __packed;
+
+struct host_cmd_ds_mac_control {
+	__le32 action;
+};
+
+struct host_cmd_ds_mac_multicast_adr {
+	__le16 action;
+	__le16 num_of_adrs;
+	u8 mac_list[NXPWIFI_MAX_MULTICAST_LIST_SIZE][ETH_ALEN];
+} __packed;
+
+struct host_cmd_ds_802_11_deauthenticate {
+	u8 mac_addr[ETH_ALEN];
+	__le16 reason_code;
+} __packed;
+
+struct host_cmd_ds_802_11_associate {
+	u8 peer_sta_addr[ETH_ALEN];
+	__le16 cap_info_bitmap;
+	__le16 listen_interval;
+	__le16 beacon_period;
+	u8 dtim_period;
+} __packed;
+
+struct ieee_types_assoc_rsp {
+	__le16 cap_info_bitmap;
+	__le16 status_code;
+	__le16 a_id;
+	u8 ie_buffer[];
+} __packed;
+
+struct host_cmd_ds_802_11_associate_rsp {
+	struct ieee_types_assoc_rsp assoc_rsp;
+} __packed;
+
+struct ieee_types_cf_param_set {
+	u8 element_id;
+	u8 len;
+	u8 cfp_cnt;
+	u8 cfp_period;
+	__le16 cfp_max_duration;
+	__le16 cfp_duration_remaining;
+} __packed;
+
+struct ieee_types_fh_param_set {
+	u8 element_id;
+	u8 len;
+	__le16 dwell_time;
+	u8 hop_set;
+	u8 hop_pattern;
+	u8 hop_index;
+} __packed;
+
+struct ieee_types_ds_param_set {
+	u8 element_id;
+	u8 len;
+	u8 current_chan;
+} __packed;
+
+union ieee_types_phy_param_set {
+	struct ieee_types_fh_param_set fh_param_set;
+	struct ieee_types_ds_param_set ds_param_set;
+} __packed;
+
+struct ieee_types_oper_mode_ntf {
+	u8 element_id;
+	u8 len;
+	u8 oper_mode;
+} __packed;
+
+struct host_cmd_ds_802_11_get_log {
+	__le32 mcast_tx_frame;
+	__le32 failed;
+	__le32 retry;
+	__le32 multi_retry;
+	__le32 frame_dup;
+	__le32 rts_success;
+	__le32 rts_failure;
+	__le32 ack_failure;
+	__le32 rx_frag;
+	__le32 mcast_rx_frame;
+	__le32 fcs_error;
+	__le32 tx_frame;
+	__le32 reserved;
+	__le32 wep_icv_err_cnt[4];
+	__le32 bcn_rcv_cnt;
+	__le32 bcn_miss_cnt;
+} __packed;
+
+/* Enumeration for rate format */
+enum nxpwifi_rate_format {
+	NXPWIFI_RATE_FORMAT_LG = 0,
+	NXPWIFI_RATE_FORMAT_HT,
+	NXPWIFI_RATE_FORMAT_VHT,
+	NXPWIFI_RATE_FORMAT_HE,
+	NXPWIFI_RATE_FORMAT_AUTO = 0xFF,
+};
+
+struct host_cmd_ds_tx_rate_query {
+	u8 tx_rate;
+	/*
+	 * Tx Rate Info: For 802.11 AC cards
+	 *
+	 * [Bit 0-1] tx rate format: LG = 0, HT = 1, VHT = 2
+	 * [Bit 2-3] HT/VHT Bandwidth: BW20 = 0, BW40 = 1, BW80 = 2, BW160 = 3
+	 * [Bit 4]   HT/VHT Guard Interval: LGI = 0, SGI = 1
+	 *
+	 * For non-802.11 AC cards
+	 * Ht Info [Bit 0] RxRate format: LG=0, HT=1
+	 * [Bit 1]  HT Bandwidth: BW20 = 0, BW40 = 1
+	 * [Bit 2]  HT Guard Interval: LGI = 0, SGI = 1
+	 */
+	u8 ht_info;
+} __packed;
+
+struct nxpwifi_tx_pause_tlv {
+	struct nxpwifi_ie_types_header header;
+	u8 peermac[ETH_ALEN];
+	u8 tx_pause;
+	u8 pkt_cnt;
+} __packed;
+
+enum host_sleep_action {
+	HS_CONFIGURE = 0x0001,
+	HS_ACTIVATE  = 0x0002,
+};
+
+struct nxpwifi_hs_config_param {
+	__le32 conditions;
+	u8 gpio;
+	u8 gap;
+} __packed;
+
+struct hs_activate_param {
+	__le16 resp_ctrl;
+} __packed;
+
+struct host_cmd_ds_802_11_hs_cfg_enh {
+	__le16 action;
+
+	union {
+		struct nxpwifi_hs_config_param hs_config;
+		struct hs_activate_param hs_activate;
+	} params;
+} __packed;
+
+enum SNMP_MIB_INDEX {
+	OP_RATE_SET_I = 1,
+	DTIM_PERIOD_I = 3,
+	RTS_THRESH_I = 5,
+	SHORT_RETRY_LIM_I = 6,
+	LONG_RETRY_LIM_I = 7,
+	FRAG_THRESH_I = 8,
+	DOT11D_I = 9,
+	DOT11H_I = 10,
+};
+
+enum nxpwifi_assocmd_failurepoint {
+	NXPWIFI_ASSOC_CMD_SUCCESS = 0,
+	NXPWIFI_ASSOC_CMD_FAILURE_ASSOC,
+	NXPWIFI_ASSOC_CMD_FAILURE_AUTH,
+	NXPWIFI_ASSOC_CMD_FAILURE_JOIN
+};
+
+#define MAX_SNMP_BUF_SIZE   128
+
+struct host_cmd_ds_802_11_snmp_mib {
+	__le16 query_type;
+	__le16 oid;
+	__le16 buf_size;
+	u8 value[];
+} __packed;
+
+struct nxpwifi_rate_scope {
+	__le16 type;
+	__le16 length;
+	__le16 hr_dsss_rate_bitmap;
+	__le16 ofdm_rate_bitmap;
+	__le16 ht_mcs_rate_bitmap[8];
+	__le16 vht_mcs_rate_bitmap[8];
+} __packed;
+
+struct nxpwifi_rate_drop_pattern {
+	__le16 type;
+	__le16 length;
+	__le32 rate_drop_mode;
+} __packed;
+
+struct host_cmd_ds_tx_rate_cfg {
+	__le16 action;
+	__le16 cfg_index;
+} __packed;
+
+struct nxpwifi_power_group {
+	u8 modulation_class;
+	u8 first_rate_code;
+	u8 last_rate_code;
+	s8 power_step;
+	s8 power_min;
+	s8 power_max;
+	u8 ht_bandwidth;
+	u8 reserved;
+} __packed;
+
+struct nxpwifi_types_power_group {
+	__le16 type;
+	__le16 length;
+} __packed;
+
+struct host_cmd_ds_txpwr_cfg {
+	__le16 action;
+	__le16 cfg_index;
+	__le32 mode;
+} __packed;
+
+struct host_cmd_ds_rf_tx_pwr {
+	__le16 action;
+	__le16 cur_level;
+	u8 max_power;
+	u8 min_power;
+} __packed;
+
+struct host_cmd_ds_rf_ant_mimo {
+	__le16 action_tx;
+	__le16 tx_ant_mode;
+	__le16 action_rx;
+	__le16 rx_ant_mode;
+} __packed;
+
+struct host_cmd_ds_rf_ant_siso {
+	__le16 action;
+	__le16 ant_mode;
+} __packed;
+
+#define BAND_CFG_CHAN_BAND_MASK		0x03
+#define BAND_CFG_CHAN_BAND_SHIFT_BIT	0
+#define BAND_CFG_CHAN_WIDTH_MASK	0x0C
+#define BAND_CFG_CHAN_WIDTH_SHIFT_BIT	2
+#define BAND_CFG_CHAN2_OFFSET_MASK	0x30
+#define BAND_CFG_CHAN2_SHIFT_BIT	4
+
+struct nxpwifi_chan_desc {
+	__le16 start_freq;
+	u8 band_cfg;
+	u8 chan_num;
+} __packed;
+
+struct host_cmd_ds_chan_rpt_req {
+	struct nxpwifi_chan_desc chan_desc;
+	__le32 msec_dwell_time;
+} __packed;
+
+struct host_cmd_ds_chan_rpt_event {
+	__le32 result;
+	__le64 start_tsf;
+	__le32 duration;
+	u8 tlvbuf[];
+} __packed;
+
+struct host_cmd_sdio_sp_rx_aggr_cfg {
+	u8 action;
+	u8 enable;
+	__le16 block_size;
+} __packed;
+
+struct nxpwifi_fixed_bcn_param {
+	__le64 timestamp;
+	__le16 beacon_period;
+	__le16 cap_info_bitmap;
+} __packed;
+
+struct nxpwifi_event_scan_result {
+	__le16 event_id;
+	u8 bss_index;
+	u8 bss_type;
+	u8 more_event;
+	u8 reserved[3];
+	__le16 buf_size;
+	u8 num_of_set;
+} __packed;
+
+struct tx_status_event {
+	u8 packet_type;
+	u8 tx_token_id;
+	u8 status;
+} __packed;
+
+#define NXPWIFI_USER_SCAN_CHAN_MAX             50
+
+#define NXPWIFI_MAX_SSID_LIST_LENGTH         10
+
+struct nxpwifi_scan_cmd_config {
+	/* BSS mode to be sent in the firmware command */
+	u8 bss_mode;
+
+	/* Specific BSSID used to filter scan results in the firmware */
+	u8 specific_bssid[ETH_ALEN];
+
+	/* Length of TLVs sent in command starting at tlvBuffer */
+	u32 tlv_buf_len;
+
+	/*
+	 * SSID TLV(s) and ChanList TLVs to be sent in the firmware command
+	 *
+	 * TLV_TYPE_CHANLIST, nxpwifi_ie_types_chan_list_param_set
+	 * WLAN_EID_SSID, nxpwifi_ie_types_ssid_param_set
+	 */
+	u8 tlv_buf[];	/* SSID TLV(s) and ChanList TLVs are stored here */
+} __packed;
+
+struct nxpwifi_user_scan_chan {
+	u8 chan_number;
+	u8 radio_type;
+	u8 scan_type;
+	u8 reserved;
+	u32 scan_time;
+} __packed;
+
+struct nxpwifi_user_scan_cfg {
+	/* BSS mode to be sent in the firmware command */
+	u8 bss_mode;
+	/* Configure the number of probe requests for active chan scans */
+	u8 num_probes;
+	u8 reserved;
+	/* BSSID filter sent in the firmware command to limit the results */
+	u8 specific_bssid[ETH_ALEN];
+	/* SSID filter list used in the firmware to limit the scan results */
+	struct cfg80211_ssid *ssid_list;
+	u8 num_ssids;
+	/* Variable number (fixed maximum) of channels to scan up */
+	struct nxpwifi_user_scan_chan chan_list[NXPWIFI_USER_SCAN_CHAN_MAX];
+	u16 scan_chan_gap;
+	u8 random_mac[ETH_ALEN];
+} __packed;
+
+#define NXPWIFI_BG_SCAN_CHAN_MAX 38
+#define NXPWIFI_BSS_MODE_INFRA 1
+#define NXPWIFI_BGSCAN_ACT_GET     0x0000
+#define NXPWIFI_BGSCAN_ACT_SET     0x0001
+#define NXPWIFI_BGSCAN_ACT_SET_ALL 0xff01
+/** ssid match */
+#define NXPWIFI_BGSCAN_SSID_MATCH          0x0001
+/** ssid match and RSSI exceeded */
+#define NXPWIFI_BGSCAN_SSID_RSSI_MATCH     0x0004
+/**wait for all channel scan to complete to report scan result*/
+#define NXPWIFI_BGSCAN_WAIT_ALL_CHAN_DONE  0x80000000
+
+struct nxpwifi_bg_scan_cfg {
+	u16 action;
+	u8 enable;
+	u8 bss_type;
+	u8 chan_per_scan;
+	u32 scan_interval;
+	u32 report_condition;
+	u8 num_probes;
+	u8 rssi_threshold;
+	u8 snr_threshold;
+	u16 repeat_count;
+	u16 start_later;
+	struct cfg80211_match_set *ssid_list;
+	u8 num_ssids;
+	struct nxpwifi_user_scan_chan chan_list[NXPWIFI_BG_SCAN_CHAN_MAX];
+	u16 scan_chan_gap;
+} __packed;
+
+struct ie_body {
+	u8 grp_key_oui[4];
+	u8 ptk_cnt[2];
+	u8 ptk_body[4];
+} __packed;
+
+struct host_cmd_ds_802_11_scan {
+	u8 bss_mode;
+	u8 bssid[ETH_ALEN];
+	u8 tlv_buffer[];
+} __packed;
+
+struct host_cmd_ds_802_11_scan_rsp {
+	__le16 bss_descript_size;
+	u8 number_of_sets;
+	u8 bss_desc_and_tlv_buffer[];
+} __packed;
+
+struct host_cmd_ds_802_11_scan_ext {
+	u32   reserved;
+	u8    tlv_buffer[];
+} __packed;
+
+struct nxpwifi_ie_types_bss_mode {
+	struct nxpwifi_ie_types_header  header;
+	u8 bss_mode;
+} __packed;
+
+struct nxpwifi_ie_types_scan_rsp {
+	struct nxpwifi_ie_types_header header;
+	u8 bssid[ETH_ALEN];
+	u8 frame_body[];
+} __packed;
+
+struct nxpwifi_ie_types_scan_inf {
+	struct nxpwifi_ie_types_header header;
+	__le16 rssi;
+	__le16 anpi;
+	u8 cca_busy_fraction;
+	u8 radio_type;
+	u8 channel;
+	u8 reserved;
+	__le64 tsf;
+} __packed;
+
+struct host_cmd_ds_802_11_bg_scan_config {
+	__le16 action;
+	u8 enable;
+	u8 bss_type;
+	u8 chan_per_scan;
+	u8 reserved;
+	__le16 reserved1;
+	__le32 scan_interval;
+	__le32 reserved2;
+	__le32 report_condition;
+	__le16 reserved3;
+	u8 tlv[];
+} __packed;
+
+struct host_cmd_ds_802_11_bg_scan_query {
+	u8 flush;
+} __packed;
+
+struct host_cmd_ds_802_11_bg_scan_query_rsp {
+	__le32 report_condition;
+	struct host_cmd_ds_802_11_scan_rsp scan_resp;
+} __packed;
+
+struct nxpwifi_ietypes_domain_code {
+	struct nxpwifi_ie_types_header header;
+	u8 domain_code;
+	u8 reserved;
+} __packed;
+
+struct nxpwifi_ietypes_domain_param_set {
+	struct nxpwifi_ie_types_header header;
+	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
+	struct ieee80211_country_ie_triplet triplet[];
+} __packed;
+
+struct host_cmd_ds_802_11d_domain_info {
+	__le16 action;
+	struct nxpwifi_ietypes_domain_param_set domain;
+} __packed;
+
+struct host_cmd_ds_802_11d_domain_info_rsp {
+	__le16 action;
+	struct nxpwifi_ietypes_domain_param_set domain;
+} __packed;
+
+struct host_cmd_ds_11n_addba_req {
+	u8 add_req_result;
+	u8 peer_mac_addr[ETH_ALEN];
+	u8 dialog_token;
+	__le16 block_ack_param_set;
+	__le16 block_ack_tmo;
+	__le16 ssn;
+} __packed;
+
+struct host_cmd_ds_11n_addba_rsp {
+	u8 add_rsp_result;
+	u8 peer_mac_addr[ETH_ALEN];
+	u8 dialog_token;
+	__le16 status_code;
+	__le16 block_ack_param_set;
+	__le16 block_ack_tmo;
+	__le16 ssn;
+} __packed;
+
+struct host_cmd_ds_11n_delba {
+	u8 del_result;
+	u8 peer_mac_addr[ETH_ALEN];
+	__le16 del_ba_param_set;
+	__le16 reason_code;
+	u8 reserved;
+} __packed;
+
+struct host_cmd_ds_11n_batimeout {
+	u8 tid;
+	u8 peer_mac_addr[ETH_ALEN];
+	u8 origninator;
+} __packed;
+
+struct host_cmd_ds_11n_cfg {
+	__le16 action;
+	__le16 ht_tx_cap;
+	__le16 ht_tx_info;
+	__le16 misc_config;	/* Needed for 802.11AC cards only */
+} __packed;
+
+struct host_cmd_ds_txbuf_cfg {
+	__le16 action;
+	__le16 buff_size;
+	__le16 mp_end_port;	/* SDIO only, reserved for other interfaces */
+	__le16 reserved3;
+} __packed;
+
+struct host_cmd_ds_amsdu_aggr_ctrl {
+	__le16 action;
+	__le16 enable;
+	__le16 curr_buf_size;
+} __packed;
+
+struct host_cmd_ds_sta_deauth {
+	u8 mac[ETH_ALEN];
+	__le16 reason;
+} __packed;
+
+struct nxpwifi_ie_types_sta_info {
+	struct nxpwifi_ie_types_header header;
+	u8 mac[ETH_ALEN];
+	u8 power_mfg_status;
+	s8 rssi;
+};
+
+struct host_cmd_ds_sta_list {
+	__le16 sta_count;
+	u8 tlv[];
+} __packed;
+
+struct nxpwifi_ie_types_pwr_capability {
+	struct nxpwifi_ie_types_header header;
+	s8 min_pwr;
+	s8 max_pwr;
+};
+
+struct nxpwifi_ie_types_local_pwr_constraint {
+	struct nxpwifi_ie_types_header header;
+	u8 chan;
+	u8 constraint;
+};
+
+struct nxpwifi_ie_types_wmm_param_set {
+	struct nxpwifi_ie_types_header header;
+	u8 wmm_ie[];
+} __packed;
+
+struct nxpwifi_ie_types_mgmt_frame {
+	struct nxpwifi_ie_types_header header;
+	__le16 frame_control;
+	u8 frame_contents[];
+};
+
+struct nxpwifi_ie_types_wmm_queue_status {
+	struct nxpwifi_ie_types_header header;
+	u8 queue_index;
+	u8 disabled;
+	__le16 medium_time;
+	u8 flow_required;
+	u8 flow_created;
+	u32 reserved;
+};
+
+struct ieee_types_wmm_info {
+	/*
+	 * WMM Info element - Vendor Specific Header:
+	 *   element_id  [221/0xdd]
+	 *   Len         [7]
+	 *   Oui         [00:50:f2]
+	 *   OuiType     [2]
+	 *   OuiSubType  [0]
+	 *   Version     [1]
+	 */
+	struct ieee80211_vendor_ie vend_hdr;
+	u8 oui_subtype;
+	u8 version;
+
+	u8 qos_info_bitmap;
+} __packed;
+
+struct host_cmd_ds_wmm_get_status {
+	u8 queue_status_tlv[sizeof(struct nxpwifi_ie_types_wmm_queue_status) *
+			      IEEE80211_NUM_ACS];
+	u8 wmm_param_tlv[sizeof(struct ieee80211_wmm_param_ie) + 2];
+} __packed;
+
+struct nxpwifi_wmm_ac_status {
+	u8 disabled;
+	u8 flow_required;
+	u8 flow_created;
+};
+
+struct nxpwifi_ie_types_htcap {
+	struct nxpwifi_ie_types_header header;
+	struct ieee80211_ht_cap ht_cap;
+} __packed;
+
+struct nxpwifi_ie_types_vhtcap {
+	struct nxpwifi_ie_types_header header;
+	struct ieee80211_vht_cap vht_cap;
+} __packed;
+
+struct nxpwifi_ie_types_aid {
+	struct nxpwifi_ie_types_header header;
+	__le16 aid;
+} __packed;
+
+struct nxpwifi_ie_types_oper_mode_ntf {
+	struct nxpwifi_ie_types_header header;
+	u8 oper_mode;
+} __packed;
+
+/* VHT Operations element */
+struct nxpwifi_ie_types_vht_oper {
+	struct nxpwifi_ie_types_header header;
+	u8 chan_width;
+	u8 chan_center_freq_1;
+	u8 chan_center_freq_2;
+	/* Basic MCS set map, each 2 bits stands for a NSS */
+	__le16 basic_mcs_map;
+} __packed;
+
+struct nxpwifi_ie_types_wmmcap {
+	struct nxpwifi_ie_types_header header;
+	struct nxpwifi_types_wmm_info wmm_info;
+} __packed;
+
+struct nxpwifi_ie_types_htinfo {
+	struct nxpwifi_ie_types_header header;
+	struct ieee80211_ht_operation ht_oper;
+} __packed;
+
+struct nxpwifi_ie_types_2040bssco {
+	struct nxpwifi_ie_types_header header;
+	u8 bss_co_2040;
+} __packed;
+
+struct nxpwifi_ie_types_extcap {
+	struct nxpwifi_ie_types_header header;
+	u8 ext_capab[];
+} __packed;
+
+struct host_cmd_ds_mem_access {
+	__le16 action;
+	__le16 reserved;
+	__le32 addr;
+	__le32 value;
+} __packed;
+
+struct nxpwifi_ie_types_qos_info {
+	struct nxpwifi_ie_types_header header;
+	u8 qos_info;
+} __packed;
+
+struct host_cmd_ds_mac_reg_access {
+	__le16 action;
+	__le16 offset;
+	__le32 value;
+} __packed;
+
+struct host_cmd_ds_bbp_reg_access {
+	__le16 action;
+	__le16 offset;
+	u8 value;
+	u8 reserved[3];
+} __packed;
+
+struct host_cmd_ds_rf_reg_access {
+	__le16 action;
+	__le16 offset;
+	u8 value;
+	u8 reserved[3];
+} __packed;
+
+struct host_cmd_ds_pmic_reg_access {
+	__le16 action;
+	__le16 offset;
+	u8 value;
+	u8 reserved[3];
+} __packed;
+
+struct host_cmd_ds_802_11_eeprom_access {
+	__le16 action;
+
+	__le16 offset;
+	__le16 byte_count;
+	u8 value;
+} __packed;
+
+struct nxpwifi_assoc_event {
+	u8 sta_addr[ETH_ALEN];
+	__le16 type;
+	__le16 len;
+	__le16 frame_control;
+	__le16 cap_info;
+	__le16 listen_interval;
+	u8 data[];
+} __packed;
+
+struct host_cmd_ds_sys_config {
+	__le16 action;
+	u8 tlv[];
+};
+
+struct host_cmd_11ac_vht_cfg {
+	__le16 action;
+	u8 band_config;
+	u8 misc_config;
+	__le32 cap_info;
+	__le32 mcs_tx_set;
+	__le32 mcs_rx_set;
+} __packed;
+
+struct host_cmd_tlv_akmp {
+	struct nxpwifi_ie_types_header header;
+	__le16 key_mgmt;
+	__le16 key_mgmt_operation;
+} __packed;
+
+struct host_cmd_tlv_pwk_cipher {
+	struct nxpwifi_ie_types_header header;
+	__le16 proto;
+	u8 cipher;
+	u8 reserved;
+} __packed;
+
+struct host_cmd_tlv_gwk_cipher {
+	struct nxpwifi_ie_types_header header;
+	u8 cipher;
+	u8 reserved;
+} __packed;
+
+struct host_cmd_tlv_passphrase {
+	struct nxpwifi_ie_types_header header;
+	u8 passphrase[];
+} __packed;
+
+struct host_cmd_tlv_wep_key {
+	struct nxpwifi_ie_types_header header;
+	u8 key_index;
+	u8 is_default;
+	u8 key[];
+};
+
+struct host_cmd_tlv_auth_type {
+	struct nxpwifi_ie_types_header header;
+	u8 auth_type;
+	u8 pwe_derivation;
+	u8 transition_disable;
+} __packed;
+
+struct host_cmd_tlv_encrypt_protocol {
+	struct nxpwifi_ie_types_header header;
+	__le16 proto;
+} __packed;
+
+struct host_cmd_tlv_ssid {
+	struct nxpwifi_ie_types_header header;
+	u8 ssid[];
+} __packed;
+
+struct host_cmd_tlv_rates {
+	struct nxpwifi_ie_types_header header;
+	u8 rates[];
+} __packed;
+
+struct nxpwifi_ie_types_bssid_list {
+	struct nxpwifi_ie_types_header header;
+	u8 bssid[ETH_ALEN];
+} __packed;
+
+struct host_cmd_tlv_bcast_ssid {
+	struct nxpwifi_ie_types_header header;
+	u8 bcast_ctl;
+} __packed;
+
+struct host_cmd_tlv_beacon_period {
+	struct nxpwifi_ie_types_header header;
+	__le16 period;
+} __packed;
+
+struct host_cmd_tlv_dtim_period {
+	struct nxpwifi_ie_types_header header;
+	u8 period;
+} __packed;
+
+struct host_cmd_tlv_frag_threshold {
+	struct nxpwifi_ie_types_header header;
+	__le16 frag_thr;
+} __packed;
+
+struct host_cmd_tlv_rts_threshold {
+	struct nxpwifi_ie_types_header header;
+	__le16 rts_thr;
+} __packed;
+
+struct host_cmd_tlv_retry_limit {
+	struct nxpwifi_ie_types_header header;
+	u8 limit;
+} __packed;
+
+struct host_cmd_tlv_mac_addr {
+	struct nxpwifi_ie_types_header header;
+	u8 mac_addr[ETH_ALEN];
+} __packed;
+
+struct host_cmd_tlv_channel_band {
+	struct nxpwifi_ie_types_header header;
+	u8 band_config;
+	u8 channel;
+} __packed;
+
+struct host_cmd_tlv_ageout_timer {
+	struct nxpwifi_ie_types_header header;
+	__le32 sta_ao_timer;
+} __packed;
+
+struct host_cmd_tlv_power_constraint {
+	struct nxpwifi_ie_types_header header;
+	u8 constraint;
+} __packed;
+
+struct nxpwifi_ie_types_btcoex_scan_time {
+	struct nxpwifi_ie_types_header header;
+	u8 coex_scan;
+	u8 reserved;
+	__le16 min_scan_time;
+	__le16 max_scan_time;
+} __packed;
+
+struct nxpwifi_ie_types_btcoex_aggr_win_size {
+	struct nxpwifi_ie_types_header header;
+	u8 coex_win_size;
+	u8 tx_win_size;
+	u8 rx_win_size;
+	u8 reserved;
+} __packed;
+
+struct nxpwifi_ie_types_robust_coex {
+	struct nxpwifi_ie_types_header header;
+	__le32 mode;
+} __packed;
+
+#define NXPWIFI_VERSION_STR_LENGTH  128
+
+struct host_cmd_ds_version_ext {
+	u8 version_str_sel;
+	char version_str[NXPWIFI_VERSION_STR_LENGTH];
+} __packed;
+
+struct host_cmd_ds_mgmt_frame_reg {
+	__le16 action;
+	__le32 mask;
+} __packed;
+
+struct host_cmd_ds_remain_on_chan {
+	__le16 action;
+	u8 status;
+	u8 reserved;
+	u8 band_cfg;
+	u8 channel;
+	__le32 duration;
+} __packed;
+
+struct host_cmd_ds_802_11_ibss_status {
+	__le16 action;
+	__le16 enable;
+	u8 bssid[ETH_ALEN];
+	__le16 beacon_interval;
+	__le16 atim_window;
+	__le16 use_g_rate_protect;
+} __packed;
+
+struct nxpwifi_fw_mef_entry {
+	u8 mode;
+	u8 action;
+	__le16 exprsize;
+	u8 expr[];
+} __packed;
+
+struct host_cmd_ds_mef_cfg {
+	__le32 criteria;
+	__le16 num_entries;
+	u8 mef_entry_data[];
+} __packed;
+
+#define CONNECTION_TYPE_INFRA   0
+#define CONNECTION_TYPE_AP      2
+
+struct host_cmd_ds_set_bss_mode {
+	u8 con_type;
+} __packed;
+
+struct host_cmd_ds_pcie_details {
+	/* TX buffer descriptor ring address */
+	__le32 txbd_addr_lo;
+	__le32 txbd_addr_hi;
+	/* TX buffer descriptor ring count */
+	__le32 txbd_count;
+
+	/* RX buffer descriptor ring address */
+	__le32 rxbd_addr_lo;
+	__le32 rxbd_addr_hi;
+	/* RX buffer descriptor ring count */
+	__le32 rxbd_count;
+
+	/* Event buffer descriptor ring address */
+	__le32 evtbd_addr_lo;
+	__le32 evtbd_addr_hi;
+	/* Event buffer descriptor ring count */
+	__le32 evtbd_count;
+
+	/* Sleep cookie buffer physical address */
+	__le32 sleep_cookie_addr_lo;
+	__le32 sleep_cookie_addr_hi;
+} __packed;
+
+struct nxpwifi_ie_types_rssi_threshold {
+	struct nxpwifi_ie_types_header header;
+	u8 abs_value;
+	u8 evt_freq;
+} __packed;
+
+#define NXPWIFI_DFS_REC_HDR_LEN		8
+#define NXPWIFI_DFS_REC_HDR_NUM		10
+#define NXPWIFI_BIN_COUNTER_LEN		7
+
+struct nxpwifi_radar_det_event {
+	__le32 detect_count;
+	u8 reg_domain;  /*1=fcc, 2=etsi, 3=mic*/
+	u8 det_type;  /*0=none, 1=pw(chirp), 2=pri(radar)*/
+	__le16 pw_chirp_type;
+	u8 pw_chirp_idx;
+	u8 pw_value;
+	u8 pri_radar_type;
+	u8 pri_bincnt;
+	u8 bin_counter[NXPWIFI_BIN_COUNTER_LEN];
+	u8 num_dfs_records;
+	u8 dfs_record_hdr[NXPWIFI_DFS_REC_HDR_NUM][NXPWIFI_DFS_REC_HDR_LEN];
+	__le32 passed;
+} __packed;
+
+struct nxpwifi_ie_types_multi_chan_info {
+	struct nxpwifi_ie_types_header header;
+	__le16 status;
+	u8 tlv_buffer[];
+} __packed;
+
+struct nxpwifi_ie_types_mc_group_info {
+	struct nxpwifi_ie_types_header header;
+	u8 chan_group_id;
+	u8 chan_buf_weight;
+	u8 band_config;
+	u8 chan_num;
+	__le32 chan_time;
+	__le32 reserved;
+	union {
+		u8 sdio_func_num;
+		u8 usb_ep_num;
+	} hid_num;
+	u8 intf_num;
+	u8 bss_type_numlist[];
+} __packed;
+
+#define MEAS_RPT_MAP_RADAR_MASK		0x08
+#define MEAS_RPT_MAP_RADAR_SHIFT_BIT	3
+
+struct nxpwifi_ie_types_chan_rpt_data {
+	struct nxpwifi_ie_types_header header;
+	u8 meas_rpt_map;
+} __packed;
+
+struct host_cmd_ds_802_11_subsc_evt {
+	__le16 action;
+	__le16 events;
+} __packed;
+
+struct chan_switch_result {
+	u8 cur_chan;
+	u8 status;
+	u8 reason;
+} __packed;
+
+struct nxpwifi_ie {
+	__le16 ie_index;
+	__le16 mgmt_subtype_mask;
+	__le16 ie_length;
+	u8 ie_buffer[IEEE_MAX_IE_SIZE];
+} __packed;
+
+#define MAX_MGMT_IE_INDEX	16
+struct nxpwifi_ie_list {
+	__le16 type;
+	__le16 len;
+	struct nxpwifi_ie ie_list[MAX_MGMT_IE_INDEX];
+} __packed;
+
+struct coalesce_filt_field_param {
+	u8 operation;
+	u8 operand_len;
+	__le16 offset;
+	u8 operand_byte_stream[4];
+};
+
+struct coalesce_receive_filt_rule {
+	struct nxpwifi_ie_types_header header;
+	u8 num_of_fields;
+	u8 pkt_type;
+	__le16 max_coalescing_delay;
+	struct coalesce_filt_field_param params[];
+} __packed;
+
+struct host_cmd_ds_coalesce_cfg {
+	__le16 action;
+	__le16 num_of_rules;
+	u8 rule_data[];
+} __packed;
+
+struct host_cmd_ds_multi_chan_policy {
+	__le16 action;
+	__le16 policy;
+} __packed;
+
+struct host_cmd_ds_robust_coex {
+	__le16 action;
+	__le16 reserved;
+} __packed;
+
+struct host_cmd_ds_wakeup_reason {
+	__le16  wakeup_reason;
+} __packed;
+
+struct host_cmd_ds_gtk_rekey_params {
+	__le16 action;
+	u8 kck[NL80211_KCK_LEN];
+	u8 kek[NL80211_KEK_LEN];
+	__le32 replay_ctr_low;
+	__le32 replay_ctr_high;
+} __packed;
+
+struct host_cmd_ds_chan_region_cfg {
+	__le16 action;
+} __packed;
+
+struct host_cmd_ds_pkt_aggr_ctrl {
+	__le16 action;
+	__le16 enable;
+	__le16 tx_aggr_max_size;
+	__le16 tx_aggr_max_num;
+	__le16 tx_aggr_align;
+} __packed;
+
+struct host_cmd_ds_sta_configure {
+	__le16 action;
+	u8 tlv_buffer[];
+} __packed;
+
+struct nxpwifi_ie_types_sta_flag {
+	struct nxpwifi_ie_types_header header;
+	__le32 sta_flags;
+} __packed;
+
+struct host_cmd_ds_add_station {
+	__le16 action;
+	__le16 aid;
+	u8 peer_mac[ETH_ALEN];
+	__le32 listen_interval;
+	__le16 cap_info;
+	u8 tlv[];
+} __packed;
+
+struct host_cmd_11ax_cfg {
+	__le16 action;
+	u8 band_config;
+	u8 tlv[];
+} __packed;
+
+struct host_cmd_11ax_cmd {
+	__le16 action;
+	__le16 sub_id;
+	u8 val[];
+} __packed;
+
+struct nxpwifi_802_11_net_monitor {
+	u32 enable_net_mon;
+	u32 filter_flag;
+	u32 band;
+	u32 channel;
+	u32 chan_bandwidth;
+};
+
+struct band_config {
+	/* Band: 00=2.4, 01=5, 10=6 GHz */
+	u8 chan_band : 2;
+	/* Width: 00=20, 10=40, 11=80 MHz */
+	u8 chan_width : 2;
+	/* Sec offset: 00=None, 01=Above, 11=Below */
+	u8 chan_2O_ffset : 2;
+	/* Chan sel: 00=manual, 01=ACS, 02=Adoption */
+	u8 scan_mode : 2;
+} __packed;
+
+struct chan_band_param {
+	struct band_config band_cfg;
+	u8 chan_number;
+} __packed;
+
+struct nxpwifi_ie_types_chan_band_list {
+	struct nxpwifi_ie_types_header header;
+	struct chan_band_param chan_band_param[];
+} __packed;
+
+struct host_cmd_ds_802_11_net_monitor {
+	__le16 action;
+	__le16 enable_net_mon;
+	__le16 filter_flag;
+	struct nxpwifi_ie_types_chan_band_list monitor_chan;
+} __packed;
+
+struct host_cmd_twt_cfg {
+	__le16 action;
+	__le16 sub_id;
+	u8 val[];
+} __packed;
+
+struct host_cmd_ds_command {
+	__le16 command;
+	__le16 size;
+	__le16 seq_num;
+	__le16 result;
+	union {
+		struct host_cmd_ds_get_hw_spec hw_spec;
+		struct host_cmd_ds_mac_control mac_ctrl;
+		struct host_cmd_ds_802_11_mac_address mac_addr;
+		struct host_cmd_ds_mac_multicast_adr mc_addr;
+		struct host_cmd_ds_802_11_get_log get_log;
+		struct host_cmd_ds_802_11_rssi_info rssi_info;
+		struct host_cmd_ds_802_11_rssi_info_rsp rssi_info_rsp;
+		struct host_cmd_ds_802_11_snmp_mib smib;
+		struct host_cmd_ds_tx_rate_query tx_rate;
+		struct host_cmd_ds_tx_rate_cfg tx_rate_cfg;
+		struct host_cmd_ds_txpwr_cfg txp_cfg;
+		struct host_cmd_ds_rf_tx_pwr txp;
+		struct host_cmd_ds_rf_ant_mimo ant_mimo;
+		struct host_cmd_ds_rf_ant_siso ant_siso;
+		struct host_cmd_ds_802_11_ps_mode_enh psmode_enh;
+		struct host_cmd_ds_802_11_hs_cfg_enh opt_hs_cfg;
+		struct host_cmd_ds_802_11_scan scan;
+		struct host_cmd_ds_802_11_scan_ext ext_scan;
+		struct host_cmd_ds_802_11_scan_rsp scan_resp;
+		struct host_cmd_ds_802_11_bg_scan_config bg_scan_config;
+		struct host_cmd_ds_802_11_bg_scan_query bg_scan_query;
+		struct host_cmd_ds_802_11_bg_scan_query_rsp bg_scan_query_resp;
+		struct host_cmd_ds_802_11_associate associate;
+		struct host_cmd_ds_802_11_associate_rsp associate_rsp;
+		struct host_cmd_ds_802_11_deauthenticate deauth;
+		struct host_cmd_ds_802_11d_domain_info domain_info;
+		struct host_cmd_ds_802_11d_domain_info_rsp domain_info_resp;
+		struct host_cmd_ds_11n_addba_req add_ba_req;
+		struct host_cmd_ds_11n_addba_rsp add_ba_rsp;
+		struct host_cmd_ds_11n_delba del_ba;
+		struct host_cmd_ds_txbuf_cfg tx_buf;
+		struct host_cmd_ds_amsdu_aggr_ctrl amsdu_aggr_ctrl;
+		struct host_cmd_ds_11n_cfg htcfg;
+		struct host_cmd_ds_wmm_get_status get_wmm_status;
+		struct host_cmd_ds_802_11_key_material key_material;
+		struct host_cmd_ds_version_ext verext;
+		struct host_cmd_ds_mgmt_frame_reg reg_mask;
+		struct host_cmd_ds_remain_on_chan roc_cfg;
+		struct host_cmd_ds_802_11_ibss_status ibss_coalescing;
+		struct host_cmd_ds_mef_cfg mef_cfg;
+		struct host_cmd_ds_mem_access mem;
+		struct host_cmd_ds_mac_reg_access mac_reg;
+		struct host_cmd_ds_bbp_reg_access bbp_reg;
+		struct host_cmd_ds_rf_reg_access rf_reg;
+		struct host_cmd_ds_pmic_reg_access pmic_reg;
+		struct host_cmd_ds_set_bss_mode bss_mode;
+		struct host_cmd_ds_pcie_details pcie_host_spec;
+		struct host_cmd_ds_802_11_eeprom_access eeprom;
+		struct host_cmd_ds_802_11_subsc_evt subsc_evt;
+		struct host_cmd_ds_sys_config uap_sys_config;
+		struct host_cmd_ds_sta_deauth sta_deauth;
+		struct host_cmd_ds_sta_list sta_list;
+		struct host_cmd_11ac_vht_cfg vht_cfg;
+		struct host_cmd_ds_coalesce_cfg coalesce_cfg;
+		struct host_cmd_ds_chan_rpt_req chan_rpt_req;
+		struct host_cmd_sdio_sp_rx_aggr_cfg sdio_rx_aggr_cfg;
+		struct host_cmd_ds_multi_chan_policy mc_policy;
+		struct host_cmd_ds_robust_coex coex;
+		struct host_cmd_ds_wakeup_reason hs_wakeup_reason;
+		struct host_cmd_ds_gtk_rekey_params rekey;
+		struct host_cmd_ds_chan_region_cfg reg_cfg;
+		struct host_cmd_ds_pkt_aggr_ctrl pkt_aggr_ctrl;
+		struct host_cmd_ds_sta_configure sta_cfg;
+		struct host_cmd_ds_add_station sta_info;
+		struct host_cmd_11ax_cfg ax_cfg;
+		struct host_cmd_11ax_cmd ax_cmd;
+		struct host_cmd_ds_802_11_net_monitor net_mon;
+		struct host_cmd_twt_cfg twt_cfg;
+	} params;
+} __packed;
+
+struct nxpwifi_opt_sleep_confirm {
+	__le16 command;
+	__le16 size;
+	__le16 seq_num;
+	__le16 result;
+	__le16 action;
+	__le16 resp_ctrl;
+} __packed;
+
+#define VDLL_IND_TYPE_REQ		0
+#define VDLL_IND_TYPE_OFFSET		1
+#define VDLL_IND_TYPE_ERR_SIG		2
+#define VDLL_IND_TYPE_ERR_ID		3
+#define VDLL_IND_TYPE_SEC_ERR_ID	4
+#define VDLL_IND_TYPE_INTF_RESET	5
+
+struct vdll_ind_event {
+	__le16 type;
+	__le16 vdll_id;
+	__le32 offset;
+	__le16 block_len;
+} __packed;
+#endif /* !_NXPWIFI_FW_H_ */
-- 
2.34.1


