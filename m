Return-Path: <linux-wireless+bounces-12110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA9961D30
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 05:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B871C239AE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FCC156654;
	Wed, 28 Aug 2024 03:50:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F0155C8C;
	Wed, 28 Aug 2024 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817003; cv=fail; b=ACgy/qAA/RDg8HhKB2/uh8W5ONYsaQQi6nppQyzey9z2j5+4sXJSQlLYqPSWFVeYfvNCaCr8TJFfATsUXTvVRByslqp9Iqn1/tUyF3JtAL/BVLZhsyAUznXayjEngMBtmtCI2F/Pobi/rU/X+VLN/4ybwbRyC+158+9QVwUUiMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817003; c=relaxed/simple;
	bh=IxE5Om0KesCF9OD2iKf9/48PjNYY0p8Qn/cbFbUhE2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dp9DkTvtgh6/18MFrEkz2Jgj2Us4CGfs2fCIRDcse8tc+qT2hq6J8rnxlgqrytw1NnjkHQgmCYqU7tAKyQrxGwid4nz1WvMdwBLAaT/TUZUdKSzNn58v29+6dTAcDQBvzVEeNZUS33FbQrSyfm4oUX8kv13Y7A160sEWc6xh+tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwBi63me65PG+mxptmfV9dZJpXeYvgiQ+znR+Gn5zsjUo9kM1ci+6XcMVerFHVUMdbencm3EA7p99JZFdCSOgQBygcTz0DW2jbjq/U9O62jx5nG+WbNBC5iad6nxOGCwoGALf1M+qRQWOAmnNNG/Lr3P99jJMwOU8FOoHPuvkTSuXu2rVtJfmsJxM2j0F0cPYB4dKjElYR0nJSfuDWW2bCUHegUmSQfVyMxSTnpx7/+sn2sTPsgOG6d2ZuUYi8KbRFrGVK2c90P8gMpRyScDUpkASIkRJfHyoP9ReSrhmvVz83e60NUHSYe6gG/YKkClqc8Az69z0IB7fTQHtdqoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LRnI0UH7UZG4g9HkC23GXGUDdkH4KVjXqUKx9S3KmM=;
 b=K9PJPE95zzTn1ie8a28g4QF0Di9rMJFvTgf9qjt3r+U6S4jPWxAuWlbCeTU2pUcettuocLEflFRhynO0nhtaLv5ckD4ApBH0sj77A0BXV9ctZ8tPMykN13WR+GmoiyHqE7d0B43Yp+CC/N1n/CrfLUJiaoPMQ9XsjKJQgIT3uhx05UUzDjEkbdzafTxNo0yon8qDlmrQSH12LD2l1nRZiKx2kKMHNigodQhZYXxAFeB0ptWjGcv4Q721RsiznsXsVEmmrr7OrIuKFrhMxSa5U7YK+4PTQkmCTqaAHbitz9pWK0uC8X7xqapc1HJwWHorLF7+pG/ZCNQokdArSCVvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8233.apcprd03.prod.outlook.com (2603:1096:990:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 03:49:58 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 03:49:58 +0000
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
Subject: [PATCH v12 5/5] wifi: brcmfmac: add flag for random seed during firmware download
Date: Wed, 28 Aug 2024 11:49:15 +0800
Message-Id: <20240828034915.969383-6-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 255f8a2a-c5cc-4898-b751-08dcc7147ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fb7vNPIOQdKny5Wn8QuqCeMMuQg6Ac+1zGoGTwIp4XRka7CKwj1dq93TxkW2?=
 =?us-ascii?Q?5GrOi5Q++U8R8Zdj5G6vfH9sEdnBnV8hIJa1Z2yc6k6+jYNL7opfh3Oxkieb?=
 =?us-ascii?Q?OBxJkwKJjSNMn6pUolKx0W38W8DipdQ+Mynq6/41K/TXcJdQzR4x7SQ4C7do?=
 =?us-ascii?Q?7l37Y0ksXbkEIpEmg1HUiiNzpibz/ziisD3K4X9Kv9D0EKn9pzALQz7Ph9G8?=
 =?us-ascii?Q?hUV2V8pSLh+GZnj9GTL/PmKKudsz9stdM+G2xGmqM2CtPfH9UwzpOX4+HuEs?=
 =?us-ascii?Q?5blWMA+/IvTiEE7b16YwFcLGq9wVYuNKydufrvRXJUtwLsFmize8eywZtENM?=
 =?us-ascii?Q?K8RmaSer9mkGOsqGm40WTFhreObqX3DRJvVWm7rSXEQu4VcWwmEnMr4Fja1f?=
 =?us-ascii?Q?mTz5chH5o4nJEgLLqJC/VIhjBI2txBVjl4BbRYSWDCTNluQWVxX4MKl6lFPq?=
 =?us-ascii?Q?CTx5WQJJHqYxFH3oKVKIxqmV+dTQb0LQc0jEnnhTYgMvYrGuuuBXi2+nqHnQ?=
 =?us-ascii?Q?rOZT1+R2GY9ZnHreB4HCwMHlR6ph5jU2nE1y3R+8S4//Egka4RAXl2IXc2St?=
 =?us-ascii?Q?i46zpBPenyM1izoPRzEDRzCZdSwUq+A8aP3i6zq9q3cJEaBy94P9lP81Rx1T?=
 =?us-ascii?Q?4fDBWfd/yVR/DaMH2O/SiVZG4bxB7EbeBelGrmpMXhi65jy6hR+7oe7UxPVZ?=
 =?us-ascii?Q?39H+sQ7wyApbNegG3/jIPYHVLPdQlSO9BG1hJWGbiT820tYwLhpta9YKmM7/?=
 =?us-ascii?Q?gFzD/mWXkwIbkgvK1cJRz/pS9WXfTGtElEgXktNazzskdjHnr4RzfkytAAjq?=
 =?us-ascii?Q?VgVSJM4SEUuwuZcxsewYBe5ySMYSjPOyYEbUKejP5TK+1utEqSk+SDjPi4hY?=
 =?us-ascii?Q?bINvskhPDjXA17kkzIHZ19Eem5fDB0QRjrIKfyg//t3oVZw48eafBlJ/0SqL?=
 =?us-ascii?Q?8AozZUeQe8x4vEa5m88uG0/gsaAdXKO0UKbYCOwKWgRchPvbjWpzrScssUI4?=
 =?us-ascii?Q?ppZImNBC/w02jeOdxjD1jqenNHKaTH9lVfbPbp1ix9l9Bs0TP8BGzCLzRaiT?=
 =?us-ascii?Q?M2stmMv7Aglg8tMsmUczd6GA3FQfN7CCflf689k5foTlAqQHTgu02pppEmMw?=
 =?us-ascii?Q?1hdu/dd8MV1csYbh2ZxAXIX14BPT360s44cfMUdRSVISLw3MUVWdWDCKmICa?=
 =?us-ascii?Q?UPBeDB5eBsJktG1P6GaTd6to6VjUPwuakVD970/IVS8O8kDDq1hA8MVDn9hG?=
 =?us-ascii?Q?5M5WSd797ZvaWZAQXiZkBhFawlu58caOOyI3/JhhyCZVqxTI3z9HLtHC8iw6?=
 =?us-ascii?Q?kUc3fhETrEJjSoPXrIVB+vlIdie+GXVS7n1Aej1CfTXB/uu64P5H+s1JCcZK?=
 =?us-ascii?Q?+yLIbcuIadfdlN07GwKsptRQoNx0siv0iceqzd9iNzLhP9ITrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fbI6SneXKVEL49FDFcw5h+Ga52EyeK6vFaCIq6/chMT3auK59pE2or9z6+lA?=
 =?us-ascii?Q?bNbjHMpyUwpiEvIxdH6o6YcqVjqX+vuNnlLVfrRCtIkqTmlDNTpSsDOOWXUj?=
 =?us-ascii?Q?zVyAWUd5WjO8EigiIA9xttWuzNKMl6tJ245GrFnH66vpwWtrrHER68qM44zx?=
 =?us-ascii?Q?lT62+Jx5Wfd7ehDmhSlseqTv3uRECJAWon+qHGllor0zOUfeWX/acGuF2U1u?=
 =?us-ascii?Q?ZAeGxxTQKOe06MB2ZmN0VTI88qnUfN80pSmaSrogHSYWJFd371UagER5j+Oh?=
 =?us-ascii?Q?7IR1nzSqKHFY/ihmXRl2HBN0r7GMXqJQ5/WuYEpUMXwdB698c8/nUMzmfzCD?=
 =?us-ascii?Q?2aLsOySKY4GFSePu1VHwJV7MHqlKBD4mAVd1uffgTRWFWPohmSOXcjiCK1SS?=
 =?us-ascii?Q?UpUcLqAL70HtgJ433k3z2TkghZLIEqdYlI4TlZhfnnjtExuN5e3YatnfBqBw?=
 =?us-ascii?Q?2L7kcD/lFL9qYgnLOx2dWdChJK/IjY0ddCjBwnipJeE1iWwhweiv/xw4C8bI?=
 =?us-ascii?Q?aJkH9NJZvkCPkc63RdkLl+S0OQe6AlLUKfJcEeILXZx4CEBeXgdZPEO6r+Cq?=
 =?us-ascii?Q?4FS5tlp7I7UT+FrB2IwWQFTY5LVUV6jFrXS8+s5lk8QoOrLJghziP2XK15w5?=
 =?us-ascii?Q?aw4WxWWIgTJDudYIzxiYUKvNddhG9iCW+Uk5ibVw8IJPYXNE8xIKQruBP6dH?=
 =?us-ascii?Q?D3tMhKh2bBrejoMS3myiwWxLBGslKP3NscjbkzZbDZ+K9ZyBlgSJrdHRT9VB?=
 =?us-ascii?Q?cTlXZP42lJvCQGJJJoaXq7VPxigH2hXKMTpMpvM2k3gbqwqCr4RByAxPYN0+?=
 =?us-ascii?Q?mNpNcKD2/w0IdzKDncDzaChPmvpdnTcNCfChPrXuBRbrAvZlTViIvjm54sL0?=
 =?us-ascii?Q?+vHscZn0BZZTIOXfwaMeyPS/09118izfQluYeal3BL3vLgGiIdUzI2h4gtbp?=
 =?us-ascii?Q?YKG4mEb8m6YhUoblDOBVp17lZrsqLC7PZ2VeZS5R9RkEsVxVpxS8CjJKDY5b?=
 =?us-ascii?Q?So4CzsBVSxHurasd4lOCH/q3DZ1ECrG6GnABm/8pE2pDKSiVUVS9rQPxpSWE?=
 =?us-ascii?Q?w23bGeyhMrpQAL8AU223QVh7VJGz7DJjzRmCqPHEkCKGSFzebaT9UNAjlAF0?=
 =?us-ascii?Q?XSTt8IRSdCYO85nKE2cN4NBUX02SpzZywiVpUuCS0C6ArWhah0tOid+a0GoY?=
 =?us-ascii?Q?ImhB5R082ehksNjyjg17tc3phsymXBh4MgD5Gvu9D8HLQu6KQtfjKbjrrdZI?=
 =?us-ascii?Q?TrycOdhpxvjyxZLnwNrLjRi+klL4phrlKKjIyxgjNuq3boG/JrLcZOzenU1h?=
 =?us-ascii?Q?/2hPRa5fvIYOjgp/xp9qCLBWPiJ8xK2qP9ryLuqTmlliHjS9AqWgqCOZtIbh?=
 =?us-ascii?Q?HiMW1kf+0UqNeUVCMpupSFWdgwjo3cu/IHjkjRpX1TfEab3ynvzXEv5l3XIW?=
 =?us-ascii?Q?HJZ/qvVuFOJBU88RMzMtiZ2A1EBFmR+O+608zfYDIRR8nLkur+XsSQolfkJh?=
 =?us-ascii?Q?tMGPryLAgBAeFJdPr/p+Yt2y8Nt7gOoFJS01P8LFFwpSQb3PLkXYDeY0YH1z?=
 =?us-ascii?Q?8wKYMpwT9D78CAIrrboXZoGv2dhJRUguuzSLHA2y?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255f8a2a-c5cc-4898-b751-08dcc7147ca1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:49:58.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP6UGpVWV5a7j09RQfao4Yv0+EADFvZfoZnztkzaCLBrwX5J2TYOCbYjlPsuZkRMjhl9iDDjb59LWPgQiBoCwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8233

Providing the random seed to firmware was tied to the fact that the
device has a valid OTP, which worked for some Apple chips. However,
it turns out the BCM43752 device also needs the random seed in order
to get firmware running. Suspect it is simply tied to the firmware
branch used for the device. Introducing a mechanism to allow setting
it for a device through the device table.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Co-developed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 52 ++++++++++++++++---
 .../broadcom/brcm80211/include/brcm_hw_ids.h  |  2 +
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 190e8990618c5..c0fdaa4dceda4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -66,6 +66,7 @@ BRCMF_FW_DEF(4365C, "brcmfmac4365c-pcie");
 BRCMF_FW_DEF(4366B, "brcmfmac4366b-pcie");
 BRCMF_FW_DEF(4366C, "brcmfmac4366c-pcie");
 BRCMF_FW_DEF(4371, "brcmfmac4371-pcie");
+BRCMF_FW_CLM_DEF(43752, "brcmfmac43752-pcie");
 BRCMF_FW_CLM_DEF(4377B3, "brcmfmac4377b3-pcie");
 BRCMF_FW_CLM_DEF(4378B1, "brcmfmac4378b1-pcie");
 BRCMF_FW_CLM_DEF(4378B3, "brcmfmac4378b3-pcie");
@@ -104,6 +105,7 @@ static const struct brcmf_firmware_mapping brcmf_pcie_fwnames[] = {
 	BRCMF_FW_ENTRY(BRCM_CC_43664_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_43666_CHIP_ID, 0xFFFFFFF0, 4366C),
 	BRCMF_FW_ENTRY(BRCM_CC_4371_CHIP_ID, 0xFFFFFFFF, 4371),
+	BRCMF_FW_ENTRY(BRCM_CC_43752_CHIP_ID, 0xFFFFFFFF, 43752),
 	BRCMF_FW_ENTRY(BRCM_CC_4377_CHIP_ID, 0xFFFFFFFF, 4377B3), /* revision ID 4 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0x0000000F, 4378B1), /* revision ID 3 */
 	BRCMF_FW_ENTRY(BRCM_CC_4378_CHIP_ID, 0xFFFFFFE0, 4378B3), /* revision ID 5 */
@@ -353,6 +355,7 @@ struct brcmf_pciedev_info {
 			  u16 value);
 	struct brcmf_mp_device *settings;
 	struct brcmf_otp_params otp;
+	bool fwseed;
 #ifdef DEBUG
 	u32 console_interval;
 	bool console_active;
@@ -1715,14 +1718,14 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 		memcpy_toio(devinfo->tcm + address, nvram, nvram_len);
 		brcmf_fw_nvram_free(nvram);
 
-		if (devinfo->otp.valid) {
+		if (devinfo->fwseed) {
 			size_t rand_len = BRCMF_RANDOM_SEED_LENGTH;
 			struct brcmf_random_seed_footer footer = {
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
 
-			/* Some Apple chips/firmwares expect a buffer of random
+			/* Some chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
 			 */
 			brcmf_dbg(PCIE, "Download random seed\n");
@@ -2394,6 +2397,37 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
 }
 #endif
 
+struct brcmf_pcie_drvdata {
+	enum brcmf_fwvendor vendor;
+	bool fw_seed;
+};
+
+enum {
+	BRCMF_DRVDATA_CYW,
+	BRCMF_DRVDATA_BCA,
+	BRCMF_DRVDATA_WCC,
+	BRCMF_DRVDATA_WCC_SEED,
+};
+
+static const struct brcmf_pcie_drvdata drvdata[] = {
+	[BRCMF_DRVDATA_CYW] = {
+		.vendor = BRCMF_FWVENDOR_CYW,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_BCA] = {
+		.vendor = BRCMF_FWVENDOR_BCA,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = false,
+	},
+	[BRCMF_DRVDATA_WCC_SEED] = {
+		.vendor = BRCMF_FWVENDOR_WCC,
+		.fw_seed = true,
+	},
+};
+
 /* Forward declaration for pci_match_id() call */
 static const struct pci_device_id brcmf_pcie_devid_table[];
 
@@ -2475,9 +2509,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->bus_priv.pcie = pcie_bus_dev;
 	bus->ops = &brcmf_pcie_bus_ops;
 	bus->proto_type = BRCMF_PROTO_MSGBUF;
-	bus->fwvid = id->driver_data;
 	bus->chip = devinfo->coreid;
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
+	bus->fwvid = drvdata[id->driver_data].vendor;
+	devinfo->fwseed = drvdata[id->driver_data].fw_seed;
 	dev_set_drvdata(&pdev->dev, bus);
 
 	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
@@ -2663,14 +2698,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		PCI_ANY_ID, PCI_ANY_ID, \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 #define BRCMF_PCIE_DEVICE_SUB(dev_id, subvend, subdev, fw_vend) \
 	{ \
 		BRCM_PCIE_VENDOR_ID_BROADCOM, (dev_id), \
 		(subvend), (subdev), \
 		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
-		BRCMF_FWVENDOR_ ## fw_vend \
+		BRCMF_DRVDATA_ ## fw_vend \
 	}
 
 static const struct pci_device_id brcmf_pcie_devid_table[] = {
@@ -2698,9 +2733,10 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4366_5G_DEVICE_ID, BCA),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_4371_DEVICE_ID, WCC),
 	BRCMF_PCIE_DEVICE(BRCM_PCIE_43596_DEVICE_ID, CYW),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC),
-	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4377_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4378_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_4387_DEVICE_ID, WCC_SEED),
+	BRCMF_PCIE_DEVICE(BRCM_PCIE_43752_DEVICE_ID, WCC_SEED),
 
 	{ /* end: all zeroes */ }
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
index 44684bf1b9acc..c1e22c589d85e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
+++ b/drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
@@ -52,6 +52,7 @@
 #define BRCM_CC_43664_CHIP_ID		43664
 #define BRCM_CC_43666_CHIP_ID		43666
 #define BRCM_CC_4371_CHIP_ID		0x4371
+#define BRCM_CC_43752_CHIP_ID		43752
 #define BRCM_CC_4377_CHIP_ID		0x4377
 #define BRCM_CC_4378_CHIP_ID		0x4378
 #define BRCM_CC_4387_CHIP_ID		0x4387
@@ -94,6 +95,7 @@
 #define BRCM_PCIE_4366_5G_DEVICE_ID	0x43c5
 #define BRCM_PCIE_4371_DEVICE_ID	0x440d
 #define BRCM_PCIE_43596_DEVICE_ID	0x4415
+#define BRCM_PCIE_43752_DEVICE_ID	0x449d
 #define BRCM_PCIE_4377_DEVICE_ID	0x4488
 #define BRCM_PCIE_4378_DEVICE_ID	0x4425
 #define BRCM_PCIE_4387_DEVICE_ID	0x4433
-- 
2.34.1


