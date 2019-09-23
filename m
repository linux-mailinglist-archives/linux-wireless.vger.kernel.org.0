Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D63BBC63
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 21:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502374AbfIWTtd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 15:49:33 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38577 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502372AbfIWTtd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 15:49:33 -0400
Received: by mail-wr1-f41.google.com with SMTP id l11so15317637wrx.5
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2019 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFJ6zWicZY8f8WavDOdQQjHVPH6dk+nXo+I5rtEql2Q=;
        b=Rt60OX8Z2aP2lClSHF94qpReq81yO6UTZhBKFzpRND/bqG0AbzEElEMBwTCFa3NgJ0
         Kil6nR38vaTtwgYB6TQKSuLhKZnmk7KTpotl8+TBRGiv1Z4VtdMupC/sPsHKc5J18hgA
         mPObVg1eCcX3jKX0NwaMIUqqln7FYYL/Nvw0okslxgb0CA7qZV8NrIcoCo9kPd7zpIC7
         lyJkCIuHmTDubMiCcEgpk1hwhcA5PWDKUzpa6MLVd2BEpmxRL1Vllp+Z1JJgTuNQb61h
         KPmMlBUCV4TK2MotuMZHXENBQ5oBLsx2f8gw+wGCVdC1S+2SyGS6YlJHlS9wYpnKqX9N
         bxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFJ6zWicZY8f8WavDOdQQjHVPH6dk+nXo+I5rtEql2Q=;
        b=Y4NunZGrfE10e6XFyHVEoPL2AlQZMRANRNDcq56l9WMyqpcS5t61KaMQ8VLjt+MdWR
         Mwtc+aDHTuSOAEFGl1tbyedfXVjaho9a0wEcuLw1NBhApqas0V/Au9aEyI/fOqmhPCMy
         9uYZoImieFa13xZBz5K6o1POZhzHz9RWYvDjQmsejlmfAmOOVCGpZllQxTRSor5rCj9g
         X/ctzSVUyHLwxPTWuLjCSUlgsk4GyOXedonm5ITFdhupmVhtDOXG1fg1ORXCayhzCN0v
         qxLE568W5mtvR1w8+VE2gMbfHph+nbY9IqNRDDlgkEBZC4SqkktViM3Hz9MtNW6CEBIx
         28Ow==
X-Gm-Message-State: APjAAAX8zccbE0N6VPdkSfE+HXioDptyfOOwGGSx8mrqAvl/aXDQ1cG7
        FNywSUH0ni9CpCZPAvhVs1DHG5VB
X-Google-Smtp-Source: APXvYqw03u9SkaVmEb8taXLU0dIbm/Mctsk+NemQWRnzsl/iUMVEZVxqkRKY019oIu2Ty1RnAh8I9Q==
X-Received: by 2002:adf:ce83:: with SMTP id r3mr846161wrn.219.1569268170162;
        Mon, 23 Sep 2019 12:49:30 -0700 (PDT)
Received: from localhost.localdomain ([31.147.208.18])
        by smtp.googlemail.com with ESMTPSA id o188sm25108013wma.14.2019.09.23.12.49.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 12:49:29 -0700 (PDT)
From:   =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, ath10k@lists.infradead.org
Subject: [PATCH 2/5] ath10k: print service ready returned channel range
Date:   Mon, 23 Sep 2019 21:49:22 +0200
Message-Id: <1569268165-1639-2-git-send-email-pozega.tomislav@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
References: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Displays lowest/highest supported channels for both 2ghz and 5ghz
bands as they're fetched within WMI service ready event.
These are shown in a frequency format.

Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 3ef6ee3..b7b8072 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5563,7 +5563,7 @@ static void ath10k_wmi_event_service_ready_work(struct work_struct *work)
 
 skip_mem_alloc:
 	ath10k_dbg(ar, ATH10K_DBG_WMI,
-		   "wmi event service ready min_tx_power 0x%08x max_tx_power 0x%08x ht_cap 0x%08x vht_cap 0x%08x sw_ver0 0x%08x sw_ver1 0x%08x fw_build 0x%08x phy_capab 0x%08x num_rf_chains 0x%08x eeprom_rd 0x%08x num_mem_reqs 0x%08x\n",
+		   "wmi event service ready min_tx_power 0x%08x max_tx_power 0x%08x ht_cap 0x%08x vht_cap 0x%08x sw_ver0 0x%08x sw_ver1 0x%08x fw_build 0x%08x phy_capab 0x%08x num_rf_chains 0x%08x eeprom_rd 0x%08x low_2ghz_chan %d high_2ghz_chan %d low_5ghz_chan %d high_5ghz_chan %d num_mem_reqs 0x%08x\n",
 		   __le32_to_cpu(arg.min_tx_power),
 		   __le32_to_cpu(arg.max_tx_power),
 		   __le32_to_cpu(arg.ht_cap),
@@ -5574,6 +5574,10 @@ static void ath10k_wmi_event_service_ready_work(struct work_struct *work)
 		   __le32_to_cpu(arg.phy_capab),
 		   __le32_to_cpu(arg.num_rf_chains),
 		   __le32_to_cpu(arg.eeprom_rd),
+		   __le32_to_cpu(arg.low_2ghz_chan),
+		   __le32_to_cpu(arg.high_2ghz_chan),
+		   __le32_to_cpu(arg.low_5ghz_chan),
+		   __le32_to_cpu(arg.high_5ghz_chan),
 		   __le32_to_cpu(arg.num_mem_reqs));
 
 	dev_kfree_skb(skb);
-- 
1.7.0.4

