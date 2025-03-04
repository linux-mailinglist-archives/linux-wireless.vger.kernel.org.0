Return-Path: <linux-wireless+bounces-19763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE44A4E481
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 16:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1D9423FFB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544B209686;
	Tue,  4 Mar 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="uwXM0uRD";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="OV95qkhz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE720967C;
	Tue,  4 Mar 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102364; cv=fail; b=SaEzVLh6TAzftS15fcJmr1QZ3CqzBoJUuDkqp3psmzpwVOSXKwYJLrwkNlQU8oaCD0ohSmJxAv6BltSwRs/L2b5B654xGRko3pinVA8k3BLz7A01AHaiSPAM2gKODsD8/nrXE9h95IcjUKGupJxQMeDiAqFbMKfmI31a6aoCi10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102364; c=relaxed/simple;
	bh=S7M/W+ncJkSbYOHjaJxkCQE45aXj1mIoinary8/mKd4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eU0zCWOTqEgNJMHwSQvMM0jSMg7ODg6htnkv3OuRtguRb2XWA/ABK2fwKED+27DvzCpScuce9mQM/oXH6XcTtbbNDT9AL+nmqGDrXstYpa9utrc9E1AF9Y3MtRydPceKEMl8XbZmKUT7zpmbL4G16O84l96H32SfBX/8cP19XlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=uwXM0uRD; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=OV95qkhz; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524BCUs0031949;
	Tue, 4 Mar 2025 09:32:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps12202023; bh=S7M/W+ncJkSbYOHjaJxk
	CQE45aXj1mIoinary8/mKd4=; b=uwXM0uRDJfWxojrKGSXR+1A6Nxs0RLnbJ8K+
	BSkiZ42aFj1po+a07VusRrQOjOahzkQq2SHAiY9oObdCe4jRRJm1OEga8UxN/NVj
	es5pkgZ92d65WM+W0duxFwC/bcNNpqVZp4a7S4627EZ4myOz2nqDP6cOXVSQLkik
	FH3ixZDDl1mjrK4cy7dQotKsea0nCTmD4Ux+gxqyPgGpvDR0BAXx4sAYB+puccUA
	e76s34reOXeeJA/llDfr+8jOYgyJZSLDFrJ60hudb6pCAGZKLk95vrgJApeqZEy/
	CgTvjy41S0Ob1N69vFClPLy0ZEacb3TdPedpgBTCosj/Rt8/6g==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 455qchhcum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:32:38 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRfQKhVyh/rRa3HdKgbuM1Ee/B4Rs1KsOvgsIf2N0COVz7+HIEAE6YQUmZZ1pH9pIIBOcDvfowupk+T9BDoGzZaOZfNc1kCwvKSgrF0cPeC6iiOf1OHyavHVNvwmLT6MMbeZT9aiFdFiB1SYfxzHeEqslMhy23hgKdUp7YpW26RlVwmGDAE+PNFkk3rn5HgcyA5KAT9xJ7BHeuu7V5sl//yw5eh+F4TgvGet6ThnpjyFZdtfxwC7iLK1v6278EIWOAST+wokO+o9AMBZZH5+awlRzt2A344P/LmW2g/a0Hufam9goa0i0TubG8tXYUmgrNb7ukW9IAf6MsgATA/rFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7M/W+ncJkSbYOHjaJxkCQE45aXj1mIoinary8/mKd4=;
 b=yq1ansMNEkynpm/ux8EZA2EIHnpSX0xhtYpdgBnJWkPdO7RZem54yDVFYJrwz4pT/cRt5DA663EcMKndBKrA1esEjuTcsD6g+obW2N3r+33fJoCybFdUVf0By4I5dxtMBsAR77KUipfA7kS5N/00l9wDxWUnpI64eIvJnrVoDA5dzwrOAqaUwXr60NUy/jQW9br7EPy1FnT/60FxxxxK893UW4W5bsIjWvJ/NT2DIdcugtWw253YKRSbe5g33/w2fMZK08mJcXzrKiyA6nQ29irntKH+9HQjL3/iB9loY89dKe9K5woDBJsHEy7ywLP+AanRp5KMM30+9KtNUFP8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7M/W+ncJkSbYOHjaJxkCQE45aXj1mIoinary8/mKd4=;
 b=OV95qkhz5r5MvZTJlYvv61dHGMRHOD996EyKO/XP4U/F1hUHz+9q/Y8kxrkSX41kTXmAFiNidQMZTAX+tXHYE5agk5PvNRL9exdRzT/K++59qXZtr/Ogj2DD1jj439MY4MuO/OBG0BrozoxKWdApGFz6azAuz09YycfmAfHUTD4=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by IA0PR11MB8399.namprd11.prod.outlook.com (2603:10b6:208:48d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 15:32:34 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:32:34 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v3 0/5] wfx: add support for WoWLAN on Silabs WF200
