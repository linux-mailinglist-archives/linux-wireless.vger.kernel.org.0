Return-Path: <linux-wireless+bounces-12109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2A961D2D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 05:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07851C236E1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 03:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5EF15530C;
	Wed, 28 Aug 2024 03:49:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2101.outbound.protection.outlook.com [40.107.255.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2943A14BF8A;
	Wed, 28 Aug 2024 03:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816999; cv=fail; b=nKUiL3EfaFu1Hcx4v7jjTKTBzWAeMiWd3WmqV+ObBPrP0nVLrNzQ9t0q46WTliG1ChKymy6RiAZDXu+D5mTN+bHe1zAk9nOvCsswFJMtLKOdRSN4KChjogomZMIKDa0Tced+MJt6LSiyiuvATDODqYJ/AxVBSUgvjkxtTNlItu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816999; c=relaxed/simple;
	bh=aQvU1H1bz/roJ9mCuqhAqDEeD+kqdQn4UHfZEiFgd58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lSxBmhGHBB1Z1xr7xZ01bpQ2zVtgp7RFR8xl/ENdK4HlteTPlEhAosm17ThcozcI1RKyImQ16GN2VOoQddDOekTVb8OAT1JoJnLr5isphjU75PF06xTEebOOV4die5L6SeS53myUci8KxWnJO9wUqUxxf/Vahq44HHPu7Kpyc2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUmTOkLvHyV65XjPC1+DUbjPigJLFKQkw7g8syq6RhbwH9S3VYcSN3uZpTTfKAhPvC3zwQ2lG+TELRJzZDCAxuhNC8kL2tpCVAmRd7uQj5e/51kB6bHBBU9bGqgVybDSmfezHJICbUOpMrE/Hco7E7gFzHEcn7y3eFGnWJOGRRyw3avnsmHSq7Mbh4q9Biuu++NWshGevarUZi0Qi6SLCvq9xGzSAHX7vpI//QoD4HQKdCmcZ3+2V5TNPqB+7OzI2dh5uQLb8T8g/g8DXFVdV2b6YWW6y9rsSLlgWAbH3UCLbe0Vb9lRTP1Lx2d9eMQDrNePyRrZfgON0kCKB/JxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHkiPmTfCGL6lb2qYDJpA+PP5vnYSg9s1MRyJcxUrys=;
 b=vYhkQCOOibGR2C49jLW7OL5MFIz2Feyb2eMJfrqKPbeOuJHMhhHNACkgc03LZEfA4ibKsgaEt4QgV3BzHKvlFRgDJTb9C+2nmvGsZl9XzGDTGRy6EuxoGpYOrfF4WtegCDT4gKIOLnlIh2j5sIvOIZQseV8yy8FPhkdqRgePLlNBAL9t2LXiU1D1/CTExPbj4Cxbg4EBLcdTv4j1NQrxGLhWj+o2alguzyUVnLcngO4BI77RWZJkIWheGePSbzhuM9/YSJ2zK8JVJBocG4heGwgaMKP9iXWrLwphakMRsvTbEpI6FfJ9BtJsvfBUlaS+M/ocEuLexXI/Yhtmlq3a+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8233.apcprd03.prod.outlook.com (2603:1096:990:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 03:49:54 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 03:49:54 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	marcan@marcan.st,
	sven@svenpeter.dev,
	alyssa@rosenzweig.io
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	saikrishnag@marvell.com,
	megi@xff.cz,
	bhelgaas@google.com,
	duoming@zju.edu.cn,
	minipli@grsecurity.net,
	yajun.deng@linux.dev,
	stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	christophe.jaillet@wanadoo.fr,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v12 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Wed, 28 Aug 2024 11:49:14 +0800
Message-Id: <20240828034915.969383-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828034915.969383-1-jacobe.zang@wesion.com>
References: <20240828034915.969383-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: f54dec6a-39b7-4f45-7eb5-08dcc71479fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IX79dHDQ7o/S3s+Y8wHvY53C5wHhZqPyaXIS+7EhWbioxu1a/v8kR0Mozhcn?=
 =?us-ascii?Q?jT3OrVrTweNGTqEn/JvMuCfHJZs/Oh/LK3c/Jrln7td0p+nMPspl761pmQSR?=
 =?us-ascii?Q?NDn3v7P1khRFPV0j8UQhlommqJryd76h7vLHadMVa9sJRUxGvTSmbSJDG0bc?=
 =?us-ascii?Q?80YldLkB+Ltn6rluBK8f+ykLXE2LCAO+FRlGi/K9NbXbzQRK0ecRH8rByGK2?=
 =?us-ascii?Q?G1EVzKycQQHP4W8f0i5jKq5i1qh1+/lP31TiFbX1lABgrLTMnO1sDMlYv0wX?=
 =?us-ascii?Q?gtUIcbteIlp+rTLECgYBMgbaxg4Qf5QjWQ0s/JaFbSz+IBae8A7Alfs8BKIb?=
 =?us-ascii?Q?sZ8J0VdSOvzU4NhLrK4JmV0Vpn+3RpQqBpwXtuoqSCicQboCdoh9u6Hx8NYQ?=
 =?us-ascii?Q?uuWObbv7W8jVTYnQ4hoWoetvCXB3/DZDc//XmtH534XwoVGjowFLM8LHHJlt?=
 =?us-ascii?Q?9Sbjhd+CB1aSAJmjE76EEPDKhW/PQX+fYH4zHEIcbcEsjOgbzcUdTRiiRxiG?=
 =?us-ascii?Q?bao0it8u+tKfg1X3o3as/wvqxHCceI/7KxgUhFD1XabZAtLyfxTwhvzEI7fU?=
 =?us-ascii?Q?qbaMAWuyGK84jGOxTKJVt2F638PJEqWGURTm0oOZH+uWP77uTeqpbA85okx2?=
 =?us-ascii?Q?4jz0Tv4cwbk22NRo/EZiu52a5xDueD6KcaYeyknvSHTNqLjrJhohx4lU0kN4?=
 =?us-ascii?Q?5vpX24a5E6mXgMMj9W0iCsmLIoTw7pUcuQsaSrePl7AliKf5ofI7jjebV5Pq?=
 =?us-ascii?Q?/ps7xd50RqkXeocKR9ozco90UIdrDryc+y+yF08QTuBbcf1XY65yBH0tiulv?=
 =?us-ascii?Q?sPQQpzL0Wluk4P4ejpQ1jU/zx+oKU7yGkv7dnFERaY+GpR/8Snang4IV/UFN?=
 =?us-ascii?Q?oAfbJtAIuZbmTrNf2U8nGUMgWmhEpIJggDmN34Q2MxnaJih+cvgR77UFPkvy?=
 =?us-ascii?Q?Lyv8SGOKF2ubF+QNkXDOMb0S4mdep8RLWipGxN5ceDsTjIW/LG5hRZAWP+RE?=
 =?us-ascii?Q?+rZLoWV0P9HP5viAVX8YV0n4k0cLFA/Vj+cTpn3KmaMbYflVxbBZxy1rtEjf?=
 =?us-ascii?Q?63O0z/KQWjIs/dscxbXxF+q+yaIbTWH7VG16BoTVNFdFAJVryLBer+tJYQrY?=
 =?us-ascii?Q?zvfa8ORzG3X5yZ12mpoy3L9qW1nkX+vTLVbEPpdfO3MLlM+JoJ/pFoubdrEt?=
 =?us-ascii?Q?DqXnYjZYPNoCeAl3NemicgCU4sDDZKO54RoDeCvG+p1XfjJ6UUJPYmHfCtqZ?=
 =?us-ascii?Q?SVeznVc4CfMCD9WJcJFpf8t1zPZw+1wrq8sBmIKgHYPEC0H3qsk+rhbdv9yb?=
 =?us-ascii?Q?FE1qFidtWHDm3urQklxGLl8NViOOhguNdfDhSjU5jxm9d3q0wwzV+jq2wfVA?=
 =?us-ascii?Q?AMhj97R4HXfEe79DkySPAZs7L04/AcwXa0PZgxjuKHXakXvdDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9pRJtJLlD88Pf9eyjAXsid6nvY2CfnAHs2vLdwrihqUiV2Mo2/S7/y6gbZn9?=
 =?us-ascii?Q?zzsB1oei7t5bYe9EZ2NwbhA/n3Z63BmQAageWDYoOH3++caG6OcmQhtKFHEV?=
 =?us-ascii?Q?d5B4vXmQA9lZbUb1xvh53j0HmsC840dUmGKUAlT3uzVVTHQ4cZOQUdJt2dqt?=
 =?us-ascii?Q?0uwoHuvKhdPzTJ5MEm8IfzZ8Jgl9aYBLVN8czi89V+gmPJPV7rJL1VYfzBUe?=
 =?us-ascii?Q?SsAEUyzcCRAsC9sEQ/cEiHe3tNsJuNQg4C5MxO+tTf67qre0LBDhzgoLs91a?=
 =?us-ascii?Q?5GNAXypr9sqZm1mWSq1PQ5jbdRCrmjC8N6kRun/LVN7V3aUX9qfPsjjW7fKU?=
 =?us-ascii?Q?tkmipIl5b8474cjPJBKmUk/mgr0dj1HQXi40OtYKcaYDeJiHrTRYTzq1wFCN?=
 =?us-ascii?Q?5NMw3xYtu25SXBQEtzYcIIxpVCdL4w5umLLNFAF5Iko7jUmVDJiOVNo9vuzc?=
 =?us-ascii?Q?sirc7VexL5kUWlOX3FCuQqp960qbLk+TU6kmJcqHjXqLUh/5Rk3D0XMmcexb?=
 =?us-ascii?Q?ZDdTw8Bwe4B/tz3ue8wUS0XjXp1LnLpRhXHNIiKQi7+YDz9BJPJkXIHefeVx?=
 =?us-ascii?Q?tlnP4jqbSBbAC+6LeKlkXbbijY20J49baugnEl26d2EQu0QweAUCuTCK+IkH?=
 =?us-ascii?Q?M51B+mJptj6aw0BHaDH44EcK9iYGyUAqs4MDNrO4wBtCj9UO1tX871WTRUbm?=
 =?us-ascii?Q?p+6Kb7wBBIXm/LV8XyoXNVrfrLql38q7d2uJdnl2pBOLG9dinenvrwIqmv8C?=
 =?us-ascii?Q?ViTCkftMNhU7ZYEiMqWxWV2/N3zRkrR9gFh/lxG+h0qVs3+IXS7+q3ZguEgJ?=
 =?us-ascii?Q?Ugsu6ujR5vZc+as+T4XyV+QFz1B2ME5GRNnZQwrVsEsPBpSZlLh/PjfRRunP?=
 =?us-ascii?Q?7ExAhizqyqaVc+XuNRHol/nPne67YmwZ2J5CevlJilj4S0l7jCE1OdyRSQrt?=
 =?us-ascii?Q?JBk6wD2OmLaTpsg2i/AHfblhSHAu+GoKuro1zJafjuUvNcv2u3Ym77q+newF?=
 =?us-ascii?Q?dMlLKFtnE6OlUhLsKIhgvOCn9JeAlgs2HU2SNl51tKCtl3DLtt0dwgm9uhb2?=
 =?us-ascii?Q?0lPIxWTCZgyTLVpWQLHIMd2LlS0FPa6/LYfY9wNJz2+rUZBjSds+LkJSGdNd?=
 =?us-ascii?Q?/8zWpDDuUKFFHq8/noXUA3wBUrQmujNrySb7FHtUkJWvbPq6sU2rb0K8Lf+j?=
 =?us-ascii?Q?87EzVRaW4DCFBHvN369GQlPeu6al/WroWRkiaEt8Lno2Dt9iWzJvL5GEshYn?=
 =?us-ascii?Q?iJqbbJrnlU9Jsbijp+fWt7TWDPTZeGySOvkgFdC1ctxtdEXpOzKXFY1VLpSt?=
 =?us-ascii?Q?13klHbnDlwK+CgsPwuxpnttatGfsUcEuowHmQnWLWZqlDCpFbL+VD5HJcSxc?=
 =?us-ascii?Q?ueVZ437COeaF/Kmspk5oTgU87E1dYwANbcIvS6G5JYJKIPHHwuLjTH++YAhC?=
 =?us-ascii?Q?qjj9EwbknJrUKG22ObgwTSkWotpqX2drgQ++o4zd1Upxf4vRulF8ww3GQ3xD?=
 =?us-ascii?Q?X+SJHkZsPqWqiOp/UNK8HXIVV0JHrxC5Spe01fmG5uL+gPBqfCHbZCUv2lGz?=
 =?us-ascii?Q?uUHibJ5Pp/s4RzQEU3HUnuQpIy3yuvpeJGD/igB/?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54dec6a-39b7-4f45-7eb5-08dcc71479fa
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:49:54.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcIocNrlTPfVzqi7ct1kOZ7qG0fqtmL/PQ9OTluEQiGbI+4eLmklWhShPEnrHnGoOseltk7diHr9qtYfvB2xjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8233

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe. Change function prototypes from void
to int and add appropriate errno's for return values that will be
send to bus when error occurred.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +--
 .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 29 +++++++++++++------
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +++---
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 20 ++++++++-----
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
 7 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index d35262335eaf7..17f6b33beabd8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -947,8 +947,8 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 
 	/* try to attach to the target device */
 	sdiodev->bus = brcmf_sdio_probe(sdiodev);
-	if (!sdiodev->bus) {
-		ret = -ENODEV;
+	if (IS_ERR(sdiodev->bus)) {
+		ret = PTR_ERR(sdiodev->bus);
 		goto out;
 	}
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873d..58d50918dd177 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,7 +561,8 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!found) {
 		/* No platform data for this device, try OF and DMI data */
 		brcmf_dmi_probe(settings, chip, chiprev);
-		brcmf_of_probe(dev, bus_type, settings);
+		if (brcmf_of_probe(dev, bus_type, settings) == -EPROBE_DEFER)
+			return ERR_PTR(-EPROBE_DEFER);
 		brcmf_acpi_probe(dev, bus_type, settings);
 	}
 	return settings;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index fe4f657561056..c1285adabf72b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -65,18 +66,22 @@ static int brcmf_of_get_country_codes(struct device *dev,
 	return 0;
 }
 
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings)
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings)
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
 	struct of_phandle_args oirq;
