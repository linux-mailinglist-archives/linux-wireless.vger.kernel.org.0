Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA535DF62
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbhDMMvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 08:51:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:45085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346109AbhDMMuA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 08:50:00 -0400
IronPort-SDR: 1KAl688eWe4g+sQ31PkCT2M1YHelNV+WSpRmmby4z95wGcGvgHrJj9MqeODsKtEjrQN72QC45l
 HiD/oerlndcA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194517558"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="194517558"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 05:49:40 -0700
IronPort-SDR: YxLQ5YEWBE6i4g0djfA5jIWy2bf4HPPRlyAsyvfrg3Gpp/yE+yK//UjtK2Wco8v2QhY5HWAIhV
 Ko/mvHczprPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="383301415"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2021 05:49:40 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 05:49:39 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 05:49:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 13 Apr 2021 05:49:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 13 Apr 2021 05:49:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV0Gzw8MeqF4i0Pv3FWL4C6hywFcyju3py3F1beTcCBSpzr0RGjZHg2jP4WRQe0RipudeqzH3rkXUh7K9eRI1pTPVgjHAEFRrayvePAWNUFMVs1VJarcuEUXFPKJu7mLnnd06/IgEN53cJQIw+xWCtbhP4bwGah1OsjWuID+/jbmgkPNN7b/ILkSTEXIDmYbRvTiOmqkFUDc8PU2Mj+48V5+aLRpVCBjio0LMqwyaghKkF/Gt0PsxNt5sP6AR2qWBznq/8mCsj7MkKhH12jZ5RaDW1eihXE4UlVh5j6ZUXIx3JAZU6nxppKmNTv5rzSOcMQhn0mU3dLzEsG7bEQAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEAwKrSCXd08Ko4lmKRPoFqaWeT1bSguvoM1To4aSDg=;
 b=nsCcqBK/QBCfabqsx/M5VzznVEUZFMTbNVGQsHGELtaodfNrQlQMUIFAuXuowDHJ4THsZM356SqI4blWAs/y3TjxyJmHdpxvrxntyc6xA80yiWxv1PCu4kIagbG/kPb5NjJF2ZcBKnXzxxt3tH05GueNqtPsDWMZV7xnO/gVK9CyFyUIGN5S/gtgW6e0iXmDscSyZx9wAI6tMFq/Ts4DW9z7g3TjpjodlFdhNGyhMhy/1nwFSdraxRHc6DaU/O+lHqAXEWONaU3/VblWMXgc7XQwpP+2eSfFR8fGY0XwQZ/8etLtBWC+Vbs2Rw/bnjVxO7LVHh8rOG2Tq7E31jfrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEAwKrSCXd08Ko4lmKRPoFqaWeT1bSguvoM1To4aSDg=;
 b=OmySAJXHCVlJ4xrsno/5/6JD7qt6nlIKOt0/ki8vkBQvAhWUJCRDVYVOFosj9+2lDg1VAsVK0dmmAzEA4KYlyYRD5ZnMgA7mk8wnYkBzP5n7cNELW/5tJeNCJB7KaHRNY92g6YIA4OSjlb37tKow64VMXcde4hFAsaXuPA/q8RU=
