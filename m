Return-Path: <linux-wireless+bounces-11996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C855695F566
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FED728249A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF6C193416;
	Mon, 26 Aug 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yKkGsamQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C119306C;
	Mon, 26 Aug 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686956; cv=fail; b=rQqeF/cbMQtaDymWUjygGYJ1j5VrrZ0C9lXEu8BaWVbWnVe6Q+0oCTKrSt5GnnetaldYzg7yXvZZMt+hcfUNaWsTpA4Gddq/d1GN8fMfZykYpAZIwOOIpP6+SPH5NaabcDkiIMT99RwSKGHoikLuyZQh37pp9waZT77JJAP7YGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686956; c=relaxed/simple;
	bh=54+OW9qPb2nACoHd2v1K6wTVrI4nErhEXmQ10IKsX8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdyGztl2HVz0buPu8CN2ohSilzb3s/VsRHlhA901/qD26W3VKUFN7MMB9vgj6RwG2Gz+nujBBEkPs7huG/iCQu+4VIThRVjbnm0/kwqI+umRirUCANbRXGyj7KQ7+k9rs7yyGIigc9Z1w8ynpQ1HBSfeX7W61kD87iLznnmlc20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yKkGsamQ; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAzw5UI/+inL8VOjL/cUsqZby+vVfMbXNKVsRIoP3w9HB0mQX+z1+Jp+wqxw/jMwPk2pBLRl1EKDNfTAVvjB+7dAclCq+Jsmcm2RRpH5gll2lxaH1DSXhRlE1MuomzJxPLnI/kT2Ab/5sxVKliDUQWohDxldADgqUk2zNs1zauBa579Dah6B8TmVewENq8ckRcsSKaqppX7HEOnqagifBDDtDnemcX8VjAA2abUBE9G6sRQu+Ryn568Cr4Hq8k5x6sQ31bo65FrV7ZbYtfKmOqze78wJ3LvlElfKCIuOA9cZ6QA5EkJ05YPxL2dyTKLTe2kUe6pqDvw13Idu/Vgmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54+OW9qPb2nACoHd2v1K6wTVrI4nErhEXmQ10IKsX8M=;
 b=Zd4d1k0/cbhtW/hqAy+4KUNC8dSIv4umQhxmnyTTpZuy+kIIs1Sf3k3XlkoGDsvxka4isjmOb66mkeY0WbHuRoqRG451Z0S9FMbfYo3XqunghzyN9acqsQs2Vc8bV+9eSLR6rRXOfLq1Z3HSA30fKOWyZPDR1tjpdXw3e30eMg4tHM7eixlN3MbK4RaYK/rfijXcHeGZtunJwjTMvclsYEoOybXpl/egdFygbd2pckI5scPnTNN8SfMwBh3cAHfxOPDRWPH5FrKRZFly5EA6px+6+iyB3xQ9JAy7VYN2RLOP2iYTTI51aqx/ByV8H8DphAYJ0/2cMfZqOZ/NujziVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54+OW9qPb2nACoHd2v1K6wTVrI4nErhEXmQ10IKsX8M=;
 b=yKkGsamQBuyTSpJS0DQvpz9Gv/S5wqfSPB5lT+1ZXXorSBjxRc7DPrPZvld/yl2vmjDp2m0Vmzf6iQ2WVcQ4DRWNV00FOYNiHNU0uSRkfsaPBhiSFLyTfwG1IqSi37ofRZgEYPgtcAPLfl0rJu9ZmhRWSJZpimXNm+/VIETEzky1f0syduRR/XtwCs0KeaDN5ChaLtQaBuTdUk6jCxLudK5Zad+saB/KCrR6Al8GLV/03x2XoSeY/xVb7sHV/2w9DrwS8s4zzbaBzicz0beNR1Z9k4n1sM/bdajC/ZbTGUrLo+wVUA9lB0HHhkL8TVYl74522FUlXUVWV2GHIRuddg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB4PR10MB6917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:42:29 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:42:28 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"jerome.pouiller@silabs.com" <jerome.pouiller@silabs.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "dmantipov@yandex.ru"
	<dmantipov@yandex.ru>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: wfx: repair open network AP mode
