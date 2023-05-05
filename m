Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10396F8A6D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 22:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjEEUxU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 16:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjEEUxT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 16:53:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACFA1984
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683319997; x=1714855997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2GOiWxlqOdpNmEeQNgwYubMTCR77OHdyo/2ZEhiWIHk=;
  b=jwqeGGqaTZ/0+gKh7azZGg7qxrJO3tvRxRRL7ja6xcG46Fuq4/X7U8Ak
   J0Y2QdLYEA7//42MVsq9lBLxyhuMtqsm3cK/u6mSjxqT49JX603NBPjHH
   oxbqYMJDtfSQ0rlhpdAqsC4hI+RnXYQUyaAdCnmwhjd/SCYyS2AQ6PO9E
   Hbl0Y2E2iynLM/fCweQoOg0QN2rfHmiNQ8QZPbKUEdyp6Qc62eXnYqJli
   kjlVE4g8xh5K8MV1utrZHWXkKna9OquCJzJncdaW5Tq70ewawmbFmxDQ/
   xZpCBHy6H6+DdXnnmhODzXPAEdlS7Q4aoHb9GIwXu1CEe49tsStfM80KO
   g==;
X-IronPort-AV: E=Sophos;i="5.99,253,1677567600"; 
   d="scan'208";a="212653381"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 13:53:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 13:53:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 5 May 2023 13:53:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSr8UcyeHKVep+esA+jjuO1ZDKpmFJG/V4cg1GEl2Xa2SL4UbWId8Avm0Nl/fZCzeM7+UuipXZL8eftyO3bPo6sK6cjHANW0350phEVTbNr0Cfj/Xcyaqcw7pJnW6EnT90/DYRZ3gLUYxYN+nYGVUK5SeNYW5s9YJkAjzO95nWguYWg2IQjEWwhvbocfvfiE0TseRdk1nRM+r1ip4Ot4YIRZfh3Fz6O7uk0tGa6MpIlNzlUjGEf4Y7sN9bec6/yoF7J8ISEwYYb8C7E2r4uSo0RDyplPfD3aPxuSCbJZJCEfzw/RwaOg/ujgees8/IldoWo/KBiVndLtIf/841rkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GOiWxlqOdpNmEeQNgwYubMTCR77OHdyo/2ZEhiWIHk=;
 b=BiQDMfDNBwFH6jf0ddh+Cl7bPJukfCDF1zoFONCV7WcCAPpCyUhjtGLiFNjR5VR9hsxb2wqOL+d5a+EJ095fXqZ5eDtNM5wK7WSBjJgS3Uizgbhkqmc4yx0CkCA0LdgAlup2uskO4c8hQDxLd+dL0aUQlsFgn8r2HmL6et0uQInk44Xm6L36RMPKIlpEBp17S/4xldvGjcdklOD0AjTrURlBaAPl6oZgJpeqOJE9ptPMeHjWsCYPeIozeT0EIU48Qaxyeql9Cfn7VeE0XiaXmp23H6AouKa+c2zVHfmMJN/NBcxX9cVRINAh4EPG+ojBBqPHEOEMHZLIvUCj+yznHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GOiWxlqOdpNmEeQNgwYubMTCR77OHdyo/2ZEhiWIHk=;
 b=bnLd/g7muQPD1Xp5U1/P9HCR0zP9d98Lqd/Em7Vd+JvhMMfTuW7zR/afAHKiuFN0rgRPTNAswaHXnjLCoMvpOnjbwFFYPcQTW8ML3QL2C9IKAZjiKXeHsWLSoMakTh6EyEcH03r7KrQYU0lFuVCqhUIEtixDdg+mi5nap88KvSg=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by PH7PR11MB8569.namprd11.prod.outlook.com (2603:10b6:510:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 20:53:13 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::30d9:173b:e580:28c6]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::30d9:173b:e580:28c6%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 20:53:12 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <mwalle@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Thread-Topic: [PATCH] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Thread-Index: AQHZZpOxdxNIPScHF0Gh2r71RWeobK9MBL6BgABRhgA=
