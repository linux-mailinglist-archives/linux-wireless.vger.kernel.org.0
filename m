Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAFF49D1D4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 19:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiAZSgg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jan 2022 13:36:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:23719 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbiAZSgf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jan 2022 13:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643222195; x=1674758195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r3yuA73ljWJd+zWAkNJ4eAkcyjkjvcnaZbRcwDYh7Mo=;
  b=YdwGel3wUU57v+owE730zA2Jt6EuHMTuqxy8+ZHv5wBs/IsRGp5e9/dr
   QWb99tUhsKOe0XrbrJcb++gj603+bUrLcAgLsQjxToNWrwfDD72joMMv5
   pHZOtxqipX9bH1CoIqI3toST7JcvSBz+y2u4EmAZlxwG6pr8wes1TfrHz
   7a/0LiRQ6sBhNN7CcR/kDhoB62Bg2mL+69j8aDuVM0kElf0O56e3GjqGz
   UxvElBSBD+0arYxcsky8jRzgnJbigzfryVx2vzAwOiea5Zn1i/tmcr6no
   6qoUxEqPCE4+nG9YbUw2nu49zXsJ4mcRM6HM1vHna+/glK4MlGylAZ71w
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="233995411"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="233995411"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 10:36:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="581189472"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2022 10:36:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 26 Jan 2022 10:36:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 26 Jan 2022 10:36:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 26 Jan 2022 10:36:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 26 Jan 2022 10:36:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaqRkmt1YJnwqLArOomUQ1QfBuMZNBcI5hVlLV6rjj7/jgzhVNhs6YAU40+kR4j03jPy1OtB/s5pXHljaU0S8NrlrcV3NFtdiIWrsOr53/b8a8bzkW2iZrFctXMYKGQQnZWNHHOyWIRAxU2TeG/OPL8tWFBM5wv4VwYVuFTSjZ0oLc4/0MSTz0UzcLSV4Q3DK/tpaNKj6E8q6R0fGEsXw/73AwVO2P4pXn9G5E05xvLaqIg+xgvQyElKoroYTNy92g1xL8bH3l18xy1HETVP9E7H1MvnWmPM6+eAM66s7onEL1qFAAv4IfOgg3T+BWG43CH96rlR9iQQuzUUWSxtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3yuA73ljWJd+zWAkNJ4eAkcyjkjvcnaZbRcwDYh7Mo=;
 b=QaA8tSNuQ00DvFnJikJpH3tsZlJ4dxlrogjCvZhmTtAhevKvivzGOHRFJpP9K08hRdHnWfxcySrHYB7oiwJGrkq+dJJuCwlrDu20NnQFMmcL9BiJxWcnT9yRnGD/g2DLHP7C/3VKVjEMiynKav1yZYbYIJFdi94xjIirhUNedcGnGWEO9yLZ3/+v5FZkd1WnU6vosZBMt/9elfvGDS3fpb1q2eXDS7XsUXh3+aZuET7WT6ntJmfjJv7nH5l7RZwvpCxDj1mtcB4GZBEFijZ7zP9HoUWQiCCi7qm0i1ZitjZaHE+2q+z6WsZP2hrRTdJBKcq/mFmWd7L0OmZJSXj/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 18:36:31 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::9977:f8a0:e268:24f5]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::9977:f8a0:e268:24f5%5]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 18:36:31 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        greearb <greearb@candelatech.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "Ben Ami, Golan" <golan.ben.ami@intel.com>
Subject: Re: iwlwifi problems, maybe firmware related?
Thread-Topic: iwlwifi problems, maybe firmware related?
Thread-Index: AQHYEkCI4ctfUOxXUU6iV5VLFX3SGKx0ammAgAAnxgCAAFGLgIAAvgoAgAAA/oA=
Date:   Wed, 26 Jan 2022 18:36:31 +0000
Message-ID: <dc56d6a7b2e0f2b76d6a584fb62fb235e691d9ff.camel@intel.com>
References: <92b00b94-aff6-8108-06d1-932b77f9d218@infradead.org>
         <04761964-e3b3-b2f7-78a4-bbc3507ad676@candelatech.com>
         <0ee64c55-1326-addb-7c9c-c922373f78c0@infradead.org>
         <cb3e4991c19659ab73cc0d9c12e8b7dbba9d652d.camel@intel.com>
         <aa666e92-6c8b-5689-1a9a-6e61d68b096d@infradead.org>
