Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79143B2765
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 08:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhFXGdL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 02:33:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:42333 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhFXGdL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 02:33:11 -0400
IronPort-SDR: b7yfDOThbs2G0SZf14lpD2I/MrZcORzBDVmQoRTcvYhHtUBvujHoPoR2v/tYNTlOCSIB0dI1z2
 /RrRCKQVogew==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="228991060"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="228991060"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 23:30:50 -0700
IronPort-SDR: +YsJptmF2FUhXB1WH7jGYG+7vV7q1E27tjAIzK59IEzYPx/nd8t010zmhXyMulc1MmkLtb0ZXB
 UJOtTZtoF3bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="417968298"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2021 23:30:50 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 23:30:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 23 Jun 2021 23:30:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 23 Jun 2021 23:30:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uw8hz80PuHHvO2HqT4Ip6zsX7uJqjCVLZIIYVB2d5NPec8tjlUiQ5B4uif4nd0xuipwt7r11XzN0KA4TmVfEPnE9F7E4SPe3+Xd1qrbzS03dqai9K9LLiCN2h/asH3LCnTbYv3rm7ubuyjXfF93m5YPQff8rZqB16rA6BWgRyBeVTCJSzzflLGgKIU1AE/sotIwYx6JejCJE54i4/7MCuM/j6dCnsGzjxbkRPKNJdfnREhd34DfSuTLuobQZIZCST9KzG/HhH33t2Gto6UgDdUSUq4EOOk4wLWNEYPG7VeKQEjV8IMdisiM4eqybkV+w800eh7jA9q5tmvTIIQINFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVZZH3uUX3DcrAwLLeLhj3nAAAt0m9ZEYEwqZ5UkDWc=;
 b=NvIUH+cusqTx6W4TT3tYpsjrdBInroLz47xBTEtOvV1kyMD9Io1rO3evB5mp+wHhHsv+j7/ypwarxFGE/gXZmTK5P0WFSucuHL9NeLJwm2XWTtrArhsaJDC40vtvRSKnG0eTHPG6ds2sDYlK53SbzZxSGICl55LTpGzTfg3msAmVvWC6BmHxZLjB0v795X55wwBgiOyjqfkGrJZqs3ZNL9RUfXeSDx5BW3DDNiBWIjnl6vv8RqLP3KP7qNNWMqVn4Yjah+BxLAQDR/yrnN+nhayl7zO/HF2afqGzQi3mtd6ojmmZNQE2AVObOUn7cFD9PVYJLKYxAV/wioI9thHThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVZZH3uUX3DcrAwLLeLhj3nAAAt0m9ZEYEwqZ5UkDWc=;
 b=s3Fzw0SRj0jqXs9Q5C/dvrwQvsd0GR5v497k3yloGoHvSFs2VKH1O8lnZIGC6kxHCjw0r7mocC7Gu0E6GxmIWiL9z/E0MBPU7PGAGhlBF9cV/KJJwYb9p7AeTKVtbMbQ3uolVNAIgieeOG20tqRwxYaRwHhRgO8HvMMJ0K83Y0w=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 06:30:47 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5c60:81c3:b049:887f]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::5c60:81c3:b049:887f%6]) with mapi id 15.20.4242.024; Thu, 24 Jun 2021
 06:30:47 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] iwlwifi: acpi: remove unused function
 iwl_acpi_eval_dsm_func()
Thread-Topic: [PATCH] iwlwifi: acpi: remove unused function
 iwl_acpi_eval_dsm_func()
