Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7150864A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 12:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376909AbiDTKu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377814AbiDTKuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 06:50:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E863FBE6
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 03:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650451657; x=1681987657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LCEwMZeXUqX0yZOzJb12gEqTfHhSiC8QrdKkloZvu2g=;
  b=Lmlzd0ydfZeJkmknl4iX+c7SYTXhyVPwkFMtlb0OzJB82odJu5jRjj8V
   cgn5l0eyNCAtgva9wx8+xlEuucpqaejev9K7tG4NRCDNFKH8uxZo9k4hO
   MlvrxQM58Am5/CmLG6tGdPtlmBAJ6lvtOWLP6WTFdWLwmod/8/3z6aG9N
   Lv4VqhJRL0iPEEA6trOejtUzFborPHTB4RixqNNKBSmKaStSrUdvSdOwY
   Rl4pSmas0At9xOOUP5iJ8mi2TFtJT00RR8ZYKHxS42t/bqO1ls+XRDiB+
   OP8ovotSF6J+gNnzIeN9mruHwyEcvh9cOqEHXFyqWOnxfAoFmDEo80CYe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245890262"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="245890262"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 03:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="658016220"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2022 03:47:36 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 03:47:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 20 Apr 2022 03:47:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Apr 2022 03:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAyWEcqIesjsefExpC4RwkEbx6IIbcGDTaeST79T0+D0hqToA3Lh/QZeiyaxN66tPc025JLvHYsjlPukVzA63sPDTJ6oDKLn7tpxAAuwap3+KhRJ/Cfx+2wNA2uaiLJ+QvPbT0iOdV0hlmMVIq7kuXq7ABz8b1kD1ZxVFCJsUp8oDiCnFkNm3F4+xcvAhKSsZ2Uc9KCsqCuZuD0pQrkFdEOSvWwOvB0nn5Hc7E9Uy42jR0/0A71RbR+xA17b85WN3S/Qql+sTdkDQE5ZswwJHJztQsFeoSHk/RJYjzvs0FYe/juiSK63wbXdJtC20/yDwHPXNppAiTtXRxJWiaE5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCEwMZeXUqX0yZOzJb12gEqTfHhSiC8QrdKkloZvu2g=;
 b=KqFSmBDF6cGGGEkmWBVuJ/L0/OabrGW8mKz+UAI7chz3rSpcriKlW38vNL3M8BcH2eeg/sk6MJn6AzQjt8Om/4phQfYh26UKFRgD+CURP0/w3aS8XF/nuJTnaNGLXDWhPpEVgnlySNISBhWZq2a7HaCXYlJrp8J4IoYuSN3YO7zq1Wpf8zus/UulkZkKoZtU4KUcq64MPXqAz85AibWE/qRH+JngXqp6VYvaZ57dnvYnWtr3aEBsuMb/vqj19uNeeI/cW6tecpwKPmecHqmNVvH08fL18A7Hi53hqFKlu6EPFCzqNmwA8BX3DgdhiAmnAMOmdNamQ8UzCfC7matm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by SN6PR11MB2797.namprd11.prod.outlook.com (2603:10b6:805:5a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 10:47:34 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 10:47:34 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "toke@toke.dk" <toke@toke.dk>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYUxiO5laT20cdFkKz0kQ4shKh3az2xgSAgAAE2ICAAARFAIAATT6AgABoR4CAAA2LgIAAKBQAgACDLgCAAFQogIAAEEcA
Date:   Wed, 20 Apr 2022 10:47:34 +0000
Message-ID: <724999bde562fedea5933cbe7bc949da796b2f30.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
         <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
         <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
         <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
         <87mtghs3y2.fsf@toke.dk>
         <e0872b6f468bfda08717214044b64187f71b4e18.camel@intel.com>
         <94b98b712b86690dd5ae19df0cc608b8193be1f3.camel@intel.com>
         <877d7kn62t.fsf@toke.dk>
         <a8b437f1fc466096f119298ae1562c2aa224ad95.camel@intel.com>
         <87o80whyoy.fsf@toke.dk>
In-Reply-To: <87o80whyoy.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b1aaf58-8620-4a75-23fa-08da22bb2d7b
x-ms-traffictypediagnostic: SN6PR11MB2797:EE_
x-microsoft-antispam-prvs: <SN6PR11MB27978FC59FCD508156B26052F2F59@SN6PR11MB2797.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L1VlQfdPYVTKa/9hNq8SmUDuAvyfQFtJdlYHUpUxtcspqWYh+fDHSJhIFfTvsDBEtHuTghC6V2o4WVEK/lwZs+Ui6lNsg2lKAFe7XBHqtsH63dtes8po8o4oSxU/M+2tw3F6z1HZ3EZAR/tqlbWPtOCrzLuAe9Zbcy+gW1GlQcgBAYhCFRQ8xRalWoeaPiILWVSHO27nMrJIQe4QsuV6LjvtbEZKubGq9/fSxbq+zp8ksnkccXdHHhKLi8SGpXBdCgY0LjVEqz5cP6THMQNxZOt7+CwaRHVsCpP3ptVLq6fTaP6kCIHMGEx7euHBzfpvuAi/YLipe9hiSUBwLVgsOoiEG1XLO9wVkAmIzEvHsLTiV+wYYXdVAnot311zJV1XkEOqQtHiziPgXyJX2lD5c/Uyg8GlEOacInBao2v7vRGR1Sbc+GUWgX93j6TvQMQetlX1IcpfZUNVD4ehBCTRqmHg2ns8KvVQ3+KMZwNEMf393NtGZduaYw2wO/zpx160dZBwAsQ+cGb3fD4JLnR8umT/Mtu7ohf5UOpm+/i8iK5jkB80exdZX3TpD5HxfZe0XAoV1navr0jbIot/n+vKgrB9uaVaGAQqTIZBdCToAAwAtixXdWm7dENkFFW2QKOGNGvDOeQGKqeTsowuWzKWmW8XOS2Jy0M5C1pKz7JCN+tEg/jPw1va/e5wFRQ2AAlhr2OLrDilPOBZ1BIvAlzxWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(2616005)(4326008)(91956017)(64756008)(66446008)(186003)(15650500001)(76116006)(508600001)(71200400001)(6512007)(66574015)(8676002)(26005)(54906003)(6506007)(316002)(86362001)(6916009)(6486002)(36756003)(2906002)(66556008)(66946007)(5660300002)(8936002)(82960400001)(83380400001)(66476007)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjVnM1lCbWhmMExZTHRwaUVxaHB6YlAreDVNU2RrcXhYZ2RaMHRJbUk4eHQ4?=
 =?utf-8?B?OHNTV2RpRyt6ZGE1Ty90azJaNTcyLzNhd0JVdGZlNjFvN3FCMWZsTzFTOGNT?=
 =?utf-8?B?N1ZyT21MNERTODJNWE44MlBCOHplWHZnY2hOQUxKaUl2ODV0WVk5V0pqclVN?=
 =?utf-8?B?NCtRdm1UMkZ3WTRrU2wvR2xPZnlhc0srL0UrVkppdXRURFBoa0ZxWDlNTWlJ?=
 =?utf-8?B?TXNnR0pEMWpPeVhybnYxd0lRL3JBOEJSSDU2dmkvWkl5ZlB5dzkwUmdndDA2?=
 =?utf-8?B?dGFkTk5uRGhwMUE0OEEyUGUvb0dtSDBycCt3QTJJVzBXSnpmSEN2UU9qbEli?=
 =?utf-8?B?RUNRcHhSaks4c0NCMUJ1M21LUTFRdlJybVcwUm1VQU4zbjdkUWE5QzBOZjFl?=
 =?utf-8?B?OW9GWGJPb3NvQzNlcGMvcE5PeUdWQUhQNDUrNnRwU3JwRmlaSHVBT2pvejBX?=
 =?utf-8?B?cG81ZUlERTZaR3RzWUpydnMyZnJGMEp6MXdMM0Q3cTh6bGpLMG1hV3BEdkxO?=
 =?utf-8?B?Z3JwbDFZWTFVbkdEazVkbWdCdTNtOGp3Sk1NcVhDMkNaYjhoZ0NJT0dJYzd6?=
 =?utf-8?B?cSszR09sMFZCWXpabjUrcnRlblM4TzJZR3MyMWk5cm0rR3V4bGhKcHJ3N0k5?=
 =?utf-8?B?YXlNK1M3MVlTK1BYcUVYOXpueno0V05iWWtadHF5ZGFSdGxrTTdOMlZmbFYr?=
 =?utf-8?B?MmljcE83NkNyUG5wcjJJQmN4NS9iNU9JZUY2eUt0QU4rMk5jMGVtRTJBZ3Bs?=
 =?utf-8?B?MUpka2tOOFBRN3VmOGdvckVHcGhrcXQvbklDSjUzaXNEWFQ5WnEvRmFjUTFU?=
 =?utf-8?B?bWtDcDk4eTZOVWlNRjBpSkpIUnVTNXdOL2V0UVB5REJVcThPT0JKTEZVZTg0?=
 =?utf-8?B?Z2tNWEdmdURsWFdqNjY4MUdUdi9PbG1RME1KeEh6dnMzc0VSWUlqc0JSMFk5?=
 =?utf-8?B?QndUcVZqSjhLNEY4Vk50RHhMMWFoengxS0s5Vmp3OVNwL1ppOVc2Y2lvMHF2?=
 =?utf-8?B?eEVFeEMxajhLK3dXVldnR2FUQ1BzVFpZWVl1YUJ5UHBsa0lUOEt4eVBRZEpr?=
 =?utf-8?B?RytwdWdDS2JvV25KbWtXdjB2QjB4eUR2c1VtU28rOE4zbDMrcGYxKzU1R0Zl?=
 =?utf-8?B?U25qSXhzdDlEcWlYSC94TkNRbWxZMEN4dE02eE9EL1pNbkdveXJGWXorbmgx?=
 =?utf-8?B?N0JvNTl6R3MzQjd6TloxcjBlbFYxcXMvVzJTZTg1UkNTb3dtVFljc3JJMFE2?=
 =?utf-8?B?KzBPYTdsc3NCS2ZzaGtwcjZ6c0NaU0drS0NqVi82QUhuRk1KTi91ZUg2cUUv?=
 =?utf-8?B?MkJGcjFvL2FPd1hhQTZuUEs4TUp2NkhyMXNPeUEyK3RhaGdHRWhaY3d5UzRo?=
 =?utf-8?B?YUI1dWlodVJCOUdhWTg2eWNaMUt6ZDZDaHJzTjVZZVE2bGdDZksrbmlvMDQ3?=
 =?utf-8?B?R0tidkNsU2ZXRUwyT1JjR2xrNFUvRjZoWDNxL2lnbWJLUnc1TTVjOE9SOEJZ?=
 =?utf-8?B?RVRua253bHVlcEZDWDM4ZndrNDM2dUlvaW4wWVYwTk8xOHFrMTFUOG9BUkQ4?=
 =?utf-8?B?WERLTVdOTEFYT09YWENhSFV4cDNxZ0JUb2hibFlRNWY3Nk96aE5XdUc1d0lF?=
 =?utf-8?B?Ym9FRS9NR1hESDRCbDB4VDNFakJzTzFraWp2azBZUjkra0F3aVFxam9IZEdB?=
 =?utf-8?B?OFNYS0JJMnNvYW9vQ3dCUHEyV0dGOW5qakRXZllRUGZBbk1sbmd2MUMxZHVq?=
 =?utf-8?B?K1JvM3lTKzJFK2JOMVU2RHV0QXNXMzVYd3hNR0IweEtkMXRWUW93SEZjYVQ4?=
 =?utf-8?B?dzdkcjd5NkplQ1NWMS9DcTNuKzVab0VLTHo0MWhPeUNmVEJjemlsU0hpWVFM?=
 =?utf-8?B?U2xpeWNwY2ZYS3UyVnNONlAwVHZnbGw1VUF3YnBVYko3QW5JcnhBMGt2Uktx?=
 =?utf-8?B?RzFEZXpwaGNSNXIzRXBKWkFGcUV5VXR2azd2UUlRZWJidFRrenhMMDdrRlo4?=
 =?utf-8?B?Yk9tRWs2WlhiV1JRQk1hVWExc2l1dVo5VXNycDErUmRKSWV3ay9KczNBWE9G?=
 =?utf-8?B?MTQ1OGtLWFpsRy9sd0xNUUY0cGgyUTZDRGV1S0Rqc0NPcGxmWmNPelYrNENw?=
 =?utf-8?B?c0djeGZwd1A3enpFWWxUMHNrZ0NDN0ZzamE2ZkRGUzVadmJRUEFDSU9odW9B?=
 =?utf-8?B?NWFta3pRSTlqUGVZYzdJamh3MUFWeVJnMlNrN21aSXNiOFh2MTZKYkwvaTEy?=
 =?utf-8?B?QlZuV3JSbEl6VEs4VnhJeTdsVC80VVBOYVpKRzF2QVNWWmxXMXNvcFRSTXlx?=
 =?utf-8?B?WkI1dm45WDdLbXpQZ1dNeHFlRURLcGk5N29oQlNwbmpTVmdZS25qM3NRN3pK?=
 =?utf-8?Q?Iv8uSgfx/gYTg1sO4QNRFc5nB5fy856bTV//k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54C4531BAD3EDC4AA256D856EE60B0BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1aaf58-8620-4a75-23fa-08da22bb2d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 10:47:34.2682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivrRVtCoeYuImKHt8MKwOrW7IFXjVHj+IAovbEbetz3DBfVaYbghTaNf6h4daYfDtk2KJVCXOdVK3OTNdBFoSQYFRim8rZ7K2h+BpIGkcpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2797
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cmVtb3ZpbmcgTHVjYQ0KDQpPbiBXZWQsIDIwMjItMDQtMjAgYXQgMTE6NDkgKzAyMDAsIFRva2Ug
SMO4aWxhbmQtSsO4cmdlbnNlbiB3cm90ZToNCg0KDQo8c25pcD4NCg0KPiA+ID4gDQo+ID4gDQo+
ID4gU28geW91IGRvIGdldCBhIFNBUCBjb25uZWN0aW9uLiBXZWlyZC4NCj4gPiBDaGVja2luZyB3
aXRoIHRoZSBDU01FIGd1eXMuDQo+ID4gQ2FuIHlvdSBnZXQgZHluYW1pYyBkZWJ1ZyBwcmludHMg
Zm9yIGl3bG1laSBtb2R1bGU/DQo+ID4gQmVzdCB3b3VsZCBiZSB0cmFjaW5nIHdpdGggLWUgaXds
bWVpX3NhcF9jbWQNCj4gDQo+IFN1cmUhIFJlY29yZGVkIHRoZXNlIHdoaWxlIGRvaW5nIGEgc3Vz
cGVuZC1yZXN0b3JlLCB0aGVuIHJlc3RhcnRpbmcgaXdkOg0KPiANCj4gwqAga3dvcmtlci91MTY6
MzQtMzQ1NTUgWzAwNF0gNDY0NTIuNTA2MjM4OiBpd2xtZWlfc2FwX2NtZDrCoMKgwqDCoMKgwqAg
c2FwX2NtZCBUeDogdHlwZSAxMDEwIGxlbiA4IHNlcQ0KPiAxMQ0KPiDCoCBrd29ya2VyL3UxNjoz
NC0zNDU1NSBbMDA0XSA0NjQ1Mi41MDYyNDM6IGl3bG1laV9tZV9tc2c6wqDCoMKgwqDCoMKgwqAg
TUUgbWVzc2FnZTogVHg6IHR5cGUgMyBzZXEgOA0KPiDCoCBrd29ya2VyL3UxNjozNC0zNDU1NSBb
MDA0XSA0NjQ1Mi41NTk0MDc6IGl3bG1laV9zYXBfY21kOsKgwqDCoMKgwqDCoCBzYXBfY21kIFR4
OiB0eXBlIDEwMDEgbGVuIDQgc2VxDQo+IDEyDQo+IMKgIGt3b3JrZXIvdTE2OjE0LTMzMzExIFsw
MDRdIDQ2NDUyLjU3MzA3NzogaXdsbWVpX3NhcF9jbWQ6wqDCoMKgwqDCoMKgIHNhcF9jbWQgVHg6
IHR5cGUgMTAwNiBsZW4gMCBzZXENCj4gMTMNCj4gwqAga3dvcmtlci91MTY6MTQtMzMzMTEgWzAw
NF0gNDY0NTIuNTczMDc4OiBpd2xtZWlfbWVfbXNnOsKgwqDCoMKgwqDCoMKgIE1FIG1lc3NhZ2U6
IFR4OiB0eXBlIDMgc2VxIDEwDQo+IMKgwqDCoMKgIGt3b3JrZXIvNDowLTM0MzA1IFswMDRdIDQ2
NDUyLjcwNjczNzogaXdsbWVpX21lX21zZzrCoMKgwqDCoMKgwqDCoCBNRSBtZXNzYWdlOiBUeDog
dHlwZSAzIHNlcSAxMQ0KPiDCoMKgIGt3b3JrZXIvdTE2OjgtMzQ0NjIgWzAwMF0gNDY0NTcuOTM5
NDUzOiBpd2xtZWlfbWVfbXNnOsKgwqDCoMKgwqDCoMKgIE1FIG1lc3NhZ2U6IFR4OiB0eXBlIDEg
c2VxIDENCj4gwqDCoMKgwqAga3dvcmtlci80OjItMzIxOTYgWzAwNF0gNDY0NTcuOTQwOTEwOiBp
d2xtZWlfbWVfbXNnOsKgwqDCoMKgwqDCoMKgIE1FIG1lc3NhZ2U6IFJ4OiB0eXBlIDIgc2VxIDgx
DQo+IMKgwqDCoMKgIGt3b3JrZXIvNDoyLTMyMTk2IFswMDRdIDQ2NDU3Ljk0MDkxMjogaXdsbWVp
X3NhcF9jbWQ6wqDCoMKgwqDCoMKgIHNhcF9jbWQgVHg6IHR5cGUgMTAxMyBsZW4gMCBzZXEgMQ0K
PiDCoMKgwqDCoCBrd29ya2VyLzQ6Mi0zMjE5NiBbMDA0XSA0NjQ1Ny45NDA5MTM6IGl3bG1laV9t
ZV9tc2c6wqDCoMKgwqDCoMKgwqAgTUUgbWVzc2FnZTogVHg6IHR5cGUgMyBzZXEgMg0KPiDCoMKg
wqDCoCBrd29ya2VyLzQ6Mi0zMjE5NiBbMDA0XSA0NjQ1Ny45NDIwNTY6IGl3bG1laV9tZV9tc2c6
wqDCoMKgwqDCoMKgwqAgTUUgbWVzc2FnZTogUng6IHR5cGUgMyBzZXEgODINCj4gwqDCoMKgwqAg
a3dvcmtlci80OjItMzIxOTYgWzAwNF0gNDY0NTcuOTQyMDYwOiBpd2xtZWlfc2FwX2NtZDrCoMKg
wqDCoMKgwqAgc2FwX2NtZCBSeDogdHlwZSA1MDIgbGVuIDQgc2VxIDENCj4gwqDCoMKgwqAga3dv
cmtlci80OjItMzIxOTYgWzAwNF0gNDY0NTguMDQyMjA1OiBpd2xtZWlfbWVfbXNnOsKgwqDCoMKg
wqDCoMKgIE1FIG1lc3NhZ2U6IFJ4OiB0eXBlIDMgc2VxIDgzDQo+IMKgwqDCoMKgIGt3b3JrZXIv
NDoyLTMyMTk2IFswMDRdIDQ2NDU4LjA0MjIwODogaXdsbWVpX3NhcF9jbWQ6wqDCoMKgwqDCoMKg
IHNhcF9jbWQgUng6IHR5cGUgNTAwIGxlbiAxODk2IHNlcQ0KPiAyDQo+IMKgwqDCoMKgIGt3b3Jr
ZXIvNDoyLTMyMTk2IFswMDRdIDQ2NDU4LjA0MjIwOTogaXdsbWVpX3NhcF9jbWQ6wqDCoMKgwqDC
oMKgIHNhcF9jbWQgUng6IHR5cGUgNTEyIGxlbiA2NCBzZXEgMw0KPiDCoMKgwqDCoCBrd29ya2Vy
LzQ6Mi0zMjE5NiBbMDA0XSA0NjQ1OC4wNDIyMTQ6IGl3bG1laV9zYXBfY21kOsKgwqDCoMKgwqDC
oCBzYXBfY21kIFJ4OiB0eXBlIDUwMiBsZW4gNCBzZXEgNA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaXdkLTM1Mzk2IFswMDNdIDQ2NDY3LjA4NTY0MjogaXdsbWVpX3NhcF9jbWQ6wqDCoMKg
wqDCoMKgIHNhcF9jbWQgVHg6IHR5cGUgMTAwOCBsZW4gOCBzZXEgMg0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaXdkLTM1Mzk2IFswMDNdIDQ2NDY3LjA4NTY0NTogaXdsbWVpX21lX21zZzrC
oMKgwqDCoMKgwqDCoCBNRSBtZXNzYWdlOiBUeDogdHlwZSAzIHNlcSAzDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpd2QtMzUzOTYgWzAwM10gNDY0NjcuMTAyODE4OiBpd2xtZWlfc2FwX2Nt
ZDrCoMKgwqDCoMKgwqAgc2FwX2NtZCBUeDogdHlwZSAxMDA4IGxlbiA4IHNlcSAzDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpd2QtMzUzOTYgWzAwM10gNDY0NjcuMTAzMzY5OiBpd2xtZWlf
c2FwX2NtZDrCoMKgwqDCoMKgwqAgc2FwX2NtZCBUeDogdHlwZSAxMDE2IGxlbiAyMCBzZXENCj4g
NA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXdkLTM1Mzk2IFswMDNdIDQ2NDY3LjEwMzg0
MjogaXdsbWVpX3NhcF9jbWQ6wqDCoMKgwqDCoMKgIHNhcF9jbWQgVHg6IHR5cGUgMTAwMSBsZW4g
NCBzZXEgNQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXdkLTM1Mzk2IFswMDNdIDQ2NDY3
LjEwNDY4OTogaXdsbWVpX3NhcF9jbWQ6wqDCoMKgwqDCoMKgIHNhcF9jbWQgVHg6IHR5cGUgMTAw
MiBsZW4gMTIgc2VxDQo+IDYNCg0KY2FuIHlvdSBwbGVhc2Ugc2VuZCB0aGUgY29udGVudCBvZiB0
cmFjaW5nIHVucGFyc2VkPw0KVGhlcmUgaXMgbW9yZSBiaW5hcnkgZGF0YSB0aGF0IEkgY2FuIHVz
ZS4NCkkgZGVmaW5pdGVseSBuZWVkIHRvIHRhbGsgdG8gdGhlIENTTUUgZ3V5cywgSSBjYW4gc2Vl
IHRoYXQgQ1NNRSBpcyBhbGl2ZSBldmVuIGlmIHlvdSBoYXZlIEFNVA0KZGlzYWJsZWQuDQpQcm9i
bGVtOiBpdCdzIGhvbGlkYXkgc2Vhc29uIGhlcmUuDQoNClRoYW5rcy4NCg0KDQo+IA0KPiBUaGUg
ZG1lc2cgbG9nIGxvb2tlZCBsaWtlIHRoaXMgKGJhY2sgdG8gLTE5IGluIHRoZSBlcnJvcik6DQo+
IA0KPiBbNDY0NTIuNDgzMzQzXSB3bGFuMDogZGVhdXRoZW50aWNhdGluZyBmcm9tIDRjOjYwOmRl
OmVhOmI4OjVhIGJ5IGxvY2FsIGNob2ljZSAoUmVhc29uOg0KPiAzPURFQVVUSF9MRUFWSU5HKQ0K
PiBbNDY0NTIuNjg5NDY1XSBpd2xtZWkgMDAwMDowMDoxNi4wLTEzMjgwOTA0LTc3OTItNGZjYi1h
MWFhLTVlNzBjYmIxZTg2NTogQ291bGRuJ3QgZ2V0IEFDSyBmcm9tDQo+IENTTUUgb24gSE9TVF9H
T0VTX0RPV04gbWVzc2FnZQ0KPiBbNDY0NTIuNjg5NTY3XSBpd2xtZWkgMDAwMDowMDoxNi4wLTEz
MjgwOTA0LTc3OTItNGZjYi1hMWFhLTVlNzBjYmIxZTg2NTogZmFpbGVkIHRvIHNlbmQgdGhlDQo+
IFNBUF9NRV9NU0dfQ0hFQ0tfU0hBUkVEX0FSRUEgbWVzc2FnZSAtMTkNCj4gDQo+ID4gSSBtaWdo
dCBhbHNvIG5lZWQgZHluYW1pYyBkZWJndWcgcHJpbnRzIGZyb20gdGhlIG1laSBidXMgZHJpdmVy
IGJ1dCB0aGF0IHdpbGwgYmUgZm9yIGxhdGVyLg0KPiA+IFRoYW5rcyBmb3IgcmVwb3J0aW5nIGFu
ZCBwcm92aWRpbmcgdGhlIGRhdGEhDQo+IA0KPiBZb3UncmUgd2VsY29tZSEgVGhhbmtzIGZvciBs
b29raW5nIGludG8gaXQgOikNCj4gDQo+IC1Ub2tlDQoNCg==
