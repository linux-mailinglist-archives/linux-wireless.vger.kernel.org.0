Return-Path: <linux-wireless+bounces-11561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB98954FAE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865E91F22B59
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE501C0DF4;
	Fri, 16 Aug 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dQll53yD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0AF558A5;
	Fri, 16 Aug 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828345; cv=fail; b=cXmPuKR9bYnhVRvt+6D0UYdBnxITDDO2NP3pW3CpG98h9gZe3H9QjMRsKZT2if/eGyDtCuHOnHdC7o4DKuTBO6zsMkMqxPtnJdZthSfgpL5Lk1MKG+euMvrB5gNYr1keWPc46+g1aq+G1HJYiLMp3UXj4WOox+n0f4acSnyqygM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828345; c=relaxed/simple;
	bh=uhJYSLys4mR80kjZd0WY8J4jBOBfbIBbpvXfFyGUnhM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F+xpYwSTTBOmkxQY5cyDXM1btWfqrVeeFYNpMVGL5VkvuCCsVj+n8ml8B6Tns6awKSYSshZYC1JemRRRMADVupMUNV/7CQVN7+96/K+o0aZ/eUm9R8hXY4NDzr2q8X9/yPj2EMyLspMv9GaQAnUfzDC65V7vG6JFS9W6MtuwQ4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dQll53yD; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYdmr/Ya329UTSiqZRKmka9DNWJeP8HBBr4NcrqZR4yI/ydC3JohfUjFbiXLQHd5vZZiLe/1yweJBXPEgMt71tuQZOZgE/PMyUH9kRj+mPpRJUL9Kb0ag4s+u6Yn012j8hRGeja7OUVE6Wc9+5uGoVLwTgCcWw9rz5P6A8X/cdmKZC4+IuWYzcjGS/d0BVIovczDkCf6sa4RXV/2Ak6uM59dov72V+pavK++fdC+O+L4sf90xdWYbZkfTpcRItPDwoXmTNGbqdrS7ClDSiL+xcekWijMxwkLEpXcQDgJsbEgwGuTQwh1rjBElda3Nr+d94iamB+rd/StoM9Ky3ZQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxWESkxZHLgtZnpErSHmaCawdocuBYJPdYdbNS/6yDc=;
 b=PFZIz2N/cfcw/qqN5giLq3DRTn5rn6Cj0hCqVn6yncx3kGbiVZSkw4Vio9bX76HhwiqL1f27ZVH64ab1KZoNJF6QondDmRj2Oc0d2QqNZjoz3tRriEflfPEUlBET2W/8zMkZttZSmi8zJBRUNH3DoOQbo0vhTdEEunDqhwj4UZIgc8oGVXl0asy89MEUKjZXICaIVYFeFI/0EBXxVCDr66BtXIymTXWfqGYoiUeXifMYagxDufHnW1LnLmmx16mDkjCWppcOxD5kqFvZAuGCZsmHfYHVMMxgMgQMONxTHWtwGNJqMpG2mWn2qR0ogGKlwsfbE75NrYtZ+gYeLFUEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxWESkxZHLgtZnpErSHmaCawdocuBYJPdYdbNS/6yDc=;
 b=dQll53yDhGahBy768JbAOEP8y1s7zE8teJU7qa9pE+Fuie2I79fKFOEJYp+qwbcZOw/7fYi95cbdPpP9EFflMG6KjKAspfzb3tAVERyW0pY8NqpyG7Z4Oo/EqhitlR+ae63fiNwefGXo/hbRszOwvzJ/B5Q5KJkUGojoJRzvZ0s0Hzrr9fJvQbfNU4x0Egow6QRttBxpDILZ48XcmEO0YZQtgBvo5Rdj3kjMyEjQI8An4zyxyDvOe2aUgD4Z7676lZec2ngLPtksP4g+n56zwcuWjNhq8OkyrNYYD8QLuz1bo7drlRGTT2X3tiM0YJfwMdMN3PW0MtfRjxqJgufufg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8328.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 17:12:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 17:12:20 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: net: wireless: convert marvel-8xxx.txt to yaml format
