Return-Path: <linux-wireless+bounces-26034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C583B13798
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jul 2025 11:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53A87A679E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jul 2025 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCEB25228F;
	Mon, 28 Jul 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mfuo+J4I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6822C35D
	for <linux-wireless@vger.kernel.org>; Mon, 28 Jul 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695312; cv=fail; b=Z0bZBerr25Gtm0R9V8vsCVMYClCHuO/zoIHipTh1ZCYWDtY5QrCVC9VK3rjNCHfs/n1gCH8IQjbByEqrDM9H4150d7HY5RqDji4BQo6u6aeYVm5JLYaPy3vi7ZR2aT4HtyLVXUTJXBoXR9WN1Tm2oDHUhIGu86u51L6VPVoZKNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695312; c=relaxed/simple;
	bh=T1HjQ3xuqa8/FWLgtmMklXn4JE+qcV+9b8x0V8XFfiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=km+s//UDoR+Ea8Xk6HE4mhuw/1M/kqzNSu5E1Rg7PmmWfZh/Bpjkr1GavIzjCNsFbajGWmWLc8UPQ1z0d7MdA+i6LqU6Ozob8vI7fIqapHpg0j6u5/wKXeAWiuzgK8ePldic74//daF0pB2FsqJULfjtXgXvKRprs3tJeZW4bj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mfuo+J4I; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753695311; x=1785231311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T1HjQ3xuqa8/FWLgtmMklXn4JE+qcV+9b8x0V8XFfiI=;
  b=Mfuo+J4Ia20Z9rp2RYYzbRAx+uAIYU7qpAVnpObT3WAdDePKTzzBeh2d
   w4rPhd8+2JQTEFqUCwHqMcauV0UwYDhPoNqp/VQnWxclWWNlvNbfQSwp3
   eOdrOoh14bZKNsoDkVo1CQVmyz1FIDwVnz8/fomwqxX8mJB8Rk9Tysbhp
   y8Jcv0We3+rJANs09Q42o2E46YgT4h7jHNULn9/wf7kcuMkJdRPSa2c56
   IJC/J3epJDkVdBcvyKGKinubyLRHt94zdKVqhrmlG4yhkuAsVu7i0Efou
   nE0go1+dWCCXYceyCB3xm3cLI+6Hwb3IJexS78EZguwOZeG7YCQ4wVI0V
   Q==;
X-CSE-ConnectionGUID: 4aIjtBajSli2Hl0ZqaP5lA==
X-CSE-MsgGUID: Vz9qWZWnQHmibm1VfVSjAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="78488363"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="78488363"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 02:35:10 -0700
X-CSE-ConnectionGUID: yj5a1RtbTmeAE2dB+VIjqA==
X-CSE-MsgGUID: zc4xbvywTwmVEcpCRKSkGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166844454"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 02:35:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 02:35:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 02:35:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 02:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EADJIca+50BHq/aPAV5mNHuuvzLvAJXH642zi8BH0wlq1tCVBzxC5hehtCayHmmYvXWo3XkEQNhLEK6nEONFIFDkQeWtwUpltwsuYIAqFRwrKmPCEfLSvYZmr9XsC81psjeHc9DvD/UeM0NIO5w5+X0r1PK2gMym5XQhzS/NyNpid2Rcof0WZbmwnEeHSoj7bH4Jn1jCusF9iSXnxR4RTbuG+l4jnFhpq1cUWSTVMkAsFg+FF4P1oFbRwnrp6bhcdwpiHL7hLxYleoh13wDV4JLuVHGWDysxJj0bI8kXXjfc65OM2JhVksdincIprnZbrb7t8rNGn5cJGXxxUL6b/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1HjQ3xuqa8/FWLgtmMklXn4JE+qcV+9b8x0V8XFfiI=;
 b=YnxPV6HAfzGx3naNBXVP3J5w2sbKciZyZwKrj/PBbnQSpqbajjJQ8f4bFGdG8UKIA8vxy3823sICOwn8kbWknVUhN43o9EndQvBI8pJlnZZZ37maJOO7OKN9RDkGYUDXm94lWgsdvlUEyqJ6Xm8i/QziXCEiM+AHt/W9adymbGQz2Ls5G+RkwE3zz1gGHEyoAABUIJ1WNvJeiECemYrCGdyQfKRkBUYlNCbfcz9q8go4joH+nqxVIeh12aOTy9RKo8196torgeL0fXhpjm9H4QLQvE3nLSzOg6m8oWEGV/cYsQIz/WLEkPfpsNDJNrbUb/WBUYNPY9j4mJWuisGRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com (2603:10b6:a03:457::21)
 by CO1PR11MB5090.namprd11.prod.outlook.com (2603:10b6:303:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 09:35:07 +0000
Received: from SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95]) by SJ1PR11MB6252.namprd11.prod.outlook.com
 ([fe80::9dc9:52bf:6024:cd95%6]) with mapi id 15.20.8964.021; Mon, 28 Jul 2025
 09:35:06 +0000
