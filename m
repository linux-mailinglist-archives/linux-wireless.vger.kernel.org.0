Return-Path: <linux-wireless+bounces-35341-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Cf8LQgY72mB6QAAu9opvQ
	(envelope-from <linux-wireless+bounces-35341-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 10:02:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A946E46EB54
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 10:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8839300187B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4E42264A7;
	Mon, 27 Apr 2026 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="ZWtiHMXX";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="FHToSedT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A82D780C;
	Mon, 27 Apr 2026 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276932; cv=fail; b=sJqD72zbl0xsNxj1YSA+wXi6SfDDR/dJYilm6cXZSfrA4GLEc4zMo5ojcxCN9g4f8NkVNb+zN7oUhxzqaUPoDLEnXaJ4+Q93SzqSFrSsV1GuZnSIE40Ti972gQJVu4p5fhXO07Wf76k/B+DjvziJjLDvWfCRUG+dyf+T1fkDs78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276932; c=relaxed/simple;
	bh=CrgPsK8T5yxPS1Iv6uXaT1D7WiXWCMRXt7l9VOOyTag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVxMAAlO+vFl1IgL3syTSMbTT5JEhJhz2w6Mbp5AQd8nvMixb7iFHpBC5iQfHpix+QKGnfsl5xoZoiTK2dHRdSXCg5HIrkDqnEIza+hbcc26XbzKsVfx5vIR1omo3OAspfXeveXd2c9R6vbexY5pErG7jCGdINXWCW3Z8PmV7Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=ZWtiHMXX; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=FHToSedT; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R09hlC374721;
	Mon, 27 Apr 2026 02:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=lQfwNYZ62r1ghEaRPNjUddqDEI7jgU74OfotjR2qN1I=; b=ZWtiHMXXNFz0
	SyQwtt19HMtm0nKD+LPrCGn8p53alwxVbTTOj42p5Ohcl0SI/h9rRwgdwJLOv2b7
	anV+JB2AccsaYJ69rcBORRNvmEQITZiU97RZrXbuGSkLdSkue8G251P4j0M18zDv
	ll4mtmIcc9jiHjDMqIIS592YaNlfiPbsWZTDYCuDOPFUSgoxlFSDxz35NKCwi3uk
	iKiZATXAkUU1qEuY408XNGZ0uUKo7gptQIAlEmaMNzqdFEhJfmSkyvniXGI5a3/p
	YVzkC6wMCfNi91iqmEPTzyHv4sYSVQdRmzQUS7MUdUxKFC6QrcigiXxCM7V7e1Cz
	vxqxE5LXLQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020084.outbound.protection.outlook.com [52.101.193.84])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4drq47tdua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 02:49:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1Suz9cXpssJ6CTqte89flihWdoQdphRvllANwFpGpZd22bTd/bxPVL2kKGS57NGg5pp1QuyouAwSTKIbtiWD9KHQVH82J47FIAuQr2dFOyAtVAsoxv90LKp8mg/YLuYbgHqlAhkD0mFdbqVLI1Xed9Myf9h06ZqYli8aFj/FBx9r/e2S2DAVfrgegYbmVjSJPU2abEfoiMw+N14pFWvvyequooxBH+3Y8ZkT5eIMlU65by788Cft8VCIve8RxNRzuw6XxU7kxonWAtFbkcGRslAe6jmkffVfzrnTQ+mEsYu3IgR76MHcT11Qw+RofUh52VI5+4MsAeWn/7HNPVnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQfwNYZ62r1ghEaRPNjUddqDEI7jgU74OfotjR2qN1I=;
 b=bgZL76l9n/LO/drxcqXVOu3Ss8BOX5qyPze1YsKnOFM+u52a1AggQwTA1feJjodIQ/doFnmWa8wm3YkIyh6bBOUCATqbg8D9PknLv4h8Hnj4JNTv6/cZgZizsj5OEJiRakBdJU8t7Y4/l+8AnhS2h7V6j455wS0Dv/5iDbwhi54et0JABYzG0CqDAM8IidCM3Qe/+KzyDV/fV2c8b/UxISDjG7dsHxRMzSq/SXsBQNNe6nMogmHpTvIakjBJrh29CW+qoRPA0hSl62sjz5PS7KWrKrb6afIWMZTE2ASpwyIqb2MppwblkMMwaN/fL1MxVdwlNRdVj824p5NNCg6b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQfwNYZ62r1ghEaRPNjUddqDEI7jgU74OfotjR2qN1I=;
 b=FHToSedTqfiMWtqXs+LrpfVScfoN64fbsAPI/II9P9GgV5LrVlKriKZDO240HFr0Dj7D5V3jIXK4XASfg6B578WyJwdQMBdMj7FkZbVjMxCpEGy6M+SCA9n4mzd3GMM2+CT61C/Ep1tsLfWE9OzgyN8qAsOWL2vOKwJw9eDq0KA=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Mon, 27 Apr
 2026 07:49:12 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::acd3:fd18:5809:64c4]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::acd3:fd18:5809:64c4%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 07:49:12 +0000
