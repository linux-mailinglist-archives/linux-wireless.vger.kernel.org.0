Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E072975C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 12:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjFIKsz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjFIKsy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 06:48:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C59E
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 03:48:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30e57e0a0c7so1124472f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jun 2023 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686307731; x=1688899731;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h404KYyxPqBgdsZFQTSqrIFdDjIjrnyWGpNK6shhs8c=;
        b=T5pzOVJf1wSan8hg1huNkSKWU1tlZJ+b9/U451RG7XIKSClXBjAMLDFetpf3edH3fz
         su5xU8d3wpy1TEjCXZ3siGDoRDd/1jmoU0eiqX2qmNNetgcFNxb9dGKv++S2o5nIwlZ6
         BDLl4fgEr/YZXzAE/PnymQATUaRfECCQXQyHSzqQZJ14wY0O0a9b4ZWCVTr5h0/7CvKl
         xsUGgOGzrEg8cj1ITQFlM5vury/tfP87vrIeOTcf39Oaaoz2zjn5zEmASj/xKY5M4Ety
         JKIYl+rI63XsrLUMlaeSyJQOkWRCGWyds5bCrtdFJMZutSafmJmFHJMA7ug/mxcfLVNH
         SF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686307731; x=1688899731;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h404KYyxPqBgdsZFQTSqrIFdDjIjrnyWGpNK6shhs8c=;
        b=ET2K/A7Cq6Z75GFAs3HnJQ1wMJCGGbEP+5Pn0xgCh6RmVRXNfWXniI6Bcwym8lumyP
         RtFv2gBrlha3ubvA8Fjs0rYa90x07y10G47DCyPHgjcYYGrdnKi94gRNuVsvxBGD2GrW
         TQ1X6CVJlQdujgKPx/VQQcj+E6VbRrfKJx/ToDsOi0o69nnG0ZSFlYmNE0Xh7Rv/CPQN
         LjR1scCQlGPXomNrwDlofuZjP7WiBloadXWe4SjXTKn+8xHE02TdYuZXKWWjibH+/BDR
         baZufYHy3vPOHOMFLEA3me2ucBTW/bf8lJpmxMEag5YvTcd+MjUJGdac3G/JQIzG3FF1
         5r0g==
X-Gm-Message-State: AC+VfDxkXlDTyD+TVfLEUIOEXqxV88N/Ze2IC5T43KpRnYOKhAvBj3Y0
        /cv2Nr5YTey3rgzcFY5S1rKNfw==
X-Google-Smtp-Source: ACHHUZ6fr5fp42SB4k5MPauPJ85Z9R6r45D01KOEIoJHHP9tkYY/LNVl7bPHVHQKgdrmOGkZuuybLg==
X-Received: by 2002:adf:fe8c:0:b0:30a:b0e7:34b with SMTP id l12-20020adffe8c000000b0030ab0e7034bmr646219wrr.66.1686307731386;
        Fri, 09 Jun 2023 03:48:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d6-20020adffd86000000b0030ae87bd3e3sm4112507wrr.18.2023.06.09.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 03:48:49 -0700 (PDT)
Date:   Fri, 9 Jun 2023 13:48:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: fix double lock bug in reg_wdev_chan_valid()
Message-ID: <40c4114a-6cb4-4abf-b013-300b598aba65@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The locking was changed recently so now the caller holds the wiphy_lock()
lock.  Taking the lock inside the reg_wdev_chan_valid() function will
lead to a deadlock.

Fixes: f7e60032c661 ("wifi: cfg80211: fix locking in regulatory disconnect")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/wireless/reg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 949e1fb3bec6..26f11e4746c0 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2404,11 +2404,8 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 		case NL80211_IFTYPE_P2P_GO:
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
-			wiphy_lock(wiphy);
 			ret = cfg80211_reg_can_beacon_relax(wiphy, &chandef,
 							    iftype);
-			wiphy_unlock(wiphy);
-
 			if (!ret)
 				return ret;
 			break;
-- 
2.39.2

