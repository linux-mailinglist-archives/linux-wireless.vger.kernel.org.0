Return-Path: <linux-wireless+bounces-10599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A8193EDDF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3614B21DFE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 07:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D021369BB;
	Mon, 29 Jul 2024 07:01:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511D130A53;
	Mon, 29 Jul 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236511; cv=fail; b=Q1I7qLGsB4TrjRGSCO6lUx/qcCbBEH0GbmYwhrOGhiK9mPvqujIJ7OkU1w9QbbC0iuRfGRRgKnggxONsL8KNc2pb04ojCB0u8bQktwD7w4LbnVjpFMG6IUy1OvVj6JN7/Yg4gB4b75o13qTujPJHSlGt49X2tgJasTc2FGw3d30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236511; c=relaxed/simple;
	bh=8fr2le2RRkyBxxo0cMbqgGIl5Pqcs8qpx2qLsAezPSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4smdgwp3nB8OccQblzk4nawEt1fj5t4ouUevSE3mxGZHohlT5Z2Hl4Q913EewFD7Sb2r2isSa4rhKO/aMT6XtcNrymve+LckDQBNDwkVoVYNiHPT7RHa0t+AybvVdAC3ATKWMtI6a5iSZwLXCSIOmBJ7pHqADx00PakFk2BVJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOvvAshdDRVXR35FHakOfCqYqA/HVyhwhx9NK4j728UHYztY3vrSR7u5Eo5cVaVDffB0z/Hg9UcQuCs2yKbJy+GhuDMcOgrsHfPtsV59rjNqI+UU1JVZqvrxYDtRjfXiYKLV0FNu3RBksDvjTF4KSbg+zt1mXR8gTXZd2SOnYUvG1Cv1QNf7+2jOTAw+b0R865jrTBG+76MwmfwKzCRT8VUflGXFRU8upEXW9uYDKUEqTOXC2/16byqLiV2pxhPjgQtH7HGbSe0jYl0S9/soPAYvQcMSoyb/cMgNFhmByKytUr0OlIamotx3CRs7bk7DvCr9RekmYdgS2MvI7PABUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB3tez9D3u90dIBU3uiBuPnvK5S2Zx5c0jWE2G6mkbA=;
 b=RH/s9QTJVpyMxEmEBLkrCxG2m2cNhDYGOZJPTcC5hR0ZWL75yv9Wpl7x7dKjEkyaYoiBjOld6gI2NVVPYg9V5CO+abd3OCyRFtWGTbyUChLOxi8oc3YFgHYOLRwFEMMplgChJWD5AkoWbDmxC+ObYiI2I8Bznd8FqQL8A/SkgdT+MdwzLpWjvSMFjxAs9Cb5f4Nsx0saUt77+LqdF4bapvX1MgMVysGwrM4TQmWy1+XtAAp7UAGmEZ0e+6Ev8ZOQzZcRy4hUYNv3+69AGI37pHM054JbTht5JG3agv/OhHH3fZPrenJ9z0nbEVUOX5LWR07c8E7L3P4MkAalHPLJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TY0PR03MB6881.apcprd03.prod.outlook.com (2603:1096:400:264::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 07:01:44 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7784.020; Mon, 29 Jul 2024
 07:01:44 +0000
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
Subject: [PATCH v4 5/5] wifi: brcmfmac: add flag for random seed during firmware download
Date: Mon, 29 Jul 2024 15:01:02 +0800
Message-Id: <20240729070102.3770318-6-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729070102.3770318-1-jacobe.zang@wesion.com>
References: <20240729070102.3770318-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::18) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TY0PR03MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 3001ca05-ce51-4c86-b054-08dcaf9c4e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QnSiuuk9oZ51A8J9BN5CHUJp7lz76Riw27M8W6j0YKtUGYKw9kVK3C2LXU3X?=
 =?us-ascii?Q?7yZPzQz8VgAQ8dAmTcS7bkAnL/PHYb/M2oYUbyCPgVCt9hsKdH9zgvXwinYf?=
 =?us-ascii?Q?9y/PALDbKH69/BRusigiG9CCJgjLi4F+dhBqYWBXlGPEtH5tf6bB/LwlRNys?=
 =?us-ascii?Q?0w4giGHx+ueZyc49D+aNtoCaDuPRnwNFk7Zeq7J4i7/zNhH40uiHFy609m/k?=
 =?us-ascii?Q?G/Ie0x5RjH6w52+5+eU0/ryvsX2V2IvQX30hXti4QfWlTGXT3wwpGW2yP1O1?=
 =?us-ascii?Q?CBc6w+LMbXK1cVKH9XpkcbQAKp3udKJH39XGTShUq3b4n1nszWjQ9oDNmBTF?=
 =?us-ascii?Q?YynYT7Q4fNi6ihkRsjJ7hA4y+HU8N+DOZcqsBFZO0n1lQu/gJcMd03LEqNsI?=
 =?us-ascii?Q?5e6jvCX9vuk1hL3zH/rH0yZm+Dlgm5AUJiPHFHKC7lGo4IzeUcM7QrR32UmN?=
 =?us-ascii?Q?Vizz7CRt3uIoN/hVl/ucYA6qJqg0kEB/ijoQDkNKBo6TfWjtS7CNEPt9+Vck?=
 =?us-ascii?Q?TgRMqDK30GSvTxtTeyPb3F8xkstFoJLvji42xSD2zQaDN8cQ88HlG0gzbTot?=
 =?us-ascii?Q?x7UpcurUrLMppT1l64m14uQytG4kj/QsHJPgqlNOIKqABM2Yn0J+DrwOHVM6?=
 =?us-ascii?Q?qWjSGdDgr4yyhuhFkHaswV8vJZDjIVaY6LP789yMixFKHwvMCzIB+fr5bewE?=
 =?us-ascii?Q?J4e0+yy2bbBwoQyfVYv01rlKK939Fc6y+Lmj/+v9opoUnhM0vHeipC4+BikJ?=
 =?us-ascii?Q?ydqv7C/YpStbeQujO8XpjqGhg8qMIIyw4SGTIn9tk2dLIDArJepKWof27jhB?=
 =?us-ascii?Q?LoIH034FhEFyt9PnXNVAOcNmlgV2LXndGGsHd+il7qm6Q4zxjNGWqPr2zzI1?=
 =?us-ascii?Q?+iH7bnzaP+WrX4DTlLCCWVPtRJ0h5PZm+Qges3uStAeO6jUZPK2pI2rFpgNn?=
 =?us-ascii?Q?RRNbKvFhzdZP36iV5LITRUgMN0WeivXW3fF4I07/d3FkghVMtaInKOdtZ8M8?=
 =?us-ascii?Q?4ul+n+937CYdnV65R6cGBEHdlP8kkf9VQESPEtvNMyTxtqN/1hbGIUR1ZqCh?=
 =?us-ascii?Q?f6deFQOK/ym+KOwecHZNowqa7BshF9x33yJojK2A9jR9DiJGYGGmtywSUrWw?=
 =?us-ascii?Q?/XOFiTomT0DbKoHXh3vzXTjptFwhOQs9o1sizOdtYFV6sl6Vo7EgWa9KEy0a?=
 =?us-ascii?Q?R34M42OnWJP3UiwZip4TrZeHTb1BtK9ZVzFS8oTVSyt6lNQnnQR0pgD49934?=
 =?us-ascii?Q?WH/LtMJ/F++GsWJOlXOJO/i/L5gQOINpPaeKzYOZXJhCMjWNSP9yjlk1Rkk3?=
 =?us-ascii?Q?eVdUnbZcyJLeEHf3O1A3gfHBzIsfsJKJWYMyEnBBXP+lkAObE/wj3vPpdS4E?=
 =?us-ascii?Q?vLPtHurFQWjHCtV7OE/V/ZOQ5Sa8qGii1wEsqbDkT8qfqL0jJvY8GncrZqUi?=
 =?us-ascii?Q?iTXYGJHxNiU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LYcVsUkqMadZJCeccrkzS8bF8bHWlSnZB90beO0J1fNiZpEKARdJWH2D351o?=
 =?us-ascii?Q?rj1Y8mce8lYJKaRAuE/xyWJ3ITAXzjyDLeCVm3dgBIswjwcs/uUEuz+5C+kV?=
 =?us-ascii?Q?k7Elr6y7lv6MYZLsSxYPjwZjtLYyzzehUJ7awk5OUVKcQgtTPJ7OCETxejN6?=
 =?us-ascii?Q?es97eFEK3nBMyYQsfWh/+ypx+rKVW36VHrdsZuzJSrOYv5W0+gyAAMxXHkgI?=
 =?us-ascii?Q?sFR69TGuYODoEAjX5I7yDJHzA1Xq8w4RFs2Y1TZM34g5hXA6BZdKJMcm7TIS?=
 =?us-ascii?Q?tKPw7fk1iDnMj5QDMugqcq3G0HvUBhkAEVvpDKNR0xlI05ZmjmJfYVN4geQx?=
 =?us-ascii?Q?bskrrG0zDj+Lluz/PmTo98k7yqHf+RJqnOYDOTo17GWyOq+50yg9Hpeouv+P?=
 =?us-ascii?Q?HsLXnpi+nkG7xvieNVx1pUv9t++Z3DQNWJjY/DaiDczisdiI51hxJkPvnVfs?=
 =?us-ascii?Q?TS+eqpRbGx3nIWTlhaz7X5VAakNEW/1mLiPZm3JDRgvu4vHyuSmoewM2YXE6?=
 =?us-ascii?Q?fzSdmiZrNuLe6wyqMNuxgLZRujuPFk/jt1COxxJ09PthVkQUcKbQlYwr0E23?=
 =?us-ascii?Q?uLRVQS3W6fkwIpnsYlGviRL4k9WLKV5TYOOuhhRReOiLMVbWKyLNcYgDRIaV?=
 =?us-ascii?Q?88t/j92APa4wFIZeweUVnRd8NT3Q3R0H0msC0KfgwggxZ3Zo6CvgSUNHIPmY?=
 =?us-ascii?Q?rNKeLm5i0GoC4EXg0wVtoga9Hx0YZFZTe3swqXH/DbwRDZr4uKbNYyECUhmT?=
 =?us-ascii?Q?PcNQcn12MNg8QQym5niWpIRjOYPi6ly0fiA8T13gNr+CFcWuwo0Uf2BSNhcE?=
 =?us-ascii?Q?ePQqEpJHeL3e9p4sJ++/TJn35ajLVuSvwLEfTJN2OAWBlfp8IwvQFLXYw+ia?=
 =?us-ascii?Q?IKBaK5DExKQD8h5OwqRpDFbUIQpyrvyeev/Cy/Lo1p08bIjDK0dLyBujlDPU?=
 =?us-ascii?Q?pgqQuHCD7R3LWI+nYEJT8Li0wfkqSF+wWjazxnKn+EwyjmgxE1HYIcOO/WrJ?=
 =?us-ascii?Q?OhdnlDakc3n+LabR5Fq6Kr21YF78Zj2qmnvJuSVAYLZz1aPLbITLCm8Qx22s?=
 =?us-ascii?Q?wwUWwe/4OHI4MYXtMPS7dasNLLymf3ERlmMFfGNuKR/M+E3AGyyHYkASfMPJ?=
 =?us-ascii?Q?z++mjTe/cewgEj4TRbB0XUbGo/Gv24IEiKnumloMQpEgTcak9GBX6nxUtdFh?=
 =?us-ascii?Q?2lQJujLYYE4tq3Tzo7dfr3z3rfTxWgGSrnTskmlSl8TEOiDnKw37vmLdoffi?=
 =?us-ascii?Q?6Flp4up5b+6G9SmqbsbKf4QkCYJRKs2/jeYup9mwGyXgxoHtP6tULc1QXsX+?=
 =?us-ascii?Q?rJkhfsSpBWrBy1AMf8xwSmpRMs5wD5Id4lhH8lrlDCVEAzmC0QiYfUgMkaNg?=
 =?us-ascii?Q?znUgEQJs7p0qDcFmXynF400GNrWAalQzD422TLaW7XTgsHS816JPRLIV1vv/?=
 =?us-ascii?Q?Kgbq4uIPi68ecqH6YBeBD3/FV/SDxYTqsJ6cRHRYqYAlkAszqQ0VRoQ98KcB?=
 =?us-ascii?Q?nFdPJQmTq/CNxJTmcWJvweeAwiIElEKLZFiIZriXrRq9pBkAJX8DzNUduHsM?=
 =?us-ascii?Q?Qa/LaHYbOisxK8rr2wRCD25wxpcMcqSudh5G8T6Q?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3001ca05-ce51-4c86-b054-08dcaf9c4e5b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:01:44.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQO6tfpKSrtFAYeDNsrX0RBClol/Jg7pDIdhvvIUvy+aOP3icCp6S8wflnnB9u5n/VuWQCfL4S+u02YH9aXHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6881

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
index 06698a714b523..938632daf30a9 100644
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
@@ -358,6 +360,7 @@ struct brcmf_pciedev_info {
 			  u16 value);
 	struct brcmf_mp_device *settings;
 	struct brcmf_otp_params otp;
+	bool fwseed;
 #ifdef DEBUG
 	u32 console_interval;
 	bool console_active;
@@ -1720,14 +1723,14 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
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
@@ -2399,6 +2402,37 @@ static void brcmf_pcie_debugfs_create(struct device *dev)
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
 
@@ -2477,9 +2511,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -2665,14 +2700,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
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
@@ -2700,9 +2735,10 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
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


