Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB79C4F7BC2
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 11:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiDGJhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 05:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbiDGJhT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 05:37:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD91107C2
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 02:35:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2379ZCxlC001609, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2379ZCxlC001609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Apr 2022 17:35:12 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 17:35:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 17:35:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34]) by
 RTEXMBS04.realtek.com.tw ([fe80::41d7:1d2e:78a6:ff34%5]) with mapi id
 15.01.2308.021; Thu, 7 Apr 2022 17:35:11 +0800
From:   Pkshih <pkshih@realtek.com>
To:     "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "honyuenkwun@gmail.com" <honyuenkwun@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtw88: 8821ce: add support for device ID 0xb821
Thread-Topic: [PATCH 1/2] rtw88: 8821ce: add support for device ID 0xb821
Thread-Index: AQHYSlU3Th3xixTJrk63ThWkSwgp4azjqsSA
Date:   Thu, 7 Apr 2022 09:35:11 +0000
Message-ID: <44c6085a07c132989c31c36b67a0c99bbdb267b3.camel@realtek.com>
References: <20220407075123.420696-1-honyuenkwun@gmail.com>
         <20220407075123.420696-2-honyuenkwun@gmail.com>
In-Reply-To: <20220407075123.420696-2-honyuenkwun@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.82.63]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyDkuIrljYggMDg6MTE6MDA=?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <647CF556A3132148BF042A954E0AE726@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTA3IGF0IDAyOjUxIC0wNTAwLCBKaW1teSBIb24gd3JvdGU6DQo+IE5l
dyBkZXZpY2UgSUQgMHhiODIxIGZvdW5kIG9uIFRQLUxpbmsgVDJFDQo+IFRlc3RlZCBpdCB3aXRo
IGM4MjEgZHJpdmVyLiAyLjRHSHogYW5kIDVHSHogd29ya3MuDQo+IA0KPiBQQ0kgaWQ6DQo+IDA1
OjAwLjAgTmV0d29yayBjb250cm9sbGVyOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQu
IERldmljZSBiODIxDQo+ICAgICAgICAgU3Vic3lzdGVtOiBSZWFsdGVrIFNlbWljb25kdWN0b3Ig
Q28uLCBMdGQuIERldmljZSBiODIxDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaW1teSBIb24gPGhv
bnl1ZW5rd3VuQGdtYWlsLmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQoNCg0K
