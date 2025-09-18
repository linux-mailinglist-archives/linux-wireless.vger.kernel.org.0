Return-Path: <linux-wireless+bounces-27475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A7B839B9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632B81C03F92
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 08:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13E52FF17C;
	Thu, 18 Sep 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="gvKlc/Q8";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="PzxkDrQF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A432FC02A;
	Thu, 18 Sep 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185679; cv=fail; b=tbMJGmCEooBXabYTB8j0jqLSMGbCUrII91Vut7+S+xi60pWrdv0owWYjuSbLJn/OrfpKmBwDxxboLaraZxsAOA4SQqNmaKyARTw+22rI51XP/HtVdOSr90XOrE73dPNqUXRdmcHDMdjMf3oIXlAcGDuGXsKCPvij+3GO43KTnCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185679; c=relaxed/simple;
	bh=gdYpwwHaWFFd2uFiOR8Z2O9ny1UO1XasOF9tNgzMK40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qrxV+eWLr9Y1TaLQrRdtvXK5GP/8ZAZOj4l0cRag7nftnP62rl60XfP+bR65GEEg/u0opMzaKRJYLeLdvY+aarZ5tWQRKjdavotC2GmmlnHLxsocJDvCo60HsZ6duE5Jz1Q2tQmzVhQSw3wEbjKIuwl1PoPk1xz2PkFWkkk8bZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=gvKlc/Q8; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=PzxkDrQF; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58I4TIhN1538395;
	Thu, 18 Sep 2025 10:54:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	ZHE8GLfQiioA9HCWA1x5rtUeCS5LF9WVS9pSLB/aozo=; b=gvKlc/Q8iUodfuaw
	h40FaHr3CwKAGTtDEdTcDPT0Npb03T4CH0jDOIFWhAOMZxzROVFgq1sMk6W8VIZ+
	euIzCY+1asbl+KUxKjIHQZFi/NEyeVmM4jzQp9/nBEsAHZO3O0hKvJz9fknJ6uIh
	qp4ZcdgsgwPGg2WH8n0gtzSXNCOxd59+6XyLKo9RNg6BJ7HY3drKudHC/amVvQff
	PSWT6J8YyDC95sbUKgY9vH6PU1gMdaI/FVgZI9BPI3XEubd+Z0oC3JgmH1VnzJg4
	wNNK+Y4SzeS1bF8f+zQn5h2WSb2s8jHmeJR9u26OUknNNd7Z4ffGYAp04U1TqSg5
	ju08jw==
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03on2123.outbound.protection.outlook.com [40.107.104.123])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 496uxd2t91-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 10:54:16 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBulSxzIFuIkvr0VsM0sXYCi9qPy5EVzEds1TdJsgUWxqXCb8dJa/TL/Ra8s7U+/fKIEGbW/Tfzje9QYg2c5L1xYyj2e+7tRnMNfltlBBlaVqlzO1jGfV6VUzvCJtMCNtXWIP8J9LGMX4gzi8uLTdy9p+GYFs+9R+fENi/E/VOCr56Lx1oUwiIoiS+tzoSpRZyRrqXjGtn75wp4UA99IxsKSKTPd3kGQtjsZTLGD5SaY6vwD04IUoSN0V5ehP+AFtkw19jiYZQ7mQN1cTN9PnGswhFrHgT0lqQMN7++P6c0DMw+0uWr5lelndQ0unwhklYq/EAA4ku+kK6wfnKuLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHE8GLfQiioA9HCWA1x5rtUeCS5LF9WVS9pSLB/aozo=;
 b=g2thKTIKE8qCLnINIW7AuWWdu2xcuEUkNwNSmlWL0E3s9gRhXspHLcE+CKJv5QO144HzxC0HZWotp+QV7WTH8No4fX6hGEOPyEXYOLzZSgzdQ2l5fVah8yY8+KhqK+8qgpjh+YNcy1SCPUeM4NKHzvpTtii9t6du3/54rY4seN8TDbUhrXDiGpZdh2Q59k1hYZTimamt35kGFeouzqKZX3apSKOE/HxARIvkrIrqkk3cTFxxU75U6uiaSh6VNP+IBIKhrITBj/RQ+mKKGK+BE6R6lyU4LcH8kDYWifkKuXeCjAk4vN/SWCTGXexK0cgaYSZhMpz/M5KUF5uZtL9udQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHE8GLfQiioA9HCWA1x5rtUeCS5LF9WVS9pSLB/aozo=;
 b=PzxkDrQFAmgZmkS9Db6RH3E5soL8h2ITYhUw6ZhRXEjpdlyhcV+jB6zVO5czpwAiiE5R8s2qczxpLrSkvpu8kh8NGSPXqVZ8cPymsDnJqdYwq6XgISD4uAiXzNQeGHL3JhW3MPWizc+6gvgDw7AFMlI+36fwBiiloJiIcjZbt/0=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by VI2P192MB3195.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 08:54:15 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:54:14 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/4] soc: qcom: fix QMI encoding/decoding for basic elements
