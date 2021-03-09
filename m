Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7233246F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 12:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhCILvH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 06:51:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:40445 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhCILuh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 06:50:37 -0500
IronPort-SDR: Or9nKQvZypx+Ym+y2RQKOI0Bt6SQbMxDtemLaBGeTAOdDdry5FE55NQEw0XVEVKtrQQ2EvhgtQ
 lL/KESB2qj6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="252235873"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="252235873"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 03:50:37 -0800
IronPort-SDR: cVu+89zeS3HXbQh5ZtG5Wfp3eD0o07BBCIJm46tJ+nEhiM4JOidTQN64xuZBMepeyn2+K9tXfh
 hmy1U16JGgGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="520298862"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2021 03:50:37 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 03:50:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 03:50:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 9 Mar 2021 03:50:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 9 Mar 2021 03:50:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB/WsWWFiLkqW/Fxj+Je6gtbcdH6gU0iYJe5R8plRWY5Sm4fOoQt4dTNi2VJIcDJxLDwJbecL1j1cB59f7dcSiVYv0flrOniLWpr5P00Tx/mCewIdFMFORY4H6aRRg7s4cj6OpcO3p1QVSjE9SzsAZJ8yZrAxs4pBENUTHjvcOM5l+OvSTE/bigzuib2MK46fa9CNFAp5GBHAE5kgSNiJ40EtEcF0xzCtUbIIZwPIUwwZKkCDD6sapsftCNnAcEU9acjON/xV2uKvO7un9iRRuLTUChwOtecPPEr3IY0RYj5uE+Hbp9WmK2Gp26SCH/OnKMpdeD/5swTVDUHf3rkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y6gZ81Yx7eXb5DSARBz527jvWWn/VwXn4cGsLIYrDg=;
 b=hlVtB3pfqRILYQ+vSiz+Gg9SFbZHtJ3b2mzZtXm5iVfFcfgus30zRQ0uWkRQD6XBLtxMJUi/zfOKTNGvnL/Y5Qk8lVOpg+AKcNdsVm0bq6SpjM9i2ELkEnXuS29wmNc9hb13RwUH/aZooh9MeJ1uEuVAgKPoJxCN48IP/c23zgx9NCaAKZ73kNnyl8rnOZbHJDdHxpiF+7HbsOuEwwlhfPF6ZIi3ZB2viNF2h1acFP+mm1h1xOgxsnb6MEVHuFMcEoHA4N07KGTnnIQL0sEAXt8W3OFKmQxce1pBpcXnjbpFs8WcOlLGztpu+i++X+G+RrV9yXWv+OT79gp9NHmO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y6gZ81Yx7eXb5DSARBz527jvWWn/VwXn4cGsLIYrDg=;
 b=QnY24jAvsUQ+i48bZXvdTcPwXNOadS27TLft8T31NZWFtY4KM3aYQYBvQFYQN990sLr6k6ToqTrY4qnkqhNi85gVv2z6sfpnzSXcCZAGF1KDwaYqiJqWlOM5qvpWcp94maFLtveHH+zWkVkBjx9Ek8cWp4c9VF0d5Czfnli6NTA=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB3158.namprd11.prod.outlook.com (2603:10b6:a03:1c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Tue, 9 Mar
 2021 11:50:34 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e084:727e:9608:11c7]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::e084:727e:9608:11c7%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 11:50:34 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tmb@tmb.nu" <tmb@tmb.nu>
