Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943F85076C1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354624AbiDSRt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 13:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240029AbiDSRt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 13:49:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB01115A
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650390404; x=1681926404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EAWkhOJa1XqmtJt7CUXBhc/Xx9+x0ceKfpEsRpVLEKI=;
  b=UOzlN/fjdtaWB3aPfHWDmaw7VdZE662urza8unp+alJIeAtxrVGDElw1
   b2/KqFDO2OmImX+UWgClL6SQ4F7sUoxNEKgiHefAcmsieOiugiq+70YFp
   b6cgMZlxEywaiZgm4pBYv98l+b72oDie/C478MY1Pv4bTmygb8kU8PoDL
   boaBjRkSlrZFT4pUNLB6K8rwnJYwT3hn7kOB94SU9PBYMLTs90tfeEH4z
   aXyUR883oHAdsyzLke2+RMPdfB9hlDrcsOcWqcUQpiXyYyvvbkA1UxfGq
   52m/2uj+Kw13Fhy8FAtE+DwwZ2uHFbIUn+J5oHGKZcwOSA96i1zmu1uCh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="264001437"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="264001437"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="576208608"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 19 Apr 2022 10:46:44 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 10:46:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 10:46:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 10:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3F4xXPXm1ECcQe4RQ9PKB/tZkRwMIIUY7z/7GEubzVWwIsUgtTuJD1sEGgsOfjrEkCRRKkQkDzYUjAFpOdis0hnc2nQU5SFe5x02PJQZy76W7w3u/MO0yWsvGPp/vcgYwgipPbNbEZHGpWiFa8U1rIjwka8zATIjGV0KaQ0T6g3g8j5PBjVuuk2mTXAuwfOlkdHvg9p6SJZwEpz9wilw9AnubISfBfBEoqL+9/jjl2NJ8WJ3gDZoreIXTvpXOue7p8yuW9wi7wc4I0JwAtNhSGH51OfSEUQMK9PekHngbELFjy3QiZdPqjo4hEGet2/A8FiXP6jwZrTvAZN3w9aQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAWkhOJa1XqmtJt7CUXBhc/Xx9+x0ceKfpEsRpVLEKI=;
 b=Jui0OAOY7vAZ9T+ZRqbfkAs/BmmqBr9pWJfETXoprSxwrEI+Sugim4Czqov5gBHmhJa6pY4cuUwPONH0TJmzhXfieXb5wt4AMk3DcK5T/lJMvVRqkIqv5t77R0K+BPA6/vAYikJwI/NvNyAaqv7pK91o5BHh93803x+pjb63MaTrCoNGmK7oyrZUxjV9lQDiWiFnkzp0h3EJKl0e+9YM+fjr7OqGdlgI/hZ8uizTB4ZH15NTZro03ATLln1RVYfx72lKSOtfywv9f12fceBrqYZRHY/N48sKiHZO+mAqv07HVyfaJiynPQTAQbHZPY80r/Ju5QG4HgK618+jq8fEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by BN7PR11MB2786.namprd11.prod.outlook.com (2603:10b6:406:b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 17:46:41 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 17:46:41 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "toke@toke.dk" <toke@toke.dk>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYUxiO5laT20cdFkKz0kQ4shKh3az2xgSAgAAE2ICAAARFAIAATT6AgABoR4A=
Date:   Tue, 19 Apr 2022 17:46:41 +0000
Message-ID: <e0872b6f468bfda08717214044b64187f71b4e18.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
         <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
         <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
         <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
         <87mtghs3y2.fsf@toke.dk>
In-Reply-To: <87mtghs3y2.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5083ac68-b748-45ba-1a1b-08da222c8fd8
x-ms-traffictypediagnostic: BN7PR11MB2786:EE_
x-microsoft-antispam-prvs: <BN7PR11MB2786E1200303BB121423C949F2F29@BN7PR11MB2786.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gUT1gvRynnEdtRL/rslz7bvevGwHXx/T8SuUzdmQhX4JLseVEbzdnZXwwNukoYo+/w0Fw5th4TZj02PhTJoWdKRavUZtJe31ox6a8Hb+MuykJ/EQx0rr3z8wOQRi+6JJqSd+eBVSEgEsqFNYdzfvsrfvfi1G/3t9suU6TMmTNwvKSM3NaJmcS676Dr7/gJMiVFd9DwkyAtpSp/ojhYECQoCZ148V120/0OIAd1Ri60ZaCTYg2OghVRKJvdVNKrQQ+mHvTHddVxj4g/YE8bTgZy4t2f+MCZB4a72xGaTiN9FpfSs/ZlPc+LxwJ+ZxGNKPaOjThL/ERpGsPoh908hhXN5r7s+saqu1wtvmUO+DBCQbFgzEAzyv5meS1c6mvFNWEzfByKvfpAGqEul8v1CmO0A/6jnvIpepbhsQQ9BL1a7yH0pvFU4IDt2A7++VAw7VlVG5m1KMl0EVl5shP+MQHrBmKLqiBgr0tjpe3gyc56Aua6UvuRPFJkY9vaNRvUns5uP1TdLo1jO56OPUtqQ93Gd/VGOKa4xW8tRNz6EJ3kdfsD6mDOKZRjRc+DccGeHleN/O0FlOUS56Pfj6ZGOM2AVS4zQLd1FKPIYjZvgu2Cu2EBhSGP0twyow5vhcSQIaV3+d/8Jmc9sO0949qn9svPSyPMt4+N8+Zdsa6fzfazxE4FG4Frxhv+pk99EmewEbfA3psJjlcnUTf+Qa/d289g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(122000001)(107886003)(82960400001)(6506007)(26005)(36756003)(15650500001)(186003)(2616005)(2906002)(38100700002)(86362001)(8676002)(6486002)(38070700005)(5660300002)(508600001)(83380400001)(66574015)(91956017)(71200400001)(316002)(4326008)(8936002)(54906003)(110136005)(66446008)(66556008)(64756008)(76116006)(6636002)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkxIMThlb1hvRjByV0pqckxUVkNwNlBJbEVUUmJNYjg4dmVsempRTDFLMHhw?=
 =?utf-8?B?R0VtbTNlV3BSNk0vQUxMNTdkZzZIS3orR2xFOG9IaGxFVjR4dEpudVdnTG9v?=
 =?utf-8?B?Y0dGTk82KzkyR3VJbkZDR0k3VnZOZERxZ050WFlQdGhMTHNOcWtyaStFSllh?=
 =?utf-8?B?RDBmZDZFTTNiQzl5TTM2VTU3QXVPZkFEZzV4UUdXUXoxWDZIVlpWVHhrRnRF?=
 =?utf-8?B?NjNOdVZtVXlTQnphRUthL2I5eFJSdmxkTTFGcm5NU1QwNjVySXBjRG9DTjFt?=
 =?utf-8?B?VUM1TVdwUWlzQm1BWTkvbzZHb0IxTEJ5WXNRc3FOWHJGeVB0b080b0NhRzdU?=
 =?utf-8?B?c1Q5eDJqV3JjdC9RcndsSnFsN0FmMFVUZHZMUmJXMkN1VmttL3lURFE1UG8w?=
 =?utf-8?B?aFlUdy81VTJ0em5qTFR4d1pmTUNSSHI5ckZHV1M0T21BdlhIeVVuOUpXUldl?=
 =?utf-8?B?eDRFekNWMVhIL284VFBkbldtQkVCSnErUFJnWlh2YlFVSWpQNkc4YjU5Vmlm?=
 =?utf-8?B?WUtSbVRKR29lRi9UVXJWalZFQ09Dd1pEOGJld0RRb244TFlaNUNOM2ttaW0x?=
 =?utf-8?B?c1d5cTNPNDN6emVGTmFWaElkWTNrWnFhUHZCTTRqbUJ1RWdwcTNuL3ZKVEZm?=
 =?utf-8?B?S1dFNkV5TkxBR3l4MnZWcEhVaFlaOVY2Yzl4cnp6cktKSVVlaG1uRXUzTjZW?=
 =?utf-8?B?ZStmNUtzWG5nMGdiOWh6MldFQnJNMkxleGN4UmRZQUNhYUxNTzhTc0NGOGRq?=
 =?utf-8?B?eGwyMFZ2MnFuQ3I1eHEyTk9md3YrbXAzTlNES3FpMmdtTGJpdmtXQmJSdDh3?=
 =?utf-8?B?T1lYaytsenFwKzA2MHYvRXFrUGVLTE1QekhpWkJlZUtCaHFpS2t2bk9JZHRi?=
 =?utf-8?B?U2syblYwUHZ5Slg3U3RReEhOM2VSa3FoWHo4eGduRy9QSERvRmlEcm1XNWsw?=
 =?utf-8?B?ZmZOSXIrVHBMamVUUDVRUjY4VjhvVjhBTy9Qb2UzeEFEbmsyUjFZWVRHUjd1?=
 =?utf-8?B?SzFZc1JVckFyemxRY3Jyd09KSS9RV1FMRXg3UEx6NWdkL3l4SnZ5U2pwa0FG?=
 =?utf-8?B?QXRKY3h6SkpsdjlvbFR4aXlYM0VGU1pweVNYT3kwWjFHYm9XWEtEOEtIWlZk?=
 =?utf-8?B?eE9SU3RpS0N2RUhwODhXcWc3VGZmaW8zSmpSMjFZcG5Zb2tsL1kwOGkvQXE3?=
 =?utf-8?B?cVZiaXY2cVI5V3o3b2gxK2NseEwxQmdGb1JNZ0xBNU9OSmhTK3VidTN1Tk12?=
 =?utf-8?B?NFd2bDg4TXNhQjhtOGZuS1hwemtBRFdsMkljcmZ1UFczdVFRVC9SQ2NhSDd5?=
 =?utf-8?B?UFpPd3VwSHdXMG9iVHIvajJsQVAwblY4YkVON0ZIUVo5NlArS0gxczg4d3VM?=
 =?utf-8?B?czErekMrWEIvR1BBb1RYVGM5SlFWQjNrc0hHOFBrTDRFY0lQUmRUaXFSQ3Bv?=
 =?utf-8?B?TGZDem9PUE9qSVVteGNabHE5TGgxb3lxRmd4WVVOWk80WmltUC94WlBtQTJR?=
 =?utf-8?B?ZFUxQUdSTnJLdmtleXV2N2wyc2UyUlNPR2tKTmhDTnh1czVnOWZYM0JzL0FZ?=
 =?utf-8?B?NTlqMVJSelYrcElJWWE0UUpxa29zMHhFNHlWQUZaSmVLOG9TNWFseW9SSFhO?=
 =?utf-8?B?aFR5WFJyQURQekwwQnIzR2M2YzlLRUZ1aTdPc2lGN3hqUmJXQ2tvVE13SXBw?=
 =?utf-8?B?YzFvcjV1enBmaTJaZnM3SFRpZUJaMzcwNE5SZ056V243Vk83WU5oZ2xOcG1K?=
 =?utf-8?B?K2VpWENQZFN3clRlVFRBdHRrdDJ1Q3ZTNnFOUmtUeTR4TFBMMFA5TnJKMmlx?=
 =?utf-8?B?Um03TjFHMGQ1TWE3RWEwMEY3LzFNdlhEUjdDdm9TSmIxaFlyU1FMaGVvVU5P?=
 =?utf-8?B?VGxSSWpvWEhmTFhCL3hqQkVJL2RncURyN043SEEzcktsMXBMQ1RScFI4NnhT?=
 =?utf-8?B?M2RBckw4bGpPOThxd2FyOXJSc0d5bjVBUUlubmgrNlBJR1B4eUNtNjVCZmpM?=
 =?utf-8?B?eXdGelV2TDFFa3hOREU5VnZwVjI2akVqT01pVlVpVjhsNmU4NE1lUVIzZEY0?=
 =?utf-8?B?ajNuTWhOM1NZTlc4STFwZEluOVpZdk44VVU0VTZLMzdlaG9RN1gwSTdEemtn?=
 =?utf-8?B?OTZWemdudnVIbnAzL2xkMm4wbkxqeFdLUFB4aDNWSWFKLzU1WENqakF1MVJ0?=
 =?utf-8?B?RkpDS1cwWWw0S0tzZnZRcGhMNmFPMUlsWEZvWU4vTCszcEdVSTV4UkYya1RJ?=
 =?utf-8?B?WFFFdEZFSFY4cS9VYllBYlpUTSt6Q2syaWo0UVdQUzNXMGlNUHlNYjNrUmNK?=
 =?utf-8?B?UTFZUHBZUU1lbXZ1N2FBbzdFVDMzdTQ1MytXRm5UMW8zd1pDdGpnNjMrZWNy?=
 =?utf-8?Q?WA5SlTpOx74CpJOLJ4Nn3KnWWmhl6A/KGcGxU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63F557FDA46BA149A432009D3A68DD6E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5083ac68-b748-45ba-1a1b-08da222c8fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 17:46:41.2150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xs1LFkm4wArxcbfTh5o6br6Bs+gRGthRxDmItbcZEvzuahekhAegRAcpGRb64Pra0cHbXAgIZLAXZmmwCESXisP5pkpLaY2X+W8+ZcYWeTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2786
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTE5IGF0IDEzOjMzICswMjAwLCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5z
ZW4gd3JvdGU6DQo+ICJHcnVtYmFjaCwgRW1tYW51ZWwiIDxlbW1hbnVlbC5ncnVtYmFjaEBpbnRl
bC5jb20+IHdyaXRlczoNCj4gDQo+ID4gT24gVHVlLCAyMDIyLTA0LTE5IGF0IDA5OjQxICswMzAw
LCBHcnVtYmFjaCwgRW1tYW51ZWwgd3JvdGU6DQo+ID4gPiBIaSBUb2tlLA0KPiA+ID4gDQo+ID4g
PiBPbiBUdWUsIDIwMjItMDQtMTkgYXQgMDY6MjQgKzAwMDAsIENvZWxobywgTHVjaWFubyB3cm90
ZToNCj4gPiA+ID4gT24gTW9uLCAyMDIyLTA0LTE4IGF0IDEzOjM2ICswMjAwLCBUb2tlIEjDuGls
YW5kLUrDuHJnZW5zZW4gd3JvdGU6DQo+ID4gPiA+ID4gSGkgTHVjYQ0KPiA+ID4gPiANCj4gPiA+
ID4gSGkgVG9rZSwNCj4gPiA+ID4gDQo+ID4gPiA+ID4gSSd2ZSBzdGFydGVkIHNlZWluZyBpc3N1
ZXMgd2l0aCBteSBpd2x3aWZpIGludGVyZmFjZSBnb2luZyBhd2F5IGFmdGVyDQo+ID4gPiA+ID4g
c3VzcGVuZC4gSSBnZXQgZXJyb3JzIGxpa2UgdGhlc2UgaW4gZG1lc2c6DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gWzEwNDM5My4xNDIyNjRdIHdsYW4wOiBkZWF1dGhlbnRpY2F0aW5nIGZyb20gNGM6
NjA6ZGU6ZWE6Yjg6NTggYnkgbG9jYWwgY2hvaWNlIChSZWFzb246DQo+ID4gPiA+ID4gMz1ERUFV
VEhfTEVBVklORykNCj4gPiA+ID4gPiBbMTA0MzkzLjM0Nzc3NV0gaXdsbWVpIDAwMDA6MDA6MTYu
MC0xMzI4MDkwNC03NzkyLTRmY2ItYTFhYS01ZTcwY2JiMWU4NjU6IENvdWxkbid0IGdldCBBQ0sN
Cj4gPiA+ID4gPiBmcm9tDQo+ID4gPiA+ID4gQ1NNRSBvbiBIT1NUX0dPRVNfRE9XTiBtZXNzYWdl
DQo+ID4gPiA+ID4gWzEwNDM5My4zNDc4NzZdIGl3bG1laSAwMDAwOjAwOjE2LjAtMTMyODA5MDQt
Nzc5Mi00ZmNiLWExYWEtNWU3MGNiYjFlODY1OiBmYWlsZWQgdG8gc2VuZA0KPiA+ID4gPiA+IHRo
ZQ0KPiA+ID4gPiA+IFNBUF9NRV9NU0dfQ0hFQ0tfU0hBUkVEX0FSRUEgbWVzc2FnZSAtMTkNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBBbmQgd2hlbiB0aGUgaG9zdCBjb21lcyBiYWNrIHVwLCB0aGVy
ZSBpcyBubyBjb25uZWN0aXZpdHkuIFJlc3RhcnRpbmcNCj4gPiA+ID4gPiBpd2QgZml4ZXMgdGhl
IHByb2JsZW0uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhpcyBpcyBvbiBhIDUuMTcuMyBrZXJu
ZWwgKEFyY2ggTGludXggZGlzdHJpYnV0aW9uIGtlcm5lbCksIGFuZCBsc3BjaQ0KPiA+ID4gPiA+
IHNheXMgdGhlIFdpRmkgZGV2aWNlIGlzIGFuICJJbnRlbCBDb3Jwb3JhdGlvbiBXaS1GaSA2IEFY
MjAxIi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBbnkgaWRlYXM/IDopDQo+ID4gPiA+IA0KPiA+
ID4gPiBUaGlzIHNlZW1zIHRvIGJlIHJlbGF0ZWQgdG8gaXdsbWVpLCBzbyBJIGFkZGVkIEVtbWFu
dWVsIHRvIHRoZSB0aHJlYWQuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBDYW4gd2UgaGF2ZSB0
aGUgZnVsbCBkbWVzZyBvdXRwdXQ/DQo+ID4gPiBXaGF0IE5JQyAvIHBsYXRmb3JtIGRvIHlvdSBo
YXZlPw0KPiA+ID4gRG8geW91IGhhdmUgQU1UIGNvbmZpZ3VyZWQgaW4gdGhlIEJJT1M/DQo+ID4g
PiBEaWQgeW91IGVuYWJsZSB3aXJlbGVzcyBvcGVyYXRpb24gaW4gQU1UPw0KPiA+IA0KPiA+IEFo
IC0gdGhpcyBpcyBBWDIwMSwgb2ssIGJ1dCBJIHN0aWxsIG5lZWQgdGhlIHBsYXRmb3JtIGFuZCB0
aGVmdWxsIGRtZXNnIDotKQ0KPiANCj4gSXQncyBhIExlbm92byBUaGlua1BhZCBYMSBDYXJib24g
R2VuIDksIG1vZGVsIDIwWFhTM0hDMjY7IEFNVCBpcyBzZXQgdG8NCj4gIkRpc2FibGVkIiBpbiB0
aGUgQklPUy4gSSByZWJvb3RlZCBhbmQgZGlkIGEgc3VzcGVuZC93YWtlIGN5Y2xlIGFmdGVyDQo+
IGNvbm5lY3RpbmcgdG8gdGhlIFdpRmkgbmV0d29yaywgd2hpY2ggcHJvZHVjZWQgdGhlIGRtZXNn
IGJlbG93Lg0KDQpUaGFua3MuDQpUaGlzIGlzIGEgU2t5bGFrZSBwbGF0Zm9ybSBhbmQgd2UgZGlk
bid0IGhhdmUgYSBoYW5kc2hha2Ugd2l0aCBDU01FIHdoaWNoIGlzIG5vdCBlbmFibGVkLiBXZSBh
cmUNCm1pc3NpbmcgYSBjaGVjayBiZWZvcmUgd2Ugc2h1dCBkb3duIGl3bG1laS4NCkNhbiB5b3Ug
Y2hlY2sgdGhpcz8NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3
bHdpZmkvbWVpL21haW4uYw0KYi9kcml2ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21l
aS9tYWluLmMNCmluZGV4IDhkNjEwNDRhNmVkMy4uN2I0NTM4MmM4MTNjIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9tZWkvbWFpbi5jDQorKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL21laS9tYWluLmMNCkBAIC0xOTIzLDI5ICsx
OTIzLDMzIEBAIHN0YXRpYyB2b2lkIGl3bF9tZWlfcmVtb3ZlKHN0cnVjdCBtZWlfY2xfZGV2aWNl
ICpjbGRldikNCiANCiAgICAgICAgbXV0ZXhfbG9jaygmaXdsX21laV9tdXRleCk7DQogDQotICAg
ICAgIC8qDQotICAgICAgICAqIFRlbGwgQ1NNRSB0aGF0IHdlIGFyZSBnb2luZyBkb3duIHNvIHRo
YXQgaXQgd29uJ3QgYWNjZXNzIHRoZQ0KLSAgICAgICAgKiBtZW1vcnkgYW55bW9yZSwgbWFrZSBz
dXJlIHRoaXMgbWVzc2FnZSBnb2VzIHRocm91Z2ggaW1tZWRpYXRlbHkuDQotICAgICAgICAqLw0K
LSAgICAgICBtZWktPmNzYV90aHJvdHRsZWQgPSBmYWxzZTsNCi0gICAgICAgaXdsX21laV9zZW5k
X3NhcF9tc2cobWVpLT5jbGRldiwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgU0FQX01T
R19OT1RJRl9IT1NUX0dPRVNfRE9XTik7DQorICAgICAgIGlmIChpd2xfbWVpX2lzX2Nvbm5lY3Rl
ZCgpKQ0KKyAgICAgICB7DQorICAgICAgICAgICAgICAgLyoNCisgICAgICAgICAgICAgICAgKiBU
ZWxsIENTTUUgdGhhdCB3ZSBhcmUgZ29pbmcgZG93biBzbyB0aGF0IGl0IHdvbid0IGFjY2VzcyB0
aGUNCisgICAgICAgICAgICAgICAgKiBtZW1vcnkgYW55bW9yZSwgbWFrZSBzdXJlIHRoaXMgbWVz
c2FnZSBnb2VzIHRocm91Z2ggaW1tZWRpYXRlbHkuDQorICAgICAgICAgICAgICAgICovDQorICAg
ICAgICAgICAgICAgbWVpLT5jc2FfdGhyb3R0bGVkID0gZmFsc2U7DQorICAgICAgICAgICAgICAg
aXdsX21laV9zZW5kX3NhcF9tc2cobWVpLT5jbGRldiwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBTQVBfTVNHX05PVElGX0hPU1RfR09FU19ET1dOKTsNCiANCi0gICAgICAg
Zm9yIChpID0gMDsgaSA8IFNFTkRfU0FQX01BWF9XQUlUX0lURVJBVElPTjsgaSsrKSB7DQotICAg
ICAgICAgICAgICAgaWYgKCFpd2xfbWVpX2hvc3RfdG9fbWVfZGF0YV9wZW5kaW5nKG1laSkpDQot
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCisgICAgICAgICAgICAgICBmb3IgKGkgPSAw
OyBpIDwgU0VORF9TQVBfTUFYX1dBSVRfSVRFUkFUSU9OOyBpKyspIHsNCisgICAgICAgICAgICAg
ICAgICAgICAgIGlmICghaXdsX21laV9ob3N0X3RvX21lX2RhdGFfcGVuZGluZyhtZWkpKQ0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCiANCi0gICAgICAgICAgICAgICBt
c2xlZXAoNSk7DQotICAgICAgIH0NCisgICAgICAgICAgICAgICAgICAgICAgIG1zbGVlcCg1KTsN
CisgICAgICAgICAgICAgICB9DQogDQotICAgICAgIC8qDQotICAgICAgICAqIElmIHdlIGNvdWxk
bid0IG1ha2Ugc3VyZSB0aGF0IENTTUUgc2F3IHRoZSBIT1NUX0dPRVNfRE9XTiBtZXNzYWdlLA0K
LSAgICAgICAgKiBpdCBtZWFucyB0aGF0IGl0IHdpbGwgcHJvYmFibHkga2VlcCByZWFkaW5nIG1l
bW9yeSB0aGF0IHdlIGFyZSBnb2luZw0KLSAgICAgICAgKiB0byB1bm1hcCBhbmQgZnJlZSwgZXhw
ZWN0IElPTU1VIGVycm9yIG1lc3NhZ2VzLg0KLSAgICAgICAgKi8NCi0gICAgICAgaWYgKGkgPT0g
U0VORF9TQVBfTUFYX1dBSVRfSVRFUkFUSU9OKQ0KLSAgICAgICAgICAgICAgIGRldl9lcnIoJm1l
aS0+Y2xkZXYtPmRldiwNCi0gICAgICAgICAgICAgICAgICAgICAgICJDb3VsZG4ndCBnZXQgQUNL
IGZyb20gQ1NNRSBvbiBIT1NUX0dPRVNfRE9XTiBtZXNzYWdlXG4iKTsNCisgICAgICAgICAgICAg
ICAvKg0KKyAgICAgICAgICAgICAgICAqIElmIHdlIGNvdWxkbid0IG1ha2Ugc3VyZSB0aGF0IENT
TUUgc2F3IHRoZSBIT1NUX0dPRVNfRE9XTg0KKyAgICAgICAgICAgICAgICAqIG1lc3NhZ2UsIGl0
IG1lYW5zIHRoYXQgaXQgd2lsbCBwcm9iYWJseSBrZWVwIHJlYWRpbmcgbWVtb3J5DQorICAgICAg
ICAgICAgICAgICogdGhhdCB3ZSBhcmUgZ29pbmcgdG8gdW5tYXAgYW5kIGZyZWUsIGV4cGVjdCBJ
T01NVSBlcnJvcg0KKyAgICAgICAgICAgICAgICAqIG1lc3NhZ2VzLg0KKyAgICAgICAgICAgICAg
ICAqLw0KKyAgICAgICAgICAgICAgIGlmIChpID09IFNFTkRfU0FQX01BWF9XQUlUX0lURVJBVElP
TikNCisgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJm1laS0+Y2xkZXYtPmRldiwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkNvdWxkbid0IGdldCBBQ0sgZnJvbSBDU01F
IG9uIEhPU1RfR09FU19ET1dOIG1lc3NhZ2VcbiIpOw0KKyAgICAgICB9DQogDQogICAgICAgIG11
dGV4X3VubG9jaygmaXdsX21laV9tdXRleCk7DQogDQoNCkFsdGhvdWdoIEkgdGhpbmsgaXQnbGwg
anVzdCBmaXggdGhlIGVycm9yIHByaW50IGFuZCBub3RoaW5nIG1vcmUgdGhhbiB0aGlzDQoNCg==
