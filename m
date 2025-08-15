Return-Path: <linux-wireless+bounces-26404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B3DB27FAF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE1C3A9E1B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A07327FD44;
	Fri, 15 Aug 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="NyV2Vvr3";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="M2Of3CH7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580591F1513;
	Fri, 15 Aug 2025 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259517; cv=fail; b=OJ3SobAYYjlmaHkazHiy8efjxMurV/ufQDr3lBzX7sKaTzhzEm4wZWrkPVngtp4wZOxrbkvNptd9tvutiRCdJ3Kf+ZUo6cNdXs2iD8cV4MAZknicCLEFpFEciXwVStZgO4p7gxzTRIPomHY4XlbxHxCdebfCPtEGLe+KH4n2yNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259517; c=relaxed/simple;
	bh=heeq3WX7EszElDv+9eBqJ8s3zNPTFCiYBvtrXRd0eRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RS/vvGv/Elv0EfcZqlCKHrnM11mruRv6Qhf0BO1RkWL0yfkeXwlbmfPQU/90PSHdVeGESfwi2SHZwbGVtl1jYSk4HJZnNoJDb3dGVX/tOnLq80n6smBEojmEtkjlECA8LUlCoaG7q/UMTOKceLJNaRgF8WmOVvQiHQ4EM7f3Fp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=NyV2Vvr3; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=M2Of3CH7; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57F5slE72735284;
	Fri, 15 Aug 2025 14:05:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	heeq3WX7EszElDv+9eBqJ8s3zNPTFCiYBvtrXRd0eRk=; b=NyV2Vvr3PUklv3Mi
	qFR9NsFAwtockP+JuwjBIMRqA9JHW6hpf7BRX9qFpti1l3us0ZHs8z2gk62eKJsi
	hucI12W83HdgE1ocdRDujiyEMoSd3YONwG0Ak7XT2U3oyvpSUcTQOzUhcIsZmDHw
	fRYdIC4Css/oEEaWrbBvya4PNNjzUgDKAEnUhBdEz6WNtAWw9lvyDVk+j2pjz4aS
	fWKasxphrufzGovMON/Zgxj7Sm5lj0nnQclleAbX713qoIjucbgAJoFyQ0IFBYT8
	ikhyoCPkzcnNOV0t/Uozt4FDoHGlenJft3PdTcZCgjPKKwo6jPuLpxXRCcVM1M2p
	xeSEkQ==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05on2114.outbound.protection.outlook.com [40.107.20.114])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48hhu3gtug-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 14:05:05 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXZYaEwMycRr6+SGpl8n7grrzeXwwbc3BL9tj/Tmx3dFvnH9Mjaf/NyiNBs4/rU3zlXHLlTgqWslXbtBHR2UL6aOq6MlkjAtzNracmj1griEm0JbdJ/pYyqDmTBf+8E5w6jiaWyN05IhrpnjIxkT5GobEIcZeGLxVttXfvJL2bDBv24pbCSVQHQ7yvMUaw2u1vkADpYwdCo8Y81TjiQ+Db/zERoIAarvkfyt9ETH+XkpbZnRJfGtz+ykMxTE/ra+GXKsvyX96GOTPPhDzVDUDyMQDbPMVWoR2IwtBBtMXQb1YleYBvt5gpFufrZ7won6QieAPDiGZhg/fRX4WyrZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heeq3WX7EszElDv+9eBqJ8s3zNPTFCiYBvtrXRd0eRk=;
 b=YsTEGrFg1JWTNsCX+cTBQrAxVY+LgqyZnV8Ny1W4bCXZJ66cyjXAqZvWAvKn5D1bQ76/K0Ir5rk+htHZAhNmxtXVPKRVkpcimizjx4nCziIyEd6eXNOLFWp8UecyKVvcEVdG426OriVTQWI3AkdlJhH+vWCfBDY3ec5m0o0hJ6GhFMX/t+ecXIk4HIY3vbpQUkyc9863Du50iv1g0batHNOaME3mRDT0RPnUcEknP0TxkNW3kvLUUYvOnpcPrFivEiAmNO89gR5Ph9bfhjVb4rIEQAXhXMaJ5Z26uL0OgIFD3ichzgELry/DFmou01SuJJDTp1upn8H+qd8KkO82wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heeq3WX7EszElDv+9eBqJ8s3zNPTFCiYBvtrXRd0eRk=;
 b=M2Of3CH7DhLYJu6cANT2L7xMKQPL4O5Rcj+x3V6a8eK3pNHKPy+9xbgvADTWtuNoCHnO8ldyEtojrZ5Kj8Fl7gLDXu3ACykIv69zTKHF0SnWdXCXAJCjgpXkPdf9fFE1ZD27myuGGN5anEUume47Rj8v/hGta6A53lju8+ENWx8=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AM7P192MB0658.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:176::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 12:00:03 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 12:00:03 +0000
