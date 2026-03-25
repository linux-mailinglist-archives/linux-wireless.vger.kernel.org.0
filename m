Return-Path: <linux-wireless+bounces-33842-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKHWMxrjw2lvugQAu9opvQ
	(envelope-from <linux-wireless+bounces-33842-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:28:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D15ED325C58
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB26B30EC305
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DAC33710F;
	Wed, 25 Mar 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="JXI50M+B";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="BbTPkC1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566BE3DA5D4;
	Wed, 25 Mar 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443612; cv=fail; b=H7zDeOXAz3v/Q40uoLyIduGUJBJZ03DePefngWSmBdRy1EQfqOe3RIH56TsuLU/LtMIrQRhOvtqfq52wjcFYducxUxg+CE8yWuV4A9boiqf3LOjBFO52A6/i+tPTickgl+1+GHao4/hObJW6jbOb815074P8xT8KCT/uIRfKlzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443612; c=relaxed/simple;
	bh=6SRrwmxFBhezj+qFrP+yb04W4tQXIg0xEfR3zYaZgko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JYvXtpZ5CtjpuYakfBFiv+4xf7wtZlAU1Ge6sTamvpmJSaJNTuwO4geiPmElsKVXcALmnnkDSXM2DPrLIExyCq/9e2cdxUELmPnh30RTePFR/f39jAcRxj2SLJpctUzzItsjgUXIpd2H6kz5a6c+5O3kBnlcNqXDbgG267+fGdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=JXI50M+B; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=BbTPkC1K; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBagxO1647206;
	Wed, 25 Mar 2026 13:59:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=hF1EtBMKz9nu4YZscfRCFBhn
	kYfEvgUv8J2cvXwuRt8=; b=JXI50M+B22F+F7/qpr8W0DIIzOL/lEPoHDIYAzsB
	SiUgPpz7XzAjhP907xQ+1+lbhYB+KZjzXDxlc9ybxjxTe287BuhQsOy0Qxy44Gfc
	nLJski6j92GqtfNHbYLRFPWeZmS6oJ/d8BhCVXFgiUum3zMAnsr+Cf3ZRQTUbc+Q
	AU3Ytml2if/hVPMKX7uZxj7G/ung3cJyJy+5Ng0EpwA6sBD/sW1QBh66dwoAvwvl
	rXD0s+gNy2OCHIqKGF+N3MPKC7/O6wKXpRgDX9Jfu42Ck2HEKlLydaJsA2RQt2fy
	L0FryYcvbPh0SivHqo5Cj/haTEiRX7hPoGaG9n7reDKktg==
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11021117.outbound.protection.outlook.com [52.101.65.117])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4d4eyxr2dw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 13:59:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+VVN0/cKmCc+F+72R4Rtlra0D19Uq06jd7BZXYiMld1qPjQLlfo8Mc/mxAvJNS/diFZLIoiS+L4i895sbHeZMnYN5jLHZpyvd4j4O6Zi6oZHoW7qcMxWC6hJ+vjs9OnMd+7j2kBsJsoqGCTjIUUUU8axl/mMnp6u0t0BX9lI1DPgNuf9t7Dz2bjDHpi3zsPFnHoa3RXJLt7nK48uuXI8ZK2W1gQUOV5zi4A5im2HQ7I0E/dabo107JHItqVvWe7pHx7Ya4R92bXSXbeu6dD8S25w6Wl1wZ2skbOVdxYV0rWwsf6ysNw+iwCK3c8Bu5RLbMNV1Ts8a/t93VQ/MgS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF1EtBMKz9nu4YZscfRCFBhnkYfEvgUv8J2cvXwuRt8=;
 b=snifIIoYPDD7xnEjmCuK6mqWOqNvXd+1dsHaV5mTAhvdGRtqAzHPgIsPdurRoy/+v8Bacs9FTQ6wuVjf6F8qzv1GE6Bbmdoa/EhERT4R1r2E2RwysISoZqXYOVf5XzVyxt5AOXWdqGwsoxhqj1F9H7dAQAvOilCxoMjTrbGSJkQT0HF9iYfuW4cQJ5ZTiLmIn9LvjemZdv7nKMQsBHMazC4Et/IQ2MQBV+2c2xWp9h6yo9r385ZIH0LHSnqJiLkGUEixhDh433RfbyEZf+BCd+UHQ8h656wKqhq+sEKscvHZJRJ0PWkXNsv1EUnymyFEB2jxDa4PWIsJHPFUd9OPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF1EtBMKz9nu4YZscfRCFBhnkYfEvgUv8J2cvXwuRt8=;
 b=BbTPkC1Kwx2AOSwN7h9rNOdkqW32cqyId4wh70VOwfmhnTYJHGD/FNz9DEUfDFvRlYw5z3I5JdMLYUU6sNqooetUObZ53oeCGTuPtsWpnHZBESxMhBQIERxu0/GcMEWgMSA1mamu9pwKzr4vJ4kSAaD/rfKdJSrW0Ie83z1aFPM=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by GV2P192MB1989.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:59:39 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 12:59:39 +0000