In-Reply-To: <aa666e92-6c8b-5689-1a9a-6e61d68b096d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9c721f7-bd34-4cd9-76fa-08d9e0fac5dd
x-ms-traffictypediagnostic: PH0PR11MB5829:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5829801109A40C7EB2F08D1A90209@PH0PR11MB5829.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZP81BlZIBrFficbxMN//RZySh5QQIxDYpnHY+X/mdh2HnhcFLADkcDiKnOmTe6mMqZjw2+NPnwD/wuaNDSTG43YtPyiXXSeqjGxK6k0IQgQ3+L9wjGL7RHna3Pb7kXarVQN9nNcXMAjlQhJ/2j+cEZ9cvBcIu1IB5KsblaGEOOmaOBzQ1tRmOkwk3nHko1quYy+VNnLhdadchtubBR+7PVOMfcdXdcbviiL5N/K9PQ29S+9rhVL1ZGWsGczl7yGcn+4ezmJYPLtBmV8tTQdflTbTY0xmGTLB7jnkLL5uYYJ7JMzjRkUk6O4jrBQwNikhLU7h18BjuZE0mYR/oXcpaHQfhZ1IY7BSu4xW/yiRDjZkjYkr+ITXwhXnxX9s1sBUODzTU31ypCaNTi3de/SOIYM2Yx5E6ZEGZHGDSkSJr4mYNsCi1YfRPSj8V8dvtkNpqNsG4d945WYHwQineFFeW5pDh6JMk5PrGIurE/T62XhtZVsK7gyF18Bz9XrFVE7gi83ZwuyhXO+mqDgUj2R0aSYNj0BQ2YoWctwCMcOI8+WNHkZ5kD0L04W7ZEF5Dw3XSZi5t30djrRF2DaQeBBBXo8RxZsjBLanK5o1cuEbqnqFVkr9nWtnFqcN3T8xO29bKdbedAH/8iwrej43bVc6ZDc3SCfMNnEU0O8pZ4+n4mfleUt4PIoP0GHeeVqUpf+WmE5fHWPLwXunFVnKS7TxQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(110136005)(82960400001)(5660300002)(316002)(83380400001)(8676002)(53546011)(6506007)(2906002)(6512007)(2616005)(36756003)(38100700002)(186003)(86362001)(508600001)(4326008)(6486002)(122000001)(8936002)(26005)(66556008)(71200400001)(91956017)(64756008)(107886003)(76116006)(66446008)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V29YTkJSeVFkOVNZbEZRSmxYT2NUR3JRSDNkRWo5TUxjZlFHOGY4RXVkOTZ2?=
 =?utf-8?B?TTJEVTVHV0VJeGhtMHdrdW9TVUJlSFZza3E2Y3Z4WXFjdm4rSStiNFlPQlM2?=
 =?utf-8?B?dkNjV2JvOTRLdSs0NndDamVmYzQwczhUM3oyVkRFaEp4b2pVbUxsK2tvdmpZ?=
 =?utf-8?B?U0FNMXlwQ1F3aGorTHJLL3dBRUVnM3hnM1UxTGdNbEJja2cxV3BsOTNyRGRm?=
 =?utf-8?B?ODdxN1ZjbUV6bXFtNHovd09qYUZrTDhmcG5zMk9qZWdzTWtTWjBGRzBGNmk4?=
 =?utf-8?B?MTl1K004TERVSXFIZjF0WWRJaHR3RGd1dGx2dWZVbEtJQTNBUDZHbnRjQ25P?=
 =?utf-8?B?RDZPbWxxMlI5T2RkS1hjY3ZVMkpSdnJPYjFNbUhrU1dpclA0V3o0WksrNjlO?=
 =?utf-8?B?b0xUNjN0YS9lamN0c2dMZG9iMmdmZCtiVzdNaVI1aERJaUpOMDZ1cmQ4THlK?=
 =?utf-8?B?NUpoUWR3ZDhGTi9POVdaQm5aS2lnZ1h4cDJPZitqdm5HSVY3amNYdmVmMERk?=
 =?utf-8?B?TUZ2MjBqZUtrSUMvWkxXSHZ4Ym8vajU3YTJ2YVhWWUQvMFVOeFlrOU82VmFT?=
 =?utf-8?B?NkZ0OE8zc05qWmU2cGdJR1FIbGZCeGxvMW54QWFId3VxbG05Q3Zrb3l5TzNN?=
 =?utf-8?B?OUxVTXlNaG1GeWlBUXlNR3R2b2poQVlFc3FXVHg2UVpaU3hvakgxV1FtWVBu?=
 =?utf-8?B?Sjk2dEFWRE1Qd0lrZ2pyOEZMQmlkdU9DaFJ5TmcxZW85YURDTDRoMk5KVjBM?=
 =?utf-8?B?WE4vVWUxOUFyam1seVAzcW5Ya2Z1TnhiRWlaMjVabzNDVUVrekY3UG9sRk4y?=
 =?utf-8?B?L2NQcG05QjZpM1Jnb2p1bk9KUW51MmhsaGcvZHZhUlNZUnVKY0hpT1dLZkhG?=
 =?utf-8?B?Zm96R3VZQkM5ZXcrTWhMT2pUU2F3SWdGSkYzRkp5aEZpQmEyZVBSWXhKcXJI?=
 =?utf-8?B?ZGgydTN0SG1WVjNwQ2dxTkJUT3FLeHREM3g4RmJscnNrbFBDT0ZlWlJxWHR5?=
 =?utf-8?B?Smx2cklZaFFQdENGU3E0VUk4TFEzaGluQ3Jpb01xaFpHVDVoajRFN1I3Ylla?=
 =?utf-8?B?K09hWGcxT0dIMWRPbjdvbjFLbkYwRzhiWFlOUXo3dG15VkNsUWZFSC92cGty?=
 =?utf-8?B?V0RJZWZsM1RNZ1pVNkwrOHlWV3ZQcVpOZDBja1R6dlFsVlpHeG45NTF3dXNZ?=
 =?utf-8?B?RW9qU21tbklmUzIyTnROTmFEWmlJTk4xQjVXcTNwVTRSaDFZaUNPaDRESWh6?=
 =?utf-8?B?MWpFQ0o0U3NtSy9hYVZCL0U4RU54UTQrbVowaHkyTE00bGtJVUhsM1M5Wml6?=
 =?utf-8?B?QWNaMzJFdWt4QnhDMndOcDBCUTg5VTU1czF5VCtMWVZNOTRzdWZpdVo3VjhN?=
 =?utf-8?B?cWcrMWNNQ3Mxbi82RkZMQzIwaVJURU5MNnFySk9hS0xCWUxCNmJOVjJqRlVo?=
 =?utf-8?B?aFRIQXdlcjc2OVlveGVBRjl5UDlhN2s3RU5SN29HUGVpaTFXY3V5SnlENlda?=
 =?utf-8?B?RHBBZmtDMTJsd09BS1pZMkUvR2M4UCtWNmFzdUM1SUUwdnZwcHlUSzFEcWJS?=
 =?utf-8?B?VS9YdFpjYmdNVFZTUXFmOUxSWTd2MHk2VVI0Y0VFV2JSYXJ1OXM4NlJ5M3lh?=
 =?utf-8?B?MWRqWTFVMkdEdEN1UWZuRHNEQ0JQekFheXl6eEYwVk5YSmI5YXJTYysxVzdG?=
 =?utf-8?B?NzU1SzVJc1RmeE9UVkkwcmhFbTM3aUt0dDRLenBmOGVZb3dwSzFYZ0k5UlJ4?=
 =?utf-8?B?VjVVZFBKQ2dqN0dCQ0lsK04vUW5sOWhURk9lcnZJVkNxVEFURjdTWmcwb2JD?=
 =?utf-8?B?dnNzL1VCbml1Wm0yZUtzeEF2SUNrbmR5U3NvOVczMW9XaUhUZGRseEtUUWhK?=
 =?utf-8?B?ZHozMWdjdTJpQTR5cDN4TVBrMjQ3MlBMQ1R6QW9qRFhSQVFUdHZyZkVWODh6?=
 =?utf-8?B?bW81K1JLRC9QS0xBNkk5d3RWdjBFRmZMZmpOdUllZVg5bzlzdVV5UTJlZE4v?=
 =?utf-8?B?VFJkaFo5NFQvRFRlWXdQa0QzL1hyQnEvQW9ObDJablIyRTN5SEp1TkhZdTBz?=
 =?utf-8?B?V0w5Y296VDFPR2dyUU1SUmdEQUV1eHBQVFJZeXVHdGlXQXNmZHROTnVpNHpu?=
 =?utf-8?B?OUY1NXI5OGRLWloraXVOSnpyS0ozM0U1SXM0MTlESjVlZkc0WUxsZUlKZDZF?=
 =?utf-8?B?bSt2U2I3cmJmd0IrR2NzU2dkMUJaN0F5U2NIREtFSXJYVDJjWWRZM2lOdGJz?=
 =?utf-8?Q?TYyBpRApO4bYDCR63An8phKq7GTRasXnNnaYsHWD2k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1175A99B38FEE4F97E89EA5EB966C00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c721f7-bd34-4cd9-76fa-08d9e0fac5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 18:36:31.0551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eokWdqXkQyKS1oA9yS0+y2LYi0c+y4xA1IA5cCVdHpviWBqii3aURvdwdKPylMA96zSTr8VWT2B9bi2eTsjjXSj7Fl4hj1OHpMbYyMvZ5ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTI2IGF0IDEwOjMyIC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IEhpLS0NCj4gDQo+IE9uIDEvMjUvMjIgMjM6MTIsIENvZWxobywgTHVjaWFubyB3cm90ZToNCj4g
