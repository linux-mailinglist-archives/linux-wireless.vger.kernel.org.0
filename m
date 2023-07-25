Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D05761D24
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjGYPSs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGYPSr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 11:18:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ABDE2
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690298325; x=1721834325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZwMVzlPDyJRijOh5CFnsnpPZ7Qw/0KqN675RNI7dln0=;
  b=LNkRIVw85jKHrD35GVrR60TmVwiiYLT5mC5Sup69MpozdDOpcKQ3xkyd
   OL0W6tLjMKVDjR8DayA5f8zZcVeiYDlUD1qv+kzlMOaCdSw802YzESj+B
   2yZQYpJTUn2ikdmMy4e/S1IszmzE+ywBPTRKXe6URGIevICkwJBlvVl18
   IFfDP4erh5dAh95gbHa3mHd7iJEtY6ARO9ClIvDjlFtEaorc4dkdHkrWt
   pKacQmsQ0QO1vBs/qtxP3MyQo24YJEja0gwoQnWypQXuiex/jGXrDZOqD
   lP1pCPG6qDacssSjy3Ws++V5G2rbw5kvufIDlyo7vfqRxZVnbA0dZCB8f
   g==;
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="226450974"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2023 08:18:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Jul 2023 08:18:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 25 Jul 2023 08:18:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/D3GgoeyJv9J8q9jiyfDHbiZU5P7HilUu0aiG7yk+HhnRbZSPdCHTU8J7nQxdnK8fyhEIx/9dCdrYvqC7nz0joCZ4W5SRCd5RjDs3R0PkbMpkdizsLioIRtlxgw91WGDPWUQfWt5ZxJLkgkqTimcbBpTLxRYZLZ/i+Ezh+nOi8R2pzhYNgiLJuDIEGivhP9MvrwDDjHhCUfrwU6Y6+EL1fggK7h3l7O3nNbiZVftYWebT3y7x4jM1omtVLXGqznvLQPIBx4uokM1o6rqinC1rkaCfdcQHQCiz3vE/OphsxITMvp3Xs1s6LLAuxgI9U81542un2y1Lvoa7Szs0czkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwMVzlPDyJRijOh5CFnsnpPZ7Qw/0KqN675RNI7dln0=;
 b=dq90ALOYbJwhaO/BsPA7X/LeGskadIR3Tao8EjDr8ttRX8Q60rNrEcbB9q9z1zrRG/K9t0nZqNy0ddg2XvW8yxADFoH6gy/kvMda2PB7wpmGiD3mUZ+/AIFonUHx5G7RXyASocy0gl+hkGTruB/XNZr0sddMwZEmM5JG9DGd2eQ2C5aQlnM7FF33ch9Totfll7f/GVvk77kNp8ZJgX5lRGuks8WfTI8pYAObiUk3bac3IVgJYQzCf6QvTz1tpRZg3nFDqD1ao0eIL7pr60lPUeOavQZdvTGVAHqMd3XZtci2HRvELiLEdoHqKZNvF8H9ejeVmM+VaKIPzcgC1bSEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwMVzlPDyJRijOh5CFnsnpPZ7Qw/0KqN675RNI7dln0=;
 b=itaPY4pzrCz3dKNP/JBOFQfjtn2jSRNAtW0eZMHyGk6N6s3ZAYgscAZHK455SfaV0AIWLvOZIptTNMQYuPzOaSzt2HU4JtKK46h2IYIxcUQmxTMmjzVBUDdaZE750ZUFDR9cb+SsfnWwmnPfYKoz3EtA78jVxmQeonrgR+mt54g=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 15:18:43 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d2bc:dc06:50ad:3dbd]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::d2bc:dc06:50ad:3dbd%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:18:43 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@kernel.org>, <Prasurjya.Rohansaikia@microchip.com>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] wifi: wilc1000: remove use of has_thrpt_enh3 flag
