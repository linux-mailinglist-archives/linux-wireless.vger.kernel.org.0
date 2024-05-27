Return-Path: <linux-wireless+bounces-8139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDA8D096B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 19:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0731F21F97
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A815ECD3;
	Mon, 27 May 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="evjJ/2rU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2079.outbound.protection.outlook.com [40.92.75.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9926AE7;
	Mon, 27 May 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831290; cv=fail; b=auwzGWnarXrXngsOdNSh52iNveOvOXzl5sx2opEUtzmQQjbyQU0FrjnJfUFH/yGYDM6m52ZxROkjtQtjhLQtPQWmbvLJw9SjIIhktPcEQ5aY/0J6cbOXnpZjnZNdk3OVuolXwWnNbiFWLpU/EkyHx5zynphfbngYJSgw92/HxWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831290; c=relaxed/simple;
	bh=v27EHbbPGqFCDbo22oqCh+0XKHZ4eiIa0tX9T93zV/I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WCNfoZvRNPQiemeV32PK3fKYgF/uV8pB9wB+WB+lgj1c6AIWXNcYxp0W/W9HO/cwYQNkZ7cXUUlTzdl1S/mjsMO0SI9vy0uHsrA4puxblIAgiKaA1ZerVDiM7mnJLnuswNuOLBqHrYhdyezEKxK7V3C0GksWEF4i7d5R3L8Awd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=evjJ/2rU; arc=fail smtp.client-ip=40.92.75.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1JZCzbfrZONtc0LqP7nR3A2+iocjp5UlspOjDLIobrjC7es3Fi/k3A97IL3DEhXij1anp5nCpnIo29YfN3wqMvXAcADm7FsDVvtZhMqlX4Xa20c48vCc3BmLe737PTHqnpRuycffl9qgHbTmTp+Fgs8s9st3hj5JDuanSzZcKSdVmjXAlVncOwvQUYSCCcoGuN3WgDmx7j/NAZm8eBHYRxBJEbVGl3EcmH7Dvg6var11O30MP3t4KjpcBezy00nnR+fiA47j/oNPTQwCQSReURKuciXUuY4HHaxOYTmpZ6BQks3820BWAFWGCeCih516aP04bM16w6V/0vqlnUs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP0LBSFwa4JkWFiCocfaapmplsiQL4LGCC2G/uEhigk=;
 b=XA9OG3mDn2mH9Bexmq3lEB3IAk8kAb91LLJdxrQor1HH9N6kMixZ2xjZsmhS4fZ05KlJ0YdLTf9IKLYlSWM1p70BHFFtfunAdCpdVt3Y0vdOnghamYfryosxOCQARITEONWjpb9piyDrokPmJ3uzhPeQsvY90LewPNSzNot+36ov3GJF2D/+bihy4GGUnq/D+4PLoEzIHqYjbWfyaIrb//x0gy2bw/IvsjCNubMPzpzqpg67dmOSXUFAwhS0TVxDwq8jYJONqtsBJvtrupga/16qOSVX7bZ4CxQmBnxeFkIjbfEA39tNvKrt1DiMPE1FfVa2OOLY781EtUsbaPKLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP0LBSFwa4JkWFiCocfaapmplsiQL4LGCC2G/uEhigk=;
 b=evjJ/2rUlfWNG5FqTc7uPzPd+MWMdHy5V43/BpWYO13fJYm/GINQq7OlVvXyp6gdiLEmGXjX1Ts1SkS28d21utX3Hno4avEDeben8s7jTMuqs5oFje0csijdknpM569by9ij9hUp+3MNu0mcL4k4Jz/3LoD6zrgRgcCsA3xEYaA2gQfZYNOkhkosZ2+6/zM+Y37fLDJ5xDJvpCbE0tCU4w71APbWt14mu/hu4ej193zNTB7TtXpSKo1hqSS8L2qRe1WUuzZ0UWWhp6LcCmn6dk3z6ByKS/YfFjVy/IxkWOhFR5kZ+IKGb8LN9glqlSfMtK+5wlheHtvHZ755qGJi/w==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB9PR02MB7321.eurprd02.prod.outlook.com (2603:10a6:10:242::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 17:34:44 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 17:34:44 +0000
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
Subject: [PATCH v2] wifi: brcm80211: use sizeof(*pointer) instead of sizeof(type)
Date: Mon, 27 May 2024 19:34:25 +0200
Message-ID:
 <AS8PR02MB7237FF1C2E880D1231684D708BF02@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [C2k+ZAh5LreQ/AeVVPOkAwiCjyVth/ra]
X-ClientProxiedBy: MA4P292CA0008.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::14) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240527173425.7902-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB9PR02MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e45500-ec09-4b2a-9a81-08dc7e734be4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	yIg9/7/7YBHsv+DbB0Zw9j3H4nL5rcA3RuzEJvVc5RjE9bi52hmukmlstHJxvJFfrSwQcTE/RE7Q1Zh0iMUQZA1rN6ZW+Y8GCBSXU72LpcGXHdfDZSTKuN6yEAFyUd6SdmBIpSBftaQspQgaiTvHM0NCkg9tF1dosPIVYujph+NgbJJ8E34INkW4hsBLISZOjHo2crCfefY/a4Da3rkmNU6AW8K0jZZVwRe6Xqkw6vBWlqECm3qhJhONo2xQfd8ekYSb7282DUywW/QrHnEHgerH4xSHt1UbUGutrwrFdUYgh1Km4aEXd9D3RkR8mfXDixeXQuhf9gh6nHXoaWqDccI7g17wApcOcxaF+GO6ALAEXQRecL0gWaAcBD2s+xC/mTMF471ZsIrJio0hl/pFhFsYJKuLAf3U+iCFrJFS8LdtlGu9BYjVHBUWqoMk/kbB/wqvlLbgmjYSOckxx+X9afzfpTnwYtow7J54XN0pYeaAdD3zfxu+bG1dhF4+p5pm0gd+85PwbaaJUOsrAIxY5Kvzq382Ui/yQOhpK0rW2P1LncXlZ1AtmiPn1aO11jy7vXVZZvvBcFWr9jokuGyT2mo0GG4WNYRDUw2EIFzLKiCGXtU2IiijA3GYWIzfIRwUe/Ctvey1pXlIOYtX15wbR8JaD4HgYf+1nXOhD2oFx71JujMBf8L5TyZivbQFhw8i
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MqRX+rvDAsfRcYE3MslHNyrNZx/uTlh9Gg4wOrY3joZPxWmbjFyVTTXt9z04?=
 =?us-ascii?Q?mRkGG3lMVhJ7fP6UMkEa6zeEMW1lPca1E6jsQQZQqXdzymmdYgwtWq7qFmoT?=
 =?us-ascii?Q?vpQKquv+XNYDXggiYSExbHNYDZoqBCtRUNkBBLIX/e3lGuPlAF76HYSpDeza?=
 =?us-ascii?Q?7bkcXRRHiqOK2LuOapfvGCQYTuIVDbCGQlEODZGElcSG5y9ZFrFIPLMf7Pta?=
 =?us-ascii?Q?H76pnIBTuxMvUeUQupSy0JYIKyMv9x0HlHaP3ZjTflsjB5XwT2Iq7Vqh2m77?=
 =?us-ascii?Q?oWzSRrdCqTB6nmN/8hl8iX5mC/xhuWetnjv3jG3A91DePc4ubZwjV2Xr/i/0?=
 =?us-ascii?Q?+tKNF5/wc8sf20hb22s5KrtKB29fi8tQgIG4DV9xmKBI6cqftldQhJw7IlOH?=
 =?us-ascii?Q?DaymuJqh7aZoo8Rco0brXMNnBtXJ9OxWrKzt7D3qtXicBE0Bajxc7aJU53Fy?=
 =?us-ascii?Q?VOYynRzWorC4unfLUvhfxAOkJohHwn7UMBq5jyG6DPAs7kJgR4lHcNjVHBDJ?=
 =?us-ascii?Q?SRvFRISWLMt7mbKEfoecpp8ajQM4pvDWDUKr+NcNquKsaL2b0r9vdxITrHAe?=
 =?us-ascii?Q?jhPRfycC1N+CX62woeAxwy6nrUZEmsEF7KcQKzLH/gfXlCQObVei80pXcQ/u?=
 =?us-ascii?Q?Q3ryfXbfGYYsXqw3BM//sbYks7AU0lt7DonmI1OgFXgc3cMFQqisnPBnEZJq?=
 =?us-ascii?Q?1tMv74MQw/MXSqZZDyIHsNWgtWVFXBuPiqGsqVSWrjIMhFLyU/WPDr/eRzWi?=
 =?us-ascii?Q?9ua2+fcOJZoD1E9/sCkCc88ZNHnJUoHHKw+cnngiIXmHbgP3Yw0C7CbTyuku?=
 =?us-ascii?Q?pyHYgRTHwMGp2hIZ6qB6JqBIBVSNjWWtHgWsGVrGfj7T0pm9XJ7mlEEGNYOt?=
 =?us-ascii?Q?mArcPraItVzSt0yn6JBtP/7HmagztOBIxuASc8XqNOLT4Bu12TgddvQfyPxV?=
 =?us-ascii?Q?GlN+lNt2OQzhpNbLoAmOWx75I1lp6NlTbObWgX30qZDi0ex3XqfU34rgFuIH?=
 =?us-ascii?Q?k68GJpiXq2lcQK7sF6i5kwtr1yiQIYW7G7e5j7fqkYwkK3c06zjzIYFptDYf?=
 =?us-ascii?Q?hYQd7CVyY95Sm/yWFeQ1EZ+DoC4iGi1MctESBY+SRR9PmMZoI+1tMZYTEnjF?=
 =?us-ascii?Q?rhz7Z5xLQ7yO94nuvk81ToRwBudv3cUHrjVKbUfn6O10TH731QZ/hSn3qIon?=
 =?us-ascii?Q?bAv7iH8VWj92ZZFVO+GdJibYhpDLC42UQjqDxckD0cs1UXSckvTus01sxt6A?=
 =?us-ascii?Q?CWajmYPL376ixoWNzmrf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e45500-ec09-4b2a-9a81-08dc7e734be4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 17:34:44.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7321

