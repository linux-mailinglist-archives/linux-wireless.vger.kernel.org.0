Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF19148C76F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 16:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354723AbiALPmm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 10:42:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:26082 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243806AbiALPmf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 10:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642002155; x=1673538155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dRsacpLG3PefvRCgKp0PhFjW896QP0Fm9jprDaIzqOM=;
  b=TiV4fsgEvyVNAHR3z8fAxI4MSdTe1OC8GP8V57AybjfQQGgwKjvUiF+f
   JMFbOrrMiZ0kvx2gIwbxxEcUk73iM+l0raRhyv7GDb0aXuY+g9GLj1Lim
   C2IQ+/yTIEl004tW/Ft6J5STANbw1k8/bvSCnWC9m0m29hbx5UuH0JZu1
   LRAbi4nF5VyAKrlb5dT4HokBA8vUqC/O20XQsNtJucKLL/FO2rb3u99Y9
   7guUePuLDdWvSp75axH7yq7X/uggIiXq1Fm/SDAdkhrwLFeHPZqBPF0xn
   g7lKbr9Vp7cLhCCXa2HEI4kIeMhdRiiXfhek6ItL/OKLOary4WhzXBZYW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="304498933"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="304498933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 07:42:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="613605931"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2022 07:42:35 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 07:42:34 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 07:42:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 12 Jan 2022 07:42:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 12 Jan 2022 07:42:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fup2fABxgc3d8aXySmYf9XBhiVHyUK9XoEDtruUcw4soG3wX9iSuIkQ7FtG93DFeRItSMbMMYezynWsS2wMuPNaXxK2eJ6GH+5nQ/rLIoYp4J0r3w0Eh97m41ayVRpNutqDsY16UWsmFoQnOOD4tHsGCzLAgXL+WMGMGzaE3CPVBmTKrwVI0PgnxKdD5FOne7o52Yy31P7yki9UWkNhMoMWR7C3Xjtb/fmGGaQa0sliPYVZx15iQxaX9i3vYezsykLJgGBBgNDjHWHluCbbKV57mR42WEEpRa9njl2equuS6swh67Ffj3v59v1pb7tZt8kIL1qi3bXLjbakXhangqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRsacpLG3PefvRCgKp0PhFjW896QP0Fm9jprDaIzqOM=;
 b=hWBeqUgPtGkLp3lU4wcL0IvjzZwBynIBIH8QQxbYl22lI7Jzd5VXHm0NRWwBjD086MX+gSCrJs3uTwtao334dbyZ24K8ZBGuvuTkGC+Zttg6xlUsSYRd1qafT3VZ9zz5wAbJMOCvNOcvQyJz/V5otIqXfsqd9zApwwTXpBrOwV0SpAYEeIcakx17BaiRaPH86EGMhm2o5axAh6B5LdS6QcxSfpTNgRCNtqhO4iORRTLBSj9bstx7jrVW7rIemCce7AN4kXgyw+pqIo3WUa6MT6vTqyyxP4tRCB1ildzTZSKeIZJa8dZGJEuBHCp6F0j7KpcyHhsFUOkWt5+631r6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 15:42:33 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::1459:60ef:a660:5fec%4]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 15:42:33 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Topic: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting
 0x2000000.
Thread-Index: AQHYB1Z1kfzr/0Efz0WQ7sMSiyR//KxfD8iAgAAIsQCAAGK1gIAADCsA
Date:   Wed, 12 Jan 2022 15:42:33 +0000
Message-ID: <f917dd2fca4f4f1227d5848681ec88cdd235d4ad.camel@intel.com>
References: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
         <0bb2a3b794c19514ad30ecc0ca60d1d6e9e438b0.camel@sipsolutions.net>
         <4c1089474bb5982aee82d58a9d300ca55e7e0c69.camel@intel.com>
         <CAJvTdKmXuzwhV+ExqPAAUTgOFk1dnU+CjnErgUgdfXp=vug_EQ@mail.gmail.com>