Thread-Topic: [PATCH] wifi: wfx: repair open network AP mode
Thread-Index: AQHa9V6F2AsytMDZyUaSKfiA10tTFrI5qe8AgAAIboA=
Date: Mon, 26 Aug 2024 15:42:28 +0000
Message-ID: <6fcd665d7c11dcde939ccf82954959298371dffb.camel@siemens.com>
References: <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
	 <13597832.uLZWGnKmhe@nb0018864>
In-Reply-To: <13597832.uLZWGnKmhe@nb0018864>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB4PR10MB6917:EE_
x-ms-office365-filtering-correlation-id: 927c17d2-5229-4ca6-55fe-08dcc5e5b119
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUNEVE1YbEZpK0xhdU91ZDQ1MktUMTlaeUFML3V2eC9GME5ZQ2t0Y1ZRYXZV?=
 =?utf-8?B?aitWNWhoSEEvb0R0SkVFT1lOa2plS0lkaXR0Zm56REd0c3U4LzVrTW9xNjVy?=
 =?utf-8?B?Z2ZVcVlhMGZuOG5TTytEME5jLzhscEJhUkV0aWVxbUo5dGViSVFIUHozbGZF?=
 =?utf-8?B?dWEyUE0rQUtrelBRMUd2VFFrTGQ3VTVTRmYzN2IzZTU3cE5BMDB5dklNQ2JH?=
 =?utf-8?B?eHdjTFlQMTN0T1lWOTE1ZjhYZWdqQ1YrR2YvWDQ4K2NRV1cva0M2a2xtT2Q3?=
 =?utf-8?B?NHFTdStPWWcxbXdtdkwvZURNWS9JRjNoaytYemdJM01mTUV6cFFUV3p2RFRR?=
 =?utf-8?B?TEJYNjNpaUxKRTR6TVRtZ3RGS1VFWTBLb3ZTbHpwaUZ3M0dLdVB0MHprb2ti?=
 =?utf-8?B?QjRGdEN0Y1B5alNuRjNCNEI5cTZpV1B4dnpNVmlYWlF1ck55bGZsT2ovZlp4?=
 =?utf-8?B?VHBPSnVOb09WbndWNm8zTnUzNDJHVFB1b3owRlJPVy9tWE40dlBYODF6M25w?=
 =?utf-8?B?TzZFanFMRW1ESE4rUXRId2JPVUxaN0QvU3hGSFA4UEZvY3B0clhPb2c4eUZY?=
 =?utf-8?B?Z1FaTWxGOFVZcTdWV016ZXQwNFFhL2E2WkRJV1lKZTRaV08veU54UENzdUpj?=
 =?utf-8?B?MXRlR0VLVWhkYU5Fc1diOTRkMVcvVlJMNHgzQy9hdzlsRU9ONHMxV21zbS8v?=
 =?utf-8?B?Rm44V2JKemk2VTdCRlRXTDBlUTZHUVIxcnFpaEZRaTJkYklLM25BOVQ4WDZw?=
 =?utf-8?B?WnFxQTV6bDVwbU0rY1B5TTNMWGl2dGV5MlZvM3J1SmFLZWo2Tlo0UENGVWM4?=
 =?utf-8?B?VGZWWWZvcnMyejUreHQ3NndTYTNQRDBsS0hkc3RKdzNJR05GRWdqMmMzZWM0?=
 =?utf-8?B?Y2VKcHRLRk1YRlVoa2RMMjNBbnAvUVNNQVN1UzJudHV1eFYxSHRaV04vekds?=
 =?utf-8?B?Yi9VU0tEcGVOdExwcDR5eUFMV0U4WVdkSmo0Tm1USTEyaCtadk5BU2hUZGY1?=
 =?utf-8?B?NUl0MVpPQnhXV2FRWWhsSXNTK1FSdlNmMFU4ODErS3plazhNV0lOdHZOdVkz?=
 =?utf-8?B?TFJUbGxuQTBhbTJsVlgvcTEvTUptTnFxSEZVd0k1a0NMTVpiNU9mZnRyOUJr?=
 =?utf-8?B?SEVsVGN3a2pUOVE3WVlaV2EyOHhuZWtwbUtGcjdTSmxzVDRyWkNhNkFkb2hk?=
 =?utf-8?B?TVJUNHhGM3lqSzd5eG5zRmo2SHhFNzU2REpuLzJvOWZUUjAxZkdscmZ5Y1My?=
 =?utf-8?B?aFN4SFlQejhuamNyUEdxckU0aFJ4RHRzbGhROWtLZmFXN25uR0NwVXNNc1I3?=
 =?utf-8?B?a3VteDc3Q2Z1SThKL1I1OHU5OG0rZjZNNUhPZmFTeUN1SGNpL2JRSE1yY2xp?=
 =?utf-8?B?bURzenpkNmozejNtTDJMV01VUSt5ZXJmWkwrTzJIVFl6ampQUkh5ZkFraHZL?=
 =?utf-8?B?c2xxQ3RPZ3ZpWFlrdm1UdDJlblNhdnBCZGxQdXYyc0x3NDRaK3NMK1ZMc1Zh?=
 =?utf-8?B?Z3RCNkNuRXQvNzFVUW53YmFtajZ0RXdtSitPS0E4R2tiL3JESzVJSzFqODdm?=
 =?utf-8?B?YjFqVzNDREJ0STNYNzlQbzdDSGFmVVRlTW1nRHhJeXd5cVRDNVhMZ1FxSVgz?=
 =?utf-8?B?RS85NzZUOGFrOGlMMkEzRTBLQnJhWXVacGR1Z2pNNHRlbkZpaE1TMUhaSkpm?=
 =?utf-8?B?ZHdoTXZOTXJ2TXhpSG52MzVvVnUyWTNkSk5yZ3UwRW4xWmc4VDQ4RXVXNnFN?=
 =?utf-8?B?eEk1anRyNWtzVFlGSE8wNk54NGxKUDkxbDN3TWl4dXh2Rld2NEc3QU11eVIy?=
 =?utf-8?Q?sjcwZr2/V3LFdV0OHIMW2Po8u4d5eCq9HAYa8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGFnZlN4OEd4Z3BrampaMm5lTzYwSGE0SnFkSVE2ZXFTazQwS2J0V1ZXQ2l6?=
 =?utf-8?B?WWd0RXNMam41d1pqbENtWGZRdWkycHVIa3NBeFBHbVZGZUN1RDlIWWdTT0c2?=
 =?utf-8?B?N1UrbG5mTDh3SWRoa0J5SVNGREo0U0laZ1EzUW1pSHhDTUdJeHNZVDFEUFdN?=
 =?utf-8?B?Z3E3WXk4WWFydU1pOE4ydUNLQVJOQVJoSkREZE5kT3YwNjU4QkowY09FeUd3?=
 =?utf-8?B?UUFINXIzRkFLeTNGYnFwNjZhMVNVMWY1bm4zYUlaRlMxYUdxQXZta21yTVJH?=
 =?utf-8?B?eU54YVpGL3BQWlg4eS9QN2MxVVVGa0dzb1VEQmVhUzh3cEg1RndCRXdVN1po?=
 =?utf-8?B?RDdycHNwVllWNSs3M3ZiNERXV0xseUZUTUYxL0hNUmpXNFEwZjMwTkJRWlZk?=
 =?utf-8?B?U3lXRzYxUWVGblVUcW54MVBySVpRdmxLNE14MG9vZ2pvS1J3MEJ5eFNseFVO?=
 =?utf-8?B?b3FNQ1pxS1R0VnQ0S2REeDcyb2FiSFc2Y3RwZmFUdWNMc2NtZDR1Z3YyTThX?=
 =?utf-8?B?OU5TdjkwaUx1bmJhYldGZjBBZE04bHpncTZOYkhiQ04zNVVmQ3FsRmVKWTV5?=
 =?utf-8?B?MTIwWmNTTXoxUUdKYktpVHUzbHB2eU8yNEFqa3gyMWZoOU1NVkdVeXZDVW40?=
 =?utf-8?B?U2J4NW9mK1pobytHclg1clRoWmlYT29LdFJ3ZWY0UDlGNzU5UEVodEd6bHBT?=
 =?utf-8?B?NDQzdnF5WXFtSnV6YkdnY3BBSnlYNHEybEhBSEFqdjdOKzM5UmY0cUlQUGNS?=
 =?utf-8?B?eGJ0ekVhcHVHNWx3RVB5UWxxcElzRmg0Z3RiTWZNakg3VWQwbWY3S0V5Y1BP?=
 =?utf-8?B?clAyUXF5U0hxd3FhQ2JESFY0ak1xODVJZ1BsRnBDVlU4SWFwOFg4TURBdlg2?=
 =?utf-8?B?eU01aHlLbzJKTEhSWFJwR25yVkNTV1ZybW14eFFtTm9vaVBYMVBqK0hUY2NY?=
 =?utf-8?B?bWJTNEM0Mk9tcnhLQ1RuRXhMWkhYVzMyRjRic0NDMHpGV1RMdHcvUk9vUUhI?=
 =?utf-8?B?RVQwM1BDM3F0WmtvbVBuWS9CRGNoSDB3YVF0K2xlV0VRSW5vTStiMjBhYWsy?=
 =?utf-8?B?NVA2dEZ2MXp6NzZqZFRQcFVoaXJGN3B5bzhSVmp6U1lKQURKaTN6bUw4aEY1?=
 =?utf-8?B?bmxmNkptc2MxKytFcXZVSHcwUzB6VVdQTTBua2Y1Z3hQdndsZ0dsWktpSEdS?=
 =?utf-8?B?WmY1bVFZRUhIVXM3bXFobzhOdDN3ekZ4enRERjdIUDRraTRDQ3lCK28yMlVw?=
 =?utf-8?B?cVFPYjJnbDh6Z1I0eGEyUDgwQk9WbVM1cjQxcDdLZVBFM2dJbzFGTnp0RDdy?=
 =?utf-8?B?TEtyRVpPRTg0T3hSbFZod3BpZEVWbDNPSjlUZjYyeFNpWHlSMkcxbEhVdjFE?=
 =?utf-8?B?VmpaVmt0dVhMbFJVYzdPYmlCYkZ2MkpWNHYvTUtBakR3MjVaNXdCaWI0bnZn?=
 =?utf-8?B?VWt1bnNCSjZINE1hRFlpb3k2WEU1US9uWlcvZm9vajlCLy9EVlNQRUswNGtW?=
 =?utf-8?B?RW1GTStnZkdtYmJldnJkcWRNN0pXNk5aRks3bnU4QjVSY29Oc05sV1BTWjVj?=
 =?utf-8?B?dkh6M1BXZVJsZ21BQVhwdkJBLzFWQTVzWW9Scy8xcElLOEc5bTkwVWVGR3RW?=
 =?utf-8?B?SGIxZEg4dEg0NVhHUjYxNkpQUVZ3S3VRYWZReklHeU9iMFNMQ1FzSThkVjNJ?=
 =?utf-8?B?ME40QVJncU9pZ0Z3bTBhNXZBaEQwNXM1bDdRdTRqU1JEcU55OXlSdTFqV1p6?=
 =?utf-8?B?czg4Mi85WnBiQWNQUVFtOGp1NUVXQllhb3czZ1R1N1YyUzRsc1lNOGNqc1BN?=
 =?utf-8?B?RUZYb2xKOWozNFlKTkhHQlB6SlNLb2JoekFWZUdUY08waXVtRnZlaVdXRmx1?=
 =?utf-8?B?Y2ZDQStGZmc0MjRsZGMvK2ZoVkRiSnVkeDRxR3hvMEhoNzRLUjk5Wm5XemJz?=
 =?utf-8?B?R21JK0JkTnNEOUtkZGw5M3RIdjZpQzF3dXBsNzcrZFhzbEMwbmFuZnFsMFdY?=
 =?utf-8?B?cUprL2F2VXBQeS83Z1A1dTBlcGEwSGgvTFRveWJNdzFQQ01qWEk2ZUJidldV?=
 =?utf-8?B?eUF1bGZuUTFnanhyaERYV0xQN0xwbGxiTFFLMWMrS1BSU1d0Tkp5RXpncU9X?=
 =?utf-8?B?NUh6bFRyUC83eUsxTjBvNWplTUJ5U213Y3dTcXFCZEgvTFJPb3RQYjRUTmhB?=
 =?utf-8?Q?OE5j7KpxHfzuyQ/CBChJYWk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <017C127E69211540A4390F1BF08C7B2F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 927c17d2-5229-4ca6-55fe-08dcc5e5b119
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 15:42:28.8932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uv2KPvDomBjcM+ERobAdAeRiYZkQCOXZJiV577gD4+IDMBO64MtO3/RMqk4vN7pUh9MrOQGNMJujA+/EGm5a6X0kTtNbRU1jNft3GJYuImU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6917

