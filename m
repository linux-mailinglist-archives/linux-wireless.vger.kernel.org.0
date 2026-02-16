Return-Path: <linux-wireless+bounces-31883-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDKdAHvokmlSzwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31883-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 10:50:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A9014212A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 10:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35856300A7F5
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0E2C0F9E;
	Mon, 16 Feb 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="MymMlX0n";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="Q9tEKGmj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E62E7BCC;
	Mon, 16 Feb 2026 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235446; cv=fail; b=M5SWX0fJQvLIBDNhm8kJ70+iq1E3TS0cdyd/w5ZkpQbO7O/g12PvCAlwhasFbLkeIKBRAAfhg+ffWQBG7sspGRoxQsg3MhmT0deKkROaYOjiifZFqlHXqCTVsAdetPdg3VWdk5SeRCjck/aA5/ucaZAkTnzS9xJyI4OR0tyMPvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235446; c=relaxed/simple;
	bh=hsKT8zcV+YhTMXImzL8ttTn0DSRYAoHjpLbGnc9q5j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iGPr0F3cPutoUBT9YJkX2WhkHLXItXcVy8p1frEK3ZNVor3mo2TEiwmkaNZmXz9Ux/67YKfplQHxjqIdD8UMj/wGPN8IIrFjDNURp6/5phZpSA/gvTLDNPZFdlYC8muULLvUNX3uCvEPqgv5CtMUhOX+2ur/SOSATvpP+HdmkfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=MymMlX0n; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=Q9tEKGmj; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G6PEUl586935;
	Mon, 16 Feb 2026 10:50:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	bl3hfgTpxu0WJ1zRqq4HEZtvplozH2H4wnlhhE3sJME=; b=MymMlX0njapDQuW8
	+5A37c9UDzQfhuzPAwY+ybdlh9EI1S2EsQg2tncSiurLrjxZUouqSaZt0bj/LzE+
	+s82wo4ymFCRTMjplMQoYojpzvbEAnIzz+34Gxg/lcOMoINIgAhQlrPapqZAgaZK
	s6Xay7QZyPxRdyCv1YaihghJhChEWy0JXS6NUlpTyl4HOkqDl7Z69McyePsKMKk8
	F+n8wh0DahYwYTflTvGrr3cGKtZb7jQi+Tk7fuh3JaduotXzpFiBtS2smOFBnxy5
	bA3LuTXc4YHNjcijhGongBHgvrKuX5zIt1jY8dJ04jVrdtNY8rcg3p+tWBQK8wWq
	XlHusQ==
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11023101.outbound.protection.outlook.com [40.107.159.101])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cadx51gwa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:50:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVfxK95t+XvXduOB7FiqMv3n1cjyvj1Ontza5e/GvlA/hoDL+RpHUEjcjOLDb/YIG/USeUJHnMGKJ8ixOai8/kZbl73tGzd/acF/oROiorGSu0Rnk3bv0Yllfy4CF+8J8gLDw1cO5rUbetGplnWpby127GrV99+SeBNP8oVhBpGlht/ZHSqZNru7ureZyvHCpBoqlQd4GQpdqjZC/EOQvSPUfUlghWSWauMmtvegZbrdxLduZWif59Ke/4iU/1OdT/fJgFGkJqGJxeTmBM0WlSiFW3WwOCyATQUYYGv+4PEUYp/7rzw5qOcpAOpbVw+yBBHEuSPBWNasFeqh2YQS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl3hfgTpxu0WJ1zRqq4HEZtvplozH2H4wnlhhE3sJME=;
 b=ZsRKMLdXSnFtSG9RG4R0rrNive5xa75yrcDmjVf13C1iVF5AJ9LOKosl1olsq4+t1rmJjVb0Bn5HjvB4N3D3vt7jIjQHWPPUEzpCjuZizJNyRCHCGQbcUT5jsL11wEAW0Obx5668XdFGbK6wBCaNrOuXezegJ0kqmUXuw9bH42EZTOOsUq1QWt/JPyrsNq7/ibmHMzbaAfb5toGR5J/02j6jbzxh6yYZY6xvecLUBDWghOiXfAmzMHxBy2x8p8cHUQW1xLOYjDl0EnXWWmC9PBeTmWjWtYU82WwzT1nIhrcD71ewVInpIIj3f4V4yicdo/F98eD5/Iev0WmBYg5BzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl3hfgTpxu0WJ1zRqq4HEZtvplozH2H4wnlhhE3sJME=;
 b=Q9tEKGmj6CgkeeaX+RGwj5OAI1oBjY3zMVXMteoN+muvYblekt9W2O89rEBE78KLBabmdvgkkGYelhtPr/RKC4i3CDULsvka5FJptob9eW5rwaUl5kDXv+IZLKatTMuSqHAJzyOx5QKDRjpSIBqiX7FLiDFGdVQ/G3bmYT1rfKc=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AS2P192MB2117.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:50:24 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 09:50:24 +0000
