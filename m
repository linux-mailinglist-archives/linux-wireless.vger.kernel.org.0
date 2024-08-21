Return-Path: <linux-wireless+bounces-11738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A39959A65
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B03B1C22418
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987F1CC88B;
	Wed, 21 Aug 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ktt/GqEd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2088.outbound.protection.outlook.com [40.107.255.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8451C4EC6;
	Wed, 21 Aug 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238787; cv=fail; b=dv9FmjSR4j6lz25ocf8NHjXMCp3gU+KVxbstV7nznEh+r1xwo+fW/9XeiPNzqeMIEs+IFgAa6zxMewFup5qXTjyvG1+EoiX3Wy2a3oX9oobNn0Yehhs9zE5sdMi9d+kaI9tHLpX1JrOUU+cwa9XjvF5LjQcFxLhvTtL41h0a7ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238787; c=relaxed/simple;
	bh=qObZnPU2AyoIS8UcHaQoRdi16GAtNfxNDzUZ0AGZXOI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GMSsXdbm1pFDOP+sLLzxNoHlK/Cbh6jzJ9QD+DJ5DjeHyidCePOkj1Ke9q7Xmc6PZviPgW+esglR1YmHxBojTQo6ANw6YYhpPSG2jKwr57zFMQVkdTdiGD9liwBDSvcnGLmHKEuNm+w90CZwZJ2ofR9ye/mRuCJ+NtAPaSjka9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ktt/GqEd; arc=fail smtp.client-ip=40.107.255.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xX6BZIhU3Ceqhct+PD62E21LlI9OeZB5B9g7qE0jc7T/KuiLAG6skUDM7BZ+R2eZvzrECxYw2fFtP/cIeRlEAtToSwTSaALSCd2FnDC40nbNtZxG1LSlzSLJQomkFBhDPWR1vQgZJUaXc0J6Gbrxm8GQkcyqP9r6sAvmA8S21ul/s6m55WNP1JmlAx6TfLxKrbEXu381rJbDjUf7qT9RqhDoKvMtCD4FdSPkFYtR92LtGJzxcgVlfy76AproK4OGag9ZGGgREQ6vu7lN3ILCccpbrmajCO/XI53HmC95X4FYKIp5fsDevayuDCRIEWrSQc+YIte11MZdYj8aELaLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lRytfToAng3MrnaXk/Nn2BwpDvURTlDuqPhOtyfe7U=;
 b=f0vEmqmlEIutPXi4lP+c3aFvk2heZXMtpYpx00WY2vyk9IVGwClvPJvemlS+uC+sqgCrTssnsU6RT29zmiXBi/u/Z9u+tKMZUZvDIOl+QoVk3npvexFexeG5XWH55kPz6YDc463eRHBgwzWrxkrT+hXhwS6AeGXTEK8kls3xi+uwSd3anREojC5Gps1cBoq7p2+Td/RMTailW1Hbk5g4s0JE87HQuqo852R+Qs22gcdma39B2QYFCN8CW9Q3wwigDaZS+XMEODsEbGVDTpZelZnEST8u/fwS8kayuHnSRD2usi5aIWxLl3E2ooZq3quKVYltatlKhrCKhEqCida/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lRytfToAng3MrnaXk/Nn2BwpDvURTlDuqPhOtyfe7U=;
 b=ktt/GqEdFECRTO5STtUu+dwA+pdijntamMYuOFHIXGRph5rqY2bkzprioifS2WRFPYIwlxepmNSdn3lUFfUOtN7oxUmYmpP2tGMaP4I369Yq4ZHzOmiRGsFezIMvB4A8ESHtXmBZwtY/jPSUXWvsjh9vmmTnjmK3O+qAyHyQn8rKyCdQAqVeTAI5K70xtHeAhoECtucSjVPz1kAXMiUHWBmR4GcFZgk6QjnbOvdw9DEENtpCIoW95i9ybF5Zw7V6/118Vul4H5eyEQEX8au2flJ35rVIjLZBWBCRwURsfbwniFonrr5cwbeBhzQxqkTULApCH8jQ+smfA+irOQP3lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by SEYPR06MB6539.apcprd06.prod.outlook.com (2603:1096:101:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 11:13:02 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 11:13:02 +0000
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
Subject: [PATCH v2] wifi: cfg80211: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Wed, 21 Aug 2024 19:12:50 +0800
Message-Id: <20240821111250.591558-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0122.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::14) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|SEYPR06MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: c9aad3e1-f355-493e-f898-08dcc1d2390a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AT+Gg75kT1FVaQMnC9YYAYVYpEeNzZLiKY6Lt2g37XUdPFDYh/yi4QbJQJsp?=
 =?us-ascii?Q?t955R2ZQSHn+giUYTAFsH/LAnJ/U8h51c8S2eZ7ug7IFQy2gjC9X44Y2HPCm?=
 =?us-ascii?Q?uqiUkLRU84M2g0QayNUoM5NlOpOUuMvonQMw7Wx4edMv2oBlOxOrjNMcrk+5?=
 =?us-ascii?Q?+CpPzjPYyNW6KOjnX7JBFLxAs4Gqf8BL6Izu+N4dsQiFxYLDyA8BwZwt3fMV?=
 =?us-ascii?Q?vdnrKip/yS4MDN7lUt26Sq6UgW8ne1CF7pkiO5AOmFGY1IBaWVGvm1zusqkF?=
 =?us-ascii?Q?Q0g6wbMUUjEZDMLE2uSRWwVGOSPNNc7DNFzsE/jEKgBal8nGJcd94JKj7qC1?=
 =?us-ascii?Q?HEs9FwADgPYL1pd1q9Vth58vQLhz9js3QvyPUmbOulZPWsgKSbL3ia6UzoxD?=
 =?us-ascii?Q?rVMrJ2hFxuslfq6LIfWgj0xYCoJNcJphjTeZFLPDpFzPgQzGvl5IWv2aWdTp?=
 =?us-ascii?Q?pF++7CfQDxcRxp0SiU+mYUij33GCo8cYy2n1jQFRqGcLXVUzP5Y/P5cMl0o0?=
 =?us-ascii?Q?64Z3fc4Shk/Y7nQQCzZ7tAoFEdRV4t474PJQdi5pQXS0cDrGpdIuvusTb3/M?=
 =?us-ascii?Q?nfiZns6fFkUN4eispkvn+cxPYQu9W8uDy0ljTQYOCcGxIhX+tMnVmlF9hArt?=
 =?us-ascii?Q?LElsJoTXj5Ge9WxJX6bpQ8lFbC37WfcVJvMDhFjR5VvKFfFR06Q+yFe3ELKP?=
 =?us-ascii?Q?Wnj5NdyvM1SCOiGI+kM/dgwj7lT+ex+R1Ay9b7JEdl9+W0AI6zUc8ZEoQh/N?=
 =?us-ascii?Q?mhYmQ2rl0MMM12sRYUYLDnx4s3U3jwNQyJC5I5PZs8dtf2I94fSlZkwtCBJy?=
 =?us-ascii?Q?1/XLmB1ADale9eKGv9tkuPnrkIAqgb+TafcQtjeGQZGzOML2gv63YFcHnXd/?=
 =?us-ascii?Q?L3kwkaPXplawJVUBgbPwi6X0gbZ+WCw0kaxwgM4c4E5+Eb43G74H/6Dt980r?=
 =?us-ascii?Q?YJIPyakTicForBEDcbv/b2jnFYOTzHTioKqP0i7azRQ6fnBCtrEYAPtEXPT2?=
 =?us-ascii?Q?89lhr+Xq1FWfMt1SuqLT0lEkv5cULjBwqKqX44VcpDiYJmeYnL14SRvGkOeD?=
 =?us-ascii?Q?qxUGGPJUAgeZbCk5tW5yWdYZA9JKO5TWwKx16WbtTgcUsjAPiP0L9JQ1ndwU?=
 =?us-ascii?Q?KV8labpSLC1CXmofKM2RRGRv1z8JlxNj9hykvhCD7nj+e7XeRIo5qub4A2ct?=
 =?us-ascii?Q?s5cw74nguj/PRkAmWAPbyAwPWfiuCGp/GogkRvlrHT8Qg7/JzpxqJUeFYntV?=
 =?us-ascii?Q?8cu31w3jZ1z+4VtRK/xxuGDEt63s5R6wA4GL4EhH9iz5tCghMwucFN0oU/gT?=
 =?us-ascii?Q?1X/o71ym1/1MBOTW+dQf4OTfih4f0P2EXYjnH1O/tZCqynB9jCynbixd01Ic?=
 =?us-ascii?Q?sePGrp41Xb4n9ZFgLWM9o2BXdV9ov8CbKUAZNeJmHqtERsVOfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0rlkhvZY6BJv/7MBdfxE5n9qZvD37eUHRgNHcRREb3l1vOoEZRi17s7/W8C7?=
 =?us-ascii?Q?XrM6snlGbMMkVRoy0oskrd/Dnmr47pJadK4vNki8RQ9GTorWfcN94ZTFS8rq?=
 =?us-ascii?Q?hjBB2bhMWxo2YexuUgwoJt7f7Lu31absHxj83hrDPKEYiS494IL5x6qtIDMg?=
 =?us-ascii?Q?l1UqRMxK+oamOG4Fk4/glvhiVHnYjweDD9fgRguGfepCfDP2e4i4sSeAW4Yn?=
 =?us-ascii?Q?gsTzBt0rUe9AguRt+L+Gvscv5Wlgp/r+8mWQ9b8bZntbHpJGkmGpi4sQlfKK?=
 =?us-ascii?Q?xy2VdkcbRHGH29EXfelZ9UxZ1Y/N7DA5fVPenFMseZuvrdlZkrIHbzxbIzs5?=
 =?us-ascii?Q?VvloQ2SCjC9eS8JuACzaGDpgZLaLaYCHN0m94Uk12sMe5753NEzIwyQMttIX?=
 =?us-ascii?Q?f3SecGLqs4mreXgs50KG4uSNjlu3asXF2UkZ0doZxVLMpMbXeNnqUKPYXJ8s?=
 =?us-ascii?Q?j7RM5qiFFvO2QCdl8R9zxP3OUgpzHOTNGOo5Aj/MmP+gKk+KYB6MWJQ5Jfs/?=
 =?us-ascii?Q?7pv/9K+8aap2e7tWqhpX/23MRRmZ+v6R5HScKqtKM7cdKPgc3T/Yh7QFgdll?=
 =?us-ascii?Q?TbcUPl9BgMccM2VGEEwtAIkKHof1yD6F03/2vC/lfG5Wm0nr3NA7+k3OMFf9?=
 =?us-ascii?Q?tYoMyxSLeyuRuujP8/1CLeaxjwxz71p1VwPp/tLi8EfIclaZocb6SXIBs3qv?=
 =?us-ascii?Q?MwWBCjBA8qB4AAhGNOdLdJQctk+zDZqqf/H/csU2lbBUJ8IqNt9VJqZ/Njpm?=
 =?us-ascii?Q?MrBJtyOUocbmAlg9x5aQ9+vhm8UtY7hT21yYSzrYaVeu8zxxoHaKXUHePkFw?=
 =?us-ascii?Q?kQPJ1WNyQxcL6U6v3paQJwt+WU8Y2meAKSOcWHO+feknx8dsABdDlnDUV7LZ?=
 =?us-ascii?Q?zM+juwi/DHgUbR9M3EJqFev6DUBQArgs78sVgMSPS+d+cN0FB1D6vq2OgiHr?=
 =?us-ascii?Q?6O3YkeaQYF4HO+GdFLc0bwXBjeDsKmMCcBMSEheAZx8p4xAUQDECSIFvU7hw?=
 =?us-ascii?Q?8GxX9pScUWIeZ9C6Kzz12YwmXXvfNFJeVZk8b4wgCBYZi2JnU+St3zSBJ8Cg?=
 =?us-ascii?Q?bcN1hGDEj8kTMjjlz5kTOYscSoM3MFwTojcDhxskGfHonnOpsM9U+7V+qUX9?=
 =?us-ascii?Q?MrD/sr1/v0vwLy22Yd3FwwcR0yvVUSRRWyoqIQup9MwKLnZreNfZT9zN4xzV?=
 =?us-ascii?Q?pxh13HNIcVI7f6WxeXKJvSHiR5sYWmDjpOjm6+8TsCVAiAh13e22qr1NJd1O?=
 =?us-ascii?Q?GJGY2/+LoNjrJfHM7G7NUxrlpbYb50i6NPtzPc5fLHESHUZEkWBQDSf+dojg?=
 =?us-ascii?Q?JXTzFq51gAPTdoUY1dmyTRnfznwj+EEiNqvxCvyGwqvELUlK2SfSmvhESeRh?=
 =?us-ascii?Q?e7WF0nEHlo21VpAN/mSHmwYaQW/fL83YBb6Rc9LRFSqLLcIymKrKRY9lIJnR?=
 =?us-ascii?Q?Eh2VcPdqJ2iKDZWNAi0oLWF61sP0bTPJI/YEeS0HEl66C+ZijBbn/tlKW9iG?=
 =?us-ascii?Q?iqHH/S+Z9Ex8dpzFQROtWJruiM4yIfzO1HrxY452f5pAPnw60ntDFlkJP2a8?=
 =?us-ascii?Q?hy8Jywu48ArwvueJADuENLwZ/jwuc/JCxB1wwjng?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9aad3e1-f355-493e-f898-08dcc1d2390a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 11:13:02.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylQSGm/K+/i/WcqXHXUOv+fQmnH0ugliYsE/+gzehyOdMEen+mSXz6DFTo9KvKZ7on21/N544DMNzDWHWcXbXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6539

Let the kememdup_array() take care about multiplication and possible
overflows.

v2:
-Change sizeof(limits[0]) to sizeof(*limits)
-Fix title prefix

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Kalle Valo <kvalo@kernel.org>
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


