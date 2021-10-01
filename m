Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4541E65A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 06:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhJAECn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 00:02:43 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38046
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhJAECm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 00:02:42 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D51694076E
        for <linux-wireless@vger.kernel.org>; Fri,  1 Oct 2021 04:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633060854;
        bh=JZ+2UXfp4vFdd/kQjFqruaoyOogczScH1wvAY/k8T5w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=UVio0W0Dx5nXnZ6AYI75Q6bIyp1WII8SyuOpaF+UGuhwVgctw/etKJL/9qAdBBEvz
         27Sr+Rwbg7eQXMCVIiob+5XkuNS2srja0Zx+thjb8YRENGQM9D2AejB+rV9EJKkyNe
         8TyC/El1deJj098w01ubxkRJlrwm8Yd4SESGXson1FfeCn7c41siedrT2Yb1pwDZp7
         rnrIWcrPBvqoZXS1htWaH0KOyzD23WBv1Ugew7MvY10z0tBv/uQ3Vent/PJNHr/k9r
         QCIshux7+Apvka8/CShDfbRJDPBFS47JrT6kt7cR0trdHrM9PTiFfjSjTMd6On3npE
         VFB1Jbe1cQ3dw==
Received: by mail-pl1-f197.google.com with SMTP id h3-20020a170902704300b0013dbfc88e14so4504024plt.13
        for <linux-wireless@vger.kernel.org>; Thu, 30 Sep 2021 21:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZ+2UXfp4vFdd/kQjFqruaoyOogczScH1wvAY/k8T5w=;
        b=hx0Cs5B5TMGF2oEgO93tbltQ7D0yMSGPoii1JkoWXRhiYqsOGqroojCIKP40IX104/
         78COfBxZmsIXfR227Qih3LF4CMlkSUSdMbqN1GkVUAILBtU0kSew4hlnKaRHimPxuhQL
         P+9ZIdQ8z8Bv/lnDiYnaF1mHKm1xOFsjV6p4hxwZMbn/Gy69AQI+gdPxZpWYci9V3bf/
         TxwV4KtBx4OzeWOOadAC6g1kCB+fIEAySnNh8aBuVHUF6OcM1Jji6CnTf/qJRY8LG7Vm
         FNEEPg5+2/L9xa92SdUWfQECn2/Epho/yG0N0Tf+BAih8767MsZ2SbUvE/Z05QVTK+Ge
         JBTw==
X-Gm-Message-State: AOAM5336fNKRQ28V8OzO9PaeI3n83qsfJYQeh3tmefzaxV0pM+eKC7bs
        M2h1/otC/FReNkdBC5fTMO3iBbEsNsWK/M/rIUGmzenyRKi3MjuHUnboifli8RLtG+xlYwFX/8+
        tiFrj4p7xShZ2J1v0irtK5JCHauMtiqy0hFoKag96FnKf
X-Received: by 2002:a17:902:b583:b0:13d:e495:187a with SMTP id a3-20020a170902b58300b0013de495187amr7761241pls.9.1633060852993;
        Thu, 30 Sep 2021 21:00:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXdD/7zf8TEYKayuEFwFBsIgspnLZKaY5dIG+yY+dNHkcpE08ZwconX4SzR9J4F9l68crIXw==
X-Received: by 2002:a17:902:b583:b0:13d:e495:187a with SMTP id a3-20020a170902b58300b0013de495187amr7761220pls.9.1633060852688;
        Thu, 30 Sep 2021 21:00:52 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e255-baca-c7f7-191a-11a1-0473.emome-ip6.hinet.net. [2001:b400:e255:baca:c7f7:191a:11a1:473])
        by smtp.gmail.com with ESMTPSA id q1sm4672928pfu.4.2021.09.30.21.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 21:00:51 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2] rtl8xxxu: Use lower tx rates for the ack packet
Date:   Fri,  1 Oct 2021 12:00:44 +0800
Message-Id: <20211001040044.1028708-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to the Realtek propritary driver and the rtw88 driver, the
tx rates of the ack (includes block ack) are initialized with lower
tx rates (no HT rates) which is set by the RRSR register value. In
real cases, ack rate higher than current tx rate could lead to
difficulty for the receiving end to receive management/control frames.
The retransmission rate would be higher then expected when the driver
is acting as receiver and the RSSI is not good.

Cross out higer rates for ack packet before implementing dynamic rrsr
configuration like the commit 4830872685f8 ("rtw88: add dynamic rrsr
configuration").

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---

Changelog:
  v2:
   - Specify the dynamic rrsr commit for reference
   - Remove the unintentional twice reading of REG_RESPONSE_RATE_SET

 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 +++++-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 774341b0005a..a42e2081b75f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4460,13 +4460,17 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
 
 static void rtl8xxxu_set_basic_rates(struct rtl8xxxu_priv *priv, u32 rate_cfg)
 {
+	struct ieee80211_hw *hw = priv->hw;
 	u32 val32;
 	u8 rate_idx = 0;
 
 	rate_cfg &= RESPONSE_RATE_BITMAP_ALL;
 
 	val32 = rtl8xxxu_read32(priv, REG_RESPONSE_RATE_SET);
-	val32 &= ~RESPONSE_RATE_BITMAP_ALL;
+	if (hw->conf.chandef.chan->band == NL80211_BAND_5GHZ)
+		val32 &= RESPONSE_RATE_RRSR_INIT_5G;
+	else
+		val32 &= RESPONSE_RATE_RRSR_INIT_2G;
 	val32 |= rate_cfg;
 	rtl8xxxu_write32(priv, REG_RESPONSE_RATE_SET, val32);
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index a2a31f374a82..438b65ba9640 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -516,6 +516,8 @@
 #define REG_RESPONSE_RATE_SET		0x0440
 #define  RESPONSE_RATE_BITMAP_ALL	0xfffff
 #define  RESPONSE_RATE_RRSR_CCK_ONLY_1M	0xffff1
+#define  RESPONSE_RATE_RRSR_INIT_2G	0x15f
+#define  RESPONSE_RATE_RRSR_INIT_5G	0x150
 #define  RSR_1M				BIT(0)
 #define  RSR_2M				BIT(1)
 #define  RSR_5_5M			BIT(2)
-- 
2.20.1