Date: Mon, 16 Feb 2026 10:50:21 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Alex Gavin <a_gavin@icloud.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: wifi: mac80211: question about 20/40 coex support
Message-ID: <aZLoXb1QughJmIvq@FUE-ALEWI-WINX>
References: <aY7NLLnOCXS8L31z@FUE-ALEWI-WINX>
 <a3fd0a27-f09f-4950-919d-1b4ba2dcb16a@icloud.com>
 <aY7y84VZW465W_zr@FUE-ALEWI-WINX>
 <61276f01-5fdb-48d9-8c5a-cc3a765bb642@icloud.com>
 <261dcee1-e5b9-4b9c-9052-f726fe5beb69@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <261dcee1-e5b9-4b9c-9052-f726fe5beb69@icloud.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVZP280CA0028.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:276::9) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AS2P192MB2117:EE_
X-MS-Office365-Filtering-Correlation-Id: fe790581-693a-4e92-aa44-08de6d40cea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGdIQmZmdkg3Yk45ekpqRVpoQjl6aVE2NGNrbHJuQ2xWMUs4aXQwYW5yRi9u?=
 =?utf-8?B?Z2kxNmtHWXZ0WS9nS2pTM1VIN2FuN0ZWQ2NNMHJWMHFwamp0UGwrQ1R6OVpR?=
 =?utf-8?B?cE94dHZ2Q1U4bUZVWTRuOFdRQzkxT2FOZldObFU1dVlyS0JGTHJmZzZMR2ZP?=
 =?utf-8?B?eEUxazlhK1d3ZVFKV2lUZTFKNnY0SjhxZGFvYWt5bTFPTkhHQmZyb0ZZVkNn?=
 =?utf-8?B?ZDFWWUcycHVjeUg5UGY1MEhBQ3Axa3c4TFozVTZ5SkhuZUNpVmQ4bDJZbGVJ?=
 =?utf-8?B?ck80TklJYkJoZDVFcTAzaDlialgxTkVRK1cyTitPMC8yT2RoWW1DWkxWcXRw?=
 =?utf-8?B?MEFZUW5VbGtYUS9mOEdCRDJQV3NYczJKL2oxZmlMUFFCR1RRRWhzSFFjTjhF?=
 =?utf-8?B?TWxndElab1dGWmlGWW9rdFdxV3RhK2VKY2Uvb3NDNkxiTjluZGZZeDgwTnNk?=
 =?utf-8?B?VzNVVlY3dmpKYTBTb0xJVVIyUThpcW1pVUkxZXFhdHF1UnJBN1ljd2t3Rjd6?=
 =?utf-8?B?TVFPa0l3WTVaWWZUQ0Q1dFh2bmtCQytHVThRNVVpZ0JNc1lUOVZ1TVErV0RG?=
 =?utf-8?B?T3h5enRxQ1NNYzhnRFpWa3BtKzB5TVB4N240cllyanR4RU1RRWU2WVMwdTQ0?=
 =?utf-8?B?SEYxL2tKOE9oYkZYdVVPcFRtcUorOXVUUXZnL1FqL0NIUXMxRnY0eGVDSTlG?=
 =?utf-8?B?MTBnZjRrV1d1RFo5YkltUmhVWGtrV3Y1R1RMVjZvYUVXcE8vN3pIZVZ5REMw?=
 =?utf-8?B?Qjd6U0ZEbTNwbzNyVkpaZlZER25keXk5d0ZDbG15RThkRUFqZmdqemZDZ2N0?=
 =?utf-8?B?SWtRVEFVRVhpTHhKNk5NQmdyNlIxTzh6ZHJrQWswa0pCVjFRU2ZiQS9ha3lk?=
 =?utf-8?B?amhWKzEvYkNwUmVYcm5FK0tydlhOMFplekVsUTI0ZDZVMEh6OXdGR0IxQVQv?=
 =?utf-8?B?NXVxN1lpdUVISHNCc0F4ZEd1TTJvMzFiVHV2VWxmZloxbm5EaVhWZUs2Wm44?=
 =?utf-8?B?L3l0NllNYjkrT0Z3WVdVZS8zajJHY1JSNTVZYUMvRmM0cStCYmRyb1JOdDZI?=
 =?utf-8?B?aVFJSExybGlvY2NaQjhhU1hScXcwOEtnZGNHWk1NbXR3RzNna2FVZlNORlVk?=
 =?utf-8?B?dk90UCszaFhhS2w2MlNBTlZkQUppY1lHWmY0dlExZFk0dE83MmRkTTQ0aVVs?=
 =?utf-8?B?TTMvUG1oUGZFZG05L1FvcUxzSDVjWXM5bFlaZFJaZzcwdEdlOUliWEVlL1Yy?=
 =?utf-8?B?a2puWlV5UVB0dkpkbGNqUUNlYThaTnZWYlZmMFdRRzFiMjZjNnVwbmpoTE80?=
 =?utf-8?B?MVpjandBVVVKVlRwWnBQNlRucjdWWGt3bk9ObXVjSVRGUzRSVW5QM2lSVExr?=
 =?utf-8?B?N3JBUFd2NDBSTHkxajY5SW96ZDJqaUpjYXZhWlJnOHBURkRITzYxbjkvNmoz?=
 =?utf-8?B?MjMwc2R1d1cxaW45cW51dk1QYjJ2VmcrSkJLbzBwN3VvRVYyNnpBakFGNXpN?=
 =?utf-8?B?K3pMNkRQWTc3VWNhRXRoZGhsU0wyUXRRWGJqejlNK25RcUMxdkZMMG80bEha?=
 =?utf-8?B?TmluZVo1V1Y1dDhUOGNHZWQ4K0UyYlhEYUd3Y3lnMEl6T1NXaDdCMlNvbHli?=
 =?utf-8?B?UGNzcnBLaEVndm5SNHF0QTZWdHNna2R1R3Q5azQvUStKZEU3UFZyWGpOY3Jx?=
 =?utf-8?B?NEk4aVltSGpVWmh4U0N6ZVpnNEkvZ09MRlR3bnRGWGZkY0tuREtxOTdkM3Fp?=
 =?utf-8?B?dDFyeXBDRy9tRWxKaDRuYzJMYWtyTDVNV3R4U2ZnV1dXbWlxZklsQk9ZRFly?=
 =?utf-8?B?SEprVUd0Y2l0SWtHQXg2cHNjRThPNm1Weml2V09sdTZjSFVpU3VNNzdaZkZh?=
 =?utf-8?B?ZVlWNUVmbDkvUnQ0QVZiWklXQUh5MU0wVGdXZG0zMUc1dkRlZytGU2NrbkpX?=
 =?utf-8?B?SW9SbFlJNUxXUEMyTDZQdkV5U05MQ1dKdkxMdkQyVFU2TlhESnR5QkkyOG1C?=
 =?utf-8?B?a29zdDYxQlEvUTRSZk42d0o4dXBIYXRYSUhXazFlQ0hMNUNyNzduU1hFY3ZD?=
 =?utf-8?B?ZUJwQVB3M2JNUWoydzFMYzE1RTZmRjJoWmcyNm9sdGQyZS9GRkdpQ3dvOUR1?=
 =?utf-8?Q?mQ+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEtkNXJJdVVhZU1Ub1hzU04xc0l1TUMvZHM0UEoxZ212dXBhWDloR3R4TTgy?=
 =?utf-8?B?WWtCZmFrQ0QzR3JkSG9SNWRlR1NPK2I2cGJBMXhtczdjd3c2Wnd5R1dhc1NN?=
 =?utf-8?B?UWMyWjRmeVltZ3JDdEZRZ1h1VEhGVlBWdVBvVWxlSEJ3S1hOZUdKTEs3V1BW?=
 =?utf-8?B?eVF4aEVGdDNiNXk0OXgvUWV6WTU4Qnkrck5jSmZxaUZvN1pKU3BMeDc4Q0ZL?=
 =?utf-8?B?cEM2ZUZuL3FOTUtLUm9YZWkrdnFqL01kYTVCaVo5d1NjdGlLNkRLWk9QRzFX?=
 =?utf-8?B?alNNcjdPbHlyMklyL0xKbEFUb2pSK2pFNGZHcUY4WXJJRE40UzRzbmpLNlVG?=
 =?utf-8?B?aDFiVkkrZDJPeGd1eXpsbGYveG5Uai9velovSit4RlJwVTVZQkRmbU1SQnB3?=
 =?utf-8?B?N3piL2d0MnFuVnQ0Qm9sWG5MZFUyRmlKdGpTNmtlQXFjUTNJQ2ZYNkdLTmlO?=
 =?utf-8?B?TlJyK0pSRmd1WXEvTWlMZExrYnVqTEYzY1M0M214VHFQREFwd1lVNThhVHRq?=
 =?utf-8?B?OGpsSXg1S2xwOUVHMCtqVlM5K2JOYVBDRUhWYXU3UlNhV0doRzJpaWgyakg5?=
 =?utf-8?B?NlJiclZDOU83TU0rcEN6QlJYSHIyUEd1dDUweTBZSVJvWlo3ajVBdk9Zd080?=
 =?utf-8?B?c3libnk4QU8xM0hOQWpNTGFQZ1JqRytnMVMwVXd4czZ3a1E1QU4zNFc0Q1E2?=
 =?utf-8?B?OVJ2N0FSdUQ1dkRNUVoya1RYU2hGeDcwdVp3N1ViRGh5N0xmMFJNaU92L3Zn?=
 =?utf-8?B?M1AvSHdPL2V5MWlxM2ZSbS93MER1RURqRHd0K29rZ29naDVBQW9oRmEvMmlp?=
 =?utf-8?B?UnRYandRZjJoUGJSZGR1WFpkRU00Y3B2NWU5TkxnRERSdndHY0dzdVBoSFNr?=
 =?utf-8?B?a3VzR0JRQUJJUE1EaVEyNGt2Nm4yQjVQRnFkZWpkcVVYSWJNTzZZYWYwaW1W?=
 =?utf-8?B?TkRwblIvdC9YeDZvcnFCSGRWODJENU1wajRVRm9wOEw0WXgyRnhydDgvaGho?=
 =?utf-8?B?TitkMFZjUEVFdzVNUTFCUGJmSzRxbFZ0bnZEZ3ZNZVhucGplcmRJSW8wNWlO?=
 =?utf-8?B?YkwxYnFhK2FSajNXWGU1dC9JNkZGNDBHUUt6VGdRZ2g5NXZkSWl3b3E4Y1pw?=
 =?utf-8?B?Tk1kT2ZUNklYcHNydTVrRzJONEdlK0JHR3UrVnJ4cDdyQXR3OERMZjRwSTJL?=
 =?utf-8?B?T05BL2FhUUgwSEJzN2NxVWVuUVpENE5aWEdjQW1SejRaZ2h6UGIxT0U5TERJ?=
 =?utf-8?B?S3Qxa0hHTFBwU0dJUXFVbnBXRmJnN1Y5U3Y3VVdwazVObE9FQTFBRktlbitk?=
 =?utf-8?B?VEo5aFRQUXZOVGhlNjZEalZpalRZQTZ2QnkzWi81Vmhsb3lQb2tXVWZIaWYx?=
 =?utf-8?B?a05ndEJjMXlNYWxnOW5rR0ltWUp5d2VFN3JOcXN0Y2g4aGZUN1BlOUlFenFK?=
 =?utf-8?B?MTFNSm8zM1oxTlVEcFp0Y0VRQ2l5dFc1ODhEK1hSeFlGVkVoSFRucGs0VjQ5?=
 =?utf-8?B?R1VlN2xmS0ZFWHVmcGdsWWp3OUt5V2FValhHNGRyS0xLMkdjdXpWUTVEM29a?=
 =?utf-8?B?NDYwWUhGNmw3cFpIeVYxbk81MnNUN2xMSkxYOU1IZzdDVlk0Mk1RUFFsOW1i?=
 =?utf-8?B?THN3cXZCenJtbzRYUGlKU0FIOUExeG5MdTVZa09kS2t3UHBFUDRIdFpCcG9q?=
 =?utf-8?B?QW1rc3d3UjdKWGpLUmJYK2lnc1pvL2krZjVmdHplWnVGUkI5QTZUL2kvL1U4?=
 =?utf-8?B?UXYzMkUrYlpRcks2U2xwZWgzeGNqRUVNTlJpLzAySndHb1dsWHZuN2YwTkJY?=
 =?utf-8?B?ZXh0YlBpR1IySkhRSUd0SjNlMlJUelgydDcvT0EvbGlZVk1HRExkTnp6ZVpI?=
 =?utf-8?B?NHB6VjhQSWpEM05YYmxMSWIvMDkwcXFiTjJDTFp0dzNaUzRNeEl1WkY0ZW5C?=
 =?utf-8?B?SzZPelVDM0M5dHl1TmNlOWR3ODBZdVlOZXBaYTEzOEVKOTBrMUl4MnBxODZX?=
 =?utf-8?B?aGZja0thR1RJNnN5S295djJDVmFhY1JsdCszbTNDRkFzaS9HNEVwMzVuK0to?=
 =?utf-8?B?c3hvVnkzZzI4SmFhZi9JNG90aDUxb1VGV2crZmMzYzlyMzdSTXFLb1NtV0pT?=
 =?utf-8?B?TkJIa044T1lLMjdlalcxeGZlVURuMHNOeHppTVVVT0RyKzFHdFRJaHZmS0xm?=
 =?utf-8?B?d2s1QThFKytWMllKSjdmbnA2aDlyZmlyRDdRa2RXQWlVL3lJeEh3WXV0aE1M?=
 =?utf-8?B?TUVsR3JmREhoUW5YWFZ2aDgwWDF6T0E2alpJeks4VDQ4Y0ZLaUdrYnUxUzJO?=
 =?utf-8?B?aGJ1NUdmUlV0MFB3czRMeHNwL2k2TG5zcG1tRGhFUU5pZThDMG1hdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rBiFoboBKkqbDIRSSUiEiKrmqnRiGPDuV8abkH9ojhRBuqeFnm81Yr9fNaV7YV/i4d9lhtOtu2BP8wixPWzmdODMFApHBVMznk3gHanxpaHPOtdkXtrJsY80DvpATiebZzd5TB2qq+ygquOxVQp3/s5cykVCArq/8zmVG37gg+rt6OrYCtcaxVbVyfo4PKIrPH9+g5dzk4/v+1puzhC2IJR5R1n0mA0+4K6AiGkGBO1BRpIDoEBFwve9/3j+TLp2OfAh5rqCAak9HfTReVQAvXciBJBZvU6Oa1u6E6ByEhfty//28aTnGW/Kh/JxYK/h0yiqqBVhtfWLbuT6UbtRykzYoAExz4bhHVJEge5ZwZyM3mymsTlh548rhQwyqm1KH1ZE6fBl1Dst/OrlxZLAP2BkIs7MliZWVMZlVbPfEcLiAPduImQcqQwvs4zTbvbaV9okfQMcI55Zngas5m0ucCS8E10WxDtJHyqlF9QwIjXRPWUBUcBNqI+oLCVDnVBnrZYNEb/KUkikd0KSYRznQYiOotrrQxqnBkfWChB1WZZ2kCehn+hReze9zM8h4yug2RTjJW81E5Ne6yIKaKrDsBR0ifVQVJ49eRIlpEixL2Ob3g7qSttoB7MNJeOj1dJj
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe790581-693a-4e92-aa44-08de6d40cea3
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:50:24.6221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOzGi2WB/0Pad+RKlzILOejsOqlLfGjzrwVlzDwsBSmIv2hpBOKnTTXJrxEllWERV6Dt7R2DOMCjrPPxnmONDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2117
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
X-OrganizationHeadersPreserved: AS2P192MB2117.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4MiBTYWx0ZWRfXxkeGgyXLXzHP
 j0TNUyZkUB2YsVwH2So/GG+Sh9NPKf6wgeF5tVlA2Jr0UIF+AnRd7IC40W7U17zT3w7zPY0n/eQ
 315FdXdbBP/sZKuJ4PggjZmCrJslZJEovF+QnlYb/xgV47MFZXsvikFlsRb/Ivwmfo5sK20wSkP
 XE9s2pzC1plaMZcZ/5Fp8yV0WUzJdfMwKIpwAE2WbtT4ZXuD/rjoibfeVKY/bnPcoVZnDEFDnfe
 r+SwKQmwEsnw01xE+jQsuZ0NIeoruWCZKhxLHgE9YvYc6J6kym2iX/ZXanf58EHt2LkP4y+w4ib
 SoTy3ZfAg06z4HD3gFhWUFsi8jUjvPUEb9Ehi81J/Q6k2a+a4w4j7ApvgApiqYswF1JW7MFPwYK
 811srM7q6BVuKTmfbZC006zaTdykqKQunTLXpZdlLL3wsFiLX2UaKFSI5Oo2YpFJbROuzFohHQz
 +Q2puKYd5slPTChIIOA==
