Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E603D2DAC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhGVTsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 15:48:10 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:36894 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230480AbhGVTsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 15:48:07 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.218])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 778AB20071
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 20:28:41 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 57E44840083
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 20:28:41 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 133FF13C2BC;
        Thu, 22 Jul 2021 13:28:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 133FF13C2BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626985721;
        bh=CtDZ0o4nlBBBSQXFqDODEbTet004EU95y57Fud6MWtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iszi2+NeMRWubOdx9sxcQe318iQARbRjIo0UDi32h+B1/+eSJE/c/WttKZH5ulX5Q
         PBCW2K9zwkfwZftfuqD+G0EzRD6nQ+cUYYcVoQWqU+GlQnMUxCaq9y5yXBp2xoeJA3
         /cUs834PHPwTHMqy5vFcUegoRYVviD0EQc3CTTKM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 08/11] mt76: mt7915:  Fix SGI reporting when using tx-overrides.
Date:   Thu, 22 Jul 2021 13:28:31 -0700
Message-Id: <20210722202834.6826-8-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722202834.6826-1-greearb@candelatech.com>
References: <20210722202834.6826-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626985721-HOrltSGX62_C
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
index 1ef67608d122..d5747d61404a 100644
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

