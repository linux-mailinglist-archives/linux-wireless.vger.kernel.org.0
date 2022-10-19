Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C91604800
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiJSNr5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 09:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiJSNql (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 09:46:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CB6172533
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666186336; x=1697722336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MygcRp9M1o9jRhx4TsFITH9t5nAqt0xYQMgSY+zSiBA=;
  b=jauSTQgnzFMf9Wcfdg6q8p1PiQ+C4p1BqrlC6aPXC9x4kEL/WFzzfHMP
   0m60y1SqJwJTxK10iHX4wvMIT91fBZzwS3RWTqCqNsxCeTC2Kp6ShhtuU
   bhf15zm+kSzLMlt0DAolAp2Tto+8UeD3saYo2iiExFYBr0UuZA6ev5siv
   XL01deWdOWIaAHRUmClXo+0AUV9vp2SAR5Dm+vaqMmYTHrsPLfRL161fm
   kvisTSzntjcVwuhTy6sA/roPDp/y4PzLtiQmXSMEwZGnqZdbSAsH6ICkJ
   zWbF1jiM2K33hXf5tFWi6pfRgrU16pwy3mZqZTPytqSqVPw+906AYTfK6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="304025832"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="304025832"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 06:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="698074755"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="698074755"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2022 06:31:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 06:31:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 06:31:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 06:31:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 06:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnnUEjiBIHoKQzsPD1ArvSZKBraGkeCL9h1t+nr+QqvysZg6IuLzKspTGVTBB3lV14aH4SiqwtgLtLHkclQVWERkVsCZFSkTYUQcy0vtvYtANUzEOayX2WVnTqcSHX9jjbssDeB+YUKLIlpbnC4ozZEQ7iRvnUQmNTOONQfUuVPxVwN4vkCgNXH12n6v5TrNy5KMXNK/xwVVEszzPO9B7sXebXwwxGzd+dpnhn3te5FsemAgwivguymJNUe0g+oeRYdUhl+xvv+pTTu37mx39EAy09vQ7eXRHjAlkIW0pJT0DVcTMyDtTbrh7V9XdHlC9wZT9pZ/+AnQvkfhqcPWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MygcRp9M1o9jRhx4TsFITH9t5nAqt0xYQMgSY+zSiBA=;
 b=S1Sa2sKf4r6RZf3Ja/KHWCu6ndML+40hI2SGhazBjYeziQgGD3knrBHA4cwJWzDWPA89DujeOdrSEsI712qUnO4TyBGp7mMt6G3KeYgIEewEJrJszUFmNo8V8StIeTiG4JKnFwUnB1l8WSEMk5CWEQ32+3WWJOcm1mUtnzQvtLmGQbR3MBIzz/n9Qz/f/9BGpXvF1lJRAXGt3dvmDLGlY8jjT4WYA81v0sHYKaOKh31Rqt12E8Nd7EA3Tu50erYRhd6Axk0TyBuT91N1PsPVIIC+ZW2WaBFF4GNhcZ7N158BQUKi9SMfyHTmeZ9kWUxYgrFLAPgn6A2Qm3PstGHa+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3897.namprd11.prod.outlook.com (2603:10b6:5:4::26) by
 SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 13:31:31 +0000
Received: from DM6PR11MB3897.namprd11.prod.outlook.com
 ([fe80::a9de:d820:b3b9:cc1a]) by DM6PR11MB3897.namprd11.prod.outlook.com
 ([fe80::a9de:d820:b3b9:cc1a%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 13:31:31 +0000
From:   "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To:     Wen Gong <quic_wgong@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Peer, Ilan" <ilan.peer@intel.com>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: RE: wifi: hostapd:/wpa_supplicant MLO Re: [PATCH 00/27] another set
 of MLO patches
Thread-Topic: wifi: hostapd:/wpa_supplicant MLO Re: [PATCH 00/27] another set
 of MLO patches
Thread-Index: AQHYwcdECXMEe3QNQ0ujvgfkz4HwEK3SFYGAgAm29vCALOJTMYANEhCAgAAzpPA=
Date:   Wed, 19 Oct 2022 13:31:31 +0000
Message-ID: <DM6PR11MB3897197E38455B0DA63CA23FF52B9@DM6PR11MB3897.namprd11.prod.outlook.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
 <6175bc95-201c-cfab-2ae6-9ba77e830394@quicinc.com>
 <09556b33ad998ad243cf75dbc230f3b07349a87e.camel@sipsolutions.net>
 <935ef9e9-2092-e3f0-0edd-4aa29f4fa775@quicinc.com>
 <e01e75013f71ede7b29f2751238935e7147796f2.camel@sipsolutions.net>
 <f3afceb8-8120-12c7-74b9-caa3abce5cb8@quicinc.com>
 <DM6PR11MB3897D1A4E13419D9F938F559F5449@DM6PR11MB3897.namprd11.prod.outlook.com>
 <96bcc467-c530-46de-8f91-c5eb0af7a368@quicinc.com>
 <776991f3-384e-f487-83b7-e1fbfd40cc4f@quicinc.com>
 <de54f4e0-810b-70a0-7629-39a2957ecd3d@quicinc.com>
In-Reply-To: <de54f4e0-810b-70a0-7629-39a2957ecd3d@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3897:EE_|SJ0PR11MB4912:EE_
x-ms-office365-filtering-correlation-id: 96369dd9-fdbd-41b3-6b24-08dab1d63c1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZD2WzpQTTrE8g0Blx7ze+DW6xQKJHPAbSrsbBqXcBiDkwjSVzzJK6liF2BUHuKbXFYTxZZq25Sbd/z4J2VTpDDMuIHdHNQbycWOrZ0KtXaShKhNy3l0syV5kYo/zATDphFctka/LJd8dzvHQWeaHcFnL2AHRyDKvHplVkNkvdVX2TKegCIBg0MR/VpP6a/8INRGKo2G6TqNNQVadE3C7n/evhsxdkB3a9gtH1JuVh+bHeQIPDyk4iEbo2ZlCB87V/i4DuXDJYlPFu/WBMwopzfQGBTBPrqbzmO62vCW2jbVraT/sQhobi0giysM3D0SWhbZqZ1WNog8JPm0NW0fHdtegqqz5VrCvQAUxVfh0+WNYdC3/TxXd66CylhLzTN92qoJuYCNkNq/AnYpofWgCVvNWWLr6EorCgw3chnCZ4szj9JvtVZ9xUzmtaNENL1302h3jzR3WxGT66EZKCw37b01eFiLGaUrn2Fk7UkLnpzBotwKOSUCKVcHFx/hV2YpvF3buY6Qaa1JPS2WZkUyKQwBjSuPww3g/q9t8B/18Swp9thIXwkHz5MZScHz4/s99IDy1LMjC+IcwNpbgZ2kZv8vip1dMqPRf7SwZtxSPj1nKwLCky5yxv/H3UsT33jTDtYwbCcbFJc3LZ2La0mf1K+xcjg0aX8j6PXBlcBnMdr3+vuzeTn/LGoWInNjwP7bY3V2i67I7ehw9atN+V9tl9AaayotZhByeTv+Zrtxr8xcvG6sdImvIrB3kmSO3bu//kIZ0WkS7hy6499IcJpNzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3897.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(71200400001)(5660300002)(38070700005)(82960400001)(6636002)(110136005)(186003)(316002)(4326008)(55016003)(8676002)(66946007)(33656002)(66476007)(76116006)(66446008)(64756008)(53546011)(66556008)(122000001)(41300700001)(9686003)(8936002)(478600001)(52536014)(6506007)(7696005)(86362001)(26005)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUVsbk1ENE5oZHZmMkM0REgyZDB2cC9xbm94NldyMGhTM09oNW92am9hUFQx?=
 =?utf-8?B?M2ZyZnFLRU9ZR1ZlZnhrOGZuQ0RtNXNqWEZNeGhja2YwV1BuNEZDSkYwbXhM?=
 =?utf-8?B?N0JoQWo1N01oZERRWENsOUM2QlhyR1RsbFhRZGFjZWZFTnZYcU5nWFpxTHlr?=
 =?utf-8?B?eVhNejA4WUkvZU9sWkgzYkZVY09KKy9IZ1VqR3FBVFR1VmxQTVZtcVNZSWha?=
 =?utf-8?B?WGIzYjNxb3NWMW5BMFdvNVduMS8ydzhKdXdzd3dlRUdLdWk4RXAzZFlkbTEy?=
 =?utf-8?B?VG5EdnBCYnhRZUQzczRqOHNWK2ZoZDZRWjZGQlQyeCtPaUxoWHNGTDdMeDVB?=
 =?utf-8?B?VWFGT0lYN3VJTTRPdkZMMkQzMlNqR1p5SzhuNUkxNTArQXZIYmhwci83aFdK?=
 =?utf-8?B?KzR5dUxDWDhjZzVpaGVlQ096eWNEa1ZUT2x1azRoR3JaekNlVlFhRmNMQXkr?=
 =?utf-8?B?U2xZNThrVHRwNEVoZ1ZBeS9MNHRhUnpWY3ZDR2RQeCs5NHFWN3hWTDgrZ254?=
 =?utf-8?B?NkQvQUxSY0FxL1gyVzd4aDFENUJzYU91UGV2ejFDSXFBenRNL3lIeFR4cGZI?=
 =?utf-8?B?bFI3b1dxRXhQeDc2NFFPczFKdDFDTXptWU9DQldlYjhaK3JGalFZUXh4azdI?=
 =?utf-8?B?dmhnVWhveENNY1k5NTRWM2pRVUtRdFM5cDhrdmk0NTA3K1JHNWx6ZmhMclEv?=
 =?utf-8?B?ZEd0Q1JMVWRBd2lqSnVjK3RHdy9SbWcrV3dycEdxcUNVcFErRWJIMmR5QnBW?=
 =?utf-8?B?QWRCRGpNQlJ2UWNSb01ESitxeGozbGR6T1lDcmladFZMVWNSem1vTU0vbjds?=
 =?utf-8?B?RW9aSjNwM3NFWjM2bkZBanlIOGx1QnZ5M3p0Tng4eTBsd1RuTGxIcmwzWWZj?=
 =?utf-8?B?MlJwaUY3ZVBpYksxOFNCakl5UUo0d0ZISXE1TVlRdkhuYmJMaHRIT1dad1JW?=
 =?utf-8?B?RDV0MXpNNHkzYlUyMjlnUlZQdGdaQVFrcUUrR1A3alZyZnVQeGQzTTN4L2dJ?=
 =?utf-8?B?TFhpNFlQOS8wbEV6U3NFb2tyS0FsYXo3U21HMktYZjg0WVN6ZlJzZUNibW01?=
 =?utf-8?B?MC9wVDdLM3VFd0VQbkZUZzY0SGxKc2c4RUFpYzYwc2RjZU1kREJMbWhWZ0p0?=
 =?utf-8?B?TkJ5K3FTVkVkQWJma24rTHRkT1hTTWY3NFJINHZWUkFxQXlObFBBRGROSGJ1?=
 =?utf-8?B?OW03WFZ5NEpSYWlyQ1FzUklva2N1QWRLbHB5YnNZMHZsd3ZmZit4amE4MkFP?=
 =?utf-8?B?ekVackM0UVNqNFFlcVFodXArQVEwL25ybFRZNXY2Vnd6WkcyZlJPQTYxbUI2?=
 =?utf-8?B?SXc5UzNMYS9tR2VpZzdZMlFDWGVhUFpFcEs2d1QvMFMwdzQ4NXR2a3I2ZVR5?=
 =?utf-8?B?c0FKN3N0aFQ4ZEZJRWY4bEVsdWZDTGJYaG1xVkdVTVVMbkJvaDg2WGlMQ240?=
 =?utf-8?B?NlZYNkFHb0F1VGxmMVp1TkZuRngwTExmS2tNai9VNWR1eGJxNmtJbWMxczFU?=
 =?utf-8?B?OTNzQ2N2Y2lsSXpNZFlKZlZLZHhkcVJlalVqR2ZxUERTdTdPRE9PQWY4dmEw?=
 =?utf-8?B?Q3AyTTRvOS9hZkZZRE84c2VCcENvOThRbWRQZ2IrSEhBZnN0eS81ZHU0emcv?=
 =?utf-8?B?VUVZRGRmYlYxaGRobjhONGdnaFFtRTFvN3RkWVhuMEJsVWxwRUM2RTJLRHgx?=
 =?utf-8?B?QnpuV3FkMWRzU0lLU3pROVRiYkFMeVUvWG53UjduYWRWYlFLcmpqV1JrSys1?=
 =?utf-8?B?ZXVJMkthZ2NGN1d1aUlybENVaHhnWHU5cVNrbll0eVozZ25xaWRJTWdJRzFp?=
 =?utf-8?B?d21zRlVTcmkvSGRQZGpvTGRLcWxDVXVsdSt5ek0yaWNHODJTck9DUUxsSFVv?=
 =?utf-8?B?bU41b3pnZzlodG1ab2t5UEZrN0dxaDVFZjBEYnZEdWx5V0ozNTVrU2lBa0tN?=
 =?utf-8?B?NjZhRWN1OHlkZ29SODhlRkk1RUp6eC90bFB0VjdSTjlQRVk1MFNOdGs1dXJp?=
 =?utf-8?B?dlI2RG44N1FkdXN0RzlSbS9mcXptRmo4MG9vS0xTQTRXY29samlTeEhRYnhr?=
 =?utf-8?B?VXhjZ2JBWTBxTmJZamRiYVVpa0dWWnc4Wk5nNzZXR3kvZnFxeGlDTjhYQnRn?=
 =?utf-8?B?QzNkY2U0WWJqVkx6cGpSajFHaHB3OEFKUTRZaFNlOEtkbmlHNVBmSnZDdFJR?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3897.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96369dd9-fdbd-41b3-6b24-08dab1d63c1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 13:31:31.5687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeZmmfHp7laX6wcBpjWF5YA+s7gXqGght8nnpxfTwRqk0jzLJz5uiGh3KVzkPxzB8WqEzNhKgjbX+HEZif8pCMBmAU6scSkUP249Vp0ZtPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiBIaSBJbGFuL0FuZHJlaSwNCj4gDQo+IFdpbGwgeW91IHNlbmQgeW91ciBwYXRjaGVzIG9mIHdw
YV9zdXBwbGljYW50IGZvciBNTE8gdG8gdXBzdHJlYW0/8J+YgQ0KSGksDQpZZWFoLCBzb3JyeSwg
c3RpbGwgV0lQLiBXZSd2ZSBiZWVuIG9uIGEgbG9uZyBob2xpZGF5cyBwZXJpb2QgdW50aWwgeWVz
dGVyZGF5Lg0KDQpBbmRyZWkNCj4gDQo+IE9uIDEwLzExLzIwMjIgMTA6MjggQU0sIFdlbiBHb25n
IHdyb3RlOg0KPiA+IEhpIElsYW4vQW5kcmVpLA0KPiA+DQo+ID4gV2lsbCB5b3Ugc2VuZCB5b3Vy
IHBhdGNoZXMgb2Ygd3BhX3N1cHBsaWNhbnQgdG8gdXBzdHJlYW0/8J+YgQ0KPiA+DQo+ID4gT24g
OS8yOC8yMDIyIDExOjEyIFBNLCBXZW4gR29uZyB3cm90ZToNCj4gPj4gT24gOS8xMi8yMDIyIDk6
MTcgUE0sIE90Y2hlcmV0aWFuc2tpLCBBbmRyZWkgd3JvdGU6DQo+ID4+Pj4+IFdlbGwsIE9LLCB5
b3Ugb2J2aW91c2x5IGFyZSBhZGp1c3RpbmcgdGhlIHN1cHBsaWNhbnQgdG8gd29yayB3aXRoDQo+
ID4+Pj4+IE1MTyAob3RoZXJ3aXNlIHlvdSB3b3VsZG4ndCBnZXQgYW4gTUxPIGNvbm5lY3Rpb24g
aW4gdGhlIGZpcnN0DQo+ID4+Pj4+IHBsYWNlKSwgc28geWVhaCwgdGhpcyBpcyBwYXJ0IG9mIHRo
ZSBhZGp1c3RtZW50cyBuZWVkZWQuDQo+ID4+Pj4+DQo+ID4+Pj4+IElsYW4vQW5kcmVpIGhhdmUg
YWxsIG9mIHRoaXMgd29ya2luZywgbWF5YmUgd2UgY2FuIHNoYXJlIHRoZQ0KPiA+Pj4+PiBwYXRj
aGVzIGV2ZW4gYmVmb3JlIHJlYmFzZSBldGMuDQo+ID4+PiBIaSwNCj4gPj4+IE91ciBpbXBsZW1l
bnRhdGlvbiBpcyBiYXNlZCBvbiBvdXIgaW50ZXJuYWwgdHJlZSwgc28gaXQgd2lsbCB0YWtlDQo+
ID4+PiBzb21lIHRpbWUgdG8gY2xlYW51cCBhbmQgcG9ydCBpdCBmb3IgdXBzdHJlYW0uDQo+ID4+
PiBIb3BlZnVsbHkgSSB3aWxsIGhhdmUgc29tZSB0aW1lIHRvIHdvcmsgb24gaXQgdGhpcyBhbmQg
bmV4dCB3ZWVrIGFuZA0KPiA+Pj4gbWF5YmUgd2Ugd2lsbCBiZSBhYmxlIHRvIHNoYXJlIHNvbWV0
aGluZyBpbml0aWFsLg0KPiA+PiBNYXkgSSBnZXQgeW91ciBwYXRjaGVzPw0KPiA+Pj4NCj4gPj4+
IEFuZHJlaQ0KPiA+Pj4+PiBqb2hhbm5lcw0KPiA+Pj4+IFRoYW5rcy4NCj4gPj4+Pg0KPiA+Pj4+
IEl0IGlzIGdvb2QgdG8gc2hhcmUgbWUgdGhlIHdwYV9zdXBwbGljYW50IHBhdGNoZXMgQVNBUC4N
Cj4gPj4+Pg0KPiA+Pj4+IEFuZCBJIGhhdmUgYW5vdGhlciBxdWVzdGlvbjoNCj4gPj4+Pg0KPiA+
Pj4+IFdoZW4gbWFjODAyMTEgdXNlIHRoZSBNTEQgYWRkciBpbiBhdXRoZW50aWNhdGlvbi9hc3Nv
YyByZXF1ZXN0LA0KPiA+Pj4+DQo+ID4+Pj4gZmluYWxseSwgaXQgc2hvdWxkIGJlIHJlcGxhY2Vk
IHdpdGggb25lIGxpbmsncyBhZGRyZXNzIGluIGFpciBwb3J0LA0KPiA+Pj4+IHJpZ2h0Pw0KPiA+
Pj4+DQo+ID4+Pj4gSXQgbWVhbnMgdGhlIE1MRCBhZGRyIHdpbGwgbmV2ZXIgZXhpc3QgaW4gbWFj
ODAyMTEgaGVhZGVyIG9mIHBhY2tldA0KPiA+Pj4+IGluIHRoZSBhaXIgcG9ydCwgcmlnaHQ/DQo=
