Return-Path: <linux-wireless+bounces-29088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E1C68C0B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40A5C35647F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509FA33B6CF;
	Tue, 18 Nov 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="mdiUyPFB";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="XUdsNHjC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC26339B51;
	Tue, 18 Nov 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460632; cv=fail; b=ROPG8KsaWZJVu4PN3vgX3yj4HVvimXD/GMkXgUfzKwx4yegNQpSOnIp7hM7B/P18E/ygpdqDmgz9gXb3fqGWUYhDONIu0GkHdDlBgylkTnFNGkjNPSiKQ4BEMlzCTVPlQRWVcD9Ek7au7nTc+3iRgxtrNUfkiDwAc+XeYuQdhrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460632; c=relaxed/simple;
	bh=Aii95n4/u9pF2ey7dNB0EKavOVfbObWG6ckofafZ4ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rzOmZduYG/yWTcbigBbfF6WJ9k8GM77JZIb5AwS50GSVNAoSJFBhblGRXpuhBixs/W/whl+Mo9uN8foiwdgKlpm986q3tnV7vIhM/ewnt1yvQmp+mGzAIPZ7ZeeGBa0eaotKl9Lv9xI3ciLb9fr5kycpvh2x/luwk9K6XfZ9u1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=mdiUyPFB; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=XUdsNHjC; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI5PwwI1657846;
	Tue, 18 Nov 2025 11:10:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=gEK1wjSaM9tvbj3d338joujQ
	vUmKQHYxSEhviseRfxk=; b=mdiUyPFBk2MwQJw97FQ9uf+/uaqJ/QsAZ+oVAewL
	CsRLD4sbfv44zO8n03nzPFysfAiYbo5+MYb0E2SVLamz6Ck8CCLhGB+u7c2V01YU
	vs/7oOGrbhXRrX7y7t6tybhctXrzze7juy0y4/n9FWVDh/fIAnNvYrezP5fuSsQv
	VPapX6HKtXZHRjkzLpT844dArdJgtz1dkSKVVtd3IM7wNgg/GThtRSIsObuik1W0
	Kd/4qMkvVaMaz3wT+jM067xti92tstp4VS4eXy15Ag96yC4SxtV+nbL1eC3FFbYJ
	DEgqjvoFKUdQeYgNOuc7atqZlZCLoq3fJjQMf+MbaKsOow==
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11023091.outbound.protection.outlook.com [40.107.159.91])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4aeercb2tm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 11:10:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+vJduEF2tYlMmZJwnR03o7R6OvGJYs4JdDlEiKRYh6mWMMNRkGd0SVxsj+uhr7QcTAPXXMNP3am7cSbBn/jkGswIKMQPnc3cDMCwH1xZJEHZTQ8Oa9MlD7dkaPQJRWabIQ9Yj9+WvdsORy9Loiz/BoG5wniaTrasHIPdjN/yh9DyNUETMzpHlNepn3vY+dhB5YxWNz2NICsXVHSvvxv3L/2gm8jdWXLrR/RSn3vAEOJA+NxbAT7TmsrfM5sdjBqJVKarqZdJNlHJmT46Cjn+QeMZ53pktZ7AAeARrTowcDSM5lodF5JuyNtVl0OZwnySqjB5g3RGbiYqysaxbKg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEK1wjSaM9tvbj3d338joujQvUmKQHYxSEhviseRfxk=;
 b=yis960X4UWsbWhGhlUXME3y7ZemJPnB6MZ8pfbnOADTLrpFxH6+p+a4n3iBHluYjmGzhUTKt8DLOThs/Qy7kkvc53Q+hC1fwmwZS31JEmdz+El6Dm2p6ESwWljiBpmy8DRyPqOGx9IUpDFIKGnh7oZB3VnANq2b4QQuv3ZQ4wS9+vxL/ILdUmIJWACkwQU4ngFqnYyLdnTc2x8k48fFoHd/+NCFEho0zoj29U88228cg95cqMdfgD51x2KtnmCHJMVMK3PZRX7H0L6CvkdPRV2DTbZ351+/AoEb4ZRR4C0WdScu+6Yep40MQoc6io7PaFQjkhS4qpNXP9NnW9P5lgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEK1wjSaM9tvbj3d338joujQvUmKQHYxSEhviseRfxk=;
 b=XUdsNHjCIhSdn7mEa1+Di2tjLB3As6PclMwJf9sNKKxKRDu1DVeuf9jj8vPEdMlfWYF5Fi+uxQkpantVSKbwRCeMUWGYW+jQGCtjJDkC3cp8Mn/Uf+8mRzmtCD0tkvkpvhNgK2cLE/EFmim5wWibXEiTXujRUC4aNefvCOiWA0A=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by GV1P192MB1905.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:5c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:09:53 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 10:09:53 +0000
