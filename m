Return-Path: <linux-wireless+bounces-26492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD72B2EED9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 08:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4927016C8CB
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 06:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9112E888A;
	Thu, 21 Aug 2025 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="hHByxU7q";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="K7BoUmes"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B9261388;
	Thu, 21 Aug 2025 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759307; cv=fail; b=ihEiULnpJmCLmpvcG8qiZgCaawjhpju26gnM9zznzFM6FpXsAVQtaJ4YtNqpUZGaiq7X+uWfTWUoSNUJtOVg3iwI6E6pZkOCm+uRlMaQBYVkzlHybc3E7rNxB5b/beWLS3Wg2rAqkAH5IV8/yE3pBfrQmdFbHRmRMsvNRVwtYCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759307; c=relaxed/simple;
	bh=FY3eeSIwwdpC+bHzp4xVsaPejb1TgazOFPxBU/XKBqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LctWj0/z82Dj5cMd4EbANa9K/hdnPBwKLLH2lowIyQ9zD1MUXL9LdOHgf/+ekTuoCM7wALn+dCVbigerGMqEyWSYe0Oel4z2vugcaVxO3FWTneVx8KM95sWY8AHl4X3jclyEmywC5bvHOCkx9Zdy0tVoozpBXPx2z2fHtMBaAwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=hHByxU7q; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=K7BoUmes; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57L6Dim2361483;
	Thu, 21 Aug 2025 08:54:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	qMFLkx/EQ40RfD1gq7LrCOcxgjIJZLZi0Jj4v7jp4yk=; b=hHByxU7qibrfbhwa
	1GIib1eJAyOmCHT0/NIRhU7pkdSqAyinWOVcMYQq/9WAJ8N5qkMU3UlY7uRooNyy
	nvJWo+MmX57702Ekllya3a+xFFv+PqXaxej2WXGAE1MslVYxsNoAfkyoQGPbY7L3
	ttbzcJDGtXr+RVcEkqN2t8KrWbsz+uRqeYar0iFPoSOpab1yTUsU6mNlT/AOxNgf
	mtYqFwIsmErTJ53TM0uJuG9ja5b27OPkBQ7d7JnyRxfccnEwqoosFLIcSMPlW9LO
	jT1mWPpU4E+4aslSlm3JJYra72h7eO3az0iuZN4GVLGj4xn8F2g2s2hwJ5f2JHA0
	r9ZbrQ==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48jffgcvgt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:54:40 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2tqV0L5LWS/Cv8tnrV+1KkGrODNWXBj1gLheNQUOyzy86s/5qwkIdlDYO17fgKOiw3a6x3K4XVJBA24giYP3BgJgG38I0x3ypmvrtnRjLa0sJyqA75rpw2viYx19GsgTqQlc3VcT7B0JeTlpHZpsVJZ4Y7bvKaUbKaGnQUug9XkYlOGsF1uxSd9KhAPijmUdYUfJCCBMmE1Arrj/3WS7KAFL5SsReTnGN23WXrp4lWnREUMAzvIjs/YvWBX6gz+u5B5tAl0OwZTX/oT86jloigs/97J2tVHxzjac3/Iih8AawyBIBQ1T2Yl67ui/Xz8Y6QfupFqV02YREuYTB6coA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMFLkx/EQ40RfD1gq7LrCOcxgjIJZLZi0Jj4v7jp4yk=;
 b=QnTAtAwxBr4jK6H9FwhWhXWvOuerw0mMKf3Ldl2KpQpUUQk6umvcbMQ8SEYk1y+z/F4T+UbzKoVrRbf7/w97GBALlRiS5NMPbaTnNckd1b40DHyNsClZ56NbDP10AMeaPIdYjZLVHFTxjvwB+AiiyxsI/L2kziIBYFII/CkDP9to0ZNhwfVU+wJgQzAuTuiZDlngVkRnvOzq59l8y11QkrghcW8VNLAc21KOVZwZkm8qEVWyYvouHqtv3jN+JqBJk713je+NSyuiZtzqLo3a643Mg410vt0fj5iIfngJrUpxShMDgyX2/Mlf5O+tiIuCYj/LxiMr8pyinWZ8AsiIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMFLkx/EQ40RfD1gq7LrCOcxgjIJZLZi0Jj4v7jp4yk=;
 b=K7BoUmesZiDTfb9ExTVyLR/up97R9xSBkWztUGdeE01ZpH/BjYFWmt2I9LPjrWaKx92YQhTu/0qkLipoWQSwcysm5n/7VAwSOlhNYNQCgouPxw6dmGaSSlrDU8vXw592ivJPSgQXdeGFOTb44+PMYs3HmTsntAS0G552OghTy4Y=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AM7P192MB0595.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:17d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 06:54:39 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 06:54:39 +0000
