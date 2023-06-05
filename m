Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1F172259C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 14:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjFEMZ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 08:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjFEMZT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 08:25:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90A7E8;
        Mon,  5 Jun 2023 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685967917; x=1717503917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cdtfgcLyGgtPieVP7DTUGDEKQgCIGV+IoH2T8YUkuok=;
  b=lq3+bHlR5V9TRRaMchIl8CXT6/fqyLqfXmctBDN0cNKd9DJkjBgxg0zf
   XdroMtz4w/bvBqdhhES+k7TMBnLsFdA56Mbuo8OAcaW1f0vBIK7+D+6Gf
   AjCDW6h9BBnVlXhMgikJ7uJjDuWNhc+zX7MqZvfjYl+AE0V76BZs3e5eg
   rxwerWY/NlKIFepsSkk0zE1FsGA+PGs2fD1b3fD/Xm5eRQ5IeZWPgjZC8
   urPCPhvxLGEX64t6eFF+ADi8d9Lvd3LJ3S6JwgAJ8CHvw69ckvJlaMJ8u
   TxD1vONvFzeDmmauJYUHW65uLINrxQIHX2/A6WxbNujQGmHgebbd0Elb9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="340990546"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="340990546"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 05:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="686096475"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="686096475"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2023 05:25:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 05:25:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 05:25:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 05:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM0WIfGvSLowCy83aZmNr/Ulc6cbdCeZvvPIdfgmmqrnovraM3nY/AOV+qo+EKpT9hu1NOfhFhFy3f+kC7KAftyfC+dW8WCLen/TJnUzG8ikBls1KplnZpqWvXw4UFHAzSPdcsnPV8c+8IgNaBrLQC+vWuEGm4U3jIAnxc88J6VEp3mmA6b5ivKVvd++jPfnUIBu7DFDUM6ue3+KdLfjDmR/Z3sq6N7EO1CjjI5sqPa5pm9cKRmSOgxBUhLtC7l2Md7gYbetHVCV4idqKxcnuU/0z3eyUmGBfSw+nb+1eBYXIQBEbB0R+TFw1V0Txs9AtO+9xJVmMMCDU6gtk89HGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdtfgcLyGgtPieVP7DTUGDEKQgCIGV+IoH2T8YUkuok=;
 b=bI53n7P7AIUaXTgrGSNuQ9r2viKtaUCpEe7ijyBZ1CznFY2BfrqdR/l29BgkinpBfwB+wZZ9WmacVBAMTA+ww7b0YEyjRNX/MSRNMjCM+9m/XXlwt90xSzn1rGTDLRrKC7x4+dYeI38bbcRECp/+eRY99jokwHWE+PAxBb/SjKXZ6kTQBIAl1YG1aONybA0wM8MpOmb4E78tNtKAztWsipxZpLHbcertNV9hMQntRUg8T8O56CSCjmxuZU1pU1+Iz7zbqj727R3oMa63k271Y2miPjuWzm7m2an8sHErk2KQOySm1VQ1V8mrxXwpAOv8xHtgEqtGaLDsDM0FVtu7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 12:25:14 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::a549:be63:2844:ca7e]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::a549:be63:2844:ca7e%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 12:25:14 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "inux-kernel@vger.kernel.org" <inux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: iwlwifi: bump FW API to 78 for AX devices
Thread-Topic: [PATCH] wifi: iwlwifi: bump FW API to 78 for AX devices
Thread-Index: AQHZlJYGjAuFrX9qtE24y1vglk8tpq92GzYAgAAb5QCABfFFAA==
Date:   Mon, 5 Jun 2023 12:25:13 +0000
Message-ID: <d290865bbfec91ee56280b409f9c62b89e80a6d0.camel@intel.com>
References: <f7e417e0-5277-4085-bb50-fb43bdc52f7a@roeck-us.net>
         <1ee34c4b93dc0acb5bd51556ce5f60062b78f970.camel@intel.com>
         <7cc45ce0-e472-5953-bbab-d15cfd96d0fe@roeck-us.net>
