Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE837464DCF
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 13:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbhLAM1r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 07:27:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:11995 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235768AbhLAM1q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 07:27:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236391057"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236391057"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:24:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="540809764"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 01 Dec 2021 04:24:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 04:24:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 04:24:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 1 Dec 2021 04:24:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 1 Dec 2021 04:24:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6tnSssvwW8xVgT7krVKFFMV7azoW2T2+wtk+psMBxVoYFZoUuS+6BX9L+4qtzMfeMRCfmbpEBTwloQi5f3YtRBMEAtzP8Tpt7SIgFQsNgKrN7jMQlwn/PPDn3j2l3D3p9Jx8VMUvZiEZcXuVDHHTWvusyNeEgNOkC/y/ju2MTRhK6x3Wb0+9vMH8LgROOwU2s5DfdKjF5ee7jhL/rf0wViWeBaQVodZ3za18gAPN0b4cz9LFUNZcvVFiuOwU3rPglr+na12aE/vuLmuCJ8VtqZmKM8szh6XjmwJcTpCFTMT4mLvelytL0blMKmyRUWCiIqyduJhbAaS4YM3V+Z9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8E0nilZQXRlWW4cZIo2ZiuuXBKMQkZP7z+OSx05w8w=;
 b=JdCC56X4kEGWwOEdPwlgH4t3gPz22RmkAc8qH2Xwt2Q8g9WVhQjceSn5DPiTO6NX3objoG2gyeo4SMR4wkHnmX+aTEzWKBeGy09I5HJbWJbcnGM2KlCkQybUlpYrzTozXHpV/bZE1Ziw9/1LcQ0OUMJH+3vtdmbC6ERODrswSoG5mRFFh6R5F4/PsqJNS5DJOYBHRvgArAUNU9rrLR2vqdLGo8wcaOxpbMxFHV6/oy5a1zn/v8aqrJH9GOpdpo79ewCH/Lzyx4u1IKH+PzDXTIbtvs/talWapl+CxRpNO7b11Yo9Zsc2RNxIk0IHgzFK85BEZQ1nIhmF0sONZukIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8E0nilZQXRlWW4cZIo2ZiuuXBKMQkZP7z+OSx05w8w=;
 b=nNmCVqnVnMACvabpPSEbJm14zQA0Pp81e/43R2jnNrOTFt2zt/mpnxpolj1X33d/KD0+f11anA5FerSYyaUrPBttBohoJacID3Oy9aO6JhlykIL+RbNMxkgQmmBded4ZFDhI0C22s93sSDnDr7xktlA/2I122qFDugVStEDR2j4=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB3573.namprd11.prod.outlook.com (2603:10b6:a03:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 12:24:22 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f0a6:e61:94db:53b3]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f0a6:e61:94db:53b3%6]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 12:24:21 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: Re: [PATCH] iwlwifi: mei: fix linking when tracing is not enabled
Thread-Topic: [PATCH] iwlwifi: mei: fix linking when tracing is not enabled
Thread-Index: AQHX5q5e4GJT9NKPLESzZwGC08iiKQ==
Date:   Wed, 1 Dec 2021 12:24:21 +0000
Message-ID: <e4ae529aff4c6dc9de90e1f7dc6d31abd9abb382.camel@intel.com>
References: <20211201113411.130409-1-emmanuel.grumbach@intel.com>
         <87fsrco6r1.fsf@codeaurora.org>
