Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69E94F5AAD
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 12:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiDFJvM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 05:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445866AbiDFJt3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 05:49:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A04C35E2D8
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649226158; x=1680762158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dkkYpJsvjVqwHf5Vu4q12KX5PcL2xQ+jSogb8xThp9c=;
  b=RQHt9yop1rusQzRfhal2SeoTvnwejgHfnHoXTdeECboUjtVnMk5QOKBV
   vfOsOtA2JpywICLnbfG4ko+ZueBq9T4zED7OB9kreAurBgpuJ/BhKoJxG
   yS2mzoFFIgb1cZrDYJ2ju5rru7RJezs3Kx/RJAN8mr//EcOqlJA0pu2YA
   I4I+er3MmbFrSmbXlJkb+tNpX5hHCKnpnIzRmqdzJLlTWvqBobKg6D5gZ
   8ls5url0Cga0czBKswv/8WR+Rafjo+iQOdIiR79ya7//KeSWeRKvZC0PL
   KjpWa+wQfjWhkcdrOCt4HNsCI04FAsHrQBU859dWgUuJpaCOQDewcUEhA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="347405207"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="347405207"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 23:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="641925953"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2022 23:22:38 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 23:22:37 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 23:22:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 23:22:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 23:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg0GKupwknO0YUs/MO2nvzxvhufg6Y38E6eV8D8DfEjexdBAMAa2J1PDx1f64wGhtC9/ITs0rgVLhw3k86B+jtSBarIMQ45++p+qydhev/MKgXqsen/jnuiju60BivmEc0QRMYmwgNMqdnVHeaT1n3cb+d0L7E3oiFoTJ3WObE/OWMwohLX/8NXZDxsNVbWFpq67unexxDy4Qu+spGoFwDhEQOazbOsQzACswS37omWT3gXXi4KGjKTV67VzouMqBjFat8oVyx0WvKHqkynuVU+tEQDaoOsTytpX4KD1rLXuZ3Y2pQgkdFoOYm+HtP+vZPDm0MebYqz7W/kVRwQEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkkYpJsvjVqwHf5Vu4q12KX5PcL2xQ+jSogb8xThp9c=;
 b=Z8nvvYA0ts1MUOSLlKt8fUHgG56UqhogPjLO8Yc4T5N/XE/pV5dFhTE8TMY5DwIDxK4k5S7dBnaqE1g6BFrctKELjV8NnwlXvrsMZmtgQ6aEQrZJkTcqD3cl4Jjz2YFVdyz8D5uFEaMxdPnTkzpv/aF/HkR7fXM8QoyBpdJQSkjErDxR7dVTrdWbjh2TfgqInd0t0tp2uWMgot6ALNYsz+8qAfprowIlGzeuYHpnol/PiEBywfqT22NFAwmauQu2qivVkSfKad96HXs2SQZnvoNVnTRm53EJp4qu72TDpvpRq5hEHE+/kF7M68JJKXPMCNEE/I4bm5M/tHCAae9/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) by
 BYAPR11MB3752.namprd11.prod.outlook.com (2603:10b6:a03:fc::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Wed, 6 Apr 2022 06:22:33 +0000
Received: from DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::ad35:de1e:6ff8:5eea]) by DM4PR11MB6043.namprd11.prod.outlook.com
 ([fe80::ad35:de1e:6ff8:5eea%5]) with mapi id 15.20.5123.030; Wed, 6 Apr 2022
 06:22:33 +0000
From:   "Peer, Ilan" <ilan.peer@intel.com>
To:     greearb <greearb@candelatech.com>, Luca Coelho <luca@coelho.fi>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 04/12] iwlwifi: mvm: Passively scan non PSC channels only
 when requested so
Thread-Topic: [PATCH 04/12] iwlwifi: mvm: Passively scan non PSC channels only
 when requested so
