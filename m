Return-Path: <linux-wireless+bounces-12000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4E595F942
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 20:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701681C21C28
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A07406F;
	Mon, 26 Aug 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="mp7NYffN";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="dq2on7Sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09901192B91;
	Mon, 26 Aug 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698426; cv=fail; b=Lrabp1Mlz1TeaD2q9ZSa4JHz5GRmty1xXLt8da4teiWwGSiWaBFINzd2emps1cqj5w1EXH7utVyqdvf0UxpA7YLU3V78jnTR3X9Guj6XoJmHPYAs8gv7Uol9r1aFUt2qJ2+SQiKilUbHflUZIdraIXnFtdW0qRoLjG/zm897hf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698426; c=relaxed/simple;
	bh=Bqb2nutxvSNGhYBPgXXCQWo2S2pwUF13ap9PfaaFMNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZkuVGVYWPf+gt1fXtIH3F5dMugd9J7lrzRtnPwycp62lTRa76gXe7GkwZ7PgKHIN+quonkZOSF1fMBnTbsdTD1QvZOX/g5sz6ybzEYmTfkBsMB55cpEZGEVeekdUvKE+6qCKgCfREIpzMkDn8w+GqeJ3f21CpJLLS1F1/3M4hLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=mp7NYffN; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=dq2on7Sa; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QAVnTI024325;
	Mon, 26 Aug 2024 13:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=mN0uAeX9STXQZcBK95kec7rrBjb//oEkWG4QVMxiXfc=; b=mp7NYffN/MxL
	xb1pZ7Hi99ia00ckfpaolCEoQy3tC8IMYgbNfzYuRIuJLPK4NpqwHR2vTMFeup2w
	ReEaqDPzIvl5DJloPw9eUWaKsgnLccIYGo/X4RbBdBSYnt4UiMgW43Iq7HWEkqRv
	ww2dX/EuhfRMdO3Z5NXSt4572YIPbeIe12H38qPJg3ReCDlGhWB8EMh1Hgq1uzJI
	i+L/uirqdWN7nYp+UkxSjlVdAvpSDh/Ls4xlyGczGkyTKvq94PCnsJA5ITn+Q/wj
	K0hcovY5wyYm8Y/SowD4ed3t1Owuqq7ypXS/qbbv7nDYmp3/cBttuayGPRFBsBNO
	gmWImegjSw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 417bu9uqvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 13:53:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbbo2NYb5alh3aQbW7FRJQZVhu7JpsaUbTcOC9rhBaRZlcOuU1tlfc4ly3H/c4GYjXWB2i2MXA3pC0gZ5/e0IIKChzPXlbnnOFG28m7UKUtbd39LltiCJhaC9TvTRX9p+BRwcSh/96tVRvxLoud0WnF+QlkNl6lc6MiiwTQVAUO1sK3rMBMAfRrBG4zTpdXXoJ/g2jtxsZW3HU8uZncR+ZBCotagfD6SO94eaTURTxkcGeb54OZ11M6EGrl/mJxXrxOQKszAm1iWl/IMlLr8ueEQfwWWlOmSaNOl4udDgeETI1PGRl1Q3IsBsilKnFdUVKJ7kW94Jp6eZhLBHy/0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN0uAeX9STXQZcBK95kec7rrBjb//oEkWG4QVMxiXfc=;
 b=R/hqtEAKfauF6ebGwz4QSdg6cMIq4fuB2OFGPjYE22Hx1Map0YizcJTwHU6k+5XbhL+qtd5m/kWCFg8WLZPYd6GqsFFtsISlm++4EkcWMj2kriRglwEDB65XsJIdKmmebz1BgxO5k/EfGLFR5cuc7CrrOyiMhjbw4AQVtfYFJ4n56HZrexjrw64ucGtd1DWZ+RizubpK5mceTvJSKMWFcItEbqAsULtbyeJbDBddogeoAIDpEK+xRWBK9tEwATp0tzMnKW62Kb2A8dIBB46PFofEJuLT1J5jZxVnnJs+NFmViEf2G+maL/ywX1iTbuFIZ1F0537ys4dvFmveKMEJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN0uAeX9STXQZcBK95kec7rrBjb//oEkWG4QVMxiXfc=;
 b=dq2on7Sa5xQrSKHwQnd6Y6E7sIFoOvaR1XieLtFaCA2MsUueaX0PfAuRrURb7xge1wm3G/i/UNXWJSX95o4jBO8H/YMrcLPQq/OUx5M6sryINFu14XFedGGgU2wjLYVSlY+LYL+dPp6dvJgAW19hFTe8/+AE6Eydzm5jP+2JFTw=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 18:53:34 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 18:53:33 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
        "dmantipov@yandex.ru" <dmantipov@yandex.ru>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: wfx: repair open network AP mode
