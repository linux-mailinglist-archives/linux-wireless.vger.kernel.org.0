Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1633E5BBDDB
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Sep 2022 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIRMyK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIRMyI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 08:54:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD74024BC8
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663505647; x=1695041647;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=tBg95mQ1tii10YwuKTH4w7bFPkk1rF1gISR78E9chWY=;
  b=WFcO3Q7pLPoLe6tpWlMQp//PDO5U33NAuTi1Iso32rpg5h8QYoPqrSSw
   6nNOZzZO5gEdHEkE/dnj3ysG6IeE1eqE/v7ks12X6XidVi46D2sM8xznW
   mKJTaSJuFTuZEPse83jOOWz5hzfzRM69aCxFrWnX7MUpZ+ZrkxKTjrPUi
   OzhBgHa7ZpP9c/HnFiSja8vLjkBC5BzmHhgNrIdfmCX1oE1gRtFgXSTbn
   bfx4PVh/nTOfx0NDtikm67cLZw6THYOUkb3IIYkugzZ8qHfA9TqC/Z8zC
   SLjtms+2R9E/1tkpkoDHJ0IzUzOoOFLGzbNWYRARc0Kk3Vffv+ILsLo1u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="286275378"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="286275378"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 05:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="680524272"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2022 05:54:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 18 Sep 2022 05:54:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 18 Sep 2022 05:54:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 18 Sep 2022 05:54:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 18 Sep 2022 05:54:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZyBt2EUU/27R4RgtIml3/koTrU2qykwSMNQ+nLqTV0FGsnFDoWqHBSPJKke7MD5nTHAiRw5bHfmP60UpllboCXSPpN5iDbTFoSfiUUvmbnm8Rb41FWCOQH20HutXTdQSmxrNnUklzjJy2UPiXG5dQV6ZdZVVJX3d+MYtwTVkMLdk/faJQfEVL5tZ83bgtAYwZRQa9FSbGEQkrGDXp2cl7CYNULSOs0tP9xNEqnZQV2vi78xJmtc+Gz3/pM4TETaubkGvLOlDEr478B9/bDnc95ZrrTXaXH5e64Zp3Jx7mod2dNMyJ0tExnGmlVViKW8K0KK1lanW0TagvS54qwW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBg95mQ1tii10YwuKTH4w7bFPkk1rF1gISR78E9chWY=;
 b=lZo+wIFXcN0e6BgoIoL1akEfzCzHlo8kWnRq9V4rtudaqe/Q0d06GVCLwUQunuMXzJjQjJ5BOBs1Tmmir//c42SqfVhePGfiRRoz0U7nDCZgS0CLzETXGj8UwOASpclxXX1+D822BG0ER4m6CPmpU5WJDfivFsCl5I+S3zxXNWUhuHs8oEZB6E+IeeTI0esrxWBubmjTFL+YYJDZ35ZzxSgjns1rRjE/OX9/FqYkRwqolS2DRJAyrWn4y5Ux4apFWbPUJKaXqSdhZmPrdvc8pSqz9ntet9YW9VgfZmvAl5bKk7yjX0PynJIM6NA7T2K6F/cqLnrBRLvJiEzdoMPXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by DM4PR11MB5440.namprd11.prod.outlook.com (2603:10b6:5:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Sun, 18 Sep
 2022 12:54:04 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::20ab:ad2f:da9f:8c7a]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::20ab:ad2f:da9f:8c7a%5]) with mapi id 15.20.5632.018; Sun, 18 Sep 2022
 12:54:04 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull-request: iwlwifi-next 2022-09-18
