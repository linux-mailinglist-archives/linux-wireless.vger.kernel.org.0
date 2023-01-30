Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90FC680C76
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 12:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjA3LxC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 06:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjA3Lw6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 06:52:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3726A5
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 03:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675079573; x=1706615573;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=8jWcPa+VgNsGatDzr4QsYxX+jNdKMqUva73D1T6Z1t0=;
  b=hKqOeo+V8H5PZSvffa+XgJ4UPzRMsF1Sn0TlMKOJAl1aTFkitzRQzRrO
   qbW+z2CURf5WbJ1cg9pJNzZt8tVTEmCujCLSB127Me3Fgn1x/kk0Nerfj
   eTfQWgoj0gz1yixxYhn23uR9ckqNMWHFPmSDaWZvc8wqpClJImTOKEvOE
   SgjdUgtQtZH/ZIEMO7h7eZWAd70MUYovkNZI3uU3W3Dow1pE40CeQAuqw
   BZ0e40twwIApnQ4S9AtwHVTSHjo932YozVvTUPbA4OMktYI5iamhzit+l
   oz54WDI8aRgPu1QrLRLpHIyUsmVUG14d1K7lYTkQxS4JGBsiamw+cH+WO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="328812425"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="328812425"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 03:51:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="992874617"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="992874617"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2023 03:51:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 03:51:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 03:51:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 03:51:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 03:51:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmtNl2dHwbTadSkmYT4tHKv9Z5M5Z+lOq8KJ5/SYztvMYrg++gHDxsEH6z+0tQ/DEr3J+0tcd5cO4lch7rR4O3f/Gpu+Dyn+uiTpZfI3HmdJ/4btgaur/LaVNqDoU+Bi6PkC088/xrYLlMRWPkgnzl1TLD7sZI0NTAascEIKxeF2Gif5lBNL6JNoXiKz7v2cBiqZab//cKEyMWhN7k7dXP3+QgXDvu83Vyl/ER86aOVTvPbsXav0t5vS6qHEMgT0b9GPaa3rWDoxfZfJB4JqM8MvjSncyQ4JjlEtw9F4kK+qtR8N8/46spYGFWARNVjHsYWDbkMOrzqbQCpRp+FkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jWcPa+VgNsGatDzr4QsYxX+jNdKMqUva73D1T6Z1t0=;
 b=Tp5Ta1osWHvMmD7iXRhEzDSt7Qlt3gu1Nd7rkqLX0wpldKny7Mue9NT6lHkcnaFVys7aYhtFRVSk9qOGSFXtMaY867QldzGGl8V3Fmj84F3txuqzJnECWIq/lzpEnjO8aVrKL6fVLUgoSKD17v6KQIHsMUXcR23/as2d7n12A6ST4ix5SGBQWZ4iUq01Ku1WhsxiFtv3q3wTUub5R5rXHK3VetdukrXV+dDLgQfXwftDIrzi7D3ncBzU4t4Ur492/GZsOAAU7NiNXt5UFUQdcgLa6wnq+vuCdr2s+UfHl+RjqcTrIa7idA0ec+6ZVjw9gaHap6Gx47qqjP30eOsojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM4PR11MB6384.namprd11.prod.outlook.com (2603:10b6:8:8a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 11:51:18 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::81be:e0c7:8c53:8f9c]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::81be:e0c7:8c53:8f9c%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 11:51:18 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next 2023-01-30
