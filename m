Return-Path: <linux-wireless+bounces-19665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B937A4B285
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 16:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B4D16AF69
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC61E522;
	Sun,  2 Mar 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="YpUp9t3p";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="FacZRWFP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC1EEEC8;
	Sun,  2 Mar 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740927966; cv=fail; b=PhvVLietQxpVfaUunRjm2oIa1QftvgpbXKk3Ruct6FJgxA67jeOeGTFf/pTfLvSKtI9wAd4WDZFqCCWR2vj6VORzGCjDyByXtJYDwvt1UmlWTMAyh5P+kOnIq8b/KO01PSMuLD5FB9jB/Ub+MfiVqqnoPaZGl09t+Aaky4huopc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740927966; c=relaxed/simple;
	bh=mGDVwJ6XyqNwXA1CMoyo4Ur45INoV/fvuRnly0t+dPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JPU5XGhmVlAgCxbglaPo6uMmSy8ly2SBcJwA4T9VeOJsMfpxM3RbVQLUp39ouIrHLJD+WcflHAHAdzD0bDeSyo0apXsW18CUcprmgViP0SdYbaXLOxG8XeTyXVJ1PyRCC2k57HbvWEDhPAEeRhzKZjruCk8pWUcg46Of1cYhEbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=YpUp9t3p; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=FacZRWFP; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522EItXY010648;
	Sun, 2 Mar 2025 08:48:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=mGDVwJ6XyqNwXA1CMoyo4Ur45INoV/fvuRnly0t+dPI=; b=YpUp9t3p2neH
	a9guoJ9A1HvXqjYZzDlejc4Gnru1j6qR3xZo+iqo+9byc0PsT1plhW+CsjlNuuB2
	/0YEwtB+b+P6a7Kau70lu/QQVAajS51ggfVBR5hEOpHgedWPIRqw22DydWhFvjbE
	NnpF2MMa79UOag7lKpXe7TQwbHWOm/qEUibnzuGyXVLVKUvte8rcio6rhvGO1APg
	/+J4mRR+UINSGb9UoIcPgpDW2Y6alLIkfMhYwLW5EE5UYP4YH/qGyzgSG5sb6LFQ
	spnCf0S6uNxokt3a0dDdxf4LhUEMcUZilVz9HwUlS3tvb8dvFphPndTh04sRiHHX
	f0rnY/ntGg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 453yegh96p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 08:48:15 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSQwIQUQeXxzW7m9pFMWxiyqDQNPA6myoADe55ocDitUEC6yKBNFQY3SQxNEuCcpd0F2vmHXrrBw8EpXUbAX7FEVBdiC8Z3xV/8tz/PtMgCNTqcc+t47CODGznCzQA61u720yUbhQZNATTI9p3CpOl5M6CPU62Ka+Q/X1PglXx+2rNEvIzzAPPMDRmiX3fqE0H08VJ8m/1fVXzhSvI1DKs8B59B/LZ8pyqqwpuhsrRaG8kbNbDlFOJvkSAePim/z162espPVJ0OJO5SeNj3O8W8lifsIFgLIPLkp+HXWd1n6NmxvSKNjmr67dIKsDMz0ICMJAMYpU27Ik+qHJv+KWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGDVwJ6XyqNwXA1CMoyo4Ur45INoV/fvuRnly0t+dPI=;
 b=N3Vqu2Csrcbr983yarTalouEGcmWglNmfmAeN3C+927ZuNR4QY+cJZbRqUg7uUo/MW4N5rPxaarlCNg3UwciW5c+zuIDXJgzuOOztfSu794I93szZKg3ByYeZD1LlpUEMEWAOEvVGIz+JaqeS1SIbnV1n8IxdvdUTJCgkUNqtugT9Nd6mHVAk4rnnQY8RpQTs5vd6APuhnY6aTcUFN635zBDX2gSjj5n0Yp8fCgu6CgLT0lyJhBfnF0LUVbBVq4R2gIVdHz8rkGTQhtjAF59FTlZGp/zS7Hu5SMyhBl8HyL/GuKGV7dpUcYx8EykVLFUKoWlSHZ7A87JVlvgPFadDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGDVwJ6XyqNwXA1CMoyo4Ur45INoV/fvuRnly0t+dPI=;
 b=FacZRWFPTyZUb2gH4XQSJmE4UxaAX+7h43dtVRY6Q1GiQzh3gKhJ7/Yu271xQVR9f6bwPxhGXc4xZaWQP6rHR/Q/pFyJIH8rl/AHWUnMsByD1jHBcq8lM3JWHrPf+fxUR5iHb+7YEZmMiUlhyLObI9qOeWEb/hCZg9tUOFU5ZeI=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DM4PR11MB5312.namprd11.prod.outlook.com (2603:10b6:5:393::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Sun, 2 Mar
 2025 14:48:12 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:48:11 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v2 3/5] wifi: wfx: allow SPI device to wake up the host
