Return-Path: <linux-wireless+bounces-1915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703BA82D4B5
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 08:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E52F2819DC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30A440D;
	Mon, 15 Jan 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XHE0BZ6V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610B4402
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40F7drMV016967;
	Mon, 15 Jan 2024 07:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=ECooTonl5aq4Io4iHkns7/dmYJ8pAyOiRyizFgpZfkc=; b=XH
	E0BZ6Vx9KS+k4s8nK5BeOcrzb78sgyG+spQ+CPvND7iMbHPMDRFpuHMIUv+8rZfF
	23lzaLBWwr7mpjgfYym12hLA9Z+87O24Ln6DPvxObSnYas041AZe6YhxG31XSxdP
	C3bA34QdZNLDBVGypnszYCfspbVQj8/vKvN5N7qbJIvIgiSl2f7tJNsEQndiDI5Q
	in2WdT+9tj12Hfai/m1a0kCk+dZM16Wps48L3RMLyn4rIBdHFRQA0GHW9frZaj7e
	Aaz6w936S85/5+WLG4AlWYsJs5qCVlte0cXqXUNlWsFDAdhVFfyg7c/FNsRBN5XA
	uZwljoxC19kRhKx5jdKw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkme12uvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 07:53:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40F7rVpm017510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 07:53:31 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 14 Jan 2024 23:53:31 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::1bb6:d69c:6826:9c1]) by
 nalasex01a.na.qualcomm.com ([fe80::1bb6:d69c:6826:9c1%4]) with mapi id
 15.02.1118.040; Sun, 14 Jan 2024 23:53:30 -0800
From: "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To: "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        "Sriram R (QUIC)"
	<quic_srirrama@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 09/12] wifi: ath12k: modify regulatory support for single
 wiphy architecture
Thread-Topic: [PATCH 09/12] wifi: ath12k: modify regulatory support for single
 wiphy architecture
Thread-Index: AQHaREnc+ajB8aFcaUWzmWw+VHM87LDXBEQAgAQJE4A=
Date: Mon, 15 Jan 2024 07:53:24 +0000
Message-ID: <565e97fbb0304a268b591a08b891bb4c@quicinc.com>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <20240111045045.28377-10-quic_srirrama@quicinc.com>
 <9e950030-2781-4fd7-84f1-cb7fd6197e6b@quicinc.com>
