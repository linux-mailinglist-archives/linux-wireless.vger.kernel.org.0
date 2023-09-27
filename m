Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8A57AFE3A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 10:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjI0IYb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 04:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjI0IY1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 04:24:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A1A1AE
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695803065; x=1727339065;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=9p/xj6mxMjYk1OzjUPRFOdtz391Gpe5Y7kcnTHaqK0Y=;
  b=NNEvWjZ/t7EeZ+fdtPTqSGHUp/oLEtCfNIxHy1mq8dYLPJBUp/QdV+Be
   rmO5jDRe69amJWtGQm/wvbS4j7S3yrQtJIB3NO4rcBpSBoIxHEaAc7ANG
   UjFz8dgHD/zmXACXQEDHv6uqN/jhgW/InMWIj8JMsE2MS8xkk5WwMfTUP
   niUoXgDnYOXyXyoJt48Q2rzr250GHoGxbdQQOewnzZ5Xnjar/jvWB7CFf
   ym2kwzGWJqPwmB+C/h9QIlu0D36YwR6BMOmn1AIUzdw/FIKVHLfpB44Zs
   4w+RzFhm+2RD8LF31JLNYGAjtMdUdGsJ0ZgqxX95inTqWiVLduQMH21Hs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="468049458"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="468049458"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 01:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892519101"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="892519101"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 01:23:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:24:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:24:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 01:24:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 01:24:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3MGRGK0zfo73z0hllbkE/LmgL9SfT+pBwPvq4B5qRPdPrbpLmms0DL4Yqvt7JTtXqqdQJJqGaThyzf771Y0c59hjECPqUgDyehml7s7ks2+1vS7F9vekEgslL8E5sCgJEeGc6kwhmSnYTzOUNDdfpezYQKw487BI3rAUNPq19EKLXau6HaiAtTvAsATzVZZYpwGwUQtCoaudybrZcwZ6VngSt41Po/Zvs+ldy2RxeJaBfTKtLySyxYh9gvcDzerbK6ZyO+G37lnxZh6ILutKVaTTnU7V1lKVltOV+Zk/y0ALTHTBvoOLrD7N34s6L0vQl6nL2MuIKDOiT1/47p9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p/xj6mxMjYk1OzjUPRFOdtz391Gpe5Y7kcnTHaqK0Y=;
 b=R0nOjCOu8SjkzSHMU9HulUTF5ptnCO/ztYisaJlRAB0LOPyeXlyRYlpvJ+i2QRF2bUDFV59jPApwwWkP1vjYmLP8mdrdJRIMn5Gdz79tz5PFGptKZTHb0in0t6dw4UEd4deLbHpqDVBQxsmQaiIW9YIk6YOqMtx2Pn9csGi1bDkrJKuN+uHemXIcehF6Z50X/yvke/5V1JHaG+40XsvtOGTZpAzf9julRYENG2t1EfNB9+LgrOiCu+oCgcGZJAWi6KEaVRlKZKMyrgSeedL5us3kVMONNeX+FONKERauhivHIWIYtW+O4wTk1ktnzBjaExQKLMN2D9sc8Eyb7A3Ciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 27 Sep
 2023 08:24:22 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01%4]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 08:24:22 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2023-09-27
