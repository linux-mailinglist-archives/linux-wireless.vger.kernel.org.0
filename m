Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B19C7D541D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjJXOcl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjJXOck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 10:32:40 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C58DE8
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 07:32:37 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:150a:0:640:1aa5:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 0E02360A80;
        Tue, 24 Oct 2023 17:32:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3WPIMU8WnSw0-80AOf66O;
        Tue, 24 Oct 2023 17:32:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698157924; bh=U0/HJdvl6o1z+6yAXxaPEsSHWfhrLDe3b87cw+RbCBc=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=UZOJfV58iStRBJdm9mTqfavxg1EDMYy7dL2d5Zm68tyy9JZno3sEx5wMVbEH+2jdg
         MmD1L302dzlreHGCiqCiRER4Joex0f2aiGitgz7dqriEUvEBf91ce9KzN3i3eSy8dA
         inwmlwq9SKgnWfvp+0BamBQx3x3XH/j07OPFGSpg=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtw89: fix timeout calculation in rtw89_roc_end()
Date:   Tue, 24 Oct 2023 17:31:33 +0300
Message-ID: <20231024143137.30393-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'rtw89_core_tx_kick_off_and_wait()' assumes timeout
(actually RTW89_ROC_TX_TIMEOUT) in milliseconds, I suppose
that RTW89_ROC_IDLE_TIMEOUT is in milliseconds as well. If
so, 'msecs_to_jiffies()' should be used in a call to
'ieee80211_queue_delayed_work()' from 'rtw89_roc_end()'.
Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4bfb4188de72..15196f07b5c0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2886,7 +2886,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	if (hw->conf.flags & IEEE80211_CONF_IDLE)
 		ieee80211_queue_delayed_work(hw, &roc->roc_work,
-					     RTW89_ROC_IDLE_TIMEOUT);
+					     msecs_to_jiffies(RTW89_ROC_IDLE_TIMEOUT));
 }
 
 void rtw89_roc_work(struct work_struct *work)
-- 
2.41.0

