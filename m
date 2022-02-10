Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6874B161E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbiBJTUb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:20:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343907AbiBJTUZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:20:25 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F964115A
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0XNi9kxPkoeOU7UZeaekgRV7N2iN5Il+pQG25O9KCg0=;
        t=1644520826; x=1645730426; b=U8c/rDwMtbfInXYb33ksUs2tEbGMBP2yzOnddYE00pOTcgl
        ondFDPkqK5MXv3EgG3suKut4Wq2zY8+XDYucmV1FtnmS1YhGG+Q2laX2z6jrfZPyit5WUNjkh5rCF
        FaFyCVRnfB5UG3RQIuPV/xEHBqYk/SuqCaEEdb0YSjwicFtstQTDWry1NmuGnxOBofr8hcyXZJcRe
        4WWUEm8EVS9jK7AR/O7fQaW/lpojEmmaI0v1CCaEc/vUvGL5JvvGBv9dXPpsbuL538YOcF4nhvfXF
        HvHbx1gl0Q1kh407FxzdnswGRT6BFOpMWkqIj2NueP3tffbyoPJGD+vAUGNBXcOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEzQ-00HC2X-B6;
        Thu, 10 Feb 2022 20:20:24 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     quic_vikram@quicinc.com, quic_alokad@quicinc.com,
        quic_jiad@quicinc.com, quic_periyasa@quicinc.com,
        quic_msinada@quicinc.com, quic_srirrama@quicinc.com,
        ilan.peer@intel.com
Subject: [PATCH v2 16/19] mac80211: Add support for storing station EHT capabilities
Date:   Thu, 10 Feb 2022 20:20:05 +0100
Message-Id: <20220210201853.60e525138d81.I15c6c8430e1a0184b1322e40f1727ed4f17b04e2@changeid>
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

