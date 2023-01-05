Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5120265E58E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 07:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjAEGVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 01:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjAEGVm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 01:21:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E965B48832
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 22:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672899701; x=1704435701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0ep4t94D6/uHuXZvrlBdJ3rm61a/+etQLQbt3XeZ+k0=;
  b=hv87BM8s5Y/TQ4rC2qbtvBG6ULdr+Hn832UkdyVvK+1cTsoTRXkiA691
   fkeyMUbdbjlZNbHTzJnEgcTGoPKh6ERomV/cy+V4sdyDy9uDsSQAgbg0H
   7fLsz4RBpapRpm5tbPCHodUPG7fJUF5q6WThdqukbJdY5vImGeDGsuR4D
   ASLbNvTNSipVaX2ui4Ef5yfyV4eCd5FtjKWuzEgfbupg9RHV82VDtY1Gs
   1qpShZtl6nzbmNpS1nyX8m+ZxkiSY0gSNoV34A8UEyBC6RODqml64ogQA
   VL4v1yXU7pfoG1kGa12bDk9kPV9iVZz+CBmMhBI50NSf+aUEzmKT96mpn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301821809"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="301821809"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 22:21:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779470354"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="779470354"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 22:21:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 22:21:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 22:21:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 22:21:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 22:21:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgzPq8v92lsuxwt/b8I4bQFOcCSWZXDED3NF8wsYwiJRfqy26LOg9sLQ/c3WHnxodfPkZ/stcQZ/AnonQfdIWUpIhO1CsPN7EsUEH16qpQwweJKO2KnDnOs9r82EnQKy2AfUaZKjpfpVjbf8e3PBmYROl0pKhNEt384V5Vy1WJ6HTNqFYKG5MwBTvyv+MDJi4usS/N4EqfBuaM/5cJaYenNAcLuyhVnAWOL675t6FsE9stL4Yiz8TpuN6krctKPMMLgy83LUq7CRla8HNiXb87+oK9vXedHUrKgayIGx5+ypLbat6q13SQ9LjM+KmX3Tv4PqC3nOYxpca4Xt0gxU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ep4t94D6/uHuXZvrlBdJ3rm61a/+etQLQbt3XeZ+k0=;
 b=jLrAiAMCQviJBybnZVHNLTv2LGUU2+n+48KhvdyTJMLWjx8gf/NHv1ALOpYKJEjX7k9NQzvXjtePVFnIPRw0f1HCG64P+Khyw8m84TTiyHzLwtctp8I431W8CpSvF0I4xHwSmhdmVtHEXazDKN4yaHuvqrUw2uSpTIGweReY0nj9mvMqZtC4FrolgMUNJd3inV494TJ9m8ozlwIJZUZj8def6/QtOizOmN7RA8BekvUgMh3dUYcsZcMRAOqJhJAhGF49b77gkHOa/Sg3a7wrTdxeFPubNJvI7VLYh3+1xsyQ6VKQPcMGx/1YYt5NtNGWPxpUtsdYu1SJBjhx8RihPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:21:37 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:21:37 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "aiden.leong@aibsd.com" <aiden.leong@aibsd.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH 2/2] iwlwifi: pcie: add support for AX101NGW
Thread-Topic: [PATCH 2/2] iwlwifi: pcie: add support for AX101NGW
Thread-Index: AQHZHlOjuF2abI1yS0mxGQy3aQuRuK6LIWMAgAAHBICABFSNAA==
Date:   Thu, 5 Jan 2023 06:21:37 +0000
Message-ID: <ae38f167ef5f16cac767db4b7a20984731e8b874.camel@intel.com>
References: <20230102024038.2915-1-aiden.leong@aibsd.com>
         <00a7a47051ead3032f383868248d89e56d3617f4.camel@intel.com>
         <708fad8b-0419-ae7f-8586-7da58b50d925@aibsd.com>
