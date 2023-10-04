Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F6A7B7927
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 09:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJDH4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbjJDH4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 03:56:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A12CB0
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696406158; x=1727942158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oWGcLSOoL95itDpCq55a+zhrgIj0PZ57yztfCws6VPk=;
  b=AKGjEMbaLBuzVHYKYSI8Sy9j+D06Rnam07aRZvcAvv7M0o3O/ZGOlhMl
   i7sRMS3t8JTTxleFCLluOHsnsEgykVx0g5b+jynfUte6QxMxh85lo2P4s
   Vqf7OPkJYBT8Tml2uveks6I+aCRYgN1be5lYR1FfetEb+YS/rE2KXfjSl
   2cZpCqdlZ3ZNOd/A/RufV8p+ABoZ7zsEHADIfUrLonEbgivqk3YWfxOjG
   XJuEgPpKVddAS5/PTM2DCEhSPB3S7xjFkt2HITyu4xD/EGnppuBNdfby0
   KNcw9o9NPMdMlZ6Waz6X7YiWCI+yrXei+nSY4DdqTf7xilrFbY+eHnyrT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="447265028"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="447265028"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="817008834"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="817008834"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 00:55:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 00:55:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 00:55:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 00:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5v87wOT8/b157DBWyYxIMrM9UMf5VwOthlZnQtjBpV2VAdaVoLi1S1Rw3BifPqnlFLfJ5eqry8PprcT9/i2tbhsudkMh0/TfI3XTS2knYbmdAB/BGqhBLo116zm1EAO24lDgS/VmoVcQg/tXrXyx0cNIrGhF1jHLUQI/T4IdOG2yW94xvpy6Rf1PzKYNBlZkGgyR5afiirpMvf4Ats/N+bD38y0CRxGSyDjV2ZmkGnStyJVWaUcHX3zMPTmzO0ejRkree/Wu8eKIPFKl9FClWLPYllk+wzjRXUUSfdRgKNZpd0IHZKFyENhJ0A1DNpUD3v1vsVf6YkwTSQSuigY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWGcLSOoL95itDpCq55a+zhrgIj0PZ57yztfCws6VPk=;
 b=Sn58kOu9K8aDSZCUJBDBwK4ooERJ4lj8ZhaZQFKApfMKYNkA/eDWeqP8owahRsbwI2D5X87N8XryZwcjHs7bjpHje/GSjmVm+wObjLMfxZ4h4Rqu0NiZKzq78b5OwvU5anOke/yoW3v1jiz6M7Lu7KYok2WGrH/ieVEv/NoxcLFizVuN7hXVmKQbSUrUNTy9XgVqAIG/DsxTacXsti61e2dYokMxb2io+Yf+zFq14eUmKQokRKqbPRORUMxzaMnMbsYsMmH8ZZhLSyni68iYka9TnWas1SQyAqONGcXhhl8/4WLXfOD3r2noJlh3nG2K35pIFxAJgDjR2nWMmIBsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DS0PR11MB7532.namprd11.prod.outlook.com (2603:10b6:8:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 07:55:55 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 07:55:55 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "dmantipov@yandex.ru" <dmantipov@yandex.ru>,
        "Berg, Johannes" <johannes.berg@intel.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] wifi: iwlwifi: drop NULL pointer check in
 iwl_mvm_tzone_set_trip_temp()
Thread-Topic: [PATCH] wifi: iwlwifi: drop NULL pointer check in
 iwl_mvm_tzone_set_trip_temp()
