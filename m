Return-Path: <linux-wireless+bounces-10900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCC0946E8F
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 14:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEE81F214FB
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535102D7B8;
	Sun,  4 Aug 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dXhftE7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011027.outbound.protection.outlook.com [52.103.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CE368;
	Sun,  4 Aug 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722773877; cv=fail; b=RAiWA8n1vzVbaQdDSkKHtUbGeFSi2Cmxg9RLAqBnVx2KUlS7Oo1L4XOZ7jS5eXhrc3O/TRMVfpy3eEdY9wMuobTcDUaTaUKtHPiPd+X2xsK+Lz5JIHcn57seIwZHBn/W4D97HUF1oH2yH+WOwNMnbD93Rc4i7ENUL5mQu3F6t+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722773877; c=relaxed/simple;
	bh=F0czT4grHPklh1XcL8KQrk6WBvDcggOV49yoVDkE9Ko=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rn/AST6kOekIOAD3IAWwgnH31sYWC9w45+PMrrfz2juEeO+cCCziQwtMBvHzAdQ5Dh86Ku8XntqBGKtuUOScc8fQbdljhypKsEX3uvLSnU7oiBLLxclgnf0pUyDFu0VQlAxRYRFc0JQtnq+oYHfO9r0qZ8VgXG0yA8xIsUd3Xcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dXhftE7E; arc=fail smtp.client-ip=52.103.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjBNWHrS5ZVHGXptTf003Dwd7FuSI7z6ydGsme37raK6ecppUKUw2OFlyBNe4oDWqQyvb+4DbypttR5pNdUVdK5zNwBVpCMmVgpuHHY/Hql1EgvoHsuewJ+dOvAbZL8Odu5ckRcTflDLNOO7WsOgm4sUE/V+ryBE9oqO+Z5NxaB1gBJDtm+ykQ792J6U9F9M+tn7hqhYcnte533wCvzi6ZiD7heIFYJdIaqo8H8F/9La416//C3tcEpNvMkVXrOj6NP+7y3Fw2OxGYA2HtoYFTW2ykpBaNvmtic8g7Hlgab4ejivHpTic08K1Fn/ekAqThUr+0qY7azGGaWN9sUIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0czT4grHPklh1XcL8KQrk6WBvDcggOV49yoVDkE9Ko=;
 b=OynulTgsaAuPdvu0ZsW78dJ+5dtv3SHlDNNdaUSQOCN3cIgediL78Ax7j54Ub9I0DHtbS1niNvaD8FxPMdtSKj+KslI9rXH0hEFp4PTCZ286hNUP3M+WdhAgvgus7L81GX7DkimvXpnH+0Dh/QOdzKRx/56/68G5/OfRE6hxRvkXwKMURvYzNuwWwhHQDTyozjnbr+3GS5CVuSgaK0q+WywZibEdQoZxSfoJMYkkKL/wDc53O4GK822yMru0zHYZ/McTcMYs3UuLfP85azTj33pKPbSvSl0+Nuzbxgz1S8o9QTdouEEmDpV8s3cCLtWvMAIGN6HBH8mlvPVfGRveEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0czT4grHPklh1XcL8KQrk6WBvDcggOV49yoVDkE9Ko=;
 b=dXhftE7EaCuVmtuQfD99HZizwUq0DSqqkrIAGz87VU2c+PhonHoAqG8i19P+K6MaNi9MVcHBS+L8ZFvQtVcPdJJt36PJGm06vKQViAn7hg7TakuoidUT/8RbJlFDDHQapUCC7ns60oTz5v1t4efLnrY7Gj+0+5dCOkxGCyYPg0q1bVueQBQHowYFyRPx5F4dl0xEwMVtPrjlgXbpDtL/9UW370reewj5tdEKvRv3w9Isgr8i1Q68jNyx8WvMBA6ryK93JQxGQVUgrLXfHHTWrbTL949AdHDgvn/pnrMoqp9NP8RzJJ7Uc2tHSMKzBhSpUKsj9pF+d2vC9MqfdHsZ6Q==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYVP286MB3715.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:369::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 12:17:49 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%6]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 12:17:49 +0000
