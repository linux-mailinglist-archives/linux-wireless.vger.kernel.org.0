Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118B94E801E
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 09:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiCZI4h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Mar 2022 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCZI4g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Mar 2022 04:56:36 -0400
Received: from m1368.mail.163.com (m1368.mail.163.com [220.181.13.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE5E1BD2FC
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=9JLde
        jWEwG01m0iNMIGNwN6THuZak8PfBMdTNi01ns8=; b=Wg6SLq3cSa9nYu572+iud
        cJewL5LDEXNI0+GEXXEuted8PytNQ/1ITGzgDsCP7LZd3toYSeuHqlkstrpT81eT
        sqtgMwZTSoS61Ni96tLOlSYituMsX5BABakAgv4eTcX2obVzBta6uZH7X7GHtxg3
        VCXlo/lCpAhQ6zxszy2DpU=
Received: from logoerthiner1$163.com ( [120.244.198.223] ) by
 ajax-webmail-wmsvr68 (Coremail) ; Sat, 26 Mar 2022 16:53:59 +0800 (CST)
X-Originating-IP: [120.244.198.223]
Date:   Sat, 26 Mar 2022 16:53:59 +0800 (CST)
From:   ThinerLogoer <logoerthiner1@163.com>
To:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re:MT7921 mt7921_pci_remove crashes
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <153f1a0c.36a0.17fba8be75c.Coremail.logoerthiner1@163.com>
References: <153f1a0c.36a0.17fba8be75c.Coremail.logoerthiner1@163.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <6042904b.235e.17fc56eadc5.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: RMGowADXkIin1D5iBeYAAA--.7780W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBPQfPnmAY-alxAQAAs3
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

ZGlmZiAnLS1jb2xvcj1hdXRvJyAtdSAtciBvbGQvbGludXgtNS4xNi4xMy9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2kuYyBsaW51eC01LjE2LjEzL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL3BjaS5jCi0tLSBvbGQvbGludXgtNS4x
Ni4xMy9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2kuYwkyMDIy
LTAzLTA5IDAyOjE0OjIwLjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtNS4xNi4xMy9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9wY2kuYwkyMDIyLTAzLTI2IDE2OjE1
OjExLjE5NTAwMDAwMCArMDgwMApAQCAtMjI0LDggKzIyNCw4IEBACiAJc3RydWN0IG10NzZfZGV2
ICptZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwogCXN0cnVjdCBtdDc5MjFfZGV2ICpkZXYg
PSBjb250YWluZXJfb2YobWRldiwgc3RydWN0IG10NzkyMV9kZXYsIG10NzYpOwogCi0JbXQ3OTIx
ZV91bnJlZ2lzdGVyX2RldmljZShkZXYpOwogCWRldm1fZnJlZV9pcnEoJnBkZXYtPmRldiwgcGRl
di0+aXJxLCBkZXYpOworCW10NzkyMWVfdW5yZWdpc3Rlcl9kZXZpY2UoZGV2KTsKIAlwY2lfZnJl
ZV9pcnFfdmVjdG9ycyhwZGV2KTsKIH0KCgoKSSBoYXZlIGhvdC1wYXRjaGVkIHRoZSBtdDc5MjFl
IG1vZHVsZSB3aXRoIHRoZSBgbXQ3OTIxZV91bnJlZ2lzdGVyX2RldmljZWAgbGluZSBhbmQgYGRl
dm1fZnJlZV9pcnFgIGxpbmUgc3dhcHBlZCwgYW5kIG5vdyBtdDc5MjFlIG1vZHVsZSB3b24ndCBw
YW5pYyB3aGVuIGl0IGlzIHVuYmluZGVkLgoKVGVzdGVkIGluIDUuMTYuMTMga2VybmVsIGJ1dCB0
aGlzIHNob3VsZCBhcHBseSB0byBtb3N0IHZlcnNpb25zLgoKSXQgd291bGQgYmUgb2YgZ3JlYXQg
aGVscCBpZiB5b3UgY2FuIHRlc3Qgb3V0IHRoaXMgcGF0Y2ggYW5kIG1lcmdlIHRoZSBwYXRjaC4K
CkF0IDIwMjItMDMtMjQgMTQ6MTA6MDUsICJUaGluZXJMb2dvZXIiIDxsb2dvZXJ0aGluZXIxQDE2
My5jb20+IHdyb3RlOgo+U29ycnkgaWYgdGhpcyBicmluZ3MgeW91IHRoZSBpbmNvbnZlbmllbmNl
LiBJIGFtIG5vdCBmYW1pbGlhciB0byBtYWlsaW5nLgo+Cj5UaGUgaXNzdWUgaXMgcmVwb3J0ZWQg
YXQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9RdWJlc09TL3F1YmVzLWlzc3Vlcy9pc3N1ZXMvNzI5NAo+
Cj5gbXQ3OTIxX3BjaV9yZW1vdmVgIHNlZW1zIHRvIGFsd2F5cyBjcmFzaCB3aGVuZXZlciBpdCBp
cyBjYWxsZWQuIEkgaGF2ZSByZWFkIHRoZSBrZXJuZWwgc291cmNlIGNvZGUgYW5kIGhhdmUgYSBn
dWVzcy4KPgo+YGBgCj5zdGF0aWMgdm9pZCBtdDc5MjFfcGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldikKPnsKPglzdHJ1Y3QgbXQ3Nl9kZXYgKm1kZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRl
dik7Cj4Jc3RydWN0IG10NzkyMV9kZXYgKmRldiA9IGNvbnRhaW5lcl9vZihtZGV2LCBzdHJ1Y3Qg
bXQ3OTIxX2RldiwgbXQ3Nik7Cj4KPgltdDc5MjFlX3VucmVnaXN0ZXJfZGV2aWNlKGRldik7Cj4J
ZGV2bV9mcmVlX2lycSgmYW1wO3BkZXYtJmd0O2RldiwgcGRldi0mZ3Q7aXJxLCBkZXYpOwo+CXBj
aV9mcmVlX2lycV92ZWN0b3JzKHBkZXYpOwo+fQo+YGBgCj4KPkZyb20gbXkgbmV3YmllIGtlcm5l
bCBrbm93bGVkZ2UgSSBzdXNwZWN0IHRoYXQgYG10NzkyMV9wY2lfcmVtb3ZlYCBzaG91bGQgZmly
c3QgY2FsbCBgZGV2bV9mcmVlX2lycWAgYW5kIHRoZW4gYG10NzkyMWVfdW5yZWdpc3Rlcl9kZXZp
Y2VgLCBkdWUgdG8gdGhlIHJlYXNvbiB0aGF0IGBkZXZtX2ZyZWVfaXJxYCBjYWxscyBgZnJlZV9p
cnFgIHRoYXQgImRvZXMgbm90IHJldHVybiB1bnRpbCBhbnkgZXhlY3V0aW5nIGludGVycnVwdHMg
Zm9yIHRoaXMgSVJRIGhhdmUgY29tcGxldGVkIiBhY2NvcmRpbmcgdG8gdGhlIGNvbW1lbnQgdGhl
cmUsIGFuZCB0aGF0IHdoZW4gSVJRIGZvciBtdDc5MjEgaXMgYmVpbmcgaGFuZGxlZCwgaXQgMTAw
JSB1c2VzIHNvbWUgZmllbGRzIGluIGBkZXZgLCBzbyBiZWZvcmUgdGhhdCBgZGV2YCBjYW5ub3Qg
YmUgdW5yZWdpc3RlcmVkLgo+Cj5UaGlzIGNhbiBiZSByZXByb2R1Y2VkIGJ5IGVjaG9pbmcgYSBw
Y2kgYWRkcmVzcyAoZm9yIGV4YW1wbGUgYDAwMDA6MDA6MDcuMGApIHRvIGAvc3lzL2J1cy9wY2kv
ZHJpdmVycy9tdDc5MjFlL3VuYmluZGAuCg==
