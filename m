Return-Path: <linux-wireless+bounces-39141-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DiSGAqp9V2rWSQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39141-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:31:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830E75E280
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=live.com header.s=selector1 header.b="P/CFdRh0";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39141-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39141-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=live.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB90306A6B4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 12:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6D14432F2;
	Wed, 15 Jul 2026 12:25:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012016.outbound.protection.outlook.com [52.103.11.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173963644C5
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 12:25:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118359; cv=fail; b=nMr6mW/qppI+zH22Fsb42BTYGPKjk8LcRgxnsOOBNpHVfYSrljukdjr+1ooWzQ4e8TvI2vev/UB9Z1pXF0zb1+ykJ9ln8ky69OgqQldZjvejVmldkV3XJ2LTqwVc5nW+xlfIkgtxY0Y68mO5iqfXp2E0mwmtpULFWdNMTHzixA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118359; c=relaxed/simple;
	bh=ovnF6idiY+WnEk/fVXeJf5Dry7yG6KGaaFgFxoKGzm4=;
	h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:MIME-Version; b=UwSEI4oIcmGvtDXnJPxsHkcf5Ju/CpKKTjQl6SiSbRHZCG5ccLN1zA32BSuxfIwkAMgKE4RRjat8iOCSm4CdBkU7Qdyy8UNlBXfnStRPav5EPs/9zD4tBE9hSI2XZBf9nKwqHYdSOvW+/lMhpNsnq7OB9udkQxf+JuIg+OT9LV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=P/CFdRh0; arc=fail smtp.client-ip=52.103.11.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRmEaKOvghd4aElnZrvrOWNrqI0wRp08a4y93j3Dht1OHdWwWvK7z7+UYfVB1GMSV5lcG/ao1ZS9oEPQrGh5rsooxi5/Vijm3MNr48+lNnac1OHAqZxpYWJO0lY4TB1vY17PPNU1Wire1m1Zo4I1hb2VPh2tx4I0aTqhwTm2jf055ruqgzSAi6LEwq/Wma+lgDZnUsvNWFvOiWUIlno0TYW6KTFXZ6VGTnoDQkvV5PLiyAtBa7xH8CEgqzxtMhNw6qtXcHe1ljpSYsn3S9mv0CRMfKGchtHBk8vcJtuhODzKzg3Trsqd59YqvE38Hdsirjdau1Yfot2SXptPPgFjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovnF6idiY+WnEk/fVXeJf5Dry7yG6KGaaFgFxoKGzm4=;
 b=GCBMElzGgFsSC/xib2YBGmf3Yb0JFdGY+xsIfTuaBaY13TmP2w1wTjY1W92ktqrt1sTZgiwrlKbWo58meptDkKJCpiTEEFPPXXx9c5jfxSDgvO/imA1RvfTIBnN5XG0ZvE08ol9KAWoZtukaiyotWobyW0dQhpXLr+7MhLj5KaY7aLQmMKFGmpXDKeU1ASILzxv2qLQFRjANgzZuTdpgRo0wqx5tMPH6EW3l53EXaj/9DtezrTLwSpsUKCcEHxkXnTACurDE3GE7ne6lNc5Nufsqo7RvjX08u8pEjPCIXS31Ljcp+BhBzgtiGotQmpcdKEJrPFls52tF0ySg/48myg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovnF6idiY+WnEk/fVXeJf5Dry7yG6KGaaFgFxoKGzm4=;
 b=P/CFdRh0QNP+ZRmhPAQ4VLe9xckOhLyKNaVxGhAJIsA3ZtCaxaz2q/zfnwXE420V6fHwjZu7PmnoSfNFF6qR5IdicK7gq1XtjPhXwxc2wnYTAYTYJvbXumFYT9LLOGk3wyxUCJ8mTzieQ5W8Hx9StmPDR/k4pKm2qLA+fF/8nNsqhdLD0vvs6+bK0R2aJj2VTSWl6wJbp9fewho0RSWNmAKuzN4akT9zgzWfSbZ/7R7TVo7tZqw/jVCy2qqw0d0n4D9tBtMEXEV2bCohVEq5A5zZu0ydp8xkbsr+zy6bAhYdgAXKQh03QEEWRyphoR20sq4cV0L3zdNfhbiu5XeZ2g==
Received: from CH3PR15MB6020.namprd15.prod.outlook.com (2603:10b6:610:156::20)
 by CO1PR15MB4905.namprd15.prod.outlook.com (2603:10b6:303:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 12:25:55 +0000
Received: from CH3PR15MB6020.namprd15.prod.outlook.com
 ([fe80::a655:4b65:19a2:85c1]) by CH3PR15MB6020.namprd15.prod.outlook.com
 ([fe80::a655:4b65:19a2:85c1%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 12:25:55 +0000
X-Forwarded-Encrypted: i=1; AHgh+RrNaTpZ2qdmUN18xuveDS8D4B/FdJWY9dL0Bt1UXI2PupVZGdA2hq51IFeUxf2ayceRXBWdLW7eBtrVOqFDmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQRK4g4wFxYECleCv8e/3F9NwJ5/kZF+Io1pWYtr5g8vmPqXk
	ShC4OYGpZbd5hrqdIlE8lymHpsVSYn4eE+1NlxnmAwwqeFmxvtirWxQ3Ne/B46h2OsSC1sQzvxI
	rg1jT8pEqqYTtAMLDUMhxwAuLPGHkIbE=
X-Received: by 2002:a05:690e:4846:b0:664:db84:ed3d with SMTP id
 956f58d0204a3-667d7ba119dmr8564735d50.34.1784117869457; Wed, 15 Jul 2026
 05:17:49 -0700 (PDT)
References: <20260715044431.1207-2-mbc07@live.com>
In-Reply-To: <20260715044431.1207-2-mbc07@live.com>
From: "Mateus B. Cassiano" <mbc07@live.com>
Date: Wed, 15 Jul 2026 08:17:38 -0400
X-Gmail-Original-Message-ID: <CAGsSZgFqeNpPXS8q9VYGGqE_ONVCD-V18vf0+R6tZTS2PeKv9Q@mail.gmail.com>
X-Gm-Features: AUfX_mxOOoY9ApWBCAUqz59WbsS2BJPtu3vHRvHFhz_-iHIEJl9CYAM8tfkxSs0
Message-ID:
 <CH3PR15MB6020BE2284EDE2F866566EDAC8F82@CH3PR15MB6020.namprd15.prod.outlook.com>
Subject: Re: [PATCH] wifi: mt76: pass LED define via ccflags-y in driver submodules
To: nbd@nbd.name
Cc: lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: SA9PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:806:23::6) To CH3PR15MB6020.namprd15.prod.outlook.com
 (2603:10b6:610:156::20)
X-Microsoft-Original-Message-ID:
 <CAGsSZgFqeNpPXS8q9VYGGqE_ONVCD-V18vf0+R6tZTS2PeKv9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR15MB6020:EE_|CO1PR15MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: bf761659-6fb0-4805-8674-08dee26c3795
X-MS-Exchange-SLBlob-MailProps:
	zBrA8FKYimgH16ycykJ01TX0wxFqAOtIYhiNbohRJtMwNBliQkLzvs+5fWO7/AQuEbLGjfshje4k1FX+LkPHI5RJQmSsX1M910BUqnnK58aVHNaYfl+RZM85ETogc+goLT9S+i0DE7rWmm+TTYHcSQzTkqAGTKACUVZrp8/hzQcUHv07gTM+dtZ0MzFOT1WsYn7MLDTFnrEsZw54y1ZRN/sfOGGSeWslOVgsNHDtC1scIORydeub0tmS1jd+RlMHuRrUkoeSUjEBoYTjcQzVglfXHEHZGBz6QXPxzvT7XR0NePpZrNKVU29I2NM6PsZeNN/j0hV+ApdZjSfth0r72PKdKEq3twTkPc8hzg+Cc4R49XwWFsMj8DnSY4odcwD0Q558CUTtpTA3ix02lwkrWFEYeQlzyF3J5eUzi0Xsd152EkCTpJFv9HCLVRP0my4SuE1HqwIwS4fHtKQ+oAjcup2CadDP76rr7Ig39hgQBJw6u1kyG2itnZu4Wcp32xZj7rxnXeawzd1P7y5ByTn06gyAe+J9epuZmjJYUI91e5YI3eGwqijtS6I8dPiaL9hap4BkMyYJfIWboZGONyz0V9vaTLJCi3d4tNDE+uHTNykbwQCki9epCDwGN+3UOkJV+J1mC+5dO/4nH1wnaeJCAtOH9fEFUmmgmI9Bfb7UsQ5pSFor1BCy22tvbkZGAfALHzrGTRaRPk6lc9J8WAfl2QUkOTvyqX5ZieymT1505YXtfk3VkhfwVTsrdqCx1xCM4BJLrnSj3sxRG1P41G+FLvHwX1pZ6v52HvFhkGcmiM7ZOt1G4dsHkg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|15080799012|25010399006|24021099003|8060799015|23021999003|19110799012|6090799003|3412199025|4302099013|440099028|19061999003|10035399007|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDlXckxlVVZTeFdpbnF4REppbW15clEvNDhLQ3BUNDdZelN0ZkYram5RUE1r?=
 =?utf-8?B?WnJzL1NJV1FETjBEZmJqbWIwOXh2RitzUzRqZWVoYU1BdHNCRVUwenh2Nmo2?=
 =?utf-8?B?c3BEUWM5YVFzblJERVFMZThPVUlvOFRsMDdLbzVid3ZSZTdDeFQ1dVJBQStv?=
 =?utf-8?B?SWJwQ2VCVmJOZmpTTFFwQUdlVzZXUVJWdFhON0xoUndkcXFtQ3p0RHBseFRp?=
 =?utf-8?B?YitHaGxEQ3UwaXN0VjUzaEVoNVVxUnNnUDJEU21wSGh6MDk2WnNacGJURk5N?=
 =?utf-8?B?OVprTGNnTEdGZU91dW40VVcwbEFmVUFVU05RTGN4M3ZGVlZCTG9WanFUTU5k?=
 =?utf-8?B?YjJPSW0zVjlNdWh1Wll3dTlwMWE2eXdXekdBdHo5dzZBZE43VWpJR3BQa2tS?=
 =?utf-8?B?VXY2dGhUYno5NDZJU1g1YkgwUllXWUlzTUVtRzJ1UHBDV0JEWnhsd0FVaU9Z?=
 =?utf-8?B?STU4M25TTkZyOTE1RmNDbm1jTWI3NFE4OTVvbHBsMHdrKzZZS3NNUkhXMVZh?=
 =?utf-8?B?bTd1ZDNmUWhGeE8xVjdXZHZ3VFFzazRVWSt5R3VkREk0eUxrTEpUdUJRVFkv?=
 =?utf-8?B?UCtWUC93bzEyQndPejBmbXJCaklUVXRVOWtzaStmYWVJbk40ZHVWQlFKNjk1?=
 =?utf-8?B?T200RWl0NnV5c2doZGxGTXcwbUQ0L2dYYm50b2dYdEtDU3h5ZTMrbDl3OEgw?=
 =?utf-8?B?UDB4d1hsS2J2aThwVzl3Z3cxeDN0aHdzQzV2V2lBU3ZOWDhKTzhBYm9jNE8z?=
 =?utf-8?B?c2ZaUHVVOGNpRWhrN1F4RUpNazVsMEgvK3NaU0VrTmhRbjVWeWQvbHkrRUdY?=
 =?utf-8?B?Qjcza2ZWVkJCazlrVFRWcEtwSk1CdnR6b3RJRmN2VThsY042cyt1Ukk5cTk1?=
 =?utf-8?B?bWNZL0cvQlpMMkZsaFltRGZSY2hpVmxlanFpZ0xmOTFWSXZaeStxK05jaHZC?=
 =?utf-8?B?VzdZWUVSUGdVR3VqaGd0aklZMW1pMEFCQUhkcEVCRTBJVFZrTTBra0pYQXE2?=
 =?utf-8?B?dGExbFpLYVY1QUthQkVWdklrbHk0dUJTM1lXcGRYbHVjYi9ycHFEc250a29i?=
 =?utf-8?B?dUkyenhiUEVYUDY1Q2tBYXVodmZmMTR5TFFWTnQ4dm9UUGJ6VTZKeFV4RS94?=
 =?utf-8?B?c1N6OEVHa1lVNXZ4dEs3V2JDR2xyejdnRGg5MnNKbVY4dzI5SXBVZTZtR2ty?=
 =?utf-8?B?T1ZaZVBTSWJRdmFUdTk4M2NTRmg1UXIrS2VDZ0U1UjBidzdtRmp0cVZzV0Y0?=
 =?utf-8?B?aHVHTUxkUy85V3E1SXF2RzlHNHo0OTNycjhBeHFac1F0ajRYUDBwbmowMzU5?=
 =?utf-8?B?L0puS1RSd1V1emVpdCtvKy9QNXV6OFI3b09HckhVREZlbDRlWXRmcy9Rb09h?=
 =?utf-8?B?TG1iV05OUkdBak1aME5Xd3kweU4xY2NIVW0rZjNEN0dpNUNzM0xkZ3dFWVFv?=
 =?utf-8?B?QkUvc2xMcWFPZ2VaNW4rRE05TFhseWhzem5Kck5nPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDg0b3kxR1V2ZHFQZURLUXdHU2lDYUxNa01PY2lMaEtaU0gzVmc0T0ZkK0c4?=
 =?utf-8?B?WWsyNDhxS3RmdmlrZjdnemlPbng2Rmp5a3BHSjh1NzVkNGJXd29TbS9laFlk?=
 =?utf-8?B?QS9kQUh6TmNRM2JWK2hZQnJQWjcraGEwejYrd1NKZWQwK0hhclBwTjlVNUU2?=
 =?utf-8?B?VFIvWWRvU3NwMkc1UkNnblF6dXlmb3daVzlTNTd4TWt0YjExWmZjM00yTGFC?=
 =?utf-8?B?WVJrbkEzbko4ZmZLQWszTjJRQ3VHdWExYVIzdWxUT2JweVhJeUozUEo4V1Zr?=
 =?utf-8?B?NlZraGVGaDZ4QXF2dUtERk80QnFMa0ZBdzg1VVpMbk5KenJ0NTJTVEJkOFNH?=
 =?utf-8?B?NXFRSHhVdGtmdzc3RFcvTDMxRktGNUM0SVlMbTJqSUZ2Y3FmM3lwK2FuUzIv?=
 =?utf-8?B?aWk5aTRoTHZaODNCL3ZuY0szdmhKYW1RUjN1T0Z4NE10MXJROWFFZXJEL01Z?=
 =?utf-8?B?QVdjdmtReU1TeGN3TG9ETkRQS2VCMFk4NVdsTjRyUzFJZVpPRHQrOUFTWnBM?=
 =?utf-8?B?NlRGQ3U5b2toMnMwZzBuc3NJSnpFZW5FTjR1d3RJNGZGTnhtWlAySGJsSHhp?=
 =?utf-8?B?SXd3K2NLSVBQMWtScUpVTG5zNWdOb29oSysxSTRwbEVvQWdveW1OSTErQkM4?=
 =?utf-8?B?emlRSEFxNllRYVNtbW1iWU9YbEtlMVhURDRKU0lLcXNma3RyNjEyWlo4K3R0?=
 =?utf-8?B?Y0U2WXpuaGxyL2U4RzVCdksxQWx4RHMvWnlMTWI4UTM1U3hheklGeGV4MXNw?=
 =?utf-8?B?RHVLdVdhUlhoQmJ2U1VYN3FsdnJsRERHb3NVdmx2VlBoamwzUUNLb0k1MXNz?=
 =?utf-8?B?WlpxWVF0WUlIbnpXdlVZaks0dXpZcUl2NVFSVmlreWJLa2ZIWjQ1NVRocFZw?=
 =?utf-8?B?Smx6VGptM3BTZGtDVkxjdEg5Z3FGUXNrdUNVcFRhVXl1ZS9xSFdPcmVObkpv?=
 =?utf-8?B?UGR1TnRtblYxOXZUQzdJUS9lMEFxMWYweGc5d0Z0QWsxNFlubkNpUEdiQ2or?=
 =?utf-8?B?NWVsTkxtTDdiZGN5K2dqVHZCQ2tCTWZHSFFFcjVQbHhHWGZzbUFQcEJqcGF6?=
 =?utf-8?B?SksxU0ZXeVk5R3BhYm01a1NFM2czSHUwVVFrNnBaSlpGZkFLbytKWWExS0Q5?=
 =?utf-8?B?Z1NOMEZNRGthblZLVkpyUi9FaXJGblJ0MUcwQ2FZTmR0cS9KbWVaYzJCOGlN?=
 =?utf-8?B?VVJGN1diNHdpaG1Uem5zSS9QakpTN0V1VjdKdmc4Rm90ekpZb1F2TCtOQWRm?=
 =?utf-8?B?UmdXc0h0UlVUWU42N2g2TENQaDZQZGhaZHlsS2ZFRlhPSEhzMG8wV2xiWnRD?=
 =?utf-8?B?N2hqa2N3MkVmQU5CVjFuUWsrSktqdWNRQ1YweFYzQmVHaXlSVnB4TGF4MWNN?=
 =?utf-8?B?dmdMOERSQjErTnR5Z0gyZXJqQW5jdUIwY1RxQkFVN3RuZlB3K3RnRnlpNVNy?=
 =?utf-8?B?MEJNSWNHeEQxa3UxaGl5WFRONW5Dd2xDc1g5R2MzT2Y5TEZzcTV0UG14eWx2?=
 =?utf-8?B?cDVkcTVJeGhSdWtTMkNvYTl0Yjl2emdGTG5USmw3TWh6eUttVzlZb2dZUEFt?=
 =?utf-8?B?WkNPTWNCR0lDSTllTmpERGdvTHJlRFNZQVZqYVF0azZpZWJMOS84eU45V2JH?=
 =?utf-8?B?RmtuQ3RLZDdsRjg4T1ZPRjgvcjdqcW11aGV2QlU1ZEdYbUVQNS9qenFJVml2?=
 =?utf-8?B?NFh5eGlxWDhoQTJSZEN5cW5Jb2lLWEkyZHUvZCs4RU5odDVXQTJPRlJ1aGs2?=
 =?utf-8?B?dVJ2R3pZcTRKZXQxeGxpN0orTms1ckc4UEY0K2Q2VkRkZmJLc3RRTytEbjFV?=
 =?utf-8?Q?Dpi6GxPQIhrkU054X+xyHwO7Qho9+Cvrkcyiw=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-d4257.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bf761659-6fb0-4805-8674-08dee26c3795
X-MS-Exchange-CrossTenant-AuthSource: CH3PR15MB6020.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:25:55.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4905
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39141-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[live.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbc07@live.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbc07@live.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[live.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3830E75E280
X-Rspamd-Action: no action

On Wed, 15 Jul 2026 00:44:32 -0400, Mateus B. Cassiano wrote:
> mt7996 in particular enables IS_ENABLED(CONFIG_MT76_LEDS) code paths
> that appear to have never been built with the define before, so it
> would be good if someone with mt7996 hardware could confirm nothing
> regresses. I'm happy to drop the mt7996 hunk and keep only the others
> if preferred.

A user has since confirmed on the closed GitHub PR that the patch also
works as expected on mt7996 hardware:

https://github.com/openwrt/mt76/pull/1090#issuecomment-4979596316
https://forum.banana-pi.org/t/bpi-r4-mt7996-be14-per-band-wifi-7-leds-now-work-incl-mlo/27574/11?u=avbohemen

