Return-Path: <linux-wireless+bounces-26611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C68B3556F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 09:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478121B65AAB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716F2FC896;
	Tue, 26 Aug 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="SmDKUu/G";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="CO4hajKC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E52FABFB;
	Tue, 26 Aug 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192841; cv=fail; b=ct+xCOLvI3N/sNrU3yhiS/hSE/GR0L1G38HYMjNx0jT+kr2XNXWa+ubiqR312Ud9KJPcJGLZ+1vgDTUBFwErg0GwQj+Xij+sMkAhXwn6dRhALWimdcvA2MsJ6cXQMU82PGx926g4iud9dfNeVeUu/zm1e/1nS5i7o85KaJXWZhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192841; c=relaxed/simple;
	bh=C42kshcE4d6VT0ayRkknPi3WTeI/QjtWi9GpIBHxM4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kj/0E63XI4PGwpIeXqlnprO6d8QjuNTBKiTeMhIbdlYnOu3rFA6/ZieOKFQjaQLa+TsCRmuKJfOkrortn8MJqCs+o+E0gsR292OKXE8eUyZL9cRbnrcjzI3oUX+G0DOfO7M81FkvnIKB6BvvsmAeShbN6o00ZX9Xdq8RylrsQXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=SmDKUu/G; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=CO4hajKC; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57Q4seTp3423421;
	Tue, 26 Aug 2025 09:20:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	5CKo+1iA8KjU9U5EoBY5xQ8dTS13RVqxkFp5TlHQOGs=; b=SmDKUu/GOzVuZFS3
	VznMu/Mej2OsxiA261EGSRlugg6B6PYn60Kr35mIP2Bh2cd4pay/uJ26UDwkK+Mv
	PvPW3OmwKkSGWmG2oo0OsjyxZHNYfDKyeUb5HqzTUJpspBZbNxFm25lZXG5sbjaH
	rJYsQjmNP1fqeSprl2mVyhHQq+9YKrn1dlptR+XbdlQz0kqM8/K6DDqSBnSDQIkN
	bDSGTGpu/dMvYnbEjtLGfCTDyGd4fK45n3i6SpktbwgSahKme8iCpnVpxBt7c4zX
	hn9oo+8q94csnpu0jrTRCZgD+XICrJb4mNr27cl1ssdoLwR/AIQW9ZdMAGb+rA9m
	r1jwtg==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2106.outbound.protection.outlook.com [40.107.241.106])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48q308ag97-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 09:20:16 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7PV+ZYle4ccHlkSciXDYrE1llk7vKTlo8iHs5JuGdrGj9aZVj2IxnlIjli+OX1/t8uqNIZUO3u5aQySRE/FejMp/F4PZChyvF2wA8zLsobkUuORG5LZXt2WflpSbn4GvxrkSwlbyjpHMCSPbgYUDP8BFvmjLmkR1YvhHu752pd47+HB6M2Rhl32YfjYwq8WBb+EUDDm81+L7fX832G37hb9DL+SIyAn+uyltgUWx/1nQAe7UJrdQptC6vAiAMh/5gX5e+7gST6qb82Wjev9cc6pz/BwD0IoDdgHVoWU4vkpGoxfo7sWc1iVi/TXFUBLlhplJ3JghDu7p622IbFXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CKo+1iA8KjU9U5EoBY5xQ8dTS13RVqxkFp5TlHQOGs=;
 b=Fue6rQEY7ZIKKGRn5NvfR1UJA5KNNVqJBC6wh5h6ihV6vknjI/1rfsPCb44StGg0krPpERh5evvfQ6l3m7jUfO/E1zDgXcPaZw/XeUefEn+LyYEXHsBP+6D8kdCQUVSs9cwckTpOibCAhB3C/I3aIu4jmbcywS4fK/e8RuNhyL4PGGO5VVd3zbyfYZfiOCQjctFKZDxq2YRhlWRrpyjBCkZSM273YADdMX+jg8QJMvkkhyc42X6K7bCGTeyd4Wlsey/s/jdVOhZsPbt68irXHS3WDjWLms4NDJY+VPtf/Yijm6RdOOq7PShv+cPOS6+k0TjPzmrjYHw2TljKvjwbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CKo+1iA8KjU9U5EoBY5xQ8dTS13RVqxkFp5TlHQOGs=;
 b=CO4hajKCoxDmiOma8cEMdF4+Uzi2tZfbXB9ZqDL+KE4UNLX/M+In5XVIfH91lFOgZGWZxEwlH68/vHDMhvED/dR7kGA7V5cFAGaSsW/ddxSKGZT3gajSGiRtwz/MM0HJJFYHVDL1vbyz845pp1JdBPA43U6T976ZK2oBRd1gw+c=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DB3P192MB2107.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:438::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:20:15 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 07:20:15 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 3/4] soc: qcom: preserve CPU endianness for QMI_DATA_LEN
