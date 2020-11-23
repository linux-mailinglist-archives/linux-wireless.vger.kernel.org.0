Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357A62C013F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKWISD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 03:18:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:60277 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgKWISD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 03:18:03 -0500
IronPort-SDR: a+r5a/B4yxMGB/azWRmysQhaBWOrwCnawpi2e8afbl8I0EePolVHouKjaeAK9RvZj4N7kklF5v
 0L0lAzhAImjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="171818504"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="171818504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 00:18:00 -0800
IronPort-SDR: 2xKndAFNbip06iuwapvfKKc3TLFmzDDspXFvD9MLI3F+njgpUUpTaoPk5IjLqhVj6dBmkHNuY6
 8Q5/wRJlTHzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="432220086"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 23 Nov 2020 00:17:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 00:17:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Nov 2020 00:17:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 23 Nov 2020 00:17:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDHMZgaXTBSjEcpfYUy3iEhRKAgqUlyUE6UR9m9jp63STeXVtWwkfwwrh1Po7RaLXEgyP9PFuSn0YPXpo0uqTUe5TC+EattVHmuL91aJbMOma9t4qrW8/9qxc23mVBsl3DqVZExDfFureWh1/BK/mWv9V3kgC4EsjRDNrFDh2Nrcm17h/0athQ9RPd0tu8e/JBN5GvNdiJsxlAhvugOxixk06vO/iyI5G+b99BPp3i611Zvu9D4SVdnOSSX19zsjwS/1LOOjt+VFRBs2wjaj80PEvYsdQ3LfyhE1S82jqGrpQJ3L9/mte/ciDplc16/QaQ+WVL0UMJPMkvh8WbswiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT7DSuamCcG8zYDIToh9aGeFsUvgs9ldY3YwBarUP2s=;
 b=a97RrSRprjdbbKJ9u/ewTKedVJPXhD434masGgneZhVZPuVCx/LxJO0sPm1U5r73vSxHDM1KmGCkUw7OBfWXNswOKzuTH0RbTrHVWUVDODP0N/oPyTuzrIPZHHt/Qwguf+qQmC2+tAIkC6S61UapnBURb5u0nBpwwXw/lcAwY4ki5pFv4X3xIVHfMKEClcadfN8wkx7+biTxwAtq63ayK/pqTGJU3OMOP20YZ5ZUTaZxnD/FFA3dhLZ6qhQpVIYZAI1ysSvzlE8wAj8Y8sZ1o7dygxekNbSsBJgi/DXsagK462YuDbuUpmwfskutS1PPBIQdktYBXjFOkFec3HrE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT7DSuamCcG8zYDIToh9aGeFsUvgs9ldY3YwBarUP2s=;
 b=Or32CayEgycOR+yI5FGAIVL3f7SZkJkAuZ1jvJyaUjjMuN1ffFvgh8VYNfYsO5GW9+agiMw3inYdQPLE+wBozftewxIexloUeCz1nsCH9UGdN12HA8pg9WnqpXFrxD8RylREWMneb12920Uo3OQiPZwww74SuprW2qV/gzN/6Ok=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 08:17:56 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f9c7:5d2b:4417:bb33]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f9c7:5d2b:4417:bb33%3]) with mapi id 15.20.3541.030; Mon, 23 Nov 2020
 08:17:56 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     linuxwifi <linuxwifi@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: AX210 version 0024 not detected by iwlwifi
