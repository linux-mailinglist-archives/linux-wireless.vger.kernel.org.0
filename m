Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D8A66211B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjAIJMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 04:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbjAIJLv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 04:11:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5731517E3C
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 01:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673255296; x=1704791296;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=I3j7qo/jSNki8nbOVNcp4AyIxAm/btnqE8AlEFPrJdQ=;
  b=U1/96mvoP/q7bcJwcq1buaEa5+x0f0oJ1cQfgeMS6EDh5ztUExLeJ78s
   q/l8moei4bpwpZkMN9PT3xrPc2szurWbciwZ/3MAc2qTBEv8hAKozReEC
   6BXXssJ9ubxOr46UpIQz2fMn/ucbZvPBifJoBZE1u86Kn/ZvQY0vHY8Jx
   i/jR2p7mUbNcdDo9iH03ZesMaQ9P5X/O8smx5w6QumjxvBhEkRevUhifK
   o/AgGrWgTTmb/Wao7WzEOawGPPI/0ZmOq8V8YPNBzU01iT8gmjoHSwm52
   2JobNYXPd2Wj77YDsB/q2qq6GL78zLiQ20b7WZLsnys8YLu6x9o0TWp+g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="310621683"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="310621683"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 01:08:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="688978677"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="688978677"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2023 01:08:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 01:08:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 01:08:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 01:08:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUsiO3+Khw4azRJo5xMr7p67X3JxAhuTQpvYC9lGqXua+2QH3I8SXPC7k8xylOdBz7wif6IWFuNvA+f5Qvn4w6cT3dUk4xJW9Br2/aaQHoT+2jG1I1KseZpgbpnZRnvP+TADjmoBtKITYv26AV+MG69bmJdXR/FFj2jwlMip5sTS1SaeZkrHLmVzdXm6YMCwpTwcwbT9iminJrDNTj1Sk0mPMsic50BddcBd92LCweDzTslPVyDhJTEXqqmiAhyn0zRNJduZi72EhEdMfyVrJbCDSvOM8rvdkxPi9BCR5ympOHOVkgWhXpCLRRKP/9hUQZe/rC61eWYVb29eHEBi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3j7qo/jSNki8nbOVNcp4AyIxAm/btnqE8AlEFPrJdQ=;
 b=T8MGgxhh/56Bxi9t7R1YL7vHCgmWTXFC7gsJO7Sm9MHGyLd6Hl2WrMv1DsNghxffTTlIk/gy1VuUUNUry6lxUzeR1sz9bM0z7+T9gcsORJ9Dlho3KXyxA9zJIC4qm14XoJ8y0u6YhvSvWdGnL47Eg+OXTMUfM7sbrs6DpNwpKtr/xpYhmx/+Nl4Iy6pRdAMvvMxIHWp6/GBHgRecX6Bl1HEXlbhqVdCBD2nQZnHHP09Masuky+q7h5x6OOPDVcYVXJqy8nMH/fvCGyxkcXXSqlDcDoiGnnWErZhjt5bShtx6A1KWiomZUm7cd9E9EQd+3FSswEXyOoKTb1aEVCLmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 09:08:09 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 09:08:09 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "anthony@durity.me" <anthony@durity.me>
