Return-Path: <linux-wireless+bounces-9808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F491EBAB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 02:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D72B22076
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 00:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73A26AF9;
	Tue,  2 Jul 2024 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dJF5vXnx";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jqLjC2jo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA717166F;
	Tue,  2 Jul 2024 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878410; cv=fail; b=I6p1YKldJcpJT7t0F1gjws1uqIxkBLYnuhKY/CvYWXPpIP7rRW/InIU6jG6lQHovmExw6AJKZAWeJs9H1JqgKlyPhConcdKk1hdv81ZgJ6zdwqMrkSORmvmAElm/fHAP/EqDUdchdHqTp8cXqi3BIECrCd5hvDZw0rsEdKpScQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878410; c=relaxed/simple;
	bh=ERXJjXAc2yhZ7ISr1XFQWZozYU4jxu3vwd8RYYW3iGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FB4JdL0Zwf3FIj6FP7G1T1TU+fjJzfdXiIxBMOKKKIbz1gwDoLJW55rE1H83z8gxjysNcabgJufMnhtvmRhNf4A+xEtk6mJGEjpfU+UIvvxPVB6y9rXVMJdaztidQztfuYDKTarLvcymq55309ePFCw3+FLYm4x8Kpk8km8mDQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dJF5vXnx; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jqLjC2jo; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719878408; x=1751414408;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ERXJjXAc2yhZ7ISr1XFQWZozYU4jxu3vwd8RYYW3iGk=;
  b=dJF5vXnxynOx3jBAl7FpXqEGLqPvDrfmoUGHl8pU+vNdorYTJOrKJa7b
   olLlTHc9uoQ2PxbYMKf688nz5A+yAv8WPIeAWvYNEQ+LsWylMB10upE74
   bb2RC2YbEMfB3WkYoh4Hj2MRyjwNC1a/U+D584rbezJbXkYVJEJu0oZrM
   Pny0sYTAeh+WB77o7rumGxTyopB1007Ypgzw0gVjZeEqwfC2TVOvpqA69
   WyNYkD/OSEnO+nfqfNyQCpNUCn+9K1PoyKPgLA+VS5271LF3d0jQahL1d
   D0r3MPQXIHki4AqiSbgndjr3YKTz4DLhFr0HN0KWDSwGjoDYPbuI/YPRM
   A==;
X-CSE-ConnectionGUID: UkdhMzY7QFSOh6KSXnPR/A==
X-CSE-MsgGUID: 2l7ojzSmS6KP6MDHEWilaw==
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="259608808"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2024 17:00:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jul 2024 16:59:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jul 2024 16:59:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEH4gHkkzZasZqjrNjS2Kb8A9OCDOLluXZkBNfX5fHyXSV7r85XpyutadmiLojJtqCr8kaRuR91A+v5CjmCvAFL1xiqVdoepSltVJyG6y/RPLfFsajcHhQibf6RJkf0DtnoBn8zcYA9ag8xlZaK0wTxJFDnmjwtc/x2NIcO048xG+OBomXsl4cuenKmey81ZyKS5CYSSK77EH9n70DUzRflPXUOc+tqeDvmtsVS5tKZsOKK8PnXcGfn8L/yKXX8ya8jaPGbyQM3uvsynndC1+KVapu5Vy6s3iZ2Ngn+2s5DqnWn7rjxS81TKdHbIp6tGb5ue6DvrnbOMJ+1x/UiuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERXJjXAc2yhZ7ISr1XFQWZozYU4jxu3vwd8RYYW3iGk=;
 b=hIpgp2xv5KJoVFQ22q66kEEz2RCgfZ8nugXnfsO4uBvIoOt1O2I1OnWEd+rayxKH7UCFJY9PIIaA2hTyVLYrWY3b2HHKoJDiDGbcrT8UrUk14AYByeC5HULFtSAUHKajYhYzVnSma7k1JHaTP2+ZcJkRqjC0JWo2NozCw7Fb8w3rCfpxWyjeGbt8P+u4q0p1ZldjbGc30+jVVJTU2IMUsDHmx8ykDC733LF1cCJJCvS03Jy/61Q5JATzjwJ57yxveu8S+VsGAYMTW2a68y8v4j3jDb/qvWCyLgqVpkyfcPvNBQPBMDShVYLvT8JhZw1H9QudQgQJfdSBbH1fSB0BIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERXJjXAc2yhZ7ISr1XFQWZozYU4jxu3vwd8RYYW3iGk=;
 b=jqLjC2jouwWn8cDkA8t411I/7y/4u1cAkaDDOJq2gSUaQxeSGaQJlTXu8m3E80P9U420jiC8bshBYJx3JsEVsyt+M8Ezua0qTrvQSqJiuOvcG0A2NfFTWC1TfqibxeI/QHsAStvK6IF+ZIILCp+UshKBZawEy06OcVGddzs+bmzerMvRvH6sm1Tw5YOrTDDw8GHPN0Rlnp0VdUUtAUCutJXMWLLx4GJ1wVLcL9SKupRJy66eOqLXo42I37BDWzxSpQ322t4fwcLmhL0v+T2iLOc7vDowX7UY+C/JA/KN1e8SdPSlcs/qeCXH0IqeGNvW1DVyqQVcEt1FYmQF9HV+6w==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 23:59:36 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::7625:e894:f3df:9ac9%3]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 23:59:36 +0000
