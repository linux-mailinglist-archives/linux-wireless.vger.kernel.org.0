Return-Path: <linux-wireless+bounces-38265-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d4KHO0YnQmog1AkAu9opvQ
	(envelope-from <linux-wireless+bounces-38265-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:05:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A11D46D7483
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 10:05:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=c4bfL44n;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=PYCkwikh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38265-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38265-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A760830073F2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3D370D5F;
	Mon, 29 Jun 2026 07:55:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC523BED5C;
	Mon, 29 Jun 2026 07:55:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719722; cv=fail; b=BaB8ZP2dBtb9ajVsctyJSzGi1eZdjY4P8+R6alJlLhLKsvmsFESkPfepFSkTxXHiBVVQ/tIO9Qre77WX/sNJBAdIuSLvak/m/JTdxyuH222eELIILJi6adHAM/pqy8nFZUoq+VD9mN8DyDEDUC7sfmNPCeJZu2uKGyLzzpgxidE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719722; c=relaxed/simple;
	bh=TmRoWKRid5Kxj/ppgbu8u5M5xTUFvu2PYTAJtOeTwgA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=ZlxPZXhP5DBH91OuL1Awhaw30bFrGIDJgBszhgmOW1SFHaQYsBHYoXtOANIrhpSMr8mnD1tsiVBi2WPiOghDe14pwoMyY5YwQIMlyq7wAt3qsL0qSrJL7OIsziAXopylwv2Mh9tTRPCRiDooDT6Jcf32fSES+hfd6A7s1tcte8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=c4bfL44n; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=PYCkwikh; arc=fail smtp.client-ip=185.183.31.45
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6u1YJ1729416;
	Mon, 29 Jun 2026 09:55:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=ieyHzbQD9Vp9GularB+qcG
	1quJHbMo/DANoSoG3ZfuE=; b=c4bfL44njjP/pS/CfrOCtHYeCQXNPGTGXa3mEA
	CiIUVjj13iFteKtYJEhozj95FXWhbjcn/wWSho+7VH4MmsAYK3tqwzX2pCxF7GdF
	zKqLhtDFfwbb3ZF4AKfmQ+4+WB+p3MaiASrma5jJ2T5rhL6+zmoL3E8fS+OkcrPL
	suevw/Ep/VLKQZPKeNRZh2HsMHEBficPByrfT1/InUj2zqHoZofPCloloNqsJXUj
	nAQy+xqtxCquin1cFzH2NNGtIz+G9B+vTHc7gRQlmCleUSK4nMsIDDFPZ1NSdEvi
	TJCMgUz6jZGX7iEPyKN5KmUpYekNBF+PVx1Y6/fjAW88A6ww==
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11021087.outbound.protection.outlook.com [52.101.65.87])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f22h0t883-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 09:55:13 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oc6chM8q5mqrpoQvOVrzcKWUe0cGngaCVM/IVAtbm28xDrgTUplXYFdgwcyEzi+dhRhRQ2CHeqGB3BiDPldgv00H7WBvRu7VrJmQlpQSY3s8K85TvfswtRPclqd4+MWmRy53090Ha2Gb7eoGPBKt3LVcwtojg1dJ14zAkYJngVrPJuy/HPrn5AVhJJtktg9JlXMYex1zsQ/p7kg13mY09UzfrXIGIL8hLkJcuGZLQ1qyfrqmsC0uA4R8/HaKAxn/hEb3+zk99RjNNblFJHKVfNu52JtlihGsoUx8oT92aRkrXRS/aM9Qk2WTxSPdmqm3Oc3DTQpQuxjeKEH2OAuA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieyHzbQD9Vp9GularB+qcG1quJHbMo/DANoSoG3ZfuE=;
 b=cj0Jn2lYPqNV4e9NkZ+1oKM1cz3ss3MMZ0mSg4L/mxtJdHgihEUy/64Sv4lTv2GFjAIu+GqP0S8bVnj5CDYN7ub8x16G61kCkctt5KO8nAx56mlAYGe2A8E4UUzJ8HAQ4z5CDs/NMMf/TkLozYiS/cFeV2/N71HQycPVJhGLZ0V0dyZxrvwoFKhsmzGSXTL+omHs+UkaieGhCCg7L0CJzfA4mCh8UfxAJin8AS6ZeZZXbgVKSDMeVVimtu7q/lUeCehgi/2ImSaLgOjPxynwoaOBbviSZwKd4kW7XHrWHkEXP1vdLY6hdJe7qU6rtlhnUF7oAbPGQtiTNllrzBhwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieyHzbQD9Vp9GularB+qcG1quJHbMo/DANoSoG3ZfuE=;
 b=PYCkwikhMbjxzzKRbcxJckvc3m2ABy0RjLMgDYx0h0SXwPeHm7PHL5lVUmBnLzOvy2WkJsu+7VDWXqhupU9r/q9VkU5OHxWgIBXEeHt6CI/jeeWbYX01Hog+yU5rJYq3/4xBolOxlGVSSIJC5EPXfHv+l3y4uUPILdUpPBnz1jc=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by AM8P192MB0961.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:55:11 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:55:11 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Date: Mon, 29 Jun 2026 09:55:10 +0200
