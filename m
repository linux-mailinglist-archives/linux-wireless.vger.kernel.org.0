Return-Path: <linux-wireless+bounces-20554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE3CA68A72
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 12:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9948D1B60A7F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB422566DE;
	Wed, 19 Mar 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGOLw98S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39EE253F07;
	Wed, 19 Mar 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381924; cv=none; b=LiZo7U+Q62G86y8oHT2jgVcFSaorrgUiTI9ivEnJ2IX4xAcgztx7BJjLcL+G8uNJBiTIY/6xGOiYnXeWDkKmOk6B5TDQNnESpY20fDEM3r9f6Ds9YZXkbz0/engc9PJ84U2MwCHJBo4qJiyQUC0363NHYsugT9pFhwK42R2a7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381924; c=relaxed/simple;
	bh=GG69JLLoOuUL0wJ0ZzPJER+gIZp4fGEUyLdiv+8TA5o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=m7pG0CGMorzEmd1AktEms54XvWoRKlxdronQpse2S0hHIDQzelLhLoa8bGJmyyJwdCZ/EQDiDClz8kW1IdzmdHa1sUF4DGcDkfLVDx568u9baJUS3KzEy2LhWOTdvwG7rKCrZohA9ePe9R2syDaEpjNvbdh2/f2PjNYBBKVBZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGOLw98S; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac27cb35309so1103056966b.2;
        Wed, 19 Mar 2025 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742381920; x=1742986720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ik3Mc4xzUUk7uaUjBM/0ZhWS7W+RmxrqI/uvK4A1d8=;
        b=WGOLw98Su4r36pzHuUPbQriBiKEzZiFCDaGoHzxiKXnMgT8PxSTr5Z2f5BuKqO6cWE
         QtMlQoFCsNfAP+t9zcDM7dROhg4P7khZMWSGaotjXQVYfRdHF44w9kNlfSu5v65/g+Rx
         Is1fVoQUx/h0lH4mZBcENff/pJ4FVk/IM67CmLagb/990hTA9H1uIxKtrvmit0KXr/hg
         8fphcaWMjeuveSu5eUyWo81fctvRYs4o+YrsjormJIKwdTtDWAOZic7LPmPLw70ZwjYU
         AA9SNmG6qI1fgB+lDAylbjpzHIc/M7+VTC5mYS1h/pnLZ5Jm2WBbuR5oXvDLkoD6+/Wq
         oemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742381920; x=1742986720;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ik3Mc4xzUUk7uaUjBM/0ZhWS7W+RmxrqI/uvK4A1d8=;
        b=f8hbQru30Nwj93GfJNXATP1A/8z01NaH6cit2QPiP1UVzGUeNe/3ouHckgxc0A/OAS
         XbINC+mh2jebFWAyINAtrDvxyRxJyQnrQS/u+HXI8JrhWg2T15JRaYQWBLzh6cPTc+sj
         nQaltwBk3LIGLQO9DLz3akaNyVsWibc6EjZiHyeF2d4TkdARfJAXO9IPePXY4B+f94kp
         8Mv2RvDech1CwhqIP1eq3OMAKwIWckYg3AjlO27S0ptorgAwO4WHF5DIrItdMJuD47+g
         SUv90vvE9UYEFr1Ux3+Q8D0HE6+25ueiQnyVGXHUj1RFEN95bMA/H1lO/O2rQHFa3Xqi
         gMfQ==
X-Gm-Message-State: AOJu0YxKQS47RcX/s5misaZ3+Hmt4rBeXMTJp7CM5AHD+9J0x6d7kMGx
	2FMz1QczBeUvzPcErcL9YCuzidcMdwckFbC+qKGIR48eHdFJQw/CuC05qA==
X-Gm-Gg: ASbGnct2ENC3KDcIiFNjVk5Pv2oGp3Cn06SgtKafO8xhsgIdeSAH1RCWiskcIFZqQKw
	/0zQDi3h1hZWgNHEG6HR3JX3/Bv2IZgS5b2uTBN8ckU/vvgEBB6ZM01RC/RJ2jHJwIT8o4QIdwa
	3B2Oc2kdztnBIN0al6n0/NK8WqC9qrxNPDkLlDwVlaEG8XvvD6WE7m/7JfZEgT62a7tfW+1MZ27
	Juu6EhMhgRaFymMlIqmPpR5Nwoy0EoL8aFK0P9J2cf+i7IlWqeUTUASZ644RGPBTy9Fvo7Rov1c
	tz0viWF0tNnaI9tanoYQzOaIl3qAHWl/1NzWDrTjNT37PITL/POXShXJ
X-Google-Smtp-Source: AGHT+IEA4wGMOrfrFB28sPI1conHykoHDMtFe8KhhCBHyyVNl/gBla+annAxFEWF+pD79/nB8whX5g==
X-Received: by 2002:a17:906:7953:b0:ac3:8896:416f with SMTP id a640c23a62f3a-ac3b7c377c7mr185093266b.15.1742381919525;
        Wed, 19 Mar 2025 03:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cfa1fsm989613066b.87.2025.03.19.03.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:58:38 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <69c63a19-5419-4bbe-858f-6ca100345a28@orange.com>
Date: Wed, 19 Mar 2025 11:58:30 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH] mac80211: clip ADDBA instead of bailing out
To: linux-wireless@vger.kernel.org
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20250317163902.1893378-1-sashal@kernel.org>
 <20250317163902.1893378-2-sashal@kernel.org>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <20250317163902.1893378-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When a Linux Wifi{4,5} device talks to a Wifi6 AP, if the AP proposes a Block
Acknowledgement aggregation size (ADDBA) exceeding its expectations, the code in
mac80211 just bails out, rejecting the aggregation. This yields a big
performance penalty on the ack path, which is observable in comparison with
other OSes (Windows and MacOS) which "play smarter" and accept the proposal with
a "clipped" size.

A typical scenario would be:

  AP -> Device : ADDBA_request(size=256)

Current Linux reaction:

  Device -> AP : ADDBA_reply(failure)

Other OSes reaction:

  Device -> AP : ADDBA_reply(size=64)

Note that the IEEE802.11 standard allows for both reactions, but it sounds
really suboptimal to be bailing out instead of clipping. The patch below does
the latter.

Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
---

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index f3fbe5a4395e..264dad847842 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -317,18 +317,20 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
                max_buf_size = IEEE80211_MAX_AMPDU_BUF_HT;

        /* sanity check for incoming parameters:
-        * check if configuration can support the BA policy
-        * and if buffer size does not exceeds max value */
+        * check if configuration can support the BA policy */
        /* XXX: check own ht delayed BA capability?? */
        if (((ba_policy != 1) &&
-            (!(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA))) ||
-           (buf_size > max_buf_size)) {
-               status = WLAN_STATUS_INVALID_QOS_PARAM;
+            (!(sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_DELAY_BA)))) {
+               status = WLAN_STATUS_INVALID_QOS_PARAM;
                ht_dbg_ratelimited(sta->sdata,
                                   "AddBA Req with bad params from %pM on tid
%u. policy %d, buffer size %d\n",
                                   sta->sta.addr, tid, ba_policy, buf_size);
                goto end;
        }
+       if (buf_size > max_buf_size) {
+         buf_size = max_buf_size ; // Clip instead of bailing out
+       }
+
        /* determine default buffer size */
        if (buf_size == 0)
                buf_size = max_buf_size;


