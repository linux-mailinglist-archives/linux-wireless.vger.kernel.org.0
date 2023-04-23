Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3301B6EBFA7
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Apr 2023 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDWNGx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Apr 2023 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDWNGv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Apr 2023 09:06:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B39310E2
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682255210; x=1713791210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BR0u26u642k76QrdIgCt1z7ba7OQ7CevicIfaDSlRA4=;
  b=CL+y7vtCYmuaF0kz08q1V6HdVbIuHn0ULSilLkELiXjOtFNwIj254QND
   AxoaQnO46bSOEg9+Sjxy9Z8FUp2wL9guGMeNUMZeH6uF1T7CAlRMOkFBV
   BtShzV8MkiaFJm4/M5mbpvLXJ6Pmvk86x+yP198qaV2+PIEfHXaYvr2oG
   vhuzmhvgOQQUH9g/15SiQG6QQb/sMWGUX8qQWVY9T/cCGM16EHdxuHPCG
   qTzZ52oS1CHUkDyftyevtGAmYgfOYu1OE7+VRxunDjuGt7rzRDH+lmMQN
   aQS0kjpFq7g1zFY2zXThCrPNIlZ0zJLdX6n4Oi3BtJYmzI7XupN87MZpK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="411553420"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="411553420"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 06:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="804280878"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="804280878"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2023 06:06:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 06:06:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 06:06:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 23 Apr 2023 06:06:49 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 23 Apr 2023 06:06:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwaC6cr89efjM+cKcTD3pPBhnhixEPQcKVqRZ5zK1JNakuV4CUwkh0n3bDtXEHRszFAWwpcL8OKH+zEldcFhnp9Gz98HkbdUz616d6gFnhpX07kKmssFwdBklax9rmMUwU09BR+NYEmwBcW3WV44pvoILFt1zrXWKfu0F9GCXeWhGg3b1kas1+1izVzVeOrkGVHxvo1nzbYWP3uNQKU2A1DAdoLwnNdyaS/ekjVPAe03Nu7MghVjU0qz5Adrk0ueBe7HIWqcd2Z5BxDt1u1t26JjJZIYbVWHBPSCiQS3C+WIEvikeJF8BScQvOz6Z7kITh/1uPTY3yYVMQsAXoO/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR0u26u642k76QrdIgCt1z7ba7OQ7CevicIfaDSlRA4=;
 b=gAlz4LH7Wj17MtQ+0sOGixk9tE/8pfSwiRk7Xa17ShNSNOa66vRVYA7KFJiopDdisFgLbu9P2Bm9qiemZzJitNHhhKyuJ2oep3Y1cv2rqIkrixNmzJQcBjnm6WcaGW6oZB7cQpkyx8ZZ1j+3Ml2uulb3bUPkbn5tb/IiXhEE+LPkq7+tSqAqT/OBKuc2WMTaVZDyHHKGtpzD0mS60XYr5XvNoUbsk5sBuvTrVnVnNLzdyoFJ3h0Cbsb5uLy1Fowhe1zmovrUm6sEIg+4m/YdzkGqNRtgJb0o5SYjji9hPF3NPOhPoXNEPrdp4RmbwQlAxQh3g5eBJS0l9uS+NIQ8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM4PR11MB7304.namprd11.prod.outlook.com (2603:10b6:8:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.31; Sun, 23 Apr
 2023 13:06:46 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::590:168a:7eda:e545]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::590:168a:7eda:e545%6]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 13:06:46 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "mh+debian-user-german@zugschlus.de" 
        <mh+debian-user-german@zugschlus.de>,
        "exp-311223@news.muster.net" <exp-311223@news.muster.net>,
        "tychokirchner@gmail.com" <tychokirchner@gmail.com>,
        "rene@debian.org" <rene@debian.org>,
        "Juergen.bausa@online.de" <Juergen.bausa@online.de>,
        "sebastian.suchanek@gmx.de" <sebastian.suchanek@gmx.de>
