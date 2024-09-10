Return-Path: <linux-wireless+bounces-12751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080697346C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ABB0B281E8
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E9199920;
	Tue, 10 Sep 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhmSSVgl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F51199948
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963974; cv=fail; b=mSLVSmX4CDBHlBPlY6DVMTEp1rtuRoHheEG1GWY8gH4L77fu7hSEvann90Dkq5OBjGmvKBBl/Q9uixcu6iigrxPwU47wPmWS23tqOa0ENf0cqxscWAi8lnKWSQOlEtNth+Z1SRGdUQexeJnpo9VCzlab0xHGwmTMdOTS/zu4o2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963974; c=relaxed/simple;
	bh=zth4BIeT64C22VUCaJ3vjiiYvccoFN0+H1QhQgYU66c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jats2SXzfi5DhdhhV3T5P9XDGOAR+7xlC0vDOWWFHcf4cbwl56y5APiJK/etHP0Jnn1h2akkxdWsgimi7Y0dPd/uirXGwJW8Uom1PGqO9lph+qJMGoY7OgDPLtcGfR38ymxcM4q+CGj5ghQLgvOPuW0pfJnTEEEikYxFKbafSRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhmSSVgl; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725963972; x=1757499972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zth4BIeT64C22VUCaJ3vjiiYvccoFN0+H1QhQgYU66c=;
  b=FhmSSVgle/9k0/Mzp0ijExuYzRYVNQxXZJ9gaMh/UZT8j+qglkE1uB38
   eGXra8fvSCx8PTCc8Qyox15khmfhxFteFGN9F3AhqKW5CcBADPX99mW1o
   Xoktn3sY3Ti3U8iHX/JZhszMz1aTVABzfq7q2e9KgZx2pH/Jq991+tyHO
   Vu82a7kWFSeOeH/l2rKz1EcixdqOYaTRDRtHs+U+h8/ZIcJIELOR0xjtO
   OUbRFTQi3LxC3dYUSB3NfWUfDddaGRjjZS6S/r/lyUaEOMQ1UA3MvNTJ6
   woEcnCk6FMS7ahdE/8+8ggjvTNis/EyEWhryGkhPmqdvwMSY+uQygT4uQ
   g==;
