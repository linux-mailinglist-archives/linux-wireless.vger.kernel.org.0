Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979C78B0FF
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjH1MuN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjH1Mtt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:49:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42B21AA
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693226982; x=1724762982;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mNcHqdru6VsKYTVdVQnuYoTa9E/jRrZ6WRMztZukA1M=;
  b=UaxfDkrTLsTTOpqm1nztPdehpEDbAzYBGR492uRKs0pwTta4eXS8jBwI
   1xuadCbqmeiKJiY+kDANCQFthh1V/AXqWfQweKTk06FOC45yMQp4udYbO
   /hKRaBz8RgxDzSoIbInAMM59u9a4Z6ZCUpE4ViE85l5//M0KS+JZo098D
   cQNVYErldktjRJgCYoDwvt00PRk7aSvVZIo9cnOZikrZSZ1d4RLJP4fdZ
   2ec+atqUZjKhC9r+fmot3kKNNIC6eHBP/Y3pFllj6OITIal8GTsyjdKgz
   UJIXCgMkEbtTCx/hl/qKMqGJF+zCqXrhb6ceyn8hORpMFTO/+mS1EoxML
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="439038227"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="439038227"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 05:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="912042659"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="912042659"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2023 05:48:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 05:48:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 05:48:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 05:48:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 05:48:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J51dJy36Gz13TixgX4rGBCnFlrk8l7TNf9h1R2rRuzgvtPUlQ/nPntNjETCYSlM7V2WajsR/on3NX5e08LjkHzGV+trNcZEJBp3AzLCcUlRPRVwqYCCyPpZsWKe31i+PrHun9TghjvUGpritEBhcAPQFZR9DQrd0SSY9ehZ2GWLu9MpX4KUJ3U7xmfo6H5xFU8EmlkV+cXn1Al5lYlSJjbXbLH70ZiVI+x53ZtZIIGYsr4C4ICe4cBCUP1XgTIiUHhZ25t8vgzyZfwns/RIgt5TWHxlZdp0NO5cK71wHbag3TTv57ln4P+Xl6pre5L5nfCJm9Ib0Tqq5K9a6sy82Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNcHqdru6VsKYTVdVQnuYoTa9E/jRrZ6WRMztZukA1M=;
 b=BaIPbSJ/34WL52Rr4rY1IoyvRtv37iQs2kNn0iwbMCKKmm8h7WrXbq1ohuityS6ZfZKdKIwTmdtxedpQ+GEWzOOvL7LKbBbVhXF9JNFWuAkxpiwAt8DS0WYFtShV55in8eCjmeomRxpnrkdAqojCJSblBjrxWLMi03o3ycRfHZwW9CUW1ap4sBhymzt2Oym/GvADbl9mtxhvE7yZPd9F2xvbEjU8kVQgdzfiAUsxL3XdiTeKf1A3xvs4Ci+OhYBf5suuTLXdvKFtmRoOgnzHvlcadvIQKg4Qcw525VbKX6WICB1H4AKLta1fCycf+ezxdfP8yPxb97NdtKchG6smPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:48:13 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::c733:b6c6:fe0d:d4c4%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:48:13 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        greearb <greearb@candelatech.com>
