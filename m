Return-Path: <linux-wireless+bounces-27430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC09B7C7E2
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0191188DEE4
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667582D63E2;
	Wed, 17 Sep 2025 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="BRjIC+bp";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="g8HI7SLu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB026F29F;
	Wed, 17 Sep 2025 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092701; cv=fail; b=A4Iw543nQ8hbVZI8ivgpRjRc49GkbSmWLmeUqwWa3/tsQWb+DqHZUNWI+a/8qmbZXxYilY4y6WluZi1s0ac1r/payx3n3N+3k1Q7BFIjQrXd6CLg18UEjnafoCiagJcw1QtOmWGmWigJjZjWvZj3kGEimRcagfmZ6M3+jK4CFtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092701; c=relaxed/simple;
	bh=4AqrnpJQRS79PeVXPyA/JAWu4Nz+cLwwCe8Y4aSkNxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=is/EncFL2TdmdO0xgtRuOR56R3ssjP+nE6xLzuISoDb+wunCrM/ZQsG+uN9GW+elPl2/5wB7OXNK3ZX0Zhj85zwIvb3AdyPFIXCtF5g55Na6LRq/XlE0Oh675OutCtGiH6IQDGKAP8YGsDciTwvSiXUdnEcfFbIQrQ0B0n49WbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=BRjIC+bp; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=g8HI7SLu; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58H5U2Uw3493535;
	Wed, 17 Sep 2025 09:04:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	H8rISTCAhJzNIwrvFwzXkmbp9aO+gihj+7pAxjgjijo=; b=BRjIC+bpGX3FDXTF
	9ykNwi+0TG6T0Tmr5TBAJzzF3BD3kyuGiHqLCku6rQlRhzrPZjxuZmEXGeG8Gnuj
	RKvPNuui/v82VESLj6yAMfB1dREVVZSuXBhNWimEPhpcQDEhfDhpAphWEKVtGpwA
	qBQOc8Q6cotrHopTJQdio8eLunWDWYGYjSSJWV/iWHNikPiBDtPG+CoeswLTJmT1
	Ijr2XuxwhaQAzL+dUM5D+6r6Q0cJX27CatIhXlGv49t6CCD+nLnH6vOmtc3UCyEK
	zmWJJvdWj5VKSh6bMHrX3gvJExyLLD2JI+avYEwvEpr6uQvWioRI5ATGAgsMYf9O
	su519w==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2139.outbound.protection.outlook.com [40.107.241.139])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 496uxd1gae-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 09:04:37 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he8ZP12qKxazdKCD2b0tRyxGjf8ys/PZkmN6YNyTv86kMrgLIRUsX2vbxb6/ytbwrkAGqGfKYeBcYUm5QOCTQDsEZV1HlRwjlf6Dc42S+6bpPQuAvvbW8h18pXiBCS00nYYu9F4tfcJcjejrwGK+nXR/0FGXeq++ILFZTx7hNvksZ/lPglsh1+jqNlZEFwgZO3li57YuYItC+8uhevH8BWq7qYJ7gtl5jTcJveobPBRM6YPHGPCszDpWKMgMe9fHQYN55/G1haPapgb7G8wfWANdNyf2HY1Amr7iNOLZziovZqRHKYPkVHfaI/HPSYuohXYmuKQMNRvfpjZM2pcXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8rISTCAhJzNIwrvFwzXkmbp9aO+gihj+7pAxjgjijo=;
 b=hn3+mljwMswZQOHE+5bwOOZ660d+eqUnABXO2NRwRP8usNwbwrTzamwHPTVsUgzm/obfAVNhzO40CI3GWJr2Pzt+wNK/SFtjIJvF9DQEvPWk+ALpaVL3qEf3yCu2h20FeVJYTt3rMK6SyMrf3cnB2VafP+81TyLEBnwM0Den0G8QEtqBqDRLuuPV1HMeFZDIOKt40coVqfgVoEiQgN/UXHZDjjQ1cCtfm4sDrTTJ+5hvTvXRTh7ozeLekFwZfe0AtvQrV1I7fx2FZAxm8r5SBbDBAkaxFY5eWAvDb+sxsnr/ygs94qLypSsHNL04ui6u1zELhlJAxFCBBJ6q4mIIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8rISTCAhJzNIwrvFwzXkmbp9aO+gihj+7pAxjgjijo=;
 b=g8HI7SLurhIPekcgop/FuYMLoWak8YiP9PCUJ8bP7O9bFeu3yONe+3adMCxuu4IdlXbJvr7wsbuEc4OQy8ACbZ9+HSnOcaUJri+6VieIE14V4XrD75Fo5a9Z1LLcGOOiTqdNvLuZDxsxL6GDGU3FKGF7iJKHCVK2C1fGKFzaUkE=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DU2P192MB2171.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:495::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 07:04:35 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:04:35 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 RESEND 1/4] soc: qcom: introduce generic QMI encoding/decoding macros