Date: Tue, 18 Nov 2025 11:09:45 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
Message-ID: <aRxF6S72ffPclf6n@FUE-ALEWI-WINX>
References: <20251118072123.19355-1-alexander.wilhelm@westermo.com>
 <5a308d21-d463-4d6f-b5d3-95a0c2ede2c1@oss.qualcomm.com>
 <aRxAa8OYCZqEx7Da@FUE-ALEWI-WINX>
 <ddd31f03-8312-4e42-be97-2d2e1b390c76@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd31f03-8312-4e42-be97-2d2e1b390c76@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVZP280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::10) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|GV1P192MB1905:EE_
X-MS-Office365-Filtering-Correlation-Id: abb6fc8a-2670-4dd6-5491-08de268a9e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HC6tuzaLBxMTVM2Efcac+kba0SoRxh6nIjYCuINdiPZQcVec6RtNVbnaG4nM?=
 =?us-ascii?Q?8/Ow6aA4/EBh9hNPfUpjQLGfasvXW4J1mKcYnvwgIPL9RvxYPYhFQxEVoNyy?=
 =?us-ascii?Q?VYnTa5w2oxz6ltUqg6BNZJUvcAxbjAeCyFWacTMedo3qV2NioP8UqZaN8DIn?=
 =?us-ascii?Q?K/HIweFBQLsYNojLrxW3pXdGw5Zwz5T8z92QZMR7+WmJa6HfHd0fT2ILXr8H?=
 =?us-ascii?Q?PmG/fbLl2xYy+ywy+GkZTghGOgnvyMjWkcsEelP/k3j0FqTGRr1Bu2fAWppp?=
 =?us-ascii?Q?vAPHwTQtakN6ucmP6nIJA7hJ3i5spa2JErbnXZDVQCZRsLf3hRLGHb4koPU3?=
 =?us-ascii?Q?ERufJ5rCVb/PyjNm9d2ut+TrQBuemNtlwmE730A1tJcEtOb1NnVDl481+4lK?=
 =?us-ascii?Q?On5hNndHfsovHVhFRhcX+SG+LsuX+yfP51L3fSlN1bm7cGCIvUDlBhyNfYAa?=
 =?us-ascii?Q?MaBKaKfAxbVePdBON1xYqSfO79TCRhiuBNySEwYb+RaJ1h3rahuTZ/lprMnH?=
 =?us-ascii?Q?OvhziFXRi6ar8C9Tcox65HWjdumkY4GEN9vefvs0J1fsJok3FHqwXzBcVWh4?=
 =?us-ascii?Q?LLpbhXvD1hApQ0KFI/Dmqx/gdLDXbc/VgnNvOABcVPiiTI1cc7lnnYCIox2z?=
 =?us-ascii?Q?JozGKdh0rySl8AZE7gz0GjnVlCd5lvsWc02B/0D7P+Xo70PvJ58apmRe76sA?=
 =?us-ascii?Q?uHe8PnTxT22V6TkF0wbM7xlsLPr14nzOT2xn05uAWqu/zBD3eeEZF6LK+UxP?=
 =?us-ascii?Q?vd4xaL1JJt6rHNoiB9izcFX0KX2/jTJCRyple6mrnYWTy1OISo5MC+Z+0gwX?=
 =?us-ascii?Q?0CHhmWvohu1bpwminy6gNaLCnzov7F4TWs5eRNv7emCOF/OmYr4MmzO5UHpr?=
 =?us-ascii?Q?/TOBOhFSu9yTx6x6zp8sokGkmZmVzubVWjWRyS6AlLRHLTzFa+EREzl30GOR?=
 =?us-ascii?Q?3rB9Ue3IjxpOkm3k4skS/unf+UvrnUQi94m4FL9N3s84yEfpfr4U1CvaOq6s?=
 =?us-ascii?Q?cW1pDxu37ZMaKeEuXHOQmwHiy2a9Lqot289Wbx+gygLSYZJooWEb8T6hrtAv?=
 =?us-ascii?Q?7Rt1OYiB1ZTwHteCQQcp84rY9HA1JFuRSPfBtO5SFR1NYYE5bfzOVm7FyMEL?=
 =?us-ascii?Q?puTpahQM03lEiPFdg6BXsz8SV7q6VBwWrGSF1ZKi6DH7GbPwO9lTRmWhY21K?=
 =?us-ascii?Q?klWDV/J/5NnCilqtlKFYnMoUJhazyZ2JxGBotvkwJbRVGjI407c6CUsrWvC5?=
 =?us-ascii?Q?IoqedZmkdhUsZKGzn5bh/QIvnZ7vBuGanB3ASj4+f8driaYhvU8+7UB+IBYX?=
 =?us-ascii?Q?oe1wBDgONCWZ6zSUlgTSsKjSfHu+GpzwoE3mEfFt67ui4VpSVSirwPxhkC/T?=
 =?us-ascii?Q?BWDl/KtK7tfTgT0jqkfQ6PkEDpZ3WwQN2IFvBszpZqzl7JgEuNmcEW1BaST/?=
 =?us-ascii?Q?fdQtlU6dcpVfnZf5IiYdpT2QUXFqjEc7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zseglap39Z/nJkPj5bgiCXZE0MxzIadoHWfncZak7p5O9y3lBXi6GJ/lmRfq?=
 =?us-ascii?Q?Ultc/CYNHJ9VNmyVq3mTVudSs4CDQ/WIm+HMH52v8wVzcIwe0IDV4trUm66Q?=
 =?us-ascii?Q?VtThlUjZdhGGh49P93U5RnJ1JE2soE0iIOiRomwwARb4DbBPdiZISQZaa1df?=
 =?us-ascii?Q?vZH5JEzuEidOkLG5Rd0spBpXE47Wo3t7NjJ5CDI91QO/ZzUwXw0KCKYa5W8W?=
 =?us-ascii?Q?Xtc24aqpTCIRQxa5lyyv5wOPQksTFlHxyAj1KyTB3RZYDcgwHhQBgaw/pLbD?=
 =?us-ascii?Q?QcBBqemaH+X5V+TIwj7yJrzpE3gL22ZcUKuaKrEOk2tRswLzb7AsSHI4v1OO?=
 =?us-ascii?Q?g0ryVTRQYq8PBaCV2sSFlPiSk0n/ic116ZG1ES6lohkxr/yOoumwwju19er9?=
 =?us-ascii?Q?4ThcfGzI4n6ht8pggTIifalbZaD0HyumyBxOFwa27msrsq6jz5txX69K8Uio?=
 =?us-ascii?Q?fBPl+rp0cpYZKlRDWazV0+ASPono4rUoahHmy3GrJavhc5fPIe3jzwDvz3W1?=
 =?us-ascii?Q?F7jQbKC+9L9ANuDOheTtcvNoFIVUl6FtuGBJEMuMazrz/HVWewHk5SFzq+3o?=
 =?us-ascii?Q?A04TMViipUcgkkAm6x6m0hK2GIP9qsKAw/LLjijfVnMB9w3NlIZTJNVJsyfj?=
 =?us-ascii?Q?U4i1ytEsPG8VORx4h6eCmWtVbqohLbSkjnfqlp+acdJWcfCj0P8korLu8HmW?=
 =?us-ascii?Q?K0Tk2Q0TmKA9omP+kxA928ev/+thjKKpxFHfrfFhCyKamprVPn5psqkbJGfN?=
 =?us-ascii?Q?2/tmtUH+nkhNCbtqB1RKuorE5I5DTSSnGDk3vFmpMcPs0LVAJ0GLX3+CGPg6?=
 =?us-ascii?Q?NU8HZC2ACsX7aseqayCYsyBf043o/Vl6q/eVPb52ybRPD9zaH9nkArmBsxHQ?=
 =?us-ascii?Q?PkdcobjH9om7t+h2jzk7OXr/HPKPdF7YK45i9BrNtfV1SAzlu4JaunkWx0F9?=
 =?us-ascii?Q?Un52emROpVK+WYqXUfFEaZwcGEumylXiY3Q9OoVZBgKnpWQ7MCqgd0ahu3PE?=
 =?us-ascii?Q?WJufBRU9mDO1nuty6v7o3M+BpD5rufFLGQTwb16w/vmWxF/yUnx8olQ+YV6Y?=
 =?us-ascii?Q?+/LtNFsLlVVW0Fae0gJdFwlB6f/4koblfUDJXpg0qQ42dMqLJxvda1cSk1RB?=
 =?us-ascii?Q?JAFfdJP1WlKjRoYmKpFZvHQo1jyCfH8zhkYeCzTYHPhBP7L9E6q8ugxldtrB?=
 =?us-ascii?Q?kiX+U/QxEcJAH4h8u4yBrHk/4H1CIwCf78mcG6uSoe+GOoolVGqXttsCw+HI?=
 =?us-ascii?Q?tBYgeFWsw8sa4ssEGMlMcpLlfUOHCuPXTae3L1Fyt3UnUzAlXBM2DL1PaYz6?=
 =?us-ascii?Q?EawuWZpfEW8j3q5s+MgDEgzVQjjVLY8GJ9n255nUfc/Y13hEuPIo9awGGroV?=
 =?us-ascii?Q?E0AhaWDEfm9FKUgl0aQAtw4cai+4fIGJ8iNBlWwE018r/JjecVhyQSt7UkZI?=
 =?us-ascii?Q?EhVj9yYKhiDPu7ymzwNs/wYK7rCFdp2c7rIbNkceWeZr8ss0mGhut8OM6MfP?=
 =?us-ascii?Q?GYl09ktnYTt4n6k3ne5hsSf4SFiSjnon/rAuf7NOlER4xBfX/o0Q7uqwfpUm?=
 =?us-ascii?Q?yaWBEZVgUEknp2UnQePFc7fMo/O9L0ZHMdxQYmtT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WKvwW9Aox9gaYoJQnzxvFoJgnns/McJTjesxjEMXr0QUo9gFOIlm+cQfVVZQip4YJTkfkeC4n5iTDMThGUFejlV5SgVIEdAzvDunFKysTGc7nbOszvpxHS0bTuRL7rlEkl6E1FFI2mFerxaq88wY0HRTl4W3xhLD0wuhPEDUFOaC+2wyYQKFqgtkxr7xRjNhNJfAbI4pF6gLRmBZ5LwfXRbpJdd0VQs8b8i2Mjr4vsamvbCd4Nj8yOMO7QZDARywM8+MSePg+15WqSm3u2XgmvUz6ILDd+9vqYMtFQrQW3FImEJxvUmg8HfFRBLplJaYK4n+W5MBhQWAono11IxphXO1zI3Zm5IqrPHjMzmD+vHpf+bEf5ZYoA9dltTowRWxky/rmPFSZYx+41m0UYx9bbAJH2D3aaSQfzS1honYjw4nU6cJnIrQxgCv++O9qDja46bORNTeMsX2TRePjtLPiKpw9z/PVrO09DuFID69V6cPNYDerXTYm79/Ga+zbLQrAPrAGR/gpyfqsM1EThrkEzdT6oWYU5si4yZDCKTjn4vz+EtFa1iyQJvWw/szo3bLPqLhaxMhyqNGZdnrn9QAgjpmRAVnxQ/QtsYhYkK9WbdyBFcL4LNF/rfVa+M9AWpT
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb6fc8a-2670-4dd6-5491-08de268a9e60
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:09:53.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW/KEjUfDeh3pokOaGkLsyceJs/ZvrF1+Jp1T8i6pRIO6kxp3RwR5wgYN2uTgaPc7AQecy0J3eGiiNKF+2IDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB1905
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
X-OrganizationHeadersPreserved: GV1P192MB1905.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: XUvrQJiYFMw4eLz2pkScRs_AEmiZqdKf
X-Proofpoint-ORIG-GUID: XUvrQJiYFMw4eLz2pkScRs_AEmiZqdKf
X-Authority-Analysis: v=2.4 cv=Qflrf8bv c=1 sm=1 tr=0 ts=691c45fb cx=c_pps
 a=e/k6VX1VYAYNZ/0Ig0h4GA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=iqf11OhCi6XAIIoteLkA:9
 a=CjuIK1q_8ugA:10 a=PZhj9NlD-CKO8hVp7yCs:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4MCBTYWx0ZWRfX3Geuj6q10qiM
 fy0B8GMcGRjIn1W5kdoJRDIvXaPoqWzh51drZdxaXQXkGunUD8fPilasL2rK+CuOAUN9Cx0O0AL
 IBYorfgBXxQgmTHf6LDIaiXGsS4m8dGPw0S87y2+5ZfYMCFOBMPOAIvVKVGYZ9FfjFk0BHSusuo
 54YdBtfZMFGZGAmmL18k8FrzuTa3evX95sFgIhQ/0pYpVZgA3bte/LKGR20Ho+9czyiTcGeLvb0
 yCt1M/CpEJDloI95ud8b5ENmJIU7K234hDEXqsI/+fzSiuoqG4Cmnzs+CD+aP1LdEPV4GYkAdGW
 wVhXy1uT0aGqMpu+XmWPWDBup/xdTir91w3NvYD688NbZ2v9V+EPEtRVTAhvDDJUSGse8qKQsNU
 /5Fqc8rmjYGTHeY3np/aNhOlA2eYeg==

