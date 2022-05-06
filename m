Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE751D2A6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389742AbiEFH6o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376315AbiEFH6n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 03:58:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60DA67D14
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 00:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=VG6enhkcbfnaWHM9AAJC7ZZjlQS6bOSTExngf6Vbps8=; t=1651823701; x=1653033301; 
        b=aO0VrmKx3bBXfmpiOn4BQKcE6p6vVH7AH0aamZW1kDBoc/5pKfrExoaW4sZY/r68zY4j6Vf3F4x
        U8rHqRSJ5DbAedDr1Ay0FV7QH54I0bMYOMCenGLiGsDRLemRgOJD6yWH2CtB4YlMHPB+8K+NJuUKk
        D1IRatduaNo0L4p7NBK0+w5ye9omTt8LnQ34SNW26o9++8Z3gsTl8m+Q5eLpSBg2DyLn+hCjN9iDw
        Re1HSDw5V9m2xYzbdY2s2zUiK54v3We82nw4UVTAdwZSrBvFzPYkcEEmoJkJhHHIxZ7rEPf/dqIse
        hXPOEqRwuaBKTGkMjSUmZvT70M8QxgFJfTKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmsnh-003zg5-1B;
        Fri, 06 May 2022 09:54:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wil6210: remove 'freq' debugfs
Date:   Fri,  6 May 2022 09:54:53 +0200
Message-Id: <20220506095451.9852305a92c8.I05155824a1b9059eb59beccde81786dc69de354a@changeid>
X-Mailer: git-send-email 2.35.1
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

From: Johannes Berg <johannes.berg@intel.com>

This is completely racy, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/wil6210/debugfs.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index 4c944e595978..64d6c98174c8 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -1391,19 +1391,6 @@ static int temp_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(temp);
 
-/*---------freq------------*/
-static int freq_show(struct seq_file *s, void *data)
-{
-	struct wil6210_priv *wil = s->private;
-	struct wireless_dev *wdev = wil->main_ndev->ieee80211_ptr;
-	u32 freq = wdev->chandef.chan ? wdev->chandef.chan->center_freq : 0;
-
-	seq_printf(s, "Freq = %d\n", freq);
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(freq);
-
 /*---------link------------*/
 static int link_show(struct seq_file *s, void *data)
 {
@@ -2380,7 +2367,6 @@ static const struct {
 	{"pmcdata",	0444,		&fops_pmcdata},
 	{"pmcring",	0444,		&fops_pmcring},
 	{"temp",	0444,		&temp_fops},
-	{"freq",	0444,		&freq_fops},
 	{"link",	0444,		&link_fops},
 	{"info",	0444,		&info_fops},
 	{"recovery", 0644,		&fops_recovery},
-- 
2.35.1