Date: Fri, 16 Aug 2024 13:12:01 -0400
Message-Id: <20240816171203.143486-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: a088b53b-a0b9-4d77-3c0a-08dcbe169667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYKa92q/dZoJOY0G3gPcQDgOWt9GbCbRHoNsMk3O5IQ37wGfwQULE/KsPXXV?=
 =?us-ascii?Q?hCulJRayocFKethUghAIf+OuU+r9rTN9FdY4HS/c8C7RqQb/vdJONx+WpIjF?=
 =?us-ascii?Q?dGMJfOYgx7f0xf7CP5yT57QHlqD2jwLYiKW+IrrFNDrgi2ENMe/ygEyBdk57?=
 =?us-ascii?Q?v+aOljxIjD/nwjaUeIktBriPaVfCeMkbT6lh+gL4JjOTrH4ZZD10TNj6f154?=
 =?us-ascii?Q?qw/6vaSZCICEYJjCIRKX3oElkssTqAkCD8GWRoV+16xYxUswtRuJNA46egAa?=
 =?us-ascii?Q?Ve3S5KSY7j5Rp9O+U9Gyhg/MWh/oPZEVHoaLZidtmWJKop00MzKyIujlVZna?=
 =?us-ascii?Q?fdjjZPS8omOATYvYMqirGI7pR/yhYCtIuH2vDUwNdl8Qlxja55mLnxlvNy7S?=
 =?us-ascii?Q?npVD9DKbjniBGiOAbzFx0PJQyCT4ckg+HuYfy99mepxU3lX4PQHjXVHoxpxP?=
 =?us-ascii?Q?bhKU8u5ZnAXiZaNJOOVDt7plr8LzNrVMJ/cw8kdMuhAhQPRpKWAlmhdsKzNF?=
 =?us-ascii?Q?UNhPoDjs0d6zuoZ5HvZRgSDcCRc2JV6jJl7GnNnHZ5O0LKdH2KHF1U1hq0eg?=
 =?us-ascii?Q?91zmoJlJstc/P1ZE45ZdPuPdGwRMJY13OMMc7mHJ1OXNC27vKBjN4ELkcl+M?=
 =?us-ascii?Q?AqmXbS6KB3+f6v/YDe3vfhFfWLUMIQcTqkWky9ZF7qPKQwItiLhdlOXt68Y7?=
 =?us-ascii?Q?dw0V53OLj9C+wTzzsCOGwMVCGjxhlCNse3veWYAORg5/IKIGZtXhEHF2d/Qb?=
 =?us-ascii?Q?UZmHBJHgXE+/liMFITwXNFe4K+autzMNCpMv8frfdi7VsJwavUoZFfZJ6Ejj?=
 =?us-ascii?Q?mhdc5eVD42LaTUOmnkZg23oRcHuITxodkXGIUgZoXGyW3KqE655O3gsXQWrL?=
 =?us-ascii?Q?lf2E5efYAr3UBZ9O9bKDFCc3qUcSOt99IV8q/aFXbnrb8eO49ylZPubevfac?=
 =?us-ascii?Q?K2JIVqsKEOe0f5G3p/ezOy084FmUuA+X3q5MkrdoBG9tG+oVPRcD/Yh9BSMz?=
 =?us-ascii?Q?zQXA+j1hsLLKEmW9SMEe9JMEi9PDYqm5AOuOi4h0/dCyofFcv7zyI19yKW8k?=
 =?us-ascii?Q?DYJyO9HYuPrkc3vX6Tglwys+2rhsbnJUCUYBakr6PSymn4H97W5LWbieKn/l?=
 =?us-ascii?Q?P44hJC7AbQFPkZZBhpOPK4WYO49OGIJPaaNlU98DvQh4RKOsJ8DxSkCX+NXS?=
 =?us-ascii?Q?F/4AOtSGv2ZzDmNlSKiOJVD2+eNKKNS6iKn8zoBQrNSTWSFL06LQrU78kGtv?=
 =?us-ascii?Q?LSgSLWIM40CJD4/i2y2ij0EWqYT8RiYubv/VDq/YfVCSlYKmWOuqSSo++6d6?=
 =?us-ascii?Q?8+7BvYeDiQrCuinbwnVCK8bPjzzl83fiWEuFcLHB7qj60+GxSJ7gzNyPdTtY?=
 =?us-ascii?Q?Z7v4reE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?quvPAM+wJfME3LB3X+z4OuX07tT+xIdW70uALdecd/3RY+4PFZtkilmwDWk8?=
 =?us-ascii?Q?SGuLUwQpuNn63OmNSgv7E4bao1cYfrRfnvTE7bLsSAVqSf4/th9eQnN05MMP?=
 =?us-ascii?Q?DnTUuhEsKuibCuEwppWJyDS/395/4VMhTU4UHbwNS2A1lbsDWWFX5iU7a1VQ?=
 =?us-ascii?Q?BEO072pYockBoBhYEOe/ouasL7amc+aqrCecmspr3FeU+9RhrznicWjMqQA7?=
 =?us-ascii?Q?UbpkM7IM5KliVRGS+66CMlU1N6rTpGfg2hHZOx4VgjU6gZiGfWKZU8wKaF6A?=
 =?us-ascii?Q?O2zC4S2Lf4K7NA4HUSkUwh2jGi+yWmjfMhIzHUrmga4SMhCO9LKDQQwdxRlY?=
 =?us-ascii?Q?Cv6eG+5kurmBQyJY7lg7khVtmo3P6rD/Cw005Y41qwyYyZWMq1KcoPWw2N78?=
 =?us-ascii?Q?/1qNm5jD2XVg/tPC4FC5X1Fv8Z0cKPZpUvmnN9d45yskpjR0Y0/ePySAYlNX?=
 =?us-ascii?Q?j8sXuZs1l6ikySyiEXFpmGSK5cCTRHw+F5f7/0DGwDfa5vfa+0N53w07UCIv?=
 =?us-ascii?Q?ys5zUFYSA6Qmf+Ozytw4846bLZMFRJfB8E/sPNFfHPy2sa5ICEd+A+s/jbpa?=
 =?us-ascii?Q?zudE7RSJzywnfcinqYo7RApSZaziN8XVzIfcYTmDa9/I+XIAKmVnTu/Amwws?=
 =?us-ascii?Q?Rv0LfOsA7YU9RqvMJ4tzsc3Uxr6hZeB8AZyYRf4wW2YFKAdVzrqdpDW2Gyh8?=
 =?us-ascii?Q?vQryg/KIjxCEVvpZVmAuA9KJ2w4/puvUM6yC68KdiUuukPOiP/qp2TvxFz6k?=
 =?us-ascii?Q?tDQjMSkQ4bo+/TYGDLZyHkX6qAeWNmUklPXY3PNU2a9E7dunbpHlyIt98mTS?=
 =?us-ascii?Q?LnsbGAu+vmY20WWg5gn++ajsn7irtDbqqMoy85p1lRKaqNJuiTBcwejJaFGl?=
 =?us-ascii?Q?h/j+XV6moAdhW/HB/HbQIdy0ndEFfsJGfWk2KWrWC8Tm+JVKY0ondNVMjoID?=
 =?us-ascii?Q?2NariL1A4FURrjRta8ASpvNDdrzww4cpLOpXYXoOweLOqoOSDImj6hDbPTTC?=
 =?us-ascii?Q?e5fJ3X19BXbBGMpO+m9eOAhsnm4nmajorix0IEuzCbyh7UxWkTy6rl652DbM?=
 =?us-ascii?Q?dfDeFVKANgf8tA917cphEcCvO8yXuq3Su8+cDfWRgwAJ5OPcbSJGo2M5I9sY?=
 =?us-ascii?Q?UlF7bCeHgZqlaroBem0l/Ax+Jf0FFs+XKAdphnI7je5E224RfiyzCum8UbGV?=
 =?us-ascii?Q?gpJCydiqV612VgJzNQnrG9tHdNas8CoiIAgHX/wJxRFjwoQ6yLLgOxmk8HA0?=
 =?us-ascii?Q?fwx4SRAlQA7fUgu54gscsuATt+ExaGqrjfI+h18upF55/mMcL0HXvFmwLLB4?=
 =?us-ascii?Q?22Dzni4Z4PgEZD2olSNfkdN10SpKEFESRpm9X+n0CIINRRj3eYo/38OoULvQ?=
 =?us-ascii?Q?ED1beWCOTBRL/v063qlMULp8uBhpRpWQ+kZWVYaqgrtoRVLq2UKky7DheaS0?=
 =?us-ascii?Q?8/s46+LzI2EFTDupYVGxwbkWGeRvvc/6FN6cQuknGPWqclHYI5r3aj5jqHI7?=
 =?us-ascii?Q?zEfGyGNFrvSnJp5ialxFI4/mreuFCjakTrHYdmnOHsT8qXiO1mirOb2wtMI1?=
 =?us-ascii?Q?6X1oLq+ENk2dvXbhlnI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a088b53b-a0b9-4d77-3c0a-08dcbe169667
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:12:20.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldJfIY5nnZsF7JinkYiYA3dh6MA8EuFAtnncunlRtxzDQZnxrrUGySIJ8zQ0hxDXleASnFCkCz3aS3QdvxlFlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8328