Thread-Topic: [PATCH] wifi: wilc1000: remove use of has_thrpt_enh3 flag
Thread-Index: AQHZsxMPwXszMpuH1EGsdQmB8pBnWa/KrD+AgAAEMYA=
Date:   Tue, 25 Jul 2023 15:18:43 +0000
Message-ID: <dfdd2fef-1e35-7f63-1d1a-fa44dd2acb27@microchip.com>
References: <20230710094401.235222-1-prasurjya.rohansaikia@microchip.com>
 <169029741972.3309254.9562766790738793480.kvalo@kernel.org>
In-Reply-To: <169029741972.3309254.9562766790738793480.kvalo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|DS0PR11MB6351:EE_
x-ms-office365-filtering-correlation-id: a37235db-8119-4461-54a4-08db8d226ee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dm1cja4HdOsQuBwMf7TByrnTNLmFCRFLjC1OmHq+K3TLTCuaq+pKRwbXDIyBh2Qbe6gNeRCI3PokyX32U42URore/yvAe3FeqZD2NZQSmOTfOEVtk6l1r3SL6zOrTCaQQmKhg675HU0cZeqvQXIFR2qgznJCTdHEcipQ8k5qQttxqMjIMbY3ujZ4PDtgfkeqATrr5pN/N4pTXNukJlPnepn9zUFC1qEMzSCK+UtSZehP8YyGIiP5a4HPG4Lp2sBDQW3FU5PO+JhEbByiInnbz8aKt7mggaBsMYtBsNrHTm1X6NaR5rGslyPMGDNCfLE1Gv2h2Pr9lKbdcDcEgKN7dvQKHqTqg7UG9Q0pqgAXFBtEWgNL23F2+BxNvAmVw8mg96lMXzwO4B1oGmoFiEsarXTPHBNE3cVzGTZ8Orz3g1FqHIMpLtRZJk6uDyfzgwCmXxA/oHhFeF5UA55ZiP9KUUkmOHYcbB2WexFqLztd1IZx2M/oTbrEh2JIZ4m6OK0VSz6D5iriTcRxRpCemXtLFAoe/v9jGwcyJFpKW9gpko76NFm5pOQ4ORUdhAKy6yeoxNYZYHZJ+4bxfqdfjdVwL23tsOJI+KEJgz27Hy58rgaMaDc0BZYTZezwqmmuVpdPEaLnPWNMeBkYuERULSGgRA/5IKZh3HUtNSO/VRzhB8s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(86362001)(31686004)(31696002)(38070700005)(38100700002)(66556008)(66946007)(6636002)(54906003)(110136005)(478600001)(41300700001)(76116006)(5660300002)(8676002)(8936002)(66446008)(6512007)(966005)(6486002)(2906002)(4326008)(4744005)(64756008)(71200400001)(6506007)(186003)(316002)(26005)(122000001)(66476007)(53546011)(36756003)(2616005)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a05KbVdjZ3BTNXU2cSswckpveVZtVStDSWpTRmxIbkZoVG9TeUhFSGhZNFpP?=
 =?utf-8?B?SVZ4bmFRb1BMaHVYQysxbmZTSkxoRnZnWWh6Q0tNZTFXenVnMGVaVWUvT2dk?=
 =?utf-8?B?MlplMGZ6OFAyTW84QnNFT25xY3JNTWxRL0FVM0tlVXdqWkJWM1JVNk1YWEVS?=
 =?utf-8?B?M1k5ZzRPeFpDMnBWcnRyOGFnYnQ4S3M2Sm1JeXJzR0s2YkdWenVnSVIyTC80?=
 =?utf-8?B?M0VXaWJlUDNTMVVmanRRdDlrMUNWM1Y3T3R2b0Fwem5WVTJ3akpibGpWcjZt?=
 =?utf-8?B?T3VFc3NQTVNSOFdxSjBDaG80dzNieVg4K0NndXFiME9nV2lqK0h1djZ0RUlJ?=
 =?utf-8?B?bkc4eU43UHl4SjBzc1BBeEJaNERaUzI1d1MzeFZwKzRYUXlBUk50OUUvb0NY?=
 =?utf-8?B?UTNjZitvTVNBYXpQKzFVdUxYQmE1TCtsUFZLK09nOG9QdW9Qd3o0WHRLNWFl?=
 =?utf-8?B?ZWNuT2tvUDlETUdxdlFEb1VVY3dablhEMWk4VEl4YUNNYlgwN1NFWElGdkxT?=
 =?utf-8?B?MUZFOWdndWZIQ2dKWVVhU3oxbEpkSzU4bnVlUzlvWUpCNXJpMUJOeFgraHVD?=
 =?utf-8?B?Ni9nME1nVzVsWUZUUzdUYWRQNjZJc0dGK01vU2t4YnBCb0VleXlTUzlxa0h2?=
 =?utf-8?B?dHRjcm1XYmExNndzUVJwSlhtYmw4QkdsYTdYbmpvSGlPaUFxb01GaGlpRTNx?=
 =?utf-8?B?NXlhd01zSU9LK3JVa0ZvZVVYTTdsR2dKamRrM0RTMjEvcGlLbVdGbXVJYU1k?=
 =?utf-8?B?VmJCMEZYUzJLRXdneDh5VFlXdHNTdDFsblViK1Q3dTRaWmhRVVBwUXVQb04w?=
 =?utf-8?B?ZmRVU0xFVlU5TVNNWml2ZW0vY200Tlk5WEdVSjRFblU3eDhrTEFTc3VTYzU2?=
 =?utf-8?B?bzMzZjFGeEZhOXpmTTltMHY1bkNpaWdWYnRrbUZXNStNclU3SWlsMEJLN2R5?=
 =?utf-8?B?Q3VIZ2lZSTI3MkJFMlJxTEREWStrL3BXYyttbkdBVSsvU2k0R0RQMVJwS2RL?=
 =?utf-8?B?d2w3UGFmcHFXcWYrUlBDVzZ6blZsRU0xQTZFUFY0UjBxUUVWeVdVcVZOdlEy?=
 =?utf-8?B?YmdZY3NxRUhvcG5PNnY2VXJIajMxZHZpMitxaS9wZWV3Tk5NNnNDbWlhS2l1?=
 =?utf-8?B?aEZTbE4yVEkycnBkT2pjQk9Ud2U4MEFmTWl0VHNaVCs5NlZUeU9nWHYzTkhZ?=
 =?utf-8?B?ZDVjcXRDdWlYM0hMaXhjQWFMTFpLRmZURFM4Kzh5ZEMxUExwQ2FmZXo2UzBY?=
 =?utf-8?B?N2pNbFNhOVJKb0xvdGlCNlIzQmxJcXovcFBVdW1TMEYwaGY3dFI5MFQ1N3ZR?=
 =?utf-8?B?OTdrNnN4ZjFKR3RCd3ZabjdBa25ML29YcCsyL1FIS1BjeHhDK1lBWUZRY0FD?=
 =?utf-8?B?ZnlvODZoY09kZ3FNMzZDMmhnNVlZV0ZoUlJhMWpNdTVXYThkWjZPMTFKSzlp?=
 =?utf-8?B?WWduS0VMNHVkTUxJc20wY1R3UWN2WXJxMkFhcHgyeS8zRzU5WVZwZTVYVVMv?=
 =?utf-8?B?cEFwV09TNUI1b3BhNEtieFNLQVlzd3E5S0RQVkRJbnU0eGYzc3h2OCtwVFBh?=
 =?utf-8?B?bEVwc0FOVXc5M2p3UnJvQ3JORnhnMm83TTlFSmRZZThKS2t4dG9TaWdkS2Ni?=
 =?utf-8?B?WmQyUmc0a3lEeTFhcFp0K0xSd1Y0Q09CMER6bStucHFwaTZuVkJOWFBmY29O?=
 =?utf-8?B?aXJPeWF3TE54MUd2MlllTTN2NGRrNHNTZFByMUY4dDUvTzVnc1dWVHpXVlNn?=
 =?utf-8?B?Q3Z2MlhpRUdPQ3MrQ0g0NlB4Nmc1bVQ1dG93R2xPcVhwSWI4S0dtRzlQZHFa?=
 =?utf-8?B?blo2ck1lRmhoa1pROVNnWisvQjlXSFN6a096U2tKZ0NjUlNhdEpNVG1wYzlR?=
 =?utf-8?B?d2R3UzJMQ0VKL05HK1U1Nm1CamZhR0pkVnZiRWVCbWhjaVYweHo4OHFkRWNq?=
 =?utf-8?B?aVVNVk5tQ1ZWQnN4ZmVMNnV2bDZRaUNQVTJYeUsxSmhXRDRuUENPbUFPRkNZ?=
 =?utf-8?B?T01lRTVFRmlBN3NXZjJLMjVtWmFOL2drMXRvWllOM1lXREIxMVhtMDN0dzdZ?=
 =?utf-8?B?dWE0V25lOS95eTBpRHNQOWFxbTFsR0o5WG5pU09vWXgwTXhKYm5ncEc1QWtI?=
 =?utf-8?Q?DBMgudHa9P92X81BlRPFuu8nG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE0D8E8B8AD11B47AF4DEB7181D58876@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37235db-8119-4461-54a4-08db8d226ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 15:18:43.1528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZHFzhDMSYBgrV5TBKsVEPpMlEWH+fGxfeJG0lbX/62O3LBuvg7T6zw0cwBnDr8RiyxrVAzoYZ57/uVRVX4cf/Mu4gxeWQMRXo1S91MtOiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gNy8yNS8yMyAwODowMywgS2FsbGUgVmFsbyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiA8UHJhc3VyanlhLlJvaGFuc2Fpa2lhQG1pY3JvY2hpcC5j
