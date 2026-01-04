Return-Path: <linux-wireless+bounces-30320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0508FCF09B2
	for <lists+linux-wireless@lfdr.de>; Sun, 04 Jan 2026 05:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08A36300BDBE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jan 2026 04:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F315853B;
	Sun,  4 Jan 2026 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uf+PeTSA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B13C38;
	Sun,  4 Jan 2026 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767501945; cv=fail; b=XgP/ERUdedYrRnyZbqtUWFkzlnl+sZDQ58FUPuY7Sj6z6KpnaJ17EAmb6n9EJYrtenkQXKuxoGfuTH90uFSfUeOpnON8tcdBEbp2o4cU6YTId3MhpTFW4+vTdWEkkg7eyu963Thf2VDyUcZlaEZMbq34Xmve+j3OfqsC6/8Yfx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767501945; c=relaxed/simple;
	bh=oYhiHRUObOTFn5m02ZcbShTIvzBET2moC95AEpoOS3M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANIBY3d5r/LBoJC1RcwJf4E/Sdme647ZHsl+mG2D/bDM2BgEsjraikt24lOSivcK1njRznkEtQPbE/HGUMnlq1DDF4kAF8SFr0qvwzj2HBOzsP7WXs7dM9nv1ZTbw+dGbIJ1+rHD6rU/YYuf6wQY2n9kGZ2+hsZr2+fM+eJz5Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uf+PeTSA; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1Pwh1qlzi5AL4af7JhjLAQrejI0pjBWqD59jZRMuZGv1SyeBioQ+HUZdQAMqhiPXHTppoQ8G9k6E+qmdwb7zZHP5LPKwYUv+yJ6psMU2peEAK0udgaEVHHVjPbE2z9ODgYSzmcPssZMhNnpiuggm/L1FJU0rmyEVK6V3oox1bHXGM6uz/WGh0Cb63nmNO0pZCzkoPShvQMsUvcuNCk1Is1Ot2Ku05UyMBgQoH7iDEzHf3rELhnKzdNKWFsAbHIdhKg0JBqA0b7dJf39omWBWRVkTSW07OD7edjCKCTNoTgXHYZmjd3t+KxjzblCsMHeiYdvOHz+8Vq0B7z/JMXw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzDUVWwjA7vocCIA8Q4Fyytg/kqV1lq0BmyzRADVeyM=;
 b=izxvsFT4jgdFOR6R55UMkhbh7xJG7WCZAMtSKVWdpHejyn5uLbzeL7/wuX4DHE36CPpPJa9EjYoeFNZtV3QxR3m2VV+Tae9fJmmod/jhXzTlZb9zCma+2Ex9khz/r7oT8PtbrXiW+oerzykwKqsYFTglcMW8gmuHHirJHNAXEtJ9eNm4RMpu9zy1rljoZixKP+3GDmkWwiiNNuXw/Zc4XQJVzLgmynIsqof9r0LITNUeE8LNKf0Pa6dC/wMpVtZmR4gy395YNQc+ryvbGEcQtFLJGgIPs2nQx+YfANvfhCAQxhz+YgCPPxKaI7smZdj0Vf2z+FEaIzgzNkhg1Fs7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzDUVWwjA7vocCIA8Q4Fyytg/kqV1lq0BmyzRADVeyM=;
 b=uf+PeTSAW2hNXE2pO8oACmlNPLw6a5f4lGnBM3SVussZ3ehmXSVhbdgvrNQwUcp1V+RofdJJO5nctGgIVluK0LcP6F5IyT49+gCSpWSU5Gh/3qkliLC13GTG5yfoBdXTY1ekiGsALi5UPzpCTwKAxsIHT6t2+TN2W66PdFM9QlWf5DOhCYHbTY7tao+ienHXQKG9GgEaUFcK565mWNKJr4kSjqoNEAsbsA51tMGwFsW5wwJoFxxL1TUg9uTaMUgzez+MSDF3Io/bvgDLZQ2HZ5ewXjUilAMpkamu33/FX2YxZpCbxjD6LIMPDEf/TbfTKtUKUfiHYrTIwNr1gCQXIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 04:45:40 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 04:45:40 +0000
Message-ID: <f265b442-30b0-45db-8149-786f30bcc613@nvidia.com>
Date: Sat, 3 Jan 2026 23:45:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] RCU stall in mac80211_hwsim during clone() syscall on
 6.18.0