On Tue, Nov 18, 2025 at 05:53:52PM +0800, Baochen Qiang wrote:
> 
> 
> On 11/18/2025 5:46 PM, Alexander Wilhelm wrote:
> > On Tue, Nov 18, 2025 at 05:35:09PM +0800, Baochen Qiang wrote:
> >>
> >>
> >> On 11/18/2025 3:21 PM, Alexander Wilhelm wrote:
> >>> The SRNG head and tail ring pointers are stored in device memory as
> >>> little-endian values. On big-endian systems, direct dereferencing of these
> >>> pointers leads to incorrect values being read or written, causing ring
> >>> management issues and potentially breaking data flow.
> >>>
> >>> This patch ensures all accesses to SRNG ring pointers use the appropriate
> >>> endianness conversions. This affects both read and write paths for source
> >>> and destination rings, as well as debug output. The changes guarantee
> >>> correct operation on both little- and big-endian architectures.
> >>>
> >>> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> >>> ---
> >>>  drivers/net/wireless/ath/ath12k/hal.c | 35 +++++++++++++++------------
> >>>  1 file changed, 20 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> >>> index 6406fcf5d69f..bd4d1de9eb1a 100644
> >>> --- a/drivers/net/wireless/ath/ath12k/hal.c
> >>> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> >>> @@ -2007,7 +2007,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
> >>>  	tp = srng->u.dst_ring.tp;
> >>>  
> >>>  	if (sync_hw_ptr) {
> >>> -		hp = *srng->u.dst_ring.hp_addr;
> >>> +		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
> >>
> >> should we also need to change its type to '__le32 *'?
> > 
> > I saw that in the 'wifi: ath12k: fix endianness handling while accessing wmi
> > service bit' patch where '__le32' was used? Which one should I preferably use?
> 
> I mean, should hp_addr in hal_srng structure be declared as '__le32 *' ?

Oh, you're right. I'll do that in v2. I'll set '__le32 *' for 'hp_addr/tp_addr'
for both 'dst_ring' and 'src_ring'. Thank you for the found issue.


Best regards
Alexander Wilhelm

