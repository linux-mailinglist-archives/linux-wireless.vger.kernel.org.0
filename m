Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCC7644558
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 15:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiLFOLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 09:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiLFOLA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 09:11:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455B39D
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670335859; x=1701871859;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=82W1TMN68ZNw3U6DEp2LhOHjCd3Y5nF8loBDuU7xYME=;
  b=fiUfuR2gZJX6sKMVtf8+yscaBUh3FLLVHCOOc4ltG95QWKw+XVsie7L2
   atwp5/PfmUsh0LueplSrYjoVCkuyBSEat4H7DvoSOHjAghUJxoucayqoc
   wcSKIlVrHpElMcvblji/5htrvOK+kUBpKjLFEym+6XZtHzw65ruMQe07s
   SK/hwc1wNjkXfMZj5tv/y0nmt7Tqmdz0Xe1Y8CKgc/M1Ti5g6Jlmk2gWN
   ezszdNJ3dqHApeeEOgfHLRvQFVMxTBbDojCAimSMoRAWJVdW9rjFANygE
   6mOTPNqAaJLaBI6kGfBE5Sbi7uZnv6Cn2gxv7hDrUhQbncpDGfueC3s+8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="296986022"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="296986022"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 06:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="752649255"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="752649255"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2022 06:10:40 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 06:10:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 06:10:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 06:10:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihEt/wUs49FwMU3cbulLywAoS2mpWocjUuc5R89cLlm+dzhLAkgrW/LA3Drr3i9oeJssIsRl2W7YDtUlfk5/KYpB15C0nggMdlCfObv1e5p5k621HWcM2dSJxHECy8dV1hhgEeeX6NsWwnF0FSejL3q91dyyDzygrc/jxu1edUC2I3shNTbQPTUfuBo89Tb5VgkZrzmM5uaiEoITXDgdIHfy5ioLrmvU611aDV88vXwu5rMV8vwmaEXgEST91XwH7vERvSqgD7TYR/dpPRCqtW4wysg9pefnipeiCuCYt6iWqQOaCmMB/Q6QDE2coUYVRiKydJXGcCbuh58+bH8Lxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82W1TMN68ZNw3U6DEp2LhOHjCd3Y5nF8loBDuU7xYME=;
 b=Os22aMc0FuGGQ8cSLcMMWpz79Fob99cg7kmqG46ZAlhA23vWOO+GvsB8zaWhHIKwN1fcPO/o1PM/aI1nTQl9ipTmgRqSaz1o9d7K+88Z8U21kuCmiecOu9JV0sJ7z4TOs/JcOU1TfvAoljZ0OQ8Pq/rlO9i9Grv6bHAcZSfLgN+N65lLXQ0P31l1NT3d990ZeDzrA639zw/lzbyc0S5Tz5/OocmtRwIjTPaJWKFjbBcLkgG0icE32nA+IahZsg8o+nWme2APvAVhzu9ZqUEOf/WUIem4OwOMz35xom7MenMTn12Dxxj4rJFDCLpGX2C/t+m6+CQwE5RTNKtLNy1guA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SA2PR11MB5066.namprd11.prod.outlook.com (2603:10b6:806:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 14:10:36 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a%8]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 14:10:36 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        greearb <greearb@candelatech.com>