Date: Mon, 26 Aug 2024 20:53:29 +0200
Message-ID: <4991052.31r3eYUQgx@nb0018864>
Organization: Silicon Labs
In-Reply-To: <6fcd665d7c11dcde939ccf82954959298371dffb.camel@siemens.com>
References:
 <20240823131521.3309073-1-alexander.sverdlin@siemens.com>
 <13597832.uLZWGnKmhe@nb0018864>
 <6fcd665d7c11dcde939ccf82954959298371dffb.camel@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR1P264CA0011.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::16) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|CH0PR11MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 2760e90c-2c0c-4483-9a39-08dcc60062ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|52116014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?UQIYfXi5p7Yj+a7WE/c5f9qdv6XYuYYwmNerYKK4eWTQVZFHEwrL/VLUQZ?=
 =?iso-8859-1?Q?551yLFGetMYpcAxASxX2BD1YLiuNo8IKAYc0NT/4jtiAw+mLSn4Szl6VwO?=
 =?iso-8859-1?Q?BmfU1nQo7YAkvBgo85jpfMqs44X+6HXCMrMH3zmU+QptwoAXXm4creFo5p?=
 =?iso-8859-1?Q?73zNPpvZXxjDM16ZzvdAuNLqS6ojnye4AyOmV2aBZfCIZ+mZYQrrew2i/h?=
 =?iso-8859-1?Q?UpUHnBCyrOgLvk4pikA9hy8nMBxMjfO7iixmfdWcYKbLfwztGewl9DVA5N?=
 =?iso-8859-1?Q?2/E2eX8uPT+Uel6sBU2J3p2d7OAqwmwcFI9sOXmjZZ2OizjQvdb/OKQ5Vs?=
 =?iso-8859-1?Q?44h8qCXyr6JpK1g+thtez1vHzi6iBmk2PvfvhJNb1j41XSreYQvT0bAfDU?=
 =?iso-8859-1?Q?A/986r06Buqt1Oi8j4BRKqHVoNqGudGDHtPVJkGUxxBMwQaoe8/z3+SKfE?=
 =?iso-8859-1?Q?o+BnEMffjD6OgkZNmLGXYSqVoUML4tcu2Qy9fJAAmOWw8zeWNCTfDjGtX2?=
 =?iso-8859-1?Q?qyJY5su9yoeov+E59NXDVrsdgf7leA05XIdvvjlaDRkfWenQWdqUtX+Df2?=
 =?iso-8859-1?Q?N5kbOmhlVInSJk+LdbbmLewZdrTd27DSiOSoTtCYUqdxtvzlGJwRVNzEJ0?=
 =?iso-8859-1?Q?sx7VwP5HEZPPVnc33geNw7z4zD4tHs1z+nsC1pCjKC67ZkR22lo/CEU/hA?=
 =?iso-8859-1?Q?VXl8awBimw3wBk6xPXBjinmGcWw0fVd6Ngzqcs5dTGXhvqIwmwcJVhk+qo?=
 =?iso-8859-1?Q?E0EbY45PBPRm8iW9FFftJ8PWe0LU9DC9zwfIFiPCVBfIV5yr0noU2S3Zsd?=
 =?iso-8859-1?Q?zUDDBBChTJAAXxKAtAKra9XZwL/SsMdCjQGaM3MRit/rK3iR3YcfA81g7x?=
 =?iso-8859-1?Q?95C4195jbgpYQmrpvzzgyPcyPOyqGrfSLwn7UHTyGSn3uf/DkvPrM8bBFg?=
 =?iso-8859-1?Q?D+pJygrU0auixSXQj6TNR7mf3cWDnCtS7yjDm23yg9yAAaMm5r1NjJfu1q?=
 =?iso-8859-1?Q?mVaQ1OdByXBRb3qlLyVhRNnOLt8q5SnPSobqS/1AAJ82w+MIXF7OtjEm3E?=
 =?iso-8859-1?Q?yt+UlB1Zynl+svYALKfnTK5UcvBYLucdy6Qniz5PT2GlHtsxPnAFc1O5B8?=
 =?iso-8859-1?Q?iBqY/6dz089mKsNRkK4eGe3HPG/DNm7/tuCUkAOegy9T/DdFOMRG80d9tt?=
 =?iso-8859-1?Q?+/3zsWeirzxokTdNb201WoQIFA7yXDAuxXYcKn4IJ5ClXPsKG/sIBw0rv1?=
 =?iso-8859-1?Q?yERc2lysPdj8QE1y+bC/iLa+DZREQYl5By9wMvkvuUZQMzYcT3+OPruSq9?=
 =?iso-8859-1?Q?+FzMSLFIX8Gk8cl6/80F8KtbDLMxZ2iDAj1/ldBcEdr6QDi56eUFYLlpjj?=
 =?iso-8859-1?Q?/ZH4EriTHPaqfxTe6F2Chf3WNukGngRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?RTWhJ+6nSLBKVPwjsEwVhrnVuLwASDqI8jwPWo2yNk6zp7Q44IMBoPjzdQ?=
 =?iso-8859-1?Q?N5D5pZHKUb6KJerUVapdBx2QebQkJ3CXHFO3mW1rA8LAWfEJ9H05CQa8bT?=
 =?iso-8859-1?Q?MQxrb/j6Y6e3z59GkdgK8myo6oCnEu95kf13iqdvQuDKFogSmt/Um5aSm8?=
 =?iso-8859-1?Q?9dr+oOT9vRP576w0OCahzimMrvJkp5zEyUYCpOQtMgiY+9ba0NJhLchZhI?=
 =?iso-8859-1?Q?iU0/LT/vx4US8Qu/SuNCVqjcLouAfDVN24FepZLA+6J/4Xt/Qs9GfSn+KO?=
 =?iso-8859-1?Q?ki4chXWrM+gaxAAoZBpwqPz/WNNLGYSh3I97ympavgZ2iUuSji2g/PWiKW?=
 =?iso-8859-1?Q?WUP2oLoJ6CFt/tbqxTEbk/Q+NQ6gowdUykC4iert/4bVv6uHQmeK3z/I/o?=
 =?iso-8859-1?Q?7hQanQ8OJn6VmaQ9WNSfy1hWTcCOlzF+mbiRSt03zV9KrWaN2rbj1y80x8?=
 =?iso-8859-1?Q?6oL8spbdqax49FnBDAfAEzxOQKtvTrsWELdtOwEKK2i5MF0wo+gBGkp1/6?=
 =?iso-8859-1?Q?1fBHkISr8U6Ode+2GLGuM1nVEDmYFHQ92kyzdsvJRh/374sjpqI0SbhO2W?=
 =?iso-8859-1?Q?WlRlocSAw0ab0MTjt7qw/7eJvq6n/Mv9LnhFjbPErggs6k/gqAsKIHy3+M?=
 =?iso-8859-1?Q?dFLReNdACDQkFOJwWeVnQINKnha7cD3gO/r6/wKdv9GVv399KPsTwDW9d8?=
 =?iso-8859-1?Q?CnWGh3iw6aOkmQJDtX1tcRjlxZyGKdE/jSiAG+BuMVT3S411M7NgkJDpI2?=
 =?iso-8859-1?Q?rjKPD5HxFvpLLhzMDv/VWbKbNenIJDTz8c/Tr4oYjriAv34vWdLAmlVg7G?=
 =?iso-8859-1?Q?Q5KmqxAJwzv1fz+otvUlVzl9s2rnFqz32hpIwID1Glg0J1u4Yow273h8o/?=
 =?iso-8859-1?Q?9Xw6TlpCkr9ad9DYI1idv73tfq4YQtYQSCZWlQBjiUHFqqWgH5sp/rCNOQ?=
 =?iso-8859-1?Q?tNGxvJCFmm6zYOTjbWZgB0vtCwXIW3ezCW7UzbBrw6jvKSORJeS7Pa2HGM?=
 =?iso-8859-1?Q?J/ykQWI00PknpZlqGpLy6AeZhGaYfiX5BVaY6ADnf7KkzJ+yRvXxGarOQA?=
 =?iso-8859-1?Q?hhSrd4NjPGg63pt6KyvSUoG4Xpgqtwg26BqO4xeDZw9agP5Ygqw3WX342D?=
 =?iso-8859-1?Q?WT8KoSVxUmaG53b1hen47WPz16nEX4IIgY+CVibl6nRCWISwY0zMqCatYq?=
 =?iso-8859-1?Q?3UbrnQTC1RZx6zVxl+/btQWSbt4TLjT/DZs1WLXq3GiQv4ABoUCLcvWHyr?=
 =?iso-8859-1?Q?XiMioCXujAI3inz/oUbWAxPyJcH8X232QsMcqPKbc0c7vH85jR9n+skvWa?=
 =?iso-8859-1?Q?O1VoDAZc1WJJS/0Tpt7wd1kElqLQhxQUUlUyaOsTrbvUfKjdw66o3j2sE0?=
 =?iso-8859-1?Q?2fyvIhRq11BjrL4um05mkEEeqUnZixxhGOw5Yrj/rhfi3d6ZJa6PKK1uAf?=
 =?iso-8859-1?Q?3tCS+4UP1WIPDpx48eoTV9GzlSdiE7CiXgn+tfjA7jLV4AZnt5+2hrrHGy?=
 =?iso-8859-1?Q?OwG3DwtGI0DmZvUdVETHpu8LPmvrKTIELEerUbwLsNgE6xzx7ZA66Oev7+?=
 =?iso-8859-1?Q?rf4luG53yMaI+FxH0Ro9N3VU1LscXqsFDAAIQJBLrvl0w2JXWEv3ATH2Ud?=
 =?iso-8859-1?Q?z5AAwiWVRMeHGwwGTfK8YI0GIr9UGvuqKqUji5Lmj+oPyBc6oFp37lpu43?=
 =?iso-8859-1?Q?/laHxLkGH59GIJmY2Dsb3cw3GUPDm29qEo30EPCq?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2760e90c-2c0c-4483-9a39-08dcc60062ab
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:53:33.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2CQMR+bl7MZhpuUEJ/uTsy4Rtc5A9ibzUScizP2Fm/rAQ5Fu9tEg1MffCXNA2xoVdnERLbc8zGP4oH7d+GCtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-Proofpoint-ORIG-GUID: PzFCeQr1rAhQvyJzLJtdK7w1UF5H5MZt
X-Proofpoint-GUID: PzFCeQr1rAhQvyJzLJtdK7w1UF5H5MZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_14,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408260144

