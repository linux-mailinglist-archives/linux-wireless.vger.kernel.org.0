Return-Path: <linux-wireless+bounces-8382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05E8D7719
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 18:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1895928183A
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21BF548FD;
	Sun,  2 Jun 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="e5+i6z3q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2046.outbound.protection.outlook.com [40.92.89.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59004F60D;
	Sun,  2 Jun 2024 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717344817; cv=fail; b=ccEVhk1ZeIBQZkjwj9Eg1uo/TXxJ8x3VefCiGAh6o2vXo6W3/B3TMTdzgUE67r2l7t5Pn9Sc4sI2uKV3+YfTV9+utQ1OrvBynkwcVghR1EXEwE9+Vgu3KHImtbD0GWYO7npNC5oSMECfk1Yp1/dgVsmvRWMZeBewdbTOB8SiyaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717344817; c=relaxed/simple;
	bh=Noh6ak1h0VsWbQVl57wwEebajgkSFAVJZESKNvNOG5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJawQQ4LTEeixIyVv+GumG4rIe+E8NazCS4FQrNi+oHoozDECsbA3SRAbSkqtsXoL+qVrpvVnWD0+fkSGDmdxvxIEWQf2sy2o6zb8/VJQqD4NCDXWZQNhtH3AuLvnmsdlJkJKIYK5k0c0a1Ygq7gyXzUn8nxwc93o2JP2KQACsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=e5+i6z3q; arc=fail smtp.client-ip=40.92.89.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ33S5frt/FZNqhs31GutZReDyjF/zkeR9avH7kB54kJ4LmEblX/suM0PkFsfMpcLfyHvtLmw+CeDQCpnqJ4OO1Yg5azt4PX1h7nlFCs7lek5djIie7h5vC02+WEku1Ou/bM2bXVTX1DwFCc9UwxVY+DOm9HiZHVc4RdUJBXezbuk+em82xE7cNwLl/XsoPP2zyX3XLwjYx8XGoPaH1YXSRCRIkjf2JZ18Cl0xAOS6CelgfjiaHnep1FOmP/Y9ue9YjZ9hp1kWVvmuvvFaMCoQQHwZ9TkCJwSrfdZA80FdINtE5wCsg1rNNRTQz3kyCj5RcFyUAiEFGewRBLUs736g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVQ3bNPqvr7lI+1aoUFNSPGsO1a466+wjnzIRCJ+ojY=;
 b=eXjhU8YY67RuLJZZy24hPi4vr8ak2RXn6P2FV54Mh9WGzgFo37aReMxwLX68hJ+ClnXvXjDW+QuvlCu1hkyOYN5+B0uJYDO7qMtCGwuhE8OFuOWFmiAvpg0HTsUk7BYAA4rWRON2jQpcJiuar3KDilxUKDFDg5NGf2YX2c9IAVqI9Wq27Ko0TZtymh9hPriHwDa//sMK28eUO0JI+TyDK6SZo57KftxNd8SgWZv59g443DsHPAnW9kDOvCP4QNHrg4sXCjOEzNA+A6Zax79pjQNZ8BtaDezx5WPKO9jwK/QDyB9JQVGrzDngkGmgmi/zSCoFReTV1JE9KiDHpvxQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVQ3bNPqvr7lI+1aoUFNSPGsO1a466+wjnzIRCJ+ojY=;
 b=e5+i6z3qJsHYRWgjxSo6rUWhTvAF4/d7FOUA5lGQ/chGIkyP+ispnmKvafmmlLNSMpwwnjOumqIjYgLwmlYX2Kd0owD+V8FuyiXY5qVHLS/yDV+1Ct9j9w5SBgZQQGcs4yv+szwGxaQINoPDdF60UuISOKyuMXMMX6s8O+nQXrpWuYbFbMhOSzNr6MoMJVqnsZbzKtrW+vxoG+0ZcqRwX4h/MKYDTkBncP8faKf06LeEjWikSV1p1h+4n5Ihvbc3nWMQwfHvXiMHRXp8c/gNy8Zqjh8nwPY8rc2tGw9SlefS441DueBCaXUmh+iqw/nxAXAlZp+YTondjZSiISR5iQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB8PR02MB5770.eurprd02.prod.outlook.com (2603:10a6:10:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Sun, 2 Jun
 2024 16:13:32 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 16:13:32 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Kalle Valo <kvalo@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/2] atmel: at76c50x: use sizeof(*pointer) instead of sizeof(type)
