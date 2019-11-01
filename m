Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1CEC0CC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2019 10:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfKAJwM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Nov 2019 05:52:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54700 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfKAJwM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Nov 2019 05:52:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id c12so4189943wml.4
        for <linux-wireless@vger.kernel.org>; Fri, 01 Nov 2019 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDqPCJfj1s6nsEUqhxYgJ7ih3q1mkKOIT1oAmB3fYFg=;
        b=plEtak1x98PIsdWlcaNgdh6ZFJWiX9xboeW0f4qEa/sOqSVOauHEyhZSilio6mjr/J
         vwRJExwGRdgAdY7tisQ5Iaqzhu10b0DlbRNTExcEzLXGo4G3A8568vR53suv10sf+Wbg
         G0j+f/bpixlEidMi1JzCV3EcqJbkDgldqU9ot+j8BnK/6Uu0a329KHBFRlBnovc6Ut36
         SL14D8gx1ZE13uIgLnGSH0HvjAsRcfARzhz4H/AZYwBrASTU5dYHIpjwELdlgcW8BNrW
         oKUvPCLK+0TZ1vZjDAahTMPn6XKEBaP3APqkne3G2ChHW2D9+baBHm+uyJs31iT4HP7C
         eo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HDqPCJfj1s6nsEUqhxYgJ7ih3q1mkKOIT1oAmB3fYFg=;
        b=P5Mt5XUvUE3RiNkhCGcB0QRuEPXzigTYrR5mKAtWb/DE20KzJpWig9S8CDlwIrHT9l
         age7+2qo/WTG4Ov4QeVK3yDK88pWLtb0eQxzI5Gv8xY4Z5rrl+iLwU/auNtqXD2yBcS0
         CO0QhQXVpntHG0loqIxHcU271WBC9tOGt4qsWJAb4fIgFjaVkR/avMNmRoTQj/Q2Eg2t
         KloWUrIRV7tL0pBbsjN+1V3Hr3jHQ2Tume/X0BZCsGgcvSehf1t+JkB2Hascw4t8O150
         WvCcqxgMvv8GacYvQTip1FFkhhkbTnsOyXfzRIkw2w5iIOlaIfRHp+HRSjSFq9uHCtKu
         kw4w==
X-Gm-Message-State: APjAAAXI1j7h5ZK6EZmtn5rmI7A/R12F++Lkm4oGNXDVv54jMbM+zjUg
        XkbBVSb0Fa/qp7v/sheNNOM=
X-Google-Smtp-Source: APXvYqxFY5X4nWP6nNqNxTkm3iph+ThBCuFpEaOTMOwIJa4bqZWGTnmRC1CBSv2RFHy+PtqTixb8VA==
X-Received: by 2002:a1c:38c3:: with SMTP id f186mr9600128wma.58.1572601928994;
        Fri, 01 Nov 2019 02:52:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c22:721d:b401:2d93:6353:7708:66e1])
        by smtp.gmail.com with ESMTPSA id l15sm5786121wmh.18.2019.11.01.02.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 02:52:07 -0700 (PDT)
From:   Eduardo Abinader <eduardoabinader@gmail.com>
To:     wcn36xx@lists.infradead.org
Cc:     Eduardo Abinader <eduardoabinader@gmail.com>,
        linux-wireless@vger.kernel.org, kvalo@codeaurora.org
Subject: [PATCH] wcn36xx: fix typo
Date:   Fri,  1 Nov 2019 10:52:00 +0100
Message-Id: <20191101095200.5778-1-eduardoabinader@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/wcn36xx/hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 8abda2760e04..6ba0fd57c951 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -2091,7 +2091,7 @@ struct wcn36xx_hal_set_bss_key_rsp_msg {
 /*
  * This is used  configure the key information on a given station.
  * When the sec_type is WEP40 or WEP104, the def_wep_idx is used to locate
- * a preconfigured key from a BSS the station assoicated with; otherwise
+ * a preconfigured key from a BSS the station associated with; otherwise
  * a new key descriptor is created based on the key field.
  */
 struct wcn36xx_hal_set_sta_key_req_msg {
-- 
2.20.1