In-Reply-To: <87fsrco6r1.fsf@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f000637-8279-4b7a-c710-08d9b4c5813e
x-ms-traffictypediagnostic: BYAPR11MB3573:
x-microsoft-antispam-prvs: <BYAPR11MB35739C4E313F3BEA5AF3E3FB90689@BYAPR11MB3573.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RTd7x6x7vF8yNyjuc2CNGmcjb70iBLnm9gwXpx1np1mdKSTv8SBho/WjCgVixgleR3TpzCIXqBNKYXxzBL3A5v4ZRmQ1Il7ci7sPR9+blfpKYpkg4echOUXWqVN0mH45xf8ku6eYHXaFahzTDIPrudb/cvzgNpf+oPyg1/jWMGGnjBPy8Ob8omOfM3sj8knOEPowF0+k1cKsC27IfrKJcKr8Si3UrWZSQWdzYa/+4AYBZ10hgayk7VuHXaa24oiDOYREG53u+5DJktTiVoL+kpY8GAfokvZpdslYcdT2a1054GucSrV5euSQStfW0iHuCKHGnoDSxGLDxzZ6aME1VVL7XDtOf2rRXufcWhSVFNiQM9VPwI/D85wVR01cn/eimKQBv/9KQQU3I+1D04vo1L2m4yLMCcmkCUoQ38PJV8LXZLlzdUMm67BSKM1akYLprH/Afw23sYdbnMZuRsBRN0Ju/EevybNeNf1wVyYB8PQcL+/XOFxw1iD2sSHDAn/yVrJkKHr/wkDpcD66fOaU354Wy7RX+TxqnSqgoKHFUQTBljgsj9lNQe8YycxnxIgENTGp52ek0ZcKhUl+gGcniGrJuM5mqF3LvltFzy7MC5tMPYBEh+LvMQBaE8sUMfx+hS3ibTrnltNR77jfd39//HmdhGhvN+HVebGF8IlfAy5sfYHdFdVXEUa8R7wma6lIdIejgzV5OXc3I1P7wG6aVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(508600001)(26005)(76116006)(6512007)(66946007)(66556008)(66476007)(2906002)(38100700002)(6486002)(83380400001)(38070700005)(36756003)(6506007)(82960400001)(6636002)(110136005)(4326008)(86362001)(122000001)(316002)(4744005)(64756008)(66446008)(8676002)(2616005)(71200400001)(54906003)(5660300002)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVgzbmhKOXJIaWlUdFYvNDZjeFZ4MlBzaFY0czdaL05VRzUrRE9LS2RCdkRQ?=
 =?utf-8?B?VjQxWTVuRi9lb2kyQXRpR0svbDJUTUNmWldwWEp2QjMzMkJ4djlSMkJNblF2?=
 =?utf-8?B?dzFUeGJ4ZTBBMGswTDUxQlZ3YVJxbHo0UVBtWGJMWEswaVBQbWhPa0Mrc1Y2?=
 =?utf-8?B?Qkw2Z3ZURU5rZmNqM3h4RDVXSkQrRmZGMDdmdE5neU9iV1hiNFBsbW5TMkJB?=
 =?utf-8?B?eUZWVHZsWUgwRC9IajhkU1IwazBTNHl3aFA4R1NtcVQ1cWZ6T2ttY0VsWHJ0?=
 =?utf-8?B?eW1OSU9FSnoxaUh1YUlwdTNyUHdMRmFxWC9HU2JORnl6OTZpb3VHUzVrQkFo?=
 =?utf-8?B?UDhTYnpnNS8ydVh4aEVuVS9WSkZBZjNVd3ArTGgrQ3VqQWdFUHR5VVhFWkNP?=
 =?utf-8?B?ZC85TjdIOExobVlQUXFQYy9CbmdvU2plZ0p4dFFFdDlucEF5M3ZVQkJoeVFj?=
 =?utf-8?B?U0pncXkrTzlBQURBclBoL0NSdnVGYXU4TVJCdnBOUEx3Y1ZMZUV1VXh6M3Ix?=
 =?utf-8?B?UW1CaWxsUmd2NXNjU3ljS0ZzU1RsSVBpRkpkNU4wdnkycHRKeW01K3pUcW9C?=
 =?utf-8?B?T0JGOVJhWWtvek5WWG8rd1hNbXVBSlN3ZW5CMGpYQnA0UzJmTU1jazJKNUhZ?=
 =?utf-8?B?UURmUGlveTJZMm8wU3ZKRnJxajVTQU5ydWNpTm5vdEJuUDlyQVRTcE9SdEYw?=
 =?utf-8?B?Q05EM09LbllIeEtDcjlEMmtUM0RUZ1hsa2JmZldsRkJYSEMzR1VrMEZsM2xB?=
 =?utf-8?B?dHFDdlVmZnR4OFpQdFBSbjFoRXY1RnVSa3BZZHpqOTl5UGtTVDRFeHI5L1hw?=
 =?utf-8?B?MFJpdkhpU3JVS3B4MDVQbXBrRzRMSWJGZlVVa1c1RlJwNTF6amlmS2NEUFVp?=
 =?utf-8?B?UkZMRzFwbkpvVlM0c2xnVjRDSUowY3k4aEQ3Rmc3WUYxQ0VjTklDRWtYYmUr?=
 =?utf-8?B?dUdYdDV4WUh0Nmt3TWJpeFQ1cXc0Zjh6NGtLZkxNb0t3alVTQTZxQ1hzNlN4?=
 =?utf-8?B?a3UwMDVzS0RhU0dMcUtMQ0RGSlN3VHo0SHl3M21tdk9RQld3TjZTKzllVFRo?=
 =?utf-8?B?K1BlU29tQ0hDMnovS3A5OWlPYU9xNDgwMjByNkVPdHpKc1ZFUjhyTFJzMjFS?=
 =?utf-8?B?ZkRTVUlyNVdVM0RqWnVKNmxZNEZOYld1MkFxdlNlelN5cUhHeFA3VWdZaVNW?=
 =?utf-8?B?L0NWa1Foc2xIckxTdnVkcEJYMWMxSGlTTm5wUk5KakJ0T292S1IrWHJ3dnR0?=
 =?utf-8?B?RUx3Um5BMUdxU1pNQnN5L1oyYWFXVmdDTnFURUtGZmNvV0RVOTVxN1JBdlVF?=
 =?utf-8?B?TUpmSlRGS1NtRmpEVFp4SEdScTZsZUd5aXByeWlvallraFJGd1VmN2M1V1ZN?=
 =?utf-8?B?MHdpR1FjSWJXTGhCZ2xML3YxUTNzYkRMbUtEZGU3VENpTVd5UlEwV2FSNEkz?=
 =?utf-8?B?eUZ3SmdQQ2ZoeGplZ0VkeHJkRUlNWUJHL0FkM2Qxa2JyWHRuWmpqcHlGejB3?=
 =?utf-8?B?ZjkxY2dzN1NjQ0VDVXVwNVdlQnFaSTM4RUtTV05EWjlhOVM1eS9XQVppWVRQ?=
 =?utf-8?B?SHJsUkhHaVNtVzJnYSsvZDhRejBaV25haVoyaVFsYkk2aGNwbFJjd1VPYytt?=
 =?utf-8?B?S1lBK0VFRUdhWWcvMFlxclRuQVVtem95cVJxR2JpQzNOMlhsRmNxMWJEanI1?=
 =?utf-8?B?SFBrL3RDaFlpTGZBMXFZdXM5R0ZaV2t6Wkg5SFdLUEh6dHN1R2lsUU9GZTZt?=
 =?utf-8?B?ZFZobm9oemR1d0p2V0YzKzBucERhV3lRRjZ2SEtDUmM3Z3VyUjZrTGVzaGR6?=
 =?utf-8?B?eFVsTE9iaXlUVDNNdzFwQmlTazdGR2EvZ0ljNXpxc0Y5blhXTkYxSjhiVW1u?=
 =?utf-8?B?NHk0NXA0d2N0b2FNWVlxS2ptT1BNNXhkTElqVjlVUWpCTVUrQVk0NVdtdW1R?=
 =?utf-8?B?c01ZR1NidTRGcnZyYlI1QkI1REx5clVIVkJEYmVLS0d2cXVGYnkzcWcwK0p3?=
 =?utf-8?B?WUVhWGZqSkszaEloZ29EQWhMVEc2d3QxMS9KZmNtekdGOFZwbVUvUTRPS0ZW?=
 =?utf-8?B?dmxPL3ZiaGxIYzdxSnUzcTdDbkdBUFgzbmFld3J1UlY2K25mRmEzQ2RWdXdP?=
 =?utf-8?B?WTdBaXF3QkFzZ01uV1BGTnYwTyt1a1VNaVRoTVJlY25lbHl6eGkvLzBqOXky?=
 =?utf-8?B?SURsb1NhMnc1RVA5eFZ0SEVIQll0ZFVBcS85M0wrazVTbkpsWlh6YVEwaXlo?=
 =?utf-8?Q?v5Adr4q0uqJCUjDEkvsklgigQk/w2N0TYVBNlWwLjk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1148BC65B17AA444843075FE9DEFBE02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f000637-8279-4b7a-c710-08d9b4c5813e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 12:24:21.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjtNXSI7vAKhZnyVjC81N2Cv2X8dsGATj9soNjNSzzbqX4YsVOkIXgX/vrxMdSOYxstZe2CAZeshlbAImCY04CuguSNZSxvQe0dYkegB0qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3573
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIxLTEyLTAxIGF0IDE0OjIxICswMjAwLCBLYWxsZSBWYWxvIHdyb3RlOg0KPiBF
bW1hbnVlbCBHcnVtYmFjaCA8ZW1tYW51ZWwuZ3J1bWJhY2hAaW50ZWwuY29tPiB3cml0ZXM6DQo+
IA0KPiA+IEkgZm9yZ290IHRvIGFkZCBzdHVicyBpbiBjYXNlIHRyYWNpbmcgaXMgZGlzYWJsZWQu
DQo+ID4gDQo+ID4gUmVwb3J0ZWQtYnk6IEppcmkgU2xhYnkgPGppcmlzbGFieUBrZXJuZWwub3Jn
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEVtbWFudWVsIEdydW1iYWNoIDxlbW1hbnVlbC5ncnVtYmFj
aEBpbnRlbC5jb20+DQo+IA0KPiBGaXhlcyB0YWc/IEkgY2FuIGFkZCB0aGF0Lg0KPiANCj4gTHVj
YSwgYXMgdGhpcyBmaXhlcyBhIGJ1aWxkIHByb2JsZW0gSSB0aGluayBJIHNob3VsZCB0YWtlIHRo
aXMgZGlyZWN0bHkNCj4gdG8gd2lyZWxlc3MtZHJpdmVycy1uZXh0LiBBY2s/DQoNClN1cmUhDQoN
CkFja2VkLWJ5OiBMdWNhIENvZWxobyA8bHVjaWFuby5jb2VsaG9AaW50ZWwuY29tPg0KDQotLQ0K
Q2hlZXJzLA0KTHVjYS4NCg==
