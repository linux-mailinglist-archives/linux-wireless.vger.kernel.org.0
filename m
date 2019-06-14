Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 620B846580
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 19:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFNRRU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 13:17:20 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:45090 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNRRT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 13:17:19 -0400
Received: by mail-yb1-f201.google.com with SMTP id y3so3391585ybg.12
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PfqzR6OCJuShUbiIZxhM7dStAsUG2Yzxrzdg+ytHsmg=;
        b=SdJx5Sno739AYIvhyoAQWdwlLaTV0qZ/Z8oxt8cXTHYNWosTV5yjnKAP5MXP4Q7zp6
         DM7EC/z7zMR71UIi6pm2oe5mPZVGCApReiP2mmd22fHXYk8gpVinxY7T0/OewUrpRIP7
         5kTOlYELQyNI9ZrZDdZDStoQt5s+y87UCMlVAIpbv2o4DqZSg9JTMggBGK6+G3eoTxfr
         274X9YibUaw1b2NYWuRwMcE5v1cWAa3LQKWZ7GmBfipWWHTM54oKOKSaSxbBuYJn3nlx
         tcfUlgc+OohLEv6JHJMljgg9ICqHAlKxo9HRrmsEcCVDEZcmwqx6FJXMxkEfI4DYs9BX
         pIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PfqzR6OCJuShUbiIZxhM7dStAsUG2Yzxrzdg+ytHsmg=;
        b=GEzPT3vST2MxF+9razsSRUyZ4tNR+c4cFJmoGEuGG/1VTXfq5Q31qhoIfGJK9nx+09
         7kGb7CZV06TpoMLsGTC2D3TrVIT/7p2TeSpqQIB4iUJx6zelw01E/BhMmn2W6M3lu1g3
         QOrU/hqwNhlHdw0eddd7XXixpNp7MUT9GxbyK70eVjlKEDkq0FbtNk15WRiHBRvVsOd9
         zQMP1LW+zKHIbscLkeRzaOyvzSNrZtZRMvhwDIV1Uye1S03D94ltZ2udiEMjE3NC03Mx
         tVk3V9vkUvx/Pyb1oeS15bmGE76YwcrysNnnQcOU1hif6dGcD4QnrJ56njBleFSfHzdV
         6sMA==
X-Gm-Message-State: APjAAAV8sICs7Dy6rU22oBJjmcr1VQZTKVhcVNS7suIDAxYoKH5W32/6
        e4SUSF0VTeyeTMSNAuKR2Pikg6fZJw==
X-Google-Smtp-Source: APXvYqwLFAxUgSeBg3lvZMfRSmKuSjWUy8qirfzUU6CTl88j+9AZEYIsfuCvJz9VcPkMGE1FsynuM3i3DQ==
X-Received: by 2002:a0d:da84:: with SMTP id c126mr11206949ywe.133.1560532637768;
 Fri, 14 Jun 2019 10:17:17 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:17:13 -0700
Message-Id: <20190614171713.89262-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] wl18xx: Fix Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Clang produces the following warning

drivers/net/wireless/ti/wl18xx/main.c:1850:43: warning: unused variable
'wl18xx_iface_ap_cl_limits' [-Wunused-const-variable] static const struct
ieee80211_iface_limit wl18xx_iface_ap_cl_limits[] = { ^
drivers/net/wireless/ti/wl18xx/main.c:1869:43: warning: unused variable
'wl18xx_iface_ap_go_limits' [-Wunused-const-variable] static const struct
ieee80211_iface_limit wl18xx_iface_ap_go_limits[] = { ^

The commit that added these variables never used them. Removing them.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/530
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/net/wireless/ti/wl18xx/main.c | 38 ---------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/net/wireless/ti/wl18xx/main.c b/drivers/net/wireless/ti/wl18xx/main.c
index a5e0604d3009..0b3cf8477c6c 100644
--- a/drivers/net/wireless/ti/wl18xx/main.c
+++ b/drivers/net/wireless/ti/wl18xx/main.c
@@ -1847,44 +1847,6 @@ static const struct ieee80211_iface_limit wl18xx_iface_ap_limits[] = {
 	},
 };
 
-static const struct ieee80211_iface_limit wl18xx_iface_ap_cl_limits[] = {
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_STATION),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_P2P_CLIENT),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_P2P_DEVICE),
-	},
-};
-
-static const struct ieee80211_iface_limit wl18xx_iface_ap_go_limits[] = {
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_STATION),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_P2P_GO),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_P2P_DEVICE),
-	},
-};
-
 static const struct ieee80211_iface_combination
 wl18xx_iface_combinations[] = {
 	{
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

