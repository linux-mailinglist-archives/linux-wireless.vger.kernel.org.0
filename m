Return-Path: <linux-wireless+bounces-25768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF5B0CC57
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 23:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6CA541E0D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D623BD14;
	Mon, 21 Jul 2025 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="cvKsHcRR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22704219E93
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132674; cv=none; b=mbT6gYogQDIiIg5H4LAIFsL6nxFmPHwU3fEEXy9ZLFjmc+HxTtkre1lwSmcH/o2a1FNh6kdeF0UE5oucF7scY8UpqBs/4JdXlhfQjl4t+v96ojMoYFiHasLLosbQkjPsBZ5sPM+XD4qWxoDWsE8+S5k7JTC7JisRCV/u/BYu1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132674; c=relaxed/simple;
	bh=asjzcL5bKXbHsPRRuRDoc3MuFgJNWjAkYi1r5Te+OFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ixdw7elePPICzxFZDKaplpTcYslzYdIyWvUTZYJKXtoENbVPENp8hQXroqBg7VoU1IT4iPO+2zOcbF0V0q228v1/tBUDK6Jzexkiqw/pt+4wHpqMsJIM3uu0uA+2O6wmqng8sUp+d1LGKo0NF28MyULC4XX2wi7hBrHF18GtUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=cvKsHcRR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae361e8ec32so834001066b.3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1753132671; x=1753737471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvibZhXIw4vQD8ie8qCh/zcgb3xWyca2awyE3W0nCIY=;
        b=cvKsHcRRJnSnk0tSSHZ9/6ktiD0xJd12+c5D+xkbM2tVi20Gn2BaxHW+cAfxXHJ4Ha
         VcnO2Y9RqcDgD0cGEP9Zn2sw1VpMLFbuI59ulaxghrzMHI2T7R0KsZGyEFKN82S1sKD0
         ca4f9s5dchRigp1awf+RzoOllayNOln8vLJD+LotOo18uTHvG5WsgiCL7+dJ24FL5aEB
         E7mtW2CdYqTovEwk2iuuNByaAnLFudblaQu+n/K2u8S+HSAf6NYmpF4PlQONk2KAMaF8
         4aW4pe8COQCyHtSHTZtsKQ4YMtXVjazLXHL8NyztHsvDHVq9BhYpBeTzSEGwsqWeEd41
         0s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753132671; x=1753737471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvibZhXIw4vQD8ie8qCh/zcgb3xWyca2awyE3W0nCIY=;
        b=qp1dtTED+hNB96v+3f3pow1c5rNAqFFl/dMLQL2MUUChS+UTSwpW6RmpPmrCW4GdPs
         W4X/Dqo08BBaewEPE9FOPD882AKwW6Ny/vRicjSEtnoNKlyqBKzl8hP/OLkJIMRNdZ4h
         MP3Pi3UseP7xeBGXwKicxhmsYnxPR7TMTZZr0CGvHjhYblFok6NiMcKuLEVxdac421lE
         3a0POQvLp5yeY1A6W75i6vsCFFy26pnBMHA07+wJezHjfIYd55W0gd7CapCjOceT1tzw
         3xDTB5PxschC3HgFbksBIw3W5C4qSZizeojpQAf7BCxnU1P0Wkx7k/K1pwaaMm4t3WHl
         kQpA==
X-Gm-Message-State: AOJu0Yz4Rkm3IXktRc8LWfalk6208j9m+nPW188DtCVL/YVpp5p25rPh
	WLTew0/DWClGMg3lZvzqe6htS+vhC5AiqUiZJ8vzhV9IZLAcSZj5Z+24zUE/Yov8pabaNE2VcMv
	RcOL9ndjI2A==
X-Gm-Gg: ASbGncvSAuLsck4mXXTvRbzJvfPkd/HFSzBNrau4QMz1OOuouaFrZSuHdM7oQAnIHld
	2JIp/nb9H7lqFC/o/rlotwlF+iUfksIoVeKz2uYjV66r2IOhm6LxqnA6JBun0nMs/NIp34gQPJY
	k4uyzh+tEJoBjsHPSsKISQqt3xF6evTvCRq4uaskqZ5yMFLTLLeYoePGauqBwli0QOoHvsvzytt
	dHBqRWo6z3HmxZryMgQn21lqOM1e1oWbO1rpprMaMDw1USM1p9VrJYCFYY17/118G3xnKIdA6cP
	qIpbmqW2JUhxGIyo3LPaedvAVRQ+cFvaNEIREBlj2BhWNcZ843HtNtkE3B5i3ExiHSnUyXmrTMK
	W4qp/DMm7XEdEMNsFhBZv6ByxasacAB34nNpeaE/kpiIjs9yi
X-Google-Smtp-Source: AGHT+IFtjTQjuF7yEGbNQTUWgaiEiIyUPuhYCDuxEiTpC1RFN9H78koupNR+sK/1XDvA45XdpnoS3g==
X-Received: by 2002:a17:907:f1c5:b0:ad1:e4e9:6b4f with SMTP id a640c23a62f3a-ae9c9b14a30mr2411321566b.36.1753132671277;
        Mon, 21 Jul 2025 14:17:51 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:834d:bc8d:cdb5:bc29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d68a1sm740639866b.46.2025.07.21.14.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:17:50 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: linux-wireless@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH] wifi: mac80211: fix unassigned variable access
Date: Mon, 21 Jul 2025 23:17:36 +0200
Message-ID: <20250721211736.29269-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ieee80211_latest_active_link_conn_timeout() we loop over all
sta->links in order to compute the timeout expiring last across
all links.

Such timeout is stored in `latest_timeout` which is used in the
time_after() comparison before having been initialized.

Should the for-loop terminate without ever setting `latest_timeout`
we would even return it in its uninitialized state.

Fix this behaviour by initializing the variable to its minimum
value 0.

Address-Coverity-ID: 1647986 ("Uninitialized variables (UNINIT)")
Fixes: 1bc892d76a6f ("wifi: mac80211: extend connection monitoring for MLO")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b4b7ea52c65e..0d96490510bf 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8521,7 +8521,7 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 static unsigned long
 ieee80211_latest_active_link_conn_timeout(struct ieee80211_sub_if_data *sdata)
 {
-	unsigned long latest_timeout;
+	unsigned long latest_timeout = 0;
 	unsigned int link_id;
 	struct sta_info *sta;
 
-- 
2.49.1