Date: Thu, 21 Aug 2025 08:54:35 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ath12k: REO status on PPC does not work
Message-ID: <aKbCq3SLsBQcQWIh@FUE-ALEWI-WINX>
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
 <d6f0b64f-1764-41cd-a7c5-fb34d034ace2@oss.qualcomm.com>
 <aKQg5vLUplzMUMlU@FUE-ALEWI-WINX>
 <ff8287fc-7122-42e7-b6ab-550576b5d599@oss.qualcomm.com>
 <aKQxcfbDYOWTa36J@FUE-ALEWI-WINX>
 <0bd40ba8-5082-68f5-f458-b1417e0498c5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bd40ba8-5082-68f5-f458-b1417e0498c5@oss.qualcomm.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GVX0EPF0001A042.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::487) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AM7P192MB0595:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0265d2-12fd-4ade-2d9b-08dde07f98f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3ZxMnpBSmRCWC9vWXRyZFRJVW1UWkxuaTZQMU80MHZnUkloV3A5cVZNeTB4?=
 =?utf-8?B?QVRsaGZVTXNLU3RqNzkyVzdubFlxS0t0Rm5FUkxXQVRodCs4MWFla1JuTDlO?=
 =?utf-8?B?WmNqUUhxMVRzT3ZUeHpucDhaNzk5MHkxdTBBV0RVaEtvdElyQk1NVkV2bEVE?=
 =?utf-8?B?Y3F2OHlNWkpKNHJxUDhZbzFMN0hVZ3VjbVVaMEppQnlLUGhwZlRvaWhUUEFU?=
 =?utf-8?B?OHRsUFVzcm4yOHlsYW92K0FjUlY2cnM3QjdpblQ0N3JPTVJmQ2FsazRyNWE2?=
 =?utf-8?B?eU4vZWQ2d1NSU25VUUtiaVlwYWdqbkpzZ2FIcE0yK0pOOVFyblpmVkIrTjZk?=
 =?utf-8?B?Ti8xN0FRZk5QWGRlQ015NTNDSjZoYmxhN25HdU4vS1BCZEhqVmRDUXB3Z3J1?=
 =?utf-8?B?QVAxYUVaVXFRMmorU0xhYnV0dC9BZjRjSndmWlgwSXRZc2VLQlFzb2hZSUNE?=
 =?utf-8?B?bFQ1VmZ2anFiTzhZMzF3NUhGVHBpTk9NZCtvTks2b2Vsb3MrZmFwbWxoNERU?=
 =?utf-8?B?blNJc3BmbVZpY1N6cFFYTkZQbkQxdEY3K1RWdVBOakZzUHV5RnYxOTVCb1Yw?=
 =?utf-8?B?VzdXMUtCcmlhSER6K0hKNGJKa2crcjNSaDZkaDhVaVpwRE5QbDdJVUtINE93?=
 =?utf-8?B?ek9jN3NqU0dxcy83MStzQXR3aU0vSWo0ZWpqS1FZMklDRjZzOGRNdlJ2N2E0?=
 =?utf-8?B?QUNqYk1ENjFWMUdxSm80aE9ZS0tscnYzVmg2RXJoMTNtcFdDRCtGaGIrc0RI?=
 =?utf-8?B?QzBwOEdqaHp6Q2VKaGFYNFE0ZjV3TldMZDREck84Zm5CYTNVRnp4L0gyYlBX?=
 =?utf-8?B?RkYwZlptcUpsN3hvNjZZSkxaV1V6bFgzL04xOHJBbGt4eVpSTU5QRGFBYlFk?=
 =?utf-8?B?TzlxSjVmeWJsTjNMdUhVSVRVNktPTHcxZU9TRHJJUkorQlo0dWt5clNHUlJL?=
 =?utf-8?B?RTlzZVgwdWFXUGlMSkcwcDZjQXBRek05Q0FpTmY5S200NzhRK1k1UGVzVFc3?=
 =?utf-8?B?N1BsdVZReDJkL2JDUXRIVlIxZkRXYWJEMnpiR0lQcGlLSjJ4UHNSVStFR0tp?=
 =?utf-8?B?QmNZTzVUV3VrRTdkeFVwa0ltNWtJUjF2cmtBNFBJLzkyY3lxNUdtL09DVWNG?=
 =?utf-8?B?Yk9GdXJybjREdHJpRWYra0x0a3VIZXNwZXJXSk9PMkhEWGlsTmtaMjkyRXZW?=
 =?utf-8?B?YWxWWnQ3SnF0MnBxK21qUVFqN2RiSzdMMGpJKzVDYTJrb1BrRzh4T0paWHJh?=
 =?utf-8?B?UDExZU8xN2dwSmFOVUxqN3JkQTMxNTVoQUJnalVNNit3Y2cwK3RVbG9xcWx2?=
 =?utf-8?B?UW1hRDRmOGxPWnh2bjZLNDYrS3JUVFlDUDBieDgxOTZTTWxPNVdSc3hSTjlr?=
 =?utf-8?B?RkZOUzkwd2NvTHRLZWdPaWVpdW91K2dPclpQUTFZK29Vb0gwSXdjVWJFa083?=
 =?utf-8?B?NlZSS25DN1NOc2lGdk1UdDlNMktDN283ejJmeXpxeUVralRLRmRjZ3Rrb0F3?=
 =?utf-8?B?OElYbldLOXdSVG9ZbSsxai9CYjJNOGVLZG9vTEN3R1RQOUxVc3UvZnVEWjhW?=
 =?utf-8?B?c0ZRMDhrQVhqZWt5TnNPalM3VWhEK0xPNGRHSXdmRTJCWGsxSExpeWZxMTly?=
 =?utf-8?B?ZFA2NlNveElpSkFWRG9XTkVFRGszRnFwa0VlTi9sL2ZsUDFCMkhUL00va2JF?=
 =?utf-8?B?ZnBhd1pZME90L0VkaGZHd2xLYVZTSEFLL1ZpcEJVUWdpSG5QZEoyblloazM1?=
 =?utf-8?B?ZExZaXpRYXdxd0xHNFhRN1VaV0p5T0NQMyt0MWp1ODZndm9aczk2VlBDdXdI?=
 =?utf-8?B?Rkd2SmUwRThiY3BFei8vL0E4cGdIN1dIbFUzT2tDR0dubzZMOVlMT2Z1Z2ky?=
 =?utf-8?B?bmozYStwZXVic2VybVF6NURHVHNRdU5JMGpwVU52QWVIRFdYMUI3V3FyUDhy?=
 =?utf-8?Q?+j8wZ3siF+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czh1a1VhZ3BCU0JTYURKYXFyUXZmRzJRa1lKZ3RZL05jZkJZWHF2YkJlcjJz?=
 =?utf-8?B?Mk11VHpxWnU3TTBhVXhDVEVkTHAvUlJxeDc0WklESFI3RmU4M21rV3cxY0ti?=
 =?utf-8?B?TjRnUlV3eThRU215U0dPaVZUa0NqVEtLS0IyOWI5eUxwUFg4ZXFuQk8yN2Vq?=
 =?utf-8?B?VWgxUnVFYnNhVnQzMmNGZXhaVUtwNTlxdHVDY1FFY29wRmZJTkE2RzZTWWFn?=
 =?utf-8?B?bGJCdEFlWW9rQ2svNVpFalVkN2lNTGtRaUt0MTJlbUFCaWhVbUxheXI3b2N3?=
 =?utf-8?B?TUNjVXhKOXZuczNVL2k5Ykh6ZStQZ0cweVZwT0l3ZEJqMHh2TkpOcGlqcHBs?=
 =?utf-8?B?UnhJSXJXa3cyZkhScGtrd1VhbjNsQmEwNWxWQ0Nha0U4c2s0RDBUaG9xVTE0?=
 =?utf-8?B?d2xpU25yZUxVUGx6Zk5Yc0s2d1dTTkQyUzRGN0syeGxGcmFaS2p6WjdaMHNl?=
 =?utf-8?B?N2NyRTJ1ckxvV3QwN3Q0Ylk2cm9zV1hPMVNJc0J2MS9UL0lORklVcDU5bWpz?=
 =?utf-8?B?WnpkVVlFUVVneEpkeFJKS3ltUmRhYTJzTTh3cjl2RTlxMlRacjZueFB4ajdH?=
 =?utf-8?B?WmFxWFhlL1orOUdjSm9ENVY0bnpxempxQkZ5MWhYTncrbG9CQTNSL0Irck00?=
 =?utf-8?B?TFRxUkJXd29hVm9yWlZUOGZ2VWw4MDAwUmNLNUlrMlUxTS9KeTBYVGt3YWxH?=
 =?utf-8?B?Rlg1NHRpZE5SaWVYajNOVWcwVDNmS0MyaENGUkJEaGJvSmhvMFRTcFBZQ0xW?=
 =?utf-8?B?SWYxRFpjWHlqaWxwaWhyRDdtM3FTRVg2eEFIdlE1aW8vUXltVk8yZm9kYWFB?=
 =?utf-8?B?d1ZDTm9IVW5ETGtQSC8xeXBCdFhSSnhhYlJhV3hBOWtWRHZFWW02YnN1WnFz?=
 =?utf-8?B?cURJeXhlTDAzT29XN0ZWRTlnQlBnK2xsVi9nRURDTkZ6aTFza1RZa3hmTkV0?=
 =?utf-8?B?VDN6ZVdKSVNpSG9nWjdBcEhIR2N2THo3dmFPNUJRK2tGR3VYcnlBSlA5QzNP?=
 =?utf-8?B?WjFmNmNGdS9kQUl5U2JYM1RhSFcrVVdPUnFLU3dqWjdtTXpZMXl6WkU2NHZP?=
 =?utf-8?B?Mmk0UjU0SHBmZXFZc0tKcS9Mc3U0emdmNzBZbDg4YUdvV2JtdnFGSmV3M0NS?=
 =?utf-8?B?U2Fqa0tyMjVLeVA4eHhPRE1FcmZaUWJ5bThmMEV4aDM2cldTMitjSDk0Rm54?=
 =?utf-8?B?YlJDSFQwZVgrMmdyd1dyMVpCalpsU1dLZEVzck16YUt4aFJtMk8rM1g3SUtW?=
 =?utf-8?B?cUJXVHcvayt4akpBZWJiT0s3cEdjWGU0bXBpN0ZjTGV1YlFwc09raTJoNGFo?=
 =?utf-8?B?Y2o0dDRoS3ZIVTduSWJBNmhxamgyV2VrQmIyTFpuaDFGMDBUT2puaS9PZGd6?=
 =?utf-8?B?Zy8xZlFBMVF3UW9Gbjlhb01KSGFzQVBYaDBJVHdFb1dtUzZmVlZFL0t2T0dZ?=
 =?utf-8?B?RUdmdHRpSytraUxxOGVNT1puWnhIQTQxVHBZOWpqL3JxcW43emE0ZWZNSm44?=
 =?utf-8?B?K1hwbHRaUnhxd05WeTlIcmYzQmI0NGptOVExRGtqVXRHVk4wS0pKUFdNTHJl?=
 =?utf-8?B?M0swNlh3VmFwT1RvcCtncG9GYklSNTFqdnJGU0U4aEEzWmN6Q2tsQWxpYzlz?=
 =?utf-8?B?K0tBYlFkdkdOdTlid0pWbWNPZTVMR1R6ZjhiN2hkdHAzY1UzVVRUeTZIRGhw?=
 =?utf-8?B?QmdiWUFWOFQxRFo4Y3FTOWw4dDVoTm9tTWVSVmFFR2syeFU4Y3k4VStSWkU1?=
 =?utf-8?B?M2k1WE82bVFsV0ZVVUpXTXlqTno0c1lpWDl3YmoxdE4rZE81c25md2tRWUhC?=
 =?utf-8?B?Mm03LzVNazBDdVF6YVdEQzJoam1WV05FcHZSaFFWUTRveXlNMFN2MGZHNDBT?=
 =?utf-8?B?SSs1WGNMMkh5NkJTNElIZ00vbVl2eHhSRWhabmtoTHRFNGlHeXhBTnFNWlQr?=
 =?utf-8?B?cnlkSWlnb1Vha3hmMW8wM3NieDdLYkNGZzdQNUx1ZU5nTTF0cnVmMFMwTjd3?=
 =?utf-8?B?TmNsUEhvbElGTnI1a3pxcytzTlNJRkswSldub29KdGZuOWxIVnR1bDJZMXBS?=
 =?utf-8?B?T2U4UXJYS3NZeVgrNVdueVRZdWEvL2EwR2hBZTh2RmtqUUpZaVliVmtKazdM?=
 =?utf-8?Q?FkOBGyft5libGphOShoyf01g7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WB+fAK4F3k8tOPzQjET8b2p61fgTQf6r8CYnvAcUHNxo8NvsR4o8PsXwV7gPTdJBmZvQ4WqYD8XMHoI1GlkmI8ITBgIsCy037bPT5j4Pm31dNlhSJJUZWsZJY5esGLW0ae11PxkWHpzbqjTSmWVYIYFbkoC8BowpNzurZRMEVd+jSN2qtEHWXUV619wn1Ms+YgroToYD9HCT8MdxhCnaAAnFYJFS1SLWAGr/SRWwkym78Qqem5k81bnKQ6pjIsMQhpIhLuscg0JXCtc9oyC/RklVfSXagkIhJfidIlzpEx9FyxjoDcIcUWqMWqKE+R+vw4t1Q5tfedBsFKoETmhj4Rz1X+owU/XQECtKwLBQTq7MV0kkUm9aUpdpcFTfYYMfgmpyAsupIw4CJpSbHcA2yk34jWuf7ANDU9zcUVhkwur7FtZR9dxFmnrWXbLFmaUe+X1wDd/Dnu1LJ/j1C6OU2IwcwiqjjqMb7Gm90SD3CxHZA3LxnkMFLl+/meVFUlqxI/zJ1IKJXRzZbhXCHgzVnt5bOL15kGvax6PQUKfPT+AiN1WeZcqzbik7ugnBtffWPFPYHbrFBcIf3P2FCwgqB2O9TuUjhrhkS+Qvqd0gpiHjCQHt3fXifyB50TpEsuZL
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0265d2-12fd-4ade-2d9b-08dde07f98f4
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:54:38.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1WnASi7IbToZ44X5yNM+Ct35GckWmeJMWZwulOJ9y8eB2awHfgQQr8ywXuqZ8sxvF0CvZGKHl+77P2yN25Mcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P192MB0595
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
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
X-OrganizationHeadersPreserved: AM7P192MB0595.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: 8xoPwIShm00UIcW9UcMGcGjQAnIO13cs
X-Proofpoint-ORIG-GUID: 8xoPwIShm00UIcW9UcMGcGjQAnIO13cs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA1MSBTYWx0ZWRfXwD4lJ1e/h6qt
 R/tq6SQD7itWVkV/U+6xxDjzlE1016X6AzheqtkXOyY0GSwOzZfa2Wod0V6lnDgV27kCoIFwz3x
 pb5Ofp/7BqlYoEuek4TXitAN9W5ZHLzpKg0pX18KPstmXGQ3azEdQmQ4fgS25mbUXq4bWJ6afEV
 oGPaurG5lFp9hKVbo+xWcqtTjNf8K1F+nSqACU3d0UMleWRasi3Q6YCG0Y58SjiqPq3VBtOGnWZ
 KvbTWnhql/a5XGi3KOnxbKRxqDzscImTaHZHiv28BK1wrr6T+BahmmIgxnTjl0WPqIfhNoTT3rz
 9NHbyDTKZE1zhj1nmIsovjf732GVikvKxH8OAj/ZEdzLr2ks9NvKCh1mvibq76CmRviKgnb0bdo
 ZxEu6NJx004WspXanHhCGK1ru4j+IQ==