Subject: Re: iwlwifi in German ICE4 trains
Thread-Topic: iwlwifi in German ICE4 trains
Thread-Index: AQHZdcFcATtoICYsAEqtk0QLGxCu26843WQA
Date:   Sun, 23 Apr 2023 13:06:45 +0000
Message-ID: <c0153e5dd0459d351807002df7cef9eb30b04e86.camel@intel.com>
References: <20230423085510.xpmcuzfhzqa4dyhs@pengutronix.de>
In-Reply-To: <20230423085510.xpmcuzfhzqa4dyhs@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM4PR11MB7304:EE_
x-ms-office365-filtering-correlation-id: 782146f3-50e4-40f4-8e90-08db43fb973a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bO4ZyzJh7QWWGvss35hOJQiSJ9pbiX+Ml2qXowG9bbyguWa4IaT7qAKgrjz2FyxHiEL0fkBSTr1yrk6UE9MBA5q/LfBR/NhanCPZZYWlVt28yfywALPCIjEIdjzJJ/BUG+voukHiv4liidjccufDPXBqYm9QZrXRiHe/VN9xqE6ZjoN2e3B6yk8GlZ10OkfSzNhD+s0kHZVfq51A43QfNLTYhh2MXPAYwVXHoF2ycwkoLsw+0F5jEJjBEi89ZniL2gYG3V9WmirLjRwuLPOPADPeRy0rVDIY681EF9Q2bnq/WEt8ALJlxarThTlMcZ5ki8dvpMRmJ4bQV/ftXH1x53UziVSAoQiMTEOQhkxoA2+IMdpUFxFXhRoZI/H1kRYLjRSkahrwI7nEG36hSieN/5WUyiQ7AGfqL+o0ymRF2DXXIL8ZbkbH8/gu/SuCY3PpOwXNL3BDL49bL1BxK14mMIwr6euFuPerUQMgvRl4M9l9ilx2ahoAKStoxpg38UR4Hmy8lAyok26zC7zUeaRMKRComrIUUVycQgdH18+08k5lOkAYntCUWeDF7ntCrlEx+nXQ5xpCn4qSKL6cM/HpKG276EVpw4UB7KvBNl/AKpk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(86362001)(38070700005)(2906002)(5660300002)(316002)(122000001)(8936002)(8676002)(41300700001)(82960400001)(91956017)(66476007)(66556008)(64756008)(66946007)(6916009)(4326008)(66446008)(76116006)(36756003)(54906003)(478600001)(26005)(71200400001)(83380400001)(186003)(6506007)(6512007)(38100700002)(66574015)(6486002)(2616005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXNRNlVhcUVMUjFqWTh5QVJWNWxoeHk0SDlKNkhNc1JLMW0zZnFOSGJpNHdH?=
 =?utf-8?B?UnB2emwwak80MjBRc1RUMU9Kc1pyZG9qU3Z2M0Z6M01zUHBrbUgveFlJSmF4?=
 =?utf-8?B?dnJybC9nQlhiODNNb0s1N1dibXlqZjVlZEI0c0FNbHJkK1drdWZJbEJMM2c0?=
 =?utf-8?B?c1c1ekFoYUw0OWdkaEZCakFSd1pwUEFwWHBLemhqaVoxaGwvMU1yQ3VzMStx?=
 =?utf-8?B?ZVl2MzVkSkZsM2d5bjlHQmliTFhKRWRIVVFmQW5qOUU2WmN3bGN0cENkZGd6?=
 =?utf-8?B?UDdwZC9nRmhjRHRqMWlGbG0rRW1KQnczMlZJKzFXZnMvNGhiNmkvOWExQ1BZ?=
 =?utf-8?B?TGpSVklRNGM5ejBLU1p2d3Z1aUQ1VlRnYStMZDJmTTE4S2VFQXhwcThKZWw0?=
 =?utf-8?B?aFQrRDIyd0tRN1pHbGwvYlJDTWJEMktpNVdUK3hvbWcrUUl6Mk41cXNnb2l3?=
 =?utf-8?B?QWw1Nmh3bmxVK1ZjdjZaTlNIeVU5VmNSRC8ySHRzMGFUdG90cHV5bFdFSTB1?=
 =?utf-8?B?bVpLQWJmWDliSW5LMlk4Y3NLRmlOUXRxZXVUQTRoV2hWc3pnTU9uYy9CMXJr?=
 =?utf-8?B?enNwZW1MalkzeHFycVp2d2Rlak9WaDljd2orQUN5UTlUaGU2QmRhdmphMmN1?=
 =?utf-8?B?U0VBVmcwemJQcFYrMVFDL0Q4SHFUQThXYVI5bWJZMHd1eURMeTFvWWY3RTU0?=
 =?utf-8?B?UExvQ0xzaiszd1FQMW80NXlDZ1dERUlsNGhBa0k4WDMvcnNHcmJVK1dtRnFt?=
 =?utf-8?B?VUNvUjE4K2g2K3hiVk9vbnBRbnRXRFdrejBxU01oSklxUnVYbTNEYkxSK2VS?=
 =?utf-8?B?emVuMlBXM0xpMjJhakZ6YmtDcjI4dnJrekM3MUhpWXVUcVRCZXVlTFQxTS9X?=
 =?utf-8?B?MVVoQUprWkxuYm9rbE5LMUJRbkc1TU9relRuZ2NUaUtCSC9ROE9RK1M1M3Ar?=
 =?utf-8?B?ZWxadXJsTk9jdVhIK0NvY1Z4dUdVS291cXlTYy9jTDUzcy9udEJ3dUlZZW9s?=
 =?utf-8?B?MGxTU2dQN3FqcnQ0Mnk5a3BaRXMxZ05wYkdMSWh0S1ZtTWFCV0YzaXZDbWw0?=
 =?utf-8?B?RWtuUEhGSWQ1UzB4d3VpNGp6OU02TkdrWjYxU1dhOUpseGJZU2h3VVh6VUpn?=
 =?utf-8?B?ZUV5ZDFIeVVoMHJIL3p5akg0MXVhN1NlVWJpaUNoa3RCQ1ZOMHJGV0FDTDlz?=
 =?utf-8?B?TjBRYXMreWRNVHdhSSsyVG9oN29xS1dDaHJnY3g4dUNHUVNsT0RWQnFuUnlD?=
 =?utf-8?B?R1U4UTdxdm54ZE1uaHpFT01Wd1FxbjVYNXdMRmw4MW5UUDdSdzcwcmxpWDRG?=
 =?utf-8?B?VmJNRVJVMGVHRUlVNVVJbG51S2lQSmUybHovR2FMSVpTSzUxalBPYUJhVmR1?=
 =?utf-8?B?Vlk1Tno1N0R5dXdKMUFtYXQ0MXp4V0tLV051eWNicnN2WWQvMHdGNVUyN0tr?=
 =?utf-8?B?RHI4bzNRajE1V3h5NHZVa0tFTmhCUDkzQ0hhNUdpaFMzVHJiSmdQOWFTcVBD?=
 =?utf-8?B?TWNqN2ZrMkdpekhOMWx4b29PTU1jRytvNStqeUpmN1JEVi9rV09DL3c5S3FF?=
 =?utf-8?B?dFJLTlJkY01uK2FtbEMrcFNQd1E5ZklLQURtS09CMTlETzg3cytiOWY0QUM3?=
 =?utf-8?B?QnRBNjJ5MGMyYXovU3RDcVR1eE5LVEZmZUtRMVMwZDI0TTY2eHdXWGRQeHl4?=
 =?utf-8?B?ekpWQ3pSNzRXRUpxSEo2dVVCWnhnZzZwa0crTVBVY3lYWU5ZMk5UcWF4R292?=
 =?utf-8?B?K2x4dXo5emFyb3hwMjFyMWFLY2ViSTY2SFF6TGlaVi8ySnMvZDROTXhWamlJ?=
 =?utf-8?B?cjZ3dVltSkY5TGQ4aHlhOExuMG9nVXVhL2hWMEh0dWl2a2V1cUJUNTh1S0pH?=
 =?utf-8?B?bGk5TTB6djJxSkR4dFNXaUdpZFpDZU9adHdVN210V2o3SkIvL0IzdTJpQStr?=
 =?utf-8?B?S1Z0cXBkTHRsVmdSaW1RaWRDRFdkR2dMcW01bDFsZnZ4a3ozbmFWbGhPbWh2?=
 =?utf-8?B?MEluSHArV3MzTTBnUm45UUFKaWtyWEJwS3lYY1hiWUdFci9oQzRoQlB0ZzBS?=
 =?utf-8?B?c0tCOFhaWEtjSDhZN2N5NmVUWmhua1NhaU41eVFWOUFTNi81SHdSQ01wVCti?=
 =?utf-8?B?a0FjRlNVY1MwWlNUT1diUmVLcEdvdmZwbnJlQzRLbUgxdkZmc2tVVGNQZXl1?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DE5AB85F385FF469342788E43C30C9C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782146f3-50e4-40f4-8e90-08db43fb973a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2023 13:06:45.5711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKAH8OsiiCsqyuXXuP8s27mZ2LHSXtlMndZRce4KCumHrVCqtiPnbhvEZ088CygnkotHMDDUSGqjb8d1I53I4ZdHODZyIy2dKpnMOVwF+Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU3VuLCAyMDIzLTA0LTIzIGF0IDEwOjU1ICswMjAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gSGVsbG8gR3JlZ29yeSwNCj4gDQo+IHRoZXJlIGlzIGEgdGhyZWFkIG9uIGRlYmlhbi11
c2VyLWdlcm1hbkBsaXN0cy5kZWJpYW4ub3JnWzFdIGFib3V0DQo+IGJyb2tlbiB3aWZpIG9uIFRo
aW5rcGFkcyB3aGVuIHRoZXkgYXJlIHN1cHBvc2VkIHRvIGJlIGNvbm5lY3RlZCB0byB0aGUNCj4g
aG90c3BvdHMgYXZhaWxhYmxlIGluIElDRTQgdHJhaW5zLiBUaGUgbWFpbGluZyBsaXN0cyBsYW5n
dWFnZSBpcyBHZXJtYW4NCj4gYW5kIHRoZSB0aHJlYWQgaXMgbG9uZywgc28gSSBzdW0gdXAgdGhl
IHByb2JsZW06DQo+IA0KPiAtIEl0IG9ubHkgYWZmZWN0cyB0aGUgd2lmaSBlcXVpcG1lbnQgaW4g
SUNFNCB0cmFpbnMsIHRoZSBvbGRlciBvbmVzIHdvcmsNCj4gwqAgZmluZS4NCj4gDQo+IC0gQ2Fu
IGJlIHNlZW4gYXQgbGVhc3Qgb24NCj4gwqAgLSBKw7xyZ2VuJ3MgbGFwdG9wIChJbnRlbCBDb3Jw
b3JhdGlvbiBXaXJlbGVzcyA4MjYwIFs4MDg2OjI0ZjNdIChyZXYgM2EpKQ0KPiDCoCAtIE1hcmMn
cyBUaGlua3BhZCBYMjYwIChJbnRlbCBDb3Jwb3JhdGlvbiBXaXJlbGVzcyA4MjYwIFs4MDg2OjI0
ZjNdIChyZXYgM2EpKQ0KPiDCoCAtIFV3ZSdzIFRoaW5rcGFkIFQ0NjBwIChJbnRlbCBDb3Jwb3Jh
dGlvbiBXaXJlbGVzcyA4MjYwIFs4MDg2OjI0ZjNdIChyZXYgM2EpKQ0KPiANCj4gLSBPdGhlciBU
aGlua3BhZHMgd2l0aCBhIFJlYWx0ZWstQ2hpcCBkb2Vzbid0IHNob3cgdGhlIHByb2JsZW0NCj4g
DQo+IC0gV29ya3Mgb24gcHVwcHktTGludXggd2l0aCA0LjE5LjIzLCBob3dldmVyIERlYmlhbiB3
aXRoIDQuMTkuMC0xOCBpcw0KPiDCoCBhbHNvIGJyb2tlbi4NCj4gDQo+IC0gVGhlIE9QIHByb3Zp
ZGVkIGEgc3lzbG9nIGR1bXAgYXQNCj4gwqAgaHR0cHM6Ly9saXN0cy5kZWJpYW4ub3JnL21zZ2lk
LXNlYXJjaC83NWFkN2ZmMi1lZjI1LTkwY2QtMmNiMy0xZjQ5ZjNlNDkwOWVAb25saW5lLmRlDQo+
IA0KPiDCoCBJIGRvbid0IHJlcHJvZHVjZSBpdCBoZXJlLCBidXQgdGhlIGdpc3Qgc2VlbXMgdG8g
YmU6DQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgSnVuIDIzIDE1OjQ0OjUzIGxpbmEga2VybmVsOiBb
IDEwMDYuMDExMTI5XSB3bHAxczA6IGRlYXV0aGVudGljYXRlZCBmcm9tIDNjOjUxOjBlOjU2OjMy
OjgwIChSZWFzb246IDI9UFJFVl9BVVRIX05PVF9WQUxJRCkNCj4gDQo+IC0gaXQgc2VlbXMgdG8g
aGVscCB0byBkbzoNCj4gwqAgJCBjYXQgL2V0Yy9tb2Rwcm9iZS5kL2l3bHdpZmkuY29uZg0KPiDC
oCBvcHRpb25zIGl3bHdpZmkgMTFuX2Rpc2FibGU9MSBzd2NyeXB0bz0wIGJ0X2NvZXhfYWN0aXZl
PTAgcG93ZXJfc2F2ZT0wDQo+IMKgIG9wdGlvbnMgaXdsbXZtIHBvd2VyX3NjaGVtZT0xDQo+IMKg
IG9wdGlvbnMgaXdsd2lmaSBkMGkzX2Rpc2FibGU9MQ0KPiDCoCBvcHRpb25zIGl3bHdpZmkgdWFw
c2RfZGlzYWJsZT0xDQo+IMKgIG9wdGlvbnMgaXdsd2lmaSBsYXJfZGlzYWJsZT0xDQo+IA0KPiBJ
IGFkZGVkIGFsbCBwYXJ0aWNpcGFudHMgb2Ygc2FpZCB0aHJlYWQgdG8gQ2MsIGluIGNhc2UgSSBm
b3Jnb3QNCj4gc29tZXRoaW5nIHJlbGV2YW50Lg0KPiANCj4gVG9tb3Jyb3cgSSBtaWdodCBoYXZl
IHRoZSBvcHBvcnR1bml0eSB0byB0ZXN0IGFuZCByZXByb2R1Y2UgdGhlIHByb2JsZW0NCj4gKEkg
ZG9uJ3Qga25vdyBpZiBteSB0cmFpbiB3aWxsIGJlIGFuIGljZTQgb3Igb25lIG9mIHRoZSBvbGRl
ciBvbmVzDQo+IHRob3VnaC4pDQo+IA0KPiBJIHdvbmRlciBpZiB0aGVyZSBpcyBzb21ldGhpbmcg
eW91IHdhbnQgbWUgdG8gdGVzdC4gV2l0aG91dCBmdXJ0aGVyDQo+IGlucHV0IEkgd2lsbCB0cnkg
d2l0aCB0aGUgbW9kcHJvYmUgb3B0aW9ucyBhbmQgY2hlY2sgZm9yIGEgbWluaW1hbA0KPiBzdWJz
ZXQgb2YgdGhlbSB0aGF0IG1ha2VzIHRoZSBwcm9ibGVtIGRpc2FwcGVhci4NCj4gDQo+IElzIHRo
ZXJlIHNvbWV0aGluZyBJIGNhbiBkbyB0byBtYWtlIHRoZSBwcm9ibGVtIGJldHRlciB1bmRlcnN0
YW5kYWJsZQ0KPiBmb3Igc29tZW9uZSB3aG8ga25vd3MgYWJvdXQgdGhlIGhhcmR3YXJlPyBPciB0
byBmaW5kIG91dCB0aGUgY3JpdGljYWwNCj4gZGV0YWlsIGFib3V0IHRoZSB3aWZpIGhvdHNwb3Qg
dGhhdCB0cmlnZ2VycyB0aGUgcHJvYmxlbT8NCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBVd2UNCj4g
DQo+IFsxXSBodHRwczovL2xpc3RzLmRlYmlhbi5vcmcvbXNnaWQtc2VhcmNoL2RhOGMxNTUyLTZi
Y2ItMTRjMy0wZTg2LWFiY2I4MzVlYzM1MEBvbmxpbmUuZGUNCj4gDQoNCkhpIFV3ZSwNCg0KQmFz
ZWQgb24gdGhlIGxvZywgSSBjYW4gdW5kZXJzdGFuZCB0aGF0IGl0IGhhZCBzdWNjZXNzZnVsbHkg
Y29ubmVjdGVkIHRvIHRoZSBBUA0KKHN1cHBsaWNhbnQgbWFuYWdlbWVudCBpbnRlcmZhY2Ugc3Rh
dGU6IGFzc29jaWF0aW5nIC0+IGNvbXBsZXRlZCk7IHRoZW4gdGhlcmUncmUgc29tZSBESENQIGVy
cm9ycw0KYW5kIGV2ZW50dWFsbHkgdGhlIEFQIHNlbmRzIGEgZGVhdXRoLiBJdCdzIGhhcmQgdG8g
c2F5IHdoYXQgY2FuIGNhdXNlIGl0LCBidXQgaWYgeW91J2xsIGJlIGFibGUNCnRvIHJlcHJvZHVj
ZSB0aGUgaXNzdWUsIGl0J2QgYmUgZ3JlYXQgaWYgeW91IGNvdWxkIGNvbGxlY3QgYSB0cmFjZS1j
bWQgZHVtcCB3aXRoIHRoaXMgY29tbWFuZDoNCnN1ZG8gdHJhY2UtY21kIHJlY29yZCAtZSBpd2x3
aWZpIC1lIG1hYzgwMjExIC1lIGNmZzgwMjExIC1lIGl3bHdpZmlfbXNnDQpJdCdsbCBiZSBhbHNv
IGhlbHBmdWxsIGlmIHlvdSdsbCBiZSBhYmxlIHRvIHNheSB3aGljaCBzcGVjaWZpYyBtb2Rwcm9i
ZSBvcHRpb24gZml4ZXMgdGhlIGlzc3VlLg0KDQpUaGFua3MsDQpHcmVnb3J5DQoNCg0KDQo=
