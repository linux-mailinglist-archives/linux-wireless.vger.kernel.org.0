Return-Path: <linux-wireless+bounces-26449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 710FCB2BA11
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 09:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7031BA7E32
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 07:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237C24E4B4;
	Tue, 19 Aug 2025 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="zUwleBu7";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="fEyloNat"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAD2EAE3;
	Tue, 19 Aug 2025 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586829; cv=fail; b=IFeBw/4Mp6QRZc5ptnAfPgu2XAjfopaYFsAQbknmXM2clQOuur8z+BUJD3/PEj2ZWFB3XKbbw/SxXrOYMui5KbVPNJIrjY3ga8q+JRYH2DovjXG8L2VEpbCe01cUkBvucNGcmV8TbgwHfHlCtPR1v7bx3L1s6c3Wq1PZ9cgJIcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586829; c=relaxed/simple;
	bh=KD70I7wQfWwiI25K8cInGkmFOR45RlNGupSFTf+vC6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ko/HYT8eCev8Xq8WYwzQRWp3/0T90lRr/QgQi5MifSzfGnc82xCA1BxF1hHfD3esAGXjqHp5FUvEHMMycM1Gao6YVz/3VMnLBz6a91uPO/g4Ue+W9JJxVM02b/HOeUdaeOCHFU3FipVsyDVv/ifZ8UZL3H63NAk412bjLjEPPbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=zUwleBu7; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=fEyloNat; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57J5pZsI3554255;
	Tue, 19 Aug 2025 08:59:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	3ToobNk5nIAXS1H7qinxVjABqgQzhej39WGFdACjESw=; b=zUwleBu7ITrFvVYz
	5zEV+VtgEJSE/kHNc31Y09SmZ8DX4+ZDqp4ZrGiT7VhFjcBOHCGmAZMQf3YFoSrW
	9GbEXvnnwXP1TGmW+L4drj7KiqHeu1lfezUPKSj9XUkmSfitaRoeV6hel+SCaSPI
	pHpS4eySZO/I8aOTRo3UNGAi6OqdM5sNzO0nVo0gMEp0ohT6HaqcQSJzyH+vjzqZ
	ck2TYilBo1EdxVXIg/kB74FYasI0v+DktC6udNXjN6M33GKReM6gMEu+74HwGIaJ
	4uKYZlhKqBnYLvr3bQpUxxW5Td6om0GPGq1ODXxA4z+BVlfab5iKeBP9vpEov5UC
	uIes6w==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05on2127.outbound.protection.outlook.com [40.107.22.127])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48jffgas2k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 08:59:58 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAe6aarMZlwz5TPbQC59Xx9JW6ne90xLuU0FWJbS+tr7/18oJABuYwjmKueedzojoW1OMDtx7iDvSIPeW/o+vlULyzRi8pVRnFYG4Pd61d1ijP74tabxhTE1wdF53nHdoAlqQ/WTm6EjOdDnSxah/RL3B4c+GzeRA0TVf9aPi5dSUkxzudyPCddm6XodLxjSq9OoePsKFJLKvQOVUDdAOxXucKC4vRLteP2yX1tKSP1VnMz4hnIFOlWYkGJQKKX7r/lMiS1AA3beyj23Di5DJdkmujEZTHdIambd9Bwe+nADqwKs8ZreAeRGawxKiXHpet4lYgNLryj0wCmxASAaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ToobNk5nIAXS1H7qinxVjABqgQzhej39WGFdACjESw=;
 b=EWVuRcenqhKm87H6U2UBD7T/8B0SQfSup5N+93Nwqtcogzpgt9oLhvaPtPfl9BOMeJZmDasHsIph+ZqsjfdCQVTVUXMFhDFOrOXGHglIgCcR31JV+1r3xs8oNNSSqHbRVwQ7XrKS739GpKv8dgCfR5ltbmcGuVXrf6i/KL/6CragIdf7RMeuBJdRxchWt1YsEjHPpBG6xsTuKWuDpFkuP9LNtIcmVR9vsv9Ud+R3bLlZdQPSjiZRFapAwi8qzMMXnrSy+2zI3NckmidHTpX2Y924nuEsyv0Qe7ev81qWuEiBo29XR/TbH0+v7mzJO0OKBG2xKYRFjaiTvZSFhna5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ToobNk5nIAXS1H7qinxVjABqgQzhej39WGFdACjESw=;
 b=fEyloNatsTAfMYqVjOF3jfcsDSpLt+z1WX1C+gNNo6ot26KEa25Xzok0T2hzFETzPEUODABiLum/nZtf2y0DHHTZXbrlkBe7HLeCqpWVCO72B9cuEuIKbdHFBwzlyHUa/miy9UkoCXjm/+i30HQChiKdt7xTlwF5evjwQB1NoU0=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AM7P192MB0578.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 19 Aug
 2025 06:59:56 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9031.014; Tue, 19 Aug 2025
 06:59:56 +0000
