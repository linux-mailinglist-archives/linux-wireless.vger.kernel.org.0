Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41FD54546D
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jun 2022 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345514AbiFISvm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jun 2022 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241494AbiFISvl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jun 2022 14:51:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9300F2B2B80
        for <linux-wireless@vger.kernel.org>; Thu,  9 Jun 2022 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654800698; x=1686336698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IyvhnFVKvy2A2QJmh5qWc9uRnzJY1dK+ku8Bk35XCDY=;
  b=lmqzOa0T4yn1GZ+Ir6t2tUGMLl3ZN9qBGmSAjEOxZCFAGr6mE8oU3OZL
   1Sp3qtc7TwoQqOJTHcTO1wGU+dsVnkEUfBWLB6NmgcWoRrSOJvroeRivL
   Gf74S5KL3e+Ercu8PDi720/YK1FGCTRhAPcmiumQssnozeD5CIUUZf5so
   DFagYs4xYsexGJf/PuuZmm9a/f29ysCr03uoPMffKAwX/7ZKDsgeAa9uh
   qHrfGaT+6IDt2nv/c3YNat5pR9PeHFYAqpANVGzUYxJ+sGwE2/vTD/MpO
   zNRJRi2UBy9ZqAWVchSmsjXwbJeTCfI0D4xEd0CZcZi+ZXIyHeyXhlwfi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339141823"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="339141823"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 11:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="710571541"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2022 11:51:37 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 11:51:37 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 9 Jun 2022 11:51:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 9 Jun 2022 11:51:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 9 Jun 2022 11:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPCkP17iP2LE2HmWyVgBCqZPBnC5UnXl+hOdQEf3D42WCI/Zef+hRGflZ+zLkVx90aUoI+AWmyelEbFtib118f1sY6g92J7tGUpR3ObhvMr++/Pb6T4VHF5t9atDvy/nqJMrRYtoyhdTzcN6GbI+MUiUGzxckN2DOqmq/bQXZAYcKzbMESaR5thdJO/UobDB/Wz7DR8UwxsM75fGQpSqBJTTS9uf2Vn6s8INXBCNFqb9LiubUQjycbsBBHOFCaU6bFNV6otWF7G1Dv++FgXaDuGr5pOHLc6HVgPRBmqIkUh3cJ9zLmuCmuoQk/Hld8CNqdIhHT4uf4wghH+m6TJtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyvhnFVKvy2A2QJmh5qWc9uRnzJY1dK+ku8Bk35XCDY=;
 b=C/GrXn9aIFw0/jb3RF7fLoWuAHkhoMzA5HNIuHQMPktotWVAL2zoGW+Qa/FnwuB4H2MHpgv/xavvNz+uCN4yQ8grn+iAFle8WCGuc7FD500jzs5U6uJejjo1XSGyGRxVWVZwgOMrfDYJjmp1MEa+ouj+jRpNsOu+GnbTPQT101Xzs3jspTBY2pL3nDg1ShiYf1gvB/mK0Clq7oNb9d/7oPSxcBzAhlUZhBqxS/rSara7SEk99ctqyx891EIDPId0ohG70BeMWIfjJsQ5UyEtBsFUzBpV9h0r3A5oXNJLHg+p8iiFeeO5i6fEloDM3wh0bbFK8YavcutOusVCfghbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by MWHPR11MB1869.namprd11.prod.outlook.com (2603:10b6:300:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 9 Jun
 2022 18:51:34 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::e5b2:f15a:9bbd:1ca7]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::e5b2:f15a:9bbd:1ca7%7]) with mapi id 15.20.5314.012; Thu, 9 Jun 2022
 18:51:34 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "Hutchings, Ben" <ben@decadent.org.uk>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>
