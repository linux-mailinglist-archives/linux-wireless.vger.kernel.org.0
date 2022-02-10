Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8101A4B128C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbiBJQTZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:19:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiBJQTX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:19:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D7C29
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644509962; x=1676045962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mFfMcLDO8vZsloUUzzRiWuYNxQ3qdsogV2CjtGcvyOM=;
  b=DtO8rorTwtvv3xLPmPMVk6TP17rlMQxrQ4/UCs3tctZO68kjn9q9oWe/
   eR8ea2FL7MseU2ZKADL7D1HXsswnQbKEcXx73UxTnVVsPcsqdeqgk7LND
   V19Wz2YNWETTmdsyqzh7lxuHpE+803///auRiLnWImelZlj5h0NFyg1B+
   Qcqab0p/g04xB1NEHzezTgfoMvO6yFpIX9r9HLW+rZBIOObs2DCpfD5jx
   LicAkoqJXfNikNy8zWM7bANyLU6Abmz7240f+3xIEwny6DWWOD/j8aq8N
   bfusDUz2lXUKB2/cRiWcDrcmFCkmW/eTa0LLtPpRwzX3T7pl8fXPK6gw2
   w==;
IronPort-SDR: nJuKAeNehrK5FbrAkUAVSK4BAJahiEjSmUK/tB5FPxxISg7A5l+2W3PBkBYxShGMtTPpwTPyMV
 aW0jbexrhX8qrWWnyfgUQXvLwbxlSDrvSYWlsXmawCQZCYuFcVwJYbjVXlWzdDeUJz1LSmEGRJ
 25npxV00O1QEbRI93/z9aCKAv5HPh1LR/pVCnfHVXQyyl6SQ7YuI/TM19WAaLF2QSQgp2DwGKQ
 WScurpI4V69JyXT0Zfpo2oWtrVaXzwzaSpMql1SzLZ5yHsK44L/c9zE6zsxr7enQqQwjyQyiCj
 0aGOvZdHuNrSs4a+q94cbu72
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="152636309"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 09:19:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 09:19:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 10 Feb 2022 09:19:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu9soAu0teCM03odP7A2FAPZsKSK6UmxjWX3fWW7SymKiJWIlstpFsFN0PM1QWvppD4FFw626qoSmQU2b28GyPkq1NdJ6B8tn+RwV3XHNbldCS1jHV9ZhNS7daSxXrr+S/B7cNBGf49xQSS/fVhEDmXFHpFYh9N3Ol1WLpwBBOGqeyXu5CPG82fMbuYsiXmxpLv2VsYIdaSb8fKKlZVKsfEDz5khXVlrv5hpsslrqM/osr2R/ScciVXhALc1Z4lHu4u5gyPGOHRYb4gowMwanSNqOvmMuOBZPM1Svd5Kb89ghyunn4lSlirXU/bVC5z96LOZfSn1wuR17EDBcKPnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFfMcLDO8vZsloUUzzRiWuYNxQ3qdsogV2CjtGcvyOM=;
 b=YmPHtzqtsYNl6r85Sb1Sw1JOedQKSqStfilK90/nXPyKM+ctnFSlkc13jrRGc1BJO+TOdkAXoKE3JdyfrDzSqbqtcfZVCIQ3IEnFousEAiNWzeQSeFMghx3RplRtHRtym4AcJZ01+WkO5dcUvKkdubNVPIpG03kZ3JjFGIUYiQkWsteLm/Fmq02PsT6ZhSxnodW/cJi19xOEg+CR0t8Ln7o0raeibBc/B542In3wiTgI/7Z/Ft7kTX44HICKJvmguHkWlV3+adzLDvHqZHHasu3wunbOYfJtjG0k7ZzaNNf7hm6XiCjoLAnELkb/7BxCSWEmLgqqB1WnY8MI2mc28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFfMcLDO8vZsloUUzzRiWuYNxQ3qdsogV2CjtGcvyOM=;
 b=XDI+siKY7iBFSSoU0wytGNHEf5tGgk5mrNv2cqX+gK/ExdLEVsLzxPpS9a1ddQxh4ocZF3VxaY1et/F7swwTTWk3ZG6yPycXWgtrTWxp9TjVFEuxLKZ6eT7xzdDeG3m3Wt+IAONeQ/kjeteOmqTtCNx2HMJxLvm6s31roOpqwaI=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MWHPR11MB1853.namprd11.prod.outlook.com (2603:10b6:300:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 16:19:13 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::bdea:48bb:2b17:e59d]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::bdea:48bb:2b17:e59d%6]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 16:19:13 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <cniedermaier@dh-electronics.com>, <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Tudor.Ambarus@microchip.com>,
        <ageisreiter@dh-electronics.com>, <marex@denx.de>
