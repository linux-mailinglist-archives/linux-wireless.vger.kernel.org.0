Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80124CEFA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgHUHUo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgHUHSM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E7C06137B
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so1011772wrl.4
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1SwOdl3qsamQLekmEElFc9JqMKayOsDgTAbLZhvVikk=;
        b=dnImnfFjiDNFfYpg8z5tV2sLsHw86tH7Jc+5orDMUB1MplgaOUwBUiMJ0coiV8t5Kd
         Or89x62EZ7WSqJVpjl7E99tdGFe+lsMtoIH10bCg02O6sO49kSY4rsdAdJVbVlh3TD0n
         DJyysjPrA0/1PGaxfT/LMg2NKe4hbmVZ+Yv9z6bnSvoFmfFGbGbwMYp1E6HayrUv2xtW
         HS9HkdRvxF/37JBgu/O0LgLDthdxhBLW/LweO6uEmAJCnyLhN5NGgZPAYZJvboD4IxOm
         LVzeDQJpHAr3qxOYXxUm78DPtzRAOJKYRfIJOQviyRNQq8V7nG85PDxgJkyPVNN9xHsL
         77cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SwOdl3qsamQLekmEElFc9JqMKayOsDgTAbLZhvVikk=;
        b=tMxEwOyPudFTbCnbrE8mD1560M61jaURTl9bhMXq54H2OBpV44/XSuldasE6AXLB0K
         qGStu821GqheaUCta5w6LKkpHrk6hAxQNrvZA5BOB95FTwzxROS5uw8z4Nk5FuhuCsm9
         p+qUcLepUuWrET/W/hDoCM2CMOEMjVHBkcv3yZnrT7ubhcOVLxmDQbdA3iZxaOLixKRh
         lnCpQWYguACdhVVRMk+D9SIEFVyT11ea9uZsJMDgELJ3Y8AZTptCxIyWbVzoyIc8gptQ
         h5FDP3JTjukIHrjUr53qeJ0f38IP9p+xJg8uSOs/CvuPyE/ZUsvbIAMM79ZBeGmgI2+c
         MM7Q==
X-Gm-Message-State: AOAM530nbP3mVxOOEn19LJQNGWZttLnOOoD8KChAmMtIFumWp6S8BQ8f
        pq1Z/cCNl3UHDTxVRusNFtNS4A==
X-Google-Smtp-Source: ABdhPJzJi0T0vD0alFijUDBN82QjCRhNnnHBSeBmNRlzlDy6K5aaLeA4aB21h/7nMVFAL/QHiEZKmA==
X-Received: by 2002:a5d:526d:: with SMTP id l13mr1324804wrc.279.1597994238166;
        Fri, 21 Aug 2020 00:17:18 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Subject: [PATCH 24/32] wireless: brcmfmac: fwsignal: Remove unused variable 'brcmf_fws_prio2fifo'
Date:   Fri, 21 Aug 2020 08:16:36 +0100
Message-Id: <20200821071644.109970-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:504:18: warning: ‘brcmf_fws_prio2fifo’ defined but not used [-Wunused-const-variable=]

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 2df6811c066ef..902b2f65d4605 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -498,20 +498,6 @@ struct brcmf_fws_info {
 	bool avoid_queueing;
 };
 
-/*
- * brcmf_fws_prio2fifo - mapping from 802.1d priority to firmware fifo index.
- */
-static const int brcmf_fws_prio2fifo[] = {
-	BRCMF_FWS_FIFO_AC_BE,
-	BRCMF_FWS_FIFO_AC_BK,
-	BRCMF_FWS_FIFO_AC_BK,
-	BRCMF_FWS_FIFO_AC_BE,
-	BRCMF_FWS_FIFO_AC_VI,
-	BRCMF_FWS_FIFO_AC_VI,
-	BRCMF_FWS_FIFO_AC_VO,
-	BRCMF_FWS_FIFO_AC_VO
-};
-
 #define BRCMF_FWS_TLV_DEF(name, id, len) \
 	case BRCMF_FWS_TYPE_ ## name: \
 		return len;
-- 
2.25.1

