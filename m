Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C505D3D4A49
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 23:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhGXVJQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 17:09:16 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58616
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230274AbhGXVJN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 17:09:13 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id C480E3F34A
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 21:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163383;
        bh=8/lOVqtLlrSxrgAjgKwuhobiXfoOTrJXfIMYxVc5wEI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=s3LnT4fX07tFkyv7jJLo5bfZnH+XuIKT4JpKAlKh7hZ+8EmLtBbnkaYuvx5rSFfhL
         aD6xK5CTqq+oyVb5rxisTJvIj/6+MArm5ls4b2OeE7IG3HuzMXOLaqAStUIgO+81g4
         qOyu785RGyGFTBnStz5Bhv+fmIdfiH6w3btFln+a9oJAv80AB1eCxmwo///jdxTuhO
         02eCNTxCC0n/Z7uAfcGF668ZnjPzWBItIrPZJwaIcOvp5EY1PPnv7ipu2z/mO9Fn1M
         EuhoYFD2qt9LPObcjBiI8IOlt7/rVvqIQpZQ0axfs0dU8Q5D0Ry49IwQezS38O4cqr
         pQpmmVMyOXDfQ==
Received: by mail-ed1-f70.google.com with SMTP id b13-20020a056402278db029039c013d5b80so2804532ede.7
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 14:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/lOVqtLlrSxrgAjgKwuhobiXfoOTrJXfIMYxVc5wEI=;
        b=e04RM53bsVt04RFxFd8TofP2E+jKQXtgnwOFcvVbfuQX9heRVtvipxoLYSORREgxGf
         jwOxbGUfN7J9blaM0DGdpmjajxs6YTbV5EygK2dddpnBVC8+JikVAZBCUTOVe6Ida6nc
         rhq1ffFpMqKQqRvHqhoaK5qMbs970OROGHTx/xUfAA2S23aRldLDybBx8yR5+GTFuHt6
         BJWvHP/RoLk96mURYiCojBoPKQ9v10SXPIb1h7OagIYeyJkwf+ZkERga+iW9XM1cmOLP
         3oCismWrrpqGG6S9iziTNxqAu/EcPZ8vwYx8tMaTGXfQNYe39f4foRq8pRTCaAHulLlP
         3aQA==
X-Gm-Message-State: AOAM533x6iVDg3CHQ0XXQFAiBA0JGDgpiv5C3FAVECB3HvaqIWK8v6Cb
        3OErwF2kXYpgdJvJGCnNT4L/E3xPFuHBdK/7U1amvQGYvkl3HZprVDa0rB89uWdtRrfHd0rqcSC
        DYyI6q01tiOaNdg6qt5O9R1bm9nSRDGxuyP8kZGh+ZSvW
X-Received: by 2002:a17:906:d8a7:: with SMTP id qc7mr3971696ejb.372.1627163383056;
        Sat, 24 Jul 2021 14:49:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya/AXEPictz92OXpo2PxX7m6G5Q6xQNJW0Zkvfy1aeBNxUMcplrM79QV8bZACZbD1hbJCwVw==
X-Received: by 2002:a17:906:d8a7:: with SMTP id qc7mr3971683ejb.372.1627163382928;
        Sat, 24 Jul 2021 14:49:42 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id s10sm12821908ejc.39.2021.07.24.14.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:49:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 07/12] nfc: constify pointer to nfc_vendor_cmd
Date:   Sat, 24 Jul 2021 23:49:23 +0200
Message-Id: <20210724214928.122096-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Neither the core nor the drivers modify the passed pointer to struct
nfc_vendor_cmd, so make it a pointer to const for correctness and
safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st-nci/vendor_cmds.c   | 2 +-
 drivers/nfc/st21nfca/vendor_cmds.c | 2 +-
 include/net/nfc/hci.h              | 2 +-
 include/net/nfc/nci_core.h         | 2 +-
 include/net/nfc/nfc.h              | 4 ++--
 net/nfc/netlink.c                  | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nfc/st-nci/vendor_cmds.c b/drivers/nfc/st-nci/vendor_cmds.c
