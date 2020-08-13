Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E512437DC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMJqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:46:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19556 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMJqr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:46:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597312006; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=n619kISlHXksZ37cU9qJ7MOgMek9J8c4+Dps5+0Q3fo=; b=P+b4aYxkCnGhtXN/yQquB5datvx0inC8K2DuUEdMFDfalIk/OlXYlzLk8AbS6n5kq01DsM/t
 Iu16dYKcRSBoSoj/7YADJCKa//whfkbnDkIougGrX6jOkOuNEnvhsRXLW8VF65rRXjsvq44R
 5jAQnT7SmQMTQvzWBToAaVcZvKw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f350c04668ab3fef6731b97 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 09:46:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9386C433C9; Thu, 13 Aug 2020 09:46:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16821C433CB;
        Thu, 13 Aug 2020 09:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16821C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 1/3] ath10k: add wmi service peer stat info for wmi tlv
Date:   Thu, 13 Aug 2020 17:47:07 +0800
Message-Id: <1597312029-32348-2-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597312029-32348-1-git-send-email-wgong@codeaurora.org>
References: <1597312029-32348-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k_sta_statistics is used to report info for iw wlan0 link,
it check ath10k_peer_stats_enabled, and ath10k_peer_stats_enabled
check WMI_SERVICE_PEER_STATS bit of ar->wmi.svc_map. SVCMAP() for
WMI_SERVICE_PEER_STATS was defined only for wmi_10x_svc_map and
wmi_10_4_svc_map interfaces, it missed in wmi_tlv_svc_map, so it is
not usable for iw wlan0 link for wmi tlv interface.

If firmware report WMI_TLV_SERVICE_PEER_STATS_INFO for wmi tlv, then
enable the WMI_SERVICE_PEER_STATS bit in ath10k, and then it pass check
in ath10k_peer_stats_enabled and ath10k_sta_statistics pass check.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00048
Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.h b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
index e77b97ca5c7f..b39c9b78b32b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -1614,6 +1614,8 @@ wmi_tlv_svc_map(const __le32 *in, unsigned long *out, size_t len)
 	       WMI_SERVICE_MESH_11S, len);
 	SVCMAP(WMI_TLV_SERVICE_SYNC_DELETE_CMDS,
 	       WMI_SERVICE_SYNC_DELETE_CMDS, len);
+	SVCMAP(WMI_TLV_SERVICE_PEER_STATS_INFO,
+	       WMI_SERVICE_PEER_STATS, len);
 }
 
 static inline void
-- 
2.23.0

