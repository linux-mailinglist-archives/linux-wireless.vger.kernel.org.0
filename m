Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30649664EEE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 23:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjAJWpB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 17:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjAJWow (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 17:44:52 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967A05EC02
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 14:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673390688; bh=2MTASe/3g8poUlJ8j96xugkp3Nk8RlBS9oT15Ccl/bo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=dPzcrmD882Ik5TAc/C4f0bhKXhnxh1Zfy4xW6YcStL50RYBI2HxngZ1Uwk1Ch0cwr
         /cKoknw15oGdOHAsDDEWKEaCnJXcH6nstQBg0ApCjt6w/kA7IqTHDVvP6QBq5R3B5u
         gUyqp22dAJ6i47ObeHG/0FH3qlMbFMFl9wzu+IQgr3DDmTDa6B0VndYaG9XEbpWjUs
         mPLNkBozUj0UxZrn8fUTxbDaJs0/7n3gFiy0NOs6kgFBUEUNm5a6Si9tHITvtmJ/QA
         RuWkfxXCY7VJ0qedENm0VqTvVtDcOobJIYOxGi9Fh1bFed5nPf/9O8D01BhWXFXWKM
         X/D65toNNmCZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CQh-1onMfG03Ft-010hAT; Tue, 10
 Jan 2023 23:39:39 +0100
Message-ID: <45e57883822389266ab67f7e0b6aa737db047cdd.camel@web.de>
Subject: [PATCH 6.2-rc3] wifi: mt76: fix dma error
From:   Bert Karwatzki <spasswolf@web.de>
To:     linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Tue, 10 Jan 2023 23:39:38 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:m1vTukqD4ylLzNvwyRH8As3UzlUTE1mP6mJfSi+gVabpSPPHqqn
 B7c94rwRd5lx4FnYCavnj9WASu5FvZCrAE/n9Mic9nNgNHAuEGkD6VhqRgueCIfclaZIBGc
 ZKUkwNURcR9DvhS7PizwgYr957fffpzjsptwPA+UOzjNc0wTHi/vavarqfOZmNYHBbGscHi
 9dYnMLlCHLM/3THtwj6aA==
UI-OutboundReport: notjunk:1;M01:P0:BmYIp7eJKXQ=;KJ8QbrGw8iwHIRZXTZ1ghf19gVB
 G5QL5j4Q1JO/NKilxkO8a/1vT77VGgMItRN9mISa69/HA8itScjBID0GbEA8TThebZA4AUTJE
 Pk9WaOK9nEewkDb+LdCcFKn1eWJu2zAQ1LirqNLEH/hYTLsJ4DWvyQvAqFJG8PFUgRdXIe4+4
 qDHBjVhOLhHVJBv6ZvFJOeAKFwZDIRGTI1v5xGqkiqIi+RDsa+/NI65+Pzgpf91oLYbMfeQba
 0248/2njWQysnP0RqWWkRSOyU8EsROwIPmk2kq6nPDW5x40Uv/E5+CMbkrTevL9smWGu+kWHe
 HL8KCV+9EqQfrtNfB35jQoY7zR92KEoa1+vaiu/kX8LoCzlS24y/nW91gVG4VW0OGl7I7MISB
 FdhLZbKi+Bb7jm87+oHhU9AWS5c4NyVqgXq3xKeDBvpAV7VNhrFnHa84NnoSnmLBfAYB6/zPz
 fZr+OUchdyTMyRRJHQmXa8pv7yKbAU6hfnoTAaTb603+mdq7gN4POQcvSImhH+2stbwxT/7O3
 fwq/c4XpEVz//uOY6Z1sf28bUQx63qoTpflIrrkYD+bI/89Z6kzS7+6PcZInfk1T0mr49AM44
 dpSO78NtAMPx5+S0Fr93cpMqRQEvjaTHE+B46oaEXukpFd7XMVgSqb4lJGYxZNulJcjg78Sq9
 nRAtOfy6GmrJ834aHuXnv5sWbflouNqlgmAJz0Dfe3XNR62uDiy6C4neUGOLcs37Pt8HAvMnb
 r6p3d9Lvup6FxqjP+Nfkhpdn8stD+a4pHkk5LT8tTbLxqjXtfASdRydkEYQH/I/xuU6V6kQEx
 NoZhOB5a2tD6OoUQRuAAvJTN50Xdj1zed1x93MBrfd/N1HnC2VfkabuMWcxv+ErHOFODS9dtA
 0/qCplTeErBTwgTP11dDvQYBvJaL9z8aQCU4gBm/+Tq7nX1tOUNgH95O5n6Gt6CGc+yS5Gufo
 wqP0rmoKFbNveoDELXfWe+/9InU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since linux-6.2-rc1 the mediatek mt76 wlan driver suffers from problems
https://bugzilla.kernel.org/show_bug.cgi?id=3D216901. I bisected this to
commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae and noticed that the

	if (txwi) {
		q->entry[q->head].txwi =3D DMA_DUMMY_DATA;
		q->entry[q->head].skip_buf0 =3D true;
	}

part is moved from the beginning of mt76_dma_add_buf to the
inside of the for loop. But q->head is modified at the beginning of
this loop.
 This patch puts at the beginning of mt76_dma_add_buf
diff -aur linux-6.2-rc3.old/drivers/net/wireless/mediatek/mt76/dma.c
linux-6.2-rc3/drivers/net/wireless/mediatek/mt76/dma.c
--- linux-6.2-rc3.old/drivers/net/wireless/mediatek/mt76/dma.c	2023-
01-08 18:49:43.000000000 +0100
+++ linux-6.2-rc3/drivers/net/wireless/mediatek/mt76/dma.c	2023-
01-09 22:07:29.533248047 +0100
@@ -215,6 +215,11 @@
 	u32 ctrl;
 	int i, idx =3D -1;
=20
+	if (txwi) {
+		q->entry[q->head].txwi =3D DMA_DUMMY_DATA;
+		q->entry[q->head].skip_buf0 =3D true;
+	}
+
 	for (i =3D 0; i < nbufs; i +=3D 2, buf +=3D 2) {
 		u32 buf0 =3D buf[0].addr, buf1 =3D 0;
=20
@@ -238,11 +243,6 @@
 			ctrl =3D FIELD_PREP(MT_DMA_CTL_SD_LEN0,
buf[0].len) |
 			       MT_DMA_CTL_TO_HOST;
 		} else {
-			if (txwi) {
-				q->entry[q->head].txwi =3D
DMA_DUMMY_DATA;
-				q->entry[q->head].skip_buf0 =3D true;
-			}
-
 			if (buf[0].skip_unmap)
 				entry->skip_buf0 =3D true;
 			entry->skip_buf1 =3D i =3D=3D nbufs - 1;=20

Bert Karwatzki
