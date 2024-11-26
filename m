Return-Path: <linux-wireless+bounces-15718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D189D9A8F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 16:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCAA163FBA
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A61D63DD;
	Tue, 26 Nov 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="R+mYUWFJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A61D63C3;
	Tue, 26 Nov 2024 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635705; cv=fail; b=Ssm5dPHPqXUoVbTWDHY1aQJMvZg7l/WB9MZzDeE5akxfo59tmJjhrKF/YNn6I1GElS1zjMcmZxTw+3q+Bnzap8PYkwDW/bdZXFxiio4itf9aKFhRhO3jLp1Z2XkXyO+8zB9CwCwNwzuTd+gRjWKuMad19Ny0BEkXzNRi3fjC8dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635705; c=relaxed/simple;
	bh=f/zZ6fmI14dR5g1/P6NqiIMLSC5ZmP5Uqc/l4Ig13sI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jm0JxuwG6mkVgnMWWZ/bkNTTS+gb9I9aQWpy0T6gDaA9FjXPAmxhvpOAy3PGL00Gy/Kgbm3D65FCyfA063nHNb8ST2zaEFeYDN/dtG1XOalOk2oqTzhOeNUD+/+8IDxki6lsB3enolHD8YDOUorhpmnXCQDgdd5Tr/ZmykNxgHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=R+mYUWFJ; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEkKtiJgeYrgV65peX/hdiScmp+YfUZvnkdGSIJaKeQYImXUCp0LA6r8O3pV/unI+kJh38W7/I+42gJIxhv+eVGTwoDZxxnpHaAZUatdblAy2p4Exvg2jW2JEX5ydCSdKL7DB+ggvQMPcMvoOZmo8MhPGUqNg8D28JTgApAyd9cq75FeqkTdWOHfeNc0D9SOO+/c8QGW/hf2IWlMM3O9NT/QUe3ot62+B1qCKmjhFdbtp3scsceA/lsU1mTLVAN6xZU7ztPmZ6W/F8yvVdnlSFbBKDGCfDHu0h4Bsrjgg3tc7MYvjna6uKn25zKnxS1A4jZcUA1CpKl7owEiZ1CkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/zZ6fmI14dR5g1/P6NqiIMLSC5ZmP5Uqc/l4Ig13sI=;
 b=DKVUEQZEdlnpJYq//nImNu4HoiEsS/tOaDG0g9XdrUqePsifsH7eo0itFWmpkGxdZnMWY2Mr/Rhjxw3BcBzMt+Oq6QOoS9hH0huSohAK20vS9vBJZufOFkRV3bveSkkdpNPzey0CY0a80cSxetfMZKbyGzY4PCey5uYL4ouX38+oHCzDAt0mp9Er67/p4OTAsCSe/GIN5dBdrB3a36/M5St44JXwrlaa4UsqkEM/WfkOuYEKuRLdUALo3JX0RXdlXtbwosUSJya0/OxPiHKw8kABPVn5muJdWDwoHePE6CfDgLwoDHnAfNL/qmMc3TuNyqDdY/DmNhH5/ZweSwYLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/zZ6fmI14dR5g1/P6NqiIMLSC5ZmP5Uqc/l4Ig13sI=;
 b=R+mYUWFJ36PXl25LVgccKFrVhUBGPPSU0vvN4l0mA8GlmWI49H5SuN+dBeT0uOZAGiosm16j1GpsDXZgHYkE1oUI/SbOgHDvcQE8/oDu4+8Zdv9OMkxORrCy24Bn97aCME6HUr5ERdR0HvQZYPqPHbZDYDxQKGAkpHomQNrjJRlyPF1GDlXgcJOnnJvHaJ2LEdPmNGBVRr4MO53F7V6BDQtbLIfD3iHwjSQAaPnVHFaH7if6AyG8g231uhYONqbie0c556LeOKNao+kUmLxxhpgT2PgOsiDvQhP/GdxakptvbUn5pRHx82RVZvsHY6ObT96y70BGeOzZA+MDyZdR9Q==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS4PR10MB5648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.10; Tue, 26 Nov
 2024 15:41:37 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 15:41:36 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>, "jerome.pouiller@silabs.com"
	<jerome.pouiller@silabs.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] wifi: wfx: allow to send frames during ROC
