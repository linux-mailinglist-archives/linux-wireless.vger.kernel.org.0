Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0539E3146C2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 04:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBIDAn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 22:00:43 -0500
Received: from so15.mailgun.net ([198.61.254.15]:10511 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhBIC7N (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 21:59:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612839512; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jQoHOJt1f+bVaxtKsuGzlepL01TAE5RWMk3Uz70Gxnc=; b=Yx2FPUntETUjyaKyyCwY2d78uCxwHA9RoKFT+oH4vMD2gW2pPm4YS1HlRRIBUx7+Lc6y23/7
 by7T8hqutVcUunhPypCCpR3bvgMglZ9/rWP5MHH4PEdMU/l325AcF6YpJtGT37yr5MVENuhH
 xtqFwEX3fn7/7jiaiOi4pYzZ4/A=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6021fa3534db06ef799df914 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 02:57:57
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5D57C43461; Tue,  9 Feb 2021 02:57:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from gongwen-ThinkPad-T420.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37EBEC433C6;
        Tue,  9 Feb 2021 02:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37EBEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath10k: restore tx sk_buff of htt header for SDIO
Date:   Tue,  9 Feb 2021 10:58:50 +0800
Message-Id: <1612839530-2263-1-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_report_used_skb of mac80211 use the frame_control of
ieee80211_hdr in sk_buff and indicate it to another function
ieee80211_mgd_conn_tx_status, then it queue work ieee80211_sta_work,
but ieee80211_is_auth(fc) in ieee80211_sta_work check fail when the
authentication has transmitted by ath10k.

When the ath10k report it with HTT_TX_COMPL_STATE_DISCARD, it will be
set without flag IEEE80211_TX_STAT_ACK, then mac80211 should try the
next authentication immeditely, but in fact mac80211 wait 1 second for
it, the reason is ieee80211_is_auth(fc) in ieee80211_sta_work check
fail for the sk_buff which is not restored, the data of sk_buff is not
the begin of ieee80211_hdr, in fact it is the begin of htt_cmd_hdr.

dmesg without this patch, it wait 1 second for the next retry when
ath10k report without IEEE80211_TX_STAT_ACK for authentication:
[ 6973.883116] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 1/3)
[ 6974.705471] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 2/3)
[ 6975.712962] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 3/3)

Restore the sk_buff make mac8011 retry the next authentication
immeditely which meet logic of mac80211.

dmesg with this patch, it retry the next immeditely when ath10k
report without IEEE80211_TX_STAT_ACK for authentication:
[  216.734813] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 1/3)
[  216.739914] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 2/3)
[  216.745874] wlan0: send auth to 5e:6f:2b:0d:fb:d7 (try 3/3)

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 9a109840a4c9..44c617834c56 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -573,6 +573,8 @@ void ath10k_htt_htc_tx_complete(struct ath10k *ar, struct sk_buff *skb)
 			desc_hdr = (struct htt_data_tx_desc *)
 				(skb->data + sizeof(*htt_hdr));
 			flags1 = __le16_to_cpu(desc_hdr->flags1);
+			skb_pull(skb, sizeof(struct htt_cmd_hdr));
+			skb_pull(skb, sizeof(struct htt_data_tx_desc));
 		}
 	}
 
-- 
2.27.0

