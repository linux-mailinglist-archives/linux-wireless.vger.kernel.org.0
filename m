Return-Path: <linux-wireless+bounces-9364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E576911D58
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5149C1C20A62
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB9E16C6B6;
	Fri, 21 Jun 2024 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ruoZhyV4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7B168C3A;
	Fri, 21 Jun 2024 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956358; cv=fail; b=uqKJ32duR33hIHpf9u4F0kiRFbuKvHVk3q6tXZgmFsywyljF+OG8QByuC1qbYlQUgk77UWNf/Ow1fl4F0nizf0OmcOI7sdwH15NBFwP77THSz4ufYHByI4+DSteBfFGtYL2ckgfYmwwZJ8sYt8KyIxWs+RjhnXoxvEeC02kWKLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956358; c=relaxed/simple;
	bh=KsGUKqGKN6VQ5BmrHWq4w2u7xKArmmcwtTe3/BFtLrU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZdRuTeN5uOkGd4EzyUtydgwPrZDzCciu44qmC87L1M8N4csaGLMJl29q2Dbxg6VPQYYe6BfoDNW5mnXt59odPg3XT7pDgWvezc+0EtPHPzvvjZzCDzYc5GGWFoqy/wFsj636W0VQUhVdOtEwuIreoU51/xl2dgG8tWCj/w6M+L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ruoZhyV4; arc=fail smtp.client-ip=40.107.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDQe/R4o8EMGhgWI9ayweCBRo8LdWdwmuSG3Pdedr/vw+ZmPo8FdXZRjl9eZYCiq3dwViQSTtSkCPdkbQww3kh7O5PG4IPUK7t7nbSNcgFv7wTsgQqFAVDyhCur1ZONDf3k9VE1oZ8Soz75TbnFV9cyJxdrylknzNri3kqRFmPQMKfHe84J9/Cj7kFrN0omu6q8ytfNWLwnJVTntxBo3B/RjlSjoP3/0xUr3b3WRs9H1asyWAqjCWLhaz69jrSHuyxCB8wh1psG5x6EjzXIR667pTV2S4GZOYnKxPGAlXfbtbm2LblZ9Hb8/yVIVgs6f5Bjxubw44IAKY2myCG/bWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE3eEKTOOG/VIMz2iXzqpghYY+dui0nO1PDbResGolQ=;
 b=eJ57uErJkJDFZwpwzy1CvLMCdC5dbqrKB2VLiukMPvA13NiZgbV7Yv90y1IAjVGExP+UwPzUVotZZIbRINjB4ddvT2A2AOU5ljOZCuoSBGO+brYW/esc1HYHEFFtH+hhLdxTwb5OK5W4D7/lIWiEkym+ishzf6qU8OjrYDb3RWWm1VGXjoFj8YEI9tJO4bl2fAhAHDjNYx+QDYeIyISNIK9WGuT3B8x/gYXdlXu7eZd5cgaCdyV6RrMxcoUDQiK9I6arUYLEQlfb5qsBdrIfN+RhjbFsY4G6W2+T/8VT3qbz6KBX6PEGA0lwEIBfAehtgwd5dKMFzdZrTKYT0rnupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE3eEKTOOG/VIMz2iXzqpghYY+dui0nO1PDbResGolQ=;
 b=ruoZhyV4JVYxv/Om9bRvcRryGMnN9uHrbS5diL7F0i9rL3524y4y/+/oWCStmM4QsioRqiNWd9FOKT3ZKpbMAr1xEDWBs8iQ1b+3pKGfFdvhU3tR0EugDITHK/h51G1kACSdIAt1aJZyKPKfW+dWz/K/A4O/z4H0gUsFnVR7Tqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS8PR04MB8135.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 07:52:31 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%4]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 07:52:31 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
