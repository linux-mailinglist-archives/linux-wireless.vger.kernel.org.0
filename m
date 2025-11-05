Return-Path: <linux-wireless+bounces-28578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D46C353C8
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4386217B0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998E3002B4;
	Wed,  5 Nov 2025 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vap6Hdi+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B680301709;
	Wed,  5 Nov 2025 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339741; cv=fail; b=cSF3/Lc9T9sKtB0P3MRebZsrKEcmY0VDBhi0+t/Ohu7Yo9jJ7qRk6qWQ/gluu0VGNUY413UXUGBsTmZSrUXjr+VAoyE/cM4XtFRf/3ft1snS3EcHdO7dvFFTOXHRYlpUEAhxhVMoiy0t5EMyx+/WrfHnD/GNMUt0I5nwz21OCK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339741; c=relaxed/simple;
	bh=yzlbCEzVvFtUsmIYCGn07dYZYrfGB1YfpJ1TlFQRbho=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SYsBt64nxbKUEjheKO2Iw/9ZS94QLjypKKB/WdH0dP8z3Z+dkgB1hx11xvF8osF3ElBI6UypYKXDIOVD4KvtlEcQpO233KwpsVfgRVEQMXcNSdU1EMKJu/YMpidCHK130viw2PiaXYc+buVGsIfGaYtIwgB9boTs/3s92IKgPng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vap6Hdi+; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ftch+AMj2YpinEKgHcCh9HgzFoG8Q9ewY0tc7ztLoBcDFk6c8bhRaHsTu1kmdVW0pSCjs4QE6jvTb+i+VpZ/FTUqEQkoTUsYatoL3lVETOq3L4vVNHpViK9lAyloMEi99qiXZAxXAEIvtI518HCZN83043KIXC9TFmp+aptXUshuVGD2EXH/1i61J+gNVWYI5oFjOt9nSGRpSt3QOaqeJZ8AnXPZVOQ4NZTdfghHDECpirwxEGYvHy5aBvmoiEoH0PuKlF7t7TIcasN2dLglT7H2i6/EJphR+2DLw2JfOchhlxCwo+VnomWA0bTMFKN9GPcOW2oJADvuXL1UtYNlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SNMjzzV2MSI938VJmunK+h7Fo9pSxZVYW+KTMnuAng=;
 b=DYcadzLPSsYTLGAc6eiOCdiqjnAfG6VcUq2STs86BIVJeb1SmLVET+33MT/Qe5OQj6GHfQLELZByzctg8Mr59kjNaElB53ZNt8cp/S7MBsXynbR1WZiqcx13xvu3iM+bBm/9HoVGng57JHgOSJo+VS7e4alwwzEyZVWGTFAZynLJfKCPSw0dXb0A1nOlhhehLlKjOQr4OwTUeJObVDaeTmI/ZjvCOYza3LQdoVrQ1PbrbI7TH5BmcbJInsGeUHtq02M/GpOa5GPBUega6YJ5CnHw0uXA2wpyRPELqBR8NyPSyjXX+wF511TzqVZf4UnvqyF7r5Pos11kwORR+GTc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SNMjzzV2MSI938VJmunK+h7Fo9pSxZVYW+KTMnuAng=;
 b=Vap6Hdi+eEeVQ7yfvHrv9xoPTTzZvn2ROvVDGLkL1qi3zEY60cBzp47MQctTR25o4Ieeu3ALR3FkPJlLFkVbPn8VTJNGucEDWoSj/7AjgvImxxExTMRz/Oi8On5PLAmnMr7rHwcz+oo5a/91ZtjhGwwWHBimoXZh9nnWMolThSwiAmZ2X1cnFUbgf3ukDHMgqnkrbdyutPDRaLWTx/WBwurP5KjoDVJjYGeov7qGjbO6hOdGlN2MBlIpT5wcrSIGYQQJtY9+m63JVr4UDBVrVaBoocvp3Mlbb4CHQSpfOLL/Sj6hlLdJYb2CGqJeNXR06Rg4MHmNyYLfUahlBZkung==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com (2603:10a6:10:1ee::23)
 by PA4PR04MB9293.eurprd04.prod.outlook.com (2603:10a6:102:2a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 10:48:54 +0000
Received: from DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7]) by DBBPR04MB7740.eurprd04.prod.outlook.com
 ([fe80::7a71:369b:fb82:59d7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 10:48:54 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v6 00/22] wifi: nxpwifi: create nxpwifi to support iw61x 
Date: Wed,  5 Nov 2025 18:47:22 +0800
Message-Id: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To DBBPR04MB7740.eurprd04.prod.outlook.com
 (2603:10a6:10:1ee::23)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7740:EE_|PA4PR04MB9293:EE_
X-MS-Office365-Filtering-Correlation-Id: f6681587-b7a6-4cda-9f65-08de1c58e9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YZ71aQ1XheMZczXoC6PJcS0G/TFId4f1SV4WgbKozI13ebGyyyEZ0oKGgVbC?=
 =?us-ascii?Q?FVryEfXIa7r8TFXYWmKU5+3BeKPhqePAdRO8XGJXzMxFQdEzw436Vno/VJdd?=
 =?us-ascii?Q?6FQ33dlo1dV2rAPkLXH86bY/7oXvXNPIlkJsAeosExxLyBJIqySrwE6cTWC7?=
 =?us-ascii?Q?8rb1i1wDyjJJIjJ2559sTeR2BUc7TUVb4Y1PIyFkf8GfI+t/dKUnFPqFBTeW?=
 =?us-ascii?Q?CAVsbTgOttoR5FYxC+6o5eT/XeLf5gO/v3hGV1BArb+e8JaEZ3tSqA31gJ7h?=
 =?us-ascii?Q?cZGQOlyme64zntm3egQfnWJeUWaA7KHoNfdLZe0L4xO9J/u+XgY6OJgJALvy?=
 =?us-ascii?Q?RbSHuPkOZ2/vEWEEp+9w82bLtgeOWlAD35MGSL/M8dyhTL8UtB+uiJ+K/Tcu?=
 =?us-ascii?Q?c2sSERz5moeJdlKla4yL384qSfte7RETklXls/3Qe3W0z5+ApR6LItpepOnH?=
 =?us-ascii?Q?xmU4BG8tu3xcAIOmJRQBsUtJ3M+CXakZ8P0ceQ8Gtcegyqa2xPsfB1+Emuyc?=
 =?us-ascii?Q?J35bhWQaJOQwh+hWGyA9ehsg9TTKHV+X4D8lzhOCXop0ICxM0FKaHv9LM25i?=
 =?us-ascii?Q?m7pIqLpLPfRnhwxhS7LpOxw5Nhzoz4HKT/bNFdzupdld7zVTP/TgzF2MTR8F?=
 =?us-ascii?Q?Dpqu/P3h5qELtXXdEgh0wecqQE2qzTdcVMi3HI+FpszWlaiZ5NDBiiFb99jK?=
 =?us-ascii?Q?TX41YLRS9jFYJqC51Ru7pxGBjyzVrC1cYpYWVqsbA+UqzaUv2vq7Ec3VXi7H?=
 =?us-ascii?Q?3uYNOcl5ZnGVcczi7kuCZ1OOZLpZI5KnAvXMC/W/ANtIaDW+pDQQgjzSz3lz?=
 =?us-ascii?Q?da1iYdbyl6nG2Zss6MfJR+vYIwXZjbmTM+xba/BsYnXe5F/ApNL0ZMCuXwxp?=
 =?us-ascii?Q?3qSrvUhaFW5NhDOHyGsVnIyhjjrpJ6MVfuXQy7l9NCHzLujbowIYmkVmIDwd?=
 =?us-ascii?Q?JqRXq1i2fO2fisWyn767kya6a3DMgVKTuBlp3WlKlYvcqWxVDME1jSFBs2RF?=
 =?us-ascii?Q?CZfZY35u5xBeZ0rU9lheirBJoDxXfr5Cg6wacOBjqYZeitGamPlIr8Gjsrzs?=
 =?us-ascii?Q?a5qlwAulU6CziWmqvY8NlRDGjzscpEWR1/nIeXOly1gDINQ1pmCQLIzmk7G8?=
 =?us-ascii?Q?rc3V340R8oVTKyxZx3UzV6Z6MZVXRMHo7gYyf9YO5YVjhgD0GuuFfoJXEBb4?=
 =?us-ascii?Q?j5qRREwWWVix5RE/baY6u7tFhgjBrMHXpRlV8AK3N9wdM8oqx95zIQ0EGdl7?=
 =?us-ascii?Q?RFVcLjH+Hm9LbYqTTMB2aIbXbcXyB1mQr68n0GIf/qmNcpmTD4+pATomdHdc?=
 =?us-ascii?Q?xVXAabOyTl6sYoU+1ekUyCCZHlaCq5Dpuppe4JLE7IxLo7NCEO6wixQMh3RZ?=
 =?us-ascii?Q?w0Eqhi6qQuMAJwapm+6cvh+WFY5a6kPl9sRV8ILhDr5zU1vm1bGDtGu6WURn?=
 =?us-ascii?Q?cGMBgZOlJI3I8xWxlqPH7iTcxo2lUPuyXDaJuF49/Rq9w5xGnan+XXkPH3ND?=
 =?us-ascii?Q?b62v6FvvhmNd0zKGwna2oR/hf4MtWSpdg4Mi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kKuijq/dPbZQilsVmtV9UZ66RH8pus9PLHFeeBuu9idPW0ifqraVWMN2PcL?=
 =?us-ascii?Q?Qy6zgEt9ZCQhFq22s/+auFzNlfkFTldF9h7YpkbzI07z4oi+eltyneOCcxCc?=
 =?us-ascii?Q?wam24Z01fn+xY1DQ5dtduTUV29T28b2jbhJQ+b8DgNrj9Ty3QFviGR8q3SXw?=
 =?us-ascii?Q?AuBKc21LTpB57uikgC9elIJ/GH6D8kiGeQfkPTPB8pLVvZKpna/lqay62w7m?=
 =?us-ascii?Q?7y6G033W0yPQTtF8ZUC4n0GaCbXwRjJOqkAEKPH67ZqQLk7f3IMRjdhxp66H?=
 =?us-ascii?Q?ZsC3iNDv0nx7enzUuq5xcEK8niSHfKpxq4OqWURFnV9psppi6JfmCYy3KJ1g?=
 =?us-ascii?Q?DCq8UQfG7CvAQdW+JijZu3xMmtWv7RwlIGfFWitgJFoT0cqH7fuP/Lz6cjVs?=
 =?us-ascii?Q?DXSWdGdIObU9IbskNAkCYLDVjeKM8/TfK2GqQUjMnOaVxI7o/y+eDovwV6wx?=
 =?us-ascii?Q?xBX6LnaRZsU8IzjM/bzgqsARuDMYvlo8O2kwEgHn4e+njD1Pds9TqSOZmIWI?=
 =?us-ascii?Q?DThkZV6UBUYLE7X+E/owLldq54YlHqXUR+MFBuPXNmMM1QbQgVZ7xJyeprvH?=
 =?us-ascii?Q?qqbasq/oVHD9MR2SzuogabMi6J6+/sX9g/O1Ir9pSWJIg7Sf0me59u62Konn?=
 =?us-ascii?Q?f5SoEEKavJJN397/1cdfAJj+lRsa6ePobh4RJ/5uH6+ZcmMANvBGJ08kezWW?=
 =?us-ascii?Q?isWHIAvicjau54UtGQOoTDWvP6x5aF3vXeE86iEB4kSPcRsDxMnOW7JwYmVh?=
 =?us-ascii?Q?8boHxdC/IPpigIlETVlTJFBFEzlxhAwTXXnAHywYIzqG6x6NSABH/pWXu5QI?=
 =?us-ascii?Q?F7qVBLg7t1gmeqxVt7X90C8kQjeLaymmXFwXHhTTjUGslvLdWLFba6ncn3Ul?=
 =?us-ascii?Q?qVtwfwwXn0vPnOiRe2wE7cUe+CCzHIk9egrg1PxCDYmOKlrKvCsEudtYi029?=
 =?us-ascii?Q?ArjUaRkp2IJCF9qPNdtwAx8yCUDjbEyFpnFIlm/V5b0TTY/QRn+EdF07zboN?=
 =?us-ascii?Q?nmPzSJoYhtT3ScG8x2Kh5ljbhHzAk+ZzezFCxUBRAyiEy9vUdau+l8Knfc7k?=
 =?us-ascii?Q?pCmf/PG1VMKdgwVO1vlOFKnVBemMJlvbP9JL48QE2Q/JUd4nrxIigsm891Gz?=
 =?us-ascii?Q?lRzzJTO78EtocPcYTCveVYMGT6RJLyxMJZC4pYsjc5tA7LIf4bUWBBcGEtnN?=
 =?us-ascii?Q?A5O9CWG9DqHDCBx2afKE4rAKdNti59NFn/x611LZ1DIRkDLiwnkpAMSC3eIy?=
 =?us-ascii?Q?VOLiCJ++Y2Y6D2CzRgGmICkq9Y5gVhgYGle4tlG+537wHcgJG2sCLMwhtUk5?=
 =?us-ascii?Q?eBLN/Dra8ehzxiNbYSAx5o063LvRxCKQHq4H0bhneDOrKvav6KZaxCduV2LY?=
 =?us-ascii?Q?kPKmbZHCDy0wWo/LrN9fq0VjVmlXFhdRpN36eGQCQ5N60oMxkM556TKNUwEh?=
 =?us-ascii?Q?k5sKUb5HJN8Goc67rnIWS4fQ1Ahgk+hwVAU4o6YDQwl2fiTTjBq/FQF2pMif?=
 =?us-ascii?Q?OEvKn4UAbSLRAtPr3KyoCCEEl1dyEr1rMijUBuXOXN0jl3sCeohSS5+g/xut?=
 =?us-ascii?Q?p9qz61q+graPRb4mFgQlRrC7dExtVbz/W33IwP6M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6681587-b7a6-4cda-9f65-08de1c58e9e7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:48:54.2979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0UUlOvACFuAVq6etoNXRGyau62t0OphZ3mTL7YjfdrB5rRtRp8L/v6MG74ZX/2A03o2ejyjL/T3WtiKFGnoWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9293

This series adds a new full-MAC Wi-Fi driver `nxpwifi` to support NXP IW61x
chip family. These chips are tri-radio single-chip solutions with Wi-Fi 6
(1x1, 2.4/5 GHz), Bluetooth 5.4, and IEEE 802.15.4. Communication with the
external host is via SDIO interface. The driver is tested on i.MX8M Mini
EVK in both STA and AP mode.

This driver is not based on mac80211. It derives from mwifiex, but due to
significant differences in firmware architecture, host command interface,
and supported features, it was not feasible to extend mwifiex without risk
of regressions. Thus, a new driver is introduced. Future NXP Wi-Fi chipsets
will also be supported under `nxpwifi`.

The driver passes checkpatch. WPA2/WPA3 personal/enterprise is currently
handled in host via wpa_supplicant/hostapd.

v4 adds support for TWT, monitor mode, WPA3 Enterprise Suite-B, and various
fixes and improvements. See below for full changelog.

Data sheet is available at:
https://www.nxp.com/docs/en/data-sheet/IW612.pdf

Change history:

v6:
   - Removed custom locking (main_locked, main_proc_lock, more_task_flag)
   - Refactored main process to rely solely on workqueue
   - SDIO interrupt now only queues main_work; avoids direct call to nxpwifi_main_process()
   - Introduced atomic iface_changing flag to block main process during interface transitions
   - Split monolithic main process logic into helper functions for better readability
   - Improved exit logic to avoid lost-kick scenarios and ensure all pending tasks are processed
   - Replaced rcu_read_lock()/unlock() pairs with guard(rcu)() for modern kernel style
   - Code cleanups based on review feedback

v5:
   - Fixed build errors introduced in v4.

v4:
   - Added support for TWT (STA mode)
   - Added support for Monitor mode
   - Added support for WPA3 Enterprise Suite-B
   - Bug fix: In BGN/AN HT40 mode, throughput was 50% lower than expected
   - Bug fix: In STA 2.4G HE40 mode, throughput was 80% lower than expected
   - Use wiphy work instead of general workqueue for cfg80211 ops
   - Introduced RCU protection for ba, rx_reorder, and sta_lists
   - Used per-TID spinlock for tx_ba / rx_reorder lists to improve
     concurrency
   - Replaced mutex_lock with wiphy_lock
   - Reverted "use tasklet for Rx" (back to workqueue)
   - Refactored HE capability handling for better clarity and
     maintainability
   - Used standard kernel helpers for MAC address handling
   - Replaced proprietary nxpwifi_ieee80211 with standard ieee80211_mgmt
     structure
   - Used u32_get_bits() for VHT capability field access
   - Replaced LOW_PRIO_TID with TC_PRIO_BESTEFFORT for skb priority
   - Removed static WPA/RSN OUI table; now derived from cipher suite ID
   - Removed redundant helper functions: has_vendor_hdr and has_ieee_hdr

v3:
   - Enable 802.11ax (Wi-Fi 6) for both AP and STA mode.
   - Extend driver verion string with hotfix number.
   - Remove Rx mlme work.
   - Remove all useless check of netif_carrier_ok().
   - Merge decl.h to cfg.h.
   - Remove unnecessary check for wiphy parameters setting.
   - Synchronize following commits from Mwifiex:
     wifi: mwifiex: replace open-coded module_sdio_driver()
     wifi: mwifiex: Fix interface type change
     wifi: mwifiex: Do not return unused priv in mwifiex_get_priv_by_id()
     wifi: mwifiex: increase max_num_akm_suites
     wifi: mwifiex: duplicate static structs used in driver instances
     wifi: mwifiex: keep mwifiex_cfg80211_ops constant
     wifi: mwifiex: Fix uninitialized variable in
                    mwifiex_cfg80211_authenticate()
     wifi: mwifiex: remove unnecessary checks for valid priv
     wifi: mwifiex: Fix memcpy() field-spanning write warning in
                    mwifiex_cmd_802_11_scan_ext()
     wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()

v2:
   - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
   - Remove useless header file semaphore.h.
   - Use static variable for cookie.
   - Modify nxpwifi_register to use ERR_PTR, IS_ERR and PTR_ERR.
   - Use error number for error code.
   - Remove unnecessary private ie definitions.
   - Remove mutex async_mutex and related code.
   - Remove unnecessary work queue.
   - Add the support for PSK SHA256.
   - Use tasklet for Rx.
   - Remove unused functions.
   - Remove compile warning.

Jeff Chen (22):
  wifi: nxpwifi: Add 802.11n support for client and AP modes
  wifi: nxpwifi: add initial support for 802.11ac
  wifi: nxpwifi: add initial support for 802.11ax
  wifi: nxpwifi: add support for 802.11h (DFS and TPC)
  wifi: nxpwifi: add support for WMM
  wifi: nxpwifi: add scan support
  wifi: nxpwifi: add join and association support
  wifi: nxpwifi: add channel/frequency/power (cfp) support
  wifi: nxpwifi: add configuration support
  wifi: nxpwifi: implement cfg80211 ops for STA and AP modes
  wifi: nxpwifi: add firmware command and TLV definitions
  wifi: nxpwifi: introduce command and event handling infrastructure
  wifi: nxpwifi: add data path support for STA and AP modes
  wifi: nxpwifi: add debugfs support for diagnostics and testing
  wifi: nxpwifi: add ethtool support for Wake-on-LAN
  wifi: nxpwifi: add utility and IE handling support
  wifi: nxpwifi: add driver initialization and shutdown support
  wifi: nxpwifi: add core driver implementation
  wifi: nxpwifi: add initial SDIO bus driver support
  wifi: nxpwifi: add NXP vendor and IW61x device IDs to sdio_ids.h
  wifi: nxpwifi: add Kconfig and Makefile for kernel integration
  wifi: nxpwifi: add MAINTAINERS entry for nxpwifi driver

 MAINTAINERS                                   |    8 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nxp/Kconfig              |   17 +
 drivers/net/wireless/nxp/Makefile             |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c       |  289 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h       |   33 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c       |  615 +++
 drivers/net/wireless/nxp/nxpwifi/11ax.h       |   77 +
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  346 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  887 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  164 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  275 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  924 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   71 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h        |  985 ++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 4050 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  475 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1283 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   98 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1217 +++++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2401 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  500 ++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  680 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  911 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1837 ++++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1836 ++++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2856 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2649 +++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1319 ++++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3449 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  868 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  250 +
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  208 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  358 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1234 +++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  490 ++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  506 ++
 drivers/net/wireless/nxp/nxpwifi/util.c       | 1580 +++++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  132 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1379 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 49 files changed, 37842 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h

-- 
2.34.1


