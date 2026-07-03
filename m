Return-Path: <linux-wireless+bounces-38560-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /UOyHnBYR2o2WgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38560-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 08:36:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCED6FF1E0
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 08:36:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=westermo.com header.s=270620241 header.b="Iqsep/6h";
	dkim=pass header.d=beijerelectronicsab.onmicrosoft.com header.s=selector1-beijerelectronicsab-onmicrosoft-com header.b=ZqTR+XOg;
	dmarc=pass (policy=quarantine) header.from=westermo.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38560-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38560-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E48E3007523
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052537B400;
	Fri,  3 Jul 2026 06:36:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C9359A70;
	Fri,  3 Jul 2026 06:36:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060588; cv=fail; b=nrJwmMIZu8pvhBrxevWJIkKZB0t+05c9C9ja8hZiU5bfnm+0JOeIdlX2amShHG3Cwc2dZ9QbIxg0ypLoGgWu/O7ganwZAyzyhr9y0sQt/d++EZNvg2hqgGrOlYLsK/ahqhAqJ+Dzdp+3rdIzeuCFk2S7WCX5ICUSbuhJxNV3bl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060588; c=relaxed/simple;
	bh=gHDI6Mzm8eunkwDzCvlH+mL0s7lJ1k+CHXkc0dDEhmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FqCCHsCWpFZYlGxro0zbrG58+fKCqgVdgy8IHrRiR3X0zDg1W4WRrfy0viKn+WoVUC1LKrdClIOEyDi/F+nwiBHzK+B3IT/xcPbIKTPxZ48rwXOJmbyRb8xabRNqTcw+EeAUIZJDE2TXZqYlxpsr7Jzl+jJjRlOjbsSNMYjxyFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=Iqsep/6h; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=ZqTR+XOg; arc=fail smtp.client-ip=185.183.31.45
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635u4YS2814286;
	Fri, 3 Jul 2026 08:36:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	BSKHa8SgmapwAajZtM/7krp5mI1FF2jr+mTMNE7+xzI=; b=Iqsep/6hcMZ7OhWt
	tAS6zbiocel7vcubJKSGTIZMHg4WyAwsC1Ab3erlSCsX+Do5SfzcFa9CZhYd5f2m
	t1VKeWC8ImmUfb47amzu1VgGHeZ1fAd/6LgwWN8h5IiyNvoY5Pizds+c9uVD/yP7
	GCj621Jupf4j/5B8k6qSADBKNHP3TFFp+2+EBhOVxOhysb7m37CE0sfs+KPIPr7T
	lwCFK7CDbLEMlOwtA2AvhH8Stm9QvvnLr8j8IH3qA8WiAkQ4QFL6Lu1y4kI0trX1
	LcZEehyZo3aG5JU0rMr9m5MFtdYuLPyAWaH8nf+n7RyVbuaGlIOzdqed4m7EOrqy
	bpI3AA==
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11023128.outbound.protection.outlook.com [40.107.159.128])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4f56sg2444-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 08:36:13 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4ANsvaHhOdI0l5U3LMk4aYLP5lgJ9NnWKKW29+GJLt+K1/gYHhXX3+LeWy+YvEZcmCzyDLE0CJudFEDoqPo7Mnxxwyn3OKa53Hrk4xQv1dDTZCo93wAR8OO892BtLyY0HujjO4eqHvSFQKCZSp4fFmrc0X29nQnm83RwkLpQCFAa1rH3Wp/pzm3b9I2W5/+zrjV6HxslwTzEona/ygHMj8uajU42/v+y7N4xmS4Hf0C1jxKu+6qyopypaiMjL1I3zeQ1TtVLMYpUguffE5PdwCgXsFL7lgUOEyxAEf3029ibKbb43IWcIS4cy1kKP3DBGJvtfHyk0uvozSixpimPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSKHa8SgmapwAajZtM/7krp5mI1FF2jr+mTMNE7+xzI=;
 b=pW3xilWpM86aV6rDfZP7TVK0kpHOXIycDAGkDJglsOHKRfCh2ZBz0ktON5INdK5/uqia14DgwTupVVl7mCzLEl0wYQ2E+yEDP1CJ6TBrb8mMQHBmnqfzOL4UOLPE0vhDSYBrY28o402vIS866npKIvov6PX+0fDfVQp/Ty087ifOW+HZRjh8PeQLwKOY3GOQkEF3xUaL3zces/moUpPbbDg9RwqFUQRl3gOF4ylxeppEOQVuqv44dQORseUudh8ERtWA4wtHHqZ3f/pEpD27rMN4r+H1hztM5yBeSwPbTj3cuFiwdsyf8eWtDDy5fasXoXpxGpFw6nj+o99PA9Z8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSKHa8SgmapwAajZtM/7krp5mI1FF2jr+mTMNE7+xzI=;
 b=ZqTR+XOgGBtmHBVaiffSFO0E4UE5pb85GWIzvgF5ZKd7rQRKVHYioBKPWaxD9wmoDaKVWz7IaRY3uAtSo2d96uEGnPWxd2QX/K1WrK+EVD64VjljXQqAt6n5cmm/yWAFfPmuO1kk3jA1nSt0p4mpCUA4WXkXNJbNs47Ljmpj9QI=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by GV4P192MB3215.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:2b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:36:09 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:36:08 +0000
