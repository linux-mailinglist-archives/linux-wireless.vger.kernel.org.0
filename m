Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55636696969
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 17:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBNQZ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 11:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBNQZz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 11:25:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623AA2CC4E
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 08:25:32 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E8FTMI022835;
        Tue, 14 Feb 2023 16:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=vKg3A1JQrnLTqq45V4KKjlOuchxodV3nR2igr7547ZA=;
 b=HAHhq0kyw7YPWLg33VPYHWLfpRN5ZtCV0hvG/eCwV/X5zEavAPZY1QllIUlPET8yIIHl
 X+2uR8LwsKNnGavERNIXy7605NvDPJgG+MFm6zl9Ra33mKYSAN9kMIlwJkztPLtBqHEQ
 u0X19BMCyiG00f+RXBaS5hVhoKLrbr3W5JCS+8JXZeTHsApR3sRC53HGpUX8r/wL3K1s
 pSEAxMEwxFsruYAuez0tYrowOGt001kEWVhpfqoXavep96Vb7kwwiaOCUukuqkpEBdKJ
 /N8UAGFcaIAMOvqzZTa14MIVhQCAIYx85vpW/5DLGVgI5KwhXlX08cZAuFWo7ETMa0Oq mA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqpmmk9v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:25:01 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGOxSU016262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:24:59 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 08:24:59 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::1f4c:fdfd:4e0e:1f4c]) by
 nalasex01a.na.qualcomm.com ([fe80::1f4c:fdfd:4e0e:1f4c%4]) with mapi id
 15.02.0986.036; Tue, 14 Feb 2023 08:24:59 -0800
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: mac80211: validate link status before deciding
 on mgmt tx
Thread-Topic: [PATCH v2] wifi: mac80211: validate link status before deciding
 on mgmt tx
Thread-Index: AQHZLFNDNH9Gan3tUkWVODr0qAToDq7PEgGA//+uV2A=
Date:   Tue, 14 Feb 2023 16:24:59 +0000
Message-ID: <a11a329efbca4f3fbcba2d0586297f9f@quicinc.com>
References: <20230119221306.24526-1-quic_srirrama@quicinc.com>
 <5fe1e6eea00f33be59ae0aaf0429be08595dfc03.camel@sipsolutions.net>
