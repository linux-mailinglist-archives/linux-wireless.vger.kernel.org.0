Return-Path: <linux-wireless+bounces-35212-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHGcGZCf6GkLNgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35212-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 12:14:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F2444871
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 12:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17DFD3082A3F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350723CBE89;
	Wed, 22 Apr 2026 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="mBQvOr3r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023082.outbound.protection.outlook.com [52.101.83.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9BB3CBE78;
	Wed, 22 Apr 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852586; cv=fail; b=NCePHHrhQ+smhH7xGrYvn42+mD28cb4aQEe9bT1mbGN1Tc+dItAecPY0loeXg23ohUTE5yLWG8uwhRUCKfVN9/Uvm/d8yB06Q4WlLt8GCcs+RwGI/H8tGNHKMTedTvj2xx3ajQGWvbq97XBDyjiky9K+XuRZtaHGxQB1HKb3q34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852586; c=relaxed/simple;
	bh=bPvZ/jPKr0jcZK2JuyKc7tPKnIxUa4VWpKyYn9c379M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qv1IHcpBrXXcM0Fk3wJh2TQKZNJIMGSm+UNs4NN7JQJXKJuLRRPZ0XuCoWiIDoRi7THBCFYgzS4kop1tD6x3eH0i67AWGwKtu/p1yOQe+OVOxOWksIN+4gmku/R67iG4ECZL1aEtvrcGeWvlO3RtHUtjJzXWt5YTfzdFqDW9X74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=mBQvOr3r; arc=fail smtp.client-ip=52.101.83.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ22slWFv04MQXuGX7X4epy65hg4ZvHJh2AJJs+B8fDMOEWtU4yjimtizQnTssQNhZGvK1Mgl1g/AmbeL1gE2jEfUJmGJQffKECe22OVR0Q7cjs0swNd50yoY0iZJvSeOum0aVPxrJj+xWOZP8AEy4HvbEkLHdtH0wGhCgeKO8w6vJgimdLhd3x12O80QLJUGqTntoYEQy/MJWRJ2FvxtrBQKOkNHzX9nzNJAtmuTT183YdJDfUSL2ITVcy7cHp+G04RMBK4R0cn4C9dw4HEG51x2byHN3SXZnD7PE1AaY35l5yPtvavtju3O4SDV6sp8OF0BuCbxLf+M+qHpiKEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx69FgFVFkN5cVIxZ+PQDv5WJQ7ttMf3jz5SZ/O8DTg=;
 b=wGBekHAw0pxMEZfJ7yfVymVRJ9ahh+Ifm81+ofjE/i59AhHcfA34oXJ/wQl3Iq7mOr7vX8KK3WyqxhylSs3WDoTt/zFU3vYhKVS7YFeVTyqx75GIz43O8606rFhR7zTDk1WKptzzPyRJzdt14GJXVaVYGPGoBQfWliNBt7Wgg3C3FLoxVV6PGFJ4r+q5VpbweEQpKswwkibPiwQnCyXFDulvo8Gnp/SXhVJcRuv4UJPBHN+j/KclFNmLi/w2ho7PzmFa5O/l2OCtSuhb/zLCh3FEux0Jn8rwRikJ4Z2/WV9ri1+6qkUnhqTqT/mikPRkVwnzuOnCg2YFR2Ib0pJ4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.61.153.67) smtp.rcpttodomain=animalcreek.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx69FgFVFkN5cVIxZ+PQDv5WJQ7ttMf3jz5SZ/O8DTg=;
 b=mBQvOr3rC0X3+Z9qE0nLK/JxeTAdG+Nm3tR13pMgJQzgUp66iZhJpDAGtyRJE1bODfFIcgbiAMlUv1yrEZtYX2+BbX+1qyAOLjugHisL84Uu6vWcSzaoKG6LYju+hYnolb5EXVj9YAVVYQ5Po+Ea5HFtWTapDBYfEnvvV0MgMZA=
Received: from AS9PR05CA0174.eurprd05.prod.outlook.com (2603:10a6:20b:496::6)
 by VI2PR02MB10999.eurprd02.prod.outlook.com (2603:10a6:800:27b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 10:09:36 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:496:cafe::a2) by AS9PR05CA0174.outlook.office365.com
 (2603:10a6:20b:496::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 10:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.61.153.67)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 212.61.153.67 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.61.153.67;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (212.61.153.67) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 10:09:36 +0000
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 22 Apr
 2026 12:09:35 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1748.39
 via Frontend Transport; Wed, 22 Apr 2026 12:09:35 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1wFUWV-002RiT-0S;
	Wed, 22 Apr 2026 12:09:35 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <mgreer@animalcreek.com>, <sameo@linux.intel.com>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <martijn.de.gouw@prodrive-technologies.com>, Paul Geurts
	<paul.geurts@prodrive-technologies.com>
