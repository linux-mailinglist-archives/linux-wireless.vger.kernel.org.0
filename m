Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE2D2E93
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfJJQ06 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 12:26:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37092 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfJJQ05 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 12:26:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id u20so3043376plq.4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2019 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3L9d8Hq5e07DU4XHZuzPz1Kd0iVbIQrEZ53Rw3PFwc=;
        b=oMNG8OFlEGU3PWXGkW4uWbQiN1c4TgfEUV4U5ZaRnieGiVh9zJFF289MPunGMy0uQa
         seUQM8U2tTTWjYTuqnWM1hjDfz4EQSu6HMMR+BLW3eWSh4BlEZczW9TkQZKEJ/hk3f8b
         1JFjuInD9NbbsOx1TTAGItzyuIrtHBAw+AvyLljpiKbRSLyrTzWMOLnm4O599EaVohmY
         qyXHpkXA478RmdObxZO9bhYjjODG2+x1geIWOUjM1C4N9VKcwAJdm2FwBoPqZPyewoBt
         HCAcvkfg29toUTW1/GIlRSFNFLn9cq68xGT5V8C627JjNT5+CYI49sBWZkhztGviM0xZ
         RQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3L9d8Hq5e07DU4XHZuzPz1Kd0iVbIQrEZ53Rw3PFwc=;
        b=ceQrxpksGTIYoKIoxMP/+OO8v8cJUB4uLHUeXZaE5bkARoI/gsg7ytB9S22dev5nbS
         vHQD3pnEIZWhMvvQlHtO5yaIzm2+4r3L3ipIyy9TF1mGNzCc2sDTtwJuofT3BFuPdWl8
         TtChTNNAdpz7PGaTFD6MAvevF5uSpnbpTdxzWRx4/Gdy7gKBu00Slk+d7ta6BDrV6dd1
         XPmBkpi+OSwNFjI3sUX9mRRAMSKNIJj6Ks7WAxzKLK6B2QKlqNjF7bkgVULmIeeTS63h
         VlGnb0QvsFeDxx320LsnEzZR0zdMGqdd8JIsNaHniKWQafjgeGKr0bSwW98TyiOep4+A
         o79g==
X-Gm-Message-State: APjAAAV0SQEFV3bdGZyBMZYX/EfHZqMWEvpBkfKPGVNDA9H0P+0b3b+R
        mpu3PY9m/zHJRs9aERU4U+nk7Q==
X-Google-Smtp-Source: APXvYqzUtSx9TXYj7cPELtcJoIFrQb9QmW162prSdvzhCjMi66kmK7ihqlK1y9torULncYYjxLcW0w==
X-Received: by 2002:a17:902:904b:: with SMTP id w11mr8623273plz.182.1570724816801;
        Thu, 10 Oct 2019 09:26:56 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o15sm6148342pjs.14.2019.10.10.09.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 09:26:56 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] ath10k: Correct error check of dma_map_single()
Date:   Thu, 10 Oct 2019 09:26:53 -0700
Message-Id: <20191010162653.141303-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The return value of dma_map_single() should be checked for errors using
dma_mapping_error(), rather than testing for NULL. Correct this.

Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
Cc: stable@vger.kernel.org
Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3d2c8fcba952..a01868938692 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3904,7 +3904,7 @@ void ath10k_mgmt_over_wmi_tx_work(struct work_struct *work)
 			     ar->running_fw->fw_file.fw_features)) {
 			paddr = dma_map_single(ar->dev, skb->data,
 					       skb->len, DMA_TO_DEVICE);
-			if (!paddr)
+			if (dma_mapping_error(ar->dev, paddr))
 				continue;
 			ret = ath10k_wmi_mgmt_tx_send(ar, skb, paddr);
 			if (ret) {
-- 
2.23.0

