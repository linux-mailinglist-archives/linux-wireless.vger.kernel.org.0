Return-Path: <linux-wireless+bounces-11177-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A047594CD83
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2200B1F221D2
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A19119049C;
	Fri,  9 Aug 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A/e57wO+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD1418C918;
	Fri,  9 Aug 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196757; cv=fail; b=dRysrrub99xOGwCmGxDD3nUy7E9qBvz3H/K6UEtGGnVOiZBghmYr8L/pnmZq58EdDQK3h8qgY+2+TP1idu8R7yk5ZXMwiXyikXlpCqcsjuCVJsjV5BAufq0uQwPLu7ZbzgjyoijkzOiwHEhPE/Q7PAWS1jmXGUvoUInXAv8qcic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196757; c=relaxed/simple;
	bh=hezQ046Qf2HecVDte4tflpsxlm8xrkR7JZc4Oh3JPBM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VRJuOnqUfwbWqiGvrchY87y4tWftTITmxigVouQiTZ8sW+jBuOjleSVKqDWN6k9ymzjhcpgfW31ah/38SkRb2MKcUxiRI9anNDJcrQiYPVOrwSijWwOpYX/LfO3YCo2Mh8DUi3jm6bF3GXGR60i8MMs2asbDn58tlHbaR5Yn5HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A/e57wO+; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLE9iQ9l7iwISmK3ayCbFI2VdDdmqz6b2lRPPGggceG8lls1IbgEQrU3I9HvXM+Ip7iaoB8wuH87MR/ckj5dfvyNfeOlUQKYF9Xhe23jxo+dQ61L65Qdsn3N3JHVajwnqDADjdV6QfoNc494aWIFQJOdymhmVR7+O1HNQ/3YReAUSqEe+hMOrwZGsJMG37A8VLaoZzsJXdA/I1db9iJh76UFA7LpvQJE+67CuGWYD5hJFrEQrXKpyEZ8JeyU5lh60w57Fr0QmXItpktDRoC/EzwffTklXnt3QSZ8jtrwhmpL+6RJ/R7Ht/XWRVYj9mmpHP0h9WLIcVJhhZ72Xs6kOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYwtKz5c1bX7FBscuF86W3rAWs3BV9zhaPGWb1OkfRw=;
 b=BKfhW/jLN/FQ2sK8nqD5dNO31CsRuGvxzE1pBkpNLyOND8IM9b8K0uDP5Fjsn3CJ/dtv/KcmENZf+QeGg3AQgqMrJoVt4Csa7QYLvWznvZ/Hm44OR7fCjuAh2W4QXsMIB8Ngx/IcCnYui/Dxw0xS5tw4+cFxZUKtTf3MSdRQXXB878Sfg3TOw9ZktewSoKwItoo1pGKGiACEgHzB+ZY474pBZK4Su7zDWi6kek9m28L/eZjFmJ6qq7pNyF50sU5A9kiJUMKfvLujYJ9EiD0/LtT3q5pWEQfcz5Ud8TDYKDXe0A0WHkl/fhCzrT/LEFKKYLKxId6+kUHVe005CVLiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYwtKz5c1bX7FBscuF86W3rAWs3BV9zhaPGWb1OkfRw=;
 b=A/e57wO+ux9NHHTXfzTp5XJCYJtjUt0/zPYxOpTZQukQFHIZrxf+tj5I36SOmTC9WGfWSTlSa6nx4qkvOuJ2hZurimPfp6UVzK07AnRCkWEOzAmbdBfuLUD7S5rxNh/3Bq4tfwFVp23Kk+elegpTfPP1EhS9VzA6KWpmvRjv49nrXt/fFlyxb4+/aTLDiVVj4xeAQ9wByf1VS6cXEDL2z9Ny6pNYQfD1CvsD3bmf31Bsy/Xr8Z2of1RoOkuAPJUlIll+dra/j7Y6RhzUfyWJuS/4D4rguMPPeaYQRDHBSp+dYXQhgReO12EfJAImIvW6NlTcyCPWzQs8wPivikO1vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 09:45:50 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:45:50 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Date: Fri,  9 Aug 2024 17:44:50 +0800
