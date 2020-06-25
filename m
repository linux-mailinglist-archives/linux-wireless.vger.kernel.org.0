Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12B209BA7
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbgFYJBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 05:01:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:38918 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388485AbgFYJBo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 05:01:44 -0400
IronPort-SDR: w/pvEzFW1dhbOIHLYRDJwj3PYHXRAsXC995cFXTbKx/uLJnZTF8CfVDkFff/zsXWNL5qfPQGz9
 SveXtNXmIgRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="124467409"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="124467409"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 02:01:42 -0700
IronPort-SDR: Ec4YVkCesz6BcDhnJqKXaJ9AoA2af+r0gwV7t0h1zXZr8+3r/QwuW74BctE+Melboa6H5huz/2
 03nc4VsSrvmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="265302076"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2020 02:01:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 25 Jun 2020 02:01:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jun 2020 02:01:32 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jun 2020 02:01:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 25 Jun 2020 02:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBOVlu1HlXYRnGulAi3ZpePPrPABlFaLOfcIPSQ8K9ohkAGcu4x3TExIaT1pek9aWl1q9Foe9VEnVR20tPUmJj9oO4cssCvQPMjviov7a5OZ3ZmQWCKoiCY7B7clCDaMzLn1pK5VL77pRylRbEvEyOg6vIc4O+rqqyvb4w2LwReuGKNIWgwHWVIC2s5dxF3M19JdsU4XERT3wuYh91nc5rJqT11VJpVFMHV5R4zC9wZnVlPoosD24JQCEjdM4uv/ywWLxXtYulbaQHQjfYHzWlldk2HxC7QAd7EfT9HxkS19y/pGKyM3rUXGfcfA+9yxH27dLJFW5HXjSuOCT4y0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfjmVq/tw5WeIBeXOqmtGwdNoStewAdYYoHC1xRcUP4=;
 b=ReMIya5woio2qF5b4nW0CDyMQ6A92BKkeRxdfXlGccpD4oq9OTKYhqSRoskaVfFKXOniVRodwBiYnaljEhbrHkC+6mAtKYuWVtLxtJzP13a9EcXwh1vo8jTvWaxriMlfKOVCk8kZ/3sqJxKwrD7rHy4OGAETL/KzKb784/E6+RHenDUhVEZnvNUW4EnLgmzc1bo4+QHvcLas+aFl2YFcTtlq2q+lyEiKqDJbPG0y0u1o6j+vMZFZSDaKlOp8ruE/Ay050A4vAZcZBAIrbSA9YAt8Ze4ECJbkBPuhJWhNy/j97rLva0RHG3e+M9zZv9xyea7vGq05Tdmsquu+ImJ1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfjmVq/tw5WeIBeXOqmtGwdNoStewAdYYoHC1xRcUP4=;
 b=uqOAcD+1IHyVGyUgvSNof9sTIKDC4bx216xVkIriWKzAPRpjnucLVMpaL6dwcshrg5e4ctdB6l8uqzK+SP9olSggbr41vwyviVvgKUqDl/5XiJbmnTmzTRdT2UPqhyiOFOV9C35ZejZibHlTJgYKppGUjp1XGDNstTMHFEstwqI=
Received: from BYAPR11MB3304.namprd11.prod.outlook.com (2603:10b6:a03:7a::21)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 09:01:31 +0000
Received: from BYAPR11MB3304.namprd11.prod.outlook.com
 ([fe80::2d25:8f8d:97e8:61e2]) by BYAPR11MB3304.namprd11.prod.outlook.com
 ([fe80::2d25:8f8d:97e8:61e2%4]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 09:01:31 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luca@coelho.fi>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] cfg80211: flush scan entries upon suspend
Thread-Topic: [PATCH] cfg80211: flush scan entries upon suspend
Thread-Index: AQHWSsxTeNrWdrwBXEqyKt+JrsXyJ6jpCBRg
Date:   Thu, 25 Jun 2020 09:01:31 +0000
Message-ID: <BYAPR11MB33049BD6B05A6DF080026265F2920@BYAPR11MB3304.namprd11.prod.outlook.com>
References: <iwlwifi.20200623211013.df306f28bb0f.Ib56a98fa55090cc2d9952463f2c292a0a101f3cb@changeid>
 <b57135152b6d88729b23d9a8d9726a59f0ed44cc.camel@sipsolutions.net>