Date: Wed, 17 Sep 2025 09:04:24 +0200
Message-ID: <20250917070428.2909-2-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917070428.2909-1-alexander.wilhelm@westermo.com>
References: <20250917070428.2909-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0012.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::23) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DU2P192MB2171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5104b936-d691-4439-1809-08ddf5b875a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vgRpciUjNgL7M1emaSKIx3lrO7ORI9GBfTuodv4xo1Cdyfqu1mNzA0Bq0fgK?=
 =?us-ascii?Q?IcIyT9uwCFS+d6r/SVlWx6uD7X7P19hos7iKPu/uz4ryhdv9FM+n7oURHMjI?=
 =?us-ascii?Q?Q+4tajtWbBaayZ4JG/A6tHPra3pAXswQ5rk/suN4YGCmqKr2pbT6YFaWN+Fg?=
 =?us-ascii?Q?WEh8jggDmpRMi6xDibh6kFipPzodSjDtXOWUBmxa60dAocZ/s0zP4rVPiAit?=
 =?us-ascii?Q?lcLjqXcd1KiJFQ+n01TvHJoc67QCB6ziditIxNIQ/SIlzrBVnhI3ITHiOnkP?=
 =?us-ascii?Q?4oiSOEb4l5B5k3CDMgOatO5pVmJM6OnKm9rs+bX1HDWOCcMXY8vIAInP0mPp?=
 =?us-ascii?Q?o96tRTpzb5Veajo/xZ+Uqu0jL+k+H7wDp6Ad+wFOtxFpDxYUwC8eSpJ93YIk?=
 =?us-ascii?Q?vIr37YR3Y+lKqrRflL47kc3TLQlyCZKIV5Mnu4WRch6ud42cg3lFeMVszh0y?=
 =?us-ascii?Q?Eu+xFFnN06dE1Z2Yow8ViMNd3fn5JM9hICofxAmJr33QvfEFk9KTlllGnBmz?=
 =?us-ascii?Q?6dT+2cjAuTP7RcX5Ju1dfl/XLLJaBVsJ1JhOVSWPGW5F5LvvIsrTHFwdkfqV?=
 =?us-ascii?Q?nx1EzxLX9Kr2NSmgX2VDok5qY0VVbqL9i9RkVAjoNkq8djG9rIsDK8mVCESO?=
 =?us-ascii?Q?bJZOgR5D3PvZhh28JsKyjA+zupjga2MfdfbX5FeduGMd8w+I0ylga6LYcqkM?=
 =?us-ascii?Q?UUEhQ+5T5gebA4OrzJ+ekHFavT+AUv8ON3D2c5sn6CLA4QaWAUE7JkentIug?=
 =?us-ascii?Q?v1NJYh9o/93J1GcRoG3B+bDmZsw8DqsGMbUj0KNnFFebA4x12iQt3bD2RCaE?=
 =?us-ascii?Q?jyBjvo378AfLb09QQ90u8EsOHgsIgKrInp/vN7ZKSVAIr5H8lT7Gt6TTyyH4?=
 =?us-ascii?Q?aHMiiKZqhNUAyU1dbuZ76J6AuiLjZ8esFvabmCdhGfxpKnN3fwRHo4VWtjCD?=
 =?us-ascii?Q?utysQz2W52qsa/kyVfuP/rOQhVrbLOR4TpjETHubht3p734lMAoj2Cvh43FI?=
 =?us-ascii?Q?mpebgKohdEnIwBON6kr7SOZGXS4iU2U2c0Gcxg0KHFam8P6zlM/ZhmI20A9G?=
 =?us-ascii?Q?pnIUJN0WiAGImIPs3HoWquPlcx1V0TRzLCpKiwsdb+K4FAO3mtrVdoknRRa2?=
 =?us-ascii?Q?ekvE+oeS9NmU2zYZf3L7A9VVGr/q9XczZuCXCFd4I8NnMsXOChX5bdQ2ppUk?=
 =?us-ascii?Q?MP16wWiQS5zz4jUSRyloQ7FW9Ly8fIARMYEsMWPdDgHZpiAu6QWEfiytB+io?=
 =?us-ascii?Q?bbJZhPgsqbRCUCCJ5qUZCdNYyUjg0pdREqIZ0jrGHcy2RVUXg8H90UbYGfcC?=
 =?us-ascii?Q?0yM8sZGMw12FHgVji7rGnaQc4xEH7Qr7fC0csdH2exsz/WEB49tWWj7kVkbe?=
 =?us-ascii?Q?ZZOcyRTXhaRx3eX9kHhIFLDJ6pAzMVrFlmqKx71mTfrq+pwtsRZtYEM7UZIB?=
 =?us-ascii?Q?X4sjyjagQfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bWnOGMsFfKzzu9qhmGpbtYarTJhbLAbpO2PzXA9N8HmpoEal75gTfFXp5ijv?=
 =?us-ascii?Q?tzFZLCJiLulNr+zw+GcBIniVFn3xKI6rgGIcp+YH6CKOsamAcSKti0vUml4q?=
 =?us-ascii?Q?s12zeCf+TeJBwo4YIcTSSu3CjQ6ooP6nQeoIR/kY70ayrGJwkc3s8ELb2BX6?=
 =?us-ascii?Q?WXKUg81GKR0uqXGm4k6U/jizzXccFl5FVvoPLv5v7skTVenh3pUOzc2V8ZUG?=
 =?us-ascii?Q?3gSqV3X5MND9S8Zs4HAN0Xb4qBmvKM84c8O+fS5s0V0+BmXc4kpa2oeLZ4Cb?=
 =?us-ascii?Q?LU1xqtvxjA78MNgCqQY4Ca5QcG7SlHBWD0Z0Np5BdmW1qgNu5U2ACvEKzppP?=
 =?us-ascii?Q?ypxptvb8axCSAFpkOsElm1yaeRHboPoHShh7mFEt/hn76dkvoHdkxbw4GyW6?=
 =?us-ascii?Q?MEeCcx1U4dd0c9MB2rqKphiTpMqUdnrJR32GhitLIqhwD57qhgWgIB7tcT+v?=
 =?us-ascii?Q?ItvfFyVGNkklFglb3f/TKq5N2bdwEvj0++jvNJN+VKh7sYGW66kwPogxtE0R?=
 =?us-ascii?Q?tUPewVJtj8FGFRLrs87B9IvN5ZMIRELRsVlsWSHN3pUE3+gmDnLxsZ0FkAf9?=
 =?us-ascii?Q?Z90UDW+eUNgLOrX90W884a5cZx43jRle3hv80pM9CbEmJdrNU1JCNEYKN22c?=
 =?us-ascii?Q?e62plet2P62+Uf9TKm99loydg0fY10vFBvEcOB18ohrDkWQrgQHLsSSprY8B?=
 =?us-ascii?Q?o3Rph+Gwvt2dKil+StL6Icc6KeR4jD0GawNX6c9JLf4ZPfhgxbjZ4lh1tLHH?=
 =?us-ascii?Q?Y4+hh1a9TultnWFgMk1buveQWI0R51pnxhxbN4Jm7lUqEScjcz1ykw4kqheo?=
 =?us-ascii?Q?YMfuEn71zGO/4TIgZO1DffA1GZwxZ/KfmltzWkfZWpYMP99GVwCjWFp6Iv8v?=
 =?us-ascii?Q?vCdPA4J59p5nDAV/cJaLrpDcaIQeaf2OFj1IWRMuJwixO3L16riTo1qyBAxe?=
 =?us-ascii?Q?YZSZFgZ3Yzx0E9sQAJYH2jMvT4hahqFZ6lIse98jV48mJivfswe9ptSLw98q?=
 =?us-ascii?Q?2gOfaTT4AOY/bV0ogsyzWr2z/fSuIsVvd4KzBr9auacgZ/8e0xY0F5Q/AC9m?=
 =?us-ascii?Q?QD+oRPddFQyli5BYPK9LhAaOnpQOsoApa1E2Py/GEXuKOhja9EY1EoWWSRp+?=
 =?us-ascii?Q?WvwnagF7wjjfNCAUUDtHUE2+TEEH2aFePiOlaCw0LKnEoCuD5ym5KHk2Rbcb?=
 =?us-ascii?Q?gKcGsBzEYYhMwZBBRlb1WT0RKIE9aHuiJusj9hsGK647BnWI/4Dw1pFH2jut?=
 =?us-ascii?Q?TEKep/YSAeRx0hJmn7VBe9AP9E+tmjHkODdgFT28ckAt+hnH6GwBIFuQCycT?=
 =?us-ascii?Q?wr9MDzSg5/2kODuMiKLbOuOtsowu+4ELC1NC2sN7nXt2byVuiELjpk1u9wkA?=
 =?us-ascii?Q?Ljf+ItlAcU8WNOXF1ls8JxGo4dNtE1WeLbZNQdFlIBjctMi0spz5zJO4ELQx?=
 =?us-ascii?Q?blJsKP70hy0xpJKcm+wo6UTcT2H/YxdZ8znMfnFk9aUEs84v/WadyN33he4q?=
 =?us-ascii?Q?xKdFTiAuROZ8qExypi8IHQBNFydJq0PX9gHlPgz5YtH7sN7cP+ZGDzhj/qgB?=
 =?us-ascii?Q?CK1Inx4gvr8FgX1aSVFdFpgHVNbEiiBUnZOWaKO4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+HWlK9l0DMRo01804mg0G9XdIfatthftpeag2wSmyRCyANLN0NS/ofFmLWPlDlNRlX0Wl0DwZRxKAJGgfQ7GY6JZFE4h6ZjYihMFEPJYFhCmZSmWDMrgXWpqulf0h5RZ5OECRkBvxQddf9MdHnqF64hu/o1gsDc5voUxDhHJ5BJZ51wW2/UeuJGwuzE4e2A47WGoBZF/9IH13lcXm/Lf6CQwe0mPfbU1xWx66GIPvDFZak4ZHpMgwpzdT5B4OUwdvgiBOP4esE/EVeuP3VesWnYbk7vVzhen43KtgHyDyx7uVaDWJJrqBLXe2dcBRAr3RxQOFmcZ0IhzsTqApl+vkqeY0zIJUsV8rZojDDPTJYczqLExOMTNCIP1iiJoLLhkAmwYtPTUHASKe4QurEbG28a3J1p8cI7lTb86iTfc3uQ0OFBVoKQ4lmFF5DESIjn64YojcF+U6fx6konT+DvR5vSdGhBt57U0ECQBTe75AjxhdElsHlwLjvTklrk257P3HSuPeZDpv2A3Vc2Adg5v4ThakT39d8Xe8eYkAgBQqjWLmfzc5I82OzvZvE1BvMWXMya3eEOj8n834L0VjmR11d6dAGesN5F18qu9QnFdeX5qvvH2hTr9zgH2akYWS4zJ
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5104b936-d691-4439-1809-08ddf5b875a5
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:04:35.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tl5AvNsp9VE9W+h0TgqOJ27aiSbcMBX/ODByaOFiuTY/xQiFQ5BD0+JtGE6IVW810QjLiI460CbzB16FAOa9ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P192MB2171
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
X-OrganizationHeadersPreserved: DU2P192MB2171.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PaL/hjhd c=1 sm=1 tr=0 ts=68ca5d85 cx=c_pps
 a=k9o3rqwAubfXSH4DRDcJDg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=ezTdE78XDLEDAIlXh4cA:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: -zR8Rf9ip17AkNjWxpcNoS8B6IlHbbGh
