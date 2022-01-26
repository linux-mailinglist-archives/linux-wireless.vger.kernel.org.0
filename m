Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF149C49D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 08:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiAZHhs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jan 2022 02:37:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:24702 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237951AbiAZHhr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jan 2022 02:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643182666; x=1674718666;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version:content-transfer-encoding;
  bh=eTgrXMFd4F+1xyCwr60jPxsQtAL2Wm2f4krriTBR2ys=;
  b=JwMr6vXggmWe1HiZhcZGU19RZ0/lbgtPfv+b1rFmpRzrBgAeuSP73iL/
   NoDEGVm5eUSjj+KJnAsGm8HZ3y4sSNZkFlYZS/RcfNgNvhKS5Q4KW/8BO
   t/YWeQTSbIAcngVX9nXRcg5RzM/yMZhV9FvWVp+nyaZlf+AUer/LqY4Bu
   /aHPmnGyFOZ7WT7VuYUrOD6ddid91oovHdFz9e/vD2bdwoCV1cB05f41/
   1bzhTFzeRB/60hEJiw2Jg+3NVRcblqqgf3ouKfonqRZDHO2Hal1mgBd9P
   7/HtiRGl47LkW12z9MSdfNnPQdJnOTul7Bes09hIb5wD9uloFiiWANzqW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246716042"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="246716042"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 23:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="628225747"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2022 23:37:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 23:37:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 23:37:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 25 Jan 2022 23:37:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 25 Jan 2022 23:37:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfCEkprqy62Y3i0nLBcWRDP9Oq+X3FKcgqbFySJ58OvHBsZiV7dOdL9h0aBs+fXESKqZVpcLKTx+xZjK/oz0fLYDnBuevTEZzoipqtKoc1I3U+XsgZKOEJWCJqBSQhjQ8gDaxEjwNj1uQg03dDFVbhg5/fTsJ6N7KzdlGyXM4NdRxcGfovsFEUfKSsHRQwDDm5xqtCQ0KOGX495oezh3c7q6sJ607DBOvKD2cX3ldvrICUpsaUDp9dIu6TaMxZkT+Uo41ykG0Qf7UGT7P960iQlA1Xwanxcq6ARBMqTFgUQsw1iw7lGDkd+B3ioOqp4k0LRMThW8E9tijMnrlIE75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnvbmfa4s4eSqZoESpK80plRht4BvWfMf+d38xYiFhk=;
 b=VOv6t/b0hG+E4pY0zPDF4UiVqNC8hsqVs9QtIGQHvavLGFgxsFwtFT3xw4+OZmUv8xwIE7NFlyot4tQPGAoEBMNLn2eMkEsbtqw/Bt2zXTgs4At0qEroPL4JBikivIl+1CncT3N3f5VYNty05abNM7JdRLvQ+EmYsLYefdaX4AXc7iYkA6S1F1PRJun9wG3HvZ24jCgJGiWWZHgT9/GQnqphDS0Zqg/0rNBKiIH2mO/J/VO071uSO/nIOCtzi+q+suctgmezNw87Oz3YlCopgzzdDwosDnXyJrcWAVYqZcQMsAkUn0HxPp8RnqL25gSc+ILZqnl4LPdndfjlscvExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6PR11MB3900.namprd11.prod.outlook.com (2603:10b6:5:19a::26)
 by BYAPR11MB2887.namprd11.prod.outlook.com (2603:10b6:a03:89::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 07:37:43 +0000
Received: from DM6PR11MB3900.namprd11.prod.outlook.com
 ([fe80::5033:7c94:f96a:1525]) by DM6PR11MB3900.namprd11.prod.outlook.com
 ([fe80::5033:7c94:f96a:1525%6]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 07:37:43 +0000
From:   "Ben Ami, Golan" <golan.ben.ami@intel.com>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        greearb <greearb@candelatech.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: RE: iwlwifi problems, maybe firmware related?
Thread-Topic: iwlwifi problems, maybe firmware related?
Thread-Index: AQHYEkCI4ctfUOxXUU6iV5VLFX3SGKx0ammAgAAnxgCAAFGLgIAABuhA
Date:   Wed, 26 Jan 2022 07:37:43 +0000
Message-ID: <DM6PR11MB39003AB7A5D7D27C9196E184A8209@DM6PR11MB3900.namprd11.prod.outlook.com>
References: <92b00b94-aff6-8108-06d1-932b77f9d218@infradead.org>
         <04761964-e3b3-b2f7-78a4-bbc3507ad676@candelatech.com>
         <0ee64c55-1326-addb-7c9c-c922373f78c0@infradead.org>
 <cb3e4991c19659ab73cc0d9c12e8b7dbba9d652d.camel@intel.com>
In-Reply-To: <cb3e4991c19659ab73cc0d9c12e8b7dbba9d652d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9ed72fd-d106-4741-b85f-08d9e09ebd5f
x-ms-traffictypediagnostic: BYAPR11MB2887:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB2887AB141A4E2E972D1EDB88A8209@BYAPR11MB2887.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDRgJPiKR/iPYILik1IfMUKQEpYxrFWtZPK+Y1ARE9IK3gY9CWZ9kQ+uJCksOJYQkXpNiBaLBIctjTimGcQrW7tfEDIHyY5gkRQXyuIXENyjnNf48l383+Wnjh3u1Lm0Me7As2V/CwdvUpHmgYTZtJbXtk2TXwAFTSRm0EoIsvMjeEHxtE9iDKHMMTtFupWQimuFQmUB1l3BtKD83Ik4UB3fGtK3KYtTPpKTwxp4EopYUZ2+RU3C7SHOEjSnxHUinytcwzi1hNDIaYITbRB7rJbrv8bTuUpO0rImgsB/3t0J6tAuQTo0IhPd9Qnx2vlXsyC5Qj78B57oxxK6DPMReOjF4KPslsFXQJYb2i7qw5SJVmC6Y/lPc5cmoVDTRc/cfg4kpM2BO1jssuIqYwl48jCMQLxkdpCkbFEVKkBRNA+Sqn13UvEk/KxY1x4hRFodKWl/jI+VJB/KHqf5uHHsd3ECNKc9BNprKARML1z8oH4ubwJcOYAuKD+z5iYxLvPxpp+Rqt9d+/6kUSt8s/N4Opkdp/CGTs8kupzcNsk/Sh4rF2oPPVPeRWpLfjj4h4a6THbUyD3JXT4/UlD9D+8RxLV9jHEB7YZNlJw1r6AnBpDaeEagDUf54KTe+B4dcwfiVb0dO63Yt6GyFTvTQJKUEcE8J/l+I4arj9MUsrCtJwiVzw+eogUecHgZ4vFEsAiJg2gg2yOR5ZTouyD2sHGXdRVKMwipxe09u4mP4ulN4kjht4Wy3mopsxL/ZoDXzccjlKzNEKxZE3kIJR1mcqtHDlpJNlvN2G0qLsK/lyXvGzE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(508600001)(966005)(26005)(71200400001)(110136005)(316002)(66476007)(33656002)(186003)(76116006)(66946007)(66556008)(64756008)(66446008)(52536014)(8676002)(53546011)(86362001)(7696005)(122000001)(9686003)(6506007)(38070700005)(5660300002)(8936002)(38100700002)(55016003)(2906002)(82960400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3FSamYzMmJzSVltYlBkak1JcFBMaS83anFGbXJYUm51NTRDVHIza1J3M1o5?=
 =?utf-8?B?SkxVemxFcVluU2ZXQ1R4TEV3RkExYTQrQmRJOHFWTWYyWlN5WWFuWURoRTQy?=
 =?utf-8?B?czBscmtNbkFRSGE5VEc2QkFFRm54Z3BBZHd0Q0NVOEFYLzlNQjhNVjU1cEZ5?=
 =?utf-8?B?Wi91M0pWU1llUGdyYUQva1EwWmxHWkdaNUI4eEdzS0xKSHF2bkRlSU5PZHJ2?=
 =?utf-8?B?RmlhTlVMaStCNnRHbjI1dURnTllzZjVtSTc4NnB3VkR1VCs4QnRuSlgzZmhB?=
 =?utf-8?B?VU1LeXBpSk5NWnQ4WG1seFk4MDFIczhzM2MxdlpyZEtkU3ZaSjYxRDFGQmF6?=
 =?utf-8?B?dVViZWZOSDZSd01BdmErcWgzTWRqdUNUemx3MVBIZUtQMXhMc3VjR0ErRjRv?=
 =?utf-8?B?SWhKZUkrcExEMEdvamlmK2xLM3QrR2N2WVh3RmFwY2RWRGxJN0dZZVNZVHFQ?=
 =?utf-8?B?eG16Z0NpdDNtRUp3UzJFWnJrdEJGNDM2T2pNOGRKdTNlME1uNFRzNkpiRWx3?=
 =?utf-8?B?elVXS2lHdERvVkpMQ1draWhJWnVtZit5anV6bzNoeTNkQjdNN3owVzIwRjNs?=
 =?utf-8?B?SGd2QTVhVE9vTngycDBucER3OTZTYlIrYVlEYmpVTm9rNWI2TUp0eXRyU0FK?=
 =?utf-8?B?WXpXSUZyWmdGaUFIQ1ZJaG53K3BqOVVrVGthR3RBL0dUTzJNQmsrbTQyQUJH?=
 =?utf-8?B?MVZRMVZwaXRVcUdLbjZZdlM4N0dOQWNnREt0MTVYcnJXQVNpM3RoS2ZMZGhs?=
 =?utf-8?B?M05ld3RLMWVzOXEvMTV1S3M4MEdzRXZCWDA1aXpqY3EzWkRvRFFZV0dqVVF2?=
 =?utf-8?B?Umc1VG1jdFdoV21sNndUN3ZyN0pJRmxMSUNXeDhCNWdONXVKQVVobVZUQkZs?=
 =?utf-8?B?bVBGb3p1VW9URHNFTENPdTNFVk8yOGo1Wk9taW4wOVpHRHcwT3N2cmI0bnpp?=
 =?utf-8?B?Ym02akNMZUNxQTU5TnpXZWl6THhpcXd4UjdlYUFjREtMRXZ3eS90WHIzQ3ZV?=
 =?utf-8?B?MGVtdC9tK1NJOHRhSkFOQkY3blpkVkdYRENZK25TYUxmVGxmME02Ym1oZ2lT?=
 =?utf-8?B?NEhPLzNJWktJUW1odDF0RUZXRnJoSnN0Z3VFRjNtakF6NnpESHNhSklycHdr?=
 =?utf-8?B?bU1lRVNhUE03WjE5Q1QyQzR1ckQwMXVvVTE1cERNVjI3RUNLYkFNNGg5YllD?=
 =?utf-8?B?bWhLRktIeTBhNGdYU3pRYWJKMExGZFJuemdLTmRpWmJudUFYY204eTltRXM1?=
 =?utf-8?B?bFJPa29qaXJnYzhmN2pjK1U5ZzN4TzNOYjUvK3dVSEt6c2NNZXdkVC9MM2x2?=
 =?utf-8?B?Mkl3RnRlZHhrR25xM0ZIbjE1SnRTcGV3aUZlMjBvOHRJN1MvV1dYa3NWMDJS?=
 =?utf-8?B?TVZlTjEvN3JYSmp4ZGh1VUlzOUVWVm1PQngvSUZOTWtnZ3BwR2h1QlhiUWo5?=
 =?utf-8?B?ZkdtRDlINTlWcDBvWDQvNG1VdnArV002TXA4OWtXYWJ1NnVaZ3orOHAwaFZl?=
 =?utf-8?B?b21JMmpUb3RtNEl0MDJ1YlAyZUpiRGNReXFzVkJtSTNSUEYvbzFyandzWjJX?=
 =?utf-8?B?dWdWR1g4akVQRUZEOTFETFUwWWRKdWtyeTlLQmU2MW5nRlVjR2t0RjdRQzRk?=
 =?utf-8?B?VlRQM0g5bVMxZW5sZnZSY0psKzNxSkZIN2VSKzAwVW9PUDBqODBqcEYwZmVL?=
 =?utf-8?B?d3lVcHVLZHZobVpBc0MycStKQmk3a3MvUFVxS25sQ2FHcTdQN3dpNlhsY25t?=
 =?utf-8?B?dHpvKzdJQlNESW1LY1pINnRoY3F0UU5MWkVuUTVEZWVacXpsc2E2aE96T2NE?=
 =?utf-8?B?NGtUcTQ2QjErcHp5MVk3d1BOQTVNWmpFZWpkeTMzMG4xS2w0dkFyMFBjeUpz?=
 =?utf-8?B?UDU0QWFKbUZnM2V3MUV2SGpJai9DWVRZY1N6TDdQQVFWUkZJZEJvdmRDS2Na?=
 =?utf-8?B?TlBVZkNkSDRQL0pIeE11MDY3V1dudlVzMWNKd3FrSUh0TllkNnhWUzhsZTlX?=
 =?utf-8?B?bGhQZzZXWVIvQ2s0RXZVeUlZLzZvY2xSTkh0TGJsckRHcjlNV04wODQ4UE8y?=
 =?utf-8?B?QjRnR3Bva1hZbGlybUpWMXN4cFpCRi8rYm95SktJbzhRVk9oQTdtYThjRGo3?=
 =?utf-8?B?bG9xMmttVGt0c01NU2FSUDBEWjIvenRQd0UxQzNSNUJBUlBnd01IeC9SVjNP?=
 =?utf-8?Q?1PdBP8/AcdiB1e2DPk3SLaA=3D?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ed72fd-d106-4741-b85f-08d9e09ebd5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 07:37:43.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXd3RTYL+NsHON6LFtpC76ioexBOt3nF7dP+G8pKXJ9AAdIaYRZfPfW7TsJvExXf5EX1WKPIHLgvN7WvZ5RtKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2887
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGV5LA0KDQpIZXJlIGl0IGlzOg0KaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVn
LmNnaT9pZD0yMTU0ODgNCg0KVGhhbmtzLA0KR29sYW4uDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBDb2VsaG8sIEx1Y2lhbm8gPGx1Y2lhbm8uY29lbGhvQGludGVsLmNvbT4g
DQpTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjYsIDIwMjIgMDk6MTMNClRvOiBsaW51eC13aXJl
bGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGdyZWVhcmIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPjsg
cmR1bmxhcEBpbmZyYWRlYWQub3JnDQpDYzogQmVuIEFtaSwgR29sYW4gPGdvbGFuLmJlbi5hbWlA
aW50ZWwuY29tPg0KU3ViamVjdDogUmU6IGl3bHdpZmkgcHJvYmxlbXMsIG1heWJlIGZpcm13YXJl
IHJlbGF0ZWQ/DQoNCkhpLA0KDQpBZGRpbmcgR29sYW4gdG8gdGhlIHRocmVhZC4NCg0KT24gVHVl
LCAyMDIyLTAxLTI1IGF0IDE4OjIwIC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IA0KPiBP
biAxLzI1LzIyIDE1OjU4LCBCZW4gR3JlZWFyIHdyb3RlOg0KPiA+IE9uIDEvMjUvMjIgMzowOCBQ
TSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiA+ID4gSGksDQo+ID4gPiANCj4gPiA+IFdoZW4gSSBi
b290IDUuMTYgb3IgNS4xNy1yYzEsIEkgZ2V0IG1lc3NhZ2VzIGxpa2U6DQo+ID4gPiANCj4gPiA+
IGl3bHdpZmkgMDAwMDowMDoxNC4zOiBhcGkgZmxhZ3MgaW5kZXggMiBsYXJnZXIgdGhhbiBzdXBw
b3J0ZWQgYnkgDQo+ID4gPiBkcml2ZXIgaXdsd2lmaSAwMDAwOjAwOjE0LjM6IFRMVl9GV19GU0VR
X1ZFUlNJT046IEZTRVEgVmVyc2lvbjogDQo+ID4gPiA4OS4zLjM1LjM3IGl3bHdpZmkgMDAwMDow
MDoxNC4zOiBsb2FkZWQgZmlybXdhcmUgdmVyc2lvbiANCj4gPiA+IDY3LjhmNTliODBiLjAgUXVa
LWEwLWhyLWIwLTY3LnVjb2RlIG9wX21vZGUgaXdsbXZtDQo+ID4gDQo+ID4gV2Ugc2VlIG5vdGhp
bmcgYnV0IGNyYXNoZXMgd2l0aCB0aGUgdmVyc2lvbiA2NyBmaXJtd2FyZS7CoCBSZW1vdmUgDQo+
ID4gdGhhdCBmcm9tIHlvdXIgL2xpYi9maXJtd2FyZS8gZGlyIChhbmQgbWFrZSBzdXJlIHZlcnNp
b24gNjYgb3IgbG93ZXIgDQo+ID4gaXMgdGhlcmUpLCBhbmQgcmVib290IGFuZCBpdCBzaG91bGQg
d29yayBhZ2Fpbi4NCj4gDQo+IFdlbGwuIFllcywgdGhhdCBkb2VzIG1ha2UgdGhpbmdzIHdvcmsg
Zm9yIG1lLg0KPiANCj4gSXQncyBvZGQsIHRob3VnaCwgdGhhdCBvcGVuU1VTRSBUdW1ibGV3ZWVk
IHdpdGgga2VybmVsICJMaW51eCB2ZXJzaW9uIDUuMTYuMS0xLWRlZmF1bHQiDQo+ICh3aGF0ZXZl
ciB0aGF0IGlzKSBhbHNvIHdvcmtzIHdpdGggbm8gcHJvYmxlbXMuDQo+IA0KPiBUaGFua3MgZm9y
IHlvdXIgaGVscC4NCg0KVGhpcyBpcyBiZWNhdXNlIG9mIGJyb2FkY2FzdCBmaWx0ZXJpbmcuICBU
aGlzIGZlYXR1cmUgaGFzbid0IGJlZW4gc3VwcG9ydGVkIGZvciBxdWl0ZSBhIHdoaWxlIGFuZCBu
b3cgdGhlIGZpcm13YXJlIHJlamVjdHMgdGhlIGNvbW1hbmQgd2Ugc2VuZCB0byBpdC4NCg0KVGhl
IGVhc3kgZml4IGlzIHRvIGNvbXBpbGUgaXdsd2lmaSB3aXRob3V0IENPTkZJR19JV0xXSUZJX0JD
QVNUX0ZJTFRFUklORyAod2hpY2ggc2hvdWxkIG5vdCBiZSBlbmFibGVkIGJ5IGRlZmF1bHQpLg0K
DQpJIGhhdmUgcmVtb3ZlZCB0aGlzIG9wdGlvbiBmcm9tIHRoZSBkcml2ZXIgbm93IGFuZCB3aWxs
IHNlbmQgdGhlIHBhdGNoIHRvIDUuMTctcmMqIGFzIGEgZml4Lg0KDQpHb2xhbiwgSSB0aGluayB3
ZSBoYXZlIGEgYnVnemlsbGEgZm9yIHRoaXMsIGRvIHlvdSByZW1lbWJlcj8NCg0KDQotLQ0KQ2hl
ZXJzLA0KTHVjYS4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBIG1lbWJlciBvZiB0aGUgSW50ZWwgQ29ycG9yYXRp
b24gZ3JvdXAgb2YgY29tcGFuaWVzCgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1h
eSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IKdGhlIHNvbGUgdXNlIG9mIHRoZSBp
bnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uCmJ5IG90aGVy
cyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQKcmVj
aXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGllcy4K

