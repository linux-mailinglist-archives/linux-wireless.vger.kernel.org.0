Return-Path: <linux-wireless+bounces-11508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAF7953F52
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 04:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D814D28835F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 02:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5E8063C;
	Fri, 16 Aug 2024 02:07:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1E97E112;
	Fri, 16 Aug 2024 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774024; cv=fail; b=U670HacxFzB7Lyz9h+HRZfnAyefH81MTh7XtBFV1g0TWNByChRVRSfNw3Weh2ELUzdAfw0mqCp4OPgjRx83ohWliTedlfGJRjlC0PBmWLCukeD+zLl21JNs7ofGyjcsfsNOrmDd+nQBEuHJ3D3WtikZt3qX3HDWcjtqM0j/3CDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774024; c=relaxed/simple;
	bh=z/JMI1ioorJsC5rpgzgpHUYttwWsJh+gThzg/mM6S6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdX1xiPOxb4PaSQ3QLfIh9gRu6zIydUhin3L9sRspsXrbdlE7vurRmfcmfaHBFcjTbtTPiHc5BLZxxB5xfvGxsWPIdMRmcUbaCH4LP2Oj5mjf8+hBoaJzLT0aJvf3RmYXpOFTMAbiVodsdlvRS9xOD7lOaEXdKcn9bvvyV9CVT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cv8UBn5qlQYpG7Bvj2DYPzoIQx+ZdPsZMjieLxWHSnbHkkQ7UL3TwS0M+IIYmgtHzXmOUtM66DSNFxgJWy0Z0gD06iQonjWRHdF9Cd2/hLoVrfk3mxR4Fespq1g3QZ9+5hgX9D3DDzneozdx1O/t9Ep4jUq33x5y1E9qJbMyktolWWdWh8OCr/iYiLo1Su4i0vtKYBd+zjaRoeC9kGzKcpVwa1MzOWT5w5KSyTeAKQYGThTjIZDmAfPfu0StlYUY2slCwg+kEQAqzLoJ3DIVZ+9SzulALEIrCitaYmZh3hUeqWrWC5dwjBEbkrqxf7E24A7ZMQVt0v0c5HCpiDa5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWqN2d2WV5H3rjNNY/SuBA/Is/G4XlfllfCP+MEOJRA=;
 b=OSUNcSlJeu7g6M09PQq+fzl7tJOPPW5JQrWRKm9XMJVlev3x2IrPHA5PGl4gGS3HqMjiMJYxOseJIzUumt1NOSdYGquxyusvT3hBUNbIwVKwgm6oeRUYXXr5pIlCbmVk0Ie2FBN2sCIPka2wxbcT79otvyyWITmE0rt4f9d8rGA9vtdCnZFMpOTfFY4/3lcp9TEIqSdCKvbx/H4wIpURSUayMFJEYoEz2yQlrTtO5zqu0dNfSYmLquof2AFNEl38hWPDbKbeCBOcKAIkGzf4zyCQBqFK+Xye+UbDQOAi6qRzljLjJvnw4NMkbdC61TvL2iM2ns2i+8FLBXcr/TGKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7444.apcprd03.prod.outlook.com (2603:1096:101:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 02:07:00 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 02:07:00 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v11 4/4] wifi: brcmfmac: add flag for random seed during firmware download
