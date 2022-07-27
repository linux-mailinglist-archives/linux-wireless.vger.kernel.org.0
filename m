Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333F58321F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiG0Sfc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 14:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiG0SfN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 14:35:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382E152458
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658943170; x=1690479170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zncWfMD5luWAIkrd0HZVeBM7hlC80nytvuo3R7bEFBc=;
  b=NQNTW/gUfzxMHagyFWAUmNMjVEppdlc6R5+CSW80Rc4Fnr1ERq4qk5s5
   Vy1r/5vu5NtLVKXyHbA31kIH+kW3YNShnVKMWlOrOUoag5tDiU4kD0gOs
   UAaNjCC5aTHppxOA05LywTJFH8CMFxtEt0Us/y6DJ47QSbOWICSyCc2A4
   eiNml9vwbwABnShyz7MalpGHImRg4fOqqbyTMqOGHwg7EDCqEYOagbSdE
   YugWvX7m2mZI/f82yBC8Rv7QtO/GyTp+lzFEF6mYqy7pWTCOwAPU4aNli
   oUlUnawUOG3pIY4xt13TSopUaZr70AI/enpXvVODch8EF4FH03VDLFRe+
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="166669715"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 10:32:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 10:32:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 10:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSp1i8uYImiWvX+f4+MzseaNS99F0buSrErAirz61Tm67GpOm+/6N5IQdFg2OLrzxBUV+02kUY/5n67nWSirQjT0cWzA6j13cxqKvijmi/y55sqJlTsq+se+JgqkrMUsphZO/34PXbMl/q96q0WU9wv6aF5E3HXSVUznvVpMDz8qLieBc2HGUpQjqc/NFm5ZyKJEZl6xBjjAOYEVo+YlkH11x7v2ZhVaoVt93iVT7a4EczFzy0vKqtH75mZRXyc+hWUrb3A9d2Zfapds4YrnP+X3nHebHMFHOIU15/lePfumnt6aGeikw0FVn6dXJXLMNX/1hE3/R4fC55Uq/oCGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zncWfMD5luWAIkrd0HZVeBM7hlC80nytvuo3R7bEFBc=;
 b=OUCRhHIrWMdJ//mwXcQTFpP1aqBERZbAK3FaG7fedoe6fYvHh8imcsr5jsqnfQiGoaIq6Ubv0hHb9nmrbQEknVyCKjjvIAVokqsSa7CdmpJafJY6VISUeRDO1sj/uuMCamzd28d2cW8ijemkQ+z1410BXuE6tuAiwPKEDnJWQ6d5WKXZUruUgs789VXufd9sQfNgcZ0vgJokVewV7aYrQZGaP1L7kh4iombYif7II0pU5JpiYRpqfSo52B6uATUzfbbAVx8v5KpbmRBCRGBtsYWOmfEo9XMO7RC2LR381MfB0wMIUv+890s8jkPEVP6oJSHneMdHTgPlnpMHM0LTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zncWfMD5luWAIkrd0HZVeBM7hlC80nytvuo3R7bEFBc=;
 b=V94b8pKMQQaw7q/JTbDagRFOsB7oG81c7dSJpg+zQYane0U7H2DiZiXTGUAe9lymyk51wl77Xk2ijDdqy6PaZ4T5XOMmPVvXtwCqJommS0kqb0LO8XAcWytfN1sTxOMfk4apiGq7Whq1Wrq8fomnUW++rkYIwwmH9lHw7qMmtlc=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 17:32:03 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 17:32:03 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <lkp@intel.com>
Subject: Re: [PATCH 1/8] wifi: wilc1000: fix incorrect type assignment sparse
 warning
Thread-Topic: [PATCH 1/8] wifi: wilc1000: fix incorrect type assignment sparse
 warning
Thread-Index: AQHYnFIwX0T9qNvnekGY6lt0TN0NsK2SOUUNgABLpgA=
Date:   Wed, 27 Jul 2022 17:32:03 +0000
Message-ID: <2b432ae1-48fc-5a70-0afe-2b9f788f14e4@microchip.com>
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
 <87v8rik8vp.fsf@kernel.org>
