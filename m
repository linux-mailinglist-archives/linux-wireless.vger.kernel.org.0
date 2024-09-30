Return-Path: <linux-wireless+bounces-13307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC1C989ABD
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 08:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09181C20902
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 06:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C20518801A;
	Mon, 30 Sep 2024 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BNCl9gU9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585E9187339;
	Mon, 30 Sep 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678334; cv=fail; b=CAG+6u7gnfMClw1L1frL0PP/9Yl3rbcEQowbVPhGcGV64tqwVTT167oDVI887zRapyd6ztFnpFrqVxAyumKRP36ggcYo9lZxnys5g0cPniylWLfroDATUnfGex1a9OpZfQbNN9KVcgfXVOrNvaNcgwXC2849kKwjSAbXor2uUgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678334; c=relaxed/simple;
	bh=xllh9g36ue1/224g8nKYO6OCUHsEhg9Z5CXDr5IINEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRF1CjuPzAkvP0dNCKCvkD24+5Owq+FnW0SZhiI8Kk3eJma4o+3QUo50agDnXZ9kxupGc/woRXuQvD9ZMFoNpJxc2GaWDEMMgAJkKBVFedpT9eozrP/iUvcFFkN9lYucphGdVHLUOOqKoD1Z6Yycuy80rdDmZ9rVF+wYP1WSkEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BNCl9gU9; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upCSEo2bXblFwFtKIDSNLRHNerrXWxw2/5Ab8RYuvOqe8xVG2PyJ/NxgxN62a1HwM1mXc/RbyN2HilHzDohxMK1g6JGqnD56twT4fh4oc1g8LntTIakiDuep1IFNlRwuW0DFzI1o3NSGabCn7N7tL4XbFRbBBVpNAsJS62WiqIufeKMTcQh1uwDKTUNrP3gJol0QE9bvoTRgOvy3VNwr9Th/AYIILO4SNFngQuW0oMO87ywccyK1vRPwZQwDGqwDykjBxUjpJyP/N/YTgmFvWLmxyMGDOcgrCuS//rVY5CzHOuOymONqwo7TmB8z/rjqVk7JV2khOnUPN/cDFLuaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C+fZ+kLlXQ3hs4tcRj/7DLpQ0te3mfxO8sC9JlFSvg=;
 b=MkK+DHV1SJ7XTZrAKtfzhFml4LcTT29iFmffDwoFsO3SitCT1zkam8NH5VxSphTWJvsjpR8/vGLJBxQykCTJtBUmrNGa2fH2bGF8+c2oQ8NdcWDOb7D9lzq6u9XxXxOwO2vC86QzpO3Pd0FjEvT9l0IJBvbtFwAYLxMhf5uwDGPb5dl+8Tku0wafmRYuZu2/GGZtcQqsmUUVUIlKsSYXQ8dG13OFjU7qlXv+QpfgHBXgtCZr6o71qkQGlqQXNXj/M3iFCO+d9NO4AuiFYFxZ8WIavkVAUrEf09tDUR8OttX4RBAuX0rjEE4V/I+TxVcoaztZ71HajBWXtb4r9e2dIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C+fZ+kLlXQ3hs4tcRj/7DLpQ0te3mfxO8sC9JlFSvg=;
 b=BNCl9gU96TiClRHe9ncNxHOFidW6KvrZEoYI3sNutfkx6Rw+Do83MlkfpDpon3I+BwiVFP+5rrrw1XwBheT8VMXV81vrvfnQcOvlGEq4g7/vEBVjtC+xY6qnRLLe4KfnetSqVD5Ez7/PTEM2p2y2zIFkL0kAYc0KBWO1w4Zx3PKkiSHT/fxq/ngBJbD0GH28nZ0fTvfmTwIb9OamfsyM/i+Qrrr2Z7LwoWu0bP3QsyaMThQ/FV9JAFBeDE5PAV9pqm9r8vQf7XexK/Pfg23AzNl5ifUX5A7Pxds5UFcut5A7H/VMSGajwkMWoiyZYlZZa/l4IejXlOWT6N0qJ7ZvKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 30 Sep
 2024 06:38:37 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:38:34 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v3 21/22] wifi: nxpwifi: add makefile and kconfig files