Subject: Re: pull request: iwlwifi firmware updates 2021-03-05
Thread-Topic: pull request: iwlwifi firmware updates 2021-03-05
Thread-Index: AQHXFM+ft1vMw79V2ECfTonS546NRap7izEA
Date:   Tue, 9 Mar 2021 11:50:33 +0000
Message-ID: <871f8d776cb51caa382f564228af1e0c357f0d20.camel@intel.com>
References: <2663a3a4-1ef6-6837-ba30-5db988e331ea@tmb.nu>
In-Reply-To: <2663a3a4-1ef6-6837-ba30-5db988e331ea@tmb.nu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [91.156.6.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ba215d6-5dea-44ed-c69c-08d8e2f18c3e
x-ms-traffictypediagnostic: BYAPR11MB3158:
x-microsoft-antispam-prvs: <BYAPR11MB315859B99778754D3E0D6DF190929@BYAPR11MB3158.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nehfMLxzDex4OBJmfT12i1w4CSq5j0K1swmzPKkmcIfgdeJrehZcrzS0RbXg1AnFFvg6ZITbivIAk8EW45PTL2eANRN+9hVByxP5rizIICNXLiHnmAED3KyqsI1j0cMmsghMdUGvXvZHSlK1ow6DE/eMMGfdQ7PkvF1NPF+s2ikXt0V2yV8S33z9vtMa0qo6M0Q3xxCMHP/UeIXbpHOS7rWZwsJWP/jwi1mRE1zLML1F5dCuyRjPjnqXq+uPJc4zUaNV5cstBg+vXwcVYbEokEsszziM1Y7hTvLGWLyR4zxS1xIGqkfUThV6Wu8CxP/nKCXFphqEajsdLf2jfHz3n9HD7ewYF53tHw7J7CP5guNN9UxlBQJGfcvEurPMhdGYSbYsfdA5XhfpWWE9YYusIaFTZtKhzPc/Izq6aYrYFnExvq8/2rpo6YQIq+u6wc9YsOg799cBWhZoTV/NnpefwqxQtAQdkd1FKgylp9UgShPhDBmnSabsIZTiAAKGO/fX6Bj34nZpqXB1iTZnyxy8gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39860400002)(346002)(396003)(76116006)(26005)(83380400001)(2616005)(478600001)(6486002)(91956017)(316002)(186003)(6506007)(110136005)(8936002)(2906002)(86362001)(8676002)(71200400001)(15650500001)(6512007)(4744005)(5660300002)(66556008)(66946007)(66476007)(64756008)(66446008)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R0V4M1k5L0RlV3BoVmlYYWlZcGdudWdORWpwb3lQN1owMnZHMmxWb2RGRkVa?=
 =?utf-8?B?L2I4eFF6UlA2YXVMSVkvYjdTSzFsMlVJTmxvUTh0MGdNQUNlcXJNcmp6SnEr?=
 =?utf-8?B?NUluS05ITVhpN1g4ZUlobGhYTUh4R2NhTjNja0ZFRTlDMzRubW1qbXhwb3Zw?=
 =?utf-8?B?Z0pUNk9JdEQrSFJ1ak13eVNYTjBwemovL2s4YXJPSDM4RWVzR25BUHZDKzF6?=
 =?utf-8?B?cGkxblRGWFhJMDNIZ3c0eVlpQWlSM0IzUE9LcysrYmZCNS9Jc0hCeGJvdXla?=
 =?utf-8?B?NFhqL1U4VFI3RWk5SG1QZHdjSFlBUjFkVk05Qlc4Z0NkZ0NpR1AyQ2R0TGl2?=
 =?utf-8?B?Smp5RDF6dksyeVNXNXE3UFY4NzdsdnBpT2FseFZOcUc2OENOU2VDUXprNDZw?=
 =?utf-8?B?ZURwTnV6emFwZnR6a0JyZ2dWOHU3OURwc0E4eWlRRzVrV0JWaXJOcSt0QjdW?=
 =?utf-8?B?NkM5bWRZV2xtbmZrd3R4akhlU0ZTTURPV3Jzb3k1SGNGM3VpQXIvUHVOcm1o?=
 =?utf-8?B?Y2lSS1ZWQU5NTC91MnVkelpjUDlVOGFGcW1aYUxUNzB1Q2RHUE5RZkxtREVL?=
 =?utf-8?B?aWVDSzBVTWUwV0JEREdsQkZKbFBXRlZNblM1eWpxWmtydzhHK0YyZ0Z6ZzZW?=
 =?utf-8?B?c1NTQ2pTcWNUSEloVkJwTHkrOE5sK0YxZHVBd3crZ1pCaEV3U3BWbWNKdnE2?=
 =?utf-8?B?STF5eE1kWGhsNDROVE9VWnl0VXlqandYc2ZKZ29hTjBuMWRoQVhibEFEdUhs?=
 =?utf-8?B?RGgyUkNtd29QbWJ4N2ZZMVh6OEdnV2xxeHVjVENmRVpGZnNQRXpwTFFZMFJL?=
 =?utf-8?B?OGd1MTYyWEV6QkJDaXN4aVEzeGJibGdMZ0VuMy9TRnNMaitSRUxlSDUyeU9U?=
 =?utf-8?B?ZTJudnNWWjgxM1FsMUxaWHVpWXFBSVFvRnR2M2RXUkczeXpORHA0YU5ET1cz?=
 =?utf-8?B?aHJiTktYRUVwN2tUV1czNUt3V3ZXUlBhcWRGcU9URXBYMzIvckZPS1E3eHVq?=
 =?utf-8?B?TnIxaFlGeGd6YjY5YW12c1E0akNxQndWOGxMM0dIbDY1SnkwcXJ3QkdoRGZk?=
 =?utf-8?B?by9nZ2VXZ25PK3MrSnl4bVU5N0ZmaHNrOVp4UDRjSWwrcmw2TU5LWHdYdytE?=
 =?utf-8?B?MjdodWRsTllEVFVTcFNIdnEraWhYOGVhc2VxTEZQc1IzazRtMWk4UCs5aTZy?=
 =?utf-8?B?WjZTRERiQUNxM2ZUaWlyTkd3SGdaQ09nRHIzb2plMUFFZ1BrWVgyTFNWSURa?=
 =?utf-8?B?ejB2aEN6VVpBcHBUL2ZGVFRHOFNzdVoxNlQvb1VOTG5VTWEwY0FJUm04N2ly?=
 =?utf-8?B?U1NRUUJDSlg0TThVNnRpUnBpR0xRdFdmenRrN2cveTZXYnBVUE8zVUVMVHU0?=
 =?utf-8?B?WWVNTlI4STNucFZiVWlERkh0VU1rWjNWOERWRVF6Z1E0YzZLSGJ4WDUxTWsr?=
 =?utf-8?B?alVtTUprMHRac01FS2Z5dHBPb0RqSk1ZY0FGVW9kRzZsQi9BT2tiM2ppZGpY?=
 =?utf-8?B?VWJOTDhrRWlOUVM2a0lsM1pvK2Q2YXlhbWVRdXo1WGFzeWJUMytmZS84R0RG?=
 =?utf-8?B?c2M4Y1lsYk5UbjZkam0ydHVtcFNQMUxtc2hGV0xiekZRaStxaVhaMUNZNGtY?=
 =?utf-8?B?TDlsNUNMc3I0KzZWaDJHUjhCNkF6Y3Y0KzBBSDZpMytGTGtXdW5PS2VHWFFZ?=
 =?utf-8?B?ZjVuMDRHeDN1K3FubStiV09GTTZtR3FSeGUzVnZyNDhocHNMalN4TlROaENU?=
 =?utf-8?Q?dY9VytsR+ZBuchtnr4sg2mWyHuWqTkn+ypA3/eH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <39D83EAA14C1314D9AF6E319B3E918B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba215d6-5dea-44ed-c69c-08d8e2f18c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 11:50:33.9516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFNp5P0rf8nLsfHAmXOlJ4Mj5enZUuyi65zDv/zi17K93Stbm15pFo/5kA5eDYYYV9YcmKDsOPqkwLoS8PD0HLX2LuivqG9SEGvTwuYGhlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3158
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTA5IGF0IDEwOjMyICswMDAwLCBUaG9tYXMgQmFja2x1bmQgd3JvdGU6
DQo+IERlbiA1LjMuMjAyMSBrbC4gMTI6MjYsIHNrcmV2IEx1Y2EgQ29lbGhvOg0KPiA+IEhpLA0K
PiA+IA0KPiA+IFRoaXMgY29udGFpbnMgc29tZSBuZXcgYW5kIHVwZGF0ZWQgZmlybXdhcmVzIGZv
ciBhbGwgb3VyIGN1cnJlbnRseQ0KPiA+IG1haW50YWluZWQgRlcgYmluYXJpZXMuDQo+ID4gDQo+
ID4gUGxlYXNlIHB1bGwgb3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBpc3N1ZXMuDQo+
ID4gDQo+IA0KPiBTb21ldGhpbmcgbm90IG1hdGNoaW5nIGhlcmUuLi4NCj4gDQo+IGZpbGVsaXN0
IGFkZHMgKi02Mi51Y29kZQ0KPiANCj4gV0hFTkNFIGFkZHMgKi01OS51Y29kZSByZWZlcmVuY2Vz
DQoNCk9vcHMsIHNvcnJ5LiAgSSBjb3B5L3Bhc3RlZCBpdCBhbmQgZm9yZ290IHRvIHVwZGF0ZSB0
aGUgbWFqb3IgdmVyc2lvbg0KKEkgb25seSB1cGRhdGVkIHRoZSBTSEExKS4NCg0KSSdsbCBzZW5k
IGEgdjIgcmlnaHQgYXdheS4NCg0KLS0NCkNoZWVycywNCkx1Y2EuDQo=