Subject: Re: Possible bug on wilc1000 [Klartext]
Thread-Topic: Possible bug on wilc1000 [Klartext]
Thread-Index: AdgdBYpowDRGmRhhS4ylc9cEzwODUwAvQHEAACUMdlAAEMyaAA==
Date:   Thu, 10 Feb 2022 16:19:12 +0000
Message-ID: <74d9191d-7bf6-2beb-2d3b-700b6a355f68@microchip.com>
References: <3994a34bb0d84e9d8181ec490a3f71d2@dh-electronics.com>
 <97d9da81-f15b-33dd-a66e-9f6dbe2c3b0c@microchip.com>
 <14d8dbd0f9de4bcdb50bd1983b2e4f31@dh-electronics.com>
In-Reply-To: <14d8dbd0f9de4bcdb50bd1983b2e4f31@dh-electronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d84a2862-2fff-4263-42f2-08d9ecb1137f
x-ms-traffictypediagnostic: MWHPR11MB1853:EE_
x-microsoft-antispam-prvs: <MWHPR11MB185370F6E1AD1C492D3E2F95E32F9@MWHPR11MB1853.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlT+1mHkDkLGmlk5f63jHBtam5mEgtLHwXQ3BsEWHd/2rKjWQBXMghQCVvyf1e6iD75xICOXByQs546A+i6LsRoI6CbzMBEguH0okmd2uCVC+0oUrs0ClBZvYwVMHrab7/or+K73g3VTy+xHYVyVsH72NPlTAJKAlSxdJuK761lghe04Nx4Jfh2ccpRx/M2n4xU0cqOa/Gxx+GzpJbY76zYZ1fGWXYuJhb7Y3+Y/HKIzeaZR/N/VGr3kau8HQYn2CObvCPHrmrlF9LuGyaIpBYvqbFDKvh3dKjC2s5mGZG1rX15bAxOc0yepi17kDkVhjTr7f2Y2gJPd+rzxVGQAqH+LGVckSA43ZyASoG3aeNsSuVIBCpQ+473LOnDiNMN2WFdM/QYDGpvaOQaoSyhbSJNNDjTqtRrPYlq0yd/0B5bvSdx4P9t7S6vo7eB26teNBs5yPJxyycfx3bxGLvg9rc7eO6GVTj1CeQUiTo9mRfnvhqKtyXBs0H3BKcgDnjGp1Uwt4BZa61ZTJwouN5/gsYr9O31zQj2Ev6xwVHNKgShNxEKhEzGus0dH90vwmeyM+tYqZrqqZY3z5KeEpfEi7sJkAOeawUh6Hi6Z1YWRdjvo6cxwgg37mjJqIU8d5EfUH0UugIr8Eelmmvndg/tqtswycy4VxRPnOSUzOHwSMulyec6W6Bn0f1vnOn6hatsG6I5ZUJU5VTpnxvm3hU3UMEJxLZaFnUdQT8XgD4ZWRwh3o8psO+UWAVDT1NZd+40VyePUvHMdJnfdgacvC9g7sy00yZGmixcSWbfcD4tgHTowx4aFFosHF/zMjsNr3sIlhNaSALjUt5jtC7nQtvn4ZBUkb6RECdKmPo2BPNnpl3I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(36756003)(6512007)(64756008)(66446008)(66476007)(83380400001)(66556008)(91956017)(76116006)(66946007)(8936002)(38100700002)(8676002)(53546011)(6506007)(55236004)(31696002)(4326008)(86362001)(122000001)(5660300002)(2906002)(26005)(186003)(508600001)(6486002)(54906003)(110136005)(2616005)(38070700005)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkI5NXVUM1BtcWZSb0Z3bDhIVzFXN2R5UzhPS1lXK0pMWlpPelA2LzFQSkc0?=
 =?utf-8?B?Z21VUnA1Tnl1RWVFQ0hHOW5jdVVBQ2ZReC9mL1pCSWdRT3V2eVBSUC9jeGw1?=
 =?utf-8?B?ekNJUFlWUW4weGdHY2U0OEJmamdwc29YemdVLzlCZ2M1ZmJ5SnoySjBwZE81?=
 =?utf-8?B?dkxBY1BHYm5CU1I3TGx5ZHBTL1lVbFRsUFRienEwL2JTZStKeGw5am9XNHNO?=
 =?utf-8?B?L01qaGpOa1doT3FIbTVvZDIxbzdaRkpZRlZEYTZhazVyMkJ4L2lWVEFZZjhD?=
 =?utf-8?B?S3JEU1NYbFo2eUVJUWtjenJuWDdlM2FsTkt4cGhOQW9NVDNHVFRJdSt2SVNj?=
 =?utf-8?B?alhxTWJqZ2hZZDV3YzU5SjhuMjJ4b3N4dWxOMXdqOTMwUHhScWJ1SlpZSXVa?=
 =?utf-8?B?aFJ2Z0lWUUJPR1BuWXBNQnhKckE0c0hveHo5SnEzVnFTeTB4Nms4bk5wbGtE?=
 =?utf-8?B?RVYrU290N2xSMDdBb2tXdHJEU1ZyYXAxMnBROEtsenVtcXppb3BrS1AyTGpE?=
 =?utf-8?B?T3dTbkpCTndwREhzcGYySHJsaUF3R0hHZlJZRWwzS2RGSUpLOFJKWDZ2bXpM?=
 =?utf-8?B?MGVWWXdsR3FVRTJ4U3FoaWUrRUlqWHVtNUM2eTZTZzdyOG8vbFppWlFpRHh6?=
 =?utf-8?B?bVNWOGdLbGUxU0NHQk11LytFdm41RFhYV2pIdHFXV25OUVBucnNvcXgvS3Bt?=
 =?utf-8?B?Nm4rbUVocVcvWDAvcHhmQURJRnMzYjhSSXBibURQR3J1UThDc0FoUTY3Vzdu?=
 =?utf-8?B?ZXRrTGk4cU9FYVowUDc2V1QvN3BDcmdZcFAzd1J6dDVpTENLV3pqajNzbTU0?=
 =?utf-8?B?WTMyR0p5TDZvY05lN1ZHTEFSNkVWZjFkbXo1VGhHUUpFamNQUXZKTDA4VUJ5?=
 =?utf-8?B?eWxDdjc3ak5mLzgzb2JKTXdXNmRDMUs3bXNUSzl1QjZpblNReXNFNXVwR0hm?=
 =?utf-8?B?elJNaVhhVWdmanZjM2xldjA4bGRkOU9RYVNyb0Q0K0FlQlJjY2tiU2dZZnZ1?=
 =?utf-8?B?UmFpQjVvQVVtZzJ2N1M3UGcrbXdMMmRBU0FieDJmRmF3NU5RemVvenFmZ1pq?=
 =?utf-8?B?REpITEl4c05pVVROVWorRWZDcXZvSUJRZWJMQk43L25FMzFWZkNsUy9kOVlw?=
 =?utf-8?B?ZVJ5VnBkMzhvRndBeHE1S1JyUitUeUR5dlJFQ3JKTTFLUktIRW9qLzhZNStr?=
 =?utf-8?B?cjBHcDRlT1BrcjkrNDU4MXJEeWhJYVFnMWtPUkZVNUxiN1ZOcGpHM0JZSk95?=
 =?utf-8?B?SGNyeVhxRVhxa1NrYkFPUHVXVHhMS0lkb2N5Ykx1TE9rcnJEQU4weXo3TnQv?=
 =?utf-8?B?WmF6aWpwS0ZFL2VLNTlyb2NCcU9meUtKTy9GNVFFaWZFRVJ4U1FTR0JmU05Y?=
 =?utf-8?B?N0JoS1VUa2hjUFEzRVFLbXkrMGVUVnlIWFhrU1lZZWE2WEswc0JkZjdaVTVF?=
 =?utf-8?B?aUNVdmV6OGJ1WVN2UnBrS0VoaDNuOTRHODlSM0EvTVdSbHRMQWJMOUYzaTVO?=
 =?utf-8?B?bDdDT0tHQlJyUXpIVU55MVdKa0pSQVNERng3RldDNXcrYXp4cHVJLytjT2Y3?=
 =?utf-8?B?ZUwydVhOOFo2a2x3MC90MkdLTFFaVnFZQUp2bTdPOXBrTHhkWEdCV1NrK3ls?=
 =?utf-8?B?S1N1UVBGRzVuSElPdFBPcUtsRENXZmQ5ZnkyOHN3RGk2cWtrZTFYODBQcDZ6?=
 =?utf-8?B?NDhaSHhoRVZQL0RHbnp2SHBBYVp1YmtQdnNJZWhoa0pJc2tmOXAxYUNxN3hL?=
 =?utf-8?B?YVBvQ0hGQ0pBOStURnRuVmpDbzVhZ2lXcy9naExZU3RCeFpsbUtsRVBrOGZl?=
 =?utf-8?B?U1FrN01GNk1PL2pncmVlRy81YXVObllJTG0rQzQyQ2Q2anROK2JVSzNLQ0NB?=
 =?utf-8?B?NmtITWRuRmVZVmtnZkRiM3lFWlVod2dSK0tIQ3ZjN2IxRFlibVI3VjQycEVG?=
 =?utf-8?B?NEhka1NLTjEzVkZia2k5R2lBeCt3S1h4UmdDbDgwc0lKb3ZRRndMbWlzZGZS?=
 =?utf-8?B?UjhjaTRDVVRMS0lvaFUvNXEyNjZSYk15Rmx6djlwOTJQa0JRSFltNHhKUW5J?=
 =?utf-8?B?a0Rua0IrK0hQMlkzSmtkSU9pNGFNZWlVRGFYdm9JSmg0OFk2blIzTis0OWNO?=
 =?utf-8?B?Y24xbHVsVjVpUjJ3azQ4V01JUVc3Q3VneGNzeHJzRmpaU01UMHpTY1lyWkp6?=
 =?utf-8?B?V01uZzh0UmdsbzVHNEdpdEN6Z0FEUGVBVkZudHpRdXord0lhVkpzZ1gxTzZ1?=
 =?utf-8?B?QlhCZjlvM0tONGRFOWJ0Vi8rdUpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC57974D416B0147B744D89E71C6B5F2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84a2862-2fff-4263-42f2-08d9ecb1137f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 16:19:12.9172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUO62TYYUfWl0NAibNoMx9sgh4lIPPWFirC6e0Tyb9SquY1q7GsCRXyRoLf17zZSFI6wo/AL6YQGwxuDDt0gaGRrL2Rt/98wTyHTC9lftcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1853
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpPbiAxMC8wMi8yMiAxNDoxMCwgQ2hyaXN0b3BoIE5pZWRlcm1haWVy
IHdyb3RlOg0KPiBGcm9tOiBBamF5LkthdGhhdEBtaWNyb2NoaXAuY29tIFttYWlsdG86QWpheS5L
YXRoYXRAbWljcm9jaGlwLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA5LCAyMDIy
IDM6MzcgUE0NCj4+IE9uIDA4LzAyLzIyIDIxOjU2LCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3Jv
dGU6DQo+Pj4gSGVsbG8sDQo+Pj4NCj4+PiBJIHRlc3RlZCB0aGUgd2lyZWxlc3MgY2hpcCB3aWxj
MTAwMCB3aXRoIHRoZSA1LjE2LjUgS2VybmVsIGFuZCB0aGUgZmlybXdhcmUgdjE1LjQuMQ0KPj4+
IChodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9maXJtd2Fy
ZS9saW51eC1maXJtd2FyZS5naXQvdHJlZS9hdG1lbC93aWxjMTAwMF93aWZpX2Zpcm13YXJlLTEu
YmluKQ0KPj4+IG9uIGFuIGkuTVg2IFFVQUQgd2l0aCBpcGVyZjM6DQo+Pj4NCj4+PiAjIGlwZXJm
MyAtYyBJUF9BRERSIC1QIDE2IC10IDANCj4+Pg0KPj4+IEFmdGVyIGEgd2hpbGUgdGhlIHRlc3Qg
Z2V0cyBzdHVjayBhbmQgSSBnb3QgdGhlIGZvbGxvd2luZyBrZXJuZWwgbWVzc2FnZXM6DQo+Pj4g
bW1jMDogVGltZW91dCB3YWl0aW5nIGZvciBoYXJkd2FyZSBpbnRlcnJ1cHQuDQo+Pj4gbW1jMDog
c2RoY2k6ID09PT09PT09PT09PSBTREhDSSBSRUdJU1RFUiBEVU1QID09PT09PT09PT09DQo+Pj4g
bW1jMDogc2RoY2k6IFN5cyBhZGRyOiAgMHgxMzhmMDIwMCB8IFZlcnNpb246ICAweDAwMDAwMDAy
DQo+Pj4gbW1jMDogc2RoY2k6IEJsayBzaXplOiAgMHgwMDAwMDE1OCB8IEJsayBjbnQ6ICAweDAw
MDAwMDAxDQo+Pj4gbW1jMDogc2RoY2k6IEFyZ3VtZW50OiAgMHgxNDAwMDE1OCB8IFRybiBtb2Rl
OiAweDAwMDAwMDEzDQo+Pj4gbW1jMDogc2RoY2k6IFByZXNlbnQ6ICAgMHgwMWQ4OGEwYSB8IEhv
c3QgY3RsOiAweDAwMDAwMDEzDQo+Pj4gbW1jMDogc2RoY2k6IFBvd2VyOiAgICAgMHgwMDAwMDAw
MiB8IEJsayBnYXA6ICAweDAwMDAwMDgwDQo+Pj4gbW1jMDogc2RoY2k6IFdha2UtdXA6ICAgMHgw
MDAwMDAwOCB8IENsb2NrOiAgICAweDAwMDAwMDlmDQo+Pj4gbW1jMDogc2RoY2k6IFRpbWVvdXQ6
ICAgMHgwMDAwMDA4ZiB8IEludCBzdGF0OiAweDAwMDAwMDAwDQo+Pj4gbW1jMDogc2RoY2k6IElu
dCBlbmFiOiAgMHgxMDdmMTAwYiB8IFNpZyBlbmFiOiAweDEwN2YxMDBiDQo+Pj4gbW1jMDogc2Ro
Y2k6IEFDbWQgc3RhdDogMHgwMDAwMDAwMCB8IFNsb3QgaW50OiAweDAwMDAwMDAzDQo+Pj4gbW1j
MDogc2RoY2k6IENhcHM6ICAgICAgMHgwN2ViMDAwMCB8IENhcHNfMTogICAweDAwMDBhMDAwDQo+
Pj4gbW1jMDogc2RoY2k6IENtZDogICAgICAgMHgwMDAwMzUzYSB8IE1heCBjdXJyOiAweDAwZmZm
ZmZmDQo+Pj4gbW1jMDogc2RoY2k6IFJlc3BbMF06ICAgMHgwMDAwMTAwMCB8IFJlc3BbMV06ICAw
eDAwMDAwMDAwDQo+Pj4gbW1jMDogc2RoY2k6IFJlc3BbMl06ICAgMHgwMDAwMDAwMCB8IFJlc3Bb
M106ICAweDAwMDAwMDAwDQo+Pj4gbW1jMDogc2RoY2k6IEhvc3QgY3RsMjogMHgwMDAwMDAwMA0K
Pj4+IG1tYzA6IHNkaGNpOiBBRE1BIEVycjogIDB4MDAwMDAwMDcgfCBBRE1BIFB0cjogMHg0YzA0
MTIwMA0KPj4+IG1tYzA6IHNkaGNpLWVzZGhjLWlteDogPT09PT09PT09IEVTREhDIElNWCBERUJV
RyBTVEFUVVMgRFVNUCA9PT09PT09PT0NCj4+PiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6IGNtZCBk
ZWJ1ZyBzdGF0dXM6ICAweDIxMDANCj4+PiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6IGRhdGEgZGVi
dWcgc3RhdHVzOiAgMHgyMjAwDQo+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiB0cmFucyBkZWJ1
ZyBzdGF0dXM6ICAweDIzMDANCj4+PiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6IGRtYSBkZWJ1ZyBz
dGF0dXM6ICAweDI0MDINCj4+PiBtbWMwOiBzZGhjaS1lc2RoYy1pbXg6IGFkbWEgZGVidWcgc3Rh
dHVzOiAgMHgyNWI0DQo+Pj4gbW1jMDogc2RoY2ktZXNkaGMtaW14OiBmaWZvIGRlYnVnIHN0YXR1
czogIDB4MjYxMA0KPj4+IG1tYzA6IHNkaGNpLWVzZGhjLWlteDogYXN5bmMgZmlmbyBkZWJ1ZyBz
dGF0dXM6ICAweDI3NTENCj4+PiBtbWMwOiBzZGhjaTogPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCj4+PiB3aWxjMTAwMF9zZGlvIG1tYzA6MDAwMToxOiB3aWxj
X3NkaW9fY21kNTMuLmZhaWxlZCwgZXJyKC0xMTApDQo+Pj4gd2lsYzEwMDBfc2RpbyBtbWMwOjAw
MDE6MTogRmFpbGVkIGNtZDUzIFswXSwgYnl0ZXMgcmVhZC4uLg0KPj4+DQo+Pj4gSSB0cmllZCB0
byByZWR1Y2UgdGhlIGNsb2NrIHNwZWVkIHRvIDIwTUh6IGluIHRoZSBkZXZpY2V0cmVlIHdpdGgN
Cj4+PiBtYXgtZnJlcXVlbmN5ID0gPDIwMDAwMDAwPjsNCj4+PiBidXQgdGhlIHByb2JsZW0gdGhl
biBhbHNvIG9jY3Vycy4NCj4+Pg0KPj4+IElzIHRoaXMgYSBwb3NzaWJsZSBidWc/DQo+Pj4NCj4+
Pg0KPiBIaSBBamF5LA0KPiBUaGFua3MgZm9yIHRoZSBhbnN3ZXIuDQo+DQo+PiBUaGUgYnVzIGVy
cm9yIHNlZW1zIHRvIGJlIHNwZWNpZmljIHRvIHRoZSBob3N0IGR1cmluZyB0aGUgU0RJTyB0cmFu
c2Zlci4NCj4+IEhvdyBsb25nIGRvZXMgaXQgdGFrZSB0byByZXByb2R1Y2UgaXQ/IERvZXMgdGhl
IGlzc3VlIGFsc28gaGFwcGVuDQo+PiB3aXRob3V0ICItUCAxNiIgaVBlcmYzIG9wdGlvbj8NCj4g
SXQgdGFrZXMgYWJvdXQgMTBzIChzb21ldGhpbmcgYSBiaXQgbG9uZ2VyKSB0aWxsIEkgZ290IHRo
aXMga2VybmVsIGVycm9yDQo+IG1lc3NhZ2VzIGFuZCBpdCBkb2Vzbid0IG1hdHRlciBpZiBJIHVz
ZSBpdCB3aXRoICItUCAxNiIgb3Igd2l0aG91dC4NCg0KDQpJIGRpZCBub3Qgb2JzZXJ2ZSB0aGUg
aXNzdWUgd2l0aCBteSBzZXR1cChTQU1BNUQ0IFhQTEFJTkVEICsgV0lMQzEwMDAgDQpTRElPKSB3
aGVuIHRlc3RlZCBpUGVyZiBmb3IgYSBsb25nZXIgZHVyYXRpb24ofjEwMDBzZWMpLiBJIHN1c3Bl
Y3QgdGhlIA0KaXNzdWUgY291bGQgYmUgcmVsYXRlZCB0byB0aGUgU0RIQ0kgaG9zdCBjb250cm9s
bGVyLg0KVHJ5IHRvIGRlYnVnIHRoZSBob3N0IGNvbnRyb2xsZXIgc2lkZSBmb3IgdGhlIHBvc3Np
YmxlIGNhdXNlIG9mIHRpbWVvdXQuDQoNCg0KUmVnYXJkcywNCkFqYXkNCg0K
