Return-Path: <linux-wireless+bounces-8383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091438D771B
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 18:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2785281960
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2EF59167;
	Sun,  2 Jun 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nYuMas1x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2046.outbound.protection.outlook.com [40.92.89.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B655880;
	Sun,  2 Jun 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717344819; cv=fail; b=kLfVbzRqNmZqxNRt/JZwqT2Jy4KcOz/okHd44VSDCfO0nHVe7nNsOAP8o0rY2OT3AgN0PVsqYttakctODxhdFKFQMueGMCWDDT0vP/Q4q5VRH64MmeK7VieFhuMQhtrnus6erzJ/cjwKAT4FWEYvJsSQXONQuiBW7NYyHA5tmls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717344819; c=relaxed/simple;
	bh=HHZCt45ENCwr9fYYe36gugYY2fQ1DPE4hVUi3TgjYK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGDAJSX2oouQ7R/3szxqM5cxpgvwHqoNWzqHgq0tKki/ZkHmgNmE1JB5PblVcpQpEV85FIJxe0f5BpgDjNRyNJG5HJ7Oevp6ugHBvo4qs2xifqIc2PMRmKCp58vXatDgk9OYi+kxgoLOjWc/3r7lP2GXICaMNDpgvGIg/otNxTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nYuMas1x; arc=fail smtp.client-ip=40.92.89.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jO0A2ecqAska8cdX4JlP4VyXHZoiyPx9EZu6eaNdKxPsYSwTeSmTxHia83bWeAomhU8hn3avzf+sdv4ZP8mAv4FFqEyKYZKSi5zx5uzgZ+jNKdObi+m7wTS/BJ0Rng5lOhq1TQLqGELbUPsd+tx3ZZJwrmAuYWa9yL+c1j7KnhwrsJk6V1e7CcMf5/7bJUCADdqnjM7LTHS6Abvp0au+rXFL8shDYg6ZRzB3jTL1k8ixm/VMg7CpYClchLtA35jebQhud8q8vZU6+Ox3LFoOEe94ChpNAihVQZHRoe0F6TG+CnTeNNocGdt+JWGZzEbJf02MCRqTPQEtpw+0ZmCCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vk8RDDC0FHtje+A9aH90LofaW1j2JUfFYGmT0aycZg=;
 b=GeMfO5Q9DdlLltcfjNdHuLIaWKxRi/St6YnGLheFhPtbTP+DkCjZgFHNzPBrRWh5TPIpO7YD82wmR0HtoBVXDJVQZaHaG6esC6eeuNuW9iL74SHltK+z8Zh4CRkdGE25K2ZaCbTZxn00CtP0zl+pRBvcuc0zz1QHnTfrVDLRgN7DaX6vCjHW7HxvA8q4b+tzW2gib/rEB6tIC47FQjlyeukszM6nLkikKWXHYXbwhWd/RcwhtNkPPY6QbPEkx+kpX/hBaxs97r3KvFT4TnFlzJpACEWX6Dl2F2fqiHXVnAi1pP92QllTuDlSx9xqg7ldxIB4cfNU9frfwVc8ynyuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vk8RDDC0FHtje+A9aH90LofaW1j2JUfFYGmT0aycZg=;
 b=nYuMas1xin2RT/3tAkrkUl405xWPoNZlOdmdxSRR/0ZUwO8NuKURcAPFL/8KU9eW7Jc4Q/VcBXwp5ATTUIt3xuUippM+/eWVMMSJ9BHY6rB53MkizSvsSJd6MrINnvKZP5FkR21BOEA8E3FA+FtzFh+KN/nCDkNRgUZSgqoiponZsPIDTmSvhDjSkZ/0olP5gW8J4kUdV3CwdKPI0Akg1B5WJ0kwpuW77dC9NVXNdMvFp+gh3kF6Eeys+EeOaqAfC/NRtMe++asD1IwLESJblt3I+drMneEjebOmz9sWsc9iStlfPdTf/i+OvOn8OFKLfUM6WNohcf65EkhtusXmgg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB8PR02MB5770.eurprd02.prod.outlook.com (2603:10a6:10:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Sun, 2 Jun
 2024 16:13:33 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 16:13:33 +0000
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
Subject: [PATCH 2/2] atmel: at76c50x: prefer struct_size over open coded arithmetic
Date: Sun,  2 Jun 2024 18:13:10 +0200
Message-ID:
 <AS8PR02MB7237578654CEDDFE5F8C17BA8BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240602161310.5671-1-erick.archer@outlook.com>
References: <20240602161310.5671-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [az89DfLxJTvwGPqRyiYJ1EJORx8gvOjr]
X-ClientProxiedBy: MA4P292CA0012.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::9) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240602161310.5671-3-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB8PR02MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: ac614939-b2e4-49f9-ab1f-08dc831ef33e
X-MS-Exchange-SLBlob-MailProps:
	Z68gl6A5j2/PepXNWlrNMoNaS1G7uLgXpcUMo4vWkBnT142L0PGTXeKYSl2h2kpkHbSHtqxqcjJ+ygmQCrpfZJXNVl5lDAUB4k98ENfTJ/gIstTV0psUTuVEJ67urii9zQbWKujWOYF/8HknEbhfFUhAFHrQmSM0ZzgMlGbZZoOjX3/syDeqGDmna/v3tOLXoVN8Elo7UIoI/TBtNysgdostAf+sTgdhuop29z3KJ2xDqVHuH4i2QCe1S8NB7IQEYCJnP+7eGmfRN9YYNAraZZiSSdy2Jhz2TI8p6sXRmpGS1zHh9NSpwWRwJzLiV+KtkNAogIdvaKiE8rHnwwSY96QaABhTwR1P72bgHOTb2ytOS1EV8lIvjO6h+8CJ6sImTTwaXundjGoPeDJnixQwFvX6y4EI/XPvM/dlI5tlqR5uTrgtWrpBv1clf6Zgs5J1AqS9GEPZI/di/SWAAEfNqbZbazMI5QWmX+RgYa77thRx/9+JiJzJF8juyJIByGO+UHEA7gm9CfrkMpBJy8pa5cWMSPFDYHj5nrmy6LITPalPQ26TziWRtzGR0HaBYfjOa7oEkxFwjbcPSfHSMq7Py6mfVCkhLyX5UEfGBD6PyHMzea9nCLw/anZDnkDDxDAA/rG+AFOAlE5LjQ7F6T19wGKxH2/jVQRx7AW52L5W8RR+AIfBPwwIXo6xX15qS8o9pO32LJuZxP6/r5oCBEdOb98Y5+Ksuj0gJtvWxKLM+co1s4qeOnoy2Lxpg/3Bw7pDLanBOiz/R0whnvbf4EaCPq6asOctHgFFXzSJCKP6TArwkKBLfbIzv8Fmo4QlnHWJ
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	1M6q4aqO2MFIUPqu2/6AX7+TLKh0mTyK7WKUkueoQcIENi7ovWB31Kf8K8tzi11UBCWySJygH/MUuWVl+WbE8AyCPs7NpKEh/kpdxhKN32w2DCube2I/3GN70BlAQls0Ux5xidOKKVSRum2qCxzVYPjOdTCoxFgJjzznfWjZIfKRVRv3oAMjesMURzDjmzeBnLqcrqz5544LbSngHTa6Sw2m9RTVivy1K30kG8jelX3UwQ7EgVbBdOhIGIkOhEsMstGYxMVbghe2p8HLEHXcTiQst1E9xf1QzshfSulPt8uAxkpZKC9HluFwQVzprii9n58HaGgMEgVruuVDmpJPt9plgrPKMee+VpZQ6ivV2siHb+9HaW6tvi38O3BM08BCjyTEUKG4nWxdQKrqrIzz9C4rnrMiuvYCOGx7NrRF5w84AHeANcTn2mPqTtoGi/U2M6HKbQ9p2L3iWU9NNuSauCu4EyWR/4NkkgUA7JUOTVHz0Fbv2yuRwpOAKaSxV3FhnyUy2cR1ZtZm0RAvYo3dGONeoUlT5HbhK45Vqf7g6sbcKkbC3+C1cQiBL5wzKbCQryh53He89wppSSxmrWUS8FdwHu388Onpq3dXkgegskZK+QA3HOrN0LrvUpafDa2ooQQhWuvEgGMCHPBv5i3qQ5HBlaYjKFlmhdOT6bUONI/788R1isp7+5br0GMsFmTcGigJImtU8JOhd14wGmgZVg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ovNg1n+1SOBlpKczqP0m63dSR1454YdTzqfSuIpg++asG1X8/TWvZEE312c?=
 =?us-ascii?Q?lmjdQYSsritfBt/Ew+hmWjr/AxVoHUZl9pSYqu3WkEwtXWlaq/E3mXK4glOs?=
 =?us-ascii?Q?V6V3Yw3SI9J+scHwJ6JUJw6MCaEKcgC2ZYNpecfqsq43iMIgmgPVaRxAsIhP?=
 =?us-ascii?Q?8L7k550VvfPwSo9nQVEvxMy9Ou18phyKOCev/IbmqYwJRys+mloz7PGB6CBl?=
 =?us-ascii?Q?teK7uk4srYr2ZKtQL5t2ZpfrS5e6JFJDKEUt34Gv9CaOU6YpRKcJCyv8QAcp?=
 =?us-ascii?Q?mKtAXV2JsuHuiHToWvaASBXeQS+FpqLxalUF/qsyISr6mw8CD8OYTYZSF+fV?=
 =?us-ascii?Q?mJMAGQXz35cYffjl6YJLWWalxA/1KHpnuzALYEp7p6WYfSN6D1JtmjwhafMR?=
 =?us-ascii?Q?GqxZoxtaUM+kua/4JPgkDT4s1sckEQ6obq8cS0XCqwo/DrkyKvGUH+Cb44DF?=
 =?us-ascii?Q?Fvz6AiJYWZhlS+vJPjrBPTLHdV5S3MZRpCzUm1v0ldyXX8Am+/iFer/OU0px?=
 =?us-ascii?Q?jIfJbbf7VFN+QFYogKi6+GXkUyuyxRb7x028XJv1XP/Gw8864TiuBlAtqNS4?=
 =?us-ascii?Q?OnrpCl2modiLT25WlRvdoXdVsySq4Iw5vdfhqCz95SYUYNY45hfKIJjpm/zY?=
 =?us-ascii?Q?Eiw0z79AB8u70Rp8pH7JCJXLrwe/LrApwH204MLl4UGKkBnYJ8oj0LAaASsc?=
 =?us-ascii?Q?ZcVo6pdyahgESYlPDTalgDrdMm5Bz1XARC+rBIivlKVPIyitQ2naCfVYqI9c?=
 =?us-ascii?Q?+ATtbzlWW1j8giG2dwGoQL7/ozbp/UxcWfT2J8Jwc/1oRr+jbOFPml66eKWD?=
 =?us-ascii?Q?L/Nj20EY0CeK3lB91H1o/E2nKfGlF5wroukrakTVUKXyYDSeIJckeMLhJ1eJ?=
 =?us-ascii?Q?GHeAv+9s5Ag0k5JbAq2GLFLKX4Vdx5FX/gpmNrmIEBShTQ2v9MKF8cXWJGT/?=
 =?us-ascii?Q?+I/mDd9jEtCyORGL2tljS+ckPUoUrvozD7DpdX6F+33ENPeTbr3aUqmgdRx3?=
 =?us-ascii?Q?micv4PDCpRxaZlYzekITzlQ3eQWSDGpwUpOkCDUOty8KYDz92ZQ9/SZoMJNn?=
 =?us-ascii?Q?9XjMmPRKLlT2s4MiKs+NY6a4l/P8Q2lxYhcZ/v7j0w80TWCiDuE/pqp+v8R7?=
 =?us-ascii?Q?OFHGIOv8lSLHhVou7ofHouZ+W1WATttR8n4u2E1F9CHWaz9oqw7SfDirjUbX?=
 =?us-ascii?Q?j0O+4KNum+AL6s4cyH96oT1GhMNWoTjrPNrbYUE2Qm03l02EciXuMtGmq+q6?=
 =?us-ascii?Q?JbMVdDjIJrS5Em/0hbPv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac614939-b2e4-49f9-ab1f-08dc831ef33e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 16:13:33.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5770

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "cmd_buf" variable is a pointer to "struct at76_command" and
this structure ends in a flexible array:

struct at76_command {
	[...]
	u8 data[];
} __packed;

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count" in the
kmalloc() function.

Also, declare a new variable (total_size) since the return value of the
struct_size() helper is used several times.

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions). In this case, it is important to note
that the attribute used is "__counted_by_le" since the counter type is
"__le16".

