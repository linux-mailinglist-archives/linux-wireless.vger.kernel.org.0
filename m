Return-Path: <linux-wireless+bounces-27817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79482BB9553
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Oct 2025 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7733B7902
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Oct 2025 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA625B2FA;
	Sun,  5 Oct 2025 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/gYQn0w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCA1E7660;
	Sun,  5 Oct 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759658702; cv=fail; b=a+Hb2peb/rpe/529imk+ynLEEhjt2pp8cxjp18ARTSWrKQRvMRbjKXym7H+vl/YqFR+kM/ZsnSAL5+1dJiVXfeDoRchtXTKQhdtU0lHu3Eo7ZNBwCtSoatWjBI0lfO74DXwJ53ACu+YInLOLZ+qIJ0bGlfG6gQnNCojZ1IFqY94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759658702; c=relaxed/simple;
	bh=axqOWm5mvbZwmcAVH/TRD4rzVEuMQQIZL3GXZFHfSAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=us94KB1nGX/Y/gRjV0ezmuroRsjd/NKxz5bEoj9YAbguC1Sk9JAhL5uf6NC1Rybw04K4rT6tsVw2e6F9D5nZwCtNi0T0gLXSbKVV2ZBavxw60MFYlJG8n+ZbcEDpTCzxl/FQUal+xL9yDJiT+2VC1GyhvasyOyd03apm4IsxsXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/gYQn0w; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759658701; x=1791194701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=axqOWm5mvbZwmcAVH/TRD4rzVEuMQQIZL3GXZFHfSAk=;
  b=T/gYQn0wUTIEPgeGl2XDNIoqw7bPJt3/OOXXVA/YMiUDii1FGDFJk2IR
   q6LseykQbHJTVgoiGhPiPFkNqSV8Dunkc6WZHHGgChOUpi3D5G8QGiYaY
   gnxZaQoGAnI8Fv1EH8fIl10hYJXhiAv4/RmpkpX409NOVvvz2KCqpzXk6
   +zQeJFh3ATkWCfDaMuZXJ2mLMSsvY42NzBVXltWWscPaGH9SjLa5aq+RH
   JgdTDclUVqCg3fkychanNXWAn+xP6aP5kKSS2C27DCujEkOzWDz6ZiHwP
   qTSxH4QIarYX310fng47Xua6tWt6I3+6EuvJ/VSI1XrihhUgudjWXFvU9
   w==;
X-CSE-ConnectionGUID: FdkBPQ1DTcWZCyFAdmQfUg==
X-CSE-MsgGUID: 2+Yo3oVeTc+c4CQ5li/Puw==
X-IronPort-AV: E=McAfee;i="6800,10657,11572"; a="62033155"
X-IronPort-AV: E=Sophos;i="6.18,317,1751266800"; 
   d="scan'208";a="62033155"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2025 03:05:00 -0700
