Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AAA63B2B9
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 21:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiK1UDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 15:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiK1UDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 15:03:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78D462DB
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669665821; x=1701201821;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=dzWgPnI2WXvvR+tPyTCvzndvVf7FxWyzKa8pqjnmxp0=;
  b=e+r95EjB/dyhepW2heRM3nvsdSCKU/rQOvJ9ikf1ctkqXTwZhLfWuxJX
   l/uTPMQXy2dxSoSbaaGK/vEeM2LrpeNUAxyr4yyFXevudLq79QN4cTrn6
   A2I5oqsb7/W8qdM4MSU3dSm0suAkEgKEfE2QaevtX37S5xs3xJdyba1mA
   6jhccqZa8vy/yhGOz1/yY+ysuoEXRmSY03dyzDIrwaHGaEzdQB2V8iBXL
   GEFtVACVDs9MOxsDGORf2CovILvWt3aQFwejkDSK0wEVyI2VTzAr8cvEO
   VNv3rEc42PPjYpVoTwferw9W6eEcMZ8IQ9nXM1hUwB3bYgF9hgJi8w1pR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="341852077"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="341852077"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 12:03:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="785768600"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="785768600"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2022 12:03:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 12:03:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 12:03:41 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 12:03:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF4BfHS7E4VjqBKW8AyB2kRZle9P+owLR/wcJLGsAL9KZv40GT62R6whGQkaEYQ3LQnu11PXf0qw+gyU/mQCGKy5ms8LuGM32vHgzwj9PgFJESzQ0TdOx5LKfsh77xL9AO7Xa2DsILzBLUqjF7apBjKS73cZHBb63gELwB/zSlftkuKM0IVtTB+jj0+0QrBA+NbayTlmz+Ia/uKC/IZ8F1DE2e9XGwa9wX0UZlivERrBNb87dhs96b+febe/ZKOWG4BpvbuAgy8gBdejZLYPdhxKwVV7qv7HXT8McqiOuox2Qj9hk+bN2jWzmPL6Tv1GlTFG8xx+M6tMIRgIcxDPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzWgPnI2WXvvR+tPyTCvzndvVf7FxWyzKa8pqjnmxp0=;
 b=nMFnmlPRoXFSjMCrLSJIULaXoZFibnKNO21HhtbJTS43GLdXt8qvx7lzs68yLVs0eMqkYNlfbpeQKChEebJt/UERaTOudc8/ufxmXTMCFmetVTy60pxbkrJft6VyU62btzQvUrM2ohhFcVl2+iF4IUVh4iZ/NUW8a2zItsmnk61WQBUvNHQnNJ4sTFXnsq3FJ5J5TFDRMT+mKoySokctJ41Vjf0rKZU8lMQJemTOgAFymSpgSLdwIuiKckhMdLPGuYIe15F/vAH6KShLwPAuV0MueJf7sbYd9M0Zpoyo44cf1fvyCKM9AnazHN5M2F/mQ7m/QWWQ4/LDRkRcrjU1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by PH8PR11MB6612.namprd11.prod.outlook.com (2603:10b6:510:1cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 20:03:38 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a%9]) with mapi id 15.20.5857.018; Mon, 28 Nov 2022
 20:03:38 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next-for-kalle-2022-11-28
