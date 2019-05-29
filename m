Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB42D455
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 05:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfE2DmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 23:42:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45398 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfE2Dl7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 23:41:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so421341pls.12;
        Tue, 28 May 2019 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X8QxQq4g8W7dGmXhhccM7yyb2O/8fX49JDeAOD3pN+Y=;
        b=uPgKQ/YlfmqKUomcGhwQixmDSqdg4VNOGMeeDtkz6OFtjsktbSqKu98GoLnZPFAtnC
         Wmq+Y45Z0XArv7OqVo9h0bAdinbtqrj8wiaNivWwfb5cwCUxcn8mIBPwx+ZiOEIVmQP3
         LlXReSxK5Qe3c5w9zwI6lT13Rmyd23GmhDQy6OILRHIQTSDY6w5WR9cXBZWwY1Qk41iL
         wX4gJxAkFW7cFgd1xp24j7otSIEMdUYSZCMBW/zSkN2jBLAOWw33rCgOznSvXu3jCMrM
         KCBaFXVZYsjpcqnsyue79DeXIV2tw/jzbjwSAB0nIu8ryadBhnwa2Y/m96yx9cyQMaJ8
         E4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X8QxQq4g8W7dGmXhhccM7yyb2O/8fX49JDeAOD3pN+Y=;
        b=bWGfXn50KF2bpGq4qyNWQWYtNXWdJGvw3qh2FYJbDT6JNiQLs8fPvUhotDD/L4cFNr
         Z7J06pa273fMRIrkqJOByy5wztbOpO4BF8xgnm20QjO9fBsRjYUiJHNqJmZDRPquOhJz
         XK9xNdBYsN4nBysY+KQ29TEfud2gVpY80TMdmhqahbf7SiamgVubSa9BQ3HIdopnOPve
         jVB9KNxYoYX8kUkhB4uf5s/wJfTJ8/NZFOdGIvp/lfWUUaYmxxoHvztM6w1AXB9Id2y4
         D2unsM1Hhu8nawTYo7dXrLC7d95ucN99Mse2fG2zywYWwiQnIR7Sb0uH1EHw0yqv88p8
         SE0g==
X-Gm-Message-State: APjAAAU9mSWSQsoeWMgiWJtRQBw+fngOuLCR9X5ltP6Y57RgkkTel3NY
        L8Cn914MJPQnxKm7+YWo05zT4J1dS3AwZg==
X-Google-Smtp-Source: APXvYqwRHjXZ9KC1rCB1uuwh/Y+RsuXHrHHL1N67yA/l/iLHkGxIslZEeP/um5EeRhA0LpPN2Rocsg==
X-Received: by 2002:a17:902:121:: with SMTP id 30mr9335600plb.314.1559101319130;
        Tue, 28 May 2019 20:41:59 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id s5sm23429464pgj.60.2019.05.28.20.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 20:41:58 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     sameo@linux.intel.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] NFC: microread/pn544: Fix possible null pointer deference error
Date:   Wed, 29 May 2019 11:43:06 +0800
Message-Id: <1559101386-26560-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When there is an access phy-hdev in pn544_hci_i2c_irq_thread_fn or
microread_i2c_irq_thread_fn, it is not initialized in pn544_hci_i2c_probe
or microread_i2c_probe.

Therefore, we change the order of calling function xxx_probe and
request_threaded_irq, and add guard of phy->hdev in
xxx_i2c_irq_thread_fn function.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/nfc/microread/i2c.c | 19 +++++++------------
 drivers/nfc/pn544/i2c.c     | 16 ++++++++--------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/nfc/microread/i2c.c b/drivers/nfc/microread/i2c.c
index 1806d20..80fc6d5 100644
--- a/drivers/nfc/microread/i2c.c
+++ b/drivers/nfc/microread/i2c.c
@@ -212,7 +212,7 @@ static irqreturn_t microread_i2c_irq_thread_fn(int irq, void *phy_id)
 	struct sk_buff *skb = NULL;
 	int r;
 
-	if (!phy || irq != phy->i2c_dev->irq) {
+	if (!phy || !phy->hdev || irq != phy->i2c_dev->irq) {
 		WARN_ON_ONCE(1);
 		return IRQ_NONE;
 	}
@@ -257,6 +257,12 @@ static int microread_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, phy);
 	phy->i2c_dev = client;
+	r = microread_probe(phy, &i2c_phy_ops, LLC_SHDLC_NAME,
+			    MICROREAD_I2C_FRAME_HEADROOM,
+			    MICROREAD_I2C_FRAME_TAILROOM,
+			    MICROREAD_I2C_LLC_MAX_PAYLOAD, &phy->hdev);
+	if (r < 0)
+		return r;
 
 	r = request_threaded_irq(client->irq, NULL, microread_i2c_irq_thread_fn,
 				 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -266,21 +272,10 @@ static int microread_i2c_probe(struct i2c_client *client,
 		return r;
 	}
 
-	r = microread_probe(phy, &i2c_phy_ops, LLC_SHDLC_NAME,
-			    MICROREAD_I2C_FRAME_HEADROOM,
-			    MICROREAD_I2C_FRAME_TAILROOM,
-			    MICROREAD_I2C_LLC_MAX_PAYLOAD, &phy->hdev);
-	if (r < 0)
-		goto err_irq;
 
 	nfc_info(&client->dev, "Probed\n");
 
 	return 0;
-
-err_irq:
-	free_irq(client->irq, phy);
-
-	return r;
 }
 
 static int microread_i2c_remove(struct i2c_client *client)
diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index d0207f8..c9694c8 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -496,7 +496,7 @@ static irqreturn_t pn544_hci_i2c_irq_thread_fn(int irq, void *phy_id)
 	struct sk_buff *skb = NULL;
 	int r;
 
-	if (!phy || irq != phy->i2c_dev->irq) {
+	if (!phy || !phy->hdev || irq != phy->i2c_dev->irq) {
 		WARN_ON_ONCE(1);
 		return IRQ_NONE;
 	}
@@ -924,6 +924,13 @@ static int pn544_hci_i2c_probe(struct i2c_client *client,
 
 	pn544_hci_i2c_platform_init(phy);
 
+	r = pn544_hci_probe(phy, &i2c_phy_ops, LLC_SHDLC_NAME,
+			    PN544_I2C_FRAME_HEADROOM, PN544_I2C_FRAME_TAILROOM,
+			    PN544_HCI_I2C_LLC_MAX_PAYLOAD,
+			    pn544_hci_i2c_fw_download, &phy->hdev);
+	if (r < 0)
+		return r;
+
 	r = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 				      pn544_hci_i2c_irq_thread_fn,
 				      IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -933,13 +940,6 @@ static int pn544_hci_i2c_probe(struct i2c_client *client,
 		return r;
 	}
 
-	r = pn544_hci_probe(phy, &i2c_phy_ops, LLC_SHDLC_NAME,
-			    PN544_I2C_FRAME_HEADROOM, PN544_I2C_FRAME_TAILROOM,
-			    PN544_HCI_I2C_LLC_MAX_PAYLOAD,
-			    pn544_hci_i2c_fw_download, &phy->hdev);
-	if (r < 0)
-		return r;
-
 	return 0;
 }
 
-- 
2.7.4

