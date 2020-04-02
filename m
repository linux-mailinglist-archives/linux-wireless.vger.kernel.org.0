Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC61519CC7E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 23:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbgDBVmV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 17:42:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55855 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBVmV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 17:42:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so5023688wmg.5
        for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2020 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=deUrCaIYg9VqgBtDxyvSfNVjqbAj9bWkcCoGMyJST/s=;
        b=THfwV+3EtI6U2dmE7J9hZ6dlveFN4xZx7dFH4LVuA9JOP1RqHbbisSH/XqVzDHLDHt
         w7HgnXPEThde/sWy0nm185afUHdPIpcllMCy7wtVekiGas0/Y3ASI4wJy4x6UWgWwdZG
         BfzvjCQTgXNaUVg3kHkLZLDpNpNedFbWyYmBF6qtQdcXOnMiO1hFQbI/nb8XgjzaODqb
         Y0RXK/pYexQTM3rxvao6ypIvuLzlN+tncnPH4ZdQL6MB+xlENqhCEoCC9gqWJHuORhxA
         JOP4w39hIjuQ0p5FNCR5qX6syvb6hrh+ddoCodlB6lewmi6pPTfW8ZjuTvpu0uAiw67f
         mv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=deUrCaIYg9VqgBtDxyvSfNVjqbAj9bWkcCoGMyJST/s=;
        b=QXWZT0279syj6Ajldy+gXanAZWpRfR6/r9iIFRNi6pN7Sma4bEMWr+3ZZcUKFGN09a
         SaVhh88EmdEJdQnovI77wJrVK05B7oi06kebH0pNjRl3VYSFwtZfJNSOyTBKzDniOCRN
         P1Z4/OomMtnl28PdZ9vGgwNgWTHc5Ayj73nYHmnUM1DajLeHza2z2JhtCZdpbEkMsBve
         b+wdJ8PxddN3t4rpIr8QwoIR6lbzyVFGRRMYGIkiifhTc4BpFqWILwHv23if5tYPNoDu
         T47T7ZwvL92Sn4ipfs8wQy6SRP81LGtOBXw/mLB77HsSUYdzR0/UkeWBOUDjZldMa5/s
         AhRA==
X-Gm-Message-State: AGi0PuZvrWsbWgIS26O3IGk7EyebhOxP8P63uQhO9KVsDyzsQ1EHQBKL
        guPsn2gi+1KZ8fYB9+8NyMbL1/Jt
X-Google-Smtp-Source: APiQypIsy2FRWSKqb9ajTmBG7N5fBeZ6/4rovH+7z8T8Glt/MH19turvmeAu0HNKw9PumETQ/f5Xdw==
X-Received: by 2002:a1c:51:: with SMTP id 78mr5213590wma.157.1585863738628;
        Thu, 02 Apr 2020 14:42:18 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.56.threembb.co.uk. [188.29.165.56])
        by smtp.gmail.com with ESMTPSA id a145sm1050802wmd.20.2020.04.02.14.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 14:42:18 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/2] staging: vt6656: set all cck rates to default.
Message-ID: <dec847da-5bad-1920-f275-741f7f704fb3@gmail.com>
Date:   Thu, 2 Apr 2020 22:42:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211 rate control decides which cck rates to use so all of
them should be set enabled at the appropriate bit rate.

This means vnt_get_cck_rate is no longer required.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/card.c | 38 ++++-------------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 4abbe9b30b65..97e1538a528e 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -74,32 +74,6 @@ void vnt_set_channel(struct vnt_private *priv, u32 connection_channel)
 			   (u8)(connection_channel | 0x80));
 }
 
-/*
- * Description: Get CCK mode basic rate
- *
- * Parameters:
- *  In:
- *      priv		- The adapter to be set
- *      rate_idx	- Receiving data rate
- *  Out:
- *      none
- *
- * Return Value: response Control frame rate
- *
- */
-static u16 vnt_get_cck_rate(struct vnt_private *priv, u16 rate_idx)
-{
-	u16 ui = rate_idx;
-
-	while (ui > RATE_1M) {
-		if (priv->basic_rates & (1 << ui))
-			return ui;
-		ui--;
-	}
-
-	return RATE_1M;
-}
-
 /*
  * Description: Calculate TxRate and RsvTime fields for RSPINF in OFDM mode.
  *
@@ -216,20 +190,16 @@ void vnt_set_rspinf(struct vnt_private *priv, u8 bb_type)
 	int i;
 
 	/*RSPINF_b_1*/
-	vnt_get_phy_field(priv, 14, vnt_get_cck_rate(priv, RATE_1M),
-			  PK_TYPE_11B, &phy[0]);
+	vnt_get_phy_field(priv, 14, RATE_1M, PK_TYPE_11B, &phy[0]);
 
 	/*RSPINF_b_2*/
-	vnt_get_phy_field(priv, 14, vnt_get_cck_rate(priv, RATE_2M),
-			  PK_TYPE_11B, &phy[1]);
+	vnt_get_phy_field(priv, 14, RATE_2M, PK_TYPE_11B, &phy[1]);
 
 	/*RSPINF_b_5*/
-	vnt_get_phy_field(priv, 14, vnt_get_cck_rate(priv, RATE_5M),
-			  PK_TYPE_11B, &phy[2]);
+	vnt_get_phy_field(priv, 14, RATE_5M, PK_TYPE_11B, &phy[2]);
 
 	/*RSPINF_b_11*/
-	vnt_get_phy_field(priv, 14, vnt_get_cck_rate(priv, RATE_11M),
-			  PK_TYPE_11B, &phy[3]);
+	vnt_get_phy_field(priv, 14, RATE_11M, PK_TYPE_11B, &phy[3]);
 
 	/*RSPINF_a_6*/
 	vnt_calculate_ofdm_rate(RATE_6M, bb_type, &tx_rate[0], &rsv_time[0]);
-- 
2.25.1