In-Reply-To: <7cc45ce0-e472-5953-bbab-d15cfd96d0fe@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM4PR11MB6285:EE_
x-ms-office365-filtering-correlation-id: 5bbc29d8-7bdd-4b1c-5706-08db65bfe9cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZjc1KYG4CvWlqUFZEQMwP2VVQwrEeKxyCwuXkS/gzOZn9sfpQbMTuQe6vq+J2ujVHTh3wlnx/UzcL0zjet3CAlxcUrZUPAvDIOhQ8PJh/nOtmmsM/IopTLafeqpPqopAXg1ubZa8S0UJ08Ue/uLwUNJ7RnTt2Q6ZDzNeZIIogc5QStyAFktBLvrF0+tW40alB0mO5T53zgw8xoZeNKp9yF+d+G+iz4shwX4JoK1zHbYnf8KCnh/suER4+/bF2AromdYagnaVzjCdUKPsjMSQgx433CMsuJiE+rLGfZuaEys1Hevwq+b6BJDWWIQKIrCMZgue5Rtk6Y9RqbUTxnzrIjKqmfRdDDNJXTLPW0OVh+YVI8qdxOLAYbsXQcjD3zSIc14OSZaVF2FlTbZLPgK9eDE1mC/XVpvZbVj7KtrPi9IOfM47/XBFb92QGYRjrM26pgMy2bsWoMGHJqxZaVjFeegwVxVK7ID8URkJLKBBX5QBCZ5fxDKeGFPZWRRYUpQRCZm4le6efxQsSBZBD3S/6rG/UDuF/hGuHjNn8B11igDPQJjd3LeBKRYxqspjoyp3RCSfKeV0aSss6Syu0cpOLMqIZlB92i9yazp+HMUOHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(38070700005)(2906002)(86362001)(5660300002)(83380400001)(71200400001)(6486002)(966005)(186003)(26005)(6506007)(6512007)(53546011)(91956017)(82960400001)(478600001)(54906003)(76116006)(66446008)(6916009)(122000001)(316002)(38100700002)(66476007)(64756008)(4326008)(66946007)(66556008)(2616005)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG5EWnBaVWJCQmc0cWd1dnVqTi9SaVJsV0s1REx0YjRCWkJSaWdaNFZpMkxz?=
 =?utf-8?B?S3FKT3c3U0JKRDJVMkt2bG82ayswSWhjVGpRcGpyQS90R3V2Yk45VHhOaXFM?=
 =?utf-8?B?M1FaU3ZuMFdzdmtPbDdwMkV0L2pEYlRlYXl3UVlNOVJDTHN1SkF0VG5PNUo4?=
 =?utf-8?B?V0hoQ2NYV0IwbW9uZzNmWHR5UkJwTTY2S3UyaWh3WmxMYmhwTGhUWmVlMlIv?=
 =?utf-8?B?TjBMQ3hxbXhDbGxld0M3MVZyUjdzclJpSnhwQVM5Tm1RbGM1WGpsdk56RURM?=
 =?utf-8?B?anh1TjNhbWUvMHJvSExUamhYRVQ1OXJGUUZwN2gwMURPR0pjUGRkUGVYYzBs?=
 =?utf-8?B?dmtQUTB2cGdMU1hMOTJKaFlaaXBRbE8vdzBHdkgzQjZ5RmNrR285YTBmMjJK?=
 =?utf-8?B?Z2dENHZwU1ZueURIVEZDMHlUV3lxRUNDV0VVckQ2cDdxdVk3VjZEdDJHSHha?=
 =?utf-8?B?dldMc2tRQmhxWlBPRVUvSjB0MDR1T1JVaU5kalVXSWdWVVNTa2JEamFZS2ti?=
 =?utf-8?B?YVVVelNqb2RPRFpDVEdBNmNLMUw3ZjlXbzU4M1E5S29YQXVEK1lleE5tdXR5?=
 =?utf-8?B?cWxlSkprditRSHNwU215blNtL0RnN3FiUHFJN0djMUhnQWxpQlI2QmdhZjJz?=
 =?utf-8?B?RFd5Q0xwOXR5K0xCaEY0Z2lhVEZwalhwRkRZeG94amRrZHdvNXc1MjhLMlNp?=
 =?utf-8?B?NXFSVDBPektDVVFXaDBMMGJ1UXZmSVpTTE9mclQ4WWk3V3hHbjNDTzNTSEtu?=
 =?utf-8?B?ZmdMbXlIdnVOV2JqY1VIWDJ2VVlWMVBtZDFUSUFzcElPYlFocWpLV0pucjR4?=
 =?utf-8?B?NmliK0piMkVLZzNIUzhsSmJubkdlZDV1RFlIbzZYUGlyVkpkMnp5MHJ1SmMv?=
 =?utf-8?B?U1p5TlRvdzAzaXl4cVA1cDI1RU9BRjVFOUs4WklyVy9JRkoyWXN5NXpsVHZR?=
 =?utf-8?B?eGhuVCtpd2dMYVV0K0xuWk94L3BCRk5BNE9jVmk3OXNGMVJ1UmViNTRjSDBG?=
 =?utf-8?B?eHhGaGNKQWF4UUFsWng2THJpVlpyejIrMzZJajlraGR4UitxdEkwM0RJbzdW?=
 =?utf-8?B?eGZza1JCQkF1QVJrWEFaOUlaZGJnUk15d0dvUERMMWdwdGI4Sm5kd2g3c1ZH?=
 =?utf-8?B?VFBVa0ZoUW5uNEQ2R0Mxa1VXbi92UmkwenVXcVNCeHg1NlNaVkVNTXJsblMw?=
 =?utf-8?B?eGM4Vk5iR01xZzNZaGFYUkxsZ1U0ZDZFZTJ3ZFBtUFlXZWpEVkR3VVU0V3o1?=
 =?utf-8?B?NGhDb0pMVWVLSlJRdDIwRzJVa0ZmakM1a3llM1lSNllFbTcvNnYzMTdJUEI2?=
 =?utf-8?B?QlplOS95S21jWmRVdzRCTFdnOFZtZHFMNDZhV2xhaktkZ3dZV1YzaG9HaGh4?=
 =?utf-8?B?aWhReW5TbHpldHh4RFZvTjZmZHM4UTAxOHMzQytJRXRCNXZpRHRDYWFEemlS?=
 =?utf-8?B?UG9RWERaM0NyQWtEbjM4UTc0anZ3VGhBWURCRTZhR0J2VlJzSnhXdnJWcUhE?=
 =?utf-8?B?ZTUvbmVXcWxzS1NINHRlTlEzZm96OG5nN2FnUmc3WUI5N21Dc0VwTkYrK20r?=
 =?utf-8?B?QVU3WE55TCtKemk0Ti9tRWRvbmpzbHBGTU54akFUVVg3RXFLbDNRc1dMVEZj?=
 =?utf-8?B?a2pCa0p4Ui8zTjM2KzRnbDh4eWR6OTBSR2hXVUdubzNBZU5acjFJeFR3NC9Q?=
 =?utf-8?B?bFdxL2pjMitEU25XT2VYTU9kUU9LR09WTWxwNGg5RHoyWWhhRXJNVlFkbGlB?=
 =?utf-8?B?YmV0UE1JaFNvV2hzSlN5emQvQUpNYmtmc1JtMGpINDBIZFJtQUFZWFArSzg2?=
 =?utf-8?B?YVJpUkljUmdkbVdnNVBPdWVsSHVXVWUwdnJlYVczYUkvU0ZXMGZlNk9hVDlw?=
 =?utf-8?B?VmtHSzBKZFNQdXA0cGhKUmJvaUVFdS84ZE8rWGt4OUU3ZUN5S00xNVZ1TjlB?=
 =?utf-8?B?QkowU1BLVzhnd0p2QUdJZ25EQzljSnpPOXI3WW9PNkV1MkJjVkVibTJNelBy?=
 =?utf-8?B?RDhPcjRGS3MxZ2pIeWNwMzJ5aEdrdEJZS2ovQ3V2aFpIMjFVTTFzeGxEeFoz?=
 =?utf-8?B?NTZ1Zjd5aTlub2hSUDdSR2N6YmZLTVJ1dVZRbjlpUDk4cCtTY1E4emlyMkdH?=
 =?utf-8?B?QU5keko3anZEelUydER1ZFNvVVdwRDhsMlNuVDk4UVpscklFUzB4eWhZbmxu?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4470B6F37409594D87B0DDCD91A65437@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbc29d8-7bdd-4b1c-5706-08db65bfe9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 12:25:13.8631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRMd2aNVZYCG+l6lX3W9Kle9S6Az4CaNOAcaZubDfA764Jadk48eyAb2BaK4Kw09pq7lKb2efl9kS8ddwx9Gebl9R8wJCP3Y0zQxuWV3XHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDEwOjQwIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiA2LzEvMjMgMDk6MDAsIEdyZWVubWFuLCBHcmVnb3J5IHdyb3RlOg0KPiA+IEhpLA0KPiA+
