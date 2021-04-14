Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2235EC17
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 07:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhDNFNI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 01:13:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:19764 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230375AbhDNFNH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 01:13:07 -0400
IronPort-SDR: PABtEodNarHTZdPCFimYaOdcu5GxgOh+UhrGEVIHKzwT/p7NYIL8k3Kx6uND+Jb/JnWbDPD0LC
 4NT1h6a4IQbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194594051"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="194594051"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 22:12:46 -0700
IronPort-SDR: 6OYeVO75AzqcV0OlxY1ZvDNNsXxrcqrPodHgYzvj5Hh1ISEcVM/RuK4DelBmOL7+TThx0Qn4kC
 8yLe9Io/VfhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="521864021"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2021 22:12:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 22:12:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 13 Apr 2021 22:12:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 13 Apr 2021 22:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4tDWN1CVn3QaIPJ7rCT0ZM4tp1Kal+ZhDLnjkoAE41o02ewWq2EFMH9eFoBtkxyJDb/akoL9BN90IY1P0GnNKJM1fe6nDDDlzieOpLMZblKWpmI6MCD2THICtzv5y85tHSWx3wmc3feypzJ1R8X8qUikgwoC6YCcQZzCcvQI26KpC09AikkLiQb2wkyFaoKaw0tfa459+/OTQpk+dEULiSRFyDOvl2qbMbO8IFfzWiokDGl+wGHUPhRY8sqSszJcygLVkKpbtJ7ocCURT4yjjMrZXEfY/uVUdMUO6UynOwbJCTeSjeOOZ/StKVPIAN5OapP2G4MyGB0HtxSfzTbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF3Tf+oM0E+eptpBRF6v4bzyfD1bMeCJAgv1ud2+nCI=;
 b=LHHvSWRI1BTGPs+2p3LDvj++Ro1qC6YtaDQwgkv0Nj1aKkGRHAT57JSViYd1u2mzzrIaB3gIh7ZGbRAyO1MH+JuiHM5DMEcVQFwOhVofOg7kdOjX37dyrWziIKnHyWGgeRfjO6jmkVM2ICBIN/2tOwTM+JkU3r8cTztjq8Fqlnzd0jYMg3Mc9TK0GULS/o6wNYW73oEgre8GPWwPynhaAO3qM62vm4oG3PRCBuop3cfEDRAyFjRKYzrckhbY55AuKVMkpdw7wxygd2osrV4cBtekjpx7ckVY0mX7/hqR3TdksPm8hBSH7m+xDHeeR+dfv8vIhPFQ1HmR9bdwoMPzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF3Tf+oM0E+eptpBRF6v4bzyfD1bMeCJAgv1ud2+nCI=;
 b=DMmFs49bfU5F+eeKAEoE+JLII6C4jU58wbJKbGE7ATGwgTpu+On87w4eXtEHoNd3sViCL2RcV594onCEXuE66jZXpDQQjpYdKdsDn5dRG06PV3Ez32aQEyjtkqkasH/hSApmZdPXyD2AnqNz6yNDFP0X22cC3UiLJGfpxe35AU4=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SN6PR11MB2752.namprd11.prod.outlook.com (2603:10b6:805:59::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 05:12:42 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::dc7d:1696:50b5:8598%7]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 05:12:42 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Berg, Johannes" <johannes.berg@intel.com>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: "rfkill: add a reason to the HW rfkill state" breaks userspace