Date: Thu, 18 Sep 2025 10:53:57 +0200
Message-ID: <20250918085406.2049559-3-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
References: <20250918085406.2049559-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0049.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::7) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|VI2P192MB3195:EE_
X-MS-Office365-Filtering-Correlation-Id: 35188f43-3a21-484d-175a-08ddf690f1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ib9dNbDI2gFzVjsw/0Le+KlZ4fGsaIsE0MnNxB6OmxanQcJK/saGknwUX+7x?=
 =?us-ascii?Q?tk1bfWJ4SvqrD6xo7JFIdplt5Qmsfo/geUfnOiCL8iAHIbqw0Jo2XNw36/su?=
 =?us-ascii?Q?yGpjnRAYgJjiddfXx5mNF3ApzkSO8DIBNXuuROeucyvscsVXcnBSdVhzrdou?=
 =?us-ascii?Q?0QviVH/5w0/9g47g9Hic1NDUcWTh5XzRsqRVSFjE/6TArL+ivcLHBzU2aIce?=
 =?us-ascii?Q?o3S1q0xrvsaTTCSTdTpQ3snPNGzzUngS/Dme9B6GCpEXfGplmgBh+t7VCaVF?=
 =?us-ascii?Q?WC7u0MLWbogph1QECtnNSPu1CCwoZg+D4VTweiOf9STA1OIhfKAP1uKHVcyI?=
 =?us-ascii?Q?1hRhrTrkDyFr0DN5FLja/Rz1tNHyyF+yaTxU6OJMaaS2swsDekQDM3+mdUrY?=
 =?us-ascii?Q?zoij4BierKWsqWd9JKvKqY3VOantFmPonZUEKeMCZNlkqVMggIjMgEUZTaye?=
 =?us-ascii?Q?4WnBWNCpwBf5w/3kmRKsvDqCFTMtm8vooeP85woj7aj3EeQCqlu0kCQgtgIY?=
 =?us-ascii?Q?45DeXgM4csazMq/jYbmQzWyhjqbpFKtZs+X9fiCe5+LPc6Qd+98ZGvXDFpj6?=
 =?us-ascii?Q?eroGxeJIo5n0/GJqw5zI+f3uiGU3AKby6kIK5waGKXAcwM0RIZ2C39ocJpqu?=
 =?us-ascii?Q?xVuNhN1Nb5bcHfvupowHuzEf945AZkIoq/jP0+BknsBqgsc5di74psmkjWDA?=
 =?us-ascii?Q?yvaFrikICjkxGBGiHHAKvlZUXfHr3p0/q5lxEleDd4XKKzsUscOh2sim2tNj?=
 =?us-ascii?Q?Tcc0sz/4A5ov5SeyOd4h03xs/jprSYVHIarLllR3paTPKIpED/UacJKhFu1b?=
 =?us-ascii?Q?Ibs2EjP+B2zcl2u9+V9J0gmono+Fs+w8PVcNWduIEVp0Xg7Mjy4nYI1YEQkN?=
 =?us-ascii?Q?yC1CAfq1njO017W735kXAd6Tl+8Ohn4OaO3YbD0i7HDXs9oGy9kVQDxR5KP7?=
 =?us-ascii?Q?OQktlTQ4DuM473CHua/QyFlLKdb+0KkAu2GppChT/lwZxs3BC8DuaAxE8Z0y?=
 =?us-ascii?Q?u5kgsDBNFom501+jmijplWI4zfku3WHvJ0f8c5JYtuURtHPX/QY5SLME5p8l?=
 =?us-ascii?Q?YL7lKtOYVlQlFf9fXVtsFnHU6/Sx6g0g0hSnifwM4yDu7T9ultLlez0pS6+z?=
 =?us-ascii?Q?QQ5gvLaS9fPabZezREQ7zq3CeQgMY8DPmLrTefAGTda3mh4GHf+y0u4txEgA?=
 =?us-ascii?Q?ANtxn3d6rHnVesGktoi0QtGdmNwtObZFAh8cEQE9w0mTJH2Xf0HE5vpiIybi?=
 =?us-ascii?Q?nscD/fV/GPNJ6ldU6mQ8hNY0N8fZ7ZoKbxXBYTeuFzAdm7bgRGqccZak1LXY?=
 =?us-ascii?Q?21906QxFv1SSpEpFsWYBbqtPHkF5/IG5OFBZdp7xxlZswgar3meJ8xfhK8ar?=
 =?us-ascii?Q?P14V0EiH+WrY+z/GaVf80k4UeHwcMMss8RTWBNQD7VG2DkbVhO9ztqFFkL+t?=
 =?us-ascii?Q?3MnC2/YLSDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aMXiIFbj4/QpC5XYRnLwB0mvWpq7KPMi1QUcp4O35RaUJ+YzgC5M9OP6RuBA?=
 =?us-ascii?Q?faNn6vGlC/atSdYTqpebgSwnYmv1cEcIjg7yQ9mvjVOXbYzTsCVGl8ovzSqW?=
 =?us-ascii?Q?iTLXonGclb+4CPJM8sSRjjdz9qUbQ80QdfMw4TOENQ4nhNgfQzOhQfLESfIP?=
 =?us-ascii?Q?sDLuLGl/o0gGERD8So4rCT/D9+AlX9DrKWfrSkqooPa4PVZQjFyCuIi/dyFm?=
 =?us-ascii?Q?5QiZqHcvqiE9LJv91yO9zlq1Ilf6Bz1Z683SGE7Nk2CoR8fKE7lGRi8t0KNx?=
 =?us-ascii?Q?Dz/R8nZz8PQtiV81pB1AYcuyJ/2WcVPYgkN9Q3hJiARaDmGX5b1AMaIhVFaE?=
 =?us-ascii?Q?9vIMRebGVKsPF+6JVd2GODn1dP25TL4b8IhJBecWiIjA6ksH+w9bTBpr4nok?=
 =?us-ascii?Q?eqmHEGiHOC/vybqp+U+6sPJGVMrm6FcHXoN2qQq3/vjAokqhDYpc0nrP7Bd6?=
 =?us-ascii?Q?5/FWypS5tXJ7uJaCp4i8Kz5ZK+VHhgAX0bXwdBAwaDqUe7rxU5uU4ZXy3L58?=
 =?us-ascii?Q?DIs9Fe43S2s4CDLRI0kh1T2CBPf0Zt4GML21p+McqPD5F7s5FnLgH0iBPzk0?=
 =?us-ascii?Q?XcO3BPbyWvJGzEzRHtjC8e/c/3yEoXGVZRr2mhSbk6RjfouJoXxd8eWErHOq?=
 =?us-ascii?Q?JMRzIc6StMNgoayVFmW+yBbA9L7cmEDC7K9JEGLteGZwJyOItdjtdDmAZFyC?=
 =?us-ascii?Q?WnS7a5vrDf5djCv4nbW9Wy4Yx9VJaPrbFVxExP4nkQ/sx+T8K2UuJB8Q7oh6?=
 =?us-ascii?Q?7OLWhPzHUI7qXXSy50nYGu6TMeadWIWiGZOQCehCUUU5K+gBrVPwI1cUyHV4?=
 =?us-ascii?Q?IcXtEmScRH25b2eIqDYE9tmuXXfMoV0tY87b/KzfvpR34nfaNfk9uWJpNZa1?=
 =?us-ascii?Q?3FhoaHjvKMW4aMAwk2hEFsr22fDqcueEC2d1hsHDweCGmnLuMBkN2t1kJKo7?=
 =?us-ascii?Q?haN+A0+tewEGz0VOBsfRD27nhaFG26c0DhPfPlB6+H1K4CNYcPqsoEQVmuGi?=
 =?us-ascii?Q?Qlqp8Tmdy5gacadC5tjudKtjPA6GB7J0FDt/cRQPzVEkqGXWs/f70zoktgGB?=
 =?us-ascii?Q?aqdumV4MJQqykCWkp9r6EqTbQNLuJ++ovUHMsxwvHzTQAHU1LKZ4QN6TE+p/?=
 =?us-ascii?Q?CsnHKalDT0oWtcW7+kRCUs5NXzc1sbt00rajzILC+lbcTvx+25TfiHx0SH0X?=
 =?us-ascii?Q?/jpFXK4h5QA1YTb0WDrLLhMaVxBmg6bLav04Lgy0ryLIWtvg9YlUmsQbzr6U?=
 =?us-ascii?Q?ll94hTjSEMYwc82GqvEgApzVwR3AfiON7WLl0yVnny0h/F9DddVjVwsXqWNw?=
 =?us-ascii?Q?rGhI8fjwSlF6rvBTnHpn96bvrz7U9/Wx+tBIHs6ggoTUBjBwrNyUoK3tWdyl?=
 =?us-ascii?Q?FXx4duaHBpG6iIIy7pn3UXu4X/PCe06MWacjTGI5Dutbmg3DXvAB0xCiMRZG?=
 =?us-ascii?Q?FSmV+p41X+KgLTRxxV6XOVLgpw8Q7oxOu3RqMkW9f9rI02IwlZi8PouGbIYn?=
 =?us-ascii?Q?YWw9xNh8gTNiAMCgItOKEFVH04/30wGXCUzz4xEJdTVkxIPcUgZyp56j1YqI?=
 =?us-ascii?Q?rx0IpnsqwFqoiyIbVSR7uErv2nFJMaRv3qAurMJu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4UKmaXFKjg1Ye9X3ZitnX19s1VTDGTwkIVbNids+lILiFecKivrpJgG+htI1IvD5lO0EjFOpO1NiWRal3h4+nCOE4IKpwVfVw3fr0auSuqbaj/SKIe+xFrfdPP3bOsdFzjG5Dr1CkcHyOsI4rTFvVY5oxWP/N95Ba06Mit+hNpyE94tt9qOCxH5h+f3aPqBekKHqDI1j7cb1MI0RDefEVvaxfdMy3a79IWHBBzTdwt+268cZ/UC2gwZ4x2tDbo5bATsH5nvFlm7LmdwgQTLNcEMS4lAiJAEYLjgbYcIJQjQSpgMqvpkRTo3Zu3BFMW4SW5S1+Ilj7nPaGmFKggqD69yQomsNTQRRwskzjq3eDIK+7ateDIUJisDDsmJMciJ2yRNGX4XFzfUZ0+DHkkFh9UM4ngEhc2vt6HpEdbf3pynoPnAq5MpzcsJO/SRUfll0umDB5ZdjI1M4CLnWEYtHZGBdQmhcOWpLdDSoGg29+0Qqafb1qptUw5hVD4qe+dWZmzpuOHYr6CM5kDMXDv5POYr5DZ70yPJ7D+r3/vyYhSb/tmbOGifqyLROf0eXLH7F8Q3dGydiRzRKGzU+VdaJNPPilTLCeydXW5EnOOiKRFVNNvbUoQQKJmI8n6OZfrks
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35188f43-3a21-484d-175a-08ddf690f1c3
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:54:14.8691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvKZVqAyfFvFUH4kWfWGlQEZOxefFl3kQMZ9DHx0tvWriY2+7kzs3kmylBkJwVMDx+MfKZ72CVMR8LeLhg5k/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P192MB3195
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
X-OrganizationHeadersPreserved: VI2P192MB3195.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=PaL/hjhd c=1 sm=1 tr=0 ts=68cbc8b8 cx=c_pps
 a=oHpv3qKjZIMSKjhKdcSMwg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8
 a=T0L45qBzl8X6T0AR6ckA:9 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-GUID: sXjnHscgcrwPg37XrmczxuibjkF_KZmV