Date: Fri, 3 Jul 2026 08:36:03 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
Message-ID: <akdYU_Lejd2FZeIN@FUE-ALEWI-WINX>
References: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
 <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
 <akYkNQTB5DPwzYXZ@FUE-ALEWI-WINX>
 <akYsszdtJfrvIRSr@FUE-ALEWI-WINX>
 <cdd85c7d-976d-4bc2-8792-bef7e98afbd4@oss.qualcomm.com>
 <akZUUhopfdxb3VTX@FUE-ALEWI-WINX>
 <980e1f5c-a845-4180-970d-02f6496f2956@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <980e1f5c-a845-4180-970d-02f6496f2956@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVX0EPF0005F6E1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1e9) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|GV4P192MB3215:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a28ee4c-4df6-473e-c43b-08ded8cd5dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	Z2U82T7i+o+gLpP89mqEePaeKaq2pFJCoyV0pOvERyqWn0vy2v7zsQfvClUVa2dzfh/tc592KZc5J/BmJ/MsxpTB4RPG9DNqiKtYjrfCvNieCy/Sat8+WOrRTZjHIuhb3bdbyQaq1zW0RBbYOP7waLFn4Ek3CUkn/FCssyKq80RT8iZ9VjaIyIcpzNZZ1gfSbc64WdEZbQoWQNKaCfgzL0dQrR1TdTLEZ1KDofUlLVtr6R1R6lsRyqfV15GIXmJTPEKA9HndlE4x9/3WsjtRTEGIt4cF4l6YVeTPH1Hcw++YibnWdtvQyzMpdPGk2qK6r0lb+Ag5ECCqPmf8B9MbxeDouXDD8jejmhNr/2baOvUGtkmm4Kj4zVzYefx4mIaL0+sj4wzA4R3jWFv3wQdlBv4KdQsl1az7JrkCqBFCxu7NPvfRzjv9XqSX3y3wdvRyEpN6siWEwyFvuyBqoyuOSe+mo74Ny/xp12JzJQIbPvbx9wwSgzxC/RRC7tlNR635kIzOoMfLdYBDOlyj5ul3RmkWU02fGid46bzYkD+oEFiNTV8xIBqkwkTpzjF5qtsxf7vGfdLI24ENBS6gxP0Zx2cRzHTH+h+7fIPPDea3iXyn8woAzYsHo1V7a8b03wESewX1AlpSumJpeDu5LPVypgAQ9yEHYs/uYlHsx4JukHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjRWYUprTUU3dUlwYjZHVjBhSFZ1bG5kQ29pK0VyQ0cyWkhKVlhWNjRReVV4?=
 =?utf-8?B?QlkwcEVYaCs1THRpUVpVOWhMU2V6OUprRVMzMUV3MU5ZRjRtR2pRZlFIdTYy?=
 =?utf-8?B?ckZtVEZjcmR1ZFovRHpFd3lVempVY1ZXdVFpT0JGcjhEcEl1SCtDbDdzUko0?=
 =?utf-8?B?Y1VHbG51bzFiQm9NeTZmb1oyMEdYaFBkU2V4c0RSbnRCcmNoZWpvVFNNRDJ2?=
 =?utf-8?B?aytKUlhjZXZOSVlTb2dtV3hLMUg2ak5ZaENRWGs5YkFzVUF5UGtVY3kwVmFB?=
 =?utf-8?B?eHhwR01TTW1tVkhuSHphNUx1ZmN6VVJsdW1MYkpDalhSTTVNbjRJRUtsTmZp?=
 =?utf-8?B?b293aHNIM1ZCKzRSbm9WYU1zSkgwdE1CNG1PZWhvYUx6bmJ0Nk9ZcnJiV0wx?=
 =?utf-8?B?eEJUREtUQUdjNExmM205NG85RWdLNnBjcUdHR29YQTk0UHJ6K1VBUXpGdnJ4?=
 =?utf-8?B?dXdqSmNlSlNZd0drYThGRUtSREJhUXdwTGdkc2lqWjdmTk9sSHlXYzlwVDNR?=
 =?utf-8?B?SW5wNG9pTU0zT29ZSnNhZVpybkNnc24rVnRObEJpUTV6QStYbjBZRUlaUHdj?=
 =?utf-8?B?akx0Y09QWmczRFhzTUN0d1VPMk50a055V1ZBZXVrdkJkT3ZsYXhWR25Da0I1?=
 =?utf-8?B?bHVQdVNjRURkV0lWV05OdndzYU9RYVZ1WU5EbUJtb2JoWWJJSFlyaVlrRFJB?=
 =?utf-8?B?bGhBTStYTzNLeUl0cW9FUjZDRCtMMldvbjljOXMrenJZUTgwSmV0VUd2YzF1?=
 =?utf-8?B?N3pPSUo3Mjd3dVJkN21obmhzYjFZNE5KZi9nUDkxZlJqeHZ0aURWaEkrMXY5?=
 =?utf-8?B?S1JmYnJUS2FIZGdhcGNWVnU1MWtYR3FFMkM0bzF1aE02SnIyVUl2MEI1ODcv?=
 =?utf-8?B?VFFyTjBrckxQTExpYmhWUUVoa0hxT1VWVGZwaWorNElNS1BNeXFkZGJXWi9r?=
 =?utf-8?B?YXJFTi9TeEJFZW5mWjZUckV0dHpzYmx1RFhXMmJuL3Zpek52dlh5U0o5UnlV?=
 =?utf-8?B?SVN0eDQ0UTljKzFROWVRR0FFbW9uS21wNWtQMUkwVGxFY3JsVUk1eXpwcENR?=
 =?utf-8?B?V2doZS9pelBGUTMvRmUxL2dQbWZYVzl2L0NRcFh5M2VmQTRTU0U4MmN1Njds?=
 =?utf-8?B?Q3V2M21GOGIzNmJEWitnbFNsTnFlSk1pam1SMVFieTlBK3VscDFaWjJicFNO?=
 =?utf-8?B?NlZHSFYxWG9HRmh3UlBCNFJmTDV2cjJ4UTZ6VWRrK1pNN2xzdlBsZzlMNmxV?=
 =?utf-8?B?Z1p6SERTbjljYnpwcTNKUnV2ajd4b013ekRXRHhCTzdtUFZQVVQ2bWUvTmZR?=
 =?utf-8?B?SWpuUmxrOTVnMkZCVmNnMWZRbUlwbjVDVTZYMGRRbzdaYlc5d25EdTllSHNM?=
 =?utf-8?B?RWFZOG9pM3BSR0Y1MnpxM0NiUjFBN092S2h3MGlUSmx2SjcrVzJodzE3ZXVC?=
 =?utf-8?B?OFY1b2FnbXdWeklITHlKYnB3SkJvZDhlQ0Fya0ZXbTB3RDh3OHh0YnlZbWI0?=
 =?utf-8?B?RE9XcjFMZmhNRFJwUVlhMVdDN2pteWp1VWo4Vjg4MUJWUkczbVMyMXk5c3dZ?=
 =?utf-8?B?RTBJaXdDR1NUZEFpbHR6c0wyZ1gvWkJ2cHhxZkVEdGZTdGljWE5PZ2VkYkJ5?=
 =?utf-8?B?blVvOFNTWUJPSkZOUXFxRWIvNGFXdVVNQmtvVDI0Zkc2bzlwODBkU2ZWTXFG?=
 =?utf-8?B?K1RIOFgvRy8vWU5SUkRZQk0vYUpleVhNaEh2SUE2ZVg1dzQvVUFmRFZhQ1ZU?=
 =?utf-8?B?bkQyNFB0NW9qT3BNMnpDU0JsNjFUZjRZdnlVKzlzei9aZFdObEZmY3FsVlpR?=
 =?utf-8?B?Nm93Z3pvU1VrYzgvUXoybDdHMkI1QXF6Q0w3Rk5yVklORldxT2ViSThjT2VX?=
 =?utf-8?B?RUJkeDlibmhUa01MNmdIK0VYZHZheXNoYWV4cWx5RjdOVkdDZ3ZiOEx4Tkdx?=
 =?utf-8?B?cy9xOTQ2N0cyVTJnUE1LK1N4bUtxRTZJRDhnZUV0YXdtOUFDd1h3ejFZRE9T?=
 =?utf-8?B?VmR1alMzMS9ZUW9QSjhkT1E0aGpFV0F5OG9Yb1RISG05ZW10RUJkZm54bVJQ?=
 =?utf-8?B?eVljcENpVlR2V0YyUFZ1WitwWnR4Sm9WTWRhZzJjaTkyYS9jWWQyR0Ivd1pa?=
 =?utf-8?B?NjQyMnRJQTZTZlNzQmxVclQ5SGVIK2psTjUvckwzbWJKczl5ZkdqMW9IRUJM?=
 =?utf-8?B?VC9HcFVuclZsMUxrKzJrYUdCaDZNQ3pzRlpkc2tQODNScjhldlFqR0RDZ2Rx?=
 =?utf-8?B?N1ZSUlZHWTBkZExSQUZjZlhWTHVJQmV6a25saTRlVy9PQzc3aUFqMTM0clls?=
 =?utf-8?B?MllUOGtkSjcyOXU4Tm5VVEt3TmhyeDJvQXo4UnNuRngvUFV6Q0kwUT09?=
