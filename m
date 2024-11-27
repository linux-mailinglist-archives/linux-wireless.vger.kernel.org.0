Return-Path: <linux-wireless+bounces-15750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBE29DA4A9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 10:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17F71640A3
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1E192593;
	Wed, 27 Nov 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="fS3SxDAa";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="OReEMvge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6E1891B2;
	Wed, 27 Nov 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699120; cv=fail; b=QLqMJBzYN0PfBU3Myv7swSL1bAuneRXBQS/S4FREFktlEE9Fe7OxCGVtlj53EbVg9WDaRFO6jX97s+SNLDe4F2+2AADMncAN9+td2nI1DJaTrbB3GP2AffBez+D8zwPJMHyPkvfOx9XlzuvJHtGz7GGeI9tWb9gIiU3qN02AVvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699120; c=relaxed/simple;
	bh=Gz+HrZPFZIGMMAPpxtgvibILTKjm15U5f1D1Zs/VtzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EN743Tp1bkFK3LwI84dj7F2nsYWvwk7KGdkNxOQMrb3+A8Czf4w2Ibho1wu0pCUtk8JG6yucERAyI2bzzF+4NL3yKp9uiqTkCgHdVGxANLn0VQx0lno5dRgJiRvKzmY/pLoAJUN/jxoky9YXIrqbNU51dhHOhkximhfYGN6/PQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=fS3SxDAa; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=OReEMvge; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQJA04R032595;
	Wed, 27 Nov 2024 03:18:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=4D6f/wQvYCQbKNamuCN0h8eOsPM8CUcyY0pChPZ+AS8=; b=fS3SxDAaHJxB
	uvvaLdxhHLLRjPSP3Vx6Ym57u8e77sKi2TaiKvqDRkXLXN9whko+iiOMiQaEXaGl
	TTquiIixY79mhUVlFOozeqTPIRoNUnYBss7Zfz3yXzNAJG4Fz6VXzi542XJOVtiY
	pYzr0oVx11y2kKUs215XEl4NaU0QtPgHRbTd4F4AxpzGu7fgIXEwxkbAc+wO4VQV
	YGaYf25UK1L64Xl5EGL2NIGFWRQTnTUzhMyCiUDDg3nbWrV+1EkPiExP4Qp6R186
	us0xoYSycNE/ZXpIOGp2XDl6fuaW+q/d5Byi7KmIQzE13FS0AxYeFur33fqshsEw
	b+U60LSKpg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4339ed8m5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 03:18:32 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK16lo1ri7ZKGcbtaYH+iQUU409SGml9dGL+MlZzUglM9AM+2XZgRHvt50zKKBudt1/p67Q1F727R8wBGmj0g3IRy+X1pETIvgLJXDbz2GS/Oi2RjNHRDKufk2mU/YMo6dZoParikcpEafy0Zrn9tDuPW58TrC1C/j2yh5cn9zCgVxod0ZwsA3luH3GBbQq+bbcH7Jfnw4tU+0Q5BFQjvAhAwRUeNcYeKmkgK5FNbVvxnGN3UzBmRt7q8rT1qcJZ9uVhKxY9rBO0gki+dHXWIChUk6UOSF7kXgI4fWf5YhBLjL3syPsFAW2aWl1oIsP3b6pye9Hfa/xc0HbXJWtW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D6f/wQvYCQbKNamuCN0h8eOsPM8CUcyY0pChPZ+AS8=;
 b=nvCW5rn7HhGdbTryBORVymUDyeydGya/riAuQnqZM23Wil2Ffe9CKrYpkjcmoQYf7706pRXZ6wGMkovPuWFTgSPxFt96qTKurAlpNQjFXTaywIh1ELIm3524qIHcS0X2U4c0WHnq1dz5ConBW+44ViO5m72i+7Mscplqh4skl5TCZ0K4sv5CEujU9/Fs/bAgrdOKbP4KxR2+UTE1/898G9CEgz9FmDnPM0jkBhHIE1mWER5FL32Xhl0EDTKq+RQk0fm5UrTPfs1pQYugy6wtHONf5n6PUYA9G7zB+fkoUtDl7kK0kEDCUr3rhqq2QTt5qrxACYVpjPb9cFgDljXw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D6f/wQvYCQbKNamuCN0h8eOsPM8CUcyY0pChPZ+AS8=;
 b=OReEMvgeqaxp82+gstzly+f29/Zn9cgdKtnQSzGLvbsRZHkC5tLGWURlqnK/Hy5WZY6OfHgOkqvG36Ru9fHjJRr+L7wHYnTVgxB9tez1KDomcSQiHmRqKlBJDndlgIWUlI+XNM+9nJxqdTxQwhyA04B/iI4QdaECSgTUbQe8bIw=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by BL1PR11MB5285.namprd11.prod.outlook.com (2603:10b6:208:309::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 09:18:29 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 09:18:29 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] wifi: wfx: allow to send frames during ROC