Date: Fri, 21 Jun 2024 15:51:25 +0800
Message-Id: <20240621075208.513497-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0115.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::12) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS8PR04MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db5a002-632f-40bc-2c2f-08dc91c71ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHDDKZnCGOrhE1FDiW0wwd4Dj65BSYBlcB2IBfJ+xMsbddq/ZLO2HLen1dLe?=
 =?us-ascii?Q?CejyEZ+bVk+0J8w48UIEGXRv8MBmShVJ97hNz27+DbGZ+lyioHmsEBZv+dLK?=
 =?us-ascii?Q?3kLFxFWlIYX2UmBGnzxJCdC07ycPLDwMuUNfjvrcqq44hYwQdWqgg7gjJr3P?=
 =?us-ascii?Q?i+gcINAgWNg7bQJtWwvO4y39aNtrfIDq7uWsjY4pXQv9EViBGSzw+eAty6sD?=
 =?us-ascii?Q?chBsr52qRwzBDkyxyh3ETY2ZDmuA9p1x+jD9FILSb5wpBUXcQZFnAnlHk17n?=
 =?us-ascii?Q?i/ZdjK+UgGlyWKxLTEgujD7yGdmqFML+dPjHGXuqc56dzllYBmJDJCZquXAZ?=
 =?us-ascii?Q?lr8yzrM3K7ZuHUXEP3PJJPBgdo9E9DSCPG7L3LEAJSmcr+2UN6kASqGQbUnC?=
 =?us-ascii?Q?/TzKKAoy6+Rpv0N9dEBMJ3d7QtOKc8eon8MrVJ1J8J67A+ZNJyZkjlUu7W7K?=
 =?us-ascii?Q?ux3fJpuUIcInzgqyg1ikDZtYRJaWIK55D4Mw0S/D7jlpFPyhit8Fb6RzERs8?=
 =?us-ascii?Q?NNbgsQn9IE05xbdGhuLJO6b3pjKNG3fLwgfBxAbKmBsTSS96LnrO3fYsjGlv?=
 =?us-ascii?Q?3fgVqn1tvWhJ8FWkeiQrMR74S4ZqgUsF/7Nv13zTKBkFXd3k9wIuQtn/4Iwz?=
 =?us-ascii?Q?DO1dXYKPCMkc7cLqobYTyZDKVk6k4J5vJ3rwheRqbr21PWjm3yqBiAwXvWmf?=
 =?us-ascii?Q?r5uWoGvfFbjq2s84YZ3dwTxrkEYCSVCyzCps46KohQLitSW6jphzJNeIpx6/?=
 =?us-ascii?Q?c2Rq7FZcpJtxS0DhGlEi8MquYq6LQtIANK/c0f7wqVx9X2xvwAwlOR4HPCHp?=
 =?us-ascii?Q?ob51cKTQdw9eUjIRRlFLvg8zjR0IZyKn74Ic+QhqmZjUErbnCTbgeW6aKO5q?=
 =?us-ascii?Q?7pqdDPXnRF0D3ROQGNMIImLMNMjAwgSwpMc1iM0QD7SoBCOQVsGGGZTIG2mD?=
 =?us-ascii?Q?bI5J0bAEemj0/5qA4nmdrRX/GmNdoM4gAaaNTk9kLkRVxGhUHIShXQg6EIJ0?=
 =?us-ascii?Q?s5HKvgiWAER8V+Kpirj/Szv5ZdYbWyANaJOyIvLbXaIQcyuyxfhNgCIY9BKJ?=
 =?us-ascii?Q?Y9sT2pTvXb3co2xQZTNaNNn2vgIm8gT61vL4fVx24zEO7Z9pTkxqCqiFWA1n?=
 =?us-ascii?Q?/nLOieV2raEw9fTGkNVWzPeH1axUXbXv2jMDxuiIAC3v2PPaUOHIQ3OIYh0h?=
 =?us-ascii?Q?UITsXaknbvFmBbguHzxiHUb8EbLb+sirwJ6C/DEdiqiv1Rr7MA4fY8ll6Qwa?=
 =?us-ascii?Q?b9WO5aWZpWhEyP1b5LNWyKhGp9eEDqmzYhTf0ong5XJ3PE8w/iMX371nIufO?=
 =?us-ascii?Q?oKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8cU5cccnwN5/iXl0A0oSJGB6g6vVJ3Q6l92qskFgULeSIbxsJXx5hESzeKZ0?=
 =?us-ascii?Q?vBWHlgQl/TDNDEFWw/000seiqvgBKcA/qoz1Z/82G66kgLwjo6XBys9lMSiu?=
 =?us-ascii?Q?ZLrQhD0gyK2I1MWE4S0lkb1MZtmU3auZPT10eOs8K2+MxPl2tL2BqRCjxiqJ?=
 =?us-ascii?Q?sX1ko3YZB4aVlyCMYM3b/YwFXNbJ0B773zbXWkippKx7j5DjetUnjd7knoqW?=
 =?us-ascii?Q?85aBFq01t9MHdD2efP6ringzkMzMN/hGTPKPmH6S+CvCr8bR4zoL9uScKFDx?=
 =?us-ascii?Q?mZEaj5uUABamGPMzJB1RjmrHRUwcVNAhUW8tY4SfbDMJDuOxu6v42lJ5Bbu0?=
 =?us-ascii?Q?FqOqbQwkExpn/kt7sNazN3n/42816PPTmWqcJL+om7aTuqZmyCXwYPhxpd8c?=
 =?us-ascii?Q?UEqyqmUl0V2ik1n53xkZmGa3l/B2mQidV38kEa9ZMXIpxFn7eXNapGI4qv8x?=
 =?us-ascii?Q?5jEXGEPhoBP5033RBsi+o5IjV2OMoAmp+Hq7UMsXFeL/JcnIhmPOiaqcwmzo?=
 =?us-ascii?Q?hw1SnlLxKIs18pzVmtLakd2adieBr0mamNF1CaYISw1crNKORtUrHHDbHfXr?=
 =?us-ascii?Q?df/rMYBMDrjDtBxCYPSGyft0IOjW8BjCJj7+yrwRJg5AbmoAqpzHdLrzscYN?=
 =?us-ascii?Q?YArNHXHp2gijTLBQ62+l7nDcdbobIJZWThbh0ezMacuzhsGeN+VH/ClZ1jeP?=
 =?us-ascii?Q?JA8Hi54aGaxVLbvXBhUQUljx2hm+WxxhHObKdG/QSIghxCcoFk6vjXaxYher?=
 =?us-ascii?Q?Qsy1RyzfbPdG0oAmIflRxGl38LRwLyVn6w8GEqfw9I3gJIVuC9s40JITYHsy?=
 =?us-ascii?Q?bRwwg7Q08C/F5GPm71BhOqp3TwcdDANttWAR8OrjT3n0aUo69H/XVFdMVbK8?=
 =?us-ascii?Q?y/6AtX1pePbCLz/aTi3o3Sl+Lug3X0HHTfdoqEFOcxpKuhTYibDWl5N0SooX?=
 =?us-ascii?Q?PDBz434OievH6f0wjFmtgHegeosSlSAvbe49tCoMmr3qdfGVSRATqeUShZWc?=
 =?us-ascii?Q?rfHnYGO2CX7rmH3tpb4ckb8XKyQjNRCDoYzZc6MgjvNQMhAbS/e2+YpYOWBl?=
 =?us-ascii?Q?hoEndrI+4bY4hi6+h9YeqYW5fyvt7bZhiq36U1oT4ibrB/jPh8whIKWKHhuU?=
 =?us-ascii?Q?tYyUvtytuX32VASr/aa6pZR5FTzK/x/cahwTzJiom2PCa9PFuKWxEaria6HN?=
 =?us-ascii?Q?0ssP7hlrDZfS8MQdGhvCQGjrit/2izDibMV/i4UlatVghIzHyb+46PPA6lOD?=
 =?us-ascii?Q?q3WNjNqysNzcnEbyHmaCMbiBxMGihezP0xLRk/hBHoK44TgrAQZaFYaHnrBZ?=
 =?us-ascii?Q?aLgRoVcVYHmqDCsVIZnfcpgTp8Gqiye2JZ8EGo9ZtLy401TN+/AOo8MoeJsi?=
 =?us-ascii?Q?j7x3mAhpfs+eLksP6tVrBv2lW0O8ZFprF8vmVQYiE2LVx7kRElpRHm0NXa86?=
 =?us-ascii?Q?cz82K0j5pGNAoieU4fRL9Jza4NKVxFsUaYNc6iXeRwPuEExFIxO9vH4vZMvk?=
 =?us-ascii?Q?YSlqzjmoRpo2yzPAtL1Q/+t839gaVqNORvEclxlGVZg28iGVJvw7uJK7a2Ul?=
 =?us-ascii?Q?OkpM0qjg4GQqXtuFza7NZqMVwsJf+a4V0PHOfYnm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db5a002-632f-40bc-2c2f-08dc91c71ab0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:52:31.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nEfnJH3H3tHJGY/DbtLlYobIyL0dgByNiir7yf990UAPoYNNXGnixdFRQNDj+Yq4Xp3uy9UHpTEvHDagYkZfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8135

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

