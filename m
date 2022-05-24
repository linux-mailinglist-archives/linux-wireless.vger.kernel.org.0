Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B3E5324F4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 10:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiEXIJp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 04:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiEXIJg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 04:09:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB577F05
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653379771; x=1684915771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cto81FLF3S2D41EJP2s0HscV2G2sKkp70TghYs9HD+Q=;
  b=hE4F1jiwdXTjlrjsYcqnMKLPp2PttOt4Xwj2jHHlxz0sUeIJSZ6z4XW/
   FXyIGQFoR879k9V96+pmPkrfzEcA1vVyl7Kcy6s3i2S2u/MYxUP4fuG1f
   sgNb4GDjoQH2Gv5y2xpRKWdLqWV1auHIkX8NbQH/PX8LebeAeKJSLw85E
   Mstt8/LiX7qvsFLb9r+ch8kfXo9QqmnDEQqJMj3+GVDuFhDAblqGTtNVn
   +RXDy0n52xXo6MX36nCyWqUc/WeWncNkAtoiisgywXwv2xpia5LxOCd2a
   nx7/mw+ZgpMGEUnSAYcTvdh6Wt5n8v+rgNw0H9rjWtFbKOxwOW1aV5BPw
   g==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="160348774"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2022 01:09:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 24 May 2022 01:09:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 24 May 2022 01:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTRR3UV0HR0mAKdWIPEBtc2nboiipnHqQskfUav4LvxQAbSQ/ZtxJYqRsK+9KmPUTHjNW57je8mkMurwKN3U9cTJgBDWt4z8RT5IYG+8aE1+KhkSxw/T48jenMncfn1bpWqMhOKRnHDxWyjOEEkDTVgHOgmyTKEWyOsFYdRzLC89nb84tvHZWCSPAleXTFBDFsFEZrVsdFBo7arqovRzf/fQ9xI3v5u4lhhonT8QERqF9tsUDPi3mgHyC9u+cP3bBG61pnrQTUqMmZGxX8UNrQ6k69WH5RvYK6vGmURWVKVAIhhN3Wreo33nYbOz3V6rtxinSEiBS+3DMZrozXCK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cto81FLF3S2D41EJP2s0HscV2G2sKkp70TghYs9HD+Q=;
 b=ibfU1tZ36Zh2xIEcv+02kHMadnvv/2RaXbgHB+kqa48QnlwKTVdu8TphGk6apJNymYL4Rid7R8czvnUFYA0dS59rnGBLQpXa1hQzBq8IxYnUsqUR8rrJZoHBLFQu19NhmWkPgyaDELxyuXUuBk04V5aLpdhcWJzVQpo+ud6jB6Jll/SI/1JhRKJsQA7MzaonwyPYXW3o5G5dXhkAC8JuBluSmoSNt8y/g2XD+VGc5TvV/WVU2hwkKaU1NEWNMD7kdlqdqdwpPp9RI3jpb5HDf+rZYNNOg/TiFnJxUam0V8gBLEbwF4CvU3hUzcTXSLzc/3CZD47wH22HiqsMLYIUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cto81FLF3S2D41EJP2s0HscV2G2sKkp70TghYs9HD+Q=;
 b=N17GR33w6uqCrKeewqMZBmLlnB8LRH7D/j841ikAgTJ5wuxlqJgGGBASe5ywhVYNUwUGFWSaY8jJmRZ/W0OwbXLMehtshfFThLdn7Sb4Eu2FqLv8FhU+/zhfnLKWBLV5cVUxCvgK98JiOgZ/GR3IhCJN/614ss4LiB6OHoF0/Nk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CY4PR11MB1511.namprd11.prod.outlook.com (2603:10b6:910:b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 08:09:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::816a:10bd:7c5e:355b]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::816a:10bd:7c5e:355b%8]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 08:09:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Ajay.Kathat@microchip.com>, <linux-wireless@vger.kernel.org>
CC:     <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH v2 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Topic: [PATCH v2 1/4] wilc1000: use correct sequence of RESET for chip
 Power-UP/Down