X-CSE-ConnectionGUID: BEiI2UHpQkK+HfezeEYKJg==
X-CSE-MsgGUID: LigGscvhREKLrVbGw8liAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,317,1751266800"; 
   d="scan'208";a="210318539"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2025 03:05:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 5 Oct 2025 03:04:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 5 Oct 2025 03:04:59 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 5 Oct 2025 03:04:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIBU54jztv5LPazobWv9WHHJ8C+9JXCat986ywt50ktUbvdx5URNaI6OvoxfL7yHJgB40roRER+hf/nBHy64D7LHG6kiVJQJQyazvi2S1RCSWG6XeK83HxNv1A+XHN8FzSFVaqC2f+K1OOfr9AvGwL+YeNmJdvrlarrNjSbMouuk9jcPj/YjBMop4PjdbgO2aH+UsrTBvsiqeHjUvFLk7yM+G5M3dn9HSEvKwYlVn1Bo2jBVDjUiOkGuCvGiANau+DIsnFZUCRyTftwFSDbryY/2HGV7tKpCDTebHsvdD5bv9zk88ec9KtmFnvZrhjRGRyDWCr7Qif/IeexfzQDZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axqOWm5mvbZwmcAVH/TRD4rzVEuMQQIZL3GXZFHfSAk=;
 b=rVctotZeTS3Sadqbx2Y6dhz+HvVZE2pgxgcenfKef+F5QvCcO8cK4JYLbqYNeIYATw1AkK6UmX8avmMDDq0p15xb98/R4JmJewDZuR/2twr4TJP7byP+OKG0NN9S3cXvom5bXt4jqBF6tCq33GVdF5eufEyf60i0z4TwH5NAsDr1IrG8khoUdQs9fgzLd98s4d7asikjRJg4IEbrtXSKkgT9z5MmREO+3reoNy3pyn0iZ+eN+cCIsWX7spPW321TVO7Vkg+LLIRcWE+3tMStLuIjo5shLsu7s5mq4yXmSnRhxpG1nOJNWO/1MeeJicLkl28Md8RSXA1rtin95ChOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by MW5PR11MB5859.namprd11.prod.outlook.com
 (2603:10b6:303:19e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Sun, 5 Oct
 2025 10:04:52 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f55e:9ab0:c331:f987%5]) with mapi id 15.20.9137.018; Sun, 5 Oct 2025
 10:04:51 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: "Berg, Johannes" <johannes.berg@intel.com>, "Anjaneyulu, Pagadala Yesu"
	<pagadala.yesu.anjaneyulu@intel.com>, "Grumbach, Emmanuel"
	<emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "Peer, Ilan"
	<ilan.peer@intel.com>, "Gabay, Daniel" <daniel.gabay@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
Thread-Topic: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
Thread-Index: AQHcNTlm+VnB67gfYEuELYoxWi9tT7SyCSiAgABvtjCAAMNrgIAAFz8Q
Date: Sun, 5 Oct 2025 10:04:51 +0000
Message-ID: <DM3PPF63A6024A9796B12A990D023532081A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251004141539.6512-1-brgl@bgdev.pl>
 <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
 <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAMRc=MdtkAFJBGN1biaGDLjgwjuzJ=kjDzEWbrX+DX27e8jYhg@mail.gmail.com>