Date: Tue, 19 Aug 2025 08:59:50 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath12k: REO status on PPC does not work
Message-ID: <aKQg5vLUplzMUMlU@FUE-ALEWI-WINX>
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
 <d6f0b64f-1764-41cd-a7c5-fb34d034ace2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6f0b64f-1764-41cd-a7c5-fb34d034ace2@oss.qualcomm.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV2PEPF00007572.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3eb) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AM7P192MB0578:EE_
X-MS-Office365-Filtering-Correlation-Id: 03810c6f-619a-49f0-c64f-08dddeee0187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXp4MHBEd1hVRlpUdVZmRFgxWVhjQmZQeUp5OGd2V2hTOWd2aElmcGtwS0Z6?=
 =?utf-8?B?TzFLb21hNzhhcXM5bGVodTJ6U3J0Qm9QancwRDA2eHhNYmZJSTZ5cjM2UzVZ?=
 =?utf-8?B?L20xYzREc0t0dGV5VUtHL05VQk80MDFwelFPUTdwdkhYd2JJdkpaNmlXREFw?=
 =?utf-8?B?RkN2YTNSckRxYXZGMkRYZW11dXpzZ3RpVG1rdnVWd2RIOFUvc3U5cDRiQnZ3?=
 =?utf-8?B?RFFXMzA2QWRtakhISElpYWx5R2RpR0VZYXhkT0x6cTltdWpsR2xwaW5XT0lv?=
 =?utf-8?B?OURuQjhKa2s4cTZtK3NwejM5Z2Vab2xiNHZIVThFQ1l0UnpyMkJ6UWpSbnAy?=
 =?utf-8?B?OVVrS2UxUnlmZS9Ga2ZXV2J3WHpMNEsvTGxLNTNkekMrK3lxOW9NZXQ0aUxS?=
 =?utf-8?B?cURZZXdWT0RFTUp2Z2t3NnM2NW5qWDBubFRRdTVxZUpzRjUxREtQVW9tMG5B?=
 =?utf-8?B?QWdHcU80TVlQMUlrU2RscVpnam5zZUxPN0FYUXBWTjdDaHZSMkJqendjUjEr?=
 =?utf-8?B?RnBXWU1WNnV5YjFrc2FQT0R4R2RqdzFsUHBQY0J4dENOcm52LzFtLzZKTUNy?=
 =?utf-8?B?eEcrTlBYc3YwUnZnWXErRDFyNERqblNnY0w5TGdabFBFbGdCdUZCSVFPTUZG?=
 =?utf-8?B?MVVjMldUczFMU3Z6ai9Eak90VFZLUmEwZ1ZTRWVtcnRIeEYwNVpYc3h2TUk0?=
 =?utf-8?B?ZjQ4WGhpeVpQeElQT0h3enFqcUlCSk5UMENEZ3d4cWFkNzlIWG9sOGtRN2pr?=
 =?utf-8?B?bHRNV3VWV3VSZnMxbEJsbGdMcWc0dGhqRE8wU21WZ3ROVXpRd3dYVVVXTjha?=
 =?utf-8?B?dk4vQnVwUkFqR256S0hRd3lCLzFyeXA4RkdwU3Vrb3RZZy90UEpFSWwreERK?=
 =?utf-8?B?SjdsZjErdUg3cXJOVGlUemYvWHJQYmFoN1pQRy94bkFqSzF2STluSzVWSWcx?=
 =?utf-8?B?cGxZdXRiZVdIamdrV0V5ZUpsTDdHLzB3anBWMUlrVFVxL0lXdnJ2SEtFQlpp?=
 =?utf-8?B?MW9SUlJqb0g3U2hvbjRsV09hMlFJM0dNZVM4aTFnd0J1MzJwRWxtUUJyK2to?=
 =?utf-8?B?QWEwZVBaeE1jNTVKTW5wdmpDUDRDR0J0ZVFSZ3VDT0d5VSs4OUttRlIrN3Zv?=
 =?utf-8?B?eFk1dkI4bWdsZnNCclBUQmZHdEVjd3l5enFYK3RqUmpUdFRlSW44d3JWQXhj?=
 =?utf-8?B?OUxxdExjbzBRZjAzK0xrWGRQcURSdEYzLzdodWFwRFVPVy9KZlFOdjF2dk8r?=
 =?utf-8?B?Z2pWcXdnZmg0SDBhUXg2aGV4YXp0aWVETFJUbXFDdDVjcTR1cnZ4QWx6dHdx?=
 =?utf-8?B?WGZkQWhXYlNCdWRwdjI2WnNsRkV5YWRrYW1RU09LMTlqYmxkcGNaaFFzcFYz?=
 =?utf-8?B?S1pBZnN1c2ZONzB4ZVJrdlE1eC9GWW5kQzlMYS9ZSndReGYwWmpzVStwaUZz?=
 =?utf-8?B?RnZwYnNKbDUyakM4VUc1QUJZSllSODRuMkZUWk1OeTU4L1Q3L2Rnc2c5eEZD?=
 =?utf-8?B?N3NSV0VaT1hqTlZTL002NExTKzkvb1pZR0p2OEl1VEp3Rlg4dzdrMldaeGps?=
 =?utf-8?B?OUppRDF2NGNudFNtWGE5OTgzb2VIayt6blZrOTFNdGVPT1YvV3E4THl1NWxN?=
 =?utf-8?B?K3FkdUw0YjBwYzVoRmpHUmI1emMwTFlWNUdzMjduZTdnc2ZmMVJtQkJQYTZO?=
 =?utf-8?B?K1hIR2lzaUNsd3pUcGRwbWRFWE5JMEtMWWpVN1BjVzdKRFFFaWE5aWgxZ3hq?=
 =?utf-8?B?V0hCM3M1NkhjNGkvZzR4b2Irc0FOZkNVSGNFWm5hc09wcXRsZ1Y2MTE5TnM3?=
 =?utf-8?B?NmlZMFJuTHJVRHRvRFc5NVhTeFNuOHlaZkRNQVN4YmJTWkFOR01FMTIzdHN1?=
 =?utf-8?B?YTlmV3pNTDlEbHpKNSs5SWxUQmx6RCtIY3diSW5ubWFXM3VFaXg2VzBUczZ4?=
 =?utf-8?Q?iEOmWr6A6HE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0xqRm1HcUxlRzNnYVB2M1laSndVMXJJbThSZGl0aHNuZEhGeTl6SzlGRU05?=
 =?utf-8?B?TmIxL3NYUnZvSUg5dVpQL3hIbFE4SmcyWE05Q3JpUmNNT1AvYlVKRitpM24w?=
 =?utf-8?B?bDcwaGZRTVhYN1AvOHRPQ0NGZGQvMXhQVmZQN09rWitVWnVrd1JkcXhlZGZj?=
 =?utf-8?B?VmhKVCtPdTQxK1ZqSWtmaVVwbnJtNHpwZGJQdXRQd1NxaUYxNnF0eWFGRUtr?=
 =?utf-8?B?NjFGWU5iOEN6bWY2bGRaanZtOXBaT2ZsOWx0TCtLd0JNM3hPMVVkMDdPSkl3?=
 =?utf-8?B?cE9xblNPTG4vSnBPbXlRbWxPYmg3aS9JcFBuRFdQUFFXM240bFY1SUNhZWJH?=
 =?utf-8?B?Sm5YVWFOejFWTk5WZEFsb1JqUjZqTTFnNUluMXFPSEpOU0NuVXRxL0J3Y2cw?=
 =?utf-8?B?dnRIbXk4QldOZWwyLzBPQUl6SFc2amZwMnJmZk9HS3J5bjg0S05YZzlxcmdj?=
 =?utf-8?B?Qk9PTlN3eHFVUGNCQlJEcW9TeS90TW5EZkhMemdWM3ZhMEdiVXVLZzNjSFRI?=
 =?utf-8?B?bE9mRk44ZThrVyttcElpcGRoUGRWT2wxS0JCN0VqcEo0WTZZRi9SM3dJTTdh?=
 =?utf-8?B?L1JCaldjMFZhQ0F3eGNOOVpsb09qK2M0dklIWmVQVGdvTGo2TGh1SFJtUXdH?=
 =?utf-8?B?NlViWCswZFM3bjlNSTVRYzdlcHJBZWJ1SEQ0a2RqcWpzdlFEeTFOeEZFSVFL?=
 =?utf-8?B?MXJ0T1U2cGNKUkc5c2lDVmxJSlZKNTljUHVPL216VmJUT2dOTE93U244N0Rh?=
 =?utf-8?B?TEZTRlg0Wlkwc3dpYlhRVmFGaTZtZ3pKcmgxVTlRTndwNjg2eW1iRTdORnJa?=
 =?utf-8?B?L2RSWjZGVGxrcTc1NXpFMjZKRzY3OVNFK3FpbkQyWEpKczdrdmxhQVMya2I4?=
 =?utf-8?B?Q01QZnlMUTd3WHc0T2g0M1dwOTFFNUNTelduQjMzRDR6Z2tVRlpTOVhrK3la?=
 =?utf-8?B?OExQdEhnVkVtclUxQnJhNGJWSEtnM2pDUHVvbnEzN1gvY0hwbjcvUHhYUHJF?=
 =?utf-8?B?NWJNMnZhUlNmaEd3ZG43T25DQnpUcCs3VGR3T3BKU2VqQ2hOUDFOVzJoSUpZ?=
 =?utf-8?B?MEJKZ3pNaXdzVHM5RGhqaDl4eS9rY2V4YUFaZkZsS3NMUGQ3L2NiQ3N2ZDVK?=
 =?utf-8?B?cThTRThFY1MwdnhnUDNBcjA2d3QvM3MzS2c1am5QbmJBTStnNjQxckU4eDhp?=
 =?utf-8?B?dzlJeWpqM1hjTGNOeVk0ODZ4czY3bTR4V050ejNHRmQ1QUx2bDEvMXQ0UVB6?=
 =?utf-8?B?cnkrckhEdUhydjN1bGRFZ2tUeE9vVGdBMUo1U2JrU21JaE1teVdkU0VMNHJC?=
 =?utf-8?B?T3hiUndBTWJWbVRJOEl0cXBLUnhacStXeXIrOVVreGpNeHdLQzQ0bU80NVFt?=
 =?utf-8?B?QlFBbjRsUEQ5UURpNWt0VHRCckdQU1o2NDA3VzREZlRyVEpMaS9BbHNhaTM4?=
 =?utf-8?B?dWFxdXVzcFZMQ1Ruc1paS3FlSFI5V3RzZGF5ejFEaDJ6NVFKWWg0aUNjMmQ1?=
 =?utf-8?B?NXVsKzBHSS9CN3lJK1NUeFFERE85K1ZHT01iK1U1Z1ErSHFUZVE3QXBGWElD?=
 =?utf-8?B?WWRaa254eVB1c0IvN0dmWGlIUFdoRjkyN05lek53VDBjZGZ5MUp4VCs5S2JG?=
 =?utf-8?B?bnNHUnA5WEMwa1BVaExZVk9ma0xBemcvdGtFTTBKMUUyVHgwUS9ZM3dJNmp4?=
 =?utf-8?B?OFJlMkpkVXZaRnlTWEVCK2FpUTNYd2VUcWQyWXZtWE1EQTMxR29xckxNcjha?=
 =?utf-8?B?L0JaYTVWcFN2ZnNZZlR3WnFUOG5kekxmZGQ5clptc0JpWXRUWHNEYTExWHdG?=
 =?utf-8?B?dGU1N0FOWCtsZFI2L0ZHOGtnVldvcHpOL3hxOTNrenA0L2FBOXpXRGVmTlVR?=
 =?utf-8?B?OGNSOHRLZENHUFVFTUpYRnZ0dWFiTitwNktqa3EzSVVlMEs2N1NjL29rK2Iw?=
 =?utf-8?B?M0p0d3NJTGg5bnlVZmRkS0dzVVZTMU5ybzYxaE1KRE5tNHpuLzBiaHI1Njcz?=
 =?utf-8?B?VGZBQm56MHU2TTI3dUNtb3d1OWxjNVRSMVdIUzhIRHYyMVlJSmlIelhIc0lT?=
 =?utf-8?B?Lzl3dmx0YzRvNnR5Ty9hYnpxckplY1F6TDRaZ3NXSGpRT29CdGk4RVVrb05K?=
 =?utf-8?Q?O2ZLgqrJSY9JdoUNylIwtlccW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vngVo/Y0BNR0gnlcXyblXccaBfzzkxuNuCTvJxrKLKcvfdAdvn4v3N7oChWKegkUATbeutvF/0J/lisCIbKfK/2XWmkZxyau6W0lUEwDk+zbhD9gi17KKfmSrAPqNekEbpv9cBrodyB+FZOOmuyBreQFVp9KW9zxbEEHiZmP4EP/x0RzK4VLj9aht07gptSCCVRb9B3b2ZhT7otJqbQuN9J7RUIPEbR9FnOBF5V9Hv/7YiX2BlfsuIN2hd+IrAFQbePv/NUOrt9fPIQ2KUhinAquDXYUfQGlVDuJnYKvUpchNCMxEq0kcZUOr5RYQb8RBT9jfIaa59o+wL5JmC5hFkB0fBGif6NiVcVtLFOcYtQDAsBKP+iLrlZkJOM3R8MVq3dd0X3iqkNubOpR5q1JJZhNxwf5m6tk8ghenYWKGYycfDhSv+f66V8PnProoykK0DhiSzg941/7MNi44tMC9tZ/fHNVneyPvB0/q8o62qt0Br5s8I93yTA3eBQJUdW8V3bfI0QoSJYaWK5kg+24l2izlIWnDhZyl9m3v+QcQhbejC2oZrOgN+VYVjgjfm9I10xGpVO59HiIGgV8ojTFSFOfKQfqgfa8aosE5UU2vtPiIIJIZrTEaTv+GhdTtBgD
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03810c6f-619a-49f0-c64f-08dddeee0187
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 06:59:56.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5Nr7y2A/Kik7+QfWUu+8lzk9lsX+1zvcxrPuRORLoZc+BxvjUBMZ3nVA0WCw3iW2HYEqY5CXXBVKhluYt658w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P192MB0578
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
X-OrganizationHeadersPreserved: AM7P192MB0578.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: sqMzz6jJIky1tPEk3Jo8ddCLB8GqT0q1
X-Proofpoint-ORIG-GUID: sqMzz6jJIky1tPEk3Jo8ddCLB8GqT0q1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDA2NSBTYWx0ZWRfX8Sq0lr+yBbCG
 pF4xa5QMt0XPDdLvrbVzyaPGf11ee0BU09qaAm7owZ72sq2hOVxKpN2G7xQzgwJh/1e0O8+m52E
 3Mg+R1kcHUSECSxfOFYRb3Rtx3Fh7ab5+DOT9pyGoskpLvDp4nOUJCBo2bOk7pq4vAsekKp6Ivb
 QOYM8qyan+WL4dTUmCX6SA/crpja31BFU8fmwPf0dlDzUg25aZ+vTIUQEao5E5QtdnKDAdPZz8n
 4T/0YtqEmsyVGnBynzFjNpghmHXTU8s0w+2xiyhyYBsw9lhMyZXNWsvKaK3LVAyllHGKTgYtz84
 mnt/plvtaOV7mzcePtYlyZTDPGBntuF0/ZvGv9q8CK9tKPyjuqZ3z0Dr55/rEGPaQ/qCFJJzH2E
 UvoJVBDJHnq6Im9aRTawL1A5pJhi3w==
