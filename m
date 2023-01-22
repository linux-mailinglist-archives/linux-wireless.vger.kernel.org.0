Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96E06771B4
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jan 2023 20:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjAVTFW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Jan 2023 14:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjAVTFT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Jan 2023 14:05:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E89513D71
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 11:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674414318; x=1705950318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9xARTbNDe32nFixQfikL1G5u4V9Pjn65by6B4yyjULA=;
  b=KGxt5g8kEcfX976uylJLV9Loz3E+hWGjYaa+VS9YlS0KwpKmIycMygMU
   DKtW8jcQ7p9xp642ROQQMzgXOJIEJDG8R8c9VuHY7pqRtdqWIPmKW4lZJ
   BJ+e3lBpsXgGQOI/r54N/QDtecIBcNubroLOVGzYc7UUk1ZENEueGvApc
   DPfF06OsXRrwn8ul9geIfDpyk45yR7w47WY/HwbnSBIdP2pSV03kEG48Y
   2vFFI0vCfeImnZWc8qkHJ+KFGCrQPu5WDsf664tHmRl1q0wXe5W4sOk/+
   AMU90bPDl/iynvbwpN8osILNgnnTWW+fkX+L7yQX8eDHT7jlFDnzUEF8A
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="325963887"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="325963887"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 11:05:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="990188345"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="990188345"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jan 2023 11:05:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 22 Jan 2023 11:05:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 22 Jan 2023 11:05:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 22 Jan 2023 11:04:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHFUH7P4eGnB5GAt7WVTzy3AjSI6I5ulvIXAzrFTR8wapdi8NIOebRTzRBx5sid6kPIOuwe6fQ8lz9yG2xgmdrnU/kCGRl4ALKEn1XRQPqTZvmzmlEbBCuATJTWjPVCJr6x/PUDHzYsTkMxOkVCqEtb7YDSxxSMACN0yeWy7WFwb3OI0vFm4pRJuTWWTpzY6vIOtpD9na/U+5bLtioNP6sa11A9UQYw515qPW1wudnlMA9KBu06/9tT4/IOH85ebJG21WUJjUmgmDBuNImDzzQvU82LepTXHt2T9XJfyl5U8VPC7qXXBb4jfBy05iVfDwXnYdPPytdqriwjpIbjXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xARTbNDe32nFixQfikL1G5u4V9Pjn65by6B4yyjULA=;
 b=nNDhBAsL/GT+rrLTf47YAznvb4l3k5nQYATeQ+CVaRASWtoNy3PDADWRy6Wog8YteH30mbOSi2vqHAwwDcdFlhWWmb+40/0aJ7GPIweZhEiyvIBT+ij1v6Y7VooWjydEbnCvW0os0fftfz/dFlYcUeFOnWR4R2wOt/aeVQgXB9ac6aYrXQ+COZruGJ1izBExuxe1lJelrDheTuWp2uJVtAZFJqq8jcauR5K4FUtQBVl/CcG7Z05VabRei5EMLySm7LH2U/Blt9g9bUg22uI3aNiS3GBQu5Q4FatbBPIivlsMjDKVYKy1kcXfZ2VbZ2Ba/vVnpoL/Hp7ssCClbEWopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sun, 22 Jan
 2023 19:04:26 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.6002.033; Sun, 22 Jan 2023
 19:04:26 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "vdonnefort@google.com" <vdonnefort@google.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: Re: [Bug] iwlwifi microcode error
