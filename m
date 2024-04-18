Return-Path: <linux-wireless+bounces-6477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CFC8A90D6
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 03:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5435C1F22455
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 01:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713288C1F;
	Thu, 18 Apr 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="p/o7HTcl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pJ8p3Id6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8257848E
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404598; cv=fail; b=EWR2WJftYXdTi3QjQK9Z3BmgSSPECwXiqql+4bYCLffcc/2bznZe3NFCYyWCaR83of7curlbY66EQwWNKjZnK8Tu/84yH5BPUjzaWxw1aQl5LS+IWWda9rcLGTofkr/PObaZVBbBKpkwua9etxmcRFSNJxkiTNz8nIHfvgCln0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404598; c=relaxed/simple;
	bh=l19uUhq5r0w9SnJu8qi5aKLnPsl29gQTbq4zA8WMZUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CU/NXEVGGQkd5v00AEhzpUXTLhdOUq7Jt0KUZRCvuS4ws2Zwa3vpqSQKik15jLjSBBGvsuPFIeo78whDn9xFprCH/lwkL93sAchWVxDKDodLEsyVzWqFEfhynswd4wn7HFJ8WWL+ObKhyMv8+BIiGtpOV2CmJGdxpzZ6fZaTi2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=p/o7HTcl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pJ8p3Id6; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0232a482fd2511ee935d6952f98a51a9-20240418
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=l19uUhq5r0w9SnJu8qi5aKLnPsl29gQTbq4zA8WMZUE=;
	b=p/o7HTcli6E/Rf4g3aCKzK0+T7NaJb6RYZG0EwGiEGfhoJWDk99ErQQ/QBt6Mr1SW3K9fLp5ZHTQmWazJjNhJXA4Xmd+R40igoa6Vnx+ztY0AyT89n29DInx1nRBwI0XtBZxH4BGYE5AbSTplhqt9bv3TUymjeDszQjhHpwsxnA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:58ac89cc-d338-4d68-911c-cf685c1bf7a3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:04bbb591-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0232a482fd2511ee935d6952f98a51a9-20240418
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 425295068; Thu, 18 Apr 2024 09:43:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 Apr 2024 09:43:06 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 Apr 2024 09:43:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeigTwhJJ/kOXrPyO4khM4UeOza5XKWnVnjG/t+pINQW4ZKfm3Mpv8fd+LP2TTYsvCenyMrm67LFW1WtvQpbBmVIfI2X5FDgWjCV4YPcl1aWPdnrcBxjouTRmxRF1EKdoWUYRW3vtOON3EXAfOYQtVFzDk1bw51OtMbyolPfScyzGiWXD1ci3q5wifTvESTH4vCtfDPcQFoK4BqDYN4qAW9Tg3ex/fE4FrGmTKfnrAkk+QBT2IZC2y3D8AbkqAE165wc+fHVhqCsKq5Z4oJT1knK1ODAK9T20B3lYOD24nID+10jq0iu9d8cO/GFPCU4M2ZtfLbHg7M+ZSc0V0rUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l19uUhq5r0w9SnJu8qi5aKLnPsl29gQTbq4zA8WMZUE=;
 b=K3nw8BH8ubo9D4+Aq2e5CrhVvzbJHHGcRicbGYYSFlcx+CA1BPhmuhYoCwUuz/Ldlvrakis5Km9ke4+OqLqCZ/yRStNxJmdtd+WYN/7O4RbSFC8Bm9SrfN0b5MHQEcBwgV+Lebi/1DzXvh3Y6AkfuqpigW/NalLS+ZoFKIZQ9yR08OEvvqI/j049B6FE6BnB5H758WtudFGbzsv6WfLz50CGFZkgOvMj4GwFEqCJ//+Kf7KK8ioz4fOrvlNi7y/PRqcSQ3o9RlCTVqXmyYM0G6+TZF1gVyaIfZK0AIEzJQVk5GHN9rJFICjs+zFtk1V8oDANYwNdBFjzqixB68pEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l19uUhq5r0w9SnJu8qi5aKLnPsl29gQTbq4zA8WMZUE=;
 b=pJ8p3Id6svo2q45PF5jKqadTnV+bUZN59HOXXlPWxlV8Pp3LsBRkmWNQsUfeXbVUYO7sOtuaMugCWByEt7dDn3ubzVB+lt5r6m/0CzTB7qFcsLHhcHGBPXAV2KbOvsxTClWkFha3FnkqQcyvYdTLNkpgN6XJ8dT9fpjh8JlMvkg=
