Return-Path: <linux-wireless+bounces-38495-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ZKOFA0qRmqSKwsAu9opvQ
	(envelope-from <linux-wireless+bounces-38495-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 11:06:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E56F50EA
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 11:06:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b=wu94fUYi;
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=T2gzaUmQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38495-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38495-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77F1630DFD15
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5A451060;
	Thu,  2 Jul 2026 08:56:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F844D03B
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 08:56:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982614; cv=fail; b=hIn1fEM0pyOfCXOtD8Cv5EkIu+SM2Wo4JOWJxTW/qHBWpy6DlAK1TUDnafGijsJzD/mayMIcFd/N5R8gQSu2Fg14y7iIdauC/iUtVFVWvf9GAvsPVE4ikJUSmvC2X6u11x1a2c8pjvFWkAWaIMLQXnZ4HgjGgkWQMEnzI79a0ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982614; c=relaxed/simple;
	bh=h+E9tJADhyDLOmBQEKCiQdLb2EVBYoz8g3OHDrC7024=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtT1sNc+t0u2BLyvvUhCYP2EY9hhpdFO8F4hPBFPGb9ulVEjWRh1r5LtS9BJ8yeDGpFQiy3LqKa0r/lve8vxlt4NRAhvvyW64bGsOwJ6iTv37XR9DcQcUaCAfYWpkXvBnduoTDw2g5OBcxTGQ9zZegKzTYGtzSfhu56OITL0suw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=wu94fUYi; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=T2gzaUmQ; arc=fail smtp.client-ip=185.183.31.45
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624oARd309780;
	Thu, 2 Jul 2026 10:56:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=uEo6PGkcUbjmEMuBGJSiS3xN
	EbkTmvlyokbWXufWfdE=; b=wu94fUYiXxn98VZnkmC1RmF3fyvN0SynhAKUcM+Z
	sHsdwKZvKS4Wq6q0hX0ry4JRgaulst69GFRBG2Q++6CyZ8dz4lkngaym/4xcnw9v
	g4c8EFyVd6J4pmrszcWt3r4L57snWepomMD/gnkbp8kUlnO/XWmhauGrD6AhvAOB
	YlpkuFmnmxSdJFe2V2IXXeRiSm1SZ+uUDuUaZ12eVjsYnzAfwY4rApH/EJwMRz2c
	NLUYUnaQX2lvK9AVx5TLZr/VXlDS6OOmdXQsbTwEQn+pcDaHuuiJTdntTDNzymlc
	RSVIAIqMEd91Chn3wKK0Goe92lp7U7WaSnjwhAIRQ1bV5Q==
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11023106.outbound.protection.outlook.com [40.107.159.106])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f56sg0wfm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 10:56:36 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKPvFb4BJTnG2XRk7j2hzf5NTSbn+Mtjf9Ef/UNcPvFOYcR+lfCqj6eHKvIBIiI17yR9bP6fm03hDKlTG4Uzu2otDo+S9x5T6qv66CO10Wq3mANqP4Yw2O6fxuqKcfqUbkrjkwkKzlTOVr0x6kYR4pjNSmsPhuYrx8AGjjLnzBNK1cqoSyfM1dG5sfdyKELncID7GwyZYroucjPO/BcORyoGIMWFR9TdHoVO1jV6dVce79u0IiG5laO3nU6B/a+I2KtBjYuGEPHNvr5M5L00nkDi7o/VZ6FquUiz3LZPZokkfW99QYA2v9UHNPdsF3ueducmyciDr3otAwVkDMgHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEo6PGkcUbjmEMuBGJSiS3xNEbkTmvlyokbWXufWfdE=;
 b=DfR1/J+3bXHrZ2ZYO8v3WECbkTEZwk7we0p5UO+BWKQh3xJ+vNTja+2NF39xr7P5N5RpJ6qIqXeXczxHsJemd1dowpoiHYOuZjK7Uobb0Q6m78M5fA/AOfsvuTNz2fTquw/HjFvFAZz1yJk3qGqmc+8vqlNu2XjcwXdLSUnY/bjt9eEYeIHsupEHg2ZbWV7KoeYvMQ/PH1On9sIgrZTY07ypJ/JzKTgiXPGc9XVCj67PjmOKQjEr+gxAM8KM4SKYOmgySVv0xtTwMBURUhzYR65A24jmf4lyY2o4+Jq1OtjzfTLrNrP/6apRi2n1qPWaxRYGadUhRI7QEqJx2wPwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEo6PGkcUbjmEMuBGJSiS3xNEbkTmvlyokbWXufWfdE=;
 b=T2gzaUmQyDRk2pqXjcxrxBXt40a8Sb3rRFIWLbGtmNrSdTv0WJKqrxH0DXSwj2T+26726aaLMwjpZL4vUs7jcsXtySA+6KZMpbFXxqz5lES6ULjstX1UyKYsTzuLFITpzGD84PLOJO8lmxm+9M4pkspvlNYjf7z8+o1+It5oWFk=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by VI0P192MB3248.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 08:56:34 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 08:56:34 +0000