This way, the code is more readable and safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/net/wireless/atmel/at76c50x-usb.c | 12 ++++++------
 drivers/net/wireless/atmel/at76c50x-usb.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 0ca2f629683d..baa53cfefe48 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -721,9 +721,11 @@ static int at76_set_card_command(struct usb_device *udev, u8 cmd, void *buf,
 				 int buf_size)
 {
 	int ret;
-	struct at76_command *cmd_buf = kmalloc(sizeof(struct at76_command) +
-					       buf_size, GFP_KERNEL);
+	size_t total_size;
+	struct at76_command *cmd_buf;
 
+	total_size = struct_size(cmd_buf, data, buf_size);
+	cmd_buf = kmalloc(total_size, GFP_KERNEL);
 	if (!cmd_buf)
 		return -ENOMEM;
 
@@ -732,15 +734,13 @@ static int at76_set_card_command(struct usb_device *udev, u8 cmd, void *buf,
 	cmd_buf->size = cpu_to_le16(buf_size);
 	memcpy(cmd_buf->data, buf, buf_size);
 
-	at76_dbg_dump(DBG_CMD, cmd_buf, sizeof(struct at76_command) + buf_size,
+	at76_dbg_dump(DBG_CMD, cmd_buf, total_size,
 		      "issuing command %s (0x%02x)",
 		      at76_get_cmd_string(cmd), cmd);
 
 	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), 0x0e,
 			      USB_TYPE_VENDOR | USB_DIR_OUT | USB_RECIP_DEVICE,
-			      0, 0, cmd_buf,
-			      sizeof(struct at76_command) + buf_size,
-			      USB_CTRL_GET_TIMEOUT);
+			      0, 0, cmd_buf, total_size, USB_CTRL_GET_TIMEOUT);
 	kfree(cmd_buf);
 	return ret;
 }
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.h b/drivers/net/wireless/atmel/at76c50x-usb.h
index 746e64dfd8aa..843146a0de64 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.h
+++ b/drivers/net/wireless/atmel/at76c50x-usb.h
@@ -151,7 +151,7 @@ struct at76_command {
 	u8 cmd;
 	u8 reserved;
 	__le16 size;
-	u8 data[];
+	u8 data[] __counted_by_le(size);
 } __packed;
 
 /* Length of Atmel-specific Rx header before 802.11 frame */
-- 
2.25.1