X-Authority-Analysis: v=2.4 cv=OpdCCi/t c=1 sm=1 tr=0 ts=6992e863 cx=c_pps
 a=pcOzTpqVKfWy+bLO9R5M0A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=yaAG3qJ-AAAA:8 a=SXzkmgPmAAAA:8 a=i9Wy5rNffVyLRxwbNK8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=oLVlbjkABFOu4cUI0CGI:22 a=EWLf6cg6Bh5aS0AxDgDu:22
X-Proofpoint-GUID: 5-c8u7Cc97uSiN6w_t1Lgpju1O8a1NZw
X-Proofpoint-ORIG-GUID: 5-c8u7Cc97uSiN6w_t1Lgpju1O8a1NZw
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31883-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,urldefense.com:url,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 65A9014212A
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 02:01:37PM -0800, Alex Gavin wrote:
> On 2/13/26 13:44, Alex Gavin wrote:
> > On 2/13/26 01:46, Alexander Wilhelm wrote:
> >> On Fri, Feb 13, 2026 at 12:14:16AM -0800, Alex Gavin wrote:
> >>> On 2/12/26 23:05, Alexander Wilhelm wrote:
> >>>>
> >>>> Hello wireless devs,
> >>>>
> >>>> I am analyzing a wireless management frame taken from the beacon of an
> >>>> access point, and in this frame the `20/40 Coexistence Management Support`
> >>>> bit is set to 0, indicating that the feature is not supported. See frame
> >>>> below:
> >>>>
> >>>>     Frame 2: 217 bytes on wire (1736 bits), 217 bytes captured (1736 bits)
> >>>>     Radiotap Header v0, Length 26
> >>>>     802.11 radio information
> >>>>     IEEE 802.11 Beacon frame, Flags: ........
> >>>>     IEEE 802.11 Wireless Management
> >>>>         Fixed parameters (12 bytes)
> >>>>         Tagged parameters (155 bytes)
> >>>>             Tag: SSID parameter set: "SSID"
> >>>>             Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
> >>>>             Tag: DS Parameter set: Current Channel: 6
> >>>>             Tag: Traffic Indication Map (TIM): DTIM 0 of 2 bitmap
> >>>>             Tag: Country Information: Country Code DE, Environment All
> >>>>             Tag: ERP Information
> >>>>             Tag: QBSS Load Element 802.11e CCA Version
> >>>>             Tag: Supported Operating Classes
> >>>>             Tag: HT Capabilities (802.11n D1.10)
> >>>>             Tag: HT Information (802.11n D1.10)
> >>>>             Tag: Extended Capabilities (10 octets)
> >>>>                 Tag Number: Extended Capabilities (127)
> >>>>                 Tag length: 10
> >>>>                 Extended Capabilities: 0x04 (octet 1)
> >>>>                     .... ...0 = 20/40 BSS Coexistence Management Support: Not supported
> >>>>                     .... ..0. = General Link (GLK): 0x0
> >>>>                     .... .1.. = Extended Channel Switching: Supported
> >>>>                     .... 0... = GLK-GCR: 0x0
> >>>>                     ...0 .... = PSMP Capability: Not supported
> >>>>                     ..0. .... = Reserved: 0x0
> >>>>                     .0.. .... = S-PSMP Support: Not supported
> >>>>                     0... .... = Event: Not supported
> >>>>                 Extended Capabilities: 0x00 (octet 2)
> >>>>                 Extended Capabilities: 0x00 (octet 3)
> >>>>                 Extended Capabilities: 0x02 (octet 4)
> >>>>                 Extended Capabilities: 0x00 (octet 5)
> >>>>                 Extended Capabilities: 0x00 (octet 6)
> >>>>                 Extended Capabilities: 0x01 (octet 7)
> >>>>                 Extended Capabilities: 0x0040 (octets 8 & 9)
> >>>>                 Extended Capabilities: 0x40 (octet 10)
> >>>>             Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element
> >>>>
> >>>> I reviewed several driver implementations, and none of them seem to
> >>>> advertise this capability. I also could not find any definition for this
> >>>> bit in `include/linux/ieee80211.h`, unlike many other capability bits that
> >>>> are defined (e.g. `WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING` or
> >>>> `WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT`). From what I can see, none of the
> >>>> `mac80211`‑based drivers appear to support this feature, is that correct?
> >>>>
> >>>> Additionally, I want to confirm whether my understanding of the feature is
> >>>> accurate: the 20/40 Coexistence mechanism implements the “good neighbor”
> >>>> policy, meaning that an AP using a 40 MHz channel in the 2.4 GHz band must
> >>>> fall back to 20 MHz when it detects an overlapping BSS (OBSS). Is that
> >>>> right?
> >>>>
> >>>> Any clarification would be greatly appreciated.
> >>>>
> >>>>
> >>>> Best regards
> >>>> Alexander Wilhelm
> >>>>
> >>>
> >>> From my understanding, this is implemented in userspace (i.e. hostapd), at least in upstream code.
> >>
> >> I've alredy seen the code in `hostapd` that implements a fallback to 20
> >> MHz. But that implementation is based only on scan results, not on 20/40
> >> coexistence feautre. Here the snippet from `ieee80211n_check_scan`
> >> function:
> >>
> >>     [...]
> >>     if (iface->current_mode->mode == HOSTAPD_MODE_IEEE80211A)
> >>             oper40 = ieee80211n_check_40mhz_5g(iface, scan_res);
> >>     else
> >>             oper40 = ieee80211n_check_40mhz_2g4(iface, scan_res);
> >>     wpa_scan_results_free(scan_res);
> >>
> >>     iface->secondary_ch = iface->conf->secondary_channel;
> >>     if (!oper40) {
> >>             wpa_printf(MSG_INFO, "20/40 MHz operation not permitted on "
> >>                        "channel pri=%d sec=%d based on overlapping BSSes",
> >>                        iface->conf->channel,
> >>                        iface->conf->channel +
> >>                        iface->conf->secondary_channel * 4);
> >>             iface->conf->secondary_channel = 0;
> >>             if (iface->drv_flags & WPA_DRIVER_FLAGS_HT_2040_COEX) {
> >>                     /*
> >>                      * TODO: Could consider scheduling another scan to check
> >>                      * if channel width can be changed if no coex reports
> >>                      * are received from associating stations.
> >>                      */
> >>             }
> >>     }
> >>     [...]
> > 
> > There are ways the BSS can switch from 40 MHz to 20 MHz operation beyond just scan results.
> > 
> > For example, a newly-associated, 40 MHz intolerant station could cause hostapd to reconfigure to 20
> > MHz operation, assuming the WPA_DRIVER_FLAGS_HT_2040_COEX is set by radio driver capabilities.
> > 
> > Directly handling association:
> > 
> > handle_assoc()
> > -> update_ht_state()
> > -> update_sta_ht()
> > -> ht40_intolerant_add()
> > -> ieee802_11_set_beacons()
> > -> ieee802_11_set_beacon()
> > -> __ieee802_11_set_beacon()
> > -> ieee802_11_build_ap_params()
> > -> hostapd_build_ap_extra_ies()
> > -> hostapd_eid_ext_capab()
> > -> hostapd_ext_capab_byte()
> > 
> > 
> > Or from driver callback:
> > 
> > hostapd_notif_assoc()
> > -> ht40_intolerant_add()
> > -> ieee802_11_set_beacons()
> > ...
> > -> hostapd_ext_capab_byte()
> > 
> > 
> > Additionally, receipt of a 20/40 MHz Coex Management Action frame in 'hostapd_2040_coex_action()'
> > may trigger the AP to reconfigure to 20 MHz using a similar code path.
> > 
> > For testing, wpa_supplicant supports configuring 40 MHz intolerant stations. See below from its
> > config file reference [1]:
> > 
> > # ht40_intolerant: Whether 40 MHz intolerant should be indicated.
> > # 0 = 40 MHz tolerant (default)
> > # 1 = 40 MHz intolerant
> > 
> > I've uploaded some example hostapd and wpa_supplicant configs here [2], if you'd like something to
> > reference or play around with. Associating the intolerant station config should trigger hostapd to
> > switch from 40 MHz to 20 MHz with this configuration, assuming radio driver support as mentioned above.
> > 
> > [1] https://urldefense.com/v3/__https://git.w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf__;!!I9LPvj3b!AsA2QqDGWXpvNJ_Z3N2Trl0qQHOI1jDydzfs8Xjv-GME96gVt-Q4hgdZTkUlQISMAQmn7HqwqqSmayxFDxGc-woJ$ 
> > [2] https://urldefense.com/v3/__https://codeberg.org/a-gavin/hostap-confs/src/branch/main/open/20-40MHz-bss-coexistence__;!!I9LPvj3b!AsA2QqDGWXpvNJ_Z3N2Trl0qQHOI1jDydzfs8Xjv-GME96gVt-Q4hgdZTkUlQISMAQmn7HqwqqSmayxFD70l2TKr$ 
> 
> Since you mentioned packet capture analysis, to observe a 40 MHz BSS switch to 20 MHz operation, pay
> close attention to the HT Operation IE in the Beacon frames.
> 
> Assuming you're using Wireshark, you should see the 'HT Operation Information Subset (1 of 3)'
> section switch from showing 'Supported channel width: Channel of any width supported' to '20 MHz
> channel width only'. I'm sure other programs are similar.
> 
> Using the 40 MHz intolerant association example, you should see this switch immediately after
> station association.
> 
> 
> 40 MHz operation:
> 
> Tag: HT Operation
>     Tag Number: HT Operation (61)
>     Tag length: 22
>     Primary Channel: 1
>     HT Operation Information Subset (1 of 3): 0x05
>         .... ..01 = Secondary channel offset: Secondary channel is above the primary channel (0x1)
>         .... .1.. = Supported channel width: Channel of any width supported
>         .... 0... = Reduced Interframe Spacing (RIFS): Prohibited
>         0000 .... = Reserved: 0x0
>     HT Operation Information Subset (2 of 3): 0x0000
>     HT Operation Information Subset (3 of 3): 0x0000
>     Rx Supported Modulation and Coding Scheme Set: Basic MCS Set
> 
> 
> 20 MHz operation:
> 
> Tag: HT Operation
>     Tag Number: HT Operation (61)
>     Tag length: 22
>     Primary Channel: 1
>     HT Operation Information Subset (1 of 3): 0x00
>         .... ..00 = Secondary channel offset: No secondary channel (0x0)
>         .... .0.. = Supported channel width: 20 MHz channel width only
>         .... 0... = Reduced Interframe Spacing (RIFS): Prohibited
>         0000 .... = Reserved: 0x0
>     HT Operation Information Subset (2 of 3): 0x0000
>     HT Operation Information Subset (3 of 3): 0x0000
>     Basic HT-MCS Set: Reserved: 00000000000000000000000000000000
> 
> 
> Hope this helps!

