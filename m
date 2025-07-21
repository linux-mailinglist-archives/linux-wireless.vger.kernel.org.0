Return-Path: <linux-wireless+bounces-25717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F122B0BC8A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E13A189B306
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49827D77A;
	Mon, 21 Jul 2025 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RlSWwFsx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E327BF99;
	Mon, 21 Jul 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079476; cv=fail; b=pJfn7L8am0HA3H1AJ7lBiOTpu/46ssilPXWhhc5oFQvEdmUKeS4oKIatHsy1pFZpg5f140VZBMIbmdauGX0E9s1HULnTkAbBTjGUu6TW3R8t1Yc4rjFbYWR6Fe/c0IexgM44TI2Pd7B0RLcXlKXi9NHOQHHdMy4EIS4ce5bB6b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079476; c=relaxed/simple;
	bh=zJbdhZ8lWW3MyIqQgLkaWn7JnpDmJk3LxllFFQ9nhP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ezBs6k01cRyh+wq13Z34x9qPrd8qSFTBzoSnh/fgP93yerFC2kIshh4zcGlrMK75s/YDuTSE3f/UWEUbQu7W21jEPGS/2Du8UNR5qXMWh2EE2hozvWpbXwsHPdZr9hjDSzKwI4y+As7C3lD9lPDeI8VBKsIOM5KjLLnkLz8SFAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RlSWwFsx; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKEFyIM/e+7/sVa57aKwowOGVKJO7PlhCZMZ7ZyLk0pS/Tuksnt+ZKrFdgZ6ZJkVZ1kOQA++W5FGtxWk8TmPrCDNok6pgktaIVGn34u7M4S06lFCidXLk9fXxkXoqllYBlYQdLX/wkCd0qLXKkSECYhACL1YOAQLgzv8C/ESEjZXPkX2j65tga6s47qBf4vmAERQ9Z4yaWeNdv3GP+S5A73ujTe/2Z1qAi1Zwvfgpp7QmOeytHhls2EnBtwlZ8RZ8uhxH51qEZVS6qRue5junGbIsrGr9qHVWc0+O6vTCF4Zfl1ScxBLl0CuS2CnocjIGv5yquiny2t+Zykt1eThhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAyh8Al+/n/SdwLSfE8tT65+ZJ340kZ5x5eczZ15x+k=;
 b=sYYKsnarWLWZOjQWFg6GRRtrSoBufMsxUr07WPz9+lefmJKCUg9b/3xlweFekqbgl/WHJG6u3JV4zKR1C0OgDEleBNTZfUy3a9LxsHi49Br5pDoCXhExFM+/tYPgZUMQgbO4GHgpX2AbzhCdYWmhcQ4XAPsQwz7eG5N2x2VHuU1ag+bmEr0iHBKM0YKqGsRKpSjPs6c57gjSwG9ZOievRIGVIZvcbdW6yU4I3w2vovUqGYGH6nqBi1MJ4h9rO3o2WJpaFeX97ztGLHWfrDlB7cibi+H60LGskCKB1hBUJ3yklHE9+7h+R8rPW9BBPNVXBk9D4LrerfZMYiswXnA78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAyh8Al+/n/SdwLSfE8tT65+ZJ340kZ5x5eczZ15x+k=;
 b=RlSWwFsx1l6cs9+0OKNPwulcWT0bZ9XZ34d8wIbIl89zZsL5vQD3Q8oKM1pYsgVQF5HviV3TZVQjclQHA2yRN8ma/wHDZ6eC/Hq8Va88qigtVGOWn5Q+zWr9sIT+1gge0xww0XQf+vQF2Ojh2z5LwuvzWHzhs0oLODEiWAw2RqhQvQ9WpBTnYaFZzgU3n0cvOtCi+8iurvapuO8GP8EZgRO+wTJLIG2ZB/x0LIfYtvgO3kR9MdvpnfmJ6JkQk0RS1m5QEQ7ko47UqxtiHuHZrjjC3toc5e3/NvLB/nprjG17tYpNQINdufP+8LvxthBAWAhD3fxjNdJjtofIeP36ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by DU2PR04MB8967.eurprd04.prod.outlook.com (2603:10a6:10:2e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:31:10 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:31:10 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org,
	johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	francesco@dolcini.it,
	s.hauer@pengutronix.de,
	tsung-hsien.hsieh@nxp.com,
	jeff.chen_1@nxp.com,
	brian.hsu@nxp.com
Subject: [PATCH v4 03/22] wifi: nxpwifi: add 802.11ax files
Date: Mon, 21 Jul 2025 14:26:22 +0800
Message-Id: <20250721062641.2001796-4-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
References: <20250721062641.2001796-1-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|DU2PR04MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: b605aa80-3e64-4ae9-f300-08ddc8202e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uz0LHmbQ/YQIdUNsposzKaAW+eidl+uBhhg5sMTIlFiF59KEFTUiIMt95Aqm?=
 =?us-ascii?Q?eRZ9QsVXA2s7pfxW1hmVsjgGBMFNfTWtK5Wx+ODDZ5QJeEhlbvpiIBEmVrKX?=
 =?us-ascii?Q?gt845d/hCLyRUrr1RMjdxr+muoj0cWtgZbhh2DQH+enjzulLyQuZ2w3LbIcT?=
 =?us-ascii?Q?m9oOr1lVi7ro2J8bqZt2mpU45TNJkfS1QtaJdZU4apHWycMTKXRG7C4XEFFD?=
 =?us-ascii?Q?lzN0CusFd+R79HnltYJ3U8Ka00m6BMea17xmwqCa0OhOs5jfLBFkSZxoePdS?=
 =?us-ascii?Q?66DQoic2q7SbEqs7KzbTapflBFsnx+UPDnWPfOY8kkANmLdFq3n/eIRru0jH?=
 =?us-ascii?Q?59Q13vIUs4GpRq/GIR9nN05if9I1JZsYd2Hz+tUwOfGQj1l1rP1h7+hN+kaz?=
 =?us-ascii?Q?j7asmKn5N0aFl/FHJiyMEUEVV1J43TBzQdOSAlovdRRRlSoFD4wva5v18c0O?=
 =?us-ascii?Q?ahzOs52MN2jJATc/U8ok+EOiP2B0i5p6dgNPJGsyK1GQ3QSkIyBBhhVfz5RM?=
 =?us-ascii?Q?m3ZbnGQdA09fj5O58KLgLZLTHh51XyGHM4WfvqF+1uaCISCU70rNH0oNyn0c?=
 =?us-ascii?Q?iGpoC0/7KPppOHgz6dWsbl6KZIspBKb1rEk9KotaZBhcNnqOuZu628ksCk6/?=
 =?us-ascii?Q?EJUXdVsQ91Ld1hurIvT8dGGxOXxR/BcdV4EFyovwBvk6ZtIbI2gAD8YdBHP4?=
 =?us-ascii?Q?IhYLjAXU67/6xm7y12IGs+QPO9cLQcOUnqnKwAeVaFrrtdlYoZtBRaG/VNtG?=
 =?us-ascii?Q?snwkyDqiVYdCExaaG3W8KjUHSSDJjuT1ef/n46fE7GwNh1hbkmH0IaIIsKXX?=
 =?us-ascii?Q?+GOKXFdBe5hhxBv0pL4sYqYV4iWNejKO7t/kKOCKS6PsV6VPE3X24GG2WzWY?=
 =?us-ascii?Q?yJEbyQ6MiVX0snzd0TYzfgEPJeBZ+5HqA7ECdPVLEZ0ok90owCg89YhozU+1?=
 =?us-ascii?Q?+3AtLJgauJN1lFIimey1gW+jain3JHTBxrvacA0nXq2dw+C0tNN6xLdVTiE9?=
 =?us-ascii?Q?oSJLn5sQs8GLJw+8siajQrtpxRkAqYeIFIFwtBDTnBFn9uWmyFpHFC7F21rL?=
 =?us-ascii?Q?scKOFjpQ/m8PhHGgN0vn4vC7VJEGzCp6+e74ReW6j6DifEJ8cA3ddPB1tO+u?=
 =?us-ascii?Q?gW6tVLkRqxJ1HoVc+smjPvI1hZM9hEiguUMfHbDAa33RLxbGLxwDeUzwgNHR?=
 =?us-ascii?Q?r7gMydszFgpQuN40msgpvDjdDmYm8S0n389LACYBzmUXMpMm4Gb4sbSKlSaj?=
 =?us-ascii?Q?+/SnjD+PgolXZumayIVqLht3V6oobi8sCZPnPRFFgCnqK/m/3k6rpQx1VqZj?=
 =?us-ascii?Q?pxlNBnabv9IIUjm18h3bIOskUMKrgo9rbTgjnIa3rKoitz3YKQ2D6+LSwXru?=
 =?us-ascii?Q?sHPYlq5ST9aLn185x6UkXGdcXAPojaH+mahWqU9rcq5ZdojAk16KUpuF2Wyc?=
 =?us-ascii?Q?OUuDIgC8RREnVVBNtBi2AJpcpY1DoQDqyx5pRFczc7Sx9QJSjfpZhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xAmnYz6H2Ty8vzZFmSn88OVfx92Vc7/hp31QRZDgT/FFMNMZtGaqwtuQeGsk?=
 =?us-ascii?Q?Po3zQVeZ9xCKs0JLc6tErxc+QEwnDeYkcFQ8zTVYDNF9Z+A0ZQjiu4Zauu+T?=
 =?us-ascii?Q?kpz1YrO9DYe6gEdxjfMDWnL+B5+PmKOVpoLyZqAd5WZdqByTeGwhH3ianROJ?=
 =?us-ascii?Q?x06ZZjoDD+J3n6aFHzHKxYfMZLZz6r+sZ4c+UULZ1UbqP2mmwiNbfHKA2yqx?=
 =?us-ascii?Q?/TGNUjb9gzRuZ55/9GTtP/09jemMBs9DO3abUvF6x1cg7Bc57taXYKuPZfg1?=
 =?us-ascii?Q?n2ciamUeXpyIIEsiqqBYCYhKeG0DoWbJJ6JW5uB4OyFgTZnofwyZxoRTOsdk?=
 =?us-ascii?Q?8s32nOhi+Yw2VB2a+LXjPpKXDcNsr7pgh2W3K7VEr51ixp1GRc+BrCitCloJ?=
 =?us-ascii?Q?X8VLUgjFDNR8rox13dBS9djfH2EKVX1qR6KsjNw0D/KxDzpxHk0Lqc6UJS1k?=
 =?us-ascii?Q?Gkhi8P/Sr2VuthGhUPAJ/4Dudv++/0IrdT3TabyLyo2N1UTpvUX7jpdsrzBT?=
 =?us-ascii?Q?3pR33Cdg1ctfTdH8ct4257rfWg2WxaZ2osEGS8SgKoKDpMfUjPTe5u67nznx?=
 =?us-ascii?Q?Mzv3Ktzhq759js+sH6mHuUIgIxs0U6sweL/s8MIWovEz5FPzvWI6kqQFt0QI?=
 =?us-ascii?Q?YYtgbV5VPG1XxFLRdP0hu65KgJqR9h/J2SEqb+H8vsErG6uAsaL90L8vh8vb?=
 =?us-ascii?Q?ijaEy7gUXcF9ZTAiM7wQlGbjOeAUmQo924j8UHxLRh/3cQUlrQvf46UZG/Ie?=
 =?us-ascii?Q?tJO7rDR5RjU3sNHUW0bl1+TtUuV8RH7u+zZiLzH3XEf2xnV+9DHKLVCeMh9h?=
 =?us-ascii?Q?htMF5i8n0BlKVeMs6SL3TaJj5Uxm+b968orZV24KtHgbXIqCkjRdCtFSyjJj?=
 =?us-ascii?Q?7aB45hbTW+/bEnVS6MhgsK5nHgDw9lCwsGSAvEGJ6eCzs7w+MA846pOL40Xk?=
 =?us-ascii?Q?qLi+k7BN2SJJEJYRulZaU30yGkmDA4ueF1Q9P5Uxf6EjnuG8PqjHTKalYiOh?=
 =?us-ascii?Q?JfUiTzjqWJoTdLpnuQXeiBYFNgcakRymlitxL1lUm/kt0nYHc0LYq5KFw3hl?=
 =?us-ascii?Q?N3iJ2witt+vK/MKc469ZAlxFzcl9lCGaoskouH7STJ/o3wiVc4jGEleEibJG?=
 =?us-ascii?Q?wzxoOo8SMnzgRMW5CDqDwwZEIq6Ot3PyMtI88j/mmyBSuEz6GPLyTZzRhuc+?=
 =?us-ascii?Q?FojeIUkbqkVJBg7J4prE8i4CP3ljCGNm9jelql/ffE2/8c/gaeMB8SCzWWTD?=
 =?us-ascii?Q?8x+j0/9BpBmjhI02OxgXS4ZxxfT86rUEhjk71mPKHcTlAZcjHRXiwCMMaXHf?=
 =?us-ascii?Q?UdDNfwH7pJ4+vpypuJV+GXCwqSfXXIezoadmNVR5ZGzCSuaemVgxuILbdiht?=
 =?us-ascii?Q?Pqs0z9P6DJz5v6x2KeJQj6xBOchEHdt6p/ii+0iZJHSRD4B2rMvmRsaNe7iM?=
 =?us-ascii?Q?gNCfILkmdklhIxUjiVMKtAz/Tiz3o8W8mavDNJ002DuOtpAn9heWdI6+Rn3N?=
 =?us-ascii?Q?EieUYVNn8fI35Z0od/Kg5S+ScJa1DL08RxqPF9vkTdDOqpkpY0MZeq291hzY?=
 =?us-ascii?Q?sfYQwPGAKJ6iAyoGw4MPvNdFFZKU25+nb+YCIqbj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b605aa80-3e64-4ae9-f300-08ddc8202e9a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:31:10.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBIO20FwUdnKtOAx5L7C8cPk+9LLRqngsb7gKWMmLiOcV9ZaJXcoaKzd0XhDIrtzJfV1q8dPVgEr4BOcJuZ7dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8967

For client mode, NXP firmware will help association process via
host command HOST_CMD_802_11_ASSOCIATE. IEs for 802.11ax should be
converted from parameters passed from cfg80211 to TLVs appended
to host command HOST_CMD_802_11_ASSOCIATE.

For AP mode, IEs for 802.11ax should be converted from parameters
passed from cfg80211 to host command HOST_CMD_11AX_CFG.

Files in this commit will support 802.11ax features based on above
descriptions.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 drivers/net/wireless/nxp/nxpwifi/11ax.c | 590 ++++++++++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/11ax.h |  72 +++
 2 files changed, 662 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
new file mode 100644
index 000000000000..3862dbc5b56c
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NXP Wireless LAN device driver: 802.11ax
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#include "cfg.h"
+#include "fw.h"
+#include "main.h"
+#include "11ax.h"
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap)
+{
+	struct nxpwifi_private *priv;
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	struct nxpwifi_ie_types_he_cap *user_he_cap = NULL;
+	u8 header_len = sizeof(struct nxpwifi_ie_types_header);
+	u16 data_len = le16_to_cpu(hw_he_cap->header.len);
+	bool he_cap_2g = false;
+	int i;
+
+	if ((data_len + header_len) > sizeof(adapter->hw_he_cap)) {
+		nxpwifi_dbg(adapter, ERROR,
+			    "hw_he_cap too big, len=%d\n",
+			    data_len);
+		return;
+	}
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)hw_he_cap;
+
+	if (he_cap->he_phy_cap[0] &
+	    (AX_2G_40MHZ_SUPPORT | AX_2G_20MHZ_SUPPORT)) {
+		adapter->hw_2g_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_2g_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_2g_he_cap_len);
+		adapter->fw_bands |= BAND_GAX;
+		he_cap_2g = true;
+		nxpwifi_dbg_dump(adapter, CMD_D, "2.4G HE capability IE ",
+				 adapter->hw_2g_he_cap,
+				 adapter->hw_2g_he_cap_len);
+	} else {
+		adapter->hw_he_cap_len = data_len + header_len;
+		memcpy(adapter->hw_he_cap, (u8 *)hw_he_cap,
+		       adapter->hw_he_cap_len);
+		adapter->fw_bands |= BAND_AAX;
+		nxpwifi_dbg_dump(adapter, CMD_D, "5G HE capability IE ",
+				 adapter->hw_he_cap,
+				 adapter->hw_he_cap_len);
+	}
+
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		if (he_cap_2g) {
+			priv->user_2g_he_cap_len = adapter->hw_2g_he_cap_len;
+			memcpy(priv->user_2g_he_cap, adapter->hw_2g_he_cap,
+			       sizeof(adapter->hw_2g_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_2g_he_cap;
+		} else {
+			priv->user_he_cap_len = adapter->hw_he_cap_len;
+			memcpy(priv->user_he_cap, adapter->hw_he_cap,
+			       sizeof(adapter->hw_he_cap));
+			user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+				priv->user_he_cap;
+		}
+
+		if (GET_BSS_ROLE(priv) == NXPWIFI_BSS_ROLE_STA)
+			user_he_cap->he_mac_cap[0] &=
+				HE_MAC_CAP_TWT_RESP_SUPPORT;
+		else
+			user_he_cap->he_mac_cap[0] &=
+				HE_MAC_CAP_TWT_REQ_SUPPORT;
+	}
+
+	adapter->is_hw_11ax_capable = true;
+}
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc)
+{
+	u16 bss_band = bss_desc->bss_band;
+
+	if (bss_desc->disable_11n)
+		return false;
+
+	if (bss_band & BAND_G)
+		return (priv->config_bands & BAND_GAX);
+	else if (bss_band & BAND_A)
+		return (priv->config_bands & BAND_AAX);
+
+	return false;
+}
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct nxpwifi_ie_types_he_cap *he_cap = NULL;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap = NULL;
+	int ret_len;
+	u16 rx_nss, tx_nss;
+	u8 nss;
+	u16 cfg_value;
+	u16 hw_value;
+
+	if (!bss_desc->bcn_he_cap)
+		return -EOPNOTSUPP;
+
+	he_cap = (struct nxpwifi_ie_types_he_cap *)*buffer;
+	if (bss_desc->bss_band & BAND_A) {
+		memcpy(*buffer, priv->user_he_cap, priv->user_he_cap_len);
+		*buffer += priv->user_he_cap_len;
+		ret_len = priv->user_he_cap_len;
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			adapter->hw_he_cap;
+	} else {
+		memcpy(*buffer, priv->user_2g_he_cap, priv->user_2g_he_cap_len);
+		*buffer += priv->user_2g_he_cap_len;
+		ret_len = priv->user_2g_he_cap_len;
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			adapter->hw_2g_he_cap;
+	}
+
+	if (bss_desc->bss_band & BAND_A) {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream >> 8);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream >> 8) & 0x0f;
+	} else {
+		rx_nss = GET_RXMCSSUPP(adapter->user_htstream);
+		tx_nss = GET_TXMCSSUPP(adapter->user_htstream) & 0x0f;
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->rx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->rx_mcs_80, nss);
+		if (rx_nss != 0 && nss > rx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT ||
+		    cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->rx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	for (nss = 1; nss <= 8; nss++) {
+		cfg_value = nxpwifi_get_he_nss_mcs(he_cap->tx_mcs_80, nss);
+		hw_value = nxpwifi_get_he_nss_mcs(hw_he_cap->tx_mcs_80, nss);
+		if (tx_nss != 0 && nss > tx_nss)
+			cfg_value = NO_NSS_SUPPORT;
+		if (hw_value == NO_NSS_SUPPORT ||
+		    cfg_value == NO_NSS_SUPPORT)
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       NO_NSS_SUPPORT);
+		else
+			nxpwifi_set_he_nss_mcs(&he_cap->tx_mcs_80, nss,
+					       min(cfg_value, hw_value));
+	}
+
+	return ret_len;
+}
+
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &cmd->params.ax_cfg;
+	u16 cmd_size;
+	struct nxpwifi_ie_types_header *header;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CFG);
+	cmd_size = sizeof(struct host_cmd_11ax_cfg) + S_DS_GEN;
+
+	he_cfg->action = cpu_to_le16(cmd_action);
+	he_cfg->band_config = ax_cfg->band;
+
+	if (ax_cfg->he_cap_cfg.len &&
+	    ax_cfg->he_cap_cfg.ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+		header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+		header->type = cpu_to_le16(ax_cfg->he_cap_cfg.id);
+		header->len = cpu_to_le16(ax_cfg->he_cap_cfg.len);
+		memcpy(he_cfg->tlv + sizeof(*header),
+		       &ax_cfg->he_cap_cfg.ext_id,
+		       ax_cfg->he_cap_cfg.len);
+		cmd_size += (sizeof(*header) + ax_cfg->he_cap_cfg.len);
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg)
+{
+	struct host_cmd_11ax_cfg *he_cfg = &resp->params.ax_cfg;
+	struct nxpwifi_ie_types_header *header;
+	u16 left_len, tlv_type, tlv_len;
+	u8 ext_id;
+	struct nxpwifi_11ax_he_cap_cfg *he_cap = &ax_cfg->he_cap_cfg;
+
+	left_len = resp->size - sizeof(*he_cfg) - S_DS_GEN;
+	header = (struct nxpwifi_ie_types_header *)he_cfg->tlv;
+
+	while (left_len > sizeof(*header)) {
+		tlv_type = le16_to_cpu(header->type);
+		tlv_len = le16_to_cpu(header->len);
+
+		if (tlv_type == TLV_TYPE_EXTENSION_ID) {
+			ext_id = *((u8 *)header + sizeof(*header) + 1);
+			if (ext_id == WLAN_EID_EXT_HE_CAPABILITY) {
+				he_cap->id = tlv_type;
+				he_cap->len = tlv_len;
+				memcpy((u8 *)&he_cap->ext_id,
+				       (u8 *)header + sizeof(*header) + 1,
+				       tlv_len);
+				if (he_cfg->band_config & BIT(1)) {
+					memcpy(priv->user_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_he_cap_len =
+						sizeof(*header) + tlv_len;
+				} else {
+					memcpy(priv->user_2g_he_cap,
+					       (u8 *)header,
+					       sizeof(*header) + tlv_len);
+					priv->user_2g_he_cap_len =
+						sizeof(*header) + tlv_len;
+				}
+			}
+		}
+
+		left_len -= (sizeof(*header) + tlv_len);
+		header = (struct nxpwifi_ie_types_header *)((u8 *)header +
+							    sizeof(*header) +
+							    tlv_len);
+	}
+
+	return 0;
+}
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &cmd->params.ax_cmd;
+	u16 cmd_size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_11AX_CMD);
+	cmd_size = sizeof(struct host_cmd_11ax_cmd) + S_DS_GEN;
+
+	he_cmd->action = cpu_to_le16(cmd_action);
+	he_cmd->sub_id = cpu_to_le16(ax_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		struct nxpwifi_11ax_sr_cmd *sr_cmd =
+			(struct nxpwifi_11ax_sr_cmd *)&ax_cmd->param;
+		struct nxpwifi_ie_types_data *tlv;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		tlv->header.type = cpu_to_le16(sr_cmd->type);
+		tlv->header.len = cpu_to_le16(sr_cmd->len);
+		memcpy(tlv->data, sr_cmd->param.obss_pd_offset.offset,
+		       sr_cmd->len);
+		cmd_size += (sizeof(tlv->header) + sr_cmd->len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		struct nxpwifi_11ax_beam_cmd *beam_cmd =
+			(struct nxpwifi_11ax_beam_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = beam_cmd->value;
+		cmd_size += sizeof(*beam_cmd);
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		struct nxpwifi_11ax_htc_cmd *htc_cmd =
+			(struct nxpwifi_11ax_htc_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = htc_cmd->value;
+		cmd_size += sizeof(*htc_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		struct nxpwifi_11ax_txomi_cmd *txmoi_cmd =
+			(struct nxpwifi_11ax_txomi_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txmoi_cmd->omi, sizeof(*txmoi_cmd));
+		cmd_size += sizeof(*txmoi_cmd);
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		struct nxpwifi_11ax_toltime_cmd *toltime_cmd =
+			(struct nxpwifi_11ax_toltime_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &toltime_cmd->tol_time,
+		       sizeof(toltime_cmd->tol_time));
+		cmd_size += sizeof(*toltime_cmd);
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		struct nxpwifi_11ax_txop_cmd *txop_cmd =
+			(struct nxpwifi_11ax_txop_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &txop_cmd->rts_thres,
+		       sizeof(txop_cmd->rts_thres));
+		cmd_size += sizeof(*txop_cmd);
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		struct nxpwifi_11ax_set_bsrp_cmd *set_bsrp_cmd =
+			(struct nxpwifi_11ax_set_bsrp_cmd *)&ax_cmd->param;
+
+		he_cmd->val[0] = set_bsrp_cmd->value;
+		cmd_size += sizeof(*set_bsrp_cmd);
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		struct nxpwifi_11ax_llde_cmd *llde_cmd =
+			(struct nxpwifi_11ax_llde_cmd *)&ax_cmd->param;
+
+		memcpy(he_cmd->val, &llde_cmd->llde, sizeof(*llde_cmd));
+		cmd_size += sizeof(*llde_cmd);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd_size);
+
+	return 0;
+}
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_11ax_cmd *he_cmd = &resp->params.ax_cmd;
+
+	ax_cmd->sub_id = le16_to_cpu(he_cmd->sub_id);
+
+	switch (ax_cmd->sub_command) {
+	case NXPWIFI_11AXCMD_SR_SUBID:
+		struct nxpwifi_ie_types_data *tlv;
+
+		tlv = (struct nxpwifi_ie_types_data *)he_cmd->val;
+		memcpy(ax_cmd->param.sr_cfg.param.obss_pd_offset.offset,
+		       tlv->data,
+		       ax_cmd->param.sr_cfg.len);
+		break;
+	case NXPWIFI_11AXCMD_BEAM_SUBID:
+		ax_cmd->param.beam_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_HTC_SUBID:
+		ax_cmd->param.htc_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_TXOMI_SUBID:
+		memcpy(&ax_cmd->param.txomi_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.txomi_cfg));
+		break;
+	case NXPWIFI_11AXCMD_OBSS_TOLTIME_SUBID:
+		memcpy(&ax_cmd->param.toltime_cfg.tol_time,
+		       he_cmd->val, sizeof(ax_cmd->param.toltime_cfg));
+		break;
+	case NXPWIFI_11AXCMD_TXOPRTS_SUBID:
+		memcpy(&ax_cmd->param.txop_cfg.rts_thres,
+		       he_cmd->val, sizeof(ax_cmd->param.txop_cfg));
+		break;
+	case NXPWIFI_11AXCMD_SET_BSRP_SUBID:
+		ax_cmd->param.setbsrp_cfg.value = *he_cmd->val;
+		break;
+	case NXPWIFI_11AXCMD_LLDE_SUBID:
+		memcpy(&ax_cmd->param.llde_cfg,
+		       he_cmd->val, sizeof(ax_cmd->param.llde_cfg));
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "%s: Unknown sub command: %d\n",
+			    __func__, ax_cmd->sub_command);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u8 nxpwifi_is_ap_11ax_twt_supported(struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_extcap *ext_cap;
+
+	if (!bss_desc->bcn_he_cap)
+		return false;
+	if (!(bss_desc->bcn_he_cap->mac_cap_info[0] & HE_MAC_CAP_TWT_RESP_SUPPORT))
+		return false;
+	if (!bss_desc->bcn_ext_cap)
+		return false;
+	ext_cap = (struct nxpwifi_ie_types_extcap *)bss_desc->bcn_ext_cap;
+	if (!(ext_cap->ext_capab[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
+		return false;
+	return true;
+}
+
+u8 nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				 struct nxpwifi_bssdescriptor *bss_desc)
+{
+	struct nxpwifi_ie_types_he_cap *user_he_cap;
+	struct nxpwifi_ie_types_he_cap *hw_he_cap;
+
+	if (bss_desc && (!nxpwifi_is_ap_11ax_twt_supported(bss_desc))) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "AP don't support twt feature\n");
+		return false;
+	}
+
+	if (bss_desc->bss_band & BAND_A) {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_he_cap;
+	} else {
+		hw_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->adapter->hw_2g_he_cap;
+		user_he_cap = (struct nxpwifi_ie_types_he_cap *)
+			priv->user_2g_he_cap;
+	}
+
+	if (!(hw_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "FW don't support TWT\n");
+		return false;
+	}
+
+	if (!(user_he_cap->he_mac_cap[0] & HE_MAC_CAP_TWT_REQ_SUPPORT)) {
+		nxpwifi_dbg(priv->adapter, MSG,
+			    "USER HE_MAC_CAP don't support TWT\n");
+		return false;
+	}
+
+	return true;
+}
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct nxpwifi_adapter *adapter = priv->adapter;
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &cmd->params.twt_cfg;
+	u16 cmd_size;
+
+	cmd->command = cpu_to_le16(HOST_CMD_TWT_CFG);
+	cmd_size = sizeof(struct host_cmd_twt_cfg) + S_DS_GEN;
+
+	twt_cfg_cmd->action = cpu_to_le16(cmd_action);
+	twt_cfg_cmd->sub_id = cpu_to_le16(twt_cfg->sub_id);
+
+	switch (twt_cfg->sub_id) {
+	case NXPWIFI_11AX_TWT_SETUP_SUBID:
+		struct nxpwifi_twt_setup *twt_setup;
+
+		twt_setup = (struct nxpwifi_twt_setup *)
+			twt_cfg_cmd->val;
+		memset(twt_setup, 0x00,
+		       sizeof(struct nxpwifi_twt_setup));
+		twt_setup->implicit =
+			twt_cfg->param.twt_setup.implicit;
+		twt_setup->announced =
+			twt_cfg->param.twt_setup.announced;
+		twt_setup->trigger_enabled =
+			twt_cfg->param.twt_setup.trigger_enabled;
+		twt_setup->twt_info_disabled =
+			twt_cfg->param.twt_setup.twt_info_disabled;
+		twt_setup->negotiation_type =
+			twt_cfg->param.twt_setup.negotiation_type;
+		twt_setup->twt_wakeup_duration =
+			twt_cfg->param.twt_setup.twt_wakeup_duration;
+		twt_setup->flow_identifier =
+			twt_cfg->param.twt_setup.flow_identifier;
+		twt_setup->hard_constraint =
+			twt_cfg->param.twt_setup.hard_constraint;
+		twt_setup->twt_exponent =
+			twt_cfg->param.twt_setup.twt_exponent;
+		twt_setup->twt_mantissa = cpu_to_le16(twt_cfg->param.twt_setup.twt_mantissa);
+		twt_setup->twt_request =
+			twt_cfg->param.twt_setup.twt_request;
+		twt_setup->bcn_miss_threshold =
+			cpu_to_le16(twt_cfg->param.twt_setup.bcn_miss_threshold);
+
+		cmd->size += sizeof(struct nxpwifi_twt_setup);
+		break;
+	case NXPWIFI_11AX_TWT_TEARDOWN_SUBID:
+		struct nxpwifi_twt_teardown *twt_teardown;
+
+		twt_teardown = (struct nxpwifi_twt_teardown *)
+			twt_cfg_cmd->val;
+		memset(twt_teardown, 0x00,
+		       sizeof(struct nxpwifi_twt_teardown));
+		twt_teardown->flow_identifier =
+			twt_cfg->param.twt_teardown.flow_identifier;
+		twt_teardown->negotiation_type =
+			twt_cfg->param.twt_teardown.negotiation_type;
+		twt_teardown->teardown_all_twt =
+			twt_cfg->param.twt_teardown.teardown_all_twt;
+		cmd->size += sizeof(struct nxpwifi_twt_teardown);
+		break;
+	case NXPWIFI_11AX_TWT_REPORT_SUBID:
+		struct nxpwifi_twt_report *twt_report;
+
+		twt_report = (struct nxpwifi_twt_report *)
+			twt_cfg_cmd->val;
+		memset(twt_report, 0x00, sizeof(struct nxpwifi_twt_report));
+		twt_report->type = twt_cfg->param.twt_report.type;
+		cmd->size += sizeof(struct nxpwifi_twt_report);
+		break;
+	case NXPWIFI_11AX_TWT_INFORMATION_SUBID:
+		struct nxpwifi_twt_information *twt_information;
+
+		twt_information = (struct nxpwifi_twt_information *)
+			twt_cfg_cmd->val;
+		memset(twt_information, 0x00,
+		       sizeof(struct nxpwifi_twt_information));
+		twt_information->flow_identifier =
+			twt_cfg->param.twt_information.flow_identifier;
+		twt_information->suspend_duration =
+			cpu_to_le32(twt_cfg->param.twt_information.suspend_duration);
+		cmd->size += sizeof(struct nxpwifi_twt_information);
+		break;
+	case NXPWIFI_11AX_BTWT_AP_CONFIG_SUBID:
+		u8 i;
+		struct nxpwifi_btwt_ap_config *btwt_ap_config;
+
+		btwt_ap_config = (struct nxpwifi_btwt_ap_config *)
+				 twt_cfg_cmd->val;
+		memset(btwt_ap_config, 0x00,
+		       sizeof(struct nxpwifi_btwt_ap_config));
+		btwt_ap_config->ap_bcast_bet_sta_wait =
+			twt_cfg->param.btwt_ap_config.ap_bcast_bet_sta_wait;
+		btwt_ap_config->ap_bcast_offset =
+			cpu_to_le16(twt_cfg->param.btwt_ap_config.ap_bcast_offset);
+		btwt_ap_config->bcast_twtli =
+			twt_cfg->param.btwt_ap_config.bcast_twtli;
+		btwt_ap_config->count =
+			twt_cfg->param.btwt_ap_config.count;
+		for (i = 0; i < BTWT_AGREEMENT_MAX; i++) {
+			btwt_ap_config->btwt_sets[i].btwt_id =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].btwt_id;
+			btwt_ap_config->btwt_sets[i].ap_bcast_mantissa =
+				cpu_to_le16
+				(twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_mantissa);
+			btwt_ap_config->btwt_sets[i].ap_bcast_exponent =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].ap_bcast_exponent;
+			btwt_ap_config->btwt_sets[i].nominalwake =
+				twt_cfg->param.btwt_ap_config.btwt_sets[i].nominalwake;
+		}
+
+		cmd->size += sizeof(struct nxpwifi_btwt_ap_config);
+		break;
+	default:
+		nxpwifi_dbg(adapter, ERROR,
+			    "Unknown sub id: %d\n", twt_cfg->sub_id);
+		return -EINVAL;
+	}
+
+	cmd->size = cpu_to_le16(cmd->size);
+
+	return 0;
+}
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg)
+{
+	struct host_cmd_twt_cfg *twt_cfg_cmd = &resp->params.twt_cfg;
+	u16 action;
+
+	action = le16_to_cpu(twt_cfg_cmd->action);
+	twt_cfg->sub_id = le16_to_cpu(twt_cfg_cmd->sub_id);
+
+	if (action == HOST_ACT_GEN_GET &&
+	    twt_cfg->sub_id == NXPWIFI_11AX_TWT_REPORT_SUBID) {
+		struct nxpwifi_twt_report *twt_report =
+			(struct nxpwifi_twt_report *)twt_cfg_cmd->val;
+
+		memcpy(&twt_cfg->param.twt_report, twt_report, sizeof(struct nxpwifi_twt_report));
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.h b/drivers/net/wireless/nxp/nxpwifi/11ax.h
new file mode 100644
index 000000000000..1b68831e3af9
--- /dev/null
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * NXP Wireless LAN device driver: 802.11ax
+ *
+ * Copyright 2011-2024 NXP
+ */
+
+#ifndef _NXPWIFI_11AX_H_
+#define _NXPWIFI_11AX_H_
+
+/* device support 2.4G 40MHZ*/
+#define AX_2G_40MHZ_SUPPORT BIT(1)
+/* device support 2.4G 242 tone RUs */
+#define AX_2G_20MHZ_SUPPORT BIT(5)
+
+/* 0 indicates support for HE-MCS 0-7 for n spatial streams
+ * 1 indicates support for HE-MCS 0-9 for n spatial streams
+ * 2 indicates support for HE-MCS 0-11 for n spatial streams
+ * 3 indicates that n spatial streams is not supported for HE PPDUs
+ */
+static inline u16
+nxpwifi_get_he_nss_mcs(__le16 mcs_map_set, int nss) {
+	return ((le16_to_cpu(mcs_map_set) >> (2 * (nss - 1))) & 0x3);
+}
+
+static inline void
+nxpwifi_set_he_nss_mcs(__le16 *mcs_map_set, int nss, int value) {
+	u16 temp;
+
+	temp = le16_to_cpu(*mcs_map_set);
+	temp |= ((value & 0x3) << (2 * (nss - 1)));
+	*mcs_map_set = cpu_to_le16(temp);
+}
+
+u8 nxpwifi_is_11ax_twt_supported(struct nxpwifi_private *priv,
+				 struct  nxpwifi_bssdescriptor *bss_desc);
+
+void nxpwifi_update_11ax_cap(struct nxpwifi_adapter *adapter,
+			     struct hw_spec_extension *hw_he_cap);
+
+bool nxpwifi_11ax_bandconfig_allowed(struct nxpwifi_private *priv,
+				     struct nxpwifi_bssdescriptor *bss_desc);
+
+int nxpwifi_cmd_append_11ax_tlv(struct nxpwifi_private *priv,
+				struct nxpwifi_bssdescriptor *bss_desc,
+				u8 **buffer);
+
+int nxpwifi_cmd_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_ret_11ax_cfg(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_he_cfg *ax_cfg);
+
+int nxpwifi_cmd_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *cmd, u16 cmd_action,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_ret_11ax_cmd(struct nxpwifi_private *priv,
+			 struct host_cmd_ds_command *resp,
+			 struct nxpwifi_11ax_cmd_cfg *ax_cmd);
+
+int nxpwifi_cmd_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *cmd, u16 cmd_action,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+int nxpwifi_ret_twt_cfg(struct nxpwifi_private *priv,
+			struct host_cmd_ds_command *resp,
+			struct nxpwifi_twt_cfg *twt_cfg);
+
+#endif /* _NXPWIFI_11AX_H_ */
-- 
2.34.1


