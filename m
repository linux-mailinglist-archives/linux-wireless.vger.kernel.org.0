Return-Path: <linux-wireless+bounces-4369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBF58718FD
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E796C285081
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCCF4CB58;
	Tue,  5 Mar 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzTNUPk4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B14F8A1
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629551; cv=fail; b=oVa1pxJzNlwpjLe7g8zY9UrSLJM6iSd4z9dbaWRACuN76XODQvn3jd1nUuUGuUEpb8Ph1qutQvRsKeCfTI3nwt51Bq+OqLlq3Y2rbg2jmNKHqmhi08LhDkGxvmrC0IoSApMoX0bNP2SQ/7xPZwiMbS32obw3uvg+M2fEruuiwIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629551; c=relaxed/simple;
	bh=vOpF/Ny2ZpqSwpsw61UkiSkASMq691CKLDBNv84dc/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RAwQBhSO3MszUCA590xzPvARzOxFBl0wh0cp38McyYF4VEi9syYpEiGxOBI53DpoogVY84xFGYEE1t1cg0PhVACl+/YAE8bxefvu9SoVmLlYS9Oe6z4eTvnvpJExkayjXDL2wtn3/Enaw70CAARoqw5kOl/NyfIEhcnc4hX5obI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzTNUPk4; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4256KIhY014638;
	Tue, 5 Mar 2024 09:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=vOpF/Ny2ZpqSwpsw61UkiSkASMq691CKLDBNv84dc/c=; b=Uz
	TNUPk4v51mqyvjkGyQ1RIHf2Gf9/p1wb4h+vQdG5zW6kDEeswUbnnQhnkZ1N9N6w
	l9NFzy1WFAioqWQTf43AAAoVLMOnTS8H94uEiiq94yX94aT4+Ni22EWldr3yNlG+
	KptMWoOwFW8o8JFNPUbrUFtbtvO5/eREFcIMQZp/0I+tBGBYl3GVwh/pK0IRyt0e
	VltMXipNnlI+EBXeMG6XSM0ZMAQyFPGMUOULEmwlr5a4NwFtr9QouBXOkftYGSmb
	G+7aGO6OLD+AckZwkZt7ikFOuu6zOKbmNCHpNOQqcywfAz3FnbFPXqnPCGYZ01g1
	xHYbTpj0jFvnvmGX/OOA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnx0y0ah4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 09:05:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COHiEgmeDb5u0QeZ/R7dPT9wX7Zw40Nj7lFtc6x9NAwuFa9dxvIADLIc0lM57jkkdKahTkA3L9sAhWFf7aKzU0bSc1iu+nxmEgo2Ypq6k8T2KJrSD4GR/2LejeJyayQ536y06Xhc9DGp8nmewxoMfeadO6UYLmb0ZVawIrBhwitTfrbe6X0SugjIN4MNF04uNhxeyMH/t2vO9pf/dqZlhM/QApMwC6elu8OBJIYf8AKWePkXnO0wfLohIiio5QnO6Q+YtSHEXLLS9vu881w6gM3qDeGNhHU5T417b6esblWX5AgUgtGmJYdqcZm0blZ7zao8F7VoPxZZn6pU/znKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOpF/Ny2ZpqSwpsw61UkiSkASMq691CKLDBNv84dc/c=;
 b=K+cxodo0QCPH2uDoe5XxR5OOVEyzJUcqoBW2UNyQLr9QIol/TtFc+tbCrhOBPScPTptk/HMB7m0K4aT0GKTxi0AYMIY+BCpcDTyrVc4unYo4fwgQglrBWES6JFzNXjFcK5ZELLXEATpv/NncCVGk99btv9E6v6s1ukZnACoLRKYwkSBqhbtWqPAxj7x8snursr1g+QwwbR39aTPJqloduwoomex/59kGDZe2Jp5B/JrOsMqKfyuCqvbm7o1ySgik+WkxWemJkgKePZBVvIe5EW7bqzwffP50L5bUh79L8W+gO0hbu74CbWug6PCQvMGnuTr4x9euNKDH9xfpgAPEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CH3PR02MB9068.namprd02.prod.outlook.com (2603:10b6:610:148::7)
 by CH2PR02MB6695.namprd02.prod.outlook.com (2603:10b6:610:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 09:05:40 +0000
Received: from CH3PR02MB9068.namprd02.prod.outlook.com
 ([fe80::60a2:66c7:d1d3:966d]) by CH3PR02MB9068.namprd02.prod.outlook.com
 ([fe80::60a2:66c7:d1d3:966d%2]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 09:05:40 +0000
From: "Thiraviyam Mariyappan (Temp)" <tmariyap@qti.qualcomm.com>
To: "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        "Thiraviyam Mariyappan
 (Temp) (QUIC)" <quic_tmariyap@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: ath12k: remove reserve member of wbm completion
 structure
Thread-Topic: [PATCH] wifi: ath12k: remove reserve member of wbm completion
 structure
Thread-Index: AQHaa7m1Rs3dK6hLmkGP6XnJWaCf2LEjGnMAgAXE2iA=
Date: Tue, 5 Mar 2024 09:05:40 +0000
Message-ID: 
 <CH3PR02MB9068432A870F6DE95DF54243F9222@CH3PR02MB9068.namprd02.prod.outlook.com>
References: <20240301091936.12054-1-quic_tmariyap@quicinc.com>
 <6a91daf9-76ea-4379-8b12-1b9cb23b3869@quicinc.com>
In-Reply-To: <6a91daf9-76ea-4379-8b12-1b9cb23b3869@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB9068:EE_|CH2PR02MB6695:EE_
x-ms-office365-filtering-correlation-id: be2218cb-7666-4c92-2d90-08dc3cf36e4c
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nmSk3RBAa0v1QrdWSEn/v9kA3VmVyJBqh4Num+zEZaBKZSEmq3/KFztO/hN1f5XdnH9yy1sRdgmnUy6wtSmbw5Egw9swkqJYJxY+6fiZ4hlnNzJihf2KDHlvueD3iYRyBJ2+WXHdUbqXJMGSI3QSyt3FE/qlUEflUUlu364sw79eK4BGbrqv8OVw7kh9xKXcOKS7dEPb5uWVjl2yBWlKQiUtj9QitvDQRlRebSq2R8KXhbCR199VeddiygUpXgqhcxfZKgSoUbGs4t7yt11PXCy4dyoB9CY4o4qWYQIASftVD/xWboeyHZAaWDzsiLDNawqrzJddkBCpg9PPsPnRoqtLucpR7uv5S3swRlRideFucrvudYZOHhQYq1Sa7fyR4oml3X2n5aCxx9VsfBsz2yW2JHM2dGK9sCZktCIn3KHL58ThUpslu4OxqaFttzwVLxefic1F8P2gtM1zbc88jm6SxnPEe2IHt9MvDOsLYJZrxHwFh4vqQqSjpkXKzTlfjwHfiJUpmkRUr6Mmr0iZto1qW4aZhDimmNzAdeuVTocu7BZyRA0sw8W2feIUThX+949FdcyCIHqxsEPbq+A8Jhru1fk6bzpYrxGFFuWf7YP2q2KiVtev9eKWP4PjvNQmd/Sdtg06zk8RRZV8kgx78CC0TyPEvQxuT8PYEZG3Bv0FFQGWwVW3CKxxbLYhsVhM3GLISVZ64o045UdsEukksA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB9068.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?b1M4REJLRHd2ZVVPb0RFYlZSOUlvWHNGbWozd0xOL3lJaXpWVXF1NDIwMXdh?=
 =?utf-8?B?VWFGdkhKbTVMUjl1cnI4bjZjVmZZSFZZV2dMWCszZkloYWE0YXV4S21Rb2Mv?=
 =?utf-8?B?bDR2T01oNFFzT2pYMEQ3eUdRUytDUWtzZzAveDdVUmQvQ1REYW5vNURFWk5R?=
 =?utf-8?B?QjdFMVlFOGpOeG9sYjlXOEtZcHVsNFlPYmU0WEdneVZwY0t6bjZkZ2ZMb3Bz?=
 =?utf-8?B?VlIyRFg0REwvZ3JwOWg4K05PaVZVSVhHZjFvVFVyRlB1bWpXb3RVd1Z3b1lB?=
 =?utf-8?B?TEcyZnlVY2FlcmZHdktTNHd0cFJ2cU1CaVlrUUhMb3dXTmRzTEg2SDlSVi9j?=
 =?utf-8?B?YlFrK00xaHVLQ2s1K0lKMTVEVlA2aXd2RnpEaHZtVVoyQjVWM2ZKVk55ejNa?=
 =?utf-8?B?ckh0REFDNGx5dUl2QmtmbnNsUFNkWVU1UzM1cEw3L3M0djBEMU9DTU03cHVM?=
 =?utf-8?B?MnhpUTZHT3o3eVBpY05KSVBGMjZvUC9jWTFMRVhabFQ4Y0NvcVU5dVN1b2Zl?=
 =?utf-8?B?NWVtZGZ4L3IzK2FVeGg1VkNjRXlqSGVxYkxMbklYQVh5TXdxR3NyYXpZQ1lk?=
 =?utf-8?B?VzRzYVgrQmYwRnlzbVdWTFVuSXRHQzNzc2xCYi81cDJmZDdJcFI0bk1IR1VU?=
 =?utf-8?B?UW1DbW56Y2xHTTZKcmdIcU5RZW1rbHdZOWVWMW52ZG5KUloxSEhXT0Vma1du?=
 =?utf-8?B?akxJT2dPZVdCSG5TdUMyV0p2T1BLQ0dnUkhQZGlCN3BydTlZZlp4bWlLTlZX?=
 =?utf-8?B?bER0ZG9FYzJldlBlL0lnQVBpb00vdUVjbGVrTURvMHlaNXRSZE5VaExGTnZi?=
 =?utf-8?B?bXBpV25tM21ZZXV5WkRUUGF6c3NxbUVOTEpPVThFWU5xclBvb05yR2kvdEp3?=
 =?utf-8?B?MnFhREtjNUoybWlNcVViWjJ5VG9oeXI5UGlVaXExNEM5TE1lTWNodkpkUFlQ?=
 =?utf-8?B?Nm5jNnNjalZweEtrZUljeUQ5LzZ0ZTJ3bGg0Mm5NRmNMQ1BQYnl4S0NjaDZn?=
 =?utf-8?B?RGNvZ1BRN2xWZzJyYjRTd0lCWHhXWS9SM0tITlFqbmJ4eGJTVXQ4TFpGNEw3?=
 =?utf-8?B?RXlxaHBaSWwvUzNoRVpmdy9LblhHclpDVExvRjF2RU5QWjQzdjBkeWErcUFw?=
 =?utf-8?B?T1VhTVd1UUVQNk9TN0paSnpxcmpuWVNIL2lpV2x1ZEFTdWNXaW9YZjhUc25o?=
 =?utf-8?B?NkdhZkRvTktvR0FSTTNZWGNpMEh0QmU5aWFkZEVJOHhkYXR5S0FFZGRsT3lQ?=
 =?utf-8?B?SlpxdXpBUkFSS2RtRzNIK1V1czlGcGhxTExCU3luVXZQQmsrQnhLbmF2QW1q?=
 =?utf-8?B?WG1XNGZkTE9yd0w4aS90MzcyazhrZlkxSHFRc215OTNjdnd3dUZxNWhIRk1E?=
 =?utf-8?B?bUIzL2ovNXR5NUxoWW1zMnRlTDVBQXNNMFVJTldFZVptdVVRMnovZUpRNmQ5?=
 =?utf-8?B?eDkvZzdzcVpFVzE0RlUzajR6YS9kTFRYQnF6ZDZmTWdLOVJreEdMSmJMOStu?=
 =?utf-8?B?N3NKbXV0b2x3dk9Fa2hRdVNFb1hTU1ZncmNrVjZ6MkNnMk81dVlqcW5hcnRZ?=
 =?utf-8?B?NnRPdWJDa2VmQWlZckhWdWhPQmZVMVJVOXBhc0M3WjgvS3lxSWZvQTZtV0Js?=
 =?utf-8?B?RHBLRldPcXYxS1lVd0lueE5BMThvY1lMdWkzVlhWSmt0RWVQTkIrMW41aExm?=
 =?utf-8?B?aGtkY0tGaXVzVVNsOXBCOWdQODdwYmRFY0lqYUUyL1RMN0F6OGRrSE9venUy?=
 =?utf-8?B?VncrTG1zSGNFSXlTeTJUOHN0eFVvenQ2Rzl6bjN1SzVHU0tKMnhvaGhibHdY?=
 =?utf-8?B?SEl2S0hvaFE4S3A5V0VmbElXcitCeksvRFluMDkyNWthWElML2VjSk9WT3d5?=
 =?utf-8?B?Tm9vTkVqZEZkTDBCZXR6bktYNkt6ZzlQUEcrZGFVc1ZUVm1HRVVHMEhwTEFt?=
 =?utf-8?B?TmRmMUFFSWErMXhzU1BoNjBqd25ON1I0UkFGeWwrVHVSbEgrM1dac2xZdkZP?=
 =?utf-8?B?bEg0Z0RnM3RnSHdJVVlpOEdxUzQ3NG1HclJnSlFlK3NGNHVlcy9rZS91a2F2?=
 =?utf-8?B?dko5d0RxVUFUcG0wd0szRWpSTEF2b056L0xzaTI3cHZIWUJRVWEwVGhmZ0tI?=
 =?utf-8?Q?dHV2PdAkGqGBIU2o7m7U8dCU1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nfRKv4hSN15vuT75m0stQbUf5WPVBhkcoZHyxdUBTEpK7zQfbF6EW0kBNzjM5B6ln2cLCD/E6BgmHo4pU3Gx5VgbMnw88X0XFclzlvd6pjytq3ufjQWZd/x4KzXbNkeTTh5K/xK/85otLDjswr383uMqHnAFpgmirKTrTtSY/x/X89pJaDH2vGF91SjOjhWIVrL7E4yEyCzPAkJSqkQ0zEZq8ictbPUqLmVnq+WpRUlPXWwuO62a8/OJqOGyY2Q+8NBiEER9IKW1SSlgLsaRfsDhjvXhEeZd5KZv7Oj4B3nLE2EKIHHxGE9lP/EUB5hV+9PAm+ma+Jo4sl6C6jnPz66Q4JjaVGuW/yiTSp8V+EL82GF1IMMgE131NY47jSlaKXu6H6NC0uNBc5haQhlY5V5+3ZOoNyBn6zyeSLXHZmxMZJgth0DNK0WqNdtXHCR3RThsGTnyFyOx83n63Kkv1D+n+hcaZ4CAwDNDVGgA9qn1PeS7/npehGrB8Ci+3jgTrfDyAzO4Dh3kTxQ+0csdFuxn9+5vzv2EGWx+xDehEfuUafTmx/YPaBV+Ih3U0onsg80TUCDUFPN/QXSzB7y0il1bnksaoOL9gg5Uv/9IiLJlHG8qkpSA6Xq194DNgtOu
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB9068.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2218cb-7666-4c92-2d90-08dc3cf36e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 09:05:40.4616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OY9zLZ5feGFDfz5I4SVoOrTfMrK8z2xkCMEdcXiOfQfng6111uylwlP/xhNHrDumiTl6z3bgdHMI6KhUuHHLKHsGWnTSm0Mzey1eV8h9YU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6695
X-Proofpoint-GUID: JO5fgh2n4pgyFH4Dri17QOirBztCanIq
X-Proofpoint-ORIG-GUID: JO5fgh2n4pgyFH4Dri17QOirBztCanIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_06,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050071

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEplZmYgSm9obnNvbiAoUVVJ
QykgPHF1aWNfampvaG5zb25AcXVpY2luYy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMSwg
MjAyNCAxMDoyMyBQTQ0KPiBUbzogVGhpcmF2aXlhbSBNYXJpeWFwcGFuIChUZW1wKSAoUVVJQykg
PHF1aWNfdG1hcml5YXBAcXVpY2luYy5jb20+Ow0KPiBhdGgxMmtAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHdpZmk6IGF0aDEyazogcmVtb3ZlIHJlc2VydmUgbWVtYmVyIG9mIHdibQ0KPiBjb21w
bGV0aW9uIHN0cnVjdHVyZQ0KPiANCj4gT24gMy8xLzIwMjQgMToxOSBBTSwgcXVpY190bWFyaXlh
cEBxdWljaW5jLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUaGlyYXZpeWFtIE1hcml5YXBwYW4gPHF1
aWNfdG1hcml5YXBAcXVpY2luYy5jb20+DQo+ID4NCj4gPiBJbiB0eCBjb21wbGV0aW9uLCBzdGF0
dXMgZGVzYyBvYnRhaW5lZCBmcm9tIG9mZnNldHRpbmcgdGhlIGFkZHJlc3MNCj4gPiBmcm9tIHdi
bSByaW5nLiBIYXZpbmcgcmVzZXJ2ZWQgOCBieXRlcyBpbiBzdGF0dXMgZGVzYyBvZmZzZXRzIHRo
ZQ0KPiA+IGFkZHJlc3MgdHdpY2UgYW5kIHJlYWQgdGhlIHZhbHVlcyBmcm9tIHRoZSBpbmNvcnJl
Y3QgYWRkcmVzcy4NCj4gPiBTbywgcmVtb3ZpbmcgdGhlIHJlc2VydmVkIDggYnl0ZXMgZnJvbSB3
Ym0gY29tcGxldGlvbiBzdHJ1Y3R1cmUuDQo+IA0KPiBXaHkgbm90IGluc3RlYWQgcmVtb3ZlIHRo
ZSBhZGRpdGlvbiBvZg0KPiBIVFRfVFhfV0JNX0NPTVBfU1RBVFVTX09GRlNFVCBpbg0KPiBhdGgx
MmtfZHBfdHhfcHJvY2Vzc19odHRfdHhfY29tcGxldGUoKT8NClNpbWlsYXIgdG8gYXRoMTFrLCBy
ZW1vdmVkIHRoaXMgbWVtYmVyIGZyb20gdGhlIHN0cnVjdHVyZS4gV2lsbCBjaGVjayBhbmQgYWRk
cmVzcyBpbiBuZXh0IHBhdGNoIHZlcnNpb24uDQo+IA0KPiBUaGF0IHdvdWxkIHJlbW92ZSBhbiB1
bm5lY2Vzc2FyeSBvcGVyYXRpb24gaW4gdGhlIGRhdGEgcGF0aC4NCj4gDQo+ID4NCj4gPiBBbHNv
IHRoaXMgcGF0Y2ggaXMgYXBwbGljYWJsZSBmb3IgV0NONzg1MC4NCj4gPg0KPiA+IFRlc3RlZC1v
bjogUUNOOTI3NCBodzIuMCBQQ0kgV0xBTi5XQkUuMS4wLjEtMDAwMjktDQo+IFFDQUhLU1dQTF9T
SUxJQ09OWi0xDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaGlyYXZpeWFtIE1hcml5YXBwYW4g
PHF1aWNfdG1hcml5YXBAcXVpY2luYy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL2F0aC9hdGgxMmsvZHAuaCB8IDEgLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9h
dGgxMmsvZHAuaA0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9kcC5oDQo+
ID4gaW5kZXggZWIyZGQ0MDhlMDgxLi5kMDFmYzBiMGM5YTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9kcC5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvYXRoL2F0aDEyay9kcC5oDQo+ID4gQEAgLTM4Nyw3ICszODcsNiBAQCBzdHJ1Y3Qg
YXRoMTJrX2RwIHsNCj4gPiAgI2RlZmluZSBIVFRfVFhfV0JNX0NPTVBfSU5GTzJfQUNLX1JTU0kN
Cj4gCUdFTk1BU0soMzEsIDI0KQ0KPiA+DQo+ID4gIHN0cnVjdCBodHRfdHhfd2JtX2NvbXBsZXRp
b24gew0KPiA+IC0JX19sZTMyIHJzdmQwWzJdOw0KPiA+ICAJX19sZTMyIGluZm8wOw0KPiA+ICAJ
X19sZTMyIGluZm8xOw0KPiA+ICAJX19sZTMyIGluZm8yOw0KDQo=

