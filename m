Return-Path: <linux-wireless+bounces-12442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE1D96A9D8
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 23:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473D11F2490B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD35D1EBFFF;
	Tue,  3 Sep 2024 21:15:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2117.outbound.protection.outlook.com [40.107.121.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2B46BF
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398153; cv=fail; b=dJsdO0V+vSZpauKio90RyfbqxUuHGtlY+96t43B0LxhLRhaoZdZU6xnbn9wZnHa+0is+ZrcokpDu0f8ieS5M4UUhkJ+0b8agp/Zjz/wwPHtgx524TGm6fF1h1GPnJw/KQfvnWFzDSJhS5dPPMIBtdzLMBjrCXCeS0le6cQW4v7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398153; c=relaxed/simple;
	bh=/0H5n4dvSp6uTSOJ2KlNTLo2qvrr/64NupVEGkCgYpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l85csABRhQwzY1UOkJqZFTM+xtupDrIvUaBl5NyaknXi6RDfBDNRmYfm4yY+esvYzA6Fo+s/KgUhSNvx8CeQEdZcud+iWZMzLNbIZcP5zoke5I/pPftEhhYrzJ0GxWdLSw6/HJuyXKOwYRhoyPugY5msjkqjqmTPhGNZOLgZNMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3adesign.co.uk; spf=pass smtp.mailfrom=3adesign.co.uk; arc=fail smtp.client-ip=40.107.121.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3adesign.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3adesign.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwcpRfXQQeqSWr+LebhrGygFbKV4yELpPtgXRITAVVh86ZFK9hy5DsA4lEriYe32AyKJmef26gDrcnou6CSbU5xwYaPGKGX4Dk8c3MTohxkc7xLHBoDfOR5yHfqPvXXUtM1Qw6m3WBmciqzAe7NsPMKZZqzEohilHMjS8qRvBpi5rPvT8o+etfmQkzyMtY0cn79cUxlpVkERLvNdsk9U6W02RdMlD6wfUxaGDWNiJXKtJMFLniB2WwZ6lY7aJ6DL3+D71VKm1JY/QDiWY6fEcWmXqQKuOlQyUcofqjBQNK974tcug78GP7159cXVaNwEQLIlhFMnxbbikM8pE0lMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0H5n4dvSp6uTSOJ2KlNTLo2qvrr/64NupVEGkCgYpw=;
 b=xsI4Tb7Ak+m83EYEfXF/phtnVD9b9gh4aBL7R/fWmmeG0NaqkTc/D8fJRCrt/RcwCM5WhX8LslsSAyyb+LIj1PNbs5iIZbxGqL+NCDKFvx5dfuTl1PHUskn0mICmA8wiIypwrskks3qTgvS8QUlv91BqUeMdSviNcc2GZYeoBF3Td1Qppt0oUzVLuAi2ogVOSCVIFSHZBzqSS9Q21EEZSe9O0TLUPJiCanIxL5jE5GJQht67gKLIXRusacfiGLGUeN2TZgs9t4nbNmvKrnyi//apY5C0qR6DiPRDFZHYvCXE36uJNSNV4NzG9ASNATPS4dKx/KcIcPRFoGMkHe5kzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=3adesign.co.uk; dmarc=pass action=none
 header.from=3adesign.co.uk; dkim=pass header.d=3adesign.co.uk; arc=none
Received: from LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:182::14)
 by LO0P123MB6879.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 21:15:47 +0000