IA0KPiA+IE9uIFRodSwgMjAyMy0wNi0wMSBhdCAwNzozMyAtMDcwMCwgR3VlbnRlciBSb2VjayB3
cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBPbiBNb24sIEFwciAxNywgMjAyMyBhdCAx
MTo0MTozNEFNICswMzAwLCBHcmVnb3J5IEdyZWVubWFuIHdyb3RlOg0KPiA+ID4gPiBTdGFydCBz
dXBwb3J0aW5nIEFQSSB2ZXJzaW9uIDc4IGZvciBBWCBkZXZpY2VzLg0KPiA+ID4gPiANCj4gPiA+
IA0KPiA+ID4gVGhpcyBwYXRjaCBzZXRzIHRoZSB1Y29kZSB2ZXJzaW9uIGZvciBhIGxhcmdlIG51
bWJlciBvZiBkZXZpY2VzDQo+ID4gPiB0byA3OCwgYnV0IHVjb2RlIHZlcnNpb24gNzggaXMgbm90
IGF2YWlsYWJsZSBmb3IgbWFueSBvZiB0aG9zZQ0KPiA+ID4gaW4gbGludXgtZmlybXdhcmUuIEl0
IHNlZW1zIHRoYXQgLjc4IHdhcyBza2lwcGVkIGZvciBzb21lIGRldmljZXMNCj4gPiA+IGluIGxp
bnV4LWZpcm13YXJlLCBhbmQgdGhlIGxhc3QgdmVyc2lvbiBmb3Igc2V2ZXJhbCBvdGhlcnMgaXMg
Ljc3Lg0KPiA+ID4gDQo+ID4gPiBUaGlzIGNhdXNlcyBwcm9ibGVtcyB3aGVuIHRyeWluZyB0byB2
YWxpZGF0ZSBpZiB0aGUgZmlybXdhcmUNCj4gPiA+IGxpc3RlZCBpbiBNT0RVTEVfRklSTVdBUkUg
YWN0dWFsbHkgZXhpc3RzLg0KPiA+ID4gDQo+ID4gPiBJcyB0aGUgbWlzc2luZyBmaXJtd2FyZSBn
b2luZyB0byBiZSBhdmFpbGFibGUgYXQgc29tZSBwb2ludCwNCj4gPiA+IGlzIHRoZXJlIGEgcGxh
biB0byBmaXggdGhlIGNvZGUgdG8gb25seSBsaXN0IGFjdHVhbGx5IGF2YWlsYWJsZQ0KPiA+ID4g
ZmlybXdhcmUsIG9yIGlzIGl0IGEgd3JvbmcgYXNzdW1wdGlvbiB0byBleHBlY3QgdGhhdCB0aGUN
Cj4gPiA+IGZpcm13YXJlIGxpc3RlZCBpbiB0aGUga2VybmVsIGFjdHVhbGx5IGV4aXN0cyA/DQo+
ID4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IEd1ZW50ZXINCj4gPiA+IA0KPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBHcmVnb3J5IEdyZWVubWFuIDxncmVnb3J5LmdyZWVubWFuQGludGVsLmNvbT4N
Cj4gPiA+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDQxNzExMzY0OC41
YTRkY2JmNWEyYzEuSTEyNTgwODU2NmZlODkyZWUwODY1ZTM5MmJmMWIxODcyZGFhZmU4YWRAY2hh
bmdlaWQNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXMuYmVy
Z0BpbnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoMKgZHJpdmVycy9uZXQvd2lyZWxl
c3MvaW50ZWwvaXdsd2lmaS9jZmcvMjIwMDAuYyB8IDIgKy0NCj4gPiA+ID4gwqDCoDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiANCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnLzIyMDAw
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy8yMjAwMC5jDQo+ID4g
PiA+IGluZGV4IGI5OGYwZmYwMjM2Mi4uNTMyZDE0ZjYxMjUzIDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy8yMjAwMC5jDQo+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnLzIyMDAwLmMNCj4g
PiA+ID4gQEAgLTEwLDcgKzEwLDcgQEANCj4gPiA+ID4gwqDCoCNpbmNsdWRlICJmdy9hcGkvdHhx
LmgiDQo+ID4gPiA+IMKgIA0KPiA+ID4gPiDCoMKgLyogSGlnaGVzdCBmaXJtd2FyZSBBUEkgdmVy
c2lvbiBzdXBwb3J0ZWQgKi8NCj4gPiA+ID4gLSNkZWZpbmUgSVdMXzIyMDAwX1VDT0RFX0FQSV9N
QVjCoMKgwqDCoMKgwqDCoMKgNzcNCj4gPiA+ID4gKyNkZWZpbmUgSVdMXzIyMDAwX1VDT0RFX0FQ
SV9NQVjCoMKgwqDCoMKgwqDCoMKgNzgNCj4gPiA+ID4gwqAgDQo+ID4gPiA+IMKgwqAvKiBMb3dl
c3QgZmlybXdhcmUgQVBJIHZlcnNpb24gc3VwcG9ydGVkICovDQo+ID4gPiA+IMKgwqAjZGVmaW5l
IElXTF8yMjAwMF9VQ09ERV9BUElfTUlOwqDCoMKgwqDCoMKgwqDCoDM5DQo+ID4gPiA+IC0tIA0K
PiA+ID4gPiAyLjM5LjINCj4gPiANCj4gPiBZZXMsIEknbGwgc2VuZCBpdCBqdXN0IGluIGNvdXBs
ZSBvZiBkYXlzLg0KPiA+IA0KPiBUaGFua3MhDQo+IA0KPiBHdWVudGVyDQpTb3JyeSwgSSBtaXN1
bmRlcnN0b29kIHdoYXQgeW91IHNhaWQuDQpUaGUgZmlybXdhcmVzIHdoaWNoIHJlbWFpbiB3aXRo
IHZlcnNpb24gLTc3IGFyZSBFT0wsIGFuZCB0aGlzIGlzIHRoZSBmaW5hbA0KdmVyc2lvbiBmb3Ig
dGhlbS4gVGhlIGNvbW1pdCBpbiBbMV0gaGFuZGxlcyBpdCBieSBmcmVlemluZyBtYXhpbXVtIGZp
cm1hcmUNCnZlcnNpb24gZm9yIHRoZSByZWxldmFudCBkZXZpY2VzLiANCg0KWzFdIGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9wYXRjaC8yMDIzMDUw
ODA4MjQzMy4xMzQ5NzMzLTItZ3JlZ29yeS5ncmVlbm1hbkBpbnRlbC5jb20vDQo=