From: <Ajay.Kathat@microchip.com>
To: <alexis.lothore@bootlin.com>, <linux-wireless@vger.kernel.org>
CC: <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>,
	<thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<jozef.hopko@altana.com>
Subject: Re: [PATCH wireless] wifi: wilc1000: fix ies_len type in connect path
Thread-Topic: [PATCH wireless] wifi: wilc1000: fix ies_len type in connect
 path
Thread-Index: AQHay9MUJPlkw1lS5k+upePlxOln17HijcyA
Date: Mon, 1 Jul 2024 23:59:36 +0000
Message-ID: <5ca827fc-a698-4579-bd8f-b9e341321d1d@microchip.com>
References: <20240701-wilc_fix_ies_data-v1-1-7486cbacf98a@bootlin.com>
In-Reply-To: <20240701-wilc_fix_ies_data-v1-1-7486cbacf98a@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SJ0PR11MB5023:EE_
x-ms-office365-filtering-correlation-id: 2bdf456e-4ba2-4ff4-c327-08dc9a29dc89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VnZwaVliMUdhRnF1TnVvUXZEOVV2ZHNOWE1tSlhkblR6aVNYRk1MRWlKU3Nu?=
 =?utf-8?B?WGNDcGRtKy80NG5IVXV6VmJkbE50cDM1K0FENnJqbmFzbEpYQnNsbVBSMDJx?=
 =?utf-8?B?Um02ekdlUmNKdmJCazVOM1lhbnlSUGZiZGN2T3hML3U2TktkcVIvdnNOVDFW?=
 =?utf-8?B?YnFTcGtnMW15di9OaFJNblhhMFp1RkJGallKeWlIc1hnTDg5VzhpVUhjYTdr?=
 =?utf-8?B?UjI4TDFnVWdOQVlRYUFJR2Q3VjlXeXRwWG5zNGtZK1IzaEFRT2htb0hXRGxh?=
 =?utf-8?B?M2l1NTR1TDluU0ZpWDcxMHBUeTRpNjkwSGgxa2N0MHMzWGl1anhlZHBEa1l3?=
 =?utf-8?B?VzNabUVvbUFGTUdVQ0didERBcWpVS2huRmQ0eUk1UmhVRElJSzNvL2ZTOTJC?=
 =?utf-8?B?SGdvbHBmQU9WcE8wRG1PbS9NOE95WlkyRnhSbTZZTklVZG0wL2NIWHZTRG1H?=
 =?utf-8?B?MXJxQ1duRTZEclNjQXU0dG45cm5SaU1OQ2ZBL1VjaktjWll6OGRNYTltVDBq?=
 =?utf-8?B?UnlRT2lqQkZGRENTNXp6QXJMR3hFUWVrWTN1M3VacVp3czRLS21tSUpLS1BI?=
 =?utf-8?B?SUN5NW15TUl2ZnRyWHZSTVNGam9Nd055LzNNQXpIUVNhbGZnOEREcmxmZ1BP?=
 =?utf-8?B?UUVkOWtuNElYV3FXeDhhZ05rRWh3eGVmdFdDOXZsYStoSk10aUpCRSsrWER0?=
 =?utf-8?B?N1o0S3lHN3BVYVdFR2ZCS2U3Q25yMkI3TnJSTkZ4clRtNFhhemJsUXFQei8w?=
 =?utf-8?B?S1hjMnBKS0diQ0F6eVZUY3dxamhtL0tFUEJ2a29JOFdwMnVaK3NBZStURE01?=
 =?utf-8?B?SDV1VjFpVWxid1l3QTJGbU4yY1NzakFQRjdTcVE1ZFRLaGswSkFLSXZtSnFC?=
 =?utf-8?B?WlFWM1Nvc3QzT0p4aUFxSVNTbks0aG03WFo2U3dTOVlOaWhFRUZESHcwQ2tR?=
 =?utf-8?B?a21Zamo1L2VBdUszWWs2N2MvV1luaG43a3Q3M29vL0tKSFMxTzAwWERCYWdy?=
 =?utf-8?B?WmZmbkJveUNmNXRXaVVmNlY1WjlPd1hid3hrMVA1VVdwSXRuOWxHdVB2cERF?=
 =?utf-8?B?RE1sNCtoQnU0VEhNUksrYVRYVWFDekpqRitJYjlGT0NHazlnd2lWTjNrVzBt?=
 =?utf-8?B?eExYOW9GWkptc0N0OU1ISmxmKzIxbkhJMUN0OVZjbDhKOGZmamI4YzRLblVr?=
 =?utf-8?B?VFQwNThWR3lzSDN3U044L0xETnVOa0RialZ3bVVTWFkra3VmTDhHdWVaM0ta?=
 =?utf-8?B?anZKdHRuWU13N3loL0NKS1hWNis0T0srOEQ1UUQxRURBRjlEZFNUblpoTG42?=
 =?utf-8?B?ck42OWx1bWRwQkNmaW5GWXUyWEhzVjI0elJqc2dkT3FjWjBlTDRjdVJyVjl3?=
 =?utf-8?B?aGJZZG83UnVwTEY5QjE2eWd6SEFaT2NxUFYwNTQ4UTlsNDFLT1E3Q1hmU2Yy?=
 =?utf-8?B?a29xUUg2RU5sZHIxd0UvWjVJOXBSVXBEdU1qMWdscFVKdWU5TGxyVmFxTDlL?=
 =?utf-8?B?VlJqUnVKS0lxNktJS25tbElhZTFLb3A0TmJrajNiR29WQnBTNnJMMkdzTWJK?=
 =?utf-8?B?clE1UG5uRGxVSExncHJoeXdVUWZjbTdFRm4vYmMwSGhCUlh0SERIcnhSeGho?=
 =?utf-8?B?M0ZockMwQ1FRaXNNUlNsN0xtcTJhTjBaVGY0VmFqWng5Z1pxSkhibDFOUFR2?=
 =?utf-8?B?c1dQeEpFRGYzRFBwOC9HMUFyL2l4M1krZ1FCRWUyK2ZhNzRlMEU0ZVJvVEpn?=
 =?utf-8?B?VjRrZm1DcDFaeHRiNXQzWnlxblVrWXpXZ25SYUZnN0svUFVrYldEMGF2R3Rs?=
 =?utf-8?B?bzZ5c0xLck1ESmtGL284dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmtJM0V6YTNnMzNIREN3RUluL1VxREgwR3huNDJ6d0k3N3ZnOXNBdGhmZlRO?=
 =?utf-8?B?SDdrVjVpWXhVdUhGVERnNk9UWEZBQlljMFhkM2JwZk9kZEFPN2t0dVBJaDlH?=
 =?utf-8?B?M2syenNPYll1YkgzQ0ZoalljaC9rUTRFb0U3ckI2bHl0WnRRNjhCV1h0VmhZ?=
 =?utf-8?B?eFl4VERhT0ZhZldmd3o3bVF1dUFsbVlXL05PY1dVWThJMDloUjJaaWtSZytJ?=
 =?utf-8?B?NDV4TG9lRFdFVU1xdWtQdzQ5Si9MSnRQUjcvVzF2STBNT3VKNDRheHZBaVl6?=
 =?utf-8?B?YUpvM0lCblY2U3E4dm9oM3RYQ1Z2akxhREVXNUh1eFRmUkwwdkVHTE01Q0Yr?=
 =?utf-8?B?amdFZjRqbFpsSUlTQ2VZcGVDL25vMlk3cjhOc0VJcHBkdjM5RDc3SGpReHBx?=
 =?utf-8?B?WCtqdFZ0bzBJVG1laW9nM3o2bldnQnU4MGRPa2NUVGJNdHlGVzJXTVBWZjhs?=
 =?utf-8?B?dXNRMEFXY1ptcUN3cXhselNSWGQyMWZnU2Y3L216UnRxRUFBOEhqVXNRNnlH?=
 =?utf-8?B?SVFhWFB4OW0rNElxVXNrOU94Ykl1RU5uSHlNSXFDR292MnozdkcxS2NuMHI5?=
 =?utf-8?B?TWlKMUxoaDU0eWFkL2l0TnpaZjQwcHQ2QTFMQ0orTUNGcG1RZ1FXVy9vRUpt?=
 =?utf-8?B?aHFFdFpIQmU0YkdwcHhYQlRKMklkQUlKWFpOVzNENmpmSDN0d1NhQmxXcWJp?=
 =?utf-8?B?KzNpUmZldHJ0SHBFYUFUVmpQZzU1b3BKaTJJNWVBMml4cXdTcUFTOVVWYm8z?=
 =?utf-8?B?c2V3UHVOc3J2VE95c0pRMEgvQ2xsb2FQUUZlcThKWXVleG05M0NvWDhjK0FF?=
 =?utf-8?B?L2VJRlRTRkE4YnZZRVo5amdDc3JEbkxZeUN3TnZoV1RsVm5zK0M1aXRGTzlr?=
 =?utf-8?B?ZHY4VHp5V1prMEtSY3kyWTNwUkZTQ2Q3Q2hndkZLdkVtbXBjb0hMWUVWcFlj?=
 =?utf-8?B?TkZWQjZKNFg0UTJKaTJLVFdoS3RHYU1YRnJVRHkwNUcvRkc5MnQ1Vi9VWjQr?=
 =?utf-8?B?U2tPNFFjZmlNM1hoL1lQT01ubUJGbDB5WW9DWGFoSHA0M2doSkNUbjBhYytI?=
 =?utf-8?B?TzNEdlJraFlMY2dXenUyN3dnR2hiSlRnMVRtcXo2RDVwNWsvUUwvUDhPY2FP?=
 =?utf-8?B?TWlYY3FId0hwOEt6UkNMdGNXbjdsVk9XMmtkZVYrTVR2YXdkbFNqaGgrb0hM?=
 =?utf-8?B?a1AzN0tzNGNTTVdZUnBnYVl1dHczSHY2RWd0RnB1ZWEyREFSOG1LWEZFV01m?=
 =?utf-8?B?K04zL3Rodnl2b28zbFpPYTNUVHQ1ZjZGUUVSN3U3K3JFWW85N0Q1RmtTRk90?=
 =?utf-8?B?TGl4bGNFUHFEUmMwM1cybjVHWUNTb0lFYmNONTdHY210VTNwUDd3ZitWU1Ry?=
 =?utf-8?B?aURsN0dpN0lxa1Y4Z0hmbm90aHprV1NhK2dVWllpK2ovc1hRSjdkRmhYUGR3?=
 =?utf-8?B?RmlNYXlIV1RPVHB5a2ZhQnVNSkRMaUc3NTdReDF5YUtYd0duTzFwUmRXMXhV?=
 =?utf-8?B?VDV6ZEVtc1kzWkRpSHNTbEhPTFRNcCtQZmhzeWdLRkZTMDR2QTNxZkU2M1R6?=
 =?utf-8?B?TFNDS1lFTTR1ZWZFWGJYeTU1bDkvZWlUM1h0dzZRa2F3Vm9BcGJBd0ZsSmhr?=
 =?utf-8?B?VUgrclJaQWN0eGVLRi95VXlOeWw1MnNIeXVqTk5mcXVJeG8wRzgvVXNSZXFU?=
 =?utf-8?B?VjJWQjd2SmY4T29LbUR1TDFOZ1ZRbE5reGxQT1ZxMUZ0bUJGQ1ordVhVWWtM?=
 =?utf-8?B?aEVpRWdqbTRJOU54YW9EcXBvMHlkNU1ZM2tCbHQzSDdyS0RidFJWVGNwbHdY?=
 =?utf-8?B?Qm1aMmN3RTdCVGRJYVNObHdKb1Npa1liRzRUVGVOYzhyM3VVeURyU250S1NY?=
 =?utf-8?B?SWR2UHd2NjcxN0ZLRDd4TzZxQzJLNzhTcnNUNXNZZ1hNZVdPcU55YVMwTTBp?=
 =?utf-8?B?SEhCL0dTVVBMMlNyY3Z1TmU4OGs1TWJIZ29xcVZ0c21mM25CeVlEazhGbGtN?=
 =?utf-8?B?b3hiUFBzbFNOVzQ0MTQyN1lZTzBQUzUxUUwvMy9NeWZyZHkwWlViYktBbExu?=
 =?utf-8?B?TUk4ays2MmJQSlR0ZGhXOVdjZG5CWS9zNm5qb0gxbjZ4WWU1REJuT3Rsd0p1?=
 =?utf-8?Q?51bIfles/Kz4qUabvpOFyl+qN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <002E884E79A6DF49931B7CF7261B7BBF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdf456e-4ba2-4ff4-c327-08dc9a29dc89
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 23:59:36.3901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3y49jHkeYy6Zm2mxqKF0jErLTktwpPAKR7TT3+5LttEa/4Bs6JB4FORj2OBcS5ZgkN511NEIZGEcuBp5g91801N1vSXhosV66hvTddqdrfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023