Hi Alex,

thank you again for a great support. And yes, I'm using Wireshark or tshask
to analyze the packets. Unfortunatelly I'm currently struggling with my
noisy environment. I cannot realy start an 40 MHz AP without force it with
`noscan` option. But then the Coex mechanism does not work as well. But I
think I'll get it working with some workarounds.


Best regards
Alexander Wilhelm

> 
> >>> In hostapd, the '20/40 BSS Coexistence Management Support' bit you reference is set in the
> >>> 'hostapd_ext_capab_byte()' function in 'src/ap/ieee802_11_shared.c' when 'obss_interval' is set in
> >>> the AP config file.
> >>>
> >>> For more information on the 'obss_interval' config item see the following from the hostapd config
> >>> reference here [1]:
> >>>
> >>> # If set non-zero, require stations to perform scans of overlapping
> >>> # channels to test for stations which would be affected by 40 MHz traffic.
> >>> # This parameter sets the interval in seconds between these scans. Setting this
> >>> # to non-zero allows 2.4 GHz band AP to move dynamically to a 40 MHz channel if
> >>> # no co-existence issues with neighboring devices are found.
> >>> #obss_interval=0
> >>
> >> Great, I found the the configuration in my `hostapd` version and the code
> >> that implements the handling of this kind of management frames. I'll give
> >> the configuration option a try.
> >>
> >>> The following sections from the 802.11 standard may be helpful to understand this topic in more
> >>> depth, although I'm sure there's information online that may be easier to digest:
> >>>
> >>> - 9.4.2.58 20/40 BSS Coexistence element
> >>> - 9.4.2.54.2 HT Capability Information field
> >>> - 11.15.12 Switching between 40 MHz and 20 MHz
> >>>
> >>> From 11.15.12:
> >>>
> >>> TE-B: On any of the channels of the channel set defined in Clause 18, reception of a 20/40 BSS
> >>> Coexistence Management, Beacon, Probe Request, or Probe Response frame that contains a value of 1 in
> >>> a Forty MHz Intolerant field and that has the Address 1 field equal to the receiving STA’s address
> >>> or to a group address, with no further addressing qualifications.
> >>
> >> Thank you for the support, Alex. The information helps me a lot.
> >>
> >>
> >> Best regards
> >> Alexander Wilhelm
> > 
> > 
> 