Date: Tue, 26 Aug 2025 09:20:06 +0200
Message-Id: <20250826072007.1395416-4-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826072007.1395416-1-alexander.wilhelm@westermo.com>
References: <20250826072007.1395416-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0131.eurprd05.prod.outlook.com
 (2603:10a6:7:28::18) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DB3P192MB2107:EE_
X-MS-Office365-Filtering-Correlation-Id: fc464f2c-101e-4a54-3731-08dde47100ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AjJB3LzZv1t2zMJY0INoN7Mur7MyqWYk4iBFqcVSWh3BGbXpzBnQf303OSa3?=
 =?us-ascii?Q?x/A7z8ZNTPcMwEMqzWHGB1mRRXe1YUH5XEv9ZPmndzPpl2vhNe7YAoMeVRQX?=
 =?us-ascii?Q?F1cIis+Iivr400rDuA6cPbh+BWIYYi+IZ52sYf0V+b45gPNsHOM+J/vwcSic?=
 =?us-ascii?Q?oZ2CWlOTnhCKPXPIzdRN8weey7V3V+TA1qnG6b1al6REGY365UyuHZleA3ts?=
 =?us-ascii?Q?KxNR4ZM0YpzNnlIipP/g7kFWy/WFHVHo+i7tUVerQ57YDaMuVIN+trJr+ZDY?=
 =?us-ascii?Q?ifurtBw/6FSAkzENJVOLtrCYtt88PtO9AjQrL6FDzyQurxmCstZOteMN9+H9?=
 =?us-ascii?Q?iCFSdB2y5e1RS7l7UoQwzcct6QvgMMk0NOZql5KG4plBV/DSNtGXLjw2ZRqf?=
 =?us-ascii?Q?K6xyFXBjXMLeQ9RGNqpTlgalpJm11FqPAyOEglEHloQSN7GswDdjbtQqLYmt?=
 =?us-ascii?Q?EkwLp4VN+o0PgVs/MqO7Uu9hppCdmWF7gGZr+TUGFUlaWk8m7zXRvyigmHST?=
 =?us-ascii?Q?COB5L6Uc7suT1YGxN200pFaHs5vhSqm33MB+mEh0FwRW3Ale/OOyh+wZgOkq?=
 =?us-ascii?Q?NBm+PLbHPUay/DRONBRtXox7M9ui+KkHoh1ELTsT3O0Uu6PJcAGmrhiiDyyq?=
 =?us-ascii?Q?WlDU93Ct+Tb/RAXTOAGXobLlcUbzdPpEuJuOF5MKYLMKVSpuz80Wv21CwQQM?=
 =?us-ascii?Q?sPoIgfXqW/RghUBn5A4mGTNsycS240m2iPuN5MnFr2TzqF9G8FxxupuPcx97?=
 =?us-ascii?Q?2CnfzR1VXAf6I/skM5GmewyvjTFu1VJZ/58cr1E25wWoYgPXpk0TCX496eE+?=
 =?us-ascii?Q?BDWQcObk7OxNPQEhoOjavNfdYlHVooBHkHBIg5TjYc8WmKvEEckSV9OAMdDn?=
 =?us-ascii?Q?7IP+uXPhFkSexx4FljZF7PmvRStvL6cOXHBYvExP0f4IIuCTliIeLNDqus/R?=
 =?us-ascii?Q?wEsH5ovvq3+z2Vz+U59NnrrGPslthem+U23rqavcCx50EDBZD4DGntWicZ95?=
 =?us-ascii?Q?q9GA/S2+5zL50nlVfkOyeo2NBDHIzMWbIxz3A4EUpJWGmTxNrPYS8Lu7HDS2?=
 =?us-ascii?Q?mUuBUf7zbbBYTHXlulrKB6LjKCPZdwed3YoAi3L23ehPiGGjDD5guWL+5hoA?=
 =?us-ascii?Q?2r1eU9turvX5p6TOk00ADPhSrZPhGSPhp4/+cPO/zjDMIPx2LcqsA8VcUTm6?=
 =?us-ascii?Q?FzVgID7pgJuPuNDor+UD9/+bL6qMSybi4jEP+82bSEE+XOlvCckFwbqivvs2?=
 =?us-ascii?Q?vLI4D0ANuG9W9k05lE1eVXeU1NOodeI6JgtjAnQ15ZyvMoCRVsStQUp08OUL?=
 =?us-ascii?Q?BzRe6NwJ9cLZ8q8eahSHaw+mLqqfKj2WrXXRLq1hKGKeHEWhp2k4WlgCydTp?=
 =?us-ascii?Q?4iENGlVlX9KpI6efp3Wdmfe2KVF6ZqtseF2LM5kicvShHmy7uG9PGwR27TG0?=
 =?us-ascii?Q?SoEIsDt0xxI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w14F5duWygr00R+bBJP3xtgGBO2jrWJ7IBM4IJ02AgBaCCxfUk2oTxCsb6l6?=
 =?us-ascii?Q?8xhkBByj/6SQlAxXirYQ997X93gJfWUVgM3mk0w4/j4UB8DCequWPmpfUAaO?=
 =?us-ascii?Q?GAGPkZvwdlSKSjnNXn8yWRV2AJeewF1uzNpCntLe8x77+AgIb8KlPwBJsiXF?=
 =?us-ascii?Q?12rH/weQCzMLHrYVC2fS7JLnFeVx7BOkvjZdaVRr1JlQmJzGLcNJLNptNzin?=
 =?us-ascii?Q?XFC9/VJBDF5JTME6V/ZLIdDoNv9AkeMa7Wurz7P8OwuT5G3p0A3MdtdQNwhb?=
 =?us-ascii?Q?8ywbwa9549XM7ba0zq1ZPA42W0J7QNK6hECu+ucFNpePl1NpnZq1+kaQTn09?=
 =?us-ascii?Q?BxOwN98quGQlXmhMhUhbxxF4cN+eX2gmDBHFTGfoYySa5hhO2cMq4IcRqdah?=
 =?us-ascii?Q?ApZ6l8WlysOpErzg1X7tDpFr3AjRDIO56B5lSV6eD1+ZQa05G4FVG+KWfLQm?=
 =?us-ascii?Q?Li+HVyT0oZr0c6aXrw5VKCB9ql9kbdTLko0dZRo52Dkey5lrIgxrvlaMjYoC?=
 =?us-ascii?Q?Ic76vnvoJjIHHpheszn5oRNhEEeFbgW6ZZVA6WZrAmL8w9oM7OTIUi/zwhzO?=
 =?us-ascii?Q?fysoO0pQdPYFfPD36p75wc5nBoN1JWng4dq0k39ED/82dK/naIhItUUN0YZn?=
 =?us-ascii?Q?rSVMCz15b2ykHcNh1uYKsXlgmf6QHi9U/l2owF0oAfDP7U7tfIOpwPl9QoGs?=
 =?us-ascii?Q?ORqDMQguXDNYyPCc/4H0RvWgwaP8rDO89qwcXtAc4jkQj+XwY4UyFbkRAvAB?=
 =?us-ascii?Q?1OM9vdfw4WmeD60QILcc/HHV7RUlieHybF7s4PpWixPLoXgJLYjoKojVKoLl?=
 =?us-ascii?Q?8G/IgAv8Jgxcp67Mgj6TbG4K6v8m5o97Kf3XKED2vTj6scAQP1Lee4dVNWky?=
 =?us-ascii?Q?iGFw1aBmJBG3rv6JXjg0gvd81mjGmdAS0mX7F3qiXXhs7gW+aFnAN5/AgEo5?=
 =?us-ascii?Q?o9qUpHurEn4SLuEf+VR9mXYinDx4MS3KFIEKHeBw4olT53ka1KjpHRNZ0dgw?=
 =?us-ascii?Q?n0+ZIg6qZbMqf3aczJ1dtApLcb7aglKgJge5kmJVMk22VpOu94oXVvsb10/Z?=
 =?us-ascii?Q?2QYEussOJyyLdit6ATi/b+vKSMWU8k+rjW8+lJsBE95ylCt6VrK3UhCXtOm2?=
 =?us-ascii?Q?yc0eUfzSC7Vuszvg+iOvzGZOXWAMS5QycX2NTflOdcDXw53jisiAij3dDHti?=
 =?us-ascii?Q?OpuGthCh+7YAv7tpDcLkkIhL+QN9aTruC5T+ocaPy9A0y7l2SI16TPNJzNdq?=
 =?us-ascii?Q?LL0Hj+m+j0YpIktS2iXN0yPpdfU0krYUE/w3PKMWGBDiYI32Bm8J4iVeB3em?=
 =?us-ascii?Q?voQ7ETgXKU+K26Vgh/83VQRe2RmTy7KK21eQMhRm4/x9m1UC3Ps17lEFcN+O?=
 =?us-ascii?Q?rNWRWLrDDxLrM4zEAxzu7zleNhNXxysZP8tJZ9FP8EAUkgvXCCfqZCqC+LxT?=
 =?us-ascii?Q?A2dOkSwHSIOGvfnSlv8CGDkDn6fLQm86hbzddjq+GYRLac9XdR9Y93NpIdCC?=
 =?us-ascii?Q?YhuJUWZlHdTtRCNE89uxwBHrzfoGCqeSS/d+2w8Xg0q4Mc0xv6vrSY1HrJ3/?=
 =?us-ascii?Q?8fbv/vGRC7pFg/fZ4K4la4vrVa5PpOaqdKYs1Yok?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GC0l5H4o1zbPhGkcd1lXSpMsVkv3mxkxCKZYrBb9oZ2GJH2UjlmTpqjmYFs/pNfFx7hErro/rXiIdiTWWarFFl7UtGYNV6GRSEe9/IJiCX8M89N2NGwA31oqu6jJaD3bhiCUvGp3npTr32Ip5pSTfQDXnAvVQ5GYZYLagMaGUYtnam9zcGxzgSGWWIWQSdXHs28NxkWQ6z/ckBKamjxK6yEEtU69nQ/ytN8df3tsCO3fXq8mvd0DXnENqK2CCbWCiRrVDN2H5w9gfy1r9l7E7h2X/Lqsfwuy2QEcif6TmZ+oPjS5AjBOtfQheH4pm+1/Ik3QUYqMReYuGUJxH/luhNcu2OaPM32Nr/9FDiScww5vOdtjMRHG3ZPLllyQe7IFRUxWRHltYP0qqJSmWPXA7uilmeTnWYuHjiNTg58qJTwVipBXEl5Qs1YYfNDU9d24JFEgaz8ZIbRDnKf9/fpI25xlFa5zDm0QV4f3Sy/F9MBydCbHH6kkunXJQCXdnSCOmIwNU3mUbo8K5LE8RTgeZPxJHqrf15FIbC+2cAwxDRbUKr+KIROLNz+K9VpySjJ6QtJUhwbLh6w6UZBn0yjJYLUCcR4J7LN2/yEc5h2akNshrPvN6ggf3/WZxAK7VF2U
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc464f2c-101e-4a54-3731-08dde47100ab
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:20:15.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huWrx1i5JdOMo69neGbWjQiVE39JNuVidMdXYQPerPpn+TqcQEUFoNexB3aZIbG2eFNJkgwhm+BAjP+Z2+P6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P192MB2107
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DB3P192MB2107.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: vH0JMn8YY3_I4H3CmDUgsMculLaDb6d1
X-Proofpoint-ORIG-GUID: vH0JMn8YY3_I4H3CmDUgsMculLaDb6d1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA2NCBTYWx0ZWRfX9KquUEO7JyPE
 i8Dy1M00qDtEnhISYhiphd9giu2kEYhCfRR3E5RwAFQMgYqZMU1KON7WttT+4nzmOCkMiDomWJF
 FPKJ7X+xNwdZJ0ql5JSO7zY9LKoXpXviTdNyXDPs9VwU5SDGwXPrxIC7cq8ffhKacZbRYbSZtlO
 4pglJenEA9ZsXhWZ5djfKJDbJuunGLtM5GHj0z7Fs8lk3RsJt1vSycK3MRQcjJXL+QqEvFciatm
 ji7hH0BS6NiiIlcr0pgdrAiYHe+9/Z6/ekAvbLG4B/QfiJAk+X8UIXSV5OtekmuLTilQ/bdC6CO
 SCXt/NDsVjxkJrVeaxeOFE6mNguhaLlbcgH3QHH7BIjZKAGAeMSXJJkNWPBebI=
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=68ad6030 cx=c_pps
 a=K3gaILMeFwxk5q8MGe2HyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=T0L45qBzl8X6T0AR6ckA:9 a=PZhj9NlD-CKO8hVp7yCs:22