Date: Wed, 27 Nov 2024 10:18:26 +0100
Message-ID: <2721026.q0ZmV6gNhb@nb0018864>
Organization: Silicon Labs
In-Reply-To: <45b7f72ee9b4b77bd05a63a4cae81481aea99157.camel@siemens.com>
References:
 <20231004172843.195332-1-jerome.pouiller@silabs.com>
 <1769588.QkHrqEjB74@nb0018864>
 <45b7f72ee9b4b77bd05a63a4cae81481aea99157.camel@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PA7P264CA0005.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::12) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|BL1PR11MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd17d7c-4f0f-47df-a0f6-08dd0ec474e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ct4QktfUrJUr087pf4oAPc9ICcAmfhAsI1b4FR3uwdeY2aoTc6XZPtE1JZ?=
 =?iso-8859-1?Q?e/2NKU4CpRztDOCKf9dTevL3iPskj1iJuqbKTPd1hY8nna5YWvTZUh9t3+?=
 =?iso-8859-1?Q?FzVhOzbBMJi1+58ife0NEo4RwuDkl/4lOJ1XxEs8R5q2lzHFnM+rEbJtMz?=
 =?iso-8859-1?Q?zrXHFKKwgPAgzEgqBSYsee3k4gvQ0zVA0yzYUrq8+whlzDePOi5TRgeFmq?=
 =?iso-8859-1?Q?2VzMlMUBkz7tM37flERveLPksO7XUCs4NZNZQeLdTdUAVpEruwRFOUnQ+9?=
 =?iso-8859-1?Q?OtlHTGdSRSw+R48qRoU9nhXLRsP44nvu9DJHBwLzsl4xK4HktQq/aHgBq/?=
 =?iso-8859-1?Q?F5Uo8o5gQ9obIGE2PKN3bbZPKl1LrQKb0s26sM5vBN7mxN5GJhhnVRhEKA?=
 =?iso-8859-1?Q?b0vMNRTWun1K++z21vaizFfHZACezvYuWDhcla16BMlB7IZ+g/ZpqArkLM?=
 =?iso-8859-1?Q?QAqrV0d1g87jNwAH0y8NL95VDNwnsQo9Ql3V+SSMyqoWKPeXh0qh+XNIcm?=
 =?iso-8859-1?Q?+xtQV4v/HN6dXoZFBFA+QZXiMornGoy9jTbMYY0j/M3F3tHvjELL3hwtDt?=
 =?iso-8859-1?Q?/aAvXzhOXe/HHUgCsnIylJZ7107yuhvJ22/0nXsstLzVR9OV9ZgkbTxwYS?=
 =?iso-8859-1?Q?5fW8SKeUsMhtgShbCRbqi3lnNpxYdmhQwApparP3LadV2to19j4H4qxAwV?=
 =?iso-8859-1?Q?Dng60zMBdC94kLD29OclkwMtW2nn2U9+eJVQUp5bcVQ2j7DdPjPlexUqWV?=
 =?iso-8859-1?Q?mcZhbUEh+mpIkgFIyVigGlIss3qZMsnQ8JU7jR/HxWopWmqzD7rWurwdD4?=
 =?iso-8859-1?Q?WarROI7RevrjOkR1D80DWCqotlvQ1C20ECucVDY+UnGgn5DctK0G+S/M9t?=
 =?iso-8859-1?Q?OZbWP/f/3ypwdzGj2pciItJ3Fj7+JbgsJEdjAqRNPMi1t0ZOecOJGpjeMF?=
 =?iso-8859-1?Q?wV0MuemGF3AdQNTjvRQMtR/2iXJWf0OxkszXIFGLzZj3xNvu6SsknoL8vh?=
 =?iso-8859-1?Q?MaFWubRujLbDlmdjzNiDZNRnBy4uKZrqR1trUHSF9Q1pdTJgGMUtWzGEdR?=
 =?iso-8859-1?Q?+g6FGr9I1odmfeZZ2iJm/uGBhcS3UiocUVUnwx7oxE/PcScWPk/ZNCyqlv?=
 =?iso-8859-1?Q?Bgb+mwc33qHQcuY1LjRiQFb8zET2DpjWgV6L1mgO5h1MW9grIE4OYtJ7Ss?=
 =?iso-8859-1?Q?YXaQwAD+ZiXeDr/T7iXh8OPY71GuSUChjm1mY1a7YNcYZYCbjsrGx0E4GZ?=
 =?iso-8859-1?Q?YKaQtlg91MNjEf+L7rRjlQ0an8gPLJZ20pTlKqDMCIkIqwSUZjcL2kjL/0?=
 =?iso-8859-1?Q?1R7ybBMqt5Hx60Wjw8m8PJzoLt5ClcW8OqyCNrV78hQMz84UnG9tUDj1FE?=
 =?iso-8859-1?Q?+cCvwsyQvqIcbRKPH6AMjngorI5uDXsMYFLm8fiOYZmv2fIu2QEO59T3UA?=
 =?iso-8859-1?Q?jMO1n3X9dgEpXBQPCJgPl8HnWIs7RmkUQTupnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?lyyViXB9OJwoJKw4YF7SEyYBmUb130xDZ96v/bHAgB1OcvkuBhLCm+uU/E?=
 =?iso-8859-1?Q?P+oj9ftlH5q9cXziGpp190BymqTnyq1Q47joVVETSsYr1fSTXeKa6M/g8N?=
 =?iso-8859-1?Q?CQWiYD2QbNxAYGkIIejE0rG05nU2EeZDValJcfq3Lr+u+Xk+Pc8ksOhG3w?=
 =?iso-8859-1?Q?S4orZ/OyrfDyrHlfZ9Xy5Mb/NASw0FjKknUuB3CP7PD1YUPQKz/rb3rYSK?=
 =?iso-8859-1?Q?8A0cFe+TRZFhF08xIZjonkZAZrfj3ewKUDKHfiyPqmOtz9x90tFN3wVcHi?=
 =?iso-8859-1?Q?D51IjUMfB/cQk/XwXObpjUPYo/rjLtL11ZtKFg/qeQ3Ez25vxp5YBqsG48?=
 =?iso-8859-1?Q?KAI//TzmmdYPsHeMzQGQHZ9TF7lFAoAeqoaCN9NcNMJt6eLznYSz+RaRjf?=
 =?iso-8859-1?Q?VorkXklfAZt8h0LM+UU73zj0Tg0a9WRC/u0CshgdKGh2pJ5JpZfra6rnKc?=
 =?iso-8859-1?Q?IieVKbH4P32JFJrn06eUFHqd0GptVHqgKqAgj/ruKVbNJTLL21tf6EgK/Y?=
 =?iso-8859-1?Q?FsYi9AVwrSNiIWyAIbkMituQFX0nYfGqXxT1Z14aitS6NyEDN5ZKCact1o?=
 =?iso-8859-1?Q?2Vx3/IvgtnBVLC/4LtZ57EZ5oRHL2eW9JeQdGzDel7DKI+lzfT+X6I3BSF?=
 =?iso-8859-1?Q?NE8/zdc0Fwbv39I42wBIRT+4LelqzG09tkDSbddixlLvZ7smurcmM4A0mM?=
 =?iso-8859-1?Q?PAeM8nnejNs9n3IlT/dFYYf3cJXeQDqWLSX2VBE9wtfiH/BeRIh0cpyfzu?=
 =?iso-8859-1?Q?RrqTS7LNmFs/O3gClsCmx/5Cex6duMNa+HHYKTvClvtH7JaMasecHBRncH?=
 =?iso-8859-1?Q?ul25BSutLEtQZ/kMoIAnub73iHqRyrTGZbnBRMk1OV1RFm8pS4NniXoxaj?=
 =?iso-8859-1?Q?RD35hkEiIKeSh2RXwaWDD5+j1FsBCWkA833LfwYddVdEwVFDdR21mqO++T?=
 =?iso-8859-1?Q?YxBIN1uo7AfqpSo4trvGuu4GdXJtNWEfRNEfekO3U5lWJddR/weEhoa9M+?=
 =?iso-8859-1?Q?WRg9zN1oOmXIHwu4GiHGGna1scvVPlXrRYif+NL85bmqltL+P0zGz5N8Ya?=
 =?iso-8859-1?Q?g4wq6T7rewRNnueyoQspAifbpZyuqWvELEaO2baHmMvCpTkJjYJyVnZBFC?=
 =?iso-8859-1?Q?jsJYzzl9lBtzs/7zGK6adotvBnKkDcaO578eOtJItpUi/DHIe1r3Y52PJE?=
 =?iso-8859-1?Q?CaY5K5b+fGUx8ABXpOWtUBTA+lM2GDRrl08FZ8PvhYlk5YwOv+r2RbF2cU?=
 =?iso-8859-1?Q?RuiKzjPUAT55Via/KGZlanx0I1d1sMHWDml5ifQAmseNBPOvoYdy3PDZnP?=
 =?iso-8859-1?Q?4GhxbL2RMreFcVYS9iwHTy06isqRjkykeHcLUD6AgSeqARLO5ayC+CNEMw?=
 =?iso-8859-1?Q?G78Mi+GzYt22vDlBW9NLVbqw2B4VRwoEznS9Y2t2Jn6f/+VlScU2mwhcGH?=
 =?iso-8859-1?Q?HOHiwF8HCuQH8mijgPJ7JevYV7af8bGQOsuQ88H36pRGBH8+ayte09hJpZ?=
 =?iso-8859-1?Q?WU9mx6ruoiLiMFGXHRQPpB0ZC2pCl+xI0VjPYIkWM/ypnOwjQLIj1eDP7I?=
 =?iso-8859-1?Q?J7P6LUK/hasED+SBJahs/jtJFQEz0ZJul1b1PKcLxt82nRN7s9YKAJx5vS?=
 =?iso-8859-1?Q?7yhSK2LFxy84w4fmFTfSkHAuYll9RjejW/?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd17d7c-4f0f-47df-a0f6-08dd0ec474e4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:18:29.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0vqok2LTymBmSy5JuiWtURm77BmO8qJTVwPOStcFfFVRvOp5lt+YvMcXDL+J8l5N8QQAmfxf/VviBVDAtg4EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5285