Subject: Re: [PATCH] wifi: iwlwifi:  Ensure ack flag is properly cleared.
Thread-Topic: [PATCH] wifi: iwlwifi:  Ensure ack flag is properly cleared.
Thread-Index: AQHZyjtTGnE1lL+mh0awgz4QOvxAMq//x1eA
Date:   Mon, 28 Aug 2023 12:48:13 +0000
Message-ID: <1043cb7c01b4a26377921c1ed8f080194cf7123e.camel@intel.com>
References: <20230808205605.4105670-1-greearb@candelatech.com>
In-Reply-To: <20230808205605.4105670-1-greearb@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SA2PR11MB4860:EE_
x-ms-office365-filtering-correlation-id: 6c029746-1f36-4acb-bcfd-08dba7c50aa2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBXwqmsPifwmaQRdLBi9etuu3KuH/h58pHctkxFhv73zw5JGVMsjzTPu2AVFISjPPtDFKCU/oSMOqCRGc3xNeNBdQJjUwK5SxQfo29p5PCPbrjI3igggLlEAezcw8Z7ChGXx3FFUzbezHPkoA+3kuxtlOo9d5zlprFjiFyxyeL8IjJ21qLIJruhjwnW2/SnV+RAMidwUHGxkq/UaaI9C4bdjU4Un+G2+ihdxx2GiOtK6b0PHUS6h98c0pEryYGWqxA78+G88C58V+NfcuTCu/WE2Pof935cTTse/c8ieFVtiXhsxe6zPZMCmpOkXme7ebcEmTxduY969dqjRFueIy0BDAjFFm73rtmOYCSZivxuducj0J0w/LdOLlpqCajW0+jleKZW0zzqmlmDE2HUnzmkGQPfYmcSziPvwyUXP0S8t1WVtUHC84IkDCSM1U/2rWGJZQFWxU/UHq05rVLaDyoFeHSGhxeYTwjMXsmDT+CC5vSWPWGkr2Xg4JuoclNcO6NprS4eTwqGV4lFmVqFA9XnHdtE4KLpzhKt2HMnSMZSOENc881orbVUP3vJMZTJR0rv/mmBNpREm2CyjxSWhOaMotwTKvjka+bVdDhtndxUd76X9ne63K+B7mkLROj5F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199024)(1800799009)(186009)(6506007)(71200400001)(6486002)(6512007)(36756003)(86362001)(82960400001)(38100700002)(38070700005)(122000001)(2616005)(2906002)(26005)(478600001)(76116006)(91956017)(110136005)(66946007)(66556008)(66476007)(8676002)(8936002)(5660300002)(41300700001)(66446008)(316002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXdNaTFRbENrbjJTajR5ZE5Da054SWxHbUdPY2ZPVmVOWnhUeDhGYktXMVFT?=
 =?utf-8?B?OXNLZDRoQ3daYWZxUGNwV24zeHZxaTNaQWZTYlB2Q2c4d3NIMWpUK0QzS3g3?=
 =?utf-8?B?UThlVEZheEF6OXlNYzhBTXVHMUFKdzE3SEM0WjJ3TFQ0YmRGWHptV1B2NmRO?=
 =?utf-8?B?Z1I1SDlsRXlUOS94Y1BYeTl3Y3F5VnFPdkNIZG5WL2s4OHAzVTRNRnU0cStV?=
 =?utf-8?B?MTJlWUo4Y3FvMFN6UGErb0ttUGZvQ2NheU04K1k0aVN2QlRHYzJHMXVXWGJJ?=
 =?utf-8?B?c0ZBd2F1d1VuR2l6aGJiT1Nrdk9kNFo2emd1dnN2TDc5SFZ2TjF4TmYwZ05h?=
 =?utf-8?B?RGdibW9qMWIwZHpIZ29ycStaYXc5NVhqZnlGUDBZdXJ4Rlc3Y3BJaEVkMkpy?=
 =?utf-8?B?MGhWc1N3Q1FlN3dESUFwUnJ2Y3NFVzRxVVlnUVBGWnhLa0d2WERzYUtUUFBs?=
 =?utf-8?B?YlNDQjEybTFwcTlZcm5WbXQ1cFp6SDVUUERNQTk3QnM0Q0FnUEVLaVdmNmRH?=
 =?utf-8?B?Q0tCdlJUQi84WlNSTlloRWVxVUp3aVlxazg1cDFJbk1iNVlXVUlCcVpMMm1p?=
 =?utf-8?B?cGtKaHMvMVg5SjNwb3JadDl5MVRoenI2R0xsbjhkemh5K1BnWExJOTN2bXp2?=
 =?utf-8?B?RDladjQ5T3pSNGJJVDJzaHpVSWdzaHIvb2toY25GcUtlQlpuaVZkQVA3Uk95?=
 =?utf-8?B?eXNlME5DaTBBSlRIZzhCSGV3eHZnUVFwZ2FxMk1uUnNyZzVhZ0lRaDN4bXlH?=
 =?utf-8?B?bDY0QVpsUzZiY2dZczlqWllMOEdseDArMUVjZDNrd2pNYXNvQStYamNLdVIy?=
 =?utf-8?B?STYyTWMwMVBXRjJvSmNEcEFmdlZEVElLMm5QTGNFdEMxeEJVNXhLSjd4cjRE?=
 =?utf-8?B?cmNBQkNzdDhJcDJzd0dFbC9aQ09VaWxrSllodDMyMTg1VlNIaGllc3VXcGJi?=
 =?utf-8?B?d2I0R2dlbEpjNjB0V0IxRzd0VVRmZUVFWUp2QVVBb3gyeUgxTjdWMVAvbTNl?=
 =?utf-8?B?Vk94ZndLQ1d1VHpGVWlQZi91RnlhMmRjU0F4bEdFRWx0Vy9lQURKZnZiV29R?=
 =?utf-8?B?S2R6TEpocSsyVFZtSjZIUHJyMDNvd3VIOEVMRjZ5d0p5Q2YrcGtpeTNDZW9O?=
 =?utf-8?B?bHZlS3lBbFFiOXpFZEU0WHo2ano1aCtGZ0ttSzJ4eWdRcWM4UHduclowUjl0?=
 =?utf-8?B?K2h0TjZBVEUyWnlGVmk0Q09mUUthTUZvSWlrcUhlTEpuWkZtTVllblYwOVA4?=
 =?utf-8?B?dUpNWTFITE9lWk1qVEFyaE10cG4xblBuTTJxUnNPamtiWU9qdkFLemVzOFZJ?=
 =?utf-8?B?WU1CeDdHRCtDV2pKV1JaSlhqUzNtME8xUjJ3bmFJamJQcFhZdXE1clpYR29F?=
 =?utf-8?B?U1RlK3lvcVg1d1MvZnhYWGpGc01KeTVhZUFYbDNLWFRlWHQ0VXRnYUZlOWlQ?=
 =?utf-8?B?VWdrQXVhL2ljVnVnQ2xtT3g4cmovT2J0NVY1dE9NMzh1UWN6L1FJVDZ2UE1J?=
 =?utf-8?B?U3c0cHNEaGNQVDIwaHlRTEJaMjlGcFJkWklyOW5YMTNvNVBka1piajQwVGs5?=
 =?utf-8?B?cWtpb2xoZEtoY01mZy8zYUZ0NGgyTWZyeFpsWWF5bUMxbDhXeXZJZ0RqM2hQ?=
 =?utf-8?B?c2hySVcyUGR4YmpnSlUzT1FYVlZ6K1VNZHNZRnNGVkFjV0dUbVJzckswL0o4?=
 =?utf-8?B?MFg1VkZtTFk1VkROdGR5cS9ITWp2VXBLTGJpQ3NVbW5FMzRuWUVvSEZnMk9I?=
 =?utf-8?B?R3g2OG8wVERCZm9EOFQwejF5aHg4a3NncUZjOE91QVBRSGJOcXcwNmRoQ3lO?=
 =?utf-8?B?T3RiV3V6bnN2and4RW5kczNxcVN6QkRPUldmTEY3QXh6ekxWTkpNQ2V6Ym9i?=
 =?utf-8?B?eU53bTE4TWs0LzVhT3c5K0JiYzc3WE5LZXA5ZHpPQ0lWdjN2cWpOTlFUUnFo?=
 =?utf-8?B?YjVhOEtsdnFLalRpdkxINFNFQVN3VFJ2cHJKRVFjQ3dSbGxSQUZJMzdxbDI0?=
 =?utf-8?B?Q2FrQWYvSVhkWWNpZ0VSYThZRXRGYTJ5Q3lrTzlGeFgzWEtvRmdIRDVHbzlt?=
 =?utf-8?B?UFVqOVdwVmZYZmt6RVVKaU5NOFpwM0pWTzNvQlVIYk9kQVBLNThaN3lzM1N5?=
 =?utf-8?B?dWVOR01HUXd4TEQxVytmeEdja05iemlDbGI2WmZDUi9vVjVZV1loR3JlZWNy?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E1CF84EA21A754DA9B56EA6C37AA985@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c029746-1f36-4acb-bcfd-08dba7c50aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 12:48:13.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWn25xVPvMh3qvo/CCHosPy7rT6AYDhy5pJ1M7erEHizz8E3KhLvKQOa1f5LJWkcsF4zIF+Haesd1z8IxpzwqhzuwQckm/scgA1oaImTJIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTA4IGF0IDEzOjU2IC0wNzAwLCBncmVlYXJiQGNhbmRlbGF0ZWNoLmNv
bSB3cm90ZToKPiBGcm9tOiBCZW4gR3JlZWFyIDxncmVlYXJiQGNhbmRlbGF0ZWNoLmNvbT4KPiAK
PiBEZWJ1Z2dpbmcgaW5kaWNhdGVzIHRoYXQgbm90aGluZyBlbHNlIGlzIGNsZWFyaW5nIHRoZSBp
bmZvLT5mbGFncywKPiBzbyBzb21lIGZyYW1lcyB3ZXJlIGZsYWdnZWQgYXMgQUNLZWQgd2hlbiB0
aGV5IHNob3VsZCBub3QgYmUuCj4gRXhwbGljaXRseSBjbGVhciB0aGUgYWNrIGZsYWcgdG8gZW5z
dXJlIHRoaXMgZG9lcyBub3QgaGFwcGVuLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEJlbiBHcmVlYXIg
PGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPgo+IC0tLQo+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vdHguYyB8IDMgKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbXZtL3R4LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90
eC5jCj4gaW5kZXggMGFiYzMxYTY5NTFkLi42N2YyMDhjYzE5YzggMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdHguYwo+ICsrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3R4LmMKPiBAQCAtMTg2Myw2ICsxODYzLDcg
QEAgc3RhdGljIHZvaWQgaXdsX212bV9yeF90eF9jbWRfc2luZ2xlKHN0cnVjdCBpd2xfbXZtICpt
dm0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpd2xfdHJhbnNfZnJlZV90eF9j
bWQobXZtLT50cmFucywgaW5mby0+ZHJpdmVyX2RhdGFbMV0pOwo+IMKgCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBtZW1zZXQoJmluZm8tPnN0YXR1cywgMCwgc2l6ZW9mKGluZm8t
PnN0YXR1cykpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbmZvLT5mbGFncyAm
PSB+KElFRUU4MDIxMV9UWF9TVEFUX0FDSyB8IElFRUU4MDIxMV9UWF9TVEFUX1RYX0ZJTFRFUkVE
KTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogaW5mb3JtIG1hYzgw
MjExIGFib3V0IHdoYXQgaGFwcGVuZWQgd2l0aCB0aGUgZnJhbWUgKi8KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAoc3RhdHVzICYgVFhfU1RBVFVTX01TSykgewo+IEBA
IC0yMjQxLDYgKzIyNDIsOCBAQCBzdGF0aWMgdm9pZCBpd2xfbXZtX3R4X3JlY2xhaW0oc3RydWN0
IGl3bF9tdm0gKm12bSwgaW50IHN0YV9pZCwgaW50IHRpZCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqLwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFp
c19mbHVzaCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpbmZvLT5mbGFncyB8PSBJRUVFODAyMTFfVFhfU1RBVF9BQ0s7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGVsc2UKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGluZm8tPmZsYWdzICY9IH5JRUVFODAyMTFfVFhfU1RBVF9BQ0s7Cj4gwqDC
oMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKgpBY2tlZC1ieTogR3JlZ29y
eSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVlbm1hbkBpbnRlbC5jb20+Cg==
