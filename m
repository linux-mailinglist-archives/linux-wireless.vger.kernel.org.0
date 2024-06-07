Return-Path: <linux-wireless+bounces-8648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF98FF9DA
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1311B22802
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E1DDD4;
	Fri,  7 Jun 2024 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QoB8n48v";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rpJCnTjM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECFB64E
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725641; cv=fail; b=mIjyOnM+vSUAtu+r/qGzPKp/F/rUAcm9XTgyoQZf+XC5vybYzEpn/cvC2QDaxmKZtxUwT3fyssNvCoUjJ8ziW/nLUJ5mgxLkz+hjgiqQwnFluVkfrn8WdAIC2CX7AOqbPrfyuQqNJqK6dA5W23saen3dCOVe1St6vFpKScldIng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725641; c=relaxed/simple;
	bh=2cLDqvge4QCX3KmM5FUFIU1OQq+aTRksdWGounrr6Z4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F6pnJukn2GxifgQAL6DHsxWolLmvBrhB0qlwHV99+4NpKwCD/e8IFO3l6r+dfQa5QO8RiECJXPbPoTQ35HGkwDpw4t3Szu1FuNdPXuTQiz/h4F7BxGusOLoujvLTlIVjq94swZ7ggzpdNy0vA8xk597v63W4c64rwHOoxElP6SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QoB8n48v; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rpJCnTjM; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b174c63c247111efa22eafcdcd04c131-20240607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2cLDqvge4QCX3KmM5FUFIU1OQq+aTRksdWGounrr6Z4=;
	b=QoB8n48vGtSY2IV4NaV1zoFE221c7cZ6WWQmvVZ556z4iwko36HxEx+EEUMNqwO9sQceUoQGkpDfb5ocWeTn007zsWTURCOmnyYP4uRKMvT7bpBMGGNatNqMSKrdBAcV2tM8FmQPH2deNuGodrIYwCo5SdZ/aq6EYyrOz2kCnGE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:d4891784-2188-4d94-8307-587828134f38,IP:0,U
	RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-META: VersionHash:393d96e,CLOUDID:452c5088-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b174c63c247111efa22eafcdcd04c131-20240607
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <michael-cy.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2070822534; Fri, 07 Jun 2024 10:00:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 7 Jun 2024 10:00:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 7 Jun 2024 10:00:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqnFJdPQpbZFzGQlqAxSkRzVNARsvv0ynczvibJdxQtHbMukLZxSojoKZ/Lf0c0x7y7IU4YRVr1v/MPXO216AO2palKha5cFo/O5z/isE9n0hbl9/1RG/VFd472DwE3hECfcbc5JmQtFqhprxBAHhj1m+MHInNObEovKkt4yJKwOFouI0jsb29J6RA09hmePhW3MOiA+07b7dkRI5k4FVLXu1XsLHnv6xiOcuxmQEtOC3C12AN3xXGz4wnM3szslaHXp9ZiMmSMNK1xekhTKSO0AHDhYzId6GB612ft0CJvKT9LeztrMDYnkRIYH0pOH3sX6Q6D6jT8w6L5fUxY8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cLDqvge4QCX3KmM5FUFIU1OQq+aTRksdWGounrr6Z4=;
 b=I8QlAEB/UbmZZEKRnwJdhFluGA6HC49MjhFlr8q8sC5UeoV7EoKJrAwyH/yyxW/GS6NOQUse9GrM4mX+3eh8GTIARkNoAHN8tw8xk6mZfoz6FDnt6flAaX0P9AEZ+EaKnlSeMAdjFxKFp5gvykCDDFINFdDVCJyfF/2DVTmhps47fQY5VQxQZX63oCUC4m3iBEmS0cvD5VBClZAFlWD19v1KannS2r3kqpVguc8swNzvY0etT+nMci4GnnPrHFZjKOgudH2QFfajAtBEHmfGtfFmdAOc4M1QDI0sT8tupgqXHdDkeLdlI4sSyg9PDdirlQKR+cpGXmmeyTEJG5WC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cLDqvge4QCX3KmM5FUFIU1OQq+aTRksdWGounrr6Z4=;
 b=rpJCnTjMrFxK7J43pJBnJcZMlDxaSr9StkEJTUQs0qM4m8AEjs5oeai/EM4s+koUkxzycab+hRoSJWd/Q1n6rlYvoJlBnrUr9VuPre4xKWQl7gxtUCkKLLZZlPf7zh+jYqyEwqtlbpVKrwyv3+Br8pPb1vGPv3ihEMz+Jkhyvwc=
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com (2603:1096:820:50::6)
 by TYZPR03MB7484.apcprd03.prod.outlook.com (2603:1096:400:427::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16; Fri, 7 Jun
 2024 02:00:15 +0000
Received: from KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::5bac:5b06:6544:cd37]) by KL1PR03MB5507.apcprd03.prod.outlook.com
 ([fe80::5bac:5b06:6544:cd37%4]) with mapi id 15.20.7656.019; Fri, 7 Jun 2024
 02:00:15 +0000