Thread-Topic: [PATCH v3 7/8] wifi: wfx: allow to send frames during ROC
Thread-Index: AQHbP9KSRfOD6XnoWU6tYD17HfBVsrLJKbeAgAB6UoCAAA+qgA==
Date: Tue, 26 Nov 2024 15:41:36 +0000
Message-ID: <fe0a827120e25264550798e07627767148182dd4.camel@siemens.com>
References: <20231004172843.195332-1-jerome.pouiller@silabs.com>
	 <20231004172843.195332-8-jerome.pouiller@silabs.com>
	 <d8e9a080b3fa9a444e4634bcc85b22bcc1ed57a6.camel@siemens.com>
	 <1769588.QkHrqEjB74@nb0018864>
In-Reply-To: <1769588.QkHrqEjB74@nb0018864>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS4PR10MB5648:EE_
x-ms-office365-filtering-correlation-id: f1ab9e3e-5142-4567-e3c2-08dd0e30d009
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnhMTTNnZUhKdWdpZ0tWYkgyNmRxVkFGUW1WbjdlRHhTOUFaNXV2bjBmTnJ6?=
 =?utf-8?B?c3RYdkxKVk11QmZHMGl6T0ZPYjI1cmlBN3NmSzFCWlJ6bVRKRHI4NjFnQllo?=
 =?utf-8?B?NVdHL1NTRm1GN3Z1QWdWNnZ0V0Zqc2ZhLzZVb0F6cDl4NGxFbzVxWkVoQjNq?=
 =?utf-8?B?RDJ6K0dlNzNwTFFjZU1JeExPWU1lK0dTNnRRaTJ5MURRWVpYMVNJNTRQU0or?=
 =?utf-8?B?L1YzUTEyNTVrQi9tQVQwVG1MTFpoNDRjYUVldkY3a1lNRmVITEpGckdHY2pD?=
 =?utf-8?B?VFdSckhZY3ZvM2pCSG43YVY1c3RtQlBoRGxEMWFxL1pQTGpIZjQ2UTlPQXR6?=
 =?utf-8?B?eEFzYUYvVEJaOE5sNDVaNnVDWEhMd2E4eGExaFh4N2ozR3JEOTV0NmJ3MmRz?=
 =?utf-8?B?UDNhZkhUVk9hQ1NhQmE5eXZNN3htSFVzaXVocVhoUWM1VnlMZU5XVUwza2xX?=
 =?utf-8?B?b09tZzZCcTQ2L25JL0g1N0dhRHdMb1hyRDFMajJocjlvdDBMbzhOSkhqZ1dH?=
 =?utf-8?B?WTFXSzZXRHhBLzZ2M2xPVGpia3NjemszL09Qek1GdktxamVPOG5VbFIvOFdk?=
 =?utf-8?B?c1R4TU4waW0yYnQ5eUtibUVaSlozdlJ2TnZXRHBSNzVxS0srREdnM3FxR3BW?=
 =?utf-8?B?aS9ZT3dXRndNd1BpRHIrVHVIM2h2SWtrLyt3eDFicFp4UDc5cXJLZmpHVDNK?=
 =?utf-8?B?Y3drZ0p4ZWtPempiYU9KeU52L25kV1JkaEFHQWsrWDFmbDlHQ0hHWC85V2Nr?=
 =?utf-8?B?ZUtVVHFTbWZobFptanE1SjY5VTVLNVpsdzhwZUdyWFpCaTg0SjlvbUcvZFR2?=
 =?utf-8?B?VFYycW5UajdmTWRQQ290ZGk0eVlsNE9Dd2JRMXRoa0xJZlRUM29nS0tPbGJX?=
 =?utf-8?B?UE95SUJ0RzRnSWFVeU1LTm9haGJiUDh3RlZJYVFFcHVZWTRJZWMrRTQwRXdn?=
 =?utf-8?B?cFhlRUdtMksxNmtFUHlWWXlyTXBsa05yOUkydUJyazcvUkJPU1k3N0lQZ2FB?=
 =?utf-8?B?OTRyNVFQQnRRdFNYU3BLdkQ5aGRSeDFCUE1FbE8zU2Znb3pWZ2V0b0RTQW5p?=
 =?utf-8?B?WDhBc2pvWjBXWHI2NnMrYjU0L0U4aHk2dkpVeVFYNmZmVVNMcmRsNHEwcjhy?=
 =?utf-8?B?ejlQWjA2ZXMzUGNkMnRwMWxVNmhZRmpMSHFmbzNuTW5hWjVKTlZBYW5aQ290?=
 =?utf-8?B?VmdaZWd0NVErd0NCVnh1OVJZWXdOK3ZGV1p6YTdueVlOVm5IdVRXY05HYVo5?=
 =?utf-8?B?cC9FTGdGNnhneTJmSUZNOTY4TXVyNDdST0hrRzZSWlhuZjFpRVRTVU10dndN?=
 =?utf-8?B?RU4vaUozSGtDV2NhdkpaV0ZWWlVGbmJWV1F4di9NSHpUWnVEdldYSXVYSGgr?=
 =?utf-8?B?UFcwSXoxVDUraEhIQ3ZCeHZLUVpoZGlmNEpSS2tmbVlHeUxmZ21WWG5KNlZm?=
 =?utf-8?B?RVVqa3hPL1dxeVdTYUV0L1pxZU1GNnVBZmhrc2ltY1JtbWEzZE1WUXB6ajJZ?=
 =?utf-8?B?MkpzUzh0eWJoLzEwMmdDUSsweTl6d2Evbnd2WVRzVnFCbzFaUzRMUHV4OUhl?=
 =?utf-8?B?aTdJcEhIUURzRnZ4eWkzOVFzUVBidVVMOXBWTkJsaUw5MVpobEw4SnorcGRm?=
 =?utf-8?B?M1M4dGMwQmdSb3ZQU2NFRHBxMm50S3g2TnBWOEkyOFVyaG9TTDdkWW4yM3JF?=
 =?utf-8?B?K3kyZE01bzU2RTd4YStRUnRiUkVzVnJtckxYajdpTDhNdGRLQ016RU14MUZN?=
 =?utf-8?B?STR3eVNvSnBycHJZVUg5UEMyRXdHUXFCTXQxSUtrZGNJYlV6b0YvbmpHYUpl?=
 =?utf-8?Q?cIustSELqCE9JcUUTER5bpnMMlcLCSIi9sH6Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WElhbUMydkhHSjNuak9vc1kvNGNjOFZNbEt3OHQ2L0xid1BXU0FleWNmanVY?=
 =?utf-8?B?RFNlbjgzTms3U1E2MWFLTnF2WEtzZVhBc2oyUzJWQTFiYlFkTlh5bmZKZCtV?=
 =?utf-8?B?ZFhKNU5aYUZaSVVnenliS0hCbmRMVTBuaTJKMGhOU2xvL3lKK3FjNVVlZjc3?=
 =?utf-8?B?M2V4RjROOEpjVWJOckU0N0dZQmhyWW5qcHliU2s3T0xiNit3VTNOMzVIdVpC?=
 =?utf-8?B?S0xmbXNmbHdPOXJQRlZkVEFHaEE5dGNhZ1MwVGVkdkRWcEpsOHAyTEllZGZS?=
 =?utf-8?B?WDNFVElTSUZrL0VZRE95UXJTQXUxYjMyTnBzVWxkckpIYjhJOUJWM1N1SUxn?=
 =?utf-8?B?dTZtYVRsVUpWL0lQUitoTG9FL2Y3NXp0SXJPeE91ZHFESmhFdHVrZWxMRzdI?=
 =?utf-8?B?WWlhdzVML2k3cysxaTlXUGU0UGs0T3ZTalZHTm9JTTRFWVhSMjcrNWY1VXRB?=
 =?utf-8?B?MjZHYkhYMWo3KytucERLVDUvUUFXU0lCMVJWaFBvRC9NZnF1QlE3Tk1hSGxv?=
 =?utf-8?B?QWpGS2FDdjZWRzl0U0ZlVlNVdnd3NjBpMkJ3cklhelFMQ3lGZ29aZFc0STVs?=
 =?utf-8?B?SFd1aWwyMmYzZ2tJTmlBTWJua1dLS0R0NUYzbElIMHcrVitHK3l4ZUF2OE1R?=
 =?utf-8?B?NDgwWkJON1RhNE1yTEw4aHJOT2FNRDhsZmVTOFBPSzltK0pXNmpFMHdTVzJY?=
 =?utf-8?B?UndYaU5qdVlFSko4RStCRXZqM1pjM2hDNjVkSWI4NkpkUzR2VXJ1bnFkekY2?=
 =?utf-8?B?TnFZbTB3KzJWb1JoQ0hONjZjY1FwbENCQkxIOGhVT200YXFkeVNaYWlERUx0?=
 =?utf-8?B?R2oyV1B2VElPdENWZTlJNnJBN2hhWVBiMVNSbUo1QlorazhNVXJSdGtMOHRQ?=
 =?utf-8?B?V2FBOEZIKzZJeEVuV2RHSUNNYmxzUDZkZTgvc3V3YnlBVVdSOVFmbitRcXMv?=
 =?utf-8?B?ZHR5NjlOSkdmWVR3NW16OVZUMVRiNm5KakZydWNXMXQwVVVDUWhId2hRWkRB?=
 =?utf-8?B?aU12VGZaVVdSQjl5S3M4aHFpTDlxZXd6Rk9pemFDcEFTa21Ec3draFE5bzZt?=
 =?utf-8?B?U1dsZWxPbE9GQmdESThqODVFdUFIeEZYQXFaOUVqKyt5eUE5TFByMTV1L3dp?=
 =?utf-8?B?czcxOXVlY1luV3d0MlAySDZIVkNLUEwyUDB3ck1iUU5lL1BxdlJvVktuT2Nx?=
 =?utf-8?B?WHU0a0M5MjhwTyt4SmtDMklXQmQ0MkdWc2dGNW9BaVNVeC9ld1owWDdtd1JE?=
 =?utf-8?B?Y29Nb0VnazNzOTR5d2hHOXZNU2RzekxYazcxakp6TzdmN25mYm0vQWNmMkg2?=
 =?utf-8?B?UWs5SHowbjNvdEhQRjJSaVVhUUlVZ1VobldXTHZ3QmgycDR1cW0xRG1JVHpT?=
 =?utf-8?B?WGxKeDRSMS8zZGhURlZ3dDArcmtGdkZHb1lBaWdDSU1RRVpSZDlVeXpnR0h3?=
 =?utf-8?B?MUJkOUNteitadi91SEh0M3E1RThiNVlNYVJvNkNIV0pwVG02a0MxNEkrcmVP?=
 =?utf-8?B?em8xNVAvczZJSnh3dUpoSzc1VG0xVWJOTTZOdGl2dVJ2SVIxT2M3S2ZLNzNN?=
 =?utf-8?B?U3pHdU5BSGVjQk1YSmYydWY3aWFjK1NDTWswekw4NlVqeHhtdzBzUE5MeEc4?=
 =?utf-8?B?Wm1CSVhYcldCaytmcDNhYXVCWmFHMlRQYU9IQ3IxU0lDNXd4SjM4T0NmYjV1?=
 =?utf-8?B?WE5CaDBST3p2N1VJc0E2OFJPdGVvRTAvZDcrcGtJY2FNM3dkekZoVFFXVkRB?=
 =?utf-8?B?VGwrRGVSbEdwVU9hZ2VwOTJ5bExCOW5NMFF5VGhycUI4UG1iMC9UeDBGNDUx?=
 =?utf-8?B?WTVxUXE3V05MSW4xL00yRE0vRkk5Tys0MldwWGlmV3JFOVQ0Wlo1d1I2L1lN?=
 =?utf-8?B?SkMyek9qN2xaNGNRV3FhWlNNV1l4U2E0a2EzeGZFdmpJbEJCMkJFTVJkaDRo?=
 =?utf-8?B?Nmg1V0xrZEx6ZkdSVmRWQW9BeVF1QW1NUmpOcVZHd0htRFhKakU1bFNWWUpr?=
 =?utf-8?B?UktPdGFmN2t1ck9tZmxQUGtTUkZsYmdPUVo5eTVYS3dvTHlCc21hRXlWYWFj?=
 =?utf-8?B?aDJ4YWduazFxbTRBYlJyVWRCK2ZCRFhjaUdNTC9DRDI5SUhMRVhKVkkzaDc4?=
 =?utf-8?B?WWZ5YWVxaE9IUUFpaEc0NTFFdE9IOUpOVVAva1dPTnpGaHlVQWNWUlZBYWpX?=
 =?utf-8?Q?FqjkcSNVXkFzLoNKj1pTmyk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D3195CE87567E4DA93A7DEC6D0052A7@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ab9e3e-5142-4567-e3c2-08dd0e30d009
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 15:41:36.7612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kO+7A+kjlX7IG48fL0i9PrwSXu1f5vCy2pWeFUrcaF0zcKMkZJTS2d2pazRQGniNSjbQKCJlgdhO1yzbJ5WwOjOhQsoTSLRNrc1DJQ/Qw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5648

