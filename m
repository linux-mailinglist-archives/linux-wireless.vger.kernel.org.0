Return-Path: <linux-wireless+bounces-25523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780EFB06FFE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE92A169497
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 08:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22528DF3F;
	Wed, 16 Jul 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="X7nVKKET";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="cjHTTzNY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BD28C03C;
	Wed, 16 Jul 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653657; cv=fail; b=bH0BvqwMPimjYeXTBIkwORn+NejfZWr+2XuA+SF4WupyxnAL3zH7ejmFjEVFmwVP1sp2eKJj2IIY4f54DJ8J8U6ftBAV/ovU8LSxqWDX+uwLu7dI0rfvQK2Q9Uen5V8hRti8j/9DvQb+fdCOHzEj4lDYTSo+yryQ/xzfr5pBwpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653657; c=relaxed/simple;
	bh=NjdnMv3x7Be/GW/cNDenPiiVJpoIb9OjJTGHffpj8i4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ev6T7H7OEWnVkLsUOJLDrWEdGeXMCJR9jpymDOo5iGtGza94/CM/S6SePF3K7A0a5bMp3Zm8ZK4tv16p5RBSvdfHxDmzrx3D2wap+A2OoQXTv9WTKBWXh+qmQgiSGkJkMC6lAg+/48vTMA0JW2C0tanVcK+jUUKme9r+iR160/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=X7nVKKET; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=cjHTTzNY; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G6XnWB2292231;
	Wed, 16 Jul 2025 09:51:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	jPgsJcPjoBmeg9h+5QgKNYAvpeBKSEE/DANZLGzOBAU=; b=X7nVKKETb0TAvo1x
	x3raFpll1urAIadIsWdTkDenLDrtbUmtk3G34YIR6xA37TGeoI5yeFyVFYfnsHjt
	SJtH4pTyUACWpRBgHkNKFhDlW01jFb0VC06yy7z1mTYTJmAC+swsBteRC+DlO6Xi
	xyWX5787a4uHqqfWDXMeBr9cdamK7b37jAMY10U1BZMwBEorpkCuE3YbUoi4vy8S
	6onWBK++yfJuqK2ZBNBWRcl9ypHw/sifg6wiX6ziICDjN0Umhs+YfV6zCT9e4gZg
	HcoCDYhw739pOhTtkyveV2rtJ5VWaV05D/fO3uxh7Jb8TPyAWu9yrlpvPsJv95xB
	lRMvsg==
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02on2102.outbound.protection.outlook.com [40.107.249.102])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47ut22b7n8-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:51:13 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXhSMFJsyNvZ9jV6nSkswq7j0hOXsueD3zjn/rs93UrStysnWwjM+WYb/wzCpKXa/F5piLuIxC6Qqu/1UQBNYmawGKlnJgJJOF6m2pw1iceAbHSBU3YZ6ojF+d/cEq4pt0J9k+6yERUEVTApmJ5jzxGPqE1xiJS2ND1kw/Hbt11Pcr7L3WGbxEQvhJFlOamH9ajHkbbQHy8Uy+JLBG8tozNmuY9bImeDzIFcpeIHITQe+bV7ddb1vs+RGPEN/6pKGaPjaKz6GxD9Fa1ibwO/K2iU//x+nHUxwCxYBfCAR5MwlLHaeSd/4hY+oyXOI6JsFn532Pua8ZeW/OH8LC0Ilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPgsJcPjoBmeg9h+5QgKNYAvpeBKSEE/DANZLGzOBAU=;
 b=HHJBew8U0sRuA83AErHpZ0TfWAQkvLNV2HMcaBM40O9NIzN50HEnMCrrzkdNJUDcGANgJo0w3IN1ntO+omEjcUMy+wbODOkFeY8Sf0MziHioXYuGRTrNtKKOzrbcuDQMRMP7GvulEV1+WfKEEAEfa7ea+V46fWI0620TL9VWgLaTbKym22k05rlN6q3VD+bHzOnWvcPNwxMgbeC/hkfBkZN9qH4NtGIJQRYeZd8VHZFiE5ZHnodE4DkydUbvPmrvN2CNeo2tvOdbl2vliSp7yy9PUcdcnWylNgp3GF8Yz+gKENO6KU9O1z+LnyUuUP97//hrhaMSZk+HAE4iQGLgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPgsJcPjoBmeg9h+5QgKNYAvpeBKSEE/DANZLGzOBAU=;
 b=cjHTTzNYnl/0hNmx5WqOQTRFzc2/SVOMBwu0zKm+0ongSl0qEyWV2ORWde5g/qrbJt3c4ETd7lp+ONrBTqqdt174HwgfbRU5HWCWlIlfug00Xi11Wbgfusjc6yySCXe3PfPPeHa4r7ZiVZYR9pon/SWZhh4lCAu6Va6k5XtbtH0=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by GVXP192MB1853.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:11 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:11 +0000
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 02/11] wifi: ath12k: fix endianness handling in QMI phy capability response
Date: Wed, 16 Jul 2025 09:50:51 +0200
Message-Id: <20250716075100.1447352-3-alexander.wilhelm@westermo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0028.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::41)
 To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|GVXP192MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: 57980b0a-c212-4156-859e-08ddc43d882e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BZf6KZjlmqeZUNO5XdyB/bcsU1qd384iHPPH/Irs/akpKDDDL+p+stYkRqAX?=
 =?us-ascii?Q?NMfvN3lOHGmjBTCH7DU1CKd7tmToPR20FwIdeTbY9m5tUsOkkFxFF5tVxcvE?=
 =?us-ascii?Q?Gg+NSF5hLWom3lYqeLU71wEddAammBxRH8wSUX3rlq2+JOqLzjgON1IGTC+j?=
 =?us-ascii?Q?xfVaWBseY4GbtjtVamqosdu97A9vNKUlJPywzyQui5c17HgNlYVNScVWtCjE?=
 =?us-ascii?Q?RoDO1RUQOV1Bd7pMSsdXCMkj6i/Qo1HdmDXF8ueWRzcCrxRQZWNdgFGRWSMT?=
 =?us-ascii?Q?Y6SghFTDf0VLLd+ZiGTGPrbFmmLmExzSHiiuIU0PA4ba5uXO06+ncJnoBk/b?=
 =?us-ascii?Q?PgvyEWvW99JbG2gnqL/2L38bNr3NWr0X/Nqfgug1LyCyS5FcpaPvEe4AgKhK?=
 =?us-ascii?Q?cuDIIjV5fgvck9spxQ2mbhgZJtnDpXucaUKoAxWDuHvZOiy6d1Yh/pTULFUR?=
 =?us-ascii?Q?yoVpSduZvIXRyFZAdPVfUaZF5PHBv9vedbK8oNd8ZH1x7pkJBEKVEgvg8xTm?=
 =?us-ascii?Q?10Ji6JnSgSiQ/2oI9AFYs0G/y+y7T989I9h9+To/WG4rMRAVxKuLRIByFGTx?=
 =?us-ascii?Q?PvERQW0vHew4iKlo+le2RSttW+64tyjs6ymDxY33UGcJFiGwCc8ycWGWLPjq?=
 =?us-ascii?Q?kdgUOlk9iN85vy3Gux9hG3ZJlmtu7qeshnDKWeLsiAJCDKPwBUV73u6oX+zn?=
 =?us-ascii?Q?fxBJ5P/pMBOgU4kMmIE99nvWcNDjmSMsZGuLEePyu0tU3SS8rheuVPTQUIf3?=
 =?us-ascii?Q?2gUSKOLO/VKT8YlcJ0zK2fzlDvW/mOS46XtWKsZS1byVjOjUYGuOJkj0hfEc?=
 =?us-ascii?Q?JICby4TzM0qG6Dka/q9n6f6eKUmfZ3ltPfubqu8b0S+Rhz3bx7s8U0q/d8lE?=
 =?us-ascii?Q?wYfeYB6P+IHcwWwxabYrCKS5rcCSsumfZRI2sOkPuxOZOzhjqUW7BqfdQhEH?=
 =?us-ascii?Q?fc00BsUJJ3uTxkhd6Cji0dZFPaMmWTZ628JuxQ41hJl3Y1PObXwBa3x92Aus?=
 =?us-ascii?Q?jRrSHc4MQ4p0mA97YNojzA+gnFGjLs85wMNeDO/FFpDKjNkQW4xRe7n3Ie/M?=
 =?us-ascii?Q?6sxz/0foTa2xjbB1g4Z0mDyppclg6t+R8C+ZI77vsuJbS20s+VAdtD7KcOpJ?=
 =?us-ascii?Q?NU24zhY/4tMCkXYo9e9wkDnbinstewb2+6KKkIrTXuTznx3yRehtzmi8sqiK?=
 =?us-ascii?Q?zOwFDm8OyNkdpmWk3PMjt74rgyVekzTcdbWcEqUDYVitsSVrBr6lFtn8vadv?=
 =?us-ascii?Q?Cf7N727WtoG6dUGErLsVcoEzGxPvmSZM4ty4yw+TOnqMYPbWXMnc482ADYpj?=
 =?us-ascii?Q?ulY3hfeZyr9Z5kRECOiOMlW9oIFbBjmC6wYzei7XC9tmxPeXX5tNg0FQWXhp?=
 =?us-ascii?Q?xcRXW4IJBZ1Dk26LaPcnmNzTYHEwg0HakEdAOChdp1AO0cdri/vzViJWOaGJ?=
 =?us-ascii?Q?Qfy8ruUY7qU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SGFJmB2NKSJcvrkJOFckfiziwztnvd/XW2bfy3ehMRh5CAQRToH+MoDx/OL0?=
 =?us-ascii?Q?u10pQzbRLsUgpVSSgVHPcLICur3+ctxTXy2NOvW4S+1J9CeR4iK66HxxseBX?=
 =?us-ascii?Q?7IKTXOicPIYmIuUAdurYKXtktgY1IOnsnF9eKCvWdS5mE8eGvCcvGGnNGW28?=
 =?us-ascii?Q?37NnsgU77EpmX0sVxauq7NQlMXtj6kZBwDnpw3HeOI7aiAE5QOj3X20zKWGI?=
 =?us-ascii?Q?4ZCCkoEhH+8uS1OpTyOv+HNdwHuKNDnxHo9ERFmPRpYdmjK9L1qn5Qkdg+aU?=
 =?us-ascii?Q?pqXSSJo7WYwFws8C+UWoQ12s+SRPH1eRgpyUuOaiIuIl7X+xfut0nWmoLJIC?=
 =?us-ascii?Q?eF4gF0d+cjiNCF1Yrqfpww9wADXoXqaZltuniFBb9PT09PWCW4Au/qkwxDSb?=
 =?us-ascii?Q?1ts760CzmgfkmcBHmQF35R+CBWnlA8HpkiretLHzCpwFRm9l8aJ+Z+J/ETI0?=
 =?us-ascii?Q?YD/kmX6i9342FYYw7d2fqoM88MmPla9XcjvX7JSrJTtVYQ7vdHmqvhJ1aRks?=
 =?us-ascii?Q?7Fh0eDLiP2X25C2X9Q0yKfzJKTqK/1iAhahQJm+/N8KaXFpDYs1mRCXKcKpM?=
 =?us-ascii?Q?2bojVHoMvAGOSW4x41we9T7LixlbN1425wq21dnDP7ySYgF4NRShIn0QjJy6?=
 =?us-ascii?Q?HnA9a60ItjHikuH7R93XCmoxmvx5LrTbFdWY+BH8dEjVjVV/R4yCObK2ncfn?=
 =?us-ascii?Q?t2diheQ8aGta9iTtB6DqYIdpgbK2HJ+277fzXAD5t/p6u/65JGdDD/lJu/NM?=
 =?us-ascii?Q?106a/XUY/oJ224NSYuMqL8ZaD7+kvw78Ts/WWa30oNQq2wc1zfBDCiLs/2lc?=
 =?us-ascii?Q?Nc0BElX7oqfqzIYPFld03SWGIWtuCm/h54o9rD/N+ezrE7WXbLqMaF4TIkp9?=
 =?us-ascii?Q?7GJdAPoMsIyzEitynlJkVzWUOfn19zcUWm/H+7E1mYkQnpZBE5/pV68NLqO0?=
 =?us-ascii?Q?uF3BYpLuw2Yw/qUSySDLip2d0KGkuafL4aD1P8ztYdlTZO120LuQs0CYvDVL?=
 =?us-ascii?Q?hL3TgrAWRHPd41wAPKmShCQnp5ENz6FtMFjl/hEBNyBaVGW/nczEDZUVo2Q1?=
 =?us-ascii?Q?XlqYHKN4h919D2kCY/F+NBrtZZ4C6sAP7NPFvqI6ieYNq1MVKgnyi18uAuZJ?=
 =?us-ascii?Q?OwQL3RcLGBsmtWAklSRBVnMQGgvN9AAvy09lUCPrP1dY7zuxHP+S0W8fO5q8?=
 =?us-ascii?Q?UyxQgCSyYjYc+sarBkMRkMdNHfXO9PZmSdTwcgo86DyQ6J1E4SPTRejdi9Yd?=
 =?us-ascii?Q?VL58cvSQ24jT/cDr9lL/JTu+n64LgkXVaOqLY2w3RzJsXvunQhuHXOdqWpvS?=
 =?us-ascii?Q?txR2H0hWLTb9H8dhIfM2O+8wqz6dK9nI9kZbH0l2YF+edNf6Y35Hr/wX4CTy?=
 =?us-ascii?Q?nnpwv4JUGM8Y/HASPkI3pvL8qNCAgOqbHPWkjOIWMpgomGHYJsSyjxSOrnyE?=
 =?us-ascii?Q?F3SUJVVAepv5bMlwq6ttY5h7T4KvWIds1kZMn/xt7jIft190E6dXeRVnbYfh?=
 =?us-ascii?Q?/M4AyXum9KKge/ruDXkmgEf3o4Sg8rWIny+9nXEsobLsZ/n5DuVnJx7Upmsz?=
 =?us-ascii?Q?TmoWJrzrMcVc5BFRYYPsHYmEKmNS3gjS3p4x7/Kx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m5S2OC6j5W7Nia+GW8h9JiNJoSDTSib6phiZgkbU0NXknTPKu91pRnG+8qK+bzJLy7NTyWpjVMVmp0WunX2u4YFw+AI8/8XFD327uGmeyEe5JaTLr5J1okGif+3NaIi5kq985UoiCgUUXokZBJp8cVwKXPK2AEqrzZg/rKPLgTb1StEfnPZcfyimYP0sGjC4Lao28R2sLh/DSVomRQ9CYMMM/5IQ6mUXPrPxxGQvrYiXzO3G7ZD6z7BP9Jti95C+vqfKtjrHq7LVJV823tCGxdMSUhPh9WFNX/kmuHDgwHdS7EU32yxen9JDyQyVAv5FUG1tFH4uytY9bbHrNiAghO261ZKwW62gZZes+92nw2r23OzzQsyrbtYW+384nne7tvh5nLybiBVh6WciClCEM/RsddwScLM9fHFdE7YuczXQMcfN7YD13mFBjbdg+41KA4cBIphAvkwiN8N2UbIwwq/vzAYBykbY7IfviYF2WHdQ/njb2b3MMELPmbPv/pn6z86oWzm1oNmOydY6wdFROjN/OKGE4uJbg0+HLXh0Zkc3BixYi8nUI8lA9hQhN97QDiG17Ihh04inl+kvSYblrLH2FZS5OaYPNw0j7cPw28dFq5CknFPPH7C/SGKIXhr5
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57980b0a-c212-4156-859e-08ddc43d882e
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:11.4013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McMpTTTIQiJf8wnTWd26NPlYulOBYC9v4R+FRve8hlNpTYgtIMl+keBTvAFIDOfySROwAGjEFqeqd4Zc+fS4GQ==
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDExNiBTYWx0ZWRfX6+Aqx7hWiZ0a
 RqeBpQ0ozSjEka4+/1uaVDhfYRI2eUfuJVV6Dq8XdDDApk148sy68oIF0OT/KDwP4iy5d336YOv
 3XwGKiTWe9iZLiYeKqePGx4NOOQ0Qtd9uoKDWNufuC38o8cpVNBYypIqOABmE9OAc2NzL4hf4DY
 xKF2YBv75utzrj1LD3Y+j0uL+05Z2iLWqzrkxbMuod0li47YmDAxmsgo4IyplXlWSh2UEPwg1vn
 Hyda4ED5T6GG1bLxlYaQY6SgaUNdLUIyEmnBw9mk3W6LxzWWusdABE43Nmafb5/5tSZ9Unx+WCV
 4cNa0C/tH4B05YjR6FdzltvP+68mxYhpcvh9ZR7wiUJyXzsR6GCWhZbIO8JjDzSzv8lbxupaRQd
 xmMDUlln
