Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3221F3E023E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhHDNpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 09:45:30 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:34026 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237987AbhHDNp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 09:45:28 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.175])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A4D2A2A006D
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:45:14 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7A6E98C0080
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:45:14 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 2760013C2BC;
        Wed,  4 Aug 2021 06:45:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2760013C2BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628084714;
        bh=2Es1FyVE3jgX+6477awy6BaMUBBUCRXlgW8KqeWJyjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdf2O53xkPooug5QchWveYiQF0G2peswYtXtUMpOIRgJaX4fNLSm9mjtlHO+SvZpp
         d1uP8Y5Tm0J4tyEno5UZHjOaMO8YDZSutW30/QMa3QHAeTweLAhoxV2VQUrwKmx7xA
         jEgGohJRQP1eBbIQA+v+ziF6WNp/BnvEl8rm2jc0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v5 08/11] mt76: mt7915:  fix SGI reporting when using tx-overrides
Date:   Wed,  4 Aug 2021 06:45:02 -0700
Message-Id: <20210804134505.3208-8-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804134505.3208-1-greearb@candelatech.com>
References: <20210804134505.3208-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628084715-U7xkcAXBFf_O
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The station wtbl logic to read rate-ctrl settings does not work when
fixed rates are used.  So, read sgi settings from the txo configuration
in this case.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 01f4aa7a6e88..6dd86dbe3e08 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -176,6 +176,15 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 						       rx_cur);
 		}
 
+		/* If we are in tx-override mode, then wtbl doesn't provide useful report
+		 * for the SGI/LGI stuff, so just get it from the override struct.
+		 */
+		if (msta->test.txo_active) {
+			msta->wcid.rate_he_gi = msta->test.tx_rate_sgi;
+			msta->wcid.rate_short_gi = msta->test.tx_rate_sgi;
+			continue;
+		}
+
 		/*
 		 * We don't support reading GI info from txs packets.
 		 * For accurate tx status reporting and AQL improvement,
-- 
2.20.1

