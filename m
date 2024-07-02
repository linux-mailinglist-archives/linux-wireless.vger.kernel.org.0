Return-Path: <linux-wireless+bounces-9849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A63B923E17
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1A4284A62
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD685C74;
	Tue,  2 Jul 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peratonlabs.com header.i=@peratonlabs.com header.b="qqsyeNZl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-00317001.pphosted.com (mx0b-00317001.pphosted.com [148.163.142.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651915575B
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.142.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924320; cv=fail; b=ax5xJIdnf3H86FuCHpnnZxu3qkR1T23JdAQphCfebxK0+LEp0KaYz7iv+jlKEevPabbiiA+a3ljT+dzyljjIS+D0B/Dk3WqwprCa6n1XXL06fvrAcUhMGbes2wZos9xrKeaW0zuulgSESD5Akb3rg17SDLmwNu/s1LyI/abjngk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924320; c=relaxed/simple;
	bh=iltPyotwh2SGl1uqDqaD2EaWSqT8hqZ7+ugV5wcgfMg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s8HJoawf75sd+kraa7BIYTLNUdRRrG/L9DcBRZQP7iXkRURDufb6gQtG3JQ5YGRXozefkblAcksQom6QVz3ICg4qbWlc98T9xcC/tjjRzflqttQ5JAQbCroCrvznRBhGvI6mzn8N50Pguk0EgSLbhEGlpX+6jav9ZJGlcYbJ4OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peratonlabs.com; spf=pass smtp.mailfrom=peratonlabs.com; dkim=pass (2048-bit key) header.d=peratonlabs.com header.i=@peratonlabs.com header.b=qqsyeNZl; arc=fail smtp.client-ip=148.163.142.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=peratonlabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peratonlabs.com
Received: from pps.filterd (m0149018.ppops.net [127.0.0.1])
	by mx0b-00317001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4628ToWD022764
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jul 2024 08:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peratonlabs.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=POD01092023PLABS; bh=cpPWgD5xbQHQkPU
	EUhnFSPqaX4Kl7+aW3vIiRfml6bo=; b=qqsyeNZlvMQDkDbeSubh660c4Umjphc
	QaxhOlrTx1MMG9ovAdiNnvBKg3BULnKv9iIfOwW5alqL5P7IE7T4sb6aEcHTfBA7
	O0pHhwWjU8U4fLyPUSdM0F16hc6bapfq+lW4tdseOKYJYLgtYs9GkU5K7CKKDWa1
	F/gnjj7ZpVndguDNwy3SzdPpNI9kA1ZyOVW0N1YPrYGmSXbY1lsSTjCj3Rbt28PS
	wi89dCazktJV9OhdarOLnxr94Mi8Xp6XaCsszo1EUbAHGQEDVUmlrzkhY+tPnxVY
	oIIJ0XsxJWnr698bGhhRwDP41+L00PVYRtfo0xgv4V3iSLiSjFxZhVA==
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0181.outbound.protection.office365.us [23.103.199.181])
	by mx0b-00317001.pphosted.com (PPS) with ESMTPS id 402bax4bkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 08:45:15 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=0pqQ6A2jt/rRTCsoWJYGSR7SbRXsDLsqmmz1SuhkLN93zhUR3lS66TBiTZ1OfV8Wy5EdnXQvxIznJdk6r69T6v7XJNmjL1dKkFqCQaxD/CEsUpN1gxrg/IKTzvFDL4Uql75xmWYTxmaiecLvgeho/9AydQgKSFAffmBP1xalRXlV04Z2okKCt+N17KsyzGHNdZcWxu0o7OBSGO+gpnaQtpYy/8k1xIdwqt466RH8JR3fEi6qz+Dd6dZ2uPBSlrfycdNzWhQapsBkkAM2NIANOfHt313mVlpNRXsqfAU3xS++3tkc0F1DGs0KnUV8IH5+GDkJwHg2M7W/LN4KIHfg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpPWgD5xbQHQkPUEUhnFSPqaX4Kl7+aW3vIiRfml6bo=;
 b=hwDJdMEd6DLGjwCQGoKYxP587OEqNsz9ObyeD58jM/COarbcUnMp1EJ3qKllDLFZwGruv9KhLR/dZz8JGxeH3/LuNkaJXspgh7ZaIrwBLomo1+nzzwjIS6/6XNeJi8h52EeMLachYSFCT9B2szHRdtkq2xPh7k7KQFrpPdo9V0BodO5ak4EBpwJTDJRC/pSCOCSVQCcvnY8Lb/q3As3nrYrWzpXCQta2elLgjOdrsrngMB5ex96m7ceB2q909jh03hSHGeyRPc4uL0WcTOL+xJT5CX+H3R4D3DhsRkbvHV/Sz+TuyUO4v11BiOqq5qgit2mQHgnguKPF6EKpWkSXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peratonlabs.com; dmarc=pass action=none
 header.from=peratonlabs.com; dkim=pass header.d=peratonlabs.com; arc=none
