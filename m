Return-Path: <linux-wireless+bounces-19664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A641DA4B274
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 16:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1D916DDBA
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F41E7C2E;
	Sun,  2 Mar 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="hyDR83W1";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="AOkzV8uL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A72AD0C;
	Sun,  2 Mar 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740927601; cv=fail; b=ntP/L0at2NRDBY0a/wgNKKTc8x2NrSxkyZ6lRttrIn4/f9I26HGMJ/glGrPZhQ0kOExgd+NVo0GClo9fLwWepbsUCVDVwaIuQkVM8sRAn3reTfjBb1ALqd38A8Mrcc/s8cZMZfQjXu0438ZqGr61d66Otw8ATLTLri69GMxCoIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740927601; c=relaxed/simple;
	bh=wbfzaANHWrZwHehU6zHqx+P4Q8s6SqoS7Ckujnd6xIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJG/sZIPQIzncAJrBRGgLhCsKDzAB8TCIU0zg61ioXpPA2mefPKFISCoboGKbsN16y1h11wr1xyuM6ayawD0j2wHvdLlS93gopOvgD6FAfoWQOjgoWjcNtMAj0s8Y4ys2X53scnhp8y/F1DXOkiz+tGcXdf2Reo4CNKvykXhBWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=hyDR83W1; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=AOkzV8uL; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522EItXZ010648;
	Sun, 2 Mar 2025 08:48:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=wbfzaANHWrZwHehU6zHqx+P4Q8s6SqoS7Ckujnd6xIk=; b=hyDR83W11vvJ
	up7rOh1WFW2Hxlj3uh6PVna2/nK2St1A3T6GfY+Ui6si6wGwwl5fkjx3Fmik8Pib
	tX9MFrnknmK6YhEov1OXJ8a7oBaPJNLYX1DIwumIEH65sFKRfB5ZfwnucKJ3zqEV
	ixCQJ/VYBgowSAeINrb1vrZLKzRvB+NqtxJ+PLRaMuXZKRiiGTfDTednqZr4Im/Y
	po6JcUCnC88iKXBUcT2WWUlWNEqebmuWUXAHPOvg9p4zuk7Eh7FIKfiZ3CPv7AP3
	Cuy8G1SFYHOYwInLnfhM1gNBMBtEOhhA8kwbPZcFEeQXgSSWSP3gdSDNUAqtH0ni
	2zuB8eX+NA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 453yegh96p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 08:48:15 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxvXb4Azs7Afw9ymZZ4NlEdpUkA9RFUeVi9yQDnUm54foyahcXWVbYbb68BPEOzluMNa1ySCYcSnx6FkHkqHutbYMdfkWlYn4MKxMjIQ9TGkIKiFiv5sI/+XKjy4FK5dKMX9C7tcqEl/eD4K/a2K3ZGt2VXObCOvy8X7kK82Jbrcx3qvDMWwTZUXlkhuxS7gM3U1INP3vK0i18ln4l36T4PSJ8jqsTLGef1l2k0RwRTZoqWmToShd3NnD3heeiF8UvMKLlyQDV+QSGok8rWdRmilnYVu6xW72q5w5O3UfNW0T/LJcgKjf+p3fmHBG5vqY2MxjseCAWZxSEDnaqfTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbfzaANHWrZwHehU6zHqx+P4Q8s6SqoS7Ckujnd6xIk=;
 b=ISeu8L+71NwNFwLyeN2t9imnztOBVl14qzX0sGPkf3Pcke+/DsB4LbbhhODK/veqya+tobUTLm7OgCfe0ebe904ZYt+3P7H2pIAhzpkVMCIEE/qzQVA8ukYaeAwLa+w2mCkivR4yaJQjmZ2fWY62Z+wgMI+N0dy83bCLTthALkhSBWo69zKDuPIWzR8IoLrH9g9p19ogwQ/4TsJecTKOsmCigWTtTAMliJ7fO8kcagriYND5ZCmK7REcPvwR3XjfSAtKQlcUPJxYNq4ErnJ3C67OpvLok5zX7I2wtYn+KRkkXdsD5MEDOJWSdHfv6nKpJsLlYSBlYLrGhrNkWNJzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbfzaANHWrZwHehU6zHqx+P4Q8s6SqoS7Ckujnd6xIk=;
 b=AOkzV8uLpdUi0kUVD6+2MqVMQAn9GSJV7H4EITjdnFOPtvMmkFVz3/jgKpANEVxS1i6ZTm0bfzAI2d+2NBUg1yCAegB1xqDIY+TNhixqVXN9EerMCwHOwhnDPVe8pmTHKExchhoMwPIe75zihO7ap2si9bcTvLigId6PE8fnOMI=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DM4PR11MB5312.namprd11.prod.outlook.com (2603:10b6:5:393::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Sun, 2 Mar
 2025 14:48:12 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:48:12 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v2 4/5] wifi: wfx: allow SDIO device to wake up the host
