Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56FB6329CA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 17:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiKUQkp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 11:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiKUQka (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 11:40:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3B5592
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 08:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669048829; x=1700584829;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PNQuXUu9kjitAubjLun0pNclOe55WpiOhm1uUNpLkK8=;
  b=C9VDS7g1x26JJ4gDuuwyqa00SUkQ1GEBCegmE+q6rixPjdNFwQrUH21o
   u9yVeKCQa8a9t7Ad5PVk0dUe9a5/wVYKDVrywjqRNpBgzYEc1lLnc4JG1
   9wzquytwgnwpSx+bDv50JcfZNEFIBLYu2pMyEJ/TK48ZFWgfo1uq+44dm
   eoP5xDlorWH/Dri6etGN/acr3NNQScS3+2ha2baZHudN+2k75flmXOAVe
   7qgSOUeRfFcKTXhzxQV9/nprwUvG/SdtBlyTPL7UyoqFZXnZHYqCVneQG
   SqhIZcFHuo/+/PpyZcYt+yvfisP8H8SkkRxOjI0BOmx5t3LRj2F2n9mKd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="293311423"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="293311423"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 08:40:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="643380614"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="643380614"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2022 08:40:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 08:40:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 08:40:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 08:40:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLaJZmYWecZfC5TRPvuU3DtFff5ikbZuuqX2Es9FGIxu4JcCnwXqYHGIXfIb5rDJxgfuojvOZYKP7BVNuVgpc0W+jWOZka+Vb/UGr3bdCgm0gSaSNfRKBGnokvTA1HuZnhup9kzoahI4ob19PFKLnhl84UXfn2M0FF38ny4G6V08dSkHu7tCFwXr/zMdwgMoh07ntw0yyrV2jSIvt685lYcI6Hw9NmjCkHXH6x7apgB9s3h6blbWepYn0Jl7cLbZER9IkbK1xYHa7tT8qZtkDlzTvtE5qnJAxDwMVl82YxeoRt136+XoqL91NUP1QbyZY+2hKSSG1EC1yh7hN8583g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNQuXUu9kjitAubjLun0pNclOe55WpiOhm1uUNpLkK8=;
 b=iIEKZEEixuYFp9iG87hHJTPZDSyghMIj//2WAK68vy8L8wMqwNGmTEsC3HWH7Opzx0DmyFa9Go6mj7uSziHN7Z61D1Z+mVxc8J0xn4de/3PpI+9looIH48YqDyfHeinqeGHeq2WPUOfEPlQ3uuqTlf3PC1ZyZmgpuLtfwJqEWLsFpQCkxbO8NHJFOwqixjLqSBqmD4AKDU+gI8ybrXDw4I9EOJdiLUSBD8Ef5zu2nrtVVfnPylpgi5Z6ewgraTKRv/nezAI1KqJjXxM/1p3nMa/KqeKzZVthHoN31Bj9mFFYN5w/LoqoXvfCo9CCIJDenf5JnUaoC+NhaEPa3So1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 16:40:08 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::28fb:a1de:6842:d70a%8]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 16:40:08 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "error27@gmail.com" <error27@gmail.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [bug report] wifi: iwlwifi: mei: implement PLDR flow
Thread-Topic: [bug report] wifi: iwlwifi: mei: implement PLDR flow
Thread-Index: AQHY/b2Lf0efBb+MHEuyaodwm6FQP65JlFaA
Date:   Mon, 21 Nov 2022 16:40:08 +0000
Message-ID: <a5e3ca255e9124041681173d013545546b42bd1d.camel@intel.com>
References: <Y3uYUEFnMiBY2ABQ@kili>
In-Reply-To: <Y3uYUEFnMiBY2ABQ@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM4PR11MB5358:EE_
x-ms-office365-filtering-correlation-id: 10b1723a-7d02-42e2-a1da-08dacbdf0d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAY34C2EleHF5eZXZg/XElmDCHCp94GfIP3PTerVWsJEsW8NcAF/78muEFjzZSjJATFbw5gk1rB8yDJUm/pAXX4bjatQkwp1ZAiz+brZIBD787wXg+6NYz8WXw/h/JA6GrsNCxhuxVnPVBecpRYEpyTrMNg+lp+A0VQO+W1iFP2EWKQDRbC+Mw7uR+za5VgMEXNY2wNfH/he9OJM+gA6x6EChmnqYhka8B+QYqjz1wZD68jiKamPN2ZqWzTemd0DHfvmo2ESneeStE+B6h+g72HmBvP0s1AucsyUKhtKBO2T4u8QjkpQi15QeB4wTvVQAK/tsdvpYlNxv2NDq5wtK5i1lOIWEE7YBgm/1sERbo2GSN3y+x9BMuJwlQdtmhXHpVaJKi37r09BHTqd8qFSIj4UwuiKGV2yloL4hFdIFW+36avPvotOsuk4yVh6meg4tOmos9aPhrGBQFJQTTI6odmStrPNnP6SRNNZx3dT2/yrx+r/M188vWdX0upbs9QzjDpeexfmKc9YnaNTOdgVLYqi4saqKhbnT3fX5semv4dwSPqbBBSd1OByOt2vf9w2nWYGVuJteYb7+Ci94g7atAEjRRc0kdZVQYly81EJMZr2khINRkrHtdtj/yPNdD82ex+M/Gj6oCa9e9ul9bns8osBHeFEEGvxHUwfhABTl/KvY+OwOc2w5aJ1gyiijgJ4EdxJtwwsp+SAYPsRnmoUFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(6486002)(110136005)(71200400001)(6506007)(38070700005)(478600001)(82960400001)(6636002)(2616005)(66946007)(76116006)(86362001)(186003)(83380400001)(91956017)(26005)(316002)(8936002)(6512007)(66556008)(4326008)(41300700001)(122000001)(64756008)(38100700002)(66446008)(66476007)(2906002)(4001150100001)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djl5aEdVY0t3R3ZQNzNIaVdQZUVkNU5wYUQ4Umo4cUtLLzFGNHZTa2tYc0Z2?=
 =?utf-8?B?SmlvZlV4empCUHRPenpjTXV2ZGc5Zm9MWXNhWlE1U2Z4WE5ZOVNYN0h5dmRP?=
 =?utf-8?B?cFJsRXJTelRlSnJNYm1HRmJBWTlBQ0RST1hyTi9KeUFrMDFSU1hPZklYNzFo?=
 =?utf-8?B?R0d2WVdwcHJZNTNwdVBucnhHbUpvblhlRjJQaHpVNTkrTWRmV0o0bk40aFNP?=
 =?utf-8?B?eGM5eVA2cFNMRndOcStSdnpUeDFQUGV5clpZS2FrSmVyQlJSNDJZNTJSWlZU?=
 =?utf-8?B?a0ltd3MwM1VqOEwwend5MElNQlNRNjJEZGJ4RW9ZVlMwR3d4cWZtUk5UZEJ0?=
 =?utf-8?B?MEY5ZURtVVBKQm9CTG54K2o0RzFURTVHRWdpd2ZNZENidEQ4YVM5OGJMTzRI?=
 =?utf-8?B?Z2ZSMXRpS1YvbVBjVHpCMmt1bWxhUVFwZDNEZ0JxaHFSQ01OVnZ5SGRIVU5X?=
 =?utf-8?B?TlZFZmdQTzB1TXF2Mi9pWFJtYytFem1oOFZYYkRCcmhtL3FNaHI1dFJ1STVN?=
 =?utf-8?B?QWNBajhqbWp3VFVLenM0RXM0UEJxOW9GSXU4UXNweEdNcDF2TkZyU1E0cDRT?=
 =?utf-8?B?QXVJaUhQbDNIMEJjS3RGY3hoV2NGTldwSCtrOExwcHk5cVJwTW8wS0VGWStL?=
 =?utf-8?B?VFpsaUpkMTVzSUlLeGFNbDFVU3FycjdOQTNDYWQwVkRHMGdKWHFsdHVVb3Fw?=
 =?utf-8?B?S0ZMOC8rMmRMUEl1elQ0SG9QWG4wMVdrWHJDaU5scm9pODZiZkNic1R3ZmxY?=
 =?utf-8?B?TDNHb1RQR2pTYWcwT3h1OTcrODFTdW5ETTdNYVhCd204UmFBTXdEV0pCdGJF?=
 =?utf-8?B?Ylc0SVlvS1dnVlRQaitTNnhjUlVzOU00dWt5MFlQTXNnVHBGV2JxSnY5UEwr?=
 =?utf-8?B?NWlySlV2YnpQWEtWZXpqRFc2OGVmdkVxdnNIR1cwTkFvN2dNTGcwbXpaY2px?=
 =?utf-8?B?RnRuV2U0WDNsZ0l1U2Erb2Q4cUdZUU1PY0VWTm1JbjgvVzdScmJVYWRXTWF6?=
 =?utf-8?B?MDMvNjJJTXR3anNKUFJ5L0Flck44UHlRTUwxalBnOVRkYVhFR081eTNFY21o?=
 =?utf-8?B?R0xjQjVnV0tKdDFZNVN1cnZMZnR0Y1VNZDhBN05xK3hGemhUNlpuWnJ3eGZ5?=
 =?utf-8?B?M3pISk9qVGpHQUdOUnlLYWRwNlFyTVJzSEpkenZDNy9ZQ0lZQTdhcnZNSXl0?=
 =?utf-8?B?WFQ1azA5NTUrdGxNNEt2V040ZmYxS3l3U0FYa0RFTXhrKzc1cFkybkxzSGQr?=
 =?utf-8?B?bVlaU3Vja0k0c1hIeFJFdzZSV1FNN0VOQWY0VHRZK1VKNXM3WTVkQVpUenlp?=
 =?utf-8?B?bWhTa1gyMytWaVd0S0ZxcStUMHp1NzBNZCswNnNBWGNjdmlHa1lUb3ZNZmo3?=
 =?utf-8?B?ajdSa0ZYa2QvK0hYeTNQeHluWFRaczVOVzNhcGJpeHA0Z3hCTHVRYmQyV05F?=
 =?utf-8?B?Q1E1VlhGTWhxOFU0ZVg1UjdOeGxQRmszRkpOYXdVdG9YNFFvZDNQcm5tL1ZX?=
 =?utf-8?B?eEtyT1dhaHFYUGJ5QlBRYklrcnRvOWNlMnAwZmYyV2taRWxQTFBJWVcycHNi?=
 =?utf-8?B?ZUxVQ1ZDVDVmcGkwbHhuanhEaGxhWW90djRaaFlnck5iL0R3Nk0xc2JtV0V4?=
 =?utf-8?B?REJRNTY2dzBpc3ZRUnFpa0ZNcHp2UndweXU0Mmg1QWU1VU02dHY4MDJxL1RX?=
 =?utf-8?B?MnhnakoxTmtwSUJCVHljWFMrdUFkQkpyV0VUc1hZVHU3UU4rK0M2VmFiTlFl?=
 =?utf-8?B?bDNnNTB2U0NaUlhhbnJCWi9FZ3pMZUJyQU11SXlHZFVaOSsweGJMSVBxSlZR?=
 =?utf-8?B?cXo0MzFaYTQxdVg2eHo0bUZkRXArOXdTd2xjbDdzZ0orNzBJNUJGa2wvaEdw?=
 =?utf-8?B?ZVdKOFJTcUZDdU04c3NmYnFWR0ZmN2wrdmRoSjI5MTJsUlNhN0x2cmY0YU9N?=
 =?utf-8?B?OUxsRGxJYXJDdDBzamVDSlZ2ZVJmYnVoa1NocXFZOFhLMVF4bHhXUWxIVktI?=
 =?utf-8?B?bWtna2RLTjFqV3hwVTBHeXQzQW9CTXpWN28vZTl0TXczMmQraGdPU0pWQ0wr?=
 =?utf-8?B?TUxJSi9hYmdnVjJad3BNK2ZpK1VZdEdKQkluellGRHF0Z1IvQTdXQ2hqNkdr?=
 =?utf-8?B?R1ZVYU1MWGZ0ODZzdXhJMkd0NEQvdGlSZytUQmgvMklCTmJYNGYrakhsOWpo?=
 =?utf-8?Q?qoS1kB+uu2+ep1h0sRcEGQc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC0813787802964D837A5A160B20B3D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b1723a-7d02-42e2-a1da-08dacbdf0d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 16:40:08.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARS6HYZMr1RVkbFsr7Zx+khcN2UP9Luvh5Wx6Q1E926pjfmHuFkCVAyrwjGWuW4aMfWYXl1i37uw0g+CGONw50a8ojfI616MrUlMF0pMwPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5358
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTIxIGF0IDE4OjI1ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+
IEhlbGxvIEF2cmFoYW0gU3Rlcm4sCj4gCj4gVGhlIHBhdGNoIDczM2ViNTRmNjJjNjogIndpZmk6
IGl3bHdpZmk6IG1laTogaW1wbGVtZW50IFBMRFIgZmxvdyIKPiBmcm9tIE5vdiAyLCAyMDIyLCBs
ZWFkcyB0byB0aGUgZm9sbG93aW5nIHVucHVibGlzaGVkIFNtYXRjaCBzdGF0aWMKPiBjaGVja2Vy
IHdhcm5pbmc6Cj4gCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vZncu
Yzo0MDcgaXdsX212bV9sb2FkX3Vjb2RlX3dhaXRfYWxpdmUoKSB3YXJuOiBkdXBsaWNhdGUgY2hl
Y2sgJ3JldCcgKHByZXZpb3VzIG9uIGxpbmUgMzU3KQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2lu
dGVsL2l3bHdpZmkvbXZtL2Z3LmM6MTQ3MSBpd2xfbXZtX3VwKCkgd2FybjogbWlzc2luZyBlcnJv
ciBjb2RlPyAncmV0Jwo+IAo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZt
L2Z3LmMKPiDCoMKgwqAgMzExIHN0YXRpYyBpbnQgaXdsX212bV9sb2FkX3Vjb2RlX3dhaXRfYWxp
dmUoc3RydWN0IGl3bF9tdm0gKm12bSwKPiDCoMKgwqAgMzEywqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlbnVtIGl3bF91Y29kZV90eXBlIHVjb2RlX3R5cGUpCj4gwqDCoMKgIDMxMyB7Cj4gwqDC
oMKgIDMxNMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGl3bF9ub3RpZmljYXRpb25fd2FpdCBhbGl2
ZV93YWl0Owo+IMKgwqDCoCAzMTXCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpd2xfbXZtX2FsaXZl
X2RhdGEgYWxpdmVfZGF0YSA9IHt9Owo+IMKgwqDCoCAzMTbCoMKgwqDCoMKgwqDCoMKgIGNvbnN0
IHN0cnVjdCBmd19pbWcgKmZ3Owo+IMKgwqDCoCAzMTfCoMKgwqDCoMKgwqDCoMKgIGludCByZXQ7
Cj4gwqDCoMKgIDMxOMKgwqDCoMKgwqDCoMKgwqAgZW51bSBpd2xfdWNvZGVfdHlwZSBvbGRfdHlw
ZSA9IG12bS0+ZndydC5jdXJfZndfaW1nOwo+IMKgwqDCoCAzMTnCoMKgwqDCoMKgwqDCoMKgIHN0
YXRpYyBjb25zdCB1MTYgYWxpdmVfY21kW10gPSB7IFVDT0RFX0FMSVZFX05URlkgfTsKPiDCoMKg
wqAgMzIwwqDCoMKgwqDCoMKgwqDCoCBib29sIHJ1bl9pbl9yZmtpbGwgPQo+IMKgwqDCoCAzMjHC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1Y29kZV90eXBlID09IElXTF9VQ09ERV9J
TklUIHx8IGl3bF9tdm1faGFzX3VuaWZpZWRfdWNvZGUobXZtKTsKPiDCoMKgwqAgMzIyIAo+IMKg
wqDCoCAzMjPCoMKgwqDCoMKgwqDCoMKgIGlmICh1Y29kZV90eXBlID09IElXTF9VQ09ERV9SRUdV
TEFSICYmCj4gwqDCoMKgIDMyNMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpd2xfZndfZGJnX2Nv
bmZfdXNuaWZmZXIobXZtLT5mdywgRldfREJHX1NUQVJUX0ZST01fQUxJVkUpICYmCj4gwqDCoMKg
IDMyNcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhKGZ3X2hhc19jYXBhKCZtdm0tPmZ3LT51Y29k
ZV9jYXBhLAo+IMKgwqDCoCAzMjbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIElXTF9VQ09ERV9UTFZfQ0FQQV9VU05JRkZFUl9VTklGSUVEKSkpCj4g
wqDCoMKgIDMyN8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZ3ID0gaXdsX2dldF91
Y29kZV9pbWFnZShtdm0tPmZ3LCBJV0xfVUNPREVfUkVHVUxBUl9VU05JRkZFUik7Cj4gwqDCoMKg
IDMyOMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+IMKgwqDCoCAzMjnCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBmdyA9IGl3bF9nZXRfdWNvZGVfaW1hZ2UobXZtLT5mdywgdWNvZGVfdHlw
ZSk7Cj4gwqDCoMKgIDMzMMKgwqDCoMKgwqDCoMKgwqAgaWYgKFdBUk5fT04oIWZ3KSkKPiDCoMKg
wqAgMzMxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4g
wqDCoMKgIDMzMsKgwqDCoMKgwqDCoMKgwqAgaXdsX2Z3X3NldF9jdXJyZW50X2ltYWdlKCZtdm0t
PmZ3cnQsIHVjb2RlX3R5cGUpOwo+IMKgwqDCoCAzMzPCoMKgwqDCoMKgwqDCoMKgIGNsZWFyX2Jp
dChJV0xfTVZNX1NUQVRVU19GSVJNV0FSRV9SVU5OSU5HLCAmbXZtLT5zdGF0dXMpOwo+IMKgwqDC
oCAzMzQgCj4gwqDCoMKgIDMzNcKgwqDCoMKgwqDCoMKgwqAgaXdsX2luaXRfbm90aWZpY2F0aW9u
X3dhaXQoJm12bS0+bm90aWZfd2FpdCwgJmFsaXZlX3dhaXQsCj4gwqDCoMKgIDMzNsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYWxpdmVfY21kLCBBUlJBWV9TSVpFKGFsaXZlX2NtZCksCj4gwqDCoMKgIDMzN8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaXdsX2FsaXZlX2ZuLCAmYWxpdmVfZGF0YSk7Cj4gwqDCoMKgIDMzOCAKPiDCoMKg
wqAgMzM5wqDCoMKgwqDCoMKgwqDCoCAvKgo+IMKgwqDCoCAzNDDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBXZSB3YW50IHRvIGxvYWQgdGhlIElOSVQgZmlybXdhcmUgZXZlbiBpbiBSRktJTEwKPiDCoMKg
wqAgMzQxwqDCoMKgwqDCoMKgwqDCoMKgICogRm9yIHRoZSB1bmlmaWVkIGZpcm13YXJlIGNhc2Us
IHRoZSB1Y29kZV90eXBlIGlzIG5vdAo+IMKgwqDCoCAzNDLCoMKgwqDCoMKgwqDCoMKgwqAgKiBJ
TklULCBidXQgd2Ugc3RpbGwgbmVlZCB0byBydW4gaXQuCj4gwqDCoMKgIDM0M8KgwqDCoMKgwqDC
oMKgwqDCoCAqLwo+IMKgwqDCoCAzNDTCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGl3bF90cmFuc19z
dGFydF9mdyhtdm0tPnRyYW5zLCBmdywgcnVuX2luX3Jma2lsbCk7Cj4gwqDCoMKgIDM0NcKgwqDC
oMKgwqDCoMKgwqAgaWYgKHJldCkgewo+IMKgwqDCoCAzNDbCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpd2xfZndfc2V0X2N1cnJlbnRfaW1hZ2UoJm12bS0+ZndydCwgb2xkX3R5cGUp
Owo+IMKgwqDCoCAzNDfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpd2xfcmVtb3Zl
X25vdGlmaWNhdGlvbigmbXZtLT5ub3RpZl93YWl0LCAmYWxpdmVfd2FpdCk7Cj4gwqDCoMKgIDM0
OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gwqDCoMKgIDM0
OcKgwqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoCAzNTAgCj4gwqDCoMKgIDM1McKgwqDCoMKgwqDC
oMKgwqAgLyoKPiDCoMKgwqAgMzUywqDCoMKgwqDCoMKgwqDCoMKgICogU29tZSB0aGluZ3MgbWF5
IHJ1biBpbiB0aGUgYmFja2dyb3VuZCBub3csIGJ1dCB3ZQo+IMKgwqDCoCAzNTPCoMKgwqDCoMKg
wqDCoMKgwqAgKiBqdXN0IHdhaXQgZm9yIHRoZSBBTElWRSBub3RpZmljYXRpb24gaGVyZS4KPiDC
oMKgwqAgMzU0wqDCoMKgwqDCoMKgwqDCoMKgICovCj4gwqDCoMKgIDM1NcKgwqDCoMKgwqDCoMKg
wqAgcmV0ID0gaXdsX3dhaXRfbm90aWZpY2F0aW9uKCZtdm0tPm5vdGlmX3dhaXQsICZhbGl2ZV93
YWl0LAo+IMKgwqDCoCAzNTbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTVZNX1VDT0RFX0FMSVZFX1RJTUVPVVQp
Owo+IMKgwqDCoCAzNTfCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpIHsKPiDCoMKgwqAgMzU4wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGl3bF90cmFucyAqdHJhbnMgPSBt
dm0tPnRyYW5zOwo+IMKgwqDCoCAzNTkgCj4gwqDCoMKgIDM2MMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC8qIFNlY0Jvb3QgaW5mbyAqLwo+IMKgwqDCoCAzNjHCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodHJhbnMtPnRyYW5zX2NmZy0+ZGV2aWNlX2ZhbWlseSA+
PQo+IMKgwqDCoCAzNjLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJV0xfREVWSUNFX0ZBTUlMWV8y
MjAwMCkgewo+IMKgwqDCoCAzNjPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSVdMX0VSUihtdm0sCj4gwqDCoMKgIDM2NMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIlNlY0Jvb3QgQ1BV
MSBTdGF0dXM6IDB4JXgsIENQVTIgU3RhdHVzOiAweCV4XG4iLAo+IMKgwqDCoCAzNjXCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGl3bF9yZWFkX3VtYWNfcHJwaCh0cmFucywgVU1BR19TQl9DUFVfMV9TVEFUVVMpLAo+IMKgwqDC
oCAzNjbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGl3bF9yZWFkX3VtYWNfcHJwaCh0cmFucywKPiDCoMKgwqAgMzY3wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVNQUdfU0JfQ1BVXzJfU1RB
VFVTKSk7Cj4gwqDCoMKgIDM2OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxz
ZSBpZiAodHJhbnMtPnRyYW5zX2NmZy0+ZGV2aWNlX2ZhbWlseSA+PQo+IMKgwqDCoCAzNjnCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSVdMX0RF
VklDRV9GQU1JTFlfODAwMCkgewo+IMKgwqDCoCAzNzDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSVdMX0VSUihtdm0sCj4gwqDCoMKgIDM3McKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
IlNlY0Jvb3QgQ1BVMSBTdGF0dXM6IDB4JXgsIENQVTIgU3RhdHVzOiAweCV4XG4iLAo+IMKgwqDC
oCAzNzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGl3bF9yZWFkX3BycGgodHJhbnMsIFNCX0NQVV8xX1NUQVRVUyksCj4gwqDC
oMKgIDM3M8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaXdsX3JlYWRfcHJwaCh0cmFucywgU0JfQ1BVXzJfU1RBVFVTKSk7Cj4g
wqDCoMKgIDM3NMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqAgMzc1
IAo+IMKgwqDCoCAzNzbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpd2xfbXZtX3By
aW50X3BkX25vdGlmaWNhdGlvbihtdm0pOwo+IMKgwqDCoCAzNzcgCj4gwqDCoMKgIDM3OMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIExNQUMvVU1BQyBQQyBpbmZvICovCj4gwqDC
oMKgIDM3OcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh0cmFucy0+dHJhbnNf
Y2ZnLT5kZXZpY2VfZmFtaWx5ID49Cj4gwqDCoMKgIDM4MMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IElXTF9ERVZJQ0VfRkFNSUxZXzkwMDApIHsKPiDCoMKgwqAgMzgxwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElXTF9FUlIobXZtLCAiVU1BQyBQQzogMHgl
eFxuIiwKPiDCoMKgwqAgMzgywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpd2xfcmVhZF91bWFjX3BycGgodHJhbnMsCj4gwqDC
oMKgIDM4M8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBVUkVH
X1VNQUNfQ1VSUkVOVF9QQykpOwo+IMKgwqDCoCAzODTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSVdMX0VSUihtdm0sICJMTUFDIFBDOiAweCV4XG4iLAo+
IMKgwqDCoCAzODXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGl3bF9yZWFkX3VtYWNfcHJwaCh0cmFucywKPiDCoMKgwqAgMzg2
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVSRUdfTE1BQzFf
Q1VSUkVOVF9QQykpOwo+IMKgwqDCoCAzODfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKGl3bF9tdm1faXNfY2RiX3N1cHBvcnRlZChtdm0pKQo+IMKg
wqDCoCAzODjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIElXTF9FUlIobXZtLCAiTE1BQzIgUEM6IDB4JXhcbiIsCj4gwqDCoMKg
IDM4OcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGl3bF9yZWFkX3VtYWNfcHJwaCh0cmFucywKPiDC
oMKgwqAgMzkwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVSRUdfTE1B
QzJfQ1VSUkVOVF9QQykpOwo+IMKgwqDCoCAzOTHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4gwqDCoMKgIDM5MiAKPiDCoMKgwqAgMzkzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHJldCA9PSAtRVRJTUVET1VUKQo+IMKgwqDCoCAzOTTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXdsX2Z3X2RiZ19lcnJvcl9jb2xs
ZWN0KCZtdm0tPmZ3cnQsCj4gwqDCoMKgIDM5NcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEZXX0RCR19UUklHR0VSX0FMSVZFX1RJTUVPVVQpOwo+IMKgwqDCoCAzOTYg
Cj4gwqDCoMKgIDM5N8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGl3bF9md19zZXRf
Y3VycmVudF9pbWFnZSgmbXZtLT5md3J0LCBvbGRfdHlwZSk7Cj4gwqDCoMKgIDM5OMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeXl5eXl5eXl5eXgo+IAo+IMKgwqDCoCAzOTnC
oMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqAgNDAwIAo+IMKgwqDCoCA0MDHCoMKgwqDCoMKgwqDC
oMKgIGlmICghYWxpdmVfZGF0YS52YWxpZCkgewo+IMKgwqDCoCA0MDLCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBJV0xfRVJSKG12bSwgIkxvYWRlZCB1Y29kZSBpcyBub3QgdmFsaWQh
XG4iKTsKPiDCoMKgwqAgNDAzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXdsX2Z3
X3NldF9jdXJyZW50X2ltYWdlKCZtdm0tPmZ3cnQsIG9sZF90eXBlKTsKPiDCoMKgwqAgNDA0wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU87Cj4gwqDCoMKgIDQwNcKg
wqDCoMKgwqDCoMKgwqAgfQo+IMKgwqDCoCA0MDYgCj4gLS0+IDQwN8KgwqDCoMKgwqDCoMKgwqAg
aXdsX21laV9hbGl2ZV9ub3RpZighcmV0KTsKPiAKPiBXZSBrbm93IHRoYXQgInJldCIgaXMgemVy
by4KPiAKPiDCoMKgwqAgNDA4IAo+IMKgwqDCoCA0MDnCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGl3
bF9wbnZtX2xvYWQobXZtLT50cmFucywgJm12bS0+bm90aWZfd2FpdCk7Cj4gwqDCoMKgIDQxMMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHJldCkgewo+IAo+IFsgc25pcCBdCj4gCj4gwqAgMTQ1NcKgIGlu
dCBpd2xfbXZtX3VwKHN0cnVjdCBpd2xfbXZtICptdm0pCj4gwqAgMTQ1NsKgIHsKPiDCoCAxNDU3
wqDCoMKgwqDCoMKgwqDCoMKgIGludCByZXQsIGk7Cj4gwqAgMTQ1OMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5uZWwgKmNoYW47Cj4gwqAgMTQ1OcKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgY2ZnODAyMTFfY2hhbl9kZWYgY2hhbmRlZjsKPiDCoCAxNDYwwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBpZWVlODAyMTFfc3VwcG9ydGVkX2JhbmQgKnNiYW5kID0gTlVMTDsK
PiDCoCAxNDYxwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiBzYl9jZmc7Cj4gwqAgMTQ2MsKgIAo+IMKg
IDE0NjPCoMKgwqDCoMKgwqDCoMKgwqAgbG9ja2RlcF9hc3NlcnRfaGVsZCgmbXZtLT5tdXRleCk7
Cj4gwqAgMTQ2NMKgIAo+IMKgIDE0NjXCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gaXdsX3RyYW5z
X3N0YXJ0X2h3KG12bS0+dHJhbnMpOwo+IMKgIDE0NjbCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJl
dCkKPiDCoCAxNDY3wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0
Owo+IMKgIDE0NjjCoCAKPiDCoCAxNDY5wqDCoMKgwqDCoMKgwqDCoMKgIHNiX2NmZyA9IGl3bF9y
ZWFkX3VtYWNfcHJwaChtdm0tPnRyYW5zLCBTQl9NT0RJRllfQ0ZHX0ZMQUcpOwo+IMKgIDE0NzDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEoc2JfY2ZnICYgU0JfQ0ZHX1JFU0lERVNfSU5fT1RQX01B
U0spICYmIGl3bF9tZWlfcGxkcl9yZXEoKSkKPiDCoCAxNDcxwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+IAo+IFByb2JhYmx5IHJldHVybiAtRUlOVkFMIHdh
cyBpbnRlbmRlZC7CoCAoVGhpcyBjb2RlIGFjdHVhbGx5IGluc3BpcmVkIG1lCj4gdG8gY3JlYXRl
IHRoaXMgc3RhdGljIGNoZWNrZXIgd2FybmluZy7CoCA7KSBTbyBpdCBoYXNuJ3QgYmVlbiB0ZXN0
ZWQgeWV0Lgo+IFdpbGwgdGVzdCB0b25pZ2h0LsKgIEdvdHRhIHJ1biB0aG91Z2guLi4pCj4gCj4g
wqAgMTQ3MsKgIAo+IMKgIDE0NzPCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gaXdsX212bV9sb2Fk
X3J0X2Z3KG12bSk7Cj4gwqAgMTQ3NMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7Cj4gCj4g
cmVnYXJkcywKPiBkYW4gY2FycGVudGVyCgpXZSBoYXZlIGEgZml4IGluIG91ciBpbnRlcm5hbCB0
cmVlLCB3aWxsIHNlbmQgaXQgdGhpcyB3ZWVrLgoKVGhhbmtzLApHcmVnb3J5Cgo=
