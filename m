Return-Path: <linux-wireless+bounces-26055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F22B15B25
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 11:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DD13B2983
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jul 2025 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228A1E1E1F;
	Wed, 30 Jul 2025 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="bCp44tXc";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="ywUwxr+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8367259CBB
	for <linux-wireless@vger.kernel.org>; Wed, 30 Jul 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866071; cv=fail; b=mqNReQAgbiXX+sRPoKAGAfbz70uKYTEfycuftPaO+MHSPwzv0+9QBZbd2JvWRXpv2ShTJ6B3dgjbUZgHJmLPPGD4jZPBsUUidfZe5+h0kE0NLetUrmcCGkWIzp8y5HDO3FG+zc+w1Ce3Vgb6HEuBCWJRnfp+3Q82Sll1WIar0nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866071; c=relaxed/simple;
	bh=wCvxIQ+0cIuMPU5UuDnn7MwzXH8Za8VwuMWPvxJseOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i4E4oh/Xlo3Qx0mVIiL+VSlsp7+JM7AbNHPoCa2O0N/ax+PfyZfPJtxJCvaNPqKjHKxVvLluq3WztU/cYB31vfWA4YrrY+6tBbCADc3XY0Yy7SZrdGuLmSscgFJUWufSaRCa2Wh8g/oIBhmH5kqX5jtBCleibQVqHykBghAOraA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=bCp44tXc; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=ywUwxr+m; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56U7n74M2354312;
	Wed, 30 Jul 2025 11:00:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=RicF9Ggj/hjBh/byRfRA4Hae
	wmPeqkJ0loYMPKfpGEQ=; b=bCp44tXcwEvK4BRMI+z0186RwKpagUyG6k8oA/wz
	WjFYAboszY06fgRdrhwldVrqynZEh8zYGeXE/Et2ZFmiCZ3qzBYD8royvY6t9Opa
	BtpnWMkFJMitHUkDh54LTX2HUMxO6q8EsU+jjLCGAAWMPs07cIL9JezGvq3q04QP
	ZBjCpKdjV1WA6IPpZXenBgPwSKX/QHrytEAagmBZ9ak8PqHSc1RECmaNSCBRLj00
	YarjsZDfytr1giw7F3SwlBTrPc39nQkxxQGNdTgEoil2+p/u/KWo7r9SxswRc4HA
	fN9ekO1xycYZbnmhMspAfOzM+w2HXYl5NTWly0GX8xG3SA==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2106.outbound.protection.outlook.com [40.107.241.106])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 487ex8r2bc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:00:55 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHMs2ObAvHhIkFcCl/ShxNWyjyHxbk6h7e9gDm+I56FLjOoak4FZi+0yuWkiMmvX3ssCn01OzRH+9RAZrT5WeRNONjmXtBnoS3RYuSxoDDlZMK068K/PU0mxc3FnS7J/Of47RGLn9fwLEouvpNdGaHfgl0RjgBap5pfzbxcxZ2/0UNRYiH5/gjkE37Spolt5CLdNTMfCscKTxj9SUXzYNMWGXKDnXp/uQOCybjinXsnesALgOf4bMiDhOSGz28wtZXTWgaI2ryd0vaoTrgJYc2M+wEHVb31lJhi5WletTEKMg722bCr0QNe19tWhY2mBB8cLIfEzbnX6CGGFW61qlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RicF9Ggj/hjBh/byRfRA4HaewmPeqkJ0loYMPKfpGEQ=;
 b=nbSsg8bPfThfXo8qqYgnolcLk+0IegdHycHnSt2tZx3qwUQw0/sSCEqo15g9AdYb5DdfCwxXW3RPFwMoFRYjRxfIgxPnYyuvO4Ia8hrKQeGgMuACcgDdnrn0chp7Z0VPD63v0vX8Knc7jSJsJxQ2Kb15otnqlIAVDO1h81t3dURX6K1K/BAy7Zju6X/xlVjVEnDX0iCnKS3tC/JO+KmA5rnITuh5cowbOWfzrDBUBlyItHGP6hwNnxFCKnCdmJtlTAE16sF2lTAp9PaX5pLkv6igbfRETCbn4iU/vaGbZj/tROdNz/ZwnBQ58pzVgP5MsJNcXWq99A+2nubcTDbXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RicF9Ggj/hjBh/byRfRA4HaewmPeqkJ0loYMPKfpGEQ=;
 b=ywUwxr+mtPLd7gTop7nbi60ifv1m4uX8rFwTLPCHKWsDUObmzHAqmkK9uoGEDyTePTVsLc0hk83uOAWUUa6LQKPjDP4ubZ+s32gYeD56kntITWxROmw8tdV82c1RXE6FXlO9Hys0BNnxDCKYaoCxpw8vHWUDB3pLlzxMXAkW3Vg=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AS4P192MB1648.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:4bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 09:00:53 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 09:00:53 +0000
