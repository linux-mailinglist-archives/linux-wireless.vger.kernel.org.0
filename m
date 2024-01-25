Return-Path: <linux-wireless+bounces-2463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8383B985
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 07:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8111F2350B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 06:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430F10A12;
	Thu, 25 Jan 2024 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e6m0NYjo";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A2T1ZgmG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4010A10
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163842; cv=fail; b=QBLjZmGZkiaS0vp715Y2JX9GmpjLK4EoQNMGMVsp523L2l2PHYW2B+jo//FE589C+Cp2v7E2hdV79n7B63jiHUvy/kBDkegKzlT2Md3w7cfgUl3QnxhsV1h4W00/b67HU3AklLCb7+symdCwZ1oz8GPwyqnqQZu+PLw8EF1nMlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163842; c=relaxed/simple;
	bh=JfANVKFLzH/oS3/+gfX/bWZ5rQ8V2REeSX/FP4FZZSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajIS8AvF3IuF+UIspN4LxIE1+ucJDnSP2AH1GigxC9kEzkIIpP9l/DfMLTt7Xvi2+Zj1kyMvMHd9JV29qDModxsgRLx7LnivbXuszaLLVDKTmuwZSVCjy1yPbqjwDM88s6y1Q0DYLK6KYeas4eMkGEVHSHN8RSV6SlIc+3iBKrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e6m0NYjo; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A2T1ZgmG; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706163839; x=1737699839;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JfANVKFLzH/oS3/+gfX/bWZ5rQ8V2REeSX/FP4FZZSs=;
  b=e6m0NYjodvC+6zH+yiyUVakqV9GLJoSTy+N6jrnHBaA+jAIhBM7dUq7B
   Rdh8q5rTo66XIlISgMKj1HFXTT1iHZClJ2YUjPZkzG1wKdRnilYRR9+s3
   iUPMr8gE5mDcjC6tYFW/zV4lBiKGmrZ536X/NxItuNaalXJ4WjWXB5cnu
   DjFWcHpEbC5GXTKZlqUqzyWvREzGvbsUl9KmU+86wN2TaiEq7ZehQwK8d
   1SVo7NbvcTYCnCjOqLfHgD2Ookhor9qvywG4BlhO/kO5mmhYLIIDh1y8s
   atRHSuhnMc9VYm6CiN/6Or318IS3mZuFYEeQz67GKBS6cZXkBsMsIVSnq
   w==;
