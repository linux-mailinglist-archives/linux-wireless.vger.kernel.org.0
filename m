Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3059E6D5625
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 03:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjDDBbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 21:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjDDBbr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 21:31:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB25C30DB
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 18:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680571866; x=1712107866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FIHEDTKMtlagdFb9FM8B9ajNqeZGYEhrMExwrzcW7tU=;
  b=B+kiNC+8mWWxOem37p+UN+T9HpdiZi6dNgvS4yOaW0oD8CQJhQPjvVr+
   O26/36wWzpnazWR4Y64lU+kfUwxMHdzhF8zrRqE5DB727swaQOySUU4y2
   /TZVLfuLwn6hbR7hnY7Tlu12SJIBUjkvS1ENGx3KRAMKhxBxxUjXFsS2v
   sSnkfBrqfScsOwTnLGdAeoe0Xur5HeNVzthpTulY+eVQ4RW/PoOMH67FD
   OOG6Y6KCXMeTHYF/xZFB+Gl0BIynxzWgJl02HQrmGoEnQj4dVFVcfXvwp
   5vF5XFhDuHJI63558LWSqhBh2an5eT5Mbhw0WoiZkFPC2UCfQSslCFYYQ
   w==;
X-IronPort-AV: E=Sophos;i="5.98,316,1673938800"; 
   d="scan'208";a="219282305"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2023 18:30:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 18:30:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 18:30:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJxjH2VwerXJT45ikAL9J4CgHtQQe2xn3N0kF+6ovdq7OtqObT6RdtvaXL6OuSrXTTTg+ml5/+DRh50AriHESTAEPV1YUZxmbgm8wy6qzfIohLI4YtOtRVHhxU3K3CAYmEUw7lCpirz8+IwrFBsPceN4PDBDy63HtXUZ7JabDZFZzSr4iq6Euwckx4Qzp0MAuR6FwjCNQYOp1iPyl/uDYnnwBceI+bmPk3FOnE85a6ug+30C9um+Jfb45RsnfjAgRbcZhgY1Hs9TLd7WpxMHfSdfX0N0+AehtzdsBpfS54yLI8mBb7eRRysfvdBCwzL59zHZ8nU0Ywlel7EcXOldtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIHEDTKMtlagdFb9FM8B9ajNqeZGYEhrMExwrzcW7tU=;
 b=AIIkYxwKc84/BCVgnf8lleuJAY6rIPoAZt6k6/DhZxNQTpg2/rBHYFClly+WxF56YDLSmXbUQf+DU4IOZcSG6OP2ng3tIyoDuN4A5PkoC6tlDQmAYvg4Uovk9QItobE5feIs3895hZ3iloaN29aNZur+Xbrs/inUyZ4P7QScEpZKDcVYhwDcTPreXzxkIkTCSQzVewjebCRNnYiQzAKZjuinuhD3WHaTF+mkfxqn77FobDgUyEj2duer/AdIml5Xtbvdal6HzN6LoerXXfFUffZw7shGebfYQSkbOqOGhvQC/g8JXP2C9mNBb6MkOW+Jik8KrqZdVxkSXyfE+mPySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIHEDTKMtlagdFb9FM8B9ajNqeZGYEhrMExwrzcW7tU=;
 b=Xaq3xalXM4S6vR/zr83tIMgYV3ACIZ87UnWVcAI3zzkJ8zEGXPPBwHhlXSE9/t8nFopcL5TKJNhfNhJ/mgq+2sQFtCKoKN5FEAyruSKTrSdiPFiFAagNHTi8I/vbpEdRb7d7Qd1vFA9oz+XO1GcidNmf6M9pCLZgroXHuSa5WUE=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 01:30:09 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3cfb:772f:24dd:e510]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::3cfb:772f:24dd:e510%6]) with mapi id 15.20.6178.038; Tue, 4 Apr 2023
 01:30:09 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kirbuk200@gmail.com>, <mwalle@kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <linux-wireless@vger.kernel.org>,
        <kvalo@kernel.org>
