Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B747B2DC3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Sep 2023 10:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjI2IZn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Sep 2023 04:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjI2IZl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Sep 2023 04:25:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8601A7
        for <linux-wireless@vger.kernel.org>; Fri, 29 Sep 2023 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695975938; x=1727511938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=K+cAoMOZLfYeWKcUmshiwT768phHPlq89plDf8v/Y1w=;
  b=UD8IaaRu3J+D8PkQbNLABJbXUWYAmg9WNa/djbNwhif4/i+B4sgJ0SKs
   fMvpv1iCWQPPPJIsGcUAPIk9xQZDItNII1ql6SxLAvGAFfrrZ5G5oYOa6
   D4T4uCbdpzy9rHeqE1ABzpNyQL+vCp5VAhvLbk0n1HDQ+mWJStteYCIfV
   3H9v/BSf76c0CAxtSkT74DygRSZHP0HH/sg1QRBWoD5hpJ/buxsf2Wfkp
   mqEYnHmyAQyFXhlMjofI98EPuTeiLh0gj9yNqMC4UxzCofC/EBFvq5Cvx
   qFM33pglwalEvb4vKxQ3V4GFKbtBJpp2xs+L+hsaHzltfaq29nmHfhtUg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="362500325"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="362500325"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 01:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="840206726"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="840206726"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 01:09:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 01:09:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 01:09:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 01:09:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 01:09:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFGSCtIKjpeQMy/OQrx11A70NEPKMP9mwAtsGcRbAcIG3xBLOeHHFI3/c2BXdM+5V9ZZaEieyDoZfMFGcetIHiUFYBwc6RT8AfH4CDk8arqUO1iGDlzbklgJcNdgT37C939CGmY4/6Tj4ZfRuepKjBV2Hs65QQ3pSP/OH81EeMM9+HsMmDtl06MQowRG69rA55uiidJ+WDln0lWea2e0yp6f+Cog9FBpM61m80bkkwZkv48ILwuqOBsov//6JlCHvx82ZGAxCXVl39YWMhBHKBm0PxpzmLVIVA6dDwL+01UL96NmewRMm4hkJxmdtEXr+P+Ht4+OEK7IUz39QeXucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC5Dlp4ib7i/Dum/T7N7UPVy3N6bi2CcYAf7Bxj9MN4=;
 b=I7vdnqzj+zVIEnL68mNZbbNdZ9q3lUtTmLSeVVPEvbUyMD96ayT7StJL/c7q/uHE/zXrgXK/6EvyWHb1Q+GiccO9ImKmmen1z0h6vxaoCdN2avMrLU+V7NhP23vd8PRJK6urTPjBeR5ubXJ4M11JXCS1a0AmHDtz5wUa0yPQ4OUsnZtIwTmwWG3tropM40krsPd4xHR8hyXnw6+bxR8i+USVHpCuqvMaJgn0sHmKbaIeclWaZru1RXcGZTeFUNRB8+wtLQW5XymGvjz3l7DHfoe9F8ByZ4byAOX0EZbEB4J69oFvb6H5wcpW+hRkBMQ92HNquM0Iu42NFozLpyXAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12)
 by DM3PR11MB8672.namprd11.prod.outlook.com (2603:10b6:0:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 29 Sep
 2023 08:09:30 +0000
Received: from DS0PR11MB7969.namprd11.prod.outlook.com
 ([fe80::fc58:88ca:6891:a55f]) by DS0PR11MB7969.namprd11.prod.outlook.com
 ([fe80::fc58:88ca:6891:a55f%4]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 08:09:30 +0000
From:   "Berg, Benjamin" <benjamin.berg@intel.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 08/18] wifi: mac80211: mesh: fix some kdoc warnings
Thread-Topic: [PATCH 08/18] wifi: mac80211: mesh: fix some kdoc warnings
Thread-Index: AQHZ8hkuPUf4eT0LbkS2aOuEk7BCbbAw6h+AgABzj4CAABapgA==
Date:   Fri, 29 Sep 2023 08:09:30 +0000
Message-ID: <4f6c6bc104c61f4ad731a1916ce5a8b574519b14.camel@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
         <20230928172905.33fea2968c62.I41d197b570370ab7cad1405518512fdd36e08717@changeid>
         <ae8e358d-3d02-4167-9232-5da8a2ec3d1c@quicinc.com>
         <3ff89e5a9ee6aeddaa771e1ada0faf13ce549f9f.camel@sipsolutions.net>
In-Reply-To: <3ff89e5a9ee6aeddaa771e1ada0faf13ce549f9f.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7969:EE_|DM3PR11MB8672:EE_
x-ms-office365-filtering-correlation-id: 22f785d8-57c3-4064-b32f-08dbc0c3681b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2UuX7HtNG2F8ega870rTdYA1yaOQrvkVZGFvQ2/zzsDSe7Mhrw87RqFYAkNQ3BeRYDtdLzxi6l1GYb0LP230+hERMpKOiFjkTVlhJjQTRhWm8xbPeYVdRGj0712deoyT3Vn5FCTZSvW9wSlM1QJAixxWAVY7HNELkikjPLhqF7XkCW7klZMfidoy0+nVysDMd+GehTUN3QeMfAleQySi+u05j/DQa9+vZpE+ClxgPca0/x2b0j3xz3KopvH1xSqyEhdAeytJJ9XV0Xp4V8PUbLjHT9BGeUHbLUs7ptU1Rga/L/tExZnFKRsWt4a1PQacS08RELXtkyMJgiFPGS4k43YSgZl78wHNKevO53ATOWzOKYZQi+3NRi1NAgM+dJ+s3cwMgVLfcEZia3pJ1FLZye9xlAjwnEjbUtKHZZEtEp45WhwKNaYH7/KpiQW02jKnGS0VD7LPga1b04S1NvVxb99f69HQKTaH44beqIB7NybY3hCyiKTP3x49aYZpug8Q/WOXPHhJMl1HY8FPNvs1Jqt+UoYdek/VBT7IcDFHLigbnCKX497WEe9hrb3TSWNbNRKSkuGh63CeV3SH7tQ+lBQ/Jx3vYcRyJQ9PQPKIwE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7969.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(71200400001)(6486002)(6512007)(122000001)(38070700005)(36756003)(82960400001)(38100700002)(86362001)(2616005)(2906002)(41300700001)(478600001)(66476007)(316002)(66446008)(91956017)(64756008)(66556008)(76116006)(66946007)(110136005)(4326008)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWQxNUMrY1cxb0ZPYXNlSE5mcEVQM1BWYUU1THFkZUY1akpRbjlKbHlnY2tz?=
 =?utf-8?B?MDdQT000WFRxSVVQWFZBYmwyV1ZkeEpvVE1xWkx3UFBWWERORUtyV2FCb001?=
 =?utf-8?B?eUVnWnVsM3NXSjJ5TnAvVEt2dFZaTVhhT21OTi9MZXp4dmRxVjJDN2N4WVZa?=
 =?utf-8?B?U3ZwcW1VSHBPeDlRZzh0WHlrWHJpdkZ6WG1HVXE1MVUrUysvbE1nMVoyVzRX?=
 =?utf-8?B?NEI0Y2ZNKzNnLzBqTjZSdWtqTmlPQ256RHM0TUhmT0ZkTzdzVFRteDQwS2RW?=
 =?utf-8?B?SkdFWEZpVmlOVlFYK3VtSzVHSStka0hpZDBRaHpCL0lGYnlQNEpNdWNhY29i?=
 =?utf-8?B?S3NnMTBxR2x1U2E1ekVOT3Q3U0xDVXVwKzVGV01YeGhLVDlMS2lFSkxHc21y?=
 =?utf-8?B?Z1ArcDZnYUVDRG5uSDZXREp0NkVCMjJTZkpuM1BRd0hrakhqekljS1NpQVJz?=
 =?utf-8?B?cmVnbHhMRENiUlk5TlBGM1kzaGJkQ2N5SnYxdzdrdEFLNVh2UUgyV0xTbDNu?=
 =?utf-8?B?dTZwS0ordEtxNjBEeVNFaVNYTEJpV3NEMXJ0b055SFU0ZEpmdjdYVGxiL2VY?=
 =?utf-8?B?Z3JDdzE5RVNlWjRjNy9XUUNkWHZ6cVpmRVFHRTV1QTBtYTh6SmJWUVBtdi9M?=
 =?utf-8?B?cThiMzNZbWpzTzNCR0pZdmNmSHFWTVRhMTJaWnlUeFluQmFydk9QYTl0U0FQ?=
 =?utf-8?B?THU0bFZOY0UxQjNxNW1JU0owWTRMOHVsQTUycnpzYWRjT1VkZkFJT1VRUm1U?=
 =?utf-8?B?SVpCNGg4QkFqUVNWY0REMlJueXFlajFEWkZmbEx0R0xiaFg2THhKMHU4VUkr?=
 =?utf-8?B?VWFCa1RLSVdJM3BXd1JxbkFKeU1pM1M1Q2p6dGxTRjJYeUppUklDbUlqQjBD?=
 =?utf-8?B?UmhyNFYxdVFCaFc0VkZSQnJGWHV6MGE2cWtPaHI0L0FuQ2J5YnNqdmtlNU5H?=
 =?utf-8?B?OE1YYUVtMmpOYVI0ODBOQ1NrL0ZRRmtwbzRxV2NDeUpWVXVSQ0N1TUhzZW1u?=
 =?utf-8?B?V1VuQVBCbkFwR0pzWHdFUGRuRGY5dVFvR3FmM2ZDVVNXNm9YdGEwd05qM0o3?=
 =?utf-8?B?ZUt0cjk3Rm85L2pBbHJYaWZzd3ZTYjBKNjBzek82cTM5djZkVnNMOEdVMjZo?=
 =?utf-8?B?RW9rVjYwUHY1ckZwdkJtdGk2TDlhbUdRVzRYMG9uN1VNUWZocG5OOTRsUWV1?=
 =?utf-8?B?bDdXMXc2SGhaM01LSW9veS92YmZCNnFvRmV4QnEvWnRNRlJXNUhaMnpNd05V?=
 =?utf-8?B?emZyWmdDVHNUWDFwcU4xcWNPbFoxaHdWZnVOdTNuZXl1aGQxbFJvN1ZKNnAw?=
 =?utf-8?B?UUliUWlZeUFTaHpGZTZVYlMrTU9hd21pbWR6YkwxY2k2RzNyRW9XejU2NUlR?=
 =?utf-8?B?UkxXTzVWNURETVNoWCtKckEybytQWGc1WEczdTVlUEV4eVJ3dnc1VUlkYjZO?=
 =?utf-8?B?eTVBTjVrYVdoSWlJNzhwcmJqbGdiY0JWajRSWGpqWXBGZ1EvMmZrZnVIdGxv?=
 =?utf-8?B?NmpIbHJjak9VOENLdFdYUHgvdGV5UGlQc2I5OUsvUVgvZ3VPSlhQenMwSU95?=
 =?utf-8?B?T0xxVTRLS2hqV3AzWUo4SWUza2FGZHhYSzRURUQwYzdraG1QN1lFTFloOSty?=
 =?utf-8?B?bGx3V2dQYk5RNnhRTEcwUmg0c2RoTUdhSy9wa1JvNEJmUGk1OHZKa2IxcEN6?=
 =?utf-8?B?RTFodHpGN240V0o3SUl3M2dUbWhJb0dRR1lWdkVTTFBlbnYrcFhJdFFBZzVp?=
 =?utf-8?B?S3FQM0FjZFRITU45aE00Y1YzLzFMa1UyRk5WQ3BaZGZHS2RUN3FQZkVXdVM3?=
 =?utf-8?B?V3dVV3RiaS85a1Q1b2RDeHZPcitnNlQxdTZ5SkVTdStzWmhxUHZZa2MvT1hw?=
 =?utf-8?B?b3VUSUhTczdVSUc4bVo4ZlI4ZjM2T0FjWTNTdVFqTWVFN2pzVTAwWXloSGg2?=
 =?utf-8?B?U0pvNjV1YzBNWXpPaElGYW5aZFFDeFYreUdRSHRONnFXRjZwS2huSHcxVlhs?=
 =?utf-8?B?VlA4dFNHS3V3QjJ2ZC9IUVVscFU2eW1TK044RjA3ZjEzaTZjdjRzOWl4RWxP?=
 =?utf-8?B?QmpzeTE0enA2KzNHRFJrdVJEeDJuZ2tCeURWL1hlK0E4QTUwVWVXUEJrZUlS?=
 =?utf-8?B?MjFzS1p3ZTloZE9TMEZObEhZZXdHOUxDa3drZjd6RGdhSmZ2ZWJKV2YzbGRt?=
 =?utf-8?B?aWV4cGdaQXFCblJ2eXUrcmNnY1l1OEZEMkpIenlaWjUvVTVOT3BHNndIclRT?=
 =?utf-8?B?anhmSUhNVWVOYnJhUm9OdjJ0UDhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17F452BFDE953045A13ABD254F038D86@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7969.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f785d8-57c3-4064-b32f-08dbc0c3681b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 08:09:30.0854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wx07ucdGkIVFFoGzFGcRRudJdaCnTNld+sVjEj+UBHCgL6r7210KkvI56O1OeHlI4sxldEbjXB6xQtD/o2Cxug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8672
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTI5IGF0IDA4OjQ4ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBIaSwNCj4gDQo+ID4gPiArKysgYi9uZXQvbWFjODAyMTEvbWVzaC5jDQo+ID4gPiBAQCAtNTYs
NiArNTYsOCBAQCBzdGF0aWMgdm9pZCBpZWVlODAyMTFfbWVzaF9ob3VzZWtlZXBpbmdfdGltZXIo
c3RydWN0IHRpbWVyX2xpc3QgKnQpDQo+ID4gPiDCoMKgICoNCj4gPiA+IMKgwqAgKiBUaGlzIGZ1
bmN0aW9uIGNoZWNrcyBpZiB0aGUgbWVzaCBjb25maWd1cmF0aW9uIG9mIGEgbWVzaCBwb2ludCBt
YXRjaGVzIHRoZQ0KPiA+ID4gwqDCoCAqIGxvY2FsIG1lc2ggY29uZmlndXJhdGlvbiwgaS5lLiBp
ZiBib3RoIG5vZGVzIGJlbG9uZyB0byB0aGUgc2FtZSBtZXNoIG5ldHdvcmsuDQo+ID4gPiArICoN
Cj4gPiA+ICsgKiBSZXR1cm5zOiAldHJ1ZSBpZiBib3RoIG5vZGVzIGJlbG9uZyB0byB0aGUgc2Ft
ZSBtZXNoDQo+ID4gDQo+ID4gSSB0aG91Z2h0IGtkb2MgdXNlZCBSZXR1cm46IG5vdCBSZXR1cm5z
Og0KPiA+IA0KPiA+IDxodHRwczovL3N0YXRpYy5sd24ubmV0L2tlcm5lbGRvYy9kb2MtZ3VpZGUv
a2VybmVsLWRvYy5odG1sI2Z1bmN0aW9uLWRvY3VtZW50YXRpb24+DQo+IA0KPiBIdWgsIGluZGVl
ZC4NCj4gDQo+IEknbSBzdXJlIHRoaXMgYWN0dWFsbHkgZml4ZWQgaXQgdGhvdWdoIGJlY2F1c2Ug
d2UgZGlkIHN0YXJ0IHJ1bm5pbmcNCj4ga2VybmVsLWRvYyBvbiB0aGlzIGNvZGUgaW50ZXJuYWxs
eSAodmlhIFc9MSksIHRoZSBpc3N1ZSBhdCBoYW5kIHdhcyB0aGF0DQo+IHdlIHVzZWQgdG8gY29t
cGlsZSB3aXRob3V0IG1lc2ggKG5vdCBzdXBwb3J0ZWQgYnkgaXdsd2lmaSkgYW5kIG5vdyBhZGRl
ZA0KPiBpdCBmb3IgaHdzaW0gdGVzdGluZy4NCj4gDQo+IFNvIC4uLiBJIGxvb2tlZCwgYW5kIGlu
ZGVlZCBfYm90aF8gYXJlIGFjY2VwdGVkOg0KDQpIYWgsIEkgc3VzcGVjdCBJIHVzZWQgIlJldHVy
bnM6IiBoZXJlIGJlY2F1c2UgdGhlIGZpbGUgYWxyZWFkeSB1c2VkIGl0DQppbiBvdGhlciBwbGFj
ZXMuIEJ1dCwgSSBhbSBhbHNvIHVzZWQgdG8gIlJldHVybnM6IiBmcm9tIGd0ay1kb2MsIHNvIGl0
DQptaWdodCBhbHNvIGhhdmUgZmVsdCBuYXR1cmFsIHRvIG1lIGJlY2F1c2Ugb2YgdGhhdC4NCg0K
TXkgaHVuY2ggaXMsIHRoYXQgaXQgcmVhbGx5IGRvZXNuJ3QgbWF0dGVyIGFuZCBpdCBjYW4gYmUg
bGVmdCBhcy1pcyBmb3INCm5vdy4gQnV0IGl0IGlzIGFsc28gb2J2aW91c2x5IHRydWUgdGhhdCBp
dCBtYXkgYmUgc3VycHJpc2luZyBhbmQgdGhlDQpleHRyYSBjb25zaXN0ZW5jeSB3b3VsZCBoZWxw
LiBTbywgYSBmb2xsb3cgdXAgcGF0Y2ggdG8gbWFrZSBldmVyeXRoaW5nDQpjb25zaXN0ZW50IHNl
ZW1zIHJlYXNvbmFibGUgdG8gbWUuDQoNCkJlbmphbWluDQoNCj4gc2NyaXB0cy9rZXJuZWwtZG9j
Og0KPiANCj4gwqDCoMKgwqDCoMKgwqAgfSBlbHNpZiAoJG5ld3NlY3Rpb24gPX4gbS9ecmV0dXJu
cz8kL2kpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAkbmV3c2VjdGlvbiA9ICRzZWN0aW9u
X3JldHVybjsNCj4gwqDCoMKgwqDCoMKgwqAgfSBlbHNpZiAoJG5ld3NlY3Rpb24gPX4gbS9eXEBy
ZXR1cm4kLykgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgc3BlY2lhbDogQHJldHVybiBp
cyBhIHNlY3Rpb24sIG5vdCBhIHBhcmFtIGRlc2NyaXB0aW9uDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgJG5ld3NlY3Rpb24gPSAkc2VjdGlvbl9yZXR1cm47DQo+IA0KPiANCj4gd2hpY2ggSSBn
dWVzcyBtZWFucw0KPiANCj4gwqAvKioNCj4gwqAgKiBmb28gLSAuLi4NCj4gwqAgKg0KPiDCoCAq
IFJldHVybnM6IGJhcg0KPiDCoCAqLw0KPiANCj4gYW5kDQo+IA0KPiDCoC8qKg0KPiDCoCAqIGZv
byAtIC4uLg0KPiDCoCAqDQo+IMKgICogUmV0dXJuOiBiYXINCj4gwqAgKi8NCj4gDQo+IGFuZA0K
PiANCj4gwqAvKioNCj4gwqAgKiBmb28gLSAuLi4NCj4gwqAgKg0KPiDCoCAqIEByZXR1cm4NCj4g
wqAgKiBiYXINCj4gwqAgKi8NCj4gDQo+IGFyZSBhbGwgYWNjZXB0ZWQuDQo+IA0KPiANCj4gVGhv
dWdoICJSZXR1cm46IiBpcyBtb3JlIGNvbW1vbiwgcGVyaGFwcyBkdWUgdG8gdGhlIGRvY3M6DQo+
IA0KPiAkIGdpdCBncmVwICcgXCogUmV0dXJuczonIC0tIHwgd2MgLWwNCj4gMzA2Ng0KPiAkIGdp
dCBncmVwICcgXCogUmV0dXJuOicgLS0gfCB3YyAtbA0KPiA5MTg5DQo+IA0KPiANCj4gUGVyc29u
YWxseSwgSSBmaW5kICJSZXR1cm5zOiAldHJ1ZSBpZiBib3RoIG5vZGVzIC4uLiIgdG8gYmUgbmlj
ZXIgdG8NCj4gcmVhZCwgc2luY2UgaXQncyBtb3JlIGxpa2UgYSBzZW50ZW5jZT8NCj4gDQo+IEJ1
dCB0aGVuIGFnYWluIGl0IGRlcGVuZHMgb24gd2hldGhlciB5b3UncmUgcmVhZGluZyBpdCBhcyBh
IGRlc2NyaXB0aW9uDQo+IG9yIGFuIGluc3RydWN0aW9uLCBJIGd1ZXNzLiAiUmV0dXJuczogc29t
ZXRoaW5nIiBpcyBhIGRlc2NyaXB0aW9uLCBhbmQNCj4gIlJldHVybjogc29tZXRoaW5nIiBpcyBh
biBpbnN0cnVjdGlvbiAoZm9yIHRoZSBmdW5jdGlvbikuIEhtbS4NCj4gDQo+IEknbSBpbmNsaW5l
ZCB0byBzYXkgSSBsaWtlIHRoZSBkZXNjcmlwdGl2ZSB0ZXh0IGJldHRlciwgYnV0IHNpbmNlIGl0
DQo+IHNob3dzIHVwIGluIHRoZSBnZW5lcmF0ZWQgZG9jdW1lbnRhdGlvbiB3aXRoICJSZXR1cm4i
IGFueXdheSwgbWF5YmUgaXQncw0KPiBiZXR0ZXIgdG8gaGF2ZSBpdCBpbiB0aGUgc2FtZSB3YXkg
aW4gdGhlIGNvZGU/DQo+IA0KPiBUaG91Z2ggb2YgY291cnNlIGl0J3MgKHNsaWdodGx5KSBlYXNp
ZXIgdG8ganVzdCBhcHBseSBpdCBhcyBpcyA6KQ0KPiANCj4gV2hhdCBkbyB5b3UgKGFuZCBvdGhl
cnMhKSB0aGluaz8gRG9lcyBpdCBtYXR0ZXI/DQo+IA0KPiBqb2hhbm5lcw0KDQpJbnRlbCBEZXV0
c2NobGFuZCBHbWJIClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1
YmliZXJnLCBHZXJtYW55ClRlbDogKzQ5IDg5IDk5IDg4NTMtMCwgd3d3LmludGVsLmRlIDxodHRw
Oi8vd3d3LmludGVsLmRlPgpNYW5hZ2luZyBEaXJlY3RvcnM6IENocmlzdGluIEVpc2Vuc2NobWlk
LCBTaGFyb24gSGVjaywgVGlmZmFueSBEb29uIFNpbHZhICAKQ2hhaXJwZXJzb24gb2YgdGhlIFN1
cGVydmlzb3J5IEJvYXJkOiBOaWNvbGUgTGF1ClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gKQ29t
bWVyY2lhbCBSZWdpc3RlcjogQW10c2dlcmljaHQgTXVlbmNoZW4gSFJCIDE4NjkyOAo=

