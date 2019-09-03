Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F267A5EC8
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 03:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfICBSi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 21:18:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35319 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfICBSi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 21:18:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id 100so15134220otn.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2019 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKRw3YAmqmgHvf0RsxYwv0O/aEY2i3zqXVRRQVICAnA=;
        b=fh7MKIWpVMn+vBpBL+m8DP7sPbJQqC/WCYwJH9+Y73947T4YPIGKZrCEpQeSzZx5SC
         FYEsAr7iCvA2IMTUbPuK37Z6FikaCjxEJXU5nds/Df3huEBKk19pXx5UhEmY3WZmT4gt
         /gLbIbL9iv1Ufwy0UQO+Rv3t28aQXr+Az+tvrrC2kMwIInRi7Z8qgIp8EluFrDEOqncg
         X2Do7PD85VKFpWl340buuG3Lkt9g7R4MHprKNbuOnCdKTNtwQqA5i34gjPBZpPlx5NXR
         dHATFfkBAes+Nt8dgqWI1dRyK0NnMUkJ3FGjQamo93h4EYdEUyuE6sQ38rrg+TeYBIlD
         TCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iKRw3YAmqmgHvf0RsxYwv0O/aEY2i3zqXVRRQVICAnA=;
        b=c7/r7qcIrYoRYuSSW5PWTDa9IbLfhTaNOfEg2xPU72NwsPX6wtdxMKipYTuw+RGvNC
         qBtM1L5DLCGUECmgSIXEQ4evgAWcXZi5FSaq8KEpDZ6It6uazC5mDRy3gIgxIK/ltu9h
         1cLJwp8coPizeV4Sl6E7IBCnlwfHSuh/mPzSxkCeG5xfWfBLKhwTky8pqTk8Gj0Ic/kc
         Z69FPNmh8lH7/thDaaX+epzEm+QrWJxxgh1Un+u6J3mFYhvbSM1QB/Ow/8NnPix1bVlR
         vaNq8sWlp6wJHh2kQ6SnwJXyFUvhKg+lKxQD0wZdLidaXtPPxNzOsclrilfoJ2jel8E1
         KHGg==
X-Gm-Message-State: APjAAAWNoAQpbWV+ka75GJmzUAA8c5UoLE+iRtvzE66AJyBAcaweBygj
        Ik63bShrr7ZxHyBtPTOdUQk=
X-Google-Smtp-Source: APXvYqxHIgEL05Ycemi7/iJWxvOnAVE8IkHOECBc50/bu/zQO2yh/JGXct17ghTA4/snCCncNhKvvw==
X-Received: by 2002:a9d:6218:: with SMTP id g24mr845309otj.326.1567473517833;
        Mon, 02 Sep 2019 18:18:37 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id d13sm230244oth.11.2019.09.02.18.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 18:18:37 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/3] rtlwifi: rtl8192ce: Fix incorrect returned values
Date:   Mon,  2 Sep 2019 20:18:13 -0500
Message-Id: <20190903011813.13946-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190903011813.13946-1-Larry.Finger@lwfinger.net>
References: <20190903011813.13946-1-Larry.Finger@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In commit 98fd8db59a00 ("rtlwifi: rtl8192ce: Convert macros that set
descriptor"), all the routines that get fields from a descriptor
were changed to return signed integer values. This is incorrect for the
routines that get the entire 32-bit word. In this case, an unsigned
quantity is required.

Fixes: 98fd8db59a00 ("rtlwifi: rtl8192ce: Convert macros that set descriptor")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
index 709dcac9d84b..b45b05a6a523 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
@@ -216,7 +216,7 @@ static inline void set_tx_desc_tx_buffer_address(__le32 *__pdesc, u32  __val)
 	*(__pdesc + 8) = cpu_to_le32(__val);
 }
 
-static inline int get_tx_desc_tx_buffer_address(__le32 *__pdesc)
+static inline u32 get_tx_desc_tx_buffer_address(__le32 *__pdesc)
 {
 	return le32_to_cpu(*((__pdesc + 8)));
 }
@@ -311,12 +311,12 @@ static inline int get_rx_desc_bw(__le32 *__pdesc)
 	return le32_get_bits(*((__pdesc + 3)), BIT(9));
 }
 
-static inline int get_rx_desc_tsfl(__le32 *__pdesc)
+static inline u32 get_rx_desc_tsfl(__le32 *__pdesc)
 {
 	return le32_to_cpu(*((__pdesc + 5)));
 }
 
-static inline int get_rx_desc_buff_addr(__le32 *__pdesc)
+static inline u32 get_rx_desc_buff_addr(__le32 *__pdesc)
 {
 	return le32_to_cpu(*((__pdesc + 6)));
 }
-- 
2.16.4