Date: Wed, 25 Mar 2026 13:59:35 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath12k: desc_va endianness problem
Message-ID: <acPcN-Jr02rD_Veo@FUE-ALEWI-WINX>
References: <ab0Y9v6BkH4HDrFr@FUE-ALEWI-WINX>
 <d0db7062-f428-410d-a704-395d67bd4554@oss.qualcomm.com>
 <acEh4vckyl6bq29l@FUE-ALEWI-WINX>
 <1c20551c-2cc3-418d-ad18-3a0bcead8b73@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c20551c-2cc3-418d-ad18-3a0bcead8b73@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVX0EPF0005F6AF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::293) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|GV2P192MB1989:EE_
X-MS-Office365-Filtering-Correlation-Id: a0beb607-140a-4b70-6e61-08de8a6e5f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yh3PMPhSJ/Mn4bAEW6HzXKCoQsnboxyw/MyzBt+B5R+y5iOA6HVcV8foUSBuor0OgmPoe3U94wlG7iUrMtXBC0YCoW+Br38HjOqX7rzr4xDTSY+FDZd4/A7ALfz8pdDt7PVNHuW9lbSkiqaF/xz7Y+G7Olm+OAtsXl3mQNElhyoWYVLmMxYERSOKTR0zYF8+A+bgk8QhH3vB4xaBp0deCT9prXghXqOQL2KJpc3tFlBSSBqjYRJZzphsSWU1pmup0MhqzZFI0Xuwxf18iXpRJiUFIdVdw+1GYwN6pYxRS4fKhdHjkW7TS0z+ExUR8lArd7s/HELtBUP6XaasPmrAI6r5vRNu9spI3QS9qE1JSmOYshddhd2wEy5YJlZPYJTf706zinUKMk4j2YP+bR6rSB9xAMSSBr3z5BkcOAuYuI4kwfjSjytn5/STC4t/HyMTJHhFt88Z4uP0q6krm/DtiOQB+xMNDDgF64kGMnwc629hgmNyNTZ6QfGWjBnB3RXUZoCOp54ae1yCEOJnXSGLyvShUYs9xuLSz+w5h/YglO3qmnBbrm9ukoMhAIw6/catmkR3ar3nclss5leAI8HYFRIj3uPcRlGzKvdTZQVLXlEDv4xaiO8REZmWk6QICT8N/LdWB8QUgP7xZBpkMaSMhp5ICrCot9IMtL+qfqs2KZ9/WwEYtfs12DCvITULSeByybWT9xtFzZeLSYE74wiuZWJsceVZzDSekcalNQZJaB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?quJtdS95l3XaeQLT1/jy1wvKfeIGODLxHr5LRC8pr1/5loLkOMpje9NQos/I?=
 =?us-ascii?Q?D6TiN18S51oDr1AN+/kjJk+U/KUWeMfRqowJIGVJ++kMzko7EeeSxSf4ivXX?=
 =?us-ascii?Q?PHUHAFeXWMRBbO1q+zcwglQwrnogiRIMdz1IXpzPlQ62ejIDoA7+7B6htDPN?=
 =?us-ascii?Q?iE74B8LnlstMxO9WKyk2TV5ZKof/4csyjPD5/pWUPIfKZvG0RNmfwjeAgxyD?=
 =?us-ascii?Q?OmQK7xGOCsk67Kf97WLpJN4OhivVkIBhLVf25TmWpsyBzaS557A9p+OqiTCy?=
 =?us-ascii?Q?HF5jamHkfhTDyu/lWl3aGzQRT1gxdtp4YnuW1Gsdz9BeufhX7wJHY+q4shlx?=
 =?us-ascii?Q?S/kYHtB625jlFve0OC+D7qWnJLN0E9RcNtilqTjp2HajbAIFGZALsI3UEswF?=
 =?us-ascii?Q?tmyPJXv0EAX/ujNXm10pJ3I1mt8v42tP+ae1wlFGw2b9q9+PprdJ8uZ+VQp3?=
 =?us-ascii?Q?uAZWtgqpb+jPqQb6TnO4kqge86jn0ogI9tnllh7NwvhktunX8HMbj92wte2v?=
 =?us-ascii?Q?NB3Guxee4LoX80Awnt1kupOLBoE62TqfnVkqyAMsYQPRRxWIBnuUk+jUQIZq?=
 =?us-ascii?Q?Bn2yxpTGtpcioZO8L1iQzaWewHO+ZHLDEvVWPamp2f6JsH+cc+BVtoyDZMlL?=
 =?us-ascii?Q?W0McBUpEfn1pIAbrsd/bPYBIdS9Ih0UB34B9xehNxrQqyPCsJws+ZLOnbsy+?=
 =?us-ascii?Q?xkqNP0e/kyZU6Ja4MMCcKC+p+VoHt2B8BHHv+QyZKcqApKRWuKhNtW6/dO/b?=
 =?us-ascii?Q?ZE7NqEiZxJQqHsV3zD5sOYnGuBDoK28pWvbEaQQKobgT79LsXBxeotKWqgFE?=
 =?us-ascii?Q?oAAYAXDy4LQIO4eCNENYP1PGp/O4W9ZYe/lTlDmUEGqX+kIQQqdHnm49MqR5?=
 =?us-ascii?Q?UWhabDj9s2O3RdpYrI1CTi3NrJg+6i7y+EBoOKwV/0wrqfLeztW6Ylwo2g1/?=
 =?us-ascii?Q?1QNQg3qpLv+yfPtdJQ6bgIknEHnlYhSqyH6wDRIJr9WLSFhPHV+Mvm6/tl0G?=
 =?us-ascii?Q?1MkgwN8buTlIz/1tezrmMevc0fWhCzjIYeRNaaZ5pHBnk0gAe/i/nxRX2ljw?=
 =?us-ascii?Q?A3Pe7CPYwErbrWfsPpIF5JosrjIfjqz2CRKaqX2n2sBW1OOspQMqUQP4CAVa?=
 =?us-ascii?Q?U9IU6EjKyQ58EQEDx2n1VyqDebscQClJRIOWUx8GgiBNmxs7o9gofyOzcpcr?=
 =?us-ascii?Q?Y/JlCnMKwflFVPPodrh3GTEu9Wn5Gqvay1JfsPWEuKGEBQyJHMJiNVIpGF3S?=
 =?us-ascii?Q?xwdLO9AKMvXuyq95CmwaHCVyjidaWjpSB7aXLEWqpqzXy/yoOvd+kXFp7OWU?=
 =?us-ascii?Q?uMVHjYiYU63X0Nb8RjyGyABEsNl65V95XFtc6Dr5sQnbGicqTMMPO8aBQ1BA?=
 =?us-ascii?Q?PrVNovNekkmHpBNHP/gNziHxnF3f71kfjZu/3Dg7W3H3ILtPeDNXh+6lfVew?=
 =?us-ascii?Q?ZIdgXyo1uEmpBvZc+mNgCZsgeKFl5CDNjiqZ1hAF18H1hnCQLWrq0ZE2gZtF?=
 =?us-ascii?Q?Fl40zHjhIzu1T4Qd06JaqJLqTJugD/VxBqjcc+2B58Cr+HNZOXuypvEwYs3/?=
 =?us-ascii?Q?r3gqX/6Zz4BUElVcaeAw/DTzZT5udnF85UhGq6mo9fYvJ0Jzw5pEVGEoYYiP?=
 =?us-ascii?Q?LGpTnmGHOkiIidypm7AURbFP3a5V4arG/ewWid8xp3dMgS7BqkT72Lu4oWbI?=
 =?us-ascii?Q?+0y0tHVMTHg80JMuA71eu3xPwOcms5LXouIlFgnnuij8TQiwrsp1clnKj4mS?=
 =?us-ascii?Q?YulTEgbtVg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	EePpGatHY0mUZFTDkyrc3yu5ih8z8qG5i1knMqxDd76kNMSQ83GHGdzmPp3EmejhWfuUxa1E0hzm64ThHF3ouIJDo1oY/9v9LSoEekcz0940aVCaZn49LIrGnlviHubcWEuYEtDB99kkyRjJM/lZ/RWsYwFQ2+m9k42fafOtLUfpC/nJeLmsNKzJO9ORZoTeNelJFIRQjlEkUIRB3A2mf06w9LQLzMHwIdvhucu2C10TgIvaTjx/jbtlyVAylwEPHpqWPi66ux5WW9cdMJQuaspazHZdR7R1BnvI0s0ivuA/MjW2DYCo8stPjz5vsKYxR+p541p/x3B5zfRO9fXNEA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BV5f/rrq9i/iinX+GMdSbbLgGLTE48poKDA1vEb+r6AZ94ThvfQIdRs2eyhSZIaBpLXKhcrQ/R7/Sj+ZY5sKGvh59S7h/I2GAsGXm5fa8uv33SjtUbj/pw8/hN1GiduH2Y0SvNjIzf/sFdWz1+FIOTxRjg7Kat2kHg4R+X4kkv+mUd+BQFHxswmCTlWyBhZB4JqWHlZrJS2DaSZNPQZIoj9nRTuSoQ+0IvRfVwmJ0kMgZj1gPT+51BR47QYF2yC/KauKbBgIyxyv3I1lre89KIXQefZmMgwS96xEKFjk9rr4VY6D8zz8E1C8rG8F89TXWWSf3mExpZdVBHsb09rcKzuWGY/BcnHA4uvagPLJQQicLxP5GT6rMXazTR7P3QZkaM9sg9qTfe/eYjAJ+UKS7Iwh5GTopkhdmLe4bqAh1/aADwemGT3thLapBFdqoV9gLjYJkdev/eXiey9aYREeydBPDxFCHTawS/l8atTlZG3UAw773Tg40Wj9Z/VvYPZY+u5pCz2J/HqQY51MpwQB9pmpW3A+ggdt2PPI0AzaqlN31VvSwTJTlaUWvYJd9mMzcEUvqzdk1z/mWo1rhYN8z1yxSyP3YuDPN4M/4NkVO+/Rb545CCFGMkN22VcxIWEZ
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0beb607-140a-4b70-6e61-08de8a6e5f9f
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:59:39.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hj0y6LTHFHmk+qwI92ha3Q9fILOUjfFmQsrUAhUEdlAGWAgKGcskqFXpohOLDyP0ga8u9D8Xj+98xby/OjuV2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P192MB1989
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
X-OrganizationHeadersPreserved: GV2P192MB1989.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: nswW8exeRBa9Q_gTCvQfZdhAz7xS7ybJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5MiBTYWx0ZWRfX+dKP3xTqO+up
 DuxZ+2z8zmx7Op3/qrniNF98d0t8DGQ1dKBzckkPAS8nr8rfBmroX3IFg59LB+dOvCfQotMeDWc
 4SS0Eduwai8l+Bt20/iNZ5X6f75Ops1jLAkAWA8+MNEYMHBYDeuwmRQQk7CriZR97azHSKoClTC
 6v8v7rDgJ1UFq1ZEWuOuSb2Nqq6hasL6a2Xl4ZTUgP8YD4aEQyH8XANsTDHdh/67kPePKrG+NdN
 MoQ0E4tkRXDjVEeuhboX6ECI+AUx1HymLAdIxXiM1F0yvnypS70X/xKsxzeJ3vRyViBATxwBeqW
 yb4qyLFuXQP+I7V3LfwtW1Jy9Iwtc7dh4KgOuWbagYKMkIWV0IsQfJl+COtmrh+uEkLZZ3EpK0W
 QiMGKpwNgUc7zgWT+gmn6CqInTkQ2PrvmLq36K7Ct9pN0kRvPSV78ENbS7k+3+Ik2nYMXCswX/F
 5fsAJNFujGoGKvLyEOA==
