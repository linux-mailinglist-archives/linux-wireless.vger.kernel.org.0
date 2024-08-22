Return-Path: <linux-wireless+bounces-11784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C156395AF99
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 09:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0082CB21542
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8E152178;
	Thu, 22 Aug 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="j87cFOjB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2068.outbound.protection.outlook.com [40.107.255.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F15502BE;
	Thu, 22 Aug 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312886; cv=fail; b=GaJru19rdlDsR5pH5aZpjZiuLcoMlxGlxuBEtCp6mfElaHRTNvT1oGEBvFhQXa4tFTNPPSFS1KztDbUmD+lmq7HGgtNetQylWrgee/+Qdg/ivoBSi//r227I23b1VTzpwQuPbUtsxEN6rYuzOIhErqy2WPiEe4PR6zn5klzU/AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312886; c=relaxed/simple;
	bh=70W/v9Iq2Z7XpxBa3VUCbgqvYXCiQBtc5yzi5ifXrVc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gHneUvuTKJOf7qea5dHr6kJT2KbLeapQMEV7DwgyQWb1FeYboNc6iPttXwrqURjVk5M7/4BZh0YRlsXGmLem22azKwXN/zRzAexaIokY3fQ1yq5pGTmcpsPcNi1Xq4xpStAaAhLCTJrboWKWVdxnn7TZomRS8smJBI4uvkN75y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=j87cFOjB; arc=fail smtp.client-ip=40.107.255.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNUgyuEGtZZARl5dFRHD3fP+VkKmg8K7sVBSEYcpMBXu8H2b/v4Xniab30iGPjVK/48gHqIbUvm4XL5DA+PUd3fdEgKbMp6V9WqSgnoxA9beii8wCqwDbiA/5Dj7bGlWk70k8nLgEO07TOvnOWuzK5PI6PaqkOD+D4Eu9SPpd6Jy8rfflf6CZr/gsroBVLWo/SK/gY3ZQIbVL2sCj9pb9+r04BrNMpfzUdc84i9ugz3bgPYbgGlGJ+ikRRHLEYn8n9I5+6g1RY/JziBKkFllwjp906SCV1uFL+VdlI3/PJtqTQFjkbhKgxZfrg3K9D5ryHCkc2ZAIIrKXr9Leffa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef7XR6JPNZyS5YfIVpE9Miops7716rm1jPaBiGZCSJY=;
 b=PSSeCm4THHmfse5LJWFLdR2sKcosCCbyFtsJ1scH701KbtpIyXRt46k1BDf8Bjjnc7iaEMgDn/iRa1wFg+uiz6+93TFrG19FsbBrlfvT/gwprIElON4s9FYOIok/Fi0HSiZix1ShMii4LbdfBSptlJUIIfSPCo7LvsYFxgmY4qZxtS2T6dmv5eJV+UwujBdTT/tp2nBE3xx5+b0TWL+fAKfn1fK8sBtcy3e/GMcYC1xQTd0DwodMzChFhI//A11XG3UyHCxjIuqvo/W5+6dbZziP3va2MhqzkhZQrTwjmmvJQgQAvwA5jvsAZZme3TJBaY5MTBDntlZo21l6G0cpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef7XR6JPNZyS5YfIVpE9Miops7716rm1jPaBiGZCSJY=;
 b=j87cFOjB/JxdW/H6xXIzII+WjpIxjWWwXDX25228jf/r/PSskZz/0GWx9al7QAfyA8nhdIEZbBbTt0o+ou1TJ5/IKdC7dbZC5O6b9oWIBwP9Aa7+3xMGxcrClLzjwb0QUY7X7ozSvwIE9yf1HCiHpW4fm44o0ikbP8lWG0U5KEwxjcs4k2LiJ9VrjwYYgqwhJ/7p6oKF5DntHWvTTOfgl68NZOd4SCoDAUHUmvjGxWUgyQoLpdcwjO9ZC01Ye9Rp1fzCyEmjiFmPqEaOqey20uZi/xC8IOXvCmNUh7EisoDgK5A1PWIWq2P9KeY0nAQyPulYUmYd/mogQXWOvnvqYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYZPR06MB6281.apcprd06.prod.outlook.com (2603:1096:400:425::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 07:47:59 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 07:47:59 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v4] wifi: cfg80211: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Thu, 22 Aug 2024 15:47:43 +0800
