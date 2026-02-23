Return-Path: <linux-wireless+bounces-32089-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a5MbOiDYm2nj8AMAu9opvQ
	(envelope-from <linux-wireless+bounces-32089-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 05:31:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9B4171C59
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 05:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D52B3019535
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 04:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F971E49F;
	Mon, 23 Feb 2026 04:31:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B417BA2;
	Mon, 23 Feb 2026 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771821084; cv=none; b=ADdC6qYy9sWzCx+LbVIbZXJhGTMTpmLRUW/W5naZLaNvHuUJx1F2M1GRqTbrrCz9mOp2kYFpQbPpNDpqrhE7EBx24//TD1i2J5cmXphzDO2oZbFGzRZELgpCFXbu+h65y67ta7Bi/94Npoy9gc7+Vf8gM9UaZIBKktfED3ZKJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771821084; c=relaxed/simple;
	bh=u83DTudh+hY3T5UHayBdexfPogjXvuYCfOHs/jwMaqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=OAElSfiMAhIaEFQHNRekxf/Vq65bm4HaF/GZu6QY6uq5GUdfRR8E9Jozm70MxnJrXbYYIgyXqCkO8rbh11lnBQ9Wjr9+c4glArVYHDbKtuDD6CnYP4br9Es2aMN/1J3CgEbD1WYWeSwf2RPUusebBvRTnN6/kkltKqhBhq+uHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.19.25])
	by mtasvr (Coremail) with SMTP id _____wCnL9QS2Jtp5lzQAA--.12267S3;
	Mon, 23 Feb 2026 12:31:15 +0800 (CST)
Received: from duoming$zju.edu.cn ( [218.12.19.25] ) by
 ajax-webmail-mail-app2 (Coremail) ; Mon, 23 Feb 2026 12:31:12 +0800
 (GMT+08:00)
Date: Mon, 23 Feb 2026 12:31:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Ping-Ke Shih" <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless] rtlwifi: rtl_pci: Fix possible use-after-free
 caused by unfinished tasklet
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <153117a9fd5b464baa77b5ef48daaabc@realtek.com>
References: <20260223031415.39221-1-duoming@zju.edu.cn>
 <153117a9fd5b464baa77b5ef48daaabc@realtek.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2c9f099b.744b3.19c88c3ffcf.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zC_KCgBXJDYR2JtpczzzBQ--.48647W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwALAWmbXAgC6wAAsG
X-CM-DELIVERINFO: =?B?mNe3VQXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR12ES3fGLXKU3xFI5V2mAEBjn/gm6wXMTYEHo80bX4e1Uw+s0wvY4BgJWzMwtNA/LaEbl
	CvRbrh48rAW5VPAJeWcF9VyqPdFYAyxBdMldrUh3AkLPUZCPaPDGTZRCsnzwOA==
X-Coremail-Antispam: 1Uk129KBj93XoWxJryxWF1xury3Jr4kCr4Utrc_yoW8Gw1DpF
	WYgw43tFWkAr1093Z8Jr10qFyUtr4Sqr1rGa1rKFyIgwsxXF1Sqr47Kr4j9ayUJr48tFWq
	yFy8X3s5Gw1kCFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFcxC0VAYjxAxZF0Ew4CEw7xC0wACY4xI67k04243AVC20s07M4kE
	6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_
	JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr1l6VACY4xI67k04243AbIYCTnIWI
	evJa73UjIFyTuYvjxUcVWLUUUUU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32089-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[zju.edu.cn];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[duoming@zju.edu.cn,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zju.edu.cn:mid,zju.edu.cn:email]
