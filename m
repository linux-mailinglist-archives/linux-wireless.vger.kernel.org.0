Return-Path: <linux-wireless+bounces-15717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E09D9A26
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 16:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF82283F55
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748B71D54E3;
	Tue, 26 Nov 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="KB9qIXRe";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="Y+zoiLuE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7056078C6D;
	Tue, 26 Nov 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633573; cv=fail; b=XeYL6M4RxQSZ4QjgWfAyX5FTA+pNhcjqJyb9GBmO6OQ76oRC1PF4NO2MTuZNYEXwLOlUxF1G4lNRuGzSI5UWc7SE2xDxaV4/f6ldXoIiMzBL6D7UUNk35RlmeaXK8lPO5yKkrn1WBOthBYBITp9LpIBpfUXg1qX0gewnII0QQqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633573; c=relaxed/simple;
	bh=tNO1x7piRQIRb6e9YZDjvTqUQvltfAjZnXZ34wnJ2Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oqAIMtADwXtYln8TRbqFebZg3v6pa7gq6UjHlWtuH4fLuws9jHw0IKc1icMmMgaBA6BbaF0pMoDeMdUCojtJfkfqITZnrY8RMzrybV+87XhRsqxjwFE7L2ppi+NaGp6VwGR0j30ZxWteNUUWIvoujHJ4WOCtUWqP8VQoW2fG5+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=KB9qIXRe; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=Y+zoiLuE; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQAOF9w027287;
	Tue, 26 Nov 2024 08:45:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=0npkZMkyKXdFih4ZzTYQtDT8wuqQzr9r/Y5TbX5ciAY=; b=KB9qIXReyzUS
	+tSRJZxmSuUHgZ0fynkIFXh+EkRG0ouFWVko/ZvQ5H5oZdoouXAmhmc1Fay6V6HR
	qDkwCnl19bkJ8WMmMY3YEdM1qhM57kT2xSaeGaWTEr3z58rESmOvFQSNxEY6FAao
	3PXQycMPY+JQ6X9hI3VKEEEKx96rHZXmbUFXbpIQ2RFE/5BVvPXGP4osu6Nh3lwi
	aIwxL0Dvt7n9o3vEaKgVCbOs0pdJfrSUuV8Z68Ivvn5+2E3hzaPVZtbhdjJuTnw/
	3ycSYT6Y+Ny0gRL5le5yG0RZ6u8+Ua1ZwADWSoYKYo5hsj1I4iq2h5QUqmFFczhk
	U/3Q9sydXw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4339ed654f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 08:45:51 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXw5nvPI/K1dSAO/JByM9SLOzcl01Udq9icshM0/pk+THdL/NiM3oewyWm7g6xT6o2oYqvUVlSzu4d2W44DSa1pgT79vFN0xorS9fV72P7I/FAPyI4erirMtU+ImnR9KZbZg3Y+y7j8vOt/uJCewr9ZeQ4birv41jbmmvDlGqe8BEunr/YNhpTSivwMdtps5S1iW5UNfoDFFeKj1Wq+2TTQ2VihicNew8tYHQpk2iaFJvLJgfA2br1mN8sjYw2AwegjrvsxmJ1bR1xdM6qc3FNBLYUt2y1C9d7uA+byoTJc1T2589gVQRJ0RuybinVbjKqCYjfK2dicpZV8TTwcg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0npkZMkyKXdFih4ZzTYQtDT8wuqQzr9r/Y5TbX5ciAY=;
 b=LGgDHFDkaM4miPM5Thv48FhEYQ7HGis6uvcqxWZAsYM/Comy8sEFvKmkwHHDZ0xwckO5uTZoKEhVP67da6XFAv188nF2HbfCt1xLAU/aFsSPljKQSszXbmlPec4C/nRvdpi6m+FDa9/ECO3+XASKZuUtNPq4sQj3DV3Ff+8OD04REZj/I143BKEdpOAKMqyDTcPjyWAa3wZjoYLooYmVBR/VvrKUGea7A9zwdJjdFq+SI6kZPkO25SpN9yMTbM3seVOYjLt2+RJdBiwCmPA/jse9Q7OmY2RCpQ8Au8w8onZ8oxhvBXivvZ2JvNqCZveK5kSEiS9gin1fi1y7bT7L3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0npkZMkyKXdFih4ZzTYQtDT8wuqQzr9r/Y5TbX5ciAY=;
 b=Y+zoiLuE7/JUyjBkLapczc1iVs7Fl/d4eYb+9aeWlM/ojElDU9XBT7C/xfGyfdLKGONQRJQivKHTkFIQwjjb5ujRw0tK0ek+e2XhVhYLZZ/qd+U3xakiKqCxwSK0Wz7uo6ZOQNw5OeCKhiaNslpYnbfPBOP0o/2H8E/KGKqNUjY=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Tue, 26 Nov
 2024 14:45:47 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%4]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 14:45:47 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] wifi: wfx: allow to send frames during ROC
