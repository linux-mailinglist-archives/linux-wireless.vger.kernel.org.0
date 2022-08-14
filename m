Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB0591FD5
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Aug 2022 15:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiHNNF7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Aug 2022 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiHNNF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Aug 2022 09:05:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF48DF56
        for <linux-wireless@vger.kernel.org>; Sun, 14 Aug 2022 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660482357; x=1692018357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fxlM7uXsQXgVFH3CZU8mUwVFuPYYxIjfMMC7mqwzGSg=;
  b=L+ygUw1PKTTlP2jP1sSk2IsI4R/fSthdtEb85k6YiVq7O7ZSTQ96/K2/
   kS6hibQM6z1cpWo1zdHuBYzHpyKHjMxN9jlk5hLyvRCvqDLBAgqL+IEf/
   xorOfYbl7nR2GpsfxoOFNbmv7G8DYPbc5IueD8Qb6eGMjP9yiwOFClC87
   ql+wD9E5ymxLTBEfs34W0gI6EO7awOwDcB6gps7p1Ylr4TVCwdvL3MWWe
   HzX5d7c/X74jESpf6k0vkl60Yw2WGhS8/9eHhzz+YN1UREK5WsF/x33/h
   3/t7/HL3P20/oX9H0EIETuZaVe+mr70W6CzMyMhQCyiyMTGC7xKJMxuTb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292619927"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="292619927"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 06:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="732678597"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2022 06:05:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 06:05:56 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 06:05:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 06:05:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 06:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2/HoAha3X9yFG9ZdB+HQznE2izFloQJtvvRfMVwGvougFfPEmOcWjVPEOM1Sq6TivkhPzrn2i5Mtsu3fb6jr3ae7CMGGRjC3lLLXoTIntj94sdZOXOgjprIi9tJ9joT0SmXIy2MJTvDpu8y7vjfUE6Z5Nui4Lwty2hGhHj91g50Uw/3JWLu7R3M5dtinaLzwQQUPIisNwRcJ0tv3G/oJLcsziLmNw7qC6wEsjrGhFoRfulUBVNeJgOY8otSXXn9XV2ai+L9HeTFaEs/mDrA0pIaIIkDuP86q2W6/xUEr2jfmXHtuD6eAqv6gWahS/NKrP51GVg+Y3fz1qrlDwlUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxlM7uXsQXgVFH3CZU8mUwVFuPYYxIjfMMC7mqwzGSg=;
 b=Jbh4nFU0uyT5ssDL/3a9QawfF6HtdkK49Ccn4fzvp2OPgavju2ZqU+NCW/GX88MqkBdhO/5GmrQDYof+c2anenJ5ls0FIRkl7GmcXJmlPaUNbe5p94xEEkZ6UufctUJvfnCmnUlHpaNAkOjhd0Dv5qhoyHL1hrQTViLXRTSDscyyV47mD4wq5ahvuLMMjPh3J0SnUzlQl4Ea9XWYZvemW4ejtbh0NZv1dDa3+/bZKIFhpXRvHPPdI/I4HYhik7hFFOZ3Gsi5eqiF3GToavux/FKHOX58km9S/KFIjj9QaZbxbvtT2GAiS4s/1sz7/Me/pK/SFeaA5T+ILorv4QS6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Sun, 14 Aug
 2022 13:05:52 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::47e:f523:3214:4517]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::47e:f523:3214:4517%9]) with mapi id 15.20.5525.011; Sun, 14 Aug 2022
 13:05:52 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "mikezackles@gmail.com" <mikezackles@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "tmvolin@gmail.com" <tmvolin@gmail.com>,
        "dennisba@mail.uni-paderborn.de" <dennisba@mail.uni-paderborn.de>
Subject: Re: [PATCH] iwlwifi: Make missed beacon timeout configurable
Thread-Topic: [PATCH] iwlwifi: Make missed beacon timeout configurable
Thread-Index: AQHYpqL46BogpcBXkkKOUZlvEbQYWa2cltRegAC9WoCAERuzAA==
Date:   Sun, 14 Aug 2022 13:05:52 +0000
Message-ID: <d9dc0c00d9ea8bb5b9341a7bcd4a75fc369a7d8f.camel@intel.com>
References: <20220226045047.643695-1-mikezackles@gmail.com>
         <c09a353b-8e52-6d9d-a3c6-743e4e6f444b@mail.uni-paderborn.de>
         <871qtyj6b6.fsf@kernel.org>
         <CAN+PumF3JfmwVh_7BffLza+v7iD58QsxanCvbCrS1ztSt=XjNw@mail.gmail.com>