From: =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Rosen Penev <rosenp@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: wfx: handle EPROBE_DEFER with of_get_mac_address
Date: Mon, 27 Apr 2026 09:49:08 +0200
Message-ID: <5416906.31r3eYUQgx@nb0018864>
Organization: Silicon Labs
In-Reply-To: <20260427051604.953450-1-rosenp@gmail.com>
References: <20260427051604.953450-1-rosenp@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: PAZP264CA0197.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::18) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SA2PR11MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f052a68-ce7d-4571-4e5f-08dea4317900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|4022899009|52116014|376014|1800799024|56012099003|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qgnZ1Cg6WgDub3TYywkiJ4txOPNRWyEssnvZFTYeQ9ZI86ljhU+ci3fpSyKRosofJmL3uzT/A1fDYrxIt10ar7Kqo3mjwMLz4JtPtEUVeYW/qctyXT99db0dXA5H1A6PEBA+X+aEX2VwwXNz2ZPewsVnWrL1fZmVPkT0/zwUObS73Szmy5ClZ/W+8a3Cvh++lK7ExwtgO4p74B6BqKyLGWwad8k8LxmkC6nN3h7Q4LVq2lcpmI99dm0NfFiFkIRDnG6iwMpjL3zIhviZSPTtUw79GjNBJRhtLeRjPw3LpNb+b7FAetwWEoRyQp2MQm5W3RsWDEl4OaH4pkwVoF5z2TvHrDckAKNYpCVA9MuThgbmfhbRIFSu8EOsRFil0vb691ElrkOqrcIXun0WOqP4A5ZrS6Xt8edz/LZQFgO86CdIgusnIxhzPWtqNu85P1GDJDlf5/aBFo/T3AjtYcsViliklY7qu+MVXIUQgRRXIoJjlo/fzhljIMd7uEWJlEKaHO/lybPICHo8d9kgJLx8F7HtF+Yi/4+OsfOZRcUN2NeyR3aAHM7D0/YemQw9e1OBB//MlaM/Sq3Dgrk/aOYP3COdq26LMSAuzHqWcswPcT5AkpKKI0MxLVSPPYYcQLAetsVgU/VoGG4XtUvDLAiMExaipQ5d77Vcs+IkMw32KCcveI57XPCbDIJYGOHMedIdwvj3j6g1m+7Zs9STiOSoeYAOnM/J4k8rnxn/QlAm1mGV6rJIBE7jL/V8pIHLnrN9N4RZj86AAFyXFlpqga38MWYSp3u0xapek7MrxRn62KE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(52116014)(376014)(1800799024)(56012099003)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3pSeXBGcjh4SGRvTUpxNThvUlplL29HSnV3RXUyemo5ZWFJQjZyblJ6NFRm?=
 =?utf-8?B?RjJvcXpaUkgrbTNaYW9HWmlmcFVRSlNzbHNHRHN6bzZmYjd1dWZHUUlHejVy?=
 =?utf-8?B?UFUybC94eXFPamFoNmxPb045byswYStSWmZoTjRCSjNSdVpLV0J0NGt3NXIw?=
 =?utf-8?B?UWhXN05SL0NSN3lTeUdHVDk3cjl3QzhZOGtzQi9UV2JVdXVEa2MxNmFHUWV1?=
 =?utf-8?B?UnBNMEdpeExSWVdEUytmdlhUY0lITCtxbkhGOFdtd21BMWpsS3M0RDlSMHdO?=
 =?utf-8?B?OGM0Ymdma3l3aXhkTWxqTXg0elBVM2U1UE5ZcjJqMEs0UzUxbjJjYTJUdzVv?=
 =?utf-8?B?MFAySXJPOFFnYjJPTjM1NkZzK01OcENnN1hzcXFrWjhvcytIbmRWUzM3b1RX?=
 =?utf-8?B?TnA0cVYxZHJRMUMrNHRtL0JIenRlazFBMno4em42UWsrTVZoRDRHbWhnekEx?=
 =?utf-8?B?SlRPNTRFOVFwZjdBWGpNcldlNUpwRVN0dDFlWVU2R1VNTjVmdDRRVHVGSHRU?=
 =?utf-8?B?Y1pObFZmYWxjUVFPYUxzRDhtUGEreitiVXFndUJEZVNKNmRTcTlnbWhzWlFO?=
 =?utf-8?B?b2lUVkVRVnI0SzUxU2pvL0F1L3dyMGJJclJoOUFpampEV2w0bldXU0ZyVFNF?=
 =?utf-8?B?M25kMENieDdiY2x5OHExVmV3RE1OSkhxYWpqdGwwOFAxemhndVFEYmFIejVT?=
 =?utf-8?B?WDRPeGg2eG04VVVmOTc1SXRrZXZpNWYzb3dkRy9LK3hHUmRXTE1jV1JNRFNS?=
 =?utf-8?B?ZzR2S3NaZnp3NjZCQWZ1TjIvcldabnJxZG9abGphQjhybFdXK3hnVzNxWExH?=
 =?utf-8?B?U0hqUGNNNjlnSE84UkJUVjk3MjQ1YzZxbzM0cXZyNlh5SWRmOFpnWmUvdmN1?=
 =?utf-8?B?cVZsWnRTdFNhMDhyTTJTUlYzcXZWeU5UTEwrRGhOOWVYTVVsamZoZGRSWHBt?=
 =?utf-8?B?dmhKdmN5d2FRN1ZUVURwK21lbHVuQVgrRVlwanAwYUxlUzhOQTBQSm1zMFUw?=
 =?utf-8?B?OTViMkFkdURTVG00WXZlU3BlTWFTQVhVT0lremgwQi9uVExNZGk5eS9aQysw?=
 =?utf-8?B?eitTc2ZQTUxNWjE4eTd4dGlRdEtoQ1A4SXVKeWw4VnJSU1FXcE04ZUh0Q1Nt?=
 =?utf-8?B?RHNKTkxPR05vejVFWXlmOFYvZW9WeUk5elpSb0YwazVrN3A3eGY2amdKeGNi?=
 =?utf-8?B?eXR3cXFXbExvZVI5YmpSM0VwV0Nxd1dsbXZqWmhCcHkvb0dLeVpBbW0xREZq?=
 =?utf-8?B?TjBYblRxL0pZS3hscmNDdm14UUlnbU9wb0wzSUt0NTY2S0RUaStEaWJnSmhO?=
 =?utf-8?B?dU9Gck9QazUxNjFveWQxaUdnUjRIQTJUUmFvN0RzUG1VUW9xNjZteFBTY2Iy?=
 =?utf-8?B?MUgyNWgveWF0L2liTjg3VE00dVJka014bzZUUy9GQ2hKRWdZRVNzcG5HQzN5?=
 =?utf-8?B?elhtWUx6RWlESEdMaWR6M3UxMFpGUExlbVhGaXZiLzNtRTJhMkxsNXkyd1ZC?=
 =?utf-8?B?R0VyUzJaekhjU0ozMGdKcXJTOGZDN1RGOEUwN1RFNDRUd3lrR1Q2Wk5DU2N1?=
 =?utf-8?B?YXhXM1lENlljV2ZkSkFBTEYxakpzVDlEN083YW5YWS9aZ1VaL2oxeVBkdHpX?=
 =?utf-8?B?NG95dXF6OE1pbG9JQmltNHYxRjFMRmVnOGpKSGV3bVV0RmFGUGt6Z2xaY2xz?=
 =?utf-8?B?NVl6N2NBZTFtSGVXVzczRlVRK0NCVllFRENTaWNZck15R3JFT0VPM0NxN3VE?=
 =?utf-8?B?WStVVDJBcW4yN2hBZDloNmpsalluSHJPVGgwRTA1Z1ZwYzNpRDdibDdMbmF3?=
 =?utf-8?B?TkwrdERMc0Y5WHZZMVE3RUEyMUFEanpTdStWeDhSdG5NeVdhRFV0TW1jMzU2?=
 =?utf-8?B?RWlZQkpQenpXMUVtVHFhVFBya1p6a3RaMTNrRmZ4TmIvRWttSDRBV3lSYzkz?=
 =?utf-8?B?dnFmVFhVYk03YnpQKy83YU1ZMndmQnUvRHpFRSsvUXpPdEFnZVhQWDZRVHBG?=
 =?utf-8?B?OTcxdmVqaG9vUGpwdGpyZTJlUHRQZlBOeWRkUDBLOGtJb29YKzJ5MVNlbm0v?=
 =?utf-8?B?NmVhaUdDRUt5cmphVDNUeEh3WVdMU2kwd0VqWi9MOEg4bjgyV1A0V09BNFpJ?=
 =?utf-8?B?enJUSmhMY3pyMFNLUnpRWllWN21wRVhzcXhKOE0veFhGZkxZSVlJb0JaYVE5?=
 =?utf-8?B?ZkN6ZitWNW95dXZpeTFUbGlYT2szOWlXTGpkczRQZUxwV2dTTTZkRWJDcVBt?=
 =?utf-8?B?OWFwd3BOdERFS3ozREJCVkM2M1l6MzdzY3Y4aWErdE9qTkdOZ2sxOEwyL1NQ?=
 =?utf-8?B?UUJhSlJTbGpBR0xCaThFN1JJWFloMEJXVVIyY1NTL1RHK2NCUkhnZz09?=
