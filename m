Return-Path: <linux-wireless+bounces-6490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298A88A9296
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 07:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3EA1C20B53
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 05:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB43653AC;
	Thu, 18 Apr 2024 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cEVswDv2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mtMI9T9n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B712207A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 05:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419324; cv=fail; b=g4AKz/aRBcGfzWHZtF2AkaYy4MX03IpwcG2fh11rUgHKyPk3e7IKTFsynVBg0ar3EBjugg+qsE3J773jH9jMAOqcBKLw05ow1WrAZ/ivj/RUHVqZwE4Vt7EMjzLrGzrokgj+90rDXvda64xtmNMrBKB8uvIwhalIbMB+mUeQiPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419324; c=relaxed/simple;
	bh=k322AULi5haGVX/syv8smYl/tRrGUJnT4f1SYcxzvGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gaZ4Or6VGmeo04RKNXANmKLUvEvpzYoU37uhZs+vkbhvefDVp4sBxKFstG3ZarKrE1xWgXIZZl6H77vfZCbL1l9R2uIJxCxrkGe94/AHRaVo8EjWLh3U1t2jyEMUHmDcrIFDc1Mqu/LQN0AFcSYri3hhD3QJWfK+Jt/SAJOSKNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cEVswDv2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mtMI9T9n; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4bd75476fd4711ee935d6952f98a51a9-20240418
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=k322AULi5haGVX/syv8smYl/tRrGUJnT4f1SYcxzvGY=;
	b=cEVswDv26EJYKWPGsfFtaUrgGnpu45RLigp7+V+NpVR+jmC3nOCvXJi7rdPeFFc0p15/sSOogNcFUyqLnXinds5dujl0wwjxM1v7ufYqdTTpaJHL4hKHvV4yZlq1mHaTemN7mkELg/6/oRljqLn1AVWP32+zk9eTrnv8ejg3ZjE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:26234605-5488-4971-a618-c6b68abb3990,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:63e05186-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4bd75476fd4711ee935d6952f98a51a9-20240418
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 493479048; Thu, 18 Apr 2024 13:48:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 Apr 2024 13:48:33 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 Apr 2024 13:48:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4MjoRKrnFBmelYmFpWt/b78xFxsyJVtWJFOhu4mUJKUyPeCjkRdbQN18befgRYmB+DuxiX0vqvqfRcGQbxiE2/GAuUH1ptlRSGsfXBEowgkttccrRzZjET/NoVFaLXBp3FNb9zQVtopj+CvjQoQMLf3S2r6KX3trw+PNsn3eivMKWQbwGhH2TpGatbkKjV3UG/WNPUu0rmIxVighmNq0NtjmLmoUHHh7ujiP9bYrC2TAWbPOOBNabhEXmboYzsVASaYF1/gLJPmvqj5JNvyOPXHGqS7DIzTA6vxedwVJOz4HV5YvfeWHGZfB3t4QdnfJyjMf5uK/Sg6TTrwV0zYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k322AULi5haGVX/syv8smYl/tRrGUJnT4f1SYcxzvGY=;
 b=liobD6YB1DDREy9x9xpZ12AZScvFDkGSMTQh8+UM0pkRYCFf7B3NiwdIRQsj2KWQ+av90RiSm5Pmquq/LSAudluEqLMBX9uuTzW/eZdElZEAMMN6VqyN8/E6QsWdOcgm2wzT/sExWDzRsyM704b5oFyWaIQ+Y806tUjRE08Wm5CkZOzAVZTI9XiUTOJv2iPWN1DJ7fy8Mk6RWU2GTGuJkr8eXr/1OYgUVjA7bOUGoQE7o2M4mHDTiK+nMBB1WVQJ2Y6qA2y3lKtdykE04KnNsPIwtSRAoOuLAgeY7rBUntFuVHn0pr1qJqP4CNY5BG9mit4MVFFN4yrFGCd7BPLdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k322AULi5haGVX/syv8smYl/tRrGUJnT4f1SYcxzvGY=;
 b=mtMI9T9nJI0Ek841G1h2aRRLBODya9ja+0JT4vx+6nEvrXvt7JkwSMIHcTjl5Md80sO3hr7ChtlFCIVEAhshETOq+jS3u3v98Z/8s88gAWFcbI20TnAmZKWnhJywM6akRkSzL5hFM1GlvDl8XNCPak/2DX/rllAWyaq5kLmcf/M=
