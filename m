Return-Path: <linux-wireless+bounces-10349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA54F934C97
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 13:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577B81F21880
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46312C48B;
	Thu, 18 Jul 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="nSKNJaCn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022096.outbound.protection.outlook.com [40.107.149.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF012F375
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302279; cv=fail; b=BTbQBkNoP+eADa1Y0ACu7/uTMfjSUp8s7ex19HOi9bBWreFS8Wz3hl2saAZ0QlTRyno8Wk3idfavst7Off3jzKkdQOToHkLM3XhzapB0BDb81qEYStOlpSF1/e86z9nunTO89isQLxhpxccxOEIY55HB3955/smyXqo6FEGa9js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302279; c=relaxed/simple;
	bh=GohD6DCqDWqiDTUVWLEYz+Iy7HBH8b6cM2j1bfZIzQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ss2ubSFT1GZCLvYaoFBEznii1OQkNYCYyw2ZCTdfEweO5I0Jfw8Cyr8ReBB1M+sFDi32+MxojNWZm7MciXyYuZm5qPZ6Lia4z7n9GGqLHFTwufbWIJw0Ytif6U/l1ANj7rL5MxGC4KnKFYEj176/aXm98Cn6DYN0qkXOyEC9A5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=softing.com; spf=pass smtp.mailfrom=softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=nSKNJaCn; arc=fail smtp.client-ip=40.107.149.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/QLWiUyAWlTW8OYq/7kqtdJENE8Z9I7WmrU0rnMR/h5m4DrD3ubec8Q/UGpPApBslNE/K7SP99ESvGLYs/gHtCg6mErxwPdU8oO6gcNOamAtlPXvY9b92hu4ZQ0EWUw5atoSSH4AFWxa+SPNTTgFhHxMxlGcQXpfd2RrrGjJLKdZouSZ/z7wrz6JriKBkVl7PhuqSz+Jo0nrURw5HBONrflSdzuA0ExN2bssdyoJ0/I1IkqrvONN8AY3+Zcr4CjO7fUqt7FF81VKi2h4q6Oe7SEmbj5+fXZn1rOMFyecZSRhN5Fa3i8cP4oKGIi0bH+5ZfrZBbIVdn3pc9n6JCjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GohD6DCqDWqiDTUVWLEYz+Iy7HBH8b6cM2j1bfZIzQU=;
 b=EY/AWIU30ycME388OPAYN6+fNghh79wTZcXdlXBs8+pvup6fRRV6yQkkLz0R7Ir4tmpf/iBtiUC+w9twLhTziOEH4erCFix1hEvILhI6hBZ5oL1j50vgZ+icuw8kKbX1th6ZewPI/k6fVisFn4EsHkkdzacH6Uir52h1CfiNdMiQeNEcbLmejS9ZMC1MqgcXO8NbI6UauoooG6vEkN8m9TWYC376P/fTAlPOk9nC1NUTrJ8XUsEPV2s8cONdgmwg6MR/3GiP0az6/MbEx5Vs0dfDT8JZ5bjG4Vn38gs9zq2+fP8aUeUwWYcX7IJjCbo3BAF62Anh+nIIuNUs8Lmpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GohD6DCqDWqiDTUVWLEYz+Iy7HBH8b6cM2j1bfZIzQU=;
 b=nSKNJaCnqAuHgq02IdK3ALJ1ulYYtbKtBFHnrsmmvELr8pJdSER7VU//5q6DoEcKYRaDK6yplGC1Q2LN8ToOyQv/gJYC6AyF7mpoL0PTImd8kwx5EkVwpJxlMZVRM+q0+/bOrvOs2DfMIC7bUSFjrg28G50nYmQkNBTNGEKzzzJMvt7kaT+EiK9AMKcHVNosEidQGR3MTZAbNRx1oRbsEpmSZLSD0YRWdZLCltlBvHeYAcfLguOGJ2T9wvOVBp34GF6ycPTNU+/mN9u0hpHyE7ViMcy77vt8yl888unmJQwsX3yTEEaG/b5OOF4/5o0UJXeitZgvKN0YSxjdtJ26QQ==
