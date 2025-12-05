Return-Path: <linux-wireless+bounces-29544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60850CA8441
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 16:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4792B3046BA6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8B03148DB;
	Fri,  5 Dec 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LggYav23";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pz3n5XlB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362212877D4
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948962; cv=none; b=vA4bpAPQJ2T0KIgIoMYbFVJn3nwMdpOxALLbVdFOqqTdnMa05N0VtcwLrzYiGTY9TRF10vBsRlICwMgg7ewXh/Pq5iRZTlkReSybuxZGK2Lb2m3WsC0eeF5aqJo8VqmP2KrgiegBko7TMZhPqELGbqfgcK7RAFUQuf8ZFrccFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948962; c=relaxed/simple;
	bh=STzMJwI116rmgDpdpGII/++01lS4bYjJuQi2WMakzRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s8EezYBK4xEX4WIjzq+F/LzYYAYLD+XuLgLjB/8qFeecYI9vSeJutzsneGAnIHDgY+3buLWEXlBXS/q8JG4/0NsGG2NMq3HxNUx5RL9pVSEG01UWj/2swAKK3pvnM5nuP6hziTTkoy7KIpsXKKvxZ86V2LB20x2p9ohP5+Lys90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LggYav23; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pz3n5XlB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764948954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JNWJCQXgH5bvny3UA4Fk9m23vdbcsYt/2+E6QHsu8TY=;
	b=LggYav23fr2/4Kk0oGQv0y6dP7huO5jJeG3MjIqXkmF1B5PnQlGtfEUK+CRoQHqUxktvs5
	KShfZyCRhYQi0rwY7gDPXbif3I52QTF2Tw/fZOdng4t3eVvxAs5aViVWZNIpGhR3ad19So
	NPQPOrsTgzF0S8We2tCmiWwaqDtZNvY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-LSO-oVAjPnKkA82VzLshxA-1; Fri, 05 Dec 2025 10:35:53 -0500
X-MC-Unique: LSO-oVAjPnKkA82VzLshxA-1
X-Mimecast-MFC-AGG-ID: LSO-oVAjPnKkA82VzLshxA_1764948953
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7d24bbb9278so4613484b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 05 Dec 2025 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764948952; x=1765553752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JNWJCQXgH5bvny3UA4Fk9m23vdbcsYt/2+E6QHsu8TY=;
        b=Pz3n5XlBb601ClnJxXwg/UdTEYmZY9QErH3gGhw/F9uHOugxryVNHmA5EWQ9D+w1X7
         z3wZ0/mtGgXbfpAdtu73d0E7sqwT+nF3YJAMz6m0Kjx2aCeCjLRa3WOlgjxCxQEryLjn
         8rGtTJLeRzUOfVC4DS2Z9PDgSUnilBB6Fv+oBhdgP48gmirhJ4wdHW3QbDmnIw+QDDq+
         Sj0F+fru73jahpboD352M1T2jPyxU4RlmRQ/s0sMePrtn0cjgFqrBHo7Nfn9g30c3ASI
         MGzcVBF2Ew0CuFxsYGjHLu4HXtrwaKiWtZoicPa8oWLz7lDOrmuIuncWhMmB7t+rKkEG
         wFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764948952; x=1765553752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNWJCQXgH5bvny3UA4Fk9m23vdbcsYt/2+E6QHsu8TY=;
        b=qqLegJNOFJCFD8bDrdFAGqTeXn+xAaSfOsxykChNHjGYoncx43J8GyKJ519fgl3pI8
         S3PV+kMKEpOkdmNNWouqRQL+PWemzvYVSUBi5XYingbEJ2BNkGn3N+lBmZTiKkDZ1iOP
         2pW/vXOKiNUS2YiZhEf2gcMb+tvc6YYh6TURULBeHpuJDr8RZe/vfXsJX9T+vPgCOtD8
         5RlZNRhTd0St4Y4qo/q+BMyXaqfJbTZkAxcXxXvbLVnjYCFC9/0YvWL09iO5yXUYBBGP
         Pjlh0ydQag8CimAHrix70rIF2VP41rh92nCMK6ogfoQgtIaIh11fz1uQvw2Si4GcHszh
         H0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVu7m/Mj1288DJdh4urA7N3z84N+EyeH2mTw97lWYoDc0QcGaH4y5borO5QhyqrT6BCFJkUaJ5vk8cwR3/6BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWz6lQHyD9dD+8Jf0j3/OtlxFO0eRPv8yvNgcaKlvj1TCrTrK
	rrpFeOd8E6mS033OkvHi4U/P4BloCcI7jL0BdFa5A52FISFWbe/d61Xb+hyYtsohS59xlnwTvSM
	KBCXZ8dr5KXVpxv8dn8DgwePYK8aEu4bNyEws1+wNP3XbUhEweVpVTNsJxCO9xUF0Zyg=
