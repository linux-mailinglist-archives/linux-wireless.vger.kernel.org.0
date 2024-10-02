Return-Path: <linux-wireless+bounces-13394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751398CAD3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 03:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD407285972
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06328E7;
	Wed,  2 Oct 2024 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eWoAqmXv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEFB23C9;
	Wed,  2 Oct 2024 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832557; cv=fail; b=Wz2uX67eN3yWzIwgmukIG8KmaigT7XROQNW8Xe0xigWQbPW1a5xmzQYv+Ev0Evn8xPI+l35VCxqNQvuKCxBEYA5zQz2WXUhZPJZrN6ZalNPo1opAyy2ir6QL8mfh8BOAHp0GklUcfUZys9BzQqLP/2jvBet7S3HHYRmeoSdEvf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832557; c=relaxed/simple;
	bh=dEeQc/fNwEOe0LkeQ2c18IRcrXuFh6WOd3scgI/Pims=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u4jn2exiwVebCoKYH1Bvs4fmkiPw5BmsODmTrK32eA/su6VvdyBQqmbcPHJlmt1pn2iLoCSEIYOQfulF8aEdstsY9A4BKL/4h6y0oWA72f3YZjnC9QrrKMj3b7Tp5TlBwSdBwhPZfb3qjkKhEHJykEl6fJfulFVuJGji1VUVQDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eWoAqmXv; arc=fail smtp.client-ip=40.107.22.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBpbyzz+EHupbVJ6/B4bA2R6aBYcV1Ol0EGGJl7GFJEi0Sk5ED7/Ows97LaYuWko+kKtzRBK3uI1m1h/LufH4sxsjVihxIyjWmSOan+2HgtEEEDlynyLnrL1/e/vCgkzNH703BuogWvJeMwR2wnxOHIptubUMyoXP94i0Y7GItN06OIyygSsJMTWxrbBzusKMMdQzjsJuHBPv8QSMpohFDHbGmd4UiVAnh4Uug95FS/DllqA7//z9IES1gLwEJ7s0TBuyt31nUtAN2/LhdyPhDbP/n0dcHiOtMraM2nDoKXEV2/j7xlyUS0xUHPGcUWXCOCue8oPiSFtjUpX8NHJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEeQc/fNwEOe0LkeQ2c18IRcrXuFh6WOd3scgI/Pims=;
 b=XA3xOSEt6cI3eD0HPDZ/3uCauwgpe20UyFHmBQqTKy1ZsNTzCkpEWuWunDs+C3CFfBQbNs9PSEhvUi8Eea+AqzQd59QZupCNH/C33maDjkJeIQxa6P6DHzAp6+L1rOjK9arB4eRmqrFEp/BMvenHfRYZfZuL+qw1n6UDu7TyrMza6BfrRD2zG8KCCbsFSJCd0ECx7z2htFxnkn0jeZHmEsjJiibSnStHDMOVZPa/ofLJVBSpZKmS801yuGdHqa4lvytVwQWK5DGoqoMvPYR9LtJmneRjMD3qdXcyO7RD2IVIX0IbeQyZIPh2/c6pLOPacDK1dwQ8zAJeyPpvllfTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEeQc/fNwEOe0LkeQ2c18IRcrXuFh6WOd3scgI/Pims=;
 b=eWoAqmXvP9nyEYmqi7bghxxJN1I/voDE8yU9B/CTrTks5o24HeGmFJGPi/6XVSLRozpLkyooupYPTkWAm4Lc5pu0uh6x3KdCTutqrxoyinTRx28ZJv7ZzVe1kuNMxDMwTIugMHR7h/dCkmlNMOTdjfA87xWRPh3MQa4Rafy+fyXjeqJV7s0yurLkPibj/hTJhrJIP4gGUwKcnhtVfaKkoOjq64qnStgksHeHq3esv2TFmrSKx5Xmr8QraXlhVTtwRwUmwl7RMeUXGnLDfTxG1JngMKlV8n7J6+qrHqzMMm1xOuEzKoUOeTwi9tjg7PGuOj881Zkevh5ibD8JZ5CFqQ==
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB9178.eurprd04.prod.outlook.com (2603:10a6:10:2f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Wed, 2 Oct
 2024 01:29:11 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::f950:3bb6:6848:2257%3]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 01:29:10 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Reto Schneider <rs@hqv.ch>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Topic: [EXT] Re: [PATCH v3 00/22] wifi: nxpwifi: create nxpwifi to
 support iw61x
