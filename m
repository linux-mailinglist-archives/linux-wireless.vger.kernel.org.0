Return-Path: <linux-wireless+bounces-19768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A3A4E476
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB3A19C20AE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147D6278173;
	Tue,  4 Mar 2025 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="PIHhX85G";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="ZjvfHfOU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641DF27934C;
	Tue,  4 Mar 2025 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102375; cv=fail; b=K1hZPEj9JL0WaEIxLgmD4qgo9Iw8ojNeujPo9MM1IJEWNBGpOu7B9ch22xNyrYUkxEt1a2ujnXicpIijY17rPdrEGfuu9+wWdy/fvk0hsOv8g1pZOQ+GvFISoG+1FZpUAu1ofcqg2uYDuckmStt+WmIwK1ffnZLyMDSizt2A/vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102375; c=relaxed/simple;
	bh=fVucF6//r7qDmwqroBbj61dAupJkMsP/J6Dq4pa8v7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQTmelT0sI234QqmA+GofNzXZDE+KQtDfwNZMpbMxOoRcnDJ9u6WBk9wRW0lQVynUJaQOnhhV8UGHqLnLKH6qPlrtOI5kl4qQxyDDwVVwwMmhs4SIuxOVm23zKhjCmVVbsF/giYP5UCu/xyg0vm4GO08oiH5QAeUalIlHEUDt+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=PIHhX85G; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=ZjvfHfOU; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5248TYaB028076;
	Tue, 4 Mar 2025 09:32:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=fVucF6//r7qDmwqroBbj61dAupJkMsP/J6Dq4pa8v7o=; b=PIHhX85GN+n3
	VJEXahLTCPGTsPHIFBGYgkdPafJWt+3VaKVuf7p+Ui9zzFvfGGB1wUolU7sU3OL4
	y2Y81ign1bRugNlZZvXTKfOmRLBa1zV7WJ4oHbDqWvnywb3Ay2FO7eRaoso5PaiY
	CXQCuWJkQZ5g8ADC6PD1/TfMjmWuLEhS7Zxibz2jdziyCqQR8BVJUWV0xgaFooOE
	ng/+AoYlH8j3HLaSiGVaq6/bGK5AnGN4Mk4YYNnpKu+okpElOeizoLKn0OvyydzN
	/oHSanOJbcJQ+qSM1HrygPcNF6cgbVT9A4dlZK60HNFkn05fwMkQlFOJw1cn7QGT
	YtF3qEq/HQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 453yegn158-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:32:38 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lyk6L3wbI6pU1sa9hcxstbDG9uxxe1cSGVZPbGx/wOPVZfc3qEakmu7GcTO/od0+rSGxGgIJgw2ecz8769MB3D3ifC5cYrKqGT67upw9Xq7q8sOFB8jo1z9ovk59Px83+eB+C43WR9wLC2/aW5q9XnbwB+FjvGU2GAMGi5NO1nOJQhi/q9MGW9HmNcAS7WtEWYHX9m1T6i/6dXztjF74NJ/Zvf8G/yINBv6iOJSt7FGadjIuoQqM5isHJFgvgao3LwIPxEPTvKm8GEuEIrSPpg7W1FsiOGBpW8qawlVY09Fz3FhbWtX9uQF7532eyVoR+Csod5VHErzUPoXRqpYuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVucF6//r7qDmwqroBbj61dAupJkMsP/J6Dq4pa8v7o=;
 b=Hr7W0w9xFGlV9PTMcOLQj0DsKyJN2x8STKYGQAGerIlIaXva4gUw48mioeagmeY40v+qtem6r/1NMdUgAlzdRsed4ARwvHM+IXc1CHgv/gPcMpEsefHUA7tLvtA6fo4w47fIohXx+vqHbZ+HjZrTv8c3KsdCzBvU1LZ6RDKWpC8pNopVXafSn/ZUtLUqBI5/kbYCRPpcLnSrD2Vz4bqa5gnglJcfmTyfAAxxDsnqpcKJ0cMQ0aAg4IsTN5h/U95BfCFKuM1ij585nnYFQkQLu7d4dvoDfUxYYGvmsg32/CdWOZyJydZf4AW/2VspWTtUSjohJSIUETtAkBghMh9Rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVucF6//r7qDmwqroBbj61dAupJkMsP/J6Dq4pa8v7o=;
 b=ZjvfHfOUUUDgXoBjuGXHEDYW54at/QaXn5O9ONeBid7yL75LAmYa3UH9KjRQ7U195hHgKe/URov7hGvkPMZdt4tWGEAbqXaf0g7T260o1IVgOBBXlqI9RtvFl9hqCsjnbzwnraZUHlvp0xFaakw/rwVigFfz3PK10BrvC4otT0M=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 15:32:37 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:32:37 +0000
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        linux-devel@silabs.com,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>
Subject: [PATCH v3 3/5] wifi: wfx: allow SPI device to wake up the host
Date: Tue,  4 Mar 2025 16:32:22 +0100
Message-Id: <20250304153224.39083-4-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304153224.39083-1-jerome.pouiller@silabs.com>
References: <20250304153224.39083-1-jerome.pouiller@silabs.com>
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b713b8-ea56-4060-9111-08dd5b31cabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3oxY3N5S2JrcUMzMHg2aDZ4SUJyemVoL0FhcTV2K0xEWTQ1Z003SjRkYmNC?=
 =?utf-8?B?bU1OYWVnYmhtcFhhYWVFRVVlc1A0NHpDdmMxZHZmRmFkTjBFRzl3VjZuSkpm?=
 =?utf-8?B?ZWdzazFIaTJmTFZESVhiSGI5ZFRaL3NnS29nSURvczRXdVdVV1FrRFhoQXYz?=
 =?utf-8?B?N0VLWnI4ZDgxVzhnY2xteTRrQ3lyUFNzajFxSVJLL3AweEJBbDdsN2RPc3J0?=
 =?utf-8?B?MncwUkRoYVBlQytJcUtFVERZRHluc2pQUWJzSWloMVMvM3hyZUdPUzEyK21C?=
 =?utf-8?B?MWVIbmtSK2tsLzdLVEQydEw1elByTjVNdzF4ZHBZSXM3b1VEQlN1U1VRY3VL?=
 =?utf-8?B?M3FSaGE5MUhqdGYxSUNMMWFmS0g0QUJRTnM1WGhETWtqeHgwS2JUQm9wcmdq?=
 =?utf-8?B?WjYvWkd1SmRYTHdBdmpRekhqdzZ2c0JXNGZudnhNVU9BSy95K25QdUxuWkM2?=
 =?utf-8?B?cmd0Zzk2eWJyU3RreTdYdmpibXBpMnhUNjR0MktvQ0UvdFpYaTQ4dUpCUmRr?=
 =?utf-8?B?Tit0dXl5SnlOYVA4TStVS0RKaEZjblllVTR2N3kyaDlibHZJb2g0QzJsK2c1?=
 =?utf-8?B?SnZaL2RxN3VtWndxQmFmaXY3OVRNL1dhTGFaSlJndTFqYlFIUmdFd1FRSzZL?=
 =?utf-8?B?ZWhFZHZ2QnhzTG95YWVYSXVYVEdGQWtkTm5oeFgvYmJxWnZONWNNL1p5a21k?=
 =?utf-8?B?TDdKSjlLL1RFZDBTME9qbkg1ZExiZjJYanpJclV5MEtzaFBiMDV2Y0V3bDlU?=
 =?utf-8?B?TEw2TlM2eGxwWGhCenpkMFlZZE9QMitNR2ppNkI3T2hPSWwwYVIzNExlVTVw?=
 =?utf-8?B?KzRTdVNXSU9wMkdnY3VMMHNTOTFtL2V2akFJclJIeDNnb0NqYldjL0RYVG1S?=
 =?utf-8?B?eXRsWTBxclBXYkdKTUFacU1xNGNvN3paY1g5Y0ExTmJYbDZ4UmpWZnNJSWhC?=
 =?utf-8?B?UVhVek9tK3M2S1ZnTzFaa2p2RnlIaWx5eCtzTnVZeHorTzdYS1pPZXpadFBq?=
 =?utf-8?B?NmtxV1lSaVBBN3NqT2svalBuRE9tMTN6TGh4YTNJZjVVUzRaTDZwNFA4Z0Mw?=
 =?utf-8?B?R2J6UVJIdVFRWnNIZnhDb25pNW14cGhGQld6UkczUFE5KzV2RWUxT3RWT3pD?=
 =?utf-8?B?Y1p4ZkFoVzRmRTFpV2N5N3hJSHhacXcwZWhkSFFpRno3WEE3TXNDWnNramxr?=
 =?utf-8?B?bTFNeDRBa0U3bmxJYlhXZHpOblRVcjBkbjVZYXRWOUltQ3JqbTljM0RxUnlE?=
 =?utf-8?B?WnRKU2NJa0N0d0FhL090TGFwaXl4SXA5YUNLQXB6QXJUcG5FWHRtaEw5ZnRZ?=
 =?utf-8?B?QVBpemdOVjNoUTFvczdDZnJBazkzb2Y2b2JhRHNCekdlNVhGL0c0ak40eU5x?=
 =?utf-8?B?QnE5YzZXQ0Y5aDlITXlyYWtZT0Y4YjR6TllWNkt5akxDRTJMT3M2cXorT0dS?=
 =?utf-8?B?Z05aMGdYSkdDWFNFRjk3S0hIUmlmQlJzRzNFZ2U4VUs3ckozeTFjUVc4S3ZD?=
 =?utf-8?B?QnRpaC9remZZZ2xycFRCcXUySjJXZUUxejg2UmpmL2g3MWZGZVg0cC9zMHBY?=
 =?utf-8?B?cnpMRHppbUNKNitqMHRHanZUT0NxTHhOREJtQVd1SnZxMFJFK1IzVXNHMmR4?=
 =?utf-8?B?L3h3VElLalJpaEpyMzJHdENVc0h6RTA4WjRuME9GK2hRMGVidUU5d1VBK3Zj?=
 =?utf-8?B?TjNkNmtQTnFDOVdIbURzTGFpZDdLNUx0SGx2SE1LaDBYNWpEbE9EbGQ1dFhl?=
 =?utf-8?B?aUh1TjdEclJBWjdLVUpQd0pTS0RqbVNuampoekZGWDJyNGlNKzJlTm4rWjdv?=
 =?utf-8?B?VlhOWW5UODMxU2VYcHFDa3ptdzRGMWorUEFDRjZ6RlUvM0FxcWpJTGdCdzNF?=
 =?utf-8?B?a3d5bkhXa2xtOW1HRjlFaGRDUVZ3VVVrMzF0MzhJcEV1RFdTK2Jua0M1cGt6?=
 =?utf-8?Q?tTq4vDin/d33cBTC+Bsg+CaE5g+ZppmH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2p2bHdtcXhxTVBhOGt0WnNYR0g2NzQ4cjBrTVoxaTdWOWZOYnB6VDV1Nzhp?=
 =?utf-8?B?UEUyUEt2c3kzdGFMUXRNNUdTdEtmRXcwT0ZYRFFQdzZQMVExY242UHViQ2VZ?=
 =?utf-8?B?QWxaRGVCY2NFTEw1VjlGNkFtWDBWdXRVQTMvdmc4d05DQWRSUklIRlRDeDEv?=
 =?utf-8?B?ZFhhV0o1c2Q2bUNzUWNrTms2MHc1UWt4dVFsSmZPSExSMy9IbThBelZpV0dl?=
 =?utf-8?B?YVFIS3hodFEzZkk0V01TUUNiWkhTS0h2SWtWK3k2QzhvRVR6Nms3Uy9OMC8w?=
 =?utf-8?B?UmowNnI1RDNCajNOdlg3UWFLNlJibG9NdHhKN3laMDBQTE10VXQxWWU2azJO?=
 =?utf-8?B?S2hNN0VKYXhZSHo0ZHFXYzNkRzVRMVhIcDk4dzlWdTIxR0dRcFZsVWpFTWk2?=
 =?utf-8?B?S0lzeklBaXYzcGdLWWVCOHRhV2dUMW9zRkJkWEZzekhySEdGS2ExTDllZWxU?=
 =?utf-8?B?eGdLYkpuZXhZbk5meWpBYjZ1am5DVUNRVGJUNnNLMk5FNllqSi9uOXhoM3cx?=
 =?utf-8?B?bjM5RHVJUTcxeUVITjRKdjhweUVBMXp6TlpXZUlGeG8zbUx0U1haTmt6OXRk?=
 =?utf-8?B?Rmo1Y2FCWjhvOHFQb1R0cFlNQzJId3N4RUtaQmVRVEMwRFN2cHJmYmx5NDgz?=
 =?utf-8?B?SzBFRFA3UEx5NVFyaTlpcjk1emp6US9uLzRkdVU2Y0xDNHM0TGZoRTliTE11?=
 =?utf-8?B?S1VhZDluZnNza2RaZUQvL3FjdEdDNnZzZFZxZ21mR1cyVlNmaWRYc3U1R1RG?=
 =?utf-8?B?MkNPZUFQVGVFenhXaHM1cTArY24wUFBGWndiYlpIdjdKUkQ5ZUdUampCVXNU?=
 =?utf-8?B?ZVJGTExHSStQdlYrVHVheWJyU2FwdVlpMVlZY1pqeURYcFZOWUtGWEgzYy9J?=
 =?utf-8?B?NUp5S0Y5eUU3U21JY2FiaEoxUXQ0TzVhSm9YNVdjQkVaWGlRakNrZEtYM3I2?=
 =?utf-8?B?cVdGM1NZcmc0eTNVM3dvQ1VXMk9TaFdCamcvL2d1a0RjMkNvQzY0b2VpT3VU?=
 =?utf-8?B?OHVOYitoaS9CTFhTK1lpbktaL0s5d3NKWWVtTDErdy9aVjVXNXhiZmNBenlB?=
 =?utf-8?B?aVgwY0ZYcnJBZjlUSXM4V1BkdVZ6ZXV3L2NZMi9VVFJtZDNnSloyOTVTWlVM?=
 =?utf-8?B?dDZqOCs4UU1tajQ3YmMwRUlDSVZIc1d3dmhsZ2plZWJiUUwzSTY5NjFUWHRP?=
 =?utf-8?B?cjB0QnNoc2ZTWnU5RjhWamhmKzN3TEhTdng4bEJENUNzVElTQlgxVGZhUjZU?=
 =?utf-8?B?U0F5REdSOVU5YzcvckVkMUJyK0MzcXlqYlJFbkxQWmhKbkNnWHE3S2I2UjFy?=
 =?utf-8?B?U01OVW4xZ1ZnM0hsWHFYcjJVNW1SNktNa2t5czZLTUhnQXc0MGpJeDFuTFcz?=
 =?utf-8?B?VENDc0U2MktvQ2hLVWozcVRsU2hWL1FmOGpkdDE1S1JPNUhTTUsxK3JRR2dX?=
 =?utf-8?B?YU9MaXExc3B5cVRMR2dIQXAxNDh1ZDFFRndOME1CMm5haWxRK1RkelBSc1FR?=
 =?utf-8?B?WnYzVEtxVlpEUGJlejBzZGFCK3U2S28wakk3bDl5dFFtdHFFRkcydjlmVE9X?=
 =?utf-8?B?TUh1Y2huckNuSEFXaXN0UXgwWHBDNEZLQlVRNlF3UlVUYis2all4VzJIOGFI?=
 =?utf-8?B?T0NCK1lraHJFU2J0MzMzWkYrZzEvdFhmNHFNVWxGejRIR0xLWDRWR1VlQ3M0?=
 =?utf-8?B?Z2lWMHltbjlDMlJwVUpYd1cxanFja01KZk1MeThGWDloMFlSdVkzZGVkV2Nw?=
 =?utf-8?B?dkNHcjBTRnU0elV0QlhtWWpUMmU1Q3FyWGdWeDV3YUVZaWJKTlI0cDJCQ0NI?=
 =?utf-8?B?Y0RFbHFQNVRVLzNPVVI4dXJnQlBVTUpsaFhHVTJybVpYZW5LOVJLMitzTFRn?=
 =?utf-8?B?eUhmNlpsTlpETHVrcFIxMEIycnVCbWJrWDFZTXpQTzNtZ3VnRHl5VkpXYU1i?=
 =?utf-8?B?dlV3b3BNVkxhKzI0MVhKcjVOQ2xHamhldzNIZjB5TGM1dTdMc25MNFdJWTBL?=
 =?utf-8?B?QUxpUHcxeGhWVTd3YkUvdHJEbzc2ZTdaaVVISEFHeG1NMjhYeHZ2VVVRZURK?=
 =?utf-8?B?cTdrSDY0OEYvS2EvZmhDOXNGR0JldjlnL3pxWGsvMGdJQ0JFcDYzU2NLcm92?=
 =?utf-8?Q?XcXmzPy4IRJbagQz0T9QRAGfz?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b713b8-ea56-4060-9111-08dd5b31cabc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:32:37.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYWiz9Uu9ZDtUCW3uZycINBuxNCPS2hSIysCuo/6QRWx4pL7WYpY65MatHPjh7Z95RBTCjAYQrmsQXLcQa4rfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-Proofpoint-GUID: e386ap-JiqGBCLeoeCzVCb6LOK1FHVLu
