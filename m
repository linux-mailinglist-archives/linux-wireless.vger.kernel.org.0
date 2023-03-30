Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AFB6D0FC3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC3UOJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 16:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjC3UOI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 16:14:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03528BDDE
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680207248; x=1711743248;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Rs2U1Uo+6lY+9fWNEUWpkuvCUgGKD5mCmAK/xblVCDU=;
  b=ZgdXuB/4rh0kW1t2Z8OB2JHTbEAERXL5cJg83XTNDc37uXipuCnWQWHu
   rBPVZS2yQ7HzsCL6G5k0gkQ4CoYPOl0+kctUQy5K6Dof4/AHh/CDce2k+
   ydfNVqcm56+D4bjpj4mbrxZyd+Z05MA8SfEWdteJ2rSW08/NudtbRvEpF
   kctrzhSlhrX6oZGoZRNU+4TX9fNnhOA+Y0Mx4lOQROoTjoL2Y9yo2LIrs
   NvvlwQ0NkJ2GJSOGWjqYHWp426d7sBP53ejuRBlUZyD37UOSZZQyLSOfy
   709/TGyTQ3R7jyTmx26mmK4yMlJaGh2pFrWnE/M4T8tXakhBgtzvRuG3M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427553183"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="427553183"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 13:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="678335054"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="678335054"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 30 Mar 2023 13:14:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 13:14:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 13:14:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 13:14:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5ii5k1Fh8wxS5aPyCncMf3Yuo22CFNIepw7GNFXDhKmNIwb1PWvkDZIk0w1hJgMQ6bak8ntjmLEOaRe/yxdWksKcsI6mY7AgQN56xhKINaIcSkCPsjZe+/2EikJBSDwQAmWfB/K/m1WqeAvuTNDHOcYLCLNcVUlYCdOfRyWwP8KEU3P4ixj8clQvqZqyEZgfDBvYnGUN1+CSvDp2thBwK+XYHTBZ+S+JkfGCsGec6mH2D8VQ3pIgkqvqBjYORndXNn8UX/pN9GWL8MhPlT6q34gNZd1wt3zKVYAf1niu7Wj8fbT+oK+N1v9fCb/6faSFGKm8vPQEYdnt17R/wQvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs2U1Uo+6lY+9fWNEUWpkuvCUgGKD5mCmAK/xblVCDU=;
 b=llkw/2Wmdz+eJ5qqEVtaXEEn1Jt/zQbY0sWzK6IyKG/dtre98Pkpj8wWcrZdoqiXfaXQqFxWXGmgjWAmSNkRd+X84KXYqNWqhljL/mDJ38SWIrSiI//L+mkomjSffzRcy1Wb2hlTti7T9d6fouI7wXvSBEgDBbqAA9frNKf1pI8IvuLl9BtnHJfJsORgFDWQkvqtHrc1dpWVvIbOg2XFpa9ev4DAh1A8eXYq2M0GHfzY/djSiKDLtQDHy5F0OsgVn0jpzAFCBe4UZIzW3qE8Aa0wt1EC4i5ZkYAXsxn61Flzs+rA8VdKs3qOoIeDBk5Jg6lLFc1qKcuQBwChxG8bDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by SN7PR11MB6873.namprd11.prod.outlook.com (2603:10b6:806:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 20:13:58 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330%9]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 20:13:58 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2023-03-30
