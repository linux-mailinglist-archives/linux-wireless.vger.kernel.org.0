Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692E32E9B16
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 17:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbhADQbk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 11:31:40 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:23641 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbhADQbk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 11:31:40 -0500
Date:   Mon, 04 Jan 2021 16:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tmb.nu;
        s=protonmail; t=1609777857;
        bh=UAzq6VXinnupBjd/KA8CzFQATjdrvi602WtQUG6OgWo=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=kIU+7UYW9DLmCsQC5m5RW5ivs0c8Pnzb4kNfDg+t0zFulOzHz7iVH7PT/kRD493P8
         OUnasWz9VLWIcLDOUiQRShsnP1q88i0Ue+e7kt5TRHBLkH5tOQZmN0B5/jkAhzxDLd
         PO/WsBMwmM/ZU4OfC5+RRiDY1oah9vFOPmX46pmY=
To:     linux-wireless@vger.kernel.org
From:   Thomas Backlund <tmb@tmb.nu>
Cc:     pkshih@realtek.com
Reply-To: Thomas Backlund <tmb@tmb.nu>
Subject: Re: [PATCH V2 00/18] rtw89: add Realtek 802.11ax driver
Message-ID: <8b91811c-09d4-3ccb-1e7b-bb1c9fe77f9d@tmb.nu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_prOotEj2tw0jnmKdsZXuM9k4dWmJYqiW0ZzuaQUV8"
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.

--b1_prOotEj2tw0jnmKdsZXuM9k4dWmJYqiW0ZzuaQUV8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Den 4.1.2021 kl. 11:17, skrev Ping-Ke Shih:
> This driver named rtw89, which is the next generation of rtw88, supports
> Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
> Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
> though.
>=20

Hi, for some reason patch 16/18 does not show up in patchwork.

Where can one get the needed firmware:

$ modinfo rtw89_core.ko.xz  |grep firmware
firmware:       rtw89/rtw8852a_fw.bin


Also, the driver is missing the pci alias to get autoloading to work,=20
like the attached patch.

--
Thomas



--b1_prOotEj2tw0jnmKdsZXuM9k4dWmJYqiW0ZzuaQUV8
Content-Type: text/plain; name=net-wireless-rtw89-add-missing-MODULE_DEVICE_TABLE.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=net-wireless-rtw89-add-missing-MODULE_DEVICE_TABLE.patch

CkFkZCBtaXNzaW5nIE1PRFVMRV9ERVZJQ0VfVEFCTEUoKSBuZWVkZWQgZm9yIG1vZHVsZSBhdXRv
bG9hZGluZwoKU2lnbmVkLW9mZi1ieTogVGhvbWFzIEJhY2tsdW5kIDx0bWJAbWFnZWlhLm9yZz4K
CmRpZmYgLU51cnAgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5Zy9wY2kuYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGNpLmMKLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg5L3BjaS5jCkBAIC0yNTUzLDYgKzI1NTMsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHBjaV9kZXZpY2VfaWQgcnR3ODlfCiAJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURf
UkVBTFRFSywgMHg4ODUyKSwgLmRyaXZlcl9kYXRhID0gUlRMODg1MkEgfSwKIAl7fSwKIH07CitN
T0RVTEVfREVWSUNFX1RBQkxFKHBjaSwgcnR3ODlfcGNpX2lkX3RhYmxlKTsKIAogc3RhdGljIHN0
cnVjdCBwY2lfZHJpdmVyIHJ0dzg5X3BjaV9kcml2ZXIgPSB7CiAJLm5hbWUJCT0gInJ0dzg5X3Bj
aSIsCg==

--b1_prOotEj2tw0jnmKdsZXuM9k4dWmJYqiW0ZzuaQUV8--

