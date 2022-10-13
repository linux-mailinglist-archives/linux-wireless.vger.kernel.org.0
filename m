Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA25FD81C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 13:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJMLJB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 07:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJMLI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 07:08:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E2C10CFB8
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 04:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665659338; x=1697195338;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=XjpsHug35xcNvfG/c3Eh/sqOm+BsVPTcnWny5BxsbLs=;
  b=BdNqVr4NxUS0a/jTU7oSkjbJZT3BtkI4XkYQXlOpbROkFJ6eOl43Bs22
   +/jMyaSJgfWLPZiDlcOhuJqRjZxFYaInCAbXMAZcMYUnzr1HTse5VWSWy
   ZY4vS1pzTRFr5EkwvT2aqQDOruBtuW5BmJjDXDlT2I7ql1M9oLLPAKimW
   RGqByAUvFAj8IY1rxYrxGrA9XxaQNrezbEi/Z5Q+NIhmU3MkJAjkY9Poh
   fnZTE7zwtA/inovdHhc6B5qArbJqwsgHxy4oKtUlKMTEZkYuk9TnYyniu
   u45b3ukLNutx0JjlvP99oK/5S2fyJbpZ3w4+f49TnTelRjBjQn2HvrJkO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="292378208"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="292378208"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 04:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="752481383"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="752481383"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 13 Oct 2022 04:08:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 04:08:30 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 04:08:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 04:08:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 04:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf9p64FmRrUn43o1OOUO0LjTaw6FBCcaOJ829ECA9V4tRKTv29kuJtMDsGx1pMhZJ1L/9DOGLfvh/9YqKBhOyAzKKBTlGixriA5SwAS08W6FzFGk4wgFyEk1oImw6EvfG0KmNeJb4PLrB62NuOrR44k18IDZZf2U9mqqJMJgYYwCEXdYRBLVKIynOfk5UarH6JkRoVcs29oIxpBTuO6BRwJCJA5KJTNuSXz1iOMQ6vUZwk14DhfciRdJXWUKmJV2BqAtwpEgmAAgXbUlTnFpkl6H+hOlJZtArdwu5mpGaROuLZ8W1RhF1kIry+Q/xhOtJqyH2W5OBv6YIZ6aql0tFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjpsHug35xcNvfG/c3Eh/sqOm+BsVPTcnWny5BxsbLs=;
 b=K0uGsSKTOkKIOL5F67ga89Pmo77rDoZZiDjY0cddE4S49KFzmYSLOkGT54HV1pCL/PitRW3MZy+QmLl4s2MBwMDLxMzsJhXib/HZWekBQ1B8hkvB5MmnbybntLdg4pP5MMs5UOawiOk3RRLjkJx+7LRNA3VjvyVVwiltMuDPQF6fDvKRyAiu9zdVqgOi5r46QnvuvyWhodFjRMWYkIitW5kQglUou7byDKt0Blu/C6rXah07xKSOTbHyA4Hlf1StFbKvI5kf0m4iGHQgpQFjmhw7YXx941PJdQsuZdyb0cptBWQmjQQE2MefHM9bx0PiwVZD0P0g/pDCKww8zPNJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5993.namprd11.prod.outlook.com (2603:10b6:8:5c::19) by
 CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Thu, 13 Oct 2022 11:08:26 +0000
Received: from DM4PR11MB5993.namprd11.prod.outlook.com
 ([fe80::5f0d:fba5:eaf4:3b7c]) by DM4PR11MB5993.namprd11.prod.outlook.com
 ([fe80::5f0d:fba5:eaf4:3b7c%5]) with mapi id 15.20.5709.015; Thu, 13 Oct 2022
 11:08:26 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2022-10-13
