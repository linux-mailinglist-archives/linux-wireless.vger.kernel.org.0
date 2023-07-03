Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F87460AE
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGCQZK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGCQZJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 12:25:09 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED503185
        for <linux-wireless@vger.kernel.org>; Mon,  3 Jul 2023 09:25:07 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:859f:0:640:3817:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id C0EA160035;
        Mon,  3 Jul 2023 19:25:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4PUox83WqeA0-ZC79cQlx;
        Mon, 03 Jul 2023 19:25:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688401505;
        bh=5UxoV8t7k+GjAdnKRMbEiyphbIcPfjiruHypdxFvydk=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=a1bUwnXa9+HIpZfaZWO0yFcOMomKOl0Y4cXWxenCn6A7lZ2F7A3SI11pdp8gZMEJW
         bGUdp5TyCRbAWymdh4lCT7ir1h/eBT/kX5mQn2vuxSnIA0ZlyRdXSw+C1XtKbRBWVx
         9K6PELE7aeA3Wl6Qrq94P2hShW+6MobQPNQSpycM=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: brcmfmac: use generic lists to manage TDLS entries
Date:   Mon,  3 Jul 2023 19:24:40 +0300
Message-ID: <20230703162458.155942-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prefer generic lists over ad-hoc quirks to manage TDLS
entries, adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../broadcom/brcm80211/brcmfmac/flowring.c    | 69 ++++++-------------
 .../broadcom/brcm80211/brcmfmac/flowring.h    |  4 +-
 2 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
index e1127d7e086d..acd3a7b5231d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.c
@@ -44,13 +44,9 @@ brcmf_flowring_is_tdls_mac(struct brcmf_flowring *flow, u8 mac[ETH_ALEN])
 {
 	struct brcmf_flowring_tdls_entry *search;
 
-	search = flow->tdls_entry;
-
-	while (search) {
+	list_for_each_entry(search, &flow->tdls_entries, list)
 		if (memcmp(search->mac, mac, ETH_ALEN) == 0)
 			return true;
-		search = search->next;
-	}
 
 	return false;
 }
@@ -365,6 +361,7 @@ struct brcmf_flowring *brcmf_flowring_attach(struct device *dev, u16 nrofrings)
 		flow->dev = dev;
 		flow->nrofrings = nrofrings;
 		spin_lock_init(&flow->block_lock);
+		INIT_LIST_HEAD(&flow->tdls_entries);
 		for (i = 0; i < ARRAY_SIZE(flow->addr_mode); i++)
 			flow->addr_mode[i] = ADDR_INDIRECT;
 		for (i = 0; i < ARRAY_SIZE(flow->hash); i++)
