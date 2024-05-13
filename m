Return-Path: <linux-wireless+bounces-7599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB28C4351
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 16:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9301F21990
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F023EEC7;
	Mon, 13 May 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Sq//C1p7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383DEC0
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610924; cv=none; b=gZQkcXVnS45cAz2iTwM+tl9VvyySAd4UpG9ju9hGBJQj7giZ7dX86Qf5C/C0+LwPk9TZfGqBLAc7oysGq+QGcjHKMMIUTmXqben2BfddIXWABnFqRiZHUia+gi8MhhJWApzzEP6qxY18btgvI1xTyHiSOupVUY6wKtLUh3sz+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610924; c=relaxed/simple;
	bh=PFnpTfOL55B98whOBYqeX5GtqS8lO3C48yZIUQx7zyc=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=iYjqQ28u570TBWPK87vTXjdErndYYAfQUOXt4XbJG3DaEMQCf7mRQfXyqiPmaNau7yEfPzFkaiRtnGRjQqyUJccgwEJtSphkALUi5UZ7AqOK+L7h94x8nx8xka2qgZwbc5DwSto/7rPQf90N9Q2+Ny4qRF7b8FFx5KBu3yAq+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Sq//C1p7 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=9nzg/fErxEjKWjyhShJtIW1S2P310lBM8cdNG0yqw2E=; b=S
	q//C1p7vO9sEZTIzIOaq5C79zEs67w1lOgXscsJi2RfqBaGaAGTChO1TTrjDwk0i
	bWm1rtp0gHw2qnFB9fQo4WdclAZpvefL0GX30KgT3oVok01B8IDg+Hc4S0J98bqZ
	0ZVOpEWhGclYEweVc9mJIgCJy40l3qa3zUAw7ry9UY=
Received: from congei42$163.com ( [159.226.94.118] ) by
 ajax-webmail-wmsvr-40-139 (Coremail) ; Mon, 13 May 2024 22:34:45 +0800
 (CST)
Date: Mon, 13 May 2024 22:34:45 +0800 (CST)
From: sicong <congei42@163.com>
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1] wifi: mt76: mt7615: fix null pointer dereference bug
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2aB/qav0Aj4yOdYOkfm0YUj+44Wsa4uvgk2YJeOpt4jBHo2yEbXHxAJUH3z96DCxCKmxuUSSZ39+txcKNgZYAKsjYvNC++oOzKkizu8n3qqQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6206228d.bdee.18f72609cf4.Coremail.congei42@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f8MFJUJmWPQkAA--.696W
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/1tbizQfd8mV4HLKD6AAKs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

RnVuY3Rpb24gbXQ3NjE1X2NvcmVkdW1wX3dvcmsgd2lsbCBjYWxsIHZ6YWxsb2MgdG8gYWxsb2Nh
dGUgYSBsYXJnZSBhbW91bnQKb2YgbWVtb3J5IHNwYWNlLCB0aGUgc2l6ZSBvZiB3aGljaCBpcyAx
MzAwS0IuIFRoZXJlIHNob3VsZCBiZSBhIG51bGwKcG9pbnRlciBjaGVjayBhZnRlciB2emFsbG9j
LiBPdGhlcndpc2UsIHdoZW4gdGhlIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWxzCmFuZCByZXR1cm5z
IE5VTEwsIHRoZSBmdW5jdGlvbiB3aWxsIGNhdXNlIGtlcm5lbCBjcmFzaC4KCkZpeGVzOiBkZTc5
MTA5ODQ1OWQgKCJ3aWZpOiBtdDc2OiBtdDc2MTU6IGZpeCBudWxsIHBvaW50ZXIgZGVyZWZlcmVu
Y2UgYnVnIikKU2lnbmVkLW9mZi1ieTogU2ljb25nIEh1YW5nIDxjb25nZWk0MkAxNjMuY29tPgot
LS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21hYy5jIHwgMyAr
KysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWMuYyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21hYy5jCmluZGV4IDdiYTc4OTgzNGU4ZC4uMDRl
YjUyOTA0NTIwIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzYxNS9tYWMuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzYxNS9tYWMuYwpAQCAtMjM0MSw2ICsyMzQxLDkgQEAgdm9pZCBtdDc2MTVfY29yZWR1bXBfd29y
ayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJfQogCiAJZHVtcCA9IHZ6YWxsb2MoTVQ3Nl9D
T05OQUNfQ09SRURVTVBfU1opOworCWlmKCFkdW1wKQorCQlyZXR1cm47CisKIAlkYXRhID0gZHVt
cDsKIAogCXdoaWxlICh0cnVlKSB7Ci0tIAoyLjM0LjE=

