Return-Path: <linux-wireless+bounces-8067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DEA8CF4D1
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9B81F21108
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2817C61;
	Sun, 26 May 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fJ1wL3pX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2080.outbound.protection.outlook.com [40.92.74.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341C17BDA;
	Sun, 26 May 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716738836; cv=fail; b=o7pPA0WCgwHQJiotEKvYiRD1jv6vxDelX5HpYcCMLuXrzeONDq/gf5vp7zQNdgkqqdlHAD3EQ2zJ+IkvKJpAByMw40yFgLCFgx0y5+v+/JD4lJKKfZudKa1BpVDsYwUHn7/7+3PODAWfMYzapAMQ85hY2gV+KgmDGv3+CsUWdK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716738836; c=relaxed/simple;
	bh=bGl+cZdEw7TEOUlR95vUSFWfEFJ/b8QEHSRdZ++DZ/c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZuNpYWVaWyt9OdkI7cM0pIxx78xe3UgPt6uBSj4E/JFzOy0yAJO1zFuX5wbAUA8uMFdRd9VBoaCYvLMMe6AVfoENYYP/Q7JNTD+PhmEhPP69wfzJwtYO9KbwskhSHfzTegHJgy9SgyDACtq3h3Hzd3tOToNgWmjiHeK7x1RlQbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fJ1wL3pX; arc=fail smtp.client-ip=40.92.74.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnQ6/pqT4botwRxp8U00U0m2pdlox+GZZ5mbiKbs+5HUOOrruNtEs7r5YRQRGUKoSC7Z+rWfHM0ZUABY+W48bRPj7eI8XPqGkJ/jfxDiqFCT9j5o8/mYlrvc7p6q7ETUz5Wbjpy+OF0v6xeKjvzym1gTfJveNrL941Z5ae6qHlDsO/f36KtF7wnv6Y7JC8EnBuC5ODLjPZoiKxBmHoGFFVrQeowIOTc7SOiUBXLO6SrOTPpRKsFHC9BDR/UPAXuS7BBgZMKc8k2B8dJ3XwERp8kml7oVrvjqtnIsE46fQZlrN/6seaCK73BGU8D3yhWTgCXCD25UYCgYUM7+ce68zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UjF533ne+R29oKLdkWmIC0TlClWGbaMuVjAVoDlBjQ=;
 b=KZ424co83lfv2Xn7nvjscBglFsKepcKDQtO21lREoIHLJhZkJbeP9hIDFqzG6lSgK5sIv6Jaj2xf/sxdHemz5uB9MZm+Zmz3/MrC8uXO8blgZlHCIYRol3sU79y0sImVW4CKw4QCf6zyxppN8/npKK+6zxr150DSTkAU/9pWinEwuSnZWred1mYhBM7jTHf+MqIZfXP/Hvj643gPbw3TMaSHIu4pMR6PfAmVx7FmT8Pssbkf+XGZf2VuXELSAA75aQ39MQMWscP+mdOK6iz5sW/oQFJFkK9L8FJz0aNslIsdRhg3tFZxikapU6FKdr/LRKkvTKfTjwx35KRH05URQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UjF533ne+R29oKLdkWmIC0TlClWGbaMuVjAVoDlBjQ=;
 b=fJ1wL3pXwm6SQ8Ket/CT4hkMEXxezXOsRw6zgIrVaqri2lemDfHWXYESSZRfQ4ZL5KgAQ3gYbPatA4V6Nel6xUT/IP9PB9SLnbyXbyNNtTKAck9bev2eVpkU/q5YdA+ps7Il0fkTf33EbOmakWOBQvXuwubRGnpwCWN8L6LAWDEqlNqcKl/QpUU0Dr9B9MY7Z8dy2oYsYr0aaJC47T+3VnMon6pjcwQw4FUDnr/Ssd33WAbVlk99x+xAFiW0EoUjAsWmDFehymgwXDphJn0+Tixt84pmCiM2uk1NGs3lJ4Ipj9ToEQl0hpVkheawHe6FLoqVTiDV8/YI1kSOz5YHtQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GV1PR02MB8260.eurprd02.prod.outlook.com (2603:10a6:150:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Sun, 26 May
 2024 15:53:49 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7611.025; Sun, 26 May 2024
 15:53:49 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Yajun Deng <yajun.deng@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: brcm80211: use sizeof(*pointer) instead of sizeof(type)
Date: Sun, 26 May 2024 17:53:30 +0200
Message-ID:
 <AS8PR02MB7237C3696881F79EAEE8D02E8BF72@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [La+141XPgp9H8RHDMk4rtECEn+K2ONDI]
X-ClientProxiedBy: MA2P292CA0025.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::9)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240526155330.5208-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GV1PR02MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8525f391-5da3-4a5b-3b32-08dc7d9c0795
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	v53IPLgrmLhFz2NiwdWkx+iwWswlFJnpAo1gd7BjsdZXfm1RzJe9Gh7rAiLsYTHqDjqLXUM9grZ4G1AifRafFRyq6EWUrQmUQH0Wm33KChU9drbllj/lYjzJNN3q0Rluy/aKM+IqnU8vszk0EqyzDFV92Xzj98OzMUB1VJxCD93MFvvHvI9b/KwxCGIwuAZHpw69EV6f0D2XruAV/Cup4XPdXywE8tSD7k+Wy72bsqznUm/ofT9/NI7STYVFqCBx+9SErNUHtideT6+TKkypSaAvjF6Paw0EQ3SEByFB+d7d6/UqoOXzV9QNUuWWs8x6oPwgsQB/O9cOepdnjc8F0zfe+dTbIQleaTjgHDmG8n88x7spW4HjyyOoHF7lQNP9cBXvO4ZYts/McF3X/19Tmrsru9NjIUHevstM27pyaYJNV4D79NPBclSvecyJP6Wy5J52wUTpr5cBkWuhwyxHD7h9Qsxr9jbmGvQcIwHLy7uOlL/CIt9MBmLbRpTr3pVqsD067xzbA5ZH4mCk8j0QOH3B0libsWXRadzDPQJT+erwApUnkOIrHYm1tTWSW1Kg9T65jTTxl9tA0vqLslRVQ8K1kNmFcLS10YrBO67nVwseQ5ETDe8ckBNKDcHJSdO1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RV4YWAh5QG2uJKacTHnxIu4x8cGM3teuKzRQpyVuyVTfSh7Unm8jI0nCOmT2?=
 =?us-ascii?Q?4pTEWxY3cADs2zKr3dGvJq+JpCDDiecdUPdzOKAO+MNnwzYgvIy/SSXgW9nr?=
 =?us-ascii?Q?JjRVTG1sYMZo3Z01J9EQpqFTGf7o3Tmv+Bgdxlh9eZhDp+wg7oX+8827J/NH?=
 =?us-ascii?Q?TS3gFlHJ76b0BllqnIrx/XJnsrucd/H9VRV02rQHVBI/ozxj87Y6XXqCnssC?=
 =?us-ascii?Q?fqCZZRHo813liZtYmP7pf1Pm9SVSQqbZDbxIYRBdSAWCMEvMVBfsEM7DZYmO?=
 =?us-ascii?Q?otbgzgnfdj5etKyqc6VY0KR3x2UeiF6ReN8OGd7IZLuYwRFWRw7zLfYNwVLT?=
 =?us-ascii?Q?xUHipqTaAA4o7xh7A8tCpnoG25v5nXe/kInqi3d+JN7L6J/HMn65YmxgXiXq?=
 =?us-ascii?Q?IwwQIxdkmVOWOq+Pyap6n7PGLiOCRUyFp377toFIwYo+4CmJT/urrxzixpk3?=
 =?us-ascii?Q?8TVCPFyRPq6ONyahQBSq7qC8+bAhmkKKEjYDyOFSGfimvGomwpTzq866UMnt?=
 =?us-ascii?Q?TjH7ykhLP84PmrR2b96vUWDpaLKmAEtHeRDr3f3bD0tsSMs2Kd0+o269B+fn?=
 =?us-ascii?Q?RSmEmhBYL8+1KsN2ICwdgf1g9PgMvX1CKSts5ZHVneF310s0S7yI7M/M4Ywg?=
 =?us-ascii?Q?F6ypYItLYShqaOSmyhx3+K0G+kgCYWogSwx0DV4D0xwb3rWziHqXT4nT/5UC?=
 =?us-ascii?Q?rmGh5UagAFHnY/tAp0VmfR/XJoQ6ZgFQv1qymtuskEOQmbEmCdzUgt06zuGT?=
 =?us-ascii?Q?NlvAVCx7qN1y2F9vTPHUsBO+7xCKcyuhlp4ScG3a+Ox6lMkBbtUfKx7/fDei?=
 =?us-ascii?Q?Bf4mSXc3RwDct5npw3WaurMAkqYyFCPW+a2wmazaZaFrdw3neM3gx/cQ4h6S?=
 =?us-ascii?Q?r27g+TtcmKawkesqnLZAPcE/6+ZiTkYE+d342uvpdJ0xHaNN3wx3VMbcI5Z+?=
 =?us-ascii?Q?KBEIXpPRbJ4rbl86cwd+HWcIgR/w35//f1WmX2fnXzm4qMdlYbMlUSZ1KNjX?=
 =?us-ascii?Q?G7+bB2MbEDnU5fASfSSqzmOD++WMV5ku1e8Lz29+uz5m3uJPeYGRVw6CStWa?=
 =?us-ascii?Q?g/rD+730JqS1kEJFYdhb2dcerxsmqLBclx0TlukR/aHELmIXVekTr0iB+ccU?=
 =?us-ascii?Q?ZtbO+d6YyoAEq0lksp3N/k+lR3//WdOl2g9ZnzJte9X3wBnE+eLe56FBvoey?=
 =?us-ascii?Q?nHAui9fl2qBSi415QvJw7VgCs1WaMYQSEB9CCw1GhuI2rfF7L3Fq8/a7mkIM?=
 =?us-ascii?Q?Azg8nrX4FTb0oAbhLt0a?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8525f391-5da3-4a5b-3b32-08dc7d9c0795
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2024 15:53:48.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8260

It is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not
change the former (unlike the latter). This patch has no effect
on runtime behavior.

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 ++--
 .../broadcom/brcm80211/brcmfmac/btcoex.c      |  2 +-
 .../broadcom/brcm80211/brcmfmac/sdio.c        |  2 +-
 .../broadcom/brcm80211/brcmfmac/usb.c         |  2 +-
 .../broadcom/brcm80211/brcmsmac/aiutils.c     |  2 +-
 .../broadcom/brcm80211/brcmsmac/ampdu.c       |  2 +-
 .../broadcom/brcm80211/brcmsmac/antsel.c      |  2 +-
 .../broadcom/brcm80211/brcmsmac/channel.c     |  2 +-
 .../broadcom/brcm80211/brcmsmac/dma.c         |  2 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |  2 +-
 .../broadcom/brcm80211/brcmsmac/main.c        | 23 +++++++++----------
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c |  4 ++--
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c |  2 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c    |  2 +-
 14 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 13391c2d82aa..d35262335eaf 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1061,10 +1061,10 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	if (func->num != 2)
 		return -ENODEV;
 
-	bus_if = kzalloc(sizeof(struct brcmf_bus), GFP_KERNEL);
+	bus_if = kzalloc(sizeof(*bus_if), GFP_KERNEL);
 	if (!bus_if)
 		return -ENOMEM;
-	sdiodev = kzalloc(sizeof(struct brcmf_sdio_dev), GFP_KERNEL);
+	sdiodev = kzalloc(sizeof(*sdiodev), GFP_KERNEL);
 	if (!sdiodev) {
 		kfree(bus_if);
 		return -ENOMEM;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index 7ea2631b8069..c199595a6a01 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -361,7 +361,7 @@ int brcmf_btcoex_attach(struct brcmf_cfg80211_info *cfg)
 	struct brcmf_btcoex_info *btci = NULL;
 	brcmf_dbg(TRACE, "enter\n");
 
-	btci = kmalloc(sizeof(struct brcmf_btcoex_info), GFP_KERNEL);
+	btci = kmalloc(sizeof(*btci), GFP_KERNEL);
 	if (!btci)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 6b38d9de71af..1461dc453ac2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4450,7 +4450,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	/* Allocate private bus interface state */
-	bus = kzalloc(sizeof(struct brcmf_sdio), GFP_ATOMIC);
+	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
 	if (!bus)
 		goto fail;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 9a105e6debe1..40b818e63ce4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1247,7 +1247,7 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 	if (!bus_pub)
 		return -ENODEV;
 
-	bus = kzalloc(sizeof(struct brcmf_bus), GFP_ATOMIC);
+	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
 	if (!bus) {
 		ret = -ENOMEM;
 		goto fail;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c
index 2084b506a450..50d817485cf9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c
@@ -512,7 +512,7 @@ ai_attach(struct bcma_bus *pbus)
 	struct si_info *sii;
 
 	/* alloc struct si_info */
-	sii = kzalloc(sizeof(struct si_info), GFP_ATOMIC);
+	sii = kzalloc(sizeof(*sii), GFP_ATOMIC);
 	if (sii == NULL)
 		return NULL;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
index c3376f887114..33d17b779201 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
@@ -219,7 +219,7 @@ struct ampdu_info *brcms_c_ampdu_attach(struct brcms_c_info *wlc)
 	struct ampdu_info *ampdu;
 	int i;
 
-	ampdu = kzalloc(sizeof(struct ampdu_info), GFP_ATOMIC);
+	ampdu = kzalloc(sizeof(*ampdu), GFP_ATOMIC);
 	if (!ampdu)
 		return NULL;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.c
index 54c616919590..f411bc6d795d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/antsel.c
@@ -111,7 +111,7 @@ struct antsel_info *brcms_c_antsel_attach(struct brcms_c_info *wlc)
 	struct antsel_info *asi;
 	struct ssb_sprom *sprom = &wlc->hw->d11core->bus->sprom;
 
-	asi = kzalloc(sizeof(struct antsel_info), GFP_ATOMIC);
+	asi = kzalloc(sizeof(*asi), GFP_ATOMIC);
 	if (!asi)
 		return NULL;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
index f6962e558d7c..d1b9a18d0374 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
@@ -331,7 +331,7 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(struct brcms_c_info *wlc)
 	const char *ccode = sprom->alpha2;
 	int ccode_len = sizeof(sprom->alpha2);
 
-	wlc_cm = kzalloc(sizeof(struct brcms_cm_info), GFP_ATOMIC);
+	wlc_cm = kzalloc(sizeof(*wlc_cm), GFP_ATOMIC);
 	if (wlc_cm == NULL)
 		return NULL;
 	wlc_cm->pub = pub;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
index 3d5c1ef8f7f2..bd480239368a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -558,7 +558,7 @@ struct dma_pub *dma_attach(char *name, struct brcms_c_info *wlc,
 	struct si_info *sii = container_of(sih, struct si_info, pub);
 
 	/* allocate private info structure */
-	di = kzalloc(sizeof(struct dma_info), GFP_ATOMIC);
+	di = kzalloc(sizeof(*di), GFP_ATOMIC);
 	if (di == NULL)
 		return NULL;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 92860dc0a92e..860ef9c11c46 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -1496,7 +1496,7 @@ struct brcms_timer *brcms_init_timer(struct brcms_info *wl,
 {
 	struct brcms_timer *t;
 
-	t = kzalloc(sizeof(struct brcms_timer), GFP_ATOMIC);
+	t = kzalloc(sizeof(*t), GFP_ATOMIC);
 	if (!t)
 		return NULL;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index 34460b5815d0..d3c74440381f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
@@ -463,11 +463,11 @@ static struct brcms_bss_cfg *brcms_c_bsscfg_malloc(uint unit)
 {
 	struct brcms_bss_cfg *cfg;
 
-	cfg = kzalloc(sizeof(struct brcms_bss_cfg), GFP_ATOMIC);
+	cfg = kzalloc(sizeof(*cfg), GFP_ATOMIC);
 	if (cfg == NULL)
 		goto fail;
 
-	cfg->current_bss = kzalloc(sizeof(struct brcms_bss_info), GFP_ATOMIC);
+	cfg->current_bss = kzalloc(sizeof(*cfg->current_bss), GFP_ATOMIC);
 	if (cfg->current_bss == NULL)
 		goto fail;
 
@@ -483,14 +483,14 @@ brcms_c_attach_malloc(uint unit, uint *err, uint devid)
 {
 	struct brcms_c_info *wlc;
 
-	wlc = kzalloc(sizeof(struct brcms_c_info), GFP_ATOMIC);
+	wlc = kzalloc(sizeof(*wlc), GFP_ATOMIC);
 	if (wlc == NULL) {
 		*err = 1002;
 		goto fail;
 	}
 
 	/* allocate struct brcms_c_pub state structure */
-	wlc->pub = kzalloc(sizeof(struct brcms_pub), GFP_ATOMIC);
+	wlc->pub = kzalloc(sizeof(*wlc->pub), GFP_ATOMIC);
 	if (wlc->pub == NULL) {
 		*err = 1003;
 		goto fail;
@@ -499,7 +499,7 @@ brcms_c_attach_malloc(uint unit, uint *err, uint devid)
 
 	/* allocate struct brcms_hardware state structure */
 
-	wlc->hw = kzalloc(sizeof(struct brcms_hardware), GFP_ATOMIC);
+	wlc->hw = kzalloc(sizeof(*wlc->hw), GFP_ATOMIC);
 	if (wlc->hw == NULL) {
 		*err = 1005;
 		goto fail;
@@ -528,7 +528,7 @@ brcms_c_attach_malloc(uint unit, uint *err, uint devid)
 		goto fail;
 	}
 
-	wlc->default_bss = kzalloc(sizeof(struct brcms_bss_info), GFP_ATOMIC);
+	wlc->default_bss = kzalloc(sizeof(*wlc->default_bss), GFP_ATOMIC);
 	if (wlc->default_bss == NULL) {
 		*err = 1010;
 		goto fail;
@@ -540,21 +540,20 @@ brcms_c_attach_malloc(uint unit, uint *err, uint devid)
 		goto fail;
 	}
 
-	wlc->protection = kzalloc(sizeof(struct brcms_protection),
-				  GFP_ATOMIC);
+	wlc->protection = kzalloc(sizeof(*wlc->protection), GFP_ATOMIC);
 	if (wlc->protection == NULL) {
 		*err = 1016;
 		goto fail;
 	}
 
-	wlc->stf = kzalloc(sizeof(struct brcms_stf), GFP_ATOMIC);
+	wlc->stf = kzalloc(sizeof(*wlc->stf), GFP_ATOMIC);
 	if (wlc->stf == NULL) {
 		*err = 1017;
 		goto fail;
 	}
 
 	wlc->bandstate[0] =
-		kcalloc(MAXBANDS, sizeof(struct brcms_band), GFP_ATOMIC);
+		kcalloc(MAXBANDS, sizeof(*wlc->bandstate[0]), GFP_ATOMIC);
 	if (wlc->bandstate[0] == NULL) {
 		*err = 1025;
 		goto fail;
@@ -567,14 +566,14 @@ brcms_c_attach_malloc(uint unit, uint *err, uint devid)
 				+ (sizeof(struct brcms_band)*i));
 	}
 
-	wlc->corestate = kzalloc(sizeof(struct brcms_core), GFP_ATOMIC);
+	wlc->corestate = kzalloc(sizeof(*wlc->corestate), GFP_ATOMIC);
 	if (wlc->corestate == NULL) {
 		*err = 1026;
 		goto fail;
 	}
 
 	wlc->corestate->macstat_snapshot =
-		kzalloc(sizeof(struct macstat), GFP_ATOMIC);
+		kzalloc(sizeof(*wlc->corestate->macstat_snapshot), GFP_ATOMIC);
 	if (wlc->corestate->macstat_snapshot == NULL) {
 		*err = 1027;
 		goto fail;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
index a27d6f0b8819..c3d7aa570b4e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -355,7 +355,7 @@ struct shared_phy *wlc_phy_shared_attach(struct shared_phy_params *shp)
 {
 	struct shared_phy *sh;
 
-	sh = kzalloc(sizeof(struct shared_phy), GFP_ATOMIC);
+	sh = kzalloc(sizeof(*sh), GFP_ATOMIC);
 	if (sh == NULL)
 		return NULL;
 
@@ -442,7 +442,7 @@ wlc_phy_attach(struct shared_phy *sh, struct bcma_device *d11core,
 		return &pi->pubpi_ro;
 	}
 
-	pi = kzalloc(sizeof(struct brcms_phy), GFP_ATOMIC);
+	pi = kzalloc(sizeof(*pi), GFP_ATOMIC);
 	if (pi == NULL)
 		return NULL;
 	pi->wiphy = wiphy;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index aae2cf95fe95..8696061bf2dd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -4968,7 +4968,7 @@ bool wlc_phy_attach_lcnphy(struct brcms_phy *pi)
 {
 	struct brcms_phy_lcnphy *pi_lcn;
 
-	pi->u.pi_lcnphy = kzalloc(sizeof(struct brcms_phy_lcnphy), GFP_ATOMIC);
+	pi->u.pi_lcnphy = kzalloc(sizeof(*pi->u.pi_lcnphy), GFP_ATOMIC);
 	if (pi->u.pi_lcnphy == NULL)
 		return false;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
index b72381791536..4b916f3a087b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
@@ -40,7 +40,7 @@ struct phy_shim_info *wlc_phy_shim_attach(struct brcms_hardware *wlc_hw,
 					  struct brcms_c_info *wlc) {
 	struct phy_shim_info *physhim = NULL;
 
-	physhim = kzalloc(sizeof(struct phy_shim_info), GFP_ATOMIC);
+	physhim = kzalloc(sizeof(*physhim), GFP_ATOMIC);
 	if (!physhim)
 		return NULL;
 
-- 
2.25.1