Thread-Topic: pull-request: iwlwifi-next 2023-01-30
Thread-Index: AQHZNKEpTh22VE8eB0WLH8lShA4kVw==
Date:   Mon, 30 Jan 2023 11:51:18 +0000
Message-ID: <ddc23836b333327e83ac7a4f9096e9fd7219eed3.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM4PR11MB6384:EE_
x-ms-office365-filtering-correlation-id: ebda4b23-02eb-4097-8e3e-08db02b84c50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UmY4V263CDobJQHS5cwHYuQN1WdxtRduZ9ajOtSPDqu2vOhFyoHN2tGgdhHhU8NbJtoVT/tBe8Fc9ZGJRaHdVhcxu2whPA3MQ4P/c1p8E7DVf1PCyjGkzkEVAYuPeL0wL33TboAi4ftT+o4oEvmlFIDy5UjnQNB/02V/uxdtiZemCYOPzol9F9cpOk+Bi6/W/DAgWw0ItdpZKBa0DsXGhi+qwCbAOl1pdWH/8OvvMCk3X5MLxic58DFOKj6r7hI5KZp7U0o0zeiWKqManW2hGHza0yJtADAPvvo7oo7OLQx5jU+NRm+Sp1tSoi4dxrk7tnzI/JrWFwOTlxdj5X/dqqtdQR47Wb/g+zN/4YDngsdtf0aOoadS/w1N7xeGeiAg9tGoFNhHftB27xGHu6JmEmzlWl67S88DkwyKRCrGlaze3hrFadCXt1zAHdacFr7MonC+OJprMkUL9hp/GurbuPELDMFH7aiFdGLcEPV3r6Ob5mPHmXrARfRc88RPlUoQJK/lQEyBC07lMoaghvMmC9bjJvaU0m2YAdSzKtawNlKETQNNvZKxs/Idyw6bQt8x6fDC+rzIuiuOCYUF8wUOuOI0NnQDrVxT/f6uU/Hg0N3sSBSqu5RDgWctqSDDONJ2GsmTdzzq/39JIay19gz7PdbdAhXPxEZWtjvu62NteX6qIRDQ2wLwUQKELopUImvLuSBstOx5OkjTw6kJou217MXgKn1/1AF00D6EoIi+ig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199018)(71200400001)(8676002)(91956017)(66446008)(64756008)(66556008)(66476007)(6916009)(4326008)(41300700001)(66946007)(76116006)(8936002)(83380400001)(478600001)(86362001)(82960400001)(122000001)(316002)(2906002)(38100700002)(6486002)(26005)(38070700005)(6506007)(186003)(6512007)(5660300002)(966005)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXNaSS9xRUpMNHBvMmxtZzhXaFFQT2w2VHI4d0VVQndLcjdiaW94SldPVHZ3?=
 =?utf-8?B?aGp2SWZhd3RIOHE3MVBjM2trenRkSlM5eUZCWUViVjdpUnhkZ1RoRkxod0R6?=
 =?utf-8?B?emduRFVKZUFxZG1JeXlpdERpUWt3MWx1Y050a1g5VDBBLzkzNUZkMnk1M2N4?=
 =?utf-8?B?RTRwenhiWFhjK2xHNkVYWnlqVXlydUtYbktXQ09DV2tua1p4NlU0SmtYRmZ6?=
 =?utf-8?B?ejc4UjN3RHBJeWJ5NTdsYitteXpMcGJIT3JrVVZmNWM3WWVIZnU4YnJSSDlj?=
 =?utf-8?B?dU5heDhXRlFnSHB6VXNpRmZoY1JybUsxc1RjYzZJYmtkTnNsZjBQcHRSU0FT?=
 =?utf-8?B?L3h0MjFXeEVhUXA3QkxKa3V0SXlKd1RPNlQ2aWo2Y1dDMWF5TmcxeFEvY3Bx?=
 =?utf-8?B?dXRrODFod1M0RGNtRm9VSFJWK2E2dmZUTVZmcG83cm9tU3QxbUxQYW4wcktV?=
 =?utf-8?B?VlUzUEtSaXBNaXAzRTFycDYydmllN2JvS1N4eU96MkJieG1SVkNsd055Szc0?=
 =?utf-8?B?dVZHMGV1VWplSFJiUU1mMUR2cDNlT3lZWHlsMVBYK1NyQ08waVVSZWtmS3FI?=
 =?utf-8?B?bUZrR0R4T01xV1V2Z2k3azQxdUhZdE5scG5tb1Rpcitmc0YvcWdxVmlnTGds?=
 =?utf-8?B?T3ZBY1lMTEVWYldNUStnajMxWHZLd1N1T3NhQTZLblZOZnZBeWRzbzNQUUJN?=
 =?utf-8?B?TTcyS3lqbWEwREdCa1loTndxZU0rdWZ5VTlBSm9aRUJKUXlYRXdVOEFPTzU4?=
 =?utf-8?B?MzAxS01tczN2U3E0N2NqVnl0UStybkorSHhMQXh2emRPYzN1T0xPdWthZkRt?=
 =?utf-8?B?WU5UYWNiMUdBQ3REUnFVRVVCUkVPbU5neFBmYVVLcjdSckZtdUN1MmgxNHBT?=
 =?utf-8?B?VEwyMEZldnNXSVhuc2E3eVREWVVkT1lvSE9mS0RpT1R6ajdlakdmZ2h3RGZB?=
 =?utf-8?B?SnlWVThuSU1uenpWWVZlMHd1cXcybFZMSFFWSWJVSHRkNXU5cmUwSTVmZk83?=
 =?utf-8?B?SWlmTmJGR3RxMGcyWDNRbU8rak9hcGJrRmc4WmJzMTkyVDVFVlB1WStuSVhX?=
 =?utf-8?B?eFg4SGtNWm9aMEZ1WG53Y0wreXdLU2VYY2FNTkRHRVF1SHhNMFM5QzRaNEtO?=
 =?utf-8?B?djN5L05VM0FZb2ZKVjBtVStCTmo3TTV1S0x6aUg3cG56K2ZidGY3YTN6Q0dk?=
 =?utf-8?B?c2doRmhHRDNrSXh4YjdKbEZXSEt1MTVLc1ZiVU9WOUFTcG5laUNBUTQvNjlN?=
 =?utf-8?B?UG5yMnVCaENrV1NNSEg3NmxxNnhpLzJvU3IrczVndkJUTUdyRDcvdnRCZ1FD?=
 =?utf-8?B?QWUxZU9YN1N2K2pkcXRXRXNWbHBlWHluQ1VBYVBHd0Jsa2g5UTBEbzRDQ3Nn?=
 =?utf-8?B?dnRaWVhTZ1h4L0I4M1BKRFFtREt1MGQxajd6ek9ZZThGZDBmYm9OTElUTHoz?=
 =?utf-8?B?MWR5SzlDU2xBMTFFYm83elo1THRsTnZrakpwbFloc09lTkNJU2RhOHZRVURl?=
 =?utf-8?B?RkNsTysvYVY5SnFYMUhCa0RFZnNKOU9DTytBSEg4WThDZENpTittWEU5b3RR?=
 =?utf-8?B?ejMxRzFmRGtLUDFQOVkzTjZweDdZK2c3L3p2UFY2djlKK3g5Uk1ZeU54dlZJ?=
 =?utf-8?B?ajVuRVBQSDBjNVJXVXFiQ3NiU1loT0Y2NVd0RVdZcGpaOVpWR3luS1Q2MS9F?=
 =?utf-8?B?b0REMGNWa0dwSXEzazVScHQxWEc4c3lQaFdsTWsvOWxTOUk5YURWSGIzS0FT?=
 =?utf-8?B?UXdzVU5qMDFIRnJlTHFMOVZhZUdWL0t6dkRXR04xVklNcDdDWDhtZmxVYzk2?=
 =?utf-8?B?NGF2WHM1eE91L3VCNE00WVJuYkxSTjQ5ckdYZmF6ZTk4RHZKdXl4ZEM5cndX?=
 =?utf-8?B?d3pXc1FWY3I2djdKR3VPcVplUXRqbEs3Zzdyb3ZGUVZZdk9SckxPcUdRc3lL?=
 =?utf-8?B?cUg0R2Vad3ZELzJPd3l1aTdNR0poQ3puYVY4WFdrV2JJWUdCN3dCYStqWG8z?=
 =?utf-8?B?WFZ1ejdKR0V3UDdvemVrMkUrSzZkZjE2elAzZWFaenN0R1ZRTEZmcHNpUENk?=
 =?utf-8?B?a1pISXE1NC9wQlE0Y1IvZDNzdlc2Q3h3bGh3d3d1aFNtT0pXaTB1aC9DdVlk?=
 =?utf-8?B?QTl2UzY0NUk4LzVUWllqVWZXYkM3TXA5dVgzMWd6SllyS2ZxOW5wS1h6bjZm?=
 =?utf-8?Q?7UOLCS7t0r2xmfv2tO/eKaw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <983EB8899E364E42800BAD5CC850E022@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebda4b23-02eb-4097-8e3e-08db02b84c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 11:51:18.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yezTwbigmiumiHW2MYSiNkMrjFPNEv8GhzK4FsypfTneKtlPr1DZQiy99aPzmIJGQZjab0772XE5QGHU1x2IjaNn0xHTm3DcxLuX2oSV/eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6384
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

