Return-Path: <linux-wireless+bounces-9702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4A91D04D
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E721C20A65
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC93D967;
	Sun, 30 Jun 2024 07:36:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8F364AB;
	Sun, 30 Jun 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719732986; cv=fail; b=ByewpkeQd41Axq3Bvx1wFE1mv3fZ1j+iLot6LUmkD0+j58CXTrmig64G8k/s7uULRzMN4ETxtuIYNVlvgw4s9RiIB8dzF4+R8Vr8UDY6i1sqBkxskX1SC3XrkTBUcHZn0JAtVXXGCWpyS6P5ugsgMZP+ltLRbpVD8yl4uyD8NKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719732986; c=relaxed/simple;
	bh=wwB0A238sLtjnS/VRPPl9pkxKVMjqGo3zjLdDqxLu2U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XGq/JDpj3KbhN/1sRZOszH6aFav+waoXf7Tca6dcy82+82TkPFT1HrZcYzAsDulfUMrOgUnc1xBMPgMYTFv7Sv+Kd6SZtosCY1JhBR4iUkZeivXbQ3LPAtxvkhH2ANSuo6J0E7vuGwFRmxlwdb5mTBKc3xdZ8JW7jaQFNDK9yag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUMnEyFWOHspQbPirr8fmIm7vKjKzM6bnW+iwpFnkZxVlsbScqJeLLx3KGUcwsfk8O5dpqAiHT2HQHOBWKLcfKPY6AhrZtdWkptoZBPS4szzo/DF3MeaC6YNUyjwT8y7fFdwSFEnTkrHSlRfS9FDeNOPYYj2UsfAfKdZMfXCjP1ynNMIvTKcYMA3NsuThh2x0X7pxl/Tv2rI2Kh2nKaK6amLcv/IvXdQusLDQyqn6EpSQCI0ANAl0hbcnOGLlNs9q73nVCMWmsgZEVvhcSAO/baqZT6iEc87jYJiJ5uzZxYuqMu5XsXYoBgWwW7q3AatndIlWFN/+V3V52kPld8gsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+kmFUo9nfAFnzQGF3b9GuIWp38OO1KLQYpCiAH/xHs=;
 b=aIh/4YzH+gTuVUMhKr5kwy/nLn3iz7z8gBRKEGhdrGJ70nTscSP/EURqhEN7V8Tn8kuwDjoEAUxtfq1LqglahB4tHn7njM1vhleLRgwliQRrUQTBJo2oB+lCraDv53bowxj7ax8Uq12kH2GxMM9bNToDr0MRtCVsCA+vvs37vJYqjwwXSvyrrNZ55uREHBg15KuqYb/8k6peF3rgDb7GDCkYkQTbPaSMQa471R9fTbNXLIHJPnNuKVqzMFb18WBBVSwVF5mu7ef2Bovzs+brnpOoauNJNrxVHj9SRvA0rnG1i49OTSSNxL/N64FSbkjDb1h6xZGJW8u/EjQG/TOWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by PUZPR03MB7234.apcprd03.prod.outlook.com (2603:1096:301:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sun, 30 Jun
 2024 07:36:18 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 07:36:17 +0000
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
Subject: [PATCH v3 0/5] Add AP6275P wireless support
Date: Sun, 30 Jun 2024 15:36:00 +0800
Message-Id: <20240630073605.2164346-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 34d09a30-3234-41f5-7cf6-08dc98d7541a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Rj/YVqw2Di7gN3xIpqzqnGwH/PFN68GfcBI00iOgxk1o6yB3meFsEDh6PFG?=
 =?us-ascii?Q?hxXL0AflkXurMuRu2okmabIPNmMi6mVydjznFA2SpZncjURzq/8KeUSw9vCo?=
 =?us-ascii?Q?6lCdsyvXIr+7m4eCMVDDvhE+4sa42XtwhRrUmPbAvwNxxin3monxYyf0rgcN?=
 =?us-ascii?Q?H9+03BNLlryWFyrPF4PA2mwQTZmI4Vp0YXHH9jcQuViXu0hNS/M1nGAd/WtD?=
 =?us-ascii?Q?3z+1Q6EJRMTxSO9o9AI9dzxuf+BXaY7QeT1f9DA79BExOQp5xwMM3Itr9pGy?=
 =?us-ascii?Q?6NXtSFlD/u71G5uY+fd85YjDPzCIyS2wEKm/CQL+8Ezxqc1Jwc2kjXcg+G10?=
 =?us-ascii?Q?W0yrcWAGNPImbgeRQZQBh7hFSA3YwlCMbksAvTJuXL24V5biZxFL9uKEjq1g?=
 =?us-ascii?Q?T/bGa5WEjquo+TNktwGcOWvEfkqlbYAAZ6QNTcyBIp9WeRmpVVm5/l+iODq+?=
 =?us-ascii?Q?SN0OTHHbqfwoh5sj6HWbCyWeB5nr89bKKVGuzS3AIQ0oXDHGlxeKgT5uNgTW?=
 =?us-ascii?Q?viVEjbScDRnxVAkiJkE/qf+5n2148+sFzfWd3YrbRVb8DQ8M8l0oaOeXwrxS?=
 =?us-ascii?Q?LjMFF4W3NIzjvF+0c+CLtN0FACzjz/b7FRx5U+TifzLiKfmemtDOFjitTNtn?=
 =?us-ascii?Q?yAfHlmlOAfRAcOv+9bW3dNngX4iQSRrlHNQRmMQW6Mpk3N/pc5AEW5VIUy8P?=
 =?us-ascii?Q?w8dnV/GGsEOoEhxX6baI6qFcDsAT7MZUOF8CevobVZxIrQNp9WD3k58O4Upu?=
 =?us-ascii?Q?65LpcomXDZfX+MhXUxMT60TzS8B041wrHGB2/lhB7+xxUs7uddBTJvezdgml?=
 =?us-ascii?Q?3ypIkDLZI3B1o3XsT3qf2V0wfubk80Rp7X0QUbRTgqxF3ZekdlcEXxtzNuPx?=
 =?us-ascii?Q?ePAeaQrjtc3865rG6nAwfDcSYNQIVfeMJWD1gk/XAgYFUwZ6/uuQezUhJCX1?=
 =?us-ascii?Q?7ekP90637dZMgXqsrrgB2zrJ6SJ4TP1o2ZdrFALu35M7FOoy1gx6y67sGiga?=
 =?us-ascii?Q?QYaGujRFfGC+s9vAXJ3XiVjAoffbkoHcKXKA1VGqXfklC0k905J3jkMG9LHz?=
 =?us-ascii?Q?jjjZqjmwe3GVJprqGJCuheqh5gb0SEKYotMvtwktKHzUm7cw1oFTN55Ss7ie?=
 =?us-ascii?Q?E7JofSkKqPmNaTqXFG6dccphedaUAIZJLQxIU7mf2tAnpPhbOZy86g5jywoU?=
 =?us-ascii?Q?YcsP2TxawmtyARntlzq9fp6dqJN5tRSkuDJQP2aiEa+JpUe7W/xs+0mOahHP?=
 =?us-ascii?Q?jcgb/nJw3kpD1TiNOR14lmPi4u0LROUpM6v7IuxkGoiL3gGBJdGp2QM65EnM?=
 =?us-ascii?Q?U0AghqId6KcIgsHn+GlY/HccU3BgR9IjHapyw4pycnqlhAhQ7b0kzLyD9C8+?=
 =?us-ascii?Q?MbYbwxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jx+4Gojk92A6zhpdON3eReebLsk2xV+0j3ODNc7/K6hSTEe0Oode6wcC9Ct5?=
 =?us-ascii?Q?IJM+jk0U5HxYgQptcL4tvMXq2VJdBHsTBBCq74k318pJcWeRV2OHY2qNnAoq?=
 =?us-ascii?Q?qCzv+yVMbDpirU93eHTp1pU0mRf203kLcSyJj5p7g7qxNliWnpsL91Yw8Rzw?=
 =?us-ascii?Q?UZ54FALj2IkZGuUvYT+NwiLMLM2M2dulA+DRA7DBuA6N/C962J5TEJ/Z0qYa?=
 =?us-ascii?Q?S2ux5C63dv0eQLlfHQERG2Eejnuph9gtlLjENvQH8YvA0BmI8pb/CvXX8TCK?=
 =?us-ascii?Q?udhpy2EBxPZaz+HpH98lfyVNaZ89jPkp56y1fVtucTKmnA57n2rEO6BIOwU4?=
 =?us-ascii?Q?SDDMA0XV3i3aqfz/NtyQt8klLY9H8kCe/yqBJ3bMjar4g14rPBJBwFU+N+Po?=
 =?us-ascii?Q?YAWHOcIhwukLrf1cTlbBynZ7llBBmNhPm20CRfEwIURJXtxmYYU/ywHKxkGD?=
 =?us-ascii?Q?8h1JQsmw9yT3kjSaXewFrv6tblAjqOJgl7ZQc7s/vLYS7SvRzoOH5GOV5R+C?=
 =?us-ascii?Q?0sd1t2VSJYCPVBwmrbAle/M8DfUfLzRwkIwPi67AaCv+qZj0Ko8sN9Mgf9GG?=
 =?us-ascii?Q?jg/caiu16pVPChqhWYXWr30PsxQmaJHbQrrW4bt2i5k/cfe4M+9W0xPpff2L?=
 =?us-ascii?Q?yVFH14c3eUAqJ2foFgq0GI98WW6l7atEUKKOyoEeQC5EgSba102CpJj1EXY3?=
 =?us-ascii?Q?/T/XkjWEeR+18NivPmIQ/DKXUQNFDQx0BmcTpEUz7Af6vXvEAoCqni02haps?=
 =?us-ascii?Q?KjVaNR3jOQDWUqX6O7zQtp1meuMA3hPjLIa8QZIPVtyRlolldD7iAyB8/Dn8?=
 =?us-ascii?Q?98F+SveL5mkA9YeSlsaGgA/ZVa0Gx5uY/z3BS6qz5apMKowOvovyMzNEeZ50?=
 =?us-ascii?Q?uD/3pt8lux5QXKVTsDBxYQ4ZR1sDKJzU9REuwZGelQFuHXWKk4UqZ0wBpWdt?=
 =?us-ascii?Q?iYQMcB/qTRu0tNOrA4tyYg3ehLj46NtJS5JDny864PVWRO5KpjyniWowfcNo?=
 =?us-ascii?Q?1GiEauonUjW24fafUNzIuMLsJa+peYMIJYLYvzNorxV/KIRBYZ2VeXqTTVjV?=
 =?us-ascii?Q?LKFE8+OLGbQJSCOPUuRou+OLZVr7jlR8rrS4jNNZOPh0bRw7TIT9DxseU0K1?=
 =?us-ascii?Q?s9YKq2TgIiCTXM9s3NCiPKegpvmeFXPX6nN7ETFHpmVmq9p6LkFMQ9qxsOGF?=
 =?us-ascii?Q?tzbEbVHUoqkGI8H7lzom96TvNyaCsWopuFbM0UKtsk+yr20/SPDjR5XdXOnM?=
 =?us-ascii?Q?4iL4GY9LeJHu9kYU4xiWEqSpxMQSfVzQE6Mvq/BoFUyaOke67N91BP/4eiID?=
 =?us-ascii?Q?BUoIsHuPv8ZP4curmfwv1WMF9gJiEsvi5DUPDm2Mo8fsV3xeC8NaTDtrl90W?=
 =?us-ascii?Q?4jHfMAHrIsSLl1WIEne37PzClWmCbx7XFxBYaEkq6oBM1f6r4V7qeExawzVk?=
 =?us-ascii?Q?B8I40uDY4EdNzlZmEvU1/JeqzxJq8UrJcByOqGz+Spd9d3V7T13T54RsWEKA?=
 =?us-ascii?Q?1dkUaX2mGaHV5cAHqn4CbYjOuCSRaSE5/UPqgNAUQ/otAhfvwRSog2f9pyq1?=
 =?us-ascii?Q?3RGxblF+qpY0jNYrxM97VlZJ6UfqCfNkMI15PTvP?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d09a30-3234-41f5-7cf6-08dc98d7541a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 07:36:17.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jF8n5V4dffTT/YRbrj1Di4S2L9Mrhd8/0pPNYB7ARnwOodM0otkWI+PwuLcSgsQFlS8bSdLxdthMZ/7+e8T9Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7234

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock 
for Wi-Fi module and extend the hardware IDs table in the brcmfmac 
driver for it to attach.

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
  wifi: brcmfmac: Add support for AP6275P

 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml  |  9 +++++++++
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts    | 15 +++++++++++++++
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c   | 15 ++++++++++++++-
 .../broadcom/brcm80211/include/brcm_hw_ids.h      |  2 ++
 4 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.34.1


