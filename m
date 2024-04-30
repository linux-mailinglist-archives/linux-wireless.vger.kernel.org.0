Return-Path: <linux-wireless+bounces-7065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DBA8B7E62
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D77528188C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7891B17F37A;
	Tue, 30 Apr 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EexTYneK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB117F36E
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497968; cv=fail; b=VxwXNGsCyFNJX55JaQzLqL4detkyZiBgbRLLU5oSMmSWHVE6f1bFjBpiRAun53RpNl7vCwqH2fYmOSURBSTeJfsXDNcPDN4he+0Eq2HbbBZ5oqHG59d0NGPVYEowxdPnapI0KB7/OMDRaiNQq/0r1/shsEh3tov9Dnt8ibUWLwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497968; c=relaxed/simple;
	bh=kcWoni8oOkjnOrwwmlbVOhLcbKTDuFwiGFHaEw+6fBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QcMEkuWAAThcNqHXfm2JYRPnzg9d6SSmTDevatK+mLWy/PDOsGlW8D6CFZh0UvTR9pifOfw0KS5z2VBFnSDkgwqqvLlnsn4nVZBnwRxLmnouIgMIvTWudTWLoDtER6bcsL/E03EL4ax1+LRCK9I8fTZL8bi6Pded9dAuV06pYQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EexTYneK; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UGnX9H007332;
	Tue, 30 Apr 2024 17:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=kcWoni8oOkjnOrwwmlbVOhLcbKTDuFwiGFHaEw+6fBo=; b=Ee
	xTYneKAM7BEvrR7ThiDMzLR5ASxQWwnFzJOmhrEoPWiC/zR/+1EPp2L9EjdliNDZ
	Gg5BjDI3LO3KeJElouUroufmcFSkZCzfyjrIaU4I8wg+rR31FAzxUD9UZFMI14XW
	PzoRxSCOhV/Iv6wtYJflJh84tpUTpdsGFshm/7cN02llfSvgvn8M6FpdY4jsNc0N
	bg+YTTABir5IvD+10P3UooDbiOWoWLxtpto02jkuRMy4VYwPqbn8VUjIDgrNuzoj
	awfKHtbDd2uVItyY8GlrBMoG8WcfywTUYhsMbd5XaXnj4dQDSeVawj+dXRgDLfaf
	R+0JUWcBbAjoPCcAjQsA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtm3uk384-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 17:26:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MATa2tknH/dNhYzeW9zSov9R6KEYfzMVNL90jSf+f19Sl+IhBy31CbnweXaSvTo3GWSveX4Sog7feTmwFzdpn5y3vp9lLZT6teUS0nRlChjVIce6TBz/zmtpAIsBt55BPOdOHJXq5w8PAkjEmN81rekU7ueFrgoUxKWMJSWpp3KpOvGJkMZ5KhcyRk8XVXWLtEi+ikhcmtyjf/q8p8Ur54FrnXwqh2R8C5UPA3daNclfEY/tjKfjA+02gJMdPT/lp7H2s9sQJocnukZVyB1i1XKMvk+RulIj+c7oVul6I4CdDRG2W5czyLMx/jEPOwTpJno2Ne0JYpxTDnFBXu8f8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcWoni8oOkjnOrwwmlbVOhLcbKTDuFwiGFHaEw+6fBo=;
 b=hZuGar9Qq6kEatwKWKho9HB/g6B9VV3UkGlen32izGCzky7qjsIIiaTuLcccLG1Qm6Wo1r5pPYRmcswKsnXIiOuWbqnSS9bTHW0VG3/Tk6pa4b+URcYqw9xt8y3a/WhmLZv1F+Xo8D/wjk2BxUEXf7Oiwv9JYgIPuEE9a3MfSAfYooWqyvQVJNNgc3SPT2q9QyZfIqCAi/1ESjA0xPF3F3GApy5YbuuKxqBPXxY9LbFXFjelW2C04XCw8ejlAWWr7bJ2PClWf/WWhFWbPKC9+YOifTlO7qu3VtSvl09FBXvlFO1u5pe3GxC81djikvSf9jnOoISdPsADp9fjCcY4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA1PR02MB9574.namprd02.prod.outlook.com (2603:10b6:208:3f2::12)
 by PH0PR02MB7429.namprd02.prod.outlook.com (2603:10b6:510:9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 17:25:53 +0000
Received: from IA1PR02MB9574.namprd02.prod.outlook.com
 ([fe80::1cfd:3085:112a:7637]) by IA1PR02MB9574.namprd02.prod.outlook.com
 ([fe80::1cfd:3085:112a:7637%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:25:52 +0000
From: Ramya Gnanasekar <rgnanase@qti.qualcomm.com>
To: "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        "Ramya Gnanasekar
 (Temp) (QUIC)" <quic_rgnanase@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/4] wifi: ath12k: Add support to enable debugfs_htt_stats
Thread-Topic: [PATCH 0/4] wifi: ath12k: Add support to enable
 debugfs_htt_stats
Thread-Index: AQHamlwSof+PSJ2PAkaJi0Hdx3OjvbF/xWeAgAFLqhA=
Date: Tue, 30 Apr 2024 17:25:52 +0000
Message-ID: 
 <IA1PR02MB95749A2932C41D5F5046BED9F11A2@IA1PR02MB9574.namprd02.prod.outlook.com>
References: <20240429173825.2369355-1-quic_rgnanase@quicinc.com>
 <adb4e20d-a6e5-4508-a3d6-9c46a1aeebaa@quicinc.com>
In-Reply-To: <adb4e20d-a6e5-4508-a3d6-9c46a1aeebaa@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR02MB9574:EE_|PH0PR02MB7429:EE_
x-ms-office365-filtering-correlation-id: 2d6076ff-0ea4-49ac-bcf4-08dc693a9603
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eVFFM0VRRExRcHRoc21iY3NtaFY5bmREUFAyUjB3bWYrWDljc01OaXJOcXJa?=
 =?utf-8?B?UkFUOHdHbklxSVl1ZDNhVmVIVCtpbHA0dzBDKzlzZXIzZmNOV2hBclBVVHFO?=
 =?utf-8?B?N2h5ZkxwWHVNdE4xRXVkOThlTE5OVDhzYzA2L1greXZKdFcvUkh0TDRUbC9w?=
 =?utf-8?B?Y0hWYW5tc2kvUmlHRjJ3cTA4N2V0YWd5ZkFqTTNmUWllWEJDejhKWkEwZTFW?=
 =?utf-8?B?Y2NqajFPTWhmbmR5NXd1MFcyZWVFSmE2d3BqcmhnNmpIaHlxZFNab3l3Vi84?=
 =?utf-8?B?MnFuQkF4NnFFVkFKYjgzbVRVQTRuWXpjV1RINVhEN3o3USsvQnZxUFB3RjVB?=
 =?utf-8?B?K0VENnUrNTdsZUgvUkZadkFLaHROYVQyQnRDQmRlZnV2S0ZjMjdLV1l3azhU?=
 =?utf-8?B?TUlzdEEzY09QZXJseDFJazl2SjJYTm1ORTJIU2dCUWJLcUxxTWc2Zm9rVDdP?=
 =?utf-8?B?VEdCVFlCWUtIRDlUSzdySnA2aTNxNlJFVGp0THZLb1hSRExTdzJPVVUxZDJQ?=
 =?utf-8?B?b0R4VFByREVkcS96UENxdW9IT2tkQnFNdVZqcTRhMlNia1FvWXkzR01Cay9Y?=
 =?utf-8?B?VTYyQ01kNXRCVkJoZ1dJZXFwUnFkdVViU3htNUVmbDRYR3hQRzRzZk9KVHE5?=
 =?utf-8?B?NTFFVk93bm9LcHNYKzRsTTJVeG51UlF0aDdUUi9kSThYMmx0U0Z0WmpldFdk?=
 =?utf-8?B?UVhHaFpsTHlIWFZ2aUd2Z1EzTEk0RFB4Wkl6RjF6RXN6emFhTC92SnVXZTAz?=
 =?utf-8?B?MCt5MFhpQnRBdStleElJRFRYYm90Rk5aNlZMU05aak1BUXhpeGtxSVRhcGty?=
 =?utf-8?B?NUJZMnZuOHMvdTgwbThxTEhYVnc2R1l2dWhzUGtpc01sWHFJakE1WWdqRGI5?=
 =?utf-8?B?bmw4UkpnRXJrSlNHeTNKSkJDdWdZZDNIS3dJOHVnMDYzbkpQWTJKTXJlRWxV?=
 =?utf-8?B?dnhIYlJxT0RCZEw1Z2lUaHhvV252STVUMjh0VEp5MEhUcTEvb3JJbHZFUU85?=
 =?utf-8?B?dGxONEczMzI2dXBSTUc0SVk1c2RpemFDWmJXa0ZrSEdreHBnNjJpMXlleFly?=
 =?utf-8?B?emxlZEk1MnpsT1FYT1Q3ZTVuVk9sK04yZy83b2NFNDZzWGtYMnhWQnNCSHRH?=
 =?utf-8?B?cndkazdnLyswQ25qS0NMRnhsN3BkMmpuYVYxZnJ5V09uMWJlbkJDRHgxcXlS?=
 =?utf-8?B?Q0thd2NuSVFhN1dQTCtWTVZudjArV3JpYWd1L3UxNEtVRGh3M1BKZEpNSXNX?=
 =?utf-8?B?UFZMdHdEVnk0b0J4SGhwUEs3NFBEeWlpbnozdmdnSDRvTER1SWc4NjkwV1Mr?=
 =?utf-8?B?d2ZVQVdjdEVNTkVRNG94TnM4bFg1d0pwMWhEWExtcVRxck1NWXU4OWtyMjVo?=
 =?utf-8?B?Yjh5bG9kQ1VOeXVPclVvcmduR2NuZGdvaDhjTy9neXFsc1REVnhjN05pKy9P?=
 =?utf-8?B?OGRSaWkwNE9SZzhPWHRZY29Sb01POXhGMytjTzJ0Q3FTOFg1ZXUxSzlDRVZK?=
 =?utf-8?B?akwzWFJ5OW5EdCtrNDYwRjRpc2tOcTNqVWdoOE9yM2Z6T0pWVFJlUHNjem1Q?=
 =?utf-8?B?ajNEbkRXZ1NPaXBUdjhuMENseVd3ZEFDZDZ3cnRta29SSHhNRW1XQWc1K2ty?=
 =?utf-8?B?OUF1WFVPMHAwMFdaRTlMajNzeUlZL0Nhd283amxBSnZzL0pGM0NGN2lmb2Yw?=
 =?utf-8?B?ZE9OamJaSzcxY2lNbDM2THZqWHhZcTNMb3IwZ0U0LzE0ekNTOXN1OTJyWnp0?=
 =?utf-8?B?dHBDSGtyajZRUXNMcDIwdWQxT2M1Sjg4azcrNm1lYStVTWs5RklGKzMvUnA5?=
 =?utf-8?B?UFZyaVRTSnJPQUpGUFhBZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR02MB9574.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c2FZak9MS2xGVW15a3VPTWFzQ2h2NmxBd29XWWcwTVlpT0JLTUdudm9iVFd2?=
 =?utf-8?B?ak05VGwzZjJNLzVtYmRaOFhoSXhEenZpeURYMng3emVjWGpLcEw1dVRZSmFv?=
 =?utf-8?B?cko4Z3dlYytReXJvSzlBMFVQN1g2YmJRYWkyRGpBbzJpczR1SjAwK09HUXFL?=
 =?utf-8?B?N2pvSlhySmtJeVMrcFNQc3hCMEhpaUtlNWFGWVlidmo2bmM4Um9MSnNyL1FC?=
 =?utf-8?B?aGwzVnRnMEpQeVFQeGdSQWM0QnNHc2o2d25QTm51OWZaYmtJcnRzekJ3MkRC?=
 =?utf-8?B?TTZjZW8wbzBNbVBEbFJYSCs2SXpGM0JSRXJCOUdCSFNPekErY3IrU0VSWS9V?=
 =?utf-8?B?NWZiLzJ0cGJVUllTcUI1ZTc1NFFUOEpobHdLeFFSem5zMXRiSTlJRndTNUFi?=
 =?utf-8?B?OG85TzNCYng0OGtMSFZZWktIQk84VFBuY2NFYjlQSGFjU2xmdWdpTkVsSWti?=
 =?utf-8?B?bWZubFRWZzh4djhwQXVSK1oyeDNtT2tSdXpjRU1KLzBtQWN1Yy9FSE1nTkpC?=
 =?utf-8?B?NUhXRlBRelFuM0YwcU9KS3NiWW5XaCsyL2JyNlkyZ3RyYzZSaU5oTXdGbDMr?=
 =?utf-8?B?ZTFNZy9Gczl3NlN6RXhpSHIraFpzM1ZaZjNqNEE0dE92NjBDdEVncmQ0Uity?=
 =?utf-8?B?Tk9yTGgzU0k4bFVIUnNhTmRQUEowRy9waDQya24xbURieERNZWtxRDJMeVJz?=
 =?utf-8?B?bDdKbUcyNnZwcXJ1TGkvNnJSQTNXUENsTHhPeTVQemhmWkFseGNKaGFuVUFk?=
 =?utf-8?B?Umlsd0ZiQ3JnQXZ0c0xZeXlEdWppZ04rTk5hdFZzSVlrOHJtM1JlZzhScEZ1?=
 =?utf-8?B?QVFLQnlmZHhDdlZUVmZsTHZTcXBJTG9qZUVBZzV2SkNlM2ozZW5ZUnlRUVlK?=
 =?utf-8?B?YUxDN205ODNKaC9ncE5qSTU3NGNnOEw0Wm5KOEJOWmJJVE9ZQWNGTnNjUDA2?=
 =?utf-8?B?YUxJOGY5NGkzK2NrSVlMeStDcnVIOVZyWEgxNytTa2xrSzJKdDR4Ung0bERh?=
 =?utf-8?B?Um1WYWVvS1FXckErYmUybWF6RUZ2dFVwT3F0WXJ6ckJ4Qk5FZlRHVUl1TlhZ?=
 =?utf-8?B?NWx0RXhZUnJOMms5ZE9LQnpyTHJEVDNnN2prYVZTRUowYndjSGpNNUphRVNh?=
 =?utf-8?B?bnVmbHgzc3UxT2xaQ2dycTBtTWY0N3FHZzVBVnNoWDZDbnM1K3ZsTnlLOFpU?=
 =?utf-8?B?c1g2MHdKNlRyclR6ai9jMUhTYU1CMXh5Z3pWdVJKd1pOekF5ZmZMWi8ySlE3?=
 =?utf-8?B?eE9ZMVNlbko1SWRnL01CRkVkc1dicFJWK3Q4SzFjMURzei8yQ0ZNcWpveWpl?=
 =?utf-8?B?TjdmVnpwd0tCZFV0LzNzN3cxc1N3cjZ4QU5mL1JRTFZLYU5TakFQaTFmcnJ4?=
 =?utf-8?B?T2tPUXVjRmVZNXFnZUlMVFBhTlo2ZFRMWk50SFZsVFhhdHYyOEozeGlSbE10?=
 =?utf-8?B?ZFNCaHRKUWtzRUYzNXIyWmZnZnZORVliUGlib1VCeUdZaElxSXU2UzBPUWZ4?=
 =?utf-8?B?b1hWbkRNbjJ4bjVPSlpUY0p5a3FkeUdJNUllT2VSK1JnTnlrSTBLNlhOdTJ5?=
 =?utf-8?B?UkYrejFjYlhHbzBlSHdDNWhyK2Rhb0x5OFRCaFpsNnRiNTJYbk5vU0JaT2ov?=
 =?utf-8?B?cTNZdnB4K1Z0S2N5ajJISDErNnlvQXdXMzNGeWQxRmxEZGFkNXVEeXMzYXNn?=
 =?utf-8?B?aWl0cmtwdGttQnh0Zk5hZ2JZUzNRRlRzc2w3WS8xSW5XY2hqcDVmQkZUWnRF?=
 =?utf-8?B?bmdXU1BuNjB5TDNmd1locUFBdU92bTNJNXVYVUY4L3FFSktJaUUvR0JtcGZL?=
 =?utf-8?B?KzRETDNrVGwwMjNyb2VJcFdYOGV4Mk1aRjhieWl2bUw1Z2ovNVRxbUduZE5l?=
 =?utf-8?B?VzRDWEdLdzJsaFJ5bm1Ub2xiM0xaZVR6TjB4T0JDMnFsU0xIMzZuL2F1V2pn?=
 =?utf-8?B?Zmg0U2haemc2TGQxQ2hFN1N1QTQ3aG1BNVBGOFh2d1pKTFQvZUcvS3NDL3Bq?=
 =?utf-8?B?MjZtMGYrY25LUWNtT2RXS2RBSDBpZGgvbFVQdHZNQ0lEK3U5NmFzN1FKMTVW?=
 =?utf-8?B?QnhZWTI1SFJ4dTJHcExweWo1UVJaUGtsZnIvRFVHVlZxMjRFMWY1bEw0c1Bt?=
 =?utf-8?Q?m00ghhj8nDZhvuWeZtXOQCEoi?=
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
	3ATaoOJvBMZpH3o6H7fBBA3XzkkuEEjoym2t2Y5Ir88EnhRMiBJ5YvYmBWlgo8zzzcypEW1UnwBYGt3NIrpxaGVtg0+QOOPopuhVyhstU909ltIFGTjYQe/KpR+gMBMiavplXNJaDu7nygpu+S4YUQY2+ABxr+RuDDcOKmvVxzYWF7ONmJWY87dfw6vZ5iZuJBMFXnqsh8gWl668xLVzVWjlccb0ligsRu7LhGpX8zTc4MhxPwMRUJzH5oVGpVIBOlQf7UX5YNf2K9/nTHECvdNlAGGv/W/+A6Uba0D6HS3zvTk1LryQ5bgbl/02Rhc0JdXLR5jGVKsiOTrBjCR/pPr1gUl8YDmmdZcZLbwrr/uNfMFgZABrmHTfS/tPXhsSkFkcgkD7BszKDOJ2EPpWKWfvsZjNdjcnEKaw8BcX7f+mreHFK77GC6UFUjtjFwgRBAWDWPHP3JMr7+kEBqps5I/3G+N/l3Zfvtg9tXk3Ak7D1MZI67lUv+XW+9Z3CwuRcNkWfvvsuERXhslwbSvx5JWTslSiDPZPX6+Sqt5q7zq35oNN2qeyYA0eP8sk+eK4occsVAlH61ictsVISZQE9v0mMswPFqtEf+wtfOdnbm3VXBMnpzCiGgqcjl3yc1mt
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR02MB9574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6076ff-0ea4-49ac-bcf4-08dc693a9603
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 17:25:52.5115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FX+ZgfGO+JX6Y3Q+dj0KOGXHRBuB+qBw/2GVpqV4I2s1sM0g/rNAG3ni2RbsQpLf/862kkHmq9AJHJuIw7S3EvmJFk24EN8/QW4Y+5UvLyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7429
X-Proofpoint-ORIG-GUID: eYpcAgFkJ49PchLpWGdlucnbsPLyDAa_
X-Proofpoint-GUID: eYpcAgFkJ49PchLpWGdlucnbsPLyDAa_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300125

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEpvaG5zb24gKFFVSUMp
IDxxdWljX2pqb2huc29uQHF1aWNpbmMuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAzMCwg
MjAyNCAzOjA1IEFNDQo+IFRvOiBSYW15YSBHbmFuYXNla2FyIChUZW1wKSAoUVVJQykgPHF1aWNf
cmduYW5hc2VAcXVpY2luYy5jb20+Ow0KPiBhdGgxMmtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBD
YzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MC80XSB3aWZpOiBhdGgxMms6IEFkZCBzdXBwb3J0IHRvIGVuYWJsZSBkZWJ1Z2ZzX2h0dF9zdGF0
cw0KPiANCj4gT24gNC8yOS8yMDI0IDEwOjM4IEFNLCBSYW15YSBHbmFuYXNla2FyIHdyb3RlOg0K
PiA+IEJyaW5nIGluIHRoZSBiYXNpYyBpbmZyYXN0cnVjdHVyZSBuZWNlc3NhcnkgZm9yIGVuYWJs
aW5nIGh0dF9zdGF0cyB2aWEgZGVidWdmcy4NCj4gPiBQYXRjaCBzZXJpZXMgYnJpbmcgc3VwcG9y
dCB0byByZXF1ZXN0IHN0YXRzIHR5cGUgdG8gZmlybXdhcmUsIGR1bXAgdGhlDQo+ID4gc3RhdHMg
YW5kIHJlcXVlc3QgdG8gcmVzZXQgdGhlIHN0YXRzIGZyb20gZmlybXdhcmUuDQo+ID4NCj4gPiBT
Y2hlbWEgd2l0aCBvbmUgYXRoMTJrIGRldmljZToNCj4gPg0KPiA+IGF0aDEyaw0KPiA+IGAtLSBw
Y2ktMDAwMDowNjowMC4wDQo+ID4gICAgIHwtLSBtYWMwDQo+ID4gICAgICAgICBgLS0gaHR0X3N0
YXRzDQo+ID4gICAgICAgICB8LS0gaHR0X3N0YXRzX3R5cGUNCj4gPiAgICAgICAgIHwtLSBodHRf
c3RhdHNfcmVzZXQNCj4gPg0KPiA+IERpbmVzaCBLYXJ0aGlrZXlhbiAoMyk6DQo+ID4gICB3aWZp
OiBhdGgxMms6IEFkZCBzdXBwb3J0IHRvIGVuYWJsZSBkZWJ1Z2ZzX2h0dF9zdGF0cw0KPiA+ICAg
d2lmaTogYXRoMTJrOiBBZGQgaHR0X3N0YXRzX2R1bXAgZmlsZSBvcHMgc3VwcG9ydA0KPiA+ICAg
d2lmaTogYXRoMTJrOiBBZGQgc3VwcG9ydCB0byBwYXJzZSByZXF1ZXN0ZWQgc3RhdHNfdHlwZQ0K
PiA+DQo+ID4gUmFteWEgR25hbmFzZWthciAoMSk6DQo+ID4gICB3aWZpOiBhdGgxMms6IER1bXAg
YWRkaXRpb25hbCBUeCBQREVWIEhUVCBzdGF0cw0KPiA+DQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2F0aC9hdGgxMmsvTWFrZWZpbGUgICAgICB8ICAgMiArLQ0KPiA+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9hdGgvYXRoMTJrL2NvcmUuaCAgICAgICAgfCAgMTEgKw0KPiA+ICBkcml2ZXJzL25l
dC93aXJlbGVzcy9hdGgvYXRoMTJrL2RlYnVnZnMuYyAgICAgfCAgIDMgKw0KPiA+ICAuLi4vd2ly
ZWxlc3MvYXRoL2F0aDEyay9kZWJ1Z2ZzX2h0dF9zdGF0cy5jICAgfCA3MTMgKysrKysrKysrKysr
KysrKysrDQo+ID4gIC4uLi93aXJlbGVzcy9hdGgvYXRoMTJrL2RlYnVnZnNfaHR0X3N0YXRzLmgg
ICB8IDMwMCArKysrKysrKw0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL2Rw
X3J4LmMgICAgICAgfCAgMTAgKy0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEy
ay9kcF9yeC5oICAgICAgIHwgICA0ICsNCj4gPiAgNyBmaWxlcyBjaGFuZ2VkLCAxMDM4IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBkcml2ZXJz
L25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL2RlYnVnZnNfaHR0X3N0YXRzLmMNCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9kZWJ1Z2Zz
X2h0dF9zdGF0cy5oDQo+ID4NCj4gPg0KPiA+IGJhc2UtY29tbWl0OiAzMjZmOGY2OGYyOGIwYjgz
MTIzM2FjZmFiZmZiNDg2YTViMGY0NzE3DQo+IA0KPiB0ZXN0aW5nIG9uIG15IGxhcHRvcA0KPiAN
Cj4gZ29vZCBuZXdzIGlzIHRoZSBmaWxlcyBhcmUgYmVpbmcgcG9wdWxhdGVkOg0KPiAjIGxzIC9z
eXMva2VybmVsL2RlYnVnL2F0aDEyay9wY2ktMDAwMFw6MDNcOjAwLjAvbWFjMC8NCj4gZGZzX3Np
bXVsYXRlX3JhZGFyICBodHRfc3RhdHMgIGh0dF9zdGF0c19yZXNldCAgaHR0X3N0YXRzX3R5cGUN
Cj4gDQo+IGJhZCBuZXdzIGlzOg0KPiAjIGVjaG8gMSA+IC9zeXMva2VybmVsL2RlYnVnL2F0aDEy
ay9wY2ktMDAwMFw6MDNcOjAwLjAvbWFjMC9odHRfc3RhdHNfdHlwZQ0KPiAjIGNhdCAvc3lzL2tl
cm5lbC9kZWJ1Zy9hdGgxMmsvcGNpLTAwMDBcOjAzXDowMC4wL21hYzAvaHR0X3N0YXRzDQo+IGNh
dDogJy9zeXMva2VybmVsL2RlYnVnL2F0aDEyay9wY2ktMDAwMDowMzowMC4wL21hYzAvaHR0X3N0
YXRzJzogQ29ubmVjdGlvbg0KPiB0aW1lZCBvdXQNCj4gDQo+IGpvdXJuYWxjdGwgc2hvd3M6DQo+
IEFwciAyOSAxNDoxNzoxNiBxY2EtSFAtWkJvb2stMTQtRzIga2VybmVsOiBhdGgxMmtfcGNpIDAw
MDA6MDM6MDAuMDogaHRjIHJ4DQo+IGNvbXBsZXRpb24gZXAgMiBza2IgZmZmZjhjNGU1MGU1ZWQw
MCBBcHIgMjkgMTQ6MTc6MTkgcWNhLUhQLVpCb29rLTE0LUcyDQo+IGtlcm5lbDogYXRoMTJrX3Bj
aSAwMDAwOjAzOjAwLjA6IHN0YXRzIHJlcXVlc3QgdGltZWQgb3V0DQo+IA0KPiBzbyBzb21ldGhp
bmcgaXNuJ3QgcmlnaHQsIGF0IGxlYXN0IGZvciBXQ043ODUwDQo+IA0KPiBoYXMgdGhpcyBiZWVu
IHRlc3RlZCB3aXRoIHVwc3RyZWFtIGtlcm5lbD8NCg0KVGVzdGVkIG9uIFFDTjkyNzQgdXBzdHJl
YW0ga2VybmVsLiBIVFQgc3RhdHMgZXZlbnQgaXMgbm90IHJlY2VpdmVkIGJ5IGhvc3QgdXBvbiBz
dGF0cyByZXF1ZXN0Lg0KV2lsbCBjaGVjayBmdXJ0aGVyIG9uIHRoaXMuIA0K

