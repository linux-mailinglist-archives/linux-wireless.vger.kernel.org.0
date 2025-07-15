Return-Path: <linux-wireless+bounces-25468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0E4B059CF
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 14:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC41741886
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAF52E2676;
	Tue, 15 Jul 2025 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FP9KVJRP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB362E265A;
	Tue, 15 Jul 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581875; cv=fail; b=Dfhl0Zu6lT9/F0KmbhaUFAhycuMIL+u2A2NsZwEEvX/ho/ER9i/pkMNlVDRlEbrZ0ooqRtr6jPJxgdjEqV9cv+clkgikbXxvL9jRrT7qGI7HgI+UwKOwa3V1R0wpQodwRPepJNdlLUMf3Vc60zdEijMMyNiE6lgbadSxR9Pq/3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581875; c=relaxed/simple;
	bh=0tL7CwnBoCVU+7464oVQ5q6AYRdbHetE4vFeZgMU+KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1mdOJ4d8+3qCbySt6s9hNXTx+Dg6/ZdzYeYnJqX6LCmRu66tSYMXToBK5TWCT7KOsk59YPT8ftix9IYIJwaA01Yx9qB4YQUBUeoiSksDJWVq6oh9QNQJEyVxIwtlAptvN6nYDgdM+Ig50x5C1g8eYX961Gpmmk4rPhGMsMWYh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FP9KVJRP; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFsI4AzIbAz3WVPStFU8XqiAjOQ7M4JBlYqmS/d/fKPS35ETENwmgZ2nsh4oIDDzkt5XOhHX2FbVWsk4rwqOlD3dRByfQXyHbRqo1N9vkvjM02RISlS66kli6aD2N33zoY4zKKgktRfBZf9Z47dt/8Kz9dCy8w67LDaHC+MRtIXOQD6KKjfiyfv4A41fPhHFJJLYpjb0ajw/ND0WPc4JL0lXUB6nV8jdGUCcCeg0yeSapEsZPnUq3Zyu75dE2JvVhk1+ALz58tA+OpDkYOtYVcZjhcTcZeXmK6T6jsSEJ5andxwB97BhebqhlAaatM/HczyDc5pBtq/YLEaisXupig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXPTVUYjR3F3aOhIywWlT2woittUXY5OWpjbgXLAWiA=;
 b=Alfx9OyV/6qSloS8FKz6jzk/OXKFO0rfPVUrBLpuUXdcz7zwPPaVNQaZ337qQjZUi9QQPk/QuGEn9IgXO7dTbXrGU9hwxPE2kfsLs3WPvzJJLFmGbtpsqSVZRZp8vbJLHFgTQAN+sAqmKlAcV1S+deFr1WQP9DoB5+ph+3hPBdPpso+/0LwSrBLLGR2IL0b5VTf3ZYt29TnWBlBLpQ+crmd5xT8zwcrXpYvqjQ6gR/uoKWXpNIjIn1gkonRPosVCkF/N20Gq90wYUXgOsooSDt5CG1ck+mpa5HRQicIY+kqmTFlxGlzJSsiyir5YjjvE8vB8VECirlg9kYNNBwJwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXPTVUYjR3F3aOhIywWlT2woittUXY5OWpjbgXLAWiA=;
 b=FP9KVJRPkTAwLJpqZ8A6v3JK37bomc5YbUEg0xx/mT3fXLfDebiLxLd6Jhd0SzvENZYBQneU9U0X0kB99sjTHmTDJnJhG5v66CaYm+4Nhu5hNG4AAfOhekrjc4YGmyh+6nn9eMQBDO0yQqtlO+OE3YEQ7wrzkx2rtfD+/DfJYte4xhA+LOGMuHyMcs3dKdpkoANOdwS1knN9mdQf6NGlg/haxWn67Y9PiQfZQ1oyaX4Jb20tQt54s7ECzjCW/EwmBL8Tv8cPDZ/hwKYJYUUYaXDlBlNe9WIxdZGvMBuB0pbHH3JGPTmYu5SoBJx7/KngcK0LJ0ZvWY4PQzodi2N2Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Tue, 15 Jul 2025 12:17:51 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Tue, 15 Jul 2025
 12:17:51 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org (open list:QUALCOMM ATHEROS ATH9K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2 3/7] wifi: ath9k: Use max() to improve code
