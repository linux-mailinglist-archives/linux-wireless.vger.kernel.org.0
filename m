Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189AD78A043
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjH0QvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjH0Qui (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 12:50:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7513E
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693155035; x=1724691035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8UNgVQlZC1fPuC2xDJb2OqqzdedgeuBtfvr/HqjDuGU=;
  b=nvkjmSQbCyIXtZzpv3ryn6Lto5oGjx3PszA0p91Ewov50nMlcuYPtguJ
   QaHbefw6K4A84ag0jreYFZPdkvlgtV5qABVUO4GLDg9y5VHrmv1LMk7xZ
   FrTtcf6jAkmtYg92UyulceenPNWCPnv29QNA3i5USpneby8nq8IDbFoJe
   o5PeU8Z3l51GiZZvLENPGp6GkmsCPrX4LNaL0BxXpv3Uw2fHnkMM+g6EX
   3j/dRGuXTb7vj1eHQ06jSvJfKzpuoVsCMCKyPdVkM2mV2iuM1RvlFugYp
   D2mzgqifrgxAuGz7LpXjDj2Sftgy7zKCwHAVYykn2sPSjpSTZirGrjVMs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="405952582"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="405952582"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 09:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="1068786996"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="1068786996"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2023 09:50:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 27 Aug 2023 09:50:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 27 Aug 2023 09:50:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 27 Aug 2023 09:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2UJMXy42yx69G25ox3ra82i9ptga42rlXouJmSyZJOmcwxU4wM8xf+NpeuRSzLimg8VY6xS9XJCQwuGtrSxTNH/zCJJ0luhc/ek36Acz8ibTJvS43tSDYgNCMz7oe1EFfjTT4cCgO735ddd7bFqe0Pm4I5WLdK8z+8HVpFCsTt1nZ53X90Y4u8KN+rG3aoh+URMGuHRRU4/tHmxuMpFjJHeOfA5ztnDKc9hwrdthCUffEGvmNYriJBgKpNAb4KEijEV2aOsxCW9UsdRHSgpiNK/vIlo42Ctif4UcqjCL4PkEff8mXOC2tf2m7anLIWCqX5iZLjjiRcN4fAalGj/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UNgVQlZC1fPuC2xDJb2OqqzdedgeuBtfvr/HqjDuGU=;
 b=d3OZbShbT+XxWIOWlzZrUUxxtBQw8dv3uspnKRIvF1JCXCp2zf/Fg6DzvMK0x9lK0HAUrWxpSJ3yrXs2qmXmEHSdwdWF2Q8uKXIWMJoJ/+ZU32PTlHjfiKiWkf3E1lcce7MXPygR0dnaCG2ysGw7fV+sd6+e02L0Z71lRnbWyHc2CJ+xPznzzGJyL/Vazy8ntKY91XtKxIdARATAH8K40xscTFr3FbHOm6FvG/qdD9HEAISWo2Yc3qKssqoOCSnBvO3siPDHSw8Y6Y01zt6DGnU3wxJBBPUpdraoeoKpp+E+GFx+94zxYQMG2QtVl48nWn0gEGTZLhNzo4uFz10sLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SA3PR11MB7609.namprd11.prod.outlook.com (2603:10b6:806:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 16:50:27 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::3ef7:b713:4d10:5174]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::3ef7:b713:4d10:5174%4]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 16:50:27 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 01/15] wifi: mac80211: add support for mld in
 ieee80211_chswitch_done
Thread-Topic: [PATCH 01/15] wifi: mac80211: add support for mld in
 ieee80211_chswitch_done
Thread-Index: AQHZ2NZ0JIOMSSihakuIqg2TD8DKM6/+WXgAgAACAwA=
Date:   Sun, 27 Aug 2023 16:50:27 +0000
Message-ID: <cd9c7bbaedc7d1b951663b2eb29c4341cc689cce.camel@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
         <20230827135854.9f3d846ec9ad.Ic2d14e2285aa1646216a56806cfd4a8d0054437c@changeid>
         <82a1c9f6-ab55-4e99-a4cb-c549e558ed15@quicinc.com>
