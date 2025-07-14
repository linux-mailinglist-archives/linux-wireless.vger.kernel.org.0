Return-Path: <linux-wireless+bounces-25362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B09EB03BE8
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 12:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E74E3AACD7
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70754315F;
	Mon, 14 Jul 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="IOcawCwy";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="P2xD4Zv2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF517A2E8
	for <linux-wireless@vger.kernel.org>; Mon, 14 Jul 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489027; cv=fail; b=KtF8ewVxWe5fxhoCKL75/AnyHH7TKOkT0cWs+OimF6u7TR+ZbN6WQgrYh0u1+9uyvU044T2zovwTu/zGxIppXLmNljLN3+VFnflWBUTPlgjNgURxOHQJRE0zZ9+LC211YpwxNtQXKY+l6lFLrl3pBJJYmfcozOrOFiwvHkOAiv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489027; c=relaxed/simple;
	bh=m6EKU4u80R1EB/Nyf+7zAqMr3BBSiuI8E8gYu3ppCJg=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lwzfEWjknXwpxrv6OW+f/uTVoSkd1qITFEU1Il0BtivXXmoNrnCXGySwj5b6yzLkSB6V5Cl6ufarTjASJC9PxDg4onX2wV3LfomfkCZjfIFzgI8u/QVo7zxYn5Kk4ntNu3OLBlmPuldnO2DoLmaFgthWt7b6CV6MfgyjRYQQHnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=IOcawCwy; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=P2xD4Zv2; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56E6YCm5958865;
	Mon, 14 Jul 2025 11:57:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	270620241; bh=urnTEkS3wWy/FJUZnvchRNLZnAKtcLKtf/R6iN4N7Po=; b=IO
	cawCwy+z9X83ygW6EA+NTVN3TW9TE5f/MN41gZA+cWE2+MV0e8Ryw4UCZmsYY19X
	3URVSv3cVUtfYFiyjNOnbspXIl/pkP/vratxyQMfK4zUjzkc1VgAVIHGGSIFhXBo
	9ZhYPQHL181eelWUBqTrnCquUiwiUhwcGyTTTt9ISTcjOZ4dbDxnbn9VSBhT1FFx
	MaYjCOmAdF8icvAid82qYYXKamCsB1HREXaYoiJP9zhcoAEbCQ/P1DrhK38uSdMS
	Y+/dDnoABV/Kxu4T1gFF7fKwfuNYKFPKkcNq6YkVcXubCDpuYHE3tFsinbkwn8hJ
	L1bp2xhfmEmHTAc6U55Q==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05on2093.outbound.protection.outlook.com [40.107.22.93])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47uc2aj0a2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 11:57:46 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVxwUt409FH/AeqeSKrELlnjCMR+XecCh0kr+JsItRH5eM6MYUTLWwEYECHxkgBryotX7nwhVxzfNDPUfaL72VWCujCU7T76KF9s3fP0uhck/B/Rqx3PkH9q9SEp8XEmiz9wISyNIIR6HcIdWrpGtAaYZpQvHIkQ5ElZBx4oExNUGy7gbuDfc7yoE1Bnq2c/XtHQZjca8cn9c1LoX24fklcXLQxRV0sN1NZoon/pbfWP8gWVmS6p1HBF7LeoNBYe3VhcYrQnPMMJFWIJXzEYwuyX5+GYgdvtTGhyYjtwHFd4DPGh1u2A9a+z8Ga8b0WTVI8jytRzW4Ou3B88cMNhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urnTEkS3wWy/FJUZnvchRNLZnAKtcLKtf/R6iN4N7Po=;
 b=ZX8JXBRYSSr3uX9v+OrtbflyRF67k6mxVtTYEs1dWnrpubGSwB5ZGW9TVAKRBlvgYnguSqyBeD9qLzblXS6LPewN06PNYwHS6E2OMUBPXrdgWsSnd1laHu+in8TBZMoJSxOSkmkSJH1oahk6mdAEw4n4iPQOnaBvWtDzmkAXqSF/hGJp0FA8R2Xwpz+g7xgRYTM4503eEe+KPV5girkqNWvGp05BiPDTUN2rSlXLPuJU9AzO+NSjKrZersUgLlsF+EoxhdivJcndryLGaVj29VWdZ6AuG226ocpoyy3KBiPIJYKiC63Iqm2ya0hKgiD108EKx44Dc9FWUWlNcXFPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urnTEkS3wWy/FJUZnvchRNLZnAKtcLKtf/R6iN4N7Po=;
 b=P2xD4Zv2AyyfsGqrjVFKS+Knm9oKkK0DJDBPhOy66NLf+sfs4x2OV/D9gX12OAKA05ir+RcMj6MHYkNuALXSWw54t3qlBTOQt0qPZJjPlMSvKuXlN1i5QJRH/sa+dUWMxJukVrXuVhhMMp08U47TzNsS2AWObX+kHeoOePFQhTc=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by PA3P192MB2988.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.21; Mon, 14 Jul
 2025 09:57:44 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 09:57:44 +0000