+	struct clk *clk;
 	const char *prop;
 	int irq;
 	int err;
 	u32 irqf;
 	u32 val;
 
+	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
+		return 0;
+
 	/* Apple ARM64 platforms have their own idea of board type, passed in
 	 * via the device tree. They also have an antenna SKU parameter
 	 */
@@ -106,7 +111,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 		if (!board_type) {
 			of_node_put(root);
-			return;
+			return 0;
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
@@ -114,33 +119,39 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
-		return;
-
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
 		brcmf_err("failed to get OF country code map (err=%d)\n", err);
 
 	of_get_mac_address(np, settings->mac);
 
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	brcmf_dbg(INFO, "%s LPO clock\n", clk ? "enable" : "no");
+	clk_set_rate(clk, 32768);
+
 	if (bus_type != BRCMF_BUSTYPE_SDIO)
-		return;
+		return 0;
 
 	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
 		sdio->drive_strength = val;
 
 	/* make sure there are interrupts defined in the node */
 	if (of_irq_parse_one(np, 0, &oirq))
-		return;
+		return 0;
 
 	irq = irq_create_of_mapping(&oirq);
 	if (!irq) {
 		brcmf_err("interrupt could not be mapped\n");
-		return;
+		return 0;
 	}
 	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
 	sdio->oob_irq_supported = true;
 	sdio->oob_irq_nr = irq;
 	sdio->oob_irq_flags = irqf;
+
+	return 0;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
index 10bf52253337e..ae124c73fc3b7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.h
@@ -3,11 +3,12 @@
  * Copyright (c) 2014 Broadcom Corporation
  */
 #ifdef CONFIG_OF
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings);
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings);
 #else
