Return-Path: <linux-wireless+bounces-25520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C79CFB06F8B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 09:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8F67AD9FB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 07:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB7329E119;
	Wed, 16 Jul 2025 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="ERxVZKpk";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="M0tdjYWR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2E29CB5F;
	Wed, 16 Jul 2025 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652304; cv=fail; b=eqYtMJXDWwGvzxsOS4JorJdGhQFw7kHXAPfunI0h40U8LyLLWxM8TXXcvFRq/4UJpzUq5v5gE/0ui4mUVvIv/QpkrmF8mS+z/jcgcGgu/T6cbJo1VGFjp35oOyPndt5xf60Hs15arvyiAH/Zu/+JlkX8iN3UCGj9+v2O5s/50Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652304; c=relaxed/simple;
	bh=4KhdNc5lpOnmbAYuAXLedqYrO6K+OhLQ5AmMwEw/QC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBfRzv7h/5IWagyqOM1fCD1uK7zAn5+2yHWmBE/zy86cNgma+/j8S7xTYNIRUIvXGTVsOf8zwhQIFxaq1DT2ML1B43qDDGIQVuUvYjtAYt71zdNVOfU8Itaadw7HCdwE4omyBL2xypbIHv+ZTSFnUEDTNRAZinPwxQHLQNXDHd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=ERxVZKpk; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=M0tdjYWR; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G7P2Ff1967878;
	Wed, 16 Jul 2025 09:51:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	iXD3LmtUwMfSV0jfNKzGm4jVwwra36GjdAVNKiNOhZw=; b=ERxVZKpkMlOR9vKQ
	9WP45FHdXDGXg3fpAsV3bp1atNrNqk3BAvpnNHVi1rlgCXmnT8oN1ch8j8JSpDwD
	RZnQZWyfeBod8HkibvFDd69AKfk/fzFZVub3wNW1noJXVdgWJS38+G4ASWUMs9Nd
	vKl9FcadUs/Qx2I2YBHVixN7aUdrJVuQfDGYfXcsNcFLw0SVpefqDY8mD3w4XiuL
	u4FhWvtWrGd+v+rw+ubOg4Krgsa3ro67eN+a1kaW48X2gOfoE7w02ISZC8M0G6Pb
	9Khhq8mXdYXtBwaYp2ChnGc78VPX+sH14yfOxXIKnGbqbt9dWAdnvyD8TifgobmD
	xOyP9g==
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02on2117.outbound.protection.outlook.com [40.107.249.117])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47w5js9re7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:28 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOq+VOhWAZZibxUEBkMlzIfYQccJExjF3/ICjZQgU1OqyJ+6qNAcGzUYstO6BSZEe+bICL7Uqc2kgFn6BE3jv8mbhamSkCSjJzNfyS/kxS8i47HFzTHE53XIy64HFNaQDSbjXRoAr7GosfC/YuQC2mmpkn03WrpjdjlJoxklrrSn1ierKJt5c/joFxugnxFrx7o5oC56krLKHtdQrBWxXqixtB71sh3z7kawu8ghTXay/uQijZ48dULYhrlONWCSOBgZu6vof5bwIJyclgrmht6DLYeLiA87UNyhj7q5lsLlAmvKGvhzO9yEkYxV1H9NsatrzXK4GNdqgAub3DNCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXD3LmtUwMfSV0jfNKzGm4jVwwra36GjdAVNKiNOhZw=;
 b=uAe3vmtYbVLzqiapoUGKIR0goaJ9wurZspZ/xIHAd/wIn0op9PwIo/gdZTwEMAhLl+/AzCuA//wiGevXkJRZX1pNy4DtTA2SofxXDT/2aesutVwsC7M+8kT/SDRsGrfh/SlhWD/3Mo7arW/hu7dwjsroAQt4xOuCeARPah2AyS4RvOa0SYHqrLSDlyrtGtfnlxJ3/HK5s+cysONKSqqD1x/Xw36TT/qtFB4YnUqZlF5y1+aelgIpB8TwSlqLElpt3hL3PhoRRwuRklhZkBQ3OLxiSLapy70ptknFBcvlyJaDO57gMk6aB9PAtSUnZSbOaVzi4MUgjuNFxSQijGY0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXD3LmtUwMfSV0jfNKzGm4jVwwra36GjdAVNKiNOhZw=;
 b=M0tdjYWRIjGz/4D4aEhf2Ncb5q8jI6DPVwCTiDqvSYLZWwQBiumvCOYkoBvHf3zd//awNp0WykGz+VLZr2pM8w3ws6cC/ID1I/F7CUL2I+GwIx7urCZvA5ouow88lwnUJC3SVXLHM7r0FHmkT5LvkYDyqfJzkQJVLepifjoI0pg=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:26 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:26 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 10/11] wifi: ath12k: fix endianness handling in QMI wlan configuration
