Return-Path: <linux-wireless+bounces-24090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED42AD8979
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2786B3A5808
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5352949F3;
	Fri, 13 Jun 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="k8KqaASd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012027.outbound.protection.outlook.com [40.107.75.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11920DD4B;
	Fri, 13 Jun 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810408; cv=fail; b=oTpz+JUZO5qa297Z4PzD84NGSVvdH/64V6+hQnB6rA3hvsA2c5OF1JBf0cM3xuIXRNZuXaVNbsagaZlCRa6Zv05/vT9iKKY4WRQei5qSKLz5bz4EXHQhnT3j8MYtdhwFDu+voFSzd2/EPVkZZfKvBWLuslRPq/x2nIJg/6L5404=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810408; c=relaxed/simple;
	bh=AqDH2L54YGv5O8v34Xf8+CJ32oEYydwH7DOHPX6F/5c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FaYCX9O10O/bBuJTsnYf702edzUuVh+Ov2ZMLRA7s+85NB9GtOwGoRI4tz5fQwe/IelXVmWLo1o6r4jvSVz0AlYIFThOq8GCYsmeTtq5mzVnVaSef6vQ+AzdOa6NyRRWLXxjD2icV2j/GOg579rZ7lCoHvAiMeiwpRYmiy/9sjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=k8KqaASd; arc=fail smtp.client-ip=40.107.75.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1rEZ8uoGfEpV8eNKYPDcKF1vd0PHcUmjyP8ti9cOudtfgyn0qcYh1PUNOGgBuyhRtmh/qfjViiNZxM6UvcTRHWcA8eNSpiem1PgiIl+7PZPrdal6Aa82rnZKrJWfdFTvg3n1BecsGmO8TfEh7Oc8GdJjKdLE6CZfbQ8PYTd0HqHlaoOU6yDQ8K9Z6k8O/7BPEnunG9lYGPGtv6+aFMptzoSy5/yHaqxayBf412giqz0OPZRX4adswpCqQZ1qy+LfVjdPFLeOEzJdOPZikasBd+KDpoxwgH9kUO6FJBII2h92SH2Fj46ZqG6/3hFjRch8dSDRn06YzxGOqp78zlGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E562fQIxfMMov69uML7jTv3+mmMYIdUDOAyZA4QlzOo=;
 b=lONSY8J3UzYpv8ZjqmimfQy7SCKUm2cfrDfKE/Nx5tC/jBePirgwVPsoIpUfntXyYen+7TJ/XcmEvwZl5nxIDmSLnCgI/2jgCz0ROCphg3ldXr+XRIX0DrATjRYJ1otwOURxVMsouyr14EFVUqLw7arJkhIcwIa7y2N32IfASSSnq7Zzqc3VeV4kEuZFOxDj92vWEwp0USnOxR9ppb/dd/nZRndb8stpHfVzmPe9p1BKEqQc6tuGVZmr1BNdN+jCxtlfXxDd2AUFxPowFVdrZc1NNFXlM5UmfFz+yf+upeuHk6ITTrrWQVKH7AeXD/UWIM7Q92G2rRZv5ishVx/Awg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E562fQIxfMMov69uML7jTv3+mmMYIdUDOAyZA4QlzOo=;
 b=k8KqaASdDezV48SD4IghreWURAt9oSCK3+rUi2RIQ2peWb5wAhBdToytj4Gr8ly+De8GRVVy/J+6Fq9MOXOdtVLpcuXRt1JaApovdBgfaevsSdili/TZswWYsK2z2JCcc/9ifG1Km5/wPlPGaCdjiksYFhtcd4n1B09FcHqJ0kHuYDHAlbwPMrbriZOyEdvfOBr3uWkYlt0VLFs+uHokXYIQnFjB/pa/nETu+VIS3ZZqr/M0XReGC0MOfLzZK5lqVE48SjeCt54ud++F36Y2HPQeJECq0tUpIsNRnBDESIOd/dLsZVGKpA97clzcQvJWU29DdqF2oNCkRG0sSzR4xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com (2603:1096:4:169::8) by
 PUZPR06MB5770.apcprd06.prod.outlook.com (2603:1096:301:f2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.31; Fri, 13 Jun 2025 10:26:43 +0000
Received: from SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349]) by SG2PR06MB4802.apcprd06.prod.outlook.com
 ([fe80::685f:929d:f06c:a349%3]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 10:26:43 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] wifi: ipw2x00: convert to use secs_to_jiffies
