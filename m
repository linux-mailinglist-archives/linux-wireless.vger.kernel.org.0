Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC187A271F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 21:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjIOTVj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 15:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbjIOTV1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 15:21:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94798
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694805682; x=1726341682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ary/uo4SY5HnHAJMp1DJjkE6Z/Vw1ZqDhS+ivz6Qafk=;
  b=SvQzRqMRCRxKOxpMDvXj95LmKtYHB9NOtH2BbskwFlaBn23SNvLYgXxK
   K9PIganuq0cllQ5QiEoRamdztfoQaTNJYK15PH95sAomBQ+ZLjD3o/Mkk
   2jecwSVpwPUIRpTtFqjb0uX3uLPfgOjbMPmAD3LO6nMAGV/EovlExGk3q
   cdcIHG8TLBwIRTkHUqbSHf3OFHcyakw0BSGw3o4NWehXhCAndiq9EkCUK
   FybrhU9mlGAn+3Zu/illtmW/3cbK9Fe8LTr1xdzdEXwjr4kltRVXntprd
   Xrn+3HapFjw1VI/wJkW7XoKbZSpE4uhmPFFS/OzrmxP7IO0Dsgp/d8Idi
   w==;
X-CSE-ConnectionGUID: uKAxUMURTNWY8mD2Kh+25g==
X-CSE-MsgGUID: o8DGhPGFQJ+3UHRH41Et5A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="171915928"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 12:21:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 12:20:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 15 Sep 2023 12:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND/j102YNMED3OwUNWamGrRXI5MD4Lt33JemxIh0glzRjnY/zXNxTe2w8LK2ClDWTnkfrH4l/IHbMNdAknQIaE3iPxFJmQoGhQC1dWFaw8XSgsruvIurED8YajsvTnWpJCPD7LDjdwSzncXfPT5bARO96FBOdVUIn7Dkjh3PA3+zUxSMM1++dxnvVxVVQYyREljORL1i7rEO2BTd1EPU2rMY4a41XIfaUHID1mR7zaDAQyOqeKVNX7JXxuQ7gK1hQYAkS15nDM5beGt3zM+54nKFA5T7gs1ZoQ+axikaWMaK/KJsT0thofAkJ0n4ngyuNj2uBfj0kxG9+QDrt4sFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ary/uo4SY5HnHAJMp1DJjkE6Z/Vw1ZqDhS+ivz6Qafk=;
 b=YjCKutDMYZvHebHkpWTbSp/ZGPh9ZnVEyHVgMv46dbN3elftovjVhDu7LVXx3FDxISk9X8sarGwuh5Fw7nseGObjMw33qoSGTMXA2z8dCV2PryLA4G23QkRVdVWQ2QkWvl1J5dRbTGdAdNJWfus+Mqm4XclsXp1gEQkYe3FWx4qBd/9U2pxBeb5lL989B8HcCqgg0S7vCj4XIueKlDX3732STLklIdrKeQ08Fkq3mTpIbZFHwOaiDZQIk6biTCFOHtTaRjeHe+BRo4zAGgjJMy7ck0F/TL92cb/SGuPjjWAzElZ7BhcXeH7ZBLbWNeECI8DrabxUCTTQigPzlCEkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ary/uo4SY5HnHAJMp1DJjkE6Z/Vw1ZqDhS+ivz6Qafk=;
 b=jSTYP/Brv4oboqSEsmSgxtWWPCEmkjYVBLMu+FuTpUn/9r3WVxz7trwj6QA6Nkrd19kfJSqoqFlqmDrYkQ60gv411r6MAqZymly65R4BppAKTaV8koAd2zkq6Y0tgaIGypr7n/MVSHj9CTcfjAxM/lnZo6YqPhf3NpyhFLGwvcA=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.22; Fri, 15 Sep
 2023 19:20:46 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::360d:b35b:51e7:f5af]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::360d:b35b:51e7:f5af%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 19:20:46 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <Prasurjya.Rohansaikia@microchip.com>,
        <linux-wireless@vger.kernel.org>
CC:     <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4] wifi: wilc1000: add back-off algorithm to balance tx
 queue packets
Thread-Topic: [PATCH v4] wifi: wilc1000: add back-off algorithm to balance tx
 queue packets