In-Reply-To: <9e950030-2781-4fd7-84f1-cb7fd6197e6b@quicinc.com>
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
X-Proofpoint-GUID: RhHlcEgG6lQ8TvQSS6c0NB65V2MB6JRJ
X-Proofpoint-ORIG-GUID: RhHlcEgG6lQ8TvQSS6c0NB65V2MB6JRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401150056

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSmVmZiBKb2huc29uIChRVUlDKSA8
cXVpY19qam9obnNvbkBxdWljaW5jLmNvbT4NCj5TZW50OiBGcmlkYXksIEphbnVhcnkgMTIsIDIw
MjQgMTE6NDYgUE0NCj5UbzogU3JpcmFtIFIgKFFVSUMpIDxxdWljX3NyaXJyYW1hQHF1aWNpbmMu
Y29tPjsgYXRoMTJrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj5DYzogbGludXgtd2lyZWxlc3NAdmdl
ci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSCAwOS8xMl0gd2lmaTogYXRoMTJrOiBt
b2RpZnkgcmVndWxhdG9yeSBzdXBwb3J0IGZvciBzaW5nbGUgd2lwaHkNCj5hcmNoaXRlY3R1cmUN
Cj4NCj5PbiAxLzEwLzIwMjQgODo1MCBQTSwgU3JpcmFtIFIgd3JvdGU6DQo+PiBXaXRoIGFsbCB0
aGUgcmFkaW9zIGJlaW5nIGNvbWJpbmVkIGFuZCByZWdpc3RlcmVkIGFzIGEgc2luZ2xlDQo+PiBt
YWM4MDIxMSBody93aXBoeSwgc2VwYXJhdGUgcmVnZCBidWlsdCBmcm9tIGZpcm13YXJlIHJ1bGVz
IG5lZWQgbm90IGJlDQo+PiB1cGRhdGVkIHRvIGNmZzgwMjExLiBSYXRoZXIgd2UgY2FuIHBpY2sg
b25lIG9mIHRoZSByZWdkIGJ1aWx0IGZyb20gdGhlDQo+PiBydWxlcyB0byB1cGRhdGUgdG8gY2Zn
ODAyMTEgZm9yIHRoZSB3aG9sZSByZWdpc3RlcmVkIGRldmljZS4gV2UgcHJlZmVyDQo+PiA2IEdI
eiBwZGV2IGJhc2VkIHJ1bGVzIHNpbmNlIGl0IGhhcyB0aGUgcnVsZXMgZm9yIGFsbCBiYW5kcy4g
SWYgdGhlIGh3DQo+PiBkb2Vzbid0IHN1cHBvcnQgNiBHSHosIHRoZW4gdXBkYXRlIHJ1bGVzIGZy
b20gb25lIG9mIHRoZSBwZGV2cy4NCj4NCj5EbyB5b3UgbmVlZCB0byBoYW5kbGUgdGhlIGNhc2Ug
d2hlcmUgdGhlcmUgYXJlIG11bHRpcGxlIGluc3RhbmNlcyBvZiBoYXJkd2FyZQ0KPnRoYXQgaGF2
ZSBkaXZlcmdlbnQgcmVnZHM/IEknbSB0aGlua2luZyBvZiBhIGNhc2Ugd2hlcmUgdGhlcmUgYXJl
IDMgdW5kZXJseWluZw0KPmhhcmR3YXJlIHBsYXRmb3Jtcywgb25lIHRoYXQgaXMgMiBHSHosIG9u
ZSB0aGF0IGlzIDUgR0h6LCBhbmQgb25lIHRoYXQgaXMgNiBHSHosIGFuZA0KPmVhY2ggb2YgdGhl
bSBoYXMgYSByZWdkIHRoYXQgb25seSBoYXMgdGhlIHJ1bGVzIGZvciB0aGUgc3VwcG9ydGVkIGJh
bmQuIEluIHN1Y2ggYQ0KPmNhc2Ugd291bGRuJ3QgeW91IG5lZWQgdG8gYWdncmVnYXRlIHRoZSBy
dWxlcyBpbiB0aGUgd2lwaHksIG5vdCBqdXN0IHBpY2sgb25lIG9mIHRoZQ0KPnNldHMgb2YgcnVs
ZXM/DQo+DQo+SWYgdGhhdCBpcyBub3QgYW4gZXhwZWN0ZWQgY2FzZSwgaWRlYWxseSB5b3Ugc2hv
dWxkIGRlc2NyaWJlIHRoZSByZXF1aXJlbWVudHMgJg0KPmFzc3VtcHRpb25zIHRoYXQgYXJlIGlu
IHBsYXkgaGVyZS4NClRoaXMgaXMgbm90IGFuIGV4cGVjdGVkIGNhc2Ugd2l0aCBvdXIgdW5kZXJz
dGFuZGluZyBhbmQgdGVzdGluZyBzbyBmYXIuIFRoZSAyR0h6IGFuZCA1R0h6IHJhZGlvIEZXDQog
d291bGQgcGFzcyB0aGUgcmVnZCBjb21wcmlzaW5nIGJvdGggMkdIeiwgIDVHSHouIFRoZSAgNkdI
eiBGVyBpcyBwYXNzaW5nIGFsbCBvZiB0aGVtIC0gMiw1LDZHSHosIGhlbmNlDQp0aGUgbmVlZCB0
byBjbHViIGFsbCB0aGUgcmVnZCBpbmZvIHNlcGFyYXRlbHkgaXMgbm90IHJlcXVpcmVkLiBJIHdp
bGwgbWFrZSB0aGlzIGFzc3VtcHRpb24gY2xlYXIgaW4gdGhlIG5leHQgcmV2aXNpb24uDQo+DQo+
Pg0KPj4gQWxzbywgd2hlbiByZWd1bGF0b3J5IG5vdGlmaWNhdGlvbiBpcyByZWNlaXZlZCwgdXBk
YXRlIHRvIGFsbCB0aGUNCj4+IHVuZGVybHlpbmcgcmFkaW9zL2FyIHNvIHRoYXQgaXQgYmVjb21l
cyBhd2FyZSBvZiB0aGUgY2hhbmdlIGFuZCBhcw0KPj4gd2VsbCB1cyBpdCB1cGRhdGVzIGl0cyBs
b2NhbCByZWdkIHdpdGggdGhlIG5ldyBjb3VudHJ5IHJ1bGVzLiBMYXRlcg0KPj4gcGljayB0aGUg
YXBwcm9wcmlhdGUgcGRldidzIHJlZ2QoNiBHSHogaWYgYXZhaWxhYmxlKSBhbmQgYXBwbHkgdG8N
Cj4+IGNmZzgwMjExLg0KPg0KPkhlcmUgYWdhaW4sIGNhbiB5b3UgZWxhYm9yYXRlIG9uIHRoZSBy
ZXF1aXJlbWVudHMgYW5kIGFzc3VtcHRpb25zPyBEbyB5b3UNCj51cGRhdGUgYWxsIGNoYW5uZWxz
IHRvIGVhY2ggaGFyZHdhcmUsIGV2ZW4gaWYgZWFjaCBoYXJkd2FyZSBvbmx5IHN1cHBvcnRzIGEN
Cj5zaW5nbGUgYmFuZD8NCkJ5IHVwZGF0ZSBkdXJpbmcgcmVnX25vdGlmaWVyIGhlcmUgd2UgbWVh
biB0aGUgY291bnRyeSBjb2RlIGFsb25lIHRvIGVhY2ggb2YgdGhlIEZXDQphbmQgdGhlIGNoYW5u
ZWwgbGlzdCB1cGRhdGUgb24gcmVjZWl2aW5nIHRoZSByZWdkIHdvdWxkIHVwZGF0ZSBvbmx5IHRo
ZSBjb3JyZXNwb25kaW5nDQpzdXBwb3J0ZWQgY2hhbm5lbHMgdG8gdGhlIHJlc3BlY3RpdmUgRlcg
YW5kIG5vdCB0aGUgY29tYmluZWQgbGlzdC4NCg0KVGhhbmtzLA0KU3JpcmFtLlINCg==