Date: Sun,  2 Mar 2025 15:47:29 +0100
Message-Id: <20250302144731.117409-4-jerome.pouiller@silabs.com>
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DM4PR11MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b1c49b-4e64-452d-bf93-08dd5999415d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFQzekxuOC8rRW5OOGZpamNPcis2WmFqSkxTVy9lUDI3bXVnZ1lkZVY5ZkMy?=
 =?utf-8?B?Z29CalA1VXQxb3FUL0g2YVpiWWpUMHFkckdaTnIzM2Q3TTZRV2JManhFdzQx?=
 =?utf-8?B?MjcvKzNjNng4a0xReGcvMjFrVnFZKzlqaklXNEZJeGx6TmF0aWRYUUw0NmZP?=
 =?utf-8?B?RC8xMzFBeWUxUVRXK0liOVpKczFZTUVQM2dtUmtOMEx4UDMySzU3SS9wSmVh?=
 =?utf-8?B?L2J6bkNuZDVPd2RNQ3Nod3hlSk9rOW5pWGlDWTBHSFRPVjl0R1U4TklFMnJQ?=
 =?utf-8?B?QzRMelpHZ1FFTFdEQ2tEZGtrbWFLRlNxZmhXTFpiendkd1hDOTdNZmNnOTVZ?=
 =?utf-8?B?SWJrc2k0SXB4anZ1SDFNZjJPRlVpcUdBY3ZGb2xUc3hmUG9mZnY5cDhzaWRw?=
 =?utf-8?B?d2ZnQnpuRk1OK2JkOXRMWnE4ZEhHalJCcXorSDNWcmtEMUVBVzZUNTl0UExU?=
 =?utf-8?B?MHZwa25UQUl2b3lMbE82Y2VrMFZDWTdMQ1ZzbG9wdGt3cmdxcmhEK3YyUmcz?=
 =?utf-8?B?ZDRWRlRhQ1lQY0h2UEdITFNQK084QWlwdWx4T3A2aVZDU0dsMGh5SzRXRWNo?=
 =?utf-8?B?SW5Qc2tMUGZMTmV1NDYwWUVWR2N5Lzcrc1VLNFZ1V3VEalJRMkVWUWtta2pz?=
 =?utf-8?B?bExYOHVvNUs4dHFKeEwrWkxXV2xOclZMZ0ZkUVhWT2tvbXk2engzYnEvemh2?=
 =?utf-8?B?cUFESVIyKyt0UE9TMmZwV1VtdVpzUzFDaU5lSXROWVRtbDhvSU0ycnZzNnNq?=
 =?utf-8?B?NGpTSklzMTBzQjZVY0pRVHNXem9VeVc5elN6MlpBVzFkdFUzQzROUjh0cHNp?=
 =?utf-8?B?Qkp0VVM4YzJGbnZCYVZxSGp3SW41NmFvNkRZbm8zM05NRUtBdi8wY1pxaTM2?=
 =?utf-8?B?V1ByVFJWcyttU1o2SE4wQzhBdVVzTjhtRUhHQWozT3IwejBsQ1BSbkVGV2pp?=
 =?utf-8?B?NWpTN2s3YkUyR2hjTENyTmtKVkY2M3haV1ZNcmRqSkxuZGRaKzRCbHoxMnh6?=
 =?utf-8?B?QTNTRURUM0R6aXZiYXpTR0hoZVhtYzBvc3BJaWtJM1YwTWdMRGFiWmRLME1J?=
 =?utf-8?B?ZHEwVU9peG1FaW1lWXJqWVVRV216Qk93ak1rWVRQU1QzMFFKOGpaWFoxVEZV?=
 =?utf-8?B?K0pwSkxvdkFqL3Urb1VCVS9KakFtS2N4NUtRTVBJVDJCckRMK2FweGNqd1B5?=
 =?utf-8?B?Mlo5WEluYlE0Yjc3dEloMGJDY1ZUekZ1Q1ZsYm5SYjI1aHo2Qnp2a3VrdFJW?=
 =?utf-8?B?RUpJMGFFVDRHMGhRdlc2ZzlOd1JIVGVZYnZSbHZ1WXYrWmNVYzl3SVNxZ0pj?=
 =?utf-8?B?dFNSQTRQTys1UTFIcktVemVHWFNaRGVpTlBON3BLUDRIQllSL3NOckdNVHZs?=
 =?utf-8?B?aThqemUvNWF0bk4zY2c0SnBDUkRaY3ZndCsvelVUQk9raUcwR2IzdlAraU9T?=
 =?utf-8?B?cFkzbjlhVkgxUldQNDhPWDZtRWpCUzAzQkxlT25TdmV0a1Z0RERSd2EzRG4w?=
 =?utf-8?B?dmN2OFNJVzN3TURzRXNsekc0WVVUQ2o1dTlCZGp4aUNJdGljYmorUk04WlZk?=
 =?utf-8?B?U3ArSHN5N2tZTUpCa0JNTHBFeFpLZU9yblJXOVBYUm5uY1R2elN6a2VwSWhR?=
 =?utf-8?B?VHdMT2kzSmNldnFiYnRGRURCM2ROUGx3c3hXdkt4TmppK05hRHpMV0RzRmkz?=
 =?utf-8?B?Z3V0RTc4UUVac3VFQm9hR2FiUXdFbkVwa2FaVW1zTUhqNXJGYy9vM2xGSVFm?=
 =?utf-8?B?c0ExaG5nMFpTUTc1aGwvZlVEaTgrRklZMlZGQnRKMlloWmlZT1cwMmVpMDFv?=
 =?utf-8?B?NllISVkzWnY5dTFNWWU3VEwrOVFsSUVwcjRtMGNOczdrOWtxdlpxVWNwRkI4?=
 =?utf-8?Q?gDILnNv2vzoe+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFJ6MGcwa2FXTUdVNmhrelJvT3ZIMFpGeURQQVJJWHBvMEVxZWNyTjJqV3Jw?=
 =?utf-8?B?YjVZVUxNcmdiTWFQVUcyMEt2ZzNNT1dRdmVmT1FkNGY3KzRBakZINFV0NDBk?=
 =?utf-8?B?RjJaL2RrbE92Ymtjdm1aTDZuU1VrT2hkYkFuTFNOMmhQMjVjSS9RbG4yYlpR?=
 =?utf-8?B?V2ZydXRhdktoanM3ZjYxN0J0eFFnM2RQRForbTh5M1oremgyTXhWQlRTcXlU?=
 =?utf-8?B?Zy9MNFoyR2lTSGxTM2dhV3JKQ0ltSWRGNFVjeWJXZmcxWTFZQVlLNEZaemZC?=
 =?utf-8?B?ZTVlQ0gzTUc5OFN0YnNUa2FKRElXcVJYa0l4THA1SFcxU2d4MVlQUHMyT0pJ?=
 =?utf-8?B?OFMvVUc1OUJ2SVpDaWJBalU2Tit6bENMbDB3ejI5NE5zZzRIMERmbzdscnVo?=
 =?utf-8?B?ZEVwTHZKT1lnUWhWbnVISUxkd0hyTzFSM21OdHBZbitQZTAyZGh4VW1URjd0?=
 =?utf-8?B?ZWhlYVpPclUrQ2pLNzdaWjNHOGhKNUxqNmxpNGpEYWgzMFBlTVZGOTU3c1JK?=
 =?utf-8?B?OEZ0UmdLbk92UDI1NmlzR240MHZDTHpqTisvREdFZS9vL3IyQjkrWTNURFJT?=
 =?utf-8?B?eXA5czVXbUQrelB3TUlDeU9PS0dQTVlxU1pnVTJMMGNBTk9rR0pnRzhrOWtG?=
 =?utf-8?B?Q1dCZ0NPK3pZejhBdExYckdHWmZwNGpqUEprVHNOVGNwSTNFYXZGc1JOMlpW?=
 =?utf-8?B?aTFMZkliejVPVm1lczdCSFpUN2dsc29LNFlsZGJ0VFJ1TzdsWkRMcHNNZmdB?=
 =?utf-8?B?RXpibmYvQ2VIWWxxREFXQlUrVzcwZDFCZm5PMm44eGJLV2RMbDJVdnh1VlBE?=
 =?utf-8?B?Vm1hbU5yNUNBdFl0UnBGWFFUY3VFQTlIaTNPNktQWVdaOTc5N1lhNDFwSFJo?=
 =?utf-8?B?eTEzQzRBYUYzdXhBY0lqWjBHNDVjRHR6N2J0aXJWR2tzVDU5Vzl0RVBjbVBI?=
 =?utf-8?B?MnRpZ3ozVmh6SFdwbjZiQVh6UDVid3lkOXlRTU9JV2RPT1U2bWRTN3NveUtE?=
 =?utf-8?B?Mm1TUHhEc21OY3lhVFhpT1J6L3JlMUNpNC9hV0t3QmhUY0ovOS9QV2l1NUJS?=
 =?utf-8?B?a2VoWWZaVmtnWEFHZ1ZFamhySjJMWEFNVERKYWVrMmE1Y2FNZXhFYjNTaExR?=
 =?utf-8?B?cGRGbU1OcTYxRDd3UzZNcG5ra24zZGRFYitZbXQ4M1FjRy9Gc2VRd25BYWdV?=
 =?utf-8?B?MGdURm9Mc2JkN05PUHo4L2FjWVpoWlAraWNqZ0FZWGZmeW9HVGM5M3lwSjdJ?=
 =?utf-8?B?bXNYdGVrNGtrT2daYU1CQWM0UUFYWGJkRWE2SzNmUVczVUs4VCtUOWdjTGlT?=
 =?utf-8?B?L3krZ21PcE5BbC9kN3ZVWWtWbExwL2M0L1VldC92bzhBd2cxZktGQjJpdHhQ?=
 =?utf-8?B?WE1PWVFGRUcwdUUyRUVuVlYveVozOHhZUFlVNHBjbXJrTjEyZ2hDL3lqMGIv?=
 =?utf-8?B?Ukt3OHN2SlJRT0RNa2hQQkJnUnk2V21qak45bitRTDV1Mm9hZ3l1aW5Wb1B1?=
 =?utf-8?B?ZmlrUmFNUGtUZmRJNmgrdk1odGJ2clFkZm55RzhGL05sbnJoeGRVZlhDYmJy?=
 =?utf-8?B?aERRcndMbjVwYkNFRzcxMDdjTWh1WFNtckl5eXVpcUxFbFlYNkNmR29EL0h0?=
 =?utf-8?B?Um5YZVc0THcxakxya0RPQkpZeTFmaTZKMDFXSlErODJRSTZvWDNWTnpkMHBY?=
 =?utf-8?B?MkZBQ1NzM21sVmYzZWJrV1lkanVzbVBGNzF0T0I4OW1WZjRSN21TWjIwbmc5?=
 =?utf-8?B?cXJXckpVMU1qdjdMUnc0OHVtbVl5WG93L0NNOE9vVHpiU29IUTM1VEhHZERF?=
 =?utf-8?B?WmRWZlpmOXdDcTd0WW50REllSG56SDdKRittcjMyOWJsZjRHMzZ6UjJoZFdk?=
 =?utf-8?B?Y0tMaTJ4VEtDbkJ2ZWdNZkpSbW1vTThOblNjeHNZaTRzYVFwaTloOCtJRDVJ?=
 =?utf-8?B?anVXZzRmdmRyU3JCbWhjbEpWdTdBSEZ6OXFXbXVHV2ZlUGRsKzhsWFBqUHIr?=
 =?utf-8?B?b0Y4NjZvU2NBMy9Cb091NmthbXFzc0gvSEtCdUhxOUNpTEJ3alpQYVVJRkVH?=
 =?utf-8?B?T0FDckltTjg1U25pbS9MMlY0L1J4UjA3bXZXK3NpdmxzS3Nia2o0VkI5bUI4?=
 =?utf-8?B?MHJLNGF3aC85WUJHamxOMVZCeGFoUFg1WFc5cGhJc0d3UE1DT3pGa1NLcnMz?=
 =?utf-8?Q?tLRPWoMF1GtlIbz5AQTtbWOKCuAy4F28GxB3h9YX32n+?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b1c49b-4e64-452d-bf93-08dd5999415d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:48:11.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV410Dm+j73tG/KqszDHwxeHKHRyg8hQ+QJaN4twkgj5u/xSztvCcymJroRK8sE9EE+pRFDETSX1kUXqp4ZRJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5312
