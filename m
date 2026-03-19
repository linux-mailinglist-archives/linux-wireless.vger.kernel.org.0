Return-Path: <linux-wireless+bounces-33457-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPyIOoafu2nplwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33457-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 08:02:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EBD2C70BF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 08:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE0E1302B207
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 07:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB42D46A1;
	Thu, 19 Mar 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="HmBgGzQB";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="mC8rEq5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0602D7DE4;
	Thu, 19 Mar 2026 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903725; cv=fail; b=fJ2J8FVQFu/VMfPAEdJ+JGxfFYzltRpM2IqCWQspApvsJhbYbKWrLl79xjM+dw+kyWcwqFYr7wTCOMAgHv1usInHXsBCaDO6CmmYySNzULZIAkp3augDA4OSWIIDCE3T11+Mqh9i5/rO9JNjKqRAi4BTVINnj54QQKEdpVivryw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903725; c=relaxed/simple;
	bh=2T75Ex32qMHijlpRVyJ/9hUZ/qOVUGzgSZpkX7D2RzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qdUIt9WbSLaG9+TVJH1YDc0FogrCAZoiwMbbQwqTDbbMRvP50+rz+Snzf2VGd/7C2lPicfr35i4UUFuxn8JOTI3bl4p3Z+vhGMdr8CG4bMUCg7BjWYsidXakYZwhgLDRCdB6pyRE+6sjCUyIoHq3Zv4npQky+vMAEf837yKDUPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=HmBgGzQB; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=mC8rEq5P; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J5LtNw3687709;
	Thu, 19 Mar 2026 08:01:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	qvc5bpELzXjxnJuj5hRCwpBoYGyIE/8IhGrfsZ3IWrA=; b=HmBgGzQBWK8FpGl8
	2b8Tq8JlDjH+x79JtKlSqujEJ2vOy5Hz7iFqmXJHGeve605aL+GDSTpZPPXlMEHK
	8Y7SBOC0HBYA5ryMi9XA/SU3ePEVQ/hXZbLw7zapAEmn8CDhYpoHoOTM1fptQYqI
	8bBMeUe5Bjiz5kwkRTl3oraAXCBEd5F7YLrCxUXTt4VubSDdfDBijUOCjSh4IOya
	45w56oI5uAlQsQs5uPdLMgZK6yuE+AkntyJfyh1mrKsB1cuZm7jGTEObEz5Z0XpM
	YwmEI+G1GvKuB4+0NsmOqRXCVv1w/VadqHx6ngi3Jw8qvdDzY9VeejFEtx/5QMGW
	a5Tfjw==
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11021104.outbound.protection.outlook.com [52.101.65.104])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4cy6wn9xtf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:01:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glYFcYCKUugxDDJxEuSuHFgWExKKdrK3ZWkBEacWyXwUuIvGvvaNz2SafFx1ytBGCIm6YBfUycy6LEGKQvOpd6O0339J9XJ3XvjmJR9kVq0L7LsyFzCNy6rbl5SfgTvWUJg0Zf288RuXE5WdosAcYbEaOIng4wtFbci+9mt+ffvUFA9fBz1kxPg7BkIDOuVIlfe8wv8A0g4Pj9OU38OCyDylBst6Nj6eRKLaX343ZHnc/9vtt3CO4m1G86qP6MzL0T8qtlHPhIavkux2IXqIpBReoXbrck5sxiWkF8rN4H1i0ZkAk5X/HWzOi7Ql0Krlq30dsvQtmcltNAkPMKIryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvc5bpELzXjxnJuj5hRCwpBoYGyIE/8IhGrfsZ3IWrA=;
 b=yrkvm+WejJc+sdT173p5ufTVgrM3wInUfuYkjqXZiDjWuXak8mwnNIUpWMigwHw4FFE9o5ZrUVg5B3s2ZRa6GHqoO1SBj05hDEEHJkt8iBjdUmwqCvxqCAdzHktxx+zp2yFMo7kyTcCxyPY0ECxpB5aLxRBsPaJYipqDlptEuL8gAnP1mms7m7gBp2ocje4++3oh3R98RP4T/uoW5+mwkur5Aeb6QPmfYCtBTMBKmKha/8Go6Wfr1HgyZh0vDD/t6GNdDvzRBSzoS06CfDaJoCA91ZU/YNgRxWorykxF+yDD3cGXy99no8w+nM3fqVREx/SsbA6Ec2mBZLUAsIWpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvc5bpELzXjxnJuj5hRCwpBoYGyIE/8IhGrfsZ3IWrA=;
 b=mC8rEq5P/FgCwrhCmZaB+rlhtXcRXBl1JHE0u958aoi7ROLoG2Qi0gDDxIxtSQ7ymseQ3ixIel2szVwzZ+0U7rJZzVnQGEajj3NsZBDvnQpw/+SL2IXXRL5vpyoIGRcHYOWk6QHjPcNb/T+WISOovGHPYqmaHvChiIyWi2/pF9Q=
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:5e2::11)
 by PR3P192MB0730.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 07:01:37 +0000
