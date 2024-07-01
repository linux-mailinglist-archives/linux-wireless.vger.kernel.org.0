Return-Path: <linux-wireless+bounces-9761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9815A91DD41
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 12:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0541CB23D5D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F0B13BC3F;
	Mon,  1 Jul 2024 10:57:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE012E1EE;
	Mon,  1 Jul 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831463; cv=fail; b=OAFYEP+08oH2RQ6okoNHM6BzMk7msDBRLQW6vUM6T2TzBhU9tzYgRoO3tzgHEt5TJvKSyB0sbUdov06bOpJbPa/VFXcS6YKO7K17d1mCdJpHmrbHuwDVw2iN1kZxPj+hVtLmMWJQC5P67mcIAO7Yy3fj5573Rx5PQ6G2+I1iSHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831463; c=relaxed/simple;
	bh=Khq2M4qcB5kzjYt5Quhh412n1XKuuZfvddGbD2fQxpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L41gJfJXy7BHbCGU6foeg3EwbbbxhzDl5QwqffQ4KtLIJbNWitlEH03kDQgoewCFO8wUBBvNg87PgqhtNsi88Wff4gXAGdQTubu1R/oFBITYPwhWALXaiyT4qtO//ej+cl/U7jf0nVS8TP45ochwgw6dWn8kO253LkUgzbM9WqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNlklQMAMregoX/Y/On2Wi8YXlePDsgRSpkSSTUah3e1sQtKfAd83zBfyLDe3CDvqBcGbgRi50qEaaSp/ZaicQCkd5MXLpGW3erkj1XxtjqVXPS4k1H9xC2NvfyulzlqrOR2RTzYUANz2+9MND/0/C0TSxeNHd6B6yPUZ08PF8KeYsc0cI0sQRfr4t34IG1KcR/ceX2RP6WTAYmOTueie+m3HB34cMAbgHPMPO9w8StM3ob4wbtfAf05+HUjqJXcSkH7tU6+qiWBoeYBdLGJkg9Q8mNgRk3zrEiszYyKhKujdVUYj7bFNUNZU1ZplwyNYtrSKmj1+sDF9blis0LHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Khq2M4qcB5kzjYt5Quhh412n1XKuuZfvddGbD2fQxpk=;
 b=CAQnQ0jEOIZFDduKgnZERneI/HfC3U7WQtaI+eNGCZXqf5A37Xugr/gWW6a4mWTJn1VC2hxICzNYqq+QYgUhtlOxqcb1gpAzg2bctsqMjm23LEe7Ibz0MrBY1t53SjpxSl1GllAJV90jC1OvO2CHb+VF1ToWHHePlOxAe7+V/wJzIx6/FsxoHe7/+VwV+qK4ewJ2oi6+BgFMfsfMYMkfGryT6Ag1NHwvXh+26GkkgOLTYBQNy6ZjJeZ6JIdPDMKkXvJafcMh8iVACt/3u9wwbCXMOOjwY7vb8HKotEYF3hbo53csn6te8+2O8D0O7f3iGYaOT0TEbSHJukoyzIfAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8308.apcprd03.prod.outlook.com (2603:1096:820:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 10:57:36 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 10:57:36 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, Stefan Wahren
	<wahrenst@gmx.net>, "wens@kernel.org" <wens@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "efectn@protonmail.com"
	<efectn@protonmail.com>, "dsimic@manjaro.org" <dsimic@manjaro.org>,
	"jagan@edgeble.ai" <jagan@edgeble.ai>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arend@broadcom.com" <arend@broadcom.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz"
	<megi@xff.cz>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "minipli@grsecurity.net"
	<minipli@grsecurity.net>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, Nick Xie <nick@khadas.com>
Subject: Re: [PATCH v3 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Topic: [PATCH v3 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
Thread-Index:
 AQHaysA7C3v/Z5nX1k2k1WM+yxb95rHf/Y0AgAAE1WqAAAQUAIAACvGAgAAQFgCAAZAOPA==
Date: Mon, 1 Jul 2024 10:57:36 +0000
Message-ID:
 <TYZPR03MB70011B5F10967EAD64FE499780D32@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-5-jacobe.zang@wesion.com>
 <bd661690-1de8-4030-a209-ef26d3559221@gmx.net>
 <TYZPR03MB7001AC28827A86338BF2B77380D22@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <CAGb2v66Vk8SMs1TOs+80Jy5fXumuYqCx59Tzd_N7wJAfyysQcw@mail.gmail.com>
 <8e44631c-955f-42de-bb2f-f3a32c79f1c1@gmx.net>
 <19068c5ae00.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <19068c5ae00.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|KL1PR03MB8308:EE_
x-ms-office365-filtering-correlation-id: ce7aadbf-fd1a-4e03-d0e3-08dc99bc9e3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vmt0MGVGY1F0c3JWUXRrZDRLM05NUjJ0eG1MazlibFdqM0RNL1N0MGZUYzRJ?=
 =?utf-8?B?K2c5cjNXU1liS3VQOWNWUE1NaHpWSjBQdUpLRTNFZXBVTytQQjVvMVZqZWZV?=
 =?utf-8?B?N3AzTzN0NWViRW5uNnI3SktWcm51a05hS0paZG9pbGM4UW45V0xwbG1tbTJN?=
 =?utf-8?B?QWp3dGtrcmRVdHJqNGxZSEQvRDZ3OEVoNlFSc2kxN3h2SUNiQWJmT1JmaHc4?=
 =?utf-8?B?NDJQeGQrN2Q1UnY1WmdMRy9ESlFrN1hCWUlhYklwTW5kNHlOS09McUNqUkxo?=
 =?utf-8?B?RXE3SlFjRW5LZk1POWpsUzFqczJyRlRWLzVFT2kwczFEMkkrWTlmWFloV2lk?=
 =?utf-8?B?eGI1U0MwTmwrTHBPVzdKNHYyUDUwclladDlMSStZOE9UaWcxT3VkTmpQOC9Q?=
 =?utf-8?B?aVZqVjJmNTFPM0tJNTlKY1hEakRPQkVEamZFdXp3VG9RUVF6NjJXNzZNT1FQ?=
 =?utf-8?B?R25TYjJhc0dkM2xQZTR2SUZiOGprM3NiaTVPMEl0UFFiRUM4TFVlZU82U040?=
 =?utf-8?B?MjZrTVBxemVzSEh4OThZSTJaSTA5ZnU0eXl2MjQ1d0tPZ05OVzlveW1RMGlt?=
 =?utf-8?B?TUFHZVRZV3V1QVlzbkNBSVRmd20veXdpblFjYUxOUFh1NVdFVmp3NEwrNGYz?=
 =?utf-8?B?SkpVS3Jpd3lqNXE0UmdBcTdhUGNmVW40MkppWjlaOXlYZy9XVVpBL0kwVU03?=
 =?utf-8?B?R2RyMStQN3hmQVR6ZnMwSkFzQXAxM1ZNNXVJanFOMjIrMkVsNG9uZzdEQ1NS?=
 =?utf-8?B?cVlHdEw1UmpEcEdWT3AwMnNiN2xFdi9GNkhYM0pyMXpxVisydDF6bVJjOW5L?=
 =?utf-8?B?bU5lMjNoNXdPYkJmbndUeStQNE9uZFdtYmRqNndnOTBPSERGTGNBTzNDUkht?=
 =?utf-8?B?eHR4TVNLVStEUnI5THJVSm1RN1UxV2J4SG5IRXZSdGlUdTNIT2JuYm9TSVBu?=
 =?utf-8?B?aXNYUWVzN3JvSU1lUDZOYjJHb3FPOVg3OE5rTnRpV3RPSTNRZTg2NjlNQWd2?=
 =?utf-8?B?UnoyVGxVS2tpUTVMQkdISHErREMzU20vZG1qdGUyTHBOcEZlRlFuTUNkOHhC?=
 =?utf-8?B?TVNuY0hmNEdGQ1Z3VXo1S3VGbkVLQlBIdlA1dUtud0ROZEM0bU1WdHJjV1JY?=
 =?utf-8?B?djArcEwxcTUvNHpQODhJRkNqQ1RlMUkrQXlMbDYyUFMrSlppL0lWelA5Ry9j?=
 =?utf-8?B?RzVFMVBGVU40MGRTL0E3MXVjNEFLaFVrL2FaeVBNNEZibXREb1JubXNlMGhT?=
 =?utf-8?B?OG5iRmc4Q21VZnhqTldFU1NFeUJKeEFmT2hsbmFKZDZpTGlibHNmZW50SDFF?=
 =?utf-8?B?MElkenovemYvb0xmbHVvMndNNWdLaXlveWhUanZGdzJDUUYzcytJc2t4aDVw?=
 =?utf-8?B?SlUwSEhkTjk5dVVZblA3OU8vRDBocGJsWnR1ekFkSzZ5S3lydk4wdDErNXoy?=
 =?utf-8?B?b3J3YXJwcEIwTzliRGFWS1dheURWN2VvRnoveVhzRzFIUFhaZVVDQTRVOFhF?=
 =?utf-8?B?Qm9RUFhKRklqcDc5bTJVcnBQbnhWNHlxcW4wVkQ0bzJRUHVuSllDN05GclVN?=
 =?utf-8?B?cTdNUUNqVGY2WUpqbU5oenBST3YrNGxpZGUwalNjQUhNaUh3SEpWMGxKaE1l?=
 =?utf-8?B?c0srZ21SSlBlOGVaaThkNWhrWFJaSzQ0a3NkbzQrbmNQLzFUankvL0JUeWdM?=
 =?utf-8?B?ajh3anR4cSsySkVkUWhhajZGYmd6T1BmZVk0S1ZrSTROK0Z2b3JDcVJmMm5E?=
 =?utf-8?B?YVk4M0QrVXhheFNoS3VaZ0NKNU1UYTEycFdNcEhJMjZFakw0U3ZteFg5TXM2?=
 =?utf-8?Q?29VGrFvPsHCALIM3n41ZxcfBbyHIiVtWXqjPw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHRGc2FjMDA2MFJiOE1oOGZuMnoyQTl0UWN6UGw1OElqMWY2bjBKektjVHVF?=
 =?utf-8?B?bENyZytJbUdVZmYzTEJEZXJVQVJBbFZ3aHgvckVIWTAzeEh2c2Q4aGlyTm5h?=
 =?utf-8?B?NWVFTlBUcWFjNGZ1VjllaTlTelJSNU0xNDF3UGJPUlhlbG9rb21aOW9XVmUv?=
 =?utf-8?B?RGpLci9TQUQ2MWxnNS9FYmtVWjRHdXRLc3pIMXRwY2pucmVrTkRXZjRKYTRi?=
 =?utf-8?B?YXd2M0Q2Q1hoMTkxdHFaOHFyYU95MklkeXo5ZkZFN3BId2E4SFlDY2MwU2U3?=
 =?utf-8?B?dWdrU0xTWnpRU1R1bXRVd3JkbTcvRVM5SkJROFByRCt4OWlDck9VV09QWFlT?=
 =?utf-8?B?ckFvVkVINlpEdWRpOE5zQXprT2hMb1JqeElGQTloQWlLVWN2U2VLQWZkQ0xJ?=
 =?utf-8?B?VSszV01Ba3plUFFIdG9tR0lkVkhGQ0VXTENVQ3FyMG5IcWZvcE5MdmZ1L2ho?=
 =?utf-8?B?WnRJeGozUVJyUHJ5bHNRekpQVXJIVGUwR0xuU1ZkNXhkMXF4NHJSdlA4OHBm?=
 =?utf-8?B?c3hKaDBoaEJvYlNXWDRjcEZwK1Z6UlAvUHd3a2hXZGY0bnBGU3plQkpVb3BT?=
 =?utf-8?B?aC9yalZJbjAxM1ppM3M2ZC9Va2k1cGhpSXFvVHRoQ1FQbzFsdmZaM25RbEVa?=
 =?utf-8?B?KzhVcENUNm9MbHdlRlVDVXJUSU1FT1hzdUx3MEhDLzZLMXlyaGlucDJHZ1BU?=
 =?utf-8?B?blVzZ1dHL1hPMFZRY0dGNjJxdnVVb1IxekI5T3QxTUFHeFJsWXRURTB0M1FG?=
 =?utf-8?B?RXNJSWJpWGdDOUowNDFJNitTZ0FQcEpHWGZjNUNFdXJJZUxBZytTUnFnSlJT?=
 =?utf-8?B?YnhIcjBFSFJ0Z3ViSzUzRGk1Si9DRDBtclBna0dTcEoweGdiVWVyNW4wVVRv?=
 =?utf-8?B?Mit5a3Y4QU5nUHBDaUxVZ1pxak1XR3lNaHhPaHUydWUzOXdQRkZ3cDVSUFFL?=
 =?utf-8?B?cmVVbUdDUnZ1MU91NndyTmFWQlE2VTNScHRnU2h0MlFDOWtBMEZkNTcxcUdr?=
 =?utf-8?B?a2s5bTNNemV5SmljMFdGVkN3WHFNWDYxVit3VEltMVFybzVRNDRPTVpIYnFJ?=
 =?utf-8?B?L0o4MFdScEtJdVpHaUVsdU5JTmJFRkwrUmJNNGNmQ3NleWZ1Vy9USzcvSUZ5?=
 =?utf-8?B?eFVLemttL3RJSE1XMy9JU1NFYmUyeDdwQlV5ZXR0dXZ0allwMWpZOEk1MnVV?=
 =?utf-8?B?L0JXL1V0WjJYdXpmZFdSbTZBMkhibXA5Z3JBSFc4cEtvYzhqSjNmbVU2TW1w?=
 =?utf-8?B?V1Z5b3A2TVFXMlVhbkpad3hkcUI2VWZUUHFKQ1hxRzVlc3BxcnQ5K0JWMEIz?=
 =?utf-8?B?VENxaEhQYXVlMkNpZTQyMG5VRTk5a2hIM1NaVVgwSzhLTjRZcFpFRy9laWFV?=
 =?utf-8?B?Vm5Rcmlnd2wwb21UbFczaHBKNkN4SjUxUEJ2WXdLTE5remZ3cm8rVUpNWCsw?=
 =?utf-8?B?Q1VZS0pMOEM4RWd6YXEzNW01SVJBbFBnUzR5dmlWVXYrdVpOZmFGYU93Tkw2?=
 =?utf-8?B?TWpiQVFnbFBOUW5saXNsSTVqMmtFMWlzRE56czJEUHp6TmRmaHV0NkhJZjli?=
 =?utf-8?B?WktPQ0hWaituRWpGaTU1OUZhWHExem9kU2FtNGlqQjFzUGo4VjdkUXFFaDJJ?=
 =?utf-8?B?c3krYzBWdXQzT0syY2k5dkc1Z1hadlEwRVdPaVREcGczQjJDT1l0VUZNYVhM?=
 =?utf-8?B?V2c1anRuVjR3VEdGRldQZW5KeWpYUndZWDhGVFZaanhoVm04TFVhQ0FJM1VP?=
 =?utf-8?B?YzRrQURoMVQ5dFcvOHZoSm9ibS9XUnJOQ3liYzgwNW1kVHhUc3F2VmRZSHhy?=
 =?utf-8?B?eldUcUlYZTZxMWd0VHUrR3RjRVdpZjkwdmxCY05QMHRYUGdmZG8xZ2hCaGNv?=
 =?utf-8?B?OXVVWUdzSkhqWVIwNXR0VmVpZWs4TzR2QzBydWVCcS8vT2dNUzdURllrd1N6?=
 =?utf-8?B?c2JyMzAyTnRRKzEzSEtoaS9OSXRXQjcwS3FEQWkwYTJCRUJpWk9jeXlWS01l?=
 =?utf-8?B?WEN4TzZIcUxhcHdIZURZa1NFMW9sazlXUGM0UURsS3BmTnM3TnV2NEFWcDVY?=
 =?utf-8?B?K1ZndkVLTk1qMjFlYWU4MktHanFmSlRIVHd6VHlTSG1lUFRhWVMybWs1NnRn?=
 =?utf-8?Q?qcctOgc7NXuDlv5CZ6ImloDpc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7aadbf-fd1a-4e03-d0e3-08dc99bc9e3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 10:57:36.7270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ehVo3IFDBQ/1/b4Oi4wS33vxDkSI08kMPOV2r+gXJR92MJB52lH7R3JCtsvGjtAxoF964ltERFekcBCus8b6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8308

Pj4gQW0gMzAuMDYuMjQgdW0gMTE6MTUgc2NocmllYiBDaGVuLVl1IFRzYWk6Cj4+PiBPbiBTdW4s
IEp1biAzMCwgMjAyNCBhdCA1OjEw4oCvUE0gSmFjb2JlIFphbmcgPGphY29iZS56YW5nQHdlc2lv
bi5jb20+IHdyb3RlOgo+Pj4+IEhpIFN0ZWZhbiwKPj4+Pgo+Pj4+Pj4gV2lGaSBtb2R1bGVzIG9m
dGVuIHJlcXVpcmUgMzJrSHogY2xvY2sgdG8gZnVuY3Rpb24uIEFkZCBzdXBwb3J0IHRvCj4+Pj4+
PiBlbmFibGUgdGhlIGNsb2NrIHRvIFBDSWUgZHJpdmVyLgo+Pj4+PiB0aGUgbG93IHBvd2VyIGNs
b2NrIGlzIGluZGVwZW5kZW50IGZyb20gdGhlIGhvc3QgaW50ZXJmYWNlIGxpa2UgUENJZS4gU28K
Pj4+Pj4gdGhlIGNsb2NrIGhhbmRsaW5nIHNob3VsZCBtb3ZlIHRvIHRoZSBjb21tb24gY29kZS4g
U29ycnksIG5vdCBpIGNhbm5vdAo+Pj4+PiBnaXZlIGEgZ29vZCBzdWdnZXN0aW9uLCB3aGF0J3Mg
dGhlIGJlc3QgcGxhY2UgZm9yIHRoaXMuCj4+Pj4gSSB0aGluayB0aGUgY2xvY2sgaXMgdXNlZCBi
eSB0aGUgUENJZSBkZXZpY2Ugc28gZW5hYmxlIGl0IGluIHRoaXMgZmlsZS4KPj4+PiBBbHNvIEkg
Y2hlY2tlZAo+Pj4+IHVzZSBvZiBjbG9jayB3aGljaCBpbiBzcGlbMF0gb3Igc2Rpb1swXSBkZXZp
Y2Ugd2FzIGVuYWJsZWQgc2ltaWxhcmx5IHRvIHRoaXMuCj4+Pj4KPj4+PiBbMF0KPj4+PiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMTA4MDYwODEyMjkuNzIxNzMxLTQtY2xhdWRpdS5i
ZXpuZWFAbWljcm9jaGlwLmNvbS8KPj4+IFlvdSdyZSBsb29raW5nIGF0IHRoZSB3cm9uZyBkcml2
ZXIuIEZvciBicmNtZm1hYywgdGhlIGxwbyBjbG9jayBpcyB0b2dnbGVkCj4+PiBieSB0aGUgTU1D
IHB3cnNlcSBjb2RlLiBBbmQgZm9yIHRoZSBCbHVldG9vdGggc2lkZSAod2hlcmUgaXQgcmVhbGx5
IG1hdHRlcnMpCj4+PiBmb3IgVUFSVHMsIGl0IGlzIGluIGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9i
Y20uYy4gYW5kIGRvY3VtZW50ZWQgaW4gdGhlCj4+PiBiaW5kaW5nIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9uZXQvYnJvYWRjb20tYmx1ZXRvb3RoLnlhbWwKCkFzIENoZW5ZdSBz
YWlkLCBoY2lfYmNtLmMgaGFzIGhhbmRsZWQgZm9yIGJ0IGNsb2NrLiBCdXQgaXQgc2VlbWVkIHRo
YXQgY2xvY2sgaGFzCm5ldmVyIGhhbmRsZWQgaW4gYnJjbWZtYWMgd2lmaSBkcml2ZXIuIFNvIEkg
d29uZGVyIGRvZXMgZXZlcnlvbmUgYWxsIGVuYWJsZSB0aGUKY2xvY2sgaW4gQlQgbm9kZSBub3Qg
d2lmaT8KCj4+IFRoYW5rcyBmb3IgY2xhcmlmeWluZy4gU28gdGhpcyBjaGFuZ2UgaGFuZGxlcyB0
aGUgUENJZSBjYXNlIHdpdGhvdXQKPj4gYmx1ZXRvb3RoLiBGb3IgVVNCIHRoZSBjbG9jayBjb250
cm9sIGRvZXNuJ3QgbWFrZSBzZW5zZS4KPj4KPj4gU29ycnkgZm9yIHRoZSBub2lzZQo+Cj4gU28g
c29tZW9uZSBjb3VsZCBlbmQgdXAgd2l0aCBib3RoIHdpZmkgYW5kIGJ0IExQTyBjbG9jayBkZWZp
bmVkIGluIERUUwo+IGZpbGUuIE5vdCBzdXJlIGlmIHRoYXQgY2FuIGJlIGV4cHJlc3NlZCBhbmQg
dmFsaWRhdGVkIGluIGRldmljZSB0cmVlLCBidXQKPiBhdCB0aGUgbGVhc3QgdGhlcmUgc2hvdWxk
IGJlIGEgZmFpciB3YXJuaW5nIGluIGJvdGggYmluZGluZyBmaWxlcyB0aGF0Cj4gdGhlcmUgY2Fu
IGJlIG9ubHkgb25lIQo+Cj4gVGhlIExQTyBjbG9jayBtYXR0ZXJzIHRvIHRoZSBjaGlwLiBJdCBp
cyBub3Qgc3BlY2lmaWMgdG8gdGhlIEJUIHBhcnQuIFRoZQoKSSBhbHNvIHRoaW5rIHRoYXQgaXQg
aXMgbmVjZXNzYXJ5IHRvIGhhbmRsZSB0aGUgY2xvY2sgaW4gd2lmaSBkcml2ZXIsIHRob3VnaC4K
Cj4gY2xvY2sgaXMgaW1wb3J0YW50IGZvciB0aGUgcG93ZXItdXAgY3ljbGUuIFRoZSB0aW1pbmcg
ZGlmZmVyZW5jZSBXTF9SRUdfT04KPiBhbmQgQlRfUkVHX09OIGlzIGV4cHJlc3NlZCBpbiBMUE8g
Y2xvY2sgY3ljbGVzLgoKLS0tCkJlc3QgUmVnYXJkcwpKYWNvYmU=

