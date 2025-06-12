Return-Path: <linux-wireless+bounces-24026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2059AAD656E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 04:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3213AC78E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 02:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883FD22094;
	Thu, 12 Jun 2025 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MaxfQTMI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013067.outbound.protection.outlook.com [52.101.127.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5E63A9;
	Thu, 12 Jun 2025 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694520; cv=fail; b=AScEKbYJwTFsidynPeF0RqVx+3AP0TY8cqk0niir11DewnSCLGb7BvnwZaRa4zQxw3jrPNodP2q7i0aVklJQTEGfN1Ech/uPnOPhD1xm3DwCAdb1S7nSI/dPnulJG6JertkBOxubh+oOZTKMOb2HRXvRNwrsDFptD8tO3e8RT08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694520; c=relaxed/simple;
	bh=XABKpFdXDoCQ8s55q9JfKvnPcHMqcVbIFGSbIVd/lUs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zwno2CmK6F5Rpj/m6d0wUOBpLPwscKv5Pm5YKZ0mbb+uC2R11s1RVzdhaBP0x3J8mG9H/ISAIIqvkWrcisQ4QLb9Gb5jthop0ZmUA4Qu2QP4SNBRzZbYK+pJPuP5DMuvWkERYxGafAjZ+HkoXoW1fSYZnWfog3XoJuSd1AiGSv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MaxfQTMI; arc=fail smtp.client-ip=52.101.127.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgJF91VuSDNrSS0yIt8AxVKNBQc0fF0Ku8TuL9BbFnQQHiY21cHs3lwEqyYVaO+kpp7soSDW6xuXlYGH19jaS8qSxu6fcBLHGOtTOk846CUTwWvecP54G+YTx8dL3HRvxwInEfiZicReAQkV7W0YHyuDNUN+0QC0lUNJRmJUv98ALBxSUGKOeeOm6KVEp0MKSv9V0va+7fpOjWGBREsl5rGS6xresLEkJaPDY8eyuuqZdYzrdKGW5nCAdTiReNtP9nXchLzjG/0BiLBf/bYw/DbI+f3e2GuWgn6v77MeeFMwuYTXEmgmcE0d8+iU0uHhgfwsqw0kznSgA5YEJVoE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgEZOZNRNZoTHu24wJ8XbOP1cBs+fhd5IesxDOAL3m4=;
 b=fL83yTj8Gcp0B/u+AhGtLKQZVAzwksAnKItcW8VmWt2dG14nKQZJcIzTKgsY8/Y5YILSRsLCk9d22yLA/Oe6+e6yPto5sMDVJ/3/IOwQjOk3PBL0thGxPsm35uo11bNn8ipPyG1MY/qNcpOnhyb2+QQpQdk+Au/BbPD6kFHSeRfDkMnSVWaD1AlXPX/iXkuYXak2HJORDOvJ84C7Z6mRVYMNlNqYk3HsrPso9c6gWwDOkTpyYt43VcUoyudMTLQbkm3FSmmuvY7+iiWmw+H6HjRO+Nn98BEItcIM+WbSiO9TVpkGtycVUh1AksTjO2hKd2XMCEWFULBg43IVFH6pJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgEZOZNRNZoTHu24wJ8XbOP1cBs+fhd5IesxDOAL3m4=;
 b=MaxfQTMICo60D0cQrahcPHUOMN6z2kHPSrtrFG0ymAiuzeUqbUu3KP05MsA5lh7qTLOKvejTYXgMbAGxfGeuGXRQB+TeOVESnXut9l4sh3JLF0bRIjeoMRzuVxhHid9skFUPU+opGWqZs8T+qjS6J6QB9krM361kSvg2CMQhGLyj1NVYOUTByr9EhqnFsJ7SV1AdIsPmCxkzpH/U3uX3RlkHjMWlVjTIPkiBxbozZSU3ywrGQzJbSQcFWQTRQrsdH+FhwLWvT+eIfwQdDv4onR3pKtFViZUKUAVEXI4sztfme64F+WrSey41W8b/ywoHedGGkNZHWTIbPW4fs24CCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com (2603:1096:4:169::8) by
 SEYPR06MB8002.apcprd06.prod.outlook.com (2603:1096:101:2d8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.27; Thu, 12 Jun 2025 02:15:13 +0000
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349]) by SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349%3]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 02:15:11 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] wifi: iwlegacy: convert to use secs_to_jiffies()
Date: Thu, 12 Jun 2025 10:14:44 +0800
Message-Id: <20250612021446.3465972-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To SG2PR06MB4802.apcprd06.prod.outlook.com
 (2603:1096:4:169::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB4802:EE_|SEYPR06MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: d25116ac-c7ff-4585-6755-08dda956f552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NTOxCmFupHH62m0ieM56CLtfoheUJ5Lr9ebsbbcNKXDMBk9DibQy2QhlpRLn?=
 =?us-ascii?Q?pNVM5cyNnQNZnT/5M6285PruTg3bmzu2gdXiH1otGKTACk3LgvP/aKpZBGC2?=
 =?us-ascii?Q?8P9sPGGCQVOc3uCbhAV9eivHjAfFQdhBLdBNv5YQV8I1QqKyFWAzYq7NFiU1?=
 =?us-ascii?Q?4gJHUmeND+4FpaKLePhpEC83uQ5HVvh4hitDMBpKmgcuMBKUUOnzYeCxNUbB?=
 =?us-ascii?Q?a3y06spyRsx7MEmQXxkQD4Yh/OI09cM5bq3BZurMA5k7gSNu8OAUPlRTVhQ1?=
 =?us-ascii?Q?U3ag/KG5jqonxlu94FWUlIE6iJVNibH+4No53IhRr7BAVjF2VD1apSCnkK8k?=
 =?us-ascii?Q?8D7Jmq4dSir+0aHr5uhIgV0xUwOInLGmDl8nz74enMZBpE52Bw6tZ4oJDBR7?=
 =?us-ascii?Q?EGEv2XmjtlqJjzGEaG+nkTA6KLPJq5edvQuwvt6qWVQp2AZsdXZ5L6/HME+t?=
 =?us-ascii?Q?edEFSVE53nuAQIAz4deJPM6OFxf2fT5u/mN1LtgrI3YHtJSZyKEZN4ccNqrL?=
 =?us-ascii?Q?uLgMx1nXnLVPck1WQIuPAyohAE0jR/KguTi0Y1G8i5tAE9yb3mGYUiUdmjjL?=
 =?us-ascii?Q?G9w2dY93QMOwLMRcmjWldQRt1OF++Fh56wy9sGiOyzUZJKAJMtudFnHFkbfe?=
 =?us-ascii?Q?SD3lv5MWRsVOp7UgsMo/2oU3nSzvsj3dzMxbnNfqYgylfSNIFU2u6NfkfAgc?=
 =?us-ascii?Q?Sg4kNximeqtH5Xfs07ReHYhCaPR57mLoOJV8XZXBtmwwVdL8hIjdDki1XAe7?=
 =?us-ascii?Q?RNiL5om/7m3KX7UT2Ar0PDGRRQL2UDSqks4iFJCijxUmBAwrzKQ1TRY4Z3UZ?=
 =?us-ascii?Q?3Iqq5dNv6n6Ekw0UpBE9QtdJ9KEWAQX9h2Jl09TW5D97pK7kK+em+YXpclS9?=
 =?us-ascii?Q?v7Hkvm9NyRp7hvWocpG3BY6dz5cQgDGldt6qxLmFbKOfA9pA0MH1BAQYA1qX?=
 =?us-ascii?Q?cTnq3DqlPn6S6i/J1UTZWHFxSSCJCmqWeJtYcB5rlno7CsLMSqR8ZkrEt1Ha?=
 =?us-ascii?Q?NBkdRFsb9xzJlgJ1uNIDS5ZzdIB/hFODvXYbAS70SWNoLDAV+BUO9UVa5QJR?=
 =?us-ascii?Q?CCU634kRWJfPcH+4iJtRqIlJ8BmEo4fAAM132jaUX84Bed0IgOVRawU6WxoH?=
 =?us-ascii?Q?4m+5hZSRiug1q+FX6n9hvQustSn+itoYwutT/CYN/wDPAZ5FooHMmtWoMe78?=
 =?us-ascii?Q?CycekyRUcALePk6Yv9+b8j7Q5ofZFUmpD3xG5bb9k6g0iVb3ffe2MF9jj77e?=
 =?us-ascii?Q?RMu8OddAtjzlXcW6Iq3M2NOKRNqMnioJDlSOjTBO0Mkj1eygk8Tcmr7zEdLQ?=
 =?us-ascii?Q?A8ros8Zj7ZIQG8jwW90ygEr6vzOZ0tOacFvRtpQ/4RuON7i+s0ergIksNI8G?=
 =?us-ascii?Q?lMQ8RuCCSX56ole25ViWmCKux6v56KprfCffBgxYirKAcKoic/ikp4ScJWI7?=
 =?us-ascii?Q?jGxB7yzZdgLpNErZ2bD0ldpwFpmIEuLZYZ3tSocSRiBq3T+MewnzbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB4802.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ywXl2Drlum8ZYX3YZ8Jz1k/thejUu+GlLnhPeI5VtumitKqBIRdYeFGGMsOA?=
 =?us-ascii?Q?pa8czQ12HI08IANFsrKEIh/UKnaSK9zWs3A3lJg23Ajruk4i3YIV8HuP7ZnB?=
 =?us-ascii?Q?sM5aj7uNiGnj8g72aCx0+De4OIX48NKHBRej49v187/fthIB3Tk++/KcJXHK?=
 =?us-ascii?Q?LmPbLMFcRTz0km/hE8w8n/KcLeURk/fhcKCnsxRQyL3fn8ezonfCp6as/K60?=
 =?us-ascii?Q?uUkUp6U4whx3WqBxik6Sqrr3rUWP8PiwQJ4er6eWw6uzGMM88/hKr1mFP+YW?=
 =?us-ascii?Q?6nKF95qMH6sVTpeECuBxX5EIFsSsgF3NmR9bs6vbolCVmDCkCDr1f38yE9fh?=
 =?us-ascii?Q?rhxoBKSUQAyyIAfsK4u9ldnxlTU9UJOMOHkxAiJ5nZIQScvckWI7UTWeIc4J?=
 =?us-ascii?Q?k8MBuiY/yLAcCjjBM2J4B3InI2ZJuhPgztsuftp6qoKGNmKuA9V8edOahm8b?=
 =?us-ascii?Q?RHYxui62qydhZD+/ANh42KeOGGBD33wSULapbTRjkrC31s1vKaM1GMDjJKxY?=
 =?us-ascii?Q?pkAAVoidlQ2XY0X+JiDlttiLWYj/zNY1i05WMvGOdiejwmdUV6kLOiX+W0hV?=
 =?us-ascii?Q?59zcCCop03HwftDXFOUKhvJgVmeSWCEENANDSGDLrp5hxBJJOgXXfM2bKjZL?=
 =?us-ascii?Q?lixEJh9W99cI5RCdL/njPXNOeHZ4R/gEojp69Mi2Pi0uaDNg3HNuAy9wZdJL?=
 =?us-ascii?Q?Mh6Gh7lbcH+2Xcrh8NupVhJP23kD/U8YLPVidjTX2irra4CAKaHvg9DOIyeW?=
 =?us-ascii?Q?jF//V4xsKw6QDLNdPWB/9/oiOaCGPApBnKqJFQ/1r4xapLdLWBrE3lJLIP4Z?=
 =?us-ascii?Q?o2/H1SD8Fsj/pxoZz7GcGG7lr7+Zp93Rrb60Iv0W+BN2F2ydxdPPVoMZrKM4?=
 =?us-ascii?Q?ugDnFojo9qXW806NFCj/WUs6zlO3Pni6rqyXSNe9MhNj0G1aDKLhSn5JXvpO?=
 =?us-ascii?Q?FalDbvi+y3q3nxejmb8/3yLmHa9MqEmpIMkpmGDZNqfO+aUr50WMFHFGVOdh?=
 =?us-ascii?Q?ckZozfJ080mYwWFS758nWnIg4BculMFzAxsEsVUtQTOXR0PV3Gpj43j9spGn?=
 =?us-ascii?Q?QZfIUZp4Zw3VJTE6sSnc5UpXDv0hUKwa5S6gt/f0JfUTjgDf2zYYSBSNWqdw?=
 =?us-ascii?Q?CRrc4bvicz+hjHnt4QGEo0FDqxLaONgEQcoDZ7hrgFLxk+Og22O1xXAfjxCh?=
 =?us-ascii?Q?ruLLb02h+JES09U6EuNXLz62Gta/mYEKGn4nNDIFy3Vxxqcnb/NWvlmdDCA+?=
 =?us-ascii?Q?H3EGZUeu8EO2PClRwA6P7oKjO3unuNVhthG66W2oGw3XK+s8CSePzfEqzUI9?=
 =?us-ascii?Q?Q8KnyCDQ+En/vgHGE25l69OHNn4NVoaT0571aajuPcN3DUlFlZYoCjcZi0k7?=
 =?us-ascii?Q?mIyipuHG4VjFCmcb74b/Tnnx9ykqLLl9ig4MimI+Mhq4vUnrv3PN/zwGCFfW?=
 =?us-ascii?Q?XeAPNKaoiu6g6M5UJMV2T3QTtLGpYcDk4UQQ4sE5Iqww0wybEUP6NvumfFUG?=
 =?us-ascii?Q?6CKuylvmCj0+ZT2coIbuBNC32pM3sBH+Sl9HViAQGaismigdOPNt781ix1tl?=
 =?us-ascii?Q?YmZ7UXEtnqdo7iuUt9/3c7dNVsTtSPSw2/WkaC5k?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25116ac-c7ff-4585-6755-08dda956f552
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB4802.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 02:15:10.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vX4MkNIKou/VWU2riBTqW2nDCJhonOxr7HRTPaw63quXJWH/qzRf4rHv8pMlf3Uac86RYqL0PMKRNv/QhaKJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8002

Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
use it to avoid scaling the time to msec.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 8e58e97a148f..24a39a968db0 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -1382,7 +1382,7 @@ il4965_hdl_stats(struct il_priv *il, struct il_rx_buf *rxb)
 	 * we get a thermal update even if the uCode doesn't give us one
 	 */
 	mod_timer(&il->stats_periodic,
-		  jiffies + msecs_to_jiffies(recalib_seconds * 1000));
+		  jiffies + secs_to_jiffies(recalib_seconds));
 
 	if (unlikely(!test_bit(S_SCANNING, &il->status)) &&
 	    (pkt->hdr.cmd == N_STATS)) {
-- 
2.34.1


