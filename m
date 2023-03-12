Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F626B6BC4
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Mar 2023 22:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCLV1x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Mar 2023 17:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjCLV1v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Mar 2023 17:27:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544EE360BA
        for <linux-wireless@vger.kernel.org>; Sun, 12 Mar 2023 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678656470; x=1710192470;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=xl7XELVVxZ2B4M3jpxWLqPJiz2I3ep0JLl50YczGcao=;
  b=PuoTboWiSsqMw4gADYmy9D25rM0/x1j/u6IY+sVHVeFwJbAVNa9QPZLQ
   MYMaMvKnOFAjUybIByjsPqTMYw1ZBXmBNL1/8/kdyZdgq6tS3gK3u0975
   c2IzsaDNYmJJ8nTftq8Rr/O/ojSzGznoeRR+iRcKZ4z38TCjR4HICsvfo
   fsnkkJzvlmpOzxOLEmy6geITu1KCIDBpLfj5SkGSxGVOt0TeuWuWAGqS4
   8ZpqmcAUkz7nzrydax8Q7lbXBNKE6uAzRKxz49854jhapaQJjomsX8SXN
   Peag31hklJI4ofHTHcsO+IPfITVPWnh1ckGFJFkZuNX4WgHnnBRYv2gGi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="401891120"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="401891120"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 14:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="924282036"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="924282036"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 12 Mar 2023 14:27:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 14:27:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 14:27:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 14:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2iA9B+n9IfgAvPgzpQuZ6wDW72r1ewzub3NjKo8qpKF/y9ov8jN44J12ZnHvBrYN4vTectr/OPwHIkQHIqYNihdFL+VuAVGfJV5RyDxWfOaPO0R56W9dPEH5S+kaLJAvn/RZhqy91RMVPtTy0jmwAQ40R/ul9GLUVoNqxtp4olyyQIMSIhfxc+HYhTI0WNWDqfqmBIfQLVZ/lwRDQ3bNxpQlE1RGPqGd3NB7BiCfmA3N7mLTmYof+OdqcYHPXuY4LBRmD15Vi8whiibkZAfpUEQPJETTg5jfxO8ypVFhx6phMq6oofWwoBuk+z4QCPCoR5WmQffwrEXkREl5oZlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl7XELVVxZ2B4M3jpxWLqPJiz2I3ep0JLl50YczGcao=;
 b=YYNC8LriylaWwO2LePWrdj8rPzZuW/VMh2JzVKn63h58VQ7ijHKT3U9RiUfq/RmZSU+KA7dxrTkMsBKWnkHPI8/FnAtoF2IZbcRbmoLAhUdh67GgzBMA1+qkI4lZxYHoJAfXZ8Z/6Nd28SInDD4QkB23hJm7aBv2isXxMkzht04gadfQfyxD2p6agPLyLt46FwutH/Ks1DlrChqHRUP19XegeHc+XH3UPtIxkzr0N20ScShc+V56jQZ/LrluPy9Jf9xqLv09dz69YGhH8SQQY8/G03lKobp2BvLdGGBtNzgrBIahktQUyNrqiiYl1Eze15f5XWqxmbU1AeJkCmtfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CH3PR11MB8095.namprd11.prod.outlook.com (2603:10b6:610:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sun, 12 Mar
 2023 21:27:45 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::4bd3:d6f5:8a5f:5330%6]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 21:27:45 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: pull request: iwlwifi firmware updates 2023-03-12
