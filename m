Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC3109CB9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfKZLEy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 06:04:54 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:54794
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbfKZLEy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 06:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574766293;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=r8aodMtyyPk9CDP8QS2QZ2XuERYIaSS+3PBWWdQtBiI=;
        b=Quxus2Q+kG6v+sHXBSabCXcdUIrUjLEkh65mEhmsmp4+O3S/25aFvwouqOehwDly
        qRVwxwxiSDVZ4LKuYcQmR5q41vfcGVpXy5zzSM2EOhFLi8++8L6VPjYa7bz5s3DYH5I
        M9GQYxODAKkGU6L8ZaYtFlHTKfLOdD6G4uhUH8nk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574766293;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=r8aodMtyyPk9CDP8QS2QZ2XuERYIaSS+3PBWWdQtBiI=;
        b=JgV+8VMcur7BMeqCz6CxT4RrjMHVOAkZ48rh2UM38mPV8thRhaom3MfNkanTAtAH
        vioOEBYIExHOJP09lcuAdGOPhhwhg/Ioep0xApbJtAjRnzXg/xAsQZ+OKiDKzIkg23r
        Ll+bq2Tu5gOGJeKKhjbX7WEwbzOEygpAoqdS2MXE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E8E5C447B4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 06/10] ath11k: avoid WMM param truncation
Date:   Tue, 26 Nov 2019 11:04:53 +0000
Message-ID: <0101016ea762b255-bfbcc96e-cbc5-45a5-8c7f-3509d5ceb5bc-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
References: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.26-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

In conf_tx() mac operation callback, we are truncating the tx
params cw_min and cw_max due to lower data type cast. so modified
the data type of cwmin and cwmax to avoid the trucation issue.

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 6a0468094694..4a518d406bc5 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4501,8 +4501,8 @@ struct wmi_wmm_params {
 struct wmi_wmm_params_arg {
 	u8 acm;
 	u8 aifs;
-	u8 cwmin;
-	u8 cwmax;
+	u16 cwmin;
+	u16 cwmax;
 	u16 txop;
 	u8 no_ack;
 };
-- 
2.7.4

