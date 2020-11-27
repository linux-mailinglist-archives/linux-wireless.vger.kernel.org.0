Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2189D2C6B0E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Nov 2020 18:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbgK0Rzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Nov 2020 12:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732462AbgK0Rzk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Nov 2020 12:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606499740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Br/IPbdHx/OaYg6xCtsKtihEPu1TMwZ+6MkhSnyxsRs=;
        b=OlqeNknsyJOgPCiYYSBRTA1H+W8HdCu3r7pnY6q3humVeUUUN0epS5Txaj2k7smHLoJUsU
        OjDWByJeZc0ecyFyPUVGFzh+EGAOM3cdS/UiFDI6/RcnUHrfMY3HTbxZVQTdmx8M5Xcfsx
        7os+S7JElacrYsG1hPt69nx4xeRbU78=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-N-mEsRJTNk6yRV84rQ9B-g-1; Fri, 27 Nov 2020 12:55:38 -0500
X-MC-Unique: N-mEsRJTNk6yRV84rQ9B-g-1
Received: by mail-qt1-f200.google.com with SMTP id d9so3657352qtr.5
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 09:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Br/IPbdHx/OaYg6xCtsKtihEPu1TMwZ+6MkhSnyxsRs=;
        b=JBvtlgUJSn5TqpQyPmg1sgnEws93WIMhhkRax1P/9l6aviN+xdQR3+H2u6G8DcKuhE
         mgQerJ+PMQ1kdN69g+SjToCYmUmuvkdeoTHpQ/dJPgzGUxzDmhV1lYOiD2cy0Mzf7srm
         BvYvGtD5tp2nxM/vDqQxASK41b+BmGodVeGuCdCrLlKulOXddt+GXLXiX32WuvEK7w7x
         a3OE8iXiCamr0kOVfdB+0dBoBtS1Aa1+hEdwfS2CdI5cvhounVeku+fUbjEK80K5NRVA
         gPyOh0X/0K1HR+NJWnXo5gpcGB5zvzJS6nwYK8At8YD4lnkAcUiiTx9Ygqq+nezjUk9h
         EfXA==
X-Gm-Message-State: AOAM530x8QMPnHlEurVlk57KEVKrWlfR+BQvrbwSrKyVl3A7VLpskYkw
        x990qe0m/yVLNvB5dAyqyklaw1GfQH0JbKwKOkv080weY3J51cqbRVv9ixJq042CtcmLFzYvpow
        WciwMc829SKGTp8VCJWYjAMkBgB0=
X-Received: by 2002:a05:620a:a9a:: with SMTP id v26mr9511046qkg.56.1606499737598;
        Fri, 27 Nov 2020 09:55:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2L15Xpt+pzKI2tQJ1Mja1bZVxZ9cJq3+yTQqjAUjwGC9JUF+NSrylLZnhZYHe6hp4SZgoPA==
X-Received: by 2002:a05:620a:a9a:: with SMTP id v26mr9511031qkg.56.1606499737423;
        Fri, 27 Nov 2020 09:55:37 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r48sm6421675qtr.21.2020.11.27.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:55:36 -0800 (PST)
From:   trix@redhat.com
To:     chunkeey@googlemail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: carl9170: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 09:55:31 -0800
Message-Id: <20201127175531.2754461-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/ath/carl9170/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/debug.c b/drivers/net/wireless/ath/carl9170/debug.c
index 19009aafc4e1..bb40889d7c72 100644
--- a/drivers/net/wireless/ath/carl9170/debug.c
+++ b/drivers/net/wireless/ath/carl9170/debug.c
@@ -45,7 +45,7 @@
 #include "cmd.h"
 
 #define ADD(buf, off, max, fmt, args...)				\
-	off += scnprintf(&buf[off], max - off, fmt, ##args);
+	off += scnprintf(&buf[off], max - off, fmt, ##args)
 
 
 struct carl9170_debugfs_fops {
@@ -818,7 +818,7 @@ void carl9170_debugfs_register(struct ar9170 *ar)
 #define DEBUGFS_ADD(name)						\
 	debugfs_create_file(#name, carl_debugfs_##name ##_ops.attr,	\
 			    ar->debug_dir, ar,				\
-			    &carl_debugfs_##name ## _ops.fops);
+			    &carl_debugfs_##name ## _ops.fops)
 
 	DEBUGFS_ADD(usb_tx_anch_urbs);
 	DEBUGFS_ADD(usb_rx_pool_urbs);
-- 
2.18.4

