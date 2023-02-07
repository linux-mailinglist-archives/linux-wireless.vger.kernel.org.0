Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F5268DF31
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 18:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjBGRou (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 12:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjBGRop (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 12:44:45 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC48CDF1
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 09:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675791884; x=1707327884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MqnDCRNAkYDDbLKCGoRJcWSm3/DYo69m5AF0tqAiJno=;
  b=ZOwsUOB2Tnq8XzkTwCwi3k8j5AZcwOAiTz/qwPrBS6MGP2cP9d5ixFhp
   zgONZPVimG3svYm6IQ6Sg83CPgj+zb5uYg8buBE0piTgz9KhcnK08MpT3
   ZezrQtwx1eAStyNJEEQm1nmnu5GRC+VChUMy3o1aCsduCmCm41xk9OMV0
   TNdfu+bjOwIuozDvvc9+0ag2uRJBtTCTqGoeq7lvhG1Zkp1JaN1K4uQpI
   yZKR4mfcq/y8g0gbVJhAP3XEAMfDvm6WUb+bcFNjA6LW+Qf3xRbF3YteC
   9EHF5C6kvYOSE3uku91g24eN2cF6l4Ta80SKC3vSCOsYPqbFRqafdQLKs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="329595899"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="329595899"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 09:44:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="755701943"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="755701943"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2023 09:44:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 09:44:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 09:44:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 09:44:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9I5Q3gB/Tg70XQ/zef8XP+QvyI8zSlLkP+p9R5m4r1QKjTyio0ux70PpohqtjMQKC8t2Z2tQaJA81j6pYATlVgb3zfdbrWTAfCQ97PmNlfdDuq6mftbFdmUiKI3E3MzSroUvwjjMXrnyk2wqeF9XvqHtnXBBcqnk6l+AQXO9nc3jEMQr6uXFZiTTlRtjWy6/ARCO+BpFyMc0RuT5l2df5gGhe3/eE3NzNnCsAn/EMyyJsVAmlNVCc4Fyo/kBZLZibLexmk4OOYqoH09iqUdUwk/an8gqfmTOfNRvMXCkZGOq1ujZNhGs64IdUiJRWp6X1R/tkF1NLgOhXsmw50+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqnDCRNAkYDDbLKCGoRJcWSm3/DYo69m5AF0tqAiJno=;
 b=Gq2/z+mAxQNNkkevvStIRvG6bUL8RN5Nb/DqZXezNHkPB2QkD2bmYRiSxddwfhRYAtVAkcQAe8Q/2qyIPpZTMbk+yUUl8yxDI9EUsnr58LXCC6a6tlkHsFuAg18KQ0aW8ZZFsJYZyoGTvY9NVxUDxt7NTRsJxFg65ZssDLNpCo8TpTlwlDrUsXFeo7id5i62PO/OmOwik34gko0defIUMZSxGH9eo1/0I4dcO505yfntfhU+2W5wPXXhxIb6haXoVRNaldqiLQ82CKIe6AOGVAe/PxYUgCzJVcSrmPtMYRMwUN3x2k5S9Xyh7AZU4rwxeyuEcLzeNOFtgnmm/4DJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH8PR11MB7072.namprd11.prod.outlook.com (2603:10b6:510:214::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 17:44:40 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::81be:e0c7:8c53:8f9c]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::81be:e0c7:8c53:8f9c%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 17:44:40 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "aiden.leong@aibsd.com" <aiden.leong@aibsd.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v3] wifi: iwlwifi: pcie: fix the order of scanning
 iwl_dev_info_table
Thread-Topic: [PATCH v3] wifi: iwlwifi: pcie: fix the order of scanning
 iwl_dev_info_table
Thread-Index: AQHZLC+CidTP1/CGsUWqrz0Jf5wOia7D31MA
Date:   Tue, 7 Feb 2023 17:44:39 +0000
Message-ID: <51e9eeb2cd84f0f8ff92981b47a8e77e11047847.camel@intel.com>
References: <20230119175657.9205-1-aiden.leong@aibsd.com>
In-Reply-To: <20230119175657.9205-1-aiden.leong@aibsd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH8PR11MB7072:EE_
x-ms-office365-filtering-correlation-id: e6dc0d5f-312c-4005-bc0d-08db0932fcf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AnaBsYLjnYtze5Nz6xgRnlQ8hBau2pneC2t1pscPL6eK4SlFGhiablbhGVkKvGD67eIpGNqX5hG4QbmA9uoOigSb6YtvtYEHdnL3LriphqtsKKdwI/SHs/Mhx3RhMiQ298rd7d5JLLwTp689RemvVPHu0bxyAD99l7cBUnkex/Egc5elGwowx5iX4cCEMarnwbBfvWn1gReHN3fwQ3lvt38OAmhjNCt0XCu13FHcyy+RbPlu6NRKDiNdrHodLD6lurxfox2TBKfRJToL+4+k0ysI0s4NydetW+YQ8h0PUJ2nZfjBRD0fzz450eg795dZG3ptsSqNPGVQKjft1AXUExmDQI2h+GCq4CpxJ+qkrf98uu9viVSvPtE8caCZjA7CvGD3+dyuupnVWb5QaeQXA0ABpcbKPwR6mBW4pDhCKFgXRFJgryj1kGOlbGtfeMd9Jyrp+Yz7QkbgebzdFJI2OpGcGNwv/oSVfiONa7oEfW+Tlo0bbujHVHbmRn/tNMuJxqyFIq5JinUATli6a04fCUoGK8A6+MqLix0q14iLQqZJ3h/lb/9+2sy5BzmgDJqBdc79iOP7RBGXQIZBtGEITbOJTXecPJAX8CqKb9WUQKWMtx6JuDhTLBcvgeYN+L15eyoVPBA0rnMPJhsqet/a619hRi3V5ClGxg4ofqS+UDkbH7T+qD3p/UNkef6R6oDr+UcvlgSLjL+x8/r/K11CQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199018)(38070700005)(66446008)(66476007)(122000001)(82960400001)(38100700002)(64756008)(36756003)(86362001)(66556008)(41300700001)(5660300002)(66946007)(76116006)(8676002)(316002)(4326008)(110136005)(54906003)(2906002)(91956017)(83380400001)(478600001)(6486002)(2616005)(71200400001)(6506007)(6512007)(26005)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHFsMGw1Qm45ZlNJQjlWR3Zadmgwdnh2WTNEMitZN25FS0NrODJzTXpSVDJi?=
 =?utf-8?B?cWJ3S042U1hwYUZkQjR6c3VmS29CUkhjSlRTeldUWm5CUEFzbVJGT1hNUHpB?=
 =?utf-8?B?dWNwVk9kQUI0QzRDWHVYaHpQVTB5T21JSmRQSnZjM0taeHJxL0JqMVpmTU1v?=
 =?utf-8?B?MGVqMUFXV0RFOC9DR3JVRldqLzFQb0FEZ01MU2RtOFhnV04xUzVxTGtYZ2h1?=
 =?utf-8?B?aktFeCtyMEdKdmJyY3lORGlKdkt0Y1JtdkhBZzlyOUpMMEVtZkNYa1BjNEhE?=
 =?utf-8?B?V1k5QTF0WUpEWi9LOGxzWTdnTG1uZDhCdERNeEc5Q001WUZ6QXFkL216ZWVp?=
 =?utf-8?B?ZkN3OVZXcUVFVUc0ellLenpiRFVUYjAzSFpZN3N4cm9CQWNJajA5cHN0MG9Z?=
 =?utf-8?B?QzZBZFhCSEdUM2dLdThuOGRoNWtSSmtBNWxSUzV3VGdrcXAxTkkyL3UrOGJG?=
 =?utf-8?B?VHNpNGdzREVOVy8xekQ2d0JPMmZtQUdYWGVCblpPYndEMDV5OVJoR3p4WktI?=
 =?utf-8?B?MkhQYzlzQTcvaEFjK0RSajhhbkV6YlRQL3M3Q3NYN2Z1Unpva211eEY4TUR0?=
 =?utf-8?B?MzBIOHVKV2RpeldtQ2ZrWFlORlRlUzJSS1BtMHl5M1oyQzdyeEIrc2VLdW9O?=
 =?utf-8?B?VXd3TG9VRDU0bVJTdmh6cU1NRXp1R3JZRVZnQSt3aW9yTGh3TDZZOXA1VjJw?=
 =?utf-8?B?RUtyTm5FQWdPT3RUVHVKeDlYY2hzUlpxRTFrbGhYbVhIdW43Z01oN1Y4NlI4?=
 =?utf-8?B?bzNUK2Y2a2MvS3Q1V1FvQVJaNkk0amlDU1ByaHJ3RzEraHZoUlY1NWFHcWdM?=
 =?utf-8?B?RTBDbmVGWDBMN3FGTGF5WGczUSs4WWNQT3RoeGhSanl1ZWdYSHFZNUxacVVK?=
 =?utf-8?B?MDNDS0V6NEJHWTQycUhTaldmbXlZY0hpQnRZQW1FTVhlZWl5cFp5bjRKVmsz?=
 =?utf-8?B?ZWQ4Mi9odUpnMEVQL09uenk5QTR6WkVTUVVHQnhaL0tIeXpKZmRkbkxMSzJG?=
 =?utf-8?B?YzZnc1hWWjdiVFovWUlRN2pkbXZ3dXRiZ1E5bHFZZkVPTkhyWE1CcWJKcUhT?=
 =?utf-8?B?TnJOVHJhbDgwdEJaYXFHZVhDeG5DMWNzbGJyZEE5bHQzU0xWMkhKU1NLL3M3?=
 =?utf-8?B?alVDQmJ6aHhJWmF4YnlGZytaNGg4ZlZHc1FtakpONmVSb3VqWkl0djdSOWZC?=
 =?utf-8?B?cWpyVWpRZ2J0VktBYXBOTTVRdUlhNXE5dXRvcHJhVGpORXZWNWRwSXl1ZTRw?=
 =?utf-8?B?Nkh1QVhhbWlBYU04cDVYZ3JJaDBKNGovSlROVDJhbEhwV1JOamFQYVN6L2xa?=
 =?utf-8?B?aVZWK2ZlVHpXNmJ5YW43Y2lpWHQwaCtlVnFBZWIrM1Q5aERlemxOWjkrNC9t?=
 =?utf-8?B?dHRNTTdyOUZlVG50U3VhdnMyUFlmc280SjlEUytKbW1kclgyV2R2Z1FndE9U?=
 =?utf-8?B?TEd6RXZ5QmQwRnJCQXFRYi93d1VNMEtTOTFNRTZpWG9DQXBkWGFrdjdPVk04?=
 =?utf-8?B?bzIyZHdKeUZnSnJRNm1hQkE3U2FFcDhRZExVSENpL0oyL2NnaXVlUnlnVjRZ?=
 =?utf-8?B?RDJTd0FBaldJRVdLdHdxUFBJL0lCUjFKV0NZbUV5VnNIS1pUNXc4NlVQeS82?=
 =?utf-8?B?R0dMVzNSaHk5ZWM0Y0RaVzI0aFhMOGhvc1FxTm0rd0t5elZLQmxBaFR0bHJY?=
 =?utf-8?B?YUo3bDF0R1pyYk9TSWR1OTdBS2VNY1RDM3VxRUd5S01jZ0Q3M1ZpODN3enRx?=
 =?utf-8?B?NXZoaFNiZU0xdFJDamFtNVJGZm92cGpiV1N3cHRCOGlXc1lJaFhwV0lmVjUy?=
 =?utf-8?B?SW9ZU3duT1YxMHlyb2RVa2VoR0RtSjRGNDgzd0w1MWt0bjNNVkx0dDF6aXEz?=
 =?utf-8?B?V3pLY3FhcG4vMVprSHoyMmFMWUdMSTEvWENRZkRIUitXblgyZi9KT2w4OWVn?=
 =?utf-8?B?RnNMNlMrdEJNUzM0RVE5VjAydDZQTUJKTjI5MnFGOXJvV3hqUCt6cEJSWS94?=
 =?utf-8?B?emUxQkFzMzkwUStWQmptck1FSjVNeExsdytEcUhEVDVEZkl2K1ZyYkhxWDUv?=
 =?utf-8?B?TmcwTGt5aklvTXdWUjRCdGR5L25IcGpWZlBLY3J6UzFaWll0M1F3MkNkeXda?=
 =?utf-8?B?eGs0TnNJeWJObFE1bVpKM0RGa1hOR0tpV2tDWWxTeXlYOTJrODM2VEpXY1N5?=
 =?utf-8?Q?KFlRIo2EW1SBCGjNaWvQtoI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DECBA13920B7EE4E896CE0CECB1E5A4E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dc0d5f-312c-4005-bc0d-08db0932fcf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 17:44:39.9945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1yxdNri5ZeSPQGLmqsBd7J5negifXfsCghwVO7fP344dc6XMydxfd6rjYPq4Q1WlItw7aoSANA2RNtdpyQ8fDxE1IP+ammHFnmHhxLVpKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7072
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTIwIGF0IDAxOjU2ICswODAwLCBBaWRlbiBMZW9uZyB3cm90ZToNCj4g
Rml4IGEgYnVnIGludHJvZHVjZWQgYnk6DQo+IGNvbW1pdCAzMmVkMTAxYWExNDAgKCJpd2x3aWZp
OiBjb252ZXJ0IGFsbCBRdSB3aXRoIEpmIGRldmljZXMgdG8gdGhlIG5ldw0KPiDCoGNvbmZpZyB0
YWJsZSIpLCBzbyBub3cgd2UgcGljayB0aGUgRklSU1QgbWF0Y2hpbmcgY29uZmlnLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQWlkZW4gTGVvbmcgPGFpZGVuLmxlb25nQGFpYnNkLmNvbT4NCj4gLS0t
DQo+IMKgZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jIHwgMiAr
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9k
cnYuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYw0KPiBp
bmRleCA5OTc2OGQ2YTYwMzIuLjA1NzY0ZWVmMTVhNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvcGNpZS9kcnYuYw0KPiBAQCAtMTQ1Niw3ICsxNDU2LDcg
QEAgaXdsX3BjaV9maW5kX2Rldl9pbmZvKHUxNiBkZXZpY2UsIHUxNiBzdWJzeXN0ZW1fZGV2aWNl
LA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFudW1fZGV2aWNlcykNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTlVMTDsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgZm9y
IChpID0gbnVtX2RldmljZXMgLSAxOyBpID49IDA7IGktLSkgew0KPiArwqDCoMKgwqDCoMKgwqBm
b3IgKGkgPSAwOyBpIDwgbnVtX2RldmljZXM7IGkrKykgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBpd2xfZGV2X2luZm8gKmRldl9pbmZvID0gJml3bF9k
ZXZfaW5mb190YWJsZVtpXTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAoZGV2X2luZm8tPmRldmljZSAhPSAodTE2KUlXTF9DRkdfQU5ZICYmDQoNCkl0IGZhaWxl
ZCBvciBpbnRlcm5hbCB0ZXN0aW5nLCBzbyBpdCdzIG1vcmUgY29tcGxpY2F0ZWQuIFRvIHRyYXZl
cnNlIHRoaXMgdGFibGUNCmZyb20gdGhlIGJlZ2lubmluZyB0byB0aGUgZW5kIHJlcXVpcmVzIHNv
bWUgY2hhbmdlcyB0byB0aGUgdGFibGUgaXRzZWxmIGFuZCB0aGUgDQoiZ290byIgd2Fzbid0IG9t
aXR0ZWQgYnkgYSBtaXN0YWtlLCBidXQgZm9yIGEgcmVhc29uLi4uDQpGb3IgdGhlIGRldmljZSB0
aGF0IHlvdSBoYXZlIChkZXZpY2UgaWQgMHg0REYwLCBzdWItZGV2aWNlIGlkIDB4MDI0NCwgcmln
aHQ/KQ0KaXMgaXQgZW5vdWdoIHRvIGhhdmUgdGhlIGZpcnN0IGZpeCAoZGlzYWJsZSB0eF93aXRo
X3Npc29fZGl2ZXJzaXR5KT8NCg==
