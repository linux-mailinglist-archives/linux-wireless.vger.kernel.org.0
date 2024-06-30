Return-Path: <linux-wireless+bounces-9703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1479B91D053
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF07F2818CE
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F5244C81;
	Sun, 30 Jun 2024 07:36:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AAC3F9D2;
	Sun, 30 Jun 2024 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719732988; cv=fail; b=Wa7zakBQ0bdfYrWSEjh/DE3pB1rP1ccK6bILYAkWtJr9qRoGph2w9tyI8tB5N/CWIjf1cOljBkMbql4hieFWs1whAUJKIixEmUEeiuii8I15Dqogp7+NTO4Uo1tmTEnkHvZlJ+5B/E0Z61QuYG8p3ZxSvCJ28zGSdMx4gJ433x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719732988; c=relaxed/simple;
	bh=CxVnHqGbck0jy6Cauk18/Fp4zXt6EBs1W5+WVwd7UFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ebJUeA0d5QRXWvPv/+aog92VDS0er8YisUWD3SA5ucBvQZUa+dRqrK6Sk9L0W/bbIJoOCrxO9CiYmWQ1S+BQe0YvEUZHCCAvtlJfHqvmNPAfldHi2Pzl5ESuBZSCxUlMO6+DM5yVtZagP7rIhS9MgJ/cOJicp/7FJzkSbbGDifk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrIqK3AEav1D+dD6zgCwzkdlu7VuOBsceeuF34oEov9filGDTjBbp9zUqYD8PduC9SXwwp7DjHjHgnenUKGcyQF50Z53ZdkU83C5K7G0CdMNkaYQoZ3vxPslvU3tDMZnIDBaxZdgvGjDSmPTL+Stb5lj7kTuX4dvEBMBdht/+2JhQuhxMxuygFKtMmqgsA3ZoW3Iy5L1QOarPH0XsvdDgsNOI0YHi/ZuN7aQAo1pWjqD6iwmSNwvBMv0ZTVVlK/KcepCHGqofN5uUA7+bm6SsJH4sJLQ2cyJ3Ez0ccJ07YWHHj9c4WfqZBjPX9xkrwBWmymLNP3f/7BmW2v3sNCcXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHMSDZtLNXiF1aO1RXytlyH2FF7rx+CJg2ro32Jw72M=;
 b=J1XscHfy9oD5IekvTVH40dJtfimgZAh5MgV9xdAPtU9EjgVwFaI6Rehyds5g7YxLwI0alQjmp7MziLkbr2DVstFR2XVJCBnA5DYTnFa8sN5EJO4HG3+Qh1x9D8JaLlxGmd/L64Kg/wykiALLlKjLsww2Q+qNe5FROh3INgLTiVWcC7LE1Joz/UmRn2/16gr7dZrWui4x8t3nL+80QzzLCk8EuvKlHUQOwySDM2bfeAGWu6SxHt2DZuZ7CcNbupE6BUkazxNeI7OaNXuB9iFR5y7Bl7VlEqLTDAyiFMGqhSsuA1Pn9Uie4BGJWEkrF65La3a2TISdEeY+myL5OCQpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by PUZPR03MB7234.apcprd03.prod.outlook.com (2603:1096:301:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sun, 30 Jun
 2024 07:36:22 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 07:36:22 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	conor+dt@kernel.org
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
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v3 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Sun, 30 Jun 2024 15:36:01 +0800
Message-Id: <20240630073605.2164346-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630073605.2164346-1-jacobe.zang@wesion.com>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|PUZPR03MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: fb723812-25ec-4da6-1386-08dc98d75696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBonuy1aOSP5Kueax/3cm08cafuul6/hDcPSIYldOLAQZFNZS+/34tYkvWv9?=
 =?us-ascii?Q?/8Um1xLldUgt6Wh/xSgS78vnH++VvwbPK7tXoAoHYntmfKRo2q9r6kS5+3cV?=
 =?us-ascii?Q?DszJuty47czS7hh8dJQFZR18Ao0mmxh+EZSOsQEMfBILSgXdCvIW5qok0261?=
 =?us-ascii?Q?p6HDXENxuKclFgf3/HltcDLNd2H5h7I2HgqkLXx3UeTCWJQxxWMJBQAqe/V5?=
 =?us-ascii?Q?GX3EXqKwhW6/Fh8GBnGWaX12XlxLi6fLTVfP9kmM+9Vj6d7opQQGlFmne7Er?=
 =?us-ascii?Q?xEpg191EZQvp/HG8iepNRmXlFfvFQiNnIAkoR7VHlqRBkA4StSJ25+OL+J98?=
 =?us-ascii?Q?ny0Y0lAEF4BZ0rF3EywpYi9K9TsDvz1YyNfVo/MRMYniwkfBQecmYlsaLsn0?=
 =?us-ascii?Q?xGgmWZZMeColgrlhLjOJNVMP7fwHtqaD4mieSyylRTjp2xzqSTFKQnNFC8L3?=
 =?us-ascii?Q?KvvOedzcHE6HG6dSUOZoHOZLfLtlI8J42vU7t/KsXE38jnor18Rlg+3Axxvx?=
 =?us-ascii?Q?5PyBnJgQECfb9twozsm7QRIDC9NaMLbT8Q9bXLQIaX97D+8XUtaDbZWBnNK6?=
 =?us-ascii?Q?u+NZcIFocOzqzuNuHYB9ImXBR3IaCMsGDrWbqIBHHVdeMQLPS3KazBHpPdaa?=
 =?us-ascii?Q?6LFQBIdKFe37TkTrhFAd21t32sMpf2DLk+PFn3chcqjULoITjrmZtBRKyGFV?=
 =?us-ascii?Q?l4XMyIR0G1V5Q2ZJ8d17Kb0A3rQaTp93ijY/Td02khH4PrGjSLyGQZAW6hdk?=
 =?us-ascii?Q?/vtiDckGt6lyVb1iKw1uyFOQet/NuHSRXBGh0MUm4KSE+8VXO9THVgQSS1Qy?=
 =?us-ascii?Q?zRBr6/vhFrRuPyvfVgjCgfXrvI4uvndWugvci1YCCLAClxYeeGJVbylWed8i?=
 =?us-ascii?Q?XEmgtXvvBDfCBwq3m6iaFSxol0q6Lqnfaza1kve8so4mA0y9BDbiXWBG+l6w?=
 =?us-ascii?Q?cQ12HZpzYhGm8KpkqueqdLkOL8h46wZ/DjHb/u5vg1efW9I7zHgsax8bvwxL?=
 =?us-ascii?Q?spIKcv2V92MhZaS7QoUAyty1be++0JGMPIBfKK8uuxtA2M9k9nMfobidGu9U?=
 =?us-ascii?Q?p3VfCskc3qLj3tDjFnqXp2rRj+lgbk8npRkyiPiv7C6uDwOspAdzsMZjkFer?=
 =?us-ascii?Q?u4kZlduhbjLFXtKGl2kCJyJqGlyUe2Va1dhEYP2YlYqpIsAD/1iryQXScaiU?=
 =?us-ascii?Q?eqTyFl2t2zbJ0Qi7wG1N9Z+vG4osc5Aw1BxA4sV4WJj7kHJFrGETCFqV0frj?=
 =?us-ascii?Q?NYmrXNcQm2/XEy4BqIvuyCGyJrAlIh8vG2bFMRxAlj6ZlZovk+DfcOKoL6+m?=
 =?us-ascii?Q?t2ELsEmGRD3I24xkjKdjGuS3KCUzQBNwkdlO1InZczee2dvW11cTXZLQMj3Y?=
 =?us-ascii?Q?AwjdG4tcTAbPPOHoA5W7hm+vDmA4T/Krx2Eywfk5ppl906l0eg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0cc9FSyZGCQ69YQbOP/W9YCMf49DWXwkQTJtDRRFEIK39qhnleSDO0lYTuu?=
 =?us-ascii?Q?weWqNUlZ46BAnOf3TJaeo7p8oiUfl/9Bq+JGFF6p9eMO95vTaiBN2c3Rd9a0?=
 =?us-ascii?Q?TE1xblanzLZ/qJMt0Zgp3thLkGU2/sHtWivkUVTFv737miHaZAPJOEvqRTsB?=
 =?us-ascii?Q?76UkUxo/8/W2KFMFWwOyLgf/2ffs77iTls4Yb5S6/oz++gQTOZP06YNWuyHJ?=
 =?us-ascii?Q?uCHA3b+CkIqzb1Gq3xId9qZZ40b5Z9Ae0Brp0Ea9dfx5z3l7qeZG3KJjibYz?=
 =?us-ascii?Q?Tq0mP+PemKAmgfp2nr0QI0/hTbJc7fRqNUEkw0RNlxc9gMKUXWYmkhsZpKTJ?=
 =?us-ascii?Q?X/Rcuo91jC2c4tu4BYskh+liYPuGF9gJbMuxNSLTMzqdVf8k+BTjqKp8mUF3?=
 =?us-ascii?Q?9Cx/YrySJmQAs/2Th5ttTGobvgjQWkpaNvmxkARu53Bc8Duiqfejr9+ilo05?=
 =?us-ascii?Q?aItW3J1uMWN3vMTjFdQoqs/pgWmnCa2FzrfAadzyLpdnw6T6xYHpza3yrD2o?=
 =?us-ascii?Q?lzE/fMRhLgJln3knjsRrmhdExiJXV8NjUTUVShzVXIasCfA3zt8D3e0kLCGU?=
 =?us-ascii?Q?7xmQM52ld0jn/Pr4yio86w6y+IBkay/ccqMQ7UiTf8rX8M386HatifTeaJAk?=
 =?us-ascii?Q?l9/z6Pj1cg0GBJZD/ipcQ4cvEbxyuT+WW9FhhmhyEsPyMItd8XgnJbgnrk1X?=
 =?us-ascii?Q?dftrQKVXfLzL3uuJc+OqnYROEorMIPLpKqj+Sg9UAGeXio+diIY+trU64J2n?=
 =?us-ascii?Q?r6XdrZnhO1174xuRgetqnJaHolqcyY045Qnc+m3GNfuiGCB9uXtIVB7cSDYS?=
 =?us-ascii?Q?YAzpEy1PaIpbrpbFTovbYPirC/Hoj65K1S3ifT5fM24IaJKdbuEWHyaB23CL?=
 =?us-ascii?Q?Y3gV7d3bBPltjFZoJpNA34rCBCvJStNlDOlM6XHDYRZ7tPyFsvQVB4T0yXIy?=
 =?us-ascii?Q?Y6yMluv8976C4lybPIX5XZbVzEdK4Z4XbFB5+USAUD67xOXxas5/o+EIp9SK?=
 =?us-ascii?Q?tYQyMfmDido63dw2vPcBOH1RAF2LFsODGsyEXO+o4ENUcEVkhUKeXZR1Vh88?=
 =?us-ascii?Q?bU2dTjxJBN1VYgPro1zQNPwBImfR7XZyot6rwN+hb5NdADKwUQnlKrG2iZRB?=
 =?us-ascii?Q?wgggia9SMn1uvgSZORYO1Awt/2Fh1XGt0g2JtghbSI6FoIUOdYd02GGdc7mr?=
 =?us-ascii?Q?r8elMI3UA8Rpyuc0BgXO+K33D8gVHeo4S3sQKwAG5dnbmfPmPRMBOFZdqM0I?=
 =?us-ascii?Q?EWQkTvmkuZ/EYjka3smRQpmSxLfb/yu3GMbdvsFvV69XiTafIVJ8z5quUiNf?=
 =?us-ascii?Q?eHCJi03yVrQSftiBXjjZ+si1sjM5TIAxCaoe1kae35DuhxmhRQUZex6Gsk4o?=
 =?us-ascii?Q?yyDatZC8AYed8JKDHKrVn7/diT3zZTkWUxy4xBKyii3I2eFXV5gzNRhHNc8Q?=
 =?us-ascii?Q?2mygwC9geDYb12oopaTjjNdwww/Q70roK/42dH4+ZCU9dvQUivQSTCmH7NI8?=
 =?us-ascii?Q?ASkg9uUJWdpLqTUUy6sH1t0eWDXRIGVp+XdRr1v/rVnb9JYPwvXzKS5BRzcY?=
 =?us-ascii?Q?O8KEg6eTIxU1aUo/tXCOb/mZWmBTLDAN3vgMtMtc?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb723812-25ec-4da6-1386-08dc98d75696
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 07:36:21.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raYfs5oH4Rv8MkuSlOxzyy8kNhepE2/eBzv0LcBV33g4mDZbbgU2g0tYiSlyWvqL2jqnn4a4GVfWomE9skeGFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7234

It's the device id used by AP6275P which is the Wi-Fi module
used by Rockchip's RK3588 evaluation board and also used in
some other RK3588 boards.

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


