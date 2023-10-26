Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEE57D8C4C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 01:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJZXqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 19:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXqQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 19:46:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD9198
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 16:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698363973; x=1729899973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QfUTuGtbEHri7KYYYRTHAbDE7Dy8B+2gN9VKmAS6FsI=;
  b=DAJStJBGkyGilHjcmlKOVy0faQHf97/NCqN9i0t9I2qoXcurhJOduS88
   VuebVr/lMc28QL+z+SUrQTJlyzoWHaNbwTlk6QFAMcMX2rV8jHIjbsVqm
   ZVHpSZ8fsMaIsdpHNLnIN56zpT/XJDU3oBcrubGhLwzE4bekbKHHbNB0x
   wRydenE/93kkK8pYlViZt23zMg788WNpwgbPEp76KUqk7YyUCdaBAOX/r
   9EXYfqzVP8uRtKzSSPH5hQS4pTjATKELClCB8hLru5Fjxgho6OETg+Vey
   MzHi3WgLEJcRmMHl4zAJAFeuMNRrBsAOrg3mah5Xfs6TohvnMjPKSlOgR
   w==;
X-CSE-ConnectionGUID: mC5ZfnSCQYGDXQlQ9IbyXw==
X-CSE-MsgGUID: gzGUxiYlSXa9c0TLcxlzPQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="11283597"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2023 16:46:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 26 Oct 2023 16:45:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 26 Oct 2023 16:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsgS9WSsHntayuCw5lgqwhNOKZfQ+gzbpbYxO7/NthrxtDgDdYaR+n5v8j1Wz+Jj2iogPrl1yAV1WMSJifwpGsNHUyLKwC1xW46wBCnfHbbjS224YV1WNAzmmjKN5OoAdqReNvp52MFzE6MDdB2PcMKiJXJXsZR8MB8DTH4BcT/+4JOELZkloSQLtId6jJybU2yH7os4fytv349INs3fhhJWj01Dq7gpGB/2mVpTcWXdBsIcJVxftWjJZudDx50QRHnAFB/+zKtjvwy8FVp7gJs9f5OSSX+9TsPLwOaGAbEr6Bsos/809+A+1id7fqqDLsHatXUUMjvvQKNLtzXAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfUTuGtbEHri7KYYYRTHAbDE7Dy8B+2gN9VKmAS6FsI=;
 b=ZPoMdxhT8xNX88EkkG19SG+9Ri9xY9hS+bXaeb5lJXeSorVSJhLoNON1hjFc8SEowcL/jXHKgkBbt7qITyk8aXphMAh+xbOqilV8EDQpZ4EofeZ3QDMga5ov+tW5MZ1w4iC6A58eHN1JY4Z00OA84WD5+YGf7KFDGSldEKmHfu+Z4SQWuEpezHMlT5HXAV7aTul5Crk5yulH9/xOobcPTptSqr+14veCg4EEeQZXqZhk2wUk5qC4tE6lL5OGctGc8VuoTA/uphtm9bec7U/mxaLSeYb1k9EUbLx00LiMX+6ZWsh02uQxnqrLdp7XwhIkNrbanF7dh7wRmqipXAMeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfUTuGtbEHri7KYYYRTHAbDE7Dy8B+2gN9VKmAS6FsI=;
 b=JqFcvFyXtxZgr2JDDfi/IKB22XeDw9Wvboq2C+wOiNw6cb2dNIkIKa841uomE2btzDqMymH8uU1NeguzHOalxtVmIEJgYTiYpKX0W6/EJlUf2NyNorPQ8uHkSlabl+mwlENtWofojOlW5QywfQfz2kWKfbqrk7LH3BjFU33hV7E=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 23:45:42 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3c04:22dd:c79d:1788]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3c04:22dd:c79d:1788%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 23:45:42 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <dmantipov@yandex.ru>
CC:     <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: wilc1000: always release SDIO host in
 wilc_sdio_cmd53()
Thread-Topic: [PATCH 2/2] wifi: wilc1000: always release SDIO host in
 wilc_sdio_cmd53()
