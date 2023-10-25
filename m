Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF397D6636
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjJYJGe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJYJGb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 05:06:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9683B3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698224785; x=1729760785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=QaVAG6Be6za8Wl8DpLd+NZvCbO6xyZAtWVSBxnCsRM0=;
  b=Kn7fPp4spCsFNCdQdABCGHIRMDZjmzlVH+EVxEvuLhQ9C0Fp60BUsaW4
   6VGnjjjjB/AQ9xgQzYhb1QEBzVawqcPL3tpUAYZM1alyrDP15HJrN9Nua
   +sGl8avPYGCvUIbf7wDhPoqwZBw8Y38nsqY77Pm/7ZWATYB+G9f0NwaxU
   fm1H0xNbMI4VwuL2ON7Y4qGwNpg6KsBxq6jhWz9dLN/Y4tSj8BeFLuUdx
   a/I6aWRGQkx8/8ak+26z/QICOGey8dgJPxfYCb+BP+gEjxh0kT4HXD5m/
   ZS7BMoZeXIyRr+QYkdJbLH3x8Kl18rBQ5JUCnlxrSsYR/iwVqHk7oNehI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="367482570"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="367482570"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="793793162"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="793793162"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 02:06:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 02:06:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 02:06:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 02:06:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 02:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clBslVH+gmxywatseELMCqUS54YNnvElvQvnbAmTUIvaNy63aA5G16U26FFUD/A60a8UdYl1LHbrxPpd0WhG9SZNX9jmTteGG0HAcBR0XlQIHrGJ9fetQVcWQgur/pi+SN5epSz7fel3YnghGOUwrU/xeDTltdkdXNG+hQukaSdZaANJ0wZxo3a3Mu1m6getdtAZhQxUS+lerTOn6e/NmvR8lFPtxpmVh4JFjRL10skyJVyHNl0ZJdW7pkdhYqgpJnQl6nJ/o5AkxRb9STq8h2gr+bXVVjfO3G9MU7MJx7ka7ZTRUEWBkt0DfZ2jQ36g7xa8gjZ8xWL1cMiw+zDx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udw4ld1Q2yfvIdXtX4sU7BytfRLh4yXce+V/Ac7Ue/Q=;
 b=COggnwnz0wc91WmWJNtCB8Hd5kcdR5cVa6H7FUK8rbzbOBLRyJZbt10snJn2N0AVlPsgIMjt1xVfc+k/MZhRpC6vVAY9uCecCTSyeTbK49O6jR7Sk7W9mJlwbz3qleadnrI/GLuv2pz6w0n1Gek1iIIv06JtM50x6ONQM+Ds6kKWMdY2Gdnk+zwn3Qr1sn9KrX+0y0qLKghf46LdoG5PfI+jANvT4MKluAZPJKitfxCa8IysK9rvm/lZY2rrLZsihCqPF9/CCqiAWm1HpP/f006qlaGkQt/Ns+K20wWhxUxbIWs4UKQXCviTgnniFE4Skb0CZaQgy6AhVORblWqfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 09:06:20 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::35a6:148a:9c70:cfe6]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::35a6:148a:9c70:cfe6%6]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 09:06:20 +0000
From:   "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [bug report] wifi: iwlwifi: support link_id in SESSION_PROTECTION
 cmd
Thread-Topic: [bug report] wifi: iwlwifi: support link_id in
 SESSION_PROTECTION cmd
