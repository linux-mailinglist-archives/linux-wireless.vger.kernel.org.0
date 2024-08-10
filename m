Return-Path: <linux-wireless+bounces-11240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F994DA73
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 05:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C09D2849BF
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 03:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA6142629;
	Sat, 10 Aug 2024 03:52:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C341422DE;
	Sat, 10 Aug 2024 03:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261933; cv=fail; b=JZNtw8JztSjxCViNzfRczKt0fDnmhVTu+Gim2ShWr0wa6aQaJBR0zBVtVLqzvPnHYHg/TOzqmUneLctl6fZcANKrhZgK/IJoC5GAUExeeCrcTy+qY5rTNso4N74mjoBZtQUDgNf/WHSA5o5xFFyyflsfNk16dRCLW+UKO4971Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261933; c=relaxed/simple;
	bh=meqF1Wvps0tBqp8oYQKkPYhIElvNO1XtRvAkS8BhVtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X3e8OjoSI2uIbKlkJ8pJxD7O/fxpmCU2LXj+1Rc2OHhmkcHlv5Jp89/YBAyRdEb+HlW2VTTHesL7o+uIifclmhV7dQ8lxtrriSgQSK+t9ns01ECP1dNNxcGV0xmPhmBW7uXmM5a0bYEIUM9HMbOlEBtc4KC/UdjyFswkoZn8o4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDujevKkekqGAehSBi2bKmP5gwPjh7bvh5oYKzC211v0p5OvwgCAAkZZ9NXpon7OnwDk5JUwX7Xy7GWADN5Y2N8wr6GVKY4SOPWPhM5yMFeCb7f2pJOZmGgOlEI2btY1iqxj6+3fQKAeWYAi0Rrw1ExwE8ayYa5h7ccxSG5kr5ml4V53TdjkVrksWLChxy/AHlesKXaUjAOiwP3BtxRQbSNpXedZq7Xmf0yE0x4h8T985LGdcHlB/jh/AhPcSYJznlQKqMBkAOzSL22DK+OwZIaBG6V+06rx+X9OOQEI+myQ9aT1EZbkhgC2aPHFL4QRMlxUboRNOsaWHQyLsC/6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdnQ3KH8JYSLAZVz0gxmwKq2xEIvMZdzGeLJyXtGqzo=;
 b=LsgABiM+ESUuS8hgZisPehBKp+a7bqUppvAbhgJ/Sif3paI31pvjNG1ohy93I/32S2I1J6q+WOAy8aJRFGP8GY3GeJTr7M1sWSt1OipAenzHP9/22Jq7EMS71GK/Ll+Z6XKbAgW7g3DVFZMayRApWu8PcngED25agnclGQ707jYpxPoWFuAo9bzJ/gcMsNRlrvHWX59Af4lys6fFh0HtIdbQWiUkDvZxdTFe+yLRDmwm7k2pCs5XcC0BlN6iJPPpxRLsT9SUyo9/Z/DTch+SdvCe/1jmowRB3CstP0kMIgwySrTN0xuNu4b6MIjtPPVOotjdfSOYb0iYXIs+io2ANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB8564.apcprd03.prod.outlook.com (2603:1096:405:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Sat, 10 Aug
 2024 03:52:08 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 03:52:08 +0000
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
Subject: [PATCH v9 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Sat, 10 Aug 2024 11:51:40 +0800
Message-Id: <20240810035141.439024-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810035141.439024-1-jacobe.zang@wesion.com>
References: <20240810035141.439024-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:404:14::32) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ac9594-7d39-4f43-3395-08dcb8efce6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?279823OQZFHQj0GbvjvU7FzB5pzLsHImYZanJu4tCY7sERB++YcmWY5fLd1T?=
 =?us-ascii?Q?7lqLLXpr8U+lUf/S0mwNsLtWZ34+zK9I20NGIhxUgXRD7sBVl74VeMLJC5Ho?=
 =?us-ascii?Q?j6g2kT6aXhJEmTCY2QS9praf62eJ6kjTb1GKMliRiGurPImaI07rlOmKXkhS?=
 =?us-ascii?Q?tYCVsPAZsjXnSF/1UgHGkfm6cTeLOBWIpiWYlAuoDRLyVqNk9068uPtmH3cL?=
 =?us-ascii?Q?PwjsrctaLlWmwDD4zLMd0NVyComWOwFoH+deDFONKNGezCuZLvf1/RYOlgyQ?=
 =?us-ascii?Q?vXOaCSbYncN7C+qF2+F0P1sh1PaZNyWSBEjYuGiB2qODV3t8WsqDalUTo8Ls?=
 =?us-ascii?Q?Fd6aFprKRAs/Glpkqq3TgN6WCjQ+mNd/ryUy/zyWiYsn0mx/ArMk2zERTD5a?=
 =?us-ascii?Q?16j6vlc98DDGJzFIk1EUYblAQf8Dihtdg84sF49f/cxs8SfmZ5Tjjl7HcmxD?=
 =?us-ascii?Q?La0ZgVFWtoEtsJGKgullNJ1gwBWr4kD0NT503DjWWQv1WT2CJMdPyhHR+Tp/?=
 =?us-ascii?Q?wqVdk8soihC5v5BrSVZqjeGevZmms33LPE/e4e3bMCB0Os6EBbTRIb8wH/70?=
 =?us-ascii?Q?gLN3nD0otpbmQsfmd44Oy56DQ1brdR2SBE8EPmx0pvTtOAkAIDAs3Y1Ek7LF?=
 =?us-ascii?Q?Skmdj7Bn3OsP/VIi/X+iVPcxy40+BUAA+pdrSAQmEUt3hWUjd5K+YK2Dmc9Y?=
 =?us-ascii?Q?ec65LLNuidzD71JaHAaOfRcApJWaWy8Tka4dkFviLGgzvxOe86b6P/zysWX7?=
 =?us-ascii?Q?aTu8zj7TI8BoNISc3ecnyqNRLCJwTXb04jpOIjZVoiQ5zL3pU6e9TFvCFyWW?=
 =?us-ascii?Q?GEEe9IQr5woAFzWPkojJE4K0YjL6V5HFQLkCop5cQHPgn4lQIG/1C76nPKjR?=
 =?us-ascii?Q?b0XWCKf9F7KZshoCCP1MLv5rW2SqJhm0d4PLVtTIMC4Fr5j03HfLXnEZuqRW?=
 =?us-ascii?Q?BOQ0ImzTXXykt8r4SE0qgEEKEqnkCJGgTZrz2K9fK0vngGP+CCmzdpFwJWfJ?=
 =?us-ascii?Q?zkZJjSuWuqs0Hlh/jI5kYztCyD7lcHnex23Yo9nwZaZ2CrZB0uS4qVpW34Jj?=
 =?us-ascii?Q?ndfWeoeguIQFxGWIal9FTTs1rTG0ccRlrVe5OTODFcMuNLzWxWxqg+aYiiAI?=
 =?us-ascii?Q?SZilARBvvhlrCqreYQY1SFz5fLhKnPPreSC9MEKmV8KQabKSfvlILpnJ67qv?=
 =?us-ascii?Q?o0bMdmHU6kOeV8sWw1NKmE+2tRQqGV9/6Fr77JmTCdrCCt/g0onbEFvEIwS1?=
 =?us-ascii?Q?KFDq9rIEck/P/Twe2YJ+SOXmpRFWwVtXzVReNfWb03wIIxycuBYZDrCwjx3z?=
 =?us-ascii?Q?Fp9f5XzHRm1YuK5PTA/e21GTAthKtawyOLHL+EaKfRzs/2sXcVwf8owU9UlN?=
 =?us-ascii?Q?XeiXqOk3IxLPaoyyUbNsojhBmEKDC+q5kPRI8pbenDtYp5euLXcmHsOmYQIx?=
 =?us-ascii?Q?Oh62O/MM4wM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uq3SGWIr79qTiCl1md0iHG9D6HdHi1IxKXo0uxp4LyISVxho+6XJJ9swXZBe?=
 =?us-ascii?Q?xYSCyDLJRKk/v3He4M4nwaPfb1TBzxGnvcQ9KYZ3UJbDRZH4pJRrcNmLISti?=
 =?us-ascii?Q?4nFJwaW+mUbIGW8aTT4y/mb4CnB49KkG7Gkq/fO9jDg5AtdQwWu3AITVgJ57?=
 =?us-ascii?Q?00D2o7RxGfx9hgQvCZtoQTlw5haZd88luY0oLi6TnEO41co8ThPy5vu6BowW?=
 =?us-ascii?Q?Zjk3CdYvH23Z6o2zH1TzyjNDqPVfYmlZPq3KmYVEaRdVOD+M+yWEB+QemaFJ?=
 =?us-ascii?Q?xA6stj6kxtDC6kcZJ1z34msJr9aZ2GMs757QwJIJAzW5xlQEI3HGp5q6EJJJ?=
 =?us-ascii?Q?FXP5lTCAb8z0U9fGOBVc6lt9b+A7V1vApKvIRaCF8RszSquzuL82vAGnu/Cb?=
 =?us-ascii?Q?b2PY2ffwWzt/4UhSGAKjpxAMTxOYKLj7Nl+wAi65ZKDQJhXyu8k4pcPxReMY?=
 =?us-ascii?Q?oy2S+2iz+Huo4uXjWFakvrAuedac1jxI5SiNBrOuz4n+rAAI29v9iDZblViS?=
 =?us-ascii?Q?0ERY4NdbbKLRYckkdLfO1F55dTGAjFpPDlvNlhRbsD8vxohclqZM4Fw01t6T?=
 =?us-ascii?Q?nXhVEAEfMEONYzz/MkF/QP9jCvqGXPTZFrkJHNyspFDcCRU9uD4uggVuZPVF?=
 =?us-ascii?Q?0N98uGEIxhDb7O0AhZMiHb0/p9fBh7iGAR7xNlk1kdJnV3ShBtFOQLkbVwG8?=
 =?us-ascii?Q?1mBro9SLhUlsNV+JQ5FgABjkSZ8Nz91xg1Acq6qz/cLtjiPl8BmrgdQqmAB1?=
 =?us-ascii?Q?ZoI1s7989y7cJ8Eu8FJwKSB/j9UfaWKMitbA91Pif+wI201pFl8bZhgo2rG5?=
 =?us-ascii?Q?h5DR0xGGBzkQjIzOn6gdrzd1pdcXhcTA8OxOIe7owU/7+P8xT9nMxdWTnYQq?=
 =?us-ascii?Q?N+0czIjDXMskpAnm6aS4NsNAsfi2HrLZSOtEM55xFyUdG8w6GMcKkv1DnWss?=
 =?us-ascii?Q?7dmQaPAwU9a/MEsdSBLf6tvchjYgOUWlLoZPpmRnP6BRb8QqylL869OF6S1E?=
 =?us-ascii?Q?ZKcbTHWfVr8wQTwv7JL39gh2M/o4HroNoZRxZ6esf9eBlsDJNaGGvDi0U4cb?=
 =?us-ascii?Q?UuwxxzqUzbThLVguH6i12vmHh05j72+bIgo2OWLTdcGiGfiVVd6oTBpa6v0P?=
 =?us-ascii?Q?WRJUZFs6cuqEaWR5RXBR3w00SSkfZe9GgN8ZYj3msRc2iucy1YipcgqzyCCG?=
 =?us-ascii?Q?2KDhRoelkoMO/6yK8IKivvFLXRf0S5F7OQWPMqLRIul+xj1IEvfL2UiCQgYF?=
 =?us-ascii?Q?SXJxxz429bxnajtJ5YwPNX6reepgAZFU+juEaidp9L3kn/qAlHf1BQWTfSFL?=
 =?us-ascii?Q?eKA58SRw3K/qwoLsOhIufa6WfLE19OoeQSfkVdf1zJF6cyg3NYMiB5hTFnXK?=
 =?us-ascii?Q?D+7NoN/xa3HLtclBBS4ICVBW+g0OYd2QK7y+UXMITZlS2eYYsLNu4PuZHAbb?=
 =?us-ascii?Q?y3aqpM3u/PN7c9Mo4Arc/VnTofoROd89ZZeJjfXb4cOYUErI5KovRmqDJ5Li?=
 =?us-ascii?Q?lHXYowmlNV2nFBntrHZcGnSHoQE4SmCR8IUWXjhR/pZ0Kc3JmXMgOQ6RWF5V?=
 =?us-ascii?Q?P/DbOydHSg8QcxUVap28YhHpkar09j9nHTg4ugkr?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ac9594-7d39-4f43-3395-08dcb8efce6d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 03:52:08.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVMgm2dhsAsIHjCj9nBv+B2X+h5WgYroSjSWy869mpj0aI4dohdvU3JRb/xQivNwyZNjSTaTyr2wKRZy5ylICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8564

WiFi modules often require 32kHz clock to function. Add support to
enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
to the top of brcmf_of_probe. Change function prototypes from void
to int and add appropriate errno's for return values that will be
send to bus when error occurred.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +-
 .../broadcom/brcm80211/brcmfmac/common.c      |  3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++--------
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 ++--
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 24 ++++++---
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
 7 files changed, 63 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 13391c2d82aae..b2ede4e579c5c 100644
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
index e406e11481a62..f19dc7355e0e8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_net.h>
+#include <linux/clk.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -65,17 +66,21 @@ static int brcmf_of_get_country_codes(struct device *dev,
 	return 0;
 }
 