Date: Wed, 16 Jul 2025 09:50:59 +0200
Message-Id: <20250716075100.1447352-11-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0330.eurprd05.prod.outlook.com
 (2603:10a6:7:92::25) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f77dbb4-bd20-4295-2260-08ddc43d9151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x0LgX3BBP+LQgXHI4czZ/5hg9ggsO8ZMnYEKLyYdq3qOvLmYJZaRg0gA/yRc?=
 =?us-ascii?Q?L0YxGhXX7xDoqTfwX0Z5dT8SQgGG5OObnyXrQNsaMawTVeA29hjuJZ38ZpXV?=
 =?us-ascii?Q?PnogCIcmnvER32UkD2HMmrR8+wAZpNI/7Vc2I166u57a30oVAipcXSN4Xs5J?=
 =?us-ascii?Q?zW9E4tK2+l2sFD0dYHxkqZ6CIzizglgKWBcskCeL05CVapJzj2EHfOzKKjxg?=
 =?us-ascii?Q?sOwQd5+hSIGe57Beb1zQFP6V1+vxweITpuLxGun8qheNhI4e2syZPBSnzf+f?=
 =?us-ascii?Q?kas0hvOyeXtL3kEzlgjwlrTaS2gZdEbFfMO/9RODh74boqCQaZ1OGPRDSekq?=
 =?us-ascii?Q?09WM4YTOAO4bwV4SsqRy0ZbmLIbXstdVxSaTG3cBXKidgesVW69QEcxVEGcr?=
 =?us-ascii?Q?JcidVPO1wbU7pKPbYoVNtG8Vt++3BmYSeDNYlLC3Q1z6AhAfiAKfJy4Hjvrc?=
 =?us-ascii?Q?MNSbkS5TOG2RcpKw9B1/5SGqU7fxEnjdT14+lX+I9NdXoq3jev4lXMm1z93c?=
 =?us-ascii?Q?k7Pa1ksXIr18A6hDTy4LOdiMRnRXX5MNA/XCbJewnBiKcRzm79qlVQdllfAH?=
 =?us-ascii?Q?lK3PC5QE7YLdsHledtH0eznxvYtkLQDs3pUbNgOrWM6Vy4EFb+T9jQInw8YA?=
 =?us-ascii?Q?roUFNlVlbKOQswqhLZ3RZ99f7oIGj9YlP3MVebMGKsz9rTutD9O5gmXX7kdF?=
 =?us-ascii?Q?EQ/IxkX2N7txZkU6lJzFxWDA9nfA8dMxYXnalUFsbGHLllEL19GFrbU9Hqyg?=
 =?us-ascii?Q?b+YOisATNAqsVdse0rcAaDNQkl73imaSTf+EKn3sURtUNutyTjO6i6P7/yD1?=
 =?us-ascii?Q?37YWuDcNQVWhl7MP2VBLfrXSkcudhQr7mKMMYABhQX7VMUJiic4PMfKXoD/6?=
 =?us-ascii?Q?KLRYns5QMMSxzrrjB7ckhh/ifWhgXZstNlvKUh0b5184Pof1Qj2tUha1VI1x?=
 =?us-ascii?Q?hpbEfZdP4umUCInSc6S0ns61nFhjTX2YgZFs9YG5QAkxFcb9CqIG1Ros8Hf3?=
 =?us-ascii?Q?r0JjxM2FazjoDVzl1cMhpb3Y3DM1MJvAixCo7fmWqhiaiIK7A/VjU6hqVmt8?=
 =?us-ascii?Q?TB3rRPIDH1KL2v1bVjIrDJqwOAynIiFDdZf4R85gL1lfwScFIDThB5ebdY5h?=
 =?us-ascii?Q?J0eFisUEQdmthV2a7roAZl/AkZKqPErDOuzYX1hVnkCe2dG66mjqX01Wa3wy?=
 =?us-ascii?Q?08LywUMl96F3ujZsxzl7CpmBICVBp+GTYOZG8dFxorj8bbAjNItX9UnXlCYk?=
 =?us-ascii?Q?c5BGE47WigOnCxv8Z+LTSs1ObUzPU542lRAMmez7v4PigC1ugoGGudXYWErr?=
 =?us-ascii?Q?ZuuW1kLR3lLpltq6hoQQ4fGGXjNqmtVEOhAqTr1zpvM9eNlHS2AD3cU6FI/P?=
 =?us-ascii?Q?FgjYFTbg0prOXF4KOFL2KSnaZ+W0fuEGXb+xbm90m4MBg+uS0CVLZxYHo8A3?=
 =?us-ascii?Q?3NqCJn5d7po=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?reZZdCW/zb5c1BCpVSG1RVYNDWKXaxEa0V+df7rPTstCN61Wfp9PJMUFJF9R?=
 =?us-ascii?Q?846GI9O6tDHgffo3lPZN+RfrYzhVEIbYir2jyzNGCoIeXp1j2skrZT3NzNkd?=
 =?us-ascii?Q?3ZLLTW/VXmbvqT/9CsaIkiFZGvLBssXjRAOfOFMCaczDlDJMCVL5Wjx6UOb0?=
 =?us-ascii?Q?DngiiXsPRzTtsZ4y5/m3R2csHobQ+d6pzHoUXiw5mbpwHS99zd+r+rFMDyoG?=
 =?us-ascii?Q?EO5pSsPZpxdTOEMYC1v1AOgsCxoQUtoKEHFNv1d8fAHWx336s2u7BEIk0Mm6?=
 =?us-ascii?Q?29TGgf0rcCdEy8xCZoJUbcTECkGoQveMaet3BX+/wmYhMo/RU6n6RWpEBd2L?=
 =?us-ascii?Q?a7ygbS+7FUz+FrYKTbzZ4pMRJ2nimHNq6Dnmnvay6Vg91ntU0ohK2179PIxb?=
 =?us-ascii?Q?gfFo9FuCoYol8N6YSmaYNCKG8r6KBmrQ5A2DMhIw44G8H9GOaz4UCPuj3oEg?=
 =?us-ascii?Q?Kdk9UYIfueQUwyKucmibrdsnoqNHap6Kj1Caz1NH98y7ptkbexvGh24dJaX9?=
 =?us-ascii?Q?H3sBoCQPdMCtz1u0wUi7iDi2HSZHwEF+U+n2VYe284j5n2ZrjD8bIobqVvew?=
 =?us-ascii?Q?uv0xMfUSbFyIZyyWQ+GQM6GRBkwtvOYSShS+svm4kZ+qnirP3itt7V7YTCxA?=
 =?us-ascii?Q?twxTGit/P9jpWpD5CO7rSkNeEjCHeeAsmV2vY+14xUpUSVGo0/0DqoWnSO4x?=
 =?us-ascii?Q?ladkAcMX3wCw8dZaU+O+PU9qNFRwPeox/M7L+7M0CcJbRdjnqCVRY3CthHFQ?=
 =?us-ascii?Q?xbJAxmVMnDmuz3MP5i4tCfRSugB7IUYj4SCoux+3yJj9sHgzvgzsllkf2H78?=
 =?us-ascii?Q?b4t53J4zI9Hjjpj05izr8n0QfIm9ZKPe1a2r7K3y8niWUOFWLUI/KZzZZCT3?=
 =?us-ascii?Q?kzWZHG6g2DqW6xgrCKdR2HTZvB6twP1/X3FhaUeg9IcnJ3WBU/BZo/t6cR1v?=
 =?us-ascii?Q?Er305rLGlZsyBnMAcPDz8wcw9uqL+H/P2uRaYf2JtP7lS50gzrcdwWDwc0Sw?=
 =?us-ascii?Q?LolHBhpv/WoFie27raLo9t9jHTTsJ8HEOgD6kxI6tkp2Aai9aIxZN1CdbYa5?=
 =?us-ascii?Q?TkuzslW2aVVer7UUpF2ZziJC/Dx3aPOq8aibVVcl+bwyUbGWMikLomSE8cc/?=
 =?us-ascii?Q?i7eoP4aXKQJjarIjTCo9N3FCV3Le4Wd5JFiK9v6RyzIvFAANpem6Z/rdS3OG?=
 =?us-ascii?Q?pXpMFHr1y7mewxbDJ2PRYw9d9UY5V8uYnEa7NgRzAUK8lFcvLmh6xSHyYdFi?=
 =?us-ascii?Q?jQR3KIPXGI81JuGebx94gc0zztg34oxEzJywm8Yh15ZfHrkJl4EmX+iNKvTN?=
 =?us-ascii?Q?DW24my1F4lO8OwpLTpBR1hgsQyrl8zMHC7OsYjbHzEmDcvNNi8gd17XOVMha?=
 =?us-ascii?Q?t5BJ1YNBvINyQTtTDqpzmUonV7bUFLCZI08pCoSqR3mM8jyNVFPGBTPXBVxo?=
 =?us-ascii?Q?1i4Xi4pHW1i00f7Dtkb77mcqZ0X08rFUKzEJIv0d73YxHm0OlyPMFdfJkK10?=
 =?us-ascii?Q?3o3LAEYeMTfz+bE/SlpP7W0hBOQdpwNeYukdQFQrRmTZRV4gXF1ep/Zg3GhF?=
 =?us-ascii?Q?MGK6jIVhQUnT9D3wKQ9YCTGt+sJLdKMv/hd9CNpN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ASi99klj3uIeLTBIb3Xnm+yaA61mHcWW/xOA8aZXMd2FQQLoQIpsSXIlaSeoUWKINjwke8qBkfYiVlVOjM42NnH4l6WAhJ63GCSujbMpe9NErSks/1knxpFygvn/DB4RW/bhNGWJpdJKE2+Wlx2UPzoE61i6mazi1klp5qAgmmp72bZn3q3PcVdYDBh9UHPDC/41EbkfAI4r9mr12JzaOMb6xUvJiov0AEtzPZlDXjoAbrXPfy1wqm1VG7a7raxPK8KmHuDjFddoHlE2OFsI01emDs/QhK0YDzupFYBKkk2exuod0Cb+sU4PumfA4TeVA+jXzDL55cLrL39d78hFRKLi2VTagOZcSxa7fyvjpN38cyMq4avtyF4/qVfVTTNhnR1KUx4hF7IcBf1mPPeTgjl3DYPsqgdAXKBjkaYYQzlCaIwA1mfVVnA5WQJQkW6LmiNG/wMRWX0gKJhv2wpUNAfzd+fFEMZhhzmMbucCJt9pGMmrXjVXAw/kMgOPuUotxgxWlIwQpDzUe9LBKU9rOmxajLVNjv74gAJ0zFBu5lBsgqPTB0/cByGcZTY7F0D73q74DwGqP3rBIvSLVJ5kJBYtkxwNz5xi0tOSDmfISWn/yNuWeWHdJiEaWQmRUJWU
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f77dbb4-bd20-4295-2260-08ddc43d9151
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:26.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCeWgv84hWpP46urH1Bj/NmQQEWeU478neSSsHtms0r5L377kAbkDC8VYYo2pRVb2NtJRtnoMm8DmrO3KGPm+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP192MB1853
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: GVXP192MB1853.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: PmXDUNGVlbCMO_Z8Autjie442rhlxw-w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwMiBTYWx0ZWRfX+q8TPV1fdEIC
 F+xaReIkr9zAhKThFBo9n9RU+tf3isY4H7/suaiHy/wr4tHx/AgESJf4MBjbtNXsLYKyX6YrMR4
 L2ldQNcrqD+7bmkn8nMyAwe+CNXHRa67Gpvd0Pc+cKQYhHW16o0qsuOl4SfASLp2N7B6fSDm58A
 WS/hsajJt0JfgzWMEUrTXOGogPFaB2J/IWtelRjChZVBqbUC+LRLJ3NGr+z4TBBwQPnijUrIz6T
 WCE4JDzPpHAi33xSgr+5ADievEFtgZwa/u59c3TBJ6YzwiT0jnQpdNCIF6EW2VMMMFsw1Wo8C+i
 Z+rQ7CSc3Bf/zFWkUihbaHIJ5A8Kq6JyBfefS6SF5NkLYuzl/6PyuPOd5gIZc0XFqaZtfNtrkJh
 rDmfLgUZ
