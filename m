Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123F86969C5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 17:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBNQhD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 11:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjBNQgx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 11:36:53 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A592421E
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 08:36:52 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DNoFGp025950;
        Tue, 14 Feb 2023 16:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=UXvBmA9jq/p7qsxw7N+weKSHAKqvAABHwERSr476xRA=;
 b=NAAt+O8P9FFZphgblm704Y76UE6eajjQxuAlL6wEwDAMYipbjNEgV0cPV+JZMni1jLxQ
 1w+J3cQHhGY5hDRCYW9J0Z9JcRi/uf9Ly+u5hU1KWphx3g4GDW3drflb2vEvxfVpd7g9
 lUZFrDEyJKyHa8EEOPtlzyZtTA9aS9rresbu9vqU6CH6DOpwungac4kkGZHLZY4tM/wy
 kynQW3whY5/WFZ3svP63sIZPDNH6+yoLmDIbpP5p5eXqd/Xx7YRqzsS6boQxxjIEGThD
 BAu/ZUN+h4EZQ9oskV/ehFz43pzf3byfSIC444h4fLuL1RH6VNpezu/rDPpHtbmh+ReJ Bw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqpmmkaqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:36:49 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGamMu011582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:36:48 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 08:36:48 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::1f4c:fdfd:4e0e:1f4c]) by
 nalasex01a.na.qualcomm.com ([fe80::1f4c:fdfd:4e0e:1f4c%4]) with mapi id
 15.02.0986.036; Tue, 14 Feb 2023 08:36:48 -0800
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: mac80211: update rx nss for the link sta
Thread-Topic: [PATCH v2] wifi: mac80211: update rx nss for the link sta
Thread-Index: AQHZLFMh3CFK5VD4n0q2BovHlTC5a67PErmA//+5MIA=
Date:   Tue, 14 Feb 2023 16:36:48 +0000
Message-ID: <42f7609f945b489b9b86aec1064423c7@quicinc.com>
References: <20230119221201.24287-1-quic_srirrama@quicinc.com>
 <16d922bd32b30e1a4282dc5941c6fff3b23908ca.camel@sipsolutions.net>
In-Reply-To: <16d922bd32b30e1a4282dc5941c6fff3b23908ca.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.44.242]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OIgMtBO6iHn648zSVbwKPPH02ZPlmsvA
X-Proofpoint-GUID: OIgMtBO6iHn648zSVbwKPPH02ZPlmsvA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldD4NCj5TZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNCwgMjAyMyA2
OjE4IFBNDQo+VG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNvbT4N
Cj5DYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRD
SCB2Ml0gd2lmaTogbWFjODAyMTE6IHVwZGF0ZSByeCBuc3MgZm9yIHRoZSBsaW5rIHN0YQ0KPg0K
Pk9uIEZyaSwgMjAyMy0wMS0yMCBhdCAwMzo0MiArMDUzMCwgU3JpcmFtIFIgd3JvdGU6DQo+PiBV
cGRhdGUgbnNzIGluZm8gZm9yIHRoZSBub24gZGVmYXVsdCBsaW5rIHN0YXRpb25zIHdoaWNoIGdl
dHMgYWRkZWQNCj4+IGR1cmluZyBNTCBhc3NvYyB3aGVuIGxpbmsgc3RhdGlvbnMgZ2V0cyBhZGRl
ZC4gRm9yIHRoZSBkZWZhdWx0IGxpbmsNCj4+IHN0YSB3aGljaCB3YXMgYWRkZWQgZHVyaW5nIGF1
dGggdGltZSwgdGhlIG5zcyB3b3VsZCBiZSB1cGRhdGVkIGluIHRoZQ0KPj4gdXN1YWwgZmxvdyBk
dXJpbmcgc2V0IHN0YXRpb24gcG9zdCBhc3NvYyBvbmNlIHRoZSBjYXBhYmlsaXRpZXMgYXJlDQo+
PiBhdmFpbGFibGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU3JpcmFtIFIgPHF1aWNfc3JpcnJh
bWFAcXVpY2luYy5jb20+DQo+PiAtLS0NCj4+IHYyOiBhZGRlZCB3aWZpIHByZWZpeCBpbiBjb21t
aXQgdGl0bGUNCj4+ICBuZXQvbWFjODAyMTEvY2ZnLmMgfCA5ICsrKysrKysrKw0KPj4gIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvbmV0L21hYzgw
MjExL2NmZy5jIGIvbmV0L21hYzgwMjExL2NmZy5jIGluZGV4DQo+PiA3MmRmOGM3MDhhMmQuLjBm
ZGY5MmUxNDI4ZiAxMDA2NDQNCj4+IC0tLSBhL25ldC9tYWM4MDIxMS9jZmcuYw0KPj4gKysrIGIv
bmV0L21hYzgwMjExL2NmZy5jDQo+PiBAQCAtMTc1NCw2ICsxNzU0LDE1IEBAIHN0YXRpYyBpbnQg
c3RhX2xpbmtfYXBwbHlfcGFyYW1ldGVycyhzdHJ1Y3QNCj5pZWVlODAyMTFfbG9jYWwgKmxvY2Fs
LA0KPj4gIAkJCQkJCSAgICBwYXJhbXMtPmVodF9jYXBhX2xlbiwNCj4+ICAJCQkJCQkgICAgbGlu
a19zdGEpOw0KPj4NCj4+ICsJLyogdXBkYXRlIG5zcyBpZiBub3QgZG9uZSBhbHJlYWR5IGZvciB0
aGUgbGluayBzdGEsDQo+PiArCSAqIGZvciB0aGUgZGVmbGluayB0aGUgbnNzIHdpbGwgYmUgdXBk
YXRlZCBvbmNlIHRoZQ0KPj4gKwkgKiBhc3NvYyBmbGFnIGlzIHNldCB0aHJvdWdoIHNldCBzdGF0
aW9uLiBGb3IgdGhlDQo+PiArCSAqIG5vbi1kZWZsaW5rIHN0YSB3ZSB3b3VsZCByZWFjaCBoZXJl
IG9ubHkgZHVyaW5nIGFzc29jLA0KPj4gKwkgKiBzbyB3ZSB3b3VsZCBoYXZlIGFsbCBjYXBzIHRv
IGNhbGN1bGF0ZSB0aGUgbnNzLg0KPj4gKwkgKi8NCj4+ICsJaWYgKCZzdGEtPmRlZmxpbmsgIT0g
bGlua19zdGEpDQo+DQo+TkFDSyBvbiB0aGF0IGNoZWNrLiBQbGVhc2UgZmluZCBhIGJldHRlciBw
bGFjZSwgb3IgY2hhbmdlIHRoZSBleGlzdGluZyBjb2RlIGFzDQo+d2VsbCwgb3Igc29tZXRoaW5n
Lg0KPg0KT2sgU3VyZSwgbGV0IG1lIHJldmlldyB0aGlzIHBhcnQgb24gd2hlcmUgaXQgY2FuIGJl
IHVwZGF0ZWQuDQpUaGFua3MsDQpTcmlyYW0uUg0KDQo=
