Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48F428A817
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Oct 2020 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgJKPzO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Oct 2020 11:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730138AbgJKPyr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Oct 2020 11:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602431686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=pR1M69yxrP9JSOS0Ie5ezAaQo49msGZptm8kNeSlSi4=;
        b=RnA8Q/+Wp2v9p6Ns6o4gZ+upo/MszJ1ShQDpQK5jFKPyD9YvqAiC+WqQWg9F9n91yq1kIm
        FNeQU+aDeVSlDMWmVMSKDXZ58Jnk9uKtzj2ze4NUzoMn5ZxETB9iU0kKGcS4mziBhnRADp
        3Vz5PZ976w6POx5rdDUmVvzPCmkI8RE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-8awCT1e3NZynJXEI-oyF5g-1; Sun, 11 Oct 2020 11:54:44 -0400
X-MC-Unique: 8awCT1e3NZynJXEI-oyF5g-1
Received: by mail-oo1-f72.google.com with SMTP id s9so4590945oom.15
        for <linux-wireless@vger.kernel.org>; Sun, 11 Oct 2020 08:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pR1M69yxrP9JSOS0Ie5ezAaQo49msGZptm8kNeSlSi4=;
        b=YcsT9mJxTXb9Mu0+IcJvHM4RRKXtxLT5xiQmc39p/qqwbY8XdPS+tvYhadWT+M/1bZ
         TY3yORIAN6PXm+jSiuHrUfBjBoe1t4m3ffQcbtW1FyHau7s2IShjjJPVfLCB4jlZTsYL
         56LhbZbwBLFbR6a4PuJkKmsQLkYP9FUOWxB4gr53xrtYHnmBjiCH+66Um36fKAzq8+tt
         6BkNkZ3aY6hOC/vTHShw2P3+1NNrMYOG/CKsO5NzgG9p7CPsttP19d/LbTsC8iRc9KHm
         /XimBwfp5LhV0L2J0vzvJZJisYFRN9cswQnm5Qa2+wlB7ayDjKqYJZZptSLnSsu3FogA
         M6vA==
X-Gm-Message-State: AOAM533ceF/Hw8+OqiGyAFA8ib9ZjxF5D+4pkiyZjpb2owoQsdXYoCfj
        F7RpNAUoWdt9r3DW5joR+s8o/mOhBE05L6PINLPpKciwIBQ390s99E24jNJSBpqNVqA1PhQFFCP
        7fVoluLTmGSwDRzIjXgSzEGTSga8=
X-Received: by 2002:a4a:da53:: with SMTP id f19mr15863004oou.38.1602431684163;
        Sun, 11 Oct 2020 08:54:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPJ4u/OeZjHz4mlSxVIynu+KwH6mw6NHjvdnFA3ZLQHkWtrDgVgyM85WaG5gdk1n/GnBdINg==
X-Received: by 2002:a4a:da53:: with SMTP id f19mr15862992oou.38.1602431683974;
        Sun, 11 Oct 2020 08:54:43 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t22sm7969499otk.24.2020.10.11.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 08:54:43 -0700 (PDT)
From:   trix@redhat.com
To:     yhchuang@realtek.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org, natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] rtw88: fix fw_fifo_addr check
Date:   Sun, 11 Oct 2020 08:54:38 -0700
Message-Id: <20201011155438.15892-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The clang build reports this warning

fw.c:1485:21: warning: address of array 'rtwdev->chip->fw_fifo_addr'
  will always evaluate to 'true'
        if (!rtwdev->chip->fw_fifo_addr) {

fw_fifo_addr is an array in rtw_chip_info so it is always
nonzero.  A better check is if the first element of the array is
nonzero.  In the cases where fw_fifo_addr is initialized by rtw88b
and rtw88c, the first array element is 0x780.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 042015bc8055..b2fd87834f23 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1482,7 +1482,7 @@ static bool rtw_fw_dump_check_size(struct rtw_dev *rtwdev,
 int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
 		     u32 *buffer)
 {
-	if (!rtwdev->chip->fw_fifo_addr) {
+	if (!rtwdev->chip->fw_fifo_addr[0]) {
 		rtw_dbg(rtwdev, RTW_DBG_FW, "chip not support dump fw fifo\n");
 		return -ENOTSUPP;
 	}
-- 
2.18.1