It is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not
change the former (unlike the latter). This patch has no effect
on runtime behavior.

At the same time remove some redundant NULL initializations.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Remove some redundant NULL initializations (Arend van Spriel).
- Refactor a bit the logic of "phy_lcn.c" (Arend van Spriel).
- Add the "Acked-by:" tag.

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237C3696881F79EAEE8D02E8BF72@AS8PR02MB7237.eurprd02.prod.outlook.com/
---
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 ++--
 .../broadcom/brcm80211/brcmfmac/btcoex.c      |  4 ++--
 .../broadcom/brcm80211/brcmfmac/sdio.c        |  2 +-
 .../broadcom/brcm80211/brcmfmac/usb.c         |  6 ++---
 .../broadcom/brcm80211/brcmsmac/aiutils.c     |  2 +-
 .../broadcom/brcm80211/brcmsmac/ampdu.c       |  2 +-
 .../broadcom/brcm80211/brcmsmac/antsel.c      |  2 +-
 .../broadcom/brcm80211/brcmsmac/channel.c     |  2 +-
 .../broadcom/brcm80211/brcmsmac/dma.c         |  2 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c |  2 +-
 .../broadcom/brcm80211/brcmsmac/main.c        | 23 +++++++++----------
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c |  4 ++--
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c |  6 ++---
 .../broadcom/brcm80211/brcmsmac/phy_shim.c    |  4 ++--
 14 files changed, 32 insertions(+), 33 deletions(-)

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
index 7ea2631b8069..0c3d119d1219 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -358,10 +358,10 @@ static void brcmf_btcoex_handler(struct work_struct *work)
  */
 int brcmf_btcoex_attach(struct brcmf_cfg80211_info *cfg)
 {
-	struct brcmf_btcoex_info *btci = NULL;
+	struct brcmf_btcoex_info *btci;
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
index 9a105e6debe1..8afbf529c745 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1236,8 +1236,8 @@ brcmf_usb_prepare_fw_request(struct brcmf_usbdev_info *devinfo)
 static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo,
 			      enum brcmf_fwvendor fwvid)
 {
-	struct brcmf_bus *bus = NULL;
-	struct brcmf_usbdev *bus_pub = NULL;
+	struct brcmf_bus *bus;
+	struct brcmf_usbdev *bus_pub;
 	struct device *dev = devinfo->dev;
 	struct brcmf_fw_request *fwreq;
 	int ret;
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
index aae2cf95fe95..39c38e1d5b1e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -4968,11 +4968,11 @@ bool wlc_phy_attach_lcnphy(struct brcms_phy *pi)
 {
 	struct brcms_phy_lcnphy *pi_lcn;
 
-	pi->u.pi_lcnphy = kzalloc(sizeof(struct brcms_phy_lcnphy), GFP_ATOMIC);
-	if (pi->u.pi_lcnphy == NULL)
+	pi_lcn = kzalloc(sizeof(*pi_lcn), GFP_ATOMIC);
+	if (!pi_lcn)
 		return false;
 
-	pi_lcn = pi->u.pi_lcnphy;
+	pi->u.pi_lcnphy = pi_lcn;
 
 	if (0 == (pi->sh->boardflags & BFL_NOPA)) {
 		pi->hwpwrctrl = true;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
index b72381791536..8b852581c4e4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
@@ -38,9 +38,9 @@ struct phy_shim_info {
 struct phy_shim_info *wlc_phy_shim_attach(struct brcms_hardware *wlc_hw,
 					  struct brcms_info *wl,
 					  struct brcms_c_info *wlc) {
-	struct phy_shim_info *physhim = NULL;
+	struct phy_shim_info *physhim;
 
-	physhim = kzalloc(sizeof(struct phy_shim_info), GFP_ATOMIC);
+	physhim = kzalloc(sizeof(*physhim), GFP_ATOMIC);
 	if (!physhim)
 		return NULL;
 
-- 
2.25.1