Thread-Topic: pull request: iwlwifi firmware updates 2023-03-12
Thread-Index: AQHZVSl767DbHG4i20e4eGzZCTpH9Q==
Date:   Sun, 12 Mar 2023 21:27:44 +0000
Message-ID: <7bbfe98e9651fc962d3133ff70aa8bf92706f196.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CH3PR11MB8095:EE_
x-ms-office365-filtering-correlation-id: 38e37db4-dfe7-4fa2-eac4-08db23409e5a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQSb6p78d5wppwPZXf1SxTDJUhynXevIm9TfPBXBQ5nTYJ/kLeqid5bUcncevHNUTEmMyN5xw9FIWVungxkYmmL7ISBTELZNDF9yq0cIkOIm2TEXkmo9oC42GgIZGYwLW8AIk+D34O2DxHy+9TyBauNSeFemnEwg5hXOrmPz6s3SGUAHpGdJFEmTDNHTtUwn/rrdCQ7TiYL7J+DpCZl9HjT9HU4D1siFa4QRdO2hIcLQCVyYW92Ki7yhXFPjd5XzxagvphBypC5g87u0aDHF/HFOtcuc1lim6uSPFO43zEI12o174jeqXifpsIxpH5TLiEA+u94XaFT56Gbx178ovetyh8ylGsFXEQRHW3idGAhaMMPjEpVE5i7NdnWjgnFyzD4g7rfNn0URWIa8b4FNtRVkSI3/VYCuK+kW/Xc7ul+nMRC44qzPTvMFTWx6gz3ieqgtLiLmTo45+p25e/ZqQmIHr9kFK1Aj6vlWpd7ZBS62LVAcfIJ/TzwMDrH+3PYdSW6vaLETIObywOBEGG5sZeFg146j1Jo8mmTIBCEK15fMPs2Pqc5dAZfnf0rs0gXeRItlPvy2Fi+XvAGgvSVI13pk943d8qQMFaaUc6fbTCCNV170J3JrT+dffS1VqQwtahL/kZRJdfjpyO0Q2FUyxNPfrATJsfjOt8wi2osGckYfB2nn9tR+jLzslpKbduo3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199018)(2906002)(15650500001)(122000001)(82960400001)(41300700001)(83380400001)(5660300002)(36756003)(54906003)(66476007)(64756008)(66556008)(66446008)(8936002)(76116006)(8676002)(4326008)(38070700005)(66946007)(6916009)(91956017)(38100700002)(86362001)(316002)(186003)(478600001)(71200400001)(6506007)(26005)(966005)(6512007)(2616005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG80LzJjc2FhTjFTTHVTNUw0bXFrU0ZtaFd3TjI5SlBObTdKVmdrL0V6VmQ5?=
 =?utf-8?B?VlhNL2FZL2JMbXRrZ1Ayb1BubXRHcnBTOU1zUTI0akRTQ0VSWDBTbXRTaVEr?=
 =?utf-8?B?a3FmekZoSGwxalAreU9kT2RwbHh2L2l6MnlBcEF1UFM0cy9KY1VBeGVtWmIx?=
 =?utf-8?B?SHJQM3o1azFPSjhZZTQrT2dLbzkxeXRuaEZOLzdiaUZrRFJnamgwbFY5M0Vj?=
 =?utf-8?B?TGUrQjZubGdTODB3Yk5DTFpRZFlvRDd1bkIvaDlwbyt0UE5vRm4rMHZaZ2ow?=
 =?utf-8?B?OXZYZTB1NldRL2JnalFqWk5FSmM1WGd3MzlIUWpqOWtFNU5SVlRVQlRZWW1q?=
 =?utf-8?B?Z0Q4WjhBNlBYQzlWTW5ybDJPVTdjWnB6Z3JnQVlaUS9EeVdCMGJGWjN3NE02?=
 =?utf-8?B?QUJBQWlGa1ZrTUt4ZzlYUy9TcHJveitnemh5dkRRRVVCczc0cmJRaEZQbnJ5?=
 =?utf-8?B?Z1VqS2U3ZndZaDdSU3ViYVk2QnpFd05iaEJ4RXJUQUtxbG5vS2l0ck4remg5?=
 =?utf-8?B?TXZJajJYQTIzVW9MOVB1SURZNHlGMWdmV0s2YkpJTDlzd05zRDhMT0NzZ0J1?=
 =?utf-8?B?dEpHRFhKc0VPaWlYTGszK0NYQi80b0VCcHBId3BTVW1rUkZ3MUJRQmkzbUFO?=
 =?utf-8?B?Rm9TSlV0ckxwd3lBOE8vaW5ySk16RGpiTjdEQUtwc015akpmV1NzYk5XSGVU?=
 =?utf-8?B?TWljZFJLRGpjYXVYY29nRGxFZlpZQ2lWYkF0Tmhwc0ZmL0JlRm1rUWJKZ0hz?=
 =?utf-8?B?anQrUTN5VWg1SGR6UEdEaGcweUhNY0lxTGhkNjlnUXQwVUV2OG55T3I1NVNQ?=
 =?utf-8?B?Mnh1MkJDd3J4ZDM4ZWx2c0dnTkFrbEp3Rmt1UzVsZXI4dklJeXREaWdyWW1H?=
 =?utf-8?B?OG1YOFBMOHV4NVZTRFVVdUo5YlhOT05oRkRpZTBGSG5aK0Rtcm04Ukl6Q2JQ?=
 =?utf-8?B?TU1YNmI4ay83S0dnNlMvVi9WaFZMMnZCY3RmYUpqS2ZpU1RSRWZIWkk0YmxT?=
 =?utf-8?B?SXNYckdTZ2hCVXhuMXorQnd2cGJ0MmhWTW1uZnQ5K3p4bWh5VVJrZ1NFTVBt?=
 =?utf-8?B?cVphdy9FemhSaXhnVUVnak13MGJpcWFzeXlCdTd5Q0s5RXQyMDFXTXIxNmNy?=
 =?utf-8?B?TE0rWDM2U29sVFMrSlJyN1cyZzBrWm5tN1BXcWlETzBjNWVQUURKSDk1bHFz?=
 =?utf-8?B?aHppQzdFVVlGN3oxYTdDRWtKL2dFMC9rbjJGcytxbVFUOEF4NFliNGUzWDJh?=
 =?utf-8?B?SVRPY1ZWYzJLc0ovM2lHVmN3N09ueTZ2dHFnYzQzQnNUQVQ2ZTYzc2lYKy9m?=
 =?utf-8?B?ZHgyZmJTQmZESExPRFo0aDB1bnF2TzAzOGprNm16TjRTRVUvTXZGbXIwWks2?=
 =?utf-8?B?ZmFiTmEvU3R5T1dDR0JVaXB2N3BXUHA3cVhuekMzc1lROVpsNXo0ZDFuS0kr?=
 =?utf-8?B?cVUxaTBnTVdoS21YeHBYejVENHpRcHRHRGNwVk1IVWZCMjZUanNmVGZZWnIx?=
 =?utf-8?B?VG1XdVlMbVdxbDArMFlEaWZ5cFMybUdYVnZuQmZOamJJUnVxWXA0MmhqUVZ5?=
 =?utf-8?B?Z01KempVMmRoRkkwbnVmVnM3amlSU09QTGIzTGZrVldpSnVZMjhOUlUvV3FW?=
 =?utf-8?B?YzJuNTRNaU9zWmdPZGk0TlV1N0piZ1RiRnl5ZEQ3WFpidytmNzRaVGptd1dI?=
 =?utf-8?B?TXEwclppUUpJQ0c3MjdRSW45K1ZTTU9xeDZtQXAvQXpHb2haUk9BMFVXcjJx?=
 =?utf-8?B?M09keDhWaldhNzlFL3JGcmhvK0RJTnhZQjBuMS9Ick1kdE1NZlE5bjdPM3Ry?=
 =?utf-8?B?K2pqS1BhM1FubHdmaExEaitUZDJMNXRRelFMenIrelRKU0JrWmMrRkxuS2Ir?=
 =?utf-8?B?S28rRUdxNXdiTVRlTVVkYXpWUDVZM29ZUWRTaWxWVk4xb0xFak9Ba0RQczdN?=
 =?utf-8?B?ejJjZ1FrRzZMOHgrbjhjZ1Rpdnh4ZW5mQTQrK2F6OHlCVFRmOERBNHA4UnVX?=
 =?utf-8?B?NVpYMW5sdlVUbUlUVzJENUZJbEs4UUlkMzNFOFZsbGM4aGNmb2xNd0VvRGZt?=
 =?utf-8?B?L05jRHk1N25TOVZuTUFWMnJ1amw2M0t5b0NTU25mVnNSdzZGRU9KUzcrMTkw?=
 =?utf-8?B?dWFCY0ZBckhGZTYxdjVBNTJOaTdaWDZFVWY5S3V3RTVhaEE4N0dkSHQ1OFBI?=
 =?utf-8?Q?lV2ualDXCv0Mj0mXpXBmvLM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F89C879F240904485EA612D46D2456B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e37db4-dfe7-4fa2-eac4-08db23409e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2023 21:27:44.4069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JofeCeTkQYydydYOUbLjjttR9xerXBasR2if0BPa8dCW2iHVcA+DLmV61Pi/ku1/5tBH1tXN3AvC96+zLZz+FXqxyHA7ayPop5YS7poAeN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClRoaXMgY29udGFpbnMgdXBkYXRlZCBmaXJtd2FyZXMgZm9yIFNvIGRldmljZSBmb3Ig
b3VyIGN1cnJlbnRseSBtYWludGFpbmVkIEZXIGJpbmFyaWVzLg0KDQpQbGVhc2UgcHVsbCBvciBs
ZXQgbWUga25vdyBpZiB0aGVyZSBhcmUgYW55IGlzc3Vlcy4NCg0KVGhhbmtzLA0KR3JlZ29yeQ0K
DQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDU4OGRkMDcxMzRkYWY0YjBmNmY3
NDY5OGYyNGVlYjc0ZWJlOTAwMTI6DQoNCiAgcWF0OiB1cGRhdGUgbGljZW5jZSB0ZXh0ICgyMDIz
LTAzLTEwIDA3OjQwOjI1IC0wNTAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L2l3bHdpZmkvbGludXgtZmlybXdhcmUuZ2l0IHRhZ3MvaXdsd2lmaS1mdy0yMDIzLTAzLTEy
DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBiNDU4YmVhYWIyNWFlNmNjN2E2MGRm
NjY5MjY3NjhiYzIwOTAyM2EzOg0KDQogIGl3bHdpZmk6IHVwZGF0ZSBjb3JlNjkgYW5kIGNvcmU3
MiBmaXJtd2FyZXMgZm9yIFNvIGRldmljZSAoMjAyMy0wMy0xMiAyMzoxNjo1MyArMDIwMCkNCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KRmlybXdhcmUgZml4ZXMgZm9yIGNvcmU2OSBhbmQgY29yZTcyDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CkdyZWdvcnkgR3JlZW5tYW4gKDEpOg0KICAgICAgaXdsd2lmaTogdXBkYXRlIGNvcmU2OSBhbmQg
Y29yZTcyIGZpcm13YXJlcyBmb3IgU28gZGV2aWNlDQoNCiBXSEVOQ0UgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgNiArKystLS0NCiBpd2x3aWZpLXNvLWEwLWdmLWEwLTcyLnVjb2RlICB8IEJp
biAxNTYwNTMyIC0+IDE1NjA1MzIgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmNC1hMC03Mi51Y29k
ZSB8IEJpbiAxNTgwOTAwIC0+IDE1ODA5MDAgYnl0ZXMNCiBpd2x3aWZpLXNvLWEwLWdmNC1hMC03
NC51Y29kZSB8IEJpbiAxNjAyMDY4IC0+IDE2MDIwNjggYnl0ZXMNCiA0IGZpbGVzIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0K
