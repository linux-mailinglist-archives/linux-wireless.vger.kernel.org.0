Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7570B1168EC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 10:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLIJNN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 04:13:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41961 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726377AbfLIJNN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 04:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575882791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=g9JfgbZHp5T4Hbg3bEJqnWJWZxG1N4J3b7/kgPt9yGM=;
        b=Uy3DmR9a1lX4OC8UPfZSR8hni8U31bvBjQ1i1Z+IMhr8RREoaq2YcA/tTiigWA70gdBNL1
        m0H+fkLA9BUxT9VMWXFyOyIPSZ4qvASf6nA9xAvNjYdbS1sIW9Xk6950grHuTsuA2SamnH
        v57SOSm4brK7BJyIeoEkVggfNAzCfPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-Qn-LUyvEM-q1hhjK6NEUmQ-1; Mon, 09 Dec 2019 04:13:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4574D1883524;
        Mon,  9 Dec 2019 09:13:07 +0000 (UTC)
Received: from localhost (ovpn-204-181.brq.redhat.com [10.40.204.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5C9110016E8;
        Mon,  9 Dec 2019 09:13:06 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH] MAINTAINERS: change Gruszka's email address
Date:   Mon,  9 Dec 2019 10:13:05 +0100
Message-Id: <20191209091305.5998-1-sgruszka@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Qn-LUyvEM-q1hhjK6NEUmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My RedHat email address will soon stop work. Change to my private one.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3a5c54a41d..dc9072717325 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8467,7 +8467,7 @@ S:=09Maintained
 F:=09drivers/platform/x86/intel-vbtn.c
=20
 INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy)
-M:=09Stanislaw Gruszka <sgruszka@redhat.com>
+M:=09Stanislaw Gruszka <stf_xl@wp.pl>
 L:=09linux-wireless@vger.kernel.org
 S:=09Supported
 F:=09drivers/net/wireless/intel/iwlegacy/
@@ -13615,7 +13615,7 @@ F:=09arch/mips/ralink
=20
 RALINK RT2X00 WIRELESS LAN DRIVER
 P:=09rt2x00 project
-M:=09Stanislaw Gruszka <sgruszka@redhat.com>
+M:=09Stanislaw Gruszka <stf_xl@wp.pl>
 M:=09Helmut Schaa <helmut.schaa@googlemail.com>
 L:=09linux-wireless@vger.kernel.org
 S:=09Maintained
--=20
2.20.1

