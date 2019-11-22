Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9310763B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 18:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfKVRJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 12:09:15 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37504 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 12:09:15 -0500
Received: by mail-pj1-f67.google.com with SMTP id f3so3296126pjg.4
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 09:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B9Jv/xAwTMBr/SQQOmML2Im6jUVdZ8hkN/604W9MSNM=;
        b=Otz1x5SZr4Ai4oe618yeoJtEUqcNl6T2x+sPkbyjFGhdufiMyR4qnEDfLosMF/jMS5
         KOQdJaSgAsknJFLwAMBn8ydfGWQgAEDgHlkFAYyfYSboq7hOp7hv6B7EMScnza7+ysQm
         jdKNfIJHdDWoJ3Uo5If+7bexsoochJMo6HcO+Lb3XwMaJZpuYbK+ezR+NfiyIDC+sYG6
         E8VcscIUqx9VOgovYnnGSZeaW/NgyBwVCnOXLxxz0+KGaMOLxM10DZxdvyTIW8JtnmMN
         GUNs3/6fo3noEhQtf+PimP8WNaqgkPVUM3isvE/ek84YbjbITsIGPfnsSepGH7D7T0sh
         GPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B9Jv/xAwTMBr/SQQOmML2Im6jUVdZ8hkN/604W9MSNM=;
        b=cyozt/njtBfuVaCZed7G0dcyna02DjxxszsRxFwdmcefcr+ypwaGseXXJk0XanKlUP
         WUYlxp1C3tb0AeFj4dfZYS6z8PrIB4flOsfqRgriMZTetCc3q8mOnJjdaecfAAE7FTRh
         OopPyPxkPupMA2puNHBug6MzsLjf0trGX33a5rPI7ZeNGp0J9l5GRs1mACz6hPq47tx5
         8XoAlyv76Sed6ZZBBRrAI/UNZAS7hyIkuJBioMUzXaP4XCvEa9Q/KDctOWLyt96jouJu
         OzPvVNwkgW5yrWZvRRD3MBa2mpeDmXymxfujvvx+ejdKKXM6BIJx7MNkPebEJtpuyMOU
         4nlg==
X-Gm-Message-State: APjAAAVQz6ueJWG40fk2ozOfHnOio3LDnAvnKHqfIUiuSwQ3U1gFz1pN
        2vl/mEyZO709QAcnpbMoQHoLEbrs
X-Google-Smtp-Source: APXvYqy8iOInsv2Xi21sBpFzRihKzdOHRvkE+eYK6IpgE/r3NQZTDgiJHqd/V+tjcYnzDFSqOcBUew==
X-Received: by 2002:a17:90a:ab98:: with SMTP id n24mr20264104pjq.96.1574442552579;
        Fri, 22 Nov 2019 09:09:12 -0800 (PST)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id c2sm7834386pfn.55.2019.11.22.09.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 09:09:12 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] mac80211_hwsim: set rx_status mactime/flag for wmediumd path
Date:   Fri, 22 Nov 2019 09:06:12 -0800
Message-Id: <20191122170612.8123-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122170612.8123-1-prestwoj@gmail.com>
References: <20191122170612.8123-1-prestwoj@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch sets the required rx_status mactime and flags in order for
the parent TSF value to be calculated and sent to userspace. This is
already done elsewhere, but this patch allows this to work for the
wmediumd code path.
---
 drivers/net/wireless/mac80211_hwsim.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index e9bc599481d4..01b2ac9707cc 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3238,6 +3238,8 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	int frame_data_len;
 	void *frame_data;
 	struct sk_buff *skb = NULL;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb_2->data;
+	u64 now;
 
 	if (!info->attrs[HWSIM_ATTR_ADDR_RECEIVER] ||
 	    !info->attrs[HWSIM_ATTR_FRAME] ||
@@ -3300,6 +3302,18 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	rx_status.rate_idx = nla_get_u32(info->attrs[HWSIM_ATTR_RX_RATE]);
 	rx_status.signal = nla_get_u32(info->attrs[HWSIM_ATTR_SIGNAL]);
 
+	if (ieee80211_is_beacon(hdr->frame_control) ||
+	    ieee80211_is_probe_resp(hdr->frame_control)) {
+		rx_status.boottime_ns = ktime_get_boottime_ns();
+		now = data2->abs_bcn_ts;
+	} else {
+		now = mac80211_hwsim_get_tsf_raw();
+	}
+
+	rx_status.mactime = now + data2->tsf_offset;
+
+	rx_status.flag |= RX_FLAG_MACTIME_START;
+
 	memcpy(IEEE80211_SKB_RXCB(skb), &rx_status, sizeof(rx_status));
 	data2->rx_pkts++;
 	data2->rx_bytes += skb->len;
-- 
2.17.1