Subject: Re: iwlwifi kernel crash on PC Specialist LTD `NH5xAx`
Thread-Topic: iwlwifi kernel crash on PC Specialist LTD `NH5xAx`
Thread-Index: AQHZIx7zcnla2U//lkimBFHk+lQ9Ha6VzYkA
Date:   Mon, 9 Jan 2023 09:08:09 +0000
Message-ID: <0e1c0ced80f1ef856d19c8cc7579c31943e27893.camel@intel.com>
References: <CAJc6SnfTSuzXTVhrKh7XY8TA2pScA3NEy7cn3y9vN_0uw2aLZA@mail.gmail.com>
In-Reply-To: <CAJc6SnfTSuzXTVhrKh7XY8TA2pScA3NEy7cn3y9vN_0uw2aLZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SJ0PR11MB5772:EE_
x-ms-office365-filtering-correlation-id: 6725bc29-dd99-4909-57b0-08daf2210737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qny7NtrrXvrieAmtnSn/ff0c4SgXB2FcVsraXMenlCGV7Rn3BBtIaOSRKaX8w2tteWwwnKi1OjFvfHO8a2D2PMsL4fO5HiZ5cvlkcCMCC/h9SLmFmZqCwew1l6rdeXORCdP3Fl0+Al7hG6Xz9zKYz1/igJJm0NPTG+qeqKDhQ8yPtWM2/6O1WoNR7EQaseUrGogsR6mr7HD5rxQHrihJkDZ2+rwKLBAlz2hZm+1miVJMUYmaorC3CuWIbiMsA3D7caDIEVJrogBma+UUvKzID1EdnFc/ceWJ3749fE/XazYZZP9/hvHNoVkBoh+CuKquyOKACNZeiBVKxoT9j2BIjTj2TZ6sy5Xn7tXf5veArriRSiuyvL50zFMrbRsH3mY9f/x7CvV1lqMkp9AsJAzMTdxLdRpjyKdnGxqPU+vOoQQCBqpVrHtiMOps+Po46mo0HcFx4GI3KxZx08/didUqp5Ur6Vo4FEyJ6mYdF0IPpUxIkLCVo8Geep9PU6pHbn/4+WaJobDZ4wzOD0MgQ/mxQlmP9m0n6QJmBGAoJi2XYHqgzeeWOf/W2+aXt+JMLcNia1EoifCfc49n0m4nvrNVTTNCyITMAupDnh17q7RRMgOg36mYzfl7eoZAEczOC5buFYpetiaDarAyknOOTRpZByhZpWvy9wTOqH6Aq5ft+wlHEwGxjN2+1wa+5zckvkXaI/HoJjmVBy98tynXJGsae1N+0yjXbmSWBrCVRfOemaw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(6506007)(6512007)(186003)(2616005)(82960400001)(110136005)(76116006)(86362001)(66446008)(66556008)(66946007)(66476007)(8676002)(91956017)(38070700005)(38100700002)(5660300002)(64756008)(122000001)(478600001)(36756003)(8936002)(2906002)(26005)(71200400001)(316002)(41300700001)(45080400002)(83380400001)(6486002)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHRFdDJPaFY2YmovcVo2YXkva241Y2xqZ2UrdURMek1rZktYY1FnNGhtZ0pm?=
 =?utf-8?B?UmFkZkRBcS9HNXFYNk41RUR3VXlDdm9UclNBVlk0OEJTb2xYNU1Fb1R5TVRv?=
 =?utf-8?B?V1pnYVpxM0h6NUpodkxGOW54Yis2YlBLTEh2YkYzVjJzQWkvUEdLNzlzTHU0?=
 =?utf-8?B?SGordTF3T01GZDZQVE1pL083MzQrRnI1RGlYdzNXYmF4QUFCbUV6cnkrRVAv?=
 =?utf-8?B?azZ4VW9nYkFvYUx3U0R5VDVqMWtKWW5TZndUUDR4VW1SaGtiQ1NTRVhXeWxx?=
 =?utf-8?B?c1FWNXAzMEM3NjlDVXpUVGZRRllIN2tPYzN3RXdXaUo1TDlla3QrdmJPSEtz?=
 =?utf-8?B?Z0NXKzBQT1g3dWJtQ2tjY2hMSktLSGNpVHFhQzJKNTYrSVQ2ekFnanl4MVQ1?=
 =?utf-8?B?OGl4Zmh4UHR5QmtkM2lXTVU4K3pUTkt2c3lHNWdVL2JUaEorT0ppMVVPdzlM?=
 =?utf-8?B?RklBcUI3S3oyaHRXT2RRcHVYalM4YWJhTzhOL000TG9jQmd4bXUzN3pUSDVz?=
 =?utf-8?B?RCtYNUdnUjROSEJ0VTM0anBiZnJxZk81cTNiY1h0aXhxemROKzFiRnJkSzNT?=
 =?utf-8?B?TjhGSVFzeHo4cnZwN3hTNVNIUUZ1SmpFTmhOUUw2MGNoVGxDZlNuT1dzSW1z?=
 =?utf-8?B?S3UvZi9Yd0JGTmt3TjBzbGFLR05RRHlYZldpZk1GQnppcndFVHFuVHpCaWwz?=
 =?utf-8?B?M1ROY09QY0swOXNZS1NmWXlMbWp0Nm41Qk9YR3BDclk4Q1hXM2pxNzEwUmFZ?=
 =?utf-8?B?WDE1QVpPd3FBM2RyVzdFcmFaYkVQaUozZDlaYkI1dklaNS8ycmJ6OEpDb2l5?=
 =?utf-8?B?YXBBMjNNWTBKT0N4d3ExdXA0MjMyZFBXMnRsL1kyN2xqN2F2SHprY1JJVjc3?=
 =?utf-8?B?VlJJYno2RmpqQ0c4eHRQNVNzbWVPemFxbU1oc2NzdFVoenBiRVBoL3BDRU9j?=
 =?utf-8?B?RmQxbDNUYWxoNzRKazhWOGd1SXBZdXNFNW1POWJmM2JQazh5UGRkQTlEWklt?=
 =?utf-8?B?VkUrZWY2M3VPcVBSRTdqRzFOVUttRUsvdHdxWU9MZlM0NmttUHNUSG5yRVMy?=
 =?utf-8?B?anBJYzNWRGpqNUEwR3l6cy8vai9DeGxvS2tNdU9oTGsyM0N2VXIrMDFSdmN2?=
 =?utf-8?B?cWptQm5xSjJud081ZzlRN3oyei9KOGpHZHpOQ0xNNFE1VUtQa3VPTUIrUWpi?=
 =?utf-8?B?TEVNZEJleWE5M2EwR09zdm51NitIR1ZZdHJXSFdSbU5yUXlVRDQ0RFV6Y3Yw?=
 =?utf-8?B?TnNhVGlYeHpCdUViUWxZazY5NzNKQlhIYVR5TE5ZWDZrN29OVEZEekVicWJV?=
 =?utf-8?B?eCtYYVJxUjc3a3hqcHIzYmlPTFJOYm95aURhK1NOK2gwcTV6Q1dFR2MxTWdt?=
 =?utf-8?B?alN3YUJRbFIxNkVWWTZZeVlISXdzV04zQUdLUzlPRDRVTXo2YzlNekVDUEp4?=
 =?utf-8?B?Y3ZaYi9JdkZaSzNGd3RaZVF4M1NSQ3JLR3JEMWxqdzlSZWRRNzkzNWtmK2NE?=
 =?utf-8?B?dlQxMmk5N3RKL1NjVnd2enpnRTlqcmxLUHNMOG03c0xOOW53djc3NzdYZTJY?=
 =?utf-8?B?bzd0TnVUY2ZsdlVBRE1xaWpCR3I2WHlsL3I2UkRqTEw0d3Z3Z1ZMMDZRTkx3?=
 =?utf-8?B?bi9XclpSUXdBQ3hORGV1M3dieHRJenV4bWx6RmlwUitKUnN3VUxId1FEVGcv?=
 =?utf-8?B?WDdIenQ4UlFFVVdiV0w3UUwzU0xkQmdGbWMva21NSnU4aWhEV0N3Um1ZUDYy?=
 =?utf-8?B?U1R2WkpvcEtLQ3RKdHdTOWs2Q29kZWcrTERqNWdTYkpuQUhRQnRnS0V1NFhL?=
 =?utf-8?B?YWtrenNNYVdXUHk2V2FJazAyQ2xCbmdXYnpPVTJXY0E1K0gvd1BYdFI2ZzBx?=
 =?utf-8?B?WU15YUx6MW83VHN1ekN4SUNkZlhUMUtTeFhsaFdqdVJKcytFL1B0NE9wckt4?=
 =?utf-8?B?TEZTaDFKQk15cEZBREtwbGlIMjVzbm5BK1BxT05Db1Z5ZkxHQ1BpQ1VQV2Vh?=
 =?utf-8?B?NktnMDlRam0yYXRNUzFDcUlPOElWeFFveTVzb0kwOHZrUEgrdUpXdG0zcFds?=
 =?utf-8?B?Qk00MGU5akthMytDQUxyOUVJdnNXNUJxb1Z0UlU1REthcS9Ydktvc3BZRURP?=
 =?utf-8?B?d0F6OWtydFFSdFpoS1VkdzJHUjFBM1c2Z0xiK3lYa3o3bTRhMjdjM24rK2U5?=
 =?utf-8?Q?YcAQcT/gJmhHCThZJbh5AUg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E52612A151BAEF4D9A19C49F84912D66@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6725bc29-dd99-4909-57b0-08daf2210737
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 09:08:09.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPzodjq3MeFrpAYCV9VqJaP6didtad8k/xp6DV9uqurL8qOJWEfv6UhicfTFKIVL1JYdYlQ6Tv9VLc3GdsHLCBt/vXgCNi4YRW/IHT51wCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
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

