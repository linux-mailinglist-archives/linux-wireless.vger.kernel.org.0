Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2410592000
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Aug 2022 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbiHNOGo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Aug 2022 10:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiHNOGm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Aug 2022 10:06:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73CA55B3
        for <linux-wireless@vger.kernel.org>; Sun, 14 Aug 2022 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660485999; x=1692021999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FyIIrUW/X4z1YFu0DJqNJpUOOMIenI/e9+55ZmNwVzI=;
  b=a6C+vId/4nDsh8/xqNIh0k14CzqCJRFr9e4yjgqsrxs8qsdMwpXT+9F8
   3Q5eIaaxDB6faBAy1YQEbrOUEZvHHL7l72FHMWMqCnZm9w3S9pW3OD4wg
   jQ+c8BPaiDPfgRzSMakShxKhvFEVzO1r5KAP6Cc5NeJdxNpOB2ocKK5h4
   28W0r5ifaYtiVUyCzHzPdqkAktwfPXod7y4Q8GaIs8yj8FRMDEvG9Y5gU
   Oth/LksEegT66FzzBtv4A5t+JMUFAVdZ0Z2BywMnh2GpfI7aJ3+4H3hHF
   e6SZ2LYIWZRB7llRp4vqIshPqgCBb9Hhz16UEVWf2KflP46WsVMsmjG4/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="274882788"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="274882788"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 07:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="732687159"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2022 07:06:39 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 07:06:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 07:06:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 07:06:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 07:06:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c54rARXLCph1VR4YlFQCZz7RsD3sB/RJMKHCNYXlh5AGogXpz0qssi32Voailz8RmPxs002fwEZq40BcSjYuH4sTArkfITr2Bgu0nwhW/zrY3Qob5vQMBbQ4UE8wzVvzHFPyjVxX1OwqCyZrXpHj4t7EQR9qp7GiLdufCqTFi2dro4oYK9zFVB1564zWkXc62/YI07Ciq/6/qWIBIwM0k4NRlDY5ws7TXxYnwG4UetobvZECtr/9tsIIgFTP3+8wLsUssq7MnqZjqwHgxs6AYXuEDGlTLy9QNNI3jzA49XC5quFhzsKdKx3L9N8W1jjVaKp8ydFr0JYe7OeI92JgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyIIrUW/X4z1YFu0DJqNJpUOOMIenI/e9+55ZmNwVzI=;
 b=F0/bJ70W4eljtHXcvk/h//1cDO8CdMg/AiWPNzyjmpP2MdmbSWcKECL7nvo6NWzecQ4Wpmz5nC5/cthRRtjbHjw371Qx/hpwXa7M3YfiL1uJ7/hUiIbPnUMfJgu5eP1yFq3DjJ9ME/M5gKueFmyVL45GMHnHZh+cUZvCgs2N+pE+sVc+bRwEDjvAMiKNM7d7Fi0EOCwQut3vobzoXfF8h/KNOffjewMhVMbxDpVr+VOLsXAt/JxihqugLf1nLtAfKx6qiFnpvPzMH6y+06UMX+z9JSppbzmUYZwwkHwC3imjx0J78cLQAlb2649aL3Mys8cfpDmKVzzjx5kdDiZldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by BL1PR11MB5351.namprd11.prod.outlook.com (2603:10b6:208:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 14:06:37 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::47e:f523:3214:4517]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::47e:f523:3214:4517%9]) with mapi id 15.20.5525.011; Sun, 14 Aug 2022
 14:06:37 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "toke@toke.dk" <toke@toke.dk>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "mail@joachim-breitner.de" <mail@joachim-breitner.de>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYrmd1Z0WM+GtsbUKGq0Z4JPGPy62tU5aAgAEdu4A=
Date:   Sun, 14 Aug 2022 14:06:36 +0000
Message-ID: <491ec4d63116aa51567f74004b5fba299af42029.camel@intel.com>
References: <87ilr4hv8k.fsf@toke.dk>
         <10b81471b9f1af8b15bc5b9a06792a0a605131fc.camel@joachim-breitner.de>
         <SA1PR11MB5825CF723F193508BC04B051F2669@SA1PR11MB5825.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB5825CF723F193508BC04B051F2669@SA1PR11MB5825.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b3434e3-f7e0-4573-a4e9-08da7dfe33b9