Date: Sun,  2 Mar 2025 15:47:30 +0100
Message-Id: <20250302144731.117409-5-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250302144731.117409-1-jerome.pouiller@silabs.com>
References: <20250302144731.117409-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PA7P264CA0241.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::7) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DM4PR11MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: 445870bc-35bd-436d-ece1-08dd599941ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TERDVGJuSStVSms4SUYwTlBXSU9QQXAzUHNkYzhiUU9sczJuOUdlUktzV2ZG?=
 =?utf-8?B?TE9HWVVCZEJDeHl2VVpWd0syejdXL2hYWUYyRVZ1Y1RzdWdHOG5SM1UySldD?=
 =?utf-8?B?OFdVOTRMS1BxcHdaY1ZTb3ptZkdUVTV0SWlTUFI0cFZrWEFKbFVISHFmUWti?=
 =?utf-8?B?V05oeFg3SVN2TGFsNW1pNUJ6TElFZlZRTEtXYW9UeW9jMGVKYTdCRnJ3WERD?=
 =?utf-8?B?N2hpSG9WemdTZTNiZnZYbG5vaEhtMXdkV295NjQvWi9ZQnR1V0RxdnZvVk1a?=
 =?utf-8?B?TG9lWG14V3dxV2JadFQwOWpYT29FYTdxbW4zL2FrZ0FiYy8vZXZZZ0RCdnJO?=
 =?utf-8?B?eENPbzlLaXRseHFtaHFXNndnemdtcG5QZDNaQVVaUm5QbS9vajcvZ1llZm9y?=
 =?utf-8?B?UDdCME5seldVdGU4ZGt4WUp4S21RUUhVZHZLbGFyYWRRT0x5M25LTU5QZmJy?=
 =?utf-8?B?NE5wN0srNlo3N3dteWd5eGZZTTRQZklmMEhmdzVidnMrQXA0QnNmd1R6UW4x?=
 =?utf-8?B?R0JZenRjM3BhbDV0MWNQTWxzTHNvRXAwRTMxRjRGSU52K2E4dDBEMGM2QmF4?=
 =?utf-8?B?UWxrOFMrMVpHZGw3MGpnTnd4bUUyTWdHOVBLcEthK3FucDYwYjdRc3B1WjlJ?=
 =?utf-8?B?dktvVm0xWVNKVnY5Nlg1ZXdBMlBZYWdYUzFvU1VoY0dsWEJDam4wY1JncjIx?=
 =?utf-8?B?S3BiRDA5SmQ2ZU1CRy9rbHc0L2s2czRhNHpUZm1QYWJWSm5oRkt3QlZMVVlU?=
 =?utf-8?B?U1l0WmhYNHpmcXVvZjhMcGQ1OS9yTmJHRkNTc3dqa3d2c1B6MFFzNVhIQUNp?=
 =?utf-8?B?MDJRcVFFS2xFZERqQzNnZE1aeDlobzNXaTFPQkZUMXd1KzdjRG9HUllZS3Vl?=
 =?utf-8?B?UnRpTTZSNjBaMmQyWUZpR29Md1k4VHRXa3JxdndOS1NjcVRVZXpGaFBqRzEv?=
 =?utf-8?B?UkVLTGRMZmtEdnVGenFRdTFjQ1VSZy91bnQ1ZldONWttcnJYNVZ2WEdmMXlY?=
 =?utf-8?B?RFFzVzBQcjFiZ1ZtckQzTGtGa1orRHpFMUFvSlU0OGtkOHJleHdpZHN2Q1pV?=
 =?utf-8?B?c0FPMUZQL09IcE9pMzJLVVZvck1yYVM3NDYwd2svNDlOdDF5U0VNMHRyOUp6?=
 =?utf-8?B?Sm1HTUE2V294WG1NRTJrSkhoVDlBMWQ4ZUN1MWFqZzlFdC9aTFVMVm1iOXZB?=
 =?utf-8?B?ekNEWWxZS3g2WnhmMVV1MmhtSkg3MUhFell6dzdJT1I5WFREakFnUGpSemdy?=
 =?utf-8?B?Q3Q1WXprSFhHOVptQWRyK28yenN4SXBHenlHakNxL0JFRTFkZjg0SXl1SlRj?=
 =?utf-8?B?VUUvbmFDNGd6ZTdhcnR4blVkcVc2YzF6UGkvWVBZbEhzRVZZbnltNGRwQXlK?=
 =?utf-8?B?UjlZdnZyOGtpVkZoN214RDdEMHUvZEJNb1krTG5xVS8wa0FMMEV4RVNVMGNn?=
 =?utf-8?B?cFBrVzYwN1hobVNrUm8zSjAva2ozeExVaVpia05sZHJ5NyswcjFvTXd2aFc1?=
 =?utf-8?B?a3c5cWpqTFpzODN2ZDdnZEJQNWp6UFlXbFhpRDBCRW11SVdLOEtZd3hoTEw5?=
 =?utf-8?B?U3QySDFjQ2Q0TVBSQkhxbDN6anVaNUI3eFgzMUxGcS9VYVFlcFB2VWovREI4?=
 =?utf-8?B?TnRXZEtBV2lycGYxM2E1ajE0cFFVS3RLUjk4bDVDOVRiNE16L3VVRHpMUmpX?=
 =?utf-8?B?OVVVcmlBK1lUMHozeDNpZkZGSFYzZ0JiQkY1TUs2cDMvZkFPL2VROWtNV1VB?=
 =?utf-8?B?ZW1aZEVnNk5wNnNVc1ZBb0I0eVJSalVlN00xanJrTWkvelJRbnRtT1pZclcv?=
 =?utf-8?B?OUttTlpqd05HN3pDRjNmZmFGVzhJYko1QWw1elQweHBWVlMrSXR4M1JXS1Av?=
 =?utf-8?Q?GXOy8wQwCrii0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnl1QnZNWDQrNTJjamMwbHkxM1NJK3N1WCtrRklScHUyK2hIRjlMaU9SNG1h?=
 =?utf-8?B?emhHK05keWQ0QmV1eHM2UDhNMVBQWFBOQVpEekk0TnN0UWlqTFJKU2FuTzcr?=
 =?utf-8?B?NDZVZUpVZjZwVkJwYWdpSE16elhOd010Skl4K2lXMXQxbWJJZENDcjY4V2s1?=
 =?utf-8?B?enU2VHFkMGFQcWVjVFo0N0pEaDZpVk1CTWkzM2NRU240b3BEMEluTFdOb3dU?=
 =?utf-8?B?LzNla0FwaUV4WUZYYWVZSUZwZ09KNFJvOFhLRGpud0I3QURaYzdRbzh3ano5?=
 =?utf-8?B?Sk1iSlBZTUJZVGJQRzIyemxSallpdlcxOE1lS1RaZ0ZETGZ4SWVSaGhQU004?=
 =?utf-8?B?T3hHNGVQZnpoQ29qR0RJcStTSnpzWFQwWkxzbXpJTDFYL2psUW5VUEJ2QW1V?=
 =?utf-8?B?ZGt6b2YzbFZEV2pwNVh5OGNMRlZvdzR3YmthUDNyaWF2VDRCZzV3TUlUdlNU?=
 =?utf-8?B?cDdiZlBxeElra2FFb0c4ZkVGU0dLUGpubWNmWDQ1TE13M0RxMEJjRE1nQ2ZZ?=
 =?utf-8?B?d1ZISUVvVU1rOThBSGlQS282bmFOVU5WSXFIdkdrYkV5Rit0LytEVVlCd0pH?=
 =?utf-8?B?cFVMaUFkT0lMUkZsVUQvWS91Z2gvNHoxSTF0MHM0WW9ZMmQxMmtxTmdqaW5H?=
 =?utf-8?B?Q3c0blpFRWo2Ky9jb3JBWVIwMk9VTENXZFYrbDdEM1ZGaXAvNDRuZ1V6YXQy?=
 =?utf-8?B?NXZ5STdVWE80cHdIZkEzbjByZVQwR0xTZldWYnVaOWNxSGpndW0ySDlJY0JB?=
 =?utf-8?B?ZWx0SW9uOUdUZFFmeU9HUXFTUkJPbUxCL2xqcWJEYmx0QzVCLzVkblNDakxY?=
 =?utf-8?B?NWwxc0N0V2VFd3VPZ3ZXakRUWTVMTXlTZ01nZDY2VFJsVDRGdU1vSUNLeVJ5?=
 =?utf-8?B?Mk51RW5WeW5oVWw5QUs2VE9iT0FuY3lackxhZVkzbVlCZHVCaFJzRUFvcFh2?=
 =?utf-8?B?VERlVXU3SWVoaTVDbVdsd3BLYTQzWXhGbDVET09aUzhJeXNoQlFSMFk5d0N4?=
 =?utf-8?B?TXprS053WlUrVi9Wa05VQStDRHh2ZnFjWU9qbmJQOGxxQnc5YitLdXY1OFlD?=
 =?utf-8?B?NlNtVVJTWDliUlV3MGQ3VFhueVgyL01KWEtQM0J5dzExNUtBZzkvUFZOaGly?=
 =?utf-8?B?RGtKcFU1dTJtVjBQRmtGTVo5K2t0ZHdsMVJnTVNBQXN6OWwvamRYTFZFR1ZG?=
 =?utf-8?B?WkVWUHZaZXBnbC9hZCt2QTJYWm5BTXlRRUFDb2htdk10UW94UURydGc3eFE1?=
 =?utf-8?B?c3ptRXJZaEZ1VjRFNXg2Kzdjc3NLeThWdStTazhnVllJSU1qUGQwaC9PMGFl?=
 =?utf-8?B?cmtFaGlLSEV4bnRrdk13UkhlUnpFS1VWMFhFSVM4ZmgzbHVJYnpnL2JNNDRC?=
 =?utf-8?B?N3RHOXQycEd4Nmp0cUtoZTRQN2tMcC9HNlhYRjdLQkxZZlZGV2Zra2lvaWZY?=
 =?utf-8?B?RHlVWElmRURZV2dXbmtSd2ZOclNVdHN5cmpiaVAwOW9lV0k2L0ZEZTJRdEg5?=
 =?utf-8?B?b2NTcnljcjgxR0NyYjVmcTVJaTF1YmRleDk4ay9oUmYyM2pMNnpjalZUZ05Z?=
 =?utf-8?B?TUJEeDhUOHBSMzR2T3plUWRDR29uRTBXQ2VaVVRON0lRU0E1MnJBQzltc3V5?=
 =?utf-8?B?dHZwcVZ6UXhxOHZKOWFTQ0RNQkFXNEtZSlRzOUdzL2FNSnN5VUlSb1ZBQWJo?=
 =?utf-8?B?dmUrL2paOHhxTlR3RlZQbnRGTHNKendPbkFSb1hmaFpab1o4MVo3Ty9qckpy?=
 =?utf-8?B?TjNnbGJlT0tuVTQxeXFPSS9nczFHZVNtT1c5dDVBdFEwUXBlUG1iR0ZqYlZI?=
 =?utf-8?B?UGtsaHFsTnZnREpDTVhmbzlqQnFFTFJMdU8xcUxaN08yYWRKOG9GdFRkRDM4?=
 =?utf-8?B?WWxJWTU2aVNFNGFtekVzYmJ5bDJhOGVSOHRKTklZYXB0Z2F6R1NXdzFjeU5h?=
 =?utf-8?B?NC82UEJNT3RqOWQveGJMUHBRcXVPcmRpcnhtTmxLSzFsdGFPWUZYeG1nNVhZ?=
 =?utf-8?B?QmEvVDdwWkdlVnBrOTVkckwyMGcvSHl2Q3lEM1NzaVBOUndvN0ZuajBzSVdr?=
 =?utf-8?B?SG4zcVVXaDRPaXdyUkRrdFp2MnFvajF5ajBLNksyVmI3eUtNNnhkQUVUOEVZ?=
 =?utf-8?B?bG9yL3dzN0RxQ3ZLU25YRnlHbE5aRGdIUUpNcDRxd2wvUEVZZVVuUTBCZ1pC?=
 =?utf-8?Q?M2a44dpSHTrkHDDO1TLKkEYBVMeDpEMRt1cEXQeRvN4m?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445870bc-35bd-436d-ece1-08dd599941ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:48:12.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jg/gUdZWIHGGyxxprk2kkvRzTeUFSWb/YGp7VMBgcW+aFLZCtx4InURKwI4LunLve7/h5exvveOMAsN0M3UXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5312
