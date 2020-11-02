Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826E82A2907
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgKBLYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgKBLYr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:47 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA95C061A48
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:46 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so9019282wmg.3
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkVHgZnw6Lei6IsVvRK9pUiVE1+hhckfR+9Br4cSPrE=;
        b=ez8EvAVTfpRWg2qZDGdhqb/Q5VPr+2CBWNYKefZgSKiRQdlbzFY5DBhRXdmI82cUaA
         2czwr+KpxFVOjtVHTRFZgXcAsnrPwyB3rJLw4HgbQz5dg92LmGZf15kaL9q3giZU6UFw
         HrgplcJXd4XvX4dhc90Z574Ub5yVhFSMv0WzQWAiCVhBTX0sSieje52/UjU06zDJ/FDR
         eLABOmzs7OPq4xW/MwkA+62zbGUmkouD/4eDdPhpERK7B2ZWg9GUe2ZU+NSBaMpPrK+g
         y5qGtgwWP19jLcIpZfes4VfbXSo9ej37waV/ydOxGttqe+e+QNEb3+cg77RINw/PhDtp
         zd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkVHgZnw6Lei6IsVvRK9pUiVE1+hhckfR+9Br4cSPrE=;
        b=S2JDQBCaeuBp5AHdxmy2xy237TPhU1f5Vlp1oxPb4QZXrUtDwRLXAh3y5VRhX1z9G9
         AILYOsVfXQ+1CFNEEYOUPQS3HVDG0clkL0a1ORlCAUuiGmqkQOswhag7dK6YEeUzbpG7
         HAWfUcllN779wBAR+wGo0bcH9Y1ZqSNePfS39y31Cqzm6v1NdjgVymQKR51E4S6ybR+m
         MJMfVUWGY7UTj28kbkeXYb2CMaZHXSWP9f8TshrqZrnLdpVst/r29K3bJL9tUAUNOvop
         rm0s5w794bw8cJ4Y7+iDnpd0PucM+wlI0MX3iZC0ZXVp29NKip5IIbDukv8T4DZX1XEj
         mpNg==
X-Gm-Message-State: AOAM532odQS9BYKqMyosCAat4mSMI98Z1V6UQzAryYmFjSO70LKeN+Jl
        VfkUGY3T/GdI4hjGxxLkPK3aPA==
X-Google-Smtp-Source: ABdhPJy7cfrla+KZZUDcnIsAf21G3KKaAzT3Zj90a4wTrKPjr9zmiJQA4cos7MCxYFjuhOaNdLYJCg==
X-Received: by 2002:a1c:383:: with SMTP id 125mr17957165wmd.175.1604316285441;
        Mon, 02 Nov 2020 03:24:45 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 19/41] ath: regd: Provide description for ath_reg_apply_ir_flags's 'reg' param
Date:   Mon,  2 Nov 2020 11:23:48 +0000
Message-Id: <20201102112410.1049272-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/regd.c:378: warning: Function parameter or member 'reg' not described in 'ath_reg_apply_ir_flags'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/regd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/regd.c b/drivers/net/wireless/ath/regd.c
index bee9110b91f38..b2400e2417a55 100644
--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -360,6 +360,7 @@ ath_reg_apply_beaconing_flags(struct wiphy *wiphy,
 /**
  * ath_reg_apply_ir_flags()
  * @wiphy: the wiphy to use
+ * @reg: regulatory structure - used for country selection
  * @initiator: the regulatory hint initiator
  *
  * If no country IE has been received always enable passive scan
-- 
2.25.1