From: Joel Fernandes <joelagnelf@nvidia.com>
To: =?UTF-8?B?546L5b+X?= <wangzhi_xd@stu.xidian.edu.cn>,
 linux-wireless@vger.kernel.org
Cc: paulmck@kernel.org, johannes@sipsolutions.net,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Benjamin Berg <benjamin@sipsolutions.net>
References: <37b368f9.92b3.19b87161d5b.Coremail.wangzhi_xd@stu.xidian.edu.cn>
 <c92ccb99-3766-46d3-8a8a-1e8a6cb79d07@nvidia.com>
Content-Language: en-US
In-Reply-To: <c92ccb99-3766-46d3-8a8a-1e8a6cb79d07@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:208:178::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: fe50f25b-4e72-4677-b63a-08de4b4c1c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEFqQXRKcTcwaGFwMWhSOFVZS3B2Q3hjT2pTeHQyd3ZnRTU3eHhJb2ZCRDdI?=
 =?utf-8?B?aTlqeFdDa1d0UEdHZzRkeGRGemFlUk9wUlNvTFVOSE55SVBxMUlreUs0M01w?=
 =?utf-8?B?RFc0dDZybEZtZjNzTUhZQW1jYjdWcGRXYWFCdVE3QTBaYklydUtneXp0VS9z?=
 =?utf-8?B?ZzRpWWFqWkxCemRXVyt3Z0JEY05SOWdRVTN5bHY0MEFaK0MrNS9UVmRqZ1du?=
 =?utf-8?B?Q01ESFJJYW1QSkx3TEp0QUpveWZuUXpxbmQ4dU5VVkx3VnZrQmxjZ1FQZHBC?=
 =?utf-8?B?enVKekwwSkZVYzJWNUNqUzY2MG9VU2hDYUlqalVWU2xXUTBxZUUyNXhKMzg0?=
 =?utf-8?B?SU1vYVFvbGJBdFZqYUNYVk1DallVYUZIYVdBYnNBTGxwY0ZJL0JqL01uRXFT?=
 =?utf-8?B?WjNpQk1oVlFXZXoxOUlWRlcrNjU1MndhVkhsUUxRQVpucU1vZWJJbytrd0pw?=
 =?utf-8?B?WUlaZ1MvTTczck1tbmVDQmRQaFRndlkvaVMrWlRsNldzc1FNTzBtanRhNHBJ?=
 =?utf-8?B?NCtlT0dOU053WlE1TEQxR3RXMEpHZU1RQVl4emx3WDVUeFp2WUNpaUFNMzVp?=
 =?utf-8?B?UzJ2WGhudjFGRUJqRUVOT3k2dGxqN1ZTcm5PaWpjSEJsMTBoeSsxZDBOK2py?=
 =?utf-8?B?V3cwcW1hQ1B2aVUxZDF6Uy9mdjg0c3ltOTJ0clY0cFpieGJCcGpyRmF4UGh5?=
 =?utf-8?B?SFhHTUNZMUE5VEcwdGhOWWhwb2FVa0hjc0RPWkpaTExDcVd0blkrVGlpYzJ0?=
 =?utf-8?B?TEcwVzMxRkZVMjBBSHJaMlEyRUo4WWlMQkRxOUQxS0pxS25CV0tEUEJPK3FO?=
 =?utf-8?B?RjV5bVdCSFhUblJoRVViQk53Q3JpMExncHFDd1hRNmZvanV6a25SY2Ziejc2?=
 =?utf-8?B?dEorZTJpSUFNOWR2ZWFWMS94bUtIc3hHWGN6NHpCVTJwMnVLL1RpUy82bExm?=
 =?utf-8?B?N1ZLaEFRWVU4RFQvNldHMnFPZUxUTDVoNEQ4VEplSVhCNUlCTzhxNUlRcGx6?=
 =?utf-8?B?TEVKSGlGQmt1ZUNabFlWYWE4c3JzSXh1YXRrV1NPbXloVS80QkpPSUdPbVdn?=
 =?utf-8?B?Q0J0dGRiSUV1RnRLUXo0VHVKeThmYktWWW8weFVJOEUxK1c2Qk9NcTQvODNF?=
 =?utf-8?B?dXNtZkpTcE5JSDhkd0pWbUJXZnpEK1UwY1kyQmExaFdtVHdDUzN2MzFDWisr?=
 =?utf-8?B?Mnlvb2Y1Z0NYYy9Od1lncGNaMG01RmZhZVBlMzF5bUhPa0dIOW5LQjNoNFB2?=
 =?utf-8?B?a0FKMS9lTjdHbjVzRUJWY05WcmwwK05IaTR3RGZCZzNJOWxtcUp3NXlCMThm?=
 =?utf-8?B?MVB5K3hnQXhvcjIvSVQ2LzV6cE9MZ3IyMkhBWWZxaFRiTkZrSFgwL0ZweTdC?=
 =?utf-8?B?cUxsNENsYXhFclRPNDVMYzY1UlptTEJTVjdYakU5aTNTOW9tK1VXd3pqOWZn?=
 =?utf-8?B?RkRUNHJTK0tTeXBoMVV3MjRvQU5Eb2pGTkM3Nk12Z1JMTk9sT3Y0WG5XVEpC?=
 =?utf-8?B?d2xMc3VFNWU4dXUrcTRNQ0l5eUNSekFvRWx4cStQWXVqaEZCajNKd2tIdUtN?=
 =?utf-8?B?NGNUQ1ljaDU0NWFIbk93M25acENlbjN1NkFLd3BFUUN2bi9XZ0J0ZE1mZEg2?=
 =?utf-8?B?NUpMTVJLdGFEMWJyay9xcENwN0hTRTR2MUR6cWZ1Y2lIc2xHdzNMYXZQQ2ND?=
 =?utf-8?B?Wm13endyMlorTHAydDkvK3k1N3FKZ1E3MFlyUU9pYzZQT005R2x0TWJ2bXlq?=
 =?utf-8?B?a0wyeVUxdmk5cEFiUUVtSnd3RTNvY0JLREZ2Y3hhbEhCREwwVFRLeThpVi9U?=
 =?utf-8?B?Wmt1VXp4cnBERmUvQ2s2NFhNU092UUtsdTNEdE9wNHhyc3N3aUFJdHN4U3JN?=
 =?utf-8?B?dG42NE9hbXZXNldYTi8zVXZ4czZLZ3BCSm9ORHBmZ0RMTTBMMGRLWnc1QVNT?=
 =?utf-8?B?KzhTR3hPTitpLzR3dWkxKzFaRWVTQkk5Y3ovUVFIYUFzZDlQVUJqZCtjT2ZD?=
 =?utf-8?B?bDlnRVVxcDVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGtMeFNMWWt0YmhPK3drSFhWU3lEZFhQMFlqU3o5RDJjSzV4eHVIVzhZSWtS?=
 =?utf-8?B?TkZtVis4WTdkVVRuajF1M29ualdlcmNNUi9QVStGRkJxazIzZkExSVZWYkZY?=
 =?utf-8?B?WVBYSGdhSE5QSzZGU1orME5JSXJyMTRocVU0YXpoTUh5aGhaaS96eGwzem9M?=
 =?utf-8?B?OUpEOGdzQ2tXQmVLV093b3hqSlRQNU55cmlMZzBnNkJ2V0dqQ1lCWHhPbUtN?=
 =?utf-8?B?azE5OUcrMzE0TS9UYVpuUDh4Wm5sUGVZejVnK3UvS0FYc2tBOEh3THRlQWFl?=
 =?utf-8?B?MDBJdEVTWkNFdUtEd0tGWW9aMjF1UlYrZmdpVnJrZnVEUVRQL0dNYXVGcnJX?=
 =?utf-8?B?a3NrN1dvdzBpeUFGR2FYSXBLNy92d21wVTZsOUNmY3h5UWhSQUZJTi9WM0N5?=
 =?utf-8?B?UTU5Vm1ITkNyYTJleW5lUTh4VTExanNzeG9YVVZuRVZiNmd6NmRPQ1hQTTIz?=
 =?utf-8?B?eTRCbVF3RnBTUm94NDMvMXU1OFUvWEJzaGh2aE9NZWZ4Sms3d296by9WV08z?=
 =?utf-8?B?QlZuQzVHZFZHbkdKa0txZTY0T3JBdk8za2Vzb3FOSGc1Z25JaFZYS2JMdVAz?=
 =?utf-8?B?NXVORDUyQWcwOUduSEZJeGZxWEJ0aTlLZUJkd3ZYRjlmY3laOEZTOGRqejk3?=
 =?utf-8?B?aE1LUmZkUEhMbG9WQjI2VW80NkZqbGE4a1JzWFNRQUVRN2VqVDlhQlRpTGhB?=
 =?utf-8?B?TnZSYzNQTWhraThrWHE1azBiaHBOZlpzSlZRUlRTWkNOaDlZZFdCQXBPdU5u?=
 =?utf-8?B?eHk0TlNlU1FHOXBlSlhUSHdLbkRlajN2TzlnWVRtQ1J0RUtmWTRzTEhNUUpF?=
 =?utf-8?B?UmZuYWkvcG9CVURUWTMwK3pDOEtMRUlSL0d1K1IrWXdpWGJnMmRPY2RsUUFt?=
 =?utf-8?B?QXVZUTRiSmdqRnpDYzh5MDdMZlY1NHdDNnhIWlZXMEZkK0NqdFJVd1ZxRWJu?=
 =?utf-8?B?K09oWm5ldG1yQlVnNzE3MEI3QTNQcmNXdWFtdCtTeG9PS0VldDBneS9VbFNF?=
 =?utf-8?B?emJIdzh3dkx3azArK3lPeTJBdkpEcXJPbTJ5Z2xHZ29pdE0yYjM4RGRXOVpn?=
 =?utf-8?B?dnZuejRuZTdYMU5RYzU2T2h2bStjaVBxN2NyK3lhZkIrUHdhdDFuTlB2RW16?=
 =?utf-8?B?VmpuVkhYakoxbTNyQ2NqcDV1RnJNZTlXTnhhWExlbDI1NlQwZGlUWFoxSkZx?=
 =?utf-8?B?aXArZ01Ea0k3Q1h4S1lIMjdvQzRVckJSSW1TV1RGYlhPbzlGOUZMY3ZmSno0?=
 =?utf-8?B?WUZPdEZlSE1WY3lpQWVPaWs1ai9VSnhyR2tGUGxzM2dQOGF0LzVSVlUrMFBm?=
 =?utf-8?B?aWxEQ3IvZGt1TmYwRmtDZlpSMkJQYjIwb25LaHNqZkdMeXFvdGh5VUpjWmlG?=
 =?utf-8?B?VUZWdGVLdnA4ZmNWd0Eya2pxdWZNMTgzZGRYbXE5dVAyY2FaeWhXWjlYdjNO?=
 =?utf-8?B?OEhuNHhraFR4aTRrQklpTWdRRjNoUW1ZSS9xYjlORjFpN0Jvd3pPVnU0UnZO?=
 =?utf-8?B?ZzRBTFI4NjRSRHByU2xjSXVoeUtSTkM3YXVCbkFkaG1xU1ZJdlZrY1pGUkt1?=
 =?utf-8?B?d3lVZC9IbnFSSGxuRDd3cnpxbS9VMEQvZnBrVTZidlBGZ2pzdmdrTCtwSHJ4?=
 =?utf-8?B?RWlBN2dnaGJQYld5NStOL2t6cGNkNVlCaFFFVVRERVoyQnRXbXFZK0x4NVhx?=
 =?utf-8?B?ME9jVXZzY0pUTTVwZkJZRks3VTEzaVp4d1lrTzBQRnVyVVJqZTFmSEY4UlRo?=
 =?utf-8?B?V3pMVlpmMjE0RTgyQzR5b0FxNUR6dTR6cUQxRXgvSWNtOVFrQzJNSFhsVkVQ?=
 =?utf-8?B?VTU2dGZNcjFIQXIvNEFxbWlucjUyRE9RTjJaSnoxY0ErU1ZENWY3dVBYYWRa?=
 =?utf-8?B?MGVXTW1WNVdrcld6ejh3QjdLaG42S2gzUmlSVjNtVkM1cTdQZlRXZFVCOTJo?=
 =?utf-8?B?alEzMUh1NlYzQ3BlV214ZFJjYXJSYlNpa2N6cFhTeFBDV0hiczRPU3p0WnQr?=
 =?utf-8?B?V21PcSswRXVpY1ZndmgxeUpXcHE2YTBaaXgwS3dUTUR2aXN1UjBQa1Q1TkdI?=
 =?utf-8?B?aUJnb1kwd2lKTUgxQjlpOTFXOC9UQ1JXQ2Vzb3JuUjc0RG9nV3lTdjlGVThI?=
 =?utf-8?B?RGlsYlBzd1ZIS2hDbklvczg5UVArYUp2Um9FTURJV2V5TGtZTmlwQVRVTVFR?=
 =?utf-8?B?L2Z4QU8wL1BPN0p1eUE1OVdkeS94VHhqZ1JFU3owbkJlTGpMM0ZZb3YyVXJy?=
 =?utf-8?B?S1pHTDNvRjlRY0dlTTgvS3NQVkM4TEUxeUpXeDdJdVV0RWlFOG9xUS9qTlB1?=
 =?utf-8?B?OHFxcnArQlYrbURxRTMrVnhKRlVlWmdldUNXclZSb0ZxamMxM2orZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe50f25b-4e72-4677-b63a-08de4b4c1c5f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 04:45:39.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRiZjU5+3caYY+CvHfxbdnYZYMgjGYtt1IkItu7qrPcxhPw+qsCXfV7to9AOy6knMBWNglrfW2n8DE3obvZHkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929