In-Reply-To: <5fe1e6eea00f33be59ae0aaf0429be08595dfc03.camel@sipsolutions.net>
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
X-Proofpoint-ORIG-GUID: pUjLB0UQqk4vWSwnVBg8CVuBPyfiWjpy
X-Proofpoint-GUID: pUjLB0UQqk4vWSwnVBg8CVuBPyfiWjpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140140
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
OjE2IFBNDQo+VG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNvbT4N
Cj5DYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtQQVRD
SCB2Ml0gd2lmaTogbWFjODAyMTE6IHZhbGlkYXRlIGxpbmsgc3RhdHVzIGJlZm9yZSBkZWNpZGlu
ZyBvbg0KPm1nbXQgdHgNCj4NCj5PbiBGcmksIDIwMjMtMDEtMjAgYXQgMDM6NDMgKzA1MzAsIFNy
aXJhbSBSIHdyb3RlOg0KPj4gQ3VycmVudGx5IHdlIGNoZWNrIHRoZSBzdGF0dXMgb2YgYnNzIGFj
dGl2ZSBmbGFnIHRvIHNlZSBpZiB0aGUgQVAgaXMNCj4+IGFjdGl2ZS4NCj4+DQo+DQo+Rm9sbG93
aW5nIHNvIGZhciA6KQ0KPg0KPj4gQnV0IGluIGNhc2Ugb2YgYSBNTEQgQVAsIHdoZW4gc29tZSBv
ZiB0aGUgbGlua3MgYXJlIGdldHRpbmcgdGVhcmRvd24NCj4NCj4iZ2V0dGluZyB0b3JuIGRvd24i
Pw0KUmlnaHQsIEknbGwgdXBkYXRlIGluIHRoZSBuZXh0IHJldmlzaW9uLg0KPg0KPj4gYW5kIHNv
bWUgYXJlIGFjdGl2ZSwgbWdtdCBUeChsaWtlIGRlYXV0aCkgY2FuIGJlIHNlbnQgb24gc29tZSBs
aW5rcw0KPj4gYmVmb3JlIHRoZXkgYXJlIGJyb3VnaHQgZG93biBhcyB3ZWxsLg0KPg0KPk1ha2Vz
IHNlbnNlLg0KPg0KPj4gSW4gc3VjaCBjYXNlcywgdGhlIGJzcyBhY3RpdmUgZmxhZyBtaWdodCBu
b3QgcHJvdmlkZSB0aGUgZXhhY3Qgc3RhdHVzDQo+PiBvZiB0aGUgTUxEIGxpbmtzLCB3aGljaCBi
ZWNvbWVzIGZhbHNlIG9uIGZpcnN0IGxpbmsgZGVsZXRlZC4NCj4NCj5XYWl0LCBpc24ndCB0aGF0
IGFscmVhZHkgYSBidWc/DQpUaGlzIGNvbW1pdCAoImNvbW1pdCBiZmQ4NDAzYWRkZGQwOWYzMjAz
M2ExNGJmMjViZTM5ODI5MWU3ODgxIikgaW50cm9kdWNlZCB0aGlzIGZsYWcNCmZvciB3aG9sZSBB
UChNTEQpIGFuZCByZXBsYWNlZCAgYmVhY29uIHNpbmNlIGl0IGlzIGxpbmsgc3BlY2lmaWMuIEhl
bmNlIEkgdGhvdWdodCBJdCB3YXMNCmJyb3VnaHQgaW4gdG8gcmVwcmVzZW50IGEgTUxEIHdoZXJl
YXMgdGhlIGJlYWNvbiBwdHIgY2FuIGJlIGNoZWNrZWQgaWYgYSBjZXJ0YWluIGxpbmsgaXMgYWN0
aXZlLg0KSGVuY2UgdXNlZCBib3RoIGJzcy0+YWN0aXZlIGFuZCBiZWFjb24gY2hlY2tzIHRvIHNl
ZSBpZiBhdGxlYXN0IG9uZSBsaW5rIGlzIGFjdGl2ZS4NCj4NCj4+IEhlbmNlIGNoZWNrIGlmIGFu
eSBvZiB0aGUgbGlua3MgY2FuIGJlIHVzZWQgZm9yIG1nbXQgdHggYmVmb3JlDQo+PiByZXR1cm5p
bmcgZXJyb3Igc3RhdHVzLg0KPj4NCj4+IEFsc28sIHVzZSB0aGUgbGluayBpZCBwYXNzZWQgZnJv
bSB1c2Vyc3BhY2Ugd2hlbiB0aGUgbGluayBic3MgYWRkcmVzcw0KPj4gbWF0Y2hlcyB0aGUgbWdt
dCBTQSBhbmQgdGhlIGNoYW4gcGFyYW1zIG1hdGNoIHRoZSByZXF1ZXN0Lg0KPj4gVGhpcyB3aWxs
IGF2b2lkIHNjZW5hcmlvIHdoZXJlIHRoZSBsaW5rIGlkIGZyb20gdXNlcnNwYWNlIGdldHMgcmVz
ZXQuDQo+DQo+ImdldHMgcmVzZXQiPz8NCkluIGllZWU4MDIxMV9tZ210X3R4KCkgdGhlIGxpbmsg
aWQgd2hpY2ggd2FzIHBhc3NlZCBmcm9tIHVzZXJzcGFjZSBpcw0KSWdub3JlZCBpZiBpdHMgbm90
IGFuIGFjdGlvbiBmcmFtZS4gSGVuY2UgdGhlIGJlbG93IGNoYW5nZSB3YXMgZG9uZSB0byBjaGVj
ayBpZiBvbmUgb2YgdGhlDQpMaW5rIGJzcyAgbWF0Y2hlcyB3aXRoIHRoZSBsaW5rIGlkIHBhc3Nl
ZA0KQWxzbywgaW4gX19pZWVlODAyMTFfdHhfc2tiX3RpZF9iYW5kKCkgdGhlIGJlbG93IGVsc2Vp
ZiBjb25kaXRpb24gbWlnaHQgbm90IGJlDQphcHByb3ByaWF0ZSBpbiBjYXNlIHRoZSBNTEQgYWRk
cmVzcyBhbmQgb25lIG9mIHRoZSBsaW5rIGFkZHJlc3MgaXMgc2FtZS4NCiAgICAgICAgfSBlbHNl
IGlmIChtZW1jbXAoc2RhdGEtPnZpZi5hZGRyLCBoZHItPmFkZHIyLCBFVEhfQUxFTikgPT0gMCkg
ew0KICAgICAgICAgICAgICAgIC8qIGFkZHJlc3MgZnJvbSB0aGUgTUxEICovDQogICAgICAgICAg
ICAgICAgbGluayA9IElFRUU4MDIxMV9MSU5LX1VOU1BFQ0lGSUVEOw0KICAgICAgICB9IGVsc2Ug
ew0KDQpIZW5jZSB3YW50ZWQgdG8gZml4IGluIHRoZSBpZWVlODAyMTFfbWdtdF90eCgpIGl0c2Vs
ZiB0byB1c2UgdGhlIHByb3BlciBsaW5rIGlkDQpwYXNzZWQgZnJvbSB1c2Vyc3BhY2UgYW5kIGF2
b2lkIGdldHRpbmcgcmVzZXQgdG8gLTEuDQo+DQo+Pg0KPj4gK3N0YXRpYyBib29sIGllZWU4MDIx
MV9pc19saW5rX2Jzc19hY3RpdmUoc3RydWN0IGllZWU4MDIxMV9zdWJfaWZfZGF0YQ0KPipzZGF0
YSwNCj4+ICsJCQkJCSBpbnQgbGlua19pZCkNCj4+ICt7DQo+Wy4uLl0NCj4+ICsJc2RhdGFfbG9j
ayhzZGF0YSk7DQo+PiArCWxpbmsgPSBzZGF0YV9kZXJlZmVyZW5jZShzZGF0YS0+bGlua1tsaW5r
X2lkXSwgc2RhdGEpOw0KPj4gKwlpZiAoIWxpbmspIHsNCj4+ICsJCXNkYXRhX3VubG9jayhzZGF0
YSk7DQo+PiArCQlyZXR1cm4gZmFsc2U7DQo+PiArCX0NCj4+ICsNCj4+ICsJaWYgKHNkYXRhX2Rl
cmVmZXJlbmNlKGxpbmstPnUuYXAuYmVhY29uLCBzZGF0YSkpIHsNCj4+ICsJCXNkYXRhX3VubG9j
ayhzZGF0YSk7DQo+PiArCQlyZXR1cm4gdHJ1ZTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlzZGF0YV91
bmxvY2soc2RhdGEpOw0KPg0KPlRoZSBsb2NraW5nIGhlcmUgaXMgLi4uIGRlY2lkZWRseSBvZGQu
IEl0IGZlZWxzIGxpa2Ugd2l0aCBhbGwgdGhlIHdkZXZfbG9jaygpaW5nDQo+Z29pbmcgb24gaW4g
Y2ZnODAyMTFfbWxtZV9tZ210X3R4KCkgd2Ugc2hvdWxkIHByb2JhYmx5IGp1c3QgbG9jayBhcm91
bmQNCj50aGUgKmVudGlyZSogdGhpbmcgaW4gY2ZnODAyMTEsIGluY2x1ZGluZyB0aGUNCj5kcml2
ZXIvbWFjODAyMTEgY2FsbD8NClN1cmUsIGxldCBtZSByZXZpc2l0IHRoaXMgaW4gdGhlIG5leHQg
dmVyc2lvbi4NCj4NCj4+IEBAIC04ODMsOCArOTIwLDE3IEBAIGludCBpZWVlODAyMTFfbWdtdF90
eChzdHJ1Y3Qgd2lwaHkgKndpcGh5LCBzdHJ1Y3QNCj53aXJlbGVzc19kZXYgKndkZXYsDQo+PiAg
CQkJCWJyZWFrOw0KPj4gIAkJCX0NCj4+DQo+PiAtCQkJaWYgKGV0aGVyX2FkZHJfZXF1YWwoY29u
Zi0+YWRkciwgbWdtdC0+c2EpKQ0KPj4gKwkJCWlmIChldGhlcl9hZGRyX2VxdWFsKGNvbmYtPmFk
ZHIsIG1nbXQtPnNhKSkgew0KPj4gKwkJCQkvKiBJZiB1c2Vyc3BhY2UgcmVxdWVzdGVkIFR4IG9u
IGEgc3BlY2lmaWMgbGluaw0KPj4gKwkJCQkgKiB1c2UgdGhlIHNhbWUgbGluayBpZCBpZiB0aGUg
bGluayBic3MgaXMNCj5tYXRjaGluZw0KPj4gKwkJCQkgKiB0aGUgcmVxdWVzdGVkIGNoYW4uDQo+
PiArCQkJCSAqLw0KPj4gKwkJCQlpZiAoc2RhdGEtPnZpZi52YWxpZF9saW5rcyAmJg0KPj4gKwkJ
CQkgICAgcGFyYW1zLT5saW5rX2lkID49IDAgJiYgcGFyYW1zLT5saW5rX2lkID09DQo+aSAmJg0K
Pj4gKwkJCQkgICAgcGFyYW1zLT5jaGFuID09IGNoYW5jdHhfY29uZi0+ZGVmLmNoYW4pDQo+PiAr
CQkJCQlsaW5rX2lkID0gaTsNCj4+ICAJCQkJYnJlYWs7DQo+PiArCQkJfQ0KPg0KPg0KPk5vdCBz
dXJlIEkgZ2V0IGl0LCBpZiBpdCdzIGJhZCAobGluayBJRCBkb2Vzbid0IG1hdGNoIEJTUykgdGhl
biBzaG91bGRuJ3Qgd2UganVzdA0KPnJlamVjdCBpdD8NCkFzIG1lbnRpb25lZCBhYm92ZSB0aGUg
bGluayBpZCBnZXRzIHNldCB0byAtMSBzaW5jZSB0aGUgc3dpdGNoIGNhc2UgZm9yIE5MODAyMTFf
SUZUWVBFX0FQDQpzZXRzIHRoZSBsaW5rIGlkIGZyb20gcGFyYW1zLT5saW5rX2lkIG9ubHkgd2hl
biBpdOKAmXMgYW4gYWN0aW9uIGZyYW1lLg0KV2UgbWlnaHQgaGF2ZSB0byBob25vciB0aGUgbGlu
ayBpZCBwYXNzZWQgaW4gcGFyYW1zLT5saW5rX2lkIGZvciBhbnkgbWFuYWdlbWVudCBmcmFtZQ0K
LCByaWdodD8sIHNvIHRoYXQgdGhlIGFkZHJlc3MgdHJhbnNsYXRpb24gaXMgZG9uZSBwcm9wZXJs
eSBpbiBkcml2ZXIgZm9yIGFsbCBtZ210LiBmcmFtZXMNClBsZWFzZSBsZXQgbWUga25vdyBpZiBz
b21ldGhpbmcgaXMgbWlzdW5kZXJzdG9vZCBoZXJlLg0KDQpUaGFua3MsDQpTcmlyYW0uUg0KDQo=
