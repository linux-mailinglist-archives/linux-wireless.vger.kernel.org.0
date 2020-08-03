Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757B6239DA5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgHCDKx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgHCDKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B72C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so13013369wmi.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ombPAKmNa4Z6zut9RJcKKY/F0yxtyCaqxLuyUzdePk=;
        b=OP5OGP19qXV8Cyz+haelcC1eEkNq5GNBL8bAKpUhU5sCxJR5+00alX+tv8q9OdTjFv
         Qf960R9R6IO6gFfQVp4fsRNtHvmBXVFhSsNWj8i+BDX2TcoYCv52czsFdzDwsT9HYaaH
         du/4iE/CUEJTCxcwpOUgqhTopcbpiWR1fs1hVgag1oJAmZAh3dZJQGFKXc28g2rIcc9I
         f5b0jk/vpLfVoXuEQLPED1v2uKUScnymTM4IH5M8O9cSilvJOh88ul7BYEgQlclLt/wU
         zwuUW85ecC+U6VeQnGGWVhNNURDazagimWOKtVuaBsuB/U0iAfQj9pGVssAPx8o9JzPk
         FI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ombPAKmNa4Z6zut9RJcKKY/F0yxtyCaqxLuyUzdePk=;
        b=M9gSxjkYI62TKyWh7AEsIduLRetkR0q8w4hSaN3RNDP2rzTb0NZqRycaMeJUmaIJ5L
         h6ohmhh6dVZ8yxDDGmP6VBEudKDWGuC2W5pyvptH2przLCV90P44bW7tGTZyn5rwZcUZ
         cvP3kzS7VCAT0LYz0jyxy3o+yhWXUSXLmTk69D92SKin2JhvqG53wzG/tUm/Yl6C5bHR
         GxVNQSlsQM47ssggFwmHAzxQBkeslozFfr0C4LxYh/ABaABX6oc0KQ7KGB7B+xkJXfpu
         76DMizWLzQgLn2+Tg0JUXofVWRdQRB9ZxXE5VqcSCCRGQkWP/oJ/Jj/2Hpfj1lr2cyPs
         epzA==
X-Gm-Message-State: AOAM5318ldGEAnwKH2u95ZndeSKnwqgLs2w/91bNhPep3EB8ZoUzHU8A
        HooQ9uS2ikBMfvmGdh9vlwuXyg==
X-Google-Smtp-Source: ABdhPJzGY+/rlx5ixlRsoZ+RNNlnFy0gFEFPDt9JgaMAewIB/h083+UDE2rxifSb2HKXQt/mNX75KA==
X-Received: by 2002:a1c:6106:: with SMTP id v6mr13576442wmb.178.1596424250947;
        Sun, 02 Aug 2020 20:10:50 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:50 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 04/36] wcn36xx: Specify ieee80211_rx_status.nss
Date:   Mon,  3 Aug 2020 04:11:00 +0100
Message-Id: <20200803031132.1427063-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Specify the number of spatial streams in ieee80211_rx_status. For non VHT
data-rates the wireless core doesn't care about this field, however for VHT
data-rates it does.

Every version of wcn36xx has one spatial stream, so specify nss for
wcn3620, wcn3660 and wcn3680 now.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index 05a84f82584c..903b47b55728 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -272,6 +272,7 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 		status.bw = rate->bw;
 		status.rate_idx = rate->mcs_or_legacy_index;
 		sband = wcn->hw->wiphy->bands[status.band];
+		status.nss = 1;
 
 		if (status.band == NL80211_BAND_5GHZ &&
 		    status.encoding == RX_ENC_LEGACY &&
-- 
2.27.0

