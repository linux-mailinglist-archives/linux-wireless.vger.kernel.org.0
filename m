Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F123E4D0A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhHITZp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 15:25:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:19544 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhHITZo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 15:25:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="201941501"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="201941501"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 12:25:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="421574028"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2021 12:25:22 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 9 Aug 2021 12:25:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 9 Aug 2021 12:25:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 9 Aug 2021 12:25:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 9 Aug 2021 12:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc5uXQaFDgsnhI3T9yhD9lJZdVz/WoxkHjfio/Wb4u1wyrp56iitt5OCyX69laj2AoQttAjWJnN9wOEkdJHBWHem2dE3ttwDunXlPkAUTymQuIsEtLT7y2PzSD21e4xnUcSUeYtwv1mDVxGhLC5dwygdrORykcg58L+Qb8IzymJnbiR6rSWFn3n0EQE0Xk/I0LWlveOYG4u8XLcbMlvx3+pwLr24b+Oz2PE4I3f4DJc/8SpC6WooZSxIGNronIx7E4Nm30unP36ewqVg4FniuRJK60PLG3RG3KDU9lm2XB9jpnRiiaTVl0y0fTNyejavlKxVzCEK1UT6Xo9SN6FY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnuNUAoJr3OrrPxCo0iTvgJRTrvor6qkPjEHSk4b8Tc=;
 b=bRRaFlrRaMW5QvI2iWYrNgmXVxyiOM64b7y0hBP/Xz3g4JlWyPeDQ/ydkbA2pTk55xvpKMHJYHWVio6KwYL5D+TsEQIYlK+z67KAL9PWqfEI7ldRXq9h3f3IGkqQeuHwxwlHimOU88s1PK7v9Tb50ikmmruW9qapQEXdjCLRMt3DlGdXq7kEfgRf9d3osQ9LzIB/5dsNkBCbecg/jEBweJRKw470vs+x8HfXSl8y1lP4Wj/9+hPr9nOA/GTyCC+W1yp9hPC9ER4VtOz6Ca3kvvAOP7HMf+5TthI72FiyVfVMNARPZRM3TpYsM5Pfja25Sh8x4XvEsF/ehbIb0kxjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnuNUAoJr3OrrPxCo0iTvgJRTrvor6qkPjEHSk4b8Tc=;
 b=daGzS6NgtQ9Q4tlwc5uEjx/SofQ14Ixg+MRk1kXM2Hw3c5zkmXtxdDMB1d28UUXsFUxAyywQt8I3mIqHV5RaPNbSbgLvAJX8uaXEOzXceUqPlK2Hi+QfrpLxI4SpEpD4i1GZzSQ0/tast838OQ7NVV4P4QQ0OhyJgGwo7JQN5sA=