Thread-Index: AQHaBw+zFVlDZ0H+00mBVlgAsOSINrBaNrjw
Date:   Wed, 25 Oct 2023 09:06:20 +0000
Message-ID: <MW5PR11MB58108BEC14B722B258026391A3DEA@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <5f5db316-3229-4fc2-81d8-3463b5b83d40@moroto.mountain>
In-Reply-To: <5f5db316-3229-4fc2-81d8-3463b5b83d40@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|LV8PR11MB8722:EE_
x-ms-office365-filtering-correlation-id: 52707f2b-e252-42a7-740b-08dbd539a7b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WhWza4JSFVlMpaXyNUSnX2q39AlEKxrg/toqQXHALIQRYKh5h4VvSECiIaxKmETU2jpzUVqz3cKHtxjrW4SKsJdb4k6e0SNhEhYjA1N3KgZbKtIJPQ0U5oM7cuzFMMxhXjNlxZHFrkz7ez9l14GvTUDyLB1wzYR8GEkCew86oRbsyQJSmBWix0gF55tITL81dUmk1F41H2/eXO/n2R0bn8HGQ60Mn2YD+YisDq90HrzVvplIbrsl4rNIEwBpvWhwj+0mQJ9yDglvEYSZsTssv3UaSqXnJNPKjLtzwuPNAMvRV1v9qPjTuAQbxtWwvvK+5Vx7x2rDcseGriSgYZZSlwgpVhhSDb7F9QoxVFlS8dO2fBFmTbHO5wXXr0l/FtPzI0sBgo6A5+307nhBcyStXCEDOu9Z4mTgSCODoMJYaseF1RAhpZ9nVkP+4cz10Ko6fClVF5rM015WroaUN84uBOTX7i3Yaw73HaCtiJnaKA+wU/RbnuOu4n6KBl0BEbt3QWte9vWuBEu7KN7H+Kw1TjZ3/SyAAQiR8NL0smWCeUPM9efYVuFu26TfmMb5hpVecvaDT+bD7YY3QqNxnHAjDQV902O5/lE+pjdGjgPrjYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(55016003)(2906002)(86362001)(38100700002)(41300700001)(6916009)(76116006)(122000001)(66476007)(66446008)(66556008)(64756008)(316002)(82960400001)(6506007)(7696005)(478600001)(71200400001)(9686003)(53546011)(83380400001)(52536014)(5660300002)(33656002)(4326008)(8676002)(8936002)(66946007)(38070700009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmVXMll3cmV3dlBuVkJLbW00K0YvTXc0N2Z5Y3lQNHIwUHFWNlV3TnRBRG50?=
 =?utf-8?B?V0lsTkNUYUNZbG0vOW1aM0hSd3NsMkttbi8rYnRnTUxTZDNNdWRnUC9mSjNJ?=
 =?utf-8?B?T2VOdGVqZEJXQkxWT29FT1RHUUYvczQ2QmZWQzB0Z1RUSFBxTk5CTnZGNXdm?=
 =?utf-8?B?NVBUaEJIMkkxRjdLd3hWVmFLRnVZUWtLM0Z4aWVrVWNDQkFxdnFPSmRraTcy?=
 =?utf-8?B?SkFQemZsSHFxZm51NlFJT1FQTTV1ZHBQNWJ2SXdEYkt2VlJmMUc5b0NQSHBZ?=
 =?utf-8?B?WmZaeGU1cVZMSzk2cms5WEdIRFM4bzNDeXJNajN2bTFvbmVGTmFmUC9lTThU?=
 =?utf-8?B?bDJ1Qy9UR21TaSswN0ljVXU2MEZjWFRLMGRueTlkTEdTRzVUdHRyTGZUajFX?=
 =?utf-8?B?UFhqay9kOC9xZ2V0Z0FiRll1Z0FGR0xXdnVpemFhdE9UeEwweTRkb3Fza0FF?=
 =?utf-8?B?RzhGL09mWjFoUEhXbWNOekJySFpSRW9hSlc5NUhKY2pTc3JPQ0VBUHpBSkhN?=
 =?utf-8?B?NFVvaTl2QklrcXYwdVcyRzhxYUc1amNibHRjUzJ1RG9qTElZRzR5QzZHY2RO?=
 =?utf-8?B?L0liUGU0bTltMlEyZWFtaWM0S1ZHZSt6YnJmd3dtTmswQ1JPNUV1OTRrZHJM?=
 =?utf-8?B?QkNqU2FZRXhtWmJDcndWRVkya1NnZUViZWhzdVpULytwUHliRGxmc3lybmt6?=
 =?utf-8?B?bGhFNkNXOXVhVnpDY1N4SUFBRUI0VFcrcmNldkh2dDNXZWIzZ1VLY1Y2UEFs?=
 =?utf-8?B?amE1VW02WTE3eWNsbWUzTGFwU1JSVmRId21Yc1d6MjAvSUJYUmdrRlBERDJp?=
 =?utf-8?B?Zkp0bTJRK3J6c3NYZTV5YVh3LzBKU09uaExla05nM2JPVk1IblRTYksvZTA1?=
 =?utf-8?B?elN2SW9DU3d1MUNlS3A1c0hsdWFrZmh2dGJPajdZNlNhWWhxTnp1RjA5YTJX?=
 =?utf-8?B?U1ZFTVB4TlMwazNjb3Z2czU5SmF1K05qVDk5ekZZMjg1Y3VxNWQ0V01QamJW?=
 =?utf-8?B?NzF4elgrdFhDWEpheGFMM3FqWXU1TzRDRGZKT0liMDlaYUJ5T25HeHc3Tkp3?=
 =?utf-8?B?Zk5KdnoxcDYvYzJxajFRQWcvTVN6Q2ppRS9Eb01IWVZUVE5sN050QmttQkF5?=
 =?utf-8?B?NTFUVU53TzkrNjUvRUwxa0grL29nRDBlWXZUWFRzcldWcVU3RDYwditiSGE5?=
 =?utf-8?B?SXMzTkZROTFtT1RIZFZiT2YvUjB6V3gxSEhDWnBONFRSSVROMVVKb3RVaTkv?=
 =?utf-8?B?elZSUlRJK216Qkk4TTZyKzRGS0xQWmc3ZGwzQUhvOGExaU56YkZzQkk3RHhQ?=
 =?utf-8?B?L1JqYzk3RnhyNDV5amZxdkxoNHMybE9SdTZzWXFvdGkzRm85MDUzemVDVnFy?=
 =?utf-8?B?UEJEb0hIMUYyangyVHhjK0NxRHlIcGxyVWIvOUJGVm4yZ0FBLzlVK3hUcGNw?=
 =?utf-8?B?eHVhcGdEQmdNdDdWS1lyR3ZZM0dkRGtsTmJrbDlBR2Vvb3FiNWZkZ3plK1lp?=
 =?utf-8?B?RG5vd1VsMkMrUzdMYmVUWUZISUQvZGFWaEg0aEVaMDBtSHpqdlZwaDF6czJz?=
 =?utf-8?B?Q2I3WFQ4L3Z5UHZGQWovZmtWNkdGLzliVXBTS2dJZUdzSE5IY3YrcEtHYytj?=
 =?utf-8?B?SjdQbkpLZmdLS2crZlZ6ZTNZN09zM0p4VEVXbUlWOWU2NDB2bkZDMDMzMjZw?=
 =?utf-8?B?SjFqeTJGZDNsMFdURnRlaWtZNGlRZEI4WHVqR3Iyc3NVWmFOa3hUc0s2d0JO?=
 =?utf-8?B?S2FIYngwclQ4RnlwZWF5V1FBR1NPbWFpeHpNTHp6Qjhqbm9RKzgwMlFtK2x3?=
 =?utf-8?B?a1RnS3QvRCs1Y1J0MGdUK09FbzB5dlhhaktFWHJUNDZwMFVnNkRqTlpyK1NN?=
 =?utf-8?B?b1VvdHkvRHhEckY1czJSMTRRQnJKUDhmOG9EaHU2emdkb3h1YjByR3IrdThu?=
 =?utf-8?B?azQxRjlsR2ozV3BZUWk0UzF5b3hzckFOSDVad2NCenBDRHVmM2tudTR4ejRn?=
 =?utf-8?B?MzJVeW5VQUEyNXFkTFd2Vit2eHg0bXZQUFFPeE9XY3hwTVdRd3ZrMU9TcEhh?=
 =?utf-8?B?dFRnRlVpMHhrdDFUbnhrV0JKZFpaemlkUzMwNElGTkQ5eUpVejhpK291U3pR?=
 =?utf-8?B?cmJEUzN4dWFMSkVTckw3a0tVajdCSTR2c3VBNzNrWWJTemMrNUswdE41eWNG?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52707f2b-e252-42a7-740b-08dbd539a7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 09:06:20.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vyonTTpE6PUbrlnlIZDLIwYOSKvCiMLVe92NvIBjSTQiNswc0QLBZCiptAWmpLiWwowB88WQAPAMzUvJnV/DmPw9P3OV8b/HTjhwwgnzCYpRLQjgTi79Y//ecqBJIWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgRGFuIPCfmIoNCg0KVGhhbmtzIGZvciB0aGUgdXBkYXRlLA0KSSdsbCBmaXggaXQNCg0KVGhh
bmtzLA0KTWlyaQ0KDQpNaXJpIEtvcmVuYmxpdCB8IENDRyB8IFdDUyB8IFdDRA0KT2ZmaWNlOiAr
OTcyIDIgNTg5LTc3MjQgfCBDZWxsIFBob25lOiArOTcyIDU0IDg0NiAzODAzDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxp
bmFyby5vcmc+IA0KU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDI1LCAyMDIzIDA5OjUxDQpUbzog
S29yZW5ibGl0LCBNaXJpYW0gUmFjaGVsIDxtaXJpYW0ucmFjaGVsLmtvcmVuYmxpdEBpbnRlbC5j
b20+DQpDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBbYnVnIHJl
cG9ydF0gd2lmaTogaXdsd2lmaTogc3VwcG9ydCBsaW5rX2lkIGluIFNFU1NJT05fUFJPVEVDVElP
TiBjbWQNCg0KSGVsbG8gTWlyaSBLb3JlbmJsaXQsDQoNClRoZSBwYXRjaCAxMzUwNjU4MzczMTA6
ICJ3aWZpOiBpd2x3aWZpOiBzdXBwb3J0IGxpbmtfaWQgaW4gU0VTU0lPTl9QUk9URUNUSU9OIGNt
ZCIgZnJvbSBPY3QgMTcsIDIwMjMgKGxpbnV4LW5leHQpLCBsZWFkcyB0byB0aGUgZm9sbG93aW5n
IFNtYXRjaCBzdGF0aWMgY2hlY2tlciB3YXJuaW5nOg0KDQoJZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9tdm0vdGltZS1ldmVudC5jOjcwNSBpd2xfbXZtX2dldF9zZXNzaW9uX3By
b3RfaWQoKQ0KCXdhcm46IHVuc2lnbmVkICdsaW5rX2lkJyBpcyBuZXZlciBsZXNzIHRoYW4gemVy
by4NCg0KZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vdGltZS1ldmVudC5j
DQogICAgNjkzIHN0YXRpYyBpbnQgaXdsX212bV9nZXRfc2Vzc2lvbl9wcm90X2lkKHN0cnVjdCBp
d2xfbXZtICptdm0sDQogICAgNjk0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQogICAgNjk1ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHUzMiBsaW5rX2lkKQ0KICAgIDY5NiB7DQogICAgNjk3ICAg
ICAgICAgc3RydWN0IGl3bF9tdm1fdmlmICptdm12aWYgPSBpd2xfbXZtX3ZpZl9mcm9tX21hYzgw
MjExKHZpZik7DQogICAgNjk4ICAgICAgICAgaW50IHZlciA9IGl3bF9md19sb29rdXBfY21kX3Zl
cihtdm0tPmZ3LA0KICAgIDY5OSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgV0lERV9JRChNQUNfQ09ORl9HUk9VUCwNCiAgICA3MDAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgU0VTU0lPTl9QUk9URUNUSU9OX0NNRCksIDEpOw0K
ICAgIDcwMSANCiAgICA3MDIgICAgICAgICBpZiAodmVyIDwgMikNCiAgICA3MDMgICAgICAgICAg
ICAgICAgIHJldHVybiBtdm12aWYtPmlkOw0KICAgIDcwNCANCi0tPiA3MDUgICAgICAgICBpZiAo
V0FSTihsaW5rX2lkIDwgMCB8fCAhbXZtdmlmLT5saW5rW2xpbmtfaWRdLA0KDQpsaW5rX2lkIGNh
bid0IGJlIGxlc3MgdGhhbiB6ZXJvLiAgQnV0IHRoZSBidWdzIGFyZSBkZWVwZXIgdGhhbiB0aGF0
Lg0KSW4gaXdsX212bV90ZV9jbGVhcl9kYXRhKCkgd2Ugc2V0Og0KDQoJdGVfZGF0YS0+bGlua19p
ZCA9IC0xOw0KDQpCdXQgaGVyZSBsaW5rX2lkIGlzIGFuIHU4IHNvIHJlYWxseSB3ZSdyZSBzZXR0
aW5nIGl0IHRvIDI1NSBpbnN0ZWFkIG9mIC0xLiAgU28gdGhhdCBtZWFucyB0aGF0IHRoZSBtdm12
aWYtPmxpbmtbbGlua19pZF0gaXMgYW4gb3V0IG9mIGJvdW5kcyBhY2Nlc3MuDQoNCkFuZCBnZW5l
cmFsbHkgSSBrbm93IGZyb20gdGhlIHR5cGUgdGhhdCBsaW5rX2lkIGlzIDAtMjU1IGJ1dCBpZiBp
dCdzIG1vcmUgdGhhbiAxNSB0aGVuIGl0J3MgYW4gb3V0IG9mIGJvdW5kcyBhY2Nlc3MuICBJIGNv
dWxkbid0IGZpZ3VyZSBvdXQgZXhhY3RseSB3aGVyZSB0aGlzIGlzIHNldCBzbyBpdCdzIGhhcmQg
dG8gdGVsbCBpZiB0aGVyZSBhcmUgb3RoZXIgb3V0IG9mIGJvdW5kcyBhY2Nlc3NlcyBhcyB3ZWxs
Lg0KDQogICAgNzA2ICAgICAgICAgICAgICAgICAgIkludmFsaWQgbGluayBJRCBmb3Igc2Vzc2lv
biBwcm90ZWN0aW9uOiAldVxuIiwgbGlua19pZCkpDQogICAgNzA3ICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCiAgICA3MDggDQogICAgNzA5ICAgICAgICAgaWYgKFdBUk4oaWVlZTgw
MjExX3ZpZl9pc19tbGQodmlmKSAmJg0KICAgIDcxMCAgICAgICAgICAgICAgICAgICEodmlmLT5h
Y3RpdmVfbGlua3MgJiBCSVQobGlua19pZCkpLA0KICAgIDcxMSAgICAgICAgICAgICAgICAgICJT
ZXNzaW9uIFByb3RlY3Rpb24gb24gYW4gaW5hY3RpdmUgbGluazogJXVcbiIsIGxpbmtfaWQpKQ0K
ICAgIDcxMiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQogICAgNzEzIA0KICAgIDcx
NCAgICAgICAgIHJldHVybiBtdm12aWYtPmxpbmtbbGlua19pZF0tPmZ3X2xpbmtfaWQ7DQogICAg
NzE1IH0NCg0KcmVnYXJkcywNCmRhbiBjYXJwZW50ZXINCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBIG1lbWJlciBv
ZiB0aGUgSW50ZWwgQ29ycG9yYXRpb24gZ3JvdXAgb2YgY29tcGFuaWVzCgpUaGlzIGUtbWFpbCBh
bmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IK
dGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEFueSByZXZpZXcgb3Ig
ZGlzdHJpYnV0aW9uCmJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQKcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFu
ZCBkZWxldGUgYWxsIGNvcGllcy4K

