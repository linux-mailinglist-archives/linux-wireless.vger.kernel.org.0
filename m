Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272B415BA21
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 08:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgBMHji (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 02:39:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:27246 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbgBMHjh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 02:39:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 23:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; 
   d="scan'208";a="237958101"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 23:39:36 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Feb 2020 23:39:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 12 Feb 2020 23:39:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWo7CchKQi+TpDldrA8TnwSoOTzFY/4AMCr77lt0opDKwLocZh3cnux1s9bRJ0wR0RLE0SVqleOaXSUwcY/+7KG8GjgP0Mox5o7z/8OkKu3M6eUb4axjKwTYESw4VfcllcFziR8Qktq6B3/uuKJpSF4g5cv/T/gmc5iAEvME7Cd6vjCbRAB0UqjdOMMRC48CbXgzZ0tQ/fAa9lGRPXVJola6yatjmtrRL5am3KMOaOlb+T/sIydGV/6eXkbEryurSptOk8cOQ1s77q3TPX7+oIgBB8J76jjX9r/hZhd83KX54x5VtcTvGqiSHSJnU1hXqbzNx2DtQgHftOkVxzpr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h+q2EjM+HqDu9pS6awbBMGZ0FimwTeXwEVLmFBqtkc=;
 b=VOFTrFWCuBKpC6C8Ik7wtDrt6BbxLBH97xGjO3m4yGQmmYwpBWGaFb9eFHkEI5HYVuVeDya70eEm8GPYEh7kJlLzkFPQIo4KPeHN+tRAxu1kCyNqcA/tUCczGOT9Kealnfs9vj8QAhDJABosoZzJevbViejXLuiJT9YvWIAtzRveXYMqmv9W2XjHRt4JMIr4AWRglrpOOb/7PpMhNcR4WgZkiVbdS4pN573OC3ZKirbyL8hlSDmO0u05n/DszA0u3/2oAIpyphwWx+H9h92sUSuvQ/DOFZHsQDVjA+IdiFXjbnSOKrIWjU7iTV/oECFAuEZk7ohVdGJNUY6ayYpdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h+q2EjM+HqDu9pS6awbBMGZ0FimwTeXwEVLmFBqtkc=;
 b=wMn7MA/XIXHcaD9XHn5R7zHfNcLkvkJTMv2Tuk02VXLcgzZQziFYfAk/UixpGHCnGOoYug0uoPznSibLHtDD8QioOOYGZERg136bvU1lxXBqHfxf/etSQr06OuBsW+PDmHC1W4boDB6ijUx1it32C5iuAbwnakyxZOlfpkm32HQ=
Received: from SN6PR11MB2976.namprd11.prod.outlook.com (52.135.126.86) by
 SN6PR11MB3136.namprd11.prod.outlook.com (52.135.127.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 07:39:33 +0000
Received: from SN6PR11MB2976.namprd11.prod.outlook.com
 ([fe80::ca9:91ae:e6ae:781c]) by SN6PR11MB2976.namprd11.prod.outlook.com
 ([fe80::ca9:91ae:e6ae:781c%7]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 07:39:33 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "dmoulding@me.com" <dmoulding@me.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>
Subject: Re: [PATCH v2 5.5] iwlwifi: mvm: Do not require PHY_SKU NVM section
 for 3168 devices
Thread-Topic: [PATCH v2 5.5] iwlwifi: mvm: Do not require PHY_SKU NVM section
 for 3168 devices
Thread-Index: AQHV1b3MoNaVXOoKuk+2wK2BAZ9U9qgWRBUAgAF50yuAARgPAA==
Date:   Thu, 13 Feb 2020 07:39:33 +0000
Message-ID: <eb6c6e1ff0e1c8c6b202e534262778a729923bc6.camel@intel.com>
References: <20200128093107.9740-1-dmoulding@me.com>
         <20200211162450.2493-1-dmoulding@me.com>
         <87d0ajx3r2.fsf@tynnyri.adurom.net>
In-Reply-To: <87d0ajx3r2.fsf@tynnyri.adurom.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=emmanuel.grumbach@intel.com; 
x-originating-ip: [134.191.233.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4363518-1cf0-4fed-cd4c-08d7b057de5a
x-ms-traffictypediagnostic: SN6PR11MB3136:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB31360186F0A7D2F1CCED3C62F21A0@SN6PR11MB3136.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(136003)(396003)(199004)(189003)(4326008)(91956017)(36756003)(66446008)(76116006)(6506007)(71200400001)(16799955002)(5660300002)(86362001)(478600001)(6512007)(81166006)(8676002)(316002)(26005)(2616005)(8936002)(64756008)(66556008)(186003)(54906003)(6486002)(81156014)(2906002)(966005)(110136005)(66946007)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3136;H:SN6PR11MB2976.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UyyisyH3dHBgB2544xlPtYyQ9NUXJIrDCcDs0IEjnf5Y+8qI06DXIgc9EKF16BGxRY1Az59oLS1YL0OZXoBWjY/qgmFpDt28CY/HkdqMYWdceGjDhDLzINwxyF5QI3bR9+CnjfNpqx6ab1xlUdJRAGpYMz5BpJb/shlntegkhApkPwDbJLrKwJaEW8V/xepnF7S9ce57Vomd6LuewatgEuAHC3yLkUZlWTU12bvqeeXzmCIQlJGmEvnTRN8ul2I3uQZna/GELwD6MY8GCCKH4oS47ooaxV6pOE8ye5662TXVpoWl0bQ6cuFkJTc5zlJ4PNLFNzu+kk62voiwDozk231iB7jqc+Wpx+7gpooNc3eJfB6FVM9kTosIeS5ZjpI5qP/trHq3SnQNGjRsAJbCmN7becwMednD0TGDGI4XVd4G/H1eS5SpYvRtoH/aSVqcdBPtHMkKtER70MHzVOjvEkE0jWT81Ks+W+Dm2qJ081UUlVOrYnse4pvqXys1QhcSIt/k8UCp0j+Tz3DJQlxUwg==
x-ms-exchange-antispam-messagedata: y+HiN8Pgbi+eBwquWRp/JDY5aCLDGuJx7C+vbFvJZGy0L/oZlVdVVOSJH6DG4XrYQEr5aPSpkQiOzea91Ic/R7AlDqke4BbKGliIaUWGch06LjMKZzaiBrz18uq8/osiYcrQhAYBaEWwX9Neslf5gg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D478C79D442005478187BD8801085EAE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b4363518-1cf0-4fed-cd4c-08d7b057de5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 07:39:33.1912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w76q0PC5nChByhSH72+cDPlPuRQBZ11Q+ovPmbBTGkXOvg41nTxB7MBNo+iCLOchNyKwZx7oJzMVz+fFmrmAskDIfRqxk2+bmS8TOhAWWpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3136
X-OriginatorOrg: intel.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUgYW5kIERhbiwNCg0KT24gV2VkLCAyMDIwLTAyLTEyIGF0IDE2OjQ2ICswMjAwLCBL
YWxsZSBWYWxvIHdyb3RlOg0KPiBEYW4gTW91bGRpbmcgPGRtb3VsZGluZ0BtZS5jb20+IHdyaXRl
czoNCj4gDQo+ID4gVGhpcyBpcyBqdXN0IGEgZnJpZW5kbHkgcmVtaW5kZXIgdGhhdCB0aGlzIHBh
dGNoIGhhcyBiZWVuDQo+ID4gc3VibWl0dGVkLA0KPiA+IGZvciB3aGF0IGxvb2tzIGxpa2UgYSBm
YWlybHkgbWFqb3IgcmVncmVzc2lvbiBpbiBpd2x3aWZpIHRoYXQNCj4gPiBpbXBhY3RzDQo+ID4g
KGFzIGZhciBhcyBJIGNhbiB0ZWxsKSAqYWxsKiAzMTY4IGRldmljZXMuIFRoZSByZWdyZXNzaW9u
IGlzIGluIHRoZQ0KPiA+IHY1LjUueCBzZXJpZXMgYW5kIHdhcyBmb3IgYSB3aGlsZSBiYWNrLXBv
cnRlZCB0byB0aGUgc3RhYmxlIHRyZWVzLA0KPiA+IGJ1dA0KPiA+IGx1Y2tpbHkgd2FzIG5vdGlj
ZWQgYmVmb3JlIHRoZSByZWxlYXNlcyB3ZXJlIG1hZGUuDQo+ID4gDQo+ID4gVGhlcmUgYXJlIGF0
IGxlYXN0IGEgZmV3IGJ1ZyByZXBvcnRzIGZvciB0aGlzIHJlZ3Jlc3Npb246DQo+ID4gDQo+ID4g
aHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDYzMjkNCj4gPiBo
dHRwczovL2J1Z3MuZ2VudG9vLm9yZy83MDY4MTANCj4gPiBodHRwczovL2xrbWwub3JnL2xrbWwv
MjAyMC8yLzcvODExDQo+ID4gaHR0cHM6Ly9iYnMuYXJjaGxpbnV4Lm9yZy92aWV3dG9waWMucGhw
P2lkPTI1MjYwMw0KPiA+IA0KPiA+IFRoZSBHZW50b28gbWFpbnRhaW5lcnMgaGF2ZSBhbHJlYWR5
IGFwcGxpZWQgdGhpcyBwYXRjaCB0byB0aGVpcg0KPiA+IExpbnV4DQo+ID4gc291cmNlcyBhbmQg
bWFya2VkIHRoZWlyIGJ1ZyByZXBvcnQgImZpeGVkIi4gQnV0IGl0IHdvdWxkIGJlIHJlYWxseQ0K
PiA+IG5pY2UgaWYgd2UgY291bGQgZ2V0IHRoaXMgcmVncmVzc2lvbiBmaXhlZCBpbiB0aGUgbmV4
dCBzdGFibGUNCj4gPiB2NS41LngNCj4gPiByZWxlYXNlLg0KPiANCj4gSSdsbCBxdWV1ZSB0aGlz
IGRpcmVjdGx5IHRvIHdpcmVsZXNzLWRyaXZlcnMuIEludGVsIGZvbGtzLCBhcmUgeW91IG9rDQo+
IHdpdGggdGhpcz8NCj4gDQoNClRoZSBvbmx5IHBlcnNvbiB3aG8gcmVhbGx5IHVuZGVyc3RhbmQg
d2hhdCBnb2VzIG9uIGhlcmUgaXMgTHVjYSwgaGUgaXMNCmFsc28gdGhlIG9uZSB3aG8gdG91Y2hl
ZCB0aGlzIGFyZWEgSSB0aGluay4gTHVjYSBpcyBPT08gYW5kIHNob3VsZCBiZQ0KYmFjayBuZXh0
IHdlZWsgSSBiZWxpZXZlLg0KVGhlIHBhdGNoIGxvb2tzIHNhbmUgYW5kIGl0IGZpeGVzIGlzc3Vl
cyBmb3IgcGVvcGxlLCBzbyBnbyBhaGVhZCBhbmQNCm1lcmdlIGl0IHBsZWFzZS4gSWYgTHVjYSB3
YW50cyB0byBtYWtlIGNoYW5nZXMgb24gdG9wIG9mIHRoaXMsIGhlIGNhbg0KYXNrIHRvIGRvIHRo
b3NlIGNoYW5nZXMgb24gdG9wIG9mIHRoYXQgcGF0Y2guDQoNClRoYW5rcy4gDQo=
