Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C702A296B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgKBLYb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgKBLY2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:28 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9FEC061A04
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:27 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b8so14173322wrn.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ka6oG61s56uSi20zjZOTu4QIASes47AodXCRjQdroWM=;
        b=hMv2NTjPlHuthCM9UUVLtzFXjBs0VVOim6KBb8hepefDkfx8HzOilWlHKbADVy53mR
         HrEsOllfzBNwQjIS3Dh+EbIZ1PvdU59dmYvHGGxhd/2SqsjmHoprnfFu3yr57tWm7XoW
         Ms+zcnJpt9oSSip1LfExS2m283N63Hv6W5fd/dJqNJGmVsOHadtbd1r2Ul+hTzSNj8S3
         naUiQkmhngjJQOyopaca7rZWYr4PIwZ8Q+2r/jJADgklPXfkTmAQuTyTim4vgwsHKrvv
         ucUC4UQNMG2Lt5mLhIBQTpR+hpL69TtgFledAviFxkpcqXS78yROoHlrCNWJkGoYyREw
         bytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ka6oG61s56uSi20zjZOTu4QIASes47AodXCRjQdroWM=;
        b=V+C+6Qahnue729oWShfuqC7A22s0aBWEY6Pi/rrV+hv6YQaUDaybRxJLIvR2/fV123
         PtKpgApuJ5VQirwpaHEh9NXFT0tnj1A0tJkw3zHXOynsZqMbCmmQaVw8oj7wymyANui3
         WRjotYye8Feaz7d3rJ/86LrhBmOBJcrlbxoxnbfGFeY8zPzeTo0oOfuIJ9Y99xDYqGEW
         p8kM9agwDrMOS3Yu92vRsyZfsh5vYc6M4K1UGcN4yNwe5eCc25YRNyCsE3TJ2heeujZM
         AnR4mTdJRuVa0ub60zIeJrhFPdVON0MdhODXKVuVlGgiQ8OKW/BcqFmFMY0E/UbLW/ZK
         pFCQ==
X-Gm-Message-State: AOAM530fA1emSKf3V0f14tFgHOmQeEQiQolC09KQiHCs4U35YnOcOsue
        SXQjxUEouXZ0+N/IW+0NLULClg==
X-Google-Smtp-Source: ABdhPJxeqB5NmAXe81Eexs63FfVCwNj4sGmOhyU4D4wEPt10+eqOdNq7ow/T47NsthmDxpFZzShvSQ==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr19555994wrn.362.1604316266442;
        Mon, 02 Nov 2020 03:24:26 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 07/41] brcmfmac: pcie: Provide description for missing function parameter 'devinfo'
Date:   Mon,  2 Nov 2020 11:23:36 +0000
Message-Id: <20201102112410.1049272-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c:766: warning: Function parameter or member 'devinfo' not described in 'brcmf_pcie_bus_console_read'

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 39381cbde89e6..1d3cc1c7c9c50 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -759,6 +759,7 @@ static void brcmf_pcie_bus_console_init(struct brcmf_pciedev_info *devinfo)
 /**
  * brcmf_pcie_bus_console_read - reads firmware messages
  *
+ * @devinfo: pointer to the device data structure
  * @error: specifies if error has occurred (prints messages unconditionally)
  */
 static void brcmf_pcie_bus_console_read(struct brcmf_pciedev_info *devinfo,
-- 
2.25.1