Date: Mon, 14 Jul 2025 11:57:39 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: ath12k: hal_reo_dest_ring on PowerPC?
Message-ID: <aHTUk+80g6QV1vWA@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: HE1PR0402CA0026.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::15) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|PA3P192MB2988:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a263a4-45bb-4a20-203e-08ddc2bce142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MeUBYcHVgRgueb3TutPjzT2Tw/FptfPEqTpJFElNsWDHZi3Gcm0NkSfgSFpz?=
 =?us-ascii?Q?oRd53KXEr7GuTBqghBAAKbN0wJC2xI+LmFNHCAaxXq65rVqD+M4G9bNGuj2U?=
 =?us-ascii?Q?LXrsD+OvVNiwsuLl0hMInqwsIWsHSbAyLmezQ4Wcs8mJ7My2R/VEJ5Le1s3n?=
 =?us-ascii?Q?+/7XsXuiDgTUtDk/7ZKhf31f32WvZ0PdPmqCUIBBYziSH/rhprJUH28SdB16?=
 =?us-ascii?Q?a9/R/503UD3xGAfEM8z3hGUFgn8sQNjxiMe2WRCD3e3P/ddXTmmBqwElVzTh?=
 =?us-ascii?Q?j4dBFedc3zw1G9GnMzDVlRhLqAATD/kWcvdpLXct19vqnth7ahvPsmJ0dzx2?=
 =?us-ascii?Q?BrN9FFs4yfXtfMAub4Eyo51sywu7PIH+cQnplqpIoXojzV6EobOyG+tTRCD5?=
 =?us-ascii?Q?ITuG/XDbN4+J00IdD80aOvoPIebC9Z30+6F0mGIDTJtBX/KxRl7I8NR9qCus?=
 =?us-ascii?Q?ErJHxU1WsQ4UrjGd3KDzAFCQVd7EFbwbdazgGMjVC7PU7ot4/sbXUrBYf2TI?=
 =?us-ascii?Q?YIrDF+pZlHETG2qVjBEjBVop+QqIr5Uhf1GkGcLwcbPT7iHWucRcXftTtqFl?=
 =?us-ascii?Q?hFMcLoYO62EBA1HoQ4Y7mN5fSnFBYF1JRrzaZ8XbtSLrBEfCCS1Q5NZMy8Gf?=
 =?us-ascii?Q?iFOCXJkiifdJGEGWuxysJsyC0Lg2qffnkP0WZDxiRVodB1jkGZtCYRAMjPmZ?=
 =?us-ascii?Q?1+hWieAwPzsgPoiuiZf/h5a5DJQ2goBBAFxF4ZxKDFdMZHNDVBuibnPFXea7?=
 =?us-ascii?Q?/OaZjR2FKfBLpwiNkNnz0vUPZRJEGJuWZANbPEF0ID4bq9uIL306ZPNMoXyK?=
 =?us-ascii?Q?a1ru1KSPy4j5KlDHIYNza5NgVeC4FcNt88aeeZq5pUGg3QqY6FfOhKVI4qHb?=
 =?us-ascii?Q?yhEjLM1YT6R40L+3ECL16TBcUeQ61dQmj9BK6SGV/Vq1uPn60i6cQPCTFg5F?=
 =?us-ascii?Q?StgB5CH2+4plSbvuRw8vrumCyhNvdC3Ghlx+2sqY7tRq4VJJoF0tpNEJZXKE?=
 =?us-ascii?Q?gBpXI8tV40f9S43/bUwtpKUnzko6ME+a1qnRIELS/h6FgEW2ufZMFCal/hTi?=
 =?us-ascii?Q?duGcoKnIX2Q0JOAb+vjNiSbybn/zprqDZCerFbVUcQvRIZp5Ehkze3ISJV+K?=
 =?us-ascii?Q?bc125I+1AGSrZiFOhZ6TPFGs47ctPGE/UQSpCCzwySx8+9wLtTuZXeKqIqI1?=
 =?us-ascii?Q?GAEwN7lhO3RYmyB9X9i20xrF7YDoETOw0USWf084c+Sz0tyUwzjdPY0AYNxu?=
 =?us-ascii?Q?p/r3czOJB1f6aETgGxqlElqzidxS+QcOd6PO0LgoYi3Du48x+Xaki9FJkXlM?=
 =?us-ascii?Q?/oNfbTWttRY7ZjxL3G8FvNU4L5uRistVkej93KFcgYknKbERWELnXQJdSwqx?=
 =?us-ascii?Q?qeT+LWsm6CKJUtxWSKXUL31Qlv86WAg/9HCc8LpDoTw4ZJ8krw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrWsQWQCnzHEo0nuEML8hBQ+m4dYsSrH6kHDK4vbmBZNbyXVF+IspMK70s6c?=
 =?us-ascii?Q?CauW0gOg8DhbKEYzUWOGMpdUZUQx+vPPFpJiwOWo9rQKIEHd5jjuFshszLXL?=
 =?us-ascii?Q?8hWlyAzNtdlqMNJrd7sM6GeiJpwMNC82UD8dswM1bd/R3A7Lq1VWN71nuQLC?=
 =?us-ascii?Q?W5b13O9XhxCTqajyjnsujgack9iB+2BW7gskzEvk5Kn/LxgLXbuC2WK72ehJ?=
 =?us-ascii?Q?jUmDbK/PdtLg9usPTrgap5WyDmbcb/KfO/8vFEAVsicxtcsrH574+Uxb34J5?=
 =?us-ascii?Q?i7G/MFS66y+xSlO3YOkQBcg5aGgwV5PNW8Wl9P2fXn1z9GAkue78Mfju7ovh?=
 =?us-ascii?Q?GahSfhbS3t/f1aC/DZ74Ms9TFiWqohCriKFAvT91lDOzny8BEPsJ9C/7wAYc?=
 =?us-ascii?Q?UnjLF//E6lrre0jexiGtU2enZc4N/ilcJ8WbRip7nU9OjFFt3v3UMNEsLvGH?=
 =?us-ascii?Q?hdhZGCx6C/lRnBtOgkf0HiWw+7QXsVDSssmhkQ0gvur27qzvjcxyWqmNFlyF?=
 =?us-ascii?Q?ghOVOPHiggAlTo3U/mJJkRo7c2LptemsPfm0RQzQq2bUWbA8QCJ2cIZAJULv?=
 =?us-ascii?Q?khOoH3bZ6/EVqovAmkOlL/7dhkHtgVxkk18zO1Bvd7XkzGkvTdClvCoVoTed?=
 =?us-ascii?Q?66uVQwtLse1ilzvNdA4X1B70ScsqIhNK+fMRT65Oc7cYF/iusO00yvwqv0SS?=
 =?us-ascii?Q?tqSXUOCMsUtRATVJDg0tiVk82oDLT1ffa7AQvqeVS4iulb4USRbvHnoRqJk8?=
 =?us-ascii?Q?i4iPBUDh+GGCmg7PiBB89mMCv/XfJcadp5hH0jXRG7LDUVLwk0BAheYig3og?=
 =?us-ascii?Q?FizdNdrrVXbaotVOwQQA2JJfLu4gmFsTRHbXe+cILkUonr4SGklSkfHVzbxP?=
 =?us-ascii?Q?ilLGDnxwVCFnD3ReksO0Zw5gtRWkpCddb1K2sJwCK0LXfxac6r+qqA7FU3lQ?=
 =?us-ascii?Q?LCUxJ1toSbR+SPG2BJhk3gVcsEBuUsIdxbki84BXW6JmZF1tX6ptbm9zL+Ly?=
 =?us-ascii?Q?y3IRwKH48bC0WPdM/1nlM/BxchrDSMD1l6wGx6qWI6gi427Va/x0fCHG03TB?=
 =?us-ascii?Q?w1fxbD1QlFhvsx7ZlCZ1kNp6coZnQgivT/VpjUKHEAUdISytXDxyuUN2H72N?=
 =?us-ascii?Q?21xOYFP9vGJsVkoEIqp9LL+RNOl6dSLMp+iTZKtLptmKdBq5s95nClvTaHep?=
 =?us-ascii?Q?1mXGsLC43XCVuIFKdx5yr3cQdD2OpFK6SAVzQI7vhnHq3fnyV/27RDo0VTsw?=
 =?us-ascii?Q?ZQUTz7rMBzGcAdo/xQTi/NYbeknxgx2Go3cZtkJEg4geP26v6/CdLqqciFSI?=
 =?us-ascii?Q?Z5vG2a39kEhsUkSufaMSqvtzyy5QXYv9yGS13I6XJ7HfPde1C5k/v2EQ/s8f?=
 =?us-ascii?Q?uOaSUFZ1r6aXG0xmXqFwU3KpozbEMIQMXMDio03TI9ROGGTa2lucvyLXHjDd?=
 =?us-ascii?Q?cPHcUiSZ1a1X6lfGhKOJWmChdIEPHtLKzvc0l4wUCrdwL/ge3GJuY0qCrRrX?=
 =?us-ascii?Q?UJ+50klQkoITFE7IiZ/QoEAItODtFAEtbh4Okytg0pvbtkxmhutcgjKA90PB?=
 =?us-ascii?Q?a9rxAcwLmfmUbXLK0Y+LfAySM48s8+qES7VbyACQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W21/4H74E5J4KZJaO5Hpa1u8ClI//UnUvaMztbrfepgep/PVoFBkl3s8U5tEV30PKxSN7W26RVW2F//cPjA+C5PvML0HQKq0q5oqf6Ir6ebDzhic4k/1b9i3KHzU09YARdx/8705dkVJouJ7Bhv9j1Y/XgA5n+pJKAe71gWb+AzxAAwko0xkOgFCmgyGg1OL0JZ8wV+2nOayNk8EjwxlIn6PqNOtXNg629WDHDOGG/SKNjYLwhXT0PIYL8WnNJ7GLtOHiDOVY7hLY5yGT26KbDMae99Dc1OTGW2jFEx/rBjsedyv74BvzGlrkU4X3KCDD1kB9iv2/lA98ceUaVZ3szT/ja7nFVhRUyrmtpAkkg/acRHN42KrNzPkpw/xgrJXHq2XOtmw2LuFkzt5inqHcATEIYX9gJ3DLK+FSi8cXL4Lb5fx26As8jZ/FIo76FBoUr3Yu65MnQKBANj5g0CP46HCZM5f1lybkym8ys8zquu2HdrzR5tKWmW2ZCr654oxuIEpIj0UsFdOWHCUM4lxeEJcyYCf0D31cz0O2y28E+QceqQNiQizJ0ln9iqT72tDWpWRa0nnXjfTB5YieXyhH7KgoDsomDoB1435OCL0zWy9f5HBjlGWIRyjHJxpOkgx
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a263a4-45bb-4a20-203e-08ddc2bce142
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 09:57:44.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmBTXkr2ByHEEE+zAGj/ZWJ77QcMkD7TNpdypFDfGOYMI/PsjTKeY5OG8Q21Nnrs7WqvQ+gXq3521RwMjBCi4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P192MB2988
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
X-OrganizationHeadersPreserved: PA3P192MB2988.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: 0GHrH7kBckPBOsEUE5CthxQf3mIr_79T
X-Proofpoint-ORIG-GUID: 0GHrH7kBckPBOsEUE5CthxQf3mIr_79T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE3NiBTYWx0ZWRfX+8goIE/aV2JD
 oMjyYpqdBejN9Ah+fAbUOcGrAsGBCKwAlF28R0M58yaVcAZC9z0A8xR6kex2OHjDUoFfNLPOPlh
 yEBL4iz9j7R/sa2ZUBRpH6HME4IjgAomwFpw/ql759wxJGk7f23Qs12Qd7QH0MoU83PjXe5MKUV
 JLfoRgVSxv5q6LzAOgGvQJ/LxJGCRkB0vuBxeUyff4oMiIcxF3FNhYfbSEO29cjCwID468B0Jfy
 l4M/pV6+LDKMzAuzsnLxsBUYdTt7GheHHhqugNq3Yay+0OuOG9qNcaTRst7xShx1s4xwaWt9R9n
 IQiQIJ7pQdDFuj2FkRypAd3d+P4GE3Ew+rq2FUp4J/JH/7D7Oir0jydUVSkgxScgRwa2zOuKazx
 xYYEs6oV
