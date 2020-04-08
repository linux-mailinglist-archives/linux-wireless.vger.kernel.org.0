Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2731A2C1C
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 01:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgDHXLW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Apr 2020 19:11:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35144 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgDHXLW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Apr 2020 19:11:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id r26so1922916wmh.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2020 16:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1oJI7w/Vka3nAtUJyEYq4j3ayrxFSj56nOQPqznbsEU=;
        b=aodEKppdwsvq6DPeDnM1rPoIhSf/XnqxhKTRr2jIRwKOgmPXIbAhA+fpkH3vK3Wcf1
         KbkYJnQMp6NNQQgAOxbGXdqgtGKpRVjutiI1HrsFOlRPEdRVIIGFzRPpIqqcb8MPCkTZ
         Gz7OuXGpmHZ54xJENbIqgaS+y5Hi2XPdcqHCqyn6rOWC3qcryVXHP0NRqjlaE2qmnoP2
         80hNLUzpTYasHv7e8M98i2TDKAaec8mh5M80cCa/ZGu7L60+h9bw8eq9azcpAedK4Dqc
         imxGOJKnZ34T1fhYy/ns6Lnn27dIQwZPfXWJvrCSaHCSPV9c4Idy/Y7Mh7x2bulwnj2f
         h6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1oJI7w/Vka3nAtUJyEYq4j3ayrxFSj56nOQPqznbsEU=;
        b=NN546cpMA3kuIVjBW6+E4vG5kkGyO7EXMafN1qfm4vwy1ittKKx3pDdNi1dhj9OtSB
         FX8KJ8DOGS2rvifRglCTWoBWuXyHq6JdOM8lmbeVxGFAQSBXuHdqeHYgUbY0YxFJePSs
         b4i6XPySZ9HVaGMA9CXwNfL7BetLy2lEca2S6zOpnu5rLJ86460ckVSw/shFaqdDD3cE
         KFY2LsKj1oedQqi3xX2CXzDyqagMaYp4+ZpZUhvcnOJ3IDV9M8tr++THa+DWOi5sNimz
         0QNOnjEVWr6rYi6PAdU7/Iu6BDEFfr1bhbmc3oPN7p7ZiAK8oPDzLut96c2QESVi2zae
         qR0g==
X-Gm-Message-State: AGi0PuYzPwQNRqK3JS1jT2vugYK57SDvG91lGOc0YWe37azgHn9TuOfK
        yJNQ75cLBQSUUi4prrFxKcU=
X-Google-Smtp-Source: APiQypLnmx5A45pP5UHhPZ1MnL9W8vHQCXC9FnEvALRp/GSD0DPv17mp8zYul65stbIk1b6/mocK8w==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr4729011wma.38.1586387480714;
        Wed, 08 Apr 2020 16:11:20 -0700 (PDT)
Received: from de0709bef958.v.cablecom.net ([45.87.212.59])
        by smtp.gmail.com with ESMTPSA id p7sm4702492wrf.31.2020.04.08.16.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 16:11:20 -0700 (PDT)
From:   Lothar Rubusch <l.rubusch@gmail.com>
To:     johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH] cfg80211: fix kernel-doc notation
Date:   Wed,  8 Apr 2020 23:10:13 +0000
Message-Id: <20200408231013.28370-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update missing kernel-doc annotations and fix of related warnings
at 'make htmldocs'.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 include/net/cfg80211.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c78bd4ff9e33..edea88510091 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -905,6 +905,8 @@ struct survey_info {
  *	protocol frames.
  * @control_port_over_nl80211: TRUE if userspace expects to exchange control
  *	port frames over NL80211 instead of the network interface.
+ * @control_port_no_preauth: disables pre-auth rx over the nl80211 control
+ *  port for mac80211
  * @wep_keys: static WEP keys, if not NULL points to an array of
  *	CFG80211_MAX_WEP_KEYS WEP keys
  * @wep_tx_key: key index (0..3) of the default TX static WEP key
@@ -1222,6 +1224,7 @@ struct sta_txpwr {
  * @he_capa: HE capabilities of station
  * @he_capa_len: the length of the HE capabilities
  * @airtime_weight: airtime scheduler weight for this station
+ * @txpwr: transmit power for an associated station
  */
 struct station_parameters {
 	const u8 *supported_rates;
@@ -4666,6 +4669,9 @@ struct wiphy_iftype_akm_suites {
  * @txq_memory_limit: configuration internal TX queue memory limit
  * @txq_quantum: configuration of internal TX queue scheduler quantum
  *
+ * @tx_queue_len: allow setting transmit queue len for drivers not using
+ *  wake_tx_queue
+ *
  * @support_mbssid: can HW support association with nontransmitted AP
  * @support_only_he_mbssid: don't parse MBSSID elements if it is not
  *	HE AP, in order to avoid compatibility issues.
@@ -4681,6 +4687,10 @@ struct wiphy_iftype_akm_suites {
  *	supported by the driver for each peer
  * @tid_config_support.max_retry: maximum supported retry count for
  *	long/short retry configuration
+ *
+ * @max_data_retry_count: maximum supported per TID retry count for
+ *  configuration through the NL80211_TID_CONFIG_ATTR_RETRY_SHORT and
+ *  NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes
  */
 struct wiphy {
 	/* assign these fields before you register the wiphy */
-- 
2.20.1

