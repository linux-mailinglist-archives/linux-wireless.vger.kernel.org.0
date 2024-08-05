Return-Path: <linux-wireless+bounces-10925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6A94761E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A781F2152B
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60833148FFA;
	Mon,  5 Aug 2024 07:34:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B36333CA;
	Mon,  5 Aug 2024 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843285; cv=fail; b=u/5HUk/yQL3pFp3JDKzQvGa3EQDED43k70NPKRzccTL6mXeiz+Z3dOku/mBvwHvanY25srczbIz6Rglr/P0mFEXKnJ8jphQuRazF1+JoQ6jNIW9YWHSU6nB3Q6pJQxG+EdbBZr4rZ458YhkEMY8Den1kYP72w824hmLedOI4O3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843285; c=relaxed/simple;
	bh=C30uLWdglNxBzumGBgsA0GivE4Gw1GpMMTWIu+/Yw5U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JroVZJMbYNTmzmnBlVmErjRksGoYu6urvgT4sP6r2su22OMovO42FkbGIwexGOXnFYxRD8b5D0+74rfFp5Qeh39zWw6NkRs7cX1YWHv3fd2EwZvxppNy16aILCANG30tXD1hvHFGI+jJVJtQwMTt0b06O4pQY4Zpm6+TUC/CbQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIWmO8g1b7oOWMafEzCDYPtA2shOK0n6xJJ9d+wQwHZiVWwGyfGv8yUa2QbobKQgWEXljC2+ygUmuf9FVTDYp3WGZ+2W2CTI6P8coJGvKNTf7iU/PE3DV1sdXErBFn18vtUdJ51Z7Vr3XtdwH7VWaJOc8xMxVyt2v4U2H1ZQ1RCM5ns86/5PM4CfDy3SXjg+PEphhWAT02AlN7672lHc2EWbhjgKS5sshyzIM/G4qXbH/DBwOBXjOxELxGz/ggIjK06/aJK4NlLIc6WEp5sONkzufYoGfS5xxQF3WCqnU+tdKANHurYtfcsY7J5iaCHwIAzYt4lkrWY8VG5pjZv9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbmv7CYQnne+n5iC/mAJMihfRBti3RW0UrXg360vIHg=;
 b=CW/iSUBjAqOyt8aXsJvlBY2A6EiqhB7GU+lDu72U/0ZOPXcu47KJpFu+iOFgIDNUIzm9GxQDkw0sYq18he5MUfGXrdaiI0lchQYtimhWCSu0jHFq0LB7B5AG9g7QwpBcgWR9BqPrsGqPsKGE297j60d2CKpuMBh91RVPfq+o6OV9+ElR/1FtrbODd3pR2bwKmMrSuz7LUueNw7TTTc8bxOtEN+To4f6rutuAY8sdxX/yGj62Km24O54ezMO7Yct6wMqTI8B07J1yH1mM26pOZYHz3Wh9my8RDlWOtHxhhUr/Sxlu8DrDF1lejwRojjdX7sv2jN+Wt6vKPn3V9CI9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8052.apcprd03.prod.outlook.com (2603:1096:990:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 07:34:37 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.024; Mon, 5 Aug 2024
 07:34:37 +0000
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
Subject: [PATCH v8 0/5] Add AP6275P wireless support
Date: Mon,  5 Aug 2024 15:34:20 +0800
Message-Id: <20240805073425.3492078-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 24e3839e-0996-413b-e7d5-08dcb5210f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k3fZRlU8YtGxBk+MCikHPDAIgflyM6x8O0JojDGcOi7H7GVpkOqvmcjyNDJy?=
 =?us-ascii?Q?uXK5d200z2jKPX9bqlNXSjmO2AkCsSDlXYa2RmNVru//+o5PgYhFKCjKZEud?=
 =?us-ascii?Q?3CDebajWQRNzEP+vxwn51Icj0JoEFTjni587Pjt0sk5F9ka7To7JDK7JOsFC?=
 =?us-ascii?Q?qRtLkSZ1/ZO22lOK3kn05q3EDY+s6pdpeoUnO6LnMBYrryw3xCr6oP6M4LTI?=
 =?us-ascii?Q?hJC1Ec+p6BO/f7ryOz359NRnwLvwA0+Pwe6jJu3G45nHHDRH20zX9Pel0u5i?=
 =?us-ascii?Q?Xe01KaX60uwfffSKqjpwIzigPlXD29BNPh8cYET2uWNLf+OtZxb6hGUyI0ag?=
 =?us-ascii?Q?G7LjuW93AYrZM4xMTOytppAQiXoyp7aJo+wZrIeAWcxVCWhCH7U1xmROO2u/?=
 =?us-ascii?Q?uV+/pzptyDkMzX4Dy8YdUzIjWxwmCD06wo4tBDRMirSYUd+HszDNVzSX5V4E?=
 =?us-ascii?Q?5jvEHB4/g5XogvcOTRTqyyvu0hing0kb7bpHGssGvXjzYzJ7RfWdEB12FdiW?=
 =?us-ascii?Q?ierU4UIa51IAAzce0MkJJEi5FIxVXtqGJuVPu2AT9y9vgxQdv0AcJ2Ho4+RP?=
 =?us-ascii?Q?FCffCk7MIkUMXzL88XvEWFsDryprm0wsPC3pqI5jPoX7VnUT4SLfClsS6rdp?=
 =?us-ascii?Q?DbQ4qwBVpaPoCN3acG5f8yu0Xqn3mhsrPHDC58h+HG1ccnn50humlStQTicN?=
 =?us-ascii?Q?/td0Eyx6iq1VEK5p/f0Y5xheWnoEispVO58Rsm9/RoGCeNViCP2SclMOaG7x?=
 =?us-ascii?Q?NHvJUZkgkpHuHdwAYn5iKQ26g774UmfpmWeQe3gj7/JXCgAhV/Zyd9wNkAhe?=
 =?us-ascii?Q?fBy3DkZRO9+JRgyzru3+KiXmkyEJI4PYnyxhttRrIr6NTk5b9hw67G7JDbFC?=
 =?us-ascii?Q?9YRo8Bfq+olIB6VW5gASbgVAdzJzUO6mM5vOOEVUluywPJu8Ynm7PT3scVe6?=
 =?us-ascii?Q?MG+GHi5JbjI+otRlS3Un995R8NsXV1mfKos3J+gcMbjEEerotAnapmYZigqI?=
 =?us-ascii?Q?d/beBsSG2ktq4LJaxclzXI9L3bWAinDB3/oJ9JMIvUeezQtXiV4sWTYJowW7?=
 =?us-ascii?Q?T9v8MYExlW0npfczx/X3S0ZS7hjaw5YrEh9nfDMzhSQ3vbx39Y8GWXYNFKes?=
 =?us-ascii?Q?OVM67a2cbPf1Pewv+UsW1pj/nczdBznmFw94kRj0uLIsVttNZ96txDxr1e3J?=
 =?us-ascii?Q?Zrj3wL/O1qSsFBwqNqy2uVxJfuYQr458mDXjJoG5+jgh1UmjpRaikvHmdtaG?=
 =?us-ascii?Q?CLdURlfF9s0CGanKSnh4YVCDXdqyLeWL4NJW8RlChwm1/EsRvPk20fwhlA/8?=
 =?us-ascii?Q?Jq2XGLLICzaff/1bj3BqlgmGXarPymiLZH1qDWkdto9ZuUI7MURpN6bj7+aN?=
 =?us-ascii?Q?IUWx85E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kp6C3vyh0PQPWPkVW/NHK6Stj7SSjL538GOrDVs0FjhdpgOuV3aIyGFucBJE?=
 =?us-ascii?Q?oTqBnlHKtwMquv9AJlVtkhQivFEwtq3cbnpHdo5yhJdJ1bHaZVvOaso9DuML?=
 =?us-ascii?Q?gzjYe2pAco0Xb+bIQDBCe4u3Kqrl4gJDGRWrBW41wHG/JiRzlVMux0GO4/py?=
 =?us-ascii?Q?eKchYvCvMqWN2PwN9U75+EnL4PYfgJhQSaW2oEB2evvKohZP1wHNZeoFqWeE?=
 =?us-ascii?Q?edLSi3aWSxSWlaJK5cipZDdVvkFC+aIu/TlYZCI4H2jDK8OEJhNziHdhy6Tv?=
 =?us-ascii?Q?NAigofpn9+Bz93TQbVrfm7OrbMaC1b2rKfYVOS17iDTYLfAKMP3kHbBmHryd?=
 =?us-ascii?Q?7i1zggsfk+JnISCKb7R+TI12OnKvjDGzXiXQ64eQuJjlzfCtOpEpqrjXYsZD?=
 =?us-ascii?Q?yMyIYVedxPTs0EMhUy5dZxey7t+f/HZAdkt6Qxp7eRqzMTc3q4taCBH+5KT3?=
 =?us-ascii?Q?ajsovxQen2MQQhvqD3oCLwLDH8Iol5Z12b2D497N4NOpQj5e5uP1OPDZWH4w?=
 =?us-ascii?Q?TfLITmkYNfdFuLl1RBuNC3o+1vLzd/V1fqRwzM0f1LSZ16L+Jije39xNy8GB?=
 =?us-ascii?Q?WpiyoDnTyOzla0FZNbbxlRkhVlWwl7rCCsnPZ1yafTfS8bp5yAwuYXT6yRxT?=
 =?us-ascii?Q?XkkUNwt7ZSpPlELDj9feTOLRbqGwkF49lIj2JFMidTCToPRQBFufk23za/Sn?=
 =?us-ascii?Q?fsrQ6cNsygfpFRRAP9sKU/Qj95KWUqw/KVkXHWno2lviSSNNozEfpQFFf/Ix?=
 =?us-ascii?Q?BVdoLBNve/kRKNl11LfAzS8pXUuD3myQMVIVbc31NZZKgBbQ7oRq/acCiznz?=
 =?us-ascii?Q?flCJ4D2NxxxMiu10fJfcWup03YSvq3drU7/2r+XIQa0N4e7VAkSttdwtJTdh?=
 =?us-ascii?Q?EYpCx2Dvgd1L9+6Px8ZceTS6Psb7cZ1KLevBgHqfhCBhtwYiDr6g8GuzzeJW?=
 =?us-ascii?Q?L6NVhUmHdKEAJihgHHzzInutAPJFkX0GQC05hU4uIvZIc8nQwmrKcXBkJzNc?=
 =?us-ascii?Q?aYVtg9drhODXQb/etg7Hk7xhVFby0gQ1U+4hFmQC2jOiYWR+AxNZkXlyf29o?=
 =?us-ascii?Q?4N9lzVut3U1y7J923M2X8bfGZ6t9O241BSZVPaGTA/U31YpIfdHjmM90/Qyx?=
 =?us-ascii?Q?xAUQfZOoE5j0Z8PIrjy93TYXlUK8GwdscBcSDfk0x4JOyUZmon+Rr8xdehHq?=
 =?us-ascii?Q?h1h0OFsxgCedh1dt/yS65fwTj8FcFi1ZHVyQgeZ9Jn81vt1NGoVr/+haII//?=
 =?us-ascii?Q?RtKIc1G27PseRpasL4CpL8G9ZOOdWqCn71b5w+quX4Lwnu+eXN+u+fMn9CxZ?=
 =?us-ascii?Q?NEpWBZiro3LBZTtCSuDHw0E74YQUimnq2sUc4SaqYPYyGhjo4kX5v2kbSZdc?=
 =?us-ascii?Q?1GgnDbTOF8ni+F8KwCmRr1WffoSGFPky6Oy6D9N/j3hlYVr5dSvyaK3NVDXW?=
 =?us-ascii?Q?JV+R0rudbBGjeqFGE4K54PEIBNmkFFZr6FUYqti/sdSPCbxqtDpH0WbvEcd3?=
 =?us-ascii?Q?AdYuvmWXk/iVLtoHmhxGzuUTjqMVxFwxKGxv/TEGJ2Fv9fMQjqra/eQPw5Sa?=
 =?us-ascii?Q?2Haipjw55xVEg/TqE7HB/B7ybNBVLkPfKIwMFqZI?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e3839e-0996-413b-e7d5-08dcb5210f4e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 07:34:37.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wh+jFt4eRm0rRGEViBU4bG48bQpPx+/hZ6aEgKKlSOZUwpq6G2WpVPvSPKhndOIXYrNSOqPHOZVHVwd4S3l2kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8052

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

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
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 ++
 .../broadcom/brcm80211/brcmfmac/common.c      |  6 +-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 28 +++++++---
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +--
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 55 ++++++++++++++++---
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 18 ++++--
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 +
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 10 files changed, 123 insertions(+), 27 deletions(-)

-- 
2.34.1


