Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A982322F81
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhBWRVC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 12:21:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48899 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbhBWRVA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 12:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614100859; x=1645636859;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=p++HYq48/hykOBUZmOTM/B2ceqiyFSokKHm4VaqIaXA=;
  b=QVhS/pEgHUXW3CxvtqzhUTe29l7pZzJq661flXOZUlADai0w+yvSkFun
   2t0NZmKGisCE9o/VHpV+UsIb3ybIt5vBuWK0q2MDv8xszOC1YxCYD0sno
   wL3HvCt6tcFlbOOCMB93/D6qPinDE0zcPUQ5JSuEprpMdtdpZ9mTJX9zH
   y5a83nj9P5UWUZq9rP0jBbaiu/UkUHjOww5txLkX63/8sKLYL/DHVxh6q
   mapbTMTY2cFRN/Qo0QF+Ba3EG8k83ZjR38BXVtbmImrq/K30+ytkomji1
   BTVyDP/S5bn8DgWfkXamxfGDu/At/+J8bS6N1cyMEUv5T800kCc1Z++mS
   Q==;
IronPort-SDR: LgGXx/Z4dIMp0C345q+mXvO86RopfVKXtYc3gbPangIgrFooVTCI88uGPF9AiVP02QaKoYqYo8
 yAfuIX1LIbr+uCjTA6cPkRIbyDb7WusHAKyIulkKadFVy6TFsiVjxIx5llGXQmUQsDXJZ/K2qu
 Ql+rDznZLCsF6H58u+At/MD+jZ/FoYEmwGRO73lLeytXjKPlFJe6awEIzdhiS+B6xEAygk4LdM
 6BDGQz9p6dwoCIp/9n37AAQynObaLGrtygcW5n4p7H/HHUKrRzJL0vFlduOkWZnSJbQCAU+aXd
 +6w=