Received: from LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM
 ([fe80::493e:62d6:55a0:48c6]) by LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM
 ([fe80::493e:62d6:55a0:48c6%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 21:15:47 +0000
From: david Atkins <david@3adesign.co.uk>
To: Kalle Valo <kvalo@kernel.org>, Janusz Dziedzic <janusz.dziedzic@gmail.com>
CC: Baochen Qiang <quic_bqiang@quicinc.com>, "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: wcn7850 issues
Thread-Topic: wcn7850 issues
Thread-Index:
 AQHa7kGb/waLDsK5rUe0AflzG3bOpLInNsxggABezQCAAjnlIIAEFF+AgACLnWCAEPZAAIAAFKQAgAMsa8CAATNCgIAARKCwgAAFVgCAAZPVMIAAFtdvgAAkNoCAAANhTYAAuXkg
Date: Tue, 3 Sep 2024 21:15:47 +0000
Message-ID:
 <LO0P123MB4057552A6B51BCC3C75A0013D6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
References:
 <LO0P123MB4057D6C2F6FEFF335B30EE7CD6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<LO0P123MB4057122D4C7D07C7114F5ABED6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<be53813c-3edc-4734-b59d-83f43f14ea91@quicinc.com>
	<LO0P123MB4057C3085F445434F5E87B3AD6872@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<26bb8ec7-7170-4a09-ada3-c7c753c16e87@quicinc.com>
	<LO0P123MB40573F46A6D63145363C6B13D6812@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<cfe8e314-a28b-4ea3-85b2-9f5b4ac2db09@quicinc.com>
	<LO0P123MB405769E063E48B0F7AE18C5FD68C2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<LO0P123MB4057E823BDB7B9ECCCD75840D6972@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<a6c609fc-150b-4779-b3f6-dddbd6ce93dc@quicinc.com>
	<LO0P123MB40578A6CEC43AEFE301F9ED8D6912@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<86bc1623-8845-43fa-9aad-a8a6066b1448@quicinc.com>
	<LO0P123MB4057266AFF389FA69FDC84B8D6922@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<fb455a66-b29b-4eb0-984c-254f9a1c5626@quicinc.com>
	<LO0P123MB40578B26075CD4C9C66D144BD6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<871q21kwk8.fsf@kernel.org>
	<CAFED-j=i+jZwtFVzoiqXrVAubmDdxhqqVpAPSCRPMPoa6G_chQ@mail.gmail.com>
 <87seuhjbfn.fsf@kernel.org>
In-Reply-To: <87seuhjbfn.fsf@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=3adesign.co.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P123MB4057:EE_|LO0P123MB6879:EE_
x-ms-office365-filtering-correlation-id: 808a0fed-e019-47a3-ea16-08dccc5d9493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjgxZlZ6SUNwdm1nMHE0a3U2V0o2L0ZKVGdDOEVXZ0NmQTMvZnFRSEpJOXVG?=
 =?utf-8?B?elFsMFp4d2NTUUpwVEkreVphRFZpaldnVG1tem44bDRwR0o0Vnc3T1E1UTho?=
 =?utf-8?B?TXZLWWpWSFROOXdjZFNnZmdERkdabFNES2EwWHJxV0Fob285REdtQjgwbmE3?=
 =?utf-8?B?VWNOL3FreW9PWVBrU29DakZlUTVxQjV3bVJQYy85c080QlBFRVM2eTdzN3JN?=
 =?utf-8?B?K3Bmb0QyQm9lV2M2NC9YNUwwZmxmMFFkQklzRkdXTmRqK25lR0wxRW1xWFp2?=
 =?utf-8?B?Q0p4UVhOeXhaQW5UM0dta1Qyd1FZcmZvaFRpUDRzNC9iZzFCUzg2UlNnZUlK?=
 =?utf-8?B?SEFCNnc5YURJaG9hNlhYUzhxQ3VBR2NIamZQN0lrTHZhWnkzTk91bDRESFhO?=
 =?utf-8?B?Y1FvOXpBcEVYbDhGWGE3V1pUQzYwUUY2dS9ETUEyTnYwSHlrTXFvWnBGYXow?=
 =?utf-8?B?L21nV3prVTBkWUxqdlR2d1IzV2ZGd093eUI3UHhUOHUzNG5UOFBaNTVjcTdW?=
 =?utf-8?B?Zm16MC9zSzRyYTdGcWFXL2xPSG1nQ29KaFduTnBET3RxSmFFWVRxblNWZFFE?=
 =?utf-8?B?RjZ3N1V0QWZNeWZSMjhibkFqNnBBbGpMUnJ3WFYySDlvdEsySzNBUnJndFhz?=
 =?utf-8?B?UlZaQU9OUCt1ZXRXNE9vQnZCV2puT1VQOURVZzhKMTBOVmpBZkRJQXg5Tk9L?=
 =?utf-8?B?ZnNGSms5L3RuckpQMkRCV2t1TGY0bFNnU0VKU0lDWDdwdUZYNWEzNjBUVksv?=
 =?utf-8?B?NHhXcWRhL2ZXd2lJS0VOR3ozQXN5cjNkaVl1QWI0d0NwT2duVWlLTGJ3WjJs?=
 =?utf-8?B?ZFo1TTVNaWxURURSRmlOVDZVUEZ3VHBoRWpxbDI5SlJ6T1BHRDZ6L2Z6bmJU?=
 =?utf-8?B?RXFpZlJ3clVObDVTV3BidnhrNk1ic3NkdWtnRkJhcWlwQjBxTThlc3lBaVgy?=
 =?utf-8?B?NE1BS1FkS3hTa0cvNjY0ZGQxd1N0UEtKcnFaSUg3WW5iNFhHeVFMelR2Zll6?=
 =?utf-8?B?RThWbkY1UDVySVc0VjZGTVdMdU1FeHBwbm5pNGtRV2NFZ2hZbTFzUyt1ZnRP?=
 =?utf-8?B?aHF5OEtjVER3aklMbWVodDA2VnY4MHA4UWxGT3ZYK2o4OTNvd0tBdkNiaTl1?=
 =?utf-8?B?d1ErdnZQQ2x4RFNHWFdVOVRROW5Ld0piMW9rZWFpeGJLejdZeTlKT2tNNGZM?=
 =?utf-8?B?UFFHU2VZWXhHTHNDZ3FrWlNJdHhEUDdmNDBEUTFSWnhsaHBuWFVldHR2bHBt?=
 =?utf-8?B?bnVFTVg3MkxxcDJVSXlFWG5qcnF1SUR2ck5nL25zUW5pcU5rc05sMUpqNUlX?=
 =?utf-8?B?WFQyRi9OWU92Sld6bWdHaVRPQmsycjdOa0ZNWjEzNWNDam1rSUV2UStNcU5n?=
 =?utf-8?B?dlp3K1lRQnZLWGhYdHk5QmpBL2dQUnJqblVzeUs1Tm1rTGcxYmhaekVHV1hI?=
 =?utf-8?B?ZWxWTkNnc0o4S3ZzbUxybEVJQlp5bDh0VjNSMlo5OTBRZXJ0aXE0bGxGbjl2?=
 =?utf-8?B?T1JCbzg1ajgzMVZHaVhCWUROZWJqRTdUcnYvQVVLV0VCclQ1cG5PeUFZSDJm?=
 =?utf-8?B?aUhGV0UyZFRVU0dqRXEzcmdMVTMrb0NjcUE1aStrUDVMVDFQUk0rQXk5OWZ0?=
 =?utf-8?B?bGdUcTdQV2hyTGQ3VGJiMldpUjZHK2lnTENuc2ZoYUNyWVp6UXIwd3RNNVZG?=
 =?utf-8?B?NENLN3ptMUc0ZFZpaG1CZU5oc3VMNndMZVVhMjZNZXplTGRKbzZ1SWpzU3ZQ?=
 =?utf-8?B?NFlLR2tmSDdxNi9tcTJNeVFIcXdEOFhpeitDYUxZbDJzSitQTGdCK0lwQzV1?=
 =?utf-8?B?VzJGNFdOWjQvQjhKYVNLUXp6cXMrSmY0VVBEclR5djJvcG11alcvc3hTR0V5?=
 =?utf-8?B?b1dHTVdtZTROOUllbUlWQjRVOXlRSUVGRGk2dmdIcU5QWUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bU10SlJSVUMrVEJPZkcyalZCNnhPZWFrdUk0ZlR4Ry93QW5nV2xBWkZBWnhh?=
 =?utf-8?B?QzZqUXhrWGZZOVFzRHpGVzUrUWNLRG12aU5jSWI4bjRUbFF1RWplSy9XK1Zu?=
 =?utf-8?B?SzZWbDFpRE1XdlR4eVBnNG9rNVZHN1l1T3ljK1FnVEFMR2FBeEpLUjFwNzlH?=
 =?utf-8?B?ZUxQRWRtNkJXT2dCTUtScSsyL3ZjYU1DaTRyaVZ5bXY5S0JSc1crSXROdVBS?=
 =?utf-8?B?ZnR5SDJpRmkvemx4R1J2UExuN2Y2QnU0S29teGdtNnJZNnZleFVSMU9oWFVy?=
 =?utf-8?B?RXJuNkdjcmVtZmUweTRxOTJrTldnZXZDODJiY0UrTis0cU9OYUUyQlJYZUNC?=
 =?utf-8?B?b3FNdS81M0pjNHptU0l2akg5YkxSK1BpWEFscTI5R0Vwd3ZqRjFBRkVlSHVG?=
 =?utf-8?B?dzVLQkNUenpac1VJcmJUSTdaUmU0ZlN2SzhlVHJMazdGVjJIbVpJbHFKMGZY?=
 =?utf-8?B?aVZIUnJvSk9Zak04U05iemF3eWV3SDArVlZZRkFRSUFKTnVYUmpIYWFhZDds?=
 =?utf-8?B?VDRzZ283aXFZZ1lpZEFUbSt3ZHF2dUtZK0NBQ1NIN3F2cDVSY3Q4VHZHS2lK?=
 =?utf-8?B?UWpwRFdFQng2aS9kWUlXbVFEUHNlUXFQRjd3YzRya3IrKzVBMjZBY3BFakFD?=
 =?utf-8?B?ODdBY0xHa21xYUkzWHlVaFY0VHo5RnhDQW5Udlc4K3dtT29BNEJJOXRTQm9a?=
 =?utf-8?B?YUNpall6d20vUXMvWHZ6T2ZkOGoyYzB3azlYVGpoaVZ4TWVkQVVveEFZYUhx?=
 =?utf-8?B?U0diYi8vb0YveDJoUXJYOGhJbGZrZGc3aUtVSDVyMWZKdUU5cEptbFFTZjhX?=
 =?utf-8?B?NGgxSEovWmk2eDVvUXBpY1dnMC9mZUt4ZU1GN1ZkVjN2SlR2ZkVLWUFxaHVF?=
 =?utf-8?B?TVE0VmllWmlkWXhEd3h1TEhsN243K252d1VzMlg4Wlg3bVV5S1cvd1BZa3lv?=
 =?utf-8?B?Z2MzdFZKeVFFdDNWNk8rYTBCaDFkK1NDTXNZSnhWRnpFelo0cXZnajJrc0xa?=
 =?utf-8?B?UjJSdGYzSjJ3ZTd3ZDhybS9WRWZwZmNLSnEwSmt1WkI2QmY4MURLUkNrMlVs?=
 =?utf-8?B?MElpdnJzQXJkMEZjSFVwdzM5RGxySGIzMGxSU3c5TU45YXBqaEtVY2pUalJO?=
 =?utf-8?B?c0JCbzFoK2diOUp1TFdIU3B1aks4S1dldURCTVY5eHRRK1VLdk9yNExUSDRu?=
 =?utf-8?B?d1psMmZQZ0JtQ2o5OTZ5ZmFESmhnaTRLL3o2NmtoMElDUGtoQkJ5QVdVNlhx?=
 =?utf-8?B?dFlXUm9JR2dRK1JEWHQxMERUVk5Oekh5dXV6NCtsNnh2VmU4V3NNeWFGYUx5?=
 =?utf-8?B?bEJWdHM1SWw4N2FEMWlQMGxjNkRLWFNwelFRUW9DbjdSVDhFWnk1eVZnM0xk?=
 =?utf-8?B?K1B1cGIxSGJhNFIyUm1zZzNoVjhoMXNoT0o2eVVlMm11Ukk4bGhVUHJwRzl1?=
 =?utf-8?B?U3pYaUlQSnV0NU54OGJpQzBvVmxpVmZsTUltbnY0bmtnUG9KK2hWUUVST1Nq?=
 =?utf-8?B?WiswWkN5WEFkYzU5MTY5UHJyamw1eFE4R0ZqRUJEVmFmY1AzTklTS2VBeUV2?=
 =?utf-8?B?ajArdm9EOE1BUzVmK0RxTHBRR2lnbUNnS0R1dDFXeW15S2J4UEROV2VjNExy?=
 =?utf-8?B?bEZtOFBNVFowRWZnMjBsTy9EUDc2djlLbTBVWW1Mb25oNloyd1RpaUxXMkJ0?=
 =?utf-8?B?RnZwcGYxMkJlTC9tbE44RW9xQkhEZzNKOVdUMEJ4QUh3bEF0dGVhYlY4dnYy?=
 =?utf-8?B?aWplRnpISTNVSEFCUVd2SjVwaWFDWE9CYXpnZFlOSGpUNTBhNk1SUHdhbEQ0?=
 =?utf-8?B?TVNET0Fack5ZWG8yTXpVZnhXbG9qb0lsN3g4ZDNzQW1JR3JVQk8vMVZ3SUEr?=
 =?utf-8?B?emZJdFR3dFl0My9GU29xalZ3Ym5OcTBUTDk4ekFqN3Zkd1FzaWt2ZzFWaTBu?=
 =?utf-8?B?U0V0U2drcUxqL3lCdnJmSUo0QzJ4MUZKZlo5Nk9zM2hwSjJVY2FVQVZHZ2Vy?=
 =?utf-8?B?TlcybDdYa2xMRW91RWRON2FpL2NXTE83VnBwNi9lOVVvZnllMmtRRDFXQlpC?=
 =?utf-8?B?bUg4RzJzbVord1A5R20wOGN4azVhRDFNaEErNEwyUGNsdm1yMEtmb25pYUg0?=
 =?utf-8?Q?gzB4QwsmwimEGgUOYrAq1jcYT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 3adesign.co.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 808a0fed-e019-47a3-ea16-08dccc5d9493
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 21:15:47.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b153f19-49d1-4c9d-8de6-70aea15d7add
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcN/Flu3Wf5O89uZ0EIaU80SBAJ344bmApdmVfR/BmiFgAMkEjnNkudEP22PPURY9qiYEmpsvMpPir0REBMr6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6879

PiA+IHd0LiwgMyB3cnogMjAyNCBvIDA5OjQ3IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+
IG5hcGlzYcWCKGEpOg0KPiA+Pg0KPiA+PiArIGxpbnV4LXdpcmVsZXNzDQo+ID4+DQo+ID4+IGRh
dmlkIEF0a2lucyA8ZGF2aWRAM2FkZXNpZ24uY28udWs+IHdyaXRlczoNCj4gPj4NCj4gPj4gPiAu
Li4NCj4gPj4gPj4gPj4+ICAgICAgICAgRXh0IFRhZzogRUhUIE9wZXJhdGlvbiAoODAyLjExYmUg
RDMuMCkNCj4gPj4gPj4gPj4+ICAgICAgICAgICAgIEV4dCBUYWcgbGVuZ3RoOiA4IChUYWcgbGVu
OiA5KQ0KPiA+PiA+PiA+Pj4gICAgICAgICAgICAgRXh0IFRhZyBOdW1iZXI6IEVIVCBPcGVyYXRp
b24gKDgwMi4xMWJlIEQzLjApICgxMDYpDQo+ID4+ID4+ID4+PiAgICAgICAgICAgICBFSFQgT3Bl
cmF0aW9uIFBhcmFtZXRlcnM6IDB4MDEsIEVIVCBPcGVyYXRpb24NCj4gPj4gPj4gPj4+IEluZm9y
bWF0aW9uDQo+ID4+ID4+IFByZXNlbnQNCj4gPj4gPj4gPj4+ICAgICAgICAgICAgICAgICAuLi4u
IC4uLjEgPSBFSFQgT3BlcmF0aW9uIEluZm9ybWF0aW9uIFByZXNlbnQ6IFRydWUNCj4gPj4gPj4g
Pj4+ICAgICAgICAgICAgICAgICAuLi4uIC4uMC4gPSBEaXNhYmxlZCBTdWJjaGFubmVsIEJpdG1h
cCBQcmVzZW50OiBGYWxzZQ0KPiA+PiA+PiA+Pj4gICAgICAgICAgICAgICAgIC4uLi4gLjAuLiA9
IEVIVCBEZWZhdWx0IFBFIER1cmF0aW9uOiBGYWxzZQ0KPiA+PiA+PiA+Pj4gICAgICAgICAgICAg
ICAgIC4uLi4gMC4uLiA9IEdyb3VwIEFkZHJlc3NlZCBCVSBJbmRpY2F0aW9uIExpbWl0OiBGYWxz
ZQ0KPiA+PiA+PiA+Pj4gICAgICAgICAgICAgICAgIC4uMDAgLi4uLiA9IEdyb3VwIEFkZHJlc3Nl
ZCBCVSBJbmRpY2F0aW9uIEV4cG9uZW50OiAwDQo+ID4+ID4+ID4+PiAgICAgICAgICAgICAgICAg
MDAuLiAuLi4uID0gUmVzZXJ2ZWQ6IDB4MA0KPiA+PiA+PiA+Pj4gICAgICAgICAgICAgQmFzaWMg
RUhULU1DUyBBbmQgTnNzIFNldDogMHg0NDQ0NDQ0NA0KPiA+PiA+PiA+Pj4gICAgICAgICAgICAg
Q29udHJvbDogMHgwMiwgQ2hhbm5lbCBXaWR0aDogODAgTUh6IEVIVCBCU1MgYmFuZHdpZHRoDQo+
ID4+ID4+ID4+PiAgICAgICAgICAgICAgICAgLi4uLiAuMDEwID0gQ2hhbm5lbCBXaWR0aDogODAg
TUh6IEVIVCBCU1MgYmFuZHdpZHRoICgyKQ0KPiA+PiA+PiA+Pj4gICAgICAgICAgICAgICAgIDAw
MDAgMC4uLiA9IFJlc2VydmVkOiAweDAwDQo+ID4+ID4+ID4+Pg0KPiA+PiA+PiA+Pj4gQXJlIHlv
dSBzYXlpbmcgdGhlIGF0aDEyayBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCB0aGVzZQ0KPiA+PiA+
PiA+Pj4gZmVhdHVyZXM/IElmIG5vdCBjYW4NCj4gPj4gPj4gPj4geW91IGNsYXJpZnkgdGhlIGlz
c3VlIHNvIEkgY2FuIHJhaXNlIHdpdGggdGhlIEFQIHRlYW0uDQo+ID4+ID4+ID4+Pg0KPiA+PiA+
PiA+PiBhdGgxMmsvV0NONzg1MCBzdXBwb3J0cyBFSFQsIGJ1dCB3aXRoIE5TUyBvbmx5IDIuIEhl
cmUgdGhlIEFQDQo+ID4+ID4+ID4+IHJlcXVpcmVzIE5TUyB0byBiZSBubyBsZXNzIHRoYW4gNCwg
dGhhdCBpcyB3aHkgRUhUIGNvbm5lY3Rpb24gd2FzDQo+IGRpc2FibGVkLg0KPiA+PiA+PiA+DQo+
ID4+ID4+ID4gV2hpY2ggZmllbGQgaXMgcmVxdWlyaW5nIE5TUyBvZiA0LCBJJ20gb25seSBzZWVp
bmcgYSBtYXhpbXVtIG9mDQo+ID4+ID4+ID4gNCwgdGhlDQo+ID4+ID4+IFF1YWxjb21tIHdpbmRv
d3MgZHJpdmVyIHdpbGwgY29ubmVjdCB0byB0aGUgc2FtZSBBUCwgd2UgaGFkDQo+ID4+ID4+IGFz
c3VtZWQgdGhhdCB0aGF0IGF0aDEyayB3b3VsZCBkbyB0aGUgc2FtZS4NCj4gPj4gPj4gQmFzaWMg
RUhULU1DUyBBbmQgTnNzIFNldDogMHg0NDQ0NDQ0NA0KPiA+PiA+DQo+ID4+ID4gTXkgdW5kZXJz
dGFuZGluZyBvZiB0aGUgc3BlYyBpcyB0aGF0IHRoZXJlIGFyZSBtYXhpbXVtIG51bWJlcnMgb2YN
Cj4gPj4gPiBzdHJlYW1zIHRob3VnaCwgYXJlIHlvdSBzYXlpbmcgdGhlIEFQIGhhcyB0byBhZHZl
cnRpc2UgMHgyMjIyMjIyMg0KPiA+PiA+IHdoaWNoIHdvdWxkIHRoZW4gcHJldmVudCBhIDR4NCBj
bGllbnQgKHNheSBhbiBleHRlbmRlcikgZnJvbQ0KPiA+PiA+IGNvbm5lY3Rpbmcgd2l0aCA0IHN0
cmVhbXM/IEkgbm90ZSB0aGF0IHRoZSBRdWFsY29tbSB3aW5kb3dzIGRyaXZlcg0KPiA+PiA+IGZv
ciBIYW1pbHRvbiB3b3JrcyB3aXRoIHRoZSBBUCBhbmQgYW4gSW50ZWwgQkUyMDAgYWxzbyB3b3Jr
cyBib3RoDQo+ID4+ID4gb2Ygd2hpY2ggd2lsbCBiZSBpbiBhdCBtb3N0IDJ4Mg0KPiA+Pg0KPiA+
PiBEaWQgeW91IHRlc3QgSW50ZWwgQkUyMDAgd2l0aCB0aGUgV2luZG93cyBkcml2ZXI/IEpvaGFu
bmVzIG1lbnRpb25lZA0KPiA+PiB0aGF0IGllZWU4MDIxMV92ZXJpZnlfc3RhX2VodF9tY3Nfc3Vw
cG9ydCgpIGluIG1hYzgwMjExIGNoZWNrcyB0aGlzDQo+ID4+IHNvIEkgd291bGQgYXNzdW1lIHRo
YXQgaXdsd2lmaSBhbHNvIGJlaGF2ZXMgbGlrZSBhdGgxMmsuDQo+ID4NCj4gPiBZZXMsIHRoaXMg
aXMgQVAgaXNzdWUgLSBob3N0YXBkIGZpeCByZXF1aXJlZCAtIGFkdmVydGlzZSAweDExMTExIC4u
Lg0KPiA+IEluIG90aGVyIGNhc2Ugc3RhdGlvbiAgPCA0bnNzIHdpbGwgZHJvcCB0byBIRSBvbmx5
Lg0KPiANCj4gVGhhbmtzLiBBbmQgSm9oYW5uZXMgcG9pbnRlZCBvdXQgdGhhdCB5b3UgaGFkIGV2
ZW4gZGlzY3Vzc2VkIGFib3V0IHRoaXMNCj4gYmVmb3JlOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtd2lyZWxlc3MvQ0FGRUQtams4cEpoZUpFVmlFU25FNTRmLQ0KPiBLK0pn
Uk1pV29pQ1NhMEdCdD1SS2FDbjdzd0BtYWlsLmdtYWlsLmNvbS8NCj4gDQoNClNvIHRoaXMgDQoN
CkJhc2ljIEVIVC1NQ1MgQW5kIE5zcyBTZXQ6IDB4NDQ0NDQ0NDQNCg0KU2hvdWxkIGJlIDB4MTEx
MTExMTEgPyBhbmQgaXQgZGVmaW5lcyB0aGUgbWluaW11bSBudW1iZXIgb2Ygc3RyZWFtcyBuZWVk
ZWQgdG8gY29ubmVjdD8NCg0KVGhpcyB0aGUgZGVmaW5lcyB0aGUgbWF4IHN0cmVhbXMgPw0KDQog
ICAgICAgICAgICBTdXBwb3J0ZWQgRUhULU1DUyBhbmQgTlNTIFNldA0KICAgICAgICAgICAgICAg
IEVIVC1NQ1MgTWFwIChCVyA8PSA4ME1Ieik6IDB4NDQ0NDQ0DQogICAgICAgICAgICAgICAgICAg
IC4uLi4gLi4uLiAuLi4uIC4uLi4gLi4uLiAwMTAwID0gUnggTWF4IE5zcyBUaGF0IFN1cHBvcnRz
IEVIVC1NQ1MgMC05OiA0DQogICAgICAgICAgICAgICAgICAgIC4uLi4gLi4uLiAuLi4uIC4uLi4g
MDEwMCAuLi4uID0gVHggTWF4IE5zcyBUaGF0IFN1cHBvcnRzIEVIVC1NQ1MgMC05OiA0DQogICAg
ICAgICAgICAgICAgICAgIC4uLi4gLi4uLiAuLi4uIDAxMDAgLi4uLiAuLi4uID0gUnggTWF4IE5z
cyBUaGF0IFN1cHBvcnRzIEVIVC1NQ1MgMTAtMTE6IDQNCiAgICAgICAgICAgICAgICAgICAgLi4u
LiAuLi4uIDAxMDAgLi4uLiAuLi4uIC4uLi4gPSBUeCBNYXggTnNzIFRoYXQgU3VwcG9ydHMgRUhU
LU1DUyAxMC0xMTogNA0KICAgICAgICAgICAgICAgICAgICAuLi4uIDAxMDAgLi4uLiAuLi4uIC4u
Li4gLi4uLiA9IFJ4IE1heCBOc3MgVGhhdCBTdXBwb3J0cyBFSFQtTUNTIDEyLTEzOiA0DQogICAg
ICAgICAgICAgICAgICAgIDAxMDAgLi4uLiAuLi4uIC4uLi4gLi4uLiAuLi4uID0gVHggTWF4IE5z
cyBUaGF0IFN1cHBvcnRzIEVIVC1NQ1MgMTItMTM6IDQNCg0KDQpkYXZpZA0K

