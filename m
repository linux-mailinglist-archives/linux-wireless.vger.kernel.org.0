Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF93249BC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 05:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhBYEXA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 23:23:00 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12672 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhBYEW7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 23:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614226978; x=1645762978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e1+0iBayD6d7YN9sNzP7v4pAT8DKuW2lwWNXqMQybbY=;
  b=Dpvaqckm5nYK4IOYVbGmDjwXO0EOAW0plkYp7tb69HyNLhpxbFRQDSOK
   OP503VPrhT7VbssIpflusBVuIjZQu2vGhsGO7TPjmqvDPJzPM6aLLxq1X
   Xv+jWIhdLrOAJ4hBwtY4UC2zkgV73/cWGvQZWre0HoMGyoQnnwWdWdX85
   1PROcFRjB5uZpui2oimuJPrB6aNMt6YKhur06AQ4xtTryEAUSZJ0PvPdB
   BpKf+vQGQUOp60Y9Fu/oQpSgpSeL9qulDnjiO8tPejAUsQ9Hpj6JKlRVM
   G9CTaK+HBBM2q8dCEH1T+EkdEKW9fcOg7c+K1O/AzuPu4HIq88yJJdH7i
   A==;
IronPort-SDR: Bc0D3ulPxpLW6uq0t4lZlrM4El+ULXnWJRz1exyN8qqLH1NlnROXRUZMy5fvW2yVdnxNTjPHJk
 OQ6gQHSyRXz0dn+nseGj9jRtrE0Q7797asrEYFjuUC4fzyqTO0pz4q82kz+FL6m2kqGnEYAYwE
 bnw56O5WR5yeysABchV1b/9GU1fD0Zm9Fgy2e3SDzrlmGtsBvPRf+Ur2vzpsDVLjjHyd/xK9qU
 uPwBqDC7g+eShj0qywW4jzpzYEE9X6G+Xkd+ZusD2wCxDs8OMsxE1UdAQQNttwt7eFhd+nMKOF
 RGQ=
X-IronPort-AV: E=Sophos;i="5.81,203,1610434800"; 
   d="scan'208";a="45383392"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2021 21:21:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 21:21:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 24 Feb 2021 21:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHTTYhvsj69aWHPH8IygP3DYcz98LNcLj9uTfzRLAhQDpVyBG6Dy55gv+mtjS5dsdms/7Hy102C0TDComFErQTzd92OkA/DUu/L9Xj4hZCPW86wGjW+ULxLs//9IIb0m9/DMtBE2jXQqRbXP5wwtNaFL/HXDsXuyWqefsUKPAL3BUjQusP9HfNaKl8WbawbFQlPBfycJLZUT/nFXAIs/LsQvgQhES6OY1d6esRJBtlrjpT9OIbGSJV7vma+ul6/knnNUime0CMZSIOFjZZfkfCNGjdq6JIHEqYvvvPhQiyMf2L1y21xIOt/jqvpjpVca/+Qj4k+1BJC9kN8KZ68kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1+0iBayD6d7YN9sNzP7v4pAT8DKuW2lwWNXqMQybbY=;
 b=JliSAHjFyD9ke2namVIjBoRbX5Lkj/zaenPh0TTThqDAilhVbziZTjqtq0A/JitJroff6PtIqDZG9y5MZ3Xfkw9eGqeyslpseBa8AXDF54WHh8ITVFZYhixuEKDRW/E3h/UXGV7wuEqy24fg6nIubUZym4CfuIQ4maaHgoLbynWQzKrrovtx82h+m+VrSvc9Cs7FFh1SATdBW0MVB7cwSJGvXqCe/Z2Z+xn2BRCbphjCNl7xfnBIvlYeteKWw1X+5jL6WS7eJEPVAiGO8SXLjKR74o83AwJ1fMEJt9wd1t97Tag0vA71mwpTXo5tOv/477Upsx8YE1ScJ4o9FZZ5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1+0iBayD6d7YN9sNzP7v4pAT8DKuW2lwWNXqMQybbY=;
 b=FhGPwMAPTuBCrImxEK4JE8npYvaOKllBe1jrFX/GWazv/FE9EfzD6E5cdluwBFEiXt03xTCdeLhP02gWCI6qD/k9l76UmvUtbsafufoaWU4yheuyQHh+iccssa6c3RXJ00qDG3YuCkRTT2t8sWoidUc4kpWxvRMWW6N9DXCvn0I=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BY5PR11MB4168.namprd11.prod.outlook.com (2603:10b6:a03:181::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 25 Feb
 2021 04:21:41 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 04:21:41 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] wilc1000: use wilc handler as cookie in
 request_threaded_irq()
