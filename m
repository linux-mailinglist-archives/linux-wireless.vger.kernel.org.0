Return-Path: <linux-wireless+bounces-33193-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDSmH73As2lQagAAu9opvQ
	(envelope-from <linux-wireless+bounces-33193-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:46:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6D27EEF1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 08:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 895F7301702D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 07:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4704E1917ED;
	Fri, 13 Mar 2026 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="0LyQOIvO";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="WtSB6QuO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45FB79CD
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387958; cv=fail; b=iTxMLOs4dfGnPk6s1M0K1RGS151SwaRJX1VfEbhiOvifiQwEe9A6LB4sMeNEztr7glJY+KYCTUTCQs8+phr/L1Y8usngQS1fZ1rISgdRB3sER6upKlmNRaB7YP5cEezrWfiZTJrDQ22tWAoK5Jj7vynFom6d5yZTBuKCezSd9Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387958; c=relaxed/simple;
	bh=by++VN0uiWfotbM8pukj1k0ndSq6LMDqN04VxgY6ciE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=udh2LRW8StYh0Dsm4Cxj6YJYMzxokPGgvi2BmRRmCx1dRzRTw6YL9Ny0qx2v8v7fn5p/XEyst3VmrxRiY5A+86PGYvfs8ETAxdpDb4bXwIv8uc34FIV9xoFMsL2mDHsO2r3Nof8pXlw4DMK/UNn/M4Ehls7f8d+701TccuuRPT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=0LyQOIvO; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=WtSB6QuO; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6K2IN1994416;
	Fri, 13 Mar 2026 08:45:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=JeC4+2DjrpiSi2SzYcd341
	UePyLBPC4sJgrtnQzpioc=; b=0LyQOIvO1KgBpEJFokBJVrj9GQDmSxFoKhwgA5
	OlnlJb3M3+6Jh9TBDyJtIaitcffx2FFHo3QPEOupFyHcCNNwbIH43VajpeWSOGoz
	whStECng1+SoCKIavAKc9pDFRCOLOBIZyp+pbRvUemfw24lfnrfdDIu9fmXmfg/4
	7GXsev50vQ5P3oSfHK4XXcl7FjIdu8tdYoyBc6T379SxeSvuCUeFLB5tRGNUf1qj
	oYIm0ICrAhHj23s8qEE46pBaBkrDQK756SZOcgm7MnhfuVUA8ZDok21ACOBDt2qB
	V5aGGVzXTcdP7NKN8PZU2NNPPw0xTYKsRc+LLGH3mjJcBc5Q==
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11023112.outbound.protection.outlook.com [52.101.83.112])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cty3gj7dh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 08:45:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbhX6JNvRgAzQ3a8q33qP1i+xTFZGUh/5HkoTfnvSp8qwrXLmQrPgnizCeLbjv0rvqTRITaxfCx+WFPicQsdAieJx+mrMRWPfNIyAuawS3OClL43RULjYr5Whqulw8OYUsq6w2wLqk+YdKsYUSrDKi2TjfvS5CJcGlRb73jVqNAkgHM4s/USkMDqrngfqtDcQbTw4fPpOnxLPD0F689xTt4YUrVcq8Pa2I5CPNuRM/iTHklmvtXJKNtmulhUsJtVgQXFdhCrSw4UpZ3Lizj0HhoouJO+El2945h0xopjTya0kmsm1cmrZdGNyy53F77RMZSSqxUrxyv5gbneROdtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeC4+2DjrpiSi2SzYcd341UePyLBPC4sJgrtnQzpioc=;
 b=s7pUGGxmXrAj/a8ErnCgYCYMms2cLKsYdmCvLHe0Uooia/aMD6cnYk4Mqk8EzwuyH/sZX41Sd1RhAbM1a3iu276xDvIG+PhR7EYLsnEn40ClEo5NPrjKTEIvKEnFEXk10+U3tQ7SUBgKuMKXBL1V3rlXIz/h5KII2b2Id3X+vrt8aQ5BOWN+lZqUEYZzX+VSJ8FmV1QRu1J81SGHZUJMUr4flVXFfQEYrKFXkxmFOEktQbyYbKVaEAL3orHpTRNM4UuO43fzifePdfMAHhIOri3iknp7sot8HESZAQ39fRAdCwKmhE+N73duH3wQqQbogRaSjsoOT+pDm4Syv9EBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeC4+2DjrpiSi2SzYcd341UePyLBPC4sJgrtnQzpioc=;
 b=WtSB6QuOEBeFxbt2lijzPhBnPjde3UOkw3u8pFZC+79oG+l96lYJbsqqwVrgnDiiaV2ZRk5T2A6W5iqMlMkSNm3X+YXIe0RShxAQDhp4r2Oul+jcVXH+55XYUBUZtgAg2h3kDWxFCm+xmJSVxXK4AcTCWrGsorHow6qO5en9cjU=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by DU0P192MB2911.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 07:45:50 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 07:45:50 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] iw: util: use u8 type to print HE MAC capabilities
