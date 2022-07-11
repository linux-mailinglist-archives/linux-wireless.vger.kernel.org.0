Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F6656D25E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGKBJL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiGKBJK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1DA9FD0
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso3542429pjj.5
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qw8ezip5HpbHXc3qzfiV/NhGAs+vlPEN8xfZY1FMMjQ=;
        b=aeqeTu6KLTvMPqXCWUVpYSuvoXzz1m17/mxcG7edVyrlOkAzI5Eempxm9Zu3RGrrhL
         JE/Elxe8IuSPv3uOmYsLjrLjFafDKXfE74dXFlICfAkpuxoR9YuDWH+nlEaNyBoTGUEW
         zpGQNgYD5oW1Mt5eDDunYFUEKMDszvTETr1e0MbwJYi01WXHCbTc+mk4bET0YV33/IHA
         ZJj1Hg6UXOeF/P2WRXtXYr4oyMRJNlh+IaviQhlkEG85vowaFesha+9V8lWtovWTviAo
         7SaNdWNuouQd23ks8ohSnsZtB1Zrdf0xu/FpWZDw24I4i/0Oatz5Mh2JB/jKNXT9k7qL
         2Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qw8ezip5HpbHXc3qzfiV/NhGAs+vlPEN8xfZY1FMMjQ=;
        b=18zB46xK9KWw9jMDomZlQb5PAjwf/9tYmeeqyRNwfaIwwLv+q6BTgo1WXqKtY87aIv
         rqv0zNd6qSgnfKTOcDIRrMQvoYy3+4FObfbWkVXU79a5kz6DdZdDsi/AJAAqimyFWsgb
         OthOz1rqmA/IdNqZ4xzcudmWZOYFyPtRfvMP0N5Q0iPKH3z6/TFWIU03KZ1QTUbqvOBR
         IaVZcWSr/IYH+WcQP7jIrHPptU+Cs34WG2aByZMSUr2kpkL21EDAFR1SROYlHpfbBsHu
         l5Iu70KbRMeCZRpW0/cYVIKqrxWZ5ukozGJ5i0HmP4XJm8Dn9yGa+yU1ELR71jJD85xY
         NvTw==
X-Gm-Message-State: AJIora8VtUe/9iffDUPi/Mueqq+1zJ8tkrt6Ownk8xRwQciMS717SpVG
        jj7G1wV1RTXPPYSTJ2gBLmOrag==
X-Google-Smtp-Source: AGRyM1tXZ6uscQhjUJ1+EPU9DLSwgYyXBbjL4nyCkLQa60qmiIabE8IuVAwmHGFQoJ0TUUi0F4J6lw==
X-Received: by 2002:a17:90a:2e03:b0:1ed:2cd5:6c4e with SMTP id q3-20020a17090a2e0300b001ed2cd56c4emr14613299pjd.225.1657501746929;
        Sun, 10 Jul 2022 18:09:06 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:06 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 05/12] nl80211: support advertising S1G capabilities
Date:   Mon, 11 Jul 2022 01:08:09 +0000
Message-Id: <20220711010816.45927-6-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Include S1G capabilities in netlink band info messages.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index bd6e2cae1dd3..71074332ccc5 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3933,6 +3933,10 @@ enum nl80211_band_iftype_attr {
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
@@ -3953,6 +3957,9 @@ enum nl80211_band_attr {
 	NL80211_BAND_ATTR_EDMG_CHANNELS,
 	NL80211_BAND_ATTR_EDMG_BW_CONFIG,
 
+	NL80211_BAND_ATTR_S1G_MCS_NSS_SET,
+	NL80211_BAND_ATTR_S1G_CAPA,
+
 	/* keep last */
 	__NL80211_BAND_ATTR_AFTER_LAST,
 	NL80211_BAND_ATTR_MAX = __NL80211_BAND_ATTR_AFTER_LAST - 1
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ab47e4130141..077dc2938551 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1942,6 +1942,16 @@ static int nl80211_send_band_rateinfo(struct sk_buff *msg,
 
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
 
-- 
2.25.1