Date: Tue,  4 Mar 2025 16:32:19 +0100
Message-Id: <20250304153224.39083-1-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR1P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::11) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|IA0PR11MB8399:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a79f43-8e76-4954-f9ed-08dd5b31c8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmFmWEpuTEdLcUpXYVhrSVpIY25JRjVBL0NBeWdvL1Q4ejk2YWYxdllOaGJo?=
 =?utf-8?B?YVdWQWdTckdSTUhyR0FsV25tQ3JMNTU5OEVmVkZEc2hYb1kreTZPMWlDVlln?=
 =?utf-8?B?TFZ2cjhTMDR6OHVGUnVQdjN3QzdBMmQwZDJ1Q011NHBsMW1xVUhhUTljMStj?=
 =?utf-8?B?K3M0TC9GTHpqd01tVnI0bXJWc3ZLTkpYS0NYbjNNR0MvVUNjOEpZY2piRldL?=
 =?utf-8?B?ZTFRRkdYa21QaVJGckJGN0o1N2M1WXNMczJxUjQ4WTRYSkVFQitNSUVtT2Vs?=
 =?utf-8?B?OFp2QXlBZlVnTHl4amVGWm9ZZTZ2UTNWOXJnUnFrUWc0Q1NkVmJSem5NVjJR?=
 =?utf-8?B?a0NiTlB0VzRLZk9LUnI0WGVqbUE5d01qR1N5eGx6U0FEZlcraHF2NXQxR1Ra?=
 =?utf-8?B?UXJqa0h1bmJlbDQwOUZjcVRxaG1ZWHV5TzU1dm51amdnaEJjRHhrYWRWVG5T?=
 =?utf-8?B?Qk1FV0t5dlVja0NpUGJnZE5oS0NEMDRoSWRaUk9jZnhaSW1iN1FHWE1INUZO?=
 =?utf-8?B?b0lzU1hCRCtpNGJ5YmxwSENSUndSc3VobE1hL2o2QytFNWNQY1h5dWdOb0dO?=
 =?utf-8?B?RTFtc2NHUTV5eHBGQWJOb0hPYWV6YzN1bS9ob2xUbm41ZDhqMHV3NUpaMEVh?=
 =?utf-8?B?S3BQOXcrYXhSYU1CdlFsbjgzdi8yMlorc1BLTmtER0ZJcDJ6ejFrZ29DYUpa?=
 =?utf-8?B?MStNNUlhbUduUitnK0VxajJMMHVsMVNIa3dGWG54U1M2WnZLb2R6VHFVM2Y3?=
 =?utf-8?B?cGE0bEViSHFCOW92VzB3dVlzRUE3VEJDYTU0dmlnZVdWRXF3SXRGNGlvUjE4?=
 =?utf-8?B?N0xFUVpBUmhmQjhvSVIwdXgvUlFiemhmL2ZDS1owdWtqK1BCbUx6UzZxWTVl?=
 =?utf-8?B?SHNMYTljWnlueUFiQjZiWm9LSG9tZUhHQlVPNHRHTG1LNkZpYnVMLzlTaFo5?=
 =?utf-8?B?dlR6WFFIRFpvS2xiZFRiRG9vOG5DY0JJRDJsS1RjUTV1K1BwRUxJckkvYWxT?=
 =?utf-8?B?NENMY010RDdqdmszbWtycW1xa2VSQktaaU92VDhURDFIakY5RWJ6dDNhZGZ3?=
 =?utf-8?B?SWpQYU1Wa0lRVEZmNWpJSXU4azZIWXhzNzRNdnVsTDZRbXdRaVBCQU1PWC9p?=
 =?utf-8?B?eUdvdDhqOW0xODlEODE0bDgyRHdlQVdNL0xlWnJ5UnN0blZXRHNheGlPUFhq?=
 =?utf-8?B?K21hZkR6TWdJQkVhUU10dC9NSFVveDgyampXVlBhaFNHWi9Na3REVkZhYVRy?=
 =?utf-8?B?U1pBTUQzQjBvVWxhazM1L2xFeXpBV0wzOHBJQUpSSkY1d3Y0WHdoL1cyWEwz?=
 =?utf-8?B?K1pmRjdzenBMcHBpcWtoRE9haW1tN01WOUFQT0VDSHNGcFdiQWlET2hPMndZ?=
 =?utf-8?B?Q0x1SGd0bTNLaXBtNlI0djBtdEZDT29EaUZmcThrT0V3ZTRrblRIaFZ4RGVn?=
 =?utf-8?B?bVhlZTVUMVA5S2kzNWxaVjVMTDErbkxrWVJkM2VsWHc0cEtub0NMQmZyeDZi?=
 =?utf-8?B?TWE0UWh1amc5K09zOERBTE9TdlRXVGVNaTg4U0tlTlZpK3dDak1pdEJJQkI1?=
 =?utf-8?B?eS9ENVJ2dDN1ZU5PdWR5NjBaSXZUa04za2tKL2MwSVZVdE9Ec2xyVS9Lb1VS?=
 =?utf-8?B?UVNBWWtnM2lzU3hkNzhkdlo1SlNZK3VVVjRGc2pmN3J5bmxxeFJpbVl5TjlX?=
 =?utf-8?B?N0dQei9kbUNGYnc4M3lnTktCYTVJNlJqamNvaU1LdXBZTEEvY0ZLQ0xJWXhx?=
 =?utf-8?B?NHcweXdpdjlMRmdlSGQyajd5eHJqTFNaV0x3a096NlR5V21lNXpOVWJ5OU5V?=
 =?utf-8?B?WXBpQjNHY3hoQXZVZC9pM2NnbGkxS2QweFpqR3pYaWxJdzNFTzZTVTJ6NkY3?=
 =?utf-8?B?L0wzTEdGNjdodFRBeEgzSFd2YUZVc09tN3VmcnRnaXFnMHM3clBUYW1zZnQv?=
 =?utf-8?Q?ldJ2JsNOPid2Wf2oPVQd7r8mhyA45Ljv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2xqSlhMVWllTW1Kby9PTTNNMUpHd3d2NHFmdzBQS09nU2RERTkwc3dLbEpH?=
 =?utf-8?B?L3JUSjk5YkhFNEJMTmJ4emJ3UHVwQ2F0SUlXZTlmSzFoTUdWTENtUmNBZCtX?=
 =?utf-8?B?dzAvWnMzM3l6MFFCZ0ErZmJwcDFUZVMyQzFvcjMweTZaTkNlRHAzZmVValpV?=
 =?utf-8?B?VkR2RmJDQjJ4WjJrNWdFRTlSMUo5SmJJT1p5bVl2WklHMW0rWFJqdFFsL0dP?=
 =?utf-8?B?L1lQWHVsUnB1amg0L0F0ZG9xVy9wMFVORFI0STVTTmJVNzNEMmt6NFVTU1Jq?=
 =?utf-8?B?VmFqOEorMTRIZEpzcjY3bXU4cEJORDUyNjdiSE96QXJmZk92RnlaeWdvVlRU?=
 =?utf-8?B?eW5TWWtGTGFCME9pT2trZEROeWt5bFYwYWx5ODdreGRud2xtQis4bE4yMHE4?=
 =?utf-8?B?eUFVdDRmTi8yZVAwblRaVVY3b09qUWtkdVVpbFk1eTJBYXh3bVFPcmJFSEZL?=
 =?utf-8?B?N3R4bWFKZGkwRTkwU0RBVlJDZGNKZnJLTWVTTmVseEprMVo1YXVuVTJWZXNl?=
 =?utf-8?B?Q0VWcUNpVmFPSXN1N0l4enNuZUVNNSttcXdDczByVkl0NE13SGZhaDloMG80?=
 =?utf-8?B?WUovdVVMZHpSaDhHQkk2SlpBbTdpU2hCcW5vZVoycnNhYXZxQTdUN0k5Rko2?=
 =?utf-8?B?TnJyMkNlS0RHUTZrY25TMm5Uckd2V0FlRzl5UDN3Z1YzOFhWbEVhL1cvRDR6?=
 =?utf-8?B?MjhWMTVMOU1vMUpHbkhJamRHaXdqeXBMR3A0VkpyQW1aZmljcjFyRFN3dWtv?=
 =?utf-8?B?c1QreDd1QjVQUWRxTnZKTGk5N1dIOGI1TTdiNGdGaVNjbk15QjJRL2ZKZ3VG?=
 =?utf-8?B?T0lURk9tQmNxRUFLMDM1ZEJsei9UTWhwdmQvZ3Q2dlRDYXlGcGFDWlRETkV6?=
 =?utf-8?B?Qkg1MHdrMDQwblV2dDRGamVRcVh3SE5Ud28xbVNiMjNFY0xxejhpZUVMK1Ra?=
 =?utf-8?B?SjF1bjVRVm9DMGlNSGtsaWNDQnI3SXRyS3BUR0s3eWpoVVFBdU9oblZaTlFU?=
 =?utf-8?B?dFpNK05ubzNkM1BVWUl1cFhZM1ZHa05EendxS1VQSDlEZVByWjdIeE96b3U3?=
 =?utf-8?B?bG9oQVUrS1JqRmozQ3JoWmpwZndpK0JaZHBuSzJXNEEzZDk1ZzFSWDlqRTBG?=
 =?utf-8?B?d213SE5VT29IaVc5QUQ4ZVhnNmpWUEhseHNHRUVJSnFVcUMxTlhkN2tEK1NT?=
 =?utf-8?B?ODdBUkphdFBqZG9vSndrN1RHMjRFcWo4S0ZnV05CUjVrdTlHUk5uNUFvY1BT?=
 =?utf-8?B?QzBzajJBdzNNdEs4ZWU3YTRlaUU1TVRUdFlsZWZCYTNFWEJoOVdyYVBhMFE5?=
 =?utf-8?B?eERBcGZTMENPSWw5WGJaUlpabWNHV1hhOFZyVXFDb081MTBTejdtNXBaSXlx?=
 =?utf-8?B?aXl6ZysxTXF2YWpWZnR3WkJoaGdMZ2VxbURWY3EvK1dWSEEwS29nTllNN0Zs?=
 =?utf-8?B?V1hXQUo5alFCVm1GYk1iWXJ3bzdHdE80UkV1RS9SdGZrcUtsQkYrb1FxNEw1?=
 =?utf-8?B?Q3I4TlVFaGZTNzdEMHhWQU5OaHl5TlJZMk11dE1UN2VCOVNaTTZNL1Ard2Jt?=
 =?utf-8?B?bFpIT3M3Y1YyZWVDODNyYXdxOG5odHJhZng4ajhRMW1pcE5TTlhBVFB4ck8r?=
 =?utf-8?B?b3pzSElnN2JYR3JFdzB3elhpWUFHMkRPcDJreUtwanFsajE3eExSbnRMSExs?=
 =?utf-8?B?ZDBUWWJ0THB2bUNzRlQ5cldidTMxRFVMOHNyU2FqS21RVXpoTGpLa1c1VlhO?=
 =?utf-8?B?bURnRHlFM0ZoTkJUMDRCVkFRQU1Da0RhbitRRXJraXRDd2h4bkJYSXc2OXZC?=
 =?utf-8?B?Tlo0aEJDK0hNMURxY1RTZllRWlhyUk56d2ttNVpneDlsbXlCVnIvZFJQdVkr?=
 =?utf-8?B?UGFEU0theWZVMkpwdDI4NVhBdENxZnRobENkRWNVVXVkMzJ5eEFJaTk5QzRs?=
 =?utf-8?B?eGN6byt6d1IzWFJSczE3dURyK0RTN3VvTjFuUmdCS2g3YlZFeXE3dkNaNUs5?=
 =?utf-8?B?WDd5MnNCT2t1eEZNUVBoMVZINlBtaElYQmkwVjFxYnJGSGhoWUNoZDZsSUk2?=
 =?utf-8?B?cjVSMGZkSitaYnpleUM5R2xBOHpLSHVHMDRxa0RnOVg4YmxBTkpJUHFZUUpj?=
 =?utf-8?Q?N9IkbmWTJT+0n9WCCWQtNXHLt?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a79f43-8e76-4954-f9ed-08dd5b31c8d3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:32:33.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2qghgefdNmvsS07yxgRR6WNDzfxekLG9Hyovaeshi6/INpyWdlFxoXKCpGqCmUkRhz5X1KXGJSZxXYLVZbKuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8399
