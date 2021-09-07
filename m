Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96C402893
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbhIGMUz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:20:55 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33682
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344473AbhIGMUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:20:02 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AC76540827
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017120;
        bh=IGi454bY1uM8p5QRZSKGDo9YXvHCL/LufQFtzz+SznM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BKgQmkFGobUvYp4GFsCJgQW/pS4+dZHWtVS2CgD0+/SI7oAylF4qKPMClkPE2XS9K
         KiZgUKdoGhiybUMClbmES0ASH/vud9PeZBpFkNjWyNt1E5o1XhJkp7Rpx++N8C3zW6
         Ho1loJ4DQ2kx8RN6QMF24nvlqOSbTPQAKgfAid2UyNRputTZHAaoQs+OO5q23+jOtk
         x6M9WFETDet2o8tUchLOwI9jxOtL8VKItU8ahicahuLk/ImV0VX/13u7+cHFhCxhbQ
         ZXqRG6pQpbHxYhkM5caBjQto37Wy/nRNpkqVFkWT+0GhNR+RcCyPMu8vz/LMs5nc6E
         2oXBE6+0V5CTw==
Received: by mail-wm1-f72.google.com with SMTP id n16-20020a1c7210000000b002ea2ed60dc6so861643wmc.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGi454bY1uM8p5QRZSKGDo9YXvHCL/LufQFtzz+SznM=;
        b=eB0Zg39esto4SSxYn/M9A0KTqtDrpt+KmbZ6Dqf8qcUBER9kxlhP3McEOrxrnUm0zE
         sNTfYKtmVtZrFaEFVRk8WEVPHbM1TE6JZ8DLGmlnf0issNGVdxcqyRJIaSy9Z8rDctzo
         RFGMNJuzpf23tYwtPsrhevUnw2Pv7M7yWQsCHSsu7opWAp5cK8al9Xs+u7jt7VBsJx4x
         59QwCxqIpyU9tLW+G7OOqytUerPALoT9P4RHMBJNmX4Q5uytmhYauXJjd2qpnTUvFK8U
         NGfTYW2+Nr2qawlV0R1LPqPcj7r92pUcNxQHFDqDEZu9//ChUO2DWgDaaYmb6Ze+C4Rl
         9Z6A==
X-Gm-Message-State: AOAM533ZM4kRl1zkSA7dq7d1ZsMTQXdcpkhicpfa2U6T0spDKw88c2pL
        6yNghOOEmTm0EawHU7KmNlkbl68uoyVrwiMu+Qtj8Uq80CVxyyJDpwaJpalODv4lH9KwysrUcg5
        nEexRHt4L16/O6RwsKxeUzegDR4FwbIJR77VgucAjwh1D
X-Received: by 2002:a05:600c:1d27:: with SMTP id l39mr3629442wms.146.1631017120416;
        Tue, 07 Sep 2021 05:18:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzkQReT6hqXvnsRi4xVMvPv5mwLHDY/KqHilLqyCDbOJpRRpQ8tjRRU7brxn8w70vPDRKkmA==
X-Received: by 2002:a05:600c:1d27:: with SMTP id l39mr3629425wms.146.1631017120289;
        Tue, 07 Sep 2021 05:18:40 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 15/15] nfc: mrvl: drop unneeded memory allocation fail messages
Date:   Tue,  7 Sep 2021 14:18:16 +0200
Message-Id: <20210907121816.37750-16-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

nci_skb_alloc() already prints an error message on memory allocation
failure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/nfcmrvl/fw_dnld.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index edac56b01fd1..e83f65596a88 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -76,10 +76,8 @@ static struct sk_buff *alloc_lc_skb(struct nfcmrvl_private *priv, uint8_t plen)
 	struct nci_data_hdr *hdr;
 
 	skb = nci_skb_alloc(priv->ndev, (NCI_DATA_HDR_SIZE + plen), GFP_KERNEL);
-	if (!skb) {
-		pr_err("no memory for data\n");
+	if (!skb)
 		return NULL;
-	}
 
 	hdr = skb_put(skb, NCI_DATA_HDR_SIZE);
 	hdr->conn_id = NCI_CORE_LC_CONNID_PROP_FW_DL;
-- 
2.30.2

