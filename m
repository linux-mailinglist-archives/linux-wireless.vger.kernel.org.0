Return-Path: <linux-wireless+bounces-17586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A4AA13366
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 07:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E483A05B3
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 06:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EB7191F6D;
	Thu, 16 Jan 2025 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CKtElCZb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258524A7D3
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737010180; cv=fail; b=hDUERAFocGeB+G3fx9YBx9+pZ4VPFp/M4AabaquaFfSAv5gfmUdUS1SknEYUN7se5rodFvGaUIVvnsWv1XsQWgjR4GcKXAo0d1fHaHjS2wM10Sv4JuxkniOc9qoiVTFiXMo74WJyNK7OcW2eqQ3gUcRBlGk7LcwLfb0oi6C/W6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737010180; c=relaxed/simple;
	bh=pa/4j1L1o5IE78+bxD33hVGp96rP0YX2O9hUjatBdp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2BqvHIKQ20M6BeZN8rmZ0o3YrUPWkNR+w63FoDpDykZIgViKXeBnkck6cP/mQD0eQai3n4xkzTX39rhTfS3dm0Op9hswaRESaLuiMi01sLTMWt11pUmBsDoozi2Y4PJmqdYKJgj7x+GzUydo+KrAPxMuc4IoC5miqusyF3ozZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CKtElCZb; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/A5X26L9zuJXwjj4JhZQkL6qjD8/m5G1rXG0cYY5mJkOufPpSepdlP3pDp5plcXORbJb6xNkan2C3ZE8drdi3f1kgdz3soarZZiKjQhOxDI2htRjC3izsFQN61dnyTIqUWSCwyY2ct3YiJOFDcEn2fRzPMhiEJEJ0ZklbCF7NPQeaKxkBMlJ7A6pCb0yK905NMh84mIk0oXe+HfgWv8GmsqK3ulzTN0weK5gETKTHZ0W323o0wekwlLW2Ne35ntxT/TrRDC3uwXCjPc5wPwG4B3Grpz3GhpR/Edxtbe5eJP8mXpzE8DkeA9azLKnBHY4GHDENCv+5Xl7xdHVjrt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa/4j1L1o5IE78+bxD33hVGp96rP0YX2O9hUjatBdp8=;
 b=h+Osl7kmP29cDijsnwSnivlWorkUmCmIC0KlZ1xXQZReTfNBBOPBDPZyGtujqK37/6SAI+DrNgKpkkuYLliJ/OPmXz2C1SrhF5zEHVIS5NbbbMDAiaBh3ck7c7erSFDoxCiLlvgwBugmErUMrmKZc9ix2l0YCxMJ8As3ae7z/DeyH0p+RnWkL12nIjoYU6fyXU2fREg69tr4MLmGamLxwnv7HPy93lEe3+51xMpEbDqocjIecZSm14OMlrc/3rxexpQD0X3ozVMg/H7TP4H5YXzLfdAkdDxhY7fooo2TWv2jK5FO3oUIpHg98n/N61Vqk9Tab1QdcSay4IiquP6uSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa/4j1L1o5IE78+bxD33hVGp96rP0YX2O9hUjatBdp8=;
 b=CKtElCZbmubnDFOVPSPMQmv+kCtJRDGi7AZVd9Gwwo3Lp1UlyQT84CuA6ZnxljOmj9cA4pnvRhid4I5wc8TZB2NbO9Quf6uLibmXbs363EmSNWw7lAZtgyjomyz8VWNytw0saVK4J5xHEtzND6YpNw/aLag4nGzEHw7+YK4bx75LBXYanX3jhu5VCSDxmNwhD7dNR7/qWhW1m6PJgVx/PHxJ8V1JT+J7akkAGADU0FqiFJyaPO/Yj+mm7mSE1ubSJUbS0pB/WcZn2d5WxyE8Wz1vQ89o+aZIoFuP2tw1E0t7u6MHfd45y93jCFBW0cCOYDnEXBtz83Uczh3K/ydvIg==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 06:49:36 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 06:49:36 +0000
From: <Ajay.Kathat@microchip.com>
To: <dmitry.baryshkov@linaro.org>
CC: <marex@denx.de>, <linux-firmware@kernel.org>,
	<linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
	<alexis.lothore@bootlin.com>, <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] linux-firmware: wilc3000: add firmware for WILC3000 WiFi
 device
