Return-Path: <linux-wireless+bounces-31807-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHX5MUnOjmlYFAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31807-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 08:10:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC8133673
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 08:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3911B30420AD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7597B26E6F2;
	Fri, 13 Feb 2026 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="0K6pDJ+j";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="lB4lLuNL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FE283CB1;
	Fri, 13 Feb 2026 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770966598; cv=fail; b=PLlryHnjSx1+XurWHe5mkbE5FtItuoUldDCtaJ/AMweXoXLdy0aTnLMvvEo4FOOL03FktmWSvgDUnSlrH2VcbJBSCtVJGA2+ZyJkNMb/RqxWY/+gUaWTHpVjGkYGKEJ9cvNv7rQnE/iF+8xtxDiCwo2MvNmEXkNEB+smyD5TyYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770966598; c=relaxed/simple;
	bh=Pvis1lXZnDrAhCAK97yMlPuzWKMrb+D63RYcBVRNDL8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Avo5Na5zjEvQ9WwnFLT8zIPaalgZHezfInED12TCRoaN6fWL7IPtKr233F7Ilk/rsQedxuxF8k1RW8oIvIXt+NcJKXkHFgu1q32OIwyy0j+LwHWkQCj54cgRvNkkhuSjhP7nLTnq6auYuD2AjJvWg3jQdelrdM7xft1XsWR8WBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=0K6pDJ+j; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=lB4lLuNL; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D65kve1974814;
	Fri, 13 Feb 2026 08:05:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=Lm6fVtFEJApRPoBDDlujJG
	0XqzaJQ4n0zMzHZxLXH/I=; b=0K6pDJ+jxMziXAqLCoCoR/BRQShk5XZW4v9ST1
	ZxISFyv72xUihZ7fzL/It3+cLja1/sk2Tq52MpLgTnMWcgIe0jEYtA8juGIKdh6r
	c02PC3Zd5g3OsT/qKTrfRF7BxhfcquL1HqLe7cDZZfjuUIMKCB09tXGAfmdcHosn
	hOoFjX0LQpFmtWDixws7sBmdNBtCwDcZPC0pzgcRL17jWVEL31ioaW6zzJ1Sdi5T
	tNgV6tRtn1R851JsK1nCezzW+IQKL5wTOyBg+izWeYjRbofyrkEy5gJWTXP45r1i
	Iu6yMtwo7LeE7sUUXrCfJV6KipYLelpr4AREiVFX0NGGGbhw==
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11021134.outbound.protection.outlook.com [40.107.130.134])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4c6asvd98t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 08:05:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLHhNcMWqjuhQQOGocBAT5dd9NYKi5GdzaVIgjXRUXMtHWX1aPmgteKwXSJto3U/RMYwpK7ID5n7KKSQSOD7HBH/6UdwD72PLpni+LQ0LdXwl/2nE1wRIl9byu9j5OyWE8YmuAobbAP4AmiNoYGNYjA9VRHNhprtMi2+jL6xIA19t2Bj8by/PNsHw2lwfnSZnbZjcwtJ9GbX2mJBqJdfiRbf/bxF5t6B/7XogIzVFD59A3XjS5/NCcUdC27k7SdPcU+mkggzBLdywJ6Z8RuXbjOBmPWIGjE8lz5Ece6Jrp/ieUaqd2PUJjWpNuNTlTz1/L4lbkxQF4ZnRtXhXUUeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm6fVtFEJApRPoBDDlujJG0XqzaJQ4n0zMzHZxLXH/I=;
 b=UVkQRKpKl9o8kPtLECnH8xS7rqLltYlOERB/FgaL6AInzU02vB+3HUWYe6A8Nq5UMo6/egTuoCS6+QEsWk22q6vziMB0Vyn86vF5o5U2Xws6guO9E1kmkyPW6CjV4RycqmsqgqIWEwvSIbEH86e0pwmcGjPI2+Htb5xWZ41fyZxBFchCZZCbUtR0Q7uyYNRsyheZhdUwY6jc1NCGh6CUDNlldnJ1NBtcZdAJ+K8q36Vwd2jpEZXMz4WHKdMO8HTkCRhE83Qt1Skf7qGOHa3GqPU5S1J7hj3EdHoS0uqdlSTcH2tL1yE689V8utOCpCFBSF3ffCT3HFh3RlM0OUi/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm6fVtFEJApRPoBDDlujJG0XqzaJQ4n0zMzHZxLXH/I=;
 b=lB4lLuNLmhLsZyBDFTioHSwYlk0COpuDYU8Sv/0UUWpWiMZx3MeTzG1J60I3hC0/8grxLWcAp9axjZ/rB/YzqN1SGuHny2hFoZEw6w5U3HcxYioiwQDYGCbmiq6Bz6RFhzLLZOHykC8EuzyMXw4Va5oLOAukdOuZ7HowfjMU7Xk=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by DU7PPF9242261ED.EURP192.PROD.OUTLOOK.COM (2603:10a6:18:3::9e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 07:05:23 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8c02:9739:5f2d:b147%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 07:05:23 +0000
Date: Fri, 13 Feb 2026 08:05:16 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: wifi: mac80211: question about 20/40 coex support
Message-ID: <aY7NLLnOCXS8L31z@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GVX0EPF00011B4F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:9) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|DU7PPF9242261ED:EE_
X-MS-Office365-Filtering-Correlation-Id: bc66b260-9d9a-4ece-38ed-08de6ace41d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmYyTnl6MWVNdHRmR0pzaFo4T3AyK3F5Y0xsUktiSHhPYTNnM2k4QU0ybEg2?=
 =?utf-8?B?cC9SSzB0RjhMbE1MMzFnRUZXK3YxK1Y4MDZ6bUlFc1hyNUZLTnBuTWU1MTY1?=
 =?utf-8?B?MXdFb2J3N01TQUdWS0ZqNDdjQ1dMV3hpSW1uanpydXhRRzYvMXJHOWZVYjI5?=
 =?utf-8?B?Rm9nQ3NzSVJDVUU0MVU2WktxSi9abE96SjQrVWlpZ2Q4WE1VNlAxNFcwTnJt?=
 =?utf-8?B?WmZ6aFZWVXNZNHhGRjBocERzV3FER0pwUWYyQ2pIYmY2UTIwWlhnTkJHRk9x?=
 =?utf-8?B?Y2VaZDEwVTNaUk9Ubi8vWHBIMDkzWitVdWxMMHVYSVE2SXpQZThyUXJRU1FI?=
 =?utf-8?B?SjR1ZEJpczNNOHBUZytsLzdnTVNwczZyTlFPdGdodnZHZ1h1YnNNMFltbU5Q?=
 =?utf-8?B?RnJ3YU1xVzdjUW5jZXZOQzFZcmxMMTVtN3FZMjZFZDRvR2NZRjRsZ3c1SnBU?=
 =?utf-8?B?U25PaWZRbkYwTmt2TTdkMHFnNWdvWGFWMk15K2pvZ2RnUHZEYkNPVDA2b0Jo?=
 =?utf-8?B?WWdSajQyS1ZxMjYvUjRtdTZ0VXZJcVRtaGw1WHVsMUlaREZFUEJIT2hKc0Rs?=
 =?utf-8?B?dU9GbjZQSldBZTlSOHdjTkk2eC9wdFhBbWhnOS9EWmM0TS9JWGhIN2RySzZR?=
 =?utf-8?B?UXRKaGp0aWN4WjBxNDNzQUFROWlZTldBcU94TWFLSFphV0M3ZFUwSURjcGJE?=
 =?utf-8?B?QTV2TEptcFFubm9nRE9XTENJeWduZmtLTWRaVkZ3bGsxUllWUkZNakc2TFdk?=
 =?utf-8?B?YWFZc3gyNlNoVEtQSnNHME5FdGVZanZueEpOc1RLcmVrMk9vanhseGtYNjlx?=
 =?utf-8?B?RUQzQ3YzbitEd280eWJyellCdHp4MzdjM0V6RVZNZ0tIaHYrcUZwTzlRUWlP?=
 =?utf-8?B?VzY4NVo1NnphUGQ5dU9rNVIrZTFXYkhLUmZCanVqaklzamlCakw4R2VPb1lv?=
 =?utf-8?B?N0YwTFFzQ2xTZEFGR01sTG9VOEJVQUJlL00zSmNwTWRxVUwvN2Y0Wk54Ulha?=
 =?utf-8?B?dDFoKys1WjFjbU5paVVobEVyQ3g0Z3RSUk94UHNLVVFjQmk4ZUhMbS9Lb2Yx?=
 =?utf-8?B?c1RPOW81bDJWSEZvdG1Ha2hveDFiRkpKdEFTT0lNdHh0UHFIaVBoQTFXMWdC?=
 =?utf-8?B?bHlmaGZVb0FSQTVHbkl6Q3J4T2E3RUZHL3RjWE9wNjhBSEZDZ3BibWFSS245?=
 =?utf-8?B?WEFudmlDbUFrSDJTNVF5UWNqMlJ4TWJUeFJ4d3ZYOHZPYk44aHBGa3Q1cXlr?=
 =?utf-8?B?OENjNXpxaEZwN3JJNzE1RmJXdVlCemVMSUNkYkQ4NU56eGl6NmJ2ZDE5Qzdh?=
 =?utf-8?B?a1JuT0l2anlPNGpNRSthMGVyWW9qWU1UUGlLdjI4WVRhRWJTQkdxRjZlTUZ6?=
 =?utf-8?B?ZktsSHZQM1JsNytwVUg1cVdmN1VYSGl2MVBzK1gvUEo0VHplR082THFKb0F3?=
 =?utf-8?B?VUlCS2JXQndGZVk3c2NDTGpkVU5xb3VCMUo4ckNTQzBlNXFxa21Hc2dyT2Jh?=
 =?utf-8?B?dkRBMDFYMWtLU0RIN0ZjWVF6OHh3RHE3T2ovQVRRVjlIdHZLc0w5UUNNSDVm?=
 =?utf-8?B?bEl3RGNLVFIzdllvZGdLbGdRRWxkWTlBUG94RzFuR0ozNjV2WHdTamVTVzBB?=
 =?utf-8?B?Zzg5Z0RKUld6YmEyc2F1bDVDeEk3S3dIcElQSHZzRjEwcDFVOU0reWlMMmtW?=
 =?utf-8?B?V2ZlRlpLZFdHcUpteU1XVkFBQ080YnRXc1VrR1k4VzgyaHd3ZSsvcit0L25j?=
 =?utf-8?B?SUR6am1VK3RPRTdERnZ0MVJ5eXYzZjVWREt5cElxVkY5QkpsZVZnVnI3cTIy?=
 =?utf-8?B?dUVPQ0dUNFhXSGlLdkRQeEFzZmFFU1ZNTHprRk9pano1TS9GZEMrSjR1d29R?=
 =?utf-8?B?bm5LS0tCMkVvKzdvOHlTWnRvcGgzalk5NC9GSnFzcUJVTzl0YTQ4SVh3dTZw?=
 =?utf-8?B?cnNMdnZoZEVhS2svVk5IbVAwTDZxZTBnUXh2aHBINmJLS0o2RlFpU0VnVmJi?=
 =?utf-8?B?ekdqSDF0Wk9iYmx2MG9rUVNqUnA1YWg5M3pkUFZzSWF0VHRVcmppVmE2TVpl?=
 =?utf-8?B?ZHVuV3VRVmhXV3FaaHVmejVjTDRDajEyZWNlOGhNQ0t1YW5wcmtyaG5kVTh2?=
 =?utf-8?Q?m2RA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmR0VFhsVGFtMWFXei9Cb3VlSkc0bnh5eS8yME10R2hGNmlieExhekhzbzRD?=
 =?utf-8?B?ZTZqUGFGYjd5ZmUyZ1MzN3lOM2ZEcVlWZWhvay8rT2NOQ2c4RHE5bmdKdjZy?=
 =?utf-8?B?TWE5SmkvREVWc3UyQW1CNFNpN2Y2SURQV2NpZ0R6YSs4R3lyVkhrSnFRcjNh?=
 =?utf-8?B?K1V3YThXNHlmZ1AxTDhIN2JGOWFnd2hEVVZYekJieHovN3E3QlB1bXlhVlNX?=
 =?utf-8?B?a2lKUnRhVHFMejIwWDUySUtlQ2FVV05hZ25BK2tsdDhnZmFieVY5M0ptekVz?=
 =?utf-8?B?UmplcFBKWCtDbEpveGU5RWlYN21kVy9nVXpMNWZzd2hWbkF3T3BkUURZMS9S?=
 =?utf-8?B?MkN0Y081WVBaeWJQc1U2OVlMN3FYMWdha1ZzY1U1c05PenoxWEJ6amtvT1lI?=
 =?utf-8?B?TjJTKzlzb1piemRLMFd3RUJSbmlOWlFmcXZFd3NOQnZ5R2lOWFE5WVFiMkpZ?=
 =?utf-8?B?c1dmNmtUTThQN3k4cXd5QzBmaVNXR200QkRWeE5BWHI0dnlkN2FzemI2NUQr?=
 =?utf-8?B?dk1mWm5YaW1FK1YwTVZLTU9VQ3ZlR1NBaGtOdkNuS0NwbHIxS20rbWpmQVQx?=
 =?utf-8?B?UHlkdzIvUjBxRjRTQjR2aXRGaHU1ODdoQ2lyS2FYSkR5TTRJR1ZBWWphang4?=
 =?utf-8?B?T2htaldyOGtNTjJnYm81cDFXdGRqaE5Jd203SUpSRU51VGNrZE9qaFdJL0sz?=
 =?utf-8?B?amFqUEZqOEMyYmVEejZ4R1EySk9hdjUxVnJzc1h1NzhIQXFNRnN5aWIzbm9O?=
 =?utf-8?B?eFVyOFhhMU9Zalh1RlZpMnBEWGtnOFZTUktCWVdUTEN6MDVwUDhtVDhqRXVw?=
 =?utf-8?B?U3VjTjc1dVg0SXJPQjhQdUl4ekVzYzZaVFN4VkhrVW52QXB6RnpoVy9jdVhP?=
 =?utf-8?B?R1dwNHRlZENydjQrQnFTZzlIWmZvaVRnUnB3eE1na0p5NlFZUzY4SG1QeWNI?=
 =?utf-8?B?cXlvb3YxQTVIRDhKRFd3bS80czZyTTJ0bUc5MkxmVytTWWJFRGxvb1RQVy9G?=
 =?utf-8?B?dmFTLzRIWUphNWpzWlUzUlJwUUtudzZ3cTdCUHg4TmVnQzdjQllSTWt1aDE3?=
 =?utf-8?B?NlZVaENlWVE5bVBHLzhEOHZUZnZiRnZ1NE9YWjVLY2VsN3hoTVpxZGRGeVF3?=
 =?utf-8?B?R3B5N3VJU1QzeGVPaEdYdUphRlpxTVZVR28wN1ZVT0ZJY3ZUdlBncGhQMlE1?=
 =?utf-8?B?L2JkWVhja0pnTnRBT25kNEptZmc4NVgxbE96c1hBY0ZPOGhnSmxTMy9sRENY?=
 =?utf-8?B?ZUYxWXJjcjRHeGRTdFU0TkxQbkNmdDdncEVCQlB5dDdMTGVmMmZ1b2QxVUxu?=
 =?utf-8?B?OE1XRm9DVXI3NUwxLzhyeWgzN0VYK1NONEJUMVFoNm1TNkU2Q21Wa2syN20y?=
 =?utf-8?B?dGl4RG5NblFCTjFGSE5oNHRsYlhhK1JTYUtxNmtFZDZkVHY4czRCWE5lWWxH?=
 =?utf-8?B?alFTT29QcEVmblk0WS9vaHNTVE54VEhRWXhvdmN1Nmw2NWVJVnpab2JCQ3Fp?=
 =?utf-8?B?M2swMHNudUphZHp5bXozbktTb3pZVVhrRkp2dFBtcEw1N3lZVkFQU2hCQ2ZY?=
 =?utf-8?B?enlCNTc1a1BYNVR4S0Z3M2VqaVBOUFVxTjhIcFoxTGJnZVRBL3VSMThPN2dl?=
 =?utf-8?B?Y0xHNlkrS2RCUGlycHdJdGQxWGtTRDBxY1g4ZnNBb1RRUy9PQWY5ejJEcDNQ?=
 =?utf-8?B?ZExqTzBQWU5McXFjTFgwb2VRdERLS0U5SlNZeUIyV2QvajBISjRwTW11OUhq?=
 =?utf-8?B?VFlMY3JLNnYxRDhoajh2SnNqMlNZaHl5YlRXdVBxV2VVSmQ5MkE2Nk1IMjl2?=
 =?utf-8?B?d0d0NnBvZW5iNHVjR3pDeGM2Yk8vZTQ5K1VFRVd1MzJ5cWdJS2gwUk42Q1NS?=
 =?utf-8?B?Rk5WYjVrRDFmTG44RG5nL0tnbXNyVFZxdUxpelFKMEZ0aCtyY21sa0RVbjE0?=
 =?utf-8?B?S0ltdnY4cGxsQUhseU8rdjRwSEVyUjR6ZExWVWtGaFltQWY1UDdlQWJJUEI3?=
 =?utf-8?B?RTJkSk9vQlhyTG5LMHIwUjhzcUlGSExab1dicmhvNUFrZlZYbE0wRDBjenJl?=
 =?utf-8?B?VndobmU0aCtuTXZKVFllR2lIUmJaUzFRU3FETG83YTJwUGxlZGdrQW9ZaTVV?=
 =?utf-8?B?b1NSVFZmR3BOWDhsa1l6N3hOMlk1NVNhaFVxOWFzTDlmbjM5NVEyT1dUbWxq?=
 =?utf-8?B?dmtyUU1odm42MG5pWmpNQTEvNk9rQzdSaEF3Nm5KUU1sNU5XOHltQUpIUE84?=
 =?utf-8?B?R2xvVVZaSUNrQ0hYTHlXR2RDWTRIVU9pdnFSNFRIQ3NNNTM1aGR1d1RZeWJX?=
 =?utf-8?B?enpOWGtYUDNFNDZNRithZHE5NlY4N2hoUzVjbW9WaXh5bE84dEg2Zz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GIgvNtYg7BcrIjtank7rEwZmuj2XY0OM3f5tIxyUSz5kROwAjJJrcYl2ew9R6LHhQu/r16vDinjO95iZ/uHrTjhCXyGRbQ1rjGT7/DSnJO1jnqy5iBifI6wnobC2D6sMDuIWSWo0qinxcjfnuPuHToFsXnxhrOwRymKdSWTYoYcJSmwQ3zOM4Ik5uxuWxPO4LY4A7BfdVGpwAwenD0u9r9ijYSibJ0wZNV+2d77iGmiTuL3cVRNG2jZ/a7ylrJRcDZNmI/gCmU3b2CaU3P7rqI7KSJFQGqdG2k7w9nf7NFjViezcIxiQGD1HOIupfeeYSNCKN0pFpsDEwgwr7vTA9YVkgYVsSvZ43xNoTevB5x8my+vXSD81jzHRHdcXO4GGrEbwTJDC8tbGfqdVRNdy+Z/h3q+dPL1LAvQHY/pBtmmEWgAduMk0UXplamxk0Gv5iOWXtplE273ckAX0xrYS1RG5Is8bKudqCxKDYmZlcnqHKcpQTi0K35gupgpHnhPJgzFLQxfrdxx3Cu2kW+Dmk4eD9OJp9LkSk1X/Q5X7KwBXtx1iLnAOBek0tFLn5NeFlzzfjhNZWkFlPls4ovRbMb1oNvOdU2nJaRaX4s1/4CIRRuoZhJ3js+xSSQ3xG6Qp
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc66b260-9d9a-4ece-38ed-08de6ace41d3
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:05:23.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvKieQOErWSWAEiWU9GWgdvaVMAjqrJki4lAjwNPOgpbvkW5JdNwpOAlCMWQfri2hq+nXblhExxcTEnvBIhwyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF9242261ED
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
X-OrganizationHeadersPreserved: DU7PPF9242261ED.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: w81ghZupTo3XmYapYOaHlP5v2wgrBvOe
X-Proofpoint-ORIG-GUID: w81ghZupTo3XmYapYOaHlP5v2wgrBvOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA1MyBTYWx0ZWRfX9C6bnn5pM+6s
 Jqswyrwq1c96OnavYLiigZFXxdd8MY26RlP11WykfIFehr3r+qmtcH31VhHE/vDafw8XKLM37AZ
 wUBZVu8U+pINEMzDMrAROnNbaEn+Bc6PhnNm9FA0f1EKRnlNtYT/0KwqFoyhTGl7u74/yPZHePn
 STfqGnZtXp22Xi5DzcbcVVbn61AJgj/71g6gP9V/jXS3qbj3lTTgkDhOWNWa83/5jFgF7QXMb8q
 kUtwD+qcWKy0QlU/G+RHnefzG/NEL43lFis6+BI/Dk359UVbhzFvJ6o9l9QmRZw/FcCXwfBbpCw
 HT71FOovJQ0TEtialEog1SQX3mcOfnFnXcCuxV3Id5YnWjWvdfYZgvFNJuHLQx3shNQ/HS4OVYf
 BF/Nt/SiId4xtkT5Sx3wCricmnOeDG9PyfHlxXBik63+4PGWSEQS9yWz/eVsTuqfl2n8iH5NX6u
 nwqvrcaUpsO/frO2tLg==