Received: from SEYPR03MB6458.apcprd03.prod.outlook.com (2603:1096:101:3f::8)
 by TYZPR03MB7520.apcprd03.prod.outlook.com (2603:1096:400:41a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 01:43:04 +0000
Received: from SEYPR03MB6458.apcprd03.prod.outlook.com
 ([fe80::190b:9e74:203a:455a]) by SEYPR03MB6458.apcprd03.prod.outlook.com
 ([fe80::190b:9e74:203a:455a%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 01:43:04 +0000
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
Thread-Index: AQHai9HdodnicF9uoUmeIynVnLuujrFtD14AgAA8fgA=
Date: Thu, 18 Apr 2024 01:43:04 +0000
Message-ID: <37ab8a32893ea9a1cbc33b6dae26b57127ea4e16.camel@mediatek.com>
References: <608cc2bb1c10c2f53a6bf26711bf49fe2c491e59.1712806947.git.quan.zhou@mediatek.com>
	 <CAGp9LzqVGHGriqpC-NTnOtvNNz5o-hXD=HcTCptHfXBD9bnfPQ@mail.gmail.com>
In-Reply-To: <CAGp9LzqVGHGriqpC-NTnOtvNNz5o-hXD=HcTCptHfXBD9bnfPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6458:EE_|TYZPR03MB7520:EE_
x-ms-office365-filtering-correlation-id: afad7de5-ee89-478e-f4ba-08dc5f48e3e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?SnJsa3lwMXBWZ0Zka2tPNUJkRGNCcVRDRWdxeDE2cDlzOExxOWdoL2hpcnND?=
 =?utf-8?B?SlE1WGZ0YW5jamwxSGl5Ylo0WmdsYldtOFJUZkhyN0xZNXd2SkplSEhCdnNl?=
 =?utf-8?B?eFoyL2ZLSC8xOFBMbWs1MzAxNDJlUXAzLzRqcm5MNVBjY3c0TFJtZGdhNHBK?=
 =?utf-8?B?bVpyVTJmUGFxditoaXVEMUZubmUxcndRKytOZXVKdlJDWTM0d2tIZllhRGQ3?=
 =?utf-8?B?RnVzRUdodjg4NklYZkhoL2J6YzNBZm8wb2V2RnAvN2pZZTUwVXhibHBJcVRL?=
 =?utf-8?B?OE11WnBtSWRWTi81bW1MdVJiWWNvWlBOQVREM1lOMjIvQ3pSa2h6N2Ruc081?=
 =?utf-8?B?VFNYWEY3ZnV4TmdWUDRrdEsvM1hXTnBoa0J0MTVycTFFc2NrTVVHVG1HVlFq?=
 =?utf-8?B?TDk0YzByMG1RQkZXZVR6bUtZdWVodFplSEl0OWRIeEV1L0JMU2E4WEZiMm9r?=
 =?utf-8?B?MVg2RUJxSGt1cU5pemdoS2tkWmtLYmhxSnYzVDEyRkdQRlZYMlllRjdPN0Rw?=
 =?utf-8?B?dmM5aVBDQkRrVWZCalNiK0oxZ1lCNWo5YThOV01qV21xK0duOFZoQlAvYysx?=
 =?utf-8?B?ZDM2ZlZsbTZ4QmpwdXdNKzgybFM2aDFralZzMUVybmx1NFZKZ0V5UUZFT3BH?=
 =?utf-8?B?aUVNcGozbUJiY1U2ek5IL2RkV0ZHcHhIMzdTVlpoKzIrVUN4azRFUEJqMEVH?=
 =?utf-8?B?QWZ0R1dtN1RuR0dCR3lSbk9yaERkdG1KS1QycC9NSzFpRzFJendDa2FlRlpS?=
 =?utf-8?B?NVFTZDU3ZTlLVkNuTk1MN0hVRTJoUU01MFEvSmJ0LzE0ZmdTYnl3UUN6Ym5m?=
 =?utf-8?B?cW5uTTUxOFBUV0lvMkxrRDJRTWZtdUhvblowRXFoaTRpTEpISkZ1WjMxZDVa?=
 =?utf-8?B?V2NYMENMRXRMS2o4eHpPRHl5TVlCaUhPcTZLUzdtby9qNE5NL2pJLzhESnFm?=
 =?utf-8?B?aVpjZDBnSjZUSm9hcDNNVnk5d0ZmczBVbkpQbUdSR1dYTFdJdGdJTk5ZTm50?=
 =?utf-8?B?OTVKYXNSeDNZWVZQYU05VGwwKzlLNkFvUUtEVW5MNVVUTmwyQVdMVTVhYVJF?=
 =?utf-8?B?TVYzUzg3WlE0Q1R4MEhZcDllcTRJMUg3ajlLODk5ZHR2YzFidXBQWWcwVkp5?=
 =?utf-8?B?ZFp0dTZ4OUFGKzRmU1UzVHpOa2dyRWN2STg1S0VDU2UzOHptbkU2MEdiL3l2?=
 =?utf-8?B?cTBrYjRxQU1qYkxYeHFjTnREMVlWSmVVaUkxWG9SSFhZMW5uMTdKQnNndXdo?=
 =?utf-8?B?YThHZ0tDYmh4NTVPeU1NWVluV0FxdzArTGFWcHk1NXN3ZFpDb2pTY1UyQVdz?=
 =?utf-8?B?RktxOGl3SVQ0d0h5RDZ0WUpsNnlCbmNBS1VjNFhPZmxzNlJTZWhhUjAxUDVl?=
 =?utf-8?B?eUZrZ0VhSk9hM0FsWFdUdHpxVElxQWh6UWZ5OGhPNmZUeU91V2hsNVdYa0lS?=
 =?utf-8?B?YW81bEV6Y1Zrd0taMmRaNXh2Rmc0akMrclFSM2djYzhQSEprTjRBcVZuYVEy?=
 =?utf-8?B?TC9vUmxsdCsxOXJWWGdteDRUVEdjbW5YSFlGQ2g5cHorUWtCYVFVWm93NzNT?=
 =?utf-8?B?aXZBdERwVy82Zm05U2Z1U1lBamtkVVNIVVNzS2FUYlYreFBaNDU1TWhyeEFJ?=
 =?utf-8?B?N3lXbVFWR3ZMYTNvYThNVm8yeisyRVVTOHkyZk9pMDU3bmJSOGQzMnVsbmli?=
 =?utf-8?B?U1N4QnZPOHBUQk5nQTVkNHRkektzenNlR2NUWUhNTzIxMWo2ZHkyWFJ6aVY4?=
 =?utf-8?B?VXZZR0ZJelU3ZENCbjhDSEpmVUtIcXZENVZZdUUwRzlDNXFrYkE1Y1lPbnBR?=
 =?utf-8?B?WDNjSjVONG5lMldzbTZmQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6458.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2hFVVZ3blRCMllyZHNxOUh6VnI3WGZrVzl1ZSs0Q3NRYUlYb3pOZGtqcGdu?=
 =?utf-8?B?c21rM2NwSXh6STZMc24xemE4d3V6NjRydGxkZlJUVlVkc3U2c1Rtc21kWWU0?=
 =?utf-8?B?TzFvWUxDV3V2V1pZSGE2OVpSOVoyT1dTOExGU1ZNaE00TzBycEsrcWppaEhU?=
 =?utf-8?B?T0lqVkxpaW9XZjBMOU9zajNCNUtpNmFhLzI1bEFaZDludkxpT25pY2liRVBQ?=
 =?utf-8?B?VEJKMHRyUS9tUHh6cVpHME8wTVArWUhPeTdzajZrb3RSVGczcEZNVHRzdXB6?=
 =?utf-8?B?WnNFTXlTRW5HazB2bmdGQURiTDBBamlRYXJ1TCtyN0FsQ3k1Wm50S3pORTZ5?=
 =?utf-8?B?VFcvUTdzZWdWS1pid3pvWjZIdytNZkJpZ3RSOFhXVng4TGZxNklNelpyY2pJ?=
 =?utf-8?B?WUt6d1Y2SlIvdHhnNmNxRjVLdHMwZlJBK3cvelBtVkFUN3hPd0VLS0dEVVVX?=
 =?utf-8?B?SHhEWkFlWHhZZ0g0T3lTZUlpTDNoSUZjU3FHZkxEdUQzOWpTOXQ2NTd5Y25z?=
 =?utf-8?B?K1Z2SlBDelVJSDQ0RDVBOVRYc0w4L1pBN3dQZGdRV3FxaFRSTWhKN0xBc0VK?=
 =?utf-8?B?TDd4VmtPYlRaZFpNRDFzaU9CaHYxUFlpUFhvWUNqcjBXTWlWMlJVclU1dk9n?=
 =?utf-8?B?Q3NiOUJ0YkxVUEdscFUvK2ZPaDV2WUlRekIzRitpSjlzSmlJbkZ2SzdPQS9E?=
 =?utf-8?B?ZitLSEZIbmF6U29nT3lrVEkwSk1Nc1cvazI1VTdHS05mZlFqMG9NblcxYlFD?=
 =?utf-8?B?KzRPZGhOcjlkcVdzVDJBRVByU2hjVldsZnV4aHZubkxOM2puR0NpNUc1bnNo?=
 =?utf-8?B?d2l4eXYwbWRDQlpxNFYwakZQVHd0bjNva1Y0Q0EyMlRrZzBEZVVQdHJiTk1D?=
 =?utf-8?B?OFhRWGM4VGxxSmROYTZJSGhoWDExUzU4THA1L1gzNTdkYkZ3Mnp3OEM1UUFB?=
 =?utf-8?B?bFpBdXc3R0RJelpENFd2NXhHKzVQOVFHbFdkVnBEcGlqYkxOeXBoUjZyVG5z?=
 =?utf-8?B?UXZxcFZxOURJSXM5NjIwcjZIVXdHL2liOVNUYTVqaTl5M3I2UzQ5VlgwNklz?=
 =?utf-8?B?OE9NWkdMbFgxSWQyMWRSdEdDZGZxUERnbytEL0ovZ2RXMXo0RW5QOTB6Nmt5?=
 =?utf-8?B?M1ZZUEd3b0NJNCtuQkVlaTkxQk5xWXowcFEwSmtUczJ4VGo0YzRQNVJ4aWNF?=
 =?utf-8?B?R1hUOXJwOGtjdVdqTzFrSnFrUktnb0JpNjAyU0lqenlpd3NUMWVDYXZ4enl5?=
 =?utf-8?B?M3BpRHVlcjMvNjhFdCsxYzRjS2ZSTk9NTjM1cmd3aWxiM1I2VlFYNFRLekEw?=
 =?utf-8?B?dWtTNHA3ZUFlMHZuTjFQaFY2dm5JZ3BhQkpKNk5NbE10NURYVk5xSmdyYVc3?=
 =?utf-8?B?d3hDRFgwRE5jdnlpcWc5dEVRZ1ZwVGdsMFR4NFZPSWN4dnlLRk5sUHYwUzIx?=
 =?utf-8?B?VHZodVJKUC80STVqNkR0T3BsV3RXSVYxUGlJRTZwZ0J1cUkrNlNubjBlUlk4?=
 =?utf-8?B?UmxrdzAycFZNbXBBQzVCQlJJYVRVTVRKQ2p2c3JiN0hOZHlhNGhiOXo4bUow?=
 =?utf-8?B?Mm14Q1hZckpxSHJscC83cGlYMVppdzhuQXp0b2RFNmNsTTZnZ1hUSXpFbVdV?=
 =?utf-8?B?ekhDNHY0Uml3cFF4dkh4NUxOV2xKc3IzV25GR2JoRmR5YUpTWk9VUllSc3VS?=
 =?utf-8?B?WmoyaFEzTnQrWktPVXhpNE9HMGFvbGFMS0ZZUk0rdkFXSnluZWgzREZxQ28w?=
 =?utf-8?B?SENpS1VFem1QOUVGRERSeFZoK3hGNGpzbmVpek1LSWl5cmdYdDFBUE9vT2xF?=
 =?utf-8?B?SlFOc3FiS3Eya0x3TzNPYjZjOTJOcENSSVYzbG1yOGx4c1lqbWJubjBPUlow?=
 =?utf-8?B?YjlBQi9zVUhKQkh0YWFKRFlKaW50UVJBN0RLVXpyaTBRR2FaWHYxZkg4Q1Fi?=
 =?utf-8?B?L21selYxS0JvL2NxY0J6RnQ3UzNFVXdsdmVWclhTdWNKT2JwbFJCMlNIYWYr?=
 =?utf-8?B?cEtMdE02cGhSaE5pT3pXUy9XazQ4cGg0Zlh1VGt1RWpXREo2OHlwamQwdEJh?=
 =?utf-8?B?aTgyVlowZmhuSVlaem9SRUQ3ZjlQbGVhREdrYmp2Y3lUamRMbHNySU1HSnUy?=
 =?utf-8?B?S1hxV3VQOVFUeTlPU1BPbG9UeVFhM1hUU1RwTE5xUGRCU0czUXZWdzA1bzN2?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A39A2316A715EF489419A1769CF1D059@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6458.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afad7de5-ee89-478e-f4ba-08dc5f48e3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 01:43:04.5031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfT1IzXM9btjNGA1H3YjvYaYNA+TzAan9WKkp0DNXN2w9CK72hjq8elC0PjkgRGAI72xOasXncvXmGhdwRRv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7520
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.017600-8.000000
X-TMASE-MatchedRID: PL66URbwWA9BfGdIwmVjfCa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2t+YXwgWdSaC+2McZY43zJ41wpnAAvAwazFxP
	fMusXQ5YBka8LIfx+oeKH9vUeWcz19mia1kFQhdAD2WXLXdz+AV+U6kGoEdO3YmQk5BUIinDNi2
	Ps89I8F2ztOmq3JjjYdwMhIlsQgvTREKzvS64+oRuZoNKc6pl+Rtu4vtjjtzR3vUA6/Pi03Egsz
	xgJpPe55TdBAtSV7T1RNJwXCumNWu6oG5WaBwJaZlRzaO1xpJ2Z2scyRQcer9M2my+Pv+HL1Fvg
	6E0U6v9nOcSWpQ67zGxn7Vh3itXlBCaQyxlaPkG3D7EeeyZCM1XXZO0BkB2nv8D7QPW2jo8fZ/c
	4tyoTbSmpeXlunaw1A6G1CdV/YzxasbIRx6ImM2095hplj6TXYQXxsZnRwoJoMXogvMW/faPFjJ
	EFr+olFUew0Fl/1pEBi3kqJOK62QtuKBGekqUpOlxBO2IcOBaUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.017600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5406677B87E077864A4B8BD39122599E43A43BB6CBF2699794903641A41354752000:8
X-MTK: N

T24gV2VkLCAyMDI0LTA0LTE3IGF0IDE1OjA2IC0wNzAwLCBTZWFuIFdhbmcgd3JvdGU6DQo+ICAJ
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiAgSEkgUXVhbiwNCj4gDQo+IE9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDExOjAw
4oCvUE0gUXVhbiBaaG91IDxxdWFuLnpob3VAbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IEZyb206IEhhbyBaaGFuZyA8aGFvLnpoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPg0KPiA+IElu
dHJvZHVjZSB3aWZpIExFRCBzd2l0Y2ggY29udHJvbCwgYWRkIGZsb3cgdG8gQ29udHJvbCBhIHdp
ZmkNCj4gPiBncGlvIHBpbiBiYXNlZCBvbiB0aGUgc3RhdHVzIG9mIFdJRkkgcmFkaW8sIGlmIHRo
ZSBwaW4gaXMgY29ubmVjdGVkDQo+ID4gdG8gYW4gTEVELCB0aGUgTEVEIHdpbGwgaW5kaWNhdGUg
dGhlIHN0YXR1cyBvZiB0aGUgV2lGaSByYWRpby4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhh
byBaaGFuZyA8aGFvLnpoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IFF1
YW4gWmhvdSA8cXVhbi56aG91QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBRdWFu
IFpob3UgPHF1YW4uemhvdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjI6DQo+ID4gIGZp
eCB0byBhdm9pZCB3YWtlIGRldmljZSB3aGVuIEhhcmR3YXJlIGludGVyZmFjZSBub3QgcGNpZQ0K
PiA+IC0tLQ0KPiA+ICAuLi4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3Uu
aCAgfCAgMSArDQo+ID4gIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvbWFp
bi5jICB8IDI3DQo+ICsrKysrKysrKysrKysrKysrKy0NCj4gPiAgLi4uL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkyMS9tY3UuYyAgIHwgMTQgKysrKysrKysrKw0KPiA+ICAuLi4vd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvbXQ3OTIxLmggICAgfCAgNSArKysrDQo+ID4gIC4u
Li9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvcGNpLmMgICB8ICA4ICsrKysrLQ0K
PiA+ICA1IGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2X2Nvbm5hY19tY3UuaA0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3Nl9jb25uYWNfbWN1LmgNCj4gPiBpbmRleCA4MzZjYzRkNWIxZDIuLjRjMmRlNTU2ZGVlMSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZf
Y29ubmFjX21jdS5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2X2Nvbm5hY19tY3UuaA0KPiA+IEBAIC0xMTg5LDYgKzExODksNyBAQCBlbnVtIHsNCj4g
PiAgICAgICAgIE1DVV9FWFRfQ01EX0VGVVNFX0FDQ0VTUyA9IDB4MDEsDQo+ID4gICAgICAgICBN
Q1VfRVhUX0NNRF9SRl9SRUdfQUNDRVNTID0gMHgwMiwNCj4gPiAgICAgICAgIE1DVV9FWFRfQ01E
X1JGX1RFU1QgPSAweDA0LA0KPiA+ICsgICAgICAgTUNVX0VYVF9DTURfSURfUkFESU9fT05fT0ZG
X0NUUkwgPSAweDA1LA0KPiA+ICAgICAgICAgTUNVX0VYVF9DTURfUE1fU1RBVEVfQ1RSTCA9IDB4
MDcsDQo+ID4gICAgICAgICBNQ1VfRVhUX0NNRF9DSEFOTkVMX1NXSVRDSCA9IDB4MDgsDQo+ID4g
ICAgICAgICBNQ1VfRVhUX0NNRF9TRVRfVFhfUE9XRVJfQ1RSTCA9IDB4MTEsDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYw0K
PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYw0KPiA+
IGluZGV4IGNhMzZkZTM0MTcxYi4uZWE2YTExM2I3YjM2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYw0KPiA+IEBAIC0y
NDIsNiArMjQyLDE1IEBAIGludCBfX210NzkyMV9zdGFydChzdHJ1Y3QgbXQ3OTJ4X3BoeSAqcGh5
KQ0KPiA+DQo+ID4gICAgICAgICBpZWVlODAyMTFfcXVldWVfZGVsYXllZF93b3JrKG1waHktPmh3
LCAmbXBoeS0+bWFjX3dvcmssDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE1UNzkyeF9XQVRDSERPR19USU1FKTsNCj4gPiArICAgICAgIGlmIChtdDc2X2lzX21taW8o
bXBoeS0+ZGV2KSkgew0KPiANCj4gSSBndWVzcyB0aGUgbGVkIGNvbnRyb2wgTUNVIGNvbW1hbmQg
aXMgbm90IGxpbWl0ZWQgdG8gUENJZSBkZXZpY2VzLA0KPiB0aGV5IHNob3VsZCBiZSBhYmxlIHRv
IGJlIGV4dGVuZGVkIGV2ZW4gb24gTVQ3OTIxIFVTQiBhbmQgU0RJTw0KPiBkZXZpY2VzLCByaWdo
dCA/IGlmIHNvLCBJIHRoaW5rIHdlIGNhbiBkcm9wIHRoZSBNTUlPIGxpbWl0YXRpb24NCj4gY29u
ZGl0aW9uIHRvIHN1cHBvcnQgbW9yZSBzY2VuYXJpb3MgYW5kIHRvIG1ha2UgaXQgZWFzaWVyIHRv
DQo+IHVuZGVyc3RhbmQuDQo+IA0KSGkgU2VhbiwNCg0KVGhpcyBzb2Z0d2FyZSBmbG93IGludm9s
dmVzIGNoaXAgR1BJTyBjb250cm9sIGFuZCBpcyByZWxhdGVkIHRvIHRoZQ0KbW9kdWxlJ3MgY2ly
Y3VpdCBkZXNpZ24uIE9ubHkgdGhlIFBDSWUgbW9kdWxlIGNhbiBwcm92aWRlIHN1cHBvcnQgZm9y
DQp0aGlzLCBzbyBjYW4ndCBkcm9wLg0KDQo+ID4gKyAgICAgICAgICAgICAgIGVyciA9IG10Nzky
MV9tY3VfcmFkaW9fbGVkX2N0cmwocGh5LT5kZXYsDQo+IEVYVF9DTURfUkFESU9fTEVEX0NUUkxf
RU5BQkxFKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGVycikNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgZXJyID0g
bXQ3OTIxX21jdV9yYWRpb19sZWRfY3RybChwaHktPmRldiwNCj4gRVhUX0NNRF9SQURJT19PTl9M
RUQpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoZXJyKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBlcnI7DQo+ID4gKyAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIHJldHVy
biAwOw0KPiA+ICB9DQo+ID4gQEAgLTI1OSw2ICsyNjgsMjIgQEAgc3RhdGljIGludCBtdDc5MjFf
c3RhcnQoc3RydWN0IGllZWU4MDIxMV9odw0KPiAqaHcpDQo+ID4gICAgICAgICByZXR1cm4gZXJy
Ow0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgbXQ3OTIxX3N0b3Aoc3RydWN0IGllZWU4
MDIxMV9odyAqaHcpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYg
PSBtdDc5MnhfaHdfZGV2KGh3KTsNCj4gPiArICAgICAgIGludCBlcnIgPSAwOw0KPiA+ICsNCj4g
PiArICAgICAgIGlmIChtdDc2X2lzX21taW8oJmRldi0+bXQ3NikpIHsNCj4gPiArICAgICAgICAg
ICAgICAgbXQ3OTJ4X211dGV4X2FjcXVpcmUoZGV2KTsNCj4gPiArICAgICAgICAgICAgICAgZXJy
ID0gbXQ3OTIxX21jdV9yYWRpb19sZWRfY3RybChkZXYsDQo+IEVYVF9DTURfUkFESU9fT0ZGX0xF
RCk7DQo+ID4gKyAgICAgICAgICAgICAgIG10NzkyeF9tdXRleF9yZWxlYXNlKGRldik7DQo+ID4g
KyAgICAgICAgICAgICAgIGlmIChlcnIpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIG10NzkyeF9zdG9wKGh3KTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludA0KPiA+ICBtdDc5MjFfYWRkX2ludGVyZmFj
ZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYNCj4gKnZpZikN
Cj4gPiAgew0KPiA+IEBAIC0xMzcyLDcgKzEzOTcsNyBAQCBzdGF0aWMgdm9pZCBtdDc5MjFfbWdk
X2NvbXBsZXRlX3R4KHN0cnVjdA0KPiBpZWVlODAyMTFfaHcgKmh3LA0KPiA+ICBjb25zdCBzdHJ1
Y3QgaWVlZTgwMjExX29wcyBtdDc5MjFfb3BzID0gew0KPiA+ICAgICAgICAgLnR4ID0gbXQ3OTJ4
X3R4LA0KPiA+ICAgICAgICAgLnN0YXJ0ID0gbXQ3OTIxX3N0YXJ0LA0KPiA+IC0gICAgICAgLnN0
b3AgPSBtdDc5Mnhfc3RvcCwNCj4gPiArICAgICAgIC5zdG9wID0gbXQ3OTIxX3N0b3AsDQo+ID4g
ICAgICAgICAuYWRkX2ludGVyZmFjZSA9IG10NzkyMV9hZGRfaW50ZXJmYWNlLA0KPiA+ICAgICAg
ICAgLnJlbW92ZV9pbnRlcmZhY2UgPSBtdDc5MnhfcmVtb3ZlX2ludGVyZmFjZSwNCj4gPiAgICAg
ICAgIC5jb25maWcgPSBtdDc5MjFfY29uZmlnLA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9tY3UuYw0KPiBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21jdS5jDQo+ID4gaW5kZXggOGI0Y2UzMmEyY2Qx
Li4yZWJmMGZmZTc4ZDUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MjEvbWN1LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkyMS9tY3UuYw0KPiA+IEBAIC02MDYsNiArNjA2LDIwIEBAIGludCBt
dDc5MjFfcnVuX2Zpcm13YXJlKHN0cnVjdCBtdDc5MnhfZGV2DQo+ICpkZXYpDQo+ID4gIH0NCj4g
PiAgRVhQT1JUX1NZTUJPTF9HUEwobXQ3OTIxX3J1bl9maXJtd2FyZSk7DQo+ID4NCj4gPiAraW50
IG10NzkyMV9tY3VfcmFkaW9fbGVkX2N0cmwoc3RydWN0IG10NzkyeF9kZXYgKmRldiwgdTggdmFs
dWUpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCB7DQo+ID4gKyAgICAgICAgICAgICAgIHU4
IGN0cmxpZDsNCj4gPiArICAgICAgICAgICAgICAgdTggcnN2WzNdOw0KPiA+ICsgICAgICAgfSBf
X3BhY2tlZCByZXEgPSB7DQo+ID4gKyAgICAgICAgICAgICAgIC5jdHJsaWQgPSB2YWx1ZSwNCj4g
PiArICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIG10NzZfbWN1X3NlbmRfbXNn
KCZkZXYtPm10NzYsDQo+IE1DVV9FWFRfQ01EKElEX1JBRElPX09OX09GRl9DVFJMKSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZyZXEsIHNpemVvZihyZXEpLCBmYWxzZSk7
DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwobXQ3OTIxX21jdV9yYWRpb19sZWRfY3Ry
bCk7DQo+ID4gKw0KPiA+ICBpbnQgbXQ3OTIxX21jdV9zZXRfdHgoc3RydWN0IG10NzkyeF9kZXYg
KmRldiwgc3RydWN0IGllZWU4MDIxMV92aWYNCj4gKnZpZikNCj4gPiAgew0KPiA+ICAgICAgICAg
c3RydWN0IG10NzkyeF92aWYgKm12aWYgPSAoc3RydWN0IG10NzkyeF92aWYgKil2aWYtDQo+ID5k
cnZfcHJpdjsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MjEvbXQ3OTIxLmgNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkyMS9tdDc5MjEuaA0KPiA+IGluZGV4IDMwMTY2MzZkMThjNi4uMDcwMjNlYjllNWI1
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTIxL210NzkyMS5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MjEvbXQ3OTIxLmgNCj4gPiBAQCAtMjcsNiArMjcsMTAgQEANCj4gPiAgI2RlZmluZSBN
Q1VfVU5JX0VWRU5UX1JPQyAgMHgyNw0KPiA+ICAjZGVmaW5lIE1DVV9VTklfRVZFTlRfQ0xDICAw
eDgwDQo+ID4NCj4gPiArI2RlZmluZSBFWFRfQ01EX1JBRElPX0xFRF9DVFJMX0VOQUJMRSAgIDB4
MQ0KPiA+ICsjZGVmaW5lIEVYVF9DTURfUkFESU9fT05fTEVEICAgICAgICAgICAgMHgyDQo+ID4g
KyNkZWZpbmUgRVhUX0NNRF9SQURJT19PRkZfTEVEICAgICAgICAgICAweDMNCj4gPiArDQo+ID4g
IGVudW0gew0KPiA+ICAgICAgICAgVU5JX1JPQ19BQ1FVSVJFLA0KPiA+ICAgICAgICAgVU5JX1JP
Q19BQk9SVCwNCj4gPiBAQCAtMTk2LDYgKzIwMCw3IEBAIGludCBtdDc5MjFfbWN1X2Z3X2xvZ18y
X2hvc3Qoc3RydWN0IG10NzkyeF9kZXYNCj4gKmRldiwgdTggY3RybCk7DQo+ID4gIHZvaWQgbXQ3
OTIxX21jdV9yeF9ldmVudChzdHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZg0K
PiAqc2tiKTsNCj4gPiAgaW50IG10NzkyMV9tY3Vfc2V0X3J4ZmlsdGVyKHN0cnVjdCBtdDc5Mnhf
ZGV2ICpkZXYsIHUzMiBmaWYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4IGJp
dF9vcCwgdTMyIGJpdF9tYXApOw0KPiA+ICtpbnQgbXQ3OTIxX21jdV9yYWRpb19sZWRfY3RybChz
dHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2LCB1OCB2YWx1ZSk7DQo+ID4NCj4gPiAgc3RhdGljIGlubGlu
ZSB1MzINCj4gPiAgbXQ3OTIxX3JlZ19tYXBfbDEoc3RydWN0IG10NzkyeF9kZXYgKmRldiwgdTMy
IGFkZHIpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTIxL3BjaS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5MjEvcGNpLmMNCj4gPiBpbmRleCAwYjY5YjIyNWJjMTYuLmY3NjhlOTM4OWFjNiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2ku
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL3Bj
aS5jDQo+ID4gQEAgLTQyNyw2ICs0MjcsMTAgQEAgc3RhdGljIGludCBtdDc5MjFfcGNpX3N1c3Bl
bmQoc3RydWN0IGRldmljZQ0KPiAqZGV2aWNlKQ0KPiA+ICAgICAgICAgd2FpdF9ldmVudF90aW1l
b3V0KGRldi0+d2FpdCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAhZGV2LT5yZWdk
X2luX3Byb2dyZXNzLCA1ICogSFopOw0KPiA+DQo+ID4gKyAgICAgICBlcnIgPSBtdDc5MjFfbWN1
X3JhZGlvX2xlZF9jdHJsKGRldiwNCj4gRVhUX0NNRF9SQURJT19PRkZfTEVEKTsNCj4gPiArICAg
ICAgIGlmIChlcnIgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIHJlc3RvcmVfc3VzcGVu
ZDsNCj4gPiArDQo+ID4gICAgICAgICBlcnIgPSBtdDc2X2Nvbm5hY19tY3Vfc2V0X2hpZl9zdXNw
ZW5kKG1kZXYsIHRydWUpOw0KPiA+ICAgICAgICAgaWYgKGVycikNCj4gPiAgICAgICAgICAgICAg
ICAgZ290byByZXN0b3JlX3N1c3BlbmQ7DQo+ID4gQEAgLTUyNSw5ICs1MjksMTEgQEAgc3RhdGlj
IGludCBtdDc5MjFfcGNpX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlDQo+ICpkZXZpY2UpDQo+ID4gICAg
ICAgICAgICAgICAgIG10NzZfY29ubmFjX21jdV9zZXRfZGVlcF9zbGVlcCgmZGV2LT5tdDc2LCBm
YWxzZSk7DQo+ID4NCj4gPiAgICAgICAgIGVyciA9IG10NzZfY29ubmFjX21jdV9zZXRfaGlmX3N1
c3BlbmQobWRldiwgZmFsc2UpOw0KPiA+ICsgICAgICAgaWYgKGVyciA8IDApDQo+ID4gKyAgICAg
ICAgICAgICAgIGdvdG8gZmFpbGVkOw0KPiA+DQo+ID4gICAgICAgICBtdDc5MjFfcmVnZF91cGRh
dGUoZGV2KTsNCj4gPiAtDQo+ID4gKyAgICAgICBlcnIgPSBtdDc5MjFfbWN1X3JhZGlvX2xlZF9j
dHJsKGRldiwgRVhUX0NNRF9SQURJT19PTl9MRUQpOw0KPiA+ICBmYWlsZWQ6DQo+ID4gICAgICAg
ICBwbS0+c3VzcGVuZGVkID0gZmFsc2U7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+DQo+
ID4NCg==

