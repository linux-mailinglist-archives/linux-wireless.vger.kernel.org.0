Return-Path: <linux-wireless+bounces-10926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE8947624
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E511F2167E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0F14A0A2;
	Mon,  5 Aug 2024 07:34:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFF149C77;
	Mon,  5 Aug 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843287; cv=fail; b=cfI5gcpGEGUkvFlrt+IoEjXjO4jH7vd0WkyjyDpeJ6g3bKmu6BbCfYSO+7dgmP1WV9x8vCInFW0b2KiRtK8IiZfRtf295Ss2eeKM6HfkcLMj0jWDmqpf5Net+kqELE8jmBk3Pm0tLQXK7QkRVLEAcJoy6iIeGlIs2WgkBrxVnk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843287; c=relaxed/simple;
	bh=2VnM3Xke/V+FBPoCBZ6dXFpkeLfGCL5kEesF20cliAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UcVkogYO4r13BRXhFndFMjV1Ob8LKzxTZXC8Z+xjBknIZESnsm9PPC0ntzrK/MU5/8t8+VrdDhJlq5aTGaO3bySSabYLqVpltxkrD2StK5wuvP+Aniqf2B9qu0FHfX5lmLuR9ZINh+qSVgKWkDgB2EfwuwCSv6Afp2J2XjVLn/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN3ZFHzdsgx9HFW3bGBecRW+0866MfYfhcPLSV//96lArVxCJnHm2+HyVk8gu8byQUyIXy3v4rgPXPa/jt6dBFxnTGyvLU8B2yTiMg7L7fMNmadnA/QQ3P3cBmROb7UJ70uVm1B9JJAy0mK+mc8VcR+rS9c2lg14icA3AETycl8iF7jQZJ46UzRricV2z4gZkr9EY7MSrNT0U8CXwPMKeH4krGEh0ZOLvT7OeWABV3aSfiSF0Ef16UFfDAoJ+ka1NxrHkRGZF2m6OavE/wVdWFyRjxSuxPJCY+AkJxz9jf97KQMrYtFPEFxhu4nao8B5A4q0qqnQ1xwhM6mSiA2IIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ZCKui3FOaZbR8MmUilWzOmfwqy4Ji7tdvVIJh0aaI=;
 b=okC1YdrKWHLwxl/sPQjCrGjFqYrAccZvBaLWWB0ZISaRnK2hUq/h+Ei5obOPaXG9ANqmcMa8y0DWxGzYRyhse4VTMHWFfu1d8ROk5Jt2hTwWvw8eEMnR0dXzPJFjkyCCpTCwumNB2pkeo5a3BYA9/PDNnHyXZFJvl6lmdLIh77bz8mhKwb7RAWZmTbEvgaCVFOFvlHiOMpfbz6O57ovf1JfVCgeUcelrgiQua0Q2u7AXtHobVVEXBojwrgcK8SJ/LJNA1zgRDQVdEfeBgjWh9A8H3hQ0c/M3DCUtgn8Aw2qmXrTBoDsdZtDJJJbo3csrcD+T5k5uAmLlkzKluvGpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8052.apcprd03.prod.outlook.com (2603:1096:990:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 07:34:42 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.024; Mon, 5 Aug 2024
 07:34:42 +0000
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
Subject: [PATCH v8 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Mon,  5 Aug 2024 15:34:21 +0800
Message-Id: <20240805073425.3492078-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805073425.3492078-1-jacobe.zang@wesion.com>
References: <20240805073425.3492078-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: f8935d96-f9ce-4187-9e2b-08dcb5211205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5N2S968RvyMnOH4+9cubPipH9jis1X6pCrb7wT0ZTUVYKner/DzQ4pZv/Jig?=
 =?us-ascii?Q?5sMhwERbQzZFrIRWAsk5LheiSg9ny3Dpz5/Qj6nUjPz2hy+34OStYGRVEurv?=
 =?us-ascii?Q?jlWAk9COsQAKd6sQhbyHjLXSDTMwO2IE//yIzNrPgMSbXT0yL07VV5aYk1aV?=
 =?us-ascii?Q?aTMdcFnio0GSxDrout3k6NJ8ZelecF/f9lK3J+JMC2sul/9+98UuCtgbfFlX?=
 =?us-ascii?Q?hIhc/hQCkIMZQ5XXpKIRsGv5NMM+LY4APvVNV3BxudteTFEaHpByekSgKTbZ?=
 =?us-ascii?Q?B8WVTZmLuRvmaWToLTXymOnz/5K6/yOa/L4JaUOR6AgNnW2JFjtaj1Xt3SoS?=
 =?us-ascii?Q?xM9sC0/UQ+g5p78jLi3zfjQfhJiHE/wpbzZ+WJJ6hfaVjPTpmeetICOuukF0?=
 =?us-ascii?Q?fL++NVjsIM3c40FHRL5njZOXLNt6wUZ/BPiN17arZxFw6ObNJxAT2EorSq84?=
 =?us-ascii?Q?PrPc2D7xu7a1F2W67Sr53i/rPHti98i6ozvKNMCasfP8zZ/y5BVbz8o75Za+?=
 =?us-ascii?Q?ZVbYdAxwzr6PIxyLVEi46aF+SQMdYfIzCkIGxkrXBiaL2gi6GVkA/G0lhPEp?=
 =?us-ascii?Q?og4a6SCpmJ73eAtVo863eNQjZy0xCglLerApTq5WQmVEaaxJE1AMIZyXeIbu?=
 =?us-ascii?Q?6YHq58VYp1Lip0Q6d+99O6Ryeo1YfyNnJog82HheCT/UQ9a0BZPe5ZHJMOR0?=
 =?us-ascii?Q?Dbb2AIDHMXrqUWPeAWGu5EEbDYkLMvmHm+ZfyqM2u76UY9v1rYWl75FBPLC9?=
 =?us-ascii?Q?LmwmFmc2o24KWBaI8nLxWeyz9AJc6+ALBKzEROke2DySPsrQzH8nCOK0Ve7k?=
 =?us-ascii?Q?pdWiwHeYWV+0uvoSgv6LQ6RWb5ci5cSM/2RV1tqMercZWx9tIhnu49Bxb0ym?=
 =?us-ascii?Q?vu0NtoJaDUTxNU+hoI31J4cNoPsXLrQmcpPWgYSJTbxImVxBcXtrnQPuWHGf?=
 =?us-ascii?Q?Pq20+yZh0doajM72XMq7gTkniJ7BXvBKep96tdVdOfvCSUD54hVSglPZjzGZ?=
 =?us-ascii?Q?Y5OmfNjSsSQwGiVJUc1ZHL609rJ6hJ2vFBHj6SgnKDh38yOX1xacaq5nMFAu?=
 =?us-ascii?Q?IcZZ1G0C6kn7ZAXtoROACJzMnTHp7UH2YERH6ogUIZN2/3HDU/v8PkOa6l5g?=
 =?us-ascii?Q?RQdUkZee3IB1jQC2yJ7Co8z/ZftXD4NEC+kbOQAico2+dhuV5dCdp0WUcit4?=
 =?us-ascii?Q?MugPwhgKUQWY/PZJAbq0B1Vc2+mv70bIqehcPcZzaPunHdzxrzD8DneOTsKz?=
 =?us-ascii?Q?c8WkO3NizGimj6XKbqCfi7OE+vmV5CHNrLaEEJySl0lnCDGYrhqCSXxTDdlC?=
 =?us-ascii?Q?NzyQA7c9OQpNA7iDXQmmxXHrZ2CqLYRPm16PGj+Em2kfEzvWFUrFJ12mVtyS?=
 =?us-ascii?Q?V1U8+5ccNWagiIrdqqYetrJWl+NW6WssxLyezZfucC/dIxVnQqTHhfWgz3co?=
 =?us-ascii?Q?2wltiAku1a4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oh80dL0QzFEX089mx0/znWXGXPdIyCkTXxhy4/vT64x2pzGcnM4+He5Rxzy+?=
 =?us-ascii?Q?mcU4K9dcO0CJQ2KVMBXAw1FZKVfL+zaJc5qHCFok2+aYh46bqBDIz1SwsW9+?=
 =?us-ascii?Q?8QHa2m7nCtEWhRO2J9n8fht0PEGvQjBqMpmPICN/MKBrQdOtO/J/WOV/IXuU?=
 =?us-ascii?Q?CgTLs3n01alWn0KkD6XeazXkWbpmfLbIMC+BqfNsQr2uTQt62vpu9TTRoXlO?=
 =?us-ascii?Q?zX9N+QHVpTNlVCkh6m6aMUoL13b3yD5zFbmga6sDj3R7GxtJjAU1UvOhpPXd?=
 =?us-ascii?Q?pNEoBqvaqSKLk9rL+EENUpVNCb1t3At4KEHsvMaDTa9xXx0NX7nmsRmJiI76?=
 =?us-ascii?Q?Nz3apG0KLYxwtw5Sm5wqrKOrEWfg6DlEEIaFEC3OXo6zcBpJEKVDYjdxBNVs?=
 =?us-ascii?Q?7wGEYI4f9xv8dUV9yo3qo6EsGTZOCKwMCmeGwUNrbAhEMUA866NsCAauLaQC?=
 =?us-ascii?Q?jiI0+/13x/C4DZnDoG2JGCapk/HwaVb0uYnb7Be/PhxDhyqxWbVJ5g8h7+Z1?=
 =?us-ascii?Q?J5E5eHFIFEl2RBGnl6lj6GRxEndRopwwapUdlVgLzhNhAYl5rB7OXul2QDmQ?=
 =?us-ascii?Q?lpB7gfxrTFbZkZrahCSe4+YGs58OxZTY3WE2eVOvQTocym+8N3dNKng1PPqR?=
 =?us-ascii?Q?lHlEThdLW3dDypmF22cmEyLz8uXGHjdc3IMG17DbTHbwmfUmuAedURNx3+bn?=
 =?us-ascii?Q?YtYYOquobIQCtNMfJRqLONi+1dW8lyjJqOskpIaKxmzgRr8tkxwLcswuPsU+?=
 =?us-ascii?Q?5tQtZIuYUKlrpURDIkPqN4Vt54gfF1i4Un0P/W+RMpXzuCixs8mVOKOrK7Td?=
 =?us-ascii?Q?bktzO1oeG9otHMeT6QpEoi45bm9KbalV+EpjsEkecwJtY0oZ97OdpL0bCXJn?=
 =?us-ascii?Q?wvBJ8MdYzR6PXtngi+zvNzHp8Vm6597gBlqRdUY2K++KnMBABcMg6wWUe9EL?=
 =?us-ascii?Q?GCu99wkT08m01B/ecAFauov1X/guWtlLcoxxXtweSrjTO3Cmd8ydH1xiH3la?=
 =?us-ascii?Q?P69g6Z8xvTq11vysA+AKQe8He2slylen8LEDpB+xrploaHWwe6jgqUC6qR9A?=
 =?us-ascii?Q?WapulDMv0tAI4XYJS2sGetOvcHAINHYXO7UebR+TN7WzrIJ/2BsYSPfOUoL6?=
 =?us-ascii?Q?+tVJ9NI/OxHw16GUAml0a3lpOMjGCdvvCnFc8K1nLjiL3es1gSDgw/q/xGEn?=
 =?us-ascii?Q?A2hLlbV6If1Qhkf/z/xEj8Ya8Z7BV8UA/EjDLG7/Ili96RUfedf9mS2csXVK?=
 =?us-ascii?Q?Z8jEtrXoPHghde/pOZLXejqS8yBCgMWxPO66UsS7CJjLMYunYETiro4o8pOC?=
 =?us-ascii?Q?H9saguamB6umZRogH2W3IxkrYj8Jbu4JYP51Y54kf2G0uEKXjTE+A8TMZvEC?=
 =?us-ascii?Q?MpZolahnvak1rUAzNdiNR70SArwcR8AOYvdm5P95lztjtGBhFFKjWRZl1tNH?=
 =?us-ascii?Q?FOD63Op756ErH/+pXHkGCSxjtZ2YI2mXG8vexoxdyy51fCFzReQ6g2K/S+0W?=
 =?us-ascii?Q?hSXd3Gx4gw95OJaNDWfCpdcrc4doUPOWGu2PTtfKG6DpTms0U26xGRRSlZtd?=
 =?us-ascii?Q?nUATwprpk7bVAnBj9rmcO5EBqVQSkQUp5cR2gJjv?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8935d96-f9ce-4187-9e2b-08dcb5211205
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 07:34:42.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rm60PySdrLAXG+eNHsyzEtL2Txk/bI2vKRszfK9fmcjtofDhext7P/FYpcCfOnI2yH+U61IGtFaq/IPzLy8Wpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8052

It's the device id used by AP6275P which is the Wi-Fi module
used by Rockchip's RK3588 evaluation board and also used in
some other RK3588 boards.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
index e564f20d8f415..2c2093c77ec9a 100644
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -53,6 +53,7 @@ properties:
           - pci14e4,4488  # BCM4377
           - pci14e4,4425  # BCM4378
           - pci14e4,4433  # BCM4387
+          - pci14e4,449d  # BCM43752
 
   reg:
     description: SDIO function number for the device (for most cases
-- 
2.34.1