Received: from SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24)
 by SN6PR11MB2797.namprd11.prod.outlook.com (2603:10b6:805:5a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 19:25:19 +0000
Received: from SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::4534:c66a:f050:3486]) by SA0PR11MB4752.namprd11.prod.outlook.com
 ([fe80::4534:c66a:f050:3486%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 19:25:19 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Emmanuel Grumbach <egrumbach@gmail.com>
CC:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "Beker, Ayala" <ayala.beker@intel.com>
Subject: RE: [PATCH v3 1/4] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Topic: [PATCH v3 1/4] iwlwifi: mei: add the driver to allow cooperation
 with CSME
Thread-Index: AQHXif89mPyUVY6cEEicwpT+rJZpFKtoYcMAgAJwcwCAAMHK8A==
Date:   Mon, 9 Aug 2021 19:25:19 +0000
Message-ID: <SA0PR11MB4752C25135622066C0CD9D9CF2F69@SA0PR11MB4752.namprd11.prod.outlook.com>
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
 <87bl7vi3o1.fsf@codeaurora.org>
 <CANUX_P3QE9xNnQLT=mHNDp4VCv37Bcjuvn9O1wQ4Btejjkbrvg@mail.gmail.com>
 <87k0l0c8pa.fsf@codeaurora.org>
 <SA0PR11MB4752B06F7330E6C14717E113F2F49@SA0PR11MB4752.namprd11.prod.outlook.com>
 <7f027e15-71a7-8843-7b60-91b57f88a553@broadcom.com>
In-Reply-To: <7f027e15-71a7-8843-7b60-91b57f88a553@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8b4ade1-4251-4ba2-23f3-08d95b6b6cfa
x-ms-traffictypediagnostic: SN6PR11MB2797:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2797E93F0E0EEC849D794A32F2F69@SN6PR11MB2797.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vgzRk5fOtrpcQnz0y+gaEsAXUFiLyoC622+oAqcbcArliwpfG5EbmzArIwI1VYj401GqCCxtSvtN3c219jY25O/RaBQSQjkrn86bJRmWbj6lGxS2jpX7M/2saapyRdbeop4cEIUSiFKebze29zZY0nZWoQaLYUEPKFJDJ+/veC+OB0et0XVS5qWarKVZTSrzrEPXZaujRKfrn3TmyndoManshLQnvXjVFxAZg5WAxcR7UNwJf7JcGmnLU5fGtp7EOIgfVME/f1diUCGfitqrEYzVUfq4mYTYm29RLkGl2K8w5ornIWZS/aEvIAPQ/4ORUWogph0E/vrmRU0Smiix4Tkt0rixQMWrdS9kho47+43qdqzHh1JCjta1hCaBNn8GlVA09LH3xVWKfM48RIbMBhxZmoxUPbxQEX4rI+RETFHGGCiAoB+XJ+q6u3K+/qsUCOvwZj+sTu+CMegv4z8YHE4oeldYXVC2vJB9RMdzgjj67VnK2Y/vUrQWwe/iWhgzEC26RcfjVb/oP4yvJddLrV9k4uFJ4AV/p95mAqmJUzP6f4JPnz54DI5mAqwa4l2YREdE34UWixUU4iiLzhRtIctIf2CpzeDgPuFNk9fosXGtJ+HjjkdoTNqLHlSn2mS2cDsPhAPo2KzAHxiDPWF4DrL4+LqYI10XEkVUHFIcseBHPT9BKuUzcOHQQQ3KbnW1JQ/pz6wJ1qpZXOH/fJM4Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(71200400001)(5660300002)(122000001)(107886003)(55016002)(53546011)(54906003)(38070700005)(9686003)(110136005)(316002)(38100700002)(8936002)(33656002)(478600001)(52536014)(8676002)(4326008)(64756008)(7696005)(86362001)(6506007)(186003)(83380400001)(66476007)(76116006)(26005)(66946007)(66556008)(2906002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjIrVWNwN2tRMmVnc1QrdWdIcVVFNkpCQjlkekpqRVJTSnBuemF5dlB2M2VL?=
 =?utf-8?B?UlpRVDdWYUJCVDFZLzhVUEk4dENxTW9EdEMzb1lPN3NTZDZPeXVoalFDU1M3?=
 =?utf-8?B?RXRCTThtempMSTllOGxqMDA4Nk9oNWMrUk9MbHd1ajZKaSsxdWJnQU1FdGdz?=
 =?utf-8?B?Z0x2Vk5XaHdsdVBjMGk5SDBYa2Y2QzJJMG82aUZIc3BML29GQTF5ZFpWVkJD?=
 =?utf-8?B?Vzg0MjBUMDUzY1Q2cEVRQWVURm0zT3VmY21IR2lnbkEwemNHWWZWWS9kVDg4?=
 =?utf-8?B?ekFqcVd4bDc3WXZGQVZZb2N6Smh4U2RHY3FkZytCYkJWWGU3S0F0MmF0SXZh?=
 =?utf-8?B?NGZkQmZBTlZRL0NGVHlqZ2NPYlZ1U1kyeXhMNXBYcDlwbGxETGw4cCs0czlC?=
 =?utf-8?B?a2tNNGlZbWhCUGtIRzI3WWxrUWZyK3hKMVdIaGRFay9KdVV3TWZtWkwxa0lM?=
 =?utf-8?B?VnY3eHpRWWZVL3h5NmZnS1dnZXQ3WUc5NEtOYytkT1dxSGJlSFJkb3ZUbFJ0?=
 =?utf-8?B?eHZSd3B5V2h2Rk90N1NrWExrMUxsREhsek5kYUxLcG9HZ0hWVFI5WCs2TkVD?=
 =?utf-8?B?aVlzVDNtcmJzdDJjeWo1eXBRMlRqRTRPMXc3dmc3OEE3cVFSeXpWU3pYbEgw?=
 =?utf-8?B?bW9XWkJqN3NocThiQXJVUWl3WFllaWVNUXVzMXRES2NkNjNReldpdXNjSStv?=
 =?utf-8?B?dGI1dmgwZTYwMHdzaHFsNGlLd056YzRvOGZyOHFoNDZWZ2E3cnJEcmVHSURC?=
 =?utf-8?B?Zmt4dDg3b0Q5MnZUaWUveCtidVV6dDVXSVJmOW1pZ29YVmxCRHI5cFRKRGpM?=
 =?utf-8?B?SkdkQjVneEtZWnlhK29LdEYyN3ZmcW1VSHdaQkxJODNER2hlUDNyekJtcTBu?=
 =?utf-8?B?ZmZNVTl4VGN6eFh5L0t0RG1GQWpTSnVKaTFIQndHdlhleHUxVXRyekRtTnlw?=
 =?utf-8?B?aVFMWnM1STg5OWZ4YjI5MzNhczRydVZheitWVE9NUEZ6QUdBcFR5UmRIb3VL?=
 =?utf-8?B?NW1jREg0Y3VySGJxbnk0VnIwK1V4aFF0UjdaMUtrazEzRmdqSGV6Sm1JREM1?=
 =?utf-8?B?OTBQcGw5ZmhzM1VrZ1h2UmdRbjRJbU5sT1dwVHU4YXgzV1I0TUdhVGxwNzdx?=
 =?utf-8?B?UFNzL1hIWXcxMjh2YzAxMG5HUkhLOWxZOTlkMndsMk5oS3RVMG40QVYwWitN?=
 =?utf-8?B?dDZ2U0krVlRTZHNPUDhWelJMd3Uya3MrWkRKM2trYVBNNEVpTnJGVDlsdG9p?=
 =?utf-8?B?R2NJNm4walQ3c2d0YnVjTm5JUXhGcDNCUXlJTHpKemhNbC8rYVFmVUpOOGFG?=
 =?utf-8?B?eGE1NG5lc1gyOW0xZDZ2SktsUXhsNUs1N2M4Y3FBYzBEOXo4SU9aQTZvanp6?=
 =?utf-8?B?K3BsK3FCU0dOZVVZNU4vMm8xWDQ3aE9KVHkzZjhDUmFGb1FCQ3p5bFh3YS9z?=
 =?utf-8?B?WFNCVnFlV25MZGRwajZUakhWSjBZK0VJNTh6ajFqeFd3Nmt4K3lYZEtraSsy?=
 =?utf-8?B?MFBDWVkvUE5FV0ZWWjQvcXAvQ2xNYlBleG1ONGduVE5Qc0tJdTFORm52Nmxq?=
 =?utf-8?B?Q3VoVVRac1ZobUliOS83RThsMEhZWU1mMFhEWWhxSjBTUkR2T1RWZWRTQmI0?=
 =?utf-8?B?bGZEVmQ2dU9YaGpMQ2NNRDhpY09YVjRNeXluMFRLcmg5Y1FXU3dvM1R2Ympu?=
 =?utf-8?B?TzlJakltbGlYdERUbWxCazMwTm9TMk9kMk9iK2h1Ui9OamozYjZ1cllscWh6?=
 =?utf-8?Q?FKEBMxT7INXa0UW3yhnRSHcktDcBZueKLlsL0nl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b4ade1-4251-4ba2-23f3-08d95b6b6cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 19:25:19.6103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rmtd7j10OSTSqRMF+3yGdgcnewOn+xV1HX3CyTAbd1lI6bo8dLkwpsX3zFEd0epON5ZvBmthsopdAikxjTIKSkIsUuZ2gpU6uP9RlLhkq40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2797
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBPbiA4LzcvMjAyMSA4OjM4IFBNLCBHcnVtYmFjaCwgRW1tYW51ZWwgd3JvdGU6DQo+ID4+DQo+
ID4+Pj4+ICsgICAgIEJVSUxEX0JVR19PTigodTMyKUlXTF9NRUlfQUtNX0FVVEhfT1BFTiAhPQ0K
PiA+Pj4+PiArICAgICAgICAgICAgICAgICAgKHUzMilTQVBfV0lGSV9BVVRIX1RZUEVfT1BFTik7
DQo+ID4+Pj4+ICsgICAgIEJVSUxEX0JVR19PTigodTMyKUlXTF9NRUlfQUtNX0FVVEhfUlNOQSAh
PQ0KPiA+Pj4+PiArICAgICAgICAgICAgICAgICAgKHUzMilTQVBfV0lGSV9BVVRIX1RZUEVfUlNO
QSk7DQo+ID4+Pj4+ICsgICAgIEJVSUxEX0JVR19PTigodTMyKUlXTF9NRUlfQUtNX0FVVEhfUlNO
QV9QU0sgIT0NCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICAgICh1MzIpU0FQX1dJRklfQVVUSF9U
WVBFX1JTTkFfUFNLKTsNCj4gPj4+Pj4gKyAgICAgQlVJTERfQlVHX09OKCh1MzIpSVdMX01FSV9B
S01fQVVUSF9TQUUgIT0NCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICAgICh1MzIpU0FQX1dJRklf
QVVUSF9UWVBFX1NBRSk7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKyAgICAgQlVJTERfQlVHX09OKCh1
MzIpSVdMX01FSV9DSVBIRVJfTk9ORSAhPQ0KPiA+Pj4+PiArICAgICAgICAgICAgICAgICAgKHUz
MilTQVBfV0lGSV9DSVBIRVJfQUxHX05PTkUpOw0KPiA+Pj4+PiArICAgICBCVUlMRF9CVUdfT04o
KHUzMilJV0xfTUVJX0NJUEhFUl9DQ01QICE9DQo+ID4+Pj4+ICsgICAgICAgICAgICAgICAgICAo
dTMyKVNBUF9XSUZJX0NJUEhFUl9BTEdfQ0NNUCk7DQo+ID4+Pj4+ICsgICAgIEJVSUxEX0JVR19P
TigodTMyKUlXTF9NRUlfQ0lQSEVSX0dDTVAgIT0NCj4gPj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICh1MzIpU0FQX1dJRklfQ0lQSEVSX0FMR19HQ01QKTsNCj4gPj4+Pj4gKyAgICAgQlVJTERfQlVH
X09OKCh1MzIpSVdMX01FSV9DSVBIRVJfR0NNUF8yNTYgIT0NCj4gPj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICh1MzIpU0FQX1dJRklfQ0lQSEVSX0FMR19HQ01QXzI1Nik7DQo+ID4+Pj4NCj4gPj4+
PiBUaGVzZSBsb29rIGp1c3Qgd2VpcmQsIGFuZCBzdXNwaWNpb3VzLiBZb3UgYXJlIHVzaW5nIHR3
byBkaWZmZXJlbnQNCj4gPj4+PiBlbnVtcyBidXQgdGhleSBoYXZlIHRvIGJlIHNhbWUgdmFsdWVz
LCBvciB3aGF0Pw0KPiA+Pj4NCj4gPj4+IEV4YWN0bHkuIEkgZG9uJ3Qgd2FudCB0aGUgdXNlcnNw
YWNlIHRvIGhhdmUgdG8gaW5jbHVkZSBhbGwgdGhlIFNBUA0KPiA+Pj4gcHJvdG9jb2wgaGVhZGVy
IGZpbGUuIE9UT0gsIEkgZG9uJ3Qgd2FudCB0byBoYXZlIHRvIHRyYW5zbGF0ZSBiZXR3ZWVuDQo+
ID4+PiB2ZW5kb3IgY29tbWFuZHMgYXR0cmlidXRlcyB2YWx1ZXMgYW5kIHRoZSBTQVAgdmFsdWVz
Lg0KPiA+Pg0KPiA+PiBXaHkgbm90PyBJIGFzc3VtZSB5b3Ugd291bGQganVzdCBuZWVkIGEgaGVs
cGVyIGZ1bmN0aW9uIHdpdGggc3dpdGNoDQo+ID4+IHN0YXRlbWVudHMgdG8gInRyYW5zbGF0ZSIg
YmV0d2VlbiBlbnVtcywgbm90IG11Y2ggbW9yZSBsaW5lcyBvZiBjb2RlDQo+IGJ1dA0KPiA+PiBh
IGxvdCBjbGVhbmVyIGNvZGUuDQo+ID4+DQo+ID4NCj4gPiBJIGRpc2FncmVlIHRoYXQgaXQnbGwg
Z2l2ZSB1cyBhIGNsZWFuZXIgY29kZS4NCj4gPiBXaGF0IHdlJ2xsIGhhdmUgaXMgdHdvIGRpZmZl
cmVudCBlbnVtcyB3aXRoIHR3byBkaWZmZXJlbnQgdmFsdWVzIGFuZA0KPiBmdW5jdGlvbnMNCj4g
PiB0aGF0IHRyYW5zbGF0ZSBmcm9tIG9uZSB2YWx1ZSB0byBhbm90aGVyLiBUaGlzIGlzIHZlcnkg
YnVnIHByb25lLiBXaGVuIHlvdQ0KPiB3YW50DQo+ID4gdG8gZGVidWcsIHlvdSBnZXQgYSB2YWx1
ZSwgeW91IGFsd2F5cyBuZWVkIHRvIHRoaW5rIG9mIHdoYXQgdHlwZSBvZiBlbnVtDQo+IHlvdSdy
ZQ0KPiA+IGRlYWxpbmcgd2l0aC4NCj4gPiBJIGJlbGlldmUgeW91ciBzdWdnZXN0aW9uIGlzIG5v
dCBnb29kLCBidXQgc2luY2UgSSBhbSB0aXJlZCBhcmd1aW5nIEkgd2lsbCBkbyBpdA0KPiB0bw0K
PiA+IG1ha2UgeW91IGhhcHB5Lg0KPiANCj4gSSBkb24ndCB3YW50IHRvIGZsYXJlIHVwIHRoaXMg
ZmlyZSBmdXJ0aGVyLCBidXQgaGF2ZSB5b3UgY29uc2lkZXJlZCB0bw0KPiBkZWNsYXJlIHRoZSBl
bnVtIHZhbHVlcyBuZWVkZWQgYnkgdXNlci1zcGFjZSBpbiB1YXBpIGhlYWRlciBhbmQgc2ltcGx5
DQo+IGRlY2xhcmUgdGhlIFNBUCBlbnVtIHVzaW5nIHRob3NlIHZhbHVlczoNCj4gDQo+ICNpbmNs
dWRlIDx1YXBpL2l3bG1laS5oPg0KPiANCj4gZW51bSBzYXBfY2lwaGVyIHsNCj4gCVNBUF9XSUZJ
X0NJUEhFUl9BTEdfTk9ORSA9IElXTF9NRUlfQ0lQSEVSX05PTkUsDQo+IAlTQVBfV0lGSV9DSVBI
RVJfQUxHX0NDTVAgPSBJV0xfTUVJX0NJUEhFUl9DQ01QLA0KPiAJCToNCj4gfTsNCj4gDQo+IFNl
ZW1zIGxpa2UgYXNzdXJhbmNlIGVub3VnaCB0aGF0IHVzZXItc3BhY2UgYXBpIGlzIGNsZWFubHkg
c2VwYXJhdGVkIGFuZA0KPiB1c2luZyB0aGUgc2FtZSB2YWx1ZXMuDQo+IA0KDQpZZWFoLCBJJ2xs
IHRha2UgdGhhdCBvcHRpb24uIEFsdGhvdWdoIGl0IGlzIHdlaXJkIHRvIGhhdmUgdGhlIENTTUUg
ZmlybXdhcmUgQVBJDQp2YWx1ZXMgZGVmaW5lZCBieSB0aGUgdWFwaSwgYnV0IEkgZ3Vlc3MgaXQg
aXMgdGhlIGJlc3Qgd2UgY2FuIGRvIGhlcmUuDQpJJ2xsIG5lZWQgdG8gYWRkIGEgY29tbWVudCBv
biB0aGUgdWFwaSB0byBtYWtlIHN1cmUgdGhhdCBpZiBhbnlib2R5IHdhbnRzIHRvIGFkZA0KYSB2
YWx1ZSwgaGUnbGwgZmlyc3QgY2hlY2sgdGhlIENTTUUgZmlybXdhcmUgdmFsdWUuDQoNClRoYW5r
cyBmb3IgdGhlIHN1Z2dlc3Rpb24hDQoNCkthbGxlLCBhbnl0aGluZyBlbHNlIGJlZm9yZSBJIHNl
bmQgdjY/DQo=
