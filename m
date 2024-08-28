Return-Path: <linux-wireless+bounces-12107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3A8961D26
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 05:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8392D1C218CF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 03:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB01420D8;
	Wed, 28 Aug 2024 03:49:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE9D13E3EF;
	Wed, 28 Aug 2024 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816991; cv=fail; b=mBEUX5uKZ55ocF/c0Rqd/BSjsoNYF9kv/Qxb0/50LkUKm5MS3o//79XaBCVhWbvrbmkJtGvYFUQEcOuzgJA884fmncJ1JqsnZ26S78p4WwU6l0k/E3O7ZPnqbtmNA1N6QSooS7AipQv7cDSC+OZ1fDzdwLFFAyOmEQCQNzZZVJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816991; c=relaxed/simple;
	bh=uyVPq0vuS+FMU0odfnlfw0F2eZnLPgwjnpAdPSqAp68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WEC+gJbsUfPa568qYbIwT/j2ceWaOsjGiF++1BLUC/nP+7Il9j6DHrwrhUZmA9o5rFYVKWqXYoDIXtRrM9kvT0nbciP5ci8jYUOjiJLiFlEd/6/cE8xaxS0BBGztB1qZq4pJGHgqBYs3jabTUOIqIoFNmiwnyTEMr9YHR9Gv3g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ob9QoGP1bQl2BVGcpyb8kNsyGQ544PmfFKfWMkf17rHXvCps0nW10aWfkx4Eut9MtN90h7WUnaqegrsdqKWcNSeNi35d2HuK8KDSfE9G8ZBOxI4lng7EOB/UOOWcWYN69Weolv3jDvNbRX0KMSiDItr0lxq/iqBbQz6psbdcdS7JsmmDHW44TrxdPZdjlI4YwYLxnN0OCsril6CWvXKqA0F9Q3rBMe012/o2iTAOtTVTSu4KGe25N657MAj4NOqKtNg3KQ+iWs8r1vmPZ5kk//Z4GAza7Nqql4VV1fgawGLfOXLRDSfP0ia769MqPtdfxHVb5mpZCbP93l5+/ip/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iPX8WFIoQ4QXgUD/qR3fD/Finzms7t/FKq4XAi292c=;
 b=n+oue3eOYIi5Buec04+9ckbBPwWuXGjEqdsZUmqoNCwmJoBPpd2AGv2wno+5zhDNeDRy1lCy4CsG41SY0o97F/avyoC/mkyl5fAymwBGDzP33D5qFmCX9ygQVSJdT9yU3TXywGxbP13+8cPUNxMffTzPzLJCTNcm2ny/IGHop5UY7RNJkIQw7H52MRJspJEd+zSrWogPYbhLMxsGBCOWspAzW0gcrA6T+KVjRRSCVWdaiZvyhbSNM4q9+HrMz9WDZPeSUOWVf8LZx9ALhWZIwhOc2w8I/j3TMxdEXrDGDshkG5uQJrJHKdb3EqMj/YO96CybJrnpu4a4vxDde+y87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8233.apcprd03.prod.outlook.com (2603:1096:990:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 03:49:47 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 03:49:46 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	marcan@marcan.st,
	sven@svenpeter.dev,
	alyssa@rosenzweig.io
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	saikrishnag@marvell.com,
	megi@xff.cz,
	bhelgaas@google.com,
	duoming@zju.edu.cn,
	minipli@grsecurity.net,
	yajun.deng@linux.dev,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	christophe.jaillet@wanadoo.fr,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v12 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Date: Wed, 28 Aug 2024 11:49:12 +0800
Message-Id: <20240828034915.969383-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828034915.969383-1-jacobe.zang@wesion.com>
References: <20240828034915.969383-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c979d7-e463-41d0-bc47-08dcc7147535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?amDyMtXD2c62yMqBvbOYkatUBg8Ss/C0o54r64rFJ3mOnoQtuUGkhe4if3fn?=
 =?us-ascii?Q?sHrITtOCs519Ec1AzhPCPs1XKCVJJbpHP86dEA9vhNUcdYu/vxKBI7nSjgPv?=
 =?us-ascii?Q?UKFUIFLmuaDt6k7RZXZRt9Bb4YPOqMiHzqV7isuWw/+B5JgfKBvZOa9nGxB2?=
 =?us-ascii?Q?ij5/tK5isFTNjr75TdsG7ZW36gFMCoQnYsh7hzQv4zMKelqz8nBfOuLR9wNH?=
 =?us-ascii?Q?Si6QnFUA77CfqD+3m6iOfzz2h0tWg9EjEWqJqNcujPrS6YwpDAuAhpv1XhWD?=
 =?us-ascii?Q?/mHRpckrfmafY7TYhJfrUdeGOAYi3+KIyJ/l+Vx4gbGyFRJt/67s9FoJNsmI?=
 =?us-ascii?Q?qGfxiU6HH3ds9J0gyNDYiAWQEF2S7Bbgb6SERKZGtqmZ6/Z+TnFXKtSfLGmp?=
 =?us-ascii?Q?Hx+xrC9rrjH/tWdq7IVgMy/Sr0lyL2Pcz+6APtKXBwQisT4ID8D4DpTbo8Qu?=
 =?us-ascii?Q?JroEejmKBnVvHAJbO3pRD+j4/0FGVKFWmmkOy25shhrL4MLIdxqzYR7TBH0s?=
 =?us-ascii?Q?oNRwHQMl7UoNTCKoWwgiwG7vkUqYSpbENRmWkBOY3LMKT63SKp4MpD8lE6gl?=
 =?us-ascii?Q?a/EEp/5ZG7FrISxcna+KzvjoNjR/8e/+NonFsxmgtihss/ascjFvvoJJ4LJP?=
 =?us-ascii?Q?6kIpOYaxcHpP90qURgqo3K9nfTxM2FHAjih+yoUOGgAB0vC5XwXmtqS2h4V6?=
 =?us-ascii?Q?rdhJc1mWFx3HVJu3zGXPHbFg3wh9P9TlLECuZV89kvQe2RPOMkA/q9+oftnJ?=
 =?us-ascii?Q?GTkPzEC9nET8ddnGbWjaAjzMqgcEGG0Vdl3bFm4IYEmm0eqKLPGZfWkxPyiv?=
 =?us-ascii?Q?lmEaKcCp3ar+mptEbPSpjZo9bmKOZ+ku3ur3UgLkeduVpyrhxvoJ7AeVKXxj?=
 =?us-ascii?Q?aZzW1kRBzqsGbyKk8jWgTPhnZ75wAamvAOBDSOWytTZcq3F4ldej1uwuuY0T?=
 =?us-ascii?Q?ce6BTKatLXK8GZfxwdN9Y09kN3H4WTngbkHFSIxhbJKlgnvmNKNu0ysG2HRq?=
 =?us-ascii?Q?RkyXRkM/w3mTBG0ZU4KPwIx7PDc+i0wJyn0Yvi/z9SGC0FNoKqNNO9ZGxgHj?=
 =?us-ascii?Q?cjf9kwPQwNcRRDyYJ7ktQLXsE98EO6PaK83GieLcRVVSAnKh0prtxryUsglt?=
 =?us-ascii?Q?p5HQ8wUodr6K/rKTv3C+uOZgAbPWlE+taK0QfqL7w8sYHbnHnqI3mCN5N6XT?=
 =?us-ascii?Q?S/Vu9OOyvTFEc84T0bjMtDeKdb2+6wHn6XCHmBYBl979X8Cuhfj9A7KzkkG6?=
 =?us-ascii?Q?Apf6ueDr3eZT4nAlyiXYkaHlhK3CfrAohp+b+0akQqeabjv2BYq364Ozotxr?=
 =?us-ascii?Q?84sLQT7uoOPn+1EkOHR9UIEu8iwN1DwmzJ5+cLbAVT4P8irKgXPCFR/TM9yR?=
 =?us-ascii?Q?gy4U8Av/TmsooiYQmD8It2oijsnu499kueoVKANLWD6JiBURlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bO8baC5pSxTt4KonDer7eav9WQa2BITFofH5W7LGaQgIsSh7Wo79IwKLJ1JR?=
 =?us-ascii?Q?krXtyDCdrmxAB4YxdqSp9CTtwfSYTiJ43fGcAo6zCmq/1j+8pb9YRTYkHmtV?=
 =?us-ascii?Q?remqorQ0DzOZe7wenSV0y8mGMJfsmC6hoxc3elX4klIlwQHnUAFLdpaKUUY1?=
 =?us-ascii?Q?TI7lyyb08OfwwEKXXFSkNa0Mmnc5EFjdzOj1+sg/Lj8++Id5+o0xRxAGmD42?=
 =?us-ascii?Q?SFrCkRUKBsQcfTsU22XlPokjnnzQIz/fpxRLpwPHteJ2qoKg0kEHJccTqt8x?=
 =?us-ascii?Q?q5hp98saU79M2JfsghASk1SUVFVJhia3Q07eRgAK+XLV0RaXAXqk71fcUOlI?=
 =?us-ascii?Q?h67j1JZKxKJvuBgZ5nqOZ3Yqak0ccKRM/GvQWbhgMxZM/IXuB5X0txtPxNWX?=
 =?us-ascii?Q?FSotdN8vqnL21WIOgPCHuJ+dwDqPeucAUEpwyget5Fi92ciceRi7TFlGguHr?=
 =?us-ascii?Q?ybSWMMODaFn7wqgP0KlNsF2Qp9Q6TD1DNaTsc4fNja38Lwfh2FbOuSi6n+0w?=
 =?us-ascii?Q?qXRSvm9Z4Qq0ku6X4xNqBSD9waimgqEDjFq7++uDsAwzLBO8KY81S7ZjlqHc?=
 =?us-ascii?Q?mz72upF4KGYBfEeSAIPVWVGqZMVRro4IR51U7ZGdj/we1Xp08uPPtc+niMuI?=
 =?us-ascii?Q?aUwm618YF+MtwVUv0trBcETUqXMiTTshnO+AXGpYAD3J/jX+0gF7oMJv8xl7?=
 =?us-ascii?Q?72ploUo3IjuTrBE9nn3uq/qVSFWF5B0LY5oI4xwYzF45BQSoD7PjPZzzfnWI?=
 =?us-ascii?Q?mKM7RS2pI0qzMCRNgf0gLgK+GFAcBuT4GHsTJud58FWEbSiHsvKLflwgyxrp?=
 =?us-ascii?Q?Hr8ii5Ewimo+eTSjRaQufQkAesaeywrl4TX0IpKyRLt5opjgn9ZouHUyvmDJ?=
 =?us-ascii?Q?A/+ojxDAn5Faxhl0mrbJnU7wb1agkghpI1l/6KH0pRGzuOFHZReG8duOY58G?=
 =?us-ascii?Q?qmAAuwSljDh5KxFWcPFXndDm8wN/UvUan0WqbKiwL0TCYlQXfFQEkpPahMLg?=
 =?us-ascii?Q?3z1Mw+0jg/3wB/LZjFoWLvlEUZgK7dONvxheMK9HX9KCeeWSmclzWN9mQbID?=
 =?us-ascii?Q?d5sw8VycLhRCxLkET04HmuRPsjf3wuLsA0m5USglaq0uQMmMOm9BnKG7iZYg?=
 =?us-ascii?Q?Hu9EK98erU0UQv06LSf/XnHWvgrmTZlKhvXdRjPoe6EgFGwSmmhdRJbGjz7J?=
 =?us-ascii?Q?A0ht61NL4+W+RajVvO+wFCqscKIQPg37O3/5eZxNGdpcJRXbQew/9AHQvaS+?=
 =?us-ascii?Q?4U7e25gzLveQRxaJB6W1khaFuE21GCRcP+jOBSZIh07sB/p99WSLfZYLxIHl?=
 =?us-ascii?Q?Fuou2+uXNBCsJkJZXALlv9T/8FuBI+JYMzUsJnlsj/7Wguc2bFn1hwJ/lP2/?=
 =?us-ascii?Q?6Nrb5s42m+ABZ37Fbx2CtZpdhIz8S0Y+qHpJy0MuWdggQlb8+XPva9pbzHJy?=
 =?us-ascii?Q?S86vqHIpDa9HlzdRgQQrsyisdzcmi9q897SZqx3BeB3IGBghPf+0PGQvn6pI?=
 =?us-ascii?Q?SnkCllQvHe4zRGWO7s8U0KFjkoLgHFJsjGUVdOcjCx4x0Cs5+vZWCE2FlUiD?=
 =?us-ascii?Q?b1KOJ82JwKXtcgXKTZaRV+OQsD3SQSJEie4MKwlb?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c979d7-e463-41d0-bc47-08dcc7147535
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:49:46.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20MEtez0wlVtLtzUlU6WNi+ZzHxd/aGNqGnG4EGdQCOFQmlqDqdgSwcRwHIA6xkEC9H/WjSZBHqzKg7S7wSA9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8233

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


