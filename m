Return-Path: <linux-wireless+bounces-19669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B758A4B28F
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 16:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280C7188FD81
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F51DED56;
	Sun,  2 Mar 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="Vumz6p9f";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="cHVOAevT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721142D600;
	Sun,  2 Mar 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740928522; cv=fail; b=bxqWrm4Gz3fvucleyCkLdVvkj0gcrYCjsu+jCvkI4FfZIAMGI1iQA+VCJaPYiBpQc0zvNSLcWR4aUYoJUsndOvq2tXgJQ2lelEBHwMQSXo2i+37WV/mAC9TqYE1dAZDzq02k23xkIKIJU/3lOpp1tYbjeJeC0bbo7YwMyzhgTF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740928522; c=relaxed/simple;
	bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EczGGoxK8b/1LMGaS/O6GuiNkmV/LO4ePKFbDgC6KvUguvc59jxG49xiownIu3lJ4BAGp8XlSm+57VbtWV3CoUkYAkHIBAok+mHJGjcthmvJ5vzTIfGO8s0On1kDsBlCFsJ+LgJvkMqgcCWudwyTydDOHahs3DtgjJoHJCeyoxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=Vumz6p9f; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=cHVOAevT; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522DawgO009523;
	Sun, 2 Mar 2025 08:48:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=; b=Vumz6p9fzLX3
	6vwBi886uu+IPipbNic0Q5+CcwP6JnApT0+85d72wJTtVkaOUd4sdZwIqhbW7neX
	lNdasrJOKSfNhfabtyGtoka/hnzsARZn7Um9CBmPIXyURVrrZ6kCdCBzaRQKxeBZ
	+p6ioSvmwLjFwnCCqDA5ttO3wwB3j/x6EIwq581jZYBUrJPKJyk4X3/cbeANcJaF
	VK4peRlhOU7MrRlf68l5CYuQX8gsE5NvyExu8UWY9sBtMegEdgNnowYeiXIity0D
	ZZeO5KPsXasnI6tb5mHvEJpOVHCfZd8u6K7upe11wVkGfYjvk7bEaG7IigsjgRZT
	/4RUX65TIA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 453yegh96n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 08:48:13 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI/GH+HGz7YPzgLGVDGfWX21k4AnJZe736BPn+owmLMhVyK6DZHr/n09GRULy1UZlrW6XtkHlZ8UoNnc3r1XjIRdom2kAyyB5Zw0b2tsDZ4QMH0etdwsquqtkU2hTtfmbZ2IlKFYU4eEjYX4BA44lOazmtxq9V5w5OMsgccnPbXw2m1Y/9K9pl66JCQFR/VPVB3mMOyGgX6By31s3N892qjHEUDNjEhpg2WBMUpx+AS0uE2aTVuAnMrYgGLJ1xrsj0w55ggC/meE/R51QyT49yU4LE+fQ0/Z4OYmVsg28K+rX4BQFw1PWKuU8q8UIorEQkACLyca2Mpw917S6O0aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=;
 b=vKD1KZX70w8R2erM6+NEenj1xOca54OWTRhlRSrVxreGORj4BLX3jEO6rENvUaynwgoX1jRjgt2uiRPaMcpZQ7hj4GZ6F4cTGuADn4b29ieWMofIf7S6nK+1/C0xXOjaYeGhzCpBYjz2NMgG4LrA7cJF7bRH+VJxFdOE1ZIsPAJnlc5BBS+UnEkxli/H/V0O7+Jyr0LhqKj2AnTVyE+FPBa537PKQGk2i5I0ENIsDZTrY+gkmhrHb5X2X85LdjC9jDf2DtZWiXYhPPI+Nga20T4wTGts4G4IGJ5uNBU32oA7h+2FFAiIaxns1G4+qYSj7fWBNIK3b3b/dbauivhI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT7fJnR9FBvNxhnXKPexZgXG00pWySO9VDitzQd0Ow4=;
 b=cHVOAevTvy+hagBsXV8F8QHA201CSwXMrC4kEpKEl2noPYZWSHEJ1sfVjJ0cjjAG7txtEKWb5NUL1gsK/YV1iM1YSfSBaGdMTcOKWZRupIJz8A/yDP3lczkeiIOYVyK7rAtwt5kOG3EjTxbOjZozWTx20DugLgTpmQvdi/PimpE=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 14:48:10 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:48:09 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v2 1/5] wifi: wfx: align declarations between bus_spi.c and bus_sdio.c
