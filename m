Return-Path: <linux-wireless+bounces-20399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D454DA62536
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 04:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC8842101D
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 03:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571F186E2F;
	Sat, 15 Mar 2025 03:13:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC176178CF8;
	Sat, 15 Mar 2025 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008389; cv=none; b=bWzfPMIgVp/Xw6dHxZ7RZcctFcrb91+ZEH8LuVFBXJzhMr622lBAihjAGX9CoklZzTv5DQuREPn6krG/kaj/u04MJOYBG/1poChusr6Ednk4rq2drz0yet4cj2C7+GUXUxxVnmoUTgjvdIIBwQVlm67tS6obHW+i4SX6D28LvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008389; c=relaxed/simple;
	bh=clmIaqAeSifdCcY5HnUSdpYLwnaZiIp7MkwL/1ZH18Q=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=pY7kVTKrThJdmmTptxh4eZsktT+7Vefd14OeWuEGWh0b1MKhU+mCg9RQp2Qntxc03xpBgzfp6eg/1TKNREfA1iTFP48q6nDy+BrMqJeVukB1tOlEGZ3ffLTT7WwSYosARskO9IL4UJtoTFj6LL2yWK2SVoR7+BCIqdidqRSXsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZF5s94y7Qz8QrkZ;
	Sat, 15 Mar 2025 11:13:01 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 52F3CrZe043981;
	Sat, 15 Mar 2025 11:12:53 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 11:12:54 +0800 (CST)