In-Reply-To: <708fad8b-0419-ae7f-8586-7da58b50d925@aibsd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH7PR11MB6699:EE_
x-ms-office365-filtering-correlation-id: c15de89b-ef92-45a7-23fd-08daeee519ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QB1pEwou/jDspNS5hrEPE5mf+HmvzoPS7SZ+Lb7amXU20TFc9G6YSwdMYGDzjFPt8nBQVXuk0PMSz3pyFmM/I26Ib6toQFiQqvK8AuYGCNuy/CLHZs8lLR2YiVZTf6I0EDbW78NLxhh4uN03QE9vSeaWJ09wOP8+O9cVBuL+VgUtxIA9YaSzQqWD6LubKixLMkfPF9GKPeYCi6U7P4mCc2ZGH11amVnDTpangqL3D++iI6eqTBe7J9xv1TLYxlw2qwL4ksSW88b4Exg3zO3Nry35KIlwq4VR41HvNSmojzwJRlNLL8L1/C4kYrvet5Ro635T26OSW0S+yH7QGiXq4H2To62FgVBxoqY7VVf7TRhEr89/QQtEG5A8O0H9dfinCOwlgS77fwRRiOt4iW1xpCRBPtE01CBQhDusjn1PZIJXPuNRvgXthnyv9B8TCUmpaDvjmM3FyxG7nAbwIgYv6Zusf/U7qr6+yV71FWt4sJSTh26xq3g5TWV84EiwPZ09KT+UOkA1R2wQ7MPhRmnGmZWZFFbLosqzPig9waxgz0eojVWWRDdgS0VToM/Zb3STfbP5e+3SMDLEKlgnWAwbVQIUhlR4Lp77909HlqIw4/F8AN3RrqEEEUm17XjDAxQn4ZGCx4ro7sbtH1cH8gt+Kza1FK8GfUdXLVUD3xLIgM8kvJNugOQsn+xoWGesZOxIcXC2pB2CWoPH2JFQM2aWZy7h4D21x9MS4qmVxHnBN7wdQ4KERfFB2/Ka+1yBvGOr2qhC141iByWO2nJfCgiXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(6506007)(53546011)(36756003)(478600001)(71200400001)(6486002)(82960400001)(38070700005)(122000001)(38100700002)(6512007)(186003)(83380400001)(26005)(2616005)(86362001)(966005)(110136005)(8936002)(91956017)(76116006)(5660300002)(8676002)(66946007)(66476007)(66556008)(64756008)(66446008)(316002)(4326008)(41300700001)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUgyaXA1eEJabkRIREl0VFE4ZFBtRkl2RjhJdk9ScENXc3VvUFY2bm9oREMy?=
 =?utf-8?B?eEl6RHJSbjJ4TGtWd2FSL3NDa0NFeVp1dWZXbUdqd29qZE94ZlBXYWl0K3dh?=
 =?utf-8?B?dzNVY0gyU2gvTnQ3UDNqSWNiM3Zjci9hTHpqSzg1UE8vekVJZUM2SVBGZVpZ?=
 =?utf-8?B?d3BNQnplNkdMUXlrWm5hQ2NCOWNjK28rNTNITHp6Ri9uYmFTeVMvNTlrS0ZZ?=
 =?utf-8?B?dHowTUttT3NzUGxSS0dOV2ZrWTRHbGN0V0NsaDd2VjZhaXo2dDJnWlpmZ2Z3?=
 =?utf-8?B?UTBNODRhMWFKR1hwam9CdGxVY1JqSFl3VWRZSWEzUjIxQ3F2amJpWWVwVWlR?=
 =?utf-8?B?RjZkRURqdW8wZGFxN3hlTHEvMFd1aWl4NDVGMExneWVsMDZTTWZ4ZWZ5d1Ev?=
 =?utf-8?B?UEE5RDlKbVdsNHRQOGJUdVVnK2Z4TVhHeHdteFd3K1I3YmtiMVJHREc5Ky8y?=
 =?utf-8?B?emFSSXZCNXVLTUhqakpHQUNwSnhaMEFaazJ1eXVWM3VnVWlDK2ZpRXhSb2Zq?=
 =?utf-8?B?NDFHeHNFM0x5bjBLMHdrM3B4enF1TzRDMy9zSjN2SkNFbmloTWExUTMvcHha?=
 =?utf-8?B?V2lVMUIxNnRBUWxHUWtvSmFkQkpyWGFqWVBJNFdlbmwwRGl3aTZuakVUdG9r?=
 =?utf-8?B?ZmM2ejZGM3BVNldYOCtCMUdPSjErRjVscFl3d3ZhN1hQalFFa0hrejN3ZGZE?=
 =?utf-8?B?S1Jad3pjTmxwZmtUT215VE5xVWRnbG1SZ280UGtoUXBzdXZIVXdIMVdiYURF?=
 =?utf-8?B?Unlab25yU2w5WVRySmxma3hXL0dGeUQyb0NQZFBKQkgvODVWb0h5cXB5UmM1?=
 =?utf-8?B?WXZHSU94dVZJUS91MWJiWTlBVTZPU2poQ1hVOWNMTzNhMllyRnU5eHVmMDVl?=
 =?utf-8?B?Yk9FemJuK3Z2U1dTVTIzOGw0NWJRdGVtRHpTT2N1UEs0bzhoazdmbk9zWldn?=
 =?utf-8?B?K0lraWIzWkp2bFRYK1RZK2cwSnBFdWE1ZUdsYVpWRnBPLzBxUjJpWnBjakxn?=
 =?utf-8?B?VmROVk5nb3NBTjcvRHBZZjVuZ3hXK1NodzBpdy92NmhKaXZOUTVaWHc1dHJV?=
 =?utf-8?B?Vmg2YVBJa3BKQWNzYWFkVjNMMVYyaGZ5cHFVdnpTN0RzT204QWhEZmNwTFpG?=
 =?utf-8?B?NUtVVlRVaG04V1cxMzVGd2RKeFEzZURMeDJ1Z2FWc3pvdEtGK1crVUdHenMv?=
 =?utf-8?B?MzE2SERaV0NWTUQ3ZE9hUVdDR012YmJmSGoreUxNSHZmWlBjOTBKeHBDM0RS?=
 =?utf-8?B?ZGZ2MWNNNkNJcGV1Y2cwNm1Kb3pCd0pveHU2SnFhT2tpKzhyN1RGZGhLV0xH?=
 =?utf-8?B?amlvVVU0S0E0MklsNnVVOGRwWGdCN3B6cGFoVUxtQnFqRFNJWWhMK3hSdnR0?=
 =?utf-8?B?MEY3NytoS2NuS1UyU055alNxUWpCM2k5Q05ib0syRU1ROTVzYU41anBMSnNr?=
 =?utf-8?B?VHRjN0F6K3lxeVBlQjVoOHFGZ0VlVDNFd1JiZGhGTmQ0NWgyZW9JMnN3bTAx?=
 =?utf-8?B?OXlhdnNwaUFWZUtrd2phL0dVeEEwaWVyOHc4SUxuTVk1Z1J4cy9Hem1aZDhx?=
 =?utf-8?B?eE1meHJrcDEzTnc2VEU4RzVrdU16MkpiekMwS1JwMDVFcXN4SUN5TTFJemhE?=
 =?utf-8?B?YldWMFBoVjNsYXZoZGRmd3lYdTNnVlRZK2dzY2hxVVV5TElXTDlhNDVNWUdO?=
 =?utf-8?B?bUtlbGg5RUZIVEJmY2RsWXlMQU55QlZIYXZBRUVMbnNRWER6QWY0UnZHMklC?=
 =?utf-8?B?NXUrcENnQjZwZmFvKy92aXJNUFMyYWxIQk9OZlZQTy9yS3hKQ0ZLaU5kMGVk?=
 =?utf-8?B?RlpxVXhXNi9lcGt2SHJaMmlRenFhVkJqRWd2czlBdEMzUFVNZDRNWFJabFM2?=
 =?utf-8?B?c3p0ZU9OVk1Fc2hiaTMwZEk0RTZoRHY4MFhFTjUzdG1yd2gwRERVcHJHR1JH?=
 =?utf-8?B?Z3hzcXpuVmxjU1VPUCttZjVkUnVGQTY3TXQrVEgzZkVUU3Nub0w0WUF2UEhq?=
 =?utf-8?B?VGF1VHZzVWE5amN2UFJ4M1MrWEFzSVF0R0k4M1FtYklpOW9TY3pWMjRsL2VP?=
 =?utf-8?B?MTN5WlYxS3Zoa0t6RzlaaWU3ZnBkeEk4L3QyMXhud2crWi9paDFPSForYzRG?=
 =?utf-8?B?L0VwaFgzOWhEbUh4UUFQYmFSMkx5d3c1aktqYWpydU1iOE1uTzhqWE5wWkRi?=
 =?utf-8?Q?S62RuYHUTIFlFahXsHmccY0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F140C923C6CCC942A9EE03A7404BCA42@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15de89b-ef92-45a7-23fd-08daeee519ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 06:21:37.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/cmBkGEFjgfCRhdJdNwGJM4jeQixnbs5Lg1V+tfHa7ksgKMDZNam+MZrcRjLXdCSMo1+G0xyxpQC8HmlS96CMt35BEgY4rdCDN43E/5ewQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTAyIGF0IDIyOjAwICswODAwLCBBaWRlbiBMZW9uZyB3cm90ZToNCj4g
