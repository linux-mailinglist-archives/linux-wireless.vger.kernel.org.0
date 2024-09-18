Return-Path: <linux-wireless+bounces-12938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBED97B9A9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 10:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AC91F25755
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA5017D373;
	Wed, 18 Sep 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MXrJIHO6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6B180A6A
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649794; cv=none; b=dqGft+iSctVtpUTWoGWpU1G+NyKPuzFTSZMPBMFFL4wYkwC/fczWbM6R5ibyEyznHZUBZWDViWjVBW7lpITDsrQWJSmFdx3ML15FEv9PJdY3JFgUpgjkzDpyT9MAfVBbO+FaHKCC/07wTAU4bY2F3pCDrkfdwTMT/IM2TKanYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649794; c=relaxed/simple;
	bh=17ERSlRppoc382F8PgDa0/gUcfR+x2UiP6ZzLbSNjMc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X0oF7wwjr+0Dw8T4A0uMDGa6TdZtgJuzuxxGaZTYKIlt4uVvj2v4cAFCg6GcwZBtoneVbit38D9hO+Es/yNM4qJe3Bpx5Qe1T1yZ8uDHzlLFV2fUDHegw9RIHGQlFnBbHm0DLO4NOFD7af8aofPCFZE15vLIOVZ+cUJugbhL70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MXrJIHO6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48I8uMq551865612, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726649782; bh=17ERSlRppoc382F8PgDa0/gUcfR+x2UiP6ZzLbSNjMc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	b=MXrJIHO66HJkvB6rzCpFMD+yB4KdyuG7dvWN/p7ifoDpRtEvo63axd1z2LvSqGICR
	 KqXoVgjhdcuND7zz7mwRPwxW8u9UbM+U8IZhMSwdJqiF4ybGo8xXLyiL6iukzOqGwA
	 bc+sdLWVyRkm+GrXrHnpFHNWAVGB/I+z350bwFOiMCCGfLhn2U/Ghy9dCZ5KH9o8Dk
	 WAqkBp91CXCMitS5/uz3aocQm/TVRkV8WZ9vv0J5cCRy+QjiZM+3QgTzS4uawTlo9E
	 u7QlFYzEABgjWY9W1cqRaV6ci722A1PkGJhTQIMFLrFmbLKWnMCv7ckYYHCouwE3jY
	 0d3RO7/xSh6cw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48I8uMq551865612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 16:56:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 16:56:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 18 Sep
 2024 16:56:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <mweissenbach@ignaz.org>
Subject: [PATCH] wifi: rtw89: 8852be: add quirk to avoid PCI 36bit DMA for certain platforms
Date: Wed, 18 Sep 2024 16:55:51 +0800
Message-ID: <20240918085551.54611-1-pkshih@realtek.com>
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

