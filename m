Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB407EDE69
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 11:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjKPK0Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 05:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjKPK0X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 05:26:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8571119E
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 02:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700130379; x=1731666379;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=D2Bg2+gIovrdnKXwE62W8wmnQafBp+ONIzkTKVdV4ic=;
  b=EiC7xJhaSluux44UgRJwRPBdRlbT7HonByCxOHbGtkpuJrhDNNyWeQHP
   LwugJ2BXaIhiW8oSOndHIcoXZYy9h3IQ+F5dgTa/jxumhxHXzpaZpRwUm
   I3auZ4d3oOuF2Hjp7oGiBF7GCz23fFEy7MdWPGMuKcYP8i6BTG+TPWGNV
   LhhZYchNpJrosHfIpqZJVFYpcIpqgN+2UZ/xn1S2WT/dKgPIfPEEGUyDH
   n/0/8zYh8jdXdJT3MaTP4Fnlms94MIn6z+oda8twMjpMpUYLo7ZO064Ip
   ekrXcZFv4RWDGoVib2OG5UJpIOwVwyo6eb/+sjZxYPDbkC1JeUliuIlZe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389920810"
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="389920810"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 02:26:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="13077723"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 02:26:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 02:26:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 02:26:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 02:26:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 02:26:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX49Z3w7gElk+I9V+hBFnp+rkQQBVf3tnkiS7G81gTSrHFaIIJvF2Wz0tMbnB97IG4aX8AzM5NH6ZX+TeCW4oF6cYSsVh5OFf0hv/cpQYtAd0L1eVBBSjuKWtmKDg0R4t0oJVwxZbwkbRJll5N0V/VmOYD4vwMGtm0yfqQl/QywLR8XSLYU3zY7ASfFmWpUJyMSueXxxTYb/kiPvtKZKGqJzBxX2IH9wi/d9QnXOVsM44jvHy/3LdLG0MS4uVqgHJS04cVJFqb3OXSnBXl/U5dIsZAvczlKnkDasJFbJP31K4MwoNUKkyOfejo8tnFxq5F/prz5UnqWYQm/k8I2rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2Bg2+gIovrdnKXwE62W8wmnQafBp+ONIzkTKVdV4ic=;
 b=kYz6NcOqVE1H/daWvj3ZAugxJ6rQtdmWIoHd8gqc4Rp/dPbbhdGmGy9xTHxvZsvcVZeogLWBTg7LbWq9p0Mf+foEvFppbLcrE7Qq8qA8CaNMbBLBUQtyzhngSEtLQzzYRXJ+G9W3Y4/D6ESFqpozLu6IgR8aata9gXMAlMn+KzfbB8O5Yvnq275wj8DaHdSo1ZkrTaFMa1JYwXPhWRUlBSxEhaQHAFTOAcYI0gueLM7OPb3jcMpK28HLEF3saNJzbso11bBXl6wSX8xVNsQWHWsYBRSVVrFQPqYQ/IVuuMk5pdtyALkSYgFPF4gHsBihxDsl61NqqFoyE8zor5pFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 10:26:14 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::b045:b0aa:bae8:706]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::b045:b0aa:bae8:706%6]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 10:26:14 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: iwlwifi firmware updates 2023-11-16-fixed
