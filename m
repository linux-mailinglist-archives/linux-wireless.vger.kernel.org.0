Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655AD46FD55
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhLJJI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:08:57 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15924 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhLJJI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639127122; x=1670663122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AGflfHeHTc9YtOG/+cfSmxnGD7ppWnBEc2eTwcuerm8=;
  b=o2OCOaldpDnMTiaiy0aLC21KKV9KAYsIBheYWM4kUOI0d94YS+GYOXce
   7ZmEY8fNNCmwalHtv+kTcO1qE56f0CHTM2CBd/GMrFZkf4CBEgeyojdFZ
   ghCFX9A8+UIdphyII0zWaSE0Ivxosi65Vw1khg1iNZmuXqSmKRwIrTk16
   j1SQphpwXdFKfjxnebe07U3l3FoL+SR96bLnodzgGFloS8WS1SJ/bjwEj
   f0DnQtwidBiCrVSu+eoQWrWtnZ61bNrFw5pZn9zv2wFG3e64PlJM7BKUA
   ARqVVEd/ivsaYPnNPKwEsw1itucbPVe4zh3RwvriY3LyU3fpbz45av+GL
   w==;
IronPort-SDR: kikKpaNqwk+O1WGxoeKd3/MhJsihk1F/aJqHLf+c4yGgSnnIfHF7nTvu72QHHE7uvrazYl7/jF
 MhxWeDlW+oZz2LCIEgAL/V6Bx5SNUeMI1xOllU5pTyT1hUVHSJWYcIGhGspmm0xOO5pcFuy54y
 p7BmBlTOcTAKQdiuzILGP9jxWMZD4tO+KEapWD7jPobAQ4ykWpDqIzBsEyWEC89lwQf1J7ujCJ
 Q51/AioVJBGfHMi/tM/IKjvnqEboV5Lx1vRBy8bNVgpNey8uutyfg6d3KOzBs6ty+K1qgeqOy4
 N8SggYk9/F/BJeV/ZVyB48Rf
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="146211653"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2021 02:05:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Dec 2021 02:05:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 02:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpQ5/2sWR6NnV1JbWliJ8fAiBL4hSkB6ynVGj8wzvau2ihuwCLV5O4AeoNfrQF7uD3CbdRVKY4cXgJVPrlmwW7klAgRbVvKKAi0yKTAVaZ3wnCVH0TmfXzvxIPM7TZhAgpz/frOL85iaZC94vHbvemkD9GgfLpIAxAp9JDSJ1oQtGch2pisYPXS93upE4J2hls90jXghBBJTiO5uXSKza62/F1EjxXBTGdrj6ynA/jgRd3vfYCsyAKznLfv1LRqyKk4xt/KV7KO9LJkVazhVKth3qhHxIHLTuwsesrlGEaW088eNppsj7ePn4IyGPuHY7ylPt7+pipvoUOmpFPNV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGflfHeHTc9YtOG/+cfSmxnGD7ppWnBEc2eTwcuerm8=;
 b=UeH/QVTuctGaPrsObTHev7SAVhcHqAbHd/GaFF4abGPSAfBugqGix7Tqe7uMldQAywz+I9Sp9j9t1jsYQarZgfOeU55caIrZe//G1MKPVM13Q0+upTL3oWG9dUTicTGXydc/V8AOXHuXZHTKJDYjF4Xn1dWyhIJKDVZbsXKoDbGjBVb4fDk1fGLMc58OOu/88L4+dcwb8OCgznN4jUMR7ARcqjHVX8P2Bbq8M1v6H+F+PIcG28DEzl1+h5TYBfc+n0g9jMvz2gRQdYgRmaVRKyJ8Irezxmw/NhkQNrSqjjp1MQlxAFH00RHiQlDrcPBB8aK88rmWkxS0bVJY8Ro5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGflfHeHTc9YtOG/+cfSmxnGD7ppWnBEc2eTwcuerm8=;
 b=sJpX7HXX86BzF28/MpyzMqNR+6qVc5whD6Yb5DuKlyp1cOouiFNhU8HqLJz9g2h56/UNf3sVuT9ntGikWpbg5PbEmls0RURXty9c8CsAUcqvnEIKKddgaEd3GyIn20kfRj4yPXJ8wI/Kmhh6tM3T+sQUbgywzo1QzjeYBD+qQ+E=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3685.namprd11.prod.outlook.com (2603:10b6:a03:fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 09:05:16 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b481:2fde:536c:20a0]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b481:2fde:536c:20a0%5]) with mapi id 15.20.4755.023; Fri, 10 Dec 2021
 09:05:16 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>