In-Reply-To: <82a1c9f6-ab55-4e99-a4cb-c549e558ed15@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|SA3PR11MB7609:EE_
x-ms-office365-filtering-correlation-id: b30680e6-2ffc-4db3-5200-08dba71db757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5J5BidgjGxxP7iB+LrO/VjccUYhSjqfVbJZcMaTa5T97w8XaBFMxmDL5B6HiwB7hxkYVoLTviB76Tdnu3PWQK8CemJByDE+4v76T6OHyikr9q4/0jGCUx7AW+0goMpu1qA2EKDMLLU1ap+Rdf9jp0RCG2ZF8zC+qSTkpyztSxMs96QNVGx2k5j1kmwuQTUoGgz8KNtbGQL28nwvKjpYPqgAqHRWPyFcjmYTwXlmY46kq4qc6AJBnElB1IEd0hMn+3f0KpHQSdSzvWnvlvaGoxmpPFXXN+wa80CqwTBBULaOcrfkcxmdWVQXVCPZWte5Gs5qbAyaNq5SPyDT+Rn+NtknSWGnm/nTThvNfw6le63crlfxCrZcYiFSY2/cuIa43wo3PSiqeLCk41nmDP0E4nPnq53Kt9JhuFa448UW1slrltVqJjxV37eIDfVgDPtbG6HTHrb/uNXh0BziYeCky9WTvBsTJTPA8GMxErcOQGEAtijRB+82FiiiTSIp4fT5iQOT3khNEFGr3GoW6KlBbKIFGSUw/Yabnc85K9VojUAsfc/NjQ+coiGc/DLRzZ3fE95mjx9CNAyl2847Lq/Fyo8jhrwm4Rkmr8sceR/5ravQsf7j6XPdEl/8/fN3kv7y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199024)(1800799009)(186009)(83380400001)(478600001)(122000001)(26005)(6486002)(2616005)(53546011)(6506007)(6512007)(71200400001)(86362001)(5660300002)(2906002)(82960400001)(110136005)(316002)(91956017)(38100700002)(4326008)(38070700005)(66446008)(64756008)(76116006)(41300700001)(66476007)(36756003)(8936002)(8676002)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXRmUktJdUFlY25neXlIY3VvL21IUDNkVmw5cnZKZGhJQmxTcXh4ZDFPWXVN?=
 =?utf-8?B?a2QvNUV1NjRPRUF1ZW1YWE1GN2w5ajJCZytYMmhRTENSS1FYVnhCeGIrTE5m?=
 =?utf-8?B?Q29wb0lXdkFtQ3BqbDlrSWZoc25wR0kzdENlS2xuZFhUTTdqd2tsL1VEbTVV?=
 =?utf-8?B?eFlYazNoUmdYZ1J6WVB2bzZQS1pWc0hNTkpTa01Hblp4eDNNT2MrV1dTWGl5?=
 =?utf-8?B?aXBRTzgwcENNUmYyOFpBNnlrcWJtL0lpblE4elpLb1dwSmpsaVQ3bnA4Tkxs?=
 =?utf-8?B?UEovc3RWcHkxbk1VTnc0Vm1QYWNtdTRHUGpadXlQZ2pSb1NPNkxobWdaWHZV?=
 =?utf-8?B?R1ZvRU5aTjQ3TU0rRzFhdGpzNkVFZnZLeWlGWkJyM3Z6WEVkUmtWK2hoN2R5?=
 =?utf-8?B?RUtNemFOTDZlUDBGb0x5R2hTdk9QZ0FNaFYzRVdLMjVYOEtvV0ZTUU45RDVm?=
 =?utf-8?B?UW52R3ZRZnZJdFNYU1RRci91bTZLUW05ME9LSUlHQmpFbW9sb05oNlJVcHFD?=
 =?utf-8?B?RW55VWN2QWVCbC9henJCTi9lMmZvS1ZDNC93ZTJ5TFJ5ayt2V01iWDkySEQ4?=
 =?utf-8?B?V0dZQ3ErU3kyY2xhcmpTRGdGUWowY0JpeExrcFFKeE0wdGFEeDUyNWRXSWpp?=
 =?utf-8?B?TUVBaHFqY1JqNjNvL3dIdGd2aDhzdDJXUHloN3hsMTBvNnlnQis5cERITE95?=
 =?utf-8?B?K0x5cFV0NkVLaEN0WTdpVFpLcjk3bDJFelhyRGgzZThrMUVGR2IvYVlnRmFm?=
 =?utf-8?B?cFdUZmRUZnlmYnh5UVJmQk9WTk8weXBsaTRQUkJZV3FYNnZ6OW9mY0V1Ym5z?=
 =?utf-8?B?Rlk1dFZOVUwwZ25ja1JmbFRnbzY0VXNrOVJNNkRIUWFSUG5Eb2pKUmtSNzNQ?=
 =?utf-8?B?NjVkaG5oNnFCc0hKL3pQZW9xNk5IRm90WEFCdnZENUhsSURvRjhOaXliM2tT?=
 =?utf-8?B?dFgrd08zcEFIRTBvWWNTWkQzUTRkdjZSbTRKUVdnUldwWndSd05vNFRjN3kr?=
 =?utf-8?B?OE5hWjZaNHV3QitIU2EyWWVhOExEUjhYZThzdGJHWUlVem54M0VKUCtoK3dh?=
 =?utf-8?B?QlI4ejNKdHFUbkxIa0RrRUhHTlNzUmdGd05GTGU0ZTNYVnBQaW9ITCt0dEts?=
 =?utf-8?B?b2ErSWlsTWVucnZXWFBQVnV2Rjk5M0V3MlB1T0VHU080L2RtVFo2WUhReC8z?=
 =?utf-8?B?RUJ1WmlnZm1VU0lNaWNHcnNJYThqNHRrbkFNYUU1bUVZR3UyclBheUViSDZZ?=
 =?utf-8?B?TWM5TWcrYkJUeEM5cncxai9qVzU0cHg4OGZiaUhuMExrYVZXVEtEZTIzOFM3?=
 =?utf-8?B?eGFUVUczaUdKVkNmaXUzbGpWcnJnaEJkejk2UFVZZzRNWVV3UTdFV0ZrQVJJ?=
 =?utf-8?B?bXc4M2lJSEtPbUkvazJJNzhZeUZwYVZBamh3OFUyV05xUW1KZ2kwMHNQb0VD?=
 =?utf-8?B?NEVDMlk1OGcrYTA3QWhVdGowRUdodDFYc0ROOGR6WGUxOGVZYTNDNmxPN1VZ?=
 =?utf-8?B?b0diMWhFZ1FBQnZ1VzUwRjhpdUVGRCtHUklRVGtCeHRmN0pIV0kwSUJUbzFz?=
 =?utf-8?B?QmNzMW8vczhNeFU3ZU9NbkhHdEJlT0QrdEczTXBzVTZPZ3Zqd0syZ3I3TFk0?=
 =?utf-8?B?VHFoYURjZGpYWlhGbzRCN04yQjhKVTB1cE9tRmhJaDA0eDN5RDVLWXVoa2No?=
 =?utf-8?B?NmFHWlk2VWRIYW9BQmQrYWNUT1RIOS9CcE40MHBoU0huaGNtSkF4Yi9jUTNP?=
 =?utf-8?B?N1IyN3htSlF5Q3NhUW11eEVZT2RHcm1IcmxRQ0N4SFhGNzFndFdlUE5mdVZw?=
 =?utf-8?B?OUhBNE5Qa2RPYWFoUnBrVlNHd01tVThsdGxTOVJGRFRJQU5kUXJ0bHAwOHp2?=
 =?utf-8?B?YVVQYm5JeHdUMzV0dTRxRjdpSS9ORlZ3NjVFblRVelNPdk5jMElweTMya3Uv?=
 =?utf-8?B?b0tGQ0lEM3BNb2hGYmxpK3g5Vm9jZFlIRVRYWGpPZ0wzZWE3ajZaYThxSUcz?=
 =?utf-8?B?ZUlscVgxZDlJVDBNbCtpNVNmNUpTa0lIYnF5ZW0zNWZacnByU0kzS3pLWVFu?=
 =?utf-8?B?eWppMHhQS1Vrc3p4RG5mTDZkd2tBY0F1U2Y4eFJYOG5jKzZLV1R2SFJXR1J6?=
 =?utf-8?B?WXZ6Z3p5QUgydGdZTVJRWkNlTWpEdEFZRzhkN3g3TkcxQnVEcUhicS9iSDBB?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <379467730E69874F94F3C5E99BBEBD4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30680e6-2ffc-4db3-5200-08dba71db757
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2023 16:50:27.4896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2cVoyhwWjlOSh99+hAcZw4iiO7njv200roirBT61WXFeb9Lg4Qa4qLF6iOCncDDP8llCD6TVgCLtH3i8OVCPdqfZX53mvE0U+73MylR2t8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7609
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

