Return-Path: <linux-wireless+bounces-18489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF48A284D0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 08:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16207A1FB5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 07:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35A21773E;
	Wed,  5 Feb 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="caqvyays"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC615219A7D
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738917; cv=fail; b=QkEYztDJ5fERdAZ4SmZFuikLolu8MF83tPWcSK5kaD5VJ40gRKLt1VyQAysXjerFJ24BVmyvFap47oXbfxruIbJCXUgHEPx3U/SX2dwjFvWoAs4v+AJSKb0mDi6qDG6g0PQpNmLbJl8eQZp0jufpkskhA9UyZ8UDS/6d3XZ3oIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738917; c=relaxed/simple;
	bh=AX9r7w9P+cPkvPw8/RBBZtBKzNeN5hcSjANTOW4fVGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sFf2TQ+VBMT02nujdsKvDJe+WfP0N2fGpVdwRqaB/pVcFSDtQG1TBhpVEdA7BJCjpqrRWpngRhJFBmDV3elHJ+RZN6VeTN3ihnfsZJmrGu/IDw21glWigS/3XpwUSX6eAM4TBFn05omyHJVyrd9H318OYAcA90Wq567InO3WBc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=caqvyays; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5155hkkx020551;
	Wed, 5 Feb 2025 06:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zws9bnc32AwIYuJNZCeSlM/cvV63Cwr8lsusWW88qtQ=; b=caqvyayslExdPd3q
	jhXwWfnwwaz6llm5Wdl8bCsxNPLGE5haDU15Xr+utVmUEc2JRZuYT6mg0m9W2CbI
	LzRB5OOYWAN5+6SxOZbvsCOLzEyWsSVlBC+9Gh2SP996pmR8w7ynjGBk4pCyqzfK
	V/81Rwxn2D/6g+hujk9YDgZIWKm8PIftONjPKrfqr7IFL9UwnUlrbEf6SV49jNLC
	8FaOIu/KCF6GIFXfyHVm8PYzg8FTqqlu2yfV6C2ZsR1IpsxQuN6JvN0egU0yyH/W
	K1j26k+7qb0sk5JkyVkiDI0dEaxgyOD5T6IOU0VQ5FdQy05IpUejFlQbJqshU4gX
	FF+cVQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012038.outbound.protection.outlook.com [40.93.6.38])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44m23g83hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 06:37:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erbR/5vNxcQ5+Ucf+REbJlYrfnqzueJXkLCR5QqxMS+Ebxji6Sts4DiikIfvDvE2oGd0wJNr9KVDr6DdVoBaVH8Aj8PthPa0WPRa+PbR2po0Dt+nabNje6s2szSoitrIQ/McaqO9D6ECXSi9wnLoBg2cyQpgLyVHqA/QeDw+i29UNQp2TyPtVr/Ko6rcLIuokYei2ad9lMKFauLgIV/uEPQQrLBAQeqfRLptSLPBzrZlfVHz7NMTKItI6NbdUyWSrb91RX3VJn8n9pGLryFUL+y+tsKS7m5XzzOxcw+63bFtU5YvtGAuweQHSXCg6hTVoH/ci7asNMx2ZCr4S6g7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zws9bnc32AwIYuJNZCeSlM/cvV63Cwr8lsusWW88qtQ=;
 b=e/gFacpw9+KQtWVkq0wvirCbrg/lx2h2uf16Tg0R0mzdaRdiQAPnRol+iSKbklMav8SWchMhbVSQMoihLIVVblfkQB9ZKXuMzSVLlPiLDw5WEBSuFPIjLnJZlxgqJDPZQReOmEkvCVZWrpHdZjfn9RqgZXtVFS/gQIbRJGmFoUJRFTL44iAWRrzSx3p51Yky6JWHK/QLQq7zDwWXxW3dQYxMSa6hsrVQNlRVbb2bIUwb/mH2LTeEd/dQfnxcVdYTpn2UeivJRcQlarNnz6PD5W8QwY7Rs4LITm139yHWgdplNhkkFDwuGvis9OUXmYBZwDfeXqjTO5hVP3kZ9h+y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL3PR02MB8163.namprd02.prod.outlook.com (2603:10b6:208:35e::13)
 by SA2PR02MB7721.namprd02.prod.outlook.com (2603:10b6:806:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 06:37:10 +0000
Received: from BL3PR02MB8163.namprd02.prod.outlook.com
 ([fe80::d217:1a93:30d1:416a]) by BL3PR02MB8163.namprd02.prod.outlook.com
 ([fe80::d217:1a93:30d1:416a%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 06:37:10 +0000
From: "Tamizh Chelvam Raja (QUIC)" <quic_tamizhr@quicinc.com>
To: "Balamurugan Mahalingam (QUIC)" <quic_bmahalin@quicinc.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Balamurugan Mahalingam (QUIC)" <quic_bmahalin@quicinc.com>
Subject: RE: [PATCH v4] wifi: ath12k: Add support for link specific datapath
 stats
Thread-Topic: [PATCH v4] wifi: ath12k: Add support for link specific datapath
 stats
Thread-Index: AQHbdoM83Dl6T+mBlk670CM7JzfJ5rM4PIOQ
Date: Wed, 5 Feb 2025 06:37:10 +0000
Message-ID:
 <BL3PR02MB8163BE57AD5EF563FD8A76B383F72@BL3PR02MB8163.namprd02.prod.outlook.com>
References: <20250203213237.2695131-1-quic_bmahalin@quicinc.com>
In-Reply-To: <20250203213237.2695131-1-quic_bmahalin@quicinc.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB8163:EE_|SA2PR02MB7721:EE_
x-ms-office365-filtering-correlation-id: 71c86b4d-d35a-4192-5cce-08dd45af84ad
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XADhF+DYi7g09QZEq485uglD6Ugih6Bqn14BTZQvxHK3cZDtBvmRIHjlw9qe?=
 =?us-ascii?Q?AnNsUmwrLR0zXkXmEG2fsOC2VUB0NhsrCNllmyFo47QBNArXOCWkialv0NpZ?=
 =?us-ascii?Q?Jd+aUE6GV+XMcNgBJ/OVhfR+yffJaeWUOpLgiCRcaXL4fCOF7EJVRvS8Xv1Y?=
 =?us-ascii?Q?u5pki0ifJvw+TThN03t0Cz0vuPvPUaUTWzi4fdDg9n+EMMAAVPMUSPiQG76I?=
 =?us-ascii?Q?RPE7KscQNM7B51VfXPDjd+bBNnZq1YKTnl3zLHxugn9Homjnv5+KAGkskAZW?=
 =?us-ascii?Q?oE2jkUxdd5xP+5Qmo48NEDXVQYTvV7r2bugdOGqFFhf2YzwmxVKrMQsYvWlo?=
 =?us-ascii?Q?9bkTCn6s0tM3VbDQVe1GnKB+pvlrX8J9gdAh1BDO83B+xuZGeeh+LO4JGM1T?=
 =?us-ascii?Q?OHGRgkLLaatfg6wwpD0aGZ35tnJ3L2scfHIz9U2SPwjoTuDchtUAsk6HYSsW?=
 =?us-ascii?Q?m5DI+z44ZJQwlvZTJG2poz9tMI49yW+qYxkDzBBmZZKjJVBcsGgDYMAs8raU?=
 =?us-ascii?Q?/5v4T5hpVCJ4zf2sD/ROkr5NPutim6IuMVSagCT7ZLPXl8pX+0xl48KZk65I?=
 =?us-ascii?Q?OZU1ENI/wP8MH0gmjMpcGmu3QsTm6KyVQTQHIk2V8KmydWnDylUN3ZKyVeb7?=
 =?us-ascii?Q?1Wjv/ZejHRSo++IAHBUeC+Q8+NgEU7AXU7fDqMPYI297h7NO6QUx9Dbaxn7D?=
 =?us-ascii?Q?u60vXWTFRDodSSlbDMUDIv3awa6YQGRl5hIsXKF7oCh7zYqz4F8UTp/j+19l?=
 =?us-ascii?Q?kV4hgqUznJ4xi8zhTrREMhlZl7Ud0FnU0qqUV2KZewgwDLafesIi5ABzLOL5?=
 =?us-ascii?Q?AT/gVCEbNM5XvVvGYTJmNEf4lhX7URkmO3L40SoAOTSSuG/GhU4W6aoRlRXu?=
 =?us-ascii?Q?7RuQ+p7RdQWrVBJX0o2/3jXlSGWnCZvUwCciutjtB05TPiU4DY0xCORv1jFl?=
 =?us-ascii?Q?IdavZUGJgqDKHWtR0/JoDqsSMNXt91lhc2yC4xyFAZXnhW7Xzchm8DrYHTQj?=
 =?us-ascii?Q?xS88AvCw1Bhis3voRGrs5essnTygg3wOTFERsa+CM7XrrqDO3yNW0CydZYKf?=
 =?us-ascii?Q?ACc8fEo2WZ8wu/YHTA9HVaAaMJdmXBcSrvnV43ofRkVZwI0ykGSbn2Zvr0tQ?=
 =?us-ascii?Q?Y+spo6pe9xbNFb23UPWMY+IvANBiOh1GejzTH/hz+PvttmwBlByXJ/Gm8+qP?=
 =?us-ascii?Q?r7sL8TmQwnZSl130+80NL+NmjqBIFPtPzrBAz+FyIwl374qX1SIqVzXtmL+D?=
 =?us-ascii?Q?9lkTeWGfWKbLZoGXKQspRDmrhJHVbalXHiv4G5+2j/Uhx8qEv7RKS8znF4NG?=
 =?us-ascii?Q?ER9OdVnr5cNI8OkYQR3WddeJ5yn2VExFxtxXAwZmvpzC8AGKd7G82oCAfV4D?=
 =?us-ascii?Q?7GPFcrKXOHBENIGYcnyMp+Tpui08fBrItiE4XH4qIBVoaZV2db0ZBgn69JbI?=
 =?us-ascii?Q?ZCMwY+OIhWdaFCiEuGzLK4UqSvnqZLmn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8163.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T36UkvYz5Iqpb6i+wO9wHeoPcBPtrAY9sNaLW/RjQZ+hBGnyv4VHBgbcqGVt?=
 =?us-ascii?Q?vKm9FmhIx1EiX0KQRUXXMRKWMNeo/hC8b7KdnlTubmt3WgctjxBBpkSNE36U?=
 =?us-ascii?Q?b0Kz70PqzDNgXUfDu7jW1b9GJqV9+PmVHRUYSc/yebT59fEWFWp+y63k6tan?=
 =?us-ascii?Q?I1d23U5W0BvdZAh4cTUyejuvNpsSV8SWqs0ua8WOMsEKmjiDKbyT3gP7d8JZ?=
 =?us-ascii?Q?G5ULewFxnn8YrmH7qclNzhTZaU4/Ah4gJjm1R/1IMOUnKh9wvYx36noJ7aNv?=
 =?us-ascii?Q?CuhMELQNmCo7bIIN+F1PsvkAaO3wCT8Hy8/++AInQ4eR3rNzp0QV6ZJomztT?=
 =?us-ascii?Q?ckSn+LBQbzdhZwIxgf32l+QsPmmK3eTrxfmj7G2TtvBg+FVCrZXJJsHdLziq?=
 =?us-ascii?Q?ImJ/V21lVYCcmJMGwSRc/U/lzqYIvs6gu6zOJX2o8+xPKxs5Kz7IB9cN48x6?=
 =?us-ascii?Q?FO8VG5ZwJYOw26WIBZ5hbf9DhOTiWdLWaTbOBvg++npizlXZvHeqgMlACzyv?=
 =?us-ascii?Q?wx9L+VY0PH5YeXDwb0NF8+/T5M9MEQoffVUgzqCG3fbCGVEFPA9lNdf2m/rM?=
 =?us-ascii?Q?vU0agcV/fkpC5xnXqS1xsKW33Rq2A2XwFPFJpQPONek/YrzIpVuoe/ZAKg3t?=
 =?us-ascii?Q?O/U2kP92Bq0YkmoKwCf2hYiycVRguiNEfekDcYXEpbFFvhCdVR/AAYmi2eN6?=
 =?us-ascii?Q?oYLWQbc5a3D42WFy8MdORAPs9kopn6eD55RjTEEMGRBriEoD9inhMjRJZ/DN?=
 =?us-ascii?Q?wJ1h3drwCmxLw8xEYi0MLI7pALS7HeB9shRFNOpWADaIDSman5+wKa/3PEdp?=
 =?us-ascii?Q?XeRHvu1VrPB9yRf3I7k9nT6oWj9hcKuVAbHzu8T2y2Vcf9oPMJmGmoJwCgTO?=
 =?us-ascii?Q?nP8CkSUAosVhWWiQk/VDEHMbJ11UO0J8j3Vspxz4eCUYHY0cz6X9j3PvPmSS?=
 =?us-ascii?Q?2jQXZ9icIf01fr6X6wkiZc/EjFIQAzvrl/VSa/xgi4Om0VELmzRKFhlWoqGN?=
 =?us-ascii?Q?0hSURp/wHbFWCXd+ZQwDAMOXVPc9VdgNHmCuu94J39l/QQQahaXp+xx/Vvx6?=
 =?us-ascii?Q?o8a78pR1G8K7JSjhpCulNoBL/VJnU7u4Qcu5a3Qq0wk1P4RnqUOtzcyzuYWQ?=
 =?us-ascii?Q?dBQU4iJuWDTgUu7Fc7hwXgTvOZKf/d1yVzxGLFl84y1pegLyDUjWIL1GPbUq?=
 =?us-ascii?Q?+8TT/ZgIwtNqtP6EftH+DZ2WRQo0HiS9PqJwMyJPZH5OIJNXPBzdyU/gVu/7?=
 =?us-ascii?Q?qIoDVRsLjZ81+qAxk/V1jqdDGEe3IV0FcD9Wci8DJbqWQFLbjRSqMWuRqLV7?=
 =?us-ascii?Q?xVimIH/IXzOgQ0j0bhkQnYIMcQuycxjH9A4ycg0El+OvYRjv0mBtasND77YL?=
 =?us-ascii?Q?G9LqVqmF3uVQyRI3PXf7ccZGfXdN5d691w72PQ/Bgljvh8W6NFPQwXGv1h4F?=
 =?us-ascii?Q?NskIH1fr4Rs/VAnAyDuE07SFl2NYSVB0BpM+R1W/aSgAFz//HAw5SPhxdpGK?=
 =?us-ascii?Q?IRRZZCO2dqYnPmbzWVcnkrCnYGbtH5Q5o5bk7wmTJ7KZeqY4puNG0r5R5rfP?=
 =?us-ascii?Q?/7NuGC+U53Sqly3nBfFO9u0iAQZ5R/8UIaMsA9dH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0+h6n8bV+nVowtheEXju2tBVGOxyoUL6Zs9+U9wGculOCrg0CTN+N4IUxFw9rPqmgSz6j7DXqr7fHTGPaqlcl//zZ6GyphlF1IopW5nSVSrJ2PZs95S6sb7WE317ZtPWxPPOetp9b0qKQQYAfbS9tgMrDASvWU6iLFMvoSAdEownBiMKv+u4L6Ax8nNatYWuS72HxrWKYCRntg8mi9DtcjpAqFNOr/EFeBnJLo5ZiEvwMebDa+pyuP3OGYKx1iztEFuIAIScr6poPB8FSXo/wdcg75DkQICn7Xciq+rAnbuAoiYn3wCk/A5jJ+jg6NISn1MpSiahSbL8TIV2nqY4kZOMhY0YYsE0Ogx0x7ixBhoVWOV97br8Ot/tS5ZNMDJED8KL8Ti2Q8HO59Z5ZOiOAy1zR25FiZJuY392clc1f84zV8we2TJ6BDS29P6oyWKfPZon184GVHcX7zgB4AzxsmKxMloyp4yBy9Xkz08Uk/l8hyCDMnbx76hZVL7jkNDMkopWZDX3TGigV3w6CkVV7qDger50PC33ByvrLlkk0thkSLabkJDf3m2J0wlYx297VmJocBuVhlBkli9pnR4BJrM/Ilrbf9hwo9GbtugiOffM1m4t2Ju/SnKLuBYoXvX2
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8163.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c86b4d-d35a-4192-5cce-08dd45af84ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 06:37:10.3685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPI03VYQbFF5NIerpbVwDqge34XOgK7i8oHG0BGtJcE/FsbyQH5UAw511WycJpw6ZC2OXgYuBBRpC5Q+3fFMT9jjqNuWmpYDZ+eLdL6BRtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7721
X-Proofpoint-GUID: qbtZgcdbebuWnZ851XUE7fK0fscSERss
X-Proofpoint-ORIG-GUID: qbtZgcdbebuWnZ851XUE7fK0fscSERss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_02,2025-02-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050051

>WARNING: This email originated from outside of Qualcomm. Please be wary of=
 any
>links or attachments, and do not enable macros.
>
>Add support to record the number of frames enqueued, hardware descriptor t=
ype,
>encapsulation/encryption types used, frames dropped and completed. This is
>useful for understanding the datapath performance and tune the peak throug=
hput.
>
>The link specific stats can be viewed through the below debugfs file
>
>cat /sys/kernel/debug/ieee80211/phy0/netdev:wlan1/link_stats
>link[0] Tx Unicast Frames Enqueued  =3D 9
>link[0] Tx Broadcast Frames Enqueued =3D 78689 link[0] Tx Frames Completed=
 =3D
>78698 link[0] Tx Frames Dropped =3D 0 link[0] Tx Frame descriptor Encap Ty=
pe =3D
>raw:0 native wifi:78698 ethernet:0 link[0] Tx Frame descriptor Encrypt Typ=
e =3D
>0:78698 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0 link[0] Tx Frame des=
criptor
>Type =3D buffer:78698 extension:0
>------------------------------------------------------
>link[1] Tx Unicast Frames Enqueued  =3D 0
>link[1] Tx Broadcast Frames Enqueued =3D 78689 link[1] Tx Frames Completed=
 =3D
>78689 link[1] Tx Frames Dropped =3D 0 link[1] Tx Frame descriptor Encap Ty=
pe =3D
>raw:0 native wifi:78689 ethernet:0 link[1] Tx Frame descriptor Encrypt Typ=
e =3D
>0:78689 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0 link[1] Tx Frame des=
criptor
>Type =3D buffer:78689 extension:0
>------------------------------------------------------
>
>Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-
>1
>Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-
>QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
>Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
>---
>
>Depends-on: [PATCH v4 0/2] wifi: ath12k: Add support for MLO Multicast Han=
dling
>Link: https://patchwork.kernel.org/project/linux-wireless/list/?series=3D9=
30206
>
>v4:
>    Rebased on top of dependent patch.
>
>v3: https://patchwork.kernel.org/project/linux-
>wireless/patch/20250203080032.3983556-1-quic_bmahalin@quicinc.com/
>    Rebased on top of dependent patch.
>
>v2: https://patchwork.kernel.org/project/linux-
>wireless/patch/20250203025714.3852826-1-quic_bmahalin@quicinc.com/
>    Rebased on top of master branch.
>
>v1: https://patchwork.kernel.org/project/linux-
>wireless/patch/20250110205912.2585850-1-quic_bmahalin@quicinc.com/
>
> drivers/net/wireless/ath/ath12k/core.h     |   2 +
> drivers/net/wireless/ath/ath12k/debugfs.c  | 118 +++++++++++++++++++++
> drivers/net/wireless/ath/ath12k/debugfs.h  |   7 ++
> drivers/net/wireless/ath/ath12k/dp.h       |  11 ++
> drivers/net/wireless/ath/ath12k/dp_tx.c    |  51 ++++++++-
> drivers/net/wireless/ath/ath12k/dp_tx.h    |   3 +-
> drivers/net/wireless/ath/ath12k/hal_desc.h |   6 +-
> drivers/net/wireless/ath/ath12k/mac.c      |  10 +-
> 8 files changed, 202 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/wireless/ath/ath12k/core.h
>b/drivers/net/wireless/ath/ath12k/core.h
>index b8c336bc02d8..118bf7ae914a 100644
>--- a/drivers/net/wireless/ath/ath12k/core.h
>+++ b/drivers/net/wireless/ath/ath12k/core.h
>@@ -301,6 +301,8 @@ struct ath12k_link_vif {
>        u8 link_id;
>        struct ath12k_vif *ahvif;
>        struct ath12k_rekey_data rekey_data;
>+       struct ath12k_link_stats link_stats;
>+       spinlock_t link_stats_lock; /* Protects updates to link_stats */
> };
>
> struct ath12k_vif {
>diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c
>b/drivers/net/wireless/ath/ath12k/debugfs.c
>index 6d6708486d14..d737a581bb85 100644
>--- a/drivers/net/wireless/ath/ath12k/debugfs.c
>+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
>@@ -32,6 +32,124 @@ static const struct file_operations fops_simulate_rada=
r =3D {
>        .open =3D simple_open
> };
>
>+static int ath12k_open_link_stats(struct inode *inode, struct file
>+*file) {
>+       struct ath12k_vif *ahvif =3D inode->i_private;
>+       size_t len =3D 0, buf_len =3D (PAGE_SIZE * 2);
>+       struct ath12k_link_stats linkstat;
>+       struct ath12k_link_vif *arvif;
>+       unsigned long links_map;
>+       struct wiphy *wiphy;
>+       int link_id, i;
>+       char *buf;
>+
>+       if (!ahvif)
>+               return -EINVAL;
>+
>+       buf =3D kzalloc(buf_len, GFP_KERNEL);
>+       if (!buf)
>+               return -ENOMEM;
>+
>+       wiphy =3D ahvif->ah->hw->wiphy;
>+       wiphy_lock(wiphy);
>+
>+       links_map =3D ahvif->links_map;
>+       for_each_set_bit(link_id, &links_map,
>+                        IEEE80211_MLD_MAX_NUM_LINKS) {
>+               arvif =3D rcu_dereference_protected(ahvif->link[link_id],
>+
>+ lockdep_is_held(&wiphy->mtx));
>+

Here arvif can be NULL, so it would be good to check before using it.

>+               spin_lock_bh(&arvif->link_stats_lock);
>+               linkstat =3D arvif->link_stats;
>+               spin_unlock_bh(&arvif->link_stats_lock);
>+
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                "link[%d] Tx Unicast Frames Enqueued  =3D=
 %d\n",
>+                                link_id, linkstat.tx_enqueued);
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                "link[%d] Tx Broadcast Frames Enqueued =
=3D %d\n",
>+                                link_id, linkstat.tx_bcast_mcast);
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                "link[%d] Tx Frames Completed =3D %d\n",
>+                                link_id, linkstat.tx_completed);
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                "link[%d] Tx Frames Dropped =3D %d\n",
>+                                link_id, linkstat.tx_dropped);
>+
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                "link[%d] Tx Frame descriptor Encap Type =
=3D ",
>+                                link_id);
>+
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                        " raw:%d",
>+                                        linkstat.tx_encap_type[0]);
>+
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                        " native_wifi:%d",
>+                                        linkstat.tx_encap_type[1]);
>+
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                        " ethernet:%d",
>+                                        linkstat.tx_encap_type[2]);