X-Authority-Analysis: v=2.4 cv=K6B73yWI c=1 sm=1 tr=0 ts=68a6c2b0 cx=c_pps
 a=TuUWA2E2N66qf4XrFxhyoQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=om5ERZoePshsk3463IkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22

Am Tue, Aug 19, 2025 at 02:51:16PM +0530 schrieb Vasanthakumar Thiagarajan:
> 
> 
> On 8/19/2025 1:40 PM, Alexander Wilhelm wrote:
> > Am Tue, Aug 19, 2025 at 03:26:34PM +0800 schrieb Baochen Qiang:
> > > 
> > > 
> > > On 8/19/2025 2:59 PM, Alexander Wilhelm wrote:
> > > > Am Tue, Aug 19, 2025 at 02:38:38PM +0800 schrieb Baochen Qiang:
> > > > > 
> > > > > 
> > > > > On 8/15/2025 4:13 PM, Alexander Wilhelm wrote:
> > > > > > Hello devs,
> > > > > > 
> > > > > > I'm currently working on getting the 'ath12k' driver running on a big endian
> > > > > > PowerPC platform and have encountered the following issue.
> > > > > > 
> > > > > > In the function 'ath12k_dp_rx_process_reo_status', the REO status is determined
> > > > > > by inspecting memory that the hardware has previously written via DMA.
> > > > > > Specifically, during the call to 'ath12k_hal_srng_access_begin', the driver
> > > > > > reads the value of 'hp_addr' for the destination ring (in my case, always with
> > > > > > ID 21). On the big endian platform, this value is consistently 0, which prevents
> > > > > > the REO status from being updated.
> > > > > 
> > > > > This does not seem an endian issue to me, because either of them we should get a value
> > > > > other than 0.
> > > > 
> > > > Really? I always assumed the value remains 0 until the firmware writes something
> > > > to memory and moves the head pointer of the SRNG ring buffer. By the way, I've
> > > 
> > > correct!
> > > 
> > > > already implemented the missing endianness conversions for reading from and
> > > > writing to ring buffer pointers like this one:
> > > > 
> > > >      hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
> > > 
> > > I was actually meaning that, when hp get updated by firmware, either with or without
> > > le32_to_cpu conversion, we should get a value other than 0.
> > > 
> > > So in your cause I am suspecting that hardware/firmware has never sent any REO status to
> > > host.
> > 
> > Yes, I see it the same way.
> > 
> > > > > > Interestingly, DMA read/write accesses work fine for other rings, just not for
> > > > > > this one. What makes the REO status ring so special? I couldn’t find anything in
> > > > > > the initialization routine that would explain the difference.
> > > > > > 
> > > > > > Could anyone give me a hint on what I should be looking for?
> > > > > > 
> > > > > > 
> > > > > What hardware are you using? WCN7850 or QCN9274?
> > > > 
> > > > I'm using QCN9274-based dualmac modules.
> > > 
> > > sure
> > > 
> > > > > 
> > > > Best regards
> > > > Alexander Wilhelm
> > > 
> > > so did you see any obvious issue?
> > 
> > For example, in the function 'ath12k_dp_rx_peer_tid_delete', the function
> > 'ath12k_dp_reo_cmd_send' is called, which in turn registers the function
> > 'ath12k_dp_rx_tid_del_func' as a callback. On PowerPC, this callback function is
> > never invoked, which eventually leads to the following error:
> > 
> >      ath12k_pci 0002:01:00.0: failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid 15 (-105)
> >      ath12k_pci 0002:01:00.0: failed to update rx tid queue, tid 0 (-105)
> >      ath12k_pci 0002:01:00.0: failed to update reo for rx tid 0
> >      ath12k_pci 0002:01:00.0: failed to setup rx tid -105
> >      ath12k_pci 0002:01:00.0: pdev idx 0 unable to perform ampdu action 0 ret -105
> > 
> > My investigations have shown that a cache flush is supposed to happen at some
> > point, e.g. after a timeout or when a threshold of 64 is reached. Since this
> > does not happen, I encounter errors after the 127th 'cmd_num'. This callback
> > function should actually be called from the 'reo_cmd_list' within the function
> > 'ath12k_dp_rx_process_reo_status'. However, this does not happen because the
> > pointer is always 0.
> > 
> > I hope I was able to explain clearly what I was able to trace. Please correct me
> > if any of my assumptions are wrong.
> 
> Your understanding is mostly correct. it is also possible that there may be something
> missing in REO_CMD ring (setup and cmd_send) which shows symptom like this in
> REO_STATUS ring processing. If other src and dst rings are working fine,
> REO_CMD/STATUS rings also are expected to work. Pls check src and dst ring
> setup path once again.

Thanks you for the hint regarding the REO_CMD ring, it helped me track down the
issue. The problem was with the 'tl' field in the 'hal_tlv_64_hdr' structure: it
should be declared as '__le64' instead of 'u64', similar to the '__le32 tl'
field in 'hal_tlv_hdr'. As a result, some necessary endianness conversions were
missing.


Best regards
Alexander Wilhelm

