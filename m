Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007592D9D9F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 18:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440382AbgLNR1N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 12:27:13 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:49778 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440354AbgLNR0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 12:26:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607966746; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nXkpuF8VfHvBATboXJSgvzYPre3kgypzyfajSE7Xx6U=; b=laAep1e7LcDqzbcnV90yP8YU1E6PRrCre+5UxvtsnBRksBr9BHPk3vbeJQxhSOnXRjj6TKz2
 HZrrOnNeM6j6Hhz/yraVuWqqBySYO+9uan54XhQNSbpt0RudGszTJj17En3I0zQCTr8Pntbh
 UArSrIAQpgvr3fXGQNwcpqCOmXU=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fd79fea08cce5ad85dd23c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Dec 2020 17:24:58
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91F01C433C6; Mon, 14 Dec 2020 17:24:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-35-200-nat.elisa-mobile.fi [85.76.35.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C0D3C433CA;
        Mon, 14 Dec 2020 17:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C0D3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     ath9k-devel@qca.qualcomm.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/5] ath: Use safer key clearing with key cache entries
Date:   Mon, 14 Dec 2020 19:21:14 +0200
Message-Id: <20201214172118.18100-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214172118.18100-1-jouni@codeaurora.org>
References: <20201214172118.18100-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is possible for there to be pending frames in TXQs with a reference
to the key cache entry that is being deleted. If such a key cache entry
is cleared, those pending frame in TXQ might get transmitted without
proper encryption. It is safer to leave the previously used key into the
key cache in such cases. Instead, only clear the MAC address to prevent
RX processing from using this key cache entry.

This is needed in particularly in AP mode where the TXQs cannot be
flushed on station disconnection. This change alone may not be able to
address all cases where the key cache entry might get reused for other
purposes immediately (the key cache entry should be released for reuse
only once the TXQs do not have any remaining references to them), but
this makes it less likely to get unprotected frames and the more
complete changes may end up being significantly more complex.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/key.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/key.c b/drivers/net/wireless/ath/key.c
index 1816b4e7dc26..59618bb41f6c 100644
--- a/drivers/net/wireless/ath/key.c
+++ b/drivers/net/wireless/ath/key.c
@@ -583,7 +583,16 @@ EXPORT_SYMBOL(ath_key_config);
  */
 void ath_key_delete(struct ath_common *common, struct ieee80211_key_conf *key)
 {
-	ath_hw_keyreset(common, key->hw_key_idx);
+	/* Leave CCMP and TKIP (main key) configured to avoid disabling
+	 * encryption for potentially pending frames already in a TXQ with the
+	 * keyix pointing to this key entry. Instead, only clear the MAC address
+	 * to prevent RX processing from using this key cache entry.
+	 */
+	if (test_bit(key->hw_key_idx, common->ccmp_keymap) ||
+	    test_bit(key->hw_key_idx, common->tkip_keymap))
+		ath_hw_keysetmac(common, key->hw_key_idx, NULL);
+	else
+		ath_hw_keyreset(common, key->hw_key_idx);
 	if (key->hw_key_idx < IEEE80211_WEP_NKID)
 		return;
 
-- 
2.20.1