Thread-Topic: pull request: iwlwifi firmware updates 2023-09-27
Thread-Index: AQHZ8RwE0YYAR9CtzkezmQ17XzPflA==
Date:   Wed, 27 Sep 2023 08:24:22 +0000
Message-ID: <edb251a86c9cc6c3fcdfa9b4304d9a7ae9c074dc.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|IA1PR11MB6074:EE_
x-ms-office365-filtering-correlation-id: 81ed5e0e-ae97-4364-0987-08dbbf33271f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8GHroRQNqV10CQcT1Ieqzx08O9/OLB3UPw+sc4IRzEv27xEtQtIZhLUBUxoTffeRc/jMbpuKte2ES+XXGYJeLc9EMp4SvkL35OulFmiGqJiH9uJ/iXrMy2487zQyIHK1S7OqbvXXCgArF2zdDXi1FDwcnJZdfKeyxB1ROSgidMBS7o3JT1b2b7sDvOz40MLpnTuJSoSEq58AxdX54ZRjWlYAXKEeNxHts/h9ZVMhepgPKgaGLZ4baXGPdGobocqj9lHzS79QzLkJbrnMIdDl1BsVWeW9eXpLfRfhJvslhbO1wWiAvfL3aSjSG9ZkaAxmhiCBPM4a8EPAaAFufPnD0D/7qFR5vtKYWUpZsQOXg2jw3Kich9u8yoJ4iOP0XwYufvzKhNqvQZW6NZsUoRICEuH+dKaa7U/x8oB2RxpNSwC1HpX0hZREbmjhoFmWvE2vjqCXlvFjtf2LFbJMJojmBajCzvsf/hgZS/rknK1NWAiT9uzT8YH9xG/lJTZIixIj/oPzOfAoya2Jmq9pWZV8N8RgQD1WsD2yJapcLJSxTdqMIWTDkkinw6jPjeRDV9qmDCwrgUexjh/P7qK2/gy7LNFsRBhYZA52ws9dqlL0Qw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(76116006)(316002)(26005)(66556008)(66446008)(8676002)(54906003)(6916009)(8936002)(2616005)(66476007)(64756008)(66946007)(91956017)(6512007)(4326008)(41300700001)(5660300002)(71200400001)(966005)(86362001)(6506007)(2906002)(82960400001)(38070700005)(38100700002)(122000001)(478600001)(36756003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkVvZGlxcm5vcUxkNFhlKy9lYjR6Sk1weXdkOTN3VjFkbEVnRXVzYUk4bXEx?=
 =?utf-8?B?eVNkYlBvK3ZMU1hQUVBTUkswem9LOTBaVUxBVXJaSGxIYU1CNEwxdjlOY2V5?=
 =?utf-8?B?QTZHM25NSndXRHE1dlNTZGJNMFhTZThXaU1aa3BrQnJiZzJUZDUrNVFtcUZD?=
 =?utf-8?B?T2VVamlTaE9jWlRIeWhxQjRFck1RTjJqRTBSU3VpMHU5QkRERDBmeG00a3FO?=
 =?utf-8?B?YjBmU0FFaXZpdzhiRWE3Ly9Tbm03Yk5JV1B6ZWt5Q0ZRbS9qRUZvMlhTUytk?=
 =?utf-8?B?UHdZVWRDVENBV01UVXg0Qk5vWU56LzlrbkliY0VyRjZqcUNuZlFCSFR3UjFL?=
 =?utf-8?B?ZFZqRzNEZnc3L2dNREx3K1QwcGZUTHZyYkdpMGxyUUw3ejkzazlMREFPRXJn?=
 =?utf-8?B?T1FOeUkxL1NZMUFTVE1EV1BJY3FqVGpuRzI2eXBBa1JKZkZhT2x3bmNjY0Jz?=
 =?utf-8?B?bmRvTTFoTkJGTE9ZR0IxcE5ydGZUbndSRGpWTXJOUFlYTURGQTBqYTlCcjFm?=
 =?utf-8?B?aUJzWWZ6a1MrVmNQTTRuOS9qcXU4djZqUzJQVVE1aFprVmhrUjNDeG9kalBE?=
 =?utf-8?B?eUZmU0FlRkY3ZGc4QzFmY00zemxDUHp3dklSUWx2QStwR2w4MmsvUjgwS1Bv?=
 =?utf-8?B?RnZsbnVtbWVCdVdYNjFVQ21tRVczSmRRTzlwQldOVm1nd1VvVXFSS3VrS3Rv?=
 =?utf-8?B?V3pPdFFEaE1TMHNPVjg1dW1VNURFcHF0cUdaMnltN3RvTW8vOXJET3ZCMndK?=
 =?utf-8?B?VGdSNEhRdTlyVzhrcjljaTFOZTRSSW4xMHZhbXM4MHJPREkzeW5pQUlUdTFJ?=
 =?utf-8?B?eHQzMkkreFY5aklGcU5iU1Exay9EWGFIRUFsSWs3dndKN2hzR05lODhaaGhu?=
 =?utf-8?B?SE1GTGhqTjAyOHltTHRrengxQzI5NkpnUEx6SkVXa280VEhPYWg5VlQ5N1p4?=
 =?utf-8?B?WWM2cGMvSDVsUzJWSFg2b2JrZDFBYzBlN0ZKMkNTV2dMT0lwUHUrTzV3U0pB?=
 =?utf-8?B?YUFVWkNEVEhpU2p3dXFHK3g5MytsNy9WcWRtTU9CK29oU09PSjN6ZVRma1Ir?=
 =?utf-8?B?eEY4T0pIVHJNOWEwWWtkckdUbXBoMmVlV1FpaEJyUS8rVHBtb0l1N3l3ZnFu?=
 =?utf-8?B?cUhzUWNDRTU5Qk1Tb2VCekNvZkJUQ25KWGR1M1A4eW5tRzl1NFRScW10MFNz?=
 =?utf-8?B?MitQU3FCRXA1ZVRHcUw0SGI2bTVRbWtyT0dOdHRiZlNjZmxYMUhXcmx0MERq?=
 =?utf-8?B?aVg1cnZCNVpwSkNIZGpVZUJSemhCV3hiSmh0STI1VEQrWFZlM2EyclQ2eVVk?=
 =?utf-8?B?dy94TlFXTWx2UGlWUUlUN09kNHBlaEJTbXFiUnJGOE8zZ3hCRW5NRGFDVVFB?=
 =?utf-8?B?clVFRExycUxwRjBxVzBCT2g5cVZRZ3BVRnVZVU5pOFR0clMyZWM5aW9BSnNy?=
 =?utf-8?B?bURiN2lNZ2tHVHg1VTBNdnc3ZEFhUjVDMStGQzlWdWRZZWpLQWx0VmxDdWNX?=
 =?utf-8?B?UW9OM1ZJSWp2MkhsenZYOHIvcWQxMWVaMk1TemMzRHU3MHdodEtubjJudE9J?=
 =?utf-8?B?R0JtOVBydWZLbFU5dTQxMzl5TG85dzdQVVhkTWZWWkhjdTJvd0ttOVViTmlX?=
 =?utf-8?B?T3RkYjhtUm1yMGFuZGZQWWoxUCtJNjNTZUxDY0xRS0EwNWZGMnZJaXBnQ0lm?=
 =?utf-8?B?UlRPYXRIUGdLZE04Z0VxQTZCQndRSDZBVjFqMml4aDc4eVZCY0NsaVNHOXo1?=
 =?utf-8?B?WUxDTnFSUnNJd0xYU1ZjWW1SQ0U3YlZRMWx1aXB4UnFjQ1JIaVFWck96ZzFS?=
 =?utf-8?B?ZHB3ajNoZThWZkUyTVdmOFVPa250SFl4YTk1SXFubGY5bjc3dVhES0tCQ1pE?=
 =?utf-8?B?TmhYNzVQb3FwdVJSbGJUaEdqS3BQTUFwamlPeUptcHBGSlYwdmhSeXc5bHJy?=
 =?utf-8?B?dUdRYWNyUG9mVjh0cEpkVmJ1VGFuR2VzdHNnTFFxZjh0N2NwejhvRUZhTHJQ?=
 =?utf-8?B?cEswWkNLVllrMU05Y0lHRXVPeklrZGJLcTIvN1NBYjU3NDByZGViQXRmUjAy?=
 =?utf-8?B?UjgyUmpxVjIzVnRFZ2VxY1FBbkpFdmIrV3ltd0llTzJGVTN4WDNMZHpWR0h0?=
 =?utf-8?B?WmtZdnpWcDJKK0dpZjZzU08vellwRjA4RDNsMXBybXd5S1JwUW0vN2NhNmVs?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93AA88A58A72134ABF6AB7C0D4DA22DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ed5e0e-ae97-4364-0987-08dbbf33271f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 08:24:22.3431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOruWBMSxjF7CVJ+9d7MfsZeBUYK8iUE4aNjdDyrq31oIM0Ll00o8/jV8HoHxWoYtt8QpMjFxZTZA6gZegLBz79kYi1vMLVmXZp5AukM5og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgc2V2ZXJhbCBuZXcgZmlybXdhcmVzIGFsb25nIHdpdGggUE5W
TSBmaWxlcw0KZm9yIHRoZSBuZXcgR0wvTUEgZGV2aWNlcy4gDQoNClBsZWFzZSBwdWxsIG9yIGxl
dCBtZSBrbm93IGlmIHRoZXJlIGFyZSBhbnkgaXNzdWVzLg0KDQotLQ0KVGhhbmtzLA0KR3JlZ29y
eQ0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDhiODU1ZjM3OTdlNmIxZDIw
N2I3YTJiOGRhZTBlOTkxM2Y5MDdlNWI6DQoNCiAgTWVyZ2UgYnJhbmNoICdtYWluJyBpbnRvICdt
YWluJyAoMjAyMy0wOS0yNiAxODozMToxNiArMDAwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUg
R2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9pd2x3aWZpL2xpbnV4LWZpcm13YXJlLmdpdCB0YWdzL2l3bHdpZmktZnct
MjAyMy0wOS0yNw0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYTY3NDRkZjgxYTMw
N2NmZWU1YjAyNzFkYWU2NWY4ZmNkZWI4NGZjZjoNCg0KICBpd2x3aWZpOiBhZGQgRldzIGZvciBu
ZXcgR0wgYW5kIE1BIGRldmljZSB0eXBlcyB3aXRoIG11bHRpcGxlIFJGIG1vZHVsZXMgKDIwMjMt
MDktMjcgMTE6MDU6MTAgKzAzMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCmFkZCBGV3MgZm9yIG5ldyBHTCBhbmQg
TUEgZGV2aWNlIHR5cGVzIHdpdGggbXVsdGlwbGUgUkYgbW9kdWxlcw0KR0wgYW5kIE1BIEhXcyB3
aXRoIEdmL0dmNC9IciByYWRpbyBtb2R1bGVzLg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpHcmVnb3J5IEdyZWVubWFu
ICgxKToNCiAgICAgIGl3bHdpZmk6IGFkZCBGV3MgZm9yIG5ldyBHTCBhbmQgTUEgZGV2aWNlIHR5
cGVzIHdpdGggbXVsdGlwbGUgUkYgbW9kdWxlcw0KDQogV0hFTkNFICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTggKysrKysrKysrKysrKysrKysrDQogaXdsd2lmaS1nbC1jMC1mbS1jMC04My51
Y29kZSAgfCBCaW4gMCAtPiAxNzk5NTA0IGJ5dGVzDQogaXdsd2lmaS1nbC1jMC1mbS1jMC5wbnZt
ICAgICAgfCBCaW4gMCAtPiAyNDYyMjggYnl0ZXMNCiBpd2x3aWZpLW1hLWIwLWdmLWEwLTgzLnVj
b2RlICB8IEJpbiAwIC0+IDE3NTMzMDggYnl0ZXMNCiBpd2x3aWZpLW1hLWIwLWdmLWEwLnBudm0g
ICAgICB8IEJpbiAwIC0+IDU1NTAwIGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1nZjQtYTAtODMudWNv
ZGUgfCBCaW4gMCAtPiAxNzIxNDQ4IGJ5dGVzDQogaXdsd2lmaS1tYS1iMC1nZjQtYTAucG52bSAg
ICAgfCBCaW4gMCAtPiAyODAyNCBieXRlcw0KIGl3bHdpZmktbWEtYjAtaHItYjAtODMudWNvZGUg
IHwgQmluIDAgLT4gMTU3MjEwNCBieXRlcw0KIDggZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9u
cygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLWdsLWMwLWZtLWMwLTgzLnVjb2RlDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktZ2wtYzAtZm0tYzAucG52bQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpd2x3aWZpLW1hLWIwLWdmLWEwLTgzLnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGl3bHdpZmktbWEtYjAtZ2YtYTAucG52bQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLW1h
LWIwLWdmNC1hMC04My51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLW1hLWIwLWdm
NC1hMC5wbnZtDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktbWEtYjAtaHItYjAtODMudWNv
ZGUNCg==