Thread-Index: AQHbEwMyNFUkvUYiK0iqRA5rNW1jCrJwAzIAgAKqpaA=
Date: Wed, 2 Oct 2024 01:29:10 +0000
Message-ID:
 <PA4PR04MB96380EE5216693C9CCE16030D1702@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240930063701.2566520-1-yu-hao.lin@nxp.com>
 <e93e1dd6-c215-4168-83e9-b8199599bc09@hqv.ch>
In-Reply-To: <e93e1dd6-c215-4168-83e9-b8199599bc09@hqv.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU2PR04MB9178:EE_
x-ms-office365-filtering-correlation-id: 24a4034f-4fb3-4104-30e7-08dce2819d92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEplVGRjVExzSkJHQmx6WnhJQTVrSjB2Y2JhZDViTXdiYjV4bWh4VzBZZ3dL?=
 =?utf-8?B?TjBUN2NISGtXbHArRGlhOHE1ZFVwZitJRjU4U3lLdURjalg0NkNOWVdnL1cy?=
 =?utf-8?B?RzB3SU56aXkxcEhwa0JBckYwVWNRWjMwamQvZXAyTGV3OTNZbzVUZkFjOWUr?=
 =?utf-8?B?dURIRktwRzRLTkFCWGZ0Qzd6bDB4Z2ZDbUZTRmZKNDVOL2dvbFZRNDgwbkV3?=
 =?utf-8?B?alIwV25ta25UaUF2RU5kUzNzb2d5VGsxUUxhYlAzTDJNKzE3TkdLRlRLZHVp?=
 =?utf-8?B?WUp6V1AwR3V5MmZLUmxrQWs4UWFYbjFqRnRRaW53UVpla2tBbnY3UElNWW5J?=
 =?utf-8?B?S3p5SGJEOVEvZUhldTF4ZHhZci9MZzRybFR4UUNzVGhwc1BLbnZKbS9wbm5r?=
 =?utf-8?B?by9XT1FHNlgzTktNWG4vajU5Zm45ODlxU0NuVXM5aDluUVZvS1NpM2dGOVJq?=
 =?utf-8?B?bUl2TVdsUmpEejlSSzc5c0l0amtJZEJuSlgvOCt5NmExQmllT2loUFJ6Tis4?=
 =?utf-8?B?TGNNNHdkS3J0OVFRYi93RU8zUGd5L05wL2VPdEhQK1RhMG94ZkR1MmpXRlhD?=
 =?utf-8?B?VjlzQzZ3SGhxNWg0VjM4UHdYQlR3bmEvQ1dESmxZUzgvcDlJNWt6alI0aWxi?=
 =?utf-8?B?ZDBzR3lPRnpKVkxldURjdUd2ZmhtMjZHSXN3Ui9hZU1QRHhVcXl0YUtNbG52?=
 =?utf-8?B?M2twVk9jd1lENnhtODZKRWRhZmt6VSt3L3Y4ME1qQkhLUDZURGRRa1dxcGJH?=
 =?utf-8?B?azV1c2M2Tkxqc1pxWnlOTUVLdTdFdVMvSGdwanl3REhrdHRCWS9lK0dmdFEr?=
 =?utf-8?B?M1lENGNPRXBZYVl3YzJOQUxtSDRvVjdpMUhYOGt2UDNYNFFEQ0liVUVOWHNx?=
 =?utf-8?B?T2N1ODV5KzJBMGlhTm9ZZ1dpdWhzeEt6MDhTU25HelFmNXByR2Q5VXlYcmV1?=
 =?utf-8?B?ZE8vNHZVTGhVeG80cmQwek41eENldTJ3cnJocTNTa2F0YWV2Smx0ajlYTDh5?=
 =?utf-8?B?dFlJbjcwQmsrajhEMG1IZ05LT0tiM3U2TWNWNXlvQ3ExUk9SVGQwb3B0bjdL?=
 =?utf-8?B?UTZtQkZNdm9XZFZpU3h5YjkxL043UjlaZUZmY2dPWmxtL0t2V0U0RnF1dmIx?=
 =?utf-8?B?cnY3WVNiVkZlL1N6YkFKbFZCYXFwYmk3QkFsN1RhSnI2aStrQVdxSnFzdzVa?=
 =?utf-8?B?RGlUTnIyV3o1MTM4WE84NHVOVm1HK3lVdFFYK3VDNUpTNzRxVE05TlR4UE9u?=
 =?utf-8?B?OHFOaDdPSEJucklDbThRQWpwZ2FmSFA2VUxqYWpiV0NxTUlYT2VnOGgxbnZJ?=
 =?utf-8?B?aCttcktWa3k4REtucjlUZ1JGak1TZHdlRis3VGhtZHgyd3BFdFNWblpoV25l?=
 =?utf-8?B?ZXd1VDhKaG9jR01mT01kRGpEeUdZdzl3c0c4QlY3R2huUXFMRkUvMzZVRlNV?=
 =?utf-8?B?RXpPK2Z4bVcveXJrenBlSkxpTE5zekt2T0FIQlB4UnVkcmNFcnJXemZCTVoy?=
 =?utf-8?B?enBmckFuZU9DeG5DamgrUFV4dHA5YU5XSGVEa1J5eERFSEtqNHJhbUFFRmt4?=
 =?utf-8?B?RmJQdFcybXhqMGpZcTJNbkxWSlhNbmhKVU5obG1qSkZDTlE1clZGVm81QXlU?=
 =?utf-8?B?cWZSYkdUVHE4c1ZJZklHSUtXYzJKTXFJWjMxeWtBa3B4cXRIV0JENXVuU3M2?=
 =?utf-8?B?MDVSVXVmdFNLaXJtd0pFUnM3RU5mRGRSdkhvTk1KRWlxdHJzWC9EZEg5M3NJ?=
 =?utf-8?B?cGUzMHBCSHVSK3Q3OUVjalhmb0l2M2hoTUpMeldKSVBKQTBJSnZscVJhZWJw?=
 =?utf-8?B?Z25HL0NwY3hJQlFCVkd4QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlJXNXZvTXhGZDFudnlrVmhEbTF2R1E2bDBCWnpLdldDTEhCMS95SmpvdGh2?=
 =?utf-8?B?V1NyVTdEbDZYN1NGZWIwR0gwSlM3ZDlubWxKNzhJcVV0SnVuQWYzakZWTXVQ?=
 =?utf-8?B?QmJ3YUxlOWhKS2xJL2psREF6QXNiQTZVUGkrQVA1ZWt4ZWFyRUJQTkttcEVU?=
 =?utf-8?B?NWMzV1BqQVlaOVpSNkcrQWk0WDNuZTZadEVna211elR4SUZkeTBGcElQMzly?=
 =?utf-8?B?SERMQXMydFVvM1lYRnRyNXYxb3RlYU54eWN6cytBYjZ0M2pnMU9WOGtKZjNn?=
 =?utf-8?B?MURWTmFlU2hDZlhRS3NVVXZLajc2SFUxWkx3TmUrRkM5VFFiR3hhNWo1SG9X?=
 =?utf-8?B?Mzcxa0NLNGRMbE4yVE51TFNjU1l4a2xtVzhudVl4eTk2TkVqSUlLekYrSDIr?=
 =?utf-8?B?cUpGNmc1SDE5ZmZKQzZHT2UwL0ZxR1l2RFNlWnRlU3BzbkwzbGdDY1JpNktL?=
 =?utf-8?B?ZWJmdGdVVEdVQ014eUZWaERKTHl2RFpEZXhVbXlyTzMwV0hmRlc4RHhwVkQ0?=
 =?utf-8?B?VjNQK2NlaHk4TjNyV2owUkJmd0FtWmYxQTJqMkEveUZQSHE4RnVBOXJuTVc2?=
 =?utf-8?B?UEdIS0NoamN0MnJaSTEreG8vd21JTEd2VWpnMUdRaEdEbmNObHhHem1NZThQ?=
 =?utf-8?B?T3lISHhXcFRzV2NlNjRVcFZ3Z0FEN2xCK2h1bTN0OEpXa2t6ZjJUMDl3b1BI?=
 =?utf-8?B?RXhycnJ0SjVEeWZzcVh2T0NXSGJVUlZZMzdMK2hCZzVaVHVhcEdDcnR5Z3Vr?=
 =?utf-8?B?SWczVG81eWwxQ1U2QXNabEZCL1dxaGdYNnZNeHd6YjhXOUYwSU80S1lvQlJS?=
 =?utf-8?B?RkxkYytldFJ2eGZNOWF6bTRKYnRnTTc0RGttdVNPZS8zQ1VGcE1MalhLL3FH?=
 =?utf-8?B?cXM0S3N1YUZHaUViQlZiNmtNY1RWRGM4dE1ocDFXU0lJOE1mem52WjQ3K3dY?=
 =?utf-8?B?eEZNZWNLU2ZYQVhBaFRueGRPQS80ZG42R0k0bjNXWEZpT0dlSHVIN0Z4eis4?=
 =?utf-8?B?RHFBTGFTTmRENnlmZzdqenAvTFNRYVJxTkx3WEdYYWMyWFFuTVNlc3JyU2U2?=
 =?utf-8?B?LzRreElCT2NSQ1c1Y1RPQVZXMmk3Y3BWSCtySDZkR0NMQ0xaZktRRU44Sk10?=
 =?utf-8?B?U3FVeStSRlVXdWo3N0ZuRXFLNkpBeFhBa0htUjZmR2s2RTZiZVlXdS9XNTNP?=
 =?utf-8?B?M1JtQW9nNi9keENvV0ZRNDJFaHUyTHRualZXMmY2QlFSU1JzTkJkclYrQWpI?=
 =?utf-8?B?KzRVOVQ0NFU5V21KSFZydXFHTEJIUXpjOTdZZHR1czlUTmU1TWMxdllPU1Z6?=
 =?utf-8?B?UXFacTRLTDhLcU96VWpSTHNUYW1mYnVNaEZkdWoySTdFRTE5Y2JVRkFVeElF?=
 =?utf-8?B?WkFDNGI5amhzaEhwMzdKK2x2cDZLNEIzejRkaWErOUpLektDTjZRRVYwUmk5?=
 =?utf-8?B?R1VLUjNpWDN3SllUYUl2VlZzbmZOQkhqNDFFNTJidmhEalBjVzlaSFJIc2lY?=
 =?utf-8?B?L2VKeUVVcURMdS9kb3hodzNFK25KdVlENk5hSHYrOTRVM3k3Y0dUN29tT1lD?=
 =?utf-8?B?c3pXcTg1Yyt1NkFoZkVnUmVPVFI3L2dXU3NvWjNhekpaZDExalNHQWRVSnZT?=
 =?utf-8?B?TXdJWHNYcXp6Wkg2aTROcGQ1SVYvam5EaDhjb3FxOG9wMnpEOU9QVlBLZFMw?=
 =?utf-8?B?R1JZOE9PZVoydW96cStlem9HTlJSUGpxV0hzcFlqQ1lGNFduYUJxbCtidUdX?=
 =?utf-8?B?dEJCSkZpRXdmM1hvZTljUGw5WGV6TWZIWVBaSjhzR0Y1eE8wRWQrcnNGc1Jv?=
 =?utf-8?B?MGlCQ0xxYXFBK2xHM2ZZbThZNlBReGJHMENTR0VpaGZuNndSVGU5UDRDNmlw?=
 =?utf-8?B?cDRnTVNGdEMwaVEvejhLdDlGb1MwRHBMWXRkSEpVUElNWHplS2JVMlZBNDlB?=
 =?utf-8?B?a1BWMExyaWZUYXdtUlREY2d5Vmg4SnpyZ3hvUnFScHdISVl5SGhRbldPNzgz?=
 =?utf-8?B?emo0MHBoaS92VmxHM0VVTitjM2VjTHR4RWR4VHBjUFhPU3AzemY4SnVNK01u?=
 =?utf-8?B?YmhOeFNMTTJpNU5uejlDUW9Lck13WlA3b0JFTkVzeFIvbWdiV2dKRnBiZGNk?=
 =?utf-8?Q?d4MwletP8CSgMVUNFia/YUZjX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a4034f-4fb3-4104-30e7-08dce2819d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 01:29:10.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtS9pI2oUHik281wFxZzJANKM8aS4YlOY4czYqcZp7BWPJonJAzVpwIMmPS1t75XlQGpjEPedRAocz26fhN8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9178