-static void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-			   struct brcmf_mp_device *settings)
+static int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+			  struct brcmf_mp_device *settings)
 {
+	return 0;
 }
 #endif /* CONFIG_OF */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index ce482a3877e90..190e8990618c5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2452,6 +2452,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 1461dc453ac22..59c77645e2183 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3943,7 +3943,7 @@ static const struct brcmf_buscore_ops brcmf_sdio_buscore_ops = {
 	.write32 = brcmf_sdio_buscore_write32,
 };
 
-static bool
+static int
 brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 {
 	struct brcmf_sdio_dev *sdiodev;
@@ -3953,6 +3953,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	u32 reg_val;
 	u32 drivestrength;
 	u32 enum_base;
+	int ret = -EBADE;
 
 	sdiodev = bus->sdiodev;
 	sdio_claim_host(sdiodev->func1);
@@ -4001,8 +4002,9 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 						   BRCMF_BUSTYPE_SDIO,
 						   bus->ci->chip,
 						   bus->ci->chiprev);
-	if (!sdiodev->settings) {
+	if (IS_ERR_OR_NULL(sdiodev->settings)) {
 		brcmf_err("Failed to get device parameters\n");
+		ret = PTR_ERR_OR_ZERO(sdiodev->settings);
 		goto fail;
 	}
 	/* platform specific configuration:
@@ -4071,7 +4073,7 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	/* allocate header buffer */
 	bus->hdrbuf = kzalloc(MAX_HDR_READ + bus->head_align, GFP_KERNEL);
 	if (!bus->hdrbuf)
-		return false;
+		return -ENOMEM;
 	/* Locate an appropriately-aligned portion of hdrbuf */
 	bus->rxhdr = (u8 *) roundup((unsigned long)&bus->hdrbuf[0],
 				    bus->head_align);
@@ -4082,11 +4084,11 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	if (bus->poll)
 		bus->pollrate = 1;
 
-	return true;
+	return 0;
 
 fail:
 	sdio_release_host(sdiodev->func1);
-	return false;
+	return ret;
 }
 
 static int
@@ -4452,7 +4454,9 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	/* Allocate private bus interface state */
 	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
 	if (!bus)
+		ret = -ENOMEM;
 		goto fail;
+	}
 
 	bus->sdiodev = sdiodev;
 	sdiodev->bus = bus;
@@ -4467,6 +4471,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 				     dev_name(&sdiodev->func1->dev));
 	if (!wq) {
 		brcmf_err("insufficient memory to create txworkqueue\n");
+		ret = -ENOMEM;
 		goto fail;
 	}
 	brcmf_sdiod_freezer_count(sdiodev);
@@ -4474,7 +4479,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
+	ret = brcmf_sdio_probe_attach(bus);
+	if (ret < 0) {
 		brcmf_err("brcmf_sdio_probe_attach failed\n");
 		goto fail;
 	}
@@ -4546,7 +4552,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 fail:
 	brcmf_sdio_remove(bus);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /* Detach and free everything */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 8afbf529c7450..2821c27f317ee 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1272,6 +1272,9 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	if (!brcmf_usb_dlneeded(devinfo)) {
 		ret = brcmf_alloc(devinfo->dev, devinfo->settings);
-- 
2.34.1