T24gNy8xLzI0IDA5OjIzLCBBbGV4aXMgTG90aG9yw6kgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTogSm96ZWYgSG9wa28gPGpvemVmLmhvcGtv
QGFsdGFuYS5jb20+DQo+IA0KPiBDb21taXQgMjA1YzUwMzA2YWNmICgid2lmaTogd2lsYzEwMDA6
IGZpeCBSQ1UgdXNhZ2UgaW4gY29ubmVjdCBwYXRoIikNCj4gbWFkZSBzdXJlIHRoYXQgdGhlIElF
cyBkYXRhIHdhcyBtYW5pcHVsYXRlZCB1bmRlciB0aGUgcmVsZXZhbnQgUkNVIHNlY3Rpb24uDQo+
IFVuZm9ydHVuYXRlbHksIHdoaWxlIGRvaW5nIHNvLCB0aGUgY29tbWl0IGJyb3VnaHQgYSBmYXVs
dHkgaW1wbGljaXQgY2FzdA0KPiBmcm9tIGludCB0byB1OCBvbiB0aGUgaWVzX2xlbiB2YXJpYWJs
ZSwgbWFraW5nIHRoZSBwYXJzaW5nIGZhaWwgdG8gYmUNCj4gcGVyZm9ybWVkIGNvcnJlY3RseSBp
ZiB0aGUgSUVzIGJsb2NrIGlzIGxhcmdlciB0aGFuIDI1NSBieXRlcy4gVGhpcyBmYWlsdXJlDQo+
IGNhbiBiZSBvYnNlcnZlZCB3aXRoIEFjY2VzcyBQb2ludHMgYXBwZW5kaW5nIGEgbG90IG9mIElF
cyBUTFZzIGluIHRoZWlyDQo+IGJlYWNvbiBmcmFtZXMgKHJlcHJvZHVjZWQgd2l0aCBhIFBpeGVs
IHBob25lIGFjdGluZyBhcyBhbiBBY2Nlc3MgUG9pbnQsDQo+IHdoaWNoIGJyb3VnaCAyNzMgYnl0
ZXMgb2YgSUUgZGF0YSBpbiBteSB0ZXN0aW5nIGVudmlyb25tZW50KS4NCj4gDQo+IEZpeCBJRXMg
cGFyc2luZyBieSByZW1vdmluZyB0aGlzIHVuZGVzaXJlZCBpbXBsaWNpdCBjYXN0Lg0KPiANCj4g
Rml4ZXM6IDIwNWM1MDMwNmFjZiAoIndpZmk6IHdpbGMxMDAwOiBmaXggUkNVIHVzYWdlIGluIGNv
bm5lY3QgcGF0aCIpDQo+IFNpZ25lZC1vZmYtYnk6IEpvemVmIEhvcGtvIDxqb3plZi5ob3Brb0Bh
bHRhbmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4aXMgTG90aG9yw6kgPGFsZXhpcy5sb3Ro
b3JlQGJvb3RsaW4uY29tPg0KDQpUaGFua3MgSm96ZWYgSG9wa28gJiBBbGV4aXMuDQoNCkFja2Vk
LWJ5OiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiBU
aGUgaXNzdWUgaGFzIGJlZW4gaW5pdGlhbGx5IGRldGVjdGVkIGJ5IEpvemVmIEhvcGtvLCBhbmQg
dGhlIHJlc3VsdGluZw0KPiBwYXRjaCBpcyBhbHNvIGZyb20gaGltLiBIZSBhc2tlZCBtZSB0byB1
cHN0cmVhbSBpdCBvbiBoaXMgYmVoYWxmLiBJIGhhdmUNCj4gc3VjY2Vzc2Z1bHkgcmVwcm9kdWNl
ZCB0aGUgc2FtZSBpc3N1ZSBhbmQgY29uZmlybWVkIHRoYXQgdGhlIHBhdGNoIGluZGVlZA0KPiBm
aXhlcyB0aGUgY29ubmVjdGlvbiB0byB0aGUgQVAgSSB1c2VkLiBUaGUgb25seSB1cGRhdGUgSSBk
aWQgaXMgYWJvdXQNCj4gYWRkaW5nIGRldGFpbHMgYWJvdXQgdGhlIGlzc3VlIGluIGNvbW1pdCBt
ZXNzYWdlIGFuZCBmaXhpbmcgd2hpdGVzcGFjZXMuDQo+IFRoZSBpc3N1ZSBoYXMgYmVlbiBkaXNj
bG9zZWQgdG8gbWUgZGlyZWN0bHkgdGhyb3VnaCBwcml2YXRlIG1haWwsIHNvIEkgaGF2ZQ0KPiBu
byByZWxldmFudCBSZXBvcnRlZC1CeS9DbG9zZXMgdGFnIHRvIHByb3ZpZGUuIEkgYW0gbm90IHN1
cmUgaG93ZXZlciB3aHkgSQ0KPiBkbyBub3QgbWFuYWdlIHRvIG1ha2Ugc3BhcnNlIGRldGVjdCB0
aGlzIGZhdWx0eSBjYXN0Lg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hp
cC93aWxjMTAwMC9oaWYuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9j
aGlwL3dpbGMxMDAwL2hpZi5jDQo+IGluZGV4IGQ2NzI5MzE0MmZmYi4uM2M0OGUxYTU3YjI0IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvaGlm
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2hpZi5j
DQo+IEBAIC0zODIsNyArMzgyLDggQEAgd2lsY19wYXJzZV9qb2luX2Jzc19wYXJhbShzdHJ1Y3Qg
Y2ZnODAyMTFfYnNzICpic3MsDQo+ICAgICAgICAgc3RydWN0IGllZWU4MDIxMV9wMnBfbm9hX2F0
dHIgbm9hX2F0dHI7DQo+ICAgICAgICAgY29uc3Qgc3RydWN0IGNmZzgwMjExX2Jzc19pZXMgKmll
czsNCj4gICAgICAgICBzdHJ1Y3Qgd2lsY19qb2luX2Jzc19wYXJhbSAqcGFyYW07DQo+IC0gICAg
ICAgdTggcmF0ZXNfbGVuID0gMCwgaWVzX2xlbjsNCj4gKyAgICAgICB1OCByYXRlc19sZW4gPSAw
Ow0KPiArICAgICAgIGludCBpZXNfbGVuOw0KPiAgICAgICAgIGludCByZXQ7DQo+IA0KPiAgICAg
ICAgIHBhcmFtID0ga3phbGxvYyhzaXplb2YoKnBhcmFtKSwgR0ZQX0tFUk5FTCk7DQo+IA0KPiAt
LS0NCj4gYmFzZS1jb21taXQ6IDIxY2ZiNzM1MTZjMTEyZjBjZjBkM2ViZDNlNGJkZmJhZGM4MTk1
NzYNCj4gY2hhbmdlLWlkOiAyMDI0MDcwMS13aWxjX2ZpeF9pZXNfZGF0YS0yMjIyNjMyMmVlN2MN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gQWxleGlzIExvdGhvcsOpLCBCb290bGluDQo+
IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9ib290bGlu
LmNvbQ0KPiANCg0K