Subject: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
X-B4-Tracking: v=1; b=H4sIAN0kQmoC/42NvQ6CMBSFX4Xc2WtabECdHGR10NEw9OcWOtCSl
 qCE8O42PIHjd07O+VZIFB0luBYrRJpdcsFn4IcCdC99R+hMZihZWbETr9G6Lw5SozQmog7jgsG
 jch2SN056tFwKS1IwfhaQX8ZIebIb3vBsXs3jDm3Oe5emEJddPPO9/dsxc+SoalVpcdGK1fb2o
 TRRHMJRhwHabdt+4EgVH9kAAAA=
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: GVYP280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::19) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|AM8P192MB0961:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9da925-cb50-4239-c566-08ded5b3bf1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	RDHKVWmZV9dJgjy5voa4YWhBTj0pGuWge7Mi5jvJXfftlpF0DX4gTMijEcBC83Vlvmjo6sPC3FyqjdWwuwS6eySUClZbXJ/Oy4VRk76/9nKerf96CXp0M8sOt0ffzSQIfyRAf7kChGYMPbcjLiIiWsFaDeOrUtnnd4PJr1ssbNXsDsev73Fgp5p+hKDlWhdNMJsP+LxY0AX+1DdsrUqqrt5VuideA4aSJxMX/X46NEysqdRGzEOMo15fZyW6R4PGOYssZrqpncFZ4UOw4btzNdXFYPJvwsPEBMtssizil3ZaFCVUtRpT9OMkxupTLZ8ay1nuU9zlt+sOJImvP1lUBUYq1YscguPzu5o5lU0l3E4QVNObdZrzJkLzuRgFAf82ERSy/7mzvIfAxvQt1cmhW7R0YEdk/UVX0Z4O1MWIH/8q5xvByzr5Vv3aRI6vw0VwTumfpK7zIcEYg0U83v0hIwHtZXu5UQ+V4sPiCAOSTsu/O3F5B1WXPk5/4lyefR0oYgHsZu+6Qbm70beBPv8tzujoeuP3ChKma4BytEIscyj+YJjbyv1yOTujlGEA0z6ebJt4mUu5bnGZMVJYTJq/+fm1kqNNKvtwq3DiVNQPYyPczcOS1W6u8bA7RgaUVhO0TV14t0IugrT4iBewE+wHL0tb7GqmJYGox6WQ5Q+qNzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEJRVjk2RkZvOUR6clJkOG11SitDTmw1WmlMQmlud3VrNFkwdkdFRDY5QmRq?=
 =?utf-8?B?WUJ0anUxclU3V01jbjVqSzRVRCsyS2RqcXAzNGQyWjNRTENTVnNnZCtQbnJj?=
 =?utf-8?B?SE9Qd3FNQWdtai8wT3JkK0ZjU2ZFNDF5eTc0cUE2SzUzWFlybG9uNGQ3ZEc0?=
 =?utf-8?B?akk2LzhyQ1B1OHU0ODU5TTNFdUxKZVNaZlhHUWhqR0R5KzlCc1Frbm9CYno5?=
 =?utf-8?B?UEJsdnVmNXorNy9LTExNTk9IZzlwMXBiMG5GNTU5RXV3cVdBUEQ2cW5tWTlP?=
 =?utf-8?B?Y0d2TkJUOHlwNis4N1lYeDVpWHVraUJBVkF0eE5xRllGejJGVnc3V1I4a2Mz?=
 =?utf-8?B?WFhHaStselhHMTJHTkVCYTVmNU1vb011WCtlUE9aTEtPc09NMGYrYk9IUXBX?=
 =?utf-8?B?ZEFTK1pXL0tnamM1czZDZFMrU2Q5Sm9ERGwwby9NOXEvaWJ1V043bllyekVK?=
 =?utf-8?B?YmEvQTdOczFVWWJPdVZEK2VrUk55dnRCbWd0ak1idUN2ZURlY1VXYytJMU1n?=
 =?utf-8?B?dnFadHowTnYxUXc1Y05mUHZNV0Qxb2RFeW9mOGx2TDZEMy9vL25kYWNSWmtt?=
 =?utf-8?B?eUhEUVgzbStPKzVjU2wxaUJaSHlOUWh1WlRNUHRMNWFpamoxdW12c2lPTUVS?=
 =?utf-8?B?dGJVRlZSeCtSWVYzclhnbkpPaDY3YnVUaU5LVi9iSWc2OVdyWGVkUi9OcUJN?=
 =?utf-8?B?ajdBRHI0dEZMTE9jbGZqcTFNaVI3anA5NEdoZmhhVE9hWXpma1pJSlhGQ00z?=
 =?utf-8?B?bUNPcjlaMGhNa0IxekdnMnl6czJVakVXa0QxQm5Oa25HREw4OU13bE9uNHk5?=
 =?utf-8?B?TzlCRU5IVVhlL0lFb3QweHVqUlZWaUJqRFZNRVVWUnlnSHVmUXQvVUlUNVE5?=
 =?utf-8?B?empxQU5CZE1wZVR6MHhaa0FseTBZZ2xZUyt4NzloNENpYlNUWk5rZXdlR1cr?=
 =?utf-8?B?ZkJ1RVR3WDRpZ2RMOG9GQWJOcFRVOTlOc2NoSTdwZ005aFMwK3NpakszMVdT?=
 =?utf-8?B?NTVxY2ozaWUrcndMdWRrTDVaTTBLQ21UR2QxT01ETVNOQmFQM3pLUTNhVDBo?=
 =?utf-8?B?WXUwMFpqaUJSWjlvT2V5VUoyTmtzWkI4YWtGSzN5TmNjNTZRK3BvMVowaDNn?=
 =?utf-8?B?N0JFQk1xNTRHRFNoVUpBb2R2MXFIN2kyWVQ1dzg5dHlhUlJqWW5heDlWTDJY?=
 =?utf-8?B?azVueW5tckVQS3MvRFhqYlJTZmlocWNwcHVPNHBXQXdTM1NjRFVSYVJoTmpV?=
 =?utf-8?B?OXR2WTdadFRKVDlkZHk1QjVrTnEwblNvdzdpcFZ5d0ljb1BJYmNRMVdiempS?=
 =?utf-8?B?SU1LQ3c0aU5YSlc2cThuN1A2WkVPeUh5RHhpWC9OaG9VUjRLOUM4SDllQndy?=
 =?utf-8?B?NG91QWFaMTFuVEtDWnhtUjNWeEk1eUFKSkZJVVY1WUh1OEZmTGtEdklrZERD?=
 =?utf-8?B?VVhsMXpIYUVQSVZKbTEyeFhOVzVmYnllT3NCK0VialdsS3VHUWg5VFpEY0pw?=
 =?utf-8?B?WWZCaUJxeHpHRlV1MWlYa2hiRlgvcmVIWExaZHYxd3cwWlVlRUJuNkF5S1JM?=
 =?utf-8?B?N2N0cmJlcm4wbnFMa1lVeWdSU3JER21zTEU3SjBkZS9MMXpidkwwTTlmR1d6?=
 =?utf-8?B?WjJ5VjBzaldWZHkyVnF1NTVnYUhLZTVUVTEwVTBpRm9QWmZsaVVTQ0M2R01M?=
 =?utf-8?B?cndvVnhmK3ExUEpLSmY0UDlsYXBTQTlkcHdYK1R0bWRGM1c0Z1VWc1pzM1Nm?=
 =?utf-8?B?UVJwVUtwZXZ2TlNQa1VqRXlSUEJUamtLV0NYdFZkeXphNkk0WFZqOWJQVmNv?=
 =?utf-8?B?bXFISGRrTGwvWFBOdUhMSmhKT0tOVkdveHl0c2QwKzBzWG5RT2ZJNGhZRTB4?=
 =?utf-8?B?amRmMUJ4R1BXckl2dUQwT3NPOGNwUGxBWDlVNFdTRkt2WGljcUIyaS9oYWVD?=
 =?utf-8?B?TUY0VXRxS25WaVRaY2poT1Y1YkFoQUI3UHRZYzZkeldDSVVNQ1pFcU1kRkE0?=
 =?utf-8?B?c1E0dUlLbys4LzVtUTdodmswOUlMaHZwVWxuSDZBeTFFK3hYZzhGdnkveFAv?=
 =?utf-8?B?alNoVXdyN0FxaHV1aFJ2TGZlRTg1R0h0VitYaXE1ekQxRFdmd25hUWVqSlNR?=
 =?utf-8?B?cm5GY2FhcWRkSU5VK2hhaFZySmFhNHJjWnBaSGp1YmR4dWsvcXZ3Y3lNcXJL?=
 =?utf-8?B?dlRxeWhFR1V4dkZGZi9BZHo0VHhCTXNpV3NOUEJESXpSVm9PY2ZMcVpQU0VF?=
 =?utf-8?B?amE1WlNlUXZnSXhZMUpGZDM3QmwwM1lPNWN4OVMrcklPb0UrMmcrejdiYTUw?=
 =?utf-8?B?MStlMjY1OUQvK0MyL3EvNk93NE1ac243d1hPWmZMUjF6R0pSQkRmZz09?=