Date: Fri, 13 Mar 2026 08:45:47 +0100
Message-ID: <20260313074548.563035-1-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::17) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|DU0P192MB2911:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6ba41c-b779-420b-40ac-08de80d48c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EoNOXLRnL8vq4p/9YiBvbPp+JpeDTjaF3Y0qdtaPLbk5JrBuQ0WVWUB33qp85DoqOcrGkV1yrbG+exAbYB8A2xavZvys+vMDQX+UrQdHEvsypQ44PFZWEqQCios33aVLP8d7xtwc+ZFzOWH2FIoEJpMlV9Z8ndnHmR76UMYL9Z7o4mkBBlttAID++Ne1A9BOpkZ3QY3J+mAmTQ1NzdUCYzvyoA8/vprvcQzTne2UFkGic2hujp9LSxeX2MznaqT5jiyQ1WbAXyVO8A8bAZ4qpUJaNePnw7feA/hr6VfK1joiCdO8bRRoK+pEBrxtEkwBQN1m0/ThLgXMM7wpTunCQsi2xKRA01tGRG8c0D/1iYYKj+dav8yDovbqL4JlVayr4rR3OxcPQnxLp+0jUPnHTklrrUNH6ScT6FHcCHra06IxzdSbyARiimRzLMCjkPCtaQXxoe9zJ3RwvTPFkoa+4V+nw6FB1L1dXNsELac51fJ9xlbwB+l2b+ZMLXX1/ZYapxKvD+Nz+XK0vwyQKK1YXNXMg2VrWbHW1vN505ibAVYlYfXA3JTT9L2mVx3YAhtPsVVeVniMVOK72A1eKS7a0263sbGVSs8zyHpBoPcHKTah3i4OF5Tk+wHyUcuv0gpruljGjmDVZlQNXgU0fdalx0sX49aROX/0Wkgd6Q61JL/hfzBfSuqI57SHZBD+i1hlKv8SeXYYEZxYSUqB2btEy88Zh7RIjzrmGFQNZi5scbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3F2dUZod3FoSTRPeUY2Q2YxT09tNTZOWVYwK21RS01vcVZWSUFvTXhOKzRa?=
 =?utf-8?B?TFNMNjVyZFk2UFdsY0pSRnA3V085M0VVWmF5N3BMRkpWRU5qYWFjWnA4TGQ4?=
 =?utf-8?B?UU5pTzJQUGNRRERBWmlqYllPZWtpekJLOG5VbUpRZjI0Mm5TN3RKdW9uUHlU?=
 =?utf-8?B?MThOdkUrTXZHV3hMakNLdnU4ZzkrL0JTaWxIWlBGMVRDVXpZN3BPdTR1cUIw?=
 =?utf-8?B?MjJoTW01bWtEMWxBQkJvZWwxRWFpUFlEYWRkTzBFUk9xa3Q2UGZkOWE4ekFX?=
 =?utf-8?B?bWFQUTRHWW8wa1IyMG9Va25MVExhYko3U2V3ek11RFdjY1pNSWh4bzQ3ajZH?=
 =?utf-8?B?dWtWb2lrMGhLMmIzTk81V0NFSHZ4c2VuaTN3OXg2anRpUmUyZDVrVTRQUnd1?=
 =?utf-8?B?YnBpQlBrN1NucitmQ3NTOW4wTUdidmlhMk5BSWVraHRDRDI2TzZLU3JJeS9P?=
 =?utf-8?B?SHc2ZWVpT3VyWmhpTmRVUkpKcFg0b3hhUkMxUWZ0UjNyTWJBY2pvdHVJSC9Y?=
 =?utf-8?B?d1F3QkE0eG1SSHhocXZ5SVl5Uy9pSGJ6ajJvOSthUkJYQytlQVI0Uys0NGFK?=
 =?utf-8?B?ampqZHlSTHFISFhzL0drMFplRUlqK2hqZXdHNUMzWWtjcE91RGhzTEhpdUti?=
 =?utf-8?B?VkhuZXk5YytWT1RkSzVtQ2E2b3Q2OXQ4K3oyeGJNWTFyTzEvUWxHRFJ2NUlE?=
 =?utf-8?B?eURicFB4azNNWk84UmZ3Nm0vd1ZnTlBMcy9Ram9qNnUrNEcrRzNUMmwwblBF?=
 =?utf-8?B?d29HYnpoVlBiTXdtdUpsZy8yT3N3eDRlbjFrMm1yNnVJNkV1N1NERmtURW1I?=
 =?utf-8?B?QVFrWUZNSXY1RWozZElJL1Jwa29KR3hxV0ttalQzRC94QkFPNENlQ3pudlVI?=
 =?utf-8?B?NS9wWmNUbzNKb1F5S1dLUjlvc1Nyb3JySWpNVkJLdE1HSFZ5MGpTUE5kclQ5?=
 =?utf-8?B?RWZjbk9WVVNjRjV4WGF6Zk1ObTU0ZzZ2bmxDTHZBNHM1b3VVc3hsNUhuVW5W?=
 =?utf-8?B?aXJ6STlKcWM4WitTVng4L3M3MDlPNTluaTVabmNKMytlQ3FrblpvZUJlNGVm?=
 =?utf-8?B?TnhjSStGbEk1UTExWGZ2UFQ5TmlQOXdvbWRoRWp5VzlkYkpzWXFwdDl6eUJk?=
 =?utf-8?B?NHpQVlpld2ZUYStveE4wQ29uQzl3TXJaT2RRTVpONXQ3cDZ6T0YzZUw2VEEy?=
 =?utf-8?B?disyYnQ3MHh0RmVEQnlnbGUwZEROWnhsTjZsR1IvUHhvalVHdUJyZkJyMERZ?=
 =?utf-8?B?OUVTWWFlNzNzZjhCYVZiRWZ2Si92UVRYQ0VETWQ1S1REVVlHNUZVSjZPU1hP?=
 =?utf-8?B?bXdQY0R5ajFRSm5panhFcUlrTy9VMUE3dEtoMEhmVXNvQm9Gb3lnQUZYeDZY?=
 =?utf-8?B?OHRvdllkbjFCN3ZQa3pnWTBva3FVSWNJbFVJSWhBLzRlemdPVUJObFVxZEtB?=
 =?utf-8?B?cUFvNk1sTTdvSFV3MHZvVVV4MGZIZ3RVZzdRSlNzalFZL0VDakU4NnF2TjlJ?=
 =?utf-8?B?eVRTYzErRGpnclhlVWYvbnZ1R2pXRUlSendoRmZiTDNXYlFsSmpFRjdyaTFF?=
 =?utf-8?B?TDVxZ1ZQTnNJcnovYzRFWGgxSXVINkhjcWFRN0V0Nlc1MGpqYU1jeUNNUE9S?=
 =?utf-8?B?R1JJWGFIQmt0Zno3NHlHdmZsL3RiZjhaTk9aZktPVjJjUlFHSU00dE9WcElu?=
 =?utf-8?B?c1lwd1FrdzVDdzN5RTErSEU0MUhhWHEvWDgveWxkcURjUThTV3BzenhLMkcv?=
 =?utf-8?B?eDFzTG9WQUZEMExBYmVhTHArUStKazZOMWZ2MzkzWWpyVzhlcUQ1Ym5Xb0Rl?=
 =?utf-8?B?VjdDKzRMVlUwMTdUM1BmWVNBRHBqWTd0SlZaMmFNczg2TER2UkMwczZIK1Br?=
 =?utf-8?B?QittMnV3MUZ4NnQ4cE10c3hsMnFCS244RHNyN21zRkMyWEFKTW1CMVdhL20v?=
 =?utf-8?B?UHFlMHhycnFOMHVqTG13VHRDdi90MTlPc1psbUprTUVhZzh0S1pYTGxuTFVS?=
 =?utf-8?B?a2ZydjJjQ2xnYUloQzN2aTBtZk4rRFNiSi9QODVncXFaVHRkQ2FjZGtIMUVj?=
 =?utf-8?B?RHhvangyRWZQeVM4V2p3QlJoc3JuYWFTclNWL3ZXdVVNQ1BSYWsvdkxRL1Z1?=
 =?utf-8?B?NzArRy94dzVxS25sVnc0K0pjUUU0Q1VIT0UvVi9qQ2d4SG9GQkJoaDdrczB3?=
 =?utf-8?B?dVhKalo0bWozUUdMNGQ0ZGtGWHZEbTF0azN0bXRjT2llTmdnaWcxa0xVTWYy?=
 =?utf-8?B?NHRNVStCMnR3WENMOEc5NUpNbGo2ZGNtQXV2SXMzL1BwTFVWWXRsbStzYlNs?=
 =?utf-8?B?QmU0S0dyWUdLYXFiSGVzN0tLUXRDNnlDZHBmTTQ1cFUvb09yQ1BLZz09?=
