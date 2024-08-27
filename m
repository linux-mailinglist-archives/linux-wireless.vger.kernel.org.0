Return-Path: <linux-wireless+bounces-12090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A90C961661
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512EB28911D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A391D2788;
	Tue, 27 Aug 2024 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kbJe23aj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010010.outbound.protection.outlook.com [52.103.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AD1CFEB7
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781930; cv=fail; b=VyxRBWRHSGs2N5TEOoqxn9KUe/CBqnnuINIJQURvykoSVgMSd8xBiFhWlkmJH8ixklI6y3KZ8jDSyhOphoMazk3A1+Pr9HULNkSK+XilYq8YskJiOn7iJg0S2WpyfZxmdQeiNK2ru3RQB0RRbcS1/F8tz8aKN6IA2GVXl/YJ+Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781930; c=relaxed/simple;
	bh=+nDNhut0ZmtxlGG4ydsU+UaqQZnwzCkFTvMXCwOdppk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+tJkl3gamh7JHRvl7kyrWo9LO1pZ0HXzWsLzCZtnocTz9hIoV92IOIF73hf+flkX9Vw5+Qn+chOIY2pLFLkuU1WSy3n63oA5RuiJlrTijAzNER/0E4oRjFMgr/ax+kukjL/OP23UaavFC1le51sccpOMrg5DEcMpK7w5SQZXMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kbJe23aj; arc=fail smtp.client-ip=52.103.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCPzANsbG8YJWbUTdCqMsBS7hzTV05LGGgWugpIXGwAlGozQ22UXOdcR6UOclO4qKE4e/iX83teq3+uZs/pUHQzZxg72kYONnguIwNTg6PlCN7lvtvJzKZKCD7D3sqbiZsuNTCJCZpFej82jm6xQHz26iNGKxBBvE5J2FWxAN39VFaudDEXFHYfY5vUss9XdzCphRql2JZTKDNjIpIuhrHQdGdJ87GZNb6HgMJiVfIUkxKSQBfwLcvQbcueD16A7taL5bFdgHux1q0cA88M3q15ybt4MadSRHftQuwgp2d5re57NRrd1OjdnmQDjBbmHmJxk4Ux2L5Djgt7op0/3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nDNhut0ZmtxlGG4ydsU+UaqQZnwzCkFTvMXCwOdppk=;
 b=PvqJELE5oB9Sgu48/gEP4wywfpr9Zi0R73LOhYfKbD+uC7IZzOqkxuQXeWEzYLPJPJZCacgmPjuPcp6VHo814am8+wSK3xwj9XjBitAlRwwbLhfy8s60VmBDgGPuCcDga6pZzIgn5Uji868f6bivifc655c969H6MeWlYpxsO6bK7ZhcWD+eE0ELWPmNrrpzgIlCAW/CFQImI7MB7m+jvXcUJ7fqfwQBSgQ8ISpHY+3DeO1jANSVyMFcFt2hMKU4PPK6hXmRJcz/E2O3KFjdli5Oa8St6+DSLCUBfQcYylsdQCooLPsspZWcHGtHGdsXzSWyVUiNEfOssWxfMjq/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nDNhut0ZmtxlGG4ydsU+UaqQZnwzCkFTvMXCwOdppk=;
 b=kbJe23ajR0ONytLh+Z91HNLcFfahTuvR+5NlTvSidnR2pmVgrBb41T1BPMoIjKyhog9YkylN270Mv7TyS9dC7vOh54nlk0kNR94neF8buRMVL/CDCQAFWi3eh0NiVUcQMml+hZva7cXMCkfh88eXBEyM4sjkJsCQ447qtC5PjO4SuEGEyba37NLnPgDJdTutzbiJU92JAz0Alr4xUS7BVst05L1sDQuQd5urBWrPMCeLclKr3lWK/0x5X4lmkrmRLeOEZ5oI3YNzuqxA5Mk/vLS1k6Juca/Jkqj+VyQ3UlHyhfDTv+d0GHfy5ZCcTm87ql3iBAwf0uKusSDXrFKd/A==
Received: from TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:85::11)
 by TYWP286MB2761.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 18:05:10 +0000
Received: from TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1672:339f:cd51:afdd]) by TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1672:339f:cd51:afdd%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 18:05:09 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: nbd@nbd.name
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 05/24] wifi: mt76: partially move channel change code to core
Date: Wed, 28 Aug 2024 02:02:39 +0800
Message-ID:
 <TYAP286MB07467C718A0428E8D6F0B0EDBC942@TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827093011.18621-5-nbd@nbd.name>
