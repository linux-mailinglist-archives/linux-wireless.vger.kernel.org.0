Return-Path: <linux-wireless+bounces-25525-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E450EB07027
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 10:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C235022DF
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689BD29AAF5;
	Wed, 16 Jul 2025 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="jSJxeopL";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="IcUvktMy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C2299950;
	Wed, 16 Jul 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653777; cv=fail; b=I4EbK1RdU58HJAfEX/1euQNv4INBESbeRP6T1/QaTHj6VKU/++KW8My2hzDzHqfpvgBo2JDEE+DTz3+bEdXVrLixglRhbWVOYuuK5hI9NjDLoSA/uMODgxJ6W/iQj5auiPu/p6BQwEZtEoeRQCNL6iJKVvC05Fhj7wIlQ66Ffro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653777; c=relaxed/simple;
	bh=EMmpJSWPUxsDmERUaFo01z6ABcAoGIRRo97cP7SEbCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PM0/6lHlDvAqsEcQzKeqlFM3o/7LvmyPdKSbQUdJ8n2S9lFpKaEOfaa9JjCzy6SmHdvyxJAX/Olw7p0X2IPtsVfL4X5QZdcCgwz84mjdOgbleOraovpjwXVznbzFr3UG3R8UXEDWpzb/vZZkEKl+VQ2iZLH6kn0mklXzX4y8aFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=jSJxeopL; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=IcUvktMy; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G6XnWC2292231;
	Wed, 16 Jul 2025 09:51:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	cU7fgeFcB/NbDJlta5ZiLVPodwe0bQUhaYBNz2bUHjE=; b=jSJxeopLhOlvhs3W
	x2qtd+gfngalwVuvt79U9m5yQy80Cb2KRP31W7wN0m3zXrCdPyJlsdDsxE5gOoRc
	NiUrwAnsuwsCAXl5uIRtV2EASdgsyQEpvhMdojCwH/AcdM1Yj5ma+aHHhydX3LVs
	Puifrvw4zdzNYpQCqQuY5MxSqfv/rsSfULl6RUF7dxKDqslfTco2GL5kogT3rIjD
	xKtqdA8hZkT1XQC0HYLjonga7gYgTFwTLCjLwFe7o9KwblDXwHxfA2RSK2eBRlyj
	+dj44ot223iTLvDez6Z1639AX3K77cUi653rlPRVOiPEA4Q4uvZ3N+HTXGEZGnPt
	LCrN+w==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2105.outbound.protection.outlook.com [40.107.104.105])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47ut22b7nh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:26 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVWqhEi29KTek0nTOalGy9N3g8dJeuaEuMgR0dTpJ+DI5M9jqR8xK105sha13D9mSOXlWAFqVIKQknPeygVgB2oJwDuB7/glWwihEqx+7NRa990m5viqbyBoxcLqJwUEFTjXdkUsYcbDKX9bTeNpVPEoeQXlPnwTNwxmJjfwEybsCdRAbRhifytPDztwZass/xaqSt0/pKKYNaZtEHCg1MxDQBENeC4l2M1vd6JM0IvDtcL24hTMXVu9M6E3B3W3wqitA+z3dhp//yt6hYNd2CTrCYSmygFZPiVhOcKXGDmwhPgD4/ZDKGU4gJleUh/WQohYc2bbOe1eILxgboxeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU7fgeFcB/NbDJlta5ZiLVPodwe0bQUhaYBNz2bUHjE=;
 b=JM2F/EubmC3PsYdj4CfeOgI5h6zXNMFtpJUOri9/48qLyEXVOC27XMuUw9q1Vw/m1hfgoSxAgY5nB5KVI0QlX9/P+YYzZRBz+MSWBG7RoFk9gk7Tb96ZJdJbFT5MChppofVAHiBqHIPuWDpAjJPDXUQ4Cwx3zRrAOJshQ9mgqG5uUpJokBmEVRsiTdwGgk9Yy6mB2dHoO1RmuANt8SOidMvuN8J75XvSaSbaJxrtUGlePiSBia/ucsivIRXGZl3HGLb29akyy4BTaHl2YV0WQ7C449wTqhQEr3l1HFBBKJHOTISphmjlPua/orbv0Z2OA+aObD3Zrehc2nXi9Ds5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU7fgeFcB/NbDJlta5ZiLVPodwe0bQUhaYBNz2bUHjE=;
 b=IcUvktMyZqpA/f19agrQJObYYzJZbLFFrBzW8JoOHbEciweNKlNiHdRQSi3ftqUZeXg88/X8qLs5NXzZHk3dZEp8WCjMYcko1j3MzQn4H9S8D+W0DVN2kKNmi480VxWrXSoNhFrawRVcXghsLbZQLnxYM0m71CUqQ8/qziS/qUM=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:24 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:24 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 09/11] wifi: ath12k: fix endianness handling in QMI firmware wlan mode
