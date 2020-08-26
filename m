Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8A252A68
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgHZJiq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgHZJeq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C5C06138D
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x9so1077816wmi.2
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2cOlNLAlJyCxc93Ww/EdcxwprT/u096tFpvtTUHaj4=;
        b=E6/EOJ6wDOrgx9PD4VumxceDaZjVO9H0XlF5v5ZN2N091FR4cecJ8IQISgb3YS5DgR
         S004H2goEX0Cfuo5HLmWBBl6FbxxinmNGCoTqRbiuKrF0gTKk1msqQQiCR4pNOHUqN5V
         ea6Zenfh75vE4bk2AGt+qXGEEGqLvobBmMmgg7hBicMqhs4wdCTrVEumLM4aSbpidIix
         Wv4B08RJlXaozPB7KpaALRNl7PhUY3zk+Bzwxwv7h4I40q9qAjiOkg3wHN7ySDm5NMt2
         d6B/Go/tW9ihIoMHHfOR4paRfhsJWojjgF4/PnYoINFkURRPRewWN6Z8dNEB5FPnAV8Z
         Uypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2cOlNLAlJyCxc93Ww/EdcxwprT/u096tFpvtTUHaj4=;
        b=eZ6O9NU4R6o/ZhyAnvjsdHAi8r+kVVU9Aw000KNU4fygafd5ngzXe+bnJnEetbiIsa
         A01SSzQ5Jrk3HCEwyO9LnciDiAwxxxsPGDy55O6tFgs0RmVKQ5syhb/CVJSPT8t3zBT6
         bcmroWER06QyiPOWSWvtk0H0Q70CxtfZsqSua2jcdRJKC0ndS+hEfMjUuSBuoPsSfCEz
         +5kYngSYNtdK+84PyIGBZ6fPXNeCIqKs48aUmbdjTkRn3NiUbBawi5igtPkT9hHsYFOP
         43MmyufEO9ZyHuhA7JkGEt5aIOZ2tuyqIXvPVTtCLXYoSey0A4geVzM3Zd0m4cJAgTq9
         bnFg==
X-Gm-Message-State: AOAM532B1CGt929miz0g8QIBMWzg9Noj7xi5UQCnJEJrzGtIjdF1EMun
        ULVEbsTbnj5S3iA7obQIB11Vgw==
X-Google-Smtp-Source: ABdhPJxceLFWyqsmMvG8GeNkuTW8rs1GiY3zLzfFP71pXMr3CP+9eWfqKwYcHMv7Y6OX5ErnrUvsEQ==
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr6103115wmo.186.1598434461430;
        Wed, 26 Aug 2020 02:34:21 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:20 -0700 (PDT)
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
Subject: [PATCH 13/30] wireless: broadcom: brcm80211: brcmfmac: fwsignal: Finish documenting 'brcmf_fws_mac_descriptor'
Date:   Wed, 26 Aug 2020 10:33:44 +0100
Message-Id: <20200826093401.1458456-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:389: warning: Function parameter or member 'name' not described in 'brcmf_fws_mac_descriptor'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:389: warning: Function parameter or member 'requested_packet' not described in 'brcmf_fws_mac_descriptor'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:389: warning: Function parameter or member 'suppr_transit_count' not described in 'brcmf_fws_mac_descriptor'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:389: warning: Function parameter or member 'send_tim_signal' not described in 'brcmf_fws_mac_descriptor'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:389: warning: Function parameter or member 'traffic_pending_bmp' not described in 'brcmf_fws_mac_descriptor'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:389: warning: Function parameter or member 'traffic_lastreported_bmp' not described in 'brcmf_fws_mac_descriptor'

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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 902b2f65d4605..775e0612fa17a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -354,6 +354,7 @@ enum brcmf_fws_mac_desc_state {
 /**
  * struct brcmf_fws_mac_descriptor - firmware signalling data per node/interface
  *
+ * @name: name of the descriptor.
  * @occupied: slot is in use.
  * @mac_handle: handle for mac entry determined by firmware.
  * @interface_id: interface index.
@@ -362,10 +363,15 @@ enum brcmf_fws_mac_desc_state {
  * @generation: generation bit.
  * @ac_bitmap: ac queue bitmap.
  * @requested_credit: credits requested by firmware.
+ * @requested_packet: packet requested by firmware.
  * @ea: ethernet address.
  * @seq: per-node free-running sequence.
  * @psq: power-save queue.
  * @transit_count: packet in transit to firmware.
+ * @suppr_transit_count: suppressed packet in transit to firmware.
+ * @send_tim_signal: if set tim signal will be sent.
+ * @traffic_pending_bmp: traffic pending bitmap.
+ * @traffic_lastreported_bmp: traffic last reported bitmap.
  */
 struct brcmf_fws_mac_descriptor {
 	char name[16];
-- 
2.25.1

