Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6444D7DC4E2
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 04:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjJaDed (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 23:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaDec (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 23:34:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A72C6
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 20:34:26 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39V3YH0c83811872, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39V3YH0c83811872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 11:34:17 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 31 Oct 2023 11:34:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 31 Oct 2023 11:34:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 31 Oct 2023 11:34:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee <timlee@realtek.com>
Subject: pull request: rtw89: update 8851b/8852b fw to v0.29.41.3/v0.29.29.5
Thread-Topic: pull request: rtw89: update 8851b/8852b fw to
 v0.29.41.3/v0.29.29.5
Thread-Index: AQHaC6sWZ2TJa7f/CUK1ZfMxc4xrCQ==
Date:   Tue, 31 Oct 2023 03:34:00 +0000
Message-ID: <baed3fc347269c3dd34244f34946e09dff183825.camel@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <50EA596FC2BB314B8BA4C9BFA4191EEC@realtek.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGksDQoNClVwZGF0ZSA4ODUxYi84ODUyYiBmaXJtd2FyZSBvZiBydHc4OSBkcml2ZXIgdG8gdjAu
MjkuNDEuMy92MC4yOS4yOS41Lg0KVGhpcyBpcyBtYWlubHkgdG8gZml4IEJULWNvZXhpc3RlbmNl
IGlzc3VlIHRoYXQgY2F1c2VzIEJUIHdvcmtzIGltcHJvcGVybHkNCndoZW4gV2lGaSBlbnRlcnMg
cG93ZXIgc2F2aW5nIG1vZGUuDQoNClRoYW5rIHlvdQ0KUGluZy1LZQ0KDQotLS0NClRoZSBmb2xs
b3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMmIzMDRiZmVjYjI3NGQ1M2YzOGI2NzZkODViNDNi
Y2I4M2RiMzBkZDoNCg0KICBNZXJnZSBicmFuY2ggJ21haW4nIGludG8gJ21haW4nICgyMDIzLTEw
LTMwIDExOjIwOjEzICswMDAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9y
eSBhdDoNCg0KICBodHRwczovL2dpdGh1Yi5jb20vcGtzaGloL2xpbnV4LWZpcm13YXJlLmdpdCBI
RUFEDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byAyYWZkMTQyM2U0NzY1ZWI2OTE3
MTFlYTVlNzhhMTk4NTNjYjJmNmViOg0KDQogIHJ0dzg5OiA4ODUyYjogdXBkYXRlIGZ3IHRvIHYw
LjI5LjI5LjUgKDIwMjMtMTAtMzEgMTE6MjY6MTYgKzA4MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNoaW4tWWVu
IExlZSAoMyk6DQogICAgICBydHc4OTogODg1MWI6IHVwZGF0ZSBmdyB0byB2MC4yOS40MS4zDQog
ICAgICBydHc4OTogODg1MmI6IHVwZGF0ZSBmdyB0byB2MC4yOS4yOS40DQogICAgICBydHc4OTog
ODg1MmI6IHVwZGF0ZSBmdyB0byB2MC4yOS4yOS41DQoNCiBydHc4OS9ydHc4ODUxYl9mdy5iaW4g
ICB8IEJpbiAxMTYwOTg0IC0+IDExNjIwMjQgYnl0ZXMNCiBydHc4OS9ydHc4ODUyYl9mdy0xLmJp
biB8IEJpbiAxMjM3NzA0IC0+IDEyNDI4MDggYnl0ZXMNCiAyIGZpbGVzIGNoYW5nZWQsIDAgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCg0K