Message-ID:
 <TY3P286MB261189441C7AF5E7FBA0634298BD2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Sun, 4 Aug 2024 20:17:44 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, kernel test robot <lkp@intel.com>, nbd@nbd.name,
 lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
 sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chui-hao.chiu@mediatek.com,
 emmanuel.grumbach@intel.com, StanleyYP.Wang@mediatek.com,
 meichia.chiu@mediatek.com, johannes.berg@intel.com, quic_adisi@quicinc.com,
 allen.ye@mediatek.com, bo.jiao@mediatek.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, oe-kbuild-all@lists.linux.dev,
 Sujuan Chen <sujuan.chen@mediatek.com>
Subject: Re: [PATCH v5] wifi: mt76: mt7915: add wds support when wed is
 enabled
To: Kalle Valo <kvalo@kernel.org>
References: <TY3P286MB2611CB2F4F5FA27D782AA80A98BC2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <202408041039.BqVRJOqp-lkp@intel.com>
 <TY3P286MB2611C363575C77278946A4B498BD2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <87o7687gso.fsf@kernel.org>
From: Shengyu Qu <wiagn233@outlook.com>
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <87o7687gso.fsf@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9DzjvMbE1ntcwDxmK6QPD0DA"
X-TMN:
 [2Cxea8Et09x6i7MdywB/Wlu95aDP0v0naWFsvWO2Abvd1KUhCjVvpspfi6U/hLBxYqjzr7BLS+w=]
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID:
 <811c11e5-1083-4d03-97f8-60b5c809a4cd@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYVP286MB3715:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fa82b2-96fa-4556-f40e-08dcb47f74c7
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9Xmqyyf+cGoeQ3Ulm4AiLwQwdQS05wrRZe3hUm2ps3yRMvBKIbUfe9kBCPeAXY8ESq25wy5litdCn01d7T0etJ3Q7RcAmR956L8JQCJdSu6TRIamSf4qmTOBn/xEktnL2mvFmMHuiOjXd9iMfSmF40+zlTS+gFF+CieWbRmKTKcFItyO24w17SuKMpHONK0iETI6FEkU2iF/lzbre/0kPjsaFBHg9blMFla1J69LPfqpudBx9JieVlWH9YyK2ZrreF+qtlxFkkU6LCNlads+v2Z5LpNNzbJ9Fj5f/hV0nW5YFqXQOEUCnkaV+bxjZ3PCEnuHK+mZxX1CQa66ltNvFyg0Y3ooiDysJFpkgqHX3gKlLFCbyoEWmcl3255vdps3cRmuijufqsVJFwzFdgmUMzv5nxnSwTNovwTyGcWhuxYbllEe8Vg6PXQ3vobxOdqhEC3EMuZdDfaYZq9W7oQEzofimiDdfBCQom6lmeGdXj/N4qQ+Fw0eGxTUx/cLrjJNOjqVsc7PZlpMBgedhkpBm8N1Gr+Vf9ijpHfkmf8ldi/TXMOz9iZQGmFjMa2pNExY4iNSaZ7EPPM1Tm5KVZIeZL6yol/2GyLQlQzoahqlwlBtBahJ3xSmjc1t3TNppQQDACk/9LJUuAayJB6cSFn5F/uR/pVQ+kNnEZpo+dxqawDEVaNRxXKkauG8pF2ND+RTbYmZHC2yJEIlyuTOzJ3SoflbUIISXOLleES0x0kOmbeCyikTTN8MS8RXJyC2zNjx6n+A=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6092099012|19110799003|8060799006|5072599009|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	+p+bNxUj3neHOx1tgn1qdxXczfLFh8xpRNJcAd1lf8zMiuZ7JKM13mXiW1SqvPA1+zXfxaeaFLyz5lDKyI3ukjmyxdi4iZxTpW+c1Ph0JS4JO6JERSVUX3Fw0AjXWtHHSscmh0Y0l3m03Ss+oW6CON9y/juv4ufN7zsQ/AsGikbZ5jwSFuRSHoaWWnoGP01f2L2ecnZGHxWZUCI3DjnIRsZ9VfFGUr8HO5oF3aOgs/vPcfP9Sa2Qh2oYKtBp5c3HnlRzHjGxBVj8DQTB+LvMpJwTjBaY3mpeAwMmP/j68EDfKGoS+Y4tzUdLdw/1L3jVflJc5HXygvDE8V+Y+UxtVkOXsZVJRjG4XtJ8Seb0QUo5GbizwF1jPE6a9/baI5QRUV4iHUIOlIRLVi9NfgQkg4XlzwJ9U26DOtTcPBtQ0syPZEj9ADvhuOCLF1TCnh5vTSvoernTweEQbygfz6hf4yr9Z5+tjiWtzEU3drKN/2yOpvjOY40pZ7xECeQ7k9/MmsfEsYjX8t0NRiFzs2J6xRMkT7/VTle2al25vHvQeNAjrWj/OGjexOva6nqLOElOR6oDq1xT8yDAmAs9p1WKptdx8E3aUVaU37oAVI82A8eDis/Z+aEwa+BbmsI+V9kgC6vfk7AfkKy7rfbaMD0Pw8w9laqXQg3IMJTxOfEZyQKC2bsdoC2iqhaLH2/Zcq936jACweoy5+JzBi/kSzzgIjNjWpkZu5vDDWobHVvjU0w=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfIHrZSy2OZAOqwLShRnA2eoSc/TXk9XIoqQqSMCmOoD4gKRHJrZ1gIyGoCh?=
 =?us-ascii?Q?LqR6NeV0T/fRzKW8Wz+sClH/SskTTIg6oQ9QKtWNEou/3rthpsz/IwZQqPuz?=
 =?us-ascii?Q?tO0uySxSN6LcD3UoA6KZTm6jzkec6xOVg6Y7EfSuTessBcxwHFdo9fwQpZgl?=
 =?us-ascii?Q?HZJuhR2OWENf2y8mEeiY85UZNaHyy8fi7467s97b3hjjp711eJUIItqXqMb/?=
 =?us-ascii?Q?BYlEq3y+hs7oVEHn9vJJo7zWIBDOukcRxu+bWxwV6jsgw1rkDr5dfFQMiUgR?=
 =?us-ascii?Q?H7k0KOuT2yXE1mGwR3r7oz1jgSZyV/lwcZAugi+WobKX9W9Zvzbe3kCL7vgu?=
 =?us-ascii?Q?/xfiH/BPE20rMJ/5wRl5Uyp/wLQ1yLMDFhTaQr1OzGgnL6BUcwFC+pre1lXP?=
 =?us-ascii?Q?SnwPg36edm4EJVkPO0BaOvfcC6UijM4N+MzUhMI0kBvM46IsaA1YaqETj/Ys?=
 =?us-ascii?Q?mI3lRSG4mEHLrgCuPjLkRqddS2iOnH8rgaBEo6ZW1mWcoFyFsp/HHkJsoWAa?=
 =?us-ascii?Q?r+TIwBGRvK4xcyvzNNHQ8Q/a2rooRfiHe6j8kd7nlRGIGX1bfcI/J2V5JX/P?=
 =?us-ascii?Q?alXEOLaVqy/vdssQ8v3JBi/PDaYEnolpZp4yL9gvi5oN8urMDs9BmsnjnTtj?=
 =?us-ascii?Q?nlFsuSX1bPMMrvKSmKmxk6pYjAAxJP8ICXj1BTIHypHE8ZOcY9od1+aH3q+k?=
 =?us-ascii?Q?eU/g00PR6DdcTCJnZIqDRKCrADBi5AUEVwzRVgrYfS0KRARioIMAXt/Qyeb1?=
 =?us-ascii?Q?jn+jbC8DlzdmKlBnqaLOMionP+SQsflLBO3hcNoeLD984CsK5muPIaNqEtis?=
 =?us-ascii?Q?f9Exdn/zz2THCbv05kJaenzz0JZ6t10Mem/5+SYmh2OK0j6GAEDbsj/BJpgQ?=
 =?us-ascii?Q?oQyma5b80qo2J4glUxblmHrCtZdS6vGI/W8wLoPzh9cRDI40qRvqn5LinmPl?=
 =?us-ascii?Q?3qL6XZYFAFdNejhUt2w7/bh9fCzsqYiweXibnx5MJt6ORcqcGhyob7Qk8Hrg?=
 =?us-ascii?Q?0026ReJVZAtNuKkSoQCkAQrdRw4wZsnx0fPARYo9DxD9ikwYQAVE429TcuFv?=
 =?us-ascii?Q?TZYaf88v8hrYdK6r5j+tyVqO2nuhZzlio4CJn7X9hHSaMJ+FiuD83gEsiWE3?=
 =?us-ascii?Q?q0X8sdWstTm4o0fIPpRx80vREr/dKV2YzjV4KXcE0ezj1WmgxC+MBaWa9p9o?=
 =?us-ascii?Q?2E/Gk7pPoOXlUS/i7WNmbrwyN51QvZiAfgcN4bhUkmwgSC1k6MiQhLsSkTwc?=
 =?us-ascii?Q?KbV4nJ1mKp+NloOoCfsrAjoaFiP6RSyUy0DRzyBlUjXFhN4eDDJQvwdU+NJy?=
 =?us-ascii?Q?4B4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fa82b2-96fa-4556-f40e-08dcb47f74c7
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 12:17:49.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3715

