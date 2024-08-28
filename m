Return-Path: <linux-wireless+bounces-12105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8DD961D20
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 05:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739211C22024
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 03:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F8D7D3F1;
	Wed, 28 Aug 2024 03:49:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2130.outbound.protection.outlook.com [40.107.215.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB73DDC1;
	Wed, 28 Aug 2024 03:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816983; cv=fail; b=YPrXLD0Vi/jkFTb8WF9eYgmcg7NVNrrhRdrFVOhBwAqMP/gEHqLNqNg2gfWlKKGygTnapf7LfC6vbCdmHppWjvT9iUwJbJkI/RQFyNompux/xCZXYcPfzfTmhjS9zFaycLwrVlZ4134Kp0B3W9NvlNr8BUxY+t5LH1NMwnq7S7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816983; c=relaxed/simple;
	bh=kBiV106/0wxWxyCK55vX34F3fWr6XEWh7PQmJK1FrHc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QiSga7mrsROr9lABSu2U67k7vG4gVfcJtBPDhtWNfwKhQxE0fnFKJKSvosf9MdD8o7vBFcxYpVbOs/souku6dJUKIATEaYh109aYCjiQbDGCf4FiNSPNsZrOmbIm48PWtu5bY9xhY0eRmULK+yTveXugHyvyN2eGE44qnPYvMLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3M9KR0NbYNp+wUJIVczboDjlif5outqClC21oxxCmwJiHiA7rmbI2VLglvhOoQJcRmeiwpoPdPchHIaJ7SFXA8Bo9mNc437Kh2IsYA/HGo+wXrcc1e7WxpWAlDrIKpgG7T7xWDXuvEiSMsV03zTuGi55IRMs9ViW4Snh99Gp+al01MYhRYrV7m2Ond/qg+KFl+9AkKIR33gWg0KutLKK7pqbjRoyXDviQK6b3+/gwVUWUdpFLYrhUep1aKYOmWOeL6u7/jVaE3E3aNh7EYi6M6H58NCHwS4qe0D2PYPJb1HO2YwoN5HC+Yw/X3rcm1qrjBblloWGDEZ7fA3wHmcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua6wgkTvFbrNvpyAY8CQ5kMzdv9XuQgJSqWVCSG5z1w=;
 b=lENwX3q23e7+aU1LLAPR1wTh7lFUCqqYipXxiwpop3csqv62XFAMBow6YBX8pRLJ3M2+C5n/KJiHT3B+kfAZFdX4GQ8GY5iGzG63s4+pHU4QBah3TzTbV4ZcevPvF8mGaVtRb3LpbparqLVPEVwKeSDYi2Dj0yyFsjagm2eRsHoLJWqhjYAXVrRC8feS/zbcxR+xmFezXDAxUdxyXZwPw2VBhuoWEAW5ket2PLg/0pxoRsbZXvn/aJuRp3TyTxa7J74eSyHw7m19lkYo55Sep77NO32xAmTyTYbV3zGfmnvOVrYsKBGVo21KdyvkzmF0lmiOctZE8GJRv3u7RoiXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8233.apcprd03.prod.outlook.com (2603:1096:990:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 03:49:38 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 03:49:37 +0000
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
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v12 0/5] Add AP6275P wireless support
Date: Wed, 28 Aug 2024 11:49:10 +0800
Message-Id: <20240828034915.969383-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: e2ffda7f-55f4-40d9-4681-08dcc7147055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4aPcZo10PbbsQ1aFqUgKwohX9RckTz4ZgbjlmM9pr6q7qb5zmrIJ6fKXxEIo?=
 =?us-ascii?Q?GcEp8Cv+Icttx8DF7PuoNZ/xsmlvwBXgmEi1OMPtrpimjkb8+qUelb/sA0MW?=
 =?us-ascii?Q?xi5RsxpMvBYcsIrW6b3ZSrog2SVDAo40j77fAzAjbJfqwIUodCzrlmxMdud3?=
 =?us-ascii?Q?e9ys4c+cEJhVpmzkBlu6+Z8RoUnL4DaKEXrcYmmOUSL3UiMLYN5a5rI6irmY?=
 =?us-ascii?Q?jAQQw5sY0VH2cMer0K25HOmufoXeqrrj/3DBJJzWnIqSkPg6JdC8vD99iMnE?=
 =?us-ascii?Q?R/gMoMAUimPWucge/a56NsndINJYPfZDS/HfeX5FkVuQ3oT67iAbgljZBJyr?=
 =?us-ascii?Q?KwootkNy3awRCGvVA3WXuABvqmId6uZsEyXouNrBZa5MW4f8CteCfzyOFSQZ?=
 =?us-ascii?Q?rglvAADqtTffEnfh6UpkMZnoC/KkwLbkX0oc69YwJ79m2wKIfKluR+mQbKcT?=
 =?us-ascii?Q?oOl6+f715qxGBjiCS0/R7/STAmZmgTeoFNpK6x9uDTbXRPn59aMdBltCROiG?=
 =?us-ascii?Q?Ui+nZKBKg9/cfXcFAbyx1OYJDd+SwMLKnmjD2nVaUQ1HNRBvKpFylXRn5m9Z?=
 =?us-ascii?Q?U4TWdIuY1Bj/FBO+smwfsWTCH8WLKGzIFp2yV1XP7oODrKfNVWoKPn34NfM+?=
 =?us-ascii?Q?H3uOC6rUXG0uH9hgFCtOgDgl1u+BEy86yx0vAE+RLJ2ldrjowMY07mnQ/Bzd?=
 =?us-ascii?Q?ffN/a92byC/wjG7kaJlizExYZ1Ldr3ndycUmhe7lM/1VCXc1mgThQwGaeoq6?=
 =?us-ascii?Q?tFjVSCn0djZaAp+hhMt/wZEcBS48E21nPqE9TlBsS9CMMu4u/VvB07J1NB+W?=
 =?us-ascii?Q?s76LTAo5w2tGL9odUi6NUQqv0478dg1yZvXu1bptV1iyCa93qW8avTTKJJHi?=
 =?us-ascii?Q?t4Scwtv8r6vGPuwKiY3QDjMjWHNsqhrREjZ73SzhsuL9v3obH/Kp4PnvUiuU?=
 =?us-ascii?Q?Gwf7M0XycqT5dmWJKWnht1vBnRhfG4H5UISN5Vt1DQ0x5Y352Gmfx7xntHtr?=
 =?us-ascii?Q?p4CBP3jWvunK9oTslBD7VPhPI+99+Ilat7HjvwlIT1TYsa862yh6fg9pnWjo?=
 =?us-ascii?Q?NQNqFdA3xUMKKwwN3yauXnIVqv7g7WX4hYjMgKTeyACF2WVbfeJECmC9FXax?=
 =?us-ascii?Q?WuiosbxsNVq52Mp7yUo5/k2C+lQOkHfwaBd1DM+r98dzah08HDxrGT1cJafH?=
 =?us-ascii?Q?IlATTzDz6s3BAdpeYRRlOIrP73CcoIZAERGEAxdiw0jNDeSBH9K1skEc0IB1?=
 =?us-ascii?Q?itSoG9TodhLrUBAHw2L6mvAIU86QSTZElzZtrMQcXqu8u64Vs2rF0AeT4wVX?=
 =?us-ascii?Q?RayTHDUGeguhNa/odJLlaT8ZZSB9SPkH+a68948QcIIrbUefvUv43uTfzKto?=
 =?us-ascii?Q?5xTMMd/mIGIaAnSaXZXm+CrUoByp8k8eKRe5QU0NrHu03wNgGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CE4YZevHIYLIZWHxztbvXlxIL+HkiPaeS4gXeQk4tm6OWLhlq7F4PeuOb+bk?=
 =?us-ascii?Q?LwLNrVo+J0L1Ak1XnXgldcSaVl+QlAS8rkW99awWy2nzNva2IQwxHwzB9Rfb?=
 =?us-ascii?Q?ecfmaG2duIpAZKS20dRcXHDoUz4uno7JYpxkWqXAK4utK3YRXXHi88+3p3eY?=
 =?us-ascii?Q?r/6XLR46XF2OxsKnvvNosSE7tfYplUVcMPFQkSFefWA89kyOHmVb1uQ88JRp?=
 =?us-ascii?Q?lOEY4pZmD7knvCL3Gpdec/kpN9IQOpZre/tU0drPLGoZ13cCtGovgfDHtyoG?=
 =?us-ascii?Q?v8yP4K1WpXqgksqXe5qZHxfYELaRfbgkHsab7XKSgqfrSh5c+9NM5YsdNPT7?=
 =?us-ascii?Q?SykKyJBEWc04NIv0iYHCLMoJvrtvBR8ahBL2w2VVHzGtPu6Jj4a+UuuWQIOd?=
 =?us-ascii?Q?YgTHJKuBhSahHv/+/iiPX/wjIg6vwawGvlvLRT80CzrQtacdrvFYQp8Ea6tS?=
 =?us-ascii?Q?wVGu1q2hsAwUCzlWmTUP2M6Dts1tU+91ftZ90n0LC5tEc+oJAN+HTa4t2e84?=
 =?us-ascii?Q?+fi3bb7T45kiVbreECa/dA8nJQMelPu5VTnnvnqQtBDIgSwozdP5jdMS1sKk?=
 =?us-ascii?Q?AhUKd+K5jStJo5pNOyH1m2nL/PhbLROLJkXTo3TcZGMdr4hrhazZ09IfayuL?=
 =?us-ascii?Q?Z2lTamlK+Ff9ePcsa3EyVMbX+tavqR42pzQidC3876Ydq57K6bd9gmV3/msx?=
 =?us-ascii?Q?QsCd1g6mtH1zraf5y4UTaj25AZiy87KlJbG3NLn4Om53hGElth8sQJm5KDfu?=
 =?us-ascii?Q?2mmlSxhmGHQei8znxMvXP9Ih2MrLGSQZ5Fu0g7BYl+k09MNc2+Vx10omOdT3?=
 =?us-ascii?Q?T/N7BEEJ93LkBQRUG5cTzA2Ryykz6upcovdgxlHoAWy8H0cNBxLGaY2fchJb?=
 =?us-ascii?Q?tMjDEbKxSKTpbUNhTGaVywcHbb/DATyacEyRwXgW/bsdYyjxu2Klddev4eBj?=
 =?us-ascii?Q?7UXzLzut2ScaGmZS+letTWn2pHr3nWW2yCSb78UHF1WQQrbSpqrtMO+gTVP5?=
 =?us-ascii?Q?zBgiEJhUdzyMfxarLKVmizTIzKFbJF+A89dmFgwk2c5BtSjmHHJd/sw36kRi?=
 =?us-ascii?Q?pg7pzX5oOyEA7xW17Vuekrw36zE5W7151x6/wsGQvHMAT8xZuc6toMvWJtwP?=
 =?us-ascii?Q?QNn7OlF/UfzbG6HGYEM3RW9eeSucUMudzHqjOrh7XaA1FOExbBWyms6se2AK?=
 =?us-ascii?Q?Dh5NtRmVLxqmBF27OL+3BGh2drKnm+Lqw5xjUuK904lazQ/7cL0Ze4FRnQyT?=
 =?us-ascii?Q?GBkY1xxChW4FJR5ei2oKBYm22wMSzztQHY4ZzM+IZKDOBdvqrE87mzWJewKp?=
 =?us-ascii?Q?N6ZoFQjPmGB9+0Y552cN6576LTUvFkxxDkOSy1VOmYi2PZ0tHGq5C5/q0+un?=
 =?us-ascii?Q?f7inTA2/APST3ypABkWh5FfVd0Z5OAjigV1ace7X1QkxJp09KOOWd5xaX0Zs?=
 =?us-ascii?Q?nJS/5+OwM6/fHtWMEX3h7N0pB4H22qf0BJvzoJWuc63pHyDQNUH/RnYK4PTD?=
 =?us-ascii?Q?3KbJEjytMzPFLjDCnNtPU13frzmmdmPON3nAMXHhlDBuss05nWA2VCxTlcox?=
 =?us-ascii?Q?BxgF2HTYi6GBGrTW4tg6aYv1PVjt+hJsF9EobYTH?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ffda7f-55f4-40d9-4681-08dcc7147055
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:49:37.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1CDtHoSI8pS5rsBhJ0uy1gBjYMLPqWDI8iDQcD01bT+j2OfYmBGAjYifs/J8k9Mt2uKOnutlYmvwp/knHu3tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8233

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

Changes in v12:
 - Add "brcm,bcm4329-fmac" as fallback compatible for PCI ID based devices.

 - Link to v11: https://lore.kernel.org/all/20240816020635.1273911-1-jacobe.zang@wesion.com/

Changes in v11:
 - Retain interrupt check in of.c
 - Split DTS and submit separately 

 - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/

Changes in v10:
 - Use ret instead unused probe_attach_result in sdio.c 

 - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/

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
  dt-bindings: net: wireless: brcm4329-fmac: change properties enum
    structure
  wifi: brcmfmac: Add optional lpo clock enable support
  wifi: brcmfmac: add flag for random seed during firmware download

 .../net/wireless/brcm,bcm4329-fmac.yaml       | 27 ++++++---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
 .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 29 +++++++---
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +--
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 55 ++++++++++++++++---
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 20 ++++---
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 +
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 9 files changed, 113 insertions(+), 39 deletions(-)

-- 
2.34.1


