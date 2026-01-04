Return-Path: <linux-wireless+bounces-30317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7078CF0920
	for <lists+linux-wireless@lfdr.de>; Sun, 04 Jan 2026 04:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2861A300B813
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jan 2026 03:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4821348;
	Sun,  4 Jan 2026 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="CcMWmGzY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF0D1EA7DF;
	Sun,  4 Jan 2026 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767496619; cv=none; b=UbvqfE7DQRZPCgiqe02qCUUV3yKCA9CLFoui4PuAA0A6IQpwBxaqG7uJ09kh+nx22SrnwuHJCeJbmdOK33E8gSgCV/KiZvfzMYG5d1brPlpuckXx9IztPHdZptmV+OGAnozgtC4o81LZ6eYOl7N/jHUkMwOgpWanPlsHYa2ENH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767496619; c=relaxed/simple;
	bh=JG/FTtjuWCQYYqm8p1fkBD8CUXROB+lqgVCAQ0nN+L4=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=JKqm1iwr/FXKPwG4C9IkzJQKI9tmPZS2ClxAZc8ln2AqyS5Sk1J1CNG3kRy6JdRXncfYFePv2aS/VB9bykljb4+l5mJtH0Jn3cGBG/LNqZCGLrvDy8MiVqWJDuJAivIYXBmRXPKjE1xRleH1z8W3CaSHcJLcK9P1qp2UJERdRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=CcMWmGzY reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID;
	bh=yS/xA0XwNPlVsRNQ/EYZQYpEwujlaEZoNJ+hsPCO360=; b=CcMWmGzYTqWB9
	AjtIzNZS3JQEbluTp85vVtMnt/MUk3QIKx+mcLg7RmCOvZDbXvUSGJfOF7ROhiAP
	gUrtMjFFtquIR+/pfHqyP7Ym304nAp9TKBSYo/xdZXdsccRbhZsH8c0vVHroJcRH
	9a01zTQfXL4e0sQiMTZhRq+sVJA9Y0=
Received: from 23009200614$stu.xidian.edu.cn ( [113.200.174.102] ) by
 ajax-webmail-hzbj-edu-front-4.icoremail.net (Coremail) ; Sun, 4 Jan 2026
 11:16:48 +0800 (GMT+08:00)