Thread-Index: AQHYb0WOeWRidm2HykuU7dQlJGrLrQ==
Date:   Tue, 24 May 2022 08:09:14 +0000
Message-ID: <23630392-50ac-5588-8fdb-5e8950acb357@microchip.com>
References: <20220523140812.164028-1-ajay.kathat@microchip.com>
In-Reply-To: <20220523140812.164028-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a23073e1-14c5-40d0-8db3-08da3d5cb129
x-ms-traffictypediagnostic: CY4PR11MB1511:EE_
x-microsoft-antispam-prvs: <CY4PR11MB15110D3F89D6DFE9C3F0121187D79@CY4PR11MB1511.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+WjoBeDYqtyxgrh6wlFuVM6CsLgzOqlDAR31XjnaTW7AXZW1humkeSwOnqrqIEgKfYw4M3ixPVKUSFq7aDvyeWiMMQz+zKUkxnTmWmZ6Z+gxPurjnC6cEy4ExGEbwu5zHP3dtqpwlOuC/v1S3KNHoYoKvrK8dHtzwMz59TnAp3POJkhvcASIkqOwK+Y1fRdwlqZ+YoNSDgi58BUPQGT3NOhpG7OUfVp7AZbBr+o2eqDsCv5aTuJk1nw8l/kbe2ls9lSJ3l5gCbi+kQhLlGZ78/l4VzPNBxi+ODtzyXUbwbbPsQNUUQAe6djcD87xMe3x70uuF01SgvaCDBfH7hUSulEiHKhnCktz3Ja0dRiOgGa+xaji3nZ4ZtFlrQNNMh1s6FSlqyzYwUE4RCeYQJZ9MaUv+fVgQS8hYbzSt7/qkmhkcvav5GHIHwzJ6qyde0hFYwa/ZdHNPWj7RGpPdChLBO7wsMyzZKmGktdSATznilJtyEZo0T51E6BSdAc3wjvbpUyBuuFtR35KNDzxnxfYyNZn064RNcNcuo9AYcLu5iijsRvwQOsKXKVihdbE+81WLSLakTmWuwt2biTLKF55oINLGOILC7x+m+732JvKezvyjwN+9Mh5HJ8L4sgVaRAZ9Yo8YsLxhh6SXZVIkFb4mWsOAnYYdFVCVp1MH9G0unyugEwmoeUzbsfbw6GLVj3DZffafU+CbMAh5IpofyWyaxYja1cKzLgKcEKg92VgtcJQfv3egCEwaW9WLqulo5ckbYrgKqLjsHN6v0GV9ggTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(316002)(2906002)(6486002)(71200400001)(64756008)(66446008)(53546011)(66946007)(508600001)(110136005)(26005)(5660300002)(36756003)(31686004)(66556008)(76116006)(31696002)(8936002)(6512007)(107886003)(2616005)(4326008)(8676002)(86362001)(66476007)(186003)(83380400001)(38100700002)(6506007)(38070700005)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlR2cVR6MU5mMVErZEN6RkIwNitYMkVFdzlZL09Rd3A0L3c5dXpUb1pBclc4?=
 =?utf-8?B?SENXR0EybzdMTVNwZDQxaHl4OVFLbzRZbkoxMllkRXMwRWRQRGNNSE5qV3ZP?=
 =?utf-8?B?VEZhbVVLdFFWSUJyK0VFSXg5MkkwV2NNS1dTcWFRb1ZmZG1zRUVMWkx0Zkkv?=
 =?utf-8?B?MVN5WURWN3NTSGxoeE9CdjdqYld2aG5PR0poZlkyeU9ETi9PbVpFU2g5RFlL?=
 =?utf-8?B?SkxjM0ZNNWNHVTBRRDhwM1ExMEZIUTRzZWVJK3hsaURBYlRuWXI1RWF3S1N3?=
 =?utf-8?B?MlVjT1RmaG4yOG80K2dYSFlDMHlnNXR1QnhHZWU4QUhqSnZZazBYOFFrY1B5?=
 =?utf-8?B?OFJ4ZmEzWGRQZzVMaW5LRDd1eDNnTGIwd3ptVnlTV1VWQk5yUU5FTjlveTdK?=
 =?utf-8?B?RnlpRWhRTlE0U01NcVRxZkRNaUNWSTJsWUZ2TEt6N05rUm10dTFLSVBTL1R6?=
 =?utf-8?B?Tkorc2Q5RHdaaEQ5ZUlpblU4WS9xUkJZQjJLTjVDQzhSeERXTnlLaHdiSGJV?=
 =?utf-8?B?Mlc0R0NTdExxczN5czBUNEp2N1hIcXFGZU4wb2pOSjBqUFRubUtRa0o4cSt4?=
 =?utf-8?B?cnUvcWp0cXhXS3F2K2tSaXdYVjhtU3dWdTgzaVZnbmcvT3YxNE5pbUZKVis3?=
 =?utf-8?B?MTlWeWRUNjJZSmtuaTZ5VlFjcjdqT3JJU013WDB4ZmptaEt2MktZL09MckFU?=
 =?utf-8?B?OUdyVlFSdFoxQUE2VDRyVTRtbUcrSFVYQ2lxZnpoblp1NUNyY3JFT1dpY0cw?=
 =?utf-8?B?Umg2L2pwb0xHT0lpZWwrbmVQZDQ4ZGlwaEV3K0E3dEVsT0tBTGZhV1RlU29v?=
 =?utf-8?B?K1NsQkJERGVtZld1RklWUDhaQTNESTJCOTRZTzhPaUptYWlsSU54R3ZDVWI1?=
 =?utf-8?B?UUxST1hJcUlRQWJtZm95OUlwZjJ1WUhrb3MwbWdBTVJ1N0twWWVrQUYrWFQz?=
 =?utf-8?B?VFJYZVk0WUpVTEdRVXBGVU9hejV6RkQ5V25ranVPc2lwd0dMVGVsc2FtdzVU?=
 =?utf-8?B?Q3dMeksxWEErVCs1dEwvSHYxSzI3QkJWczdpcktudU5sL253eVVvcjhlL1o2?=
 =?utf-8?B?YWpXellCM2I0dUpwL0Y3a2pOb0hoN2huZ2VYNVJoV2tpc0taUktnblAzWXdm?=
 =?utf-8?B?STRNdjFNSmE4RlJwTjNpVlZHZ0t2QWdBOHoxTzVSSDZpQUg3djJ2WkZwWE92?=
 =?utf-8?B?REZHVzBmbG9Zd1FQbmE0aHkvSmZTTUJlemlDM1JoSjZXZFFLZk5JQXQyeEJn?=
 =?utf-8?B?RkRBdHhoL3UxYnRDdHpqQ2NyRlhWZFNGNmhZakJnZktBVE5la0hTY09yR0Nv?=
 =?utf-8?B?Sk5OVGpxNzY4RkI3Ykp5TTFDejMwYk9WNGhPckJJMFgxNGlVT0pKM0Q2K0kz?=
 =?utf-8?B?TmVUNjhYOFMzNFQ1ZS9YTkJOTERva1gyMmoyNHdKQTIwOUtBeTIzenVvZ0Nm?=
 =?utf-8?B?am1iZWJVc1h3QnRqclZpVHFzSVVyRmRkSWQ4ZnZjRGZGNmhjdXFUTGpMNTlX?=
 =?utf-8?B?cG84VEt2aTNTdUlsS0ZodFJDK1M2Y0kyQlY5cHAvaS84aGNHdmZId2ZaQkdw?=
 =?utf-8?B?S1ZCeWNmR25DQ3JZZVA4bVVCVmRWV05MVjdoOUxiSUVSMjNJbVgyWnQxTERG?=
 =?utf-8?B?bWVicWpsUEZRS095cWV6YTNZeUJtbTA1R3VBMk1KV1JpSDF6TEJQY1dNaVJJ?=
 =?utf-8?B?MXQ2K2tjNzhTTXZuUUF6N1VpZnRqR1lVZVYwNk9kUWdsWm53WXpmTnVLZDc0?=
 =?utf-8?B?SEc3dXBOWGVoTGVDdFRQeWQxQU9ZOXk1S1NyL0VJQjl0Y3RVLy9pWC9PdGJo?=
 =?utf-8?B?M2ZXKzVkVGZiQkNxek44aUVEbEd4T3MwVzU5ZXZJdExvTUlLVVBnZi95SW9Y?=
 =?utf-8?B?VlBZQW5UaGZMb08wSStBeHcra0JYZmo4SEdpK1ZXMkRYNUszRHBKYlM2VEJt?=
 =?utf-8?B?L2hIeUhqK254aGRvWFN1ZUhvZmlCNm1FeVZLWDJUdTBJVVR5M0hFRW8yZSt1?=
 =?utf-8?B?WjBSSjdEYzBTdnFOaTJRMm42ZG1qaDBsSWpyN1k1TEdTdUtvaFd6L0xDdDRi?=
 =?utf-8?B?U1pNU09XV3h6R0xEeTFNSFg2TXZ0bkMzL3U2Smp5eFFMZ0d4QStqWmtXazln?=
 =?utf-8?B?elMyRS9FNERmS1hRbmxOUVZ1RnlrWnlSa01KRUc1L1RDbExyVjBsNjhZNDhF?=
 =?utf-8?B?K2IvWnc4bG55a3ZabW9QTUN5bFRXT0tKdFMxMlFlSWFIWEZ4SmtYWklkNW9P?=
 =?utf-8?B?MDc5Sm9WLy9oMXBURDhveDhqamoxaThRVzdvbEU1MnQwWEVldGZWZHNBVFhq?=
 =?utf-8?B?bVlGdzBZUks2a0pxTDZia2VJazk0WkQ2REJYbFpTOWdKV2Z4VGY1NHpiZEZh?=
 =?utf-8?Q?Mz6h3SlWViz9LRKc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC12E7A4B50B594286623CC7C7683D40@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23073e1-14c5-40d0-8db3-08da3d5cb129
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 08:09:14.4766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VK1QerKxPlnGzV+14lBjKRX5Lc5fbDjsl1+niP8so+yZii8WABAZKYPVclpaHNczyA6DSEnRvOJ0eI9xBqfEyluly0yDXH8Cw/JCPTmxung=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1511
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksIEFqYXksDQoNCk9uIDIzLjA1LjIwMjIgMTc6MDksIEFqYXkgS2F0aGF0IC0gSTE1NDgxIHdy
b3RlOg0KPiBGcm9tOiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gRm9yIHBvd2VyLXVwIHNlcXVlbmNlLCBXSUxDIGV4cGVjdHMgUkVTRVQgc2V0IHRvIGhpZ2gg
NW1zIGFmdGVyIG1ha2luZw0KPiBjaGlwX2VuKGVuYWJsZSkgc28gY29ycmVjdGVkIGNoaXAgcG93
ZXItdXAgc2VxdWVuY2UgYnkgbWFraW5nIFJFU0VUIGhpZ2guDQo+IEZvciBQb3dlci1Eb3duIHNl
cXVlbmNlLCB0aGUgY29ycmVjdCBzZXF1ZW5jZSBtYWtlIFJFU0VUIGFuZCBDSElQX0VOIGxvdw0K
PiB3aXRob3V0IGFueSBleHRyYSBkZWxheS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFqYXkgU2lu
Z2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+DQoNCkRvZXMgdGhpcyBuZWVkIGEgZml4ZXMg
dGFnPw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAw
L3NwaS5jIHwgNiArKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWlj
cm9jaGlwL3dpbGMxMDAwL3NwaS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dp
bGMxMDAwL3NwaS5jDQo+IGluZGV4IDE4NDIwZTk1NDQwMi4uMmFlOGRkMzQxMWFjIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc3BpLmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NwaS5jDQo+IEBA
IC0xOTEsMTEgKzE5MSwxMSBAQCBzdGF0aWMgdm9pZCB3aWxjX3dsYW5fcG93ZXIoc3RydWN0IHdp
bGMgKndpbGMsIGJvb2wgb24pDQo+ICAJCS8qIGFzc2VydCBFTkFCTEU6ICovDQo+ICAJCWdwaW9k
X3NldF92YWx1ZShncGlvcy0+ZW5hYmxlLCAxKTsNCj4gIAkJbWRlbGF5KDUpOw0KPiAtCQkvKiBk
ZWFzc2VydCBSRVNFVDogKi8NCj4gLQkJZ3Bpb2Rfc2V0X3ZhbHVlKGdwaW9zLT5yZXNldCwgMCk7
DQo+IC0JfSBlbHNlIHsNCj4gIAkJLyogYXNzZXJ0IFJFU0VUOiAqLw0KPiAgCQlncGlvZF9zZXRf
dmFsdWUoZ3Bpb3MtPnJlc2V0LCAxKTsNCj4gKwl9IGVsc2Ugew0KPiArCQkvKiBkZWFzc2VydCBS
RVNFVDogKi8NCj4gKwkJZ3Bpb2Rfc2V0X3ZhbHVlKGdwaW9zLT5yZXNldCwgMCk7DQo+ICAJCS8q
IGRlYXNzZXJ0IEVOQUJMRTogKi8NCj4gIAkJZ3Bpb2Rfc2V0X3ZhbHVlKGdwaW9zLT5lbmFibGUs
IDApOw0KPiAgCX0NCg0K