MS4gUGxlYXNlIGhhdmUgYSBsb29rIGF0IHRoZSBzZWNvbmQgY29tbWl0OiANCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvaXdsd2lmaS4yMDIwMDMyMzE1MTMwNC5lYzRm
NDYzYmRlNjAuSTE0ZTkxNDZhOTk2MjFmZjExY2U1MGJjNzQ2YTRiODhhZjUwOGZlZTBAY2hhbmdl
aWQvDQo+IA0KPiBGaW5kIHRoZSBgZ290byBmb3VuZDtgIHN0YXRlbWVudC4NCj4gDQo+IFRoZSBs
b2dpYyB3YXMgdG8gZmluZCB0aGUgRklSU1QgbWF0Y2ggdGhlbiBicmVhayB3aXRoIGBnb3RvIGZv
dW5kYC4gVGhlIA0KPiByZWZhY3RvciBjb2RlIHJlbW92ZWQgdGhlIGBnb3RvYCBzdGF0ZW1lbnQg
d2hpY2ggaXMgaW5jb3JyZWN0Lg0KPiANCj4gDQo+IDIuIExldCdzIGdvIGJhY2sgdG8gdGhlIGZp
cnN0IGNvbW1pdDogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzL2l3
bHdpZmkuMjAyMTEwMjQxNjUyNTIuYWJkODVlMTM5MWNiLkk3NjgxZmU5MDczNTA0NGNjMWM1OWYx
MjBlODU5MWI3YWMxMjU1MzVkQGNoYW5nZWlkLw0KPiANCj4gwqA+IFdlIGRvbid0IHdhbnQgdG8g
Y2hhbmdlIHRoZSBzZW1hbnRpY3MgKCJtb3N0IGdlbmVyaWMgZW50cnkgbXVzdCBjb21lIA0KPiBm
aXJzdCIpDQo+IA0KPiBUaGF0IGBzZW1hbnRpY3NgIHdhcyBtaXNsZWFkIGJ5IHRoZSBwcmV2aW91
cyBjb21taXQuDQo+IA0KPiANCj4gT24gMjAyMy8xLzIgMjE6MzUsIEdyZWVubWFuLCBHcmVnb3J5
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMy0wMS0wMiBhdCAxMDo0MCArMDgwMCwgQWlkZW4gTGVv
bmcgd3JvdGU6DQo+ID4gPiBSZXZlcnQ6DQo+ID4gPiBjb21taXQgM2Y3MzIwNDI4ZmE0ICgiaXds
d2lmaTogcGNpZTogc2ltcGxpZnkgaXdsX3BjaV9maW5kX2Rldl9pbmZvKCkiKQ0KPiA+ID4gDQo+
ID4gPiBBIGJ1ZyB3YXMgaW50cm9kdWNlZCBieToNCj4gPiA+IGNvbW1pdCAzMmVkMTAxYWExNDAg
KCJpd2x3aWZpOiBjb252ZXJ0IGFsbCBRdSB3aXRoIEpmIGRldmljZXMgdG8gdGhlIG5ldw0KPiA+
ID4gY29uZmlnIHRhYmxlIiksDQo+ID4gPiB3aGVyZSBhIGdvdG8gc3RhdGVtZW50IHdhcyByZW1v
dmVkLg0KPiA+IE5vdCBzdXJlIEkgdW5kZXN0YW5kIHdoYXQgcHJvYmxlbSByZXZlcnNpbmcgdGhl
ICJmb3IiIGxvb3Agc29sdmVzLg0KPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQWlkZW4gTGVv
bmcgPGFpZGVuLmxlb25nQGFpYnNkLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gTm90aWNlOg0KPiA+
ID4gUGxlYXNlIHJ1biBmdXJ0aGVyIHRlc3RzIGJlZm9yZSBtZXJnaW5nLiBJJ20gTk9UIGZhbWls
aWFyIHdpdGggZGV2aWNlDQo+ID4gPiBkcml2ZXJzLg0KPiA+ID4gLS0tDQo+ID4gPiDCoMKgZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jIHwgMiArLQ0KPiA+ID4g
wqDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4g
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9w
Y2llL2Rydi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5j
DQo+ID4gPiBpbmRleCBhNDZkZjEzMjAzNzIuLjVkNzRhZGJkNDljZiAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jDQo+ID4g
PiBAQCAtMTQ2MSw3ICsxNDYxLDcgQEAgaXdsX3BjaV9maW5kX2Rldl9pbmZvKHUxNiBkZXZpY2Us
IHUxNiBzdWJzeXN0ZW1fZGV2aWNlLA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFudW1f
ZGV2aWNlcykNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
TlVMTDsNCj4gPiA+IMKgIA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgZm9yIChpID0gbnVtX2Rldmlj
ZXMgLSAxOyBpID49IDA7IGktLSkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsg
aSA8IG51bV9kZXZpY2VzOyBpKyspIHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBjb25zdCBzdHJ1Y3QgaXdsX2Rldl9pbmZvICpkZXZfaW5mbyA9ICZpd2xfZGV2X2lu
Zm9fdGFibGVbaV07DQo+ID4gPiDCoCANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoZGV2X2luZm8tPmRldmljZSAhPSAodTE2KUlXTF9DRkdfQU5ZICYmDQoNClNv
LCB0aGUgZml4IGl0c2VsZiBpcyBjb3JyZWN0ICh0aGFua3MgZm9yIGZpeGluZyBpdCEpLg0KVGhl
IGNvbW1pdCBtZXNzYWdlIHNob3VsZCBiZSBhIGJpdCBjaGFuZ2VkLCB0aGUgImdvdG8iIHJlbW92
YWwgaXMgbm90IHJlbGV2YW50DQppbiB0aGUgY3VycmVudCBjb2RlIHNpbmNlIG5vdyB0aGlzIGZv
ciBsb29wIGlzIGluIGEgc2VwYXJhdGUgZnVuY3Rpb24uIEFsc28sIGFsbA0Kd2lmaSBjb21taXRz
IHNob3VsZCBoYXZlIHByZWZpeCAid2lmaTogIiB0byBzZXBhcmF0ZSB0aGVtIGZyb20gdGhlIHJl
c3Qgb2YgbmV0ZGV2Lg0KVGVsbCBtZSBpZiB5b3Ugd2FudCB0byByZXNlbmQgdGhpcyBjb21taXQg
b3IgSSBjYW4gZml4IGl0IGJ5IG15c2VsZi4NCg0K
