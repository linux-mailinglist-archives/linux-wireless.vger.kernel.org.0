Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC55064B0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 08:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiDSGo3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 02:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiDSGo2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 02:44:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B4F27FEA
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 23:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650350505; x=1681886505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a6bwoabvdiChqvb0RQ9nOkRLxjjqCtUgPVqR/1T+ga8=;
  b=ceVeM/g3QSwg1IiGIzd7sfhc0Ym/MUaXt9FNgq3FjotmS8Q4lx96QOPE
   XALLbOFdgngfwDpgZqbxPi1o9sqFMO0ixhstw4LNZNxIg28Z6JfeK/HsQ
   yVpi1LxGDzxIE7hIkaeTcBt019oHzQBBRTEL2NmgIBnfF+IGx64Gd+8vc
   PlKlaMVx7nY29L+2p7kRyt6pkxxpd9Cvcu6ilzhIY9jbgk80Rx/ll84mE
   GZIQ/sYAcHl2KV0pCXR7mXCPorXiB2Q59oFk7md2pmivx/GUue9W/7pgY
   tSUq+cPg7iSCnf9x47oQDWmBZyshwIHZ11sd0WcooecRXVXPkl+TegJQ8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="244276549"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="244276549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 23:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="575947868"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 18 Apr 2022 23:41:45 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 23:41:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 23:41:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Apr 2022 23:41:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Apr 2022 23:41:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QybczKrilXq31Y4EZqU0FFRieqfUOOHcfXowQRjCI+DFGecyei0nqg3B6i31S2GW5pzcGVj66AQ6EUxtVD10tDPn18vClAVbk9QWEryWo4suFuErcUAtGQm7brsDpfm0phLi5KrNRCmhvKW3ZtGklAp2O0RQrAzjiUtKKrSAe6eyI7EgT97yrFHZYui28LDf0DX66zgAgJQrGAjmMb4eEZV8YUwewg3W87SlaqkMSj/tAukEEV6GEJyORo26dy9osrOUBTI969SmEw5U0jnZ3tY8UqlacgQWCF4uwdV4WLMu58SNlIcv6nBnXh8OYx0ntPsnqAFrn3Q6QkdWGCDRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6bwoabvdiChqvb0RQ9nOkRLxjjqCtUgPVqR/1T+ga8=;
 b=gA1taVsPiqhkgY7EOZb/DF5hwTijD2TSaTbFP+doDoJuV/ysIZvnp2oq4rr4xJklvxXxTfoPZpmCzhyF/URjFOn5Sm0ya+MLAXObsaIczrVesgx0nAv4aNjN1KUOgF+pegDFddI0dKOnzFl57/cJdktAHordsS8rAlNbp7/0eMx1fgk3KOdPN2fBxVcEj30Ccr+GjM/biUTZSyTMb/IfX2nZ1Z/V8zeEnuTa4bsborKVqtag+x2jFXBrrdauw8UTanV/HHGWiHgerdLC6k/x+RzmKpeIjP7ru4Hw1bLPJUO5oCdd5ZxmZglp8WwNpW1e2W/EDdSTQtgPn39q7jKwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by PH7PR11MB6029.namprd11.prod.outlook.com (2603:10b6:510:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 06:41:42 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 06:41:42 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "toke@toke.dk" <toke@toke.dk>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYUxiO5laT20cdFkKz0kQ4shKh3az2xgSAgAAE2IA=
Date:   Tue, 19 Apr 2022 06:41:42 +0000
Message-ID: <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
         <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
In-Reply-To: <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b638dd1-b160-4a66-44f0-08da21cfaa54
x-ms-traffictypediagnostic: PH7PR11MB6029:EE_
x-microsoft-antispam-prvs: <PH7PR11MB60293E4A9398E6C6533C59E1F2F29@PH7PR11MB6029.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNUVe5iZdPuoI+DkMDJObQuztF0BWQ1sWOiAx2kmbCkK4+EmIeiuChAOymcPQJCe7NSiSAmbtYp5GeBTEp/8YkRBnVVuhGboUnMLuAH8LDfH90seH7BaAx/ANGeYQmsQz4ieRdrfX/dYLFBspm4vG7cQlrYODFozQTUyO/jfls7KzFNq8deND6GhVc0bl7NwBU4BuX76WQf0ixNEy4xxQCaWC/a7JQ+1VcznsyAFgZNMQY/YLPSwuV5mAr+7PBDZFK6rr4AONE437/xgHKwt7Zp7SeVbFriNcPMQS5FNRKMXfxH/P4YCkKwZYJr+32xTNcmwVRUdXYXeaH5Rb5EAhFvZAobyfs8+J3PrxebzIPFJMlb5efbm5Yx23X4PLoR5vvIa3gOJbcy6FGkCqmHeZF8SYFTT3+EA89uILcmuYOtVxST9loDIyKfv9X+kMfN4haOdwoxUI95gJHMdhjGMW1rDeHP5/K3jkPiqxcbVpInAsrKnbzjbmYJwHrAVTE6QA65z0ZkggHBjbVPM/X439rtmZB1lGLtpHDlmTeiGqo+YfDX1NXlL5aiplrLS2Xd1Z0oLNCa3bLICWrREnjdQ981X+3lcf+YkfUn0EuCiX1N2mCE2Ys8kvakb0MYzQsxTIIPULoi3IELH7eM1CBVoWro6k9RIwz26JGzGvoqrVwd4e/OnxiHvFJp+4BbaUBpTz6EJLHBH8ahJC6WbP6E89A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(107886003)(38100700002)(38070700005)(86362001)(83380400001)(6506007)(66574015)(66446008)(66476007)(66556008)(91956017)(64756008)(66946007)(76116006)(6636002)(36756003)(316002)(4326008)(8676002)(71200400001)(110136005)(54906003)(122000001)(6512007)(2616005)(508600001)(6486002)(15650500001)(2906002)(26005)(8936002)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjJuRUZ4QlNoU0tuejFqK1RkTGg1OUEwQ1BEc0hET2dHc1FpbjgxWGRGdDZa?=
 =?utf-8?B?dzQyRkNyeEp3Rjg4cEpXaVBEbU9iYjcxUDFRTVJyeW9YV2dWVU50ak0ySXZL?=
 =?utf-8?B?R2dWNys4Q09HczVTRFNaQTlPakpqSWxCeHBYb25DV0daL0RBaGFwZnpiTENX?=
 =?utf-8?B?dkVvckNiLzB1OTl1cHZ0ZGJlVGVoNGdMa2tQeURldnR6VVM1TFR0MFM2dGxi?=
 =?utf-8?B?dVg2SGYxc3dwbU1vN1BrZXh4b2RENysvSHRrM0tKcEFFU2xKSnVDN3JCWUpV?=
 =?utf-8?B?SFVRcmgvK08zRnduZCtySVQyWEhBelBXYlNRTjBTNTVlQjd4aG9kcDBuOVAw?=
 =?utf-8?B?THZobExpK1UzajNKM3ZKSmlaUVprcTBHcFNsQUdxOTA0U1FzTW1zSSs2Z3o2?=
 =?utf-8?B?d0xCU3dTelB1VitrUmhaRDdnZEhKaElFMzZWNHVMTFdwc3hnOUcyYUZEQkFv?=
 =?utf-8?B?ZE5RdnZZanpRRDNtWlQrZ0FaZVpYcWRScnVkZnUwcHBzNElxMXU2djNLT1ln?=
 =?utf-8?B?eFp3cDhUYzh6UmRqODBWalBZeWFmZUxteEhiQ2g5ak0yZHhwM0ZOQkJGUXVr?=
 =?utf-8?B?Zk1DM1RzRlZibXZWbVZJT1lOcTlxR0hacVVOdEVXZmIyVDZiYmZwVzhvaWRQ?=
 =?utf-8?B?bDRCZ3BrKzloUjRpbHNFQlpXQnpvL21TWmVnZWpXMldVMzVjcmZaNzBuQk0x?=
 =?utf-8?B?WVV5OHBLR2hWWUxMUHkwL1REaVVJYXBSeU5QVkpydU5rcStud3JtbG9HcEZM?=
 =?utf-8?B?SGxhdW9kN1g4WjF5dWR6dmhBSGppQlF3cUdsYk9UNTV1ZDRZY1V5elpEVGxm?=
 =?utf-8?B?NkYrRG9VU3BGYnJZZTFBYlZjaFUvdEE3NEJmNEI5a0RjdUFFSkQ1ckVsT3dm?=
 =?utf-8?B?Ulp4RmxvVDR6NHM4QzI0SjRKMUJPVHJDdFdiRGhDTTZ5YWtTcmsxS2V3OU5w?=
 =?utf-8?B?TVdTUzA2RVUrQkxKOVBGckNTMVF2dDh6Z1VuakYwOFlEa3N4dG01eTlzWm12?=
 =?utf-8?B?MXJHUCs2TUxlVGIwbndVWXhEMWNSNlVkd0Nld2ZOWmlBcnNDTDFEYmI2cER3?=
 =?utf-8?B?eERlcytrcVczQWRkUUZQekIwQnQzczNrOWkzU3ZCbkdKcGZlTGloQk1oVW5R?=
 =?utf-8?B?OXdybnFTY2l2cTVvT2ppTW5qTlRRb2gyR2I3OTg3MTlaeHg2NXpLUXU5Z0sz?=
 =?utf-8?B?NW9FMWp6bWVrN2licDFaYTI2d29PeldsdDhPdTg1R29FNE5mQVZtMGkyb2x1?=
 =?utf-8?B?NnZQcTBPeG9BOEZhdGw2T2N3YktwTzZMNm5tdWREK2h4dE1VSEMzc25LT1Zx?=
 =?utf-8?B?UHEzTzY3RkdPVXljOTZ0UGp6T3RwMkN6azFDRUFlaVZ2WUxjOU01Z2lKTXpz?=
 =?utf-8?B?SUhUTUppYktZa2dTVUcvS0RjUkdCS2xhdlVEaHY1S3QzVmVRS2tFYXk0Szc1?=
 =?utf-8?B?bmxMRnFjUFlVZm1BWHhWMEZGOHFMZEdpbVdSY1JxbjFFTkRlNUZuZTZmWlRL?=
 =?utf-8?B?dWF6dEFNQ0Q5cjRPY2hvcm1KaDEzQkJ4VHdyVnAvL2lZaVI3S0JWcTdiNkVs?=
 =?utf-8?B?Wk1PQW1pT2Vvb25tNFNZQVBDTTNSd3hsWHVrUG5DdTFVRDdDNTF3QStYaGxv?=
 =?utf-8?B?aVJlNGJJUksrUWhQcG1ob3F6UTVxeWppSTRoUGRqRUFxODBFU2lrWEgwWGc5?=
 =?utf-8?B?SFp5RHc5bFNGajBtMS9Wc1plSjRKSHRJQXRYNUQ3OVpOQ3Y3K2JZY2VYaTFk?=
 =?utf-8?B?UjVqcnphQTlNQmlsMDYwN054ZEw4dHZ3azV0NGpTVjZJSnpuKzN2U3Q0Rnla?=
 =?utf-8?B?bTEzL2JhTS83UzNld1l1Yi85MEJKL0NibC90Z041UzJQR3haZlo4c09oQksv?=
 =?utf-8?B?Unl1VDFITzRiQ1pPLzljeUcxS1g0eElGTU1hVGlXaWhuUkE1NmxkeDBJL0Zk?=
 =?utf-8?B?K1BhN0tnbmN1MjJzVm4wbXVYekRLVUVkYVJtbVRZdkcxN0NmMG0xaEZ4WDBG?=
 =?utf-8?B?UVhmYVJsM0E3OERDVVYzRlYyS0RlZmV2MmlNQ3l1Qk1SekFmTEJneUc0T1d3?=
 =?utf-8?B?Z1JRNmF2dVM5WmthOUxwWVFUUU9ob1FQdVhNRDVrWWs4N1RBOCtOVVlzaVA1?=
 =?utf-8?B?MkhGT1pVdmNWVEx0aTVUc3VVQmR3UXRzWFhSSDhqRnJuWkRiK0Z2UTFnNUk1?=
 =?utf-8?B?R0FUSjRKUUt6TVpHNXlGcTJNbVIwa1NjbE1rUTc4dzdmbHI5QjE3V1paaHBh?=
 =?utf-8?B?S0phUnJPUFNjV25PYkQzMTRTd1RoU3phOVNsbWJYbmRZcERPK09rNGl6VVg4?=
 =?utf-8?B?MTdXandGMDdpcDFvRTM1c3h3SVN1a2pSM2NjZldXSG5ZL3RIbjk2Z1YvODFq?=
 =?utf-8?Q?XUB3WCMsHJ8UmjnXAQof6iQdFiWtZwqThtW4h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC680DF895E9DA4999B5FFEEA346907B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b638dd1-b160-4a66-44f0-08da21cfaa54
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 06:41:42.5474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcdcSi2wQKEnlBSK8J/6GPscn2vbVWrxGluM6OYDTt3gvJkAyh6VpwcS5kB3761F72dw/lvs7IkovMTZx7rVXirCe68FaOs9WIHq86/Gryg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6029
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgVG9rZSwNCg0KT24gVHVlLCAyMDIyLTA0LTE5IGF0IDA2OjI0ICswMDAwLCBDb2VsaG8sIEx1
Y2lhbm8gd3JvdGU6DQo+IE9uIE1vbiwgMjAyMi0wNC0xOCBhdCAxMzozNiArMDIwMCwgVG9rZSBI
w7hpbGFuZC1Kw7hyZ2Vuc2VuIHdyb3RlOg0KPiA+IEhpIEx1Y2ENCj4gDQo+IEhpIFRva2UsDQo+
IA0KPiA+IEkndmUgc3RhcnRlZCBzZWVpbmcgaXNzdWVzIHdpdGggbXkgaXdsd2lmaSBpbnRlcmZh
Y2UgZ29pbmcgYXdheSBhZnRlcg0KPiA+IHN1c3BlbmQuIEkgZ2V0IGVycm9ycyBsaWtlIHRoZXNl
IGluIGRtZXNnOg0KPiA+IA0KPiA+IFsxMDQzOTMuMTQyMjY0XSB3bGFuMDogZGVhdXRoZW50aWNh
dGluZyBmcm9tIDRjOjYwOmRlOmVhOmI4OjU4IGJ5IGxvY2FsIGNob2ljZSAoUmVhc29uOg0KPiA+
IDM9REVBVVRIX0xFQVZJTkcpDQo+ID4gWzEwNDM5My4zNDc3NzVdIGl3bG1laSAwMDAwOjAwOjE2
LjAtMTMyODA5MDQtNzc5Mi00ZmNiLWExYWEtNWU3MGNiYjFlODY1OiBDb3VsZG4ndCBnZXQgQUNL
IGZyb20NCj4gPiBDU01FIG9uIEhPU1RfR09FU19ET1dOIG1lc3NhZ2UNCj4gPiBbMTA0MzkzLjM0
Nzg3Nl0gaXdsbWVpIDAwMDA6MDA6MTYuMC0xMzI4MDkwNC03NzkyLTRmY2ItYTFhYS01ZTcwY2Ji
MWU4NjU6IGZhaWxlZCB0byBzZW5kIHRoZQ0KPiA+IFNBUF9NRV9NU0dfQ0hFQ0tfU0hBUkVEX0FS
RUEgbWVzc2FnZSAtMTkNCj4gPiANCj4gPiBBbmQgd2hlbiB0aGUgaG9zdCBjb21lcyBiYWNrIHVw
LCB0aGVyZSBpcyBubyBjb25uZWN0aXZpdHkuIFJlc3RhcnRpbmcNCj4gPiBpd2QgZml4ZXMgdGhl
IHByb2JsZW0uDQo+ID4gDQo+ID4gVGhpcyBpcyBvbiBhIDUuMTcuMyBrZXJuZWwgKEFyY2ggTGlu
dXggZGlzdHJpYnV0aW9uIGtlcm5lbCksIGFuZCBsc3BjaQ0KPiA+IHNheXMgdGhlIFdpRmkgZGV2
aWNlIGlzIGFuICJJbnRlbCBDb3Jwb3JhdGlvbiBXaS1GaSA2IEFYMjAxIi4NCj4gPiANCj4gPiBB
bnkgaWRlYXM/IDopDQo+IA0KPiBUaGlzIHNlZW1zIHRvIGJlIHJlbGF0ZWQgdG8gaXdsbWVpLCBz
byBJIGFkZGVkIEVtbWFudWVsIHRvIHRoZSB0aHJlYWQuDQo+IA0KDQpDYW4gd2UgaGF2ZSB0aGUg
ZnVsbCBkbWVzZyBvdXRwdXQ/DQpXaGF0IE5JQyAvIHBsYXRmb3JtIGRvIHlvdSBoYXZlPw0KRG8g
eW91IGhhdmUgQU1UIGNvbmZpZ3VyZWQgaW4gdGhlIEJJT1M/DQpEaWQgeW91IGVuYWJsZSB3aXJl
bGVzcyBvcGVyYXRpb24gaW4gQU1UPw0K
