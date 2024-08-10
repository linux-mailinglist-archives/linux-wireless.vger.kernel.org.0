Return-Path: <linux-wireless+bounces-11236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E4494DA64
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 05:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B371F22483
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 03:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026C013958F;
	Sat, 10 Aug 2024 03:52:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDA1799F;
	Sat, 10 Aug 2024 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261922; cv=fail; b=CWRbCBeOzmZfRlbmqkhR8gueXqImU0tj5kfx1cu+2usMnzoHnTgeTQNEm4ENH6hWXL5BKN2L4HooscONdcMBMK0JXEOpJACxV3H5elqt19xk5LhUyWsqb0b9Nl9PVI8R/do6pXJkcyqcj02se+3y7j9Byw3iPpbBZgVCP+vrkPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261922; c=relaxed/simple;
	bh=Z5qPXEEUkX8AN1DqhXokMw4fnKn3XIuwYTBU1dtBvB0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bB2O9X280u6izM6V5kcQtrwLr8kd0Qmqi1lYJYyxMM6gco6lH/2ckzWS40NzMNzrbVDUnB2y+nwTdguv1sRvJlaThdisCYwGpCrruMq5GMUcreBoTeOkz3bQNC6i3A9Oigt69ejIj36tc2Aie5Cj9O3fqdV+z6detAjPKwZvSzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dv5Wg3TV90FEU9u/+VnM3GGtTXAVSv9TdOwDwNTdR2aNZ5DABgYJRBgARXuiARPUAzYLsaE6pg6X0IhWJehwJpdn364jzAGU0Q2y110YGOc5xMdzCZ/D7R9ivxYeTF/MyXqsk9pQARYD6ZF/o8+rxpB4L5hucmeYyCKZqr/Z9LOkuJDEIpAWcwfLiI6Rbc/LRsjmHqETMbABLyWruORI7UnnujuP9kAMTmQImNIhqndH4qS0k0sYpick15hMfMPUsGwg+2smTx9ibvSVGJ4RbfjLOUrRZhudy9ZqwqmWPMjSEwvDQ0Xd3v2aDqk80Jkg0P8R9sYCsYbjMcumyylLUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWxvyZebHcn5nlT/XWQT3uL3yRarW/BmR9Lh58Ys/cE=;
 b=BDcpioPZ/LtvwA8JEosJh46AhSp+2tpY6fldTZecEEvnhaAVPxJ9pX24ihP5UvMdQ9nDOYOsf+vTpRZNovVhgtPd1yi652jdS7Onl6uXn8CeIS3xC+n+2zBBpak2dW2BqF/sJ+6NIN+jjZ+ihkPUm+D4akvmZjc1kqsrLEy5rDb396XCwkyKpX6g8b11LypC0Tk4Gcr1KUmUj9havqFe+RF+i62pDh6TLOPu4+zHovZ5WgUg1AqqKHu7tV0cXHUhU5bppchFRdPmSvZDo2BKO7gbAyt/8xglKLEl+v1yq0D+WBN7zLcwHZIyvLxa0yu1RpAAQIQtpLR1Y2QKZt8xNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB8564.apcprd03.prod.outlook.com (2603:1096:405:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Sat, 10 Aug
 2024 03:51:56 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 03:51:56 +0000
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
Subject: [PATCH v9 0/5] Add AP6275P wireless support
Date: Sat, 10 Aug 2024 11:51:36 +0800
Message-Id: <20240810035141.439024-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 9881e7b0-87ec-42af-64dc-08dcb8efc73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6l67MsjeBj5NnZm22cGom4kJEwnbc65erypE75jX7hBh7doYZK0KIZf4Fx3L?=
 =?us-ascii?Q?iKJ4K77EtYFJOL7qRyFxujiIvCHVxK9yaTDfOn5zdJUXYK4Xv5h68a/c3DQM?=
 =?us-ascii?Q?Cxm7oPpAhsqK0+8BN5ChY/q+Bo9OuRii4t9IHV66d5yd5Tb8TbJQAOwnPpxS?=
 =?us-ascii?Q?G1+KZSBxeL3p4smInjDqv1CFqK1fKagiGC4qEHwj7XaKHkG5LoBP2okcjpcD?=
 =?us-ascii?Q?2DcjCsF65f2HVF4nZ9hOnoyOCIcJuMP61faCl+JyAxQcAR7DQhZNU3fYPIHt?=
 =?us-ascii?Q?y+aFjyE0k89YHweLCeWXlpJyPrRBzjoOVczdTZgoT9PZxKrxHIlgWYBfeEVQ?=
 =?us-ascii?Q?fU7Vc0gKwywlca+8iWzwRX9Ep1QvbAoPIB5hNoaOwZ7ekaywIoR0NZMJOsvq?=
 =?us-ascii?Q?YYTORFzUMeJYgTYr2BMNONdrj2hOUvdZFhBp8ceVyhK9EHjVa0ipBnnyQ+f6?=
 =?us-ascii?Q?fIrqyCCIOFdmbH3N2IudNzM600wXEpqr7iHzw1C3Z5QJE2BOOZPF7LZyE2Tz?=
 =?us-ascii?Q?f7aXl9H9ipyRWsuVeKq4RWUsT2dRd8R63LgKRoHp9Y5IVEWqbqIj9+tpgIac?=
 =?us-ascii?Q?QAf4DoQwTS6O0XHlm/CBkK52YxFXvtrnwFgUR5wKcs2CTmpLOADFUV65lC2o?=
 =?us-ascii?Q?vPPFtFG49uO9H0YIxLkgnXDQDvcnQDhO8rcQgteiRqmxbOy74/nb4Hd8ayIr?=
 =?us-ascii?Q?E+mfBNYZB+4+UDELwe1IW0U0bla5sBM8qprqYZSkjw7e8XLJZD+8vjlyILVQ?=
 =?us-ascii?Q?63PnLxMtZZQPc2iqpHF/pc7syXz1jexTRysuHCFeoYsgzW1NfSQv2zmFTViK?=
 =?us-ascii?Q?EtAhD8I5o1bsDD7zuGtkF+jL1xfNMrtRXyLck7I8jb+FlXy8aDgYSXIq8DbZ?=
 =?us-ascii?Q?nnrC1BY1b7W/QOVblNHuGbjIOHAsZOJVpj8jxWSnjKjjJkAUFaliDGMTf1Ni?=
 =?us-ascii?Q?GPVrwY+wNcLPeJLaZe4ctcy8krsdFO7/OzqV5Rwtgk/4S2uBlKUi6LbvItsI?=
 =?us-ascii?Q?sM7WRl8EgMSnfRwlVaCQNc/c9GclnSdLliIDqWpcHmRUtomAw83JUV1btwVG?=
 =?us-ascii?Q?s763WYekFFUUU6AP5Syk/xkvKQT4wpckscI1QiUHEfZ6M9VoXTZbG9YEPuSA?=
 =?us-ascii?Q?bPSX/It71+ykb62jBppOrozpJ7qeDSElbj0POx664DtMe23OmggIV48GI0p7?=
 =?us-ascii?Q?6SHmxWdJvWgi9ZrxVF8glpWWVXGGLvWZ+FLxUis3QjFSl3asuC2G1zKR+udS?=
 =?us-ascii?Q?2gDOzPjl9vza7q0AY2onfWHjEOeWB+QCM2z/pCehfCfb397UUphcmd+SiHn4?=
 =?us-ascii?Q?3ATyjVMZGzp5L2PZ7oEznfi42jUqaljJNnZgzPLOV7YnhNpLuRLrKCbBBqDv?=
 =?us-ascii?Q?AQP20gmpP2AKyFWNvucrpifb9t13?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0DyWeVu0/JUMyANZu7XFvDctZ7nsxM9ofCHkbsMXSMeVzGO4G6m30TrwDXW?=
 =?us-ascii?Q?Vc8KvO21qmxMEnP8aNQtAyf6m1UouYqFvajBbbQ4a8KOSu6QPbRX9cuuzGU3?=
 =?us-ascii?Q?VZMCFHqpXcVegLIM3Ho6nXAeaennLQ1ynKSx1hONpRI3IDr6PUjxXIVOeXMk?=
 =?us-ascii?Q?MoApTi7cIOH9mgCPiKvN9qYA6FMBszCOvzNTYpSvuzPfEDZS5tZ67TVLsEmV?=
 =?us-ascii?Q?A16cBK2exi3RILYpWv5HABZnJT0ZPgiFWj9vjXncoIeM0/yBJ8f2f5sAGRG2?=
 =?us-ascii?Q?DzP1hhph//5/n7DMsxbw2k0VquHJK5YSNCbtVfwoaPDW2RqPHyetCzeSnXPr?=
 =?us-ascii?Q?yTJSSAf/HTlX+0RJ+uxinfJsVsqpjb1QgmQMHQfS5xc+ilSafrcKfRsljbLu?=
 =?us-ascii?Q?dqWm8xjs/vwe5OjupcoSawfCEgdIjVQ6575YAquZeTwipB1QxKWjdte5YN4+?=
 =?us-ascii?Q?yChbmaFWv/NeqOtokmuKNnNgCCm49pU3dIUy2yKk4Bn/+CERYNupBebvPxPR?=
 =?us-ascii?Q?AUfESRE3HVKrIF68LwzmqdurbSCUwf9tZ1dfGZ0OTZzS8KU14bvl8ivx+QBE?=
 =?us-ascii?Q?TPaloDgn+/f0Vu3LZkJayiX72gFWghzDeb5YITkgGJyIIKHiLFbj2Hbz190H?=
 =?us-ascii?Q?kZkNMPF7rZPoCOkgIckuJNh7QjsBToOEKHS9RoYEjTzkiOxjsqjhuzP2h/Xc?=
 =?us-ascii?Q?E2tq6sd45ifPfwFb91jujrBtnKEx3p0ivTIqc9jJD44P1C2QTYc8/33l0+aq?=
 =?us-ascii?Q?n9ciCE+nrHIrSX+4GH1NsXMVrVdwr9Y985BH4Xj3MMH6fzQsb7AfS3PRBQYL?=
 =?us-ascii?Q?5dFX72WHNBhCDaxNwLCE0uhiSq6baxMyIDyiysgGIEjpYonA9nSWwzndLALa?=
 =?us-ascii?Q?C1dP8MSSNgrfkKCLPwXIIK8efypQPqOsMCc4HdQBzWy6dunVB7e1RAo5vE6R?=
 =?us-ascii?Q?3X+bSGVstQupdBki9j1/1HN8Qg9ujN6Uw5AJsrAOIbhdg67sufJ4Ke7ZExLH?=
 =?us-ascii?Q?YiCZBeQwGo6/wuS0YTQCvaO0tsIdYPwcCl60Ws3k6q4/rS+DXEDeyrWnpBUO?=
 =?us-ascii?Q?ijAUdSrKcM9WA+9OQcP1lLNmB2yuh+mEJrKZ+oT3MHFyxxufT5gChj8LcRcb?=
 =?us-ascii?Q?UXtAf75WwGP+t4JSzBxga6SXpe8Ww1gq5s2iodRFJ4MMxiC3+gt2sk4culdU?=
 =?us-ascii?Q?BwSle2o9dZoeZ7MTXHj69pX+bfJUCx6kK7KN2Fj3C1slDMlks8KlZ8VUfxv7?=
 =?us-ascii?Q?FzjNmeSCJ5lOG2edSHq5PntRt62hqP5rqsY+C2KR4oTwTfv5ONh2T/ZfDeMX?=
 =?us-ascii?Q?HZ5nfWY+jJQoGE7d2gL9T8FZF+D2+tdfKXp+8rbH3w+xDGnwJLY9FrP2f/TT?=
 =?us-ascii?Q?FLK4yT06SH2daMgZSC4FbAKXo+luU9RvNs8FlQRBpz/dHNDdBCFmw2XVYgFT?=
 =?us-ascii?Q?u9nGW1iXYg2wD5B+Xr9Yzf9zwtcs/nItShp+gIBV1rRJ0Gh8PGav7rPDVRzv?=
 =?us-ascii?Q?L8X1sXHQbg4xNRz+Xa7ivqqddRoYM/RyvLJutFC8ukwsnYsqYTE9zxG9niGL?=
 =?us-ascii?Q?+PZ2btGc0WavWCe6010zUan0TFPCxJviBf4x3OSd?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9881e7b0-87ec-42af-64dc-08dcb8efc73b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 03:51:56.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uSpsAOu/Sz5vnMHFdP+3ys3FgW3ErEUl7bUJ5FIC0j9jegFLNMOjZhmInQ/FSjJNm0QKOHD0Cxp9qYS9pLenw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8564

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

Changes in v9:
 - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
 - Add if statement for brcmf_of_probe in common.c
 - Retain modifications to of.c other than the return values

 - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/

Changes in v8:
 - Add appropriate errno's for return values that will be
    send to bus when error occurred.
 
 - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/

Changes in v7:
 - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
    value, move clock check to the end of brcmf_of_probe
 - Add "brcm,bcm4329-fmac" compatible for wifi node

 - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/

Changes in v6:
 - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
 - Add return if clk didn't set in DTS

 -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/

Changes in v5:
 - Add more commit message to the clock in bindings
 - Use IS_ERR_OR_NULL as a judgment condition of clk

 - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/

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
    AP6275P
  arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
  wifi: brcmfmac: Add optional lpo clock enable support
  wifi: brcmfmac: add flag for random seed during firmware download

 .../net/wireless/brcm,bcm4329-fmac.yaml       |  9 +++
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 16 ++++++
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
 .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++-------
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +--
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 55 ++++++++++++++++---
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 24 +++++---
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 +
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 10 files changed, 134 insertions(+), 44 deletions(-)

-- 
2.34.1