Like encrypt type stats below this also can be put it in a loop.

>+
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                "\nlink[%d] Tx Frame descriptor Encrypt T=
ype =3D ",
>+                                link_id);
>+
>+               for (i =3D 0; i < HAL_ENCRYPT_TYPE_MAX; i++) {
>+                       len +=3D scnprintf(buf + len, buf_len - len,
>+                                        " %d:%d", i,
>+                                        linkstat.tx_encrypt_type[i]);
>+               }
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                                "\nlink[%d] Tx Frame descriptor Type =3D =
buffer:%d
>extension:%d\n",
>+                                link_id, linkstat.tx_desc_type[0],
>+                                linkstat.tx_desc_type[1]);
>+
>+               len +=3D scnprintf(buf + len, buf_len - len,
>+                               "-----------------------------------------=
-------------\n");
>+       }
>+
>+       wiphy_unlock(wiphy);
>+
>+       file->private_data =3D buf;
>+
>+       return 0;
>+}
>+
>+static int ath12k_release_link_stats(struct inode *inode, struct file
>+*file) {
>+       kfree(file->private_data);
>+       return 0;
>+}
>+
>+static ssize_t ath12k_read_link_stats(struct file *file,
>+                                     char __user *user_buf,
>+                                     size_t count, loff_t *ppos) {
>+       const char *buf =3D file->private_data;
>+       size_t len =3D strlen(buf);
>+
>+       return simple_read_from_buffer(user_buf, count, ppos, buf, len);
>+}
>+
>+static const struct file_operations ath12k_fops_link_stats =3D {
>+       .open =3D ath12k_open_link_stats,
>+       .release =3D ath12k_release_link_stats,
>+       .read =3D ath12k_read_link_stats,
>+       .owner =3D THIS_MODULE,
>+       .llseek =3D default_llseek,
>+};
>+
>+void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
>+                              struct ieee80211_vif *vif) {
>+       struct ath12k_vif *ahvif =3D ath12k_vif_to_ahvif(vif);
>+
>+       debugfs_create_file("link_stats", 0400, vif->debugfs_dir, ahvif,
>+                           &ath12k_fops_link_stats); }
>+
> void ath12k_debugfs_soc_create(struct ath12k_base *ab)  {
>        bool dput_needed;
>diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h
>b/drivers/net/wireless/ath/ath12k/debugfs.h
>index 1c30745ee415..db87d9ad17c8 100644
>--- a/drivers/net/wireless/ath/ath12k/debugfs.h
>+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
>@@ -15,6 +15,8 @@ void ath12k_debugfs_unregister(struct ath12k *ar);  void
>ath12k_debugfs_fw_stats_process(struct ath12k *ar,
>                                     struct ath12k_fw_stats *stats);  void
>ath12k_debugfs_fw_stats_reset(struct ath12k *ar);
>+void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
>+                              struct ieee80211_vif *vif);
> #else
> static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)  { @=
@ -40,6
>+42,11 @@ static inline void ath12k_debugfs_fw_stats_process(struct ath12k=
 *ar,
>static inline void ath12k_debugfs_fw_stats_reset(struct ath12k *ar)  {  }
>+
>+static inline void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
>+                                            struct ieee80211_vif *vif)
>+{ }
> #endif /* CONFIG_ATH12K_DEBUGFS */
>
> #endif /* _ATH12K_DEBUGFS_H_ */
>diff --git a/drivers/net/wireless/ath/ath12k/dp.h
>b/drivers/net/wireless/ath/ath12k/dp.h
>index 75435a931548..1bcac114f09a 100644
>--- a/drivers/net/wireless/ath/ath12k/dp.h
>+++ b/drivers/net/wireless/ath/ath12k/dp.h
>@@ -7,6 +7,7 @@
> #ifndef ATH12K_DP_H
> #define ATH12K_DP_H
>
>+#include "hal_desc.h"
> #include "hal_rx.h"
> #include "hw.h"
>
>@@ -313,6 +314,16 @@ struct ath12k_reo_q_addr_lut {
>        u32 *vaddr;
> };
>
>+struct ath12k_link_stats {
>+       u32 tx_enqueued;
>+       u32 tx_completed;
>+       u32 tx_bcast_mcast;
>+       u32 tx_dropped;
>+       u32 tx_encap_type[HAL_TCL_ENCAP_TYPE_MAX];
>+       u32 tx_encrypt_type[HAL_ENCRYPT_TYPE_MAX];
>+       u32 tx_desc_type[HAL_TCL_DESC_TYPE_MAX];
>+};
>+
> struct ath12k_dp {
>        struct ath12k_base *ab;
>        u8 num_bank_profiles;
>diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c
>b/drivers/net/wireless/ath/ath12k/dp_tx.c
>index 1896178d2d4f..94b9f41941a1 100644
>--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>@@ -219,7 +219,8 @@ static int ath12k_dp_tx_align_payload(struct ath12k_ba=
se
>*ab,  }
>
> int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>-                struct sk_buff *skb, bool gsn_valid, int mcbc_gsn)
>+                struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
>+                bool is_mcast)
> {
>        struct ath12k_base *ab =3D ar->ab;
>        struct ath12k_dp *dp =3D &ab->dp;
>@@ -464,6 +465,17 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_lin=
k_vif
>*arvif,
>                goto fail_unmap_dma;
>        }
>
>+       spin_lock_bh(&arvif->link_stats_lock);
>+       arvif->link_stats.tx_encap_type[ti.encap_type]++;
>+       arvif->link_stats.tx_encrypt_type[ti.encrypt_type]++;
>+       arvif->link_stats.tx_desc_type[ti.type]++;
>+
>+       if (is_mcast)
>+               arvif->link_stats.tx_bcast_mcast++;
>+       else
>+               arvif->link_stats.tx_enqueued++;
>+       spin_unlock_bh(&arvif->link_stats_lock);
>+
>        ath12k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
>
>        ath12k_hal_srng_access_end(ab, tcl_ring); @@ -487,6 +499,11 @@ int
>ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>
> fail_remove_tx_buf:
>        ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
>+
>+       spin_lock_bh(&arvif->link_stats_lock);
>+       arvif->link_stats.tx_dropped++;
>+       spin_unlock_bh(&arvif->link_stats_lock);
>+
>        if (tcl_ring_retry)
>                goto tcl_ring_sel;
>
>@@ -522,7 +539,10 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base
>*ab,
>                                 struct ath12k_dp_htt_wbm_tx_status *ts)  =
{
>        struct ieee80211_tx_info *info;
>+       struct ath12k_link_vif *arvif;
>        struct ath12k_skb_cb *skb_cb;
>+       struct ieee80211_vif *vif;
>+       struct ath12k_vif *ahvif;
>        struct ath12k *ar;
>
>        skb_cb =3D ATH12K_SKB_CB(msdu);
>@@ -538,6 +558,19 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base
>*ab,
>                dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
>                                 sizeof(struct hal_tx_msdu_ext_desc), DMA_=
TO_DEVICE);
>
>+       vif =3D skb_cb->vif;
>+       if (vif) {
>+               ahvif =3D ath12k_vif_to_ahvif(vif);
>+               rcu_read_lock();
>+               arvif =3D rcu_dereference(ahvif->link[skb_cb->link_id]);
>+               if (arvif) {
>+                       spin_lock_bh(&arvif->link_stats_lock);
>+                       arvif->link_stats.tx_completed++;
>+                       spin_unlock_bh(&arvif->link_stats_lock);
>+               }
>+               rcu_read_unlock();
>+       }
>+
>        memset(&info->status, 0, sizeof(info->status));
>
>        if (ts->acked) {
>@@ -592,7 +625,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct
>ath12k_base *ab,
>                 */
>                break;
>        default:
>-               ath12k_warn(ab, "Unknown htt tx status %d\n", wbm_status);
>+               ath12k_warn(ab, "Unknown htt wbm tx status %d\n",
>+ wbm_status);
>                break;
>        }
> }
>@@ -722,7 +755,10 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k
>*ar,
>        struct ath12k_base *ab =3D ar->ab;
>        struct ath12k_hw *ah =3D ar->ah;
>        struct ieee80211_tx_info *info;
>+       struct ath12k_link_vif *arvif;
>        struct ath12k_skb_cb *skb_cb;
>+       struct ieee80211_vif *vif;
>+       struct ath12k_vif *ahvif;
>
>        if (WARN_ON_ONCE(ts->buf_rel_source !=3D
>HAL_WBM_REL_SRC_MODULE_TQM)) {
>                /* Must not happen */
>@@ -748,6 +784,17 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k
>*ar,
>                goto exit;
>        }
>
>+       vif =3D skb_cb->vif;
>+       if (vif) {
>+               ahvif =3D ath12k_vif_to_ahvif(vif);
>+               arvif =3D rcu_dereference(ahvif->link[skb_cb->link_id]);
>+               if (arvif) {
>+                       spin_lock_bh(&arvif->link_stats_lock);
>+                       arvif->link_stats.tx_completed++;
>+                       spin_unlock_bh(&arvif->link_stats_lock);
>+               }
>+       }
>+
>        info =3D IEEE80211_SKB_CB(msdu);
>        memset(&info->status, 0, sizeof(info->status));
>
>diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h
>b/drivers/net/wireless/ath/ath12k/dp_tx.h
>index a5904097dc34..10acdcf1fa8f 100644
>--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
>+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
>@@ -17,7 +17,8 @@ struct ath12k_dp_htt_wbm_tx_status {
>
> int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);  int
>ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
>-                struct sk_buff *skb, bool gsn_valid, int mcbc_gsn);
>+                struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
>+                bool is_mcast);
> void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)=
;
>
> int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask); dif=
f --git
>a/drivers/net/wireless/ath/ath12k/hal_desc.h
>b/drivers/net/wireless/ath/ath12k/hal_desc.h
>index 3e8983b85de8..aba1023ec619 100644
>--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
>+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
>@@ -1,7 +1,7 @@
> /* SPDX-License-Identifier: BSD-3-Clause-Clear */
> /*
>  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rig=
hts
>reserved.
>+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. Al=
l
>rights reserved.
>  */
> #include "core.h"
>
>@@ -1263,6 +1263,7 @@ struct hal_reo_flush_cache {
>
> #define HAL_TCL_DATA_CMD_INFO5_RING_ID                 GENMASK(27, 20)
> #define HAL_TCL_DATA_CMD_INFO5_LOOPING_COUNT           GENMASK(31, 28)
>+#define HAL_ENCRYPT_TYPE_MAX 12
>
> enum hal_encrypt_type {
>        HAL_ENCRYPT_TYPE_WEP_40,
>@@ -1284,11 +1285,13 @@ enum hal_tcl_encap_type {
>        HAL_TCL_ENCAP_TYPE_NATIVE_WIFI,
>        HAL_TCL_ENCAP_TYPE_ETHERNET,
>        HAL_TCL_ENCAP_TYPE_802_3 =3D 3,
>+       HAL_TCL_ENCAP_TYPE_MAX
> };
>
> enum hal_tcl_desc_type {
>        HAL_TCL_DESC_TYPE_BUFFER,
>        HAL_TCL_DESC_TYPE_EXT_DESC,
>+       HAL_TCL_DESC_TYPE_MAX,
> };
>
> enum hal_wbm_htt_tx_comp_status {
>@@ -1298,6 +1301,7 @@ enum hal_wbm_htt_tx_comp_status {
>        HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ,
>        HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT,
>        HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY,
>+       HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH,
>        HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX,
> };
>
>diff --git a/drivers/net/wireless/ath/ath12k/mac.c
>b/drivers/net/wireless/ath/ath12k/mac.c
>index b3907ac05f69..95c8c30df4c0 100644
>--- a/drivers/net/wireless/ath/ath12k/mac.c
>+++ b/drivers/net/wireless/ath/ath12k/mac.c
>@@ -3980,6 +3980,9 @@ static struct ath12k_link_vif
>*ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
>        arvif->link_id =3D link_id;
>        ahvif->links_map |=3D BIT(link_id);
>
>+       /* Protects the datapath stats update on a per link basis */
>+       spin_lock_init(&arvif->link_stats_lock);
>+
>        INIT_LIST_HEAD(&arvif->list);
>        INIT_DELAYED_WORK(&arvif->connection_loss_work,
>                          ath12k_mac_vif_sta_connection_loss_work);
>@@ -7347,7 +7350,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw
>*hw,
>
>        if (!vif->valid_links || !is_mcast ||
>            test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
>-               ret =3D ath12k_dp_tx(ar, arvif, skb, false, 0);
>+               ret =3D ath12k_dp_tx(ar, arvif, skb, false, 0, is_mcast);
>                if (unlikely(ret)) {
>                        ath12k_warn(ar->ab, "failed to transmit frame %d\n=
", ret);
>                        ieee80211_free_txskb(ar->ah->hw, skb); @@ -7411,7 =
+7414,7 @@
>static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>
> skip_peer_find:
>                        ret =3D ath12k_dp_tx(tmp_ar, tmp_arvif,
>-                                          msdu_copied, true, mcbc_gsn);
>+                                          msdu_copied, true, mcbc_gsn,
>+ is_mcast);
>                        if (unlikely(ret)) {
>                                if (ret =3D=3D -ENOMEM) {
>                                        /* Drops are expected during heavy=
 multicast @@ -10556,6
>+10559,9 @@ static const struct ieee80211_ops ath12k_ops =3D {
>        .suspend                        =3D ath12k_wow_op_suspend,
>        .resume                         =3D ath12k_wow_op_resume,
>        .set_wakeup                     =3D ath12k_wow_op_set_wakeup,
>+#endif
>+#ifdef CONFIG_ATH12K_DEBUGFS
>+       .vif_add_debugfs                =3D ath12k_debugfs_op_vif_add,
> #endif
>        CFG80211_TESTMODE_CMD(ath12k_tm_cmd)
> };
>--
>2.34.1
>

- Tamizh