Date: Mon, 30 Sep 2024 14:37:00 +0800
Message-Id: <20240930063701.2566520-22-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d30ffe-24f6-40a1-452d-08dce11a8180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ie2K9nOrkkaB3P5hrgsmxeEmO5aW2VsVlrY9wGzq7wrWvn4c7x5kxlo8MFUF?=
 =?us-ascii?Q?50pXJWzDWj96hkFzs0V7CGIK+T/Z/K8K1LDJ67fpj962VjRtd3WXhp3aLc6h?=
 =?us-ascii?Q?y9d6nVpElnBD8a+uCM7BspSdq3OgtJ1JkKlmaQDp+CJMrD+1FcRGjqe8a2MB?=
 =?us-ascii?Q?Cahhp/iHW1EcHW9Fv/pwedbTe+nz+a9km03tcdDNnTomaCPC9SW0b/1/COs6?=
 =?us-ascii?Q?UREFIGVGhC2cJLAS6QUVMboDGVqS77KLC7UQdLYx9RSBj5xHazmUO+ZYpyaZ?=
 =?us-ascii?Q?Br6gV8nEEWnyDCMpCGwby6Mc1I5Pt1ADtKVzAibdZlTNg0RtvNrNSm0+e+ye?=
 =?us-ascii?Q?F/Z9YJ5jI1OeFhMDx2G96osttuKiPXtyIqlqqq5/YLKLboXO5TrkjP+fxV/f?=
 =?us-ascii?Q?2vg5UFHxGZ+xgjmpDVLCJg7oAyXjOsx3WTVA0lT/j5RK/rMLe1P0pcxmk4wn?=
 =?us-ascii?Q?e1rduXhAq1R4yYgxRzjJeqDbr0SrvyJ0p5iOxs4QrX6WzajJicwMEOfVwHpp?=
 =?us-ascii?Q?uwHsbPxpTACY3oC2nWfO9mlVi8sC/Th7kG4caiL+M2Ol29vOrxuNRuoWXCWS?=
 =?us-ascii?Q?y+/Z9N0lD/HZTOOxaAuGSHAzotdfbhf+9M1MdnWfZSR6EQCw7UfoYXXyPIAZ?=
 =?us-ascii?Q?HyHzQ18N31IhszsqLVAlToO7d/UYkKwMxIJMAPhkOHoXLGOxCrXwhNquUORN?=
 =?us-ascii?Q?awq+7JW6VfRIqYubSLRSXwPjZH9YuJPgMTF/2FdQdh5oFzc53K0FaebAfWaw?=
 =?us-ascii?Q?JaYpFDhfN8symKxD3mJC4fhPStA3uVkG5a3SmACw4wOhUXfDthwYaPL0W33V?=
 =?us-ascii?Q?FLrIKlnKO8gNDsG2J+VuvJ+Te7SvhjpXfKaI5fE3PsEfLRCUm9yCU6mqFu65?=
 =?us-ascii?Q?fmplmyNRXFEZ+yjuxcTBbRg97Tb+3VTfLigdUHcMoNnxskmrOn7G/vtpmo6T?=
 =?us-ascii?Q?P0dsJwn8GmcJR7qFlgyKktPGkgAHb3rXYnHVM8DP8iFsrkwam25mu4f1XJe2?=
 =?us-ascii?Q?tbWWgqTpoc5spK7MmpYnw6ydjdyoAixrRbQzvXOo5gFlrNvEXcSIK6BEXBZi?=
 =?us-ascii?Q?vroaw4/+QkIc74mZT1keElQxt1QDDieKswVux9djPQVpYb5KkOyIA2364MOz?=
 =?us-ascii?Q?Oe7oTCYu4QxBQQyLIEDzFi16xdfJjj3fnx+RsMcuUYO+op/QLCRxjtt5ZBs9?=
 =?us-ascii?Q?9oyPJxfBRUs5vBOl8gl/rLaSlOuZK551Cq5lcrl7VlchCQ5A8Q9RKEqCSaXm?=
 =?us-ascii?Q?xG1wn7pPBJPKKO2CmPK/VdGGNDjYnDbHUBvVclA7F4Ubn0Lk4gY57a0nWBfg?=
 =?us-ascii?Q?RbWJqoqog1jo2zFefBZUP3GPjADYyiBNQSMXXJIVSvzEFQSCmd9F9dcgFbOM?=
 =?us-ascii?Q?CbF71RbHjumPgzXyCkcLX4wGSVS9Gmy+eaAoeH7t6AMeVSCruQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MzAJWKYcT6lacLBR536N+9UI2P0LNUdVRM0pKAVAB6a4B7wb6TmNFUKYOKQG?=
 =?us-ascii?Q?15XDOUwX90LSxBC28Ah0ZHK5fRFrsfXcKKyYHK0Qn8VBVfpdKtEeUZRhndMx?=
 =?us-ascii?Q?2dZ4QAdCfJk/ls3iTDcaeSRE1PvFL1CZaayXxsFUDe9bSiFUaIvDIErzrxuN?=
 =?us-ascii?Q?xNayx7yzVYoRsXlxlN0M5nZgA97pY47999SSK01XTDgecnRZR138OZrsO68h?=
 =?us-ascii?Q?ey65nVq1cCgVtC5dEx0CPRVnnWq5Un6O8kr7teJPuAW72s4tUBU0hLKqW7He?=
 =?us-ascii?Q?1BZnZR/LLvwX314Iv74uqNeFt7I7tHDfSxbWWB45Ej1sXd9uqrf//grmfUMh?=
 =?us-ascii?Q?35ObUzP3ExUWbFIjENox6iZCi/mX+O+g4AsdK8YwQFB8D4BvOhCcmjFRl755?=
 =?us-ascii?Q?+NZy/Hkpgkg+tKxCN8d+ikOPgXHJ0vD2VQzSBA6pLjFJ5/s8fwrFx5E4E6u0?=
 =?us-ascii?Q?WuFBO+UOQWqAcATULqFNCH5YKe+PE5NzXyw88qoknR4RcdZe4toTfaMc+z6r?=
 =?us-ascii?Q?y6BuXkdm7kD/9sWuCPuJ1xsSTR7tbwvZ3eGUyu84QGy5kRhZva9jgKI5pnpy?=
 =?us-ascii?Q?EUcDEhawt//mrXUEYDlUfS822gwyihMAMjTJSXWZFE4xAJZBZZKSR0O1s9Rp?=
 =?us-ascii?Q?Q2vlvbhHe98dL8N+vGc765mjRBuY+qc4FJOPPumFswixhxxsikSRtEeSZUmy?=
 =?us-ascii?Q?BOCeMalve9IYFURHBVvkHfrLdVj8tqMWcJSg1FSzzhzQl5f4dgukz9QS96Kf?=
 =?us-ascii?Q?UYP4HWirUlO7Xl+JBxR9QKgIha++RRJoUGW4LztmcbO/XDUYWwNQNLeP+OUX?=
 =?us-ascii?Q?BPxE0c6JqKv++DkpeBHg4vBT043iyIyWwPA+nim5GLJShjcecQWnXjvfZpiw?=
 =?us-ascii?Q?xIYqM+eqjGO4/VD0DUzWe/LVXruXhxed9HQ/j6MivtCwItDvjsgGvxyukWec?=
 =?us-ascii?Q?ubsHxtcDVIHCYa72ya+rXOKPjy1DG0UDsrivD2funSG2waDkjVw9Cqm4Kzup?=
 =?us-ascii?Q?pnN6zz/IK29xafGkGXx8SVs2u0tLsa9QQ2FdY3YwcwUENMRVcavRFeQCg+KP?=
 =?us-ascii?Q?AqIrdXn7DgwVw5NBBiNpey6gDRlao6KDIIxB4ijXB0fU1lszDtNPJNbNI/1t?=
 =?us-ascii?Q?GG9VfLU9ja4LyRhqyS9X4mdp8wNCqhdFhjK0JrE1878coENYtSkFNObnoH2X?=
 =?us-ascii?Q?McZuEa862+R/fR+DttvOqEAm0lOjTqy2fiVP2NSw23AH1xh+4M0xlUET9/xs?=
 =?us-ascii?Q?Ah6uonAJYrsBBr/wnLW+mbX9EJ+hk6X/nRAiWSJEg64Q0NIqyC8kk4cPZoX0?=
 =?us-ascii?Q?8/PxZfEk5NoZWxx9GJmS+R3wkRcK7Lz5chahXu7ZbXPAkxF4Ny2sERZ4WfFX?=
 =?us-ascii?Q?TQgxpbVjFFoSaiovbPolvriApeOCU/fyhXziz1s9htZtH3AMw6TLtUUueGYp?=
 =?us-ascii?Q?p7HqaA7Fxxl0b3AgvN9w4ZPU3vYjmfMYkTeqNLu4bkroLv23vHlz2F+uOaFK?=
 =?us-ascii?Q?UO6yzZj9ghg0va6n1Hg8Oz2IXANcUtHJ0eZwyHhqCW4gHotwFU63e6axzUga?=
 =?us-ascii?Q?5SCcjOmBprhriDuT+RVBEQyiG9E035VQ8nFNboB8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d30ffe-24f6-40a1-452d-08dce11a8180
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:38:34.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvO9dvlYKtFZ1JO6Jv0FK3ji3YYTg+4jPmq8mbutyBBzfcj5WrW3y5JE8HMUFXhtNpbzymGRLpLbMmMoSqXuJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

