Return-Path: <linux-wireless+bounces-24458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2146AE7791
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 08:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950721BC511C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 06:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D11F4611;
	Wed, 25 Jun 2025 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="p4mVLhWK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF971F37D4;
	Wed, 25 Jun 2025 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750834523; cv=none; b=sAvbxYuttsU6ScmR39klzE+9vK+aZdPCjDWfjDrKAKfGViHveWlMVLUrLry1dpx0jfG1lDh2aUFKjkUV9vtQewEeeaa0PKb4oXzxnDTzMQgxjQCSCwrMKutmXyyvHg1krkmIhm08Mm+FXMQDlo4BQmIzup5xrEjRKQo+2UAROgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750834523; c=relaxed/simple;
	bh=rrKZ1irw5yAVm4i9aB7BKAfnsmBuXw9it0NTlnvpSjQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rv/PQcpJGShvpGQ/Cl/axJP5C1T+rRte8EA3goq8hSWNzuj2d/RIrRIF+3ZWMQuXumw8giJkYFJnTDJb7/AH6u9dkwYUZiBxsPq0u2tL4P69Zd4K6y6ty2TIGRVkOc6sxD9E21hGUC68UyUJym+qD7TPFWyKIaZHchm4mRmdcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=p4mVLhWK; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750834519; x=1751439319; i=markus.elfring@web.de;
	bh=qIxvwagA5r9Vos0XWvHO/MalZBvADoeLlVXEg11hQjo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p4mVLhWKaFvl2f4lSbktYxlpDcRgtEeq5Gpy49GiuM3UqQHzoJzo1FOEAgw+i6NC
	 pknomE9oLmkKG5sGoMBY1EvLw5tpGsvxb6NxMragGqWlBsVIMQnXgDq78DCoPWoGq
	 l7usK+oUAnZxCb8FJMoBa7zQrJOK/gOL3XSjsMzyA/zkrvXBlN37Fx1k8b3fiH1Y3
	 ZgtNqsDbFwoThoJNTq3qbKwQxxIZYBrxYpo6fW8tcuVMN5TsmgqHyJ5l1aNygmk3L
	 vdQbuPCixMKHxkjdUBV6qWmFBYPlm3ru7q6CqGDr9+bStxsjPV8wOBe3lSD9EYv7R
	 FaCylo7QFZr6ahq1ZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d3k-1usThm2ioi-00xBzK; Wed, 25
 Jun 2025 08:55:18 +0200
Message-ID: <9de5fb9e-bbe9-4f27-9370-1fff9e3c9fe2@web.de>
Date: Wed, 25 Jun 2025 08:55:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] wifi: rsi: Use usb_endpoint_xfer_bulk() rather than
 duplicating its implementation
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-wireless@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Kalle Valo <kvalo@kernel.org>
References: <d04019cd-f782-4d81-97ce-3d70946e5c54@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <d04019cd-f782-4d81-97ce-3d70946e5c54@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4LrI0Ok8MstTdwLoStYhEWx587AL9yyOz3vn1FnCBLI2nW6/T45
 hGsIJAVY0or1AqmhSGhkIYI8ji1WuiJdKlPUbugPJ+8F5SfI6nGl5JYZQkhFyP6h43Z1gi2
 EcMQ5ENWkngdGTwsITV1SOedJls5dWJWBmUE0LGzMEEOp8mv3Jay1dj0pcSTTlhsq1C/CVm
 kBej+KS8nAIRV6T/Za54g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JLD0F29C9i8=;+bd+Jj/F8ljuc56jPZCh3se8nlt
 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
 k3VY0fXpKU2Wp8=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Jun 2025 08:46:02 +0200

Reuse existing functionality from usb_endpoint_xfer_bulk() instead of
keeping duplicate source code.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V2:
Another change possibility was taken better into account for the USB API.


 drivers/net/wireless/rsi/rsi_91x_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless=
/rsi/rsi_91x_usb.c
index dccc139cabb2..31707b543c19 100644
=2D-- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -122,8 +122,7 @@ static int rsi_find_bulk_in_and_out_endpoints(struct u=
sb_interface *interface,
=20
 		if (!dev->bulkin_endpoint_addr[bin_found] &&
 		    (endpoint->bEndpointAddress & USB_DIR_IN) &&
-		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
-		    USB_ENDPOINT_XFER_BULK)) {
+		    usb_endpoint_xfer_bulk(endpoint)) {
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
+		    usb_endpoint_xfer_bulk(endpoint)) {
 			buffer_size =3D endpoint->wMaxPacketSize;
 			dev->bulkout_endpoint_addr[bout_found] =3D
 				endpoint->bEndpointAddress;
=2D-=20
2.50.0



