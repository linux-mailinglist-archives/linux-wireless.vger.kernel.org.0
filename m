Return-Path: <linux-wireless+bounces-25741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F202B0BDCE
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7974516B44D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8B7283FFC;
	Mon, 21 Jul 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="qPBMln8n";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="mEd2NUb2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3C126BF7;
	Mon, 21 Jul 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083439; cv=fail; b=D62YJyO0itSjd8fJCnov3cIef2RH9ifHFNejknL/WzDEm1FFQg/pE0gTnMXFxIPoVrxneAbsXd4cILGi83S4AicaduKINNu3hE+/nAovM4POvsk2aZ8eZrZEpWYGpWh7gneA+3nGGBwDm+rAFLrxSukYZ6WCT4ym6361HdjNCDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083439; c=relaxed/simple;
	bh=NaA3HuAwGySYHlN9UV90HnLdBjoJhgGCaCL/MKT6Onw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUfk8bqiRXw8ehDfv/jANJeuBnLuY0ff273rArMf1emJWegVHc9te19vvko+X66nrYh4SB371ZLN2NS8bJ0NhEOhILybGOul22SiQyOdpwFKoI/2UQXYyGru/nzTSgmr8wOqMWsRQTCds9jHgeJZF5R8LwqX4shm6jPHHrVkl+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=qPBMln8n; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=mEd2NUb2; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56L5DGbj693391;
	Mon, 21 Jul 2025 09:36:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	43KRm9NDC9pZmdHzHYZEU17Ma/HbdPnR+e3pUZ0sSAY=; b=qPBMln8ng4moUuZ8
	vNEVgdIdhqExOTJ280J9mJENxSrWVZ7guCtWR9TEmJtge5VVv2caenWeeVvA8uxU
	qW5tRToiqRAFlb51ELX4NSLlrfaK5oNFesqTRNyRDcm+9HrsKjOY4kXGZ2GJHVzG
	dBsfODMQktBd2pa0WqDeD1rblg48kOyBYNKtDhyXlDtDSa+2Y9jAztJ04f3xMRZ8
	HqDyH4RB3gUtNYtRJ9IuQhvRC7jDmUPmj2Idpm/GV/33KZf5EvT2PddWDeQhbqQj
	cIipkfPg7vNmm6lmml8ZuV0ovVVI6Dny1e4sTzSFnB0Iso6B9T6ZeoQ4sjG08hBM
	i9K+Ug==
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05on2096.outbound.protection.outlook.com [40.107.21.96])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 47yyq9hv59-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 09:36:50 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMerWR4i2ZK7n6SlAcYBSOHbKGbYni1Y3xsQyUdERJehjkKct26nK7IbKvTzhVoh4wHOBnln10H5WHBnYj5tk3W8NXoLzRJHv63JRY9ebpke0ipHc/8H5/dnOzVT1h47dE2CWasuCzLGW2Ot1ad8HOfitudgLsJWDkrZ+sGn3AL+9gfhU4LnNdKvjHrBa4JiQAMKwZruAkCP5yvF5RRUeJ+YnqMc9mdYw9rxYvFtmNjdnUSA7hoR5+UbFzGndF/o6E8OFsHy6MCvrjcipPmy1oFzdmmoZs6Mz9+8yXwVpU0/iMUHe1yJbiGmPiJeE701s68NkzbuzcaPSWZEbYW8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43KRm9NDC9pZmdHzHYZEU17Ma/HbdPnR+e3pUZ0sSAY=;
 b=y664GAFDb9C6LBDrBQvrgHq7erTW52JhR86pySk8sg/nxUYepsRrznT9WgzlcbMRCNKdvrYSbUODPhSc7FlovnJly/LlqLobuSRgQVXt0HOXHvMPje+vBQfabfgCi2dGKsj4OX3EoEOWCPXrpd+998itvcN44T5ME6UP5UT1dxJvQUcGaX6P8777h3bBvpzULFjbJeWhdwqy8nwn/sCGhT+fbMKjwGfmUM9JAkcxNjFwJ2YkctEPWbDWFdPOz59ysxn8XpIv9MDThQ1leFu7Sb4AEg+hVzAnYs0VH9bfqJz3Dr9E8EaHOz2TZYLP1mR1QTNopUGC+AiWyEduwUXHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43KRm9NDC9pZmdHzHYZEU17Ma/HbdPnR+e3pUZ0sSAY=;
 b=mEd2NUb2rYkX8Bdae0nQL4LnN1O4e6NQbSDyQFQFRswjT/d4Nb58beIni7NvH4F4PHdpYEoRG9Aggz0QVDI0vVOtXPeeior4Ay/pFh/G99qoJQx0DzEA8hgI8veXVoIqPuVGCYP+Pnq8Yd8Z4Fi3N9YkFk/JiZq/XYG1gL4Eftw=
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
 by AS2P192MB2145.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:62f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.20; Mon, 21 Jul
 2025 07:36:47 +0000
