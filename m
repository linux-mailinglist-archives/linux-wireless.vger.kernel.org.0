Return-Path: <linux-wireless+bounces-4531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5EC877ADE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 07:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FA3281553
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 06:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3600DC8FF;
	Mon, 11 Mar 2024 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OlSpD8kc";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HjkOgONV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4DC8E2
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710138048; cv=fail; b=hm+jcuQmpRNfqwJWzo4MHrV+8PF4XhUEm6YuXTv77SnbHCWZYfIuOrwg3Y4VK4uJ+DG0a18KMTpj7ymuzY0z+LXB3Ycl0CfAtA4oD4gfghygHiSPQy+sTc0FKq0dXl+GJm1Ht8fwC6lFhnHdooYvYN29Ab3vrw7A3PxRj2kbbIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710138048; c=relaxed/simple;
	bh=HxEase9HatBCCZaDLDQGVbunGl6XvlFXQaxHM4nw+84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lcDV8vGktf1F6BDPo4h0O/Wu0bW9ZfWqi+RqI+Vywz/ylXwHcTkPPqhqCVlwfpKuHyd0s/zJYZSAJBEiUWL+aoWeCZPdeixIDMuZTIUP/o094zPI3sihLsoaZtfAUunTI/kc0s+7O+1GqBeojtfITURQWi+M5XrRZU84DlR0woA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OlSpD8kc; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HjkOgONV; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 775410f8df6f11ee935d6952f98a51a9-20240311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HxEase9HatBCCZaDLDQGVbunGl6XvlFXQaxHM4nw+84=;
	b=OlSpD8kcfwtaCSoTMPEcG4a1jy2uhCrQeGzwzsjl/NcfyH9U2D3D1m1sfYMDQ2EiWDT55hUrDvxlDHf9pcfHOiVSCzG7hIqMh1UgJieEv1pcEIujCLKO433KHHk5gE/SDcH7rBfvhz4VUXzitj1+58UO2vzsXSeMAN6Vq6F7INo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2a8a5f7e-a07f-473e-87f0-3ea8140cd15b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c1735981-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 775410f8df6f11ee935d6952f98a51a9-20240311
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 142620733; Mon, 11 Mar 2024 14:20:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Mar 2024 14:20:31 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Mar 2024 14:20:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bd5/lRJTgt6AMhxoof6b0HpUJBKEEzX7AAfNrgR7a2SBgKeNe2oidX2u4+VRi1CGvo3oS7gYo3FCdqns8Bw5Ib/ApUkFJHr3ymKILP9R70CxbY/Iknkp7WwNyOuhglIJQYfyEj3WgVg4gz5IvX0RdX1pD+EbySLGquwacEyB7QYbU0B6fCn03Vbaq6SgqJLt+5sR2r3PVl4GMjkhu7CgHHdhmy/bMS3bBybLyXz8nJ3OwB7AXfqV23k8yMo/6Mp7rFQ2ikEpMr6Nf+NQwlA5OzeAWwNSWA2Te95qsl+hPoLPfEpmNZX7r4nQIhzNtdvPduM13dpvOBsz2/zqT/9Dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxEase9HatBCCZaDLDQGVbunGl6XvlFXQaxHM4nw+84=;
 b=ewSZ8jwVcoJnGjibmlqzEWKa7/s9k2RPRQrJuaWDJXlJanclMBOMCF3N7rVwwkTJVH5DGNWbb5NmpC+j1sqm/Qb8qTu+m7Lb7nXKrmJdGxnziPSx0LgtiYDbSRP5EH6mzfqroUlmECSdlzLdAbpipJ9APX2MQjcvnWVzhAp0i+6RwxHqY8D6Ee0TkGYtyud9vSomrF/MyKR/Q8r8b6szgfd9tEzkpAh073JOD7jeZf1do7Jk+JKcxBVq3S+muTgKCQoiXysbk9XXd47uxRhW8NYM7/hr30YoZXQKwRXPNl5ynEbrWm5wZnG/G2Zm0eAWKjrm+O2boyTikjff3UW1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxEase9HatBCCZaDLDQGVbunGl6XvlFXQaxHM4nw+84=;
 b=HjkOgONVPGJjtCKt880PdmS+IplHjnf13yyTUqknfkAccZU1uGy/Ejqr5uknFPGp83T7is2osi8JgM32+9R1rd3n0Xu6t1W1FkxUB3Dx9gCP1qvlCBdWQ/l/j1XREp9CMeLVM399IEPtX0nJCTvwK/2yC0V9zjJlPVnU7cuDrpA=