x-ms-traffictypediagnostic: BL1PR11MB5351:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j5rcsAn3s2JKSsNYvN4T5Yn402HoQYT/DUGylJDuA6jZj41iCiPLC8HeXhNW7SaoAFsVthjUo0lpPxQ4bJlR6NvgMTqXauVlf0sBVN1jKHeyDcCNukQunMsBQS1BUYT8nrG/dluDP5XbZd24Ei4MTqNrBfmwRirg5Zw+NCCeRbk4y5665ZtEW43RXfFnVQ6eo9E9l0igDLecBBEHp+901GgvpFsV7dV56MseNcmxE61X1zWxXmfN3sWQyiMgW6T30U7K0ll0ewVdJBo6wOwTbMXkJLfJmXgQgdqdUjzuLedCFBpF5Qeo9agW0tV4H57MsPHF3nL4Grn0XlfOJLK1szrYR9q+qjKHAk54TrPSjkK/NdCF7U8cJZCJ6c5WUAk86CH0vmHdxJWJozUJRAicOiizRtbvyJUV8xhL3cSGfu/y182frF+qhDgF1sLu3I414VwFvSshI3/kNGS7nOSbSQCrl3TUT449dmnu4PSIlPD/NqZLBGuPBxL000Oq4Qx5AMpCW8mu3fREmCWI8EmhIRy+2P8+q4yNQC7XrPBQSDmiy1HLh/c56OsADniYZwYfKOdZDgqFduI+Q4vZi1pJsjNBbKElS1sEdiV+LL7jQor47MYCVVVD+97MdY6d3GSeDhlg+3N61HizYEBJU7w/5NAvsvQGRGc5hr61IYW54pBoVO0ZHmeaBQ31Q77cHq0VzuAxS/guGbWbW13XDC6iHpgfsM88tFyiJ4DYKW9VlhOB3jtMcjFaUjxHJCAXd/KgjUozDw3a7w9NfXyjEZ6dhGUCFyxOMXwNLQcN6hK/aNrEyF2OiCLYhI5zYY879EO6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(366004)(346002)(8676002)(91956017)(316002)(122000001)(71200400001)(38070700005)(41300700001)(82960400001)(6512007)(15650500001)(2906002)(66446008)(66556008)(66946007)(26005)(66476007)(76116006)(4326008)(38100700002)(186003)(64756008)(5660300002)(478600001)(8936002)(54906003)(83380400001)(110136005)(86362001)(36756003)(6486002)(107886003)(6506007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFJPUUVDQUYrV1d3M0hCZHFEeWcxVGtmYkd0RVRjVTBDazY4V0d5cFZ3eGhX?=
 =?utf-8?B?SjV0U05rV0VqTXJZa2VNZ3ZTUXZDWlFXbEE5MVdDUG9ZYWJJM0lzYjZBNGdS?=
 =?utf-8?B?dkRCRmVERlYydHNPT1ZvZ3ZFSmx1ZXcwM3BhNG5lUnhNOVlBQkZVOXp1dU5Y?=
 =?utf-8?B?OGZObm5QZ1V6MnI5RWpCVTFwZy96NmlFRVM0cEhRc3VybjFSWjZWdnBsdERn?=
 =?utf-8?B?dm05Uk9ONGFYdjNZaG5WcHRnLzNoQ1RRNCs2QkhqOEpsZTNBTTRZc01rZ1Av?=
 =?utf-8?B?cTRuNTV6YUxlM0owMVFSQ0FmYkwySjV3ZithakRqY0FLSG0xZE94bnNGS2NE?=
 =?utf-8?B?Wi8wWnZIOTZ4NExZdTA5eFRZWGlLcncvOWRvRHpUaFgwWSsxSk1vM0hBWlZX?=
 =?utf-8?B?d0lFbUtYUkpFTUZZaVdBSTZucWVSQ0IyWFV0OSt6SUpMZlhZd051M29ra0xj?=
 =?utf-8?B?cDk2alJxKzBtS2wrWlpIYkdlRzRBKzFqUjRMeXFaSDVtMzBqTUgxZGZPS1pr?=
 =?utf-8?B?TmRlNy95RUJWWFRQWi95b1Q2UnIyNXpzbGF1ak9QaWZlU3RvREZieVZEZEJx?=
 =?utf-8?B?bDhTSWFrckNXd0hSOXAvMkhLa2tGaUJ5MVJUTHNyejhxa3Y4ZXJtdmNwMHRj?=
 =?utf-8?B?aTZrakxnbFRyVWZMcDlrRENzT1R2QlRDQU0zNStzZDhiaVgveEtNQldLSHln?=
 =?utf-8?B?dUxxRkovUm5acVpiZE44ZDdWb252NURpOU4vTmVaV0UyTmJnZjNIMHVhTzQx?=
 =?utf-8?B?d2NITzR0clR5cGc2UnR3c3NZU0Q2cmp6WGg5cjMyRGVVMmJZQjU0eVFsakgv?=
 =?utf-8?B?UXJEVysvM1pBSEl1SXIzbUlhRUhzSWFWbXJuQ2ZtbXFHNkF6UkRJMWwwejhi?=
 =?utf-8?B?SFNsaDhNS0RaM1c1dXJzKzU0RTI4eE84c24xRnZIRmlwbjFEUzRaMjMrQ0NW?=
 =?utf-8?B?S0JFbzV5eHdTNm1jdnRZTFYwelRiVlo2WHU1eUNHRWJBNTNlZjJuZUx4V3p4?=
 =?utf-8?B?OUlENlRqbmloUnRkc05qUHhaTDdZZ1p4NHZEQzczRkgweHowMlpoeFBHNUR0?=
 =?utf-8?B?c3d5TktsNkJrbXg1SHBzVmhiZklGc2hwSUhnVzg3Q1kvL3pISWh2R1FHTHdG?=
 =?utf-8?B?Yk5FN2NpZDFadFBKUE1HWm5tMXg2TUtBMjRPRXFZdDZMVyt2Q0x1U3lYVk9Q?=
 =?utf-8?B?amlOdUpjV0pPWVovYlVPVnBYaGwycFMvM3Jab1RWYU1SU3pCa1p3WkJ3RjVs?=
 =?utf-8?B?SUdsVldpYS80bmRmajVLc1FCKzVUcnE1OWw5VW16Tm1UenlYeVh3eXFXeXZa?=
 =?utf-8?B?Y0E4WnpnSlFuQnRQekVyWFBKSnpNV1YzL0toQXpUTkttQjJlNjNYTUdJMXly?=
 =?utf-8?B?bWtuTW5vZ1QxRGRiTVZWbUQ4eTZMUVJkVGdiUktxSExXcXpNczdCTUFOVnkz?=
 =?utf-8?B?dEkxWTNQN3hQS29OYmtEVWZCbGVsYitkQ2ZGblI2SHFtVVppcHM3anJDU0Zj?=
 =?utf-8?B?MXBNc3V4UEo5NXlKcHpQR2t5ekhWSHQxL1pRUEV3MVJYYmYxeXUyVnhYd2Vp?=
 =?utf-8?B?UldxNThYR0F2RzJMUml1WWtmZnBlM2xBeU8zWE5ZOGpZdUF3aUlQdDFnTy9k?=
 =?utf-8?B?T1JNeVI0NTBEWDUvNjVrMXgvRDYxak9PNGgxWGFOTzNibnQxbHRZckc4elJT?=
 =?utf-8?B?VWJwc2NrOUxDb0trUVlsV2JpYnRycUxObjVXUFpnQTJhMlVJLzlkWVNicGJw?=
 =?utf-8?B?alBiSzJ4dThxMnpBcklucURjMzVZSkp2cVdpd04rdVdIREFxdXI5dk1lV2ZQ?=
 =?utf-8?B?MDNlZVpoZFNHWHFMZllZalc0bTJjejBsZGZtN1pNRGlUNmlkQUVHUDhkY2J0?=
 =?utf-8?B?YzRlaGIwcjRpYVowOXpIVndRQTVnZ3piM2owdEgweTliK3FyeTdSTHdURldU?=
 =?utf-8?B?cXhUZFZSSWlZc0NpdTdsTnZydEp5cmxHWGhIOUZuaW84N0NXNjVDSk5rOUlm?=
 =?utf-8?B?OUp3Z0tzdWlxQzRXK21LQkdLSVNSd3dTaFJFWjcwOFNibWgwZlR6bmhDaUN4?=
 =?utf-8?B?dEV1cElJSFZwTDdpUllWaHp2S05PZUZIM0UvazliNC9Nclp5UDg4K1F4V1V2?=
 =?utf-8?B?blFlR212b2d4akdBblRuTWtJdXlveUE3WVJmKytxNFFHc24wM3dGZXpzL2JC?=
 =?utf-8?Q?qR5WvelOiSBRKaRpCRDZrZ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55525691DC4E6147BA3B193ECDC8751B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3434e3-f7e0-4573-a4e9-08da7dfe33b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 14:06:36.9159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lR3HRWCMeIFDiKe2tWBXGjNC2hhPctLqXOg8IcfHhckkF2yqJVUYr4ef2WzR5uNm0kAQGJHw+FEwBiBu+QvCOfNzRd4g9H/bfXkVsYoRWOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIyLTA4LTEzIGF0IDIxOjAzICswMDAwLCBHcnVtYmFjaCwgRW1tYW51ZWwgd3Jv
dGU6DQo+IA0KPiANCj4gPiANCj4gPiBIZWxsbyBFbW1hbnVlbCwNCj4gPiANCj4gPiA+IHN1c3Bl
bmQuIEkgZ2V0IGVycm9ycyBsaWtlIHRoZXNlIGluIGRtZXNnOg0KPiA+ID4gDQo+ID4gPiBbMTA0
MzkzLjE0MjI2NF0gd2xhbjA6IGRlYXV0aGVudGljYXRpbmcgZnJvbSA0Yzo2MDpkZTplYTpiODo1
OCBieQ0KPiA+ID4gbG9jYWwgY2hvaWNlIChSZWFzb246IDM9REVBVVRIX0xFQVZJTkcpIFsxMDQz
OTMuMzQ3Nzc1XSBpd2xtZWkNCj4gPiA+IDAwMDA6MDA6MTYuMC0xMzI4MDkwNC03NzkyLTRmY2It
YTFhYS01ZTcwY2JiMWU4NjU6IENvdWxkbid0IGdldCBBQ0sNCj4gPiA+IGZyb20gQ1NNRSBvbiBI
T1NUX0dPRVNfRE9XTiBtZXNzYWdlIFsxMDQzOTMuMzQ3ODc2XSBpd2xtZWkNCj4gPiA+IDAwMDA6
MDA6MTYuMC0xMzI4MDkwNC03NzkyLTRmY2ItYTFhYS01ZTcwY2JiMWU4NjU6IGZhaWxlZCB0byBz
ZW5kIHRoZQ0KPiA+ID4gU0FQX01FX01TR19DSEVDS19TSEFSRURfQVJFQSBtZXNzYWdlIC0xOQ0K
PiA+ID4gDQo+ID4gPiBBbmQgd2hlbiB0aGUgaG9zdCBjb21lcyBiYWNrIHVwLCB0aGVyZSBpcyBu
byBjb25uZWN0aXZpdHkuIFJlc3RhcnRpbmcNCj4gPiA+IGl3ZCBmaXhlcyB0aGUgcHJvYmxlbS4N
Cj4gPiANCj4gPiBJIGFtIGhpdHRpbmcgdGhlIHNhbWUgcHJvYmxlbSwgb24gS2VybmVsIDUuMTks
IHdpdGggdGhlIHNhbWUgSW50ZWwgV2ktIEZpIDYNCj4gPiBBWDIwMSBkZXZpY2UuIEkgcmVwb3J0
ZWQgdGhpcyBpbml0aWFsbHkgdG8gaXdkLCBidXQgdGhleSBzYWlkIGl0IG1pZ2h0IGJlIGEga2Vy
bmVsDQo+ID4gcHJvYmxlbSwgc28gSSBmb3VuZCB0aGlzIHRocmVhZC4NCj4gPiANCj4gPiBIYXMg
dGhlcmUgYmVlbiBhIHNvbHV0aW9uIHNpbmNlPw0KPiA+IA0KPiANCj4gSSBtb3ZlZCBvbiB0byBv
dGhlciB0aGluZ3MsIHNvIEknbGwgbGV0IHRoZSBvdGhlciBwZW9wbGUgcmVwbHkgb24gdGhpcy4N
Cj4gDQo+IENoZWVycw0KDQpASm9hY2hpbSAtIENhbiB5b3UgcGxlYXNlIGZpbGUgYSBidWcgaW4g
a2VybmVsIGJ1Z3ppbGxhLCB3ZSB3aWxsIGFzc2lnbg0Kc29tZW9uZSBpbnRlcm5hbGx5IHRvIGxv
b2sgaW50byB0aGlzLg0KDQpUaGFua3MsDQpHcmVnb3J5DQo=
