Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E486A66299D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjAIPOy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 10:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbjAIPO3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 10:14:29 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C29395E8
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673277183; x=1704813183;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=c2Rz01dyLt08pu/eFpc77XJJwx0uyU9xtK1jWXx12nI=;
  b=Xd7E2t41uqtB9qjw7R+BvMCnPmX1va5g9NjNc8QA6yVeise/qA5Jarsa
   KEtDjpTbpC/rhZmvyprX2IRVjPWc7x0p9LTkciySRfW7uKbtHsaAaqUdm
   Lv6qr4iTyqxPI5qXUfUJlDuHyq3c3gqrNIOUxSslaHQ3522EibgVszJTN
   VYXVeQmBuANFe07OepL+fLz2s3Znkg08mUKNsClgFdrAhGBxIA1O0RfMj
   aiFjmh6xShjYautqdw3QSRUBb4yIH80FDi/0KJk0l7eI6pxN/HZI2tiGR
   ZKEz6LB60g5GyJTsTKOPTkx92UUXOrIzcap4ScKQPTecDVnGIxhMArgpk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324900710"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="324900710"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="985420656"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="985420656"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2023 07:10:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 07:10:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 07:10:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 07:10:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 07:10:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN7FADsCNFq/XHWZRN3i7ZRoVOC/w22ziZAAp4C25IBXiYmXuCGH9viAtGQdlXqf1zAJRD1JJoYi3ZETrzsiyJl1kW/mggC40xM2VAZSMDDpZ3Y0bXo8WV19dluBfftnPlwTv+e8ZM0D8b8MFU5BNFH6DcD+AgX/lcc03SfvOewsPA61ziqHZbEDfDCNPDu3GYsrvn8ZQNr8KOdv8drdPK1tILH8lh3ZdnU8Kv5EEOEscuSWlA++CaEuzs7hquUoiq9UyeaZvwkRsQ2rLRdt6/hikTYuwhdBna1UjtgsGgv5aSJLyAn1Zo0/UOqzpSlYDrfD3wRRzhWC1zg2veEOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2Rz01dyLt08pu/eFpc77XJJwx0uyU9xtK1jWXx12nI=;
 b=bStk72WLi/huwW38Axr1Nf/a2pr19lm8C9jJNkFdlMdAPNHKbv2EH/WuRH5Mfiqkex4jwgxfq1F17BEfUE7E8BPA4CALyf4NG+VtSLrCcayx7rDQm8/+3xmb9nicIe6nKm+MWysJ5HeR4JwRjy4BoR9dnGfDK0EzCFnFbMzLCr+5nB4nYvIylfQg7Q/pZ1rExOkdYkmqpBLR5QZAr+m6ZCd/kecg80qZ66tgskg2h73b+X2CDJsfF9AN6Nsn1kl/0rEveHx7+c6+iApD+0vMXEipHmjfZOagJdtbMVm5CHOaVhGVYIDB9j1UN4sSYDylc1TUuBmnD5llf1A07/A7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH7PR11MB7452.namprd11.prod.outlook.com (2603:10b6:510:27d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 15:10:20 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 15:10:20 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2023-01-09 - fixed version
Thread-Topic: pull request: iwlwifi firmware updates 2023-01-09 - fixed
 version
Thread-Index: AQHZJDx9yxVqNUo7U0iQDc5R1/tkyA==
Date:   Mon, 9 Jan 2023 15:10:20 +0000
Message-ID: <60ea573bd4cd000d8576eb510492c55449461457.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH7PR11MB7452:EE_
x-ms-office365-filtering-correlation-id: 8d346af7-d9a0-409c-2548-08daf2539fcf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xssNS5oTko3UXPucKJeDJ0ukga1zKtJSFvHADil4yx1cHwIBiFdBO+KT6G7xFYlF5q/9yT/JVDFoTH/2QvAJm2bKaDLAN68swcilPFdsBvFQQ4fOgG9rdhxAhtYwDoLMAIBeZbegppz/Rcu6936ynYTDL+QECRVDCR5b4xdu0BxsfA7Ugl6Q+od51e1LfUnWFauhGgKzzphM8hZw87063nEYp0lJQueGgvT6GgS5UZt9kQoSv8J0XFmHlqGb1s/xFJIy0ANp9Hqg/Lk0TTNhFhraNYAm5MlUPjgm1hssQ6+6sq/jg6JwbhXP0hJOU4YkO3uFB1tcPC3NUU5DH0lEKvwGoO+j+oXOhYwCiGPpfvR0Snt27CydxdIB5fD5hc6zFqlYZXyWWWwPPTogHFXyEbaSfkgGBsLWA3EhrvHJobGMraR4MiVdO9vXQeuebJI/0Zc7Q3Afj72GQ79J9qz8c+BD7t4ml+QhbhbRLiDOPaarx8y69FgOpNXGQ94P6NcxnuYn8l/HaFvrGjevlbUw8HywBPfMfA4m8Tgao/S2PaW1YKBLeiRW/qU1bu3PRsLWG28LxrQf2bitpO53L9FXzF/eaZENoV+9owp/O1ci6xsnk1r0/ju4Kpup8id1/VH2yCRAS4ZvMU5ZSVYQ0ZBUQlR0/4RXu2BZAZc3YdTZcKzM3+qp+8qgGSaozSW4A22OXbXz/bu0FVkKcY0utG23yq0ils8xhWfo0nlgoC4zgJ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(2906002)(83380400001)(15650500001)(54906003)(2616005)(66476007)(66446008)(66556008)(64756008)(5660300002)(66946007)(26005)(186003)(36756003)(122000001)(8936002)(6506007)(6512007)(82960400001)(478600001)(76116006)(38100700002)(8676002)(41300700001)(6486002)(86362001)(38070700005)(966005)(19627235002)(6916009)(4326008)(91956017)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmJiSmtpdUthR0J3cTZCeXROZGNEV0VGZVd0aVdNZ2xoZ3NqU3NTdjJPQ0Zv?=
 =?utf-8?B?UmliZTJZenVPMFJ4WndZUzd6SUVLOXlwV2s0Y2pLVkRxWEQ0M3dqWm1WeVAx?=
 =?utf-8?B?ZTFnaGZvbmJMZjhWbzlCYWpOYW9iMjdDQzNjTWZNcGFIc29uSVNndjJSb2Fw?=
 =?utf-8?B?aHVwWVBERC9Vb3Y1SEVRYW1qV1BqMHNiMm8xeTFhQ3V6dTRBdFVuU0NwTVZX?=
 =?utf-8?B?NndQdUVKNDBmOXFxTXpVUmtGa3ZqSklLcDZPY0tPTnE4Qml5Yk1SVzdQYmlI?=
 =?utf-8?B?SDVvL2Q0cHJDZUFxMm1GNENNNEJwWlN4bWdLejVTeSs3K1QyOVFWcDU1Z1hh?=
 =?utf-8?B?NVJJTFkxdDVtZkVvY0FoSWFiRW1TVDM5L2o0V3NIM1YxTk9WY1pHem5UbGU0?=
 =?utf-8?B?eVhXUExJUW1tQWF0Q05QRVpZMU1qTlpYY2VqRVBlUHpHbENoaWhiU1o3enhE?=
 =?utf-8?B?Zlk2RmphbnJob2NRUnJCbkpzTUR4bURwbWxHZjVTRytGNnJ1VDFwSTJYMkpo?=
 =?utf-8?B?WjVFa1FGQ3E1OC9VaHdjcUhpU0tzUW45cW4vOXI3bEdmcGJZYTczWTVCZDhL?=
 =?utf-8?B?VFlnb2JnVERpYXcvY3JyMUxJV3lobDBOaXNNV1dxSWpXUVhqY0pPUDN6bEkz?=
 =?utf-8?B?RllnKzVQSGRkdnBEeEVyWGo2V3d4V3BQVzBCSk5NWXA0Y0lwamxCVXAyZmd5?=
 =?utf-8?B?SkExc3Rzd2EyV1NRRHorcElhSnlkSHBjcEkyTWRVWHFoY0JlNjg1WGtXaWZs?=
 =?utf-8?B?ZHB6dEhoZGIvQ2J0bEZmTGhuNWoxQzVXMTZMMytwZGthT3pocjkydTZGQS8x?=
 =?utf-8?B?UHJ6d1poK1ZJdHdBUEVnVm0xZlZ4OVJtbWtLU3FZY0xsUTBDT0lSVkEzVmdW?=
 =?utf-8?B?ZktHK3duUkc4eHNEUzZoYTl3OUVzZEo1TEFQOFc0RitFYVcvZzczY3ZoejRK?=
 =?utf-8?B?ellmR1hUdnBWZzJqRFlybHNOem1iOHVJVlVoWXE1VHBpVmFvODFpV1UyT3NQ?=
 =?utf-8?B?cldNZ3dSY05KTEdaQlBmOGsrbGtsajc5YWdHMXpBR2lCaEx6T2Q1VGdrOGxQ?=
 =?utf-8?B?dUl2R1kwT3pQTGI5ckFnSjQ3UmJMSFZRSXJma2VZRzFlYWVTck80UTMxaEd6?=
 =?utf-8?B?V2M4K2xRaVB3ZEtlUVdwMHdIUTBQVGNHd1hLMHB2T2xuTFlHRG1DQ2NVV2hV?=
 =?utf-8?B?ZHhHZHNmTVRFRk9CREFHM1lGU0ttQkNTYzZPRjhFbzBnVHp6clplN0ZXdUM4?=
 =?utf-8?B?MUVDemhUMStaY0dXTUxQckMvTzRBbTFuSEdJTkdWc1VkSFl4NnArU3VxaWpE?=
 =?utf-8?B?RXplTHV1dStvVUpWM2M4aS90dW9UM1EzQUJ5bVJxdWtrczR1NitXRVE3WE5p?=
 =?utf-8?B?VGFSckZubHhQZFNyNmlIdTVuZml3bmpsamswWk1FSXBWWDZmWDJabXRxdG9r?=
 =?utf-8?B?dGFRZXo0WDFMTHlWbUZzbGpTbDIxS285YzZ6QXBPSFRHdnNiQ0pic2Y3Zm1M?=
 =?utf-8?B?SG9zbTNKRVFmMWtPZ0JmYy9PdEVKamQxYWZMRHpTSDZ4UDQySGhYblhFemN5?=
 =?utf-8?B?ciswOUc1WmRNdFUyWmFBayt3U1RSQVVjL25lOG1ickdjcS9mWVBObks0eFVF?=
 =?utf-8?B?bkJ6aGRwWTlodUExaCtPZVQ0T2pBaHpJcmdyc1pUTGNoUFk5YUxkak40cG42?=
 =?utf-8?B?WERnV014Q3JhM2lJcXlrVy9SMndUS3czVjZRK0xFd3ovNHEzbjZ5U1JnSVh4?=
 =?utf-8?B?d0ZObVZPS21IYWN4OWtZdkQ0M280eWIxYnVWR214RVloUW9tTUpYaGMvUDVp?=
 =?utf-8?B?NEduOWlrbVkyK0VTbTZBOFdaL0dYeUp1UXIxLzVUVnk3ZzRHMDJZWVd3RWow?=
 =?utf-8?B?R01zYnNaV0lseDhCR1JySFR1dUxVd0FoMFRzZ3VYTUJaaUhydFl5UDBtOGFZ?=
 =?utf-8?B?RWh1eGdkaTZuNTNaU1pDckhFMHRyNnNaQ0lvT1B1VSsralBmbFIwNUZLSnB2?=
 =?utf-8?B?MzQ4dDVKa083a1AySnF1NDFQa0tVcVRhY3I1MTU4RjlXRVlyeVRHRWxXZ0F0?=
 =?utf-8?B?bzU2aFlyVFVRM1BIakNBS1JNSy9KRHprU0g1aWVmMlpXcFB6SEd1VUl0alJF?=
 =?utf-8?B?OVFKNFB3S29GSkoxS01BN0FjbDgvOGE2TGovQVd6NnRzVkNVeFdRb0VMckw2?=
 =?utf-8?Q?rEh77mPhaiW1fUkDOP1WbdI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <463723B1630FD549AB8D46EBC6FC822D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d346af7-d9a0-409c-2548-08daf2539fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 15:10:20.3081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERjBDPl/DNppluttI8D3EPu63OFAMYhh714bzcoLtrgCe4SoVwdslcYfxXMnD4TIRBn7hwdt3/pzo4WVHAvaI1kMdc2EAaO3Zh8UwHObDZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgaXMgdGhlIGZpeGVkIHZlcnNpb24gb2YgdGhlIHB1bGwgcmVxdWVzdCB3aGVy
ZSBJIG1pc3NlZCBvbmUgZmlybXdhcmUgZmlsZS4NCg0KSXQgY29udGFpbnMgc29tZSBuZXcgZmly
bXdhcmVzIGZvciBhbGwgb3VyIGN1cnJlbnRseSBtYWludGFpbmVkIEZXIGJpbmFyaWVzLg0KUGxl
YXNlIHB1bGwgb3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBpc3N1ZXMuDQoNCg0KLS0N
ClRoYW5rcywNCkdyZWdvcnkNCg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1
MDRiNjkxMTdiMGE2OTk1MjMwZTBiNzcwMGVmOGEzZTc4YWNmYzU3Og0KDQogIGFtZGdwdTogdXBk
YXRlIHJlbm9pciBETUNVQiBmaXJtd2FyZSAoMjAyMy0wMS0wOSAwOToxMzowNSAtMDUwMCkNCg0K
YXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cDovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9pd2x3aWZpL2xpbnV4LWZpcm13YXJl
LmdpdCB0YWdzL2l3bHdpZmktZnctMjAyMy0wMS0wOQ0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5n
ZXMgdXAgdG8gYzhmZjFmNDY1MWEwYTFhN2I5NzIwZTk2MzVhMmIxOWFhMjMxOWRmMToNCg0KICBp
d2x3aWZpOiBhZGQgbmV3IEZXcyBmcm9tIGNvcmU3Ni0zNSByZWxlYXNlICgyMDIzLTAxLTA5IDE2
OjUwOjI5ICswMjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpGaXJtd2FyZSB1cGRhdGVzIGZvciBpd2x3aWZpOg0K
DQoqIHVwZGF0ZXMgZm9yIDkwMDAtZmFtaWx5DQoqIGFkZCBuZXcgZmlybXdhcmVzICh0eS9zbykg
ZnJvbSByZWxlYXNlIGNvcmU3NS00Nw0KKiB1cGRhdGUgY2MvUXUvUXVaIGZpcm13YXJlcyBmcm9t
IGNvcmU3Ni0zNQ0KKiBhZGQgbmV3IEZXcyAodHkvc28pIGZyb20gY29yZTc2LTM1DQoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCkdyZWdvcnkgR3JlZW5tYW4gKDQpOg0KICAgICAgaXdsd2lmaTogdXBkYXRlIDkwMDAtZmFt
aWx5IGZpcm13YXJlcyB0byBjb3JlNzUtNDcNCiAgICAgIGl3bHdpZmk6IGFkZCBuZXcgRldzIGZy
b20gY29yZTc1LTQ3IHJlbGVhc2UNCiAgICAgIGl3bHdpZmk6IHVwZGF0ZSBjYy9RdS9RdVogZmly
bXdhcmVzIGZvciBjb3JlNzYtMzUgcmVsZWFzZQ0KICAgICAgaXdsd2lmaTogYWRkIG5ldyBGV3Mg
ZnJvbSBjb3JlNzYtMzUgcmVsZWFzZQ0KDQogV0hFTkNFICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCiBpd2x3aWZp
LTkwMDAtcHUtYjAtamYtYjAtNDYudWNvZGUgfCBCaW4gMTUxODc4OCAtPiAxNTE4Nzg4IGJ5dGVz
DQogaXdsd2lmaS05MjYwLXRoLWIwLWpmLWIwLTQ2LnVjb2RlIHwgQmluIDE0ODk2NjggLT4gMTQ4
OTY2OCBieXRlcw0KIGl3bHdpZmktUXUtYjAtaHItYjAtNzcudWNvZGUgICAgICB8IEJpbiAxNDA3
NzM2IC0+IDE0MDQwNDggYnl0ZXMNCiBpd2x3aWZpLVF1LWIwLWpmLWIwLTc3LnVjb2RlICAgICAg
fCBCaW4gMTMyNTUwMCAtPiAxMzIxNzIwIGJ5dGVzDQogaXdsd2lmaS1RdS1jMC1oci1iMC03Ny51
Y29kZSAgICAgIHwgQmluIDE0MDc3NTIgLT4gMTQwNDA2NCBieXRlcw0KIGl3bHdpZmktUXUtYzAt
amYtYjAtNzcudWNvZGUgICAgICB8IEJpbiAxMzI1NTE2IC0+IDEzMjE3MzYgYnl0ZXMNCiBpd2x3
aWZpLVF1Wi1hMC1oci1iMC03Ny51Y29kZSAgICAgfCBCaW4gMTQwNjc1NiAtPiAxNDA0MTg0IGJ5
dGVzDQogaXdsd2lmaS1jYy1hMC03Ny51Y29kZSAgICAgICAgICAgIHwgQmluIDEzNjkxOTIgLT4g
MTM2NTQ4NCBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2YtYTAtNzgudWNvZGUgICAgICB8IEJpbiAw
IC0+IDE2NjcyMzYgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmLWEwLTc5LnVjb2RlICAgICAgfCBC
aW4gMCAtPiAxNjcyOTg4IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZi1hMC5wbnZtICAgICAgICAg
IHwgQmluIDQyMDkyIC0+IDU2MDQ4IGJ5dGVzDQogaXdsd2lmaS1zby1hMC1nZjQtYTAtNzgudWNv
ZGUgICAgIHwgQmluIDAgLT4gMTcxMTEwMCBieXRlcw0KIGl3bHdpZmktc28tYTAtZ2Y0LWEwLTc5
LnVjb2RlICAgICB8IEJpbiAwIC0+IDE3MTI3NzYgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmNC1h
MC5wbnZtICAgICAgICAgfCBCaW4gMjgyNTIgLT4gMjgyNTIgYnl0ZXMNCiBpd2x3aWZpLXNvLWEw
LWhyLWIwLTc5LnVjb2RlICAgICAgfCBCaW4gMCAtPiAxNTE3MTQ4IGJ5dGVzDQogaXdsd2lmaS10
eS1hMC1nZi1hMC03OC51Y29kZSAgICAgIHwgQmluIDAgLT4gMTYyMDAwNCBieXRlcw0KIGl3bHdp
ZmktdHktYTAtZ2YtYTAtNzkudWNvZGUgICAgICB8IEJpbiAwIC0+IDE2MjA3MDQgYnl0ZXMNCiBp
d2x3aWZpLXR5LWEwLWdmLWEwLnBudm0gICAgICAgICAgfCBCaW4gNDE4NzYgLT4gNDE4NzYgYnl0
ZXMNCiAxOSBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmLWEwLTc4LnVjb2RlDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGl3bHdpZmktc28tYTAtZ2YtYTAtNzkudWNvZGUNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgaXdsd2lmaS1zby1hMC1nZjQtYTAtNzgudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
aXdsd2lmaS1zby1hMC1nZjQtYTAtNzkudWNvZGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lm
aS1zby1hMC1oci1iMC03OS51Y29kZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLXR5LWEw
LWdmLWEwLTc4LnVjb2RlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktdHktYTAtZ2YtYTAt
NzkudWNvZGUNCg==
