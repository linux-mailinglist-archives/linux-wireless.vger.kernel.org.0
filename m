Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2791019CC7C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgDBVlj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 17:41:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38975 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgDBVlj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 17:41:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so6029321wrt.6
        for <linux-wireless@vger.kernel.org>; Thu, 02 Apr 2020 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=d2LuQ9+tNaM4iX/cPzhdZ44JC45KzMGRSOTVMyTga64=;
        b=c79F/GVEsGXKxyOu7A9T1Qfohd2O5y0eRvw8sV/dT6rBmaI28MM9db9/0HN9CPuXzL
         361BRQBo8MFfwCZr3fpIwnlZR5Mup51v4ON7YZ66/4Uo18Fa/oC3UZ8M7dFXuBLkgMmF
         DiHM6zR0vLV2JRMww5ocIJsvGwvJjf5Nph6YIPup8ybhLWqYSVidC2iEdlYdCwruhP6u
         ZxQZlaadfZpKkmEoyo+5KQ6BsF2nIVyUHnqcjRky61V9oqT++hDaZr7ij5cjIqLA8//C
         8d9+HstFCYn0kV0EirNcFnc8T6Sew/u5rN7+H9fTL0NsFPuWmz/pdRo6piRwjIrEHbV1
         i92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=d2LuQ9+tNaM4iX/cPzhdZ44JC45KzMGRSOTVMyTga64=;
        b=pRqyuALnccqEbmnqDbKQiBBdW0bVI4qMAR2MX+jcO7YhmTWwgJGxADJV3G5od+NX+0
         ecAh49NHGewxqQrLbrFgP3zuoAjgnpBJVq+1aJdhx+9dMz1KjH2DVdPqqt7HK/iJKOCE
         UMHTZTl3+A9K0DrWYglC5SxyJJUo1tdblRXRx4VOR65hXyaOsj16bTWQ8n5zBiwl/n2/
         G+eeqmF8WFsjBuJxZ9DDEDdWW5kV0uGzG6Qb6H9bM9Q6xETrkd5HsZKLZeyn/Si9Nseq
         aaQErYUTdv/D38zKJ2JeZfZKWEsifIm8xvwlVRN0D0vrzRGczey0PC0gfymHYsLqSbt4
         dytQ==
X-Gm-Message-State: AGi0PuaNulblN7+5E5XMyNcAAn9+x/a80jIhDSx2t7Psq1VkQf/l1zSY
        MmQ2K5NXrnBTbqcPnWYmPio9/Ikc
X-Google-Smtp-Source: APiQypLTExJmoPfCrwiXbr6n2YgIiH3ReADoHv65LIhP5tC20uJdWQFk4OyVzCWisp79x/KL6F59qw==
X-Received: by 2002:a5d:5230:: with SMTP id i16mr5423057wra.15.1585863697150;
        Thu, 02 Apr 2020 14:41:37 -0700 (PDT)
Received: from [192.168.43.18] (188.29.165.56.threembb.co.uk. [188.29.165.56])
        by smtp.gmail.com with ESMTPSA id 91sm3123622wrf.79.2020.04.02.14.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 14:41:36 -0700 (PDT)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/2] staging: vt6656: set all ofdm rates to default
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
Message-ID: <9a52d7f4-dd3e-efdc-eef8-bb794f7dea6d@gmail.com>
Date:   Thu, 2 Apr 2020 22:41:34 +0100
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

mac80211 rate control decides which odfm rates to use so all of
them should be set enabled at the appropriate bit rate.

This means vnt_get_ofdm_rate is no longer required.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/card.c | 54 +++--------------------------------
 1 file changed, 4 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index dc3ab10eb630..4abbe9b30b65 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -100,48 +100,6 @@ static u16 vnt_get_cck_rate(struct vnt_private *priv, u16 rate_idx)
 	return RATE_1M;
 }
 
-/*
- * Description: Get OFDM mode basic rate
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
-static u16 vnt_get_ofdm_rate(struct vnt_private *priv, u16 rate_idx)
-{
-	u16 ui = rate_idx;
-
-	dev_dbg(&priv->usb->dev, "%s basic rate: %d\n",
-		__func__,  priv->basic_rates);
-
-	if (!vnt_ofdm_min_rate(priv)) {
-		dev_dbg(&priv->usb->dev, "%s (NO OFDM) %d\n",
-			__func__, rate_idx);
-		if (rate_idx > RATE_24M)
-			rate_idx = RATE_24M;
-		return rate_idx;
-	}
-
-	while (ui > RATE_11M) {
-		if (priv->basic_rates & (1 << ui)) {
-			dev_dbg(&priv->usb->dev, "%s rate: %d\n",
-				__func__, ui);
-			return ui;
-		}
-		ui--;
-	}
-
-	dev_dbg(&priv->usb->dev, "%s basic rate: 24M\n", __func__);
-
-	return RATE_24M;
-}
-
 /*
  * Description: Calculate TxRate and RsvTime fields for RSPINF in OFDM mode.
  *
@@ -289,20 +247,16 @@ void vnt_set_rspinf(struct vnt_private *priv, u8 bb_type)
 	vnt_calculate_ofdm_rate(RATE_24M, bb_type, &tx_rate[4], &rsv_time[4]);
 
 	/*RSPINF_a_36*/
-	vnt_calculate_ofdm_rate(vnt_get_ofdm_rate(priv, RATE_36M),
-				bb_type, &tx_rate[5], &rsv_time[5]);
+	vnt_calculate_ofdm_rate(RATE_36M, bb_type, &tx_rate[5], &rsv_time[5]);
 
 	/*RSPINF_a_48*/
-	vnt_calculate_ofdm_rate(vnt_get_ofdm_rate(priv, RATE_48M),
-				bb_type, &tx_rate[6], &rsv_time[6]);
+	vnt_calculate_ofdm_rate(RATE_48M, bb_type, &tx_rate[6], &rsv_time[6]);
 
 	/*RSPINF_a_54*/
-	vnt_calculate_ofdm_rate(vnt_get_ofdm_rate(priv, RATE_54M),
-				bb_type, &tx_rate[7], &rsv_time[7]);
+	vnt_calculate_ofdm_rate(RATE_54M, bb_type, &tx_rate[7], &rsv_time[7]);
 
 	/*RSPINF_a_72*/
-	vnt_calculate_ofdm_rate(vnt_get_ofdm_rate(priv, RATE_54M),
-				bb_type, &tx_rate[8], &rsv_time[8]);
+	vnt_calculate_ofdm_rate(RATE_54M, bb_type, &tx_rate[8], &rsv_time[8]);
 
 	put_unaligned(phy[0].len, (u16 *)&data[0]);
 	data[2] = phy[0].signal;
-- 
2.25.1
