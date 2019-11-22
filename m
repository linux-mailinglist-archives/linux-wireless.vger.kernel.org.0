Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA410764A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 18:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVRRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 12:17:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37444 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 12:17:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so3774829pfn.4
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DcsslMAygnD7yk84CpnOySOl202pcz0hRl0XZbmX6aE=;
        b=TXJYr4tUxQLT/tDlv149LiKqyl5SyfcoyRy+gEP1re2sTJHvJIzdAT4StoeOUCNPdL
         G+hYzjj4lwVbuhL1GZWX1H8LgB1PXX+N3LGaLuQKDW39F1DTiEbh3eDqF8sMDSr9hPwl
         DgnVo/4fumZQQOO2JnIs4V8jpKXiHXjfbL3uafx16uNh5/pOxA9FjjTTyzv54pA8mKwO
         v+wrQTdz+Z0/PoaF6Rdb3KIrJLi70RoapcOahdZjOqCkE/Nn2u/mKBIuqLKM5XmGTdqb
         hlRn0jHCFS2uB7tpvCnS10P+EwaRV6sYSpernvOhJRZyCP+yIolgGLYSIip3fvZFwtJN
         7h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DcsslMAygnD7yk84CpnOySOl202pcz0hRl0XZbmX6aE=;
        b=saIZWanG7s1juNUeyDZt4JsvwD6BcseAN9t9VZayvNrPCjL8KQdKHonjm6y5bDSf+q
         OPjoYyYQFAUX+vyROizEsqVC/n9uGYDueKOFYy+kjekABa1igoWDCCTdcQ0S9eeIotAO
         X4g0bnJC76bDeU4akmK37BOCtXIMC4qIdLa1+npjQfdOfvaw0LyepEBFDxjkuvaPxayN
         oRUA2hei8cUcYh/ItRb0KlATxXBgT/iDs6w1BbYhh7NH540c6jWplV6L9WvhuRBlG45r
         2MDLpL9nUqblMIh1NqSisD5GNJxRDYrU3Di63AXoqATz9uKJMlrRp4cTAEZavZs78a04
         igSA==
X-Gm-Message-State: APjAAAU1OZdjjpTWNjtGVbPpQBD6on5+oAyDMniCfIfit7V2nKzkwt0Z
        FIEKsjpYZMNaHpnbZgBYYkoUb5aQ
X-Google-Smtp-Source: APXvYqyRk06TDaQoS9xpuZhJgNzN6/yhMh72e9q6em1aZXLMTNNg0O8BdQTeqNASTE2N0YogfXy39Q==
X-Received: by 2002:a62:7bd3:: with SMTP id w202mr18116892pfc.200.1574443020732;
        Fri, 22 Nov 2019 09:17:00 -0800 (PST)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id b13sm7406030pgj.28.2019.11.22.09.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 09:17:00 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/2] mac80211_hwsim: set rx_status mactime/flag for wmediumd path
Date:   Fri, 22 Nov 2019 09:14:01 -0800
Message-Id: <20191122171401.8788-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122171401.8788-1-prestwoj@gmail.com>
References: <20191122171401.8788-1-prestwoj@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch sets the required rx_status mactime and flags in order for
the parent TSF value to be calculated and sent to userspace. This is
already done elsewhere, but this patch allows this to work for the
wmediumd code path.

Signed-off-by: James Prestwood <prestwoj@gmail.com>
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

