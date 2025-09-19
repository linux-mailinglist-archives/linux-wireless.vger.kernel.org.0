Return-Path: <linux-wireless+bounces-27510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B27B881AC
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 09:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE80522C70
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291D2949E0;
	Fri, 19 Sep 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="Nb5knGqF";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="rDTI3kpd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAD283FD0;
	Fri, 19 Sep 2025 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265690; cv=fail; b=KWhWdCd3+5IDRB5WRZAl6W/8cphi0ckitJZAei0VOOng8VjDsXY0jNkGI4ouwnE5/5yTm9Ok+7A/UOfk0OnHxe9WeDRdDtT81G7B31pmt1xeBzj5YtSnvfVnjULrJuN5Q4/0I3bmDqwfYQYmSVoqyCqv2RoC1ztk++O6gR66Q6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265690; c=relaxed/simple;
	bh=j0FNJNeTXhZiuEWVYqmFXammh12ollCrer4f3T7WfbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nrrghFY9YDdoQjQzkp+hDhFErskT/Ey9uAKMoOTfakDbe4GNiQzzXgutx+iOMtgcWv4y/enhGOG4R1oL2EvRvK1EkEFzcNHjmahR/w5Nu0Jy7ZTJCdTuFMPLlUBadmnpZMF3zDu+rfdy2X9SzQ8ppRZjJNd7IaXVGGtQOzzqNFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=Nb5knGqF; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=rDTI3kpd; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58J4kqau2285048;
	Fri, 19 Sep 2025 09:07:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=YZ+qyFO/0sn5mqDUzstVopNy
	7DbWcW/IX9C2gfk/oHc=; b=Nb5knGqFd24o7SakvRHqBAmVKIwLLTh2+qD6fOx+
	sh+dwPOiRoAHinS5sjmi87xhhVac3lwa6DEyBjp5Jl9Y3WoHCw7tGzJ0mwVeUTiQ
	3FGzG+/qZuiMQshy3x2u4X+lS9qmbg9AxOWbXy1x/I/nTUYVrznT+Fmkp0s3Ba60
	6eeuYmJ6Qmi607tBhpL7nHXsH6PnCOJKwXr/QqdU3pbx6G4pU1oDuwclCnn5SW5i
	ta1OFQxsP9Ug6ziho0fLfXbuPpU3c5rYnKQPRC4SbizzWese/XW6Yp7sHB7yrM7/
	FSXbGAo8wNkTY89pvLkRY0Lc+PkigLFm3B482KEELl2ikA==
Received: from eur03-vi1-obe.outbound.protection.outlook.com (mail-vi1eur03on2130.outbound.protection.outlook.com [40.107.103.130])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 498vnfg8rq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 09:07:57 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZM4Rt2Rlr1OJCEphUpnxjX9OT3Q2u8CXmuFrhHsrRojgW+/+dqCPnJhyOOVR4LMFLFofINyCir7/YeH6GjXwd4fHA6BgejO7h3RHTDkraVO3OsCeQiiaUErshIVoUvGVta8yZiM5KRrsFfw4+iLztmnYmMXDber1vOcDOa4DvFTCN2Q7J0rnwRq08CHvJ7QqMA4XXvpxcb8NuaKbGfpMtRHaSznF/TQvQwuzSEEIqWE5eUFhS7fqni8lgice1swHH4vcoeHSwMxR/Hoj9CahyzSXgV0SgiQuW9ApYp+5oh+puYK3lK2Xxtm693kazQ/i9SYFkGj/H5K9Mo5Phvsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ+qyFO/0sn5mqDUzstVopNy7DbWcW/IX9C2gfk/oHc=;
 b=YBBWJb+8faa9ytfQxYbjJszw1tTaNgr2d3b0QP2Hsjq7d8NSnOGO8xUn8eycfFm8hPL/nexolM/ZUa8wRgjYnIecb1WBT5sLEj+qKbOvAGxk5Qff1qwOtE9GaIdXpygkoTbUz1ZSwdcR1KbWZmdra+poBn9VEGAVbmV8n77r2C2CDTfVVgRPFdUWxOHPO+EeT80cpe0cyQrUtFMNP3nwQwvOVwML6kKelM+uDOPjtB4zwbZM1oypD9tQG1MY9p3y1GUrfn4Nn8p+fv3VWnY0kORlNsJtdcqtgSZ52wPugw7cCgOcQALVUqehlAWrJi7BbMh8WmDFIgRjX5SiHnEcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ+qyFO/0sn5mqDUzstVopNy7DbWcW/IX9C2gfk/oHc=;
 b=rDTI3kpd1xvLMFWNhxoFtJ3CgG+ClRHstaQaI6UZrnv4LBvBYQ8gKy8cZbHda+QdrwwwwbRNuohXK3/JQsVBQNc8Me/Oni1OdlfKpu3J0njdOfdghmF3tIhnZtEJBttHjAy9EN+SZK7I3a/ELSUY1lxyP3yR0WeUzmtbusr45oY=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AM7PPF9D10A4C88.EURP192.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:07:54 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:07:54 +0000
