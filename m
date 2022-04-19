Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1B5064E9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 08:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbiDSG7p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 02:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbiDSG7o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 02:59:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F8427B14
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650351422; x=1681887422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+Yeo7M6hNjsT7kPsOVYLCj7VXfwg7Y89x6iP3rddxOw=;
  b=SVrr2e4RI/WZaAVPlOy2mAF6TrQwkHZvXL0JQNMCT8w4oYaueAVyyhsx
   iPoWmDit4Vcx/y62kMGo58mgFMMmJrpI7QlapPPWCOodIwNpDsBpBYt0B
   uhAkEwR5YE/9jjGaOMUCX4B2CIANDnYjZBo828k9QE4t2B1rQWvuSOXT+
   EQFGKpKezi/l+J7nOXexJE5ogQqQERRJdPKgYlUtjQqvTYhV5FtL89Cjl
   iKK26UvPFPKHvD8nvV3Kt1ahWdwjjK9jZHZNsFzPVCrpBwRHFYk7ql8jY
   ZRFtc1EA94P7imYEGTFrw66WosA2RcCRPkgS9+vBvlqV3jWzJCv3rK2tT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263868872"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="263868872"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 23:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="665844696"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2022 23:57:02 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 23:57:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Apr 2022 23:57:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Apr 2022 23:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAa3CuEjQ1RHgrhfUfLo9sPygbwDj9K7Qr9pAZ28nxD77FsKpAPzmqA04gp28pEUe2MEMgJ1oBr7uR9nBdIZ+NN6SVmyb8SvfVetv+ttxbJn5ax+gOW4VPk5opu7ngpw4v8dvLvAh9UV/zqnqWwXQmRQFiD2dVVPeNPM3+2lXfTnarLrYJMbSTXVaF6ik0Atz6SLE3TioNyVC50fbkij1/vDp7vdBjpJR2S2ra5IvbC4CywLISXHgxz7Gv3B4L8w6KtphmWt0Fj66cXepcuc5gg/bCtucams/eF5B0yyNXdZU5LdhVivt0iv+meVCRdQ3F0vcoFDaobxsmEiIPFpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Yeo7M6hNjsT7kPsOVYLCj7VXfwg7Y89x6iP3rddxOw=;
 b=UYdrLusGNPwfwfN5RPf8NDkXwKi0/yqa93ALbILvcXYB6X+6PD2mWSgZBE5zqi6dBcay6M/vPWS2RCY2lPpQchTuDUzbQioTInqITtbxu/I5a90ynVRHJskxE7HTqz/FRCoOamGSM8YdVbxdqBsXRi0d7VL7wl5l1ZPq3/MxIjMn/9inz21nwh6ZqXAn5MdZLRCespKV+Re9GySlOHEnn5DljLayhNnBR4TlQlh1wgH9eZUFg+FEjZ4UYI1Ebu5fAOFa+wwVoBqDa3SEBQzSo5ocxXv4ZYLYnIXsf/sGfZAA4QGqJKgknt+AyF08jODcki2f9QlYP+fPzLeg9mvAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by DM5PR1101MB2282.namprd11.prod.outlook.com (2603:10b6:4:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 06:56:59 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::fcb0:5d44:ef18:7b3c%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 06:56:59 +0000
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     "toke@toke.dk" <toke@toke.dk>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Subject: Re: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Topic: iwlwifi devices disappear after suspend on kernel 5.17
Thread-Index: AQHYUxiO5laT20cdFkKz0kQ4shKh3az2xgSAgAAE2ICAAARFAA==
Date:   Tue, 19 Apr 2022 06:56:59 +0000
Message-ID: <be3b424aec839d899e4a8cd659ebb53a85d67339.camel@intel.com>
References: <87czhe39p6.fsf@toke.dk>
         <1f6188ee5c88ac78a4aadcf169b4b1cc857a84d8.camel@intel.com>
         <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
In-Reply-To: <d3158dfeb64276f5a9259b17342ff85dc6a4b79c.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b23e8d6a-9871-4227-d954-08da21d1ccc3
x-ms-traffictypediagnostic: DM5PR1101MB2282:EE_
x-microsoft-antispam-prvs: <DM5PR1101MB22829E3DAA6BA2F516C204FAF2F29@DM5PR1101MB2282.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: meA6JtncJXrtOi8CHGURINlO/G/3ybHZiRKtnxdm4wbtgxzrGT0ff1rXESb4sohTxax+qk1tk0E0eo6i+fkHvf9syp3wE8viZBliHM14+HL+eha2spAeRuMSObMQ8mnyuBPfvRQDACX3J4wOXVg1ecb83kAmAxDLTxJ6cBya5Q0IZbhIG7Ul1zaIUPmKHSU9fNX0VSZMyPw/cDWyD7oI80xxlo6kSE8fDlggqngy/iNK1RQSf/0/Leen6n0j7aOGdP7ap9K+x6J0dXP7Yenaern6AF5NrGNohTynPLVobA8VIYtUg+NPrn+h9v2wRoSnCoxpAylTS4/oBfYGWe6xms1cf59veL6Y1jM9frB2ondD3C34U8nORh4SH+dZWd802xh4H0BF9XXFkAmks4jsVrrFmAKXt9UD9hwxesJF3blp65qmzqfOpFDwCB/BO+vJDTKCLTFQ10WabnOOmDaY6AXLj737fnVnajlUi4tTfaIFQc6DXNbip/U9IzMCQNAV+6Gv+MfG6FNNpMet0DkmQUE5c7mcf5hv8IG/KLDCBz1xHJVCK9bEMBqVYOIUmFZMOZAtSmNUUqv4TwmaURhTcsMhFnSoESfUIJ4GasiEFXRFJyvBU5HfgSYstHQABQ2CY5AXqtmm3sW2p1FIPjdzq+iesNLcuvVeU1MyF69c57sKRpf07lWyh6VmHvt6jVOes7S5QJ+WE8zclqKFJNtpjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(26005)(186003)(66574015)(86362001)(15650500001)(2906002)(66476007)(91956017)(38100700002)(66946007)(76116006)(38070700005)(83380400001)(4326008)(8676002)(2616005)(122000001)(6512007)(66446008)(66556008)(64756008)(5660300002)(8936002)(36756003)(508600001)(71200400001)(6486002)(82960400001)(54906003)(110136005)(316002)(6506007)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1hjb0Nld2ljT1NWSjIzU0ZNVGhHNm9OT1lXdDM1b2dMMlQrRjZJUmhwbUFU?=
 =?utf-8?B?ajc1REtNVEhMQ0tpVnZOaUx4T09lMTNiOWZsMTNEbVVuR2VyUHhOUHdMcEJB?=
 =?utf-8?B?LytORERXKzFFa29XTjRLT2x4MFVHbzdJRmFHYTUwREtxMzB3alFHQjh2dnh1?=
 =?utf-8?B?M3Y0TGR0VS91a0xYSGhuUTQzbExFNk5STTNOY1pCVjNWckNaUFRaRUhJQWwz?=
 =?utf-8?B?NTVEUnZLQ2xGbFpRSTBYSElSNDdYQVZ2MGp4dHpuVUMxR0w2dXo0UHR1YkV4?=
 =?utf-8?B?aXlrMVlIaHUvK2hVYUZkaVg3WlRiOWNySEpNUWIxYkc4OG5Tajkzb2J6YUo5?=
 =?utf-8?B?RXgzTnBrVnovOTNBTnZibktRamlZbnQwNHJleFBRT2UweDZGcEVhSmtKUzZy?=
 =?utf-8?B?ZlNhZERZMnVtQW5jclNaM3Rvc2l0bHR4MXB2OEFEOEd6ZUNqRklabzJ4M1lr?=
 =?utf-8?B?alM4RjczL0xWcWlxMUZWbEMxMU9HZ01YeUZaWlJRankvK3RTWk9SVkl3M0Jk?=
 =?utf-8?B?Ym11NXExRk8rRjhpTnJZaHZUdUlKNllCdVl3TEVCWTdsMlN2Wis3TmZjRXl4?=
 =?utf-8?B?NlBEblU0YjFHaCtBYlpXZ3oxeHY4MFpwbGFRaEJYcU5BNlNNN2YrVUpmNFVH?=
 =?utf-8?B?RjI2NmQrRndOR3FyT0RIU0FWWUoxRGFWU0tWYkFlTkp5SnB6Y1BtQklobW5Z?=
 =?utf-8?B?a2EwNXFRUnJpUTZUQWhqL09Kd1ZKaThNeEZ3bzdncU5JellwNVV4eERRMjdF?=
 =?utf-8?B?TS9xc1dUWG5IcVd0TWFhMXJkTkdZM0FpSStkQmt0ZXUvN1ZHbVFVcnQ1Q3p2?=
 =?utf-8?B?V1czb1Y5QVloQ2ZENDVtdkhtUlhvMmhnY1RkMXo0VlRHbkVocHJKQ0M0L3Zu?=
 =?utf-8?B?c1E1ZlUrOUllUTFmN1hJSzFFRVRWT0pyMCsrc1NTZ0dONFZNV0VzbEpqZWNp?=
 =?utf-8?B?b1pYdHQxeGVyZjRUTEpEeVlGODJ3eWJGZUpRNFViMDF6SWVrSDFMMTBBQS9O?=
 =?utf-8?B?eG1SSWwrR1MxTFY0cHJjOHVoWFpMS29IaVArRTBseGg2a3Bjb3ljblVkL25n?=
 =?utf-8?B?aEMrVTZCeENOV29yTkxlR1hITVRXcHZ5WHI0eWlsM0hSbUhpUzRieXRtMWQv?=
 =?utf-8?B?UEFwOUZWMyt6ZCs4QUtvc0ZIQ05MZFlEMEI4L0E2Y2JHc2V3NmdOcjRKZmRR?=
 =?utf-8?B?NEk2Wkl2VERuMTdCd1pLcm1nY256OVpJSlRIcTR5N1gwa0dxMldqdDl6V0dQ?=
 =?utf-8?B?ZTZVUE0yVURHWk5SUlB1TXpUY0F3U09qWDJnYUR6Vmk1K0R3SDdibUV4S2tw?=
 =?utf-8?B?SHNWR3doVi9WVU9aRGpCTjB1WVAxd0Z5OUE3OHlZZFdSVXlhZUJnSFNTK05W?=
 =?utf-8?B?SkhRTW1EU09BOGhNdk0xdWt5Z09yckIvbFBqa0IvaHRkcXdjSlR2ckV6eWxa?=
 =?utf-8?B?U2MvM3lNUTAySk9DanpubytnMHRrS2dlaVBjeEp4VWkvUlVQOGNibWlCMUxG?=
 =?utf-8?B?LzB5d2dVdVk0NnpXZFZHSGhmUkwxa25DcUdGNCtqa1lDa1hTNHF3QmxOSXJk?=
 =?utf-8?B?c1Jic2tGc256YTZFRTFaaGRMSUtPdUgrWUFSK3QwMEtzQjltYUVONDFiMjRY?=
 =?utf-8?B?ZFpqZUZYVmV5bEllYjJGYllydzMxc1BIK09XN0pXSGsvZVo3VldQTEd2M2xL?=
 =?utf-8?B?Mmd2TmhYMmlZdVAwWjlDRDNFM2g5K2ZmOEJCaGk0MGFyMTVlU1ZGRENNaUNr?=
 =?utf-8?B?WnNnazRPTUp0NzdDenJ4QmlsUHI0Y25hb1dkOUtRUTFPeXZ6QzErZWcwUUpZ?=
 =?utf-8?B?QkpGYkVuMC9zYzZoU3U2ZTVrdjlTNDQzeFNzdUZnaWFjeUpPdFdiK3ZabTNa?=
 =?utf-8?B?eHF2OVl1d2JIL2k1eVVzMzlKZmlWMHEvQTh4RUlUaGl2UGh5L3pEa0trYyto?=
 =?utf-8?B?d215SU1hOUJGWUFQd2IrQ09JYVg4bnBzWGFnUFRjd1dHRUZ1WVhWdGtvOFJK?=
 =?utf-8?B?b3l2VDRSOEs3cUxQTUlZTDkxWmRMZWZDSmxjWG90QzFoOXVFazdwajVpQVRD?=
 =?utf-8?B?eWJZU2tqQ3MzWERYcHc1QlFHaWw3K0cwTEducWJzTnExS295RGJZTTN4VWVN?=
 =?utf-8?B?OWppaUdpT2xyQ3h3WHFUNWVlVzhQQi9YRktCUDJmL1E0WitmQU5EZDkveDd0?=
 =?utf-8?B?VnVuK0NNUHJ6RTdPTzVqbDRwSlFnY0l2ZEt1ZUx4MHpNNzViRkNKNTZGVEdO?=
 =?utf-8?B?eWpsWmIzZWtZYWdydTFRcHpKYlBNVzhlKy9Ia1RvQXBwUmFldm9wQUY4VkJk?=
 =?utf-8?B?L1lPMlkzM3Y5c2lxWkN1M0ZFUFlURHJVM3ZBNEdSMEZNKzY3b1lvMTVINnJL?=
 =?utf-8?Q?SDHhDYimlkXBax1og6z5PC1r8olyRM60wBtMU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F9932CD4F53864EB7E2A110158BB414@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23e8d6a-9871-4227-d954-08da21d1ccc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 06:56:59.2834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oooskTWjGS0A8wo6r1cw0RJ23vg5M2Y3Wgp6J5cAtXNY+FvT85L4WypLjBfvSdxM0qAou/445stYtievvWgGGJNjdOYYdlYEf5f8zPMPO1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2282
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

T24gVHVlLCAyMDIyLTA0LTE5IGF0IDA5OjQxICswMzAwLCBHcnVtYmFjaCwgRW1tYW51ZWwgd3Jv
dGU6DQo+IEhpIFRva2UsDQo+IA0KPiBPbiBUdWUsIDIwMjItMDQtMTkgYXQgMDY6MjQgKzAwMDAs
IENvZWxobywgTHVjaWFubyB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjItMDQtMTggYXQgMTM6MzYg
KzAyMDAsIFRva2UgSMO4aWxhbmQtSsO4cmdlbnNlbiB3cm90ZToNCj4gPiA+IEhpIEx1Y2ENCj4g
PiANCj4gPiBIaSBUb2tlLA0KPiA+IA0KPiA+ID4gSSd2ZSBzdGFydGVkIHNlZWluZyBpc3N1ZXMg
d2l0aCBteSBpd2x3aWZpIGludGVyZmFjZSBnb2luZyBhd2F5IGFmdGVyDQo+ID4gPiBzdXNwZW5k
LiBJIGdldCBlcnJvcnMgbGlrZSB0aGVzZSBpbiBkbWVzZzoNCj4gPiA+IA0KPiA+ID4gWzEwNDM5
My4xNDIyNjRdIHdsYW4wOiBkZWF1dGhlbnRpY2F0aW5nIGZyb20gNGM6NjA6ZGU6ZWE6Yjg6NTgg
YnkgbG9jYWwgY2hvaWNlIChSZWFzb246DQo+ID4gPiAzPURFQVVUSF9MRUFWSU5HKQ0KPiA+ID4g
WzEwNDM5My4zNDc3NzVdIGl3bG1laSAwMDAwOjAwOjE2LjAtMTMyODA5MDQtNzc5Mi00ZmNiLWEx
YWEtNWU3MGNiYjFlODY1OiBDb3VsZG4ndCBnZXQgQUNLDQo+ID4gPiBmcm9tDQo+ID4gPiBDU01F
IG9uIEhPU1RfR09FU19ET1dOIG1lc3NhZ2UNCj4gPiA+IFsxMDQzOTMuMzQ3ODc2XSBpd2xtZWkg
MDAwMDowMDoxNi4wLTEzMjgwOTA0LTc3OTItNGZjYi1hMWFhLTVlNzBjYmIxZTg2NTogZmFpbGVk
IHRvIHNlbmQgdGhlDQo+ID4gPiBTQVBfTUVfTVNHX0NIRUNLX1NIQVJFRF9BUkVBIG1lc3NhZ2Ug
LTE5DQo+ID4gPiANCj4gPiA+IEFuZCB3aGVuIHRoZSBob3N0IGNvbWVzIGJhY2sgdXAsIHRoZXJl
IGlzIG5vIGNvbm5lY3Rpdml0eS4gUmVzdGFydGluZw0KPiA+ID4gaXdkIGZpeGVzIHRoZSBwcm9i
bGVtLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIG9uIGEgNS4xNy4zIGtlcm5lbCAoQXJjaCBMaW51
eCBkaXN0cmlidXRpb24ga2VybmVsKSwgYW5kIGxzcGNpDQo+ID4gPiBzYXlzIHRoZSBXaUZpIGRl
dmljZSBpcyBhbiAiSW50ZWwgQ29ycG9yYXRpb24gV2ktRmkgNiBBWDIwMSIuDQo+ID4gPiANCj4g
PiA+IEFueSBpZGVhcz8gOikNCj4gPiANCj4gPiBUaGlzIHNlZW1zIHRvIGJlIHJlbGF0ZWQgdG8g
aXdsbWVpLCBzbyBJIGFkZGVkIEVtbWFudWVsIHRvIHRoZSB0aHJlYWQuDQo+ID4gDQo+IA0KPiBD
YW4gd2UgaGF2ZSB0aGUgZnVsbCBkbWVzZyBvdXRwdXQ/DQo+IFdoYXQgTklDIC8gcGxhdGZvcm0g
ZG8geW91IGhhdmU/DQo+IERvIHlvdSBoYXZlIEFNVCBjb25maWd1cmVkIGluIHRoZSBCSU9TPw0K
PiBEaWQgeW91IGVuYWJsZSB3aXJlbGVzcyBvcGVyYXRpb24gaW4gQU1UPw0KDQpBaCAtIHRoaXMg
aXMgQVgyMDEsIG9rLCBidXQgSSBzdGlsbCBuZWVkIHRoZSBwbGF0Zm9ybSBhbmQgdGhlZnVsbCBk
bWVzZyA6LSkNCg==
