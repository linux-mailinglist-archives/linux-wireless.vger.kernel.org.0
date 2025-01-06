Return-Path: <linux-wireless+bounces-17109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A83EA0272A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 14:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AD83A1FD6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364EB1DDA2D;
	Mon,  6 Jan 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="nvsBjFPN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160C73451;
	Mon,  6 Jan 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736171702; cv=none; b=VkIWSl6W5FCej8tT7MUGO1bB/mL5tRSsK90t36HRy5JQUwWP/RCjlGGT0h9/biB6WP7qhYAviGeV2JG99gWT2C96B1a59fHRk2CHEyyGrH4+U22FzjCa8IMmqjdi4RCC5fN3pxMSZKy3cdI56hF61XfxIOwBaqJjWWNY05aILL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736171702; c=relaxed/simple;
	bh=OfAWVIhquapKWdH0NOhugaf+FOe2nhzQ4nySOzgCuEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAvpxKbAZvjoBBNfSJEZRlVUxtdyzfKIGcf+NtwKOj+pherndEz4HOPGlhAATMkA2VG2DL5jvMelJ3uADJmY6dNq8SFfzzrbocShqQHh+C7hn5lnwsobOSsC34zrU67CvmWOKa4rCl9tP0tgvMSDOj7sMpdxMSnS1fgYi/M/Fm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=nvsBjFPN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736171686; x=1736776486; i=fiona.klute@gmx.de;
	bh=OfAWVIhquapKWdH0NOhugaf+FOe2nhzQ4nySOzgCuEI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nvsBjFPNqEA53WpEcWah5/XtDyl/R49biT64fF/4JVMP//Z4NFvoaSezkC6TczwK
	 b1D9m2kGX8hFcQnMG3IAP2ohK5QfcANkif5NxALNoNNQDakbiJvSGV5gpUAFsGj7J
	 tDIcAD1ma3EdPuxtUVKnApy2/B3tCLs1/0IYs65nISZvHoYDT0L4rM6y7f5ZXYQ+z
	 ArbU88PUJIdA6QF9dfJpaJ9vnGOCsAxk/ctkgWWDVum76wLmqXyB7O1PpHQdTbKfm
	 DrKVw59BBnIPCLbf8PuWA9rCKeX20VWL64QncgXtKY06VOLEayfizil8IZeeLoiG8
	 13Mhu34GKL4MP8cwhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from chiaki.cable.inet.fi ([84.249.220.44]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MgNh1-1txZDG3yNr-00do1P; Mon, 06 Jan 2025 14:54:46 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtw88: sdio: Fix disconnection after beacon loss
Date: Mon,  6 Jan 2025 15:54:34 +0200
Message-ID: <20250106135434.35936-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:p3goXPO60eNJJrumrqiwu6F/r2SRjhFyfsP9SQzHcAf2AMN1Yqm
 hGJ/9VGngs5+gr6rSOm14Ewoez7Duv1PrCvR7n2Q16inkOXJyInYL/VwKppDoDLLTPLuCBA
 ap5J/x2SBE9iuU86biqbVPT61lwg1Z7Hyed9/Z1a82wI5aoUH1ksjLGSzNYRyzs+40wzfeD
 dt7DbUcqP7KW9dl06Ot7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:urP0PKoSD2A=;MjqvAmBXGKfm1IRan1MZLbfaEUG
 4u2eR6+z6BijSvWPrwOOvetjaf+haOFatL2++iZjGBGWdPH+0o75Smq5eECXognyjpJIVzMvw
 6QfBl+ytvQA7O+A0ecWFLYeP+5AQU+ijz5/txyVHdemuDQBdr28MWmhFSUBAroQpjy9lAaLHE
 lq7+VIotmIF0sQUns8sJ8ugwUWvxrtOuw26ItmZUrS34WdhhKBVXzxRdWUtvnvgDbbOphbtCj
 xbETSSCYRbI0q/gHgftLrkSx3Khp3/6gAFKIMPokB9/NW2sjUpoOpgtJZmay+dc0vegJnEYwW
 4mgmU2nQKZEuNoeAgjY/zXMS1FHYkqMpWBKLOLIjWMwsonMbmgy+4Xr6w7QDN3zk4YbKTpEkN
 j5MAIuHEnH8TBph5k+U3LQRVB51+Jys8ZGpjj7mG8zCJrQ6FRtAqyqq/mB+A30a6Kg3cm/oEV
 DG5eJJCQP9qls4n6SIbJZuGXbLGqNAl903DQg0rM1jsVNHBElCCZwWDayBEY48SWTsKk07m8T
 XX+oEV6auZA2mBVou3HuHKoHqfN8UE2rpOSZfC90IGWcwaAMGqoyVdghIwDlzUpcispoqpioL
 nHJ0OXIxiOqD5xv1juRENmPWwkI5KTP8q/sHt3It2z3yWxAhRKXLYHRSaHQHyYDjQRIXmktrI
 ifxyv4OL2JcZ+5OWevwoz+I5nEJHs7E9MTv7qP7SaMoT1yUAhpHbJNfZ5iuR1VSV/ptBu9ALD
 HEEtELmKWCNn8C5rytjpp0noXUOTxoixfZV1i+UVNOeVnieLF3+41oOXbrplBcKlwwrBwVhqO
 SWFpPmP5swhacurnQ+T15bZ5VKp8+ctu1mdgFGjPGBomCIjnLbO+/hPFfnLTFLiK3155RDqVa
 Kj3ydeH4k+4an6r45HeABes84oXdas+M7FO0mu4j7iNOR5p0CGG7wIDVkQDRsFgJStKrvN+dX
 CZlyjYF5zFmohugf3FyYysluG4kmAdGO0qBZ4YmZ4n/9GMZhD1IFKsEjTfcwpgW8Y+P8lP7Ox
 yZ7CqAdETMWb2CFzHL6YgzJ6KXJN0wJ6lc9wBjEoJFthzVDr5jrUkk30xpGsyjTXfLmI1zx51
 DDXPp3rC7iOFagUkbe6KHCC5ucL4rD

VGhpcyBpcyB0aGUgZXF1aXZhbGVudCBvZiAyODgxOGI0ZDg3MWJjOTNjYzRmNWM3YzdkN2M1MjZh
NmEwOTZjMDljCiJ3aWZpOiBydHc4ODogdXNiOiBGaXggZGlzY29ubmVjdGlvbiBhZnRlciBiZWFj
b24gbG9zcyIgZm9yIFNESU8KY2hpcHMuIFRlc3RlZCBvbiBQaW5lcGhvbmUgKFJUTDg3MjNDUyks
IHJhbmRvbSBkaXNjb25uZWN0aW9ucyBiZWNhbWUKcmFyZSwgaW5zdGVhZCBvZiBhIGZyZXF1ZW50
IG51aXNhbmNlLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogRmlv
bmEgS2x1dGUgPGZpb25hLmtsdXRlQGdteC5kZT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg4L3NkaW8uYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3NkaW8u
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jCmluZGV4IDc5OTIz
MGViNWYxLi5lMDI0MDYxYmRiZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9zZGlvLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC9zZGlvLmMKQEAgLTExOTIsNiArMTE5Miw4IEBAIHN0YXRpYyB2b2lkIHJ0d19zZGlvX2luZGlj
YXRlX3R4X3N0YXR1cyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LAogCXN0cnVjdCBpZWVlODAyMTFf
dHhfaW5mbyAqaW5mbyA9IElFRUU4MDIxMV9TS0JfQ0Ioc2tiKTsKIAlzdHJ1Y3QgaWVlZTgwMjEx
X2h3ICpodyA9IHJ0d2Rldi0+aHc7CiAKKwlza2JfcHVsbChza2IsIHJ0d2Rldi0+Y2hpcC0+dHhf
cGt0X2Rlc2Nfc3opOworCiAJLyogZW5xdWV1ZSB0byB3YWl0IGZvciB0eCByZXBvcnQgKi8KIAlp
ZiAoaW5mby0+ZmxhZ3MgJiBJRUVFODAyMTFfVFhfQ1RMX1JFUV9UWF9TVEFUVVMpIHsKIAkJcnR3
X3R4X3JlcG9ydF9lbnF1ZXVlKHJ0d2Rldiwgc2tiLCB0eF9kYXRhLT5zbik7Ci0tIAoyLjQ3LjEK
Cg==