X-Proofpoint-GUID: Op8StPeGsMzHboS0rHpoOLFIyki8nVsr
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=67c46faf cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=_bZ_Ugej2YiJM_EvIRMA:9 a=QEXdDO2ut3YA:10 a=CJgG61vzA6yyTBTLYZUp:22 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: Op8StPeGsMzHboS0rHpoOLFIyki8nVsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_04,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=824 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503020120

SWYgdGhlIGRldmljZSBpcyBjb25uZWN0ZWQgd2l0aCBTRElPIGJ1cywgaXQgY2FuIHdha2UgdXAg
dGhlIGhvc3QgdXNpbmcKZWl0aGVyIHRoZSBTRElPIGNvbnRyb2xsZXIgKHRoYXQgcmVxdWlyZXMg
TU1DX1BNX1dBS0VfU0RJT19JUlEKY2FwYWJpbGl0eSkgb3IgdGhlIG91dC1vZi1ib3VuZCBJUlEu
IFRoaXMgcGF0Y2ggYWxsb3dzIGJvdGguCgpPYnZpb3VzbHksIHRoZSBTRElPIGNvbnRyb2xsZXIg
bXVzdCBiZSBhYmxlIHRvIGtlZXAgdGhlIFNESU8gZGV2aWNlCnBvd2VyZWQgb24uCgpTaWduZWQt
b2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0t
LQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9idXNfc2Rpby5jIHwgNDQgKysrKysr
KysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zZGlvLmMKaW5kZXggZjI5MGVlY2RlNzcz
Li5iZDhlMWZmYjYxYmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
ZngvYnVzX3NkaW8uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19z
ZGlvLmMKQEAgLTE0LDYgKzE0LDcgQEAKICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4KICNpbmNs
dWRlIDxsaW51eC9pcnEuaD4KICNpbmNsdWRlIDxsaW51eC9hbGlnbi5oPgorI2luY2x1ZGUgPGxp
bnV4L3BtLmg+CiAKICNpbmNsdWRlICJidXMuaCIKICNpbmNsdWRlICJ3ZnguaCIKQEAgLTE5MSw5
ICsxOTIsNDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgd2Z4X3NkaW9fb2Zf
bWF0Y2hbXSA9IHsKIH07CiBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCB3Znhfc2Rpb19vZl9tYXRj
aCk7CiAKK3N0YXRpYyBpbnQgd2Z4X3NkaW9fc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCit7
CisJc3RydWN0IHNkaW9fZnVuYyAqZnVuYyA9IGRldl90b19zZGlvX2Z1bmMoZGV2KTsKKwlzdHJ1
Y3Qgd2Z4X3NkaW9fcHJpdiAqYnVzID0gc2Rpb19nZXRfZHJ2ZGF0YShmdW5jKTsKKwlpbnQgcmV0
OworCisJaWYgKCFkZXZpY2VfbWF5X3dha2V1cChkZXYpKQorCQlyZXR1cm4gMDsKKworCWZsdXNo
X3dvcmsoJmJ1cy0+Y29yZS0+aGlmLmJoKTsKKwkvLyBFaXRoZXIgIndha2V1cC1zb3VyY2UiIGF0
dHJpYnV0ZSBvciBvdXQtb2YtYmFuZCBJUlEgaXMgcmVxdWlyZWQgZm9yIFdvV0xBTgorCWlmIChi
dXMtPm9mX2lycSkgeworCQlyZXQgPSBlbmFibGVfaXJxX3dha2UoYnVzLT5vZl9pcnEpOworCQlp
ZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwl9IGVsc2UgeworCQlyZXQgPSBzZGlvX3NldF9ob3N0
X3BtX2ZsYWdzKGZ1bmMsIE1NQ19QTV9XQUtFX1NESU9fSVJRKTsKKwkJaWYgKHJldCkKKwkJCXJl
dHVybiByZXQ7CisJfQorCXJldHVybiBzZGlvX3NldF9ob3N0X3BtX2ZsYWdzKGZ1bmMsIE1NQ19Q
TV9LRUVQX1BPV0VSKTsKK30KKworc3RhdGljIGludCB3Znhfc2Rpb19yZXN1bWUoc3RydWN0IGRl
dmljZSAqZGV2KQoreworCXN0cnVjdCBzZGlvX2Z1bmMgKmZ1bmMgPSBkZXZfdG9fc2Rpb19mdW5j
KGRldik7CisJc3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1cyA9IHNkaW9fZ2V0X2RydmRhdGEoZnVu
Yyk7CisKKwlpZiAoIWRldmljZV9tYXlfd2FrZXVwKGRldikpCisJCXJldHVybiAwOworCWlmIChi
dXMtPm9mX2lycSkKKwkJcmV0dXJuIGRpc2FibGVfaXJxX3dha2UoYnVzLT5vZl9pcnEpOworCWVs
c2UKKwkJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgd2Z4X3NkaW9fcHJvYmUoc3RydWN0IHNk
aW9fZnVuYyAqZnVuYywgY29uc3Qgc3RydWN0IHNkaW9fZGV2aWNlX2lkICppZCkKIHsKIAljb25z
dCBzdHJ1Y3Qgd2Z4X3BsYXRmb3JtX2RhdGEgKnBkYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9k
YXRhKCZmdW5jLT5kZXYpOworCW1tY19wbV9mbGFnX3QgcG1fZmxhZyA9IHNkaW9fZ2V0X2hvc3Rf
cG1fY2FwcyhmdW5jKTsKIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZnVuYy0+ZGV2Lm9mX25v
ZGU7CiAJc3RydWN0IHdmeF9zZGlvX3ByaXYgKmJ1czsKIAlpbnQgcmV0OwpAQCAtMjM1LDYgKzI3
Myw5IEBAIHN0YXRpYyBpbnQgd2Z4X3NkaW9fcHJvYmUoc3RydWN0IHNkaW9fZnVuYyAqZnVuYywg
Y29uc3Qgc3RydWN0IHNkaW9fZGV2aWNlX2lkICppCiAJaWYgKHJldCkKIAkJZ290byBzZGlvX3Jl
bGVhc2U7CiAKKwlpZiAocG1fZmxhZyAmIE1NQ19QTV9LRUVQX1BPV0VSKQorCQlkZXZpY2Vfc2V0
X3dha2V1cF9jYXBhYmxlKCZmdW5jLT5kZXYsIHRydWUpOworCiAJcmV0dXJuIDA7CiAKIHNkaW9f
cmVsZWFzZToKQEAgLTI2MSw2ICszMDIsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaW9fZGV2
aWNlX2lkIHdmeF9zZGlvX2lkc1tdID0gewogfTsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUoc2Rpbywg
d2Z4X3NkaW9faWRzKTsKIAorREVGSU5FX1NJTVBMRV9ERVZfUE1fT1BTKHdmeF9zZGlvX3BtX29w
cywgd2Z4X3NkaW9fc3VzcGVuZCwgd2Z4X3NkaW9fcmVzdW1lKTsKKwogc3RydWN0IHNkaW9fZHJp
dmVyIHdmeF9zZGlvX2RyaXZlciA9IHsKIAkubmFtZSA9ICJ3Zngtc2RpbyIsCiAJLmlkX3RhYmxl
ID0gd2Z4X3NkaW9faWRzLApAQCAtMjY4LDUgKzMxMSw2IEBAIHN0cnVjdCBzZGlvX2RyaXZlciB3
Znhfc2Rpb19kcml2ZXIgPSB7CiAJLnJlbW92ZSA9IHdmeF9zZGlvX3JlbW92ZSwKIAkuZHJ2ID0g
ewogCQkub2ZfbWF0Y2hfdGFibGUgPSB3Znhfc2Rpb19vZl9tYXRjaCwKKwkJLnBtID0gJndmeF9z
ZGlvX3BtX29wcywKIAl9CiB9OwotLSAKMi4zOS41Cgo=

