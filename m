Return-Path: <linux-wireless+bounces-19719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F8A4C70D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 17:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154A0165317
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8423A563;
	Mon,  3 Mar 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oWOhDyHs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01olkn2100.outbound.protection.outlook.com [40.92.53.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B514215079;
	Mon,  3 Mar 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018879; cv=fail; b=AzF1R21QQOQWRnTQgmDvsfGL3dryTQQyOn8QPFG/YIcwQKn7aLqZm3A5nwCKEwPfU9ayncxO+cR7oIfYhFMaqeDtB2g6dygMzai3gJS8xxRivFHwMox3F7UdJzvUTCYQHUZlOWOHqPLRl+HPIZaLVep8N09CX7j1AD5VCeTkX9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018879; c=relaxed/simple;
	bh=vs1aYOgnYvdN/j3Rnb3OQ4QgOATdVx/k3rVHjIF5/vA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FzhLpT6U5UW7dxlkykFfosFG5ik10vc4eLkcLxtc4hDmGUklY79ITarKVWCG33+Baj1sJ1VCOUjXWPr1v+utgyzBTUqNEw4C3HSfvo0sneCgm0+qDAbvaK8LEeqk1UiVFIdZMnmf6n0VEU0BScQ5kQskm3II8AWN/Ok74vKdKdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oWOhDyHs; arc=fail smtp.client-ip=40.92.53.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Luzc64WernD5gPsJDEpG0Z6gPJ0RM8iNyG9itG1NdhijbYCV0wCzfTi6znXvYkhFKxMJxt+WSRwwLZjqrPQpy1SeUDr5IyNeCas5IFCxQZo0E1vwEUPwna51diD3sQXlY7KkLz43cPVajJbeV/iEK4Yq/v2aJLleRjqz7sOoTddVJ+EYj3G/XHOjX9sXcyl8RUBE6uf2YVmFVNn9IpDhRc/MQcINGE/c9wrO8B1Ew5NZz8I3C74j7UVIkyDo0pdyxElMXtKvvptsccdAEyNY2NAZMjyZ9+nz5p4utT8sk7GO3FDEdWSaEqpZ/RWXHXpLxKtF4sqoKvn+JzLGqbDnQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpkRGsQHcCBEiKXsWS8f+MivbmNog39ckQjepJMOmdE=;
 b=bU7v5bKDu9jLAQ9aEAtf8/XVymtb1WuxIZrOHgpWnLL/4PrsraGjpWEaOrmU+/DzIWGipSNWFSuo64VA9ha015UFkbVTpOI29AWqTuCk2l+Hc2/bByc2ogojA5am6Vwm6nHFsrUOFgAFqhj4uV3k/GBuyWQ9sIHI0Y+SYOVdmKUvDabFOG2+uGeDgcinzstM6mjdlgGuxTP5Xbbsha4jqmBBeC2onkSo/KEXfx4f4vVdu5lFR4n5CzXyPV0/wmTFH8HbS6TQ2dMjHzBoLylzRhR4VncYBOPw976dkXLPYBnB7lM9dB/nd71oNvAecF79TIWzC1qR450mD3NypX0YaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpkRGsQHcCBEiKXsWS8f+MivbmNog39ckQjepJMOmdE=;
 b=oWOhDyHsnoJujuOJvWDF1mc0ybrGgtvlg1TZAMdCrs7A+R2nMhzRlPufw627k4Me2ttkFoCDYS7/QAjtzZMoCNPThuTcTgfK2uSYUBeRbRKB3CgqmkNjJKM/0usExWMobZMjgM33Mhi90Lwn9HLNGmlQKYJ7ibbk6mfiYK4CB26x8fJ2+crXCvYkc+nHFWK0I8dZMs1v22vU2XxIeIkIHpyLOXjWgKjARX6NG8iRSYBWMAzAhJdrNIh+fUolEtWkrpX9P7n2Gh29I0LSaRKbchI1IdX1fwU7Xontvw2+9Wn9Tptz9Af/OPBLTxpKcPRIJXy2mf/rocaei6WcKYox/w==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by TY2PPFDD0B528A9.apcprd01.prod.exchangelabs.com
 (2603:1096:408::3d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 16:21:07 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::3641:305b:41e2:6094%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:21:07 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: johannes@sipsolutions.net
Cc: jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 1/1] wifi: ath11k: pcic: make memory access more readable
Date: Tue,  4 Mar 2025 00:20:59 +0800
Message-ID:
 <TYZPR01MB55566065525ADA7F71F516D4C9C92@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20250303162059.13432-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|TY2PPFDD0B528A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 36922519-a1db-4784-ad72-08dd5a6f66b8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5062599005|461199028|5072599009|19110799003|8060799006|3412199025|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWpCE5jbUTSREUUuVqXsaE2J5stwPiaOtLP5MI4VFwnM8kHTcOTx06TZ85lG?=
 =?us-ascii?Q?8QmjOuame+2quqorM5e7FB4Imstv8+HLKMEZ+kSMdb7ZDLHy5NuhS8YDnqoj?=
 =?us-ascii?Q?GyHQjXISaQgi/r806sHJIoe3c8B1RnnNS5ilD9kEwszhp1yQWtiZddB0MB0B?=
 =?us-ascii?Q?dm5FmY+1YN1kbyoljc37H9zqk3/xTWA0zI4UNDrM6Ay+nxQx/iSQXFEcHReh?=
 =?us-ascii?Q?k2MubED3vyR8PRXtd3EZQhzxkn+pTHxjqDdBUDAcLxVgSeEhuPEj5xjESoxw?=
 =?us-ascii?Q?LLPk25jMbt4aXjAojAPqsgOVgWleta7aU7vHjsBc0HB4aqAUkudr/3i8KsX5?=
 =?us-ascii?Q?liYtn0R1/B1oFu5p+TMbOGg/zn3M6GEJb7lh8HCNUf4eJDmw3TQLCuRkgKY8?=
 =?us-ascii?Q?WmqMObfp0Ot9qAzhBM7Xib1n3Je6zYYldrb1Dlqu1Ghvo3cKHHY96SoK8rpC?=
 =?us-ascii?Q?Ygqf7LOZuas6xTdHBigkQCauh24P82rsuMAribaMBaHL0JhRaMba4JJhwIlR?=
 =?us-ascii?Q?tSBnBHaoXU8qUI4xgu1V6A+dPldgn1oo/iY3xyK81whVf+Ut9k58OhL6eVXu?=
 =?us-ascii?Q?aOSbfjV9PJXYUfg8/uLf45Vea7okPEXMD23Mreny2maz0KOY/0Oj1iapaZRY?=
 =?us-ascii?Q?GiyVVxkQ5llSuMUkN6bD2AcReP9N3xFH2d7oeCdAwaZKzgRBcKNtzj5nEbka?=
 =?us-ascii?Q?31txhcRkYFFJDI0icJcqxOvbYP3wPUN/knBTGcHLuy/Ekobplihyvia1ozke?=
 =?us-ascii?Q?mwZa65xcvO91AUFHLpcU2H0fOn+uTJp9FQDQ4gxFwJDWBbYPRvmV59VQmyEe?=
 =?us-ascii?Q?B/8lLWUl1rObhPYS4Qxo2RG5wTWmR3Epi37lxh966AAd0Ovi/fCezjH1XM98?=
 =?us-ascii?Q?UmC2Y7TUJKKpt96VTnvsM4j1veuBSWAhpYhX4EDj2WMcBclT499jdHsEQA1d?=
 =?us-ascii?Q?xYIyyVp1Gv60kFoywk3UnRnA+ojFPLeCoNmnX85EDEnIIeYHBIVIEwinJMfN?=
 =?us-ascii?Q?WkVs6kuQcUBvKrN39LXNNRevD+KBKApbN8kHlMwny7wgXlOMsltdE4yt/rkC?=
 =?us-ascii?Q?pWZnrewFzcLZ2pZXjpfBMuYocHTTJ2iAlxMbVDd3yh5VV07BaSn8NaF9n/Je?=
 =?us-ascii?Q?+CnqRv4S81vl2c1FAoc6cGAa5Ea/Q20OxA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wA+Z8QIvfkYpgpbZtmJBCNWMncZ0DhJA67JtWwDgzXRKRyT1+CT3DnXtJp1b?=
 =?us-ascii?Q?1B27QU1+BXSl7NUELBfgrUYC7UQMeXJVHt5XKm19nYa19pwe308UaO6z2TCl?=
 =?us-ascii?Q?jHW0CxBb7Gz6dJ3KgDTq5NE8xF4i90PaAfuJSPRUy30BnyEzdKeiqtxLJfZx?=
 =?us-ascii?Q?XxCt/WPLuvy2Hf1Y2/BzkCEgdqU329rZnSglRbdKqqF0qsIaP62TxamAOyM2?=
 =?us-ascii?Q?NfCJhKuUc5yndZlQSXGhbZ3VHPUXy96/ppnsu/g+SYeUk+lIzejGPc9Etk7I?=
 =?us-ascii?Q?+lf3UUUfiBrwzIzH3/MQmvEnf1GmM08tcHwF5swHn6TYMrCUkm0pfLAEr6sx?=
 =?us-ascii?Q?VgDghqXq6YmoIVunHk9vv+DOm92o71dYYbMoIGNtLokyJHy26UjIMJU+xmuH?=
 =?us-ascii?Q?C/SQc4gQxbZRgvO6IUx8iTQ/VY9USou6DUrMzHtoKUuK2Gi2Gpr/l59cPYRM?=
 =?us-ascii?Q?V0K9myseD7G+c/xAPMmGoLizJxt2E84SOPUIMPz7FmW4uu4e3CYt8sDS1wtG?=
 =?us-ascii?Q?2rKQQeMRhkDYiH95CtBbXiQwGJRW5Zv69gpZMrrxNrXobKKK/uPgi/DbPEk8?=
 =?us-ascii?Q?T3P1B6bS0+O50VMiE7CyEZHoqdDQ4+iNecr1z2VmiYiwbj+jHY7agSbfNSMH?=
 =?us-ascii?Q?vubwI4TC0ouYTN6x5CTVHRJfu1zTE/XcS3+5VLI9L1d/iKFhR7rRXU+qvEjN?=
 =?us-ascii?Q?HjDKYOnxSIQt1qg6A4jE7hSfJG/6Ej5IA6tBHocfDA2LtWe16qzvOobdTBxo?=
 =?us-ascii?Q?5/pbgVQKgVeknvOCc74q5cWyA7ZyQJVdaR8KPs4RATwWbNN//nr5E5fEnHno?=
 =?us-ascii?Q?oZ0ppp12Iv7m6lRPhPVUOak+AztDHg5doOrHhB45TD/z+HLBPTx/BagiQaZu?=
 =?us-ascii?Q?MjVSg/BfeyEoqR46XjYNvxxSE6zx25GqB8muJlqzOx9BZvutVqLKu+mIbGwe?=
 =?us-ascii?Q?Elenx/x6aJ2pJepyCd5uyC4xyDBYges0AEeDI5bV1m3Q57p8ZGEbqGR5M/ZQ?=
 =?us-ascii?Q?1o5/B1OQ0PVHUPVI84aGX+eORftHtBjGgOHy7oHEzWf0omXgcTm3PUjeOCyn?=
 =?us-ascii?Q?YtMx+a12anW4tcErqIZHuDgBa+edrmicV2P2P0W4RkjGQqU2xljHw216AQuw?=
 =?us-ascii?Q?iF/vpVE8ayfmUYfLqzVS6MeoKm3k28Y+NFw2+bu9eg/V6stc+jGKXhu+uVCx?=
 =?us-ascii?Q?+R7XwyKNFeW6ID07+GDRVE2UdgjPNp3eXE1d18EfZXvFwoaRTFJMXg0g1as?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36922519-a1db-4784-ad72-08dd5a6f66b8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:21:07.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFDD0B528A9

The BAR memory access model is a type of paging.
So let's spilt the BAR addresses into two parts: window and offset.
And split the register addresses into two parts: page and offset.
The window is used to map page.
Window 0 is always map to page 0.
Windows 1, 2 and 3 can be configured by ATH11K_PCI_WINDOW_CONFIG.

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 38 ++++++-----
 drivers/net/wireless/ath/ath11k/pci.c  | 95 +++++++++++++-------------
 drivers/net/wireless/ath/ath11k/pci.h  |  4 +-
 drivers/net/wireless/ath/ath11k/pcic.c |  4 +-
 drivers/net/wireless/ath/ath11k/pcic.h | 29 ++++++--
 5 files changed, 97 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index f2fc04596d48..6d7e45792927 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -148,43 +148,45 @@ ath11k_ahb_get_msi_irq_wcn6750(struct ath11k_base *ab, unsigned int vector)
 }
 
 static inline u32