In-Reply-To: <87v8rik8vp.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a7589c8-5640-4304-8464-08da6ff5ebae
x-ms-traffictypediagnostic: MW3PR11MB4683:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +eEc/u7kRMNLjromQmMZRORf+vdD4l/DxNsKPqblzc1Aplau/JBMGSn6nrRVXbG2tO4+WnTNLvkqpMOWxHGWKVG3DUfhnaudtdzAc62PpeNwaeatMDh+l/uWOIc8S/cg12LnbbO+/te5SR3GlR+DUpvp9ydHuMAMo6jvxAZkJDgQwzwCopo8tMPxaH7cXfBSXc1LZPGcVi3JQBaIRP0YXWOjPErmvGgl+jTFFTXwAxg3iIWFQkfSJajZP4HQ2fwSLDrIV2BcWATOqaNbUHQFRVJcauKYY0QOTldudGK+ubZj9sZuiyEI3c9qDBGnbXeE0UXGmgPyH+dzKSjdZKQO2dZanvTk2H1nLArmmJBJiCFxFj/PK12lUWIFfHjchc2MOWAUUQSe++/iNYRtLyFwTUVgmCajAvLKzd+R//6Xf+QEtjAhR8FIZw2IX50DzDV2rQIhGN6NuXbv1zVxYXDCYRx+TIi0eIB3T0hH47I/mpFa5WLXh+NXK51cRhd8JVJIWiSlaCc5Q0R/0mh7b6j5rkkPGW5xKgVcC0ZJ3YrbDs/CIfFkgddBwEizo7OWHDBCdT3wmKdOpkivNOLB0DqlU3DCBW3ovXauPV/afWUy/df3nS08aBDM9uTINAQiSHTit1DIANlwT5HuKxmZlOClBLtoI/93qjnqwjDb4GVUhIU2aXmR2kqLvuksp7nrxfmmfHIt8ZZpa/Ti6ugYMP4uJkSAH0Zn2FkpcALvk3pkcIfM6MV4rsIFzpV73pldvIU31fse9C5f7pJ3VldJ4s4ONbQfT7/NthShLLv/YXX2mhaX9cZ0D3uCrUAgvvjnX2A71PfAoaY67XVkWMJ59ZcmBaYdDU1J2M2ZXtrKY379gl0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(122000001)(53546011)(26005)(38100700002)(31686004)(2616005)(6486002)(83380400001)(316002)(71200400001)(6512007)(6506007)(41300700001)(6916009)(478600001)(54906003)(5660300002)(64756008)(91956017)(66476007)(4326008)(66446008)(186003)(55236004)(8936002)(2906002)(66556008)(31696002)(38070700005)(66946007)(86362001)(36756003)(8676002)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aStpeGpBQk5MeUUzRUlOSldyVFBLZE5ZS2xsQ1A1Z3dFUVlGN1ZjaDBXNG1N?=
 =?utf-8?B?d0NHWTBBaWNQeFZsbFN5VTlIdEx1eDdpVWd2UnU2cDR6RERhZHFkdkxLOVhJ?=
 =?utf-8?B?aEY0all1ZC9vVFBhNHd1ZjZrNTg5QlY5aForTVkvR3Z4c01iMmFVSXdBOTVh?=
 =?utf-8?B?dVhpUDNMQVRUZWdMYlNsVEpNaE13MDludy94NDkzZ01DTlhKUTR1QUFRemk0?=
 =?utf-8?B?cndGaVNYVHpQekxQRXgyeXk3MDVYRzdMV250bSs0eDVLbFRRQTVCa2I0eDRk?=
 =?utf-8?B?QVpIV2FJWGI3Y1NVRno2Rmh5cXhRbXU0Nm1ONTludHBMWkNtcjZtclJrVDYx?=
 =?utf-8?B?aGd5V0JsbUlmOCttV2JpNzM2ay9Vc1JTRzRPTzk3bHByb2RHQzRFTGI5bnI2?=
 =?utf-8?B?OG1uajFnY0dCUnlVKzBxWjloT0w5LytUMmhBaFN3YVhsVW9zU1lvMUwvSkhC?=
 =?utf-8?B?cUlITkE2OVZ0NlBBMXdsOWdZUnlHeUJTRXRqTzhwY1lHTkVGZXJvL0lIaURF?=
 =?utf-8?B?R3l1djdTOXpKdURhNzI5cWtuaDN5S0JOK2RwZXlWQVorVUxuM1pqQUVpQTBP?=
 =?utf-8?B?Z1hGejFJaEF3ZTF5T3U2cHRzdmswV08rQytzckJZSFRuT29Kci9tOUVLRmx2?=
 =?utf-8?B?MkJEektUajFUU0NLd21rbkkrOTI2NEU4TzZTbkU5U1Q1TlA4SmU0dkVENEJT?=
 =?utf-8?B?dFlhL25lRUhrL1M2bjQ0MWdqdm1XbmticjJJMDl0eVJsMnBBS3NKVHlzUGo3?=
 =?utf-8?B?dURVT2pNTnNZRGl3enZZb1JrdG1NaTRXa1FaN0RUNk94c0YzeHRLdExDOFk0?=
 =?utf-8?B?aGZIcGRvaWRWd0JVZnRaQUlnNlJtdEtRc2NWa3BZaXg0WExwNjdCKzdlVmxv?=
 =?utf-8?B?YVN1M0Z5VXhnYkc3KzdYYnR3UGpHWWp4anlrNXNyemtsK3NjaWN1SnhMdmNM?=
 =?utf-8?B?ZERjSUY5ZzNkeDV2VWMyb2luU3RKTFBtenRUVmJKNUl3bE93VUJDQ1lrc1ly?=
 =?utf-8?B?ZVFmYkQ2SGhrZ0VCM0NTMWZHQnI2NVlxQ24raFRudGRwTEo0Rm1TUjVSTFFI?=
 =?utf-8?B?akNxWXFPUkNMNTFVNG9ObEM4Mlppbi9xY09PZHRnTDdsdVBreSt5V0VPQXJ0?=
 =?utf-8?B?TXJLS29jMUtiRm53WjU0b1h3SS92R1dWZzc4b0RPcWVXWXpzaVo1R1lnR2RD?=
 =?utf-8?B?M3Urd2Zvc0hJeUZnN3RES0xBbWR2ejFpUXhzMUxVNDJpWjViaFdkTGhaVk9t?=
 =?utf-8?B?NzZmaisxdWpJcThEUG56M0pCMk9RZTlwZlJsTFpWZ1h6RHIrMHh4MlA1dUxE?=
 =?utf-8?B?QXFrcnovcHdBWHI1NzlZRjVDbzhEUVQxdDhVMjZuckNORVc3UnJZU3k5NjZM?=
 =?utf-8?B?Z050MWRYZENScUxjc0hnbktkemd2VXF4Y2ZwTEk0bnlwTVpwVHg2UzlucFJ0?=
 =?utf-8?B?bDNiei95OXMwTjVGSktsUUxLNXQ5cGNZRU84UGZjTFdOUUpyV3IzOFFHb3Rv?=
 =?utf-8?B?cm04ZlZCUjBoS0pBZzNvUERMOWtUNWVJSVBJZWdqcHZtVjhvUUNLVUVLamVo?=
 =?utf-8?B?cTloM2pOQUFPQ25YOVJaWkNzWThFV3JEYnd3VW9UcXA2S2wvNnVuajF6ZHE3?=
 =?utf-8?B?ME11dklVVk41d0J3QXFGY2NvNzM4YUM4cDgzbWxOSkl6a2xmNG03UHFTOFFG?=
 =?utf-8?B?aEpYcndyeWFzeHMrN0lsb0hHY1YvMCtieUpkVEwrdmdKaWQzVVVoVGVkTHNu?=
 =?utf-8?B?N3ArWldxdk9ZMk03Y0dkQXNZQjZJRkRPOGd5SzNSb2NVamQ5NFkyNTgvTFJS?=
 =?utf-8?B?U2dicmNTQ0VpRzVBU2YzM04rd1N4WTE0bUxWTWRDQ3JMSCtCdEUxdlRIbE5T?=
 =?utf-8?B?NXovSnRTd2RxUVIvMmFCYk1RMXpFTHhHTXI0WnA3Smg3V1h4OEQ4bGhzak5D?=
 =?utf-8?B?NXQzQkw4MGtSQmJybXFiaTBoZi9mb3JrOVErSnhpak9DMmxlUzZBOXM2Zm91?=
 =?utf-8?B?blNvWFBEZi9xeGZxTDFBSDJub2VsTnV1OGI2aEFhR0xrQjA5bk5wNEpJYVQ1?=
 =?utf-8?B?QWR1OWxXTU5VQUJybXltSGs0OFEzYnVmS3M3aUFObDE2UVFOekhWS3R5cGNr?=
 =?utf-8?Q?kIEGj48aFQmJcb4vdpzIpcxUA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96560776F77F5F4DBB8F6BF240CAFBD6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7589c8-5640-4304-8464-08da6ff5ebae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 17:32:03.7475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/M160SayT00aW505VMW0Ikp7nFJYKk3YEXzyi6hGsbiCs+WDV76Sgi9m3nQZUzQ5FWpOgTxahOorZfH2YqdR+LlYGI2zk3WS7OMLczVfCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDI3LzA3LzIyIDE4OjMwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gPEFqYXkuS2F0aGF0QG1pY3JvY2hp