X-Exchange-RoutingPolicyChecked:
	rLqhqu1osG5SAYpjlCeun6/hHgfkLy+drD1RwQo5a6EPQxztQheTqsfDe7bNz/G7RbaYrYSqMfWWKoabNtM14KO+Sq3p4co34N4nyPUN3fjnnPXNz5fkM6iUmpBJ4ynwL3RiWfBNjBliWA8812UFvOtfJsJWCVYbxUycTSNQaZ3P9zg1YGG0HYWTGcRF9sSqG+N4Kb6j3Oq1glRHkuh0Dn/d15OuP0SKeWIIM2nFfDkES63tqKPTBPSe0gRcbRCr38eogSW/UNyXJXgFr2awkOXIipbFrLAJmbUH8XiaOP6pn6o9GHgCyuETQ1Cm8ThN32vBhMuqj+IUvItfA4bW3A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dZmYrlNVgG7ZJHZHG1P2Tu68OXOsMj4Ys506S8aF6IfqqwBdlM6CU8Rn1LCY1Bc6seJn25ZQUsdK7sACmJ4UAFQL3bScjDDnUuipvjtI3OZ1oD4Yz3eyD78YV0K45f+CpuxGepRgaY0HFC36cIeoG5xAVeOnOrLTjggQNfvqIHnGhqLw61qldMH2riemOHYi9CO0JxKVKm2ad9t3+B7IWEaEBYOqAvr6C5VTR2qSPoqwkWZejV0G6AxyeekGADFOIaSPi3bMMH/S4za+yW0I+ynm+UCeNxlFn6i0DUUpX9nJr5N6lSUtg+fhN4178VfRcA214ZpYyfLWh/901w6VCXkvkt5kX9/LjYTT4GmdVwo1R9ETWhMOLbu4+MFiVBRJHzQ/26MzbOqcCKy/NqeABR9w7DjcBhYZ/vQ0z08rXY5lDcYbTPeiBrVmIfBUF94NKl6W4rM9veoVjqGhI0xwAOO5PtE7l3YeYgqtyU/WOsezgnNQu/GevolIv/nxXZ8AGYQUoClhU2G7ZVUlzaYyjBZG13IIjJ++HyNybBhatxCZR6venjtu8Yvjh1C7eKfZPw1nGIfyXcSc4I6VqaTfAUwQM+JU0lkVlqXeuQEFgiPKcD9RnyZWaEhLyKdNfs1s
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9da925-cb50-4239-c566-08ded5b3bf1f
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:55:11.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeWedmF6mQehRlCx9GaUhgSqtD9JwTgVc1s/L8ttbHHfFK7z0D9HGVJdkcSmUSdWAURs31qmcV5Ux9TaeJ5sbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0961
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
X-OrganizationHeadersPreserved: AM8P192MB0961.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: 7Y353yq2vo_yxOfibf8njHD3PfTBx0LM
X-Authority-Analysis: v=2.4 cv=bcRbluPB c=1 sm=1 tr=0 ts=6a4224e1 cx=c_pps
 a=OncqJTBqDIk3bkOWU5w5NA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=N9GNhs4bAAAA:8 a=F4jRbKuxnH_zUiGVJR0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX37w/8teMR3uC
 x6QU9WB7qxVfOvcaCEUM34Q3FJ9E3gtkugoz9GU6Lr1f7xx0yeJDgZpYOWR86ummjKPz0iIputz
 6mbQ7sdf/R9mDMreL9UEP0goYQtdHM0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX+ta9VZ3RqBkA
 4HFR5+ya/weVuyDcL1XGPrWNspYf2PTkiyvKMFJwgpuLQBCiuYEQAgZMKuD4Qr9hgmzl2sVw6IS
 2S16ngSOLj9esn/SwCbhNoBzpEqPDhnxUtHXhVfhXQYGsKMUjPvED8DJrwlMwnoLEP2D8miJofa
 Apb7eRRsNSUoyQ9gQ3McUodHKdacPvNFQ964f00dmo+at0U27z2UGjHpRvdYw5nLWCpxgri/S26
 I5vKsp+5xb/npxQ8Huk1vlCPPVa1/cR55nxvcqZGufjnU6QNkYhtj/nJ/X2Q+3jEB179CDuKmvZ
 XX/g+rhpbqrG63NhU+bQaJoHFIInakbQWJWukTvibjY9nHGGUKhuyPR3NDgnCRaCuYSSmAVqdFU
 zF+n6iZlRd/aZxUXWBApiw+Y4F85t7zTwIZewXRKlPIIi5eEkooExbk5rqMWO5tu1U+0O1QL2E/
 6Ecv3EGshsMIwekgQsQ==
