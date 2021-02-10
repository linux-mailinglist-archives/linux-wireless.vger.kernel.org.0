Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533D8315B99
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 01:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhBJAsr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 19:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbhBJApw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 19:45:52 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7F5C0617AA
        for <linux-wireless@vger.kernel.org>; Tue,  9 Feb 2021 16:42:35 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id l23so258487otn.10
        for <linux-wireless@vger.kernel.org>; Tue, 09 Feb 2021 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ZnFgpWZW/pibsdLxTLSbnISeByhzyHarQxXUqXKzeg=;
        b=hItZCUkUv3hVP0EKFKWGCHiq7LK6jTKvkwxQLRTVv+G2duyo63PGIc8YpI3DXE6v6Q
         93/TWf1dv1X8blaa5DeXeJ06ryE89D1TQkJDMHeu8+4PcwShh/BskEUrk4FnAjGukA1/
         b6mCu9NEcGcDsOJPB1nb3PYD86+w1ds5Zeedg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ZnFgpWZW/pibsdLxTLSbnISeByhzyHarQxXUqXKzeg=;
        b=ttHfKPOkFKdDhr8/Be0RUuL5JLNOxKI1ocIUhGg/tGssiBpahmAAIifi/veKNdP2/c
         QThuKRJgmOclFM6fhzdjzoAeoBI6JqRC/1DW+xDjqHlaW006w38BeKe/eLpOxb+ZBJps
         k2z1uidNJsU5F0OPTUWLeOOtrU/tNZsCqlCsLwI4hwmz9Bw88eogPu/GNAb2D7MSdncL
         I9hAP/aAT2R0REbKoMTrkCOF8kbC1WomCkai2OQBco2gAMX3fIQjx+D/J8T46GPZNutd
         6WRuBsnc/Qhl4zrzla+sMnsJPOvFZ65QewMkMp5JGVgreCSqG/yG3MJhPxT7jlHoCBgw
         tu+Q==
X-Gm-Message-State: AOAM530sn4kCJ6yQQPpfsCQfukJ5MVlsN5dH5wx32zF7jJFMSSPjE6i5
        YhRqZDvptjYTQUAgd6u2oWpu7Q==
X-Google-Smtp-Source: ABdhPJweKOk0U05wNNP7z8KOUn9C3PAmUn3jmo0QzHPBvGkR1giuIk30fNASdJrHyDRZtCLGpIiDCQ==
X-Received: by 2002:a9d:4e2:: with SMTP id 89mr259973otm.140.1612917755107;
        Tue, 09 Feb 2021 16:42:35 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s123sm103060oos.3.2021.02.09.16.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 16:42:34 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ath10k: change ath10k_offchan_tx_work() peer present msg to a warn
Date:   Tue,  9 Feb 2021 17:42:24 -0700
Message-Id: <3b1f71272d56ee1d7f567fbce13bdb56cc06d342.1612915444.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1612915444.git.skhan@linuxfoundation.org>
References: <cover.1612915444.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Based on the comment block in this function and the FIXME for this, peer
being present for the offchannel tx is unlikely. Peer is deleted once tx
is complete. Change peer present msg to a warn to detect this condition.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index e815aab412d7..53f92945006f 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3954,9 +3954,8 @@ void ath10k_offchan_tx_work(struct work_struct *work)
 		spin_unlock_bh(&ar->data_lock);
 
 		if (peer)
-			/* FIXME: should this use ath10k_warn()? */
-			ath10k_dbg(ar, ATH10K_DBG_MAC, "peer %pM on vdev %d already present\n",
-				   peer_addr, vdev_id);
+			ath10k_warn(ar, "peer %pM on vdev %d already present\n",
+				    peer_addr, vdev_id);
 
 		if (!peer) {
 			ret = ath10k_peer_create(ar, NULL, NULL, vdev_id,
-- 
2.27.0

