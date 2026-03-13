Return-Path: <linux-wireless+bounces-33178-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCc6MvCms2nOZQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33178-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 06:56:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78D27D818
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 06:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A0030A1874
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 05:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD73321A1;
	Fri, 13 Mar 2026 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OR4/ZG3e";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gV1l/RIA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81E31E84C
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381329; cv=fail; b=Idk0AQ1qRDYZHcjGlTu9jB4x79J/Sj7odOpAOnZKCzS7WxVvsLzro5UFt7S8NlME5Cm7MLn9uueMuFkfv8tZPJ4cykcWMglF+ZpmX0NOx2szp2mOOSdFBjOcOmxIUo8K5+/eIw9c/NPHxxavE1+yduVfbbICKHp6MVhER7Qdv9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381329; c=relaxed/simple;
	bh=vtEncJ0wfcJUrPA9e52gb/oFwTlT9HzPaR+B5YraLTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lW2YbHnJ0rcd92KXECRkNooQksCpFEXBWjJGSaC3lQ7zfWtIDaHfSgulLX9X8+kYlhFxB6TTvNAGwGIwcvnFfu/eL6EQx13a2hN9IOLLe7ncq6csCaBRB5zhUQr4d1gxXtEPQ3cSjR9QEEZO7DH1HkvmxiMz2HJGaQdAvPROdkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OR4/ZG3e; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gV1l/RIA; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 385340d61ea111f1a02d4725871ece0b-20260313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vtEncJ0wfcJUrPA9e52gb/oFwTlT9HzPaR+B5YraLTw=;
	b=OR4/ZG3e8kAPERjYFNnkVMI7AiLTfni4nYnqeLZ9I7H7FaOJwQr05/P111+X8NiL0KsLsW7lB44zncV4lc2BGIvjHp2R8WRNQcck3n6gfbJAearBTPp7bQCA+2E5K0fgHauEsLkkANf7hcP3PGOx1jnc5V9azrast/BmY2Y8GDM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:31448e63-a20a-4f1d-b79c-fda16cc39b41,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:f4abacd4-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 385340d61ea111f1a02d4725871ece0b-20260313
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2013942342; Fri, 13 Mar 2026 13:55:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 13 Mar 2026 13:55:19 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 13 Mar 2026 13:55:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxCdqG+s9vK00jEHNDAKWcO1a/TyyjsvupeFt2sWNZhMv02aQuhLwWJ8Q5sNx7xN3q3L6wmeaRWElhm87ioS8Row0ax03j3R3BSBwmWKEajlCawF09O9o5/w5RA8mTP5KczW4knO58wfoCvHXYYdeooHLlT6U5Jh2neTIimC6tIoqHmf7ZUW4CLl95L7L6gMMcXA/TvKK9WGgHsu3s18VnhNkGf+VOOEIgteVuxh00D4Y7uP7I1cdhiYxCIREB+TOCzVkfsZgbbS8d46m7B2LKwfBOhMfeqQswLOJNmBGc2wxw+VrXzgH7tzTNfMrncw8qqecSAoJpueZXcR7PluwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtEncJ0wfcJUrPA9e52gb/oFwTlT9HzPaR+B5YraLTw=;
 b=YbaaetViDpm3MqyU8RlRxVQHJeDX2mihrGso6jPqVxJiySWhIKT1LWxmBJe7EBL34mqVprDKfgbSfbnI4mbSG81W63FlVA6tZFK0v36QyUMlc7VAVzqd+YeDMqq6eVglAmOGu9MXw5cqe/fCP5VLHixhYe3znHz5Xpy5zTT/eajscvW1pLqyjG/HcItAh475qWEJdOR6PBSi+lJU2Gh2zkfAgFTxizWll/oXXZKj5N1+k7QLRgset8zvtRvn+u17BsmQsFlCL9TgZ53RJMvmE0wIP9L4otRlv7o0477sWakvq3/n1X1OhAuVoDMofb4C4PmCkqmcY6Cn0y7MDstZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtEncJ0wfcJUrPA9e52gb/oFwTlT9HzPaR+B5YraLTw=;
 b=gV1l/RIApxjdYS1JBLKr3pzED7jW83kCMt3K8joLcC5wtAJwIHZCzt4MOJIcqZlK+vt6whrj57BwGy/MVYKs9R/MPSq3qcFnrQ9y5hSfm6GvgyAMSAjcTVFgwI7xKkHttL2j8UnEi2DoHI91qOUkP2vLpAYudUj53Zyx0+Yv3rM=
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com (2603:1096:101:47::9)
 by TYZPR03MB8691.apcprd03.prod.outlook.com (2603:1096:405:aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 05:55:17 +0000
Received: from SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::6990:9922:41d5:1c6c]) by SEZPR03MB6468.apcprd03.prod.outlook.com
 ([fe80::6990:9922:41d5:1c6c%3]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 05:55:17 +0000
From: =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>, Ryder Lee <Ryder.Lee@mediatek.com>,
	=?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= <Money.Wang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= <Evelyn.Tsai@mediatek.com>,
	=?utf-8?B?U3RhbmxleVlQIFdhbmcgKOeOi+S+kemCpik=?=
	<StanleyYP.Wang@mediatek.com>
Subject: Re: [PATCH mt76 5/6] wifi: mt76: mt7996: fix the temporary buffer for
 calibration-free data
Thread-Topic: [PATCH mt76 5/6] wifi: mt76: mt7996: fix the temporary buffer
 for calibration-free data
Thread-Index: AQHcsgbOdSb89M0nu0W3IFv+gHyUS7Wqt72AgAFAIwA=
Date: Fri, 13 Mar 2026 05:55:17 +0000
Message-ID: <7c815cbffec061ab7f7102d71ff14a774dfce456.camel@mediatek.com>
References: <20260312095724.2117448-1-shayne.chen@mediatek.com>
	 <20260312095724.2117448-5-shayne.chen@mediatek.com>
	 <abKaN35p0J67rMOa@lore-desk>
In-Reply-To: <abKaN35p0J67rMOa@lore-desk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6468:EE_|TYZPR03MB8691:EE_
x-ms-office365-filtering-correlation-id: d26a2f65-b514-4b3c-21a3-08de80c51a65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: fJQK/mi1npqzzjeCQI3lt0Ujb5/+L6vlfwrZHROrMKgnaB9rs1nqXGovZqhJMgbHBSdzZ4Qk6O4VrF7BI6dIRnG4GmRup5zZo7qiH6Xzq1AR8iw+/X5bgD4FW/ES9xeDh1puSphuyB3fY/5WikQqlvGV5gt3Fd2rLc/ygd31C9AXQDRInMcUxXwGVeQcQAXWXai+MPm0gwnqsiRe7+ae+GBYSfmcGD8uOrr1V7myg/W71jQh3IXfBns/8nKa/lmJAlJwP/Yd5t/7yw5I3RQRutqxXQALbI3vhersb172F0Uzhs0YE97FRGODD2uT6ZCdmnQYtJJx4QS8C8RTnubDWl38RBgnJaY9yVOwiGjZZ2PMkMVqmKp8Dv22kGEZmIlc30ZEz8z1OOnEycnnAUMnvPuG1PzRjikiFxI7hRUNFTJRl7u/8TFjbe9az2UGmXJSSqJNAVdZisLexBccJ5jWCRmDk1nKaYJbmGuQCs61yLxIss7/Ix2vTqtdPTnT8eWovq/MnTscePvXXeS9ZEbx9hTHdEWE7FIKe1CtI+328+2ipKGqNdrvDoleqBKjJm+8QD77iPlqNq2hILzdEn/JGbEyHMfBhDn6o4I5XaDNukh21yEWTZhzpiSJoq7R1ObZNtcWGJI3vXSfLo6NHTUL33EbZhzURHyZthlc37BXATvZ3WnjOdYrQF9AiYIntm5q2DuXHw/X2geiH9gg2GrLWb+Fcm7MCJr6W/Fo8i6VoEOwdvXijA3VhZ65lOxx31Ovyacyuqrwfa/Ou/e5RXTlnjB6yyTsW+MH+sZzqBRA6O8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmVEVzY1YXlYWnpyYWVhSjA1V1BZNXExTDIvWFFDQTJHUk0vVFR2cERUUFZr?=
 =?utf-8?B?REc5VEVkelVzWnhvR1NBa3BUWW5kMW9hTUJONTJUR2F5Vk9oeDMzdEtPUDNm?=
 =?utf-8?B?ZVRUWEIwUnJnQk56TTlMdVZjUXJvUTZ1VVk1aW1EZ2VuUWFERVl2Q0pjcEtQ?=
 =?utf-8?B?QklxbVlRenppc1NwM2I1S1RQaDhXdTNyK24wYXhXNHlYSkVsd1kremtudGpu?=
 =?utf-8?B?V1NOS2RNQkI5OGNPRndIcXhTa0hhaGRSK0EzQ3h4SFpjQ3NCV0NGUndHUS8z?=
 =?utf-8?B?Sk1PNnYveVpsbUFSN2ZwdDI2NnBvNnBtNlJLNXVHYUdBcFZoeFRpaU0ram1j?=
 =?utf-8?B?MVJoTzVvUzVuS0tJcC9EbVBxTFBlS1BqOXBxMDhxY1VNSDJLV1NERzRjcm84?=
 =?utf-8?B?Zy9BMkx1bkxvWVJCS3E4U3RXTitVemtjWWJWcjBSamRqOXZwbmFwRjF5bFBH?=
 =?utf-8?B?L2IvWERvVVJWT2QxVmVkUlpwcnlvVXdMcHNuS0dFeUR1a0pBZm9CQi90enFP?=
 =?utf-8?B?S0ZmZlNHMmVrZlRNb1NESHhhaUNSdzRETnhvQklFSytBOU9rRmdqeWdaMEti?=
 =?utf-8?B?bC9Vc08zN1pHMVJMcjlYNXJWODRkb3o3K2VMdjBWamlneDBCcjFxcHg3Z3BQ?=
 =?utf-8?B?c2J3SG5kT2hkSTRvWkRnQ0NoOEdkRUUxdWxBMW5idklESEhOK1gyOFN2S1RN?=
 =?utf-8?B?K29pOGJ5NHFFSVRNNEFnTUxtTkswdVNpWmVET3ZaeGwrejlUbE03RExEeVRo?=
 =?utf-8?B?UUpzZHdwOHBJNUFwUjZnTEl3MHlvQ0VmR25naWx1aU9tczVhUWRRbUdxWStj?=
 =?utf-8?B?U21BNkVaay9XMUg4c2lod1IwQW40blIvdzhQbW5sM29jQ2gyemVoTUVuSjl3?=
 =?utf-8?B?SVlVNjV4NHVLV0g1T0tDWVJINGxEbUd5N1h0MWIxMHFzcW16c3R6R2FSRDh4?=
 =?utf-8?B?Y1VzRTREWGdpblErTFpxak4zVXVhaFpCME4rdXFqK0UzMU9sQUdjY0ZvR0VF?=
 =?utf-8?B?eVZMaTVEeEFkWm9mNHExWXEzNk1OeWxhUUQyZWxHVThVandNb3JTYXoxMXhK?=
 =?utf-8?B?emp5ZHg0WGY1d1JXbUJyRXpvYVVpMXhJOVc4VGExOGZjczVFajZoK3d0SXpk?=
 =?utf-8?B?Z1cxY3VqTUtVb1lsdU5ndEFSVFBKUE0rZUlsaG41eVlwcXo2NHhXQlBHMVNC?=
 =?utf-8?B?dG9MUlFaNDFIYmFsNlh3QWxiSlNsejZhWTU1SFhPU0tvVGd0aUEvSWRzcFkv?=
 =?utf-8?B?dmZZQk5lMk51d2tKaFVxRnA0Rjd2dkVoQ1pkZWhqeDRNMmZWblNsRE11SWhS?=
 =?utf-8?B?dWRIbE9veGFXN1d5d3JnakNHbSsxMkdSVHJNWFdTbkpUeTBGa1h6dGhkQkYx?=
 =?utf-8?B?L1VRSVJnQkVWNkUvbjgvUFNhc3Q1c0ZXUlZQZ0s1QWw2Z0VIMUtnV2NhQXdJ?=
 =?utf-8?B?U0JTWjhsdThVRmlGMTgyUDlWNmpCbzJ3enk5M0RTZzFpVGJBSlZjcTJuTU95?=
 =?utf-8?B?VTViSUl3TDliWXFaYWZIeWp1TmFMQzB0dGdrY1FlNjB2bFBPNnpyWkVVZWYx?=
 =?utf-8?B?OEp2eVNDNFg4TUQyenhld3hXakYzTU13eDNHdkFhdWdHVzREN05KVVZrTk1t?=
 =?utf-8?B?ZzhESXhWcHZnVDN3Z25aWXRSVDBLdjV6MGRCYmkxekw1WWttV2taMCt0LzYv?=
 =?utf-8?B?V2hnRVNUN0tKZDd5Qm5GdHRsOHRNajNWTDQrZW9mK3BDczRHT0lWbzFSaHAr?=
 =?utf-8?B?SUNSZmI0c1pRaGZ0K2dtU2FTVEovNGV2a2FaMms2dVI3aFdNQ2hVSmFJTjVK?=
 =?utf-8?B?blZEZVJWQXkvY2dBL1NWeGVWOCt3cnNmTHZPL0tYNVhPdnU1NG5vTUtsN0RE?=
 =?utf-8?B?Tk5xTTFISnNuVENzUXJKc04yaDJTTVhmK1dVaG5TYTBxT2c1NlRmUVI4aEZG?=
 =?utf-8?B?YitZdE1mNlE5dzlLdlR1L0t0bVh1aForbmNRcEhsQnc1Y08raG1heFpoRGxN?=
 =?utf-8?B?UDdtWjBPdFYrK3JaYmRPVjByTklCT1oxd1V4ZnhjdExOdXpwYU5KM3NGUGVa?=
 =?utf-8?B?SW9CSE0rblBVWmt3b1dLZ1JNcnlnYnJkSHVPTVVzZU05bmJucWRsYWFkSWZS?=
 =?utf-8?B?WlNrV1lqUTU3VHkycndXcTNIUVVjN0RuTGo3dE5TejkwbGpvOStWNXk1VVU2?=
 =?utf-8?B?ZDgyWDRvcXpmWFFHM2FiVXpFWU92aDFwbmhvdUJrMTVjbkFnR2tSbWFuK2R2?=
 =?utf-8?B?c1FqS2N4cHlPRERQdzNEN050YzJjUUNESUJCWkdkRXdPSE5ydXFBc3I0Nk1F?=
 =?utf-8?B?T0xwcGh5R1lhNVoxZUhhNjY4TkYxVHl3dW96MjBNS2hOajRxOHVrdU0zMzc2?=
 =?utf-8?Q?9M8VzWBoya7AKnuE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BD1DEC28373FF4384513892D6EF0DFA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OBA6fgeFWf++rSOvLH67awsNmVxqojX9bv8xpft+qBECdRr8o/lD8HDS8b0RxtAgM6VxCSW6qhbLTbazqRUT2rBu2/iZokyhDGJHD02CsilC8+bw07HTJbuqAlU6JXDM28hEDqzJgQt5qiqgSAMvQRA0tXz8Bs0EZAQ3oe04PJ8HkQRAgyrQ+pPmWvgnFpdwTrHIhYZleSFlwXrsN5Ydtgn2xlaJDP2zJ3eWDAEjKs5k9WjqL8quyvCBOOgz45MFNDbH2ckhCzmjoL4pbD0OMGdKaOfU2JCvwMF4HZ1cWkbjBcZwoezvwpWWoZu4JT0dGvGH65iHOGMX1e8gAvKoBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26a2f65-b514-4b3c-21a3-08de80c51a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 05:55:17.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XH2Vf4s9mQ+PICiYUHPwVbWnDRdNkMGSEc2jEoyeITowfeIvCy3HIh80FLcZTP9UxcqfkGO03wG8OBRlAvqhieZ1c8FUaBdWM99m+15iHMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8691
X-MTK: N
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33178-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Shayne.Chen@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: AB78D27D818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDExOjQ5ICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IEZyb206IFN0YW5sZXlZUCBXYW5nIDxTdGFubGV5WVAuV2FuZ0BtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gTW92ZSB0aGUgZGVjbGFyYXRpb24gb2YgYnVmW10gb3V0c2lkZSB0aGUgZm9y
IGxvb3AuDQo+ID4gDQo+ID4gRml4ZXM6IDIyNGM3YzJiZTU3OCAoIndpZmk6IG10NzY6IG10Nzk5
NjogYXBwbHkgY2FsaWJyYXRpb24tZnJlZQ0KPiA+IGRhdGEgZnJvbSBPVFAiKQ0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFN0YW5sZXlZUCBXYW5nIDxTdGFubGV5WVAuV2FuZ0BtZWRpYXRlay5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTk2
L21jdS5jIHwgMyArKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5OTYvbWN1LmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTk2L21jdS5jDQo+ID4gaW5kZXggMmE5YzU5ZDE1ODk0Li40YzczM2Y1
MWEwM2UgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5OTYvbWN1LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210Nzk5Ni9tY3UuYw0KPiA+IEBAIC00MTA0LDYgKzQxMDQsNyBAQCBtdDc5OTZfbWN1X2dl
dF9jYWxfZnJlZV9kYXRhKHN0cnVjdA0KPiA+IG10Nzk5Nl9kZXYgKmRldikNCj4gPiDCoAl9DQo+
ID4gwqANCj4gPiDCoAlmb3IgKGJhbmQgPSAwOyBiYW5kIDwgX19NVF9NQVhfQkFORDsgYmFuZCsr
KSB7DQo+ID4gKwkJdTggYnVmW01UNzk5Nl9FRVBST01fQkxPQ0tfU0laRV07DQo+IA0KPiB3aHkg
YXJlIHlvdSBtb3ZpbmcgYnVmIGhlcmU/IEl0IGlzIG9ubHkgdXNlZCBpbiB0aGUgaW5uZXIgYmxv
Y2suDQo+IA0KPiA+IMKgCQljb25zdCBzdHJ1Y3QgY2FsX2ZyZWVfZGF0YSAqY2FsOw0KPiA+IMKg
CQl1MTYgcHJldl9ibG9ja19pZHggPSAtMTsNCj4gPiDCoAkJdTE2IGFkaWVfYmFzZTsNCj4gPiBA
QCAtNDEyNiwxMyArNDEyNywxMyBAQCBtdDc5OTZfbWN1X2dldF9jYWxfZnJlZV9kYXRhKHN0cnVj
dA0KPiA+IG10Nzk5Nl9kZXYgKmRldikNCj4gPiDCoAkJCXUxNiBlZXBfb2Zmc2V0ID0gY2FsW2ld
LmVlcF9vZmZzOw0KPiA+IMKgCQkJdTE2IGJsb2NrX2lkeCA9IGFkaWVfb2Zmc2V0IC8NCj4gPiBN
VDc5OTZfRUVQUk9NX0JMT0NLX1NJWkU7DQo+ID4gwqAJCQl1MTYgb2Zmc2V0ID0gYWRpZV9vZmZz
ZXQgJQ0KPiA+IE1UNzk5Nl9FRVBST01fQkxPQ0tfU0laRTsNCj4gPiAtCQkJdTggYnVmW01UNzk5
Nl9FRVBST01fQkxPQ0tfU0laRV07DQo+IA0KPiBJIHRoaW5rIHdlIHNob3VsZCBhbHdheXMgZGVm
aW5lIGFuZCBpbml0aWFsaXplIGJ1ZiBhcnJheSBoZXJlLA0KPiBvdGhlcndpc2Ugd2UNCj4gY291
bGQgdXNlIGl0IHdpdGggdW5pbml0aWFsaXplZCB2YWx1ZXMuIFNvbWV0aGluZyBsaWtlOg0KPiAN
Cj4gCQkJdTggYnVmW01UNzk5Nl9FRVBST01fQkxPQ0tfU0laRV0gPSB7fTsNCj4gDQpIaSBMb3Jl
bnpvLA0KDQpUaGUgYnVmIGFycmF5IGlzIHVwZGF0ZWQgb25seSBpZiB0aGUgbmV4dCBvZmZzZXQg
aXMgaW4gYSBkaWZmZXJlbnQNCmJsb2NrLiBGb3IgZXhhbXBsZSwgb2Zmc2V0cyAweDRjIGFuZCAw
eDRkIGhhdmUgdGhlIHNhbWUgYmxvY2sgaW5kZXgsIHNvDQoweDRkIHdpbGwgdXNlIHRoZSBzYW1l
IGJ1ZiBkYXRhIHJlYWQgYnkgMHg0YywgaW5zdGVhZCBvZiByZWFkaW5nIGl0IHZpYQ0KTUNVIGNv
bW1hbmQgYWdhaW4uDQoNClNvIHdlIG5lZWQgdG8gcHJlc2VydmUgdGhlIHZhbHVlcyBpbiB0aGUg
YnVmIGFycmF5LCBvdGhlcndpc2UsIGl0IHdpbGwNCmNhdXNlIHVuZGVmaW5lZCBiZWhhdmlvci4N
Cg0KVGhhbmtzLA0KU2hheW5lDQoNCj4gUmVnYXJkcywNCj4gTG9yZW56bw0KPiANCj4gPiDCoA0K
PiA+IMKgCQkJaWYgKGlzX210Nzk5NigmZGV2LT5tdDc2KSAmJiBiYW5kID09DQo+ID4gTVRfQkFO
RDEgJiYNCj4gPiDCoAkJCcKgwqDCoCBkZXYtPnZhci50eXBlID09IE1UNzk5Nl9WQVJfVFlQRV80
NDQpDQo+ID4gwqAJCQkJZWVwX29mZnNldCAtPSBNVF9FRV83OTc3Qk5fT0ZGU0VUOw0KPiA+IMKg
DQo+ID4gwqAJCQlpZiAocHJldl9ibG9ja19pZHggIT0gYmxvY2tfaWR4KSB7DQo+ID4gKwkJCQlt
ZW1zZXQoYnVmLCAwLCBzaXplb2YoYnVmKSk7DQo+ID4gwqAJCQkJcmV0ID0gbXQ3OTk2X21jdV9n
ZXRfZWVwcm9tKGRldiwNCj4gPiBhZGllX29mZnNldCwgYnVmLA0KPiA+IMKgCQkJCQkJCcKgwqDC
oA0KPiA+IE1UNzk5Nl9FRVBST01fQkxPQ0tfU0laRSwNCj4gPiDCoAkJCQkJCQnCoMKgwqANCj4g
PiBFRVBST01fTU9ERV9FRlVTRSk7DQo+ID4gLS0gDQo+ID4gMi41MS4wDQo+ID4gDQoNCg==