Thread-Topic: pull request: iwlwifi firmware updates 2023-03-30
Thread-Index: AQHZY0QptXzEtdy0FEK6+gE9qr4cWA==
Date:   Thu, 30 Mar 2023 20:13:58 +0000
Message-ID: <a64091100d99323501ee95b25436490346142c22.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|SN7PR11MB6873:EE_
x-ms-office365-filtering-correlation-id: 11fca073-c15b-4ee1-9a3a-08db315b4b88
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPqm2W31ctsfnlQAX7SEr13TamgmDulyVaJwI/fhwPyks7JTeGsUHaO7WhlljQWCVvKaTOaGovuvxzh9/r2hduAilUtyGzDUfSyh7VpDoL1PJqOdLHabvFTSPwYi4TOtwaxmtTvXT/pPrZ1ZiUnZ2gy8w9gGwLaaxmoBcRBE0CAnp/7FnRhzjRjJHTeyzhR3s4f3fonDNebhDQOppwSV5haS9MbmA/u4YPlAOyCAicGVKCFOfGFsu6OQzTamy36uFQk/qSuWiBhfic1rNDmcKd50gssrcgs/+rOWf8/v7wdh/MGJchJ+65qIh85EgYItNitGyWHxgxbcTnulu7GWYsJK5MHr29yNZ9s8nQzId0GyL1xM29WoLz+rTmFWhgl6U05+ZToRd8AVj+s0jVc8Lhk3R58XyaWFAxYqEvjSrAqZsEE86rWp8CXLK1Srecpk+uOsF/c/lDxUERU2KWo7yE9FiPQ0WVebHovL9uXIKH4pb3soUWdWyOd36dj0v1xfhXck+qk+BDrl+tm0AUN+CIbIRHWkKLfNIkEyvwlir3z5IXjxI1SL2UTvkwYmir7MGjDABKSd2BmgRpTwvSJu2H+44D8gIRQJGH3hIhFPVOI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(86362001)(36756003)(83380400001)(41300700001)(4326008)(76116006)(8676002)(64756008)(66946007)(316002)(91956017)(66556008)(966005)(6486002)(6916009)(66476007)(66446008)(19627235002)(54906003)(15650500001)(478600001)(71200400001)(2906002)(38100700002)(8936002)(5660300002)(38070700005)(82960400001)(122000001)(26005)(2616005)(6512007)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFYva0dGbWcyTGFSS3JkalFTSDJBT2ZVMG1KZTFZZTVYNHhsVm41bHZNdk4y?=
 =?utf-8?B?K25uNEc4Y0t0eG5FUE96Nlh0VjRzWWdiZ3ZiREg1YWN4NStDNnpyZzM4elJR?=
 =?utf-8?B?YWYyR1RxcmV6R2pvNWhkVFZENUpmMkNmWkE3eDNvQkRRaTFoeHM1elBKZEla?=
 =?utf-8?B?SjFwQmd1SVVyTFVaUWhSRGNWdlQvUVRXTkRoYkRVVVBubTZGdlNjWWgwN0Fu?=
 =?utf-8?B?c3BWaGxFSjdnVE5oTElWRlE5RFFjM1ZSU0dzblZQRWY3Y1FWcDBuR0gyYlZE?=
 =?utf-8?B?LzlVVXFMc2NEL2hMeGNrRCtWRDNQTnNlMDRwdjhFVHcrMjdBSHVwMGxMMmxr?=
 =?utf-8?B?UUV5WUVzbDJxd21IeXdqalVJMFRjWEwrWUY2OUhhNUFoeFpMK290REVGSllt?=
 =?utf-8?B?UmNKb2QrREJwbVMzVlkvZlV3QUNVVGx0dDd3ZjV5b2Vua2tydDNmS1AwQUti?=
 =?utf-8?B?MCtGNnFXVmJyek1HdzNOMitXU09PNW9MaTMyNFZLd2xOVm5jNUdPMnZJV1gz?=
 =?utf-8?B?dm4wSlJMNDFERUg2WE0xUlBBYzlzdm1hR3VodlFkNisyZkJMdE5tZTJ6bEFH?=
 =?utf-8?B?STcwQjhpanFLSVdvQmtIbzRreVNrMWtDWXR4TkJUdnRMOVZJSzg3SFZFb3hl?=
 =?utf-8?B?bHZKRkdLb2MvdGV2VFY3TFNkT2Nvc1ZKdDNjdkhOanlIMU9GTHQwL2NneGVx?=
 =?utf-8?B?T2x3M2dhemlIZmlpR3c4YnNBeXFvT3haR3ZjY3NWM002d0IzYW1MNXNoZXFv?=
 =?utf-8?B?YmJXWUg3aEgvODhLa1BKVm41OTR3bUZENGgwM3h1emlZaE9kSFZaNWJKMG5r?=
 =?utf-8?B?REJFeWNnSG9qSjhqNTRuZVZpUFJMdHZRWXVSTXdSRHBvTURBdXFiNjVRTS81?=
 =?utf-8?B?L2twY0MyVWJZNWExWFJPWXljMlBTWHZqQTdHN05Uek8xeHVHbjI3OUoyYUFV?=
 =?utf-8?B?aTBpTStNZmpNck5INDdMN2lYbHc4ak9UUy82Q0tOQm5LanNYQThpQWJENUQx?=
 =?utf-8?B?V0hvWGVDRWVwSi9wcHFWeFdPMUd0bnBWVzVJZEcyTjFBRVBwTDk5cUVKcnZs?=
 =?utf-8?B?YkFVd3ZHNk8yWFdxdXB3aUJYVlBkakdnalJjYnIrM25CRjB5Szh3djY3STN5?=
 =?utf-8?B?ZlI1Nit6MUF3ejFBZXRlNmN5U2JoL1lwQmhqbTh1R09KVEVWSDhOZmZIc2xZ?=
 =?utf-8?B?Y3VEZmFRQko2RThEcnhDWDBQT2FtVlg5Q3pBeVpUb3JiYUFYVGk4TmN1OHNz?=
 =?utf-8?B?QTlaNitjbFRqSGdvNjliMk9TWm92SFhlTFdRQTFVNWx4SzJWeEZHNVRDK3BK?=
 =?utf-8?B?TVNkek1XcFJadm1NYkdYQTd5aWQ5REJna0xlUC9xdkZDREtGTzViNVpzVmdu?=
 =?utf-8?B?Qlk4eDNWa1M5bTlYc2U4cDE3citPaTRIck84MENTMHA2cmU2MU9vYVhkRVVK?=
 =?utf-8?B?TVdUVXFNbUpLOUhUbk8rNUdZZ2ljYUEwaE02YTZabmJwSnJBbzlKT1l5bnM2?=
 =?utf-8?B?ZGxCeHpMcngyN3l6ZlNQbTcrU1dXZWptQWxrODQrU1dSa2Y1QlJyaGFEYlAw?=
 =?utf-8?B?Snd2UlpPYUJTd2Z0ZE5UU050RXVyQWVlMHJDZzcrNklnYklOVVd0T0lWODVO?=
 =?utf-8?B?NDZYWXpLN21LdkdlU2tuUHJySUxGV1FTdE1oOGN6d2xqVit5WVZ6WXpZaUpW?=
 =?utf-8?B?U1U3U3NBRm9LWlY5c05WT3hRdjRjdHV3YnhjbTNRaEhsbjVjK0tiakUrdWR3?=
 =?utf-8?B?RGRmSGR6T3RwQVlHWEViT0pVc1RjUkZRRkY0alVzK3JOV2lBcmdXdlRBc09W?=
 =?utf-8?B?eGcyM3RTYjZ1d3p2U0RMNFh2dUFLbnh2Zlg1bGs5dFJMUEY0VEM0RUFUL1pr?=
 =?utf-8?B?bXBQYXd5MW4vemhmQUJNekhqZHluY24xUkxZbzNxQk9mTlVoM2RjSHROUHNi?=
 =?utf-8?B?YXYxQ2J4UVF1RmM0UDlURW0xZTQvWW8vcDhRSFhjc1ZvTjZKeUltQmdCMXV2?=
 =?utf-8?B?cmErcmRpMmpta2hCUGJmWllxY3UxMG02ZkkrYmlxOTNrWmhvUGxrQlBpaWlP?=
 =?utf-8?B?TUpZelZBZXFzcWhoR200Qng5NFdPazRpWmpUU3pCNWp4U2xUWGpwTnZiRm56?=
 =?utf-8?B?RnB3K0F2N3pPcnZwY2Y2RUlxR3VqdlowaC9qcHdpOUFFb2M5c3ZFZVIwZTRT?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BEE80F1864F654C9B8C502B1D31BCDF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fca073-c15b-4ee1-9a3a-08db315b4b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 20:13:58.2022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCA8Qn9xdhc4m5XQR2UNcehmRNJm+niK7DamDtuLQdMR6a+1JUChrKWe8kwisXiuq1716bo/guy666F0zv2VbQg8UX5qzU1eKm+WSGqtmGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNCkl0IGNvbnRhaW5zIHNvbWUgbmV3IGZpcm13YXJlcyBmb3IgYWxsIG91ciBjdXJyZW50
