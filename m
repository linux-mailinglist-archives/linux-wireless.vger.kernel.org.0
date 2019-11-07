Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 539A9F2AB4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 10:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfKGJb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 04:31:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfKGJb2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 04:31:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E6786607C3; Thu,  7 Nov 2019 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573119087;
        bh=mqtpqHY18ivGiFB5+qIy1kwckL/kg/AIykdO52D3w1o=;
        h=From:To:Cc:Subject:Date:From;
        b=pIYnpNmR2Snb3K9ymxslj1cZntblGxVZ6spBg/uTBsUTKuxZ2OlBeX7X6SrDbdhOR
         uS2Z8t75JeFbDhysWmcEOZh6dZWI4AJ3kum4SdyACUV/e71fOHuXPVA5gSBykP0tCH
         XhpPJHWVgV4rdkKjW4jX0oHZv6Jnb6Gt2Fg3kDCQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4166960300;
        Thu,  7 Nov 2019 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573119086;
        bh=mqtpqHY18ivGiFB5+qIy1kwckL/kg/AIykdO52D3w1o=;
        h=From:To:Cc:Subject:Date:From;
        b=DCjFZHi46F3yAca4xMBV3UpL4lZlMGLWtadylxkAy47Igd1IIgzI2s7G2Fr0d3qUy
         BW84AfN1dFgfGxFciehgiscfkjcMzoWJRmtiuYA99mjxZOIAKUccQCqo19SC28Ig/U
         trV/HXCGFHW673QSXw86lzUtuJC2uMSkbN5zTyYo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4166960300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: correct the tlv len of ath10k_wmi_tlv_op_gen_config_pno_start
Date:   Thu,  7 Nov 2019 17:30:31 +0800
Message-Id: <20191107093031.24131-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

the tlv len is set to the total len of the wmi cmd, it will trigger
firmware crash, correct the tlv len.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1 and QCA6174
PCIE with firmware WLAN.RM.4.4.1-00110-QCARMSWPZ-1.

Fixes: ce834e280f2f875 ("ath10k: support NET_DETECT WoWLAN feature")
Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 69a1ec53df29..7b358484940e 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -3707,6 +3707,7 @@ ath10k_wmi_tlv_op_gen_config_pno_start(struct ath10k *ar,
 	struct wmi_tlv *tlv;
 	struct sk_buff *skb;
 	__le32 *channel_list;
+	u16 tlv_len;
 	size_t len;
 	void *ptr;
 	u32 i;
@@ -3764,10 +3765,12 @@ ath10k_wmi_tlv_op_gen_config_pno_start(struct ath10k *ar,
 	/* nlo_configured_parameters(nlo_list) */
 	cmd->no_of_ssids = __cpu_to_le32(min_t(u8, pno->uc_networks_count,
 					       WMI_NLO_MAX_SSIDS));
+	tlv_len = __le32_to_cpu(cmd->no_of_ssids) *
+		sizeof(struct nlo_configured_parameters);
 
 	tlv = ptr;
 	tlv->tag = __cpu_to_le16(WMI_TLV_TAG_ARRAY_STRUCT);
-	tlv->len = __cpu_to_le16(len);
+	tlv->len = __cpu_to_le16(tlv_len);
 
 	ptr += sizeof(*tlv);
 	nlo_list = ptr;
-- 
2.23.0

