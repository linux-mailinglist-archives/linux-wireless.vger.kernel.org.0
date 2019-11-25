Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21481091F1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 17:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfKYQgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 11:36:19 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:52942
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbfKYQgT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 11:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574699778;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=B04r6TelRDXX7WilUs9v6mEy/co8eAu697uhT4HnCog=;
        b=LMquWG66X0wdGnhOJWa8IZuw+9e/Uj6Ekp+LLXHUHA9A7AfpqN+n8KXGT5dykLnB
        9qLOjQUdfWF246h1dF5CDBuVnGI6LdAytB+/jMNHAyxSutbuYjFWz/+qmM76kM0Zupp
        /nVlylByj85KtQXhehO8mZGQAW6G/c1yM3GJ5Yf0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574699778;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=B04r6TelRDXX7WilUs9v6mEy/co8eAu697uhT4HnCog=;
        b=c2XQZorpygS90sh2BXaQ7FA5szNkm4VY2buIVgMhMk9kakdkDRVTNfQ6ZHAAU/wX
        IHEZaYFosmN3hkKHFFXGnPwp0SLTy60ZeIz4xlGT0lDIzQGu1jjDVnrg6FzNq9L+eze
        XJT3BosWeFXb5ZMJbPn5QUh4t/SZvv48JY0MOHOY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F295CC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 1/8] ath11k: add RX stats support for radiotap
Date:   Mon, 25 Nov 2019 16:36:18 +0000
Message-ID: <0101016ea36bc1e7-b9c8f0c1-9781-4920-afa0-45684e8754cc-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
References: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.25-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

mac80211 expects the definition of what HE rate info is available inside a
struct prepended to the skb.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 9491a479fab5..c498c4920e11 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2038,11 +2038,21 @@ static char *ath11k_print_get_tid(struct ieee80211_hdr *hdr, char *out,
 static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *napi,
 				      struct sk_buff *msdu)
 {
+	static const struct ieee80211_radiotap_he known = {
+		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN),
+		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
+	};
 	struct ieee80211_rx_status *status;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)msdu->data;
+	struct ieee80211_radiotap_he *he = NULL;
 	char tid[32];
 
 	status = IEEE80211_SKB_RXCB(msdu);
+	if (status->encoding == RX_ENC_HE) {
+		he = skb_push(msdu, sizeof(known));
+		memcpy(he, &known, sizeof(known));
+		status->flag |= RX_FLAG_RADIOTAP_HE;
+	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
 		   "rx skb %pK len %u peer %pM %s %s sn %u %s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
-- 
2.7.4