Convert binding doc marvel-8xxx.txt to yaml format.
Additional change:
- Remove marvell,caldata_00_txpwrlimit_2g_cfg_set in example.
- Remove mmc related property in example.
- Add wakeup-source property.
- Remove vmmc-supply and mmc-pwrseq.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: /soc@0/bus@30800000/mmc@30b40000/wifi@1:
failed to match any schema with compatible: ['marvell,sd8997']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Add Brian Norris <briannorris@chromium.org as maintainer
- Remove vmmc-supply and mmc-pwrseq
- Add wakeup-source
- rename to marvell,sd8787.yaml by using one compatible string, suggestted
by conor dooley at other binding doc convert review
---
 .../bindings/net/wireless/marvell,sd8787.yaml | 93 +++++++++++++++++++
 .../bindings/net/wireless/marvell-8xxx.txt    | 70 --------------
 2 files changed, 93 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
new file mode 100644
index 0000000000000..c6647672b7b1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/marvell,sd8787.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
+
+maintainers:
+  - Brian Norris <briannorris@chromium.org>
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  This node provides properties for describing the Marvell SDIO/PCIE wireless device.
+  The node is expected to be specified as a child node to the SDIO/PCIE controller that
+  connects the device to the system.
+
+properties:
+  compatible:
+    enum:
+      - marvell,sd8787
+      - marvell,sd8897
+      - marvell,sd8978
+      - marvell,sd8997
+      - nxp,iw416
+      - pci11ab,2b42
+      - pci1b4b,2b42
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source: true
+
+  marvell,caldata-txpwrlimit-2g:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for the 2GHz band.
+    maxItems: 566
+
+  marvell,caldata-txpwrlimit-5g-sub0:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 0 in the 5GHz band..
+    maxItems: 502
+
+  marvell,caldata-txpwrlimit-5g-sub1:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 1 in the 5GHz band..
+    maxItems: 688
+
+  marvell,caldata-txpwrlimit-5g-sub2:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 2 in the 5GHz band..
+    maxItems: 750
+
+  marvell,caldata-txpwrlimit-5g-sub3:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Calibration data for sub-band 3 in the 5GHz band.
+    maxItems: 502
+
+  marvell,wakeup-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Provides the pin number for the wakeup pin from the device's point of
+      view. The wakeup pin is used for the device to wake the host system
+      from sleep. This property is only necessary if the wakeup pin is
+      wired in a non-standard way, such that the default pin assignments
+      are invalid.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc {
+         #address-cells = <1>;
+         #size-cells = <0>;
+
+         wifi@1 {
+             compatible = "marvell,sd8897";
+             reg = <1>;
+             interrupt-parent = <&pio>;
+             interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
+             marvell,wakeup-pin = <3>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
deleted file mode 100644
index cdc303caf5f45..0000000000000
--- a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Marvell 8787/8897/8978/8997 (sd8787/sd8897/sd8978/sd8997/pcie8997) SDIO/PCIE devices
-------
-
-This node provides properties for controlling the Marvell SDIO/PCIE wireless device.
-The node is expected to be specified as a child node to the SDIO/PCIE controller that
-connects the device to the system.
-
-Required properties:
-
-  - compatible : should be one of the following:
-	* "marvell,sd8787"
-	* "marvell,sd8897"
-	* "marvell,sd8978"
-	* "marvell,sd8997"
-	* "nxp,iw416"
-	* "pci11ab,2b42"
-	* "pci1b4b,2b42"
-
-Optional properties:
-
-  - marvell,caldata* : A series of properties with marvell,caldata prefix,
-		      represent calibration data downloaded to the device during
-		      initialization. This is an array of unsigned 8-bit values.
-		      the properties should follow below property name and
-		      corresponding array length:
-	"marvell,caldata-txpwrlimit-2g" (length = 566).
-	"marvell,caldata-txpwrlimit-5g-sub0" (length = 502).
-	"marvell,caldata-txpwrlimit-5g-sub1" (length = 688).
-	"marvell,caldata-txpwrlimit-5g-sub2" (length = 750).
-	"marvell,caldata-txpwrlimit-5g-sub3" (length = 502).
-  - marvell,wakeup-pin : a wakeup pin number of wifi chip which will be configured
-		      to firmware. Firmware will wakeup the host using this pin
-		      during suspend/resume.
-  - interrupts : interrupt pin number to the cpu. driver will request an irq based on
-		 this interrupt number. during system suspend, the irq will be enabled
-		 so that the wifi chip can wakeup host platform under certain condition.
-		 during system resume, the irq will be disabled to make sure
-		 unnecessary interrupt is not received.
-  - vmmc-supply: a phandle of a regulator, supplying VCC to the card
-  - mmc-pwrseq:  phandle to the MMC power sequence node. See "mmc-pwrseq-*"
-		 for documentation of MMC power sequence bindings.
-
-Example:
-
-Tx power limit calibration data is configured in below example.
-The calibration data is an array of unsigned values, the length
-can vary between hw versions.
-IRQ pin 38 is used as system wakeup source interrupt. wakeup pin 3 is configured
-so that firmware can wakeup host using this device side pin.
-
-&mmc3 {
-	vmmc-supply = <&wlan_en_reg>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	bus-width = <4>;
-	cap-power-off-card;
-	keep-power-in-suspend;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	mwifiex: wifi@1 {
-		compatible = "marvell,sd8897";
-		reg = <1>;
-		interrupt-parent = <&pio>;
-		interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
-
-		marvell,caldata_00_txpwrlimit_2g_cfg_set = /bits/ 8 <
-	0x01 0x00 0x06 0x00 0x08 0x02 0x89 0x01>;
-		marvell,wakeup-pin = <3>;
-	};
-};
-- 
2.34.1


