Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2364E62010A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 22:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiKGVY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 16:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiKGVYf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 16:24:35 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B22F03E
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 13:24:05 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h193so11574059pgc.10
        for <linux-wireless@vger.kernel.org>; Mon, 07 Nov 2022 13:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/o5FCsZjB0k9oSFt888W97IJmFuVYvzneNfFQvShUoA=;
        b=Kg3XOtH86d4ACLOqR2y77ImlCLN6Is4VxnK63nK/vS59XKoCEMXPwhluJwKxW6Wt7i
         BXErj+1sW05WQ5sKOAKi+eoM1uIQ9BTo4+x/wSORPLnk54gScdpZLWgbb4OxqomR85JK
         Fi4vR9tvrzUn+SgypwJzKnP9HAGxyj6VaN0mHznmY13tuXBtaqINtcXajx9DgO0xGSFv
         Wj90H3ddvCgcN2GCZ2PNLlm4KJBrR+DzCdbDS++Izi2tXPodELny0T4ItkfS6x10ZaJD
         Mte5HovV6dScRribgHjaukSyPVXv+Rt3o1VV21hCthUlsz1P/qtXF4FkPIIjV1/O7Ajv
         Ljsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/o5FCsZjB0k9oSFt888W97IJmFuVYvzneNfFQvShUoA=;
        b=kC0cXeReBZWhzCBvDFX9sMisP8RsHteCXWM0l8HX6c3tXvewdmjGaOEcv+/fEYTEa8
         e3Aoi9fgSk7ah5ygiX5zYeU7m7wBNsvsZ90PsRgvRbnbSYw0ERHd4IkNr8FhtgBeGUdA
         MoVwVknTZn+y/zFwqj4nkCy8bcnpxmJQR90TVUhnMlkmuFHmtoHF+PKQ8oW/qp5Ggg/W
         5ilGyl7lh6ePxgJiSc17G9fGbmqefGObL33BtY7i4Pm+LhpUoDEB2PQPk29Kr1sH8UHG
         H1k+ezoUdeM6WvTV07ko/bysNOo7CSRsxdM6r7SCZkBnpG2gjEPs18lvMvz1N5TNn9WG
         Locg==
X-Gm-Message-State: ACrzQf0W5kV3j8Mdt9X9ekeEPhQgoeNQDHbpcE47PKJBiX9vAYED/y+R
        eqPU8av2Om7UA1x+tjTMZwFXGw==
X-Google-Smtp-Source: AMsMyM7pzOjgmF81XL/VVXARbU8uineQQsAShp96yqyDwwBpNk3OqbepyknoTQ9FTK8u5HVTWcvx5A==
X-Received: by 2002:a62:5e06:0:b0:56b:e3f8:824f with SMTP id s6-20020a625e06000000b0056be3f8824fmr52843127pfb.84.1667856244934;
        Mon, 07 Nov 2022 13:24:04 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id z10-20020aa79f8a000000b00560bb4a57f7sm5102356pfr.179.2022.11.07.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:24:04 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH 1/4] wifi: cfg80211: Add long_beacon_interval and short_beacon_tail
Date:   Tue,  8 Nov 2022 10:23:55 +1300
Message-Id: <20221107212358.272070-1-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kieran Frewen <kieran.frewen@morsemicro.com>

Support variables to handle short beacon period and adding a
separate tail for them.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/net/cfg80211.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 11a370e64143..7f785b81b8e3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1179,8 +1179,11 @@ struct cfg80211_mbssid_elems {
  *	or %NULL if not changed
  * @tail: tail portion of beacon (after TIM IE)
  *	or %NULL if not changed
+ * @short_tail: short tail portion of beacon (after TIM IE)
+	or %NULL if not changed
  * @head_len: length of @head
  * @tail_len: length of @tail
+ * @short_tail_len: length of @short_tail
  * @beacon_ies: extra information element(s) to add into Beacon frames or %NULL
  * @beacon_ies_len: length of beacon_ies in octets
  * @proberesp_ies: extra information element(s) to add into Probe Response
@@ -1207,7 +1210,7 @@ struct cfg80211_mbssid_elems {
 struct cfg80211_beacon_data {
 	unsigned int link_id;
 
-	const u8 *head, *tail;
+	const u8 *head, *tail, *short_tail;
 	const u8 *beacon_ies;
 	const u8 *proberesp_ies;
 	const u8 *assocresp_ies;
@@ -1217,7 +1220,7 @@ struct cfg80211_beacon_data {
 	struct cfg80211_mbssid_elems *mbssid_ies;
 	s8 ftm_responder;
 
-	size_t head_len, tail_len;
+	size_t head_len, tail_len, short_tail_len;
 	size_t beacon_ies_len;
 	size_t proberesp_ies_len;
 	size_t assocresp_ies_len;
@@ -1328,7 +1331,7 @@ struct cfg80211_ap_settings {
 
 	struct cfg80211_beacon_data beacon;
 
-	int beacon_interval, dtim_period;
+	int beacon_interval, dtim_period, short_beacon_period;
 	const u8 *ssid;
 	size_t ssid_len;
 	enum nl80211_hidden_ssid hidden_ssid;
-- 
2.34.1