bHkgbWFpbnRhaW5lZCBGVyBiaW5hcmllcy4NClBsZWFzZSBwdWxsIG9yIGxldCBtZSBrbm93IGlm
IHRoZXJlIGFyZSBhbnkgaXNzdWVzLg0KDQotLQ0KVGhhbmtzLA0KR3JlZ29yeQ0KDQoNCndhcm5p
bmc6IHJlZGlyZWN0aW5nIHRvIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2l3bHdpZmkvbGludXgtZmlybXdhcmUuZ2l0LyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21t
aXQgYmNkY2ZiY2YwYThmMjRhOTE0YjhjMTYzOTA2ZTZjZTkzZDdmODg5NzogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgbGludXgtZmlybXdhcmU6
IFVwZGF0ZSBmaXJtd2FyZSBmaWxlIGZvciBJbnRlbCBCbHVldG9vdGggQVgxMDEgKDIwMjMtMDMt
MjAgMDg6MzQ6MjcgLTA0MDApICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCmFy
ZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHA6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaXdsd2lmaS9saW51eC1maXJtd2FyZS5n
aXQgdGFncy9pd2x3aWZpLWZ3LTIwMjMtMDMtMzANCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2Vz
IHVwIHRvIDc4YTg3ODJhOWU1MWU1MDJhNmVkMjY3ZDI3MGM2OTI1ZmI3Mzg4MDU6DQoNCiAgaXds
d2lmaTogYWRkIG5ldyBGV3MgZnJvbSBjb3JlNzgtMzIgcmVsZWFzZSAoMjAyMy0wMy0zMCAyMjo1
NTowNCArMDMwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KaXdsd2lmaSBmaXJtd2FyZSB1cGRhdGUgZnJvbSBjb3Jl
NzgtMzIgcmVsZWFzZS4NCg0KKiB1cGRhdGUgOTAwMC1mYW1pbHkgZmlybXdhcmVzOg0KaXdsd2lm
aS05MDAwLXB1LWIwLWpmLWIwLTQ2LnVjb2RlDQppd2x3aWZpLTkyNjAtdGgtYjAtamYtYjAtNDYu
dWNvZGUNCg0KKiB1cGRhdGUgLTc3LnVjb2RlIGFuZCBhZGQgLTgxLnVjb2RlIGZpcm13YXJlcw0K
aXdsd2lmaS1RdS1iMC1oci1iMC03Ny51Y29kZQ0KaXdsd2lmaS1RdS1iMC1qZi1iMC03Ny51Y29k
ZQ0KaXdsd2lmaS1RdS1jMC1oci1iMC03Ny51Y29kZQ0KaXdsd2lmaS1RdS1jMC1qZi1iMC03Ny51
Y29kZQ0KaXdsd2lmaS1RdVotYTAtaHItYjAtNzcudWNvZGUNCml3bHdpZmktUXVaLWEwLWpmLWIw
LTc3LnVjb2RlDQppd2x3aWZpLWNjLWEwLTc3LnVjb2RlDQppd2x3aWZpLXNvLWEwLWdmLWEwLnBu
dm0NCml3bHdpZmktc28tYTAtZ2Y0LWEwLnBudm0NCml3bHdpZmktc28tYTAtZ2YtYTAtODEudWNv
ZGUNCml3bHdpZmktc28tYTAtZ2Y0LWEwLTgxLnVjb2RlDQppd2x3aWZpLXNvLWEwLWhyLWIwLTgx
LnVjb2RlDQppd2x3aWZpLXR5LWEwLWdmLWEwLnBudm0NCml3bHdpZmktdHktYTAtZ2YtYTAtODEu
dWNvZGUNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KR3JlZ29yeSBHcmVlbm1hbiAoMik6DQogICAgICBpd2x3aWZpOiB1
cGRhdGUgOTAwMC1mYW1pbHkgZmlybXdhcmVzIHRvIGNvcmU3OC0zMg0KICAgICAgaXdsd2lmaTog
YWRkIG5ldyBGV3MgZnJvbSBjb3JlNzgtMzIgcmVsZWFzZQ0KDQogV0hFTkNFICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDMwICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KIGl3
bHdpZmktOTAwMC1wdS1iMC1qZi1iMC00Ni51Y29kZSB8IEJpbiAxNTE4Nzg4IC0+IDE1MTg3NzIg
Ynl0ZXMNCiBpd2x3aWZpLTkyNjAtdGgtYjAtamYtYjAtNDYudWNvZGUgfCBCaW4gMTQ4OTY2OCAt
PiAxNDg5NjUyIGJ5dGVzDQogaXdsd2lmaS1RdS1iMC1oci1iMC03Ny51Y29kZSAgICAgIHwgQmlu
IDE0MDQwNDggLT4gMTQwNDY3NiBieXRlcw0KIGl3bHdpZmktUXUtYjAtamYtYjAtNzcudWNvZGUg
ICAgICB8IEJpbiAxMzIxNzIwIC0+IDEzMjE5MDAgYnl0ZXMNCiBpd2x3aWZpLVF1LWMwLWhyLWIw
LTc3LnVjb2RlICAgICAgfCBCaW4gMTQwNDA2NCAtPiAxNDA0NjkyIGJ5dGVzDQogaXdsd2lmaS1R
dS1jMC1qZi1iMC03Ny51Y29kZSAgICAgIHwgQmluIDEzMjE3MzYgLT4gMTMyMTkxNiBieXRlcw0K
IGl3bHdpZmktUXVaLWEwLWhyLWIwLTc3LnVjb2RlICAgICB8IEJpbiAxNDA0MTg0IC0+IDE0MDQ4
MjAgYnl0ZXMNCiBpd2x3aWZpLVF1Wi1hMC1qZi1iMC03Ny51Y29kZSAgICAgfCBCaW4gMTMyNTUz
MiAtPiAxMzIxOTU2IGJ5dGVzDQogaXdsd2lmaS1jYy1hMC03Ny51Y29kZSAgICAgICAgICAgIHwg
QmluIDEzNjU0ODQgLT4gMTM2NjEyMCBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2YtYTAtODEudWNv
ZGUgICAgICB8IEJpbiAwIC0+IDE2ODI4NTIgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmLWEwLnBu
dm0gICAgICAgICAgfCBCaW4gNTYwNDggLT4gNTYwNDggYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdm
NC1hMC04MS51Y29kZSAgICAgfCBCaW4gMCAtPiAxNjkxODA0IGJ5dGVzDQogaXdsd2lmaS1zby1h
MC1nZjQtYTAucG52bSAgICAgICAgIHwgQmluIDI4MjUyIC0+IDI4MjUyIGJ5dGVzDQogaXdsd2lm
aS1zby1hMC1oci1iMC04MS51Y29kZSAgICAgIHwgQmluIDAgLT4gMTUzOTI4OCBieXRlcw0KIGl3
bHdpZmktdHktYTAtZ2YtYTAtODEudWNvZGUgICAgICB8IEJpbiAwIC0+IDE2Mjg4MjggYnl0ZXMN
CiBpd2x3aWZpLXR5LWEwLWdmLWEwLnBudm0gICAgICAgICAgfCBCaW4gNDE4NzYgLT4gNDE4NzYg
Ynl0ZXMNCiAxNyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmLWEwLTgxLnVjb2RlDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtZ2Y0LWEwLTgxLnVjb2RlDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtaHItYjAtODEudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaXdsd2lmaS10eS1hMC1nZi1hMC04MS51Y29kZQ0K