Thread-Topic: pull-request: iwlwifi-next 2022-09-18
Thread-Index: AQHYy127Qlg5Ti/Ut06tNd0j/dfrsA==
Date:   Sun, 18 Sep 2022 12:54:04 +0000
Message-ID: <b18b016d911204bdd5c6f4b08d698d679419a204.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|DM4PR11MB5440:EE_
x-ms-office365-filtering-correlation-id: 83d9980c-9a4c-45e0-1cd3-08da9974ddcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KNjuYfQonjdbI394923rD21bSfMVR2YkEfaWYRemHQtwgB4Y8qaC/yV3PG8yUaydPj6pon45j6VlvgxWCKrk2/1XBvJPBILWfhHWhjvK56f2H5aJNne4aQwhP/0c4Y257239wml17nwN4kcL4NsquFi30aM8kiuBDsjedR9LPJIFrMUvS9G+4UxD5rqJ9YAebfOFum3KX12P+e9z9i9zmhIvV8ZtCTWRF72hxT24zjEXFlybcEmq76Ee7wkP6DJwrl+Yt+Dw0GyWDkvvzYfuO1i5SYe/7BWZM2sQFPxz66Tn3PeIFWbH3f7Hx+Lf25U6jACrhoL2+oHCjNdLEyopx8XhxqEnTyh1mr6wLwc8DqirqJ0reVPA+iNv8rVuNPZW2hGwjPz6dgs52spQ+aFADNe3g294/e8Iqak6GYIjaOXsDa+6oGcMe4T2TyjUJqfHxH8QFOTkH9Ken1Yup3oRSbIBMZEi2Bnbz2cbtPa1nZfR6CluBulyvug/5spfFJToyg4ED6KyFL2uSCOiIU/u/rwxAGBLS316f64JX3bLEP/ylfQyYhZUZxO10HF6CK/pJ4o3MJoLDEjxRjwSr43Q/HyUBJOlb/fd1h6/jmJUyj5DnNPojS5DSS4bGyN+BE/h5Oxw9B4XimZnlXQQr8BeGaE8Sx4S49I8VjPphDhMZEWBkN7wZ+kgWncDVJHcj2VsUfiN63Zp++Z4hDhkD+o2tRVmU75HmNS7TbnbaBz3XdAWIuiaMFYv6eVL3dC+oCtVmxp6N8pcgg2/Gb7LeqyQfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199015)(41300700001)(122000001)(8936002)(66556008)(66476007)(66446008)(82960400001)(64756008)(4326008)(2906002)(2616005)(36756003)(91956017)(83380400001)(76116006)(66946007)(38100700002)(186003)(316002)(6916009)(6506007)(38070700005)(6486002)(5660300002)(86362001)(8676002)(71200400001)(478600001)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHN0OUVid3RJcnllY0hzUVdYUHBTSjh3VHlLWmIxUDFDSExPeTBQaWM2djF3?=
 =?utf-8?B?d2xqRGFlWXJZNzU3RUlJMDd1NGdzSmNFUmlTbzZhV29PZDJCTFNlOXVRbnEy?=
 =?utf-8?B?VTZWR1lpV3pham1MRHlGSm9icFVYTGN5bTFOK0twdW5OSVhadEdKMk5lUjY3?=
 =?utf-8?B?SlBJdS93OFYvYWVKMUlrYmQzaFlFREw2aW1XaENJZXZOZE5oZlpMZ2hOTGlE?=
 =?utf-8?B?b0Y0T3dzaElUOGQ2cGEwYm9VamR6SWpmZlNXaHlDZ0o0QXh0MGtrYTVWWkQ0?=
 =?utf-8?B?Zzc4amJwbEtzRnRtT055cGlSSHZsajE1SnNDNmsvTTRGemlOdE5XL3NlZEwv?=
 =?utf-8?B?eHVDV0hCd0poYmJTZE9VNmcwejR5aWhTaDkrZ0Y4VWNHdzZmVFY2UXV0bmtv?=
 =?utf-8?B?UmdlNElzQ2t2R3Qxd1NmeFpaYkw4d3ZVWmRhczhaRm5BOEdaempDY3FSbVRx?=
 =?utf-8?B?K3oxRzVIMjJmejNxT2l5VXlLQ1dLRitoY1FKOCtLMmhNcm9mMjRUbFJTOGlY?=
 =?utf-8?B?bUJacWZQbmxJd2JJdTVpT0JsRzNaR1h1MmVHWmc5bHFsdDVWWEtXRmVneXZx?=
 =?utf-8?B?SmdadjJwczZUQU9UVk42VERwZ1ByYkhFcTVVU0ZTTHVlZWUzdW1EZm1JeHlS?=
 =?utf-8?B?UERPbExQcjNXc25hamZIRHpMdGpEdlJxSG5tSDFhN0d2MkZOU0NxT0JzcUFV?=
 =?utf-8?B?UTFVZHkybWM2SndwWVRSbURPRTFDK3dKei9ZcSt0S3o4OTZWQ2JWcFFKQnQ5?=
 =?utf-8?B?aUhBTCtqYjFTOXlVSHBCUmFzVnVvU0kzQWRiRzB5WU5PRlI2TUFMbWFlRDNp?=
 =?utf-8?B?emRUYWxPUFh5KzY2byt2Wk5wUVZUNm8wUUJnR1pRVzZ4WStXKytPS3VWRXJw?=
 =?utf-8?B?TWQ4c1g3TFpkdGJmalFkRnEza213bCtFMERxUkdwUmJUd05NM0F1NzhtTm5L?=
 =?utf-8?B?ZTlGemdQNm5MMmRVck50VGdjVDAwTFMrSGQ0RC9ibCtyenFudnFGYkRKRE1w?=
 =?utf-8?B?WGM1V2VyWmpPb2tIWkpLNWN5UzZwamN2TEVTSVdyUmIzSDNxcnZYWDF0b05N?=
 =?utf-8?B?TDFrZDhRY2NWbDZiUjdpZzRzVXVxZTEvdWFaWUFLWW1QOC83TkR0MThBL3dY?=
 =?utf-8?B?WTI1c1NMbzNoNllMeDBLWWtPL0tDTEQyZVdvdERmdWRlTTViRHRoejB4L3o2?=
 =?utf-8?B?ZmoySXVESUpXVzdtd2VJcTlkTlpGSmxqTjA5MFlzdjhpeElPU1B1dkNKbVNV?=
 =?utf-8?B?d1VmTitHNWhMWTV2QlBzdmFlQVhENGtBbGZDQzI2RmRPSklweUpUT2JNeU04?=
 =?utf-8?B?Vmg1bEgrT0RMbTdjbnNvMVpaTW5aZUJmZDFUc2RjVDBiQU9XcGgzMUxXODdI?=
 =?utf-8?B?ck92bkRlUEhpRHUrTGFIL2R3bmxQVnVCcjNMdGVrUGw3cThXaHJmVFBUUG5G?=
 =?utf-8?B?cXE0M1BmV3N3SCsrMTBlY2JKZjI0WVNaL0hEUkYzYmh4eElkVzV4Z1NBVFMr?=
 =?utf-8?B?dWUyNytXcmd2cFZ1YUU5S21KY0xDQkFsby9BSCtkcVN0WDBKZ3VJUHV4Sk9B?=
 =?utf-8?B?MW9ZeG9tMStkbk8xMmNkNXN6NEh3WXhsWFphWmp4YWpUajdyMStjYi9xVDlX?=
 =?utf-8?B?cDMyNUxrZC9NNitFaGNMTzlzUkpoMDVQZjF2Ukp5bEhETVJjWTIrMy9pSkdj?=
 =?utf-8?B?NTJFdHh5OW8wMTUzbmt3RDE0NjJyNExnZ3Z3YUNNSWF3akVYcHJ4d216cU9K?=
 =?utf-8?B?NmZRMEJwTitBc3MwVzRFdVF3OExoN2d0aFZNOHFBaEFEUTFQOWN6bTZPK0ky?=
 =?utf-8?B?WUpHMmRRNmtybE8rV1NZR2FlcHFPY3RaM3o0QU9NcEtuRTM4SE5tUHdtU3B3?=
 =?utf-8?B?dlpoWEl5MEtmRUlmc1ErRXVXamMxU3hSY3l3MG4rSjFvdGdpcUF2VkY4bE9p?=
 =?utf-8?B?MWhHZkdIZEYwQWhYSjdLZzlXQlU1dHdOWHRpdVU4eDZVMGR6Q1dpa3FyVlhi?=
 =?utf-8?B?SE5wRklDcm1oK0R3QlViaTQ5cUZnVXozZ2NFUjNEMUpramhrWDBjTFJ0K3RR?=
 =?utf-8?B?N0lzTnpNODBZaFRONHBOdk5oUElNd1k5Mi9mWi9uSFJVaHNCMlJ1K1JlT2dH?=
 =?utf-8?B?UFhIbjZ1eHl5bE1sNHBscHFYV0VIeGQ4MFJucnB1WUd1aG5hSjJNRUdoVEt5?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C09B171275B324D964156974F7594BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d9980c-9a4c-45e0-1cd3-08da9974ddcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2022 12:54:04.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/t4X7vQ8Dh08qx9ej2rcjw075OWCMkXT+WcXGzXZFfPUoExztw05xc6JmTfXLi7VX1twGVpN9WhK8B29BoXl5BZZZ+BkhrK7gznzJ000BA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5440
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgS2FsbGUsDQoNCkhlcmUncyBteSBmaXJzdCBwdWxsIHJlcXVlc3QgZm9yIHY2LjENCg0KSXQg
Y29udGFpbnMgdGhlIHVzdWFsIGRldmVsb3BtZW50LCBuZXcgZmVhdHVyZXMgYW5kIGNsZWFudXBz
Lg0KDQpUaGUgY2hhbmdlcyBhcmU6DQoqIFJlZmFjdG9yaW5nIG9mIHNvbWUgd293bGFuIHJlbGF0
ZWQgY29kZQ0KKiBGaXhlcyBhbmQgY2xlYW51cHMNCiogQWRkaW5nIHN1cHBvcnQgZm9yIEJaIGRl
dmljZSBmYW1pbHkNCg0KVGhhbmtzLA0KR3JlZ29yeQ0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMg
c2luY2UgY29tbWl0IGQ1MzUwNzU2YzAzY2RmMTg2OTYyOTVjNmIxMWQ3YWNjNGRiZjgyNWM6DQoN
CiAgd2lmaTogcnRsOHh4eHU6IFJlbW92ZSBjb3B5LXBhc3RlIGxlZnRvdmVyIGluIGdlbjJfdXBk
YXRlX3JhdGVfbWFzayAoMjAyMi0wOS0xMiAxNDo1Nzo1NCArMDMwMCkNCg0KYXJlIGF2YWlsYWJs
ZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3bHdpZmkvaXdsd2lmaS1uZXh0LmdpdCB0YWdzL2l3bHdp
ZmktbmV4dC1mb3Ita2FsbGUtMjAyMi0wOS0xOA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMg
dXAgdG8gMzJmZWQ0NzA2ZDlhY2EzMWM5ZDU3NWMxZWZhNGEzNjI0YTlkNTU0MzoNCg0KICB3aWZp
OiBpd2x3aWZpOiBtdm06IGQzOiBwYXJzZSBrZXlzIGZyb20gd293bGFuIGluZm8gbm90aWZpY2F0
aW9uICgyMDIyLTA5LTE4IDE0OjQwOjE3ICswMzAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppd2x3aWZpIHBhdGNo
ZXMgZm9yIHY2LjENCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KSGFpbSBEcmV5ZnVzcyAoNSk6DQogICAgICB3aWZpOiBp
d2x3aWZpOiBtdm06IGRvbid0IGNoZWNrIEQwSTMgdmVyc2lvbg0KICAgICAgd2lmaTogaXdsd2lm
aTogbXZtOiBBZGQgc3VwcG9ydCBmb3Igd293bGFuIGluZm8gbm90aWZpY2F0aW9uDQogICAgICB3
aWZpOiBpd2x3aWZpOiBtdm06IEFkZCBzdXBwb3J0IGZvciB3b3dsYW4gd2FrZSBwYWNrZXQgbm90
aWZpY2F0aW9uDQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IEFkZCBzdXBwb3J0IGZvciBkMyBl
bmQgbm90aWZpY2F0aW9uDQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IGVuYWJsZSByZXN1bWUg
YmFzZWQgb24gbm90aWZpY2F0aW9ucw0KDQpIYWltLCBEcmV5ZnVzcyAoMSk6DQogICAgICB3aWZp
OiBpd2x3aWZpOiBtdm06IHRyaWdnZXIgcmVzdW1lIGZsb3cgYmVmb3JlIHdhaXQgZm9yIG5vdGlm
aWNhdGlvbnMNCg0KSWxhbiBQZWVyICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogQWRk
IGhhbmRsaW5nIGZvciBzY2FuIG9mZmxvYWQgbWF0Y2ggaW5mbyBub3RpZmljYXRpb24NCg0KSm9o
YW5uZXMgQmVyZyAoNSk6DQogICAgICB3aWZpOiBpd2x3aWZpOiBtdm06IGZpeCB0eXBvIGluIHN0
cnVjdCBpd2xfcnhfbm9fZGF0YSBBUEkNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogcnhtcTog
cmVmYWN0b3IgbWFjODAyMTEgcnhfc3RhdHVzIHNldHRpbmcNCiAgICAgIHdpZmk6IGl3bHdpZmk6
IG12bTogcnhtcTogZnVydGhlciB1bmlmeSBzb21lIFZIVC9IRSBjb2RlDQogICAgICB3aWZpOiBp
d2x3aWZpOiBtdm06IHJlZmFjdG9yIGl3bF9tdm1fc2V0X3N0YV9yYXRlKCkgYSBiaXQNCiAgICAg
IHdpZmk6IGl3bHdpZmk6IGNmZzogcmVtb3ZlIElXTF9ERVZJQ0VfQlpfQ09NTU9OIG1hY3JvDQoN
Ck5hZnRhbGkgR29sZHN0ZWluICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogZDM6IHBh
cnNlIGtleXMgZnJvbSB3b3dsYW4gaW5mbyBub3RpZmljYXRpb24NCg0KWWFhcmEgQmFydWNoICgx
KToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IHBjaWU6IGFkZCBzdXBwb3J0IGZvciBCWiBkZXZpY2Vz
DQoNClllZGlkeWEgQmVuc2hpbW9sICgxKToNCiAgICAgIHdpZmk6IGl3bHdpZmk6IG12bTogaXRl
cmF0ZSBvdmVyIGludGVyZmFjZXMgYWZ0ZXIgYW4gYXNzZXJ0IGluIGQzDQoNCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2NmZy8yMjAwMC5jICAgICAgIHwgIDQyICsrKysrKysr
KystLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL2NvbW1hbmRz
LmggfCAgIDUgKy0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9k
My5oICAgICAgIHwgIDYxICsrKysrKysrKysrKysrKystDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9mdy9hcGkvb2ZmbG9hZC5oICB8ICAxNyArKysrLQ0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvZncvYXBpL3J4LmggICAgICAgfCAgIDQgKy0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL2Z3L2FwaS9zY2FuLmggICAgIHwgIDIwICsr
KystLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvaXdsLWNvbmZpZy5oICAg
ICAgfCAgIDMgKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL2QzLmMg
ICAgICAgICAgfCA2NjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3
aWZpL212bS9tYWM4MDIxMS5jICAgIHwgIDI1ICsrKystLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9pbnRlbC9pd2x3aWZpL212bS9tdm0uaCAgICAgICAgIHwgICAxIC0NCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9vcHMuYyAgICAgICAgIHwgIDE4ICsrKy0tDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tdm0vcnhtcS5jICAgICAgICB8IDM3NiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9wY2llL2Rydi5jICAgICAgICB8ICAxOSArKysrKy0NCiAx
MyBmaWxlcyBjaGFuZ2VkLCA4NDYgaW5zZXJ0aW9ucygrKSwgNDEzIGRlbGV0aW9ucygtKQ0K