cC5jb20+IHdyaXRlczoNCj4NCj4+IEZyb206IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3Jv
Y2hpcC5jb20+DQo+Pg0KPj4gU3BhcnNlIHJlcG9ydGVkIGJlbG93IHdhcm5pbmcNCj4+Pj4gZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2NmZzgwMjExLmM6MzYxOjQyOiBz
cGFyc2U6IHNwYXJzZTogaW5jb3JyZWN0IHR5cGUgaW4gYXNzaWdubWVudCAoZGlmZmVyZW50IGJh
c2UgdHlwZXMpIEBAICAgICBleHBlY3RlZCB1bnNpZ25lZCBpbnQga2V5X21nbXRfc3VpdGUgQEAg
ICAgIGdvdCByZXN0cmljdGVkIF9fYmUzMiBbdXNlcnR5cGVdIEBADQo+PiAna2V5X21nbXRfc3Vp
dGUnIHZhbHVlIGlzIGV4cGVjdGVkIGluIGJpZy1lbmRpYW4gZm9ybWF0LiBBZnRlciByZWNlaXZp
bmcNCj4+IG1nbXRfc3VpdGUgdmFsdWUgZnJvbSB3cGFfcyBjb252ZXJ0IHRvIGNwdSBlbmRpYW5u
ZXNzIGJlY2F1c2UgdGhlIHNhbWUNCj4+IHZhbHVlIGlzIHJldHVybiBiYWNrIHVzaW5nIGNmZzgw
MjExX2V4dGVybmFsX2F1dGhfcmVxdWVzdCgpLiBVc2UNCj4+IGJlMzJfdG9fY3B1KCkgY29udmVy
c2lvbiBBUEkgdG8gYXZvaWQgdGhlIHNwYXJzZSB3YXJuaW5nLg0KPj4NCj4+IFJlcG9ydGVkLWJ5
OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+IEZpeGVzOiBjNWIzMzFkNGY1
NTBmYjc4ICgid2lmaTogd2lsYzEwMDA6IGFkZCBXUEEzIFNBRSBzdXBwb3J0IikNCj4+IFNpZ25l
ZC1vZmYtYnk6IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0N
Cj4+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL2NmZzgwMjExLmMg
fCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2ls
YzEwMDAvY2ZnODAyMTEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAw
MC9jZmc4MDIxMS5jDQo+PiBpbmRleCA1YzJjN2YxZGJmZmQuLjE5ODYyZDkzMmYxZiAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9jZmc4MDIx
MS5jDQo+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvY2Zn
ODAyMTEuYw0KPj4gQEAgLTM1OSw3ICszNTksNyBAQCBzdGF0aWMgaW50IGNvbm5lY3Qoc3RydWN0
IHdpcGh5ICp3aXBoeSwgc3RydWN0IG5ldF9kZXZpY2UgKmRldiwNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgbWVtY3B5KHZpZi0+YXV0aC5zc2lkLnNzaWQsIHNtZS0+c3NpZCwgc21lLT5zc2lk
X2xlbik7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHZpZi0+YXV0aC5zc2lkLnNzaWRfbGVu
ID0gc21lLT5zc2lkX2xlbjsNCj4+ICAgICAgICAgICAgICAgIH0NCj4+IC0gICAgICAgICAgICAg
dmlmLT5hdXRoLmtleV9tZ210X3N1aXRlID0gY3B1X3RvX2JlMzIoc21lLT5jcnlwdG8uYWttX3N1
aXRlc1swXSk7DQo+PiArICAgICAgICAgICAgIHZpZi0+YXV0aC5rZXlfbWdtdF9zdWl0ZSA9IGJl
MzJfdG9fY3B1KChfX2ZvcmNlIF9fYmUzMilzbWUtPmNyeXB0by5ha21fc3VpdGVzWzBdKTsNCj4g
Tm8gdGltZSB0byBpbnZlc3RpZ2F0ZSBpbiBkZXRhaWwgYnV0IHRoZSBjYXN0IGlzIGp1c3QgdWds
eS4gSXNuJ3QgdGhlcmUNCj4gYSBiZXR0ZXIgd2F5IHRvIGZpeCB0aGlzPw0KDQoNCkkgdGhpbmss
IHRoZXJlIGlzIGFuIGFub3RoZXIgd2F5IHRvIGhhbmRsZSB0aGlzIGlzc3VlLiAna2V5X21nbXRf
c3VpdGUnIA0KZWxlbWVudCBpbiAnY2ZnODAyMTFfZXh0ZXJuYWxfYXV0aF9wYXJhbXMnIHN0cnVj
dCBzaG91bGQgYmUgY29udmVydGVkIHRvIA0KJ19fYmUzMicgdHlwZShsaWtlIGJlbG93IGNvZGUg
c25pcHBldCkgYmVjYXVzZSB3cGFfcyBleHBlY3RzIHRoZSB2YWx1ZSANCmluIGJpZy1lbmRpYW4g
Zm9ybWF0IC4gQWZ0ZXIgdGhpcyBjaGFuZ2UsIHRoZSB0eXBlIGNhc2UgY2FuIGJlIGF2b2lkZWQu
IA0KVGhvdWdoIEkgYW0gbm90IHN1cmUgaWYgdGhlc2UgY2hhbmdlcyBjYW4gaGF2ZSBpbXBhY3Qg
b24gb3RoZXIgZHJpdmVyLg0KDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9jZmc4MDIxMS5o
IGIvaW5jbHVkZS9uZXQvY2ZnODAyMTEuaA0KaW5kZXggY2M4YTk4ODBiOWQ2Li45MmRmNzBhZmU0
NDUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL25ldC9jZmc4MDIxMS5oDQorKysgYi9pbmNsdWRlL25l
dC9jZmc4MDIxMS5oDQpAQCAtMzUwOSw3ICszNTA5LDcgQEAgc3RydWN0IGNmZzgwMjExX2V4dGVy
bmFsX2F1dGhfcGFyYW1zIHsNCiDCoMKgwqDCoMKgwqDCoCBlbnVtIG5sODAyMTFfZXh0ZXJuYWxf
YXV0aF9hY3Rpb24gYWN0aW9uOw0KIMKgwqDCoMKgwqDCoMKgIHU4IGJzc2lkW0VUSF9BTEVOXSBf
X2FsaWduZWQoMik7DQogwqDCoMKgwqDCoMKgwqAgc3RydWN0IGNmZzgwMjExX3NzaWQgc3NpZDsN
Ci3CoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGtleV9tZ210X3N1aXRlOw0KK8KgwqDCoMKgwqDC
oCBfX2JlMzIga2V5X21nbXRfc3VpdGU7DQogwqDCoMKgwqDCoMKgwqAgdTE2IHN0YXR1czsNCiDC
oMKgwqDCoMKgwqDCoCBjb25zdCB1OCAqcG1raWQ7DQogwqB9Ow0KDQoNClJlZ2FyZHMsDQpBamF5
DQoNCg==
