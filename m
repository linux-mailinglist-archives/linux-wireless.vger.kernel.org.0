Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6780AD9C12
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2019 22:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbfJPU50 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Oct 2019 16:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbfJPU5Z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Oct 2019 16:57:25 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83D797FDC9
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 20:57:25 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id z128so24998973qke.8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2019 13:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBQ7gpZ68XC9yJUIRmvhGT9ykcxZ7LBo1PQ5kgI2O8M=;
        b=j3lSdJPfwLpm5NnQ/Kqvd9huegQhD3njpbhnJNzSkWvt9tWfeGG7SWF7N6Qfy6UT2l
         +0ZZ2Q6o0kSBmZyCPW2FsiL2myqzt2oJlHaBMosA7laJYtUt+CDjmYErHahxRLHpVXbC
         w1gAArUilceo/g4soJU763G3icZakoaqfElT2TLfOsTeAApfa0DbT7yypp/QZJfBNgC8
         dAUqu5tcS+qUS7Xwa2U3fG9Jkid2YeJpuWKSqSEXxwfVrZmqaTU2nHTiqUxF8f3o2in3
         1Y2WRenhBwFCL5ySmDZsmsENESBGl0g0rw605cNwgb/5LJJJS7Q9jnP28uxT5+Mp/wT/
         yAtA==
X-Gm-Message-State: APjAAAXmy4/e0bWiZlxn80D9usjzHZGiKxu2h/bTZoJs2A5kd6qfY6z3
        OBbCcuon3D+SgDIUcMqwMB/aqrVv8z5PeYIZOHxXiXpz/8DB4laKfizNgJtqkv0ji4rnRS04+eB
        oS5cTYQbkSOHqlxxIW7r2ykXar2s=
X-Received: by 2002:a0c:eda9:: with SMTP id h9mr30854qvr.125.1571259444744;
        Wed, 16 Oct 2019 13:57:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtZQ1p9uv2sCQ5sckBZmJmAmvdBRNeFuMdkuR0mLRWv2XsHKm8h8LAyLgrLZlCxrCo9UBhpQ==
X-Received: by 2002:a0c:eda9:: with SMTP id h9mr30831qvr.125.1571259444351;
        Wed, 16 Oct 2019 13:57:24 -0700 (PDT)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id 16sm26966qkj.59.2019.10.16.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:57:23 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolas Waisman <nico@semmle.com>
Subject: [PATCH] rtlwifi: Fix potential overflow on P2P code
Date:   Wed, 16 Oct 2019 16:57:16 -0400
Message-Id: <20191016205716.2843-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nicolas Waisman noticed that even though noa_len is checked for
a compatible length it's still possible to overrun the buffers
of p2pinfo since there's no check on the upper bound of noa_num.
Bounds check noa_num against P2P_MAX_NOA_NUM.

Reported-by: Nicolas Waisman <nico@semmle.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Compile tested only as this was reported to the security list.
---
 drivers/net/wireless/realtek/rtlwifi/ps.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index 70f04c2f5b17..c5cff598383d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -754,6 +754,13 @@ static void rtl_p2p_noa_ie(struct ieee80211_hw *hw, void *data,
 				return;
 			} else {
 				noa_num = (noa_len - 2) / 13;
+				if (noa_num > P2P_MAX_NOA_NUM) {
+					RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+						 "P2P notice of absence: invalid noa_num.%d\n",
+						 noa_num);
+					return;
+				}
+
 			}
 			noa_index = ie[3];
 			if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode ==
@@ -848,6 +855,13 @@ static void rtl_p2p_action_ie(struct ieee80211_hw *hw, void *data,
 				return;
 			} else {
 				noa_num = (noa_len - 2) / 13;
+				if (noa_num > P2P_MAX_NOA_NUM) {
+					RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
+						 "P2P notice of absence: invalid noa_len.%d\n",
+						 noa_len);
+					return;
+
+				}
 			}
 			noa_index = ie[3];
 			if (rtlpriv->psc.p2p_ps_info.p2p_ps_mode ==
-- 
2.21.0