Date: Tue, 26 Nov 2024 15:45:31 +0100
Message-ID: <1769588.QkHrqEjB74@nb0018864>
Organization: Silicon Labs
In-Reply-To: <d8e9a080b3fa9a444e4634bcc85b22bcc1ed57a6.camel@siemens.com>
References:
 <20231004172843.195332-1-jerome.pouiller@silabs.com>
 <20231004172843.195332-8-jerome.pouiller@silabs.com>
 <d8e9a080b3fa9a444e4634bcc85b22bcc1ed57a6.camel@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PAZP264CA0256.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::8) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SA2PR11MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0f543b-772b-428b-e25f-08dd0e29033d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?QnAwsRgp+TkSUojRNz8R8WHS9HL+Xgbsi2ay2DoodlNHera4pdU6pW6eOm?=
 =?iso-8859-1?Q?BQezACQz++ctt0447GGrc1WhIxHWx3iG7qOVo9Sn9OFpeeM/6Ys+5fnPCo?=
 =?iso-8859-1?Q?W2fHrE671/+kIcUZDqd5A6YwAEIOstnu5DCLVe8GWmMeiCfoMdCTiJKMKE?=
 =?iso-8859-1?Q?atVMzGxmubx8OtFFoJOqqINnE8lrUd2o/XAuCabHpX+qalcvlI87SGAI61?=
 =?iso-8859-1?Q?n2WTaKQhU5f+uZGFoKHCiVU6QKCOFXqrHsiB4GLN3xVvlsnvSCA2uSEX/j?=
 =?iso-8859-1?Q?opxE9tCxpTIfSv7xNDKcVfKafyzFZgVtYdtSuh0RHIGfMJsMvo3s1mYnCl?=
 =?iso-8859-1?Q?jLbNkSSU7lg5obNUFFI2MHakz1MDT7tXqQuSr5FUmMPCQFmnCd3Uss/Jfd?=
 =?iso-8859-1?Q?EPQa6AEpZOau64o3Z/TaGOLBXZyPVbleBpgexdpViAJrBxaOPhMi3DQLF0?=
 =?iso-8859-1?Q?cOQDPFZMCwWcTe2PqO4qSpf/8e/cZJMAR3fv8MIGsrBiUPKVbZrBrIZvZP?=
 =?iso-8859-1?Q?MwIuAmUALighVmtTBtTuy3jrbRYB72vd+U1HmhKCopSstXIXIM4OXGALyk?=
 =?iso-8859-1?Q?nXSdq4urnTEldC49MN1r32PMHYrm7pDggKTYkpKDK0wGJIrxyANvIhvGan?=
 =?iso-8859-1?Q?z4GDQ/ZlMOF5j2xLTb5OnQsEx4gbFny7TJ587maSGBMIV2lea6Co3kmHKt?=
 =?iso-8859-1?Q?O86ntfMc9I3l49KBldu8DltRfE4XPT5GnJc0V49YAsvtWwFMwaVT153VaU?=
 =?iso-8859-1?Q?qQOteuengMh+FvSKEe6PgbI063Igb5aSY0gTDCujlsIwGOzRfaD27WBdTF?=
 =?iso-8859-1?Q?l4ftzMelLCwW0A5WZG6lbcud+B/xVoh5ZIHb3Ob6DZHr3k9sCbc3t15f7I?=
 =?iso-8859-1?Q?Ud/uX/tM66+0w136RF5IeRWKLfLuQRD4vYxjrfvQpNDXilq42S7i7/hyA7?=
 =?iso-8859-1?Q?5lOcAlFCDJIX5HFRHgD6RYs3QrXA44+RcL0gcknubZx7mU/8EF/7QUJdHM?=
 =?iso-8859-1?Q?FrGyj2GTbXux5YuLrK8RGRY1ybJTGBajftnHf7bVDszDqb3wZJnaFvNffy?=
 =?iso-8859-1?Q?WYFUvCrQ68ZbOAw5hvoqmVGaEZm5rCU9esxhgTZP/bIIB7NjXuUe/VcYBz?=
 =?iso-8859-1?Q?SCAbaJjrPtMWJbUWhAT3lP6CRfT8fz99AzVgthGshu+hjrWF2KEhNsCmhh?=
 =?iso-8859-1?Q?GVlyEn7zJEUXIi577owi17Cu8MM0vAsOtRmd4wVtjER+0gvQnuEsOyCEzj?=
 =?iso-8859-1?Q?u+qEn20yG47hjxyVg/zL4iQHEP+A1AywgCcx190fXnzHueSQW1bQlJ/XWi?=
 =?iso-8859-1?Q?XJn8bY8qWrBioRAlDZgoOzj2FKg0pC2vFqCm/oSSPwOMT6UrwQpPQQyp9x?=
 =?iso-8859-1?Q?I73AjUHrJFrukp5PN8XHAjT0tThhHtCvqncvyOsgCO/3tlp5s/xw0v6N6m?=
 =?iso-8859-1?Q?w4vKT7d11DqUet80admKpp2jh0IvVNRrxbVtGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?YzzraGVhACRJroLwV1F+XfmVObu2oISzbE7Rd8UCX23LjnK5b2793O2sn9?=
 =?iso-8859-1?Q?nTkpWK6gGzQpw6WVhYYDC6eobCCyFvCO0iEiFT2OEuBr7HhgSK2J7U8EKo?=
 =?iso-8859-1?Q?U/jPFku0pzgz5A6voE5Svi6L2nWs+jxYpSVo27EeDO+TBnAxLEUDHT6yoU?=
 =?iso-8859-1?Q?0cEpuakQNY2QN0smAmik1/lfg48XRwIbe3pj3tHvFcju1ftfKO7Xf5T4mo?=
 =?iso-8859-1?Q?6Uh8n2GwEQZr2GpDY4REMDB3TesisfaAFYzyR+85HWTSS1+5dRW64XoJmK?=
 =?iso-8859-1?Q?JrTatmY0RnNxHuYo1cdhFiFwZDuvWU9xlGeqOka2xCtWQatS2y9PmpajGZ?=
 =?iso-8859-1?Q?e3Ewo2j4vdl+/iOvQ0MXQklTiL66PpACTwatn/ch64sT0AoZ40cAOqfcAH?=
 =?iso-8859-1?Q?XKY4rnPG4oxp+wPcIa9DPlpmDeC/WkOoxw+yfXP3jHUicv/lni3DOJhyoR?=
 =?iso-8859-1?Q?n2RndDGCf1BGxs3+xL1KMotxBqKWzuWeSdLAHVeDncjqg70CIA+ch5V42T?=
 =?iso-8859-1?Q?88j/U8HLssVVauaaz6X/s7lAQmg504SlWc2dElIa80KHzjksLhlTwrwSyC?=
 =?iso-8859-1?Q?esW6EQktx91RqfR/iirfvdVPf91MchyPtNHLxkjfjYaOw1m8sSWRbV3iu1?=
 =?iso-8859-1?Q?jdkk1WvQ+scogrLSDAPEkLPxaRsPjQWx3slh2ssQ8Bh/SmqJgBUvdSozvG?=
 =?iso-8859-1?Q?e1RrQAl92BFzomjcytI03s9YdtLSdVTw/XR5DwbghncEeiDg7KFIbDOVQa?=
 =?iso-8859-1?Q?izOstKafywjOtErSv19pXoV+vD/boZI2qdK09Pafik6G95SCFvQ9UgmQLx?=
 =?iso-8859-1?Q?GV+M4ArIjD/8LRZn34DH8LbnZstHvmguOwj6rlMpPgrVDTMVKSlliPOh//?=
 =?iso-8859-1?Q?SN/Hva//zB5gOeZ6Hb337eQwOVXFXtIH1ookmsgCzPIL9bqyQ/yS6TLQ+A?=
 =?iso-8859-1?Q?lyBVPqz/dbk4MyibDuxTQpPOf+1+Ajt2RGiFjczL+ag5UCc0nnvNmpFFSS?=
 =?iso-8859-1?Q?yOwiwOEmrmDpG+Q77s6lrtJtL47LwCbiFE0mWtTR0vWHzVGO45/xeBi/AZ?=
 =?iso-8859-1?Q?5+hSapy/xev9WiLvXSSpzZexFlftDuNgI4I6NBuX3jBWbRMoAVW19LiIaz?=
 =?iso-8859-1?Q?l1cXJftZIQOzw+7+1vVZhZB0a/5aNrXmA55QvKjv3n1KuxtV82ywac3BOI?=
 =?iso-8859-1?Q?FRf9x9EEUBKXr4CozJqz7htapV3ZgFkodZIOyEEUtZobGuxjntcodNsf8C?=
 =?iso-8859-1?Q?QF9mz+hRkRjKSHFabIpateC5RS0Lc4314DMyUNA3Sne2KAW2s1s8txQf1z?=
 =?iso-8859-1?Q?Yepyh1TNtIWAWPVl2VEBX3Oi7meMh6O/fnwhoergE+Ug79m7uGl+3QWezF?=
 =?iso-8859-1?Q?Z5TirC3l6vvzu0uNAzNB+guVnzvN2ubr8Mh3u36/d6qnpAPuy7XCriicPA?=
 =?iso-8859-1?Q?GQUNh1aeyRtDvxkIOFdrI38dwDq3opVgf18Zj2E1608LH8JykXHBM52yEB?=
 =?iso-8859-1?Q?2Z3eVrN8+MVjXVwYLZyO1W26fj9kP1FrelrulL6aDV/87iLN4pKqGXOOyw?=
 =?iso-8859-1?Q?Uc93qEfDs+82a/4reR27qtx8z47ihXDBhOOIutmnFxhSyH4YjbKM5Dq6qQ?=
 =?iso-8859-1?Q?C4KryEX/JAX5QgsO/G2bc0HVLYUVH7Vsth?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0f543b-772b-428b-e25f-08dd0e29033d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 14:45:46.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTEVITC0LtGqvpj4V2IYQ0ed0qoaUYEuMfnmdg5NqOKEpxYvgWmbiRF5i0TxGdYXNR5Dcx4qBEsTY8V9KY+flw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-Proofpoint-ORIG-GUID: 8paqvFsFC1Y1Y5IaK1ElvcacdgpW8ade
