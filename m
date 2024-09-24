Return-Path: <linux-wireless+bounces-13095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D31C983B21
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 04:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F191D1F21171
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 02:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE24414;
	Tue, 24 Sep 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ouopGW8Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE81B85FF
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727144238; cv=none; b=tQrExFlbBT7ntqCQK2L7bhtkIN0zgbYfLXjjoo2tpt3CUU5ulYHLy58cbkxzlvxPGQdLerjNOGmcI9bRZp2yrFw/EgeblCRdfczBVlD/prb0MMElJxzAgBvHnXWelkUCP0dNdovSGxaQXx7RhWutuUGbDhiXlcVv9EHnqK76GMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727144238; c=relaxed/simple;
	bh=eol4ld1zYQ/ELSY2k48SDLC+CX3S8XHhOkytotAZOvE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GQonQYA1zHJ/rw45VYB4NXLD0Vj80QYHYK/J++w28Cj91nJkL8Y/4oYwBhygO3FoSbGPNglMwL+YbNW0yu87YMl8bJsVTQ6dizcWT7JVcnv7qrTX3iB475bNOLPt7CAB+mAJao/jK3fMcW62x7WS6kMopBkpK++ZygKkNkrCu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ouopGW8Q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48O2H9WB02228303, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727144229; bh=eol4ld1zYQ/ELSY2k48SDLC+CX3S8XHhOkytotAZOvE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	b=ouopGW8QbnKVBWeAwlhgadFT/fxGieI0uwCYLlCaBd1rhQsefWtkld23+AxHzpdPL
	 6n0ehM1/gvYo8lfL30K8eCX4hwzjTud0TtZ7UiWzYR11WWB/+66CSYEEixFHW83pKH
	 S2gU4gIKAqbiS1Tf0kp/RVEyzZSapCPB6tDg/tQgUadJISlteyFXrI+6qQouhLVXv3
	 5/bSPsZrkuVGit4e/MaiOdLVWgQ4FTe6DLLx6lvCvTeZXS9VIYjk7Z9WWQlsDikTTL
	 Zf/BKDw/4rvtvQg0u3NHta4FMaqJ64L6cixZ7gx6oRt8P5MoK0NeiUVp8Pl03g2c56
	 UzKkfeGeVzg4g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48O2H9WB02228303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 10:17:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 10:17:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 24 Sep
 2024 10:17:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <mweissenbach@ignaz.org>
Subject: [PATCH] wifi: rtw89: pci: early chips only enable 36-bit DMA on specific PCI hosts
Date: Tue, 24 Sep 2024 10:16:33 +0800
Message-ID: <20240924021633.19861-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