On 1/3/2026 11:42 PM, Joel Fernandes wrote:
> On 1/3/2026 10:38 PM, 王志 wrote:
>> Dear Developers,
>> I am reporting an RCU CPU stall detected during fuzzing with Syzkaller on Linux 6.18.0-rc. 
>>
>> Technical Summary: The stall occurs on CPU 0 while executing a clone syscall. The task was interrupted by a timer softirq which then invoked mac80211_hwsim_beacon. The trace shows it is stuck waiting for a spinlock in mac80211_hwsim_tx_frame_no_nl. 
>>
>> Key Logs:
>> RCU GP Starvation: 10509 jiffies
>> Call Trace: native_queued_spin_lock_slowpath <- mac80211_hwsim_tx_frame_no_nl <- hrtimer_run_softirq
>> Environment:
> [...]
>>  native_queued_spin_lock_slowpath+0xae/0x9c0
>>  debug_spin_lock_before home/wmy/Fuzzer/third_tool/linux-6.18/kernel/locking/spinlock_debug.c:87 [inline]
>>  do_raw_spin_lock+0x20d/0x2b0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/locking/spinlock_debug.c:115
>>  mac80211_hwsim_tx_frame_no_nl.isra.0+0x6f1/0x12c0
> 
> This seems to be a case of softirq context acquiring a lock without
> spin_lock_bh. That explains the stall.
> 
> A quick search on the mailing list showed this was fixed recently:
> https://lore.kernel.org/all/20251128151537.0b4006217137.I688f8b19346e94c1f8de0cdadde072054d4b861c@changeid/
> 
> Can you try the patch and see if it fixes? Also CC'ing the author of the patch.

