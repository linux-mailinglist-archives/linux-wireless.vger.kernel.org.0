Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100F4324EC1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 12:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBYLFL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 06:05:11 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:57125 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhBYLFK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 06:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614251109; x=1645787109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x9sSiDBwZbUo3rUjKncR/MLvBn5DkXIMbasZmPvcwLU=;
  b=EycrXuo5RyqE7mzhucQgui9WbyEfbMoukvFJRkmEHrRb//AJte5B9RHF
   xS3qcC9d4Fb/CAomYfo2S8Nk6+eNDfoByonlCP3WazpfVCoAYv/QBtp7S
   gmiY0rlcdIzIEj6fe8J6DZEMvrYG710pHTZMbEOhDRZ10l0w/zlODIYbT
   gBxVz5n4tArmQnHd5tpo7RKx3u4QIdAGWdmW1BHILk0ZQE/2HOVniaeG/
   N+sepjdF0UaXO6DUfH++GCKpeyizQ9nmUFBwvexGQWgddbtZ7YypXLvuK
   wEEdC4wkKdUZhgQs/WxWvswOH3rGWK/oMA9APieCpdfh5FgPvCIdfbdtR
   g==;
IronPort-SDR: UouDXHR60mdPMZCSveCNUAAMIv4JZxpb+bsq9d/yjB8W/EOHOWUkqrntXjJIEunnKXMBqWyinN
 qNzvV1cbBiep18nU8IG2X6UNTiJbHfTR1CA5DCfUfTRP7l0AWVoXHwwns0FKXdjznqten6j6of
 SAGSjumceL3zMlEV44E66mJpv7haOFnc3wjsUBFKNaPiWhGru62Me9IkecMjfMQi1J0A9CTHCc
 8kkazNltQdaxfakOR36nLcicjmrL5cLBhnoFlHJUVsRY6dYm6r/PPK7chStyroNevGHPBbLOpr
 Tok=
X-IronPort-AV: E=Sophos;i="5.81,205,1610434800"; 
   d="scan'208";a="110592817"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2021 04:03:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 04:03:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 25 Feb 2021 04:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJwsqFCjzinx6iaYrM70G/WPjGe/vxO9eMsPAjRDchehUnHfeJxOCGJ0Tks5KQ2VUp2hYuj+mt1T41uS2HuOfe0akARGlOnWm45RQZNz7om2cvdJke/jBcqTKX4Ip7ERjKiUFYrRodVZWrGkiEKVpPzuwSh7hpI4voXdzUnIElKCdJ7dKMuMTKbHYE/wCydM2wTA5oNtPjeXHkroBnsQCfOU07d9Vb2aSNFZISXHZFMHi0QAGJg85PzcTwzD4BkfrOOkkFSP8hKz3RjF0v5MZqNJ2EC6x8ZZMZ1K3c8yYd98s65yRUjoMFGgaJyEy7YrBbPMWopy9VlXwKPRK6vMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9sSiDBwZbUo3rUjKncR/MLvBn5DkXIMbasZmPvcwLU=;
 b=Y25CF9g547MguxBdixQ/fuZ1vZHGE1dP+TD5Fx+1TCfTmzBQzUS27NRxT75Aj7q4CP1h8/Lk9a1CtoUfMEYiyQMlq9MOFVp1TpE2tG735JfEt+C408ijDQq+o9xfshJ/XN2L6ThYH5n5TgmSTvM5mbplnv+XDTuh3X3rZAz4nlwFOdm8oVVDa+nPsp/xQmKlfjJYpz71zvWXXM89KKQ/+DvWqlLNTV9tnXPxG4JgB8RS0RhOXxKY0y9hMCaOKZFCC3QfPvN4h39yx2Rqu+A/jHWLDFxIED2NQJL9w77+m6MTKwJ2nn6DDouc9CEc+BMPK3iRPoU4PKb8mInX42jFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9sSiDBwZbUo3rUjKncR/MLvBn5DkXIMbasZmPvcwLU=;
 b=ogFXrkzK7ypkk5B7Qq3mHJxaXLNc5Zc61NJsOqMqY7JVv6R/9QOoKmJWdyOpD+WLYwHuDBJ41+iyspXwCzRhgsUDxPBFPd0DF14mPZ1sQ3uYzChXoqEFJoXJm95B9f5tpXgsabimAr/HBSogDyF4YLpdJv8XAVYBUHMw7mVKcUw=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3383.namprd11.prod.outlook.com (2603:10b6:a03:1b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 11:03:51 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 11:03:51 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <davidm@egauge.net>, <julian.calaby@gmail.com>,
        <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 4/4] wilc1000: Add support for enabling CRC