Date: Fri, 16 Aug 2024 10:06:35 +0800
Message-Id: <20240816020635.1273911-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816020635.1273911-1-jacobe.zang@wesion.com>
References: <20240816020635.1273911-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dde7f6b-34b9-41df-0541-08dcbd981d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gmoyu6ThTKt60rTAFvM8dRxpmMnzshJ12MKnKRp0cV3Gofo9hMrn/6qbBKST?=
 =?us-ascii?Q?ltfX5sn0HebUuQIF3MzuioAXeLMyf81QIr/SY2f9vRkfvtbf/Bj5rnBm4zxs?=
 =?us-ascii?Q?pVVveXnJR5t53x5m+raz32QadO1iUCzjjF/ivS1JzBMbCs2KcwpIz8d8mqOZ?=
 =?us-ascii?Q?61EMVnewhzLI3U+C4GEDeP4A2QVq9xkN3MtJnLhouXYvZSXGvFv3AhtxQcFs?=
 =?us-ascii?Q?uiYFpGC55zT7XsE/s03Yce+jWF9pubWZsJS5kXIA7X97TzIB6LZJ+FvZr4MD?=
 =?us-ascii?Q?dVPTbGaTYAbcGitPHNzqU13PQ5DySy+MbezJUQUSZZ/dCWynrH6DEvECntMI?=
 =?us-ascii?Q?Yr5qBaPkBji1g6KUF3rjwL2G5Vifnf/uV3J2Jntjlr79DL1DXJKgOtz/HX36?=
 =?us-ascii?Q?QT0v4JziBVKCtLVbIm3QcsvNFePjxfN5+sudPpnKs4wd+gteb0qQGpzWKb+2?=
 =?us-ascii?Q?VC7qYD7bHmFrwZrYNj+wD+hTf4Q1vhnBw+rpCCMBLV2QbHPVVD5Y/D/CeRhK?=
 =?us-ascii?Q?zvtp2TWv+ApPsasplzVAJ9YykTikjpsrZvk/hKys+LiVKav3AYhG01dbdckO?=
 =?us-ascii?Q?x34T3UzeGtlDtmwWvyUVoQ0bIOdmZ37Ix1xJjNY5ljkktxl467LPXVx/JTKc?=
 =?us-ascii?Q?up7XJ0qtDTCgXzb0ONE2HY6/T0nHvd3piMYTrFn2o3J47+wgHNW64IKe+ASd?=
 =?us-ascii?Q?svWitETT0nh7TR88CrrSOaQhKdKz+9BhOSUJocL2XLoE8gWflLuvo+iNls03?=
 =?us-ascii?Q?TsbAHirfpD9L1D2tlpE+mDsfGyFD2FwguD8mTBmuV1+Ii3QEXVKtNK+64RA1?=
 =?us-ascii?Q?XUuSZjq9YA2J7kojYOWIiwIpMEfsrpi+VRl3ngozNikWf+kP/usvvzwozF+X?=
 =?us-ascii?Q?GxSqxhtd4n37gixXOffRXWGMLC8sIZE3dY5ned3m+kSgTK5hhCK0DdGVArXv?=
 =?us-ascii?Q?MlfBNMqNzBCqSrUYxlsK3WGhokCScdxd1NRi4QjlbWCdBHMCM7T2UO8Myt1d?=
 =?us-ascii?Q?vdnomVWyCeAZ26HqEQKjN8/IKp6Nnj4Y5JT2dRmQIjaYeCrOLV1u2MHHlwfd?=
 =?us-ascii?Q?beXXWCLCMmVoj/v6jNsR8QzbsXmcXLHDOMDFjY47UfjtwixvbZ+74/W14i/t?=
 =?us-ascii?Q?SNYDP5THeOvKRZk83xYKnprLLHpOSeJxc4bitE4POc7x/LeMVB/xeaxKGwtJ?=
 =?us-ascii?Q?BNm0RIADRdM0RM4AwyUjGk7HOzNiruJBc3/LDa2uoFszDGaNFCRyUsoomj+X?=
 =?us-ascii?Q?Fz9I0NWuXDLMmmjQBD7q6uL0jW3MfbTZyp6ge7sMFYLCBFJLNuPGSxjGea3y?=
 =?us-ascii?Q?HJBI6b63QfrozBnUliq2OhqSxx9ncRlMT2VA1TfsmMN2JZKdTaQy83HEHG2s?=
 =?us-ascii?Q?1GJ6sLIzRKzQIk5XoLSzDFIPDcSR5erF9/VYHG/fHdG6WJXN5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xs7thqapfbVSBmCasRY1Y/LWbcmfTMnM3PYVmGrG2tDhNMtToWKgIx7r6v85?=
 =?us-ascii?Q?0cDfU49a3l5jfhyGk1L+0xpT/vueM/AHi/NaacCDZSr9WERkdmOdALsDHSxQ?=
 =?us-ascii?Q?UDpVodNJQyaVwQ9f2da2YWMxave7dVcDo1ZcWZzl/LsfPSqjm9SsuZu8Is4H?=
 =?us-ascii?Q?R/MIoEnMiyttAyBoX3SQFm843nibZHgWYft6RiBmOeukCRBdswWN+lgk9z9W?=
 =?us-ascii?Q?p7nIvQFdxWWCgEz49Cnp42+XE+RbbGvjCqf0UYkPnWNDsAk5EGIyHwcnnIR0?=
 =?us-ascii?Q?V/IFIsBdv48FMVhJzSfdI4WbNzFrBG17JXVN5ADSpQXhE68EDXSTuz1Gko/D?=
 =?us-ascii?Q?3yuuk7YGts6JsCX5wmKwD0ntmfUAn7U9BsrVXF0yY340Gmvggbbp+fN0iCAn?=
 =?us-ascii?Q?vMEhK7Npbak1Zvcusej1OhGSAvBkQYsFuM26qR0rOR+CBZZIRLgItM/115Lq?=
 =?us-ascii?Q?+YQg5Hh9D4ybHcloAC9NakwYZrXd7ke/je9fTx9uZtRll3TJRWd8VADxevU4?=
 =?us-ascii?Q?vR3Fhq9uqssf+yQ9DpQvvoXzwbFiIL2LoXFJcCy+tGeJHPsAGEHEDE7eXgip?=
 =?us-ascii?Q?G5HyVzb7JP+c7Fj48mUO9w98IkSJ76UmFsK1PE8CFygCgkJNXUugvmuP4X52?=
 =?us-ascii?Q?PysSjm77XLxvXj2VdCOacGnCEhO+gSIKM2OXAtSLHpcxOnsIsFK3p765IxSt?=
 =?us-ascii?Q?O3LbdkvY8x4CIeCVPIr7gdKW1qdRO5wKf2zbLgR6tvmaNpLqRqdt9lsjgTy6?=
 =?us-ascii?Q?No9/XmvE2Csxj5eZmsit0tXV2HirQxbd2i0Fb7Ut2fav0HO/1wWSLH5PpmL4?=
 =?us-ascii?Q?1FEq3OHKyYuUTni3DE2dMe5AwbWWxeTBQcF8aaPO73/3i8bR+JWgTQyKyYxU?=
 =?us-ascii?Q?Rwkr0LOVRjc0cHPh5Me4UxXWjOlBz/r5wSHPKLhrolbfM3qy6K8rgQVP9Sqd?=
 =?us-ascii?Q?xBcvLB+6sEyjG6qmMkWQAsM7EDqKalQdWuU6HNSal2Q7ns77qcmoLXRhkdFK?=
 =?us-ascii?Q?LYX7J3Y6lPa3QItrUpsK7Q/AVHM0Hga4K1o4suYF3jOdrsDrx+MnQzZtIisu?=
 =?us-ascii?Q?fPNylf+0WE4WKGaEHa8N6y3KhZALUbIuGhRWDXC1wDHa77TGhedId4yIakkK?=
 =?us-ascii?Q?ttYD2HORburSxAH5cM7Tx8YFkkFhzOTHNzbwYcoV87BBlCzWtfByUi2sCR6C?=
 =?us-ascii?Q?0nmPsoigSbisWZBLwgaC/tEN56L5foGJFfODwpqKyZE0z/sBbTpviQBCx5ej?=
 =?us-ascii?Q?6x+FTfrDy4vAaJSkilQ6wqmcLCMECHNtjkPbY9d3CejLQbSPrGB+y4vuzZQ9?=
 =?us-ascii?Q?L2ItjFXtkKpZBPsnJJ0WtSybSxwPhHfvYxkrkcHqlGcs7CtOrcblwAtzKXXP?=
 =?us-ascii?Q?myGnuf21YrfDg3MG6V+e2JZFUNpbE3l1eNQs0NiNw5CnpQCgR2UbOB++fjOZ?=
 =?us-ascii?Q?Tbdd9J43SBCqbToaJKOWP9UReAFLSAxNL3jv/27+MFMucONpy1NHPs/fEawh?=
 =?us-ascii?Q?5kAcdiZiKnUoeYYbf/qFwvkGCrQdwrvGvL3yjBk/GGt7r75Cs4Dzo5R1pzmE?=
 =?us-ascii?Q?Frgmx7VVdvFdt6vXEWMCPXXBhAxWRfOkbhbjq/RC?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dde7f6b-34b9-41df-0541-08dcbd981d83
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 02:07:00.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoyuqEHcBV6ncxWk0xOAfShzgTFeqOrgqNJEKy6MKnaN0yeHNLW+4/eQ/fzS5HIZDBXulPh8dLn7SfGrmgafFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7444

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