Thread-Topic: [PATCH] linux-firmware: wilc3000: add firmware for WILC3000 WiFi
 device
Thread-Index: AQHbZ3GKYuBJrtYZzkyipv/0jszdjrMYMScAgAAmWgCAAEXMgIAAWWuA
Date: Thu, 16 Jan 2025 06:49:36 +0000
Message-ID: <ff2bb565-fecf-49b1-9060-53e36132f7e5@microchip.com>
References: <20250115171751.7308-1-ajay.kathat@microchip.com>
 <b558af8a-a72b-4568-8ed7-5be22105a5c6@denx.de>
 <798971cb-0c4c-4e5c-9e90-2488edca49a7@microchip.com>
 <snk2vtgflkb5bu2pbuke7hoxpmjy23hspn2pktzplmr3ipnhgg@pz6n4eabguct>
In-Reply-To: <snk2vtgflkb5bu2pbuke7hoxpmjy23hspn2pktzplmr3ipnhgg@pz6n4eabguct>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SA2PR11MB5131:EE_
x-ms-office365-filtering-correlation-id: aa3f43f1-efaf-4c55-84fe-08dd35f9f0fa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejFjaU9vRi9CVmZDTTJReElhRkQxZWVGMkV1aEdodzhlKzFTVEZHMlRDeDNn?=
 =?utf-8?B?bCtJTDc4TWlTOXMrNWJoMDhxeFF3OFlGeVlUdkZNd2dpNWI2ODRCalpMUHlF?=
 =?utf-8?B?Y0N4SCtiTTVxNTRTZzJORVFJRlVmb2V5cXB3Tk1kdjhiNlFSTFJVa1VvSldN?=
 =?utf-8?B?QWhFNFJqTjdKcjEweHh4VHhYNTZhMnY1Zjc2Qk4wcnBUVDhPOWx5aTRnVUVm?=
 =?utf-8?B?bjdvL3o5VDhmMXJCa1phdzZmVkdaVnpwcTNqR0JLeE9WaWd6NkowQWt2Vm5r?=
 =?utf-8?B?ZVQrMlNzdjl5VmQ3ZnZiTzRlQkl1RXhwSDZvVU9VSHFmWHhJdUJEWFBaN2tX?=
 =?utf-8?B?eWc2eHJtVGs5WlBzejF6OVZaQmE3T2F1dFVnaDI0MnpoUFF3Z2Z6cTJwdS95?=
 =?utf-8?B?eXJIVytkUTcvUFAybm1od1VKU0FabTg3cVNmcGpFVnBBRjdhTTZGQzU3UXF3?=
 =?utf-8?B?dTJOMVZteTgxV0M4dlpZd2hYRnZOZGo5Q0tQTUhhMFZ4WUJ3OXh0dFR6VFF3?=
 =?utf-8?B?VjU4SU50Q3NIWlVFWWs2dmpDckpmUHZ6VGt2a0ZtZUJIaFJjbjRUeHd4Tzc1?=
 =?utf-8?B?Sjd3MmZGd0dQN2lPVWY4QWNMN1Y5RzhXWDB0alZyYVZwRG1YS1kzNXA2bXRQ?=
 =?utf-8?B?TmxUaWhhRjRSQXhGWVg2aGVlMTFTb2U0MEY3ME1leDVxVTR0Y3BXYSt2ZUdO?=
 =?utf-8?B?R09KRG1uRmROL1B0ZnpOQzFuTTVFU1lCdEtTR0IzTEhCME9VbCtjc1N1UWJG?=
 =?utf-8?B?Vzc5d0NMMnRUZU9WYXRIR0I3Mmt3UDhDeENGVjgwOUExeHI1dlNCbHpvMXlo?=
 =?utf-8?B?eVFpamJDWk5RUFF5d1NQRjdpQkR4R0hXS2ZyT0tiMDN0d25NMHk3U0JpVVNn?=
 =?utf-8?B?Sk10U2E0djFPMXFNYXl4Nk95b1U2eUxiT1pvMkVwd0hLbkVvR0JnWkc3MWNN?=
 =?utf-8?B?Y29OOHQwUmdrL1V5WEZwNS9SOERDdWlQV3JidW5OeThIUTBYblBRaWwyR1VZ?=
 =?utf-8?B?V2E5R0JKZGVNOEpSMHRIOCtBSGd2Y2tvUWhqdURMdEdIZGUrY2ZKUFBrbVJq?=
 =?utf-8?B?VFRmd1hSVnUvUDl5MGkyOTFFeW9odUhqalIybTJpUDMyYWticTV6WDd2NEpp?=
 =?utf-8?B?MUJoakhsbnRtK1JZK3JkZStWend3elliNjJ2Tzhteld6Z1JURUJqdFFXb2g3?=
 =?utf-8?B?ZnBuR2p1M29iQWgxWk9pU3YvQWUyaUZyQ0ZrMWxrL1B1WlMwWWNoSENaRlJ2?=
 =?utf-8?B?cnBHL3NHZWRpK2RaMWZyNXIrajgzbDNzOXVUQ3djT2xqbUN6dlVEM1duYXNp?=
 =?utf-8?B?bkdDdy9tQzl3VHpYYUxKRkZqYzg0RklRU09WU28xSjlvL1Jvc3hpNGZ1eVNJ?=
 =?utf-8?B?cEs3QnZBQ1FtSWg2WjVpNDQyekpna3lzdkNaVkpyTGZNdTFHR2h5Y3VHdWJp?=
 =?utf-8?B?VGlwZzN2YjNsbnd6L3Bmcm45Ym1ITmdXQWlzb3RtMVQ0Q3VDZDdqS3RoQWpm?=
 =?utf-8?B?VnMzSGRVdHZmbEFDZDdmNUVDaExxZ0pYSkNjNUUwT3BoSWxIejlTaVJURnd6?=
 =?utf-8?B?ZE1McXQ1WVFZOGp0V0xwN1B4Mjlqa002T2tDNTVtbFFnb1U1ajVhaDR5Vm55?=
 =?utf-8?B?ZVpQTVF0NS9yTHFCSFd6REIzdnpvVzZ4bGVET0dydElVWTlVZ2VNekpQdTlh?=
 =?utf-8?B?ZkdjR2JZaGNzdEM5Q1BpbkUxQS9Jb0hCSlVHUm5HNm5RVWxLaWFhc0wrRmdN?=
 =?utf-8?B?eFhUMTA2V0d2QVJtaGhubWIvMUZIZjRsa0NjRDU4VzZ4MlprMDRaS3FwZjZM?=
 =?utf-8?B?eXQrSTZPakpkUDcvNnFhMnovMVo2bWxML3dqRXFLaUxWcUpBdC84U1VhNzZH?=
 =?utf-8?B?RG1SYnVsNDBjQmJLM3VocS9QbnhDUU1yNzB1SWFLc2V1RlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?elpDMXdubjY3ODdNcGdwTTA2NktxeHZjeHVkdnBRYXM2RVlXWmRqRlR3Q21Z?=
 =?utf-8?B?UEt2K1h1RWpXQkJJcU42NTZNRmlsNWJkQXRGVjVKSkNnS2lDTTFDN3VuSWJN?=
 =?utf-8?B?Slg2NVZVdEtwVUlIbTFqOXhZbjBNNFluT21WeGJEbnhiMnRLUTBxdkNlam5Q?=
 =?utf-8?B?aUZ2b0ZiaE9FWDNqakF1dFNNL3JWNzh5VnArcVdEM2JiME5jdm1OOUJ3TFZV?=
 =?utf-8?B?bWVOZGZEOUY1dHVEaEFtb2s4MUYvK21hY0ZDUzhtWHVWNHJPb1dRM3JVNmlU?=
 =?utf-8?B?S2JsNWNIa2RWWW01WG1KNmM2bFNzQzJuVlczUEJsRVNsakFzMTNLYTJBcGhW?=
 =?utf-8?B?SjZGQzZGNmQ3bFcrMDJsZWNaNGRCeXo1VEhXNnNzMCtDT2kyRmhrcG9lZGgx?=
 =?utf-8?B?SWpQK3FTQnUzK1pCVjdRL0hOSUNhaldTd0Q4c2VIYnQ2cjFTMmlBN01MTkRx?=
 =?utf-8?B?bzNtZk02a09rVFlFdEVkOTd6c2NSY3RTRVgvYjJOUnJRQjFEa2JpSHRaMnU1?=
 =?utf-8?B?OWx2LzV1MERKMjBFUUduQ1UxanY5dUZ1UGFnS2NnZm5FekorZ1VnSko3ZnJx?=
 =?utf-8?B?MzZOWG5HVEErdDZhZStKaW1RRWFGblFSWFdKZ3EwQkhFSXlmQ0I1NDRoSWgv?=
 =?utf-8?B?Wm83enBiL3R1cDdjYlRwNVF6SU95bWp1d0FWT1h1K29PTEZVa25lWUVLMmdX?=
 =?utf-8?B?bFdsb0pSZjlKTW40Qll3djZaaTJ3S2NlelNzanJiUmNaUjVwMStHYVhLcUgr?=
 =?utf-8?B?RUZhS0ErdHIwNjJ4U0JRRlFlczFuVXZueTVPcVF6RkkxcWk2dHZLTDk2Q0dY?=
 =?utf-8?B?UFhEdllMTjZaOEthVUVhQ2pXME85Ym8wQjVPMkF6WnV6UzFMR1k1cDlHZExH?=
 =?utf-8?B?OUZsaTJ3V3FKbWx0OW1DU3Z6L1ZaaEVKNWtveExtbWo0OEYvRVYyRDl2YlpM?=
 =?utf-8?B?M1ZOcUQyTFhxSU0vdG9Rem9oV3ZYWVZtc1doeFVxdWJXL20rSTRJd3NtSzhX?=
 =?utf-8?B?dUdTdlZHTDN4TXkxbm5uK3pYa1ZvTHdFbG9XTUpNd0JETzAwaHJIaG1QUVNN?=
 =?utf-8?B?RGlXM1BQazNFV1FxWmF6dTh1dXRTL2xISjNhNy9jdzlRRjhhUTRURTVXaGVU?=
 =?utf-8?B?MTlmcEoyWVFnbUEwOFdGZ1Jhd0xURS8xZW9rSWxqR1F5UG9McXUzY3pPcWVE?=
 =?utf-8?B?SnY3ejlCa00yYUgwcmxHNW9NVCt3Nk5iVThBc3NWWjF5dndqdHNpV2xOMHc5?=
 =?utf-8?B?UFIvUHp5ZitYbzI0Ym5GKzIrS2l6U3VPQXhJRmo0RGN3MWd1N01xcEZNVDZO?=
 =?utf-8?B?SGxOdTF3di9JWEtpVmUvNXYzMnZhTXRReWsyRllwdG92TUZsMVZpY2Z6a2VK?=
 =?utf-8?B?N0hFRkFONHpUWjQ2UkFBdmRWMlJEZ3pveHgvREdqQnJjQTFrK2hNd2JaQlk5?=
 =?utf-8?B?RjBBVk1PcnFyVW1oczh2RFllNDlxamNXYmNFN3BVeG4zbFp0Y2k2RUZlRkJ0?=
 =?utf-8?B?S3BPRmNmMnFYS2NMZFdUazB4Wkt3UGpveEZJZG5TUUx5aVhxaDFFWE9TY2JZ?=
 =?utf-8?B?eXAyRkZHek9SS051REp4bUxlVDREeGQ4Z2I0Zld6NCtpRk12RnNuT25ManVL?=
 =?utf-8?B?UWp6ZDNCNC9MYVNxTldyTW55UE90SVd0aHBnc3AzQWU1aVRHMzlhL1lrQUVj?=
 =?utf-8?B?di9MSGd5eUlmUWpDT3RkK1IxSVVIam0yRFpqc1Nnd2dKdW5TL3Y3dkx6L0hi?=
 =?utf-8?B?SVM4aXo5dm56MnFtMW1jUUwzS1loK3hseHd6T1R1dE5ObGJBUlBTc0RmeG5s?=
 =?utf-8?B?R3cyc2R6ZVQ3bjhEUlU4ajJmYkdrd0o4cHAvVUZraGljM1JHbUVhcG9PZ05Z?=
 =?utf-8?B?eHdaSXlkekJWaytpakh5aGdPRFJSMGp1VjFjSmtDTnFxenJSQmgrQlhxYmli?=
 =?utf-8?B?WHBQV0xBWmFGMk8vYzZZK3ZnUHpDMTRnK241ek1HWEN2UnhkVHFIUGcvWDly?=
 =?utf-8?B?T2tHNzlkbVB6d0YvUVg3azIxZDVkNjJDNXUwaDdvaDZsc3I3RmVuOXRxVWR4?=
 =?utf-8?B?dEw4K3VoNUpmbGpsWERvdXhyS0NjcUNUNDNaby9oMFRuSGxLUkRBWmJmYzk5?=
 =?utf-8?Q?Q99Bm+H1wSj2/aRNzcEMZY5+6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15F018F94BA93149AD612A0DFF42359C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3f43f1-efaf-4c55-84fe-08dd35f9f0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 06:49:36.2306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhBfNrwyILK7bAY32MWaPV8mvQjUsju+ju1YWoYFVZHhbmSC06yufobr/YcCVBzaFirGwaeh4HHAZFlyXdsty2AcrX/SMB44qSY2czLFydk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131

