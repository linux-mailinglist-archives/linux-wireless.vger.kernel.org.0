Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5033A786906
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 09:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbjHXHzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 03:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbjHXHzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 03:55:00 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67EE170D
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 00:54:54 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e2b:0:640:94b5:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 6859360135;
        Thu, 24 Aug 2023 10:54:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nsFdET9WwmI0-HwLOH6sP;
        Thu, 24 Aug 2023 10:54:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692863691;
        bh=qXPc9WQi8jtJuPmLlZa3OkWLGJnQUKyL8ylyggIXN3A=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=mJ+aNj2/JL5/wG8219fWP9uNBivlCZ8FpalRTtxoiGGt/XrV9hodQD1Q2VMDzJHEO
         vcbBx6zMaDzOuuVjw8HS51vaYiZjIoitKoLq8fVJDMIM7mNjVJi2I4BhBzAUQ7/nAx
         nfodvXEofI40fOjA24wMXQ5Qpodb8IVOz2iQmbJk=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath11k@lists.infradead.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/5] wifi: ath11k: simplify spectral pull functions
Date:   Thu, 24 Aug 2023 10:50:46 +0300
Message-ID: <20230824075121.121144-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824075121.121144-1-dmantipov@yandex.ru>
References: <20230824075121.121144-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'ath11k_spectral_pull_summary()' and 'ath11k_spectral_pull_search()'
always returns 0, both of them may be converted to 'void' and
'ath11k_spectral_process_fft()' may be simplified accordingly.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/spectral.c | 24 ++++++++--------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 705868198df4..97eb2a457685 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -470,10 +470,10 @@ static const struct file_operations fops_scan_bins = {
 	.llseek = default_llseek,
 };
 
-static int ath11k_spectral_pull_summary(struct ath11k *ar,
-					struct wmi_dma_buf_release_meta_data *meta,
-					struct spectral_summary_fft_report *summary,
-					struct ath11k_spectral_summary_report *report)
+static void ath11k_spectral_pull_summary(struct ath11k *ar,
+					 struct wmi_dma_buf_release_meta_data *meta,
+					 struct spectral_summary_fft_report *summary,
+					 struct ath11k_spectral_summary_report *report)
 {
 	report->timestamp = __le32_to_cpu(summary->timestamp);
 	report->agc_total_gain = FIELD_GET(SPECTRAL_SUMMARY_INFO0_AGC_TOTAL_GAIN,
@@ -500,13 +500,11 @@ static int ath11k_spectral_pull_summary(struct ath11k *ar,
 					__le32_to_cpu(summary->info2));
 
 	memcpy(&report->meta, meta, sizeof(*meta));
-
-	return 0;
 }
 
-static int ath11k_spectral_pull_search(struct ath11k *ar,
-				       struct spectral_search_fft_report *search,
-				       struct ath11k_spectral_search_report *report)
+static void ath11k_spectral_pull_search(struct ath11k *ar,
+					struct spectral_search_fft_report *search,
+					struct ath11k_spectral_search_report *report)
 {
 	report->timestamp = __le32_to_cpu(search->timestamp);
 	report->detector_id = FIELD_GET(SPECTRAL_FFT_REPORT_INFO0_DETECTOR_ID,
@@ -531,8 +529,6 @@ static int ath11k_spectral_pull_search(struct ath11k *ar,
 				       __le32_to_cpu(search->info2));
 	report->rel_pwr_db = FIELD_GET(SPECTRAL_FFT_REPORT_INFO2_REL_PWR_DB,
 				       __le32_to_cpu(search->info2));
-
-	return 0;
 }
 
 static u8 ath11k_spectral_get_max_exp(s8 max_index, u8 max_magnitude,
@@ -629,11 +625,7 @@ int ath11k_spectral_process_fft(struct ath11k *ar,
 		return ret;
 	}
 
-	ret = ath11k_spectral_pull_search(ar, data, &search);
-	if (ret) {
-		ath11k_warn(ab, "failed to pull search report %d\n", ret);
-		return ret;
-	}
+	ath11k_spectral_pull_search(ar, data, &search);
 
 	chan_width_mhz = summary->meta.ch_width;
 
-- 
2.41.0