David Lin (43):
  wifi: nxpwifi: add 11ac.c
  wifi: nxpwifi: add 11ac.h
  wifi: nxpwifi: add 11h.c
  wifi: nxpwifi: add 11n.c
  wifi: nxpwifi: add 11n.h
  wifi: nxpwifi: add 11n_aggr.c
  wifi: nxpwifi: add 11n_aggr.h
  wifi: nxpwifi: add 11n_rxreorder.c
  wifi: nxpwifi: add 11n_rxreorder.h
  wifi: nxpwifi: add cfg80211.c
  wifi: nxpwifi: add cfg80211.h
  wifi: nxpwifi: add cfp.c
  wifi: nxpwifi: add cmdevt.c
  wifi: nxpwifi: add cmdevt.h
  wifi: nxpwifi: add debugfs.c
  wifi: nxpwifi: add decl.h
  wifi: nxpwifi: add ethtool.c
  wifi: nxpwifi: add fw.h
  wifi: nxpwifi: add ie.c
  wifi: nxpwifi: add init.c
  wifi: nxpwifi: add ioctl.h
  wifi: nxpwifi: add join.c
  wifi: nxpwifi: add main.c
  wifi: nxpwifi: add main.h
  wifi: nxpwifi: add scan.c
  wifi: nxpwifi: add sdio.c
  wifi: nxpwifi: add sdio.h
  wifi: nxpwifi: add sta_cmd.c
  wifi: nxpwifi: add sta_event.c
  wifi: nxpwifi: add sta_ioctl.c
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
 drivers/net/wireless/nxp/nxpwifi/11h.c        |  432 ++
 drivers/net/wireless/nxp/nxpwifi/11n.c        |  851 ++++
 drivers/net/wireless/nxp/nxpwifi/11n.h        |  163 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c   |  278 ++
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h   |   21 +
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.c  |  928 ++++
 .../net/wireless/nxp/nxpwifi/11n_rxreorder.h  |   72 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig      |   22 +
 drivers/net/wireless/nxp/nxpwifi/Makefile     |   38 +
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c   | 3773 +++++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h   |   19 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c        |  484 +++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c     | 1285 ++++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h     |   92 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c    | 1042 +++++
 drivers/net/wireless/nxp/nxpwifi/decl.h       |  299 ++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c    |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h         | 2262 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c         |  502 +++
 drivers/net/wireless/nxp/nxpwifi/init.c       |  696 +++
 drivers/net/wireless/nxp/nxpwifi/ioctl.h      |  445 ++
 drivers/net/wireless/nxp/nxpwifi/join.c       |  910 ++++
 drivers/net/wireless/nxp/nxpwifi/main.c       | 1726 ++++++++
 drivers/net/wireless/nxp/nxpwifi/main.h       | 1507 +++++++
 drivers/net/wireless/nxp/nxpwifi/scan.c       | 2894 +++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c       | 2646 ++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h       |  340 ++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c    | 3229 ++++++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c  |  858 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_ioctl.c  | 1320 ++++++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c     |  244 ++
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c     |  215 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c       |  362 ++
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c    | 1170 +++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c  |  483 +++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c   |  498 +++
 drivers/net/wireless/nxp/nxpwifi/util.c       |  751 ++++
 drivers/net/wireless/nxp/nxpwifi/util.h       |   90 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c        | 1397 ++++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h        |   95 +
 include/linux/mmc/sdio_ids.h                  |    3 +
 48 files changed, 34928 insertions(+)
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
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ioctl.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_ioctl.c
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


base-commit: 238d636723a30311e20fde0a361662e829fe488b
-- 
2.34.1

