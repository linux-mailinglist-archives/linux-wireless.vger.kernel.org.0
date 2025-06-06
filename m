Return-Path: <linux-wireless+bounces-23795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 993EAACFD95
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E4C189862C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 07:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BAC25F98C;
	Fri,  6 Jun 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="i+cVNvza";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="jqpMkpM+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDF7FD
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749195439; cv=fail; b=Akn65klN3l7Kpk34j0ZQAW6Of235F30Zbv0NIVINdw0rzVWekMCQDgZL+XP5rjWBzoNCnNeCtM6c+LUC5tnsGaCTiiReV2OfSAu+tliDeYP3qoDvsh/vGmn0N655zDCeWm05MBM3EKxAt2VE8nmPgV3uFz6AGgSoFiQAzWeAfng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749195439; c=relaxed/simple;
	bh=TD9g6bA7stt5MqpmLb/mvVFm6LY6wWFVLSbUIeRpsYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FeyDD0ztD7mAIh9KPfuviv3OnUw6vD+XMjZZd7HbRQTaXspayVsM7dvlcVKQwPXE82YI0tN0VLVRCm2UevRHnfDc8L7ZJrAhhvXn1Y4dN5clFf/P9klzhlpVD3EMATdwXBJb+uayqZNDwv0DTsuLoUp4gO6/2GGJcONzYx/FrYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=i+cVNvza; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=jqpMkpM+; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5566DNJQ015519;
	Fri, 6 Jun 2025 09:36:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=270620241; bh=O8ILOmZDotvY9iA8KHdhSXOm
	IslZJJ2H2kA3fjNFFso=; b=i+cVNvzaJEE4oCODc6ede1zV6hNVjHnpCiLesaY/
	ZpgWHKJ5NJHW0gusNcDSgooBkQDVQsdwUitQVzNzA7/OTF7SA7uIy5xpTXC/AfyT
	Ao/cJZKrskzJFbV8J1vItJGPpijC3AMYF9ZfOdAFn5yQN4Y0NEwbVVbAjzFwFo7H
	tK/Qu62kekxM9Mzxs8GEZVHC5dxHue3I7HQLneBi/3yMjEnqkKIUVS9833+KDdYV
	2behMZBDpnecGwYGoYIbaLtlsVL3K1xWdXBM/B5b3ywCgjzrABMpYU+XF53jHQN2
	qSD18iYYbVTfjXGtM+KIWTYycb+BVwrQq52ggrjoJaivUQ==
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03on2104.outbound.protection.outlook.com [40.107.105.104])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 473dxsrmns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 09:36:49 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxosDN+d6p8fL+XeVydNDxyToIXxMvRjognBwerGTpH2U39hIY5AwdqV7MiLKKpv3o5UCSZJ9ZAiVqMVdiSaO1PElHyiPINtc/qpAu58YC+ymW1Bnuw0zWCV/jjbOffIbcY6+G9n+qsfNRM73OSrDxaRAuD4GwK+VSn5YHnqMa8WF1r0tEeLXOgAyI+b5Zg52Davl53ZXYz/VlD93lHtte//rY/twb8CX/+yZqXcNuGAByvQwnyaCKEkluvXdWrd7n51rYwbMcehklu/CnE0aKsxI388TlCg2GmxHaQKzcRtIcydb+2dMh6NIcJ3Tx1HmRiXkItcEahlzkVUlKUKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8ILOmZDotvY9iA8KHdhSXOmIslZJJ2H2kA3fjNFFso=;
 b=f0wIrMFGkSu+4ask6oVJe/1+deSQeEGGtqM7V0U2cQT5Rs4HLLVgz97gY9MpGpdINayTlbsFLsR7sDIpVOfwb4Rluh3IviyO8HWw0yX0n9nrrPzymz6hV4phNwTzV8tpxvXXbOi4PugBK3oB7qpxOI9PS3TqqSWhH7W+xP27008wdWsuA+fx7H0C70K1ArnYZ8mB4CnsZAzPCb34YrEPKpBhWmXnDQCM6reVtoPgX9rJDvCbMhfDwDzG43df/D5qgHNKFz9+lXjhgFmloDezzbUalOxTjbsRTbTyagYstG1LBCQyoIqtLHpfRHovlt2VU3B5QmEd+muzdCS4btWIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8ILOmZDotvY9iA8KHdhSXOmIslZJJ2H2kA3fjNFFso=;
 b=jqpMkpM+wX/F03SMvjsgkohD5G5wTayZ3ivIiv1aFDn3gacKgR7jQky4CPfCYNHJVQfFBZln6hjL+Ahj7WodIJvmKzkQh9IrcISq6ugHRhhRH2nVIqdY4CO7UbSyUeYt+m43jfxUpMrM0A9ZhzHTNeQEh9JStyObr70BokjFMpg=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by PAXP192MB1509.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 07:36:47 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::bee5:29b7:49f2:cf70%4]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 07:36:47 +0000