X-Proofpoint-ORIG-GUID: sXjnHscgcrwPg37XrmczxuibjkF_KZmV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA4MSBTYWx0ZWRfX5zX1GfY4B1By
 c3+r9WmI3YkovuUlTDsIa5FweeJfqEqyCvlsBdXCsAt/67pjPweVPf7VSvqYSqB9CCdyu6ArIv/
 J56OsQOrl8MEJhgYbS8kRxnwFQLmCUXn1sTmN30oRafS/rGfAfs4YnRim8xoucbxktOGZOJ2ztn
 NYp/0Lgv8PBif2bKs3RZT2KMit5sww8fIJFwZKczwG2J3j0P6XQsObCRY6XkoaGg+AcOym7Y63v
 1gTixUBdwS1YdeVsq615zdBQi8MyO7UNCoItE2MfjMugM46po4+LjS+6F/SQONmKkqwelEHQG9Z
 jLtfmBfuxvIRpkSenYDTrTdzEI4P3tAKSHLEGAnIJuoOChH/7HYh7ZXpCdsj1o=

Extend the QMI byte encoding and decoding logic to support multiple basic
data type sizes (u8, u16, u32, u64) using existing macros. Ensure correct
handling of data sizes and proper byte order conversion on big-endian
platforms by consistently applying these macros during encoding and
decoding of basic elements.