X-Authority-Analysis: v=2.4 cv=bpFBxUai c=1 sm=1 tr=0 ts=69c3dc40 cx=c_pps
 a=HLRP1L5HxsJDO2m16KNwxQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=Wz_ZTsTj9wgVYb5gFMkA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: nswW8exeRBa9Q_gTCvQfZdhAz7xS7ybJ
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33842-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,westermo.com:dkim,beijerelectronicsab.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D15ED325C58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 10:46:10AM +0800, Baochen Qiang wrote:
> 
> 
> On 3/23/2026 7:20 PM, Alexander Wilhelm wrote:
> > On Mon, Mar 23, 2026 at 05:31:03PM +0800, Baochen Qiang wrote:
> >>
> >>
> >> On 3/20/2026 5:52 PM, Alexander Wilhelm wrote:
> >>> Hello ath12k developers,
> >>>
> >>> I have another fix for the big endian platform, but unfortunately the data types
> >>> do not match here, so I need your support. The problem is the following: the
> >>> structs `hal_reo_dest_ring`, `hal_wbm_completion_ring`, and
> >>> `hal_wbm_release_ring_cc_rx` all define the members `buf_va_lo` and `buf_va_hi`
> >>> as `__le32`. At first glance this seems correct, because the entire structure
> >>> contains only little endian fields. The local variable `desc_va` in each
> >>> function (see patch below) is of type `u64`, so it makes sense that I would need
> >>> to convert from little endian to CPU endian. Unfortunately, this leads to the
> >>> following crashes, in `tx_completion` and `rx_process_wbm`, respectivally:
> >>>
> >>>
> >>>     Kernel attempted to read user page (40dcdf) - exploit attempt? (uid: 0)
> >>>     BUG: Unable to handle kernel data access on read at 0x0040dcdf
> >>>     Faulting instruction address: 0xe209290c
> >>>     Oops: Kernel access of bad area, sig: 11 [#1]
> >>>     BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
> >>>     Modules linked in: ath12k(O) mac80211(O) cfg80211(O) compat(O) ...
> >>>     CPU: 1 PID: 10200 Comm: jshn Tainted: G           O       6.6.73 #0
> >>>     Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
> >>>     NIP:  e209290c LR: e2092854 CTR: c08d3190
> >>>     REGS: dffe3d40 TRAP: 0300   Tainted: G           O        (6.6.73)
> >>>     MSR:  00029002 <CE,EE,ME>  CR: 44004804  XER: 00000000
> >>>     DEAR: 0040dcdf ESR: 00000000 
> >>>     GPR00: e2092854 dffe3e30 c328a500 e2092854 0040dcce 00000008 00070000 cf900000 
> >>>     GPR08: 00000000 cf900004 40000000 c8e52c4c c08d3190 1002801c 0fcf5000 c0ab85f8 
> >>>     GPR16: d0d1f7a0 c12a9080 00000001 df7b7f80 00000003 cf900000 e1bc0000 e1ccb988 
> >>>     GPR24: ffffffff c8ed0000 e1cc0220 00000000 c8ec0000 c8ec0000 c8ec0f50 c8ec0000 
> >>>     NIP [e209290c] ath12k_dp_tx_completion_handler+0x22c/0x720 [ath12k]
> >>>     LR [e2092854] ath12k_dp_tx_completion_handler+0x174/0x720 [ath12k]
> >>>     Call Trace:
> >>>     [dffe3e30] [e2092854] ath12k_dp_tx_completion_handler+0x174/0x720 [ath12k] (unreliable)
> >>>     [dffe3e80] [e208fe18] ath12k_dp_service_srng+0x58/0x380 [ath12k]
> >>>     [dffe3ed0] [e20a1490] ath12k_pci_hif_resume+0x520/0x8a0 [ath12k]
> >>>     [dffe3f00] [c067404c] __napi_poll+0x4c/0x260
> >>>     [dffe3f30] [c06746f8] net_rx_action+0x188/0x340
> >>>     [dffe3fa0] [c003a3d8] handle_softirqs+0x128/0x280
> >>>     [dffe3ff0] [c00045b0] do_softirq_own_stack+0x30/0x50
> >>>     [d0f2fb70] [00000000] 0x0
> >>>     [d0f2fb90] [c003a7d0] irq_exit+0x70/0xa0
> >>>     [d0f2fba0] [c0000c84] ExternalInput+0x144/0x160
> >>>     --- interrupt: 500 at percpu_counter_add_batch+0x9c/0x150
> >>>     NIP:  c0425e8c LR: c01a5964 CTR: c01764e0
> >>>     REGS: d0f2fbb0 TRAP: 0500   Tainted: G           O        (6.6.73)
> >>>     MSR:  00029002 <CE,EE,ME>  CR: 48008802  XER: 20000000
> >>>
> >>>     GPR00: c01a5a00 d0f2fca0 c328a500 c1db7300 dffc0f20 00000000 fffffffc 00021002 
> >>>     GPR08: 1e763000 e1091054 00000007 c12b0530 88002808 1002801c 0fcf5000 c0ab85f8 
> >>>     GPR16: d0d1f7a0 dffc0f20 00000000 000003fe 00000000 f92412bd 00000003 c9525480 
> >>>     GPR24: d0f2fd74 c8a501f8 c12b0530 00029002 00000007 00000000 0000000b c1db7300 
> >>>     NIP [c0425e8c] percpu_counter_add_batch+0x9c/0x150
> >>>     LR [c01a5964] unmap_page_range+0x484/0x820
> >>>     --- interrupt: 500
> >>>     [d0f2fca0] [00000001] 0x1 (unreliable)
> >>>     [d0f2fcd0] [c01a5a00] unmap_page_range+0x520/0x820
> >>>     [d0f2fd60] [c01a5d9c] unmap_vmas+0x9c/0xe0
> >>>     [d0f2fda0] [c01afef4] exit_mmap+0xb4/0x2a0
> >>>     [d0f2fe40] [c0031610] mmput+0x40/0x140
> >>>     [d0f2fe60] [c0038df4] do_exit+0x2b4/0x990
> >>>     [d0f2feb0] [c00396c4] do_group_exit+0x34/0xa0
> >>>     [d0f2fed0] [c0039748] sys_exit_group+0x18/0x20
> >>>     [d0f2fee0] [c000dbac] system_call_exception+0xac/0x1f0
> >>>     [d0f2ff00] [c00110e8] ret_from_syscall+0x0/0x28
> >>>     --- interrupt: c00 at 0xfded438
> >>>     NIP:  0fded438 LR: 0ff23958 CTR: 0fd94930
> >>>     REGS: d0f2ff10 TRAP: 0c00   Tainted: G           O        (6.6.73)
> >>>     MSR:  0002f902 <CE,EE,PR,FP,ME>  CR: 28002402  XER: 20000000
> >>>
> >>>     GPR00: 000000ea bff93390 b0316520 00000000 113e8af0 113e8af0 00000000 00000000 
> >>>     GPR08: 00000000 00000000 00000000 ffffffff b02ccb04 1002801c 100a0000 bfbc4260 
> >>>     GPR16: 114974b0 00000000 114a4de0 00000000 b02cc900 00000001 00000000 00000001 
> >>>     GPR24: 0ff239a0 00000000 00000001 00000000 b030f52c fffff000 0ff23958 00000000 
> >>>     NIP [0fded438] 0xfded438
> >>>     LR [0ff23958] 0xff23958
> >>>     --- interrupt: c00
> >>>     Code: 512a421e 2e140000 512a463e 40f20008 555b9f3e 39350004 754a4000 7c804c2c 41c20224 7c87442c 2c040000 41c20230 <88a40011> 7fc3f378 83a40008 8a640010
> >>>     ---[ end trace 0000000000000000 ]---
> >>>
> >>>     Kernel panic - not syncing: Fatal exception
> >>>     ---[ end Kernel panic - not syncing: Fatal exception ]---
> >>>
> >>>
> >>>     user@root:~# Kernel attempted to read user page (c011de) - exploit attempt? (uid: 0)
> >>>     BUG: Unable to handle kernel data access on read at 0x00c011de
> >>>     Faulting instruction address: 0xe1e3dc44
> >>>     Oops: Kernel access of bad area, sig: 11 [#1]
> >>>     BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
> >>>     Modules linked in: ...
> >>>     CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O       6.6.73 #0
> >>>     Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
> >>>     NIP:  e1e3dc44 LR: e1e3dc30 CTR: c08d40e0
> >>>     REGS: dffe3ce0 TRAP: 0300   Tainted: G           O        (6.6.73)
> >>>     MSR:  00029002 <CE,EE,ME>  CR: 44004402  XER: 00000000
> >>>     DEAR: 00c011de ESR: 00000000 
> >>>     GPR00: e1e33154 dffe3dd0 c1870000 00000000 cebe0000 00000000 00000000 00c011ce 
> >>>     GPR08: 00000001 00000000 00020000 c30a294c c08d40e0 00000000 00000001 00000000 
> >>>     GPR16: e1ce2668 c9270000 c9269a18 c92664d0 e1ce26dc 00000000 babababa dffe3df4 
> >>>     GPR24: 00000040 00000000 c9266480 dffe3dec dffe3e04 c9260000 00c011ce c9269a18 
> >>>     NIP [e1e3dc44] ath12k_dp_rx_process_wbm_err+0x124/0x600 [ath12k]
> >>>     LR [e1e3dc30] ath12k_dp_rx_process_wbm_err+0x110/0x600 [ath12k]
> >>>     Call Trace:
> >>>     [dffe3dd0] [c0ab8e30] 0xc0ab8e30 (unreliable)
> >>>     [dffe3e80] [e1e33154] ath12k_dp_service_srng+0x314/0x380 [ath12k]
> >>>     [dffe3ed0] [e1e44540] ath12k_pci_hif_resume+0x520/0x8a0 [ath12k]
> >>>     [dffe3f00] [c0674c7c] __napi_poll+0x4c/0x260
> >>>     [dffe3f30] [c0675328] net_rx_action+0x188/0x340
> >>>     [dffe3fa0] [c003a3d8] handle_softirqs+0x128/0x280
> >>>     [dffe3ff0] [c00045b0] do_softirq_own_stack+0x30/0x50
> >>>     [c18c7e10] [c12b040c] 0xc12b040c
> >>>     [c18c7e30] [c003a7d0] irq_exit+0x70/0xa0
> >>>     [c18c7e40] [c0000c84] ExternalInput+0x144/0x160
> >>>     --- interrupt: 500 at arch_cpu_idle+0x24/0x50
> >>>     NIP:  c00071f4 LR: c00071f4 CTR: c000fe14
> >>>     REGS: c18c7e50 TRAP: 0500   Tainted: G           O        (6.6.73)
> >>>     MSR:  0002b002 <CE,EE,FP,ME>  CR: 84000402  XER: 00000000
> >>>
> >>>     GPR00: c08cc978 c18c7f40 c1870000 00000005 00000001 40000000 c328becc c12b0530 
> >>>     GPR08: c12b0530 c000fe14 0098ca91 00154674 24000402 00000000 00000001 00000000 
> >>>     GPR16: 00000000 00000000 c00119a0 dffee5f0 00000001 00000000 ffffffff c1050254 
> >>>     GPR24: c12c0000 c0011970 c0011940 c12d0000 00000004 c12b040c c12b0000 00000001 
> >>>     NIP [c00071f4] arch_cpu_idle+0x24/0x50
> >>>     LR [c00071f4] arch_cpu_idle+0x24/0x50
> >>>     --- interrupt: 500
> >>>     [c18c7f40] [c0a367e0] 0xc0a367e0 (unreliable)
> >>>     [c18c7f50] [c08cc978] default_idle_call+0x38/0x58
> >>>     [c18c7f60] [c007b3b0] do_idle+0xf0/0x130
> >>>     [c18c7f80] [c007b580] cpu_startup_entry+0x30/0x40
> >>>     [c18c7fa0] [c001325c] start_secondary+0x48c/0x930
> >>>     [c18c7ff0] [c0002870] __secondary_start+0x90/0xdc
> >>>     Code: 7fa3eb78 4bfcba59 7c641b79 41c20144 38a10044 7fa3eb78 4bfcdb85 7c651b79 40c2026c 83c10058 2c1e0000 41c202d0 <813e0010> 7c09b000 41c20010 7e84a378
> >>>     ---[ end trace 0000000000000000 ]---
> >>>
> >>>     Kernel panic - not syncing: Fatal exception
> >>>     ---[ end Kernel panic - not syncing: Fatal exception ]---
> >>>
> >>>
> >>> My fix, as shown in the patch below, is to remove the conversion. But then the
> >>> member variables `buf_va_lo` and `buf_va_hi` must be `u32`, which is obviously
> >>> wrong. Alternatively, `desc_va` must be `__le64`, but that is likely also
> >>> incorrect, because the address is simply dereferenced, and this clearly requires
> >>> CPU endianness. What I also do not fully understand is who actually fills these
> >>> addresses and at which stage this happens. I hope you can help clarify this so
> >>> that I can provide a correct patch for this issue afterward.
> >>>
> >>>
> >>
> >> hmm, i am not sure here, but can you please try
> >>
> >> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> >> index 1c82d927d27b..f142759a217b 100644
> >> --- a/drivers/net/wireless/ath/ath12k/dp.c
> >> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> >> @@ -1246,7 +1246,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
> >>
> >>                         /* Update descriptor VA in SPT */
> >>                         rx_desc_addr = ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
> >> -                       *rx_desc_addr = &rx_descs[j];
> >> +                       *rx_desc_addr = (struct ath12k_rx_desc_info
> >> *)cpu_to_le64(&rx_descs[j]);
> >>                 }
> >>         }
> >>
> >> @@ -1286,7 +1286,7 @@ static int ath12k_dp_cc_desc_init(struct ath12k_base *ab)
> >>                                 /* Update descriptor VA in SPT */
> >>                                 tx_desc_addr =
> >>                                         ath12k_dp_cc_get_desc_addr_ptr(dp, ppt_idx, j);
> >> -                               *tx_desc_addr = &tx_descs[j];
> >> +                               *tx_desc_addr = (struct ath12k_tx_desc_info
> >> *)cpu_to_le64(&tx_descs[j]);
> >>                         }
> >>                 }
> >>                 spin_unlock_bh(&dp->tx_desc_lock[pool_id]);
> >>
> > 
> > Hi Baochen,
> > 
> > It actually worked, although the solution isn't entirely clean. Sparse
> > consequently complains with:
> > 
> >     dp.c:1249:42: warning: cast from restricted __le64
> >     dp.c:1289:50: warning: cast from restricted __le64
> > 
> > To be honest, I also don't quite understand why the struct pointer has to be in
> > little endian at this point. The function `ath12k_dp_cc_get_desc_addr_ptr`
> > returns an offset from the `vaddr` inside the `spt_info` struct, stored as a
> > `u64`. But dereferencing it suddenly treats it as little endian. Shouldn't
> > `vaddr` itself perhaps be a `__le64`?
> 
> that piece of memory is for direct access by the target, so yes I think 'vaddr' should be
> defined as __le64.

Thanks again, Baochen. I've prepared a patch now, and it's working. I'll send it
shortly.


Best regards
Alexander Wilhelm