UlRMODg1MkJFIGhhcyBQQ0kgMzYtYml0IERNQSBpbnRlcm9wZXJhYmlsaXR5IHByb2JsZW0gb24g
Y2VydGFpbgpwbGF0Zm9ybXMsIHNvIGFkZCBxdWlya3MgdG8gZXhjbHVkZSB0aGlzIGtpbmQgb2Yg
cGxhdGZvcm1zLgoKT3RoZXJ3aXNlLCBmYWlsZWQgdG8gZG93bmxvYWQgZmlybXdhcmUsIGFuZCBX
aUZpIGJlY29tZXMgdW51c2FibGUuCgpSZXBvcnRlZC1ieTogTWFyY2VsIFdlacOfZW5iYWNoIDxt
d2Vpc3NlbmJhY2hAaWduYXoub3JnPgpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXdpcmVsZXNzLzIwMjQwOTE4MDczMjM3LkhvcmRlLlZMdWVoMF9LYWlEdy05YXNFRWNkTTg0
QGlnbmF6Lm9yZy9ULyNtMDdjNTY5NGRmMWFjYjE3M2E0MmUxYTBiYWI3YWMyMmJkMjMxYTJiOApT
aWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4KLS0tCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuaCAgICAgIHwgIDEgKwogZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYyAgICAgICB8ICA0ICsrKysKIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmJlLmMgfCAxNCArKysrKysrKysr
KysrLQogMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb3JlLmggYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuaAppbmRleCA0ZWQ5MDM0ZmRi
NDYuLmQzYjE0MGFjMGFhZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OS9jb3JlLmgKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9j
b3JlLmgKQEAgLTQ3MTAsNiArNDcxMCw3IEBAIGVudW0gcnR3ODlfZmxhZ3MgewogCiBlbnVtIHJ0
dzg5X3F1aXJrcyB7CiAJUlRXODlfUVVJUktfUENJX0JFUiwKKwlSVFc4OV9RVUlSS19QQ0lfTk9f
MzZCSVRfRE1BLAogCiAJTlVNX09GX1JUVzg5X1FVSVJLUywKIH07CmRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5jIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9wY2kuYwppbmRleCAwMmFmZWIzYWNjZTQuLjAzZTNlMTdjOGE2NyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYworKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5jCkBAIC0zMDYxLDYgKzMw
NjEsOSBAQCBzdGF0aWMgaW50IHJ0dzg5X3BjaV9zZXR1cF9tYXBwaW5nKHN0cnVjdCBydHc4OV9k
ZXYgKnJ0d2RldiwKIAkJZ290byBlcnI7CiAJfQogCisJaWYgKHRlc3RfYml0KFJUVzg5X1FVSVJL
X1BDSV9OT18zNkJJVF9ETUEsIHJ0d2Rldi0+cXVpcmtzKSkKKwkJZ290byBub18zNmJpdF9kbWE7
CisKIAlyZXQgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCZwZGV2LT5kZXYsIERNQV9CSVRf
TUFTSygzNikpOwogCWlmICghcmV0KSB7CiAJCXJ0d3BjaS0+ZW5hYmxlX2RhYyA9IHRydWU7CkBA
IC0zMDc0LDYgKzMwNzcsNyBAQCBzdGF0aWMgaW50IHJ0dzg5X3BjaV9zZXR1cF9tYXBwaW5nKHN0
cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwKIAkJfQogCX0KIAorbm9fMzZiaXRfZG1hOgogCXJlc291
cmNlX2xlbiA9IHBjaV9yZXNvdXJjZV9sZW4ocGRldiwgYmFyX2lkKTsKIAlydHdwY2ktPm1tYXAg
PSBwY2lfaW9tYXAocGRldiwgYmFyX2lkLCByZXNvdXJjZV9sZW4pOwogCWlmICghcnR3cGNpLT5t
bWFwKSB7CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0
dzg4NTJiZS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9ydHc4ODUyYmUu
YwppbmRleCBkOGY5ZDkyY2EwZmIuLjMzYTZhYWNhNWE0YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9ydHc4ODUyYmUuYworKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTJiZS5jCkBAIC02Miw5ICs2MiwyMSBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHJ0dzg5X3BjaV9pbmZvIHJ0dzg4NTJiX3BjaV9pbmZvID0gewogCS5y
ZWNvZ25pemVfaW50cnMJPSBydHc4OV9wY2lfcmVjb2duaXplX2ludHJzLAogfTsKIAorc3RhdGlj
IGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIHJ0dzg4NTJiX3BjaV9xdWlya3NbXSA9IHsKKwl7
CisJCS5pZGVudCA9ICJBU1VTVGVLIENPTVBVVEVSIElOQy4gVFVGIEdBTUlORyBCNTUwTS1QTFVT
IiwKKwkJLm1hdGNoZXMgPSB7CisJCQlETUlfTUFUQ0goRE1JX0JPQVJEX1ZFTkRPUiwgIkFTVVNU
ZUsgQ09NUFVURVIgSU5DLiIpLAorCQkJRE1JX01BVENIKERNSV9CT0FSRF9OQU1FLCAiVFVGIEdB
TUlORyBCNTUwTS1QTFVTIiksCisJCX0sCisJCS5kcml2ZXJfZGF0YSA9ICh2b2lkICopUlRXODlf
UVVJUktfUENJX05PXzM2QklUX0RNQSwKKwl9LAorCXt9LAorfTsKKwogc3RhdGljIGNvbnN0IHN0
cnVjdCBydHc4OV9kcml2ZXJfaW5mbyBydHc4OV84ODUyYmVfaW5mbyA9IHsKIAkuY2hpcCA9ICZy
dHc4ODUyYl9jaGlwX2luZm8sCi0JLnF1aXJrcyA9IE5VTEwsCisJLnF1aXJrcyA9IHJ0dzg4NTJi
X3BjaV9xdWlya3MsCiAJLmJ1cyA9IHsKIAkJLnBjaSA9ICZydHc4ODUyYl9wY2lfaW5mbywKIAl9
LAotLSAKMi4yNS4xCgo=