X-Proofpoint-ORIG-GUID: 7Y353yq2vo_yxOfibf8njHD3PfTBx0LM
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38265-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:alexander.wilhelm@westermo.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,westermo.com:dkim,westermo.com:email,westermo.com:mid,westermo.com:from_mime,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A11D46D7483

The ath12k_dp_get_mac_addr function performs a simple memcpy from a
CPU-native data types into an u8 array. On a big-endian architecture, this
later results in a null‑pointer dereference. Convert the data to
little‑endian first, then copy it into the target array.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/dp.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index f8cfc7bb29dd..50957915dbf4 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -647,8 +647,11 @@ int ath12k_dp_arch_rx_tid_delete_handler(struct ath12k_dp *dp,
 
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 {
-	memcpy(addr, &addr_l32, 4);
-	memcpy(addr + 4, &addr_h16, ETH_ALEN - 4);
+	__le32 le_addr_l32 = cpu_to_le32(addr_l32);
+	__le16 le_addr_h16 = cpu_to_le16(addr_h16);
+
+	memcpy(addr, &le_addr_l32, 4);
+	memcpy(addr + 4, &le_addr_h16, ETH_ALEN - 4);
 }
 
 static inline struct ath12k_dp *

---
base-commit: 702847e8cfd51856836a282db2073defd7cfd80c
change-id: 20260317-fix-mac-addr-copy-on-big-endian-f1a4fea40184

Best regards,
-- 
Alexander Wilhelm <alexander.wilhelm@westermo.com>