Received: from AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a]) by AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
 ([fe80::f6d5:55ee:51e7:b13a%4]) with mapi id 15.20.8964.019; Mon, 21 Jul 2025
 07:36:47 +0000
Date: Mon, 21 Jul 2025 09:36:42 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 00/11] wifi: ath12k: Fix endianness handling in QMI
Message-ID: <aH3uCiv/OaWbt5T8@FUE-ALEWI-WINX>
References: <20250716075100.1447352-1-alexander.wilhelm@westermo.com>
 <833ce5f1-51b2-4d4c-a839-38989ea10344@oss.qualcomm.com>
 <a2sjvescdtdo75lpt6e7tnf7c46sj6g3mlakva5nzsa2p643w2@ie4scpc5vhv7>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2sjvescdtdo75lpt6e7tnf7c46sj6g3mlakva5nzsa2p643w2@ie4scpc5vhv7>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: HE1P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::17)
 To AS8P192MB2240.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:63a::18)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2240:EE_|AS2P192MB2145:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d19e01-8249-4e99-35ff-08ddc82958ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0cyOXlDRFpuNVVGU1krL2VQbzNaclZBSStzbUNSR0g2eDhpd2JrRit1VDBW?=
 =?utf-8?B?b2FaN0VpY3dUNXhBVmRDZytLdnBqcjNoSUVneTA4TWs2MENrQ3hTVDByV3Zp?=
 =?utf-8?B?OWs1L3pZNjZXL0ZwT21uVGRpcFZQb1ZRb1lqMHp0MVNQaTRzOUNSMEpqYVgr?=
 =?utf-8?B?UEc4bXV6MnJERTVhYXkwTU1oblNPMStTNEdNOTdFZkJzMjg5WWxsTUZsRlk1?=
 =?utf-8?B?RXJZallDN0pFQ3hXQWMwc2UxTU9OR1Fwak1xS0xyRjUvaVg3VmFURVBkT0Vh?=
 =?utf-8?B?dldLZmlla1o1WmUwcG80VVcwL3Q1anYzVlBlV05tWmRRSEl4WFJQNjNNalMy?=
 =?utf-8?B?R29SMGkvaTFhdHV6Tm5qY1kzcDhqTXlsT3QwVXRvR3gwOW9laEN0WkZmV0l4?=
 =?utf-8?B?bVFVRVRqNFdjdkhUYndZdEpuWjNMa0Fqa2NBVjIrRkt3aFN0cGFFVmhNeUE4?=
 =?utf-8?B?citaUVFtd2xXRUIrYW9LL3IrYmQySXNkeTNSZUdjaVBoek5vTE9STWEwaUlv?=
 =?utf-8?B?dTgwNWt4c2w3cG83M0dpUENBbEVjYTlzM2FFSzVpbnp0TG4zZWpMajhZeWZJ?=
 =?utf-8?B?M0VFbTVkVFFPLytnOWZKU3ZWem9zYUdOY1Z1OEdTUTVUTVZmTnBtcTlnRWdy?=
 =?utf-8?B?K3BzWlNDazV6bUN0akZtSmJ5bWRzOEtDUjdtNVc2eGQ1elh5UXBxd245c1Fj?=
 =?utf-8?B?WDFWMERPMG5ucDJxZ3NvWFAyWDFZNzBCdEVvSUwzNlFLMUJKWDRVMGk4R2pF?=
 =?utf-8?B?UFVHVlhFWHpwOG4xRWI5QjhtYzBoNW0vQWR3aG4zSHRDSllSeFBzaWRoU2hE?=
 =?utf-8?B?Yytocy9Xai9PVWZIMUoxN3ZNdWFSYnFnaExDaUtNVmU4b0pHRFdndFF4VGxi?=
 =?utf-8?B?YlV4L3o2UGpPd3JiTlJRblZvS3Axa2o1L0d4YTFMOFkxTTEvWXk4SjRXWDFw?=
 =?utf-8?B?NUh0alhSNWdPMkIrVTAvQkwwNWc1b3ZMa0hFNnVFZnRVYk9oMHdUQW56Y2Q2?=
 =?utf-8?B?RE1tSWc4TE5aSU1PMXkvdENNNjVCZld4VmhQbHQrSWNHQWsxeGJkUE1OMU4w?=
 =?utf-8?B?WWc1Z3JoeXczaGNsd2hmM28rYTFkSXNVc1VFUVB6SjFLZ0R2YmFSazErUTRU?=
 =?utf-8?B?VEhqKzcrYW5FbVVXRld6L1ExZm1IS1cwd1FFaHBGcTdZSFZVVWFuQTU2dGRm?=
 =?utf-8?B?d0dFbEtNcVp4Rk9meTVlZk5pZ080b2M0YnFEb2tpZzZDT3pLYUNYRW5pb0gy?=
 =?utf-8?B?SDg0MDVrSnUzczYvNUFSbTJJb2dGLzJQVGZickRzOG92T3JSTG1SK3FQTG1M?=
 =?utf-8?B?Qm1MRndXT3hnVUZLWjV5Y1Bmb2h4UGJPem5zRzNycGJXY1BvOU1oRWc0TlRz?=
 =?utf-8?B?bHlGQnI3bnJsSEZlN3ZNNUJyd0hoa0ZHdytHUmlWbXJEWlZab3dxK0JsVk9u?=
 =?utf-8?B?TjN3WlhrWkRacEIyYXFveUpSVFVxVEhpeW04RWxaNEY4K2RzZnM5ZkMveDI3?=
 =?utf-8?B?YUNOckUrS1JjWWZIb1VXNEdqMFpnVDY2TExqUFI3TXM5QVo2T2pldGZ3Sjg0?=
 =?utf-8?B?Syt2QytlbmVCOTB5ZXJoNnAyRTl6YXNKV0x0STcyY0ZCQXBuWTg4bE1ZMlpz?=
 =?utf-8?B?WkFqTUYyazhQd1ZWL1BWTlNwb1hZRUNUOVVsNkM1MDNrNTNuSmdJdjJBdmQv?=
 =?utf-8?B?c01yZGw1MGFidzJUb20zQURSY1hzdDJxYzZnRDcwMVJHN1pyem5MMzUrTE4z?=
 =?utf-8?B?SjVZdG5sNXZYcDNhSmVyQ0lPWHpaNTFmbWZrZ3FKajlSK21OL1VoUHNqTW4z?=
 =?utf-8?B?RW4zeHIwMVV6NWF4SGpHZ1BMVXZwYW9ucEdqZnBwTmYyTVRmQmVtdks1TG5r?=
 =?utf-8?B?eHMvTG5jT3hpMFF1eXJqUzdxNldQS0doNTZGR0ZqeUxQdTVZUGdIODVINFFw?=
 =?utf-8?Q?MwUXGxl2PRw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2240.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2NISGQ4OEhGT2ozS2lWQnZzSVZva3U3YWg2M2pmNGFXVEYvZXIxSG5QczEr?=
 =?utf-8?B?VXlTaWdrQTFESVpFU3ZsZkZmcUdCNXh6SmtZTDlYZWl6ajQvbUI0RTFlYXND?=
 =?utf-8?B?QmZXREl3M0p6RzZhV3NZdGFVRGxhNW52ZFJjSlhlVFB1THNRTG5LVGU1TzZs?=
 =?utf-8?B?WG1HOEZYaDRzZE4yaGZHUkxhMkR0VDUyWDZvQWRha1JMek16bGZ5KzhVTWJh?=
 =?utf-8?B?M3hxbkhKK2k4Qm16SGl0SEl6OGI1bWxJdlkyc3FXZzVERUxHNzhldDN2TnlC?=
 =?utf-8?B?VzNWWDNsa3Zna0JIelBmQytsd29lRHhRZnVGalVtbjF0TG9HVC9NbGF5bHBV?=
 =?utf-8?B?TE9jQWRkYkVSeXl0cUR3WDhlK0lwR0psWmFYZ01OVTEwV2p3czFvbkY5NW5s?=
 =?utf-8?B?OHBpQk1SSE4xQnNnS2ltOW14aUZ4ejlSTTBJRXE4QllCZXkwNHdYWkZXVFd0?=
 =?utf-8?B?RHM2dlVkWi9UcHVINzdPV1JVYXQwQWUySEVPdk9WaTNIWVVEQjFUd1B3UjUx?=
 =?utf-8?B?YXBjQThJS0ZseXpscnZleHlOVkNrT3g1Nnp5NHZqWEFFSzJVcWU0NFhzWk9Y?=
 =?utf-8?B?WlZOaHN2TTRIWHIrWms3cGtaWmhiQXc3Uno3Ulp5NlRNcDNYclJNTlRjYWtP?=
 =?utf-8?B?L1N4K2lkV2JCZ29Dd05uNXdnUDJCcUZ4Q2UzZ1RNZysvVGZvc1BVVnFGelFG?=
 =?utf-8?B?dWFsWjZRSGVqRkNCbVk4elo5b0NUK1E2eHNxTjNsTHl2TFQ2NEZ0M00zSml4?=
 =?utf-8?B?RFZxU1NwQU1mTzdqTlJuVzRqOTZWOW9FeDRqNFVpT3IvTDdOQW0vTVpHa1Jy?=
 =?utf-8?B?dzRZZnF3eTE3TUJsNzhHbzU3RDIvUTFaUkFuYjVEWHd2NDV5SzFjeGVldFZR?=
 =?utf-8?B?UFZXOFhWY0M1a3Z5anJCY25sWm92YVArK1J1cjUwZVpSSVMvS3RqME0vd0Zx?=
 =?utf-8?B?akYxVXhia3BxTGJCWXZUanFnOVIxWVFIYURGMzlEd2QrRTFFNUR3S3NBaDV1?=
 =?utf-8?B?NjYybC8wdGMzRGYyNFVva0xLWDd0NXRvNE9CQ216U3pYT09Cb0NZQTN5VjBO?=
 =?utf-8?B?d0NrTXNqK1Z0RFJQNmNyWk5zeEJDK2w3VkNMeGpDK2FQblBON1Z3VEJsMDIv?=
 =?utf-8?B?cTNTK0QzbjhKVXgxM2xHaHA1bjRKRklIbDBCUC9yQkNtSHFtRXV2NVRlVlo2?=
 =?utf-8?B?cUlDZWNDZDlnMUJuK0xzdnhMR2dzQU55bTVORGlJWVUzZm81TmIwV0JjblN5?=
 =?utf-8?B?a25tNXc3MXJ5dXlldE1nNUtjbTM1Rk1DbWlnVXUxajRLeTRicGJLL0hJQ28x?=
 =?utf-8?B?N0tubXI3RE1ZcmdIazFDWkhoRk0xaWx4WkRTYWU4cFVlYkI4S3N0cFFCOWlx?=
 =?utf-8?B?UkRMR1hXN3ZqalBYekVweEdMRlppU2hoTnhvTTBiWllvQU5ibHIvSy9qM1ZN?=
 =?utf-8?B?VlhReURlVG50a3dCRHJQSUVrRnRUZEJDQThUWjBNTmtuV3JHUXVVaXpUVjZx?=
 =?utf-8?B?M1pUK3BmZWlxR1NSNjhJMWF1OFk3NFNpMEpLMGZFN0NJaXdtcXBSTUI0dDZa?=
 =?utf-8?B?eEY5N2dMVnhnNTR2czVMbFVnZDlySkgxbkFjQyswL1dneHRxaC9EVVhpdG1R?=
 =?utf-8?B?ZmlQQjBjOHF6YjZQWFY0YXN4VXRyMFEycUtWemxsZGpjNlhLL3A3K3RiL1JR?=
 =?utf-8?B?ODJvZ1RCS1BCOWU1NGgramlqVjYwcUtlTzdRUU1NanVTVTNoR2tqcklFaE9Y?=
 =?utf-8?B?NlNMamc5dnp1T3RERDA4SVJCQVVlc1FWZzlOeElmc0FqWThQQlU5VXBFL2Qw?=
 =?utf-8?B?U2l5OWVwRHJwSEozeVcreWlMWTJIZTQ3VUdLOUkvd29vb1lPWkVkRG5keW1U?=
 =?utf-8?B?WFlteWpnS0lObkR2ZmNTMndRWGpVSmNzWTBEYjM0QWY1NUJJa2EvcUVRQUtY?=
 =?utf-8?B?ZUtGSHo3cTUzdXBRSGU4YUNOczUvVkFPbWxONXQxZkZPM21VU3o5VHRZQklZ?=
 =?utf-8?B?dTFYYUtUMEpNbFpkYnJ2SkJOcUVxSEpIYnUweWZtQnM0QTE1RGFyMTVZR0RX?=
 =?utf-8?B?akluTFdmWm5sbTJVcFN4T2JVd2RyQXdkUDh5Z0RmMnhBS3F4QUJpTXo0Q0sx?=
 =?utf-8?Q?zVEZ9ZMl7nlS4j1/XxmzFGXpV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VpWj94hswqBZnR1KmVfFwxf0p/sNNAMfv7IRsNA6vJJUST6hzfwFXG8I9nABrlI0AiTUivXMWdBvMw0A6uOBVqmNOoTryLqN+eAJLiXXaMTV7RQcW1SWscJu0GBm4gh3BpkXvW/dw8LUtIaATZcq6OBh6K1avBDo4D5xsFjokXxZ43cW903lFPwNbDRyp2N1mxtdW6yD1oGEIGQeeHzncNH4jiCgYyu7ttHTOjYoAWi+em18TdFVyu+TeBg9qJD7UYMNb0cWDSA/RoSiUOeEOPk1cSYFTeF68rMj+0vHaE7rogRzC44AlIxQb0ryJeuD7HuhC6VkV/TU5BQBAURqkifuqlsDgFP89YWgjhrYeUh5+HstPc99X8QMWUga60zwXHblijfYQmnYOBWHQPpFWpjiNxfR3dbvnnozrwGvIUzmkWorHI+xHR690klQoDUHpl+m1LZuxEXVU9aGbbsEri1IS2xjYzilfXXYNkLO9P9jRXYODERdc/60FAGgh5y1eUSd7e72L/cV/FQfeqkKrROkZOf5Q2SfCfE2ZHBJRrQM6ZRMpT2RN/GRcuJsjDCUxXt1f7rtuHHzirRw5GkdgKCyWgKCAHENbs0bRwXDOvN0XH0Xh5DxLf/M/cNo9evO
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d19e01-8249-4e99-35ff-08ddc82958ed
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2240.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 07:36:46.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93Zbn5j2k9WmM2IggRNDPuYMSKkYe81vie+3p7eOxnSfPEza7mwHcg3qDLy/dfQo8XvR6dO5Xb9nKCNUdHuYIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2145
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
X-OrganizationHeadersPreserved: AS2P192MB2145.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE5MSBTYWx0ZWRfXz4+CNV/3ZSsp
 Hd/CmG0tey2Qv2tjOgF7WHBwrHI2C7ejzcv3ZM9OiEVh6nXUnQB2KkWqWG1VgBPFDfdxDVNC0ZT
 NmjU0pu+s8re/BIKQ6nyn3tyAWaQeaAwQDSQoKnmCvZ4Ad5gWb7oQKMAutIs561CZBXBV1bYmiO
 lTCnMwYnZ7df5TRwu3NN8cAMPdaEyK9iXXKxQtIgo7bAKKbhL4byoZx5e8d4NwKycuNEjzX1bP1
 Ac4f9q6VXMrRTmsxZyOYQmaOW8A9byoUKKazzI5rV2pMIVNny7YPyJp6RGPR64CTA7qhs5bdHDv
 6IOU8uhtJE+PuLE/kZm8KgWVlvyKJPm+cVFCuUTWL2s3cHDcDRQ2z2DVQbxc9k4Of3SX1B5Sc/B
 uDbjgGc1
