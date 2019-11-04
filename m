Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB332ED8EA
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 07:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfKDGRe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 01:17:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39868 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKDGRd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 01:17:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so10615709wmi.4
        for <linux-wireless@vger.kernel.org>; Sun, 03 Nov 2019 22:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyIV0QwdHIVyFetqgi2/yoOwnwayJibkeG1JHUZkuCg=;
        b=jAOI71U30ncvEF3lBRdQtQ4ku0GO9KylPlkEBfWmpDWsFvMiNzZS8hwJHyUx3XX1kA
         p0kKXedPKa6X93LMkYZwMkQVTwUvzDyb9Jp3eZW85EVPxr5KuY29sjspVhxwMuJJBuRD
         jkuqBiKjrskOS9gXYog/nyBEbYQMbbFAUejLKsEaIsmLFq1lkjlN1PqxMa6ftBai7ZgR
         wFRsj0mAcYHt4IY6/WCUtGiCHOhk4TPZtts7Bv4G0mxPTeK1e/l5uLZnU7AiddKtbR0h
         AcrQAzUMFPO2i9lz3GoIUrNqcPW75z2hrAxef+Stea5G76ht0qI8Glln8fcLeyZ/5ecW
         pXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GyIV0QwdHIVyFetqgi2/yoOwnwayJibkeG1JHUZkuCg=;
        b=BioHp/636seDoGWbZHHRWKG2MZyCD1Z/bbg0SyqkckuW2B7WoroepiB85lrMUBv0dS
         QfmnGuVH9SzHmOWAeOOKTXLsqlFCT7aQp6mtoDL7nLq0FzqHNTsfjIw17lo+6qSWg4TP
         Kir3N5qQYocS/TgxfC9IEylGvfN/j78EQdX9f60UnOvgKEjD+5LoVhPpznOnmiYGk7GK
         DM4WmrTLcQchi5jCbdZdWqeugURjoBOR4fES3h89SvMDKRAvgrB164Vt/Dt0GDHG8XLn
         TJeDDBOgnVBREgn0r/mALJEJL2JyfqQUPVNpvwYscnK7Rr7KmCA901JJLpNl2QNNKeG7
         N6kQ==
X-Gm-Message-State: APjAAAXlSqapllI45wpfcXRh1jlW8bv6chhWt6dlIdK1caktirFfr8WP
        QPKqimZSpRiUXtizXnRq4QA=
X-Google-Smtp-Source: APXvYqz5RfGbH7/X6t8tw6l7aAGkvLZll2cinhllWjn5r9ZDrYi0Kr3BbO48ynOtgWAS4lucrTqHDQ==
X-Received: by 2002:a05:600c:2212:: with SMTP id z18mr22901843wml.154.1572848251730;
        Sun, 03 Nov 2019 22:17:31 -0800 (PST)
Received: from localhost.localdomain ([193.27.220.66])
        by smtp.gmail.com with ESMTPSA id y78sm8626716wmd.32.2019.11.03.22.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 22:17:30 -0800 (PST)
From:   Eduardo Abinader <eduardoabinader@gmail.com>
To:     wcn36xx@lists.infradead.org
Cc:     Eduardo Abinader <eduardoabinader@gmail.com>,
        linux-wireless@vger.kernel.org, kvalo@codeaurora.org
Subject: [PATCH] wcn36xx: fix typo
Date:   Mon,  4 Nov 2019 07:17:22 +0100
Message-Id: <20191104061722.5379-1-eduardoabinader@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
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

