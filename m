Return-Path: <linux-wireless+bounces-37798-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gPHYL3RkL2qi/gQAu9opvQ
	(envelope-from <linux-wireless+bounces-37798-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 04:33:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B96682E23
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 04:33:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=VyhirQ0L;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.s=selector2-mediateko365-onmicrosoft-com header.b=OfukeT0q;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37798-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37798-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CE8B30010F1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 02:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556DC238D54;
	Mon, 15 Jun 2026 02:33:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA853405F7
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 02:33:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490802; cv=fail; b=fJeDMp52ECwGewzAvyYaCGFy37oux/kWHwKH/WlrtHsHNNIqgmLOEJAtPTubGm1LKtz1CHH2p1Mb2k7JRVvTfmrbADIbYiOlDHsnLC48O8taN/irgrhaQKtKOWCD1ApauyGrzG5EpbVXZLWzZmaVhMAbimmVRNl6RVdUXIT1p/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490802; c=relaxed/simple;
	bh=j7jZregFawHrBVbW9GOB+0q5Uh+hR7U5+UfIn4XB4HU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qGmb0vtgMQ7rqN3WVXgotC8K9oCSdPPslyr6oW7bu25UtCHuB2uB+hduz6svYzINDAZdPhMtU/XpbsFSmipKIUi1ZVEVkTspuUu3/ZOJrYkdESlA1VqWdInBJVlVzGpSMlVRpmiYzBrGssH0QOimZi30FwJ+nKwnXIBEcKcGjCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VyhirQ0L; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=OfukeT0q; arc=fail smtp.client-ip=60.244.123.138
X-UUID: 7112fae8686011f1b1788b6acf885367-20260615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=j7jZregFawHrBVbW9GOB+0q5Uh+hR7U5+UfIn4XB4HU=;
	b=VyhirQ0L1iluiyX8hHDmx8h0ICpMuJUA5vZiw7sIYAOShPkyU3sPTY6iSSBv5x8272qVikS80jAsEb0eXS7xeYWfUm8xl99czmKx47B2HuPgZ31Ub+0eTHOAxBUyykSn0/5ZzQjXdj+Fl/rmSUw+CNBclyYKxCftGD1ehn/CwY0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:25f1d778-ed4e-4d2f-bc81-e3bfd4951d02,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:f8a59a0c-b93f-491b-8cec-c0f70e8205c2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7112fae8686011f1b1788b6acf885367-20260615
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 178516280; Mon, 15 Jun 2026 10:18:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Jun 2026 10:18:03 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Jun 2026 10:18:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqKm8K2C8EkzfmD2eXOImVKLT9/u8a2h3hOj2hmBXZyGdiYNV7iLsNxLDNNTmsZl9UYp6MDobEsOy+ERSpObatDkhhV1xuSq1zzfq0BJz5Ij4BBeNccmgdxX2xU0uw8NXxUdqp0YCbLkKpfqaBOUt3qnSnUkG4SUOKz3lBMy6UYU0GDrq2oM0qXhouymhEc0o/kYOR/Dk+LDVz75kuRainKG3tZX69IEVneiwQ9UinNrLb7fo/6DBNCBenv8ju2Ek/m5i3rcFx8RPeAUS7W2MJgbkiW/2UhrvtpwrNo5zyigVj2GjIsiuj4zdoKr7i+RsHv0YMfmqhhGxgHX2ZmxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7jZregFawHrBVbW9GOB+0q5Uh+hR7U5+UfIn4XB4HU=;
 b=BOaiK8yXJAb4zN3dwsNh5/3B0K0iXujA1ZfVVAequpgLzbDSTzr5eBMmx3l9APVI9uEJ6zRF3l7DaxQ5IdItr0CJ7mU0aEBZic7Vg4I0oMd7rVsRZAjQsKj0nBQ5pO5dTzrY9NmmNUqq3eCf7mAEFwi56y15Zh5mA6xHoamUYRh32Q9TT98SD7VBVEB6cLOyy82qD2xgWMywWrQhbA7s9/EPJQUvpPXt1KhJLJ3YVEXt3v6/GWW/eeMP4J58OTbpbcY4dIj4exbTDJ5Wbo3tTZSl/9aobGE6T7qmP9jF9/VFvbN3ZSMQ2PQJWAPE8DmvwsKo7v54YGaN5qUIxPdRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7jZregFawHrBVbW9GOB+0q5Uh+hR7U5+UfIn4XB4HU=;
 b=OfukeT0qLeTrbEpiA6gjPjO3g/PXwNRpzwL5eOWMqZUZMsAwbyXpO879dH8vGiscd2f/qQX+l07FPVgCs5j/cYCmjzwRH9iQTHtVqnZ53Kpx2NSplxj3AszogZu6vnIyKd0EsHlpfRqWNr7sWyUYfeQsV3IwoPjNC4/TlaXurtY=
Received: from KL1PR03MB7079.apcprd03.prod.outlook.com (2603:1096:820:d5::5)
 by TYZPR03MB8213.apcprd03.prod.outlook.com (2603:1096:405:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 15 Jun
 2026 02:17:59 +0000
Received: from KL1PR03MB7079.apcprd03.prod.outlook.com
 ([fe80::9bd3:f66a:efd4:f6af]) by KL1PR03MB7079.apcprd03.prod.outlook.com
 ([fe80::9bd3:f66a:efd4:f6af%4]) with mapi id 15.21.0139.009; Mon, 15 Jun 2026
 02:17:59 +0000
From: =?utf-8?B?RWFzb24gTGFpICjos7TmmJPogZYp?= <Eason.Lai@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, =?utf-8?B?SkIgVHNhaSAo6JSh5b+X5b2sKQ==?=
	<Jb.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?=
	<Quan.Zhou@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
	=?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
	=?utf-8?B?TGl0aWVuIENoYW5nICjlvLXnq4vlhbgp?= <Litien.Chang@mediatek.com>
Subject: RE: [PATCH v3] wifi: mt76: mt792x: fix use-after-free in
 mt76_rx_poll_complete
Thread-Topic: [PATCH v3] wifi: mt76: mt792x: fix use-after-free in
 mt76_rx_poll_complete
Thread-Index: AQHc8be4PVmABwIGy02LX+dhg/7XZ7Y+9LcA
Date: Mon, 15 Jun 2026 02:17:59 +0000
Message-ID: <KL1PR03MB7079CDD6006DA83B2E0DD32D97E62@KL1PR03MB7079.apcprd03.prod.outlook.com>
References: <20260506084315.3143553-1-jb.tsai@mediatek.com>
 <8430bab4-a064-4f58-81d8-c8801d17f89a@nbd.name>
In-Reply-To: <8430bab4-a064-4f58-81d8-c8801d17f89a@nbd.name>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7079:EE_|TYZPR03MB8213:EE_
x-ms-office365-filtering-correlation-id: 08eb52c5-426a-4766-6038-08deca845200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|18002099003|22082099003|6133799003|11063799006|5023799004|4143699003|56012099006;
x-microsoft-antispam-message-info: r+fE7yHon+sydE6dRAX4zt3mckmqZd27eefCVoaQNlqWjI0ly8WU52+GnhRSosCWdZOLrPerGkVRQqnhaY2LVkK1c+vqtGN3PNbjgbwmDquBeISH7+5uNLf2ZJSmolFqvqVJLJAzk+BzsuTq0K5hHJGZwcfCYhMzWSMcCPf+CE6n5qv8XbiBTGccNxtsOBieLYvTeCNpEvH4Lf3swKy36Rqsk5NNSAemxue/zh9cCI/JO/73vWJ8rA9gCMEQtLr36VKPRw9Ua9e5M086wJRXACXAidLasYwnLwexu/5kMIc0NUVHbigKkalffNcWqG9vc6pxcv5yY45Nx2EeDRGKqeKzh4TD93CUHiBUsOlp0w5HqdSXuvt0OWkCY9EHo07TVGFzOAe/xF43LBva9ZiaHaJa/JX2gMoKNJnUL1RG9pjKF3sLN6IlCGqZjYUtCKfg79hqN0E45tVbsUttonzZLbZqHXUWX5Wxoxl0617G45fudvYUhij3usVcog07jxLs5Q7MFKAZQJNpLUppVGGptzteW7ntxBjDtrkuFC4iH89ALG3Futj+MU3ZOSpELJLb7lwGJLVFs2yih7j4p8rMSOkwr4nh8uzHam4G3ktI4CS/Ej+GrbJ73ZgHKqzvDZsmx0R585Y+oewYGSyXJPszH6beT7FcKUSb+iDOhq6D7yHhKUdTb9ustwTcb/fB1ZbBgnweRlFBewpOeEN4YgC6YC5w62oduag9SifRD1xFNaFOLbdb15n9FrznQarKsMfA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7079.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(6133799003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1VEa3JDK2VaekdOM0FEM3crWkEwaGpYdVJyVGZ4V2lLaGtzUk15U2JmeFls?=
 =?utf-8?B?ZTVwR05FZlNOc0pNQ3doVGVXa3JwNTN2bWNKT2lnK3hydXZSd1E2cTRVRGdr?=
 =?utf-8?B?OUNha3dFY1U4czc1UU9PYXcwMFU2em9uWGVDbUg4aEg5UHlIaCt6ODJrQVVY?=
 =?utf-8?B?T29GSGNRWGd4WEZTd0ZHUndrdjA1U2dCTmtWdGw0dUlnUXh6blA1VXZCRWly?=
 =?utf-8?B?Y2ZOTlQzK1ZFYTFGbmY5ZWVMWDRsTFhPOFZFRlplQk1FQjkwcnphOVcxUWZF?=
 =?utf-8?B?bGR1bEhLbUdwQ3VoWS9JVnBsVk94L0M1N2lhenlMR1UyZE1abjBqMTFqOTRi?=
 =?utf-8?B?dURJQmY0aWp1cGhrRlhyUmhNTzQ4cGhaMVlDelVHVnB5QW4yWnJRNHBpNkN0?=
 =?utf-8?B?ZHBjb1ZYaXF1endIOUlzMVdLRHFIREx0OVFhMXJPeHNkb1RGakpYVmhLMk15?=
 =?utf-8?B?Qit0NWxodzdtbzVPOVNHazExNnNKcE5iVU5jQ0krSW5QQ1VaMHpjMHIva0lB?=
 =?utf-8?B?UG5Xbys3U2VLNUFvOUkrOTQ5YjdYTzE5QlRldHdqbzBDeTBmalFlNWdhb1kv?=
 =?utf-8?B?L3FDNzBqQlRvYmpKaVl3V21qTjg5NmU2NDVaM0t5Q2xraU91R1VvT0lidzlz?=
 =?utf-8?B?ZjJqUHU0Z3FJZzV2aHZCam1TSE9obWpiWEc4MjBxT241NGZiZ3M1Ri9SRVdj?=
 =?utf-8?B?OTduRURJZ2ExQmdDS3k0ZWtFRmV3Y3lhVTBYblRONm5jMzQ0cUhNWnBYbW5s?=
 =?utf-8?B?L3pwaTJHa3BLeGV4YWJJWklKaHBRKzFQN2VGb1ZBWWt3anl3VGxyRGVTVmpa?=
 =?utf-8?B?REEyZEZBNmIvQkh2dEd3OWdMTFN4Q2FOT3VyVHZKREE3SlRvNHNQTjZzQlZx?=
 =?utf-8?B?RlVyY1pzcnVDdEJvRFVzUmU2dWw5ZG9XQmxzL2NRMGZiOVFVckVBZmdWWkVR?=
 =?utf-8?B?YzRCa3F2VHpvSTVkdGVFMW15YkhyM2JVTXdxdjgzRmxkNnlWY0xPbktHMnU5?=
 =?utf-8?B?VGVrVGxUaWhPdklKS2Nib0RCTG9mR0FsQU1tMDdkaTVERm9maVZVbVhlZG9h?=
 =?utf-8?B?UjVSaW84MXlPUmFISGIveGwzOXpjVHpxb2w2VGk2cDVSNXdId2pybDdQcW5k?=
 =?utf-8?B?cFV4ZXEwSUVWVWE5UEhKV2xyaUNJUytNQ05kTnhpcnVJYnpPUzB1VHVFWldG?=
 =?utf-8?B?enBKSlMydjI0SEMxUWtobzNOdkx0YWNtMDJTWU01bjhOZFpUQlowcWNwdVJp?=
 =?utf-8?B?S2dDMmZ4VXcvcktFU1pLSkIyZTN1WWpTcGxIM0F5OXVrSFIxaldwYmIwU3ZI?=
 =?utf-8?B?bVkrRHNxNXBXMWQxSmRiUkhpdzZtR0liVmFzNG51NWRnb3RQQjR1N2lva1FH?=
 =?utf-8?B?QXd2M3YrU0FCTUtuUkE0VytLM2F0QmU0OVFHcXVGL05ZL1Q2MjZGaStzRmta?=
 =?utf-8?B?NFhMS0dtUGh6WmR2ZFFJb2tWVVg2R1J0alBJQ3ExOFZSL3Nnd1VMTFZMSVdZ?=
 =?utf-8?B?aldHWWlRUjRwWGx1UldaR0xKY2JPSTNDT2lqUHE3UkZ2c0oxUFJzUDV4N2E2?=
 =?utf-8?B?eDhyQm5BT1BsMytiWW81K0VOYmd2USs0ZlNBS0pwMlQyS3JrNS80MVR5S3o0?=
 =?utf-8?B?eXdtekJXTEFRMjZPOFpOblBFS2RQYnhPUHpHNGlycUZuU0ViZ2ZRWlMvR1lQ?=
 =?utf-8?B?N2FHQ2I1b0Flc0RLVDhUT1o0L2pTWHl3VEpFejcwcWlLSW9zd29CTXUxRW9h?=
 =?utf-8?B?Z1htUTh2RUtOeG91dElxc3ZjMHdXZzk5SlFkcTRNejRnWXhZdnlBaG1KUWZO?=
 =?utf-8?B?NnNqMDAzTzdlSzVCN3BKaDk5c2J5UTRrc2FoSG41U251Q05CVW5WV3JITFpD?=
 =?utf-8?B?dCtzeTR4cmx5Yzh5SHBWOWs1TG9RVUx6TEY5Q1kvYkZsWHpCZkJ3SGpUaDh3?=
 =?utf-8?B?WU90REJKMEJxUWlubnFVZVdESU41Z0tzQVVhalc4RFdPNGV5VjVhVzBEd1Fa?=
 =?utf-8?B?bkppS2kwTmxuK1p5YkJHUHdRZEYwaE5HZVZiSTlPMkpVbWVDZDNRZ1RXZkt6?=
 =?utf-8?B?NVNIV1NtYW9MckMxS2pwZ3dwV0hxNXNoSDQ4bUc5YjVWSkhBeVBFdzJKSFJQ?=
 =?utf-8?B?Vy9ra09TazF4bm9DUW1NU3NlTXhwSnQ0TUJOTkM1SGVXZFhqeHltTDlUdkFL?=
 =?utf-8?B?Y2lwYjN3bGlGem1WZE5HWUR4SVZKZTZHbGh2RVlabjJMZkU5VlJoWXJvMUx5?=
 =?utf-8?B?czRHek1qY3hPeWtYSlpjb0hvVmRpeDllTG9sa1pFOXV3ZnNYTG10Tk0rRlBq?=
 =?utf-8?B?R2pZU3FEN25WVjlWM2xHUFpaRkJreW5TRWUrZENZNFg5bWVlbThQZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RNYwzWBK2ndMMiiVjKMtMVqzzOkxSXB4b7wMXex2mR9jo/i+X4RVfPTPcIBlqO9FSBQOClfoN8sIge9olgiaQb7BtuoRW+6yG4Z01p5TFgzGWtofmqzY5xtDFLz47uZ6Utsi+dXXuaM+sFExgd59j2cmAm0kMdjOC30waPplLKU1+EFMPHitCz2sr4iIOjFB2UFFv2/hwNv3fk28be/ONEpqN5+DevTo20GTxVas3K8wkEYOi5pFgTDkwuykWqRePr1RwFSkoC+Da28Qlrud/0GAINARf/Q3w5E+2FuKL6fDbUth4YYDXBmLHWGAWeYiLZA/gwWLD+0Qa2CRlP3eYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7079.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08eb52c5-426a-4766-6038-08deca845200
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 02:17:59.2901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYQZdc754F7N/Ql+VMwUiZdYRpfrhlBYWg9euO+/S+iA9Y5TvsuGlHLYI9MvWA+ZtpMzfYz23txLMLeOd+Efrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8213
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37798-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:Jb.Tsai@mediatek.com,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:Litien.Chang@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Eason.Lai@mediatek.com,linux-wireless@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email,nbd.name:email,mediatek.com:dkim,mediatek.com:email,mediatek.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Eason.Lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2B96682E23

QWZ0ZXIgbG9va2luZyBpbnRvIHRoZSBtYWM4MDIxMSBTVEEgcmVtb3ZhbCBmbG93LCBJIGRpZG4n
dCBub3RpY2UgdGhhdCBzeW5jaHJvbml6ZV9uZXQoKSBpcyBpbnZva2VkIGFmdGVyIG10NzZfc3Rh
X3ByZV9yY3VfcmVtb3ZlKCkuDQpZb3UgYXJlIHJpZ2h0LiBJIHdpbGwgY2hlY2sgbXQ3OTI1X2No
YW5nZV92aWZfbGlua3MoKS4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCg0KQmVzdCByZWdh
cmRzLA0KRWFzb24NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEZlbGl4IEZp
ZXRrYXUgPG5iZEBuYmQubmFtZT4gDQpTZW50OiBNb25kYXksIEp1bmUgMSwgMjAyNiA3OjEzIFBN
DQpUbzogSkIgVHNhaSAo6JSh5b+X5b2sKSA8SmIuVHNhaUBtZWRpYXRlay5jb20+OyBsb3Jlbnpv
QGtlcm5lbC5vcmcNCkNjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1l
ZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7IERlcmVuIFd1ICjmrablvrfku4EpIDxEZXJlbi5X
dUBtZWRpYXRlay5jb20+OyBTZWFuIFdhbmcgPFNlYW4uV2FuZ0BtZWRpYXRlay5jb20+OyBRdWFu
IFpob3UgKOWRqOWFqCkgPFF1YW4uWmhvdUBtZWRpYXRlay5jb20+OyBSeWRlciBMZWUgPFJ5ZGVy
LkxlZUBtZWRpYXRlay5jb20+OyBMZW9uIFllbiAo6aGP6Imv5YSSKSA8TGVvbi5ZZW5AbWVkaWF0
ZWsuY29tPjsgTGl0aWVuIENoYW5nICjlvLXnq4vlhbgpIDxMaXRpZW4uQ2hhbmdAbWVkaWF0ZWsu
Y29tPjsgRWFzb24gTGFpICjos7TmmJPogZYpIDxFYXNvbi5MYWlAbWVkaWF0ZWsuY29tPg0KU3Vi
amVjdDogUmU6IFtQQVRDSCB2M10gd2lmaTogbXQ3NjogbXQ3OTJ4OiBmaXggdXNlLWFmdGVyLWZy
ZWUgaW4gbXQ3Nl9yeF9wb2xsX2NvbXBsZXRlDQoNCk9uIDA2LjA1LjI2IDEwOjQzLCBKQiBUc2Fp
IHdyb3RlOg0KPiBGcm9tOiBFYXNvbiBMYWkgPEVhc29uLkxhaUBtZWRpYXRlay5jb20+DQo+IA0K
PiBBIHVzZS1hZnRlci1mcmVlIGlzc3VlIG9jY3VycyBpbiBtdDc2X3J4X3BvbGxfY29tcGxldGUg
ZHVlIHRvIGEgcmFjZSANCj4gY29uZGl0aW9uLiBUaGUgU1RBIGhhcyBhbHJlYWR5IGJlZW4gcmVt
b3ZlZCwgYnV0IHRoZSByeF9zdGF0dXMgc3RpbGwgDQo+IGhhZCBhIHBvaW50ZXIgdG8gdGhlIHdj
aWQgaW4gdGhlIFNUQS4NCj4gDQo+IFVzZSB3Y2lkX2lkeCBpbnN0ZWFkIG9mIHN0b3JpbmcgdGhl
IHdjaWQgcG9pbnRlciwgYW5kIGxvb2sgdXAgdGhlIHdjaWQgDQo+IHZpYSByY3VfZGVyZWZlcmVu
Y2UoKSBieSB3Y2lkX2lkeC4NClVubGVzcyBJJ20gbWlzcmVhZGluZyBzb21ldGhpbmcsIGl0IHNl
ZW1zIHRvIG1lIHRoYXQgdGhpcyBwYXRjaCBwYXBlcnMgb3ZlciBhIGRpZmZlcmVudCBidWcgaW5z
dGVhZCBvZiBmaXhpbmcgdGhlIHJvb3QgY2F1c2UuDQpSaWdodCBub3cgdGhlIHJ4IHByb2Nlc3Np
bmcgY29kZSByZWxpZXMgb24gUkNVIHRvIHByb3RlY3QgdGhlIHdjaWQgYW5kIHN0YSBkYXRhIHN0
cnVjdHVyZXMuDQpUaGUgcmN1IGxvY2svdW5sb2NrIGFyb3VuZCBwb2xsaW5nIGFsc28gc2VlbXMg
Y29ycmVjdCB0byBtZS4NCg0KQXJlIHRoZSBmcmVlZCB3Y2lkIHBvaW50ZXJzIG1heWJlIHJlbGF0
ZWQgdG8gYSB2aWYgc3RhIGluc3RlYWQgb2YgYW4gYWN0dWFsIHN0YXRpb24/IFRoZSB1c2Ugb2Yg
ZGV2bV9rZnJlZSBpbiBtdDc5MjVfY2hhbmdlX3ZpZl9saW5rcyBsb29rcyBzdXNwaWNpb3VzIHRv
IG1lLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUu
DQoNCi0gRmVsaXgNCg==