Date: Sun,  2 Jun 2024 18:13:09 +0200
Message-ID:
 <AS8PR02MB7237C784C14DBC943CB719F88BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240602161310.5671-1-erick.archer@outlook.com>
References: <20240602161310.5671-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [MR30IX40Q1PMBu4B6bBJuLNY9GXys/Nr]
X-ClientProxiedBy: MA4P292CA0012.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::9) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240602161310.5671-2-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB8PR02MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e412873-8917-4825-c272-08dc831ef295
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwWBFFzn80jCJQAJVwNE0XiCoJsq6VbH6lRneqLXEuovHqmPRGwooEqhrx9eKosk01UGowsgMAZMEzuHQ9Xt19u99vEFe37xJuybd6nQIM0m695U6/nZzVWsNOsX4h2BX1hTa4l8eVDHFWH/zYMQFVkAn7Szx6dgHrMK36IMbt7x1GWJ5eK+Np/B/n4vssnYyY8Ib7eu780KskCWZVVO1pNDc9TI3tRlnrgNdVXyTXXXIfRyRycyx9VvDDtY+8HyokbmavzZNwDEK38AkiTRCgX4ff+h00A7RDr4yJREOxssKbtotNwUXxOif5X/42jWa/HkJaLjZkEIczmy26fQ1QKAwQ39/RH3JFqtKVmHtk0ENEVoUbeGDpPvVxwPPZsNbbPFGnt3hLA0XmmhLEPOZrRk8X3eedbiC6PuWVtwCPx1hU32PZGsYF2A4IHW/wYERv5x7sjs7v8FYGqnQNyjmHIDVGSNxRJxS4jB6tPJK3FyBHrBh0lJgF6ysTMvP3pKHGIH/Rf8HJFEpnmiMTk+32Bgpgb/Th9nEINFwNQzNJix4UXoStqxXOpx4JVJXVjtYMFb4OVsCaYoiBUaZ5WEyIya7hXQI0m2Z90ig25AXjX7LuUixcvIn/+6bDqdaIkWZ67uceyE215/4g2lsv8m8vMH8POlcNaHlBDs+buZLFP8HeAOLt2DKAWnEYSHLFVxZCDESImrpnfbLzA0SIFUg6dw9C3vppK6skCj1P1bg8u03u8dTXEmspS+HF7pMVRFCYw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	XPCiMnfiuXDcBxTGoDKICA+uFQrqxjiflNOuOpdYSSilfEKVfhdozRuOF64h4u8+1GI5IryVXcVmUaUhPAae8uEyuGdRXDdfQT2B4Fcf69KwFxLUSjYr1s55EXyE+gPBkoQIaN/lLy46rXLVAp7uJQRBDs4W1H4u944/jkmzBzX23ii3fKLr1XrW3j99RDumHYimlFLxNyJtHfhv6qMLAl+BC4gElQfUulkyWzha768pdBbupniBb2/JduPIz8yUEt+Y2GVf+iWGSyFAgxdd0QE3PSBK07lAzxpmhA22IZLYD5QXTv4wm4HSRynEHFlBFyt5Wd9W3DqwvUS2XFBH8BTFapm8TPO7unSulHnEt+7Y28hHRJNV8VVia+7/yYezgm5dEsCl2Bz68JQPfGDEhdSMOMMunoTUPMH2U5kl0t1rTjFfWfZVgpVteUy/Dby58C83frEOQXkaVpiDpk7LtGIqJa6zbDwggGmFD5t33r7dbhmKT7ap2zFQLfF8pF3UtbH4KgiKeet1dWrVEmDUge4L/KFv8fsWdFr5lH/kLiKIHGW6BacPvCGWKQepWp4O7GuBbytinIGfNmDmHwQrZXt3UxG8ioi35/BM5CgPOttex7uJaGSzCHB2VikdbpAb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LVh700je98sAdZJ9ANABOBhEKRtP32/3novBNxoywfE8oQVqkyIs5Gu/XOif?=
 =?us-ascii?Q?+jkwjNaz9sQplBVCnPsaEGbpfbwG3Wjd9WU/7KohYHcICdA0vYJU27FY8Qjx?=
 =?us-ascii?Q?Bdwlt8k+jUoRky0OuOGojfD7gHfjhvRBr0BOC2wdD1yP1FcMBfWVqJRGZiYU?=
 =?us-ascii?Q?g+VJQoWQsF+gSAYBXCn8eoV6V87OrvteOyl5OYKIu+mcG0T67DzCE1QYT7Ot?=
 =?us-ascii?Q?dgweZEsyI5JpeKoJ/4WR151Pacu0Xqnq6Nbgju8Plj6AuZTGsyCi3HM1itMS?=
 =?us-ascii?Q?STaYGtSrTNdVUuHyOhSGA5eKvjjGDw1IPiyZwm63aUaxDBNkADRGPn/48b01?=
 =?us-ascii?Q?Y+UUmshxAennadWM8aqgkL0DfJRgqaw4v6Lb96FWfWKGJZP00Lajp/zMyoU+?=
 =?us-ascii?Q?/pWsmsjczrml2EHD0ww1BekmxbsU7kxq8b9rdFdgHyag4SmlBmIOS5LJL4uR?=
 =?us-ascii?Q?+G4SBPPBs6TgJY2dE3hvaUMqI4ifaTYiQEzp7Y6DCRCxuZ/soupyCGQAR/HR?=
 =?us-ascii?Q?VC6fx0dO0WslyqtGTABpEiaNO5+KVIFAjqjFogNuc67vM9r4DIDboG4Pvx44?=
 =?us-ascii?Q?89TuRGsZcXdfU96cY59qwXNxS00s5l3g1cz6+xaJvmu7suvMacYPjqVXE1cI?=
 =?us-ascii?Q?YyD5fmPKsFd4+85tAtlHNuEyxkKMtvt4TTE8+T8NonY5m10D+sgNjBRz3+lK?=
 =?us-ascii?Q?gn+f6hn7TvAAH/msF9IjUXapvpqgBzrA+D1Pus5PqR8LyosWGGt2kV07f6Ms?=
 =?us-ascii?Q?5ooUWf8163Pgq17WoIiAqLVvFVUfxdXkCx9XbWtg4T6V+J8Q2wP+v18kYuqP?=
 =?us-ascii?Q?i3jENZ0DN/o1zvL1dI0Nuj+bqdfZAsQxmTCwjyPyocXrmBu95RUfUK6z0qAC?=
 =?us-ascii?Q?BxyfYFKmHg3xKfBnycbGZgeYpSin30C7bvQwsifmCcpB7VzSJd0yEUUU5hYW?=
 =?us-ascii?Q?df4aGZ9ms/pQnQ0comR7vARWuNhA7naV02kpfDH6L/b+lgkNwGbSv7rDzFLQ?=
 =?us-ascii?Q?s1zf97XBc9MwEcW+eL8MpdXrI1jdJJHV1fpryJbzxvvDhPKNrcvGuIxZdu6P?=
 =?us-ascii?Q?5oV1p/VUDyvsyr9s+zfyv4TklSNGLZ3VTcVRZGat4lDkhB1NFCzGjR0HaqC2?=
 =?us-ascii?Q?zW4jhibQVuqc46tbMMytIqJSmeqL4I9LjOU7v/nwGOyuJZcw3jcxKXSi3eFX?=
 =?us-ascii?Q?HPmXvQ3GquQ7hu21OA0B6Yk0f43m7g5Lh/cpkLZT3LmvhwD+exb2nYgZiKah?=
 =?us-ascii?Q?heEjB6qLdsA/CTCCgFOB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e412873-8917-4825-c272-08dc831ef295
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 16:13:32.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5770

