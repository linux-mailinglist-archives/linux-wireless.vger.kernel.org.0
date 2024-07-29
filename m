Return-Path: <linux-wireless+bounces-10594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938693EDC5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86E91F21DFB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A899F74058;
	Mon, 29 Jul 2024 07:01:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2102.outbound.protection.outlook.com [40.107.117.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EA6A8DB;
	Mon, 29 Jul 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236496; cv=fail; b=AWx+oSECdQQdB21WD5dsIyoBi02XXolets7LMoW0c84sZt23x+FkCfIJx5II22NG9cng3LbJ513fLopVaGL8clBMdelHGynCx6NX7+FHCMhZWSgJt9l720cXczP0esC3jqD0/f1EJ/nDXf1Tb3dU6HQJ06/vLZEaZE8/59W+0b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236496; c=relaxed/simple;
	bh=kBtf5PILxtZkvUthxvMX0F27b1O4QzNR/E8t0XQ3ywU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q/POWkDhcQ2fEmbdJgXBVtEtsltwwoWIdW3V6X0Kl7aQGOby62EtF8WAxRB21D2nD4+39xMlvdpL1d3JZQKnCqijXvXJlptEhxhUuf+gGCuWTozT3RQw/j76antY6njb+r1AywHBRE39qVYqzt/dRqCHI5xPvFwraxIjV9oCC2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udj7Jbo5qRdi4EmgeW/8qemG0DB/NtxInNf3uqRT/PrT/Py+iw0UWU7LAjnRYIYDH7e7rwXgUpzPDT6s6Oq3T8y96GqAVJio7AE954qMqgWvocul0xmVHNL3PdnnBc3fH6yj1GlMpNZOyDgnw99Uw+47rRD9oy8atrEqU5NEXsANyfK/IlxnauNuJi/zfXq9pCW/Pf3Zv1YobgHlgjWato8/B8ZuLZLP8ihAaIuyZ30sahDSuQd62zbJQCmKG83Q2cCfiep9n01xzTpjEortmJMnP0bhSGVivLvzpaQEwkrSvwyuKggJoaZEe1w+cRYbb0+4jCZbxmvryvfvGiOC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5joZeAkWIRQ34gsuTda02RA7b0+WpONtmE7vZr9/GDI=;
 b=CW6GteTZ8lTu3Cs9wpDmKLwynG/tBVyKLV7mqZI43eEMoq9y0Ibhd8swG0EcU81/wXbqUwhHgcNKRJg1HSx92WGez+YRo6FQ8kQD7hI0QaXAnIJtgT1m+EhxR/qIPdl9IdTsrDXJZi1xMaFV387rm/pQXLabf/0vt556bSp5pPCH4imBRqmPKBAohy8NEtfpgm0s1FzWs4Uz9YnlH6naThPTbvcrAWR2/nt/M7HlqVXkaO9v/o7iQlK1MWOfxsEB4km7Ml0IoXYgjCaKguNE2wYcjpsaccsXlI9qZ+n0QqE3sEKHZFEYKU6gUNIRwRPuMQZkvcVK6Ing2GeoJ/6eyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB7870.apcprd03.prod.outlook.com (2603:1096:820:fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 07:01:29 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 07:01:29 +0000
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
Subject: [PATCH v4 0/5] Add AP6275P wireless support
Date: Mon, 29 Jul 2024 15:00:57 +0800
Message-Id: <20240729070102.3770318-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: a9c86fb1-3cb6-49da-925a-08dcaf9c4537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IWXhb6rccKRr1rIiu3R0EA96hsvaOa12rABF0XwzOaW5R4dM+aq9aY90WkmD?=
 =?us-ascii?Q?Y5wXe+DG/K8UEedp5ePeazKmuOkZGLqe31Ldek6CPadSyu8wjSvKCcCay79Z?=
 =?us-ascii?Q?KDz5oOW+4dm/pmE+1vasU4X2YbRMv+5bK6i6wzSWcZSNsgM/azVX9MmNGAMe?=
 =?us-ascii?Q?nao0hl8q8DAEFxiVb6pMgSQYU59akX6wIPXkMOK8VqZVzThGEj3KjkrIZKDr?=
 =?us-ascii?Q?HxZnTBQtI3ytE6N86fBknCJmssMHC9zK1AkmZ1KbEBJUfDZQngYTkgCwb4vd?=
 =?us-ascii?Q?w8gGWn/mNyOrCOX7gz315BegUTX1ScwWiIfPzRmqErJnFMPp+d4dIh4FNlL9?=
 =?us-ascii?Q?M2OdnOOIUkgzkAdU/pqlYUYrUBiIctE2/4EfiVvSGv+Wc7bbqgNUjziJBU4H?=
 =?us-ascii?Q?DHbAfWCtA+BH5cWuCNZ0bWT5hqj/vjoavtbXcFLnh4JoSpmTIR212u8ETf0g?=
 =?us-ascii?Q?2mJZtlkgb07t+PWQRafgl+WBFSW0jN0YYp+LlFNXuBXgJmV+tHLE0obODlZO?=
 =?us-ascii?Q?+uDwH4LYSqO6GURgSmyunu4Nfi1G1jB8uVUdUnXDzByqeXCxeomQzIMDPIJM?=
 =?us-ascii?Q?a4I4OMxUPRr0a7N4FH6MMnoZ+5yVsEKwM/OVidwTXyMgU2k0IOQsBsxLU1DQ?=
 =?us-ascii?Q?mK/AUcvsePFf2Y9xPcJuKKY7dTzaPlNQteYpowLC3HekFXWsFmuSegCv2xkT?=
 =?us-ascii?Q?ZoQxtnwQz5329Q68FdpFKgA1+rzzzqWtSrkqJ9FQt9txVlFQ6+47ciHBqZiE?=
 =?us-ascii?Q?N64KZb+awPUdMumPO51cqm0AQ9cTulnBJeoqYFchp4lE2+dDXsKaxHjgkoSG?=
 =?us-ascii?Q?t9RSFWoUzCjdkGcWRInaQgT7b95tDrpmPCzDViU1LL9cYpthanmAvZT3dox4?=
 =?us-ascii?Q?Bqg0FCp7TJiCGYFbxUt2SRNLRRuEqASQy5o0NBViG3c1lDAFlrvaHuehMfNZ?=
 =?us-ascii?Q?Ow8tKFH+ma5Mihbe91yY9k7+2o0f1TYQUR/P182A90PvSHAH7ZtZmf+6iNFm?=
 =?us-ascii?Q?I8PEio2vAs0JSzTnGDD6ZJr0Wh/vwY4hx7P55rbHlVslcAey0v8rBmndq7C0?=
 =?us-ascii?Q?VtAjpaTzVSb8ADptbf2vF9jAYCinQh82fpHRHaqkx0VBs5GTVmIl02fEYhiO?=
 =?us-ascii?Q?cY6GE85IQvBCoMESdO3bbwUYCRTKiGMaRfwmVP0NxftEwDIH+Wx2/0/D5euK?=
 =?us-ascii?Q?SwTD4Ypp33k6p04cqYexP410dwNOQ7o+w98GAFT9qGP+so6Sjus4AiwGh73j?=
 =?us-ascii?Q?tUPbP1MRAwu0RpuUK1+8WxYdI2Kmp2WlXccbOw+rvMakMKXWGHx0g2qYGZxF?=
 =?us-ascii?Q?gJZShIIYUxYkClmw6feKU6xBlvqS/WN3ogphG0lpQeZLMnQcxUV9wBmwZ46l?=
 =?us-ascii?Q?wo1gPLY143F/zbjcktHNAv26QjZo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXlqTnkIgeAXZipSoqFG/RV7gtxU4tFzJwUkeKv9esWJ/rq7aovwUSlqwm/q?=
 =?us-ascii?Q?eoJva6ZGpWJzEqpsWHOPhfEEzefAcz0ZANX5ErbDBbNHwxCpNCX8PB3bOJtZ?=
 =?us-ascii?Q?37EaZotTh7qZDZcB0eIv27nr3tY8WZK0FanTKTYXE5bpQqLhE50Ms8eLwBsI?=
 =?us-ascii?Q?ociwQSRok6MK9uh98Svzl8OPFskhL/qNOAcpZI40p3pVj135EXtepeLuwVQ4?=
 =?us-ascii?Q?9WJz2Juo1TqlVEt8YAfG9KCA0ABlCjNrLelyo6Evh41aSJ0itXmTYX3FDUcw?=
 =?us-ascii?Q?wLlxTRbJR/f4rIM3J5gVvKrWfwn9oa8PFaseTPuHi1zZYaXqB8YiMvh0lcFX?=
 =?us-ascii?Q?LlsOyi6BpfmaLVGof7u9DDGhPycwnU2A+hEABa6NZ1Slwm67TYO4SjhSUAe0?=
 =?us-ascii?Q?pfB9woKHSW8GBLOk6VBUzCzdJpZzs00K7guDqOH+1FPjhCbCkRnRE9vHJhYB?=
 =?us-ascii?Q?KSUOUXBgYKnxECCWmxGpHgfEM0OhlcqBh8xb2QFRS/WLX9DCXtMrMFjqjcZv?=
 =?us-ascii?Q?pUfsFtb/APo6NV3l0uWiLkKEtM74gr2qGS6D8fGoN9kIWo8L2HTLbwqyTZzh?=
 =?us-ascii?Q?QZMFrDt2HJUr+j3MHTTa3BlzzapK0iPZTU+M0rSz41AyBWV/zYiNzh4K8PZ6?=
 =?us-ascii?Q?I6RjZ+8JyEwAcrWb8OkvuouknL723L5XfvxapU+NepU44uGWzsSuh48T0nKt?=
 =?us-ascii?Q?vKh4/KF2sYMsrakt8AYAOgqpgNDcV1SoM5fXg/wCoSztRQy5X08Sod7CtJBa?=
 =?us-ascii?Q?Ac7ZRRrFeMvLuvSzM2beWwwYfObGuLN2EsyduADiQpru29v3Y+0sRfDqkQRB?=
 =?us-ascii?Q?5yADU6qQ+3+n8bkdDscrBNQK0fMCw10vxUWC2ENXoNgCqH02tKKNX/KPdEPW?=
 =?us-ascii?Q?HyElhd8iLH5hRu0a6Hw/0rwPCLgwT2l7wpFZa9laWXaHs5iEa5dbB4zkPgam?=
 =?us-ascii?Q?4+TTJqyCVO5QVyamq5lFJtS9KwrvIJ3lSFA4e9r2a3tlTSp7YPB6U2Kqwl/K?=
 =?us-ascii?Q?fusLt6ys4jFuf+4+z4P+SuTSqPaVsW6pv3m4M3foKY//EqFQLdZaCeIKTWPt?=
 =?us-ascii?Q?4FgRSEVKVpVUx1vRi6ONO15kdumuJFRv6f3u2Dr9m53QjOCmr0payGdmGJan?=
 =?us-ascii?Q?aL6DEEej2TCaXajZJFm5YGQpgmP7hpXlgPkvero3PwL38FFoYzb8yXAHCxJx?=
 =?us-ascii?Q?tUTFhTAo2TMATXV7eCpCeh16YNObDuW78+jG9pWXHQgQCSN7FPidUrRNshgU?=
 =?us-ascii?Q?sMxfQSL0XBpndhc8OmaV9xekKPbnPdCCMagZoTuvzAuFqF9Z8T56qwIN/JX/?=
 =?us-ascii?Q?zRm9sHV1Vh0URvoYv8CaaH8IFoiCfjCdPD9syrahBuwHFcS3ytuSqdlnsSWR?=
 =?us-ascii?Q?bHfqEI6BlQYpLIXTpvSinBdVOxeZ4VE+J8MmadJ4ojc02iJcGicwZf9Jssfu?=
 =?us-ascii?Q?7ey25panqfOZ2qipoHXrExD52IyybLJm/ZU2lqWxc5EsAePWABzkRoKaRPqt?=
 =?us-ascii?Q?IaDvZkWMgcSeGz/8j/n6oIon4B4htQo6aFzXLj9YqOlShHeP3WYmMqvAwGhd?=
 =?us-ascii?Q?rQNbXhotXSJlC/p5Lr9NCbEHetVmieWLXt0kACKJ?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c86fb1-3cb6-49da-925a-08dcaf9c4537
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:01:29.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4B3e4eJGD21aKH2pXm8MPujw6YahgOlXVxV5epA2hvwftzfhmdRuACQMwYCPXaxdl3LXP6w1btPaZwVtffLWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7870

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

Changes in v4:
 - Change clock description in dt-bindings
 - Move enable clk from pcie.c to of.c
 - Add compatible for wifi node in DTS
 - Add random seed flag for firmware download

 - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/

Changes in v3:
 - Dropped redundant parts in dt-bindings.
 - Change driver patch title prefix as 'wifi: brcmfmac:'.
 - Change DTS Wi-Fi node clock-name as 'lpo'.
 
 - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/

Changes in v2:
 - Add SoB tags for original developer.
 - Add dt-bindings for pci14e4,449d and clocks.
 - Replace dev_info to brcmf_dbg in pcie.c

 - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/

Jacobe Zang (5):
  dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
  dt-bindings: net: wireless: brcm4329-fmac: add clock description for
    AP6275P Wi-Fi device
  arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
  wifi: brcmfmac: Add optional lpo clock enable support
  wifi: brcmfmac: add flag for random seed during firmware download

 .../net/wireless/brcm,bcm4329-fmac.yaml       |  9 ++++
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 16 ++++++
 .../wireless/broadcom/brcm80211/brcmfmac/of.c |  9 ++++
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 52 ++++++++++++++++---
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 5 files changed, 80 insertions(+), 8 deletions(-)

-- 
2.34.1


