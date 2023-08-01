Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C3F76C089
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 00:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjHAWq5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 18:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjHAWq4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 18:46:56 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B412B;
        Tue,  1 Aug 2023 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1690930007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tHEfEuheYq1rMmU1IaJm2EFOCvJfmQ3ow7jMNnIxa/M=;
        b=MSu4DZNa3bvrCP+heR+AOZfSkDu75Iw6kFWS/Dz71v+UIw3G/+MNovPRlwhwQjCu4o/ABp
        1hPqUKZ5l4uckFZfOoayy8H9OJg7YHVz1mjJ3uSum1AyIZ15FDv7r4bCQw/UQ/LWm3+V3O
        MftzXTLiFtt9FAUMu7bNzTuqYk6ItI8=
From:   Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 0/2] ath11k: Don't leak ack_status_frame during
 tx_complete* processing
Date:   Wed, 02 Aug 2023 00:46:25 +0200
Message-Id: <20230802-ath11k-ack_status_leak-v2-0-c0af729d6229@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGLyWQC/43OQQqDMBCF4avIrDsliQRrV71HKTLGiQZbI5NUC
 uLdG3qCLr/F+3k7JJbACa7VDsJbSCEuBeZUgZtoGRnDUAxGmVpdlEbKk9Yzkpu7lCm/U/dkmrF
 R1FCt2A6thzJehX34/ML3R7GX+MI8CdNfuU2jRlu3rm+Ms7Z3t4XEUy7vzlFGOI4v37F6AboAA
 AA=
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc:     Kalle Valo <quic_kvalo@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Sven Eckelmann <sven@narfation.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=sven@narfation.org;
 h=from:subject:message-id; bh=NCr+XZUPJYsm0GGWvSDiIYvPVRyI2bf72kEgqxdL8a0=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBkyYtPRPa2MLdnh+gYmkV/WsqI2xv99XWI5nkj3
 /ts+ZsZvnmJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZMmLTwAKCRBdhwoHwSZ7
 Rg71D/9ZSifsvtEFs6NOoYEqLiMtXYjqpYmYHL4hOfX5PMLrn0HwizkdauD5KbxH6wy15zyMDlK
 2OdG1VIP+nWkJlSmdz+XXfO2PnsZ4lOt0TD0/x3DjH1HmsIEl9qgEfnokrTbMLe92kc/4bou4dz
 4t6y01LXeGQTud6BnXzAjP9Xgp+sT59VyQluNw5WIP7L60LE2aWbKWxGIK+wNni/TSFT+B7gZAd
 7cuLSjvtfPzfrq1fzkYRf7kj0gnELrljReFv9dx8gtrul7CasaPDuO693K6mP/azk44jRayidqV
 /VyRfCyweUXk3EzFOG8r0fuqRQhazHIhdJXw6p2yyIFhuRsbyU6t8OumRF1g9RO0QQkiRDN+OKI
 SLdZVUApoYohUzUwNVHukf11oFkywg+gtWWbdcQs3jh+NMAAuvwPA1qbdhgBVdlkEUzi1NFYxTe
 LqHTrgWAKHNLFkJIUEgLK+bqFZKY5CwkYGDha1Fk2kHbJ1MgMJfyczvIz8Zu4dCzXu3Ykqq0N69
 CHGiy/NKmLx/rWuexyHT7Y9SiUWeBgdiQrGNoJiiiSk0FZ2EF5YH1jUEk90x9J9a3GeFQCJx8Qs
 9J5x0uv5E6hJ/0UbJnbe6q+duCNOI3JCwj5KMJt7FiJn/NfZto8zwzdPNNhiwHCBdoxFH5WKA8T
 7mJPGZvU8smMj5Q==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It was noticed that APs stopped to accept clients after a while. With QCA's
ath11k fork, it even printed some additional information:

  attach ack fail -28

when new clients tried to connect. hostapd was then usually showing a
message like "deauthenticated due to inactivity (timer DEAUTH/REMOVE)".

While debugging this, it was noticed that this happened when a peer was no
longer known by ath11k but an NL80211_CMD_PROBE_CLIENT triggered TX was
just "finished" for it. In that case, ath11k was just throwing the skb away
and left some information in various data structures in mac80211.

And after Felix pointed out ieee80211_free_txskb(), it is also clear that
dev_kfree_skb_any() in these functions should also be calls to
ieee80211_free_txskb() - but for these, I have nothing to trigger this
error case. Still, a patch is provided as part of this patch series.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- Simply switch to ieee80211_free_txskb() as recommended by Felix Fietkau

  + ieee80211_free_txskb calls ieee80211_report_used_skb
  + ieee80211_report_used_skb calls ieee80211_report_ack_skb (when
    ack_frame_id is set and !IEEE80211_TX_INTFL_MLME_CONN_TX)
  + ieee80211_report_ack_skb will remove skb from ack_status_frames

- Add second patch which handles similar situations in the previously
  patched functions
- Link to v1: https://lore.kernel.org/r/20230801-ath11k-ack_status_leak-v1-1-539cb72c55bc@narfation.org

---
Sven Eckelmann (2):
      ath11k: Don't drop tx_status when peer cannot be found
      ath11k: Cleanup mac80211 references on failure during tx_complete

 drivers/net/wireless/ath/ath11k/dp_tx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 1d7dd5aa35474e553b8671b58579e0749b560779
change-id: 20230801-ath11k-ack_status_leak-70a7a30e5d9f

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