Date: Fri, 6 Jun 2025 09:36:44 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org
Subject: Re: ath12k: big endian bringup
Message-ID: <aEKajB3NHyPFdrXo@FUE-ALEWI-WINX>
References: <aD8HK4Iagc99skN5@FUE-ALEWI-WINX>
 <ae1215c7-5ea6-447c-8c07-5667e13dae89@oss.qualcomm.com>
 <aEE37D3hvlJmcN5E@FUE-ALEWI-WINX>
 <5c17e765-8975-c3b7-ff0c-3bef4862d1f7@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c17e765-8975-c3b7-ff0c-3bef4862d1f7@quicinc.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV2PEPF00003855.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:15) To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|PAXP192MB1509:EE_
X-MS-Office365-Filtering-Correlation-Id: 2072ea1d-3713-4b44-0d66-08dda4cce472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1tXfl001oM//PJgNkXckKtnA41/CaIsiGld4LI/nWnOjuO8T8/u8wXcRlH0o?=
 =?us-ascii?Q?fgPBpQgDT0oRMerB8Wgw+CYfGfE2CVUUPJnWe4tNT6+kgUblqPvPKikkHdbV?=
 =?us-ascii?Q?0y3XU1+5ZAc76Bl+SXpRpA7shinH7s+Bl2R1kKZef0PyNsyydyqNho7z0Uu1?=
 =?us-ascii?Q?uuxa1HUWU9DFold3HoR4Er8Yi+roWYdVjJJFsKVAiyQu5Qk4gfEstpjhz1WE?=
 =?us-ascii?Q?okaK6ftJrEpMMsjDVUlI5P4cUXaO2Vm3nwckm8WEagoCd5trvAGRAbRP56NZ?=
 =?us-ascii?Q?qodFEdfeT7K56qBZTgDxr9ihe4AJ4tkzCk6xDJwKfD7jzndLjzHAaXoVEFiI?=
 =?us-ascii?Q?9y0LL4evRkLVXJ2hqjtHYBz3taVsiVyXJifq7WKsNk1HrPS7i7UBUe5O4aOK?=
 =?us-ascii?Q?YK81RdzG7lFYMULCsR8roz+NfgIK7j4toUvJ917JdsGnvDMMW1VAKeQUJ356?=
 =?us-ascii?Q?DeLb67BOppJFOu2eiLcJyP+UvAF1WhZcTUOWyfcGWD+hWPPtKpdkh2mfqToY?=
 =?us-ascii?Q?ZBC3o6Tsu8nYpNdgUR6KUS8RI6ZHgeVRRsKaWoDPOoPRe7EXh49aYRLaQTL1?=
 =?us-ascii?Q?gbrL/TCglJ4kNrDC+i0+p6GKBozstnnPtsfmBdy3h/MibKW/UyJZYxaQ6SPf?=
 =?us-ascii?Q?HSEyFTfZkgfjf87vu6/U7/D7qEqSqk6Dmyl+9Qu9B3rssdLjnSgF99BMZj1u?=
 =?us-ascii?Q?hh9lT0cw44w15YxdBYz6BiYfY9q/UQCfnKRJcyTHI4gIbVrBAOA4d1wclQYl?=
 =?us-ascii?Q?OmZDCnWv20BQP2w2f6voZSFOk4pyqH2IUmZulIv/74QOzrT4ki52L4+AfR7X?=
 =?us-ascii?Q?0onzqp5Erm8KgBLxsc5j7MvKDMMn27KpzeZFjGKj9OcBE+/3SUbAOpzbxi4H?=
 =?us-ascii?Q?27io2qNslVXTBnvIpI1ybzTRKbeiO0mshjOmpgqDejskYKzrFMvP5KoIeApE?=
 =?us-ascii?Q?zzqbnIDJZVegpqASTEkD2+omOaeQs/peXmrL6gytdnDjl5+rGcwGtSx00A2U?=
 =?us-ascii?Q?1UvZtp+tG/a5VprDh5DW7U3Z35RfapgcewV7KDvPixtkPd1DupN/zM15XAXX?=
 =?us-ascii?Q?zzitJyI1aKghvxJ1rn+lhFQjSfxZCG/gbtrlkZSahowKIC+3v8nYcUoinGIz?=
 =?us-ascii?Q?9AdbconUvxJ1bMbpw1tGV9Gw6O4rj+jNR85/4fkgAiyGfha+da3xcbWID2i8?=
 =?us-ascii?Q?OFm3W/q2PEDpOpbaFtwmkgDORocIYbX+rbeEQfO87kQdRW3Tk4YuWtvR8MZ0?=
 =?us-ascii?Q?ZWl1flr4tiLQ/qV5kFRRn/+2kFIfhya+AzjluexDZ32mqKOI5TnOGZM5dpTg?=
 =?us-ascii?Q?sTFWhOMYnx4OrHp0BgUPzDKkr5dtRItEKt7WTGkp3uUwPmquut9V3snyIbl2?=
 =?us-ascii?Q?T33WYjW2NwE3IT3PjyaJuO97jnPsJs+5mhpmhYXlwiwMSIqs5pOI44ETA22A?=
 =?us-ascii?Q?eVcgzY871Ac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EMqLoc00P63sCxpS0OUQbN6DbQT7zP+Lcup2SlG8tGmrrAhSqnxstKuntx5M?=
 =?us-ascii?Q?SW1aSPEMlGvzpBob0cnrmDBKl4rpNEktpIW9KKvRZHUgMiICjHl2ph3+Ubje?=
 =?us-ascii?Q?gOz52JW8aL+TckQpZfXZ/bHtd4mqGQWgxphrY84m9HpRo7giKa2/Cf5t8Sdl?=
 =?us-ascii?Q?WceokhyHKxy/TX+1pCaIQhpOlKvFGdye6jCgQaCxMpJAeG20xzo3fIfq6o/I?=
 =?us-ascii?Q?FO6qxrJCw0Juh7F/7mJPKl6ZufuGzsgAthO7jlyqg/U+rpj3xpEufOLbkkRT?=
 =?us-ascii?Q?MgPNJ6B+vXfx3hpZByjqTOJa9BSvUwaaziqBIe0ZYCbI+KFyWZBjV6BwyniH?=
 =?us-ascii?Q?3UkFn1xQ6++HjcUb6/EljF3SjDuu13Cp14Usk4cMyVJevzF3Pkl4RiWvhHJs?=
 =?us-ascii?Q?5f1Cnq3koc/jlN7+mJciy/9U4aSk0pf5hInvpPAtWox+t1NsAWGTUg+F0jPP?=
 =?us-ascii?Q?uTZuxY8btcpZ/hMga8r4Bmyr+xeEKLRmAQ+DTX8TqWFgSNwA1uh6iIDx2hyy?=
 =?us-ascii?Q?vi1WgenvvX+3ufCd2U+JPZr3Jv+IEiJkb/f/TSfzE72Re+sDF2gFP/tsOzdx?=
 =?us-ascii?Q?KuWsdU9RpJIL1wwEnWFe/TAUkB+H0WXIyv24JCQNUeUgd5ANISriywjC7rJx?=
 =?us-ascii?Q?pLukfwDT4Sok8yRjWM6iQo0n79Tw5N+ybGbF26rklOELFDGpN1vNosmroytl?=
 =?us-ascii?Q?McYptme4KxnKdgxaKV4vrKNQzDVPrxJ9dMJxmHzDT8KE2p0wugqUIqLvuzlO?=
 =?us-ascii?Q?Q/rhpo4i3RflsApEVJcx7yIquCVQ+qSKDzZZBHQy7WAN4wJg1odfVuPajG9b?=
 =?us-ascii?Q?NxGTce5/C2dgkVwfc0/BGiVCaBzMKTqzqhBszEK1uTMl7ahP2IKYBT4+Agkw?=
 =?us-ascii?Q?BkysX0yCIrdpRBmwNV6atniGxSg9uT0B/zyq966wGxYTgunqU2yIKe7gbs1E?=
 =?us-ascii?Q?eIeKNTtLO5PzamC1na8morqioMcvdcomOK6U0vpt+mcLbVuycxwu2TNPENp8?=
 =?us-ascii?Q?TndXohd0H7TQ5Sg2LqgAKwPKrgmfD8M38ZeUvu1sPLRXW71wi5Nu1gig3xmD?=
 =?us-ascii?Q?fnd6sCNk3ZU79DuqKZ1XsW7IQPojgzh2IPm+HVyMknweUJYCiqxsAX7lxhsT?=
 =?us-ascii?Q?OtxebRD/104qBQ9lMvmo6w+Z3TlZiw5cqZvg8TOO4M8ivQEETNZ0gNpuBffx?=
 =?us-ascii?Q?obpSd4s8SbmQYUGtP6jv95eTAksiUg+MBm2GHxrkJkSz6vq3aEdmjxXhc8l4?=
 =?us-ascii?Q?201zIWYxkB5rpxSSX7eI3pt388Ft7pIkIm/2aim2RaGeAmBaTenDqtC5d/uc?=
 =?us-ascii?Q?pEBcCpRZlvTOjHKdCtizMiNAxu/r6XoZ027BKQNTYhCTi0wyMzayYO7c0pFS?=
 =?us-ascii?Q?mIhNiyneHOcSjw8rzW7cqaLdFwP/slySN0cmd1Y3re/oG4Aj9hOE12aR/YzC?=
 =?us-ascii?Q?LJW5wiGCsZAgRyGb2237gmQvywTOHliN/ehvyl2GRNG7HfnLjWuBymME0HM7?=
 =?us-ascii?Q?T2FXN2uu9VRvA6B5MneAzeMwIrywOlnKFOAGv+aLm644OBEn4hM6XXaFHI7t?=
 =?us-ascii?Q?HvkpUjTzVBAJV6k9vHvvxa0CDFcGBkFMp+t0/Rxy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eZODrxI/MLmSYzQgtuWoQKoFglTSFkHbME8ovY4ByPGoTwEejHsItCvtzxXc4X1p0PxANkK8q60eEJw4tZjnAXOW5khXx91SsRFa7Z5oyLH1SUpKgl044ncw7tflzkNtSCtB5Ulq0G7cfnvlWBWti1ikgqK0VrI5+proADr6oWdv8OYTzeJVM751vRq2Ukidy0B+KpO38m29Kj3BD+pBpcCwBbupKdW8fovLK9XubM+8ziB7WGl0qgD9pT4HqF+QlJDfxqADkIREkWLkKxaHh1DyMlUG966E6ktYPXswmIMKWFH6r/rdd54fpItFvZOLCSQdFvEurz4+bj98c5RvHkOguXnCiXUXCBcyc27qHjqVGa5jxLqNeMqwCaRFsKjZZNZ9gylOi1ekuJcoydJTEzB6h2IARteqln3S+iREZBDi6eZBaG7OeoqoLG0Ei2hdz97fppnOHTQoU8HdrudLTPJ6Q6sNepFYA/PYeuu+Gh65pRn8UlR4DUmOX13CNMJX2vAQtDrBdBdNh15zvVX+d8nmME5odxfptJCIcgHLcyU8MpcACOoQPp1SvXhJ3i/O9ZDGxc/LSwJtVb9ak3riVYSJ8F/YDLupX8wobzwk9RLc1NQCC6v3gUxKts82rJrS
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2072ea1d-3713-4b44-0d66-08dda4cce472
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 07:36:47.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAQWjJx+meeDJD0CQ2Jw5kJZYLvOkZyF2MfSVhIMyXq0JAiCVEeFCCH+shSkhICiXS1TWR8SP9g9t9/NzbX5OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1509
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
X-OrganizationHeadersPreserved: PAXP192MB1509.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: wS-4EdGydOp_M4gGJ1AcPkEHIP2ATuLr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA2OSBTYWx0ZWRfX4iWGKzxk7yQe 1WtUh+0ecIjYGnA6htbnQH3HQ3Q6bcXkrxh8XoHMz0TMXDpu2/G4k0/276rdX12DWvb4ha+2WoX VExMixBETkMX1OEKUofNdjAL89dBqbc7/f5TdR2qyhg+e1uu8IV9Bs3G6JwOnh8BqRL/B80e7Ei
 24hnv6Z6y+nHK+fcrI2agC/BLeh5so/CTvqWgWsMNdCprpMMrsl6AAD4EFvw1e87jseStrhJYAw 0WXXKQnye7in5LKJFmjDCkFkBiY9y0vAYLbGtqf5NsXy7TjGzyvgkY8eT8CsZ5mZK+p27fkf8wL dxPv2ojsupt783+OLD7rfJm3fz0bAK9styACo69KlzIFVcHPnGiPG4Kzki8Wy97ezw2xGAx3GMy
 VJ22c2kyfGUAtWAkKQUcLS0QT7USdUhovGsjMi827O/EeKvidj6lMa3pxSeThCDNZ8UCx4fD
