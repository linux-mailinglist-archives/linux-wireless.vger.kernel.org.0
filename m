Return-Path: <linux-wireless+bounces-34315-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDvaIHITzmmnkgYAu9opvQ
	(envelope-from <linux-wireless+bounces-34315-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 08:57:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5257384D1C
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 08:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D4AE3018764
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0BA328616;
	Thu,  2 Apr 2026 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dsXyYhXo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010019.outbound.protection.outlook.com [52.103.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E9320A00;
	Thu,  2 Apr 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112604; cv=fail; b=Sf3gZpwX+lsR/KQSqbi5LMQR367c+Mjkec/cOI8YFCW1fma0qD29li2rQvgN7fjarvUhj/uqdm1KDO616PztBLeZdTSeGn2ByZslGlLYbPCe6/Q1gofXoiK1urUxU2S0pgAjgufHVypZky5sfi6tDFSXfb2UUKWoSc3MiTagDus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112604; c=relaxed/simple;
	bh=2xrCPATmp99GCbqXT+5qUk+YJdLb/e2RbGsp0Ympffo=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=SuY1QEVZdHLDyb4qD4rbjDK4mNv+sK3aAs6HK440glQhfVqY55kjOkb6iCNmormeUymEbF0isjBJYiVWVNenn/l6A9Lc9oVoSkYxP1Nx9wTB0LATHIDeT4BTpPOsdesC+4tzQN6eYojbvBHTp4sEiSxbBWqlw4zmCdNLx4pg1MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dsXyYhXo; arc=fail smtp.client-ip=52.103.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpwmYzCeTKarIAzlb5BRNnmg0Yw0ctDKHAZFTR4BzPLDD/X1ZDUcRJt/yF41inS+gv1ZdL1s2Wsza3cAZmDXmw9b9AuL5xtqIt6uyEIELygsN681KhlBf5e0luHD68Hm3zTlBepX9t8mXOX4kaTA9zHimThf5NYetGbtt1cgvExg+IVioHydykyDP4WbEVTHxSTKWPaSmne7Z8ilIJk5oGOxaO9eRHMk8+hk5BIXokpToOd2sJ3RUg4xqTaErplomRaElHLpNpal6XHQpBWSRGqR9r4F8yzTfFFxHh4prDZiIgIfrndq14HwljWJCMT4LYp0cHGk+hTeTIkB771TJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3N1ecifa4s8jG87JCykBBBqaFW4O8cXupYszNNwopY=;
 b=uu8Lth2RKje2vI4zgvmAYKoJdNL2DLmldDDrcqlISw1ftWbeay/M3JZG0ndVx5skU9fgMLdVnp/Cx/Tx+YvH+HqlSQXpP7X6t1g1JaLWrma8ygKmGB6esEOVC3A5oiqckNDnH124zDIoQhttV5KOtUloNEfZ0efdco+p0D6+X9QUeohhh1O5ne4LLaUEAaatH+SGrA4C6NNc+BkOX17kgi6A97+qg3bpwuovBwEQIL0WTw0mj8Qf8nqr9/gABKI0G9ALjb3e+3sDGNZXJRMcLv894lT+hLZSpPtKw1N7VBFEHaMJBXhIOZP6OiTiZa7HBozQvkXnW036Nup+uJizXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3N1ecifa4s8jG87JCykBBBqaFW4O8cXupYszNNwopY=;
 b=dsXyYhXoc3eX5vQOwg2LSbvTfDxuq3Q9N3RlOkN/mU3Xrqhh7YNMnw2iBJlqA0tKwap/Ztt7PEZS9iXVyy3qmWuVv94OqpDagpYn8HQfqQu68XvLQFRpvWk2JaPrmUAEC+mmsz/b5H7Ov6xV40jFMaWOQlv+I6H2LpnGCP/zfGJUaWX+EkZmRXFMuJZ9eM7EgaNEKkjmq1snp4WfeLkMJE3tgK4Ju+sbjxJPvBRxZ0zAtJGvkJZMzePOBZjnp0dC5r/w3r+5gmhFXY5e5Qv5SGHlFDPe3UJQg/UkZWJr8gKcnbnVPxHZlkXKqDi9ARO2ZF8opqGj5Ak57TEwi80Tsw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYZPR01MB7325.ausprd01.prod.outlook.com (2603:10c6:10:16e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 06:49:58 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 06:49:58 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 02 Apr 2026 14:48:07 +0800
Subject: [PATCH] wifi: iwlwifi: mld: validate sta_mask before ffs() in BA
 session handlers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB788115C6CE873271A9A15A25AF51A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIACYRzmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwMj3bTMitRiXQtzU4ukJDNji0TzZCWg2oKiVLAEUGl0bG0tAGOs9Fp
 XAAAA
X-Change-ID: 20260402-fixes-8758bb638a7c
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
 Johannes Berg <johannes.berg@intel.com>, 
 Shaul Triebitz <shaul.triebitz@intel.com>, 
 Daniel Gabay <daniel.gabay@intel.com>, 
 Benjamin Berg <benjamin.berg@intel.com>
Cc: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>, 
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=2xrCPATmp99GCbqXT+5qUk+YJdLb/e2RbGsp0Ympffo=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzHOCajfv8F26vHMX1w1jyfSC0pIrKx6cvrKNuV30l
 6HHbN7nPnUdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMJHTRxgZzq7gf8Oq2fv0
 kgPbnBmmk3NjO5d+CpzFfmxHvgj3sU4dNYZfTCHtjOyrFh9f/P5ZhbZ46am8HzJfz56/qLtrapO
 gDU87MwDiv0rZ
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4P286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::14) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260402-fixes-v1-1-63dfbb5ed61e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYZPR01MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: e4258234-9205-477a-0563-08de90840d4a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5062599005|5072599009|6090799003|24121999003|15080799012|12121999013|22091999003|19110799012|23021999003|8060799015|40105399003|53005399003|3412199025|440099028|26121999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHVIbDc3UmZYNnpQd2VpWjRGdFVtVTVTMXRyQ09qWDZudzVtZDd3bjlMNGxS?=
 =?utf-8?B?d2lQa0xOcjBxMkswdW5CZXdIcGhEbzJ0eUp0MUFhRi93QTltRUJuSUdpUWN6?=
 =?utf-8?B?ZWdxVHlMSytjdk5pRzR0Y1licW5lWEg2K1l4NHI5NlFrNm9ya3kveUFNdndl?=
 =?utf-8?B?Z1lySENzRnJFc0VkRXJsT2JDK0lRK0RSZjRHeGFMTVJ2MzhVWFd0aVAzZFE0?=
 =?utf-8?B?QmpFRGIzbjdRd2NHVXQydWovYkIrVFV4UzNsZFdvSUJrOFJDYW83N2F6SVYw?=
 =?utf-8?B?VmlWTjdFSFJic05saXBXdXp3Z0V1VnNLL2c1U3VpU0NNQkRObjEwT0YwSmdj?=
 =?utf-8?B?WUVxU2hRR3FYYUhGVFFkUVRHODJwUGEwdDJPTlYwa05SUUd5V0c2a0V0Q3k0?=
 =?utf-8?B?R05IRTZpbWYweXN1alBZT1RFcE02bFRwL2JGTnVuQkwrZTYwVG52d1JOdUc4?=
 =?utf-8?B?VGJIc25QRzVGR2NzLzdoaHVvMWJZWURYR1I5YzdLRTBzZ21tOUJDc2YyU1BH?=
 =?utf-8?B?aTl5Vm52ajBaT08vdm5rOENzRE41WXE0clNUMmE2YTczZnlYcWFmWGY0ZW9m?=
 =?utf-8?B?dzc5RnZqVWRjRHBXaW56czh6Zm9mcUcyTENCVDBub3NuNVdYRjRDNVJDd29l?=
 =?utf-8?B?ajkxQXJUM2RNbnIvcGg5NjBxRVc1eVhwTjR0cFpzamJ2R05QOXM4SDNXRzhw?=
 =?utf-8?B?b3FNdUFEZHV4UExrRWNjb21uWlJBSVhKNm11U1E2b2xIQ1B3VEpSMkllb3dJ?=
 =?utf-8?B?OEJVMmVBRStlbW9EYmlrb0c3bVd6a0RlejhrWlM5cVR2dzEzTWJuV3pYVUUr?=
 =?utf-8?B?cGc4OXg3Y0tDbkgvTGxhNldreWRJQlhKd3hrTTZnSUtXTWZEQng4U292TkxX?=
 =?utf-8?B?LzZTOCt3MWp6UEJhcmk2M2xOMmZjTnRIS3dPVElMejdzN2VZeURGRk9WNVlq?=
 =?utf-8?B?eC9qZU9wSndsenFjaVVGMXovMTFVVmNuTG9yMzFPajd2TysrWkhkTUtBa0RS?=
 =?utf-8?B?ZXYzVEJuM1lxS01HNzlIQ2V3S295WWVJaTc4Z1ZTQkdYT0N3c1E1c0ZtZFZV?=
 =?utf-8?B?ekRuZC85VmZoRlUxSHpwT29WdTFkb0ZBQlpqTTE0amh5WlFobFM4b3ZJekx1?=
 =?utf-8?B?MVdpR2xVZStHK0RsdkRicS9OUlpOMnBWZk03WVBvaWFYWWhvT0JPZnZ4UXJj?=
 =?utf-8?B?bEpnekFtUGxPVk9jMEd5STI4ZUtRL25NWCtVTmZxSEtLY0V4ZjZ5RG9wdlBs?=
 =?utf-8?B?L0p0UVp0WXJ1NHg2dVVpbis3akNVejQxSDBJTmJvcUFpaXdwWjNvNGZWNXAr?=
 =?utf-8?B?dEFYNU5pVlJPMFFwWkQrTG9SRzdRNGQ2SDQxOWVObm1xdEhyWmJXUURTSVk3?=
 =?utf-8?B?S2JiTW5UbmF3Kzlhb3dIRHJSbVFISmZXdVpaUy84ZDRzWm8zb0FtWTVsZzB0?=
 =?utf-8?B?Q01YczVJc21tRmR1N29EREdCKyttQmU2QXVLQ05CN1MxTDZRSDRZNjNIbU9i?=
 =?utf-8?Q?+cRlWTLCZMUhlypQLWkvn87W7ZG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elBaaExhM0JQTVRHTmRjSlc2aGtXWEZjR1p2WklhNkNsVzhudHJKKzZvYzJn?=
 =?utf-8?B?VVo1WEVDTlVhZkxwSUdBWXJwOTNVNkJ1cUZwclcvUGU2TGlhbEZOU3lQWjVO?=
 =?utf-8?B?dkxJcVJLK2tqd1pFMllpUldzc3M0QUlqUloyb2pZaWU3WW9TeE56alE4MTl0?=
 =?utf-8?B?cFZWMi84bjk5WVNqSVBod0lTeGdFaDMxZFZwUHhyZVRYUmszSVlSZW13dVdq?=
 =?utf-8?B?TEEvRGRCRzZ5MWg3OGJQc2hIaGh2ZVlYek1Kb2xSLzFZK1ZjelhQbjZXZGlZ?=
 =?utf-8?B?VklNZGtsbGJVNWNueDBTbVpJYkpBdjNjanZuNDlGNm52Q2lPbEo4Mi9LajFD?=
 =?utf-8?B?M05XTGRvV0JQdjdsUkh4c0VqaDRINy9DSzJ2RU5BZ0kxRitQM01VbHZoN3RR?=
 =?utf-8?B?bk1UeGJUR3Q2NDMxazRwbGlVOXlnL1N2dXVZa0QvQWNCTmpxejNLWDlaNkNk?=
 =?utf-8?B?SUVEMFB1bVNMRWlrRU5KRytJVlBIOHQ3bkV4dG41Y1VRWmVZMHdONHZNRnR6?=
 =?utf-8?B?a1YvSVhUZUY4d2NqbTNjNW5Fd1VXOTROQWRjL280NW1RREdrd3B5dXAzdEZu?=
 =?utf-8?B?L2FlOENUcjA5TlQrZUpUZ0ZOeGxMdVRKL1BVdmNEYlRqKzN4R3pNaHhNdlkx?=
 =?utf-8?B?WHFPWVRIRGhBeXZZZXB5MFdEalJNelEwOUhPKzlHeWVjekJtMWhwZkZyU0pz?=
 =?utf-8?B?NWxvT1VZUVR5bDlqcTZPNkh3NlM3TmxNNzM2T1NsZzlZOFFxUDJrS3R5Szhw?=
 =?utf-8?B?YVVSc3JOU1NJeDdaS1JuaittbVQ3Sk41U1M1dzM0VWdSb1BuM0lrZDl5eWNl?=
 =?utf-8?B?aWZHMzNqRVVXK2RDNGRBTUw5L3NUZWVPQmZ3ZmJpWXVTQXdmWTNnSFNLeG1v?=
 =?utf-8?B?MGR3STJqQUlqUEFCWStYb0F4MDJQTis4aGNJTmdFTHVObXpSY2NSWVdEYWlM?=
 =?utf-8?B?Vis1MytzZURkUGZlTXRmMllDSmN4c21GZER2REdIdkZjLzFWcVBkaTltcFJF?=
 =?utf-8?B?RTAzaWJCamcwUWtocmFqVkJlYmxZZStXc1lBSndNR1RONTI1QWNBV2JPRUV0?=
 =?utf-8?B?V0k1bmFYUnlPQVBJRmx3V2dsTDFSYnp2aHVNMHhnSXlwdXp1WloyYk5DbWtn?=
 =?utf-8?B?eWtEM1FSdUs3UFh3ZDlzbDdkbHBKTmxFZXM3d3U1ZkRvS3JOVWRrbUxzSzVp?=
 =?utf-8?B?Q3NRaVhMUnFVcXVOVVpYaEVha0pNamtwa2xDSVFMcjROR0NIMWh1L21HRm1Y?=
 =?utf-8?B?SHFPV3lXWlI5VW00VjFmc0ZMTnJIbXQ3aURrRks3RnVCRUdRcG9zK2hCdDJx?=
 =?utf-8?B?U1dqb0x4VXhpSTBmRzFsMDg1UXVMWStyQmQ3OXk0YjR2WXUxNzA1RlNDQVIz?=
 =?utf-8?B?bFh0NzVrUlhsUi9ES2FMRE8yNVRxOSswVjUxT3pnYUdwaFhJNTlpd1I1bm9i?=
 =?utf-8?B?N3lIZVp3MVpJNHZ2VjYzYXdlTWRSU1RGeVBzR3BVUE9oL1dRN01uQTluSlgv?=
 =?utf-8?B?dDkyVGIxUEVkam1CY2dMa3I2dVFzSWZtVnBzdFZybmdWYWZYWVM2VFp6SlAv?=
 =?utf-8?B?UFdCZUVMNFdqb2tIUjB4SWhvelJTQlZkOHJjcmVwME5xYmgwSi9Wc2JXZ3A4?=
 =?utf-8?B?NVpHcmM4Wmd0Q3owTU1nU2JJSldqWWdRc2x3eVRVVHlPYS9yc2VZWTdSZDVE?=
 =?utf-8?B?KzgxZHBxUVd1bHpYdkRENENhbHpJNS94dTNZbWt4QkNOazdacldRU1kvUjla?=
 =?utf-8?B?dzNZeVpUMThhL21tZnczQVB3QVdWbzU3eGw3Q1V5VU9lSk96ZWNoQWdyd0Zv?=
 =?utf-8?B?OGhOd25hNUM2NWVBaFJsL1ptQ0NwVHkyMGdXQjdWSzZYL2M3ZjZwSEtZeWZI?=
 =?utf-8?B?aDZiVTdKRWJDTyszMk5tdXNxKzJtMndiM2ZnL0tVRVAyWXc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4258234-9205-477a-0563-08de90840d4a
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 06:49:57.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYZPR01MB7325
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34315-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5257384D1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Three BA session handlers use ffs(ba_data->sta_mask) - 1 to derive a
station ID without checking that sta_mask is non-zero. When sta_mask is
zero, ffs() returns 0 and the subtraction wraps to 0xFFFFFFFF, causing
an out-of-bounds access on fw_id_to_link_sta[].

Add WARN_ON_ONCE(!ba_data->sta_mask) guards before each ffs() call,
consistent with the existing check in iwl_mld_ampdu_rx_start().

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index 3bf36f8f6874..e3627ad0321c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -64,6 +64,9 @@ static void iwl_mld_release_frames_from_notif(struct iwl_mld *mld,
 	}
 
 	/* pick any STA ID to find the pointer */
+	if (WARN_ON_ONCE(!ba_data->sta_mask))
+		goto out_unlock;
+
 	sta_id = ffs(ba_data->sta_mask) - 1;
 	link_sta = rcu_dereference(mld->fw_id_to_link_sta[sta_id]);
 	if (WARN_ON_ONCE(IS_ERR_OR_NULL(link_sta) || !link_sta->sta))
@@ -166,6 +169,9 @@ void iwl_mld_del_ba(struct iwl_mld *mld, int queue,
 		goto out_unlock;
 
 	/* pick any STA ID to find the pointer */
+	if (WARN_ON_ONCE(!ba_data->sta_mask))
+		goto out_unlock;
+
 	sta_id = ffs(ba_data->sta_mask) - 1;
 	link_sta = rcu_dereference(mld->fw_id_to_link_sta[sta_id]);
 	if (WARN_ON_ONCE(IS_ERR_OR_NULL(link_sta) || !link_sta->sta))
@@ -347,6 +353,9 @@ static void iwl_mld_rx_agg_session_expired(struct timer_list *t)
 	}
 
 	/* timer expired, pick any STA ID to find the pointer */
+	if (WARN_ON_ONCE(!ba_data->sta_mask))
+		goto unlock;
+
 	sta_id = ffs(ba_data->sta_mask) - 1;
 	link_sta = rcu_dereference(ba_data->mld->fw_id_to_link_sta[sta_id]);
 

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260402-fixes-8758bb638a7c

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