Date: Thu, 2 Jul 2026 10:56:30 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: ath11k: BigEndian platform support?
Message-ID: <akYnvuVkIQrPcjkO@FUE-ALEWI-WINX>
References: <68290980-5bfb-c88c-be78-954f9591c135@westermo.com>
 <87cz0y96j1.fsf@kernel.org>
 <akIuPiYGXDbDWLGZ@FUE-ALEWI-WINX>
 <a412f206-e856-47f8-af74-8eb268ed50d0@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a412f206-e856-47f8-af74-8eb268ed50d0@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVX0EPF0005F71E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2c8) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|VI0P192MB3248:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec256f2-89c8-489f-cb7f-08ded817d158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|18002099003|4143699003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	WtErLKEzWjc2jdDbkU09zW2aS2s3ehgWhNMn/QbFpz2+4CsY2pWVTroWijbHOJCHhe6wOYpq5VejSxE9YC3bJuFbL9EtHe7fGTCr2QutV7lXyhj7gvCGAAQleZqH/DSuMoZnI6Akp1JGgxL79RNbBikPwVLiBSmv6kq8QvyOcXd/dPhNRJbGPyyfTeE8gWPqKwd/mehZnBikAXZ4ahQZgFpJiWBRtECtUFW5XxfMWO6mw1VAHsMwlNzHWkwM/NJ3LCPE70DgImygBTghSKkc2smx7B9XCYgh7OGWl3eJ2XmWJkOuIit6RYjI5vYQpwvYAQYIChJpyyq2QTpq77fIP+4e4db9oapg+bY8qosVbjlRUClzz7lTECMbq++k+JxDPR/ydY5iNT7sBUwLr925wFkcyDGOSlHp7zGW2kgjy1U9evJN51U4BKvlbl2mhICKpoSPfCzrRA7vU1AUzzdK03UG0N0B6CcQVu5hUUK6VGfN0Dlo8UxDpPfR81EecubrmGh0kmoajGRsFhBG7UJgx+LASvem0XqPCYSTd6sBBiFL7qbk3Jm4wlXE/5TtwRonaYrPhv4sv98fdgbsq8VgFWlYaEp/hcK+3ij5iWOgdDXal/7snoBQXcfn5RkyHMa8pDdEtihinMWOXLTCJypmRQdtklfdS2deF/WtDdQaLHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(18002099003)(4143699003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Z7wTV/+sqBacVTciVlB6NBLJHkHFvXUtD6AXGd6qqsNjcLEgAFsLtD7KLqS?=
 =?us-ascii?Q?RZyd6vi80nC9Yf+0wE8BKElV0vShqdO1him96UKTFTxeToSy8KNExXO7MXwH?=
 =?us-ascii?Q?YF6P5wIWx2DmVOUL2LT5a48zYtOVPNgQr5TplISX8l8+qdBcd9n1azzwYWnN?=
 =?us-ascii?Q?NEpIahDNLCjyiN68hg4NfdhfeLSWBFszqQ00VFNxVekE0dcvDxGAxO81szhR?=
 =?us-ascii?Q?aq2UY+PYTFPMuYfmLY2HPRbrAcYAAe253bU9ugiS61yJlHPa8f+XljUIF4NF?=
 =?us-ascii?Q?UfC3gmTky61QXA8oXr39/TSDWzU2UvH/60r7nF9LarsTmfWGAf3a1K26KKgr?=
 =?us-ascii?Q?JEV6a6gQQ80Gov0dkRzWL8ZRufnwoJ1EnXygRtEE2lwJcOXKJfzX/+TsLN+x?=
 =?us-ascii?Q?w9CdASSBpd0Aw/zoJ/ravewldDhuL+4axHuoetgaiC56n9daA4XJzW/+0Jpl?=
 =?us-ascii?Q?mFGimD6XsFUMYnR6lV9xrR2sqLWV0gpTMyn26MncLaWYoZnAjFGTLNgwnipe?=
 =?us-ascii?Q?c+BW1e+hg8LgYUi+ZKhiud5ydMQqeIMqbQ+KungU3JOdqqbvuhjPxrW8Skt7?=
 =?us-ascii?Q?YFTXs97iu4rOkHegbiFUzpayZgooDZigVk2KdbWzkx4YznricNAuhww98T0t?=
 =?us-ascii?Q?rL+CAYZ/fzAO/PVGgiNUoAgo685TGgFtrLlYxNTL4Gg0gTN/PSeCVKJFHebJ?=
 =?us-ascii?Q?d7tLhAzmOAiYD5QnqQbLUoRDI7wbE//b9sUqae3lYrhK4zvDVj5XXbM9hhxV?=
 =?us-ascii?Q?VWKw3TcdczpMNEyYb83Y1UksP5pgewlEqHF/SNd84PkkxQydd2OBscLZlRB7?=
 =?us-ascii?Q?WQMOSOva8zd3J25te3szZx+oErvKH5agjCFjaecdSWxG/ntwheFEv1BBo/PG?=
 =?us-ascii?Q?S9k/eI+UFsQax6BWlUjG3iBAAHbvDnYLQgYBXXirFgyRV1qbLpHoOlKpcHVY?=
 =?us-ascii?Q?ZJJ80jAIK4d+NG3TicSpcm7dLS3Rj/3ryhivSndmLls/Cd1Xuo7I/yiDuB+4?=
 =?us-ascii?Q?DAQCsU/P/zc3neShpINVTifbwagHgqd/CYMKQbeuPJJpXgPQbUaxbdIrafHG?=
 =?us-ascii?Q?xSISpgW1eiZpEV7fYDx/1FNF0NmwCVtGfdtcLW5ZzcPkm2fzTXLCeJzXqRdZ?=
 =?us-ascii?Q?iNW5rUsWtPhdPnITHOmkRHeaO5Cb4HHWQaqYIrzvvkDVKTrDJRYkyIb1fU6e?=
 =?us-ascii?Q?zgAqUOIEzIAq2rtjFd/QiUyrF5Ku+47c3Y8Hruv6iDUaZdrXV8nGFNn8G7V8?=
 =?us-ascii?Q?npZoxpPjZdV0nXyc/lbAWzDyzgYovRs4YIQf3OJ+UcnkH/kjDouD/WJnIM0j?=
 =?us-ascii?Q?Lqx8rPmgcHg0B92bqI/gfLG0t/rCWdkAjWUIMbfgcjULf0iQIaxgCUOLxDVM?=
 =?us-ascii?Q?D7ppzjuqYlg8J2ifIudXZMZowUOybL2t4BibadWA3eUwZh65S1Pma10EkpRF?=
 =?us-ascii?Q?8p+lEJjavf6dBTPgEmBgmBS2716O23CQXN+5+D2XhY7tRTGaFCC+1mcPoz7E?=
 =?us-ascii?Q?mCAuTp/ReHUPArZryhYagBA/kPX/J447PXobV/5wIGf4zCdqz3EueQ1znMGw?=
 =?us-ascii?Q?BeobFvLY5k8Htp7fh2Ay50OPcE0OJce99NHrE0V67Sj8cfoGOsZlHwj74xHB?=
 =?us-ascii?Q?Knjj2/GoZRf5SFtFeShJeou9OYpFo9JJLTu8jgL9qf+lqvnzyBDNF4TJi6OC?=
 =?us-ascii?Q?Ndn6SvW7Qw5z7KIWCihEmVaGpam26GAie9j0HoKoClpxYn5hD0LdWMmkVl6J?=
 =?us-ascii?Q?URE9kt7+Pg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	X64rqexOdovy9CSx0llpjw7vzX2Fd4ssHt04bYSq7Y5DkToOqo0RSGaO+8F01mstsVBq1KNzTu+T2LRFoh0oLal5jUkqZjSulLioGSDI7FxwAuxHzKJ99n5KYkqmK6nI8dS4JxVkUi/+dn4OsgXCUwpBY70K+o8kdEnUiBDwaCftl012cahtvCqWomyhKDPBRZ74jiF1UbYF5EJyb2fDpJkRBWGiagUVfCSdwyL+4KKgFXtn+BxKiWb3j8njjSEQ5rl+lBBZlllFmGauQN41PstyoDyCrO/eHk4PF35Q9VHgpMiJboFthjQrAc0trlEtZWAoGfKndbFkgEjXuy4rOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c+308AA8qdB5q2SF/nvVZrydqPDYY5svvDIfTV83VWW/v8qUEJ0CN3FVP+FKO5cnJ9shAPOxsvLnC7r/tMXP8dupBoOsRmr8vP6h5TJI1DeUMCxt55um5bBS4pNojmJqYgpu3aDUvGJX5+1odFspBupJjwMq+u++NvLmGb8WmpNbFiC1IxihZb98g4jmNjHiqDS7/dp0qGrkMtc7DB3eGU8f25NWRsmTxUO7YmXKcX9qhAaVistVA1jihNgGV6ueUdz4DNwjhAMNB6By3AMl9HV9nXYwuG8Ta32U/gUMstIu/XNBdPS+9G4YF/yQ6bDkTEX5FI6XR0W75mEu0IJr2UcOwtDdTXOp2vKp6lJ7iXWI67pGNWOh508gf6YRc+uV62pjG6tYCpWGnE73J50v+xrczeYZhcLn6Mde3wZIeN4XoyKGEeUMQ/xyJdC3j3OmFsYTaaVMr9U+wtBx/WvbKCBaUNCivKwTRLtKERFDteJLLh4Q2pvqtIN/1T6H32DnhKV3v7JNL4+CnEpJtj+VymTa/oLluJ2Leyx3DWqSXOnOAoJ3B/PjgYLdOqUCmvMf1JsAqq9q/g3ID9+4vZa2yEjzjNrbcGLghPQJQXX16yAgW54ePGV3pUDqmKAL3f+O
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec256f2-89c8-489f-cb7f-08ded817d158
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:56:34.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phKvdZRq8z9gr6eIa3auKmvzajrYGoRf7paNdSLBg8TBeRzffzZbIVF3cEs+SRDSuKTqa4FOSluA7xzeprB2zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P192MB3248
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: VI0P192MB3248.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: E-1z7ubhvIzzUH72Sp6ewMffmbSYQCJE
X-Authority-Analysis: v=2.4 cv=OJoXGyaB c=1 sm=1 tr=0 ts=6a4627c4 cx=c_pps
 a=/vQH5hnWz8y0ig1Rm7Y62g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=N9GNhs4bAAAA:8 a=WBCLUAq48yB5X9q75cQA:9 a=CjuIK1q_8ugA:10
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4MSBTYWx0ZWRfX65G+ZnNgXwgP
 c6ho7HjCIkB2IC9Pp/bbcD7aF0kBcIi5rfMRwQLxbkd2VxEnBzhIL7yo6/vsZm0UyZhdUivvgmd
 1HeHCunVJ4JX/ogLJhbc1SJeqPoGzOm9/gUmK8kLR32hgQr1d1kJ1LCdlBJHdHK2RmpEYIlMW5+
 xukOsEH0skZ3xDOC8nMp6+sgVO+IAW5BZHKHqwDLGG+zJZnGm3y7wVL3EvuG6hFohZ2MFaYyNwJ
 zojRk6TJ1Fmzfag48bXfspWNM0j1SHGRNvPK7g5Vf0DdHVWTyJ3LhMybyDu4tDzGIcRglZLL8Cc
 H9sh/fJUnQ+pNtOm2k3PCYgNzEOx5I0rPhRsWBM6SR3SqYS3xc71renTWAtnumxwCj6pauyReQe
 M5JD+abFL5Vu1LJAkPAi6+nEZZ1MoKpiJZzPjNDj0jCslQ6DGvzOg0I2z4timTR/zp8Z+6cIhlM
 PaGLAWPKHgcZMG1o5LA==
X-Proofpoint-GUID: E-1z7ubhvIzzUH72Sp6ewMffmbSYQCJE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4MSBTYWx0ZWRfX7lGKxQ9jpzPA
 d45/QFnHvcByHidR0SD3g7NORiGwa7r+K/TrCsZStqs5yuf1J2UEOYQQZRrvFQ86NxxBTlshRfO
 AWJxppBlrQSNYBxRSRrsNJLj8WKLAd4=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38495-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,westermo.com:dkim,westermo.com:email,westermo.com:from_mime,FUE-ALEWI-WINX:mid,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C15E56F50EA

On Wed, Jul 01, 2026 at 10:08:47AM -0700, Jeff Johnson wrote:
> On 6/29/2026 1:35 AM, Alexander Wilhelm wrote:
> > On Tue, Jul 11, 2023 at 11:49:54AM +0300, Kalle Valo wrote:
> >> Alexander Wilhelm <alexander.wilhelm@westermo.com> writes:
> >>
> >>> I am trying to get the QCN9074 module to work on a BigEndian PowerPC
> >>> platform. My question would be, has anyone done it yet? If not, what
> >>> kind of effort would you estimate for porting or are there any
> >>> firmware limitations?
> >>
> >> This is a good question. The short answer is that it _might_ work with
> >> QCN9074 but AFAIK nobody has tested it and I'm not really optimistic.
> >>
> >> The long answer is that the big endian support in ath11k is implemented
> >> in a weird way which I regret big time. The idea is that the firmware
> >> does the translation instead of ath11k driver with this flag:
> >>
> >> /* Host software's Copy Engine configuration. */
> >> #ifdef __BIG_ENDIAN
> >> #define CE_ATTR_FLAGS CE_ATTR_BYTE_SWAP_DATA
> >> #else
> >> #define CE_ATTR_FLAGS 0
> >> #endif
> >>
> >> But later I was told that not all firmware branches actually support
> >> this feature, sigh. To my knowledge QCA6390 and WCN6855 firmwares do not
> >> support this CE_ATTR_BYTE_SWAP_DATA but I'm hoping QCN9074 firmware
> >> would support it. Grep for BIG_ENDIAN to see more big endian specific
> >> changes.
> >>
> >> In ath12k the endian support was implemented in a proper way using
> >> __le32 type family and cpu_to_le32() & co macros, but it's also
> >> untested. It's on my todo list to convert ath11k to do the same but no
> >> idea when I'm able to work on it. Patches very welcome.
> >>
> >> Do let me know if you test ath11k on big endian, I'm very curious to
> >> know the results.
> > 
> > Hello Jeff and the `ath` developers,
> > 
> > there are still a number of pending patch requests from my side for `ath12k`
> > addressing various big endian issues. I assume there may still be gaps that I
> > did not uncover during my testing. Nevertheless, `ath12k` is now running stable
> > for me in both AP and STA modes, so I have started to look into `ath11k`.
> 
> Let me start by addressing ath12k. I have been sitting on your patches because
> internally there has been a lot of discussion on this topic. Just this week I
> convinced Those That Need Convincing (tm) that your changes are consistent
> with the approach that was taken with the rest of ath12k to have the host
> driver responsible for all byte swapping. So I'll finally be taking those patches.
> 
> HOWEVER, Qualcomm is trying to transition all of our products to be based upon
> the upstream driver, and the team responsible for enterprise access points
> believes that their KPIs on Big Endian platforms cannot be met with software
> byte swapping (my understanding is they currently use hardware swapping in
> their out-of-tree driver). So it is possible that ath12k will need to
> transition to hardware swapping in the future to meet that need.

That's an interesting approach. Unfortunately, the situation with the `ath11k`
driver in the past was that the upstream code never really worked on big-endian
platforms. I can understand why, since only very few people are still using such
architectures today.

However, my concern is that if `ath12k` also performs the byte swapping inside
the firmware, neither I nor the wider community will be able to fix endianness
related issues anymore. In that case, we would have to rely entirely on Qualcomm
to address such problems, which raises the question of how much interest there
still is in supporting big-endian platforms going forward. If big-endian support
is no longer a priority, wouldn't it make just as much sense to perform the
swapping in the host driver instead? For little-endian platforms, this would
effectively be a no-op anyway.


Best regards
Alexander Wilhelm

