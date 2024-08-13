Return-Path: <linux-wireless+bounces-11334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C394FF83
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 10:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2C01F24657
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A443137C35;
	Tue, 13 Aug 2024 08:20:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5518E29;
	Tue, 13 Aug 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537226; cv=fail; b=T2j0QZ6TZmeq3A2akqmpizt7n7fxl98q+IRkXAfhZnF+G6LUthHQJyN9UY177i+JZ9E3j4oa466U4ttcanKpX44HavsGvXB2e0n8qxyHsUT6WDaETO5yzSWNecvqjJx1U/FaV7x7pXCaadpkRxHxBfDd3LrfxFMnjg4F/OnQ/Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537226; c=relaxed/simple;
	bh=QLM+SwMkH/4ULPUg7heBOEurzKWzpwdqtLxyPir6eSk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BHV0dAyfG90PNV6Mbo7KW5Uzxar8Rj/Hx6MCM/zXFvAayjkkRp00UmJELKPv2G5ZQqWdBclRdIJBv8ycQcseK+fV6XLrwolKaFDeB2igJo51ob71kOLWm0n2tdAQzcw4rf+GpA6fHArLLT0hbXewEGVZkPDiq9YkyXkIM9z3C34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjvoEGx7JQrYWqHQ0gVjy0QY1LuLNZSLA/WbrQzva+gtvGB7zTVHvAcF+krT9bHurmNxm6AetsNzYE0BO0cp9YrkqlQlVcPPVUyr5+2o5nNWQ1b/kw3PBsWXbD15k/E1IX+23uGFLR5bCXBSq2b1CZxxYSDI2iyuPOl9PDqBixed7wIwDnFz2MvWusbp/TaD38E9BS0Aslam78yVcD+kdVL6cDg4Cftv/UMABQs3AOZ/ecz1EgJgHuEYzK4bWIhxn2W5x92pbU6UVcANvwNhTvqMQOaLxArbVY5CWYSz1SSY3fAzsa8smTdJHa1RpDflfS5uquWKp5j/i0YeJ8QPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qngay0JW9A6HmYeVLCyYDAVp6HXyaqvXfsF8k3Qk2wA=;
 b=HsuffRlcMo0HZNXg4OqzmyjRPd4u/9LqO/7Xpol/mqHFKzkA7EIXj+eo8k1v5fpCH48bAvj4h1wooFrlbYYCr0wt+8TpR4mX8Co0m4odx2827AZ9T7B71R3y5N+taxibfCnNvH/ssQPIk+h3J/YCA2oiMA0UUauSaWdYVC4at+cuu04/76WfxsbVf6WkrunzOkrcJY9jJVE8SJwxJZaXYiAB4vzh0x1UsvGtCyI2amm9dxXwXomIHlNKBtdJhrN/vKoA/4pdW85/f+wjUvtxgyaX9yXZKyTJB0DQs0vPWReqcIATtXbK/erNE6oVmjSDUQSmhfSq9N0e7yjauRcBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by OSQPR03MB8748.apcprd03.prod.outlook.com (2603:1096:604:275::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 08:20:19 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 08:20:19 +0000
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
Subject: [PATCH v10 0/5] Add AP6275P wireless support
Date: Tue, 13 Aug 2024 16:20:02 +0800
Message-Id: <20240813082007.2625841-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::10) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|OSQPR03MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a53096-89d4-400e-a5ea-08dcbb70c485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6L4ht0Xm1gTUe3immVspvgXWB3QlBHF2xTsbKmbSAk94sf9GwFrIiJJ1+EvC?=
 =?us-ascii?Q?ysoHuHwL2R8HwoayhS+fqub9IZ+N0KTZXeeIWfzc35h57VIwWVhl0S0kk9Fh?=
 =?us-ascii?Q?IDxkErGwg/OrnqtjVL6GSDVjgHy7tE6F56rrisXG7MEtDTgIEnjoxIvg566f?=
 =?us-ascii?Q?YuwSHVdwLGo58BVhm1UUboOBp4mxB6NDmqROASm461z/arGjw7FU1Akgxvyq?=
 =?us-ascii?Q?9Tli8D/AzCRmKKwDW5DHdh7bvpgRGVB4RdlnKNEUN3QTY8yUN9lUCm8zlPnX?=
 =?us-ascii?Q?2Nkvx7FXeJSQ1AWVWOahsWoAyF7KvKXCFD81jXjlcCN9IBDFPkA9oLf4RBlN?=
 =?us-ascii?Q?A/7BVCPmTW6r/314idbxF/3+UZhH20sqvddnSh8u6+/VND4Zsr7hxRwSLsMt?=
 =?us-ascii?Q?ettq2TT7bmFwbfMabSlfNfansf189kfDLR/btXaTZBp0FGZYIOu6B4L7No0W?=
 =?us-ascii?Q?CfDDERjEpys0BJ4ASVVhNsHLDEeakmVip3cTV/2Ivj7Jp6hCIjCAcNSgEwN3?=
 =?us-ascii?Q?01CpZMST7gaUR+R28djgepZ2exBaBKWfHlaqsXMbI3VFRQspf2mct5iALXhY?=
 =?us-ascii?Q?1Fa3aQUjFUWftSd5R2j51liD4rsp3Ib+QNVeQv7Ly0bhRCX/ZI1/DMNdxER0?=
 =?us-ascii?Q?sFAJoEr6Zo3XBLDu/f/q22wZEVoQNXgqZ7RbB+r+/gKv5u8ycA2PCsaO7gp1?=
 =?us-ascii?Q?/yz3ZaklM9i5adbQwba9CLKNalm5XgAWNyRmtqQlnU9RieA6GBrYScG1MkPG?=
 =?us-ascii?Q?4neELEnopoIKXk9MTFOuhr/DHo1TyfRk/0uaCscIYV0A7QheNSWlsweNhsLP?=
 =?us-ascii?Q?xL2gWhxpEPUJ2CPUiUWnXf7Nyd2eQExlqy7oV2KxSslFghuVzTHgRx/swvrb?=
 =?us-ascii?Q?ssdwP1Q0tt5OKmQr+aBjrZS73wcwVm5PznHis1gQKM4syMGbTlDe6ET1Urpg?=
 =?us-ascii?Q?3M88W2upO3epVFRbfuaUS6wkStqWplKHJf1epEze/P4dFZYOjUu1ke6BOaK7?=
 =?us-ascii?Q?Yln5GF2ETJQEfycYcbeKyVpuD1EZKZXegSEXU3GdjUSG68FIHgWd0TZ+AUkr?=
 =?us-ascii?Q?cgU+bGWdkZpjwbuq8a33+0MxpX6QZQ+IPZqo/JPat6yk+32QZ3OEVZ38+NXA?=
 =?us-ascii?Q?Jsd9bx2grNEnAfV1RO/hZ3utj44XQIkpc6KcaOqhE2xflaCnxHsnlcNERhkh?=
 =?us-ascii?Q?Ew5kqXdDOV27Ap76+0c8UwBsoLZU4V6oZvuSveCg8aOB6GfSfpdhAkng2tMQ?=
 =?us-ascii?Q?+JhFbkKnCyWHAt1OWcTTi4lpoZ8oGhT+AgXDe2Gj3YHbGNheDjDENJgKv9hC?=
 =?us-ascii?Q?jsfvzwMn87DEALw17Oo9bKUd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6piLFKMwjeVMviX3D2JRw4gxsdPhforeNncbm0ZVmrScVAhcxDsAg7Ujo5Dc?=
 =?us-ascii?Q?kvtk7RthnYYm0fURkicXfu67HE2cJS4vYyhw1o4AWfAJDGmAq//0tdCQSl3V?=
 =?us-ascii?Q?xV+ikeoPI+7f4ulLgSaBfoH1yIbo7gBnD4BExrS0P/D6i9ifIDQSzh7kTBoQ?=
 =?us-ascii?Q?yEyxTnWeBo707i5Mq9xcAQJGGV/B6VHc6QkHIoCZJN6Q7mapD3QEzmSLCWo+?=
 =?us-ascii?Q?qQyQ8Q1Tn364YH2qHWukv65pJSIcfFOoRLjjUsjcWM9v18W5AcPX3oXlITVa?=
 =?us-ascii?Q?VXSpBkgVksslEN5oGfpXZaVKK/BzieERrmM4hUUP1p1GPbR3nLjbbijN/K3+?=
 =?us-ascii?Q?DBp2/wtxUq4WvC7lcflmPjk3EwB92gYkFNCkoxdkCjzj8l4nwsE2GJ+imUiI?=
 =?us-ascii?Q?BMPo88/8amw+S4dY4xq2fuYCPlDOanLcPNvraTcGzJBUZnTtzqJrpyKi84hv?=
 =?us-ascii?Q?natBb5l+0+/44wkq5AGMfcf13bWiyFnLKUiBmCm6ga6k0CkUw77Lzsgw6StV?=
 =?us-ascii?Q?+Hsw/7QrzEuzacEdniupixmN39iriv8rfvUV1j2gMbxM+r/BkJ5fZZkKrrtY?=
 =?us-ascii?Q?dDBSAgf9kOnEbKBCKB5PAjciFp1SPiyDgK+IQDx8dFmrrEc36uhHjnJZcx4+?=
 =?us-ascii?Q?Jv6VCKAR1ILQp3lIGy9LpRrcw4j3sT6pWEAKxAJtsmQIjR+beQao3wPUZ0Xp?=
 =?us-ascii?Q?RlDyrFiGE13MAUfvVO32BnZn0ERD/lCcFCLaXQx+A0FVVMZ2Ed1q62G+G0KF?=
 =?us-ascii?Q?usGAOJUmbXcoSfZi5+0i4LWAjZ6UKSuhN2zUuQjg5oxfVvRwUcYUVu1lZ6kZ?=
 =?us-ascii?Q?e/EPObbbZ/spDEKpWD49+uNq0zk70fgPWDL/IVp/K59ZGC+uy/byS37XiFlm?=
 =?us-ascii?Q?Bk0BEwWJEBH3/ZGYv5Xtg7JBxNlK+Moga4Dr5ovnp80hu/aaYjF4/WF7AxsZ?=
 =?us-ascii?Q?VfTSdKQdq+2TT4eCptYNlUtbcg+9kGwzO/Yr8KLsKAQgtTsIxXEu+JPTp80d?=
 =?us-ascii?Q?HpQZpVJMUM+bRoAlxYJEn5mGtyuRqHA3L2AgWc07UzgAwtbPT3RKiWNUMiJE?=
 =?us-ascii?Q?iTpgGN8/39zBtBme5IGLW3xut/tpNTPYJdxxIMzHlMPRkFmtYy8W3DiwTokF?=
 =?us-ascii?Q?NWA+WgkmPb1SKCPMW1Lm+ChcFSA4jhm0haq0ohuaxmtoQVxKgiWhWD9g4QrW?=
 =?us-ascii?Q?+jiiutcU/L/rbYWP42Sw//uFyRdhh47I9M1LRkJK86fs7eYHfjEL3s6rIquh?=
 =?us-ascii?Q?lWZVULSyzqs12GNg9s2jRfEqEyBVzCm3nAvV6C3VFp4t4P4vR4RS+weujJgz?=
 =?us-ascii?Q?qi356qKSVmHvOlsU1anfLTht/ZLqrEMjC89SKGsEB+u7cT8d8hZyqpXUF7/W?=
 =?us-ascii?Q?hz9M1qaIQHKgD3/mVP8qm2qg+SfFRksbwgc4f/5tgOiu379HCOETjCCJcoSV?=
 =?us-ascii?Q?5zdt82jLhu0esYjS8bFEwRm8j8ieB6HMV4W1TganWZAu1fefUHnnvIHKk+Zk?=
 =?us-ascii?Q?CFj8xMZqnQFyjHRGM2gvhtDW/sLf6D9hQz9nc4FDtoWduy4mEgRCYq/4pF/n?=
 =?us-ascii?Q?ymfZMdwbRFvHHnPDVlWRsFF3tvXb2VxV+ts4Fx67?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a53096-89d4-400e-a5ea-08dcbb70c485
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:20:18.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT87yCNAtAJ4VAQP2NCYKdCna8Vqe79fxErPbih4lkuM4yuHy9snUK6Gd3xm/gcKZSzP9AUmiaYIWJWvZN8ulw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8748

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

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
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 22 +++++---
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 +
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 10 files changed, 132 insertions(+), 44 deletions(-)

-- 
2.34.1