Date: Wed, 16 Jul 2025 09:50:58 +0200
Message-Id: <20250716075100.1447352-10-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0058.eurprd09.prod.outlook.com
 (2603:10a6:7:15::47) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dba87ab-8ca9-404e-26bc-08ddc43d9028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PquQSiqXUGdw7d9x/QyG8sOTyJ1THxhRTBbSc4SHNZ05l6HqCucMkmrOygHr?=
 =?us-ascii?Q?1RMUbLO7NN9Cuf1vmp+jwFt2rbvyrZy13kFerFOUO/Hn2EF+9E7G8KmLzqBq?=
 =?us-ascii?Q?ijxwNmWO7rSvS24mlODyx4tVge4a/0RJziLUCPP30jIoWXazWmOOT6PtLNhC?=
 =?us-ascii?Q?5MzxdipWYn53HZ1TvDwPw0ncPGwYVkDCFLYUz7VtqQaKYzufF96pN5V/G6n9?=
 =?us-ascii?Q?bnavE0q83EbGRTmPyfqpLjHg624qWaU3PG4gxk08phOL+DwxfYj/7pzLk2Ud?=
 =?us-ascii?Q?KemKRK3bWtC+5ahAD18mGZNmTRVMdG7G+puVenHCh7vgT3n15pmPKjeuxQTV?=
 =?us-ascii?Q?/2E708yfH+vVYWie/kPRzSrsoTOxdPK016tMIgzVALzdFOAQgurIgGTyaNFh?=
 =?us-ascii?Q?VFQSvA0WSQKuVc226q+gBIOHoaphvrJm0GTaIY7RsVQ7hgWGWisSEoMGH6cP?=
 =?us-ascii?Q?Y0A8aR7X8ouUlLimCVV2oqWZ053BXzExKbGhk77pHg7GumEi0qNqbrrzJoSz?=
 =?us-ascii?Q?E69s11AcyAvWmpKmk5pbL+Jn8LiYajBWvPTPeVvoOsSjouDnYEdrOJP3M658?=
 =?us-ascii?Q?11iTHRosg/xq/7KK6qJ0KI6nxCk+ysrteMI3DQ9VrvIOVMUnciYDb+b5Qns0?=
 =?us-ascii?Q?E0tDzqt5gAtFwwf7VwvPBoXyfLzEAtpsy9DfaJhgzADivc9CvGt/H9ekiqco?=
 =?us-ascii?Q?GTApv2SBPpuiG/huoc2LLpN/t+2efIwWmHHX5NcWaafeChi0PzfGfTbD1lpI?=
 =?us-ascii?Q?UOs+YcviLMwXmVIHPvr78xWd78cWNChyuzFMU4SlXBBhZugJrGxClDkXu2DQ?=
 =?us-ascii?Q?nrQwsDJmUSDhY6rq8c1JCS5SpHFzZdtnw8zrO3+x10/Dmwg9lfouvlnUFJdi?=
 =?us-ascii?Q?tWqiq+hj+2KcYiNFZry2C/N0d8W/TjScAC8nj9nmElhvCrlHxeRjwdWLlb4U?=
 =?us-ascii?Q?O2jxy2J8ylxV40o9jKUHx4f0e9GeBPZZrgz/ylvC/+7YuiDXI/8LEqEw18AF?=
 =?us-ascii?Q?+FuUttO5mz4f3iB4AkbNdEEcNydXQbNgaYQI+TSntUhdsT8KaaipSmZcx0gU?=
 =?us-ascii?Q?8zdLTOTEC4YGsDf+a3syHtexkAvww2P9DwZjFNL3bH1uG/58ga+YbiflNN9g?=
 =?us-ascii?Q?sjGMUJtm0Oqm9cVgN7bsTynP3bq3vBFk2/MEaBEACJ/bMLhW0McPK0+QdK6g?=
 =?us-ascii?Q?SgOZpK5lIGMOJjKbJ1IosmwiKQrdmf4h0B5JXcUNVO+spwfts9vAGIZe95AV?=
 =?us-ascii?Q?ozIZi2Y/jQ1mJx/T/SNShqVhgZLfJuaEdIR0mPJq63D6y7b1B2JfDJKZHV9H?=
 =?us-ascii?Q?aU5Oi5oXwo96ApPXjO4bNW1uEJrfM3uXgSd/vFpJWYWe7oROmW68jCfBtYww?=
 =?us-ascii?Q?DHDLE6FO+Tbti2poXYLuB+HEbtlttdiEe3QeQmzx7pAb8zanYlRwqf63cBcO?=
 =?us-ascii?Q?ZRkDTOlTiM4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ilDp5jrpqnExhOPbwYTZcQ//DgGAIzflv+H8PE+WqeBGHQ5CsWnt9VVXmd4t?=
 =?us-ascii?Q?y9FzJXNXKoRzZQw/MbhbumjxZn6pw+ZVlK1qc8ZYEIPLVt/MVNhEVtopytZb?=
 =?us-ascii?Q?CoFEPdx3vw8oyk5PmjR3PhpFV1plt7uq6Nz4ccP3UIITkiCa82j8tdwso2Mv?=
 =?us-ascii?Q?m4OS90asFMR6p3rpWKtBrWhQv+S9yBsttvMEqw06Iqw1QEUAGGFlyq+ttKdJ?=
 =?us-ascii?Q?UvzuIpWqDxjzqvyzAHlvThIjIHywZVRJLp3nImJ1gF6gUnnFRt02DJXNeqd7?=
 =?us-ascii?Q?JelC4lG6qrGZWBUrbU3qqUhe5PFDc0KlT7DgQOXhJxF8ERDC3WH/yoby9MEL?=
 =?us-ascii?Q?jWuu4pvVeUYhsPAYiNb/sLdOFUwQCnxJMbh4F4nJ9jGbn2KBv3bAiDpAmlYM?=
 =?us-ascii?Q?BMpsUYMuxqZHpTMSZHlKTG2WCxqDwO7TfY9Gx9y2u6a7183D2FpS/wcK3fHt?=
 =?us-ascii?Q?+CdMhg4pMwYkdq568jMeisULgeV0CFTbWDaRuUih680EEzG28P//YDws+2nR?=
 =?us-ascii?Q?wvZj4cLhKx/NzkmsmLTK6WdxxBvH+N1/nUOmlxSS1SVNOErJbQFPe/2+awDt?=
 =?us-ascii?Q?Xc0ZuvpE8nb6EQHxJ9s4yTimOElFcaT/4xOum6PbWLjlC9wQLukgk/m2efnt?=
 =?us-ascii?Q?hAk5/MbDP9cKnxgfcLM6gZ4uHBrKLzungTrVhjy6ldhP8FYb17LljjCLub5n?=
 =?us-ascii?Q?O0wd5Y/hMjl1LJ02SQvvR3qLD4CUHJFPY8QouqAu/HPVntJ8BXNdhFOIMHBU?=
 =?us-ascii?Q?YCMJAKdk57w3/TN3IP+sVkcwLtY0sn8BE1DcZpNIytAbzTU4B5nN+icfcb8o?=
 =?us-ascii?Q?upAxxAv2Ro+HoFP8V+SseI3N1kSUuVY1n3YvU/CFeZxrh2em39ywUXfP/sCw?=
 =?us-ascii?Q?YXuU8JFINvDFo4eEyXHQf25oPxMMvkoMLyVmIUo/Q9c4DLf4pC+oAmpTMvNt?=
 =?us-ascii?Q?Qd5ge0yqGdOZsusHuRvfhiOngBsPAakRyG0jghTjBQE/ukYUVBTIavtjlbvD?=
 =?us-ascii?Q?hlg08Z6VGHQ3AF5YfazeWp3JCkG/7nSfp9d3CZZgrfTjaReB/8T0SH6y+xDq?=
 =?us-ascii?Q?GEXxqQBRDJN16lMYe//YEpFrEHme0ot0vKZkw6k0n2olxhyjlqVRGeGXaUiO?=
 =?us-ascii?Q?35c+7ewCEOLGIGbSehn04I31tEyqgt4psuaZL6hKVNOshJNQdhlgMmrrMoiL?=
 =?us-ascii?Q?0kwS2zbT5erMCXf8P70rnVdC/WqcxEcLs00SGGQZbqD1ZHs3AAGIz9UVKYGJ?=
 =?us-ascii?Q?40fOyAQfQ2gwvVcZgYm3af08hCJRuJSpRNzdogRdIZOPpNdHPReEu3ymewSJ?=
 =?us-ascii?Q?AkG2cKsaGI62Bt6YAiYA48TkZI9vk7j9mf0Pv5yN/CrNpn4xZsTDbH9Fz3Ux?=
 =?us-ascii?Q?1Prot0AF9dLj9jWe2PBE3rm33v8+CTqx+juGKaecz8IKuneLfKNwo46xYLuH?=
 =?us-ascii?Q?J4RyTfHCr4uclatVJ4ldBFAIz9naX1uXB8HXDWLj1F9wIWr/C2y1+PZ9H59M?=
 =?us-ascii?Q?MBDJhajxg6dc32xfUFTAoshfKPePtR7ez4Rft6aLndj0tnWkkUWRMgz6iCb6?=
 =?us-ascii?Q?cdn7KJwsxOpLg7M7FtLpjgc3rPxEH8dF/ZWipBo/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PNlpg6qgCH5oz6eqHUhE8R7hO9K4gj5M4AFpCQtj124McBt+bd6ZTP0cVYxUMD4tltUwARzrDt6bfYsNbLeu1lVhK4CWP9ES/USdZ5HhTMrDKmi8ZMv//DHexuY7h/zWE4AHWc3T/ZiGBTk3xnNKUCGkmL5DII/zW5C1p2UNto/RQDzRWj70m60QlH6guOyaakelti2AY1ezjKAJgx4m9jHHK+j6rINQPGEzKzrYp76TPJ2hX9iqxSjaVwPb5hoerkfT/SwGJeu7/lreW+DOPA2+OQsxGSkJ8X3v5Vv8Zg7BrliWRywvQg+dWzf7amLqVfe+9jSW3IcwhatXnoHXrT4TkjAciPoO3lw5hcnEiXPZsSl6T01gxGzXW4ITdgbQzWXpaTU4PdgnOYIrgdMH3dAj9jmsW8bSoUOk0tpqq+lYZjGu+qcbkNiIALaBGkmu+JczX8v16HyoSJFgkeWcPqR4KZmTTWQLwmLmb+32homHHhjIe0mz1p4B2AEpN8regkWuGtd/zTSGAQ4cuYN/ERxSnvr67rPomnn8/BOTo0xXQWVmZXNiIhi4PFTMhMA844kHcIjOub40sPFiAuXPkSjsrT/cFPTCS44pbDRKgsmYCLAiaevajfQW6U2y+Tu5
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dba87ab-8ca9-404e-26bc-08ddc43d9028
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:24.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Wuox8ADirlbqNWi0CadejAbA+NTivZ9N2l/kR4sIJCAzDoJSrGBd67xiPg+0N4cBdO/NjNbElJC1byBMqCKdw==
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDExNiBTYWx0ZWRfXyJwWk3/Zu38h
 4PJBVV5uDECv6R/eiWzM9XJH3mPdQ+xPrk3YGgcLtAthxbcFK4DuHmL/s9EL55+Tc45bZTwqDAi
 8wkPqJqRe2c0mFMwwpKdP5kUZvOQthkzKEq/Jc44r5Ej6HHMDaj+IbIyG6F2/M7bKQlTexUcIYR
 tPrK7wNoWT2Tl7j20BNDyBpnrUkbiTvXj+z/YSf9OgcbtEeLU5w5xQwlLfDGSg7rdIjiFlECCXi
 ni94d8xpgRVoMMB7Sbh57ElLA5Uxy6xKQGZicwj5vEZxQHxaasa7Pe+PPkyvH4oCXk7i2rE24DN
 rfOhB9OTOX1c1gIhsc2kns+io7upMt42WLK9Jlt2cE1EI6Kt5BmBwr14tHS0glWJlYjY4cTMAOj
 RVCt/Vvc