-void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
-		    struct brcmf_mp_device *settings)
+int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
+		   struct brcmf_mp_device *settings)
 {
 	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
 	struct device_node *root, *np = dev->of_node;
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
@@ -105,7 +110,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
 		if (!board_type) {
 			of_node_put(root);
-			return;
+			return 0;
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
@@ -113,33 +118,39 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
-		return;
-
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
 		brcmf_err("failed to get OF country code map (err=%d)\n", err);
 
 	of_get_mac_address(np, settings->mac);
 
-	if (bus_type != BRCMF_BUSTYPE_SDIO)
-		return;
+	if (bus_type == BRCMF_BUSTYPE_SDIO) {
+		if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
+			sdio->drive_strength = val;
 
-	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
-		sdio->drive_strength = val;
+		/* make sure there are interrupts defined in the node */
+		if (!of_property_present(np, "interrupts"))
+			return 0;
 
-	/* make sure there are interrupts defined in the node */
-	if (!of_property_present(np, "interrupts"))
-		return;
+		irq = irq_of_parse_and_map(np, 0);
+		if (!irq) {
+			brcmf_err("interrupt could not be mapped\n");
+			return 0;
+		}
+		irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
+
+		sdio->oob_irq_supported = true;
+		sdio->oob_irq_nr = irq;
+		sdio->oob_irq_flags = irqf;
+	}
 
-	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		brcmf_err("interrupt could not be mapped\n");
-		return;
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (!IS_ERR_OR_NULL(clk)) {
+		brcmf_dbg(INFO, "enabling 32kHz clock\n");
+		return clk_set_rate(clk, 32768);
+	} else {
+		return PTR_ERR_OR_ZERO(clk);
 	}
-	irqf = irqd_get_trigger_type(irq_get_irq_data(irq));
 
-	sdio->oob_irq_supported = true;
-	sdio->oob_irq_nr = irq;
-	sdio->oob_irq_flags = irqf;
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
index 06698a714b523..c34405a6d38b8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -2457,6 +2457,9 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
 
 	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 6b38d9de71af6..461b7ff3be24b 100644
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
@@ -4446,13 +4448,16 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	struct brcmf_sdio *bus;
 	struct workqueue_struct *wq;
 	struct brcmf_fw_request *fwreq;
+	int probe_attach_result;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
 	/* Allocate private bus interface state */
 	bus = kzalloc(sizeof(struct brcmf_sdio), GFP_ATOMIC);
-	if (!bus)
+	if (!bus) {
+		ret = -ENOMEM;
 		goto fail;
+	}
 
 	bus->sdiodev = sdiodev;
 	sdiodev->bus = bus;
@@ -4467,6 +4472,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 				     dev_name(&sdiodev->func1->dev));
 	if (!wq) {
 		brcmf_err("insufficient memory to create txworkqueue\n");
+		ret = -ENOMEM;
 		goto fail;
 	}
 	brcmf_sdiod_freezer_count(sdiodev);
@@ -4474,8 +4480,10 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
+	probe_attach_result = brcmf_sdio_probe_attach(bus);
+	if (probe_attach_result < 0) {
 		brcmf_err("brcmf_sdio_probe_attach failed\n");
+		ret = probe_attach_result;
 		goto fail;
 	}
 
@@ -4546,7 +4554,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 fail:
 	brcmf_sdio_remove(bus);
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 /* Detach and free everything */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 9a105e6debe1f..f7db46ae44906 100644
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


