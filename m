Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB84F6DD644
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 11:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDKJJN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 05:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDKJIr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 05:08:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B934ED0
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681204079; x=1712740079;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=aZRNxl3amvIU4b19bDkng3SgGAfXa+xvBIyQSriuboM=;
  b=UuLKDqN6PJRa0fLQ/DPcySWdxHcT+SCa8bAiJlpMFOIaVAWhVqVU6fa5
   uKSCYpnSH7TGlNBiYkDqvotsdEYcNpdPXWv3GAkG9cKMjjUI6CSU/UmC2
   +0fo7SbqYjGJ1Mr3c/DhF/Yr3//Qtrv3U1mlIOubIwVj9eMS2YKRE+PKq
   f1EqNW98v5r/OY1ChVOt+FVee8mOBzEO0efI8HNDI/q4gmHpfyfdQo++T
   eXnx4GCGyyZQYjnTVw7d1HGWNNNHHhm0YpjyqbA47xqeYDX1iKvC2TrqH
   K2GQ9fG7Sie8ltOr3sap7VH7LX4enwmHOjiXrK+/j8t62waPszkQP2QKA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341053104"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341053104"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 02:07:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="718897812"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="718897812"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 11 Apr 2023 02:07:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 02:07:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 02:07:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 02:07:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjrQstzeVcPYn4Z4wZekh8pJ7prKhFjCA+SR5zj0Nb/JjUi08QTKUjw/ODWQ+X4Fk76lo68XQlWDlzwUIj191sBTGImOa+cs3UrtuIDZrgicGAjh8Q7/gf+MK82M26VvLQ6/zOvUUIZQ2wj2Gk8ei3iBZHM3WNgHxmbPS8MFoZPALuLw3N6dny8sYrONIqUrS01E0Bht0owKw6cw/FsZ31U15kDNpobKt2V3X99IbrlT2rkVIEY1dQOZqrRj7E9o2xE1YCcMa/0l1FwSuoIxrvXIPh4tWvsBle9RlkB7mGcuLRQvQy+qAsd0h1rSTIi3kMxWxifZlnYWLsHpnBBvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZRNxl3amvIU4b19bDkng3SgGAfXa+xvBIyQSriuboM=;
 b=NmVxD/RSPL4DV+MsnQg0cfMJmczIqsk4dloeYeK8i/Im0SQYAhnKxqjT6FVTjtfARJbMWc/RlOL6j+p7OM38ZSj00kruFmRaXEkI3sur752hwexUxfTEW6LH7JIYIr6qvg97op0IZWIMx30oQ56Lk9uisEhA4s5HHeB5kuusQKmScdiQZRsKy7i5VbuHmwMAuhd3n+Ytn07xIGSvzxEYqnEb72O3F89sOydWB8anTvR/oaXX9/PmbsteUoz/BZ0m2phaKIs7DxUu7JSBmS/ozN7IplqwV+NsYlRDrcQT9J/xgd5HPg/gl15Kjbtwkau8TT2UJXEqWl8vREFJ7o+BNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM4PR11MB8177.namprd11.prod.outlook.com (2603:10b6:8:17e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 09:07:35 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330%7]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 09:07:35 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "acd@woods.net" <acd@woods.net>
Subject: Re: ax204/Intel NUC13 i9
Thread-Topic: ax204/Intel NUC13 i9
Thread-Index: AQHZaYdfgiy/osc0GEaeIZzlECkjwa8gVxAAgAAJYICAAAMAgIAAHjGAgAAYOoCABH6jgIAAvo2A
Date:   Tue, 11 Apr 2023 09:07:34 +0000
Message-ID: <f2850fbe3264ff4a0bc5eef367c515975f15da54.camel@intel.com>
References: <9AEF6A8A-44F0-4863-9467-44C137D7430A@getmailspring.com>
         <6B4C1859-60D3-449E-8617-D20B9B06F5A0@getmailspring.com>