X-Proofpoint-ORIG-GUID: -zR8Rf9ip17AkNjWxpcNoS8B6IlHbbGh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDA2NyBTYWx0ZWRfXwH8mEvGfRe87
 KNtSEluC39AU/RfBJAEaDa/88qiD0iiVZlYp+pexw5n2AxKqvMq/Z//CFZ0uwY89HvT7pWxtYpo
 /AZE33aN1TjidpHYmk7KSlmpXxkoVF2m4pSDcO/9GRYIutx0YyS4vLtz7Ne4E3xe7BTusCRisBz
 s4UR6MbzNn57HrH+RN+jdQPUNF5M2IFZ5C0cm9qHNlXAXv5ENWaVkTbtAFlEnv/cWq5//ViHoaS
 I2KhJZ+xxvWf1s6cAf0Tr7wjGAnamp2HC++YBiqOLs+81Qz89s0V8wpAnQiVpoRw2lRZSiV4t2h
 +xWIrf/DieILZcncXTMLJIPW1i2XJAAKr0cE3pAJq0cmcnhBRp4qunql7kx744=

These macros enable future support for encoding and decoding primitive data
types in a generic way. They handle host CPU endianness while ensuring
little-endian format on the QMI wire, as required by the protocol.

Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/soc/qcom/qmi_encdec.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index 7660a960fb45..cb43531a8b66 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -11,6 +11,19 @@
 #include <linux/string.h>
 #include <linux/soc/qcom/qmi.h>
 
+#define QMI_ENCDEC_ENCODE_u8(x)			(x)
+#define QMI_ENCDEC_ENCODE_u16(x)		__cpu_to_le16(x)
+#define QMI_ENCDEC_ENCODE_u32(x)		__cpu_to_le32(x)
+#define QMI_ENCDEC_ENCODE_u64(x)		__cpu_to_le64(x)
+
+#define QMI_ENCDEC_DECODE_u8(x)			(x)
+#define QMI_ENCDEC_DECODE_u16(x)		__le16_to_cpu(x)
+#define QMI_ENCDEC_DECODE_u32(x)		__le32_to_cpu(x)
+#define QMI_ENCDEC_DECODE_u64(x)		__le64_to_cpu(x)
+
+#define QMI_ENCDEC_ENCODE(val, type)		QMI_ENCDEC_ENCODE_##type(val)
+#define QMI_ENCDEC_DECODE(val, type)		QMI_ENCDEC_DECODE_##type(val)
+
 #define QMI_ENCDEC_ENCODE_TLV(type, length, p_dst) do { \
 	*p_dst++ = type; \
 	*p_dst++ = ((u8)((length) & 0xFF)); \
-- 
2.43.0


