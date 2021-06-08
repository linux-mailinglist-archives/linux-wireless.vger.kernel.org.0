Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6F139F749
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhFHNHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 09:07:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:40620 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232339AbhFHNHA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 09:07:00 -0400
IronPort-SDR: 3ZaAnWK7BwI4NLJB74tDoPLcZyXZRd4RYjc1kzmo8KxToc3l2kQjwiAROdCBTASkbmmGzlhIRw
 6mOsiloGfzaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="204861604"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="204861604"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:05:06 -0700
IronPort-SDR: 2NyR5s/z6cd/UZQwvwfGcNzX2rKFFW9SYxe/uH3hyCvA8V0Na3qZ74fp0//yYUSnWwf7jCbI8X
 hLkxD2e018ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="635056920"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2021 06:05:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 06:05:06 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 06:05:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 06:05:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 06:04:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsMnkbL8vrmY4PQWzBVSDAmCnp5FXQywgBYTjlYMZehIh7Mi6oisHL76K5m6vxNsem1+CM0gV/nY84/A/BcbWjDv/l2JKx8u4GlJ9ObbAi6Xl3VMdO6fkww5veZfigIzTO0wTDYfmFzC0PiZNqhzxafczDIRZGUURAv+FJOh0M0+APIKJO7XdP2HszDw42ZOekzxz9uxgM3eLgJKnc43sGpoI/LjUPkPX5+pa+dXdF3Uq464B6IiYk2sLeTUH7eNbYCJIxNp94PztuXnKk3Cn7p2yRu3s6fJD2N32w4+oHhn/y4sjJqDXkkb+zbPXU0ihwDy1nIoVqcvghBqU1N+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA+08+xaldBRsbQFagZi4y2S9qUpJ0sYMJ+h9NYOjfk=;
 b=kWZHjlsNNjlYnoqCNqgH1p+xN8bbwyw40766qpr/g9r3UUxiZ0VGrV4Y9G+vGj/cwxoSyPEHwkJhWuVDd6f5yyhBmuNopoU+ZRFd3fAAeJACYh7tWpTMlpWx73IWUm0w+UuoGYVPXkYbc9ROal0dkKAOSdHbBpeN8OxpHW8vJ39tx+RBwmduRcCw6GMTHWqN+rfHcMSIWXmSwkIeUeH0nQxqpXLOApSvvn1SO+C5oOevIiKDPHvQRY9umjTu+CxselO5gQ95v6JYVXmZ4DkoYDcN7CkLG9NzN164bde0e0O24EgPEe/AXuh1T4k30xaC46kwEaONKB0UO5SMsZ4Zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA+08+xaldBRsbQFagZi4y2S9qUpJ0sYMJ+h9NYOjfk=;
 b=cRQmhU8Imna9pNOEruWjFGL2q26swcKg427jCtZRlSTKZQfn6NXjLHQTVBkObMrTEojsKiu6DqLv7RPGEmluixwZ33pUeSwrSZQoHT1ZYSQn0Dqqkq5KHoHKUDy5gLiwt/mm3XDJl+hJzg9w92Hc8RIUWG3yurwF9PT48wHu1jE=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BY5PR11MB3877.namprd11.prod.outlook.com (2603:10b6:a03:186::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 13:04:28 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::106d:d229:f71b:b34f]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::106d:d229:f71b:b34f%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 13:04:28 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [bug report] iwlwifi: support REDUCE_TX_POWER_CMD version 6