Received: from SI2PR03MB5514.apcprd03.prod.outlook.com (2603:1096:4:125::6) by
 TYZPR03MB7409.apcprd03.prod.outlook.com (2603:1096:400:41e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.33; Mon, 11 Mar 2024 06:20:28 +0000
Received: from SI2PR03MB5514.apcprd03.prod.outlook.com
 ([fe80::2dd0:bff8:d546:5992]) by SI2PR03MB5514.apcprd03.prod.outlook.com
 ([fe80::2dd0:bff8:d546:5992%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 06:20:28 +0000
From: =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?=
	<Michael-cy.Lee@mediatek.com>
To: "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>, "pkshih@realtek.com"
	<pkshih@realtek.com>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"ilan.peer@intel.com" <ilan.peer@intel.com>, "arend.vanspriel@broadcom.com"
	<arend.vanspriel@broadcom.com>, Ryder Lee <Ryder.Lee@mediatek.com>, "j@w1.fi"
	<j@w1.fi>, "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"nbd@openwrt.org" <nbd@openwrt.org>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Thread-Topic: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Thread-Index: AQHac3YVJzJXeXFtLUSP+KW74/Kg/LEyEX6A
Date: Mon, 11 Mar 2024 06:20:28 +0000
Message-ID: <a2a7ace267a309930882d3e6bcf58fa41d07d658.camel@mediatek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
	 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
	 <5a89e63fb7644d12be72154c90c96199@realtek.com>
	 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
In-Reply-To: <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5514:EE_|TYZPR03MB7409:EE_
x-ms-office365-filtering-correlation-id: 6fb7c357-c684-4434-7c68-08dc419358c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgCdKT+QFTL3ycszlxdo3nAH+SV989NY/pwC7iMoxEpxGzFGxfYVfEoKSmVZPIUZc4/YTN4WVjmeKrzXV0YtbEOWft65j4CZuz6Jy578mSkXegJ9TtW9/9X41Rp8kfr9cSf+5l4QaSkvNdltiwJhkxDOiWc+Vvcb553KO5/ZtoykYLiP/EvJv0mufMpv17LLvpAIlMh6ztz6sF74juLPn8DPoZJjsrw69j+PcEfgvPPKX4GIG6Vh1RbSqHavZhazGPL5XAu/80HguTg4z/oWd9EdQtnOeSXfA991oY9JqmZQ2wpE/WDg4SrAkddALxWXkg6tQ1MbkJazQkjSYKb6/zUMsi0Gsp26NOy9mujp7Oj47GMrtnwCwfjdYGgjZITdt2lK0dtH6AyPX5OJpoWypfK8I02gf6KI5eaRu4mMml5CxGYL6u9BfqNZxFW4eWDYIaDDoL10Pfywi2L8+i/nxgY96YiQpyGwetpjNqGjqkEyQQEzmbdGSVJXkLb9h+DNMwFt+yZJymsphrc4e5eF+Fc0wLi96rwMkNs6yIogbltzRQodE2/Z9S8htHpcwuXotl8KSj/qcwFe//XC6ni4WRoRau/lmNVu6tpUkDw8YJKww83MgMltUuIh/A8a1IrlmiLrdaqNrEMhltfS/56C6RGNpiYvMzFNZlRWhATRsBnkyRZvAHDojahtXCjSxkQeIHwm0qK1aWYh/4hD2sL0vOZLaHoYN1vB/H6UW9GHE+M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5514.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmRGLzdxcldvWERER0tJclNrQkNuU3hud3d1QnNOTHNhR2V3RmZhbjFncyt3?=
 =?utf-8?B?Q3BlL01yZGV6YnNCbVVQT1hiWEh2SHNSeEs1clN4TFhvd1phKy9CR2FWMUU2?=
 =?utf-8?B?Wk9majMyK3NkWnI3SUZkQVNqM0N3ZWpOcUZZNVNFd3ZpbjNnS2lPM0FWSkUx?=
 =?utf-8?B?TjRTRnVVZVdrWk15bVIvTUQ1ZytuaFA1YTM5eHZ1M09DUkNSTFhJV2xLVWl5?=
 =?utf-8?B?UlFRZ2taRjlaai9RUzFjS0pqTFJPZUdnZkdPc1pJcmNMWitlNFVHMWpuZlBt?=
 =?utf-8?B?b29PcUNkTFBjSjc0TGZPcENtQTUzMndrUHdManM0dWQzZmlaVEJwbnB1SkdQ?=
 =?utf-8?B?WFJZc3l0bjNYZktTS0czWVV3TEY3T2psR3FUNlk2cXVuUlJkbnBOS0pMTWVV?=
 =?utf-8?B?ZmlUUExBaW5kREI5NVNLZXllZ3g1Q1V5ZmQyaHp4dko1cjJYM0VlOElNb1pv?=
 =?utf-8?B?VGo2eTBXd1I0R1JKS1Rpc3dpalB2TkdqOGw3dTJjckV2MEk0WE03SzVOWm1O?=
 =?utf-8?B?d2xudGxvV2d6bk0ycUdrbTBrVWhxcnJOZUZ4Rk1PYzhQVU9QKzFYZ1c1YVVT?=
 =?utf-8?B?SUhrSnNHdXRKdHVRZzVKcWRDdStsaUNaZEs5VjZjbml0aFcwVVIyNy9tMlNo?=
 =?utf-8?B?N20zSTNyaVVHaEhwemdRRmVXQ2x1S3ZXTEgzdFVMenJFTTBHb2FYcVBqbTBy?=
 =?utf-8?B?dy9lUzk4KzlacHJ0MTFLNkFqUXN5c1c1VlZUeDVpV3pjLzFKbmpHb2hxL0lK?=
 =?utf-8?B?SkYxdE9BeWREakZhOHdTTjNuejhEcjRnQytjampCQ0ZFSERlZTc5TE9kcTFX?=
 =?utf-8?B?VmkrVTYxUUtDRTNnTGliUjRJMkQ1VHNWblE2eFdXb284Z0VDMy95UWlPRmJU?=
 =?utf-8?B?RkQ3SHhaUEh1RU5aRzFhV1NWZ3pmSURTdTVncmgxdW5TbkJoZmtQaE1XWFpk?=
 =?utf-8?B?L3lvbTdqQ0xrMXJQWUpuYkJ4c1lqTlhOeG1hTk9TbGgyUC9aWTJPZWJuS00w?=
 =?utf-8?B?SzdKczNVQ053cUhpbDU4V1h5bGJEeHVoSWZ5WmZGcHR5bjIzT2wyOThSSlB1?=
 =?utf-8?B?VitHNzErWHAwT3hLeHZ5SG43dFIybTZXMU10c0IvVnhlRDZ6bElVQ3JjMXJV?=
 =?utf-8?B?QWhVL1FjZFR2VmtMMWpsdUZmbnVOTzgvREdQSGVEY3lCQU4wSVlwbU50WnRS?=
 =?utf-8?B?YVRZd1hWdStTUmxRVFBMVklDUzRuMnB0MkVpbkdzdmxjK2NoZEQ1T1V6SjJM?=
 =?utf-8?B?d21MbXBsK2QxQ2k0NDFCOHRQWjkrQTB0NFlreGpyY1l3L3QxNVIzV3lBcGZy?=
 =?utf-8?B?NGtIWVRuejdLYnBkcUlHZVREUHFDbWFhdmdlQ2wxL1lBWUdNTmVZSERjWG1x?=
 =?utf-8?B?UUs3TmljeUVpMVArKzZOM0oxTUVRSDFEYXJuQkRQQVdwY2RpSXhvYlBSdDdS?=
 =?utf-8?B?V0xRVnlJL3pqTEdOMHoweXdDQWt3R1UycWZwb1FDTDlFRDBhOVFobVZZT0NK?=
 =?utf-8?B?c1JrTTIvK2djK0ZqaFB2Q1FyelViTW0vcFBNK0xDVXplbXRvTVYrWXZhSWhV?=
 =?utf-8?B?NmptWk9kb3BFdzVZMmdTakdZTS9vYi9YbFJ5eW96RnFRUlp2N1piNXJtYU4v?=
 =?utf-8?B?RlczK3EvUUlrNGhsb2xoRlVaV05OV3hsT0Nwb3d3WTZ2cnJ3QTEyYml3Qkx3?=
 =?utf-8?B?K3JXYWsvZXk5d01OOVRlbVZGdmYzTS8yaWFVM1VTRnFZTnE1c05qTm9oSWRC?=
 =?utf-8?B?a3puYkVsVUUxNGkwQ0hRWW5PVXoyY2hUcTF6N3A4S2REOW5MeU11TzA5emhq?=
 =?utf-8?B?bUExTHNyNVg0TkUya0t5ZWNXU05FR3lQNlZEZWxuckNucW13bTBHWXJJTlN3?=
 =?utf-8?B?b2toOTlGWW95SzJnSHhzQVI3VERpaTlzVWN3Nk5HOFlGZjdmcU1aQ3QxQmk1?=
 =?utf-8?B?WTZwK1d0LzhaaU5ZcEVmSS96dUlROXM2eUJtYVZkU2loKzBjeXJpUGx0ZWM0?=
 =?utf-8?B?U2hRUmZMaEpoRGhOYmFQSVgreGVYRXZrWWZxOGU2S1lmVGQ0OUV2YkVvZDBU?=
 =?utf-8?B?ekUxcURPbUN5aVA5SkFhckJHRDdFQ2l3dWVISURkTmZlelFFTjd2OWNZZXZm?=
 =?utf-8?B?c0srM2xLK3FDczdJQ3pUeU9IYlBMNWRMcndpMGYvZkY2MTVwS0lGZ292cGo3?=
 =?utf-8?Q?4xudzP+yHbBA1w5Jya5CVME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94F5337234AD944F9E6616CA81FF5FF9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5514.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb7c357-c684-4434-7c68-08dc419358c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 06:20:28.4335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KVIsfhcnPkYuoHPopSc+Ni2JM/LoDEHR8s+iIEXywgJ4lJWFDfjIXtenSgO96A5dPUC9zVZ7WlLJ8o83HPNKyjjgyczPjpzRD2eANhyftI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7409
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.827100-8.000000
X-TMASE-MatchedRID: hls5oAVArl8OwH4pD14DsPHkpkyUphL9QKuv8uQBDjrb6Y+fnTZUL/3P
	7PV5Gp/Q762AX6qVgnEXx7Y1qQDTgLZ4xEO8ChS19Ib/6w+1lWQhwKIIdklOV+od133eVWP4wyk
	hkAJj9sE1788N87XboHetSK7DATLfU/SF2hrhoS1c/msUC5wFQSmkZgwpl7M3nQqircTOm4f77e
	BDbq1tuOiOjwg/iONcL+ZX8jH+lEViqLA/u706icNrWpY804TGju+GX08gELB2jD/JuqpOkqqPo
	yh3F974ZsAAlfA/+SWRk6XtYogiatLvsKjhs0ldVnRXm1iHN1bEQdG7H66TyBVBSZtgeh/R
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.827100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A4A6F8A0909DE17DE1CE61C8E2ACD323489255A18BB893F19B6113A7533830AD2000:8

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDA5OjA5ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiANCj4gSSBndWVzcyB0aGF0J2QgYWxzbyBhcHBseSB0byBwcm9iZSByZXNwb25zZXM/IE9yIGRv
ZXMgaXQgbm90IHNlbmQNCj4gdGhvc2UNCj4gYXQgYWxsPyBCdXQgd2UgZGlzY3Vzc2VkIGJlZm9y
ZSB0aGF0IG1heWJlIHdlIGRvbid0IGhhdmUgdG8gYmUNCj4gcGVyZmVjdA0KPiB0aGVyZSwgc28g
SSBndWVzcyB3ZSBjYW4gZmluZCBzb21lIHNvbHV0aW9uIHRvIHRoYXQuDQo+IA0KPiBTbyB3ZSBo
YXZlLCBzbyBmYXINCj4gDQo+IFJlYWx0ZWs6DQo+ICAtIHVzZXMgb2Zmc2V0IGluIGJlYWNvbiB0
ZW1wbGF0ZSB0byBzZXQgcGFydG5lciBjb3VudGVyLA0KPiAgLSByZXF1aXJlcyBob3N0IHRvIHNl
dCBDU0EvRUNTQSBlbGVtZW50cw0KPiANCj4gUXVhbGNvbW06DQo+ICAtIGNvcGllcyBhbmQgdXBk
YXRlcyBDU0EvRUNTQSBlbGVtZW50cyBhbGwgYnkgaXRzZWxmDQo+ICAtIGJ0dywgbm90IHN1cmUg
aGVyZSBhYm91dCBwcm9iZSByZXNwb25zZXMsIGRvZXMgaXQgZG8gdGhhdCB0b28/DQo+IA0KPiBo
d3NpbToNCj4gIC0gcGVyc29uYWxseSwgSSdkIHByZWZlciBpdCB3b3JrcyBsaWtlIFJlYWx0ZWss
IGZvciBsZXNzIGNvbXBsZXhpdHkNCj4gDQo+IEludGVsOg0KPiAgLSBub3QgaW1wbGVtZW50ZWQs
IHByb2JhYmx5IG5vdCBnb2luZyB0byBoYXBwZW4gYW55IHRpbWUgc29vbiwgYnV0IEkNCj4gICAg
dGhpbmsgd2UgbWlnaHQgcHJlZmVyIHRoZSBSZWFsdGVrIHdheSB0b28gaWYgd2UgZXZlciBkbyB0
aGlzDQo+IA0KPiANCj4gTWVkaWF0ZWs/IEJyb2FkY29tPyBBbnlvbmUgZWxzZT8NCj4gDQo+IA0K
PiBJIGd1ZXNzIHRoZW4gZm9yIFF1YWxjb21tIHdlJ2xsIG5lZWQgdG8ganVzdCBhZGQgYW4gZXh0
ZW5kZWQgZmVhdHVyZQ0KPiBmbGFnIGZvciAiRldfSEFORExFU19QQVJUTkVSX0xJTktfQ1NBIiBh
bmQgdGhlbiBob3N0YXBkIGNhbiBqdXN0IG5vdA0KPiB1cGRhdGUgdGhlIHBhcnRlciBsaW5rIHRl
bXBsYXRlcywgb3Igc28/DQo+IA0KPiBUaGFua3MsDQoNCkhpLA0KIA0KU29ycnkgZm9yIHRoZSBs
YXRlIHJlcGx5Lg0KIA0KSW4gc3VtbWFyeSwgTWVkaWFUZWsgZmlybXdhcmUgYmVoYXZlcyBzaW1p
bGFybHkgdG8gUmVhbHRlaydzIGZpcm13YXJlLA0Kc28gd2UgYWdyZWUgb24gdGhlIGNvbmNsdXNp
b24gb2YgdGhpcyB0aHJlYWQuDQogDQpCeSB0aGUgd2F5LCB0aGlzIGJlaGF2aW9yIGRvZXMgbm90
IGFwcGx5IHRvIHByb2JlIHJlc3BvbnNlIGluIE1lZGlhVGVrDQpmaXJtd2FyZS4gSW4gb3RoZXIg
d29yZHMsIE1lZGlhVGVrIGZpcm13YXJlIGRvZXMgbm90IG1vZGlmeSB0aGUgcHJvYmUNCnJlc3Bv
bnNlIGFuZCBpdCByZXF1aXJlcyBob3N0YXBkIHRvIGZpbGwgYWxsIENTQS1yZWxhdGVkIEVsZW1l
bnRzLg0KSSB0aGluayB0aGlzIGNvdWxkIGJlIGZpeGVkIGlmIGhvc3RhcGQgcHJvdmlkZXMgQ1NB
IG9mZnNldHMgd2hlbg0Kc2VuZGluZyB0aGUgcHJvYmUgcmVzcG9uc2UuDQogDQpCZXN0LA0KTWlj
aGFlbA0KPiBqb2hhbm5lcw0K