Date:   Fri, 5 May 2023 20:53:12 +0000
Message-ID: <cffca4d1-5ab5-0633-7bab-00d65526bfa7@microchip.com>
References: <20230404012010.15261-1-ajay.kathat@microchip.com>
 <87wn1mok5g.fsf@kernel.org>
In-Reply-To: <87wn1mok5g.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|PH7PR11MB8569:EE_
x-ms-office365-filtering-correlation-id: 126135e2-82f9-4c55-4eba-08db4daabddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNRAuBH1KsSAH8RI2iYpegA6gFrsYJS5snCOOcC/XQhtrMJFsAFLxpXPaXN1jdMjbcBk8ZzMO9w02psqRlVzBz51L5UQzNw7kdvczNIfk5VWbWiZeEQx4g5T6HJd7g5h9CX3O6yWcF9297XfhP+pU3tocWHww/KvhvA21eF1xKdtMv8O4z8KgzUCCgjoB12+u1QeRWE+GvkssGx4XVpIOA+bbHaelF1QB4AzfWkaZx9KtnWRAzbPjbANbLzgdPhbpHUxyWbPvRydpMGyn/FbhVdUAX6/1IpLIRKip4zePrn4CVpTqhWOPMbKWRtGVPOj+gj4HHGCVcebPyCRMOj7n8XMH+rr+dSXeNqJ8d3V1bBfSX1+y9RdZ9eAUuiQ0dyBoHjskP01eyzmyLoGfeHOS3bCiIqUyzvPX437lGBldujwckmi8IcVvODwMJWhDHJfj8WJSbUfc2Ke7j+KHO90CXsBxi7/dy7C8ZFdKgWkiIwWX7Ci2q+OgvXJR0qf1dxxsoODJojYfy8kaEnytQ8mH4NyK3LykNE/X+5YhquTLw4gq/5zxunNxKZNYxwjji/gEelAoxYCVY6OH5tZGLuZBDc4Zg0WWeN6T/KFhVSWXvpPiJZepJ+go7rnGZUQpVFqubGvvCjKbCSUII6zwD4q9lA7b+YvOO2gUfVj5P/HHSY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(36756003)(478600001)(71200400001)(31696002)(86362001)(6486002)(54906003)(316002)(66556008)(66446008)(64756008)(6916009)(66946007)(66476007)(76116006)(4326008)(966005)(41300700001)(8676002)(8936002)(5660300002)(38070700005)(186003)(2906002)(38100700002)(122000001)(2616005)(6506007)(26005)(6512007)(53546011)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGYxU1FxbTlKYSsrNUovMERCMXdMajVCWk5ScGxnNjBmVnFISWdiMitpaDJa?=
 =?utf-8?B?a2NLRUwwVVZjdzVDVlFWNllEQkFMOEJFcEZpTEdkTndLWFFIRlE2NU0rVzdY?=
 =?utf-8?B?QXJ5bE45TzVsVzVRNlFHSHZZd1h1U0w4MGpxNTJ3VFNqWWxWOWhmL2ZodXgw?=
 =?utf-8?B?RW5OVnE4dWhPL2hYWXIyU3JBOFEzRVg5cDlLbjBGYUt4ZVo3aGg2QWZac0F5?=
 =?utf-8?B?NXg3L2lGZTk3ZUhkMk82K2FzZ3kreGNRbUl6SjR2N0svV2Y1NGhqd2ZGY3BM?=
 =?utf-8?B?RWQ5enJSTFlCc1Z6UWJRU3MxanB4dnMwRmUrQ1lId01IUzlMMlJnVGh5NFRu?=
 =?utf-8?B?NFBSZDdERktBWjFaUHZRUUZvN0pmTHRieGxNSGZONUQ0eXhueU12anNodDFl?=
 =?utf-8?B?eHd2YXpQZWdmTExPanF0ZGhPeXBaQVZ5SEd4eUJ2MTQwTDByczBvSWloTDh6?=
 =?utf-8?B?U3poSW4rVHlrVzIzY0t6TDdlVzZnOVlyOUh4Q3BTRUlLV1RSRWk3MHhSNC9L?=
 =?utf-8?B?SC9oMStRang2TlFOcTVtWnMvTC9mL2luM2NGTlNmRmtSR0hod3E2RlV5MFNu?=
 =?utf-8?B?REZMSnE2VjJZMGRSRkVqakVoSmtnYXFTazVna2doYk8yRWIxNms2L3NvdGZK?=
 =?utf-8?B?YmJ2cEIxcCtWNHYyZnBJdDZqVnRSbCswazZ2OFRIdllPT2pWcml5M2RFNFVR?=
 =?utf-8?B?VFBubjBKdlhQTzFHSndiS1k5Sm9ucGRqWXhXLzdUUllkMHFVWFFad3FhNmhB?=
 =?utf-8?B?NnM4UFRicmNEK1g2ZmFiY3JQZ1pVRktiYzZETE9hOWhWSXVYK20xYkk1ZDlv?=
 =?utf-8?B?V25SQSt3N1ErYTlYcUVTMnJoL0NyU1lNUEFEdEtOdDNDaGVDK2Y4UzJSRkx5?=
 =?utf-8?B?L1FMNjVnOE1EMjFJaEc2SmFzV2Z2blJ2b0QwQWRnbXYveUJRaVM0NG9QVUJ6?=
 =?utf-8?B?Rlh5RzJhaHZ1UlAxWG8xdzhsQjhsa0YzOFhGRjNwZmZXM1Q0QXFFZFdWZ1NI?=
 =?utf-8?B?d3plelJLY3NsL0dLYm1tUnF5Z2ZQRXJDYU1BL3o0NmZLU2hVTm0yYXZyNTJn?=
 =?utf-8?B?ZFFvWlQ0NDV3K0ZOODdCWjhkTzdKa3orT2t3SUcxQkVzMi82TDlvVldhRGt1?=
 =?utf-8?B?SUNMWGZET1M3dzN1VytWTHZ6RmlseTdtcDQzLzZ0MjlzcDNHK2l3eDNReXBz?=
 =?utf-8?B?SzBjOHFRdGFuZWlwK0tpaGxjR280R3F4U0ludUNnMXVKMUhMbXRRME5jWldj?=
 =?utf-8?B?Y3ZNR3h3N1A1Uzk1cGNpOEhiWi82R1BaRWxmQWRwZWlOV0RwMkkxYVRNWHUw?=
 =?utf-8?B?bFFxVHNyTGpvdlAyTWs1QVhnR3ErY2UvTlJRUXN2c0FpSUIvTVlNRjdxYXg3?=
 =?utf-8?B?eWgvOTJBNndrcU90enJVK0tya3VjVE9laWl6WWNzZzRtclV2aGszWk9oVlBX?=
 =?utf-8?B?TlZnZVdkWkJRRU1nUVV3YkpJWk0vQjltY3dLN1AvaUFQdEczNFk0bW5EZGNn?=
 =?utf-8?B?Wm1Cd2VaVXpsSlFOU1RCQ0NXalkvVDFwdHhXczlVbHBTd25UY2dVaE03Y29m?=
 =?utf-8?B?K2F3L1YxU2lFUzJsMXo3OTZadGNzZTk5anRGaFVzRXl6Ykt0d011VlJMRVFZ?=
 =?utf-8?B?UG0wMEh5ZnorQWo5TlFRbXkwQStUV2YrN2V5Mi9pTmJvZENNOU00QTl0NGkz?=
 =?utf-8?B?N3Ixeno1dVVHbmxJOHcwaWdnZnFaU0xyejJ2aEk2NTQrOVNWYjZBVUYzdWZU?=
 =?utf-8?B?VVZWakVpcTNJY0FhUnpNRVlMTTJDWWg0S0tWMkd1NzJ0d2lZcElDWlZFNkN6?=
 =?utf-8?B?Ly92dCtHdGM2SUMxa3ZoOHRuaFRpSDVlWVN6MmNLN2FEZEhKSHNhemN6WW9m?=
 =?utf-8?B?eDI4UlB1eVFWUm90WldIYUpBQkZMUzhoT1YvWjBPZzAza0ppY3YyWmZOemNk?=
 =?utf-8?B?RitzVkwvUlJTUXhOQ2drTHBDMFQ4VmpkVkVGdjNPYnBEY3FhcWRQclVZYllG?=
 =?utf-8?B?UGI5Z1BkVlFMRzF3aFNWeVg3WkRZYXc2bElHWFdiRm4yNmZNMnFHc2xudnhE?=
 =?utf-8?B?SUdQQ2FIUVo3S0FvOHpEK2pjVmRLbTlwTzEwVERaYUVMMFZhWnRURzVuVjE4?=
 =?utf-8?Q?81uIfAwGAtVjcq3LgNEC2Pf1B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8FCB3FD47BF714CB582DC94750E1778@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126135e2-82f9-4c55-4eba-08db4daabddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 20:53:12.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5D06iRWd4CvbpAYliESvrPZ/yt1bGvq5JLrEZfpGBqbBDsroMXF2qRG3/+ssOJhhQT1ldL4Z3rXojasIdiN9eI7gi/bP0QcS4+v4kk5on2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8569
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDUvNS8yMyAwODo0NywgS2FsbGUgVmFsbyB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiA8QWpheS5LYXRoYXRAbWljcm9jaGlw
LmNvbT4gd3JpdGVzOg0KPiANCj4+IEZpeCBmb3Iga2VybmVsIGNyYXNoIG9ic2VydmVkIHdpdGgg
Zm9sbG93aW5nIHRlc3QgcHJvY2VkdXJlIFsxXToNCj4+ICAgd2hpbGUgdHJ1ZTsNCj4+ICAgICBk
byBpZmNvbmZpZyB3bGFuMCB1cDsNCj4+ICAgICBpdyBkZXYgd2xhbjAgc2NhbiAmDQo+PiAgICAg
aWZjb25maWcgd2xhbjAgZG93bjsNCj4+ICAgZG9uZQ0KPj4NCj4+IER1cmluZyB0aGUgYWJvdmUg
dGVzdCBwcm9jZWR1cmUsIHRoZSBzY2FuIHJlc3VsdHMgYXJlIHJlY2VpdmVkIGZyb20gZmlybXdh
cmUNCj4+IGZvciAnaXcgc2NhbicgY29tbWFuZCBnZXRzIHF1ZXVlZCBldmVuIHdoZW4gdGhlIGlu
dGVyZmFjZSBpcyBnb2luZyBkb3duLiBJdA0KPj4gd2FzIGNhdXNpbmcgdGhlIGtlcm5lbCBvb3Bz
IHdoZW4gZGVyZWZlcmVuY2luZyB0aGUgZnJlZWQgcG9pbnRlcnMuDQo+Pg0KPj4gRm9yIHN5bmNo
cm9uaXphdGlvbiwgJ21hY19jbG9zZSgpJyBjYWxscyBmbHVzaF93b3JrcXVldWUoKSB0byBibG9j
ayBpdHMNCj4+IGV4ZWN1dGlvbiB0aWxsIGFsbCBwZW5kaW5nIHdvcmsgaXMgY29tcGxldGVkLiBB
ZnRlcndhcmRzICd3aWxjLT5jbG9zZScgZmxhZw0KPj4gd2hpY2ggaXMgc2V0IGJlZm9yZSB0aGUg
Zmx1c2hfd29ya3F1ZXVlKCkgc2hvdWxkIGF2b2lkIGFkZGluZyBuZXcgd29yay4NCj4+IEFkZGVk
ICd3aWxjLT5jbG9zZScgY2hlY2sgaW4gd2lsY19oYW5kbGVfaXNyKCkgd2hpY2ggaXMgY29tbW9u
IGZvcg0KPj4gU1BJL1NESU8gYnVzIHRvIGlnbm9yZSB0aGUgaW50ZXJydXB0cyBmcm9tIGZpcm13
YXJlIHRoYXQgaW50dXJucyBhZGRzIHRoZQ0KPj4gd29yayBzaW5jZSB0aGUgaW50ZXJmYWNlIGlz
IGdldHRpbmcgY2xvc2VkLg0KPj4NCj4+IDEuIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXdpcmVsZXNzLzIwMjIxMDI0MTM1NDA3Ljd1ZG8zZHdsM21xeXYyeWpAMDAwMi4zZmZlLmRlLw0K
Pj4NCj4+IFJlcG9ydGVkLWJ5OiBNaWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9yZz4NCj4+
IFNpZ25lZC1vZmYtYnk6IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+
IA0KPiBbLi4uXQ0KPiANCj4+IEBAIC03ODEsMTMgKzc3NiwxNSBAQCBzdGF0aWMgaW50IHdpbGNf
bWFjX2Nsb3NlKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2KQ0KPj4gICAgICAgaWYgKHZpZi0+bmRl
dikgew0KPj4gICAgICAgICAgICAgICBuZXRpZl9zdG9wX3F1ZXVlKHZpZi0+bmRldik7DQo+Pg0K
Pj4gKyAgICAgICAgICAgICBpZiAod2wtPm9wZW5faWZjcyA9PSAwKQ0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgIHdsLT5jbG9zZSA9IDE7DQo+PiArDQo+IA0KPiB3bC1jbG9zZSBpcyBhbiBpbnQs
IEkgd29uZGVyIGlmIGl0J3MgcmFjeSB0byBpbnQgYXMgYSBmbGFnIGxpa2UgdGhpcz8gSW4NCj4g
Y2FzZXMgbGlrZSB0aGlzIEkgdXN1YWxseSB1c2Ugc2V0X2JpdCgpICYgY28gYmVjYXVzZSB0aG9z
ZSBndWFyYW50ZWUNCj4gYXRvbWljaXR5LCB0aG91Z2ggZG9uJ3Qga25vdyBpZiB0aGF0J3Mgb3Zl
cmtpbGwuDQo+IA0KDQpJIHRoaW5rIGl0J3MgYSBnb29kIGlkZWEgdG8gdXNlIGFuIGF0b21pYyBv
cGVyYXRpb24gYnV0IEkgYW0gbm90IHN1cmUgaWYNCnVzaW5nIGF0b21pYyBmb3IgJ3dsLT5jbG9z
ZScgd2lsbCBoYXZlIG11Y2ggaW1wYWN0LiBGb3IgaW5zdGFuY2UsIGlmIGFueQ0KbmV3IHdvcmsg
Z2V0cyBhZGRlZCB0byB0aGUgd29ya3F1ZXVlIGJlZm9yZSB0aGUgJ3dsLT5jbG9zZT0xJyBpcyBm
dWxseQ0KY29tcGxldGVkLCB0aGVuIHRoYXQgd29yayB3b3VsZCBnZXQgZXhlY3V0ZWQgYXMgbm9y
bWFsLg0KSG93ZXZlciwgSSBmZWVsIGl0J3Mgc2FmZSB0byBkZWZpbmUgJ3dsLT5jbG9zZScgYXMg
YXRvbWljX3QgdHlwZS4gSSB3aWxsDQpwcmVwYXJlIHRoZSBjb252ZXJzaW9uIHBhdGNoIGFuZCB3
aWxsIHRyeSB0byBpbmNsdWRlIGl0IGFsb25nIHdpdGggdGhlDQp1cGRhdGVkIHZlcnNpb24gb2Yg
dGhpcyBwYXRjaC4NCg0KUmVnYXJkcywNCkFqYXkNCg0K
