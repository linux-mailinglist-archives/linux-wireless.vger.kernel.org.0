Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1305F48D229
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 07:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiAMGDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 01:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiAMGDn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 01:03:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43368C061751
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 22:03:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v48-20020a25abb3000000b006113ce63ed8so9228365ybi.22
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 22:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=rRyEFmS7punxeQqOoiys20soJGTAicrW1PQEVjtcuOA=;
        b=UC0FFRMh7o2iv/d1ZaJ/LghgsJZH08kcjGW6ZhhwJ4hbYSY6P+mQaFSJDBtkIeisxh
         dMYTFNE35bneVl2jeioGSk0VZpsNrNj5umTNHSo7/WfBdW43ivLDm0uSMRRiN1q+wk18
         KUO68aRriqBmEwRu1X2MJ4F7pNMwbp3x5cG1qIhUeqa4uGQsEkK4wE/8puOTljUSMwxF
         bvjGIA8CNa10xPaJBAYSDpATqlY2HMsAksMnBkY1N10KeVbcV58t0I67QfSbqlDyIHqi
         7HCGiemBUd4/oKlwlhieXx+3JMxbst/olfPkK+vw2Dy7LIHVwPax+YlCJeOetB0tNcwu
         eOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=rRyEFmS7punxeQqOoiys20soJGTAicrW1PQEVjtcuOA=;
        b=dmwhGkctBEFLsaMtcuuM4P5PGtJmPU0C0LK/U59Ifo+WTPizUaNXDfOTUrJ0h0ytlr
         pEGJ2RyC1RkBVVtM6/ic3WtklM/qB0to3Exl+55VrKGjvRXNIJcQxkveajgJmmFsO8wk
         14Jy6t1jCci61XB+QCx68vfFZV0Wlw+1Q1KUFiCpsAyrG98z90YqEwywXiKlldZKs30A
         v3nUUTVSKRp8cX0B7+eahnKXRmqo46BmX9ajzzq6XZWcpFAMxjsNw/kJTG3rZRlFAt7H
         2EExQ49Diz+D5VpsbcFqDuYrsUCAJCwuMWCgB9/rg+EfmcWo5+dLuA8pRUhXQaAGvZEK
         gyoA==
X-Gm-Message-State: AOAM532WASZVDP5tk7CKT2MB8+r5dTitXLXzZxCBDRukQ0UWKNoocPKs
        VM9mLnoTMwdztU3R4RXa6zVPuNWyyQY=
X-Google-Smtp-Source: ABdhPJxSiBZP+f3lo0Lf91MgLkH3gGGAomTSOZ3Jk/TA1UJ3E9WfxNaD7K60yMczdglZzeGoqktyox8bTi4=
X-Received: from jaeman.seo.corp.google.com ([2401:fa00:d:11:2232:d256:314c:979c])
 (user=jaeman job=sendgmr) by 2002:a05:6902:120f:: with SMTP id
 s15mr4571599ybu.390.1642053822522; Wed, 12 Jan 2022 22:03:42 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:02:35 +0900
Message-Id: <20220113060235.546107-1-jaeman@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] mac80211_hwsim: initialize ieee80211_tx_info at hw_scan_work
From:   JaeMan Park <jaeman@google.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        adelva@google.com, kernel-team@android.com,
        JaeMan Park <jaeman@google.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In mac80211_hwsim, the probe_req frame is created and sent while
scanning. It is sent with ieee80211_tx_info which is not initialized.
Uninitialized ieee80211_tx_info can cause problems when using
mac80211_hwsim with wmediumd. wmediumd checks the tx_rates field of
ieee80211_tx_info and doesn't relay probe_req frame to other clients
even if it is a broadcasting message.

Call ieee80211_tx_prepare_skb() to initialize ieee80211_tx_info for
the probe_req that is created by hw_scan_work in mac80211_hwsim.

Signed-off-by: JaeMan Park <jaeman@google.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 0307a6677907..95f1e4899231 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2336,6 +2336,13 @@ static void hw_scan_work(struct work_struct *work)
 			if (req->ie_len)
 				skb_put_data(probe, req->ie, req->ie_len);
 
+			if (!ieee80211_tx_prepare_skb(hwsim->hw,
+						      hwsim->hw_scan_vif,
+						      probe,
+						      hwsim->tmp_chan->band,
+						      NULL))
+				continue;
+
 			local_bh_disable();
 			mac80211_hwsim_tx_frame(hwsim->hw, probe,
 						hwsim->tmp_chan);
-- 
2.34.1.703.g22d0c6ccf7-goog