Date: Sun, 4 Jan 2026 11:16:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?546L5b+X?= <23009200614@stu.xidian.edu.cn>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: [BUG] cfg80211/mac80211: RCU stall in cfg80211_wiphy_work during
 IBSS scan handling
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250410(2f5ccd7f) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <532d062e.9287.19b8701eb6b.Coremail.23009200614@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:BrQMCkBmzeCh21lpddDqAA--.13290W
X-CM-SenderInfo: qstqimqsqqliuu6v33wo0lvxldqovvfxof0/1tbiAQUDCGlZJUsz3
	wACs-
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gd2lyZWxlc3MgbWFpbnRhaW5lcnMsCgpJIGFtIHJlcG9ydGluZyBhbiBSQ1Ugc3RhbGwg
aXNzdWUgZm91bmQgYnkgc3l6a2FsbGVyIG9uIExpbnV4IHY2LjE4LiBUaGUgcHJvYmxlbSBtYW5p
ZmVzdHMgYXMgYW4gUkNVIHByZWVtcHQgc3RhbGwgaW52b2x2aW5nIHRoZSBjZmc4MDIxMV93aXBo
eV93b3JrIHdvcmtxdWV1ZS4gQSB3b3JrZXIgdGhyZWFkIHByb2Nlc3Npbmcgd2lyZWxlc3Mgc2Nh
biAvIElCU1MgbWFuYWdlbWVudCBmcmFtZXMgYmVjb21lcyBzdHVjaywgZXZlbnR1YWxseSB0cmln
Z2VyaW5nIGFuIFJDVSBzdGFsbCB3YXJuaW5nLgoKS2VybmVsOgpMaW51eCA2LjE4LjAgKGJhc2Vk
IG9uIHY2LjE4KQpOb3QgdGFpbnRlZApDT05GSUdfUFJFRU1QVF9GVUxMPXkKVGVzdGVkIHVuZGVy
IFFFTVUgKGk0NDBGWCkKCk9ic2VydmVkIGJlaGF2aW9yOgpSQ1UgcHJlZW1wdCBzdGFsbCBkZXRl
Y3RlZCBjZmc4MDIxMV93aXBoeV93b3JrIGJsb2NrZWQgZm9yIH4xMGsgamlmZmllcwpXb3JrcXVl
dWU6IGV2ZW50c191bmJvdW5kIGNmZzgwMjExX3dpcGh5X3dvcmsKUkNVIHN0YWxsIHJlcG9ydCBl
eGNlcnB0OgpJTkZPOiByY3UgZGV0ZWN0ZWQgc3RhbGwgaW4gY2ZnODAyMTFfd2lwaHlfd29yawpy
Y3U6IHJjdV9wcmVlbXB0IGRldGVjdGVkIHN0YWxscyBvbiBDUFVzL3Rhc2tzCldvcmtxdWV1ZTog
ZXZlbnRzX3VuYm91bmQgY2ZnODAyMTFfd2lwaHlfd29yawpUaGUgYmxvY2tlZCB3b3JrZXIgc2hv
d3MgdGhlIGZvbGxvd2luZyBjYWxsIHRyYWNlOgpjZmc4MDIxMV93aXBoeV93b3JrCmNmZzgwMjEx
X2luZm9ybV9ic3NfZnJhbWVfZGF0YQpjZmc4MDIxMV9pbmZvcm1fYnNzX2RhdGEKaWVlZTgwMjEx
X3J4X2Jzc19pbmZvCmllZWU4MDIxMV9pYnNzX3J4X3F1ZXVlZF9tZ210CmllZWU4MDIxMV9pZmFj
ZV93b3JrCnByb2Nlc3Nfb25lX3dvcmsKd29ya2VyX3RocmVhZAoKQXQgdGhlIHNhbWUgdGltZSwg
YW5vdGhlciBDUFUgaXMgc3Bpbm5pbmcgaW4gYW4gSVJRIGNvbnRleHQgaW5zaWRlIGRybS92a21z
IHZibGFuayBoYW5kbGluZywgaG9sZGluZyBhIHJhdyBzcGlubG9jazoKbmF0aXZlX3F1ZXVlZF9z
cGluX2xvY2tfc2xvd3BhdGgKZHJtX2hhbmRsZV92YmxhbmsKdmttc192Ymxhbmtfc2ltdWxhdGUK
aHJ0aW1lcl9pbnRlcnJ1cHQKClRoaXMgc3VnZ2VzdHMgYSBwb3NzaWJsZSBsb2NrIGNvbnRlbnRp
b24gb3IgdW5ib3VuZGVkIHByb2Nlc3NpbmcgcGF0aCBpbiB0aGUgY2ZnODAyMTEvbWFjODAyMTEg
c2NhbiBvciBJQlNTIG1hbmFnZW1lbnQgZnJhbWUgaGFuZGxpbmcsIHdoaWNoIHByZXZlbnRzIHRo
ZSB3b3JrZXIgZnJvbSByZWFjaGluZyBhbiBSQ1UgcXVpZXNjZW50IHN0YXRlLiBBIGZ1bGwga2Vy
bmVsIGxvZyBpcyBhdmFpbGFibGUgdXBvbiByZXF1ZXN0LgoKUGxlYXNlIGxldCBtZSBrbm93IGlm
IHlvdSB3b3VsZCBsaWtlIG1lIHRvIHByb3ZpZGUgYWRkaXRpb25hbCBsb2dzLCB0ZXN0IGEgcGF0
Y2gsIG9yIG5hcnJvdyB0aGlzIGRvd24gZnVydGhlci4KVGhhbmsgeW91IGZvciB5b3VyIHRpbWUu
CgpCZXN0IHJlZ2FyZHMsClpoaSBXYW5n

