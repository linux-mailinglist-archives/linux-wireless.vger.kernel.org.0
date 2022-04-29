Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9795147F3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 13:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiD2LWX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 07:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiD2LWW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 07:22:22 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6585675
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 04:19:05 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23TBIQZL003504;
        Fri, 29 Apr 2022 20:18:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Fri, 29 Apr 2022 20:18:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23TBIPiV003500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Apr 2022 20:18:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3ec24824-00b6-4fc3-8bcf-71b9bbcb69c2@I-love.SAKURA.ne.jp>
Date:   Fri, 29 Apr 2022 20:18:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: [PATCH] ath9k: fix use-after-free read at ath9k_hif_usb_rx_cb()
Content-Language: en-US
To:     Toke Hoiland-Jorgensen <toke@toke.dk>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pavel Skripkin <paskripkin@gmail.com>
References: <00000000000055348705b43c701d@google.com>
Cc:     syzbot <syzbot+03110230a11411024147@syzkaller.appspotmail.com>,
        andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000055348705b43c701d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Although hif_dev->htc_handle is allocated by ath9k_htc_hw_alloc() from
ath9k_hif_usb_firmware_cb(), hif_dev->htc_handle->drv_priv is not assigned
until ieee80211_alloc_hw() from ath9k_htc_probe_device() from
ath9k_htc_hw_init() from ath9k_hif_usb_firmware_cb() returns. However, as
soon as ath9k_hif_usb_alloc_rx_urbs() from ath9k_hif_usb_alloc_urbs() from
ath9k_hif_usb_dev_init() from ath9k_hif_usb_firmware_cb() returns, a timer
interrupt can access hif_dev->htc_handle->drv_priv via RX_STAT_INC() from
ath9k_hif_usb_rx_stream() from ath9k_hif_usb_rx_cb() from
usb_hcd_giveback_urb(), which results in NULL pointer deference problem.

Also, even after htc_handle->drv_priv is assigned, when
ath9k_htc_wait_for_target() from ath9k_htc_probe_device() from
ath9k_htc_hw_init() from ath9k_hif_usb_firmware_cb() fails,
ieee80211_free_hw() (which does not reset hif_dev->htc_handle->drv_priv)
is immediately called due to "goto err_free;". As a result, a timer
interrupt which happens after ieee80211_free_hw() triggers use-after-free
problem at the abovementioned location.

We can flush in-flight requests by calling ath9k_hif_usb_dealloc_urbs()
before calling ieee80211_free_hw(). But we need to take from two choices
for not yet assigned case. One is to change e.g. RX_STAT_INC() to check
for NULL because it depends on CONFIG_ATH9K_HTC_DEBUGFS=y. The other is to
assign a dummy object which is used until initialization. This patch took
the latter.

Link: https://syzkaller.appspot.com/bug?extid=03110230a11411024147
Reported-by: syzbot <syzbot+03110230a11411024147@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+03110230a11411024147@syzkaller.appspotmail.com>
---
Pavel Skripkin has tested "check for NULL" approach, but not yet accepted.
What was wrong with Pavel's approach?

 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 6 +++---
 drivers/net/wireless/ath/ath9k/htc_hst.c      | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index ff61ae34ecdf..e497a44aff88 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -931,7 +931,6 @@ static int ath9k_init_device(struct ath9k_htc_priv *priv,
 int ath9k_htc_probe_device(struct htc_target *htc_handle, struct device *dev,
 			   u16 devid, char *product, u32 drv_info)
 {
-	struct hif_device_usb *hif_dev;
 	struct ath9k_htc_priv *priv;
 	struct ieee80211_hw *hw;
 	int ret;
@@ -969,10 +968,11 @@ int ath9k_htc_probe_device(struct htc_target *htc_handle, struct device *dev,
 
 err_init:
 	ath9k_stop_wmi(priv);
-	hif_dev = (struct hif_device_usb *)htc_handle->hif_dev;
-	ath9k_hif_usb_dealloc_urbs(hif_dev);
+	ath9k_hif_usb_dealloc_urbs((struct hif_device_usb *)htc_handle->hif_dev);
 	ath9k_destroy_wmi(priv);
 err_free:
+	ath9k_hif_usb_dealloc_urbs((struct hif_device_usb *)htc_handle->hif_dev);
+	htc_handle->drv_priv = NULL;
 	ieee80211_free_hw(hw);
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index 994ec48b2f66..d461eca389ab 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -468,6 +468,9 @@ void ath9k_htc_rx_msg(struct htc_target *htc_handle,
 	}
 }
 
+/* A dummy object used until device is initialized. */
+static struct ath9k_htc_priv ath9k_uninitialized_htc_priv;
+
 struct htc_target *ath9k_htc_hw_alloc(void *hif_handle,
 				      struct ath9k_htc_hif *hif,
 				      struct device *dev)
@@ -493,6 +496,8 @@ struct htc_target *ath9k_htc_hw_alloc(void *hif_handle,
 
 	atomic_set(&target->tgt_ready, 0);
 
+	target->drv_priv = &ath9k_uninitialized_htc_priv;
+
 	return target;
 }
 
-- 
2.34.1