Fixes: 9b8a11e82615 ("soc: qcom: Introduce QMI encoder/decoder")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/soc/qcom/qmi_encdec.c | 46 +++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index 1f9091458d72..90a48fa7ecf4 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -23,13 +23,6 @@
 	*p_length |= ((u8)*p_src) << 8; \
 } while (0)
 
-#define QMI_ENCDEC_ENCODE_N_BYTES(p_dst, p_src, size) \
-do { \
-	memcpy(p_dst, p_src, size); \
-	p_dst = (u8 *)p_dst + size; \
-	p_src = (u8 *)p_src + size; \
-} while (0)
-
 #define QMI_ENCDEC_ENCODE_U8(p_dst, p_src) \
 do { \
 	memcpy(p_dst, p_src, sizeof(u8)); \
@@ -58,13 +51,6 @@ do { \
 	p_src = (u8 *)p_src + sizeof(u64); \
 } while (0)
 
-#define QMI_ENCDEC_DECODE_N_BYTES(p_dst, p_src, size) \
-do { \
-	memcpy(p_dst, p_src, size); \
-	p_dst = (u8 *)p_dst + size; \
-	p_src = (u8 *)p_src + size; \
-} while (0)
-
 #define QMI_ENCDEC_DECODE_U8(p_dst, p_src) \
 do { \
 	memcpy(p_dst, p_src, sizeof(u8)); \
@@ -225,7 +211,21 @@ static int qmi_encode_basic_elem(void *buf_dst, const void *buf_src,
 	u32 i, rc = 0;
 
 	for (i = 0; i < elem_len; i++) {
-		QMI_ENCDEC_ENCODE_N_BYTES(buf_dst, buf_src, elem_size);
+		switch (elem_size) {
+		case sizeof(u8):
+			QMI_ENCDEC_ENCODE_U8(buf_dst, buf_src);
+			break;
+		case sizeof(u16):
+			QMI_ENCDEC_ENCODE_U16(buf_dst, buf_src);
+			break;
+		case sizeof(u32):
+			QMI_ENCDEC_ENCODE_U32(buf_dst, buf_src);
+			break;
+		case sizeof(u64):
+			QMI_ENCDEC_ENCODE_U64(buf_dst, buf_src);
+			break;
+		}
+
 		rc += elem_size;
 	}
 
@@ -508,7 +508,21 @@ static int qmi_decode_basic_elem(void *buf_dst, const void *buf_src,
 	u32 i, rc = 0;
 
 	for (i = 0; i < elem_len; i++) {
-		QMI_ENCDEC_DECODE_N_BYTES(buf_dst, buf_src, elem_size);
+		switch (elem_size) {
+		case sizeof(u8):
+			QMI_ENCDEC_DECODE_U8(buf_dst, buf_src);
+			break;
+		case sizeof(u16):
+			QMI_ENCDEC_DECODE_U16(buf_dst, buf_src);
+			break;
+		case sizeof(u32):
+			QMI_ENCDEC_DECODE_U32(buf_dst, buf_src);
+			break;
+		case sizeof(u64):
+			QMI_ENCDEC_DECODE_U64(buf_dst, buf_src);
+			break;
+		}
+
 		rc += elem_size;
 	}
 
-- 
2.43.0