In-Reply-To: <6B4C1859-60D3-449E-8617-D20B9B06F5A0@getmailspring.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM4PR11MB8177:EE_
x-ms-office365-filtering-correlation-id: 1f06df1c-6c57-4b93-abba-08db3a6c306b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V891c2JWKXmqme0fGmgVDsDoCJ+pEiemrOnf60rUQ/BjeV08S9AU/c7QaRDW9VM4hQs8bfYctR/5hR9qPQHCfdVAKbBI5WhAuPxOkziIQ/Z8C86wy19/4vVJveM8Eo11CjR/Ej+wVbDXMXUFpcmC/WUFrXbvGlg1V8bdoN1REuGpXk4WKTY4iL7MmGTpXGTA/f+q39R2fDOqxeHaopX8HaPwDjFh9ATIbZR+wIiIvf7loZ+MqQdBqLR9Ko9Nt55AdbzLQvzDPVmidS/hrLc7GyuHfGasqZE1lTNgIvqPJ1EDGvjUK4FXmrJduZwmtN/IW1RNiqsZovg5GQpX6iVVze92IAryKL4WMsVDZIe3WYMzpZo3/HXnBr+p/4ZIl/qrBM7qLlaEd6F5yqQt15WD3X5RRWKSuPOSpCZtsh080jPyaiwwhRmeXnee9/1QDRr4W5/qlRaq7tRN9trBDhPdr7OKaTNImI3Kb87/egwIhaj/kUbNr1Kaw7bl1aCs7pn63xUvojQq1f2TfDqbasWXMmiiOmD8XlxSUnpmxhuncgQuNYTqdN5ndEUpZInGOyecB4DrAtHHAFgGP3UYmVGO/OGFLIiIEgOGrEhaE435mqY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(66946007)(91956017)(76116006)(26005)(86362001)(316002)(6512007)(6506007)(110136005)(66476007)(66556008)(66446008)(64756008)(186003)(36756003)(966005)(6486002)(71200400001)(478600001)(8676002)(8936002)(2616005)(38100700002)(41300700001)(122000001)(5660300002)(38070700005)(2906002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NklvdExzRmIxZW9hK3Z0dmpWRE02K0pIcDZHT3Y0MENrTHdmVHltTG82U0xk?=
 =?utf-8?B?dWFPdTc1ZUl0clY0RmdMWmlZaWp4aHBuMUt1TmNER1gyb3A2WkMzSHIyaDYy?=
 =?utf-8?B?N1B5T1BuS0E3UUJ5ekhjN1Q3bEJuS1FiNXVhTnUvZFVrVUlkN3pNNFlKSUtQ?=
 =?utf-8?B?bGg0VGlyYldBRC8xYXBNVXBoTnBwSytBL2ZPRFo1RU1ZNlIwUnprd1RRY1lE?=
 =?utf-8?B?V3FNN3hzUUl5UnljU3lEWDM3VnR1M05EZno0KzhDdGNCQlFLcVdNajlTRTdv?=
 =?utf-8?B?MDdnakVaL0kydkxqeC9DTzN6bGw1M0k4ak5WMFpVeTk0TlczQysramMwQXlB?=
 =?utf-8?B?QmVYWWlvSWlvRHVyaVdNTzZWY1k3YXlWVThRYi81N2NFSWxHbjN1blQxQmo0?=
 =?utf-8?B?MHhadjlldnJVell4MDU2L0dITnJaR0RJeTRobXZocjU5R2c5clI4S2RxdHp0?=
 =?utf-8?B?dmtNN3MwNnMvY2I5OEFQa3grbCszdzJMUG9NQmdocEJOVFN6cGdKd3c4OHhZ?=
 =?utf-8?B?azQvemt3L3BMSlZpeHJFY1hGYkZTOXA1K1h0WnZKYUcwQkx1d0VRNTZyNFlo?=
 =?utf-8?B?Q1FGSUxTam1qMWVkWnVhKzlTTXVDRFNhS2xiQWdsd25BTmNqdUlubFNCcWw5?=
 =?utf-8?B?RWF5UnJQd2EzU3RBQ05PcmdOdjZaNVREQ3I0WUpWWjNnYXlucEpId1dHaTFo?=
 =?utf-8?B?NDdiTjludkpndGdsVUpIWFFOOHNPVmxrM3I4MlMwUkl6SzA1TTRNYTRlNWhx?=
 =?utf-8?B?bjcrS0pqNThQUXJnYXdRYWdZZWQyTUpzcVpXL1UyNDB1bXQ4bGM4SWFyNTl0?=
 =?utf-8?B?QnU0NTk1NzRhTERaQzBlYUZKRS9DNGt0MnlkZFhTbTZBVkRuakY4ZWM3K0dL?=
 =?utf-8?B?cWh4aENkNHllakx0eEpYb0hCQUVWTDlzUXI2NkFRRnU0c0pHUUEzaHJtd3JD?=
 =?utf-8?B?ZXVFM0ViVVB1aUVNdFViYk1HSnVZMzhGOHprZm42TXRsWGJQQVBNL0dpandj?=
 =?utf-8?B?OUEyTngvZ2lXN2hiUkFMNkJKMmIvYXRKQ0FmamplbFJxTmxSU1pucHpQNm5l?=
 =?utf-8?B?VEN4dXVkdi9pSk1yM2o1UGRBV1VlemlYN3hJbHVIeDlEODFlK2kweDc4eC9G?=
 =?utf-8?B?RGwvaVZ0Ny9yaDJiN3ZQc0lmTVFzNFpxMzZqejEvUmhEaVFjQnp4V0hCbVlr?=
 =?utf-8?B?dnlsLytZQkxPWmtTSlZodmVRRUpYSFNIS1NSNWtZeGNEVjhEWmhmVE9vNTdn?=
 =?utf-8?B?cUtsL04yK0VoZXM0U1J6VFRtOFptdDNpY2puWlF5RjIxVzVpV2hnaTQ3dnZr?=
 =?utf-8?B?aVUrdDI2TW1mMlhPd3hUcVZ5QmNxOGRVd2l0VmVpRkswQ2tIVjBndnhkcFpI?=
 =?utf-8?B?Uk5YaWk4VnRMRUFDNFVXbmgvT0piamlvOVdHT2l3TDBYUGxwbXJJUEQvMEtv?=
 =?utf-8?B?T3ZjOFA5TVpjdkUxZnYrNVJrS1pMaDZzQjRleFF2ZElUOWlxdVVLaCtqWGVi?=
 =?utf-8?B?Mml0eFhXckV4T0dzeDUrK0NXSm9RTnhiZGcwdFRNWnZ3SHN0Mys4QzNKbm1j?=
 =?utf-8?B?UHRyd2RyenVSS2VOZG9QSEJVYlB5YzVKTHViWVBNbkpYZ3FCbU4xUUJuT2Iz?=
 =?utf-8?B?UTYwRTFGZTJuNURSMzVjUE4xeHA4YkRBYmFwWStuUXllcFI4VXZzQTRJdEJH?=
 =?utf-8?B?OVYyaUNQU25DRHhESS9DZzQ5U09RWG1qOVlkYjFQM3JlZTVHMlJPeGdsNG5h?=
 =?utf-8?B?QjUySFErOGV5SElYS2F1QzQ2VnlGdzlTZncxbHZTbHNNWE5ZOHJEY3FFRmlC?=
 =?utf-8?B?Tml2MDF2WVRteVRmc3k3TXFuNUFsYXlnWjRqSGF6WGdNdlVXK1IyOENlNXhZ?=
 =?utf-8?B?NE10V1VIWEZrQWhOalNrV1FBbEYxYnU1RGxxMGxwbWJmZXM5STRnejRocjVq?=
 =?utf-8?B?bDMxajNBQjhVN1lzR3RzNThOenRDbWlvUERKSHpZMEhMWkRXWVRwZkNFN2dD?=
 =?utf-8?B?UGVRSFJpRHY3RndDaHFhRzRBVEMvc3VCQjhjT1I0ckY4cG5aQUZGNW5VdDQw?=
 =?utf-8?B?aEtyVXhITmdHYlcvMGlVbHVSdTZZYjI2ekRLZDltNnQ5Qk1vNVhNK0hSUmlw?=
 =?utf-8?B?SCtJN2g5akJTaitGUUpBdURQMnhUNGc1ZVlSUTNCcEJTNWFDRndyMk1hdVlP?=
 =?utf-8?Q?qaZogWc1zok4rjWMdXAmmbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3CC0B0B6E4B28409D4BDD16BDC126F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f06df1c-6c57-4b93-abba-08db3a6c306b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 09:07:34.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mc4bOqfN16fULB5NqfmI61EPUawBGclQMIUSs88H7bXE52EP4wTgGI2af4EyWZrRCjV/OIcUo6MGmJQbwe2BZMKEPK8gdlypIr8XZb1hWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8177
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTEwIGF0IDE1OjQ1IC0wNjAwLCBBYXJvbiBEZXdlbGwgd3JvdGU6DQo+
IFRvIHN1bW1hcml6ZSB1cCB0byBub3cgYW5kIHJlYm9vdCB0aGUgZGlzY3Vzc2lvbjoNCj4gDQo+
IEkgaGF2ZSBpbnN0YWxsZWQgZmlybXdhcmUtZ2l0LiBUaGlzIGlzIHRoZSBmaWxlIHRoYXQgd2Fz
IGV4dHJhY3RlZCBpbnRvIC9saWIvZmlybXdhcmU6DQo+IC1ydy1yLS1yLS3CoCAxIHJvb3TCoCBy
b290IDQyOTQ2OTk4MSBBcHLCoCAyIDEwOjQ3IGxpbnV4LWZpcm13YXJlLWl3bHdpZmktZnctMjAy
My0wMy0zMC50YXIuZ3oNCj4gDQo+IFRoZSBjYXJkIGlzIG5vdCBzdWNjZXNzZnVsbHkgaW5pdGlh
bGl6ZWQgYnkgdGhlIHN0b2NrICg2LjEuMjApIGtlcm5lbDoNCj4gW8KgwqDCoCAyLjI4NDE4M10g
SW50ZWwoUikgV2lyZWxlc3MgV2lGaSBkcml2ZXIgZm9yIExpbnV4DQo+IFvCoMKgwqAgMi4yODQy
MjFdIGNyeXB0ZDogbWF4X2NwdV9xbGVuIHNldCB0byAxMDAwDQo+IFvCoMKgwqAgMi4yODQyMjNd
IGl3bHdpZmkgMDAwMDowMDoxNC4zOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikNCj4g
W8KgwqDCoCAyLjI4NjEzM10gaXdsd2lmaTogTm8gY29uZmlnIGZvdW5kIGZvciBQQ0kgZGV2IDdh
ZjAvMTY5MiwNCj4gcmV2PTB4NDMwLCByZmlkPTB4MzAxMGQwMDANCj4gW8KgwqDCoCAyLjI4NjE1
NV0gaXdsd2lmaTogcHJvYmUgb2YgMDAwMDowMDoxNC4zIGZhaWxlZCB3aXRoIGVycm9yIC0yMg0K
PiANCj4gVGhlIGRpc3RyaWJ1dGlvbiBpcyBEZWJpYW4gQm9va3dvcm0gKHRlc3RpbmcpLCB3aGlj
aCBoYXMga2VybmVsOg0KPiBMaW51eCBzaHJ1YiA2LjEuMC03LWFtZDY0ICMxIFNNUCBQUkVFTVBU
X0RZTkFNSUMgRGViaWFuIDYuMS4yMC0xDQo+ICgyMDIzLTAzLTE5KSB4ODZfNjQgR05VL0xpbnV4
DQo+IA0KPiBUaGUgY2FyZCBpZGVudGlmaWVzIGFzIDB4N0FGMCwgMHgxNjkyOg0KPiAwMDoxNC4z
IE5ldHdvcmsgY29udHJvbGxlciBbMDI4MF06IEludGVsIENvcnBvcmF0aW9uIEFsZGVyIExha2Ut
UyBQQ0gNCj4gQ05WaSBXaUZpIFs4MDg2OjdhZjBdIChyZXYgMTEpDQo+IMKgwqDCoMKgwqDCoMKg
IFN1YnN5c3RlbTogUml2ZXQgTmV0d29ya3MgQWxkZXIgTGFrZS1TIFBDSCBDTlZpIFdpRmkgWzFh
NTY6MTY5Ml0NCj4gwqDCoMKgwqDCoMKgwqAgRmxhZ3M6IGZhc3QgZGV2c2VsLCBJUlEgMTgsIElP
TU1VIGdyb3VwIDYNCj4gwqDCoMKgwqDCoMKgwqAgTWVtb3J5IGF0IDYwNGMxMjQwMDAgKDY0LWJp
dCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQ0KPiDCoMKgwqDCoMKgwqDCoCBDYXBhYmls
aXRpZXM6IFtjOF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDMNCj4gwqDCoMKgwqDCoMKgwqAg
Q2FwYWJpbGl0aWVzOiBbZDBdIE1TSTogRW5hYmxlLSBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0
Kw0KPiDCoMKgwqDCoMKgwqDCoCBDYXBhYmlsaXRpZXM6IFs0MF0gRXhwcmVzcyBSb290IENvbXBs
ZXggSW50ZWdyYXRlZCBFbmRwb2ludCwgTVNJIDAwDQo+IMKgwqDCoMKgwqDCoMKgIENhcGFiaWxp
dGllczogWzgwXSBNU0ktWDogRW5hYmxlLSBDb3VudD0xNiBNYXNrZWQtDQo+IMKgwqDCoMKgwqDC
oMKgIENhcGFiaWxpdGllczogWzEwMF0gTGF0ZW5jeSBUb2xlcmFuY2UgUmVwb3J0aW5nDQo+IMKg
wqDCoMKgwqDCoMKgIENhcGFiaWxpdGllczogWzE2NF0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0
aW9uOiBJRD0wMDEwIFJldj0wDQo+IExlbj0wMTQgPD8+DQo+IMKgwqDCoMKgwqDCoMKgIEtlcm5l
bCBtb2R1bGVzOiBpd2x3aWZpDQo+IA0KPiBHcmFudGVkIHRoYXQgSSBhbSBubyBleHBlcnQgb24g
dGhpcywgYnV0IEkga25vdyBlbm91Z2ggdG8gZ2V0IG15c2VsZg0KPiBpbnRvIHRyb3VibGUsIHdo
aWNoIGlzIHdoYXQgSSBwcm9jZWVkZWQgdG8gZG8uwqAgSSBiZWxpZXZlIChidXQgY291bGQNCj4g
d2VsbCBiZSBtaXN0YWtlbikgdGhhdCB3aGF0IGlzIG5lZWRlZCBpcyBhIGNvbmZpZ3VyYXRpb24g
bGluZSBmb3IgdGhhdA0KPiBQQ0kgSUQgaW4gaXdsd2lmaS9wY2llL2Rydi5jLCBzb21ldGhpbmcg
bGlrZSB0aGlzIG9uZToNCj4gDQo+IElXTF9ERVZfSU5GTygweDdGNzAsIDB4MTY5MiwgaXdsYXg0
MTFfMmF4X2NmZ19zb19nZjRfYTAsIGl3bF9heDQxMV9raWxsZXJfMTY5MGlfbmFtZSksDQo+IA0K
PiBNeSBhdHRlbXB0IHdhcyB0byBkdXBsaWNhdGUgdGhlbiBjaGFuZ2UgdGhlIG5ldyBsaW5lIGZy
b20gN0Y3MCB0byA3QUYwLA0KPiBidXQgdGhhdCB3YXMgYWxzbyBub3Qgc3VjY2Vzc2Z1bCwgd2l0
aCBzdWNoIGVycm9ycyBhcyAoY2xpcHBpbmcgYmVjYXVzZQ0KPiBpdCdzIHJhdGhlciBsb25nKToN
Cj4gDQo+IFsuLi5dDQo+IFvCoMKgwqAgMy45NjAxNjRdIGl3bHdpZmkgMDAwMDowMDoxNC4zOiBN
aWNyb2NvZGUgU1cgZXJyb3IgZGV0ZWN0ZWQuDQo+IFJlc3RhcnRpbmcgMHgwLg0KPiBbLi4uXQ0K
PiBbwqDCoMKgIDMuOTYwNTUxXSBpd2x3aWZpIDAwMDA6MDA6MTQuMzogU3RhcnRpbmcgbWFjLCBy
ZXRyeSB3aWxsIGJlDQo+IHRyaWdnZXJlZCBhbnl3YXkNCj4gW8KgwqDCoCAzLjk2MDU5NF0gaXds
d2lmaSAwMDAwOjAwOjE0LjM6IEZXIGVycm9yIGluIFNZTkMgQ01EIEFERF9TVEENCj4gW8KgwqDC
oCAzLjk2MDYwMF0gQ2FsbCBUcmFjZToNCj4gW8KgwqDCoCAzLjk2MDYwMl3CoCA8VEFTSz4NCj4g
W8KgwqDCoCAzLjk2MDYwMl3CoCBkdW1wX3N0YWNrX2x2bCsweDM2LzB4NTANCj4gW8KgwqDCoCAz
Ljk2MDYwNl3CoCBpd2xfdHJhbnNfdHhxX3NlbmRfaGNtZCsweDMzOC8weDQ1MCBbaXdsd2lmaV0N
Cj4gWy4uLl0NCj4gDQo+IEl0IGRvZXMgcHJvZHVjZSBhbiBpbnRlcmZhY2UgYnV0IGl0IGlzIHVu
dXNhYmxlLg0KPiANCj4gSSBhc3N1bWUgKGJ1dCBJIGFtIGRlZmluaXRlbHkgb3V0IG9mIG15IGRl
cHRoIGF0IHRoaXMgcG9pbnQpIHRoYXQgaXQgaXMNCj4gZHVlIHRvIHRoZSB3cm9uZyBmaXJtd2Fy
ZSBiZWluZyByZWZlcmVuY2VkIGJ5IHRoYXQgbGluZSBvZiBjb2RlIChpLmUuDQo+IGl0J3MgYSBk
aWZmZXJlbnQgZmlybXdhcmUgZm9yIDdGNzAgdnMuIDdBRjApIGJ1dCBJIGFsc28gZG9uJ3Qga25v
dyB3aGF0DQo+IHRoZSBjb3JyZWN0IG9uZSBpcywgdGh1cyBJJ20gYXNraW5nIGhlcmUuwqAgSWYg
SSdtIHRvdGFsbHkgb24gdGhlIHdyb25nDQo+IHRyYWNrLCBJJ20gZmluZSB3aXRoIHRoYXQgdG9v
LCBJIGp1c3Qgd2FudCB0byBnZXQgaXQgd29ya2luZy4NCj4gDQo+IFRoYW5rcyENCj4gDQo+IA0K
SGkgQWFyb24sDQoNCkNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB0aGUgd2hvbGUgZG1lc2cgbG9n
PyBBY3R1YWxseSwgdGhlIGJlc3QgaXMgdG8gb3Blbg0KYSBidWd6aWxsYSB0aWNrZXQgKGFzIGRl
c2NyaWJlZCBpbiBbMV0pIGFuZCBhdHRhY2ggdGhlIGxvZyB0aGVyZS4gSXQncyBzdHJhbmdlDQp0
aGF0IHRoZSBjYXJkIGlkZW50aWZpZXMgYXMgQ05WaSAobWVhbmluZyBpdCdzIFNvQyAtIGludGVn
cmF0ZWQpLCBidXQga2lsbGVyDQpOSUNzIHNob3VsZCBiZSBkaXNjcmV0ZS4gTWF5YmUgeW91IGNv
dWxkIGFsc28gYXR0YWNoIHRvIHRoZSBidWd6aWxsYSB0aWNrZXQNCmEgcGhvdG8gb2YgdGhlIE5J
QyBpdHNlbGYgd2l0aCBhbGwgdGhlIElEcyBldGMgdGhhdCBpdCBoYXMgb24gaXQ/DQoNClsxXSBo
dHRwczovL3dpcmVsZXNzLndpa2kua2VybmVsLm9yZy9lbi91c2Vycy9kcml2ZXJzL2l3bHdpZmkv
ZGVidWdnaW5nDQo=