SGkgS2FsbGUsDQoNCkhlcmUncyBhIHB1bGwgcmVxdWVzdCBmb3IgdjYuMyB3aXRoIHRoZSBsYXN0
IHBhdGNoc2V0IEkgc2VudCBhbmQgb25lDQppd2x3aWZpIHBhdGNoIGZyb20gdGhlIHNtYWxsIHBh
dGNoc2V0IGJlZm9yZSB0aGF0Lg0KDQpUaGlzIGlzIGFsbCBub3JtYWwgZGV2ZWxvcG1lbnQsIG5l
dyBmZWF0dXJlcywgYnVnZml4ZXMgYW5kICBjbGVhbnVwcy4gDQpNb3JlIGRldGFpbHMgYWJvdXQg
dGhlIGNvbnRlbnRzIGluIHRoZSB0YWcgZGVzY3JpcHRpb24uDQoNClBsZWFzZSBsZXQgbWUga25v
dyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhhbmtzLA0KR3JlZ29yeS4NCg0KDQpUaGUg
Zm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDRjYTY5MDI3NjkxYTAwMzkyNzliNjRjZmEw
YWE1MTFkOWM5ZmRlNTk6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgDQogIHdpZmk6IHdpcmVsZXNzOiBkZW55IHdpcmVsZXNzIGV4dGVuc2lvbnMgb24g
TUxPLWNhcGFibGUgZGV2aWNlcyAoMjAyMy0wMS0xOSAyMDowMTo0MSArMDIwMCkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogIGh0dHA6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaXdsd2lmaS9pd2x3aWZpLW5leHQuZ2l0
IHRhZ3MvaXdsd2lmaS1uZXh0LWZvci1rYWxsZS0yMDIzLTAxLTMwICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQpm
b3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gOWNiZDVhOGFiY2E5MDQ0NDFlMzY4NjFlM2E5
Mjk2MWJlYzQxZDEzZjogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgDQogIHdpZmk6IGl3bHdpZmk6IG1laTogZml4IGNvbXBpbGF0aW9uIGVycm9y
cyBpbiByZmtpbGwoKSAoMjAyMy0wMS0zMCAxMzowMDoyNSArMDIwMCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
DQppd2x3aWZpIHVwZGF0ZXMgdG93YXJkcyB2Ni4zLCB0aGlzIHBhdGNoLXNldCBjb250YWluczog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQoNCiogRUhUIHJhdGUgcmVwb3J0aW5nDQoq
IFNuaWZmZXIgc3VwcG9ydCBmb3IgRUhUIGFuZCBhIGZldyBmaXhlcyBpbiB0aGUgcmVsYXRlZCBj
b2RlDQoqIEEgZmV3IGdlbmVyYWwgY2xlYW51cHMgYW5kIHNtYWxsIGJ1Z2ZpeGVzDQoqIEJ1bXAg
RlcgQVBJIHRvIDc0IGZvciBBWCBkZXZpY2VzDQoqIEZpeCBhIGNvbXBpbGF0aW9uIGVycm9yIGlu
IG1laSAoaXQgc3RpbGwgZGVwZW5kcyBvbiBCUk9LRU4pDQoqIFNURVAgZXF1YWxpemVyIHN1cHBv
cnQgLSB0cmFuc2ZlciBzb21lIFBoeSByZWxhdGVkIHBhcmFtZXRlcnMgZnJvbQ0KICB0aGUgQklP
UyB0byB0aGUgZmlybXdhcmUNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQXlhbGEgQmFyYXphbmkgKDEpOg0KICAgICAg
d2lmaTogaXdsd2lmaTogbXZtOiBTdXBwb3J0IFNURVAgZXF1YWxpemVyIHNldHRpbmdzIGZyb20g
QklPUy4NCg0KRW1tYW51ZWwgR3J1bWJhY2ggKDEpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbWVu
dGlvbiB0aGUgcmVzcG9uc2Ugc3RydWN0dXJlIGluIHRoZSBrZXJuZWxkb2MNCg0KR29sYW4gQmVu
IEFtaSAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBidW1wIEZXIEFQSSB0byA3NCBmb3IgQVgg
ZGV2aWNlcw0KDQpHcmVnb3J5IEdyZWVubWFuICgyKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12
bTogYWx3YXlzIHNlbmQgbnVsbGZ1bmMgZnJhbWVzIG9uIE1HTVQgcXVldWUNCiAgICAgIHdpZmk6
IGl3bHdpZmk6IG1laTogZml4IGNvbXBpbGF0aW9uIGVycm9ycyBpbiByZmtpbGwoKQ0KDQpIZWlu
ZXIgS2FsbHdlaXQgKDEpOg0KICAgICAgd2lmaTogaXdsd2lmaTogaW1wcm92ZSB0YWcgaGFuZGxp
bmcgaW4gaXdsX3JlcXVlc3RfZmlybXdhcmUNCg0KSm9oYW5uZXMgQmVyZyAoMSk6DQogICAgICB3
aWZpOiBpd2x3aWZpOiBtdm06IGFkZCBtaW5pbWFsIEVIVCByYXRlIHJlcG9ydGluZw0KDQpNb3Jk
ZWNoYXkgR29vZHN0ZWluICgzKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHJ4OiBhZGQgc25pZmZl
ciBzdXBwb3J0IGZvciBFSFQgbW9kZQ0KICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiBhZGQgc25p
ZmZlciBtZXRhIGRhdGEgQVBJcyANCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogc2ltcGxpZnkg
YnkgdXNpbmcgU0tCIE1BQyBoZWFkZXIgcG9pbnRlcg0KDQpNdWtlc2ggU2lzb2RpeWEgKDEpOg0K
ICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiBSZXNldCByYXRlIGluZGV4IGlmIHJhdGUgaXMgd3Jv
bmcNCg0KVG9tIFJpeCAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IHJlbW92ZSBoIGZy
b20gcHJpbnRrIGZvcm1hdCBzcGVjaWZpZXINCg0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvY2ZnLzIyMDAwLmMgICAgICAgICAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9jb21tYW5kcy5oICAgICAgIHwgICAxICsNCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9kYXRhcGF0aC5oICAgICAg
IHwgICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvcngu
aCAgICAgICAgICAgICB8IDE0NQ0KKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy91ZWZpLmMgICAgICAgICAgICAgICB8
ICA1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvdWVmaS5oICAg
ICAgICAgICAgICAgfCAgMTkgKysrKysrKysrKysrKysrKysrLQ0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvaXdsLWNvbnRleHQtaW5mby1nZW4zLmggfCAgMjEgKysrKysrKysr
KysrKysrKysrKy0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtZHJ2
LmMgICAgICAgICAgICAgICB8ICAxMiArKysrLS0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL2l3bC10cmFucy5oICAgICAgICAgICAgIHwgICA0ICsrKysNCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21laS9tYWluLmMgICAgICAgICAgICAgIHwg
ICA2ICsrKy0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2RlYnVn
ZnMuYyAgICAgICAgICAgfCAgIDYgKysrLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9tdm0vZnRtLWluaXRpYXRvci5jICAgICB8ICAgNCArKy0tDQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vbWFjODAyMTEuYyAgICAgICAgICB8ICAgNyArKysr
KysrDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vb3BzLmMgICAgICAg
ICAgICAgICB8ICAgMSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0v
cnhtcS5jICAgICAgICAgICAgICB8ICA4MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHguYyAgICAgICAgICAgICAgICB8ICAg
NyArKysrLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2N0eHQt
aW5mby1nZW4zLmMgICB8ICAgNSArKysrKw0KIDE3IGZpbGVzIGNoYW5nZWQsIDMxNCBpbnNlcnRp
b25zKCspLCA2NyBkZWxldGlvbnMoLSkNCg==