X-Proofpoint-GUID: 6uMWIW0jYGVrSdyVEkhZepSfEKXumxFg
X-Proofpoint-ORIG-GUID: 6uMWIW0jYGVrSdyVEkhZepSfEKXumxFg
X-Authority-Analysis: v=2.4 cv=NOrV+16g c=1 sm=1 tr=0 ts=687759fe cx=c_pps
 a=vhHpBV8J9674Opnj/x6zJg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=F4jRbKuxnH_zUiGVJR0A:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI firmware wlan mode request message. Add missing
byte swaps wherever this structure is accessed or modified.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 2 +-
 drivers/net/wireless/ath/ath12k/qmi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 5043d0c39b56..2fdd5eb128d2 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3242,7 +3242,7 @@ static int ath12k_qmi_wlanfw_mode_send(struct ath12k_base *ab,
 	struct qmi_txn txn;
 	int ret = 0;
 
-	req.mode = mode;
+	req.mode = cpu_to_le32(mode);
 	req.hw_debug_valid = 1;
 	req.hw_debug = 0;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 101d91131ef0..d05cd9b47911 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -552,7 +552,7 @@ struct qmi_wlanfw_m3_info_resp_msg_v01 {
 #define QMI_WLANFW_MAX_NUM_SHADOW_REG_V3_V01		60
 
 struct qmi_wlanfw_wlan_mode_req_msg_v01 {
-	u32 mode;
+	__le32 mode;
 	u8 hw_debug_valid;
 	u8 hw_debug;
 };
-- 
2.34.1