X-Exchange-RoutingPolicyChecked:
	s/hVYM8NAktDV1/5vBYpFnlHuZebwjarZ4T9brJ3SLyPoGJ/cQC3a6RDuOXdg/f/y4R+yP66sufWt9oTbdH5qcRmV40fY/uyESbYcnbjfAnUjTeQ5s2MCLNoyDmw5RpRlrxeCn3paB02KJU2Q6Ops892ek7PnFYqUaDxQtqpZCjZLXBOQ9wV2zBImWC2E1V3DMNJ68CrNUhyZEsfFyCqNm5ECNdbjw8QlGuNV+XujkH85hKyOuo01l6jOqlYMZKtYR4xUmJJTE+oLN+orRFpQymlOWec27nxKAsSiEZclx4jBE1g9GwnlF/mKm1m50Y+zlNLWH3qmPM0p0wM6oPmOg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fky268vUSC7P0oy2Ty4xj3xIJqxMCYxW2pvDf6TZa6/qsb03A6tBbe67as+udJt05Z+TorozrXy4O1/g5mNyaYe4e+c4IdljINYGpBa1A84YUnU/Ko1lAC3xI4reAHwDtWRtMzUC40QQJLHJog5Q7kqXFfOuC3mty3kxrE1XCpOb0Do69BW6mIFS07GADKN7q+wxmYrzzO1kRoMYfZHuQUDLbcuCqy56+qqWlVEOgbfl+nGqNa8b3DWCkOgR56U/3maKLnP/wG1nVaKK921ISRCAWYu2TQ1lPymV8iN3Q3gEHMMzzzwjuDQpxpBHYRXv/foT2fieocZ97AyUzFmwNahROBYTUIaGzIY8PAjyX2neDW8hD5J7Nx3aBAWMClEX99rBrz0Ol7mTEoKYBw9KCuN+C6zeS6h1BLOkyYT42EG5BYopGUySS0BR7s7LsKVcIZngDhCNy8eeAZPmfjqAMEBtpL5mXsm5gCiMiLgkVQHl/8k6A7flnQ1HD4dsnkT8EgLoMsTEcfhr2OipHirnLmL5goBKbPEkWhiFUlVOXs2cNCZWbY1i4s6bAhvueGa7nOtm86lOfkjHi+7j34ZLW/aH24ec9Xwkc/FSegVECAi7Kt4TTaCdGxCVL5WyMOd0
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a28ee4c-4df6-473e-c43b-08ded8cd5dd0
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:36:08.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3VXjmYqSw9X78eGWYGdh6Amk5xtVc2HmRp+4hxOSF0Mcwj9EaI/6JOdSD9arJMRP3NsBs809lr5CQPW6hAl8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4P192MB3215
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
X-OrganizationHeadersPreserved: GV4P192MB3215.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: MzQMyumn_KbvVRt0-Q0ahaDiRQcLEyEm
X-Authority-Analysis: v=2.4 cv=OJoXGyaB c=1 sm=1 tr=0 ts=6a47585d cx=c_pps
 a=bal5+AhnAL6dM2nM8UVcQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=Iwk81yimAAAA:8 a=7Cy53YJppAFV2WzCtMQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PqBb7rsBcpu_OT3Qf5tX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2MCBTYWx0ZWRfX6Ykwbj70x6PO
 pQXuKxGYeAESywrFakd0wfmSAZwSMQSBMc864uRyR3FwYwDpTiK5Tw2rSZ3hGETvAhAypy3+CcR
 HKiBNU1ygvZZGwn4U+pJDet20iKxC6wwpxFOLUk95MCIfSGvpZtooPo/NvaX+Ur+LtByjfpjLqT
 CC4K3CxenfgUnwPNAQlgAbD/97nNC/qqUcZfdrMkqKgDB5dogJ7HQMeJin7Uhr5gkfNXiQPNHgT
 zvIS3I0f1qtSWBc3IzlG54drZopxTdSsMT7e5kNJK7ZKvjvXxcFbpDdzIcPOlWI1OyRhxCHGDBb
 eO9yooUT0QrI/T/JEIdSSfvEpQ6hoVoEjH5cHapMRyOPr3R4p0vDOX56uc62E3Vt/RmlQWmG5tL
 +iRWGsTVKeuJ8I+jc7Bw22kyJzKEanKAzRK5isctDzAN5ngHk6k5f+rw/GTh2oV2bZ9UPmnkG3x
 X1i3MNRydKj1ifLJm5A==