X-CSE-ConnectionGUID: +v3TUYAzQzKvVDjyvCNxjQ==
X-CSE-MsgGUID: nCsNAsp8T8GCTup7zTDxWg==
X-IronPort-AV: E=Sophos;i="6.05,216,1701154800"; 
   d="scan'208";a="15265766"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2024 23:23:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 23:23:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 23:23:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiH09as3KpTXNbCXEf1nANmTE+zjIlMHXKCZ56BI6e/TQM2QkpPHLYLgbJT6tN+K124bylEIJV3sr7PDYO06nCG9yBNQl0k807XZsKLG1T0OCtqqoD+2nv5y+Ici74G+cxsGbLYanudTc3nNrxxVTRYyn3pcCUXPaWd+y/71sLrEDGqeR8vvJzkgElFjbEfQhbDumJiiavMbwGKRBlgYMo1TYn/ZWDry+J5jdG0iea8wWUDktLmoL9qOqPaCuE3de2NKTFT5beYgB5bfV4rrbVNlpHzTKDfwU5R0mZE1Km8J9JGpDZ/gGhTp5xOOaWccaG1Qp97HQyib7t8jKk+w/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfANVKFLzH/oS3/+gfX/bWZ5rQ8V2REeSX/FP4FZZSs=;
 b=BhNzOoSUcP6v2FBJMYoLXLmFebVm8/UCaPWY+O7DCKMAYSKfwwDtkfz2F2qXgFpsgp+YKQA1NMpMNI6COTFQkPqYIA50tD8D/Uj1S7EFp95CSAO0uPrr8LLjkluy07cG/hWDvd47hYgjdeZ/xdOS+Ba41RRP0tcyG9bhirp34ESTxUtjtIc1BH4PcQXf+vmXALbzfmP//6lZxTXaK0lti7dDUUrzwz5k/4WkC8QAtzJBDv29wcwOnzD9XEBIEEL8m+CAlJbwzi8c7TZclxjfjQK1Yx8yMJt5OT+wY+wI+nn585NxYTgA60oxJQ6u2MPpBsbFc9s5s0aEBilyqGMAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfANVKFLzH/oS3/+gfX/bWZ5rQ8V2REeSX/FP4FZZSs=;
 b=A2T1ZgmGo/r63g2QBXluZIhlw8CXKUEn5PmGbyouDeHmEfb+QjbvFQWMxC4di0HdMUsYgiI3pyECQfHXXIzHorqQauokWY1sMkNk5RnC9nJuMTZc1IiwDkWoQHfdfZzshpkSJS3X7u0bbI+XZNCFaL+5xNfuJoh0zamS8c2XBcCMev6fuoBNjRhFhBf2RvQJU9EfiNjM1X3B0YFwPsblkj5IJE/kCskKfM/6qqW8VLw4M1rREh/U1tSKW6NqSsISe6F944PHlQ8skV00EjImFYfn93Q8NlDGUoo0x5c2dXW+uS8Nq74a/kwavhqD1yyIdCkGi7pt4YXsDfQheQzYIg==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Thu, 25 Jan
 2024 06:23:22 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 06:23:22 +0000
From: <Ajay.Kathat@microchip.com>
To: <davidm@egauge.net>, <alexis.lothore@bootlin.com>
CC: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
Thread-Topic: [PATCH] wifi: wilc1000: validate chip id during bus probe
Thread-Index: AQHaTXfuVyXu+UQNkEOt6vVeWNVJQrDmYtaAgADNRwCAAHtPgIABAX6AgACOnACAABSIgIAAwv6A
Date: Thu, 25 Jan 2024 06:23:22 +0000
Message-ID: <c5118672-7e67-4601-a570-52c8e212aeda@microchip.com>
References: <20240122211315.1444880-2-davidm@egauge.net>
 <20240122220350.1449413-1-davidm@egauge.net>
 <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
 <b8e8a3f82fe240506e82322a10be7b4e9f218eca.camel@egauge.net>
 <0d77d857-35ce-43bc-aaf3-2b46c01a44ec@bootlin.com>
 <ab077dbe58b1ea5de0a3b2ca21f275a07af967d2.camel@egauge.net>
 <eb20373c68936f032c322174fbbd3353167d898a.camel@egauge.net>
