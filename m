Return-Path: <linux-wireless+bounces-29057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D9C65ABB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 19:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35DEA342D0E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E62FE575;
	Mon, 17 Nov 2025 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N140kNft"
X-Original-To: linux-wireless@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D82C1596;
	Mon, 17 Nov 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763402973; cv=fail; b=BMY0jrnnf2617DGMde0B8qG7O06C7ZzqG0hVpvaGQx8yFviy7TH7rctiNymoQYlToJTTosw/oh+b0/X2mtxNj02AkoFR3vYrOguP+Ugw8A3JNL072RF/TRukj8Rf6ErdT7KnjPbLTm7IgnGYOITlt6jJcQc4U41RmcR+oS2g+/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763402973; c=relaxed/simple;
	bh=YMplBRnwV33KMFor3Zh+GDPRwI3DHihmrh+1k0X6/R4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CYLZ5BXz28uLIbPl45sl11o6/Psw59/CMWFBwqFJXFI1rStWTZDBJkMYwd0wgL8cWUzCq3fKpLI5+EhrIFfWxP/pBIyLBoaE00jHjTrZdLVBSbifUsucWoO5hyy/sNSG9JpFOwZcQB3c0FTOFP1ckLy7QB23ktWGabVO+hSNfnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N140kNft; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQAfGJAz6njEw+/qgvumUfeohtCdSxvUpRCEFD0aH+QuqCbYWkGqxE14BNPrliq9C2j4nPogtg3xoG99dUCU7vJIhonbZYq28CT6gcOJok8W6kXk7yJhktqlpCMkanACblGCi06BjyfqddK6tEgtJJmPc5VbybWyCTCEt0gefZJBeb+Pj7M5aXFgFsPzcUl1EIuIbTbFsatkKaWX43w35E6HBJ4uljRwYbpL0hBtKmkhBJhPJ1vmwlPbLc8HJ3tj+BlyXLqGuNHIhCGYeGanumH8t56Z2oxB9wyMsDX4+J1Z66ZiPXxjJ54xkzl1ZvwobBjQLddmn8FVMgcNLJ1gVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Jl+U6uRtWPvR/kAAgkkKvKmT716k9/YBKRRGW1Odso=;
 b=qiXxcTTSXu1J3uVHAGL19dip6L/jSxJdDVxQDVEQ9EJydT7N5Sksa4Ai9I3aooqeMmvJpLga6p3RoadZ7rpESPX638MYoLYgG3UsOUo/+Mh0hdet96x1BN1Mr+8Cg/YPW+7Qp744YyemoiwLWcUKJ2hhGqAusC3EdKDokTBKiVQgcBB4TbxPv87xJLAm9CI0/oWvQW4rN/vYIZdg6PGDHE+N784HT9FgCvyJVdEVDGO1+8Wx26p1gXTL7d/OPyKWtpO6mffDz6DTILviebQN7uRkNlgUdyILXttYzmhaVG/Y4gee45F+B5njSINrR1ksfymT39eHe9tnYJLv49bIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Jl+U6uRtWPvR/kAAgkkKvKmT716k9/YBKRRGW1Odso=;
 b=N140kNft5inckQPk5qspzkZiEfXpCXHllBmwpa7thXpagUEt6qNkde9ytzq33beVcl7nwpk/7ltz16SqtD3VX+s2O0n67uXhz+IlrMZTLJD1NcS9Ad2Hvs9grOhzbJgG2/83CA59z44mO/RAVJFj89/UpfbyOMlPt7uLH8TdCHy1JXrpOU2dUtSnbxrUPBKFFAo6bQlOa2Jd+B6YCy2SPyPtB4F+hSrMF1jcn5M5J/9yWhJPh7EDa6xGb+x1lB9EhuiWebis1OmTTQgl8Y/T+EATZ5U4wld2+lDORUYecB4UQbAeRrHlIzgEg4uX6e2nBeKrWPE1VDWjD52opjL4hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by PA4PR04MB9639.eurprd04.prod.outlook.com (2603:10a6:102:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 18:09:27 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 18:09:27 +0000
From: jeff.chen_1@nxp.com
Date: Tue, 18 Nov 2025 02:08:34 +0800
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v6 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Message-ID: <aRtkooxPeRYTiuJL@nxpwireless-Inspiron-14-Plus-7440>
References: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
 <4eaa11d66e9b788d9824c5b8ab1f1618791b53f3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4eaa11d66e9b788d9824c5b8ab1f1618791b53f3.camel@sipsolutions.net>
eFrom: Jeff Chen <jeff.chen_1@nxp.com>
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|PA4PR04MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: dc981df7-c51c-4033-39ee-08de2604725f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTdiajNOSmFBajdRdG9Yand6Vll5SzNVMUdGMHQyaVdvVVd5QlhsRWhSOExl?=
 =?utf-8?B?YjNSZE5zeTZ6a0kzcmYyS1pnZkYwbE9pRzV2YW1PdkRYVi9QcWFqNXh5cm56?=
 =?utf-8?B?WEdJc0dLdk5POHlDbVM4MjUxV25mN1poSVlJM0krR3NqeEU2Ung0cGJYVXlS?=
 =?utf-8?B?cWFXTzZDL2ppY0FUMmlNMTlwVGdyUE1HM2E5WGxUWVBkTjQrd3Jvek1OYUta?=
 =?utf-8?B?MWlEd2poLzVkNTJWYlF4dTJNcDhiLytrTWRYVlJ6UDFLNkFWRVJqMFh1eXN1?=
 =?utf-8?B?YjZWVFBmbzlMaXFCbmZUNVYxMmh4dDhDOXdLdFkzNE9mMGExY2Q5ejMvWS93?=
 =?utf-8?B?RFlQdmdBc1prd2g0MmhOMjVCa1FNaXFHOEV6MFZONEt2L2ZMYTVYcjNZYlVD?=
 =?utf-8?B?SXFGdUY3WTFqUzg4c3JaVjZIMUxzVWZ4SkYrbVJqWXNDUzl6TUtMeDdjbkFr?=
 =?utf-8?B?NUxhUHdUV3ZxT2J4dTZ1T2RQdkNXaHRhUWFLcE1XR3p5dEZTUTFuRDV1S1Ay?=
 =?utf-8?B?WUE1bzJKem13L1FMbFo4dDlpcGVCMmZoZ2c5QU5LbklTWnNFT2Q2Tm5yZGk5?=
 =?utf-8?B?VjNVblhOUStJRDQzck9xWjBqUEQ3WUJ1U1pBTVZoN05MYWNtZXg1OVBxSEpB?=
 =?utf-8?B?Nnpud0VPTjZDMVRHcnlsY1dzOW1LYmFsWUNCTUVHNnNpWVhYdndwOWN5MktL?=
 =?utf-8?B?UW5DSGhsc2Z6YnZMQzhBMWxsalQ4ek5NVnJndDJySm1LYm56V3crR2tieWRZ?=
 =?utf-8?B?ZVlDMEFoZFBFZXhaQ0Jpd01xbDRXa3V0dFRadE1QclNFNlRPclpXa3NGK2Nw?=
 =?utf-8?B?aWsrWDViSmFsc2ZsV0JoRzBlU1hCSm5hUytVdFRJc0QyZ1EvUzFKOXBRTnlQ?=
 =?utf-8?B?dGhQNDdobWdka1VyNUpBa1VKUEdoWUNweHQxSk1oMmtDZWlDZ3JKZU1oZElH?=
 =?utf-8?B?WDdEcXArYTFCeURUWnJzMjVobmFjclFod2lrRjBJUFZlbkxBMkpUbW1iRFFa?=
 =?utf-8?B?UTh6WWxSbnhKekhYRCtMZ1ZDM0JvSkczZjBHTThObXhTYUNsdFpneGRPV2Vm?=
 =?utf-8?B?WHVJc3JQSGlpdlU3N2dqYWlLMTUrSWM0U3FzUVZHWjVJR2VTWkxkVE1OMzZ5?=
 =?utf-8?B?aGZYSE50eDFRN2ZRL0dyTzBMV3gybE9XanZVenphaENyTzFwVG1VOTA1VFlY?=
 =?utf-8?B?VWpwbUtjSHVmRy9qOW9Jd1NleTFORDZ0T3lFR1hSM01FdWFRaFpYS0dkQmR2?=
 =?utf-8?B?WVgreC9GTERrQUwzUW5yeUFhSzJ6SmltdDk0am5NSCtHZTdjN0U5MExDS21y?=
 =?utf-8?B?OW5yclJGaW0xYmxveCtIS0plNjFQWkVFKzZ4VG8rSFFnb2pFUjJzWG9vYmVH?=
 =?utf-8?B?NnAza2NsSTBrcFZZNU80RHBlb0MvclIrb2diblo5WGN1S0xMNnRGTS9NcCtw?=
 =?utf-8?B?TjZjeUxwYlMxUGhNQnliSzgrbUg4ME4vRFRuWTdBbDZQOUVocVh5UEhVSWFy?=
 =?utf-8?B?dmhIQ1h1aW81dFVrSEFJMDVjd0RDTndtODlvZEo2RC9FNHdyRkZCTGYwZWFK?=
 =?utf-8?B?T2lwdTBCZW5ERU92aWFJWS95d1NmR3N4NEtmUytYeVZjNUJ0U3BLTm1iTWZv?=
 =?utf-8?B?YlczR0tHSFNQU2lVbzA5UnBIc2hPWVIvTGNLRjVqMUNwL3VqbzZlc080QkF5?=
 =?utf-8?B?bUQ3VzUrRUI0VW9DQnlNWnVCUUNqd3pZM25tWXprbitJL2lOV05zR01wY3Er?=
 =?utf-8?B?NDYyQzA5a1cvcGVqS3dIVEN4YU5SM1c0bzIvSUlQNXNLZERKQ2JsQkYzMWxK?=
 =?utf-8?B?NmE0STc5SWxKWmNsRnNBMEZkZ1FHeEdlYUJEd0EvN3BHN1JKRkVTN3VMaHd1?=
 =?utf-8?B?eHhUVlAveUFhM3FKL0hyblZaUVlEampnTzAxOE5IdXoxa3Q3Nlc5U1A3WlBG?=
 =?utf-8?B?UmtkRTIvNmRnSHhMVTRzbEZBZHRqSnRXU3pJRTh1c2FiQ3A1dTlkOFBDQzJH?=
 =?utf-8?B?SS9NMHZ4NUxhNDV6N1picldUWkl5SmtrRGd5a2tody9QdGFubm9rbHBjY3lY?=
 =?utf-8?Q?ro8LWs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzBqL1VtOE1tSCtuclJ1azdBamNNOGlYZVR0YWtmSEhwb1dDODdjdjlqSHJL?=
 =?utf-8?B?cmFDOThSczF4SXczaVJhYVJ4ZmVDbHJOL2VkTDE1cmR3RmpmeGwvV0pHYnh4?=
 =?utf-8?B?TG9tSEtKVEVVMnAvZlhiN0syNEo2WjNOYVJad1ZGUmF1TVpPUlNBc2lMSzdV?=
 =?utf-8?B?ODFGRjI5Q0x3N3RGQ09LMnNEbEVyTTdIWUV3dE45RU9GWDBDOWpoSExXZjhr?=
 =?utf-8?B?SnB0WjVrK0pWbHVTVXEvQW1LekJXN3UrUFpVTjFSRThJaFpGMVlQcThtN054?=
 =?utf-8?B?cVRlanlCSTBmdFlNWGhsbEJOQlFvbUIzSzhYcUFzM2thR1BZSDh4ZVdPSk5E?=
 =?utf-8?B?RHY3SHcxOWRMdytLb09VbC9ZSlRIanY5cUdtK29WZzl0OGFLbVBidE83aE5F?=
 =?utf-8?B?MVBYNUE2TlZmREZLbWFndDBJTGhKQ09JZTBrR3hmZ0FDT3pXME5LZzhlZFdJ?=
 =?utf-8?B?VDNJRzFqeGFsN2VmdWJjNTFCY2JVSkh2dmRQUlJlK1RvOEp0M0xWdjNRV3RB?=
 =?utf-8?B?cERGUEJkcFd0VzdNR2F2cm0veHNydHVhdG5VWGR3dUVOTVhkQ1FhSzRJalNH?=
 =?utf-8?B?NndyUFR3cG44allRZjVlcGdHbVNHYnI2SldCQTlPV2Y1Z2FKNkhKNm85SE84?=
 =?utf-8?B?SXN4d2FuQ28yNEcxUHQ0c1FwS24yb0ZDOXdGdlBSdTUxNnc5cjFiTXphMVZj?=
 =?utf-8?B?anQwQ1lwNWFVd2llMSthNndUcXE3NitOdHM0b0RMUlc3WmhqY1ZTNlY5dG9H?=
 =?utf-8?B?VkxaZllMOCsxVUI2NVBaM2g3TFRScVJSTG5HN2hJYjVxa2FBN2kwU2o5ejZ2?=
 =?utf-8?B?bmVXOCs1RFJMNlY1akRhUkh3bVkyUDUxcGJTMDZpdkZQUGJFeU95WkxJWm9v?=
 =?utf-8?B?Q3IxZnNEWHNrVWhqTlVkMVpLR25sdEVxdFZNcGNqbW9UZWM1RERFZm0zOTFi?=
 =?utf-8?B?cTVtNG9qOHJlbytvTmMyN0hxVHlnU0Uxa1p3a3grQ2dBaHYyQ0tUSTZYWEZy?=
 =?utf-8?B?dmRtZnVQSGUwdnEyamxOTmk4bjU3ajFvMlJKdXZJVWo2UUFFM1l6c2xGQ1Rt?=
 =?utf-8?B?ajZ2OVQ0a0hscFBiaHNraktOWU0rODMyYWlCUlUwamNTUWpudTlRalR5dFd3?=
 =?utf-8?B?dHBiQVkvdDZ3SHkxemtvN1BySVVZZVQ1bGo5ZlNScU9va2JLM1lMNFlRRmcv?=
 =?utf-8?B?NlJNU1RJMVVZZ1BlamMwa2dZQWhoTnB1YkxKRmcrQXBMSXZxekFHVHExUnhO?=
 =?utf-8?B?bEpnc3EwRVFXd0tETG1LQjNWRkJxTG5RWnhlSHV3VFJreExwanU4R2crU2o4?=
 =?utf-8?B?bGtJUjljMU0zYkk2QXR6OWRMSmhvYzJzMU1GZlhQdFh4blFYbHBwRnpCRkk4?=
 =?utf-8?B?MmE0KzUrdEVXdDF2T2gyZE4weU9oZDBsVmNOYmp6aTg1NmpCUXI5ZnNoV0lv?=
 =?utf-8?B?ZGZyVk0wdDJhY0lac1BaMDVndXFSNnRJUVJPTWV1Smt1NCtYYmhsenNXakUr?=
 =?utf-8?B?QXNBdmxiaE9reGdBOGt6VGhVa09HTzMvRWE1RnkrWVlDcFdHcEgvbzBNMjVu?=
 =?utf-8?B?S2xUTHV6UjFGVFVPOC9yY2gwNkRsbG8vVDZDZVNZNWVkV1E4eFpvcjRXR1Nt?=
 =?utf-8?B?QUNKb01ob1F6TXpqNGlRRm5CeW5XQ2xvSk9UOUhSNzFvZ2c3b0loeXQybEhB?=
 =?utf-8?B?MjY4bjkwUy9nY3lTb01NejZCUlhIYWZkd0toYnBpT0NiWkRoZ0hWWkk0RUhz?=
 =?utf-8?B?L0hlaXBvazlZK0wzRmhMMWg3TjRZajVZVXprUzR0c1dxS2l1Wll2RVZFOEta?=
 =?utf-8?B?d1JpeVNGdnpkeDdsdi9SZXJDRnBXdXhuamQwUjdZM09namQveUdyQ3Z2Rmto?=
 =?utf-8?B?UG1PV0lSQW04SFZnZTZGYkdMdUZ5WGRkeWZyTDk1N2I3UGhMbzhidTFFd3dq?=
 =?utf-8?B?SWg5M1h5MTI3RHI2ckhDT0lNVDZWd3ArdHlQQkJJQU1FejNaZ0FXRm43cmRQ?=
 =?utf-8?B?d3N2MTJ4Ynlub1pmMjhoMkNGTGJHeExOc0Fhb1BXNm5EZWVwaFZLeFIxbm85?=
 =?utf-8?B?b2xOUy9DZ3ZHaEltMlBxMWYwVEVFdjNzRUpHQnozQk9SdFlNYVMxdDNjZDhE?=
 =?utf-8?Q?8XiGn8JOZ9Dd9x8uwOUuh+ekw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc981df7-c51c-4033-39ee-08de2604725f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 18:09:27.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTB4bdvNEf2PcIWYo/7QvOD1MrRko5yN6BW5hWzsvzrab/lhYgJ+crySNF+Ss3SvdWbylFwMnrYWDIwMuwtG2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9639

On Tue, Nov 11, 2025 at 11:37:57 AM +0100, Johannes Berg wrote:
> Hi,
> 
> So ... I thought I was just going to pick this up now (removing the
> 'inline' in patch 4 that shouldn't be there according to the bot), but
> ... it doesn't build (cleanly) for me.
> 
> First:
> 
>   CC [M]  drivers/net/wireless/nxp/nxpwifi/util.o
> drivers/net/wireless/nxp/nxpwifi/util.c: In function ‘nxpwifi_rxpdinfo_to_radiotapinfo’:
> drivers/net/wireless/nxp/nxpwifi/util.c:648:12: error: variable ‘ext_rate_info’ set but not used [-Werror=unused-but-set-variable]
>   648 |         u8 ext_rate_info = 0;
>       |            ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> 
> Fixing that, I not only get a LOT of sparse warnings such as
> 
>   CHECK   drivers/net/wireless/nxp/nxpwifi/util.c
> drivers/net/wireless/nxp/nxpwifi/util.c:654:40: warning: restricted __le32 degrades to integer
> drivers/net/wireless/nxp/nxpwifi/util.c:655:38: warning: restricted __le32 degrades to integer
> 
> but also a bunch of sparse _errors_ such as:
> 
>   CHECK   drivers/net/wireless/nxp/nxpwifi/cfg80211.c
> drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1043:17: error: typename in expression
> drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1043:24: error: Expected ; at end of statement
> drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1043:24: error: got const
> drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1043:17: error: undefined identifier 'static'
> drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1058:32: error: undefined identifier 'legacy_rates'
> drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1058:32: error: undefined identifier 'legacy_rates'
> drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1059:40: error: undefined identifier 'legacy_rates'
> 
> 
> Can you please take a look at that?
> 
> johannes
> 

Hi Johannes,

Resending to the list for visibility.

Thanks for checking. I’ve already posted v7, which fixes the build issues and addresses the Sparse warnings you mentioned, along with several other related fixes.

Please let me know if you still see any problems with v7.

Jeff