X-Authority-Analysis: v=2.4 cv=DPN14zNb c=1 sm=1 tr=0 ts=67c71d16 cx=c_pps a=LJpgAVzrtcldLI4wrjuEkA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VXklulzeiYJ0jjgIAQcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7OGUk7S2nybEF-QSf4EnP5k0WKe-YRU3
X-Proofpoint-ORIG-GUID: 7OGUk7S2nybEF-QSf4EnP5k0WKe-YRU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=500 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503040126

VGhpcyBpcyB0aGUgaW5pdGlhbCBzdXBwb3J0IGZvciBXYWtlLW9uLVdMQU4gb2YgU2lsaWNvbiBX
RjIwMCBjaGlwc2V0LiBUaGlzCnZlcnNpb24gZm9jdXMgb24gdGhlIHBvd2VyIG1hbmFnZW1lbnQg
Y29udHJvbC4gRm9yIG5vdywgdGhlIGZpbHRlcmluZwpjYXBhYmlsaXRpZXMgb2YgdGhlIGNoaXAg
YXJlIG5vdCBleHBvc2VkLiBTbyBhbnkgbXVsdGljYXN0IGZyYW1lICg9IGFueSBBUlAKcmVxdWVz
dCkgd2lsbCB3YWtlIHVwIHRoZSBob3N0LgoKSSBoYXZlIHRoaXMgc2VyaWVzIG9mIHBhdGNoZXMg
aW4gbXkgZ2l0IHRyZWUgZm9yIGEgd2hpbGUuIEkgaGVzaXRhdGVkIHRvCnNlbmQgaXQgYmVjYXVz
ZSB0aGUgY29kZSBpcyBiYXNlZCBvbiBhIHByb29mIG9mIGNvbmNlcHQgYW5kIEkgZG9uJ3QgaGF2
ZQphY2Nlc3MgdG8gdGhlIGhhcmR3YXJlIGFueW1vcmUuCgpUaGVyZWZvcmUsIHRoaXMgZmVhdHVy
ZSBpcyBleHBlcmltZW50YWwuIEhvd2V2ZXIsIHRoZSBvbmx5IHdheSB0byByZWFjaAp0aGlzIGNv
ZGUgaXMgdG8gcnVuICJpdyBwaHkgcGh5MCB3b3dsYW4gZW5hYmxlIiBvciBleHBsaWNpdGx5IGVu
YWJsZSBpdCBpbgovc3lzLiBTbywgSSBiZWxpZXZlIGl0IG1ha2VzIHNlbnNlIHRvIG1lcmdlZCBp
dCBpbiB0aGUgc3RhYmxlIHRyZWUuIFRodXMsIEkKaG9wZSBzb21lIHVzZXJzIHdpbGwgYmUgYWJs
ZSB0byByZXBvcnQgdGhlaXIgc3VjY2VzcyAob3IgdGhlaXIgZmFpbHVyZSkuCgp2MzoKICAtIEZp
eCBtaXNzaW5nICdzdGF0aWMnIGtleXdvcmQKICAtIEZpeCB1bnVzZWQgc3RhdGljIHZhcmlhYmxl
IHdpdGggQ09ORklHX1BNPW4KICAtIExvY2FsbHkgY2hlY2tlZCB3YXJuaW5ncyB3aXRoIENPTkZJ
R19QTT1uCgp2MjoKICAtIEZpeCBjb21waWxhdGlvbiBpc3N1ZSByZXBvcnRlZCBieSAia2VybmVs
IHRlc3Qgcm9ib3QiWzFdLiBNZW1iZXIKICAgICd3b3dsYW4nIG9ubHkgZXhpc3QgaWYgQ09ORklH
X1BNLgoKWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyNTAzMDIx
MDU3LjVxQ09xcmFhLWxrcEBpbnRlbC5jb20vCgpKw6lyw7RtZSBQb3VpbGxlciAoNSk6CiAgd2lm
aTogd2Z4OiBhbGlnbiBkZWNsYXJhdGlvbnMgYmV0d2VlbiBidXNfc3BpLmMgYW5kIGJ1c19zZGlv
LmMKICB3aWZpOiB3Zng6IGRlY2xhcmUgc3VwcG9ydCBmb3IgV29XTEFOCiAgd2lmaTogd2Z4OiBh
bGxvdyBTUEkgZGV2aWNlIHRvIHdha2UgdXAgdGhlIGhvc3QKICB3aWZpOiB3Zng6IGFsbG93IFNE
SU8gZGV2aWNlIHRvIHdha2UgdXAgdGhlIGhvc3QKICB3aWZpOiB3Zng6IGFsbG93IHRvIGVuYWJs
ZSBXb1dMQU4gdXNpbmcgTkw4MDIxMQoKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
YnVzLmggICAgICB8ICAxICsKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvYnVzX3Nk
aW8uYyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93ZngvYnVzX3NwaS5jICB8IDQ1ICsrKysrKysrKysrKysrKystLQogZHJpdmVycy9uZXQv
d2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMgICAgIHwgMTQgKysrKysrCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jICAgICAgfCAyNSArKysrKysrKysrCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oICAgICAgfCAgMyArKwogNiBmaWxlcyBjaGFuZ2Vk
LCAxMzggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCi0tIAoyLjM5LjUKCg==