X-CSE-ConnectionGUID: G2UbMnj4SsWhMUbza1OQlQ==
X-CSE-MsgGUID: RLNCjkUZQ92QUXNx4BuJOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35367678"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="35367678"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 03:26:12 -0700
X-CSE-ConnectionGUID: U1eWbGm0RBWAGvoP9iHOWg==
X-CSE-MsgGUID: WicoZZrMS5eGCFdRpsmEIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="90268634"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 03:26:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 03:26:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 03:26:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 03:26:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 03:26:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdd1UImAe4lzp6d/Sm2p01PZ04b573hKiCT7yMVguQnpyoUP3t78h0NlJ4RfVHXh2Ay4WE1aoIeTGD+icKL0A9MPUyfPnrNcJ6Ct7Sm5foiEUfEyMKDns+5/ohxyqZD0weUCmcpi/38Zx2S2goK2IYAGo8PqfDjrek+1n4TIzafBooooBEhXovYVD6SdPzdfR9ureiPrLMqhBTLip3BPL2rL3TuFykC3HKkYtTWJPZWCYyc3U8GvVX1m4VUYJKGOT0z+Wtp/DlJGFiSVJHMKxKlKG11D9ICJ1YX/YiO99XmMZbJGhwIvQKs9JOelwURG2eP7+j/MolwOj/ZJy10GHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zth4BIeT64C22VUCaJ3vjiiYvccoFN0+H1QhQgYU66c=;
 b=qusaW+F2ZF69MEF2EdfWf6X8U8c0oUczGm2tWo9833OS3pweINJYndRKqrTM8dwiPZRk4nlIDi1xJGli39/B0BSa2zdQpKWvhzcBYnS/WIy+KOc9aXd6C7IdbGiJNvjod5HSHj5MLoAN2S/vcS+Gyg8DS4lvFQZbsYCpMUPtxvvNo2JkFza6EGDdNETRbGUEidhU601VuRmZy6q0ad2fSXHp3XI0cA8nrYMitD/We7tda1hcAyFJa73KqBFEKxC5Q8+LuyyYWKaEeQNOv6PQVc60feRHbWbtjBlLO2yxf81tLc3jB3cgoWgYx+PTP4qVF7+Q32CMacR2eEYKyGDQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by PH8PR11MB6706.namprd11.prod.outlook.com (2603:10b6:510:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Tue, 10 Sep
 2024 10:26:02 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 10:26:02 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "chris.bainbridge@gmail.com" <chris.bainbridge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>, "Korenblit, Miriam Rachel"
	<miriam.rachel.korenblit@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>, "benjamin@sipsolutions.net"
	<benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
Thread-Topic: [REGRESSION] iwlwifi resume error, bisected
Thread-Index: AQHbASid0CU63h7wCU2RsueU4ZEG+rJMpxoAgAAufYCAA+5CgIAAEYCA
Date: Tue, 10 Sep 2024 10:26:02 +0000
Message-ID: <36b0f88ff0f17e0246037d5f834ac545afa69cf0.camel@intel.com>
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
	 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com>
	 <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
	 <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
In-Reply-To: <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|PH8PR11MB6706:EE_
x-ms-office365-filtering-correlation-id: 99b953ed-9b82-4f15-6ff0-08dcd182f884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TTIxeUM3eHFGZzZ2SDJ3U3JQRVJNT3N3eEN3NEd4Z2RrMmkrZ2I1RnFUWklF?=
 =?utf-8?B?Vmt0OVhzd3dibWc2azJZMU8xdCs2RGxRN3BFQjM2a0w1UnNSMnUrMkEvaGtW?=
 =?utf-8?B?MFRyazY4cmFrY2dWc05ldG50V0txdENwSDNEUTNNWGNQaFRRZ2V0dlEvR2xR?=
 =?utf-8?B?QmJWSVJpZUMwY1EvQ0YwMUl6Vkt5KytvVXlSSk9ZSkxLNnhYTFEvR010MWth?=
 =?utf-8?B?TzFjMS94YUh2MG1oMlFSMStGYXFCQ2FGNzRvVEhJbmFlR01sT1AwaE1RMlRx?=
 =?utf-8?B?QUVkUW9Zdzk1NEZ2UmdJR3lkeWlBbTI0elMrQkZtTUh6SXJBWG0vNlR5c3R6?=
 =?utf-8?B?STIrU2F3UTlRZURKemJMS1lKbUdlWk4zUG91WkVuQnlMTndPVzlXeGQ2b0gx?=
 =?utf-8?B?ZTZGL0k2TDMwbzZ4cHZzakUxcyt6ZVVZWGtGQ2FvZjJyYVZPK21yMWFHUVVG?=
 =?utf-8?B?NU1DQllsMGIzVU9nMzR2dU16NE83Tkg4eXBTMUtQbEJIN0NxYjEwcFY4eXI1?=
 =?utf-8?B?ZHFZczRUZmxlYVhWZXUwaHlOaFdFY0xLZ3E0S0dLNFBROWFRa0pqNjFrQ0ds?=
 =?utf-8?B?TG8rZWxjUC9Xd2oyRnZtMkh5QWRzQ0Fyd3JSY0FlMmdSa0l3RHY1dW8wcDFx?=
 =?utf-8?B?NXZxdDVKTmtsYnFCYzc0dGtEdXIzaFl0em5xZDhjR003QmFMYU84OUk5R2Vt?=
 =?utf-8?B?T2Q3NHlmanJKeUcwMnNSOXMxcytUc1VzdTJaN3lMMlRSNlE1TkU5UFFVMWQx?=
 =?utf-8?B?QXo4Vlg2VDZTV2tCM2dTUW1paTJGNW8yZ1lBUDAwYTZtdSs3UXpIUG5SNVh3?=
 =?utf-8?B?ZjRDa3RsUDdZdjgycTNIMUo0UUNST1VRaW5Edk1wbUxLL0dlUE1YeXBPMDZH?=
 =?utf-8?B?TllFQjcyZWR1OERyS2pqcFQ1clF0dndWeFU0MTRjdDdBU281RjBhajNmc2tF?=
 =?utf-8?B?SkFEWmtTSThQVk9uWDBMYjVEc2d0S0V1clpMRHF1Zlc5VVBFQ1pNbGl0bzhQ?=
 =?utf-8?B?aVA2NjNUS1oyaTlmc0FQTm5aSnJZNTZLZzdpRnZkaWNZL3FmdXdLdWdCWnAr?=
 =?utf-8?B?MlE4Y2N0R29DZVpHV0tWQ3ZyT2VIODNwaTVtaWRCV0F4OHRsZGRjcTJWZERC?=
 =?utf-8?B?K2pvOUFZUmpGaU1BZ2NZeVRJTGlrYjgrd1lJbjhxQ2F3R1RwbmswUlJYVkpF?=
 =?utf-8?B?Uk4rK1JCWWYrZ2lORmlYV2lTd0hMTzM3M1QxSnlYVXd3QStNaEVvSm54aDds?=
 =?utf-8?B?YkhYSDVtUFNuNnZzcVZBZXlVdzAvWmp0cUtnSjhWaGFCUmlZeWxBZGRzMjVS?=
 =?utf-8?B?VzArU3B1UnNNTlpJYmdFTlY2RWtVNFZTTzN6M3pDNEVOY2RpK0d3aTJ2engx?=
 =?utf-8?B?U0s0a2UyZ1FkTzNvVnltaGdkb2d2OWlXN1Y1TTZHUTdaV0s5VDdWVkpNT25o?=
 =?utf-8?B?cWhneDZ4alhXWER6MWplR0g1L21SWStNYWlSaUZEdjlad3k1Rzl5UDQ4eU5h?=
 =?utf-8?B?ZGtRQ09OWFljNXVscjBIejZIMXpOYnJuN3pkRXV3bXgyL3NzdUhCR3Yyd3h0?=
 =?utf-8?B?NHRTTDdldy8yTHQwMXRQd0RtdmFMU2cvWkx2b1dSVWcwSFNCdjh2a0ZVTFYz?=
 =?utf-8?B?cWg2eW82SDlVbktRS2hNUUl0VU5VbVpzWElmS1RDeWgxN0VOcU15aHVsL3l5?=
 =?utf-8?B?eUlLTldIVUlpa0s0V09CbWlqczFJaGVKY0ppeTZJTjg3R3ozZjdiZXlCNzBr?=
 =?utf-8?B?djhhNjBHVVE0aTQxaE1VVVB0cmJUNzNQSHc0Y005VHEvVWRNbzVhbE13aHJV?=
 =?utf-8?B?N3ZwNVhaUkkzUHl6M2pXNUVmL2JsZERkRml5U0J0VzNpVUNtbTdrTC95OUFZ?=
 =?utf-8?B?akEzQlVMTEVCM25MUCtaSjMvRnhEalJwS2tobXNNVlNwRFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEhxVGdKVCtSOXhyeGgwNDRjTWFlQkQveitybTZKeXdZMUM2azdOeGFnelBT?=
 =?utf-8?B?UDA0Tm91QzFvcmd2WDhFMmtPNEsrc0lEMjBrSWR0aDlGdy9wMFpDdlZMeXNo?=
 =?utf-8?B?RHFDdnduOWlxek1MMDRwYWY3dk1vUUxOWjhTS3VkQWo4QWVOZkg1VnhlN094?=
 =?utf-8?B?R2VXMEFNdjFYc0s5NEdnU0lKMWZnSzFXQjVkenkrMkpsTWloZGNJSmtURE9x?=
 =?utf-8?B?MEs2aGg3V3JnNG55VWl5NkdWWHJLT3d3dFV1YnRqNEpRK1NSUEFIeDErdUxH?=
 =?utf-8?B?ajF6N0RKb2hPRGpteGovc09leWdnMlZJV2lndDJOOUNVSllLL20vYkpiOTFR?=
 =?utf-8?B?TzA5OFkvMERGRFZuaktxVndCR25DS0RGai9KSWVIM3Q1TE5wQ2drNkNRWkpi?=
 =?utf-8?B?VjFzMFAxSHBSbjN3dmhjMUxFNEpqc1Zra3VSTmlsWmhaL08zcHpvQXZDRDBD?=
 =?utf-8?B?L2JnZVZsK1V0a1k4N1FaWGIrVzk3NGVNNWVXVTF3VWl5N2JCZWxGK0ZhUUpy?=
 =?utf-8?B?RXI4VFFYc1B2QkxTSklVdmFqS2Z2MTF2SzJPck5VYUxOQ3dqYWJxVDVCZlpX?=
 =?utf-8?B?RjJvNElmbEZWVUZ0ZThuS0lCUmc3M0Z1dnZhL2tVeGFQYzhESGdGVERyMkVQ?=
 =?utf-8?B?MU1zMEIwb21JcmtOSjM5VmgrOHEwZFF2N0tVdkZJWDRYL0xvTnJzRWQxQ1do?=
 =?utf-8?B?dkwxSWF0UXJ6aTM5TUpHU09KNkl2N1NlWmVlMzRaRTRGNU1rcC9xQysvY2hx?=
 =?utf-8?B?UXZaL1pFSmFlQmFBWHM5QkdIdkFBYURoTHJIZGR4VmFBZjlSSGI3VmNKMFBx?=
 =?utf-8?B?bFVzTytXdVB6RFBpV2JiMlBTWkxCMmpVMWJvbnJ4SUw0TEJmYUFsNlVReHU0?=
 =?utf-8?B?NUlVc0x1RGVBQnNGbkk2dXlIai9MUGQ2ODhiWjhZL2dON0hKL1dkL2dOd1F6?=
 =?utf-8?B?YmE4NU1QdlJqajh0bTFXRWRVellqcWdCODRITW5WNmdFa1dZYTBPeVAyb052?=
 =?utf-8?B?ZjFlRVcyMXN1WVJNRXZVZGhTa3hjZmNBdU51Nm9tM0RreGc3cGdCYmRhZjZJ?=
 =?utf-8?B?bndSdnpVbHFOWXlSQVdpbkQ3VHgwVTZWMDBiQm1jZzZPdi9VTXhZb2pLaUxt?=
 =?utf-8?B?K2NSYVNlSUNmNHg4SWtxYmdJVFpDRnNMWmJpcnhBVXp6dTBoRG1uTSt2SGpT?=
 =?utf-8?B?VFc5M3ltVXJVQWduOWJGeWk2TEwwM04yRy95aVBsNlVJOHJycHVnTGFCb1JZ?=
 =?utf-8?B?U1RQRXJuQzBuZGhRMjlNTmtDR2VXMFFmVDkwaGRIUkF4bzZLNkRzMTRwRldR?=
 =?utf-8?B?V0RVZUl2V3liK0hpVzIxSk9pWFczWldiZDdSUEVhSFhFZ0Q4Zm9xWHdzeUJG?=
 =?utf-8?B?OGVJalVQZkMwNTZZdWk3K29jWDFUUnQ1emx0N1k3SGo0cFZBM1JJWkk2d0hO?=
 =?utf-8?B?ZE1ZV1kzdkJNby9HczNvbGZldkNxcWZlKzJTd0VOaEFYUTUrMmRLOEU4WEVX?=
 =?utf-8?B?Q1pJTEJZaVM1aUhOZ1BYOXdDZEp1SU5KWjBNZEZTMnlvSmpDdFJhMDJYQjdR?=
 =?utf-8?B?dFk0V3JOcEV4WkhKMENZT20xamxHTFNxd1E1RWh0T1BNeXhCK3VUa0Erc1B5?=
 =?utf-8?B?N2tMbDBMRGJHR3h5YW41eUlxRGhoZzZiSC9VRW5ycFlxVXNhK3R0ZXViWFh0?=
 =?utf-8?B?WHA4VWdtejlsSzQ0QmZYemVvYko3anFZSEUvY3M5VlowL21hREVyOWtadE8z?=
 =?utf-8?B?Z29wb2xwdENwS2RkbHdqMnZ5dkFubnBkTVMrOWxMbmViaGxrYXIrQjBzUG5J?=
 =?utf-8?B?WWJNZWkycVNaYm5yZDB1SnRqU1oyOG1DTVdmVmlldlNSWFlLS0pYQzBjZGJn?=
 =?utf-8?B?ck84NzZxUDB5b1lUaDlFdlQ4cmdPS1BMSmJnZy9xcW14elV0MVdaWm1BOXRX?=
 =?utf-8?B?cFAwMXN4eFI3UTRHZ01xblhaUlNySXdhVVB0d09JRTQxS042Wk9Va0U2UUNl?=
 =?utf-8?B?ZU90djFlai9tUGRpaGtyQXNKRExlQWNQWWFEazVLZndkTmNVL1kxOHhtVW9G?=
 =?utf-8?B?OWxJWUk1alJvQk9iSE4zV0JUU2hWQXV0L2d0d040M0FFSWdid1B4TFJBNUxH?=
 =?utf-8?B?QmlCdFVvMXdEN2x2L2ZBTmNNeVlKbE1rZmRTZ3ZYRXFHZEF4QkQ3UlRZWW5q?=
 =?utf-8?Q?XMgOIedx3wGSMIi5tAqfpkw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B748CDCFE7EE940A8854A51DA03F97E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b953ed-9b82-4f15-6ff0-08dcd182f884
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 10:26:02.4548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOvYPupCCrZ3ceMXb1rDUnHAOn11Emm7VhQZO5IGniCMikmopUyKw3FAUjNN48luWSpEK/vqUjjrpSIz9tN2jT6NlNvAWt9AuAGotLANipU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6706
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA5LTEwIGF0IDEwOjIzICswMTAwLCBDaHJpcyBCYWluYnJpZGdlIHdyb3Rl
Og0KPiBPbiBTYXQsIDcgU2VwdCAyMDI0IGF0IDIyOjIxLCBDaHJpcyBCYWluYnJpZGdlDQo+IDxj
aHJpcy5iYWluYnJpZGdlQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSXQncyBwb3NzaWJs
ZSB0aGF0IHRoZQ0KPiA+IEhQIEJJT1MgdHVybnMgb2ZmIHRoZSB3aWZpIHdoZW4gc3VzcGVuZGVk
IG9uIGJhdHRlcnkgcG93ZXINCj4gDQo+IFRoaXMgaXMgbm90IHRoZSBjYXNlLiBTdXNwZW5kaW5n
IHdoaWxlIG9uIGJhdHRlcnkgcG93ZXIgYW5kIHRoZW4NCj4gcmVzdW1pbmcgKHN0aWxsIG9uIGJh
dHRlcnkgcG93ZXIpIHdvcmtzIHdpdGhvdXQgZXJyb3IuDQo+IA0KPiBJZiB0aGUgbGFwdG9wIGlz
IGRvY2tlZCwgYW5kIHBvd2VyZWQgdmlhIGJvdGggdGhlIGRvY2sgVVNCLUMgKmFuZCogYQ0KPiBt
YWlucyBQU1Ugb24gdGhlIHNlcGFyYXRlIFBTVSBjb25uZWN0b3IsIHRoZW4gc3VzcGVuZGVkLCB0
aGVuIGVpdGhlcg0KPiB0aGUgZG9jayBvciB0aGUgUFNVIGFyZSBkaXNjb25uZWN0ZWQsIHRoZW4g
dGhlIGVycm9yIGhhcHBlbnMgb24NCj4gcmVzdW1lLCBldmVuIHRob3VnaCB0aGUgbGFwdG9wIGlz
IGNvbnRpbnVvdXNseSBtYWlucyBwb3dlcmVkIHZpYSB0aGUNCj4gb3RoZXIgcG93ZXIgc3VwcGx5
LiBJdCBhcHBlYXJzIHRoZXJlJ3Mgc29tZXRoaW5nIGFib3V0IGEgcG93ZXJlZA0KPiBkb2NrL1BT
VSB1bnBsdWcgZXZlbnQgd2hpbGUgc3VzcGVuZGVkIHRoYXQgY2F1c2VzIHRoZSBlcnJvciwgYXMN
Cj4gb3Bwb3NlZCB0byBqdXN0IGJlaW5nIHN1c3BlbmRlZCB3aGlsZSBydW5uaW5nIG9uIGJhdHRl
cnkuDQoNCk9rLi4gc28gdGhhdCdzIHJlYWxseSBwb2ludGluZyBpbiB0aGUgZGlyZWN0aW9uIG9m
IHRoZSBCSU9TIG9yIHRoZSBzeXN0ZW0ncyBmaXJtd2FyZS4gU3VyZSB3ZSBtYWRlIGENCmNoYW5n
ZSBpbiB0aGUgZHJpdmVyIHRoYXQgaXMgbm93IHNlbnNpdGl2ZSB0byB0aGF0IHByb2JsZW0gc28g
aXQgcG9wcyB1cC4NClNpbmNlIHdpZmkgaXMgYXZhaWxhYmxlIGZvciB5b3UgYWZ0ZXIgcmVzdW1l
LCBJIHRoaW5rIGl0J3MgYmV0dGVyIG5vdCB0byBmaXggdGhhdCBmb3IgdGhlIGNvbWluZw0KcmVs
ZWFzZSB3aGljaCBpcyBhbG1vc3Qgb3V0LiBJJ2xsIGZ1bm5lbCB0aGUgZml4IHBhdGNoIEkgc2Vu
dCB0aHJvdWdoIHRoZSByZWd1bGFyIGNoYW5uZWwgYnV0IHlvdSdsbA0Kc2VlIGVycm9ycyBldmVu
IHdpdGggdGhhdCBwYXRjaC4NCg==