From: "Otcheretianski, Andrei" <andrei.otcheretianski@intel.com>
To: Vinay Gannevaram <quic_vganneva@quicinc.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"maheshkkv@google.com" <maheshkkv@google.com>
Subject: RE: [RFC v2 1/4] wifi: nl80211: Add more configuration options for
 NAN commands
Thread-Topic: [RFC v2 1/4] wifi: nl80211: Add more configuration options for
 NAN commands
Thread-Index: AQHb/Gmza/juQR+PkkWJ1U39mMmetbRHHpCAgAAtkRA=
Date: Mon, 28 Jul 2025 09:35:06 +0000
Message-ID: <SJ1PR11MB62523440745642D4A88C49BBF55AA@SJ1PR11MB6252.namprd11.prod.outlook.com>
References: <20250724100457.181825-1-andrei.otcheretianski@intel.com>
 <20250724100457.181825-2-andrei.otcheretianski@intel.com>
 <7a0b2eae-d6bd-4f26-8ff7-c569574b58d1@quicinc.com>
In-Reply-To: <7a0b2eae-d6bd-4f26-8ff7-c569574b58d1@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6252:EE_|CO1PR11MB5090:EE_
x-ms-office365-filtering-correlation-id: c1110b0d-dbfe-49ed-fab3-08ddcdba09c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d3oxYWQ4Y0hxTkJNKzgyaStBQ0FpMnUwSnRWcHJOVVY5Z0QzL0tDZjdrUXN0?=
 =?utf-8?B?Q2p5ME1aUTVLSkFJT29YYmxPa2NaT0ZyWTR5aGJteWdvSk8wK2MwVEVXS1Jl?=
 =?utf-8?B?U21uVHdLc094K3FqVDdNZGROOHdJeXRtUDljZHZqU3ZSYzZKK1ExTTNXZ082?=
 =?utf-8?B?dFQ2eFBaYkdUZHFtQ1FxZjQyQkNKaTQvL3NFU2tDSGVLTVNVWkNQdG1WckpW?=
 =?utf-8?B?V1UvVDJteEtIWnRZUXZWOGYrdVBtUVF6YkZ6ZlBRditvZFdGSUdTeW5lN29H?=
 =?utf-8?B?YWowbVZTNkxjY00zTktjSjBEWHo0N05EM1R1NHVPekFyN2lSYk5EeVlrWlJ6?=
 =?utf-8?B?ZDBGZGtKYTVoY3ZNajFDOExHcGYvcHZJWTJGbFE4V21BYkhNaDdjUXU4Y2p4?=
 =?utf-8?B?K2ZkTTE5V0xXWUZYOWJoK2l1SUlmeCttdG54eE5Vb1dDZytuZEo0WWs4bzlo?=
 =?utf-8?B?K3hrTTVsa1RCT29Kb3lCczZGK2ROTkp3dHJZQUk4WWhiMkxuYnZjMmR4OFZm?=
 =?utf-8?B?cGJDL0xGejVLRVpGNTNRdEdzWE5NMnBRRjBKVk1tMDdqQUFuREk0dTdSOTFN?=
 =?utf-8?B?TXQ2N3doVlFpaUdtNWJRNDJGQlh4OHpwOXpLQUI1RHNuT3hTb2d4Y1AyVUpr?=
 =?utf-8?B?bk96d2tuSHpGQjE2SUVFS1Y4Um5kTmxjelBDQWdXdW5WTEhlNzJYR3BGRnZy?=
 =?utf-8?B?d1VNOG5kYU53NFVtUzNESXdKTUZhYjJ3cHVpa3FJN3hJSmNCYW1hdUxTRUpC?=
 =?utf-8?B?TVlQTDFsQ05tdW5mYVptRnBQQnpoMXN1eUhSWk9Nd3VGaVdSaU5iVEtGeFBi?=
 =?utf-8?B?VlRvVmtyZDVsV0s4S3I1bTlkRzVuTVFrMHgreXB3R2RVQ1lRWFBLWlc1SlpD?=
 =?utf-8?B?K0gySCtFc1dsenlQY0tDRHprMFRSQXV5a2tjS3Z6NTVvTWhwWS9RZFhMUStO?=
 =?utf-8?B?KzZ0NlVKc1hWRld1QWo0OUVYZDNyamw4cU00Yzd3NWhQZVd0OUFNYlMzNGRs?=
 =?utf-8?B?dy9DYWRvc3paRWFlcmw0OTJ6NXdwcFI5ekdkSkpmMCtMRis1Q3B3UU5pUllQ?=
 =?utf-8?B?MDNrYVhkQy9IL0xJNXQvcFAwM0VjcjNlL0t6QmVUYm9vS2xZcnltY3BtVTBl?=
 =?utf-8?B?b2dRVjVqRFJ2MmtOb1NEK1NjKzBtSmxXMmdkN2tkMHlNekdqSXRZSUE3NXBy?=
 =?utf-8?B?UHJuRjZHWXNYTUlseE9jdXd5MmxNU3pzR3lRTFl5d3JBNHI5K1M0VVNTZStE?=
 =?utf-8?B?a2FnUmxnQnNZZk9OOWJvWEx5TnBoWTZpaXU0OHRpbEtUSWtDN29HM1k2bWln?=
 =?utf-8?B?RUxCbTROZk1WTUxvWmoxb01UdFUvcWhUV0c4NVo4RGc3UGtSOTRySUg3c1lZ?=
 =?utf-8?B?UDN0bHJrVWVqRVBzVDI3S1JhZ1BPUkxwNFpOYWxSbVNneC9qYmpmT1JDc2sr?=
 =?utf-8?B?cGFDek5DcXFiM2xSRzhxSXJvY2NrMTVyaVZNR0dKYVZVK0gyZnRMSjJpUC91?=
 =?utf-8?B?TWU1cjhRK1UwcXYyRVY3ZUZZRE5nRlozUWFQWENCU1NMS3d4Q2IwS3MvaHE2?=
 =?utf-8?B?Lzc4UEJsZFAvRENoY012M0cvcUJ5eGxaVVBjVGRscGdYRUYyWjBwL2xhdGdZ?=
 =?utf-8?B?OCtJY3E2QmhvMUdRWGtYcDliTFc3aHlHT2NJNHNHTWZzdU1IZkh2RklJSGNj?=
 =?utf-8?B?VmhKaXpRVGJrZHN2LytyRDZRdGFYbjdSdy9XNVlVcE9tZDJlT1gxeHZhVndw?=
 =?utf-8?B?aGJSQ3hlWFpnZENBaE1yUC9qSjN5dzVrTGsyWnhQSERDSzRNRTBPZGczRTdJ?=
 =?utf-8?B?ekpxbmE0anZaeGxPcjhZK0JrbGdCU0UvSzlqaVVGWEN1VGJVOXptM1l0ZitP?=
 =?utf-8?B?UEFPNVd4KzNiaVJSMzdaSEc2SHZFQ1JLTVRnRFhFc3RRQm44K1U0c1hPM3cx?=
 =?utf-8?B?MzVXLzArQ21td1cwSkZrWWF3eVJKOTM3dmRlQ3p6Mk0zL1U4Rm9QaVN1MVZF?=
 =?utf-8?B?K0svVnNYMWVBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c25SaWtsMW01OVpPb0R4cjV6NHBaMmdJY29GQ1I4NzZJSlptMnVjQTRLdEtj?=
 =?utf-8?B?cUFQWDFGOE1QdnVPZUF1Uys0WGh2dURnVlVDY01ZdTUrYTVYOHFjdzVPMUh4?=
 =?utf-8?B?cjh3V1Z3OTU3R2tKNUVzLys5dnZBMlZUaGdEOHozWS81ZXk0Z1BGMmJDOXlB?=
 =?utf-8?B?NmpxTmtwSG0vbER2Z1YvNCtKQ0lFbWxMNy9qb1lSQjgzeW56TUsyNm1Vd2pz?=
 =?utf-8?B?dU16akZsbjJxTGxsL0c4c0J2OWxBYmZEUEk1MG1hTzY5U1QyNVpaQVBOM21X?=
 =?utf-8?B?Lzk3YWR6c29LZm9LMVY3RzhDSkE2djMxUTMxS2VkbzZndENGb21oWThPT1Y1?=
 =?utf-8?B?a2lubThJQ1lyVUptbXoyTUtRck5oVGVDM2VIRkMwaDQ2ZUVPbm9aSG04RDhK?=
 =?utf-8?B?MGp5bUJ1b0IrWkgva3lJMlRoaGxBOTEzRDhEQkh6T1BvcmpHNU9vUktxMmhO?=
 =?utf-8?B?VllPdlRwR2hrZHlIS01MNmc5MCtpNGc4aEc5M2hCN3dLc1FlaVRCRkI1RGFn?=
 =?utf-8?B?dyszeXF0MWUvd3VjYitaU3o4VS9WTmhvcWZvNEcwSFhjOUhINFpvb3BXTThp?=
 =?utf-8?B?ODUxUTdFMU9nak9Rbk5KWWJCK1RiYTFVZVVFbHdlclRFYURpK0JZK0tNWlMz?=
 =?utf-8?B?MW1RK1RqLzY3UGd3YnBMZU1XbXFGcWJON2lpdWxHYy9HYVVFdFNXeWpZOWxn?=
 =?utf-8?B?L0pldENZZHU5UzdIeVRYdkNUbkFiNVovZnEzVzFVbVNwZFpQbytCZkVJMlM3?=
 =?utf-8?B?aTFHNnRvZ25wV2dIRGl1ckM1TGV1ZnFubHRueGRXcW55UzVaRHFjaTdPYUdH?=
 =?utf-8?B?cmpnb0dEZWR2UEFOUVV1YjZHYUdQLzA5NERBR25ZbnBCZ0w2eHZqZzF6d1Nu?=
 =?utf-8?B?N0VJMU9zVUNBUkovMUNKeFArM1dmc2NZRDJoWFQrWWN5YzVkSVVHWXUwbDNY?=
 =?utf-8?B?NnNGSzU0cVQyWGdvTXVNNFo3T0JKK3QxUU9hWElNcGFnWkYyQlhpZmxNNHNl?=
 =?utf-8?B?bmpSR3Vlb05VZmpCRzcvMFR3TWg0Q3Z3QjdrZ012WjN5VEhtZ1pPZkFwSXA2?=
 =?utf-8?B?UGVLVEJ3TmFUM1RtNHJ1S2loNWZMS0xIb3VMZDRpZkxQcFZPRnRUbnFCd29V?=
 =?utf-8?B?NVA3cStVb2dGSXlqUHprRU9xc2ZYYkZHOG9zSEN0ODErTTA4eFc0RnY4SmFJ?=
 =?utf-8?B?SjM1QjhQT0hzNVdMWVNPVWtrdzlFbEFVK3c5bW10L1BhOWpzV0hubnB3WE9j?=
 =?utf-8?B?bVY1SHI5NzJ2ck8vSmpiQno2MkxWekJncng1cWpJRVVNcjI3R0NXSG5NYnE5?=
 =?utf-8?B?U0ZZYkVma0FlTW9qajd0UldGSVUzTDlMVk9yQXh5ZllvaWNlbForcmRQSnZ5?=
 =?utf-8?B?RWdESXpVWTFwTFl5ZHNaWHR6MU5laGt1bElPaWgwL0pwdktGUThML2tVYlRp?=
 =?utf-8?B?S0czWkZsaGFzcmxEL0J5NU0vQTVIejVYelV0aFN0ZjJJL3ZXTWtOT1A5UWNs?=
 =?utf-8?B?U2t6SW5iTHpnLzZiUEZ3bXI2UFFhaVRzWTEySXVtbXhIK0dHZDlFZTFUVjhk?=
 =?utf-8?B?S3VocUZ0NGRid2gyNXBvREtZY29CaTdtOFp2Qkl5ZHBmQU1jSnNFcTEwVkNv?=
 =?utf-8?B?dlRCejhwd1hPZE1NR1dqemgyOHBsRlRHVS9vcW9yUlNPZkl4YUJyZlR4dWJV?=
 =?utf-8?B?Z0Q0TjJXRUN4czVVeWI0RUdhWHBIT2NhOUI0ZnpDV3BJR1dBTUQ1SzZRSVUx?=
 =?utf-8?B?dnRjVXhkbk5yUUs2dGRNSzNtVlB2em1RWUxKV1d3N01KajlHTnZUMjQ2S2Ns?=
 =?utf-8?B?ank3ZW1RUVFoWU9Cb1R5dUpHTDFQa0FDelhCUUdZZm1nVlZTekFSdU4yUXVO?=
 =?utf-8?B?SFc5OTAvK09qTEVjNVIzYklwZTBSc0VhRjJFRTkzVkZSLzU4QUxVNDJWaFpR?=
 =?utf-8?B?NUxrSDhOcXIzY2lEVm1rYWJUSHFJQVBXNWdGS1RpdnlkbjFYdnd5d0hVdXZh?=
 =?utf-8?B?ZEQrSkRHdllCK1RLVjZoUVdmTE1CMi9yenBocTFkbExYZVBLREJJUlk2K1p6?=
 =?utf-8?B?RCtKTDlVS2pEbk1qSzhlcG8zU0dBRlhaNXZUNTNSNkdvYVUxazQvRnNHbGhX?=
 =?utf-8?B?eURpY0NLZkNUT3p1QTVaNnBDRHFKRHNnQW5Qa3NIQXl0aEgzOTNLRVFpdFpj?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1110b0d-dbfe-49ed-fab3-08ddcdba09c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 09:35:06.7269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gFkKsQPMa+SJWQy66Umx6wLRu+4zK+Crk/2yreDLBnnUvLceQ4NYbogOkHtNtAICMHknWI6sjG9VgylgfSELoXifNKBtn7VUAxPutwY9m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5090
X-OriginatorOrg: intel.com

PiBlbmFibGVfc2NhbiBpcyBub3QgdXNlZCwgQ2FuIHlvdSBwbGVhc2UgZGVsZXRlIGl0IGZyb20g
dGhlIGRvY3VtZW50YXRpb24gDQoNCkNvcnJlY3Qgd2lsbCBmaXguDQoNCj4gQ2FuIHlvdSBwbGVh
c2UgY2hlY2sgb2YgdGhlIGluZGV4IHNob3VsZCBiZcKgTkw4MDIxMV9CQU5EXzVHSFogDQoNCldp
bGwgZml4IGJvdGgsIGdvb2QgY2F0Y2guDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLA0KQW5kcmVp
DQo=