Thread-Topic: [Bug] iwlwifi microcode error
Thread-Index: AQHZLonT6KjV8qvws0iHze6j+GjFg66qy5mA
Date:   Sun, 22 Jan 2023 19:04:25 +0000
Message-ID: <19fbd02c0ba9b28ee1de38a151c4e65b80a42ad1.camel@intel.com>
References: <Y813ApLzGgNMHMBu@google.com>
In-Reply-To: <Y813ApLzGgNMHMBu@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DS0PR11MB7263:EE_
x-ms-office365-filtering-correlation-id: 5e1dc0e3-6188-4798-51e1-08dafcab7ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4U+7z8JzIWJUiopYj8ecBo2gnH/kkjUFBFd9IpeSdYp/OU/TsWGIlsUsUSP9s9bvSchHVhqVquh23vJ4YoIW68gI2kN+DlKkNk0PYBzf8FeSiAI+7F/NUNS5TvBVvrnXem527vR/e8IS1MG0meaKNj+ZYwjk+sVQaaG+sFP7g6FqT4u9SlygSNF0wlUgDiWf0BwR9Hh5LDVmFzdaxEFXWvXxw/IsFNsykSo5dYBZagbOfHdj7tiTG+yMkBHi0IzTju1YNP/5wmfUCv0cty/dvc4nzAHn/KF3C2lqfO2nIU6lL5joL4vaPTefHfkBkhWofVpioHmXm3dQ3VvNVar9CELvN5EsPpQZS0H9VHF8DHaUgz4Tq+yABhDjKDA3qmT16iX2G0c4f8apKfdUiTKJkMotf1SADn7YA/+ZTmGh0Cd0FOjZpzOyhda0/OdfFQc8UiDW1+MltwfkFmZeg08um6HYqoobDNRJ0xC7wIoinfmJKiIGaSOjRD5+BAVkYfg2RU9QaTVYzxuM8OYqPOocLKUjOtudRPoAF4sj0bB94WNKw8M74QJqu3meUqHWy9W9t7U7kTsseKvQMv4Wu66hLq0YWtKIc7fSswMl/aF84uFfpHVWYOawp24nkmn4iuCndn3sPYwXkBTgTLcE/ntjHeIKDZnTY8lN6ul4XsF7fbSErNg+aKmwXBwuhaOFZkUdwfTFtJCbd+YX51wEaccahdHyy6WURStHRtKGlDiSuEE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(36756003)(66446008)(8676002)(64756008)(478600001)(91956017)(2616005)(4326008)(66556008)(66476007)(76116006)(6512007)(41300700001)(186003)(66946007)(26005)(86362001)(2906002)(83380400001)(71200400001)(110136005)(6506007)(107886003)(316002)(6486002)(966005)(38070700005)(82960400001)(66574015)(5660300002)(122000001)(38100700002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWV2RDlFd2hKdmZmVFBzR3MzT1N6MEdPM0dkaWREQ1A4aVRJL2N0YzZDeSty?=
 =?utf-8?B?QjlIdzJISEdybkpIYUtGYVJwdkRvWjQyTFFlQ1ZvTzYzaXFFdDVQMWlXYVBD?=
 =?utf-8?B?SEwvT0FMSy9ESFdSSVV2a296c2VTRXdnRVBGQVZiMXVTOGQ5VFc2K290MDFr?=
 =?utf-8?B?MTZzRGdxVHJQdEd1Zk5YeGplNmhoUklncEpneTZ0dTV3NXJ0SVo3TFFORlV3?=
 =?utf-8?B?WjlwUkQ5bkFRMTRiSjE5RU9JU0dIckIzMndQdU5UaDZJa3plV3V6YUNNOFZp?=
 =?utf-8?B?TXhHUldJaXNGSzA4U1pYcXQrNlE2dGNOcHcrcU12OGxKMjJnc3F2R3Fnbkl0?=
 =?utf-8?B?WFVGTE9iNC9YSDZQS3FMREhaRDE3dGc2N04vd0ZHbklxOE1ENGRUSkhiWXVk?=
 =?utf-8?B?Z1Rnb01HTzIwUHB1RnN5dCtuWHVNWmlFNGUvU3R2NTkzbm92R3lzNkVlUm54?=
 =?utf-8?B?aDhscEZHYWIyb1pQekJNVmprRmdIdjNiYkxRY1haajM5NVpyUzdrbml5R0Fh?=
 =?utf-8?B?c1JQdDI4ejN3aTNJSi9YNlBKdVRNMnBLK250Q2Z2T0hQNE9vV3JmWSs1ZEhB?=
 =?utf-8?B?YVNBSHlqMzkrMWxuaEI4SFVaL0tDVlZtMVFKbHNjTnU3VGg1eENYUHZMdmla?=
 =?utf-8?B?K3J3K05QdjVudmROcXpRQzM0ekpZZ0NTdlAyK1NGelIwZjdTaFFtTm9QQzJS?=
 =?utf-8?B?REszWE1Rb1M5OUtKQ1Z2MDR3QTQ1c0hhQ2F6OUFKRHk4a2RkU0prM2luL3JN?=
 =?utf-8?B?TTJQUjNxTjhOTVl1MjNQMCtuTEdXTWR4L1Y5NDVpYnRkOFdRRU5IdGZUVWIw?=
 =?utf-8?B?TXRJK2pYcXNOTHdMQkk2UmJyN09TK21mNmtTSG9BQ012WDlPZnRtNFJVcmY1?=
 =?utf-8?B?YUJsdmU2WStXQUJaWk9ENU15dW1YdGQ0ZVl0RnF3UVh1clQxa1JxU2ZWZ0Yx?=
 =?utf-8?B?N29XOEdNZThMakJNNFdzTm9UT2dTaDVCNG05RGRLc2VDYWN5QTRXVnlvNjdW?=
 =?utf-8?B?OTZWbnlZTTkyQ3ZpU1p3T29TYWQwZXUzM3NvUm5KYTV1VmlValdzOHhrNENK?=
 =?utf-8?B?YTdzNXNVcW90dldQaFBESEFCNFh6ekxEMjNyNjBZQjVTSWtwZ2tNU2liYmQr?=
 =?utf-8?B?bElmR0tabFRNalVaMFJCVnpOUXNoS1l5b00xNTRiZE81QlJtem90ZzdWMmtV?=
 =?utf-8?B?b2pLUDVEMmpzZE9nQStyY0Z3YXBWQjNJVHpDQUpBR1RpN2ZBbmxlVFN2SmlT?=
 =?utf-8?B?dU1MTmFPNHNnOFRma3Y1b0NqZHE2QnhkSURtTjFhV3BrQmg5VE5Bcmo4SU1T?=
 =?utf-8?B?L3QzTFFtSXZORHY1QnpUVzNvNmZaSjRkZUE3NEpCdC9nM3pFUUJiTFozYlUy?=
 =?utf-8?B?Qkl2VjAzV0NGRTI5d1o2bTJBdk9FV3JXakdWUFN6SUNXa0JMUThpM1p2YVNZ?=
 =?utf-8?B?MERML0ZmWCtsVS9WUGFybUI3cnpLVGNQWHBWbFdSa1d6djAxbDMraE9rQ2g1?=
 =?utf-8?B?bmp1R1lXZE1Jb0l3dnQwcVBka2RUdTNOYTRWZ01NcmJ0YldGZDVSY3Mxb2gw?=
 =?utf-8?B?WGVBWTNxVGtuSnlHNkg1T3V2WHR6YW9QWjFzeEE4RlRpT1BpdEpmWFV3NEJE?=
 =?utf-8?B?NkYzaEFtVVJHR21OS1A4ck9jdnVRUTF6azViSE9hUVVhTFZmWHd1NGtDUXMv?=
 =?utf-8?B?Z09nQmVyQnEwRFlPejJZYWd5cjdMNVZLMEdOdGdqbTVVZFZ3Sm5WYWwzUGx6?=
 =?utf-8?B?NjlkVFJFMjEwY3JPRklnRDkrQVAzeUJlb0J2Z3U3anRqSENXak1uR2JrQ2RK?=
 =?utf-8?B?THhqT0xNcE9mTitoN3FrazJnYXV0dm5MSXNWN1hTc01QUTM3S0xjK2JocFZG?=
 =?utf-8?B?VFdKRHd2MTFSOXN4cGgySFZmbTVybjByb2dvRVdQazc0a2NaSjg2dElrOE51?=
 =?utf-8?B?Q3dsRThUZGREcnhyVS9HTlhvb2NtQUt2U3g0c1JhSkNJTUI5VTE1S25TUHhX?=
 =?utf-8?B?UmVtY09RZUdPZjEzUjYrY2FYRm9wU3NPeE9JVFdxaXUwMlFaR3k4UHZZZUYv?=
 =?utf-8?B?d2pxWExTYUd0K2JTTitSRFFnZHh3bThXZFVwbDV0ZG15NlpIcGZqUVh2dFln?=
 =?utf-8?B?M3JkWlg2N1k3ZGRNejlNR1dvYlhTYVFlODFQYzdHNUk0V1k2dnU0Y1hjNlFu?=
 =?utf-8?Q?cxu7/HluAk6bt40nEUNzApo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D84A51E2934344DB8AAFFB9D35EE7A3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1dc0e3-6188-4798-51e1-08dafcab7ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2023 19:04:25.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9jwE/JQADvsX0hoEHG/1AZWe1PF+KPRivp0RdKie7b1GslyWNMMQN/7OD43/hU5J+X7eNMviwvmybAdFSJ1jzDm9RVRxNs4AeHnmv2/1e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU3VuLCAyMDIzLTAxLTIyIGF0IDE3OjQ4ICswMDAwLCBWaW5jZW50IERvbm5lZm9ydCB3cm90
ZToNCj4gSGkgYWxsLA0KPiANCj4gUmVjZW50bHksIHRoZSBuZXR3b3JrIGNhcmQgb24gbXkgbGFw
dG9wIChBWDIwMSkgc3RhcnRlZCB0byBsb3NlIHRoZSB3aWZpIDMgb3IgNA0KPiB0aW1lcyBhIGRh
eS4gV2hlbiBpdCBoYXBwZW5zLCB0aGUgb25seSB3YXkgSSBoYXZlIHRvIHJlY29ubmVjdCBpcyB0
byByZXN0YXJ0IG15DQo+IG5ldHdvcmsgbWFuYWdlci4NCj4gDQo+IEkgZm91bmQgaW4gZG1lc2cg
dGhlIGZvbGxvd2luZzoNCj4gDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiBNaWNyb2NvZGUgU1cg
ZXJyb3IgZGV0ZWN0ZWQuIFJlc3RhcnRpbmcgMHgwLg0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzog
U3RhcnQgSVdMIEVycm9yIExvZyBEdW1wOg0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogVHJhbnNw
b3J0IHN0YXR1czogMHgwMDAwMDA0QSwgdmFsaWQ6IDYNCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6
IExvYWRlZCBmaXJtd2FyZSB2ZXJzaW9uOiA3MS4wNTg2NTNmNi4wIFF1Wi1hMC1oci1iMC03MS51
Y29kZQ0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMDAwMDA3MSB8IE5NSV9JTlRFUlJVUFRf
VU1BQ19GQVRBTMKgwqDCoCANCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDAwMEEyMDAgfCB0
cm1faHdfc3RhdHVzMA0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMDAwMDAwMCB8IHRybV9o
d19zdGF0dXMxDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwNENCRTA2IHwgYnJhbmNobGlu
azINCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDAwMUFCMTYgfCBpbnRlcnJ1cHRsaW5rMQ0K
PiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMDAxQUIxNiB8IGludGVycnVwdGxpbmsyDQo+IGl3
bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwNEMzRTk4IHwgZGF0YTENCj4gaXdsd2lmaSAwMDAwOjAw
OjE0LjM6IDB4MDAwMDEwMDAgfCBkYXRhMg0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMDAw
MDAwMCB8IGRhdGEzDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDk2ODAwRkY3IHwgYmVhY29u
IHRpbWUNCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4NDI0QjYwMTEgfCB0c2YgbG93DQo+IGl3
bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwMDAwMUZCIHwgdHNmIGhpDQo+IGl3bHdpZmkgMDAwMDow
MDoxNC4zOiAweDAwMDAwMDAwIHwgdGltZSBncDENCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4
QUNFNzdFMUMgfCB0aW1lIGdwMg0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMDAwMDAwMSB8
IHVDb2RlIHJldmlzaW9uIHR5cGUNCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDAwMDAwNDcg
fCB1Q29kZSB2ZXJzaW9uIG1ham9yDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDA1ODY1M0Y2
IHwgdUNvZGUgdmVyc2lvbiBtaW5vcg0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMDAwMDM1
MSB8IGh3IHZlcnNpb24NCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDA0ODkwMDEgfCBib2Fy
ZCB2ZXJzaW9uDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDgwMDhGQzAzIHwgaGNtZA0KPiBp
d2x3aWZpIDAwMDA6MDA6MTQuMzogMHgyNDAyMDAwMCB8IGlzcjANCj4gaXdsd2lmaSAwMDAwOjAw
OjE0LjM6IDB4MDEwMDAwMDAgfCBpc3IxDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDA4RjA0
MDAyIHwgaXNyMg0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwNEMzMjAwQyB8IGlzcjMNCj4g
aXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDAwMDAwMDAgfCBpc3I0DQo+IGl3bHdpZmkgMDAwMDow
MDoxNC4zOiAweDA0QjEwMDFDIHwgbGFzdCBjbWQgSWQNCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6
IDB4MDA0QzNFOTggfCB3YWl0X2V2ZW50DQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwMDAw
MkM4IHwgbDJwX2NvbnRyb2wNCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDAwMTgwMTQgfCBs
MnBfZHVyYXRpb24NCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDAwMDAwQkYgfCBsMnBfbWh2
YWxpZA0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMDAwMDBFRiB8IGwycF9hZGRyX21hdGNo
DQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwMDAwMDA4IHwgbG1wbV9wbWdfc2VsDQo+IGl3
bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwMDAwMDAwIHwgdGltZXN0YW1wDQo+IGl3bHdpZmkgMDAw
MDowMDoxNC4zOiAweDAwMDBEMEEwIHwgZmxvd19oYW5kbGVyDQo+IGl3bHdpZmkgMDAwMDowMDox
NC4zOiBTdGFydCBJV0wgRXJyb3IgTG9nIER1bXA6DQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiBU
cmFuc3BvcnQgc3RhdHVzOiAweDAwMDAwMDRBLCB2YWxpZDogNw0KPiBpd2x3aWZpIDAwMDA6MDA6
MTQuMzogMHgyMDAwMzQ2MyB8IEFEVkFOQ0VEX1NZU0FTU0VSVA0KPiBpd2x3aWZpIDAwMDA6MDA6
MTQuMzogMHgwMDAwMDAwMCB8IHVtYWMgYnJhbmNobGluazENCj4gaXdsd2lmaSAwMDAwOjAwOjE0
LjM6IDB4ODA0NTVCN0MgfCB1bWFjIGJyYW5jaGxpbmsyDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4z
OiAweEMwMDgxMjAwIHwgdW1hYyBpbnRlcnJ1cHRsaW5rMQ0KPiBpd2x3aWZpIDAwMDA6MDA6MTQu
MzogMHgwMDAwMDAwMCB8IHVtYWMgaW50ZXJydXB0bGluazINCj4gaXdsd2lmaSAwMDAwOjAwOjE0
LjM6IDB4NDI0QjYwMDMgfCB1bWFjIGRhdGExDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweEFD
RTc3RTBEIHwgdW1hYyBkYXRhMg0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHg5NjY1M0ZENiB8
IHVtYWMgZGF0YTMNCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDAwMDAwNDcgfCB1bWFjIG1h
am9yDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDA1ODY1M0Y2IHwgdW1hYyBtaW5vcg0KPiBp
d2x3aWZpIDAwMDA6MDA6MTQuMzogMHhBQ0U3N0UxNiB8IGZyYW1lIHBvaW50ZXINCj4gaXdsd2lm
aSAwMDAwOjAwOjE0LjM6IDB4QzA4ODVFMDAgfCBzdGFjayBwb2ludGVyDQo+IGl3bHdpZmkgMDAw
MDowMDoxNC4zOiAweDAwMjMwMTBDIHwgbGFzdCBob3N0IGNtZA0KPiBpd2x3aWZpIDAwMDA6MDA6
MTQuMzogMHgwMDAwMDAwMCB8IGlzciBzdGF0dXMgcmVnDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4z
OiBJTUwvUk9NIGR1bXA6DQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwMDAwMDAzIHwgSU1M
L1JPTSBlcnJvci9zdGF0ZQ0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMDAwNTcxMCB8IElN
TC9ST00gZGF0YTENCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDAwMDAwODAgfCBJTUwvUk9N
IFdGUE1fQVVUSF9LRVlfMA0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogRnNlcSBSZWdpc3RlcnM6
DQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDYwMDAwMDAwIHwgRlNFUV9FUlJPUl9DT0RFDQo+
IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDgwMjkwMDMzIHwgRlNFUV9UT1BfSU5JVF9WRVJTSU9O
DQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwMDkwMDA2IHwgRlNFUV9DTlZJT19JTklUX1ZF
UlNJT04NCj4gaXdsd2lmaSAwMDAwOjAwOjE0LjM6IDB4MDAwMEE0ODIgfCBGU0VRX09UUF9WRVJT
SU9ODQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwMDAwMDAzIHwgRlNFUV9UT1BfQ09OVEVO
VF9WRVJTSU9ODQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDQ1NTI0MTRFIHwgRlNFUV9BTElW
RV9UT0tFTg0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgyMDAwMDMwMiB8IEZTRVFfQ05WSV9J
RA0KPiBpd2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMTMwMDUwNCB8IEZTRVFfQ05WUl9JRA0KPiBp
d2x3aWZpIDAwMDA6MDA6MTQuMzogMHgyMDAwMDMwMiB8IENOVklfQVVYX01JU0NfQ0hJUA0KPiBp
d2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwMTMwMDUwNCB8IENOVlJfQVVYX01JU0NfQ0hJUA0KPiBp
d2x3aWZpIDAwMDA6MDA6MTQuMzogMHgwNUIwOTA1QiB8IENOVlJfU0NVX1NEX1JFR1NfU0RfUkVH
X0RJR19EQ0RDX1ZUUklNDQo+IGl3bHdpZmkgMDAwMDowMDoxNC4zOiAweDAwMDAwMjVCIHwgQ05W
Ul9TQ1VfU0RfUkVHU19TRF9SRUdfQUNUSVZFX1ZESUdfTUlSUk9SDQo+IGl3bHdpZmkgMDAwMDow
MDoxNC4zOiBXUlQ6IENvbGxlY3RpbmcgZGF0YTogaW5pIHRyaWdnZXIgNCBmaXJlZCAoZGVsYXk9
MG1zKS4NCj4gaWVlZTgwMjExIHBoeTA6IEhhcmR3YXJlIHJlc3RhcnQgd2FzIHJlcXVlc3RlZA0K
PiANCj4gVGhpcyBzZWVtcyB0byBvbmx5IGhhcHBlbiB3aGVuIEknbSBjb25uZWN0ZWQgdG8gYSA4
MDIuMTFlIGNhcGFibGUgcm91dGVyIGFuZA0KPiBhZnRlciBteSBmaXJtd2FyZSBoYXMgYmVlbiB1
cGdyYWRlZCBmcm9tIDIwMjEwODE4LTEgdG8gMjAyMjEwMTItMS4NCj4gDQo+IElzIHRoYXQgYSBr
bm93biBpc3N1ZT8NCj4gDQoNCkl0J3Mgbm90IGEga25vd24gaXNzdWUuIFRoZSBmaXJtd2FyZSBj
cmFzaCBpcyByZWxhdGVkIHRvIDgwMi4xMWF4IFRhcmdldCBXYWtlIFRpbWUgKFRXVCkgZmVhdHVy
ZS4NClNpbmNlIGl0J3MgYSBhIGZpcm13YXJlIGNyYXNoLCBJJ2QgbGlrZSB0byBhc2sgdG8gY29s
bGVjdCBzb21lIGRlYnVnIGluZm9ybWF0aW9uLCBzbyB3ZSdkIGJlIGFibGUNCnRvIHVuZGVyc3Rh
bmQgd2hhdCBjYXVzZWQgaXQuIEluIFsxXSB3ZSBoYXZlIGRpcmVjdGlvbnMgaG93IHRvIGRvIGl0
LiBJZiB5b3UgeW91IGNhbiBjb2xsZWN0IHRyYWNlLWNtZA0KYW5kIGZpcm13YXJlIGR1bXAgd2ls
bCBiZSBncmVhdCwgYnV0IGlmIHlvdSBjYW4gYWxzbyBjb2xsZWN0IGFuIGFpci1zbmlmZmVyIGl0
J2xsIHJlYWxseSBoZWxwIHRvDQpnZXQgdG8gdGhlIHJvb3QgY2F1c2UuIFRoYW5rcyHCoA0KDQpb
MV0gaHR0cHM6Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vdXNlcnMvZHJpdmVycy9pd2x3
aWZpL2RlYnVnZ2luZw0KDQo=