In-Reply-To: <CAJvTdKmXuzwhV+ExqPAAUTgOFk1dnU+CjnErgUgdfXp=vug_EQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12265342-3edf-4111-2bd9-08d9d5e2265f
x-ms-traffictypediagnostic: SJ0PR11MB4927:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB4927CD8FB40213EBA3C4347190529@SJ0PR11MB4927.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l04DuR83hP5O7pABsvR6A8xB1JGshT/HR/QCfBn2TnkfPpW8pqIFfz4xBY3MxfX76nWPzJs/8nNxYFtZ8ZURh1x+d6Db8FJ6nvn+bfQWhTR2SqZ5I7e+Aab9mIHFenh1QpxgCkXIEoaKZqm08XfvaFDWh5AjMyCtQd9oknFrHuPghZtY7yGMxcgVgqIlil8Ti4ceablDrjxzw+oYWUG4e60xkhMCBD+AB0XUW5k4FWilEiqhZWykwjg2DyZUi846L50jPPRK3CD7e3njCSyZKdzPjlmpBRRVF4vSMiiDINFvRpPFNZvEOHE/Q9LZfyhci8LvZFcF12V9bUTEQKMZ8a5zgD7HvzadRNiWhQ92Tfk/s8K0w21TRo/jGQk/bzqOLVzpLqrP+Jaolg1uhf1Mi0FHkkulgKkQ7dFQAm+VQL70kVNC5AipvfxpYJmhdJCE5jM/tmcQ0Hy+2oxVDii3Dw859PHhsts50fF25UDpYYl2C+mQ85ELTiDJQofM2LbVHwgA++mIar00bSncuQ8SL64aOuN3VDl9vBryS+ub+IpUUAAxlZQVO6ntQopCyJRDUpc+sR5aNiY9VEnn7s4y9q9Gf8trT9VwCsTiFe22ig+/Vwqny6jmWGuxgTdRSYLFXxwk3QzP9Txe5xPC+xvA7wqOcTAS0Vb+evUNONMawpWMumn7c+CdsILM+lMMm5tg3TH9JcwEZ87ZWSznkwBfVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(54906003)(6916009)(76116006)(26005)(91956017)(53546011)(6506007)(8676002)(186003)(6512007)(5660300002)(71200400001)(4326008)(2616005)(122000001)(508600001)(8936002)(4744005)(38100700002)(82960400001)(86362001)(316002)(66446008)(38070700005)(66946007)(66476007)(6486002)(66556008)(64756008)(83380400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmRRNXBNMVR3OWxUb255UzBjbUJYS0xFaVlwYW5wN21CMEo5SDZNYzlNUURj?=
 =?utf-8?B?YzVTVjJ2L05ycWROM0hyMFRyb1dtT1lsMEozUVNYSENaNVJoUDVUbi9EM3Bx?=
 =?utf-8?B?L09HNGJnQloxekMxcnBYcENscVFxMXQvVU5KVkJjdDJTc09lNEdvYWQ3QUlk?=
 =?utf-8?B?NUgzVVpNR2xlOXNsTTdZL09GL04wN2pxbUdDSCsrUTU3ajUrenhKOGRKWUhJ?=
 =?utf-8?B?OUkzdE9HME1GUFJKWmdZOU5qcXNZRENxejVwWDJUUnJ3QjA1S0RzUm9CN2FK?=
 =?utf-8?B?UXU0WHJEbmpoQ0VlMG4wbVNmZVB0SCtXYVpFVDJPb2lHSFhvMmtsbzlJd25o?=
 =?utf-8?B?NEJsNDRxMlcwTngxb2tvUUh0RzFxR1JITGhNWXdsaXpFZkREV0U3RU43U1NT?=
 =?utf-8?B?aFg1cGFMMnRWd3QrZ21IYUdmUUZlS3JhS2tpV2kwOTRTaHpmbktkMEVkOTZx?=
 =?utf-8?B?NVY3SW40ZXIvYmVKWVJ4YkFWa3dMbWU0VVVEbS9uMU4yUC9lTnV5TUtuWElm?=
 =?utf-8?B?UDBwRnIzZ2lLekdVMHNmSmt2QVhDNGF1UlBLd0hUM0lEc0h0dUJGa0JobUJN?=
 =?utf-8?B?MUdUOXBTOEFVMlh3TnN0NE1MczBDdW9GOWdWVHl1SHJOZ3d3UjdrM1ljNWJZ?=
 =?utf-8?B?Q3ZuRHZvOUt3ZFBSU1F5WDlYeitObkdnanJwNEIySmpQWncyNXQxd05PMEtE?=
 =?utf-8?B?QmluUzRPbzc2d1lzR3BQem9wVkZDVG5SY1VRcWEzQW1WWDlsellKMUVwZ0Jx?=
 =?utf-8?B?OHZSekhCTGZVZkRNTHVuM3lFSEV4Z2tld2JBQ0ZscTh6QlRUTVNSYnlaM0lH?=
 =?utf-8?B?ck1RSjByUFh3SmFBeitOclYrUEdyTXFXRWlhMkQ4ZVd2QTMwcU9oNk9URWpK?=
 =?utf-8?B?QlNzcjRhSFpBcHRPVGhMVDR3MEtyOEgySzA0RWRNMEN3cTd6c2hoMXhvdENa?=
 =?utf-8?B?QWlVQW5XdDkyN0dlQ0IyZGp2NWx4Z1lDM0lFN0VoWE1yQjVYUjRoTlR1ODcw?=
 =?utf-8?B?S2VOOTlCdFNySzIzMXlpUm56MnQxNG4xOXZVaklLbHByWjFPRDBhajVsdExH?=
 =?utf-8?B?RlRKdi9yMDBJZEdtY1JGYmExWGErVXFWTVVOdm1CQmhxMjBkZEVVaUFvOGtu?=
 =?utf-8?B?eDBTU2VjOStWR2pCMy9xOUhlOWxMT3VJR2h1RWx5VjE2R1hTenhNV3RZeFJK?=
 =?utf-8?B?TFBCU1FJTWUrdS9pK1NBWlQ3VUo4RHV0VTVWZnZDNEhwemp6ck5KelBRRGdN?=
 =?utf-8?B?dlJBbVNlVC9TWkhrZ1ZoS2o3MGxDQU83SEhJdXVmNFZXdVVua09ZT1dXYzU2?=
 =?utf-8?B?MlNTL2RpTEp6RkdIVXhvT2JkMXdPTnJQTVliNk5sSW1wbmlkU2xaa2RLZHlk?=
 =?utf-8?B?V0NqU0NCS2dRTnlObzV1aFhBalFKK2VpNHRjOHVPM1hqcWRVdEdHZWhxYllW?=
 =?utf-8?B?NDU3anRJSldUbnQwb0doSzRhMU5RTFQvZ0IxWHF5VFlnNUNYY2wrZFVYOTYv?=
 =?utf-8?B?M3d2T25XQzNrOVMwZ2hUcGZhTHpZdTFsM1BaV2xYTWhLd1VkZW1xWE5PWUNW?=
 =?utf-8?B?aFh5WlFTUlBhK0dyYmlLd0RMM0xlcEV3UDVXRm9iM1dSY2NUYlFRQWdvRktJ?=
 =?utf-8?B?bkZ5amZEeDZMblhibFdhN0xsT2d5TlpZVHNwNnA4NUJQcnFXTTYxME9jTWtW?=
 =?utf-8?B?MG01cG44bEovdmVFakk0SUluNnk1VmN3OE9weUZrNUUweVpESCtwV29xM2ta?=
 =?utf-8?B?T1VsQjBJa3ZyMHhQQXl4ZkhabEg5R3RuQnBHZFlabVBTSXJKSGxNandSMkM1?=
 =?utf-8?B?Uk1kNGdRZkJ1d05Ic0JySDRpRWNvUVNiSUpNeUNSbWtYL3lpTjVER0tJS2c0?=
 =?utf-8?B?aHBCTENhbEN4VDJOMmNIU3BiUVh5RlAwZnJ2SnZrUTdMaFI4czJzS1VNTHNh?=
 =?utf-8?B?M0ZBRWwzY1BsT1NzNmVyZ2hCM2U4QUp5QnVibCtxcWZNUy8vRXlHWVBJSHZz?=
 =?utf-8?B?cXYyR0tQV0treE9UYUxPRHFWaGEvMkxDSWZ1dUlrMFBiQlJDUVRuMVhrSFZw?=
 =?utf-8?B?alArY1U2VVVZa1BDVUxpM0t0OXVoLzhSelJuYy9aYUN2NnlSL2Jsblp0YmhO?=
 =?utf-8?B?NHlWSmtoYlUxaDNVTnErYTNXaUMxUkdpZ25RQ3pUSGZ2RVpnbk4yY0NPa0NR?=
 =?utf-8?B?c0cwQVBTZlVsdGxEQzhMb1UzTHRLaEUzYmRNVzZGMXYwNTMvd0x0dy9Rc0Ny?=
 =?utf-8?Q?A1p1T/5UVQppYWFMCeDHiQMvfi27BVK1gQPPoWjcUU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E20AAE62CB2BDE4DAD019AA5A4ADAD59@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12265342-3edf-4111-2bd9-08d9d5e2265f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 15:42:33.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHV79odIlUQXEAuN+a+2MkbBNUOwA/MW+6M1/bv2GKrJF9nCN2EwBAYqIMZmW11eL6Re5sD/Fg4akxteYUfxnz0TglL3s+QShTvjDo8ooKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTEyIGF0IDA5OjU4IC0wNTAwLCBMZW4gQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgSmFuIDEyLCAyMDIyIGF0IDQ6MDUgQU0gQ29lbGhvLCBMdWNpYW5vDQo+IDxsdWNpYW5v
LmNvZWxob0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGVyZSB3YXMgc29tZSByZWZhY3Rv
cmluZyBpbiB0aGlzIGFyZWEsIHRvIG1vdmUgdGhlIGluaXRpYWxpemF0aW9uIHRvDQo+ID4gdGhl
IGluaXQgcGhhc2UsIGFuZCB0aGF0IG11c3QgYmUgY2F1c2luZyB0aGlzLiAgSSBzdXNwZWN0IHRo
aXMgcGF0Y2g6DQo+ID4gDQo+ID4gY29tbWl0IDc4YTE5ZDUyODVkOTNlMjgxYjQwYzNiOGQ1YTk1
OWZiYmQyZmUwMDYNCj4gPiBBdXRob3I6ICAgICBNaXJpIEtvcmVuYmxpdCA8bWlyaWFtLnJhY2hl
bC5rb3JlbmJsaXRAaW50ZWwuY29tPg0KPiA+IEF1dGhvckRhdGU6IFRodSBBdWcgNSAxNDoyMTo1
NiAyMDIxICswMzAwDQo+ID4gQ29tbWl0OiAgICAgTHVjYSBDb2VsaG8gPGx1Y2lhbm8uY29lbGhv
QGludGVsLmNvbT4NCj4gPiBDb21taXREYXRlOiBUaHUgQXVnIDI2IDIzOjM2OjEwIDIwMjEgKzAz
MDANCj4gPiANCj4gPiAgICAgaXdsd2lmaTogbXZtOiBSZWFkIHRoZSBQUEFHIGFuZCBTQVIgdGFi
bGVzIGF0IElOSVQgc3RhZ2UNCj4gPiANCj4gPiAuLi53aGljaCB3YXMgaW50cm9kdWNlZCBpbiB2
NS4xNS4NCj4gDQo+IGdvb2QgZ3Vlc3MhDQo+IEkgaGF2ZSBjb25maXJtZWQgdGhhdCB1cHN0cmVh
bSA1LjE0IHdvcmtzLCBhbmQgdGhhdCA1LjE1IHdpdGggdGhlDQo+IGNvbW1pdCBhYm92ZSByZXZl
cnRlZCB3b3Jrcy4NCg0KRGlkIHlvdSBoYXZlIGEgY2hhbmNlIHRvIHRlc3QgdGhlIHBhdGNoIEkg
c2VudD8gSSdtIGFsbW9zdCBzdXJlIGl0DQp3aWxsLCBidXQgaXQgd291bGQgYmUgbmljZSB0byBn
ZXQgYSBjb25maXJtYXRpb24uIDopDQoNCi0tDQpDaGVlcnMsDQpMdWNhLg0K