X-Proofpoint-GUID: fSLzdFzuqKU86HfX25IWrnMR-Xjr3dS_
X-Proofpoint-ORIG-GUID: fSLzdFzuqKU86HfX25IWrnMR-Xjr3dS_
X-Authority-Analysis: v=2.4 cv=NOrV+16g c=1 sm=1 tr=0 ts=687759f1 cx=c_pps
 a=lAFVUdC4KqDR+XbUfoMjaA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=8gLI3H-aZtYA:10 a=N9GNhs4bAAAA:8 a=F4jRbKuxnH_zUiGVJR0A:9
 a=PZhj9NlD-CKO8hVp7yCs:22

Ensure proper endianness support for big-endian platforms by correcting
data types in the QMI phy capability response message. Add missing byte
swaps wherever this structure is accessed or modified.

Fixes: 53a65445c144 ("wifi: ath12k: add QMI PHY capability learn support")
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 2 +-
 drivers/net/wireless/ath/ath12k/qmi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 2287ed87dae8..2973edd2735b 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2283,7 +2283,7 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 		   "phy capability resp valid %d single_chip_mlo_support %d valid %d num_phy %d valid %d board_id %d\n",
 		   resp.single_chip_mlo_support_valid, resp.single_chip_mlo_support,
 		   resp.num_phy_valid, resp.num_phy,
-		   resp.board_id_valid, resp.board_id);
+		   resp.board_id_valid, le32_to_cpu(resp.board_id));
 
 	return;
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index ed7808fe2b71..abe2fba25d13 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -273,7 +273,7 @@ struct qmi_wlanfw_phy_cap_resp_msg_v01 {
 	u8 num_phy_valid;
 	u8 num_phy;
 	u8 board_id_valid;
-	u32 board_id;
+	__le32 board_id;
 	u8 single_chip_mlo_support_valid;
 	u8 single_chip_mlo_support;
 };
-- 
2.34.1


