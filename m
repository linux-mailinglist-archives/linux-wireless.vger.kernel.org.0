Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52987A24A4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjIOR2F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjIOR1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 13:27:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6731FE0
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694798869; x=1726334869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+rQTvo5QKalv8HivWGf67rZ/T+MGTaFnEFWQ9U8NIV8=;
  b=qzzYBpNC3QTg0OVw0kcajUlxTmiu1eR33OwGsz+eEOo2UVY9Qk9YDcoF
   fN//HYPsxnfSKJEPSF1oBQ+/i9UYgZ+gYDLevCs/4UFq/gPDIKogIOAPk
   Gz6zvdrWkR+ayo6Y9rqk9xiEmGOl5I4RUqJG+yItwMgZsU/OMuoJnyHFI
   W5Zgdb4YkAmzEKnJ/oR7WehFVmuHEsy46FsFD/7lKXTQPmkFz0xxv/6Bi
   O8/eMQxmErc2p2qcsDNBFDziuc42YISBZn2bCDzQw+jxmS+g3jm60sUF2
   FFdrWdH65rBY9ZD8uGtYQWZ2X8pMfERj53DitnzKK/sbrRf/FHubn1BXU
   Q==;
X-CSE-ConnectionGUID: 540I9zFYQv6l73T0kEp1Kg==
X-CSE-MsgGUID: 4+OZYfj2QQWqkIDlUrcFqQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="4911299"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 10:27:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 10:27:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 15 Sep 2023 10:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dftPdodMYVkjoZWgidw9Xus/vG2nLTwGUubavOKoEoCuTM669UKvscz8AbboXmf+Ja5rrCJmVw9viAg5qjQbTk0jZ+1THafZNZfPH+wZyGFFxyve3QoDOc+XkOJa1MKhxedEuNH23Fm/HwaDAW4kMV0SFZbuF7QzSIhIrN0MUaWjaDMGEO2G8kg3lwCXphsgr8ZdOZ0F6OojCP8cukvvExrMkCbVvIypyqzkP69DTdeYwCXi+I8OfkitBjcaMyDxkkfup6SGLYFw4DyXzwcWF+LQkeBdq66KlKNr/BUXwYFf8u2Q7MmSx32Qr1Y2TEGv/LPrlxTlmFKI8VOniSAvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rQTvo5QKalv8HivWGf67rZ/T+MGTaFnEFWQ9U8NIV8=;
 b=gFg+f2AO/APFsJm2Sse6JSGZaoD9Jf1i/DPLCPon6GERRh+H4dJjspXOCCh+eBAgH5m8z2/S5Juximy0KcPd+06j22v2emq+HydINUJH3vMwRpcSiODDGOKD/CyS0NhMStQFN0q5m9n4vGECLyjwtVamkQgZWo+llhX9wPKfdfe+zJZbUFIKBNKG7p2RiQvhbwOGjOHyejTyGOk1D3boCfmXQ13rEX1I0hoLpd/oesmMcsSu5xmH6xu7pPIYofHTJy4UVqRozc0ppTBF6gEvZyk+vbVCDA+DdtuMr3pNlaFxUgH1Tb+uw4ca4wNy/lXLtb8OxPsAeSsWwdlBZOqLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rQTvo5QKalv8HivWGf67rZ/T+MGTaFnEFWQ9U8NIV8=;
 b=TzlU1EEhoThVv0tE7+FLekJ+lA9+vHm3qCdhkxjLPvpalCZBG4omiTyv/uCzIJy/JJDN1ieg146HC/WLsCK9F6xoSVCq3UOXNwkFipOTymCXdlTtee10Cc32P0lz9q96yezuAKJMJl/xFnjsyK4PlwcohMMhIcQYp1qwIWPYpJE=
Received: from DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) by
 CO6PR11MB5585.namprd11.prod.outlook.com (2603:10b6:5:356::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 17:27:04 +0000
Received: from DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2]) by DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 17:27:04 +0000
From:   <Prasurjya.Rohansaikia@microchip.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v3] wifi: wilc1000: Added back-off algorithm to balance tx
 queue packets.
Thread-Topic: [PATCH v3] wifi: wilc1000: Added back-off algorithm to balance
 tx queue packets.
Thread-Index: AQHZ4a36H8g8Ibgqk0++EZxK8R8Jf7APpikAgAyJ6AA=
Date:   Fri, 15 Sep 2023 17:27:04 +0000
Message-ID: <07b0078a-5ad4-f09f-b57c-2de90404e774@microchip.com>
References: <20230907170851.178834-1-prasurjya.rohansaikia@microchip.com>
 <fc3eadf9f8f9e88ed2f1632253646ac1245e9c64.camel@sipsolutions.net>