Thread-Topic: [bug report] iwlwifi: support REDUCE_TX_POWER_CMD version 6
Thread-Index: AQHWyVPm8LymXluzUEOtV//c2pB2jKsLOveA
Date:   Tue, 8 Jun 2021 13:04:28 +0000
Message-ID: <78208c3f9c689fe1b178f88fd14c59202f3a78e9.camel@intel.com>
References: <X8irC3FP0QDE9QFe@mwanda>
In-Reply-To: <X8irC3FP0QDE9QFe@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f97aa63-3a3e-486f-986e-08d92a7df2f1
x-ms-traffictypediagnostic: BY5PR11MB3877:
x-microsoft-antispam-prvs: <BY5PR11MB3877837044018145FA2F833A90379@BY5PR11MB3877.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ml0KAIAbcOVmb1KTzNyeyruj519HYUhIFVbacex2fDN+b9ED5bgQB9FtKp/AAvtKFJpgdiS+AS2Wjn+PTv/kv151AIqRgfnaMKEcX2YB/x4L5ysrER5B+AkrlTGB2BZi9b7XD1Cj5M98YRFNpxKgcJ6X3uRyPN8fcvmbZv/FTFuK7Fu11CdIk5LXXwpvNK0DiZTJDL7mC3cZk3kFUESEHpoGXhsYojWN0+2IoR3bBCzeYIm5hf2MhhBkRFIwghgxiTmMebkEAoReI5wu01zZb+5bipHtABRnFou783UTTVWrHTeUTgKrtO+k3ih46mFyVJRIbsYGzbzOXGWYiSNFHO32D/SWFoljnROEA8FWmMICueh4iG91UiUpPBPfihtui7b6v+yT1ltRnn9svcTWX3RM4Oi6o2tJcxxFpY0kcCapO32btbpleKmw9kuu+nuN6KBPr1bta2QLcWLN2u46tQoJrOLw19QswuiQn43fWGjyqn5zYBdHhUx/9DHkMZQ1D91+acoz8luGY/qyyzIzdHRbwpdUEq8fBZ1OgiztRwRabgzYvKZt1OoZZm0QOg0+QhiR01ncG2OF8KgNo+MO4xJ6urNvwbHI2T4EW6vV1gQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39860400002)(396003)(2906002)(71200400001)(36756003)(5660300002)(26005)(186003)(6506007)(6512007)(6486002)(8676002)(83380400001)(86362001)(8936002)(6916009)(122000001)(4326008)(66946007)(66476007)(76116006)(64756008)(66556008)(478600001)(38100700002)(66446008)(91956017)(316002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXRPbnB5KzBDYzZYTjc5QWlWZmdoUzlBQ2g1dys0OVQ3RmVFVTkrL200Q1ZD?=
 =?utf-8?B?V0ZnMm9pb0E5YlZnV241S3Z5V09pcm1oTVpKMFZIdXdGMWJORkZTZE1ISkt2?=
 =?utf-8?B?V3BoMDJWWUhiVnQ5S01jVmVFem95aUEzcHI3ZXpXdytLWGRId2dzMVVneDlh?=
 =?utf-8?B?K2JVbmFBMDlYaXErNTd3M0VoSjIyVStVTThVYlcycXQ2N29kMEdZYW1pV1Rx?=
 =?utf-8?B?dGhzZ3VjaUErYlJkTHo2Rkw5NTg3YWN0OGtSMDhlTWpWS3IvdlpVQzc2OTNn?=
 =?utf-8?B?cEg1VE9JMHNxTWxKN1FjMGV1LzYrVWNtdTlqQkZDTFlBaHJmNkJNeWVhR0h3?=
 =?utf-8?B?NTJaV0FYMFZrSzg1bXpmVHdac25SUitsNVRvTnNEY2NocXpqeTN1aVFRc3Rr?=
 =?utf-8?B?blBCb0ROaytBUEFjd3ZNTHdCalNtUTVmNTRxb1RrQU5ONVhaSlJ6bkg4VkJj?=
 =?utf-8?B?SGx1ZzNvbTBNNXpuQnQzSWhJcDl5UnNnVzNMeDdxaDVYbnJCUXJ0T2xQRGdU?=
 =?utf-8?B?RDVRbk1MbTI2aXBTZlhQRldTdGEvU291MVIyZzEydlhTenRBSGh2cnk1ZHN4?=
 =?utf-8?B?SWU5SnZwemQ0Z0Q4cnE2czJpQ0Y0U3Bad0doUlJKZTJCd0RzbzhEdkhsUWpr?=
 =?utf-8?B?WU5iZnhqM2hvVElRMkVZRU92bHBLR01oY2l3d052RXNTUXN0eUxWUUJBZkIr?=
 =?utf-8?B?bHlIaVRMK3NvUU1JRU00ZzRwRHhIcmdmQ1duL3dPNzkxNk5POUJ1U3ZpTm9H?=
 =?utf-8?B?R1MzamJvdHFjMzFBUDl4d3JXdmRDMzVQQW4vdngyYkdTYUNtVytYc1JpQkkx?=
 =?utf-8?B?WTgxajhjTStpNFNhRW1teEJRaGgrLzN0QnpZdkJGR25ISWFEWVh4R0hXTWNQ?=
 =?utf-8?B?UXFOblVVTWZJVFhHQS8xUmJQVXJwUUdWSHRlNzZrSjVJUzdqT3g2bjZWbnRH?=
 =?utf-8?B?M1hJWFZPd2h2VTJXL213Y0IzNlhhL3Z1WG5VeXZjYk8xU3c2T1ZUOXZNZFBI?=
 =?utf-8?B?VHpkVDVzTEt3UmJmem5pSmVUUE5aWDMvL0pqTE9TUEt6eEN6dUlpb0gxTDY1?=
 =?utf-8?B?ME9xc0ZmZ2doOUNLazM3ZzNpdm8xdDByakJiK2Y4dWxXYjE4UGtSdThIV3l4?=
 =?utf-8?B?bStBWi9Yd1RZL0RJNGtVQjNoNVpRQ0ZrRjBlWHh4TzV2TEFUWmNZeXQrQlNB?=
 =?utf-8?B?OFIwdURWYndoWnY5eE5jMmR0KzI0LzN6VWRzQmo4V1Ruc0I0ZElVUWxnTVJO?=
 =?utf-8?B?NG9aSElmSzZNdFFPakFiUXd0SUllM1VpbGs4UFErb3l0ZmFlMUdSYlkwOUt1?=
 =?utf-8?B?TGd3Z3ZmVlg3T1ZsVGpJeFpFWE9EeEU0S2phWFhKaW41UmdkS3NHTmJLV3BD?=
 =?utf-8?B?OVpONWpOOWF6NkZqM0owRCs2R0dIZ2hwdlRlTGlQODhZY1pmZ29UeGxCQVBR?=
 =?utf-8?B?N1E5WW42ZUw4ZFlSRFhsei9Wa3JVMm80MUNFUFhlcGFrVUVZT2VEM2xDczJ5?=
 =?utf-8?B?dkJMK2RrZzlkTHdUWmd5V282UWo2aTMyUG9oaWJqRUxPT1VhR0RIVDhPR1ha?=
 =?utf-8?B?aWVXcU5ra2lIaTlHTldlNHNjMU5pSWhJQ1JEN3pFT2JCM242RkhIVlZ3T1c4?=
 =?utf-8?B?aHNsbFdLL1FJNkRiN01zL3JJTFVXc0JnbmJpK3g2L25xZ1p5YzlvUUlXZDFC?=
 =?utf-8?B?Q2N2UVUzZFlLM25NMUVTSHlZSGh4Rm13M3RITldIcGloV1RTQlZKcFhwRGVs?=
 =?utf-8?Q?yVCscgzv7VzyPwRLmP/JpnE4NClGucqOOJ/jhpZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <111DF6E774DE0444A1E63A1E30E0C249@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f97aa63-3a3e-486f-986e-08d92a7df2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 13:04:28.4114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQYMWpwSI3yh7QC8hfhXbCgsoZnNbwgUvVK4LguJFFk2cvpoJR3U+BF8oBj9jbZPbdXfhMJGvo3XRc0AplexI7ajIDkXrrELg9baYDxDoRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3877
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDEyOjA4ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBIZWxsbyBMdWNhIENvZWxobywNCj4gDQo+IFRoZSBwYXRjaCBmYmI3OTU3ZDI4YWM6ICJpd2x3
aWZpOiBzdXBwb3J0IFJFRFVDRV9UWF9QT1dFUl9DTUQgdmVyc2lvbg0KPiA2IiBmcm9tIFNlcCAy
OCwgMjAyMCwgbGVhZHMgdG8gdGhlIGZvbGxvd2luZyBzdGF0aWMgY2hlY2tlciB3YXJuaW5nOg0K
PiANCj4gCWRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYWNwaS5jOjQ2MiBp
d2xfc2FyX2ZpbGxfdGFibGUoKQ0KPiAJZXJyb3I6IGJ1ZmZlciBvdmVyZmxvdyAncHJvZi0+dGFi
bGUnIDEwIDw9IDE1DQo+IA0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3
L2FjcGkuYw0KPiDCoMKgwqA0MjIgIHN0YXRpYyBpbnQgaXdsX3Nhcl9maWxsX3RhYmxlKHN0cnVj
dCBpd2xfZndfcnVudGltZSAqZndydCwNCj4gwqDCoMKgNDIzICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBfX2xlMTYgKnBlcl9jaGFpbiwgdTMyIG5fc3ViYmFuZHMsDQo+IMKgwqDCoDQy
NCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHByb2ZfYSwgaW50IHByb2ZfYikN
Cj4gDQo+IE9yaWdpbmFsIG5fc3ViYmFuZHMgd2FzIEFDUElfU0FSX05VTV9TVUJfQkFORFMgKDUp
IGJ1dCBub3cgaXQgY2FuIGJlDQo+IElXTF9OVU1fU1VCX0JBTkRTX1YyICgxMSkgYXMgd2VsbC4N
Cj4gDQo+IMKgwqDCoDQyNSAgew0KPiDCoMKgwqA0MjYgICAgICAgICAgaW50IHByb2ZzW0FDUElf
U0FSX05VTV9DSEFJTl9MSU1JVFNdID0geyBwcm9mX2EsIHByb2ZfYiB9Ow0KPiDCoMKgwqA0Mjcg
ICAgICAgICAgaW50IGksIGosIGlkeDsNCj4gwqDCoMKgNDI4ICANCj4gwqDCoMKgNDI5ICAgICAg
ICAgIGZvciAoaSA9IDA7IGkgPCBBQ1BJX1NBUl9OVU1fQ0hBSU5fTElNSVRTOyBpKyspIHsNCj4g
wqDCoMKgNDMwICAgICAgICAgICAgICAgICAgc3RydWN0IGl3bF9zYXJfcHJvZmlsZSAqcHJvZjsN
Cj4gwqDCoMKgNDMxICANCj4gwqDCoMKgNDMyICAgICAgICAgICAgICAgICAgLyogZG9uJ3QgYWxs
b3cgU0FSIHRvIGJlIGRpc2FibGVkIChwcm9maWxlIDAgbWVhbnMgZGlzYWJsZSkgKi8NCj4gwqDC
oMKgNDMzICAgICAgICAgICAgICAgICAgaWYgKHByb2ZzW2ldID09IDApDQo+IMKgwqDCoDQzNCAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FUEVSTTsNCj4gwqDCoMKgNDM1ICANCj4g
wqDCoMKgNDM2ICAgICAgICAgICAgICAgICAgLyogd2UgYXJlIG9mZiBieSBvbmUsIHNvIGFsbG93
IHVwIHRvIEFDUElfU0FSX1BST0ZJTEVfTlVNICovDQo+IMKgwqDCoDQzNyAgICAgICAgICAgICAg
ICAgIGlmIChwcm9mc1tpXSA+IEFDUElfU0FSX1BST0ZJTEVfTlVNKQ0KPiDCoMKgwqA0MzggICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiDCoMKgwqA0MzkgIA0KPiDC
oMKgwqA0NDAgICAgICAgICAgICAgICAgICAvKiBwcm9maWxlcyBnbyBmcm9tIDEgdG8gNCwgc28g
ZGVjcmVtZW50IHRvIGFjY2VzcyB0aGUgYXJyYXkgKi8NCj4gwqDCoMKgNDQxICAgICAgICAgICAg
ICAgICAgcHJvZiA9ICZmd3J0LT5zYXJfcHJvZmlsZXNbcHJvZnNbaV0gLSAxXTsNCj4gwqDCoMKg
NDQyICANCj4gwqDCoMKgNDQzICAgICAgICAgICAgICAgICAgLyogaWYgdGhlIHByb2ZpbGUgaXMg
ZGlzYWJsZWQsIGRvIG5vdGhpbmcgKi8NCj4gwqDCoMKgNDQ0ICAgICAgICAgICAgICAgICAgaWYg
KCFwcm9mLT5lbmFibGVkKSB7DQo+IMKgwqDCoDQ0NSAgICAgICAgICAgICAgICAgICAgICAgICAg
SVdMX0RFQlVHX1JBRElPKGZ3cnQsICJTQVIgcHJvZmlsZSAlZCBpcyBkaXNhYmxlZC5cbiIsDQo+
IMKgwqDCoDQ0NiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByb2Zz
W2ldKTsNCj4gwqDCoMKgNDQ3ICAgICAgICAgICAgICAgICAgICAgICAgICAvKg0KPiDCoMKgwqA0
NDggICAgICAgICAgICAgICAgICAgICAgICAgICAqIGlmIG9uZSBvZiB0aGUgcHJvZmlsZXMgaXMg
ZGlzYWJsZWQsIHdlDQo+IMKgwqDCoDQ0OSAgICAgICAgICAgICAgICAgICAgICAgICAgICogaWdu
b3JlIGFsbCBvZiB0aGVtIGFuZCByZXR1cm4gMSB0bw0KPiDCoMKgwqA0NTAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqIGRpZmZlcmVudGlhdGUgZGlzYWJsZWQgZnJvbSBvdGhlciBmYWlsdXJl
cy4NCj4gwqDCoMKgNDUxICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gwqDCoMKgNDUy
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4gwqDCoMKgNDUzICAgICAgICAg
ICAgICAgICAgfQ0KPiDCoMKgwqA0NTQgIA0KPiDCoMKgwqA0NTUgICAgICAgICAgICAgICAgICBJ
V0xfREVCVUdfSU5GTyhmd3J0LA0KPiDCoMKgwqA0NTYgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAiU0FSIEVXUkQ6IGNoYWluICVkIHByb2ZpbGUgaW5kZXggJWRcbiIsDQo+IMKgwqDC
oDQ1NyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGksIHByb2ZzW2ldKTsNCj4gwqDC
oMKgNDU4ICAgICAgICAgICAgICAgICAgSVdMX0RFQlVHX1JBRElPKGZ3cnQsICIgIENoYWluWyVk
XTpcbiIsIGkpOw0KPiDCoMKgwqA0NTkgICAgICAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwg
bl9zdWJiYW5kczsgaisrKSB7DQo+IMKgwqDCoDQ2MCAgICAgICAgICAgICAgICAgICAgICAgICAg
aWR4ID0gaSAqIEFDUElfU0FSX05VTV9TVUJfQkFORFMgKyBqOw0KPiDCoMKgwqA0NjEgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBlcl9jaGFpbltpICogbl9zdWJiYW5kcyArIGpdID0NCj4gwqDC
oMKgNDYyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdV90b19sZTE2KHByb2Yt
PnRhYmxlW2lkeF0pOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoF5eXl5eXl5eXl5eXl5eXl4NCj4gQnV0IHRoaXMgdGFibGUgc2l6ZSB3YXNuJ3QgaW5j
cmVhc2VkIHNvIHBvdGVudGlhbGx5IHdlJ3JlIHJlYWRpbmcgYmV5b25kDQo+IHRoZSBlbmQgb2Yg
dGhlIGFycmF5Pw0KDQpUaGlzIGlzIGEgZ29vZCBjYXRjaCEgVGhlIGludGVudGlvbiBvZiB0aGlz
IHBhdGNoIGlzIHRvIHN1cHBvcnQgdGhlDQpsYXJnZXIgc3RydWN0dXJlcyBpbiB0aGUgRlcsIGJ1
dCBub3QgZnJvbSBBQ1BJLiAgU28gdGhlIHNvbHV0aW9uIGZvcg0KdGhpcyBoZXJlLCB3b3VsZCBi
ZSB0byBjaGVjayBpZiBqIGlzIGxhcmdlciB0aGFuIEFDUElfU0FSX05VTV9TVUJfQkFORFMNCih3
aGljaCBpcyB0aGUgbWF4IEFDUEkgdGFibGUgd2Ugc3VwcG9ydCkgYW5kIGp1c3QgZmlsbCBpbiB3
aXRoIHplcm9zIGluDQp0aGF0IGNhc2UuDQoNClRoaXMgY29kZSBoYXMgYWxyZWFkeSBiZWVuIHJl
ZmFjdG9yZWQgaW4gb3VyIGludGVybmFsIHRyZWUgKGFuZCB3aWxsIGdvDQp1cHN0cmVhbSBzb29u
KSB0byBzdXBwb3J0IHRoZSBmdWxsIHNpemUgdGFibGUgZnJvbSBBQ1BJIGFzIHdlbGwuICBCdXQN
CnNpbmNlIHRoZSBjaGFuZ2VzIGFyZSBub3Qgb25seSBmaXhpbmcgdGhpcyBidWcsIEknbGwgc2Vu
ZCBhIHNlcGFyYXRlDQpidWdmaXggZm9yIHRoZSBtYWlubGluZSBmb3Igbm93Lg0KDQpUaGFua3Ms
IERhbiENCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