X-Authority-Analysis: v=2.4 cv=K6B73yWI c=1 sm=1 tr=0 ts=68a420ee cx=c_pps
 a=7npOGqyay3yyVygbfyT32Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=P3XI3Sk0-mpVhaV6S1kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

Am Tue, Aug 19, 2025 at 02:38:38PM +0800 schrieb Baochen Qiang:
> 
> 
> On 8/15/2025 4:13 PM, Alexander Wilhelm wrote:
> > Hello devs,
> > 
> > I'm currently working on getting the 'ath12k' driver running on a big endian
> > PowerPC platform and have encountered the following issue.
> > 
> > In the function 'ath12k_dp_rx_process_reo_status', the REO status is determined
> > by inspecting memory that the hardware has previously written via DMA.
> > Specifically, during the call to 'ath12k_hal_srng_access_begin', the driver
> > reads the value of 'hp_addr' for the destination ring (in my case, always with
> > ID 21). On the big endian platform, this value is consistently 0, which prevents
> > the REO status from being updated.
> 
> This does not seem an endian issue to me, because either of them we should get a value
> other than 0.

Really? I always assumed the value remains 0 until the firmware writes something
to memory and moves the head pointer of the SRNG ring buffer. By the way, I've
already implemented the missing endianness conversions for reading from and
writing to ring buffer pointers like this one:

    hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);

> > Interestingly, DMA read/write accesses work fine for other rings, just not for
> > this one. What makes the REO status ring so special? I couldn’t find anything in
> > the initialization routine that would explain the difference.
> > 
> > Could anyone give me a hint on what I should be looking for?
> > 
> > 
> What hardware are you using? WCN7850 or QCN9274?

I'm using QCN9274-based dualmac modules.


Best regards
Alexander Wilhelm

