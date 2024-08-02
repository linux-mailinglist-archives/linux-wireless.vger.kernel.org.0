Return-Path: <linux-wireless+bounces-10847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A891F945666
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 04:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAAD1C2281F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 02:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2863B796;
	Fri,  2 Aug 2024 02:57:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B881C6B4;
	Fri,  2 Aug 2024 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567460; cv=fail; b=qkmozGIEnw3HvBJhzQu5MwmLwRYPdTZ7b4eAb12rtmHC9fePFAYDGah2aSwctx5eepB0LAOCj02OLkPsaNdvXcQ0yavocGu839FoGxIB9Ufjfiv6js5FAMc+UkKwUtb9GQm2iNV8HncHv5MM82welTwoWiMmPnenm3I2O+fxSJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567460; c=relaxed/simple;
	bh=2VnM3Xke/V+FBPoCBZ6dXFpkeLfGCL5kEesF20cliAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYqiFVhuVXYCNrB3SZmbLG03zDi3ds+SYjglboGNQljHPZ29srataE722SxxImoql1MCeWn19xMHugJXDDnOkvTO6KCU0ZCAXWl0dTkeYuZvgd7UDWBj1mjJH+riNQqP8b2aLW5USeb4usQ6VZmaDmDQVtpqwBGV4/jsWGfgqeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx2x+S/4Swd/SwvKjwvIzDIg6hFLdwhmSerASxPOkr+0MOX1Rg7FOTXeRu1ax1UpqXPmv41GXV+de+D0JDCcYSzFl6jyKYjM4/I5DIxarsAbewmFUx5fXgCxv1ozKqavce8lJZdrmZkHmyis+gi+H7Bed9QYk/y4+YuUdO91GNXOy5ECcZtDOHuxfEwfeKCGfxNRusTutiwhWB4/13Bpb082yVjjGMqBwJgbF7887d2QL8SADugvKpnrTrtDUGYbJze8zQ63V1ypl5c91RnMMDwCTdv4yf2VheeWKD1xM6uRQ+D7dZFgrETrX2gJ+Tqj7pAMAAoW9LWRxM3b6VTtZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ZCKui3FOaZbR8MmUilWzOmfwqy4Ji7tdvVIJh0aaI=;
 b=hi3ZmfJ4xswtINYAJfMj4xRVamLGWR1lUZXJSxSoeIN3DNNT1buD7I3R0AegsulmQrMi8TJRxb7bWh13d4aoa2MA/51dRl45nuwnLkWVpuWGQE4pE72rWsA6BPmwm/9BopjitDJYOJQ1Icsskp2cmrfTECnBQDv7cUt14j6GfP2RAZTh2Hq9ACRJ8L9RfVrELFXmkpbigOJ2vzrldENOwZVGfLHHMFG77XEasTjbq2KCYyz7v5VQ50hvqYlBtZ/tFGknNjzb+1O5NaI9G1olRe3oERIJL9hc3Yjqi+sZA8M1RLG+Hnkt8M/eNZCvm3am0kADTTFIVkPSDiiSDzGwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7120.apcprd03.prod.outlook.com (2603:1096:101:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 02:57:33 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Fri, 2 Aug 2024
 02:57:33 +0000
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
Subject: [PATCH v7 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Fri,  2 Aug 2024 10:57:11 +0800
Message-Id: <20240802025715.2360456-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802025715.2360456-1-jacobe.zang@wesion.com>
References: <20240802025715.2360456-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 6133089a-f584-4df3-e79b-08dcb29edafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OwnDRzYd5e8E1jzv+vJX4sRadcZpZ2EhCpEd2R7quXBonWCYuRj73JziV7Ql?=
 =?us-ascii?Q?KrJXKnhL/MbTKvxii4vkBAZIqKGGnCY5WktXc8GPZSn+y/J6mPEgrXrMwHTy?=
 =?us-ascii?Q?JcayCV4Fm37gq01jDg/GUrML5CGWfZ58ZerCYmMvRC7zOSobWB9Nz7SGoDJ4?=
 =?us-ascii?Q?h5/qbhtFNlwUAdfC/95UCGt+lX+leRWtDfby7EvYSsr26j9s4YBYPdXPbt0i?=
 =?us-ascii?Q?KXHNcufxFNUsVtLqX6eXO5XMGLsSw2SP6juUnuTA4kY7TLgVnenAtmcyqpu+?=
 =?us-ascii?Q?0yZde8LmNm0kSbhClslxmx3R0/AJdL+eLiVucb+N4ckEB/+6ADT1vuhBAmjw?=
 =?us-ascii?Q?oOWwxZM3Nl34Kbsq+OEBSwB0xygbjk3R0xc3Oaslhz2ZO8e2hmkh2CsozRu9?=
 =?us-ascii?Q?u+prHEECtxNqfCac3isFmCIJ1A/GYCZDuh5gCXxR5ureqJtaF0mTxhJkdJ83?=
 =?us-ascii?Q?eEWb1I9oH87bdaOL1G37t3qRwG4wssIyMcSmKjEG39su9nn1mRiiRlpcSVRw?=
 =?us-ascii?Q?XVYuEXweithsMticTd7ZR6fLyph49Mdb4nKosS6GRiGDESasomqqhMD5NfBu?=
 =?us-ascii?Q?FLeiGKdJ05Eqmvxiu+OUyCzJq1AqsU/R9zu/RdhuO1OL6/ANfagUvlba43aj?=
 =?us-ascii?Q?ofdxq6UEe7hnyuII0LvBC3xSMlbN4XoupATJ30gvhHeob6sXlWggpAk0GhpX?=
 =?us-ascii?Q?rMEIzNkGHm+kSEb7Z/i/s5U39gXdnf505T7XIZJvn9WU6gaNSjs/m2QOJk0d?=
 =?us-ascii?Q?xmIaAHRuCt7GlGE1wxE3uGW3cNynukRnO2p+GrL7yxXz1ZV5NsFOfjF1myRN?=
 =?us-ascii?Q?SA33IHOQjUtOumK/VrBrQ4odwb60jeEhx1y6012RqI3CafvHpF0+t+8/EMBm?=
 =?us-ascii?Q?nmtH5+pDCv3IPbrFoZEEqL9pK6ozx1hqiMCO340SyOuIC4ZnF+wweNu+lKU0?=
 =?us-ascii?Q?6Pl9BG6offmXSzCWdxtDzJUe6ueSahVhnFhPgyhEALttW4QDqsa7zbqjWOrD?=
 =?us-ascii?Q?CoTptTrIN+GK+9SEtmEjh7RSYSKKJZ1RYd0pvAPOdL935VbidoYloiNGUuUY?=
 =?us-ascii?Q?ShOA/RJD6pEfc1Iyy/Ghe/22BVs6s5WX5goL6jZi4P5EK3fm9m7SjRwB3B/3?=
 =?us-ascii?Q?uLbN+LHGn1jqyPKDAQiwLraOHKWxjXpJNPiJoQcQLu26DFj3JPYnz7xirWu+?=
 =?us-ascii?Q?C4+fZ4UY3ddCf6B/N57EVSpfEpv/gqp86pECYi25uMpTnoU64a8ZGlunMz7a?=
 =?us-ascii?Q?2g3yP3jv9df6V36Ky6N/Q00I0kWQiAp0cooGmqz6S+ZrhUkARl0k7LjHuUbv?=
 =?us-ascii?Q?wVeyRsHvMKsDVAzNCXgMKkiJYcQGOBfhphkZf/hNDxReD2QXXc3MO4kHR/pN?=
 =?us-ascii?Q?IyaxPeGYH9T17iys9MOs+RMGStO4f/8LLku9Q8Ta4dfVHbn8mV85Dif8mO5l?=
 =?us-ascii?Q?5290M24EpkM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikLvRhe2DULS5GpFTQwIhgE+kZ8ErfqFpAao140UOyVbxREMrGWQOQX+WWoY?=
 =?us-ascii?Q?caXuyZik7//W3ZdOIaxo8r4Na/hzjwbR1mG0Nn7m+CcEUkcq/2Gc0WLZBJfY?=
 =?us-ascii?Q?5SNWUQgEVddAvJ9TCc+Utdo04gPaNlOHMAtQ0/lGTi01/YZDO4uGB1k8uRgP?=
 =?us-ascii?Q?ZVX1xjMq9imVLjXSoQ6rXcwfnmpLbuR4dV80VpyQfJahj7Ya0hbTUJlqFc4l?=
 =?us-ascii?Q?ZcvcnN/RTFks416atPGUfBjNsRdgZE2KV7U8bjN7j4Qrvletw+KNpt1rlsy9?=
 =?us-ascii?Q?Aiyla46FjgZULmFbOMp99zO4auPlxewrDsJQhbB2HzY6CDnb1uiUVX588scD?=
 =?us-ascii?Q?HP55qpjvQzCdmH9ZdL3ezMqL2wwQBmCUTn1NlIBEPiVHipxqLq/1NB6hIsMa?=
 =?us-ascii?Q?3zCm2PbFKSMRWXJGDs28SZJT8H7mJa/1t5QCmZ/dwNgZ/zl8PAcwjSwxFmGU?=
 =?us-ascii?Q?UKlZ94alTJyfge6OL02cVkyTX5odVJjvJgpLGP9Ycw2wZa0yI4TzcbJ+GlIc?=
 =?us-ascii?Q?ezLaTtJ2ufUelShAcrbEIBY4a09iiSZqALHEJjsE7gUlLGdZjm7IjxedRY+y?=
 =?us-ascii?Q?yvK56fdbLV8P7VfqJUZILqLU7APHweZ45W9KsdKY4ld3CZoJ6heDJBg4vBtP?=
 =?us-ascii?Q?0ef6AXQGH3NvbPTKHqOtgNTercIrtlAs4dJSDwfPmgNoON02fXWwUPv0X3A6?=
 =?us-ascii?Q?eC2eGUrBwwi7XfebEWGm5N+XTq3ADzIi+va6C1KY2H7aSvY9y9bCGFP9ceIR?=
 =?us-ascii?Q?GoDZF+p71hY0L5Bk2HFO2Wp5Ev25axb4AmStToWF6EPbDanh6xFZZ/9mwzof?=
 =?us-ascii?Q?xvbRfPuUTbFmBfK3ZurozHWxYnbXfxce4crCxQEbEynyFx/vDRupiLQexaP2?=
 =?us-ascii?Q?pHet1RP4meVyDZTKcrktoAluM9z/nnrct+LEPCzXDdhk99Q+CipzspC5ssHa?=
 =?us-ascii?Q?D9hlPA5076SXXqYF+3jkSKcc5RgnT/1rgQ0YgS3c9WYVWb8EtwwQd9+tJCOq?=
 =?us-ascii?Q?N7yLoBf93YDWOeItnB8RkpjPW3l++21jrqUB80i8yO/BP3wbDOyZ52IJPdJG?=
 =?us-ascii?Q?ZQY7F9LUJDpePijewMjpxYNrh/X1A7GBaupQ5pQCzRPV1EwshFJ3Zcju5Om8?=
 =?us-ascii?Q?YG1ToaAHajFZrpVs6dGwNttOMr5IEPkDWQsuZoIl0kdoCVOQfnJo6jWVgfac?=
 =?us-ascii?Q?m6pNNY4rf8sBFY1Q8IQl2nqEE91tzLcOkE0qio4n4siO/eASVkrHlNjWhqgt?=
 =?us-ascii?Q?PGz6zRiQ4sW/s1EKoRIEgZl+MaKIjQ4QXi0uFB0kYhDbalNIvwh+mCJVx2tF?=
 =?us-ascii?Q?/L8BFIUbgbVCMKuR97BQvwZ4wVW8LIPfH3Km48aIkjLYOr+RXawJ+ky47U96?=
 =?us-ascii?Q?q6Ya4sXeo45Ci4le6kRR1VZMc0KmGou4cHpLstxM8Eux0DN/MRJHxRoB+tgd?=
 =?us-ascii?Q?d+iGApGsFFGlDHf6OXmSfmIczD8kpCefCoWEtXdL4kpDRmn4MEAG4JXRVC18?=
 =?us-ascii?Q?8kOwTR16YaxgK6NwmHdzNbsLLkR6DMvtRo8IERTsbLJmT0hrzhWv4XIw4XYu?=
 =?us-ascii?Q?pqUoWAf831yk16cyxXjfbgbT/PtZNxy/WfeTIR/m?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6133089a-f584-4df3-e79b-08dcb29edafc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 02:57:33.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hAGvb8rHvLGLwznYa1DwVtymiKX4/EXJh5lrRc9U3fSEQZVXlUg/+VN0r2RBL38bFXOBu82/FOialC7jufilw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7120

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