In-Reply-To: <CAN+PumF3JfmwVh_7BffLza+v7iD58QsxanCvbCrS1ztSt=XjNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa5865bf-c452-4ec5-e73b-08da7df5b74c
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0f7wdX8asTWMBCgzXG7xjpRv8HHtolzo+CunfyZOliUkrdPW1LSjBOhJa45P1zkCKsYSBqidT3ShC4fvcONhgWGZEuVc97yyllCuui6K/gydln7SfoRDhm74ks6IgFIC8STJU4ka/xEOYwGXZeKEkVQMx434tC5wvyCvVs+9PmleCPjB9D+DdPxix5CeBOicIVQLpW0YKpbPssJljtHw6T21XTtAzMxwBhx2dNNsx5A+gOA7BvCXBhI74KaXZIE4aHYYv60Xh6bdOv5eQcl7m12832i0KU4UUTvCzsFX45vKthaSQil2hR61OWFOThKdKCbGQihQda3r+SqC9Oeqq/z0wFLjU2ny0Fgv61DJWzf5AuYa5urQLMwIYSJJ9FaDC6e2UeToZ36YXkmQk3HkFdBsuIDdHfRfXXFGYGSYaXaoWo8pdDLODyvmAIDcAkPuF/SmdhuZjq1ITUYMbWM8/kYbZm3z0Jx2YXc6mMEjTteRf92vW7T4dyGgJi76hXFSSvXgEMeXuPk9fxz8tKdOpitSPUqN6pHAsUzQOty1Wn/QqMmMMmJSZeZxPpu7btkz6DGjhYXhRaehAhe4AZbk/GkswCLf0zLxxr7Koeqqh/U5RabXBzFp0LZzLGXFp6BIFHxeju5kZt3QYvVpVtQAFGuj5reO9KccYJYAUDclq6MIL7eQZXUEUifnbTJkp7tzUIJ1fhMepdk+NS4xSrnaKHK0QLbykSnOZTrTr85StRuoQq3ugu5hc3VxpbsZhoQXRIa6y1nbw/Ryqq0S53C0Uldt3iqki2XsITROoyK7bG3IRtLFCKzJtK98Tn7dI1tfPAD++q8ZrroZA+FJgsz8+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(136003)(366004)(39860400002)(86362001)(2906002)(478600001)(6506007)(26005)(6512007)(41300700001)(6486002)(966005)(66446008)(8676002)(64756008)(66476007)(66556008)(110136005)(36756003)(82960400001)(316002)(71200400001)(54906003)(2616005)(38100700002)(38070700005)(186003)(5660300002)(76116006)(4326008)(66946007)(8936002)(91956017)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dndnUlVmRkVEZWlwSWZCT2QzeC9BTDdxcGpwTTNyK2J1dzJrMlViVFB1TS9k?=
 =?utf-8?B?aWNIa1NTTkhUQWVjTkdOR0syMWZneGg1eUhaSGVMN1hHSUpaS2hYWHhDTXo1?=
 =?utf-8?B?QU9BMG44VGp6R3k0TklEeTlKSmNMbnlWUEpTSFJMeWh5elV3WmVLbEhCYjZT?=
 =?utf-8?B?TnlkUm1LMzBDSUtGdnlZd29qRURWWnYwT3NsZTlQQW9GeGNPWllnZUM5UThz?=
 =?utf-8?B?LzRGMU9kaE9DRm5vcjYyTlRQQkVvT3ZLanNtbTBYUFJmekw0Y2J5RjRQZUNt?=
 =?utf-8?B?bDRRR0xKa2ZNNEQybjdNWWZjZTk2YTIyM3VVZU1mY3ZWMmd1b3JqellSUml4?=
 =?utf-8?B?SjQ0YVZCeWVFcmN6UjB4MmFEL3Y2dFh5T3pTSmRmSHE5NndEdFhYVzZ5RjJv?=
 =?utf-8?B?OE9DTndGZ0YyeU13b21tcGVWbUJRcWhRMTZvZFlGK3BUdkdvc2lRN05tQVhM?=
 =?utf-8?B?WDBFamdSUjIvdEtEWExBMCtZR0xwNnJaUWRub29sdVlvU0RPT2Z6ZGNPYnVt?=
 =?utf-8?B?UjduQ0x2bHlsU2FFSUNiTG5WUHovR1Bmdmx5cnY2RXRXbmo1MGZweUViY1Vi?=
 =?utf-8?B?ZUlsTDZKYkZRQkxxbjdMMzAzdkJicTYrOG5BUGZMNXVMbG8zM1lGdXNId2M5?=
 =?utf-8?B?UEtNODBueHZFU09PckJJZzZXK216bHJiMjQydUVnQWxCV0FTYU1TWXZLUi9Q?=
 =?utf-8?B?YkZEd3MwYm5lY1p0Tm5BcTVJSGxiZ2I1NjVLK1pyWklPRmxtanZ0WjdwNFBR?=
 =?utf-8?B?c2I5cWlCUUkwVUFCRmgvcEVRSUNESkVwWmhPZXlLelJIL0NnWFl1NGhWVVM0?=
 =?utf-8?B?Z0t4YVFuZDhEL0hXeFFFMWtnOFBnT09NNDlNR1JxK3V0c2ltT1prTzJ3Vm1H?=
 =?utf-8?B?R2Z6bXpTZnNXeDZBVUk0VTQvSFE1Y2o2am83R1lDSzRWWHBkYkV3T2dMUDVB?=
 =?utf-8?B?RFVIWE1MeTczZDExTll5Q2VYTnFHWXZ2OXpLd1d0RkdJQjllRlg1YzViVlhJ?=
 =?utf-8?B?bmNOVkpGdllnKzJVZGdmNTMrR1FYengxQ21WRHFLTXpIL2srY1Voc2R3cGxU?=
 =?utf-8?B?YlF3NjdGbFFheXBCWGx5SG16bjZ6SE1wbnhiZi9xVFZUTms0dTRoeTFlVXk5?=
 =?utf-8?B?d1N5NWlZQTI1VzZBYlVWd2xtaFNJQURDMVJwT2V5N1hWMExJUC9qdnlZZTI1?=
 =?utf-8?B?YjlES2NxL2xvYzZLRUVXMWFnaWJMQmhybFpUdkE2Z09LSVpCQXJ6VjlLY0s5?=
 =?utf-8?B?YlpJdUgwaWxOa09rRS9acVYxbEs0ekJXWjMyYVpwUmVkSDVHWHpwQ0xtZnBP?=
 =?utf-8?B?RStiNVVkYS9mOEpWVkhqSDV1WC9FazJrVlhDUllVVHRuN001azhURjRlOWFo?=
 =?utf-8?B?L04wUUFkbzlNcDFISmJ6Nk5rS1ZuakFlUEhaN2N3ckgySXFSb0FNTTVHcGNB?=
 =?utf-8?B?bFlEcXBMdUs4SUs4bjBRWFVhOXY0SXg4c05UaGtYUWNkN3ptcWdyV2ltUmdm?=
 =?utf-8?B?cVVHSyt5VllSbEhQUkR4d3gzMnRXMisxdW9tVjJYeGUrK1g0UVVKVWFzejJZ?=
 =?utf-8?B?N0I4dHN5SnNNVUJQWTFmd3h1UXhhUEdQeWpJVUFmMFpVTjNSSmZYNWlxWk0x?=
 =?utf-8?B?TXJTM3FacWpiamN6N045aExHMWFhSlVEUEc5b0diNjhoUm9MUXlzNEgyMm1m?=
 =?utf-8?B?MTlrOHkvYVVaS05Xd2xuSnlYU0s5d0tqUVozeWNmb2R0bFZmT3F5NnNwN0Rj?=
 =?utf-8?B?R2dScE5CenJzbHkrcE1sT3JDYVdRTncyaENIQWpqZUNkSlVTSWp2S2sxakdo?=
 =?utf-8?B?dzI1d01KMGJ6WUJqY1RtR1dYbEo0d3ZIcWFlckx0SWlqL3JGN1JUa0NkOGxV?=
 =?utf-8?B?WFdrbExrN3dwWmFyUFVXdlVYcmd1ZnZEWmhvdmdSVmZ1alYwNk12UWZORWFk?=
 =?utf-8?B?YndWR0JxbUhFMEprUnpWcC9aRWx6U1BiQjJDN2NJL3hmNjg0TlhMMUpWZ2RW?=
 =?utf-8?B?NDlEL0VYVzhoQ3l6bzhjRncxS013N1h4TEUvMVBsM1RsSzF1TlNvQkY1NjF2?=
 =?utf-8?B?eFF3ZURlS1JtNVNxZG8wcGtadWg5M09PSmt5bXU0MDBPb2tmb2ViUEozakpU?=
 =?utf-8?B?cmdkMEY4dSt2eVBXRkVuYUtuM0F3OGpJTFlubHRxMTdXTzVIYXhPbjdQVGx1?=
 =?utf-8?Q?h0VfdvnNLqQpGrRnHCt3o00=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4E2EF843C9692408EBE0D870169868D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5865bf-c452-4ec5-e73b-08da7df5b74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 13:05:52.1607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncou4x+k0l2CGgZ5wNuXAkj/sAQnygFLcKQblkPRoyUN1v2lN5RbAcqjFimY5GBw/nzvwarCOja8tJCfwWQ7t6kGtpzngT0qZ7UYDGIE8f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTAzIGF0IDA4OjUwIC0wNzAwLCBaYWNoYXJ5IE1pY2hhZWxzIHdyb3Rl
