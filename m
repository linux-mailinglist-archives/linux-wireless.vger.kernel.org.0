Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71465908FE
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiHKXNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Aug 2022 19:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiHKXNq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Aug 2022 19:13:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE5E90C52
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 16:13:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so6493546pjf.5
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 16:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cAmRLOTm/YIdX7Lx7jAm2pYzm8lrQiOwQoZv0peuAxs=;
        b=E+QLW/IAoTknWNSGflsbei9HSX/XT24kvAVQPmibPUOSKnHD6YGWvKOKjVI7MqmhwJ
         5Tp4tZUc5Yv7XXO4wOsvD9u/cXvkiKCYLMvCaid4d8jiy8y8RivPtlMMbH61frzxqPus
         7+0Hq19Z1s5NE35KYR79XGYJyJ12huXszs0fsjCYENzuwvboruvT0/o+x501xavdlQvl
         xGoz1F/1Lqmgo8z8Dok2ECSBfGHUU9Uqclww1dCI6uHQANn4ZJkSAnWcZiNl2Fsn9dSN
         1sksxXUMiP8VO14nQtY41yvZwW9A8tyg+r7u4EBdTIThHyXgr+9ez7+rEsUMp6luB4na
         ZWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cAmRLOTm/YIdX7Lx7jAm2pYzm8lrQiOwQoZv0peuAxs=;
        b=kTODXiBguGc2Y9EZYGscED6tBLRUcr3pYXoFKHf99N/fzHPW4yu6rTCK+MmqA2ZrMt
         lAV4kR2Ed4uVjXX3BhiqEuVUrcoe/BbB2iiXzGCATVUGxlJ1VFTL+OejrZ86dqaT4qck
         jaU6AHloz7BjFwlF5sof2UqqgIAvXYxlyZVNl5GtgdvuiGlVqnUL2rX3Wq/6bNKmqzSi
         qOj2M6il0rXaP16VIezXniZe5veBVnUYYYnasEf1U9kT+ffCle/lb2HiWh95t5xjUko2
         2AxAdLqTyhxvz7fchxze5eTKBdpXLH6q78I5fBagFiPLUYY7APXk/Mijqy9lQrjbNqie
         gOPw==
X-Gm-Message-State: ACgBeo3zqLUqW8985NSGTgBc2k+dX1lv9CfZ12Zhr3dgY28mu+m3ix/m
        mVAMuJ3GTJSWgkXZTNpwPePNf7RWrEs=
X-Google-Smtp-Source: AA6agR4jGGjP4dghu8DTJEq4S7OnEvMBQvYZm4R/dWS1NSP2/n0X3VWs8mjfCxa3ZlfUPsmbP0oe0w==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr1263072pjb.143.1660259624612;
        Thu, 11 Aug 2022 16:13:44 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0016d2db82962sm227644plg.16.2022.08.11.16.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:13:44 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] include: nl80211: Add POWERED_ADDR_CHANGE feature
Date:   Thu, 11 Aug 2022 16:13:37 -0700
Message-Id: <20220811231338.563794-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220811231338.563794-1-prestwoj@gmail.com>
References: <20220811231338.563794-1-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new extended feature bit signifying that the wireless hardware
supports changing the MAC address while the underlying net_device is
powered. Note that this has a different meaning from
IFF_LIVE_ADDR_CHANGE as additional restrictions might be imposed by
the hardware, such as:

 - No connection is active on this interface, carrier is off
 - No scan is in progress
 - No offchannel operations are in progress

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 include/uapi/linux/nl80211.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d9490e3062a7..57ead424a0c3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6174,6 +6174,14 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_RADAR_BACKGROUND: Device supports background radar/CAC
  *	detection.
  *
+ * @NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE: Device can perform a MAC address
+ *	change without having to bring the underlying network device down
+ *	first. For example, in station mode this can be used to vary the
+ *	origin MAC address prior to a connection to a new AP for privacy
+ *	or other reasons. Note that certain driver specific restrictions
+ *	might apply, e.g. no scans in progress, no offchannel operations
+ *	in progress, and no active connections.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6241,6 +6249,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BSS_COLOR,
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
 	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
+	NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.34.3

