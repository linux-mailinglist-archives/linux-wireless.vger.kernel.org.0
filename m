Return-Path: <linux-wireless+bounces-11238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099594DA6B
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 05:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E481284039
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 03:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B6513D2B7;
	Sat, 10 Aug 2024 03:52:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099AB13C81B;
	Sat, 10 Aug 2024 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261926; cv=fail; b=sYzi8Kczsm0ttEUUd5cQZRCsgCcupHko9Gsk9XdBreQVEZaasjeT/h2Sv2xbJy5nw4odzs+YlAGgIE3Ysi2Z69/hvq14jQrDkcwYT+xoUqBT3idBQwNDp84vtDFADvJJf8YI8pEa17JkGyaYdT7k2xeg6HwfRe5PanLjx/pEvZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261926; c=relaxed/simple;
	bh=uyVPq0vuS+FMU0odfnlfw0F2eZnLPgwjnpAdPSqAp68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C82fYc+ciYKouMoR7E+gDUELA/Pqrw1LG1tF8LqmMIQAMcgL62RWtKBuOwApo3YjJv9FRevyEIzXV39joaO0PwLaEQ/ryN/dPxUogz/AS9bKGnFMBBf0PcVvIzZjGZoKk5DUB72TK/zfHA7QKydxBuCfhxUnV99KRA7cnTIcwIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrENUBkt99v+6nI087BX4AHSuA+AZl4HcXaNTT5MEdUoVv2t6cobySTrpFmHaY+PyH5KZq0HwU2E3wLvFqUFIfd4cHq/0iHJPO5+N2xEFOBbrxve5YRGm3i9fttEOOqYt5x+A4/d6nGwutgC3OhtitkC8J763+n07a8juAxLPDNQ5QGrTKI6aJqOxbaoyVq0Jpv8+u+2oXQXXBLqhbZVic641cjXq+1ckTu6k+94fr/7+EU/9bOIKEi6NBmGkXbTpvUuKZYUgd0BH0vLkb46yjjH+W0Yz2c+fMJlYlX3luqkg5WVqxgurc8veAKW168rDZOuhD/I0erDJxwKAKqyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iPX8WFIoQ4QXgUD/qR3fD/Finzms7t/FKq4XAi292c=;
 b=RAFPNUB6GKEM3ZTGVBh48IRVUC6fBqbJx3pOPJi3Bh2q0smrivZHsDZgvuvo5A7kNe/pRNKEGbWcHfFhBoZWfd5GdHQ84piw3fRx/i82AXwiFpps8vNcGtYTaKO57S1oeX+5vPsHgUwA7Ofo1r6uej+iMj42qLJtpsNG+Wv9TD5CVPgFFCJvoHp5DAQzcBpgPeYxFNvA+qJS1TSz0tcMekttBndR645MTjCrWeI4kQGGCRY9qb0+251OX1qvZM9xCyxI0mIxsGlRj+wljrLrA0AFPUiIzUzf1p8ICAh2eh+1ZeDyCTnoacYy+JXIr6twB9/v07Np9eH8XWR3JSibUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB8564.apcprd03.prod.outlook.com (2603:1096:405:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Sat, 10 Aug
 2024 03:52:02 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 03:52:02 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org,
	arend.vanspriel@broadcom.com
Cc: efectn@protonmail.com,
	dsimic@manjaro.org,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arend@broadcom.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	megi@xff.cz,
	duoming@zju.edu.cn,
	bhelgaas@google.com,
	minipli@grsecurity.net,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Date: Sat, 10 Aug 2024 11:51:38 +0800
Message-Id: <20240810035141.439024-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810035141.439024-1-jacobe.zang@wesion.com>
References: <20240810035141.439024-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:404:14::32) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b502213-4ad2-443f-9ea3-08dcb8efcaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WeOiauOuwv/wRlM7OMD+zbQQHKSuZiMP/WE/YUrismwoSkiCGlxGYQNkRqBq?=
 =?us-ascii?Q?8MAkObP/OSKxpKfUbC2dxD3oon/lA91AK8qyT+bNHQ/wd34zOFFv+9Rh23VK?=
 =?us-ascii?Q?2QUkSuVpbz3+YJErTnP/1p2R5w2e6Fr0I9g/Bs1SePqfKFf51eLpLahfEA62?=
 =?us-ascii?Q?Az5sTZDPY1o5eHLtCklDxjwWAIZYrJ7nka3w3UF5VrMC1njVPOxVjGx4yrNO?=
 =?us-ascii?Q?UIDC1vJn0w2nl970ubhV22njAMWhj+4tz/Mz2IoJsa9PcPqhKPIcXHjY500p?=
 =?us-ascii?Q?uj/I1627QDpWKqh3YfQBfbl1+pvB72QmWOK2FZVFPwCvY8npgt29LW7Hqpzd?=
 =?us-ascii?Q?ltZ27ki01/HOiGW5sD8Lf5MNPNRGd4Pf1r7Oc8P+iSOf/hxv0JCW67czayAn?=
 =?us-ascii?Q?MLR+NNDabv7wJ0vZ3hXR+FPwE9Jf/QOchUB97WzgXJmkyhux9QOBsJwLbq7a?=
 =?us-ascii?Q?KlKPR/4skzGZoURxq+ZOygtD8ZhKk1lqGwA1+q2ieIDU1l+nDlnWndhc8Nao?=
 =?us-ascii?Q?IviHgw7uZ+AqgOZf8krU0VhXrUkWo+xY+Bwnk2/bst9y2h5DdzqbtF/YSQzN?=
 =?us-ascii?Q?sBDoblOMtICxhqLXhxUdGy6LLVjvQ/ed/FiIV3emVxuuWocEr67odvp7neyK?=
 =?us-ascii?Q?+tQNHnkxnkKu2vklUsSWXD9I7WNic8zNTl9tSytSEAZelFKYBTiLhgmAwN2X?=
 =?us-ascii?Q?2WmP7URhFxUt8WmhHQhUDk1jseHoD0Grvk+uDRTRSKVUPlf7LpJvmrUq0XCW?=
 =?us-ascii?Q?GdFEwsGV5/mRKQSr0V9p+kNitM1surTUnloPxzRPEteSOmdTIzaHCLaaYtSJ?=
 =?us-ascii?Q?U2r/3cg1kv+Y3SVTvNDlFDn4L4096cORtNd8gruQ9i3LweTfMtw6sCwcQu+O?=
 =?us-ascii?Q?/CYHLgwZEeUfuPeU+SzruHpu6HLhXsYmFnXDkbqbgJCRO/ExTNKDYnO0lLfg?=
 =?us-ascii?Q?he9kwq9Fo1uN0pStIyTGXUEzxVcEmScFehNNTRSD67lycCSTLt3THzOxa2XO?=
 =?us-ascii?Q?oWQ4jo3aCK1N+MomjYZ90umxuewg11xy3mB0hn8Dj7gy8JVXbs8jYZaUu4IC?=
 =?us-ascii?Q?E3Gf8VMYJHoG4cJt6fiaecctQ1jmIQGRvaOPGmrGLonfvuC9rIfZxZ3t31Uc?=
 =?us-ascii?Q?j/9DIrHpvdZkdJucp2GuB1+XfXuCrpAfadqRUnXgDZcTV/ifqfwFpkU23KOJ?=
 =?us-ascii?Q?AXMrh8wlsMyg2LQEnQfMWFC8e+JXLDIrqrAGHULMroKB5HyHBmxA1GiaTHb6?=
 =?us-ascii?Q?FMTuq+jC8i0ZR4Wvp5gNItV4XQL0rwnqkgsdZpLWQzAanptfH/aZ/Y+ZzuiL?=
 =?us-ascii?Q?gdfpXn7zXuwJQ5+QqqadW7jAAlxQTzlXpIQHxOHncsVO3P/Wa3I2flJ87WOH?=
 =?us-ascii?Q?8gIkktmJVsyc4ut2+6HPplVPrsAs2ynWeNBQ8QPt1edWXXHIMISXiCup0NvM?=
 =?us-ascii?Q?aWPsMRd/M3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gEXZgjD3IKwypIw5b2sAyGGfp5YQiF4GiR6re31HM3zLBOdV6vrKbMIga023?=
 =?us-ascii?Q?H/L+97hQ8uhbmYuRARJ1VCfPw8aQcxAKYDFRsP6AqIbtS24KQ2m9WqygYAoI?=
 =?us-ascii?Q?nNDttqpTN7GCcXeyz7VSECZAWUoKx2AQKkM9munwBTjRpft72d0bn3DLLiR4?=
 =?us-ascii?Q?GFWABuIDYNjwk9Vjh7q9F7KbOWGsRxLUqw7ux2JS1i/bbbN7EJjnEnaflIwX?=
 =?us-ascii?Q?Dktsdvp1QwO542BQqdatQ+uf+Z8M9Y/TF44UKACSU7i2o6F88FazWeu4GWvN?=
 =?us-ascii?Q?QStnqONEYRd1hGImR4vEQy5phWuFBdD3/ls2EhIySnMe+UJaLvtez+4elc30?=
 =?us-ascii?Q?TLYwzCQJBZLHbzjR1mKhQ075PTr5g5m6ykQG18qWijfzW6QVg70dDCrO29HZ?=
 =?us-ascii?Q?qLHzD7GSlS7zltk/OwDiZdB3NBEJCoJ6UWWYpNs5oUbQ+hwnHaqiwHD062cZ?=
 =?us-ascii?Q?B0uuUj5sdKCkAKSgCgffYsOiMKohqWjZ0SG2aSL/fDsz9Vf/9EUfMl/QrwGL?=
 =?us-ascii?Q?VHIQhDjUwjhXrS3ERqe7KSUiM3LFd9PiBEy7g8aEepO++otHAqF3ztzUi99H?=
 =?us-ascii?Q?TUXYrt6mnFbGhbvodaaHp8XP+/E6bxr3QkEg7F3sUOzfwKY/FxUzp5IgEid8?=
 =?us-ascii?Q?Z4LkjrigRVy+pghc68b2P5ME8BZd4UlTbvvVR2wipbobXEK9T8gWF7JckGdQ?=
 =?us-ascii?Q?DGqkDELr7ONhBMCNeIjwsF0Z7KbjeVrDMQIjMMDV0lTSP4FpabGb5lg/I7fB?=
 =?us-ascii?Q?bRy9258LLEZnEaMXOg7UWFQXRy9YRO80O++4ntvlSAIjLPpjpe79z9cR22PF?=
 =?us-ascii?Q?u17nisvTLbFRXOGYhvd2ZzfXpLYYi/IdBwaM8nzIUjRfRuaDJMDNSaILu9U5?=
 =?us-ascii?Q?V78b6I0tGUvnpW8p/dM1/wkeNaAtzK0V0fIBNKPJ/0cZ5eojEYwdovNkzf37?=
 =?us-ascii?Q?e0zj6qsaxcWIjgR5snKh6vLKqV5QK6F58n+WPpmMjwgfzVf5ROg+21Fyfkzu?=
 =?us-ascii?Q?cGpFM07c0BXm3XDNRW3JOZ/MkE9nOKSHP0U49M0pwTvzEANqY1feBPhL2qmN?=
 =?us-ascii?Q?N1xSPollnvfKyLY8/ov5CBzGV3W/mJa0GApOU66F4OHQBed3YOPakl2VtzWe?=
 =?us-ascii?Q?MUNsgopg96WwbZ+tzuRJHfyIJC10rxzVLhWjC9SA2jIunjqZUTjd8sZZm+DY?=
 =?us-ascii?Q?9NxQn0zVwegpVccYhfeXMGWgYp2+llD1oMjvlQdc2YDmNgy+FrAlzbA6X5GY?=
 =?us-ascii?Q?8dcbyu+NBo3850KkkDH5vOBxboBmTp1Jvni94jHxRC5Um5RMXQXnM0ASTpLr?=
 =?us-ascii?Q?kqMcUovteoa+u+HdI/6jImutewivbt20EZyngzanwuEiDv5E/mNhnnmh4LCQ?=
 =?us-ascii?Q?XHhqCXpezNB7jV7J+281+XPgt9kmPfglisNbefZcb5Qk3WQWwyIywCq9o1uL?=
 =?us-ascii?Q?gQLIPKjaSwMbhQR/DnYCheUPPDmFUYvSOiTA2jK6GttQtlDNN8zbjjFna+8R?=
 =?us-ascii?Q?TDXpdJKblN34slRWLM+uziOjhRSQe3ICXyY1vyOm6Gp7IfiocOmlsbwMYkgG?=
 =?us-ascii?Q?pLavlL8qYz66M4y4v7YhgnXqygk/FiJ4UQ5tOa1k?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b502213-4ad2-443f-9ea3-08dcb8efcaea
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 03:52:02.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZBqoC9gRchG9f+No3ENtqGJbQRFAGs9cvLXnxLKcUMMnUJT3KyxExGUr+Hm6sR3Dm2r7uvWlqo0fuNdawlLQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8564

Not only AP6275P Wi-Fi device but also all Broadcom wireless devices allow
external low power clock input. In DTS the clock as an optional choice in
the absence of an internal clock.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index 2c2093c77ec9a..a3607d55ef367 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -122,6 +122,14 @@ properties:
       NVRAM. This would normally be filled in by the bootloader from platform
       configuration data.
 
+  clocks:
+    items:
+      - description: External Low Power Clock input (32.768KHz)
+
+  clock-names:
+    items:
+      - const: lpo
+
 required:
   - compatible
   - reg
-- 
2.34.1