Thread-Topic: pull request: iwlwifi firmware updates 2022-10-13
Thread-Index: AQHY3vQe77MrxG5oCUyP0bUfIKyJvw==
Date:   Thu, 13 Oct 2022 11:08:26 +0000
Message-ID: <7da86974c74f441c083a77e1ddfa2f2bd15a7aac.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5993:EE_|CY5PR11MB6462:EE_
x-ms-office365-filtering-correlation-id: 771ab9b2-6e95-45c4-385f-08daad0b4090
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 49taWk63r0OaIMv+tz6js7/Hj8N5nVhwQ/c+eEuRlU6kJtUR19Oal86REIiS1F93x6BHT68qbOoYb7Fna5JuTkouJLdFCWcu7UZj9yEEM0jz/5JGOpLEgB6kuxCMc5kdpinz0F7PJ0WpJby4INOSn5P+JaeFWysHbBCdr42K+tQpkrjf92mcGTuC9YhAotmc6XBcRnY1mX65d7wPJ/jNMELkXCjz1Haed1u2jiIVHNGNUJ7ZkziNzMPz5S+q1ymyv8NrZhWMPoS0czm/1jtj5h47/g1a0p376x5BR5mJu9ObzyNd8Jlv4nSM9tpCJgGUsDWHVc6auoJtgIMX0EOidRNDWdCMdIN1DX1JItribO2JbZXnbl8YKXid1gTEy0HLSY56/HqjSgX8QlQUdMqZKPV1DwiCDD/NOMEPoySnVaWx9tJtm/fyXou3O1ETU63aW9wTF5ESbgx31G1oI0LOhN9W/eIgEGtfZm60siWiiD3rL/185sFys10XOrHohPdH4bycgWmQ/qhlNWpOxqmCcdAji737gOqt/kMEuQVJUdkCpqf3Illxg8aJD6VwtRoOZTkQF13s+6lf1Bz1nsOoRtpubQ686G2Uox/LYuEWWNXCYWTdUMpq39GPhdoh8L15Wj3O1nb7Owk274b49WH0dopMZxhlnZhFKA5QYsiWrWCVkPtQ9p7IZX7MzxSHBGG6Pm5rsTknardh4MZZUTwQ+Gp6pbKqHVoNU2e90PdL5JQeaHOFzTA4TuqOam8fRvR4g7YzDUCqoSaZ6cQLM+fjZKKMi94lFY1fZ3prgRrQZcjzCJxIm2RDlryXpHke5XfJr9Dm0O/SpufG6oQOgdz+uA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5993.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(76116006)(316002)(64756008)(41300700001)(66476007)(66556008)(66446008)(66946007)(91956017)(8676002)(4326008)(6916009)(71200400001)(2906002)(966005)(5660300002)(122000001)(19627235002)(4001150100001)(6512007)(6486002)(8936002)(36756003)(15650500001)(86362001)(478600001)(26005)(2616005)(83380400001)(38070700005)(54906003)(6506007)(186003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmxxQ0h2ZVhRTUU5UzR5WTF4aW5YV1c4TXptTGFBczJhbzN1QnR0T2djcnNT?=
 =?utf-8?B?bnRCMDErdmswcHBvanp2cTd2NU13Z2FVN3dGRVVyRXhzOGpDLzMwTlhnQ1ly?=
 =?utf-8?B?TFl5M2g3TG1LR3ozZkRZRlNtNmxjVitoTVg1cG5WL2RpQ1VEdTg5ZUIzZHBt?=
 =?utf-8?B?RGY4T0kxdDlyL1c3am1rbDZxUnVmNk5FMHZIRk9NdWtucE8rRjN3RG1FcXJB?=
 =?utf-8?B?REpieHJ1aVdOMUZtb0VVQnZ0REhaMDFhYkFnUlBtY25EWlIyL2M0MXZGQ3VG?=
 =?utf-8?B?THIzcWFGcytTb2E0V24vT3hWNUthU3R6OHZTamZaQldmaDFaUy9zL0JKZWQ3?=
 =?utf-8?B?S3FlZkNoVjkwVWtBcUNSeDVIcTRNSEFCMUtwS2x5VEkrRGw5anZ3Z2pNV01C?=
 =?utf-8?B?RE9rTzFRMDZHRms3bjdRNWNIVW5UdzNiUmQyZmVaNVZkb1FPeGJ3WmdtZ2Ez?=
 =?utf-8?B?VGwxOXRYQm1JSkF0djZObEZtTlQ2SHlFS005Zkc2MmViM0QxdDVtenVCeUF0?=
 =?utf-8?B?c0l3ZDBWZjczcDFTUmVJNXlwRWlXSDlOVVVnNHpZYTA1RHVXd2RuMWh1Qktm?=
 =?utf-8?B?cXhXcExwYnlrclJ0SHJSM3ZwRzY3cjNWQjRzWnduQWFzMWRJTEkreEI2OXUz?=
 =?utf-8?B?MEdZbnltM2hKRkwxeUkvdXAyMC9IUndZRGRkakRzYVltaFAzTHZNR0pkZTha?=
 =?utf-8?B?SzVocVM0VUFUak1HSHI4SmhHWldQeDlVd2xPY1F3VldtY1ZRWmtCQkljSzRt?=
 =?utf-8?B?Z3ZKSHluMUdRdXVISmdwNDVGNjMzb3pNLzdsV21ZTnRkeitxSzYrOE1mQjBq?=
 =?utf-8?B?enJZQWpabWhQcnJycGpmSmtMLzE5M3QrYlJpZGR4ZS9XV3NaUW12SzBObWx5?=
 =?utf-8?B?djBGM0xGSVhMRVpPYTJqaE9rczFGUHVBQ2t0UXBrUTdTWkE5ZTRHalRVSEoy?=
 =?utf-8?B?ckJKVXg0RW1JS21rWldYRUgwdkRHaEpWMXBRNE8vL2pSb3hPVHVjcDVuMWRk?=
 =?utf-8?B?YzJ5bUQ0dCtNZ3JLSHpOaGVkbTVxRGxWNVcvQVh4Z08rQy92VWNTV1dKUkt5?=
 =?utf-8?B?L0xqMnYyTmVNbU5MbEZTOVBvdWdXVTdGVmRHeWpYYk1LYWFVanRSUkswMDNR?=
 =?utf-8?B?dm01ZFhlQWYvMDZPRDNCbFdJRWxXMGpodzQyY2ZtV3JGTTdtcGN4dEFKTktS?=
 =?utf-8?B?N2kzejd5dW9HWjhNRkNudVFwTGJHUHVuQks3S2x1RTJITmdLbFVDcEd5ZjZw?=
 =?utf-8?B?WC9MQkV0M0ZKQnExMWVkam9GRFd6Wm9VR1UvTi95SGhnbTd5L2ZOSFV4cmls?=
 =?utf-8?B?aVFTTlJPWjRBeStEZVNjTVEwTk5LNVZDTWhYZDVONWVqTXVHVzhmYTl1NjNv?=
 =?utf-8?B?NCtaWVFYcFRPR0Y2czBzYjZEQWxhYzhUbFcvaExvWU53S1JYM3ZTV2pNcERm?=
 =?utf-8?B?d0hsaXgwTjA1LzZHY3pIbzBFTC82NGtkUDE2bWdRekNldml2SjJ1RHlmZUF6?=
 =?utf-8?B?ZVJlQy94ZVR2bTQ4Z0YrRnRUOTBDVmpZTUxuWUw5UHlUY3VkRTQ3SHEzbXRH?=
 =?utf-8?B?YjJ3SEJvR3RBbWxvMDA5ellqNDB0OVpFZDBJeHYxRmQxaS9RSmt5cUxRV1hY?=
 =?utf-8?B?YitlOUFsTXB1b1FRSldvQkZLSXdGYkQ1czNSaks5N1IvcmZNeEVocURXbnhu?=
 =?utf-8?B?QkdSZGIxNlBMTG9JUHZKaURRbmlXeUxjV0RzcSsrQ0xORjBWTXNaakljN3BL?=
 =?utf-8?B?SWM2eU9Wdk5zUmtNS1NGMytiREFJL2xlQVExRy80MW5LbDlNVlNmOS9HdHBC?=
 =?utf-8?B?cWpoUzcvUGJ2SWhLZ2JaUFBTVTgxM0haYkd0QVA1V3U3K2tOWDVBeGNnSFd3?=
 =?utf-8?B?Y2w4Q0RLbVVkV256MU5OZ0dnRTk3dnoyNHZJeDhXZnVNL2l5YTIxNWhha1F4?=
 =?utf-8?B?d1dXZVAwSUhCQWk1RUgvYnUyUWlzSmNaalZpWjVWc2xuWG43dUZ0YmN0N1lN?=
 =?utf-8?B?cnlDSHBIdnpSbithc0ovOXBIcG9RM3o3V0s4aU1jZndHMjRXOFB0dExIbUtQ?=
 =?utf-8?B?dFRsWFhyNWtsLzJjUXNObFZic2xkdlpCd3k5TnlGTk9jMnpHNmRaT0pEais2?=
 =?utf-8?B?YnJUemlRbEw0K2YrVndoNEZhcTJBdmxuTzA5L1FRK0I4TS9VRURnWXZKVFFt?=
 =?utf-8?Q?VCHf8MIXYjfROzgvz6ZrG5s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <469B332CC9F56E49A72050DA2698EF4E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771ab9b2-6e95-45c4-385f-08daad0b4090
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 11:08:26.5159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRRSXseMVNFlnARuBFqLP1MM+7RxUrYdD6bMLiavyflCrH97P5t6v7kImNIVFBUb8Vl5ZRvMyz8pxsAzuUhOWSkOljU1Ukpa5vZtanK4KWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6462
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

SGksDQoNClRoaXMgY29udGFpbnMgc29tZSBuZXcgYW5kIHVwZGF0ZWQgZmlybXdhcmVzIGZvciBh
bGwgb3VyIGN1cnJlbnRseQ0KbWFpbnRhaW5lZCBGVyBiaW5hcmllcy4NCg0KUGxlYXNlIHB1bGwg
b3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBpc3N1ZXMuDQoNCi0tDQpUaGFua3MsDQpH
cmVnb3J5Lg0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDhiMDdjMWZiMWQ4
ZGU0MjU5NjExYTBjY2NhZWRhODkzZDc5MmNkOTE6DQoNCiAgTWVyZ2UgYnJhbmNoICdhNTMwLW1i
bicgb2YgaHR0cHM6Ly9naXRodWIuY29tL2x1bWFnL2xpbnV4LWZpcm13YXJlICgyMDIyLTEwLTEy
IDEzOjA3OjM5IC0wNDAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBh
dDoNCg0KICBodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3
bHdpZmkvbGludXgtZmlybXdhcmUuZ2l0IHRhZ3MvaXdsd2lmaS1mdy0yMDIyLTEzLTEwDQoNCmZv
ciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA5OGI1NTc3NGJjYzZjOTAxY2M5ODVlOGZhYjE0
MDQyMTlhNGVmMTk2Og0KDQogIGl3bHdpZmk6IGFkZCBuZXcgRldzIGZyb20gY29yZTcyLTEyOSBy
ZWxlYXNlICgyMDIyLTEwLTEzIDEzOjE1OjAzICswMzAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppd2x3aWZpOiB1
cGRhdGUgOTAwMC1mYW1pbHkgZmlybXdhcmVzIHRvIGNvcmU3Mi0xMjkgYW5kDQppd2x3aWZpOiBh
ZGQgbmV3IEZXcyBmcm9tIGNvcmU3Mi0xMjkgcmVsZWFzZQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpHcmVnb3J5IEdy
ZWVubWFuICgyKToNCiAgICAgIGl3bHdpZmk6IHVwZGF0ZSA5MDAwLWZhbWlseSBmaXJtd2FyZXMg
dG8gY29yZTcyLTEyOQ0KICAgICAgaXdsd2lmaTogYWRkIG5ldyBGV3MgZnJvbSBjb3JlNzItMTI5
IHJlbGVhc2UNCg0KIFdIRU5DRSAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0MCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogaXdsd2lmaS05MDAwLXB1LWIw
LWpmLWIwLTQ2LnVjb2RlIHwgQmluIDE1MTg3ODggLT4gMTUxODc4OCBieXRlcw0KIGl3bHdpZmkt
OTI2MC10aC1iMC1qZi1iMC00Ni51Y29kZSB8IEJpbiAxNDg5NTQ4IC0+IDE0ODk2NjggYnl0ZXMN
CiBpd2x3aWZpLVF1LWIwLWhyLWIwLTc0LnVjb2RlICAgICAgfCBCaW4gMCAtPiAxMzcxNTMyIGJ5
dGVzDQogaXdsd2lmaS1RdS1iMC1qZi1iMC03NC51Y29kZSAgICAgIHwgQmluIDAgLT4gMTI5MDg5
MiBieXRlcw0KIGl3bHdpZmktUXUtYzAtaHItYjAtNzQudWNvZGUgICAgICB8IEJpbiAwIC0+IDEz
NzE1NDggYnl0ZXMNCiBpd2x3aWZpLVF1LWMwLWpmLWIwLTc0LnVjb2RlICAgICAgfCBCaW4gMCAt
PiAxMjkwOTA4IGJ5dGVzDQogaXdsd2lmaS1RdVotYTAtaHItYjAtNzQudWNvZGUgICAgIHwgQmlu
IDAgLT4gMTM3MTY2OCBieXRlcw0KIGl3bHdpZmktUXVaLWEwLWpmLWIwLTc0LnVjb2RlICAgICB8
IEJpbiAwIC0+IDEyOTA5NzIgYnl0ZXMNCiBpd2x3aWZpLWNjLWEwLTc0LnVjb2RlICAgICAgICAg
ICAgfCBCaW4gMCAtPiAxMzM0NzgwIGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZi1hMC03NC51Y29k
ZSAgICAgIHwgQmluIDAgLT4gMTU3NzQ2MCBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2YtYTAucG52
bSAgICAgICAgICB8IEJpbiA0MTgwOCAtPiA0MTgwOCBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2Y0
LWEwLTc0LnVjb2RlICAgICB8IEJpbiAwIC0+IDE2MDIwNjggYnl0ZXMNCiBpd2x3aWZpLXNvLWEw
LWdmNC1hMC5wbnZtICAgICAgICAgfCBCaW4gMjgwNjQgLT4gMjgwNjQgYnl0ZXMNCiBpd2x3aWZp
LXNvLWEwLWhyLWIwLTc0LnVjb2RlICAgICAgfCBCaW4gMCAtPiAxNDc1ODc2IGJ5dGVzDQogaXds
d2lmaS1zby1hMC1qZi1iMC03NC51Y29kZSAgICAgIHwgQmluIDAgLT4gMTQxNzk0MCBieXRlcw0K
IGl3bHdpZmktdHktYTAtZ2YtYTAtNzQudWNvZGUgICAgICB8IEJpbiAwIC0+IDE1MzM0NDQgYnl0
ZXMNCiBpd2x3aWZpLXR5LWEwLWdmLWEwLnBudm0gICAgICAgICAgfCBCaW4gNDE1ODggLT4gNDE1
ODggYnl0ZXMNCiAxOCBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLVF1LWIwLWhyLWIwLTc0LnVjb2RlDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktUXUtYjAtamYtYjAtNzQudWNvZGUNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgaXdsd2lmaS1RdS1jMC1oci1iMC03NC51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpd2x3aWZpLVF1LWMwLWpmLWIwLTc0LnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3
bHdpZmktUXVaLWEwLWhyLWIwLTc0LnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmkt
UXVaLWEwLWpmLWIwLTc0LnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktY2MtYTAt
NzQudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1zby1hMC1nZi1hMC03NC51Y29k
ZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmNC1hMC03NC51Y29kZQ0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWhyLWIwLTc0LnVjb2RlDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtamYtYjAtNzQudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaXdsd2lmaS10eS1hMC1nZi1hMC03NC51Y29kZQ0K
