Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD7249716
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 09:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgHSHY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 03:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHSHYN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50480C061342
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so20430046wrh.10
        for <linux-wireless@vger.kernel.org>; Wed, 19 Aug 2020 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vaZ+GprAhy2WYAM7ouom3T40mlyDiSFdzkYLUqEOnA=;
        b=YhK7+Gkgm60xh0/o16dYRkX3oK8trh5m0up4fYpP76ITHXS7Qvs+iz7mM/TtE/kt+C
         Uuftv5fopnYrIQaSajIr9ZIRXMfpkKvj7QrXOKYAWWKVRi9iFObahuDTC+kpGL91CGek
         RBYZGakNTHur0l17D+1PC5nI+cgyz2orPmCjyBdNe8uQ25T5tNYz6p9buAaOq0UN/TSY
         WIXkK0KhDL30pdN59/ns00DgoGnLf5o6pZ62zQx0YhcnlTYJ7CIlI+QcDghQwTnOuqaN
         NGrCgmC6/Z2u2axxK1T80a6o4llMhwkJNNy+qJMYsCTsobqlAgZ5dcQMVk/24EEKNUq/
         VSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vaZ+GprAhy2WYAM7ouom3T40mlyDiSFdzkYLUqEOnA=;
        b=PUwIPtSaucnlKD20QVulOWAeJxCZz08yW0rgYZy1TVuyUkLICAdhF4qMOsSqqZiLyP
         tr+K+eoCNxy4anUGf1FSHCyM96G61xUClaJsLDadA1OUC9bx7Jvrr80MfboT04MHXtYm
         lgVsKch7ZZ96BIVtxvcClcLdSWWO7M56yta2q+1vszUhb9tZbQ42d3bpwCpeT/owSk48
         /IB330lnbDgbiTj/QSeMUKfCWQUjiHXR6cbLmCyN3zD+4RvJBednTcJ5Qpe3yDLJrpDG
         OD0J9MeR5fB4TQnu1yJtPxRgmVF234hmGIvLuMidPgeTIDfQnnOK/87JDZvU66oY8B88
         WhnA==
X-Gm-Message-State: AOAM531zvl4QJ9gCtjF/YiR7EduDPu3xHyVBSoUn8ebFWjLHBuFV3Ha5
        OIajVsZk71w0g2HOnm/5fggA2w==
X-Google-Smtp-Source: ABdhPJwh4q+qWk7ffnlfepOmSFUtqSc9oXwvRWHyCij00qidVfOMj+GW8jr+2YbYNaQDA+dFBmihlQ==
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr23301717wrx.354.1597821850019;
        Wed, 19 Aug 2020 00:24:10 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 04/28] wireless: marvell: libertas_tf: Demote non-conformant kernel-doc headers
Date:   Wed, 19 Aug 2020 08:23:38 +0100
Message-Id: <20200819072402.3085022-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are only 2 kernel-doc headers in this file and both are
incorrect.  The first one does not attempt to document the function at
all and the second one is suffering from severe doc-rot; the format is
wrong and only 1 out of 3 parameters are being documented.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/marvell/libertas_tf/main.c:129: warning: Function parameter or member 't' not described in 'command_timer_fn'
 drivers/net/wireless/marvell/libertas_tf/main.c:554: warning: Function parameter or member 'card' not described in 'lbtf_add_card'
 drivers/net/wireless/marvell/libertas_tf/main.c:554: warning: Function parameter or member 'dmdev' not described in 'lbtf_add_card'
 drivers/net/wireless/marvell/libertas_tf/main.c:554: warning: Function parameter or member 'ops' not described in 'lbtf_add_card'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/marvell/libertas_tf/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 02bd7c99b3588..5937b645a5334 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -121,7 +121,7 @@ static void lbtf_cmd_work(struct work_struct *work)
 	lbtf_deb_leave(LBTF_DEB_CMD);
 }
 
-/**
+/*
  *  This function handles the timeout of command sending.
  *  It will re-send the same command again.
  */
@@ -542,11 +542,9 @@ int lbtf_rx(struct lbtf_private *priv, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(lbtf_rx);
 
-/**
+/*
  * lbtf_add_card: Add and initialize the card.
  *
- *  @card    A pointer to card
- *
  *  Returns: pointer to struct lbtf_priv.
  */
 struct lbtf_private *lbtf_add_card(void *card, struct device *dmdev,
-- 
2.25.1