Subject: Re: ax210: Ability to report noise floor?
Thread-Topic: ax210: Ability to report noise floor?
Thread-Index: AQHZCMEhtDRb9XLcqkqDEHngG5lP0K5g532A
Date:   Tue, 6 Dec 2022 14:10:36 +0000
Message-ID: <00a4d194f70c4f4c7b7df38b79c0df40ba87f0aa.camel@intel.com>
References: <a8a2c506-96c8-1850-0585-cda09d4b31f0@candelatech.com>
In-Reply-To: <a8a2c506-96c8-1850-0585-cda09d4b31f0@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SA2PR11MB5066:EE_
x-ms-office365-filtering-correlation-id: dc878ff9-975c-48c7-002e-08dad793a5aa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1KdOZkiK/A/Mcc+yNxitGc2i3RDWAjabDHwRKo3JFMA56A3wXTxFdd4oQgsfY5mmjMprS+7nz1owisZcL5SNZ3I751PjdeSelI0BgK5Uon6KaK65ViH12MXjn1745wA0IjHcai8GgwXKH1YFfivDxiGMjqbPUn+Jl0+ppx4APLGpfj0HubP4A8riP9TkI7jO79q/282QrRDIu06ORevMHCY5eZSCl/5QHaIeV/5sNDSyk/YjRNValul7jBnXb5r+GIVZZzzvSji8vSEqJJPLeTxx324HvDgxqmgJa/lhnUT+JCOxMulv/4u4sVzMn3Y/w3qW9Gx37lRvpsTqyRmmlkHpUegTXnCPEcOcji5XnkvdRxR7AT6Z+/B1dZEscQRhQgm81gCtHw9ZzPatz9ZoFlZXM1wr7Nhz8p8/yvl+K0amkgwVHesBq2G6Xiv5xZSLmdDfbDbowChrTw8sYOsC3eoiYxqfdQ75jnuhsPiVMl7yWPg3OAv+JePlP2ddgGGiinKDpifww8EnsLzVzJCEdfZBX6gAAkNiP7rxufSJryAm3Qq6DcVTRVVvmYbihMzHMQiTTNfyPTYxBwWJqWpeVT6gMIIhiyah/YxB2k4jr5iuLOtePInnHWjcLYjJ4ZP83asp/D4UWjcq/rmtR70KafYXnXVtQgDXfdZHMmbHB9KvJXwabZYkRPrqQ7xYYyClO62xFVS8gL0j3jrEsg5Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(478600001)(71200400001)(82960400001)(6486002)(38100700002)(86362001)(91956017)(122000001)(8676002)(8936002)(38070700005)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(6506007)(5660300002)(6512007)(26005)(110136005)(36756003)(2906002)(186003)(41300700001)(2616005)(316002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MS9FVmRxRlpyakNEemw2STB4bUs5Z2dHZUFybHl4RzkwQkNaWnFYVU51dmFM?=
 =?utf-8?B?bGh0RlBjR0JNUVhJSVUwT1FkQjkvTy9CZDcyQW5GQkI5Zzg3QVgrejlUVmFp?=
 =?utf-8?B?UUZNUVlHYUNXL2R6NWRadmlxNTJuYkgzZzgwTitvSzFFcXNzOFRSZWhlbG9F?=
 =?utf-8?B?QVZ3bS9NUXFIeG4wKzZtU3M2WU5tYTZEQ1pLa1UvV0RnRGhrSUwvS0tBVndE?=
 =?utf-8?B?a2JWaXRabkgxR245SWNrM213dWtjTFU0ZWRnOXVVYzBwT1F1K01wM1lWeDhs?=
 =?utf-8?B?UkpiRnFRa083bGE0MXhqVThGZEFrWG1DemFUVjJrVllDaGNsMXo4YkE4anhQ?=
 =?utf-8?B?VVV2STZRQUZYbGV0aHdtU0ovTDRNeG1IR1NHMVhUbTZlak1TZWZlbDNzYnNY?=
 =?utf-8?B?RStKTUk1Z3dLSUg1UGxWUHk0WWszOXlVUkxFVSs2Qkw5T2NOYnBBdFVZdGVT?=
 =?utf-8?B?M2gvYXl6QVJnNnJ1aGJ0ZzVTY2w1dWtKR2l5cXk2eHkvTHR1YTVyQytBbWty?=
 =?utf-8?B?NHgybS9vUnZOVm1DeHRTbFlmZllhOVJRYlVKekFpUEJWeE40SXE0RTdwVFhO?=
 =?utf-8?B?bnIrVUl1U1BnT1ZDMEpXQXZ0RTRoaDRON2RVYTNJcEVpWnppQ2Z1bWtqQ2R3?=
 =?utf-8?B?U1FOYk5RYWM3cUF2YTNkbzBqZG8vM1Y3UGZBRVhua2hOTm5EWms2cUVjZWtJ?=
 =?utf-8?B?cHVZOXdzcUJqMXYyUVRTMG16TDFhTUw2UXhON0E3d0tDUkUwcTh5d0EzendS?=
 =?utf-8?B?WkwvYThnaVJEOEtqNDYwT2wySXl1SG1sNmYzOHB4QzRaWEQyUklNa3pWTGF5?=
 =?utf-8?B?ZjZseFF2Q1B6WUhUUUtCaXNlek1uVHpoRTRvRDhyUTh4WW1oM3JpNU52T1Yz?=
 =?utf-8?B?NG9TNG94Wm9FYXRyRThuT3pCUEJ6WjRvTmV4YTVYd0NnQm0rSnZkemJCNHRS?=
 =?utf-8?B?V1pMTlIxTUdzVGpiN2NtRWs2TDkrQndVc1hRR0IzWUhTTytBZEEzbzV1UU1R?=
 =?utf-8?B?TE14czE1YnM3ZzRTYkU5WjdPdnE0R3Yrdkxab3BXVDg0MFpWQTd6eWdUdDVD?=
 =?utf-8?B?VDlTOG9CVFhvMko1aFl5NGZCM1hwdmZDT1p1dGdZOWgxOEExMDIvMThOTEhU?=
 =?utf-8?B?QlN0Z0pqYnFyMDZsblRHNHVMR3NIam9GMG52bE1QaXdzN0FBZHA3UGwwUDNK?=
 =?utf-8?B?c2Nmam5UQjRqcWR1YlNuU3ZtY0EvS0FmZHIwNG9SQmdSdTllUGpTUnNGVmU3?=
 =?utf-8?B?SlpxSlVSdXpmVWhNQnZ3Z0crSzFOWEhQUndJZ3l3ZzhZSkJTQUlNSGNkbTZi?=
 =?utf-8?B?dFN2c1A2eXRpWTVMTjU2allXT1paKzdzNXVjUTNOdW5HS1JmV3dDWlJzTkRt?=
 =?utf-8?B?UnMxWXJ2bytORkZFSGM0d1V1dkwyUnprNjZFUUtJeENtaCtMMGswMlF6UVYv?=
 =?utf-8?B?Ukd2Z2lNb1N2YU91Q2JTS1NGZUg0bWJ1eHFCcjhqNHVVUHpLdU1laXU1bkV4?=
 =?utf-8?B?RFkrNWdkbjF5azQxMEFXVW1pbitPVlhCK3N2ZG51NnNMQmlCbHR1Qkxxa3dh?=
 =?utf-8?B?QmxEUjkxVEFBK09oZHVELzRFb3B3T2RyWURaNU9rRnI0N1F0K2ZiV0NnWlBp?=
 =?utf-8?B?V1kxVDA2SWJKWml0UGRneHBIeXZPUEk2RmRidmVTSFZVUWNtNFA4dzYrbDIv?=
 =?utf-8?B?S25EOHlGcnRsYW1USER0dUhNZEt2RWJDTHE0STFQWWRaclF0elg0ci92QWlT?=
 =?utf-8?B?WG1YQWFZUmNMZ2ZidndGOXB5WDZrcDlqYUZUVkxpc0lpL0toK21LWG03bHNs?=
 =?utf-8?B?ckFQTE0zSCs5aC9yRVBSREpQQUovWW1VQXpUZ0tsQmRRMzRhYVQ3UC9nR0My?=
 =?utf-8?B?Ui9HemdPUjEwa3pvVE9DSmxtTmY0SVZmU2N5RS9yYXBBSzB5V3dUYmg1YTRJ?=
 =?utf-8?B?Q05PeFcyWHhDU3JUREtLMUdGMnQ5SVpCR0hjazdUS0VwR1BvZkN2L0xaeUxt?=
 =?utf-8?B?NlZQR2taTTNBK0FoSldYUktsYzA2WDdlOU5kRmhlNHRrVTVVM1NObjEvM3VY?=
 =?utf-8?B?cm5JVkF5VkpjdWNJaVRKOEo0V05JMjdiaWVMWFJ4cW5BWG1nMG84cGVwNGND?=
 =?utf-8?B?YUxSbXdxS0lzZzBtSW5hb0hsMGMySkVEeGpVVnU5WW95RVh5cTZ3T2N0TnM2?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9C76AD345E62B4E980A6048AD4CE784@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc878ff9-975c-48c7-002e-08dad793a5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 14:10:36.5736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMRHAbPqRLmuMQIItmLzjjQEQt+SK4WYnkk2SQWvBgiWNun24oZhl01q+1zq4iz+iuHvzstSQfPwGDtKQfcIR/tpiiFvl2mbJv7PmjbZT6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQmVuLA0KDQpPbiBNb24sIDIwMjItMTItMDUgYXQgMDc6NDkgLTA4MDAsIEJlbiBHcmVlYXIg
d3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gSXMgdGhlcmUgYW55IHdheSB0byBnZXQgSW50ZWwgYXgy
MTAgdG8gcmVwb3J0IHRoZSBub2lzZSBmbG9vcj8NCj4gDQo+IFRoYW5rcywNCj4gQmVuDQo+IA0K
DQpObywgdW5mb3J0dW5hdGVseSB3ZSBkb24ndCBoYXZlIHRoaXMgaW5mb3JtYXRpb24gaW4gdGhl
IGRyaXZlci4NCg0KUmVnYXJkcywNCkdyZWdvcnkNCg==
