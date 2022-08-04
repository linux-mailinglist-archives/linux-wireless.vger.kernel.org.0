Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE758A045
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 20:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiHDSJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiHDSJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 14:09:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCCD6BD7A
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659636545; x=1691172545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BPLKIjk9Xz5ipuZH8emEinB08gm9Lq6XH9SLM+7oV8E=;
  b=Zfeb6+AOn5yFA8h65NYQ9LV/erQhWiJ/U7MuLHjuA4nOU13fJrON1T3/
   2NdaPlyVW3uIrgj3JgWLVGMmB7u3wBpmioNHylYHOxXYaLu6tflXsxmbU
   9eA5FG4d5ddxiAcRAyaYiBUo+mHMDBlViO2bXR/6rV54k+EZzBUbhl0ZK
   tLg64ZMNpCLbYnPeJsqyh78QayOwVfR7/vB/38pN8YsdeD0PPGDjfbOi+
   ItCmGtH31NXJnjAAaFjRWWam6wEct/cbM1QAe5S0GPglyS7bpfpN4ZGwB
   fdsmBRwAySSmop7/WeVHtYA4I7o8ohVyhy1NJiKpqx/v0l59533lR1MnV
   w==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="175124089"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2022 11:09:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 11:09:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 4 Aug 2022 11:09:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yej9EeO0vSZOd9g+iVaFBsugr2Bs+IPoyIGpx9bn7CEbTURBGAX6U49778h4NUr8yiNg67RGIO7sU4vM32AqwfsoNVsbXFPYKZM4DikhR/Hl6/34v2Gk6fvtpR8JroOXuxZ9KK6KS+4yuFU+va8KE8yid6wBX+Ll88oU+SaF2zC6mpew0mR81m2ccrPvDKLbA9cycrA7IwEyGicKEYKASM2mQVTaqQCKO+KrifR32WK2F/+TNQ/xZOmX/uAcEuNF5lycdLt3vEd4YuPqyjQaJUF8gSOhUJfLEXaoRG3lLUZF6EyBOKI11me4LDVvt7sEV1YMdCEHgiOJ3myTqrFgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPLKIjk9Xz5ipuZH8emEinB08gm9Lq6XH9SLM+7oV8E=;
 b=kK9hTOvLXpTJsCDFb4NZ1bAeOuSsnfmrYGjs6ZnegV3bCVBu8iYHCZfhGLZ1434bH0pxE4syxhQIkQKXV2PcIOtwFD6+Bov/6g3cs2o5L/RsV4i5P01dcOJNYu7KXyd+V0VSQVwDsmplHDZqTSAnJcP72KwBVq5IHdpi6MP3goMg98E6fNt0u7rX3QMRJn33Y3x9KfLYTpsUEjyhIwb38t+Vu4L4lBFebzUKznn1KW4WzwXgCEXgpwQjelmkn3v7+JNPiy5kjpRxGJU0jn0rDdRLWDNal1Wr2iWTygSd1wlL3J0MI+Khv57rRoQcv7geIDQfbG2GjgiJDNyl7f8bLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPLKIjk9Xz5ipuZH8emEinB08gm9Lq6XH9SLM+7oV8E=;
 b=fFiqK2Pegvm5yTQdB+Wb5wCpWaA9kRGYg+lIs0f9EMcAnLq8gkoVckyzITkhArNrk3Jc6+9gdcup2X1Ho6hyoXNec1HKwz7f3PUq5SugFXel6j3z3cRQbD7kfGJjLJYs2xSAD6gvWs9cp7GVdCPKhBkQ25SFkq6PNoBy9lkvwJM=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by CY4PR11MB1767.namprd11.prod.outlook.com (2603:10b6:903:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 18:09:00 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e%9]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 18:08:59 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <mwalle@kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: fix DMA on stack objects
Thread-Topic: [PATCH] wifi: wilc1000: fix DMA on stack objects
Thread-Index: AQHYqAS2buySm8vdCEW3DEuKM8hVrq2ey/cAgAA+iYA=
Date:   Thu, 4 Aug 2022 18:08:59 +0000
Message-ID: <f1a81362-78a6-f4b9-e728-835755262077@microchip.com>
References: <20220804131837.336769-1-ajay.kathat@microchip.com>
 <f25d53c4fe90b2ef153a721bd225f8db@walle.cc>