Received: from BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3a::5) by
 FR2P281MB1558.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:89::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Thu, 18 Jul 2024 11:31:11 +0000
Received: from BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM
 ([fe80::138b:9d6c:e70f:8ea2]) by BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM
 ([fe80::138b:9d6c:e70f:8ea2%4]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 11:31:11 +0000
From: "Jesuiter, Henry" <henry.jesuiter@softing.com>
To: Ping-Ke Shih <pkshih@realtek.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "Le Suire, Michael" <Michael.Suire@Softing.com>, "Sperling, Tobias"
	<Tobias.Sperling@Softing.com>
Subject: AW: Performance of Reassociation 
Thread-Topic: Performance of Reassociation 
Thread-Index: AQHa2EeueyCxNvdWakyDpuL0/ysvurH8K4CQgAAv1i8=
Date: Thu, 18 Jul 2024 11:31:11 +0000
Message-ID:
 <BE1P281MB22102E859A8EFF4475843FB89EAC2@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB22104B386701ADEEE1E741269EA32@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
 <ef8f3c47b3264aedad776ff248fa635d@realtek.com>
In-Reply-To: <ef8f3c47b3264aedad776ff248fa635d@realtek.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2210:EE_|FR2P281MB1558:EE_
x-ms-office365-filtering-correlation-id: 5710c950-eb03-4851-8ebf-08dca71d204f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T040UElzZ0tXSFVZMzJKN0xLOGF6YWtVRjJOdzdTSTdBRFBGSmZrMktUaWQx?=
 =?utf-8?B?c2xrVHhuWlEwRWtFaG5QWk1DR3NnVkRwejlYbTVsNGdMVGdnL2owejgrNHMx?=
 =?utf-8?B?QzFCTU5WY2d3S0cza3ZXN1Z0anlHN2RYZGNNWnNBbWxTWjdCcUNiNDRWMmg5?=
 =?utf-8?B?d3NyNmRpZHRCUytOdnFoL1VLOVpGN2pPakt4Z01rUDRkcUhpZjlmUnp6NXNw?=
 =?utf-8?B?WlpxamY4Q3JUdk9GQmRSRGZMa2Jick0zYjBkWXQ3dXluaXliSEYzSnZSQlpD?=
 =?utf-8?B?bWhRQktOT3VZQzQwV3IvcVE4QWM2RThEZ1VoYXlBS25RSEJEdGpCWUNqS3pi?=
 =?utf-8?B?MFR6OXdaMkpISk9XVTN2NUV3cFZBT0F1QzFWWTRXS1NWVVpTYnBQT1VnbUZt?=
 =?utf-8?B?enNsN2JpMzRlY3JpZHJaM1B4a3IwUGxRZGZSR0RRUjVWY3dXZGJsWGpQaGhj?=
 =?utf-8?B?clpYS0lmYlo5Mnh1eVJZVmZESndHcWhsWXlhQi94T085a0xDeVM4eENTNzNr?=
 =?utf-8?B?ZzFjcFhVQlBkcUcrWTZmRWptamdBK3ZwYjV1WSswQlRGd0VEYjUyVUNEdThl?=
 =?utf-8?B?WXBLZzFvT0pQd2NMR2FLdWQvRmIwWG85aVhkZGI3MDZYbVJoZkdGZCtjRUhK?=
 =?utf-8?B?azAzWGpwc2puSnduZG5oMlF0WStMa3ZHdFJsaVVWeGJNSzQrSkZzZHdvejdV?=
 =?utf-8?B?anR0YTB1NXoraTNqZytlS2dqZjVFVkJtdzY1V083TFdmbDU1ajRKaytnamtn?=
 =?utf-8?B?eUIxZHZPUkcxMW5uaXU3cm9nL1JRd3MzS1JWZGNKbDNOTHpzalllSFZ1aUli?=
 =?utf-8?B?VUJKSHMrOHNiYmFHektTUmI2T0ErZDNGN2RCTUdHaTZzcTc2d0dKUWsxblA5?=
 =?utf-8?B?Vm03V21yTzArUEl6N3p0a1lVT1E5aHZpUjY1OU1nVmdUWnZmTWhndCsxbTZR?=
 =?utf-8?B?ZEh5S0pTS1lSbW03YVFsS3psQVVOMXYwUnJlWFNoa0ljNjNwRit5c0lCRUtV?=
 =?utf-8?B?dEtLRjFmVTczaTd3ekZjVTQ0Qmw2TUJxbXRKSHNjVU52T2xRRlc4NW9lQ014?=
 =?utf-8?B?MnYvSlBwMkl6UzJIbnd4M0JKUms5U29URXFCYkV2MXNNVVJ5dXlCRVp0VzhI?=
 =?utf-8?B?T3FhbXA1RmFVRHhlb2drcFB6WUpmOEcwcFZkQmZJS1RXQkZFZDE1ODJKUStW?=
 =?utf-8?B?UWUrMWJvTmQ4TFhSbTN4TTRFQm1yM05kdnF5T1BZZVc2eUNTMFROamcyOGNC?=
 =?utf-8?B?TmxvOTlieFFMRER0a1BOc1RRVDI5M2JxRVpXclhDYU5QUDJTMGRRaEpNY1pv?=
 =?utf-8?B?bis1ME9xV21hZlBTczdDdXA2VmhKY05zOUtienpyV3duRmxxaUcxZm1pQVB1?=
 =?utf-8?B?b2NEVk90SmU1TTZ5NlllTkJLTUVXRG4wd1J2L1N2Z0FPRGFUSUJqRGlCTDNY?=
 =?utf-8?B?ZXZQb291MTZYQXZXVVBhcjJ6bzhSZHNOMTNrQWZSZUc1VGZZVnVCSE1PQVNa?=
 =?utf-8?B?a2RnbTZSaHRESjBMQytmbXlOWVlVeVJkRGtjNkUxVEtydjd0RzNSMTFLS0N3?=
 =?utf-8?B?cXUwTFNMVE1EbklMYnNKM25rNTg5U3hyamJVL1VRTjVxc0NScTlqRVdVMnQ4?=
 =?utf-8?B?NDlRZjI5VkdaL29JV1Zqc0hsamxvUUhoRU04cDV1bStSdmJuOXN5ZWwxdnh0?=
 =?utf-8?B?YUN4WVRrbUxiR3FPYjhLWmxSa1N1SWNSWlVsakJjSFBHN3d0eGhnM09Ldmlk?=
 =?utf-8?B?dGNENGduWnhTSjN5WXpDMzdzZmxVZmw1UlArWlZvblhRV1dMVk8xaFA2V0x6?=
 =?utf-8?B?RHk1QkEzWTNhQTB6Z3U5WVkvb29VWlgvelNYY0RZdlgyN0ZaZXlSSHkxR3FV?=
 =?utf-8?B?a1MvM3R1V2t3bzAwMk5xVTkxVS9XWEJTMEZBdXlqbDZYa2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXI3MWZuZkVsY1kzdWVMN0s4T2kvTXZnTC9Sb1EzMTA1Q3NpN3duYitIanFO?=
 =?utf-8?B?YzVLeitWRTErVVEwNWJvMWxFdWRCTVJJT0hUdSsxSmdqQlN2dks1YzZYY3dt?=
 =?utf-8?B?VlIwY1VIWjhtb2VqQ0Yxc1dQaGF2d0syMWJ1YXJYR3IwWVJsUUVlWFBZcWxN?=
 =?utf-8?B?VXY3cE16YVcyTDNSL1dxSE5ZZnlibTdXTGllUUF2OXByWUVkTmFBSitFUW1J?=
 =?utf-8?B?TGpibE9udTZRS0dqbU1VNEhWejhWMXp3Nkg4UkMrZzVSN0pFREw3ejNWckVU?=
 =?utf-8?B?VzhRQ1NNdUNWYXZRSW4rOEl2RThZSjQwVFIvQ0NLcmVmZS9jNzJOaVVFeEpu?=
 =?utf-8?B?RGsyaCtQRnBYMlMrblVHdXFpSG5IaUc3aVZzYyt3TDZ1dFQrQ3RIV2VJQVBW?=
 =?utf-8?B?cFJqK2Mwd2x6WFdNUnJGSW0xOUJ5MjdlK0t1UUJuZXh6aUdObTE0cWM3VnFR?=
 =?utf-8?B?dWo1UVNJNHVDcWNRb0pDZ3NuVllrcEJkSU4yYURmMTk0eUQzdU5VZDBjR2sr?=
 =?utf-8?B?dGEyUWo2UVZIMjl3eTZQZ1A2Z2R1NmNDWWt1d1FVU1JCeUxhclQxZnIzbmx3?=
 =?utf-8?B?MXAzaGZmSm1MWHRXV041YVVvWG96eisrUHVtUUV4MUZIRTFUeEs0T0cvUGZt?=
 =?utf-8?B?ZFBxeU9LZmlML2FoRlBsY21hN3RuZHU0US8zZzlWbEZSL3B5cHgvT2hYZ0FP?=
 =?utf-8?B?VUhVQzRTSThTL1QrVHFkYXA2c0xlMHdxRjFHVCtJM2x1Wm9BNjNJa3ROMUNE?=
 =?utf-8?B?MUh1ZkJPd2dwVGRUL3NjdUZ3VUl2TkdtQklZVnNrOTIwU0JSa0IweXE0eDBl?=
 =?utf-8?B?alB3QlNMMEZtb1NVQzdySHRwSzBOWWRoWjlDd3NvZCtDVmZ1ZnI2NGxWSFhw?=
 =?utf-8?B?Nkw3aGlTQVd5bnNWWjdaQjJwOU5YRWhManVsZzdQNXVYLzVCUG8xMndBT0FD?=
 =?utf-8?B?Zm5aejNJRWN6aGVtYkxjNXNZQ29UTEFoWm82M2g0Tk8wYVFhZ1lSNEVyZTBB?=
 =?utf-8?B?cFJVbldpQUtrSEhWQVNGS1UySmJMUktBQXpmODkwSkQ2Y3FiSk1NMmZ0NHg1?=
 =?utf-8?B?WUFZQy9IdnM1V0o3aUVGaG56SEJNMjV5dzBITlVOWi84WEVrOXhWREwwdWlB?=
 =?utf-8?B?UGNoclNmVEJqbFZkc0hoaEpuMTRwdm8rSFh6QmxoOHM3S0ZBNmNjbmJYOHpC?=
 =?utf-8?B?OTdxNDIxUTk3WWFPL2c1OW5nOUFicmYyTndDc2dzSFlzWnZQREdTRS9tSjll?=
 =?utf-8?B?UU1CblVvUENCZkx1MS9paVJuNjNYNTJnWW5pdk9YTWV3NnYxSDFIVHdlVEE0?=
 =?utf-8?B?RWlDMTF6aEtTbFYzdm85ckNZY0pxVVRrem0zNWJqY3dSSTRReUhvajA0V2xj?=
 =?utf-8?B?RG5zaUY3aVozUkR6d2EwU0l5VWlnamxvS0dlS0g4RXp5S0tPRDUyQVozNnhh?=
 =?utf-8?B?bmZ3ZjJNR0plaHFBRWloUEZqaWxIeG1mVDkyZ0REYmdPcU90akNKeUdvT29r?=
 =?utf-8?B?RGd5L3FBV21HNUpZZW1UekRtaVBZUlQ0WlhmcUltTThDSy9QSUI3NkJnNTBo?=
 =?utf-8?B?N2xDVDFqc3p6UXFBOXQ4Zzh6cFQzTkJxenlwd2dOQllzWnhHTnZaaTJkcGFr?=
 =?utf-8?B?NFpVQjk2NEErY1F1NnpuZ2pZUm9sdFFpNzJtNnFuTlBtLytSeUZ4UDhUMXUr?=
 =?utf-8?B?UWxQdmhqeHhzT1lMTHU4YWY4aTZpcVlSKzlBU3RHUHliYU16cndsTHp1MHIz?=
 =?utf-8?B?L0Era1hGRlpIa0JHUlM1ZTFXQlNKR3A4ZEUveWsvdWZKS28yMTVvb1pnRkU4?=
 =?utf-8?B?NG1IRE1FTlB3VWxNWUxKemlNQ1ljYUlGQTk3QzFJYlBIN1A4RVJGbktsSGpu?=
 =?utf-8?B?STcyY0M1N2xIbjU5QkgxWHNDQ1lBZHNHY1BsRzZLZHV1cU16MCsxQ3ptVGRs?=
 =?utf-8?B?dHZsN3VrcU53eThIa3IvYldGakVhNE8vYUhXVHRjQlhPT3E4ckxtQW9NUDBa?=
 =?utf-8?B?b3VaRVR0S2NzMDVYQmJPNUx0YUhmeFJTaDJldHhxbUxHYzhQL0hFU0lJeVMr?=
 =?utf-8?B?Q2hneG92Y2craUc5T0o3VGRFZkFLTWkrWkpRS0JyMEprLzhhWmtHZEp2aGVG?=
 =?utf-8?B?SXZXK0h2SnhjZ3FnN3FYcllmTHArVXZEMWx1NjNVUitneGRCRFl4SlVEbzNu?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5710c950-eb03-4851-8ebf-08dca71d204f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 11:31:11.7293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+4SFwFPLndISmnQX4yAoNsWxz5ItGZdcye9LxFQSvfTH2FrHrcV4NmZQNGV9/3Ty3tcQpWle/6YB28fPlrTL6IWr2B7jy37j7nFD5h/UQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1558

SGVsbG8gUGluZy1LZSBTaGloLArCoAp0aGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGFuc3dl
ci4gUGxlYXNlIGZpbmQgbXkgY29tbWVudHMgYmVsb3cuCsKgClBpbmctS2UgU2hpaCA8cGtzaGlo
QHJlYWx0ZWsuY29tPsKgd3JvdGU6Cj4gRG9lcyBpdCBtZWFuIDQ1MG1zIG9uIGtlcm5lbCA1LjE1
LCBidXQgOTAwbXMgb24ga2VybmVsIDUuNCBmb3IgUlRMODgyMmNlPwpbSmVzdWl0ZXIsIEhlbnJ5
XQpBY3R1YWxseSBpdCdzIHRoZSBmb2xsb3dpbmc6CsKgICogYWJvdXQgNDUwbXMgZm9yIEtlcm5l
bCA2LjggKFVidW50dSAyNC4wNCksIGk1LTczMDBVCsKgICogYWJvdXQgNjAwbXMgZm9yIEtlcm5l
bCA2LjYgKEJ1aWxkcm9vdCksIENPTWkuTVggNgrCoCAqIGFib3V0IDYwMG1zIGZvciBLZXJuZWwg
NS4xNSAoVWJ1bnR1IDIwLjA0KSwgaTUtNzMwMFUKwqAgKiBhYm91dCA3MDBtcyAtIDkwMG1zIGZv
ciBLZXJuZWwgNS40IChZb2N0byAzLjMuNiksIENPTWkuTVggNgrCoApGb3IgY29tcGFyaXNvbjoK
wqAgKiByb2FtaW5nIHRpbWVzIG9mIGFib3V0IDEwMG1zIG9uIGFuIEFUSDlrIG1vZHVsZSAob24g
YW4gb2xkZXIgSFcgcmV2aXNpb24pLCBLZXJuZWwgNS40LCBZb2N0byAzLjMuNiwgQ09NaS5NWCA2
CsKgCj4gV2hhdCBpcyB0aGUgV2lGaSBjYXJkIHlvdSBhcmUgdXNlZCB0byBtZWFzdXJlIHRoaXMg
cm9hbWluZyB0aW1lPwpbSmVzdWl0ZXIsIEhlbnJ5IF0KV2UgYXJlIHVzaW5nIGFuIEVtd2ljb24g
V01YNjIxOCAoV2lGaSA1LCA4MDIuMTFhYyAyeDIgTVUtTUlNTykuCsKgCj4gSSBtZWFzdXJlIHJ0
d19sZWF2ZV9pcHMoKSB3aGljaCBpcyB0byBwb3dlciBvbiB3aWZpIGNhcmQsIGFuZCB0aGUgY29z
dCBpcyBhYm91dCAyMDBtcyBpbiBteSB4ODYgTkIuCltKZXN1aXRlciwgSGVucnldClRoYW5rcyBm
b3IgdGhlIG1lYXN1cmVtZW50LiBTbyBpdCdzIHF1aXRlIHRoZSBzYW1lIGFzIG9uIG91ciB4ODYg
TkIuCsKgCj4gSSBtZWFzdXJlIHJ0d19jaGlwX3ByZXBhcmVfdHgoKSB3aGljaCBpcyB0byBkbyBw
aHkgY2FsaWJyYXRpb24uIFRoZSBjb3N0IGlzIGFib3V0IDE5MG1zIG9uIDJHSHogYW5kIDVHSHog
Y2hhbm5lbHMuCltKZXN1aXRlciwgSGVucnldClRoaXMgaXMgdGhlIHNhbWUgZnVuY3Rpb24gdGhh
dCBpcyBjYWxsZWQgb24gcm9hbWluZywgYW5kIHdlIGFyZSBleHBlcmllbmNpbmcgc2ltaWxhciBy
ZXN1bHRzIGhlcmUuIFRoYW5rcyBmb3IgdGhlIGVmZm9ydC4KwqAKPiBUaGUgY29zdHMgSSBwb3N0
ZWQgYXJlIGhhcmR3YXJlLXJlbGF0ZWQuIElnbm9yZSBJRUVFODAyMTFfQ09ORl9JRExFIHRvIGF2
b2lkIGNhbGxpbmcgcnR3X2VudGVyX2lwcygpL3J0d19sZWF2ZV9pcHMoKSwgc2F2aW5nIDIwMG1z
IHRvIHBvd2VyIG9uIGhhcmR3YXJlLgpbSmVzdWl0ZXIsIEhlbnJ5XQpXZSB0aG91Z2h0IGFib3V0
IHRoYXQgdG9vLCBidXQgd2Ugc2VlIG5vIGVhc3kgd2F5IHRvIGF2b2lkIHRoZSBwb3dlciBkb3du
IGJlZm9yZWhhbmQsIHNpbmNlIHdlIGFyZSBub3QgYWJsZSB0byBkaXN0aW5ndWlzaCBhIHBvd2Vy
IGRvd24gZHVlIHRvIHJvYW1pbmcgZnJvbSBhIHBvd2VyIGRvd24gZHVlIHRvIG90aGVyIHJlYXNv
bnMuIFNvIC0gc2luY2UgdGhlIGNoaXAgaXMgcG93ZXJlZCBkb3duIC0gd2UgY2FuJ3QgwqBqdXN0
IHNraXAgdGhlIHBvd2VyIHVwIGhlcmUuIEFueSBpZGVhcyBhcmUgd2VsY29tZSDwn5iJLgrCoAo+
IEZvciBQSFkgY2FsaWJyYXRpb24sIEkgdGhpbmsgdGhpcyBpcyBzdHJpY3RseSBuZWNlc3Nhcnkg
dG8gZ2V0IGdvb2QgcGVyZm9ybWFuY2UuCj4gT25lIHdheSBtYXkgYmUgZGVmZXJyZWQgdGhlIGNh
bGlicmF0aW9uIGFmdGVyIGdldHRpbmcgY29ubmVjdGVkLCBidXQgNCB3YXkgYW5kIERIQ1AgKHJp
Z2h0IGFmdGVyIGdldHRpbmcgY29ubmVjdGVkKSBtYXkgbm90IHdvcmsgd2VsbCByZXN1bHQgZnJv
bSBiYWQgUkYgc2lnbmFsIHF1YWxpdHkuCltKZXN1aXRlciwgSGVucnldClRoYW5rcyBmb3IgdGhl
IGNvbnNpZGVyYXRpb24sIHdlIGhhdmUgc2ltaWxhciBjb25jZXJucyAtIGVzcGVjaWFsbHkgcmVn
YXJkaW5nIHRoZSBFQVBPTCBzdHVmZi4KwqAKT25lIG1vcmUgcXVlc3Rpb24uIElzIHRoZXJlIGEg
d2F5IHRvIHVzZSA4MDIuMTFyIChmYXN0IHJvYW1pbmcpIHdpdGggdGhlIG1haW5saW5lIGRyaXZl
cj8KwqAKS2luZCByZWdhcmRzCkhlbnJ5IEplc3VpdGVyCsKg