Subject: [PATCH] NFC: trf7970a: Ignore antenna noise when checking for RF field
Date: Wed, 22 Apr 2026 12:09:30 +0200
Message-ID: <20260422100930.581237-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|VI2PR02MB10999:EE_
X-MS-Office365-Filtering-Correlation-Id: b05fa4d7-3d42-4b82-14c5-08dea05741e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AQGCjCb0cFu/XR9/Kkb6mJkSBTXwM3Ot73fjtc80RXskgLUC1Z3zmCdJpaxdH44rG3UyTORDxk2DR6d7S7DkKhbu1OQDRJNRrRxOqsnFED03nF1fFzfr+2Qv/E+teSYq/3wgaZM50gztDsftRaSd43YaSTQ27kzhieS/Aj20hKjH3sQT529N/V8rjLZ5qQDLQrbRIYOSyaaroQWVSjAUL4OM0C6SjDRytWRs/5h+eogaCXR4T8WwEj/8/YS0mA1w8ciOOKx+Clpq0J0ScK2u2kfi34xj+cRQNXeHSjpioKzphCV7abrH6waHqKfYjVcJAIO2attb+Htsdi4l0NHJr826nSYIxwyPsP/9TEPEvGjoOigTo8wAAq1rbgEp1vL2aHzoSVty+r9GfCrQOji/DxJfJJQwsrsntMUim/VvegUSwAwCtxlb0yA+O2e++Ov4svuwttziF5H+l2Y4rAEKbxgRziYZx6tVX1ADRux39z1pIM6egU3sk8UL+WKFztJmzB7uEpcHymYEXh03vsjWjGwJLkZroYBBinNrixrmTxjQ55qAtSdh5HWFJ/gLOM5t05WS5df31BMdszU7j/spUg+6H4CbIay3WhFqChlxwLsZ/6OEarlyuYit9a3Kalhq7++Tkr0biwJ9UR+2rV55WXKTvO9dfq31yOOJHLPoCKW1emn8Rfe6RZU816YyqLBZYw/iM1g9blpAd95bD4La/GNqiV0AY1mKbLGstDJw6XVyKkuk/n4dfXkWN6/PgMHuCrFEEx0JRRp3YQTXI8ptKw==
X-Forefront-Antispam-Report:
	CIP:212.61.153.67;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:webmail.prodrive.nl;PTR:mail.prodrive-technologies.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yessdqGPVb1BjY2ugm8Mm8RI6FXwjq19Gga9qUxEvP+PZ6OUb3oNYsXnrK4KmH5UsrHCpErWW2WZuoqCp1ZufLqx2vB0pSzBm4q1PoDbr13hU9Jm26uQf0WKQU4b8mWTIWFJKfBeNuF1EKrTufUYI2b1v1N1HYkZuqvPn3RlzV112/rrcU/PFiWiRllOhAKX7UFVK27RNyrDyB21kNczYCTzKT2epAzZSPyEnalf1E2xtIlU3hmliRcYAeQEvoQyyU4VcdoVI6aUNyw88YJvqigVJfUBTsWh9B0x7kZ/IMdTnuno7qPlOqzp2S7WuDjRX0YNUpAkFChPChSKsvvuJls1eoY2KGMp4LoMIyjoOi6Gsy5y4LYIhM3GvZ/s7gB+TJ4AgeRiPYPUIBmL36nCV4AXz8Z5VZmECFcUH/y9FtvSyL/LCpp7H5eMbdVNE+P0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:09:36.0224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05fa4d7-3d42-4b82-14c5-08dea05741e0
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[212.61.153.67];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR02MB10999
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[prodrive-technologies.com,reject];
	R_DKIM_ALLOW(-0.20)[prodrive-technologies.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35212-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[prodrive-technologies.com:email,prodrive-technologies.com:dkim,prodrive-technologies.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[prodrive-technologies.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.geurts@prodrive-technologies.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0F7F2444871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The main channel Received Signal Strength Indicator (RSSI) measurement
is used to determine whether an RF field is present or not. RSSI != 0
is interpreted as an RF Field is present. This does not take RF noise
and measurement inaccuracy into account, and results in false positives
in the field.

Define a noise level and make sure the RF field is only interpreted as
present when the RSSI is above the noise level.

Fixes: 851ee3cbf850 ("NFC: trf7970a: Don't turn on RF if there is already an RF field")
Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
---
 drivers/nfc/trf7970a.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index d17c701c7888..08c27bb438b5 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -317,6 +317,7 @@
 #define TRF7970A_RSSI_OSC_STATUS_RSSI_MASK	(BIT(2) | BIT(1) | BIT(0))
 #define TRF7970A_RSSI_OSC_STATUS_RSSI_X_MASK	(BIT(5) | BIT(4) | BIT(3))
 #define TRF7970A_RSSI_OSC_STATUS_RSSI_OSC_OK	BIT(6)
+#define TRF7970A_RSSI_OSC_STATUS_RSSI_NOISE_LEVEL	1
 
 #define TRF7970A_SPECIAL_FCN_REG1_COL_7_6		BIT(0)
 #define TRF7970A_SPECIAL_FCN_REG1_14_ANTICOLL		BIT(1)
@@ -1300,7 +1301,7 @@ static int trf7970a_is_rf_field(struct trf7970a *trf, bool *is_rf_field)
 	if (ret)
 		return ret;
 
-	if (rssi & TRF7970A_RSSI_OSC_STATUS_RSSI_MASK)
+	if ((rssi & TRF7970A_RSSI_OSC_STATUS_RSSI_MASK) > TRF7970A_RSSI_OSC_STATUS_RSSI_NOISE_LEVEL)
 		*is_rf_field = true;
 	else
 		*is_rf_field = false;
-- 
2.39.2