Thread-Index: AQHXaLnz98GkmmvJAkyVYslshm7HJasis3iA
Date:   Thu, 24 Jun 2021 06:30:46 +0000
Message-ID: <14e38a13437e87e678576a58bf2b3ae0efa7f987.camel@intel.com>
References: <20210624052918.4946-1-kvalo@codeaurora.org>
In-Reply-To: <20210624052918.4946-1-kvalo@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fda2467-a306-4e95-2b5a-08d936d99a84
x-ms-traffictypediagnostic: SJ0PR11MB5056:
x-microsoft-antispam-prvs: <SJ0PR11MB50563D738131D9876284489A90079@SJ0PR11MB5056.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h9EG9z5kaKcAmVHKXkeM6ZuBieCZuRUUTEqlpu2pS1Nq+QfdlMXuQCM6eYxh/mR2b39VsMO35vB85YBjtCvBkoWzbtXOoTpjXNgqi8LVtX1VLC82UBYuVMQYbgpdyZAlaw+6QeWyeURhUV41IAB3ypWcPlT61uiJB0Q18MYPrD1jxrNSPuuUcufUKOFYsFPLY7+5vM1CZY+rNwoCp1maxkJ0Kb8JA2r6izWTx3r3tQlLqjBTVV5rXTBJdT4bjuVQhC8gPcgA8eTG1V9jEuIOlxQw9t8vBSE08dRUwnrsbffbHZlqJrrF69XH0QmNZNug/sVms7loAVC581t+htE0sgjr86vhiq2DNBsuoeyo66BcIhZXQTH+cxalx7fJl51GnTINfqn0lLGjQWoeLwt173KP2q6V8X2s+oWkRRetKSOB+wiN1ommepHdO2amiCggpjPQ0PqchKsF2ATbRNLvVxB8tz/iyfPWPlWQJXYq1KU1rWBi2PSk7/usRiosocwfZJAfYTWKg7c+gOkCQ8y3ZqKoV5RMXGRqCmNa84XR8Wt/7SR/zDusrQ+4bw0WTUpISncf4vURP/GTE6L4Fkc/mLHA2159mgGTz8bI/p0ZalZAEZ5xPP40hNI9ssjaVxU44v4iOkK8CUkvTcceBWghcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(366004)(346002)(478600001)(8676002)(38100700002)(122000001)(36756003)(86362001)(6486002)(8936002)(83380400001)(71200400001)(2906002)(91956017)(186003)(6512007)(66556008)(66946007)(66476007)(64756008)(66446008)(4744005)(5660300002)(2616005)(110136005)(76116006)(316002)(4326008)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2pIN1FhTzcrS21nSXRLSjhNcnM4UlpsV1lwOUdXZkozS2tSeDltZmczZWRz?=
 =?utf-8?B?RVpwTjljU0ZpeFBtdk5RRStSWkZtczFabFdKYWI4RVpndWpvNkhJc2ZJdTNi?=
 =?utf-8?B?NUpMU01Xb01FNWhBTlFkWTc2ajVEMEtFQk5rVlUzTEdxUlBzRmJnQWdnSkQr?=
 =?utf-8?B?bklleDlWOXN2MW1xcmFqNDExYnh6NFVQN1c4UGp2TmszQ2hsRVpra0xROUlk?=
 =?utf-8?B?bC9NcE9sNi8zK1Rsd2lMNG1Qd3ZMS0xtODBvN0FzbkE5WU9QdDZ0cFF0aUVK?=
 =?utf-8?B?M2FTZXdCU2pob0RjbTRPaXFGN3JaMXpoVmZicmVXUkY5QytVTzNjL3paUjhU?=
 =?utf-8?B?UmVQcVpCcGtVTkVSTFZjNVo3dFhuMGF6SHZKU1BtSHRIZGxPcWpaT29jZ2tn?=
 =?utf-8?B?a1QzbHIzV3dWK1RQVUVGbnd6NWN3Ync5Z29xUnREc0FjQThGUmc5aEo3NHY3?=
 =?utf-8?B?Sm9pUkhuZExIY0tjTGV2RFdTSGNBczMxakZBT29jTjdPSGd6OEJybUJmZ1hh?=
 =?utf-8?B?ZTlXNmZXQ3E5cm1ETnhYQklhQ2svQ2hiS1l4QkJYSmlCSVROZjJZQXQxMWhx?=
 =?utf-8?B?clJVM3Y3QXRZd0Y4VHZVZlNjbDM4OWFHK3JUUjJGbUJuUitFL21vNVZ1K1VU?=
 =?utf-8?B?OHl1QzRTckNEbm5nVkxReVRoYjBRaHU5cWxNeHNVUVZjcmo0VWgyajRKTys3?=
 =?utf-8?B?c2xZc2FaV2RoakRLWllWNnYvR3pyb0ViZzJaVWl0NEFTN0xHNGkrQmZCKzF4?=
 =?utf-8?B?Tzh3TVE5a1Izdld2enJnR3E2V2VBWWJkY2IyRU9hM3RUWU9XcHFaamxJNDBr?=
 =?utf-8?B?SnEwWklBaVpTc3Ftd0FPTUticnZFRi9WNzZkb3BoTFJLWFY3WHg1a21MUGlr?=
 =?utf-8?B?eG1ONHBYUmxmREJWS0p6VGF3S2szdkg2RTA2cnFhRkpYT2JIZTVjeHBQTUlM?=
 =?utf-8?B?VGEySWc2dmRWM2NwcXo0WFhJOGtxOTVNQ2NOQ052bU1hUXN6a2lJTEMxK2pV?=
 =?utf-8?B?UGxDOHFnM1pOR21vaCtBdEtQQVQ2cExNZ05Tc2MxMTRHMWlVK0dGL1RRR2FJ?=
 =?utf-8?B?dk53clBOVTBjM1lpL2pjeXNFbEJIbEtsODBXdFQ0OFF0L04xVm8rSjFhR29D?=
 =?utf-8?B?Vk9wUjZFYWU3cFhIQzFOQXdpd3V4TzE2NGJCYzQvbEZtRTAyZDJvaGY0L3J3?=
 =?utf-8?B?OElrTWZtQnBJS3M4WmpnSlQzL2xYMklKT2kwWGg0OFN1bjQ4aU1jOW5aakNa?=
 =?utf-8?B?c0orV2lkN0JmRUxOM3ZBYkZkV2F1VFBjVmVoays1MlRrUDJUczFWdStFMlp4?=
 =?utf-8?B?RFVUZ1JqWWRnQ2QvZTc1L1BTZDNQQUhESkZNcmVQTkJvY0hhV1Y2Qm1QMjl3?=
 =?utf-8?B?aDhrZlgrVFZjcnpDQ0d5dlhTSjJBcFJ5c1dtdVZuTWRIaS9NRXdSbE5lYzhZ?=
 =?utf-8?B?MjVHaEdaUVhUZi9reXRrbEpyVi9nblU2S0Zyc3JCUTEvdmd3TnJYcjRKZlhX?=
 =?utf-8?B?NUp2aXBJTWxON2p5cllsZ21CcW9ndDg2clViZWFJR2RjWkQ5UUtsVG0xRHJm?=
 =?utf-8?B?OFltNUplWHdxOXpIMTdsSnlraU9vdWo4dFpEbkY4alovS1p2OWJZZ0JIQ3VQ?=
 =?utf-8?B?MWFRbmRDcXlXd2Jibm9hZkhmQkQ2bGREbS9Cajd5QTMrUE5TV0kvQllIK3JT?=
 =?utf-8?B?c2xrU0VTMjE2RElrTDZZcjF4cENabE9aRUxCanJydE9USmN6UWdaK0xpcGtx?=
 =?utf-8?Q?RzePQ8Vi9ZfppCW+5ssspBaCEu1p171bC9Ui6xm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <71C9556C8A86A046BDC4691C0202FCF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fda2467-a306-4e95-2b5a-08d936d99a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 06:30:47.6213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6t6EjRswLBIh4vhQpepvRi6DXKvpam5Zir1oy4M7UHwCb2Mt5W0YbugjyUtSttHMzeNYdLhiFguaK658Uwp0LddAd4VYuKGzC4U82EzWjZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTI0IGF0IDA4OjI5ICswMzAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBT
dGVwaGVuIHJlcG9ydGVkIGEgd2FybmluZzoNCj4gDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvZncvYWNwaS5jOjcyMDoxMjogd2FybmluZzogJ2l3bF9hY3BpX2V2YWxfZHNt
X2Z1bmMnIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0NCj4gDQo+IFRo
ZSB3YXJuaW5nIGlzIGNvcnJlY3QgYW5kIHRoZSBmdW5jdGlvbiBpcyBub3QgdXNlZCBhbnl3aGVy
ZSwgc28gbGV0J3MNCj4ganVzdCByZW1vdmUgaXQuDQo+IA0KPiBSZXBvcnRlZC1ieTogU3RlcGhl
biBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+DQo+IEZpeGVzOiA3MTE5ZjAyYjVkMzQg
KCJpd2x3aWZpOiBtdm06IHN1cHBvcnQgQklPUyBlbmFibGUvZGlzYWJsZSBmb3IgMTFheCBpbiBS
dXNzaWEiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBLYWxsZSBWYWxvIDxrdmFsb0Bjb2RlYXVyb3JhLm9y
Zz4NCg0KTG9va3MgY29ycmVjdCEgVGhpcyB3YXMgYSByZWJhc2luZyBpc3N1ZSBiZWNhdXNlIEkg
c2VudCBzb21lIHBhdGNoZXMgaW4NCnRoaXMgYXJlYSBhcyBmaXhlcyBhbmQgb3RoZXJzIGZvciAt
bmV4dC4NCg0KVGhhbmtzLCBLYWxsZSBhbmQgU3RlcGhlbiENCg0KQWNrZWQtYnk6IEx1Y2EgQ29l
bGhvIDxsdWNpYW5vLmNvZWxob0BpbnRlbC5jb20+DQoNCi0tDQpDaGVlcnMsDQpMdWNhLg0K