Message-Id: <20240809094533.1660-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ed11ef-16cd-4e96-515c-08dcb8580d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?46ZcavFnL828x6YdPG58o9ezDtde8zw+hQvPyXxo1H3+Dqo64KtyHlE8VEzQ?=
 =?us-ascii?Q?CrnFbo6VuY56P1k2vaJxWRCM/0mnEZn3RzQQ0WNcpRnfefjXNZjxwNt8q6mE?=
 =?us-ascii?Q?ROMyi9keWBAv1pVqb/4GLzk51mBf9XeExJHsSctV3mWGGPYdK4bw26VwYioD?=
 =?us-ascii?Q?MMgW+hdLJhOHv3cjZEf9B/PuWfpz/qIpYTi68I616wXIa+KIyZwkS/U3X9gA?=
 =?us-ascii?Q?CNfvyX5TYDsIoy7ygyErgCTARSC7XYJpOmQb9dDD/DG/VqqdD0XrJd8eVE7c?=
 =?us-ascii?Q?6mSY4Hh1bZxWTKlzNwqHdr2NAyCHLoSZ/UDIdByMICGoTHqB0+Rja9FO0/Aw?=
 =?us-ascii?Q?Hw6NYucXc6OsInN6uzjOF3LIYvIQXi5PQUcqDQFHETcT+dBbCG+Sdh9g3EQ8?=
 =?us-ascii?Q?qp2RiNaLP+gNbTSmE1ry1GJsGMAeXhqsoKWNyw1YnFPRgq6t9AR2hG6DcDbh?=
 =?us-ascii?Q?7bApCDY1Ehz8XV7N0d1FhIPEd5UxQ51VGDug0AEZsO+pbdB61qJtH+iMcOc5?=
 =?us-ascii?Q?opaB/Y0WBUH3mODSPwV9v3NO9PDdallWPg9PuTKquwQv73y+AV83IwnqBLGI?=
 =?us-ascii?Q?wDR9qFW4qVHS1x93Fxx9jOnuglGp10SgHwduy+Q06+QABMR9QQHnLoDU9pbd?=
 =?us-ascii?Q?RH+XZXhqYi9fSkFl6wHsBWEUlZnI3zP1K75oyOsbOW4fn2YR/1vQfo8bIEEu?=
 =?us-ascii?Q?2maFlH8KMyNwL2ZDt+OxHc6QjHYjlX/LG20fJYGBhnyXiIaUS9yPG7xczNmn?=
 =?us-ascii?Q?HuoXpKJoeuLfn8xHaXXBsvlNi3ZBjfhYohBfYZQdJ3ehR2sV58HyfToqOOCa?=
 =?us-ascii?Q?EB8Egwpwu3m5ET92cZ2NpMQIzHqXlmKV5rueIpJyS7trQy0/R0iNyzUzRYpq?=
 =?us-ascii?Q?P1hDZ3LOfbk4mZbPLQrrSvYyKgiQP/aJArwfsGthvy7U1Rvvoza3ATZ/MCWr?=
 =?us-ascii?Q?bfnWAPXOSsGL/97YTzj+M+Dn11dm4AlEMitFV9ijAac0EWnjxY5Sh4Br4gB5?=
 =?us-ascii?Q?nkGUUKv3yWFIXqNeSWX9FEQlSS507HFHII/l5AkoHrgNx0l/R/+wWXSim5t6?=
 =?us-ascii?Q?9OjE0CmkO7gZU/kwLwH64jCiqKtv5dRJEeMt4vc1MCW+9zq7Oua1JPS03djH?=
 =?us-ascii?Q?V/rEUi96cX3//Cs0EFB8+kFryxg84CJ7DM6yqxN4iiRxZYZnYtDx0n0seOj+?=
 =?us-ascii?Q?peeQlehkBpxrJrFRoS3S5iEA9RKX+9QHUY00OeAY2Ur4xcaXB5220/EMGyQe?=
 =?us-ascii?Q?g2+10roxiPvRPnFhOhyZIHmG4+i/dCFUNFUbUVbyLWQW2+ExiT1ucc87N8Ef?=
 =?us-ascii?Q?7SDK5vhWhecj8FyECKzrfwVuDx/Sj1b1QaEHRCzhbqBX2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dgyzxlPEZDnHikd83fyhbntYPXLIAo0oBpH9aU0ubImzRBqzzc0YZGc8PGJu?=
 =?us-ascii?Q?7XOuzxXyDnM5M3jZcSRrJOY4mDPVSgJBhbwsfowYKnymONu7BX4m/GuPXSO2?=
 =?us-ascii?Q?MjuATRSLcxy4mKktm96s4MUIXG/sOm2/jVBDGgTp3M666h3tl0ySS8T/a777?=
 =?us-ascii?Q?vA94jltOrNvcRgUfOR2vDIA9dq6MfSRLHYXAab/EHKRKS+I2CkmVCGP4LVGk?=
 =?us-ascii?Q?81Z4kysl4t0E7BdpeucL0woWuuHqDUaLyq+YluMpUhj9BUje3ddyqcdUo19f?=
 =?us-ascii?Q?Ps+9Z1L+hrOapkxE6jhuWroyG2kK5rl3n9iDIWBei2AObHQ8rJ23prasM7kK?=
 =?us-ascii?Q?/bXT+uCQloZgI1uUtidZ4WeWpozuzpCaE+RIJxmMikRkmcKb2B2usDB49cUT?=
 =?us-ascii?Q?O+VQtNe12PQ022UJBAmfJj2YMalvu8NGwX/i2MTkZumgtFIJRj3onDeHWV5z?=
 =?us-ascii?Q?TaT3kXXRKR9cMRYTRBcJAA5/At9K/MTMUSt8hLJQRI4wiSet8wghlpSzOsPF?=
 =?us-ascii?Q?GT2PtTCnmGXmuAij7qSBhG9yn0VKJ1U7B0eDmz57aO+pU4WggKfl0P3Zy4OS?=
 =?us-ascii?Q?ORsUNsig5zhKDaBBEVbB8K1ZlbHbjjmYhPK5Owd0jC9zq2/QPc39ONgjR+zK?=
 =?us-ascii?Q?ECnnF8DJYeCxGFr+pA8/UCcVJnCHathZrw0f+T0OohaaXZTuxbzNlqn4pzqF?=
 =?us-ascii?Q?gsE/qMYLRwWOAUzwXAWFodFMT56JI1wz0Ai69C9s38uUpu4R3RFSt9NyLydH?=
 =?us-ascii?Q?kZacqcbCxlE2y51tORWUc0rWZEF9yaImNwdRcedWI2qnnOk2tFDbVRkM4MJJ?=
 =?us-ascii?Q?GRLRTHjOGIp9qKCNtt4qJqx802H1SpncVPqOtMeQQYc6sOikrIt5De7ZpR1d?=
 =?us-ascii?Q?82UVfgAZFXYDi9uaw7PYAhc0AcTmfcrzytzv3nbGj5yFXwlb9+vqJxJ1QM2p?=
 =?us-ascii?Q?8uB3Y8a+gbts4DAr/Aw3En7gHyk4XDwvXUci/jR/ktylC6+Trfd/8ahVL92k?=
 =?us-ascii?Q?cmxBgxj76J5LwVaeMg7HjqA28AC3jqDx53THq5VUdwCgX0mLDA2fPEdY96gH?=
 =?us-ascii?Q?BzoHlOuRKXf8aeTvnSnfCdHWJP94D09F10iS+Y6t68fcIM+B0JBQKu20XyVQ?=
 =?us-ascii?Q?Zlm2aEk/uGWgmEGS+BUF1lX5cmZ/O1N9mjq+fyW3rnrlXBao7PqPmEmpiIgW?=
 =?us-ascii?Q?hK6+lUNDuBxqpqu2eu1zaBhILC4SRCLXbJ3I+S3q5r4gKradp2eV4AMBHTW1?=
 =?us-ascii?Q?e5wTg4hjMDH6KGA6mSdzVSv/DQo6mO2ZalaLufFrwfMSFX6Trmb3hx/N9ung?=
 =?us-ascii?Q?Nh24d2GgpoxpLBRETyUtRJ2jmeV1arhhlb0UgHxXkr7XqmKEnI77SmEo9VmY?=
 =?us-ascii?Q?bDNIz/iq7PcyqzvMKG1lzOW7rrswmXwGwygBTWHhqteBsE3dFRDdwUjxZMo7?=
 =?us-ascii?Q?37OodqrDO5JhglgwZdCOuh7MxML46LxpMWJW1LB64omHtcVZ7eUcLE/B1P5Q?=
 =?us-ascii?Q?HfBQdXcl52Sg1LbfT+X1iEfrPE6gPmJZ2XNGYHRXWDmZsCN4xuPrZ2+pIJol?=
 =?us-ascii?Q?VKC/xnf62Y5KNZmRHNnrEvzVjX+vG7CPjIhVBsTCDhtseR+6JXB8llbstQkX?=
 =?us-ascii?Q?pfkiB3DBHGHpKA9oQbcjyH+9bidPCgV3rxd0h0MK4hwR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ed11ef-16cd-4e96-515c-08dcb8580d35
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:45:49.9748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0m1BDKf3bR0AZN9Pig7o5DC7G3gHG7XTlx59q0HDDqyOkMkKNdf/gUzXYSTfIZirujBe8Hq5MBFES5BpeDPmOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229