X-IronPort-AV: E=Sophos;i="5.81,200,1610434800"; 
   d="scan'208";a="45176277"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Feb 2021 10:19:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 10:19:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 23 Feb 2021 10:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0LwdkU32Nx2EAwsf1COhGi30E6wKBjeGsVAO5rsd68a4DWMuDlRo+z0rep1o0zdlj/A2trUEi3Nmj9COgJYMNingtYJ0WQENqbLr8FYzmaINcSd16lotdjOfi451I+mrt1rwm1wYbMmWPSQoO76JqGskLv2nYV8dmsotMRe9yX8YsmO9PNtdw4vd6yoXX5RTMJFITsZd77iIUFJE9kWt2kGKN0EkbveDL5n5CYTSIWRyctSqySPEhFIUibbFsGb4f9AW/eH1JUrEgzxdhyYY2ebFtqdJuoyHNGRw/NeDMumwjB4R0Dtxmb1BfKxu+/tRD5JQRZcx1AR9ksNNOMT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p++HYq48/hykOBUZmOTM/B2ceqiyFSokKHm4VaqIaXA=;
 b=IigCa5Jc8eSlUdLwhKHLtAFOicF4FgJoMEY+amoMorUWBqALpvSARu85R2HsfliadcDFbYnvAqOV41gY/5igo50cXrK96quai7BTVxsQaW46ZYfMT8v3DkOtEs1suX2y2iIGdLBKsv05QS7BVUQObLnMopaPlD4CEB+Kw5u7+odnYGCCkAAVXADH6bBtaOxOBpLeMgKtow324j9Sg8BsO8QbFsy6c3bAV1QdK+pvHoQuus5x2bJXd2q2RExxZjD9COAljLAlhgwWzuAcE83idAJbWgewzg+/nWvS8LeHDUN6CnSQOA/IUDoPXUUXBgc9YYau37Vip314Tf3oWLv7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p++HYq48/hykOBUZmOTM/B2ceqiyFSokKHm4VaqIaXA=;
 b=eYF4yPL3aq7hEIlexoeYsFV735yv/oVNW0PFfXn5EphOlZwWeExz+2sbXjlpqyNY6QtlmL3HAwRLE0P8yjcAIMTf2CZ2xUHHyUVuZfqX3x4WIoA1SA4TXcDLFJIwWP2SXkCpZWTD7XgjCuZUxMo8r60n/ZWLcw34ioVU/9YYP/Y=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3174.namprd11.prod.outlook.com (2603:10b6:a03:76::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Tue, 23 Feb
 2021 17:19:41 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.034; Tue, 23 Feb 2021
 17:19:41 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <davidm@egauge.net>, <linux-wireless@vger.kernel.org>
Subject: Re: wilc1000 driver
Thread-Topic: wilc1000 driver
Thread-Index: AQHXCLDudY08vai/x0+sLM30/GJrVapj8fQAgAEI8oCAAPQKAIAAD9EA
Date:   Tue, 23 Feb 2021 17:19:41 +0000
Message-ID: <b7c1b271-993b-064e-3c2a-74302744edd8@microchip.com>
References: <e8ed97f214f6087b7ac59298c8efe2d1144f7d55.camel@egauge.net>
 <eb6c6b39-f168-7237-d220-585f99532fd9@microchip.com>
 <f3e0540462ed8bcc59787f71e3b1b258945a6142.camel@egauge.net>
 <5fc9c8ad5d93e2172f03515f8275851af285a895.camel@egauge.net>
In-Reply-To: <5fc9c8ad5d93e2172f03515f8275851af285a895.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: egauge.net; dkim=none (message not signed)
 header.d=none;egauge.net; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [106.51.111.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd5624ae-d1d8-4343-4a70-08d8d81f34f7
x-ms-traffictypediagnostic: BYAPR11MB3174:
x-microsoft-antispam-prvs: <BYAPR11MB317494474E108C07543AF2DCE3809@BYAPR11MB3174.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzNnLflBcCqGtDCC7oxhhpY8kuDacjeFHAuE9r2wBxkMHtR7KZU5bVc+ecPVmVuVLHG3PZbeJS5ueEKz/XO0J35Iz26n/O1I2LEAkU+u+r6OU6WAoyq7SLfRANDK6h9vyFz+cJRqDywMbVE1/YQN8COfoQG50WDB6d4mMwQZ8Ktvc95afOYaXAkBLhOZK3uXAufOSlexwVb4rsY0haJLn2OQjKf4uSXlWjSp67oSLFkHseLhVB/mykI43EcsHbMaySUACrM5EOKxVcUytcrAHZpdQooza6Sx1aPZn1ah1LMcxIMV5Owt/AQBufVkBcrHMVsXebRnQk0TE0kP1dp8Zdxrnvb2Huj0XLhSJdMv6WxzZjCDbt7ALXBgQNDM+BFdh8dBNqtEuvcXedqF7RGVqy665sVcqAAdjvVFGUc07tQh8bKaMLsnOA2q5jAHlxyackSY0mtbkOikBAvZssDnhNSIOetZ1hVDOXYzCwSDKXSUyK+9qUW2TvRUD72/fhvN1zTssE3eaCVHp9W702MEQygOxfp6N5pjTfddpCVHkngxebw7aUvYopiy0GMFX/5fPPDzRwXgktrlr8LWA0ZngE6urFfemW0EGl/tbM5s1h8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(396003)(346002)(2616005)(66446008)(64756008)(31696002)(71200400001)(66556008)(86362001)(91956017)(8936002)(55236004)(5660300002)(6512007)(26005)(478600001)(36756003)(186003)(53546011)(7116003)(316002)(6506007)(76116006)(31686004)(110136005)(2906002)(83380400001)(8676002)(6486002)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cUNGL25adkJNajdzTWZDZGNybVRSbkdCK2Zvbm9HSHJoRy9TZE9EbkpUakF5?=
 =?utf-8?B?WGRMUUx4Smx4VGFWbS83QXZ0UnNLYUtGTUFKdjcwWUVkZ2VacW1pMW5sNlhj?=
 =?utf-8?B?MERrSkNsZ242U3NsYWYvVTQxZ1BGY1ltZTFjM001RWg1cFdBWkR6NXpwV0ls?=
 =?utf-8?B?NGdrbDk4UmhIUXVKMHcxUDVwcHpCakhtaGM3eGxVd2FXUmV1MWQxSzVkQjRW?=
 =?utf-8?B?aTZOUXNpRU14ZlVVK3c0ajkvdHRVTEhPb1V0TVJHa2NYdnI3a1I4ck5oeW1V?=
 =?utf-8?B?R1haSklEeDVQTUlVaHRzM2hLVE5NZ2RNVFB0YXVZOHg4S2M4UnRHK2UvTWpi?=
 =?utf-8?B?VTVOWFVkN3FuK3NRTDRzdE41M1RrL1BjTlVqYUQvY0xFVTNJYjAxU29aSTh6?=
 =?utf-8?B?MkZ1VXVKaXM0aDJCeTJGRStJaWVxaFZlZmVEczhOMjhpVmlwaXdOMUE2U1hx?=
 =?utf-8?B?bkVkV2hEUkpqQzJzanNJMlBEYjdXdFhzWkVFMkhneGdLMXZqUTVXTUJiMnpZ?=
 =?utf-8?B?eVB2V0l3ZGdtc2tCT01ycmhLcHc0M1VFMVlZcHRNVEpYczZIeWRJNkdGcmdh?=
 =?utf-8?B?L0E4Ly8ybVNzbGUyNDNFbkEwTlZ2V2JzQkNSQWw1ck0rQUdFN0dzVXBwaDI4?=
 =?utf-8?B?QWlocXZkSDVaY2FrY05INUZRdG5LdklFaU9vTm9kMzR4TWN4VjZvUi95NDhL?=
 =?utf-8?B?WUY2MWFtWll6VGxLTTNIR205bWlEZjNBRXpzSENSTVk4cDBITE5lVDB6bDBi?=
 =?utf-8?B?a296ekk1a3I5amVVS29MUCt4QzJnNDVLcDFxT0RMNjZiSHJDakhKVFJLWGpH?=
 =?utf-8?B?bmFjZ2psazlLVmhBYmUvOTdpTms0aDNQRmdraW84SVM3RmJNL3ROMnBaNXp6?=
 =?utf-8?B?SGVuMDZjL25XOVdSbFRSTzdOUW9LK1BkdnM5SDh3OW5nbmNGZ1UzNE1pYlk3?=
 =?utf-8?B?WVBHTXBEbXBXUWIzVUhlV2tXUXdlcHIxTXJwV3BpYlc2L0Z2cGY4V20rOVRm?=
 =?utf-8?B?YzFzMnhzbkdVUHd0Unp2T01MSjYrQWVvVmx1SE15UUh2cTMybUswU1UyOW1t?=
 =?utf-8?B?UXl6Ylhxd3Y4UWdHL3FWTnJmS2dGQXhCSUl5R2xGZ1IyM0hHSWg1djlqZ0JW?=
 =?utf-8?B?enZTWXFwSDFoRGlWWGxNU2ZwNmk1YkpYTi90S3BqcTBnMjlNb3BoQXdyOW5Y?=
 =?utf-8?B?a1cweHRybU1RUVZlWi9iR3B0Sm9HNDdTNDBqNkRhSmJGMmZ0UjM3S3FHaVpu?=
 =?utf-8?B?QnlCWjVhYzlMTk1WWGgxSnpuYWlYb09XZlV3VjU4eXJEM2krejRqMy8rZzEz?=
 =?utf-8?B?MjBXNGhXSElka1RvNHE2TzBMeFBIYk1CU21wZzJQVkZ3M25TYW13alBBU0JD?=
 =?utf-8?B?cCs2ODUveGNQekpZWFU3NnRORk02TUcrRUdBWGN0bUNpMldHSkR6NGNsMWV5?=
 =?utf-8?B?K0g3UGpuZFpZR1N1NGVHRmRtWWo3VmIyQ1VPZk1Nd0E2N0x1ZWNCb3dCbyt5?=
 =?utf-8?B?UEdaWGE5MGpMbmI0Rmh6eVBoU2xqekx2bXl1aWsvV21OSmt5RHFpbDA2czFh?=
 =?utf-8?B?WlNYdjhmRmg3NlE0NEdBRHk3aTlhYjlwY1VWSUNCN2VlcXFGa1p2Sk5BUHlX?=
 =?utf-8?B?c282bUZhR1h3aVFySFNScEJHbDhmOWRnQUtMSkdtdytxelZBWldVRXkzUnp4?=
 =?utf-8?B?eHRySEQ1OHRwQnhONUxpMVNtRzFSSTU0aTlnWE9ITG8vejd4WEJUWHFtTmF2?=
 =?utf-8?Q?GhcuHeSjR+v6Lr87Ps=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <509C2A96C1178D4981A2E99FC9F73143@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5624ae-d1d8-4343-4a70-08d8d81f34f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 17:19:41.6704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekb9+ZGmcArgLlcS73AcJbEYKAlK70o+LyD1U42ClZp1ywwn2la/7j5QSyG/1ykCwkRkyaDqM2SbJKOYdy2ZJSqzr83wv3Jg2hiaZbX8hEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3174
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIDIzLzAyLzIxIDk6NTMgcG0sIERhdmlkIE1vc2Jlcmdlci1UYW5nIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9LLCB0aGUg
cHJvYmxlbSBiZWxvdyBpcyBjYXVzZWQgYnkgd2lsY19zZXRfcG93ZXJfbWdtdCgpLiAgSWYgSSBj
aGFuZ2UNCj4gdGhhdCBmdW5jdGlvbiBpbnRvIGEgbm8tb3AsIHRoZSBkcml2ZXIgYWN0dWFsbHkg
d29ya3MhICBEb2VzIHRoaXMgbWFrZQ0KPiBhbnkgc2Vuc2UgdG8geW91PyAgRnJvbSB3aGF0IEkg
c2F3IHNvIGZhciwgaXQgbG9va3MgbGlrZSByZWxldmFudCBjb2RlDQo+IGlzIHByZXR0eSBtdWNo
IGlkZW50aWNhbCB0byB0aGUgb25lIGluIHRoZSBsaW51eC1hdDkxIHRyZWUgYW5kIHRoYXQgb25l
DQo+IHdvcmtzIGZpbmUuDQo+IA0KDQpBcyBJIHVuZGVyc3RhbmQgeW91IGFyZSB0ZXN0aW5nIHdp
dGggZGVmYXVsdCBwb3dlcnNhdmUgbW9kZSBlbmFibGVkLiBPbmUNCmFwcHJvYWNoIGNvdWxkIGJl
IHRvIGRpc2FibGUgdGhlIGRlZmF1bHQgcG93ZXJzYXZlIG1vZGUgYnkgY29tcGlsaW5nDQp3aXRo
IENGRzgwMjExX0RFRkFVTFRfUFMgZGlzYWJsZWQuIFdoZW4gaXRzIGRpc2FibGVkLCAuc2V0X3Bv
d2VyX21nbXQgY2INCmlzIGNhbGxlZCB3aXRoIHBvd2Vyc2F2ZSBkaXNhYmxlLg0KSWYgdGhlIHBv
d2Vyc2F2ZSBtb2RlIGlzIGVuYWJsZWQsIHRoZSBjaGlwIG5lZWQgdG8gYmUgd2FrZXVwIGJ5DQpm
b2xsb3dpbmcgdGhlIHdha2V1cCBzZXF1ZW5jZS4gV2UgbmVlZCB0byBicmluZyBpbiBjaGlwX3dh
a2UoKSBBUEkNCmNoYW5nZXMsIHRvIHNldCByZWdpc3RlcnMgc3BlY2lmaWMgZm9yIFdJTEMxMDAw
LiBJIGhhdmUgcGxhbnMgdG8gcG9ydA0KdGhlc2UgY2hhbmdlcyB0byBzdXBwb3J0IFBTTSBtb2Rl
IGJ1dCBpdCB3aWxsIHRha2UgZmV3IHdlZWtzLg0KDQpSZWdhcmRzLA0KQWpheQ0KDQoNCj4gICAt
LWRhdmlkDQo+IA0KPiANCj4gT24gTW9uLCAyMDIxLTAyLTIyIGF0IDE4OjQ5IC0wNzAwLCBEYXZp
ZCBNb3NiZXJnZXItVGFuZyB3cm90ZToNCj4+DQo+PiBOb3cgdGhlIGRyaXZlciBsb2FkcyB0aGUg
ZmlybXdhcmUgYW5kIGdlbmVyYWxseSBzZWVtcyB0byBiZSBoYXBweS4NCj4+IEhvd2V2ZXIsIGFz
IHNvb24gYXMgYSBwYWNrZXQgaXMgcmVjZWl2ZWQsIHRoaW5ncyBnbyBhd3J5LiAgSSdtIHNlZWlu
Zw0KPj4gdGhpczoNCj4+DQo+PiBXSUxDX1NQSSBzcGkxLjAgd2xhbjA6IENoaXBJRCBbMTAwM2Ew
XSBsb2FkaW5nIGZpcm13YXJlDQo+PiBbYXRtZWwvd2lsYzEwMDBfd2lmaV9maXJtd2FyZS0xLmJp
bl0NCj4+IFdJTENfU1BJIHNwaTEuMDogRmFpbGVkIGNtZCByZXNwb25zZSwgY21kIChjYSksIHJl
c3AgKDA5KQ0KPj4NCj4+IE9uIHRoZSBTUEkgYnVzLCBJIHNlZSB0aGVzZSBjb21tYW5kczoNCj4+
DQo+PiAgTU9TSTogMHhDOCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgzOCAoRE1BX0VYVF9S
RUFEIGFkZHIgMCBzaXplIDU2KQ0KPj4gIE1JU086IDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAw
eDAwIDB4MDAgMHhDOCAweDg4IChjb21tYW5kIHJlc3BvbnNlKQ0KPj4gIC0tLS0tDQo+PiAgTU9T
STogMHgwMA0KPj4gIE1JU086IDB4RjMgKERBVEEgaGVhZGVyLCBsYXN0IHBhY2tldCBpbiB0aGlz
IHRyYW5zYWN0aW9uKQ0KPj4gIC0tLS0tDQo+PiAgTU9TSTogMHgwMCo1Ng0KPj4gIE1JU086ICAg
eHgqNTYgKDU2IGRhdGEgYnl0ZXMgdGhhdCBtYXkgYmUgYSBsZWdpdGltYXRlIHBhY2tldCkNCj4+
DQo+PiBTbyBmYXIgc28gZ29vZC4gIEkgZG9uJ3Qga25vdyBpZiB0aGlzIG1hdHRlcnMsIGJ1dCB0
aGUgbGFzdCA4IGJ5dGVzIG9mDQo+PiBkYXRhIGFsbCBjb250YWluIDB4MDkuDQo+Pg0KPj4gVGhl
IHByb2JsZW0gZnJvbSB0aGVuIG9uIGlzIHRoYXQgbm8gbWF0dGVyIHdoYXQgY29tbWFuZCBpcyBz
ZW50LCB0aGUNCj4+IGNoaXAgYWx3YXlzIHJldHVybnMgb25seSAweDA5IGJ5dGVzLiAgRm9yIGV4
YW1wbGUsIHRoZSBmaXJzdCBjb21tYW5kDQo+PiBhZnRlciB0aGUgRE1BIHJlYWQgaXM6DQo+Pg0K
Pj4gIE1PU0k6IDB4Y2EgMHgwMCAweDEwIDB4NmMgKFNJTkdMRV9SRUFEKQ0KPj4NCj4+IGJ1dCB0
aGUgTUlTTyBsaW5lIG9ubHkgcmV0dXJucyAweDA5LCBoZW5jZSB0aGUgYWJvdmUgIkZhaWxlZCBj
bWQNCj4+IHJlc3BvbnNlIiBlcnJvci4NCj4+DQo+PiBJdCdzIGFzIGlmIHRoZSBjaGlwIHdhbnRz
IHRvIHNlbmQgbXVjaCBtb3JlIHRoYW4gNTYgZGF0YSBieXRlcy4gIFRoZQ0KPj4gYnl0ZS1vcmRl
ciBmb3IgdGhlIERNQSBzaXplIG1hdGNoZXMgdGhhdCBvZiB0aGUgd29ya2luZyBkcml2ZXIgdGhv
dWdoLA0KPj4gc28gbWF5YmUgdGhhdCdzIG5vdCBpdC4NCj4gDQo+IA0KPiANCg==
