Return-Path: <linux-wireless+bounces-10927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D5947627
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4F31C210BE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCCB14B972;
	Mon,  5 Aug 2024 07:34:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AD14B947;
	Mon,  5 Aug 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843291; cv=fail; b=HlUJbYzGF5NRdTch+jdSvbAeefbMVfY3Z5SYkA0mKQ04wZMjzcI5ETPHWyOxvxjn5gITnmQliHFxxL+woDCeXTnXuMpDZipZyw9+HRQu3oRSuhX+OkKcE5/Jma4nY7AGjyh/J72jaoTk0frNCxNndZlkSQikb4wu/0kBCLOR6AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843291; c=relaxed/simple;
	bh=uyVPq0vuS+FMU0odfnlfw0F2eZnLPgwjnpAdPSqAp68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=og+Eajl9HZd4DkurUtwHcE1W84YjHOE6y/vnV6Unz5SYEeMDXHS0e4kKT9Mbr1hiReKlvJOgJGk3MlsWgTpbfycXbbwcfwvLwDazWDUDHzNgL1VeU5hLCiJ77fN2lkDXPdj/ALMy1RhsSBHsQ5PTSANbADqyfmYBPdddHpIjk7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we+/E4/xyM1cI9EFHrEAuoxhfyaHsAruLlPwPHzF3IDAklvHQ7B1RYISYKQhNP1c5iy/o4xHBELeWUocIzXofkxplbEkjdbTIKjDlmFxCPYHQhoa/sp5AIYDZMzHSySlGk033M0vhPr3QgPzHRiwQ4RwzX/PpsTWacllBbokYMJbqnBpVOJXea5YzQ8OrEvfp4z3DXZHrcE/ZEorHarCyXr4SAp/6lSa2YzX471uFJhprhMQfunMYg6a5OjDc/kRrmYItS0SQKtrz42sG1PekMS9afZ1J7qUoGyFWaCC94pq3WXHewgYin57OdCh3UTk90ltLTyDly955SaKwzyaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iPX8WFIoQ4QXgUD/qR3fD/Finzms7t/FKq4XAi292c=;
 b=tSJeB23WSOZIA3+wxoXQdSg9HM668gBZohqNMkKxKUXsOVAJABob/bCCEz3jXIa0tccP+35oDy3QidBePkLwypfcw4Vwsi3uSE0H3WSCaFLibg2FSTJ7ESnphbv/JqEFOmLp/7oWOaWn1Q3LXL2DpxZcWf9ApYIJssHkFhnxuLWGlkgyxoN6WXwU6aSeLDYkdunLUzjTfWyJ3mtvl1IkKwljvqPhGtuQt9OmEni4qvo6WBA4lEUw3n81DqQw3XZh+9cfaSVtDentV+Ua0qRh1KEDtMwZ3Th4Kbl2reUdVJ9ryxRbCNIPnd+V5v4bWh3WgxwMiu+21vL2MywGA2Jchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8052.apcprd03.prod.outlook.com (2603:1096:990:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 07:34:46 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.024; Mon, 5 Aug 2024
 07:34:46 +0000
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
Subject: [PATCH v8 2/5] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
Date: Mon,  5 Aug 2024 15:34:22 +0800
Message-Id: <20240805073425.3492078-3-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: d9ab381a-b1fb-4c52-7aec-08dcb52114bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nk3Ycj3HZF+DV7q4iasYLVF8fbCn3UijapLLOAz4W+hPdlyvHh42O47hiWrT?=
 =?us-ascii?Q?wWE/ISo3RqXQk3RNgRfdsoWSpEH6Ond4UYfpy9p71GXBblwdO02jvxMvkq4/?=
 =?us-ascii?Q?rIYC6hqqjJDklkyPKGZ2mhr41+Ezyo6Ga09TLwh9r04QJqWNrXixg15IeI+c?=
 =?us-ascii?Q?f6YVyA0XOCKLI7MkhP1KPf7vx6L4Yj57yYtu7k8nPs0l2KKbK4TTtw+rbbzT?=
 =?us-ascii?Q?72Za9Fzh8kiSxpgIcq0n3VtX6ieaB7Je4kmLiv+aofaeqfq7CVlOHo9iWeMc?=
 =?us-ascii?Q?p7y/BnBoXyDUHJ7WEge87utkLq1d0gGZa8eqd5kt6l/Df3jqIP2+RvT0xKGA?=
 =?us-ascii?Q?otXqcKy2xMVUNfm54jw8Upxze/Rr6iCAVMLhvwKjQlPKChwdCZbpTeun0dp7?=
 =?us-ascii?Q?nY8vol4TGim4sg0/3S6szidMVQKuM1GCta206jW5aziE5/58/oXwPP3o1pG3?=
 =?us-ascii?Q?VCBpxouVMeN6VVnyz2ZlcPr2BIZBUnqWjKEbWsXSVKCdBiRZZSbbI0IXrUC6?=
 =?us-ascii?Q?ovfI0Pl1r7Gr5RqgdYwnM967vmMNSMo9t6Io8wpDjpoAY7LK2M0RQhtN73ph?=
 =?us-ascii?Q?mC/gAfjHj/SyGLLxgNz8QDSC6NhYi2A/TvC1aao6Asn04DyuRswlO+yDYnIH?=
 =?us-ascii?Q?aYaHaeQjXWj0vp6554prDZ8oO19+67ouJuj1vnyB+MxTIOQR3N8X5yULot2k?=
 =?us-ascii?Q?u01HBuE9J/qrXsRJJGULmAMpTJLU9ht3DPG2PSlY/M0W4SSgSy+e5eqYyeyD?=
 =?us-ascii?Q?kPPYpq9jq/JOB/EmPNU504jdOqM8EkcSgH6bSL6tjWHcFTevO8w+IJ6joA9e?=
 =?us-ascii?Q?yPUumFaKDapuWQD3Qy8LbMcFw+AKwyF3gOjc8h5z05zcdTZL4fukiPKa1lIN?=
 =?us-ascii?Q?L8k7fDQg2CzZ/d1c22muB0dKZW8jBZrCHbj5kpvbe3Yz30GMb2z1/Z4vRsXy?=
 =?us-ascii?Q?AJGdpjwxBQVY9F/iKa3A5q4EvrLvSa/UFlGk0pEWMJbenOGBslLTv+tk7pOm?=
 =?us-ascii?Q?fNBaqDrvCVPQdOi2i7ETnC3upQheaaJpFjg1euei1KoWrNhqnllEJXArCT1a?=
 =?us-ascii?Q?2onZtJkiYDLQTQq5wDovYP5DYWyaZqSKz6XkQai1gt99Q7w4sBUgmKtWu5i+?=
 =?us-ascii?Q?2RGxzhNs1ucLGrCIw47hN69/NdtG6MdPdRW9SrhY17eW1fywoZe9/4QWev57?=
 =?us-ascii?Q?GZjNhFiWZTXaRnjoNx0VHSpAyrkiPoa6H/ihzRuq+6kMbE9/fEs3e2DgYMjA?=
 =?us-ascii?Q?X9y+sw1qcjT8OpoKVWC2DON5rgEefExFdxgvKTuEaiM589uzg5vbcAzwgeBl?=
 =?us-ascii?Q?YWXGbxAx+SFwlgKpotRNC38jhtpAfZWiJZc+rQnJudqVzMf6FBeWQ2bnIPaS?=
 =?us-ascii?Q?eYhgqh2sIJXmBR/Ri97bl4m3Jh00lArkVzJObOXDWGmGHYnC/f8RrjNljr+D?=
 =?us-ascii?Q?4t969dhP1qk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+iI7VxpbrM7UcPp2in4uew5NS2r2Ez36zpPZZNuSMWyY4wcRNSZ7pYuUjG28?=
 =?us-ascii?Q?/Gniv5IiZUSjVf8ZPki/7dtY794Tl6WGym+yE178dg5sIcDumxTtZSXM8oL2?=
 =?us-ascii?Q?gNX2NrRQlPcmFPYK1mrO4NFLqKGb5eaU9+BFnZW49K9mAJoIkvRC18aKyADw?=
 =?us-ascii?Q?pif+H4wI5bixOG8wXm+u9RlPi2VnjzWi+Rvide7LecMtjZKeuyp9vsr1ODir?=
 =?us-ascii?Q?LFPriR2AfPWgoMRDoO6U5jfx4xGCngqcBwdbHbnxJdgG460Fy8e4idpSCoAA?=
 =?us-ascii?Q?DB1Q2+BtkxYAftHMwAV3U0ks/m08Pnj+7qRo0CV3a801mXoX6xH49/pWkk+f?=
 =?us-ascii?Q?rQjj4ROeuF0rduWB0KtGejUf2LIV1tvt2M/1yIbJS1Prpp/Eh4iE6Wt7mND9?=
 =?us-ascii?Q?4zdyJ9W2DydTNSbTx5/bqZi4BhWLHWLDovjt+SsZKULtxnGe8dqLzb+FEdtP?=
 =?us-ascii?Q?R3NhUPEE8roDX0C3KrNbE7l8TTX34bxZNQmZhiqiPaSq/DwApqV4qdLlL1Td?=
 =?us-ascii?Q?tgqK8W5zNqgKsvwFD0+ouDbViH/6RJtHCsSfNvezl4Kxfm9wGkVvIgzE8UDo?=
 =?us-ascii?Q?uLjs6jzEgOtbK4oI8Lxair76x9Os3SphuOvvVncP+tQC8SI+WFXDBqWzuNBK?=
 =?us-ascii?Q?MH5DpyliwvtENHk2HHMtZ64utk+ZPkI0Z0CvZsWGyvEt/EQZP/3mZM4UR80e?=
 =?us-ascii?Q?Cj8uSC3YehALIFsL2JJX10UMksG/Gl2GagHR7GaugEWfEtxHekYDY/AO5FaX?=
 =?us-ascii?Q?K9CUARddCOo7sb0TBa6xxDgcP7Me5UIE2JePc45bRbM6C4HpHdpHSVsYyNHC?=
 =?us-ascii?Q?LJFEsowZ3/T05A6IgT5diyULuV3yRjTbBc/QWxOVbXiC8XR/NM5z/gZgwy2E?=
 =?us-ascii?Q?7r4R7nuG7gaa8RQPJbXKhd4dBmcWmcEJA+Kc74hlRAPhhK4x1hye37iZ/n/K?=
 =?us-ascii?Q?4eFFl+0sGbGZeHgevXsIxQ3BkFUjceCnG33DL1l3eBa54Wq8XRYVK3ontSeP?=
 =?us-ascii?Q?IbJXdOjRdUpReVGwtIf0ch1RPnLCZfhV6m3uGAaj2OFauPCoTgvBKE45sgTL?=
 =?us-ascii?Q?FlAsgCS+QOb7dgn7ARuwHEcqvZ8oM9LRI5V7VKU6cO0zPakgx34pz7uoTL7W?=
 =?us-ascii?Q?5hrGF8K7V41sPJPr6tdHXVFFK7g22ANgHdPk2FS0eNe0GxfRNjlTJkxdmr2X?=
 =?us-ascii?Q?TrvOXA/kMKXX75iePJIkpBA0T/f8pdUVnatXRVzaB8iZzC5Ijz+Ag7CsqRQ2?=
 =?us-ascii?Q?QgtZuQ679yvCf+ELnIWE4NcdjOj64R+kMPTGJjbmEkApfTGC1fFH9byvpo/w?=
 =?us-ascii?Q?h9/in8RxFqJYboqgPcTicKivmhjzSdz64mt4KfXUbHFaCxR72tHSN90QneaL?=
 =?us-ascii?Q?Bc+rVfZbhqsLsYvPVV1BPGbFNTMJE02dvNcTmA+VKJMzOQkz6Nnjf3mTqiGk?=
 =?us-ascii?Q?MCDEfYRR6Nv7rREE9HA4RJC9iD/uI5BHECUYg/kaduUtfP3J81C0esU7KnVT?=
 =?us-ascii?Q?Fz66I7xGVy34aFQv0ZvXKc+jTSo+nW/INpESqOVhwGn9uhPJc7z+WNmj2JFc?=
 =?us-ascii?Q?kRfLF+G3ZMs9+DsfTqo2uIqkMe8VWm3dZ6eRNK3z?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ab381a-b1fb-4c52-7aec-08dcb52114bc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 07:34:46.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNeuXvtPGjjOA/hUdV9xez7Oid8GSPuO66NYLc47qb/GXb/Fko3W9r7DHxc0d6/9XMtmBHDOLmtQmREfht8lIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8052

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