Thread-Index: AQHZ5/6Jc1ibUt2jf0mdH6PjQte6nrAcQ3IA
Date:   Fri, 15 Sep 2023 19:20:45 +0000
Message-ID: <2f9fd8fe-af4f-2957-ae5f-3e1729317d8e@microchip.com>
References: <20230915175946.4361-1-prasurjya.rohansaikia@microchip.com>
In-Reply-To: <20230915175946.4361-1-prasurjya.rohansaikia@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|CO1PR11MB5092:EE_
x-ms-office365-filtering-correlation-id: 12c3c352-86fd-4324-eb96-08dbb620dc5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pl5J91Omk8ujiIteoDq/41BP2qY/kTeRLk2O79yXB2wiCEX6dlkQ97+7j+yJ0UUW0+JdPl/pCODBM8RWfRYUa/mMKqlGM5MLyEZgMsbzEvsxzBVOVNoVozdspUMUcvlBLZg2GSHjrUqnYQA8bV5BtbRs0XF92UoUDs0/nMCa0unnl5KO4dLwYrAn4xbbt/7tR31VvFOWTlzAqq2xoBOQC+XAZKepixhGvmDSzKOS1cAA9WV3Ru5XIY1K2/7ceGXJ0UjYR16rxCwoL/GcasNTSjiYoG/x9uiXXQCMh3vbIRFxCJggodOitdUORGJdMGqiIoHpJXcZ39rTgHSybgOsZDuI0iaEia9WYgkwUmO8KdTdzH+3i8zCM0ZyCW7rLzr7Eqr2q1WcBecJK5PhwZs82BAipad+cGKIJjU5v9N82lo5Pg4oCqHgr9RzaShbYH9PrkvF4Jwtsta676+Gl9Lmwd9CZvZQnbJGLLHhNQEJcCmKGZWOm2sGR3Rs3v/ZN3v6aO/C1ehEJXvLCWxtvgyvmE9jliEDlQPwlobaLfd/HmADO73JSXcfevsCPIfJcjiWZHckT1JjBkauOlqmz7GhOCTPiKVQnIGtnkjcNC0H4ajl13gW0flrejyzKt0Ykz3yqDhcw+A6AjF5Fyv3NkskgvqhT7g1k8+8t0bFy7bwKORdVgAbTUTaX57CcUvvKgJl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(1800799009)(186009)(451199024)(122000001)(53546011)(6506007)(6486002)(71200400001)(6512007)(478600001)(83380400001)(107886003)(2616005)(2906002)(64756008)(66946007)(76116006)(66446008)(66476007)(66556008)(8676002)(316002)(110136005)(4326008)(5660300002)(8936002)(41300700001)(26005)(31696002)(86362001)(36756003)(38070700005)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0lEVmRiRGpaeWdxTnhvb3lUQm1lczRwelF5R2xLYTBRNzlBVi90YVRqZnhP?=
 =?utf-8?B?cGRVcXV1bVBEMzhlNHY3S0E4eEgxWXFBSXh5bTFLUW52bVVuQVMyNEd1Ujl2?=
 =?utf-8?B?UXgwUnNiVk9MaUo3eGNJWUMyV01ycHByb3dlRlBsL2Jvbi9YRzBmZE0xRkdH?=
 =?utf-8?B?amczaTJtR2doS2dXcHVzWFNMWDQ0QlhoVmJlaDJMTWQ1bjNycG84NmZiazdy?=
 =?utf-8?B?MUlmVkNTM09CRkFpcnYwdEhaWitzby8zcjdMKzVNTURDNFpnSldhK0l5N3Bn?=
 =?utf-8?B?TitmRjVoQWxFejNBMTZnZFJ4YmxKUi9Rd2hJaUlMTklWN2k5T0RFTmRQQmZu?=
 =?utf-8?B?Y0JQeXdQZUlYU0N3aU0wTENxUmxZNXQyaFhUUjRhZE9aNVRRSWRqUlJpTG5Y?=
 =?utf-8?B?OXZCNDE1SzJPZW9Id2kybS8wRDhTTFZMc1VsdGZSR0QrdTRxdjIxL3BsS0xj?=
 =?utf-8?B?S1RCajZZSWgwdDRweTNHbWZ3cG1ySDB0MmFiVEdiK0UzeDFySWh3Ym9rVTA1?=
 =?utf-8?B?UjZTTVVjTEplamNaWWQxcFpVR1JPbnFieGtmbXduNmp4bWFKMGhlTHZBT01l?=
 =?utf-8?B?dGRLdGhiRG9HR25qMzExYjBTQ1hEM2xmOExGcmJtWGxTdVY0QXZRaXo2dmxr?=
 =?utf-8?B?QkNlRmZmSEVEOE9sQWxVWXNkeTRkMkNJZENlUTBTYU5yK0xnZVdSL1d0K2FI?=
 =?utf-8?B?M2tNOFd1ODIxZ3JObEs4K0FIOUFCZzUrTStZQW5ZK1BvcUpJTWVsQjl0ZWxn?=
 =?utf-8?B?VVN1K0hibkgwaTJJN2g5a1RkeHgxdVZjWUNDdFNkVGhUYW1uWWVFU0toYXFX?=
 =?utf-8?B?Z254UzZmR091eC9vTFE1dWlHaDRBa0VWdjMyRlNTREdMT0xqUDdXZGsxMVRX?=
 =?utf-8?B?YnVUWTZSNFVDcUhEa2kycElpUGlsZjZOU3pvNG5DQ0N0bDh4bUwzK09wamEr?=
 =?utf-8?B?aHRpT2FaNTN2dTdoQlF4WTE4QkVCSWwwdWtWZ2I3L1doNGJKWTJrYVZ2a056?=
 =?utf-8?B?SXpTaXRiYlFQOUdXc01yMUYrWGRSNS9NZ0JhelZ2Q1VLTHArVllnRUlMajlo?=
 =?utf-8?B?YzRIVEMyZ2NsWjViMWxieWdXd1Z6cVR5b3lCVCtWcmg0TEdDYzdvR0NMTTBM?=
 =?utf-8?B?a0duSkY0aExUNzdvN1ZYUDVPUkM1VWVrQ3YwTFB5Q2o0ekVKWlZsem9qNitV?=
 =?utf-8?B?OG8vUkhtZXgyWGRQUGxUeHRTendleG1uWWwxTnI2T2ZhRkVtNXVNMldkSGJj?=
 =?utf-8?B?cFdwNUNvdmhnRWdvbWpxeitoUUYvcmRvdzA4M2xjUDA1QWEySWoxSUVtNlc5?=
 =?utf-8?B?OWRiT25pbFJBLzhERk0zUkpaRnNCcUFVdjB4cWlpTzZxaDNnQ3FYQzJiR0h4?=
 =?utf-8?B?U2dVcnFObFUrVUFxOU5jNzBDTExnOGpYVTdsdDRSR2FqVmgxTUtoaTBNT3dR?=
 =?utf-8?B?RVZMWTJ3bUVYL0NDeEJEMyszaWd5L2hXZHlKMWlOR0FsNWJPKzZ3bFFhbGZD?=
 =?utf-8?B?aHpUUzRObkFxQnB2QVZTS2ZvL1JINjM3M05GWDdvYjgxVm5HVDd1YmkrbnVK?=
 =?utf-8?B?YkRGdzMrK0pqblc3d3NzcjJiditHRDhmZmZScmErU3VqUHBldmQ5VSsxdnVu?=
 =?utf-8?B?L3UwL1RQSjdlZFRrbUF1QTRvY0QwbGdXK3gzRXpRdXdVaWltL2lBUHF5UG95?=
 =?utf-8?B?QVJBZXFqNk44Kzl6ZUFMck8yWmt1QVpPTFdVR21nU0p6T21aSzI3WElMeXhF?=
 =?utf-8?B?ZTVocWc3azIra3gzN1JyaWJ1NWFJTTV2MEhrUm9Ldlo3SllQekJuQVhQdWZO?=
 =?utf-8?B?NndwQ3d0bWJUb2VodE1ySGhackFYVVFWbWhJN3lhaVoyOGo1NC9JWldDYWNW?=
 =?utf-8?B?UHdKYmZiVFEyWERHNWFVVlZEYm4yc3k5cXRNQks1bGNmL2tGYWpVamNuSCtu?=
 =?utf-8?B?c3dlN3N0VXpocUpOK3k4d2F4WWt1aFRaM1MzeTlVaS83NDdBN2FIT05hbEhW?=
 =?utf-8?B?UU5YOUtlalh4cDdkNis0Uy9ZYS9NN0Z0TzBKTHBXMlNGODR3Yk1PRHBjYzlD?=
 =?utf-8?B?OFNDWDR6bHJLVWE0eThIVEhmY0dUek1ZNnNUbFhYcS82VGlWbHlEaDl5M1Ry?=
 =?utf-8?Q?uGr1lW2pXrlfwty5uOYf5bIUX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CDD346F7351DD4A83A768FCDABDABBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c3c352-86fd-4324-eb96-08dbb620dc5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 19:20:45.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Et8n4nOldsHDko92I21FR+Ijb6RThFzIn66irfKZmPf31P6Nt1px28TeLKBtZqzNrW11GF/Npqt07Bm01JsGF0WRNaSg+Ktq5SNpq6d96yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gOS8xNS8yMyAxMTowMCwgUHJhc3VyanlhIFJvaGFuIHNhaWtpYSAtIEk3MzY2NCB3cm90ZToN