This series adds support for IW61x which is a new family of 2.4/5 GHz
dual-band 1x1 Wi-Fi 6, Bluetooth/Bluetooth Low Energy 5.2 and 15.4
tri-radio single chip by NXP. These devices support 20/40/80MHz
single spatial stream in both STA and AP mode. Communication to the
IW61x is done via SDIO interface

This driver is a derivative of existing Mwifiex [1] and based on similar
full-MAC architecture [2]. It has been tested with i.MX8M Mini evaluation
kits in both AP and STA mode.

All code passes sparse and checkpatch

Data sheet (require registration):
https://www.nxp.com/products/wireless-connectivity/wi-fi-plus-bluetooth-
plus-802-15-4/2-4-5-ghz-dual-band-1x1-wi-fi-6-802-11ax-plus-bluetooth-5-
4-plus-802-15-4-tri-radio-solution:IW612

Known gaps to be addressed in the following patches,
  - Enable 11ax capabilities. This initial patch support up to 11ac.
  - Support DFS channel. This initial patch doesn't support DFS channel in
    both AP/STA mode.

This patch is presented as a request for comment with the intention of being
made into a patch after initial feedbacks are addressed

[1] We had considered adding IW61x to mwifiex driver, however due to
    FW architecture, host command interface and supported features are
    significantly different, we have to create the new nxpwifi driver.
    Subsequent NXP chipsets will be added and sustained in this new driver.

