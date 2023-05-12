Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E811D6FFE43
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 03:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbjELBH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 21:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELBH2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 21:07:28 -0400
Received: from m1346.mail.163.com (m1346.mail.163.com [220.181.13.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F382185;
        Thu, 11 May 2023 18:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=T/O302IAcB7QpRto9iIQfmF33Q10kFLsAaDuHFznmZE=; b=J
        c6Q1wb2s1/XSWn92f8vI8JzxBu2MApS2r4W4gvk9jGwEvl1wf2vvYpW/XJpxhmB2
        PNOHYeCLBHdi/oegECsEjzGJvEn0YuCLZvW7MhNcHrZHwSP081SD21eEXdSjGQiZ
        1ZMcdQdCFQugh7IOUWKyDcuMTpXYDyRaRXVKKAKku4=
Received: from luyun_611$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr46 (Coremail) ; Fri, 12 May 2023 09:06:09 +0800 (CST)
X-Originating-IP: [116.128.244.169]
Date:   Fri, 12 May 2023 09:06:09 +0800 (CST)
From:   "Yun Lu" <luyun_611@163.com>
To:     "Simon Horman" <simon.horman@corigine.com>
Cc:     "Larry Finger" <Larry.Finger@lwfinger.net>, Jes.Sorensen@gmail.com,
        kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re:Re: [PATCH v2] wifi: rtl8xxxu: fix authentication timeout due to
 incorrect RCR value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <ZFzfAH+a4ivS3gXo@corigine.com>
References: <20230511031825.2125279-1-luyun_611@163.com>
 <d8b5f499-6778-34c0-1f12-9d0f6698abb7@lwfinger.net>
 <ZFzfAH+a4ivS3gXo@corigine.com>
X-NTES-SC: AL_QuyTAfSevE0t7yWYZOkXnE4XhO8+Wsqzv/Ui24VTOZ00iCni0woqcmVSL2Xn08+NMwKhqgK4XDdK5utzfrFFRY8isfDKgeyuabFwXwjvbhNS
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5666004c.867.1880d7e6ddf.Coremail.luyun_611@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LsGowAAHotUCkV1kA2kUAA--.36335W
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiQx5szlc7eW924AACsR
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

CkF0IDIwMjMtMDUtMTEgMjA6MjY6NDAsICJTaW1vbiBIb3JtYW4iIDxzaW1vbi5ob3JtYW5AY29y
aWdpbmUuY29tPiB3cm90ZToKPk9uIFdlZCwgTWF5IDEwLCAyMDIzIGF0IDExOjM0OjE5UE0gLTA1
MDAsIExhcnJ5IEZpbmdlciB3cm90ZToKPj4gT24gNS8xMC8yMyAyMjoxOCwgWXVuIEx1IHdyb3Rl
Ogo+PiA+IEZyb206IFl1biBMdSA8bHV5dW5Aa3lsaW5vcy5jbj4KPj4gPiAKPj4gPiBXaGVuIHVz
aW5nIHJ0bDgxOTJjdSB3aXRoIHJ0bDh4eHh1IGRyaXZlciB0byBjb25uZWN0IHdpZmksIHRoZXJl
IGlzIGEKPj4gPiBwcm9iYWJpbGl0eSBvZiBmYWlsdXJlLCB3aGljaCBzaG93cyAiYXV0aGVudGlj
YXRpb24gd2l0aCAuLi4gdGltZWQgb3V0Ii4KPj4gPiBUaHJvdWdoIGRlYnVnZ2luZywgaXQgd2Fz
IGZvdW5kIHRoYXQgdGhlIFJDUiByZWdpc3RlciBoYXMgYmVlbiBpbmV4cGxpY2FibHkKPj4gPiBt
b2RpZmllZCB0byBhbiBpbmNvcnJlY3QgdmFsdWUsIHJlc3VsdGluZyBpbiB0aGUgbmljIG5vdCBi
ZWluZyBhYmxlIHRvCj4+ID4gcmVjZWl2ZSBhdXRoZW50aWNhdGVkIGZyYW1lcy4KPj4gPiAKPj4g
PiBUbyBmaXggdGhpcyBwcm9ibGVtLCBhZGQgcmVncmNyIGluIHJ0bDh4eHh1X3ByaXYgc3RydWN0
LCBhbmQgc3RvcmUKPj4gPiB0aGUgUkNSIHZhbHVlIGV2ZXJ5IHRpbWUgdGhlIHJlZ2lzdGVyIGlz
IHdyaXRlbiwgYW5kIHVzZSBpdCB0aGUgbmV4dAo+Cj5uaXQ6IHMvd3JpdGVuL3dyaXR0ZW4vCj4K
Pj4gPiB0aW1lIHRoZSByZWdpc3RlciBuZWVkIHRvIGJlIG1vZGlmaWVkLgo+PiA+IAo+PiA+IFNp
Z25lZC1vZmYtYnk6IFl1biBMdSA8bHV5dW5Aa3lsaW5vcy5jbj4KPgo+Li4uCgpZZWFoLCBpdCdz
IG15IG1pc3Rha2UuIEkgd2lsbCBzZW5kIGEgdGhpcmQgdmVyc2lvbiBsYXRlciB0byBjb3JyZWN0
IGl0LgoKVGhhbmtzLgo=
