Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2381948D519
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 10:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiAMJnE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 04:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233252AbiAMJnD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 04:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642066983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2+FNU2MPaqVltcC6h9bscIlPJirp7fr9l0D+4BMbyMc=;
        b=PRVpO1GZ9LUiqQyQXHDlrZTEyYLqBcmiBQfAIfNNV0jROzfM1Bmg9ISxB1FLaQs5aWo9gE
        wh+unRvFgmZqxfGCH86HZtcKJpsA6lfUL5EC5jnIZmJmYDf90FLrImuhNI6/j2qkFrVC4J
        9wsdKra2cmsIEzW9OyMvT4ToIdIhk1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-l2sTLUSjO1u7TqyKlXA4CQ-1; Thu, 13 Jan 2022 04:43:01 -0500
X-MC-Unique: l2sTLUSjO1u7TqyKlXA4CQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F5A68042E1;
        Thu, 13 Jan 2022 09:43:00 +0000 (UTC)
Received: from ihuguet-laptop.redhat.com (unknown [10.39.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16BC410595A1;
        Thu, 13 Jan 2022 09:42:58 +0000 (UTC)
From:   =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     pkshih@realtek.com, kvalo@kernel.org,
        =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
Subject: [PATCH] rtw89: fix maybe uninitialized `qempty` variable
Date:   Thu, 13 Jan 2022 10:42:53 +0100
Message-Id: <20220113094253.73370-1-ihuguet@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Call to dle_dfi_qempty might fail, leaving qempty.qempty untouched, which
is latter used to control the for loop. If that happens, it's not
initialized anywhere.

Initialize it so the loop doesn't iterate unless it's modified by the
call to dle_dfi_qempty.

Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index afcd07ab1de7..9f73a2303e90 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -172,6 +172,7 @@ static void rtw89_mac_dump_qta_lost(struct rtw89_dev *rtwdev)
 
 	qempty.dle_type = DLE_CTRL_TYPE_PLE;
 	qempty.grpsel = 0;
+	qempty.qempty = ~(u32)0;
 	ret = dle_dfi_qempty(rtwdev, &qempty);
 	if (ret)
 		rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
-- 
2.31.1