In-Reply-To: <CAMRc=MdtkAFJBGN1biaGDLjgwjuzJ=kjDzEWbrX+DX27e8jYhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF63A6024A9:EE_|MW5PR11MB5859:EE_
x-ms-office365-filtering-correlation-id: 141d8f5a-4476-487f-6387-08de03f6a026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cHhEektBbE9oMGtnMll2WDhWWkZXWjIzOU1BZ0E0OFNpZ3VOYkYvTEUxSEts?=
 =?utf-8?B?dnhyczJtTXJxRlMvSlk4UUwyejJEbWNJNEg5SWROWkc1dGFNd3dBZTdSSmZq?=
 =?utf-8?B?bFpWTWZNK2tDVmFUY3BwT3QvbUJBTENuREVhVnpHelc5cXJnVXYrZ1hXK2dS?=
 =?utf-8?B?TGdTc2FWQWtpN000ZnBZb1Iwblk3YWZmNDMwcjRhR3JHMXhQL0lPVXNBM0ZI?=
 =?utf-8?B?RjVzR3ZEZDd1Mi82ZThIS21DT1BkQkorUXBaNk53c0JaS0pScG8wZUlGdWJm?=
 =?utf-8?B?WjFhSERBaEttdFk4ZUZLb3F5amhzZTk1c0gvWlpyYmE4UjhyZm9vM25mR0lX?=
 =?utf-8?B?R25IcGdRSG0rR2pSbWRCOHFIR1U2Y2dKZUk3SGZGa0liaEhTZXZjc2JhN0M3?=
 =?utf-8?B?TlVKTTdseHJLc1kvTkd6aSt4QThScmIyWG9EN3ZxTFBMR25XU3JPZ3VFMmh6?=
 =?utf-8?B?VW9Bb2ZmaS8wQi9mTWRSczZqdDlSUDdkajhBZVJmcHhpYmVWZko0NlR5VmU1?=
 =?utf-8?B?SU9XVUtWNloxdy9CVlBnOHlzYm9EYXhNZ0V1Uk9UWlZMUDhHOFRsVmZEZWRk?=
 =?utf-8?B?d2tWM3IxQVFjdEpPZU5WRlI2U2Y5amd4TERvYnQyR1FRbkJETDVZMTFuV2t1?=
 =?utf-8?B?R1VpLzdBWTQzanhzcFVKeDNnVnJwSUVCMVRGbkhnNnlsVy9MR253ekZ5Mzk2?=
 =?utf-8?B?SzVkY3ZrTTVZdmRTM2ZlWXpTc3pVaUk3TFZVOTBGU1FDck1lcUtVVUVDV1BG?=
 =?utf-8?B?SHFBZU5Oa3hhZmEvTERrVlM1emgyUzFyNldTQURWRXFyY0R2WHkrcWZVZ3RE?=
 =?utf-8?B?SzZhZjZMVFV5QXJac0N6ZFlweEd2VHFyWEh1M2Zva2MyWForOC9ZN2dGV1pI?=
 =?utf-8?B?SnoxMUNFdyswRGRCVVFjMjBXU3Q4NWRlOHBxRzVvZTl6dFB2Vks5MmpPUlF6?=
 =?utf-8?B?cDRCamVpVmQzNnV2dkVjOS9IWVZZMTM2TjZWS3kxVDMwUnk3dnFDQ3MwQ3JM?=
 =?utf-8?B?RzZnaEdJUmZ4QU1aSTRuRzdqZ1p5SXJ6cTZVRG55a1ppWFg4ekVhRkNGaGlD?=
 =?utf-8?B?S2JPT1pJT2FUSDdZbmtKcVBhc3Iza0M5YUtuaWY3enNKYTlkVE9VL1UycFYz?=
 =?utf-8?B?dFFNcGVVbnVTZjhXUWFqMW0rKzR5QmNjT0tWSDFzdklKL2ZmcHhoUTV6SFly?=
 =?utf-8?B?b1JhVHNVZ25WcnVKcTJjcHFtcXp1QXpqbytwVU5LT0VMTzRvREk0amRBK204?=
 =?utf-8?B?WmpMdFhVNXpHcUgzMThlSExrM1lWNitiWkd3U1Nudml3RkErZm4rN1B4cUdw?=
 =?utf-8?B?QTNXOGZqeW54WG9IQ0VHZVRva3hKNC9oYWU5L0JMK09rbmFKbzlvdHRzaDlD?=
 =?utf-8?B?QlhJUVR4cExCOFN4UWlsN2N3clhOVFpKQ3AyTml3dzdneWxpWFJ6elB2ZFA1?=
 =?utf-8?B?QWRtQzdjVEtXOXFhTWlibGVyL0czK0szMjUyamtxZCtFbUlJZnhQd3lveVV3?=
 =?utf-8?B?bFkyNUJORjlwL3lGZ1RjaEJxbnZua2J3ejVTWTdoREQ1Zm5GL3FKNm1kRlln?=
 =?utf-8?B?OGtTUHlzUmdPVWQ5VXAySnVLSG1NQ0JQUm94dTZ0K3F4a1hYOTVxaS9mOWRZ?=
 =?utf-8?B?SEREM0J4RXpFWGVYemp0N3V3ODlxanFPVFQ5dlZjVXo0RFlVeWRSNTFLYTNl?=
 =?utf-8?B?b2ZJMlNnaWlVNnF2dEhpSUtTUGdOK01walBkNlYvb1k0ZEJVTFphblR4alhK?=
 =?utf-8?B?TWZKZFlydUpzNHBKUHJhaWExN2t1ZyttUHlJdG1YWU5tSG5ubE9uN1FTUW9P?=
 =?utf-8?B?emhkTmtSZTdMakRIKzFKR1FhSE1SSjlhSkFKMXhubGhIdXBxNmd1b21aTWIx?=
 =?utf-8?B?clE2MW9iT1BoSmRHR2dHMFVWTUV1STlHZ3JVdlhWODFjRWhtdkxiUkpnWHdl?=
 =?utf-8?B?ZEdGZW4xYlkxNFdUdXhIdFk0MDE5UVdjNnNqY1FsV1o1QndiSGRmenZUTUl6?=
 =?utf-8?B?QmNyOXExelc0R1lUVTBxWmNTdk5TV0F3dUpTcXpsS1ZBbjZBTlZaRXlTNjJw?=
 =?utf-8?Q?CZOizS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGdYb2Z0eWJ2RmJoZjFWM1N6b1Babzh4bmdtVnpJSng0MXJYNnFDMmFFNTVB?=
 =?utf-8?B?YTJxWGVPT3hrUzBaLzRmMG9VQ2VrVE0wdjF2SGV4Z0d1ZXEyWlh0c1NFTFdV?=
 =?utf-8?B?aTdvdU5DVHdxSUJNSFVocTRLSUU5bjhyWlEvQ1RPVEdGYWs3NGdua1pJRHhH?=
 =?utf-8?B?NFQvZzAyb2dPTmhUbzVTMlZhV1prMVdWUmNBQml0RG1tcy9YUjUzR2ljblRS?=
 =?utf-8?B?QzNBVW1PL0NVTTUxakRENXNvOXQrSjNKTXYvLzJSTFZjU21JRFdKYTJzekdE?=
 =?utf-8?B?QVVrV0FBbVF5SDlTdE8veWI5N1l2WXF0UzV6aFFmNmlLM3JpaGxpa3NXSVR2?=
 =?utf-8?B?YjdrN0pxVEo0OCs4WmcwN2hReDA3LzdlNzlkMG1KelFWVzZHa3FrR2ZHakg2?=
 =?utf-8?B?bjNVSm5MdUJzekxCc0YrSkIrTGF0TUU4aGZud2tZa1lKb3BmS1luNXNqNVdv?=
 =?utf-8?B?TmhqNW9tRXkydGVxem1QNFR0Rnd6elJudkFqWVEweWVHVXJjN0pacHJsMlBm?=
 =?utf-8?B?aU9leW90NDNQWktEd1g5M0RKaTIzaHhYdVpxSDkrUk5CQmFHOUp3TS9kTkxQ?=
 =?utf-8?B?S0kwUFJ2OHhWRUNtTFg2THF2MTBIa3ZNM2UvWUsveTNNcFRHVWNCams2d1BS?=
 =?utf-8?B?T0JEWTdqUlp4eGg3NTluUXRmTFpiVVpSTkRmSHNxMld6VzdiZmFJZnNqRTYv?=
 =?utf-8?B?eitJK2ZXcC9qSkRnb3VjMWd2N3gwOWpVc3pjTEdTWE5FQzNRMFFhdFIzcHNE?=
 =?utf-8?B?aDY5dnZrcnlyTHlML2MybDZZV2IwUFlqQlE3eWhiUWM0V0VWc2g2cjFRSHUw?=
 =?utf-8?B?MEwrTURFKzZhbjBRVDdEVzltM04zWUhMN1Z3MCtGd2x0YWJHT0F6a2FHYUFT?=
 =?utf-8?B?bVpkN0F6MWxNOFhQWGRJdjJZQTJ3MC8xN2FQeXJnV0tBVm9nZ1g0cGlXcXh4?=
 =?utf-8?B?alpqSmdxeit0Wjd1VC9CY2lRRDNYY1A3ZTcrMTNXSGNQTGpKUXc3SVNQOTcz?=
 =?utf-8?B?TVJFVFE5V3VpKzZZR29GTHNxdkZCYU41M2VGSCtlNVlSVk9aQTdFZ2w5azJv?=
 =?utf-8?B?aXphc3ErVmlEUm4xM05pQnN2dmxPM0lDcGt6NDY5eVpRWllkTDAvNldzYVFY?=
 =?utf-8?B?b0RYZDVrZEhDWmNzVXQvTXozOXJuN2duenpYTXU2Z2d6TnJKcnNPMHlPSkky?=
 =?utf-8?B?enFOVVpJYkgvYTNIVTZmaFFsbzFscnUrNmpVNUFNK2phOVhuV1paWkVid1lz?=
 =?utf-8?B?T2VNSVJhWFVndjFENTg3NzRJam9kdDF3c1Q2THVHZWFlS0pQUENnaElzdDFH?=
 =?utf-8?B?T0NHc2dza0FpN1d3ajZFVGdSY0dHb1VFWkZ2T05ZNVF4K1YxS0l3OXJEM2c5?=
 =?utf-8?B?SWF4Uzc2VnBSRGtXbDlNckpLRkpkdGhjS0NXRXg3cVFOdWFoRWVMOFB1eEc2?=
 =?utf-8?B?RHhBdmMzaU9TRWNxdGdzbFdCV3pNbVlLN1BvYnc2alJ4eEI5akxKeHFkNVE2?=
 =?utf-8?B?dHZucjlVNjVQZUxPNUdEbzFFelJROHlEV1hiaG04Zk91MmpqRmQvdWllZ1g4?=
 =?utf-8?B?QTQ3WU5Na3JxaEQrS1dDMFpYV1h4ZlZPUGZjWFhVNFBWVm5uNHJBOFlPc2JQ?=
 =?utf-8?B?ZmxCajBiclVZQlEzZFMzZWk4NnJMY2pZeHo4QnBVTHNKWENMbWJEcFhHOGFl?=
 =?utf-8?B?UHhhbGhGc2hQMFl4a0RXVHZiZXR4VVFXVm5RQmphL28wV3ZDYlVXaUxKd290?=
 =?utf-8?B?LzNRMDNNVGl6aWVNeU43eEZXaTJNQ2ZDbGU4MStDWFBZUmFZdENjcmVyZFM3?=
 =?utf-8?B?SUQ0ejM0c203bWQ5aGo0VDZJakc1TWx3eHEweVpTbnlvRXJtTWVnamlkalM0?=
 =?utf-8?B?QUl5RjcvTno4K1J1KzVieE4rc1IzZjR4VEpmSTUvTCtuN09hVGQ3MGJ4RTJz?=
 =?utf-8?B?emVlOXNrTCtTUElRbkdrUG1tS3p0enB3WXJYNkk4eVJ0bmRTMjM0VGd1RGdG?=
 =?utf-8?B?WUZOOTZzQWQzSFAzVytCNUs0K0dSS09WaDVHaUlhVEJFR3c3L1U4S1Vrblcv?=
 =?utf-8?B?WU9QSVdleUphK1ZlZDVIYk9VVy9TelRhQ0h5Sit4NWJ5Q3BtSnlwcFpUbWky?=
 =?utf-8?B?SjNkS0l0cXI5UUVKTVcrUTJSZnlPeVNWZFVJRWxHYkRydE9KVWs1V1JYaWJj?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141d8f5a-4476-487f-6387-08de03f6a026
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2025 10:04:51.6759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH/X8DNOcRf1s4V2ztxoQ9rYDrvenRt1B91Src+oF1iZ3EIrZ0AUmDelj2WbQiualObQC7ixbl7CudmjedWbMN2GKQgB5EpMJLxF09XGYUBirPApQ+t9dLW9z7uTr8Dr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5859
X-OriginatorOrg: intel.com

PiANCj4gVG8gd2hhdD8gSSdtIGFscmVhZHkgYXQgaXdsd2lmaS10eS1hMC1nZi1hMC04OSB3aGlj
aCBzZWVtcyB0byBiZSB0aGUgbW9zdCByZWNlbnQNCj4gZmlybXdhcmUgZm9yIHRoaXMgY2FyZC4N
Cj4gDQpTZWUgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
ZmlybXdhcmUvbGludXgtZmlybXdhcmUuZ2l0L2NvbW1pdC8/aWQ9NzBmY2UyZTcxYTNjYmJmNTBj
YzU3Njk0Yjk0ZGNiMjdlYjkxMTFmNQ0KVGhpcyBpcyB0aGUgbGF0ZXN0IHVwZGF0ZSBvZiB0aGUg
Rlcgb2YgeW91ciBjaGlwLg0KDQpNaXJpDQoNCg==

