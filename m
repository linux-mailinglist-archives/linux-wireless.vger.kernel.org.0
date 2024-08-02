Return-Path: <linux-wireless+bounces-10846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF43945663
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 04:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950A12864D4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 02:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672761BF58;
	Fri,  2 Aug 2024 02:57:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373715AC4;
	Fri,  2 Aug 2024 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567458; cv=fail; b=fJ+LsRX5D5OXMyrmxI2vVe1yZHBAUlvPpyI5UTUY+X5b2aNbrEkqo/thAcl6ufFNI97tCZTSCceBQzdH2FTKhFlx3+4Vlaw4rBcmjhIAT7pI1MY36koXpLNO/LfjNVwHuAhMIgq59cWxC1S0/OO8SL3tY+48y4Ys3QxBYrFzVR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567458; c=relaxed/simple;
	bh=06p91y4gYwFh3ItcC2YiX0pNjvsD9pt4sOwY1PLMjZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lpVWClD+Cg9ymWyJ+gY50xBkjmtYf6z6G5OxlyAbQMq2wkdSoPzphwiRU2c7Q6mizRiEKkjAjSnM1EevK87FrZc3Nj1vbBtNy0VIKN/YzDJtdyTyFVrk1GlPZMT690UUxaG8XuN1SsRVY3PvMqFUIxcewDyenPymXhLRi8OkqBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDzzUyCJ3ynYJAogSr1fdzcgSCiV3fVv3YUU3Q7hIGeOBhmVBXtTnkcZ0e01l2ZxWl1+0hEKhfAUiFLSCm5AgBwduNSDiv9wDfHigRhe/kvOizt007ZPkH2I/13Nc2/s3Q5tJ74i/bfsn1sqENDmQF3k51yF1lC2rq9BYmwqGdsi1jOdBDhNMjv0+EQYCZULxqQqYzYTKtHA9TpXZQWwvJqeKIyDTyxkg4SER+aA4r1V4VIx4tHLyK6Dn9dKR1MfWmOEmpqwQDGu55zgxLcka2qkYR7jPJQsHph/cYI1niRHe2pCdFMDJMldkqbrMQJJfB/ndIloghJ+b3lp1ssgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH/E6yU5OxXmVOQxAS7sXHXmOWZLFkG/Q0tcSeoonrE=;
 b=kYQIRcwTAsU9nDOlIe/PPCmT29y2H/dIUUqtUTkLrSRP25rbhZdW/lvrZbw8uw/l4vv5iFfQUFrLaoOR9HZGEgA86zt5+zO/gTH2UPvwytc7dyGQSnypIbnK9JcVLwgYGG6tCqk/aIYtqh28wM2VRtMLFSs7nSxoWxnYwyU7TgHS+xGUOe8FsyMwhtHZOvC689SOeQuXkS0DimGX3aG+yeO/QOIuOQsu+jdHP+FG8KyN4ow0X3CzrMWj8oZ4NbGgoAnEiefnVpvDoTp8/YOcmwoQ8oa5hXkpxqoI9HiUs1S71v/mYAGBz5FHluxA129BCOZm5UozbSU49GxjOimSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7120.apcprd03.prod.outlook.com (2603:1096:101:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 02:57:29 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.016; Fri, 2 Aug 2024
 02:57:29 +0000
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
Subject: [PATCH v7 0/5] Add AP6275P wireless support
Date: Fri,  2 Aug 2024 10:57:10 +0800
Message-Id: <20240802025715.2360456-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 1f717a21-9a4b-4925-1be9-08dcb29ed891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YcwxjKwUE8g5kRzfFYyE7Mzf16LzCncg/ia+FVXb+ViIAiigq/3jTAy5rJYm?=
 =?us-ascii?Q?QfIZ2ULpEgFbq+rKmaJWkwxvvXBVscj25QHDF8cZOGROMSKVN0NWfXtIylIl?=
 =?us-ascii?Q?TdLAPui1Jj2Y4YxfL/6zCKmbKAOpVMD6ezaXci4B8WOl0Pk6pKfn6+jF0UPz?=
 =?us-ascii?Q?HIAuA3zw/9danV/ChjT0oZzS+ne/sZiVV8bx/GZe3uBd9ekhWnNXtGIVKzM/?=
 =?us-ascii?Q?7NaukLHmzolRTxOPYTKeY5aSAp+ItYgyBuSl3RlrTvtJsaHclf06MsnG8DuG?=
 =?us-ascii?Q?j084yjPjSr0Graxyn/V4J3qPSbYxQ2c7qvyt0lfXTW8ZZKXns6PjYUttL8cK?=
 =?us-ascii?Q?ON7GhxVqG489HdLLZCVp+Q0wHOKHhLybfDwP50+I97KvYU7eqrzkx/TGuDPX?=
 =?us-ascii?Q?o90UkTdhxhB0HVF2F8TsDJPSFQvfTz2Y/YdHxxn9ZZonZi7T7Hwi9cuIypBg?=
 =?us-ascii?Q?piLXTgEOu4dsBfgUZZ739RgTDG848dp7Nxh3PvoBeOvTWEM+b7bvgj7QASae?=
 =?us-ascii?Q?9Gap6eARxkP+4t+L9q/JQO3+zE1IJsk1ZWjllCvH90QiWkissU5gbXAn8aNz?=
 =?us-ascii?Q?P+7/OSDBSbqt0Mt4Wp03fpfto5vTmNyCgs95hW9znY/n/pAKUX5+Ar0thr0Y?=
 =?us-ascii?Q?2Rti8KBuFwaxmD03PYQZD9FQmpp/WscpUayg/O6fDivqpE/clzbM7sfJyuXX?=
 =?us-ascii?Q?DZagc95m8rbDaecgx2kcR3Gl9yUapG+TvHn6HXra0pP+KZLGWUPOkpWhH6oa?=
 =?us-ascii?Q?ikI0n6uyPFlupH4l1EBMUVAXUiDOpe2WvRd/65QpGYqM786uwIK62z5Xw855?=
 =?us-ascii?Q?vG+RLCNQFPuMlq1hR8z3nyyuZqjb8wx2FDRnjR2i5GlC83bpG/rEQ3rMxJ3g?=
 =?us-ascii?Q?kU+ZukFnaYKWSDU3iMHU0GQZ+YOHmRcrfHan/wwuDiQpamBGc9dHIm7Ek0Lk?=
 =?us-ascii?Q?ZlJJkOYu7xkE9LGhywhCeRJZcxA5Tow9piAsVuzrn1D+i3cOUteYkOWk98ci?=
 =?us-ascii?Q?lA/X10z2NjkS05nAj3iZ6LMMVHM8mvfjACRPRNdhJFnpeXRRP4osKNUdYzXK?=
 =?us-ascii?Q?rL7rPNVMO0Fr6DoUzo/M2RcZJSlpwmQsfRtgZxsQovpho3QBI5NhkAS2uW6K?=
 =?us-ascii?Q?GMSYYMC5OK5+IN3JukUsNNBECPQShfw/Xr9439pVhMHWFNiQbTSQc3MiktwH?=
 =?us-ascii?Q?LvYsLs50bXz+SaMO+FutfFLJEartVCQGqWBIrkqetJ7J3JP1Zbt4pz+7cFOA?=
 =?us-ascii?Q?E1UzNpDmNrZGj73ReyHR9waXfeH6FruLvFvkeyXRmQb4kfsrutpvU8uODAq/?=
 =?us-ascii?Q?QEP5vVJjPqnoo5MQDePxRROBFNdmgH1BZIAyI/XpLpw98cyXKcnu9gTgHZRc?=
 =?us-ascii?Q?56ZbD+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9DW+DE5cZ6V5DkoZyxh8FwCFpTjoHGEBOKwfyD5ugIxg0X6uzeo/LQzZdtg?=
 =?us-ascii?Q?rUvMRF5AfaYnSqIthQTFRFhZl83kolBPtVFYaf5mQ1egbtFdntBco6yJZvHK?=
 =?us-ascii?Q?kSNm0egnweOw6EB6/yoOthZP+yZJUEoAAIfpHzSHYqRSPsv49ipWot1v/uDP?=
 =?us-ascii?Q?wBKRnV/b+ueHvxvuIC2T4j7LRFWL9e4M2141OL/dE4T4HEmBGCsmwcdWLxFK?=
 =?us-ascii?Q?LDg+Q2f/GOzAB3Yy9w78ZkD1pWfA34sMSPCgFYekJu6YNYYXJcoIFCYsJf7g?=
 =?us-ascii?Q?Y7ja8j74Qt/x8dTqg7ew6PTCMjfbM5U8h8SnYqOlGGtxL9OQ+9/AKnXbvbl5?=
 =?us-ascii?Q?UpgrZ1eJo6nU9fe72AEktnlAbXm1tXL4dmyl/KNhkcGfiD2YkAVWd9Ewx1+1?=
 =?us-ascii?Q?DlMAi3+mKMqnKy1v00BfwowxdlbwA3wvllUCvMpW2ikb2sRbqVT8IDUd/hhT?=
 =?us-ascii?Q?egVSHjBImYQJo6kIRKXtjjbchcAnssItH5PnimiZtagQ362D2wt8iNSgWmva?=
 =?us-ascii?Q?M1ZrrNZ7Ueuud2ZASRw8O8m3G//OKGaU0TDV6SIRyVrb7ppzSwG7zqmQcF3z?=
 =?us-ascii?Q?FOsTEofMJ+gdvkczXnj/aDHw+EbZS640cWCKtskC6tJYHopJd8Qbg0jnJ/D+?=
 =?us-ascii?Q?H3cg2CgpjPkpZrqtjEE8tkurT7lOUVcvocu8I2iw+2MPagCIsEzg57RByYFv?=
 =?us-ascii?Q?Uwo85diQxhna502VmECzVksahYYbyYku1+FgqjvSqFEap9XHxe7dCm2Q9eBU?=
 =?us-ascii?Q?4UgZlOEd9w+TkV6YN89KOBsPbGTwpkPdqiwaR/bs1RyhcYkY3hUwsXsXTqIp?=
 =?us-ascii?Q?HP3rYnu7ZD94XE+Wo2M1DRBvwLHtLx+ftCnrNsOq499/ph8n1PN2l9qeUYl7?=
 =?us-ascii?Q?qL2xfopTOpqRg4qqsXrX9Huopqf03jEbMrWu59tBOCv32/8rTxXF/SyLRHDl?=
 =?us-ascii?Q?UQM4W14EwSUDJKvfuhs5st4WovQywgG82bvjSjX4pP28Ot9cYxd6/XmqawMP?=
 =?us-ascii?Q?pQ0xNAfJmRn5ZYMy5Lfc6CBp0fKOoBfnAbY4VkZzCyLnktO3vhE19TOm4+OY?=
 =?us-ascii?Q?ajlI2nsnusTXwmaT8jQBy57QZohXowoBqg4KV1dfflNmjG+lgMmaJhHXD4W5?=
 =?us-ascii?Q?LSdKNWwJyAHTFEnphCV1i9aPPVeAalEipPr8V9qZnboEWhnqrxwM71fdRCi1?=
 =?us-ascii?Q?ie9byRiAFjBP4aioUl+j22frpYTyhvWAtH4GQwuCmVE4C2jZAHAJQnVNl+Cl?=
 =?us-ascii?Q?E+O6WL2ChUY/mu2lS+c5D7jaz1H6ayHs4L21zmlAuNnz3Tw94OKIrB9MuC0a?=
 =?us-ascii?Q?6WPEAjmUe+Gb2mKVkeaNag7nhp894dmj2a0V2kaGa8Cy3UfY4eYveZPOdfdx?=
 =?us-ascii?Q?bwMpKUoBQMENfynsVVAmBr7woRhfXjm8rwcJZMMF9pSixLeNrgLnCkI0AI4h?=
 =?us-ascii?Q?J8AX5IyO/u58+bxFBBDLHO5+hkrd4f0VVBtOdJHw6PfL4VPAkmSomlgafBay?=
 =?us-ascii?Q?vzgrK63MXf3KVgRS+Rx/1jtn7z3On2Ny8pZU5Bl6Pz6Z+rC/8el6RczOmmEr?=
 =?us-ascii?Q?B29sNIp6SrGJahSpZO7Wy73IIQhgSbxwZIH8WGj3?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f717a21-9a4b-4925-1be9-08dcb29ed891
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 02:57:28.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zxt6evR7gJ90scRtBMTejvTdq1VlGSvjAh3nr2w3UrUrrwJyO4B22lBRV08mOJtaVMxPy1gl8/Ro7LgQsINCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7120

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

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

 .../net/wireless/brcm,bcm4329-fmac.yaml       |  9 ++++
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 16 ++++++
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 49 ++++++++++-------
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  4 +-
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 52 ++++++++++++++++---
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 6 files changed, 102 insertions(+), 30 deletions(-)

-- 
2.34.1


