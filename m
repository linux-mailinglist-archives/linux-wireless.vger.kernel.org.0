Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75A65B5AFB
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiILNRR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 09:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiILNRQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 09:17:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586E72ED5F
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 06:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662988635; x=1694524635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vz/nRhTNwvbxgiPJe+1jMHp5+JcNzK7WiB2wz74+syk=;
  b=U4g3sFrd5iCs5hwpzQoWfT0vsl8qx0vvRjfNWNBFtX2viNhzsEo/pSXI
   8D6OoEjEq2h4SqY7S7hwBIk4nksWxHYTM/rNS3yFPBmnf9nkHfGmLT1De
   Zi0m5eeujnARMzutDc5cM232Fw36RCqNJ7bG13rFBrAYuT1tMoxu8PYYl
   6tUfD3g2RBJ6GLSZ0APpZBSPq7C6TKm+sefWV78tAggMKZkLmtAjLHfwt
   xv83WuTZkMcE8tIJVNEwClZ8tPM7gVPzA5WgcRSZ87NvxoHpAGdMh99Yk
   TRNWAu15b+MNhHwkQo9dEk5pE8Z/aQpP8mVe2JRbyxQrgzJJkewOpzIzy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324094177"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324094177"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 06:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="618547674"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2022 06:17:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 06:17:14 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 06:17:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 06:17:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 06:17:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLm2sN7p4BVTDzTZIiTd+7M+/MXyDfgLsW98JM1QTrfAiw178vowijWBgDy+Ao4m+KfFI/bcBCa/T9VwOLOA4dyfDf3ojvEHgsc9+fmALS8rTRTQyeX4NlW1FgSitYkRzEj6GuT1casH2hbglnxgAEhnJa60H3NcIr5IA+Pkz+Mv96yPoYSwl7t2XzVJm+LQBUjGHyfcraBr73X+Mm5s7adxkuql2+g+VInr5L/ALs80n1w2O8RWxapBsUfar3IP2VQdL9EFC23MS0PP+1yvrIGkHk8QhPMG5WOX8hSeCcvF6dbnCi1HKFfDBdXwYO1QFjjqXUHY+98nsaW5KRly5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz/nRhTNwvbxgiPJe+1jMHp5+JcNzK7WiB2wz74+syk=;
 b=IKyiuff8u+aKwR62sNGBrBRWWAxu5yUyxUJY00rAwBUl6k7Ljlz4kqJKRINKZ0me/VX6j+z6waKMWmb0EOYDonLv18D6eQGs/PdcOffkkF9Dfk7H/ZEU4vZWnEkx7bwHs8asK8bRfQUV+li7Tcsz7CbSPg73DKmdZ8aR2iFFXo16RLmv8dpoye0H7vsD0cuenjePg2fz9OS4bRZgO+AViKlNxT9HsuNXLSa4xBhE9L8sACQVZd1CClDooNEphTw5RSouE61jl8lwFq7ZckvUL6ZkpdFgfRL51G+xXWLRh25TqQodVrCFkQ+LpYmEN6mujvIrhWSBnTFxKDiPZRz0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3897.namprd11.prod.outlook.com (2603:10b6:5:4::26) by
 PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.18; Mon, 12 Sep 2022 13:17:09 +0000
