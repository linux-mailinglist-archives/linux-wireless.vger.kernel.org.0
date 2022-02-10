Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8174B162A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbiBJTUY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:20:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343886AbiBJTUV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:20:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECABF116D
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pTzUO/iLdArxO7QBxL5WrsG8xZLnhgzyR32bcWH1LzM=;
        t=1644520821; x=1645730421; b=moapJywS72qnZzvLb8TiEoLGNvhN0SmqXEHPy+lh94WPFDu
        dpqMEmJrhnZxXp3FKPfjJaZe/vJCDgOEGXo2Qfcz0zF9E1szpqpRWPAHl/MQ67iJxCeO2tY6KhFuZ
        MIdg7qlxInIlTwbkpScMN2iGRu8zPC0+Ljv5SvQg0BA7C2OaPUY/QiDWcWFrvIUt32o37Brb/GF/k
        ExRBo25uKgL0OlkTkGvF/MNQU5bIrL+2OZWDLtLDc5yxMLdqPsl7wAAToTrFm7zFiMC33J/BXjSHI
        PhDmoXWlmloNTQ9Dg/n36GV9PeBP7qe/Wt0UZVjr2Ru3GAVeoiBxisrBx2myvzfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEzK-00HC2X-N5;
        Thu, 10 Feb 2022 20:20:18 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     quic_vikram@quicinc.com, quic_alokad@quicinc.com,
        quic_jiad@quicinc.com, quic_periyasa@quicinc.com,
        quic_msinada@quicinc.com, quic_srirrama@quicinc.com,
        ilan.peer@intel.com
Subject: [PATCH v2 03/19] mac80211_hwsim: Add custom regulatory for 6GHz
Date:   Thu, 10 Feb 2022 20:19:52 +0100
Message-Id: <20220210201853.bc2fddd81537.I9507395b64496d96a2276ba8c1e1323e54407aa7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210192008.188166-1-johannes@sipsolutions.net>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add a custom regulatory domain for testing 6 GHz, including
320 MHz bandwidth. This can be used before the regulatory
databases are all updated etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 92e055ee0bb9..defb7e36c1f2 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -173,9 +173,23 @@ static const struct ieee80211_regdomain hwsim_world_regdom_custom_02 = {
 	}
 };
 
+static const struct ieee80211_regdomain hwsim_world_regdom_custom_03 = {
+	.n_reg_rules = 6,
+	.alpha2 =  "99",
+	.reg_rules = {
+		REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0),
+		REG_RULE(2484 - 10, 2484 + 10, 40, 0, 20, 0),
+		REG_RULE(5150 - 10, 5240 + 10, 40, 0, 30, 0),
+		REG_RULE(5745 - 10, 5825 + 10, 40, 0, 30, 0),
+		REG_RULE(5855 - 10, 5925 + 10, 40, 0, 33, 0),
+		REG_RULE(5955 - 10, 7125 + 10, 320, 0, 33, 0),
+	}
+};
+
 static const struct ieee80211_regdomain *hwsim_world_regdom_custom[] = {
 	&hwsim_world_regdom_custom_01,
 	&hwsim_world_regdom_custom_02,
+	&hwsim_world_regdom_custom_03,
 };
 
 struct hwsim_vif_priv {
-- 
2.34.1