index 94b600029a2a..30d2912d1a05 100644
--- a/drivers/nfc/st-nci/vendor_cmds.c
+++ b/drivers/nfc/st-nci/vendor_cmds.c
@@ -371,7 +371,7 @@ static int st_nci_manufacturer_specific(struct nfc_dev *dev, void *data,
 	return nfc_vendor_cmd_reply(msg);
 }
 
-static struct nfc_vendor_cmd st_nci_vendor_cmds[] = {
+static const struct nfc_vendor_cmd st_nci_vendor_cmds[] = {
 	{
 		.vendor_id = ST_NCI_VENDOR_OUI,
 		.subcmd = FACTORY_MODE,
diff --git a/drivers/nfc/st21nfca/vendor_cmds.c b/drivers/nfc/st21nfca/vendor_cmds.c
index 62332ca91554..74882866dbaf 100644
--- a/drivers/nfc/st21nfca/vendor_cmds.c
+++ b/drivers/nfc/st21nfca/vendor_cmds.c
@@ -295,7 +295,7 @@ static int st21nfca_hci_loopback(struct nfc_dev *dev, void *data,
 	return r;
 }
 
-static struct nfc_vendor_cmd st21nfca_vendor_cmds[] = {
+static const struct nfc_vendor_cmd st21nfca_vendor_cmds[] = {
 	{
 		.vendor_id = ST21NFCA_VENDOR_OUI,
 		.subcmd = FACTORY_MODE,
diff --git a/include/net/nfc/hci.h b/include/net/nfc/hci.h
index b35f37a57686..2daec8036be9 100644
--- a/include/net/nfc/hci.h
+++ b/include/net/nfc/hci.h
@@ -168,7 +168,7 @@ void nfc_hci_set_clientdata(struct nfc_hci_dev *hdev, void *clientdata);
 void *nfc_hci_get_clientdata(struct nfc_hci_dev *hdev);
 
 static inline int nfc_hci_set_vendor_cmds(struct nfc_hci_dev *hdev,
-					  struct nfc_vendor_cmd *cmds,
+					  const struct nfc_vendor_cmd *cmds,
 					  int n_cmds)
 {
 	return nfc_set_vendor_cmds(hdev->ndev, cmds, n_cmds);
diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index e7118e0cc3b1..00f2c60971d7 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -343,7 +343,7 @@ static inline void *nci_get_drvdata(struct nci_dev *ndev)
 }
 
 static inline int nci_set_vendor_cmds(struct nci_dev *ndev,
-				      struct nfc_vendor_cmd *cmds,
+				      const struct nfc_vendor_cmd *cmds,
 				      int n_cmds)
 {
 	return nfc_set_vendor_cmds(ndev->nfc_dev, cmds, n_cmds);
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index 2cd3a261bcbc..31672021d071 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -188,7 +188,7 @@ struct nfc_dev {
 
 	struct rfkill *rfkill;
 
-	struct nfc_vendor_cmd *vendor_cmds;
+	const struct nfc_vendor_cmd *vendor_cmds;
 	int n_vendor_cmds;
 
 	struct nfc_ops *ops;
@@ -297,7 +297,7 @@ void nfc_send_to_raw_sock(struct nfc_dev *dev, struct sk_buff *skb,
 			  u8 payload_type, u8 direction);
 
 static inline int nfc_set_vendor_cmds(struct nfc_dev *dev,
-				      struct nfc_vendor_cmd *cmds,
+				      const struct nfc_vendor_cmd *cmds,
 				      int n_cmds)
 {
 	if (dev->vendor_cmds || dev->n_vendor_cmds)
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index 722f7ef891e1..70467a82be8f 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -1531,7 +1531,7 @@ static int nfc_genl_vendor_cmd(struct sk_buff *skb,
 			       struct genl_info *info)
 {
 	struct nfc_dev *dev;
-	struct nfc_vendor_cmd *cmd;
+	const struct nfc_vendor_cmd *cmd;
 	u32 dev_idx, vid, subcmd;
 	u8 *data;
 	size_t data_len;
-- 
2.27.0