X-Proofpoint-GUID: PmXDUNGVlbCMO_Z8Autjie442rhlxw-w
X-Authority-Analysis: v=2.4 cv=Nf3m13D4 c=1 sm=1 tr=0 ts=68775a00 cx=c_pps
 a=FTvBPcilzv59yY3GK08+0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=Fcvcvy57vIv4vxiygTkA:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI firmware wlan configuration request message and
its associated structures as well. Add missing byte swaps wherever these
structures are accessed or modified.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 22 ++++++++++++----------
 drivers/net/wireless/ath/ath12k/qmi.h | 14 +++++++-------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 2fdd5eb128d2..71cf6408c6fb 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3291,7 +3291,7 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	struct ce_pipe_config *ce_cfg;
 	struct service_to_pipe *svc_cfg;
 	struct qmi_txn txn;
-	int ret = 0, pipe_num;
+	int ret = 0, pipe_num, sr, len;
 
 	ce_cfg	= (struct ce_pipe_config *)ab->qmi.ce_cfg.tgt_ce;
 	svc_cfg	= (struct service_to_pipe *)ab->qmi.ce_cfg.svc_to_ce_map;
@@ -3306,8 +3306,8 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 
 	req->tgt_cfg_valid = 1;
 	/* This is number of CE configs */