Date: Sat, 15 Mar 2025 11:12:54 +0800 (CST)
X-Zmail-TransId: 2afc67d4f036ffffffff8b0-b175a
X-Mailer: Zmail v1.0
Message-ID: <20250315111254625RMIKeUh51j1Xk9CWuu2LT@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <linux-kernel@vger.kernel.org>
Cc: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtYWM4MDIxMTogbWluc3RyZWxfaHQ6IFJlcGxhY2UgbmVzdGVkIG1pbigpIHdpdGggc2luZ2xlCgogbWluMygp?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 52F3CrZe043981
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D4F03D.003/4ZF5s94y7Qz8QrkZ



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogRmVuZ1dlaSA8ZmVuZy53ZWk4QHp0ZS5jb20uY24+DQoNClVzZSBtaW4zKCkgbWFjcm8g
aW5zdGVhZCBvZiBuZXN0aW5nIG1pbigpIHRvIHNpbXBsaWZ5IHRoZSByZXR1cm4NCnN0YXRlbWVu
dC4NCg0KU2lnbmVkLW9mZi1ieTogRmVuZ1dlaSA8ZmVuZy53ZWk4QHp0ZS5jb20uY24+DQotLS0N
CiBuZXQvbWFjODAyMTEvcmM4MDIxMV9taW5zdHJlbF9odC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L21h
YzgwMjExL3JjODAyMTFfbWluc3RyZWxfaHQuYyBiL25ldC9tYWM4MDIxMS9yYzgwMjExX21pbnN0
cmVsX2h0LmMNCmluZGV4IDA4ZjNmNTMwZjk4NC4uMzFhM2I2ZTRjNThkIDEwMDY0NA0KLS0tIGEv
bmV0L21hYzgwMjExL3JjODAyMTFfbWluc3RyZWxfaHQuYw0KKysrIGIvbmV0L21hYzgwMjExL3Jj
ODAyMTFfbWluc3RyZWxfaHQuYw0KQEAgLTEwMTAsNyArMTAxMCw3IEBAIG1pbnN0cmVsX2h0X3Jl
ZmlsbF9zYW1wbGVfcmF0ZXMoc3RydWN0IG1pbnN0cmVsX2h0X3N0YSAqbWkpDQogCXUzMiBwcm9i
X2R1ciA9IG1pbnN0cmVsX2dldF9kdXJhdGlvbihtaS0+bWF4X3Byb2JfcmF0ZSk7DQogCXUzMiB0
cF9kdXIgPSBtaW5zdHJlbF9nZXRfZHVyYXRpb24obWktPm1heF90cF9yYXRlWzBdKTsNCiAJdTMy
IHRwMl9kdXIgPSBtaW5zdHJlbF9nZXRfZHVyYXRpb24obWktPm1heF90cF9yYXRlWzFdKTsNCi0J
dTMyIGZhc3RfcmF0ZV9kdXIgPSBtaW4odHBfZHVyLCB0cDJfZHVyLCBwcm9iX2R1cik7DQorCXUz
MiBmYXN0X3JhdGVfZHVyID0gbWluMyh0cF9kdXIsIHRwMl9kdXIsIHByb2JfZHVyKTsNCiAJdTMy
IHNsb3dfcmF0ZV9kdXIgPSBtYXgobWF4KHRwX2R1ciwgdHAyX2R1ciksIHByb2JfZHVyKTsNCiAJ
dTE2ICpyYXRlczsNCiAJaW50IGksIGo7DQotLSANCjIuMjUuMQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkZyb206IEZlbmdXZWkgJmx0O2Zlbmcud2VpOEB6
dGUuY29tLmNuJmd0Ozxicj48L3A+PHA+PGJyPjwvcD48cD5Vc2UgbWluMygpIG1hY3JvIGluc3Rl
YWQgb2YgbmVzdGluZyBtaW4oKSB0byBzaW1wbGlmeSB0aGUgcmV0dXJuPC9wPjxwPnN0YXRlbWVu
dC48L3A+PHA+PGJyPjwvcD48cD5TaWduZWQtb2ZmLWJ5OiBGZW5nV2VpICZsdDtmZW5nLndlaThA
enRlLmNvbS5jbiZndDs8L3A+PHA+LS0tPC9wPjxwPiZuYnNwO25ldC9tYWM4MDIxMS9yYzgwMjEx
X21pbnN0cmVsX2h0LmMgfCAyICstPC9wPjxwPiZuYnNwOzEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKTwvcD48cD48YnI+PC9wPjxwPmRpZmYgLS1naXQgYS9uZXQv
bWFjODAyMTEvcmM4MDIxMV9taW5zdHJlbF9odC5jIGIvbmV0L21hYzgwMjExL3JjODAyMTFfbWlu
c3RyZWxfaHQuYzwvcD48cD5pbmRleCAwOGYzZjUzMGY5ODQuLjMxYTNiNmU0YzU4ZCAxMDA2NDQ8
L3A+PHA+LS0tIGEvbmV0L21hYzgwMjExL3JjODAyMTFfbWluc3RyZWxfaHQuYzwvcD48cD4rKysg
Yi9uZXQvbWFjODAyMTEvcmM4MDIxMV9taW5zdHJlbF9odC5jPC9wPjxwPkBAIC0xMDEwLDcgKzEw
MTAsNyBAQCBtaW5zdHJlbF9odF9yZWZpbGxfc2FtcGxlX3JhdGVzKHN0cnVjdCBtaW5zdHJlbF9o
dF9zdGEgKm1pKTwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnUzMiBwcm9iX2R1ciA9IG1pbnN0cmVsX2dldF9kdXJhdGlvbihtaS0mZ3Q7bWF4X3Byb2Jf
cmF0ZSk7PC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
dTMyIHRwX2R1ciA9IG1pbnN0cmVsX2dldF9kdXJhdGlvbihtaS0mZ3Q7bWF4X3RwX3JhdGVbMF0p
OzwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnUzMiB0
cDJfZHVyID0gbWluc3RyZWxfZ2V0X2R1cmF0aW9uKG1pLSZndDttYXhfdHBfcmF0ZVsxXSk7PC9w
PjxwPi08c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnUzMiBmYXN0X3JhdGVf
ZHVyID0gbWluKHRwX2R1ciwgdHAyX2R1ciwgcHJvYl9kdXIpOzwvcD48cD4rPHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj51MzIgZmFzdF9yYXRlX2R1ciA9IG1pbjModHBfZHVy
LCB0cDJfZHVyLCBwcm9iX2R1cik7PC9wPjxwPiZuYnNwOzxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+dTMyIHNsb3dfcmF0ZV9kdXIgPSBtYXgobWF4KHRwX2R1ciwgdHAyX2R1
ciksIHByb2JfZHVyKTs8L3A+PHA+Jm5ic3A7PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj51MTYgKnJhdGVzOzwvcD48cD4mbmJzcDs8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPmludCBpLCBqOzwvcD48cD4tLSZuYnNwOzwvcD48cD4yLjI1LjE8L3A+PHAg
c3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQg
WWFIZWk7Ij48YnI+PC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrlvq7o
va/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXplOjE0
cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+PHAg
c3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3NvZnQg
WWFIZWk7Ij48YnI+PC9wPjwvZGl2Pg==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


