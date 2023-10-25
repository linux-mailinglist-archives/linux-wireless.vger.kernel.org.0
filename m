Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6877D5F0F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 02:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbjJYA2a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 20:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344743AbjJYA23 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 20:28:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1AD7D
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 17:28:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so5042326b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1698193708; x=1698798508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf/mJKG+cM9PUZ37Ntd+jIGUOXThng+0dMJXTU4/tlk=;
        b=jN/FJ9HsvcV8MWJpTt2qEbd6BaeL6n9sWD0x4wMogV5w97FinLBxgiFQ9elcwqqAox
         PdbQJvNJUtIAMq9yiaIZYcayKX6zBw/HfXDraXJg9Ctqti1JiL6+RlbgAgURrcBytcqS
         FfMbgUFDrcRrc45ruoi8dj2ik+qXoML5BkOudUVXnagxyWaVvi981OXVvn41YrATGCtQ
         jKsDhqw9fvuWKQ73X/9TawvLoI9wV8eAVEvZ12Vid38VaOkzIXmPxiQSpHiyW7UTKOwm
         BOY71ZPZTVb0ldP8fSe/vZzsQN4dtXtrVgnpPYjknA1iuHrH/hdoAy+6eFhh665mXxnG
         32LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193708; x=1698798508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf/mJKG+cM9PUZ37Ntd+jIGUOXThng+0dMJXTU4/tlk=;
        b=fhnC8D3yDUdM48in0fK0b37hvwjyLrLiR3sL7OhTb5ZEi8bTYxa4DFtGpVTiAxE787
         EWpdhkaOUGNgafZQSMhkPyR4LImvYlErBdjTwV4lsXfdAk38dfmL854kqcPLTd0akMPH
         SdGXJu72WMt+bGjKMoNQz4342mPkViW/1ggHcaaHsg7HKK9KK3e/zuTZ3qNJfaaXJD+O
         J5W2WzVf0lzhrg8u4VtGdm/X7NTlqvwn3GZZpUxqOoq35GFgyr2iKQAAKwwcl5wnbJGv
         2aY72WZLPwVztgZK+xmcxC6bgJYqzEpir3TFz74P6QTHWtSm5I0uHokwbWtArLMdBFnt
         DzXg==
X-Gm-Message-State: AOJu0YyNeFSPHN2IzzBSyX3bd0uQ6cs2gL+tk3SEyEBik+1UXzQa5z7d
        pu/eCPFGx+KFKNEVz4ENCHeSq8Hn8Y9cIIFZ8+ftkY/x
X-Google-Smtp-Source: AGHT+IGcVmUAzz3OZry2UaX+wsowBeGQJO5ZbMCYc7pEBYisQSTfrlftIjUww2p8YYAR0kzIJ7P7FQ==
X-Received: by 2002:a05:6a20:258e:b0:14c:3218:c1bd with SMTP id k14-20020a056a20258e00b0014c3218c1bdmr4730809pzd.11.1698193707731;
        Tue, 24 Oct 2023 17:28:27 -0700 (PDT)
Received: from liam-xps.sydney.mm.lcl (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.googlemail.com with ESMTPSA id ix21-20020a170902f81500b001c0a414695dsm7982258plb.62.2023.10.24.17.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:28:27 -0700 (PDT)
From:   Liam Kearney <liam.kearney@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     Liam Kearney <liam.kearney@morsemicro.com>,
        linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v3] wifi: ieee80211: fix PV1 frame control field name
Date:   Wed, 25 Oct 2023 11:27:55 +1100
Message-Id: <20231025002755.1752983-1-liam.kearney@morsemicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update PV1 frame control field TODS to FROMDS to match 802.11 standard

Signed-off-by: Liam Kearney <liam.kearney@morsemicro.com>
---
v3: add signed-off-by line missed in v2 
v2: update comment to reference 2020 version of the standard

include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index bd2f6e19c357..d8e878167385 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -172,11 +172,11 @@
 #define IEEE80211_SN_MODULO		(IEEE80211_MAX_SN + 1)
 
 
-/* PV1 Layout 11ah 9.8.3.1 */
+/* PV1 Layout IEEE 802.11-2020 9.8.3.1 */
 #define IEEE80211_PV1_FCTL_VERS		0x0003
 #define IEEE80211_PV1_FCTL_FTYPE	0x001c
 #define IEEE80211_PV1_FCTL_STYPE	0x00e0
-#define IEEE80211_PV1_FCTL_TODS		0x0100
+#define IEEE80211_PV1_FCTL_FROMDS		0x0100
 #define IEEE80211_PV1_FCTL_MOREFRAGS	0x0200
 #define IEEE80211_PV1_FCTL_PM		0x0400
 #define IEEE80211_PV1_FCTL_MOREDATA	0x0800
-- 
2.39.2

