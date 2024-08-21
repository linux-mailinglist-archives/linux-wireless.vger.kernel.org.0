Return-Path: <linux-wireless+bounces-11725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A69595F0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 09:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5DD281A09
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB19F1B81CD;
	Wed, 21 Aug 2024 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EWrgckZF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2076.outbound.protection.outlook.com [40.107.215.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930D1B81C7;
	Wed, 21 Aug 2024 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224829; cv=fail; b=XGI+EFfa5eafyH2GLrrjlcP5tZZ7vI3pzBI7jltB27TWIMDvoihM3ttVIqrzGJAyjH99qTwlbVftXETNzOE5AsPv7f93VQbRg9vbCgjy73yomoFl5lOPOhFP6v1kvpHehH3cU4iIpJs/c0dlCRYTEO14BzZHVIHwIF8d+oq9VSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224829; c=relaxed/simple;
	bh=9v+hYoYRVS4xyp28qhtKyJLoFj8+LpEJvXOJEsXj3N8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eQHYAk4o0xcem9votGIEaYuWc1UDjNXpBxw4udnBqcGI9wfOIilu8eUn+4oLKMPIj+CBoi8r7u48O27Mc00UO18TIMd7GrQE0rre+p23vHi2XxH5P32DZutzcICmc1fyn+d5AVEefjbHw1RYB8m3aWBUy7wAlNOhX/YY+fsOuVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EWrgckZF; arc=fail smtp.client-ip=40.107.215.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3eVsZkP/0jSG0wOlSGKLG/THzxMfWKGBdOFZgla8h5SztH90hMTSRFS9E06IN7ZqtOWhCHcaMXuUVs5cNf45xvaWYwYi/q8Ju9P8nDs5ctUtUxceBdhjS6wPB29AltGLCnygru8XDMsXK3m1FjQS9oeSuZ0s47PNrfb7VOXaR86TWmjOQ3QjmTrpbP+KoTlx6dUtaKVIkClSVgauAapzNpQo5D8vzls0ds+ImYlr9HAkJONLyf/4fDd2OyjMHVyCNoVvpF3psvXohvDyhvhmwoeotN7Nu5bzRyEzj7GCWkbbtbJagIjzZxLn9Az0g7Y5RuO0D9Bei485A7cqn6UUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulqjzYFlLH+7rVvl/XnVpLsrxmoiCeu38ldhvEAWznk=;
 b=qrJRCt5uNYnPicurUKV1TeK1OJA6BhA0/LK/JitJj0rLTy8Fv34ZOetwIhZMHiX6MIYJijEdGKpkLwSFhhms40TYHSWulzPVJPOsMfs4glqmzRjRlzPaSu//C9l4x36RFQeMwJB2mTPK+8qBc6TWwy6a73x56kW/vwn/EU/Dx8W0lZpgFkb47UHrGy4zEpi2KSgPWFedOi+D0UuWGeBb1MCPg8vRw4qt0vU8XCSPferNhzGgQ7CQGlSW7yhK4awMQ6tITXm9h8HB7K7bSlF8VEcDwTgSJJSxg2n0H1t+Gbx4cGUjx9wCrYiQxzAk+PYuDZj89pC+/vKyFCRLNGMCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulqjzYFlLH+7rVvl/XnVpLsrxmoiCeu38ldhvEAWznk=;
 b=EWrgckZFIR2BeakoPYvVmLsq7e7zx39tGrQmfRDRc7lGZWZ0OJgtTJuo1AiUHPp/9rrjQVNJKk8UJiuM0yy4QW/goqFGriK8MUK/uTEZLpTEC19W89dV+BbIt277pbqgss9jhw1NPbdK33RT3Ocssm+HjKQWi0R0wIGey2jqcqftMljzen+uhBsgakgFPcMJ52CK0JUBCR+UnPWhs9Dy0nxGk2LpOnVQQuh7rC/gWRujYiETiwpFRhtIDZ1ESAQKtRj7G44yGKakn80ktio1RCVh8JlwgA3J0S/XqEtJpia6LHeXOZ0mps44dVQhDZpmLfw7iHl6QdsuELdKd1IWlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TY0PR06MB6883.apcprd06.prod.outlook.com (2603:1096:405:15::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 07:20:23 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 07:20:23 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opens^Crce.kernel@vivo.com
Subject: [PATCH v1] net: wireless: Use kmemdup_array instead of kmemdup for multiple allocation
Date: Wed, 21 Aug 2024 15:20:08 +0800
Message-Id: <20240821072008.4065483-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0117.jpnprd01.prod.outlook.com
 (2603:1096:405:4::33) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TY0PR06MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 01837e63-71be-46b0-aa40-08dcc1b1b87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LjypNFV8AKUJ7soHyrV4mPe45QedJlsunH9LobSYd7LVk6rpafttQE3b4mcu?=
 =?us-ascii?Q?7IUeghKh8iUDASEu6Oie98tHP6jdmB1J2HLGP5jn9n3l0Sd2ytFFcg1WDnD6?=
 =?us-ascii?Q?JbbnZp9kHIiJ1B30G1H2gTw7ULyx3GzWWvX+hG6eRbknB9cd4hSQ/a5lmYj4?=
 =?us-ascii?Q?RvKm3Q2hpVXnySncub9ZW3tHBF8x3ZI24USHhdrW/S5oDhrC1B4IQQgZUFAu?=
 =?us-ascii?Q?RREum+wGqauF+pe7UMcYoBubUpUmAT8XrWRolTExSk6/g7l66fADspk3ymmR?=
 =?us-ascii?Q?QGmI05riMPrhqCP5ymGRLbihSyIl871W6f+vL05Eh113gQmkRxmQT9MvQN/a?=
 =?us-ascii?Q?kw13sglKyIcTTOkdnwwc9Nv1ZrmUWXodUgqv8oMwPGre4+49ihZi78kb2WIp?=
 =?us-ascii?Q?HT+jfKnMvH2Qyo6Xtcfh0e3fGOfHZHTjB1yEa88dKQxkK2zrVlvyOYc2fmwU?=
 =?us-ascii?Q?BPApcjay3n1gbAxJonD15J89AjRVGGyrKfFK844/G443n/4Z0MzuqWZMii9f?=
 =?us-ascii?Q?75o7OAPgzmAsZ6YvM9ai+R2NrgH2F5ncgjm7uQOpJrCQjbSCzOvznb7jLpYU?=
 =?us-ascii?Q?x2wwVhChImJEX08YlYTJHV658A3aIMvAMWEzxl0F7AAbn3abHdB3SrEy9AZ/?=
 =?us-ascii?Q?XRLskmjd8EteIEWlXNHZ4xvF1njJYWUZfiqkzq8TvWslB6fOZz3E0SBP9V46?=
 =?us-ascii?Q?2n4j7ZpNHJDlomX4ZqfNrzyT1Xpgl+LPfgSGw0E3R96NQCzaSwFC6oBrcruk?=
 =?us-ascii?Q?Vu7Qzwyku0rBsXCkbikzsTe9Ix1DnnzQYN+ejHVbuYLEOIeQPds22vswP8M7?=
 =?us-ascii?Q?cNBH1MEuJIAectEdRHww92opxoOdq838YlQHXcCUN7vjfsr+NO7axdCt65O+?=
 =?us-ascii?Q?W9+OYFCoY86EqpAjqIDCLyDl59kiOcO3cxwGDp+d7ODXqftdE7DA/ENSAXSv?=
 =?us-ascii?Q?Vk2byhHzIpD0v9oCpTW7s4lcBtKsvTTSWU19+kCePEYVZDN/8MvMNGkmLN1U?=
 =?us-ascii?Q?IB8j89jfAAZZi5TA+3OXXLMJXzmt0on/ykZKH/5tntHPTeJTK7e9PudW+tnP?=
 =?us-ascii?Q?Vmi+u0i7WPhO8gKn2gOrq4Ews/wuOBqqEq1+9Hk2+eYSaUaPkmUkdx0z8zZr?=
 =?us-ascii?Q?jnEgnKfkeiFbLYuLYYPeu+V4Cp7xMdOGfynmHDuwqj59YuePwcIMD8ezaDIr?=
 =?us-ascii?Q?hmQOZ8DgdVWPvgyspGxZ0DgyuQ+bWXniF4IyaK0P4ZlKtAVsH/3MSww2L0+b?=
 =?us-ascii?Q?ZMK/R3Cl1SyS0HUqSyxP4sciGafEiwpP3nrUJOxxii9kipcR2pU1A1f1XwwI?=
 =?us-ascii?Q?rJJaLYRc01244WKrCe0z2mIyX5bINIy30/+hjEcYFCvQ4nSMVl99nEtLED70?=
 =?us-ascii?Q?5ouLvN76fGt+dMhujKx+spAmjYvB0Etlmoru/Omq6GkOHJ+FxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SKVCpa0T7McFXurYgiNoX6c4YzldeokTpVrj5wiE+iz7rPAXtGldiqToRe1r?=
 =?us-ascii?Q?zE2EcUFtr/0j/fkn2TpDnRWpMhFXM+qOQjsaU5peclDeOwNTGTzh5yPTE8ca?=
 =?us-ascii?Q?Ldjns510WNMPm6rS4Ooqa51C6TAEhg/Wj7a/eimfR4UoytCBsGqXAiVhod5P?=
 =?us-ascii?Q?L5dQWy9XpM6rePKzL/tkhJXbQbSf4WT82yWNi9MpcusH8G89rcnl9rAkoLsu?=
 =?us-ascii?Q?Sa5b3c6sVcdbGoXCRGOJlZXiHPTyvFtLfAnGMS4YsNRECL3lehfzHNQDzK00?=
 =?us-ascii?Q?inP98a82HmQb03RkzCKRaIqZT8W+kwsFy9H0ugEuh6mowuPAqcQZIOQvB9Pz?=
 =?us-ascii?Q?70CrekHANScnGzBTNrmWVLc9Z9355QvzClNYcJ4NBRrbQgFDQpsKXH0+HVnZ?=
 =?us-ascii?Q?wHkwHjF0QYHMGkgvsmo9nKkbm0iaG9D3XzKmadU+laNdy/iBKO6fchA7ysnd?=
 =?us-ascii?Q?sUJEwTyuuP0zqmOLapEAGI2V0vH8BJ+HPq5u9i28t9MHq8Mos5kbxL6zBcfA?=
 =?us-ascii?Q?iPUj/nku4toUiBNRdkU4HT4/50wBYZQcbRC4L3Fl3vftbwqsGjxO98NH7nVI?=
 =?us-ascii?Q?psiPf1G/pd4Ryw8uRyLd31vM6LaTLrNSwmS2qJQ6wEt+HNs79BWScPP93G2B?=
 =?us-ascii?Q?A7fWgKkhgiRNqE5vWV8V0VGhXHU4fbk/oTEDkDM9qnt1osMpb7KhodhGUur8?=
 =?us-ascii?Q?GFLZL7DE3OaXGIy9eawlMNiZVop4XnEr0D4cobLCzuRZI6uxpjEQz42L4ljh?=
 =?us-ascii?Q?6ujK0ftnN5SABdufTRxxAWnSnxCXDui23vYGWcOk/LOvoEmM5O4rf0hWwPCc?=
 =?us-ascii?Q?rq7NOIYYvACQ1euNxmPi8Mqtvx7mY9M63qsca76Lr3P/2/UFRTT2Mn+nMt9U?=
 =?us-ascii?Q?Nhj/uR8ELqO7MBW/praCnPPRbzke8F/UivMV5e31bAeXjuczn2x3zhernPEI?=
 =?us-ascii?Q?z5bjZku0my9G4tyH8ZTvEKe7Ea3vY1jFZQ626QYOhFaPlSX6dHNkOzc/UvRa?=
 =?us-ascii?Q?RlePK/0ZqGxmnnS+Hi87MHEB0fho4C2uKp6oJREPGLMPXqQu+S+bKgxZYfUW?=
 =?us-ascii?Q?1beGHI6AAPMnvHuKLoPn8QTTCs3l9oaqhrIVGo52/9zIhzUiNHmqzoQBbbfD?=
 =?us-ascii?Q?iWdj9Z/XB3VZY6ZfMAhQFCZihJclDQg1Qa/qK7Z/KLCL8g5fT6yJHpZm0lSv?=
 =?us-ascii?Q?//CrakYj2EAP5csmDVxX+pmtotoTXtur4vuLvD01fCduGZYY1FNIu8c7pcaQ?=
 =?us-ascii?Q?lqaZaJRZMtjY3gjb64dgNz0mA7EvmF05SQv8ZZLVOqKtNAXYESH7cWYm3ypo?=
 =?us-ascii?Q?W075Gw8L9m1fp5B92bQ76w0lTuQACnvJQEXGaj2twC1qZ+XDQIxB1IMTfExs?=
 =?us-ascii?Q?v/j1RB0XwJKhCa7Lx3lnzGzIJGnMuGbfSvAGoCuYh+3iVMm7Vp9Fz7kYA6UR?=
 =?us-ascii?Q?s12smv20RfF2AGm1xnzdikKoue4oWMgrCoOU+Zfq9damlUxGb9281dKMpgOo?=
 =?us-ascii?Q?WFdadUWtLzbLb0FQiItwTaGH5mPT0MHpMWQhCW7ff4YOsDKIPOf7oWhMdqIN?=
 =?us-ascii?Q?369ubFAouRT6ZOIGHVQyUxlRUa33T4dU1MnbBhSg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01837e63-71be-46b0-aa40-08dcc1b1b87c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:20:23.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WTZQauRRY1q03365MlDL5WrG1VZ2R8veQ0U773+zJv1VNZyX4K2r4S3Q3xtYoNOV0PI8oS0vKulzJNIQOvzjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6883

Let the kememdup_array() take care about multiplication and possible
overflows.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 net/wireless/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 9a7c3adc8a3b..6cf19dda5d2a 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2435,8 +2435,8 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		if (params->num_different_channels > c->num_different_channels)
 			continue;
 
-		limits = kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
-				 GFP_KERNEL);
+		limits = kmemdup_array(c->limits, c->n_limits, sizeof(limits[0]),
+				       GFP_KERNEL);
 		if (!limits)
 			return -ENOMEM;
 
-- 
2.34.1