In-Reply-To: <fc3eadf9f8f9e88ed2f1632253646ac1245e9c64.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6336:EE_|CO6PR11MB5585:EE_
x-ms-office365-filtering-correlation-id: 00c67e75-b9c3-4fe1-dbea-08dbb610fac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4rWqsWtB1zU7nkTBx/mMpp4Yq9RRU/R2Hzh19wcNQSXN5dBSlcN/rCShl4SaG+6ItBRphu/tATMVX4iWcedL3WWXtN7cAwbsrnCuyWhhNWG1CNnA2J7vukvOTHJKd+NRDnPxPSQw8ZpefFej2MRas5e+V8X0+2mvbb/T5RcBf9pY3CAw1qlz/Gm2ICKQbPxCV7QyOXEsj1XNHvHZlnNRWsWuRb1Z0rRXC4OyQlo4ffgIAtk4uO3q7MFnQCN9XlDhAHoMRKU7uxdErKWtvhlGsnPAmL/2jUDr71Ajt2ePfSZUBTTe0wpmGQ+7mkC8a46ygXEvgJf1ZH0JVG6RQ7PONqZmUXVUc1bLpaOpS2VVbrNNvlI9kn9LyKRLUzpe99kLr7zZEEN/F1/8J3ybCaejhC+R1tAZO/WeTf94xCLVE47i1Gbejp/kT116URKGIvnF7wp4zY8cf+m2ztvjJPlEfkKDu8k2jRgQfayZg09NAqyCLlEf1sBxmn7incI6TYfvqeZrjn7ic2MyremCdCy1m4tTnItc5GGJH7vC8VjGpd/ynqbS56/nhtZ5QMCKu6ezv7Bu7kQ78e6M5vpNom+wnRiqccoxFICW3O9s97fB9SAwOUzY2I8A5PEpBDpIy4pSrkUfXX0cOTOuBjqmOcgPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6336.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(1800799009)(186009)(451199024)(83380400001)(31686004)(6506007)(6486002)(53546011)(71200400001)(36756003)(86362001)(38100700002)(38070700005)(122000001)(31696002)(2616005)(107886003)(26005)(2906002)(6512007)(966005)(478600001)(4326008)(5660300002)(110136005)(91956017)(8936002)(8676002)(76116006)(41300700001)(66556008)(66476007)(66446008)(54906003)(316002)(64756008)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVNTVUtNYkpGK1Y5ZzJTZmtKeEswbXZYSkUwZ2xSZ0h5UlEySHNFcFgvcWpX?=
 =?utf-8?B?MDQrdDc4TTV1K2hzZFA1SkcwNks0a0ZWWlRGcUZ6c0Zla1dtbVhVVDV1ZDhN?=
 =?utf-8?B?YU1mVE1xQXNTaVhwWExnMkNLTFIwcG41N0hERDVVTmRMdFp0NnlJTzZOTk1G?=
 =?utf-8?B?d0RLVjluSGRtNjJQcVJwQ0pmanBwRWZ0Qys0RVBIOVJ2eEQ4cTkyaDdKVXdP?=
 =?utf-8?B?VUZ2ZFZuVjNSa1lZN3RZRFBuVzNhSlpzTVlrbVBqNUFVMk5veWtjNWxUOU5E?=
 =?utf-8?B?RUxNZGIwanJ4V0NGSDU0dmhzU2FDY09HSWpuY1NPZzM5NDh0dm5rM3FzZXlZ?=
 =?utf-8?B?M2hLbE9RUENPcDViMWdVYnUzK0VvYnU5ek0vbFJmRjZ3dFlaOUZRd25HbHM1?=
 =?utf-8?B?VWcrSGVPT3JUd3c0NVBEaFJwZmVCRWJnQUdmTUdCNk1ucmFrUkJLVFhmdW5T?=
 =?utf-8?B?b2pTUWRNeEdFYy8zeXBYbkkzU04wMHlqY2I5dDJXZ1dLMmhHYXdvT1dMZXNP?=
 =?utf-8?B?UkNPMkpycHdzNWcwZ1dlTGxjcEFoemFydURkQm9PTnE5cVJTRk5XR01uTWJ4?=
 =?utf-8?B?SEsxS1RVdkJtdGFVTm1lWXRwNGJXaEpXcDM5TTlMaHpJTU1ONlYrTmpWVzJH?=
 =?utf-8?B?UEVoNGFzbHBBVDBTMGhaOE9sSmJkd1lramhWbUlsTFBBSEh2eDRuWExtcDVU?=
 =?utf-8?B?aFJFeFlaWXE5aG9OM053NWhzL0VNRkVmSEd5M1crVi9NMCtpZWVGaXZoSHN4?=
 =?utf-8?B?VWNqdzB3b0hIS0h0MEh0dC9WcDFKQWtwWDVkd3dMcnk0LzNnMlJtYVZaa2h6?=
 =?utf-8?B?UGhFSWxlQkNoVlV1V2FER1ZybE8xR1J0cUZvRUJqZzB5UnFGdnMvVlE0eVI5?=
 =?utf-8?B?M0ZKTkhnVGN4ZlpZSy9vMzVscmFacVQxSzNsYjNyVHdMbEZ1TTBBaHk0V2ZN?=
 =?utf-8?B?bUtzUVBseFlPVzViSldtZlUwMW05Um5LTU0wRUF4OTNHQkpIb3RBczlaVEx5?=
 =?utf-8?B?ekEzTW5Jd1Uxa2VhdytQMXRla3FId3drNVQwUXJlVGVQeU9RNEYwTVRSeHhT?=
 =?utf-8?B?STJINmRtRncwdlBRSWR5R29VTzlINXJod3Q4WEpDbWcvK1B3V3NnTE9HVWQr?=
 =?utf-8?B?dlNDN3dOMFQ5dU8rQ3JIMlFYQUZ1c0liNXdtQTkrdzFOYVlCd25jT29nZy9X?=
 =?utf-8?B?Ny9HZFMxQkVKQ0NZTWV0c0VwRnd4SHFTNEpEZGVPcFg0dTJ2aXoycUZRd1FB?=
 =?utf-8?B?Unl6RXFYUU9ZdmxOUENra0JNK1lkSkt1dkJQbGovQ3pDbG1rNjdlaHYzMHc0?=
 =?utf-8?B?djU0RlRCQlhQdWx1emdWUUdWOXpRSUFKbzFMWEFzc1hURnVlVmxRVTIwSEJK?=
 =?utf-8?B?YWhreXErVTNDU01YM2RqOEZDR0x0OTBRM0prZXNIMFA5aW5tQWJBcW53eUhG?=
 =?utf-8?B?c3UwK3R2Rnd0bmtkc2JNVXZEN1FYOHloeVVFYkNrM3YxRmNvYmZNSVlTb1FC?=
 =?utf-8?B?QmpDVk5xK1ZZSjlNbDFWWXc5dU93T3RGZzVyUFhXYkFaSjdUWGE5UlhkTjhm?=
 =?utf-8?B?TTE0b3pXTm9YbGZEQ1hsejhUU0VBeGtJVnRKdjFwbmQxdHBrbEhjR2NyQlFQ?=
 =?utf-8?B?T0tZU2RKTzFiZUxON3ppUkFVeUZISDl1ZS9ML0VHM3NqUEJCT2hnUGtlTmxz?=
 =?utf-8?B?ZnhMajlWbWdGTHRWTkRORzhTaXd4TVd5R3prRFJraHdabmJxcjcwMDc1enQ3?=
 =?utf-8?B?TWtQWVliMEFMZU1TaWk2cHl4UXlXRURqYVdMUzFNbktybjdwQ1d0cDhHaCtx?=
 =?utf-8?B?L2JOWEtyMThtRGxyUDdzK1NpMzRwZmxqSmxRQ2N1NzVlamliS0NpZnJlSk96?=
 =?utf-8?B?S0FWUEhPdDdPdnRsK3ZoakhHNE1kM1lqMVpWVUdTcVdxZlJJMjM1R1pLTkV2?=
 =?utf-8?B?bTQvamVrMWVkN3k3WHRWWVpPMm5DYVNvTGZvdTRkQVFZQXlsa1AwN1A2RHVQ?=
 =?utf-8?B?SnJqZ0l4enF2WWRXbTVIbXJLUkFVdnhVd05WR2Nld29xQ2FLV2kzNHB5VE1U?=
 =?utf-8?B?aGNLQUw3ZzQ4SC91eVVkS1BTZ3hvYWoyWEI4dEtUZkNsejBVbnU5a0M3aTI4?=
 =?utf-8?B?TDB3UHMzWm8wRHpGby9SWFRqUk53UTUzaGNVVXdkcDBIdVQzS2VINlJ5ajBW?=
 =?utf-8?Q?pQ9ogRWCQX+Ift5Ed6kXJFA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A25B40B2686BD42844CB658D6ACCA21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c67e75-b9c3-4fe1-dbea-08dbb610fac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 17:27:04.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6o57A+7ta08CbZwnwBdd+3Sc4CGR0fIH1tuzSDwwJQWHJkj7SeZj8kmNGaKoWb3SDZTm7QLN6RGBjzKWHtoq1ppasv7pc3YUEkFpvR9DY0o7C2neMzuoEKL171GTRxod
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDkvNy8yMyAyMzoyNywgSm9oYW5uZXMgQmVyZyB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDIwMjMtMDktMDcgYXQgMTc6MDgg
KzAwMDAsIFByYXN1cmp5YS5Sb2hhbnNhaWtpYUBtaWNyb2NoaXAuY29tDQo+IHdyb3RlOg0KPj4g
RnJvbTogUHJhc3VyanlhIFJvaGFuIFNhaWtpYSA8cHJhc3VyanlhLnJvaGFuc2Fpa2lhQG1pY3Jv
Y2hpcC5jb20+DQo+Pg0KPj4gQWRkZWQgYW4gYWxnb3JpdGhtIHRvIGJhY2tvZmYgdGhlIFR4IFRh
c2sgd2hlbiBsb3cgbWVtb3J5IHNjZW5hcmlvIGlzDQo+PiB0cmlnZ2VyZWQgYXQgZmlybXdhcmUu
IER1cmluZyBoaWdoIGRhdGEgdHJhbnNmZXIgZnJvbSBob3N0LCB0aGUgZmlybXdhcmUNCj4+IHJ1
bnMgb3V0IG9mIFZNTSBtZW1vcnksIHdoaWNoIGlzIHVzZWQgdG8gaG9sZCB0aGUgZnJhbWVzIGZy
b20gdGhlIGhvc3QuDQo+PiBTbyBhZGRlZCBmbG93IGNvbnRyb2wgdG8gZGVsYXkgdGhlIHRyYW5z
bWl0IGZyb20gaG9zdCBzaWRlIHdoZW4gdGhlcmUgaXMNCj4+IG5vdCBlbm91Z2ggc3BhY2UgdG8g
YWNjb21vZGF0ZSBmcmFtZXMgaW4gZmlybXdhcmUgc2lkZS4NCj4+DQo+IA0KPiBodHRwczovL3dp
cmVsZXNzLndpa2kua2VybmVsLm9yZy9lbi9kZXZlbG9wZXJzL2RvY3VtZW50YXRpb24vc3VibWl0
dGluZ3BhdGNoZXMjY29tbWl0X21lc3NhZ2VzDQo+IA0KPiAgICBQbGVhc2Ugd3JpdGUgY29tbWl0
IG1lc3NhZ2VzLCBsaWtlIG1lbnRpb25lZCBmb3IgdGhlIHN1YmplY3QgYWJvdmUsDQo+ICAgIGlu
IGltcGVyYXRpdmUgdm9pY2UuDQo+IA0KPiBhbmQgdGhhdCBzYXlzOg0KPiANCj4gICAgU3ViamVj
dCBsaW5lcywgbGlrZSBjb21taXQgbWVzc2FnZXMgKHNlZSBiZWxvdykgc2hvdWxkIGJlIHdyaXR0
ZW4gaW4NCj4gICAgaW1wZXJhdGl2ZSB2b2ljZSAo4oCcZml4IGZvbyBhbmQgb3B0aW1pemUgYmFy
4oCdKSwgbm90IGluIGFueSBvdGhlciB3YXkgc3VjaA0KPiAgICBhcyBwYXN0IHRlbnNlICjigJxm
aXhlZCBmb28gYW5kIG9wdGltaXplZCBiYXLigJ0pLg0KPiANCj4gam9oYW5uZXMNCg0KVGhhbmtz
IHlvdSBmb3IgcG9pbnRpbmcgaXQgb3V0LiBJJ3ZlIGFjY29yZGluZ2x5IHVwZGF0ZWQgbXkgY3Vy
cmVudA0Kb3V0Z29pbmcgcGF0Y2ggJiBJJ2xsIGRlZmluaXRlbHkga2VlcCBpdCBpbiBtaW5kIGZy
b20gdGhlIG5leHQgdGltZSBJDQpjcmVhdGUgYSBjb21taXQu
