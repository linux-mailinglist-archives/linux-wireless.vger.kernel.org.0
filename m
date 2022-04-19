Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47B25078FD
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357213AbiDSSi3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357735AbiDSSiM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 14:38:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE125DEBF
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650393328; x=1681929328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zdabxYKm+Rowj3j/EN25UViwdTcGbH/4vcPolEmrgwE=;
  b=YIUsdgnwqbuqEW4aWlKSjsY/JllT0nL9faEEamBEj471JSdPvR7u4C7H
   WRPuV1ZWemK+7BHV/BMGxDv1Yf0Tk+i4+3BvYHGDHrd0xOaEdciIX/JaX
   2rwrr41WWISrTky3mZZLf1Svn8BJqU5ttquoVzDVmGZzuvq1v8vNvbiHS
   s2I4h2vcYq5vI8GyeHS6jsnUXXRxD8mMzCOZUdVVKNglSptN2UoEMy0M6
   d5br3OSr56o9HvBbzysK9lA40WQ7ij11iDp2q5O6GPg2dTzzUTkn4lyb+
   x5Ee7G1eK7CuZziyZXFlOxtli8R6Z7d1zInfOFnLJKlf9bp67Bf3+VkgD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="262699559"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="262699559"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 11:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="529429221"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 19 Apr 2022 11:35:11 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 11:35:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 11:35:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 11:35:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfxsYa+Vy7AcDIEJ7PzONfgvjORdd6uZlN/R3ZKkZDpzurCzbnTKRypNI4NAbBuQz+TNX99Nju3nS4/kuHJnGTbY5C1rzh92eY0d/XicKPPfl6rUc5P1t+rTBwr6oHEfytZmm+AcVHF59TcJxuV5f6JLytYILXkiN/wWmNkgcMhwd305ZiT8TDg0E3y7kXI/TLNy+Rhsn7kM5DAgJ0cVg6J0KfX8BNewjh26Nr3YQL3nLC6vyNgxKubmYCgHj94uEFKoC9Yc3eC4NNAmQvIZBDpdLIUa/cgJoxN5h0opKeOdi164Ai1dAatvz6D5JnfUmvwLv2Yo5ooiKFRZlpVS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdabxYKm+Rowj3j/EN25UViwdTcGbH/4vcPolEmrgwE=;
 b=l/KgAYvb+Xs+puUaYUYRFlyiHqGmvFhNLz7jvRFLU88a/iGGbi5GJ3qbvIMhcfDAYUj0OotO/sTqRNwLNzVC+Vvzxpf7sJdF5g2GOnND0B87Df/g2++41VCysKk3YoXnm8D+HpPrMsmDkji8axRRWSO/olRflAM+uxW4tL4/cqAfgpPrnftTIQW9qJXMopY6n82fS3rv/yc44PRkkjr+DIZx1Nzn4LCqWeNbnyVb3vcPIuurQZ5f+Pdd2t6RQomCJ+1O9qnH8AFTaikEEe2Oo+aKhCgRKfjTLBciSYcYDdkqGupehCYenEiCn+ZMbWNDRNvmP297YUberpXe/7EsYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by CH0PR11MB5393.namprd11.prod.outlook.com (2603:10b6:610:b8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 18:35:09 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 18:35:09 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "toke@toke.dk" <toke@toke.dk>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYUxiO5laT20cdFkKz0kQ4shKh3az2xgSAgAAE2ICAAARFAIAATT6AgABoR4CAAA2LgA==
Date:   Tue, 19 Apr 2022 18:35:09 +0000
Message-ID: <94b98b712b86690dd5ae19df0cc608b8193be1f3.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
         <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
         <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
         <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
         <87mtghs3y2.fsf@toke.dk>
         <e0872b6f468bfda08717214044b64187f71b4e18.camel@intel.com>
In-Reply-To: <e0872b6f468bfda08717214044b64187f71b4e18.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c159b07d-5585-4222-d85f-08da2233553d
x-ms-traffictypediagnostic: CH0PR11MB5393:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5393227DF2C329B024E0AB08F2F29@CH0PR11MB5393.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FkWkcJOyGyGduvZPVyVX8VQnqnYPUv0sO0epUaDv4T7V/EFesaYc3CgBB9ysiDtrUnfL0+bBZ9Peo0OlvolUP+0hzDhwNwvOcy2qZEi7HBnhWLmZXxmBk8Zr1rUhRZ38ht2RjI5Eie56z3HfLjP2E8D9Oy3q7dnr3OFdmZDcazaIwDuB6TT+0KF+wSw2TUS2EvysEuFq3MMr1wTBY5t0kaWVX0Cu1tYevh/+qBfOwBEI2DaDa9umpM9qGRUSbWaI4n6ByRPuua10131jJlDNh6xggSwcVUxVS+XYgs+X8zkY9mcy7RxjpI6r3nvUjWJOD51tgzSFTCk/NwCHt8gXrKLbpjsckufKswfBpwN9qm9n3zeo9ZvRwQijnX75SQ37Q2RRnHai7KHw3Iy+Vn2ObuZ6ubWc7o9coQVkU/TSYvegZb9zvNIv9Hrs9H6WbycL6tGPXgPYtzLnVRXn07xi6CYbye6bcJ7I1BFxgynCHfyH0FIK46IBDXwqgUtMC1eO4UZ4+6cKcU8M27p60qNT7Y8ErpMN2sypopYVJh/tOpztlJaV4qFbBqr3UNuCMl47knvXlS18f6HsN64Uq/I72mz8zmkUFeL9P5p3m2SqA5S9PN1Xd8CCMVui7w6rIxxZifN3ZNEFNGtWXUVHDSMoirwxTnjuT2GU3oyLtUvLBKZxjqdr4J4O3yRcO8asChrnqi1nfEhApAzP50uJHsIzMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66446008)(66556008)(76116006)(64756008)(66946007)(6506007)(6486002)(91956017)(66574015)(508600001)(15650500001)(4326008)(86362001)(83380400001)(8936002)(2616005)(2906002)(26005)(186003)(5660300002)(6636002)(8676002)(122000001)(316002)(36756003)(38100700002)(54906003)(82960400001)(107886003)(38070700005)(110136005)(71200400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TS93RzVPU29TSnZMdGc0TmRQZHhJR3IzV1Vrb2I4eTJ1MFU5eUYraVQ5cDh3?=
 =?utf-8?B?YWlHMVVuWUhXeko4d1RpOVR5RDVZVDU0SkRqME9Xdnk2djJYYytBTXorOGY3?=
 =?utf-8?B?M3hYRUFwRlVGSy9rdFBlNHdxdnRqMi8zdzF1L3ZMYXlMRGorS3psVHJzQmR4?=
 =?utf-8?B?REtROHVTNW5JSHV2OFQ1VG5KOHlhYW4xV01lMWRmNXN2THBKYjlUdStlL0ZW?=
 =?utf-8?B?cWRmTFVScE0yWVRObUp0NU5lTUVxVDBwYVdZck9wendKQkF2eGxBUkRHQllK?=
 =?utf-8?B?WEZaQnZRUm9hZld2WnAzODExYlNvU3BzQThqUTBjMXVXeWZDQkFmcFZBc3dM?=
 =?utf-8?B?RGVjN1lsakl3QWJ0enhodXgvL1dFMHdhbTQ5ZXJYN0FUZ3R6WlQwUHcvWlhl?=
 =?utf-8?B?NG81QkhuYnZuZjV2ZVcrLzV1cm9QK1V2YklTNVZ0dHN3OUZxRHBxN1N5Snc5?=
 =?utf-8?B?SlNlZFpFRHRQUWVLd1lmS2JKY05ab1Z2aStDRWM5alhuRzRVS1pkNEFoWCtx?=
 =?utf-8?B?UFVqNXJkSFJQSmFQRzIwUktTSlhhQjZvSEFpZDdLSTZad0tCNTMxRGdoS3l4?=
 =?utf-8?B?NnFYTmlxRm9IWDMvODBWMFBQSDJkVmErZzdzWjlpY080cHF2eUp5WkF2QlpF?=
 =?utf-8?B?ZUFtUFRqaURsWXdyWituRFdac21YcXE3QmkyQ3ZwWTVBRlhNMUhnbzZBVU82?=
 =?utf-8?B?L2Y1NUpTNXFNaG8vejZvaldyblRKUDNvNDF4Sm5Ta3NhWmp3S1g2QnR3M1c2?=
 =?utf-8?B?b3NEVE5RWTQvNnV4Y3l5L0pMSmZtWncxVkJ3M2ZabURIeWU5UDY2Smg4WEZK?=
 =?utf-8?B?L2FVaDYrWldTUWZnZk11b0pxelJrd3pqYWd4VGxScVNlc21WMmhQWTVDeUNU?=
 =?utf-8?B?eHJwZWNMSHBIY0F1R285TStLcDZ1eTB2OXF1VjZXSWlWckxzblp3RjJLUWhC?=
 =?utf-8?B?aHV5VzNlSWNCZmhrb1lvSFFUdTFMaXlpWTJsWk9KbXc1MWU5M1BHV0ZLOUQ5?=
 =?utf-8?B?ZUVMZzZXU3ZsQmVkU2RkRVRBOHJ6S2hVU2g4VkxiTW04bC85cWg3dXdpR0g4?=
 =?utf-8?B?RmREQXBKR0pqd3hzSmFKUzFHZUJ1TkgwQ1dqYkVPNXZMQ1V1eS9vR25mbU41?=
 =?utf-8?B?Q2NZRnBYYmhTNDZhQ1Z6MXgzWTRlOHRJaytOSWptTGxMdXRFUUwvdHpmajMx?=
 =?utf-8?B?OU5wSzNVRW0rQWdoM1BxdFdwQ1lrM2huN2RWV1hQOTQ4QzludjhSdGZ3VHNr?=
 =?utf-8?B?U3J4aDF3NWlvZDdOSTZYN0xDRTE3akp1bnRmRDlrR0JFRkQrKy81RjlDYnJL?=
 =?utf-8?B?R2NaKzdscHE5ZkpEWUdoRHpzZEpCQkxLb3hCKzdUNE9YMGlQeGhkNzF2UElR?=
 =?utf-8?B?eXNBa0RjcEU4VDdaOWtCbHYzVmlscWllbk1MaFMvRURyNHg1NHNmZHdpQklK?=
 =?utf-8?B?Z082ZGY5UFM3c2tSUjFsbzVEVGErc0lpalpGaU82V2hlT3d2a1crREtRSFhn?=
 =?utf-8?B?bjBOZm81dzZMYVlQN3A1UjU3UXUyWWJsNW42Zm1rZ0lOa1BqeFIzYTBwZ2JL?=
 =?utf-8?B?VmRpRXZveU5mZEcycTlKWlJScGNGamZ0aThEeDlaYmtvN3pIdW9zcGg0UkZk?=
 =?utf-8?B?bi9aSksxZWlIUHNsRTllNURxTmozNWgraDVBSVZ5NVhHODkvMFJnbUh1eWpI?=
 =?utf-8?B?dFF3SU9vYlcxS25KVVdEL3E4SDVJbGZoWGR2elhkSFUrQVJVMU1BalpEcFRh?=
 =?utf-8?B?UklLdzVsT3lJbXdFV0M5Um1DZktKZWVNVi90Nk54UCtJQTFaUXBrQUFQSlZC?=
 =?utf-8?B?dnZqbENYdWJhTE5LSUg1VkU2WFJzZTlPSG1zbzFINmQ3VEQrQ2NzcTNoa3RU?=
 =?utf-8?B?Mk0vb3dtNVJHa2lTTTZqT0tsVDVLeWNBNU5KOEhIL3ZQVVpGeUhCOGNBZndU?=
 =?utf-8?B?VlFKWGRGWVVNQWtPOXRWdUp4Z2ZXV2hGbXJieFBXbXFST1pPKzQ0d2lHek5y?=
 =?utf-8?B?b1V0RmJ0VnJuOUlObnltRzJyT2dCbVhPcHE1V1dTMG9TVjl0QUF5OFA1QVdy?=
 =?utf-8?B?RXVCd1JQdTJRTG9Jd0Qrcmt2YWpMdG1yOXVYdE9oMlpmZDl2NmxjVXdWVXJM?=
 =?utf-8?B?WnVlZUtZUVZTM1FBM3diVEVDVFNwUEQvVHRXRkxZQjE3cXFHNUpqK2lOd01B?=
 =?utf-8?B?RUN2TjFsSnVvaHdaZjQycGNFK3AvRDFXTFhlNjdGYmRMV21Xd09iMWw5RkZu?=
 =?utf-8?B?cm4rVHl6VnFXSzZBRnhmRGg4R3ZsWkJYWXozTHJPaG9MYmc2VFZjanp4bkZT?=
 =?utf-8?B?eTJhaC8yTWowWThRQzB2QlVxblorN2hNSWJ2TjBsS2hSUFo3MlphbjdkbnlD?=
 =?utf-8?Q?3uYgTAp/XtDrlr3nR/hqc1F77zgwZxoRc//GD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F96A89DE447114D87CA30063C730431@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c159b07d-5585-4222-d85f-08da2233553d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 18:35:09.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjYaSJCFljUFmxz3/7DF2OTsNhjlUleK/USbpkogQROuKQmu9ugqJidMWHkDCwRZStW+PvnhfrdhfP6Q8jHLP0v4q1opBOM9bZEHOg/Dk/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5393
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

T24gVHVlLCAyMDIyLTA0LTE5IGF0IDIwOjQ2ICswMzAwLCBHcnVtYmFjaCwgRW1tYW51ZWwgd3Jv
dGU6Cj4gT24gVHVlLCAyMDIyLTA0LTE5IGF0IDEzOjMzICswMjAwLCBUb2tlIEjDuGlsYW5kLUrD
uHJnZW5zZW4gd3JvdGU6Cj4gPiAiR3J1bWJhY2gsIEVtbWFudWVsIiA8ZW1tYW51ZWwuZ3J1bWJh
Y2hAaW50ZWwuY29tPiB3cml0ZXM6Cj4gPiAKPiA+ID4gT24gVHVlLCAyMDIyLTA0LTE5IGF0IDA5
OjQxICswMzAwLCBHcnVtYmFjaCwgRW1tYW51ZWwgd3JvdGU6Cj4gPiA+ID4gSGkgVG9rZSwKPiA+
ID4gPiAKPiA+ID4gPiBPbiBUdWUsIDIwMjItMDQtMTkgYXQgMDY6MjQgKzAwMDAsIENvZWxobywg
THVjaWFubyB3cm90ZToKPiA+ID4gPiA+IE9uIE1vbiwgMjAyMi0wNC0xOCBhdCAxMzozNiArMDIw
MCwgVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIHdyb3RlOgo+ID4gPiA+ID4gPiBIaSBMdWNhCj4g
PiA+ID4gPiAKPiA+ID4gPiA+IEhpIFRva2UsCj4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gSSd2ZSBz
dGFydGVkIHNlZWluZyBpc3N1ZXMgd2l0aCBteSBpd2x3aWZpIGludGVyZmFjZSBnb2luZyBhd2F5
IGFmdGVyCj4gPiA+ID4gPiA+IHN1c3BlbmQuIEkgZ2V0IGVycm9ycyBsaWtlIHRoZXNlIGluIGRt
ZXNnOgo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gWzEwNDM5My4xNDIyNjRdIHdsYW4wOiBkZWF1
dGhlbnRpY2F0aW5nIGZyb20gNGM6NjA6ZGU6ZWE6Yjg6NTggYnkgbG9jYWwgY2hvaWNlIChSZWFz
b246Cj4gPiA+ID4gPiA+IDM9REVBVVRIX0xFQVZJTkcpCj4gPiA+ID4gPiA+IFsxMDQzOTMuMzQ3
Nzc1XSBpd2xtZWkgMDAwMDowMDoxNi4wLTEzMjgwOTA0LTc3OTItNGZjYi1hMWFhLTVlNzBjYmIx
ZTg2NTogQ291bGRuJ3QgZ2V0Cj4gPiA+ID4gPiA+IEFDSwo+ID4gPiA+ID4gPiBmcm9tCj4gPiA+
ID4gPiA+IENTTUUgb24gSE9TVF9HT0VTX0RPV04gbWVzc2FnZQo+ID4gPiA+ID4gPiBbMTA0Mzkz
LjM0Nzg3Nl0gaXdsbWVpIDAwMDA6MDA6MTYuMC0xMzI4MDkwNC03NzkyLTRmY2ItYTFhYS01ZTcw
Y2JiMWU4NjU6IGZhaWxlZCB0byBzZW5kCj4gPiA+ID4gPiA+IHRoZQo+ID4gPiA+ID4gPiBTQVBf
TUVfTVNHX0NIRUNLX1NIQVJFRF9BUkVBIG1lc3NhZ2UgLTE5Cj4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiBBbmQgd2hlbiB0aGUgaG9zdCBjb21lcyBiYWNrIHVwLCB0aGVyZSBpcyBubyBjb25uZWN0
aXZpdHkuIFJlc3RhcnRpbmcKPiA+ID4gPiA+ID4gaXdkIGZpeGVzIHRoZSBwcm9ibGVtLgo+ID4g
PiA+ID4gPiAKPiA+ID4gPiA+ID4gVGhpcyBpcyBvbiBhIDUuMTcuMyBrZXJuZWwgKEFyY2ggTGlu
dXggZGlzdHJpYnV0aW9uIGtlcm5lbCksIGFuZCBsc3BjaQo+ID4gPiA+ID4gPiBzYXlzIHRoZSBX
aUZpIGRldmljZSBpcyBhbiAiSW50ZWwgQ29ycG9yYXRpb24gV2ktRmkgNiBBWDIwMSIuCj4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiBBbnkgaWRlYXM/IDopCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFRo
aXMgc2VlbXMgdG8gYmUgcmVsYXRlZCB0byBpd2xtZWksIHNvIEkgYWRkZWQgRW1tYW51ZWwgdG8g
dGhlIHRocmVhZC4KPiA+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IENhbiB3ZSBoYXZlIHRoZSBm
dWxsIGRtZXNnIG91dHB1dD8KPiA+ID4gPiBXaGF0IE5JQyAvIHBsYXRmb3JtIGRvIHlvdSBoYXZl
Pwo+ID4gPiA+IERvIHlvdSBoYXZlIEFNVCBjb25maWd1cmVkIGluIHRoZSBCSU9TPwo+ID4gPiA+
IERpZCB5b3UgZW5hYmxlIHdpcmVsZXNzIG9wZXJhdGlvbiBpbiBBTVQ/Cj4gPiA+IAo+ID4gPiBB
aCAtIHRoaXMgaXMgQVgyMDEsIG9rLCBidXQgSSBzdGlsbCBuZWVkIHRoZSBwbGF0Zm9ybSBhbmQg
dGhlZnVsbCBkbWVzZyA6LSkKPiA+IAo+ID4gSXQncyBhIExlbm92byBUaGlua1BhZCBYMSBDYXJi
b24gR2VuIDksIG1vZGVsIDIwWFhTM0hDMjY7IEFNVCBpcyBzZXQgdG8KPiA+ICJEaXNhYmxlZCIg
aW4gdGhlIEJJT1MuIEkgcmVib290ZWQgYW5kIGRpZCBhIHN1c3BlbmQvd2FrZSBjeWNsZSBhZnRl
cgo+ID4gY29ubmVjdGluZyB0byB0aGUgV2lGaSBuZXR3b3JrLCB3aGljaCBwcm9kdWNlZCB0aGUg
ZG1lc2cgYmVsb3cuCj4gCj4gVGhhbmtzLgo+IFRoaXMgaXMgYSBTa3lsYWtlIHBsYXRmb3JtIGFu
ZCB3ZSBkaWRuJ3QgaGF2ZSBhIGhhbmRzaGFrZSB3aXRoIENTTUUgd2hpY2ggaXMgbm90IGVuYWJs
ZWQuIFdlIGFyZQo+IG1pc3NpbmcgYSBjaGVjayBiZWZvcmUgd2Ugc2h1dCBkb3duIGl3bG1laS4K
CkhtLi4uIG5vLCB0aGF0IHNlZW1zIHRvIGJlIDExdGggZ2VuZXJhdGlvbi4uLiBzbyBUaWdlckxh
a2U/CkJ1dCBzdGlsbCwgdGhlIGZpeCBiZWxvdyBzZWVtcyByZWxldmFudC4KCj4gQ2FuIHlvdSBj
aGVjayB0aGlzPwo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL21laS9tYWluLmMKPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkv
bWVpL21haW4uYwo+IGluZGV4IDhkNjEwNDRhNmVkMy4uN2I0NTM4MmM4MTNjIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL21haW4uYwo+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbWVpL21haW4uYwo+IEBAIC0xOTIz
LDI5ICsxOTIzLDMzIEBAIHN0YXRpYyB2b2lkIGl3bF9tZWlfcmVtb3ZlKHN0cnVjdCBtZWlfY2xf
ZGV2aWNlICpjbGRldikKPiDCoAo+IMKgwqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJml3bF9tZWlf
bXV0ZXgpOwo+IMKgCj4gLcKgwqDCoMKgwqDCoCAvKgo+IC3CoMKgwqDCoMKgwqDCoCAqIFRlbGwg
Q1NNRSB0aGF0IHdlIGFyZSBnb2luZyBkb3duIHNvIHRoYXQgaXQgd29uJ3QgYWNjZXNzIHRoZQo+
IC3CoMKgwqDCoMKgwqDCoCAqIG1lbW9yeSBhbnltb3JlLCBtYWtlIHN1cmUgdGhpcyBtZXNzYWdl
IGdvZXMgdGhyb3VnaCBpbW1lZGlhdGVseS4KPiAtwqDCoMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKg
wqDCoMKgIG1laS0+Y3NhX3Rocm90dGxlZCA9IGZhbHNlOwo+IC3CoMKgwqDCoMKgwqAgaXdsX21l
aV9zZW5kX3NhcF9tc2cobWVpLT5jbGRldiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNBUF9NU0dfTk9USUZfSE9TVF9HT0VTX0RPV04p
Owo+ICvCoMKgwqDCoMKgwqAgaWYgKGl3bF9tZWlfaXNfY29ubmVjdGVkKCkpCj4gK8KgwqDCoMKg
wqDCoCB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogVGVsbCBDU01FIHRoYXQgd2UgYXJlIGdvaW5nIGRvd24gc28g
dGhhdCBpdCB3b24ndCBhY2Nlc3MgdGhlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIG1lbW9yeSBhbnltb3JlLCBtYWtlIHN1cmUgdGhpcyBtZXNzYWdlIGdvZXMgdGhyb3VnaCBp
bW1lZGlhdGVseS4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWVpLT5jc2FfdGhyb3R0bGVkID0gZmFsc2U7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXdsX21laV9zZW5kX3NhcF9tc2cobWVpLT5jbGRl
diwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBTQVBfTVNHX05PVElGX0hPU1RfR09FU19ET1dOKTsKPiDCoAo+
IC3CoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IFNFTkRfU0FQX01BWF9XQUlUX0lURVJBVElP
TjsgaSsrKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFpd2xfbWVpX2hv
c3RfdG9fbWVfZGF0YV9wZW5kaW5nKG1laSkpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGZvciAoaSA9IDA7IGkgPCBTRU5EX1NBUF9NQVhfV0FJVF9JVEVSQVRJT047IGkrKykgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWl3bF9tZWlf
aG9zdF90b19tZV9kYXRhX3BlbmRpbmcobWVpKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXNsZWVwKDUpOwo+IC3CoMKgwqDCoMKgwqAgfQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtc2xlZXAoNSk7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgCj4gLcKgwqDCoMKgwqDCoCAvKgo+
IC3CoMKgwqDCoMKgwqDCoCAqIElmIHdlIGNvdWxkbid0IG1ha2Ugc3VyZSB0aGF0IENTTUUgc2F3
IHRoZSBIT1NUX0dPRVNfRE9XTiBtZXNzYWdlLAo+IC3CoMKgwqDCoMKgwqDCoCAqIGl0IG1lYW5z
IHRoYXQgaXQgd2lsbCBwcm9iYWJseSBrZWVwIHJlYWRpbmcgbWVtb3J5IHRoYXQgd2UgYXJlIGdv
aW5nCj4gLcKgwqDCoMKgwqDCoMKgICogdG8gdW5tYXAgYW5kIGZyZWUsIGV4cGVjdCBJT01NVSBl
cnJvciBtZXNzYWdlcy4KPiAtwqDCoMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgwqDCoMKgIGlmIChp
ID09IFNFTkRfU0FQX01BWF9XQUlUX0lURVJBVElPTikKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBkZXZfZXJyKCZtZWktPmNsZGV2LT5kZXYsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJDb3VsZG4ndCBnZXQgQUNLIGZyb20gQ1NNRSBvbiBI
T1NUX0dPRVNfRE9XTiBtZXNzYWdlXG4iKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvKgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJZiB3ZSBjb3VsZG4ndCBt
YWtlIHN1cmUgdGhhdCBDU01FIHNhdyB0aGUgSE9TVF9HT0VTX0RPV04KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogbWVzc2FnZSwgaXQgbWVhbnMgdGhhdCBpdCB3aWxsIHByb2Jh
Ymx5IGtlZXAgcmVhZGluZyBtZW1vcnkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogdGhhdCB3ZSBhcmUgZ29pbmcgdG8gdW5tYXAgYW5kIGZyZWUsIGV4cGVjdCBJT01NVSBlcnJv
cgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBtZXNzYWdlcy4KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGkgPT0gU0VORF9TQVBfTUFYX1dBSVRfSVRFUkFUSU9OKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZtZWktPmNsZGV2LT5kZXYs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAiQ291bGRuJ3QgZ2V0IEFDSyBmcm9tIENTTUUgb24gSE9TVF9HT0VTX0RPV04gbWVz
c2FnZVxuIik7Cj4gK8KgwqDCoMKgwqDCoCB9Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoCBtdXRleF91
bmxvY2soJml3bF9tZWlfbXV0ZXgpOwo+IMKgCj4gCj4gQWx0aG91Z2ggSSB0aGluayBpdCdsbCBq
dXN0IGZpeCB0aGUgZXJyb3IgcHJpbnQgYW5kIG5vdGhpbmcgbW9yZSB0aGFuIHRoaXMKPiAKCg==
