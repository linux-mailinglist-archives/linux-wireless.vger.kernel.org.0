Return-Path: <linux-wireless+bounces-3196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A273584AFFA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A661F21B3B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA761CA8C;
	Tue,  6 Feb 2024 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jt4kQ7Ci"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5BD12BEA2
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208356; cv=fail; b=mWhMsP10qzf/uPEgFinp7zcMK2nJgU/qX4QiREAN9ecT3SrgaETY01yTMni5mllzBjqFhsKSbhOgbzE3xZzMeiV6VWGFeBYxfCILw1rI8vXfmJ5mpIvbUpwzyUuf7wkrhiVQMCxerJBThQcrmqJrSP9daHCUgX5Sl9WaD3bA0cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208356; c=relaxed/simple;
	bh=/SlVhou+lZxTT8osZs9hkVIJsAqlgwdQylOIC6shQcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=doQrK+o/ftjZ6WiWN/hb5QnZJXqBoU1W0B4Gmqnh9yZ8zbW+zjsJpzKN2g/XgMNvZvJsPPSS8uQ/a0GbKH451W8igKVqhNvQ5I/oDB8N+dt2G6IVWutVDbeOARnVjBo9LeDoE9gkaAj5ejgp4jzK2Gup3uRsPZruuvhJh/iRRcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jt4kQ7Ci; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707208355; x=1738744355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/SlVhou+lZxTT8osZs9hkVIJsAqlgwdQylOIC6shQcU=;
  b=Jt4kQ7Ci1YBMDtSDUwmyNPD8d7FsuVLz4kGwEzm70ZhXJGNHLl5hjzHB
   z9BtiwjLvrf1ZA6bQYR7kbno63YLrLg1dq5cMUo0pQ4be+MqWwUK3/a2V
   rtOnExwgzGt5GiclKTn9J0sTP9ihEXEpmlPN9d2C4mnyd1gu3hWAZUFWQ
   LtlEfS0qLA16Sv2Q1rluwdifYrS0kV6VM65pSEv21vy2iuxaQQqIfBlmS
   8lp6l0lG3JwWy4Tibl1/8ZywtQ0XfZVx3yLv/dvq9DldkM8iLSGvVtc2I
   73ZfbBr6N02Iil42SK+AsXXZ9d7BGW0xW9fwagedhJuMmGr484WS3HcMI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18216464"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="18216464"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 00:32:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="31773841"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 00:32:34 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 00:32:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 00:32:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 00:32:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIwheedZJuhKse/+kXiiXqTf7Eo7LzPoBGWkPcDuuFgj8vcGmWth8XSvDFWuHU27k8uJ79GoAL7OAhijmpgWVOQV2ptkQHrbFVMzoTUNXCU9ncSi4I8GHAVOtAxEbWZlNoRX89qfX3xBrPxuQf/3jLhGL0HSskPwMpJ0ugo0Sed7XiTfFS0EAawxQKYs+wH/EcEHd/NlFJt+GfMhGPJGD2tvlob/SiKSMV11JB1WWks7OhwFjog5kR6bFKnS8It6Ktw8jTs3iYPcmEbIqEL9Gjxre5rVO+Pu38tdtVB5gPgb4MtDBw0AgvT9dKUPo2ygfh3EUjjRe8txZ6QihYxl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SlVhou+lZxTT8osZs9hkVIJsAqlgwdQylOIC6shQcU=;
 b=GNUd0DnHp6NRUhUadLWqKQIQvHS9uhiJilZ1PahRX7ZaXFdLOLAAUb3hcx3iGE/VcV3QHzA6F+ANVtqEZAq+gnpB5P/9IuwEJSYfECDTFBIfTl6zYPxBswufj+FF4Qy8hEWIYrHo4GnzJ/sqMx7clLCo09bzKLQBumRxhrD1Zq5Q50AnfenwNDFBuLiAAc0HbZKkL3NVogbTkPbn37to70AmVaGgFed4AK2BIbqtQnlvoFcyiXolG9guHxjKtSkc073gvJr4J//tmmiJ7Vl9CkAQ/c1lKT9hgirs74Jy3EK+t2/T9icU0HmoEMmaq3CybNb6KRBysWnpjef1RaztEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 08:32:31 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 08:32:31 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Sebastian Wiesner <sebastian@swsnr.de>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "daan.j.demeyer@gmail.com" <daan.j.demeyer@gmail.com>