Thread-Index: AQHZ9dstbshPsUShpkilzmFAMhZ5rLA5RK+A
Date:   Wed, 4 Oct 2023 07:55:55 +0000
Message-ID: <a0f3b77380bb37d298e19473d1d32ded8d3db99e.camel@intel.com>
References: <20231003092048.24998-1-dmantipov@yandex.ru>
In-Reply-To: <20231003092048.24998-1-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DS0PR11MB7532:EE_
x-ms-office365-filtering-correlation-id: 5ad6da58-fa24-43d8-de9e-08dbc4af565e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R33aWG2lBmo33l/Zo8/O/fqpeLj+cHwKl28DdVQYZcRDjOdtM8BqAr8hVRUN6cZQvPrr7ktRGyvnuiRRQPgI3mFnERbwRCc+mGYYhcoyCqxuEskiFb3xtDfC1ckMFDJLxdsOuDRf4aCzLvLDAu53pRu44l2qTdITNABLennzTunVjgYwOflYAmYuaFYLaC0lp3JSDbQkAO8yHRdnHAsXobyKvL0dM1mg491nuQ2Tea4Ca8tbo4CDyGDbPDKoJ1+BfUSLciFZMydjSQybcYUWlDiS3hDYrlqhYAaUsZkBN6Z+R4TTLf2pFn+EGoEHPajK7gfuc84YPMdlJigW48KW0eoH5NtHUc2v/1kZfODo/3MWHw0stCDKV3jpY1SjT2GhFcIyqnAn6rYZxC4GgaVsdn2fCY77LjdynYT0t/EkTaPghPlmlEiz4eyOklKY8v8woG7ATbvFoNe/IULlc+QX0bjED6aZYMzVGp4i192ryauHdWIgxQh18lkPZt66hjtoiBPPIpwKZKP8cLTGjNQIRp8xz2eW0sCTpDkY8zAvwMmrSQu+XQ+GXkOtr+AG1zt0AroPb2l3cuI4Bc3BZVHdGvVmQ0ydSLIddlzNrz60A8vnPvRU+jN8kbBtb76q34IN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66446008)(64756008)(54906003)(66556008)(66476007)(66946007)(6636002)(316002)(41300700001)(76116006)(2616005)(6512007)(26005)(36756003)(71200400001)(6506007)(478600001)(6486002)(38070700005)(38100700002)(122000001)(82960400001)(86362001)(83380400001)(110136005)(91956017)(2906002)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YllBK3pXOWIzWWdkZ1FlR0RXVUU2MEFGYnRFUjI2VGtjRlBIZUNzdDNNK01q?=
 =?utf-8?B?Zk9Kb2Eremo5VHRIcm96dmJsTmkyTUdNeXRiRjRGUDEwNSszaU5McllobUVp?=
 =?utf-8?B?cEtYYlFwcUpSY3JxZDJydzIxbFAzaG5LRmI4a001aUt4dEtaYkRvZHZ4RFJx?=
 =?utf-8?B?NmFSQmJ5Z0Nodnp4dlhUYkdQVjdsT21ONjYxNWsvTWJrdDE0UnpmTUJBWEYw?=
 =?utf-8?B?Qkw1K1RhQ2dDaXRrT1ROdWxxYTdCWWZoMnFsNklVMk04YUFycVJKaWJVdEl4?=
 =?utf-8?B?Ry95bEtldURCNzByMHNvRnZkdFRYaDBhV2k4M1pHSGZMc1g0NC9zZ1RhaG9t?=
 =?utf-8?B?c0JjUFdsVE1rT3BidjlMVXdicmZEdnlZRFRDYkg4dnhrZjMyTGdqWWhPQzdR?=
 =?utf-8?B?Nm9YTjAwSzJ2WCtDSElhNVhyU1kwa3NIVmhET0JHQy9ZcGRCd2NtU3BxSFN4?=
 =?utf-8?B?R05odDZ4SUREWjNSOThrL2gzVFpLWW55V0xLZEFkcmlsZ29sbWtDSEliS1hJ?=
 =?utf-8?B?NHNGTlZBRXNKdk9OY0N2VklQd2ozNEVSSW95VUY3TzJ0OTh6ZWM4clh6YU1w?=
 =?utf-8?B?UFBuMVNKdEtFbmpDdUY0UERJS2Nxc3dzdDdwdXdSSzFtenNKSjRFd2xURjR1?=
 =?utf-8?B?ejg0M1JjZGhPem92L0RkTGNlV1Bzb0F3TUFCREtUbElEUUlub1JwYmdOdTBq?=
 =?utf-8?B?QnczQWh5M3ZsN3F6cTdhbXpZREF5ZWhzLzZtZVpHd1pZbnJCQitlY3RYRVF6?=
 =?utf-8?B?bGtLVm8xcGwraFZhc25TanRHb2ZHKytpMXpQTWNRcXJvUE9VZDZJYlpwT3lR?=
 =?utf-8?B?MzFRaFkrUnRUOHJqMkZ4djR0R05JMS9TVDRrcERpZWtpd1hxVXNJcmFtdk0w?=
 =?utf-8?B?VU43R0FMbi9Jb21TRnN4Z0tUbXltbVBWalhsR3JIMFpJME1xWHNSM2xTTHQx?=
 =?utf-8?B?ZDVxdlF6cVErcythRDYwQ05BbDNUNUs3YlRuMldIQXZVRlR6Um1oaFFlY3Zt?=
 =?utf-8?B?b21rVVpxV2VObUFMWEEwU0xDeDF6dmJHVy83TTFGWkVXMHQ1czFOYnZFRDNU?=
 =?utf-8?B?TVgwUjVxQldqcWtPSmwwRkVyMXBNSS9WWGUvWVdIZzIrWWowTzlCQzl4Zi9o?=
 =?utf-8?B?V3dUL3lObXJlU3RvdlB0WUdIRlRNTStFSTRXcUNZc2cyM1BuS3UrT2FvNy9w?=
 =?utf-8?B?K2lGNEJGd2l5bEYwYmlBblVNU1JGU05hNitrK2FnQ1hlM2hKYTlnb2ZYeDE4?=
 =?utf-8?B?Sk92MlFFd0lNb0tlYjRtVzVxOHJMMi9rRXc4amNlZG5VbWtCZWpCZjk2eTNk?=
 =?utf-8?B?c29PYXNKOUtOWmZaeFRCVGhTS2RGcjhJdVduMi9LYlJGQXdkT2pPZVAvYzFr?=
 =?utf-8?B?b3ZCTTZoTlAyeHF2T3Rvb3NoNTRRTWVab0JvZHVNMzBtT1J5c0pNZlFrd3Uv?=
 =?utf-8?B?UCtna1pGcGNYdGY2WDNhNytHTU5aV1ZWd3lkbkE1ckthRXpVY3EvY2g2QXFq?=
 =?utf-8?B?dmRuQnNnSGYvdVJ5QzBiRHZPZlBEL1cxTWVIQTFsaHZXblNHSlJPdHFFc3Ja?=
 =?utf-8?B?bVAvSjFuTUFNeUozaUlnSzJZYitjYlh6YTJ6Umt1aHdxbHQ1cThqemdRQ3Fh?=
 =?utf-8?B?enAxS05ZTGtmK2JMeDVWYUNRRGg5SWRLR3lpSy84S1F1UmVsdFhhNFpKSW04?=
 =?utf-8?B?VlEyYlVXY0hXOHNvK2NUZnBYbUlJOGVOaW13bnVsS0dHT0dZOTkwcGJXNDds?=
 =?utf-8?B?M0ROSUV6OUJvOGcySHBJY3U3bStMVmUyUk5vQWsvbHZobzM0eUdkNUlNSmZx?=
 =?utf-8?B?dGpoTkNQMlNoWENUWldyaTZBZVFWZEJLNTR6cmM1OGZ1QlhZUmpqeE10enFl?=
 =?utf-8?B?SCtVaUVWbTJyWXFZT1hWRjEvOVl6cGNhRkh0eG9NcGgySEdqYi9NeklKYll1?=
 =?utf-8?B?a0N0c3VEeHRmV21PTDF2LzV6cVZ1OWlyUHZ5TUxGNHdaU3pMcHI3TDExcm5C?=
 =?utf-8?B?Ujk4b1htb3FzMEdUVlVYNUhjSGxBVXB4eEVhbUVwdHZ5dGllQVB2WkdhZmpi?=
 =?utf-8?B?d3JSUnczWkJkdVFWbnN1Qk1NazVrQkZPdGI0UmFPNTgyRlQwdnp3UDB3eUt2?=
 =?utf-8?B?RGRHd1dYZDZDRHZGc2toRGVjNGUyeW1HMyt2a050bnVMMzRhcERMWVBKWmpM?=
 =?utf-8?Q?vcv9f/+SBnjzHuuTsqGAQ1k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBA3DD213809D24681545F3ADC649139@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad6da58-fa24-43d8-de9e-08dbc4af565e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 07:55:55.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UejEA8alG5bcVyy4WRtdqAiDRAI2ZpcEzvdC0Sfeduf8xMVj0s1db+kW9KmwncAHnQmxCAFkjoQPBfqFrxjmLy6XIh+Fi7ht7o8CA+q+X5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7532
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTAzIGF0IDEyOjIwICswMzAwLCBEbWl0cnkgQW50aXBvdiB3cm90ZToK
PiBTaW5jZSAndHpfZGV2aWNlJyBpcyBhbiBpbi1wbGFjZSBtZW1iZXIgb2YgJ3N0cnVjdCBpd2xf
bXZtJywgaXQgY2FuJ3QKPiBiZSBOVUxMIGFuZCBzbyByZWxldmFudCBjaGVjayBtYXkgYmUgZHJv
cHBlZC4gQ29tcGlsZSB0ZXN0ZWQgb25seS4KPiAKPiBGb3VuZCBieSBMaW51eCBWZXJpZmljYXRp
b24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IERtaXRyeSBBbnRpcG92IDxkbWFudGlwb3ZAeWFuZGV4LnJ1Pgo+IC0tLQo+IMKgZHJpdmVy
cy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHQuYyB8IDcgLS0tLS0tLQo+IMKgMSBm
aWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3R0LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9p
bnRlbC9pd2x3aWZpL212bS90dC5jCj4gaW5kZXggMTU3ZTk2ZmEyM2MxLi5kZWU5YzM2N2RjZDMg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHQu
Ywo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3R0LmMKPiBA
QCAtNjQyLDcgKzY0Miw2IEBAIHN0YXRpYyBpbnQgaXdsX212bV90em9uZV9zZXRfdHJpcF90ZW1w
KHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICpkZXZpY2UsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbnQgdHJpcCwgaW50IHRlbXApCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpd2xf
bXZtICptdm0gPSB0aGVybWFsX3pvbmVfZGV2aWNlX3ByaXYoZGV2aWNlKTsKPiAtwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgaXdsX212bV90aGVybWFsX2RldmljZSAqdHpvbmU7Cj4gwqDCoMKgwqDCoMKg
wqDCoGludCByZXQ7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgbXV0ZXhfbG9jaygmbXZtLT5tdXRl
eCk7Cj4gQEAgLTY1OCwxMiArNjU3LDYgQEAgc3RhdGljIGludCBpd2xfbXZtX3R6b25lX3NldF90
cmlwX3RlbXAoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKmRldmljZSwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAK
PiAtwqDCoMKgwqDCoMKgwqB0em9uZSA9ICZtdm0tPnR6X2RldmljZTsKPiAtwqDCoMKgwqDCoMKg
wqBpZiAoIXR6b25lKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IC1F
SU87Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+IC3CoMKgwqDC
oMKgwqDCoH0KPiAtCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IGl3bF9tdm1fc2VuZF90ZW1wX3Jl
cG9ydF90aHNfY21kKG12bSk7Cj4gwqBvdXQ6Cj4gwqDCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9j
aygmbXZtLT5tdXRleCk7CgpBY2tlZC1ieTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVl
bm1hbkBpbnRlbC5jb20+Cg==
