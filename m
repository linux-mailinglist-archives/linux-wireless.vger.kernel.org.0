Return-Path: <linux-wireless+bounces-20480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE4CA668F8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 06:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DA4171F14
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 05:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A81C6FFA;
	Tue, 18 Mar 2025 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TcKZOfHp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDFF1C5489;
	Tue, 18 Mar 2025 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274513; cv=fail; b=E2iHAdBnBPyuZuqYYnD/a33Fr332O9yRSRDAQAicp+uOqftQP5KqOA+V/j33wRs/8iATcqeChykv+A+8TGdexPB6dRHNYrHMaNl3YxnGULNLjqcRP1ONO1s4BjSApvgkBidJ7rPdhz4YM7I+I9MlaWyWvajaDKv7pM3wywPeF1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274513; c=relaxed/simple;
	bh=XaWjNWqzmD6M2ZqtwKsTuwogrWOf9+dIOlvJplnq4Eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxFx+hfw+fiXoOadfKCxdvB3J3qZ59LULGEzkDIclCTAc8FwQdYEr6RPoF589mEWs69yuGn/vPto1678Jzwtj9bYekDdMdArhB8oTKI1p++DADkpSw5FKGXFY9cTAZ/zUHugk3BjphvixFYPWDyLBaAu/2Kg90FZ0eMliqID9Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TcKZOfHp; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQ8Zya1p586VVjTGv8UHaQnQ36d93RvC7rlcHKIrxjzOuwhC1BCTgJ62bnPutb5v1Lee5qek6f3t8yaoRXr4WAHVBxFd6bR/JRPaHJju9we0ipGjE2wFaeMILENkTTYQc7nt7HCgez0enUCWYZNLf/ZYn9nJvkFrQykQplt3HBvAcYDL0cuAGg8faRLwf/UEKcj8dS0uVKRlKhdlqg7DSPZQjJ9u6GlsVKndEzERaQfiphrYFYVFmjl9Gn5a4kayhnONpJDPAHXHLCGpE2Qrb/ALCRe+6yWDTcNk5aZXT6ddcwrSJWKtahUO8gV8MwaNowdSuSS/g4fwyYBvA3D/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o1Z2TiMzuFEzu83i+yEwFY1vFuaixTJKd1ZttqCwV0=;
 b=up5Q0xC38hKJovt/4fc1Rkf6brT6kMhrsms+dXwR64RNHwPNFG6yXx6/20yVYKptTmn2fDgHlUkj7quSIaB3bdrCRccu/QQ10uBKlID1w8ZXkrDFxPY8P2fwtc9uBLou/ucBjlMsEesZJtvs5vw6uDAHHPYY691GWd23phNFN3hJR/3VlTlvbz6nN6eR/v+BT5MAg+lhoH8U3Xct7xE29XoqgIDF1ZuCJCKXOIPwTdMtJEQAZhkRsZoucVB4mLoq6Cxz9FaGYx4VQoZbq+hMwFc3535B1Ta8PPNQSh7ejJeqTCbhnmSDUNvcwqCFUJ0MKPf6QjnHNWxZ2Sb1SstaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o1Z2TiMzuFEzu83i+yEwFY1vFuaixTJKd1ZttqCwV0=;
 b=TcKZOfHpiFNPPjvSfv2Gt+hoTIZjjQ/udJlVFnyDEBERk29+XlJuiJ96bYniRXRL7ioLMODvPQq+pjWVSr4wy7YLqCIDj8IkMnevEFVW4VrNRw9Kf0cujIQvUyjPMKOJiczqStdVkcrYoLE2I/w0g8FgdbnMpbcUf1dBWP93aQmNJOl8gqeoV4aUFdmB1GQ81yERPLO4ydo8yHjBFSZ4Mmxd/VLMtojippOkj/Q29oyVyxnuq0fRkViYk5UQfSrObwCt0DPMNZCO34u4cXYdWWdewsR9DP/mjJ2sj9Vwm/be8xcjjdo0cfEZ2vvyJBuJOYlUF58OfcNqf6zvtpGsEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7)
 by AS8PR04MB8022.eurprd04.prod.outlook.com (2603:10a6:20b:28a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:08:29 +0000
Received: from PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6]) by PAWPR04MB9910.eurprd04.prod.outlook.com
 ([fe80::24b9:b9fd:bcc0:4ee6%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:08:29 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	johannes@sipsolutions.net,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	s.hauer@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH v4 0/2] wifi: mwifiex: Fix RF calibration data handling issues
Date: Tue, 18 Mar 2025 13:07:37 +0800
Message-Id: <20250318050739.2239376-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::12) To PAWPR04MB9910.eurprd04.prod.outlook.com
 (2603:10a6:102:380::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR04MB9910:EE_|AS8PR04MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d85637e-18f7-4bac-8280-08dd65daebea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/sYInUZTOa5Jd2+NsS0vgwO2cW8Ge+sfEXNuOeobyF7s910bhBxp5Mu/EFD?=
 =?us-ascii?Q?lRbiqq/eSRWx250Xq3SmTAOsVXgSliO+WRriItPxsc5GKK/BqmQPMniNs/TG?=
 =?us-ascii?Q?oP0mPoh5J3bJOUSsXWRdGfyYsC8Gfs4c8GFDkI9rdp65z9/AjmwB3uacVXoS?=
 =?us-ascii?Q?UG7Uf19uRTmsWLI2uXAJhlfGgX0/pKFr1+Twjkcfc8d5ctzuwJi7xqC8/UHp?=
 =?us-ascii?Q?4rOiK6QPKloPdhwf+hoGQKTIYCtnVvWmRWjKw20cYegauJHbbH9/3xhxFq9H?=
 =?us-ascii?Q?502camXY5TJ4073RkWTpiAl7eT4I9jMGEA510UtA8K2laCXSG+DZ96ZDUunL?=
 =?us-ascii?Q?GOTpgLha6pWIyl7B63mWdms9xwdM8SC8w9Z9rtPrtMZ2oKh4phb94XAzslfh?=
 =?us-ascii?Q?AX94GWqJfV7Ynf1wOS5TTF+n8JwG/l8WkOlTZ5XYHK9cWFinnUa+pAxoWcZU?=
 =?us-ascii?Q?YAbSNnyzQsesECy6tFylq2Dkc1ltpE4IfgH2r6C5GXJHjfL1WsqrlPkgcdMF?=
 =?us-ascii?Q?F8/XZ0LrEEwZXBtCOOpotn9sIRN8qPvE6n+4QQwc4OJbFpWli9YJvIITCP0S?=
 =?us-ascii?Q?U5qKBCIDM9sE+XWjP65rnv+3kqN3R3kvC6cH5RVMSJGHajciIGcpsAj27/z/?=
 =?us-ascii?Q?0nwzReui25d111d9dNN/x0NvHdebFETAxxbEeYrOdwqgovNqcxSxrnLe4WGR?=
 =?us-ascii?Q?2RhpuuUZoWRqR3uzsJYQkTKoxV6b1xvuj31IwQa7p29UQscrTHnFQUkgTH96?=
 =?us-ascii?Q?ffhEOdhw7vNWQQ1H0u8lFOwQhJOnz5HYV6xdS5wHVI+KfHyLnViE3RHnZ9i3?=
 =?us-ascii?Q?D7ks0Wt1i1lGRGPEkKagVrvzMnCLCNuoS+zBjGGZ/tT/2XMAWSkDn3wcx9uX?=
 =?us-ascii?Q?FYmcp/wwaIUNsOS3os+22VkCtV72EG7ZKg2BtfbCf3CDomJTQ4oX7BQHFaqW?=
 =?us-ascii?Q?EIwLmETfXZl3q+QvUY2yqbdkrTn7Wu6UKfOvXxhqDG2QvXUPZUbM9Wkb/wac?=
 =?us-ascii?Q?mf4mwMloV57m78FrS80d2pRpvrDLwA3exB+dAktCzCpluYeCdslIszorhKZJ?=
 =?us-ascii?Q?M3gTYeij9vWlk5k38htqYogxbxPcq2rZWL1XAaEloF3t+JkRfexn8TRGE+aq?=
 =?us-ascii?Q?snnW5rMQrFp8pCOSonEp5B11kk07XyGY6/OAXoQNptVDE0dPLKRZDt/o7nTS?=
 =?us-ascii?Q?QDvu29RgYkYBj6bpMhGz8jk3gdx7veR6yqyEF1H7ju9gc7dl/c7UdAQ/ztFL?=
 =?us-ascii?Q?FEwjdSXGThEWOYpOzCAqQWzXvqFjUoSJfwCuwORlc50+laWC5672euwi9x/Y?=
 =?us-ascii?Q?Q+9cQKna5WFV175xvz/r+WBFCPWVAc5igUlamUi5nU7MDeg18gniG4buCr96?=
 =?us-ascii?Q?B4eacEbWl57tVKJA1PnabJgGok8bvwKkX02+QYtJ8fcyMYU/BystuEYh7Mas?=
 =?us-ascii?Q?ZwyF2cgWL24Y2uHLEbTLPuBpiZrWR11F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d01A40HgrCcR3Ikyb+ZIolNgpDDBMlcg5bIS5lsG6Jqp8ak7Yj2fNB2UtiDS?=
 =?us-ascii?Q?+9MfRNjINQ/RW8ca5PdweQv+KY/A0U9XEZQfN+aWR2r5lQJBk/rv1nQiSx0l?=
 =?us-ascii?Q?ouYtlEgCj6Ge9z6WEODbI1WnP/exiKA209iKcAO9U45j2i3zv2ALF1Jaxy4+?=
 =?us-ascii?Q?wije3oAoZHHj5lhEESO8LHuhqUv1J45pyZnV+ahfoSd/leE3VFRotvaZzVbr?=
 =?us-ascii?Q?dlBRu5Kty/QYCu0kqgVTuKe8WxJZ6yqFmk3e3aktnB6xnQpiQIXNXuO8E5/z?=
 =?us-ascii?Q?FG0BZnT/UPo/SFkLf3zzCu1LJbYQrfFPX1o0WBp0EtSTS7J06P3L7xyfJB+x?=
 =?us-ascii?Q?UGT9FqKHhhGcbzFSnELh3qcIfvyTtCU9MfFePl+Xn7eGKtN2YL9+28UxhgDj?=
 =?us-ascii?Q?nI9dSibYvXhjEzL4j7fYRPnwtmx+LBIKdW44iLdPKs1XParceLZjBCn0q6nO?=
 =?us-ascii?Q?rYzZRHm5XUnsE+Oyzp2bEIkbVc/zzMWmfbv6g3oSDcIrngL4HQ9NlHDd14Ik?=
 =?us-ascii?Q?6hdcXfvtX1VVq+xdLi/SFPhKBgi1hm8xWbBQsdL8uxiw9Fama8gGeH1zLcT/?=
 =?us-ascii?Q?tqrs+68CYXWakGNUKypSFL0VLgd11zQD+wCCb0beqM4x4VpY01/zj0fj8uLs?=
 =?us-ascii?Q?NaDw3yT2X0jYwUuaKH24by9ubyzGYmuno1mFjG2EWpuLRR4gT8chUQJpiHsm?=
 =?us-ascii?Q?Wtk7qtGY5WtCndsnoiYBXXtVoDx88YAEoqQRL+6c0oeood9b4+KLPGQFJF0H?=
 =?us-ascii?Q?DGgmhAxVc6Lxcd6fpZDYZYxmmYDuaMQEqCFSs4aYcWGLPyeZiZeCXPglBisj?=
 =?us-ascii?Q?tdW4bsgcaXAhaJ3EpY2qh0/wAlckKXkwsqYQMZKNpY+o+O623KgFUbMBo2jU?=
 =?us-ascii?Q?nuhUpR30J2i9hgPUzWceoJDN0KbL98/LN2SLooJATsou+nHKHwSgjkvUQc1g?=
 =?us-ascii?Q?Xubkn3U0svsFhfVpEkKcC3+HWyvx2XlpH8tYL55m4vbUAXOHAHVZW6icx8XR?=
 =?us-ascii?Q?AnzX57cUC36xdRVHHauVqiyWtDSXXb98RAQZPRKPRVFhf5oN4mFJJaNYpiGy?=
 =?us-ascii?Q?jfmW+JOX1kLsdnIcknqlHBFzAOoQTX1lp5BG5Lg78GUI/sZk6axlpOt7Ta4r?=
 =?us-ascii?Q?lKatHPVZObant7qN32xoVMtwolRNf39sVQGniGgGcFYiuxzHCsPG0F+zQUaS?=
 =?us-ascii?Q?5CSJ4ov2dg2SdJ48wmgNk1EG9JI3MvMGddwhdkGyjxF6ZA19IIr7N4Qrq/+f?=
 =?us-ascii?Q?+GOy7ZVmbHYWhKbe4/oDisSgJHvtXsquUWgACR3mARiwRD2tzjjV13hwMe1Z?=
 =?us-ascii?Q?Ha1Dxw7pyUuXnE6bO/85qJsZeFyBwNCtxGi9v7qoeV4tHb1TfzQh8fXJ8hfE?=
 =?us-ascii?Q?rRJ/ZmsDpNA+XIrjWwrhtuermYVYGzfmGo0XuyLi4i9MXwLqDoG0wrhdfPTm?=
 =?us-ascii?Q?O6Q2PZuQHSYgcWHsQ0a0rnvnXXKt3SclT8IlV9iPbihpZ/swl095GT4B/2mo?=
 =?us-ascii?Q?bJBrK7aJdFpYa3zWm4RwGDtpGSBHdwjoY8U3lKINejpcIk+nrk0W8ULh4/br?=
 =?us-ascii?Q?jxwmdPfhwjlX6SCBMhQULvshjiP/0EE87c/lsNkv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d85637e-18f7-4bac-8280-08dd65daebea
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 05:08:29.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ofTpIYMOgJ60p295PxxeuxdAp33mKcoj8k0BcukxuyNVob/Z2YSUAy/C5QooyZnL7YNMdtPB63F0PTCFiHayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022

This patch series addresses two related issues with downloading RF
calibration data in the mwifiex driver. The first patch resolves the
problem of calibration data being prematurely released before the
download process. The second patch focuses on restoring the functionality
to download RF calibration data from a file, which was broken by a previous
commit.

These fixes ensure proper handling of calibration data while avoiding any
impact on downloading configuration data from the device tree.

Typically, calibration data comes from OTP/EEPROM. This patch merely
enables the functionality to download CAL data to the firmware from a file
and does not require backporting to stable versions.
---

**Changelog**:
v4:
- Patch 1: Clarified the title and included the Fixes tag.
- Patch 2: Refactored the patch to ensure that changes for restoring
file-based RF calibration data downloads do not impact the functionality
for downloading configuration data from the device tree. Added detailed
explanation about the potential impact on device tree-based calibration
data downloads.

v3:
- Split the patch into two separate parts for better clarity.
- Improved commit messages to provide more context about the issues being
addressed.

v2:
- Expanded the commit messages with detailed descriptions of the problems
and their impact.
- Highlighted the premature release of calibration data before the download
process.

v1:
- Initial submission. Focused on correcting the command format for
downloading calibration data.

Jeff Chen (2):
  wifi: mwifiex: Fix premature release of RF calibration data.
  wifi: mwifiex: Fix RF calibration data download from file

 drivers/net/wireless/marvell/mwifiex/fw.h      | 14 ++++++++++++++
 drivers/net/wireless/marvell/mwifiex/main.c    |  4 ----
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 17 ++++++++++++++---
 3 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.34.1