Thread-Topic: "rfkill: add a reason to the HW rfkill state" breaks userspace
Thread-Index: AQHXMKP/gwMFyG9QcUSP5uW9Ef5Mc6qzd/cA
Date:   Wed, 14 Apr 2021 05:12:42 +0000
Message-ID: <SA0PR11MB4752FEE472EC18B6A4F376FAF24E9@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
In-Reply-To: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [77.124.210.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44a75bcf-fbd8-4220-3ed4-08d8ff03eeb6
x-ms-traffictypediagnostic: SN6PR11MB2752:
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wt/mHxuS4bzjz5hSPglLZSEZ0ydLrForTGQHnkZj8pkNMKfqV0DSU5wa5vP3J2RjmYql8yY2W6xmpI2OgN1JmXv2+W0moinz7BgkBvVzAY6VeaM4YOYHlCBMD2R+6OdoMTENXpoMWRag8Ht3kch4g8jj4QDsR0BFBifZKyz0lzTCMqsq4JLRqa0dl/9GJhhi4ku2sNKwjrGhW1bq+buzKuzI/8FAHhhQMb3OP99QA/DvbK3AE2hplQHVmrxzBz9779dCrEEMUJFrExLMSNGfsLfQLvDvclidFGHhZuzcakU0zDq49ER60bxZO3pCFHejY7DFStAFIpuLLYsOslbmDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(86362001)(55016002)(9686003)(8676002)(5660300002)(122000001)(71200400001)(6636002)(8936002)(66556008)(6506007)(33656002)(26005)(52536014)(4326008)(66946007)(7696005)(38100700002)(478600001)(76116006)(186003)(66446008)(110136005)(316002)(66476007)(966005)(2906002)(64756008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?anJkUU9jRzZNLzBuS2FpemxkME5HMndVQ1FwdTB2eE5DYVlLbEZxeTFMdEVT?=
 =?utf-8?B?WHdzaTBTeHFkZWUrcDk4WFQybGU0L1AyOHBZMFZCenBCTzhabFFSNHlkbGU3?=
 =?utf-8?B?MEpVbzV6U29YdFQvbEpRTkZ3aWcxUFExTjhoOExTSzBOMVBaTFo2Mm9sZFh0?=
 =?utf-8?B?ZFhzaWNJT1dhN1hUejdIazJKaktBUVZ2Qll0ZERyU1MxbDhkNkFETE02MU82?=
 =?utf-8?B?aktrbnRaUkhBNEFCZ3ZCNFo4Q2xQbks5K0hDY0tDSHE2UHRrQW5rZmVvQklv?=
 =?utf-8?B?TDlqZkFqYVlCNjAvVnFWazI5RUpXN3I4MXZaWlFmRGQ3RWxudFl4UVVGSlZk?=
 =?utf-8?B?Q3dzMmxCejB2Y1ZXd0tVMkdIZGtQd3k5aFpRbWswZ0tSWE9CcGowMDdUdVBW?=
 =?utf-8?B?bFBkVllndEREejZOYjRkKzkrcnorVms5cFl6N2xkMDFNWlVNR1VYa3I5Ry9p?=
 =?utf-8?B?UkVFdktWRGdnMDFGU3VaVlg0eEdrYVFMYnZMMzBXeDdGUGpFa1VHOFRHdHVP?=
 =?utf-8?B?cTR2OWxmd09ubW85aDhRQ0Q5Sk95NjdGSnhGN0ZlR3g2MCsxRXZLaExkeUhh?=
 =?utf-8?B?eUVpOWZWUVlHRjlUV1Nwd2h0QmNwbW1iSHd5UHFvMEhQTU43RVZDN0xEMC9O?=
 =?utf-8?B?eFJjeUcvZWgyVkJkdENTQzlTbWZ4UFZ1NkNaeXorWExlREk0VWFkR2NBWUwr?=
 =?utf-8?B?REFjWHBpdUJoZEFUSVhmcGFid0RZL25McG4ycG9SQWV5azZBL3UwUDhabnN5?=
 =?utf-8?B?NzVMa0hUKy8yQndLYlBoREVFUXFyN1ZUdDQycWJxbHR1VXppWjZOYUlRaDFk?=
 =?utf-8?B?RU41cHUwYnVHVGt6V3FSZjFrR21ONnUxWUpZRU5ud2daRy9pYkdveExLaENB?=
 =?utf-8?B?VEV4Z3d3VkFGaFBHMUJoeVE1QmFBOWFEaFRsZnRlMFNGVGhiR3pFTHQ5Wllv?=
 =?utf-8?B?djNSTjBTakxtWTR0NkVPU0ZFdExWQzBGdk80dEt3eFdwZFIwT0lZU1EzTmI2?=
 =?utf-8?B?UmV2ejFESGlvbFQwMnkxWFZkOGxYaEs2TU1YUjFnd2hVRlA5UVFlR2pGei9W?=
 =?utf-8?B?Ukt1ZHcvZnB6RzVwSFViMFRma2NVSU50MGRoelp3WWV2eE1pbStiaTFqanZY?=
 =?utf-8?B?bjllTGVNTlJMMG1rZHlRbDBFakZsVTZndUtJeVNudmRxNVZucDRKM2VZVFdN?=
 =?utf-8?B?ZmFiTjh4a0JVRmp2TXhNdnozeDltNWFXajJRVThyQTJKeVZ3aTlLc3k2SHA1?=
 =?utf-8?B?VlBzdGNRdGhReUdoR2wrUXl5TVVyaUlydlpieXpwU1ovM3hHN2ZqUFJ3Tm5l?=
 =?utf-8?B?aXhnM2hrVk9JeFVrdTdMc3NOeEIvSlY5RWFXdnY0M281ZzdWZERMa3hsUEJP?=
 =?utf-8?B?OUhZTXRKV0NFSXF3bGYxREU5UXM1cU5DL0VnMElzT1Q3b1I0Nm1pT283N2Zw?=
 =?utf-8?B?Wk1iaWRCTms1V0Z6Y253TjVBQ3gySE40TEZjanY2emJoZHpHYlFiYTVySVA1?=
 =?utf-8?B?OVlPS2xVbmM4SzZ6Q2FxWmlFNmFaaEgrUlcxQlhzK1g3N04wMnhXd1U4V1hO?=
 =?utf-8?B?WjRuYU1JekFCS2NTa0lVaGlnVXFnWGo4djdNQlcrcCtvYjJJbGhxTGZ1Tk1r?=
 =?utf-8?B?MDZXNGpxV2ZUdm5KMjR2cFFBNWlDNnZjaFVsdHRXUEl4M3c2QzJhM2dIV05J?=
 =?utf-8?B?VFU3YkRhdU9xN2Y5U2xVZzNFOFlVeGd4d3poSE5mUm10NnV2eE4xWUZsNlFu?=
 =?utf-8?Q?ET0T8BtPcEBZVafGbjRj/VfmmmRSPT25nsvnMNl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a75bcf-fbd8-4220-3ed4-08d8ff03eeb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 05:12:42.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSPwQg5XkHQNZZkHkBJ9V1Y3n5LYNnI2mODo29o2HzqMPZ69JZswveYbp6yJVHiIqIRKlhmxbq8zvjgeYDqWeNv5tCYdwwm2xcGgiVYviO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2752
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiANCj4gSGksDQo+IA0KPiBJJ3ZlIGJlZW4gZGVidWdnaW5nIGEgdXNlcnNwYWNlIHJma2lsbCBp
c3N1ZSB0b2RheSB3aGljaCBib2lscyBkb3duIHRvIHRoZQ0KPiAicmZraWxsOiBhZGQgYSByZWFz
b24gdG8gdGhlIEhXIHJma2lsbCBzdGF0ZSIgcGF0Y2g6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2kN
Cj4gZD0xNDQ4NmM4MjYxMmExNzdjYjkxMDk4MGM3MGJhOTAwODI3Y2EwODk0DQo+IGJyZWFraW5n
IHVzZXJzcGFjZS4NCg0KVGhpcyBoYXMgYmVlbiByb2xsZWQgYmFjayBieToNCmh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2piZXJnL21hYzgwMjExLmdpdC9j
b21taXQvP2lkPTcxODI2NjU0Y2U0MDExMmYwNjUxYjZmNGU5NGM0MjIzNTRmNGFkYjYNCk90aGVy
IHVzZXJzcGFjZSBicm9rZSAoc3lzdGVtZCkgc28gSm9oYW5uZXMgcm9sbGVkIHRoaXMgYmFjayBi
eSBkZWZhdWx0Lg0KVXNlcnNwYWNlIHRoYXQgaXMgaW50ZXJlc3RlZCBpbiB0aGUgbmV3IGJ5dGUg
d2lsbCByZWFkIDkgYnl0ZXMuDQoNCj4gDQo+IEl0IGlzIHRvbyBsYXRlIHRvIGZpeCB0aGlzIG5v
dyBzaW5jZSB3ZSBsaWtlbHkgYWxzbyBoYXZlIG5ldyB1c2Vyc3BhY2UNCj4gZGVwZW5kaW5nIG9u
IHRoZSBuZXcgQVBJLCBidXQgSSBzdGlsbCB0aG91Z2h0IEkgc2hvdWxkIHJlcG9ydCB0aGlzLg0K
PiANCj4gSSd2ZSBzdWJtaXR0ZWQgYSBmaXggZm9yIHRoZSBwcm9ibGVtYXRpYyB1c2Vyc3BhY2Ug
Yml0cyBoZXJlOg0KPiBodHRwczovL2dpdGxhYi5nbm9tZS5vcmcvR05PTUUvZ25vbWUtc2V0dGlu
Z3MtZGFlbW9uLy0NCj4gL21lcmdlX3JlcXVlc3RzLzIzMg0KPiANCj4gTGV0IG1lIHF1b3RlIHRo
ZSBjb21taXQgbXNnIHdoaWNoIGV4cGxhaW5zIHRoZSBwcm9ibGVtOg0KPiANCj4gIiIiDQo+IEFj
Y2VzcyB0byBhIC9kZXYvZm9vIGRldmljZSBzaG91bGQgbmV2ZXIgdXNlIGJ1ZmZlcmVkIG1vZGUu
DQo+IA0KPiBXaGlsZSBkZWJ1Z2dpbmcgYSBnc2QtcmZraWxsIGlzc3VlIEkgbm90aWNlZCBpbiB0
aGUgZ19kZWJ1ZyBvdXRwdXQgdGhhdCB0aGUNCj4gcmZraWxsLWdsaWIuYyBjb2RlIG5vdyBzZWVt
cyB0byBiZSByZWNlaXZpbmcgYm9ndXMgZXZlbnRzLg0KPiBEb2luZyBhIHN0cmFjZSBJIG5vdGlj
ZWQgc29tZSByZWFkKGRldl9yZmtpbGxfZmQsIGJ1ZiwgOCkgY2FsbHMsIGV2ZW4gdGhvdWdoDQo+
IHdlIGNhbGw6DQo+IGdfaW9fY2hhbm5lbF9yZWFkX2NoYXJzKC4uLiwgc2l6ZW9mKHN0cnVjdCBy
ZmtpbGxfZXZlbnQsIC4uLikgV2hpY2ggcmVxdWVzdHMgOQ0KPiBieXRlcy4NCj4gDQo+IFRoZSBw
cm9ibGVtIGlzIHRoZSBrZXJuZWwgZXhwZWN0cyB1cyB0byByZWFkIDEgZXZlbnQgcGVyIHJlYWQo
KSBzeXN0ZW0tY2FsbA0KPiBhbmQgaXQgd2lsbCB0aHJvdyBhd2F5IGV4Y2VzcyBkYXRhLiBUaGUg
aWRlYSBpcyBoZXJlIHRoYXQgdGhlIHJma2lsbF9ldmVudA0KPiBzdHJ1Y3QgY2FuIGJlIGV4dGVu
ZGVkIGJ5IGFkZGluZyBuZXcgZmllbGRzIGF0IHRoZSBlbmQgYW5kIHRoZW4gdXNlcnNwYWNlDQo+
IGNvZGUgY29tcGlsZWQgYWdhaW5zdCBvbGRlciBrZXJuZWwgaGVhZGVycyB3aWxsIHN0aWxsIHdv
cmsgc2luY2UgaXQgd2lsbCBvbmx5DQo+IHJlYWQgdGhlIGZpZWxkcyBpdCBrbm93cyBpbiBhIHNp
bmdsZSBjYWxsIGFuZCB0aGUgZXh0cmEgZmllbGRzIGFyZSB0aHJvd24gYXdheS4NCj4gDQo+IFNp
bmNlIHRoZSByZmtpbGwtZ2xpYi5jIGNvZGUgd2FzIHVzaW5nIGJ1ZmZlcmVkLWlvIGFuZCBhc2tp
bmcNCj4gZ19pb19jaGFubmVsX3JlYWRfY2hhcnMgZm9yIDkgYnl0ZXMgd2hlbiBjb21waWxlZCBh
Z2FpbnN0IHJlY2VudCBrZXJuZWwNCj4gaGVhZGVycywgd2hhdCB3b3VsZCBoYXBwZW4gaXMgdGhh
dCAyIGV2ZW50cyB3b3VsZCBiZSBjb25zdW1lZCBpbiAyDQo+IHJlYWQoZmQsIGJ1ZiwgOCkgc3lz
Y2FsbHMgYW5kIHRoZW4gdGhlIGZpcnN0IGJ5dGUgb2YgdGhlIHNlY29uZCBldmVudCByZWFkDQo+
IHdvdWxkIGJlIGFwcGVuZGVkIHRvIHRoZSBwcmV2aW91cyBldmVudCBhbmQgdGhlIHJlbWFpbmlu
ZyA3IGJ5dGVzIHdvdWxkDQo+IGJlIHVzZWQgYXMgdGhlIGZpcnN0IDcgYnl0ZXMgZm9yIHRoZSBu
ZXh0IGV2ZW50IChhbmQgZXZlbnR1YWxseSBjb21wbGV0ZWQNCj4gd2l0aCB0aGUgZmlyc3QgMiBi
eXRlcyBvZiB0aGUgbmV4dCBldmVudCwgZXRjLikuIExlYWRpbmcgdG8gY29tcGxldGVseSBib2d1
cw0KPiBldmVudHMuDQo+IA0KPiBFbmFibGluZyB1bmJ1ZmZlcmVkIG1vZGUgZml4ZXMgdGhpcy4N
Cj4gDQo+IChiZWZvcmUgdGhlIGtlcm5lbCBjaGFuZ2UgdGhlIHJma2lsbF9ldmVudCBzdHJ1Y3Qg
d2FzIDggYnl0ZXMgbGFyZ2Ugd2hpY2gNCj4gYWxsb3dlZCB1cyB0byBnZXQgYXdheSB3aXRoIHVz
aW5nIGJ1ZmZlcmVkIGlvIGhlcmUuKSAiIiINCj4gDQo+IE5vdGUgdGhpcyBpcyBuZXcgdXNlcnNw
YWNlIG9uIGEgbmV3IGtlcm5lbCBhY3R1YWxseSBiZWluZyBicm9rZW4uDQo+IA0KPiBJIGJlbGll
dmUgdGhhdCB0aGUgbmV3IHVzZXJzcGFjZSAoZXhwZWN0aW5nIDkgYnl0ZXMpIG9uIG9sZCBrZXJu
ZWwgd2lsbCBhbHNvDQo+IGJlIGJyb2tlbiwgc2luY2UgYSBuYWl2ZSB1c2Vyc3BhY2UgaW1wbGVt
ZW50YXRpb24gd2lsbCBkbzoNCj4gDQo+IAlpZiAocmVhZChmZCwgYnVmLCBzaXplb2Yoc3RydWN0
IHJma2lsbF9ldmVudCkpICE9IHNpemVvZihzdHJ1Y3QNCj4gcmZraWxsX2V2ZW50KSkNCj4gCQkv
KiBEbyBlcnJvciAqLw0KPiANCj4gV2hpY2ggbWVhbnMgdGhhdCBhZnRlciBhIHJlY29tcGlsZSBv
biBhIG5ldyBrZXJuZWwgaXQgd2lsbCBleHBlY3QgOSBieXRlcw0KPiBmcm9tIGEgcmVhZCBjYWxs
IGFuIGlmIGl0IGdldHMgb25seSA4IHRoZW4gaXQgd2lsbCBjb25zaWRlciB0aGF0IGFuIGVycm9y
IChvciB3b3JzZQ0KPiBpdCBjb3VsZCB0cnkgdG8gZG8gYSBzZWNvbmQgcmVhZCB0byBtYWtlLXVw
IGZvciB0aGUgbWlzc2luZyBieXRlKS4gTm90ZSB0aGF0DQo+IGdub21lLXNldHRpbmdzLWRhZW1v
biBzdGlsbCBoYXMgdGhlIG5ldy11c2Vyc3BhY2Ugb24gb2xkLWtlcm5lbCBpc3N1ZQ0KPiBldmVu
IGFmdGVyIG15IGZpeC4uLg0KPiANCj4gSSBiZWxpZXZlIHRoYXQgYWxsIHRoYXQgd2UgY2FuIGRv
IG5vdyBpcyBmaXggdXNlcnNwYWNlIHdoZXJlIG5lY2Vzc2FyeSA6fCBidXQNCj4gdGhpcyBpcyBz
b21ldGhpbmcgdG8ga2VlcCBpbiBtaW5kIGZvciBmdXR1cmUgZml4ZXMuDQo+IA0KPiBSZWdhcmRz
LA0KPiANCj4gSGFucw0KDQo=