CC:     <Claudiu.Beznea@microchip.com>, <linux-wireless@vger.kernel.org>
Subject: Re: RFC: wilc1000 module parameter to disable chip sleep
Thread-Topic: RFC: wilc1000 module parameter to disable chip sleep
Thread-Index: AQHX7GR0iVpWqOmSgEO6XUQarQMP+qwp4z4AgACVlwCAAA+vAIAA6MsA
Date:   Fri, 10 Dec 2021 09:05:16 +0000
Message-ID: <ac53bc89-485c-6f3d-7fbc-38ee8870a713@microchip.com>
References: <0baed35e98144bc7e29681264caf954b659cd481.camel@egauge.net>
 <4bf158ac-18d0-6feb-fbef-dc0739d74487@microchip.com>
 <a03e133e46ff305dbad796913b79c994c91581d5.camel@egauge.net>
 <efee7360e8be88d58251e38c848637c8163bdf19.camel@egauge.net>
In-Reply-To: <efee7360e8be88d58251e38c848637c8163bdf19.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e90a554a-3a57-438c-b191-08d9bbbc2f00
x-ms-traffictypediagnostic: BYAPR11MB3685:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3685F57D9FC0F3A8DFC049C4E3719@BYAPR11MB3685.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+3Aot4xdvCkH1jUSLvYek6XQQbZohuSZyYvOvsQpNT9D0nXrKHzh1L9K/kmj30yKRyDQY2E/lU9RMlyQ25mQwrKUyjVlygSviAGnRm1EiJ0/04DQgOBMa0D5Rag5ivhQ1o9GMuO1GUxH+l05M+oU28Yo+y+pufmoZRlT6DiwVF+/EuCTK9jobRE/Q3jjqHlrzhazbZwHIC+LRgAOGKx8tcqo+9j7QiTzEzlhU9vFogc5M+tLcuBLxHkTKDNKfk3MuY9qGs6xZzUb2eCjg550Ga8YRAllG4wNr7N5VdyLBPpu1aLSQggz1IEV8ez6+rXutQF/Bz1IG6jC9T33JsOOBeIk9oWkXJ9RqGMECDLAkR2Q07jiZDvHZ8PQxsWNJcxszGdsclEUCPSGSBRER3jrCWalWcdmuP7RAhDBHTGKs8ZWsP0wM+tsV4waiZ7j9Y9NmI6ebiYsq7/9N7ldxNi1Pn3OxMF/d8ln9y5ROcAfjF3+LRhIWcub6O5w+Umdo6bE7U5Af3nigyn5HZGqTv05BrkBZk4ZVyEdoV3h/n8qinat+jHPfnN3Mm3neK5W/dF33drB3B9HFLqehr+YcAtOdEWSf7zOWBTN/iF1BAxbKza1T4ZYM4HrkFlpV9LYsXtTxZhs1BrZZfDGMoNULCIQfXHoLwryRHcd0LPew7me0Zc388q8xlbo89NbtEccGUqYsdrKqzcSc5e608ECuQmxYAvf53alEq3Uc42oFiktVX5ulwnBC74K5FKoiJpXRVl2ZQgbpm0p66WqrOhAkllwXA8zpnjfuGyOiBZ4DiMPTG+flJqk28UQuvIwkWY2zOYrQY4LBUlGmKfhwnQ5Y3xAMBXfcIWwDCoAhyNfzpo6h4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(2906002)(316002)(6916009)(186003)(8676002)(4326008)(71200400001)(966005)(508600001)(26005)(122000001)(55236004)(38100700002)(6506007)(53546011)(36756003)(8936002)(31686004)(6512007)(2616005)(83380400001)(86362001)(38070700005)(6486002)(76116006)(31696002)(64756008)(5660300002)(66476007)(91956017)(66556008)(66446008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWgvamMxaE9NSGd6MDhxdFFVOWFZU3l4M0FqNGNOcmMrUnFTNVg1eGVxYng4?=
 =?utf-8?B?b01PWlIrVkh3ZURvenFmNEhhdE1HYmhhZmptS1pLa0E4QjF0MklXdjBCWFJ0?=
 =?utf-8?B?ekFkLzRkcm9jbnZUMHoycE5sOGt1Q1VIWlZqNHhNQWdmNkFtZGs4cWdBUGhV?=
 =?utf-8?B?QVhMaWUrTnRxdkdXS0V1VU5JQTlQb0RpVnFhak41anRveVhxZkVpUEtZZUN5?=
 =?utf-8?B?WFo3VThqN2gvNzRLMUtQaERwczFUeHdZRkpzN3J3L3poS2k2ZjVFNDNHeS80?=
 =?utf-8?B?L2JiTWJJNzIrbXpsckxweForeVhLTVlUaWE0Z2xrVVQrNkd1U0VmTy91R1VF?=
 =?utf-8?B?c091RE5wekR3dkZZN2RjQkErZWhRYzgrcWJReFovMmVYd09WYVZUTldEN25M?=
 =?utf-8?B?Yk1uMStBTE1HMElxbEJTblRVN3h5SmVLaDFaTVdVYXNnb2taQjlhakJsdk95?=
 =?utf-8?B?dVJHUXdkWG5hSzJuU1UxWXlteUZuaE9idzd4SXNBczVBV3lFYkNBbWJYT2Fp?=
 =?utf-8?B?aVJWVkxETXV2RWE5VEV4VE1xeDh1YWtLOUc2M2dQZzJYSmhQd0F3YUxDMG16?=
 =?utf-8?B?ZU83Zm80THZBam5MaWJlVkJLVllyREsvVHdIb3NkcHNlenRkVzY2dHR3cXNo?=
 =?utf-8?B?amdROWQ2VDVKOENrbVk4aml6QjZGdFlWV1g1Z0tMS0R6ME5QTmxrL2l4OWNL?=
 =?utf-8?B?c3lSQURXbzVOcFA5cUFBdm1DaXNtTFdPMGljbjRXYzRzc2V5cHZFM01NaytB?=
 =?utf-8?B?N0szL3RwdWwrbXN0NTJjVTV4RCtQZ2RHN2I4M3V0UlU2ZDd4MkdaUThFYXhx?=
 =?utf-8?B?czZVdzQ5V2tDY3RHYzhoSDl5b1ZMYUlYQUl2bVpwZWE3MkRLbGlDYzdVMkNI?=
 =?utf-8?B?MHNra1d2ZmViSVR1OXFCM3pURjhKMU1kaFg4Q0p5aDAxNTF5V0FXYUxvOUlh?=
 =?utf-8?B?VllmK3NyWXN3d1NjWHJDVExLY2xQVURhNHNjY2hKT2s1NHdQaDdJR3JHei9v?=
 =?utf-8?B?ejArWkx2TnR4YzlMMHQzbXRoTU9WRDh6OHhrc3UzcWJPbERGc1lIbWs0NE1x?=
 =?utf-8?B?dVVFbXRNTEhYMy96bnVNQ1p1ZUU3RDE4OWxYY0k5UDhaQ0FUQi9Tdm9YQ204?=
 =?utf-8?B?MEswWmhyMkRlSDdndkZlRENFVk1oMXQvRW80VFozREtqekJPNHBiOXYyaHR6?=
 =?utf-8?B?S1BzZEdoNjYzRFkvc1YzSklHWTJmamRDV2xsMktLK3lLWU1TUUdDNTEra25W?=
 =?utf-8?B?bVZOYVBpY2lleHMzeUsvS0IwOTk1TXh5L29maWVtejJDK0RrOEdBUWtQeDRT?=
 =?utf-8?B?OXlsaVk1RStTamF1VHVZZytEVWpaaWV6ajhSN2ZseFdDR2hhQ0NRTHIwV3Fz?=
 =?utf-8?B?ODVOc2dXYWZ4clFDREJvWTNCZ3pWR01KTnJsbEwvWVBXeC9XWmx5ckV5MUJt?=
 =?utf-8?B?ZmMwN055d0NYbU5GZmlCYS90WU9jNFZkVStaYzVXdTdDRmNHbENKVHB5Rms5?=
 =?utf-8?B?U1hHZ1hEOFRwRjlWckFEVzZ6NUZyL281Um1keUE1Ui9sRkJQSlBkOHNuNVd1?=
 =?utf-8?B?RTdvaDFHQkplT24vVm9WVWxiNDBUckFqUlBpcndwUWNNNVg3RTJaS0cvcTV2?=
 =?utf-8?B?NkMra2NGNkRLcUlXOE1sZmtwNkZnbldkTmZYYklDL3ZScHdmay8vbmVNTWM4?=
 =?utf-8?B?bWtpbUlCeGxRazljblYyR0V5YUQ2RzNPdUtXUVg5RGhpQTVtN09JSjBPZEpq?=
 =?utf-8?B?a2hnYlNyUVlLTStIUUJ3dzh3WWozT3VQaTRkcVZyMUVuWjJ3a1FkbitpQUo1?=
 =?utf-8?B?SVhMREh1cWdPNCtSSmxwWEovMVBrdW1hTEhQZ3FKUW1CQm9JOE0zVmdMbTFk?=
 =?utf-8?B?cHptUG1NdFZKNDZCQU9qS2g2c1ppRWcxM3JMdGp2TDRsckhRR1ExV0dQVWM5?=
 =?utf-8?B?UG8zVlhZcTQxOXp3QVpjY3p6ZjNQenE4dDg3ZEVqT3NZVkNMUkVEOXE5bDdy?=
 =?utf-8?B?VkFxSmdMaS9SOUxoZVFYTjFhdm1oWit2WCtIVkVsNlBFOWYzMjJ2R3c2Q0VT?=
 =?utf-8?B?eGpWbXJzTDFMZ1luOWRvbzZrRnJ3OC9JM3RPdmg2S1FyN2NYZFJnYTNRRUgz?=
 =?utf-8?B?bCs3YjRBRnQxVE1JVHJBb2VQRVgvOSt6bnkwYjFjNldVL1IyS1Vwa0xYMTB1?=
 =?utf-8?B?SlFQSG5YanlFM1ZLcnVsbmlVQm1QZldvNzBoYnlzOVdEZ0JtZHBXZHpQTmM1?=
 =?utf-8?B?Z0tUbkZVZm02SEdLZjdHdDlJRnZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <638111EBC0C3ED4E9883B3B90D5A9FAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90a554a-3a57-438c-b191-08d9bbbc2f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 09:05:16.5450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOsBEGmxBBS4bAg2cdpPmdvBPLVcygs7eL+pqoNzZjbBxQb/C60l75sYdhIs6xa3LgPMGR4N6DYm9qNBEKKkigFWhfEfJfkYhf0dju2/7/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3685
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gMTAvMTIvMjEgMDA6NDIsIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gT24gVGh1LCAyMDIxLTEyLTA5IGF0IDEx
OjE1IC0wNzAwLCBEYXZpZCBNb3NiZXJnZXItVGFuZyB3cm90ZToNCj4NCj4+PiBEaWQgeW91IHRl
c3QgYnkgZW5hYmxpbmcgdGhlIHBvd2VyLXNhdmUgbW9kZSB3aXRoICJ3cGFfc3VwcGxpY2FudCIg
b3INCj4+PiB1c2luZyAiaXciIGNvbW1hbmQuIEZvciBwb3dlciBjb25zdW1wdGlvbiBtZWFzdXJl
bWVudCwgcGxlYXNlIHRyeSBieQ0KPj4+IGRpc2FibGluZyB0aGUgUFNNIG1vZGUuDQo+PiBObywg
SSBoYXZlIG5vdCBwbGF5ZWQgd2l0aCBwb3dlci1zYXZpbmcgbW9kZS4gIFRoZXJlIGFyZSBzb21l
IGRpc2NvbmNlcnRpbmcNCj4+IG1lc3NhZ2VzIHdoZW4gdHVybmluZyBQU00gb246DQo+Pg0KPj4g
WyAxNzY0LjA3MDM3NV0gd2lsYzEwMDBfc3BpIHNwaTEuMDogRmFpbGVkIGNtZCwgY21kIChjYSks
IHJlc3AgKDAwKQ0KPj4gWyAxNzY0LjA3NjQwM10gd2lsYzEwMDBfc3BpIHNwaTEuMDogRmFpbGVk
IGNtZCwgcmVhZCByZWcgKDAwMDAxM2Y0KS4uLg0KPiBBcyBmYXIgYXMgSSBjYW4gc2VlLCBjaGlw
X3dha2V1cCgpIGNhbiB0cmlnZ2VyIHRoaXMgbGVnaXRpbWF0ZWx5Og0KPg0KPiAgICAgICAgICAg
ICAgICAgIGRvIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGgtPmhpZl9yZWFkX3JlZyh3
aWxjLCBXSUxDX1NQSV9XQUtFVVBfUkVHLCAmcmVnKTsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIGgtPmhpZl93cml0ZV9yZWcod2lsYywgV0lMQ19TUElfV0FLRVVQX1JFRywNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnIHwgV0lMQ19TUElfV0FLRVVQ
X0JJVCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBoLT5oaWZfd3JpdGVfcmVnKHdpbGMs
IFdJTENfU1BJX1dBS0VVUF9SRUcsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJlZyAmIH5XSUxDX1NQSV9XQUtFVVBfQklUKTsNCj4NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgIGRvIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdXNs
ZWVwX3JhbmdlKDIwMDAsIDI1MDApOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB3aWxjX2dldF9jaGlwaWQod2lsYywgdHJ1ZSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICB9IHdoaWxlICh3aWxjX2dldF9jaGlwaWQod2lsYywgdHJ1ZSkgPT0gMCk7DQo+ICAgICAgICAg
ICAgICAgICAgfSB3aGlsZSAod2lsY19nZXRfY2hpcGlkKHdpbGMsIHRydWUpID09IDApOw0KPg0K
PiBBY3R1YWxseSwgdGhlIGFib3ZlIGxvb2tzIHJhdGhlciBncm9zcy4gIHdpbGNfZ2V0X2NoaXAo
KSByZWFkcyBib3RoIFdJTENfQ0hJUElEDQo+IGFuZCBXSUxDX1JGX1JFVklTSU9OX0lEIGFuZCB3
ZSBkbyB0aGlzIGF0IGxlYXN0IHRocmVlIHRpbWVzIGluIGEgcm93IG9uIGVhY2gNCj4gY2hpcF93
YWtldXAoKS4gIFdvdy4gIElzIHRoaXMgcmVhbGx5IG5lY2Vzc2FyeT8NCg0KDQpJIGJlbGlldmUg
eW91IGFyZSB1c2luZyB0aGUgb2xkIGRyaXZlciBjb2RlIHNvIHBsZWFzZSBjaGVjayB3aXRoIGxh
dGVzdCANCmNvZGUuICdjaGlwX3dha2V1cCgpJyB3YXMgY2hhbmdlZCByZWNlbnRseSBzbyBJIGRv
bid0IHRoaW5rIA0KJ3dpbGNfZ2V0X2NoaXBpZCgpJyBjYWxsIGlzIHZhbGlkIGFueW1vcmUgaW5z
aWRlIHRoaXMgQVBJLg0KDQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWljcm9jaGlwL3dpbGMxMDAwP2g9djUuMTUmaWQ9NWJiOWRlOGJjYjE4YzM4ZWEwODlhMjg3Yjc3
OTQ0ZWY4ZWU3MWFiZA0KDQoNCj4gSW4gYW55IGNhc2UsIGZvciBub3csIHRoZSBiZWxvdyBzdXBy
ZXNzZXMgdGhlIGVycm9yIG1lc3NhZ2VzOg0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NwaS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWljcm9jaGlwL3dpbGMxMDAwL3NwaS5jDQo+IGluZGV4IGI3NzgyODQyNDdmNy4uNTE2Nzg3YWE0
YTIzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEw
MDAvc3BpLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAw
L3NwaS5jDQo+IEBAIC00OTgsNyArNDk4LDcgQEAgc3RhdGljIGludCB3aWxjX3NwaV9zaW5nbGVf
cmVhZChzdHJ1Y3Qgd2lsYyAqd2lsYywgdTggY21kLCB1MzIgYWRyLCB2b2lkICpiLA0KPiAgICAg
ICAgICByID0gKHN0cnVjdCB3aWxjX3NwaV9yc3BfZGF0YSAqKSZyYltjbWRfbGVuXTsNCj4gICAg
ICAgICAgaWYgKHItPnJzcF9jbWRfdHlwZSAhPSBjbWQpIHsNCj4gICAgICAgICAgICAgICAgICBp
ZiAoIXNwaV9wcml2LT5wcm9iaW5nX2NyYykNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGV2
X2Vycigmc3BpLT5kZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9kYmcoJnNwaS0+
ZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIGNtZCwgY21k
ICglMDJ4KSwgcmVzcCAoJTAyeClcbiIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNtZCwgci0+cnNwX2NtZF90eXBlKTsNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVJ
TlZBTDsNCj4gQEAgLTc1NCw3ICs3NTQsOCBAQCBzdGF0aWMgaW50IHdpbGNfc3BpX3JlYWRfcmVn
KHN0cnVjdCB3aWxjICp3aWxjLCB1MzIgYWRkciwgdTMyICpkYXRhKQ0KPg0KPiAgICAgICAgICBy
ZXN1bHQgPSB3aWxjX3NwaV9zaW5nbGVfcmVhZCh3aWxjLCBjbWQsIGFkZHIsIGRhdGEsIGNsb2Nr
bGVzcyk7DQo+ICAgICAgICAgIGlmIChyZXN1bHQpIHsNCj4gLSAgICAgICAgICAgICAgIGRldl9l
cnIoJnNwaS0+ZGV2LCAiRmFpbGVkIGNtZCwgcmVhZCByZWcgKCUwOHgpLi4uXG4iLCBhZGRyKTsN
Cj4gKyAgICAgICAgICAgICAgIC8qIFJlZ2lzdGVyIHJlYWRzIG1heSBmYWlsIGxlZ2l0aW1hdGVs
eSwgZS5nLiwgZHVyaW5nIGNoaXBfd2FrZXVwKCkuICovDQo+ICsgICAgICAgICAgICAgICBkZXZf
ZGJnKCZzcGktPmRldiwgIkZhaWxlZCBjbWQsIHJlYWQgcmVnICglMDh4KS4uLlxuIiwgYWRkcik7
DQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIHJlc3VsdDsNCj4gICAgICAgICAgfQ0KPg0KPg0K
PiBNYXliZSBhIHBhcmFtZXRlciBzaG91bGQgYmUgYWRkZWQgdG8gaGlmX3JlYWRfcmVnKCkgdG8g
aW5kaWNhdGUgd2hldGhlciBmYWlsdXJlIGlzIGFuIG9wdGlvbj8NCg0KDQpJIGhhdmUgbm90IG9i
c2VydmVkIHRoZSBmYWlsdXJlIGxvZyBzcGVjaWZpY2FsbHkgZHVyaW5nICdjaGlwX3dha2V1cCcg
DQpidXQgaWYgeW91IHNlZSB0aGVtIG9mdGVuIHRoZW4gd2UgY2FuIGFkZCB0aGUgaW5mb3JtYXRp
b24gaW4gY29tbWVudHMuDQoNCg0KUmVnYXJkcywNCg0KQWpheQ0KDQoNCg==
