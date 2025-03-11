Return-Path: <linux-wireless+bounces-20133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2407A5B849
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 06:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108691894104
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 05:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7CF1E9B1A;
	Tue, 11 Mar 2025 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gWfC7LRq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010013.outbound.protection.outlook.com [52.103.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3B1CA9C;
	Tue, 11 Mar 2025 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670092; cv=fail; b=sUSU1BTODwQIWb0e9LeWMTvAR3by+DXWM8HaE+E2FUHlSZFrC8HxHS762AeJAcVStN4VBkG1MEiy4ay4tkk20QJl2pv5o7/PjTDB/44qP/MqjgNf04m5BeefUNneNxIdAHIV6eR/BaM1gsAWd4R5HE8PjTuQOPrShevkkIMMG+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670092; c=relaxed/simple;
	bh=kWgQSl5qpsRIzaib/YKMr0AhmMn+UT/DjysEH35xJUY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JZ9fEO0viCcKYn3UOVgvF+pZYTOzuky+HFcoQ3nyq0m6XZYJoUjYUxsO1DT66BUn9P0PNzSRhxXvKUe8b4u5kVK8paIpfCIIrqhcEcnJ39WuumdX4dHrDVCpx8feFF7GXFQKfZMM8CZhrhZw32Q02TL3aUNP9PQbtaVwSDP9kyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gWfC7LRq; arc=fail smtp.client-ip=52.103.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/Ive2UmqDFHbvb6AEUMn9aCH5oBPRqd4CXHbMJeGly1kc1gzD9luShILuebTvDiEG3mrmoFvFruST1uAO0YxcXSC+AfBQPkl6Ot46YHRVAKWA1RussPNpwMj437REv0sURte43BJ2MNT+txyhOKk0MC4a2cbN5vyO9rnDTPr1zHzb4Ee5g0iWIhdqIrgn8B6Ga2DJf0aAYR0rwn3QuWCp6+MRbbyRoOJ/+N4Afkr2IdroIGi/0llLYYX5HrURO2XUYeisPF2nyftU3xSRCyUzd/b5cuGUAxry+tPi0QUGfZB1cmmy0829YloSuVcXe+VW/4TaaEylohZV2PGXaR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWgQSl5qpsRIzaib/YKMr0AhmMn+UT/DjysEH35xJUY=;
 b=AyGS1coq/RoAA4u01JIm54iefn5P3Owt2k1QGiRMl40/sAffwm4Gx2319JX9IZnedsP/BmDrhOI0R4NnSbFg1RxsZxh2Wo90ZEr19MIMUL25IH418KbJGA62z7Ad+W6zf6ByXpUjC+cmkKDZ5Hynsm7JhAEO8H6MmHpFS5rF+MwpZhHdbbxHmpVo91zDDk3zL5bB9dh3YE8K59y8lE7R0dHuiVEq4alX5/SVxzTBKL/ZuXHZZBbJKBzhm/1J/O1om+SUpHJQNdZ+2FVxbOp9ulJ24I+TtZ7RkPFCimKNBGe33yhLV77C7x4T9YcE8U6W+4TRsYGPmU33w9ICtJXi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWgQSl5qpsRIzaib/YKMr0AhmMn+UT/DjysEH35xJUY=;
 b=gWfC7LRqeACJ4Rq1wHORYI3lB9S6Hd7vXKOCpGRXKhor1yg6+onmRrzwSpdlW/svvh8Ooan3HnuRmM3BmRCpuRqMQL02jvLDFpoYFXV9pgyUPt0CbEdDZ2/K3xDxIY+oqyh1eh3lkozZh0X83VD5aZXKYaKw2+TF18Xwum7+UoXeIed48d32B1GaEkjNto1DhRbfKZ7IWGCcpSrokTfJs1M7QGcK1w9mdj38ZrBTfAckSDIrjrVxXTwwgjdxadCZlnGmk0ilWqCtroEZlFsaRNYL7abk9Uf2jGKF5BeiwoUO8R8fj37Hj8sAX1u+LfvM84L2gMz7vIr9cV37/HGbbA==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYRPR01MB13896.jpnprd01.prod.outlook.com (2603:1096:405:216::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 05:14:45 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 05:14:45 +0000
Message-ID:
 <TYCPR01MB84379512D874F722A0466D0A98D12@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Tue, 11 Mar 2025 13:14:41 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com
Subject: Re: [PATCH v9 RESEND] wifi: mt76: mt7915: add wds support when wed is
 enabled
To: Ping-Ke Shih <pkshih@realtek.com>, Felix Fietkau <nbd@nbd.name>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
 "howard-yh.hsu@mediatek.com" <howard-yh.hsu@mediatek.com>,
 "greearb@candelatech.com" <greearb@candelatech.com>,
 "chui-hao.chiu@mediatek.com" <chui-hao.chiu@mediatek.com>,
 "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
 "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>,
 "sujuan.chen@mediatek.com" <sujuan.chen@mediatek.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "bo.jiao@mediatek.com" <bo.jiao@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
References: <TYCPR01MB84376C7074C566865654F05098D42@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <b6b52bfcdb614137ac63fddfdaf9cb97@realtek.com>
 <OSZPR01MB843481965BA47B030566DF2698D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
 <71ed8398-4619-4793-804d-77cad36e7402@nbd.name>
 <OSZPR01MB84345D44294ACA75A863ED6B98D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
 <349d0fbe197a40068377e889a2311cb2@realtek.com>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFazLV3FGBjT
 +9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q4Ww/W87mQ12nMCvY
 LKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx0HJ92zTBMzMtYsL7k+8ENOF3
 Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/SJv0w2YmqZDIAvDXxK2v22hzJqXaljmO
 BF5fz070O6eoTMhIAJy9ByBipiu3tWLXVtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1e
 l5WW/qxqrKCSrFzVdtAc7y6QtykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdr
 omSrsD0gEmGcUjV7xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB
 +X85sxcr4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
 2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0xi/KZIRpS
 lIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQABzSFTaGVuZ3l1IFF1
 IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX5PUVXUNSaGVT2H/jUgzJGSnI
 5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDjUgzJGSnI57GwD/9O6kei
 9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSi
 OnyyHrg8StmGLksQE9awuTnlnQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHa
 JwFi1KATSI1AhsF3CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9vor
 aKhx+0DsZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
 Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISFgvZoGYdB
 9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaaLZH/jzQf7FpIGGhD
 YnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2yVu3w4tIchRT3wekMh2c3A3Z
 DeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yAj6Ey0YrIUbW9NOhIVCGkP4GyJg756SGz
 yPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AEH2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4
 TrXUR0ScTy1wTKV1Hn+w3VAv6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23F
 j4LK2mKTBoEwtC2qH3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8
 aiQQUKyZdG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
 Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM/pM4L0tP
 VCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwhagPSYDV3cVAa4Ltw
 1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVykk4q2DDi0dSC6luYDXD2+hIof
 YGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjnzuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ
 7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQzRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoD
 IbtRm3xt2tFrl1TxsqkDbACEWeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3Ci
 zcOmgc61pDi/B6O2IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DB
 bUslCmkAEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
 EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3PPt4wkQkd
 bF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZOpxb1EwWwvnVUwrLx
 CuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsNVeqrWU0mDAOgvqB86JFduq+G
 mvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEyuRmtKtqxTP/u6BzowkV2A/GLxWf1inH5
 M81QgGRI2sao6To7sUt45FS+y2zhwh62excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFO
 jeBOYr+ZCCeARh+z4ilo1C2wupQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrr
 mnEaZMsoRdS22fneCVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/
 1aPc2IoxcQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
 z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/aLzG+Fguu
 GNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2
In-Reply-To: <349d0fbe197a40068377e889a2311cb2@realtek.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BS5rU6CHC81qRWcNiKM5wWqK"
X-ClientProxiedBy: TYCP301CA0072.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::17) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <ba987db2-e077-4569-9a3c-bfad3e2ae7f8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYRPR01MB13896:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3cd587-2ec9-4161-fee5-08dd605ba331
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|15080799006|19110799003|5072599009|8060799006|12121999004|6092099012|461199028|440099028|3412199025|4302099013|20055399003|26115399003|41001999003|12091999003|19111999003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3h4YXJ3REhHd3loaDd6SUtTM0JZVndTcGxXZUdYRUtFbXR3cnB2UUx0NExT?=
 =?utf-8?B?ZmpINjd3UzEzSUIxeVdIZUFVWHdXTkZsbEtGdElqMDNnYVd1a2t3M0hSbEVa?=
 =?utf-8?B?c0dycng5SHFMWFQvd0c4aUc1TFhNbk0vVHNzYTgrdnJtN2RiaDlWUmhUcU9m?=
 =?utf-8?B?Z3B1d2hDcmREMXI4SWVhYmg1TkJXU2doRnJkVXUxQlViVWpaWVhQWTR4ZGhE?=
 =?utf-8?B?cWJjM2V0V0U1RjJYVlhrWXRIYnVPQUYvMGxzUTI5Z1paUjJYZ0txNHRYSkpT?=
 =?utf-8?B?eDVBckFLSlNkYkNsbDdKWms4YTYvaTR4MXlkdEcvUmhvR2xEcWZSNVNCRWZj?=
 =?utf-8?B?YWhFV2RMRFl4N0xZdXhYR29NdlY3UXRPRGJWMGg3T0p3dFJsTEM0UW1IYjJB?=
 =?utf-8?B?clBRcjArQ0U3c1VMZENNcm1EUGx4ZGZVZnlzTGlDai9hYWJYWWRGQ1dkTXNm?=
 =?utf-8?B?a0p4emJqWHNtVktqTWQ5ZWJzZ3NtV2Q0aVVHd3JwVXEySy9sYkhMUmVwSjZr?=
 =?utf-8?B?V0pXaGtLNzlqY0JuenB1QlFtZTBOTVFxa1E0cVMxR012eGRBSU11bVh1YVRS?=
 =?utf-8?B?cDhPcXp4eXhpRXlJZCtpdkkwa0FUQXA1ZlRKN2V3Wk9kSXl0cXp3dHVwODgz?=
 =?utf-8?B?NVVNMHV2TFhUWXQ1cFBSbjhtSWNPbnVoUERQNVFSQXFUczI5STVObVR5L3hh?=
 =?utf-8?B?bEZmOFliM2ZHa0VCZmdibTg5UzdvSXJXYzUwbHpTOUV0azVnT09TS1dBUFkw?=
 =?utf-8?B?T0xodVRrSnV5NXBVdERwZWRJcUNmSHVKczNyMkFIS1VPZGNMNjcwTVd4cU5C?=
 =?utf-8?B?dmErUnJic2krRE1hUi9FbStzek1QMmxPQmNOcGltT3FXRWpaak9UL3FRa0E3?=
 =?utf-8?B?Sk9qMDRVRENRUlh5WVNiRUNPS1pjcFFIVFJlQmlUUEFvZDI1K01acVdweDJ2?=
 =?utf-8?B?WTJhSy9KQWdacWtwaU5lZEk0eVhMZlhhZmV2THJYNTRveHlBVmdvNmxUbHdF?=
 =?utf-8?B?M1NsTS9tZWFQRU4wSzdBZys5NVdCVUxCbzZWUXRuU3M2RTNxelpkaXliQm00?=
 =?utf-8?B?N0piTCsyemsyV2IycjVzYTY4SWpxazRkSFNQQjhaWE5Ydmw2Q1hodC8vekNr?=
 =?utf-8?B?ZXdoQXZHTnFtbzhTelk2K0xkOEk3bEFGajRsQjdBeVhiZXgwL1dGSUJ4dDk1?=
 =?utf-8?B?QXBYT2NET2kxa0MvTm5NbDAzTXF4SmZXc2w4azVicmFtK0xtU3l3NlAzLzNh?=
 =?utf-8?B?aTVncFdKdmN5RElncjlFd0JHek1MMjYraFNHdGMzaWNYVDIvNlZNa0RwK2Rk?=
 =?utf-8?B?Q3pwclFFeHBKbEFrMFY0REwybXloc1FyR0xSNHJUSm8zQTZqb1hFUllnUURH?=
 =?utf-8?B?elhqSmZtanpwYStvVmlLWG5CMVVITmQ2VnhZQjdwbG91dlNLSDNSUmxxWTBY?=
 =?utf-8?B?WVBSTFg2OFk5VDRzM2tiOGpjQjhyVHBUL3BqNzRTc1g4Z1dYeE54d1lhWEV1?=
 =?utf-8?B?K0JuUTNWb1RzMXFqYWdPSjVNcGJWOFp3MUwvdWJuNVBUQ2lQdW1UMzNxbURm?=
 =?utf-8?B?Ry9hNjJqWUhhV2pmc2ZOcmMvSEY2WmpZOGYzZDFEYVhWdUFobTJvaGpNYzNK?=
 =?utf-8?B?MklFZWNSMVg1N0V3ejR1dDlId1EzVFNwakxZZE9kOTNNTzViYmtQS3hLamc4?=
 =?utf-8?B?djFIeHZDOU54QUZNbGJKd0V5N3pGR3BJeExLeVplblZwbE83VUFhU1RxVkJK?=
 =?utf-8?B?V0dVR0Z4M3hOa3FkMHBpTzNubzFuTzBEcUZIUVdLZ1JXV1BBeWI1dUYrTVhE?=
 =?utf-8?B?WWMxUTFqbzdhcTludCtmR0FpU3ZpTm13cWNFYnEzcEtURVp2UTZoVVplOGZC?=
 =?utf-8?B?Q3lSMzFBdVM0OW02WlJOaGJocCtZSkdlVit2SFRTN1JFbXBmUFNiMmw3S3Ju?=
 =?utf-8?B?dHRNcjM5RzdZOVNiK0lXYWRMWnArUFNocG1kbFdUSnI3S2ltMGRuWFlIUmNY?=
 =?utf-8?B?aExIUjNOZVF3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODg3bkp1ajhnMi8wYWYvV3ZQRk5zOE4wT2tCY252QmlvbkxBN1lWdTUybHpS?=
 =?utf-8?B?RXlXTkJEb0tRNHpkYU4zUlRYYWxtNFI5VWN5eXoxbTVjekhkTFhweEV3V2xR?=
 =?utf-8?B?WWhVZDRKMURENGR1dytjdmgvR0M4aGE4ZEpKZ3d0cWVNTWVKZVlmNWVPbXl0?=
 =?utf-8?B?SW12ak1ZMTZMdDlqM2pwR2xPbHRoR0lOeitCMmRMN3F2djgzY0haQWdFYXV1?=
 =?utf-8?B?emVlWnl1NEFhTzJCbmtoMERUZ2RXK1hsVklUSWNsZlBZTDdDa3psU0E2OGtM?=
 =?utf-8?B?RlQ0U3grNkRVNkR6elR4YThaVlYyWUhSZVBqSHVEb1cxSG9JeTFnd3dDcXdh?=
 =?utf-8?B?NklEWUxrUlljd05rSXZjd2UyUTZKMDVXb0RNai82QmdtY2swUmtDT1I3Qjl1?=
 =?utf-8?B?clB0azJHdUdaRXZPcU0weHRraittK3ZyYzF6Y1NQYndrbXJRV1NXcWVhNm55?=
 =?utf-8?B?dnlMYjkzbThzN1FodmwzaXNoYUlEUlQyZ2dFYVFGc1dTeUNhb0dkNHF1RDVl?=
 =?utf-8?B?N1Uwblc1OVcxekFWMHJaYmI2NHVqUkVKL09FNWo1RlMxSWRaeGhPWHNTUkNR?=
 =?utf-8?B?dldqbFh1RG82RzMrNG1WMTc0STA4L1Bvc2lQcXlFRTc5dzNKNFh1ZHNDeUw0?=
 =?utf-8?B?cDN5NnpXR2wwcmRjZ0RMOTNYZzV2S0o4NXg5bENTaTJCOHdLTXdYVEh2TDRY?=
 =?utf-8?B?d2lBdVBsNXlBUkgyTHVpTHA4OUR6K2c4UnJteVhaOUF3c0xtbk84ZUw1OEJs?=
 =?utf-8?B?dm8vclNsbUVSZm5DT01vcExzTEpQK05OWXc1T1NCOHUyR2RBRkRVK2ZTUkta?=
 =?utf-8?B?M2Erd3VWaGhsNTA2bFQ3MExsWlBoNlFrdHJQOVZxUDRMeWNEUWUrZ1pYZmFV?=
 =?utf-8?B?b1ZWRUYycXBQdUdsRnpOaUNMSGJ6eS9uaW9pOGZGcVplRm1xdWE1QnpwU24z?=
 =?utf-8?B?RXVtNXYyTDdnTU1xUGdqaVNvaVV4WmprS296L2NncWhVdGJlNFU3TzF0SVdV?=
 =?utf-8?B?cjRLNklLeEs2czZrMDhQQTJ4YU1lMGZZMUxMS0VybjBWajVoL3JMMm1UYk16?=
 =?utf-8?B?L2pXMHhSWS9RZTFiQjRFeG9laU9rN3JkSUpCa1NQM2I5WElRNTlmV1BnRkEv?=
 =?utf-8?B?RHZZcC9yV3d1U0dvbTJyUmI4VEUxNWxOSjNzTTZvNTBRUVRjdUFkRG00b1ow?=
 =?utf-8?B?ZUtUMm1Nb1NsZFAyanNocUhSZ08wR1ZTeTBwV0VEUVVSODAxWS9WcmRmdUdm?=
 =?utf-8?B?bWNEVnFId3R4K0t6ak9ObVZhNlp1U252dWdOaVBKN1dnZWYwY1RxRWs0Qnhm?=
 =?utf-8?B?d1ExUjZzVjVUUnNSY2MxY21RWGxZL3NJdWxPZVpkZHRueTl6bldvWDlwWWUy?=
 =?utf-8?B?TVB1ejFha09OSDhqOVlIWHJQOUVJOUhNTy90MXpCcFcxbDdkSEUzZlJqekhS?=
 =?utf-8?B?eTdsTmpRM252K2Q0cVRnQzNrN01VNFlmT0FSVVJ0Z0VzQWZ1ckdxZmlzekly?=
 =?utf-8?B?VVNTQUxHK3lOUGlhNzIxZElRREJIcE5STjZTdmFWWFdpN2QxZ09vV0ZVZDZU?=
 =?utf-8?B?b0tJNW5LbDVVWWFzSDIxWUh6K0t6NjdzKy95cCtnUUY0ZHRqbTluZG9PTDB0?=
 =?utf-8?B?cUNBUU9wTThWdFZmb1diTGZJTmJoZWJVN3paQnV6UVNxcDJweXlvNnU1Umtp?=
 =?utf-8?B?QkU3RG5iOVl4QkhGbm5TOEFydU5sRGx5c1htcEVVMXl3U3F0ZkY0NmJLZ1Rs?=
 =?utf-8?Q?jTCGOYngTUhR9oMfJg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3cd587-2ec9-4161-fee5-08dd605ba331
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 05:14:45.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13896

--------------BS5rU6CHC81qRWcNiKM5wWqK
Content-Type: multipart/mixed; boundary="------------Q520fdaJuWFclVh06T0Y1xsY";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Ping-Ke Shih <pkshih@realtek.com>, Felix Fietkau <nbd@nbd.name>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
 "howard-yh.hsu@mediatek.com" <howard-yh.hsu@mediatek.com>,
 "greearb@candelatech.com" <greearb@candelatech.com>,
 "chui-hao.chiu@mediatek.com" <chui-hao.chiu@mediatek.com>,
 "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
 "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>,
 "sujuan.chen@mediatek.com" <sujuan.chen@mediatek.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "bo.jiao@mediatek.com" <bo.jiao@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Cc: wiagn233@outlook.com
Message-ID: <ba987db2-e077-4569-9a3c-bfad3e2ae7f8@outlook.com>
Subject: Re: [PATCH v9 RESEND] wifi: mt76: mt7915: add wds support when wed is
 enabled
References: <TYCPR01MB84376C7074C566865654F05098D42@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <b6b52bfcdb614137ac63fddfdaf9cb97@realtek.com>
 <OSZPR01MB843481965BA47B030566DF2698D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
 <71ed8398-4619-4793-804d-77cad36e7402@nbd.name>
 <OSZPR01MB84345D44294ACA75A863ED6B98D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
 <349d0fbe197a40068377e889a2311cb2@realtek.com>
In-Reply-To: <349d0fbe197a40068377e889a2311cb2@realtek.com>

--------------Q520fdaJuWFclVh06T0Y1xsY
Content-Type: multipart/mixed; boundary="------------b8RvwkJvSHynBowNqRPSWhqJ"

--------------b8RvwkJvSHynBowNqRPSWhqJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCuWcqCAyMDI1LzMvMTEgODo0NywgUGluZy1LZSBTaGloIOWGmemBkzoNCj4gU2hlbmd5
dSBRdSA8d2lhZ24yMzNAb3V0bG9vay5jb20+IHdyb3RlOg0KPj4gSGVsbG8sDQo+Pg0KPj4g
SSBtb2RpZmllZCB0aGUgcGF0Y2ggYXMgeW91IHR3byBhZHZpY2VkLiBJZiB5b3UgdGhpbmsg
aXQncyBvaywgcGxlYXNlDQo+PiB0ZWxsIG1lIGFuZCBJJ2xsIHNlbmQgYSB2MTAgcGF0Y2gu
DQo+Pg0KPj4gTW9kaWZpZWQgcGF0Y2ggaXMgYXR0YWNoZWQgYmVsb3cuDQo+IA0KPiBTaW5j
ZSB5b3Ugd2FudCBwZW9wbGUgcmV2aWV3IHdob2xlIHBhdGNoLCB3aHkgbm90IGp1c3Qgc2Vu
ZGluZyB2MTA/DQpPSywgSSdsbCBzZW5kIHYxMCBhZnRlciBmaXhpbmcgdGhlIGlzc3VlIHlv
dSBtZW50aW9uZWQuDQoNCj4gDQo+Pg0KPj4gQmVzdCByZWdhcmRzLA0KPj4gU2hlbmd5dQ0K
Pj4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2LmggICAgIHwgMTUgKysrKysrDQo+PiAgICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTE1L21haW4uYyAgfCA1MyArKysrKysrKysrKysrKysrKy0tDQo+PiAgICAu
Li4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jICAgfCAxOCArKysr
Ky0tDQo+PiAgICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5o
ICAgfCAgMSArDQo+PiAgICBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3V0
aWwuYyAgICAgfCAzNyArKysrKysrKysrKy0tDQo+PiAgICBkcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L3V0aWwuaCAgICAgfCAgMiArLQ0KPj4gICAgNiBmaWxlcyBjaGFu
Z2VkLCAxMTUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCj4+IGluZGV4IDEzMjE0
OGY3YjEwNy4uYmQ5NDNiOGIyMGJjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQo+PiBAQCAtMjgsNiArMjgsOSBAQA0KPj4NCj4+
ICAgICNkZWZpbmUgTVQ3Nl9UT0tFTl9GUkVFX1RIUgk2NA0KPj4NCj4+ICsjZGVmaW5lIE1U
NzZfV0VEX1dEU19NSU4gICAgMjU2DQo+PiArI2RlZmluZSBNVDc2X1dFRF9XRFNfTUFYICAg
IDI3Mg0KPj4gKw0KPj4gICAgI2RlZmluZSBNVF9RRkxBR19XRURfUklORwlHRU5NQVNLKDEs
IDApDQo+PiAgICAjZGVmaW5lIE1UX1FGTEFHX1dFRF9UWVBFCUdFTk1BU0soNCwgMikNCj4+
ICAgICNkZWZpbmUgTVRfUUZMQUdfV0VECQlCSVQoNSkNCj4+IEBAIC03Myw2ICs3NiwxMiBA
QCBlbnVtIG10NzZfd2VkX3R5cGUgew0KPj4gICAgCU1UNzZfV0VEX1JST19RX0lORCwNCj4+
ICAgIH07DQo+Pg0KPj4gK2VudW0gbXQ3Nl93ZWRfc3RhdGUgew0KPj4gKwlNVDc2X1dFRF9E
RUZBVUxULA0KPj4gKwlNVDc2X1dFRF9BQ1RJVkUsDQo+PiArCU1UNzZfV0VEX1dEU19BQ1RJ
VkUsDQo+PiArfTsNCj4+ICsNCj4+ICAgIHN0cnVjdCBtdDc2X2J1c19vcHMgew0KPj4gICAg
CXUzMiAoKnJyKShzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgdTMyIG9mZnNldCk7DQo+PiAgICAJ
dm9pZCAoKndyKShzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgdTMyIG9mZnNldCwgdTMyIHZhbCk7
DQo+PiBAQCAtMTE2NSw2ICsxMTc0LDEyIEBAIHZvaWQgbXQ3Nl93ZWRfZG1hX3Jlc2V0KHN0
cnVjdCBtdDc2X2RldiAqZGV2KTsNCj4+ICAgIGludCBtdDc2X3dlZF9uZXRfc2V0dXBfdGMo
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQo+
PiAgICAJCQkgIHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYsIGVudW0gdGNfc2V0dXBfdHlw
ZSB0eXBlLA0KPj4gICAgCQkJICB2b2lkICp0eXBlX2RhdGEpOw0KPj4gKw0KPj4gK3N0YXRp
YyBpbmxpbmUgaW50IG10NzZfd2NpZF9hbGxvYyh1MzIgKm1hc2ssIGludCBzaXplKQ0KPj4g
K3sNCj4+ICsJcmV0dXJuIF9fbXQ3Nl93Y2lkX2FsbG9jKG1hc2ssIHNpemUsIE1UNzZfV0VE
X0RFRkFVTFQpOw0KPj4gK30NCj4+ICsNCj4+ICAgICNpZmRlZiBDT05GSUdfTkVUX01FRElB
VEVLX1NPQ19XRUQNCj4+ICAgIHUzMiBtdDc2X3dlZF9pbml0X3J4X2J1ZihzdHJ1Y3QgbXRr
X3dlZF9kZXZpY2UgKndlZCwgaW50IHNpemUpOw0KPj4gICAgaW50IG10NzZfd2VkX29mZmxv
YWRfZW5hYmxlKHN0cnVjdCBtdGtfd2VkX2RldmljZSAqd2VkKTsNCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCj4+
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jDQo+
PiBpbmRleCAzYWEzMWM1Y2VmYTYuLjA3YzJjZTUxOGQ5NyAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYw0KPj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jDQo+
PiBAQCAtNzQ1LDggKzc0NSwxNSBAQCBpbnQgbXQ3OTE1X21hY19zdGFfYWRkKHN0cnVjdCBt
dDc2X2RldiAqbWRldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCj4+ICAgIAlzdHJ1
Y3QgbXQ3OTE1X3ZpZiAqbXZpZiA9IChzdHJ1Y3QgbXQ3OTE1X3ZpZiAqKXZpZi0+ZHJ2X3By
aXY7DQo+PiAgICAJYm9vbCBleHRfcGh5ID0gbXZpZi0+cGh5ICE9ICZkZXYtPnBoeTsNCj4+
ICAgIAlpbnQgaWR4Ow0KPj4gKwl1OCBmbGFncyA9IE1UNzZfV0VEX0RFRkFVTFQ7DQo+IA0K
PiBJbiByZXZlcnNlIFgnbWFzIHRyZWUgb3JkZXIuDQpUaGFua3MsIHdpbGwgZml4Lg0KDQo+
IA0KPj4NCj4+IC0JaWR4ID0gbXQ3Nl93Y2lkX2FsbG9jKGRldi0+bXQ3Ni53Y2lkX21hc2ss
IE1UNzkxNV9XVEJMX1NUQSk7DQo+PiArCWlmIChtdGtfd2VkX2RldmljZV9hY3RpdmUoJmRl
di0+bXQ3Ni5tbWlvLndlZCkgJiYNCj4+ICsJICAgICFpc19tdDc5MTUoJmRldi0+bXQ3Nikp
IHsNCj4+ICsJCWZsYWdzID0gdGVzdF9iaXQoTVRfV0NJRF9GTEFHXzRBRERSLCAmbXN0YS0+
d2NpZC5mbGFncykgPw0KPj4gKwkJICAgICAgIE1UNzZfV0VEX1dEU19BQ1RJVkUgOiBNVDc2
X1dFRF9BQ1RJVkU7DQo+PiArCX0NCj4+ICsNCj4+ICsJaWR4ID0gX19tdDc2X3djaWRfYWxs
b2MobWRldi0+d2NpZF9tYXNrLCBNVDc5MTVfV1RCTF9TVEEsIGZsYWdzKTsNCj4+ICAgIAlp
ZiAoaWR4IDwgMCkNCj4+ICAgIAkJcmV0dXJuIC1FTk9TUEM7DQo+Pg0KPiANCj4gWy4uLl0N
Cj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbWN1LmMNCj4+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbWN1LmMNCj4+IGluZGV4IDlkNzkwZjIzNGU4Mi4uMTkxZjk2NmMzZjMyIDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWN1LmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21jdS5jDQo+PiBAQCAtMjM4NSwxMCArMjM4NSwyMCBAQCBpbnQgbXQ3OTE1X21j
dV9pbml0X2Zpcm13YXJlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYpDQo+Pg0KPj4gICAgCW10
NzZfY29ubmFjX21jdV9kZWxfd3RibF9hbGwoJmRldi0+bXQ3Nik7DQo+Pg0KPj4gLQlpZiAo
KG10a193ZWRfZGV2aWNlX2FjdGl2ZSgmZGV2LT5tdDc2Lm1taW8ud2VkKSAmJg0KPj4gLQkg
ICAgIGlzX210NzkxNSgmZGV2LT5tdDc2KSkgfHwNCj4+IC0JICAgICFtdGtfd2VkX2dldF9y
eF9jYXBhKCZkZXYtPm10NzYubW1pby53ZWQpKQ0KPj4gLQkJbXQ3OTE1X21jdV93YV9jbWQo
ZGV2LCBNQ1VfV0FfUEFSQU1fQ01EKENBUEFCSUxJVFkpLCAwLCAwLCAwKTsNCj4+ICsjaWYg
SVNfRU5BQkxFRChDT05GSUdfTkVUX01FRElBVEVLX1NPQ19XRUQpDQo+IA0KPiBJbiBNVDc2
LCB0aGVyZSBhcmUgdHdvIHN0eWxlczoNCj4gICAgI2lmIElTX0VOQUJMRUQoQ09ORklHX05F
VF9NRURJQVRFS19TT0NfV0VEKQ0KPiAgICAjaWZkZWYgQ09ORklHX05FVF9NRURJQVRFS19T
T0NfV0VEDQo+IA0KPiBJIHRoaW5rIGJvdGggYXJlIGNvcnJlY3QuIEp1c3Qgd29uZGVyIHdo
eSBub3QgbWFraW5nIHRoZW0gY29uc2lzdGVudC4NClNlZW1zIHlvdSBkaWRuJ3QgcmVjZWl2
ZSBGZWxpeCdzIGVtYWlsLCBjaGVjayB0aGlzOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtd2lyZWxlc3MvNzFlZDgzOTgtNDYxOS00NzkzLTgwNGQtNzdjYWQzNmU3NDAyQG5i
ZC5uYW1lLw0KDQo+IA0KPj4gKwlpZiAobXRrX3dlZF9kZXZpY2VfYWN0aXZlKCZkZXYtPm10
NzYubW1pby53ZWQpKSB7DQo+PiArCQlpZiAoaXNfbXQ3OTE1KCZkZXYtPm10NzYpIHx8DQo+
PiArCQkgICAgIW10a193ZWRfZ2V0X3J4X2NhcGEoJmRldi0+bXQ3Ni5tbWlvLndlZCkpDQo+
PiArCQkJcmV0ID0gbXQ3OTE1X21jdV93YV9jbWQoZGV2LCBNQ1VfV0FfUEFSQU1fQ01EKENB
UEFCSUxJVFkpLA0KPj4gKwkJCQkJCTAsIDAsIDApOw0KPj4gKwkJZWxzZQ0KPj4gKwkJCXJl
dCA9IG10NzkxNV9tY3Vfd2FfY21kKGRldiwgTUNVX1dBX1BBUkFNX0NNRChTRVQpLA0KPj4g
KwkJCQkJCU1DVV9XQV9QQVJBTV9XRURfVkVSU0lPTiwNCj4+ICsJCQkJCQlkZXYtPm10NzYu
bW1pby53ZWQucmV2X2lkLCAwKTsNCj4+ICsJCWlmIChyZXQpDQo+PiArCQkJcmV0dXJuIHJl
dDsNCj4+ICsJfQ0KPj4gKyNlbmRpZg0KPj4NCj4+ICAgIAlyZXQgPSBtdDc5MTVfbWN1X3Nl
dF9td2RzKGRldiwgMSk7DQo+PiAgICAJaWYgKHJldCkNCj4gDQo+IA0KPiANCg0K
--------------b8RvwkJvSHynBowNqRPSWhqJ
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------b8RvwkJvSHynBowNqRPSWhqJ--

--------------Q520fdaJuWFclVh06T0Y1xsY--

--------------BS5rU6CHC81qRWcNiKM5wWqK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmfPxsEFAwAAAAAACgkQX75KBAfJsRnt
KQ/7BAsgyfwG2hQcaZ111t+AWpoXnLOo9KQ+GOh6DV4xoNLnjWCwrQTVLi6pcxZ5jYScfPYr1+s6
/SZV/7NgRqZJp9XzpxRKZewPGvU9nyVyUiLKgEwLRwydOpYHnRaZFhpkW8SR/+MkWaZPf8bnHqtM
IqWo8eQYF6LzMJ61m9FstGdgh8/EDa2Q06DHsntKYTwjOM0f2JLxro6Dn/y1A2XsWuJwjCe52QTV
l1BJsiZabLXclERdhPvqtgYOwclj40SG8Q/gEglIagfvt/p9j6F78Zuo2ZQfmgV1numHoyC0WHls
7RHYjtgY7xhX4/wK4B4tyEDK40YCxaR0WujVZaNw7O0RfXStXz8UaXIYfCz+nwckYQffoJuBQFUg
zQgmvJ3NYSyU0OvXj92cOziTNFBHZ4QQnSe+aYt9X4ydDXsCjp3C3q1wSSsPNsNtCah38/eZ1VJJ
E/KRoPjfKpZJSxeOD6eLb3FY+drnLuFILx1sdWfpCnsVkcv53FTX5zk+YrddKyegzbuJFbsUbfHn
wO2OYy98jr5C0ahlRMP/6VrnumPER4umCAM40mWAH8Gbpoy8pR3en70rH9SHmMqCyzfQcSpbYXhi
J8uca7DR8dFfbUwghGFRJxmnnscstCW9yb5lb4ZvLX8ZUzQw8KA6wdZUy1n3qOz8Wb7K4B6mFgvL
OWg=
=UcoD
-----END PGP SIGNATURE-----

--------------BS5rU6CHC81qRWcNiKM5wWqK--