Date: Sun,  2 Mar 2025 15:47:27 +0100
Message-Id: <20250302144731.117409-2-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250302144731.117409-1-jerome.pouiller@silabs.com>
References: <20250302144731.117409-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PA7P264CA0241.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::7) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DS7PR11MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1e3746-eae9-418e-9822-08dd59994017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWgzSm9YcWRVb1d3bE5uUWk3QmlEM091QWp6cVpHRXRkeHdIZkIwSnByZ2Nx?=
 =?utf-8?B?SENvS1VJL2tKZjFlb3RmTnhFZURLMjd3RjdJR2JBdlptRm55bXhFN3RGLzJR?=
 =?utf-8?B?RTBsY0dFS1Bsd3dQbzkrMUxPVUkzVTRRcWE4QmIrNlNPZU1DR0NRT3BuTnFJ?=
 =?utf-8?B?QzkvdDJKVUFVN3VCeGtIUHdWZlFRdHhDblZRbVZMc2RWRC91MWd4YXJXbFdK?=
 =?utf-8?B?QWwxUkNaZlVXVDFDWmpSRkZ2UmJnbU4wZnhwMFlhMzdSdnlZdGtCSzZHM09U?=
 =?utf-8?B?Y3pOcXpyekd3RmMzaVVLYWxia2Y5OHpWeUpDMFlVYldZeitnV0NBZC9kZVAx?=
 =?utf-8?B?SWhrZGl6c0srZVd1aFRIZmZQak1XM3VoZjFjWDlXQitNaG90VDExNGJZMEFa?=
 =?utf-8?B?MFdnQThoL1lCdmhFUEw1ZFlHb3ZEQXRORDFFVXI3cVBKYmdDMXI4TStDamIw?=
 =?utf-8?B?YU1Cbkp2Wk5vQU13NUVPRTUvZ1VobHR0TmZNbG5tOHpzS1IzTVBuYmQzbThY?=
 =?utf-8?B?cUpwTTJjVVVsdVpieS9sTGFhV2MwNFQwUjZPOWdsc0lZNzRLWSt4azd4d3RD?=
 =?utf-8?B?aTU4NUVHVmJRZUUvUDMvNUhWSjI5K3JnNHRpb3FLRjZNQ1dBeFdoYU5mYkI3?=
 =?utf-8?B?YTVnS1I1bHNjSWZSQnlmWXNKQ1JQQlZXcHVMMnA3cHNxZlRGTFRXV2pSdURM?=
 =?utf-8?B?N0g4VHk2MTMxRVkxTFlCVE04ajdXenF1b1V0NHdWUTNWUEhIRnFYNVYyQWcv?=
 =?utf-8?B?Wld2a0g5QnFxc1NDNHdKVEp3NTRkQnc5bjFuZ25kV3U2dnZIUjBUQk5Gc0Y3?=
 =?utf-8?B?L1VxS0VvNllubUtCMDhPUUIrc0ZGZ1Q0Z1U0Tzg5Z3pndlFIcFJxTGVFbllH?=
 =?utf-8?B?UTFYcGZTcHE4eWtxbXZZNHJGK01VNEdLTnI2a0NFa0xwVllqU0s1TDIydW0r?=
 =?utf-8?B?TllrQ0piRzlQRmZMWkRhaUsrS3NOdlhoTW1QVTBORStEV21pZHczUUNjd1ZT?=
 =?utf-8?B?YVNuNjd0RXdRTHJ3Ym1JRU56WUQvS3dnSEhjcERVQncvQjZ3Y1hQRm5RWVcx?=
 =?utf-8?B?WkdUWFJvaUtRa0orTEpqT2N0TkhiamVMZEtVNjZXQTlObGhpanA3T0czV05P?=
 =?utf-8?B?UEFiZUIwYmhBdTE1d1k1c0tCL1VkNVJVRmtkWXVlOU9SSGt2QlVRVmFlRlVZ?=
 =?utf-8?B?dTd0OXpaK0E2d3UzT2hvQVRIaVE0QmhPSVlOL3g5cFpJUHR6c01QYVBod1or?=
 =?utf-8?B?c3V1S0NUbHRjZ2tSdExGY3JLQXFseVd5eSt3Q3NMeVZRNlVObyt4WWNya25r?=
 =?utf-8?B?am9nZzJSVlhhTG5VUlhjUlUrWmRpcnY5WWcyWHlZRFZmL0R0OExrUlo2ZEp4?=
 =?utf-8?B?OUFrdGc4U1RXSjE2TFhiMExCRDRIYVJFOGRIVlRjdVRwYXBOcUpxc0w5blZU?=
 =?utf-8?B?dEh5Y0UyRzZaZHVROE1HMzF0WmYzNnRTZFBZRUR4TzJyMWJ6QW5MZEhHTFhu?=
 =?utf-8?B?cU9yRlp2cXBta3cyUVcxcXhlUkhNaHBkZUZyOHYzeEwrUjR1Z3BzcjVaVmZ2?=
 =?utf-8?B?c1lDQzZUUXpBaTVLSjRleDdoVVJNV0tSUnBnZ1Y4bEVzRjlmTGlZNGVUV2NS?=
 =?utf-8?B?aEUranRKRTQzN1VRdnh6SFFUZ0Y4QXJpWDJmbisyb3dEdk51bXlnY01VRHlD?=
 =?utf-8?B?N2NVQ3o0N2NnVEdTS05qSncxYVJJdXBUQVBHWVpIR0owQ0gvVzRzM1lLanVM?=
 =?utf-8?B?SGc3UGZmckxkdnI2ZDJHQ09zSDUrY2JQYXZ4Z3REUnpyWHdDQVZEdHZOY2xn?=
 =?utf-8?B?RndIZUFRYnUya09Gd1hPZlNpaTV5QkdBMUU5OE1kS280NTFXdUhGUkVKSmtS?=
 =?utf-8?Q?xNStpdF1QY+a4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzJLNEp0dkY2ZnByYjBXa0FpRCt3NHQxT09rSjZXTGF6dExWeFNBdm4vRWsx?=
 =?utf-8?B?Q043WXZPdyt4OWF5NkVpMlg3cnpXcGFnVmtRZjFkYXlTZ3BKWkZabi8xamx2?=
 =?utf-8?B?eFJmM2ZpeWJnRE8ybXd4VGEwQzhaSU05U1Zsc3hxRUVEWElzZmVwL0lxMEJ3?=
 =?utf-8?B?V21CRWpXZFdDcmk4eExxMFgxSTRBdk5jamppcjlsZ1NtWVFSUER4RU52VzNu?=
 =?utf-8?B?N1pycGVUTGNVSFRCQVdBRU1WcnlvZS92Q1Nnd2ZlWlJrZFI1MUZlWE9yeGQy?=
 =?utf-8?B?TDlwRFdtaXpORE8rNWppTmpURHZNWlVpTkdJZlJEVmpZUDFFMk5WSk8xVnVm?=
 =?utf-8?B?a2pmRkJ1bmk0V21yb1JUVThYUDNDR1E1bzM3b2JqTzVOa0Q5MkY2WXgyUFlw?=
 =?utf-8?B?SUxGVWhKTjdUS2RweXRsVmVnQzAvdTdhYjgzNm9wckZoT0dPTDlDSUJRVkxh?=
 =?utf-8?B?VW5pa1p5RlBnTGNGSEEralhmckxJSlFnUUl4NGsvK3Q2d28vVXBiTG4xeUZB?=
 =?utf-8?B?OGk2MHpzMXhGTTQxcHpIMll5OENJVzhTQTdQQklmTHRiWThuMzdoWGFISzZx?=
 =?utf-8?B?azRWR25uV2JTY1p1V3F4R29IUFNFOXpQSEFzSmpNVTUwWURBVm8rcFVEZ3ZW?=
 =?utf-8?B?WlNaSlZTbjN0cllHdGR1OGJaUjZyVHhQdzgzcThGWCs1eXlQbzFxYU5Nc2I1?=
 =?utf-8?B?T3FPckNkV1cvR2t6N2g0K0ZpQnhzWXZicUoxNC9LQ0tlK3l0ZEx3VGljblZX?=
 =?utf-8?B?V251Uzltd2xxTUVlVEZaWlRscTJYNkhScnVJdmUycHN5cDFBUDFYUDlIS2x6?=
 =?utf-8?B?UXZuanpmZkxaV2VSRTQrampCa004ekIvSk1mZ3lIc3E5OWhLWnBPUk1rL0Zr?=
 =?utf-8?B?RjU2ajRWeG8waGQrblFCTFJWUEFVTzhsRmFYZEtKbWV0TlFBSlNOL2N4SUtn?=
 =?utf-8?B?cG9SZTRMcmF4VHdzMWxBOGoxNWxraVg3VGVVMEZoUDhkWnEyVDdUYmxmRHMz?=
 =?utf-8?B?TEtBWjg2d2o1UTMrdWZNWEwrMFcweTZIRDVGSGtOTTdRRWJtQkVCeU8wdDhV?=
 =?utf-8?B?dXkrNmVaYm9Qb0JERkVBRnVyZ2s5NDExUHBaQmNqYjJHYkVob2pVazIvaG5r?=
 =?utf-8?B?Um1Ycmx3a3cvYkpHYmxjQUU0VlFpbTZMUS9YRHFsMXR1TGxiUGZyRGtXU1dK?=
 =?utf-8?B?K1MxRjJmNWUySk5UY0M4ZG1WVHBJRUptTVBBc09xVStCQ1pPVnFDclllL3lG?=
 =?utf-8?B?NUhWRURXU1RWVnBVaUlNaFJmZzFnakZIY0w4WEl4djlvQWpBNWVBcjdReVFH?=
 =?utf-8?B?cXJtZW1lOEhKSHpMSGd4enRpS1JQc1pUZW9jZHNiZk0yS2RQcGdYcTgrQWNo?=
 =?utf-8?B?MHZ5VFltVnpNMGdlZTdVMFgwYjIzQThBeWdnVlpKckh0bnFXbXlLckFkRTFa?=
 =?utf-8?B?ZlZWeXF6N0dCNWlUYkltWWJ2NTZ0czRDSTlOZFZoNi9xbnRBMjNYdEEyTGZs?=
 =?utf-8?B?R2FLeTVidDJKT0YweFZmdkpCek9wYnZZTlZBZENGYmhlSXBiME9kOWFpSEs4?=
 =?utf-8?B?UUxNRUllOUtsZUhveUVFYjBQRWE4K1pUdmFvMFhmMndHdXBVTkVrSnduMzl3?=
 =?utf-8?B?ZDUzTUtNMktmbWR4V21QeklvUnduMFdQR3g4dXVEZmxEdEh2bU1RZ3pneUJ2?=
 =?utf-8?B?WEt5SE9va1ljajA0VmlQM3pZaE9xb0xVZEtLRDJLSXhmajMzbVQ2L3k5Umtn?=
 =?utf-8?B?Y0RHVW1SMVd3SDRWd25CVVEzZFFJN1JSTzZ6dlN5c2ZPMXU2U2hQSlVKUmlY?=
 =?utf-8?B?VlZDeW9tb0ZkT0ZlUnZ5MzBYcU9KbXIwVHlWUzlpRXhXMnBOcWdSMFd3S01Z?=
 =?utf-8?B?TVlMTXNsUks3MW1jazRBME9GVnlKWElVT0RsWk9IRWE0cDB0RGRnWDk2SjNM?=
 =?utf-8?B?WnJxMlNhTTJvZlpjayt4UE5WeTQzbzQyVUNxS0FkYy9zaVl2WUduWmJ1NUxk?=
 =?utf-8?B?cWlmVXJhUW9Bb2RMdjMza1Rnd0hHc0sxR2tncndUbzQ4Zk1iTzJnb1hsK0lx?=
 =?utf-8?B?WHhtcml4U0dwTm9hWU5SUCtMRzhVRG5aMkhvVHNzWXBiVVRCaHo0b0RNMmhq?=
 =?utf-8?B?Mkd2Lzlvc0toaEZsYzN6YjIya2NiaWdpZzN2T2FNcDdpN3BPOUFwMjFFdU8z?=
 =?utf-8?Q?6uFQMpO6oRR2peHyjJqTOQa9jVreqVoOCtfe/Y+FOTKd?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1e3746-eae9-418e-9822-08dd59994017
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:48:09.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q99njI4BHFWnoyA0BOtIDx+rfF//LRHM+r0QQ3+PMdd/kwdBj87bJaNiRk6tZeASpi9skGQZYo1Qo/1g0NOnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-Proofpoint-GUID: n5mI8541ID66aRY8nMnkwcvnMtGlCfi0
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=67c46fad cx=c_pps a=CmjB6Nkc3E8pi8fe8piFzA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=94Nz2Nw6my-I-Yvh_ZUA:9 a=QEXdDO2ut3YA:10 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: n5mI8541ID66aRY8nMnkwcvnMtGlCfi0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_04,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=624 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503020120