Subject: Re: pull request: iwlwifi firmware updates iwlwifi-fw-2022-06-09
Thread-Topic: pull request: iwlwifi firmware updates iwlwifi-fw-2022-06-09
Thread-Index: AQHYfALB0kmimN5RO06UIxQC2JQTKq1Ha9kA
Date:   Thu, 9 Jun 2022 18:51:34 +0000
Message-ID: <2d4e7c863938728e661e7bf93f42d26ee8456c58.camel@intel.com>
References: <9ec532a3e9c5b67bcb00e64c0cbe9b371e9509cc.camel@intel.com>
In-Reply-To: <9ec532a3e9c5b67bcb00e64c0cbe9b371e9509cc.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 840f7893-f13b-4ee5-b730-08da4a49133a
x-ms-traffictypediagnostic: MWHPR11MB1869:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB18694F1074D4B9E2657A93AA8BA79@MWHPR11MB1869.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0H20KM+GwAVWinV7tAf3F3YjGeUPsa+3Y1UFzgC/FqjCDVhDwjduEsl1pBYpaJeYHzmMCjhh2woVtfG4WJ83SyPitHjaBhPXhFRdXSwT6bCYlF+k/zG+qODMne99gXQ0C5ZHfLxJtuEp0CLFl/BuI5vnk4nu6sNe7cpw5ZIMmKYuufpZ6VQ5HY5qhwSmiUODel9qMf1OI9fZNWZ3WOpoqApjZ0uerJHT7WRTqjqEX95s+RCOa7hDhaE/IEvoDMryXXefihCHXDdnECiD2tn6WWuEMHaB5FOliSfpJF5FIck2VK0bFoNvwDBTIyHmnnc4D1J9sJ9lYxV8l82Z/l70giSShhq2dNfHy2EcqAPyXQWtRUAR/d8y4BqkdfzFd4Q2x9gD8glcru41U9NQrws+L5adctWWboLFBodHuoOHYm9a9wd5Sz1Mtd9+g/ZaA+qcn9pdjRKcfBv5w1nJfSAzuuVAc0jnOF6gvaZfdDcSrM87UlKO5gkTIe0wEbX0YH17ceV8acmvsAsurC95OH4/+V8dc3CqDuSmht4kjidPtyUFKiB/NvAbpeYASPau+EDg0AA4GGd5KuA8s0zFRP4asS0/JWnX9UVC6Dn3cXnET9EILn9RVIhg0XsU/erthTvohFnYJQLU8aWHB1UIFiDRXlH8b4sSrZ28ytz1AFnQzoErxll/7JDls8yWJreA1tqz1dara4BrC0L8V06mtbjZrLTQz7sC9BPgcTSdToNXcCZuYmN0lzYKaogn+lqdwor70kOC0mi4LixgIRS6COLIkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(83380400001)(6916009)(6486002)(66476007)(66446008)(64756008)(8936002)(316002)(66556008)(76116006)(966005)(6506007)(8676002)(15650500001)(4326008)(122000001)(86362001)(26005)(66946007)(54906003)(186003)(36756003)(82960400001)(19627235002)(6512007)(2616005)(2906002)(91956017)(508600001)(5660300002)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWdPN2VDVVJzTDJaamF5QXA1T3dGUjlzT0FSRFZMME5ISk1Fdm5MdWx6ZDU2?=
 =?utf-8?B?dXJwNzIyK2xOSlBzclNZNEJQbWdtVlhuUXJnTGtJNE8wSk1URTEwOEZCdll1?=
 =?utf-8?B?bWNGenNqdVlmUVZ0ald6NjF2Z2orL2hyK09IVS9BVzlIQkd2Y0pNWmxJYjdS?=
 =?utf-8?B?YmVveU95Y2hRRDZsTVpkTkZkd2NZaTZYTW8rTm9tRjlnR3FRZGV5L3Q0cjAv?=
 =?utf-8?B?S2xIRSt0cUJPQXM1WnVVdTZIWngrUVcwRnBmSS83VEszZUFEOFN4Nkl1Z3U3?=
 =?utf-8?B?Q1ZZaDUrd1VTdjhHUE9oVys5RkhGMVZkdS9aTlYvd1R1cFg2Wm9pYkN0UXd5?=
 =?utf-8?B?YUZQeEVXdzlydWU3QnVscXVSLzV5Q0NrSEhaSFM1dFVuQUZMZXBoSWVKbFkr?=
 =?utf-8?B?QXViV1VxMm9yVzlxRHRpQXRXTDJPZkFKMitUYU1xYVdkYWsyTWhMSkZ2V2JK?=
 =?utf-8?B?YWZNbUQvdkdWNlYvRStEam0rcHA5VGJEcS9aSDQrb21uVkdZNEtkRFRMYXBt?=
 =?utf-8?B?R01XUUl5d0I5bklqcVBJOGpKaXZydk9KMnV5TDRjbk16RjNiL0VNNTZEbHdM?=
 =?utf-8?B?TFRka0xxLzZnN0tzRWdqYkV5UVVOaUhzMUx2YnVzd2c5SisvRGtBUUNzL2li?=
 =?utf-8?B?dGdMbGdOOVFkR29ZVzBrRnNjY054YVk1Q0thL3puVjNDZGROSXg5U1VpcXdK?=
 =?utf-8?B?cHFLbE5FWm9wOFFDc1hsaStUZzBMYUlXTy9KZDI0TUMzUzNBNXpISVNLUElz?=
 =?utf-8?B?bFdmUmdma1BuOUdXVnlNV0hqcDJLdTdsZlNzVmRRV01lOGR1YWxmeDVpVjEx?=
 =?utf-8?B?eXlQRFphQTVFak5WNkYwcHJaMEdZa3hwZnRQZGZMYlZKVFM0ei8rWGp2NW0x?=
 =?utf-8?B?dmNHYjFMU2F2YUp3WWlxaVo0VUgzenAxK0lPdi9yQ2d0cFhQQmZTUE15eFpJ?=
 =?utf-8?B?VHl4V2prdG10a3hFNWhxczN0TkVnUEZGTzFJa0ZPTzVQVHIvUlN4UE9JQmJl?=
 =?utf-8?B?c3JFK3JYWHNQZFl2UzhCTFFnd010b3JDWVVKbFpLYlM1djhJRFpTTG1Qc2FD?=
 =?utf-8?B?ZHdzZTRtaHVVdkhNejNxL2tCRmdQY0V6MUNlUE45MFpiMktuRXJHYVNlQnZv?=
 =?utf-8?B?Tzg1a3d6WVFKck9mNlA3YkJUclpWbllOTS9yeWN3YjAxQ3V3eW4vOHc5Y29F?=
 =?utf-8?B?bEs2bVdqTk4zRE1wd1VsUFBEbzdHaVBrK3RuZ1VGbU90SWlnajF1OFJuTDZn?=
 =?utf-8?B?aXBNKzVubHl6SUxycDJESTZWYzkzT1d0UjcwOE03cFdlSjUzdHJ6K1BmRVhI?=
 =?utf-8?B?UmdVKzkzWWhxbHA4T2hSOEZWQ0g2Y2NFMndBNVRIVy82K1QvekdER01hSTd1?=
 =?utf-8?B?VDJ1UHg2bWdRVlN4R2ljQXN6Z1oxRXIxQUYwVnFZTGdwKzNsS1pOQkphQWpj?=
 =?utf-8?B?OXUyMVR5ZDlFTkRZd3dFczJTMTNmUVp2aW9TODBsaDVjZ09mdWVVcGw2Qkgy?=
 =?utf-8?B?YlRSc080UmY3VmpZTzVSVjAvMUkyUVlWUTNFcEMyZUVoN05MMU5hUGNsTUpq?=
 =?utf-8?B?bmhzUVN4c2ZtMUlycE4vNUxTMjZVcGptQjZtWXdocFJITkhhVTF3Uk9lOUlt?=
 =?utf-8?B?d3lxWUNsQWRnQ0dka0FZa2p1M0pkMDJ2NUN2bkdoWjc0MnRnM0F6WTc4NmVZ?=
 =?utf-8?B?RHdJWmhQT3BDT0ZEMEdIYUNyeEF6SkxuWDNMVXpnMmRjZ1djWjdLdXJYSmMz?=
 =?utf-8?B?L0dyUXRRTUxSNXZYVlJ2Wit6ZjFXY0xpVFQ4bnY5aTY1aWVyV2I3ZUVYRXZM?=
 =?utf-8?B?ZnMrKy9haGVvQjFRZW5TVytYOEI0K3E0ejNDYzEzanFxK29NYi9Uc0h0d1RC?=
 =?utf-8?B?L2VXSG9zYVFIME9Ga3RsSjlOcTdVUmhCR2I2L0V4OTFLVkdXYnpSVTZzL1BF?=
 =?utf-8?B?dUkzWEFKOUVwdUtQTVE2N0d6UUxrdTgvZVg1Rnc4bHA0K0s5V2ljWUgvUDNR?=
 =?utf-8?B?aXRkMG5GM1lYOURqcUg0KytMc3czUXhUTFdoWjlVSEtra0dxbGd6R2NEa2xx?=
 =?utf-8?B?OXhoallZS25nSm1haVdDTWxKZmdudXJXcDlzdnMrbVhPVjErcDAyRWNyY3dM?=
 =?utf-8?B?K1dMZTBaVHRVbGM3eEVCTFNTUzBnUC9LZnZQMFlyZUdTci9MWWlnT3Rua3E0?=
 =?utf-8?B?TXk4ZDdwYTBpT0gvZE5SOFVaOWQrTitOdEkvRXMzdS9CR3NyMi9CV3M4Yzh3?=
 =?utf-8?B?YlFJaEVxelFlR250VTQwWDY1UEtFN01iY2lYaVZSRzZDQlU2SGRQNTN4K05Y?=
 =?utf-8?B?bzdHTFpIS2hEZVc4cWRpczV3NW5vU1BOeG9HLys0WTcvSDRySDlaRFVrdlhT?=
 =?utf-8?Q?NIdFC4aG8RRoNcXWTRXHH4ycQxM4TE31R5OJS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76842CB6595CA143BA8E54255FD15241@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840f7893-f13b-4ee5-b730-08da4a49133a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 18:51:34.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OH0UrXioFUqGWLBSLSHE9jcnzD0QnDCWUfyN/Z5cADcUEbwdvQ+fFj3xX9HRlZLCAf+3S0uL0J2d9ZcHC3RwtS4AbP3v2RYGd0MDaio5E90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1869
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIyLTA2LTA5IGF0IDE2OjEzICswMzAwLCBHcmVlbm1hbiwgR3JlZ29yeSB3cm90
ZToNCj4gSGksDQo+IA0KPiBJJ20gdGhlIG5ldyBtYWludGFpbmVyIG9mIGl3bHdpZmkgZHJpdmVy
LCBhZGRpbmcgTHVjYSBpbiBjYyBmb3IgbXkgZmlyc3QNCj4gcHVsbCByZXF1ZXN0LiANCj4gDQo+
IFRoaXMgY29udGFpbnMgc29tZSBuZXcgYW5kIHVwZGF0ZWQgZmlybXdhcmVzIGZvciBhbGwgb3Vy
IGN1cnJlbnRseQ0KPiBtYWludGFpbmVkIEZXIGJpbmFyaWVzLg0KPiANCj4gUGxlYXNlIHB1bGwg
b3IgbGV0IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBpc3N1ZXMuDQo+IA0KPiAtLQ0KPiBUaGFu
a3MsDQo+IEdyZWdvcnkNCj4gDQo+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQg
MDJjNjk4NjNjODg1ZGI5NjNmOGMwMTIxYjUzM2YyODE2ZWY1YmUzYjoNCj4gDQo+IMKgIHJ0bF9i
dDogVXBkYXRlIFJUTDg4NTJBIEJUIFVTQiBmaXJtd2FyZSB0byAweERGQjhfMDYzNCAoMjAyMi0w
Ni0wNyAwODozMjozOSAtMDQwMCkNCj4gDQo+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBv
c2l0b3J5IGF0Og0KPiDCoA0KPiBodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2l3bHdpZmkvbGludXgtZmlybXdhcmUuZ2l0wqB0YWdzL2l3bHdpZmktZnctMjAy
Mi0wNi0wOQ0KPiANCj4gZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDk5Y2I0YjA5NWI3
Njc5NTk2ZWQ5ZmJmMTU3ODU2OGRmMTgzNzc4NjY6DQo+IA0KPiDCoCBpd2x3aWZpOiBhZGQgbmV3
IEZXcyBmcm9tIGNvcmU3MC04NyByZWxlYXNlICgyMDIyLTA2LTA5IDEwOjE5OjMyICswMzAwKQ0K
PiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiBVcGRhdGUgYW5kIGFkZCBpd2x3aWZpIGZpcm13YXJlIGJpbmFyaWVz
IGZvciByZWxlYXNlIENvcmU3MC04Nw0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBHcmVnb3J5IEdyZWVubWFu
ICgyKToNCj4gwqDCoMKgwqDCoCBpd2x3aWZpOiB1cGRhdGUgOTAwMC1mYW1pbHkgZmlybXdhcmVz
IHRvIGNvcmU3MC04Nw0KPiDCoMKgwqDCoMKgIGl3bHdpZmk6IGFkZCBuZXcgRldzIGZyb20gY29y
ZTcwLTg3IHJlbGVhc2UNCj4gDQo+IMKgV0hFTkNFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0MA0KPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tDQo+IMKgaXdsd2lmaS05MDAwLXB1LWIwLWpmLWIwLTQ2LnVj
b2RlIHwgQmluIDE1MjAyMDggLT4gMTUxODc4OCBieXRlcw0KPiDCoGl3bHdpZmktOTI2MC10aC1i
MC1qZi1iMC00Ni51Y29kZSB8IEJpbiAxNDkxMDU2IC0+IDE0ODk1NDggYnl0ZXMNCj4gwqBpd2x3
aWZpLVF1LWIwLWhyLWIwLTczLnVjb2RlwqDCoMKgwqDCoCB8IEJpbiAwIC0+IDEzNjk4NDAgYnl0
ZXMNCj4gwqBpd2x3aWZpLVF1LWIwLWpmLWIwLTczLnVjb2RlwqDCoMKgwqDCoCB8IEJpbiAwIC0+
IDEyOTAwODQgYnl0ZXMNCj4gwqBpd2x3aWZpLVF1LWMwLWhyLWIwLTczLnVjb2RlwqDCoMKgwqDC
oCB8IEJpbiAwIC0+IDEzNjk4NTYgYnl0ZXMNCj4gwqBpd2x3aWZpLVF1LWMwLWpmLWIwLTczLnVj
b2RlwqDCoMKgwqDCoCB8IEJpbiAwIC0+IDEyOTAxMDAgYnl0ZXMNCj4gwqBpd2x3aWZpLVF1Wi1h
MC1oci1iMC03My51Y29kZcKgwqDCoMKgIHwgQmluIDAgLT4gMTM2OTk3NiBieXRlcw0KPiDCoGl3
bHdpZmktUXVaLWEwLWpmLWIwLTczLnVjb2RlwqDCoMKgwqAgfCBCaW4gMCAtPiAxMjkwMjIwIGJ5
dGVzDQo+IMKgaXdsd2lmaS1jYy1hMC03My51Y29kZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBC
aW4gMCAtPiAxMzMzMjk2IGJ5dGVzDQo+IMKgaXdsd2lmaS1zby1hMC1nZi1hMC03My51Y29kZcKg
wqDCoMKgwqAgfCBCaW4gMCAtPiAxNTYzNjkyIGJ5dGVzDQo+IMKgaXdsd2lmaS1zby1hMC1nZi1h
MC5wbnZtwqDCoMKgwqDCoMKgwqDCoMKgIHwgQmluIDQxODA4IC0+IDQxODA4IGJ5dGVzDQo+IMKg
aXdsd2lmaS1zby1hMC1nZjQtYTAtNzMudWNvZGXCoMKgwqDCoCB8IEJpbiAwIC0+IDE1ODc4MDAg
Ynl0ZXMNCj4gwqBpd2x3aWZpLXNvLWEwLWdmNC1hMC5wbnZtwqDCoMKgwqDCoMKgwqDCoCB8IEJp
biAyODA2NCAtPiAyODA2NCBieXRlcw0KPiDCoGl3bHdpZmktc28tYTAtaHItYjAtNzMudWNvZGXC
oMKgwqDCoMKgIHwgQmluIDAgLT4gMTQ2NTIwOCBieXRlcw0KPiDCoGl3bHdpZmktc28tYTAtamYt
YjAtNzMudWNvZGXCoMKgwqDCoMKgIHwgQmluIDAgLT4gMTQwOTMzNiBieXRlcw0KPiDCoGl3bHdp
ZmktdHktYTAtZ2YtYTAtNzMudWNvZGXCoMKgwqDCoMKgIHwgQmluIDAgLT4gMTUwMjkwMCBieXRl
cw0KPiDCoGl3bHdpZmktdHktYTAtZ2YtYTAucG52bcKgwqDCoMKgwqDCoMKgwqDCoCB8IEJpbiA0
MTU4OCAtPiA0MTU4OCBieXRlcw0KPiDCoDE4IGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktUXUtYjAt
aHItYjAtNzMudWNvZGUNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1RdS1iMC1qZi1i
MC03My51Y29kZQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3aWZpLVF1LWMwLWhyLWIwLTcz
LnVjb2RlDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGl3bHdpZmktUXUtYzAtamYtYjAtNzMudWNv
ZGUNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1RdVotYTAtaHItYjAtNzMudWNvZGUN
Cj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1RdVotYTAtamYtYjAtNzMudWNvZGUNCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgaXdsd2lmaS1jYy1hMC03My51Y29kZQ0KPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBpd2x3aWZpLXNvLWEwLWdmLWEwLTczLnVjb2RlDQo+IMKgY3JlYXRlIG1vZGUg
MTAwNjQ0IGl3bHdpZmktc28tYTAtZ2Y0LWEwLTczLnVjb2RlDQo+IMKgY3JlYXRlIG1vZGUgMTAw
NjQ0IGl3bHdpZmktc28tYTAtaHItYjAtNzMudWNvZGUNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
aXdsd2lmaS1zby1hMC1qZi1iMC03My51Y29kZQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpd2x3
aWZpLXR5LWEwLWdmLWEwLTczLnVjb2RlDQo+IA0KDQpJIGZvcmdvdCB0byBjYyBsaW51eC13aXJl
bGVzcyBpbiB0aGUgb3JpZ2luYWwgcHVsbCByZXF1ZXN0LA0Kc28gYWRkaW5nIGl0IGhlcmUuDQo=