X-Proofpoint-GUID: oZ2R-oLurMlSR8fWtOgpCgSsTCOfVITY
X-Authority-Analysis: v=2.4 cv=c4CrQQ9l c=1 sm=1 tr=0 ts=687dee12 cx=c_pps
 a=TN/PSA1dicSLKyo1b5gmLQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=8gLI3H-aZtYA:10 a=y0YAG0SLqlpaMzJntZwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oZ2R-oLurMlSR8fWtOgpCgSsTCOfVITY

Am Sat, Jul 19, 2025 at 11:24:51PM -0500 schrieb Bjorn Andersson:
> On Wed, Jul 16, 2025 at 08:13:20AM -0700, Jeff Johnson wrote:
> > On 7/16/2025 12:50 AM, Alexander Wilhelm wrote:
> > > Fix endianness handling in QMI firmware transfer on big-endian
> > > platforms. Without this fix, the firmware download fails due to
> > > misinterpreted data structures exchanged between the host and the
> > > wireless module.
> > > 
> > > The issue occurs during early bring-up on big endian systems, where QMI
> > > messages are not correctly parsed by the driver, leading to failed
> > > initialization sequences. Ensure all relevant fields are properly
> > > converted between CPU and little-endian format in request and response
> > > messages, as expected by the firmware. Attached logs showing the failure
> > > before the fix:
> > > 
> > >     ath12k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
> > >     ath12k_pci 0001:01:00.0: boot pci_mem 0xcd4148e9
> > >     ath12k_pci 0001:01:00.0: pci probe 17cb:1109 17cb:1109
> > >     ath12k_pci 0001:01:00.0: pci tcsr_soc_hw_version major 2 minor 0
> > >     ath12k_pci 0001:01:00.0: request MSI one vector
> > >     ath12k_pci 0001:01:00.0: MSI vectors: 1
> > >     ath12k_pci 0001:01:00.0: msi base data is 0
> > >     ath12k_pci 0001:01:00.0: Hardware name: qcn9274 hw2.0
> > >     ath12k_pci 0001:01:00.0: boot firmware request ath12k/QCN9274/hw2.0/firmware-2.bin size 15134776
> > >     ath12k_pci 0001:01:00.0: found fw timestamp 1722934582
> > >     ath12k_pci 0001:01:00.0: found m3 image ie (421880 B)
> > >     ath12k_pci 0001:01:00.0: found fw image ie (7229440 B)
> > >     ath12k_pci 0001:01:00.0: found dualmac fw image ie (7483392 B)
> > >     ath12k_pci 0001:01:00.0: found firmware features ie (1 B)
> > >     ath12k_pci 0001:01:00.0: features
> > >     ath12k_pci 0001:01:00.0: using fw api 2
> > >     ath12k_pci 0001:01:00.0: dualmac fw selected for board id: 1005
> > >     ath12k_pci 0001:01:00.0: Assign MSI to user: MHI, num_vectors: 3, user_base_data: 0, base_vector: 0
> > >     ath12k_pci 0001:01:00.0: Number of assigned MSI for MHI is 3, base vector is 0
> > >     ath12k_pci 0001:01:00.0: Assign MSI to user: CE, num_vectors: 1, user_base_data: 0, base_vector: 0
> > >     ath12k_pci 0001:01:00.0: Assign MSI to user: DP, num_vectors: 1, user_base_data: 0, base_vector: 0
> > >     ath12k_pci 0001:01:00.0: irq:18 group:0
> > >     ath12k_pci 0001:01:00.0: irq:18 group:1
> > >     ath12k_pci 0001:01:00.0: irq:18 group:2
> > >     ath12k_pci 0001:01:00.0: irq:18 group:3
> > >     ath12k_pci 0001:01:00.0: irq:18 group:4
> > >     ath12k_pci 0001:01:00.0: irq:18 group:5
> > >     ath12k_pci 0001:01:00.0: irq:18 group:6
> > >     ath12k_pci 0001:01:00.0: irq:18 group:7
> > >     ath12k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
> > >     ath12k_pci 0001:01:00.0: cookie:0x0
> > >     ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
> > >     ath12k_pci 0001:01:00.0: WLAON_WARM_SW_ENTRY 0x2
> > >     ath12k_pci 0001:01:00.0: soc reset cause:0
> > >     ath12k_pci 0001:01:00.0: MHISTATUS 0xff04
> > >     ath12k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
> > >     ath12k_pci 0001:01:00.0: pci reg 0x3164 instance 0x11 read val 0x11
> > >     ath12k_pci 0001:01:00.0: setting mhi state: INIT(0)
> > >     ath12k_pci 0001:01:00.0: setting mhi state: POWER_ON(2)
> > >     ath12k_pci 0001:01:00.0: mhi notify status reason UNKNOWN
> > >     ath12k_pci 0001:01:00.0: mhi notify status reason MHI_CB_EE_MISSION_MODE
> > >     ath12k_pci 0001:01:00.0: qmi wifi fw qmi service connected
> > >     ath12k_pci 0001:01:00.0: phy capability resp valid 1 num_phy 2 valid 1 board_id 84934656 valid 1 single_chip_mlo_support 0
> > >     ath12k_pci 0001:01:00.0: intra device MLO is disabled hence skip QMI MLO cap
> > > 
> > > Alexander Wilhelm (11):
> > >   wifi: ath12k: fix endianness handling in QMI host capability request
> > >   wifi: ath12k: fix endianness handling in QMI phy capability response
> > >   wifi: ath12k: fix endianness handling in QMI firmware indication
> > >   wifi: ath12k: fix endianness handling in QMI firmware memory indication
> > >   wifi: ath12k: fix endianness handling in QMI respond firmware memory
> > >   wifi: ath12k: fix endianness handling in QMI firmware capabilities
> > >   wifi: ath12k: fix endianness handling in QMI bdf download
> > >   wifi: ath12k: fix endianness handling in QMI firmware m3 info
> > >   wifi: ath12k: fix endianness handling in QMI firmware wlan mode
> > >   wifi: ath12k: fix endianness handling in QMI wlan configuration
> > >   wifi: ath12k: fix endianness handling in QMI response
> > > 
> > >  drivers/net/wireless/ath/ath12k/qmi.c | 149 ++++++++++++++------------
> > >  drivers/net/wireless/ath/ath12k/qmi.h | 106 +++++++++---------
> > >  include/linux/soc/qcom/qmi.h          |   4 +-
> > >  3 files changed, 136 insertions(+), 123 deletions(-)
> > > 
> > 
> > Frankly I'm shocked that the low-level QMI encode/decode is not doing the
> > endian conversion. Since the Qualcomm internal tool that generates the data
> > structures has always generated structs with cpu endianess (i.e. u8, u16, u32,
> > etc) I just assumed that endian conversion was handled at a low level.
> > 
> 
> I'm suspecting that those tools, just like this implementation, is
> exclusively tested on little endian machines...
> 
> > So should this issue be pushed down to the QMI encode/decode rather than foist
> > it upon every client's read & write?
> > 
> 
> It's been a while since I looked at the implementation, but conceptually
> I'm in favor of this.

I could certainly implement the endianness fixes in the QMI code. However, I’m
concerned that other drivers might depend on the current behavior. These changes
could potentially introduce regressions, which I would want to avoid.
Additionally, I’m already seeing some Sparse warnings, and I’m not entirely sure
how to handle them properly at this point.


Best regards
Alexander Wilhelm