From: =?utf-8?B?TWljaGFlbC1jeSBMZWUgKOadjuWzu+Wuhyk=?=
	<Michael-cy.Lee@mediatek.com>
To: "greearb@candelatech.com" <greearb@candelatech.com>, "sven@narfation.org"
	<sven@narfation.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: mac80211: scan ignores next_delay calculation after first probe
Thread-Topic: mac80211: scan ignores next_delay calculation after first probe
Thread-Index: AQHat9qsG6O6mVgUEkG//+srMI7jXbG6wR4AgADMCoA=
Date: Fri, 7 Jun 2024 02:00:15 +0000
Message-ID: <eeb7a3659d8eca3a3a1fe080628cac7826d0ac5d.camel@mediatek.com>
References: <2540184.6tgchFWduM@ripper>
	 <2bcadb06-2a4e-4603-945c-839d92ace8fa@candelatech.com>
In-Reply-To: <2bcadb06-2a4e-4603-945c-839d92ace8fa@candelatech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5507:EE_|TYZPR03MB7484:EE_
x-ms-office365-filtering-correlation-id: d139d47e-2d01-4811-d4d7-08dc869592c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?L0s5VzJJVG5CUzFNYXBxNjJ1czdjdUowZjhDdWN2L1pGUkdLZlVNbWpDaW9E?=
 =?utf-8?B?OXYybkNqS0U4SGRRV1ppQk1BM3BtMFovSm81Q3J2NG1sNFlYSm43WXQwY3lz?=
 =?utf-8?B?SlhzUnloVHZBR1NqMjNQa3I5UGlJcTJRbGdLYmRXaXA3MmtqQUF5TS9xYzlS?=
 =?utf-8?B?L0R6NHhZU2NKSDhCTTFnNkp5WnE1YUw1MXJ3Y1BqOXFtY1NJdTdWMXZ2ZFVJ?=
 =?utf-8?B?c3lqRUpsT2E3R0RPUStkVkROdENQc2VtNlFRYUUwbFhiQ1VrVEJWZ2FaNDll?=
 =?utf-8?B?RG1XajFMTTlROUlwb1dwZllHTStqeW5oU3l0Mnp3dzZPbXF1c1FRZXJicHR3?=
 =?utf-8?B?NmlNdUtKbUlSS1d4OVpMeUZyWXA5Ym5kMTJiWjRKOHlwVHE4WXhBaFJLeDhK?=
 =?utf-8?B?bERiSmtwYndQWEdLMUFhY25QWjVIeExhYyt3djFFRENPQ0FoTGFHZGFhZm54?=
 =?utf-8?B?OTNQMTIrZnEvREJSUlhkdDMyNFZiZndja0ZuYkJ3bERFdW03bzV2RjlXcTF0?=
 =?utf-8?B?WDVBcDgyZXZJeEJJZ1dkQ2NvaCtia3hJeEQySjRlQ1lmL2dkSFphKzZzU016?=
 =?utf-8?B?UmRQc2ViSncwTmI0Y2ladnErY2lYcjkxREw2elB5UHV0clVBZDJZd2g3VjRT?=
 =?utf-8?B?THcwamlpUFVBelIyZnViM1huNU14anh1MUdWaHp3N3dCREJrWlRIWGt5TnA4?=
 =?utf-8?B?cmNmN2M3bC8wdDNrbUFjZzJQQkZKYUdqU0w2bjR0ViswUzlmOGlNVmZQd1po?=
 =?utf-8?B?WkZWQlpkZysxbWcrWm92aTIzZEZkVENwNSsrNU1kdFlEQ2JRaS81RThDVFVw?=
 =?utf-8?B?NExsTCtzNnovRVlFNFBTejB0SG1mNnB4MnMzc2VmSStsYVJkTUZDSjd6amRY?=
 =?utf-8?B?NDZpbllhZ3hZQ2JrbnBSSzJuOHM0d01TMFFxcEF5Q1JSbzZWWWE0YXJsMlVB?=
 =?utf-8?B?anV4clY1VCtkUFZqVUFCVk1DZjNJbWVtTWZ4dEl1NkdpWmlJb2lFd1dZTzBU?=
 =?utf-8?B?b1dwVFRLZWFpZG1PY1VwT1A5MW1Qd25QdUZsUmZjQmFDdW0wZ1RRWS9IWDlK?=
 =?utf-8?B?cjlmOEdxelArZlplQmNtdDVrYVo1dDlKdXFHUzczODMwSGRJRkxrUWU0NUFT?=
 =?utf-8?B?b2NpRFpyejdoMW4vUWtNM3FGZlRnRjd6cE1HaGNZMDlUc0pJZjdmdGdmWVNY?=
 =?utf-8?B?SmdwanVaOFI2S0RlcVc1d0JZbVplZzh5OVJqREVuQkRmQllZa09kUDFJWURT?=
 =?utf-8?B?YVZ2TitpLzlXTnppeEp0cEUyZG1vQ2ZZeHRZc1o4Zy9IRHB3WWhMaERkWlFN?=
 =?utf-8?B?Y3VYTXVOYjVWeWJhUWxYbGRBR1NLdWtDcExOZ0YwTEo3UHVUZjRPRVovZERU?=
 =?utf-8?B?QlVwdUt3WWNDZ0NvanVHWk5Gb3p5MGlhUGxXMzVFQlYyT3VCaUZScjN6MXA3?=
 =?utf-8?B?TUthTGZoYUpnWlY3WmtyUDA3dW5qemR0eXIxSFhMTnNzOXV2ZVkxSXdvRkhT?=
 =?utf-8?B?ZzBuZDBXaTlxbUd2V3FmUGo5WmJqQlorREpJWDNJQ0ZuU2ROMzk1SzZ3MlBK?=
 =?utf-8?B?NFlmcitSZlc3eVFaVHVRYml0TzA1dUphUE4yaTl2MjFROFFSL2tTc1BVWXZ5?=
 =?utf-8?B?NkhMMTFMTzVoWkphVEd0dmdBdDZmQ2p6YWpHYXN4WDRSKzJqN09DMW9XRmRO?=
 =?utf-8?B?bFkrQ0hKUjE5bWh2MkE2NU9oV29tY2dJNnU0L2NjOXNvQmNDYkQwUFllNlRm?=
 =?utf-8?Q?qs6LrIYZ7kLOcRaUWuxM/KdccebB1ehO6NImm2m?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5507.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDdjQnRYN1hlc3EwMG1VY0RDb3BJUEVGVXlZRzBob1hRTndSMHl6WHduSFMz?=
 =?utf-8?B?REQrdkUzY2JNenA4bzFCMDNJcGdERXpFSWlVd0llZXZoSERiZGxXVnJ4Ymd0?=
 =?utf-8?B?WVlqWXVnMVJTTldxbmtrbHVrTm5GZElVb1VNaEZzejI0b2tjWG1QYUg3Y242?=
 =?utf-8?B?VG9zdEw3NC9rNlNzRGRISWVEYmMxTVpkUTF4S0JZeXdQbTh6dCtJS2tpYnFo?=
 =?utf-8?B?VG9tVkp4Q1NjMUdRZkdYREgycGxPV3RpNGhydlZWSkp4bGNzdkE5NmdlL3Ew?=
 =?utf-8?B?d3hNdlFzUzBaSDBIWWd5Vk85WGw4TUl3RWU5YnkyNlgwTUFxVXdOQzBjTkNJ?=
 =?utf-8?B?Mlc2OFdjSjJESGFkcloyRHE1dXh2M2lQNmRxRUx0aDN2WmdSNyt2aXdFcnlE?=
 =?utf-8?B?cE0zRnR3YVdWRGpZNTBvQXdWRlFrWWcvTS9rd3Fsa1ZYSGNwaCsxY1J0aFUy?=
 =?utf-8?B?dEZzUk0yYTNLU0hEdURMWmIvOWc3VUh2ZG5TWExGSDN4U2UxSW9OdWdoMzlu?=
 =?utf-8?B?ckVnbFBEMjRIYndDVHdQQi85c3ZmT0RkaldIN2xON2F2VDhZcC9lQXNQOFZt?=
 =?utf-8?B?dkR3UW1aV001RDFaZHA5WkRkKzdkYm9hOXB4TnN6SmZqYWFaVGpFaDJZeTBo?=
 =?utf-8?B?MTE0bkVoUmxqRDJQWWRiZkYyRFJsRkR0cWJQd2tRVUdEY2VBcXRZQkdnOFJq?=
 =?utf-8?B?YlV3M1lUSTBTRGJzR0RubXoySjNVL0p6aFpyNEIzRlZvWmNtWXUrV213djc1?=
 =?utf-8?B?ZEI4aXFGVGxHR2lpaDcySlRtN1lXMC95Q3VNajlRNUEyNXJvQ2h4RFc3STNE?=
 =?utf-8?B?WUc1VWZ4Z2hSWnRNeUhJNzBUd2FiSHpCOWYvc2NTVE9jL1VESFVvOFhkRjM4?=
 =?utf-8?B?cE1xZXQrU3hNSzh3dWtnS0I0czdxa25pQU5sVzMrdFJXaGZWUkwzV1hkUXdu?=
 =?utf-8?B?WGkrejBSdTQ5ZjB6eFNyUmVndEtTMHo3Z3loWWw3cDc5TW5laURsbWY2cHky?=
 =?utf-8?B?cE1HalNDYUlHMHJqUUxvZk5qRmtBWnFBTzdmVnY0NWJuZEE4RkgvQXB1aE1O?=
 =?utf-8?B?Z0YwM284SjdlLzFyNmV1bGRRcFJVZ1FFY0hGa2MrcldYU0tacnU1SlQycUNi?=
 =?utf-8?B?cmptQ2NFNU0rTGxwOGd0TmhVSjNOa21MbldTK0M2MXJxbFB1RUxHUm1Ydjdv?=
 =?utf-8?B?bWJMMUlMbDZEMmd6QmQzdlNpNnVHUFYwRzFXcjJrcFNmYjV4WjZjbkZYV2Qz?=
 =?utf-8?B?N2lLZkFxZ2dlNk9tT3JaOWpBM3FveTJweHBPc1VscnpwRGdtdFl0cmpoVVBP?=
 =?utf-8?B?eDF5TCthb1NRVlVDeXhWaml6aStLdVU2cEJ4U1I2d1FkMlZncEZReFZmRTUz?=
 =?utf-8?B?aVRVRHRGOHNMcWFHc2JDOVFmRTdBNTFsMTVkLzEyMWJWbXNKengxQUI5UXN6?=
 =?utf-8?B?cmNicHFSYk5Va1ZrUkhmWG9RbEt3cU5WVlRKYmtROXhGdHpscnBjaHpGRWFI?=
 =?utf-8?B?QW56eVNrR0NadkppQ3hIWlpVNFZIOS94dmdmS2ZjcFJsdTVhbndKaVpRcmFh?=
 =?utf-8?B?TzU5by8vM2NZS0J6dk9YVlJSdy9KcURpZ21CMWRRRUJvSGh2R3U5R0EzTVVX?=
 =?utf-8?B?YlpHSTFTNHN2RVYwajgvVzgzVTNKVmRwRzJIcXdrMStWNXJSL0w4YUx4MWhx?=
 =?utf-8?B?Z0VvVmlCZUhWblVxZ3ZWR1ZacndGWHl3SjBJM3lmNmduc2hLazRHSGtMVllw?=
 =?utf-8?B?WGc1dWJ2eHVjU3R0TE04emcyN094L1liVUM4QnFiUE9kczFwaEw1L0FiOW9W?=
 =?utf-8?B?ZE1qYm5YZEtvL0FJeDRManVQM21DSjE0cktkWXBCbk5VS3VRS0dEUGwrbC9x?=
 =?utf-8?B?RnVxUzNGK2h3cFlVdXR3LzdyTk04cnVhd0RZL0huVGVTNnNjL2dBVjlXdnFV?=
 =?utf-8?B?YTZudkFzTlRBc0hFSlJLbDJIOXBGdCtPMnpaRmtXZTMzSkw2bUlKZmxweEYr?=
 =?utf-8?B?OG12MFpmeGdaUnVpdEFOekhJay9rOE5XdXM3aFBTTGMwZTlUeTVmS04xTVo5?=
 =?utf-8?B?cVZBNHExSWppV2pVTUNQZXF4cnZBbEVDaWhKWmpNREJLTUhaQTJTeUZMVU1h?=
 =?utf-8?B?NllqNWR1czl2Sy9BL3JpVlVCeXczdEhYaDVOWjJHZWNkS3prVHUwQjNJbUlK?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73E59693D62CBC459D57B9B88F1E9879@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5507.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d139d47e-2d01-4811-d4d7-08dc869592c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 02:00:15.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DY8/zWeqec9n1WfqKgHcHpBBL8+Auf+CViR6e21YVk01wArvbkulH9Qo+kcj5sU1IttwJxpvcRHfa1kC1Vxy9E8C5qwQI1BYVR41jcXBsic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7484

SGkgU3ZlbiAmIEJlbiwgDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLCBwbGVhc2Ugc2VlIHRo
ZSBpbmxpbmVzLg0KDQpPbiBUaHUsIDIwMjQtMDYtMDYgYXQgMDY6NDkgLTA3MDAsIEJlbiBHcmVl
YXIgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUg
c2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gNi81LzI0IDIzOjI3LCBTdmVuIEVja2VsbWFu
biB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBJIHdhcyBkZWJ1Z2dpbmcgc29tZSBwcm9ibGVt
cyB3aGVuIHRyeWluZyB0byBzY2FuIGZvciBCU1MgKGFuZCB0aGV5DQo+IHdlcmUgb2Z0ZW4NCj4g
PiBub3QgcmVjb3JkZWQgb24gY2hhbm5lbCAxKSBhbmQgbm90aWNlZCBzb21lIHBvdGVudGlhbCBw
cm9ibGVtcyB3aXRoDQo+IHNvbWUgY29kZQ0KPiA+IGNoYW5nZXMgYnkgeW91LiBOb3QgbmVjZXNz
ZXJpbHkgdGhlIGNoYW5nZXMgaXRzZWxmIGJ1dCB0aGUgcGFydHMNCj4gd2hpY2ggbG9vayBhDQo+
ID4gbGl0dGxlIGJpdCBsaWtlIHRoZXkgd2VyZSBtaXNzZWQuDQo+ID4gDQo+ID4gV2l0aCB5b3Vy
IGNvbW1pdCBkNjAyNzdhYzNmYzkgKCJ3aWZpOiBtYWM4MDIxMTogYXBwbHkgZHVyYXRpb24gZm9y
DQo+IFNXIHNjYW4iKSwNCj4gPiBJIGNhbiBub3cgc2V0IHRoZSBkdXJhdGlvbiBpbiBTVyBzY2Fu
cyAodGhhbmsgeW91KS4gQnV0DQo+IF9faWVlZTgwMjExX3N0YXJ0X3NjYW4NCj4gPiBqdXN0IG92
ZXJ3cml0ZXMgdGhlIGNhbGN1bGF0ZWQgbmV4dCBkZWxheSBvZg0KPiBpZWVlODAyMTFfc2Nhbl9z
dGF0ZV9zZW5kX3Byb2JlLg0KPiA+IFNvIGZvciB0aGUgZmlyc3QgY2hhbm5lbCwgdGhlIGR1cmF0
aW9uIHN0aWxsIHNlZW1zIHRvIGJlIHdyb25nLg0KPiA+IA0KPiA+IEluIHRoZSBwYXN0LCB0aGUg
dmVyc2lvbiBmcm9tIEJlbiBHcmVlYXIganVzdCBvdmVyd3JvdGUgdGhlIHZhbHVlDQo+ID4gSUVF
RTgwMjExX0NIQU5ORUxfVElNRSAoZnJvbSBpZWVlODAyMTFfc2Nhbl9zdGF0ZV9zZW5kX3Byb2Jl
KSB3aXRoDQo+IHRoZSB2YWx1ZQ0KPiA+IElFRUU4MDIxMV9DSEFOTkVMX1RJTUUgaW4gX19pZWVl
ODAyMTFfc3RhcnRfc2Nhbi4gVGhpcyBzbGlnaHRseSBvZGQNCj4gYmVoYXZpb3INCj4gPiB3YXMg
aW50cm9kdWNlZCBpbiA4YTY5MDY3NGUwNjAgKCJtYWM4MDIxMTogU3VwcG9ydCBvbi1jaGFubmVs
IHNjYW4NCj4gb3B0aW9uLiIpLg0KPiA+IEFuZCBldmVuIHdoZW4gaXQgZGlkbid0IG1hZGUgYSBs
b3Qgb2Ygc2Vuc2UgdG8gbWUgLSBpdCBkaWRuJ3QNCj4gY2hhbmdlIHRoZQ0KPiA+IGJlaGF2aW9y
LiBCdXQgbm93IGl0IHNlZW1zIHRvIGJlIGNvdW50ZXIgcHJvZHVjdGl2ZS4gTWF5YmUgeW91IGNh
bg0KPiBjaGVjayB0aGlzDQo+ID4gYWdhaW4gYW5kIG1heWJlIEJlbiBHcmVlYXIgc3RpbGwgcmVt
ZW1iZXJzIHdoeSB0aGlzIHRoZXJlIGluIHRoZQ0KPiBmaXJzdCBwbGFjZS4NCj4gDQo+IEhlbGxv
IFN2ZW4sDQo+IA0KPiBJdCdzIGJlZW4gYSBsb25nIHRpbWUsIEkgZG9uJ3QgcmVjYWxsIHRoZSBl
eGFjdCBkZXRhaWxzLiAgQnV0IG15DQo+IGdvYWxzIHdlcmUNCj4gdG8gaGF2ZSBtaW5pbWFsIGlt
cGFjdCB3aGVuIHdlIGFyZSBzY2FubmluZyBvbmx5IHRoZSBjdXJyZW50IHdvcmtpbmcNCj4gY2hh
bm5lbC4NCj4gU2hvdWxkbid0IG5lZWQgdG8gZG8gYW55IG9mZi1jaGFubmVsIHdvcmssIHN0b3Ag
b3RoZXIgdHJhZmZpYywgb3IgYWRkDQo+IGV4dHJhIGRlbGF5IGluIHRoYXQgY2FzZS4NCj4gDQo+
IFRoYW5rcywNCj4gQmVuDQo+IA0KDQpJIGFncmVlLCBzaW5jZSBpdCBvbmx5IHNjYW5zIHRoZSBj
dXJyZW50IGNoYW5uZWwsIHRoZSAnZHVyYXRpb24nIG1pZ2h0DQpiZSBtZWFuaW5nbGVzcyBhbmQg
dGhlcmVmb3JlIGlzIG5vdCB1c2VkIGhlcmUuDQoNCj4gPiANCj4gPiBUaGUgZGlzY3Vzc2lvbiBp
cyBhYm91dCB0aGlzIHBhcnQgKHdoaWNoIG92ZXJ3cml0ZXMgdGhlIGNvcnJlY3QNCj4gdmFsdWUg
Zm9yDQo+ID4gbmV4dF9kZWxheSk6DQo+ID4gDQo+ID4gc3RhdGljIGludCBfX2llZWU4MDIxMV9z
dGFydF9zY2FuKHN0cnVjdCBpZWVlODAyMTFfc3ViX2lmX2RhdGENCj4gKnNkYXRhLA0KPiA+ICAg
c3RydWN0IGNmZzgwMjExX3NjYW5fcmVxdWVzdCAqcmVxKQ0KPiA+IHsNCj4gPiBbc25pcF0NCj4g
PiBpZiAoaHdfc2Nhbikgew0KPiA+IF9fc2V0X2JpdChTQ0FOX0hXX1NDQU5OSU5HLCAmbG9jYWwt
PnNjYW5uaW5nKTsNCj4gPiB9IGVsc2UgaWYgKChyZXEtPm5fY2hhbm5lbHMgPT0gMSkgJiYNCj4g
PiAgICAocmVxLT5jaGFubmVsc1swXSA9PSBsb2NhbC0+aHcuY29uZi5jaGFuZGVmLmNoYW4pKSB7
DQo+ID4gW3NuaXBdDQo+ID4gDQo+ID4gaWYgKChyZXEtPmNoYW5uZWxzWzBdLT5mbGFncyAmIChJ
RUVFODAyMTFfQ0hBTl9OT19JUiB8DQo+ID4gSUVFRTgwMjExX0NIQU5fUkFEQVIpKSB8fA0KPiA+
ICAgICAhcmVxLT5uX3NzaWRzKSB7DQo+ID4gbmV4dF9kZWxheSA9IElFRUU4MDIxMV9QQVNTSVZF
X0NIQU5ORUxfVElNRTsNCj4gPiBpZiAocmVxLT5uX3NzaWRzKQ0KPiA+IHNldF9iaXQoU0NBTl9C
RUFDT05fV0FJVCwgJmxvY2FsLT5zY2FubmluZyk7DQo+ID4gfSBlbHNlIHsNCj4gPiBpZWVlODAy
MTFfc2Nhbl9zdGF0ZV9zZW5kX3Byb2JlKGxvY2FsLCAmbmV4dF9kZWxheSk7DQo+ID4gbmV4dF9k
ZWxheSA9IElFRUU4MDIxMV9DSEFOTkVMX1RJTUU7DQo+ID4gfQ0KPiA+IFtzbmlwXQ0KPiA+IH0N
Cj4gPiANCj4gPiANCj4gPiBBbmQgaGVyZSBpcyB0aGUgY29kZSBpbiBmb3IgaWVlZTgwMjExX3Nj
YW5fc3RhdGVfc2VuZF9wcm9iZSB3aGljaA0KPiBhbHdheXMgc2V0cw0KPiA+IG5leHRfZGVsYXkg
dG8gdGhlIGNvcnJlY3QgdmFsdWU6DQo+ID4gDQo+ID4gc3RhdGljIHZvaWQgaWVlZTgwMjExX3Nj
YW5fc3RhdGVfc2VuZF9wcm9iZShzdHJ1Y3QgaWVlZTgwMjExX2xvY2FsDQo+ICpsb2NhbCwNCj4g
PiAgICAgdW5zaWduZWQgbG9uZyAqbmV4dF9kZWxheSkNCj4gPiB7DQo+ID4gW3NuaXBdDQo+ID4g
LyoNCj4gPiAgKiBBZnRlciBzZW5kaW5nIHByb2JlIHJlcXVlc3RzLCB3YWl0IGZvciBwcm9iZSBy
ZXNwb25zZXMNCj4gPiAgKiBvbiB0aGUgY2hhbm5lbC4NCj4gPiAgKi8NCj4gPiAqbmV4dF9kZWxh
eSA9IG1zZWNzX3RvX2ppZmZpZXMoc2Nhbl9yZXEtPmR1cmF0aW9uKSA+DQo+ID4gICAgICAgSUVF
RTgwMjExX1BST0JFX0RFTEFZICsgSUVFRTgwMjExX0NIQU5ORUxfVElNRSA/DQo+ID4gICAgICAg
bXNlY3NfdG9famlmZmllcyhzY2FuX3JlcS0+ZHVyYXRpb24pIC0gSUVFRTgwMjExX1BST0JFX0RF
TEFZDQo+IDoNCj4gPiAgICAgICBJRUVFODAyMTFfQ0hBTk5FTF9USU1FOw0KPiA+IGxvY2FsLT5u
ZXh0X3NjYW5fc3RhdGUgPSBTQ0FOX0RFQ0lTSU9OOw0KPiA+IH0NCj4gPiANCj4gPiANCj4gPiAN
Cj4gPiBBbmQgbWF5YmUgeW91IGhhdmUgYWxzbyBub3RpY2VkIHRoYXQgeW91ciBwYXRjaCBtaXNz
ZWQgdGhlDQo+IGNhbGN1bGF0aW9uIGZvciB0aGUNCj4gPiBwYXNzaXZlIHNjYW4gaW4gX19pZWVl
ODAyMTFfc3RhcnRfc2Nhbi4gSXQgYWx3YXlzIHNldHMgaXQgdG8NCj4gPiBJRUVFODAyMTFfUEFT
U0lWRV9DSEFOTkVMX1RJTUUuIEJ1dCBJIHdvdWxkIGhhdmUgZ3Vlc3NlZCB0aGF0IHRoZQ0KPiBj
YWxjdWxhdGlvbg0KPiA+IHNob3VsZCBhbHNvIGJlDQo+ID4gDQo+ID4gbmV4dF9kZWxheSA9IG1z
ZWNzX3RvX2ppZmZpZXMoc2Nhbl9yZXEtPmR1cmF0aW9uKSA+DQo+IElFRUU4MDIxMV9QQVNTSVZF
X0NIQU5ORUxfVElNRSA/DQo+ID4gICBtc2Vjc190b19qaWZmaWVzKHNjYW5fcmVxLT5kdXJhdGlv
bikgOg0KPiA+ICAgSUVFRTgwMjExX1BBU1NJVkVfQ0hBTk5FTF9USU1FOw0KPiA+IA0KPiA+IA0K
PiA+IEFub3RoZXIgcGFydCB3aGljaCBzZWVtIHRvIGhhdmUgYmVlbiBtaXNzZWQgYnkgeW91ciBw
YXRjaCBpcyB0aGUNCj4gPiBzY2FuX3N0YXRlX2RlY2lzaW9uIGhlbHBlciBjb2RlIGluIGllZWU4
MDIxMV9zY2FuX2dldF9jaGFubmVsX3RpbWUuDQo+IEl0IGxvb2tzDQo+ID4gdG8gbWUgbGlrZSBp
dCBjb3VsZCBub3cgdW5kZXItZXN0aW1hdGUgdGhlIHNjYW4gdGltZSBiZWNhdXNlIGl0DQo+IGRv
ZXNuJ3QgaGFuZGxlDQo+ID4gdGhlIGR1cmF0aW9uIGluZm9ybWF0aW9uLg0KDQpJIHNlZSB0aGUg
cHJvdGVudGlhbCBwcm9ibGVtIGhlcmUsIEkgd2lsbCBzZW5kIGFub3RoZXIgcGF0Y2ggdG8gZml4
IGl0Lg0KT3IgbWF5YmUgeW91IGFscmVhZHkgaGF2ZSBvbmU/IFlvdSBjYW4gc2VuZCBpdCB0byBw
YXRjaHdvcmsgOikNCg0KPiA+IA0KPiA+IA0KPiA+IEtpbmQgcmVnYXJkcywNCj4gPiBTdmVuDQo+
IA0KPiAtLSANCj4gQmVuIEdyZWVhciA8Z3JlZWFyYkBjYW5kZWxhdGVjaC5jb20+DQo+IENhbmRl
bGEgVGVjaG5vbG9naWVzIEluYyAgaHR0cDovL3d3dy5jYW5kZWxhdGVjaC5jb20NCj4gDQoNCkJl
c3QsIA0KTWljaGFlbA0K