Thread-Index: AQHYGbGKBjrG/ErWYUqh3jmSjjk7eKzQo1uAgA/SLKCAAZc1AIAAvNjQ
Date:   Wed, 6 Apr 2022 06:22:33 +0000
Message-ID: <DM4PR11MB604389FD3E2AA80056B02AD4E9E79@DM4PR11MB6043.namprd11.prod.outlook.com>
References: <20220204102511.606112-1-luca@coelho.fi>
 <iwlwifi.20220204122220.457da4cc95eb.Ic98472bab5f5475f1e102547644caaae89ce4c4a@changeid>
 <f18f11f2-b9b9-9d86-340e-d567247ef7bc@candelatech.com>
 <DM4PR11MB60435B74198FD8A0FE70853DE9E59@DM4PR11MB6043.namprd11.prod.outlook.com>
 <200b2f77-6832-85e5-5294-97c918f62c06@candelatech.com>
In-Reply-To: <200b2f77-6832-85e5-5294-97c918f62c06@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36c1035f-dd81-40ff-a0fe-08da1795d5fa
x-ms-traffictypediagnostic: BYAPR11MB3752:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB375258C1148D49B2D54C77CEE9E79@BYAPR11MB3752.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXETalwq5XSyDZcwOz9p6fxZjExfV65FMtsg9qM/B6Pq586vAht+B6nFJvyEBLPEhg3WSh8vgcf7yJskUI/0vrF0noiUYpNZZOIbki0Edc2sw18EVRC9ad0/4rGOGO5XMi5L/nGRFRhYRi3/YZIj9OX6M8nDwTaIApQ5ceHzx0DIw77BivoV9UXFvcAQLyYPsfLXr1NUK+mkAaT5tQQXofr2N3UKWBDwoK3Kzl8W59zeSyJGSjjbdvdYLIzYoFPPbpQFTr4qRskxgUHnpASlk355qr2JL83GfVBI9KhJ9WTz7ep6k0bJ5VW3rWYnBpa+dVlQgrYn+7aXPN47+YiRQoazQp0H09RpMEJqKpANxoTXaN7EJdKINSUiLQIvUQAOKPXbAQcQXCweQ/g/hfBswjKWADQHuaVETsnm0glhzIBxJbQyiZ99f6lGd1KvN95tKcR8bFR2FzrPPkLhzW2kxtKxoloMj8kGEoPQGV4+EqVSV1B5IVzqlx/PE/KET7+3mtHUXoPd0GKiDfVIIXOMpChn3aIiSW6kO+9JB5uLVKED9PwZZ4rvIbpm7NPGSCnMgs66hqonG8gVcaVAZokACK8fHiYQT8uz9WvXBJZs2VoxIB68cc/23MCiNQs5fWt4Y5xpcX9pFEd4Lf9UXRk9B+aQ7AWo+2MH5v49/VVuBWKuW8VoiM5RmfzjkFBEl75ffYRm/Nr90cIGUJ5pl6+sOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6043.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66946007)(110136005)(8676002)(122000001)(508600001)(4744005)(52536014)(82960400001)(66446008)(66476007)(66556008)(64756008)(53546011)(316002)(7696005)(6506007)(5660300002)(4326008)(38070700005)(9686003)(2906002)(33656002)(71200400001)(55016003)(186003)(83380400001)(86362001)(8936002)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1pNa3VUc3piZnVaMnl1TVVXQVA3MWc2OUNHUXNmbXA5WkNydEJnSXJOTTZL?=
 =?utf-8?B?bFRPcXRhd1hPaFl0WHRLelZTc05qbU50ZitNNExlNGVuTHdqSWdRWm52clBz?=
 =?utf-8?B?WGFsMVgwWEFBTUNmUkxxS2tHZ1BRc1VYd3hvV2VRaVN3c2xITjJMMzNwVVdB?=
 =?utf-8?B?NHplYUs0VzVhc3llRHpEVlN0OTVwMjFYTjZ2bDdiQ1V1Zm03MlRaTGs2YWtZ?=
 =?utf-8?B?ZVJEMW9jN2w2N3dtalFkcUFsNnBIUXg3Z3pnSFlHaWpDWnl0Ym9Kc3FuNlI3?=
 =?utf-8?B?WkhTZVhvaHFkR3lDelc3U1ptaVc2YXhEbllLS0JobVl1TWV6UzRDcXR3Ukgw?=
 =?utf-8?B?SkYwTVFmajRYbm1FSU1yUWEyRThEZmdIVWNHL2lsK3lkb21XMURzUlh1S0x6?=
 =?utf-8?B?SnBtOHVIbGcwRVlyWGFtYTFvbUhrcDZVb3I1ZUY5Z0tqLzZqdHdtZGRySjlm?=
 =?utf-8?B?LzBnRkVhMlMxRHQxaTNyTmZwSC9nU25kTzVmQ2ZNR0crODRjbGpRRm1tZ1Bl?=
 =?utf-8?B?aTB3YTYzQmpLcmRoL2F6MkxCTitSMnBxMC91ekxTM3h1TTBxbktVWUxLaG9F?=
 =?utf-8?B?N2VOVGNTL3hsV1d6TUxKNzlJelc2dDFuNy96L0R0TGFINk8xYVZIc0ZTVVUr?=
 =?utf-8?B?cmc5b1BlZzhOVXhKVjBvTDA3TkhZVDNFTkxqM1E5UEdJLytpRklzK0g0WWxm?=
 =?utf-8?B?eGl0Szc0TTg1SzFHQ3FtbTc2ZlJCRSs0aStmc0ZjMnRqc0NpUVFxdklBVzBt?=
 =?utf-8?B?QnZ6SGllUUV2cVkremdLeThSZXZOc2h4bnhGaEJxUi9vRW56L2c0SFVCbnFW?=
 =?utf-8?B?bWdvVFRKcEZmNis0dmZBUlI2dGcyQjd4Z3N3NG9KOXB5di9pcTJ3WjU3Tm1O?=
 =?utf-8?B?cWlZdHBtMEQwUkNuczFvSEs1cC9LUERrOWh6cm9vMHdRU1pMRU95TVZ5Mmw2?=
 =?utf-8?B?QitxR0drSVlaL2tObUp2TjRlZ3F0RnFnMWFNWTM2b0U5dFlqamQvelErOUdP?=
 =?utf-8?B?OWRXMURMR0dKcFFnVW5QSndRUG9TYzdUbGtpOGRuMVhmSkFtQW1KN2F0REYv?=
 =?utf-8?B?SFBkSWZKMm41aVUvbjdnd3ZXTlBOejAxVmN0dkpvWVg3WFNVcDRIYzRyU0Ra?=
 =?utf-8?B?bzFjcEhlR0x6Qyt5eGxuSGt1TDJoS09yWWpFOVpEVGtwQk16emNCMWhZTy9T?=
 =?utf-8?B?aHpxNVpxRXFyQWFGSFR2QW1PK1B3S2Rmak1zMmJHeDhzNGdoNTFtNlRDbVhx?=
 =?utf-8?B?RUcxcUpNWlE3QkVqMEhhSEJOQ0R1Rkl6TXo2a1d4VXdlRld5L01WUXpDSnNn?=
 =?utf-8?B?c3N1YklmaytwS3VMVVprZ2VqZWpSZHZCVjk4TnRMT0hnQllXM1NqK0gyZ1pt?=
 =?utf-8?B?Mi9KQmh6R2N5Ui9yVUt5N1RiZnFWQW02elF6aXNCNHo4eDNwOHdCaUIzMHZu?=
 =?utf-8?B?SGRqOUFZdUNOWUoyZ004NCtzUW94dURoMG05eFpFUnRuL0J6a010Zkt3cXRj?=
 =?utf-8?B?L05LUnFqQXROZTdHWWJvS0sxS0lrdWxSQkNkK0hOWDJpSnNFMVFSOTNwSml6?=
 =?utf-8?B?WHpIcHZlODVncUlHK3c2VURHL0VFajVILzQ3NkYzRjdzMGtmcDNBclBhYVdH?=
 =?utf-8?B?NjgzV0dPYWw2WlRxUlNJbmp4dHRFMVhncTFINGMvaFZtRlZoaGYxZmRSVWN4?=
 =?utf-8?B?eUl6czRxK0NEU1dFK0xqM0t0QWg4aFFIYjdtSUNjV3dMMktWc245QXg3a3Np?=
 =?utf-8?B?WnJjTnRYVVh3Mmt4ek0vVW5BTjJGc0V2TzBFVldqK0FsL0g0Q3dEMEhRRlNO?=
 =?utf-8?B?dVVMTTErVWhrYjJxd0MrK21QUXhzSE5DY3pndE9IU2tiN3VwdXJkRkNGU3VN?=
 =?utf-8?B?c1FCQTdINWJOdWVIeHhHdDdvazhxbEZqeHpLT0o5emNNZW43aVcyUHVDRVZs?=
 =?utf-8?B?MVAra0FZYTVLVGhYaEdrVGdQSlJkK2tEOVI0T2M0QVRFMWNZa1ZjUDR6NFJ4?=
 =?utf-8?B?aVZwUTB5a09Xc29seDRLOEoram5tQXlIelpRVjBtTmIvSXJXNWxhbmtzdXhu?=
 =?utf-8?B?bHgySGEwUERvdnZqNFNjQWdxTDFDM1YrL0doTmo0NHBKbUw5RFNSK3dRejFK?=
 =?utf-8?B?Ykk3UEdiWVA1cFpsMzhXWnk1ZXRtWXVkc3huSHo4dEUrUWs4TmhoZndzTFl4?=
 =?utf-8?B?RkkwWHZaL2gzQzB4MktON0RrTFBpUUJYL21KZ2s2NkVOTWhJWDhKVEVmdEcy?=
 =?utf-8?B?R3hXMlArQm9lTEd2TGp1Z2IyUVFDeldsUFc3SENHb29IQS9tWmFOZE50SnF1?=
 =?utf-8?B?R1FqZk9zTkM3NTlCcTBITUp3ZEV2dldxTzE0bkY0aWRoNklLZzV4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6043.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c1035f-dd81-40ff-a0fe-08da1795d5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 06:22:33.3103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwHSpSIXYrLrvf9ZqP5fuSfjm4ew9c2S3qhCmrNnhtk2eWNvKd8tc6YgyMrCadSlMgD7dvqxOqzbnaTgsqbyKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3752
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQmVuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJlbiBHcmVl
YXIgPGdyZWVhcmJAY2FuZGVsYXRlY2guY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAwNSwg
MjAyMiAyMjowNQ0KPiBUbzogUGVlciwgSWxhbiA8aWxhbi5wZWVyQGludGVsLmNvbT47IEx1Y2Eg
Q29lbGhvIDxsdWNhQGNvZWxoby5maT47DQo+IGt2YWxvQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4
LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA0LzEyXSBp
d2x3aWZpOiBtdm06IFBhc3NpdmVseSBzY2FuIG5vbiBQU0MgY2hhbm5lbHMNCj4gb25seSB3aGVu
IHJlcXVlc3RlZCBzbw0KPiANCj4gSGVsbG8gSWxhbiwNCj4gDQo+IEkgd2lsbCB0cnkgdGhpcyBz
b29uLiAgQnV0LCBhbnkgaWRlYSB3aHkgaXQgaXMgbm90IGFjY2VwdGVkIGludG8gaG9zdGFwIHBy
b2plY3QNCj4geWV0Pw0KPiANCg0KUHJvYmFibHkgc2luY2UgSSBkaWQgbm90IGNvbXBsZXRlIHdo
YXQgSSBwcm9taXNlZCAoYWRkcmVzcyBwYXNzaXZlIHNjYW4gY29ycmVjdGx5KS4gSSdsbCBoYW5k
bGUgaXQgYW5kIHB1c2ggYSByZXZpc2VkIHBhdGNoLg0KDQpSZWdhcmRzLA0KDQpJbGFuLg0K