X-Proofpoint-ORIG-GUID: mmg3_pkpUooAlursdrsf7I1PxsbJvjvJ
X-Proofpoint-GUID: mmg3_pkpUooAlursdrsf7I1PxsbJvjvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411270076

On Tuesday 26 November 2024 16:54:12 CET Sverdlin, Alexander wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
>=20
>=20
> Thanks for the quick reply Jerome,
>=20
> On Tue, 2024-11-26 at 15:45 +0100, J=E9r=F4me Pouiller wrote:
> > > > +             for (i =3D 0; i < num_queues; i++) {
> > > > +                     skb =3D skb_dequeue(&queues[i]->offchan);
> > >                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >
> > > Nevertheless, the lockdep splat comes from here, because
> > > wfx_tx_queues_init() has never been called for wvif->id =3D=3D 2.
> > >
> > > What was your original plan for this to happen?
> > > Do we need an explicit analogue of wfx_add_interface() for vif->id 2 =
somewhere?
> > >
> > > I still have not come with a reproducer yet, but you definitely have =
more
> > > insight into this code, maybe this will ring some bells on your side.=
..
> > >
> > > PS. It's v6.11, even though it's exactly the same splan as in
> > > "staging: wfx: fix potential use before init", but the patch in indee=
d inside.
> >
> > Yes, probably a very similar issue to "staging: wfx: fix potential use
> > before init". I don't believe the issue is related to wvif->id =3D=3D 2=
.
> >
> > You have only produced this issue once, that's it?
> >
> > I wonder why this does not happen with queues[i]->normal and
> > queues[i]->cab. Is it because queues[i]->offchan is the first to be
> > checked? Or mutex_is_locked(&wdev->scan_lock) has an impact in the
> > process?
> >
> > In wfx_add_interface(), the list of wvif is protected by conf_lock.
> > However, wfx_tx_queues_get_skb() is not protected by conf_lock. We
> > initialize struct wvif before to add it to the wvif list and we
> > consider it is sufficient. However, after reading memory-barriers.txt
> > again, it's probably a wrong assumption.
>=20
> I've actually disassembled the stack trace exactly to offchan processing.
> I have no idea why kernel sends offchan on a non-configured idle interfac=
e,
> I still need to come up with a reproducer.
>=20
> But as soon as there is an offchan in the sorted list of "queues" (coming
> originally from VIF 0:
>=20
> void wfx_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control=
, struct sk_buff *skb)
> {
> ...
>         if (tx_info->control.vif)
>                 wvif =3D (struct wfx_vif *)tx_info->control.vif->drv_priv=
;
>         else
>                 wvif =3D wvif_iterate(wdev, NULL);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> Puts any offchan into offchan not of VIF 2, but of the only VIF 0...

Note skb_dequeue(&queues[i]->offchan) is called whatever there is a frame
in the offchan queue. In fact, wfx_tx_queues_get_skb() can be called even
if all the tx queues are empty (and this happen when the wake up event
comes from the device).

So the reproducer involves wfx_add_interface() and a not-yet-identified
event (that could be an IRQ and a Tx frame) that wake up the bh workqueue.

> I think you are right, this could only be offchan queue of VIF 0.
> But then it's just a race of TX workqueue against
> wfx_remove_interface()/wfx_add_interface() pair (which I see regularly).

We have the same conclusion.

> We probably need RCU in the TX path and NetLink lock in the VIF add/remov=
e
> path similar to other network drivers...
> I can try to come up with a patch for this...

I wonder if there is a way to iterate over the vif using the cfg80211/mac80=
211
API rather than maintaining a list of vif in the driver.

[...]

--=20
J=E9r=F4me Pouiller