--------------9DzjvMbE1ntcwDxmK6QPD0DA
Content-Type: multipart/mixed; boundary="------------k9UuR6m47P2rz2qUqKHzynG9";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: wiagn233@outlook.com, kernel test robot <lkp@intel.com>, nbd@nbd.name,
 lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
 sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chui-hao.chiu@mediatek.com,
 emmanuel.grumbach@intel.com, StanleyYP.Wang@mediatek.com,
 meichia.chiu@mediatek.com, johannes.berg@intel.com, quic_adisi@quicinc.com,
 allen.ye@mediatek.com, bo.jiao@mediatek.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, oe-kbuild-all@lists.linux.dev,
 Sujuan Chen <sujuan.chen@mediatek.com>
Message-ID: <811c11e5-1083-4d03-97f8-60b5c809a4cd@outlook.com>
Subject: Re: [PATCH v5] wifi: mt76: mt7915: add wds support when wed is
 enabled
References: <TY3P286MB2611CB2F4F5FA27D782AA80A98BC2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <202408041039.BqVRJOqp-lkp@intel.com>
 <TY3P286MB2611C363575C77278946A4B498BD2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <87o7687gso.fsf@kernel.org>
In-Reply-To: <87o7687gso.fsf@kernel.org>

--------------k9UuR6m47P2rz2qUqKHzynG9
Content-Type: multipart/mixed; boundary="------------v0VOlPgFtxI0Ac0pCyCYFLbR"