Date: Tue, 15 Jul 2025 20:16:49 +0800
Message-Id: <20250715121721.266713-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715121721.266713-1-rongqianfeng@vivo.com>
References: <20250715121721.266713-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: acd76834-b891-4082-1aba-08ddc3999e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApVKkEMwbB5DmAyCNmXcyVK0Os5dK2VA1aAoSrU5Tot0EhQI2b8dhlaJxraj?=
 =?us-ascii?Q?sEDP2u2azx6lieKCyFHCOp5NCPy4teqP7GMX0klwrioln4Lde67p70u9vBu/?=
 =?us-ascii?Q?So1yjE6mYMRQBwjfNnHLuPLGxLVuTCnve9C4ZWgqvRx74acyMe/AaiolUqnO?=
 =?us-ascii?Q?FGcbX5cNx+LphDmD2XTM+EuVMD5rNRcyYbOct+6sGstzAheRiGF6LYvZNe+0?=
 =?us-ascii?Q?zupzBM7hY9DwaZYnCmkGt6x7ziLq1mO1okieTj5HIA5JLIFg3e+XzNSdJxlk?=
 =?us-ascii?Q?tZ/F6qEQVX0/bYCwUwz0buaD/wvy3hK6DjY9zyTJviOgfUaUSqQMfjnrCRXz?=
 =?us-ascii?Q?IdICjggC7WkD/hg1orWwbffRbGE6Vpjpr64+enkBXSHhLlujjSDTYCaZ5Krr?=
 =?us-ascii?Q?PE7HoVd5vUDujJ3DPa4vt53nUfnCql52EWtVSywp/03dq9qVvpSCWVRFkaFd?=
 =?us-ascii?Q?CDcIvueP8y9IdlScf9EcrDbEG6Gk3k+dHKhEJ7M1F20G2g698RcXtDOhsueK?=
 =?us-ascii?Q?8fZ7n2vtueFTn2Z8QP7Rz5zujUyWM7eFHvHq5BU3xojweQ2t9ui8U2KayFCX?=
 =?us-ascii?Q?FgIgAm/CMy3BL/tNfee8OGDlWn0eTPnVEoTX226IO2ioyX/nzZs0gnRq75dd?=
 =?us-ascii?Q?+e2/gskAZBE04KXh2kKqBfxnLJgZ11oLeTiXX++oXUT6MmZqtOFI9WAgNUMT?=
 =?us-ascii?Q?rGHoTpGYyyEn1lAzzkJW2edCb9Dkdt+6+0Rj3rV1om6ueBwOlPQctrUo0JHF?=
 =?us-ascii?Q?0ldIoHrjyPFCLFYAIqyVHE96fCYj7/ViiERwVZvXWUr/hvaXwMaWyqH5UHZb?=
 =?us-ascii?Q?aWV/d5ro+yczpVVWesyqWrvN1SliFRzMuQwGGt+NDMML4Us5A2qx/3jJ4EDe?=
 =?us-ascii?Q?wyOrD6JMAwlNQ5sQfyL3bBAtAhav2KZvOfncC12MW0PSzi+IfuVNNrmueuU1?=
 =?us-ascii?Q?c5wcRKNdgztUPN3xlzkvXH9JgWViXSB8yF6bLlED2h9jacQPKlPAEMfbUDvL?=
 =?us-ascii?Q?kQp9MsswDhqgr81ceIqyTOr7qA7tg4oi13LQgMM1HI1YHwFSxjk6oMVbZ5Ai?=
 =?us-ascii?Q?HXN4GsOKHLDV99gSOziYp4C4pCTV6EUGAAnVHW3639h0OaA2uNrvsov+mxmG?=
 =?us-ascii?Q?hizRulkgeiVKUcajnZwx8tj8h2UjENOS3vYMwiqIRkfwEoyYwImwK/MdhUKv?=
 =?us-ascii?Q?7kZ4hqFEMVxrkXKxNk985d5aAsJnLlAhd3jTlSkthTJAuQmKr5GqJMihiRuM?=
 =?us-ascii?Q?b9LMHxvinKlVmBW4K0rwCmiYehheh96ODXo+sYus1f3tInv/s8mY4g2BOWic?=
 =?us-ascii?Q?1Ys0KCXTA/M4/gJpawG/nKoPBsyD1fgsftmQWQLAmQ7gmWZto2qtTBwmrJDI?=
 =?us-ascii?Q?je0PGp5X5U3k/VG9can8qYqG0ZCje02iyhBDEQZqfeYPPUgD9v9h3S1ydD81?=
 =?us-ascii?Q?DAVCoNB6lINK58gQcDVwUBqN+69SpRqihmwodFQQMkCoOIF+Kp7Fdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wbq2GU2R3xkpmH31VSI+iozzBD8XCl1pSOPz8rKJ+I+v7ijinFbnvyVCk6uI?=
 =?us-ascii?Q?+QWPfeP87PYCKyIsb/uvGFN6S7oooQD+CvAkONTnP2iEr/FfaH9AosBa4sXp?=
 =?us-ascii?Q?3P1tncO3RLD7H+kcJKmhjDaBuGckMoF0HQmnd3wsf8JYCqtfjLcudLdIhDqa?=
 =?us-ascii?Q?+YZkLNlPQ7baKlPiqIq//eyK/r9w8QbYsLcEDZuCdnE+9Eblm80YcQrwlg8V?=
 =?us-ascii?Q?h/9lyMnRiM1LZ9ZU9B6vZqO2Pt9X1ev4mt8IdCOG5A/AG0wOv80VPs00ZinT?=
 =?us-ascii?Q?eIN1GBAyl+eWFVzaG0aRyYAa5QCvWjfRw/r7dHgFKCm6FrjdAuQvhVE0j655?=
 =?us-ascii?Q?/QYWhygshwQupnqhm3OB/uX4DEPXaKVoOKZMKLSWb7ZhdDtIWIpAFEZxQnge?=
 =?us-ascii?Q?1P143/SKouO3TFw2uf2REsqC8V0jhgmp8kwsbHlUjc5RtEw1IZ+Z0iG7o6Ac?=
 =?us-ascii?Q?14Ot+8y0vbDfibGMs4SPBYNLF+c9+FiLNEa6QT7JC4mcOPoswsqpWWtRrqpD?=
 =?us-ascii?Q?xSnxN3GYV+bKrRTV/mFYo1qF72fKLEr5HiTzBSNzpVf7ccMw+3yWWU+DAZ6B?=
 =?us-ascii?Q?eUe8J2Tr4W/OZ8rTMPafHgQJAicqk6GUKR/Ay9n8uVoZfILeK62NMh5VDih2?=
 =?us-ascii?Q?ML62jvAiKJClr7EalLmHEU7xO/60Bf2XFCxxB9Bh0xUwSlUJjGnagAkIl0mn?=
 =?us-ascii?Q?xgCbwhvw3+jtRjZdDco0Vk1Ii+0ORWFJjiHWQH6D2cnCOch9Fww8tUkDFUki?=
 =?us-ascii?Q?Q/U+2x5XPR4POJqFy/57TKf+yCJ0N6A+qGov6KamMkFSvOnzYAqw7DSlrik3?=
 =?us-ascii?Q?u685/TyhcQ6IDnAyhUFyGh1mR1BIdsaNREsji4U0vJDUwTsIzxy8vhWBuJUr?=
 =?us-ascii?Q?hefbKT8rn6WN2HbqEnckybv079WAz3uhL2S9sXk92otyjGkAonz7UVoAvteo?=
 =?us-ascii?Q?3Sm1frw49aBvO3SXImRkGszRGPRVHDGjGa/GbCYQa6ur9A2nFxFmd696N4Bj?=
 =?us-ascii?Q?rDeksLsSnYn8P9X4hRezTm2TGr+/PfXbMvwR+Dy4d6AJGqLcOq1cxKaWeXaR?=
 =?us-ascii?Q?zi5JEHoCuaORzG1hEYK/tgvxggPyp1IiBAiUdpHZV8dqqKMak/cBxutPm3jW?=
 =?us-ascii?Q?cBRCvax78K449Ji/GJhhpLRZl9vg589Khhi/TPI1DxC5MsZiqnZiAOEYn918?=
 =?us-ascii?Q?xqCaW1uQkgg3O+vnoQDgif095l8Ot19i3l0mIIVW1wx/EPx56AXhvMTsfqDs?=
 =?us-ascii?Q?h6/iiOjdl029vKxZCs9vq3sbLxhTNmGnln6sh31JLJpc5qM9pWFOtLfLeMIM?=
 =?us-ascii?Q?hGgiGwYt7Sf7EbjdaphC7uhWTmK7woVOcNQ9GoXMM8yMudiUyM/vPuZOeAMY?=
 =?us-ascii?Q?n6+BPpPSHMSuIcDgnHfEe0HDajwi/XjfQtvhF0qMSICyiHB0CZUKc8cBOUwf?=
 =?us-ascii?Q?AzZmnQGJ6/zgdmYtsROj/lAR8wN+PKHDrftPm/WSXH+IvMJOTTtGh/MDABUK?=
 =?us-ascii?Q?dGrgZmGBuRD/p7YzsdaVpfTXmeMXC6uCJxpJdDqdrVnetF+LaumwVNk0pjGP?=
 =?us-ascii?Q?X5r9kgZWF1R59EMZrWHXFRt38VShh4kwjvS93+X9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd76834-b891-4082-1aba-08ddc3999e49
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:17:51.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCXtsnSEfhzbQ9mTpTM11S/zxkG04p7dBnfd2Wg/6Kc+0h5Z7Glj3kwc6mxWcre8OfXpG6CD5Qo36umxQJicKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428

Use max() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/wireless/ath/ath9k/dfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 2fb73a5e1d51..370346450675 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -239,10 +239,7 @@ ath9k_postprocess_radar_event(struct ath_softc *sc,
 		 * Radiated testing, when pulse is on DC, different pri and
 		 * ext durations are reported, so take the larger of the two
 		 */
-		if (ard->pulse_length_ext >= ard->pulse_length_pri)
-			dur = ard->pulse_length_ext;
-		else
-			dur = ard->pulse_length_pri;
+		dur = max(ard->pulse_length_ext, ard->pulse_length_pri);
 		DFS_STAT_INC(sc, dc_phy_errors);
 
 		/* when both are present use stronger one */
-- 
2.34.1


