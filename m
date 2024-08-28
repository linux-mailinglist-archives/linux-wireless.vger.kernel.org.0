Return-Path: <linux-wireless+bounces-12104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393D961B89
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 03:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477EF1C2316D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 01:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115C3B1A2;
	Wed, 28 Aug 2024 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="q6Y0DKoX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011028.outbound.protection.outlook.com [52.103.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D3208A0
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808899; cv=fail; b=CV8StJOuS9xLa+jPWcd2s2ojIiilVVAXxN4KqNuFNaVjj5MeWlOd59SqNLADWMC+x7LKZ9TOZurPF1VCg3Setc4vNhQmoF9hAIT+6dwdCj0xb6Q06u0RkKiszaUs90m14rpnzDXZx909vkFy0QWCnioERs5XYj8slHzTNos16As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808899; c=relaxed/simple;
	bh=1Ty/yvsOJLgvD9Q+pPgosUCkXIIed2YOjJM6B6xVNIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PkvxbyMZibF+74ro3K5Ph5DLjytpevMubixCZt//nbUpXEQTo00+A5lpcq+Kqmj+s/EWf+5XALb//piGuPrEZyAUfwPx8VIM7pCcZSvonCDgjjqazTYxz4VrLx7T4N27uyB/XJD57DCLqJqd1y/yp7tB3DTRxI5gyOUO3hlcerg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=q6Y0DKoX; arc=fail smtp.client-ip=52.103.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu4VBt6tA6J7N0FiP6sVUG8i9AVaX0HxR7PIOxGwsNeGKHSnvnx6cEhRUYDDwXQ2PQHcy+8sGHW8rdQhgP+Dt+szF6N44JLQ16Lr1mW227aQ6+LVzY3BFAdYWWYt08yOD9jEZ1r/zMUfqL9iSw+weI+i/lkifuIrvW31FkvceLXMwOvGOUAubdofjpm+wkOk5k7sAApst5ONRHdZz5AFrNm1TyQ37FTSaMawUt3FLelEAHWWcf8PjrQAIx4ntqOG7WRm4WmSApTKMBeOICWYUcsRYx2QsEF/zknB3d2yGQbcUHB0P2OvvRSM7KvPzaoKCiIkBPqtxReWwtWXL5QRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zntqPmhcVtciLqWHhR9EdyBzIWstLLmKHAVVZywIYqY=;
 b=mdoFktsCcVYtHE5pemIIX3rCxHhFL0bOOiF/t/N2x9N2o8QHmLC/ZB3AxCTVjW4eSqj2OS1nxT3tETJ04f5qM8122A5DaQC7snIBByrLIqxvDmv8BLRN0M2sJFDsBNWGydjNaNVu2IeWVZVMiX42BU7a6s55H4MM/+2SBv/Xj/7ZQOk+OAXNFO8G7Hd+Y+56y76JtFnbZcH4g47ahHYMbyvs6gSC738zs38Lnnd4h8OTcv8LymsP+HVsN5DVjwhqdWzLpUvII+xSFbr8nGzF12w0ZhJH7aEfPwrhzJqrbWTuOknlhy19pkD26qnWYt/o7wI2i8VPrhIacNTl3t0mTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zntqPmhcVtciLqWHhR9EdyBzIWstLLmKHAVVZywIYqY=;
 b=q6Y0DKoXnQd2eGMQpZwkHoDIUqx7rGrC4BMgcDw3ifRPU8ezyQPsEznsE1WUGW/McLzEeBfqk1uGZ/bZSxn5MxhEfOZzoXhY0mdI0XAfYD013bzrbshxa3bBpgkvPw1d6SaZApf4r40qzKH+pvi7h8dZExXJcMIHo3Tbc4ct56tT0hZFKduv/XOdcI9beukK8yRqi0gZCCUHHhwqCd4FiJZj1XvcynsuJ5iTKb9T4QEhLD0vxW081/VkKM101x8rUQgbcBrTrA29ROVPRvNgNYy+Wx6xIJbkXjo0MTqmoKPwJmtAIuvnOBsLEykFxjVHQBVaCtePPji6SNTIc1UWAw==