T24gU3VuLCAyMDIzLTAxLTA4IGF0IDA1OjA1ICswMDAwLCBBbnRob255IER1cml0eSB3cm90ZToN
Cj4gSGkgdGhlcmUsDQo+IA0KPiBEb24ndCBrbm93IGlmIHRoaXMgaXMgdGhlIGNvcnJlY3QgcGxh
Y2UgdG8gcG9zdCB0aGlzLg0KPiANCj4gW8KgwqDCoCA2Ljk1ODYzNF0gLS0tLS0tLS0tLS0tWyBj
dXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+IFvCoMKgwqAgNi45NTg2MzVdIFdBUk5JTkc6IENQVTog
MTIgUElEOiA5NjEgYXQNCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wt
bnZtLXBhcnNlLmM6NzExDQo+IGl3bF9pbml0X2hlX2h3X2NhcGFiKzB4MzhlLzB4M2IwIFtpd2x3
aWZpXQ0KPiBbwqDCoMKgIDYuOTU4NjUxXSBNb2R1bGVzIGxpbmtlZCBpbjogc25kX2hkYV9jb2Rl
Y19yZWFsdGVrDQo+IHNuZF9oZGFfY29kZWNfZ2VuZXJpYyBsZWR0cmlnX2F1ZGlvIHNuZF9oZGFf
Y29kZWNfaGRtaSBzbmRfaGRhX2ludGVsDQo+IHNuZF9pbnRlbF9kc3BjZmcgc25kX2ludGVsX3Nk
d19hY3BpIGl3bG12bSgrKSBzbmRfaGRhX2NvZGVjDQo+IHNuZF9oZGFfY29yZSBzbmRfaHdkZXAg
aW50ZWxfcmFwbF9tc3IgbnZpZGlhX2RybShQT0UrKQ0KPiBpbnRlbF9yYXBsX2NvbW1vbiBudmlk
aWFfbW9kZXNldChQT0UpIGJpbmZtdF9taXNjIG1hYzgwMjExIHNuZF9wY20NCj4gYnR1c2IgdXZj
dmlkZW8gYnRydGwgc25kX3NlcV9taWRpIGJ0YmNtIHNuZF9zZXFfbWlkaV9ldmVudCBqb3lkZXYN
Cj4gYnRpbnRlbCB2aWRlb2J1ZjJfdm1hbGxvYyBidG10ayBlZGFjX21jZV9hbWQgdmlkZW9idWYy
X21lbW9wcyBsaWJhcmM0DQo+IHNuZF9yYXdtaWRpIHZpZGVvYnVmMl92NGwyIG52aWRpYShQT0Up
IG5sc19pc284ODU5XzEgYmx1ZXRvb3RoIGt2bV9hbWQNCj4gc25kX3NlcSB2aWRlb2J1ZjJfY29t
bW9uIGl3bHdpZmkgc25kX3NlcV9kZXZpY2UgdmlkZW9kZXYgc25kX3RpbWVyDQo+IGRybV9rbXNf
aGVscGVyIGVjZGhfZ2VuZXJpYyBrdm0gbWMgZWNjIGZiX3N5c19mb3BzIGNmZzgwMjExIHNuZA0K
PiBzeXNjb3B5YXJlYSBzeXNmaWxscmVjdCBjY3AgaW5wdXRfbGVkcyBrMTB0ZW1wIGhpZF9tdWx0
aXRvdWNoDQo+IHN5c2ltZ2JsdCByYXBsIHNvdW5kY29yZSBlZmlfcHN0b3JlIHdtaV9ibW9mIHNl
cmlvX3JhdyBteG1fd21pDQo+IGNsZXZvX3dtaShPRSkgY2xldm9fYWNwaShPRSkgdHV4ZWRvX2lv
KE9FKSB0dXhlZG9fa2V5Ym9hcmQoT0UpIG1hY19oaWQNCj4gc3BhcnNlX2tleW1hcCBzY2hfZnFf
Y29kZWwgb3ZlcmxheSBpcHRhYmxlX2ZpbHRlciBpcDZ0YWJsZV9maWx0ZXINCj4gaXA2X3RhYmxl
cyBicl9uZXRmaWx0ZXIgYnJpZGdlIHN0cCBsbGMgYXJwX3RhYmxlcyBreWJlcl9pb3NjaGVkDQo+
IGlwbWlfZGV2aW50ZiBpcG1pX21zZ2hhbmRsZXIgbXNyDQo+IFvCoMKgwqAgNi45NTg2ODZdwqAg
cGFycG9ydF9wYyBwcGRldiBscCBwYXJwb3J0IGRybSBpcF90YWJsZXMgeF90YWJsZXMNCj4gYXV0
b2ZzNCBkbV9jcnlwdCByYWlkMTAgcmFpZDQ1NiBhc3luY19yYWlkNl9yZWNvdiBhc3luY19tZW1j
cHkNCj4gYXN5bmNfcHEgYXN5bmNfeG9yIGFzeW5jX3R4IHhvciByYWlkNl9wcSBsaWJjcmMzMmMg
cmFpZDEgcmFpZDANCj4gbXVsdGlwYXRoIGxpbmVhciBzeXN0ZW03Nl9pbyhPRSkgc3lzdGVtNzZf
YWNwaShPRSkgcjgxNjkNCj4gcnRzeF9wY2lfc2RtbWMgbnZtZSBoaWRfZ2VuZXJpYyBjcmN0MTBk
aWZfcGNsbXVsIGNyYzMyX3BjbG11bA0KPiBwb2x5dmFsX2NsbXVsbmkgcG9seXZhbF9nZW5lcmlj
IGdoYXNoX2NsbXVsbmlfaW50ZWwgYWVzbmlfaW50ZWwNCj4gY3J5cHRvX3NpbWQgY3J5cHRkIHBz
bW91c2UgaTJjX3BpaXg0IGFoY2kgbnZtZV9jb3JlIHhoY2lfcGNpIHJ0c3hfcGNpDQo+IHJlYWx0
ZWsgbGliYWhjaSB4aGNpX3BjaV9yZW5lc2FzIG52bWVfY29tbW9uIGkyY19oaWRfYWNwaSB2aWRl
bw0KPiBpMmNfaGlkIGhpZCB3bWkgZ3Bpb19hbWRwdA0KPiBbwqDCoMKgIDYuOTU4NzEwXSBDUFU6
IDEyIFBJRDogOTYxIENvbW06IG1vZHByb2JlIFRhaW50ZWQ6IFDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBPRQ0KPiDCoMKgwqDCoCA2LjAuMTItNzYwNjAwMDYtZ2VuZXJpYyAjMjAyMjEyMjkwOTMyfjE2
NzE2NTI5NjV+MjIuMDR+NDUyZWE5ZA0KPiBbwqDCoMKgIDYuOTU4NzEyXSBIYXJkd2FyZSBuYW1l
OiBQQyBTcGVjaWFsaXN0IExURCBOSDV4QXgNCj4gwqDCoMKgwqDCoMKgwqDCoCAvTkg1eEF4LCBC
SU9TIDEuMDcuMDdUUENTIDA2LzAzLzIwMjANCj4gW8KgwqDCoCA2Ljk1ODcxNF0gUklQOiAwMDEw
Oml3bF9pbml0X2hlX2h3X2NhcGFiKzB4MzhlLzB4M2IwIFtpd2x3aWZpXQ0KPiBbwqDCoMKgIDYu
OTU4NzI1XSBDb2RlOiBmZSBmZiBmZiA4MSBlOSAxMCAwMSAwMCAwMCA4MyBmOSAwMSAwZiA4NiA2
MCBmZQ0KPiBmZiBmZiBlOSA2NSBmZSBmZiBmZiA0OCA4ZCA4NiBhMCAwMiAwMCAwMCBlOSAxNCBm
ZCBmZiBmZiAwZiAwYiBlOSBjYQ0KPiBmYyBmZiBmZiA8MGY+IDBiIGU5IGUxIGZlIGZmIGZmIDBm
IDBiIGU5IDA4IGZmIGZmIGZmIGU4IDlmIDAyIGM0IGRjIDY2DQo+IDY2IDJlDQo+IFvCoMKgwqAg
Ni45NTg3MjZdIFJTUDogMDAxODpmZmZmYTIyYTBjMTBmOTI4IEVGTEFHUzogMDAwMTAyNDYNCj4g
W8KgwqDCoCA2Ljk1ODcyOF0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjkyMzU0YmYz
NDE2OCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANCj4gW8KgwqDCoCA2Ljk1ODcyOV0gUkRYOiAwMDAw
MDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IDAwMDAwMDAwMDAwMDAwMDAN
Cj4gW8KgwqDCoCA2Ljk1ODczMF0gUkJQOiBmZmZmYTIyYTBjMTBmOTg4IFIwODogMDAwMDAwMDAw
MDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDANCj4gW8KgwqDCoCA2Ljk1ODczMV0gUjEwOiAw
MDAwMDAwMDAwMDAwMDAzIFIxMTogMDAwMDAwMDAwMDAwMDAwMyBSMTI6IGZmZmY5MjM1NGMxMDAw
MjgNCj4gW8KgwqDCoCA2Ljk1ODczMl0gUjEzOiBmZmZmOTIzNTRiZjM0MDAwIFIxNDogMDAwMDAw
MDAwMDAwMDAwMyBSMTU6IDAwMDAwMDAwMDAwMDAwMDMNCj4gW8KgwqDCoCA2Ljk1ODczM10gRlM6
wqAgMDAwMDdmMzk0YTYxY2M0MCgwMDAwKSBHUzpmZmZmOTIzYzNlOTAwMDAwKDAwMDApDQo+IGtu
bEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gW8KgwqDCoCA2Ljk1ODczNF0gQ1M6wqAgMDAxMCBEUzog
MDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gW8KgwqDCoCA2Ljk1ODczNV0g
Q1IyOiAwMDAwN2YxNWNkZGNjNWIwIENSMzogMDAwMDAwMDExOTgwODAwMCBDUjQ6IDAwMDAwMDAw
MDAzNTBlZTANCj4gW8KgwqDCoCA2Ljk1ODczNl0gQ2FsbCBUcmFjZToNCj4gW8KgwqDCoCA2Ljk1
ODczN13CoCA8VEFTSz4NCj4gW8KgwqDCoCA2Ljk1ODc0MF3CoCBpd2xfaW5pdF9zYmFuZHMrMHgy
NjUvMHgyZDAgW2l3bHdpZmldDQo+IFvCoMKgwqAgNi45NTg3NTFdwqAgaXdsX2dldF9udm0rMHgy
NDUvMHgyZTAgW2l3bHdpZmldDQo+IFvCoMKgwqAgNi45NTg3NjNdwqAgaXdsX3J1bl91bmlmaWVk
X212bV91Y29kZSsweDIwOS8weDI1MCBbaXdsbXZtXQ0KPiBbwqDCoMKgIDYuOTU4Nzc4XcKgID8g
aXdsX3J1bl91bmlmaWVkX212bV91Y29kZSsweDIwOS8weDI1MCBbaXdsbXZtXQ0KPiBbwqDCoMKg
IDYuOTU4Nzg5XcKgID8gaXdsX3JlYWQzMisweDI0LzB4OTAgW2l3bHdpZmldDQo+IFvCoMKgwqAg
Ni45NTg4MDBdwqAgPyAweGZmZmZmZmZmYzEyYWMwMDANCj4gW8KgwqDCoCA2Ljk1ODgwM13CoCBp
d2xfcnVuX2luaXRfbXZtX3Vjb2RlKzB4MjkvMHg0MCBbaXdsbXZtXQ0KPiBbwqDCoMKgIDYuOTU4
ODEzXcKgIGl3bF9tdm1fc3RhcnRfZ2V0X252bSsweGFkLzB4MjgwIFtpd2xtdm1dDQo+IFvCoMKg
wqAgNi45NTg4MjZdwqAgaXdsX29wX21vZGVfbXZtX3N0YXJ0KzB4N2U0LzB4YTUwIFtpd2xtdm1d
DQo+IFvCoMKgwqAgNi45NTg4MzhdwqAgX2l3bF9vcF9tb2RlX3N0YXJ0KzB4NzgvMHhlMCBbaXds
d2lmaV0NCj4gW8KgwqDCoCA2Ljk1ODg1MF3CoCBpd2xfb3Btb2RlX3JlZ2lzdGVyKzB4NmQvMHhm
MCBbaXdsd2lmaV0NCj4gW8KgwqDCoCA2Ljk1ODg2MV3CoCA/IDB4ZmZmZmZmZmZjMTM0MzAwMA0K
PiBbwqDCoMKgIDYuOTU4ODYyXcKgIGl3bF9tdm1faW5pdCsweDNhLzB4MTAwMCBbaXdsbXZtXQ0K
PiBbwqDCoMKgIDYuOTU4ODc2XcKgID8gMHhmZmZmZmZmZmMxMzQzMDAwDQo+IFvCoMKgwqAgNi45
NTg4NzddwqAgZG9fb25lX2luaXRjYWxsKzB4NDkvMHgyMjANCj4gW8KgwqDCoCA2Ljk1ODg4MF3C
oCA/IGttZW1fY2FjaGVfYWxsb2NfdHJhY2UrMHgxNjAvMHgzMzANCj4gW8KgwqDCoCA2Ljk1ODg4
M13CoCBkb19pbml0X21vZHVsZSsweDUyLzB4MjIwDQo+IFvCoMKgwqAgNi45NTg4ODZdwqAgbG9h
ZF9tb2R1bGUrMHhhYzEvMHhjODANCj4gW8KgwqDCoCA2Ljk1ODg4N13CoCA/IHNlY3VyaXR5X2tl
cm5lbF9wb3N0X3JlYWRfZmlsZSsweDVjLzB4ODANCj4gW8KgwqDCoCA2Ljk1ODg5MV3CoCA/IGtl
cm5lbF9yZWFkX2ZpbGUrMHgyNWMvMHgyYjANCj4gW8KgwqDCoCA2Ljk1ODg5M13CoCBfX2RvX3N5
c19maW5pdF9tb2R1bGUrMHhjYy8weDE1MA0KPiBbwqDCoMKgIDYuOTU4ODk1XcKgID8gX19kb19z
eXNfZmluaXRfbW9kdWxlKzB4Y2MvMHgxNTANCj4gW8KgwqDCoCA2Ljk1ODg5OF3CoCBfX3g2NF9z
eXNfZmluaXRfbW9kdWxlKzB4MTgvMHgzMA0KPiBbwqDCoMKgIDYuOTU4ODk5XcKgIGRvX3N5c2Nh
bGxfNjQrMHg1Yy8weDkwDQo+IFvCoMKgwqAgNi45NTg5MDJdwqAgPyBleGl0X3RvX3VzZXJfbW9k
ZV9wcmVwYXJlKzB4YWYvMHhkMA0KPiBbwqDCoMKgIDYuOTU4OTA0XcKgID8gc3lzY2FsbF9leGl0
X3RvX3VzZXJfbW9kZSsweDJhLzB4NTANCj4gW8KgwqDCoCA2Ljk1ODkwNV3CoCA/IGRvX3N5c2Nh
bGxfNjQrMHg2OS8weDkwDQo+IFvCoMKgwqAgNi45NTg5MDddwqAgPyBzeXNjYWxsX2V4aXRfdG9f
dXNlcl9tb2RlKzB4MmEvMHg1MA0KPiBbwqDCoMKgIDYuOTU4OTA4XcKgID8gZG9fc3lzY2FsbF82
NCsweDY5LzB4OTANCj4gW8KgwqDCoCA2Ljk1ODkxMF3CoCBlbnRyeV9TWVNDQUxMXzY0X2FmdGVy
X2h3ZnJhbWUrMHg2My8weGNkDQo+IFvCoMKgwqAgNi45NTg5MTJdIFJJUDogMDAzMzoweDdmMzk0
OWQxZWEzZA0KPiBbwqDCoMKgIDYuOTU4OTEzXSBDb2RlOiA1YiA0MSA1YyBjMyA2NiAwZiAxZiA4
NCAwMCAwMCAwMCAwMCAwMCBmMyAwZiAxZQ0KPiBmYSA0OCA4OSBmOCA0OCA4OSBmNyA0OCA4OSBk
NiA0OCA4OSBjYSA0ZCA4OSBjMiA0ZCA4OSBjOCA0YyA4YiA0YyAyNA0KPiAwOCAwZiAwNSA8NDg+
IDNkIDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IDhiIDBkIGMzIGEzIDBmIDAwIGY3IGQ4IDY0IDg5
DQo+IDAxIDQ4DQo+IFvCoMKgwqAgNi45NTg5MTRdIFJTUDogMDAyYjowMDAwN2ZmZjE3Yjg4ODQ4
IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6DQo+IDAwMDAwMDAwMDAwMDAxMzkNCj4gW8KgwqDC
oCA2Ljk1ODkxNl0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDU1ZGE1ZWM0ZjE1MCBS
Q1g6IDAwMDA3ZjM5NDlkMWVhM2QNCj4gW8KgwqDCoCA2Ljk1ODkxN10gUkRYOiAwMDAwMDAwMDAw
MDAwMDAwIFJTSTogMDAwMDU1ZGE1Y2Q0ZmNkMiBSREk6IDAwMDAwMDAwMDAwMDAwMDINCj4gW8Kg
wqDCoCA2Ljk1ODkxOF0gUkJQOiAwMDAwMDAwMDAwMDQwMDAwIFIwODogMDAwMDAwMDAwMDAwMDAw
MCBSMDk6IDAwMDAwMDAwMDAwMDAwMDINCj4gW8KgwqDCoCA2Ljk1ODkxOF0gUjEwOiAwMDAwMDAw
MDAwMDAwMDAyIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDA1NWRhNWNkNGZjZDINCj4g
W8KgwqDCoCA2Ljk1ODkxOV0gUjEzOiAwMDAwNTVkYTVlYzRlM2EwIFIxNDogMDAwMDU1ZGE1ZWM0
ZTczMCBSMTU6IDAwMDA1NWRhNWVjNWM3YjANCj4gW8KgwqDCoCA2Ljk1ODkyMV3CoCA8L1RBU0s+
DQo+IFvCoMKgwqAgNi45NTg5MjJdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0t
DQo+IA0KPiBIb3BlIHRoaXMgaGVscHMgc29tZW9uZSwNCj4gwqDCoMKgIEFudGhvbnkNCg0KVGhh
bmtzIGZvciB0aGUgcmVwb3J0IQ0KQ2FuIHlvdSBwbGVhc2UgdGVsbCB3aGF0IGtlcm5lbCB2ZXJz
aW9uIGRvIHlvdSBoYXZlPw0KDQo=