X-Authority-Analysis: v=2.4 cv=Fa43xI+6 c=1 sm=1 tr=0 ts=6874d49a cx=c_pps
 a=LWr0d/8Hy8Q69ROG7GRQEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=8gLI3H-aZtYA:10 a=zmLIPRoEDJebVOGnzM8A:9
 a=CjuIK1q_8ugA:10

Hello devs,

I'm trying to bring up the ath12k driver on big endian PPC platform. Currently
I'm stuck and need your help.

In the function _ath12k_dp_rx_process_ inside _dp_rx.c_ the _desc_va_ is
extraced as the following:

    desc_va = ((u64)le32_to_cpu(desc->buf_va_hi) << 32 |
               le32_to_cpu(desc->buf_va_lo));
    desc_info = (struct ath12k_rx_desc_info *)((unsigned long)desc_va);

As you can see the _buf_va_hi_ and _buf_va_lo_ are swapped on big endian since
the data type is __le32. However that swap leads to kernel panic on my machine.
The entire _struct hal_reo_dest_ring_ consists only of little endian member
values and it seems to be correct. Therefore I assume the values are already set
wrong earlier, but I cannot find a place in a source code where they are set.
Can someone explain to me how and where those values are set, so I can fix the
problem?


Best regards
Alexander Wilhelm

