Return-Path: <linux-wireless+bounces-11829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2A95C712
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 09:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA6A283BD8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2EC13D503;
	Fri, 23 Aug 2024 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lGxQUIqc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010003.outbound.protection.outlook.com [52.101.128.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D175413C827;
	Fri, 23 Aug 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399814; cv=fail; b=V2hhYPd8wd52IFaY3iErUSpff98HUQo/S09jJ2Aft17H+1p8SMkp6Zi5CdnhyimdzKKwslhiAQ9jp1cQuhc7NQSUbtAhN+u/qg2Z/pt+GUcxMgGWg8nZ+15o/hV53tKvjevO1NsFBV9POO13shDhcDJMLYLzTcgNWJG7/zYVPmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399814; c=relaxed/simple;
	bh=Fo5OSqyKrMOTdZVsb5g9Vfnn93Pn6aeMUt8V9Rt0RMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxvF0VEAoZtFh1RiQxdledIy0ihCBRa5zKcRUCqzvVemHmmB6jMJ4O6nuJiNhDBq+PVCdQ9diLvdohulama/HW4hpq2yHXMZ40zcJax+1xzQxH08andjDigpkU0JPijtv0IW3Xn3RsXfHTqKGgYr1caFuqx7EZhA9B5uqzRYlcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lGxQUIqc; arc=fail smtp.client-ip=52.101.128.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7vtTKr0TT2KlSWKR/AvZ2IjZi30TTD64cgTyBmP5pENRO8xHaxzSl5mVgGv2b8XHrHcFexbGefQ/Q8Bli7Xj96FuC0tXmHH7j++3UwHwcB9JqOFI3itL1MGj0OsgKzBDJ/8tTAfCx2//JBdPk6IOQNXy4Bkwvf2O3QmLJFpDT28sRl2PpQnspN/FzaXTGauy+4z2fKytOJxbpplJrFJqrPrSXzxVbAkfnvQacTgV/o9VdoX1XV6iSbcQpf5nQeudFnWx16tbp2h70g6lr4qZGNKON9UVnMxXHFpYW5iWXj0VzhkUgT+p9OaZTQVGeBOM4jdpcLp0GrJYYnpnj6G7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo5OSqyKrMOTdZVsb5g9Vfnn93Pn6aeMUt8V9Rt0RMw=;
 b=ft+QA7BH+z8eXoX8G66LOfiyWBgYHoJZcyLj5bBgo9Y6cgGXt3aV1Ya8T6RWdRyedbXIlu4gDRi3CEQ7jbWbTcvRdO4ncUxIvq0Z6TsldPpMTGamelXvCCzs2ap0+jITi8M/J+RAL9nS9EtSOngz9KyEGKpsDAx91RlOxpkXp+8094KWFaigLQQr2KjtHd+BDfi1isxqdREfIeDChLvkbT4hupbw6CLvbaXo8I+AtpFfu2BcNtqy5C2QILlBuukal0pfX65M44Vzo/sTCJ9M7QjAsRrRTTj2A5x6wPLr8mf7Kq1ntoLezuR10sNkcAaW8PwViYbDeVBKuLjNi9tQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo5OSqyKrMOTdZVsb5g9Vfnn93Pn6aeMUt8V9Rt0RMw=;
 b=lGxQUIqcjxnjYcmSNe/zsIJOJCpeHidXrIM23lQSMBf/IhqB62jTDvdzTM98Cnq9sNW96aDkj9TknL0vQYIIA6zAKIeAoh2UxKSY24GKk9n2T0Bz9fIJqXDnl+2yQ4uRRjPtaWgrAK3Si5alqPGyB3fuh6ZMTarFzM1vlR+wEyRX7QRJrlxeMcqHo8zH0/dQcH+akSD9Gzl8daHm2AmH+ArhEPU5muyt5OtY8An0hK8GEVcupmGcZVW3B/KVXDEw61p7/KWdUz6dUUqP491dbRuCYpuzq4g1vP9cEkH4P+GW27nz1tM9bbMG8j55k7uAnNxGzJIkgNTf2rNBvphQmw==
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYUPR06MB6002.apcprd06.prod.outlook.com (2603:1096:400:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 07:56:48 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 07:56:47 +0000
From: =?utf-8?B?5LqO5L286Imv?= <yujiaoliang@vivo.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>
Subject: Re: [PATCH v3] wifi: cfg80211: Use kmemdup_array instead of kmemdup
 for multiple allocation
Thread-Topic: [PATCH v3] wifi: cfg80211: Use kmemdup_array instead of kmemdup
 for multiple allocation
Thread-Index: AQHa9D0DrmUpPn+mL0205ecj6nzXmrIy2UkLgAGiPoA=
Date: Fri, 23 Aug 2024 07:56:47 +0000
Message-ID: <6cc2a3bf-0444-463f-98d9-daec3f95865d@vivo.com>
References: <20240822024242.1203161-1-yujiaoliang@vivo.com>
 <871q2hgi08.fsf@kernel.org>
In-Reply-To: <871q2hgi08.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4461:EE_|TYUPR06MB6002:EE_
x-ms-office365-filtering-correlation-id: 3af26205-a3f7-4f92-68de-08dcc34923ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmhBc0I5dU9xTXUvd01PcWNURXV0cnFHeDNIa2tLem9veXl2VVI3M3NHRmtp?=
 =?utf-8?B?UEltT1ptOXp2TndCNlE5RTQraDZUb0I5K1FCSHRpR0FqNEhzbEp6YmY3NXdp?=
 =?utf-8?B?cXYyRXhYV0hDdUhEYWFLUjhwTEFZUjljVEtHN0JLSks2Qk80bFFCN1dOTTBa?=
 =?utf-8?B?aWI3QUo4cEc2VWZ2ZTZWeGhPYVgvTlAwcThSMW5DWDM2amVYdDJqUUhaQXBF?=
 =?utf-8?B?Z3hTTUxLdDN3ejhEL2N3ZU9JOFNvMU1va08wYXNsSWFOempSUmVwMUJMalVq?=
 =?utf-8?B?ejlVaVJPVlhCSGh3Z2l4NGUvRktIN2Nab0hvRWlYS1dGcmdaaDkwZHdtdTZW?=
 =?utf-8?B?VjZ3R2lsa2JWc2oraDJOdVZvbnRvTm1Zc2dUTGJUMXRzZ2I3dkNDY0wwaWE2?=
 =?utf-8?B?WnlsVWFabUZWclRydENSZkRXTFFRK0JqZ3BDbzQrMHBQVTgrN1pzZk1IV0pS?=
 =?utf-8?B?UCtYOTY2aGJVRk9vV0srcE5qTU52R2YzM0lWRUF6NWFjRjdjdjZuZEZtMVJT?=
 =?utf-8?B?NUg4U2M4cVZvT2hMbnN2d0c1UmhMb3creXV3UC9TZ2hsekcwMnErdzJyMDZC?=
 =?utf-8?B?SE12N2ZaUTdJem1Ha0UwZ2NqbVVXT09saFY3UWpGN1dGOEEvQmIvNUM5eGRj?=
 =?utf-8?B?RW9TQnFtTVVGTzNSb2JFYS9UeU05dFpQU2lVQ24rK1dscTBtVmlUTGh6enF4?=
 =?utf-8?B?b2JucE5Xd3JmYTRmTGFCb0Zvdlo4Y2EzQittSmlxQTBQV2crNFJwK29VcEk4?=
 =?utf-8?B?dTBLUUtwdEN0TG5lS0RQMm56MjJmNXVIMkFSVGdZZDErNFJabTlpWlc4bEVN?=
 =?utf-8?B?NmU4V3VYc3p4QTBoY0NoNGptOExYL290ejdMVHAvRForR0hHSFJWWVdIUEVQ?=
 =?utf-8?B?ZDBVV1FvN2pQUGwwdmRPaVI2ajFYQkFablgvYXI4aTBDS3p6eTZaTHdZYm5l?=
 =?utf-8?B?QmdESS9Jak1UTFZsS0JQcjh3bzVUOVlLTE92aE44N29KR0p5T1BwWC91MFpu?=
 =?utf-8?B?UVJxNnhXK0NoR1ZhVVRNMG44WW9GaHgvVDQ4QVYzenFNSEVqZ2V6ZGlJb1BK?=
 =?utf-8?B?MEJJOVdRZFpuZzBSM01ZcUo5Y0d5enIwYS9aTVpnaDgrK1lzcUhhYklzRmxy?=
 =?utf-8?B?ZjdPdTBSN3NGSDV2VXFTR3ZaV2RsZWp1V0VUUEYySzBlVGVJeDM1ellocW1V?=
 =?utf-8?B?OEk2QXQvTHFHTFZNMzdLWkc4dVpJY0o2U0w4ZkM3S0xMU3lDeHh1L3ZiQmpR?=
 =?utf-8?B?a2JpOXF3Q1g1OGJQbnZVSW9TWjN2UmsxK2NnaytGbjcrd240bzJMRXFFYmRw?=
 =?utf-8?B?NFRtdVdxSEtaR1BkNnNQWnlVRHhkdWFqdkgxWnFoTVVsSWdEU0hyaWRyM0lk?=
 =?utf-8?B?SG1qL3ZYWmx4TXpVRVE5UEhFS2g0enlTYjcwZWlmckFVb1ppUEpocHJwaGlO?=
 =?utf-8?B?WXBsSmZENFc2SEt3eStqazNMRTZLbmRYS2puZ2FNcGRzSlpabENPb1Y0cWdD?=
 =?utf-8?B?T1pTdjJWNlBDaHRacy8xRmw5bGlRSGJ1UFBDZWU3U0NSSkZMckozSXV6SzNK?=
 =?utf-8?B?MURiM01oY2RNc0dycDk4UkhIZEFTUm12ZXUzSlU2MHZaVCswNHNOT2FUbk5D?=
 =?utf-8?B?aDdhODltWWtNL2xGSUd2djc5RUNRVjRZVUhPTkp2N1Q1ODdnWTJyZ3BEd0th?=
 =?utf-8?B?ekcxY1dLbEcrTGJJQXAyakJCdmx6d1d5TGhYSVhUaGVYbC9aRTlEVGdYRWxC?=
 =?utf-8?B?b0VrVHhpcGx0UC83bk4xOVE4TDFMLzdVRlBnVkRReHphdFRWWGFwNENxM1Z5?=
 =?utf-8?Q?TvlrTU5JtGEo3/Zqu/dxGrq5/vQZURBDLDeXs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnZvZEhWcGVTa2FIYVJYM0lFUDkyYUZqQk5Bak9rcFdIRG0vdW5pdjNrMjQ2?=
 =?utf-8?B?bzd0Q1ZnMmx4Z3MvUUFpbjY1U3kvS1RzZkFYa3BiS3ZZM3pIa2FBSzNMYU8x?=
 =?utf-8?B?SUVLUnk1bG9UWFNsaEk2TDVHMjNmY0ZCa2VLRXg1WTk5TnpxditRa2lLUE84?=
 =?utf-8?B?dndoMTlnR3NZOVlkYTZLQ3J6d21DZkRhMVM2RUhFUExzL2FhZDJ0RzA3YU5L?=
 =?utf-8?B?OFo3NkFaY240NUJHK2JUcGtHQ0ExUmRGTk1teW9yUytKVUZ5RFhxOUlYUWpp?=
 =?utf-8?B?TlQ1VlpGQlJhT3RSc00vZVNENFNHRjlraEJGV1crd3pwY2JYVkFFWU9HVnJa?=
 =?utf-8?B?TmE0MTlYdDNjNWJLaldvZTJhdzVZVVJlRWV2STY0bWxSSGV1SGNsMHlMVTdj?=
 =?utf-8?B?MDFsMWppQ0tGNk9NaHVFZlVmTVFsYThYenFobzZEdWhnOEJaQUZYMmRsbGpQ?=
 =?utf-8?B?WFI0MlQ2L00vNHJTaUN6RFIzYmg5b0UxeUl5SlFZMXJ2eDlhK2VKblV0eWRl?=
 =?utf-8?B?M25lVU11d0NSN29DYlBNMzVzZTZVKzVBa0hPL1krQjBhVjhoZkVsdlRsanU5?=
 =?utf-8?B?dEplRVZSc25yRCthYWVhaExXWEpCeXZlSWRvMTNvaTMvb3MwRDA4NWxzaFJj?=
 =?utf-8?B?dlRYQkYxdDdBdG1IMGFEdWkxMDlpc2I3cWs2S0N4a0p5L0F5SGFFNzJuUFdz?=
 =?utf-8?B?N01BVlNGcERiMFU0QXE5dW1kQVdNOEYvR2dITTlFWU1PMnlZVTliZkpUZUxn?=
 =?utf-8?B?cHJmRnNKMi9wNGU0bXU0M004dEVwamtaMW43UTM4SFd4LzB3b3owNGVkZk5l?=
 =?utf-8?B?bFpNWDVQVjVhaFdRUjBjOWpHb2R2ZXlRN0hDZkQxSG9ZYy9qSzYvL25QdTM3?=
 =?utf-8?B?Ly9VZWNNSk81NUhweGhWdm9nNDkwQlRaVDZ3OExaUzVUdkFxdWZ6dVFiZ2VC?=
 =?utf-8?B?MmsxTUpJZEtuWjlQVWhQSEd1Sk4zNm9uaUFaaGZyUHZ0NDgvclFvZ0N3eFVF?=
 =?utf-8?B?ZUN0K0NvWUZDTEpJcWEwLzYwYmdGNWRlb2F4ZEhuc3NYSS85dHkrakxjVWNs?=
 =?utf-8?B?TjE0aXpHMjVmcEd0bUFhQkhxRTJMNWFiK2x0Y0tuNjRJRGJFcXNvT0FwUVdi?=
 =?utf-8?B?NnlnZElvTHhFOEtvUndZYkhCVzVjOE1MdTQ0bXErLzhOaHRYQ3hJS2JTTG9M?=
 =?utf-8?B?TjJtNE1wYW5wQ09jQUNjTzhKL2dlWEUrTWNwazAxT3UxL2JjTWFsYlFWRmxs?=
 =?utf-8?B?WnJkd2xWOGRqQnl6NDk0T1haYTM3SHFVVCs1U3ZQVGFSZktxMURZQk9LdVY0?=
 =?utf-8?B?UWJ0bzRHQy9NQlR1dHVyNGpUOWE2V0ZJWG1UUkUwZE5BdjI4WHoyYy9NbzQ0?=
 =?utf-8?B?dlhoZURqOFZ4MzJMUm9YUlhoSGJoV1RCNEdGb0pZMVNoeUZoUHcvTWNRNTdk?=
 =?utf-8?B?NWpwbnJlQnpqU0F5b1BoTkxITFdTMTdEelpobVVKS2R1RFdNdno1VDFoa3M3?=
 =?utf-8?B?ZGhRZnlWVTBsUnRIT3U0TVlOVzV4SmpDZUtDdlhXWWtqVG9VR011bUpoaTNN?=
 =?utf-8?B?YnJ5Sk9OaDhhVzI4QmgxTE81RW1TZ3M1Tmh3dmhyOGQyTktjeThJNFdKWE9l?=
 =?utf-8?B?SzRtc0JuSTBKNm5wQzBtdFlvVDdMM3hlRUZweTFOblY4ekE0bnpKQTJ5Z29Q?=
 =?utf-8?B?WnZYUFJCWENMWVdlQ0lMM1hSNTNseHlSdUhjK0NLOWdVbHJWY2I1Y3Q2VEdj?=
 =?utf-8?B?T2VwTXJnRGQxN1dGRUQxNDIydHFyckJQcUp0bCt6Z1d3VWZSK1Q2TW0yN0Na?=
 =?utf-8?B?WDlQU1BsV1IyOGJpbmdZbTMyalovOWpJcEtiVGZtWUN1ZFUvWnFkZnVrVHBh?=
 =?utf-8?B?aytNVFJnUXhjS0oyUFRVOHVsWk8zL01FcWFlL2Y4TTdicytWK0xPbVpkOU1x?=
 =?utf-8?B?M3FVbWNST2NlNTVIQndVRFV4dWVicjlGTmlSTUQ5SzU2bXRtQUdFTnBoTE8w?=
 =?utf-8?B?MHNXYzdPK0JKeFdER0E4aDh5cGxpY3M1c1pRSnJzQTIrZVZKR01rN25KSDdo?=
 =?utf-8?B?eVhTZXpXMDRaR2FPSS9DUitBdHVLdVZ1ckd4bVord0o4K0xGT0tSMVY0VzBK?=
 =?utf-8?Q?iJQE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59B020F1F3033243803916600F5C372F@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af26205-a3f7-4f92-68de-08dcc34923ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 07:56:47.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pj+dpUnHCx75H6zTcohzxVgEr0PEqkKB+/qzW+uwcHFMeV5yxyKNTmd858Ap7tl7R46IQS6p9QUjY+Xq9XQAsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6002

5ZyoIDIwMjQvOC8yMiAxNDo1OSwgS2FsbGUgVmFsbyDlhpnpgZM6DQo+IFtTb21lIHBlb3BsZSB3
aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGt2YWxv
QGtlcm5lbC5vcmcuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0KPiBZdSBKaWFvbGlhbmcgPHl1
amlhb2xpYW5nQHZpdm8uY29tPiB3cml0ZXM6DQo+DQo+PiBMZXQgdGhlIGtlbWVtZHVwX2FycmF5
KCkgdGFrZSBjYXJlIGFib3V0IG11bHRpcGxpY2F0aW9uIGFuZCBwb3NzaWJsZQ0KPj4gb3ZlcmZs
b3dzLg0KPj4NCj4+IC0tLQ0KPj4gdjI6DQo+PiAtQ2hhbmdlIHNpemVvZihsaW1pdHNbMF0pIHRv
IHNpemVvZigqbGltaXRzKQ0KPj4gLUZpeCB0aXRsZSBwcmVmaXgNCj4+DQo+PiB2MzoNCj4+IC1G
aXggUi1iIHRhZw0KPj4gLUxlYXZlIC0tLSBhYm92ZSB0aGlzIGluZm9ybWF0aW9uDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogWXUgSmlhb2xpYW5nIDx5dWppYW9saWFuZ0B2aXZvLmNvbT4NCj4+IFJl
dmlld2VkLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9v
LmZyPg0KPiBOb3cgU2lnbmVkLW9mZi1ieSBhbmQgUmV2aWV3ZWQtYnkgYXJlIGluIHRoZSB3cm9u
ZyBsb2NhdGlvbi4gUGxlYXNlDQo+IGNhcmVmdWxseSByZWFkIHRoZSB3aWtpIHBhZ2UgYmVsb3cg
aG93IHRvIHN1Ym1pdCBwYXRjaGVzLg0KPg0KPiAtLQ0KPiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvbGlzdC8NCj4NCj4gaHR0cHM6Ly93aXJlbGVz
cy53aWtpLmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9kb2N1bWVudGF0aW9uL3N1Ym1pdHRpbmdw
YXRjaGVzDQoNCkhpIEthbGxlLA0KDQpJIGhhdmUgdXBkYXRlZCB0aGUgcG9zaXRpb24gb2YgdGhl
IGNoYW5nZWxvZyBhbmQgc3VibWl0dGVkIHBhdGNoIHY0LiANClRoYW5rIHlvdS4NCg0KQmVzdCBS
ZWdhcmRzLA0KDQpZdQ0KDQo=