Thread-Topic: AX210 version 0024 not detected by iwlwifi
Thread-Index: AQHWwRdnSMMFSdoyaEOkK2Zb9bobfKnVYBuA
Date:   Mon, 23 Nov 2020 08:17:56 +0000
Message-ID: <ce7fab1d400a04eb31727546b99af0292a0d30f4.camel@intel.com>
References: <03e8284e-4ea8-fe3e-8da7-62a778b1a059@gmail.com>
In-Reply-To: <03e8284e-4ea8-fe3e-8da7-62a778b1a059@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.151.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e6888c5-47fb-487a-41ac-08d88f884886
x-ms-traffictypediagnostic: BYAPR11MB2647:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26472C5A7947609F0510B97090FC0@BYAPR11MB2647.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Of3m7uQCq8V9F/d5Xxlj5clFcSPElx8JtsxErhk5zQmL2P5ZBqTew1N3TmQaRhItAcbafZoMp2uDrOxgPHRVnjPeFVymrVYhiUErjqbxSGDGRqL7a95mI3JbzmsISqrmmPHk/KY0cb4QDOHZdlkXea3/yIDHl3j/TX41z15XCPu5ZfDXI9fUBAc5b5+x7kOdn/Z75sckG0w7wKRX5YVc1ExC2wwdYriQI+7lce+6yefSn8ZYfAYEjC4Q+22oA9/LzIEGzZqBASiCaUrepUGtsLd/C3Ze5JOH84XqmuEroKdiDHEMtU8/XohyfnLqu376SkMAsPwNa9W/B+zeBb6sGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(76116006)(86362001)(91956017)(71200400001)(66946007)(316002)(186003)(26005)(2616005)(66476007)(66556008)(64756008)(66446008)(6506007)(110136005)(5660300002)(6486002)(4326008)(6512007)(6636002)(83380400001)(36756003)(4001150100001)(8936002)(478600001)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1d034IoKCc+B5qSHzFCo3iRODHk5CyEbSLHZQh/H+HVEi97CrOJXMZdwZF0vJNKuI73CPOaG4FY2ay4vU3vOi+4Oqk4Fqw2+vruSdFR88IFzZc6uC18jDsy848JmfiSnTR9bRB00ZDbsJ+4cYdPSmJuflaiso4sVO1M6cAx6bMTpSTQT9h9mYZwtiOTOsMHiplLcHhnEyqSkmFSRBsq8/888s4cqivy43ez+q1k8x70e+vvYOPXAY0id6KknLoN7U6g2sLjMjRuk4rKz1R0OvnVGCBXEVCEkUCz5B+wGIr2HNijYugW+VLqwh+GGKGqJz9OXWXmTwiTrNN0F6O67MD8BTc9EbB/uVt1jMbNdZzKkVH6CWRz//eWzo0t3qcwOB/eeiGx4xP98ofLIhYMLvVBVFa+WSNlh9Bvn5CKr/FqytJ9brD/lsJ1lVMK6Umt0b10IdGQefnnSyhRD7PHJ0Fpm+/nQix/zFLoEMdkUJ+16IISrEuGK4Da/oKzpwrK8GuhrHh1Tq95rwvDTtzYzDOr9iF5eC6tKn2F6prJMsaa+mg4fr9aJwcapzpg/wIWlxqGSPZh8zwyZUdG95xv9YqdD/0KgTE0BnZ3HdpzNhiGravcQkXNg3rWJ+tKEswzQO9/HYY12RAV8C+rTstx7Z4XgDuD4+vv2iUVsn4fvuCXhbPibL6PrQxHyLevooEkrv+GVFIswilGft1iJ5UkDIRgAbuiHiRyoUNN2/fTnAII8e1UT6Y4I19jC7F/KS6FTpSd/UZmloYf34qcae4yw1HKDvmZbWxVy+d146iDKT6UtQQWOCE/KGx9gellwnQj+EcOfz0q0eVQ7y1X2tbDxaak1dGkRjRzlTxc4Yu8nMsHRL10DqNdmxf3UV45mTJt8fNa/+vqO0yFRxJdEbs8cKg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <34553A26886046429F5B928F51556FCD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6888c5-47fb-487a-41ac-08d88f884886
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 08:17:56.7497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iD9ueOa73XA2aMw8tk8rwqjZCSsW4zFKcHQ6HjBzfGb/bQW9L07YeAr/IUWRTRCh1KXQnqAYT6rVxsk9Ub8uJtHsbeH7GB4ZjkcqOk1Xhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2647
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgSGVpbmVyLA0KDQpPbiBTdW4sIDIwMjAtMTEtMjIgYXQgMjI6MzUgKzAxMDAsIEhlaW5lciBL
YWxsd2VpdCB3cm90ZToNCj4gSSBoYXZlIGFuIEFYMjEwIGNhcmQgdGhhdCBpc24ndCBkZXRlY3Rl
ZCBieSBpd2x3aWZpLg0KPiANCj4gMDE6MDAuMCBOZXR3b3JrIGNvbnRyb2xsZXI6IEludGVsIENv
cnBvcmF0aW9uIERldmljZSAyNzI1IChyZXYgMWEpDQo+ICAgICAgICAgU3Vic3lzdGVtOiBJbnRl
bCBDb3Jwb3JhdGlvbiBEZXZpY2UgMDAyNA0KPiANCj4gQWRkaW5nIGZvbGxvd2luZyBlbnRyeSBz
ZWVtcyB0byBiZSBzdWZmaWNpZW50Lg0KPiANCj4gICAgICAgICB7SVdMX1BDSV9ERVZJQ0UoMHgy
NzI1LCAweDAwMjAsIGl3bGF4MjEwXzJheF9jZmdfdHlfZ2ZfYTApfSwNCj4gKyAgICAgICB7SVdM
X1BDSV9ERVZJQ0UoMHgyNzI1LCAweDAwMjQsIGl3bGF4MjEwXzJheF9jZmdfdHlfZ2ZfYTApfSwN
Cj4gICAgICAgICB7SVdMX1BDSV9ERVZJQ0UoMHgyNzI1LCAweDAzMTAsIGl3bGF4MjEwXzJheF9j
ZmdfdHlfZ2ZfYTApfSwNCj4gDQo+IFsgIDQxOS40NzMxNDBdIGl3bHdpZmkgMDAwMDowMTowMC4w
OiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikNCj4gWyAgNDE5LjQ4Njk4NF0gaXdsd2lm
aSAwMDAwOjAxOjAwLjA6IGFwaSBmbGFncyBpbmRleCAyIGxhcmdlciB0aGFuIHN1cHBvcnRlZCBi
eSBkcml2ZXINCj4gWyAgNDE5LjQ4NzE5MF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IFRMVl9GV19G
U0VRX1ZFUlNJT046IEZTRVEgVmVyc2lvbjogOTMuOC42My4yOA0KPiBbICA0MTkuNDg4ODI4XSBp
d2x3aWZpIDAwMDA6MDE6MDAuMDogbG9hZGVkIGZpcm13YXJlIHZlcnNpb24gNTkuNjAxZjNhNjYu
MCB0eS1hMC1nZi1hMC01OS51Y29kZSBvcF9tb2RlIGl3bG12bQ0KPiBbICA0MTkuNTMzMTM2XSBp
d2x3aWZpIDAwMDA6MDE6MDAuMDogRGV0ZWN0ZWQgSW50ZWwoUikgV2ktRmkgNiBBWDIxMCAxNjBN
SHosIFJFVj0weDQyMA0KPiANCj4gTWF5YmUgdGhlcmUgYXJlIG1vcmUgQVgyMTAgc3VidmVyc2lv
biBpZCdzIHRvIGJlIGFkZGVkIC4uDQo+IA0KPiBIb3cgYWJvdXQgdGhlIGFwaSBmbGFncyBpbmRl
eCB3YXJuaW5nPyBJIHNhdyBpdCBpbiBzZXZlcmFsIHBvc3RzLA0KPiBpcyB0aGVyZSBzb21ldGhp
bmcgdG8gYmUgZml4ZWQgaW4gdGhlIGRyaXZlcj8NCg0KR29vZCBjYXRjaC4gIFRoaXMgaW5kZWVk
IHNlZW1zIHRvIGJlIG1pc3NpbmcuICBJJ2xsIGFkZCBpdCBhbmQgdHJ5IHRvDQpzZW5kIGl0IHN0
aWxsIGZvciB0aGUgNS4xMC1yYyBzZXJpZXMsIHNvIGl0IHByb3BhZ2F0ZXMgYXNhcC4NCg0KLS0N
CkNoZWVycywNCkx1Y2EuDQo=