-	req->tgt_cfg_len = ab->qmi.ce_cfg.tgt_ce_len;
-	for (pipe_num = 0; pipe_num < req->tgt_cfg_len ; pipe_num++) {
+	req->tgt_cfg_len = cpu_to_le32(ab->qmi.ce_cfg.tgt_ce_len);
+	for (pipe_num = 0; pipe_num < ab->qmi.ce_cfg.tgt_ce_len; pipe_num++) {
 		req->tgt_cfg[pipe_num].pipe_num = ce_cfg[pipe_num].pipenum;
 		req->tgt_cfg[pipe_num].pipe_dir = ce_cfg[pipe_num].pipedir;
 		req->tgt_cfg[pipe_num].nentries = ce_cfg[pipe_num].nentries;
@@ -3317,8 +3317,8 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 
 	req->svc_cfg_valid = 1;
 	/* This is number of Service/CE configs */
-	req->svc_cfg_len = ab->qmi.ce_cfg.svc_to_ce_map_len;
-	for (pipe_num = 0; pipe_num < req->svc_cfg_len; pipe_num++) {
+	req->svc_cfg_len = cpu_to_le32(ab->qmi.ce_cfg.svc_to_ce_map_len);
+	for (pipe_num = 0; pipe_num < ab->qmi.ce_cfg.svc_to_ce_map_len; pipe_num++) {
 		req->svc_cfg[pipe_num].service_id = svc_cfg[pipe_num].service_id;
 		req->svc_cfg[pipe_num].pipe_dir = svc_cfg[pipe_num].pipedir;
 		req->svc_cfg[pipe_num].pipe_num = svc_cfg[pipe_num].pipenum;
@@ -3327,11 +3327,13 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 	/* set shadow v3 configuration */
 	if (ab->hw_params->supports_shadow_regs) {
 		req->shadow_reg_v3_valid = 1;
-		req->shadow_reg_v3_len = min_t(u32,
-					       ab->qmi.ce_cfg.shadow_reg_v3_len,
-					       QMI_WLANFW_MAX_NUM_SHADOW_REG_V3_V01);
-		memcpy(&req->shadow_reg_v3, ab->qmi.ce_cfg.shadow_reg_v3,
-		       sizeof(u32) * req->shadow_reg_v3_len);
+		len = min_t(u32,
+			    ab->qmi.ce_cfg.shadow_reg_v3_len,
+			    QMI_WLANFW_MAX_NUM_SHADOW_REG_V3_V01);
+		req->shadow_reg_v3_len = cpu_to_le32(len);
+
+		for (sr = 0; sr < len; sr++)
+			req->shadow_reg_v3[sr].addr = cpu_to_le32(ab->qmi.ce_cfg.shadow_reg_v3[sr]);
 	} else {
 		req->shadow_reg_v3_valid = 0;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index d05cd9b47911..37840d015a5c 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -406,12 +406,12 @@ struct qmi_wlanfw_ce_svc_pipe_cfg_s_v01 {
 };
 
 struct qmi_wlanfw_shadow_reg_cfg_s_v01 {
-	u16 id;
-	u16 offset;
+	__le16 id;
+	__le16 offset;
 };
 
 struct qmi_wlanfw_shadow_reg_v3_cfg_s_v01 {
-	u32 addr;
+	__le32 addr;
 };
 
 struct qmi_wlanfw_memory_region_info_s_v01 {
@@ -565,19 +565,19 @@ struct qmi_wlanfw_wlan_cfg_req_msg_v01 {
 	u8 host_version_valid;
 	char host_version[QMI_WLANFW_MAX_STR_LEN_V01 + 1];
 	u8  tgt_cfg_valid;
-	u32  tgt_cfg_len;
+	__le32 tgt_cfg_len;
 	struct qmi_wlanfw_ce_tgt_pipe_cfg_s_v01
 			tgt_cfg[QMI_WLANFW_MAX_NUM_CE_V01];
 	u8  svc_cfg_valid;
-	u32 svc_cfg_len;
+	__le32 svc_cfg_len;
 	struct qmi_wlanfw_ce_svc_pipe_cfg_s_v01
 			svc_cfg[QMI_WLANFW_MAX_NUM_SVC_V01];
 	u8 shadow_reg_valid;
-	u32 shadow_reg_len;
+	__le32 shadow_reg_len;
 	struct qmi_wlanfw_shadow_reg_cfg_s_v01
 		shadow_reg[QMI_WLANFW_MAX_NUM_SHADOW_REG_V01];
 	u8 shadow_reg_v3_valid;
-	u32 shadow_reg_v3_len;
+	__le32 shadow_reg_v3_len;
 	struct qmi_wlanfw_shadow_reg_v3_cfg_s_v01
 		shadow_reg_v3[QMI_WLANFW_MAX_NUM_SHADOW_REG_V3_V01];
 };
-- 
2.34.1