Received: from DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b]) by DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 ([fe80::656d:42d4:bdce:a46b%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 07:01:37 +0000
Date: Thu, 19 Mar 2026 08:01:31 +0100
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix MAC address copy on big endian
Message-ID: <abufS5-aJhi63zs5@FUE-ALEWI-WINX>
References: <20260317-fix-mac-addr-copy-on-big-endian-v1-1-b7b6c49cb07f@westermo.com>
 <44549364-7187-4b1a-b1fe-5bf6e309ec16@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44549364-7187-4b1a-b1fe-5bf6e309ec16@oss.qualcomm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3PEPF0001DBFB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::30d) To DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:10:5e2::11)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P192MB3090:EE_|PR3P192MB0730:EE_
X-MS-Office365-Filtering-Correlation-Id: b27a07c2-ba8c-4cf2-0d27-08de85855cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uS4o/mRBllMKBgIoCTlHStM00cn3rjva6RzljiSe8Twt7xkhgKW1iiw59KO9VN4QlztjBLZhA5fVmqAn1tImFJIOhVCeggnBoiMmeHpI3uYhh/GnKm/sbyJBrljtYGiM9tHa1DSRJQxTP6SsY84ja/6fVVfRv/VFN4ZxdQ69MnQNxQvIkdyok8B3xJ/NhDtMXtn5S6ZHnsE+ebwmETJe8OZqF60fezAxAFbFzqf+J8MntwxrGrwM4DfEJsWs57KDkZFhkFaEJiPLA4QrcTxKVv34POJAAXY3RPa5z2ehtBgGm3c69vgAVZZKwqwdVwwrO2swTBb0oymYnrK0lm6b9YbrsEsOqSoLHVUJkFpeIWtq2OKUc2xvFWnrdwpmdiw4rE0tutPfZT5JEODveQGjIhI31QURMtS2glS+MLzgzF5M6D0Y2z/zxWyoRyAIzeGz4fAiafkoMD1rx8NgF9n0wBZIornhsLNzsAX/l94HmoUCTcMsYWKH15mV+mwbDO3N21Sse8RZUSTVEhHub1ESbmc/6IXcpAY+8DF1AnLD/m6L751xznV2Wih9FA0CZTZRVeK5JR6byrV5Dj87gG1YTkSWMfyTsx7LNiEFpIEND8faRu+vEhb9hvbIzjTJpnEUehER3BbWmyxiUk9LRJfsPU1UlovkqEppBIK5NMAsqjkJqbB6p4FIcs/BG4Tq48AS/5kcbbywh0YVjy6e+dEDOP2nG3uCY86lVwj9bqZgr7Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P192MB3090.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEc5WFFielhCbGxBcXVKaVlZTDAwUjVFSUNRNUIrMDZ3QWFLL01wVlZQWDlS?=
 =?utf-8?B?dGE4QVBEWWN3cjhnWGdIRjU4TmFIOGl4QlhDNzUxR3lrZFVPRGNHY2ZJNWhY?=
 =?utf-8?B?anRWMmpZeXplLy9mdGpvYmg2UUx4V0N1S2RVOTUxdm1Fd1dLem9tcVh4RVdo?=
 =?utf-8?B?bFdra3Y1NkEzc1FCTUd6K3FRN2JPdUhuWnEza2ljSGdTOUJVVytnMzhpTUN2?=
 =?utf-8?B?TGVoY2Y4QlM2dGd4czA1d0V6blJTZUZUcHhpNndxVElzNHVyS1Z2OWtqTjN5?=
 =?utf-8?B?bGFXdytGNGhDZnpXMzNjUXZoZ1E3Vm1lNHlISDM5WlJyRG11Z1ozUWVCL3lD?=
 =?utf-8?B?UXRiRi84K0R4Y1RuT1VQYXVoaDRuQVJPODBGaWJ3L2IweldXL0NyWXAzdWFo?=
 =?utf-8?B?TXc0bEhrOUNmQm9pNTVPOUtHdDNhdllqZDBBZTJJc05nYk5HWHNFTXA4RFdV?=
 =?utf-8?B?bU9SckR1M1Z3cUNhNHdsSDQrMzFTWXdva3htYVlSRlUwdHdISzJSUHBoUWdl?=
 =?utf-8?B?eUR2NkV4VGVFRVlUV05BTUp5bUtMRjdza3dKZS8zMkkxVnhwVVhORWRTZ2pB?=
 =?utf-8?B?NjlxeTNvRXpQbUJYd1hmeEtNcHFyaldZZ0UxVFFDSXdtRjI2MHQ3M0ZPd3Qr?=
 =?utf-8?B?cFM1Y0VsbnV3ZjRHTjZ1SEE0OWx3amdPOGxYejJuN2dDWWFXaFg3aWxTbnI3?=
 =?utf-8?B?b2kyMEg3R0JUcndxSW03ZVBnRGw2YlBuQWE4T3Z4d0wrNXI3QnFlSUlaaUFy?=
 =?utf-8?B?N2JIVWYvU2lNaGk1UFp0RzZpa1FtRG05NlhvUHZuUnprdFpwOFQyNUJ1ZVdN?=
 =?utf-8?B?aE51MEJraTlKd0tvd1p1REpSQ2ozYjRYZWUvWEpmSmM3R3JVNjdGRlhEQVM4?=
 =?utf-8?B?RzdtQ2RYazdRWVkvL2ZmZXEzd3hEUEY2VzdSZjM1ajdhb05jSGFRcFpYaVZY?=
 =?utf-8?B?OEozR3l5amZMTExIeUYxQ1BuOGUydXlNVjFoRDBGL0d6RnNKNTd6SjNJYjlw?=
 =?utf-8?B?YmIwVGtvUGNGRmNPU1NMUE9xdVJZTkIzT0VZekFJbWZlWU5OYlAwT2p4cTd3?=
 =?utf-8?B?amJhWndRSTgxODU3SXU5eDErYTVDODVPZ0tnaWtKZXpETWEzcmdGQkY2VXNF?=
 =?utf-8?B?VkNFWHFTTlNKRWV1bFRqN2ZnY1RoSDRrSTdUTzVYRlVmVkp3Mnh5by95ODhC?=
 =?utf-8?B?TWpOL3dSV1BNYzhGdGRzMTZabGhqdXFiRzd5Rkw2dmdBT2p6ZGRNN3J3ZldS?=
 =?utf-8?B?bW1KRml2c3RUZVVEcXF1K3dtM0xrajNWNE5JNTQ1d1FvcmZQQTFtd2psUlQw?=
 =?utf-8?B?NW5aU2dIZG5CMzJKTUlZVzFadUZhRUFjKy94WEtEeWJLM1R3UmJDMzNJNk83?=
 =?utf-8?B?blkrTkwzVTZUTDV4RldPeUM4cm9wci9jM3NjVUgvV2Z2OVVUeEFDRzh4bGY4?=
 =?utf-8?B?Rk9mSForaTRGcXpVclQzKzl3WmpOQnllTU93TEo4T3RxWDRXTVBlOXNHMnFB?=
 =?utf-8?B?cmdTaExmc05wRjIycXUyMVNEKzRrUitqd0RTTnZwb0RqWTYvVGxTZWdyTWNv?=
 =?utf-8?B?TkNrbjJ6NndRdVhDV2ZzZnc0WDNjZXh0c0tQMy85bnFnQ3JhbHhiZlBybEFO?=
 =?utf-8?B?eU9OcVJjTkFPLzgvUDF0cWVKaVhQd3RacTlRWjNaaldSN09QK1ZDVVJDNS9S?=
 =?utf-8?B?RTlGR2NiY1gxUFBVNDhPRWxuQktFbEx4TTN2Z20wVHJ5bkJFaWpUNk1UeUxZ?=
 =?utf-8?B?L3BoL1RSVW9jT3BHNEFWUFpZdVUxUC9PaWwwKzN1ZmM5eTVoWFFhYkowS1Ba?=
 =?utf-8?B?SmVEbmorYkl3NTBxYmczSGZ6ZmZndXNVdmNJNEVpUTBqcTYwOTNCSmVDSDJx?=
 =?utf-8?B?c0NrSkR5ZjNKVjZjNUJPQ0FyQmpKUTJYdWpJWXhJaHk4TnFiK2N6amtwY0FH?=
 =?utf-8?B?L0NFVEhxdWhvS3pVL29TVTQ1NDVMQkErcXdMS0kzWlFyTEk2YnZscjZrRytI?=
 =?utf-8?B?N29ZU1FpdEV4Mkh0N0pta3Z1dzc3MFVKbVIxYUNYV0tKUlRvZk5WcHZoRzF0?=
 =?utf-8?B?Uzd0a3lWRzBibzhsMGI5SldCWjR2ME9MMjNQYjFTRkhFcnhwaXA4UVhubjkw?=
 =?utf-8?B?Zm16OFZvQjFJbXFRVnZNYkw5OWlIV1VqZVRpcmZtL2xKSHFCL2h2Ky9CZGsx?=
 =?utf-8?B?YlRIdFNQMlZDQ2UzemkwSEtQdEtURHdXZFV2ZU9WMWttRzV6OWdIcUVxdVdz?=
 =?utf-8?B?NkNjTUlVM3U1YW1QclZwd3RlRGF0QXR1ZHNTMUUrVlZyVkF3WHVkUG5kWlpn?=
 =?utf-8?B?T0pteUtySzE4UFJSOVEwcEtUWm9JeTFkMnVrUndvTnZwOHIzckR5QT09?=