On Monday 26 August 2024 17:42:28 CEST Sverdlin, Alexander wrote:
[...]
> On Mon, 2024-08-26 at 17:12 +0200, J=E9r=F4me Pouiller wrote:
> > On Friday 23 August 2024 15:15:20 CEST A. Sverdlin wrote:
> > >
> > > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

[...]

> >
> > wfx_hif_set_mfp() is no more called when open network is started. Norma=
lly,
> > wfx_hif_reset() is sufficient to avoid any side effect with previous ca=
lls
> > to wfx_hif_set_mfp().
> >
> > However, if you don't mind, I would prefer to call wfx_hif_set_mfp() in=
 all
> > cases.
>=20
> I'm a little bit confused by this comment... You write "wfx_hif_set_mfp()=
 is no more called",
> but I struggle to find when it was last time called (for open networks).
> Not when you visited this part of the code in commit b8cfb7c819dd
> ("wifi: wfx: fix memory leak when starting AP"), not in fe0a7776d4d1
> ("wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()").
> And even not before the latter change (say, fe0a7776d4d1^):
>=20
> static void wfx_set_mfp_ap(struct wfx_vif *wvif)
> {
>         struct ieee80211_vif *vif =3D wvif_to_vif(wvif);
>         struct sk_buff *skb =3D ieee80211_beacon_get(wvif->wdev->hw, vif,=
 0);
>         const int ieoffset =3D offsetof(struct ieee80211_mgmt, u.beacon.v=
ariable);
>         const u16 *ptr =3D (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->dat=
a + ieoffset,
>                                                  skb->len - ieoffset);
>         const int pairwise_cipher_suite_count_offset =3D 8 / sizeof(u16);
>         const int pairwise_cipher_suite_size =3D 4 / sizeof(u16);
>         const int akm_suite_size =3D 4 / sizeof(u16);
>=20
>         if (ptr) {
>                 ptr +=3D pairwise_cipher_suite_count_offset;
>                 if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
>                         return;
>                 ptr +=3D 1 + pairwise_cipher_suite_size * *ptr;
>                 if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
>                         return;
>                 ptr +=3D 1 + akm_suite_size * *ptr;
>                 if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
>                         return;
>                 wfx_hif_set_mfp(wvif, *ptr & BIT(7), *ptr & BIT(6));
>         }
> }
>=20
> What do I miss?

Indeed, you're right. This was the original behavior. So:

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>


--=20
J=E9r=F4me Pouiller



