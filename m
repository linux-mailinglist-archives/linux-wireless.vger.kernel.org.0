Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A79061E1C7
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Nov 2022 12:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKFLBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Nov 2022 06:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiKFLBn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Nov 2022 06:01:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C86DE99
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 03:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667732502; x=1699268502;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=eGzMGfR9EaocAQ9BbWVbEgpOPN2HngapI79kVXDtGrk=;
  b=K3WOpbvsaxwxRfvdgNhGcY43YmcgSA40cr08KEB++I1avu4aHTe2iBRm
   hgjxCsh7sqIn6vZAc01OpC1whVbm+2+R7hMrFojTSvhsth67L5OChCNJG
   29HHR4Y35iQ9XiqGHLqD6LNpfQaUWx2x5D2gGKagnM5km2ZERyJ2Eqe/N
   UMyBjh0MHrHVyuL39+OBOtDIA5KKpxd4dIxwSzqL6uqxdSfJgXJwCUPlA
   CaBwF3OO36SDocxoU278qJG2XaRzjW6rxKAtwDTXHpLybdWRErVtIxD++
   qEq50A0kxpRWtySj8PlaP2LT30bC6w/BZY1n6nWeUxcZeFutpxSwSAPFY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="311375049"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="311375049"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 03:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="760804579"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="760804579"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2022 03:01:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 03:01:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 03:01:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 6 Nov 2022 03:01:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 6 Nov 2022 03:01:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxb3thvFc7zwTQX0twzhX7e71tu9TEzKHYKro3R9Q6fStySmrj4B/lLhu6T5Hc2goSQ1i7za/0AKXhxrs1C89zTeVuxj9ffx88S0rXerlIFlSrrfF7s7zg5IrT/TfmEAAiRAaCV5nawU5PuFspnutRPtJRx14lJmfg2xlW806A/yZB1aGy81LZBWNkIbR78Gt6dm7ow3/4z4G9zA0FImjnc+ZJl4vwAIZJbfdEOAPAAcBHV53nDf1qxx1o0llfBLJ523k7QrhmoQ89yXS7Pb+Exv1+fNymqey8pRVEAmk7zuecqttdIdSeK+8nmd4Z4EfPPk39mZ57td8xqiXq8RsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGzMGfR9EaocAQ9BbWVbEgpOPN2HngapI79kVXDtGrk=;
 b=N81DstL+5M44tsTKDSj+gRQ0QeOfQe5fD1pjhOaki6+PXctV5dTUWLxyjBcykvBuf98jso8KdbfnGfAvJMnnD1XlS+Er7hXxpJ9rFWPR/qbqZkV4MmtuhEsgH6BJLalt1brlqlPeBtmie67QFtG3pbJ11Gqc9EFNf1TcMxn1d57ctIecq5DSNkArwETIY3eHQsBxRcjZ1GOFYWPfmK9gFLuykTzSc6kGrIkERDlfiC8cV9Uzf4wRtTAhmR/vDpA7InqLfo4hCsq3gkNbVyFWG3J+C0ZiN4xc9KtaKNX8pn6S63NU2zz3oyM/5u2gKTgD+fh/3ZYJBrOGWijmqu5ZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Sun, 6 Nov
 2022 11:01:39 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::5d7a:9a21:6238:25b]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::5d7a:9a21:6238:25b%9]) with mapi id 15.20.5791.022; Sun, 6 Nov 2022
 11:01:38 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-for-kalle-2022-11-06