--------------v0VOlPgFtxI0Ac0pCyCYFLbR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

WW91IGFyZSByaWdodC4gSSdtIHRoaW5raW5nIGFib3V0IGNoYW5naW5nIHRoZSBjb2RlIGxp
a2UgdGhpczoNCg0KI2lmZGVmIENPTkZJR19ORVRfTUVESUFURUtfU09DX1dFRA0KCWlmICht
dGtfd2VkX2RldmljZV9hY3RpdmUoJmRldi0+bXQ3Ni5tbWlvLndlZCkpIHsNCgkJaWYgKGlz
X210NzkxNSgmZGV2LT5tdDc2KSB8fA0KCQkgICAgIW10a193ZWRfZ2V0X3J4X2NhcGEoJmRl
di0+bXQ3Ni5tbWlvLndlZCkpDQoJCQlyZXQgPSBtdDc5MTVfbWN1X3dhX2NtZChkZXYsIE1D
VV9XQV9QQVJBTV9DTUQoQ0FQQUJJTElUWSksDQoJCQkJCQkwLCAwLCAwKTsNCgkJZWxzZQ0K
CQkJcmV0ID0gbXQ3OTE1X21jdV93YV9jbWQoZGV2LCBNQ1VfV0FfUEFSQU1fQ01EKFNFVCks
DQoJCQkJCQlNQ1VfV0FfUEFSQU1fV0VEX1ZFUlNJT04sDQoJCQkJCQlkZXYtPm10NzYubW1p
by53ZWQucmV2X2lkLCAwKTsNCgkJaWYgKHJldCkNCgkJCXJldHVybiByZXQ7DQoJfQ0KI2Vu
ZGlmDQoNCkRvIHlvdSB0aGluayB0aGlzIGlzIG9rPw0KDQpCZXN0IHJlZ2FyZHMsDQpTaGVu
Z3l1DQoNCuWcqCAyMDI0LzgvNCAxNzo1NiwgS2FsbGUgVmFsbyDlhpnpgZM6DQo+IFNoZW5n
eXUgUXUgPHdpYWduMjMzQG91dGxvb2suY29tPiB3cml0ZXM6DQo+IA0KPj4gVGhpcyBlcnJv
ciByZXBvcnQgaXMgYSBmYWxzZSB3YXJuaW5nLiAic3RydWN0IG10a193ZWRfZGV2aWNlIiBu
ZWVkcw0KPj4gIkNPTkZJR19ORVRfTUVESUFURUtfU09DX1dFRCIgdG8gYmUgZGVmaW5lZC4N
Cj4gDQo+IEkgZGlkbid0IGludmVzdGlnYXRlIGFueXRoaW5nIGJ1dCBiYXNlZCBvbiB5b3Vy
IGRlc2NyaXB0aW9uIHRoYXQgc291bmRzDQo+IHdyb25nLiBUaGUgY29kZSBzaG91bGQgc2hv
dWxkIG5vdCBiZSBjb21waWxlZCBpZiBpdCBkZXBlbmRzIG9uDQo+IENPTkZJR19ORVRfTUVE
SUFURUtfU09DX1dFRCBidXQgdGhhdCdzIG5vdCBzZXQuIFdlIGhhdmUgemVybyBydWxlIGZv
cg0KPiBjb21waWxhdGlvbiBlcnJvcnMgb3Igd2FybmluZ3MuDQo+IA0K
--------------v0VOlPgFtxI0Ac0pCyCYFLbR
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFaz
LV3FGBjT+9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q
4Ww/W87mQ12nMCvYLKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx
0HJ92zTBMzMtYsL7k+8ENOF3Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/
SJv0w2YmqZDIAvDXxK2v22hzJqXaljmOBF5fz070O6eoTMhIAJy9ByBipiu3tWLX
Vtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1el5WW/qxqrKCSrFzVdtAc7y6Q
tykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdromSrsD0gEmGcUjV7
xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB+X85sxcr
4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0x
i/KZIRpSlIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQAB
zSFTaGVuZ3l1IFF1IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX
5PUVXUNSaGVT2H/jUgzJGSnI5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
AQIXgAAKCRDjUgzJGSnI57GwD/9O6kei9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ
8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSiOnyyHrg8StmGLksQE9awuTnl
nQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHaJwFi1KATSI1AhsF3
CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9voraKhx+0Ds
ZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISF
gvZoGYdB9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaa
LZH/jzQf7FpIGGhDYnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2
yVu3w4tIchRT3wekMh2c3A3ZDeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yA
j6Ey0YrIUbW9NOhIVCGkP4GyJg756SGzyPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AE
H2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4TrXUR0ScTy1wTKV1Hn+w3VAv
6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23Fj4LK2mKTBoEwtC2q
H3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8aiQQUKyZ
dG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM
/pM4L0tPVCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwh
agPSYDV3cVAa4Ltw1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVyk
k4q2DDi0dSC6luYDXD2+hIofYGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjn
zuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQ
zRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoDIbtRm3xt2tFrl1TxsqkDbACE
WeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3CizcOmgc61pDi/B6O2
IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DBbUslCmkA
EQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3P
Pt4wkQkdbF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZO
pxb1EwWwvnVUwrLxCuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsN
VeqrWU0mDAOgvqB86JFduq+GmvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEy
uRmtKtqxTP/u6BzowkV2A/GLxWf1inH5M81QgGRI2sao6To7sUt45FS+y2zhwh62
excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFOjeBOYr+ZCCeARh+z4ilo1C2w
upQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrrmnEaZMsoRdS22fne
CVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/1aPc2Iox
cQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/a
LzG+FguuGNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2zsFN
BGK0OekBEACw8Ug2Jo4DF9q3NFOZ7/Vwb6SlKpj3OdBjGTPwRZjV4A5CzbEqXrkl
TKFNE9CRbxyoNXN1UXXrBb7VHKgyu0rnGPqOb0rtUABz+wMvYuShKOPcWmg6n9Ex
9UGIsYBMJ01IQMU87qcZUmfxo5eYfniyBnOGB+pbVf1jhOhZWIXlVdmxYbMc+xeh
W+VHI98BiL14vXWFmpBWFc85BO4AbijDzPtkZhPvB9mj2he+z/XUND+nG3to7xAY
I0Kxacw55w8HL35Nuv+G7EtUWX5uhpO/dDB0BMcW05s6L6rebpEAAMFVBKIAJUKy
pvTYcAN+E7yfQAzvl8mNtcVMsFHTr54wTSHR0Xx32G72Ad7dkeqy8HhfkT1Q/5V/
xzUz1qgmtQtWgA6jnSCYISGOXMjnFhzMG3DVuE5cI/RaPlybHfBsqrtQoxeMMoX1
qD3Tt3TvwFojOEw4KE3qz1zTcozqLHScukEbNhlcLRUv7KoqSIcnN56YEnhjMu9/
ysIbFuDyQo9DaieBBWlwTiuvq5L+QKgHsGlVJoetoAcDojCkZxw6VT7S/2sGCETV
DMiWGTNzHDPGVvutNmx53FI9AtV09pEb2uTPdDDeZZhizbDt0lqGAianXP+/2p1N
Zh0fMpHJp+W4WXPQ+hRxW4bPo/AXMPEZXkaqqDrMcsTHrwrErCjJ5wARAQABwsOs
BBgBCgAgFiEEl+T1FV1DUmhlU9h/41IMyRkpyOcFAmK0OekCGwICQAkQ41IMyRkp
yOfBdCAEGQEKAB0WIQRP/KgY/enlmX5EpW5fvkoEB8mxGQUCYrQ56QAKCRBfvkoE
B8mxGVNQEACNCgyibR1+BY00hem9CCIZGHqyWfJn9AfiPYIY1OB80LUJXhJULtT8
DeUUOgMZtywhJvu4rIueOufVzeuC5P0lfO4htBmi2ATQu8bT2h0YxcNL3YKYFoqe
+FiVI7RxR1G2C+fDecyCXUrPtry++NiXdLVeFdDxumCuHZKffqiqFpL/8yDLnaoc
3aVHPT2Wv0iDU1JeSOC5LKPWFNznA5ZX6uxfiKzSc4E1qi/vr+1twXqwiwfIc9Ib
NniN59mzfXyKd64Geu1UT2wf1dZzVAcsXWDM4orCyx11eVh7ZKPmmVe9mpwcdh+s
4t76/WDFbbUe6ZSixOwINRUn16CvUNBxpCKI5RXmpCLj8Z+oUBpyR6c1sdw0uk7F
o4TcjBsvQXtpkewqyXXyy4NcCpveWPICbh8RmvZx4ScTufXH0FmLMkthuRgH+TqD
HHFvKNyhHoXWeIQT7oez28oY2a81CKQ+m/TkgNeA6vqmBZYJ1kKK6nc3vbFLc4Jk
2SRVCNpIvr+E38hxHz5e2n6dtgfgCCb2EEA83TjmX8/2dWZJA4ndML7AaCjw3Xqr
NbTrVgP99oH+D+7tFxJ+LlLAhIjKs1efKEFlOsXH7QqyO13BUYldhFL+2KjrNFoG
X9s7f57xIaqwdTd/okf4eBNYkg1+Pcj/AMgEAvRcagMATy2pAGmxMF2YD/9Z6y3I
oPB+lkSrP3AE1fhBRL/OH7UaLB4pyCpeGLhG5X8xdM9dwRPX+kadflKH2F0GPqUi
x5O1tJUMEdCb/WpQ9gUAb6Ct1Zntis8hd8pNQIGUT+kpwnpiLVEhbeg5DX459ho8
N+o6erYR34cUz4o0WFa1TVNFQGKRTWfzyUxxGUUcW2QC5mCwPCPZv69zvW5c0Ddi
RwUcYGGruslC7cHWXbO8zQ/R2zQcCjnyIniqoyQDTsQlK1oBM6iQMALhej6fsMe7
zWlA8/0FNj27Ub6biaWmK9aohWTkZtv7bD3IKaQRaq/lBg+2OmDGrSHNREt5T4EO
85QqMJLnjzQ2/FbA62E+piWzRaChJVUy0Ol6SVJHGascnqT4fWBX0lpZx9A7+XQh
CtCbX7ETzHPzugeXXyAhVuleaV+yzoSc9+aF2y38WrFczSzFX5APegWZ/8JxEbhJ
KqOwqSlC+IMwblPA3naZbCiKuTYxiU0Ys3CSdZeFFvSXuvhLJk185anQQjQS874J
8pkvTd2ueYxp46hde0rCZaAKlhNrp3G1NNUpt5QpjLan6NhmpQ42XfILC4v1Qg7A
T4vGG0QPhmMhbGgPn+44EYuh8/941mkyaYL0fXyu6l2HoKEZiLerr8vqgc08NvAl
QW/1QnKz4zA5XUvOrxQsLFF9ie2eG6DWJkdh1M7BTQRitDoIARAAtZRhbhuAfenu
NS2kPytShodMn4bfP1lSNi/P6vSWVym6s+bQPIbuRYfNvMZMKR1hPF93ERpSCAx9
bEsLtXJ3w9p2gFOUkn77sw/14v0jPJokQbTfg3dO0PKb+/89q1oVuOyGLhgXW1P/
ZGdIred56i2vsVfz7NmvPkSATr1bPTocYgpqdGf1+FQp8pDN60aXQ0RJ7rZpOTGx
/5BvgeraLXCbpy3ibaJF92HDU5QM1AeBs7LpXybFc+DZ+wktULeKemAF2EDnFauQ
CfGi66MHXGz2Dgy77ladSpz+OvpLTMpubzVeiGXwkNsa/Fs6lv1+arY2dUtHjvvU
0kLf/arNT+mOCMD8c2aOapgUQhOhM2U2OwRgbJ1y6OVKyN0UN76kDpKSpSsQelpV
/TfUk4LMTOB+rIfeAwG0NfKsYCzxV2dvX9E4wgAupsryeHYhidFuUwQncPqckOVg
xXCwOA6GGtMVEQFR0snuVn4ulLgAJy0rJXbYSj8vac4V67X6l2CK8xvgvZUgm2C/
MoV9XcjoxQzNIMySFDNBmM+rtTOW7Rxn1mlI7se5TOKAlnq+cTuLAu+L/LKNRSoe
dKYsUUTjHGmewyUNlcHHHQcjMS3jwzZ2a9+YP5KpKJCsT/eqBZoiPAL6V9iCBiM+
02BKe2R86wK8OqehvxvR2mpFwVPk/H8AEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1Jo
ZVPYf+NSDMkZKcjnBQJitDoIAhsgAAoJEONSDMkZKcjn/ecQAJ1Da87OZQnYugWr
vPQOfsdV9RfyyXONrssGXe8LD/Y6rmzZVu+Bm49F9TF0Qxc+VOrJpv9VVsfOqFJi
0wykOwyESdVngNrAW9ZWzfIvkEDSpTlaxvzbNEY7pBpvb1xFoSMrou1ro3299XKf
tlA29RYHiwH1HIC1JPJBWsS4tlahZ9AtGo5p5wVoEKxN6D/SrjLCcFiQJlH1yISc
sZVFm3qgTuo2g0uzJM0o1Y2B7T8mK/rsm3hUHJlbCrPl/rkYEAlhSUKpawKhldRh
OeqUUCcjnfdmFgTH/HtTMIlEQA+Ck/T8M5+Zp/nhCpPCx0pTuDdUTRo3tWHL+Nri
wK+AuZNR+0pevuTYOyD6CV0Hng/3lU86i3gN16GVxNWQjUdQ1ps9InaQhLxsgevQ
msgzOqo6GUiHQIdxvAtcG7pXv7HRhxsZA+68h8lixiMeE1W30PH1nxn5gN/Ekldj
c5F9xBu1/vTSX9dGzer1zZZFn4J8lbD6R+keOaroF8Q9S1cYnQbh3vASshmzNgi+
ISmLtR1a4zjxY2AlKNv+jkdpItjot5dewxVeU5x5i1sXWJ3Dt4xNyFSs2PZs1IuP
Solmy00hVZdFiGmr8QuMmOo6YagSdVvrryw812k5vAskD5AMC9EGru1Y8e9FddsL
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------v0VOlPgFtxI0Ac0pCyCYFLbR--