Subject: RE: Missing firmware dependencies in iwlwifi module?
Thread-Topic: Missing firmware dependencies in iwlwifi module?
Thread-Index: AQHaUh7sQCUowhGaMU2X9E6GTf24r7D9COjg
Date: Tue, 6 Feb 2024 08:32:31 +0000
Message-ID: <MW5PR11MB5810F28AAF0E76D32DD87FD1A3462@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <3146ecbcfffeb1ca05c05f7d1f141711c15651a2.camel@swsnr.de>
In-Reply-To: <3146ecbcfffeb1ca05c05f7d1f141711c15651a2.camel@swsnr.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|MW5PR11MB5809:EE_
x-ms-office365-filtering-correlation-id: c5d480f1-5372-4e27-3305-08dc26ee293f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IpNOA8FegA6oQ4+6GJ0tLl1ZbKujADNDe7mrR5n943d9N8wSqvPU73a3qYWVexYBNK0Si0/TuWO+7JECtZMK48twWcfFrAbG+jY4gtf6HnPexzZxoL5nXkpCOwO13Gz0sPNIrgD7eD4stbdiulzHF3s/vvOsfKqJBy19dCfLqBYSdrDxd0k2JEo8Bxs3bl4HdUW7P6EDY6scbEV1ADBHFkuB0CRpFvjGirVLuUoXD2Wzmrtqa85UouS/a2yVl4bXk2nJ+2xNCQ4u7yooqI20qzwVvnWx+ejHguq8o+8TE7PyrIUxa2ONzNZvlDyV6WxI5bk5gdaPzcisbXtL3ScH6uckaG6XEEvuq7BYtsWEto761tKBHfUtw8nTxPCHLYHznyzI1+bvfcq1YyhcSOsnNn5+zf21kDqFzLFvd4WVQqZM88HqtY1ZnJZfw7j27Damxk84xieMap9I9eCA+BKy1nO+gpXDqdC7SelKHTc2LQ+zpT9h8qso9oyfDSIDRloSAItIFRIVSKJIsE3NMBOAD+8+7Awb8W35fRfPE2LU9hA/Wr+MfCo8KO4xvaAXRZcj08uzP0Idv3S0WSQLuvJSa4/OmxD1pZz6TCwtixv30mo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(52536014)(2906002)(55016003)(41300700001)(83380400001)(38100700002)(26005)(122000001)(82960400001)(86362001)(33656002)(6506007)(7696005)(9686003)(53546011)(110136005)(64756008)(8676002)(8936002)(71200400001)(478600001)(66446008)(66476007)(66556008)(66946007)(76116006)(966005)(38070700009)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkNEQVRpR3FMY2xXdktUOGZnN2pFcTNtQVlWbjhiQng2Y1lyZHg5ZUV0Q3pV?=
 =?utf-8?B?a3dhendSclhsVm41alpaV2Y0YTNEMmpoVVExekJXTklsYjR2N25ON3NhTjRD?=
 =?utf-8?B?MUFRSkxTL282NldNbDJNWE1nRjhINTI0VksrT1ZuYkx0dVp4UjNDak1TaU5F?=
 =?utf-8?B?aERRU2JrQ1RvaHYrTFBXWjQramJWVFlLV0x2Zkw0aWRaZUVuMjl2clpHQXd0?=
 =?utf-8?B?S3A2RVJ1cmo1WjV1OEI3VGwwZS9EbXJTSHU2RmJKbER1QUIyYkFpaXNNakpX?=
 =?utf-8?B?dXhNa3Y2d1BpS2VWcjRNTUR4UE84ZWU4TFR0enRIbE5RRmhqS0g3eDdqK1A0?=
 =?utf-8?B?czJLZEY3R3Y2UEJmUTRWa1ZZdVZLejVXemUrRHpiNS94TzhRRDFWRmpjdm9y?=
 =?utf-8?B?Y2I4emtLOGszdkU2MGNiSC9QRWE0eUkrQVhqQjJKT3p5SW1iT2lmQUMrckU4?=
 =?utf-8?B?VHVubW94ejBuRXovWTNoRnNjNUhmd2p2eHQrMHlFWUhBL09pbkJKcUNaem5j?=
 =?utf-8?B?WUFYeUZqL05kVkpPeUhDdVkybTh0WlZUNjM3dzNrRUxJMFFLWGgzb0J2RTNx?=
 =?utf-8?B?c2RzQkwwSlA3TE1qQ1pQcFFoL2ZwVGl1VUJjK0RSdGR5OUZwY24xQVhxdkVG?=
 =?utf-8?B?bnZ2SS9TaG9IL3Z6TEpJNmFEb2pLNXRmd0FLckJtZ2VuYk14VzA0RUN1SFlh?=
 =?utf-8?B?ZDc0TkI3c2NmTmFCQWNqZEprdXJ2NEpnUW45MjNaYzg0OGVjWGxPQlRRZXhj?=
 =?utf-8?B?MDU1THlSNnZVYUZwR1VnTmxhMHo3QTdYVU92bVc2MnlkUTVDckVYZkhNZWNx?=
 =?utf-8?B?am43SHJ0NmJUS3VYdlkwWFQzWEZrUDd5Q3YxSE5lajhCdWVMSktJQkZkTkhx?=
 =?utf-8?B?d09IaU5kZU9RM1hRMDlEVUIxSGdEZmx3SU9hTkdqVWVQU0ltT1haMXYyMVk2?=
 =?utf-8?B?V042SFBlY1pxRnVHM2Q1YzNabkZKWVBkSnpNNzg2ZTJQeEczcjd2blE3TnJM?=
 =?utf-8?B?VlFUSmxQdHNXZE9NS0xCbVVZREpiaStHRkpOL3A0cHNjUS9RQXp2Yk1tdi9Y?=
 =?utf-8?B?eXY1TXFLU3daZUpFbExyei9tR0RsaG1ORy9rb21GOCtSMVptL09EeXFMRGJp?=
 =?utf-8?B?MklxQ2dTd3dmWFhmTmFsVTNTK2YwcFkrY2E0UlNoa0tXbmFRcWNSUVB5Sisr?=
 =?utf-8?B?THg3SEZBMWF6VkovcC9MMm9ieFMveUtzWXl6NXJpV0hmNU8wTnVBaitEaGsv?=
 =?utf-8?B?VnBwOEM4eGpJUDQ0cHEzUlJMOE1DREhvZ0Yyb0JISXNPVlZtRE0xWnlCcUVs?=
 =?utf-8?B?S1IxNng1NXNQR3czVXNvdmM1NUp2K2NjQXAveHRyQWlNVjZpa1owS2xVRFFu?=
 =?utf-8?B?RHdiRHlCajM5WUNHR3ZWWTdkelArbUNGdXRGNFJhYkFnbzA2RUJESE1vcGZ5?=
 =?utf-8?B?YTRiWnJhelI5Mlp6SzNzNG1yTGJKa2FBOUxaTlZtZ1VQejRMaXZLUm9ySGQv?=
 =?utf-8?B?b3FYWnoyWlRzUUxNKzZvak1nQlJybXZVT2NISmk0L1lSaHFyK2l4a0I1endm?=
 =?utf-8?B?OUNCbjh1dEN6V0pZYy9sc2s4czZUR2FZbVJzNElodWZLeEdhTTQzWUhrV3h2?=
 =?utf-8?B?c1NsWWRUZWR6THljWUtMby9qbHBSMzBnNzVxcXZhZGZHNnFIV1ErQkdSU3A4?=
 =?utf-8?B?VlpXcERSR2dsYys3NU1WTU93a0pmS0duTndsdzR0bHBsRElCYXFLTklkL3pl?=
 =?utf-8?B?c3llR1hRSkhIUWpjRTB4NkJJSk1YcUZ3emNHOTJmM25JTFFKeWc3RnlRb003?=
 =?utf-8?B?QWtBNmJ5VmoyRFNiWTZUckR6OVVlYWhMYzNQTFNYUVMwYzgvbDNpL2NMQnRt?=
 =?utf-8?B?YmN4MzZMKzB2YVlrbXlyTExVWHhha1ZUQWVKSmE5QkpleEptVE5MQ2ljcURP?=
 =?utf-8?B?WnhaZGo0ZE9abWNXYjB6bE0wT1ZFaEhSZ2FzdThGaWFCdWRlTnpXb1VlMTlL?=
 =?utf-8?B?UTA2QmgydWltbVNtWWFBeEthZFJWQXY1eDNZdmRjK3o0eUNadk9FUFRvbG9J?=
 =?utf-8?B?cVVXQU9uR1JuTSt6SlVnbUZYUlJGUHN5NTZsbEp2S0hDcjZlcWQxSktDVU1U?=
 =?utf-8?B?R1RSVzg2ZmFLOHp2VnZvNmxJUkRkbVZVczA3alZrRG1ncGpQdmdDOFZic3hU?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d480f1-5372-4e27-3305-08dc26ee293f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 08:32:31.5438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtN8goDhXNjT1hpSTCItBOuzXnZ7mTLHZlF0kwkuwu8MRjtw3R55DPDmDPKy0mqLoaJO54OLmhxF5NLNdb3IGnEoV7Pr7/mXwzk2UndP/Z+JZ21NoBtHG40vEV30cLnn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com