[2] Some features, as of now, WPA2/WPA3 personal/enterprise are offloaded
    to host wpa_supplicant/hostapd.

v2:
  - Rename ioctl.h and sta_ioctl.c to cfg.h and sta_cfg.c.
  - Remove header file semaphore.h.
  - Use static value for cookie instead of run time random number.
  - Use ERR_PTR(), IS_ERR() and PTR_ERR().
  - Use Kernel defined return error code.
  - Remove unnecessary private ie definitions.
  - Remove mutex async_mutex and related code.
  - Consolidate multiple workqueue into one.
  - Add the support for PSK SHA256.
  - Use tasklet for Rx handler.
  - Remove unused functions.
  - Remove compile warning.

David Lin (43):
  wifi: nxpwifi: add 11ac.c
  wifi: nxpwifi: add 11ac.h
  wifi: nxpwifi: add 11h.c
  wifi: nxpwifi: add 11n_aggr.c
  wifi: nxpwifi: add 11n_aggr.h
  wifi: nxpwifi: add 11n.c
  wifi: nxpwifi: add 11n.h
  wifi: nxpwifi: add 11n_rxreorder.c
  wifi: nxpwifi: add 11n_rxreorder.h
  wifi: nxpwifi: add cfg80211.c
  wifi: nxpwifi: add cfg80211.h
  wifi: nxpwifi: add cfg.h
  wifi: nxpwifi: add cfp.c
  wifi: nxpwifi: add cmdevt.c
  wifi: nxpwifi: add cmdevt.h
  wifi: nxpwifi: add debugfs.c
  wifi: nxpwifi: add decl.h
  wifi: nxpwifi: add ethtool.c
  wifi: nxpwifi: add fw.h
  wifi: nxpwifi: add ie.c
  wifi: nxpwifi: add init.c
  wifi: nxpwifi: add join.c
  wifi: nxpwifi: add main.c
  wifi: nxpwifi: add main.h
  wifi: nxpwifi: add scan.c
  wifi: nxpwifi: add sdio.c
  wifi: nxpwifi: add sdio.h
  wifi: nxpwifi: add sta_cfg.c
  wifi: nxpwifi: add sta_cmd.c
  wifi: nxpwifi: add sta_event.c
  wifi: nxpwifi: add sta_rx.c
  wifi: nxpwifi: add sta_tx.c
  wifi: nxpwifi: add txrx.c
  wifi: nxpwifi: add uap_cmd.c
  wifi: nxpwifi: add uap_event.c
  wifi: nxpwifi: add uap_txrx.c
  wifi: nxpwifi: add util.c
  wifi: nxpwifi: add util.h
  wifi: nxpwifi: add wmm.c
  wifi: nxpwifi: add wmm.h
  wifi: nxpwifi: add nxp sdio vendor id and iw61x device id
  wifi: nxpwifi: add Makefile and Kconfig files for nxpwifi compilation
  wifi: nxpwifi: add nxpwifi related information to MAINTAINERS

 MAINTAINERS                                   |    7 +
 drivers/net/wireless/Kconfig                  |    1 +
 drivers/net/wireless/Makefile                 |    1 +
 drivers/net/wireless/nxp/Kconfig              |   17 +
 drivers/net/wireless/nxp/Makefile             |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c       |  366 ++
 drivers/net/wireless/nxp/nxpwifi/11ac.h       |   33 +
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  433 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  851 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  163 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  276 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  917 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   72 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   38 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h        |  445 ++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 3773 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  484 +++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1285 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   92 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1041 +++++
 drivers/net/wireless/nxp/nxpwifi/decl.h       |  294 ++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2249 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  501 +++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  694 +++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  915 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1666 ++++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1478 +++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2806 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2648 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c    | 1307 ++++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3233 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  864 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  244 ++
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  209 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  358 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1169 +++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  491 +++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  499 +++
 drivers/net/wireless/nxp/nxpwifi/util.c       |  946 +++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |  108 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1379 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   78 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 48 files changed, 34897 insertions(+)
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
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
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/decl.h
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


base-commit: 555ba98448f8916bff87067853a7e931949e6b57
-- 
2.34.1


