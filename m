Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450AE696A57
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 17:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjBNQvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 11:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjBNQvZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 11:51:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D62BF30
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 08:51:05 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E5vS0q019139;
        Tue, 14 Feb 2023 16:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=eKIciNup5U6P+AjItWno5b31qq3c4mCJtoec7St/gO0=;
 b=JRPaBkmy0uBGKK8gveufxW41ONBdJF0XhHKtzk94E4ngi08regUWa9XT7cZ4iiaFQcQl
 XdSEIP866BcCXkkJ5iPBpPBPAnzJJm+ytnKrlBxete7qVLZt1rTYAomtKSujEmUZJfgI
 SygiaIEXzoQgdIhIReI1meot/DZpyx/NQ+QB38SlYcpHONhavnjj4hQOX6TTTaK9GrG6
 fuuLLdR/SF6rRzN3nWEntqsxv95hQvxGkpyOCjspYaRKcoIVAe2W1SP2HHDG+n9mVQiU
 Z1LEBrveh5feR5+duQvWDb07OSSR/nZvRtnphJhxDCKY2FVyQwmXiVjSQf6MIkW5qj+/ NA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr4kp9jnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:51:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGp10T000520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:51:01 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 08:51:01 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::1f4c:fdfd:4e0e:1f4c]) by
 nalasex01a.na.qualcomm.com ([fe80::1f4c:fdfd:4e0e:1f4c%4]) with mapi id
 15.02.0986.036; Tue, 14 Feb 2023 08:51:01 -0800
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: mac80211: support poll sta for ML clients
Thread-Topic: [PATCH v2] wifi: mac80211: support poll sta for ML clients
Thread-Index: AQHZLFMvG+NdxCguPU2jxy910wQWfK7PEpqA//+2hgCAAIksgIAABDFQ
Date:   Tue, 14 Feb 2023 16:51:01 +0000
Message-ID: <44ca4d8d7ead49e590f4448523ec2ca2@quicinc.com>
References: <20230119221240.24441-1-quic_srirrama@quicinc.com>
         <8512c5c275dbbb9f3f9d5e946905c3a3fc35457b.camel@sipsolutions.net>
         <121cef28d9b74613adb0ea1b8e072458@quicinc.com>
 <ebda77c69f22c442573a461602800e2980a9e139.camel@sipsolutions.net>
In-Reply-To: <ebda77c69f22c442573a461602800e2980a9e139.camel@sipsolutions.net>
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
X-Proofpoint-GUID: RIzhB95waQfMMSX92aKgZMSPX2R3pkr4
X-Proofpoint-ORIG-GUID: RIzhB95waQfMMSX92aKgZMSPX2R3pkr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=380 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldD4NCj5TZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNCwgMjAyMyAx
MDowNiBQTQ0KPlRvOiBTcmlyYW0gUiAoUVVJQykgPHF1aWNfc3JpcnJhbWFAcXVpY2luYy5jb20+
DQo+Q2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIHdpZmk6IG1hYzgwMjExOiBzdXBwb3J0IHBvbGwgc3RhIGZvciBNTCBjbGllbnRzDQo+
DQo+V0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29t
bS4gUGxlYXNlIGJlIHdhcnkNCj5vZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBu
b3QgZW5hYmxlIG1hY3Jvcy4NCj4NCj5PbiBUdWUsIDIwMjMtMDItMTQgYXQgMTY6MzQgKzAwMDAs
IFNyaXJhbSBSIChRVUlDKSB3cm90ZToNCj4+ID4NCj4+ID4gQWZ0ZXIgYWxsLCB3ZSB3YW50IHRv
IGtub3cgdGhlIE1MRCBpcyBzdGlsbCB0aGVyZSwgbm90IGEgc3BlY2lmaWMNCj4+ID4gU1RBLCBy
aWdodD8NCj4+IEV4YWN0bHkuIEl0IGlzIGVub3VnaCB0byBjaGVjayBpZiB0aGUgTUxEIGlzIGFj
dGl2ZSBhbmQgbm90IHNwZWNpZmljDQo+PiB0byBhbnkgbGluay4NCj4+IEJ1dCwgYXMgeW91IG1l
bnRpb25lZCBhYm92ZSBpdHMgaGFyZCB0byBrbm93IGlmIHBvbGxpbmcgb24gdGhlIGRlZmF1bHQN
Cj4+IGxpbmsgaXMgZ29vZCBlbm91Z2ggdG8gY2hlY2sgTUxEIGlzIGFsaXZlLi4gU28gdGhlIHN1
Z2dlc3Rpb24gaXMgdG8NCj4+IHVzZSB0aGUgbGluayBpZCBhcyBVTlNQRUNJRklFRCBhbmQgbGV0
IGRyaXZlciBkZWNpZGUgdG8gc2VuZCB0aGUgbnVsbA0KPj4gZGF0YSBpbiBhbnkgb2YgdGhlIGFj
dGl2ZSBsaW5rcz8NCj4NCj5ZZXMsIHB1dCBhbGwgdGhlIE1MRCBhZGRyZXNzZXMgaW50byB0aGUg
ZnJhbWUgaWYgd2UgZG9uJ3QgYWxyZWFkeSBkbyB0aGF0DQo+YW55d2F5LCBhbmQgdGhhdCBzaG91
bGQgYmUgZ29vZCBlbm91Z2ggZm9yIHRoZSBkZXZpY2UgdG8gZG8gdGhlIHRyYW5zbGF0aW9uPw0K
U3VyZSwgdGhlbiBJIHRoaW5rIGFwYXJ0IGZyb20gZmlsbGluZyB0aGUgSUVFRTgwMjExX1RYX0NU
UkxfTUxPX0xJTksgaGVyZSBvdGhlciB0aGluZ3MgYXJlIGFscmVhZHkNCkluIHBsYWNlLg0KDQpU
aGFua3MsDQpTcmlyYW0uUg0K