T24gMS8xNS8yNSAxODoyOSwgRG1pdHJ5IEJhcnlzaGtvdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBXZWQsIEphbiAxNSwgMjAyNSBhdCAwOTox
OTo0NVBNICswMDAwLCBBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMS8x
NS8yNSAxMjowMiwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIDEvMTUvMjUgNjoxOCBQTSwgQWpheS5LYXRo
YXRAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4gVGhpcyBjb21taXQgYWRkcyBXTEFOIGZpcm13
YXJlIGZvciB3aWxjMzAwMCB3aGljaCBpcyBzdXBwb3J0ZWQgaW4NCj4+Pj4gbWFpbmxpbmUNCj4+
Pj4gTGludXggd2l0aCBjb21taXQgWzFdLg0KPj4+Pg0KPj4+PiBGVyB2ZXJzaW9uOiAxNi4xLjIN
Cj4+PiBodHRwczovL2dpdGh1Yi5jb20vbGludXg0d2lsYy9maXJtd2FyZS5naXQNCj4+Pg0KPj4+
IGNvbnRhaW5lcnMgZmlybXdhcmUgdjE2LjMgLCB3aHkgYWRkIHRoaXMgb2xkIGZpcm13YXJlIHYx
Ni4xIGhlcmUgPw0KPj4NCj4+IHdpbGMxMDAwIGFuZCB3aWxjMzAwMCBmb2xsb3cgdGhlIHNhbWUg
dmVyc2lvbiBudW1iZXJpbmcuIFNpbmNlLCB3aWxjMzAwMA0KPj4gZmlybXdhcmUgaXMgZ2V0dGlu
ZyBhZGRlZCBmb3IgdGhlIGZpcnN0IHRpbWUsIEkgdGhvdWdodCB0byBpbmNsdWRlIHRoZQ0KPj4g
Y29ycmVzcG9uZGluZyB3aWxjMzAwMCBmaXJtd2FyZSB2ZXJzaW9uLHdoaWNoIGlzIHYxNi4xLjIs
IGluIHRoaXMgY29tbWl0Lg0KPiANCj4gUGxlYXNlIHVzZSBzZXBhcmF0ZSBWZXJzaW9uOiBmaWVs
ZHMgZm9yIGFsbCB0aGUgZmlybXdhcmUgcmF0aGVyIHRoYW4NCj4gaGF2aWduIG1pc2xlYWRpbmcg
YW5kIGluY29ycmVjdCBzcGVjaWZpY2F0aW9uLg0KPiANCj4gV2hpbGUgd2UgYXJlIGF0IGl0LCBk
byB0aGUgb2xkIGFwL3AycC9ub3JtYWwgZmlybXdhcmUgYWxzbyBoYXZlIDE2LjANCj4gdmVyc2lv
bj8gSWYgbm90LCB0aGUgVmVyc2lvbiBjbGF1c2UgaXMgaW5jb3JyZWN0IGFueXdheSAodGhlcmUg
c2hvdWxkIGJlDQo+IGFuIGVtcHR5IGxpbmUgYmVmb3JlIHRoZSB1bmlmaWVkIGZpcm13YXJlIGVu
dHJ5KS4NCj4gR3JhbnRlZCB0aGF0IHN1cHBvcnQgZm9yIG5vbi11bmlmaWVkIGZpcm13YXJlIGhh
cyBiZWVuIGRyb3BwZWQgaW4gMjAxNiwNCj4gbWF5YmUgaXQncyB0aW1lIHRvIGRyb3AgdGhlc2Ug
ZmlsZXMgZnJvbSBsaW51eC1maXJtd2FyZSB0b28/DQoNClllcywgdGhlIG5vbi11bmlmaWVkIGZp
cm13YXJlIHdhcyBxdWl0ZSBvbGQgYXBwcm9hY2ggYW5kIGl0IGdvdCByZXBsYWNlZA0Kd2l0aCB1
bmlmaWVkIGZpcm13YXJlLiBUaGUgZGlmZmVyZW50IG1vZGUgc3BlY2lmaWMgZmlybXdhcmUoYXAv
cDJwL3N0YSkNCmZpbGVzIGNhbiBiZSBkcm9wcGVkIG5vdy4gSSB3aWxsIHNlbmQgYSBzZXBhcmF0
ZSBwYXRjaCB0byByZW1vdmUgdGhlbS4NCg0KPiANCj4+IEdvaW5nIGZvcndhcmQsIGJvdGggdGhl
c2UgZmlybXdhcmUgd2lsbCBiZSB1cGdyYWRlZCB3aXRoIGEgc2luZ2xlIHBhdGNoLg0KPj4gT25j
ZSB0aGlzIHBhdGNoIGlzIGFwcGxpZWQsIEkgd2lsbCBzdWJtaXQgYSBwYXRjaCB0byB1cGdyYWRl
IGJvdGgNCj4+IHdpbGMxMDAwIGFuZCB3aWxjMzAwMCBmaXJtd2FyZSB0byB2MTYuMy4NCj4gDQo+
IEp1c3QgbXkgMmMsIGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBwYXRjaCBzaG91bGQgYmUg
YXBwbGllZCBpbiBpdHMNCj4gY3VycmVudCBmb3JtLg0KPiANCg0KSSBub3RpY2VkIHRoYXQgdGhl
IHBhdGNoIGlzIGFscmVhZHkgYXBwbGllZCBzbyBJIHdpbGwgc2VuZCBhIG5ldyBwYXRjaA0KYnkg
aW5jbHVkaW5nIGluZGl2aWR1YWwgdmVyc2lvbiBmb3IgZWFjaCBmaXJtd2FyZSBhbmQgZ3JvdXAg
ZmlybXdhcmUNCmZpbGVzIHRoYXQgY29tZSB1bmRlciBzYW1lIHZlcnNpb24uDQoNCkZvciBXSUxD
IDE2LjMgZmlybXdhcmUgdXBncmFkZSwgSSdtIHBsYW5uaW5nIHRvIHN0cnVjdHVyZSB0aGUgZmly
bXdhcmUNCmluZm9ybWF0aW9uIGxpa2UgYmVsb3cuIEFueSBzdWdnZXN0aW9uPw0KDQotLS0tLS0t
DQoNCg0KRHJpdmVyOiB3aWxjMTAwMCAtIEF0bWVsIDgwMi4xMW4gV0xBTiBkcml2ZXIgZm9yIFdJ
TEMxMDAwICYgV0lMQzMwMDANCg0KDQoNCkZpbGU6IGF0bWVsL3dpbGMxMDAwX3dpZmlfZmlybXdh
cmUuYmluDQoNClZlcnNpb246IDE0LjA0DQoNCg0KDQpGaWxlOiBhdG1lbC93aWxjMTAwMF93aWZp
X2Zpcm13YXJlLTEuYmluDQoNCkZpbGU6IGF0bWVsL3dpbGMzMDAwX3dpZmlfZmlybXdhcmUtMS5i
aW4NCg0KVmVyc2lvbjogMTYuMw0KDQotLS0tLS0tDQoNCg0KUmVnYXJkcywNCkFqYXkNCg==

