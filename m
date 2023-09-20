Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9284C7A8684
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjITO2G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 10:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjITO2F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 10:28:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3892CAF
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695220079; x=1726756079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rn2DyzlFRCYI5oWBSoxcZd6Y2/gYhxlrd6QdAFmxd38=;
  b=iHqiYROlWoqbNjeqcIlkxV7MgyRBZOw6gJaLWofX0huNKfOmqANqpLYD
   KoQjKOFsuGj3qHNB8vkunK8SAm3vJ++weAvqPBipDnnDWRR1eEqJDeZYO
   E/mdUOZk6Mcvezbd6eoHPeFDLafTjGfnEqqkJSQoG1Oyd+jpkrCACojLJ
   vXXL7FaxB5YVhqamRQwgSXccGtHRV3EKEETYlM7ssJq+7sy8JKjYoCULi
   LnuOTchNmtYEYc+yx989WPgP2l5uD6SdeSVST/tqRRB4lvxASlET0TClf
   z/Cncu1WtZONdHAmYLrMkU1nl493HkZxMmf5EwkqKUwQZzBDBFjEEgmWt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="365290178"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="365290178"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 07:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="816926164"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="816926164"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 07:27:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 07:27:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 07:27:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 07:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOc1DR/WCzmOOn/qnsplZj2MjWL6XEUkIE1GCl2KKxYVz66qCOcVp19f0UoyEOZtSthMPacICSvxDEwPnFXqxxqzZvRS/h7UNIKVZPR3jMYMvvC06JPxtLa59uGFO3WccF1xB3KcJ6TumMDw8f1k8DEayNoQURq00Ezgi9QK3EJV+Z/WI4W3nHUR+8hrWp0cRoao8sV4xZqKuIh6O01a8J763I/+QU/NVfyaUxwfERmEnFHGqufvedp1pgN67wjTvMmnafmXmhLI5nNfzibXYq2WfQMmAsoUbznXj9CTcgvv8K2xXVwJcWK9DphvnykcTt+UaEKWAaaa23abLWGE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn2DyzlFRCYI5oWBSoxcZd6Y2/gYhxlrd6QdAFmxd38=;
 b=Oxp+HGNcKgznCwlHsq6XcwYeaGt63kuEbyHU3+4SxbVJUgAh4AvPnn2lmv09dsVIrE7a8lhdB0dX8G01DROmTgSseL6w3HG2l6+jtoAOpMeN6TKTkw9v+r9Z8bNGPsC7aPtpQxRkYX+WjN2BPoJJ2UyWSlGg+Ie68WusSsLnKJeh6ofNyHhZmttIgte/5ngIqvi8s+rxdWw+Zdf4rK7ffWAAgvNakXeVf3c+I2ZX4v56uMdEUwMtJ8SVHU+o7HTiuZK7/z3c00KzdGhy8elD6CFGm3U78c/N+tB64D1mDbsRJnOguyx64e5g6tcadTx/Hxsa/+kOW7aNFAUBzz9ZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by CY8PR11MB7034.namprd11.prod.outlook.com (2603:10b6:930:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 14:27:37 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::fe36:eb09:813b:5e01%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 14:27:36 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Beker, Ayala" <ayala.beker@intel.com>
Subject: Re: [PATCH 13/18] wifi: mac80211: add support for parsing TID to Link
 mapping element
Thread-Topic: [PATCH 13/18] wifi: mac80211: add support for parsing TID to
 Link mapping element
Thread-Index: AQHZ6iD8ok2K1BEKDkO8kCw99HL22LAhD+iAgAK5CIA=
Date:   Wed, 20 Sep 2023 14:27:36 +0000
Message-ID: <0bd89217fc2e74561f7980403f2262a12828dec9.camel@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
         <20230918140607.5398d9c5df2a.I2281ab2c70e8b43a39032dc115db6a80f1f0b3f4@changeid>
         <9d46505f-7df7-40c6-8a9a-203e6687b713@quicinc.com>
In-Reply-To: <9d46505f-7df7-40c6-8a9a-203e6687b713@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|CY8PR11MB7034:EE_
x-ms-office365-filtering-correlation-id: 70418cb5-2ea5-4b58-7954-08dbb9e5bcd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oyY1aQW6YjPcGa0JS8+mtLuRhF6q3+2NEL3xn58yz9oo3unhdw9YFQQkGFyRvtZlFt/dx+B9om2GIF3jo1box+U5mJgI3GkkPz7T2z8tYFNkN1EvocBqyRhO1OqjO+XG+jQjCIesD3yVjXBMF9WKgcsvW/JIIPbPMbVIwjEzrP12F5s/3M2uh4Hi8/tNoTYqrL31JNh4y46tNe1rIS8KztzjxaVWltDw7QTbDbNjtIBfZmcXqWska3NkZsS8SXv/dHQsb98IG/MlTsK5913zJZC6ksDCZLzInPjwu/E0FGMWSnzuHE6fTjWHfMwZSpr3xA4W9Y5Tc/xo7CMLJ1tO2mRwMBFm3GwoCZrqAi1N6UNpfAvEWBYbdvzzdjIv2v/6ofVw70OW9Z92MTNwY1u5Qe3Ok0oYPUo96Hqc9fyWcgPi0PsnOkkzpLlkqY6+qkm+ycVUhZy8ZmwvbA3TLMybvi3VjsUDiOX36iAnE2IrQNY1ww2WFGYUVHL2ukY9DAqi2PsDEAFXG1ugWi1jXu1ht4oV2cySvRM1GqAV94bBWgwuiuTCvluC7QTh8i2g9OlDTQvF9EHgMLMp3JHz3brrAwXw3Fa4+JaU3LrWEV6JpaFfER70zQEzQSxt1TbuZ/P0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(186009)(451199024)(1800799009)(6512007)(53546011)(71200400001)(6486002)(6506007)(122000001)(86362001)(36756003)(82960400001)(38100700002)(38070700005)(26005)(107886003)(2616005)(2906002)(478600001)(5660300002)(8936002)(4326008)(316002)(66446008)(8676002)(66476007)(66556008)(76116006)(66946007)(110136005)(91956017)(64756008)(54906003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1ZXUFJBMi9nNkp5YzBJMU5TVTNEREwrVTZoVHpXaW9keTlnMVZqdVgxaFk3?=
 =?utf-8?B?eWI2eFVJQ0J4Q1NiaTFaVlpDdFRBOHpLUUs3ZGk0bzg0cGZvUzlOSE9jcXFS?=
 =?utf-8?B?MWdJcnRjMmNBYTNJeEZwRi9LaGRZdklqejQvdk1uK1RrZlIvenNNb0JCQjYv?=
 =?utf-8?B?ZmN3Q1luUDhnVm11bEhocjlFMGNaREhXUlNMUWNYZ29uK0JoQUNtNjV0VnZu?=
 =?utf-8?B?dmhtUzlRL1B6WnhxZmhKc0sweDNCbG1WSTFQbDZDMVNwZ1h2V292Y0hVQ0Zv?=
 =?utf-8?B?ZUp1TWR2c0dlWUJ4ZmM3akJ6enE0S0UyZHZ6VlVqR3BqZGRQRlJjZjNLRzNF?=
 =?utf-8?B?UjMyNnFOeUEzdlMvR2hqQXg0NmdTSnA1dnpQSyt6bFA5a2dnMHdWMkRrSk9X?=
 =?utf-8?B?S2w5SGJ5MTBidnI4RnYvMWNYaFphaVpFSm93Wk5qQlQ4M0lZS3BnbFJxOUJQ?=
 =?utf-8?B?K1pVVk1DM0s5UE5zU08wbWlXeGZCOWFpRTMzUUlLMk5VWmNpQUE2RHRUN0Zl?=
 =?utf-8?B?WHdiM0FxL2hVRTgyQm4zWU9lcjR0aEpCYk02YnVCcUh6bzVNRy81dy8wdVN6?=
 =?utf-8?B?cndkMGtxTm9aeWlVeTBRczlpOEtBK2VneUF3K25zTlJMb1BXYjIxcVFUNk9m?=
 =?utf-8?B?R0dPYk5GYzhXcWxnVGZtMTBrc1lqbjlWcUFSL0JUa0tqeW94RnoyNXgvTlBk?=
 =?utf-8?B?d1BpaXdGRnZRMkdVaWRaWjd0Yis3N2xPUUlWbmNJb2VodG5sZHBzSXFiQlJl?=
 =?utf-8?B?aVE3ZEZDRmwrUElmUUdjVlN6N2ErL2lNWVozamtHTnQ5ZmRYLy8rSzYvbmtH?=
 =?utf-8?B?ZXY1QmRpbDJQWHpLSGFKZzd1bVAxMDFucUx5SkpiRmZGbCtYcG04MHRZVmU1?=
 =?utf-8?B?K1kxVFZSZVZlV3RuQXJXT29WOE9iZUYwTUd0azA3akVxMkE5Njcwd2lqN0t1?=
 =?utf-8?B?UFhJSFBqckNnano3aXd3dmxiQzlDWTRRZlp3OWhLT0VEbnhsa0ZNank0RUt5?=
 =?utf-8?B?N29kT0pBOVUycnMrbXZ2UnBRL3RvUklKTTVnS1YwMTRGclJUZHRJeVBhVndN?=
 =?utf-8?B?ZmptUEhqbkc2eUdtL1dCSGw5M1dyekRHYWNDa3I4WDVQWEVCam1FQmhJOGJC?=
 =?utf-8?B?NjRKZUw4UGcxNSt6M3hGT0NWamFHS3N6UkNsWHMzS1BBeUhycnkrUEJ1TTlu?=
 =?utf-8?B?bUF3cERETTMrbkpuWEw2enJNR1pDUVc2VUpZSUtNRzdhTysyV05CUjdGbjA3?=
 =?utf-8?B?M1cycnkySTgwekNqMW56ODl0cHhoSlk4bmR2d0xSTHBUS3dmVzJOcVZHQ2RK?=
 =?utf-8?B?KzhUenk0WjhxdkFEMTJFbDFIdHhwcWN1MnhFVUJUdGlhRnFvbWJqY2ErTVJV?=
 =?utf-8?B?S21DWXQ1M1pUOHk4WHduSzkvRHFxbXU5ZTRGQ2QwUkY4WFV3KzlqVkJKelRo?=
 =?utf-8?B?SXdLT0xzd241UXpJRCt3dVRIQVp0QS9wRE9kR3ZCblJobStXVzRMUXhvZSto?=
 =?utf-8?B?a1NmVHg4YUtBVEdkUGUyeWZ0QXY2Z2tBOEdYYXorMS8zdkltMEpzcFNhVVhp?=
 =?utf-8?B?U1AxaDIrK0ZpblJuQURuMXh5OHJDWjRqQ1N6cDVNVDIzUnVuS21Na0lWSThF?=
 =?utf-8?B?Q1dEWTI2b2dEcWxHMy9mL21Rb2VRREp2bzV3VkE4Rm9SWmVhb3ltbkxtdnNM?=
 =?utf-8?B?eTh0a2VTKzhlNUE1MFRXcTZrdDZiUnZlaWRwVzZ5ZW5TYjZDVGpvWUU2UWE3?=
 =?utf-8?B?b09ablRQN1dMQktNK3dZR2ZTS05mam9vSVZuWFVOYmhvc1BOalY5TnVYdk9K?=
 =?utf-8?B?VWd2S1Exb2lZMzRWQkZMejVnbU44RDlsRmpqaC9hZTNoSnRkZ3RsbkNkc0F4?=
 =?utf-8?B?dWVXTFNGcm1uOWVNMnlzb2U3NTFKVFhHTzJvbEhjNG4wOVd3RkQ5bWNxUU9U?=
 =?utf-8?B?Q2FEUC9mNkYzZkNTcGRUb2ZrdzBrL2VRUk5Oc1BtQ2ZXelF5Z1hVcFh6Tncr?=
 =?utf-8?B?RWp6RE1aTCtTT2Q2YmkwazdvK29EY3V4dlZIMEtJNVhwM01rMmwvL1pYTE45?=
 =?utf-8?B?eDJBMndGQnVZRlNsaWpEeEhteHdYd1diWDl1RllleEltS0V5UmhwT2t3TzRj?=
 =?utf-8?B?UDNqRzFnU3hia2Qza3ZXWFVGaGlDUE43bkdobnlNaUROV2VsT3FFZlMwd2RQ?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B5E0ABDF23BBF4E88D6C6C6F4FAB7A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70418cb5-2ea5-4b58-7954-08dbb9e5bcd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 14:27:36.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxOB70MjN2qJVtw0AxjqT3VMkMVuOnvtKJbpkV6/bdR/N5aXbVt5cD5u6F7S7SW/TVzNfSVB0A5h67nzWopJthb2ko/WAMqR0VCB12VW9vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7034
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTE4IGF0IDEzOjUyIC0wNzAwLCBKZWZmIEpvaG5zb24gd3JvdGU6Cj4g
T24gOS8xOC8yMDIzIDQ6MTAgQU0sIGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29twqB3cm90ZToK
PiA+IEZyb206IEF5YWxhIEJla2VyIDxheWFsYS5iZWtlckBpbnRlbC5jb20+Cj4gPiAKPiA+IEFk
ZCB0aGUgcmVsZXZhbnQgZGVmaW5pdGlvbnMgZm9yIFRJRCB0byBMaW5rIG1hcHBpbmcgZWxlbWVu
dAo+ID4gYWNjb3JkaW5nIHRvIHRoZSBQODAyLjExYmVfRDMuMC4KPiAKPiBJcyB0aGVyZSBhIHJl
YXNvbiB0byBub3QgcmVmZXJlbmNlIERyYWZ0IDQgc2luY2UgaXQgaXMgdGhlIG1vc3QgcmVjZW50
Pwo+IAo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBBeWFsYSBCZWtlciA8YXlhbGEuYmVrZXJAaW50
ZWwuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogR3JlZ29yeSBHcmVlbm1hbiA8Z3JlZ29yeS5ncmVl
bm1hbkBpbnRlbC5jb20+Cj4gPiAtLS0KPiA+IMKgIGluY2x1ZGUvbGludXgvaWVlZTgwMjExLmjC
oCB8IDUxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiDCoCBuZXQv
bWFjODAyMTEvaWVlZTgwMjExX2kuaCB8wqAgMyArKysKPiA+IMKgIG5ldC9tYWM4MDIxMS91dGls
LmPCoMKgwqDCoMKgwqDCoCB8wqAgOCArKysrKysKPiA+IMKgIDMgZmlsZXMgY2hhbmdlZCwgNjIg
aW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pZWVlODAy
MTEuaCBiL2luY2x1ZGUvbGludXgvaWVlZTgwMjExLmgKPiA+IGluZGV4IGYxMWI3MDIyZDllYi4u
NmU4OTEzZGJiZmY2IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9pZWVlODAyMTEuaAo+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9pZWVlODAyMTEuaAo+ID4gQEAgLTEyNDYsNiArMTI0Niwy
MyBAQCBzdHJ1Y3QgaWVlZTgwMjExX3R3dF9zZXR1cCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdTgg
cGFyYW1zW107Cj4gPiDCoCB9IF9fcGFja2VkOwo+ID4gwqAgCj4gPiArI2RlZmluZSBJRUVFODAy
MTFfVDJMX01BUF9NQVhfQ05UwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAyCj4gCj4gaXMgdGhlcmUgYSByZWFzb24gdG8gbm90IHVzZSB0aGUgc2FtZSBUVExNIGFi
YnJldmlhdGlvbiB0aGF0IGlzIHVzZWQgYnkKPiB0aGUgZHJhZnQ/IHBsZWFzZSBjb25zaWRlciBh
IGdsb2JhbCBzL3QybF9tYXAvdHRsbS8KPiAKPiA+ICsjZGVmaW5lIElFRUU4MDIxMV9UMkxfTUFQ
X0NPTlRST0xfRElSRUNUSU9OwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgwMwo+ID4gKyNkZWZp
bmUgSUVFRTgwMjExX1QyTF9NQVBfQ09OVFJPTF9ERUZfTElOS19NQVDCoMKgwqDCoMKgwqDCoMKg
wqAweDA0Cj4gPiArI2RlZmluZSBJRUVFODAyMTFfVDJMX01BUF9DT05UUk9MX1NXSVRDSF9USU1F
X1BSRVNFTlTCoMKgMHgwOAo+ID4gKyNkZWZpbmUgSUVFRTgwMjExX1QyTF9NQVBfQ09OVFJPTF9F
WFBFQ1RFRF9EVVJfUFJFU0VOVMKgMHgxMAo+ID4gKyNkZWZpbmUgSUVFRTgwMjExX1QyTF9NQVBf
Q09OVFJPTF9MSU5LX01BUF9TSVpFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAweDIw
Cj4gPiArCj4gPiArI2RlZmluZSBJRUVFODAyMTFfVDJMX01BUF9ESVJFQ1RJT05fRE9XTsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDAKPiA+ICsjZGVmaW5lIElFRUU4MDIxMV9UMkxfTUFQ
X0RJUkVDVElPTl9VUMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAxCj4gPiArI2Rl
ZmluZSBJRUVFODAyMTFfVDJMX01BUF9ESVJFQ1RJT05fQk9USMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoDIKPiA+ICsKPiA+ICtzdHJ1Y3QgaWVlZTgwMjExX3QybF9tYXBfZWxlbSB7Cj4g
Cj4gcGVyaGFwcyBhZGQga2VybmVsLWRvYywgYW5kIGRvY3VtZW50IHRoZSBzcGVjIHJlZmVyZW5j
ZSwgd2hpY2ggaW4gRDQgaXMgCj4gOS40LjIuMzE0IFRJRC1Uby1MaW5rIE1hcHBpbmcgZWxlbWVu
dAo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgLyogdGhlIHNlY29uZCBwYXJ0IG9mIGNvbnRyb2wgZmll
bGQgaXMgaW4gb3B0aW9uYWxbXSAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgdTggY29udHJvbDsKPiA+
ICvCoMKgwqDCoMKgwqDCoHU4IG9wdGlvbmFsW107Cj4gPiArfSBfX3BhY2tlZDsKPiA+ICsKPiA+
IMKgIHN0cnVjdCBpZWVlODAyMTFfbWdtdCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgX19sZTE2IGZy
YW1lX2NvbnRyb2w7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgX19sZTE2IGR1cmF0aW9uOwo+ID4gQEAg
LTM2MTgsNiArMzYzNSw3IEBAIGVudW0gaWVlZTgwMjExX2VpZF9leHQgewo+ID4gwqDCoMKgwqDC
oMKgwqDCoFdMQU5fRUlEX0VYVF9FSFRfT1BFUkFUSU9OID0gMTA2LAo+ID4gwqDCoMKgwqDCoMKg
wqDCoFdMQU5fRUlEX0VYVF9FSFRfTVVMVElfTElOSyA9IDEwNywKPiA+IMKgwqDCoMKgwqDCoMKg
wqBXTEFOX0VJRF9FWFRfRUhUX0NBUEFCSUxJVFkgPSAxMDgsCj4gPiArwqDCoMKgwqDCoMKgwqBX
TEFOX0VJRF9FWFRfVElEX1RPX0xJTktfTUFQUElORyA9IDEwOSwKPiA+IMKgwqDCoMKgwqDCoMKg
wqBXTEFOX0VJRF9FWFRfQkFORFdJRFRIX0lORElDQVRJT04gPSAxMzUsCj4gPiDCoCB9Owo+ID4g
wqAgCj4gPiBAQCAtNTE1NSw2ICs1MTczLDM5IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpZWVlODAy
MTFfbWxlX3JlY29uZl9zdGFfcHJvZl9zaXplX29rKGNvbnN0IHU4ICpkYXRhLAo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmaXhlZCArIHByb2YtPnN0YV9pbmZvX2xlbiAtIDEgPD0g
bGVuOwo+ID4gwqAgfQo+ID4gwqAgCj4gPiArc3RhdGljIGlubGluZSBib29sIGllZWU4MDIxMV90
aWRfdG9fbGlua19tYXBfc2l6ZV9vayhjb25zdCB1OCAqZGF0YSwgc2l6ZV90IGxlbikKPiA+ICt7
Cj4gPiArwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX3QybF9tYXBfZWxlbSAq
dDJsID0gKGNvbnN0IHZvaWQgKilkYXRhOwo+ID4gK8KgwqDCoMKgwqDCoMKgdTggY29udHJvbCwg
Zml4ZWQgPSBzaXplb2YoKnQybCksIGVsZW1fbGVuID0gMDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChsZW4gPCBmaXhlZCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gZmFsc2U7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBjb250cm9sID0gdDJsLT5jb250
cm9sOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGNvbnRyb2wgJiBJRUVFODAyMTFfVDJM
X01BUF9DT05UUk9MX1NXSVRDSF9USU1FX1BSRVNFTlQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZWxlbV9sZW4gKz0gMjsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChjb250cm9s
ICYgSUVFRTgwMjExX1QyTF9NQVBfQ09OVFJPTF9FWFBFQ1RFRF9EVVJfUFJFU0VOVCkKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbGVtX2xlbiArPSAzOwo+ID4gKwo+ID4gK8Kg
wqDCoMKgwqDCoMKgaWYgKCEoY29udHJvbCAmIElFRUU4MDIxMV9UMkxfTUFQX0NPTlRST0xfREVG
X0xJTktfTUFQKSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHU4IGJtX3Np
emU7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxlbV9sZW4gKz0g
MTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobGVuIDwgZml4ZWQgKyBl
bGVtX2xlbikKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIGZhbHNlOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChjb250cm9sICYgSUVFRTgwMjExX1QyTF9NQVBfQ09OVFJPTF9MSU5LX01BUF9TSVpFKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBibV9zaXpl
ID0gMTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbHNlCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJtX3NpemUgPSAyOwo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsZW1fbGVuICs9IGh3ZWlnaHQ4
KHQybC0+b3B0aW9uYWxbMF0pICogYm1fc2l6ZTsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICsK
PiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBsZW4gPj0gZml4ZWQgKyBlbGVtX2xlbjsKPiA+ICt9
Cj4gPiArCj4gPiDCoCAjZGVmaW5lIGZvcl9lYWNoX21sZV9zdWJlbGVtZW50KF9lbGVtLCBfZGF0
YSwgX2xlbinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiA+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoaWVlZTgwMjExX21sZV9zaXplX29rKF9kYXRhLCBfbGVuKSnCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZm9yX2VhY2hfZWxlbWVudChfZWxlbSzCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBc
Cj4gPiBkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjExL2llZWU4MDIxMV9pLmggYi9uZXQvbWFjODAy
MTEvaWVlZTgwMjExX2kuaAo+ID4gaW5kZXggNmM1NmVjNDJkZGU5Li5mZGU5NTZmOGE5MzkgMTAw
NjQ0Cj4gPiAtLS0gYS9uZXQvbWFjODAyMTEvaWVlZTgwMjExX2kuaAo+ID4gKysrIGIvbmV0L21h
YzgwMjExL2llZWU4MDIxMV9pLmgKPiA+IEBAIC0xNjc4LDYgKzE2NzgsNyBAQCBzdHJ1Y3QgaWVl
ZTgwMl8xMV9lbGVtcyB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGllZWU4MDIx
MV9tdWx0aV9saW5rX2VsZW0gKm1sX2Jhc2ljOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0
cnVjdCBpZWVlODAyMTFfbXVsdGlfbGlua19lbGVtICptbF9yZWNvbmY7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgY29uc3Qgc3RydWN0IGllZWU4MDIxMV9iYW5kd2lkdGhfaW5kaWNhdGlvbiAqYmFuZHdp
ZHRoX2luZGljYXRpb247Cj4gPiArwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgaWVlZTgwMjEx
X3QybF9tYXBfZWxlbSAqdDJsX21hcFtJRUVFODAyMTFfVDJMX01BUF9NQVhfQ05UXTsKPiA+IMKg
IAo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIGxlbmd0aCBvZiB0aGVtLCByZXNwZWN0aXZlbHkgKi8K
PiA+IMKgwqDCoMKgwqDCoMKgwqB1OCBleHRfY2FwYWJfbGVuOwo+ID4gQEAgLTE3MTEsNiArMTcx
Miw4IEBAIHN0cnVjdCBpZWVlODAyXzExX2VsZW1zIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqAvKiBU
aGUgcmVjb25maWd1cmF0aW9uIE11bHRpLUxpbmsgZWxlbWVudCBpbiB0aGUgb3JpZ2luYWwgSUVz
ICovCj4gPiDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGVsZW1lbnQgKm1sX3JlY29uZl9l
bGVtOwo+ID4gwqAgCj4gPiArwqDCoMKgwqDCoMKgwqB1OCB0MmxfbWFwX251bTsKPiA+ICsKPiA+
IMKgwqDCoMKgwqDCoMKgwqAvKgo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIHN0b3JlIHRoZSBwZXIg
c3RhdGlvbiBwcm9maWxlIHBvaW50ZXIgYW5kIGxlbmd0aCBpbiBjYXNlIHRoYXQgdGhlCj4gPiDC
oMKgwqDCoMKgwqDCoMKgICogcGFyc2luZyBhbHNvIGhhbmRsZWQgTXVsdGktTGluayBlbGVtZW50
IHBhcnNpbmcgZm9yIGEgc3BlY2lmaWMgbGluawo+ID4gZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIx
MS91dGlsLmMgYi9uZXQvbWFjODAyMTEvdXRpbC5jCj4gPiBpbmRleCA5N2M1ODIzZGEwZWIuLjY0
OGQ0Yjg4M2Q0MyAxMDA2NDQKPiA+IC0tLSBhL25ldC9tYWM4MDIxMS91dGlsLmMKPiA+ICsrKyBi
L25ldC9tYWM4MDIxMS91dGlsLmMKPiA+IEBAIC05OTUsNiArOTk1LDE0IEBAIGllZWU4MDIxMV9w
YXJzZV9leHRlbnNpb25fZWxlbWVudCh1MzIgKmNyYywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsZW1zLT5iYW5kd2lkdGhfaW5kaWNhdGlvbiA9
IGRhdGE7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhbGNfY3JjID0gdHJ1
ZTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiArwqDCoMKg
wqDCoMKgwqBjYXNlIFdMQU5fRUlEX0VYVF9USURfVE9fTElOS19NQVBQSU5HOgo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhbGNfY3JjID0gdHJ1ZTsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaWVlZTgwMjExX3RpZF90b19saW5rX21hcF9zaXplX29r
KGRhdGEsIGxlbikgJiYKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZWxlbXMtPnQybF9tYXBfbnVtIDwgQVJSQVlfU0laRShlbGVtcy0+dDJsX21hcCkpIHsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxlbXMtPnQybF9t
YXBbZWxlbXMtPnQybF9tYXBfbnVtXSA9ICh2b2lkICopZGF0YTsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxlbXMtPnQybF9tYXBfbnVtKys7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgIAo+ID4gwqDC
oMKgwqDCoMKgwqDCoGlmIChjcmMgJiYgY2FsY19jcmMpCj4gClRoYW5rcyBmb3IgdGhlIGNvbW1l
bnRzLCB3aWxsIHNlbmQgYSBmaXhlZCB2ZXJzaW9uIHNob3J0bHkuCg==