Received: from DM6PR11MB3897.namprd11.prod.outlook.com
 ([fe80::57d:192f:2271:3a48]) by DM6PR11MB3897.namprd11.prod.outlook.com
 ([fe80::57d:192f:2271:3a48%3]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:17:09 +0000
From:   "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To:     Wen Gong <quic_wgong@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "Peer, Ilan" <ilan.peer@intel.com>
Subject: RE: [PATCH 00/27] another set of MLO patches
Thread-Topic: [PATCH 00/27] another set of MLO patches
Thread-Index: AQHYwcdECXMEe3QNQ0ujvgfkz4HwEK3SFYGAgAm29vA=
Date:   Mon, 12 Sep 2022 13:17:09 +0000
Message-ID: <DM6PR11MB3897D1A4E13419D9F938F559F5449@DM6PR11MB3897.namprd11.prod.outlook.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
 <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
 <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
 <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
 <f3afceb8-8120-12c7-74b9-caa3abce5cb8@quicinc.com>
In-Reply-To: <f3afceb8-8120-12c7-74b9-caa3abce5cb8@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3897:EE_|PH0PR11MB4792:EE_
x-ms-office365-filtering-correlation-id: d5c869e9-36a1-47bd-5e72-08da94c118f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1MFEjLAsCGsU4ndDbsn0DrTOJMCSWlaZDvEtJqAzEAsR/SUePTc2MtB75u42Fqv7FeA4k68QMOs6KWPSMUpRNOVN1wjXHxt+5SbtgLJbTfzXwMB9XkOjLHocbWtWe7q/gtdgoU27qBv+qbWgOAIYwUmaUQnY6ph1/z55iq8mIauRi6Fvi58XNZPZe0dhGZkyHbVZDAuLj50I9Ht7M8g6EeQHDQowk09DUu7fT5ZtXmAm6rL/+Ut6thXKH6WcgqaVOVnwgKMD9PAcRMNJRZ3WgN/EWBS8ZUKApVDGzfib9zNKYuMwajyGpFeFjjrj7qGiKSC5BJMesfHTEA2+DJPWjiH9Vlhv3/NuPvGMn4v6j1WAkIbCdj8cf/dGf4H4Td00c6fLZyzapz2cwoAWhp24RT0+2iEKq7NDtB4d/Ci12vYCCY2bmZmTSlfZn+yJEFrcShevVzSH6NzVuOJ6BoooINp0v18BfxwXfHgW80KlwDCo9FQD+HTFkD89CWPj5mQbwe5MWK0gAbWJgMjq3DIAky3bfjw78oV5MjhMUphEcxSc4rhw3ZQe/bEMEavT0LwUzMSGzDqvm5srizq5N/1AfBpRzkKZzcAGsGlBgOdM0xG0HcAuUMnZBEoFzSWwVIdsCQiai6gLhGSCxFriVsFa2is5Wgg4B7ZigP9yUnG9aBO/T1/fmmXplEcbDAdf3BRcqiVkcdyMlcj3qvAFOC5b9RIETtB1rqYJA1v2HsBlz75i+e2jdOki3nOh9cJmVnScs+OzLqoblZFvvhjgSdjwQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3897.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(346002)(366004)(66946007)(83380400001)(122000001)(2906002)(8676002)(66476007)(4744005)(5660300002)(66446008)(64756008)(52536014)(66556008)(38100700002)(7696005)(76116006)(4326008)(8936002)(33656002)(26005)(41300700001)(55016003)(478600001)(316002)(110136005)(86362001)(38070700005)(107886003)(9686003)(71200400001)(6506007)(186003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q09mNWVtdkNtUXl5dFJGMVZlTTFsdTNrTnJPU3FoaWlwVnRZWE82UVVwME1v?=
 =?utf-8?B?SmZmbDJJVXRTKzQ2MERMVUxIQThXMTRWOW1SVG54OFBlU2x6UlNGSm1yV084?=
 =?utf-8?B?TDJvSVdyL0I0U0l3SG1PTGRiWU5OY2tFQlNra3AwaVhEWEh3Z2ljUk80WElC?=
 =?utf-8?B?dU9aLzFmdmhqLzNzZERWU0tjWHBJdWozMnVhMWx2YXVCY0pqOFV2VHdOOURr?=
 =?utf-8?B?dWZJTC9leTlrbXpKVldxY3Ewd3VpaGNlL3ZGbHRJRkw3OUhZN3dJeHZqNXAw?=
 =?utf-8?B?V3Y5OFQ2b3lCMnhEZTZ3Ulh0cmRnZzB6czc3cWdIYjArbkNHVzkwUXp0OGpT?=
 =?utf-8?B?QXJNY2IrN2NpekF2MCt0Z0kvVkhtb0xTalNoQnJ4RXBzTkN6c1lZZFJmVDdq?=
 =?utf-8?B?YVY1Rjd0WHFGU3BjVjQ4Z0Z0ZUY1WFU4U2VUM0dqb0tHZzNrbTNVcWlPc0NL?=
 =?utf-8?B?ZVRqd0dEeU1FazhaS1ZjS0s2K1RXVyt3WDh1UFdaQ2tFTjgwclZBZWpsL2ZF?=
 =?utf-8?B?OW1scTk4ZkN4d3Y1K2xrNFdTK2g4MW9VcG0yYWNxOWdXQ0ljc2h6YXdHbFlH?=
 =?utf-8?B?OE1vaWFpdHI3VnVSZTcweFFzSWZacGlUcDloLzJkSjY0bVR5UXJqUEY5TkhP?=
 =?utf-8?B?UlU3eUVFanlScmZhdUlQaUFCamNBVnplZUhsanpGaE82Q05rUW5pS1ZUSEFt?=
 =?utf-8?B?MzZpMllHUlJQUGFEQmFiRkdrZ0dtY0VVRkJYb2hyWU1FSHFPNDhEOGQvM1gz?=
 =?utf-8?B?WDZ2Uk53WkhGRjBEZ3FBSUl5cDY4V20wMkFqejZlMkRQVnVTUGRYSHR5ZWt6?=
 =?utf-8?B?YWlqcWlZaXJZMXVPZENERC9Dc1IzOCtHb1pEQ2w3aHVTSStPMVJIWU96Yk44?=
 =?utf-8?B?OHRoamJUQmwwQUhqQWE3RlhlNjF0eWJrL2dwSWpwaFVIOVp5QTJHZEpEcVcv?=
 =?utf-8?B?aUswTHFXYjNvclQrOTR2YTRvSGR0MFZJZThGUkxmYkVSay8yK1RFcWN3d2lm?=
 =?utf-8?B?RHF1aVBWYnc0ZXFuRnduaWhMbnRIQzU3M0hWUGszNlI0Ri9BMXlRM2dUWWwx?=
 =?utf-8?B?T1hPWCt4YjF6ejY5ays3L0NrRGlIQ2JXbTQ1MHo2bXUvbGo2SXN4WVNRQ0di?=
 =?utf-8?B?S3cyWmJZblhaeC9INSthQWl5eGdqMGFJM1BFRUc3VlNZZDJESHBrQWtkZC9R?=
 =?utf-8?B?QmI4TTVydUJqR3FETnhuc3JrRDVzd1ArVXdCSi9QRldpZVZld2IvRnBlMEFT?=
 =?utf-8?B?U2tYSkhJaXNlM1hTbGFFRFR3Q0dQU240YnIrRlZiUldZbHcyRVVPSjVHZ2lz?=
 =?utf-8?B?OFE5YVNscFo1elA4VkJkOHU1UjJxSTNKZWdvWnQwM1AwV2gzVDU5aDRUb2Vq?=
 =?utf-8?B?dWhSalVLaCtnUnJsdzZZY1VYS1h0ZWt2NFFlT0xaaVpEU2NCU1ptQ2ZPSUNa?=
 =?utf-8?B?SHNNVVRnYmhRMTYrTWgyUzRXdkgvdWxzTnJJbitoVG95ZkYxR0ZQZmtOV0Za?=
 =?utf-8?B?dXd3SjluQkQ3REYyRktoQTAwVXVkd2M5cXFjNmd5ait5RWxPdlpYUWRkUHhJ?=
 =?utf-8?B?dCt4cFpQOW1aSTdoNjVJQjZybnJraGVSTkQyLzFCTUtoSE1BOXFaNW1KREdK?=
 =?utf-8?B?LzEyR2Y4SWV5cWRyWnRoK09GMDhZQXkyN3JTNXNQbzc2VnRpYXFjd0lxektY?=
 =?utf-8?B?SkJOVXd0NFUwWjNEeXd5L3d0c1VoY1ZKNDF3ZWNXTDRKTkhjZjJyS1UrREtn?=
 =?utf-8?B?WkE0OHRrUzM3cjgxSFBWZFpxaDFmV3owOThpLzlhc2dYdXRFSC9ScnFFR01E?=
 =?utf-8?B?SnVHL0tlMm5vaU1lUW1jeElSZWdYbTNsYW9TOGRwSlhiWUE1UThtSExmZjlH?=
 =?utf-8?B?cm5lR0dyVkd3K2d5NVJpUW41R0Z5TURsd1cyN2FQZTZxbmtmeStHM204cWJY?=
 =?utf-8?B?d04wOU14eXo1K1UzOGhhMUx6TzY1S21wcnB3VVpOOVJFNkZibmRXdktwZEJK?=
 =?utf-8?B?cjhRTjkwdVVlTFRSOG1LL25XT0E1K3YxM1JaaVRDdC9VQmtaWmJKSFNwTlpQ?=
 =?utf-8?B?STN1cWpvRWJlUmMyUU4waXpmbmx3L2R4Y3pLMnVaTUdnWHNxNjVLaXJmbkYw?=
 =?utf-8?B?MFdjQjVtR1UzOTl2azN5N1hVYys5TUVIaUtQdkVTclUzMlBRR2szTUppRmFa?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3897.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c869e9-36a1-47bd-5e72-08da94c118f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 13:17:09.4275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njMkhkd6DhyD75JHTXz2mF8JSks6620/Ix8XtqS93cwcq3p+odCzRFnrQjFBeXeK7pjUVtF4KgNQmtdYkJV69PxeJcbRE7DDGS8pqYPJOwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4792
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiA+IFdlbGwsIE9LLCB5b3Ugb2J2aW91c2x5IGFyZSBhZGp1c3RpbmcgdGhlIHN1cHBsaWNhbnQg
dG8gd29yayB3aXRoIE1MTw0KPiA+IChvdGhlcndpc2UgeW91IHdvdWxkbid0IGdldCBhbiBNTE8g
Y29ubmVjdGlvbiBpbiB0aGUgZmlyc3QgcGxhY2UpLCBzbw0KPiA+IHllYWgsIHRoaXMgaXMgcGFy
dCBvZiB0aGUgYWRqdXN0bWVudHMgbmVlZGVkLg0KPiA+DQo+ID4gSWxhbi9BbmRyZWkgaGF2ZSBh
bGwgb2YgdGhpcyB3b3JraW5nLCBtYXliZSB3ZSBjYW4gc2hhcmUgdGhlIHBhdGNoZXMNCj4gPiBl
dmVuIGJlZm9yZSByZWJhc2UgZXRjLg0KDQpIaSwNCk91ciBpbXBsZW1lbnRhdGlvbiBpcyBiYXNl
ZCBvbiBvdXIgaW50ZXJuYWwgdHJlZSwgc28gaXQgd2lsbCB0YWtlIHNvbWUgdGltZSB0byBjbGVh
bnVwIGFuZCBwb3J0IGl0IGZvciB1cHN0cmVhbS4NCkhvcGVmdWxseSBJIHdpbGwgaGF2ZSBzb21l
IHRpbWUgdG8gd29yayBvbiBpdCB0aGlzIGFuZCBuZXh0IHdlZWsgYW5kIG1heWJlIHdlIHdpbGwg
YmUgYWJsZSB0byBzaGFyZSBzb21ldGhpbmcgaW5pdGlhbC4NCg0KQW5kcmVpDQo+ID4NCj4gPiBq
b2hhbm5lcw0KPiANCj4gVGhhbmtzLg0KPiANCj4gSXQgaXMgZ29vZCB0byBzaGFyZSBtZSB0aGUg
d3BhX3N1cHBsaWNhbnQgcGF0Y2hlcyBBU0FQLg0KPiANCj4gQW5kIEkgaGF2ZSBhbm90aGVyIHF1
ZXN0aW9uOg0KPiANCj4gV2hlbiBtYWM4MDIxMSB1c2UgdGhlIE1MRCBhZGRyIGluIGF1dGhlbnRp
Y2F0aW9uL2Fzc29jIHJlcXVlc3QsDQo+IA0KPiBmaW5hbGx5LCBpdCBzaG91bGQgYmUgcmVwbGFj
ZWQgd2l0aCBvbmUgbGluaydzIGFkZHJlc3MgaW4gYWlyIHBvcnQsIHJpZ2h0Pw0KPiANCj4gSXQg
bWVhbnMgdGhlIE1MRCBhZGRyIHdpbGwgbmV2ZXIgZXhpc3QgaW4gbWFjODAyMTEgaGVhZGVyIG9m
IHBhY2tldCBpbiB0aGUNCj4gYWlyIHBvcnQsIHJpZ2h0Pw0KDQo=