X-Rspamd-Queue-Id: 0C9B4171C59
X-Rspamd-Action: no action

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOgo+ID4gVGhlIGlycV9wcmVw
YXJlX2Jjbl90YXNrbGV0IGlzIGluaXRpYWxpemVkIGluIHJ0bF9wY2lfaW5pdCgpIGFuZAo+ID4g
c2NoZWR1bGVkIHdoZW4gUlRMX0lNUl9CQ05JTlQgaW50ZXJydXB0IGlzIHRyaWdnZXJlZCBieSBo
YXJkd2FyZS4KPiA+IEJ1dCBpdCBpcyBuZXZlciBraWxsZWQgaW4gcnRsX3BjaV9kZWluaXQoKS4g
V2hlbiB0aGUgcnRsd2lmaSBjYXJkCj4gPiBwcm9iZSBmYWlscyBvciBpcyBiZWluZyBkZXRhY2hl
ZCwgdGhlIGllZWU4MDIxMV9odyBpcyBkZWFsbG9jYXRlZC4KPiA+IEhvd2V2ZXIsIGlycV9wcmVw
YXJlX2Jjbl90YXNrbGV0IG1heSBzdGlsbCBiZSBydW5uaW5nIG9yIHBlbmRpbmcsCj4gPiBsZWFk
aW5nIHRvIHVzZS1hZnRlci1mcmVlIHdoZW4gdGhlIGZyZWVkIGllZWU4MDIxMV9odyBpcyBhY2Nl
c3NlZAo+ID4gaW4gX3J0bF9wY2lfcHJlcGFyZV9iY25fdGFza2xldCgpLgo+ID4gCj4gPiBTaW1p
bGFyIHRvIGlycV90YXNrbGV0LCBhZGQgdGFza2xldF9raWxsKCkgaW4gcnRsX3BjaV9kZWluaXQo
KSB0bwo+ID4gZW5zdXJlIHRoYXQgaXJxX3ByZXBhcmVfYmNuX3Rhc2tsZXQgaXMgcHJvcGVybHkg
dGVybWluYXRlZCBiZWZvcmUKPiA+IHRoZSBpZWVlODAyMTFfaHcgaXMgcmVsZWFzZWQuCj4gPiAK
PiA+IFRoZSBpc3N1ZSB3YXMgaWRlbnRpZmllZCB0aHJvdWdoIHN0YXRpYyBhbmFseXNpcy4KPiA+
IAo+ID4gRml4ZXM6IDBjODE3MzM4NWU1NCAoInJ0bDgxOTJjZTogQWRkIG5ldyBkcml2ZXIiKQo+
ID4gU2lnbmVkLW9mZi1ieTogRHVvbWluZyBaaG91IDxkdW9taW5nQHpqdS5lZHUuY24+Cj4gCj4g
VGhlIHRyZWUgc2VsZWN0aW9uIHNob3VsZCBiZSAicnR3LW5leHQiIChtYXkgYmUgInJ0dyIsIGJ1
dCBJIGRvbid0IHRoaW5rCj4gdGhpcyBwYXRjaCBpcyB1cmdlbnQpLCBhbmQgc3ViamVjdCBwcmVm
aXggc2hvdWxkIGJlICJ3aWZpOiBydGx3aWZpOiAuLi4iLgo+IE1vcmUsIEknZCBwb2ludCBvdXQg
dGhlIG5hbWUgb2YgdGFza2xldCBpbiBzdWJqZWN0LiBUaGVuLAo+ICJbUEFUQ0ggcnR3LW5leHRd
IHdpZmk6IHJ0bHdpZmk6IHBjaTogZml4IHBvc3NpYmxlIHVzZS1hZnRlci1mcmVlIGNhdXNlZCBi
eSB1bmZpbmlzaGVkIGlycV9wcmVwYXJlX2Jjbl90YXNrbGV0IgoKVGhhbmsgeW91IGZvciB5b3Vy
IHRpbWUgYW5kIHJlcGx5ISBJIHdpbGwgc2VsZWN0IHRoZSAicnR3LW5leHQiIHRyZWUsCmFkanVz
dCB0aGUgc3ViamVjdCBwcmVmaXggYW5kIHNlbmQgYSB2MiBwYXRjaC4KCj4gT3RoZXJ3aXNlLCBs
b29rcyBnb29kIHRvIG1lLgo+IAo+IEFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFs
dGVrLmNvbT4KCkJlc3QgcmVnYXJkcywKRHVvbWluZyBaaG91Cg==