Date: Fri, 13 Jun 2025 18:26:24 +0800
Message-Id: <20250613102624.3077418-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To SG2PR06MB4802.apcprd06.prod.outlook.com
 (2603:1096:4:169::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB4802:EE_|PUZPR06MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3cf673-7eb8-47e6-eefe-08ddaa64ca93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eD99unSHI9AlZl/1TStkabVA/8pp9wrwbBCpGZTi2qHNignHu50z4cwrQV6d?=
 =?us-ascii?Q?yo6cWdzeXxJ5VCxl5fcKkRwqpwESlqb6GHWlj94kAHaJ8T+imcq0cka35D26?=
 =?us-ascii?Q?ftA/5n0FCRmWJ02mUpcs1ZZme4DcjfO2JFR+rmneehHP3i+ResaimVAu69Z/?=
 =?us-ascii?Q?wJCR23S6Xw6vWdJqL0yJ0AlBUT0jZEh3t37As42aYUuC9Su0wZueRANjJzAO?=
 =?us-ascii?Q?VIzznkxeXFuKX3CNwxoe0zT0b7nVC6UMCdkJZMRueYPVCJBe2W/OuZZokgcB?=
 =?us-ascii?Q?PzpGfs4UdB3Eoh7du+brBsxIze07zmPU/pVd1BDc+s22qVAwj2JLUeN8J+DZ?=
 =?us-ascii?Q?Rq75VVoum/1v8Rm8kVdR1Ex1K4dL3ZCCiZQKv87WvoL7JB9Ybb7PpJAU17G1?=
 =?us-ascii?Q?m5L/I1ce/oCRlYOa41GNKIf/GQx1tcZGgI1bJ2ejX2qM1n/mOrzGnqTfRhO6?=
 =?us-ascii?Q?FSfN2fsncJsioG6A2HcyRDvFCRL8kCX9A2a0OpWOoRIYs15kPi4AeOTCt8BO?=
 =?us-ascii?Q?os9AJEbHoRt6l1wt43PEn4s+L7pc50sJqbxOWcawGo+lG5L5THYExLPwf3FI?=
 =?us-ascii?Q?hSd4k3vhcEAkWs4usGeN/HOFNnGwqflmLM1ogwi8X5Zw6tRTBxIYIquOigF4?=
 =?us-ascii?Q?IwxFq9Nn+acafDZdgWhgC3qdQXQNbW4D7gyxzKAHN2y4KPp0zWFLA79/TdUx?=
 =?us-ascii?Q?8U2nZvGqkwEaysl7fa79BQz5AYrJJJWdbZeb5R5M0yleNORpjpRdzDxSqwmh?=
 =?us-ascii?Q?CfhB3P3odlOhf6ClrOxtXN3dLmRQSHeRJkrsep1+z10UgTbINNg4zC0Nfw6k?=
 =?us-ascii?Q?5REqGqHthIG0yZ9wwoRgAt8Dyc9pef+1ZDN8SkNkkfBg8l+Y59cbONKn+IWv?=
 =?us-ascii?Q?HwiDbp09iFN331vYTM1tX85agLQqFfgg2ws+td0yZeuApSyJpCNar73Wzy7H?=
 =?us-ascii?Q?pPbdTnsZuhNtwBP+/KhQf3KZ2Bopp9N3QCkFiGknqMAo9kS40xlPfYhkECzj?=
 =?us-ascii?Q?z6h8Qz0Y4+g284Tq7iB+vsPFbvwl3f7B+kGLbHsoG22Mc4JeEvxx/b0hOwwl?=
 =?us-ascii?Q?Ne798iGm6QLgiOoqJ0fsSbySXBzFi7NX/wwl7czkX8Vzd/uUs5PeO+WjCKSE?=
 =?us-ascii?Q?52IX3QN/ATiaR54z7E+PAPSbT9cqITPpfaXo9og8xr9R3ykZAPYT2yJ+fbqc?=
 =?us-ascii?Q?fFP8TjldVQaHsuqhq1zTBjKoSGU2A1hJFGKs9DKsTLu3gBZbjQiCPv3Gk1R6?=
 =?us-ascii?Q?rfbi3/ZgpdRTRX8xouFnt8WCnUEsk75hx1445nHRfgZW0vxmL7DclAmEkVjB?=
 =?us-ascii?Q?aBrHnbP6xhuo1oHyRZk+d1aSC0CZU7GHa0yrFD/Q7lAy1jqSF2wHIoyIovjv?=
 =?us-ascii?Q?7bNb1Acb2wAJY0ulzkSAmQI+R7i04J9A4sifwhMt43CvIUdhMPky5jRsC0HY?=
 =?us-ascii?Q?B32+EOMmyuVxDn729yTKnO1ytXheRudqf+5WUrDkZ93IuykUS1mhEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB4802.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QNu/pgyNV4V0xqjZSpDJzGNMffY4K0tvlDqXGPJOuO/Vnvrjii1iBuiuelYZ?=
 =?us-ascii?Q?+Rd4dx/8hrB1YfyFd4BganXLniSZa6PnBeqO1CqTLH6rqL31TGnBlq3JdD49?=
 =?us-ascii?Q?qREoAxspI4wD68CEXDlWoNuGne8KafD5GCxSaTYKa0GvP3Ofdr6URMpcjnaa?=
 =?us-ascii?Q?KZfC0w/N2TYL2ueRzOqFLsYShiV29npQ+v+K48fiq2Q9PZ3cM13dpYGpjCBm?=
 =?us-ascii?Q?HrtHPVbSYi50ovbShfNGByXbgNCSUpHm85ge2Wu/TcMoDVRFjSNqCKJCULO5?=
 =?us-ascii?Q?pU8TJMWoAWllp5GlIBfsXfw/Wa0X0bh4DZINJfHhpjHeNxjPebo37vp9bWxa?=
 =?us-ascii?Q?tli4tiP9zfQmM6inililyn60j8Yx7MLOkz92N3ESBvfVHxYXn2SzVNxu/vSj?=
 =?us-ascii?Q?GaafKawJ4aLsKnsAQ54z0VTMEs0puTRygSdFzeOkVrwUsb9iMHEJea8Rk2yw?=
 =?us-ascii?Q?s410GpiWA2x22WvCV1iInYwDXCWrolvRbKhE2MJPRzKgYU1cAI/JRsuYCfuz?=
 =?us-ascii?Q?vrzmCDul7nfsgs0ZfYRt8G5KRJs7+4ZW2c7aE62QQAb2gj7uP/Z9QvZOR7c2?=
 =?us-ascii?Q?7kBSy+f98fQkZPATD4XUth/Gq9zvRiIgXSu38KUQEo+q8Vy456PBwDv1Qx24?=
 =?us-ascii?Q?A1uZZibj/8tEY9e5ETf21Ok6lxf72RGHX/cNGR9KwTRxsNeeWmpdsIC8Y6O5?=
 =?us-ascii?Q?oHMJEd1vLYbjM2egW9sa48yLjOW0qoXWQsMQQq8MLAgZaHGsqWj/mKISxX/x?=
 =?us-ascii?Q?Cn8e8joY3veuxRKNWEDgrZHmjRwaC1ZhkuValrVH/1pk41Gm3S4N7mPdK976?=
 =?us-ascii?Q?l9wOHSQsAzHHEfx6QCBg7F8y2Y3e73ACxbFLz+t9/j9h2xiW4Wa7peeVKt6o?=
 =?us-ascii?Q?nV7RjIrZa6Iyfud8YBcS02CMEkjP1KWTuRx8Ufl5zZ3pOM2oavJWw5vKgmut?=
 =?us-ascii?Q?TM8+r3guji4w/KMSYcrcMPgS+wje4acoufW2VvwsASdU8rr8ltP9mhb+p20m?=
 =?us-ascii?Q?dxySlKszuR2s9PrQo+UeyN/qu0XszSxtmeaqM2fj9mX7gdDZvn6iIrUhPLIW?=
 =?us-ascii?Q?Z73oc+Jfijnoe1Ige0oL+ykb5q7H42n4ndLiAcv9jvmBOKkH3SMsjO4Etyyk?=
 =?us-ascii?Q?BBDpbvWJlTLMfnzkCkmlSB/xQlPKbtwlX69G1b0EJ6a6V0rOpL7y+PoBA+7U?=
 =?us-ascii?Q?/8A096pPbqS2qq3ygt48W8dH4IdeIrEAmshAtBk0gABm9gopAbjhyXGEZaGN?=
 =?us-ascii?Q?KGcHfSP7NjVLT2JqLnz4iZ5I6RcpBHxzu723aVHTsRv4IXomc7fdEm68yOfO?=
 =?us-ascii?Q?/KZfVuuXYjcn1TftPzHWI90RraFXmG8t4VLM6SrevvPwhpU0We56z9DpJ93e?=
 =?us-ascii?Q?TC6w2mj4XFje/jF+6flh/xzKZC59Js2SQQ187iFBImmYgE8OvPgK99uXobGl?=
 =?us-ascii?Q?vw+oYhRtrGZ6U1HmlXOb0BT5e5xEwMgQV/iuXk23Nqiv47mGUIC9L2D3K1JX?=
 =?us-ascii?Q?DQqFL+CzsuRDIqAwpVl1ZwWo46lPTSb5j8fhGQ3W/Emx6dlrR8kbrBsffhti?=
 =?us-ascii?Q?Ycyf8wIQIdggAjFf1ndrTU1MLnPmDSmRYCmI4IMB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3cf673-7eb8-47e6-eefe-08ddaa64ca93
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB4802.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:26:43.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERwHZN6eYFWja0Qa50ghuUJ1r7tUh746woPJMGdozJKUhjQoXI5S5K0LsDllKrhvGTt8OVm7X/oq8WXDvt74kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5770

Since secs_to_jiffies()(commit:b35108a51cf7) has been introduced, we can
use it to avoid scaling the time to msec.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/net/wireless/intel/ipw2x00/libipw_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_module.c b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
index 0a16127bfd68..2ad085b1f492 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_module.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_module.c
@@ -83,7 +83,7 @@ void libipw_networks_age(struct libipw_device *ieee,
 {
 	struct libipw_network *network = NULL;
 	unsigned long flags;
-	unsigned long age_jiffies = msecs_to_jiffies(age_secs * MSEC_PER_SEC);
+	unsigned long age_jiffies = secs_to_jiffies(age_secs);
 
 	spin_lock_irqsave(&ieee->lock, flags);
 	list_for_each_entry(network, &ieee->network_list, list) {
-- 
2.34.1


