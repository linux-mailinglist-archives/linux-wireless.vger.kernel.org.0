Return-Path: <linux-wireless+bounces-10595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563D93EDCB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6967B20D62
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 07:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3D61272A7;
	Mon, 29 Jul 2024 07:01:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2102.outbound.protection.outlook.com [40.107.117.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619382D7F;
	Mon, 29 Jul 2024 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236498; cv=fail; b=j1j1m4ootK2aHcinBhXYv2bh4jON1YoMtJqwzwh54y54NquthGiAa8zGp+giuoAHwrdbOxQ30hUDwGz0A4GY2BiZwYZdoh+bwChg3GuStT78usrtoeU18P8YsZUu0qSvYgnMk2YS6W5sE5lh5H7sYOVqyekbyHXmfC4UU0EbSa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236498; c=relaxed/simple;
	bh=ktRJBsGGjJAW7tpIhCoDO5wtOo/XHcwQyHY92weMLU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MN5j+ayb97kh7sula6OBAIdk9sP8D/MZQgOE64PREyWrJ/Zh5ogCKX+cbirR3z0whCF7/OnOG50CufdPES+hAR1+FEL9Gh+zvH54CwYR3OLu1XSaidrLOKfeQMvN4iS9QMN4hy7L5G/a/hqJgS4lty+ziwj/eEAciXaZd+8/3Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIN4PoDnYQtooRqRm22M+8GZWJ0zHc6iCeHkTJLtTNa7tb1glzVOt6eH+VOp9DiV7eSug8F5BO8RWeBXlt3pAaIxGHkJvOWvkHv5f9hyOlb30EoyokRi4cM1xBdCcpVgovg2Fz0vwM1783i/ptHjo/jrgcnWgFfz+te4UqlSB/Ld0k/tQArTuM4xJMansN2ppwgltJcTxZlpyR9Ojq4t0G2aOCzD6Mhf0nIYeXmzq22cMGoFdAaAL7w46KoNG2UDE/vSrIopeUQaoUI7ErLq0IJFuZi3XWu+6teuG62F/31K43Y6zCCkUfCpJQukLgqfdLR70FWP9oUtqPQOah9yiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6zTTdkpi6ahsF6jVbVHnvRxzFTyyYnmY/2NIU7IZ6g=;
 b=eso/DCVnr6tPmHH1wIg340cNKz6clG8IK7ob43pgVnvFeaJiibzApv3J4VacEJwR7FQMeAHeDtUqAUeRrDE0RMJ9eK1UK7CnGaWZtLeZ7ek9W1duYhIIpbIHOuyhW6HTmfmXy4qRZECHDOPb2KD6QeNjEb+d3h1fqrS9ETsFEXQX8QPKjrbfdCWQCBpQjmI51hqquw//jPq7JFNt35IWqJbXbWOw3uB7ZDRb9Mu1Jd+qGQoIXM7Ez7ct8qo2AuXRe1Gg8xkinSONfhPuxPaRvPoGr5fFLGyThey+Nzq9E3A8wuEJFXBluY1HhwGVnV060ltDW4EwILLtB2OROzK9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7870.apcprd03.prod.outlook.com (2603:1096:820:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 07:01:32 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 07:01:32 +0000
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
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v4 1/5] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
Date: Mon, 29 Jul 2024 15:00:58 +0800
Message-Id: <20240729070102.3770318-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729070102.3770318-1-jacobe.zang@wesion.com>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::18) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f789baf-efe1-4f53-2a22-08dcaf9c470b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5BVk1Vs/AQOEFuAChOgDIlNnULo5dZWoyW4AuAog4PBPHldgtbnv1M/Z5stV?=
 =?us-ascii?Q?umTpu967L6umcotKoj/epdgYaOzRue0mrDEgt4q4ZkrY66bCSbkG0yDIDT/K?=
 =?us-ascii?Q?kgRSZZxm03eOtQcj8Lkk5Nwl03Z6Y6zjxxA7v/kTZmtWAT7Ts757l+4g+gA5?=
 =?us-ascii?Q?mhV/ft5olxN1Iy1TCVDkVB8cshNPlQzlDZzhmb8MFNnzKpZCCKy5xikjZuDt?=
 =?us-ascii?Q?rbzvoOaYPGSL6zlMgb3lOSmG0zQm+TElZz7IsUUSx/HqYpTI2Nrx2FLcEQ6Q?=
 =?us-ascii?Q?8W1Qz1icCNCsalTurhoryr3eFHgCmu+k5B8uABk2dqOdgNZcsRoKizWPc/t5?=
 =?us-ascii?Q?FFwpK3gQMpyc1wBIH/2xXtQUzP7arV/2vfjCnG1LZNHKz+EK55Ab/FSeEgxc?=
 =?us-ascii?Q?7FaONoV/Ff8L8wX/ReTdwQuW4IHjXTkgT+DdSCHCRlwmFY2lhYJcjebMmWNj?=
 =?us-ascii?Q?quBs2xTiJmhcowjsEvHfSetvRGOKta8juZO+inc4OeHfQD4T+g5+xMNFFREZ?=
 =?us-ascii?Q?p2rPP16Fs9VbWLWJfeQ8BrYe/iHmTgCN/1lDUNHI5bGhXdq0jPjM8gw+g2nq?=
 =?us-ascii?Q?4zf5aOUplTopaBqnTBoFpKHxiwFNFes8S4jz0nZrsEpznZvI4Qb+joOcFbrd?=
 =?us-ascii?Q?ubt3T9LAaDMW0CsBpVSST4yvt8qSrsiLYm2/eS5Lpm3cq6B9oEry6KEo1L/K?=
 =?us-ascii?Q?wSQfrX6MImhcfBQwsDrKAGAYRvcXOk7mjQlGclKWa755G0v0+DeBYpCYIK1r?=
 =?us-ascii?Q?SEo8kyNmnOiA56iYQz4HMojin0+4soikjO+7kZwaBy5khcvtVvaTZiMnDu0t?=
 =?us-ascii?Q?phjMjW0/zP4uwFPRJOXK17+OfwUPX/OzU9K4XQGADJBpK0zkNSG5AilYAgpJ?=
 =?us-ascii?Q?mD6DypZ77cC8PHpT7Ma81+ybAxXBByb9x8OqY1+WFBJPlnAsizAN+rb5f8q7?=
 =?us-ascii?Q?81KHZ+3XMh69NYo6ggRj0B858BSeIo74o1kMLUFQQfLAxXG7Fd4sFvpF9hP2?=
 =?us-ascii?Q?EH+IYubdqgRDew+sqZ0ggx4NisfWF4S2wQcfNLJxhRSizCneDp05JOehCpMx?=
 =?us-ascii?Q?3V4xPtmEgldZ7crYqbmvpmKiKiFyjV+trYpyMFvNdFHpbRYOFZ/DGfiijJYK?=
 =?us-ascii?Q?W2ojMOSUzl9BuMMQkCdpNNuAICsYoJ3y5m8OgoI6G7bDBnSPmK4dWurdz0wW?=
 =?us-ascii?Q?GFsbl9PDBtVr2wCqoHjQIdaK3bLHx8Jh11SMxQltfy/X2umqMOdH1zSazQjW?=
 =?us-ascii?Q?IQcIQbb7zYwV8NSamCaGvuSnWDBq/GiM6CRKzYYAxkjzT9DDOmFictrTzE+X?=
 =?us-ascii?Q?jhE64c6uf4aDokj1Kc6cGVzT8bSmTt61VDtmJgO9ZwCPDGs0xL68BLhAV2Lu?=
 =?us-ascii?Q?Gj+kXjPtGS1VChNJ4pP9WLDGO33XsedJ/9hOBPPb7QVxPdePS0/RyLCDUUma?=
 =?us-ascii?Q?I4AtQhg55f4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9MpQyz3HPSJ0SkWfytxKZiQVPVtgG+oJN2pm9rt0ukRZ40tn3260izNW4Hww?=
 =?us-ascii?Q?mmwQ4ovnBNOEB3I4moyI1X3fh8+T/lRiyqp422zKxP21qpE1frYWGSWTEjSu?=
 =?us-ascii?Q?YN7N6/nXq9RsmUlY1/PggyTiclUK2ZYGhtJWAtYB9DvgEHDhX12zaeOM5Ipg?=
 =?us-ascii?Q?5aONvUaEZ/drkn9wh+6z/h7U7q5kklyYWjKIHkaCx2ZMCQkuEQr4P0JbTq7b?=
 =?us-ascii?Q?gCQJFpfE/RXgfGaWaQdhBOUxADMl2Ifz/hXkS5C7BCHepcDHrkaX0D2o79D/?=
 =?us-ascii?Q?bXR4zI7XSjCE0aoSChU/ninBFKHUIAw8SvryiWA1mIiiyUDpBCRIkF0UfRIh?=
 =?us-ascii?Q?vRXh1SFKqWZmzX3Zjq+ZnoKkjXG0HAVG0Ju3TRutfgSPtzEp2fMCKhcuCl3q?=
 =?us-ascii?Q?vpNDYB/JYJel/wT3uN10KOUoWe+CkLsgKCuvSg/p82QVIG9PoHk5/1ZHZp45?=
 =?us-ascii?Q?+cRCgLT0CLXXnJGWfB5d1X/BDiyND9TOsvvDa4cIVze17xB6GcQauGVcedCo?=
 =?us-ascii?Q?TmPSGvSFGYzLla6ktqySdPkzsuDE7J+PUZXoJGWEpucmCUfgL3GNoElVsGTs?=
 =?us-ascii?Q?VWmem4xl7ev873e3Un7DirR9mZaZsleZAA8ITVnDkswCBm0KOn+6D2PVThyr?=
 =?us-ascii?Q?rKz8lROKsvJHIkG7jedW0qBlq+lSY2yKhVC7dmG/646Gp5rvULHulLJg2LHu?=
 =?us-ascii?Q?OlGOi4uvOtbo9v9HDLsBF+Q/MW9freGefVIPHdh5S6RcnkfslwPwqhaPmDZ7?=
 =?us-ascii?Q?vqgxoYlBuKzMso8gRPp+X+ltuAWAi+TyrCAA86dmSE/1+G347fzdYRbqZQv3?=
 =?us-ascii?Q?jcJ4TOo9QjBuYJEno9DL9Kzfei7AV9FHD+YpWVMS38tQuMjl2qtfA9XjnqBE?=
 =?us-ascii?Q?TE8lwYUP3zTmTmDj365p/sRdY3Q3qbzdvQIw7qRmuPMRv5wMu//oTFuethZb?=
 =?us-ascii?Q?Z1eWCWbVakH+51saVLbTekfMyYNfu3+krJSOKXa1VdEhFJPVCbee/8vnhaKZ?=
 =?us-ascii?Q?+EOKkr4tFwuUMcvie0gesuwIAX/DKxpn30ZpoDPYqhVfwyTtTo+Do4RaPOer?=
 =?us-ascii?Q?f3V1vDDDXqxr5r4MhFoYvw+9KebSrtDgeR9PTmsakxF8ATq0jUa/q0hrvDyj?=
 =?us-ascii?Q?r4z3/QpxXqH8QFx8UogxBzPudalJURni9eE+RAf0BCR1dyKP0ZEWQA41nUin?=
 =?us-ascii?Q?2DKzdjVj5MPVNbZseePbNcTUXDb++hpmNHj04REDK7WIT9zL4zNIvSqg2u24?=
 =?us-ascii?Q?6rd8hT0hdS+dGjGorOIc4wn9L1MuepL7BArLpb1jKNCJRXFHLBNZ1JFfBZI4?=
 =?us-ascii?Q?ZhVP24kDs+Le3+a0EajBRKmgpsnmt+ZAOrDf+rmXjvqrpbG29WRY0eVSKuYj?=
 =?us-ascii?Q?uaSC0f0bWMDdAJr62SrahohNArUwRxHMeUMKdABQHpWm/d8ImNUhRcnDvb/n?=
 =?us-ascii?Q?m2AAS+/9avMGgFnaGyi39ZbEY87czS/n/tvYIm7vCY94fs+BDUiCg7lISkAN?=
 =?us-ascii?Q?k5NXzrGUaagV8RxnRwdfzb/FSvLlh/dATuQav9ZUd7psQhPKcL+38xIhTqcg?=
 =?us-ascii?Q?YIvQ4hY7bs7b3lOKakHjhsdS5yhEX9rTzqhuDx6V?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f789baf-efe1-4f53-2a22-08dcaf9c470b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:01:32.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DVP4Hqsv2Ou63dcs4NkowWUrzWbjS9fkM/nEHz37Bwjs28TAXqbLf1dHhGM5fWaS63EWQnuXqt771Pb9isk9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7870

It's the device id used by AP6275P which is the Wi-Fi module
used by Rockchip's RK3588 evaluation board and also used in
some other RK3588 boards.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
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