Date: Fri, 15 Aug 2025 14:00:00 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath12k: REO status on PPC does not work
Message-ID: <aJ8hQKnlboOLFSkh@FUE-ALEWI-WINX>
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
 <573c76a8-c2a0-4b9c-b5a8-762b8d094b81@dd-wrt.com>
 <aJ8LYj+NGaX8cwge@FUE-ALEWI-WINX>
 <5ce28473-0fab-4fbe-9668-0042ff7d86c4@dd-wrt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ce28473-0fab-4fbe-9668-0042ff7d86c4@dd-wrt.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV2PEPF000045C2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::449) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AM7P192MB0658:EE_
X-MS-Office365-Filtering-Correlation-Id: 36db9ccb-9444-4846-8524-08dddbf344a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWFXWGtVZGNXdW5XNVVxY0dIb0RZaE9hQUphQXg4VmJUcWx6U1J6NzN1QjJm?=
 =?utf-8?B?RytqblAzM2txWElpVGUzNDJhWkplZk95dzkvR1hWdWdUd0dYYTBib05kNDNI?=
 =?utf-8?B?c2owOUlGTXZSeGZSbC96ME5RWEdBZzFmRlNWdld6UEgra29vZU1Dcnc4T1FD?=
 =?utf-8?B?SUtaOFAybndOY3RUaHFUTUJLd084K2dDcHgrUkZJYnNadWhBaFdKdkI1dW94?=
 =?utf-8?B?OStLNFg1Sm5ZYTFRQXdmN3dKNEhVb3FlVXZmdnpkVFpFRUljYVB3YkNtY1Zu?=
 =?utf-8?B?MGQ1UlduTG5jTmJZcm1jMENsMWFXSVVxOGJDNlVCVCtpdmJQNHpQUEVUelNx?=
 =?utf-8?B?ekYxMGIvTHdkMWxKbWdGNnBOc0tDakJNV1ByOFJXVElVblN4ZTRrbmpTSDZ2?=
 =?utf-8?B?QVdYTjZQSDB2TkpWQ242elRiakNJRm9HNHpFS2lDWDh2Y2JaRVVMaDMweTBx?=
 =?utf-8?B?THZMOGx5VlAxL2NTcVBFdmh4emdHWTZoK2tPQnZXUEtOK2dQYXhMZVo5emJT?=
 =?utf-8?B?RnRZUjFDVUpKUmJ6d1h1Mk8yUFVZQkc3K3lFb21sOFgvWStOSVJxWTFGSlZw?=
 =?utf-8?B?TjVSSXFnL1Y3S1UybEpjNUFMLy96VFp5TDgwNk9sK2RDOHVkdlRXaWRaMkN0?=
 =?utf-8?B?ekdHRFdqSENLbjE4dVNHaUxwMDh6a3BlRlkzNmZwdGM1eUdFZG9UT2VVTnda?=
 =?utf-8?B?bmJlOW1tVXZzZDEydlNMUHdva0xZVDd0YnNGUjFTblMvaHVhejZZTStnclo3?=
 =?utf-8?B?TmZtRFVqSTVLbjdLdXF1Qy83RWNRNjNYQzdnM3JHN1NlUEhjenl3SXpSOWNt?=
 =?utf-8?B?cjJhUVZRUi9WUnhyUVJCdEJTVTU3b1VXLzVlakptV3hmbFBlVTllcWJ0ZWI4?=
 =?utf-8?B?aUN3Z2xSaWdkb0pnNzlCWnN1L0M4MXp5SFVNRnRPRzErVUh0bHRBNmQrenFa?=
 =?utf-8?B?VkwxemNiRFpxMTNESTExbjRrd2dNK2dTK0pHdURHNU8ybHdYUnlsY1V5SkJr?=
 =?utf-8?B?RSs2SnBpNEV0Z3hMNEs5K0YyR21NS2FEWG82U1hkbWs1RHd5ejhNWFU4UThM?=
 =?utf-8?B?NVkwQkt1Z2ZMemJvMzVrVnFKaGVEZjVsZ0NZcHRyZEk1bXZ6V01seCtsa0pS?=
 =?utf-8?B?VEQ3Y2tkTEh6SEJuYlBzZmdDSUZySGZ6dEoyYlNIVjYva1ZPM3Zzc01wWnM5?=
 =?utf-8?B?MWFpN3NBS1BIV3hhc2ZBbVdrWE53RG1sdG85WGd3dW93eVJ0Tml4Ykp5U2sx?=
 =?utf-8?B?ZktQeWJTRmU5RnVJeWVRKy9IQSs2Wmo2aEljRFY2dlNFNTRaeERPM2FjMUkr?=
 =?utf-8?B?TUhIYWFhLzFlR3ZGVmM3Q1pTOW1XUlJTeWZUVGRMbXFib0czaUZMenJQYStF?=
 =?utf-8?B?aTU2R2htOHNOTWlkdnBtRUdXWkhDc0xZSDVaWDFLWjNxMGYrOURkRjFFNnNZ?=
 =?utf-8?B?Q21OS2l4RWM0dFNzL1Y2WXBHRzRJeWR4VVNnQmdVdDYvUnFKNmVEZUdTOGhW?=
 =?utf-8?B?U212MzVHQ3JoamxQOUh1UFFWSytsaEVUM29Jby80TFR3OEl0bkJzb0pkbnRJ?=
 =?utf-8?B?Zy9GNGpTczlrSXJoSEhsS1dhTlVqczZWdjVVNVMrYXlDVHVTWW5NcnFBWi9k?=
 =?utf-8?B?Sms0TmorY3FhVnB3Vys1V1ovMU5IOVB1NituUm9JSktDYnpBdWhjeVRVbE5v?=
 =?utf-8?B?Q2YySXA3V0xZZkFIdlhBOEFjY0pPeGFEbWVDQzdWZE9FMmUvSUxuVHg4TTBx?=
 =?utf-8?B?Y1JqWUIvalJzd2tGRHp4VzRCc0ZQUFUyeUVBakloQ3ZLRllVRWNwMzJqWmo4?=
 =?utf-8?B?Y2pXRm9uS2NrMFFXLzJhNHNGZzhWVU96UmhGYlFaaUJOZktQRS9hOHJaTEI1?=
 =?utf-8?B?TnczMTEzQ1JnMy9QclNmT3NSTG9LaHNrYkpIWUc4Zm9tbm83eUozY0oxT1Va?=
 =?utf-8?Q?h3tnBb2Hv3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1ZaTGZLbHMrdW41dXcyZWViUkVvYWNxL0NYMWIwTW1YaDVwMHk0ME9ZTlBS?=
 =?utf-8?B?S2Vrbmw0T2QwYndwQVRSTGpTanM5Z1lkbkJ0T01SdDlpbzV6QUFYWk9SQUpo?=
 =?utf-8?B?NVlEYmtCS2QzL3d4WXJvN3N2L1ZuaGc2cDN5MVpCSXpDYUx4Q1VrZmFNdGx1?=
 =?utf-8?B?SE1KK2dZTXVtMEpJWHFPZ21wQ1dubC8wZjA4ZVYvSXg1ei9YQWFybDZKbEZW?=
 =?utf-8?B?QXpUL3FBU05Zem5KMXpEZlUveHNLeElxZG52VnpoakRmWlo0cXRJamZiSnA5?=
 =?utf-8?B?SnNZaE43K2RoYzczeGxrTkduZy9FTDN4NEthTmNjM0NMWEQyZG1HK04yWTJR?=
 =?utf-8?B?SHBzWm95aEIra0EwL3dNc0FIdkhQYnBoL1Z4eVlaRDZzK0cva1NUWmcvVmtt?=
 =?utf-8?B?UUkvZ0hqK0N6Q3FuZ3FrOXJEeFFoRlRwbnVHNzAyc0w3MW9IRjhzYTlWclBv?=
 =?utf-8?B?eEh1V2dCRXdleXFVdDVlZThFeW1mdlorK2xOUkxTNDRvV0lNbDhkKy9oZ2Iv?=
 =?utf-8?B?OHBqRUdTbmhOdk14WGhDekd1UU8xQVh1ekxQU2lsREhVM3hmV3ZqS0tDRXhi?=
 =?utf-8?B?SkZETW1sb1FBY2xGUGUzamFiZUs1VWZuQnBIeGdQbVpuQ0cyZzByczJRUWNl?=
 =?utf-8?B?TS9Ra0Rldi9GMWUzV1Mvb21TZXIwcVhUTjhzV2Rnd3R1Q2VXaDVoQ3luNktY?=
 =?utf-8?B?anhURVJjTmZZVXpjRUV1enh1V0FaK2dVaWVwYnMzSE8zcE5QSm9hZHhidG5l?=
 =?utf-8?B?bTVwV1loOEdFZjNUYkU2ME5RbjZja0dNVHgybXlrV2dpR3pvNzJvRDc3Z2tZ?=
 =?utf-8?B?WDBybWNJR0FDaEVMeEg1Wmg5TnlnTzFYZEQvbXkra0YzOHFFU1dpbjVSM0Mv?=
 =?utf-8?B?U0lKMWUyT2FRTHFPVnhvRDlDNUVzeVVwNHRiYnNjRlNqVW82Vmt6V3VFeCtz?=
 =?utf-8?B?NGRxZStmcW1IRVVHSW1pNzRZVUM0cHgrOFZ0eXJZVGMzZHNkb0QveStsRXk4?=
 =?utf-8?B?MWhsQjNydjdtZnJCalY3eUp1RlJLRStGR0dNVnhOYkE2MW14azlPQ2tEVThD?=
 =?utf-8?B?eHI1VjlzK3Y4c0VtWCtMVDlXcFBOVGVMeWlwbkdLWms1aHhhelRFcmt4azI5?=
 =?utf-8?B?bUxnUjlFcTRHdDNoMmZrbW54VE44dzQ3bXFVS1hGWTdSM2dGZUI4VWNBVDRF?=
 =?utf-8?B?MmZFellOVmRtZWhUbUFVdjdlMklSTCtvdXlyM0J5aFcvK0U5ZVpyeUFrdFFn?=
 =?utf-8?B?WDFpQ3BqNnFOTitqbUZ2THBSN1c2Zk5Cd0VicEFoSGRkd21odkxRQmQyYWZL?=
 =?utf-8?B?NnJBcVNIY29NYnJKa2hsMHN3ZFduMzJBQ2JzdlRWcVBLRU00anJhbzV5MENi?=
 =?utf-8?B?TXFLVDNtWnN6QTFwTmRxaHJaOU9vTU9vYWh2d1lKTC9UMmVpYnB1dWowY0Zp?=
 =?utf-8?B?NGFTNzJaUzlFeG9ONURvazU2KzI0UkZqLzB2SjdxZWdyRGNjNGxQYnRMWVp6?=
 =?utf-8?B?bUJ1Ym9YR25EK2FmcXgwcnZkY0RvS1RjMWJjRlBhTzBpMDlacXJyUHphcFZC?=
 =?utf-8?B?T1NHMmVmc0kzQm82eEIxZ2hNRDJOYk1MVURaL2J6ZlBUSHpZQWlNbzJaM0hR?=
 =?utf-8?B?NUl3cUdMNjZWalBkcFdVMmpVK1hmNlhHZ1VMUGRPeEUxeDRScTFDeVdkQW9t?=
 =?utf-8?B?K2J1Y2JHcEpFRFBtY3JXNHo1dHRTWW5od2gxcDlicnhGcHJWWlVKNHp0VWlP?=
 =?utf-8?B?QzlJdHcyRGxPQUxYOXJuRlJwOHorNXA4Y3FpTVFmY2NxNG9EV1hzSFM5b21E?=
 =?utf-8?B?eGhLWlNLS1JuT3lnVmJLSG5sTlNZRytpSXpYa1lrT0lSRHFHTEtCMSs3Z0dN?=
 =?utf-8?B?dUdVcEdLaUxmMDk5b2lmRUFRK0xONmdUdmIrWEROWEF1YUREd3diTlp1RHF0?=
 =?utf-8?B?SWdPUFg3SlNDVTZHZ21GcUg2eWpqc1FoK3JkaGVUckJlci8vbDg1OU5MWTlD?=
 =?utf-8?B?djZEUGVZZHVEWXMxcDJscEJyT3ZXejhOdjhQSXFxanhwbkQrTFpicExoc2RP?=
 =?utf-8?B?clRoQ2NoYncxbTZHcFhDUTZsVlFMWXdVQjZnZmYwTk5EUWVuNUdTWUJreXAx?=
 =?utf-8?Q?gMC8LRXyUwMkAqfR50jL4NMfC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KNJ6EcIbWu3pOIGcYTqZbGjYjhJRFevYg86DjFUa0OgXIj40jgEqcNtaCAVN9EenL2JQQg8nXTosjhN701cttbF2nDFrrA2qMMvzx03odXeeYVVQjUlSk+PgRbtFkRMuzlSFgNlbXjD33BfzaDCaSBFc1rqAz2Zf3GmKloKfZm7vwinNBxHxs6sYxLELqe3PcfRU/xTmJDQsHVupzTlHnTW5M64aBtcN2igE4eOAs6/NiYsQWl8eoGy7VNnVIh0zyf6SH7FEaNrxKgKjPnNhXK6giNUXC+xl4VMsiKRgMc0m6aMDGrl8zLq39RSoGwqah39/N+tJbYeXH2HXpnyTBSEYwIYIiG4NzJmX1OD30Ra5AoFAZ83DvenyMWpesO+EjBNIKo+hTr9rrYmfx3/SSjgZz8O0CXOkO/UK0n1q9qM1Eub6yAsAlpPMiaqe9wv5sfZTJbIyD4K4HLplwB7FZ0756t2hAg3Gj7kwRCtGhzTZywXSwJ9uenQeTZEaAptmh9dwBh6SUjeJcpmvpn58ybG/eO4t40YrJP07mjDDEJE1vhPDPgZiicJY7n0OihZ2VpH/ONwqgzm7/a73UoGEtJnnOiLZn9piGwncA+q/bfJ3IZOzBsxR0USJJ9Y1PXbB
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36db9ccb-9444-4846-8524-08dddbf344a7
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 12:00:03.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M1xvPmwlxmQta9KNpizayGVj/dUUSoDf3QY+0oV0ckH42XHN6t3Sj0zgqU16MgBlsL9XgTP/8epopIPXevaPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P192MB0658
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: AM7P192MB0658.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=ceOLbnDM c=1 sm=1 tr=0 ts=689f2271 cx=c_pps
 a=Iy8XcT5hUYZTIqWYt96TUg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=RmOkW0f0sXjMcqtWxUkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6sVlpOBsTpuk_lvohPLi7XaX4JAYIAlr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDA5OSBTYWx0ZWRfX8r3obVB5AdE/
 zQWjT2MYR47xm4ibp0Z8cP0bBT19LUMT1P9dKV9GHnwbng3gN6X1jl6EBLvHYsCVVhb/pvgbMqH
 jnr4rsrkJH27oU41wDjg0SLpmKUqdBQtqyS4OJ1t5ccVPmooywWcROhcEV/+gTfiWdqbRwMEprS
 8kU9Jj2PotLtcrAOGS8wymAj3izZEZsLaYdliH/ifZ7ZlPKSNp2yhG/VC/JxYZ3GT9xy7oBUW4P
 r4iaonBR+bpe8FpEf1LdaJqVBAWTYuUVuZbJ1HkITdIt5T0eoDBJAQ+PeBOqASmjxBItper0tRv
 9T9x5DXVdGDJCLei6k+9IzGbnRNNoVkAYPsOvXJ2VvDUpzXgV+dz5+fjXoD+vl5be//bNxmObSD
 MQ5SCjz7X9c1HOyhM83K0SduYxZRNA==