Thread-Index: AQHaCBZ2CC+pFZ7jDkSoWWrWM+DGd7BcvOGA
Date:   Thu, 26 Oct 2023 23:45:42 +0000
Message-ID: <238182ed-b7f0-4b07-ab3a-e25b5fa16eb1@microchip.com>
References: <20231026141016.71407-1-dmantipov@yandex.ru>
 <20231026141016.71407-2-dmantipov@yandex.ru>
In-Reply-To: <20231026141016.71407-2-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SA1PR11MB7014:EE_
x-ms-office365-filtering-correlation-id: 286bb95e-cf7a-414e-923f-08dbd67daa8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l+oYa0PVPoBsisuVa9/eXGl/fgJ6gFjYOhSS7Up83IXWQFa1n0Ah1xSoHlX5GWoPbusZ5++DE5yNG9xi0XzT6rv2qwkJ9Ao0YtbLM8Cq/mmrifWTzJ3EZmQxnuemOXOj0SNJ86hgIIVSyQkm/ryMbBi611Jkk+wZQYoOaZLMMJt1ml2br/0h2aBcAHnqMshO7++HLVWQSMHnXTuKxJy5xasGD3uMeIa+8gcfXxvU50CKPLLvdJaKg9Eg32sb/OwLLO2QgNUGugASf4zfgVHf+Slm1d9DwzpB/CiSLqZUhTiuzFMjuklcFwH+/3uk30XUC6wo8JfY0z0KKIKyINEOI8ACbVufDn+78MWEpfWjCFy+eIDiHt7yKiW9jA5BN0qnVELYWkgUEK+ex0mgnrS75boNL4gI8BQ8mOpZUjyk+HMOf46PSwziFPne1qZIODfi0w8vtjHadZK7Y9Tnph9RVQw5Hi9wCCFC1FHneD3agqUMZoyClDR2qRB8PJNaW42zIcwdCASX2v3L2CZkUsGw2ysqWtxERDLYiM3dlnB+6deu/lOvO4CaUSbp0X/gR6HUEChTs8zXA0j74ZfMJdN3jwi1iWRhi2HcC5zZuNjnOHG2whKI952QlZowO9tJ+OySLWmocObtK4R6cRvjWwpNkz6vpeWRpjAJ5HhnmROYzkvkO+Icpz/dxIPrf3QxJWIgZNtrP50SbOyTU5N6UuG7fzxGyf+ytk50SSJnVSYholQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(38070700009)(31686004)(38100700002)(41300700001)(2906002)(31696002)(5660300002)(36756003)(86362001)(8936002)(8676002)(2616005)(4326008)(26005)(6506007)(91956017)(66946007)(6512007)(66446008)(71200400001)(122000001)(316002)(66556008)(6916009)(54906003)(66476007)(76116006)(64756008)(478600001)(83380400001)(6486002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVF2SWtsejdwdEhxa1cvUDYycHg1ZE5obEkyQzBROXc0WWc5Tm0vUmNyMkdr?=
 =?utf-8?B?eEtUcFZXVEpJenBXejRhOVBma0oybzlqYkU1VHo5MlB4UFJMSzB2Q2VzWXRa?=
 =?utf-8?B?SGFsK3IrQUZUdVJ6bzlES0N2MVdoU1JmQ3ZubG83dzZWcVJJYTl3NWR0VUZp?=
 =?utf-8?B?TDR3TVhQS2tpVTJKTnRKN3hxRlN6NitGZjdxNXhQMmZTWUloVGMvU3E4Rnh3?=
 =?utf-8?B?WnhFbGlBSCs0UitRbzFrQnkvVkNuZHFiQ0dwL0tlM1FjRHp4eTdVc2NtODND?=
 =?utf-8?B?WG5SQ1R2R0dnWnVydmVWWXV6M3l3bm1yWE5nTDFhTkRhMFVBMjI3YWYxZmhu?=
 =?utf-8?B?ZWdoRnEvUG1abDVFVjQwckIzM2VZTk1kUTFFR3dzekpZRGFzb1V2ME92UWRD?=
 =?utf-8?B?SnpQUlV4cGFZcFRZSm0zTGxzOGE0aVAwa2pXemdEWExhVWFxajdob1dYRjU2?=
 =?utf-8?B?VnFrZDlUelZDa0FLTHZPU2VyakRZMzUrZ2srenFKY3ZzUXgyeGZJRTQ2SlFZ?=
 =?utf-8?B?YUJOTFZiVEtwZjVCTHhSb29GWElSS0tVckRFa2h5Wi9kMlhVK3JwRC9HUFBI?=
 =?utf-8?B?QUpzbFpnUkdDS0EzTk9ibTh4aXV2VzFpbG5Wek4wUEpxNUZoMlM4RVJjeXZ6?=
 =?utf-8?B?MForV2UzM1lqOFJvdXNXbW05cVBUMXYramY0NXRZbGpUUTNYUWY4LzJnZ1hM?=
 =?utf-8?B?aVlpY2Zpa1BDNk1qQkVpdHp1S3VTdEM3RXRnSGNVY3h6YUZZMUJoNnNqSDU1?=
 =?utf-8?B?Y1lXM0hYcTAxY2xCZDN4MVo2MnhsMzE1MnNvY2VKTERjcG5sQkdSRTcwQlRS?=
 =?utf-8?B?ZlJYWGh4dGlCcHlubE1rT0JiQ0NMcityb1dMVlJzSGR6a0hJUVkrMEpWYllN?=
 =?utf-8?B?ZlYrSHh0SExBNTFRbEJTSXZOYXNZZFRDMmNET0x1NlBZTlFrV3MxRnFyMVlN?=
 =?utf-8?B?RXVLSlhzbjR1M0dtUXZNYjdsczdEOHVsSnRKd044eG53MWdNaWR3OVhVY2lJ?=
 =?utf-8?B?WHpiSm56ejZvNU9NMXdhZWNvQlVPT1NndGpyaVZUanFkcXpCUHAzck9xYll4?=
 =?utf-8?B?dmppVzcxTFJsaVZ4L2I3MjFPSVd1YUdSTmc4R0RZL05adG1sRjY4SXhQU3cy?=
 =?utf-8?B?UE93N0Y5SVpjQ0Vobk1pc21BR2w3WWVyYW1KNDV4b2pHZVpXaGJLRnFiekQz?=
 =?utf-8?B?dkxrNjV3L0tzcEo2M2c3RU00WUtXSUN1dmFlSmUrbDl3QXFGc0RHN0lUVDRo?=
 =?utf-8?B?QnRkbVdHNXZLQWo1amdPcnZnU2lSZ3dpZ1pQK0lNR1pYWWNVTWNyVW5SNzQ0?=
 =?utf-8?B?dGljUFRFVS9ZNWwvelhhWXhwQndaRUVDV0ZKT0RLQURQa0RWKzdHOXhJMDFP?=
 =?utf-8?B?RC9raEViM0s5ay9UL2ZpVGdXTmpzSUdEdER6K2JJYjE0N1ZLNm1lTDRYMFMz?=
 =?utf-8?B?UXg5Q1VPdjV1Y1hUVnlpSGpOTVMrYmEyWGcyNkVrTzZGQ0VRTmdKWjVUZlhv?=
 =?utf-8?B?cFFhbjRLSVR4UFJmcDAzMDI1YWZwTnVDb0YvdWVWRFU2UkF6cDRzUFVnVGhz?=
 =?utf-8?B?UTByQmNCL3N5NWR1SDZ5N2E0OUhhcEN3UWJKZVQ1WjN4cTc5Rko3VkgyN2VJ?=
 =?utf-8?B?RE5Sdi9lbHQwV21Ia2xTMzFJWGljWnpJbS9QY0YzQlNvN2cyM2VlVHZmNDhF?=
 =?utf-8?B?R1RZL2pwa1phZTM1cysxN05sNGRzU1ZoeUN5cEJwMktEcjlpVHA0bGxQNGdn?=
 =?utf-8?B?UEFZTjZHZmlkcmhzSjlFVENKcTVacE5rOEgyaVIxdmc2ckc5ekc3dzVmeGh5?=
 =?utf-8?B?ODJwSzdXY0trNHRFVGtiQ0o2eDNCNlpmVnl3NkNUMUFldkZ2bGFIVzlDcEVo?=
 =?utf-8?B?T1ZPTkIzRWhMNk10dkp0Z2NkQ3N4Q25ES0NGMEVHaEJGSG5yWjlBUUlwV1hz?=
 =?utf-8?B?czBQbXNzM0tkYWV4V2R5cUtadVBBV3F3dkZWeUVIT013VmoxaFhMOWhRTlRG?=
 =?utf-8?B?cm5RYmJWcXg3ZnF1YUwzUndNSlRrQUlIQ3FyK0ZuZU8zR0tvTFZNeHIweTVo?=
 =?utf-8?B?WnQveDQ5RC9qY29DdmVMbXVwWDBDdVEzMlphdFY0M2xYcVlaSU1oTUd1YXM4?=
 =?utf-8?Q?NMchUl6oh3cT2dMfdvi9NvQB8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7C2284F61344C458A0FAB047F83D0FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286bb95e-cf7a-414e-923f-08dbd67daa8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 23:45:42.3234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBv0NlQe3C2KkOyGdO9xGr/+L64eekoFX2oCHKZ5La6ZEpKe4OPLAL1gd03iETa/HkHUpTVVdJg9W+xzKODZW2UfzRT5bPRG73C5R66rYZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhhbmtzIERtaXRyeQ0KDQpPbiAxMC8yNi8yMyAwNzoxMCwgRG1pdHJ5IEFudGlwb3Ygd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRW5zdXJlICdzZGlv
X3JlbGVhc2VfaG9zdCgpJyBpcyBhbHdheXMgaXNzdWVkIG9uIHJldHVybg0KPiBmcm9tICd3aWxj
X3NkaW9fY21kNTMoKScuIENvbXBpbGUgdGVzdGVkIG9ubHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBEbWl0cnkgQW50aXBvdiA8ZG1hbnRpcG92QHlhbmRleC5ydT4NCg0KQWNrZWQtYnk6IEFqYXkg
U2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25l
dC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc2Rpby5jIHwgOSArKysrKy0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NkaW8uYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9zZGlvLmMNCj4gaW5kZXgg
ODc5NDhiYTY5YTIyLi4wZDEzZTNlNDZlOTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9zZGlvLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NkaW8uYw0KPiBAQCAtMTA2LDkgKzEwNiwxMCBAQCBz
dGF0aWMgaW50IHdpbGNfc2Rpb19jbWQ1MyhzdHJ1Y3Qgd2lsYyAqd2lsYywgc3RydWN0IHNkaW9f
Y21kNTMgKmNtZCkNCj4gICAgICAgICAgICAgICAgIHNpemUgPSBjbWQtPmNvdW50Ow0KPiANCj4g
ICAgICAgICBpZiAoY21kLT51c2VfZ2xvYmFsX2J1Zikgew0KPiAtICAgICAgICAgICAgICAgaWYg
KHNpemUgPiBzaXplb2YodTMyKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+IC0NCj4gKyAgICAgICAgICAgICAgIGlmIChzaXplID4gc2l6ZW9mKHUzMikpIHsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZ290byBvdXQ7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAg
ICAgICBidWYgPSBzZGlvX3ByaXYtPmNtZDUzX2J1ZjsNCj4gICAgICAgICB9DQo+IA0KPiBAQCAt
MTIzLDcgKzEyNCw3IEBAIHN0YXRpYyBpbnQgd2lsY19zZGlvX2NtZDUzKHN0cnVjdCB3aWxjICp3
aWxjLCBzdHJ1Y3Qgc2Rpb19jbWQ1MyAqY21kKQ0KPiAgICAgICAgICAgICAgICAgaWYgKGNtZC0+
dXNlX2dsb2JhbF9idWYpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG1lbWNweShjbWQtPmJ1
ZmZlciwgYnVmLCBzaXplKTsNCj4gICAgICAgICB9DQo+IC0NCj4gK291dDoNCj4gICAgICAgICBz
ZGlvX3JlbGVhc2VfaG9zdChmdW5jKTsNCj4gDQo+ICAgICAgICAgaWYgKHJldCkNCj4gLS0NCj4g
Mi40MS4wDQo+IA0KDQo=
