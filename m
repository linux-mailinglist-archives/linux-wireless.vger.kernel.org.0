Return-Path: <linux-wireless+bounces-10929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7895094762E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2811F21D29
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E516150990;
	Mon,  5 Aug 2024 07:35:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53814F9E6;
	Mon,  5 Aug 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843300; cv=fail; b=eSPjTkArRQSNkGW2RJPy1bGuTLKqneY/pXxocvSOGUpA5NJsM4aQ8GAjKjj+twCaBKqy4r4HVSurQ9olzTIlQ7djVldrt+gGs+uqNTOENMTe4bqUyUNpWmQBJWfqy6artby9YWoJPhl1vjCod6DSl27QWKF6PXYUhYlsZ68ZEXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843300; c=relaxed/simple;
	bh=mR5ASTteSedxZYVvoFpPHRrXeiLivjQPNPfhqqaTliU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ifU1QEbLXfLScqEKqNDBkMStPzUQQY8GPjgFicL+iDLhQ69PTzEK22KUSsv0rsT1uvozQpKJKNTF2Qx6/Cd5fvv7HyXCtLYzUUR9nWpcnLC4AdwnXZnKHDiri7M7j7+wNneWLR4ms/PeA+ZWXjxarYeQrYOGlH62H1fuDXOKkM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSlPd/BwpkOvHpAM0kLbAAhOTlmF8kGrSFW3+44RyXosLksazJ0sS9ILbISfVTRluCqiD3ENZir4Ho9mOyyC8Xj2DVbXIsUaWJ2+Czni3ku5dtVn/kc0BKcJneoogGKnEU+kEFla6oUUFIlqQ3+BUwF8mScrPYduP28iTfpPvdB/L27cgGfnAki9jYw4rVKq08BHZ/j5UKrsXKX9Z3GykQbrAUXCQMH/e0lQ+Wa7YY3WG4Tlh4oNX87YEFI2F1Jex27wZ0IIMJfmgCy7CPEd8TIt/353CkqTjAHXEh+fXGCJIbSB6KN5LsHlONPyhQNxl+tgbaHIlGilLcupXaFiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtKNOAdCR0o6r0PtMudKDdC8rQXrTjHn5IR45Tic5BE=;
 b=cO6PCC3uMyd6jZ2JAmxN8sz3V55VCP9xv5A7YxHuZF6v2Minj/l45sHuFdlZQaCvEmkEcwiGf95QFM4Q5RcMWz+8Gwv0bk6fWUcwSdqqToZZ7ReR7c9GBamxUGom3IK2XQ8+Ovtuc2LWCI79vf2QdpZ9UCmP3sCqGeiCljxnRMYi8zN79C01nOiM70A3RaQwgReY1bu5k/DBGCGTVRPuYsTOiXJNQ83Av+3ewWCD+oRETqjD1tc2aoWjPjTa2OUXgdbMl2VZOXFt0oBOw+q0WIl2IvaJUdVveQ1aFijc3/A+98x+ekia04i4QGmCo9vIU5laCMZ9edrDSorKjpMFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB8052.apcprd03.prod.outlook.com (2603:1096:990:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 07:34:55 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7828.024; Mon, 5 Aug 2024
 07:34:55 +0000
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
Subject: [PATCH v8 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Date: Mon,  5 Aug 2024 15:34:24 +0800
Message-Id: <20240805073425.3492078-5-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805073425.3492078-1-jacobe.zang@wesion.com>
References: <20240805073425.3492078-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|JH0PR03MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bd7744-8b7c-4290-d2f3-08dcb52119ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qWTY8P+ttPHeEnTsUhC/kQGdTpuT6U98oa8yOZ0na2dt9opM9kLbJ62HOQrR?=
 =?us-ascii?Q?OG5a5qLaVsTLoPehIpFIuyxWo/00Ek+yFB9xyegPXSiEH9Jns4BtzwH3dsaH?=
 =?us-ascii?Q?wpPu1iIEEhXD5Vsr1PfHD8NbrBpG5Zm4W3uIqfU8nADh8+LtetKu+BYz3tSa?=
 =?us-ascii?Q?1nbGrA3ZG9FZoY4TR6wZxAQicEfqvZtLM6Qxion9ZhfDX5nAdijTg1XYdo36?=
 =?us-ascii?Q?H7nKGQ3koV/PK54TfTNS9gbUG2h9d6nCZqwYjmKxA7wC/vNEGLhJZM/UxQxt?=
 =?us-ascii?Q?VDaqV1IA3alxL6QJe7pMUxDhT8fIRy5ioLf5vfJR+E2LbfNpmkS9UFS9JYfv?=
 =?us-ascii?Q?S+RwURE/I5nXIqiIn6oGswIRUZaEHTg3O5u8mfEPC2bPS1tkJqR5i3XGJu2h?=
 =?us-ascii?Q?C+dE++itf/79ohheSPKoLc26GKz6lUt27uvX9sXP36RDAD1iOvwqxNs3rTsd?=
 =?us-ascii?Q?kI4PZJ3vdp+ycYbKPPDsW+OVm2ZDGVoWYpbi71vbbAZvk4mM6O94pmVBUl2c?=
 =?us-ascii?Q?BrWYovXDHNkagkjvSTDgrmCH8+eEmgbGGgG1wielfLCoCD+WlrlSUTlu2eql?=
 =?us-ascii?Q?zKWjDLRADKv+wMuoHExanuC3AiYCTIgLScCphILhN4x2ntBTHnBYFw0gb/vb?=
 =?us-ascii?Q?b2Ln9XZ18EIGK5ShHaqgpCirsMy6sh8jsAKESV2gE/z7YXd9f2XSy5HHpk3I?=
 =?us-ascii?Q?Z4v9lw6u6lF6srZG4jMJxi8sUpAPphwddgi5iM+VRluev/jY0hI/53fKdzM0?=
 =?us-ascii?Q?yydgeN7B1c6E/VuwdeEoOqeQCo1Nx3+czrpAXs/z5sk+KRwQIvfRAi4lutUF?=
 =?us-ascii?Q?EIXo6aX/FxpJzOKr3MowmJ9BVyeo2jR0neKMcrjIW0JQLuA628GoXwR3Q5XV?=
 =?us-ascii?Q?T2Y1HSKlgU4YTIsODqENz69SEWF3fPXETRfkSRws/BICb8MIENxQdt1UeGoJ?=
 =?us-ascii?Q?1CQko9voVVsWj9yFgTnDIIvI5Nv8mSzIxWCERuDOKRyrwEZOwosvUVVMtIsT?=
 =?us-ascii?Q?KhsPO3XjHkN9LeUNc8nWtvN3tRt/yhSmRKazSkX6tjxpwIiVQ+qHzYSqCxP9?=
 =?us-ascii?Q?t68T6eATNltsWdk3l0On4A1y9vplmlDiR66jflWWBTdYrVnJy7n4t5KWRmU0?=
 =?us-ascii?Q?Wqb0O0WYltUL6gVHrGOH5mjkS3/poOATq2EzycFXq5AhaxeUzJe+ue29HsIi?=
 =?us-ascii?Q?ufLtw+H05rtYHTDjD4CSM6T6zYDpR4UxB5sLncs6o4ZaDWXDsSV3SUlep5PJ?=
 =?us-ascii?Q?u/yrJV/fEeU59FD1OPiZNECBhGBc93F0rHfVqZ3twEGvOoIK8kfZ8CBI2EsT?=
 =?us-ascii?Q?GPNmPYolCwCdxCfnttvFdF1RqFB3DuUZFWE/QjuVrT+hCh7mZxqUqwkTnVlR?=
 =?us-ascii?Q?/Ng6iFdgTH8kXsXhTX3ewaV/meNekMz3Sgxd2yJzY4ZR7KlAzve2AlangMIE?=
 =?us-ascii?Q?8A0h9UBYyNE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v82F1kl0Vu52tLec+sk/ZankSfjCPrgnotSxRPzmgxJTs98lxOtP7SlePmyC?=
 =?us-ascii?Q?Wr+rJPj7Bfof/PUc7zbdzaLCH4c4LquxQ2CUgnwwM8qg2hBOa85n69XN/0KX?=
 =?us-ascii?Q?OBf4uR1ZdFCNqeUSycZEAPQ/2xxd1WU+go64Hg8u8R8xJB4BYwOcIyqUlgLN?=
 =?us-ascii?Q?+BeR76+hJE1tY1oh8WbjOc+FYKhTFzwPEbg/qa+Xb61XfyGxXi2CBqOLhUTO?=
 =?us-ascii?Q?u3SCpK9C6l4ql8VAU6bynFw+WVGoyCtrQL1+CNLVUW479UYjF1KQchrn8W81?=
 =?us-ascii?Q?M8zALeaoCFSVthYuprblUQ4YJ9OIvY6FzvRdOcqs2eZvkCQcpBOL2cKcUR+F?=
 =?us-ascii?Q?n+gNej3h/LBLpH7LoceINmL+uuJcB0fdLgA8XZdptjaWmBoN03fl444mN2jH?=
 =?us-ascii?Q?O9LoYnA9cyh3JLNhhwWaEseNoJ0Cb7CMYUWC8Kioa0gZ6VabWBFp+GvhKrcn?=
 =?us-ascii?Q?kYgiZZ5jc3/uZqIOlROGYcVqI5Y0W9xmaXBw9d23wDfCvacrXMbuws9xSDTr?=
 =?us-ascii?Q?TDLC3exdyy9cYqiqvKiZUGCTnupvlvCnXZquVRSQUV3J3WDuKcznQY+22T+m?=
 =?us-ascii?Q?Vr0PLhpVjwOahlsv02LVD/Jz/GbOKFTe2tYQbgIM8YRuAst+aX3yaJVbgfux?=
 =?us-ascii?Q?kEJSz1RwclDur1KNm5uktGRPfdlN811tFfZOtG9pIF8jSP3ayr7udemlJXgs?=
 =?us-ascii?Q?+ZmHI9Qc2kgyF+lR+yKpOlOdClVFWcu6ecF1GP0zkBQfkrXmfNNVTyKQvvTA?=
 =?us-ascii?Q?N+jIUwYGzbBKNFjjvZqIN0muPHatSs80xQGNDujfz6f1RJHBHG0g5H1xuQtv?=
 =?us-ascii?Q?RDtz/qFNo5vLYg2E4QyKckZqDRSfImboedIztFyK2yfWjDOncICfyyNRnZVG?=
 =?us-ascii?Q?6OVLoeFz1AHXfs0/5jUVQFVbffx3W+z3QHj8VB/8ASA5mjg+GVPUCNvo05RF?=
 =?us-ascii?Q?S5AY2LBCOFQIH0nVBoqQ9W36ATmuymVRgKyf4yiC+N+2ddcltyOm1VSHUdiy?=
 =?us-ascii?Q?BcYXO3j3bKkGErdpg8IyXKrPXoOKvGrBnD/PW9OOfuBedlAt+bvfKNNCtQbt?=
 =?us-ascii?Q?Fkc3CtT5yYMi7lijKzaHeMFeIiw7N8syiIm5gqlaAxR+/DDzSQIpg4M1+dyD?=
 =?us-ascii?Q?eenjBuQQ3cGHvOjH9X402qnvazOIM76WPEIrxdzYiH/O4XrOT2GRFimEMAba?=
 =?us-ascii?Q?H9xAXyGTeMXIhjpGzE0kDApO842iG/SYwlxLypG7fhRfKynhGCr7wGP6Yrkc?=
 =?us-ascii?Q?O1OUA+moiUisX72AHgQFZtmWPFdG7/hBhAFkP3deUO5r6mF7ENVkrnKnWbRu?=
 =?us-ascii?Q?GqvexbMrJfoq3WQA6HcUp/3BlNRW5Yz5YVRQVV/1YSDGHH0wi/2PJaHH8a8A?=
 =?us-ascii?Q?pF5piv/Q47W3npD768vIu+IMAplxVXgjvtz6eX1r940yPHbz3L7nbV9fT/0C?=
 =?us-ascii?Q?Z2EkhvcA1vbKwbQlRXnt2XSIwkAGnsx3QiA6JjnYZqgPHPxkR3cWRZxV3C3s?=
 =?us-ascii?Q?/IMThy9TaDEG81OWvlY7SfwW+g8zSFmYTk3lCFBZXoOTlbaIrVYCaScLDXSC?=
 =?us-ascii?Q?pmW1Kju2EcxWF8+L50jBS662VFuYWbw96Fz4B6Dv?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bd7744-8b7c-4290-d2f3-08dcb52119ae
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 07:34:55.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WMnInpc1akEKpQ/2VMO7QNG+vIMUK95niz4QmVglXLJ8zd10Ic5FzjbEgebvdKrT+65niVIx/nVKXBfMbkBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8052

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
 .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  4 +++
 .../broadcom/brcm80211/brcmfmac/common.c      |  6 +++-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 28 +++++++++++++------
 .../wireless/broadcom/brcm80211/brcmfmac/of.h |  9 +++---
 .../broadcom/brcm80211/brcmfmac/pcie.c        |  3 ++
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 18 ++++++++----
 .../broadcom/brcm80211/brcmfmac/usb.c         |  3 ++
 7 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 13391c2d82aae..ee3ca85c4a47b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -951,6 +951,10 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		ret = -ENODEV;
 		goto out;
 	}
+	if (IS_ERR(sdiodev->bus)) {
+		ret = PTR_ERR(sdiodev->bus);
+		goto out;
+	}
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
 out:
 	if (ret)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873d..6c5d26f9b7661 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -561,8 +561,12 @@ struct brcmf_mp_device *brcmf_get_module_param(struct device *dev,
 	if (!found) {
 		/* No platform data for this device, try OF and DMI data */
 		brcmf_dmi_probe(settings, chip, chiprev);
-		brcmf_of_probe(dev, bus_type, settings);
 		brcmf_acpi_probe(dev, bus_type, settings);
+		i = brcmf_of_probe(dev, bus_type, settings);
+		if (i < 0) {
+			kfree(settings);
+			settings = ERR_PTR(i);
+		}
 	}
 	return settings;
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index e406e11481a62..5f61363fb5d0e 100644
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
@@ -113,8 +118,13 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		of_node_put(root);
 	}
 
-	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
-		return;
+	clk = devm_clk_get_optional_enabled(dev, "lpo");
+	if (!IS_ERR_OR_NULL(clk)) {
+		brcmf_dbg(INFO, "enabling 32kHz clock\n");
+		clk_set_rate(clk, 32768);
+	} else if (PTR_ERR_OR_ZERO(clk) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	}
 
 	err = brcmf_of_get_country_codes(dev, settings);
 	if (err)
@@ -123,23 +133,25 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	of_get_mac_address(np, settings->mac);
 
 	if (bus_type != BRCMF_BUSTYPE_SDIO)
-		return;
+		return 0;
 
 	if (of_property_read_u32(np, "brcm,drive-strength", &val) == 0)
 		sdio->drive_strength = val;
 
 	/* make sure there are interrupts defined in the node */
 	if (!of_property_present(np, "interrupts"))
-		return;
+		return 0;
 
 	irq = irq_of_parse_and_map(np, 0);
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
index 6b38d9de71af6..7d79e2db201b5 100644
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
@@ -4446,6 +4448,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	struct brcmf_sdio *bus;
 	struct workqueue_struct *wq;
 	struct brcmf_fw_request *fwreq;
+	int probe_attach_result;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -4474,7 +4477,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	bus->brcmf_wq = wq;
 
 	/* attempt to attach to the dongle */
-	if (!(brcmf_sdio_probe_attach(bus))) {
+	probe_attach_result = brcmf_sdio_probe_attach(bus);
+	if (probe_attach_result < 0) {
 		brcmf_err("brcmf_sdio_probe_attach failed\n");
 		goto fail;
 	}
@@ -4546,6 +4550,8 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 
 fail:
 	brcmf_sdio_remove(bus);
+	if (probe_attach_result < 0)
+		return ERR_PTR(probe_attach_result);
 	return NULL;
 }
 
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