X-Proofpoint-ORIG-GUID: 6sVlpOBsTpuk_lvohPLi7XaX4JAYIAlr

Am Fri, Aug 15, 2025 at 12:50:00PM +0200 schrieb Sebastian Gottschall:
> i just can say. the changes i had to make for ath11k to get big endian
> somwhat working where massive. alot of endian handling in ath11k is simply
> not considered. the firmware is little endian and alot of fields must be
> converted to host endian order. but at end end i struggled with dma
> transactions and gave up since it was not resolvable. the patch i made for
> ath11k was massive at the end and ath12k is not much different
> technically ath11k and ath12k can be merged at the end. i dont know why
> there are 2 drivers maintained which are technically very similar at the
> end. alot of patches for ath12k can be applied to ath11k which i do
> sometimes if its a usefull patch. but ath11k itself is abadoned for
> maintainance as it seems (at least if you look for qualcomm supplied
> patches)

Regarding the ath11k driver, sure, if the firmware doesn't handle the swap
correctly, it should be disabled and managed directly in the driver. I’ve
already have a patch for this, spanning over 10K lines, which I plan to
upstream at some point.

In contrast, the ath12k driver performs the swap internally from the beginning.
I only had to make a few minor changes to get a working ping. Some patches are
already in the queue, and others have already been merged upstream.


Best regards
Alexander Wilhelm