Thread-Topic: pull-request: iwlwifi-next-for-kalle-2022-11-06
Thread-Index: AQHY8c8kWoJiM6QWfUCs6xB0aK3krA==
Date:   Sun, 6 Nov 2022 11:01:38 +0000
Message-ID: <141140c10cd372c03abccb0483548108de705565.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM6PR11MB4705:EE_
x-ms-office365-filtering-correlation-id: 63957db6-828c-46e7-2f98-08dabfe64712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bRoJKXAVSiPJggzQ0DzqI84BXxzMi9/dpMFfcVyU1WGv4A32qdIRoTxGZBLqMceGXbjj7jPpa68qWKI3UCdEFIvC8qkl0gN/5h8DHrWoZIWdLfKVngJBE6/ENN8tH1CGKlZceQrpTgLt9q81FN9iqMl6fTNj9jlo+1TjdzWWIN5Q1vuRLjq0YA5eONnGDwbieKraFszxbKhWyokbzvadN9/CPiMVbRQMpaCtVe2cmEVyd70aOyC5l9VPZtgUOHf1jQDDUa1jDTTOBCf/T7vOlRt3m7f2zS9lk9m038/Rf8GtgQ1LthiKwHbHIlnGeBJJYK2IyeHtnIswlPGoa0JQBQdiqPYdFZae/QhEApGCgQ1vGfDI4NAGC80LMJKVasjfNkMTQg/XOxf6+ndxsY47KpZp7BDgVSJJEZf7uWNsoX4m8hsQ0QQt3UOxQ1JzXkdfZFYLDSHQRpQ7QQZFS3QccWM7yJtE0kbH+j99zaPc86mDG4cGbZLZP8kT7ljHqL4Ma3S7KX0LH/m7NUIKA9i+T+/VaXCysyMhS+Bj7kh5oP6HMCEHV5T28TWAMX7cdY9ZDIaxS/PsKDt8LOdoBFKjuT6fNJMHlyewZcLTxgdBYLL82ol+SaMFIkSBTcB3iDcT6uI0xo5sa5Xw+B5/ivlImac5kWJOnZvY0/T67j6cx275LADlRVt/BobHsEQrHwowx65KyMU0JfsKj2epH4s3qxBBQA4gKfiANDsuonMQhdzmLevoHDLES1W5P2VJLfRMgARAOGSH4LzN2eYFd9vZJ+awk++q1REuiQ/1HlE7htU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199015)(966005)(6486002)(478600001)(71200400001)(5660300002)(8936002)(41300700001)(2906002)(6916009)(316002)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(8676002)(4326008)(91956017)(83380400001)(38070700005)(38100700002)(122000001)(82960400001)(6506007)(86362001)(186003)(6512007)(26005)(2616005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um1XUGM4aFo5S09sUXM1OTI4czBtV2RmOHZBMmRJRWtCOE5HWnU3OWowZWJz?=
 =?utf-8?B?SGNOVjFROG1zODRQWENGWFhUQ0JIK0ZCM250TnNOckw0K1pURHJVbVFPak0w?=
 =?utf-8?B?Uk1MbVd2UlVKQzhJOC9oUmpIWVZBMjgxTThJb2lkbGNqMWI2N2dDNzBlb3FU?=
 =?utf-8?B?VVZQbW5QUGdUcnhpVnNtd0NvZEZSWC8zUDF6Z0JSNTJSMjhpNlBhYmhqakxG?=
 =?utf-8?B?Q0xQb0NFQ3ZFdE1VUkhxcEEyaldueWNYNW16SldhMmI5VGl4Z0pNS21xM015?=
 =?utf-8?B?NDlaaWYvbEZuSW5YcjhzNnJrZ051dzFBaFk2b1Rvc0g2Zi9Qb2VTTHdoV0c2?=
 =?utf-8?B?U0kvS01wVFRuSWxlLysxRGhqRGlIUHYyS2tsQjQ4NmVxSWNjR1lCZ1VHVkdz?=
 =?utf-8?B?ejVoUGduQzhLME5hdkhBV3ZOaG9FNldBRnhMOEsrRmhlY0hPWjdvYlk2Rll3?=
 =?utf-8?B?b3BkMnhzVjl6KzlxTEpYR20ySkhYOHNkM2lJZnlBZ0szWGRmR1Z3TUdyZHdD?=
 =?utf-8?B?Z0pQTlMzUk9HSkxQMUxhS1ZBT2ZTb294ZkNOb2hoV1dHVEdkM3Bac0cxWkJG?=
 =?utf-8?B?dmJGakxNSHR3Z3pmOTYzTnVhNGp5cEdzaEZIRnltNUdUaXRNVnljbGltSW1h?=
 =?utf-8?B?UmtheHRMaE0zczdlaFN5U1VOdmJVU1NyQzN0Z05Yd3ROY2g1aStkeDZBZ0Vj?=
 =?utf-8?B?L0xxQ3gzcWRPNXFyMG9XZGN4eTZZTU03NWpGOU5FNE12YUIrV3UwNGVlT3h0?=
 =?utf-8?B?RFBsWVRTRHQ0YmRGRmVtVjdYV3FrT0VqTjNENXRsNEV5RGlUU0k1RWdHVlJ3?=
 =?utf-8?B?SzV6TzRnZ2ptczJMWWNVd0dNbXZlbkNMdkYyL09LWDM3U1F0cm9COUJRK0ZS?=
 =?utf-8?B?dm90Sm5hcWQ3cWpnTStlUnlPWkJRRWFjNHhMMkpYbkpYYk1EejhJRzNJUkpi?=
 =?utf-8?B?Rk5Fdi81VmZFbUdXVC9Sc2JEaVpydldYcjkvQldpNkF0QTk5anVTRFRqWmln?=
 =?utf-8?B?R3hoWHYrQTFSOXY4UFE0N0hnQXI0Y3VXeFAyME5vVkN0UWRHTFY2dzB0aEha?=
 =?utf-8?B?UUlWMXl0Y0I2dlZxKzlaaW1vanhxbnpLbmxpVnBZcHJZNFB5ZVEzRThqYU94?=
 =?utf-8?B?WEhMb3podzNiMUFoMWhXRERPUnJvc0Nhbmk4TlN6VGtQRG5OYWVvODJWZ3Rx?=
 =?utf-8?B?MTh4c1JIaEs4VmtyMEQ4ajFRTkpWTUVXNGNBeEsrVWpDNmlKT05EdjlRaDYr?=
 =?utf-8?B?TFBIZkc1cTRZeWlDSGNvMndPMG11KzFyWndwVUhxRUNhbzJVWmNISlZwdmRz?=
 =?utf-8?B?QW1sU1pUMnBabm5SekJ3T2J2YWpUZ2U0NXo3TWtaNGRDVDU2T2Z3ZUR2Y3Uw?=
 =?utf-8?B?ZWkzYUl1NkY1NzdQWWVHQ2l6eHQ0cXhwQVE0K0ZSNHBxR2VKN3dRWU9hRUFh?=
 =?utf-8?B?R1Yvb1o0aXVqSDJLd3dYMFlqazJFKzNtVjdETEd4SGlqZSt5THJHaHVNV3lx?=
 =?utf-8?B?cXV0ak5oSTJXbTc2M0kzRFNTU1BvTS9DdFpSbUZQQ3VMa2RYek9YRjdXVGdl?=
 =?utf-8?B?dnlpRlRqakJXa0xQd1pRaHFjVWpPdTkweU1LWWJ3MEpxam5mdmY2TEdUbHE0?=
 =?utf-8?B?NHl2VHBGaHpXZU1ycGxKMkxYaDF0d05JRUl6eXh6Ym9EM3pseE1FZmZPUHBi?=
 =?utf-8?B?UkEzdU1wbDNWWGpTelJJZ2k4VkhEcEdJR3YzSzJ4ZFNrOEtlc3NlOFFvaXZp?=
 =?utf-8?B?N1B2bzZIajRnUnRJRG9rdTI5Q2JIOGZURG1wcUhVUGxHbTZPTGlGWm9SSGJ5?=
 =?utf-8?B?b0xiMUZiOVNiNmVucVFKZEwyVWJEODJGRmpEekxGak5UTTdLRGxKTkQxNVZL?=
 =?utf-8?B?RFZYdU16bVFUSWxQOENzcVV6ejlJUHd2RlJOUEVPQ0QwRkhBOUZxUkFNb2tz?=
 =?utf-8?B?ZGFHZitSeWRCNmV4MEtOdjhiLzd0T21hSW1BOVQ1ME5xQjZiR2tzZHIxaXBK?=
 =?utf-8?B?dlFxQkh4NWRaYVNuWnlaQ2c3U2JtY09weVRsWHlLT1VEWE8vQkVUUGF6a1FZ?=
 =?utf-8?B?R04wcWZzeFlRWmprQXI5RmpTVTRhZ1VuSmdjRXA3SHlPdXRPVnZHM1Y5R2Fl?=
 =?utf-8?B?TlJIYmpsOTN4dzJiV09GcHlXeng3ZHpwcFAyZjJ0VnZPdWU1azVGRDJNK0sx?=
 =?utf-8?Q?QDOEbQ5aCzr6bbqcISMg8LY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C403FC704FF3346B9BF319707B5ED97@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63957db6-828c-46e7-2f98-08dabfe64712
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2022 11:01:38.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xf+1Nj9juLxrQa9CPrUWVXGIYRR6Ij4vM9UERWoyUvPlpK6a+84AdW1+CW8NUSclCbTUDGNulO1TYnPvqAQqmcYbgBgIhLx7/ZdKzyTslYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCkhlcmUncyBteSBmaXJzdCBwdWxsIHJlcXVlc3QgZm9yIHY2LjIgd2l0aCB0
aGUgbGFzdCB0d28gcGF0Y2hzZXRzIEkgc2VudC4NCg0KSXQgY29udGFpbnMgYnVnZml4ZXMgKG1v
c3RseSBtZWkpIGFuZCBjbGVhbnVwcy4gDQpUaGUgc2Vjb25kIHBhdGNoc2V0IGRlcGVuZHMgb24g
dGhlIGZpcnN0IG9uZS4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGFyZSBhbnkgaXNz
dWVzLg0KDQpUaGFua3MsDQpHcmVnb3J5DQoNCg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNl
IGNvbW1pdCBiZDk1NGE3ZTRhYTA3Mzk2MzA4ODRmYzU3MmQyZDBlNGRjZDE2ZTI1Og0KDQogIHdp
Zmk6IHJ0bDh4eHh1OiBVc2UgZGV2XyogaW5zdGVhZCBvZiBwcl9pbmZvICgyMDIyLTExLTA0IDEz
OjAxOjM1ICswMjAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoN
Cg0KICBodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdp
ZmkvaXdsd2lmaS1uZXh0LmdpdCB0YWdzL2l3bHdpZmktbmV4dC1mb3Ita2FsbGUtMjAyMi0xMS0w
Ng0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gNjhlZmFkZThlZjVjMDY1NmNmNDBk
NTExZGZhMzY3Njc2Mjk0MTEzODoNCg0KICB3aWZpOiBpd2x3aWZpOiBtZWk6IHdhaXQgZm9yIHRo
ZSBtYWMgdG8gc3RvcCBvbiBzdXNwZW5kICgyMDIyLTExLTA2IDEyOjAyOjQwICswMjAwKQ0KDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQppd2x3aWZpIHBhdGNoZXMgZm9yIHY2LjINCg0KUGF0Y2ggc2V0cyAwIGFuZCAxDQoN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCkF2cmFoYW0gU3Rlcm4gKDcpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiBz
ZW5kIFRLSVAgY29ubmVjdGlvbiBzdGF0dXMgdG8gY3NtZQ0KICAgICAgd2lmaTogaXdsd2lmaTog
bWVpOiBtYWtlIHN1cmUgb3duZXJzaGlwIGNvbmZpcm1lZCBtZXNzYWdlIGlzIHNlbnQNCiAgICAg
IHdpZmk6IGl3bHdpZmk6IG1laTogYXZvaWQgYmxvY2tpbmcgc2FwIG1lc3NhZ2VzIGhhbmRsaW5n
IGR1ZSB0byBydG5sIGxvY2sNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1laTogaW1wbGVtZW50IFBM
RFIgZmxvdw0KICAgICAgd2lmaTogaXdsd2lmaTogbWVpOiB1c2Ugd2FpdF9ldmVudF90aW1lb3V0
KCkgcmV0dXJuIHZhbHVlDQogICAgICB3aWZpOiBpd2x3aWZpOiBpd2xtZWk6IHJlcG9ydCBkaXNj
b25uZWN0aW9uIGFzIHRlbXBvcmFyeQ0KICAgICAgd2lmaTogaXdsd2lmaTogbWVpOiB3YWl0IGZv
ciB0aGUgbWFjIHRvIHN0b3Agb24gc3VzcGVuZA0KDQpFbW1hbnVlbCBHcnVtYmFjaCAoMik6DQog
ICAgICB3aWZpOiBpd2x3aWZpOiBtZWk6IGRvbid0IHNlbmQgU0FQIGNvbW1hbmRzIGlmIEFNVCBp
cyBkaXNhYmxlZA0KICAgICAgd2lmaTogaXdsd2lmaTogbWVpOiBmaXggdHggREhDUCBwYWNrZXQg
Zm9yIGRldmljZXMgd2l0aCBuZXcgVHggQVBJDQoNCklsYW4gUGVlciAoMSk6DQogICAgICB3aWZp
OiBpd2x3aWZpOiBtdm06IEZpeCBnZXR0aW5nIHRoZSBsb3dlc3QgcmF0ZQ0KDQpKb2hhbm5lcyBC
ZXJnICgzKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG1laTogZml4IHBvdGVudGlhbCBOVUxMLXB0
ciBkZXJlZiBhZnRlciBjbG9uZQ0KICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiB1c2Ugb2xkIGNo
ZWNrc3VtIGZvciBCeiBBLXN0ZXANCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogc3VwcG9ydCBu
ZXcga2V5IEFQSQ0KDQpMdWNhIENvZWxobyAoMik6DQogICAgICB3aWZpOiBpd2x3aWZpOiBjZmc6
IGRpc2FibGUgU1RCQyBmb3IgQkwgc3RlcCBBIGRldmljZXMNCiAgICAgIHdpZmk6IGl3bHdpZmk6
IG12bTogcHJpbnQgYW4gZXJyb3IgaW5zdGVhZCBvZiBhIHdhcm5pbmcgb24gaW52YWxpZCByYXRl
DQoNClJvdGVtIFNhYWRvICgyKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IGRiZzogYWRkIHN1cHBv
cnQgZm9yIERCR0M0IG9uIEJaIGZhbWlseSBhbmQgYWJvdmUNCiAgICAgIHdpZmk6IGl3bHdpZmk6
IGRiZzogdXNlIGJpdCBvZiBEUkFNIGFsbG9jIElEIHRvIHN0b3JlIGZhaWxlZCBhbGxvY3MNCg0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnLzIyMDAwLmMgICAgICAgfCAg
MzYgKysrKysrKysrKysrKysrKysrLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9mdy9hcGkvZGF0YXBhdGguaCB8ICA3OSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
aXdsLWRiZy10bHYuYyAgICAgfCAgIDcgKysrLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRl
bC9pd2x3aWZpL2l3bC1wcnBoLmggICAgICAgIHwgICA0ICsrKw0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvbWVpL2l3bC1tZWkuaCAgICAgfCAgMzAgKysrKysrKysrKysrKysr
Ky0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tZWkvbWFpbi5jICAgICAg
ICB8IDMwMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVp
L25ldC5jICAgICAgICAgfCAgMTAgKysrKy0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tZWkvc2FwLmggICAgICAgICB8ICA1NSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9NYWtlZmls
ZSAgICAgIHwgICAxICsNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9k
ZWJ1Z2ZzLmMgICAgIHwgICA0ICstLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL2Z3LmMgICAgICAgICAgfCAgIDkgKysrKysrDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vbWFjLWN0eHQuYyAgICB8ICA2MCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZt
L21hYzgwMjExLmMgICAgfCAgMjMgKysrKysrKysrKysrLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9tbGQta2V5LmMgICAgIHwgMjI2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oICAgICAgICAg
fCAgMTkgKysrKysrKysrKy0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9t
dm0vb3BzLmMgICAgICAgICB8ICAgMyArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL3J4bXEuYyAgICAgICAgfCAgIDggKysrLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9zdGEuYyAgICAgICAgIHwgICAzICsrDQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHguYyAgICAgICAgICB8ICAxNSArKysrKysrLS0N
CiAxOSBmaWxlcyBjaGFuZ2VkLCA3NzMgaW5zZXJ0aW9ucygrKSwgMTIxIGRlbGV0aW9ucygtKQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212
bS9tbGQta2V5LmMNCg==