SGVsbG8gSsOpcsO0bWUhDQoNClRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIHJlcGx5IQ0KDQpPbiBN
b24sIDIwMjQtMDgtMjYgYXQgMTc6MTIgKzAyMDAsIErDqXLDtG1lIFBvdWlsbGVyIHdyb3RlOg0K
PiBPbiBGcmlkYXkgMjMgQXVndXN0IDIwMjQgMTU6MTU6MjAgQ0VTVCBBLiBTdmVyZGxpbiB3cm90
ZToNCj4gPiANCj4gPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxp
bkBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBSU04gSUUgbWlzc2luZyBpbiBiZWFjb24gaXMgbm9y
bWFsIGluIG9wZW4gbmV0d29ya3MuDQo+ID4gQXZvaWQgcmV0dXJuaW5nIC1FTk9ERVYgaW4gdGhp
cyBjYXNlLg0KPiA+IA0KPiA+IFN0ZXBzIHRvIHJlcHJvZHVjZToNCj4gPiANCj4gPiAkIGNhdCAv
ZXRjL3dwYV9zdXBwbGljYW50LmNvbmYNCj4gPiBuZXR3b3JrPXsNCj4gPiDCoMKgwqDCoMKgwqDC
oMKgIHNzaWQ9InRlc3ROZXQiDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBtb2RlPTINCj4gPiDCoMKg
wqDCoMKgwqDCoMKgIGtleV9tZ210PU5PTkUNCj4gPiB9DQo+ID4gDQo+ID4gJCB3cGFfc3VwcGxp
Y2FudCAtaXdsYW4wIC1jIC9ldGMvd3BhX3N1cHBsaWNhbnQuY29uZg0KPiA+IG5sODAyMTE6IEJl
YWNvbiBzZXQgZmFpbGVkOiAtMjIgKEludmFsaWQgYXJndW1lbnQpDQo+ID4gRmFpbGVkIHRvIHNl
dCBiZWFjb24gcGFyYW1ldGVycw0KPiA+IEludGVyZmFjZSBpbml0aWFsaXphdGlvbiBmYWlsZWQN
Cj4gPiB3bGFuMDogaW50ZXJmYWNlIHN0YXRlIFVOSU5JVElBTElaRUQtPkRJU0FCTEVEDQo+ID4g
d2xhbjA6IEFQLURJU0FCTEVEDQo+ID4gd2xhbjA6IFVuYWJsZSB0byBzZXR1cCBpbnRlcmZhY2Uu
DQo+ID4gRmFpbGVkIHRvIGluaXRpYWxpemUgQVAgaW50ZXJmYWNlDQo+ID4gDQo+ID4gQWZ0ZXIg
dGhlIGNoYW5nZToNCj4gPiANCj4gPiAkIHdwYV9zdXBwbGljYW50IC1pd2xhbjAgLWMgL2V0Yy93
cGFfc3VwcGxpY2FudC5jb25mDQo+ID4gU3VjY2Vzc2Z1bGx5IGluaXRpYWxpemVkIHdwYV9zdXBw
bGljYW50DQo+ID4gd2xhbjA6IGludGVyZmFjZSBzdGF0ZSBVTklOSVRJQUxJWkVELT5FTkFCTEVE
DQo+ID4gd2xhbjA6IEFQLUVOQUJMRUQNCj4gDQo+IEdvb2QgY2F0Y2gsIHRoYW5rIHlvdS4NCj4g
DQo+ID4gDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBGaXhlczogZmUwYTc3
NzZkNGQxICgid2lmaTogd2Z4OiBmaXggcG9zc2libGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl
IGluIHdmeF9zZXRfbWZwX2FwKCkiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdmVy
ZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+IMKgIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgfCA1ICsrKystDQo+ID4gwqAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYw0KPiA+IGluZGV4IDIxNmQ0M2M4YmQ2ZS4u
N2MwNDgxMGRiZjNkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93Zngvc3RhLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0
YS5jDQo+ID4gQEAgLTM1Miw4ICszNTIsMTEgQEAgc3RhdGljIGludCB3Znhfc2V0X21mcF9hcChz
dHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZikNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgIHB0ciA9ICh1
MTYgKiljZmc4MDIxMV9maW5kX2llKFdMQU5fRUlEX1JTTiwgc2tiLT5kYXRhICsgaWVvZmZzZXQs
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBza2ItPmxlbiAtIGllb2Zmc2V0KTsNCj4gPiAtwqDC
oMKgwqDCoMKgIGlmICh1bmxpa2VseSghcHRyKSkNCj4gPiArwqDCoMKgwqDCoMKgIGlmICghcHRy
KSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogTm8gUlNOIElFIGlzIGZp
bmUgaW4gb3BlbiBuZXR3b3JrcyAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldCA9IDA7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBmcmVl
X3NrYjsNCj4gPiArwqDCoMKgwqDCoMKgIH0NCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgIHB0
ciArPSBwYWlyd2lzZV9jaXBoZXJfc3VpdGVfY291bnRfb2Zmc2V0Ow0KPiA+IMKgwqDCoMKgwqDC
oMKgwqAgaWYgKFdBUk5fT04ocHRyID4gKHUxNiAqKXNrYl90YWlsX3BvaW50ZXIoc2tiKSkpDQo+
IA0KPiB3ZnhfaGlmX3NldF9tZnAoKSBpcyBubyBtb3JlIGNhbGxlZCB3aGVuIG9wZW4gbmV0d29y
ayBpcyBzdGFydGVkLiBOb3JtYWxseSwNCj4gd2Z4X2hpZl9yZXNldCgpIGlzIHN1ZmZpY2llbnQg
dG8gYXZvaWQgYW55IHNpZGUgZWZmZWN0IHdpdGggcHJldmlvdXMgY2FsbHMNCj4gdG8gd2Z4X2hp
Zl9zZXRfbWZwKCkuDQo+IA0KPiBIb3dldmVyLCBpZiB5b3UgZG9uJ3QgbWluZCwgSSB3b3VsZCBw
cmVmZXIgdG8gY2FsbCB3ZnhfaGlmX3NldF9tZnAoKSBpbiBhbGwNCj4gY2FzZXMuDQoNCkknbSBh
IGxpdHRsZSBiaXQgY29uZnVzZWQgYnkgdGhpcyBjb21tZW50Li4uIFlvdSB3cml0ZSAid2Z4X2hp
Zl9zZXRfbWZwKCkgaXMgbm8gbW9yZSBjYWxsZWQiLA0KYnV0IEkgc3RydWdnbGUgdG8gZmluZCB3
aGVuIGl0IHdhcyBsYXN0IHRpbWUgY2FsbGVkIChmb3Igb3BlbiBuZXR3b3JrcykuDQpOb3Qgd2hl
biB5b3UgdmlzaXRlZCB0aGlzIHBhcnQgb2YgdGhlIGNvZGUgaW4gY29tbWl0IGI4Y2ZiN2M4MTlk
ZA0KKCJ3aWZpOiB3Zng6IGZpeCBtZW1vcnkgbGVhayB3aGVuIHN0YXJ0aW5nIEFQIiksIG5vdCBp
biBmZTBhNzc3NmQ0ZDENCigid2lmaTogd2Z4OiBmaXggcG9zc2libGUgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIGluIHdmeF9zZXRfbWZwX2FwKCkiKS4NCkFuZCBldmVuIG5vdCBiZWZvcmUgdGhl
IGxhdHRlciBjaGFuZ2UgKHNheSwgZmUwYTc3NzZkNGQxXik6DQoNCnN0YXRpYyB2b2lkIHdmeF9z
ZXRfbWZwX2FwKHN0cnVjdCB3ZnhfdmlmICp3dmlmKQ0Kew0KCXN0cnVjdCBpZWVlODAyMTFfdmlm
ICp2aWYgPSB3dmlmX3RvX3ZpZih3dmlmKTsNCglzdHJ1Y3Qgc2tfYnVmZiAqc2tiID0gaWVlZTgw
MjExX2JlYWNvbl9nZXQod3ZpZi0+d2Rldi0+aHcsIHZpZiwgMCk7DQoJY29uc3QgaW50IGllb2Zm
c2V0ID0gb2Zmc2V0b2Yoc3RydWN0IGllZWU4MDIxMV9tZ210LCB1LmJlYWNvbi52YXJpYWJsZSk7
DQoJY29uc3QgdTE2ICpwdHIgPSAodTE2ICopY2ZnODAyMTFfZmluZF9pZShXTEFOX0VJRF9SU04s
IHNrYi0+ZGF0YSArIGllb2Zmc2V0LA0KCQkJCQkJIHNrYi0+bGVuIC0gaWVvZmZzZXQpOw0KCWNv
bnN0IGludCBwYWlyd2lzZV9jaXBoZXJfc3VpdGVfY291bnRfb2Zmc2V0ID0gOCAvIHNpemVvZih1
MTYpOw0KCWNvbnN0IGludCBwYWlyd2lzZV9jaXBoZXJfc3VpdGVfc2l6ZSA9IDQgLyBzaXplb2Yo
dTE2KTsNCgljb25zdCBpbnQgYWttX3N1aXRlX3NpemUgPSA0IC8gc2l6ZW9mKHUxNik7DQoNCglp
ZiAocHRyKSB7DQoJCXB0ciArPSBwYWlyd2lzZV9jaXBoZXJfc3VpdGVfY291bnRfb2Zmc2V0Ow0K
CQlpZiAoV0FSTl9PTihwdHIgPiAodTE2ICopc2tiX3RhaWxfcG9pbnRlcihza2IpKSkNCgkJCXJl
dHVybjsNCgkJcHRyICs9IDEgKyBwYWlyd2lzZV9jaXBoZXJfc3VpdGVfc2l6ZSAqICpwdHI7DQoJ
CWlmIChXQVJOX09OKHB0ciA+ICh1MTYgKilza2JfdGFpbF9wb2ludGVyKHNrYikpKQ0KCQkJcmV0
dXJuOw0KCQlwdHIgKz0gMSArIGFrbV9zdWl0ZV9zaXplICogKnB0cjsNCgkJaWYgKFdBUk5fT04o
cHRyID4gKHUxNiAqKXNrYl90YWlsX3BvaW50ZXIoc2tiKSkpDQoJCQlyZXR1cm47DQoJCXdmeF9o
aWZfc2V0X21mcCh3dmlmLCAqcHRyICYgQklUKDcpLCAqcHRyICYgQklUKDYpKTsNCgl9DQp9DQoN
CldoYXQgZG8gSSBtaXNzPw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0K
d3d3LnNpZW1lbnMuY29tDQo=