It is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not
change the former (unlike the latter). This patch has no effect
on runtime behavior.

At the same time remove some redundant NULL initializations.

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/net/wireless/atmel/at76c50x-usb.c | 44 ++++++++++-------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 0b55a272bfd6..0ca2f629683d 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -332,7 +332,7 @@ static int at76_dfu_get_status(struct usb_device *udev,
 
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), DFU_GETSTATUS,
 			      USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_INTERFACE,
-			      0, 0, status, sizeof(struct dfu_status),
+			      0, 0, status, sizeof(*status),
 			      USB_CTRL_GET_TIMEOUT);
 	return ret;
 }
@@ -366,7 +366,7 @@ static int at76_usbdfu_download(struct usb_device *udev, u8 *buf, u32 size,
 	u32 dfu_timeout = 0;
 	int bsize = 0;
 	int blockno = 0;
-	struct dfu_status *dfu_stat_buf = NULL;
+	struct dfu_status *dfu_stat_buf;
 	u8 *dfu_state = NULL;
 	u8 *block = NULL;
 
@@ -378,7 +378,7 @@ static int at76_usbdfu_download(struct usb_device *udev, u8 *buf, u32 size,
 		return -EINVAL;
 	}
 
-	dfu_stat_buf = kmalloc(sizeof(struct dfu_status), GFP_KERNEL);
+	dfu_stat_buf = kmalloc(sizeof(*dfu_stat_buf), GFP_KERNEL);
 	if (!dfu_stat_buf) {
 		ret = -ENOMEM;
 		goto exit;
@@ -931,14 +931,12 @@ static void at76_dump_mib_mac_addr(struct at76_priv *priv)
 {
 	int i;
 	int ret;
-	struct mib_mac_addr *m = kmalloc(sizeof(struct mib_mac_addr),
-					 GFP_KERNEL);
+	struct mib_mac_addr *m = kmalloc(sizeof(*m), GFP_KERNEL);
 
 	if (!m)
 		return;
 
-	ret = at76_get_mib(priv->udev, MIB_MAC_ADDR, m,
-			   sizeof(struct mib_mac_addr));
+	ret = at76_get_mib(priv->udev, MIB_MAC_ADDR, m, sizeof(*m));
 	if (ret < 0) {
 		wiphy_err(priv->hw->wiphy,
 			  "at76_get_mib (MAC_ADDR) failed: %d\n", ret);
@@ -961,13 +959,12 @@ static void at76_dump_mib_mac_wep(struct at76_priv *priv)
 	int i;
 	int ret;
 	int key_len;
-	struct mib_mac_wep *m = kmalloc(sizeof(struct mib_mac_wep), GFP_KERNEL);
+	struct mib_mac_wep *m = kmalloc(sizeof(*m), GFP_KERNEL);
 
 	if (!m)
 		return;
 
-	ret = at76_get_mib(priv->udev, MIB_MAC_WEP, m,
-			   sizeof(struct mib_mac_wep));
+	ret = at76_get_mib(priv->udev, MIB_MAC_WEP, m, sizeof(*m));
 	if (ret < 0) {
 		wiphy_err(priv->hw->wiphy,
 			  "at76_get_mib (MAC_WEP) failed: %d\n", ret);
@@ -997,14 +994,12 @@ static void at76_dump_mib_mac_wep(struct at76_priv *priv)
 static void at76_dump_mib_mac_mgmt(struct at76_priv *priv)
 {
 	int ret;
-	struct mib_mac_mgmt *m = kmalloc(sizeof(struct mib_mac_mgmt),
-					 GFP_KERNEL);
+	struct mib_mac_mgmt *m = kmalloc(sizeof(*m), GFP_KERNEL);
 
 	if (!m)
 		return;
 
-	ret = at76_get_mib(priv->udev, MIB_MAC_MGMT, m,
-			   sizeof(struct mib_mac_mgmt));
+	ret = at76_get_mib(priv->udev, MIB_MAC_MGMT, m, sizeof(*m));
 	if (ret < 0) {
 		wiphy_err(priv->hw->wiphy,
 			  "at76_get_mib (MAC_MGMT) failed: %d\n", ret);
@@ -1035,12 +1030,12 @@ static void at76_dump_mib_mac_mgmt(struct at76_priv *priv)
 static void at76_dump_mib_mac(struct at76_priv *priv)
 {
 	int ret;
-	struct mib_mac *m = kmalloc(sizeof(struct mib_mac), GFP_KERNEL);
+	struct mib_mac *m = kmalloc(sizeof(*m), GFP_KERNEL);
 
 	if (!m)
 		return;
 
-	ret = at76_get_mib(priv->udev, MIB_MAC, m, sizeof(struct mib_mac));
+	ret = at76_get_mib(priv->udev, MIB_MAC, m, sizeof(*m));
 	if (ret < 0) {
 		wiphy_err(priv->hw->wiphy,
 			  "at76_get_mib (MAC) failed: %d\n", ret);
@@ -1072,12 +1067,12 @@ static void at76_dump_mib_mac(struct at76_priv *priv)
 static void at76_dump_mib_phy(struct at76_priv *priv)
 {
 	int ret;
-	struct mib_phy *m = kmalloc(sizeof(struct mib_phy), GFP_KERNEL);
+	struct mib_phy *m = kmalloc(sizeof(*m), GFP_KERNEL);
 
 	if (!m)
 		return;
 
-	ret = at76_get_mib(priv->udev, MIB_PHY, m, sizeof(struct mib_phy));
+	ret = at76_get_mib(priv->udev, MIB_PHY, m, sizeof(*m));
 	if (ret < 0) {
 		wiphy_err(priv->hw->wiphy,
 			  "at76_get_mib (PHY) failed: %d\n", ret);
@@ -1130,13 +1125,12 @@ static void at76_dump_mib_local(struct at76_priv *priv)
 static void at76_dump_mib_mdomain(struct at76_priv *priv)
 {
 	int ret;
-	struct mib_mdomain *m = kmalloc(sizeof(struct mib_mdomain), GFP_KERNEL);
+	struct mib_mdomain *m = kmalloc(sizeof(*m), GFP_KERNEL);
 
 	if (!m)
 		return;
 
-	ret = at76_get_mib(priv->udev, MIB_MDOMAIN, m,
-			   sizeof(struct mib_mdomain));
+	ret = at76_get_mib(priv->udev, MIB_MDOMAIN, m, sizeof(*m));
 	if (ret < 0) {
 		wiphy_err(priv->hw->wiphy,
 			  "at76_get_mib (MDOMAIN) failed: %d\n", ret);
@@ -1375,7 +1369,7 @@ static int at76_startup_device(struct at76_priv *priv)
 		 priv->scan_min_time, priv->scan_max_time,
 		 priv->scan_mode == SCAN_TYPE_ACTIVE ? "active" : "passive");
 
-	memset(ccfg, 0, sizeof(struct at76_card_config));
+	memset(ccfg, 0, sizeof(*ccfg));
 	ccfg->promiscuous_mode = 0;
 	ccfg->short_retry_limit = priv->short_retry_limit;
 
@@ -1411,7 +1405,7 @@ static int at76_startup_device(struct at76_priv *priv)
 	ccfg->beacon_period = cpu_to_le16(priv->beacon_period);
 
 	ret = at76_set_card_command(priv->udev, CMD_STARTUP, &priv->card_config,
-				    sizeof(struct at76_card_config));
+				    sizeof(*ccfg));
 	if (ret < 0) {
 		wiphy_err(priv->hw->wiphy, "at76_set_card_command failed: %d\n",
 			  ret);
@@ -2443,7 +2437,7 @@ static int at76_probe(struct usb_interface *interface,
 	struct usb_device *udev;
 	int op_mode;
 	int need_ext_fw = 0;
-	struct mib_fw_version *fwv = NULL;
+	struct mib_fw_version *fwv;
 	int board_type = (int)id->driver_info;
 
 	udev = usb_get_dev(interface_to_usbdev(interface));
@@ -2531,7 +2525,7 @@ static int at76_probe(struct usb_interface *interface,
 
 	usb_set_intfdata(interface, priv);
 
-	memcpy(&priv->fw_version, fwv, sizeof(struct mib_fw_version));
+	memcpy(&priv->fw_version, fwv, sizeof(*fwv));
 	priv->board_type = board_type;
 
 	ret = at76_init_new_device(priv, interface);
-- 
2.25.1


