Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0262B106
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 03:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiKPCIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Nov 2022 21:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKPCIo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Nov 2022 21:08:44 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67CA38B3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 18:08:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p12so15120967plq.4
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 18:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4qTfTJgfMrLVQOXxEPoFSBsvy1MRVj5Vj/ISDmX1nU=;
        b=0u6GQKANIk6TzKNdOThzAXo30yY3OOgT7c+ZwkVJ3Fj2EbHD6J4CRkFStxpkz5zJfM
         WECLogZYPu+S0LwqxZOUgm5y5LLkEcQgI3ZLxpsiuQiiD9NXUAKgJDxc0N3YvJS+VTfS
         18CfsRc1PYUD2TEm7f2CxAC67s40XjcgpY/caikNGua6b8JantAaSukerbTj7klez6qW
         GoZgMK6vGZ59uPNZNWbbDtRXwi51F+mabN/6Dq49UeDffVpi9eN7VmR1i3ZOqZ1CmZFU
         yVhCWhfSt6S7O78Jod0IOKnn6IIDoH6doFbpsb/U+5DEHe8HSKHlGGeyaX+s809fzk34
         jAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4qTfTJgfMrLVQOXxEPoFSBsvy1MRVj5Vj/ISDmX1nU=;
        b=dgwVcMdL22HKaJjkIar8Bo89v+p3jnDUPwZhCW9Fuh1IIIcNxzCWXgWZgcAjAQHlNr
         fGdwY9Xoq389LHKuP5JlkJr+MP2UnUKXU9b9OxxYLegXrVdl28y2MwKUtltyc7PmrubJ
         VNpnzj3EorrvBywhAXoXsph0PvfHwuZr/gvvsomIB0eM4Y8+SDGBEkqyYewPDce1k89P
         Zj/2YlAj9q7P92xS32xxN2eUTzRCJQ1XXOr22JTzaDHCk9ylXw+co6gjfTClIo/8RTjx
         GZcBKzrUQ6U0qgfLd+NQloTXiVA4IpyecjvNwuzGCJQC2dBxyBK4jJtedJJ0dO/Llllc
         C44Q==
X-Gm-Message-State: ANoB5pnsaM+AVHgi/U3kkSJUTulJr96603P6izTcK5NEAtQdrwIAIKJV
        WqRwwcPdvO2jecw2bC6B7/T8sg==
X-Google-Smtp-Source: AA0mqf6m1bLpJvcvQ8O+TyAKde1l19imIKfmPNB7PHE14Qjr1xRZ+yPP1y3f6R3JeLI3EUEMN/Kg7g==
X-Received: by 2002:a17:90a:bc01:b0:213:1935:9744 with SMTP id w1-20020a17090abc0100b0021319359744mr1280304pjr.207.1668564523155;
        Tue, 15 Nov 2022 18:08:43 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id y2-20020a62ce02000000b0056bbd286cf4sm9379231pfg.167.2022.11.15.18.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:08:42 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v3 1/4] wifi: cfg80211: Add short_beacon_tail/head/period
Date:   Wed, 16 Nov 2022 15:06:57 +1300
Message-Id: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
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
separate tail/head for them.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/net/cfg80211.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 11a370e64143..99f28ef2323f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1179,8 +1179,13 @@ struct cfg80211_mbssid_elems {
  *	or %NULL if not changed
  * @tail: tail portion of beacon (after TIM IE)
  *	or %NULL if not changed
+ * @short_head: head portion of short beacon or %NULL if not changed
+ * @short_tail: short tail portion of beacon (after TIM IE)
+	or %NULL if not changed
  * @head_len: length of @head
  * @tail_len: length of @tail
+ * @short_head_len: length of @short_head
+ * @short_tail_len: length of @short_tail
  * @beacon_ies: extra information element(s) to add into Beacon frames or %NULL
  * @beacon_ies_len: length of beacon_ies in octets
  * @proberesp_ies: extra information element(s) to add into Probe Response
@@ -1208,6 +1213,7 @@ struct cfg80211_beacon_data {
 	unsigned int link_id;
 
 	const u8 *head, *tail;
+	const u8 *short_head, *short_tail;
 	const u8 *beacon_ies;
 	const u8 *proberesp_ies;
 	const u8 *assocresp_ies;
@@ -1218,6 +1224,7 @@ struct cfg80211_beacon_data {
 	s8 ftm_responder;
 
 	size_t head_len, tail_len;
+	size_t short_head_len, short_tail_len;
 	size_t beacon_ies_len;
 	size_t proberesp_ies_len;
 	size_t assocresp_ies_len;
@@ -1328,7 +1335,7 @@ struct cfg80211_ap_settings {
 
 	struct cfg80211_beacon_data beacon;
 
-	int beacon_interval, dtim_period;
+	int beacon_interval, dtim_period, short_beacon_period;
 	const u8 *ssid;
 	size_t ssid_len;
 	enum nl80211_hidden_ssid hidden_ssid;

base-commit: 5c111ec204d15d1c7d00428b0afdda62ff118565
-- 
2.34.1