X-Proofpoint-GUID: 8paqvFsFC1Y1Y5IaK1ElvcacdgpW8ade
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_12,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411260119

On Tuesday 26 November 2024 08:27:43 CET Sverdlin, Alexander wrote:
>=20
> Hi Jerome,
>=20
> I've just got this (with CONFIG_PROVE_LOCKING) in idle,
> without any traffic on the wlan interface:
>=20
> [119012.104386] INFO: trying to register non-static key.
> [119012.109730] The code is fine but needs lockdep annotation, or maybe
> [119012.116313] you didn't initialize this object before use?
> [119012.121992] turning off the locking correctness validator.
> [119012.127778] CPU: 0 UID: 0 PID: 336 Comm: kworker/0:1H Tainted: G     =
      O       6.11.0
> [119012.139802] Tainted: [O]=3DOOT_MODULE
> [119012.148547] Workqueue: wfx_bh_wq bh_work [wfx]
> [119012.153591] Call trace:
> [119012.156282]  dump_backtrace+0xa0/0x128
> [119012.160340]  show_stack+0x20/0x38
> [119012.163939]  dump_stack_lvl+0x8c/0xd0
> [119012.167890]  dump_stack+0x18/0x28
> [119012.171472]  register_lock_class+0x4b0/0x4c0
> [119012.176033]  __lock_acquire+0xa0/0x1f50
> [119012.180148]  lock_acquire+0x1f8/0x330
> [119012.184083]  _raw_spin_lock_irqsave+0x68/0x98
> [119012.188731]  skb_dequeue+0x2c/0xa8
> [119012.192390]  wfx_tx_queues_get+0x20c/0x5a0 [wfx]
> [119012.197525]  bh_work+0x3bc/0x950 [wfx]
> [119012.201749]  process_one_work+0x234/0x658
> [119012.206040]  worker_thread+0x1bc/0x360
> [119012.210056]  kthread+0x124/0x130
> [119012.213535]  ret_from_fork+0x10/0x20
>=20
> the uptime is pretty high, as you can see, it's not in startup.
> But I've noticed that NetworkManeger closes and opens
> the interface from time to time, which leads to
> wfx_remove_interface() of wvif->id 0 and consequent
> wfx_add_interface() of wvif->id 0. And only 0, which seems to be relevant=
,
> see below...