Thread-Topic: [PATCH 4/4] wilc1000: Add support for enabling CRC
Thread-Index: AQHXCnEwZSbR0AsbwkSoOjOCksEYjKpn0IyAgAAmboCAAGoDgIAAKPIZgAAs+IA=
Date:   Thu, 25 Feb 2021 11:03:51 +0000
Message-ID: <22b6e634-d881-7e94-c96f-f92b1588cf05@microchip.com>
References: <20210224055135.1509200-1-davidm@egauge.net>
 <20210224055135.1509200-4-davidm@egauge.net>
 <CAGRGNgUR7wHgprWcqz5orJNuhcxeLMSE1C3WCi1_UH_MCwJ6Cg@mail.gmail.com>
 <70567db1d625086e051b305320c9d4be7deb1b82.camel@egauge.net>
 <74fcdef6-124e-3fc2-6467-f71badc01d0c@microchip.com>
 <87mtvseev3.fsf@tynnyri.adurom.net>
In-Reply-To: <87mtvseev3.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.104.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 066938e6-ecae-4f58-2ddf-08d8d97d08a3
x-ms-traffictypediagnostic: BYAPR11MB3383:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3383242BDAA71D7EC23EF16BE39E9@BYAPR11MB3383.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yeI9hkO3zBxHwTLhP85SYCRGmsCUbbXbLGVkvbDNFp/6o9zWXfQaOFCclH4w8rh6lwcdj7xqFWWK3JDGbliffoVTGSoEjxldUXSO8++9beMkl6I4KQ4xdFTIZZVurx1OsFTac9KDXNlpmxtZQhWZGxZY86NlVeDHyNjptRvZlD2UdBJps1/t5Y4vjT9CnG1NDX+YdNR/ruBJsf7fuBE2HW/kyCJdE/AWHx7x/QoYECmbO4eQYp6pIbqEt9tPX2a9tXH1285Ac41uNz8LP39RGFpkICm3trieJnsfjwcd504iuRHibuptucx9wp0NhVt5GQsod8UKrq7/0kBpxWyrj0Ay6J6s8MJtWPB/w3WoMoR1Wwwp0wCLjZLhSEh7kKYF7jrN2aneIVn9BnEZjPanHQEiRlhw0isVOIBZcMIf++ilrE2lf8Pd+h7i+ucsugeuV1AI3dECQGc54EUHdrc/zUbzzv8KD/txcAYblhb3H4CC2E9+0XR4JXf8t3GENFl8FsrD5HpsW+L/0CxOfM+VlwQJ9xaP88KzbKn5MmmJhQtrrZHndmkaVOeaaXp781Dlbe3NWazVnKhTRSwiF5jaPJje+k+qdKT7FyHGwLXPHlY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(31696002)(2616005)(36756003)(54906003)(86362001)(6506007)(71200400001)(26005)(53546011)(2906002)(76116006)(64756008)(83380400001)(6512007)(66446008)(55236004)(478600001)(91956017)(8936002)(4326008)(66946007)(66556008)(6486002)(107886003)(5660300002)(6916009)(8676002)(186003)(31686004)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UWFjeExUOGZVR0tuK2hHejdPbnM4OTZMVCtZcHdHTnZSWnVYU3NVWFpibU5B?=
 =?utf-8?B?QWVjQnVLcFVHUzJXcGtHV2N3SEFNd1lMcUZXRWdzVUJ5UUZnSk9WOGpaWU91?=
 =?utf-8?B?cjFGRUVlZER3VEI1K2g3ak5vbnBPZ3k4bkJVOFAvbHU5Qm1ld2xCaklKQmFP?=
 =?utf-8?B?bXJpNVFOdTN4V1Bkd1dIUExYQUV6VkE0eHJjMndRaTdxTXZIM0orb2ZjS2pF?=
 =?utf-8?B?dUhoeHFVWUZSQUM5SkF3ZGI4eks2T1V4WVg0ZmJGRWJqeGduUHlISU1DY3R4?=
 =?utf-8?B?SlJKU2Q5MUZsVFpId3hYem1WMks0RWhud3MvZEVkNzkrNzVTbXlacVQzZitD?=
 =?utf-8?B?UTZFdC94aXE0NjQyYm0vM3pxYk44THFJcFdnMmRob203RnhXSWlYYWh1K2NQ?=
 =?utf-8?B?SmxjYjhHSG1teEgyVXdKNTRCci9nL3JnSVVyS1Y4Ym9UZ0FLM09nbllkZ1Zl?=
 =?utf-8?B?eDZXYUs4R3lYeUY5YnJmMnhBaC9GKytWNlZmL1lzcUMxUERLMGdjRXJURlVr?=
 =?utf-8?B?RlFaUEM0L0hsZFErTGVUQzJKSjk0NUNGTEkyUk9PS0VPZ1lEdzRBcmJHTU5u?=
 =?utf-8?B?ZitiNzhaWEF6RnpqVGJUbTcrZXBSY3ZDMTE4dmRNbTdpVjBzUEpzOFpSM2ph?=
 =?utf-8?B?UkRhTTJCckN0Q2REY1lsMkxKQSt1bUJjOVI4T2pnZzgwRWI0dDE1Sk5idFN1?=
 =?utf-8?B?Q3hyUG5jUjl0NTZNdkhqazg1WWZCU05vM09TWVp0ckRKZlhFU1l3Qk5ObE9r?=
 =?utf-8?B?WDVyeXlWaFJZZ1pCREN5U2J1a2pDeGZDM01xOTlWdmRGVHh2cDI2VVdwWG1l?=
 =?utf-8?B?VzhwckNLUUtMZjdxcWFQRHdoUE4zZktZNzJOLzVBbVAwOXU0bnJZRnFmWWpY?=
 =?utf-8?B?blphOHpFaks1aDg3dE04cnhKcVZRdzNTZDV1TkJxOTNMK1VCdjVydkQ2TS9I?=
 =?utf-8?B?Mjd1THZVeWxPb05ZaFlkYlQyMXFQVE1mSDAvUE5ReXBQT01GZmNDYU14V0p3?=
 =?utf-8?B?eTJTb2hlZFBRTzI5T0dRU0c1Q0x5bVVLeWJVenF0QW4rUU9paEp3dEJYa3lI?=
 =?utf-8?B?T2puUWZIcFdwQmFuSFB4VmltaXpyZEVPMjdNQ3NTT3hxbXdtcTF6NnBId1Vm?=
 =?utf-8?B?QW5hYkYxZ3lLRGlBdzYrbXhmdEFJWVJVeXdsSy93TGRVZW15Wk11VUdmdG9I?=
 =?utf-8?B?eTZUcno2a21KalZ2aWl4bDA4R0NBK2FBQmo3bTdwQWp6WElmM1lHeG5Cb3lK?=
 =?utf-8?B?VFBFMG9DNklITGtBQmk0SzYzbzhXcXdQT3JaMXNsc3VWcHRxTy8vaW5uVE94?=
 =?utf-8?B?QXNFNC9LckFSNDMzd1M0Mm5PcTZnbFYwQm5lRjhNSW5keDNvbWhJaWNXYkxu?=
 =?utf-8?B?UG9RZWJYVStiLzhzRDhnNi85cURFS3lqbVorc3N2WW9XVGdlZVRwek1JV0Ev?=
 =?utf-8?B?bW0vSEJyaHJOZjREcGwvRzR6T015N0h2WkZhN3c4Z3MvbDBsRTVKLzdTVTF2?=
 =?utf-8?B?dmhWVGNtV2t0WDNZZVBESGNVTGtNTk0wempRUE1uWmVBKzJoUjlnMGQxZEp5?=
 =?utf-8?B?b3pDaE5TNExHSXhLaHJMdm5EZE1OZDM4R0Q4V2lMdm15czNkYy9zR3AzQ0JI?=
 =?utf-8?B?Y0d1UWp5dmJUZEhHT2JOU3VXd0drU3prOUxITXYwSUlBRmhoY2tjMDhhMmxB?=
 =?utf-8?B?VHFDOE0vOEZqS2huazE2bnJqeXMyTGZiTnpDYTdCR1hkd3h6cWZDbVlYSzgw?=
 =?utf-8?Q?s661b9MWoWc+KrwMQ5rriEOCPUWMFFtVrhnRIW4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <762C5807BE7CF74DB1E80494863F0E2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066938e6-ecae-4f58-2ddf-08d8d97d08a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 11:03:51.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmQYu1yEZVz4s3CZnP4g7613RbwSwtTpc0wRVAHWFedsYszDsOh1BoFJjm89H1NXP7QuzX3AnZPtjnDUhh6X1wUMe0oao6Mp51LIl9Pv8oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3383
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCk9uIDI1LzAyLzIxIDE6NTIgcG0sIEthbGxlIFZhbG8gd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gPEFqYXkuS2F0aGF0QG1pY3JvY2hpcC5jb20+
IHdyaXRlczoNCj4gDQo+PiBPbiAyNS8wMi8yMSA1OjA2IGFtLCBEYXZpZCBNb3NiZXJnZXItVGFu
ZyB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+
IEp1bGlhbiwNCj4+Pg0KPj4+IE9uIFRodSwgMjAyMS0wMi0yNSBhdCAwODoxOSArMTEwMCwgSnVs
aWFuIENhbGFieSB3cm90ZToNCj4+Pj4gSGkgRGF2aWQsDQo+Pj4+DQo+Pj4+IE9uIFdlZCwgRmVi
IDI0LCAyMDIxIGF0IDY6NTYgUE0gRGF2aWQgTW9zYmVyZ2VyLVRhbmcgPA0KPj4+PiBkYXZpZG1A
ZWdhdWdlLm5ldD4gd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4gKyNkZWZpbmUgRU5BQkxFX0NSQzcgICAg
MCAgICAgICAvKiBzZXQgdG8gMSB0byBwcm90ZWN0IFNQSSBjb21tYW5kcw0KPj4+Pj4gd2l0aCBD
UkM3ICovDQo+Pj4+PiArI2RlZmluZSBFTkFCTEVfQ1JDMTYgICAwICAgICAgIC8qIHNldCB0byAx
IHRvIHByb3RlY3QgU1BJIGRhdGENCj4+Pj4+IHdpdGggQ1JDMTYgKi8NCj4+Pj4NCj4+Pj4gU2hv
dWxkIHRoZXNlIGJlIEtjb25maWcgdmFyaWFibGVzIGluc3RlYWQ/DQo+Pj4NCj4+PiBJJ2QgY2Vy
dGFpbmx5IGxpa2UgdGhhdC4gIEFqYXksIHdvdWxkIHlvdSBiZSBPSyB3aXRoIHRoYXQ/DQo+Pj4N
Cj4+DQo+PiBZZXMsIEkgYW0gZmluZSB3aXRoIHRoZSBjaGFuZ2VzIHRvIG1vdmUgYXMgS2NvbmZp
ZyB2YXJpYWJsZS4NCj4gDQo+IEtjb25maWcgaXMgbm90IGlkZWFsIGZvciBjb25maWd1cmluZyBm
dW5jdGlvbmFsaXR5LCBzb21ldGhpbmcgbGlrZSBhDQo+IG1vZHVsZSBwYXJhbWV0ZXIgaXMgdXN1
YWxseSBiZXR0ZXIuIEJ1dCB3aHkgbm90IGp1c3QgZW5hYmxlIENSQyBhbHdheXM/DQo+IFdoeSB3
b3VsZCB0aGUgdXNlciBuZWVkIHRvIGRpc2FibGUgdGhpcz8NCg0KQXMgSSBrbm93LCB0aGUgQ1JD
IGNoZWNrIGNhbiBiZSBhbiB0aW1lIHRha2luZyBvcGVyYXRpb24gZm9yIGVhY2ggZGF0YQ0KcGFj
a2V0cyBhbmQgaW4gdHVybiwgY2FuIGhhdmUgaW1wYWN0IG9uIHRocm91Z2hwdXQgcGVyZm9ybWFu
Y2UuDQpHZW5lcmFsbHksIGl0IGlzIHJlY29tbWVuZGVkIHRvIGtlZXAgdGhpcyBDUkMgY29uZmln
dXJhdGlvbiBkaXNhYmxlZC4NCkJ1dCBzb21lb25lIGlzIGNhdXRpb3VzIGNhbiBlbmFibGUgaXQg
b24gYSBuZWVkIGJhc2lzIGJ5IGtub3dpbmcgdGhlDQpwb3NzaWJsZSByZWR1Y3Rpb24gb24gdGhy
b3VnaHB1dCBudW1iZXIuDQoNClJlZ2FyZHMsDQpBamF5DQo=
