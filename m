Return-Path: <linux-wireless+bounces-26869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB50B3C2BA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 20:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22B81B2288A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 18:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DD621A95D;
	Fri, 29 Aug 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EFXIh8vU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7D9443
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493621; cv=fail; b=cJP6PBNkQRFBsRo3f6bBG6UaOVkhnP6XW9kptnl+iIQwnr0t2wMxR0MF0kclFLdwDQzNVAbrkd5Iti4oUzxPru8qUgiM5xdscDgBAevJwxIrIL1q4MNqQZw4kW/iD/AUMAPD1sHRvg3YEN2OOSxC6EfFLnBYv+gg1eQhC9HGoDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493621; c=relaxed/simple;
	bh=2TroFhblYneVKiRkT3lnUVv0qvdThttKoKMGDL6frNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dRXGmVOGUA2rKmmgvZSrwNhwNAWC4wAclkZQHLSRRGvPSSLBRDwSKbDV1OSe+xLVSveO0o7KA1DSCogbMWV0E4bDp82eurC/m7v4mEN2DKIuLZaS6Qym9omTYAT3fJs1r6jdrfs5Ei51ZkoWmGMoXc6k/37EdnVwxE5Jwi2p6Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EFXIh8vU; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9F5y7+yiXRRqo/ClaQV/l+qXDWZYeJzwD5GAGPRLuVTfqDMYUo+BXtrvu32tOG9Z7Frgz09XNPG2dpealKSCsuL/Chx1cUJ95uJpPRNDfwZW4JADa12dxtlJmf+g2KLFJp/1HXXhQpyfMOk34Zcw29qJVPRUIBarOGTq75L5+mab6aqhOvxqx3VmzM8bcDlEJdjFHeVLW71qrBGteAa2P+eFGZb8j4VKAiOCrdgCKzrFwGKd1xxNIHzCxUImf0Fh82rQ3DR9vXklU3ZdHkvIDlMcQ4OGdo21PMotCUJ7Q4eSaiKGZqmNE2XQU+GfUQstpQ/q527C7kZXNMfBUk6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TroFhblYneVKiRkT3lnUVv0qvdThttKoKMGDL6frNQ=;
 b=ZYDCIEy9g6XmKFjf0wvmBJz64vN4Jg1VhQWzFdaCkv+EKSN1M4eC6VSwkJzOrRNjKx7YdGMOah4IJAdWb8h+Vb0o8XHP03BNohvhmfGeOHDGaI7uZTNIPhuqBrM6kqs6nop/aH4Cf8oorBs8hY54C47saCZ3NNPM9zsJy6neYoWzJR/aVGSqVtVKZwBjuItlNKM1oGs3Bnir+8RfJmiAYiGYDeYSQKah+AaNEK7V6jR8vURABMxYK4fxbWc2J58rEGr9MlA96CMXHF0wJtL4SswH5hDFEaReezuFl0ca9CWDXbBMv4Vt1X2cUdFc9sUxRQFElM4pcUqlkZKWTWaILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TroFhblYneVKiRkT3lnUVv0qvdThttKoKMGDL6frNQ=;
 b=EFXIh8vUZfQLIn1HeeytLqyE0e6cwtlJNKJUA1Ai65zYvoAtat1u0b2UxrsH4Jl+QKx8lutjLMd8Ys1oJS1V1KTWTB4dpBJlgNqqKnYj7zhuF3H0jr1VQYhjXSQCv/eyQ8AJkmrEvRJUozl3jyENQ/G7Hin5x1dKqJl2hDh2nmF4pvwF8vraFF6H79LXzcAl+BRhQTxWvFaEJ8Tu0zF8glO3Zp1QbFCL4kUJ7btwBsKS6eG6PpHpbUl4SvcPuN31stonkS0N7VwlC9Y+d0HeewQ5b/LrFMJZzx6noQ9C/ZoTbvhj0v0lpouHJZ5h+5anuRY16OPSu3mtqe9WHHAzsA==