X-Proofpoint-GUID: Z6r_Q_qsXa9OeHT_rXABiVbC_hChzU68
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=67c46faf cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=y8Il-FFEXRI_uRj3CQYA:9 a=QEXdDO2ut3YA:10 a=SRgmj7pJOxBPWxSGtsjD:22 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: Z6r_Q_qsXa9OeHT_rXABiVbC_hChzU68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_04,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=874 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503020120

V2hlbiB0aGUgaG9zdCBpcyBhc2xlZXAsIHRoZSBkZXZpY2UgaGFzIHdha2UgdXAgdGhlIGhvc3Qg
dXNpbmcgdGhlCnVzdWFsIFNQSSBJUlEuCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxl
ciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
c2lsYWJzL3dmeC9idXNfc3BpLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxl
IGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCmluZGV4IDQ2Mjc4ZGNlN2ZmYy4uMWQ2YmYzNTI1
ZjRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGku
YworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYwpAQCAtMTMs
NiArMTMsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgogI2luY2x1ZGUgPGxpbnV4
L2lycS5oPgogI2luY2x1ZGUgPGxpbnV4L29mLmg+CisjaW5jbHVkZSA8bGludXgvcG0uaD4KIAog
I2luY2x1ZGUgImJ1cy5oIgogI2luY2x1ZGUgIndmeC5oIgpAQCAtMTg5LDYgKzE5MCwyNiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHdmeF9od2J1c19vcHMgd2Z4X3NwaV9od2J1c19vcHMgPSB7CiAJ
LmFsaWduX3NpemUgICAgICA9IHdmeF9zcGlfYWxpZ25fc2l6ZSwKIH07CiAKK3N0YXRpYyBpbnQg
d2Z4X3NwaV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3Qgc3BpX2Rldmlj
ZSAqZnVuYyA9IHRvX3NwaV9kZXZpY2UoZGV2KTsKKwlzdHJ1Y3Qgd2Z4X3NwaV9wcml2ICpidXMg
PSBzcGlfZ2V0X2RydmRhdGEoZnVuYyk7CisKKwlpZiAoIWRldmljZV9tYXlfd2FrZXVwKGRldikp
CisJCXJldHVybiAwOworCWZsdXNoX3dvcmsoJmJ1cy0+Y29yZS0+aGlmLmJoKTsKKwlyZXR1cm4g
ZW5hYmxlX2lycV93YWtlKGZ1bmMtPmlycSk7Cit9CisKK3N0YXRpYyBpbnQgd2Z4X3NwaV9yZXN1
bWUoc3RydWN0IGRldmljZSAqZGV2KQoreworCXN0cnVjdCBzcGlfZGV2aWNlICpmdW5jID0gdG9f
c3BpX2RldmljZShkZXYpOworCisJaWYgKCFkZXZpY2VfbWF5X3dha2V1cChkZXYpKQorCQlyZXR1
cm4gMDsKKwlyZXR1cm4gZGlzYWJsZV9pcnFfd2FrZShmdW5jLT5pcnEpOworfQorCiBzdGF0aWMg
aW50IHdmeF9zcGlfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCiB7CiAJc3RydWN0IHdm
eF9wbGF0Zm9ybV9kYXRhICpwZGF0YTsKQEAgLTIzOSw3ICsyNjAsMTIgQEAgc3RhdGljIGludCB3
Znhfc3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpmdW5jKQogCWlmICghYnVzLT5jb3JlKQog
CQlyZXR1cm4gLUVJTzsKIAotCXJldHVybiB3ZnhfcHJvYmUoYnVzLT5jb3JlKTsKKwlyZXQgPSB3
ZnhfcHJvYmUoYnVzLT5jb3JlKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJZGV2aWNl
X3NldF93YWtldXBfY2FwYWJsZSgmZnVuYy0+ZGV2LCB0cnVlKTsKKwlyZXR1cm4gMDsKIH0KIAog
c3RhdGljIHZvaWQgd2Z4X3NwaV9yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCkBAIC0y
NzMsNiArMjk5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgd2Z4X3NwaV9v
Zl9tYXRjaFtdID0gewogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgd2Z4X3NwaV9vZl9tYXRjaCk7
CiAjZW5kaWYKIAorREVGSU5FX1NJTVBMRV9ERVZfUE1fT1BTKHdmeF9zcGlfcG1fb3BzLCB3Znhf
c3BpX3N1c3BlbmQsIHdmeF9zcGlfcmVzdW1lKTsKKwogc3RydWN0IHNwaV9kcml2ZXIgd2Z4X3Nw
aV9kcml2ZXIgPSB7CiAJLmlkX3RhYmxlID0gd2Z4X3NwaV9pZCwKIAkucHJvYmUgPSB3Znhfc3Bp
X3Byb2JlLApAQCAtMjgwLDUgKzMwOCw2IEBAIHN0cnVjdCBzcGlfZHJpdmVyIHdmeF9zcGlfZHJp
dmVyID0gewogCS5kcml2ZXIgPSB7CiAJCS5uYW1lID0gIndmeC1zcGkiLAogCQkub2ZfbWF0Y2hf
dGFibGUgPSBvZl9tYXRjaF9wdHIod2Z4X3NwaV9vZl9tYXRjaCksCisJCS5wbSA9ICZ3Znhfc3Bp
X3BtX29wcywKIAl9LAogfTsKLS0gCjIuMzkuNQoK

