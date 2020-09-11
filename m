Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493DC265A38
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 09:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgIKHOn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 03:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgIKHOm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 03:14:42 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71EC061573;
        Fri, 11 Sep 2020 00:14:42 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t20so7076159qtr.8;
        Fri, 11 Sep 2020 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WIC+w8cci/CjHq4Rlp9g5LGl+w5+e9ru3XkhCS9HFuc=;
        b=TyOwSiafxbsI2YHXi9yv1z2Iv9zTCW2mQrrVv67q0USjGc0/aIA5yaVO6yFHRcGbtg
         S/mCZQ1rCoIIEIoHf6E/e6gp/3q7NDHHhvmXdmtn+lJaG7N/A5aisZALfZMR/hlaWkik
         Lk6bTOTF0+qwmYrUTeT8lxTQkpS6fiDp8CT7cah5XyLqWPu8I63F4U5a30lF8JHf5ZuV
         sEvl/KCU28qNtkR4QFnTPP1aOFQSlhXjGdsbHy/HZgydkIy0pAT1+yhSTRgd3YBSRgGu
         3V7DF3OYCxpnTEfZwW0BGTFlMiLbRKZJZug0Pn88RJRWX4eFjoVueGXn2bOdSpjttnM+
         EBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WIC+w8cci/CjHq4Rlp9g5LGl+w5+e9ru3XkhCS9HFuc=;
        b=ejRfa7FMq4mpqWGuNSWZNTudCo6Dn53+VVmaQ7mwDrJJNrrdtmFchBetgZTVtbDk9o
         Vya/eehorGn+zPh/LdS6PREm82M40U5bU6v3OSmYX1e0ti9aI/TSx+gM2GZK4EvfCdzb
         IwddBOfyfmlQ8jpKuDFk9EpNheOFbfxyXkPP84fXOD96x4ZJL2lP5aDVkd9AV/Ug2xoy
         EKtZAGupSOUVpuXX7F362WS470yfKQWxRWsb6hVhdNKZfaFvxTnbAVl4uULTQopbJcBn
         YCIft5f1z8SxlW+b3sqGT1cUuH/88UYb17wsksYvSbfRuvLJoBXv4GVNXtzmL8+F198B
         Qn1w==
X-Gm-Message-State: AOAM530zY0ad/hnsUY6inHDY7sA5vAGtwgsXUEdz/zG7lsboqhVmUxAo
        0GwUJLYL/YMAoBVri/uwNeM=
X-Google-Smtp-Source: ABdhPJzldrodFvp6XswLy0oZ4aLaQXxfe+q4ZM5piA/s39ouMgvrlkl9hJI+ZoTIBaBL2IlulsOfBA==
X-Received: by 2002:ac8:178d:: with SMTP id o13mr656506qtj.103.1599808481565;
        Fri, 11 Sep 2020 00:14:41 -0700 (PDT)
Received: from seraph.myfiosgateway.com (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id l19sm1572318qtu.16.2020.09.11.00.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 00:14:41 -0700 (PDT)
From:   Brooke Basile <brookebasile@gmail.com>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        syzkaller-bugs@googlegroups.com,
        Brooke Basile <brookebasile@gmail.com>,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com
Subject: [PATCH] wireless: ath9k: hif_usb: fix race condition between usb_get_urb() and usb_kill_anchored_urbs()
Date:   Fri, 11 Sep 2020 03:14:27 -0400
Message-Id: <20200911071427.32354-1-brookebasile@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Calls to usb_kill_anchored_urbs() after usb_kill_urb() on multiprocessor
systems create a race condition in which usb_kill_anchored_urbs() deallocates
the URB before the completer callback is called in usb_kill_urb(), resulting
in a use-after-free.
To fix this, add proper lock protection to usb_kill_urb() calls that can
possibly run concurrently with usb_kill_anchored_urbs().

Reported-by: syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=cabffad18eb74197f84871802fd2c5117b61febf
Signed-off-by: Brooke Basile <brookebasile@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 3f563e02d17d..2ed98aaed6fb 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -449,10 +449,19 @@ static void hif_usb_stop(void *hif_handle)
 	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);

 	/* The pending URBs have to be canceled. */
+	spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
 				 &hif_dev->tx.tx_pending, list) {
+		usb_get_urb(tx_buf->urb);
+		spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
 		usb_kill_urb(tx_buf->urb);
+		list_del(&tx_buf->list);
+		usb_free_urb(tx_buf->urb);
+		kfree(tx_buf->buf);
+		kfree(tx_buf);
+		spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 	}
+	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);

 	usb_kill_anchored_urbs(&hif_dev->mgmt_submitted);
 }
@@ -762,27 +771,37 @@ static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
 	struct tx_buf *tx_buf = NULL, *tx_buf_tmp = NULL;
 	unsigned long flags;

+	spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
 				 &hif_dev->tx.tx_buf, list) {
+		usb_get_urb(tx_buf->urb);
+		spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
 		usb_kill_urb(tx_buf->urb);
 		list_del(&tx_buf->list);
 		usb_free_urb(tx_buf->urb);
 		kfree(tx_buf->buf);
 		kfree(tx_buf);
+		spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 	}
+	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);

 	spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 	hif_dev->tx.flags |= HIF_USB_TX_FLUSH;
 	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);

+	spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
 				 &hif_dev->tx.tx_pending, list) {
+		usb_get_urb(tx_buf->urb);
+		spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
 		usb_kill_urb(tx_buf->urb);
 		list_del(&tx_buf->list);
 		usb_free_urb(tx_buf->urb);
 		kfree(tx_buf->buf);
 		kfree(tx_buf);
+		spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
 	}
+	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);

 	usb_kill_anchored_urbs(&hif_dev->mgmt_submitted);
 }
--
2.28.0