Thank you for the report. Let's dive into this.


> On Wed, 2023-10-04 at 19:28 +0200, J=E9r=F4me Pouiller wrote:
> > Until now, all the traffic was blocked during scan operation. However,
> > scan operation is going to be used to implement Remain On Channel (ROC)=
.
> > In this case, special frames (marked with IEEE80211_TX_CTL_TX_OFFCHAN)
> > must be sent during the operation.
> >
> > These frames need to be sent on the virtual interface #2. Until now,
> > this interface was only used by the device for internal purpose. But
> > since API 3.9, it can be used to send data during scan operation (we
> > hijack the scan process to implement ROC).
> >
> > Thus, we need to change a bit the way we match the frames with the
> > interface.
> >
> > Fortunately, the frames received during the scan are marked with the
> > correct interface number. So there is no change to do on this part.
> >
> > Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
> > ---
> >  drivers/net/wireless/silabs/wfx/data_tx.c | 36 ++++++++++++++++-----
> >  drivers/net/wireless/silabs/wfx/data_tx.h |  2 ++
> >  drivers/net/wireless/silabs/wfx/queue.c   | 38 ++++++++++++++++++-----
> >  drivers/net/wireless/silabs/wfx/queue.h   |  1 +
> >  4 files changed, 62 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/wireless/silabs/wfx/data_tx.c b/drivers/net/wi=
reless/silabs/wfx/data_tx.c
> > index ce2b5dcfd8d89..e8b6d41f55196 100644
> > --- a/drivers/net/wireless/silabs/wfx/data_tx.c
> > +++ b/drivers/net/wireless/silabs/wfx/data_tx.c
> > @@ -226,6 +226,18 @@ struct wfx_hif_req_tx *wfx_skb_txreq(struct sk_buf=
f *skb)
> >       return req;
> >  }
> >
> > +struct wfx_vif *wfx_skb_wvif(struct wfx_dev *wdev, struct sk_buff *skb=
)
> > +{
> > +     struct wfx_tx_priv *tx_priv =3D wfx_skb_tx_priv(skb);
> > +     struct wfx_hif_msg *hif =3D (struct wfx_hif_msg *)skb->data;
> > +
> > +     if (tx_priv->vif_id !=3D hif->interface && hif->interface !=3D 2)=
 {
> > +             dev_err(wdev->dev, "corrupted skb");
> > +             return wdev_to_wvif(wdev, hif->interface);
> > +     }
> > +     return wdev_to_wvif(wdev, tx_priv->vif_id);
> > +}
> > +
> >  static u8 wfx_tx_get_link_id(struct wfx_vif *wvif, struct ieee80211_st=
a *sta,
> >                            struct ieee80211_hdr *hdr)
> >  {
> > @@ -352,6 +364,7 @@ static int wfx_tx_inner(struct wfx_vif *wvif, struc=
t ieee80211_sta *sta, struct
> >       /* Fill tx_priv */
> >       tx_priv =3D (struct wfx_tx_priv *)tx_info->rate_driver_data;
> >       tx_priv->icv_size =3D wfx_tx_get_icv_len(hw_key);
> > +     tx_priv->vif_id =3D wvif->id;
> >
> >       /* Fill hif_msg */
> >       WARN(skb_headroom(skb) < wmsg_len, "not enough space in skb");
> > @@ -362,7 +375,10 @@ static int wfx_tx_inner(struct wfx_vif *wvif, stru=
ct ieee80211_sta *sta, struct
> >       hif_msg =3D (struct wfx_hif_msg *)skb->data;
> >       hif_msg->len =3D cpu_to_le16(skb->len);
> >       hif_msg->id =3D HIF_REQ_ID_TX;
> > -     hif_msg->interface =3D wvif->id;
> > +     if (tx_info->flags & IEEE80211_TX_CTL_TX_OFFCHAN)
> > +             hif_msg->interface =3D 2;
>=20
> I never actually see wfx_add_interface() with id 2...
> Which leaves all the queues uninitialized....

This is expected. Interface 2 is not a real interface. You can consider
it as a special queue (for offchannel packets) on the device.

[...]

> > @@ -246,6 +250,26 @@ static struct sk_buff *wfx_tx_queues_get_skb(struc=
t wfx_dev *wdev)
> >               }
> >       }
> >
> > +     wvif =3D NULL;
> > +     while ((wvif =3D wvif_iterate(wdev, wvif)) !=3D NULL) {
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Is there actually any point in iterating over wvifs here?
> It has been done right before and all the queues are now sorted in
> the common "queues"?

hmm... you're probably right.

>=20
> > +             for (i =3D 0; i < num_queues; i++) {
> > +                     skb =3D skb_dequeue(&queues[i]->offchan);
>                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Nevertheless, the lockdep splat comes from here, because
> wfx_tx_queues_init() has never been called for wvif->id =3D=3D 2.
>
> What was your original plan for this to happen?
> Do we need an explicit analogue of wfx_add_interface() for vif->id 2 some=
where?
>=20
> I still have not come with a reproducer yet, but you definitely have more
> insight into this code, maybe this will ring some bells on your side...
>=20
> PS. It's v6.11, even though it's exactly the same splan as in
> "staging: wfx: fix potential use before init", but the patch in indeed in=
side.

Yes, probably a very similar issue to "staging: wfx: fix potential use=20
before init". I don't believe the issue is related to wvif->id =3D=3D 2.

You have only produced this issue once, that's it?

I wonder why this does not happen with queues[i]->normal and
queues[i]->cab. Is it because queues[i]->offchan is the first to be
checked? Or mutex_is_locked(&wdev->scan_lock) has an impact in the
process?

In wfx_add_interface(), the list of wvif is protected by conf_lock.
However, wfx_tx_queues_get_skb() is not protected by conf_lock. We
initialize struct wvif before to add it to the wvif list and we
consider it is sufficient. However, after reading memory-barriers.txt
again, it's probably a wrong assumption.


So, maybe this could fix the issue:

diff --git i/drivers/net/wireless/silabs/wfx/sta.c w/drivers/net/wireless/s=
ilabs/wfx/sta.c
index a904602f02ce..b22ea4243c0f 100644
--- i/drivers/net/wireless/silabs/wfx/sta.c
+++ w/drivers/net/wireless/silabs/wfx/sta.c
@@ -748,6 +748,7 @@ int wfx_add_interface(struct ieee80211_hw *hw, struct i=
eee80211_vif *vif)

        for (i =3D 0; i < ARRAY_SIZE(wdev->vif); i++) {
                if (!wdev->vif[i]) {
+                       smp_mb();
                        wdev->vif[i] =3D vif;
                        wvif->id =3D i;
                        break;


However, I am not confident in playing with memory barriers.

--=20
J=E9r=F4me Pouiller