Og0KPiA+IFdoeSBub3QganVzdCBpbmNyZWFzZSB0aGUgZGVmYXVsdCBiZWFjb24gdGltZW91dCB2
YWx1ZT8NCj4gDQo+IEkgbWFkZSBpdCBhIHBhcmFtZXRlciBiZWNhdXNlIEkgd2FzIHVuZGVyIHRo
ZSB2YWd1ZSBpbXByZXNzaW9uIHRoYXQgYQ0KPiBsYXJnZXIgdGltZW91dCB3b3VsZG4ndCBiZSBp
ZGVhbCBvbiBhIHdlbGwtYmVoYXZlZCBuZXR3b3JrLCBidXQgdGhpcw0KPiBpc24ndCBteSBhcmVh
IG9mIGV4cGVydGlzZS4gSSBqdXN0IHRob3VnaHQgdGhpcyB3b3VsZCBiZSB0aGUgbW9zdA0KPiBj
b25zZXJ2YXRpdmUgY2hhbmdlIHNpbmNlIGl0IHdvdWxkIHN1cHBvcnQgaWRlbnRpY2FsIGRlZmF1
bHQNCj4gb3BlcmF0aW9uLg0KPiANCj4gVGhhbmtzIGZvciB0YWtpbmcgYSBsb29rLg0KDQpJIHNl
ZSB0aGF0IHRoaXMgaXNzdWUgaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNn
aT9pZD0yMDM3MDkNCmhhcyBhIGxvbmcgaGlzdG9yeSBmcm9tIDIwMTkuIEJ1dCwgYW55d2F5LCB3
aGF0IHZhbHVlIGZvcg0KYmVhY29uX3RpbWVvdXQgc29sdmVzIHRoZSBwcm9ibGVtPw0KDQpNYXkg
SSBhc2sgeW91IHRvIHBlcmZvcm0gdHdvIGV4cGVyaW1lbnRzIHRoYXQgY291bGQgaGVscCB1cyBm
aW5kDQp0aGUgcm9vdCBjYXVzZSBmb3IgdGhpcyBpc3N1ZT8gVGhlIGZpcnN0IGlzIHRvIHJ1biB3
aXRoIGEgZGVmYXVsdCBkcml2ZXIgYW5kDQp0byBjb2xsZWN0IGEgZmlybXdhcmUgZHVtcCAoaGVy
ZSBpcyBhIHdpa2kgd2l0aCBkaXJlY3Rpb25zIGhvdyB0byBkbyB0aGF0LA0KaHR0cHM6Ly93aXJl
bGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vdXNlcnMvZHJpdmVycy9pd2x3aWZpL2RlYnVnZ2luZyNm
aXJtd2FyZV9kZWJ1Z2dpbmcpDQphbmQgdGhlIHNlY29uZCBpcyB0byBsb2FkIHRoZSBkZWZhdXQg
ZHJpdmVyIHdpdGggbW9kcGFyYW0gcG93ZXJfc2NoZW1lPTEuIFRoaXMgd2lsbA0KY29tcGxldGVs
eSBkaXNhYmxlIHBvd2VyIHNhdmUgYW5kIHdpbGwgbGV0IHVzIGtub3cgaWYgdGhlIGlzc3VlIGlz
IHNvbWVob3cgY2F1c2VkIGJ5DQp0aGUgTklDIGdvaW5nIHRvIHNsZWVwIGFuZCBtaXNzaW5nIGJl
YWNvbnMuDQoNClRoYW5rcywNCkdyZWdvcnkNCg0K