X-Exchange-RoutingPolicyChecked:
	E11+J17KDsVxOboQ5L7BCnUgGG5KPeAkvaLDoGh6GO64bzjbWpN0sTT6ObfIOhsSZb3XFyY4ilEJMRhrM8k9VD4DZBgPtj0+1Jmm8qaoLVxzQC85aTer8/EJpcXf49xweSmqHKkjOOsvjnRH/z2lzw/ZcbOkPjHx+urQAG0DhWMV6JVKiyfdOShMOPD0kVFkvCf4RY1OXs6x/g0eQJLvi8HE6umemtU/9QzPcN0JwCixVtqjw6slWEw+tCtuuuonrDH2iHKU4AfjjMCaLcO7aE+mWabkBJOAhrlVbA/dkC+1wEQ0BqaypgDmzu86pO8yt6fXUNW6Y7/d+oDqLhfGEA==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f052a68-ce7d-4571-4e5f-08dea4317900
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:49:12.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W52k82sg0Arjs9cIMdw6nezbjvbnueizNH+yqNOlXhddcRWaJ+4HtrxxbKbRm3YgFrp/dvxUrXZOIIwSGrLqSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
X-Proofpoint-ORIG-GUID: YfSVx3gaTmqbNqYhbzt_2jUuSDfudRAw
X-Authority-Analysis: v=2.4 cv=Y6DIdBeN c=1 sm=1 tr=0 ts=69ef14fb cx=c_pps
 a=n68PQVbWKEFYfOwbXA7NlQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10
 a=i1IsUcr2s-wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gIHJBl62Mt9vjvfn7G3b:22
 a=buQUfWhnF1OtDDk5FV7I:22 a=pGLkceISAAAA:8 a=dL-elrpOpMQk_W1iTM8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA4MiBTYWx0ZWRfX/2KErTtNqnsO
 GWdJxbUN/o1JdOpx3SIumNBUQyyGxqWtDx4ab16qEm+d5V99Z4HrCMYFaeVOA10hcqV7WHi5ZSQ
 kSjydqU22wldNWD1DUPLwIkdPr9rOCJuPZI4m3gL+P40ARdm+CrRSKcfafZaXYWCe3/Z7P+X/TS
 Z2qp+m0aI1VnL/a6p2MyY5JUBogeheBJpVHxCEw2Oc4WlinSqRAtQO2/GCoGRjeDCEJMyciVCqj
 gmmFP52YW/kobkHsutRPMxlh48qNWndtEqiisz2IPwiZhW4djUcNLhOr/yVXQdKWpxf4SruwOZ1
 IRB1b9gTpMaCR97En+4arJWrsddC03BWyJ0RqLoMR2gaQPFeuTkZQycasAfTcev9z0okPdckEu0
 ep+PmWBzfo+1oJt2PZ6TXUWm8LY0MI27k2zaBaGMR3nRKdGKcyxQ/oNT9z9dTlx3vmbg4r+lH9p
 Uic0ONmZ/dj70aWakYg==