--------------k9UuR6m47P2rz2qUqKHzynG9--

--------------9DzjvMbE1ntcwDxmK6QPD0DA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmavcWgFAwAAAAAACgkQX75KBAfJsRly
bg/+MwPTlfJI/XXtqUnD1IqWybwBIstw+2EmSrUX+2CUI1pmzyG8N8Xmk/POmpAY8X3OPYWgVHEl
6Xq4tdvPAmsueRYrWdPZd1qcDQ0+AH2k690q+LM69Ey4BAXVt9WVB5f7zZjH8kVnfu3+fglIN0YZ
Bz79pK/wX6Wk3X5F+pP98hMO2ogmPN3BC24gnV2pe/pWG+7xFLJC18wbj7Iar2Bnh091WGltgr+z
4xzenVSQpBez9LlyHln8sV6Zv8HJUiNvy4adNA8aUSlaOPRa9uWMViCfzSUu/Q9o6IS4AEuM3mDX
gA4o8cyFANBe9SrQyG+CMyTjkYpFaswVqR/OPhvOy4XuY6NxJ654fmcsIpVomr2nzx9qrRmHAhdp
Lz7dUWU90J4YGGfaGRU0hSzKGM6cn1xeuYSGYMAxbAKbxoG8cz3XUnqNi1WYmJEQ9M92NudWGZE2
1Bzw56hFtrciEqMVlpfP6T0OCM4xQPbnZDwi54UEtKUxNHMMP/oHbqkoJGbX6pLUeXQ07PJYSeAQ
CQJzxHBfZidaWbjWqTXgyjsoUaktzOfXADnDgBtOY6M61LiOslZ8ZYAPtfGf2eU9PaAYEmNbzVah
CKay8saBZtrEMvEO1xuoDfGUhFN9VeHK8M8VFwTUFzdPb0YEPQ8ZQjU1LUiBzmqag+CDl2EDOeQ1
AJU=
=x755
-----END PGP SIGNATURE-----

--------------9DzjvMbE1ntcwDxmK6QPD0DA--