PiBIaSwNCj4gPiANCj4gPiBBZGRpbmcgR29sYW4gdG8gdGhlIHRocmVhZC4NCj4gPiANCj4gPiBP
biBUdWUsIDIwMjItMDEtMjUgYXQgMTg6MjAgLTA4MDAsIFJhbmR5IER1bmxhcCB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gT24gMS8yNS8yMiAxNTo1OCwgQmVuIEdyZWVhciB3cm90ZToNCj4gPiA+ID4g
T24gMS8yNS8yMiAzOjA4IFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+ID4gPiA+ID4gSGksDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2hlbiBJIGJvb3QgNS4xNiBvciA1LjE3LXJjMSwgSSBnZXQg
bWVzc2FnZXMgbGlrZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBpd2x3aWZpIDAwMDA6MDA6MTQu
MzogYXBpIGZsYWdzIGluZGV4IDIgbGFyZ2VyIHRoYW4gc3VwcG9ydGVkIGJ5IGRyaXZlcg0KPiA+
ID4gPiA+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiBUTFZfRldfRlNFUV9WRVJTSU9OOiBGU0VRIFZl
cnNpb246IDg5LjMuMzUuMzcNCj4gPiA+ID4gPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogbG9hZGVk
IGZpcm13YXJlIHZlcnNpb24gNjcuOGY1OWI4MGIuMCBRdVotYTAtaHItYjAtNjcudWNvZGUgb3Bf
bW9kZSBpd2xtdm0NCj4gPiA+ID4gDQo+ID4gPiA+IFdlIHNlZSBub3RoaW5nIGJ1dCBjcmFzaGVz
IHdpdGggdGhlIHZlcnNpb24gNjcgZmlybXdhcmUuwqAgUmVtb3ZlIHRoYXQNCj4gPiA+ID4gZnJv
bSB5b3VyIC9saWIvZmlybXdhcmUvIGRpciAoYW5kIG1ha2Ugc3VyZSB2ZXJzaW9uIDY2IG9yIGxv
d2VyIGlzIHRoZXJlKSwNCj4gPiA+ID4gYW5kIHJlYm9vdCBhbmQgaXQgc2hvdWxkIHdvcmsgYWdh
aW4uDQo+ID4gPiANCj4gPiA+IFdlbGwuIFllcywgdGhhdCBkb2VzIG1ha2UgdGhpbmdzIHdvcmsg
Zm9yIG1lLg0KPiA+ID4gDQo+ID4gPiBJdCdzIG9kZCwgdGhvdWdoLCB0aGF0IG9wZW5TVVNFIFR1
bWJsZXdlZWQgd2l0aCBrZXJuZWwgIkxpbnV4IHZlcnNpb24gNS4xNi4xLTEtZGVmYXVsdCINCj4g
PiA+ICh3aGF0ZXZlciB0aGF0IGlzKSBhbHNvIHdvcmtzIHdpdGggbm8gcHJvYmxlbXMuDQo+ID4g
PiANCj4gPiA+IFRoYW5rcyBmb3IgeW91ciBoZWxwLg0KPiA+IA0KPiA+IFRoaXMgaXMgYmVjYXVz
ZSBvZiBicm9hZGNhc3QgZmlsdGVyaW5nLiAgVGhpcyBmZWF0dXJlIGhhc24ndCBiZWVuDQo+ID4g
c3VwcG9ydGVkIGZvciBxdWl0ZSBhIHdoaWxlIGFuZCBub3cgdGhlIGZpcm13YXJlIHJlamVjdHMg
dGhlIGNvbW1hbmQgd2UNCj4gPiBzZW5kIHRvIGl0Lg0KPiA+IA0KPiA+IFRoZSBlYXN5IGZpeCBp
cyB0byBjb21waWxlIGl3bHdpZmkgd2l0aG91dA0KPiA+IENPTkZJR19JV0xXSUZJX0JDQVNUX0ZJ
TFRFUklORyAod2hpY2ggc2hvdWxkIG5vdCBiZSBlbmFibGVkIGJ5DQo+ID4gZGVmYXVsdCkuDQo+
IA0KPiBKdXN0IGNvbmZpcm1pbmcgdGhhdCBrZXJuZWwgNS4xNiB3aXRob3V0IGJyb2FkY2FzdCBm
aWx0ZXJpbmcgd29ya3MNCj4gd2l0aCBmaXJtd2FyZSB2NjcuDQoNCkdyZWF0LCB0aGFua3MgZm9y
IHRoZSBjb25maXJtYXRpb24hDQoNCkp1c3Qgb3V0IG9mIGN1cmlvc2l0eS4gIEhvdyBkaWQgeW91
IGVuZCB1cCB3aXRoIGJyb2FkY2FzdCBmaWx0ZXJpbmcNCmVuYWJsZWQ/IElzIGl0IGEgZGVmYXVs
dCBjb25maWd1cmF0aW9uIGZyb20gc29tZSBkaXN0cm8/DQoNCg0KPiA+IEkgaGF2ZSByZW1vdmVk
IHRoaXMgb3B0aW9uIGZyb20gdGhlIGRyaXZlciBub3cgYW5kIHdpbGwgc2VuZCB0aGUgcGF0Y2gN
Cj4gPiB0byA1LjE3LXJjKiBhcyBhIGZpeC4NCj4gDQo+IFllcywgcGxlYXNlLg0KDQpXaWxsIGRv
Lg0KDQotLQ0KQ2hlZXJzLA0KTHVjYS4NCg==
