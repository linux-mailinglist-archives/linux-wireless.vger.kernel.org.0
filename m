Return-Path: <linux-wireless+bounces-11241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99D194DA76
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 05:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDC11C22045
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 03:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036E14387C;
	Sat, 10 Aug 2024 03:52:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AF1428F0;
	Sat, 10 Aug 2024 03:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261935; cv=fail; b=mNvLJLugbTCTUMkE7vgBAMa1pD8Vk9bHKvElJ0zYpy2XsGoW/Ydm0EB2+FR7JjjZsU87/d/kDw7WUUa9pwLZ5gJJqEy/J9wA0GkKzWl7xK/q2R8Ouo8jRs7bpxQVtQq7ojJ1xcjNsj/ST8A+vmLr9KWPsmNYLOj/wUSgpNqWDEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261935; c=relaxed/simple;
	bh=z/JMI1ioorJsC5rpgzgpHUYttwWsJh+gThzg/mM6S6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Av/rZEesLwsNGnsCY5XTrvyOv7fVYS7NTnnzSInDfncTW6O4PVW+Q3cBCF0kWUT59rNvGuEK/U0NXxBgmy1i7Iwi8FDmdB7CAl1nyN4yvCgjrwgpZCbtkg1433WER5ILlUaZVyQTaW5r1ekg/wAt3luEG+2Vy3/sE9PEv83tHQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihRfwKKkoa4nMVlikrqu538qpix78VWpTFmNFPMeyyAn8BXxtzowhFIgFLYdQX4EejnC+44vnyeABqlTvG4jDLmRQmHsQpjIWyc7b6jJP/1/EcrztCQHKNL37ovd3yBPB1GxzRxdim6kWOglaUJ6VCT7Hg/guuAuYMggT5wcDEp0wyI5a1AG0hQbJDKJ3oyci1b12izx8EXtnsY0Z050QHTEpTp8/ke3L7lhm9YreuGPUizSZS/Uo9vBWjL3wyPNH7cHvs0GaKaL0md4+sckuDZ5plk8IeuNZx+WRaxtaf8wze7BfSYnChaXUOEwxxrYLzG3Mbnh8kxbxcDvPnsVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWqN2d2WV5H3rjNNY/SuBA/Is/G4XlfllfCP+MEOJRA=;
 b=fOzK23LXA5zYA6yV2wXIxUQqTu5meEEAfEjx72NtFw/ACfXa6xlmm+GvAt1+kGDzeiHKz8K4Xl3wfnOzgfT6xmPBVVijIoyBUcmKAz15/4PrdhI0RsgbNdUoZdzGQIUaov5/CSQwegzvLtBTyGkiKc5oq/fxJruYkSMalVeChhQDqpo3Ei/akpCVYC6dRzYUsE6wcSZ2Cu2Mv/KI0/lUrFl4gZKp9Ge7WZaJ02eInbGWu9z1eXeILYOlJUq7mUy0YUVCrirmxPCOVbAMi6jzAYc6jS5dr1rNUU0SEv7msw0I3wfgvfFriCwqspHs6Rb+DSxZ4fFL1faiWdVMLdH81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB8564.apcprd03.prod.outlook.com (2603:1096:405:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Sat, 10 Aug
 2024 03:52:11 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 03:52:11 +0000
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
Subject: [PATCH v9 5/5] wifi: brcmfmac: add flag for random seed during firmware download
Date: Sat, 10 Aug 2024 11:51:41 +0800
Message-Id: <20240810035141.439024-6-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2abc559f-4342-48ca-1ad6-08dcb8efd02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iKmv/fk0IAMayeJQ4kM477c9W9rh7gq07wSwAinVmkQ6pSVicBQ4WH/qii1d?=
 =?us-ascii?Q?lYK6yUAinzBkVysaH8K02kb+IbtqjN0mYXR3xbgTVRPgaCPBzbm8uzj9lMBv?=
 =?us-ascii?Q?7cN184wfKWDYLhX8roX0RsExAm8VC0jyPLO/PrUWy5JNlMMLy5KM+zkOu8aR?=
 =?us-ascii?Q?JEn5c263X7AWjj9P3ZXHZBssuWEqBoIRKgDEvcsWJL9dWnvFrcJdoI4pFQ2A?=
 =?us-ascii?Q?ptPH/sHyjRA1gLTbZgrtzhdum20xerPYm9D7NO0ebghPt7VLgrcP8qeHOsWb?=
 =?us-ascii?Q?teapZ4eWZkoSz0iYP7CC6aBQrW87iGdqTR2HeQcZXmT7nChmhz8Kqca2Mohn?=
 =?us-ascii?Q?vac45F5HxObe0cZLWMn2NwvrhBPcCdW9stxHrNp2U2BImO0Vhc+wIYYGfc7a?=
 =?us-ascii?Q?jBnPfXKO6N5aGFe9BNW8d3mEGyed2sz5Zi4q1MLtKaD5LlVIV6gpJflJQZFi?=
 =?us-ascii?Q?AntQP8WEj7jZLKzbIxBj9v7jv4OpTBOSoh8bwnLWeBang7TN+ZdhE7kwUP+z?=
 =?us-ascii?Q?ECHw9L8kPPRcoCIrbvqHCtdLEVz/329YTzaPJDY1OQm4dy1y5YM+N2US6KvA?=
 =?us-ascii?Q?CjlC6Oz4Kawnoe6F3ypouR2alhLMPPPA6SvmJIV69WdSa05TwzdE5SZoFXnY?=
 =?us-ascii?Q?T4y0V93KFCprwoe6wI/JF7U/+wOkMeRM8NOWi2gB+zVyg74r81xPpHH0meyP?=
 =?us-ascii?Q?cPm5CGYy6uMXnp+BIaLLgLegJ6yzH4uaUR9l4EClVV79Xbv1z7+qeXxyJHH4?=
 =?us-ascii?Q?OGZdxE+IrUbJCpdNuXPo/YxZYB5gxJaLaebJjgbdtolU2eOnIL2rCTWRwECa?=
 =?us-ascii?Q?Q7vq7LTjsCGKxBHHkbzSLvUOatgxUTYrpDjrQuTFSil8l1Hz0kGgJ+Z+SKB4?=
 =?us-ascii?Q?c4qfcekOYwn3Z4FQQAhrUpLLw0z3/IyTurATy/UZFDcWqgjm87CCTP/vzGbU?=
 =?us-ascii?Q?GRsJKk720PsGsjwTgBwqNiaw4ed4/qNlIDZ0RfxhmZB6bDPAFFWV+sTdOo7J?=
 =?us-ascii?Q?rcHV7+fzE5JwfHvXfiLqwg0zAwL1WfoLGqm6zFOV3jGEcTs5rH+nilBerScr?=
 =?us-ascii?Q?13hAIQZqX2XtyC7j42j884e6B5k0JyEPK8PemksQbNZcLz9iYbMBNxP3jSaa?=
 =?us-ascii?Q?8BTjlM0uLRdUaHcyhwwn+K+eKSDSwjqQXU30pU9NwfY2CxGSYJOBWlLY+y8R?=
 =?us-ascii?Q?JgpiuKa/sta9P6BqJ3zgOZU4y4NEeuycFnm+LLLBTtxb1xJJQTzvuX+dES/Q?=
 =?us-ascii?Q?+AX4X/diPuDOMZx36Hw+2qT7AMuQRtPw2cL+FGl/6KVL75bargMJzxAHQPno?=
 =?us-ascii?Q?0u+yxwDyH2JYDzct5XG7/1rINGiQOLwOlfSauREQct4Ws2Njvuu+VGP3zXL5?=
 =?us-ascii?Q?Bmvrm4z5UFVUJ6sdgGT6zfxIfy603SUFb77F1D1NYujq9CMQFno4+qKdn7CM?=
 =?us-ascii?Q?OiIJ/5ZaUAU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ciw3Dk6Ql1aLh9bPQ1S8VeuP2kG4t+mBpFY00N/BrBqTy/cfEgSqTi2v6+/b?=
 =?us-ascii?Q?SPobHXgCRojQVlobhivqlrGbCUTvBnGgS5K1O9Ik8cQ5UKg71Vu8TmLzopRr?=
 =?us-ascii?Q?AmoEyfj/iq9HwcfSXiomvoXmUPo2uY78J+A5Agx/8S/nrU0UJnlwfaw2Hj94?=
 =?us-ascii?Q?nvjo4z3d7i+Q1SzhB2CEURwt9SxBka980qGO+J+erJLphwEW4d/ht64D4SvY?=
 =?us-ascii?Q?nT+Z2KRUh4Dr6gC6fytYYNw2hny6dW1nPHF/z5+nBZeu7mdjfUpc+grjIUvX?=
 =?us-ascii?Q?rnaHCgg9DRsBszNEPM5WkFrzD7lm7CvyaDSRWm7u1VN6ublrq7Ft0Xseb4oz?=
 =?us-ascii?Q?IDK6e2BBuoSThaZP38Gxr6dJYIqpxJmBvBYBQnYpNHWT/tIUBxA713XapKVn?=
 =?us-ascii?Q?MNgvpHwz04P/VEj1LwmNkcUlUlviPVF+cT5gv4B/Mvp35K9sN8kzmWfcSwXn?=
 =?us-ascii?Q?UjlRDtbaV9cC0w6zPguXNr7YRNdMYpDxCRpQBO0hjM/KT4v08TkEEAJUguTd?=
 =?us-ascii?Q?2N5gzcO1fDSvF4gE+4KOLtjB3YbLTQT94k9e0Jj08JMGIa6uGoKe8JkIQJfz?=
 =?us-ascii?Q?gM5UezhXcSosDzoW6wdI8abSxcUms+ncF6wSRBQY2v4kDrGEq6cIncrAVPwi?=
 =?us-ascii?Q?KKzgtw+0QVDv2O6x0O88QMGsXqfgE4Mor8HP/fkEaGhwWGLMeDjuFlbB/NI5?=
 =?us-ascii?Q?fsRIdGwhlMaetvDnSC5bVwR+fM7fsw6AgGlfgMbFZJ16tuaSup6IkYYi0C06?=
 =?us-ascii?Q?xAI/qJu/mG5cIu3ZoiO+qLrUF+nN/QjbzoPQprOWdrieX6iudkReaOKWegz1?=
 =?us-ascii?Q?5tB/oZipMJAD2d7561oLOygvEyCiysZgK3dd7IaGN1FPpGOpgmfQ6OKrahTD?=
 =?us-ascii?Q?r5b8JyOVZEp5yiftQEiT+5YMoEvJiMnFDmFOowO2d6lF79mWaAivMYVg21XR?=
 =?us-ascii?Q?EhFZX5FmrWzyGLD8ylrg8YX/P7SViIctoCaqd9HTMFvh2WQTfLsuJoTZpmaV?=
 =?us-ascii?Q?b4gLveAiFipaxd99SIGq0NaQFR3ujOjp63VAzFmFjTBe8T6t03b/uEBXkyiC?=
 =?us-ascii?Q?C2uHPRL0jNxK2XgDBYxIT1acJVwNLVG5IqDdpH0j2dLcI/cfqMK+G/ft7Ss6?=
 =?us-ascii?Q?OY8sGr4DBgW8JBq8PK+viJQXDXH8fxTak/9LHdpbvEFT60e4AF7v5s5jcw2m?=
 =?us-ascii?Q?t91E9Od9ymfmEiKBQ16fQoYOmoqJgjPePv8wivxPYfvF3FqLydxQFjMBb99/?=
 =?us-ascii?Q?yK8r/RmobJaS7szI/A+1LhjYbKJLFLoUxsml1Zv6QMN/XkMMB7avcq25ksqq?=
 =?us-ascii?Q?vGoYN3XSQ180h0kUE0xGxP5ksNrZ6JjZAQqXK21+GFxtfI59+coF4dNSnLEd?=
 =?us-ascii?Q?J2CQUcUw+Oh5JSmockGGHw29y3jOp2C6OMZR5SMNYfvAfU66/l6iJXVXwYPi?=
 =?us-ascii?Q?bEWKhYP6yM/HdPrqTarF1F4dlt5hueVEJ2O6p5IVhAWwzhrtSHWTbd2jPk/B?=
 =?us-ascii?Q?3hxNoAP4jqSPOzofAFhm+FbICLNAuXfLC2OgrkUBnmsKp2fBc6BCNaeJtwyj?=
 =?us-ascii?Q?Fd3pYK/kPqQta4WGfHBeeYaHPl12oclYb3TG6CE9?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abc559f-4342-48ca-1ad6-08dcb8efd02d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 03:52:11.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pnixoV3NL/+I/+pfEIlifCu06hcqA6ssyzAUqhYH5/zbM2b7H+n4O7NfObie6ckY8RTA+/wj1YJRI/82sST8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8564

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
index c34405a6d38b8..e88fa4cd62a1d 100644
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
 
@@ -2480,9 +2514,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -2668,14 +2703,14 @@ static const struct dev_pm_ops brcmf_pciedrvr_pm = {
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
@@ -2703,9 +2738,10 @@ static const struct pci_device_id brcmf_pcie_devid_table[] = {
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


