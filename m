Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A06969BE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBNQfg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 11:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjBNQff (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 11:35:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DACC2B62E
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 08:35:02 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EB5rhs004835;
        Tue, 14 Feb 2023 16:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=bnz9/DVCtj5NY6Z1hLVZyKQan7z65g1mANWIz8mpFAc=;
 b=Coyyy9tF99panCjVE7j9w8umtGpHyAK48sI4fJjbuOw+Kpdq0srcaE+Icfvd6ooK6Iey
 HCa9muNmQAhXHtJSQsEUbaBnBwxUwg+CqAacICPcyljpWOA+bP1uNix87+WHPr/gQrPf
 UM+GPQ6ObhnzBZGm7DNOYpqQRL+nKoGAOiYb3IweVaPOXDUz1zsobLlqJ3FytCSKLvWY
 h+0vIg7sI20XcKelP4TvKKE+Si6apdLpjL5WkRbMhK8shEHPdqXt4IUZwUTg/aNfBsjC
 8ZjmDd7S2Jt8+DQCokBsN4MZ5x+Uc6xvqxNABMRyrN0eh1gx8MpTNRW0IuoqohRgrHgK JA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6qkh7q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:34:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGYwd0028291
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:34:58 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 08:34:57 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::1f4c:fdfd:4e0e:1f4c]) by
 nalasex01a.na.qualcomm.com ([fe80::1f4c:fdfd:4e0e:1f4c%4]) with mapi id
 15.02.0986.036; Tue, 14 Feb 2023 08:34:57 -0800
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: mac80211: support poll sta for ML clients
Thread-Topic: [PATCH v2] wifi: mac80211: support poll sta for ML clients
Thread-Index: AQHZLFMvG+NdxCguPU2jxy910wQWfK7PEpqA//+2hgA=
Date:   Tue, 14 Feb 2023 16:34:57 +0000
Message-ID: <121cef28d9b74613adb0ea1b8e072458@quicinc.com>
References: <20230119221240.24441-1-quic_srirrama@quicinc.com>
 <8512c5c275dbbb9f3f9d5e946905c3a3fc35457b.camel@sipsolutions.net>
