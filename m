Return-Path: <linux-wireless+bounces-1781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EB82BA67
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 05:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0466528AD5A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 04:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F23D5B5A6;
	Fri, 12 Jan 2024 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OncK6186"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22645B5A3
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C4JpaU007577;
	Fri, 12 Jan 2024 04:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=Q4m40fwMg/wMB/FsJE/i93PNvAmG5JFhKvuG3fxaFp8=; b=On
	cK6186qCHiMSPbZ+pRot0sKITUPCM/VunDBnWsiQy5rU8usEIIetxzr0GsimHMJ4
	2vUat6+d+uuM8xwIMs2856musT3pcpEqZBJAA3EapVQO5wdeLa6bGbcpPOVpDUZX
	B5Dcy7fZBq0w/jMT2kpBNJDa9rgjaGvUmggFdMvnmM0zLxAht4YwQNm29ZPV/PUj
	9EQae2Cblkiim1esboekNvIWkNpEENLH4CS7A+DuDHpGhQX2bmGOHsp68/VLLf/7
	Wh742S6Tpb2ES4LUyNsG7MJaevF8LiJqTkVvE/0SFof0/UH7PxHqVFVC7m2CMlTm
	mzNKJUQv9aPuoL4rWPNQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjpuj0t97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 04:34:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C4YDRe018179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 04:34:13 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 20:34:13 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::4c50:85be:1649:87eb]) by
 nalasex01a.na.qualcomm.com ([fe80::4c50:85be:1649:87eb%4]) with mapi id
 15.02.1118.040; Thu, 11 Jan 2024 20:34:13 -0800
From: "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To: "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        "Sriram R (QUIC)"
	<quic_srirrama@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 00/12] wifi: ath12k: Add single wiphy support
Thread-Topic: [PATCH 00/12] wifi: ath12k: Add single wiphy support
Thread-Index: AQHaREnRMm8ohGOPKECTigDMaWE1n7DVk4iAgACLLeA=
Date: Fri, 12 Jan 2024 04:34:13 +0000
Message-ID: <606709d9eab84207b0ab73d12e7defcd@quicinc.com>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <f1431217-447e-4d1e-a97c-e5cea6ff2c36@quicinc.com>
In-Reply-To: <f1431217-447e-4d1e-a97c-e5cea6ff2c36@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R-fjS3CtAUv2BtOGpIdcs_c9NHusYxiJ
X-Proofpoint-ORIG-GUID: R-fjS3CtAUv2BtOGpIdcs_c9NHusYxiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=652 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120031

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSmVmZiBKb2huc29uIChRVUlDKSA8
cXVpY19qam9obnNvbkBxdWljaW5jLmNvbT4NCj5TZW50OiBGcmlkYXksIEphbnVhcnkgMTIsIDIw
MjQgMTo0NiBBTQ0KPlRvOiBTcmlyYW0gUiAoUVVJQykgPHF1aWNfc3JpcnJhbWFAcXVpY2luYy5j
b20+OyBhdGgxMmtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPkNjOiBsaW51eC13aXJlbGVzc0B2Z2Vy
Lmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIDAwLzEyXSB3aWZpOiBhdGgxMms6IEFk
ZCBzaW5nbGUgd2lwaHkgc3VwcG9ydA0KPg0KPk9uIDEvMTAvMjAyNCA4OjUwIFBNLCBTcmlyYW0g
UiB3cm90ZToNCj4+IFRoaXMgcGF0Y2hzZXQgaXMgZGVwZW5kZW50IG9uICJbUEFUQ0ggMC8yXSB3
aWZpOiBhdGgxMms6IEludHJvZHVjZSBodw0KPmFic3RyYWN0aW9uIg0KPg0KPkknbSBjdXJyZW50
bHkgdW5hYmxlIHRvIGFwcGx5IHRoZSBwcmVyZXF1aXNpdGUgcGF0Y2hlcyB0byBteSB3b3Jrc3Bh
Y2UsIHNvIEkgd29uJ3QNCj5iZSBhYmxlIHRvIHJldmlldyB5b3VyIHBhdGNoZXMgdW50aWwgdGhh
dCBpcyByZXNvbHZlZC4NClN1cmUuIEkgYmVsaWV2ZSBpdHMgcmVzb2x2ZWQgd2l0aCAiW1BBVENI
IHYyIDAvMl0gd2lmaTogYXRoMTJrOiBJbnRyb2R1Y2UgaHcgYWJzdHJhY3Rpb24iLg0KDQpUaGFu
a3MsDQpTcmlyYW0uUg0K