Cj4gRnJvbTogUHJhc3VyanlhIFJvaGFuIFNhaWtpYSA8cHJhc3VyanlhLnJvaGFuc2Fpa2lhQG1p
Y3JvY2hpcC5jb20+DQo+IA0KPiBBZGQgYW4gYWxnb3JpdGhtIHRvIGJhY2tvZmYgdGhlIFR4IFRh
c2sgd2hlbiBsb3cgbWVtb3J5IHNjZW5hcmlvIGlzDQo+IHRyaWdnZXJlZCBhdCBmaXJtd2FyZS4g
RHVyaW5nIGhpZ2ggZGF0YSB0cmFuc2ZlciBmcm9tIGhvc3QsIHRoZSBmaXJtd2FyZQ0KPiBydW5z
IG91dCBvZiBWTU0gbWVtb3J5LCB3aGljaCBpcyB1c2VkIHRvIGhvbGQgdGhlIGZyYW1lcyBmcm9t
IHRoZSBob3N0Lg0KPiBTbywgYWRkaW5nIHRoZSBmbG93IGNvbnRyb2wgZGVsYXlzIHRoZSB0cmFu
c21pdCBmcm9tIGhvc3Qgc2lkZSB3aGVuDQo+IHRoZXJlIGlzIG5vdCBlbm91Z2ggc3BhY2UgdG8g
YWNjb21tb2RhdGUgZnJhbWVzIGluIGZpcm13YXJlIHNpZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQcmFzdXJqeWEgUm9oYW4gU2Fpa2lhIDxwcmFzdXJqeWEucm9oYW5zYWlraWFAbWljcm9jaGlw
LmNvbT4NCg0KQWNrZWQtYnk6IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+
DQoNCj4gLS0tDQo+IHYzIC0+IHY0OiBBcyBwZXIgcmV2aWV3IGNvbW1lbnRzLCByZXBsYWNlZA0K
PiBzY2hlZHVsZV90aW1lb3V0X2ludGVycnVwdGlibGUoKSBieSBtc2xlZXBfaW50ZXJydXB0aWJs
ZSgpLg0KPiANCj4gdjIgLT4gdjM6IFJlcGxhY2VkIHNjaGVkdWxlX3RpbWVvdXQoKSBieQ0KPiBz
Y2hlZHVsZV90aW1lb3V0X2ludGVycnVwdGlibGUoKS4NCj4gDQo+IHYxIC0+IHYyOiBSZW1vdmVk
IHRoZSB1bnVzZWQgYHRpbWVvdXRgIHZhcmlhYmxlLg0KPiAtLS0NCj4gIC4uLi9uZXQvd2lyZWxl
c3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5jICB8IDIwICsrKysrKysrKysrKysrKy0tLS0N
Cj4gIC4uLi9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5oICB8ICAyICsr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAw
L25ldGRldi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRl
di5jDQo+IGluZGV4IGU5ZjU5ZGUzMWIwYi4uOTFkNzFlMGY3ZWYyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5jDQo+IEBAIC0x
NDgsOCArMTQ4LDggQEAgc3RhdGljIGludCB3aWxjX3R4cV90YXNrKHZvaWQgKnZwKQ0KPiAgDQo+
ICAJY29tcGxldGUoJndsLT50eHFfdGhyZWFkX3N0YXJ0ZWQpOw0KPiAgCXdoaWxlICgxKSB7DQo+
IC0JCXdhaXRfZm9yX2NvbXBsZXRpb24oJndsLT50eHFfZXZlbnQpOw0KPiAtDQo+ICsJCWlmICh3
YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGUoJndsLT50eHFfZXZlbnQpKQ0KPiArCQkJ
Y29udGludWU7DQo+ICAJCWlmICh3bC0+Y2xvc2UpIHsNCj4gIAkJCWNvbXBsZXRlKCZ3bC0+dHhx
X3RocmVhZF9zdGFydGVkKTsNCj4gIA0KPiBAQCAtMTY2LDEyICsxNjYsMjQgQEAgc3RhdGljIGlu
dCB3aWxjX3R4cV90YXNrKHZvaWQgKnZwKQ0KPiAgCQkJCXNyY3VfaWR4ID0gc3JjdV9yZWFkX2xv
Y2soJndsLT5zcmN1KTsNCj4gIAkJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShpZmMsICZ3bC0+
dmlmX2xpc3QsDQo+ICAJCQkJCQkJbGlzdCkgew0KPiAtCQkJCQlpZiAoaWZjLT5tYWNfb3BlbmVk
ICYmIGlmYy0+bmRldikNCj4gKwkJCQkJaWYgKGlmYy0+bWFjX29wZW5lZCAmJg0KPiArCQkJCQkg
ICAgbmV0aWZfcXVldWVfc3RvcHBlZChpZmMtPm5kZXYpKQ0KPiAgCQkJCQkJbmV0aWZfd2FrZV9x
dWV1ZShpZmMtPm5kZXYpOw0KPiAgCQkJCX0NCj4gIAkJCQlzcmN1X3JlYWRfdW5sb2NrKCZ3bC0+
c3JjdSwgc3JjdV9pZHgpOw0KPiAgCQkJfQ0KPiAtCQl9IHdoaWxlIChyZXQgPT0gV0lMQ19WTU1f
RU5UUllfRlVMTF9SRVRSWSAmJiAhd2wtPmNsb3NlKTsNCj4gKwkJCWlmIChyZXQgIT0gV0lMQ19W
TU1fRU5UUllfRlVMTF9SRVRSWSkNCj4gKwkJCQlicmVhazsNCj4gKwkJCS8qIEJhY2sgb2ZmIFRY
IHRhc2sgZnJvbSBzZW5kaW5nIHBhY2tldHMgZm9yIHNvbWUgdGltZS4NCj4gKwkJCSAqIG1zbGVl
cF9pbnRlcnJ1cHRpYmxlIHdpbGwgYWxsb3cgUlggdGFzayB0byBydW4gYW5kDQo+ICsJCQkgKiBm
cmVlIGJ1ZmZlcnMuIFRYIHRhc2sgd2lsbCBiZSBpbiBUQVNLX0lOVEVSUlVQVElCTEUNCj4gKwkJ
CSAqIHN0YXRlIHdoaWNoIHdpbGwgcHV0IHRoZSB0aHJlYWQgYmFjayB0byBDUFUgcnVubmluZw0K
PiArCQkJICogcXVldWUgd2hlbiBpdCdzIHNpZ25hbGVkIGV2ZW4gaWYgdGhlIHRpbWVvdXQgaXNu
J3QNCj4gKwkJCSAqIGVsYXBzZWQuIFRoaXMgZ2l2ZXMgZmFzdGVyIGNoYW5jZSBmb3IgcmVzZXJ2
ZWQgU0sNCj4gKwkJCSAqIGJ1ZmZlcnMgdG8gYmUgZnJlZS4NCj4gKwkJCSAqLw0KPiArCQkJbXNs
ZWVwX2ludGVycnVwdGlibGUoVFhfQkFDS09GRl9XRUlHSFRfTVMpOw0KPiArCQl9IHdoaWxlICgh
d2wtPmNsb3NlKTsNCj4gIAl9DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmggYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmgNCj4gaW5kZXggYmIxYTMx
NWE3YjdlLi5hYWZlM2RjNDRhYzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuaA0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmgNCj4gQEAgLTI3LDYgKzI3LDggQEANCj4gICNk
ZWZpbmUgVENQX0FDS19GSUxURVJfTElOS19TUEVFRF9USFJFU0gJNTQNCj4gICNkZWZpbmUgREVG
QVVMVF9MSU5LX1NQRUVECQkJNzINCj4gIA0KPiArI2RlZmluZSBUWF9CQUNLT0ZGX1dFSUdIVF9N
UwkJCTENCj4gKw0KPiAgc3RydWN0IHdpbGNfd2ZpX3N0YXRzIHsNCj4gIAl1bnNpZ25lZCBsb25n
IHJ4X3BhY2tldHM7DQo+ICAJdW5zaWduZWQgbG9uZyB0eF9wYWNrZXRzOw0KDQo=