In-Reply-To: <8512c5c275dbbb9f3f9d5e946905c3a3fc35457b.camel@sipsolutions.net>
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
X-Proofpoint-GUID: g5BqsS-0wknRkJwpfF9vqkapMy1A6O_x
X-Proofpoint-ORIG-GUID: g5BqsS-0wknRkJwpfF9vqkapMy1A6O_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=644 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldD4NCj5TZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNCwgMjAyMyA2
OjE4IFBNDQo+VG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNvbT4N
Cj5DYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRD
SCB2Ml0gd2lmaTogbWFjODAyMTE6IHN1cHBvcnQgcG9sbCBzdGEgZm9yIE1MIGNsaWVudHMNCj4N
Cj5PbiBGcmksIDIwMjMtMDEtMjAgYXQgMDM6NDIgKzA1MzAsIFNyaXJhbSBSIHdyb3RlOg0KPj4g
VXBkYXRlIHRoZSBjbGllbnQgcHJvYmUgaGFuZGxpbmcgd2hpY2ggc2VuZHMgTnVsbCBkYXRhIGZy
YW1lcyB0byBjaGVjaw0KPj4gaW5hY3Rpdml0eSB0byBzdXBwb3J0IE1MIFN0YXRpb25zIGFzIHdl
bGwuDQo+Pg0KPj4gUmVwbGFjZSB0aGUgdXNlIG9mIGRlZmF1bHQgYnNzIGNvbmYgd2l0aCB0aGUg
bGluayBzcGVjaWZpYyBjb25mIGFuZA0KPj4gdXNlIHRoZSBzdGF0aW9ucyBkZWZhdWx0IGxpbmsg
dG8gc2VuZCB0aGUgcHJvYmUgZnJhbWUuIE5vbiBNTCBTdGF0aW9ucw0KPj4gYXNzb2NpYXRlZCB0
byB0aGUgTUwgQVAgd291bGQgdXNlIGl0cyBkZWZhdWx0IGxpbmsgYXMgd2VsbCB3aGljaCBpcw0K
Pj4gb25lIG9mIHRoZSBhY3RpdmUgbGlua3MuDQo+Pg0KPj4gRm9yIE5vbiBNTCBBUCwgdGhlIGRl
ZmF1bHQgbGluayBpZCBpcyAwIGFuZCBpdCBpcyB0YWtlbiBjYXJlIGFzIHdlbGwuDQo+DQo+VGhp
cyBzZWVtcyB2ZXJ5IHdyb25nLg0KPg0KPkl0IHNlZW1zIGxpa2UgaWYgd2UgaGF2ZSBhIGxpbmsg
aGVyZSB0aGVuIHVzZXJzcGFjZSBzaG91bGQgcGljayBpdC4NCj4NCj5CdXQhIFRoZSBzdGF0aW9u
IGNvdWxkIGhhdmUgZGlzYWJsZWQgdGhhdCBsaW5rLCBmb3IgZXhhbXBsZSwgYWZ0ZXIgaGF2aW5n
IHVzZWQNCj5pdCBmb3IgYXNzb2NpYXRpb24uIFRoZSBzdGF0aW9uIGFsd2F5cyBoYXMgdGhlIGRl
ZmxpbmsgdXNlZCAodW5saWtlIHZpZikgYnV0DQo+dGhlcmUncyBub3RoaW5nIHRoYXQgc2F5cyB0
aGF0IGl0IG11c3QgYWN0dWFsbHkgYmUgYWN0aXZlIGF0IGFueSBnaXZlbiB0aW1lLg0KPg0KPkhv
d2V2ZXIgdGhhdCBvYnZpb3VzbHkgbWVhbnMgdXNlcnNwYWNlIF9jYW5ub3RfIHBpY2sgaXQuDQo+
DQo+QW5kIHRoZW4gcmVhbGx5IGl0IG1lYW5zIHdlIHNob3VsZCBhZGRyZXNzIHRoaXMgZnJhbWUg
dG8gdGhlIE1MRCBhbmQgbGV0DQo+ZHJpdmVyL2Zpcm13YXJlIHBpY2sgdGhlIHJpZ2h0IGxpbmss
IGFuZCBkbyBhZGRyZXNzIHRyYW5zbGF0aW9uIG9uIGl0LCBldGMuDQo+DQo+QWZ0ZXIgYWxsLCB3
ZSB3YW50IHRvIGtub3cgdGhlIE1MRCBpcyBzdGlsbCB0aGVyZSwgbm90IGEgc3BlY2lmaWMgU1RB
LCByaWdodD8NCkV4YWN0bHkuIEl0IGlzIGVub3VnaCB0byBjaGVjayBpZiB0aGUgTUxEIGlzIGFj
dGl2ZSBhbmQgbm90IHNwZWNpZmljIHRvIGFueSBsaW5rLg0KQnV0LCBhcyB5b3UgbWVudGlvbmVk
IGFib3ZlIGl0cyBoYXJkIHRvIGtub3cgaWYgcG9sbGluZyBvbiB0aGUgZGVmYXVsdCBsaW5rDQpp
cyBnb29kIGVub3VnaCB0byBjaGVjayBNTEQgaXMgYWxpdmUuLiBTbyB0aGUgc3VnZ2VzdGlvbiBp
cyB0byB1c2UgdGhlIGxpbmsgaWQgYXMgVU5TUEVDSUZJRUQgYW5kIGxldA0KZHJpdmVyIGRlY2lk
ZSB0byBzZW5kIHRoZSBudWxsIGRhdGEgaW4gYW55IG9mIHRoZSBhY3RpdmUgbGlua3M/DQoNClRo
YW5rcywNClNyaXJhbS5SDQo=
