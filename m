Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895A25ADE9F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiIFEtF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIFEtD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:49:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E015F233
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:48:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so6337139pjl.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qGFhC4Pt6EcprkTSPzvVWVdSH6KTqSlQ80Wc40VOPaU=;
        b=2seAIBgqWcGKZBYj5qJppmfLVNv0YbjnpSFpnQZZ8R+dFr4ydawr6UQADjynGH826Y
         7pwAsEQdID2BZKT6XsxScthPlLJG3kcSAL01koiXsqr9e+vRrUI6PHQTz4gjag4Xb4Ci
         uMJp07qiVd8+oSXQCxQt73e6fN42vWGZ7mLgBv9BXtT9/omo15jW2nusAFdYv7URtUKH
         8mqtOEvbkDJXZfliszl1mIXTmiowI3axwrFRh0yJF5toB93LvFLEXDgR9EN80tifDv6/
         hKQJXeQFazSIK1o4+qTEQLz9yl1/9i1hiOOEY079HPoq9qvbq4HTamBGma5rE66glL7E
         7wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qGFhC4Pt6EcprkTSPzvVWVdSH6KTqSlQ80Wc40VOPaU=;
        b=RJVZudMfACj/bLGMXIsKsd4p1KTMfqNGFVTaqwEa5Dq9yfTzffdGVo5KaHV3UPRTz2
         sM8Lah0JV67Noub0N1WY+veEB8PV97DbwuQCMVZDzAiuYJe1CnNqUjr+4HvWxeV2sjdj
         2ihzsBeL2zSy4bznrOX0p4ZTu3SpQtTRFJdxXWJzWyF29xjiMBFx5PB00pAuObvalU/J
         PF0Elb+UrtgrJ9BUS2ZjbTwDygFJtCD1ECoJ0TTVV/HAu3bTkwAVZYJuojp1OJZkP7GD
         FJAx8GnqVXT7A36A/p1NuUszBNu+depv78uN81H7hxRpluh6tn3eo0VCs9yiwdrfyzsz
         N5EA==
X-Gm-Message-State: ACgBeo3IPgFgF+MkkUJYBPD6/1N/4RabVrx+xba3dUNJYGJOqtQFr40E
        1W22zqUBxeJENox1N2uVcw0ZbQ==
X-Google-Smtp-Source: AA6agR4j7wy4xgUPhF8lwecPZVG/oAhTIjrQH8ppcyAqZRCb3UgWk6aeNk+E42w4o7xt9acqUUbifw==
X-Received: by 2002:a17:90b:4c8c:b0:200:5fa3:9766 with SMTP id my12-20020a17090b4c8c00b002005fa39766mr9211872pjb.129.1662439737612;
        Mon, 05 Sep 2022 21:48:57 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:48:57 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 05/12] nl80211: support advertising S1G capabilities
Date:   Tue,  6 Sep 2022 16:48:05 +1200
Message-Id: <20220906044812.7609-6-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
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
---
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 7daa2ce1cb57..f20b9aefd420 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3994,6 +3994,10 @@ enum nl80211_band_iftype_attr {
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
@@ -4014,6 +4018,9 @@ enum nl80211_band_attr {
 	NL80211_BAND_ATTR_EDMG_CHANNELS,
 	NL80211_BAND_ATTR_EDMG_BW_CONFIG,
 
+	NL80211_BAND_ATTR_S1G_MCS_NSS_SET,
+	NL80211_BAND_ATTR_S1G_CAPA,
+
 	/* keep last */
 	__NL80211_BAND_ATTR_AFTER_LAST,
 	NL80211_BAND_ATTR_MAX = __NL80211_BAND_ATTR_AFTER_LAST - 1
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5e9aaa8c0d7d..931e35619cf4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1949,6 +1949,16 @@ static int nl80211_send_band_rateinfo(struct sk_buff *msg,
 
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
2.34.1