Thread-Topic: [PATCH] wilc1000: use wilc handler as cookie in
 request_threaded_irq()
Thread-Index: AQHXCqeTc8gMGR/R+EWdEgZdzjM0K6pnblRJgADXyAA=
Date:   Thu, 25 Feb 2021 04:21:41 +0000
Message-ID: <0802f506-c254-a562-7bf5-08a1d524938b@microchip.com>
References: <20210224122044.15146-1-ajay.kathat@microchip.com>
 <87tuq1fpss.fsf@codeaurora.org>
In-Reply-To: <87tuq1fpss.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.110.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6b9e156-142c-4894-766d-08d8d944d9f9
x-ms-traffictypediagnostic: BY5PR11MB4168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4168FD3CE6A8048B9597939FE39E9@BY5PR11MB4168.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rf1pphMYcMHvwUOiSBQ0TmcisdUG/9DdYZuSaZVAlT8rcT3AkI+fv0eCs1PQkqPvigXr/gk9f3ujY7HejPKHlyMC1C/ZU7/c5ZqZHcH+z6LIqGQPTCdo9KDsCIZiy9s7SrMvFv3zqCDqNEyXLQX1UwRL6JOIPQJfSR4qA0eOnSzfj0Noo+xVC3Sp5mzy4lntvT4mwbtwV7EbO/f2/G/dg11y88A8xD5JsqB0xScMXBZVQhJGTAC4ywYpQ9YfXke8iveg7rhv2GskcouJtO8CkWWntcvLfo42XODh605L5zMj/tggRnsxa0qWhI3gsqvJ5e1MLie2OqKbnC/pqCmNYzoBLPYkLjJQXlLBrtlVcbvVxyS2J81v5gpGyuI7TPMLWwrqQDvkmK/tKoRiJkILJrwQ824Q2OBiZga3gTRmAm9ld8ooTTi0qsfSS3L9P++t+uisHtvx/QfMsI/oWRvQ9/4Ku23lIyCLAdGFpIki7mmxrrM3lmKs4F0eLrpB6LoRpQQ0ridaY/gcIdViCd2DZrdN6/IEvm1YcTcVf+E0LhfgMbV8Ic3uNCzY6/ZpVoVLs5ghAa/Gd5wniL5hCo9aSgmFHCdgGhxi5wFnXcUOOR+V+4SAdNVRteUwH2pKk4ObziFym747p8uavP0yCyC4yHNGtr+X1AbqsK+Pqy3cZ7DpOMJYBz4Q2SLtmxjPIgPE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(396003)(346002)(39860400002)(66476007)(83380400001)(186003)(64756008)(66556008)(6512007)(966005)(71200400001)(478600001)(76116006)(107886003)(66446008)(53546011)(8676002)(316002)(66946007)(36756003)(31696002)(6916009)(26005)(4326008)(91956017)(86362001)(5660300002)(2616005)(54906003)(6506007)(8936002)(6486002)(2906002)(55236004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WlhvQU9ZU0gyRnpDeS9UWEZqbDJwc3U5ZmNuZVlIaklTdkYrbHBDS2ZtOUNt?=
 =?utf-8?B?UUlBVDZ3UXFBVGdiYUpBOElzTDM2NDdaSjRpdGhyaVVzWWhUTDB5VHA5akQw?=
 =?utf-8?B?U2dVNDVhTmpqTlBPVnhCNnU0ckN2UVdtZnFBYkVEOGlXMERXVzBIZWtaUkdK?=
 =?utf-8?B?b3NuSGxWMWt2TnNSYVZlZnNNcGZrMHlXTjM5NEN5MjN2UXdhRDlJenBpd2FS?=
 =?utf-8?B?eXAzK1hZNEdNV2VFVGwwdGJNazV2bWw1ZXM2em93YW00VmhuMDk0QzhlcWlU?=
 =?utf-8?B?R3lPRGp5TU5VeitUYkMrL3FlVFlFanBDWGg4b2g3eERQeUZHUXJ6VC9OQ1V4?=
 =?utf-8?B?WVF0SmRsZWU1UmpkbTRFV05GR1VTdE1jVDdkZlNwM05najdIaUVMRkd4QzRr?=
 =?utf-8?B?R0pxY2I1VGdQa2h1RFcxZitmU0wwWUlRSXJZMjZLdk5nVzU0WHB5M1RxT1ZI?=
 =?utf-8?B?Z1JNYW5nblZNcWthVjE0VzBGdE5aanhVUnpnS1doYmRGUFlrbDBtQ2VBbjU1?=
 =?utf-8?B?OURGalZEWEVKSEg1T3lLR3d2SGlyZ3hLZlRhQVFsYXNBdHoxSCtyN1pxa2N5?=
 =?utf-8?B?SDFRWlJJVnVqcW1SZEQvSDF5Y1E0Q0V1TE5BVU4wbGVkOUtBSFMrZzJNZGJH?=
 =?utf-8?B?anlQNTQxS2hpNmtIRHY0aTJSek54MjZhemVSN0ZrYVg4dUhFejl5b0lkaXh1?=
 =?utf-8?B?VkJydE43eitwRllBWVNiU20yYVFkYXArL1MrVjZKYjJwUVpnK3lyeUdQRmJt?=
 =?utf-8?B?SnpKY3l0bFdwRFA2SjhaNjZjU0xkVUQvSXF3MlpWOWNWUzVWaXN6c3lxakpu?=
 =?utf-8?B?dHlaMkFhQ2Q3aEd3YS9iZEtPZ2lJa3J4aWZhOXg0bTNrcTk1VEUrTU9hcTdV?=
 =?utf-8?B?S3JWd0xwOG5rSXFTcWl6Y05CT1R2TVFCaU92aDUxYjJoUm4xZE83QUNRWG54?=
 =?utf-8?B?dnZLeEJodmFHVGZ5NTVtOCtmN2FnajJFbGtpejNIcVdJV3VxNVNRZEtsdHlk?=
 =?utf-8?B?VDhsN2VWZE1aSUNwZEE0a1ZyZVFkanRvUjlNd3libDdaSzZMTzUrOVQ3Wkli?=
 =?utf-8?B?SlhvVkxpMzJ4aUZXU2lHWmxmT0dCaHVySWFrRlA4QlZCd1JFR1RDNmlwV0hi?=
 =?utf-8?B?c2JXWlQ1VFdwQ3l0cVNoRy8zR2RkcTFwU0FVWWxuNkM3MkhHTld4WEpYNVc1?=
 =?utf-8?B?WWhWQllRa1RSTENIcVNVUDZiTUpnYzdJK1pSMnJDL2hYeU80QXVpZzVvb2tW?=
 =?utf-8?B?K2h4Q1ZzOUR2bWtGSlRPRFF5RG92anBsREhpS2I4MWphSEhaSUdmeGpRWE5Q?=
 =?utf-8?B?eExHRUdKNlhuQ3Z6ODV0MU11MGw3cDJCTXVXV3BXVWR4QTVxdFZjeHZDb25C?=
 =?utf-8?B?SG15dmNDblRLVDRNRTNpVzVwUDFHUkI3QjZ3YjROZmpqR2FsZDRTanFmdHU2?=
 =?utf-8?B?Y2RUVG53SWcvQkpqaFFlZDhHWUhWekNoR08xdUhwc0tqdUhNOTVTK040NXFU?=
 =?utf-8?B?ZFNWMU8xbU52b3ZXaEtpYUpmZ3dsNEVkU0wrS20rNlB3Z3A3YmFRMlNTeCta?=
 =?utf-8?B?QjdGWHNSZ1JZbTBLN2ZZSHVkcFA0WjMvaXRMZnkrNW9Td1hqTmgrNDJnV3Vi?=
 =?utf-8?B?MnljNG54NWJoRWl2aWhYcVhnVmFwbW51K1Q2T255S2c0a25lUmduTlV0TGY5?=
 =?utf-8?B?YnBkUGJ5cGh6WUZtT3gwdWY0MTR4bksxTjd6OVF3UzlzVFoyRFRmMVpQSG8v?=
 =?utf-8?Q?ptRFU7p+GeYhpNhQQMK+gdPI/CNMlpMRJ8TDBm2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CC53E458C661C48BD84854EDFE427F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b9e156-142c-4894-766d-08d8d944d9f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 04:21:41.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdMHA5noZz9LPh0wGbxQOxHPaCqganVM64Yi9xF5Z3GoxxqvWApd5nfWwRt+lEP5s7C9Vwuf4KQ1pjdgfFrF0BQeCoF0oE1D/leDUwtCnk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4168
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCk9uIDI0LzAyLzIxIDg6NTggcG0sIEthbGxlIFZhbG8gd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gPEFqYXkuS2F0aGF0QG1pY3Jv
Y2hpcC5jb20+IHdyaXRlczoNCj4gDQo+PiBGcm9tOiBBamF5IFNpbmdoIDxhamF5LmthdGhhdEBt
aWNyb2NoaXAuY29tPg0KPj4NCj4+IFVzZSBzYW1lIGNvb2tpZSBmb3IgcmVxdWVzdF90aHJlYWRl
ZF9pcnEoKSAmIGZyZWVfaXJxKCkgdG8gcHJvcGVybHkgZnJlZQ0KPj4gSVJRIGR1cmluZyBtb2R1
bGUgdW5sb2FkLiBmcmVlX2lycSgpIGFscmVhZHkgdXNlcyAqd2lsYyogaGFuZGxlciBzbyB0aGUN
Cj4+IGNoYW5nZXMgYXJlIHJlcXVpcmVkIGZvciByZXF1ZXN0X3RocmVhZGVkX2lycSgpLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEFqYXkgU2luZ2ggPGFqYXkua2F0aGF0QG1pY3JvY2hpcC5jb20+
DQo+PiAtLS0NCj4+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvbmV0
ZGV2LmMgfCAxNCArKysrKy0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21pY3JvY2hpcC93aWxjMTAwMC9uZXRkZXYuYw0KPj4gaW5kZXggMWIyMDVlN2Q5N2E4Li42NmY3
MjVhYWQyMDkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAv
d2lsYzEwMDAvbmV0ZGV2LmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hp
cC93aWxjMTAwMC9uZXRkZXYuYw0KPj4gQEAgLTI0LDEyICsyNCwxMCBAQA0KPj4NCj4+ICBzdGF0
aWMgaXJxcmV0dXJuX3QgaXNyX3VoX3JvdXRpbmUoaW50IGlycSwgdm9pZCAqdXNlcl9kYXRhKQ0K
Pj4gIHsNCj4+IC0gICAgIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSB1c2VyX2RhdGE7DQo+PiAt
ICAgICBzdHJ1Y3Qgd2lsY192aWYgKnZpZiA9IG5ldGRldl9wcml2KGRldik7DQo+PiAtICAgICBz
dHJ1Y3Qgd2lsYyAqd2lsYyA9IHZpZi0+d2lsYzsNCj4+ICsgICAgIHN0cnVjdCB3aWxjICp3aWxj
ID0gKHN0cnVjdCB3aWxjICopdXNlcl9kYXRhOw0KPiANCj4gTm8gbmVlZCB0byBjYXN0IGEgdm9p
ZCBwb2ludGVyLg0KDQpTdXJlLiBJIHdpbGwgc3VibWl0IFYyIHZlcnNpb24gZm9yIHRoaXMgcGF0
Y2ggYnkgcmVtb3ZpbmcgZXhwbGljaXQgY2FzdC4NCg0KUmVnYXJkcywNCkFqYXkNCg0KPiANCj4+
DQo+PiAgICAgICBpZiAod2lsYy0+Y2xvc2UpIHsNCj4+IC0gICAgICAgICAgICAgbmV0ZGV2X2Vy
cihkZXYsICJDYW4ndCBoYW5kbGUgVUggaW50ZXJydXB0XG4iKTsNCj4+ICsgICAgICAgICAgICAg
cHJfZXJyKCJDYW4ndCBoYW5kbGUgVUggaW50ZXJydXB0Iik7DQo+PiAgICAgICAgICAgICAgIHJl
dHVybiBJUlFfSEFORExFRDsNCj4+ICAgICAgIH0NCj4+ICAgICAgIHJldHVybiBJUlFfV0FLRV9U
SFJFQUQ7DQo+PiBAQCAtMzcsMTIgKzM1LDEwIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBpc3JfdWhf
cm91dGluZShpbnQgaXJxLCB2b2lkICp1c2VyX2RhdGEpDQo+Pg0KPj4gIHN0YXRpYyBpcnFyZXR1
cm5fdCBpc3JfYmhfcm91dGluZShpbnQgaXJxLCB2b2lkICp1c2VyZGF0YSkNCj4+ICB7DQo+PiAt
ICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gdXNlcmRhdGE7DQo+PiAtICAgICBzdHJ1Y3Qg
d2lsY192aWYgKnZpZiA9IG5ldGRldl9wcml2KHVzZXJkYXRhKTsNCj4+IC0gICAgIHN0cnVjdCB3
aWxjICp3aWxjID0gdmlmLT53aWxjOw0KPj4gKyAgICAgc3RydWN0IHdpbGMgKndpbGMgPSAoc3Ry
dWN0IHdpbGMgKil1c2VyZGF0YTsNCj4gDQo+IFNhbWUgaGVyZS4NCj4gDQo+IC0tDQo+IGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9saXN0Lw0KPiAN
Cj4gaHR0cHM6Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9kb2N1bWVu
dGF0aW9uL3N1Ym1pdHRpbmdwYXRjaGVzDQo+IA0K