X-Proofpoint-GUID: YfSVx3gaTmqbNqYhbzt_2jUuSDfudRAw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270082
X-Rspamd-Queue-Id: A946E46EB54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.25 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MIXED_CHARSET(0.91)[subject];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[silabs.com,reject];
	R_DKIM_ALLOW(-0.20)[silabs.com:s=pps12202023,silabs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35341-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,silabs.com:dkim];
	DKIM_TRACE(0.00)[silabs.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jerome.pouiller@silabs.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hello Rosen,

On Monday 27 April 2026 07:16:04 Central European Summer Time Rosen Penev w=
rote:
>=20
> In case nvmem gets used and is not ready in time for probe of wfx,
> EPROBE_DEFER gets called. Return it so that a proper MAC address can be
> specified in such a case.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/silabs/wfx/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireles=
s/silabs/wfx/main.c
> index dda36e41eed1..dc40a9bd986d 100644
> --- a/drivers/net/wireless/silabs/wfx/main.c
> +++ b/drivers/net/wireless/silabs/wfx/main.c
> @@ -445,6 +445,8 @@ int wfx_probe(struct wfx_dev *wdev)
>         for (i =3D 0; i < ARRAY_SIZE(wdev->addresses); i++) {
>                 eth_zero_addr(wdev->addresses[i].addr);
>                 err =3D of_get_mac_address(wdev->dev->of_node, wdev->addr=
esses[i].addr);
> +               if (err =3D=3D -EPROBE_DEFER)
> +                       goto irq_unsubscribe;
>                 if (!err)
>                         wdev->addresses[i].addr[ETH_ALEN - 1] +=3D i;
>                 else

I assume this patch works when WF200 is connected on SPI with reset GPIO
configured. However, for SDIO and without gpio reset, we can't run the=20
device initialisation twice.

I believe the check has to happen before the call to wfx_init_device().

To check it works as expected, can you also test your patch without the
reset-gpio attribute?


--=20
J=C3=A9r=C3=B4me Pouiller