Subject: Re: wilc1000 kernel crash
Thread-Topic: wilc1000 kernel crash
Thread-Index: AQHY57AoYhoLUWmb1kmazG1Rwau7ba4fkKkAgADRA4CARVuEgIAAJISAgAq+dgCAqgBggIAAug+A
Date:   Tue, 4 Apr 2023 01:30:09 +0000
Message-ID: <f69b432d-f7c0-a03f-870e-c8fc0038feda@microchip.com>
References: <20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de>
 <6d022f41-85bb-cde2-0b3d-feef0a0711f2@microchip.com>
 <20221026085415.6jgwrhq4sunqaypm@0002.3ffe.de>
 <20221209120343.wvagbfprsgdj74af@0002.3ffe.de>
 <4f279aa2-b5df-0b76-2cdf-ddb339a19cf7@microchip.com>
 <20221216101842.jjz3glyotqbbqlk4@0002.3ffe.de>
 <8d6316ef-fd66-0b18-ca5b-bb945ebc5370@gmail.com>
In-Reply-To: <8d6316ef-fd66-0b18-ca5b-bb945ebc5370@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SA1PR11MB6807:EE_
x-ms-office365-filtering-correlation-id: da47ff8f-e710-41ea-fa3f-08db34ac20f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: npIUwPMPBhH8GV5cnWLqzskpdIdXbaxXmIlMbuxCxr423zgt75MZkIs+6iJsuz7ihEutMsTV0cUMabPbdyGwfKGHUs7o31Fv+ng5OJs4PJM0paD8+NFuUoplG7S674FOR0sv0PWcKW10F11K4CFY+I3ZaovKuJd0/5pYowvVB1GNcbyVj0fuuiAywANsXqrG7ZR4r0O1sDQF0qgWZmqIPCDzB6ymI2vzf1QNyBbqdlOTXhvvk1l2gibNbTYMRsj+uM8UgtrCketIDXSjzb1h/ETT0yNjT4qYSsytiHmuHw8FBA1GPAs4VYIbN9Lq9c2Rw96p0Ryt/OArtG8NobtjXBj1/5YyVsEdzkyVJsrXcRFew9oHX46SooAfd6e0+Zey+Knpg9RDRYAuL5HWNjKQXclgdnuCBGoiScwgrkX2b38tbejdAHK/0OY3cdeisZvLRG9jXWErr52vnyG7WpPIVGu5I6iecvTTObisvruxXU3hLHKoPOypjZmzdKKudo0z8+pUsCVs/nrSP3k1FtKtGT5e+P4B27XjmJ6YFp6XMNOKtEkvwCgOR2lTLsCPtybVqfwbMOUDpxi67xKrb5FwFnxKPLh17ARitzvICkXTwMNEqcXFTZPp7w/Krv5Y7JG28dq/uqkw4O3Dicr0xNNRzh+VEPjUKrMB7hkj1zAtkSw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(5660300002)(31686004)(110136005)(54906003)(2906002)(316002)(7116003)(41300700001)(8936002)(186003)(478600001)(4326008)(76116006)(66946007)(8676002)(64756008)(66446008)(66476007)(66556008)(71200400001)(966005)(6486002)(122000001)(53546011)(26005)(6506007)(6512007)(2616005)(83380400001)(36756003)(38070700005)(31696002)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFlFWU9NNjR6VXRoNFI2MjNZcXM2NzVLRXVEMkhzcmNRMHhaTVJIaFNrbGRZ?=
 =?utf-8?B?YlROd2dpd0duV3ZTSEhUVy9oZ2RQWHlaMnpUQ1gwcTY0MndwaGR6YWVwVmdB?=
 =?utf-8?B?Z0NwOUIyMjZhRmQrR0QxQ2V6Y3VSRWVKb3lEOTgyY1JEZzR2NmsvYzVLZ1Qx?=
 =?utf-8?B?bXlWd0c5RWZYOVVOa0ROSE94S0lKWmJER21BYlE1K0NTVTdFbnlJOFhMZkQ5?=
 =?utf-8?B?ei8wOWJIcVFPcXpyMU1HVnY4M3hMZWRacktLUUd1TUJ2NU9kUlRxZDAvNjRz?=
 =?utf-8?B?RWZYNVBSQ2xWSFJla2dKcGtqdkFrdWlQekV4Qnlkc3l5ZE9YZmtNOVFRamhS?=
 =?utf-8?B?aW5BU2lpOGs0RytYUWpGd0xCT1ZvYkJYWDRuSStycVRRd3M1SGVXSjdZbWZI?=
 =?utf-8?B?eDAyampxeHlDR1BrKzcvUkN1bnFmK0x1Wkw5bTlVSUlENGk2YVBmMk9XZmdV?=
 =?utf-8?B?OEtHUnB6UmZWM3YwcVBlR0xOSE5PcUhSZHNxeDM0cXFTdGlwZm5tNzRSbE84?=
 =?utf-8?B?N1RPeXZwNWkzMTQwcGFOc2Nrd01VMUI3NjNMeUxRMFkxQy9RUC8rUmlPeFJB?=
 =?utf-8?B?SjQ0MXlEOUhRamJ6TmxOZ0JqL2FPMTFCNG91TXZEbzdSRXVyRjJnTGdlRXo5?=
 =?utf-8?B?R1lodXgybnA0VEJaSHFMc2xWcmJvbXdjL3lMR2V5R2Jac0VnZFZwYUoveHQ3?=
 =?utf-8?B?UnB0eWNFczFBVGVkR29LOXpvTWgrYVlWbkM2ZGVkeDlWTFNYLzd3eS9mbDJC?=
 =?utf-8?B?NGdVdTVNZ1dRekxjcmMzQmU5WlRSOUNnY3N1am1aOUlhQWwwRzBFY2crdlZn?=
 =?utf-8?B?cGxQbllQcDZ2Zk1MS0lhcXVBZVJXYmtDRzdBK0QzdUd5dXJ2eEFsOEp1K0py?=
 =?utf-8?B?eHMyb2FkeFAyd0tSa0Eyc2JIZXd5d0FNckdmRkpCU3VPWVEyQm1WNGRHUFI3?=
 =?utf-8?B?cHI5WTNrOFNzTmxwaGphRElqMnVoZjRSaFZOQXFTWUFjbWV3Nm1FSWV0T1dZ?=
 =?utf-8?B?bUdpZW1rYzJZcDFBNDkyem5ya2lINTdhZjVKc3FkRDVtWEQ0ZnBvclc1L3ow?=
 =?utf-8?B?VGZyN2t4a093RTFrQW1naFhqc3I1YlMxa1FINGNTN2pjWkMzZkxLRTMxbWZu?=
 =?utf-8?B?MmdMSjlraE1KcWFOMnd0THROSDB2OWltRFJ0aGNIQmdDaS82WWNPVGlMdWk4?=
 =?utf-8?B?dWtoYXpIUkJsM2JGNXBhRFdoN2NVblRmSEFyVWVoYjUzdWZmTE56L3d5Nm1Z?=
 =?utf-8?B?TWhHa3I5Q3RnZWFMYm8yZ09aNHJYT0RaY3R2R3ZIU2Z3SFkvWnBoNXdoQmZU?=
 =?utf-8?B?c2w4NmtNNS9vT0RlK3d5UW5HckRJdTR5bWNHUCtCaDMvZldabzJWMjJaQkRK?=
 =?utf-8?B?YVB0RFNvRXQ3YVdnaU9DNG5HQnNjNzZJT3dBWlI3TDA4SmhQYmsxY2Q4RFVp?=
 =?utf-8?B?NGZwSVFNVUpvdnBzazI5V0VMY3lodDdQV2ZOU0RWWkdIRkZmM1Q5SjlNcFoy?=
 =?utf-8?B?V3FvcW1ueWRydWJzM3VwajRGQzd6UzNNMVRyLzZmeWFnNVZFY2V6MlpNV29y?=
 =?utf-8?B?Q3dqek94cVBra2c5T1dLSVhjUithak8xbGM5Q2lzakVYdzBQdy84VmJtZEI5?=
 =?utf-8?B?OXBGRUdCc0ZFaTlJS2E0VksxVHpLYS9LNXJkeFJxR2V2ZjRMaGdHbHI1a3Rj?=
 =?utf-8?B?NkVVTFg3eldROXBiVTV5R0pTUE1qOTFVV2s1K2VxOUdxUXlXZ01uRzNIV0du?=
 =?utf-8?B?d3FMMVYwVWROYmZxdDF3OWlXWFBMU3ZkbXJ3UjA2ZUlDL3ZsakhJK3lnWEw1?=
 =?utf-8?B?VHNXMWZxNHpDMWxGci9WaklWUnJSNzZNNnBweHpRUFNPTkdYcmpDemw4c0Jz?=
 =?utf-8?B?bFBwcWZCU3JLdkhOT2FTNGFHVm5sK3pyNlArZXd2a3d0anQ2RExvVEV0cnZr?=
 =?utf-8?B?THA2Q1FsckdFNDVHQUZyYzBHSWFYTHVpYnVaRW1sb2VuNDZKb1FRaTVDWWJN?=
 =?utf-8?B?cStBeWZTbTJqc1hLSkZQbktOWWZwd3V3cmxlcG4yT2VsSjYvNGhBTTZHRlI2?=
 =?utf-8?B?aFhwUzlLeExROHhSdExUODYyNEFoYlVHaXd3ZTBWbnNieUROYXU4UWJkdE0v?=
 =?utf-8?Q?8MUaKXYSLKosiHn60B6DRk3cW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49EA50B994F3034988CA135E8EE2153B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da47ff8f-e710-41ea-fa3f-08db34ac20f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 01:30:09.4861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWNXj0GQLELwOM4rcmXQJvncvimWjWxgblSw8vhkNiOvj+V/alSveaW/8Gnfyo5nbyy/MD07Ht6IFHzsSLP8kuFJJKYm62LRSo4kG8IeCiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gNC8zLzIzIDA3OjI0LCBLaXJpbGwgQnVrc2hhIHdyb3RlOg0KPiBbU29tZSBwZW9wbGUgd2hv
IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBraXJidWsy
MDBAZ21haWwuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2Eu
bXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTYuMTIuMjIuIDExOjE4LCBNaWNoYWVsIFdh
bGxlIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gT24gMjIvMTIvMDkgMDI6MTQsIEFqYXkuS2F0aGF0
QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4gTm8gcHJvZ3Jlc3MgeWV0LiBJIHRyaWVkIHRvIHNp
bXVsYXRlIHRoZSBjb25kaXRpb24gYSBmZXcgdGltZXMgYnV0IHdhcw0KPj4+IHVuYWJsZSB0byBz
ZWUgdGhlIGV4YWN0IGZhaWx1cmUgaW4gbXkgc2V0dXAgc28gSSBuZWVkIHRvIHRyeSBtb3JlLg0K
Pj4gU2hvdWxkbid0IGl0IGFsc28gYmUgcG9zc2libGUgdG8gc2VlIHRoZSBpc3N1ZSBieSBjb2Rl
IHJlYWRpbmc/IEkndmUNCj4+IHByb3ZpZGVkIHRoZSBjYWxsIHRyZWUgaW4gbXkgcHJldmlvdXMg
bWFpbCBhbmQgbXkgY29uY2VybnMgcmVnYXJkaW5nDQo+PiB0aGUgbG9ja2luZy4gRWl0aGVyIEkn
bSBtaXNzaW5nIHNvbWV0aGluZyB0aGVyZSBvciB0aGVyZSBpcyBubw0KPj4gbG9ja2luZyBiZXR3
ZWVuIHRoZXNlIHRocmVhZHMgd2hpY2ggY291bGQgY2F1c2UgdGhpcyBpc3N1ZS4NCj4+DQo+Pj4g
Rm9yIHRoZSBvdGhlciAiRlcgbm90IHJlc3BvbmRpbmciIGNvbnRpbnVvdXMgbG9ncywgSSBnb3Qg
c29tZSBjbHVlLg0KPj4+IFByb2JhYmx5LCB3aWxsIHRyeSB0byBzZW5kIHRoYXQgcGF0Y2ggZmly
c3QuDQo+PiBPaywgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgc29tZSBwYXRjaGVzLCBJJ20gaGFw
cHkgdG8gdGVzdCB0aGVtLg0KPj4NCj4+IC1taWNoYWVsDQo+Pg0KPj4NCj4gDQo+IEhlbGxvLA0K
PiANCj4gSSBmYWNlZCB0aGUgc2FtZSBrZXJuZWwgb29wcyBpc3N1ZS4gQWZ0ZXIgYW5hbHl6aW5n
IG15IGxvZ3MgYW5kIGJyaWVmDQo+IGRlYnVnZ2luZywgSSBhZ3JlZSB3aXRoIE1pa2hhaWw6IHRo
ZSBwcm9ibGVtIHNlZW1zIHRvIGJlIGFjY2Vzc2luZyB0aGUNCj4gc2Nhbl9yZXN1bHQgcG9pbnRl
ciBhZnRlciBpdCBoYXMgYmVlbiBudWxsZWQuDQoNCkkgaGF2ZSBzdWJtaXR0ZWQgYSBwYXRjaCBb
MV0gd2hpY2ggaGFzIGZpeCBmb3Igc2Nhbl9yZXN1bHQgTlVMTCBwb2ludGVyDQpleGNlcHRpb24g
aXNzdWUuIFRoZSBzdWJtaXR0ZWQgcGF0Y2ggaGFuZGxlcyB0aGUgc3luY2hyb25pemF0aW9uIGJl
dHdlZW4NCm1hY19jbG9zZSgpIGFuZCBhc3luY2hyb25vdXMgaW50ZXJydXB0cyBmcm9tIGZpcm13
YXJlLiBCYXNpY2FsbHksIGl0DQp0YWtlcyBjYXJlIG9mIGJsb2NraW5nIHRoZSBleGVjdXRpb24g
b2YgbWFjX2Nsb3NlKCkgdGlsbCBhbGwgcGVuZGluZw0Kd29ya3MgYXJlIGNvbXBsZXRlZCBhbmQg
YWZ0ZXJ3YXJkIG5vIG5ldyB3b3JrIGFkZGl0aW9uIGlzIGFsbG93ZWQgc2luY2UNCnRoZSBjbG9z
ZSBpcyBpbiBwcm9ncmVzcy4gSXQgaXMgd29ydGggdG8gdHJ5IHdpdGggdGhhdCBwYXRjaCBvbmNl
IGFuZA0KY2hlY2sgaXQncyBiZWhhdmlvci4NCg0KMS4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXdpcmVsZXNzLzIwMjMwNDA0MDEyMDEwLjE1MjYxLTEtYWpheS5rYXRoYXRAbWljcm9j
aGlwLmNvbS9ULyN1DQoNCj4gDQo+IFJlZ2FyZGluZyB0aGUgc29sdXRpb246IGlmIHRoZXJlIGlz
IGEgcmFjZSBiZXR3ZWVuIHR3byB0aHJlYWRzIChhcw0KPiBNaWNoYWVsIGRlc2NyaWJlZCBlYXJs
aWVyKSwgdGhlbiBJIHRoaW5rIHRoYXQgdGhlIGxvY2tpbmcgbWVjaGFuaXNtIHdpbGwNCj4gYmUg
dGhlIG1vc3QgcmVsaWFibGUgc29sdXRpb24uIFdlIHJhbiBpbnRvIHByb2JsZW1zIGR1cmluZw0K
PiBkZWluaXRpYWxpemF0aW9uLCBidXQgZHJpdmVyIGNvbnRhaW5zIHR3byBtb3JlIHBsYWNlcw0K
PiAoaGFuZGxlX3NjYW5fZG9uZSgpIGFuZCB3aWxjX2Rpc2Nvbm5lY3QoKSBmdW5jdGlvbnMgaW4g
d2lsYzEwMDAvaGlmLmMpLA0KPiB3aGVyZSBzY2FuX3Jlc3VsdCBpcyBzZXQgdG8gTlVMTC4NCj4g
DQo+IEkgdXNlIE5ldHdvcmtNYW5hZ2VyIHRvIG1hbmFnZSBuZXR3b3JrcyBhbmQgSSBoYXZlIGV4
cGVyaWVuY2VkIHRoZSBzYW1lDQo+IGZhaWx1cmUgbXVsdGlwbGUgdGltZXMgd2hlbiBzd2l0Y2hp
bmcgZnJvbSBvbmUgV2lGaSBuZXR3b3JrIHRvIGFub3RoZXIuDQo+IEtlZXAgaW4gbWluZCB0aGF0
IHN3aXRjaGluZyBiZXR3ZWVuIG5ldHdvcmtzIGNhbGxzIHdpbGNfZGlzY29ubmVjdCgpIGFuZA0K
PiB3aWxjX2RlaW5pdCgpIGZ1bmN0aW9ucyBhbmQgaXQgaXMgbm90IHlldCBjbGVhciB3aGljaCBv
bmUgaXMgY2F1c2luZyBhDQo+IGNvcmUgZHVtcC4gSSB0aGluayBpdCdzIHdvcnRoIGF0IGxlYXN0
IHRha2luZyBhIGxvb2sgYXQgdGhlc2UgYXJlYXMgb2YNCj4gdGhlIGNvZGUuIFdoYXQgZG8geW91
IHRoaW5rPw0KDQpJZiBwb3NzaWJsZSwgcGxlYXNlIHNoYXJlIHRoZSBzZXF1ZW5jZShjb21tYW5k
cykgZm9yIFdpZmkgbmV0d29yaw0Kc3dpdGNoaW5nIHNjZW5hcmlvLiBJdCBsb29rcyBsaWtlIGJv
dGggZnVuY3Rpb25zKG1hY19jbG9zZSAmIGRpc2Nvbm5lY3QpDQphcmUgZ2V0dGluZyBjYWxsZWQg
ZnJvbSB1c2VyIGNvbnRleHQuIG1hY19jbG9zZSgpIGlzIGEgbmV0ZGV2aWNlDQpjYWxsYmFjayB3
aGVyZWFzIHdpbGNfZGlzY29ubmVjdCgpIGlzIGEgY2ZnODAyMTEgY2FsbGJhY2suIEdlbmVyYWxs
eSwNCndpbGNfZGlzY29ubmVjdCgpIHNob3VsZCBiZSBlbm91Z2ggdG8gZGlzY29ubmVjdCBmcm9t
IGN1cnJlbnQgV2lmaQ0KbmV0d29yayB3aXRob3V0IGJyaW5naW5nIHRoZSBjb21wbGV0ZSBpbnRl
cmZhY2UgZG93bi4gSXMgTmV0d29ya01hbmFnZXINCmNsb3NpbmcgdGhlIGludGVyZmFjZShtYWNf
Y2xvc2UoKSkgYmVmb3JlIHN3aXRjaGluZyB0aGUgV2lGaSBuZXR3b3JrLg0KDQoNClJlZ2FyZHMs
DQpBamF5DQo=