X-Gm-Gg: ASbGncs05YjUwUT3c+K7cNfSkHtq9YbbMg/iOC4jLcwJFtfLoGnpI/KiMrWPRk139he
	YN50CZCoEBegDx4pEjZfncoYkImbeGK1otMVcI2+yIqOYngmFSSo/lNe6umemjVJvUq+HVR+8y2
	ccvp4FIGwRVPteTX+zyilGV7STAwBAjcAB3q4ziE3xoh/HqXwFEoT6yXgJ//c/KvPdAk23jfXFX
	KGVP0jKq2niptw2XFuth4hlU7WzWTLk+1HN3Rf4TlzL8b7KOA3ohVpEOlWOvRHTmuzG41jgonQ+
	EVG4uzFXoMUdG15+tSzqxXYa9apDPIPvcxTxaZPbJnO7YGBTbemb2vR7AXJaxGLlFpAKEP1PIkL
	ilq1yXWky00+chrth3inaLQM24Zm6zECyF2rA7A==
X-Received: by 2002:a05:6a00:1d16:b0:7e8:43f5:bd30 with SMTP id d2e1a72fcca58-7e843f5c53fmr442939b3a.69.1764948952612;
        Fri, 05 Dec 2025 07:35:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGibYUsuTvgSXgBChTk0AFwQw2BX4f9n6aUflTsFibE6nucBaMW0HHA+YsiEu06MWKun2Rnog==
X-Received: by 2002:a05:6a00:1d16:b0:7e8:43f5:bd30 with SMTP id d2e1a72fcca58-7e843f5c53fmr442914b3a.69.1764948952222;
        Fri, 05 Dec 2025 07:35:52 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:3861:8b7f:6ae1:6229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a07213b6sm5641875b3a.26.2025.12.05.07.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:35:51 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Shaul Triebitz <shaul.triebitz@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>,
	syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com
Subject: [PATCH] mac80211_hwsim: fix divide error in mac80211_hwsim_link_info_changed
Date: Fri,  5 Dec 2025 21:05:02 +0530
Message-ID: <20251205153502.273426-1-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent a division by zero crash when userspace provides a zero beacon
interval value. The crash occurs in the beacon timer setup code path when
info->beacon_int is 0, causing bcn_int to be 0 and triggering a divide
error in the do_div() macro.The issue can be triggered from userspace via
nl80211/cfg80211 when configuring a virtual interface in AP mode with an
invalid beacon interval.

Fixes: e57f8a489c29 ("wifi: mac80211_hwsim: send a beacon per link")
Reported-by: syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5bb5f06f99924ea0cf86
Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 5903d82e1ab1..e67e2c989ea6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2595,11 +2595,14 @@ static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
 			link_data->beacon_int = info->beacon_int * 1024;
 			tsf = mac80211_hwsim_get_tsf(hw, vif);
 			bcn_int = link_data->beacon_int;
-			until_tbtt = bcn_int - do_div(tsf, bcn_int);
+			/* Proceed only when bcn_int != 0 */
+			if (bcn_int) {
+				until_tbtt = bcn_int - do_div(tsf, bcn_int);
 
-			hrtimer_start(&link_data->beacon_timer,
-				      ns_to_ktime(until_tbtt * NSEC_PER_USEC),
-				      HRTIMER_MODE_REL_SOFT);
+				hrtimer_start(&link_data->beacon_timer,
+					      ns_to_ktime(until_tbtt * NSEC_PER_USEC),
+					      HRTIMER_MODE_REL_SOFT);
+			}
 		} else if (!info->enable_beacon) {
 			unsigned int count = 0;
 			ieee80211_iterate_active_interfaces_atomic(
-- 
2.51.1