PiBGcm9tOiBTZWJhc3RpYW4gV2llc25lciA8c2ViYXN0aWFuQHN3c25yLmRlPg0KPiBTZW50OiBT
dW5kYXksIEphbnVhcnkgMjgsIDIwMjQgMjE6MTANCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogZGFhbi5qLmRlbWV5ZXJAZ21haWwuY29tDQo+IFN1YmplY3Q6IE1p
c3NpbmcgZmlybXdhcmUgZGVwZW5kZW5jaWVzIGluIGl3bHdpZmkgbW9kdWxlPw0KPiANCj4gSGVs
bG8sDQo+IA0KPiB0aGUgaXdsd2lmaSBtb2R1bGUgc2VlbXMgdG8gYmUgbWlzc2luZyBmaXJtd2Fy
ZSBkZXBlbmRlbmNpZXMgb24gc29tZSAicG52bSINCj4gZmlsZXMuICBBdCBsZWFzdCwgdGhlIG1v
ZHVsZSBjcmFzaGVzIGF0IGJvb3Qgb2YgdGhlIHBudm0gZmlsZSBjb3JyZXNwb25kaW5nIHRvIHRo
ZQ0KPiB1Y29kZSBmaWxlIGlzbid0IHByZXNlbnQsIGJ1dCAibW9kaW5mbyAtRiBmaXJtd2FyZSBp
d2x3aWZpIiBkb2VzIG5vdCBsaXN0IHRoZSBwbnZtDQo+IGZpbGVzOg0KPiANCj4gJCB1bmFtZSAt
cg0KPiA2LjcuMS1hcmNoMS0xDQo+ICQgbHMgL3Vzci9saWIvZmlybXdhcmUvaXdsd2lmaS0qLnBu
dm0uenN0DQo+IC91c3IvbGliL2Zpcm13YXJlL2l3bHdpZmktZ2wtYzAtZm0tYzAucG52bS56c3QN
Cj4gL3Vzci9saWIvZmlybXdhcmUvaXdsd2lmaS1zby1hMC1nZjQtYTAucG52bS56c3QNCj4gL3Vz
ci9saWIvZmlybXdhcmUvaXdsd2lmaS1tYS1iMC1nZjQtYTAucG52bS56c3QNCj4gL3Vzci9saWIv
ZmlybXdhcmUvaXdsd2lmaS1zby1hMC1nZi1hMC5wbnZtLnpzdA0KPiAvdXNyL2xpYi9maXJtd2Fy
ZS9pd2x3aWZpLW1hLWIwLWdmLWEwLnBudm0uenN0DQo+IC91c3IvbGliL2Zpcm13YXJlL2l3bHdp
ZmktdHktYTAtZ2YtYTAucG52bS56c3QNCj4gJCBtb2RpbmZvIC1GIGZpcm13YXJlIGl3bHdpZmkg
fCByZyBwbnZtDQo+IA0KPiBJIHN0dW1ibGVkIG92ZXIgdGhpcyB3aGlsZSBidWlsZGluZyBhIHN5
c3RlbSBpbWFnZSB3aXRoIG1rb3NpLiAgVG8gbWluaW16ZQ0KPiBpbWFnZSBzaXplIEkgd2FzIHJl
bW92aW5nIHVubmVlZGVkIG1vZHVsZXMgZnJvbSB0aGUgaW1hZ2UsIGFuZCBta29zaQ0KPiBhdXRv
bWF0aWNhbGx5IHJlbW92ZWQgZmlybXdhcmUgZmlsZXMgbm8gbG9uZ2VyIG5lZWRlZCBhY2NvcmRp
bmcgdG8gIm1vZGluZm8iLg0KPiANCj4gVGhlIGltYWdlIGZhaWxlZCB0byBib290LCB3aXRoIGl3
bHdpZmkgY29tcGxhaW5pbmcgYWJvdXQgYSBtaXNzaW5nIHBudm0gZmlsZSAoSSdtDQo+IHNvcnJ5
IGJ1dCBJIGRvbid0IGhhdmUgdGhlIGFjdHVhbCBlcnJvciBtZXNzYWdlIGF0IGhhbmQgYW55bW9y
ZSkuICBBZnRlcg0KPiBtYW51YWxseSBhZGRpbmcgdGhlIHBudm0gZmlsZSB0byB0aGUgaW1hZ2Us
IGl0IGJvb3RlZCBzdWNjZXNzZnVsbHkuDQo+DQo+IFNlZSBodHRwczovL2dpdGh1Yi5jb20vc3lz
dGVtZC9ta29zaS9pc3N1ZXMvMjMzNCBmb3IgdGhlIG1rb3NpIGJ1ZyByZXBvcnQuDQo+IA0KPiBU
aGlzIGlzIG15IGZpcnN0IG1haWwgdG8gdGhpcyBsaXN0LCBhbmQgdG8gYW55IGtlcm5lbCBtYWls
aW5nIGxpc3QgcmVhbGx5LCBzbyBJJ20gc29ycnkgaWYNCj4gaXQncyBtaXNzaW5nIGluZm9ybWF0
aW9uIG9yIGlzIHNvbWVob3cgaW5hcHByb3ByaWF0ZS4NCj4gDQo+IEknbSBub3Qgc3Vic2NyaWJl
ZCB0byB0aGlzIGxpc3QsIHNvIHBsZWFzZSBrZWVwIG1lIENDJ2VkIGlmIHlvdSBuZWVkIGZ1cnRo
ZXINCj4gaW5mb3JtYXRpb24uDQo+IA0KPiBDaGVlcnMsDQo+IFNlYmFzdGlhbiBXaWVzbmVyDQoN
CkhpIFNlYmFzdGlhbiwNCg0KTG9va3MgbGlrZSB3ZSBpbmRlZWQgbWlzcyB0aGF0IGRlcGVuZGVu
Y2llcy4gDQpXZSdsbCBmaXggaXQgYW5kIGxldCB5b3Uga25vdyB3aGVuIGRvbmUuDQoNClRoYW5r
cyBmb3IgcmVwb3J0aW5nIQ0KDQpNaXJpDQo=