To clarify, my assumption was softirq context is sharing code acquiring a lock
with regular process context, that causes a context-recursion deadlock if BH is
not being disabled in this path.

 - Joel

> 
>  - Joel
> 
> 
> 
>>  mac80211_hwsim_tx_frame+0x1ed/0x2a0
>>  mac80211_hwsim_beacon_tx+0x56d/0x9e0
>>  __iterate_interfaces+0x2e0/0x650 home/wmy/Fuzzer/third_tool/linux-6.18/net/mac80211/util.c:761
>>  ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 home/wmy/Fuzzer/third_tool/linux-6.18/net/mac80211/util.c:797
>>  mac80211_hwsim_beacon+0x105/0x1b0
>>  __run_hrtimer home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:1779 [inline]
>>  __hrtimer_run_queues+0x1f5/0xb30 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:1841
>>  __hrtimer_get_next_event home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:578 [inline]
>>  hrtimer_update_softirq_timer home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:1193 [inline]
>>  hrtimer_run_softirq+0x17f/0x350 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/hrtimer.c:1861
>>  _test_bit home/wmy/Fuzzer/third_tool/linux-6.18/include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
>>  cpumask_test_cpu home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/cpumask.h:646 [inline]
>>  cpu_online home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/cpumask.h:1205 [inline]
>>  trace_softirq_exit home/wmy/Fuzzer/third_tool/linux-6.18/include/trace/events/irq.h:142 [inline]
>>  handle_softirqs+0x1d4/0x870 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/softirq.c:623
>>  __irq_exit_rcu+0x109/0x170 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/include/asm/bitops.h:202
>>  irq_exit_rcu+0x9/0x30 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/softirq.c:738
>>  sysvec_apic_timer_interrupt+0xa8/0xc0 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/kernel/apic/apic.c:2145
>>  </IRQ>
>>  <TASK>
>>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/include/asm/idtentry.h:697
>> RIP: 0010:__sanitizer_cov_trace_pc+0x4b/0x80 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/kcov.c:217
>> Code: 74 1d a9 00 00 0f 00 75 16 a9 00 00 f0 00 74 05 c3 cc cc cc cc 8b 82 7c 16 00 00 85 c0 75 05 e9 5b dc 89 09 8b 82 58 16 00 00 <83> f8 02 75 f0 48 8b 8a 60 16 00 00 8b 92 5c 16 00 00 48 8b 01 48
>> RSP: 0018:ffffc90002d47698 EFLAGS: 00000246
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82075ed9
>> RDX: ffff88802a758000 RSI: ffffffff82075ee7 RDI: 0000000000000007
>> RBP: dffffc0000000000 R08: 0000000000000001 R09: fffff940002a92c6
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0001549630
>> R13: ffffea0001549600 R14: ffffea0001549618 R15: ffffea0001549600
>>  copy_pte_range home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1284 [inline]
>>  copy_pmd_range home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1390 [inline]
>>  copy_pud_range home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1427 [inline]
>>  copy_p4d_range home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1451 [inline]
>>  copy_page_range+0x1c67/0x63a0 home/wmy/Fuzzer/third_tool/linux-6.18/mm/memory.c:1539
>>  rwsem_assert_held_write home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/rwsem.h:215 [inline]
>>  mmap_assert_write_locked home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/mmap_lock.h:76 [inline]
>>  vma_end_write_all home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/mmap_lock.h:347 [inline]
>>  mmap_write_unlock home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/mmap_lock.h:354 [inline]
>>  dup_mmap+0xd9e/0x20d0 home/wmy/Fuzzer/third_tool/linux-6.18/mm/mmap.c:1872
>>  futex_init_task home/wmy/Fuzzer/third_tool/linux-6.18/include/linux/futex.h:73 [inline]
>>  copy_process+0x36ba/0x76c0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/fork.c:2230
>>  kernel_clone+0xea/0x8b0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/fork.c:2609
>>  __do_sys_clone+0xce/0x120 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/fork.c:2750
>>  do_syscall_64+0xcb/0xfa0 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/entry/syscall_64.c:99
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f00649a6d07
>> Code: 00 00 90 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
>> RSP: 002b:00007ffe2d0a2b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
>> RAX: ffffffffffffffda RBX: 00007f006575d680 RCX: 00007f00649a6d07
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
>> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
>> R10: 0000555572e6d7d0 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000032 R14: 00007ffe2d0a2d80 R15: 00000000000e717e
>>  </TASK>
>> rcu: rcu_preempt kthread starved for 10509 jiffies! g98817 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
>> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
>> rcu: RCU grace-period kthread stack dump:
>> task:rcu_preempt     state:R  running task     stack:28520 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
>> Call Trace:
>>  <TASK>
>>  sched_info_arrive home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/stats.h:267 [inline]
>>  sched_info_switch home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/stats.h:330 [inline]
>>  prepare_task_switch home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:5122 [inline]
>>  context_switch home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:5272 [inline]
>>  __schedule+0x1044/0x5bb0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:6929
>>  __schedule_loop home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:7011 [inline]
>>  schedule+0xe7/0x3a0 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/sched/core.c:7026
>>  schedule_timeout+0x113/0x280 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/time/sleep_timeout.c:98
>>  rcu_gp_fqs_check_wake home/wmy/Fuzzer/third_tool/linux-6.18/kernel/rcu/tree.c:2007 [inline]
>>  rcu_gp_fqs_loop+0x18c/0xa00 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/rcu/tree.c:2083
>>  rcu_gp_kthread+0x26f/0x370 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/rcu/tree.c:2280
>>  kthread+0x3d0/0x780 home/wmy/Fuzzer/third_tool/linux-6.18/kernel/kthread.c:463
>>  ret_from_fork+0x676/0x7d0 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/kernel/process.c:195
>>  ret_from_fork_asm+0x1a/0x30 home/wmy/Fuzzer/third_tool/linux-6.18/arch/x86/entry/entry_64.S:245
>>  </TASK>
>>
>> Best regards,
>> Zhi Wang
>>
>>
> 


