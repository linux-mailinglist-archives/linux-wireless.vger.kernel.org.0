Return-Path: <linux-wireless+bounces-19850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C265A54501
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 09:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0FE162193
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9620766A;
	Thu,  6 Mar 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="jS6fzEAH";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="UWykzZdx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89311DF24E;
	Thu,  6 Mar 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250158; cv=fail; b=tOsAbrbIFmNgfOTHgkQsmAiWcsDyUhC4hu4up/6Y9OPAqokFzcnmVI9lBYh+w6p3xRkYrK/ve9m4sj2iHRJ9AQDDbLQ3ap/c8u9c/JfTxfrbkNTOB9gDVSezqLUp87ljMh4m0Jq/QdDB1z4zUy91Z+zeSl22okWxn71VRqk6PMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250158; c=relaxed/simple;
	bh=OcGJEtSYTZzFqx1+eKTkeVrNPPqYG/ilqIOi8oukvYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2jS7EQIqdpThvaILZp5DaCLsKLFOGwQ1JSQPmvhfzMfmXzahXYhalIPhds3OSFRlbHzvlYtEIY8qXc6FVn3m61DMM5H7KJLy8yEvc6MA3jrWOQiJ7NQdUov4osx2UBHmhbW5+vemaKRjgb0wgYkcaGbXh7NVTay2AjMAxubyVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=jS6fzEAH; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=UWykzZdx; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52686heP014379;
	Thu, 6 Mar 2025 02:35:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=OcGJEtSYTZzFqx1+eKTkeVrNPPqYG/ilqIOi8oukvYw=; b=jS6fzEAHZCtO
	uk6Gb+01rhfjLCertp8v8F8x2shFGs95UyxrVvBDo4zCI8X84wAFwbav7Hz29LKr
	Kl95FoO1CFlJPlPsV63CFrlx03rcuoUj7VOqQ9UqjAPqcFak5ujIGFhXvWJnixT3
	kVscbtXZt2F3jvvOV93fz09MI6mWCnCqPN7lDaKCnR8unReYnCAmo8GGWmm/qQ/3
	GQyKeq+IlHEKDXb+ivGzGb1G+oJNjh+QhKbM1pWGbcE4bh3N54tlPuqgmFKi3IFu
	5GPuXh/Gvso86XIRL0BFHWQqUkymhvj6WWUZzPO7lNqZ4bPzPNnFW9EdHJI70XAy
	gdOYnxzTQA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 455qchn104-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 02:35:35 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1tIghYjefM3ExwrniLEhMBGRA4VhSiMAMnDnskos8KKPVMoj6dhTS9TULxxLnGYGu6pKMCKuT3FbshHbRQh4YkVCDqPhdl5AfRxyYQvO/Q6+uBR3OTxEHzBm2q2xhAF6/2gxOirYLKtlptxnu2COWPHRiS3HJf1yu4/muYcREP04dFfq1JniG9z92VH6FyqGdjyIW3aqGnJgEpkEj7ixKLhFZTE4cBbeYvBYhNnJETuEMThIoDccm3Sp6zhfpzzhaU1VP/gKMG/m9xSjCfmVqxnMiTcWNOTgFNlNKWu5IibAiETaEG5Nsk0JHejKQbrN9SSSWRWs4umYXpvx4fTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcGJEtSYTZzFqx1+eKTkeVrNPPqYG/ilqIOi8oukvYw=;
 b=EHpArvujIG6RCnqt7u1QJ4WygtCXLleqhdWih5GZIVuC5xba8J2evqV8UIdal0MaXUO8vup7z5jKbofua1vD9nVKjSjjpfDMniwD3ji1XRiJ74T1osl8FJxNG5Z+Iwfo+kr4L7aygrEkPHnAUGY0upxDpwrPRARD5gPf4EUNwdVcx0N71g6ADBIcwEv4WgjFSy+4Ak2sOIWys0gim0zCVZmNrQBvflqHieC1RjmgQyCy4Ihad6nsyXKs1fxZuUxR7IcqDrGLKwaD08fsh+S2aEUpnYB5Zwp6AcpKAeILnbMo9XT2M4lZ/LbUPeDt8BG0yMAvk7WIjXCM4RnM7+6Tnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcGJEtSYTZzFqx1+eKTkeVrNPPqYG/ilqIOi8oukvYw=;
 b=UWykzZdxmm2rXJv83MjmuTM6j6ynohmxwYyU/8BPbfH68aTEeZm13Rkw76ZgRRwLI1m7/+SOtD37cWYD3bmBM0wxAs/NMfj0mu+aXhrIpW08azmop+Kc5zVFsUTKfmgs/PrA6ECNMNcuJ1wtJqr59pDUGnFLkr6vr4pEvFxf7zs=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH8PR11MB8258.namprd11.prod.outlook.com (2603:10b6:510:1c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 08:35:32 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 08:35:32 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com
Subject: Re: [PATCH v2 0/5] wfx: add support for WoWLAN on Silabs WF200
Date: Thu, 06 Mar 2025 09:35:28 +0100
Message-ID: <47066295.fMDQidcC6G@nb0018864>
Organization: Silicon Labs
In-Reply-To: <98b872e270bf2d03700b39ec5b62f2746eb46e88.camel@sipsolutions.net>
References:
 <20250302144731.117409-1-jerome.pouiller@silabs.com>
 <23857370.6Emhk5qWAg@nb0018864>
 <98b872e270bf2d03700b39ec5b62f2746eb46e88.camel@sipsolutions.net>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PAZP264CA0071.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::6) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH8PR11MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: afd8034d-4730-44ed-ee26-08dd5c89db67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?L++1fVlt6Mm/YtY18o9zF+EEgzLKGhjo7Mj6IE0Y7wK+mhSVUUbwSOjnFh?=
 =?iso-8859-1?Q?iZMbAsFHLwMVg9wxqWBoqCqmp7NQQlODvg4xeO438fgmeUb4TN/oyJKgEn?=
 =?iso-8859-1?Q?2BxR4oulXQ69lUTxebiZRaI/TlBWuoeyDHo3K9tvi6tL3yxVPfGRW5JuD7?=
 =?iso-8859-1?Q?bRVlhgcTVvY7Pb4XzbVlillk6JCe7apQkBQ/7cY+7GuG4zyYFShBfkw7vt?=
 =?iso-8859-1?Q?F90V0NqfMLVgzDcoYpGcoHZj2WPNJzY6fWMChqvWR3AlSG35UHdmReaavE?=
 =?iso-8859-1?Q?vaiaDCFXJ96O8pyuWB8Mc9Kb4GrODCLRHUco7zf89Z2syph768cPydlH3R?=
 =?iso-8859-1?Q?6TLYqaY2r/CS5JVNl7jjTuPKvBTofLD7TuI7+CkAO3tBKmxgz9G/05YX/A?=
 =?iso-8859-1?Q?i/6fBcxvKjF+hY+1D9p8t1HhLrHppo2txgkfzYDK/1mXFujFF3cX679fH9?=
 =?iso-8859-1?Q?zV8CKB1PHmKH1568y6ZLJ1UaLbkIl2RZ+P7M1t3+eBvJmS5DjXWZ2e79T0?=
 =?iso-8859-1?Q?MrfIgSa4t43q0o99uQD0peLUX7HC788gkJI9pB6rZbcBYUz+4z/qt1Crtf?=
 =?iso-8859-1?Q?IZyUMu1MkYDa19gUOZao0X11qOUoE8bkewkIcM2UknJhuJFKLVlLnr6uE1?=
 =?iso-8859-1?Q?u56jn05GkIMfsxUG53YYI2eX9lMdDPE1R9xDeqwJpWyMELh8eyYTYT0zH+?=
 =?iso-8859-1?Q?1uoMktdOFFtqO5XYT2GD4FZFFSpHckH9zn+rcPjIVJqyic9Zsc5VBmL3ss?=
 =?iso-8859-1?Q?L3B/VgTUJdgoIAAeAINjBsXK5RIVuKWQ/NDfW9y3fYelfgY1ZxS3TwHPKM?=
 =?iso-8859-1?Q?8INd3KTfFHBHEJZ3Pk4kkJgLcuUfczo59Km2Gd5wMejz9IRKRQvLNT+L6S?=
 =?iso-8859-1?Q?T3yJ68Y+RX6zSDSNT3RWcKeW/5J0eJ6FZXvQ4aJkMMBc1LILsqs5yZ0uPw?=
 =?iso-8859-1?Q?EYsecRpB/8gpwcrhpksNo5PZCfzlTbudFE8Bpw5zjYvHR7Vl5gVSLHczih?=
 =?iso-8859-1?Q?fcxud9jcCcCHqF7IAPDF4YgzaI1QhAODzsUe06LTvi7QN2seOu9wZMQhWl?=
 =?iso-8859-1?Q?1HrdUoH4nSap3RoA72kSS8prIwiJY77hSdVqc+2Wkxcr6SHVG73g65Y+GI?=
 =?iso-8859-1?Q?NEUmv5NSjk7vLpfMcN/Tq5XKe4Nm4Nma7OGkPTpO1yfdJFWcr3MP+QOAkD?=
 =?iso-8859-1?Q?awsRmzImFuZ7ZoLG04JiwM6PIv/XGoKDkh7nhWH9a+++VXmKYheMDc2W2J?=
 =?iso-8859-1?Q?o1FSEZ+ajlop2nyenKfK41sZjQ6bpnlZHqvlb2hv5qw+3TqjWroHea6lIk?=
 =?iso-8859-1?Q?7jEjGZfSXDRkmgaOUvmK6ixAJTQPJlP1v3eYwSUYL9xR+EdVOLJ1KSnq4I?=
 =?iso-8859-1?Q?b9Rx4SgLkVrnlW37l6axYGlMl+brGNn3ku+a0Ytw+NulD9RpmCvUpI3QUs?=
 =?iso-8859-1?Q?TTTJ1FQU+pAMbrZHJx3moSBKeHjL7KeWhHegTWIVU99kosGWfMB+mc92P2?=
 =?iso-8859-1?Q?RO4KP0lTkiqdwP10qOLWzS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?1mOjA5wKT5+fUAziRwL0TjDZ5YlYDjUSOJv4/V9zM/3MbINf6cAqzCQNkG?=
 =?iso-8859-1?Q?3SuQoo64T3SBbQFS3n6x5jHK9fe32RHHfNBJEqaFGP4JolJXg66pUYGcDk?=
 =?iso-8859-1?Q?IBNfDBZbClP7Fq+UxVfNyJgCsxmsWdkieJeUm97MWDYOvfA+fZ9Vi0Vq5p?=
 =?iso-8859-1?Q?x24pSi9vWOJobB+q08NfS9dyQQVjhMe5xp1yHE00IDuIry/Z3uRw1aKfaG?=
 =?iso-8859-1?Q?0tjBFR2DFuWI5ceJ5IF5VhPqE1gwnhwKcimHP74l5C1F0xubrJ6OD8OHcK?=
 =?iso-8859-1?Q?HusKuMIpUF30OafzZbjSzREW5T1nAVY0JB7E1F+HRnPBioKWCvQzVtFR4f?=
 =?iso-8859-1?Q?XczYxIBZnQBwOo7N03LmZ1vBk9hSCpWD7Av9q18NSfCJB1hS0iBXQOL0sw?=
 =?iso-8859-1?Q?qznipmXK9Fphf3TEjUOjIT/J0/CTKwYmMLFjTjLAEey6yFYphseKsMWDHQ?=
 =?iso-8859-1?Q?3Odc35M2fcKk0e5ID1qKMjPpUgd5wKYQbQRkVs474kic8gWhPvy9l6Zjgj?=
 =?iso-8859-1?Q?rSeO4p+/GqEp+3pAseTIhCYICwn5Ur6ZLJjW0oI170zXhQmFadj1lQ5TgA?=
 =?iso-8859-1?Q?8niEzizA+Sg6cBvbxg4dwzFDnR3dwu1pQfPwvtMNfyDyEGrWDybRpm607Z?=
 =?iso-8859-1?Q?ngsjLJciD6YhjasVZ/J0/bpZaNGfK95nIlcqg+WGy+KmRtazWd5spcskOP?=
 =?iso-8859-1?Q?TA89A//jgbaI9POA1BXzIU1c7eNcXQgsu4vXI3L0krB3A+sLUuW3d5aVIs?=
 =?iso-8859-1?Q?vnQwGULERE3HpU7xV8WTmn4HqAjPL5cjSX4b1jGGTyOyvm46rjbEZx0p/B?=
 =?iso-8859-1?Q?Rqqhjjgn63akaR2OopfWyyn2a3tLRdlGc21j3rbZ2cVElSB7o6YKLIAFPz?=
 =?iso-8859-1?Q?AC6Y/kDXLxZ0I+uV8Ya9FtE3rJtuEfI9PVtzN4aRIQ2lz8/R6WH1ozFHHk?=
 =?iso-8859-1?Q?DJ/mrIN+/853Nyu8meG7RZuRep/ejhO3oj1X9jrU9XFBy0fNaZoxy3siS/?=
 =?iso-8859-1?Q?VwuVXVRHjmU3Y6CEnhD1sGtQFmjUtqZI9YWSV0z+AhZo+vvxM+7f3ElPWX?=
 =?iso-8859-1?Q?byK3GTnde3oGbwFWv83M7kIZ5o2FWTJTekay2V9cCMcQ1qZY/nHQ7FviHC?=
 =?iso-8859-1?Q?IdEmaYNzYGWMsxu59UCAOwhwObBcy6qjsQ0mueeT9q0Pm0wkFYD8Al/Wbo?=
 =?iso-8859-1?Q?7eKdluz9XIqAppsObruW0ZKR6e+mwqZVjYNP2h5NpNuudcFBWSn4gKzChA?=
 =?iso-8859-1?Q?nKFf8O7FcD00wBI97LfzstXueaD4XB9yokjwVbDy/lfsUE/vq3cYOhvnFZ?=
 =?iso-8859-1?Q?uU830fLvoYva9AYQRs6WqobxtE+bOe2Wfn4zVjfMyiKucKI832mvwO/lg7?=
 =?iso-8859-1?Q?Mw6O6HHT7IOl73TwFKIFL1OJoh58K4Vkgtc8mY1bkj4xg+nzBRpnmdzb/q?=
 =?iso-8859-1?Q?ZGnHAhXjmILMAHvnM2rkcCP10CmgcH0IjK6aWlisdztR14+8Oi0wHkLYnQ?=
 =?iso-8859-1?Q?KgbluJFwt7tAtk91o/AplEtcqaB3uCde5gop+BpPl1Fk6EVbxQYFY7JbrH?=
 =?iso-8859-1?Q?VNLTg+HV+gzCuBmmfXx8qfQhsDv/ZgUrTnR1Jhur6GSx5FagnrNTJu0uPe?=
 =?iso-8859-1?Q?ASomjb2wdRB2OccEogOh5Jrub6NMkPfnql?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd8034d-4730-44ed-ee26-08dd5c89db67
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 08:35:31.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jP1q7qtLqlw4QASRtj+Lw5PR+4Egcfg6tXZGSvxnURc1sFAiDzgFlzq26TO/Tnso4yU1YBL62oWNYj8ZGMf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8258
X-Authority-Analysis: v=2.4 cv=DPN14zNb c=1 sm=1 tr=0 ts=67c95e57 cx=c_pps a=GDxOUaUasxmcDRSC7gC2IA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Vs1iUdzkB0EA:10 a=LLPZWm0_0O8A:10 a=i1IsUcr2s-wA:10 a=s_S5HfJIwM8zxxf8BAQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: GFpuMWdrecngYfhIeqhZUiBL3_2heAuR
X-Proofpoint-ORIG-GUID: GFpuMWdrecngYfhIeqhZUiBL3_2heAuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=801 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503060064

On Thursday 6 March 2025 09:10:05 CET Johannes Berg wrote:
>=20
> On Wed, 2025-03-05 at 16:18 +0100, J=E9r=F4me Pouiller wrote:
> >
> > I will send a new version in a couple of days. Thus the various robots
> > have time to test it.
>=20
> Any particular reason? I don't think you need to break the lines in
> these two minor cases, it's only a couple of characters wider.

I have not opinion. I do as you prefer.

> IOW, I think I'd take these patches, but if you have something else to
> change about them I guess let me know.

I though the missing target tree name was a blocker.

If this is not a blocker, then you can merge it.

--=20
J=E9r=F4me Pouiller



