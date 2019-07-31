Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E9A7B737
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 02:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGaAdT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 20:33:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34238 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfGaAdS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 20:33:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so68381247otk.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2019 17:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zl/XIPtA8PCHSdRUvmWg2RJfRMVKA10rT4L5zhVQ3Z0=;
        b=QqxcjIPwLYxmHIX09RaIhiO+ayskkd/WMmrpQtHUI1ZXFTYySLzjWuVDMu+9ZHOFAo
         r2I+G8lzPDBirB7wBpZoG+a03FNpHwgt+gEI2XMQpWXgBoFYduQqZXKwRqZQgN8eIiev
         47MAM/M4W1bS1WT7g6Hg9wiL0+dp50T+ETw2ShJwaD0MX+mJzkeZ5NgR3S+1Vgpc00sR
         PIbML0iAfkBriQaWgGm/dWNCLTLS8jWzOI9AMPfyN2bKWrknw2AsiuPYj6zfstQPQdtR
         lpE1J9V0MtnGIZQ235ZaHuepMMIIEMLa5OFG3zlZcUE5zKNN6cDATuxhHpMajraLXRd9
         M5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Zl/XIPtA8PCHSdRUvmWg2RJfRMVKA10rT4L5zhVQ3Z0=;
        b=pCRT2DtQj57246DXnW0nodtlMDLtKFUhekEmw5DtthyxIxm5ToB1X5F9naz2rHj+xn
         9EeviZLIgAFRSON0ZBCfzNQEAbGYYEuMK1K9QuQOAShJCBEA99EjkBOuPInzFBkv9jhb
         WRnINlwC+yMKdKTXzsgLvf7LnyOvDBXP5tEJ68XlUIxLO2mCBRu2EHHBzH2pQ21H1s/k
         XcyCs+ru2QPb5y/KCNcxYQK9eHB/4ExhqEk5Au/qzB+XOba1VwY4Pc381df/uoWEy2vG
         Pn6SNBOJeRESj+j3HcKe1KPI9xCdNhoNnNwZeX9oZfZ/AntGoUdRpwKXKDkFr+MtqoIr
         W/Hw==
X-Gm-Message-State: APjAAAVgPiGwIg1FTW9g2QTwY1nuzqhp0zaTQlAZFbxggE2EU9/eaf+T
        MeSIU0JOXN6PBDc4+XFagAw=
X-Google-Smtp-Source: APXvYqysLlPx9oXjXQIdJ7+vqnoZ6xhy7PMCWbeAqD3nsffA6mIpFx8nLe6/CXN5xgB7sSgecFtNXg==
X-Received: by 2002:a05:6830:1aeb:: with SMTP id c11mr22590907otd.230.1564533197813;
        Tue, 30 Jul 2019 17:33:17 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t11sm22156016otq.13.2019.07.30.17.33.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 17:33:17 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 5/5] rtlwifi: rtl8188ee: Remove local configuration variable
Date:   Tue, 30 Jul 2019 19:33:04 -0500
Message-Id: <20190731003304.14377-6-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
References: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The configuration variable IS_LITTLE_ENDIAN is replaced by the standard
__LITTLE_ENDIAN. In addition, an unused struct is removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../net/wireless/realtek/rtlwifi/rtl8188ee/trx.h   | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
index 4e3682ded89e..bd862732d6ae 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
@@ -560,17 +560,7 @@ static inline void clear_pci_tx_desc_content(__le32 *__pdesc, int _size)
 	 rxmcs == DESC92C_RATE5_5M ||\
 	 rxmcs == DESC92C_RATE11M)
 
-#define IS_LITTLE_ENDIAN	1
-
-struct phy_rx_agc_info_t {
-	#if IS_LITTLE_ENDIAN
-		u8	gain:7, trsw:1;
-	#else
-		u8	trsw:1, gain:7;
-	#endif
-};
 struct phy_status_rpt {
-	struct phy_rx_agc_info_t path_agc[2];
 	u8	ch_corr[2];
 	u8	cck_sig_qual_ofdm_pwdb_all;
 	u8	cck_agc_rpt_ofdm_cfosho_a;
@@ -587,7 +577,7 @@ struct phy_status_rpt {
 	u8	stream_target_csi[2];
 	u8	sig_evm;
 	u8	rsvd_3;
-#if IS_LITTLE_ENDIAN
+#if defined(__LITTLE_ENDIAN)
 	u8	antsel_rx_keep_2:1;	/*ex_intf_flg:1;*/
 	u8	sgi_en:1;
 	u8	rxsc:2;
@@ -595,7 +585,7 @@ struct phy_status_rpt {
 	u8	r_ant_train_en:1;
 	u8	ant_sel_b:1;
 	u8	ant_sel:1;
-#else	/* _BIG_ENDIAN_	*/
+#else	/* __BIG_ENDIAN	*/
 	u8	ant_sel:1;
 	u8	ant_sel_b:1;
 	u8	r_ant_train_en:1;
-- 
2.22.0

