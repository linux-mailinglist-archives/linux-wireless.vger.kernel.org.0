Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1FC4E5E84
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Mar 2022 07:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiCXGME (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Mar 2022 02:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiCXGMD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Mar 2022 02:12:03 -0400
Received: from m131.mail.163.com (m131.mail.163.com [220.181.13.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 053ED583B1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=BurWx
        9hL3lM/65TTnr4TMjDNRBhqQYed+e0tCXCstqE=; b=bZMv7RS/InO9qNiB9mBTc
        IF4z9MRM/XNjHTcslimgPeGbm0mGDNFf7IhsXrfIRzd+yw7RMfnNojawNedTC2xj
        DcOZ6O4DBi9KLHvftqNm4LN6i8FjM0XKOh1ndYViSOh1yD6AYCs55aRrKBUmTf80
        TGV8WB2c9ERy7u6Hgydaso=
Received: from logoerthiner1$163.com ( [120.244.198.223] ) by
 ajax-webmail-wmsvr1 (Coremail) ; Thu, 24 Mar 2022 14:10:05 +0800 (CST)
X-Originating-IP: [120.244.198.223]
Date:   Thu, 24 Mar 2022 14:10:05 +0800 (CST)
From:   ThinerLogoer <logoerthiner1@163.com>
To:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com
Cc:     linux-wireless@vger.kernel.org
Subject: MT7921 mt7921_pci_remove crashes
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <153f1a0c.36a0.17fba8be75c.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AcGowAD3Suw9CzxiwS0LAA--.14286W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBax3Nnlet3qLO-AAAsR
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U29ycnkgaWYgdGhpcyBicmluZ3MgeW91IHRoZSBpbmNvbnZlbmllbmNlLiBJIGFtIG5vdCBmYW1p
bGlhciB0byBtYWlsaW5nLgoKVGhlIGlzc3VlIGlzIHJlcG9ydGVkIGF0OiBodHRwczovL2dpdGh1
Yi5jb20vUXViZXNPUy9xdWJlcy1pc3N1ZXMvaXNzdWVzLzcyOTQKCmBtdDc5MjFfcGNpX3JlbW92
ZWAgc2VlbXMgdG8gYWx3YXlzIGNyYXNoIHdoZW5ldmVyIGl0IGlzIGNhbGxlZC4gSSBoYXZlIHJl
YWQgdGhlIGtlcm5lbCBzb3VyY2UgY29kZSBhbmQgaGF2ZSBhIGd1ZXNzLgoKYGBgCnN0YXRpYyB2
b2lkIG10NzkyMV9wY2lfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQp7CglzdHJ1Y3QgbXQ3
Nl9kZXYgKm1kZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRldik7CglzdHJ1Y3QgbXQ3OTIxX2RldiAq
ZGV2ID0gY29udGFpbmVyX29mKG1kZXYsIHN0cnVjdCBtdDc5MjFfZGV2LCBtdDc2KTsKCgltdDc5
MjFlX3VucmVnaXN0ZXJfZGV2aWNlKGRldik7CglkZXZtX2ZyZWVfaXJxKCZhbXA7cGRldi0mZ3Q7
ZGV2LCBwZGV2LSZndDtpcnEsIGRldik7CglwY2lfZnJlZV9pcnFfdmVjdG9ycyhwZGV2KTsKfQpg
YGAKCkZyb20gbXkgbmV3YmllIGtlcm5lbCBrbm93bGVkZ2UgSSBzdXNwZWN0IHRoYXQgYG10Nzky
MV9wY2lfcmVtb3ZlYCBzaG91bGQgZmlyc3QgY2FsbCBgZGV2bV9mcmVlX2lycWAgYW5kIHRoZW4g
YG10NzkyMWVfdW5yZWdpc3Rlcl9kZXZpY2VgLCBkdWUgdG8gdGhlIHJlYXNvbiB0aGF0IGBkZXZt
X2ZyZWVfaXJxYCBjYWxscyBgZnJlZV9pcnFgIHRoYXQgImRvZXMgbm90IHJldHVybiB1bnRpbCBh
bnkgZXhlY3V0aW5nIGludGVycnVwdHMgZm9yIHRoaXMgSVJRIGhhdmUgY29tcGxldGVkIiBhY2Nv
cmRpbmcgdG8gdGhlIGNvbW1lbnQgdGhlcmUsIGFuZCB0aGF0IHdoZW4gSVJRIGZvciBtdDc5MjEg
aXMgYmVpbmcgaGFuZGxlZCwgaXQgMTAwJSB1c2VzIHNvbWUgZmllbGRzIGluIGBkZXZgLCBzbyBi
ZWZvcmUgdGhhdCBgZGV2YCBjYW5ub3QgYmUgdW5yZWdpc3RlcmVkLgoKVGhpcyBjYW4gYmUgcmVw
cm9kdWNlZCBieSBlY2hvaW5nIGEgcGNpIGFkZHJlc3MgKGZvciBleGFtcGxlIGAwMDAwOjAwOjA3
LjBgKSB0byBgL3N5cy9idXMvcGNpL2RyaXZlcnMvbXQ3OTIxZS91bmJpbmRgLg==