-ath11k_ahb_get_window_start_wcn6750(struct ath11k_base *ab, u32 offset)
+ath11k_ahb_get_window_wcn6750(struct ath11k_base *ab, u32 regaddr)
 {
-	u32 window_start = 0;
+	u32 page = ATH11K_PCI_REGADDR_PAGE(regaddr);
+	u32 window = 0;
 
 	/* If offset lies within DP register range, use 1st window */
-	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
-		window_start = ATH11K_PCI_WINDOW_START;
+	if (page == ATH11K_PCI_REGADDR_PAGE(HAL_SEQ_WCSS_UMAC_OFFSET))
+		window = 1;
 	/* If offset lies within CE register range, use 2nd window */
-	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
-		 ATH11K_PCI_WINDOW_RANGE_MASK)
-		window_start = 2 * ATH11K_PCI_WINDOW_START;
+	else if (page == ATH11K_PCI_REGADDR_PAGE(HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)))
+		window = 2;
+	else
+		WARN_ON(1);
 
-	return window_start;
+	return window;
 }
 
 static void
-ath11k_ahb_window_write32_wcn6750(struct ath11k_base *ab, u32 offset, u32 value)
+ath11k_ahb_window_write32_wcn6750(struct ath11k_base *ab, u32 regaddr, u32 value)
 {
-	u32 window_start;
+	u32 window, offset;
 
 	/* WCN6750 uses static window based register access*/
-	window_start = ath11k_ahb_get_window_start_wcn6750(ab, offset);
+	window = ath11k_ahb_get_window_wcn6750(ab, regaddr);
+	offset = ATH11K_PCI_REGADDR_OFFSET(regaddr);
 
-	iowrite32(value, ab->mem + window_start +
-		  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+	iowrite32(value, ATH11K_PCI_BARADDR(ab, window, offset));
 }
 
-static u32 ath11k_ahb_window_read32_wcn6750(struct ath11k_base *ab, u32 offset)
+static u32 ath11k_ahb_window_read32_wcn6750(struct ath11k_base *ab, u32 regaddr)
 {
-	u32 window_start;
+	u32 window, offset;
 	u32 val;
 
 	/* WCN6750 uses static window based register access */
-	window_start = ath11k_ahb_get_window_start_wcn6750(ab, offset);
+	window = ath11k_ahb_get_window_wcn6750(ab, regaddr);
+	offset = ATH11K_PCI_REGADDR_OFFSET(regaddr);
 
-	val = ioread32(ab->mem + window_start +
-		       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+	val = ioread32(ATH11K_PCI_BARADDR(ab, window, offset));
 	return val;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index b93f04973ad7..22478d19872f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -54,74 +54,77 @@ static void ath11k_pci_bus_release(struct ath11k_base *ab)
 	mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 }
 
-static u32 ath11k_pci_get_window_start(struct ath11k_base *ab, u32 offset)
+static u32 ath11k_pci_get_window(struct ath11k_base *ab, u32 regaddr)
 {
+	u32 page = ATH11K_PCI_REGADDR_PAGE(regaddr);
+
 	if (!ab->hw_params.static_window_map)
-		return ATH11K_PCI_WINDOW_START;
-
-	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < ATH11K_PCI_WINDOW_RANGE_MASK)
-		/* if offset lies within DP register range, use 3rd window */
-		return 3 * ATH11K_PCI_WINDOW_START;
-	else if ((offset ^ HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)) <
-		 ATH11K_PCI_WINDOW_RANGE_MASK)
-		 /* if offset lies within CE register range, use 2nd window */
-		return 2 * ATH11K_PCI_WINDOW_START;
-	else
-		return ATH11K_PCI_WINDOW_START;
+		return 1;
+
+	/* If offset lies within DP register range, use 3rd window */
+	if (page == ATH11K_PCI_REGADDR_PAGE(HAL_SEQ_WCSS_UMAC_OFFSET))
+		return 3;
+	/* If offset lies within CE register range, use 2nd window */
+	else if (page == ATH11K_PCI_REGADDR_PAGE(HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab)))
+		return 2;
+	else {
+		WARN_ON(1); /* In current code, we don't access any other page. */
+		return 1;
+	}
 }
 