Received: from TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:85::11)
 by OS9P286MB3883.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 01:34:46 +0000
Received: from TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1672:339f:cd51:afdd]) by TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1672:339f:cd51:afdd%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:34:46 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: nbd@nbd.name
Cc: linux-wireless@vger.kernel.org,
	yangshiji66@outlook.com
Subject: Re: [PATCH v2 05/24] wifi: mt76: partially move channel change code to core
Date: Wed, 28 Aug 2024 09:32:10 +0800
Message-ID:
 <TYAP286MB07463C077B2D8D3D5FE6B2F1BC952@TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <3f880bab-17d8-4a8a-aef6-c7ed005420f7@nbd.name>
References: <3f880bab-17d8-4a8a-aef6-c7ed005420f7@nbd.name>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [meXFRILUfoNlOycrDvMqOcunEO2ftTJ9]
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:85::11)
X-Microsoft-Original-Message-ID:
 <20240828013210.3338-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0746:EE_|OS9P286MB3883:EE_
X-MS-Office365-Filtering-Correlation-Id: 50092015-adc5-4119-6059-08dcc7019940
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|8060799006|19110799003|461199028|3412199025|440099028|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	xQpDMtk9eAxT6SpYOSbWqFOTveYKvRlxku64Nx6Ff8z4usYum0XOICAD/Ev+gwRfmmDm1vMOSplAxrHTLlJ3+Y+QM/yxhGcSrlx+96PadPnuRD2PBl8Z6HULkfYGAPitdDONwpJr/Zh+NrAXXeIkcNI+cOD8fSiM+iVkMu/xW5ga7C7XYpY3DbC839ibniniEuuIHW5Utb7VGXaYBy/amD1yzh76hcU2HLNxp5N3ao0WK7grrWynBnfzIvhmYk1f9MvQqcNKqpSEHIv3q1vgcbb/vgBWS7YE7/58qP5Esxg79Uiir3M71k+QVQNyrB4wvNG996d3PFQE+LydEQACX81CobBTPbw/WQiN8U6AGBE07IYBFIvbo9toDM7UFCj62/6eVkUVZrd5Na7gHNFM9di2r2/2IVH6XUQHjjDE5ZJUuiNR36L69Ve/JIPQnx49hynGoPfw//C4TXIBMfk6MeHVRblyFXoQ0O9lDRQcKosqnKyjTBoLx3LPn85XKRAcZpBysJCQCvFRRT8iFI8uujNgHGL6+mvNb9vbLWprKiTc7ArurpuhmSybwZMgcoNi0Dpb5nzqq8jEwgEDv7ATS1Q0y4O8cQHJ5fBUN0M1iSBkWml9HswOsda7cxv+lhw9cxeUjglKooitjHwYcBBH3shqXM3x0xJcj5uvG9WX+PzFQrpdmVqJIM0pqvUloCm5WGcVZMtxzCTDyAiku1UAOGhuMV72XGO1ve6Oyl0pC+sE6yidHRhmD9g5LndDyMic2WWcTD2lN/Djk11W745zS3afbjOkYgdmNKiLHDJD0iKxxIqpfxfVdNX8B5ylIv1jVCqa7MBxCHg+Ln0oUMi2Xg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fbggbPAlYEAhAQTHcFXxb5sSbywAJq+w4DRbLoCy3CHi4D2/hSG8lvQ3ivIR?=
 =?us-ascii?Q?GzlY7dZ38UbUDtyYacdAiSEe+D16dz4ZP0g5QANbZ8pfaNEwwByq9yz+ABmy?=
 =?us-ascii?Q?gxd+c5ATjIGWhYLu3kPinfWAmzJAeXTQZX/lBGobQ8Ek/RYg8kuyx/Z3w1ye?=
 =?us-ascii?Q?A9zvgqonkw1uFPkM5vbS8ESZBqggb/h6/qe1GO9/IRqOXVXgacntJxJkgt2U?=
 =?us-ascii?Q?bNmk8cWoE9gxTYowxAgxWDdae47SrpXjXj+CVLmOJS39MwrfDnR4vFCmkbBw?=
 =?us-ascii?Q?7GFXqQf4EDxeZU4S8VDGiFdtMm9Z7HB6d/xLvfJDv/B7Tb21yyEdzaPjbZ+4?=
 =?us-ascii?Q?RtXUufWZcM50OsJayTaGhaxKmuW0u+dxlMe8ogjP9NSizqOPv1JXjQVaw7BQ?=
 =?us-ascii?Q?s4w88to513MSAeDkfkWvnn/lztGfyxF4B8Zt42kqFNMiMeE/stNUSkkTtgdQ?=
 =?us-ascii?Q?7ZFIEY94mIa49+R4sN4SdAET0n8QirZI/pwa6yI/QPWXq4f9SBWMta3n3Pew?=
 =?us-ascii?Q?w8MWibWcVYOEKpZxl0eWqa0GzxaZXnMJMGaX8JYcBQH9HJLRsRSXTGLfvwg7?=
 =?us-ascii?Q?Kc1b5am9CfVNNUExHJK3Xf4MBlY2kFr49/JiuxAyGOFT2yE/UMfNppH5RlwB?=
 =?us-ascii?Q?trjOSSCylEm9SEfFoMCo2kLNrHoAOcAryaclhp5IsF788G589yhb0C+pBaTf?=
 =?us-ascii?Q?Ehcih8q6JuRFVtPCcJodMUATjudMv51C94lT1cWB1zJ16EzTAyi2Y5BaFn4X?=
 =?us-ascii?Q?zpQg+CtQc1J8WTdrZs50739gLrD/NZ1yHS7O5UwU9CInjeFKEDcbAlp+57Fz?=
 =?us-ascii?Q?py+F1bF0UhGJr1RTc/UP6cDIwbmsh3kKU1x3h1OTGTRoJqCGsa4WORfy91c+?=
 =?us-ascii?Q?JT4aw75E8yqVTDIORIHXqjGH8ahGEryGnP+tikxwkgE4i3fNwnuk1oHEvOfq?=
 =?us-ascii?Q?rTTYa1BLzQoyWd2rDYBznR/TU/sN0dxcdJra5yxAmlYkHYCkUqcfMpBq2lhM?=
 =?us-ascii?Q?96yXmzmiaobptP07hhFqZLfmVCAn9GXHxDuwBGzc3f82qQeJGNT5PGSP22tC?=
 =?us-ascii?Q?NLbwVGiXGNmSE5CxBkluLDln1IezgnidFG7JWTr5UGDq3E/Rc/vIm3DezwNM?=
 =?us-ascii?Q?fMVbEYqeZdW9vlbfOANjxjHhqN58vdKV9afKtTvJqs3hBPMRGnQO99FmRRHr?=
 =?us-ascii?Q?5mMjuaDThLm7mfBP3hWRDungjzjQ+aBjKprK5XmUK2LBVH/jm7lNmwAmAqvV?=
 =?us-ascii?Q?ddNFWBAjOsbgXYpMeYJJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50092015-adc5-4119-6059-08dcc7019940
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:34:46.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3883

On Tue, 27 Aug 2024 20:37:28 +0200, Felix Fietkau wrote:
>On 27.08.24 20:02, Shiji Yang wrote:
>> Hi, Felix
>> 
>> This patch broke the MT7610E. After this patch[1], the client
>> cannot connect to the MT7610 AP on OpenWrt. There is no error
>> log output. BTW, MT7612E still works fine.
>> 
>> [1] https://github.com/openwrt/mt76/commit/b80c997b3ff6f3e32fd729dc1c97709da5779fa1
>
>Thanks for reporting. Could you please test if this fixes the issue?
>https://nbd.name/p/55035e55
>

Thanks, it fixes the issue for me. Tested on MT7620 + MT7610E router.

Regards.