T24gU3VuLCAyMDIzLTA4LTI3IGF0IDA5OjQzIC0wNzAwLCBKZWZmIEpvaG5zb24gd3JvdGU6Cj4g
T24gOC8yNy8yMDIzIDQ6MDUgQU0sIGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29twqB3cm90ZToK
PiA+IEZyb206IEVtbWFudWVsIEdydW1iYWNoIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+
Cj4gPiAKPiA+IFRoaXMgYWxsb3dzIHRvIGZpbmFsaXplIHRoZSBDU0EgcGVyIGxpbmsuCj4gPiBJ
biBjYXNlIHRoZSBzd2l0Y2ggZGlkbid0IHdvcmssIHRlYXIgZG93biB0aGUgTUxEIGNvbm5lY3Rp
b24uCj4gPiBBbHNvIHBhc3MgdGhlIGllZWU4MDIxMV9ic3NfY29uZiB0byBwb3N0X2NoYW5uZWxf
c3dpdGNoIHRvIGxldCB0aGUKPiA+IGRyaXZlciBrbm93IHdoaWNoIGxpbmsgY29tcGxldGVkIHRo
ZSBzd2l0Y2guCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEVtbWFudWVsIEdydW1iYWNoIDxlbW1h
bnVlbC5ncnVtYmFjaEBpbnRlbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBHcmVnb3J5IEdyZWVu
bWFuIDxncmVnb3J5LmdyZWVubWFuQGludGVsLmNvbT4KPiA+IC0tLQo+ID4gwqAgLi4uL25ldC93
aXJlbGVzcy9pbnRlbC9pd2xlZ2FjeS80OTY1LW1hYy5jwqDCoMKgIHzCoCAyICstCj4gPiDCoCBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2xlZ2FjeS9jb21tb24uY8KgIHzCoCAyICstCj4g
PiDCoCAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZHZtL21hYzgwMjExLmMgfMKgIDYg
KystLQo+ID4gwqAgLi4uL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5j
IHzCoCAyICstCj4gPiDCoCAuLi4vbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL21hYzgw
MjExLmMgfCAxMCArKystLS0KPiA+IMKgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdp
ZmkvbXZtL212bS5owqAgfMKgIDMgKy0KPiA+IMKgIC4uLi93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L212bS90aW1lLWV2ZW50LmPCoMKgIHzCoCAyICstCj4gPiDCoCBkcml2ZXJzL25ldC93aXJlbGVz
cy90aS93bGNvcmUvZXZlbnQuY8KgwqDCoMKgwqDCoMKgIHzCoCAyICstCj4gPiDCoCBkcml2ZXJz
L25ldC93aXJlbGVzcy90aS93bGNvcmUvbWFpbi5jwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArKy0t
Cj4gPiDCoCBpbmNsdWRlL25ldC9tYWM4MDIxMS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOCArKystLQo+ID4gwqAgbmV0L21hYzgwMjExL2NmZy5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MzUgKysrKysrKysrKy0tLS0tLS0tLQo+ID4gwqAgbmV0L21hYzgwMjExL2RyaXZlci1vcHMuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgKystLQo+ID4gwqAg
bmV0L21hYzgwMjExL21sbWUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAyOSArKysrKysrKysrLS0tLS0KPiAuLi4KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL25ldC9tYWM4MDIxMS5oIGIvaW5jbHVkZS9uZXQvbWFjODAyMTEuaAo+ID4gaW5k
ZXggN2M3MDczNThkMTVjLi42N2Y1NDgyNTExMGYgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL25l
dC9tYWM4MDIxMS5oCj4gPiArKysgYi9pbmNsdWRlL25ldC9tYWM4MDIxMS5oCj4gPiBAQCAtNDU0
NCw3ICs0NTQ0LDggQEAgc3RydWN0IGllZWU4MDIxMV9vcHMgewo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBpZWVlODAyMTFfY2hhbm5lbF9zd2l0Y2ggKmNoX3N3aXRjaCk7Cj4gPiDCoCAKPiA+IMKgwqDC
oMKgwqDCoMKgwqBpbnQgKCpwb3N0X2NoYW5uZWxfc3dpdGNoKShzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZik7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBp
ZWVlODAyMTFfYnNzX2NvbmYgKmxpbmtfY29uZik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdm9pZCAo
KmFib3J0X2NoYW5uZWxfc3dpdGNoKShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmKTsKPiA+IMKgwqDCoMKgwqDCoMKg
wqB2b2lkICgqY2hhbm5lbF9zd2l0Y2hfcnhfYmVhY29uKShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpo
dywKPiA+IEBAIC02NTQyLDExICs2NTQzLDE0IEBAIHZvaWQgaWVlZTgwMjExX3JhZGFyX2RldGVj
dGVkKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KTsKPiA+IMKgwqAgKiBpZWVlODAyMTFfY2hzd2l0
Y2hfZG9uZSAtIENvbXBsZXRlIGNoYW5uZWwgc3dpdGNoIHByb2Nlc3MKPiA+IMKgwqAgKiBAdmlm
OiAmc3RydWN0IGllZWU4MDIxMV92aWYgcG9pbnRlciBmcm9tIHRoZSBhZGRfaW50ZXJmYWNlIGNh
bGxiYWNrLgo+ID4gwqDCoCAqIEBzdWNjZXNzOiBtYWtlIHRoZSBjaGFubmVsIHN3aXRjaCBzdWNj
ZXNzZnVsIG9yIG5vdAo+ID4gKyAqIEBsaW5rX2lkOiB0aGUgbGlua19pZCBvbiB3aGljaCB0aGUg
c3dpdGNoIHdhcyBkb25lLiBJZ25vcmVkIGlmIHN1Y2Nlc3MgaXMKPiA+ICsgKsKgwqDCoMKgwqBm
YWxzZS4KPiAKPiBJIHdvdWxkIG5vdCBjYWxsIHRoaXMgYmVpbmcgaWdub3JlZDoKPiArwqDCoMKg
wqDCoMKgwqBsaW5rID0gcmN1X2RlcmVmZXJlbmNlKHNkYXRhLT5saW5rW2xpbmtfaWRdKTsKPiAr
wqDCoMKgwqDCoMKgwqBpZiAoV0FSTl9PTighbGluaykpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybjsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gCgpZZWFoIC0geW91J3JlIHJpZ2h0
LiBXZSBkb24ndCBuZWVkIHRoZSBsaW5rIHBvaW50ZXIgaW4gY2FzZSBzdWNjZXNzIGlzIGZhbHNl
IGFuZCB5ZXQgd2UgcmV0dXJuIGhlcmUsCkknbGwgZml4LgoKPiA+IMKgwqAgKgo+ID4gwqDCoCAq
IENvbXBsZXRlIHRoZSBjaGFubmVsIHN3aXRjaCBwb3N0LXByb2Nlc3M6IHNldCB0aGUgbmV3IG9w
ZXJhdGlvbmFsIGNoYW5uZWwKPiA+IMKgwqAgKiBhbmQgd2FrZSB1cCB0aGUgc3VzcGVuZGVkIHF1
ZXVlcy4KPiA+IMKgwqAgKi8KPiA+IC12b2lkIGllZWU4MDIxMV9jaHN3aXRjaF9kb25lKHN0cnVj
dCBpZWVlODAyMTFfdmlmICp2aWYsIGJvb2wgc3VjY2Vzcyk7Cj4gPiArdm9pZCBpZWVlODAyMTFf
Y2hzd2l0Y2hfZG9uZShzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLCBib29sIHN1Y2Nlc3MsCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHVuc2lnbmVkIGludCBsaW5rX2lkKTsKPiA+IMKgIAo+ID4gwqAgLyoqCj4gPiDCoMKgICogaWVl
ZTgwMjExX2NoYW5uZWxfc3dpdGNoX2Rpc2Nvbm5lY3QgLSBkaXNjb25uZWN0IGR1ZSB0byBjaGFu
bmVsIHN3aXRjaCBlcnJvcgo+IC4uLgo+ID4gZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIxMS9tbG1l
LmMgYi9uZXQvbWFjODAyMTEvbWxtZS5jCj4gPiBpbmRleCBmOTNlYjM4YWUwYjguLmNhNjA0NWY1
NmI0YiAxMDA2NDQKPiA+IC0tLSBhL25ldC9tYWM4MDIxMS9tbG1lLmMKPiA+ICsrKyBiL25ldC9t
YWM4MDIxMS9tbG1lLmMKPiA+IEBAIC0xNzczLDcgKzE3NzMsNyBAQCBzdGF0aWMgdm9pZCBpZWVl
ODAyMTFfY2hzd2l0Y2hfcG9zdF9iZWFjb24oc3RydWN0IGllZWU4MDIxMV9saW5rX2RhdGEKPiA+
ICpsaW5rKQo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoGxpbmst
PnUubWdkLmJlYWNvbl9jcmNfdmFsaWQgPSBmYWxzZTsKPiA+IMKgIAo+ID4gLcKgwqDCoMKgwqDC
oMKgcmV0ID0gZHJ2X3Bvc3RfY2hhbm5lbF9zd2l0Y2goc2RhdGEpOwo+ID4gK8KgwqDCoMKgwqDC
oMKgcmV0ID0gZHJ2X3Bvc3RfY2hhbm5lbF9zd2l0Y2gobGluayk7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgaWYgKHJldCkgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZGF0YV9p
bmZvKHNkYXRhLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAiZHJpdmVyIHBvc3QgY2hhbm5lbCBzd2l0Y2ggZmFpbGVkLCBkaXNjb25uZWN0
aW5nXG4iKTsKPiA+IEBAIC0xNzg1LDI1ICsxNzg1LDM2IEBAIHN0YXRpYyB2b2lkIGllZWU4MDIx
MV9jaHN3aXRjaF9wb3N0X2JlYWNvbihzdHJ1Y3QgaWVlZTgwMjExX2xpbmtfZGF0YQo+ID4gKmxp
bmspCj4gPiDCoMKgwqDCoMKgwqDCoMKgY2ZnODAyMTFfY2hfc3dpdGNoX25vdGlmeShzZGF0YS0+
ZGV2LCAmbGluay0+cmVzZXJ2ZWRfY2hhbmRlZiwgMCwgMCk7Cj4gPiDCoCB9Cj4gPiDCoCAKPiA+
IC12b2lkIGllZWU4MDIxMV9jaHN3aXRjaF9kb25lKHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYs
IGJvb2wgc3VjY2VzcykKPiA+ICt2b2lkIGllZWU4MDIxMV9jaHN3aXRjaF9kb25lKHN0cnVjdCBp
ZWVlODAyMTFfdmlmICp2aWYsIGJvb2wgc3VjY2VzcywKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGxpbmtfaWQp
Cj4gPiDCoCB7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWVlZTgwMjExX2xpbmtfZGF0YSAq
bGluazsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaWVlZTgwMjExX3N1Yl9pZl9kYXRhICpz
ZGF0YSA9IHZpZl90b19zZGF0YSh2aWYpOwo+ID4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGllZWU4
MDIxMV9pZl9tYW5hZ2VkICppZm1nZCA9ICZzZGF0YS0+dS5tZ2Q7Cj4gPiAtCj4gPiAtwqDCoMKg
wqDCoMKgwqBpZiAoV0FSTl9PTihpZWVlODAyMTFfdmlmX2lzX21sZCgmc2RhdGEtPnZpZikpKQo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN1Y2Nlc3MgPSBmYWxzZTsKPiA+ICvC
oMKgwqDCoMKgwqDCoHN0cnVjdCBpZWVlODAyMTFfbGlua19kYXRhX21hbmFnZWQgKmlmbWdkOwo+
ID4gwqAgCj4gPiDCoMKgwqDCoMKgwqDCoMKgdHJhY2VfYXBpX2Noc3dpdGNoX2RvbmUoc2RhdGEs
IHN1Y2Nlc3MpOwo+IAo+IG5vIHZhbHVlIGluIHRyYWNpbmcgdGhlIGxpbmtfaWQ/CgpJIGNhbiBh
ZGQgaXQuCgo+IAo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmN1X3JlYWRfbG9jaygpOwo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgbGluayA9IHJjdV9kZXJlZmVyZW5jZShzZGF0YS0+bGlua1ts
aW5rX2lkXSk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoV0FSTl9PTighbGluaykpIHsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByY3VfcmVhZF91bmxvY2soKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgwqBpZm1nZCA9ICZsaW5rLT51Lm1nZDsKPiA+ICsKPiA+IMKg
wqDCoMKgwqDCoMKgwqBpZiAoIXN1Y2Nlc3MpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc2RhdGFfaW5mbyhzZGF0YSwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImRyaXZlciBjaGFubmVsIHN3aXRjaCBmYWlsZWQs
IGRpc2Nvbm5lY3RpbmdcbiIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3
aXBoeV93b3JrX3F1ZXVlKHNkYXRhLT5sb2NhbC0+aHcud2lwaHksCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmlmbWdk
LT5jc2FfY29ubmVjdGlvbl9kcm9wX3dvcmspOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZzZGF0YS0+dS5tZ2QuY3Nh
X2Nvbm5lY3Rpb25fZHJvcF93b3JrKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3aXBoeV9kZWxheWVkX3dvcmtfcXVldWUo
c2RhdGEtPmxvY2FsLT5ody53aXBoeSwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnNkYXRh
LT5kZWZsaW5rLnUubWdkLmNoc3dpdGNoX3dvcmssCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDApOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmaWZtZ2QtPmNoc3dpdGNoX3dvcmssIDAp
Owo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHJjdV9yZWFk
X3VubG9jaygpOwo+ID4gwqAgfQo+ID4gwqAgRVhQT1JUX1NZTUJPTChpZWVlODAyMTFfY2hzd2l0
Y2hfZG9uZSk7Cj4gPiDCoCAKPiAKCkdyZWdvcnkgLyBKb2hhbm5lcywgSSdsbCBzZW5kIGEgcGF0
Y2ggaW50ZXJuYWxseSB0byBmaXggdGhlIGlzc3VlcyByYWlzZWQgaGVyZSBhbmQgeW91J2xsIHNx
dWFzaApiZWZvcmUgcmVzZW5kaW5nPwo=