In-Reply-To: <eb20373c68936f032c322174fbbd3353167d898a.camel@egauge.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|PH8PR11MB6563:EE_
x-ms-office365-filtering-correlation-id: 1a87d18f-4db1-420d-5581-08dc1d6e2147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aOiX/Uv6EIhjbvaswrex2pcB2j2ggKkOQz2f4dptBm/vvjbusUh507GuFLmWiyC7KvabGRhae3e/rVwmrF5SfzLIuaWQU5GRRC6bCGwqsUkPErZGLMP0xt9S94NcW+7gbrUB2AqmQSfNmSbWn/iA1aolaTcTLjuSIPlNyl0UQp7Z2XTxJyeZSF6dwqf1W6G2EMF4sG/tONE3JRNAQKIkNV4VCjqxwYAX+bO5USkepQsCyUpbw7DcOaOKJqP+qZOBeePZ006e1jpUbdk1V2yQJqEsAhBNq3tdW34p3U/DZcCv7rFC9YfAf6ITd+8u5bWI72TB2+dIZSYKlnEgPWu1AdxOoUIvRWDBqNxQjbzDaQgZyZdZlSVUajpmqFnM5Oc+8mBz7qbnwb+M/fYC/47u0VOpVwSX/2iTAGK3YxT1RZBx0GkQyoZr/ZOuibYeexiQSE3R92Bhe2u1iOTWVJ4Mj01oOn67i6ziMl36qkM7rvO+EEe9cQAG083E6AAhw+Vm5g3EA58xjKwKiELyhNEYnynHLuPWuJbFub4j2QqQsNaDxvzQSLklojzjhQxRrJlm2dQQGJFTV+OYolCrBNvh6dzISGPFMm42S7TFpIX/TrYNBXzPE/3ABgolScb1oTgqHYTEEpYxziJ3OVuR07stWV+UxhkaUPs304Sjx09SnjSJDNQIPtrhq4K8anKOSoFoVSkFs8wFIhf1/MpsFMRYAUPhooZqDYPG5B76ym/rWqI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31696002)(86362001)(71200400001)(38070700009)(53546011)(36756003)(6512007)(6506007)(41300700001)(26005)(2906002)(15650500001)(122000001)(8676002)(38100700002)(4326008)(31686004)(5660300002)(66476007)(66446008)(66556008)(83380400001)(478600001)(2616005)(110136005)(6486002)(54906003)(64756008)(8936002)(316002)(66946007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlJ4SUhqT3FLSkNmTkxKZUtSR0xicHJVSk5JMkJjendlTzR3NXRONWx5ZVhu?=
 =?utf-8?B?c3VIRVptNTR5YzQ2YXN0WTZCQ0JjQmREVVJvelNUMkxubTlCWFc0bUJSVGxu?=
 =?utf-8?B?SkRTUEwwdlFTb21mWStPSmtCWTlSK2wrTTZtdzNlcnU5aGlwaTRsNjhBeU02?=
 =?utf-8?B?MmQ1OEFka2grN29nV3U2ZEdFV2lPUnhLQy9ZRW44WUlsV0J3b25yOUxhQmFN?=
 =?utf-8?B?MDlSL2JwcHlCSHM2aXU5RWVydkhNWk5xaUFWNldrYXEySzR2SWRsTlc1cUNQ?=
 =?utf-8?B?blhYRmJjbjNYTTRQTS96T0Y2VG1xeThvSGVkWWlBeDdlYnRWZnVGeThvTjkr?=
 =?utf-8?B?RWE1TFgxMUJKcVVZNzY1WjBES0l1NTZtWFM4Z2hqdVJFQXozKzlmWjByUjJH?=
 =?utf-8?B?YmdaMjZ3WEdLUmRrYnplMWhaV2FtUlJpdTJFbEFoVDNBQTk0cng1ekZzeHVB?=
 =?utf-8?B?QTIyQ3d2bGV3TTY5QXRYMEcvT2JSL2JWWkJYSDF4cnlmQkxYejNlMzQ4RVE5?=
 =?utf-8?B?SGVGWkFHNVFNUlo0cDVzTGFIY1I3VjdqQUpXWmEweWJzUTJMMUNQTEhnREVo?=
 =?utf-8?B?VGJNQWFMQnZPa0wya2MyR2czcW1FZnRJUGxTTTUxNUR0UWlRZEVlV3lJR05i?=
 =?utf-8?B?UUp3b005aVd2aTlINzJGS1YyaVAvQWxGcTRsYkZoazdzYjRNNXRYckkvemY5?=
 =?utf-8?B?QkljaS9XYjVYM09Hd3dZUDVscEZlSW53b1BURFpxMHQ4SFhtUnJUeG9ya05V?=
 =?utf-8?B?akllNlB6Y0FSTDU2cW1pSHZhdk9aREc1YmJ0UTZmazEyRkJ6czFLMEFOWlli?=
 =?utf-8?B?NG1iNGVMU25MT01YQ2pHc1dMVjUvRFk2VkV2aTljVGhnVzRiSG0rQWFwaUJ3?=
 =?utf-8?B?K2MrdVFmcnBGZXUveitxbzF1MlAzaWplcDA0TUJMZU1oMzhKYTVyUWlrbUpM?=
 =?utf-8?B?WnI3NUVxRDQ5cEV4YkJWZ2piMVlYdXMzY0pISmFJQUN0azN0MWx6QWUxbkxZ?=
 =?utf-8?B?WDJST3J1cDFYQ0h4dGhqT0toQkNJQUp6RVludXk3TDkwU2dNUjBBdG9Jam5o?=
 =?utf-8?B?UWluYkU2ZEFzSlUwSFdLZm1hNFNaZXVPVjN6UnVMdnhUZThKRnErUlFObDJM?=
 =?utf-8?B?SUpQMTlEbHJSY20xSFVDaFcrYmYyNmR3WnhyT1dycFZCQlRrWEVHbGFSMjZQ?=
 =?utf-8?B?dU4zbWd3Si9TM1phbWRicHQ5SmgxQnFWSWcwWWo0ekc2VUxJeWVzWXAzNVBo?=
 =?utf-8?B?WUR0K05ScGoxWXlGc3lmdkJDeXRQZmdxVFA0RnNGUER0NytGeS9CRTNRU1dS?=
 =?utf-8?B?cjR3aklPSmVzUGtRUUp1UE9pTmp3cjBPMlVIdnByNy9WZWV1cnY0Uk5CTU1M?=
 =?utf-8?B?Tld0UGo4eGZCUkFPYnB1SVh6R1J0SGZ4SW9OVitzcUUzQlZiSjJvZmhyZC9B?=
 =?utf-8?B?UXFsK0JFaWo2eHR6bjlieXFzOUN6aThFZXFhV3pkY0NNcnk4MkpVWnRyNld1?=
 =?utf-8?B?YU40ZHN4RzdBY05hRVhicCtOZ3c4RHRYYmpPWDE5dCtMaG80L2EvWHVPT21R?=
 =?utf-8?B?dG45ZnRRRDF2b0N4Nm1UOTFZbXh0Yk42M2NqODlQekY5N05kOGExS1BUS1hN?=
 =?utf-8?B?VGJHNVl2L2ptTVNTU2twakY1MmwxbndkRHN5NmlUSXdjdndFd2tkRjU3Q01x?=
 =?utf-8?B?YWtYR1M3TXkwSHczTWZkVHl4SEdQNTJHTVlxeUJpd1lzLzROY3NQZnhpcDhE?=
 =?utf-8?B?SHVDdHNwQkZ1T1NOLzUrKzZXc25Ka21xbndiOXczMXdTM3M0aG1TVG1jeEVx?=
 =?utf-8?B?RWQ5d0pJN0U5bDhDdWpubGdWZFpZVFVHZWlMcktjY1dMTHAvSGdyenAvcytP?=
 =?utf-8?B?b3dYNzRHNWVMWjlYc3NFVVc4anpJMngzTzVEc3IxazZhZWU3NEtqL0FFUzV6?=
 =?utf-8?B?VEcyU1hzNFFtUjR2QmJxcFdYWmpuWUJRVmVxNGFGeEpBb3BIaUpvQnN1M1lO?=
 =?utf-8?B?aUM4WDVhZ09rbjBud1g5UVJOcVBnZEIyZ1N6YkUvTGs3SWFCY0pzNTZDS2Ri?=
 =?utf-8?B?RTFwSWpvN3Z4dm4yRlVtazNSWXJmNXJpcFdXS0w3KzZ4Szh5SHYzd1pyc0dD?=
 =?utf-8?Q?8olSCQ5iYuwv1nTXIpu2OPWcY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDB8792A2FA49A4F9E20C7869EFE95DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a87d18f-4db1-420d-5581-08dc1d6e2147
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 06:23:22.1683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4OqaqZam9tz1sk4IIxlDYn+z+l9Ilf5RxgpkzOEcVtfS3c7/YvNVQyL8kIpf1PGbWYW+LdPYgwbfxpX83WtV00hpEDgiocoNav+C90d0UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563

T24gMS8yNC8yNCAxMTo0NSwgRGF2aWQgTW9zYmVyZ2VyLVRhbmcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCAyMDI0LTAxLTI0IGF0IDEw
OjMxIC0wNzAwLCBEYXZpZCBNb3NiZXJnZXItVGFuZyB3cm90ZToNCj4+IEFsZXhpcywNCj4+DQo+
PiBPbiBXZWQsIDIwMjQtMDEtMjQgYXQgMTA6MDEgKzAxMDAsIEFsZXhpcyBMb3Rob3LDqSB3cm90
ZToNCj4+PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCj4+PiBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGlu
IHdpbGNfbmV0ZGV2X2NsZWFudXArMHgyOTQvMHgyYzANCj4+PiBSZWFkIG9mIHNpemUgNCBhdCBh
ZGRyIGMzYzkxY2U4IGJ5IHRhc2sgc3dhcHBlci8xDQo+Pg0KPj4gT0ssIEkgdGhpbmsgSSBzZWUg
d2hhdCdzIGdvaW5nIG9uOiBpdCdzIHRoZSBsaXN0IHRyYXZlcnNhbC4gIEhlcmUgaXMgd2hhdA0K
Pj4gd2lsY19uZXRkZXZfY2xlYW51cCgpIGRvZXM6DQo+Pg0KPj4gICAgICAgbGlzdF9mb3JfZWFj
aF9lbnRyeV9yY3UodmlmLCAmd2lsYy0+dmlmX2xpc3QsIGxpc3QpIHsNCj4+ICAgICAgICAgICAg
ICAgaWYgKHZpZi0+bmRldikNCj4+ICAgICAgICAgICAgICAgICAgICAgICB1bnJlZ2lzdGVyX25l
dGRldih2aWYtPm5kZXYpOw0KPj4gICAgICAgfQ0KPj4NCj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQg
InZpZiIgaXMgdGhlIHByaXZhdGUgcGFydCBvZiB0aGUgbmV0ZGV2LCBzbyB3aGVuIHRoZSBuZXRk
ZXYNCj4+IGlzIGZyZWVkLCB0aGUgdmlmIHN0cnVjdHVyZSBpcyBubyBsb25nZXIgdmFsaWQgYW5k
IGxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KCkNCj4+IGVuZHMgdXAgZGVyZWZlcmVuY2luZyBhIGRh
bmdsaW5nIHBvaW50ZXIuDQo+Pg0KPj4gQWpheSBvciBBbGV4aXMsIGNvdWxkIHlvdSBwcm9wb3Nl
IGEgZml4IGZvciB0aGlzIC0gdGhpcyBpcyBub3Qgc29tZXRoaW5nIEknbQ0KPj4gZmFtaWxpYXIg
d2l0aC4NCj4gDQo+IEFjdHVhbGx5LCBhZnRlciBzdGFyaW5nIGF0IHRoZSBjb2RlIGEgbGl0dGxl
IGxvbmdlciwgaXMgdGhlcmUgYW55dGhpbmcgd3JvbmcNCj4gd2l0aCBkZWxheWluZyB0aGUgdW5y
ZWdpc3Rlcl9uZXRkZXYoKSBjYWxsIHVudGlsIGFmdGVyIHRoZSB2aWYgaGFzIGJlZW4gcmVtb3Zl
ZA0KPiBmcm9tIHRoZSB2aWYtbGlzdD8gIFNvbWV0aGluZyBhbG9uZyB0aGUgbGluZXMgb2YgdGhl
IGJlbG93Lg0KDQpJIHRoaW5rIHdlIG5lZWQgdG8gaW52ZXN0aWdhdGUgdGhlIGFjdHVhbCByZWFz
b24gZm9yIEthc2FuIHdhcm5pbmcuDQpGaXJzdCwgd2UgbmVlZCB0byBjb25maXJtIGlmIHRoaXMg
d2FybmluZyBleGlzdHMgd2l0aG91dCB0aGUgcGF0Y2godGVzdA0KYnkgc2ltdWxhdGluZyBhIGZv
cmNlIGVycm9yIGluIHdpbGNfYnVzX3Byb2JlKCkpLiBXaGVuDQp3aWxjX25ldGRldl9jbGVhbnVw
KCkgaXMgYWxzbyBjYWxsZWQgZnJvbSB3aWxjX2J1c19yZW1vdmUoKSwgSSBiZWxpZXZlDQp0aGlz
IHdhcm5pbmcgd2FzIG5vdCBvYnNlcnZlZC4gT25jZSBpdCBpcyBjb25maXJtZWQsIHRoZSBmaXgg
Y2FuIGJlIGRvbmUNCmFjY29yZGluZ2x5Lg0KDQpBdm9pZGluZyBuZXRkZXYgaW5pdGlhbGl6YXRp
b24gaW4gd2lsY19jZmc4MDIxMV9pbml0KCkgd291bGQgcmVxdWlyZSBsb3QNCm9mIG1vZGlmaWNh
dGlvbiBhbmQgY2hhbmdlcyBpbiBBUEkgY2FsbCBvcmRlci4gSU1PIHRoZSBLYXNhbiB3YXJuaW5n
IGZpeA0Kc2hvdWxkIGJlIGluZGVwZW5kZW50IG9mIG5ldGRldiBpbml0aWFsaXphdGlvbiBvcmRl
ciBhbmQgaXQgc2hvdWxkDQpmcmVlLXVwIHRoZSByZXNvdXJjZXMgZm9yIGFsbCBjYXNlcy4gU3Vw
cG9zZSBpZiB0aGUgY2FyZCBpcyBub3QgcHJlc2VudCwNCnRoZSBwcm9iZSBBUEkgc2hvdWxkIGNs
ZWFuLXVwIGFuZCBleGl0IGdyYWNlZnVsbHkuIEZvciBkZXRlY3RpbmcgdGhlDQpjaGlwX2lkLCBJ
IGhhdmUgY3JlYXRlZCB0aGUgYmVsb3cgcGF0Y2ggY29uc2lkZXJpbmcgdGhlIGFib3ZlIHNjZW5h
cmlvcywNCnBsZWFzZSBjaGVjayBpZiBpdCBtYWtlcyBzZW5zZS4NCg0KDQotLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvc3BpLmMNCg0KKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3NwaS5jDQoNCkBAIC0yMjUsNiArMjI1LDEx
IEBAIHN0YXRpYyBpbnQgd2lsY19idXNfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCg0K
ICAgICAgICBpZiAocmV0IDwgMCkNCg0KICAgICAgICAgICAgICAgIGdvdG8gbmV0ZGV2X2NsZWFu
dXA7DQoNCg0KDQorICAgICAgIGlmICghaXNfd2lsY19jaGlwX2Nvbm5lY3RlZCh3aWxjKSkgew0K
DQorICAgICAgICAgICAgICAgcmV0ID0gLUVOT0RFVjsNCg0KKyAgICAgICAgICAgICAgIGdvdG8g
bmV0ZGV2X2NsZWFudXA7DQoNCisgICAgICAgfQ0KDQorDQoNCiAgICAgICAgd2lsYy0+cnRjX2Ns
ayA9IGRldm1fY2xrX2dldF9vcHRpb25hbCgmc3BpLT5kZXYsICJydGMiKTsNCg0KICAgICAgICBp
ZiAoSVNfRVJSKHdpbGMtPnJ0Y19jbGspKSB7DQoNCiAgICAgICAgICAgICAgICByZXQgPSBQVFJf
RVJSKHdpbGMtPnJ0Y19jbGspOw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWljcm9jaGlwL3dpbGMxMDAwL3dsYW4uYw0KYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2No
aXAvd2lsYzEwMDAvd2xhbi5jDQppbmRleCA2YjJmMjI2OWRkZjguLjZmOTU0NTZiMDUzYiAxMDA2
NDQNCg0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3dsYW4u
Yw0KDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5j
DQoNCkBAIC0xNTM3LDMgKzE1MzcsMjIgQEAgaW50IHdpbGNfd2xhbl9pbml0KHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYpDQoNCg0KDQogICAgICAgIHJldHVybiByZXQ7DQoNCiB9DQoNCisNCg0KK2Jv
b2wgaXNfd2lsY19jaGlwX2Nvbm5lY3RlZChzdHJ1Y3Qgd2lsYyAqd2wpDQoNCit7DQoNCisgICAg
ICAgdTMyIGNoaXBpZCA9IDA7DQoNCisgICAgICAgaW50IHJldDsNCg0KKw0KDQorICAgICAgIGFj
cXVpcmVfYnVzKHdsLCBXSUxDX0JVU19BQ1FVSVJFX09OTFkpOw0KDQorICAgICAgIHJldCA9IHds
LT5oaWZfZnVuYy0+aGlmX2luaXQod2wsIGZhbHNlKTsNCg0KKyAgICAgICBpZiAoIXJldCkgew0K
DQorICAgICAgICAgICAgICAgd2wtPmhpZl9mdW5jLT5oaWZfcmVhZF9yZWcod2wsIFdJTENfQ0hJ
UElELCAmY2hpcGlkKTsNCg0KKyAgICAgICAgICAgICAgIHdsLT5oaWZfZnVuYy0+aGlmX2RlaW5p
dCh3bCk7DQoNCisgICAgICAgfQ0KDQorICAgICAgICByZWxlYXNlX2J1cyh3bCwgV0lMQ19CVVNf
UkVMRUFTRV9PTkxZKTsNCg0KKyAgICAgICAgaWYgKHJldCB8fCAhaXNfd2lsYzEwMDAoY2hpcGlk
KSkNCg0KKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCg0KKw0KDQorICAgICAgIHJldHVy
biB0cnVlOw0KDQorfQ0KDQorRVhQT1JUX1NZTUJPTF9HUEwoaXNfd2lsY19jaGlwX2Nvbm5lY3Rl
ZCk7DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEw
MDAvd2xhbi5oDQpiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFu
LmgNCmluZGV4IGYwMjc3NWY3ZTQxZi4uODU4NWRkYTA3OTBjIDEwMDY0NA0KDQotLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9taWNyb2NoaXAvd2lsYzEwMDAvd2xhbi5oDQoNCisrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93bGFuLmgNCg0KQEAgLTQ0MCw0ICs0
NDAsNSBAQCBpbnQgd2lsY19zZW5kX2NvbmZpZ19wa3Qoc3RydWN0IHdpbGNfdmlmICp2aWYsIHU4
DQptb2RlLCBzdHJ1Y3Qgd2lkICp3aWRzLA0KICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBj
b3VudCk7DQoNCiBpbnQgd2lsY193bGFuX2luaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldik7DQoN
CiB1MzIgd2lsY19nZXRfY2hpcGlkKHN0cnVjdCB3aWxjICp3aWxjLCBib29sIHVwZGF0ZSk7DQoN
Citib29sIGlzX3dpbGNfY2hpcF9jb25uZWN0ZWQoc3RydWN0IHdpbGMgKndpbGMpOw0KDQogI2Vu
ZGlmDQoNCi0tDQoNCg0KUmVnYXJkcywNCkFqYXkNCg0K

