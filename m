Return-Path: <linux-wireless+bounces-22258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B31AA4B14
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0F04C0F6C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B4421B182;
	Wed, 30 Apr 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VI2r+pg9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A31C173F
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015926; cv=fail; b=BZITAqBws9xL+8p1t0ADE1RczkeMf+ExnKRAgfBSAMPFPFNe22fzGPe2PJBX+LCicDAxB2hDHEK2itYxBIWE7musSmytK4KSbxurrZa7ODctHk7aqwqaI2WWR164pRkKpfTW2wULEdvZnYKWvooboKaPWzI2RROsZFAlmEPLhMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015926; c=relaxed/simple;
	bh=N7tAHZ9YBoDdsUsQwEc1KiDapkXPwc+QR5OZMxpPuZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R+MrDDL4j2bQtQ5WH7OJ2KfndkJKk7RcaV9d2/ctzuoVP49J9eX1Ff7jRqDl5t4+hk0fx/6+A2ZrOUOBp4eLjW5JAbnerIdPXZuJwtq/sRal7OA0ljfAiauqOI1rZGnPzBB7TAm/NRW5wFz9oCMiYcijTK9OdcTVqQV5CwU85Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VI2r+pg9; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U9Y8O0016791;
	Wed, 30 Apr 2025 12:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N7tAHZ9YBoDdsUsQwEc1KiDapkXPwc+QR5OZMxpPuZY=; b=VI2r+pg91w/FG1PN
	R0OaTW9PzYML3MS+rGn6+OxgPK0pcXJF2V6hsLVnXzSAmdz6Yax2XEUbpsw3zPGj
	WHjAh2IIM6mOHVmPViCY7GDPac30+ehpDn/Xdzt6oE+SB+Gnx2JzbjOVbTWjUe3F
	etehzsgFnvI6qCyU1O+CbzOIWjhhHy6L+OBXNwcq7RIkjTlKr6DGPW8NJop+Zk4L
	VTyIu3QAriMz0xhAwLEqpx6XN6M7lxe0250z/qHZa4sfH4G4Gqhh5K2A/DhpoVbD
	zypxlp0ZWxGpNSrTcWayrcYx7UusPsdx26rCi5KNjUTp0R74bQaf8irIXr/p1UIw
	vojnqA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010002.outbound.protection.outlook.com [40.93.20.2])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6uaa46c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 12:25:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEK4Gx+tpnUGQl4LTDTP2EpoSG4A8ZEP4uijojE1gf6XZlhDMFFQUEP+IpcFGyX3TDiYAodSO4lqzi8GWhF3Q3gbn/Ml+5hWLbyGnWoHfj92Q6eF9JTS5X+jXLZ7lUfINulY4pK00lgfYwUFUftK0IcsutWj+3P0krfqovryo+ho7/27jB63QPNM9UqSu8OiXIbijRZkanrYVxYxiI9W21F2iJuzXqFkuQLHjGZ/ybAU5ANFLoSk3rj0NOm9b+MP/11ku7SWKeJ2zzB4MDUP6PY3WE2iFlsJtm0VJDpjB3KANT5GI5TWJBd6Lh2WyO54xoudCMNkv5YUGuZtkPb3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7tAHZ9YBoDdsUsQwEc1KiDapkXPwc+QR5OZMxpPuZY=;
 b=wW0oyBIUGyceO0Fkt+4eK/mtt7aSDyN9UmyBQ+UkoRGWZs4K8zcpDFj7n6MiUBlQdoVLG6b8Z9Q5VaoivBe9MAHkMKcNUaKGlUnoxLr4upfSXKqjtBOtbIhKB0zzx0kzhoMQUzxyOXI9mYZA4qBgbGi4iTs6e5aZm4tYE9ciQpvl2FayeDAh6h8mjik/wM6sqjX7YKuntRafgbK9y7r7M8tlyXMjlapxNXQ665TKjLYGtlsHsH0fY7dWznjBveySfLi/mDloL0s6wrLrrrVwd8X/x7MIFFafoRqgPW1LkrjTM45xF4iRYsImkfVmSUxtlRaQsCSOmQHCRLr4CaG9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SA3PR02MB10083.namprd02.prod.outlook.com
 (2603:10b6:806:3a0::14) by SA0PR02MB7307.namprd02.prod.outlook.com
 (2603:10b6:806:eb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 12:25:14 +0000
Received: from SA3PR02MB10083.namprd02.prod.outlook.com
 ([fe80::1b09:fb03:61a8:a84d]) by SA3PR02MB10083.namprd02.prod.outlook.com
 ([fe80::1b09:fb03:61a8:a84d%7]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 12:25:14 +0000
From: Maharaja Kennadyrajan <mkenna@qti.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Maharaja Kennadyrajan
	<maharaja.kennadyrajan@oss.qualcomm.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH wireless-next RFC 2/2] wifi: mac80211: process group
 addressed Rx data and mgmt packets on intended interface
Thread-Topic: [PATCH wireless-next RFC 2/2] wifi: mac80211: process group
 addressed Rx data and mgmt packets on intended interface
Thread-Index: AQHbuZ/y4JtyZKBlkE+MD/liNWH6+bO8AJMAgAAYn+A=
Date: Wed, 30 Apr 2025 12:25:14 +0000
Message-ID:
 <SA3PR02MB1008360AEAF6B0DF92E264C49F0832@SA3PR02MB10083.namprd02.prod.outlook.com>
References: <20250430071435.2201777-1-maharaja.kennadyrajan@oss.qualcomm.com>
	 <20250430071435.2201777-3-maharaja.kennadyrajan@oss.qualcomm.com>
 <940db15452d6dc9c7f4dd074360bacd2c6f315f8.camel@sipsolutions.net>
In-Reply-To: <940db15452d6dc9c7f4dd074360bacd2c6f315f8.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR02MB10083:EE_|SA0PR02MB7307:EE_
x-ms-office365-filtering-correlation-id: bfe03f1b-fe3e-4fb9-ec3f-08dd87e20f0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?STljWVlpS1ZKUVVvUkhqYytGNENBb3VQeUJKS3dGYU9iVTBmOHlpNEdLT3hW?=
 =?utf-8?B?cGN4cHhvVDUxeENDdUdlejIzN0pFUTFEaVUrQllJN1A3YVZDMmhZTmxtUDhz?=
 =?utf-8?B?OFZXNWh6RmY0OGdzcXBtQWRrM3krWEFoMlNVQ2xpdlhFT1RmSGU4ZHhDVEpr?=
 =?utf-8?B?T3dySHNCeWlnM3NJb1YyNCtPTVN4bkMzd1VPSk13MjFHcWlMYk9PR3c3a3ZC?=
 =?utf-8?B?VDczOVBiZ0NOQXM4Mjc3MlpRK2R4MjRnc0JXeFE5Rnc3RCtsTFYwWitINjZo?=
 =?utf-8?B?b3J2LzdTbHZjY2l4ZU8wT3gvZElnNURmeDJrWWJwZWQ3RXJ4aVVNa0MvdUly?=
 =?utf-8?B?c0tHZ1dMblJSS0RlUUhCWko5UHVUNDhKQWhNcnhRd0dsQW5GZ1doN3RvSFlO?=
 =?utf-8?B?T001M0hLL2tvcW9nUSs0TGZFdGkzTkdBTEtMYkVRaS9BZFFkSnVYdnFmUGU0?=
 =?utf-8?B?RksrbENXZ09hdkxscTl3OHB6RkpLVm9PYVNNcnhpZHdTTXVMR0U0NzhwanJ1?=
 =?utf-8?B?UXc0cTA1SUlpdFc4dnVGZ09qT09rS0d1dW96a3pEeXFKZkk0UEExaHp6dENM?=
 =?utf-8?B?dnBraUxZUEw4WmFkMkU4cVk4dWFQOWdEUGdVWjNudlJ0MEhrdzI2Y0Rjc3Yw?=
 =?utf-8?B?RS9QcjVQN3V1S2d0bFhlWUJPRlcwYXNLclltMTEzT3NHVkM2WGNLaFpYc2lK?=
 =?utf-8?B?dGx5TXNmUlAwWk5DU1RnTGxHaWdKalluQlE5ZnRDNFpxNE5WTXJidDFqMnFQ?=
 =?utf-8?B?d2w0UkM4U3p3MGJ5Z0ZTUGpwKzgvcXpUSStxWXBUVUZ6cTYwL05XYkVJTjI3?=
 =?utf-8?B?Q2FDeHNINTVJclVJbzNhem56MU5GOEJhMHU2WWZtb3NwZUFGa0FWK3BZTFVL?=
 =?utf-8?B?cFVyaEd0OEY2MWVaaC9VdVIxZEtldGpxQzhPSWI5Y25ITTNQOWN1UDJtUThW?=
 =?utf-8?B?cTlwTXRqTlVEQzJKTm1lVTdjUVlzbG1yaUxLSUhkRjNYSU1IRDhXdGFKVHlG?=
 =?utf-8?B?RUQ1ZDFGVkpENVZIc3l3M0NoYjliTW9jVmtrY2dSU0FYaU9hTm9MVXJZU3BD?=
 =?utf-8?B?Wnp1T0NVd2RvVktWUWtrWUl0YUF0eENNV2RjYlRsSUJhZm5Cb1lrNUNGakRR?=
 =?utf-8?B?amRrT1pFdk9VcXRsS2lCdkdITmE4U0oweWJkeThZU0RjTnRBMTlSQTB1UVVG?=
 =?utf-8?B?QjFWTkR2aTRCcDRlZm5UTXo2WFR3elhZMEx6WFFENWM4UFcwM0VSUVlSWFVl?=
 =?utf-8?B?dGJJSDBTS25YWWNvMkt6b2Nmd1dyOGpnVFQxM1RQa0RpM0J3Y3drT3ZUTUI4?=
 =?utf-8?B?TVZhaU9XTnhsK3l6Ukc1Tnl1YzFudE1nbXJad25vOEI2RWpxUVRySjRMeVJu?=
 =?utf-8?B?VkMvS0liSWFSRlcyNHZoOWpmTXFMcXVXbjhLT1huRWR3cG1kMXRZL0c3ZjJ5?=
 =?utf-8?B?S1dKUzZKbi9jOC93R0U2eC9CVUl1TkkwMVA1UUROT01jRFoxSnNhNWxXSjlX?=
 =?utf-8?B?OCtGZmZaZHZZaGZVY0UzNGFob21HY0wxa081cTMyU1VHYVkzODBkSnA2WFRZ?=
 =?utf-8?B?RjJDOUhRY2p2VmtKTTQxUG10ZHJmWE41cVlaNXpuVFUyOTVWZ0kvUzllT2Vk?=
 =?utf-8?B?S2ZQQ3dkZDFNQnpteXBsSVE1aE1SeUI0Y3lPKzJlMDcvQ0FyUXM0RHhaM2xk?=
 =?utf-8?B?UXE4TlFNNlJoY3pSV1ZHdkk3a3FHV0wvY0ZKUlcyd09PUi8zSUdjcnFpcWJ4?=
 =?utf-8?B?UlpzSlE0dW1sMVpyOTJFWnpvQ3MyRlpLaUFTNWtMQUxMWndwajVNK2xJQjla?=
 =?utf-8?B?dndnU2xJbVk3WDZLWEJNVmIzTFh0ZlVnT1RHTDQzRlVnck5odHpkQ3Rvb1dU?=
 =?utf-8?B?WTB3THZYT2dDdzJUWUpLcWl2VlN1U2ZvWFZLL0hIN0I5NDJCT2QwR1RTbzZl?=
 =?utf-8?B?ZWVUOWFUeFl2UFVySm1tN1UxTXdwcDlpL3BDaUhQZE54bnF1emkwRC9kMmNW?=
 =?utf-8?Q?4Tg/C9FzAyc5qLC/w/jqmOdBRPg6PE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR02MB10083.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2VTb3ZvekZSVnJjbENyVko0VHYrdlNtVmxmQVJzaTB4WHJmZVkyL2x5bEdJ?=
 =?utf-8?B?TUQvY0VlaUVNNE9GaHlNYStqRDBldmtzMDI2RGNBR3hTVG8zRC9sNllBdEJS?=
 =?utf-8?B?RFBFUEdTTlRzUGt3Rk0wZU5jTXpFc1NzY2drK3YxWlhRZFhQTDlOS0V3alZy?=
 =?utf-8?B?TWRwcWFJUzRDWmlPTlhtNDg3YjBRdDZZbVFmbkY4SU5LYXRiY3hQVWZiaHM0?=
 =?utf-8?B?bVpNUlZ1V2NJa0VRNjRrWjFFYWNNSjhVR21ISkR6WFRqcXZ6NnF0ZXRQTG04?=
 =?utf-8?B?TGxpTS9GVnl5S3dpNmhCbFpLZTNJUzZ6OE9pVzljcVhpd0RXK3lId2NPSW4w?=
 =?utf-8?B?RlFzZVRUWjEzR3FCSTRiSXhqNXpaRzV1TUIvcnZJMk9ZQkZKcEFYQnEvVWZ6?=
 =?utf-8?B?QjgwRlV1YzdITjFPZkpnWTFGYkpTU2FhRzVpRERtQnhhUlBFWkFXZzUwVjlK?=
 =?utf-8?B?UFhkQktNLyt3RUprMHlvOTlBTlJlN2x3UDgwRXgycU9NeE92TjNQVWxtbVcw?=
 =?utf-8?B?UlovMzlyTERoN0lzcUxmZjFsNHFaS2RROEppamQrWUJaM1RiazNwYWMwMUhZ?=
 =?utf-8?B?dm1lYXppZFI4MUNjeC9SZ3FhTWdyaGJFWk9xbXFUZDdKTWloOFBnLy9KZ3Ju?=
 =?utf-8?B?SHZ5TG4yUDA5TVdZQ0JrZ09BcVNhVEZUNUtCaUxXY0RNZHUzSjRIM1F6WTV1?=
 =?utf-8?B?L3FwU2FtcHRpd1FTalRwZ1F2WjdoTDlEZDhVQzJtclVMMzhJalhTeHBjM1Yy?=
 =?utf-8?B?Smp2aGlQQnRoaldxWG1qN3c3bEJpWGpxb2JkUUZlaE5FSUI3TDFUY29PZ2Vz?=
 =?utf-8?B?Y20rVUErdy85R2hsTWlSYURPZ0dGVTFWczdmd3dvL2piaFUwbCtJc0dWYkI3?=
 =?utf-8?B?K0pLUXltMmh0NS9sRkE3ekZnL1FvQlJHaVBIRjBJZFJDdlNBUTRYbEx5Lzhk?=
 =?utf-8?B?WHlBTXhtTVhuaW1ZUUpYSHROYmNESnlLL09HS1VXMWZ6aVRsOGROSGt3eG5t?=
 =?utf-8?B?eHdoOVB0eUxpUVpCYVhRSCtrS0NiSlZTTlk2TzRKOVFCSGFaWkhEWHFjZTlE?=
 =?utf-8?B?QWx1akU3WnM3T1hDZ3BWN3FhNkVzTEs0WUtsMWxlM2ptNFFHWHBlVjFTaE5M?=
 =?utf-8?B?RlZCNno3czVqdlQ3VHZhRkVDYTV4WktudkczT1ZNUXZmR0RxMCtuZE9SOVpZ?=
 =?utf-8?B?QXltVmtUSzd4L2pmcFhoc21qVEp3aEZ1SDJ3VUJacVpFZ2p0VjUyK2tJQUpx?=
 =?utf-8?B?dlR0d1dNeUhSdlVROEFQbUE1TUpqOE5CUk1ldWlZWUVIaXZ1dVRZaVRCUElm?=
 =?utf-8?B?ZDRTaWlGS0JITFRlQVFnS1IvUGwxaXd2ME44VVlObDNkR1l4bnp1S2YyVkx1?=
 =?utf-8?B?S01TMCtSdzY4K251NWdTZ2Y3YkRVaFhxZGQ4dGJDNk1WMTdTRHBxWjU5aVpV?=
 =?utf-8?B?dWdSVkRZWjUva3AwZU1VWjQyTnQvd1RDWVZWbnBsbEFQY1ROZjFjZXR1RXpn?=
 =?utf-8?B?YUZURXJvbEE2c2x6dHlYRFFVNUJvWmExd3lZdURQQmVRalVaZUxrNTFKdlV6?=
 =?utf-8?B?QWJmaVdxMG5VcVZ4eGRqUURNa2RuRmlLOTV0VEZaaDN6UGphVGp6N253L1hH?=
 =?utf-8?B?QnhiOXRNZmw2T1pyQ0JLd05KbytZbEhEM1EveEx5Q2w1SFN1SUQzVXorTk14?=
 =?utf-8?B?WHJ4MGN0U1FJYU04QUZmM2crZFE0ZThKUnVXSWN2eXFhWDJ6SVFESlQwZlpX?=
 =?utf-8?B?eWFyZCtEK042Qlh0T3IyUXBiT3pqdzZRazQrR1FtdTNNMXREK3BsUC9vZXRk?=
 =?utf-8?B?YURuQzFKQS9kSUlsL3B1R0FGQjlQQTlobHJ6Y3l4NFlyV3VBSHExRGVRUjVX?=
 =?utf-8?B?VFZpby9KcGV4S3pqeDZBM1NRWFU3OTV2RzdnSzhObFJ1eXRPRFNEaklFc3RL?=
 =?utf-8?B?c2E1cjNLclNjeUtLbzNua3BjZ2tSYVVObDF0UkNiVlNpQXFYWHRKeWxlT0Vp?=
 =?utf-8?B?S3ZuUEx2K3BEWk1PdFNxZk9LWWhZV1JoL0EwZ0drSVNxbW1pcXp6Sitnc3lY?=
 =?utf-8?B?aWFaZ1NLcDFiay82SDZGdlpLRE8rMHlNVmZHMG5jbFNHU1RtbWd5YmI2dm9X?=
 =?utf-8?Q?AEnMOnyqusrhgl1M0NzTwZs+U?=
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
	s4Cl3M5652EojC5mUtf4dK1WcpgdzelsP8R050iD+CsoylPzSgKAUBvkghogD9ZueWwgmx+mRGVwMSeS3Dl2gAVipQYLnE/r/8vB6K9ntuCrYyQ1JuswZ0zmdOP6o3N+A5roPL86y9xoIK6/N9dPpE2ykQuvN6wFcNjh0NxaS1WpaQoh20GEkeZzpsvmtIs8ScIqrm04Nq5Tfvtqs3cuPauCI/nBaFh8gVeMun+NZ06B/DZOCtfwamI3HBDiilDvhYj6WGBVa78VnjxYs1buwhB2cPlaemFxC7VzlN5xZSqnHAn3EKa0aGyMVvm6BwtAgGJoKoNhk3As3Wn0uvBT9pCQsuUxtiynXgk1xuxatAgIf64vqh9nIZAWdI/K/vOih3nWtZBSHveGnoqFDSRjG3Fk1mj8BEdRyAAP28rrXVCpmw7ObHxREvaSIBUHWH14/O8TQPBnF5C5gcWBAgykSJKdjO9YeV+43oGSXfefsBUWvRPQCgW+xSAaxOEwNgZisq4w/bozM+BHphr68O4BGqAN5mpKgWbxLwGgIg/JF49Wt2o6rzw59Xktdwv5Po3Uy+j4HIXobJW/qxA6+tnn4TCetE51PaOTSAjfyYCDeK4zFBXphYdp9INERTyvb5eT
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR02MB10083.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe03f1b-fe3e-4fb9-ec3f-08dd87e20f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 12:25:14.0934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejiA/KSgTw7T5fWvNw5MW8o4soFe4dtLutKAR/JtO4e69Ybz/J84FeZ+LHGHB7pGj5MGgfFhsWt3hoGsrrVHPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7307
X-Authority-Analysis: v=2.4 cv=BNizrEQG c=1 sm=1 tr=0 ts=681216ae cx=c_pps a=qtOW3xRV1T1JVXeTS8V0gg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=stkexhm8AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=FTtXlruqqbeckf2belkA:9 a=QEXdDO2ut3YA:10 a=pIW3pCRaVxJDc-hWtpF8:22 a=vUsbdJjsiYsWhgVz2Rkt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA4OCBTYWx0ZWRfX28Q3MYjvE++6 WjuXY67UwM0JAau79Im8aD+/LLE4we5wDGVv4Lw0JtKfwAVGxKr88eXSv8ta2EmZ0M5sbqaNiLV BeDLS1KRy1Ub5kgQyO8MA8t23ouY90Bkb2F2gA2OCO1b+T21GOk9aAkSo50CgIoyurFQiHR+BHa
 4piViK0AP7wqd17WySYyM9PIbuhAdEe1jEApGmzvg+eyGbtI7ITG8PUGDHWJaefRqbeOiTBI1bc ++2H2RndUwmFnQAu16+YvgsVRrjsc23k4FzcaIFddRbnmo0NfGdfGWcF/j23rBF7LEIFIvVDief eOCqLG9yjblwv3z4IyLgx8Ry9K6u6B8Vky+kEiPcjZ1OgKRvbhzw0ggkfJ2vFnk7VL0i1Nlnqou
 C75VLO1Zr5GvlK4e4b/YxJcqBlJ4GjFemk/0b34MvNswOwbJrgWrE6oIgg1YZKh4K2ZvLwgX
X-Proofpoint-GUID: OByju6bTVBjQkhcR1Jj3j2Yf4XQvjffB
X-Proofpoint-ORIG-GUID: OByju6bTVBjQkhcR1Jj3j2Yf4XQvjffB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300088

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMwLCAyMDI1
IDM6NTMgUE0NCj4gVG86IE1haGFyYWphIEtlbm5hZHlyYWphbiA8bWFoYXJhamEua2VubmFkeXJh
amFuQG9zcy5xdWFsY29tbS5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB3aXJlbGVzcy1uZXh0IFJGQyAyLzJdIHdpZmk6IG1h
YzgwMjExOiBwcm9jZXNzIGdyb3VwDQo+IGFkZHJlc3NlZCBSeCBkYXRhIGFuZCBtZ210IHBhY2tl
dHMgb24gaW50ZW5kZWQgaW50ZXJmYWNlDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdp
bmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkg
bGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IEhp
LA0KPiANCj4gSSBzdXBwb3NlIHlvdSdyZSBtb3N0bHkgbG9va2luZyBmb3IgZmVlZGJhY2sgZnJv
bSBNZWRpYXRlayBldGMuIGZvciB0aGVpciBtdWx0aS0NCj4gcmFkaW8gYXJjaGl0ZWN0dXJlLiBD
b3VwbGUgb2YgY29tbWVudHMgb24gdGhlIGNvZGUgYW55d2F5Og0KPiANCj4gDQo+ID4gKyAgICAg
aWYgKHZhbGlkX2xpbmtzKSB7DQo+ID4gKyAgICAgICAgICAgICBmb3JfZWFjaF9zZXRfYml0KGxp
bmtfaWQsICZ2YWxpZF9saW5rcywNCj4gPiArIElFRUU4MDIxMV9NTERfTUFYX05VTV9MSU5LUykg
ew0KPiANCj4gV2UganVzdCBhZGRlZCBzb21lIGZvcl9lYWNoX3NkYXRhX2xpbmsoKSBtYWNybyBv
ciBzbywgc28geW91IGRvbid0IG5lZWQgdGhlDQo+IGRpc3RpbmN0aW9uIGJldHdlZW4gTUxPIGFu
ZCBub24tTUxPLiBJIHJlYWxseSBkb24ndCBsaWtlIHNlZWluZyB0aGF0LCBpZiB3ZSBkbw0KPiB0
aGF0IGFsbCB0aGUgdGltZSB3ZSBoYXZlIGZhciB0b28gbWFueSBwbGFjZXMgdGhhdCB3b3VsZCBk
byBpdC4NCj4gDQoNCldlIGhhdmUgdG8gbG9vcCBvdmVyIHRoZSBsaW5rcyBvZiBzZGF0YSBoZXJl
LiBTbyBzaGFsbCB3ZSB1c2UgdGhpcyBBUEkgZm9yX2VhY2hfbGlua19kYXRhKCkgaW5zdGVhZCBv
ZiBmb3JfZWFjaF9zZGF0YV9saW5rPw0KDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGJzc19j
b25mID0gcmN1X2RlcmVmZXJlbmNlKHNkYXRhLT52aWYubGlua19jb25mW2xpbmtfaWRdKTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgaWYgKCFic3NfY29uZikNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgY29u
ZiA9IHJjdV9kZXJlZmVyZW5jZShic3NfY29uZi0+Y2hhbmN0eF9jb25mKTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgaWYgKGNvbmYgJiYgY29uZi0+ZGVmLmNoYW4gJiYNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbmYtPmRlZi5jaGFuLT5jZW50ZXJfZnJlcSA9PSBmcmVxKSB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXNfZnJlcV9tYXRjaCA9IHRydWU7
DQo+IA0KPiBZb3UgY291bGQgbXVjaCBlYXNpZXIganVzdCAicmV0dXJuIHRydWUiIGhlcmUsIGFu
ZCAicmV0dXJuIGZhbHNlIiBsYXRlciBhZnRlciBhbGwgb2YNCj4gaXQsIHdpdGhvdXQgdGhlIHZh
cmlhYmxlLg0KPiANCj4gKEN1cmlvdXM6IGRvIHlvdSBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIGd1
aWRlbGluZXMgdGhhdCB0aGlzIGJyZWFrcz8NCj4gTGlrZSAic2luZ2xlIHJldHVybiBmcm9tIGZ1
bmN0aW9uIiBzdHlsZT8gQmVjYXVzZSBJIHNlZSBpdCBvZnRlbiBmcm9tIFF1YWxjb21tIGZvcg0K
PiBubyByZWFsIHJlYXNvbi4gTWF5YmUgSSdtIGFsc28ganVzdCBtaXNyZW1lbWJlcmluZywgYnV0
IEkgZG9uJ3Qgc2VlIGEgZ29vZA0KPiByZWFzb24gaW4gY2FzZXMgbGlrZSB0aGlzIHRvIGV2ZW4g
d2FudCB0byB3cml0ZSBpdCB3aXRoIGEgdmFyaWFibGUuIFNlZW1zIG1vcmUNCj4gbmF0dXJhbCB0
byBqdXN0IHNheSAib2sgZ290IGl0LCByZXR1cm4gdHJ1ZSIuKQ0KPiANCg0KWWVhaCwgd2UgY2Fu
IHJldHVybiB0cnVlIGhlcmUgYW5kIGF2b2lkIHRoZSB2YXJpYWJsZS4NCg0KPiA+ICAgICAgIGlm
IChwcmV2KSB7DQo+ID4gLSAgICAgICAgICAgICByeC5zZGF0YSA9IHByZXY7DQo+ID4gKyAgICAg
ICAgICAgICBpZiAoIXN0YXR1cy0+ZnJlcSB8fA0KPiA+ICsgICAgICAgICAgICAgICAgIGllZWU4
MDIxMV9yeF9pc19zZGF0YV9tYXRjaChwcmV2LCBzdGF0dXMtPmZyZXEpKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIHJ4LnNkYXRhID0gcHJldjsNCj4gDQo+IG5pdDogeW91IGNhbiBjb21i
aW5lIGl0IGFsbCBpbnRvIG9uZSBjb25kaXRpb24gbm93Og0KPiANCj4gIGlmIChwcmV2ICYmICgh
c3RhdHVzLT5mcmVxIHx8IC4uLikpIHsNCj4gIH0NCj4gDQo+IG5vdCBzdXJlIHRoYXQncyByZWFs
bHkgYWxsIHRoYXQgbXVjaCBiZXR0ZXIsIGJ1dCBzYXZlcyB0aGUgcmVpbmRlbnQ/DQo+IA0KPiAN
Cj4gQWN0dWFsbHksIGl0IG1pZ2h0IGJlIGJldHRlciBvdmVyYWxsIHRvIG1vdmUgdGhlICFmcmVx
IGludG8NCj4gaWVlZTgwMjExX3J4X2lzX3NkYXRhX21hdGNoKCk/IFNvIGp1c3QgaGF2ZQ0KPiAN
Cj4gaWVlZTgwMjExX3J4X2lzX3NkYXRhX21hdGNoKC4uLikNCj4gew0KPiAgICAgICAgIGlmICgh
ZnJlcSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiAuLi4NCj4gfQ0KPiANCj4g
YW5kIHRoZW4geW91IGRvbid0IG5lZWQgdGhlIHx8IGluIHRoZSBjYWxsZXIsIHdoaWNoIHNpbXBs
aWZpZXMgdGhhdD8gQW5kIGFsc28gZ2l2ZXMNCj4geW91IGEgbW9yZSBuYXR1cmFsIHBsYWNlIHRv
IHB1dCB0aGUgY29tbWVudC4NCg0KVGhhbmtzIGZvciB0aGlzIHN1Z2dlc3Rpb24uIEkgd2lsbCBy
ZXdvcmsgb24gdGhpcyBhbmQgc2VuZCB0aGUgdXBkYXRlZCB2ZXJzaW9uLg0KDQo+IA0KPiBqb2hh
bm5lcw0KDQo=