b20+IHdyb3RlOg0KPiANCj4+IEZyb206IFByYXN1cmp5YSBSb2hhbiBTYWlraWEgPHByYXN1cmp5
YS5yb2hhbnNhaWtpYUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFRoZSAnZW5oYW5jZSB0aHJvdWdo
cHV0IGZsb3cnIGFsZ29yaXRobSBpcyB1c2VkIGJ5IGRlZmF1bHQuIFNvIG9sZGVyDQo+PiBzZWN0
aW9ucyBvZiB0aGUgY29kZSBhcmUgcmVtb3ZlZCBzbyBhcyB0byBhbHdheXMgdXNlIHRoaXMgbmV3
IGFsZ29yaXRobS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQcmFzdXJqeWEgUm9oYW4gU2Fpa2lh
IDxwcmFzdXJqeWEucm9oYW5zYWlraWFAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEFqYXkmQ2xhdWRp
dSwgY2FuIEkgZ2V0IGFuIEFja2VkLWJ5Pw0KDQpBY2tlZC1ieTogQWpheSBLYXRoYXQgPGFqYXku
a2F0aGF0QG1pY3JvY2hpcC5jb20+DQoNCj4gDQo+IC0tDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIzMDcxMDA5NDQwMS4yMzUy
MjItMS1wcmFzdXJqeWEucm9oYW5zYWlraWFAbWljcm9jaGlwLmNvbS8NCj4gDQo+IGh0dHBzOi8v
d2lyZWxlc3Mud2lraS5rZXJuZWwub3JnL2VuL2RldmVsb3BlcnMvZG9jdW1lbnRhdGlvbi9zdWJt
aXR0aW5ncGF0Y2hlcw0KPiANCg0K