Received: from BN7PR11MB2610.namprd11.prod.outlook.com (2603:10b6:406:ab::31)
 by BN9PR11MB5482.namprd11.prod.outlook.com (2603:10b6:408:103::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 12:49:38 +0000
Received: from BN7PR11MB2610.namprd11.prod.outlook.com
 ([fe80::5480:4536:4082:eae0]) by BN7PR11MB2610.namprd11.prod.outlook.com
 ([fe80::5480:4536:4082:eae0%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 12:49:38 +0000
From:   "Peer, Ilan" <ilan.peer@intel.com>
To:     Ben Greear <greearb@candelatech.com>, Luca Coelho <luca@coelho.fi>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
Thread-Topic: [PATCH 06/12] iwlwifi: mvm: Add support for 6GHz passive scan
Thread-Index: AQHXJg5w+sLc3CukO06kSfTxTOYklaqd/7oAgBEn/cCAABSLAIAACi1wgABJI4CAAucZEA==
Date:   Tue, 13 Apr 2021 12:49:38 +0000
Message-ID: <BN7PR11MB2610C90612F45C833CD60B95E94F9@BN7PR11MB2610.namprd11.prod.outlook.com>
References: <20210331091452.543321-1-luca@coelho.fi>
 <iwlwifi.20210331121101.7c7bd00e0aeb.Ib226ad57e416b43a710c36a78a617d4243458b99@changeid>
 <aa0dae40-1565-2bb0-b33f-0da82a8de137@candelatech.com>
 <BN7PR11MB2610D9C80C698F837C3A2A55E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
 <eb60c152-81ac-2977-87fc-f724d4d6ccf0@candelatech.com>
 <BN7PR11MB2610CE4FAF07FFB017E19AB0E9719@BN7PR11MB2610.namprd11.prod.outlook.com>
 <8dfae5c0-1900-a1fc-ee36-8ceaa9ec0dbe@candelatech.com>
In-Reply-To: <8dfae5c0-1900-a1fc-ee36-8ceaa9ec0dbe@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: candelatech.com; dkim=none (message not signed)
 header.d=none;candelatech.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [147.236.145.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecf99bd4-088b-43e1-82f0-08d8fe7a992a
x-ms-traffictypediagnostic: BN9PR11MB5482:
x-microsoft-antispam-prvs: <BN9PR11MB5482BF9B630547B13ACB3378E94F9@BN9PR11MB5482.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:337;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 522JQ+pwsCo2LlUqrcDR3y04xj0I5mq76Mr9lRQ6mKjxd2YrnFCac9J8lqRCSh2peZ1Z9FIc7IO6Yp6CpexxuCAKMs7GQ1Zg04U9qSjod9IbCD1Fd0z/a2KP8PyjnBYrBPT5BHk7oQmO7p410u+Hvt6ZJfBg4NggZ5Ke4B3uH1YnXwtsNGNuVnXvotEagVyoDmc8H/WylVzC+g/XBhnIMHEnWKlpJx3ibAplTwggPZeDWyc4bAnRM319nVGS2uZzenePmkKidyK97QANRTyxp1McNTAVxWzwW3aOmdalHe9JXf60X1TixwWyqhrKmasJQCOZwvs7GNzYrtWO7ybK8H1np79LHTlj9wSNRo+jRRuDtycPJHfmngeynwT91L7HaUf4ftHqLCs1g2KsYOTEezVJTLiiKxe30LMXyPS8E/Lq8EhC9pUYtLgAwOQlHGgmqH7VbaUGDbsAb+GZq8VJ1+fE3BiF001pW5lYpOrIjYpSlANf4vtQmSizwPSju5Wjol3VVaAxo8qggB6ie49qnKi0rLWw+ZIKHpSAYm+N+kUflEIq4C3BCz/sDM7fKo/iK6Vs3BDkTu2k6t7P/2NWPxqOCvpoqeMZT43jJDTrfqY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2610.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(5660300002)(7696005)(26005)(2906002)(33656002)(53546011)(8676002)(110136005)(83380400001)(66946007)(316002)(66446008)(66476007)(6506007)(4326008)(52536014)(76116006)(55016002)(38100700002)(478600001)(9686003)(86362001)(8936002)(66574015)(71200400001)(66556008)(64756008)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Qys4bHVVOW9mdDU0YWI0aEtuUkxWMDR1MzVFUjFGNGlXYlN2ZnJieGFxWUNu?=
 =?utf-8?B?R3hsb0RweWpPWXNyRFg2c0dVeU5SeEJoYkF2blhXb3Q1N1orK29kL0U3Nm9Z?=
 =?utf-8?B?eGo3bXpCMjFwSUl6ODFuTURKdmJ0aHIyVHowU0kwcFhzMlNnNkFITk1rNGZs?=
 =?utf-8?B?YjNLdStJYk9UU3R2L1Q5RWp5ZUNqVit4NWpON0wwZDNtYWlmMkZzQVJYZzVH?=
 =?utf-8?B?RXkrZFBvTkNvdW91Uk16Tm9wajlzS0xwQzdvQ2VjOE1XYjAwN2JNa05vVTlE?=
 =?utf-8?B?L3Bud1Vaayt0b1hHNzdLNW9FVWdONzhnVHF2RjZ4VEMyQy9GQzg4eXFGRWhw?=
 =?utf-8?B?ekcrRjhKOVpQRkpzeUp2NTZGOG5nWnk3VUFBOHVsRnFURGd2dHVxQ0U0Qm8w?=
 =?utf-8?B?ejZoYzkzcndyQkl6VGoxay9abzBvbk9FQjhhK2YyK0Y1SmFuQ0FCSDdPa0JG?=
 =?utf-8?B?MGtqSEZtZCtTWHpRYjR0TjVxbGpLL2QzMVFYKy9ZVUpQRXdEMTF5SjUycFA5?=
 =?utf-8?B?YXdZMnRMMDBJMGxzcmlDWWw5Y1hzb1Rha0FhdW1UTnNpNEdnbnYxdCttc0E2?=
 =?utf-8?B?a1pSbklLeGdGdktkaGd4MEd5Zm56V3ZGOUxiYjhNOWpDZmNBMkJHdXorMVo2?=
 =?utf-8?B?OEl2S1BiazhIeUZNT05HRk5xQ0FyZDZHeHRkQ09IU28rTWZrME5sb2hLYlpM?=
 =?utf-8?B?dHBEZlBHc0l1L3h2WG5kV1ZvNzlRWitvcVBnaWM1YkFaTXZqSW1sNlYzSVlu?=
 =?utf-8?B?cGI4U0NxYlFYeWtIODl6OStEYjFycHhJaXNISjFjSmVHZnhqQ3lXOWhqNGtt?=
 =?utf-8?B?RTJFeEZJb2hBN2hnbDZXWjJZejFNTzVwQ01xTHpQTG5iZHhVMWxHa1hvNGdz?=
 =?utf-8?B?alMyQ1FULzdoK0JqNjUxUGVNOW5KWE91MDU1Smt6QXRHSTFSYVBHNXZVVlJv?=
 =?utf-8?B?amxEMTQwMmRmUjhodW00MzY5ek9lL3ZHeld2RGtWS3Q1UU8yM2RmK1hQb3Jj?=
 =?utf-8?B?eEI5N3lsSzdTdFVFNzJmd0lBZzdJUmJkUjhYTzJGOU9IV2d6M2w3azBxWHRF?=
 =?utf-8?B?c0JnVTROcTV0NzdsTm43a2VNZnpTbHRKZzdudUFEcE81Q0tId2cwd2JGMUh5?=
 =?utf-8?B?UEovdThLa093TEMwMG5LQzNEc0FlZGJpcnZBc0txSzBhQlFhNi9iMEhXODlx?=
 =?utf-8?B?TG1wNW9TZW1VSzRWbnVCYnRqUEhHVTFwSVNubms0MDllREczbFFiUFhjcHlZ?=
 =?utf-8?B?YWQxM3pmZjEwN29oZkxmNU1Zb2JnblR0NUh6SGhLZXVJL1A4NXd4aTRuSXZ0?=
 =?utf-8?B?RFN2aVRzbHZuY2VxODV2SjVEUVM1U05XL1JRQjZWSmpiSnhFUXJKTllZZEgr?=
 =?utf-8?B?Qi9XSjE3aEtUajdlVmd6ZGpnZ2wvcStDY3VpUG1haHJhUzlraTFycEpnTmtl?=
 =?utf-8?B?akQ4bktpa3JjWUVzQ3hMdTVRVENMTkpnTEdOdTBwVVpVWUpWOGJKRitJeTl1?=
 =?utf-8?B?aFh6bElMaUtNZkphRDlHK3ZjaDlPUXg2Z2ttUlVZSHcyRnhaVDFHZWRTWU9Z?=
 =?utf-8?B?ekVCWktuMTY0QVJ0enFmTnJMeFR0NlZyKzJPM2hEZ3JwUkowS3RKSTZFTnNi?=
 =?utf-8?B?emthaVYzai9XSldib3pUVXFnMmMwNm1kQk5HMmYwNEIvVVB0b0RDbEI4RWNw?=
 =?utf-8?B?c3VERjZ0NDZPZkN6NVp3MEYvSTNJT3RYbXVQd2docFZHMmFsREpTc3Fid09Q?=
 =?utf-8?Q?IYEP8AwJm0wtUi8GBwFpD1t2/3e0CwSHGAPgrok?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2610.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf99bd4-088b-43e1-82f0-08d8fe7a992a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 12:49:38.1260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVXoq8Z+HbuHRVfli1y0mxRo5IKhnrqiVsOFpVhfcZP790ZiowLYiVaqVicBEp7uExLHtWGLePKOlCWdkoXUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5482
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQmVuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJlbiBHcmVl
YXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiBTZW50OiBTdW5kYXksIEFwcmlsIDExLCAy
MDIxIDE5OjE1DQo+IFRvOiBQZWVyLCBJbGFuIDxpbGFuLnBlZXJAaW50ZWwuY29tPjsgTHVjYSBD
b2VsaG8gPGx1Y2FAY29lbGhvLmZpPjsNCj4ga3ZhbG9AY29kZWF1cm9yYS5vcmcNCj4gQ2M6IGxp
bnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA2LzEy
XSBpd2x3aWZpOiBtdm06IEFkZCBzdXBwb3J0IGZvciA2R0h6IHBhc3NpdmUgc2Nhbg0KPiANCj4g
T24gNC8xMS8yMSA1OjE0IEFNLCBQZWVyLCBJbGFuIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4+
PiBUaGlzIGxvZ2ljIGVuYWJsZXMgYSBzcGVjaWFsICdwYXNzaXZlJyBzY2FuIHdoaWNoIGlzIG5v
dCBkaXJlY3RseQ0KPiA+Pj4gaW50ZW5kZWQgZm9yIGRpc2NvdmVyeSBvZiBBUHMgZm9yIGNvbm5l
Y3Rpb24gZXRjLiBidXQgZm9yIGRpc2NvdmVyeQ0KPiA+Pj4gb2YgQVBzIHdpdGggY291bnRyeSBp
bmZvcm1hdGlvbiBpbiB0aGUgYmVhY29ucy9wcm9iZSByZXNwb25zZXMsIHNvDQo+ID4+PiB0aGUg
ZncgY291bGQgdXNlIHRoaXMgaW5mb3JtYXRpb24gYXMgYW4gaW5wdXQgdGhhdCBtaWdodCBhbGxv
dyBpdCB0bw0KPiA+Pj4gZW5hYmxlIDZHSHoNCj4gPj4gY2hhbm5lbHMgKHdoaWNoIGFyZSBzdXBw
b3J0ZWQgYnV0IGFyZSBkaXNhYmxlZCkuIFRoaXMgc3BlY2lhbCBzY2FuIGlzDQo+ID4+IGludGVu
ZGVkIGZvciBjYXNlcyB0aGF0IHRoZSBkZXZpY2UgZG9lcyBub3QgaGF2ZSBhbnkgb3RoZXIgcmVn
dWxhdG9yeQ0KPiA+PiBpbmZvcm1hdGlvbiB0aGF0IGFsbG93cyBpdCB0byBlbmFibGUgdGhlIDZH
SHogY2hhbm5lbHMuDQo+ID4+PiBPbmNlIHRoZXNlIGNoYW5uZWxzIGFyZSBlbmFibGVkLCB3ZSB1
c2UgcGFzc2l2ZSBzY2FuIGFzIG5lZWRlZC4NCj4gPj4+DQo+ID4+PiBXZSBnZW5lcmFsbHkgdHJ5
IHRvIGF2b2lkIHBhc3NpdmUgc2NhbiBvbiBhbGwgdGhlIDZHSHogY2hhbm5lbHMgYXMNCj4gPj4+
IHRoaXMgaXMgYSBsb25nIGZsb3cgdGhhdCB0YWtlcyBhdCBsZWFzdCA2IHNlY29uZHMgKGFzIHRo
ZXJlIGFyZSBzdWNoDQo+ID4+PiA2NA0KPiA+PiBjaGFubmVscykgYW5kIHdpdGggdGhlIGRpc2Nv
dmVyeSBtZWNoYW5pc21zIGRlZmluZWQgZm9yIHRoZSA2R0h6IGlzDQo+ID4+IG5vdCByZWFsbHkg
bmVlZGVkLg0KPiA+Pg0KPiA+PiBJZiB0aGUgc3RhdGlvbiBjb21lcyB1cCBhbmQgZG9lcyBhIDZF
IHBhc3NpdmUgc2NhbiBhbmQgZG9lcyBub3QgZmluZA0KPiA+PiBhbnkgQVAsIHBlcmhhcHMgYmVj
YXVzZSA2R2h6IEFQIHdhcyB0dXJuZWQgb24gMSBtaW51dGUgYWZ0ZXIgdGhlDQo+ID4+IHN0YXRp
b24gdHJpZWQgdG8gaW5pdGlhbGx5IHNjYW4sIHRoaXMgbWVhbnMgdGhhdCBpdCB3aWxsIHRha2Ug
NTANCj4gPj4gbWludXRlcyBiZWZvcmUgaXQgY2FuIGhhdmUgYSBjaGFuY2UgdG8gc2NhbiB0aGUg
QVAgYW5kIGNvbm5lY3QgdG8gdGhlDQo+ID4+IEludGVybmV0PyAgSWYgc3RhdGlvbiBjYW5ub3Qg
Y29ubmVjdCBhZnRlciBhIHJlbGF0aXZlbHkgc2hvcnQgdGltZSwNCj4gPj4gdGhlbiBJIHRoaW5r
IGl0IHNob3VsZCBzY2FuIGFzIHdpZGVseSBhcyBpdCBjYW4gaW4gb3JkZXIgZmluZCBzb21lIHBv
c3NpYmxlDQo+IHdheSB0byBjb25uZWN0Lg0KPiA+Pg0KPiA+DQo+ID4gVGhlIHB1cnBvc2Ugb2Yg
dGhpcyBoZXVyaXN0aWMgd2FzIHRvIGhhbmRsZSBhIHZlcnkgc3BlY2lmaWMgY29ybmVyDQo+ID4g
Y2FzZSB3aGVyZSB0aGVyZSBhcmUgbm8gQVBzIG9uIHRoZSAyR0h6LzVHSHogYmFuZHMgYW5kIHRo
ZXJlIGFyZSBvbmx5DQo+ID4gb25lIG9yIG1vcmUgbm9uLWNvbGxvY2F0ZWQgQVBzIG9uIHRoZSA2
R0h6IGJhbmQuIEJhc2VkIG9uIG91cg0KPiA+IHVuZGVyc3RhbmRpbmcsIHRoaXMgaXMgbm90IGEg
dmVyeSBsaWtlbHkgc2l0dWF0aW9uIGFuZCB0aHVzLCBkdWUgdG8NCj4gPiBvdGhlciBjb25zaWRl
cmF0aW9uIGUuZy4sIHBvd2VyIEtQSXMgZXRjLiwgdGhlIGFib3ZlIGNvbmRpdGlvbnMgd2VyZQ0K
PiA+IGRlZmluZWQuIEhvd2V2ZXIsIGFzIHlvdSBjYW4gc2VlIGluIHRoZSBwYXRjaCwgdGhlcmUg
YXJlIG9wdGlvbnMgdG8gdHVuZQ0KPiB0aGUgaGV1cmlzdGljIHRvIGJlIG1vcmUgYWdncmVzc2l2
ZSwgYW5kIGlmIGl0IHdvdWxkIGluZGVlZCBiZSBuZWVkZWQgd2UgY2FuDQo+IGNoYW5nZSB0aGUg
YmVoYXZpb3Igc3VjaCBjYXNlcy4NCj4gDQo+IFllcywgYW5kIEkgY2FuIHR3ZWFrIHRoZSBjb2Rl
IG15c2VsZiBpZiBuZWVkZWQuICBCdXQgYmV0dGVyIGlmIHVwc3RyZWFtDQo+IGRyaXZlciBpcyBh
bHJlYWR5IG5pY2UgYXMgcG9zc2libGUuDQo+IA0KDQpBcyBJIGVtcGhhc2l6ZWQgYWJvdmUsIHRo
aXMgZW50aXJlIDZHSHogcGFzc2l2ZSBzY2FuIGNvbmNlcHQgaXMgb25seSB0YXJnZXRpbmcgYSB2
ZXJ5IHNwZWNpZmljDQpjb3JuZXIgY2FzZSB0aGF0IHRyaWVzIHRvIGhhbmRsZSB0aGUgY2FzZSB0
aGF0IHdlIGhhdmUgbm8gaW5mb3JtYXRpb24gYWJvdXQgdGhlIGN1cnJlbnQgTUNDLg0KSSd2ZSBy
YWlzZWQgeW91ciBwb2ludHMgd2l0aCBvdXIgcmVndWxhdG9yeSB0ZWFtIGFuZCB0aGV5IGZ1cnRo
ZXIgZW1waGFzaXplZCB0aGF0IGZvciB0aGUgY29tbW9uDQp1c2UgY2FzZSBvZiBzdGF0aW9uIG9w
ZXJhdGlvbiwgYXMgdGhpcyBpcyBleHBlY3RlZCB0byBiZSBhIHJhcmUgY2FzZSwgdGhleSBwcmVm
ZXIgaGF2ZSB0aGlzIGxvZ2ljIGFzDQppdCBpcyBpbXBsZW1lbnRlZC4gDQoNCj4gPj4gQW5kIHdo
eSBjYXJlIGFib3V0ICdhdCBsZWFzdCA0IGNoYW5uZWxzJy4gIElmIHdlIGtub3cgdGhlIEFQIGNo
YW5uZWwsDQo+ID4+IGFuZCBjYW4gc2NhbiBleGFjdGx5IHRoZXJlLCB0aGVuIHlvdXIgY29uY2Vy
biBhYm91dCB0YWtpbmcgYSBsb25nIHRpbWUgaXMNCj4gcmVzb2x2ZWQuDQo+ID4+DQo+ID4NCj4g
PiBUaGUgYXNzdW1wdGlvbiB3YXMgdGhhdCB3aGlsZSBhIGNvbm5lY3Rpb24gd2FzIG5vdCBlc3Rh
Ymxpc2hlZCBhIGZ1bGwNCj4gPiBzY2FuIGlzIGV4cGVjdGVkLCBzbyB0aGF0J3Mgd2h5IHRoZSBh
Ym92ZSBjb25kaXRpb24gd2FzIHNldC4gSG93ZXZlciwNCj4gPiBJJ2xsIHRha2UgdGhpcyB3aXRo
IG15IGNvbGxlYWd1ZXMgYW5kIHNlZSBpZiB0aGlzIGNvbmRpdGlvbiBjYW4gYmUNCj4gPiByZW1v
dmVkIG9yIGRlZmluZWQgZGlmZmVyZW50bHkuDQo+IA0KPiBUaGUgY29tcGxleGl0eSBvZiB0aGUg
cmVzdHJpY3Rpb25zIGFyZSBnb2luZyB0byBzaWxlbnRseSBicmVhayBjZXJ0YWluIGNvbmZpZ3MN
Cj4gdGhhdCBhIHVzZXIgY2FuIHJlYXNvbmFibGUgZXhwZWN0IHRvIHdvcmsgSSB0aGluay4NCg0K
QmFzZWQgb24gdGhlIGludGVuZGVkIHVzZSBvZiB0aGlzIGZsb3csIHdlIGRvIG5vdCB0aGluayB0
aGF0IHRoaXMgaXMgZ29pbmcgdG8gYnJlYWsNCnVzZXIgY29uZmlndXJhdGlvbnMuDQoNCj4gDQo+
ID4NCj4gPj4gSG93IGVsc2UgY2FuIHdlIHRlbGwgdGhlIHJhZGlvIHRoYXQgNkUgaXMgYWxsb3dl
ZD8gIEkgcHJldmlvdXNseQ0KPiA+PiB0cmllZCBhbGwgc29ydHMgb2YgdGhpbmdzIHRvIGVuYWJs
ZSA2RSBjaGFubmVscyBzbyB0aGF0IEkgY291bGQgbW9yZQ0KPiA+PiBlYXNpbHkgc2V0IHRoZSBy
YWRpbyB0byBzbmlmZiBvbmUgb2YgdGhvc2UgY2hhbm5lbHMgaW4gbW9uaXRvciBtb2RlLCBhbmQg
SQ0KPiBoYWQgbm8gbHVjay4NCj4gPj4NCj4gPg0KPiA+IEFyZSB5b3UgYXNraW5nIHNwZWNpZmlj
YWxseSBmb3IgaXdsd2lmaSBkZXZpY2VzPyBJJ20gbm90IGZhbWlsaWFyIHdpdGgNCj4gPiBhIHNp
bXBsZSB3YXkgdG8gZG8gc28gb3RoZXIgdGhlIG9uZSBkZXNjcmliZWQgaGVyZSwgYnV0IEkgY2Fu
IGNoZWNrIGlmIHlvdQ0KPiBuZWVkIGl0Lg0KPiANCj4gWWVzLiAgYXgyMTAgaW4gcGFydGljdWxh
ci4NCj4gDQoNCldpdGggdGhlIGN1cnJlbnQgcmVndWxhdG9yeSBzZXR0aW5ncyB0aGF0IG91ciBO
SUNzIHNoaXBzIHdpdGgsIHRoZSByZWd1bGF0b3J5IHRlYW0gc3RhdGVkIHRoYXQNCmlmIHRoZSBk
ZXZpY2UgZmluZHMgZW5vdWdoIEFQcyB3aXRoIGNvbnNpc3RlbnQgY291bnRyeSBjb2RlIGluIHRo
ZWlyIGJlYWNvbnMgKGFsc28gb24gbGVnYWN5IGJhbmRzKSwNCmUuZy4sIFVTIGNvdW50cnkgY29k
ZSwgdGhlbiB0aGUgRlcgd291bGQgYmUgYWJsZSB0byB1cGRhdGUgdGhlIE1DQywgYW5kIGlmIHRo
ZSBNQ0MgZW5hYmxlcyB0aGUNCjZHSHogY2hhbm5lbHMgdGhlbiB0aGV5IHdvdWxkIGJlIGVuYWJs
ZWQuIFRodXMsIHRoZSBzcGVjaWFsIGNhc2Ugb2YgNkdIeiBwYXNzaXZlIHNjYW4gd291bGQgbm90
IGJlIG5lZWRlZC4gDQoNCj4gPg0KPiA+PiBJZiBhbGwgb2YgdGhlIDZFIGNoYW5uZWxzIGFyZSBt
YXJrZWQgYXMgcGFzc2l2ZSwgd2hhdCBoYXJtIGlzIGl0IHRvDQo+ID4+IGVuYWJsZSB0aGUgY2hh
bm5lbHMgaW4gdGhlIHJlZ2RvbSBmcm9tIHRoZSBiZWdpbm5pbmc/DQo+ID4+DQo+ID4NCj4gPiBB
RkFJSywgYXMgdGhlIDZHSHogcmVndWxhdG9yeSBpcyBzdGlsbCBldm9sdmluZywgd2UgYXJlIG5v
dCB5ZXQNCj4gPiBhbGxvd2VkIHRvIGRvIHNvLiBCdXQgb25jZSBhZ2FpbiwgSWYgeW91IGFyZSBp
bnRlcmVzdGVkIEkgY2FuIGZ1cnRoZXIgY2hlY2sNCj4gdGhpcyBvdXIgcmVndWxhdG9yeSB0ZWFt
Lg0KPiANCj4gWW91ciBwYXRjaCBlbmFibGVzIHBhc3NpdmUgc2NhbiBvZiA2R2h6IHdoZW4gbm8g
cmVndWxhdG9yeSBzcGVjaWZpY2FsbHkNCj4gYWxsb3dzIGl0Lg0KPiBJIHRoaW5rIGp1c3QgZW5h
YmxpbmcgdGhlIGJhbmQgYXMgcGFzc2l2ZSBpcyB0aGUgc2FtZSB0aGluZywgYnV0IHNpZ25pZmlj
YW50bHkNCj4gc2ltcGxpZmllcyB0aGluZ3MuICBJZiB0aGVyZSBhcmUgcmVndWxhdG9yeSByZWFz
b25zIHRvIG5vdCBhbGxvdyBldmVuIHBhc3NzaXZlDQo+IHNjYW5uaW5nIG9uIDZFLCB0aGVuIHlv
dXIgcGF0Y2ggYnJlYWtzIHRoYXQuICBJZiBub3QsIHRoZW4ganVzdCBhbHdheXMgYWxsb3cgNkUN
Cj4gY2hhbm5lbHMgdG8gYmUgYXZhaWxhYmxlIGluIHBhc3NpdmUgbW9kZS4NCj4gDQoNClRoZSBk
ZWNpc2lvbiB3YXMgbm90IHRvIGVuYWJsZSA2R0h6IHBhc3NpdmUgc2NhbiBpZiBub3QgbmVlZGVk
IGFzIGl0IGhhcyBhIGhpZ2gNCnBlbmFsdHkgaW4gdGVybXMgb24gdGltZSBhbmQgcG93ZXIgS1BJ
cy4gV2hlbiB0aGUgNkdIeiBjaGFubmVscyBhcmUgZW5hYmxlZCwNCm91ciBkZXZpY2UgZm9sbG93
cyB0aGUgZGlzY292ZXJ5IG1lY2hhbmlzbXMgZGVmaW5lIGluIERyYWZ0IElFRUU4MDIuMTFheCB3
aGljaA0KbWluaW1pemUgdGhlIHNjYW4gdGltZSBhbmQgb3V0IG9mIGNoYW5uZWwgYWN0aXZpdHks
IHdoaWNoIGlzIHRoZSBwcmVmZXJhYmxlIHdheS4NCg0KPiBUaGUgbG9naWMgdG8gb3B0aW1pemUg
c2Nhbm5pbmcgdGltZSBhbmQgY2hhbm5lbHMgYmVsb25ncyB1cCBpbiB0aGUgc3VwcGxpY2FudA0K
PiBhbmQgb3RoZXIgaGlnaGVyIGxldmVsIGNvZGUgdGhhdCBjYW4gdGFrZSB1c2VyIGlucHV0L2Nv
bmZpZyBhbmQgbWFrZQ0KPiBkZWNpc2lvbnMgdXNpbmcgaW5mbyB0aGF0IHRoZSBkcml2ZXIgd2ls
bCBuZXZlciBoYXZlLg0KPiANCg0KQWdyZWUgb24gdGhpcyBwb2ludCwgYnV0IHNpbmNlIGN1cnJl
bnQgd3BhX3N1cHBsaWNhbnQgdmVyc2lvbiBhbmQgb2xkZXIgb25lcyBoYXZlDQpubyBzdWNoIHN1
cHBvcnQgdGhhbiBpbiBwcmFjdGljZSBlbmFibGluZyBhbGwgdGhlIDZHSHogY2hhbm5lbHMgdG8g
YWxsb3cgcGFzc2l2ZSANCnNjYW5uaW5nIGJ5IGRlZmF1bHQgd291bGQgaW5jdXIgcGVuYWx0aWVz
IGluIHNjYW4vY29ubmVjdGlvbiB0aW1lIGFuZCBwb3dlci4NCg0KSG9wZSB0aGlzIGhlbHBzLg0K
DQpSZWdhcmRzLA0KDQpJbGFuLg0K