Message-Id: <20240822074743.1366561-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYZPR06MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 711743ba-13c4-4eae-0bcd-08dcc27ebdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0QAZr9z7xW3OM2ormwzBQCLOs0oGz6wxqQM4rBd1mmR5yAFpwBD8ffyfPV+2?=
 =?us-ascii?Q?btevkVi7Jhtxtk79QjH9JCt5nA24REhGGTgRuJNdbqvp92dC2k4FBS6E7H+P?=
 =?us-ascii?Q?jDLvO2IJPETbIwr7V3a4OGP/QMD3eJgU6dI4FcATsl21VWxwpcwktgak3Y+J?=
 =?us-ascii?Q?a0zDCO2ZTpvBSnkr/sb/3L/mNtlyY5fJMJ9dn72C9QOn5mnVYG/3Es4fCj4f?=
 =?us-ascii?Q?BhQUxqdJ5xCV+i8REHQPNcGmdUVF63OOHa/QRBb9GsVf+n4SscEO0AnsMAdr?=
 =?us-ascii?Q?Ae9CKIrGqBuuHKY+PwAemDR5Iea57vkEZvodxKsp80DhyO1DVdPUL1o2Layb?=
 =?us-ascii?Q?/DGuimujOe+f4SvVcofF5yCYBi3knyGZatoBXKIQ4qemIabwgD6XCrmtTztJ?=
 =?us-ascii?Q?MC6eb7K5+FfzXwxKV3478djPpbwXTNgFQfxG3WFuIbJRJjqdI6oQkqOQpG0D?=
 =?us-ascii?Q?k/WrSomHUVFSFZGm1YtOSTSCuXg6C4K1zimO3LrRWw4efiJmUGvjA5Z+suE3?=
 =?us-ascii?Q?9EQWSG2+B+KpTDLWovywMlQAgTQNPzX11lf4amha/C7BjdlgRm+PfHVZ9K+v?=
 =?us-ascii?Q?RK6kcgSIOF44pR3qaHiYsWqyyl3TJrRnSBNM0ujGC4to6+l6Ki9lVLKer1Ck?=
 =?us-ascii?Q?YgWWkfkMIfk4QkbbnNWYAiVAiljBVKKloip2fuxOlu8lGdSHncaKo8U/6hRH?=
 =?us-ascii?Q?jtjjL2cEi8iWeA0VTVnWSm4SatVW3VxrnpyAQIxQPJT2cA0cbmfczhueKlJ7?=
 =?us-ascii?Q?apKEQffRIa6TGUe/5FT42DTOQ+ESTdgHCueXiN+btXTOCxf4aZhKt+S9n8Dy?=
 =?us-ascii?Q?HzWSW+soVKP/aLelR30k7oaEotr1D6FYdAjC7FK8mSEpaaWVlbeGHoTin9yr?=
 =?us-ascii?Q?31qQSMUMAxO/LXg5C8UlwNL9CobAprzbBsCtTs/JQKEWznYh4290jpYDhYCG?=
 =?us-ascii?Q?Az6SLXXxU2F+n9OK7A0sQAKLh+juhYDl6RD4nV8uVTQpqn4UUulWyO6pQxAZ?=
 =?us-ascii?Q?hZ0wmBgW/cnNMR1UpQZal3Zd4+A4V8FIxMl0+POC9QvRrpDyzz+VASm8zbdc?=
 =?us-ascii?Q?JNPo/X6ER28RIguii4vsO4NO7UNxqwSL7w8o/oMDOtOMHbHTEi7zuIueZA5i?=
 =?us-ascii?Q?+L7Ds+EBPkD4yIC6BK/hHA94T/Ky1UabMzmyhIjObUEkpvSynx/aB7CH3loh?=
 =?us-ascii?Q?BRuMLGZV+HO5itBLEj/zG2uvlSulh2//7lYk0x9eVYZzoCyTe0MuimQryvBH?=
 =?us-ascii?Q?BIsB9eyZ13dY/nOQI2zT4ZCYH4eiAll3lLZ/0l332lO4mOQu/yXMcBFwAyWl?=
 =?us-ascii?Q?kPYwoYWh6zssNsysXzfwXf8jL8Gx9HWfVK7201ZqNRQXsC5kGELRbJlqCgVb?=
 =?us-ascii?Q?782o+wLd05ioTH1HDieX0sGA9sUrI3vnl3OIevE2QbcSA1pPpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CsxgbOy8SAjna7P/NCZwMiq0ZFOSyktw1mJao7Yev4pHXzX26Qwxo+U0or88?=
 =?us-ascii?Q?KqSkEjloGlTUnNi9PONDrBG+FNiYQ1kthnRB9Eih+bCSmI5RTfTGTXTaCFnB?=
 =?us-ascii?Q?0hVLjpsYoLm33d7SFfu000UtjhtSW0xTMl6GR6JF17Gydsux4Wx3lyHoewsu?=
 =?us-ascii?Q?aPab7X8evH8QWUcczK204XAAU9dotz+IAMwjc6bWl5cuernompYPCr87MtZz?=
 =?us-ascii?Q?9NN6BmmcfEgr8ydIhEO5kcAsrQCR75u8T0oz0gHMFEdHRbf3DLJzq3TeOSy+?=
 =?us-ascii?Q?qvrr0WSGJ8CzWsClAp0WBExJ47Ja7DyrDK7DqOCsciHn7aCt8Anj9QAbBHHR?=
 =?us-ascii?Q?KbGmkpzYnzcYXsF1hZiLx6GB3iZJD0/nmQvYVSOc5HbSTYJNAO5zm/STQz0z?=
 =?us-ascii?Q?LxEE5puuTkA8SwluDmyre0P6eJqXrHCi80yIC4TC1er726OzDNskoV5u4bMS?=
 =?us-ascii?Q?Xbfabxr02ccEgM5jLXgAvtUa6OZu8xbuUMAIidACS68QfdKEewf1l86kRQDc?=
 =?us-ascii?Q?WhDzp8noX822Re3ZNOScQsBmL4YAv6y6H0wofp4FH/52voSRDCPBOuoreVE3?=
 =?us-ascii?Q?XjsAbwE6Yc6f0gNNGRpGOhB1+xIGucSXsEy6oDACI9frhG1gNzKo3v/TE7hk?=
 =?us-ascii?Q?Z+Ke40VljyoCRIYR9Hv02olxBaz+HSaGO3z9qX2tL7ywhRtPpy7VtT+2LMJ1?=
 =?us-ascii?Q?UB1+yc9YTeU+nAXG5+uEpqvToJFbsurMSJ6swQ5b5/iA0EZMxZG8caivjquM?=
 =?us-ascii?Q?jNyUapvZS0hMNzOtQZVvyaZMMwOa1aQPfdDJXZ2tU4vojxF5RBBztz2FSTEy?=
 =?us-ascii?Q?oqyYSRF19r8WtEdK3axNmPoYvUI6zCnjhTEkKPDzcMCA5SIcKeGBae+GZtOt?=
 =?us-ascii?Q?Q74zWeWMC1f1Wr/oYAdYciYn96EqCy7IYKWIOXfwVph4yC2VHVta7ZWtqHNG?=
 =?us-ascii?Q?K6fWQKN3pf+CgYDdNqf2NZYXKBENnrjo6mBLAQ5jsBoANHkwkdjE8JMkIHO3?=
 =?us-ascii?Q?ajjaZOJNHS8r58kYEDvaO8W/l2drWw6R4HrlKDPVR/nwgb8Z9AdM4FgY9myv?=
 =?us-ascii?Q?UZQ/qhWXA4eBvL+T7w+AP3eAi0YelF6sjEHL2+mFVOYtXCeiskm/vFPKjOzC?=
 =?us-ascii?Q?93O4wT6Z2xnbmSBr16gmW9Hlk2LRGbQcxT6wk8YZn27Ul1pXhdiyiGjOTxVN?=
 =?us-ascii?Q?JUwQBua8CdwyUsAeXXdjEBwzY34CCfGgdV6xY/WWv5IawNoSTe3kIfOcuvL6?=
 =?us-ascii?Q?GjrQxcR1KYehvf48bRTOuS70aDos9TweyITVq5mtiMeegc8tbTSLxued+r8i?=
 =?us-ascii?Q?CIvB/cjrv64CCzJnyYoVQZHNNn+15KJRDx1+3ZT1B0l185+qKMJJEXfyRJg+?=
 =?us-ascii?Q?OV1sxaWl++ph4WY1H+0snOiBKVHJhShLc4zPblr6z9k8Xjlo2WIxwMvYYBNX?=
 =?us-ascii?Q?PYGAKwxBL88svVc5cCJMdvhbnQFOe2Xmr1YRJ6GqHqRQ0SMc3r9PD3I2GE04?=
 =?us-ascii?Q?z8ZdAV+MlF7xvcpvia/MtPMKZuyIZ4WEBdjarpp8wcVaOapa3Uajc9IBAmOL?=
 =?us-ascii?Q?6aRbhd3UId7GebKrkAEtOprgUfyHYsrkliIM9Fxp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711743ba-13c4-4eae-0bcd-08dcc27ebdef
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 07:47:58.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJgTIM2K7Ip/KFWtOUAc3Xky25iE+EPQJ0IiEnQDsovJkhgmACjpkF0MLW+XuT/0rAwHQ9HTAgKP0YWl6aBGzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6281

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2:
- Change sizeof(limits[0]) to sizeof(*limits)
- Fix title prefix

v3:
- Fix R-b tag
- Leave --- above this information

v4:
- Move the Signed-off-by and Reviewed-by information above
---
 net/wireless/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 9a7c3adc8a3b..e7c1ac2a0f2d 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2435,8 +2435,8 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		if (params->num_different_channels > c->num_different_channels)
 			continue;
 
-		limits = kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
-				 GFP_KERNEL);
+		limits = kmemdup_array(c->limits, c->n_limits, sizeof(*limits),
+				       GFP_KERNEL);
 		if (!limits)
 			return -ENOMEM;
 
-- 
2.34.1