Thread-Topic: pull-request: iwlwifi-next-for-kalle-2022-11-28
Thread-Index: AQHZA2SB5oTR+JsBG0a9m4D6sMqv5w==
Date:   Mon, 28 Nov 2022 20:03:38 +0000
Message-ID: <b194da07d6f2617e6f273d204712d360be79f634.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|PH8PR11MB6612:EE_
x-ms-office365-filtering-correlation-id: ffd93f85-e914-4434-2c15-08dad17ba38e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znFQQDV/6RE+kYay75dyaaD1lCfZgn5tm7YiA1Lw9fOnbjMvWGu4B9i7zjLeDKet6k7DU6nZ+1JlA1yjugCos9nCtEI6EEYL+d5lhyzPsGaaUv6ylKljLekJOZnGHb9mNS/UBK8KwruQefP8mOuSUkfpfb/njFaY53KLMIbxkt3Zd8/gYP9pYK7yY5Ks/jckoBU8qx5f+N2tw6viXbQyGlF8xmQEpQE7I5ONngyZU1Yx9zrrSVDC9va/IG4socIU+E9RPdWZEfQuekyXipUBZmIiXmN70IvqWrIhkThrbwmH472jCIgtBROV0yOyT2jLhrr+nn6RvioODIho7qZzw0DtBedDHDNonEq6Azab0JpSfg4vx7tmiE+W/JkN1F0oEwpJvgntplC06tWpPFnrbQbJ7+on47bRwcEqvjwchDX8/7gWQiTuw82v86VgPGAQtSIk0FbydJMD2CcFSekxeVHQeqDjig0vUDOAC7TO9jENmD54s4RRWB2gtjq8jQbs5FaVzej7CIXMLBVcDU/OR2kKK7d4ApRgtuyAeuiqjnTMpg1KvtJyk4DAVKfyp13JQ13Rdn3Lg54ebH1kbh5w4srM1Y0BwRrrlBfcEKeUa8+rumwfGkpWG1vf/N63JU2Yzn4QChOcP0LoBtoiC7XroYq7w+/r44w9NslX8FxBFGnxYcmhnyslaPk55Uw7+VZGvoUeGvKXXxTv6mfQ5W2LZojw9dqdzcNR9m9p5rPK/0g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(4326008)(8676002)(5660300002)(66476007)(8936002)(41300700001)(66556008)(66446008)(64756008)(71200400001)(2906002)(4001150100001)(76116006)(316002)(6486002)(478600001)(966005)(66946007)(6916009)(36756003)(91956017)(86362001)(26005)(6512007)(6506007)(186003)(38070700005)(2616005)(83380400001)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3p6MGR6eUREOTRIMDV3SEtJYnhHRis0K250Y2RvS1hZNXZqSm9vWEgwK1c0?=
 =?utf-8?B?NWZJRmZoeTA0TU1uVUJNbUNJbUtodmRaZ3ZvOHUrVFd2R3h2Qzc2bEFkVnNU?=
 =?utf-8?B?VUtheldjOWpnR1MrUDcwbVRDeWFUUEs3Q2FMN1RwQ0poTTBCbkZzMFlIcTZ6?=
 =?utf-8?B?Qk11ZkswSmZMc2F2WHdtc3kvanA5SzBIdXZvMW80Y2VvaHZmcmMwL3Jxa1dW?=
 =?utf-8?B?M0doS1dwaGQ0aFBZUmlTemU3ZjUxQ2lEMm5jWjVMcm9CeHdBVk9TenM2YWJB?=
 =?utf-8?B?L2x2dloyTUdKK0hjSm9ENmlPT0JNV0JlWmZpQVVDT1NUVEFRWjVRN2VqNVhW?=
 =?utf-8?B?YTdpNXd3K3ZVUGNITUdCdFo2dktQSDVoZllnY3RabEhoTXJjSUUvTWUvNTdz?=
 =?utf-8?B?Y0RtUkpHR1dkZU5kUGJnOGRZT1JpWEFUYjczbHRZTW9HRzJ6elNNbWFPTnpm?=
 =?utf-8?B?Y29OZCtib005RlowY3dLdDV1aEpiWnEySHVnRVJZaFJRRkNkTHovM2NwZXY5?=
 =?utf-8?B?KzBjWkhEbHplYXZ3WVBZV2tDZFM4cGRyNkJUT3Bpek9wWWNiOXVSZldRaktU?=
 =?utf-8?B?dmdEbUZKOENSbkxvQUZIOW9HNGlRK1ZwMGoxdHgwaXlTRTR6M0hKTjJ1TStG?=
 =?utf-8?B?UTVnOCtISVh4aHhkL0xialJCVitOa2FtOVlDRERqUjNWdHZMbnZNSG0rSDNE?=
 =?utf-8?B?ZVVBZ1BRcStGNFZlV0NDZDdMQkFjMjFTbHROc2RxZkk2YlJDc0FvajgyOVhS?=
 =?utf-8?B?YVJud3ltL2p5Q1ZwT0JISTdVa0VWakNwa3dCVTVPa3ZZRlVYeUlKYVVnU3pG?=
 =?utf-8?B?RkJSejN2U1RVMkQvSjhkb3JmQjBUWEdEUHlraXNqUDNiS3Y2YjVGQVdSZzRS?=
 =?utf-8?B?Nk5EdE9Za3I5N0RzN29MSVhhZU1Fdk5Pa0dPekVXRUpRbHg2U1FWdVQ0WUVk?=
 =?utf-8?B?aE9oZWY4UmJIWGhsNXgrSUlTeW00QWtzSFB6cHFoUXR0S0ZUUUkyOVNBd2lN?=
 =?utf-8?B?cldRK013N1NGd3orUWtuREltZy8rVXRPcjVhTyszTi9GbzNNNUY1Y0tkQUxL?=
 =?utf-8?B?djgvMHlTNUU5YU9zZGZPbTlZTlVGVk5tTWFPdkNpRldBTndVMkE0THhIcVVi?=
 =?utf-8?B?ZzB2bnhCdVdyc3JNdTNCa3dPV0E3bnI0Z29INlVTOWdkLzQ0Smc4MGJkRkUy?=
 =?utf-8?B?N0JQa0hUb2YvUW1HRnRST0JUSU1VT2F2cGExT2lGWVF5R1l0dTIwV05RQXJ4?=
 =?utf-8?B?RDlCLzA0TlU0ODdVWm02bHpxcWt4MmRSMXV2aGNzQUEzVlZLM1haMzMrVkR1?=
 =?utf-8?B?elhwTU1tdHlLUmVNdTFXb01yNGpWdzIzWCtpWVI5RzRETHI4dVh6Q2NuTWl4?=
 =?utf-8?B?bUJlanlrMXcwa1p3RjJEY25nL0NWSmdsUGM2aXF1SGFGWlRhZFhsdGJxajkw?=
 =?utf-8?B?WllEMHRhVGowM3F2NUJSU3NJa3prOWFWSFNFeU9Cdmw4Y1R1eVhUUDVzcWg4?=
 =?utf-8?B?OU9wQ3Q2Snd0MEhBYWVwV1J4QmRBclVPSUp2eVVtS1ZaZTEwclpGWEJOdEo1?=
 =?utf-8?B?T0xWMm5mVW9sU2xNZncySWxTcU9Ba2FQaHVRWVpRVDdmS1hVdnVYeHZxSHQ5?=
 =?utf-8?B?eGtLeEpIemRTQmpIZVQ0YVVtZFNRVVpzS2pyUmhZVUlQVGMrR3FMOUZ4clBD?=
 =?utf-8?B?SmxiL0o4R3FVMTF1N29IZjVCUE5Rb3VoSWtjWjFraUg5dUgzaUVrWWN6V3Rp?=
 =?utf-8?B?NEw5aGZxU25lUzdpMUphTno1MmpRMEVRRk0yT1dGRFRxM0N3NzR6TWtVSmNL?=
 =?utf-8?B?d1RndDZweWZ6cVpuNFFrenUxakVkRCtHcUZtMlNmNE90RlJKd3hLV2lnMy8z?=
 =?utf-8?B?SHJVZ2ZuZkljTURQVlllLy9OazlmNks1WllsWkViWnRRc1dGekJNQTU3OTFz?=
 =?utf-8?B?VG0zamRkc1FQazQ4UmNlUzRsWHFtaGU0NGlCbEsvTkJ3WU8yTVc1My84Tzdn?=
 =?utf-8?B?b3Ixakl3ZGhnODhjTzVXQUZmeHM2b3Fhd0FMMlhjSnVtZEFqZjU5TmNHdE1K?=
 =?utf-8?B?anA2Q3JPc1pHNThIaEZpQ2dmUXI2bWRXMmVYRDc2bUViUS9ibXlZTlN3dWtW?=
 =?utf-8?B?K0xxM0pWRmlsSk5HTUJZcXhaYTYyUzZ3akdFNzlQOEl1bTB4Y0tDd0RzbmtI?=
 =?utf-8?Q?9Z3sIQkZusMUhOasXpw3ArA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7D0EA31D3F6E34E8EFE4A9A1369DF2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd93f85-e914-4434-2c15-08dad17ba38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 20:03:38.1064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgf23kcFjS+T4+g6wIz66AgE0YhZilzsXvd3hBPUfJ7uyEYDjQO735oCWnEfITWdr2ALJTQbnoEAvX2CqOvK7glu9I2BoiwjiausZAz/y2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6612
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCkhlcmUncyB0aGUgc2Vjb25kIHB1bGwgcmVxdWVzdCBmb3IgdjYuMiB3aXRo
IHRoZSBsYXN0IHR3byBwYXRjaHNldHMgSSBzZW50Lg0KDQpJdCBjb250YWlucyBFSFQgYWRqdXN0
bWVudHMgYW5kIHNvbWUgYnVnZml4ZXMgKGl3bG1laSBhbmQgb25lIG9sZCBidWcgaW4gdHggcGF0
aCkuDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhh
bmtzLA0KR3JlZ29yeQ0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGVjZWIw
MjRlZTNlZWQxYmFjYjVjMzJhNDg0NzI2OWYyNjg1ZTJlYTQ6DQoNCiAgTWVyZ2UgYXRoLW5leHQg
ZnJvbSBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQva3ZhbG8v
YXRoLmdpdCAoMjAyMi0xMS0yOCAxNjo1ODoyOCArMDIwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0
aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9pd2x3aWZpL2l3bHdpZmktbmV4dC5naXQgdGFncy9pd2x3aWZpLW5l
eHQtZm9yLWthbGxlLTIwMjItMTEtMjgNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRv
IGYzMWY3Y2Q5ODc1YzJhYjc0NDAwNmJkMmFkMjU2NDFkYjUzZjA3OWQ6DQoNCiAgd2lmaTogaXds
d2lmaTogbWVpOiBmaXggcGFyYW1ldGVyIHBhc3NpbmcgdG8gaXdsX21laV9hbGl2ZV9ub3RpZigp
ICgyMDIyLTExLTI4IDE3OjU0OjA5ICswMjAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpUaGlzIGlzIHRoZSBzZWNv
bmQgcHVsbCByZXF1ZXN0IGludGVuZGVkIGZvciB2Ni4yDQoNCkl0IGNvbnRhaW5zIHR3byBwYXRj
aC1zZXRzIHNlbnQgYmVmb3JlIHdpdGggdGhlIGZvbGxvd2luZyBjb250ZW50Og0KKiBpd2x3aWZp
IEVIVCBhZGp1c3RtZW50cw0KKiBkb3VibGUtZnJlZSBmaXggaW4gdHggcGF0aA0KKiBpd2xtZWkg
UExEUiBmbG93IGZpeGVzDQoqIGl3bG1laSBzbWF0Y2ggZml4ZXMNCiogYSBsb2dnaW5nIGRhdGEg
aW1wcm92ZW1lbnQNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQWJoaXNoZWsgTmFpayAoMSk6DQogICAgICB3aWZpOiBp
d2x3aWZpOiBudm06IFVwZGF0ZSBFSFQgY2FwYWJpbGl0aWVzIGZvciBHTCBkZXZpY2UNCg0KQXZy
YWhhbSBTdGVybiAoMik6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IHRyaWdnZXIgUENJIHJl
LWVudW1lcmF0aW9uIGluIGNhc2Ugb2YgUExEUiBzeW5jDQogICAgICB3aWZpOiBpd2x3aWZpOiBt
dm06IHJldHVybiBlcnJvciB2YWx1ZSBpbiBjYXNlIFBMRFIgc3luYyBmYWlsZWQNCg0KQmVuIEdy
ZWVhciAoMSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IGZpeCBkb3VibGUgZnJlZSBvbiB0
eCBwYXRoLg0KDQpEYW5pZWwgR2FiYXkgKDEpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiBw
cmludCBPVFAgaW5mbyBhZnRlciBhbGl2ZQ0KDQpHcmVnb3J5IEdyZWVubWFuICgxKToNCiAgICAg
IHdpZmk6IGl3bHdpZmk6IG1laTogZml4IHBhcmFtZXRlciBwYXNzaW5nIHRvIGl3bF9tZWlfYWxp
dmVfbm90aWYoKQ0KDQpJbGFuIFBlZXIgKDEpOg0KICAgICAgd2lmaTogaXdsd2lmaTogbXZtOiBB
ZHZlcnRpc2UgRUhUIGNhcGFiaWxpdGllcw0KDQpKb2hhbm5lcyBCZXJnICg0KToNCiAgICAgIHdp
Zmk6IGl3bHdpZmk6IG12bTogc3VwcG9ydCAzMjAgTUh6IFBIWSBjb25maWd1cmF0aW9uDQogICAg
ICB3aWZpOiBpd2x3aWZpOiBtdm06IHNldCBIRSBQSFkgYmFuZHdpZHRoIGFjY29yZGluZyB0byBi
YW5kDQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IGFkdmVydGlzZSAzMjAgTUh6IGluIDYgR0h6
IG9ubHkgY29uZGl0aW9uYWxseQ0KICAgICAgd2lmaTogaXdsd2lmaTogbnZtLXBhcnNlOiBzdXBw
b3J0IEEtTVBEVSBpbiBFSFQgMi40IEdIeg0KDQpNaXJpIEtvcmVuYmxpdCAoMSk6DQogICAgICB3
aWZpOiBpd2x3aWZpOiBtdm06IHN1cHBvcnQgUFBFIFRocmVzaG9sZHMgZm9yIEVIVA0KDQpNb3Jk
ZWNoYXkgR29vZHN0ZWluICgyKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHJzOiBhZGQgc3VwcG9y
dCBmb3IgcGFyc2luZyBtYXggTUNTIHBlciBOU1MvQlcgaW4gMTFiZQ0KICAgICAgd2lmaTogaXds
d2lmaTogbXZtOiBhZGQgc3VwcG9ydCBmb3IgRUhUIDFLIGFnZ3JlZ2F0aW9uIHNpemUNCg0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL21hYy5oICAgICAgIHwgICA2
ICsrLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9hcGkvcGh5LWN0
eHQuaCAgfCAgMzMgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3JzLmggICAgICAgIHwgIDEwICsrKy0tLS0tDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9mdy9ycy5jICAgICAgICAgICAgfCAgIDIg
KysNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1kcnYuYyAgICAgICAg
ICB8ICAgMyArKysNCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2l3bC1lZXBy
b20tcGFyc2UuaCB8ICAgMyArKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZp
L2l3bC1tb2RwYXJhbXMuaCAgICB8ICAgMSArDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwv
aXdsd2lmaS9pd2wtbnZtLXBhcnNlLmMgICAgfCAyMzUNCisrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZHJpdmVycy9uZXQvd2ly
ZWxlc3MvaW50ZWwvaXdsd2lmaS9pd2wtcHJwaC5oICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLXRyYW5zLmggICAgICAgIHwgICAxICsNCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9mdy5jICAgICAgICAgICB8ICAy
OSArKysrKysrKysrKysrKysrKystLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXds
d2lmaS9tdm0vbWFjODAyMTEuYyAgICAgfCAxODkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
LS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaCAgICAgICAg
ICB8ICAgMiArKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL29wcy5j
ICAgICAgICAgIHwgIDEzICsrKysrKysrLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9p
d2x3aWZpL212bS9waHktY3R4dC5jICAgICB8ICA1NCArKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZt
L3JzLWZ3LmMgICAgICAgIHwgMTI1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS90eC5jICAgICAgICAg
ICB8ICAxMiArKysrKysrKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL3Bj
aWUvdHJhbnMuYyAgICAgICB8ICA4NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMTggZmlsZXMgY2hhbmdlZCwgNjQ3IGlu
c2VydGlvbnMoKyksIDE1NyBkZWxldGlvbnMoLSkNCg==