To ensure correct handling of endianness in the QMI subsystem, the
QMI_DATA_LEN field used in host-side drivers remains in CPU-native byte
order. Remove unnecessary endianness conversions, considering that
QMI_DATA_LEN is always of type `u32` on the host. On the QMI wire
interface, however, its representation is variable and may use either 1 or
2 bytes.

Fixes: 3ced38da5f7d ("soc: qcom: QMI encoding/decoding for big endian")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/soc/qcom/qmi_encdec.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index d8575e92dbf6..01f7045e91dc 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -365,6 +365,7 @@ static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 			break;
 
 		case QMI_DATA_LEN:
+			memcpy(&data_len_value, buf_src, sizeof(u32));
 			data_len_sz = temp_ei->elem_size == sizeof(u8) ?
 					sizeof(u8) : sizeof(u16);
 			/* Check to avoid out of range buffer access */
@@ -375,13 +376,11 @@ static int qmi_encode(const struct qmi_elem_info *ei_array, void *out_buf,
 				return -ETOOSMALL;
 			}
 			if (data_len_sz == sizeof(u8)) {
-				val8 = *(u8 *)buf_src;
-				data_len_value = (u32)val8;
+				val8 = data_len_value;
 				rc = qmi_encode_basic_elem(buf_dst, &val8,
 							   1, data_len_sz);
 			} else {
-				val16 = *(u16 *)buf_src;
-				data_len_value = (u32)le16_to_cpu(val16);
+				val16 = data_len_value;
 				rc = qmi_encode_basic_elem(buf_dst, &val16,
 							   1, data_len_sz);
 			}
@@ -664,7 +663,6 @@ static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 	int rc;
 	u8 val8;
 	u16 val16;
-	u32 val32;
 
 	while (decoded_bytes < in_buf_len) {
 		if (dec_level >= 2 && temp_ei->data_type == QMI_EOTI)
@@ -712,8 +710,7 @@ static int qmi_decode(const struct qmi_elem_info *ei_array, void *out_c_struct,
 							   1, data_len_sz);
 				data_len_value = (u32)val16;
 			}
-			val32 = cpu_to_le32(data_len_value);
-			memcpy(buf_dst, &val32, sizeof(u32));
+			memcpy(buf_dst, &data_len_value, sizeof(u32));
 			temp_ei = temp_ei + 1;
 			buf_dst = out_c_struct + temp_ei->offset;
 			tlv_len -= data_len_sz;
-- 
2.34.1


