Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3CA4AA2BF
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbiBDWDN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343719AbiBDWDI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:03:08 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7B4C06173E
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 14:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0XNi9kxPkoeOU7UZeaekgRV7N2iN5Il+pQG25O9KCg0=;
        t=1644012187; x=1645221787; b=G4ZpF1Ir50r33cukoGPNJLGZc7cn2+gS9j4IEHwY+GBtylG
        WWglFVIr2IuFbPZI+BbrRV+xQIhHV7VhjZBJ/3TxEIeBlN2sT2sLiOc9uVeculncDa0dYZcnxgNP+
        Pmr1qXgDVIN9uZc3hjzY2+EuQbkCU7L6qfFWjafAgimOdr95iqbeNce72PfoeUaBsfDRcnbFRv01N
        CP7AzNkVkRozolkKTKOaGTcM5lohDdW6z6KMVMcojOTRdJPQTZno+5LhujE3vfSJhCn2SEOvMnEU3
        p3fcmdq3YzN1l0h+mLQV3jEe0ueOhA70RBj0/P73kNKtU5YKvthACc1EDRq8WU7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6fZ-00EeJL-KL;
        Fri, 04 Feb 2022 23:03:05 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>,
        Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 16/19] mac80211: Add support for storing station EHT capabilities
Date:   Fri,  4 Feb 2022 23:02:52 +0100
Message-Id: <20220204230119.a6743595ed1e.I15c6c8430e1a0184b1322e40f1727ed4f17b04e2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204220255.448224-1-johannes@sipsolutions.net>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
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

When a station configuration is updated, also update the station
EHT capabilities.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87a208089caf..aa45627a4208 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1716,6 +1716,14 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 						  (void *)params->he_6ghz_capa,
 						  sta);
 
+	if (params->eht_capa)
+		ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
+						    (u8 *)params->he_capa,
+						    params->he_capa_len,
+						    params->eht_capa,
+						    params->eht_capa_len,
+						    sta);
+
 	if (params->opmode_notif_used) {
 		/* returned value is only needed for rc update, but the
 		 * rc isn't initialized here yet, so ignore it
-- 
2.34.1

