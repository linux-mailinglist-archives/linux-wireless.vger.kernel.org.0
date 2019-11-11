Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A65F7339
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfKKLiy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 06:38:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36177 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbfKKLix (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 06:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573472332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+Di3Kl/jO6R1/yj5/OK39qxfLJcA5U247p2Yowc9hI=;
        b=Muh5Q/WhXDuRTsTsaJasg4WFgBw1RBV3Tv59K3UZN0469Mm18SoDJQpF5o6OtkZbHfq6J6
        e3NJNZv/9arsB6NMWcgv1AlbOLdxVl1o8mALhsKOqxe2LSZfqrJXuoqnCZxy/fs3L7p7l0
        QvHPAwl/HZS+UgEfAo+K2r1JcQmekJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-8pWTqUvPOjWFJDZgpVej_A-1; Mon, 11 Nov 2019 06:38:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D646800D49;
        Mon, 11 Nov 2019 11:38:50 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-121.ams2.redhat.com [10.36.117.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC82119C4F;
        Mon, 11 Nov 2019 11:38:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 2/2] staging: rtl8723bs: Drop ACPI device ids
Date:   Mon, 11 Nov 2019 12:38:46 +0100
Message-Id: <20191111113846.24940-2-hdegoede@redhat.com>
In-Reply-To: <20191111113846.24940-1-hdegoede@redhat.com>
References: <20191111113846.24940-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8pWTqUvPOjWFJDZgpVej_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver only binds by SDIO device-ids, all the ACPI device-id does
is causing the driver to load unnecessarily on devices where the DSDT
contains a bogus OBDA8723 device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging=
/rtl8723bs/os_dep/sdio_intf.c
index c48d2df97285..859f4a0afb95 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -24,13 +24,7 @@ static const struct sdio_device_id sdio_ids[] =3D
 =09{ SDIO_DEVICE(0x024c, 0xb723), },
 =09{ /* end: all zeroes */=09=09=09=09},
 };
-static const struct acpi_device_id acpi_ids[] =3D {
-=09{"OBDA8723", 0x0000},
-=09{}
-};
-
 MODULE_DEVICE_TABLE(sdio, sdio_ids);
-MODULE_DEVICE_TABLE(acpi, acpi_ids);
=20
 static int rtw_drv_init(struct sdio_func *func, const struct sdio_device_i=
d *id);
 static void rtw_dev_remove(struct sdio_func *func);
--=20
2.23.0

