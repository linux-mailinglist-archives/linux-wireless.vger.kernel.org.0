Return-Path: <linux-wireless+bounces-10647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C059405DA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AB71C211C1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 03:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5B7F484;
	Tue, 30 Jul 2024 03:31:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020135.outbound.protection.outlook.com [52.101.128.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896033D5;
	Tue, 30 Jul 2024 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310272; cv=fail; b=ozaWC/F0A9aEaVmP7i9OXmcgzI/F6+3eyHe2pQkR1VJuK/1IJDU6FjaVz0v/3ljCm16OgKqb9LzOFUxDxyJ8by51Cmf4RfaRiKLK9TwtGozJ1GLI5CTVIXmT/PFt7EesdZ37Dbo+Zd1dcstx805veCEwX/Ysj9f5ls/VqcHVewg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310272; c=relaxed/simple;
	bh=TH2Wei174Mye75El9jfqsnvnc68OyxRzTuc71xnFv9g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=puNqKVJG01HXYvnJDluTzywOyHTlhyqz1r3+FvrOy0icf2O8IfzmQ0zCp3y/gk7tMJUu7wcEsAQrDJcMjRtCV1xUzCYBWMfVGmGxBj9MyYRUOZrhpEs+7Y2rQU0HseYlXzIfy8NFgpZPARIJb/HUhf/ouXO+LmgnZT0Vj7OzZLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=52.101.128.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnBfmB1iiIGdm05wgP1OwX1SonZo8f5qx/nLAP4HfNMph7uD23lEbbdJVzYJbB/1d7k5IBPTbY1Ga3LQYUqIAXVpkj+pH2Vwh8jOBLrQNO0lYZnOSUmt9RhkcvL3TrHRP4/UhI0fhyjvcQ/LOTvUWEezTdZBQ9j7jVgW/i8puZuFLzyJ4KRLIbYMXHR2yaAVMwYNvL4sxPFX1/55Q2zPNa0ppcF9Z4h5XJmAUawvUiMzPRNeFs6pDCSlzVTuS7EzNAY1wdEEJ32cYFN0KHhPVOOWMuzt7JGzvBDgV0fW9BGeKZV11AzyzOC+Z0SX7u+Ru6HLrXDEfx9ovXE7WGllZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V4DN5Gmi43iofOZoWHCHiEA0sxKCJpIZ0khVH0f9xA=;
 b=N9SvNZS3g7JXaZZ4VFvc39XZ9dh7lHYNf5/vkaAFiPF7g+xgKU+4hRyQAJVDDvqjQqCGL7jIWbiR8Mzx993pBLVyJd4yrppYqGmqDV/yyJiNb0/X17j3swKlV5RlAR46+aGRsMqxIclISKRUYmnSbrFD4WrNGKvLaX76kzR6dJMq12qRHw0K6wRtMxDylb11ts4QFYSMevU2WWzt5QEzX9RKqTSbUARIbS/d8fL1j5Ks7dgb2YP1JPAuRKGG6aMtZGzhH8UxKftNDZgU4iEW8VDwzJ3vABLKNH+IHfmApBBDCsETsqgGl5rttfiF1EtHMq9qmDYtBCW3BD+M8QyEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB7705.apcprd03.prod.outlook.com (2603:1096:400:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 03:31:05 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Tue, 30 Jul 2024
 03:31:05 +0000
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
Subject: [PATCH v5 0/5] Add AP6275P wireless support
Date: Tue, 30 Jul 2024 11:30:48 +0800
Message-Id: <20240730033053.4092132-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: b08e1066-7c96-4669-8273-08dcb0480b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4Jh+tVysRiFJ8OrvOhvkk3tvH3/PmekKLtNj4K8OS7rA0ygWwaH0CUhOSBv?=
 =?us-ascii?Q?FeBrfXeB6xME09yIpNrTjgn1tqBGjD6+9tm4jC4r5xcGffC4gGIOMLo6B4jM?=
 =?us-ascii?Q?ndQMSwNr6wV73ujyUxZbarUCu2BBCzR8QKrWU4EINZk6Bqu6qLsEndmHm6ie?=
 =?us-ascii?Q?mX/gkD3N12jVVcNsClYqUsjKtsbwcWVdzc+BoISG6SLZjLP0BT/0BT5imWEV?=
 =?us-ascii?Q?DXex+VY9PTExjPblGavCjudnzCRuovVd/WiwiBn6xAVB5pljGmZqe7FVzsj7?=
 =?us-ascii?Q?3Tk0gdDGTYVfQzo9baqkYYcWHnaZRIAJa7TlCGUwLcj72cwanxBxF7fVVCzj?=
 =?us-ascii?Q?PloGirkHjSesu+W3m6czLTyjLxjujnYibdl2+8HPh4MvPNQ84UaACEIiGEAb?=
 =?us-ascii?Q?eBgIPThDOgdA0DyExUvS29JxDsPrHFI6dAh6dVo2q5HlpJ/krBluggRVS7Nb?=
 =?us-ascii?Q?qLhTvLIzvZQryx4kcGONFWaUo76Fe88IQ/TDsGive3cT2Oe6s3smE8vFSQ2Z?=
 =?us-ascii?Q?2U0ZNunrJ84NIzikADZe/dP5I7mMkiNCafJpfsnGsKCDkQrtdIoq34uaj1mw?=
 =?us-ascii?Q?tgk6lw07ZthoeLzv4w8LfypdfV7RJ7ZcQ1kWSFBeD+sZredd0FgKGE81xg3B?=
 =?us-ascii?Q?wH3fmcCdP//u39R/7ffktvCSJts0qrm+k/GT8FRKu7H9Ke0Px7ZKEjbZ8bVo?=
 =?us-ascii?Q?yjYs8M7nuuGzpZ0wJge1u8rbPWog3mwdL04xX/XyQvn+JjiTGTAW4slbOIqk?=
 =?us-ascii?Q?DBPpV07g14AEHeAYqcKshcM1aQ3w2vU1Us0vbYoBoCSVwQs6dJ1BWWHFzcx4?=
 =?us-ascii?Q?wu1DrZzac2bajZPDNMuq+/UofxRfMLzc7FkcPWDdGtNv8WRCJND7DKtnbvQ7?=
 =?us-ascii?Q?s6teax8dHHqADGitqAaYn/7z1KaWY5cOFk+OjoruAljVaz1n64KQroyG9YBj?=
 =?us-ascii?Q?32bi68CYGt4EF5OWmNF14t3ubICxOypyVwZv8t5zaz/msJiLvJmMt8SIMtgl?=
 =?us-ascii?Q?2Xbfu7osxhNFUPgaATHQZdbJBMMd21PVpSh5OrrsvtlOzckZDuiLOJEzMWIn?=
 =?us-ascii?Q?oefePMp2UzTGUfB82owoPv4mBC+fOTMHloy8WHoPwiCJ25tU9rwy2EVNwWzt?=
 =?us-ascii?Q?dIbWwvq3Mr8PP0Xai2NPpUQfAQ/O8CqCX+lZe53cSxZkvLpdCeGbMaPZenM/?=
 =?us-ascii?Q?DbnIRQLIRTP82ti5Rcv7zohIaIMxcwGoqO+LPYNxXi1kJGcKjAianr1A9xcX?=
 =?us-ascii?Q?DT1nOh5sNq+XWZIjOSSsNrvg0w0iJtMmQGb+lRzO/nsif/WVX+8/okfbSmXZ?=
 =?us-ascii?Q?n83Z6EytfnGca8GZi+yuX95CZjwLI+FYXzl8o2yBkKJkpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+xzJr+hLefhNpVdl9fa68znlCpFL8utCVCuRmg308a+wTlVBY2o6CZc9q0UR?=
 =?us-ascii?Q?Y+XN2IxQXJ6LfcVumAtXUrYmCUqG7f28HLZkiOF23NoIOtVT6h2W6aiTSpQN?=
 =?us-ascii?Q?zfKOa/eJ1bJQvNFNfzo22mpgDrufizCiYRu/RAMESciha+1fH1lasZsgkVNl?=
 =?us-ascii?Q?YqRgrd7OfLnmed8wJ9vHUkN4fet+k6EDQ78NDBABfLskM/K014HhedkBExG5?=
 =?us-ascii?Q?qHYeRtKA8Q9lQ4HMLVe6ZQQNXfytj4dj92bg15voGoTWaBi1KDdoWnDP/MNg?=
 =?us-ascii?Q?taFhxYUKvnmoDeFCJrmoK8seNGQVDsHAwbMhi+qYe+UiUklwfGtGnUHW8dcE?=
 =?us-ascii?Q?mgj9hr0mYU/lpcML+ADAhumON9Ud9h02IpvXruv/Zs3g48RnjqMs/9RNpX60?=
 =?us-ascii?Q?DtAlzX4pd6rWmbhNQoWvBFHvuJAoz1nb/CDKuRcL1Bwppq3IsXqWAg1vVzLv?=
 =?us-ascii?Q?2KR2Rk5sVz+Ij03gEd4SJmu0OW4P8NDeWhfbRzsnGwLHqk5AgIiUnI+ZiFy5?=
 =?us-ascii?Q?N/IAJhwszCVELHlX0Eb6L8mM5lRCkyhtIwXadTMQ98+jJTvAmOy0DB1Ffpx9?=
 =?us-ascii?Q?Y0P8sLp6DVWWo0aYucmQAk3qj7A9Nqol1lyHO9j+qEZ0XCwK5AHYRwwxGASE?=
 =?us-ascii?Q?XuRuJi2a0rvRS4dMh8jQyjdw2k2PePtBwi2D4pFBNhERpQlFV/wySlSNxPXD?=
 =?us-ascii?Q?/sw95Gz8258kSNLbbrnsrMnvLUjCDJkGcpd6aXuDx2bFzwm9wpnvkqiuPoNk?=
 =?us-ascii?Q?sZt5Lon5/5YelwDvnukGMXK9TrvMocsUORII4w62agZPmVjpxdbuz2Zr/a/x?=
 =?us-ascii?Q?evziHfDe7fR8VEmN/N8Tet0phDAig9sgbEEbVM7XnYNLRMpnUVwQyQSwMok3?=
 =?us-ascii?Q?JDWFBnmRxYEXZYFZfYIaDzoI7vEo7UeKOBNK7P8rFoRbUTyaop3wBaAEZKSw?=
 =?us-ascii?Q?+VkOy+BFQcuD2kxvHmEU/l0b+K2VV56X7088fqqznQ+82GV2SIQqWko9DRRn?=
 =?us-ascii?Q?lZKQLqSL8ubzn26zQICxzYy97YexR52IvW7IGhfwOoE1QRXrw6Vi7dRU6iAO?=
 =?us-ascii?Q?eF+3VC4Vhul0DVr/sbX5hn2PCKrtD59GyF80VUZkg2JzfG9qVXxQke03xl1y?=
 =?us-ascii?Q?I1LpkJhKGuUKOX4aIr3qcOD19t3ffNGq3zgivsSISoJQP5WzlXw/TQCPEeBP?=
 =?us-ascii?Q?5OQUL8CN1mbK3ESizOVw7aF5sVB9gMR2TabiKakF4OYL/rUlecuYLwV1GWkz?=
 =?us-ascii?Q?ddLAaORP/8qMYNOHPJfmqL12q3nH0N3c6BLVKPWatnA8oIJERW6RyCEvKS6y?=
 =?us-ascii?Q?/x+ZU5QV8VwjzSKjzyOanMEwWAJfpHtQ31AwMN6jcmnpQoJWQWa0X3aD5Zhd?=
 =?us-ascii?Q?h2ceMKf/5BUeCjCdlsT97qmaSwhN78RLkrLPHa32nRBwvBbzlHzaoi65vfu+?=
 =?us-ascii?Q?IQg6eqD+p545TbKdqtL57UrSt328XKgN9hI21qW+q5pRQsZ+b91n9w+PljOt?=
 =?us-ascii?Q?OVNcMWSnCIW6T8Ki1aS9VvyD3wHJxmXy1MVmjh1UcD0lBbx56XKtd4tfLTnD?=
 =?us-ascii?Q?aAWZUE2GEFB66FwWs8WS8jP/zSqFwevWZcPuSD2M?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08e1066-7c96-4669-8273-08dcb0480b24
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 03:31:05.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O7F+09R4q8lH0hNAW/3WJ9uNsWOesUHOopX6Rfzu8EweyxW7utWWoie7m1KD5v8C94W1bm3dIfwhdUNT8HoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7705

These add AP6275P wireless support on Khadas Edge2. Enable 32k clock
for Wi-Fi module and extend the hardware IDs table in the brcmfmac
driver for it to attach.

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
 .../wireless/broadcom/brcm80211/brcmfmac/of.c |  8 +++
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 52 ++++++++++++++++---
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 5 files changed, 79 insertions(+), 8 deletions(-)

-- 
2.34.1