X-Exchange-RoutingPolicyChecked:
	BGe40N64r5l1+Q19FMxOayoGXiIiJ/lk2A3CxT8cpfoCyBDfNilff8JhE0xTjoIkTAiWX0sSVCSwfEWqhWoTCMkcVENIXhGFyuQ8PS5lAclg/depSAfryYUg0v7D5gdd7PDCzZk91V2QCIOrNONrfjBd1YWxjg15ZKc4Et+Gl4USPSa02Jnj9ynsT98nPHlxfswFyhL5YsQqLbqQzpm6uILh46A60tjWNN3GnsgsIUAI0sNP09ucxabuJ1VCAybAxewq0ZH+BBv0bSHqdzg7jmxsfmMsvBEgsAi7TFXqjBcucoWL7w2Dc2Rp1Eoo8HjqxZHzxhe8E6GLXON9vhCZVw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3QtU2qWqWp/ZBp+DM0rWuZzYupHwQTehIRDjn5XW9hQ9kMIjXUR6Tdb99bgU+tuvR34nb7I0As6xNsR78aGEQUTUHLncfmFZMUIDdDCYv6XcvNOoLsrhglANlVcJNRfjepKMMf+h3orJ6IX3KP24iQS2a4VB5HHH/zC2fR6upuT70wZyARA75x9L4h1PN59Kc1zYa5Fh/jNK9S+Yab0qYbOoi52p5x2AhePuko8kVWltshkxV80TyiUjuw7F5STWS6gq5H4/DuSPg2Qa5qNMohFHD8gJ3JLqyComehV/Rv0JGqz9f6D13NWAq1u2lUfd8cre38pLvjL81HZ1GW5/1PBN3IUYnRtMrhO7qm9biHnhvwRXOP/N0D6ChWiIb6zoWRpaVXnyY80oRGBdt0vh7OE4HhsdNtu6WNX/cUbFNx92wyE/KjI9axF1HtVG0nTFBd5SHfuEA0TwbEqQfghYxxwUhzjCOvQ0lU5BrdrnEsC6QOvlvdz2H4AmMwRtYh/reEucSnTz0FLUls8zoMisBYtusIELzEIg5xlJKmmXQcpbqdsU7r1Rp5PWC3dYS+CI/9tLtSRZ+6y8vibus49vTdFm52fg/d+SQ47tN62q2YlYSbsg8e+cuTua8On6MUv+
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6ba41c-b779-420b-40ac-08de80d48c00
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 07:45:50.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xRF4V2dJbVkCoUorPD/MLUmzH2Xpsw+NtnRzKMTtiEbNGW2fS4dPkezzItfc2FR8EAbq9n8mfe2JZ7s8JdDDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB2911
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DU0P192MB2911.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: UkVLn6wqcRYNIsHllctX73ikhG46KOzQ
X-Proofpoint-ORIG-GUID: UkVLn6wqcRYNIsHllctX73ikhG46KOzQ
X-Authority-Analysis: v=2.4 cv=MIhtWcZl c=1 sm=1 tr=0 ts=69b3c0af cx=c_pps
 a=orIhxW4DOeZ+bPO+1gm2Ng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=N9GNhs4bAAAA:8 a=VzK9FSCvjmmKcJYUvUoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1OCBTYWx0ZWRfX3hVX1ofwbw4L
 rih/EwpYdlJdHCr+2yxCY7CuzQBQoLHe+YJPyDhJ5chym/uG/xvlaqrKOmwKkv6xURbBgjUED1B
 dqZ0PQnqzhoZDBjvvaH/MXKcw2B5msw1oPEn9uYRAe1U1VHAO9W2uS/gOBboPf97l7lfvQf2rlc
 tSyJEQ2lXIUjC7KElDzy75zssC2mSAaSx9R1fsHKMwLpBV61hXccFPKE1q+ee9e8xNLKF0wISri
 +2bkyEQpgi7epqYOibvvU3SoBUEcneJvtCSbBWPg3tp/jYAXJ3wroqAJ3gb8gTotXFBHXWrMvdM
 VJM4mr+gQgCfHNUP5j8evB0VOQWzTDkIUAXjM0PYjFzNX2t6vM+1y/WPyY/dNJADErmEnGkdxDQ
 FDqfcQWKB1YA9xMy7HlrnNIYgvqIQKP883+Qp7vCvGy0SCqD+pzUXZULNYT7CIvr+xoI3AEn/QC
 jUqqFtCWrIy2Ou3/sgg==
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33193-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8FC6D27EEF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the HE MAC capabilities are printed as u16 values. This causes
each two‑byte pair to be represented differently on big‑endian and
little‑endian platforms. Use u8 values instead to print these capabilities,
just like it is done for the HE PHY capabilities.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util.c b/util.c
index e6d42e5..11f8117 100644
--- a/util.c
+++ b/util.c
@@ -1304,8 +1304,8 @@ static void __print_he_capa(const __u16 *mac_cap,
 	#define PRINT_HE_PHY_CAP_MASK(...) PRINT_HE_CAP_MASK(phy_cap, __VA_ARGS__)
 
 	printf("%s\t\tHE MAC Capabilities (0x", pre);
-	for (i = 0; i < 3; i++)
-		printf("%04x", le16toh(mac_cap[i]));
+	for (i = 0; i < 6; i++)
+		printf("%02x", ((__u8 *)mac_cap)[i]);
 	printf("):\n");
 
 	PRINT_HE_MAC_CAP(0, 0, "+HTC HE Supported");

base-commit: 3dcef44ffd4a16a9eac49bd8016c445b14877294
-- 
2.43.0