In-Reply-To: <f25d53c4fe90b2ef153a721bd225f8db@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6372289a-87f0-4c89-103a-08da764467de
x-ms-traffictypediagnostic: CY4PR11MB1767:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvF0CnxA9r4+Obiboi+XYif4fwYkIKEL7dcOB9vXNK1DeTMi1yyvKeZSEfPJCmT9r9Ehz6zh7kb0AQ205CPdJZ0qDCDR+hW3xUOH7INfRX4e/xD7GKJSfUlKG8DmFZ6RetUEvoeu2ZJGEPJxpKZQh2vCF3a0SGRsUVKjo012+xsMNkbrxvgiwDK7VhBNqL54zICZ3Qm2IXcbEQXUqwM80gBDMCoj4NAeUNCMwmTcTQ3V940hj2IaifXTG2xOZn2amBJpMPaiOvQcsjznXMKaVp/hoFEr9Wj4tVNrhZZ3sp5BPDqFo8NP0+6fv/x+4ncmSzrbagPDDN8hrUNAQJGirKLnr420Di9jMheuDO5Houfhb2DbMpFnaRko5HZk5ai10hB0xxb793Xeo26YKd8om5WKrdXk6zMijSCN/01gd6Yvos1M7XMoGL09aRYV5Vbf9dgezAy/WdZ/797tKRDYhhXVwxMs7yy7e4VxtQ02TOwCHeZrBGFfhvj57xIbKUPaNvebn/+bpO11LxGkiMoZtK/qMTLld8bYP9e8nNUoYH0FdpB7s+uoskAr4K7o/pLNvpmY8Y/iMWYonv5/6zGRpFQrrHPAzZ5Ho1zEjLk1g0nFbiWE+NPKhY9AZASFIuURkB2Le44BFz15qod2Ia5UEo/iXzynhJ02rC0jhEPVzg3rXLEl2T/g5xTtomrjd1OrL4ocZzw8oPtkzLNYlft9mC9FKviyZqPjTu6lWYx0iYcSgieML1RR8qkZrXjQpbakRehwIufpDdeywwDs82GDQLv/UfabkwHF70ZOflSFdjqaktBgm5k0XdhQYG4jyIVQl6Cl9p5hBdAUB+81WzlzjFrEpmdGgMw7fkPx6CNrT5lY9RywVrNzYT7VtPW8DX2j2OmLK8Duem5VD+gZ4zZcLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(376002)(396003)(346002)(122000001)(186003)(38100700002)(2616005)(6506007)(26005)(36756003)(31686004)(6512007)(41300700001)(55236004)(53546011)(38070700005)(2906002)(83380400001)(6916009)(54906003)(4326008)(66476007)(8936002)(66556008)(966005)(316002)(71200400001)(8676002)(76116006)(86362001)(6486002)(31696002)(66946007)(5660300002)(478600001)(66446008)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0RsTmR1UnVFZ21mUzFlZitXNmJXY3A3SHJvQzhBajR1V3B6UCtUc2dHa0Ja?=
 =?utf-8?B?THUvUWNyZElGMUV2bXFoQjNNellNNy9nWDZtM0xla3ZpRWh0c0hSSXhacXYz?=
 =?utf-8?B?alNyaDdSU0g2M1FBMzlqYUlHaDh0VFRmNC9NdDd4WThPZUo5N1NjNEJkTjVr?=
 =?utf-8?B?THNRUS9pektFTzAxTTViQmtCWXBkSUw2elcwWDlCak5mTHAva3djSW92V3lZ?=
 =?utf-8?B?aHJpcW9TWmUvM3BMZUdsMUdKMkkrTkQ1eUJoRHNVdzhkQ0dEMjZxSThPYWx5?=
 =?utf-8?B?OXp2OExxbXd0VzFvS2VmUUJIL096MnpjNlFBVUNrSmJmSDJYK3pSSVo1ZDRN?=
 =?utf-8?B?WUlpV2ZzelVwNWFydmJrTExkMldGVVBMM3c5eVlCcHBPR0poS0NOS1ZUREpu?=
 =?utf-8?B?TWloYmpwMDUzY2FabEhZS3cvMlQ3MXErYk1MVis4Z2JkWXlHeEN5KzJvVFFI?=
 =?utf-8?B?NW43RmJJK2dWMHBkNTJYWjEzMHpYdmVuellHWlVpMFVmQVJTU0hKVTVuRGtH?=
 =?utf-8?B?aEsrTERiYnhvdGRqZTV3Z284a2dJRG9PZXBieUVCeXhRMzY4cVYxTkU1R2Vu?=
 =?utf-8?B?QmpWMUdLK1lidVI3UGZBemxMMjlyQkNvUkRWNnhKUVErckxtL1NtbkRYWnZB?=
 =?utf-8?B?cHBoekdRR2kweWlwZHB4clVrRFF6Qms2OGVZVXoybk1DdzBKSHh2LzRITlVB?=
 =?utf-8?B?c0U0Kzc5VmQvT2RoTVd2NFpDSFBZdUxteU1tUUJEbDM2YnZUM0xtckc2dXox?=
 =?utf-8?B?UVJITjF5K1ExTXovcnVtUG41b0hFOVBIVGlhOVN6a0YxeWVjSGh2RzZGaklD?=
 =?utf-8?B?cnhJYnVORHVDOE5EdHNkc2lVRDhZRnlDZStYbTJFeUw3M1lwUG9yaGRJQ3M3?=
 =?utf-8?B?U1BROUNXbC9xekNtQWVkOG40RlV4Wjk5Wnhmby9UV0lMbHJoVm9aUDFnank4?=
 =?utf-8?B?YTEyeVcyc2RONWZIeVFONC9BZ1N3akVMa2M1TEYyUjhnekhpSFFJUlZNV1Vr?=
 =?utf-8?B?d1RhY25ub3FzWmFiMUNUTHVhbHltRFZVZFB4QnRGRkc1Sjl2YWQ4U2xUVFhE?=
 =?utf-8?B?UkozSFBueTYxSDE4Z1p5SFFZUU5ZbmVidGljbmF6RHZjMTBuMHJIQ3N3MjRy?=
 =?utf-8?B?K0wzZEFiYStsU2lHNzlxQk9EcmhYZldaeWZnckV5M2t6QjRkcDUwZGJHOHBp?=
 =?utf-8?B?Ly9ZZTdZRnczQU9DTHdLVyt4TVZNN3I3eEZnTnY4emIvVjk2SnRBRy9XNU1i?=
 =?utf-8?B?SnhjOUFGUDFaazNaQU1OT0dERFNuRytsMklLQjBjTTEzY3ozV01td3NsQTRB?=
 =?utf-8?B?Znc1RHc1azlWc3AzTHQxZlFEa2Y1S2xxYnRkK3o3WlREMTZHZnVlQXlJSXZR?=
 =?utf-8?B?TFcxdERrWlFLTWVFQnlmZmVpOVJ0Y2xoNlRDZHBHMGNjdWlxQXBFeUhWUG9I?=
 =?utf-8?B?dmpBekVCazg0TGIvZ21CM3pUSnRuNXdyaUhrVWR1OGl3QVJ4NjdudWszTVhO?=
 =?utf-8?B?aDNybE1UMlJKWkVNNlFZNlQwZVUxSnk0YTFwSGdsUnBhMDJkdWcvdHY5bTdx?=
 =?utf-8?B?Q2FJVngweHJvb3E0ZkNENk5SaUdLdVo4ZUJDUTA2UUx3ekdCd1hjZDVhWmdz?=
 =?utf-8?B?QW00Z1dUSnZ6R1lRSGxUbElQOXUwOXlqcnkvVXpTZXhQcHR5YkUyZElZQkMy?=
 =?utf-8?B?akxoemVTbzVuU3QzZVE4V1c2eXY3REJiUUUrcjdHbEFqcURyNHh3bHBuUkJP?=
 =?utf-8?B?RjlwYThWNms0ZFNUNkVZWG9IbjRaS0x6QXJxU3p5eUNielpGbHVCZ1JrSEEv?=
 =?utf-8?B?NVlrdEY3aXVvZ2ttS2ZVOFZNQkZTZi82ZlVQL01MVHVib3J4UnpJRENjRW5R?=
 =?utf-8?B?QzlkdWxYWjUzbzhlU3V2NzhzL0tCSEtFWUZSQjcxenFmRGVXWXpMVitpSlVh?=
 =?utf-8?B?L3U5bWNtRDJ4MnZDQ0hVWllyZVpXSWJEUTI2S3F1SmN4M0tiejh3ZG0wU1pu?=
 =?utf-8?B?bzNuSCtJNDcyUEU4bGt3S0Nhd2lrQ2hpdTVwQXkxNmJLTG54djJRdGFLcHA2?=
 =?utf-8?B?ZGlUbWpDa1g0VnFKenJhN0k5M2Y3VjByM3lOd2hzNjNBOVZrT1VaR2pDdkZn?=
 =?utf-8?Q?IROvLqOkeCNZqFlyjCL4z55Bo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5A2360DF105934F8C52565AE283B1C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6372289a-87f0-4c89-103a-08da764467de
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 18:08:59.8337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tP0+LJtJpIS7K+2spLZFrQngvZfZmY0sjv0IzzDS9zWuw8ily0QjwbyrHJIA2z3L+BOj5C3JITSle4KD2PDbZWyPzcNu+rpwj2eLir5DBd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1767
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMDQvMDgvMjIgMTk6NTUsIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
DQo+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gSGksDQo+DQo+IHRoYW5rcyBmb3IgdGhlIHBh
dGNoIQ0KPg0KPiBBbSAyMDIyLTA4LTA0IDE1OjE4LCBzY2hyaWViIEFqYXkuS2F0aGF0QG1pY3Jv
Y2hpcC5jb206DQo+PiBGcm9tOiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29t
Pg0KPj4NCj4+IFNvbWV0aW1lcyAnd2lsY19zZGlvX2NtZDUzJyBpcyBjYWxsZWQgd2l0aCBhZGRy
ZXNzZXMgcG9pbnRpbmcgdG8gYW4NCj4+IG9iamVjdCBvbiB0aGUgc3RhY2suIFVzZSBkeW5hbWlj
YWxseSBhbGxvY2F0ZWQgbWVtb3J5IGZvciBjbWQ1MyBpbnN0ZWFkDQo+PiBvZiBzdGFjayBhZGRy
ZXNzIHdoaWNoIGlzIG5vdCBETUEnYWJsZS4NCj4+DQo+PiBGaXhlczogNTYyNWY5NjVkNzY0ICgi
d2lsYzEwMDA6IG1vdmUgd2lsYyBkcml2ZXIgb3V0IG9mIHN0YWdpbmciKQ0KPj4gUmVwb3J0ZWQt
Ynk6IE1pY2hhZWwgV2FsbGUgPG13YWxsZUBrZXJuZWwub3JnPg0KPj4gU3VnZ2VzdGVkLWJ5OiBN
aWNoYWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEFqYXkg
U2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+DQo+PiBUaGlzIHBh
dGNoIGlzIGNyZWF0ZWQgYmFzZWQgb24gWzFdIGFuZCBjaGFuZ2VzIGFyZSBkb25lIGFzIGRpc2N1
c3NlZCBpbg0KPj4gdGhlIHNhbWUgdGhyZWFkLg0KPj4NCj4+IFsxXS4NCj4+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIyMDcyODE1
MjAzNy4zODY1NDMtMS1taWNoYWVsQHdhbGxlLmNjLyANCj4+DQo+Pg0KPj4gwqAuLi4vbmV0L3dp
cmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuaMKgIHzCoCAxICsNCj4+IMKgLi4uL25l
dC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc2Rpby5jwqDCoMKgIHwgMjMgKysrKysrKysr
KysrKysrLS0tLQ0KPj4gwqAuLi4vbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFu
LmPCoMKgwqAgfMKgIDIgKy0NCj4+IMKgMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0ZGV2LmgNCj4+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWljcm9jaGlwL3dpbGMxMDAwL25ldGRldi5oDQo+PiBpbmRleCA0M2MwODVjNzRiN2EuLjIxMzdl
ZjI5NDk1MyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93
aWxjMTAwMC9uZXRkZXYuaA0KPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlw
L3dpbGMxMDAwL25ldGRldi5oDQo+PiBAQCAtMjQ1LDYgKzI0NSw3IEBAIHN0cnVjdCB3aWxjIHsN
Cj4+IMKgwqDCoMKgwqAgdTggKnJ4X2J1ZmZlcjsNCj4+IMKgwqDCoMKgwqAgdTMyIHJ4X2J1ZmZl
cl9vZmZzZXQ7DQo+PiDCoMKgwqDCoMKgIHU4ICp0eF9idWZmZXI7DQo+PiArwqDCoMKgwqAgdTMy
IHZtbV90YWJsZVtXSUxDX1ZNTV9UQkxfU0laRV07DQo+DQo+IFNob3VsZG4ndCB0aGlzIGJlICJ1
MzIgKnZtbV90YWJsZSIganVkZ2luZyBieSB0aGUNCj4gb3RoZXIgbWVtYmVycyBvZiB0aGlzIHN0
cnVjdHVyZS4NCj4NCg0KT2theS4gSSB3aWxsIGNoYW5nZSBpdC4NCg0KDQo+PiDCoMKgwqDCoMKg
IHN0cnVjdCB0eHFfaGFuZGxlIHR4cVtOUVVFVUVTXTsNCj4+IMKgwqDCoMKgwqAgaW50IHR4cV9l
bnRyaWVzOw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93
aWxjMTAwMC9zZGlvLmMNCj4+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMx
MDAwL3NkaW8uYw0KPj4gaW5kZXggNjAwY2M1N2U5ZGEyLi44YmIwYjhlMTg5YWYgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc2Rpby5jDQo+
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc2Rpby5jDQo+
PiBAQCAtMjgsNiArMjgsNyBAQCBzdHJ1Y3Qgd2lsY19zZGlvIHsNCj4+IMKgwqDCoMKgwqAgdTMy
IGJsb2NrX3NpemU7DQo+PiDCoMKgwqDCoMKgIGJvb2wgaXNpbml0Ow0KPj4gwqDCoMKgwqDCoCBp
bnQgaGFzX3RocnB0X2VuaDM7DQo+PiArwqDCoMKgwqAgdTggKmNtZDUzX2J1ZjsNCj4+IMKgfTsN
Cj4+DQo+PiDCoHN0cnVjdCBzZGlvX2NtZDUyIHsNCj4+IEBAIC0xMjgsMTAgKzEyOSwxNiBAQCBz
dGF0aWMgaW50IHdpbGNfc2Rpb19wcm9iZShzdHJ1Y3Qgc2Rpb19mdW5jDQo+PiAqZnVuYywNCj4+
IMKgwqDCoMKgwqAgaWYgKCFzZGlvX3ByaXYpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVOT01FTTsNCj4+DQo+PiArwqDCoMKgwqAgc2Rpb19wcml2LT5jbWQ1M19idWYg
PSBremFsbG9jKHNpemVvZih1MzIpLCBHRlBfS0VSTkVMKTsNCj4+ICvCoMKgwqDCoCBpZiAoIXNk
aW9fcHJpdi0+Y21kNTNfYnVmKSB7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IC1FTk9NRU07DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZnJlZTsNCj4+ICvC
oMKgwqDCoCB9DQo+PiArDQo+PiDCoMKgwqDCoMKgIHJldCA9IHdpbGNfY2ZnODAyMTFfaW5pdCgm
d2lsYywgJmZ1bmMtPmRldiwgV0lMQ19ISUZfU0RJTywNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmd2lsY19oaWZfc2Rpbyk7
DQo+PiDCoMKgwqDCoMKgIGlmIChyZXQpDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdv
dG8gZnJlZTsNCj4NCj4ganVzdCB1c2UgImdvdG8gZnJlZTsiLiBrZnJlZShOVUxMKSBpcyBhIG5v
b3AuDQo+DQpPaw0KDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZnJlZV9idWZm
ZXI7DQo+Pg0KPj4gwqDCoMKgwqDCoCBpZiAoSVNfRU5BQkxFRChDT05GSUdfV0lMQzEwMDBfSFdf
T09CX0lOVFIpKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNl
X25vZGUgKm5wID0gZnVuYy0+Y2FyZC0+ZGV2Lm9mX25vZGU7DQo+PiBAQCAtMTYwLDYgKzE2Nyw4
IEBAIHN0YXRpYyBpbnQgd2lsY19zZGlvX3Byb2JlKHN0cnVjdCBzZGlvX2Z1bmMgKmZ1bmMsDQo+
PiDCoGRpc3Bvc2VfaXJxOg0KPj4gwqDCoMKgwqDCoCBpcnFfZGlzcG9zZV9tYXBwaW5nKHdpbGMt
PmRldl9pcnFfbnVtKTsNCj4+IMKgwqDCoMKgwqAgd2lsY19uZXRkZXZfY2xlYW51cCh3aWxjKTsN
Cj4+ICtmcmVlX2J1ZmZlcjoNCj4+ICvCoMKgwqDCoCBrZnJlZShzZGlvX3ByaXYtPmNtZDUzX2J1
Zik7DQo+PiDCoGZyZWU6DQo+PiDCoMKgwqDCoMKgIGtmcmVlKHNkaW9fcHJpdik7DQo+PiDCoMKg
wqDCoMKgIHJldHVybiByZXQ7DQo+PiBAQCAtMTcyLDYgKzE4MSw3IEBAIHN0YXRpYyB2b2lkIHdp
bGNfc2Rpb19yZW1vdmUoc3RydWN0IHNkaW9fZnVuYw0KPj4gKmZ1bmMpDQo+Pg0KPj4gwqDCoMKg
wqDCoCBjbGtfZGlzYWJsZV91bnByZXBhcmUod2lsYy0+cnRjX2Nsayk7DQo+PiDCoMKgwqDCoMKg
IHdpbGNfbmV0ZGV2X2NsZWFudXAod2lsYyk7DQo+PiArwqDCoMKgwqAga2ZyZWUoc2Rpb19wcml2
LT5jbWQ1M19idWYpOw0KPj4gwqDCoMKgwqDCoCBrZnJlZShzZGlvX3ByaXYpOw0KPj4gwqB9DQo+
Pg0KPj4gQEAgLTM3NSw4ICszODUsMTAgQEAgc3RhdGljIGludCB3aWxjX3NkaW9fd3JpdGVfcmVn
KHN0cnVjdCB3aWxjICp3aWxjLA0KPj4gdTMyIGFkZHIsIHUzMiBkYXRhKQ0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY21kLmFkZHJlc3MgPSBXSUxDX1NESU9fRkJSX0RBVEFfUkVHOw0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY21kLmJsb2NrX21vZGUgPSAwOw0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY21kLmluY3JlbWVudCA9IDE7DQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNtZC5jb3VudCA9IDQ7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNtZC5idWZmZXIgPSAodTggKikmZGF0YTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY21kLmNvdW50ID0gc2l6ZW9mKHUzMik7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qIGNvcHkgdG8gYSBib3VuY2UgYnVmZmVyIHRvIGF2b2lkIHVzZSBvZiBzdGFjayANCj4+IHZh
cmlhYmxlICovDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNweShzZGlvX3ByaXYt
PmNtZDUzX2J1ZiwgJmRhdGEsIHNpemVvZih1MzIpKTsNCj4NCj4gTG9ja2luZyBzZWVtcyB0byBi
ZSBtaXNzaW5nLCBubz8gSG93IGlzIHNkaW9fcHJpdi0+Y21kNTNfYnVmDQo+IHByb3RlY3RlZCBm
cm9tIHBhcmFsbGVsIGFjY2Vzcz8NCg0KWWVzLCBJIGFsc28gdGhpbmsgbG9jayB3b3VsZCBiZSBy
ZXF1aXJlZCB3aXRoIHRoZXNlIGNoYW5nZXMuIEkgYW0gDQpwbGFubmluZyB0byB1c2UgdGhlIGV4
aXN0aW5nICdzZGlvX2NsYWltX2hvc3QnIGxvY2tpbmcgaW5zdGVhZCBvZiANCmludHJvZHVjaW5n
IGEgbmV3IGxvY2sgYW5kIGFsc28gdGFrZSBjYXJlIHRvIG5vdCBhZGRpbmcgYSBkdXBsaWNhdGUg
QVBJIA0KdG8gaGFuZGxlIGNtZDUzLiBGb3IgYmV0dGVyIHVuZGVyc3RhbmRpbmcsIEkgd2lsbCBz
ZW5kIHRoZSB2MiBwYXRjaCBmb3IgDQpyZXZpZXcuDQoNClJlZ2FyZHMsDQpBamF5Jw0KDQo=