X-Authority-Analysis: v=2.4 cv=J+inLQnS c=1 sm=1 tr=0 ts=698ecd35 cx=c_pps
 a=oadGwveH4K/rHZ7pqere9g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=RxTbA9-1CU_5KBPb2R8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[westermo.com:dkim,beijerelectronicsab.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-31807-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13EC8133673
X-Rspamd-Action: no action


Hello wireless devs,

I am analyzing a wireless management frame taken from the beacon of an
access point, and in this frame the `20/40 Coexistence Management Support`
bit is set to 0, indicating that the feature is not supported. See frame
below:

    Frame 2: 217 bytes on wire (1736 bits), 217 bytes captured (1736 bits)
    Radiotap Header v0, Length 26
    802.11 radio information
    IEEE 802.11 Beacon frame, Flags: ........
    IEEE 802.11 Wireless Management
        Fixed parameters (12 bytes)
        Tagged parameters (155 bytes)
            Tag: SSID parameter set: "SSID"
            Tag: Supported Rates 6(B), 9, 12(B), 18, 24(B), 36, 48, 54, [Mbit/sec]
            Tag: DS Parameter set: Current Channel: 6
            Tag: Traffic Indication Map (TIM): DTIM 0 of 2 bitmap
            Tag: Country Information: Country Code DE, Environment All
            Tag: ERP Information
            Tag: QBSS Load Element 802.11e CCA Version
            Tag: Supported Operating Classes
            Tag: HT Capabilities (802.11n D1.10)
            Tag: HT Information (802.11n D1.10)
            Tag: Extended Capabilities (10 octets)
                Tag Number: Extended Capabilities (127)
                Tag length: 10
                Extended Capabilities: 0x04 (octet 1)
                    .... ...0 = 20/40 BSS Coexistence Management Support: Not supported
                    .... ..0. = General Link (GLK): 0x0
                    .... .1.. = Extended Channel Switching: Supported
                    .... 0... = GLK-GCR: 0x0
                    ...0 .... = PSMP Capability: Not supported
                    ..0. .... = Reserved: 0x0
                    .0.. .... = S-PSMP Support: Not supported
                    0... .... = Event: Not supported
                Extended Capabilities: 0x00 (octet 2)
                Extended Capabilities: 0x00 (octet 3)
                Extended Capabilities: 0x02 (octet 4)
                Extended Capabilities: 0x00 (octet 5)
                Extended Capabilities: 0x00 (octet 6)
                Extended Capabilities: 0x01 (octet 7)
                Extended Capabilities: 0x0040 (octets 8 & 9)
                Extended Capabilities: 0x40 (octet 10)
            Tag: Vendor Specific: Microsoft Corp.: WMM/WME: Parameter Element

I reviewed several driver implementations, and none of them seem to
advertise this capability. I also could not find any definition for this
bit in `include/linux/ieee80211.h`, unlike many other capability bits that
are defined (e.g. `WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING` or
`WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT`). From what I can see, none of the
`mac80211`‑based drivers appear to support this feature, is that correct?

Additionally, I want to confirm whether my understanding of the feature is
accurate: the 20/40 Coexistence mechanism implements the “good neighbor”
policy, meaning that an AP using a 40 MHz channel in the 2.4 GHz band must
fall back to 20 MHz when it detects an overlapping BSS (OBSS). Is that
right?

Any clarification would be greatly appreciated.


Best regards
Alexander Wilhelm

