Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB16A1200
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBWV3u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 16:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBWV3g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 16:29:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1926F48E3B
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 13:29:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso5087482pjv.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 13:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBP4zrGhzp/1XJInd8akb9sTPZfhBtUrpFRhcTrkgp4=;
        b=vjsUH8VuuiEl7qvo50u0VfBstN/o1gBcE13iXwcFkflJd/R7SxL5vwLnXWmhtOHHyY
         nu9P3iwt6w1wR7/poKkHaYgZ6cWYkkmLBztFbTOR2l85P+y6e/oy/OqWJd5dRzWXbNTw
         qoYq4q/9w8UZMAI0Tz44f4ObE/RciJEyqSFSvLGwsIdgQCm98cvI+c0JhN4XKfBP4C0d
         TblbZeDAUzFUWOfdlSbQRhgRQ9RBxw47ryFkqTW1TP7E78yuaVECMdJIknr981+gGdki
         cLbvAR27o7FWNWauz2sAGYPyDi8J+PQAi3wbko+19DiMg0San37GM9RxSzWwS32S5QVv
         obeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBP4zrGhzp/1XJInd8akb9sTPZfhBtUrpFRhcTrkgp4=;
        b=rHLIwG3gwKGZV+YcGlGgfVC77f/Rig751Syj0FZKaL+96rZXENcdT8/CCdPW7K6bbv
         c82q7BZup6IcTXJIvpe8izOMhSu61rjljx1cNnR5IisnvSepFOG/1FT3ygVlPrD8fN39
         vivJoNi7Wq1ZeDoXeNE2ir/FHstIVp2dTRZOIIDAp9PBXgoljOY910JRC7Jo1LhfCzxG
         aN8MyzM1CccmtWfDkM5sCGBPDAoLyBTvdCSnjyUdroDF30g+T0/1OnG650jE4/1Goet8
         EqNsiGkTltZJXQwUFGP08V3Q2k6oNOik23DJyybHUPqip510kj4q9AV+IhvcMQ3QFDYv
         WadQ==
X-Gm-Message-State: AO0yUKWpzIzs1G008oD+3YgQs0ArUp5m95oFXvboKMDtyIuimqnTKj3Q
        6HT4+gjYzTXya5Uyl6Cz2UnmsQ==
X-Google-Smtp-Source: AK7set+YcOtcJI/8To6PsZLimNsC2Ju8OugH20pwGXoXuMom0evW+7bwpTy1Og29E3XTJ/04LM4fJg==
X-Received: by 2002:a05:6a20:6908:b0:cb:ea93:86c1 with SMTP id q8-20020a056a20690800b000cbea9386c1mr6696357pzj.32.1677187775511;
        Thu, 23 Feb 2023 13:29:35 -0800 (PST)
Received: from virs-pc-014.morsemicro.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id f20-20020a633814000000b00502e918fee3sm3299438pga.60.2023.02.23.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 13:29:35 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
X-Google-Original-From: Gilad Itzkovitch <gilad.itzkovitch@virscient.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH] wifi: nl80211: support advertising S1G capabilities
Date:   Fri, 24 Feb 2023 10:29:17 +1300
Message-Id: <20230223212917.4010246-1-gilad.itzkovitch@virscient.com>
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

Include S1G capabilities in netlink band info messages.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f14621a954e1..47d40120b0df 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4026,6 +4026,10 @@ enum nl80211_band_iftype_attr {
  * @NL80211_BAND_ATTR_EDMG_BW_CONFIG: Channel BW Configuration subfield encodes
  *	the allowed channel bandwidth configurations.
  *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
+ * @NL80211_BAND_ATTR_S1G_MCS_NSS_SET: S1G capabilities, supported S1G-MCS and NSS
+ *	set subfield, as in the S1G information IE, 5 bytes
+ * @NL80211_BAND_ATTR_S1G_CAPA: S1G capabilities information subfield as in the
+ *	S1G information IE, 10 bytes
  * @NL80211_BAND_ATTR_MAX: highest band attribute currently defined
  * @__NL80211_BAND_ATTR_AFTER_LAST: internal use
  */
@@ -4046,6 +4050,9 @@ enum nl80211_band_attr {
 	NL80211_BAND_ATTR_EDMG_CHANNELS,
 	NL80211_BAND_ATTR_EDMG_BW_CONFIG,
 
+	NL80211_BAND_ATTR_S1G_MCS_NSS_SET,
+	NL80211_BAND_ATTR_S1G_CAPA,
+
 	/* keep last */
 	__NL80211_BAND_ATTR_AFTER_LAST,
 	NL80211_BAND_ATTR_MAX = __NL80211_BAND_ATTR_AFTER_LAST - 1
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 112b4bb009c8..e1510165a6e5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1957,6 +1957,16 @@ static int nl80211_send_band_rateinfo(struct sk_buff *msg,
 
 	nla_nest_end(msg, nl_rates);
 
+	/* S1G capabilities */
+	if (sband->band == NL80211_BAND_S1GHZ && sband->s1g_cap.s1g &&
+	    (nla_put(msg, NL80211_BAND_ATTR_S1G_CAPA,
+		     sizeof(sband->s1g_cap.cap),
+		     sband->s1g_cap.cap) ||
+	     nla_put(msg, NL80211_BAND_ATTR_S1G_MCS_NSS_SET,
+		     sizeof(sband->s1g_cap.nss_mcs),
+		     sband->s1g_cap.nss_mcs)))
+		return -ENOBUFS;
+
 	return 0;
 }
 

base-commit: bf767e3600e0b7d389c6c6a861bd3313ac956c06
-- 
2.34.1