In-Reply-To: <b57135152b6d88729b23d9a8d9726a59f0ed44cc.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.233.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fbc01b5-5dc0-468f-27cf-08d818e65a9e
x-ms-traffictypediagnostic: BY5PR11MB4226:
x-microsoft-antispam-prvs: <BY5PR11MB4226023BBF556F7B60CCC3B5F2920@BY5PR11MB4226.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1VeSXEtUfVYj5VJiS96U4XthEqn/p18Nm1WCUrnhP+kwpe+qInx/Xd0YTlLT+QhCsXl2M8EY7q3b66KeGtwXTtfPq2/dphkGbJyo81aEGMjbi6MaVSVGS9CgY/sTVlkv5Bbo1lFCE9DhpP32iBKmdbFbsb3KqN0wGq80Rh5IP62PVkBdfKCcgWw9nxRNPe2iktitEdqWUXBI58Q9Xo9XFTMU7NAkmgvW374r9q5K8ec1LL4JSCZyWXpa7L5xGC0ltR2PfOoczFSNiWAZNyh52kFPasRc6cuM1nBCnRFdd7vxOXUKVwZWgBBrwKh0p1fbWC7LOUsKF7X2oqNQ5D1aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(186003)(15650500001)(110136005)(71200400001)(9686003)(33656002)(6506007)(2906002)(4326008)(7696005)(55016002)(478600001)(52536014)(8676002)(86362001)(5660300002)(76116006)(316002)(26005)(66476007)(66446008)(64756008)(8936002)(66946007)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tGcIqW2hDcKYcoLvWF3u2M46ZUf4CcKu2LtO0fj30a6O7v2Do9FfqK5sAt6ZFZKh9TX/0ee8c5hbfM60pi38xvOZnyhgS2zomvLV+MIZOStyM3iE/F9iz6t7E8ztPZ0WxLS07E9X/kvaW0ouAsD5lh17gZpyEHoWFbcAO/NFgwLWwJEq8YNIMtNAeVv5Vvm4Spt+1KyZ9S1j6g7F/urR93JYaxsAUZsdCVGh1L2qDxnxxnO/vfS33ywecchsUudkCJZ/wEphiSuioZBImPUJJVzWdbUdtYnYDyzEh/Lh1YSrc08w5yUChb+Zlvpv7INqgpAlUaf7bxHvu7Gq3zWDRW0vqDzW028xY6E3qU/pbYcO6jDfSwqGgH8EizwAL5K/49YhoBSwIU5ZbdXqoIXGi4MrI3j+gnDrtCemImDqqAtE4NS5gOCyrSE2jDH0qoPH3DjVZ1IbKMxYaCwqkPsMN93V+89uvSltsqnIbQu+sCNoT7TKE4WYtTCvHaxh03ju
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbc01b5-5dc0-468f-27cf-08d818e65a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 09:01:31.3085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vxjt1qOgsU00eGi7b57HVkDH4h2V9V4V7VeXxyrul1BposNxqvr+HiS6xkAl5uC04zAn+Afe/ssE6dFleEBkzNg0ztSAIQtXfbjNjHvdkhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
X-OriginatorOrg: intel.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBPbiBUdWUsIDIwMjAtMDYtMjMgYXQgMjE6MTAgKzAzMDAsIEx1Y2EgQ29lbGhvIHdyb3RlOg0K
PiA+IEZyb206IEVtbWFudWVsIEdydW1iYWNoIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+
DQo+ID4NCj4gPiBXaGVuIHdlIHN1c3BlbmQsIHdlIGNhbid0IHJlYWxseSByZW1lbWJlciBvdXIg
QlNTIHRhYmxlLg0KPiANCj4gU3VyZSB3ZSBjYW4uIFdlIGRvIHRvZGF5IDotKQ0KPiANCj4gWWVz
LCBJIGtub3cgd2h5IHlvdSB3YW50IHRoaXMgZm9yIGl3bHdpZmksIGJ1dCB0aGlzIGNvbW1pdCBt
ZXNzYWdlIGlzbid0DQo+IGdvb2QuIEFuZCBpZiB5b3UgaGFkIGEgZ29vZCBjb21taXQgbWVzc2Fn
ZSwgeW91J2Qga25vdyB0aGF0IGl0J3MgYWN0dWFsbHkNCj4gb25seSBuZWVkZWQgZm9yIGl3bHdp
ZmksIG5vdCBmb3IgYmFzaWNhbGx5IGFueW9uZSBlbHNlLg0KDQpJIGFncmVlIHRoZSBjb21taXQg
bWVzc2FnZSBpc24ndCBzdWZmaWNpZW50IGFuZCB3YXMgIHdyaXR0ZW4gcXVpY2tseSB0byBnZXQg
dGhlIGJ1Z2ZpeCBpbiwgSSBzaG91bGQgaGF2ZSByZXdyaXR0ZW4gaXQgYmVmb3JlIGdldHRpbmcg
aXQgcHVibGlzaGVkLg0KDQo+IA0KPiBBbmQsIGluIGZhY3QsIGl0J3Mgbm90IGV2ZW4gbmVlZGVk
IGZvciBpd2x3aWZpIGJlY2F1c2UgaWYgeW91IGhhZCBXb1dMQU4NCj4gdGhlbiB0aGUgZmlybXdh
cmUgc3RheXMgcnVubmluZyBhbmQgeW91IGRvbid0IG5lZWQgaXQuDQo+IA0KPiA+IFB1cmdlIGFs
bCB0aGUgZGF0YS4NCj4gDQo+IFdlIGFnZSBpdCBhbHJlYWR5IHNpbmNlIGNvbW1pdCBjYjNhOGVl
YzBlNjYuIFRoYXQgc2hvdWxkIGJlIHN1ZmZpY2llbnQgZm9yDQo+IG1vc3QgZGV2aWNlcy4NCj4g
DQo+IEFuZCBpbiBmYWN0LCBpZiBpdCB3ZXJlbid0LCB0aGVuIHRoaXMgc2hvdWxkIGhhdmUgcmVt
b3ZlZCB0aGUgYWdlaW5nIHRoYXQncw0KPiBub3cgY29tcGxldGVseSBwb2ludGxlc3MgOikNCj4g
DQo+ID4gRXhwb3J0IHRoaXMgZnVuY3Rpb24gdG8gYWxsb3cgZHJpdmVyIHRvIHB1cmdlIHRoZSBC
U1MgdGFibGUgaW4gY2FzZQ0KPiA+IHRoZXkgZmVlbCB0aGUgbmVlZCB0by4NCj4gPiBpd2x3aWZp
IHdpbGwgbmVlZCB0byBkbyB0aGF0Lg0KPiANCj4gSSB0aGluayB3ZSBzaG91bGQganVzdCBoYXZl
IGEgcGF0Y2ggdG8gcHVyZ2UgaXQsIHdpdGhvdXQgdGhlIGNhbGwgaW4gc3lzZnMuYywgYW5kDQo+
IGRvIHRoZW4gaXdsd2lmaSBjYW4gY2FsbCBpdCBpbiB0aGUgcmlnaHQgcGxhY2VzICh3aGVuIGl0
IHJlc2V0cyB0aGUgZmlybXdhcmUuKQ0KDQpJIHdpbGwgcmV3b3JrIHRoaXMgcGF0Y2guIEknbGwg
a2VlcCB0aGlzIGZ1bmN0aW9uIGFuZCBjYWxsIGl0IGZyb20gaXdsd2lmaSBvbmx5Lg0KIA0KPiAN
Cj4gTm90ZSB0aGlzIHdvbid0IGV2ZW4gYmUgX3BlcmZlY3RfIGJlY2F1c2UgdGhlcmUgYXJlIHJl
YXNvbnMgKGxpa2UgYmVpbmcNCj4gY29ubmVjdGVkKSB0aGF0IG1lYW4gdGhlIGVudHJ5IGlzIG5v
dCByZW1vdmVkIGV2ZW4gd2hlbiBmbHVzaGluZywgc28gdGhhdA0KPiBzaG91bGQgcHJvYmFibHkg
YmUgZG9jdW1lbnRlZC4NCj4gDQo+IGpvaGFubmVzDQoNCg==