X-Exchange-RoutingPolicyChecked:
	ePYuBwk79A5rmQRc4wUdF0Mol56dAZJSzKMNWYJz87OjRaFXuW1yUgx2gCsePERd0HXNu6kpAHLyI7YfFtVh9DtfvofWaFTZUrLNyrpVwchiKIOgGW6yCupTs6jeKWTcR57aaatks1wnVRrtTnI8QN3YO5At5DKSzYVxOOw8c8PtTpr05ORhjdoGqrH99+X+l9R45mlfCvVjPYuD4bYGiWSyfgM57ZXfhBEAAK0SQnp5nhdWQ4/mzVDbNhLU/zyFRzFDe1n26uDyIWbqFwjtZ5huEUs7VPu5lHHrSsXRQBIY41DDvecQzxKSFMA+CpvP3JWUQkVnIbqTtr44XSo5sg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x/UdzkZom3fStTgTZMlNFnGWPZhcEk8frpy4H/apVjnVI9U9n+0mepTO2EZNHqFLMl73uEBwa7wMYBMoj6U33iCirds0ch31/zk52J2I3IJWzMPpAVl5Q30CPAAt43tG01oJuvjhRzeWQfRNMhcAiMQJZOBimQI/Cdp+HuAa4H3iZ8lw8XqhxDBMSAMhnNHSJc3Ieww8Y8/0ZsCq+7dNGoqFFzeLuBfCk3juxGcq039x6valoGrBP9UO8xOiU9dQOOk8ao1Ez0+EnIw4NG6MChYpXnPLpySNwCb7ROnHKuHFA/XunWgoFnjrBzjLVxbXy1OC/lXiTqbtJ6KsPfFwA056iqE0ddgspJPmXB36MINFbLe7gP9d/7iT0TUJxiVg9i2Ps0Ja6BdAszqHXsNI2oeFZu0xOZCchneajeqI/2hrbePjGWjPkTYmpEdtJuKLCAa4rxGAmKCIXLa/F0Kr1344M7UxWQa3BLX2cBsEyxquXKYuiHR9mXj9lvnZVg1N3Jwa4bHaPe0azveR2BaZ4saZ1Fpvv9QzMac90K0MIicDnPxpO9XQ8JrXgTgPs974B+YZVRo5G/cvwK25okleCsjCgk/d8PeRe4CGPwygZRfa5QFiB8NAJ+tb+PcLq03J
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27a07c2-ba8c-4cf2-0d27-08de85855cc4
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:01:36.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4JRhyOf/VIl9Bzigu3rFFe2sHZpxrJfc2zh/xfo1zUdaV+Iwyqggf75qy44jGmeeYZBG0XXDKTot+aQKw/Llg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0730
X-MS-Exchange-CrossPremises-AuthSource: DB9P192MB3090.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: PR3P192MB0730.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA1MyBTYWx0ZWRfX2dgtp7FGPCLQ
 7KUP0zvViUi6wVz8QxGmybrZr+MT2DL4CqzZSh2FCaRqACJd7ZEsw/MlGkD1C8nW6EmGc0ng04T
 q1CZBr3ZErEWKDijWTqCiVJpSOGwVpuKV+FXxFpQYxmnepb6pITJaZ+q+pW5x+nUx/m/VXTJLyV
 ukgrP6yKP0L5XlfCZFLhTKZlObA26xRjoPQMP+bfZAbJYU8Ow6UjWaMCuA1ZERBTM3BR+ivgNHL
 1ZDoFs4o18GtXsYA7QeADeMnX7bRBCJ93hYskLOJYbiAPu76lnsh5NvVG6r5lbzklxa3t57EtUK
 5CynY4jBMh4cuqVtbgV43SrUCL7VfYphlmOOYdVTvMt/g0LFdLoZo7t1DgHBAbUnDi7YPiGMkyw
 En2H9dm6BvoTqzyzq+K3qGl7V3vYKWSAuNYrX+cTLAZS6bKo6uEWbtL2ssKeAwx0QjFQ+4oejJ+
 1t/dmea2GImyhktuRWg==