X-Authority-Analysis: v=2.4 cv=K9PYHzWI c=1 sm=1 tr=0 ts=67c71d16 cx=c_pps a=IJ1r+pqWkCYy+K3OX67zYw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=y8Il-FFEXRI_uRj3CQYA:9 a=QEXdDO2ut3YA:10 a=SRgmj7pJOxBPWxSGtsjD:22 a=d-TXpq5eZF0AJmg2YLt_:22
X-Proofpoint-ORIG-GUID: e386ap-JiqGBCLeoeCzVCb6LOK1FHVLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=874 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503040126

V2hlbiB0aGUgaG9zdCBpcyBhc2xlZXAsIHRoZSBkZXZpY2UgaGFzIHdha2UgdXAgdGhlIGhvc3Qg
dXNpbmcgdGhlCnVzdWFsIFNQSSBJUlEuCgpTaWduZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxl
ciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
c2lsYWJzL3dmeC9idXNfc3BpLmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxl
IGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3NpbGFicy93ZngvYnVzX3NwaS5jCmluZGV4IDQ2Mjc4ZGNlN2ZmYy4uMjBiOWMwMTZi
NDBjIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGku
YworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2J1c19zcGkuYwpAQCAtMTMs
NiArMTMsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgogI2luY2x1ZGUgPGxpbnV4
L2lycS5oPgogI2luY2x1ZGUgPGxpbnV4L29mLmg+CisjaW5jbHVkZSA8bGludXgvcG0uaD4KIAog
I2luY2x1ZGUgImJ1cy5oIgogI2luY2x1ZGUgIndmeC5oIgpAQCAtMTg5LDYgKzE5MCwyNiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHdmeF9od2J1c19vcHMgd2Z4X3NwaV9od2J1c19vcHMgPSB7CiAJ
LmFsaWduX3NpemUgICAgICA9IHdmeF9zcGlfYWxpZ25fc2l6ZSwKIH07CiAKK3N0YXRpYyBpbnQg
d2Z4X3NwaV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3Qgc3BpX2Rldmlj
ZSAqZnVuYyA9IHRvX3NwaV9kZXZpY2UoZGV2KTsKKwlzdHJ1Y3Qgd2Z4X3NwaV9wcml2ICpidXMg
PSBzcGlfZ2V0X2RydmRhdGEoZnVuYyk7CisKKwlpZiAoIWRldmljZV9tYXlfd2FrZXVwKGRldikp
CisJCXJldHVybiAwOworCWZsdXNoX3dvcmsoJmJ1cy0+Y29yZS0+aGlmLmJoKTsKKwlyZXR1cm4g
ZW5hYmxlX2lycV93YWtlKGZ1bmMtPmlycSk7Cit9CisKK3N0YXRpYyBpbnQgd2Z4X3NwaV9yZXN1
bWUoc3RydWN0IGRldmljZSAqZGV2KQoreworCXN0cnVjdCBzcGlfZGV2aWNlICpmdW5jID0gdG9f
c3BpX2RldmljZShkZXYpOworCisJaWYgKCFkZXZpY2VfbWF5X3dha2V1cChkZXYpKQorCQlyZXR1
cm4gMDsKKwlyZXR1cm4gZGlzYWJsZV9pcnFfd2FrZShmdW5jLT5pcnEpOworfQorCiBzdGF0aWMg
aW50IHdmeF9zcGlfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCiB7CiAJc3RydWN0IHdm
eF9wbGF0Zm9ybV9kYXRhICpwZGF0YTsKQEAgLTIzOSw3ICsyNjAsMTIgQEAgc3RhdGljIGludCB3
Znhfc3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpmdW5jKQogCWlmICghYnVzLT5jb3JlKQog
CQlyZXR1cm4gLUVJTzsKIAotCXJldHVybiB3ZnhfcHJvYmUoYnVzLT5jb3JlKTsKKwlyZXQgPSB3
ZnhfcHJvYmUoYnVzLT5jb3JlKTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJZGV2aWNl
X3NldF93YWtldXBfY2FwYWJsZSgmZnVuYy0+ZGV2LCB0cnVlKTsKKwlyZXR1cm4gMDsKIH0KIAog
c3RhdGljIHZvaWQgd2Z4X3NwaV9yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2UgKmZ1bmMpCkBAIC0y
NzMsNiArMjk5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgd2Z4X3NwaV9v
Zl9tYXRjaFtdID0gewogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgd2Z4X3NwaV9vZl9tYXRjaCk7
CiAjZW5kaWYKIAorc3RhdGljIERFRklORV9TSU1QTEVfREVWX1BNX09QUyh3Znhfc3BpX3BtX29w
cywgd2Z4X3NwaV9zdXNwZW5kLCB3Znhfc3BpX3Jlc3VtZSk7CisKIHN0cnVjdCBzcGlfZHJpdmVy
IHdmeF9zcGlfZHJpdmVyID0gewogCS5pZF90YWJsZSA9IHdmeF9zcGlfaWQsCiAJLnByb2JlID0g
d2Z4X3NwaV9wcm9iZSwKQEAgLTI4MCw1ICszMDgsNiBAQCBzdHJ1Y3Qgc3BpX2RyaXZlciB3Znhf
c3BpX2RyaXZlciA9IHsKIAkuZHJpdmVyID0gewogCQkubmFtZSA9ICJ3Zngtc3BpIiwKIAkJLm9m
X21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKHdmeF9zcGlfb2ZfbWF0Y2gpLAorCQkucG0gPSAm
d2Z4X3NwaV9wbV9vcHMsCiAJfSwKIH07Ci0tIAoyLjM5LjUKCg==

