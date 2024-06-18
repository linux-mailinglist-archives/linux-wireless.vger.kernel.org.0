Return-Path: <linux-wireless+bounces-9195-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D443790D3B2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1542871EA
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B82139C1;
	Tue, 18 Jun 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="OvpqATay"
X-Original-To: linux-wireless@vger.kernel.org
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2099.outbound.protection.outlook.com [40.107.135.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE13149C63
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718998; cv=fail; b=nqzrq2ZDzfxu1Ea0Lp6a++4HUrxoxbqhDtZen8CVZeUtEfo0iNKvZg/U09rqBCpo/o4IdTJlOUx8QQ0Jn4dWWJ1ptzHXVFcZlnr7zMwL5em6/uGc6PsffN9K+XqwtvqzBR9QsjJT5lzFTHwL3VNvmbvKFDwCa/mrfC2t8axvLB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718998; c=relaxed/simple;
	bh=h9IBTwSymiuSgcxXH80mC7mVTwKOiDhKwjQcV7gk4Is=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ad0OD2I8ctmsbgEJc+VWya71xPGm0z2QBTVYoSZzflt1Ay+IWuENkK1OfLmPpouOYEMIVTq3LVzWxFtQV0h9Qoc1Fp4WViGmx15IliI6U/5/n2mlwKv3QbycLs3iXzmLV2WxVr8malkHolKfUHHtHnJK29hJdvd9TWCxjmj4ccE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=OvpqATay; arc=fail smtp.client-ip=40.107.135.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk08mzM/CFFbW5kLAdtrXYOT2SY2yvGdsALg4Gk3ZF3IxGr/SMBjdGPoBGjuV+f5zt2O5svo9xBkpW/ctYTCzuxOZWBjeqUzeN5Vz7GE0Ae0HUpHOmXG49N8J6TrtCH0VwDKeBSZWnIQFYZH77NqMUXpg4FLJiioJ9ptu4/ClMDBzoUxq0toty8JYIBxHQylF9u9GbTbS+Hn54L9Ox/W1hD7gpsdA0rQaExBA3cdnQ9EoEC7nCO2V05ToNjlDoLSyq1uZADT2SusLbF44W2m+xVOfm1EfEjPepldm0qcDEgUIQpc8Xbu86DR8347t+hswvXqene0wLaMaD1bYuVi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9IBTwSymiuSgcxXH80mC7mVTwKOiDhKwjQcV7gk4Is=;
 b=OecjSKhGEmqiDsOEZpvseflrbyhMnm0BqFktkwAO62nfHEA6qLlL9Va4A8tqRw+DKNEN+4EtUsJdnTJ5Ukp5eUj/TtHoeQXjOKHKDZ0zuMR5szQp9ROboBC+AkjE0giYpP2otN1CJVxS8m6Q2RpgmjL1PBGw2gBgOw7sL89j/WSTHx7em9p7Pe4kpFHs2YoEnRrtUc90jFO0fnFevgHjQeAY9ctvNHlJfqXc46m/qYebSWRjpAPRO0zPoIfr7VREP34TPHlRekN3ycWFN1c8yI21OQn1gZ/3tzmU+KtcBk2XZlcoL5DMrNAybQ+L92fAELu1j1tqaRkGU8JPIbzMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9IBTwSymiuSgcxXH80mC7mVTwKOiDhKwjQcV7gk4Is=;
 b=OvpqATayJjZwgIehLIKD9gzyRD+PSm+ZkI3T5oDHyAieVwSVOk29g1I1i+tJHP+KxpHQQCr4gKRWjNxOe35tNT5lqCIP6+yTJNTAi5A+RU2Laz1iByQDJ16WlMxyNIjiSU6FoHqUF+kLL0n4zOOjc3B4sLPlYI1Y7N/IrvO6JRoq+Yqc1r4rU/aD0tp3W5zyl9cXyodQKwu4I/T81V2jjYxsaxi1vS7OEj+i1ymR5gO3jCrHdh6UgyJ/wgL1qvNhA/KtknCg0dduUgEGYb/6FyWsFpDqkgTpW61UhhgIGTx8TnW+z21X+sgnKRh4nCYZ6Eykw6CUjTVUUsGwoh+H+A==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 FRYP281MB3034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Tue, 18 Jun 2024 13:56:30 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:56:29 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Le Suire, Michael" <Michael.Suire@Softing.com>, "pkshih@realtek.com"
	<pkshih@realtek.com>
Subject: RE: wifi: mac80211: unencrypted message in 4-way handshake
Thread-Topic: wifi: mac80211: unencrypted message in 4-way handshake
Thread-Index: Adq7OqrIXwNmhc6ZT92PlJydhITGNgAAMsqAAC1j+AAAAr9O0AAAxQYAAWIOgSA=
Date: Tue, 18 Jun 2024 13:56:29 +0000
Message-ID:
 <BE1P281MB2420B8A0493568084C9F119FEFCE2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB24208AB02DAEACAE9AF4B5C5EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	 <BE1P281MB2420DA2C6AFF94E525306302EFC62@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	 <6bdbcae5cfedccc507426bde60fe86e72212ca5a.camel@sipsolutions.net>
	 <BE1P281MB242075CF50BF71257D14F955EFC72@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <bf445f8aa320858124368a210b5cb86a9613b44b.camel@sipsolutions.net>
In-Reply-To: <bf445f8aa320858124368a210b5cb86a9613b44b.camel@sipsolutions.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|FRYP281MB3034:EE_
x-ms-office365-filtering-correlation-id: 2b4e58c0-f7ae-46b3-7635-08dc8f9e7448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFBueTljUHliNVc2UnhBWEdIUlpWNTIyVkZpTzZ0Yk9SN0V1L1VVY3J1QjRp?=
 =?utf-8?B?N0VFOTNPTkFZY0FEdGVsMXQyQ3BCb2JaNUp5Y1Bpd1VSWkxFK3VDd0RIdEpt?=
 =?utf-8?B?NWRTZ3V3TFU2b0JsZG1yNGdwZ0Q1QXQ4RjdPLzFUeUF5UnBWMTVWUmZQNEpw?=
 =?utf-8?B?dStvR05WYWt1d0VWbEUzeVFpMkFld3NvUGRibnlvMlJxNjdnd3FFUlAzNzhp?=
 =?utf-8?B?QjZWVDVnTkI4TkpOemgyRFlkTEMwYUVlV3NZQk10UURnazFoTTlTRnFXNzdM?=
 =?utf-8?B?bk4vWGFEanpWeldRMWFSRld3bkVqcVZnb0JKTHpiSkNUYUw1OGhSR1FJUWsy?=
 =?utf-8?B?NkxFRG9hZW40Z213YkVPcHM3RlR1a1N5bmlFbWpPb0ZqRmd1TDJOeGR1SHlV?=
 =?utf-8?B?anVKNnozSWNJQXN5YWJtR1NPWE1OTmkrV2ZJZUYzK1o2a2lSUHJjT1NNV3px?=
 =?utf-8?B?RTRhT0tKY1owdExuV0hwWnlETHp4VUpPaTRVNStzNFNXQ2p1bFZZbXRzOXl5?=
 =?utf-8?B?WExQa2F2SW1hbkJOS0UyR1BseEdkWndHY0xzdnE3OXNtek81STY1TWtPYXg3?=
 =?utf-8?B?Ymo0KzJvdjAvY0RNVEJsQnR5Q1lLVExjNDRwQjFMd1ZCcytBb2ZQSUw4Q1hw?=
 =?utf-8?B?djlxbmdMaEpmU3pIK20zMTVBWFpqaFcydmozTDR2UGk5a01TWTZib3pSOGdu?=
 =?utf-8?B?Q0hxRWdGZk9rTllVc3FFT1ZwNnJyeFVtVE01MUlxYkk5RXJIMjhhL3dvYWU5?=
 =?utf-8?B?YTQyQVpDV1V2UWdJUi9Idmc0ZUxhd2o2YVppVWxsRkJaVWpDRXpUMFRFVGpT?=
 =?utf-8?B?NlM1RzB6T0lrZXRlMGVhcE94eFFmai9DRGhwNDFnK011UUpmQjQvaXMxK3lC?=
 =?utf-8?B?U2tYdEFxalRndk1jRU9uMHd0NFh1TWc5a3RRMm81T282NnBzUjFkTncrQmUy?=
 =?utf-8?B?cGNndEhSZEVEdWc5VDNpTGl4WStpVk0xMGVyV0YzQzlZc2ExNCt4ZEN5cmwr?=
 =?utf-8?B?ZjgxajRTZktJMlZqNTNBZkYvb1RsY2lIU1dOd0kvMGt5azF2N0srMUdGUjY5?=
 =?utf-8?B?dGdEVFo0QitjczNObWRUdHc2all1VHRIeENDdlJWM1NPWXM2ZVloL0NGSjVW?=
 =?utf-8?B?NlJEMnJhYUpibGcxa05rZU1LVlFtMXNJOEFlczM4ZVJ0eHJ4WG9TMG9RQmdI?=
 =?utf-8?B?R3lkWTVQNDBxOGZwaU9PM1JHTzRwS2NLRmZySkJHSGkrRFNSYkdMWldYTXMz?=
 =?utf-8?B?TUp0Unkra3hwRTBmK2VMNHlmcTFiZWlJNU5xTHNnQUpwSmp6K2NoOEhsdUkw?=
 =?utf-8?B?em5LTVZzVytJV3p4RGNlQjFVNHRvU08vUWNYNFNiNnRoLzBpZUt6WTZCQVNW?=
 =?utf-8?B?WmovNjl6SWkyeGdCK2s1UkJlaU9QQlhEL2VTdzJXNC9vZXE2bVRDU0hMbk96?=
 =?utf-8?B?QmFweDFXODJFVEtPRVY0aWxSeHRRM3E5NnZOd1RCNU1LRHBQR0laTHQzNjh0?=
 =?utf-8?B?cGdHM2dYY200V3VFaHI3M2FVM2tDMVdlNENvRWd4NFVFR0dnbGMyMkl1YTdk?=
 =?utf-8?B?ZUF2TlRtcWJBN0t3bW1UbkRiZTRtTUVFM25mVk5YK0ZNbVdOa2hiK2hxNXJ5?=
 =?utf-8?B?Ukhaa2RnVkNEdWRITlBkRnYrbFA5cUNBRWw5a3dDZDduaHpCelF0UytSVFFo?=
 =?utf-8?B?L0RJeWRhMTdMZk1YUHZoUThRMHFKZUlnalZsS0VIWS9aMXhWQ0VSMWVqTWdJ?=
 =?utf-8?B?OXovL3ZCUEdNMUhsQUhibHZqYXJTZnlROXdRTFoxRkthbVBTR1pIY21qOXpz?=
 =?utf-8?Q?KuddoIypnuPfEE0foCoElXEryHp9tGxhKrG6Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SjBoQVloSXk5VndERUNiS3FkdzIxOTJTWVhVeDZteTVIZWZwWmREWjNYL0pP?=
 =?utf-8?B?OHc1VW9KN2ZqT3ZQNXNrNVBHQ0ZzRWM1dEM3TnQxcjc4dkFyUkRLVEFmU0Jq?=
 =?utf-8?B?U2REYnpGazdJYjZ1RWpORjg2NmxScnQ5SmlycW0vbDQ5cnl2c2cwWnQxQmtj?=
 =?utf-8?B?Nzc0Y2FaLysyTmx3aTVxTHBJZEpFVlhDelhPbUEwY3N3b1NCUkZSTU80SXQ0?=
 =?utf-8?B?YkdSSmJxUTZKeGRvdWtqK3Bzb1BGQiszRFJWaHpUMVowSm5JZk04YnE0UDhX?=
 =?utf-8?B?dkI3QW5QbVRtd0o1Y3lSRkFkd2ZvZ1FTbW00NGN5M3RKazZHa0dDUFdEcTNh?=
 =?utf-8?B?KzFnQmNXUkNoQ3pPQUpXMUViMmpGZGxoNVBnT25aV0lnYUNUTnkwOFdXekhy?=
 =?utf-8?B?eDRzTCtuRWEwaVlLbkMyU1gyKzNwektlTFpwMG95OXNjVFA4UGM2d0VuaDM3?=
 =?utf-8?B?WHFKUjFyUHRrdk1neXZYUHloTzI5K0ZmeHl5Rkw1MFJtVm9WNkFIaGgrSTRl?=
 =?utf-8?B?UFdnNXpERXZ1Nzd0RDUzbkVNTmpPdGRXS0IyOGU1NG5XaXZGbkJSSEtON1kz?=
 =?utf-8?B?RXlXYy9LN0JZRDlyR3NGYzZGcERtNnVrZ1J1TTU3aHNRRmtjbGZpckNEQzRV?=
 =?utf-8?B?UXVMWHNMNGVLNVpDWTZZWHVLNldmbGwvNGx0VlNsK0NWelVXQTJmVDhQeUFy?=
 =?utf-8?B?REFyeTZMQ3g0NGZ6UGxnZXhhRERrL0xQKzJEUkhkVUppSFA2ZjdrRmZlWTdi?=
 =?utf-8?B?RjRJNGxPSUg1V0ZCc09ZbVd1U1JEeWVHNThISGVVaUFLVlR5Wk1DdnlSZUFO?=
 =?utf-8?B?MzF4TUM3Z3ZmVnNBM29QbVJLOVQ4U0xkM0d1dDZ2N2oxSGFQUzhkK1RkdnV0?=
 =?utf-8?B?ZDNEWVdFRnoxVU9ZZUI2NXkxZEVVUGk0Y1NEUER1a2Vod2dMbkdqWjh0R1pE?=
 =?utf-8?B?L0JNOGRNelFXL0FhU09TVWNoZEs5OUppVk5UQ3A4TXdtWmlvVjk2MGtIWlNJ?=
 =?utf-8?B?WVFSUFpvc0taQ2sxbmhsNi92V0pjRGpqZm1Ja0I5Skhqc0NqK0t2bnNVcUdv?=
 =?utf-8?B?NXpJbGxkUTBXdXRVWGJnTk4yRENtU1R1c29ONmVkdWR1U0Z2NjlsaUJxMm9E?=
 =?utf-8?B?N2dSYklpKzNyMWY4Qmc4cGF3RE1ISHdWN29Yc3pPWlhNK1E3bFB3dE1VKzZl?=
 =?utf-8?B?Y05hSWpKT21aS2RQZkxneXdkeFdVRVNUQTVVWXdtYTlhUDNkeUM1em5XazBt?=
 =?utf-8?B?ZjljQjYwMENYbExZVE0yaTAxQlhHeTVPVmtQRnZodGVTQXVuRDh0Qk9qNHp5?=
 =?utf-8?B?TE9KNEtibTQ0QW5hUEpseXo0S3c2dEJNK3M0Wlo2bkNlNGFUTnBncVZaN0JK?=
 =?utf-8?B?RTJKaHA3ZkZvMHR1a2s0ZHI1RGxhekpSRDM2T01IL1ZOWk0wby9Qa1FBY0Zz?=
 =?utf-8?B?TzVXOWxCOWZJMWF0Z2NVRnNkY3h3blZ3WE1SYTgrSHlqTFJoZThKYjVuOFNU?=
 =?utf-8?B?SURPMUxRaXdjR1JlM3hDZmtEUlU0TUZOSGF3RjdvV1QrUXk3YWVKMFRCcXUw?=
 =?utf-8?B?WVRDSHBncnBZSEYzTmRod1J5RTdMUjloWk5FV29McmUzV21UaXdncEEyekM2?=
 =?utf-8?B?dDZoY251Z203VDRBaWwrK2FpYzVodFdQRVFjeTNWL2hLYVlSQlgvenJsZk1j?=
 =?utf-8?B?RVVvMjVpTVhOdlFlTWJ4QVc5aFk0VWpzSlptVExaSkZ3d3l6cDNLTzFBeTlT?=
 =?utf-8?B?cHRRcDUvZVJCeWw2aEJCUW9kWS9PaEJ2WEVNd3Z1RnBUcHM2MmFXL0dMZ1Jp?=
 =?utf-8?B?ckhaenVsSjBhVWYzVDBHVHBxWG5WZnhnclZyempLaEpjMlkxbkppNmNvZTRQ?=
 =?utf-8?B?L1YxQjQzc2ZRWlAyTURucU9CYXNwR0xCL1p5TEMxcXQ2WmV4d01HK3ZUL04r?=
 =?utf-8?B?WTJtNlVQTy9NRHgwbVg2UVJhUlJNTDZRRXpSVnRxdExIbjVCS0JKa3g0cTUv?=
 =?utf-8?B?cE5QcHdEbkFPM1lUQllPWGd1L3NiQ2VKYjQ3V2t6dWF1UlJjM0dFeHE4c2U5?=
 =?utf-8?B?S1VqQjJBU3N0NlVNNjNWb3Q3bmxlMHV1RVlsYzhuZHpNdUpySFpmTHJ1cFpq?=
 =?utf-8?Q?xgCjj4Uzzr60rCa3va2ViN+sy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4e58c0-f7ae-46b3-7635-08dc8f9e7448
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 13:56:29.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDm4WUF8FIEP3/voRpzEGS5j5KHGKOLRnZARBb8phBbDMyPecxNs6/IOYNwTPlRYvxbSL/4kcQ8qkTiPKIw3nf8H1pyVPY+MtL+C4ch9TyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3034

PiA+ID4gPiByZWNlbnRseSB3ZSBtb3ZlZCBmcm9tIGEgNC45IGtlcm5lbCB0byA1LjQga2VybmVs
DQo+ID4gPg0KPiA+ID4g8J+kr++4jw0KPiA+DQo+ID4gOkQNCj4gPiA+DQo+ID4gPiA+IERvIHlv
dSBoYXZlIHNvbWUgaGludHMgd2hlcmUgdG8gbG9vayBhdCB0byBzb2x2ZSB0aGUgaXNzdWU/DQo+
ID4gPg0KPiA+ID4gTm8sIHdheSB0b28gb2xkLg0KPiA+DQo+ID4gVGhhdCdzIHdoeSB3ZSBhbHNv
IHRyaWVkIGl0IHdpdGgga2VybmVsIDYuNiwgd2hlcmUgd2UgZmFjZWQgdGhlIHNhbWUgaXNzdWUu
IFNvDQo+IEknZA0KPiA+IGFwcHJlY2lhdGUgaGludHMgZm9yIGtlcm5lbCA2LjYgKG9yIHByb2Jh
Ymx5IGxhdGVyKSwgdG9vLiA6KQ0KPiANCj4gWWVhaCBidXQgZXZlbiBtb3ZpbmcgNC45LT42LjYg
aXMgYSBodWdlIHJhbmdlLCBldmVuIGJpZ2dlciA6KQ0KPiANCj4gPiA+IFRha2UgYSBsb29rIGF0
IHN1cHBsaWNhbnQgbG9ncyBpbiBob3cgaXQgYmVoYXZlcyBkaWZmZXJlbnRseSwgSSBndWVzcy4N
Cj4gPiA+DQo+ID4gPiBUaGUgb25seSB0aGluZyB0aGF0IGNvbWVzIHRvIG1pbmQgaXMgdGhhdCAq
bWF5YmUqIHRoZSBlYXBvbC1vdmVyLW5sODAyMTENCj4gPiA+IHBhdGggZ2V0cyB1c2VkIChkaWZm
ZXJlbnQga2VybmVscykgYW5kIHRoYXQgaGFzIGRpZmZlcmVudCBiZWhhdmlvdXIgaW4NCj4gPiA+
IHdwYV9zLCBidXQgaG9uZXN0bHksIG5vIGlkZWEuDQo+ID4NCj4gPiBUaGFua3MsIHdpbGwgaGF2
ZSBhIGxvb2sgdGhlcmUuDQo+IA0KPiBJIHdvdWxkIGNlcnRhaW5seSBob3BlIHRoYXQgd3BhX3Mg
dXNlcyB0aGF0IHBhdGggb24gdGhlIG5ldyBrZXJuZWwuIEl0DQo+IHdhc24ndCBpbiA0LjksIHBy
ZXR0eSBzdXJlLg0KPiANCj4gam9oYW5uZXMNCg0KSSBndWVzcyB5b3Ugd2VyZSBvbiB0aGUgcmln
aHQgdHJhY2suIEZvciBub3cgd2UgZGlzYWJsZWQgdGhlIGNvbnRyb2xfcG9ydCB2aWENCmRyaXZl
ciBvcHRpb24gaW4gdGhlIHN1cHBsaWNhbnQgY29uZiwgYmVjYXVzZSB0aGUgd3BhX3MgbG9ncyB3
ZXJlIHBvaW50aW5nIHRvDQp0aGF0IGFuZCBub3cgdGhlIDQvNCBmcmFtZSBvZiB0aGUgNC13YXkg
aGFuZHNoYWtlIGlzIGVuY3J5cHRlZCBhcyBleHBlY3RlZC4NCg0KTG9va2luZyB0byB0aGUgc3Vw
cGxpY2FudCB0aGUgcHJvYmxlbWF0aWMgY29kZSBpcyBpbiB0aGUgZm9sbG93aW5nIGZ1bmN0aW9u
Lg0KV2hlbiBXUEFfRFJJVkVSX0ZMQUdTX0NPTlRST0xfUE9SVCBpcyBzZXQsIGR1cmluZyByZWtl
eWluZyBhdCB0aGUgdGltZQ0Kb2YgZnJhbWUgNC80IHRoZSAobmV3KSBQVEsgaXMgbm90IHlldCBp
bnN0YWxsZWQgYW5kIHRoZXJlZm9yZSwgbGVhZGluZyB0byB0aGUNCmZyYW1lIGJlaW5nIHVuZW5j
cnlwdGVkLiBUaGUgYWRkaXRpb25hbCBjaGVjayBmb3IgUFRLIGJlaW5nIGluc3RhbGxlZCBpcyBw
cm9iYWJseQ0KdG8gcHJldmVudCBzb21lIHJhY2UgY29uZGl0aW9ucy4gQXQgbGVhc3QgdGhhdCdz
IHdoYXQgSSB0aGluayBhZnRlciByZWFkaW5nIHRoZQ0KY29tbWl0IG1lc3NhZ2VzIG9mIHdoZW4g
Y29udHJvbCBwb3J0IHdhcyBpbnRyb2R1Y2VkLiANCg0KaW50IHdwYV9ldGhlcl9zZW5kKHN0cnVj
dCB3cGFfc3VwcGxpY2FudCAqd3BhX3MsIGNvbnN0IHU4ICpkZXN0LA0KCQkgICB1MTYgcHJvdG8s
IGNvbnN0IHU4ICpidWYsIHNpemVfdCBsZW4pDQp7DQpbLi4uXQ0KCWlmICh3cGFfcy0+ZHJ2X2Zs
YWdzICYgV1BBX0RSSVZFUl9GTEFHU19DT05UUk9MX1BPUlQpIHsNCgkJaW50IGVuY3J5cHQgPSB3
cGFfcy0+d3BhICYmDQoJCQl3cGFfc21faGFzX3B0a19pbnN0YWxsZWQod3BhX3MtPndwYSk7DQoN
CgkJcmV0dXJuIHdwYV9kcnZfdHhfY29udHJvbF9wb3J0KHdwYV9zLCBkZXN0LCBwcm90bywgYnVm
LCBsZW4sDQoJCQkJCSAgICAgICAhZW5jcnlwdCk7DQoJfQ0KDQoJaWYgKHdwYV9zLT5sMikgew0K
CQlyZXR1cm4gbDJfcGFja2V0X3NlbmQod3BhX3MtPmwyLCBkZXN0LCBwcm90bywgYnVmLCBsZW4p
Ow0KCX0NCg0KCXJldHVybiAtMTsNCn0NCg0KQ3VycmVudGx5IEkgZG9uJ3QgcmVhbGx5IGdldCB0
aGUgcmVsYXRpb24gb2YgUFRLIG9mIHRoZSA0LXdheSBoYW5kc2hha2UgYW5kIHRoZQ0KUEVBUCBz
ZXNzaW9uIGtleSBvZiB0aGUgVExTIGhhbmRzaGFrZS4gTGF0dGVyIGVuY3J5cHRpb24gc2hvdWxk
IGJlIGFwcGxpZWQNCmluZGVwZW5kZW50bHkgb2YgdGhlIFBUSyBiZWluZyBpbnN0YWxsZWQgb3Ig
bm90IG9yIGFtIEkgd3Jvbmc/IFNlYXJjaGluZyBpbg0KdGhlIElFRUU4MDIuMTEgc3RhbmRhcmQg
ZGlkbid0IGhlbHAgbWUgdG8gZmluZCBhbiBhbnN3ZXIgdG8gdGhhdCBxdWVzdGlvbi4NCg0KU28g
SSdkIGFzc3VtZSB0aGVyZSdzIGEgYnVnIGluIHRoZSB3cGFfc3VwcGxpY2FudCBvciB3aGF0J3Mg
eW91ciBpbXByZXNzaW9uPw0KT3IgaXMgZGlzYWJsaW5nIG9mIGNvbnRyb2xfcG9ydCBhbHJlYWR5
IGNvbnNpZGVyZWQgYXMgYSBwcm9wZXIgc29sdXRpb24/DQoNCg==