VGhlIGVhcmx5IGNoaXBzIGluY2x1ZGluZyBSVEw4ODUyQSwgUlRMODg1MUIsIFJUTDg4NTJCIGFu
ZCBSVEw4ODUyQlQgaGF2ZQppbnRlcm9wZXJhYmlsaXR5IHByb2JsZW1zIG9mIDM2LWJpdCBETUEg
d2l0aCBzb21lIFBDSSBob3N0cy4gUm9sbGJhY2sKdG8gMzItYml0IERNQSBieSBkZWZhdWx0LCBh
bmQgb25seSBlbmFibGUgMzYtYml0IERNQSBmb3IgdGVzdGVkIHBsYXRmb3Jtcy4KClNpbmNlIGFs
bCBJbnRlbCBwbGF0Zm9ybXMgd2UgaGF2ZSBjYW4gd29yayBjb3JyZWN0bHksIGFkZCB0aGUgdmVu
ZG9yIElEIHRvCndoaXRlIGxpc3QuIE90aGVyd2lzZSwgbGlzdCB2ZW5kb3IvZGV2aWNlIElEIG9m
IGJyaWRnZSB3ZSBoYXZlIHRlc3RlZC4KCkZpeGVzOiAxZmQ0YjNmZTUyZWYgKCJ3aWZpOiBydHc4
OTogcGNpOiBzdXBwb3J0IDM2LWJpdCBQQ0kgRE1BIGFkZHJlc3MiKQpSZXBvcnRlZC1ieTogTWFy
Y2VsIFdlacOfZW5iYWNoIDxtd2Vpc3NlbmJhY2hAaWduYXoub3JnPgpDbG9zZXM6IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjQwOTE4MDczMjM3LkhvcmRlLlZMdWVo
MF9LYWlEdy05YXNFRWNkTTg0QGlnbmF6Lm9yZy9ULyNtMDdjNTY5NGRmMWFjYjE3M2E0MmUxYTBi
YWI3YWMyMmJkMjMxYTJiOApTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFs
dGVrLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5jIHwg
NDggKysrKysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg5L3BjaS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9w
Y2kuYwppbmRleCAwMmFmZWIzYWNjZTQuLjVhZWY3ZmEzNzg3OCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYworKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5jCkBAIC0zMDI2LDI0ICszMDI2LDU0IEBAIHN0YXRpYyB2
b2lkIHJ0dzg5X3BjaV9kZWNsYWltX2RldmljZShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsCiAJ
cGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOwogfQogCi1zdGF0aWMgdm9pZCBydHc4OV9wY2lfY2Zn
X2RhYyhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpCitzdGF0aWMgYm9vbCBydHc4OV9wY2lfY2hp
cF9pc19tYW51YWxfZGFjKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldikKIHsKLQlzdHJ1Y3QgcnR3
ODlfcGNpICpydHdwY2kgPSAoc3RydWN0IHJ0dzg5X3BjaSAqKXJ0d2Rldi0+cHJpdjsKIAljb25z
dCBzdHJ1Y3QgcnR3ODlfY2hpcF9pbmZvICpjaGlwID0gcnR3ZGV2LT5jaGlwOwogCi0JaWYgKCFy
dHdwY2ktPmVuYWJsZV9kYWMpCi0JCXJldHVybjsKLQogCXN3aXRjaCAoY2hpcC0+Y2hpcF9pZCkg
ewogCWNhc2UgUlRMODg1MkE6CiAJY2FzZSBSVEw4ODUyQjoKIAljYXNlIFJUTDg4NTFCOgogCWNh
c2UgUlRMODg1MkJUOgotCQlicmVhazsKKwkJcmV0dXJuIHRydWU7CiAJZGVmYXVsdDoKLQkJcmV0
dXJuOworCQlyZXR1cm4gZmFsc2U7CisJfQorfQorCitzdGF0aWMgYm9vbCBydHc4OV9wY2lfaXNf
ZGFjX2NvbXBhdGlibGVfYnJpZGdlKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldikKK3sKKwlzdHJ1
Y3QgcnR3ODlfcGNpICpydHdwY2kgPSAoc3RydWN0IHJ0dzg5X3BjaSAqKXJ0d2Rldi0+cHJpdjsK
KwlzdHJ1Y3QgcGNpX2RldiAqYnJpZGdlID0gcGNpX3Vwc3RyZWFtX2JyaWRnZShydHdwY2ktPnBk
ZXYpOworCisJaWYgKCFydHc4OV9wY2lfY2hpcF9pc19tYW51YWxfZGFjKHJ0d2RldikpCisJCXJl
dHVybiB0cnVlOworCisJaWYgKCFicmlkZ2UpCisJCXJldHVybiBmYWxzZTsKKworCXN3aXRjaCAo
YnJpZGdlLT52ZW5kb3IpIHsKKwljYXNlIFBDSV9WRU5ET1JfSURfSU5URUw6CisJCXJldHVybiB0
cnVlOworCWNhc2UgUENJX1ZFTkRPUl9JRF9BU01FRElBOgorCQlpZiAoYnJpZGdlLT5kZXZpY2Ug
PT0gMHgyODA2KQorCQkJcmV0dXJuIHRydWU7CisJCWJyZWFrOwogCX0KIAorCXJldHVybiBmYWxz
ZTsKK30KKworc3RhdGljIHZvaWQgcnR3ODlfcGNpX2NmZ19kYWMoc3RydWN0IHJ0dzg5X2RldiAq
cnR3ZGV2KQoreworCXN0cnVjdCBydHc4OV9wY2kgKnJ0d3BjaSA9IChzdHJ1Y3QgcnR3ODlfcGNp
ICopcnR3ZGV2LT5wcml2OworCisJaWYgKCFydHdwY2ktPmVuYWJsZV9kYWMpCisJCXJldHVybjsK
KworCWlmICghcnR3ODlfcGNpX2NoaXBfaXNfbWFudWFsX2RhYyhydHdkZXYpKQorCQlyZXR1cm47
CisKIAlydHc4OV9wY2lfY29uZmlnX2J5dGVfc2V0KHJ0d2RldiwgUlRXODlfUENJRV9MMV9DVFJM
LCBSVFc4OV9QQ0lFX0JJVF9FTl82NEJJVFMpOwogfQogCkBAIC0zMDYxLDYgKzMwOTEsOSBAQCBz
dGF0aWMgaW50IHJ0dzg5X3BjaV9zZXR1cF9tYXBwaW5nKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rl
diwKIAkJZ290byBlcnI7CiAJfQogCisJaWYgKCFydHc4OV9wY2lfaXNfZGFjX2NvbXBhdGlibGVf
YnJpZGdlKHJ0d2RldikpCisJCWdvdG8gbm9fZGFjOworCiAJcmV0ID0gZG1hX3NldF9tYXNrX2Fu
ZF9jb2hlcmVudCgmcGRldi0+ZGV2LCBETUFfQklUX01BU0soMzYpKTsKIAlpZiAoIXJldCkgewog
CQlydHdwY2ktPmVuYWJsZV9kYWMgPSB0cnVlOwpAQCAtMzA3Myw2ICszMTA2LDcgQEAgc3RhdGlj
IGludCBydHc4OV9wY2lfc2V0dXBfbWFwcGluZyhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsCiAJ
CQlnb3RvIGVycl9yZWxlYXNlX3JlZ2lvbnM7CiAJCX0KIAl9Citub19kYWM6CiAKIAlyZXNvdXJj
ZV9sZW4gPSBwY2lfcmVzb3VyY2VfbGVuKHBkZXYsIGJhcl9pZCk7CiAJcnR3cGNpLT5tbWFwID0g
cGNpX2lvbWFwKHBkZXYsIGJhcl9pZCwgcmVzb3VyY2VfbGVuKTsKLS0gCjIuMjUuMQoK