-static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offset)
+static inline void ath11k_pci_window1_select(struct ath11k_pci *ab_pci, u32 regaddr)
 {
 	struct ath11k_base *ab = ab_pci->ab;
 
-	u32 window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, offset);
+	u32 page = ATH11K_PCI_REGADDR_PAGE(regaddr);
 
 	lockdep_assert_held(&ab_pci->window_lock);
 
-	if (window != ab_pci->register_window) {
-		iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
-			  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
-		ioread32(ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
-		ab_pci->register_window = window;
+	if (page != ab_pci->window1_page) {
+		iowrite32((ATH11K_PCI_WINDOW_CONFIG_ENABLE |
+			   ATH11K_PCI_WINDOW_MAP(1, page)),
+			  (ab->mem + ATH11K_PCI_WINDOW_CONFIG));
+		ioread32(ab->mem + ATH11K_PCI_WINDOW_CONFIG);
+		ab_pci->window1_page = page;
 	}
 }
 
 static void
-ath11k_pci_window_write32(struct ath11k_base *ab, u32 offset, u32 value)
+ath11k_pci_window_write32(struct ath11k_base *ab, u32 regaddr, u32 value)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 window_start;
+	u32 window, offset;
 
-	window_start = ath11k_pci_get_window_start(ab, offset);
+	window = ath11k_pci_get_window(ab, regaddr);
+	offset = ATH11K_PCI_REGADDR_OFFSET(regaddr);
 
-	if (window_start == ATH11K_PCI_WINDOW_START) {
+	if (window == 1) {
 		spin_lock_bh(&ab_pci->window_lock);
-		ath11k_pci_select_window(ab_pci, offset);
-		iowrite32(value, ab->mem + window_start +
-			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		ath11k_pci_window1_select(ab_pci, regaddr);
+		iowrite32(value, ATH11K_PCI_BARADDR(ab, 1, offset));
 		spin_unlock_bh(&ab_pci->window_lock);
 	} else {
-		iowrite32(value, ab->mem + window_start +
-			  (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		iowrite32(value, ATH11K_PCI_BARADDR(ab, window, offset));
 	}
 }
 
-static u32 ath11k_pci_window_read32(struct ath11k_base *ab, u32 offset)
+static u32 ath11k_pci_window_read32(struct ath11k_base *ab, u32 regaddr)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 window_start, val;
+	u32 window, offset;
+	u32 val;
 
-	window_start = ath11k_pci_get_window_start(ab, offset);
+	window = ath11k_pci_get_window(ab, regaddr);
+	offset = ATH11K_PCI_REGADDR_OFFSET(regaddr);
 
-	if (window_start == ATH11K_PCI_WINDOW_START) {
+	if (window == 1) {
 		spin_lock_bh(&ab_pci->window_lock);
-		ath11k_pci_select_window(ab_pci, offset);
-		val = ioread32(ab->mem + window_start +
-			       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		ath11k_pci_window1_select(ab_pci, offset);
+		val = ioread32(ATH11K_PCI_BARADDR(ab, 1, offset));
 		spin_unlock_bh(&ab_pci->window_lock);
 	} else {
-		val = ioread32(ab->mem + window_start +
-			       (offset & ATH11K_PCI_WINDOW_RANGE_MASK));
+		val = ioread32(ATH11K_PCI_BARADDR(ab, window, offset));
 	}
 
 	return val;
@@ -163,16 +166,16 @@ static const struct ath11k_msi_config msi_config_one_msi = {
 
 static inline void ath11k_pci_select_static_window(struct ath11k_pci *ab_pci)
 {
-	u32 umac_window;
-	u32 ce_window;
-	u32 window;
+	u32 umac_page;
+	u32 ce_page;
 
-	umac_window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, HAL_SEQ_WCSS_UMAC_OFFSET);
-	ce_window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, HAL_CE_WFSS_CE_REG_BASE);
-	window = (umac_window << 12) | (ce_window << 6);
+	umac_page = ATH11K_PCI_REGADDR_PAGE(HAL_SEQ_WCSS_UMAC_OFFSET);
+	ce_page = ATH11K_PCI_REGADDR_PAGE(HAL_CE_WFSS_CE_REG_BASE);
 
-	iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
-		  ab_pci->ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+	iowrite32((ATH11K_PCI_WINDOW_CONFIG_ENABLE |
+		   ATH11K_PCI_WINDOW_MAP(2, ce_page) |
+		   ATH11K_PCI_WINDOW_MAP(3, umac_page)),
+		  (ab_pci->ab->mem + ATH11K_PCI_WINDOW_CONFIG));
 }
 
 static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
@@ -615,7 +618,7 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	int ret;
 
-	ab_pci->register_window = 0;
+	ab_pci->window1_page = 0;
 	clear_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags);
 	ath11k_pci_sw_reset(ab_pci->ab, true);
 
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index c33c7865145c..90e6ae55192f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -65,9 +65,9 @@ struct ath11k_pci {
 	struct mhi_controller *mhi_ctrl;
 	const struct ath11k_msi_config *msi_config;
 	enum mhi_callback mhi_pre_cb;
-	u32 register_window;
+	u32 window1_page;
 
-	/* protects register_window above */
+	/* protects window1_page above */
 	spinlock_t window_lock;
 
 	/* enum ath11k_pci_flags */
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 3fe77310c71f..d65b5cb6f986 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -164,7 +164,7 @@ EXPORT_SYMBOL(ath11k_pcic_init_msi_config);
 
 static void __ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
-	if (offset < ATH11K_PCI_WINDOW_START)
+	if (ATH11K_PCI_REGADDR_PAGE(offset) == 0)
 		iowrite32(value, ab->mem  + offset);
 	else
 		ab->pci.ops->window_write32(ab, offset, value);
@@ -194,7 +194,7 @@ static u32 __ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 {
 	u32 val;
 
-	if (offset < ATH11K_PCI_WINDOW_START)
+	if (ATH11K_PCI_REGADDR_PAGE(offset) == 0)
 		val = ioread32(ab->mem + offset);
 	else
 		val = ab->pci.ops->window_read32(ab, offset);
diff --git a/drivers/net/wireless/ath/ath11k/pcic.h b/drivers/net/wireless/ath/ath11k/pcic.h
index ac012e88bf6d..b1b8db3e382f 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.h
+++ b/drivers/net/wireless/ath/ath11k/pcic.h
@@ -14,11 +14,30 @@
 
 #define ATH11K_PCI_CE_WAKE_IRQ	2
 
-#define ATH11K_PCI_WINDOW_ENABLE_BIT		0x40000000
-#define ATH11K_PCI_WINDOW_REG_ADDRESS		0x310c
-#define ATH11K_PCI_WINDOW_VALUE_MASK		GENMASK(24, 19)
-#define ATH11K_PCI_WINDOW_START			0x80000
-#define ATH11K_PCI_WINDOW_RANGE_MASK		GENMASK(18, 0)
+/* The BAR memory access model is a type of paging.
+ * So let's spilt the BAR addresses into two parts: window and offset.
+ * And split the register addresses into two parts: page and offset.
+ * The window is used to map page.
+ * Window 0 is always map to page 0.
+ * Windows 1, 2 and 3 can be configuarable by ATH11K_PCI_WINDOW_CONFIG.
+ */
+
+#define ATH11K_PCI_REGADDR_PAGE_MASK		GENMASK(24, 19)
+#define  ATH11K_PCI_REGADDR_PAGE(x)		FIELD_GET(ATH11K_PCI_REGADDR_PAGE_MASK, (x))
+#define ATH11K_PCI_REGADDR_OFFSET_MASK		GENMASK(18, 0)
+#define  ATH11K_PCI_REGADDR_OFFSET(x)		FIELD_GET(ATH11K_PCI_REGADDR_OFFSET_MASK, (x))
+
+#define  ATH11K_PCI_BARADDR_WINDOW_MASK	GENMASK(20, 19)
+#define  ATH11K_PCI_BARADDR_OFFSET_MASK	GENMASK(18, 0)
+#define ATH11K_PCI_BARADDR(ab, window, offset) \
+	((ab)->mem + \
+	 FIELD_PREP(ATH11K_PCI_BARADDR_WINDOW_MASK, window) + \
+	 FIELD_PREP(ATH11K_PCI_BARADDR_OFFSET_MASK, offset))
+
+#define ATH11K_PCI_WINDOW_CONFIG		0x310c
+#define  ATH11K_PCI_WINDOW_CONFIG_ENABLE	BIT(30)
+#define  ATH11K_PCI_WINDOW_MAP_MASK(i)		(GENMASK(5, 0) << (6 * ((i) - 1)))
+#define   ATH11K_PCI_WINDOW_MAP(i, page)	FIELD_PREP(ATH11K_PCI_WINDOW_MAP_MASK(i), (page))
 
 /* BAR0 + 4k is always accessible, and no
  * need to force wakeup.
-- 
2.40.1


