Return-Path: <linux-wireless+bounces-24441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5063AE6CE2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61357B0AAF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248A2E336E;
	Tue, 24 Jun 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="N6lO9vKH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177826CE3A;
	Tue, 24 Jun 2025 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783836; cv=none; b=m4D9+89GzYiwG0CBPFjHqJGu/oArdIowLBjfZWnadRv9/T6ZYOtEglL1kgUcXfOHyFyPzdH6qi7Ou0Up8OJz8WnxHg2hrirzchNlaW8wdUDmGXZzY8Hmbrqg7zNngsy06O+xAxEjADT1YcDRnQYKT/JQ+PBbAnzenFJL12+aBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783836; c=relaxed/simple;
	bh=jypxy5YrrrwHn5OZnPatbc8/doa480riJ7fn4J04Tf8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ql7ZElTTE1qxonEA8d9E7pU9OZJcl+RoE0TNzFnfVW/Mzvs7H67mPq1CLizGjdjHXzDG+kDmx6vxus7fDKm1FfmlvDVmKv18WNNmzfpO8ISDpRjGj5KsyTExOjaRYSSbGK6OFc6yaLvWQgHqe+xCcrd9I0OhAI2e7uIedgsdWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=N6lO9vKH; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750783831; x=1751388631; i=markus.elfring@web.de;
	bh=lygtFga4Zzar3EOZ2eacheVtpaUZOubLZPWP3hzvSZE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N6lO9vKHkbZfUQA39Xmwgz1E85NPGO73xBrx6d8yKfABeW7zlGpN6zoc3DWZpNnp
	 1cBfIKjzNRrbeD4xe4qfQZZkqdyUPHW/UVCjGcd2G46qYS/tw+GqGt0Q465OgdM+z
	 sGTsswua9kziiVIeQ1UfK8QTWggVdPZthLExS/OpkZ3NJem5a3r/HtxF8Wmm89/Gc
	 yND1QoVmnfcQxOPomubRkv2qNHPdylYLsEnvrMwwwrfgHXKCQVtiRsyQaGdk6FZox
	 R3aA0Mj9SC3t6eFFzv4X/P76aksFKbws2e9XCzLuLVEQMLFZy8f/Nq49EVuan+N0V
	 tnxZRCwe7RbYicY9ug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.200]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCXZh-1ucfJ737H1-001XBS; Tue, 24
 Jun 2025 18:50:30 +0200
Message-ID: <d04019cd-f782-4d81-97ce-3d70946e5c54@web.de>
Date: Tue, 24 Jun 2025 18:50:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Kalle Valo <kvalo@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] wifi: rsi: Use usb_endpoint_type() rather than duplicating
 its implementation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lXqP4SBeKatBUgQxHpIBKFyCDNJqkN5F/V+bZzAkdP9xv2Uj8ol
 r2Nkg9KPvjbMWT+pj3WLQKmmbMLGBljG6/eJ9WrbRvURp7V1kUxjPhTpzWx5tFKUOjSj0fU
 +kDpii0dzT8P7Khb4uGlQz8O8Qt5UBsaqkkbjAtpGC4XiZjq+lcmbDGIMLFXztUlNMaqI1T
 uMHeOO5HtkXPkVk2l+HWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tHnLAntKgus=;Uxld4nniI8GeEOO5MisbefS46Fi
 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
 br4NP/wvGyYU0XGtedpw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Jun 2025 18:42:39 +0200

Reuse existing functionality from usb_endpoint_type() instead of keeping
duplicate source code.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/rsi/rsi_91x_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless=
/rsi/rsi_91x_usb.c
index dccc139cabb2..64994022b33e 100644
=2D-- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -122,8 +122,7 @@ static int rsi_find_bulk_in_and_out_endpoints(struct u=
sb_interface *interface,
=20
 		if (!dev->bulkin_endpoint_addr[bin_found] &&
 		    (endpoint->bEndpointAddress & USB_DIR_IN) &&
-		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
-		    USB_ENDPOINT_XFER_BULK)) {
+		    usb_endpoint_type(endpoint) =3D=3D USB_ENDPOINT_XFER_BULK) {
 			buffer_size =3D endpoint->wMaxPacketSize;
 			dev->bulkin_size[bin_found] =3D buffer_size;
 			dev->bulkin_endpoint_addr[bin_found] =3D
@@ -133,8 +132,7 @@ static int rsi_find_bulk_in_and_out_endpoints(struct u=
sb_interface *interface,
=20
 		if (!dev->bulkout_endpoint_addr[bout_found] &&
 		    !(endpoint->bEndpointAddress & USB_DIR_IN) &&
-		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
-		    USB_ENDPOINT_XFER_BULK)) {
+		    usb_endpoint_type(endpoint) =3D=3D USB_ENDPOINT_XFER_BULK) {
 			buffer_size =3D endpoint->wMaxPacketSize;
 			dev->bulkout_endpoint_addr[bout_found] =3D
 				endpoint->bEndpointAddress;
=2D-=20
2.50.0


