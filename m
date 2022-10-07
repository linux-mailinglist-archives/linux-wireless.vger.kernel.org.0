Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE15F76FE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJGKkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 06:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJGKkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 06:40:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0634C13FA4
        for <linux-wireless@vger.kernel.org>; Fri,  7 Oct 2022 03:39:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 297AdLesD001230, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 297AdLesD001230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 7 Oct 2022 18:39:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 18:39:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Oct 2022 18:39:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::402d:f52e:eaf0:28a2]) by
 RTEXMBS04.realtek.com.tw ([fe80::402d:f52e:eaf0:28a2%5]) with mapi id
 15.01.2375.007; Fri, 7 Oct 2022 18:39:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>, Kevin Yang <kevin_yang@realtek.com>
Subject: pull request: rtw89: 8852c: update fw to v0.27.56.1
Thread-Topic: pull request: rtw89: 8852c: update fw to v0.27.56.1
Thread-Index: AQHY2jkfiGGzjUawtEacVS1KDuoXZA==
Date:   Fri, 7 Oct 2022 10:39:49 +0000
Message-ID: <3e31775b3916b4d9300e6156564dc80f889c4b8b.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.69.151]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzcg5LiK5Y2IIDA0OjU0OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <9429BC6822470241B6E003A2AF80F4C2@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClVwZGF0ZSA4ODUyYyBmaXJtd2FyZSBvZiBydHc4OSBkcml2ZXIgdG8gdjAuMjcuNTYu
MQ0KDQpUaGFuayB5b3UNClBpbmctS2UNCg0KLS0tDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2lu
Y2UgY29tbWl0IGQyYWFjNjNiODM4MWMwNjMzZGUwMDQ3NmE3ZjNkOGY0MzZlYTRiYzU6DQoNCiAg
cnR3ODk6IDg4NTJjOiB1cGRhdGUgZncgdG8gdjAuMjcuNTYuMSAoMjAyMi0xMC0wNyAxODozNTo0
NyArMDgwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAg
aHR0cHM6Ly9naXRodWIuY29tL3Brc2hpaC9saW51eC1maXJtd2FyZS5naXQgDQoNCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBkMmFhYzYzYjgzODFjMDYzM2RlMDA0NzZhN2YzZDhmNDM2
ZWE0YmM1Og0KDQogIHJ0dzg5OiA4ODUyYzogdXBkYXRlIGZ3IHRvIHYwLjI3LjU2LjEgKDIwMjIt
MTAtMDcgMTg6MzU6NDcgKzA4MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0K