Received: from SEYPR03MB6458.apcprd03.prod.outlook.com (2603:1096:101:3f::8)
 by JH0PR03MB8312.apcprd03.prod.outlook.com (2603:1096:990:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Thu, 18 Apr
 2024 05:48:32 +0000
Received: from SEYPR03MB6458.apcprd03.prod.outlook.com
 ([fe80::190b:9e74:203a:455a]) by SEYPR03MB6458.apcprd03.prod.outlook.com
 ([fe80::190b:9e74:203a:455a%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 05:48:32 +0000
From: =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>
To: "sean.wang@kernel.org" <sean.wang@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2hlbmd4aSBYdSAo5b6Q6IOc5ZacKQ==?= <shengxi.xu@mediatek.com>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
	"nbd@nbd.name" <nbd@nbd.name>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
	Sean Wang <Sean.Wang@mediatek.com>, =?utf-8?B?SGFvIFpoYW5nICjlvKDmtakp?=
	<hao.zhang@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7921e: add LED control support
Thread-Topic: [PATCH v2] wifi: mt76: mt7921e: add LED control support
Thread-Index: AQHai9HdodnicF9uoUmeIynVnLuujrFtD14AgAA8fgCAABLnAIAAMa4A
Date: Thu, 18 Apr 2024 05:48:32 +0000
Message-ID: <3f4a39624807091eec4c30b9521b40006b5906d0.camel@mediatek.com>
References: <608cc2bb1c10c2f53a6bf26711bf49fe2c491e59.1712806947.git.quan.zhou@mediatek.com>
	 <CAGp9LzqVGHGriqpC-NTnOtvNNz5o-hXD=HcTCptHfXBD9bnfPQ@mail.gmail.com>
	 <37ab8a32893ea9a1cbc33b6dae26b57127ea4e16.camel@mediatek.com>
	 <CAGp9Lzq6g8YQ=_eZHJX4qQjv-F2anGnPw8f88rHD2Vo1iwiGWg@mail.gmail.com>
In-Reply-To: <CAGp9Lzq6g8YQ=_eZHJX4qQjv-F2anGnPw8f88rHD2Vo1iwiGWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6458:EE_|JH0PR03MB8312:EE_
x-ms-office365-filtering-correlation-id: b78bc065-b1e3-42af-7d3d-08dc5f6b2e33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?U2dMUlBYS0JiWmxabVFDd3dXUTNMc0ZjOHlFT3c3MGFYNmJRTDkyQ1A3ZU9n?=
 =?utf-8?B?MmhvWGxKbktEdlZKWHBuRWJUYlpMMStTejgzSk01RFE0citlWFd2RURQMGtk?=
 =?utf-8?B?UXV1SWZMbGw3Ujk2MFZYVy8vaTdYQmZlSlFjN281UHdaVnp2Ry8yUHcwOEdV?=
 =?utf-8?B?L0pvaVFtcWVLMUR2YjBaYlF6dHExdFNtVm5KbzN4Q24wbEgxcHEwWlhVLzZP?=
 =?utf-8?B?VHB5bUVGZWgxRk11R1N5TG1CbDlMMnF0cnN1eElLYmpTSC9yWjRBKzczMStv?=
 =?utf-8?B?TTU1L0tUdXhLanR4MTdsVUwxYmNTcDZMb2l6VkVOU1Fnblc5bEdSbkFwWHBV?=
 =?utf-8?B?SEs4WkV2eWRxRGJ5ZnFyR0NNY1dkNXJIcDd2Qjc0QmVIT0xCV3M1QVJXQzNk?=
 =?utf-8?B?VTVEc3NtenN6bUFjZkozZElub3FpNjQzOEpnSVVHd3RIQnhtOEpvMUsvTC9P?=
 =?utf-8?B?QnNvQUFEK3lyZE85QkJPWllubk92MmpPVzBiUHpvT1NETUh4SHB1VjN5QnNK?=
 =?utf-8?B?MHI1TnI0UUZZWHRUTEVpa2w1RWhTcXFDblNYYjhDVFduNElGaFFyTVZEZEhz?=
 =?utf-8?B?TjlpSzNKMXJiVmlhRGY4KzRycnp4MG5BZWw5Wlowa1A2aFNjMTRic1FnNWhZ?=
 =?utf-8?B?SUorZEtYWE1Kb2NrZTQ0QTdrcU44MUJSNE8rWUdEc0RrV01BYlZ1cEpzaURz?=
 =?utf-8?B?Q09veXJkeS9VNmIxdzN2TVBJTTJPK3BQYWh4L1N5RTZXQUNsM05zVGpBeXpU?=
 =?utf-8?B?YjJIK2RzWVhSZXdCalNrL2g5a2gvdElmVzdKWjJBV3BIaVZrNnNtaXFUb21V?=
 =?utf-8?B?a0ZqRUQ1N3ZLa2ZHdlIvekNXMHdJNm8yVnJHYy9ta05DZGZ2RWpJUEVhSWVx?=
 =?utf-8?B?b2srWllTckpZTTd5RldWOFBab2dGWUVzSjFTV2FYMnpXTmVqWEJMdmtNRmFh?=
 =?utf-8?B?YjRwdW9KOSs3Y0FmK0lndTVIcGtucExNVzFZUHN0RW1yMTN0a25uVEdaRms5?=
 =?utf-8?B?UzhBKy9pdEdFWEVUZkptTmh0czdKUFNpMU9yZ0N3L1FpY2EvL3dyd0VnVzJG?=
 =?utf-8?B?M1pHbXp3WUJyajNwcit2aE5ZWGpSeklOblE1OU02emk0bm90NHlyZE5pYWQr?=
 =?utf-8?B?ZzJkV3Q2T1BpdDJvcnRTcnE2QmVFTnlvUDJUNi9vRnpUSHhyUm0yNHBQNHJK?=
 =?utf-8?B?WjJKV2RxOW9BRU1nRUNBbW1HcnBIV2tGRUlDQ2dhdVVHYlU5bXNCcm4wY254?=
 =?utf-8?B?RVpKZ2VaMUtiRXc5U1hEUVQrZDJWbUY1NmdVeE9IVTNyeWhVK0VqZHZZa3Nw?=
 =?utf-8?B?SXNYMnl4cUZRcXl6dURYL2RpQUxCNmNZQ3ZEYll1bUZoMXBxdURDVkJMYkJG?=
 =?utf-8?B?NzRkdDZkWkZTOWdCOCtiZGJyQlpqNHFtdWRiMEUvbWEyODIvNDhwdmY2M25l?=
 =?utf-8?B?V3g0SUVsdUdlNzd5QUxYNjE4SUJGWXlkcFBDalAwTFlleGtCeTVxekU4WUpC?=
 =?utf-8?B?aS94ejhvQVRkQS9xckFWaTlwT1dtNW5iNk5EcVc4NmZiZis0azB3VEQvNzd2?=
 =?utf-8?B?ZHA0L2NlUmdtd05uWGt0VmtDTU9OU3NncC9Sc0NIQlVFc0M3bnpsTVNzNUhy?=
 =?utf-8?B?SjNGdnJBV091NWZGandzdUtWczllQnJnV2hLSkF5TzZwdk5jVVljYXV1TlJX?=
 =?utf-8?B?S04zQjA2dVVVZjNUbnd0NWdMYnFZTWhvUWxNb3YwN2dxUXdEdS8zSUZWQXRp?=
 =?utf-8?B?bkhYSW5EeVhBWUdTU0E3cHlFMVpJRUlsWmprYjgxMWdZbHlKS1YyTmI2eUV3?=
 =?utf-8?B?RmhpcDhvYU1EOVZyMGYrdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6458.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzhqdWtjYTNZNm1CQ1BlRVhrM3JUWVpGYjFUeUVua2VJalNveWplU2hSOWRM?=
 =?utf-8?B?YmVleXczL3BXbmJPcXJ6TExnU2dWOHNGeUljbXBTZFlLU3BXZGc4eGhqVVNm?=
 =?utf-8?B?bjBDbWhUOGRkMytSc3Z2Um1welcveFhsU2tWNUp0dnV5bHFQS2RPOVVVMGJP?=
 =?utf-8?B?Skorc29ibkU2eWp3SU9EL0VIaDh5RDlRLzRlcHQxVkhlNXpVQmpTOEY3THFU?=
 =?utf-8?B?YmIxdHM5YWthMTBoMHNHclN1OXlQSGFUV0JrMmpYR3NNTVNCTGRGRHJBNTF1?=
 =?utf-8?B?S0czYjR5dXZZS3A1M3pPY2hoUXhwOUJOOCthUGRPUlVTd2hEeEx4QVp6OXNN?=
 =?utf-8?B?TXRRaXhJbWF6ZllFZkVDMnBKRGU3ZUg0Z1I5eFFMSUdRQ21YSHZzQU1qYTh5?=
 =?utf-8?B?WHhBU1R3SFNuK1NxQUExbTM4bk4xU2pHZGRER2NxVThncm9EMXJqbC9OeG9n?=
 =?utf-8?B?bHRaWlh0dnhISUdJTjZDUnBrblNoNFZBdnBhR243cThMa2I1d1lzUWZnZXg5?=
 =?utf-8?B?RG91a2w0Y0Y1NWU0UkxpaWdZQkJqbTM0UVM4K2o2aEl3d1c4NHhod1BGQVUw?=
 =?utf-8?B?aVJjQ25QSnJQYlBVTm1DQWlzeVcxZ3pUNXRmdWNuMlBjVmVBc2NMa3BCVld3?=
 =?utf-8?B?WU9oM2lLT2FFU29aZVhMbmttbHNJS0lxWlVHS1JiN0xPSnJVb2xqbmIwcGZ0?=
 =?utf-8?B?QzBVblk4ZjVvYUdxTzg2MFlQUUlSOEVvZmZ6ZHFCV0hOY0lmd2VsRHpSWjhr?=
 =?utf-8?B?R0V4ZEJhaDU4aWI2OTk5MnNZL0V4eWY2aUlEQjVCSldrQU1jb1lBb0d5U3lF?=
 =?utf-8?B?WW83RmRiOHhKMXE2WkYwRnJzb3VIcExIb2hpSjhmSlVUSitFS1c5ZUtXTFBU?=
 =?utf-8?B?N0RzSUNmN1JZdXBwbnFJb0VHQmE1NWVJYWc2OXEvMGZKUGxFWDdHaENRdnZq?=
 =?utf-8?B?amZVWUsvWnNlYlBpZUNIWnNDNm1TaVFHTXptM091Z1JwWllMSndoNWhFNmRu?=
 =?utf-8?B?aEg1VlNBV0JxaGJ6WDBDYm16R2dXdC9TRnd5Z3JMUW10VXM3VjU3enJrZk5F?=
 =?utf-8?B?ejdjUGhFZWRvM2wvL3hJeG9vZ0NXOXVZQzdvMGhSM2phNUQxQjVlbml6Y0xN?=
 =?utf-8?B?VEFJa1d0VGUreUFoRUlQRnVEbG1YTFpta3p0RFNHNnNhZWU1eHBsbGhyZ0Vt?=
 =?utf-8?B?TVdjS1VhSFVvMGFWMDZjcG5VWkgxWHdMMUVLcVRqaGxISWRjUSsrVmJvSVlu?=
 =?utf-8?B?MXUzVXgyelpRZldvOXJ4SGM0OUJLQ0NzU1FjMFZCeEp5SzE4NENMMWViSHpr?=
 =?utf-8?B?M08vN2VqTFdIZzFWVjdobWhseWlXMG1MR3YxMTZpNVJUWmt3c3ltc0pzKzlk?=
 =?utf-8?B?czdIMlY0c1pwbUlxd0IxUERMdjVNVDRnNWhrM2l4QUJXMUxEVjNObmoyUzJ2?=
 =?utf-8?B?eEVxL2ZHc052bi9vU0Q3cHg1ZTFQZmJoUGljUlVBbnBkUW84RkhkR1I2YlJk?=
 =?utf-8?B?bVIxL0tqcEdkenlNa1dOb1ZwZE1mN29YdzNUWU02U1UwSE1HN2JVT0t3dGZO?=
 =?utf-8?B?ekloME1jaFdEUUo4T0VVeStHdkJKU3FDUFBVZVdUOUtFdHVZbGRtcXZrYWUr?=
 =?utf-8?B?UzE0U1c0QXZYcXEvM3o1Zis0ajJoWk9uR25wdzIzelZpR3c5OWRQaTVPSk95?=
 =?utf-8?B?VHVwN2N4dW42M2Q0RjdSb3l4Unlta1VQcVl6SmpJRU1zN2RXWHU4Q3VyODV1?=
 =?utf-8?B?NUZOS2tFaTZhTXgrMGI4blp4bU91YTY5ZGVMTHlJUnA2WUZXbDEvaWxNWTNt?=
 =?utf-8?B?d2l2ZlVFZGpIYU1VRGNxRERieFYra3JudVE4MFFrNDl3bVhxL2NtZDBiWjcv?=
 =?utf-8?B?T0FmUFB6blV0eGJPaC9KeUkvMGY5anpRU1BUK29UalNFVkJoTmxPU2syeWdW?=
 =?utf-8?B?MmZURWY0L2pWYldtVTlOTlZBaGxTbEcwc003TkdqQTJFSkpVYnJGb2tqaHAv?=
 =?utf-8?B?MWRXMHFtVyt3OEdadHlDWVBpbE9BUkZrUGVadUZTZWNyQUMzWjhwTkYxNEo4?=
 =?utf-8?B?Y2xCYW9wTUNNTnVya3FsS3cyWi91d0pTdjMzWUFGaElnSUFLcUdIdUpKU1pM?=
 =?utf-8?B?bXhHenMra3FsVGQxMmJNblZHb2tUMlFFSGpldlUrZ2FiVmRhMkFRbkx3dFpz?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CE531478C4C4F40A82077ABF881D713@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6458.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78bc065-b1e3-42af-7d3d-08dc5f6b2e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 05:48:32.0691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9F3fVsSPhzLV1jRLux6rYjsmPOphuvCDPb5MVM5aWo0z7/yAYg/8s7PaIb8NhDPLXcPBomyKPfNRr/AJtRYBuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8312
X-MTK: N

T24gV2VkLCAyMDI0LTA0LTE3IGF0IDE5OjUwIC0wNzAwLCBTZWFuIFdhbmcgd3JvdGU6DQo+ICAJ
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiAgT24gV2VkLCBBcHIgMTcsIDIwMjQgYXQgNjo0M+KAr1BNIFF1YW4gWmhvdSAo
5ZGo5YWoKSA8DQo+IFF1YW4uWmhvdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24g
V2VkLCAyMDI0LTA0LTE3IGF0IDE1OjA2IC0wNzAwLCBTZWFuIFdhbmcgd3JvdGU6DQo+ID4gPg0K
PiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMNCj4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ID4gPiAgSEkgUXVhbiwNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEFw
ciAxMCwgMjAyNCBhdCAxMTowMOKAr1BNIFF1YW4gWmhvdSA8DQo+IHF1YW4uemhvdUBtZWRpYXRl
ay5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogSGFvIFpoYW5nIDxo
YW8uemhhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBJbnRyb2R1Y2Ugd2lmaSBM
RUQgc3dpdGNoIGNvbnRyb2wsIGFkZCBmbG93IHRvIENvbnRyb2wgYSB3aWZpDQo+ID4gPiA+IGdw
aW8gcGluIGJhc2VkIG9uIHRoZSBzdGF0dXMgb2YgV0lGSSByYWRpbywgaWYgdGhlIHBpbiBpcw0K
PiBjb25uZWN0ZWQNCj4gPiA+ID4gdG8gYW4gTEVELCB0aGUgTEVEIHdpbGwgaW5kaWNhdGUgdGhl
IHN0YXR1cyBvZiB0aGUgV2lGaSByYWRpby4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogSGFvIFpoYW5nIDxoYW8uemhhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiBDby1kZXZlbG9w
ZWQtYnk6IFF1YW4gWmhvdSA8cXVhbi56aG91QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogUXVhbiBaaG91IDxxdWFuLnpob3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gdjI6DQo+ID4gPiA+ICBmaXggdG8gYXZvaWQgd2FrZSBkZXZpY2Ugd2hlbiBIYXJk
d2FyZSBpbnRlcmZhY2Ugbm90IHBjaWUNCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4vd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuaCAgfCAgMSArDQo+ID4gPiA+ICAuLi4v
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYyAgfCAyNw0KPiA+ID4gKysr
KysrKysrKysrKysrKysrLQ0KPiA+ID4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkyMS9tY3UuYyAgIHwgMTQgKysrKysrKysrKw0KPiA+ID4gPiAgLi4uL3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTIxL210NzkyMS5oICAgIHwgIDUgKysrKw0KPiA+ID4gPiAgLi4uL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2kuYyAgIHwgIDggKysrKystDQo+ID4g
PiA+ICA1IGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzZfY29ubmFjX21jdS5oDQo+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmgNCj4gPiA+ID4gaW5kZXggODM2Y2M0ZDVi
MWQyLi40YzJkZTU1NmRlZTEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3Nl9jb25uYWNfbWN1LmgNCj4gPiA+ID4gKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuaA0KPiA+ID4gPiBA
QCAtMTE4OSw2ICsxMTg5LDcgQEAgZW51bSB7DQo+ID4gPiA+ICAgICAgICAgTUNVX0VYVF9DTURf
RUZVU0VfQUNDRVNTID0gMHgwMSwNCj4gPiA+ID4gICAgICAgICBNQ1VfRVhUX0NNRF9SRl9SRUdf
QUNDRVNTID0gMHgwMiwNCj4gPiA+ID4gICAgICAgICBNQ1VfRVhUX0NNRF9SRl9URVNUID0gMHgw
NCwNCj4gPiA+ID4gKyAgICAgICBNQ1VfRVhUX0NNRF9JRF9SQURJT19PTl9PRkZfQ1RSTCA9IDB4
MDUsDQo+ID4gPiA+ICAgICAgICAgTUNVX0VYVF9DTURfUE1fU1RBVEVfQ1RSTCA9IDB4MDcsDQo+
ID4gPiA+ICAgICAgICAgTUNVX0VYVF9DTURfQ0hBTk5FTF9TV0lUQ0ggPSAweDA4LA0KPiA+ID4g
PiAgICAgICAgIE1DVV9FWFRfQ01EX1NFVF9UWF9QT1dFUl9DVFJMID0gMHgxMSwNCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21h
aW4uYw0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9t
YWluLmMNCj4gPiA+ID4gaW5kZXggY2EzNmRlMzQxNzFiLi5lYTZhMTEzYjdiMzYgMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21h
aW4uYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzkyMS9tYWluLmMNCj4gPiA+ID4gQEAgLTI0Miw2ICsyNDIsMTUgQEAgaW50IF9fbXQ3OTIxX3N0
YXJ0KHN0cnVjdCBtdDc5MnhfcGh5ICpwaHkpDQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgaWVl
ZTgwMjExX3F1ZXVlX2RlbGF5ZWRfd29yayhtcGh5LT5odywgJm1waHktPm1hY193b3JrLA0KPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTVQ3OTJ4X1dBVENIRE9H
X1RJTUUpOw0KPiA+ID4gPiArICAgICAgIGlmIChtdDc2X2lzX21taW8obXBoeS0+ZGV2KSkgew0K
PiA+ID4NCj4gPiA+IEkgZ3Vlc3MgdGhlIGxlZCBjb250cm9sIE1DVSBjb21tYW5kIGlzIG5vdCBs
aW1pdGVkIHRvIFBDSWUNCj4gZGV2aWNlcywNCj4gPiA+IHRoZXkgc2hvdWxkIGJlIGFibGUgdG8g
YmUgZXh0ZW5kZWQgZXZlbiBvbiBNVDc5MjEgVVNCIGFuZCBTRElPDQo+ID4gPiBkZXZpY2VzLCBy
aWdodCA/IGlmIHNvLCBJIHRoaW5rIHdlIGNhbiBkcm9wIHRoZSBNTUlPIGxpbWl0YXRpb24NCj4g
PiA+IGNvbmRpdGlvbiB0byBzdXBwb3J0IG1vcmUgc2NlbmFyaW9zIGFuZCB0byBtYWtlIGl0IGVh
c2llciB0bw0KPiA+ID4gdW5kZXJzdGFuZC4NCj4gPiA+DQo+ID4gSGkgU2VhbiwNCj4gPg0KPiA+
IFRoaXMgc29mdHdhcmUgZmxvdyBpbnZvbHZlcyBjaGlwIEdQSU8gY29udHJvbCBhbmQgaXMgcmVs
YXRlZCB0byB0aGUNCj4gPiBtb2R1bGUncyBjaXJjdWl0IGRlc2lnbi4gT25seSB0aGUgUENJZSBt
b2R1bGUgY2FuIHByb3ZpZGUgc3VwcG9ydA0KPiBmb3INCj4gPiB0aGlzLCBzbyBjYW4ndCBkcm9w
Lg0KPiANCj4gSGkgUXVhbiwNCj4gDQo+IFRoYW5rcyBmb3IgY2xlYXJpbmcgdGhhdCB1cCBxdWlj
a2x5LiBJIGd1ZXNzIHdlIGNhbiBhZGQgaXQganVzdCBmb3INCj4gTVQ3OTIxRS4gSSBoYXZlIGFu
b3RoZXIgcXVlc3Rpb246IFdpbGwgdGhlIG5ldyBjb21tYW5kIHlvdSBhZGRlZCB3b3JrDQo+IHdp
dGggb2xkZXIgZmlybXdhcmUsIG9yIGlzIGl0IG1hZGUgb25seSBmb3IgdGhlIG1vc3QgcmVjZW50
IGZpcm13YXJlPw0KPiBJJ20gd29ycmllZCBpdCBtaWdodCBub3QgYmUgY29tcGF0aWJsZSB3aXRo
IHRoZSBvbGRlciBNVDc5MjENCj4gZmlybXdhcmUuDQo+IA0KPiAgICAgICAgICAgICAgICAgICAg
U2Vhbg0KSGkgU2VhbiwNCg0KV2UgaGFkIGNvbXBsZXRlZCBjb21wYXRpYmxlIHRlc3QgZm9yIHRo
aXMgbW9kaWZ5LA0Kbm8gc2lkZS1lZmZlY3QgaGF2ZSBiZWVuIGZvdW5kIGZvciB0aGUgY29tYmlu
YXRpb24NCnRoYXQgd2l0aCB0aGlzIG1vZGlmeSBhbmQgb2xkIHZlcnNpb24gZmlybXdhcmUsDQpI
b3dldmVyLCBpbiB0aGlzIGNvbWJpbmF0aW9uLCB0aGUgTEVEIGZ1bmN0aW9uIHdpbGwgbm90IGJl
IGVmZmVjdGl2ZQ0KYW5kIHJlcXVpcmVzIGEgbmV3IHZlcnNpb24gb2YgZmlybXdhcmUgZm9yIHRo
ZSBMRUQgZnVuY3Rpb24gdG8gd29yay4NCg0KQi5SDQo+ID4NCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgIGVyciA9IG10NzkyMV9tY3VfcmFkaW9fbGVkX2N0cmwocGh5LT5kZXYsDQo+ID4gPiBFWFRf
Q01EX1JBRElPX0xFRF9DVFJMX0VOQUJMRSk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAo
ZXJyKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ID4g
PiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBlcnIgPSBtdDc5MjFfbWN1X3JhZGlvX2xlZF9j
dHJsKHBoeS0+ZGV2LA0KPiA+ID4gRVhUX0NNRF9SQURJT19PTl9MRUQpOw0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgaWYgKGVycikNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIGVycjsNCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgcmV0
dXJuIDA7DQo+ID4gPiA+ICB9DQo+ID4gPiA+IEBAIC0yNTksNiArMjY4LDIyIEBAIHN0YXRpYyBp
bnQgbXQ3OTIxX3N0YXJ0KHN0cnVjdA0KPiBpZWVlODAyMTFfaHcNCj4gPiA+ICpodykNCj4gPiA+
ID4gICAgICAgICByZXR1cm4gZXJyOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArc3Rh
dGljIHZvaWQgbXQ3OTIxX3N0b3Aoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQo+ID4gPiA+ICt7
DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IG10NzkyeF9kZXYgKmRldiA9IG10NzkyeF9od19kZXYo
aHcpOw0KPiA+ID4gPiArICAgICAgIGludCBlcnIgPSAwOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsg
ICAgICAgaWYgKG10NzZfaXNfbW1pbygmZGV2LT5tdDc2KSkgew0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgbXQ3OTJ4X211dGV4X2FjcXVpcmUoZGV2KTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
IGVyciA9IG10NzkyMV9tY3VfcmFkaW9fbGVkX2N0cmwoZGV2LA0KPiA+ID4gRVhUX0NNRF9SQURJ
T19PRkZfTEVEKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIG10NzkyeF9tdXRleF9yZWxlYXNl
KGRldik7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAoZXJyKQ0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiArDQo+
ID4gPiA+ICsgICAgICAgbXQ3OTJ4X3N0b3AoaHcpOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+
ID4gPiA+ICBzdGF0aWMgaW50DQo+ID4gPiA+ICBtdDc5MjFfYWRkX2ludGVyZmFjZShzdHJ1Y3Qg
aWVlZTgwMjExX2h3ICpodywgc3RydWN0DQo+IGllZWU4MDIxMV92aWYNCj4gPiA+ICp2aWYpDQo+
ID4gPiA+ICB7DQo+ID4gPiA+IEBAIC0xMzcyLDcgKzEzOTcsNyBAQCBzdGF0aWMgdm9pZCBtdDc5
MjFfbWdkX2NvbXBsZXRlX3R4KHN0cnVjdA0KPiA+ID4gaWVlZTgwMjExX2h3ICpodywNCj4gPiA+
ID4gIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfb3BzIG10NzkyMV9vcHMgPSB7DQo+ID4gPiA+ICAg
ICAgICAgLnR4ID0gbXQ3OTJ4X3R4LA0KPiA+ID4gPiAgICAgICAgIC5zdGFydCA9IG10NzkyMV9z
dGFydCwNCj4gPiA+ID4gLSAgICAgICAuc3RvcCA9IG10NzkyeF9zdG9wLA0KPiA+ID4gPiArICAg
ICAgIC5zdG9wID0gbXQ3OTIxX3N0b3AsDQo+ID4gPiA+ICAgICAgICAgLmFkZF9pbnRlcmZhY2Ug
PSBtdDc5MjFfYWRkX2ludGVyZmFjZSwNCj4gPiA+ID4gICAgICAgICAucmVtb3ZlX2ludGVyZmFj
ZSA9IG10NzkyeF9yZW1vdmVfaW50ZXJmYWNlLA0KPiA+ID4gPiAgICAgICAgIC5jb25maWcgPSBt
dDc5MjFfY29uZmlnLA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvbWN1LmMNCj4gPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvbWN1LmMNCj4gPiA+ID4gaW5kZXggOGI0Y2UzMmEyY2QxLi4y
ZWJmMGZmZTc4ZDUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTIxL21jdS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21jdS5jDQo+ID4gPiA+IEBAIC02MDYsNiArNjA2LDIw
IEBAIGludCBtdDc5MjFfcnVuX2Zpcm13YXJlKHN0cnVjdCBtdDc5MnhfZGV2DQo+ID4gPiAqZGV2
KQ0KPiA+ID4gPiAgfQ0KPiA+ID4gPiAgRVhQT1JUX1NZTUJPTF9HUEwobXQ3OTIxX3J1bl9maXJt
d2FyZSk7DQo+ID4gPiA+DQo+ID4gPiA+ICtpbnQgbXQ3OTIxX21jdV9yYWRpb19sZWRfY3RybChz
dHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2LCB1OA0KPiB2YWx1ZSkNCj4gPiA+ID4gK3sNCj4gPiA+ID4g
KyAgICAgICBzdHJ1Y3Qgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgdTggY3RybGlkOw0KPiA+
ID4gPiArICAgICAgICAgICAgICAgdTggcnN2WzNdOw0KPiA+ID4gPiArICAgICAgIH0gX19wYWNr
ZWQgcmVxID0gew0KPiA+ID4gPiArICAgICAgICAgICAgICAgLmN0cmxpZCA9IHZhbHVlLA0KPiA+
ID4gPiArICAgICAgIH07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICByZXR1cm4gbXQ3Nl9t
Y3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwNCj4gPiA+IE1DVV9FWFRfQ01EKElEX1JBRElPX09OX09G
Rl9DVFJMKSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcmVxLCBz
aXplb2YocmVxKSwgZmFsc2UpOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArRVhQT1JUX1NZTUJPTF9H
UEwobXQ3OTIxX21jdV9yYWRpb19sZWRfY3RybCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gIGludCBt
dDc5MjFfbWN1X3NldF90eChzdHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2LCBzdHJ1Y3QNCj4gaWVlZTgw
MjExX3ZpZg0KPiA+ID4gKnZpZikNCj4gPiA+ID4gIHsNCj4gPiA+ID4gICAgICAgICBzdHJ1Y3Qg
bXQ3OTJ4X3ZpZiAqbXZpZiA9IChzdHJ1Y3QgbXQ3OTJ4X3ZpZiAqKXZpZi0NCj4gPiA+ID5kcnZf
cHJpdjsNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTIxL210NzkyMS5oDQo+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTIxL210NzkyMS5oDQo+ID4gPiA+IGluZGV4IDMwMTY2MzZkMThjNi4uMDcw
MjNlYjllNWI1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkyMS9tdDc5MjEuaA0KPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9tdDc5MjEuaA0KPiA+ID4gPiBAQCAtMjcsNiArMjcs
MTAgQEANCj4gPiA+ID4gICNkZWZpbmUgTUNVX1VOSV9FVkVOVF9ST0MgIDB4MjcNCj4gPiA+ID4g
ICNkZWZpbmUgTUNVX1VOSV9FVkVOVF9DTEMgIDB4ODANCj4gPiA+ID4NCj4gPiA+ID4gKyNkZWZp
bmUgRVhUX0NNRF9SQURJT19MRURfQ1RSTF9FTkFCTEUgICAweDENCj4gPiA+ID4gKyNkZWZpbmUg
RVhUX0NNRF9SQURJT19PTl9MRUQgICAgICAgICAgICAweDINCj4gPiA+ID4gKyNkZWZpbmUgRVhU
X0NNRF9SQURJT19PRkZfTEVEICAgICAgICAgICAweDMNCj4gPiA+ID4gKw0KPiA+ID4gPiAgZW51
bSB7DQo+ID4gPiA+ICAgICAgICAgVU5JX1JPQ19BQ1FVSVJFLA0KPiA+ID4gPiAgICAgICAgIFVO
SV9ST0NfQUJPUlQsDQo+ID4gPiA+IEBAIC0xOTYsNiArMjAwLDcgQEAgaW50IG10NzkyMV9tY3Vf
ZndfbG9nXzJfaG9zdChzdHJ1Y3QNCj4gbXQ3OTJ4X2Rldg0KPiA+ID4gKmRldiwgdTggY3RybCk7
DQo+ID4gPiA+ICB2b2lkIG10NzkyMV9tY3VfcnhfZXZlbnQoc3RydWN0IG10NzkyeF9kZXYgKmRl
diwgc3RydWN0DQo+IHNrX2J1ZmYNCj4gPiA+ICpza2IpOw0KPiA+ID4gPiAgaW50IG10NzkyMV9t
Y3Vfc2V0X3J4ZmlsdGVyKHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYsIHUzMiBmaWYsDQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1OCBiaXRfb3AsIHUzMiBiaXRfbWFwKTsNCj4g
PiA+ID4gK2ludCBtdDc5MjFfbWN1X3JhZGlvX2xlZF9jdHJsKHN0cnVjdCBtdDc5MnhfZGV2ICpk
ZXYsIHU4DQo+IHZhbHVlKTsNCj4gPiA+ID4NCj4gPiA+ID4gIHN0YXRpYyBpbmxpbmUgdTMyDQo+
ID4gPiA+ICBtdDc5MjFfcmVnX21hcF9sMShzdHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2LCB1MzIgYWRk
cikNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTIxL3BjaS5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTIxL3BjaS5jDQo+ID4gPiA+IGluZGV4IDBiNjliMjI1YmMxNi4uZjc2OGU5Mzg5YWM2
IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkyMS9wY2kuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkyMS9wY2kuYw0KPiA+ID4gPiBAQCAtNDI3LDYgKzQyNywxMCBAQCBzdGF0aWMg
aW50IG10NzkyMV9wY2lfc3VzcGVuZChzdHJ1Y3QNCj4gZGV2aWNlDQo+ID4gPiAqZGV2aWNlKQ0K
PiA+ID4gPiAgICAgICAgIHdhaXRfZXZlbnRfdGltZW91dChkZXYtPndhaXQsDQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICFkZXYtPnJlZ2RfaW5fcHJvZ3Jlc3MsIDUgKiBIWik7
DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgICAgZXJyID0gbXQ3OTIxX21jdV9yYWRpb19sZWRfY3Ry
bChkZXYsDQo+ID4gPiBFWFRfQ01EX1JBRElPX09GRl9MRUQpOw0KPiA+ID4gPiArICAgICAgIGlm
IChlcnIgPCAwKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgZ290byByZXN0b3JlX3N1c3BlbmQ7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgICAgICBlcnIgPSBtdDc2X2Nvbm5hY19tY3Vfc2V0X2hp
Zl9zdXNwZW5kKG1kZXYsIHRydWUpOw0KPiA+ID4gPiAgICAgICAgIGlmIChlcnIpDQo+ID4gPiA+
ICAgICAgICAgICAgICAgICBnb3RvIHJlc3RvcmVfc3VzcGVuZDsNCj4gPiA+ID4gQEAgLTUyNSw5
ICs1MjksMTEgQEAgc3RhdGljIGludCBtdDc5MjFfcGNpX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlDQo+
ID4gPiAqZGV2aWNlKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgbXQ3Nl9jb25uYWNfbWN1X3Nl
dF9kZWVwX3NsZWVwKCZkZXYtPm10NzYsDQo+IGZhbHNlKTsNCj4gPiA+ID4NCj4gPiA+ID4gICAg
ICAgICBlcnIgPSBtdDc2X2Nvbm5hY19tY3Vfc2V0X2hpZl9zdXNwZW5kKG1kZXYsIGZhbHNlKTsN
Cj4gPiA+ID4gKyAgICAgICBpZiAoZXJyIDwgMCkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGdv
dG8gZmFpbGVkOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIG10NzkyMV9yZWdkX3VwZGF0ZShk
ZXYpOw0KPiA+ID4gPiAtDQo+ID4gPiA+ICsgICAgICAgZXJyID0gbXQ3OTIxX21jdV9yYWRpb19s
ZWRfY3RybChkZXYsDQo+IEVYVF9DTURfUkFESU9fT05fTEVEKTsNCj4gPiA+ID4gIGZhaWxlZDoN
Cj4gPiA+ID4gICAgICAgICBwbS0+c3VzcGVuZGVkID0gZmFsc2U7DQo+ID4gPiA+DQo+ID4gPiA+
IC0tDQo+ID4gPiA+IDIuMTguMA0KPiA+ID4gPg0KPiA+ID4gPg0K

