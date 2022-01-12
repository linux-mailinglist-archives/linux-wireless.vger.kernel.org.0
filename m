Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D448C129
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 10:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349494AbiALJk2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 04:40:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:7027 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349438AbiALJk1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 04:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641980427; x=1673516427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Wx3JV2d6HgFJnGK+o2vw3rPk7xkVT94bdaeq1tjnwnY=;
  b=Urvxz6SsTLqHGhJFmKkx5rYsBTB2UXgr/5IrqfBxiw1ece59ZF2LXK9r
   WPjpWcd5HHM/L3pglptDegpgIgWrdIiomlprG/IF2E7RoCCMpLKNSpQgY
   72v3yN1T/ax9UOlBvCwboPLslPKUG9jfewkqDj/habkBtvCzCzVaSdpQD
   LBlyWluqTMsjoX4XAX3cTsMWIUwGQQwnwbv1Y9HH4Rki+FL85DsvPQ2RZ
   /MyAAbic3SBW68f6pmqWV/Qup/Y3nsDB8h690kLf8cY1MKzOjPKoYu57z
   H0vn0I2z7+GAIjec/TuFvS+Yy4i+Nm0SajBkUdQw8zCykaW+VfSlAkoc1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243654533"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243654533"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 01:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="474853787"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2022 01:40:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 01:40:25 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 01:40:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 12 Jan 2022 01:40:25 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 12 Jan 2022 01:40:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASG7oiLaGARTJIChj2srJHK3IIx9MYRbg+g8JYuB4d6EnzlJ3ri9mh45FJZvHyuUimzZqgZ23MFle8PKZKLzpa0iitTlgotc5JLx8Fww2cxikNxYqPqiAJn8YyJJPHa0QdHQ8IqjHmLfSrNPikeA/cHYxyktXRXldc/4oZES3Qgamz8MH6ObqnlHENXZsGeLIDliBTM+nI734p3mMziLhoMrTB8pCwWkDdxSuPuJzzcJflCL5uegpjCABO1+L08N8MwAAfpc1/FRJ6pC6z9IGcqNqLBaje3Ni1nfLtFWl9988CmI/OoycUEUt7ke6ZbbROeB9Iv2ov+R0gUaVLFhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wx3JV2d6HgFJnGK+o2vw3rPk7xkVT94bdaeq1tjnwnY=;
 b=BkBSrhoNiInRDA4swjEmyWwvoGTb/ih/c0UobpnhK3iVmYlK6SOn2oensPzLjCnkdwShTpzfgbWXBQg+VVdTa9izQORwJIw2vaYpgWb9NhsFX4/lofnyVLQrjhUt9tH45UsZrsK2flH+ys7tphxuDedmV9w7XIVSmhUm31TLfFsc5Lyu3xVqnw2r/D32JVeEYjjqjCMv7bslNrB9xpHZcvMs2KVuwe9MvKLTDH+lYQahKhmE7uaTQWlXPJSvLlhFUeK0w9PQ6klecAfJ17D+w/AgnoplqB0ZvPVIA4xxi3LYi5cd78GSLO4QfTVvGjhuS+DkGuBYP9X39FlweKeXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BYAPR11MB2981.namprd11.prod.outlook.com (2603:10b6:a03:83::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 09:40:23 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 09:40:23 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Topic: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Index: AQHYB1Z1kfzr/0Efz0WQ7sMSiyR//KxfD8iAgAAIsQCAAAYOAIAAAdeAgAAATQCAAAF+AA==
Date:   Wed, 12 Jan 2022 09:40:23 +0000
Message-ID: <e94cf5212135e3aa7ad3fe290258220466da2523.camel@intel.com>
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
         <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
         <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
         <ab9e48ae8dad3187d206d46fc1d997245ecbc3ef.camel@sipsolutions.net>
         <9644c62f580e30a2b7fc3d62b67db0b1e64872c7.camel@intel.com>
         <770267e4ad06661383dd16afbd51690cfad58d49.camel@sipsolutions.net>
In-Reply-To: <770267e4ad06661383dd16afbd51690cfad58d49.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00b95089-bd41-494f-2676-08d9d5af8e6a
x-ms-traffictypediagnostic: BYAPR11MB2981:EE_
x-microsoft-antispam-prvs: <BYAPR11MB29819B626ECDD00E681158D590529@BYAPR11MB2981.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWqCmbn7aHE03yEfeb38FhPj36m6LPmk22Q84ec6xn6SmjwXGP2EUM17gpS/X81t08+NtKI92JvAUTXeR73NuTtxzmvm1PrX3t6P+Akx4QFB8M1PXCX8CWmMcTdHZ9miYjl4uQ5ou7Dmj4z3zD/S3uNzZ6GmUSXe8lG0o+LSTHgXKDne2nd4inMZUCxgbCCOb6Al+ImFXwmME90gBwUM3jUhht912W72uR6vtY/2ZyqFUzNASW3ikLZMjr7K4vSaq6sg/eUlsmRZh1YyJ07VlvuHSO1JNvsIRtw1GZAZt1c5uIG7qqwNSYhErbqrMxkwInBAVjxEZjnFwPM45Sna8iwvfJkcjSBrf2XNvFh7dwjpeJE1dJVR7fwtc8k70pjNBMK49q2uupeYowiqhfZAz6GYWPrZmzqpx/UuqvEvOSw5ZtXvKgks/cTieX3E8yAYgSYhcHGUV5CI9oQlZocLcj196A9aOuZ/xQU6eajsM6W7U4mTz6qR3lGXeIA79pZqL9j/xz4H1ywoxR9LIgbQLFaLrrE647JNgPEEs+lcZV1yv0HM09cYX5dA08oxJpTEpkIJ8OUuWqSlZ0dttLu5oSl1/NXuzQsBGlydAiNr0hgiZcDwwgO9bepPhelFpeY67FU+AZBmeHonQNNWrkedPbC0JNQzltV/maSohaVEBKWNdN8oqgI1Y7qU8hVNimOUDMJuqusi5xUrUUamSAs1nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(508600001)(36756003)(71200400001)(38100700002)(110136005)(83380400001)(5660300002)(122000001)(316002)(6512007)(6486002)(76116006)(91956017)(186003)(26005)(86362001)(4326008)(2616005)(66446008)(8676002)(8936002)(2906002)(66946007)(66556008)(66476007)(64756008)(6506007)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFRUcEJ6WjZxMlcvN0REblpIK21hdnJUN2szdDZRamhRZlRGTEQ3RzEzN2Jr?=
 =?utf-8?B?eVdKVFpXL1FKVUtydEhoMDVMaUdSVHQ0MHNFbjdiNWVjZGRIVkpNWW5xMG1l?=
 =?utf-8?B?MC84d3M3ekpkSlpsbVEzNkdTQmhYSzNmdXByV0hGYXFSc2FwWjhHY3lsczhV?=
 =?utf-8?B?cGQxTXFhMVR2N0UrSDhtK2JCK0JvSVhwR1p1QWJVNTlCR1JqTk1yMTUwMWJt?=
 =?utf-8?B?SFJqQmhCVi9odGRkdXRDNzZuWG4wMEdiOWdHNGlWaVYrQ0VHdGtIMnozNEVP?=
 =?utf-8?B?QXZIbVpKMG1wYTlNT3pRTW5BdmZxY3gzTXQ4dlpLTWxUcnlPdU9lOThWMnBZ?=
 =?utf-8?B?M1ovT1dsb3ZvZ0ptbThocmR2bHpwOWtVZm5iRmdHMEVCUm5ORWxaNGVnNHp4?=
 =?utf-8?B?ZUcraXBNUWJxM2RYRS8wd0pVY1ovMTJ6U2ZNZVU0MFZwbG1DcEVVQ3F4OFFU?=
 =?utf-8?B?SUV5L3FqTEdBcXEyTzB3cE1pS0VaZHBvTHRpSzRSOVJhSUJWRGVJOGpyb3Jx?=
 =?utf-8?B?UEtFbitTc3pDK2s3d2pISU1ZdUFlZU9YZWZ6Mi9hakM2cmo2elFqT0Y3eVZk?=
 =?utf-8?B?UGJSczhUWHlUTkxTckphMDFpRUJEcXBReWVKbW5KQTI4TXhZbVg2WVBQNXB2?=
 =?utf-8?B?ZWIvN2dCK240cmh2MEtNZ1VPZGtMUWtmckFaSUlTeXlCNkdSSEI0aXM2dkhj?=
 =?utf-8?B?WjNvYU9WR0RnUUhieGVNbW44VHVrdmVra24yRCtydG5ZanoxQ2M3V0NqOHNW?=
 =?utf-8?B?TDQ0Mjhjd1d6eTdEYVN3WEpXY09vRndRSGdaYnN5eUp6Vk94bU1EUnIzNTBq?=
 =?utf-8?B?SzRIQ25BOS9LRTNMSndCZzhRSmtoZW83NzJiaDVoOVU3Snl6TkVNTGYyYkgr?=
 =?utf-8?B?WXJPUUtkbTdKQUtuYkNTcEhKOHp1RmQzeXVjVkY2WmtyR1A2NlBmRFRYYWdk?=
 =?utf-8?B?Wml3cjhTZ1VMZ1BVbktYV0NYNEdTS2M1MXY2VDZFZ2grSmVuZ1NGeW5aTWQ0?=
 =?utf-8?B?NkFhTFBXVlkybDVTYWpoa25jRlZjK1M5aGk3NEdwZGRQUjUwNFNJeThsYncx?=
 =?utf-8?B?OFZXbTE1UFQ1NWVlZHgwVEQzVnRhZEFpb1VTRzJVbkZhYzAyVit6UG8zNHgr?=
 =?utf-8?B?Y0VzL05JQlU2bFJZdGUyUWhIL2R4T1VkYjE3bElGSTFvU0oybGJ5SXg0SFRl?=
 =?utf-8?B?VjRiM1djcDljcjRENXA0c0c3aUFUa0ovOTRqbEc2bCtwTUdFTFFvRTJUY0w0?=
 =?utf-8?B?WE05UUp2RVF1UzU2aWdCdk9raXdOM2kraHUrc25KZWNhK0pvVUEyY0JiQVU3?=
 =?utf-8?B?eWtDU3d3eWx2djhsTVhESW5sMER4VFFRczNZVHFjL09RbWJHMHZXNCt6S3dK?=
 =?utf-8?B?ZDdXR1AyUHdFNEVLbndSVDlQNmZqazdhYWZYQ0ljV21NNUh4azF1LzE2SVJ3?=
 =?utf-8?B?WWI4eHZtR2dueGdZUzZVVDN0d294WERxcGE0NDNpUHVGcmdzL3RYZUpsTjVK?=
 =?utf-8?B?UnNOS25tVTY3Y1BPcTdSQkY0Y01VMGRLOEozM2RrQ1psWHBqM0E3VGVySmdU?=
 =?utf-8?B?dnd1TEM0cjF5UVBOQWFCWTgxRWxpd0JGckx5M3k1aE8xK0U3YjEweS9GKy9o?=
 =?utf-8?B?b3RoTHQ5d2crL00vZzNGQmJpVUZJZC9sQVpiMXBtQ20xT1VScHZJSm5VNXJh?=
 =?utf-8?B?Z0lVVEdoSlJ0R1RuMG9GQUZTUTVLRXJyNmI4cmRqbXNFelVBUTRLcFM2T0ZC?=
 =?utf-8?B?eHlmcWF3Wi9SVVMxNXViMmE3cW83QjJlV001UEcyeWFSakFrS0krMWlnc1JK?=
 =?utf-8?B?UzVMNFJZdGQwRytLUm82TitZZ3hqdlVIaTI1Z2hZSm9LaFBKT1lsSVZocWdL?=
 =?utf-8?B?MkcyQjBubkk1SVdESkRqVFFqbWU3UXc0S0tDUTRseER2WUFXTlg3NXVsdnF2?=
 =?utf-8?B?Y3lMNndydFhlSEtPZDlUWHltbWlVU3ZOaTg3L01BbnJDTUluL0k0VTJ2N2lY?=
 =?utf-8?B?Y0Yxayt0OXdESExlc0swNDFablE5cXpNWGp1TXFYTDRDWFlTQW9oWS9sbW4v?=
 =?utf-8?B?SklYeTZ5RnNkNFBHVGROWTJVRUZmamtzN0lQSXVlTXRkeGZDNG90RWtQcy82?=
 =?utf-8?B?V28wWEt0V1B4ZXdjb25mUXNlMlVheU1PM0k2V0V2UGllM3k2clBjVDFMSXF0?=
 =?utf-8?B?dUVGV0RwVlNnVlhKWkZMUDJxc1B4VGZhRnkxWmsyamVkWFNOM0ZrcGdzY2NY?=
 =?utf-8?Q?9mPuWvKpiqvwon7w/71SlKVRgtHrUgEPCXVGT8xmio=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE64C0DFD310BE40BCB960350978A77F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b95089-bd41-494f-2676-08d9d5af8e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:40:23.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5B8yi3+RRd/tlc4tNfplRpf59D7dpt+2tIUcbPEjmFZzbQpXtIPI8FoXSSqUTTqaxDGLrOICHUM+S5J6u34w0xWpNp//gHyFbQG6TwGcqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTEyIGF0IDEwOjM1ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBXZWQsIDIwMjItMDEtMTIgYXQgMDk6MzMgKzAwMDAsIENvZWxobywgTHVjaWFubyB3cm90
ZToNCj4gPiBPbiBXZWQsIDIwMjItMDEtMTIgYXQgMTA6MjcgKzAxMDAsIEpvaGFubmVzIEJlcmcg
d3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9tdm0vZncuYw0KPiA+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2ludGVsL2l3bHdpZmkvbXZtL2Z3LmMNCj4gPiA+ID4gaW5kZXggODYzZmVjMTUwZTUzLi5mMTM4
MjUxODUwOTQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvbXZtL2Z3LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50
ZWwvaXdsd2lmaS9tdm0vZncuYw0KPiA+ID4gPiBAQCAtODM0LDYgKzgzNCw5IEBAIHN0YXRpYyBp
bnQgaXdsX212bV9zYXJfZ2VvX2luaXQoc3RydWN0IGl3bF9tdm0NCj4gPiA+ID4gKm12bSkNCj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgb2Zmc2V0b2Yo
c3RydWN0DQo+ID4gPiA+IGl3bF9nZW9fdHhfcG93ZXJfcHJvZmlsZXNfY21kX3Y0LCBvcHMpICE9
DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9mZnNl
dG9mKHN0cnVjdA0KPiA+ID4gPiBpd2xfZ2VvX3R4X3Bvd2VyX3Byb2ZpbGVzX2NtZF92NSwgb3Bz
KSk7DQo+ID4gPiA+IMKgDQo+ID4gPiA+ICsgICAgICAgaWYgKCFpd2xfc2FyX2dlb19zdXBwb3J0
KCZtdm0tPmZ3cnQpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQ
Ow0KPiA+ID4gPiArDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAvKiB0aGUgb3BzIGZpZWxkIGlz
IGF0IHRoZSBzYW1lIHNwb3QgZm9yIGFsbCB2ZXJzaW9ucywgc28NCj4gPiA+ID4gc2V0IGluIHYx
ICovDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBjbWQudjEub3BzID0gY3B1X3RvX2xlMzIoSVdM
X1BFUl9DSEFJTl9PRkZTRVRfU0VUX1RBQkxFUyk7DQo+ID4gPiANCj4gPiA+IEkgd2FzIGdvaW5n
IHRvIHNheSBpdCBzaG91bGQgcHJvYmFibHkgcmV0dXJuIDAsIGJ1dCB0aGUgY2FsbGVyIGxvb2tz
DQo+ID4gPiBhDQo+ID4gPiBiaXQgZmlzaHkgdG9vPw0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgcmV0ID0gaXdsX212bV9zYXJfaW5pdChtdm0pOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oGlmIChyZXQgPT0gMCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
ID0gaXdsX212bV9zYXJfZ2VvX2luaXQobXZtKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBlbHNl
IGlmIChyZXQgPCAwKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IGVycm9yOw0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gaXdsX212bV9zZ29t
X2luaXQobXZtKTsNCj4gPiA+IA0KPiA+ID4gc2hvdWxkIHRoYXQgImVsc2UiIGJlIHJlbW92ZWQ/
DQo+ID4gDQo+ID4gWWVhaCwgSSBub3RpY2VkIHRoZSBzYW1lIHRoaW5nIHdoZW4gSSBjaGVja2Vk
IHRoZSByZXR1cm4gdmFsdWUuLi4gSQ0KPiA+IGRvbid0IHRoaW5rIHdlIHdhbnQgdG8gYWJvcnQg
ZXZlcnl0aGluZyBpZiBTQVIgR0VPIGluaXQgZmFpbGVkLCBzbw0KPiA+IG1heWJlIHdlIHNob3Vs
ZCBqdXN0IHJlbW92ZSB0aGUgcmV0dXJuIHZhbHVlIGZyb20gdGhlIGZ1bmN0aW9uPw0KPiA+IA0K
PiANCj4gV2VsbCB0aGUgb25seSByZWFsIGZhaWx1cmUgcGF0aCB0aGVyZSBpcyAid2UgY2Fubm90
IHNlbmQgdGhlIGNvbW1hbmQiLA0KPiBpbiB3aGljaCBjYXNlIHdlIG1pZ2h0IGFzIHdlbGwgYWJv
cnQ/DQo+IA0KPiBJT1csIHdlIGFscmVhZHkgcmV0dXJuIDAgaW4gdGhlIGNhc2VzIHdoZXJlIHdl
IGRvbid0IGhhdmUgdGhlIGRhdGEgb3INCj4gc29tZXRoaW5nIGVsc2UgaGFwcGVuZWQgKGFsc28g
Zm9yICFDT05GSUdfQUNQSSkuDQoNClllYWgsIG9rYXksIG5vdCBiZWluZyBhYmxlIHRvIHNlbmQg
dGhlIGNvbW1hbmQgaXMgYSBiaXQgYmFkLiAgTXkgcG9pbnQNCndhcyB0aGF0IFNBUiBHRU8gaXMg
bm90IHRoYXQgY3JpdGljYWwuICBJdCB3aWxsIGltcHJvdmUgY29ubmVjdGlvbiBpbg0KY2VydGFp
biBjYXNlcyBpbiBjZXJ0YWluIGxvY2F0aW9ucyAoYnkgaW5jcmVhc2luZyB0aGUgVFggcG93ZXIp
LCBidXQNCndvdWxkIHN0aWxsIHdvcmsgYW5kIGFiaWRlIHRvIHJlZ3VsYXRvcnkgcnVsZXMuLi4N
Cg0KLS0NCkx1Y2EuDQo=
