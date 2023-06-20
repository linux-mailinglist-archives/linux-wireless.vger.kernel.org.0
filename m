Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595E473637C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 08:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFTGSM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 02:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTGSL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 02:18:11 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8995C6
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 23:18:08 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26a7:0:640:a2d5:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id F37F846C8B;
        Tue, 20 Jun 2023 09:18:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3IagSMrDVCg0-5RhEpYfg;
        Tue, 20 Jun 2023 09:18:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687241884;
        bh=j2I35tbv6d4WIXmoB8QlWamzuNzsL2b2lM+9mrl2CXk=;
        h=Subject:From:Cc:To:Date:Message-ID;
        b=DXG4FId0w7wVUyTEGTC2iHaYuwxoOGuwUdkKOglWhKsXiXfd0iaLI/pXUiQzhUqB8
         p/4WMN0Nzv5ACUNjGgYXvpujKjgn6sGwPVbA+FtKNCuPL8PhRORNi/vgyT5456k7tj
         ztPXw2fw6il9n18ajVnVLHtPLsizngeT96GYqLVI=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <5c114ed7-6e8a-76a7-c0da-4193d1288686@yandex.ru>
Date:   Tue, 20 Jun 2023 09:18:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: ath12k: memcpy() source buffer overread
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V2hlbiBjb21waWxpbmcgd2l0aCBnY2MgMTMuMSBhbmQgQ09ORklHX0ZPUlRJRllfU09VUkNF
PXksIEkndmUgbm90aWNlZCB0aGUgZm9sbG93aW5nOg0KDQouLi4NCkluIGZ1bmN0aW9uIOKA
mGZvcnRpZnlfbWVtY3B5X2Noa+KAmSwNCiAgICAgaW5saW5lZCBmcm9tIOKAmGF0aDEya19w
ZWVyX2Fzc29jX2hfaGXigJkgYXQgZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9t
YWMuYzoxNjQwOjIsDQogICAgIGlubGluZWQgZnJvbSDigJhhdGgxMmtfcGVlcl9hc3NvY19w
cmVwYXJl4oCZIGF0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsvbWFjLmM6MjAy
NzoyOg0KLi9pbmNsdWRlL2xpbnV4L2ZvcnRpZnktc3RyaW5nLmg6NTI5OjI1OiB3YXJuaW5n
OiBjYWxsIHRvIOKAmF9fcmVhZF9vdmVyZmxvdzJfZmllbGTigJkgZGVjbGFyZWQgd2l0aA0K
YXR0cmlidXRlIHdhcm5pbmc6IGRldGVjdGVkIHJlYWQgYmV5b25kIHNpemUgb2YgZmllbGQg
KDJuZCBwYXJhbWV0ZXIpOyBtYXliZSB1c2Ugc3RydWN0X2dyb3VwKCk/DQpbLVdhdHRyaWJ1
dGUtd2FybmluZ10NCiAgIDUyOSB8ICAgICAgICAgICAgICAgICAgICAgICAgIF9fcmVhZF9v
dmVyZmxvdzJfZmllbGQocV9zaXplX2ZpZWxkLCBzaXplKTsNCiAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KSW4gZnVuY3Rpb24g4oCYZm9ydGlmeV9tZW1jcHlfY2hr4oCZLA0KICAgICBpbmxp
bmVkIGZyb20g4oCYYXRoMTJrX3BlZXJfYXNzb2NfaF9oZeKAmSBhdCBkcml2ZXJzL25ldC93
aXJlbGVzcy9hdGgvYXRoMTJrL21hYy5jOjE2NDM6MiwNCiAgICAgaW5saW5lZCBmcm9tIOKA
mGF0aDEya19wZWVyX2Fzc29jX3ByZXBhcmXigJkgYXQgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
YXRoL2F0aDEyay9tYWMuYzoyMDI3OjI6DQouL2luY2x1ZGUvbGludXgvZm9ydGlmeS1zdHJp
bmcuaDo1Mjk6MjU6IHdhcm5pbmc6IGNhbGwgdG8g4oCYX19yZWFkX292ZXJmbG93Ml9maWVs
ZOKAmSBkZWNsYXJlZCB3aXRoDQphdHRyaWJ1dGUgd2FybmluZzogZGV0ZWN0ZWQgcmVhZCBi
ZXlvbmQgc2l6ZSBvZiBmaWVsZCAoMm5kIHBhcmFtZXRlcik7IG1heWJlIHVzZSBzdHJ1Y3Rf
Z3JvdXAoKT8NClstV2F0dHJpYnV0ZS13YXJuaW5nXQ0KICAgNTI5IHwgICAgICAgICAgICAg
ICAgICAgICAgICAgX19yZWFkX292ZXJmbG93Ml9maWVsZChxX3NpemVfZmllbGQsIHNpemUp
Ow0KICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQouLi4NCg0KQW5kIHRoaXMgc2VlbXMgY29ycmVj
dCBiZWNhdXNlOg0KDQovKiBkc3Q6IHUzMlsyXSwgc3JjOiB1OFs2XSwgc2l6ZTogOCBzbyAy
IGJ5dGUgc291cmNlIG92ZXJyZWFkICovDQptZW1jcHkoJmFyZy0+cGVlcl9oZV9jYXBfbWFj
aW5mbywgaGVfY2FwLT5oZV9jYXBfZWxlbS5tYWNfY2FwX2luZm8sDQogICAgICAgIHNpemVv
ZihhcmctPnBlZXJfaGVfY2FwX21hY2luZm8pKTsNCg0KYW5kOg0KDQovKiBkc3Q6IHUzMlsz
XSwgc3JjOiB1OFsxMV0sIHNpemU6IDEyIHNvIDEgYnl0ZSBzb3VyY2Ugb3ZlcnJlYWQgKi8N
Cm1lbWNweSgmYXJnLT5wZWVyX2hlX2NhcF9waHlpbmZvLCBoZV9jYXAtPmhlX2NhcF9lbGVt
LnBoeV9jYXBfaW5mbywNCiAgICAgICAgc2l6ZW9mKGFyZy0+cGVlcl9oZV9jYXBfcGh5aW5m
bykpOw0KDQpEbWl0cnkNCg==