X-Proofpoint-GUID: MzQMyumn_KbvVRt0-Q0ahaDiRQcLEyEm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2MCBTYWx0ZWRfX3gQ7EvNXNqmD
 Yk0yH2XYzBp7kxjzFDlNyiBd+LEWMxrkxiQJvL5K6tTdGyCoPEOLmPZPe1WZCjKM6xDVOaGAJ33
 2Ev7mbth4jYeV+gnH/+M66oWfGXWE5k=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38560-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,westermo.com:from_mime,westermo.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BCED6FF1E0

On Fri, Jul 03, 2026 at 12:04:10PM +0800, Baochen Qiang wrote:
> 
> 
> On 7/2/2026 8:06 PM, Alexander Wilhelm wrote:
> > On Thu, Jul 02, 2026 at 05:56:01PM +0800, Baochen Qiang wrote:
> >>
> >>
> >> On 7/2/2026 5:17 PM, Alexander Wilhelm wrote:
> >>> On Thu, Jul 02, 2026 at 10:41:25AM +0200, Alexander Wilhelm wrote:
> >>>> On Thu, Jul 02, 2026 at 04:12:00PM +0800, Baochen Qiang wrote:
> >>>>>
> >>>>>
> >>>>> On 6/29/2026 3:55 PM, Alexander Wilhelm wrote:
> >>>>>> The ath12k_dp_get_mac_addr function performs a simple memcpy from a
> >>>>>> CPU-native data types into an u8 array. On a big-endian architecture, this
> >>>>>> later results in a null‑pointer dereference. Convert the data to
> >>>>>
> >>>>> Alex, did you find a time to investigate the root cause of the null pointer?
> >>>
> >>> Hi Baochen,
> >>>
> >>> I am now running kernel v6.18.26, and it looks like the null-pointer issue is
> >>> gone. I only see the following log messages:
> >>>
> >>>     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
> >>
> >> what is the actual mac addr reported from firmware in the PEER MAP event? My understanding
> >> is that, without this patch (if we really need it) we get a wrong mac addr, then in
> >> ath12k_dp_link_peer_map_event() we are more likely to fail the peer look up hence would
> >> create a new peer and wakeup the waiting thread. But the log here clearly indicates that
> >> the wait timeout, which does not make sense to me.
> 
> I think I can understand the behavior here: even if wakeup happens, the waiter in
> ath12k_wait_for_dp_link_peer_common() checks the map result by calling
> ath12k_dp_link_peer_find_by_vdev_and_addr(). Since the mac addr of the newly created peer
> does not match, check failed. Finally we get timeout.
> 
> > 
> > I have now added the following debug output for `peer_map_ev` inside of
> > `ath12k_dp_htt_htc_t2h_msg_handler`:
> > 
> >     /* DEBUG */
> >     switch (type) {
> >     case HTT_T2H_MSG_TYPE_PEER_MAP:
> >     case HTT_T2H_MSG_TYPE_PEER_MAP2:
> >     case HTT_T2H_MSG_TYPE_PEER_MAP3:
> >         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info: %08X\n", le32_to_cpu(resp->peer_map_ev.info));
> >         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.mac_addr_l32: %08X\n", le32_to_cpu(resp->peer_map_ev.mac_addr_l32));
> >         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info1: %08X\n", le32_to_cpu(resp->peer_map_ev.info1));
> >         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info2: %08X\n", le32_to_cpu(resp->peer_map_ev.info2));
> >         break;
> >     default:
> >         break;
> >     }
> > 
> > Here is the result:
> > 
> >     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info: 0002002B
> >     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.mac_addr_l32: C921F004
> >     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info1: FFFF0EE0
> >     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info2: 000502F5
> >     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
> >     ath12k_pci 0001:01:00.0: failed to create vdev 04:f0:21:c9:e0:0e ret -110
> >     ath12k_pci 0001:01:00.0: failed to assign chanctx for vif 04:f0:21:c9:e0:0e link id 0 link vif is already started
> >     ath12k_pci 0001:01:00.0: invalid vdev id in vdev delete resp ev 0
> > 
> > Let me know if you see anything suspicious or if you need additional debug
> > information.
> 
> I am not really sure about the final mac addr and vdev id passed to
> ath12k_dp_link_peer_map_event(), so can you also add print below?
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c
> b/drivers/net/wireless/ath/ath12k/dp_peer.c
> index 47d009a0d61f..3e8201d536a5 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_peer.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
> @@ -162,6 +162,9 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id,
> u16 peer_
>         struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
>         struct ath12k *ar;
> 
> +       pr_info("peer map event: vdev_id %u peer_id %u mac_addr %pM ast_hash %u hw_peer_id
> %u\n",
> +               vdev_id, peer_id, mac_addr, ast_hash, hw_peer_id);
> +
>         spin_lock_bh(&dp->dp_lock);
>         peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, mac_addr);
>         if (!peer) {

Sure, here is the output:

    ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info: 0002002B
    ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.mac_addr_l32: C921F004
    ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info1: FFFF0EE0
    ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info2: 000502F5
    peer map event: vdev_id 0 peer_id 2 mac_addr d902298bM ast_hash 5 hw_peer_id 757
    ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
    ath12k_pci 0001:01:00.0: failed to create vdev 04:f0:21:c9:e0:0e ret -110
    ath12k_pci 0001:01:00.0: failed to assign chanctx for vif 04:f0:21:c9:e0:0e link id 0 link vif is already started
    ath12k_pci 0001:01:00.0: invalid vdev id in vdev delete resp ev 0


Best regards
Alexander Wilhelm