Received: from DM8PR11MB5752.namprd11.prod.outlook.com (2603:10b6:8:13::15) by
 DS0PR11MB7957.namprd11.prod.outlook.com (2603:10b6:8:f8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Fri, 29 Aug 2025 18:53:32 +0000
Received: from DM8PR11MB5752.namprd11.prod.outlook.com
 ([fe80::6ad7:8f77:89fe:bc03]) by DM8PR11MB5752.namprd11.prod.outlook.com
 ([fe80::6ad7:8f77:89fe:bc03%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 18:53:32 +0000
From: <Ajay.Kathat@microchip.com>
To: <dan.carpenter@linaro.org>
CC: <linux-wireless@vger.kernel.org>
Subject: Re: [bug report] wilc1000: move wilc driver out of staging
Thread-Topic: [bug report] wilc1000: move wilc driver out of staging
Thread-Index: AQHcGLmQOPaGoAZsWEKVs0OxuiwDTLR5+vqA
Date: Fri, 29 Aug 2025 18:53:32 +0000
Message-ID: <f629abce-47bf-45ce-82e0-a50f5fd7abc8@microchip.com>
References: <aLFbr9Yu9j_TQTey@stanley.mountain>
In-Reply-To: <aLFbr9Yu9j_TQTey@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5752:EE_|DS0PR11MB7957:EE_
x-ms-office365-filtering-correlation-id: 2136ed33-559d-4855-7e8d-08dde72d59db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGNFVTJqMFVmc0ZjRnQyVHJ1QXllYnhFZ1pJTDJIYmNsb2wyQnpPNDRmZTBt?=
 =?utf-8?B?YzNrQ3BzZWFQSi9aZVVFcmd4ZGpUVHVCcjlhZ2xxUHNZWlB5eDFueVpmQW5S?=
 =?utf-8?B?UmdnTkd1aXZlS2hueWFlMWczU095eU9qYll0cWg0cUcrdWtWc1BwcE1tNG5r?=
 =?utf-8?B?bW42NlFxQk9TdTBSUitjUWdRdURpZG9zbFdIWStxeCtCY1BIbGxMQ0lyZ1NV?=
 =?utf-8?B?bE5BdjdZc1V2ZlA0eEltMHAvNnJzT1pBUk5La0VydER5UXVER0xnYnJEL1dn?=
 =?utf-8?B?OHJMbmJEQkM4aCtWcHB1MndXTUJwREd5dTVBQ3ErZEgxLzUyZWZjWXl2Vlpm?=
 =?utf-8?B?MjdMcGtlcGtoaHFXaExKbU14eXRrenRSWkcvRTRicEZoTGlHdFUrS3AxYjJ0?=
 =?utf-8?B?alUybHEvcSsyRmpWb05Rb1NiQUNKTUhKRXJLbXdYSXp1YkVnWXNpbFpQRS9Z?=
 =?utf-8?B?dkJ4TFBWSEdLaCtiUkRpMEVXSjhZbDAzblV5SUJGTHpyUmJzZHl2UmtHbk9s?=
 =?utf-8?B?dXI1bTFJYkxCWVFHK2dQYkZHUjRYQVpOZ3BZTkRWa3NOdXJvVjZEdzk1bVlx?=
 =?utf-8?B?eFljWlgvWFhVUG1keHJlSDgyMWJkVkhaZEJ2c1FtNlNXelF0SDJWbGUrVlpF?=
 =?utf-8?B?SE0zQStSRStnWDhTYnRjdEVOSzJ0RWo4VWtlZXU5ZXlQR01FY0NoSE1nelBL?=
 =?utf-8?B?NG1zWldrL0hGM1p6WnBIWTEwbExFK0lqYzl3OGtNQjlRdUhQclMxZ2o4b3ZG?=
 =?utf-8?B?a1d5WEhHSkhsVEkwMVJIV1d1bmJ3UEYxTkZWYnJkOE43dGRpZGlUTndoZkxK?=
 =?utf-8?B?bDlZUXdoOWxYTmt5dEdaKzdmN2E4Rm1BaHV3VVJoTzVWK3JNdEFCU3J5cVJL?=
 =?utf-8?B?TGo4Ly9yTGNRemRyTjhYZ0NFY0x6U0JOT2ZHZnI4TVpUN0xZQUdOWWl4WElC?=
 =?utf-8?B?MnBCbzE5T3E2eUE1WHRuZ2dpdXVWbGVjZGYrdkZ4ekZmTGFycDg5YzF4a2VX?=
 =?utf-8?B?Z3RTaVNXM3JzKzQzSlA1L295SGRnbEJ6a3d1T3dZSVlrajhOKzk5S3B4VmVJ?=
 =?utf-8?B?Ujg2VXd0bEJsUng2elgyTGF5dnlScVkxMEhlRUxyVm8rV050SzVuZ3cyTEt5?=
 =?utf-8?B?T0RRT2xnMkM0TzBUK2oxbmxaWEtmWnlDeHdrajlYU1l6dnVCNUczV1UrN3U1?=
 =?utf-8?B?K1VYTXZQRk50TFd6djNpek5VeStPdWt4M0NKdDNFamcvdzRkdWswcjg0T3JZ?=
 =?utf-8?B?elQzS1ByNWtZMjVJbzR1MVR0cS90b3FXWnRYOEh5N01nTm5XVE44L1E5bkE4?=
 =?utf-8?B?OUlmdU5vbktldmtTbFYzbkR6bjRJTXJTWTI1YlJnNEJqdHNnYUtQZXZJckVr?=
 =?utf-8?B?M0R1RUFpN2Q0eXBtaUc2U0c3MHh5eXZaN0JsZmI0MUkvQWpjR2tXWk1nT0I0?=
 =?utf-8?B?czV2M0xUUmZoeHl0UURnMExhMUtuTXJ6SVdjWmh6Y1QvL1E1T1gyS0gyOU1u?=
 =?utf-8?B?U2wxeDI1YmZRa21uWmd6dE81dlcvMi93ZW5JTFlsWENPMHhDRGtnS1RPek9N?=
 =?utf-8?B?VUhkU3pLbkUza05lcVhleXhBUG9kUWtHU1BXTEY0M0tsQW1jTlZ5VmZ3eDcx?=
 =?utf-8?B?aUNJTThSMkFpRDYxS0hoTHZtSzdiQVRkQnBqZ3FMS0JLLzhHMWdBQkkzUmlR?=
 =?utf-8?B?MC8wMzYySlpVMkZFc2lKVHQwQ2RadDc3a1ZoWGZ3UFdQaEpNZkY1SkpUbldv?=
 =?utf-8?B?RllKS3c5Q2hpSDZtVnJRZXpQL1k4TTY3SFN4ekZ2RjRsSjR1TTZMNUFXblJO?=
 =?utf-8?B?Q2JVL3F2aFNUSFRUNW9iV3ZpaC9SQXl0R0krdjJZcHlaU0VwTXhDZUJqMk1m?=
 =?utf-8?B?Skkwd2htZWhjeGdtOXVtZEQyUFI3MnExRitxQTVEbmJsdjhvcUd5M1dVT0M5?=
 =?utf-8?B?R2VCWVNES1hRdlBsU0hOVXVTU3l2bDdRK3A2dnJtcXpmMEhOVHFaZEM2UGYx?=
 =?utf-8?Q?FKoosaAs/G3jTbmHL2Wpwt0qpsCiug=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjB6U0tXM092TEFzbmltazdHTmRhcG9BSmxrWTlwTS9KMG1OajJuaHRVU3Jr?=
 =?utf-8?B?a3JFaFVVK3VCa05IVXFENVUwNUFxTFNFMkN2blNKdENTSlg3ZEIrb1VVY0N5?=
 =?utf-8?B?M0dyZUozeExVL24rY0FFNUFnRENYRVlpazdqVWRpRFZvbDJaM2NHNFZkeHV0?=
 =?utf-8?B?U3ExQ1l0SmlpTUJwUGhnZE51aUZub0wzSUhUYVdjZ1ZxOXJLd2JLZEU5TmhB?=
 =?utf-8?B?WW5lVWVxWUZHemp0SWVENUM1b3pFdE5rSkJza2dnbUJ6LzFwMHFaZThMQU9S?=
 =?utf-8?B?emI1NGRXNFpzbUdBNFpnUjVydGRQWVk5S3ZYUS85VEI4U21jVXNlV3RBWDIz?=
 =?utf-8?B?eVk2enFMRHVBcnhXYStTdXV6QnRZNzZBL2xRQ01wR3lzNk83WnZKTEMvOUVn?=
 =?utf-8?B?YTR1MW5xK0Q5TnIrVGJLalRjT3hjS0t1NnJTR3dnSmZCa1JmVWd4YVdBTDYv?=
 =?utf-8?B?eStkVnRubFh5NFFwZDJ6V0duRnJ2a3dHeXFQTDVYWGFmeCs1VHBLNURaenlY?=
 =?utf-8?B?OHUvenhiZWpGd1IyZ2tXZnplWEhEMmFKYzVXeXRoM1EzRzhEdDN1VURDeWVB?=
 =?utf-8?B?OG9yZklJcDE1NWE4SzZYck1aVG9CQmRESklOQnk3RmJTbDhXQ2NBenVyczF5?=
 =?utf-8?B?RHovVGxrdjd4dzNQYk8zdEoyMkZYUUFCdG4vR3NYbGlQaTVJUDVPRTZEa1pX?=
 =?utf-8?B?N1RSa0tEcHFNZ1N3Wmt0NXhuTHdSZ3R5bU94UVRMUG9SQ09NSmRKU25paElX?=
 =?utf-8?B?MmFKeVFabUxZZkFzZ05TenBRRDlCWWJudVJBOG53UTFsR0hEQklyRVhPR1NL?=
 =?utf-8?B?VGZuMzdLY2cvRzRrbHUxMWZ6YmVqOHNPZkl3S2xKbXhsU0lPRHlLdDhuSHFL?=
 =?utf-8?B?bmI0K3NvdlVJWDBzQWEyMEtwUGtmQmJYSGVZd0R3T01rUUt4UmpySVhzaC9C?=
 =?utf-8?B?NkVzMHluRk9GS1hQM1FTMHNra2QzcVh2L3Nrd2E1YXBOMEZSc2tNUFY4dUV0?=
 =?utf-8?B?ZEUzdUkrWTdTeXpFVFEwR3A5U2pxT0ZjRDUzc2F4SWdaNXlHNnhiL2cvUVhT?=
 =?utf-8?B?akNEbDNWQlBIaFVHSWpoaUdqR3dVNVVRTW9jYlRVOFpIVHg5RG4yUUdmNy9U?=
 =?utf-8?B?emVSN1h5N3E2NElPRUkyL21oZkRnUy9FMElkZVJCNW1pNmNnYXN4amFJY01B?=
 =?utf-8?B?TkJaQzhVL0RvN1FSZ2E1b2dlYUVPWFZzeUw1bU9xYkc1eUxlWFg0SHRWc29j?=
 =?utf-8?B?d0NqUWZKUW50Ny9FTlFlMTU2MnNLdE96djNIT05IT1RlYU45Ris3dCtOdXpx?=
 =?utf-8?B?Q1haV1ZGTGwwbG5scHpCd2xzeHFrK1BKTE50dUdlSnc2N2hIdUFKZTJ2UTBS?=
 =?utf-8?B?azZRT0g1VVRUUVVzeFFqTFpCKzhkOHF3RktlSHlyUDdHUng3TkV6TkFuR2VP?=
 =?utf-8?B?OXRRQkV0SFJOdUF4Q3dEbDhMSk9wNU5jK1ArM21ORXUwNlBiUGxIdUN4MjNu?=
 =?utf-8?B?TUVHRXlQOFVraktna0w2cVJJZDF4R21UNEUrK1dBTkErcEZnK055RldHUXhR?=
 =?utf-8?B?am42RmtxS3pHWHBIM0YzaXRwODZaOHQwbjQrKzVvNnR2VkNmcGw5ZTJlZkwx?=
 =?utf-8?B?MTZjRXozUzFSeDZRcFJXWDJWUFZmdmd5NVRxOFJJOHVyRnk4VEhSb2F6NWtS?=
 =?utf-8?B?YzFheXZTczNBUVNNNmNBMjkwUnBEaGFVUkdLWGg2aG4vdU1sOGhBMTlaRmF6?=
 =?utf-8?B?SHI5ZmxDZVF4d1kvSW92RlM3VFdGZDRMMzJDSTgwbnMrc2lKR2xHU212NWVv?=
 =?utf-8?B?WDdqemozOXNQZEllOXJCN1Njc3E1NVhVMHVCU2NlU0szVXZUdXduLzFJZFdz?=
 =?utf-8?B?VkJoMHFMdGJ2YU5yNDZqVUhOanFCTGhVOXpNdTFxN0pEL2xaR1lSTHg5cVRG?=
 =?utf-8?B?d1FwM2NlZUpMeitKb0gvWTErTXg4b1liOUhLNC9PTWIwd2FLYkhVVlVZUG4v?=
 =?utf-8?B?QjhKRTlDSXBqRjh0U0JiLzZ4ZnJWd2kxWkV0a3l3cUtxL0gxNmFQZW5RU1JT?=
 =?utf-8?B?ckI4NDF6KzNpTDRBZG5NVVQyckE4OExpWk1JQXpRdml2eUtjYS9JVzhZVUtl?=
 =?utf-8?Q?rij3FVxiF0CJ7OxIcm5LEUJ0/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <993F3C3626F1024ABE49B2EA522E5968@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2136ed33-559d-4855-7e8d-08dde72d59db
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 18:53:32.3019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6V/GxP3H5YH1KP0OTDuK8wMVBa5pYa3KAgnlzGdmPasZcr/E++hjcv+6+lPFzs1jXuiYQV0gjlqR8SD2TyJADx+C+Xvrfaf1w3aaZDOpTD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7957

SGkgRGFuLA0KDQpUaGFua3MgZm9yIHBvaW50aW5nIG91dCB0aGlzIHdhcm5pbmcgYWxvbmcgd2l0
aCB0aGUgYW5hbHlzaXMuDQoNCk9uIDgvMjkvMjUgMDA6NTAsIERhbiBDYXJwZW50ZXIgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8gQWpheSBT
aW5naCwNCj4gDQo+IFsgT2J2aW91c2x5IHRoaXMgYnVnIHdhcyBpbiBzdGFnaW5nIGFzIHdlbGwu
Li4gIF0NCj4gDQo+IENvbW1pdCA1NjI1Zjk2NWQ3NjQgKCJ3aWxjMTAwMDogbW92ZSB3aWxjIGRy
aXZlciBvdXQgb2Ygc3RhZ2luZyIpDQo+IGZyb20gSnVuIDI1LCAyMDIwIChsaW51eC1uZXh0KSwg
bGVhZHMgdG8gdGhlIGZvbGxvd2luZyBTbWF0Y2ggc3RhdGljDQo+IGNoZWNrZXIgd2FybmluZzoN
Cj4gDQo+ICAgICAgICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWljcm9jaGlwL3dpbGMxMDAwL3ds
YW5fY2ZnLmM6MTg0IHdpbGNfd2xhbl9wYXJzZV9yZXNwb25zZV9mcmFtZSgpDQo+ICAgICAgICAg
ZXJyb3I6ICdfX21lbWNweSgpJyAnY2ZnLT5zW2ldLT5zdHInIGNvcHkgb3ZlcmZsb3cgKDUxMiB2
cyA2NTUzNykNCj4gDQo+IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21pY3JvY2hpcC93aWxjMTAwMC93
bGFuX2NmZy5jDQo+ICAgICAxMzggc3RhdGljIHZvaWQgd2lsY193bGFuX3BhcnNlX3Jlc3BvbnNl
X2ZyYW1lKHN0cnVjdCB3aWxjICp3bCwgdTggKmluZm8sIGludCBzaXplKQ0KPiAgICAgMTM5IHsN
Cj4gICAgIDE0MCAgICAgICAgIHUxNiB3aWQ7DQo+ICAgICAxNDEgICAgICAgICB1MzIgbGVuID0g
MCwgaSA9IDA7DQo+ICAgICAxNDIgICAgICAgICBzdHJ1Y3Qgd2lsY19jZmcgKmNmZyA9ICZ3bC0+
Y2ZnOw0KPiAgICAgMTQzDQo+ICAgICAxNDQgICAgICAgICB3aGlsZSAoc2l6ZSA+IDApIHsNCj4g
ICAgIDE0NSAgICAgICAgICAgICAgICAgaSA9IDA7DQo+ICAgICAxNDYgICAgICAgICAgICAgICAg
IHdpZCA9IGdldF91bmFsaWduZWRfbGUxNihpbmZvKTsNCj4gICAgIDE0Nw0KPiAgICAgMTQ4ICAg
ICAgICAgICAgICAgICBzd2l0Y2ggKEZJRUxEX0dFVChXSUxDX1dJRF9UWVBFLCB3aWQpKSB7DQo+
ICAgICAxNDkgICAgICAgICAgICAgICAgIGNhc2UgV0lEX0NIQVI6DQo+ICAgICAxNTAgICAgICAg
ICAgICAgICAgICAgICAgICAgd2hpbGUgKGNmZy0+YltpXS5pZCAhPSBXSURfTklMICYmIGNmZy0+
YltpXS5pZCAhPSB3aWQpDQo+ICAgICAxNTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpKys7DQo+ICAgICAxNTINCj4gDQo+IFRoaXMgaXMgdGhlIHJ4IHBhdGggYW5kIGluZm8gY29t
ZXMgZnJvbSBza2ItPmRhdGEgc28gaXQgZmVlbHMgbGlrZSB3ZQ0KPiBuZWVkIG1vcmUgYm91bmRz
ICBjaGVja2luZy4NCj4gDQo+ICAgICAgICAgaWYgKGluZm8gPCA1KQ0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuOw0KPiANCg0KQWdyZWUsIHRoZSByZWFkIGNhbiBnbyBiZXlvbmQgdGhlIGJ1ZmZl
ciBsaW1pdCBzbyBpdCdzIHNhZmUgdG8gYWRkIGJvdW5kYXJ5DQpjaGVja3MgYmVmb3JlIGFjY2Vz
c2luZyB0aGUgJ2luZm8nIGJ1ZmZlci4NCg0KPiAgICAgMTUzICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChjZmctPmJbaV0uaWQgPT0gd2lkKQ0KPiAgICAgMTU0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY2ZnLT5iW2ldLnZhbCA9IGluZm9bNF07DQo+ICAgICAxNTUNCj4gICAg
IDE1NiAgICAgICAgICAgICAgICAgICAgICAgICBsZW4gPSAzOw0KPiAgICAgMTU3ICAgICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgMTU4DQo+ICAgICAxNTkgICAgICAgICAgICAg
ICAgIGNhc2UgV0lEX1NIT1JUOg0KPiANCj4gICAgICAgICBpZiAoaW5mbyA8IDYpDQo+ICAgICAg
ICAgICAgICAgICByZXR1cm47DQo+IA0KPiAgICAgMTYwICAgICAgICAgICAgICAgICAgICAgICAg
IHdoaWxlIChjZmctPmh3W2ldLmlkICE9IFdJRF9OSUwgJiYgY2ZnLT5od1tpXS5pZCAhPSB3aWQp
DQo+ICAgICAxNjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpKys7DQo+ICAgICAx
NjINCj4gICAgIDE2MyAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoY2ZnLT5od1tpXS5pZCA9
PSB3aWQpDQo+ICAgICAxNjQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjZmctPmh3
W2ldLnZhbCA9IGdldF91bmFsaWduZWRfbGUxNigmaW5mb1s0XSk7DQo+ICAgICAxNjUNCj4gICAg
IDE2NiAgICAgICAgICAgICAgICAgICAgICAgICBsZW4gPSA0Ow0KPiAgICAgMTY3ICAgICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgMTY4DQo+ICAgICAxNjkgICAgICAgICAgICAg
ICAgIGNhc2UgV0lEX0lOVDoNCj4gDQo+ICAgICAgICAgaWYgKGluZm8gPCA4KQ0KPiAgICAgICAg
ICAgICAgICAgcmV0dXJuOw0KPiANCj4gICAgIDE3MCAgICAgICAgICAgICAgICAgICAgICAgICB3
aGlsZSAoY2ZnLT53W2ldLmlkICE9IFdJRF9OSUwgJiYgY2ZnLT53W2ldLmlkICE9IHdpZCkNCj4g
ICAgIDE3MSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkrKzsNCj4gICAgIDE3Mg0K
PiAgICAgMTczICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChjZmctPndbaV0uaWQgPT0gd2lk
KQ0KPiAgICAgMTc0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2ZnLT53W2ldLnZh
bCA9IGdldF91bmFsaWduZWRfbGUzMigmaW5mb1s0XSk7DQo+ICAgICAxNzUNCj4gICAgIDE3NiAg
ICAgICAgICAgICAgICAgICAgICAgICBsZW4gPSA2Ow0KPiAgICAgMTc3ICAgICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiAgICAgMTc4DQo+ICAgICAxNzkgICAgICAgICAgICAgICAgIGNh
c2UgV0lEX1NUUjoNCj4gDQo+IEhvdyBtYW55IGJ5dGVzIGFyZSB0aGVyZSBpbiBjZmctPnNbaV0u
c3RyPyAgU21hdGNoIHRoaW5rcyA1MTIsIGJ1dCBJDQo+IGRvbid0IGtub3cgd2hlcmUgU21hdGNo
IGlzIGdldHRpbmcgdGhhdC4uLg0KPiANCj4gICAgICAgICBsZW4gPSAyICsgZ2V0X3VuYWxpZ25l
ZF9sZTE2KCZpbmZvWzJdKTsNCj4gICAgICAgICBpZiAobGVuICsgMiA+IFNPTUVfTElNSVQpDQo+
ICAgICAgICAgICAgICAgICByZXR1cm47DQoNCkkgdGhpbmsgU21hdGNoIGdvdCA1MTIgdmFsdWUg
ZnJvbSB0aGUgYmVsb3cgbWFjcm8uDQoNCiNkZWZpbmUgV0lMQ19NQVhfQVNTT0NfUkVTUF9GUkFN
RV9TSVpFIDUxMg0KDQpQYXRjaFsxXSBoYXMgYmVlbiBzdWJtaXR0ZWQgdG8gYWRkcmVzcyB0aGlz
IHdhcm5pbmcuIEkgaG9wZSB0aGlzIHdvdWxkIHJlc29sdmUNCnRoZSB3YXJuaW5nLg0KDQoxLg0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvMjAyNTA4MjkxODIyNDEuNDUx
NTAtMS1hamF5LmthdGhhdEBtaWNyb2NoaXAuY29tLw0KDQoNClJlZ2FyZHMsDQpBamF5DQo=