SGkgSmVyb21lLAoKT24gVHVlLCAyMDI0LTExLTI2IGF0IDE1OjQ1ICswMTAwLCBKw6lyw7RtZSBQ
b3VpbGxlciB3cm90ZToKPiBJbiB3ZnhfYWRkX2ludGVyZmFjZSgpLCB0aGUgbGlzdCBvZiB3dmlm
IGlzIHByb3RlY3RlZCBieSBjb25mX2xvY2suCj4gSG93ZXZlciwgd2Z4X3R4X3F1ZXVlc19nZXRf
c2tiKCkgaXMgbm90IHByb3RlY3RlZCBieSBjb25mX2xvY2suIFdlCj4gaW5pdGlhbGl6ZSBzdHJ1
Y3Qgd3ZpZiBiZWZvcmUgdG8gYWRkIGl0IHRvIHRoZSB3dmlmIGxpc3QgYW5kIHdlCj4gY29uc2lk
ZXIgaXQgaXMgc3VmZmljaWVudC4gSG93ZXZlciwgYWZ0ZXIgcmVhZGluZyBtZW1vcnktYmFycmll
cnMudHh0Cj4gYWdhaW4sIGl0J3MgcHJvYmFibHkgYSB3cm9uZyBhc3N1bXB0aW9uLgo+IAo+IAo+
IFNvLCBtYXliZSB0aGlzIGNvdWxkIGZpeCB0aGUgaXNzdWU6Cj4gCj4gZGlmZiAtLWdpdCBpL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgdy9kcml2ZXJzL25ldC93aXJlbGVz
cy9zaWxhYnMvd2Z4L3N0YS5jCj4gaW5kZXggYTkwNDYwMmYwMmNlLi5iMjJlYTQyNDNjMGYgMTAw
NjQ0Cj4gLS0tIGkvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwo+ICsrKyB3
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKPiBAQCAtNzQ4LDYgKzc0OCw3
IEBAIGludCB3ZnhfYWRkX2ludGVyZmFjZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0
IGllZWU4MDIxMV92aWYgKnZpZikKPiAKPiDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwg
QVJSQVlfU0laRSh3ZGV2LT52aWYpOyBpKyspIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKCF3ZGV2LT52aWZbaV0pIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc21wX21iKCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB3ZGV2LT52aWZbaV0gPSB2aWY7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3dmlmLT5pZCA9IGk7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiAKPiAKPiBIb3dl
dmVyLCBJIGFtIG5vdCBjb25maWRlbnQgaW4gcGxheWluZyB3aXRoIG1lbW9yeSBiYXJyaWVycy4K
CnllcywgSSdkIGNvbnNpZGVyIHRoZSB3aG9sZSBUWCBwYXRoIHZlcnkgcmFjeSBhZ2FpbiBWSUYg
YWRkL3JlbW92ZS4KQnV0IHRoaXMgaXMgYSBzZXBhcmF0ZSB0b3BpYy4uLgoKLS0gCkFsZXhhbmRl
ciBTdmVyZGxpbgpTaWVtZW5zIEFHCnd3dy5zaWVtZW5zLmNvbQo=