Let nxpwifi can be configured and compiled under
kernel source tree.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/Kconfig              |  1 +
 drivers/net/wireless/Makefile             |  1 +
 drivers/net/wireless/nxp/Kconfig          | 17 ++++++++++
 drivers/net/wireless/nxp/Makefile         |  3 ++
 drivers/net/wireless/nxp/nxpwifi/Kconfig  | 22 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/Makefile | 39 +++++++++++++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..4d7b81182925 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
 source "drivers/net/wireless/mediatek/Kconfig"
 source "drivers/net/wireless/microchip/Kconfig"
+source "drivers/net/wireless/nxp/Kconfig"
 source "drivers/net/wireless/purelifi/Kconfig"
 source "drivers/net/wireless/ralink/Kconfig"
 source "drivers/net/wireless/realtek/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..0c6b3cc719db 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_WLAN_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_WLAN_VENDOR_NXP) += nxp/
 obj-$(CONFIG_WLAN_VENDOR_PURELIFI) += purelifi/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
 obj-$(CONFIG_WLAN_VENDOR_RALINK) += ralink/
diff --git a/drivers/net/wireless/nxp/Kconfig b/drivers/net/wireless/nxp/Kconfig
new file mode 100644
index 000000000000..68b32d4536e5
--- /dev/null
+++ b/drivers/net/wireless/nxp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config WLAN_VENDOR_NXP
+	bool "NXP devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_NXP
+
+source "drivers/net/wireless/nxp/nxpwifi/Kconfig"
+
+endif # WLAN_VENDOR_NXP
diff --git a/drivers/net/wireless/nxp/Makefile b/drivers/net/wireless/nxp/Makefile
new file mode 100644
index 000000000000..27b41a0afdd2
--- /dev/null
+++ b/drivers/net/wireless/nxp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_NXPWIFI)	+= nxpwifi/
diff --git a/drivers/net/wireless/nxp/nxpwifi/Kconfig b/drivers/net/wireless/nxp/nxpwifi/Kconfig
new file mode 100644
index 000000000000..3637068574b8
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NXPWIFI
+	tristate "NXP WiFi Driver"
+	depends on CFG80211
+	help
+	  This adds support for wireless adapters based on NXP
+	  802.11n/ac chipsets.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi.
+
+config NXPWIFI_SDIO
+	tristate "NXP WiFi Driver for IW61x"
+	depends on NXPWIFI && MMC
+	select FW_LOADER
+	select WANT_DEV_COREDUMP
+	help
+	  This adds support for wireless adapters based on NXP
+	  IW61x interface.
+
+	  If you choose to build it as a module, it will be called
+	  nxpwifi_sdio.
diff --git a/drivers/net/wireless/nxp/nxpwifi/Makefile b/drivers/net/wireless/nxp/nxpwifi/Makefile
new file mode 100644
index 000000000000..8f581429f28d
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/Makefile
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright 2011-2020 NXP
+#
+
+
+nxpwifi-y += main.o
+nxpwifi-y += init.o
+nxpwifi-y += cfp.o
+nxpwifi-y += cmdevt.o
+nxpwifi-y += util.o
+nxpwifi-y += txrx.o
+nxpwifi-y += wmm.o
+nxpwifi-y += 11n.o
+nxpwifi-y += 11ac.o
+nxpwifi-y += 11ax.o
+nxpwifi-y += 11n_aggr.o
+nxpwifi-y += 11n_rxreorder.o
+nxpwifi-y += scan.o
+nxpwifi-y += join.o
+nxpwifi-y += sta_cfg.o
+nxpwifi-y += sta_cmd.o
+nxpwifi-y += uap_cmd.o
+nxpwifi-y += ie.o
+nxpwifi-y += sta_event.o
+nxpwifi-y += uap_event.o
+nxpwifi-y += sta_tx.o
+nxpwifi-y += sta_rx.o
+nxpwifi-y += uap_txrx.o
+nxpwifi-y += cfg80211.o
+nxpwifi-y += ethtool.o
+nxpwifi-y += 11h.o
+nxpwifi-$(CONFIG_DEBUG_FS) += debugfs.o
+obj-$(CONFIG_NXPWIFI) += nxpwifi.o
+
+nxpwifi_sdio-y += sdio.o
+obj-$(CONFIG_NXPWIFI_SDIO) += nxpwifi_sdio.o
+
+ccflags-y += -D__CHECK_ENDIAN
-- 
2.34.1


