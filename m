Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DFF7A0A74
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 18:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbjINQJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 12:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjINQJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 12:09:07 -0400
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90A1BDD
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 09:09:03 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:195:0:640:cda7:0])
        by forward101c.mail.yandex.net (Yandex) with ESMTP id 4ED1360036;
        Thu, 14 Sep 2023 19:08:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id S8jreuLDXiE0-8T098tht;
        Thu, 14 Sep 2023 19:08:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1694707708; bh=khJbb1v9CxYDR69tTGRoXyJBoHhMmLWlZqVZyoTBExk=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=fsGkfe3z0a3k5l897BsdEDzcx9PyMzBmOXDE1SGCg4zWNfWUqdTbPSOgXxM4IGzoZ
         IlGeXiARYykxq8D9oj11sRVmeatYgHv5laBXcoTvXhuNfxD5BdviWNxw5xwjVCYqfN
         rnNPEfaTP7SsodPsQhMxynQLDRqSZYl1nbYRap5g=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: drop HTT_DATA_TX_STATUS_DOWNLOAD_FAIL
Date:   Thu, 14 Sep 2023 19:07:03 +0300
Message-ID: <20230914160744.155903-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <18eac255-720a-488e-882e-b79f098aba65@quicinc.com>
References: <18eac255-720a-488e-882e-b79f098aba65@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to Jeff, 'HTT_DATA_TX_STATUS_DOWNLOAD_FAIL' from
'enum htt_data_tx_status' is never actually used by the
firmware code and so may be dropped, with the related
adjustment to 'ath10k_htt_rx_tx_compl_ind()'.

Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Found by Linux Verification Center (linuxtesting.org) with SVACE.
---
 drivers/net/wireless/ath/ath10k/htt.h    | 3 +--
 drivers/net/wireless/ath/ath10k/htt_rx.c | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 7b24297146e7..c80470e8886a 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -880,8 +880,7 @@ enum htt_data_tx_status {
 	HTT_DATA_TX_STATUS_OK            = 0,
 	HTT_DATA_TX_STATUS_DISCARD       = 1,
 	HTT_DATA_TX_STATUS_NO_ACK        = 2,
-	HTT_DATA_TX_STATUS_POSTPONE      = 3, /* HL only */
-	HTT_DATA_TX_STATUS_DOWNLOAD_FAIL = 128
+	HTT_DATA_TX_STATUS_POSTPONE      = 3 /* HL only */
 };
 
 enum htt_data_tx_flags {
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 438b0caaceb7..b261d6371c0f 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2964,7 +2964,6 @@ static void ath10k_htt_rx_tx_compl_ind(struct ath10k *ar,
 		break;
 	case HTT_DATA_TX_STATUS_DISCARD:
 	case HTT_DATA_TX_STATUS_POSTPONE:
-	case HTT_DATA_TX_STATUS_DOWNLOAD_FAIL:
 		tx_done.status = HTT_TX_COMPL_STATE_DISCARD;
 		break;
 	default:
-- 
2.41.0