Date: Wed, 30 Jul 2025 11:00:45 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: Missing BEACON_LOSS event
Message-ID: <aInfPSL+ofPfqrRY@FUE-ALEWI-WINX>
References: <aIjGvT+yQkZf8/Xs@FUE-ALEWI-WINX>
 <DBP862N3JBT3.2NRSJ8BECF0YI@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBP862N3JBT3.2NRSJ8BECF0YI@gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVZP280CA0090.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::12) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AS4P192MB1648:EE_
X-MS-Office365-Filtering-Correlation-Id: 77573a50-876b-4e4f-c180-08ddcf47966f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gSUTDHYnlNLS9SK4z0VE7CM1kFhPn/LDV7ErgLhbqDRTzSDyTIAEXyRueBwt?=
 =?us-ascii?Q?5Vj9bq+z/IP4IDtrfG06VpOjIaMUWTCuSfb8hlU0VDqgHVpZ8pXpOLk/lL2E?=
 =?us-ascii?Q?cXQFh7lhZy3nPPVe5OCHn4d8xVhgBRjotqj/TLxHiwtgZvWH5Gi4W3E7I7M2?=
 =?us-ascii?Q?s3jwUv3DmCLj4xxYFFRRH9dNGy0DjdKtFV24SDtW7H+EBltrgts65WMbUf1H?=
 =?us-ascii?Q?AlxqbiayPGGEQBjApRVd6n2zYV8bWSt9XgYkKZvYnetIrCpWKhe5/kPQ/H4b?=
 =?us-ascii?Q?X096y+oQiTYys+NFkbeIJ2CfDJujsjCQ1Pc3w7F2u2JeDc4wAiaHOl2iGKz6?=
 =?us-ascii?Q?qBK+4V3oIsFa0Yr+lViccIdTQ5NfQ2GB7QPHrIhQMB22YO/0gXiCh0REtQJH?=
 =?us-ascii?Q?yqLKeUH7XlW2nGCBUFqRWLXGVNLdSE8ckbMu4byPDjT0Ni7cZ9YacDYsgmT2?=
 =?us-ascii?Q?MMLPV8k6m39JlPcYusoneJT+TznOMF2yCe3LdzmGmOnVpRwvYYghi3mkDNSz?=
 =?us-ascii?Q?lmyvQOKQ89BS091G3Yh8xh0G5nAjagMz7Jwn5/nJ7koRxORnlLr2tCu5jV9X?=
 =?us-ascii?Q?J7V7bG4tLLrCu1/goJmiJdridDOFYU6C5YtH7G8P+wVmBmrBXR/XTUMCkO+L?=
 =?us-ascii?Q?iYqBTy27zCwoVrI6p32ODPPbklVJz/U16hQRQ8baGqW9mSzlIS/ik5c9eEWM?=
 =?us-ascii?Q?NAEeLAWC/rpro27wPbik9i/ITEYGrlnPNlcTKqTdNhfVDEa0TBAHpkz8q+ps?=
 =?us-ascii?Q?4vc2fvdL5KLCxiWHi5KjcUj6I75OZkZq1rm5+RUzrdlwfAkZho/pc9ivW3jD?=
 =?us-ascii?Q?1oL7ZxTohJjmGQsoOPXPKloxcy/wb72YKGpFHaZ4LWF7kge6FyplEF6nBDqy?=
 =?us-ascii?Q?a9OsVPORhQ6JhaIqRTBP8+b+WK15k1wB4t+UnKadHWMteS11dUfvpnXNka87?=
 =?us-ascii?Q?+Ir+Ax2rwv+64yHzTQMD6YrWt629yw3TiAWCv4Q0VdwWlY4n/txKCjFzWjxD?=
 =?us-ascii?Q?AbBace8Fm9Xx/trh/SS4aRmCXInaGborUn1yN5MjHCnbjPSoKWFauNST0l1J?=
 =?us-ascii?Q?9CGIJv0OLx+ImzuH2XkU1yMb77aifIgioB9r/lxFwqHNPvoXvk392cmcvVrq?=
 =?us-ascii?Q?bUurKqrbBjYWlsbsSkrGBVv32Pq+pCX1nH+cWXRbzC0UdQNfN/aDapVgB5Zw?=
 =?us-ascii?Q?XCggNezD8DGZvkg/RLADK28SXchgViJHG6vSpSEvfnqdoKsP/5FGe83JRd1X?=
 =?us-ascii?Q?ZvzXhpB/bwsQmneASBSNw/8BIy85fX+ELvvbP9ZN1bE3nVEEzTq1UblckiEP?=
 =?us-ascii?Q?NV/4wsQ/y4D4aG+2gyHCzkHkq9X6uvwmDcXn4d0TGObW79jTkQLPn/nAv8gC?=
 =?us-ascii?Q?BRnZnxI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hkxHVYx6rrd3+JYKZ8OtxafoSX+eozq2Sgmjmu5fMiLQbnX95YTUL0FF4Y7A?=
 =?us-ascii?Q?dulOXpyAin6t+5H++GtPxK9ENx45QEWYkZnIDfPPbQPwi05P2buM9i79et2F?=
 =?us-ascii?Q?p0jzUR8Uhm5U1HkRRRPNqjf+85cvPeNEG0UaTvbyLZG8Qw2+ef4TqlisEWda?=
 =?us-ascii?Q?7MYNqJVaEQrsQ+mxUh2veyWN9JheL8w2sLxXh81hdVkB4Ph5o6Ubjw1h10ch?=
 =?us-ascii?Q?5anLGR7jLhquwnuIs2/XckE9vsOYYRjqJrs2Opkt4Ifbvhu1eOr9qASOH/YN?=
 =?us-ascii?Q?RV85giTAYMKRirZKGFf09cWl7Lm6U+q63n4Jg0vE/A1YVI6W6aXUeAhFJHjm?=
 =?us-ascii?Q?y+25g4ihIXmrz/636GVJOkPC1cmoxA7bC6bRcmva9G/KqAgEKHuTtfjivPQS?=
 =?us-ascii?Q?+R+0KFVZfT7enSfsIp9iGx+HzHw760lt4ff3JCEvDtNoCtXOHIR+ogRiFF1p?=
 =?us-ascii?Q?DR7eSDke+cHgGzUXrOPqAyM/Lm+oKYrnnJ+hM7GBOPh0ANbdjowvYStwXO61?=
 =?us-ascii?Q?fzjpHOUnS6Q3Z9qhytWyImDU38c5ishytHTaDO7LDswZUbYOqqK++Iupomew?=
 =?us-ascii?Q?UIPBfTIAJSnFrFd2L6Qj3PKiP6igNsQK1RIp8SNVA77zvJ7c8u3sAJSF9RSN?=
 =?us-ascii?Q?Adz39+Tz+U8TXb41EZxQIO54/bV79lcAXTeXvKNjpQa2SHtNcMKa3m8W4Pen?=
 =?us-ascii?Q?4UrZwPr8NaiT0CsLIdA2vyHWxobAf7KhBEAIaK908roGMr2TnMXfEoM277YE?=
 =?us-ascii?Q?E+fbFZvOnKDojkh4DMiYZoRmW90+2D02P++oYA7XB7uGm2MoEoJGZumPQqLK?=
 =?us-ascii?Q?/hFuTMfKUrv4wZsK9zoto2xdkhmY/2F9AkQ6hCekZeeKQetc9VfHPrxCLl6V?=
 =?us-ascii?Q?L7pUVQt/tiBuC+FYItHd7fSrUWCQsZl078t9vHeZe7IkvBAWOV8nfaSyM23W?=
 =?us-ascii?Q?uNTes41tMRylqCXDVAHhTalFn/yhpM1nzpf1VSHztnt9e6SP8XCnwjWOYMcL?=
 =?us-ascii?Q?6uyKhHtfvrqSIdCRG8wpgH2N3F1Wws/3b1009lOrlugcOUBpIuWsZOeET/cO?=
 =?us-ascii?Q?z6WYcfLu1wdRHwso1NM4Mr97N9qabc/SSDOeVyEMfOHqNYBj179938JM5ts3?=
 =?us-ascii?Q?FV+zAGOfm2QhLkt/WOJitsqqj0ujM7NjPLLKCo8lj40EqD4es4P0j/n/KW+x?=
 =?us-ascii?Q?S6XPH5KBg+LILOte5GKVqRD/wXc+7OtCc1UIOiqutbfyQBeurtSySzLPC9/R?=
 =?us-ascii?Q?i2cjHbFX5SJ7nSFIdqshTI10fOIH+izAyWyUWCGN5n5YmwC2lg5f1/hZNLPg?=
 =?us-ascii?Q?rvIPG+3/yLaEwyjQ2i+7o79R0CADw91y0znN4ZrgWYQ1odgcXSv7KrR+mCQ4?=
 =?us-ascii?Q?RlRontqc9eum0QN2VkoouJDy9ZJWJ7YaZlRG6WWNY646R8WV05KeY8Kj6KM0?=
 =?us-ascii?Q?GrV2XLAQOzUSDH6Sta/DuX9GUPYaNYIZ9fdB4bs9XHRqWkH2N3d0Yf6i3uip?=
 =?us-ascii?Q?7WVvMJZJn8iasdSh0jH6AG2/i1fosS8wmh/nf5YP3uvFop6PGXVAS8AgkYP5?=
 =?us-ascii?Q?ILVV295DSyrJxPUTkg5nhGjj9taSvFVpDAJddi0O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vmsAWJaLCOfqconLVSUxwJPyrp7ycxvt6WSsbWGZkrJpbYpxrnAIYnU4XAVTdsJorVYfuPsku8veSISCp7MYIzaDOOzBWtKPrDAw8GtB5eCdQimxoBUbZOWygd4EwhrfNXLPkxz4adGSTY+XDRQR5tvL4lkXUrJp5YxqG5r56TM2OufZ7O6ujQHGt3KG7Rs+/uXn/vpqoKUX1J4BKxJAMAQ3cQZXps086gYL2MOBBpO2w16ySYVvm+S+e+VmGBnd5MB7UUQnhrpF7mxO+5/WfDmBZrUaGw1DFVH8RtqCa8BH/xbcGD8nEQFztlvxsaPNuLmvVN61SkJK4fI5dBCBfUpmRgvsjWbFDT7RIgDTp09Wc0SVDvobQX7xUNrgb4ScqyOACCD2jaTIXkTslMHchMpEybWZAM2xLQ6W0Bau7und7A6PUFOFFigLhwfYlFZKMvWU4MQyKYnvdW0sRz9WsRUn+2a9mfsHtD+pNPxAqhHDF49xarpILsTpCLFZ9vik2UpgwjmmSfl2gog37mBOax4kb2v0C6MGcoST4aYGQFCLL5R53pOJvlmNzwsT+QB63dvKXBkKvvlo4Eu6Ic9q6BMIZAfLKb7UTf0uQNOOhdfO93tgjsOL5Owi9tLUbTFW
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77573a50-876b-4e4f-c180-08ddcf47966f
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 09:00:53.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ibrXWNzdMktqIbu83MxlurlO57MXRY7M+RXB6PBQIkclb+CFBx+fblhs/gFbMOOME+fj+P4DesCjQ4AnYPlag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P192MB1648
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
X-OrganizationHeadersPreserved: AS4P192MB1648.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: 2opzL8VWLZDK48n3YmrW5k13J2y2X8Iw
X-Authority-Analysis: v=2.4 cv=CoK/cm4D c=1 sm=1 tr=0 ts=6889df47 cx=c_pps
 a=K3gaILMeFwxk5q8MGe2HyQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=8gLI3H-aZtYA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=qC_FGOx9AAAA:8 a=1v0ElVGvnx-MpyXDiLIA:9
 a=CjuIK1q_8ugA:10 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA2MyBTYWx0ZWRfX1dfMgQKEEawk
 1i4UEpzBEcXODwAzyjsuCqKocVUTl0DPOlbij5m9FaFCGcCkNIUMxmnIeZW38Yodu5MKn3cqJne
 Z673uOjXARu5jeZh1ZpaBIOoqSlTxZfgJsFBjqSQe8R33cxkmKGy+r7frISxmccHGMBaelwQPD0
 ZZ1ZfcPZW5PiQHPOZUvuY5Sbe3zNs/oIhEpRBNAkyv+ZF+AZCQhvcVNhdLU2EtpAv3ZNnYEJIs5
 9SbXV0l5SQWrfZcpJA6oP8ny2WPY/MuQ2nTAJL6zFNjNv800SrF5xkYRlMT1M8+midLh1xZ0ppN
 Mg8m6bdVYj2cRGFXUzp/lhaA8dGCCpzqEy4MVTxbkx1BSEsHXCpsQ/4LAi04qBl853TO8lmYtj+
 r9Lbwwta