X-Proofpoint-GUID: -3emJMoJYMycQSnNXyHUCC-7N2VV9pgm
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=69bb9f52 cx=c_pps
 a=hCtnQJJSGWj+YDErie+S4w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=Puzt6NqoZ2-6pIA8uDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -3emJMoJYMycQSnNXyHUCC-7N2VV9pgm
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33457-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,westermo.com:dkim,beijerelectronicsab.onmicrosoft.com:dkim,host:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.wilhelm@westermo.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82EBD2C70BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 11:00:22AM +0800, Baochen Qiang wrote:
> 
> 
> On 3/17/2026 7:22 PM, Alexander Wilhelm wrote:
> > The ath12k_dp_get_mac_addr function performs a simple memcpy from a
> > CPU-native data types into an u8 array. On a big-endian architecture, this
> > later results in a null‑pointer dereference. Convert the data to
> 
> curious how could this happen? how matter the endian, it is just six bytes which are not a
> pointer hence can not be dereferenced, no?

You are right, the wrong shuffling of the MAC address on big-endian platform
itself does not immediately cause the null-pointer dereference. But later in the
code execution this address is used, which does lead to a null pointer. The
execution do not handle the error and continues despite the null pointer, so
this may be an additional bug. I need some time to find the exact location
again, but here are the logs that show the triggered null-pointer dereference:

    user@host:~# hostapd /mnt/custom/hostapd.conf
    Kernel attempted to read user page (8) - exploit attempt? (uid: 0)
    BUG: Kernel NULL pointer dereference on read at 0x00000008
    Faulting instruction address: 0xe2077f38
    Oops: Kernel access of bad area, sig: 11 [#1]
    BE PAGE_SIZE=4K SMP NR_CPUS=4 CoreNet Generic
    Modules linked in: ath12k(O) mac80211(O) cfg80211(O) compat(O) ...
    CPU: 1 PID: 8455 Comm: hostapd Tainted: G           O       6.6.73 #0
    Hardware name: CyBoxAP-A e5500 0x80241021 CoreNet Generic
    NIP:  e2077f38 LR: e2077e74 CTR: c00833f0
    REGS: d0e7bac0 TRAP: 0300   Tainted: G           O        (6.6.73)
    MSR:  0002b002 <CE,EE,FP,ME>  CR: 28004484  XER: 00000000
    DEAR: 00000008 ESR: 00000000
    GPR00: e2077e74 d0e7bbb0 c1dc4a00 00000000 0002b002 00000058 0934edc0 001c0000 
    GPR08: d0e7bb58 00000000 c9370948 00000000 c00833f0 035012ac 00000000 04e04690 
    GPR16: 00000000 00000000 00000000 bf9d2070 00000000 03493d36 04e04660 c9349600 
    GPR24: 00000000 00000000 00000000 c8b1d1f8 c8b1d248 d09917c0 c8b1d614 0000000e 
    NIP [e2077f38] ath12k_mac_11d_scan_stop+0x1c98/0x31d0 [ath12k]
    LR [e2077e74] ath12k_mac_11d_scan_stop+0x1bd4/0x31d0 [ath12k]
    Call Trace:
    [d0e7bbb0] [e2077e74] ath12k_mac_11d_scan_stop+0x1bd4/0x31d0 [ath12k] (unreliable)
    [d0e7bc10] [e20793b4] ath12k_mac_11d_scan_stop+0x3114/0x31d0 [ath12k]
    [d0e7bc40] [e1f5b41c] ieee80211_do_open+0x13c/0x8b0 [mac80211]
    [d0e7bc70] [e1f5bb40] ieee80211_do_open+0x860/0x8b0 [mac80211]
    [d0e7bc90] [c0675318] __dev_open+0x108/0x1c0
    [d0e7bcc0] [c06758ac] __dev_change_flags+0x1dc/0x270
    [d0e7bd00] [c067596c] dev_change_flags+0x2c/0x90
    [d0e7bd20] [c0774838] devinet_ioctl+0x2c8/0x990
    [d0e7bd80] [c0776f60] inet_ioctl+0x1a0/0x270
    [d0e7be00] [c0639750] sock_ioctl+0xa0/0x580
    [d0e7be60] [c02042c4] sys_ioctl+0x4e4/0xc90
    [d0e7bee0] [c000dbac] system_call_exception+0xac/0x1f0
    [d0e7bf00] [c00110e8] ret_from_syscall+0x0/0x28
    --- interrupt: c00 at 0x2ad109c
    NIP:  02ad109c LR: 02bc3958 CTR: c0249eb0
    REGS: d0e7bf10 TRAP: 0c00   Tainted: G           O        (6.6.73)
    MSR:  0002d002 <CE,EE,PR,ME>  CR: 88004400  XER: 20000000

    GPR00: 00000036 bf9d1c60 98425520 00000007 00008914 bf9d1ca0 00000002 bf9d1c98 
    GPR08: 00000007 033b3d68 04e062c0 d0e7bf00 22002800 035012ac 00000000 04e04690 
    GPR16: 00000000 00000000 00000000 bf9d2070 00000000 03493d36 04e04660 00000000 
    GPR24: 00000000 bf9d1cf0 04e0af40 00000001 bf9d1ca0 00000007 02bc3958 00000000 
    NIP [02ad109c] 0x2ad109c
    LR [02bc3958] 0x2bc3958
    --- interrupt: c00
   Code: 4bfeee39 77e91000 40c200fc 77e92000 41c20018 813b0000 28090003 41c207fc 28090002 41c20834 833e001c 835c0140 <81390008> 2c1a0000 80690000 40c2031c
    ---[ end trace 0000000000000000 ]---

    Kernel panic - not syncing: Fatal exception
    ---[ end Kernel panic - not syncing: Fatal exception ]---


Best regards
Alexander Wilhelm