Date: Fri, 19 Sep 2025 09:07:50 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 4/4] wifi: ath12k: enforce CPU-endian format for all
 QMI
Message-ID: <aM0BRto3lYNJdBYz@FUE-ALEWI-WINX>
References: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
 <20250918085406.2049559-5-alexander.wilhelm@westermo.com>
 <e8d283aa-fb73-45d6-a89a-54ff31f205c8@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d283aa-fb73-45d6-a89a-54ff31f205c8@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF00006634.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d6) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AM7PPF9D10A4C88:EE_
X-MS-Office365-Filtering-Correlation-Id: d125efc6-ad1a-44e0-28ca-08ddf74b40d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4DpOXAPHyCNb2GR+LHTFj23ZQkgf4Uz219E3UWAk4o+bxhel4iED+vOADViK?=
 =?us-ascii?Q?RfE7LspaSppeo8atGz8ESEgDlfV7fwi1s1I+tyZM/sDV8nNy6xskQgyHtWGB?=
 =?us-ascii?Q?0OWSc4UmDvVWIsPSVGQjV+IXLldHNeElwMqEHeLUuzMldv/6VnTkxpUyt5G2?=
 =?us-ascii?Q?lT8HZJ1r10jqos6s6FKzCi8B9wAUa5U7bwq4rqPmctNqtJjG3hT9mMGLM2RC?=
 =?us-ascii?Q?+hFRx0jclkUzCxkX+lY0Anw9v4dh60GI60lVLFPbhY04nzVNFbOa1/K0aYOn?=
 =?us-ascii?Q?+zAHs2eS4sXRNiYxRUjKawKboCtCagI/sIGWYuIpd+ZHQL+o84rGWCK6aGvA?=
 =?us-ascii?Q?NpcJiRp0i9nwZWzwGWY5+WNhWm6QLM4u/zO4u3HpyBkHiZ693SggEl66Vbw5?=
 =?us-ascii?Q?Yku+uBM8HVD+0WwPRm7agQ9nrqbHqSy802Hb86WEcoGUJhGbxekGcvQBP3XU?=
 =?us-ascii?Q?fmef8hbI6Fy59z1xRZVPmMuFCH6FI9yFOrFh9Gn5rA91t9112CJdQfZirqJr?=
 =?us-ascii?Q?noQMTBYBK1yH9CA+pjS1XYMtFEcEDOSS8yIy0VBkbLCA7VDzMuU0HmCnfhmg?=
 =?us-ascii?Q?ZFDay67W7kZHD/3DjKNGVsWVZyUrRaG/e8eCxCXAUGi7VBaIL2aeQhtppVn8?=
 =?us-ascii?Q?eTU4J1VvHUi5Qw9JFVgKvKEOEzQkjfmctfSEPPxhwPbIoKse73FK4EkSRhfJ?=
 =?us-ascii?Q?KLjKi3KhOmsOc+ZOpZdbTqhMN0jGsF4Q0Q0pdzCajLEEUCoZvtcvc8eSVnj3?=
 =?us-ascii?Q?wz2u5GZeZ2/lgDy+mJNO+hkNTW6asP8cQ6FnmmrXf4mVKkW0vJDGtZQpCIoY?=
 =?us-ascii?Q?aQ0rUP6IcdEF8sLXmTCsxY3ENj4uj5DEJQocMXByI6QY1ShbcoY8O6IocWqp?=
 =?us-ascii?Q?8Gr9z1y71xzrbZI8S1ybmY2YZjD6StTegZfJBwEDEuR6CBQC/553uOPXyWRw?=
 =?us-ascii?Q?28alS9dC9dMmTfXuxTPl460UM8WKXuB8CShBIKeCVZfJ552EwIgWQ5trfDjE?=
 =?us-ascii?Q?2ivWqemnoB/FCb3GntLpxqAtEl6b0xiMyJGRqRp/lP6yWYgRndFXdfG/Uzz3?=
 =?us-ascii?Q?5cX3GL0tMaZRrNRs38zLGZbWtbz0t0SOWddhNycl8/WRqUUWFBrKWWDsxjMc?=
 =?us-ascii?Q?CqbtdYj7DUyLR9UYy/FnbT54wtoJl0KZSQMYQ7ScwEBmRF3n2ZbL7v8vxkqX?=
 =?us-ascii?Q?DHb20q7pk0Ha5ZxSS/5xGgegjkUeqjWTq7SX/vwWRtpz2rX191MsEeqc88w9?=
 =?us-ascii?Q?6ksz8L7Qwd2SXtJLrwdWaaE15F5lMrr/E3f9TdAg/5Jd7OPj1MaKHubuIbBq?=
 =?us-ascii?Q?wY8w34a5hLj4lZRnr5TnHrfnnQy8gxlxyw/YDkDi8B0/kxPmwxoVBvxgO/4X?=
 =?us-ascii?Q?8KBlm9ehsm8H5AQInw8c1HdbUbJgNzIFUrIyAQ2oIXPRuHhuds3eGG+pvqZ5?=
 =?us-ascii?Q?9ywpXkXKXoU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9TM/LHL4xhxr9wkQWh/8sN+m+LpRl1HRjXYZLnIJcSaOoR7x35sI0b8P4FZA?=
 =?us-ascii?Q?MzeP63hDH8jJhvdJlRp+CXpLd/zN1wcaMjHVAR7UU/uOb2eIf84o8HyUoOfQ?=
 =?us-ascii?Q?82sbOTPyN+sZSNMxT1Uh4sxpUP3opvGAuHZeOhwax5C1NsA1g0Xv6ClBx/3e?=
 =?us-ascii?Q?hEODVseHMtRlRr7u5xZwPjgz3DhylV8iiw//lwwSpGcubBbeAYeIYuKGrILT?=
 =?us-ascii?Q?I3VWq/3OsgoNImSYQ51KKpEviLXJEoYcy2seno5K9zELa6bp8mM9qHV8sP4N?=
 =?us-ascii?Q?JUOw3Ze+yphYO1/M/s+paLaFWnNqDnGIDkJfOeMWIYpo/lwPgtSlCLTYtxnw?=
 =?us-ascii?Q?m8xhXa+nCykCoP8a000D53z51NXruYylZmv8n8BFO1v8mrWTdvNUrSVLy0iE?=
 =?us-ascii?Q?+x+2x97+b9fTuZGmiNNO0jNtQ9K3+x6nLKGbBIqBsZ9rFiSnFAzdw7l1QBhc?=
 =?us-ascii?Q?RsV+1MlqIlTnzw16/lpXMUHNb87nPnQ4YD/F2JFoSCNzBGlQZqMOXnTIRWvd?=
 =?us-ascii?Q?/PFbsrtereBqr2f4RA5X4ao5jUOioKz0Z42PrsbKSKH8IDQc3Y3ZgfbSl16H?=
 =?us-ascii?Q?14AWBxTLSMmPO8RlV4iPjML890odMlx9WlKmANvkAZ6xdS53sbJB/Jcm2vCp?=
 =?us-ascii?Q?zsjVTYzTcG1L7FXZtsGXsKfelzsj6dzTMV88D1C18uxTvVCTyYJ8QbzLCSPd?=
 =?us-ascii?Q?b+r0csHzxtSTAsnUARUR0ATKKm9ID3Bu5+p4ITvOTNNVzRuRfnCodhgzDHMV?=
 =?us-ascii?Q?joxxHS5CR1jiq3nJBhM300o8nZOoR4QZwUb4srC9v9cfg74A+jW6VKYR2HfH?=
 =?us-ascii?Q?ci3AfmJ2PEQshXrlu+zBFjNFhnSKeEI2F5HMkNJgdFLfHNDsOP94yHyR5Akq?=
 =?us-ascii?Q?aIJ7MRh15YUsXB665hjbmOrrkDZniZ8Jh9SmKobrFWZzU8X7SvgtI851OH+p?=
 =?us-ascii?Q?fsDjb755D/uv3H42vVE5ndTRpi4Xi+8/psf19+jpVwxJtrDhe9n9dAfUOTfv?=
 =?us-ascii?Q?egievi1aDCFGCGl2Gld5IaRrJKfzK2Iw0tXNRloK8rZ4zlD1NtUWvTZCi75P?=
 =?us-ascii?Q?7M+uAw2FobM7TkguO3lSPleXaN5dZ1EoYnbIUM83Di7ryhqFwycEI+EztzxG?=
 =?us-ascii?Q?aHrdPth4/jFa8TJE83iG5M7WGUyUITYZeHM0Vc72XO/biv6ZDBQhZrv7JO5q?=
 =?us-ascii?Q?aJ/mtCKEWFmaME55EmcnaAy5S5XMJ7RfozwrFfehmqDNjLhlu/ceajGwiSc6?=
 =?us-ascii?Q?3g9+uZKi1gSURmv7o4D6Ni34s1t73h5fz4FMKBUPBBcfTlOA9jWGrC5YDH8l?=
 =?us-ascii?Q?1FcHuj+9kHenZqy9JvZGGh1Wc9jh87PeatD9PZr5/BpKjFAe37FHT9MfioBl?=
 =?us-ascii?Q?MUk9wtZDtajwpKZ6Qe7YmwKS2Kxrhk25H3WtMhXV3jZ7UynzTM5x1/emfBeP?=
 =?us-ascii?Q?LJ/0SpWQvBJYSJJpqgHeJ4av4w+uoYLSEwuNlGIdcX5rd228BLvcJPXEN+3r?=
 =?us-ascii?Q?pzZ4/rdTRN92blYgzGPOw3uNAo7zU9hfjIJOaxn7LSQS7cIPi1xSldRCeFAn?=
 =?us-ascii?Q?cxBWXtoS4Y3Z3O8g+Z3C3i+/IkS3ZWG6vihYEx7M?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Enp0LUopwvLNI3JCgPHA+qokW8vSZi8q9QnvXkBvtI9D3cRjXWD1pE2YdJ373CcrMPt/mzdC0BJAoz4+cZXdelztrIAUqFhgT1OKjYPFXPnVea4Gzw6w1YCg6fIUtrTiatBChZ70cdYbb9+HyoqWNHWwBBiM5BQnwFfNhtQrtsyvE5pBRgJXZQ/Wy5yTXkIVCFLq86jupk7NG5w1emL1x0mcDZRCzk8Or1sHmmR2wg6POaL3ePO2F2/Oiv4bRFCxxCwWDsy0+XnnLtcOFp+0VvRDyX7ceyXP3XXJVZLG/orV7EaYWcUTUqK5YHqzpAevZOIA6yzQ1n0cvd7aCdxKh5ImQtE2KaOuAzN24I/UVjKHYY5WVS1zNCF7oVFz5lbY+DYuLSmHK7/a4LipdHQ0K8a1MlZO6JFdS7vLjAwT6EDg2riPXBxucmHOxnUIuHHZuycvclVsdyZoHiaNPYFu6G1MOR/z2aDgJVGUfLI0LEGDwWNhJJ5aie0rdzmYTHWQlnWZzOZ5+Wup/bsz9CrEUGdCQ2eUvGmeLjwiBUSnBpclmxkmK7/2zDqMogrkhU4P+zmvAYQSMySFEhlTrEYrXTD4Ar/NOlE3Bn8Jt30Q9MfIshEqkNR3iTDm4X2ptduS
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d125efc6-ad1a-44e0-28ca-08ddf74b40d9
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:07:53.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdrRlu//o/59dQif94QwWodjI6P5asmhz9bE3r/W4cOqvijkW866FX9Wc6gVY5seYV/+BB7xa7+Di/RN3yLgEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF9D10A4C88
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
X-OrganizationHeadersPreserved: AM7PPF9D10A4C88.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDA2MyBTYWx0ZWRfX0C1Wk0nL5XU3
 So4DOLVYID7qeJnX4LM4g6MLsv0f0HffZEwlNfzH02Vt8zd+/30/druRyqyYJmzhI6u5PQx19iA
 VwOfhhoRxTEzp2cmUcV82l4Qvq+NU/js59BSEs5lIXTh3CZRlx33KwYGI1lnPrx0Ho+Uh+9aQp2
 gius9NeIfJ0rtOkuxxLtumo+RfltI4b/Tttzs7CaeozHMdwFpWxR6dHoDwT+05GyI82cBveSzgm
 DuTAttgk+H80EXa6dHiJSA/tikhujPUoRLrdcC2a+BdqCDCxtf4kwB6FAU/OeLyL8+vdZIf+w9a
 YV3dkUKVdz2JC59xWBz56EqP6Ezl5ZtTJlylk26yA9Ok3dZtNyaGOPgeBug2co=
X-Proofpoint-GUID: 9Cj-wdZ4t28U535SvmJWVht3N0cK-y8O
X-Authority-Analysis: v=2.4 cv=GoVC+l1C c=1 sm=1 tr=0 ts=68cd014d cx=c_pps
 a=V59pdZ4g0JWSVNiqYUCRRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10
 a=oXHnMrK1vIW9SSD5T-UA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 9Cj-wdZ4t28U535SvmJWVht3N0cK-y8O

On Thu, Sep 18, 2025 at 09:31:18AM -0700, Jeff Johnson wrote:
> On 9/18/2025 1:53 AM, Alexander Wilhelm wrote:
> > Due to internal endianness handling within the QMI subsystem, all QMI
> > requests and responses must now be provided in CPU byte order. Replace all
> > QMI-related data types with CPU-endian types and add the necessary
> > conversions to ensure correct interpretation across architectures.
> 
> I think you can break this out into a separate patch, but reword in a manner
> that doesn't indicate any dependency upon your series (it can be a predecessor)

Sure, I will do that. I have only two questions:
* If I split this patch series, should I start on each one with v1 again, right?
* When I mention that BE support will only work on future kernel version, should
  I better avoid the "Fixed:" tag or not?


Best regards
Alexander Wilhelm