X-Proofpoint-ORIG-GUID: 2opzL8VWLZDK48n3YmrW5k13J2y2X8Iw

Am Wed, Jul 30, 2025 at 09:52:16AM +0200 schrieb Nicolas Escande:
> On Tue Jul 29, 2025 at 3:03 PM CEST, Alexander Wilhelm wrote:
> > Hello devs,
> >
> > can someone help with the following issue?
> >
> > I'm using a QCN9074-based device in STA mode, connected to an access point. When
> > the AP is powered off (without sending a deauthentication frame), the client
> > remains indefinitely associated. There is no disconnect, no beacon loss event,
> > and the RSSI remains stuck at the last known value.
> [...]
> > From what I can tell, the function `ath11k_mac_handle_beacon_miss()` exists and
> > is wired up via `ath11k_roam_event()`, but the firmware never seems to send
> > `WMI_ROAM_EVENTID`, so the handler is never triggered.
> >
> > Is this expected behavior? Does the firmware need to be configured differently
> > to enable beacon miss detection in STA mode? Or is this a known limitation? Any
> > help or clarification would be appreciated.
> 
> Hello,
> 
> I've brought this up already on the ath11k/ath12k list:
> https://urldefense.com/v3/__https://lore.kernel.org/ath12k/CZA2NS7J83D4.18SU6W9R96KPY@gmail.com/__;!!I9LPvj3b!A_l1xrZCr5Oo1_ZCUkIiXoWPpFN0WLWL0jzZvD_tjkUbOJTC-SHA0CC0HrtcXfPeOOb3729mKsEecEcXslQ0X9e4o9WHOw$ 
> To my knowlege, nothing upstream has been posted so far by QCA.
> 
> In non mainline sources there is a patch to support ath12k:
> https://urldefense.com/v3/__https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0/patches/ath12k/897-wifi-ath12k-Add-support-for-STA-mode-to-trigger.patch__;!!I9LPvj3b!A_l1xrZCr5Oo1_ZCUkIiXoWPpFN0WLWL0jzZvD_tjkUbOJTC-SHA0CC0HrtcXfPeOOb3729mKsEecEcXslQ0X9dH40t43A$ 
> My guess is that ath11k works the same way.

Thank you for your response, Nicolas. It helps me a lot. Most of the patch code
is already part of `ath11k` driver. I will port the remaining part that
implements the `ath11k_peer_sta_kickout_event` for STA for me until another
firmware/driver solution is proposed.


Best regards
Alexander Wilhelm