@@ -385,8 +382,7 @@ void brcmf_flowring_detach(struct brcmf_flowring *flow)
 {
 	struct brcmf_bus *bus_if = dev_get_drvdata(flow->dev);
 	struct brcmf_pub *drvr = bus_if->drvr;
-	struct brcmf_flowring_tdls_entry *search;
-	struct brcmf_flowring_tdls_entry *remove;
+	struct brcmf_flowring_tdls_entry *remove, *tmp;
 	u16 flowid;
 
 	for (flowid = 0; flowid < flow->nrofrings; flowid++) {
@@ -394,12 +390,11 @@ void brcmf_flowring_detach(struct brcmf_flowring *flow)
 			brcmf_msgbuf_delete_flowring(drvr, flowid);
 	}
 
-	search = flow->tdls_entry;
-	while (search) {
-		remove = search;
-		search = search->next;
+	list_for_each_entry_safe(remove, tmp, &flow->tdls_entries, list) {
+		list_del(&remove->list);
 		kfree(remove);
 	}
+
 	kfree(flow->rings);
 	kfree(flow);
 }
@@ -433,24 +428,19 @@ void brcmf_flowring_delete_peer(struct brcmf_flowring *flow, int ifidx,
 	struct brcmf_bus *bus_if = dev_get_drvdata(flow->dev);
 	struct brcmf_pub *drvr = bus_if->drvr;
 	struct brcmf_flowring_hash *hash;
-	struct brcmf_flowring_tdls_entry *prev;
-	struct brcmf_flowring_tdls_entry *search;
+	struct brcmf_flowring_tdls_entry *search = NULL, *tmp;
 	u32 i;
 	u16 flowid;
 	bool sta;
 
 	sta = (flow->addr_mode[ifidx] == ADDR_INDIRECT);
 
-	search = flow->tdls_entry;
-	prev = NULL;
-	while (search) {
-		if (memcmp(search->mac, peer, ETH_ALEN) == 0) {
+	list_for_each_entry(tmp, &flow->tdls_entries, list)
+		if (memcmp(tmp->mac, peer, ETH_ALEN) == 0) {
+			search = tmp;
 			sta = false;
 			break;
 		}
-		prev = search;
-		search = search->next;
-	}
 
 	hash = flow->hash;
 	for (i = 0; i < BRCMF_FLOWRING_HASHSIZE; i++) {
@@ -463,12 +453,9 @@ void brcmf_flowring_delete_peer(struct brcmf_flowring *flow, int ifidx,
 	}
 
 	if (search) {
-		if (prev)
-			prev->next = search->next;
-		else
-			flow->tdls_entry = search->next;
+		list_del(&search->list);
 		kfree(search);
-		if (flow->tdls_entry == NULL)
+		if (list_empty(&flow->tdls_entries))
 			flow->tdls_active = false;
 	}
 }
@@ -478,31 +465,15 @@ void brcmf_flowring_add_tdls_peer(struct brcmf_flowring *flow, int ifidx,
 				  u8 peer[ETH_ALEN])
 {
 	struct brcmf_flowring_tdls_entry *tdls_entry;
-	struct brcmf_flowring_tdls_entry *search;
 
-	tdls_entry = kzalloc(sizeof(*tdls_entry), GFP_ATOMIC);
-	if (tdls_entry == NULL)
-		return;
+	list_for_each_entry(tdls_entry, &flow->tdls_entries, list)
+		if (memcmp(tdls_entry->mac, peer, ETH_ALEN) == 0)
+			return;
 
-	memcpy(tdls_entry->mac, peer, ETH_ALEN);
-	tdls_entry->next = NULL;
-	if (flow->tdls_entry == NULL) {
-		flow->tdls_entry = tdls_entry;
-	} else {
-		search = flow->tdls_entry;
-		if (memcmp(search->mac, peer, ETH_ALEN) == 0)
-			goto free_entry;
-		while (search->next) {
-			search = search->next;
-			if (memcmp(search->mac, peer, ETH_ALEN) == 0)
-				goto free_entry;
-		}
-		search->next = tdls_entry;
+	tdls_entry = kzalloc(sizeof(*tdls_entry), GFP_ATOMIC);
+	if (tdls_entry) {
+		memcpy(tdls_entry->mac, peer, ETH_ALEN);
+		list_add_tail(&tdls_entry->list, &flow->tdls_entries);
+		flow->tdls_active = true;
 	}
-
-	flow->tdls_active = true;
-	return;
-
-free_entry:
-	kfree(tdls_entry);
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h
index 818882b0fd01..e7bfb5495aaf 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/flowring.h
@@ -32,7 +32,7 @@ struct brcmf_flowring_ring {
 
 struct brcmf_flowring_tdls_entry {
 	u8 mac[ETH_ALEN];
-	struct brcmf_flowring_tdls_entry *next;
+	struct list_head list;
 };
 
 struct brcmf_flowring {
@@ -43,7 +43,7 @@ struct brcmf_flowring {
 	enum proto_addr_mode addr_mode[BRCMF_MAX_IFS];
 	u16 nrofrings;
 	bool tdls_active;
-	struct brcmf_flowring_tdls_entry *tdls_entry;
+	struct list_head tdls_entries;
 };
 
 
-- 
2.41.0