SnVzdCBkZWNsYXJlIGZpZWxkcyBpbiB0aGUgc2FtZSBvcmRlciBpbiBidXNfc3BpLmMgYW5kIGJ1
c19zZGlvLmMKClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxs
ZXJAc2lsYWJzLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19z
cGkuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVz
X3NwaS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc3BpLmMKaW5kZXgg
MTYwYjkwMTE0YWFkLi40NjI3OGRjZTdmZmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvYnVzX3NwaS5jCkBAIC0yNzQsMTEgKzI3NCwxMSBAQCBNT0RVTEVfREVWSUNFX1RBQkxF
KG9mLCB3Znhfc3BpX29mX21hdGNoKTsKICNlbmRpZgogCiBzdHJ1Y3Qgc3BpX2RyaXZlciB3Znhf
c3BpX2RyaXZlciA9IHsKKwkuaWRfdGFibGUgPSB3Znhfc3BpX2lkLAorCS5wcm9iZSA9IHdmeF9z
cGlfcHJvYmUsCisJLnJlbW92ZSA9IHdmeF9zcGlfcmVtb3ZlLAogCS5kcml2ZXIgPSB7CiAJCS5u
YW1lID0gIndmeC1zcGkiLAogCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIod2Z4X3Nw
aV9vZl9tYXRjaCksCiAJfSwKLQkuaWRfdGFibGUgPSB3Znhfc3BpX2lkLAotCS5wcm9iZSA9IHdm
eF9zcGlfcHJvYmUsCi0JLnJlbW92ZSA9IHdmeF9zcGlfcmVtb3ZlLAogfTsKLS0gCjIuMzkuNQoK