SGkgUmV0bywNCg0KPiBGcm9tOiBSZXRvIFNjaG5laWRlciA8cnNAaHF2LmNoPg0KPiBTZW50OiBN
b25kYXksIFNlcHRlbWJlciAzMCwgMjAyNCA0OjQyIFBNDQo+IFRvOiBEYXZpZCBMaW4gPHl1LWhh
by5saW5AbnhwLmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnOw0KPiBr
dmFsb0BrZXJuZWwub3JnOyBmcmFuY2VzY29AZG9sY2luaS5pdDsgUGV0ZSBIc2llaA0KPiA8dHN1
bmctaHNpZW4uaHNpZWhAbnhwLmNvbT47IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVj
dDogW0VYVF0gUmU6IFtQQVRDSCB2MyAwMC8yMl0gd2lmaTogbnhwd2lmaTogY3JlYXRlIG54cHdp
ZmkgdG8gc3VwcG9ydA0KPiBpdzYxeA0KPiANCj4gSGkgRGF2aWQsDQo+IA0KPiBBbnN3ZXJpbmcg
aGVyZSBiZWNhdXNlIGFuIE9FTSBwcm9wb3NlZCB1c2luZyB0aGUgSVc2MTIgaW4gYW4gdXBjb21p
bmcNCj4gcHJvZHVjdCBvZiBteSBlbXBsb3llci4NCj4gDQo+IE9uIDMwLjA5LjI0IDA4OjM2LCBE
YXZpZCBMaW4gd3JvdGU6DQo+ID4gWzFdIFdlIGhhZCBjb25zaWRlcmVkIGFkZGluZyBJVzYxeCB0
byBtd2lmaWV4LCBob3dldmVyIGR1ZSB0byBGVw0KPiA+ICAgICAgYXJjaGl0ZWN0dXJlLCBob3N0
IGNvbW1hbmQgaW50ZXJmYWNlIGFuZCBzdXBwb3J0ZWQgZmVhdHVyZXMgYXJlDQo+ID4gICAgICBz
aWduaWZpY2FudGx5IGRpZmZlcmVudCwgZG9pbmcgdGhpcyBvbiBtd2lmaWV4IHdpbGwgY2Fycnkg
YSBsb3Qgb2YNCj4gPiAgICAgIGJ1cmRlbnMuIFRoZSBlZmZvcnQgb2YgbWFraW5nIHN1cmUgbm8g
cmVncmVzc2lvbiBpcyBhbHNvIGEgaHVnZQ0KPiBlZmZvcnQuDQo+ID4gICAgICBXZSBtdXN0IGNy
ZWF0ZSBhIG5ldyBkcml2ZXIgbnhwd2lmaS4gU3Vic2VxdWVudCBOWFAgY2hpcHNldHMgd2lsbA0K
PiBiZQ0KPiA+ICAgICAgYWRkZWQgYW5kIHN1c3RhaW5lZCBvbiBueHB3aWZpIG9ubHkuDQo+IA0K
PiBBcyBkZXZlbG9wZXIsIHRoaXMgc291bmRzIGxpa2UgYSBodWdlIHJlZCBmbGFnLiBJbiB0aGUg
bG9uZy10ZXJtIGludGVyZXN0IG9mIG15DQo+IGVtcGxveWVyLCBJJ2Qgb3Bwb3NlIHVzaW5nIHRo
aXMgdHlwZSBvZiBoYXJkd2FyZSBpbiBvdXIgcHJvZHVjdHMgZXZlbiBpZiB5b3UNCj4gbWFuYWdl
IHRvIHVwc3RyZWFtIHRoZSBkcml2ZXIgKGFzIGlzKS4NCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4g
UmV0bw0KDQpNd2lmaWV4IGhhcyBiZWVuIHB1dCBpbiDigJxPZGRzIEZpeGVz4oCdIHN0YXRlIGZv
ciBxdWl0ZSBzb21lIHRpbWUuIA0KTm93IHdlIGhhdmUgcGxhbm5lZCB0byBhZGQgc2VyaWVzIG9m
IG5ldyBjaGlwcyBhbmQgZmVhdHVyZXMuIA0KQWx0aG91Z2ggc29tZSBvZiB0aGUgY29kZXMgYXJl
IGZyb20gTXdpZmlleCwgd2UgZG8gc3BlbmQgbXVjaCBlZmZvcnQgdG8gZW5oYW5jZSB0aGUgRlcv
ZHJpdmVyIGludGVyZmFjZXMgYW5kIGEgZmV3IG90aGVyIGFyZWFzDQpPdXIgcHJvcG9zYWwgaXMs
IG13aWZpZXggY29udGludWVzIHN1cHBvcnQgb25seSBleGlzdGluZyBkZXZpY2VzLiBOZXcgTlhQ
IGNvbm5lY3Rpdml0eSBjaGlwcyBhbmQgZmVhdHVyZXMgd2lsbCBiZSBhZGRlZCB0byBueHB3aWZp
IG9ubHkuDQpXZSBhcmUgYWxzbyBjb21taXR0ZWQgdG8gcmVndWxhciBRQSBhbmQgbWFpbnRlbmFu
Y2UgZm9yIG54cHdpZmkuICANCg0KTWF5IEkga25vdyB3aGF0IGlzIHlvdXIgY29uY2VybiBvbiB1
cHN0cmVhbSB0aGlzIGRyaXZlciBzbyB3ZSBjYW4gYmV0dGVyIGFkZHJlc3MgaXQ/DQoNCkRhdmlk
DQoNCg==

