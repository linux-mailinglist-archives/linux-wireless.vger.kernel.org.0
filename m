Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883CBF7338
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 12:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKKLix (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 06:38:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbfKKLix (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 06:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573472332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZwWbKAicByQ7caf+4UMVGlXXUwIVp5v2QMtoVjYuVEo=;
        b=bORSX6lUDsn105mhDruU61244zhuF7te9cPooYlytSWog4xhvp9u/XGUuFb31upDAMUHXS
        m5qrSzwKvDkAU4LMVgVB+IO8+b0Puzp5TWiqGV6ldoST+S4mZuRy+dh13s2fAMf959GbSn
        VMvYKt3hY0Wodigg0oHKBETZDj4AAKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-Nt4mKNmhMKKKZIUUB4C3ng-1; Mon, 11 Nov 2019 06:38:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 631EB801E68;
        Mon, 11 Nov 2019 11:38:49 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-121.ams2.redhat.com [10.36.117.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FF4219C4F;
        Mon, 11 Nov 2019 11:38:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        youling257 <youling257@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: Add 024c:0525 to the list of SDIO device-ids
Date:   Mon, 11 Nov 2019 12:38:45 +0100
Message-Id: <20191111113846.24940-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Nt4mKNmhMKKKZIUUB4C3ng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 024c:0525 to the list of SDIO device-ids, based on a patch found
in the Android X86 kernels. According to that patch this device id is
used on the Alcatel Plus 10 device.

Reported-and-tested-by: youling257 <youling257@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging=
/rtl8723bs/os_dep/sdio_intf.c
index 12f683e2e0e2..c48d2df97285 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -18,6 +18,7 @@
 static const struct sdio_device_id sdio_ids[] =3D
 {
 =09{ SDIO_DEVICE(0x024c, 0x0523), },
+=09{ SDIO_DEVICE(0x024c, 0x0525), },
 =09{ SDIO_DEVICE(0x024c, 0x0623), },
 =09{ SDIO_DEVICE(0x024c, 0x0626), },
 =09{ SDIO_DEVICE(0x024c, 0xb723), },
--=20
2.23.0