Thread-Topic: iwlwifi firmware updates 2023-11-16-fixed
Thread-Index: AQHaGHdTlVpHcGYyJk2V+p0yvIfLuQ==
Date:   Thu, 16 Nov 2023 10:26:14 +0000
Message-ID: <877cd7e05d187b48ec2615c7b4c1def200370eef.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|MW4PR11MB7103:EE_
x-ms-office365-filtering-correlation-id: ca1d89a4-70ca-4001-935b-08dbe68e7629
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtNlZK0a+cfVwr0xfUMGaP1eZZQ/gS90Hi0hoQqx1/+nDeKKe6sn0IWG7BKW4E7lnxAcisj2qdvW4IgEx9fbRpj6SaS9qXgBsva9SWi8chIAEiGl0xONnV1vwui6ZnOvAs7bjJ6WfFmEVhSeKgDuB4apR/ggdD+oQvoo+4HV5lJJ2R/6mEKtTGt8RVb1zbulvd7qbND/DBDq7IOiXn+SNVpnfzw0rsh1d/5dCafTLw7IcjFChZb/JRvE+ZMfa3v0yzr49/V8ZpmjEq6RCTKKQoN3DJXibe4Kph95TF/2oa0D1rMnWXZIoUkENf4s7Eq5czlEKtAsr6ArUiBvdi3CFHyoGXhKMG75N/mNvHHFVedvZWqdn3q5G/lORdTATRU5yVjVKc0YKYB8bKHXyVz0j/JUd+X03KZd25CH/HFUYBNkfNh4mPKenbzqKoJKHqM/ypwmMWctt/HYgW5D2XzxzIUXOUlzW5dklHc5hMjjlQ0cn4aE7HN9g0iDBSWMnidBthXhV6Nh3vPGRGjbZRdoB1ax7DCchFPWS8yln7NkJGwZrIH6HCNJBNA095dDPLQuB2V9rGxj0aG/ssSiMykU3bxImHPC9GZ4Ms44zd1E9p8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6486002)(966005)(478600001)(2906002)(6506007)(6512007)(4001150100001)(2616005)(91956017)(71200400001)(86362001)(5660300002)(316002)(6916009)(64756008)(76116006)(66476007)(4326008)(66446008)(66556008)(66946007)(8936002)(8676002)(54906003)(38100700002)(38070700009)(83380400001)(41300700001)(26005)(82960400001)(107886003)(36756003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTZ6MkZoUzVmaXJ2U1ZtaWhFMUE0OWlwK2I5Sm15RlF1M2NTbzFLbkZPRUtR?=
 =?utf-8?B?SklNUEw4dUUxZDErZklDWklYdnVVenZNK0p3SE41NEpuWWZkamQ0VWNENk9v?=
 =?utf-8?B?ME1ScFVjazM2LzNnbm50S0JTcERRQ0FxUmNTQmI4Ym1nNlJDemVwU081bGJ5?=
 =?utf-8?B?L0Z2NWZmbDRuNTQvU3UwSFFkMGFwWlBzVndtbnVyOTFSdVlYOGpXbFkvV2RY?=
 =?utf-8?B?VW13eGUwek13QWJYQ3hYRnZBdzJWd1lKVExRMVNvRkxvUnRmMTJFTzRET2g3?=
 =?utf-8?B?eWJVeDJKVDdDKzRoTXVrVDdnV3JYdGdvRlFRdUs5YXpyTXV3UHhmYjc4THJp?=
 =?utf-8?B?eSsyR0NsUmM3WmpCUXU5WWE5S2ppSTdHUE15b0VNRmNmcUdBMEhWZGx1SDhn?=
 =?utf-8?B?UHJVcVcrZGUrKzczK2ZuWVFnMnZNV2xXMUtObnBlTVAvU29DNy8zZTlaWVhR?=
 =?utf-8?B?Vy94cHkwOUJiWEo2K1djQnhjSW1JYUs4enB0ZWtadzN6TCsvZHNWZzJ1VTlm?=
 =?utf-8?B?RzJWUVhvbUVqd05oRExnS09WK002TGRrU012U0ExWjlZT1JMWmhIQzFqaHhM?=
 =?utf-8?B?c25Ja2hDK25BNWkvNVJvK1EyQTE0d3Rtc3d6ME1jeWV0cVBDNGNRK2Z5MjVh?=
 =?utf-8?B?SUx4aTB6UTFESExSeW0xaUtvczZ3aWkwOENremJQRXBMS2VDTjJqR0Z2eDhJ?=
 =?utf-8?B?T25vcENLRXN3Q2pEb3RhNGt1bk5meStjNjM5TzBmeklObXRSMkxqUFg2Vldj?=
 =?utf-8?B?TzM0RzNZKzYrZWc0UkovdWFYRjVWR2Nob1dwWGJIY3paN3R2Z3dOUjhiWENF?=
 =?utf-8?B?V0pNV1luVC9zOU5WZ2E0a25VdU8veVRwbjdHTnk0cXJocXMxeFJaRGlBakFG?=
 =?utf-8?B?dDVlWG5yalkyVTFkWitoUXRwcmhJS1lCdlFBdVhMc3ZYWThVNFNpLytYNXFB?=
 =?utf-8?B?MUFKWVNwYndrbmhPQnh3Rmhxd1RvdTNKTEdEYjdJWFlnc2xVQ0R1NklzQlhl?=
 =?utf-8?B?ejNCa3RqTzhub1FKSnVLRGJqUHM3WHFPdE5ZQU5LUFNESEs0dFNIODc4MmFB?=
 =?utf-8?B?M3ZVajYvNzN0ZVFxeXVZVHRDZWRpZjd3Q0JTTmsvOVRMSW8vZzQxNFRoZk0r?=
 =?utf-8?B?YWVwTVQybVVUSVMvNWdFalBFdFpmQ2s5VDVwUmRzQ29OQURLbktaVDljUDdm?=
 =?utf-8?B?dWtGdkFuWnd5M0xUTEJuRklsVUhQOG9renRHeU5BaFBnVEV3V0hRblBjYjht?=
 =?utf-8?B?M1k5YkM4MktMSURBNU1Nem9PUFFhc1NBaUVKUU4xM0l5V0Y2dWsvUFpsUFJI?=
 =?utf-8?B?bzNJMm9mdUZ6cS9JdWliSTIwMis2T1NzOW5KUFZFa3VqcEx6am8rSm9FTDlP?=
 =?utf-8?B?aE1HMiswQklmUzJnWjdPeU1aUDUrZmEzdmxQN2dwcEl5Y2cvcGZrV2Zjc3hV?=
 =?utf-8?B?VklrbVRiWGY0UkhXUXB2dFZIbEkxMXdrZlBoNitSRlExdHIveStUdjBkUVk1?=
 =?utf-8?B?VTBBRDB4UFJTelZPMmV6NVFjWXNsejNDdGUvOGgzbFZjZU5ZUDJ6UHgzUmZy?=
 =?utf-8?B?WXBhbmpXa1pCVE82UmV5S0hUcUZVeE1wWlNpcE9mbTg5ZkxKVkdob2RzV2gv?=
 =?utf-8?B?VlRhSlVLSGFLbnJ5SmhhTkFONkRmbkxwSFByd0h5Y25KWmNmNlkxVFZOWER5?=
 =?utf-8?B?VHB1U0VWSTZPNlBxc21sK0dJTWJzZXYwK05FN3VRSjV2Nk9kN0hkcGJYV2I0?=
 =?utf-8?B?Tno2NHh0VzZXc0creFVFYms2Zi9hUGRoY2F0d3hXNkhEZ0EyeDZtM2dNbFJu?=
 =?utf-8?B?NWNVcjgrdzR5bG1vTSs2VGU0cEE0OFE3WWlLM3UwMXBicU9EUFdMWm9IeHZq?=
 =?utf-8?B?L0Q2Y3orMkNJNGJvc0JTOHl0MytsM1I1T2NFZlJKOU5MNk1uYzRCUEN2aWFv?=
 =?utf-8?B?MnR2L3NycW41ZkJncHNLNzAyZC9VWFlVQXFPYjBVeGt1ZCtHVzdha3FvWExj?=
 =?utf-8?B?VUlyOHdsWEtyM05zS2Z0VEgzb29rVnJWRVcwdXpGUnhJdlVYakRqZHFqd1VY?=
 =?utf-8?B?R1d6ODhVTk9GVW1EVnNvTFdBTjNnOHRXSUxYVDJFOWM4d1FHK0hZUWFWcnhN?=
 =?utf-8?B?QkdaRzM0dTVoNkpYaitrVVhqVFhMOXJwZFpmdGRIdUpWWkRYTGk2Q3FuKy9t?=
 =?utf-8?Q?0+QiFwzQ2Bx2LbQq0j6m13E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3561BCD7503014B92799358096CE666@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1d89a4-70ca-4001-935b-08dbe68e7629
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 10:26:14.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrlO8BuwgwQyjmp4n6hEzRhFbdDK7iPuBMXCwSlgZdPYKUIVFi+UuGqelSYd9Jf34HvjLryj1XkmNkjtCY1/kDAG0W/Og8sLvfuvgjBw3kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgYSBzZWNvbmQgZml4IGZvciBjb3JlODMtNTUgZmlybXdhcmUg
d2hpY2ggaGFkIGEgc2lnbmluZyBpc3N1ZS4NCkl0IHNob3VsZCBiZSB3b3JraW5nIHRoaXMgdGlt
ZSwgc29ycnkgZm9yIHRoZSBtZXNzLg0KDQpQbGVhc2UgcHVsbCBvciBsZXQgbWUga25vdyBpZiB0
aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhhbmtzLA0KR3JlZ29yeQ0KDQoNClRoZSBmb2xsb3dp
bmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMTI0YjY2Mzk2YWM3YTZkY2U3MjRkMDRhYzdiM2JjZWYx
ZGIxZDU1MToNCg0KICBNZXJnZSBicmFuY2ggJ3JvYm90L3ByLTAtMTcwMDA2ODk2NScgaW50byAn
bWFpbicgKDIwMjMtMTEtMTUgMTc6MjQ6NDYgKzAwMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhl
IEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHA6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvaXdsd2lmaS9saW51eC1maXJtd2FyZS5naXQgdGFncy9pd2x3aWZpLWZ3
LTIwMjMtMTEtMTYtZml4ZWQNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGYyN2Rl
YzYxNmUyOWU0NGNkOTA2NDU5MjZjMTQ1OTYzOWQxMTJjM2Q6DQoNCiAgaXdsd2lmaTogZml4IGZv
ciB0aGUgbmV3IEZXcyBmcm9tIGNvcmU4My01NSByZWxlYXNlICgyMDIzLTExLTE2IDEyOjE1OjUz
ICswMjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpGaXhlZCBmaXJtd2FyZSBhbmQgUE5WTSBzaWduYXR1cmVzDQoN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCkdyZWdvcnkgR3JlZW5tYW4gKDEpOg0KICAgICAgaXdsd2lmaTogZml4IGZvciB0
aGUgbmV3IEZXcyBmcm9tIGNvcmU4My01NSByZWxlYXNlDQoNCiBpd2x3aWZpLWdsLWMwLWZtLWMw
LTg2LnVjb2RlICB8IEJpbiAxODQwMTE2IC0+IDE4NDAxMTYgYnl0ZXMNCiBpd2x3aWZpLWdsLWMw
LWZtLWMwLnBudm0gICAgICB8IEJpbiAyMjY2NjggLT4gMjI2NjY4IGJ5dGVzDQogaXdsd2lmaS1t
YS1iMC1nZi1hMC04Ni51Y29kZSAgfCBCaW4gMTY5NTc4OCAtPiAxNjk1Nzg4IGJ5dGVzDQogaXds
d2lmaS1tYS1iMC1nZi1hMC5wbnZtICAgICAgfCBCaW4gNTUwOTIgLT4gNTUwOTIgYnl0ZXMNCiBp
d2x3aWZpLW1hLWIwLWdmNC1hMC04Ni51Y29kZSB8IEJpbiAxNjcwOTQwIC0+IDE2NzA5NDAgYnl0
ZXMNCiBpd2x3aWZpLW1hLWIwLWdmNC1hMC5wbnZtICAgICB8IEJpbiAyNzgyMCAtPiAyNzgyMCBi
eXRlcw0KIGl3bHdpZmktbWEtYjAtaHItYjAtODYudWNvZGUgIHwgQmluIDE1MjA2MzYgLT4gMTUy
MDYzNiBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2YtYTAtODYudWNvZGUgIHwgQmluIDE2Nzk3ODgg
LT4gMTY3OTc4OCBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2YtYTAucG52bSAgICAgIHwgQmluIDU1
MTcyIC0+IDU1MTcyIGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZjQtYTAtODYudWNvZGUgfCBCaW4g
MTY1MzgzNiAtPiAxNjUzODM2IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZjQtYTAucG52bSAgICAg
fCBCaW4gMjc4NjAgLT4gMjc4NjAgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWhyLWIwLTg2LnVjb2Rl
ICB8IEJpbiAxNTA3Mzg4IC0+IDE1MDczODggYnl0ZXMNCiBpd2x3aWZpLXR5LWEwLWdmLWEwLTg2
LnVjb2RlICB8IEJpbiAxNjMyNDY0IC0+IDE2MzI0NjQgYnl0ZXMNCiBpd2x3aWZpLXR5LWEwLWdm
LWEwLnBudm0gICAgICB8IEJpbiA1NTAyMCAtPiA1NTAyMCBieXRlcw0KIDE0IGZpbGVzIGNoYW5n
ZWQsIDAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg==
