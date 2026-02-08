Return-Path: <linux-wireless+bounces-31639-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IJvM2t3iGnfpgQAu9opvQ
	(envelope-from <linux-wireless+bounces-31639-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Feb 2026 12:45:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F22CB1088F4
	for <lists+linux-wireless@lfdr.de>; Sun, 08 Feb 2026 12:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67B5330028CF
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Feb 2026 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC329352C20;
	Sun,  8 Feb 2026 11:45:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020095.outbound.protection.outlook.com [52.101.150.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAAC350287
	for <linux-wireless@vger.kernel.org>; Sun,  8 Feb 2026 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770551143; cv=fail; b=fb0MvgVa93A1+vASEoIGI2m4w3I1qlT96Ib5nr5+XlROCGUGGD2aawK63XfRdX4xx6ewEJY35mfSo5iwyPS+eq0vcPfVzHlsD7ph7byEEhGbxaUt34hlzlNg8VGBqQgNvuqG/kVdkXh9W88GvNvniIdh9ACNoMcOaCchba82i3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770551143; c=relaxed/simple;
	bh=jbM3XggfIZgo/KKubW5PsDf/aiOpKgp0KAtwhWBkjSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FVW6R8CjQ88UcMnG1Mndt4HwTn7F2Rps7kPrlhxx8ZY7HYyYQpTN3M2KfPWOuGloVAtltCc/GYuj7ADLuVgTG8GqzZWvl+0V8HBQ8S9KJ4BVy3zAC8Jggxfto8wLs0Izk6wV4fW8sJduCPGSLkkoZH+Au0O2foTCykr9Rga03jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=52.101.150.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0iKuvS3u8sdYmKVFA3r+/6sx00fOn14S7FzyFdiWCTsjnXsmk5/jAW0+NhCwdSn2YXTS3Tj1+LuCG7HiRlZ7uDzuKOGd1jKWsmKIl8xnJE62T9S3tjhNwWnLcVtQH9P0CAEP9cgpyaXsC7AnOKc9fyLTqCfnqXYJw5jvS6vF/UJr/yG/3gV7JskU2gcqK5Rs1175reMGBjK9RIBQu83sThm3yBLPhABOWXI70Fbr5UhRqVWDK3w9K/zW5FuN2PhQBSwTFYUdDsrPajAI/Dns1IruZORWuk6l4E74jTzUu1fBbOtlub6zaJ02Jgb9RS69RrXVP8V2iBd8E8ejfcr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiBuNazef2An4/yZRPhyGkWPfn17oTn2/s/Ne12iB/o=;
 b=XdM7Zsda2Dr9nB9l20J8jv2/Xaezt/U38k+cS34XOgS4rkDBX4xEY8nnQYZjUTERAbnK66OsTZM0NrXb8sL/q5PCQ1/9DKcU4dpTuKCqH+4yhUfaQvRYYeAC/SEwgncDuxKkK3vk+p3YfGGozJGfu97Bu4REgXjt11yhtIMa4FPvIBPE54jwKv8qGsOUwfkbyt6iaWiE77xC6Xx5yj9rOPFYNx4OmXk5TEoKlDIcCRBaWO0wRUw+JE2KNgD52Kkrb9QHS5SUQc9PwcxKME0DyXucxgEji6DyY8+kgGACCJOy/BFneItxQ1a9hklrrD1ShjatHum3zsoHKdY3wSRwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 SY7P282MB4618.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:278::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Sun, 8 Feb 2026 11:45:38 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9587.017; Sun, 8 Feb 2026
 11:45:38 +0000
Date: Sun, 8 Feb 2026 11:45:24 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: johannes@sipsolutions.net
Cc: rudi@heitbaum.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mesh: don't incorrectly use const
Message-ID: <aYh28AFauAnhkzee@c1ec8b16bbaa>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEWP282CA0140.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d5::18) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|SY7P282MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b51b8f-c303-4984-fd29-08de67079415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5SGe4WlhQUf9lWQ8BB5lbS6sM7nmWSfamZsAHg9x2MJU3iZuaXlzcKF1gnfa?=
 =?us-ascii?Q?T6D4X5djHSKVdOxUWHOfuM3aH12FuAgiSwm42FKL/h+GanMLcJrd166JRwtS?=
 =?us-ascii?Q?sDY2Gom2nWyCGLD+kklfst+Kzj3g+7dsEWYQoXylUCuSh1XslwdxpxYriHNi?=
 =?us-ascii?Q?SHNtMBQv/zg9GzUaHm1u6Cz03beeiA6VKHNhCBexS1n2wFDB0ZtvlU1k3Koa?=
 =?us-ascii?Q?nlOkh8LwnCIN0on8q82PGlgGCwBVK8ncTXwmk9+J4Aa7R+0lvxWfvMeZn+tc?=
 =?us-ascii?Q?mjSj9dBH+F/oiXdh76o2dEXmROG5P5q63/2lyzRoAsqj1T2gDUEpV49K9a6X?=
 =?us-ascii?Q?tPSNRXZimY0Xc6TQ1i35jzqf7DjPuj1xwd/4kAYkZSlX4nNTuSlD8JOpyCXx?=
 =?us-ascii?Q?wVBxYHRjjozXr0pImZdK9RsJkpNg6Gh52+gmHJPGYp5Etf8ywRzFc/hql9YR?=
 =?us-ascii?Q?LEALDz14bwilTNpp0sfL2n9JdWpHolPnumaMC9FN/4KAhc86hUXh7L0bjkyS?=
 =?us-ascii?Q?m0PLVlMkwI1OG2C+yb0iaXD703kj+4/DqbBVxoTJH9ppUqjBADcR6337bJ+C?=
 =?us-ascii?Q?TVL5vlPp1y4ftCDFxvSWem81MTXMk5hMl/pRr8Q+jhAYwcMBQ4aTBh5IMOCS?=
 =?us-ascii?Q?GYjYv7v4fL63GvUzdEqqHGuqUgoUxjgCaPw164tWfs00o9kTY+i2/gpGgwPI?=
 =?us-ascii?Q?LhANaW45+FyO8DYnzDF+osA0gFVkoPiuCK01sHE3sEoWdC23X1NSEDTl5kAR?=
 =?us-ascii?Q?SsjM7uWDKtPEjA0fZbEMkjJ2x+7z8gaG3lGlDlC/6eEml9clWnU5Ma3prYac?=
 =?us-ascii?Q?JPFMTqUjLxnnLCB2T0rIzb7Iqo9WgBG9ehS7zKW3SvFLDrVmDcwTS5HB1CAI?=
 =?us-ascii?Q?jIqMpfOEVci3aYkgNhKk/bQU8AO2kRq87hOsfHQBwwH88Ga4JdQxcojHK4AE?=
 =?us-ascii?Q?fzLCBFH+oNr0+VUPOxs4Ws1QHevO1gEaYPyL68oTn0KHrmeOIgfUYt1Qv6lL?=
 =?us-ascii?Q?W+1bNhebwfDdoUNLfACunZQslKvzr47Wa9nZ9nqSYHkySTwftQF79D+i//wk?=
 =?us-ascii?Q?3eiiS2vn3Yi6X2vzs5AepXH/rt8XlCEb1rt35BHuwZS1rBNrd3WElMKozqIX?=
 =?us-ascii?Q?yMt0thet0W6kV7wz1SFCL7smeQUaN4bX+aAcikyY5wHh0Lo4G/RDU+v/HEwq?=
 =?us-ascii?Q?oZu11bitZANHFTW0/AKcHTlu9pmvi4LqT59vjRMATyb/EKcjlNk5+B6QjCr5?=
 =?us-ascii?Q?SJCWAzT1Uy/vpwM+IdLUjcTPqzYAQSNrQMb8tGVpfHH9xwgXTcYbd1BXqLtQ?=
 =?us-ascii?Q?z9GJJTjzg/uf9Ar5C6a21ovEQn34QbA4c6VblvFoNa3YXna+SEkh87m9cmBT?=
 =?us-ascii?Q?oT81oM3d0xYE4R701B1UI4eOAbA5bj+KToK/Yz3vXB5PT9uxyz0KuqvAoyMl?=
 =?us-ascii?Q?tpfRbaMm7G2FiI9yVpQrmJfoQnURXSx5ETyYUY7ljFXO258D4XdT1SwBcksQ?=
 =?us-ascii?Q?HLKkWmtiPEGkCvEJ1/msKij53ESbzUoz6ItENlQkyvUtBAAMXOAfTcR522eb?=
 =?us-ascii?Q?Sxzd5jPp6+mKno8uGXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xV4ryjGqVwF7JuCz69b792ooa84nsIu+0Y90WA4LELPSmeqWfdyRdForuvHT?=
 =?us-ascii?Q?czSG17dLpSaDlG5r2K5Ntoy7onObGbeR/oqZg0Fov93IRJ3yOtlWeqYWNTXM?=
 =?us-ascii?Q?gIMdykgU3JjfwtIrTr11vpRyuK1eMzFgRUsVr47v9EUFOhOC9lIis+SUSsKC?=
 =?us-ascii?Q?wGLtzuCxkbMtIYEZHjrjHd/KBu3WeK6J6GemgLvKBuUSlqG6wNmXSEhodn7s?=
 =?us-ascii?Q?Ic6qstxjUwUATZRN8YrOFb1WvRQQL8cewnsxtyTEXxe+UoH6BglLbIcGzzDm?=
 =?us-ascii?Q?0LpgwagKitJp1oUdJeIbh6NNekdePTufZsEH8DnmTuUzs8535YZkw5rEdiUj?=
 =?us-ascii?Q?wt9pMblzZMRr+1p4INOkv8Vy8DWZNwX/yKKbqqSY9LvyMKLSTxP2whCrUb4K?=
 =?us-ascii?Q?ji+3bYdf/4Z59VNnqfRHi3jaOV/JfklmeqQqb+CFPKC/qppu8om7eklJr0op?=
 =?us-ascii?Q?lAyVl6c+a06Cuzg6olxQsE6tL7dBywQVBjtUzxcYb1WaecbzLqUyj8wOp32W?=
 =?us-ascii?Q?yUpBrjkkRN4ilo/U2j2oYzqSgOpLo7npyqlpCjY+RubFrFzY/rWQc4O99gTT?=
 =?us-ascii?Q?Vz58Jr6HJiiCnK+KnvBqssBe91DMY+U5ZOFGktTusiFEsOVLG+CP8yTsZIHM?=
 =?us-ascii?Q?YmFaojUBDZFbDAkTuhNKE1XGqXfny74lLKZwkkFRP5MmGQU4DCAwxO6rnlhT?=
 =?us-ascii?Q?AU5SS+F7q+RXITm0YF7ANGCO9Nf7iaTcIQ/radxFQj10QZQi5hQkFl6+HmGc?=
 =?us-ascii?Q?DmKffLg1W10a8LU4BOtgoQcodSeryj3CmVbqLnFqf0QZ10jjSzM9wtRCWSy8?=
 =?us-ascii?Q?FvM6eA8TNCrWcTIuaLruhtGclZiaKFAHolhHi18475XwVtm5a8vSxDxZmiKP?=
 =?us-ascii?Q?Qi6KUSom4c3hGe2GqkMj93+vaWpLWUGeIuG44/hwMqNuExI+EbwQp0WZTh0i?=
 =?us-ascii?Q?crzGop1nE1obYGx4B18epkNcOrlXwrp5otaOVuPiFerSfDBiZI5kpQiMTBSW?=
 =?us-ascii?Q?u2PK8B+XFcZtje/t1xEGx3qJ/PYhs1yvo73lj6v14Q/xowbD36FT3SCrB1fg?=
 =?us-ascii?Q?f9alLyIIqjqpvccFN4DQBEZ9AWj87GKcNm6I7aypmVEgcMVh30NqrRv5IZp2?=
 =?us-ascii?Q?ME7VH0jNmQieq5Hf462+/HWU++cQX7uUQciVIZdrSx7HnqpKYBk51eyQGoNx?=
 =?us-ascii?Q?lj/dBEYY965kqog0+dFirqdp5E1YAgwlcOHff2ObG5cxoI+Y+6ZgT6rG9vWz?=
 =?us-ascii?Q?O3rzUK8sj8qvrSmrt+O+VW59ZExdODsH9bPM2t37zzYkp5vCy5qwSZPP0Kxi?=
 =?us-ascii?Q?czp8Uyl+Neqs9ViL4q0Kk8MZXKPSdkg0HuqLqvbSgHt5BZFlTrHVkLnpp9AM?=
 =?us-ascii?Q?24jQgKHgAX0kOirVS3T+mk7qTj0volSJ2RihmMk7mEGSS6nAvdEuUOqJzcdk?=
 =?us-ascii?Q?AkRmip/tBIt5f2BZvmPP5yq/mkaA7lcw8tzMHTsRFzeoIyfOAiMMO0yj57X4?=
 =?us-ascii?Q?qLWUSJ5hwiVIRd4EDojj94KD89FTl+ASc01/GEh9+r8ilDSg6oiodopMLi4K?=
 =?us-ascii?Q?mII8RuaNWBTE8cUH+Zme9lkkO6WVzrVDNCpqQZ0TVMxWLArIBypMBd7Qp63z?=
 =?us-ascii?Q?Q3Qy7sCQfxkDLVvPt4+v7FSYip3zJg9QN6l+sZjoOQUKaTsaPtwJqmXTPsqx?=
 =?us-ascii?Q?xOCOI09k6+UVbd3PqivESFpZfcfJ7mTpw6arm+VR0APPwV6y?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b51b8f-c303-4984-fd29-08de67079415
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 11:45:38.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZRWrrnlZYk2c0ku8J12zZvCFdS13nisfvP100jKsaaXz1osHbI+d3k0DrwTiuYfcbunUk3UnmqWx54im0kfAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4618
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[heitbaum.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-31639-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rudi@heitbaum.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.772];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F22CB1088F4
X-Rspamd-Action: no action

*name is used by strchr and subsequently modified replacing "="
with '\0'. Remove incorrect and unnecessary const. Passed in argv[]
is editable, and is being modified in the function.

Fixes:
mesh.c: In function 'set_interface_meshparam':
mesh.c:327:23: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  327 |                 value = strchr(name, '=');
      |                       ^

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 mesh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh.c b/mesh.c
index 40e5e5e..f116ae7 100644
--- a/mesh.c
+++ b/mesh.c
@@ -317,7 +317,7 @@ static int set_interface_meshparam(struct nl80211_state *state,
 	}
 
 	while (argc) {
-		const char *name;
+		char *name;
 		char *value;
 		_any any;
 
-- 
2.51.0


