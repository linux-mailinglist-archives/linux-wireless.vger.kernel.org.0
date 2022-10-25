Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3C60D597
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 22:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiJYUez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Oct 2022 16:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJYUev (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Oct 2022 16:34:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1B31204
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 13:34:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso71365pjg.5
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grIJtsumq7xZtYBcKAeImmLQxyvLrRWBXYMypcdwKuA=;
        b=ecqZD1ooxs6OdAZoL/ziXFAfQcHgI+q3P+DLHNXxiAec79g54wSlov1ng+lgIAlVw/
         VOzYuAt8c+C44huDO7yrN3bmO2c7d4dl5Svc0GFWrOE5s49MM9OpZtgxsEPv21sqUdlY
         1vUbV3ILIpeicjsqlx7c3qcI3GZ6MsLzPjIkEH8LmpKGUzJ5CY/G5+L94SRnJ0cmQ+7P
         bmuLIBfSXejrHzWt64N/KPZu+jGJlLt9w8/ilEhMOeVtwAhRxDMZFRSCWD1OPNFG8mir
         Nux5nbfxkbJSqrcaYcePBPvgKHpteGUVcMMI3jM2hvcpWWWXxKBoSn1bE+xAICSuyx8V
         5Ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grIJtsumq7xZtYBcKAeImmLQxyvLrRWBXYMypcdwKuA=;
        b=ZGZHWXHkMqFnBSjS2Fg5ma5ThtxZv0WBJmBzkobYwH2NOSH0267ouiXR0jTIUVkBDx
         A6ipjn46iRIvu9D3pTjIGm/zt5L5WkTmPiAprS+agagCIhKNcxxpK4mp2GK8ns6gWL7z
         PJtCsHYlTaAKoKNQuKCKaZ/z81VlRMMw/zhIraHgbC1KAbllUpyc0BP7tN/RZ3JGiYBS
         g9/5G288L1a9mInVU196qnh197ZMzhS22nL0h7Sb9K4ND7rgG5qMuf9/CmNA5SkjH3RC
         pOw+aJ8QONm60+l3cpwWn7nUFRIGb69+mZez4Mfxv+RDTQoebQEqB2fMitOGi+EeYrOp
         P8VA==
X-Gm-Message-State: ACrzQf0EGQgyLxWXf+i1rPyavYh8CcHEHRcHuqfjpDUKEn8BmJp/xJS1
        q1ih9Xc0CVq5L/sTbCY+Mz/wG3WN6uQ=
X-Google-Smtp-Source: AMsMyM5Lwq5JM+w1mWOdL8/yY+r/JKT1uxXELu+xB+5bw9Se87d0gsUr7/7P9dTZdn6f6p4v+HrofA==
X-Received: by 2002:a17:90a:c78a:b0:212:e56b:2b17 with SMTP id gn10-20020a17090ac78a00b00212e56b2b17mr100839pjb.51.1666730088450;
        Tue, 25 Oct 2022 13:34:48 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id n22-20020a17090a161600b0020dd9382124sm5514731pja.57.2022.10.25.13.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:34:47 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] wifi: mac80211: handle connection loss in __ieee80211_disconnect
Date:   Tue, 25 Oct 2022 13:34:43 -0700
Message-Id: <20221025203443.410121-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221025203443.410121-1-prestwoj@gmail.com>
References: <20221025203443.410121-1-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ieee80211_connection_loss() can be called during times when the
kernels state is in flux, such as after a successful authentication
but prior to successful association. This can result in the kernel
never telling userspace due to __ieee80211_disconnect bailing out
if !ifmgd->associated. This has been seen out in the wild on
iwlwifi:

[503619.324379] wlan0: disconnect from AP d0:15:a6:70:e1:20 for new auth to d0:15:a6:70:b5:40
[503619.367204] wlan0: authenticate with d0:15:a6:70:b5:40
[503619.367233] wlan0: bad VHT capabilities, disabling VHT
[503619.367236] wlan0: Invalid HE elem, Disable HE
[503619.367237] wlan0: 80 MHz not supported, disabling VHT
[503619.371184] wlan0: send auth to d0:15:a6:70:b5:40 (try 1/3)
[503619.406401] wlan0: authenticated
[503620.270833] iwlwifi 0000:00:14.3: Not associated and the session protection is over already...
[503620.270943] wlan0: Connection to AP d0:15:a6:70:b5:40 lost

At this point userspace has received a CMD_AUTHENTICATE event but
nothing else. No disconnect or anything to indicate something is
wrong. Userspace supplicants expect _something_ to come after a
successful authentication.

This patch modifies __ieee80211_disconnect() to call
cfg80211_disconnect which will ultimately send a disconnect event
to userspace notifying it of the situation.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 net/mac80211/mlme.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fc764984d687..5c88cf717fb2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3270,6 +3270,11 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 
 	sdata_lock(sdata);
 	if (!ifmgd->associated) {
+		if (ifmgd->connection_loss)
+			cfg80211_disconnected(sdata->wdev.netdev,
+					      WLAN_REASON_UNSPECIFIED, NULL, 0,
+					      true, GFP_KERNEL);
+
 		sdata_unlock(sdata);
 		return;
 	}
-- 
2.34.3