X-Proofpoint-ORIG-GUID: wS-4EdGydOp_M4gGJ1AcPkEHIP2ATuLr
X-Authority-Analysis: v=2.4 cv=A4xsP7WG c=1 sm=1 tr=0 ts=68429a91 cx=c_pps a=su6Vvmeombb17ZKpv29V+g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=8gLI3H-aZtYA:10 a=avO38gPrluGtcA-_ASUA:9 a=CjuIK1q_8ugA:10

Am Fri, Jun 06, 2025 at 10:48:27AM +0530 schrieb Vasanthakumar Thiagarajan:
> 
> 
> On 6/5/2025 11:53 AM, Alexander Wilhelm wrote:
> > Am Wed, Jun 04, 2025 at 10:30:40AM -0700 schrieb Jeff Johnson:
> > > On 6/3/2025 7:31 AM, Alexander Wilhelm wrote:
> > > > Hello devs,
> > > > 
> > > > I need help to bring up the QCN9274 with ath12k driver on big endian PowerPC
> > > > platform. I've already found some issues and fixed the MHI start procedure [1]
> > > > and QMI conversion [2]. Furthermore I added some endianness fixes on 'qmi.c'
> > > > file and could successfully transfer the firmware and boardfile to the wireless
> > > > module. But the firmware does not start properly.
> > > > 
> > > > I'm trying to analyze the error and don't fully understand what is happening.
> > > > While 'ath12k_htc_connect_service' I expect a successful response from
> > > > 'ath12k_htc_send', but the connection then is timeout. It seems that I should
> > > > receive a message with length of 20 and at least I get one. But then the driver
> > > > remains endless in the 'ath12k_ce_recv_process_cb' and I always get a message of
> > > > length 0 from the 'ath12k_hal_ce_dst_status_get_length' until RCU stall happens.
> > > > 
> > > > More interesting is the 'CE_ATTR_BYTE_SWAP_DATA' from ath11k, that is still used
> > > > in ath12k code, but HAL structures now are swapped in driver itself at the same
> > > > time. Is that correct?
> > > 
> > > That does NOT sound correct.
> > > What happens if you unconditionally keep the BYTE_SWAP flag disabled?
> > 
> > Hi Jeff,
> > 
> > I tried to do so, but nothing changed. I will verify whether big endian platform
> > sets the 'CE_ATTR_BYTE_SWAP_DATA' bit inside of 'attr_flags' at all.
> 
> Byte swapping will not get enabled in ath12k for big endian platform.
> CE_ATTR_BYTE_SWAP_DATA and and other byte swap related macros are ineffective
> in ath12k, CE_ATTR_BYTE_SWAP_DATA is not really added in CE_ATTR_FLAGS.
> 
> 
> > 
> >      ath12k_pci 0002:01:00.0: rx ce pipe 1 len 20
> >      ath12k_pci 0002:01:00.0: Target ready! transmit resources: 4 size:4096
> >      ath12k_pci 0002:01:00.0: boot htc service HTT Data does not allocate target credits
> >      ath12k_pci 0002:01:00.0: Service connect timeout
> >      ath12k_pci 0002:01:00.0: failed to connect to HTT: -110
> > 
> > But I found the problem for the above log in HAL. I set the '__le32' type for
> > the 'ht_addr' and 'hp_addr' from 'struct hal_srng.dst_ring' and 'struct
> > hal_srng.src_ring'. Now I am one step further and have some capabilities issue.
> > By the way, maybe you can help me here. The function
> > 'ath12k_pull_mac_phy_cap_svc_ready_ext' differs now from the respective one in
> > ath11k to overcome the endianness problem. But the following lines are
> > questionable:
> > 
> >      cap_band->he_cap_info[0] = le32_to_cpu(mac_caps->he_cap_info_2g);
> >      cap_band->he_cap_info[1] = le32_to_cpu(mac_caps->he_cap_info_2g_ext);
> > 
> > The same for 5G and 6G frequency bands. But it seems that the usespace requires
> > here '__le16' instead of '__le32' ones. Can you verify that? Or maybe I
> > misunderstood something.
> 
> No, it is indeed 4-byte. In total, there will be 6-bytes in mac_cap_info which
> populated from two 4-byte information from firmware with some internal data
> encoded in MSB two bytes of the second word which will get dropped when advertising
> the cap to mac80211 (in memcpy).

Yes, you're right. There is 6 and 11 byte arrays for 'mac_cap_info' and
'phy_cap_info' for HE and 2 and 9 byte array for EHT capabilities. They are
wrongly set on big endian due to simple memcpy from u32 to u8 arrays.

Best regards
Alexander Wilhelm