Received: from BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:181::22)
 by BN0P110MB2225.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 12:45:13 +0000
Received: from BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM
 ([fe80::195f:fd46:5d40:e25c]) by BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM
 ([fe80::195f:fd46:5d40:e25c%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 12:45:13 +0000
From: "Youzwak, Jason A (PERATON LABS)" <jyouzwak@peratonlabs.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Adding EPCS Support
Thread-Topic: Adding EPCS Support
Thread-Index: AQHay/c/68w81c+Vn0q7oPfEApoewQ==
Date: Tue, 2 Jul 2024 12:45:13 +0000
Message-ID: 
 <BN0P110MB12102BF7BDD2D28E95373DD9D4D3A@BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_Enabled=True;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_SiteId=2a6ae295-f13d-4948-ba78-332742ce9097;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_SetDate=2024-07-02T12:45:13.507Z;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_Name=Unrestricted;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_ContentBits=0;MSIP_Label_d9be401e-98d6-42b6-bec6-0ceb84895e69_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0P110MB1210:EE_|BN0P110MB2225:EE_
x-ms-office365-filtering-correlation-id: 6e0d8c42-2229-4da2-17f1-08dc9a94d144
x-ms-reactions: disallow
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?dUa7n5yXewxyR/GnMhz2doKlHB22nFITRF5u++wVLK2a/EzdB8GNv8vy?=
 =?Windows-1252?Q?zLZqLhvutYOeexK/oDJYYSaMwpZRnS/g2xcuHlXSnjGUZyaKGaNAlGQb?=
 =?Windows-1252?Q?InpWhbdDAj5iqCGnnVzqhoHrOFS3iGhDPp+VcV5dbhMf+F5S7pY/wZcV?=
 =?Windows-1252?Q?tjOJH3bC5jKBjZ+vKhJhe394YRUo3ewxbldLQE04Miih1A+znMrZIfCE?=
 =?Windows-1252?Q?csM7yFwuD/g6N9zv0tRCfsJ08/ZDTOXxW+wqFwTecvpTBIBcq6BwXX3E?=
 =?Windows-1252?Q?evZWpHGObmdlCTt0pVvfIHDd5uoNjnCu/49VsAjPxdS8z0XOR4+dgTUW?=
 =?Windows-1252?Q?gX3JTQ+BgJ+GChEoplsyMRWFEqHDmLy8hDk5IHNSHbdWpB8SMKIZA98F?=
 =?Windows-1252?Q?wiJFO8/QY4QA8v0lfkH/IsobJ0nb3FsLKl6hAArYaH56uTupwKLmZrB1?=
 =?Windows-1252?Q?reHSu1BzEcZXFuMO0V2kjqgzGSzH12BBhdDLppHDxBUE3+ochWdUF8Nm?=
 =?Windows-1252?Q?DNv1rXEEvB3H0Flq7pH3FhTryIyPQ2OoJS9K2nWyRMqBSxtVij69BPka?=
 =?Windows-1252?Q?pfYgMdcWC7q5XNA15ydkW2eX47hIZz41tgX8yQoJrr3MBf12BACas28i?=
 =?Windows-1252?Q?Prad/JTp8Bx9gZ32a3b7uZGtsyt3S0zjlaD/0qfGPZGSVWp4SxPOoBpf?=
 =?Windows-1252?Q?VcAPPoto537KwZWZjc783D9ABFh/VvGtQlcc/uB5tLlL4AbMLmUiSV5i?=
 =?Windows-1252?Q?6gT4w9BbHNxt7j2Ox587NoQBkjmhtu2TGL01j0+OXO6IMICgTWqmTKmg?=
 =?Windows-1252?Q?X9qqkRme+SkB87j2HRbdF9FKYgFIlWmEy4n8WFgXMy+ECYxex1/7qgei?=
 =?Windows-1252?Q?gg9KRF6x1jSRAfDK8WveL2+QFWVxGGadxmnhIdQWrrYOUoPb4gJiP0qv?=
 =?Windows-1252?Q?fYgig9if0tlhT9KAgs5xVtVQT23bFpsYaJPTVSRXdf/Yf6X9tIzmmnOH?=
 =?Windows-1252?Q?c7knea37foPBiuXQP5L5vhErcvHA3a2wQ3C/qMVrgu/xCqj4SXQblVG/?=
 =?Windows-1252?Q?1sxaWo88jjoCINf6fO3POGM5YWkmhwUcgCfWjaK/QwvKESC+Px6Tl2xA?=
 =?Windows-1252?Q?DacwV2uNWJRRCZQN4LdI+chSjoMB82mvqdq8Hj/fj3zoMS46w7id7r9V?=
 =?Windows-1252?Q?SvmlMrXM0Cm+wROJ+Ytmev17+oo60resJ7oZPvrXwXt/Aj7KpwomISST?=
 =?Windows-1252?Q?W59s75qc27yMWQENv4sg543WUIb9IpahZFP61K1ZrpGrhD3rCE2O4jaA?=
 =?Windows-1252?Q?f/jDb+weEkI+pC2ernbCa4qwmMNzwsZP7tJ0v3vwGTPCEyas+ylNVxQY?=
 =?Windows-1252?Q?clFt1RZp0tArvvrR0T+ibTHIYaDm2E8ce32BaEVZJq/05z1FVcOmK2mQ?=
 =?Windows-1252?Q?wMqyyHFddrcFiiZtm1Eqik3wap4Js3VBuDltZYiKS+pZZIaz8LiepdhK?=
 =?Windows-1252?Q?gynFOfpYx2wMXowT9+0B7L7neP5Zqw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?sRcknXaGuqq1H+l6UFuLxRaNbCZuqExUatnnfvSlcFsHnHppe+f4qaqE?=
 =?Windows-1252?Q?YAC1kL0eD58xpadiRaARiBeGnGw0sfpUv7jsCsV22uGLyjRgXHXUNCfT?=
 =?Windows-1252?Q?jDgT0Py3sZQsFJd8sw/IIjBS+7t7xMmDDfbOCl3gKu5fW2RUUc+MPkT+?=
 =?Windows-1252?Q?12JOa4qSLqJ/V2s2DsI3KfN19kKoNpDgTofhUsPn3ZBGOz+HLHf5BXGx?=
 =?Windows-1252?Q?8tWcTlQeJcUvZxT+1pU9sLxZ5B0Kes6B8bRaKTCYGVbTNZ7tIjPzymU1?=
 =?Windows-1252?Q?XJtc3RI/Dw9lplNuNJUebu79kdwkZjH2zqrG1bv1Lk9E2p/H2oQruS1P?=
 =?Windows-1252?Q?oF8UrxfypQ+ngVXhw8wdJi6X192xRfwa2uBEExu4gaoHM0/bH7oFhyEg?=
 =?Windows-1252?Q?wkYMtvTr9lOjRk14DYkM2t9YgjHHaTl1ais5vDn5p8OCmR47supWgWB3?=
 =?Windows-1252?Q?ei3WwbwOFJzdmcrrHI6kWKNFeEqNuUpLEX9WT+IQKCzVyiu6JE0+p4cD?=
 =?Windows-1252?Q?pRaG3rEtEGmYq1x3V4hrEKFmi0JjkmbukWzJEGhfrjRM8H/UO7YrmLgC?=
 =?Windows-1252?Q?ulcwoHxlffr7hjojJdGnrcg3HbbypAYot14RTp8PJ//m7ybA3IxcfOqR?=
 =?Windows-1252?Q?/DrL5muUtFTx5vK8VZBaAdKYVI2/CSwdPdoZFAG5giW+dX461Q2qhWhw?=
 =?Windows-1252?Q?5cx3JytJgcbFn8NMfBDuHrrsGNkpy+idECwia36BXvXJpF7WDvQu2E2I?=
 =?Windows-1252?Q?G/QEhvrM6g5TAEYvomXUvIBkI5lTVvwe/E/bbbKONVqxOj9BnaEnHtUP?=
 =?Windows-1252?Q?XEADYBcj6XyXFKMR1HGbK4RnNhmfej033gvzmclVCU/plxN/ACRJkV7C?=
 =?Windows-1252?Q?a9epaOQS9ltNzcDAKYVVelfaIjslbRvEDWr53TCiNKrgecw9BQwhEi0G?=
 =?Windows-1252?Q?JVVxqjb51KmM5HjyrbNNYIYYQ8hLwvrBZi5orMfx3oEErDZ2NnqJnRHw?=
 =?Windows-1252?Q?NDXE7YnADHwj9/lh1S0wK2gaJ5MRp1/gG88D9LBoCpjb9dhSZgrabTKh?=
 =?Windows-1252?Q?b5WTWJNDwWA5M7T5M7/xl+BXwQRrlruUER8W3MS/I0CwcDo9k18tjddi?=
 =?Windows-1252?Q?Sq2sZ844a4oHnTeI69wRhtS3vSo7Y7QOWr0m6TILy/a7UMMZDRlWQR3L?=
 =?Windows-1252?Q?jnTJ4SIe4r6u+g1KsjmJfjgv1d7Wt/E6b1T3EnVOlHTayKgckYgYVXmk?=
 =?Windows-1252?Q?ZgHuu5pNhPfyffGZp/4pAvec7/MBNiBvXG+5fCs+1E8XWbuHrafdWJ68?=
 =?Windows-1252?Q?/NLAmrke1pZ3WpxRp+Qy4vswrxKSDuoWuFiDzLsL1QG6yQAmntAoYtIb?=
 =?Windows-1252?Q?WLG6krj6ZhtbukAUiLj8cSBVts4/Znx8aS8EAwfU+Wi1zO9WdZl9Oiyo?=
 =?Windows-1252?Q?LP5IXHX1lKiluJdvvLV0u47hoK3AHQBzWYYIoNYyCD+d1YI0pn7fAKaq?=
 =?Windows-1252?Q?XrHEfg426YiX3Ba/pxlweTmzFhTIZfrfsgUHldkkVv7sVYbj1f6/dAwF?=
 =?Windows-1252?Q?pzm1nvQRqE0/hy+be1rzN7Shj8K+b0gkAICfkSbKsseCQg8EPTP2htH/?=
 =?Windows-1252?Q?G5E=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: peratonlabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0d8c42-2229-4da2-17f1-08dc9a94d144
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 12:45:13.6279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a6ae295-f13d-4948-ba78-332742ce9097
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB2225
X-Proofpoint-ORIG-GUID: KVDKUQAcV0FJBQp8v6xSMsaMXNWhlMj9
X-Authority-Analysis: v=2.4 cv=S7eLw5sP c=1 sm=1 tr=0 ts=6683f65b cx=c_pps a=pj3U7PEmHrmn+1j25+pYxA==:117 a=pj3U7PEmHrmn+1j25+pYxA==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10 a=4kmOji7k6h8A:10 a=HFUoU3P_DP0A:10
 a=rDd1SCgFB-YEiFBF15kA:9 a=pILNOxqGKmIA:10
X-Proofpoint-GUID: KVDKUQAcV0FJBQp8v6xSMsaMXNWhlMj9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_08,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407020095

Hello,=0A=
=0A=
We are implementing a Wi-Fi 7 feature called Emergency Preparedness Communi=
cation Services (EPCS) that provides priority to Stations (STAs) that are a=
uthorized to receive National Security and Emergency Preparedness (NSEP) Co=
mmunication Services. This feature is part of Wi-Fi 7 certification, detail=
ed in IEEE 802.11be Draft 6.0.=0A=
=0A=
We have started implementation efforts for the Linux operating system (spec=
ifically Arch Linux). We have successfully implemented and tested the over-=
the-air behavior per Wi-Fi Alliance defined test cases by modifying the =91=
hostapd=92 and =91wpa_supplicant=92. However, we are facing challenges maki=
ng kernel modifications related to applying EDCA parameters for channel acc=
ess. Specifically, we need to modify the nl80211, mac80211, and cfg80211 co=
mponents in the Linux kernel to accommodate the following behavior at the S=
TA per IEEE 802.11be specification (Draft 6.0, Clause 35.16.3.2):=0A=
=0A=
"While EPCS priority access is enabled, the STA affiliated with an EPCS non=
-AP MLD shall=0A=
=A0=0A=
- follow the contention-based channel-access procedures defined in 10.2.3.2=
 (HCF contention-based channel access (EDCA)) using the EDCA parameter set =
stored in the dot11EDCATable as described earlier in this subclause, and=0A=
- ignore the part of the procedures defined in 10.2.3.2 (HCF contention-bas=
ed channel access (EDCA)) that concerns the update of the EDCA parameters t=
hat are sent by the corresponding AP in its Beacon and Probe Response frame=
s=0A=
- if the per-STA profile of the EPCS Priority Access Multi-Link element is =
present in the EPCS Priority Access Enable Request or the EPCS Priority Acc=
ess Enable Response frame received by a STA affiliated with the EPCS non-AP=
 MLD and the per-STA profile contains an MU EDCA Parameter Set element:=0A=
  - follow the rules defined in 26.2.7 (EDCA operation using MU EDCA parame=
ters) using the MU EDCA parameters stored in the dot11MUEDCATable as descri=
bed earlier in this subclause, except that=0A=
    - if the MUEDCATimer[AC] of the STA reaches 0, either by counting down =
or due to a reset following the reception of an MU EDCA Reset frame, the ST=
A affiliated with EPCS non-AP MLD shall update CWmin[AC], CWmax[AC], and AI=
FSN[AC] to the values stored in the dot11EDCATable as described earlier in =
this subclause=0A=
    - ignore the part of the procedures defined in 26.2.7 (EDCA operation u=
sing MU EDCA parameters) that concerns the update of the MU EDCA parameters=
 that are sent by the corresponding AP in its Beacon and Probe Response fra=
mes=A0=0A=
=0A=
After the EPCS priority access is torn down, the STA affiliated with an EPC=
S non-AP MLD=0A=
=A0=0A=
- shall update its CWmin[AC], CWmax[AC], AIFSN[AC], and TXOP Limit [AC] sta=
te variables following the procedures in 10.2.3.2 (HCF contention-based cha=
nnel access (EDCA)).=A0=0A=
- shall update the dot11MUEDCATable following the procedures in 26.2.7 (EDC=
A operation using MU EDCA parameters)."=0A=
=0A=
We took the following approach:=A0=0A=
=0A=
- Define new nl80211 commands: NL80211_CMD_EPCS_ENABLE and NL80211_CMD_EPCS=
_TEARDOWN=A0=0A=
- Define new STA flag: WLAN_STA_EPCS_ENABLED=A0=0A=
- In net/mac80211/mlme.c, in ieee80211_mgd_set_link_qos_params(), if the WL=
AN_STA_EPCS_ENABLED flag is set, ignore the EDCA parameters from the Beacon=
 and apply Priority EDCA parameters.=0A=
=0A=
Despite our efforts, we encountered several challenges:=A0=0A=
=0A=
1. Sending EPCS Enable/Teardown commands to the kernel (mac80211) from user=
space (hostapd) via netlink.=A0 The response was "Operation not supported o=
n transport endpoint (-EOPNOTSUPP) (-95)".=0A=
2. Receiving, parsing and propagating the message via nl80211 and cfg80211.=
=A0 Specifically, we would like guidance on storing parameters received in =
the NL80211_CMD_EPCS_ENABLE message and retrieving them in the net/mac80211=
/mlme.c module.=A0=0A=
3. Applying the new EDCA parameters in mac80211 module.=A0=0A=
=0A=
We are seeking help from experts in the community who have worked with thes=
e components. Specifically, we would appreciate responses to the following =
questions:=A0=0A=
=0A=
- Is the kernel the right place to implement this or are there user-space s=
olutions that we can leverage?=A0=0A=
- If kernel modifications are needed, does our proposed approach make sense=
, or are there better alternatives we should consider?=A0=0A=
- Is there documented guidance on how to add such features to the kernel?=
=A0=0A=
=0A=
Please see our initial work to provide basic support for EPCS messaging in =
Linux kernel 6.9.5 on Arch Linux in the patch below.=0A=
=0A=
Note: this is a proof of concept and not a full implementation =96 Priority=
 Parameters are hardcoded in the net/mac/80211/mlme.c module.=A0 A full imp=
lementation would accept priority parameters via the =93NL80211_CMD_EPCS_EN=
ABLE=94 command.=A0=0A=
=0A=
Patch to Kernel 6.9.5=0A=
----------------------=A0=0A=
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h=A0=0A=
index 1e09329ac..33c123b1d 100644=A0=0A=
--- a/include/net/cfg80211.h=A0=0A=
+++ b/include/net/cfg80211.h=A0=0A=
@@ -4855,6 +4855,10 @@ struct cfg80211_ops {=A0=0A=
int	(*del_tx_ts)(struct wiphy *wiphy, struct net_device *dev,=A0=0A=
=A0=A0=A0=A0 u8 tsid, const u8 *peer);=A0=0A=
=A0=A0=0A=
+=A0=A0=A0 /* JY: PLABS ADDED */=A0=0A=
+=A0=A0=A0 int (*epcs_enable)(struct wiphy *wiphy, struct wireless_dev *wde=
v);=A0=0A=
+=A0=A0=A0 int (*epcs_teardown)(struct wiphy *wiphy, struct wireless_dev *w=
dev);=A0=0A=
+=A0=0A=
int	(*tdls_channel_switch)(struct wiphy *wiphy,=A0=0A=
=A0=A0=A0=A0=A0=A0 struct net_device *dev,=A0=0A=
=A0=A0=A0=A0=A0=A0 const u8 *addr, u8 oper_class,=A0=0A=
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h=A0=
=0A=
index f23ecbdd8..69ddd2092 100644=A0=0A=
--- a/include/uapi/linux/nl80211.h=A0=0A=
+++ b/include/uapi/linux/nl80211.h=A0=0A=
@@ -1592,6 +1592,9 @@ enum nl80211_commands {=A0=0A=
NL80211_CMD_SET_TID_TO_LINK_MAPPING,=A0=0A=
=A0=A0=0A=
/* add new commands above here */=A0=0A=
+=A0=A0=A0 /* JY: PLABS ADDED */=A0=0A=
+=A0=A0=A0 NL80211_CMD_EPCS_ENABLE,=A0=0A=
+=A0=A0=A0 NL80211_CMD_EPCS_TEARDOWN,=A0=0A=
=A0=A0=0A=
/* used to define NL80211_CMD_MAX below */=A0=0A=
__NL80211_CMD_AFTER_LAST,=A0=0A=
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c=A0=0A=
index 07abaf782..a3d979909 100644=A0=0A=
--- a/net/mac80211/cfg.c=A0=0A=
+++ b/net/mac80211/cfg.c=A0=0A=
@@ -4347,6 +4347,32 @@ static int ieee80211_set_ap_chanwidth(struct wiphy *=
wiphy,=A0=0A=
return ret;=A0=0A=
}=A0=0A=
=A0=A0=0A=
+/* JY: PLABS BEGIN */=A0=0A=
+=A0=0A=
+static int ieee80211_epcs_enable(struct wiphy *wiphy, struct wireless_dev =
*wdev)=A0=0A=
+{=A0=0A=
+=A0=A0=A0 struct ieee80211_sub_if_data *sdata =3D IEEE80211_WDEV_TO_SUB_IF=
(wdev);=A0=0A=
+=A0=A0=A0 struct sta_info *sta;=A0=0A=
+=A0=0A=
+=A0=A0=A0 sta =3D sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);=A0=
=0A=
+=A0=A0=A0 set_sta_flag(sta, WLAN_STA_EPCS_ENABLED);=A0=0A=
+=A0=0A=
+=A0=A0=A0 return 0;=A0=0A=
+}=A0=0A=
+=A0=0A=
+static int ieee80211_epcs_teardown(struct wiphy *wiphy, struct wireless_de=
v *wdev)=A0=0A=
+{=A0=0A=
+=A0=A0=A0 struct ieee80211_sub_if_data *sdata =3D IEEE80211_WDEV_TO_SUB_IF=
(wdev);=A0=0A=
+=A0=A0=A0 struct sta_info *sta;=A0=0A=
+=A0=0A=
+=A0=A0=A0 sta =3D sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);=A0=
=0A=
+=A0=A0=A0 clear_sta_flag(sta, WLAN_STA_EPCS_ENABLED);=A0=0A=
+=A0=0A=
+=A0=A0=A0 return 0;=A0=0A=
+}=A0=0A=
+=A0=0A=
+/* JY: PLABS END */=A0=0A=
+=A0=0A=
static int ieee80211_add_tx_ts(struct wiphy *wiphy, struct net_device *dev,=
=A0=0A=
=A0=A0=A0=A0=A0=A0 u8 tsid, const u8 *peer, u8 up,=A0=0A=
=A0=A0=A0=A0=A0=A0 u16 admitted_time)=A0=0A=
@@ -5165,4 +5191,7 @@ const struct cfg80211_ops mac80211_config_ops =3D {=
=A0=0A=
.del_link_station =3D ieee80211_del_link_station,=A0=0A=
.set_hw_timestamp =3D ieee80211_set_hw_timestamp,=A0=0A=
.set_ttlm =3D ieee80211_set_ttlm,=A0=0A=
+=A0=A0=A0 /* JY: PLABS ADDED */=A0=0A=
+=A0=A0=A0 .epcs_enable =3D ieee80211_epcs_enable,=A0=0A=
+=A0=A0=A0 .epcs_teardown =3D ieee80211_epcs_teardown,=A0=0A=
};=A0=0A=
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c=A0=0A=
index 1e9389c49..100e26729 100644=A0=0A=
--- a/net/mac80211/debugfs_sta.c=A0=0A=
+++ b/net/mac80211/debugfs_sta.c=A0=0A=
@@ -80,6 +80,8 @@ static const char * const sta_flag_names[] =3D {=A0=0A=
FLAG(PS_DELIVER),=A0=0A=
FLAG(USES_ENCRYPTION),=A0=0A=
FLAG(DECAP_OFFLOAD),=A0=0A=
+=A0=A0=A0 /* JY: PLABS ADDED */=A0=0A=
+=A0=A0=A0 FLAG(EPCS_ENABLED),=A0=0A=
#undef FLAG=A0=0A=
};=A0=0A=
=A0=A0=0A=
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c=A0=0A=
index 497677e3d..aba87d1d4 100644=A0=0A=
--- a/net/mac80211/mlme.c=A0=0A=
+++ b/net/mac80211/mlme.c=A0=0A=
@@ -2720,7 +2720,30 @@ void ieee80211_mgd_set_link_qos_params(struct ieee80=
211_link_data *link)=A0=0A=
struct ieee80211_tx_queue_params *params =3D link->tx_conf;=A0=0A=
u8 ac;=A0=0A=
=A0=A0=0A=
+=A0=A0=A0 /* PLABS JY: Changes BEGIN */=A0=0A=
+=A0=A0=A0 bool epcs_enabled =3D false;=A0=0A=
+=A0=A0=A0 struct sta_info *sta =3D NULL;=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0 /* New flag lives in the Station Info */=A0=0A=
+=A0=A0=A0 sta =3D sta_info_get(sdata, sdata->vif.cfg.ap_addr);=A0=0A=
+=A0=0A=
+=A0=A0=A0 /* Get result 0 or 1 */=A0=0A=
+=A0=A0=A0 epcs_enabled =3D test_sta_flag(sta, WLAN_STA_EPCS_ENABLED);=A0=
=0A=
+=A0=A0=A0=0A=
+=A0=A0=A0 mlme_dbg(sdata, "JY: PLABS mac80211 module changes\n");=A0=0A=
+=A0=A0=A0 mlme_dbg(sdata, "EPCS Enabled=3D%s\n", epcs_enabled ? "true" : "=
false");=A0=0A=
+=A0=0A=
for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 if (epcs_enabled) {=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mlme_dbg(sdata, "JY: PLABS We are enteri=
ng priority mode!\n");=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // Setting EDCA parameter to Voice=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 params[ac].aifs =3D 3;=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 params[ac].cw_min =3D 4;=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 params[ac].cw_max =3D 5;=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 params[ac].txop =3D 65;=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 params[ac].acm =3D 0;=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=A0=0A=
+=A0=0A=
mlme_dbg(sdata,=A0=0A=
=A0"WMM AC=3D%d acm=3D%d aifs=3D%d cWmin=3D%d cWmax=3D%d txop=3D%d uapsd=3D=
%d, downgraded=3D%d\n",=A0=0A=
=A0ac, params[ac].acm,=A0=0A=
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h=A0=0A=
index a52fb7638..ac2a39d57 100644=A0=0A=
--- a/net/mac80211/sta_info.h=A0=0A=
+++ b/net/mac80211/sta_info.h=A0=0A=
@@ -104,6 +104,8 @@ enum ieee80211_sta_info_flags {=A0=0A=
WLAN_STA_PS_DELIVER,=A0=0A=
WLAN_STA_USES_ENCRYPTION,=A0=0A=
WLAN_STA_DECAP_OFFLOAD,=A0=0A=
+=A0=A0=A0 /* JY: PLABS ADDED */=A0=0A=
+=A0=A0=A0 WLAN_STA_EPCS_ENABLED,=A0=0A=
=A0=A0=0A=
NUM_WLAN_STA_FLAGS,=A0=0A=
};=A0=0A=
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c=A0=0A=
index 65c416e8d..8be612b49 100644=A0=0A=
--- a/net/wireless/nl80211.c=A0=0A=
+++ b/net/wireless/nl80211.c=A0=0A=
@@ -2641,6 +2641,8 @@ static int nl80211_send_wiphy(struct cfg80211_registe=
red_device *rdev,=A0=0A=
if (rdev->wiphy.features &=A0=0A=
NL80211_FEATURE_SUPPORTS_WMM_ADMISSION)=A0=0A=
CMD(add_tx_ts, ADD_TX_TS);=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // PLABS Added=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CMD(epcs_enable, EPCS_ENABLE);=A0=0A=
CMD(set_multicast_to_unicast, SET_MULTICAST_TO_UNICAST);=A0=0A=
CMD(update_connect_params, UPDATE_CONNECT_PARAMS);=A0=0A=
CMD(update_ft_ies, UPDATE_FT_IES);=A0=0A=
@@ -15299,6 +15301,30 @@ static int nl80211_set_qos_map(struct sk_buff *skb=
,=A0=0A=
return ret;=A0=0A=
}=A0=0A=
=A0=A0=0A=
+/* JY: PLABS ADDED */=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=0A=
+static int nl80211_epcs_enable(struct sk_buff *skb, struct genl_info *info=
)=A0=0A=
+{=A0=0A=
+=A0=A0=A0 struct cfg80211_registered_device *rdev =3D info->user_ptr[0];=
=A0=0A=
+=A0=A0=A0 struct net_device *dev =3D info->user_ptr[1];=A0=0A=
+=A0=A0=A0 struct wireless_dev *wdev =3D dev->ieee80211_ptr;=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0 rdev_epcs_enable(rdev, wdev);=A0=A0=A0=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0 return 1;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=0A=
+}=A0=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=0A=
+/* JY: PLABS ADDED */=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=0A=
+static int nl80211_epcs_teardown(struct sk_buff *skb, struct genl_info *in=
fo)=A0=0A=
+{=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0 struct cfg80211_registered_device *rdev =3D info->user_ptr[0];=
=A0=0A=
+=A0=A0=A0 struct net_device *dev =3D info->user_ptr[1];=A0=0A=
+=A0=A0=A0 struct wireless_dev *wdev =3D dev->ieee80211_ptr;=A0=0A=
+=A0=0A=
+=A0=A0=A0 rdev_epcs_teardown(rdev, wdev);=A0=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=0A=
+=A0=A0=A0 return 1;=A0=0A=
+}=A0=0A=
+=A0=0A=
static int nl80211_add_tx_ts(struct sk_buff *skb, struct genl_info *info)=
=A0=0A=
{=A0=0A=
struct cfg80211_registered_device *rdev =3D info->user_ptr[0];=A0=0A=
@@ -17488,6 +17514,24 @@ static const struct genl_small_ops nl80211_small_o=
ps[] =3D {=A0=0A=
.flags =3D GENL_UNS_ADMIN_PERM,=A0=0A=
.internal_flags =3D IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),=A0=0A=
},=A0=0A=
+=A0=A0=A0 /* JY: PLABS ADDED */=A0=0A=
+=A0=A0=A0 {=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 .cmd =3D NL80211_CMD_EPCS_ENABLE,=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 // PLABS: If we encounter issues, remove validate=A0=
=0A=
+=A0=A0=A0=A0=A0=A0=A0 .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_=
VALIDATE_DUMP,=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 .doit =3D nl80211_epcs_enable,=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 .flags =3D GENL_UNS_ADMIN_PERM,=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 .internal_flags =3D IFLAGS(NL80211_FLAG_NEED_NETDEV_=
UP | NL80211_FLAG_MLO_UNSUPPORTED),=A0=0A=
+=A0=A0=A0 },=A0=0A=
+=A0=A0=A0 /* JY: PLABS ADDED */=A0=0A=
+=A0=A0=A0 {=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 .cmd =3D NL80211_CMD_EPCS_TEARDOWN,=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 // PLABS: If we encounter issues, remove validate=A0=
=0A=
+=A0=A0=A0=A0=A0=A0=A0 .validate =3D GENL_DONT_VALIDATE_STRICT | GENL_DONT_=
VALIDATE_DUMP,=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 .doit =3D nl80211_epcs_teardown,=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 .flags =3D GENL_UNS_ADMIN_PERM,=A0=0A=
+=A0=A0=A0=A0=A0=A0=A0 .internal_flags =3D IFLAGS(NL80211_FLAG_NEED_NETDEV_=
UP | NL80211_FLAG_MLO_UNSUPPORTED),=A0=0A=
+=A0=A0=A0 },=A0=0A=
};=A0=0A=
=A0=A0=0A=
static struct genl_family nl80211_fam __ro_after_init =3D {=A0=0A=
@@ -17504,7 +17548,9 @@ static struct genl_family nl80211_fam __ro_after_in=
it =3D {=A0=0A=
.n_ops =3D ARRAY_SIZE(nl80211_ops),=A0=0A=
.small_ops =3D nl80211_small_ops,=A0=0A=
.n_small_ops =3D ARRAY_SIZE(nl80211_small_ops),=A0=0A=
-	.resv_start_op =3D NL80211_CMD_REMOVE_LINK_STA + 1,=A0=0A=
+=A0=A0=A0 // PLABS Changed=A0=0A=
+	//.resv_start_op =3D NL80211_CMD_REMOVE_LINK_STA + 1,=A0=0A=
+	.resv_start_op =3D NL80211_CMD_MAX + 1,=A0=0A=
.mcgrps =3D nl80211_mcgrps,=A0=0A=
.n_mcgrps =3D ARRAY_SIZE(nl80211_mcgrps),=A0=0A=
.parallel_ops =3D true,=A0=0A=
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h=A0=0A=
index 43897a526..8aec66206 100644=A0=0A=
--- a/net/wireless/rdev-ops.h=A0=0A=
+++ b/net/wireless/rdev-ops.h=A0=0A=
@@ -637,6 +637,17 @@ static inline void rdev_rfkill_poll(struct cfg80211_re=
gistered_device *rdev)=A0=0A=
trace_rdev_return_void(&rdev->wiphy);=A0=0A=
}=A0=0A=
=A0=A0=0A=
+/* JY: PLABS ADDED */=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=0A=
+static inline void rdev_epcs_enable(struct cfg80211_registered_device *rde=
v, struct wireless_dev *wdev)=A0=0A=
+{=A0=0A=
+=A0=A0=A0 rdev->ops->epcs_enable(&rdev->wiphy, wdev);=A0=0A=
+}=A0=0A=
+=A0=A0=0A=
+/* JY: PLABS ADDED */=A0=0A=
+static inline void rdev_epcs_teardown(struct cfg80211_registered_device *r=
dev, struct wireless_dev *wdev)=A0=0A=
+{=A0=0A=
+=A0=A0=A0 rdev->ops->epcs_teardown(&rdev->wiphy, wdev);=A0=0A=
+}=A0=0A=
=A0=A0=0A=
#ifdef CONFIG_NL80211_TESTMODE=A0=0A=
static inline int rdev_testmode_cmd(struct cfg80211_registered_device *rdev=
,=A0=0A=
=A0=0A=
Thanks in advance,=A0=0A=
Jason=A0=0A=