References: <20240827093011.18621-5-nbd@nbd.name>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [NSnXakTA2oxOKinUu6L8DTbvwxGByW0M]
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:85::11)
X-Microsoft-Original-Message-ID:
 <20240827180239.1148-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0746:EE_|TYWP286MB2761:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da3853a-609a-4cf1-8146-08dcc6c2c9ef
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|19110799003|461199028|3412199025|4302099013|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	X8k/3n9jtJG2mgBfabm96cNB/0wOC9kBNvtCwbP467aMQZ6mLybOhXx+NLM4Vhmx3Mot/U8HHSFWMoqkh316voP83sOAdPI1aKCeBAlZVbmFdKxLdhAk5IzyYp8bxLV9Pbx+BFWGBoYZGZRoDKvRr7LtV8thfl3xewrN+V5tSLBiceKZ1drPnHwJTckFqJeXuV2HdJZ3fpgpp5IUvI3Xamf0izALbV5ocgbwL0jpT8AmfPQauF30Rdbyiu17e9bpn+Btuz5z7L49ZB76mAbm9CLrumx0JZmUckZvBpP1H/GjiNWOaCq2Qk05eJp2Q8xGelQmPkU3OJF8Fbd9OW470E1+J0M1fFv5brtED7g3YSmoWMGx5qeJlLNRHiRC+n7+Ek2jmHVzYWkBFbQPwCFdSW5AvkbqCj2S+mPsitHctTDEx/l8QT4jS8JAKCTIFbRiXlpOfXa80HS0T3h1D4ySaBLINRqbed306VHn9SoOlyXrKIXCdj3bHqC6cGLIo9C2yK1Qfy/55B2fZbBTG7WtFJ6k9St3gUlgOR233rYoTadcw21wKO2pxEjtEmdUFbM36Nen0IQwGMU8kjj2PA7fqPYX189QTAItOEJs+Xgl0UNcGHRIopL1LfAJJNB4xlqZ/mEmq7MfrDQrln2ISlhWEBS+sS0sl6rxehY5Fkh2ExbPOD/cjDVLt5mWAafaTY6t9b9dWp27PqFQiF6Vwow3knGVYIMH6FirKeh8mE5VYUdBFgA5VK+2aJdi/fRC1N3LW5xcTF63Oo2hxcF/1qTdYquwjia+k1eRxnwBNaxFw5xLCqmHZ6MY+MDyAxCl5Iew
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K0/gazUcFtagOsOZ0rLSFnzfp4qp1bYtYm4yC8Or2e9vlQGkhjdW1hTqQryh?=
 =?us-ascii?Q?okwWmdxUEQsyRSaTTTeXYBACAGPP4eG/VDBJurn3Wr9W2lTShRffMpfRdHek?=
 =?us-ascii?Q?wgtqOki/Pk9ypGcdrqunhfu2d89fAsFXZYe4rhyy/e4g92z7wHgNbRE2Isv5?=
 =?us-ascii?Q?uqVkN/UWqPcI59pp8O0nXgTXC5sG68mFflkvVQpyCb8xkMWWpjRg03unpygb?=
 =?us-ascii?Q?130R909ElCpcckHWWcd9rROrVY6yKIsZm52DI769kRb9GQ3JaqLtoo55ZWYM?=
 =?us-ascii?Q?wAsuNfkeu5rPurT/9IMdv/O6y3H8tA1LspRD2RxYbLnoCceWGITpx6o8WYqT?=
 =?us-ascii?Q?Luyk7RVP4kCGJAljYpFZEoEUDZFoZ3zZjgJu18Ddp5aFcm9+AhguuzS4hj/7?=
 =?us-ascii?Q?2DOGwgmAY34nbzvr1+dtnQPobPy1/WZv+NTZ2FsZOiAK5B9TPbp0p7phpeaM?=
 =?us-ascii?Q?ISEOkegzj8UbMvycIWsn5GKPtNhwx818Zh7/SMLZ7Hhbea1RbvKkR4UTt77n?=
 =?us-ascii?Q?fab7FHLHB46v7LKkuyN8y5MZqgOSTYkXmB52AuxF3SHD7ZaOZ7QUrkLzceZh?=
 =?us-ascii?Q?bA63X7SMVN5lfu2/FZM42JcrCLWv5oRk6mYqihAsRIYjde9vIC0mh+ZyrjYv?=
 =?us-ascii?Q?wOM7V0Byvv8MnS+64QGcUtXbVGrY77XefzUjOoZJTLbW7FybO7vAErF2uOsp?=
 =?us-ascii?Q?0/rbZwIbUFoTho5MmaTVEXIk8uZ3s9JeKp8wMMdErH4Cj/NJahNArwZJP8hq?=
 =?us-ascii?Q?Et/LBq1JUFN8WJy+kbyFwLWC0oe64F8wirctJKo10kfwYN4xYY0qD2UKbZum?=
 =?us-ascii?Q?Q/6ZTPohXW5c264rJkRtV3Ui9yS8hRjJYVich0grqCb6ldgglYhS29M1hvjg?=
 =?us-ascii?Q?Qc7a6aagUWqdkpCAp6EuyYeTaqQsqa6WGdh1zB+hdLa6Lr1DeUjv7FRS0jU7?=
 =?us-ascii?Q?NkoBUpRxoXlSFIf/6n3SGy+hLCFWevLeRZopnAkV+qicaQFRbrzYi6MT3+LH?=
 =?us-ascii?Q?wxceVet49ix+H9aJMYymQbiuQM1f2b0SXiY5A6Aa+zV9f+meU9sGR/2k42qH?=
 =?us-ascii?Q?eHlSr8e+/OcVNalDfwrThU0W+2cfakztgGE+8K4suWe+wYCZY5a9lSrZxHmI?=
 =?us-ascii?Q?wh81aCAXBh9DAd/jCov34UKA7/PtLKQH4fEXsde7q0BzuRhFokl1G8IS/CAU?=
 =?us-ascii?Q?StfU8GfkEt9RMsiGjjmTe663ka8Sa96Tx5hmRcC8QdOoarmhMoc0R8mg6LQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da3853a-609a-4cf1-8146-08dcc6c2c9ef
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0746.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 18:05:09.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2761

Hi, Felix

This patch broke the MT7610E. After this patch[1], the client
cannot connect to the MT7610 AP on OpenWrt. There is no error
log output. BTW, MT7612E still works fine.

[1] https://github.com/openwrt/mt76/commit/b80c997b3ff6f3e32fd729dc1c97709da5779fa1

Regards,
Shiji Yang

