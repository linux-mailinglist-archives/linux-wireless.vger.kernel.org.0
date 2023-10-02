Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0417B5A2A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbjJBSaj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjJBSai (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 14:30:38 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05909B
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 11:30:33 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:6094:0:640:a0fc:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 7B7B66004E;
        Mon,  2 Oct 2023 21:30:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0Uai0s2WoOs0-1UsmPXuD;
        Mon, 02 Oct 2023 21:30:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1696271400; bh=wAy9SqB3FdhkMyineGEngwKExIGQyZJibJ7vayETQdE=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=an5ZI0OrMMBx1JD2ZiXObjSp2fIyWbE8bC6RQh6kfyW6xUo0WWBAkL/UsyeuNwBVM
         D/bpIhobI4BvznshTvI48jz8sRaHCEE88koBPCUZZDAamQhBc7jQnzwIF48iKeBhY6
         R1iiKnsxMhX5SKl4927nCJJnj0ZRj37d/6hBsOP0=
Authentication-Results: mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath12k: remove redundant memset() in ath12k_hal_reo_qdesc_setup()
Date:   Mon,  2 Oct 2023 21:28:48 +0300
Message-ID: <20231002182856.131254-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'ath12k_dp_rx_peer_tid_setup()' is the only place where
'struct hal_rx_reo_queue' object is allocated with 'kzalloc()',
call to 'memset()' in 'ath12k_hal_reo_qdesc_setup()' may be
dropped. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath12k/hal_rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index ee61a6462fdc..f6afbd8196bf 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -713,8 +713,6 @@ void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
 {
 	struct hal_rx_reo_queue_ext *ext_desc;
 
-	memset(qdesc, 0, sizeof(*qdesc));
-
 	ath12k_hal_reo_set_desc_hdr(&qdesc->desc_hdr, HAL_DESC_REO_OWNED,
 				    HAL_DESC_REO_QUEUE_DESC,
 				    REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_0);
-- 
2.41.0

