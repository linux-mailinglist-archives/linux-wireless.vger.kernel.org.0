Return-Path: <linux-wireless+bounces-13126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F154A984BA0
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 21:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2596C1C23025
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 19:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AA12CDBA;
	Tue, 24 Sep 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="c/wieX23"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88021130E58;
	Tue, 24 Sep 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727206437; cv=none; b=Jt7kxLiGUlw61SX/onErzl2T2GdMmk52pOFb0Ss/WjM2Hu14rrm51Vkzo13/F4pXds4HoAXyKaxWCnfNmBfwgokhdLJhnIMg7P+ZgC0Q7JC5+Gwo0qkSpc7AYTY2TKIJZGrB7bQPw0iSm6JLfXNx8NvbdCVXA9jA9nra/3cjVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727206437; c=relaxed/simple;
	bh=Q0JDOq8sfmCgEEs+y7IEKG8FXSr9YVUvlCC1FtysQ6Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OFCvbDwywIezwNrEZA3OAB4FegikiocMHDvbYS3l6FFvSjra5PeOoluQJN51rQydNgGNQTZR/OeldyN77ivLy2UzhxmE3jY0s0NZX1ST5Gp84SfJ3yWVBBo2e80Dd2v7MJ/HcYa+cCxEuZ9zJstZtRR8owO4Jdpv8sQQzSssjJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=c/wieX23; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727206431; x=1727811231; i=markus.elfring@web.de;
	bh=spba1qkATSAImggeaQkIEJnBCpW0mRm6T5bLfdk8GQA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c/wieX23gGJellPP0E8aBxQG14jBKj6NR/xJez0Try+6AvAk54r9A7GeGUutgdkE
	 uHVm+AEHLubRz3n4/Y+z9CuEg0NIijhHa2cDj1QEtBVeBYPHK7sCfYkXpy8phkey/
	 1R2g74XWJxoDahOEChUhxzoISTLBvLAN86/ZFESYoVFZi9ppFYCIh+2vH4kvxGFer
	 Bg9J7Q1jFNg/BLelZ1RZXqxUm1wjdWQ24Fxb+G0xj1rhzuyi29G51b+WlgxOxNpkU
	 PPTSpM0auPux2Zk+0qIQoWP2Rs5+M7rHpwibEntfZtrsZviplbw7YLuxF7257Aodt
	 TQKAo6v9dvAWBycPtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuF8x-1s5cbi3Txd-016GE2; Tue, 24
 Sep 2024 21:33:51 +0200
Message-ID: <d6037759-4dc8-4cc7-922f-95739761d068@web.de>
Date: Tue, 24 Sep 2024 21:33:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ssb: Call ssb_bus_may_powerdown(bus) only once in
 ssb_bus_register()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a63b5Hroecg4Cd0LUV5K1X2EO8x/ydyVfXOr0v5Uq3f16956k2K
 xiV2c4QnFJSCweVbE5KMZVPLqhLEvtFyxNufEun2vJCB2czFytyxUxWsl3D9IrS6RX9MhMc
 QhgeJ93VHwG81O5mMhckea7gqCckIQe9vva3xZduZ6wSm7yXmpcubt23XJsDllXM4D2QD3K
 5mo0ha096WC49/XZdYTkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gre6E0Na5Yk=;gBunWeUjMxDdpvJNkgQR6kTevXM
 xZKrQ42nW+ZIVX+hDh+03vorky8TyGQRM/jSF+H1Ky9sEODEyyQix5cSqGiQbKVo8SBQ5l3ch
 9zatbLqrPiJVC2ypQnWhS1ZjSn4qIbbKhbZ7gaq+UXsBjWG4fpZWnpYOPJps/awghWPm6krez
 83Mt/PNgeHfFzm5Qd39tsvl4wTL4iEnDQyFDrgoFI+b7nt3gSU+d+Bjyf6n/BqhdfRlPI3Hao
 BzhYla6pdALsgZD+Ss/fEjZUUovIJDP9OWSOxt2qoPDihp5lYs078rGX54KLD13g6rFzbGTOx
 MLhSgcVAl1A8OyTu8A8/Q1lbob7MEZq+dDzJYvE66lIXZmg4QX5x1TFp+XJb9vlXrkGd4xrPN
 YZGMVvH2j54WVLXQL2ECnz64TMDcs4AybZtCON2lIC92tYlJ5EbZMzPOJlwD4veEWaqYQp0ff
 XpyGF3bM0zITm5E1n3QAcl8fsHYtYNXcz3zWXNI2YjrI4cB+KXoL0eyxPdKDRXatwu1iv3NcZ
 /+VET5QTSuDzsR6qnDPw+mr3v3Dwvi1byv/J0wxSZfARgO1oaqdQIM1T3rW7AjOIYEsKJFVYW
 ohcP+Isl+eRjD7trW4WPPTzGnJBsgvA2u9SMsGtmiL7HJUiT/5xu4M/zZ3tPibO8pQ7Cysn8v
 FdGR/3FzcCFxbY8VPEblY/V44EH0W3IR8xGAcI7CMyahYvLH8zXSVhYF+IfRWSIgy44CPckct
 G+HoKiFhfwGfOOC/mjmZRY0lqF2eE8G+B+xvJmehPbLrg+2A6bB0Gjxdb7dR6o0q0+qD9zLkC
 EkxjyoqqChrEJXTCPCShEmlQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Sep 2024 21:24:13 +0200

A ssb_bus_may_powerdown(bus) call was immediately used after a return valu=
e
check for a ssb_fetch_invariants() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/ssb/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index aa6165e3db4a..458858b5472e 100644
=2D-- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -663,11 +663,9 @@ ssb_bus_register(struct ssb_bus *bus,
 	ssb_extif_init(&bus->extif);
 	ssb_mipscore_init(&bus->mipscore);
 	err =3D ssb_fetch_invariants(bus, get_invariants);
-	if (err) {
-		ssb_bus_may_powerdown(bus);
-		goto err_pcmcia_exit;
-	}
 	ssb_bus_may_powerdown(bus);
+	if (err)
+		goto err_pcmcia_exit;

 	/* Queue it for attach.
 	 * See the comment at the ssb_is_early_boot definition.
=2D-
2.46.1


