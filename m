Return-Path: <linux-wireless+bounces-30579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BACD05F33
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 20:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0273303E001
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 19:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726AA329E55;
	Thu,  8 Jan 2026 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVv4ewMK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95582FF651
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902264; cv=none; b=qLIWQM9q1MX4lxLcQFOxSsAzUvecyDE59atIhpiwubQRSoVEEbZpwkJ7Tc/Tp/U6Uq2D+TNAB+MvSRABk0+EdHXQdiUEhLyduGNSNEMhCpcqAc4WT4q57BoG7JysXPuLWFfqsJHUj5NOvEUOeefItprbKmxIJgUDX1AeUIhUu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902264; c=relaxed/simple;
	bh=SEPQdKAnhPs5qLuQcj39VfnCDYxTiNdPEOtqU1zoQRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gcgh/g5YIWvhSkvIb+NzQc1B38uG2sdbB6flT9I6GkKoybyshEY5UF4owFfmozg/VMTDA/kzpWldbC0XZ/vWRkRIfV8lkt2AZlguzdGgrMtZW8jaSa7cU+/GEhjkA2Ll4Yrqhu4R3kbGZDn3YfMy8E9/lDv1nA/kGlVLmB1NMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVv4ewMK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d28870ddso560240f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 11:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767902261; x=1768507061; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gDf4kLAuf0qf8dByGwvVIAAHMwWtxHLpFy5fp7Ykwc=;
        b=SVv4ewMKDYFLaBBR0a7aI6A9JomvmAP3+HlvrbqDfrnMXzj/L5Kpo6MmH9SwYXud8z
         WaZPcwdFdwdSg67Ck7cUktr8fOXoRz1lCElZU/B6+MYiy+urk2IsxO0YI55HIrfCEzgf
         p/8F/W5emq1umeMCW/ZdvS2N5LaP/E4UhAdJPmYwhJAq71sjRPtbHp+pL6jNdzsbGKRZ
         Je/Bn7rmEs0eJI0PWcwwTeXjB2m36PEH/ypgAKMR2eiw5ZeR0fBnccYZKLehII5yliKx
         To8c0sN+RHPRzT+RoajfioHBwIArOrmCoJjy7G20qZWHxkal3MxLxFegGzO0nanHowRr
         jXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767902261; x=1768507061;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gDf4kLAuf0qf8dByGwvVIAAHMwWtxHLpFy5fp7Ykwc=;
        b=FumO5P1nRoI3qLnrTSpIGSf6t2o4IGQi7E7qvPzk7Zr0Ahlr2/n2q7ZG39xG779tzz
         Xs4+h7q/LKyp4Lg3ULlgeR7vhoslbYeEhxf3WlWQ7J1VcOCRIQnxV4FOXISc1YapkBmr
         cc82yIRF02T3UqeiG9E3ejqaIicqPLLHzlASZCBcm+QoucdmFRvIU9i6FMbhAWWMmq47
         uJYR3OzelHgOEkaOa1l/4GQpZRRL+JMsJjBYgw2XeNVSUI0Nnd4ctjOcw8qIevfHYVIp
         eatSUi59CF4IXqsk42Wk3Js6AirbEZtWI22Xnb5vLqnxdWx4UGQ1DAo8gEf/y/8mbMDy
         NE+g==
X-Forwarded-Encrypted: i=1; AJvYcCVsNvq2jMPR6b+45mDxDmSikXPe9RHNCNmkrt6j/keaA+WtF64H4KzLYq+UZTouzl4W4Nb9EG+v3/yE8UZAkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzunZ/HkKvfVMmHhs/y+8HCN/IZGnc+Y4qrX8h0WZgbuxFC0Yah
	ZyHSUF0UQWcaW5kBmW79NDPKgFfBR+kj1ARZV1I/fXonci8htSKtOkgwy+GnFi9gEkw=
X-Gm-Gg: AY/fxX7yJ7a7lMoQGCxjUpn1/dttCs55BRwIIEK5dFOKewTUj2bfRUxV7wYFYTlqepC
	+kwqBCo9o4ByOQmLRDfKCYdMMqMFrP4Q9kV/zeRm862qBDiodcscsM3W82PaBRn/7Ww+HYq5mTT
	+0lFacTdicIuNrHoJ4UuaHTtegdL9rGC95H5cLZDoi5zHE9d1aQ9PEyx1jL6uPnciloNo3sBOjA
	3pOF7aMgPc7reSWSUqMShpZAnaVNOXrNPHeVodbzNar9VRKJgnIk0RROvbBdW6Mljdw3zlFY63K
	njMNR7FdracrfcZlIXPtVKLWfDACJWT6Re7jB7W1IixoVDhiEldOtxD78DCTmd7fCAvuljHtgKL
	UNrTOubwi+EniCBqzx94iUUvarGrmeqKNB7SigtMuJAy8+olD2KblN8laBtfSxj2gAWNnjM1okt
	AbqqBYXnZRc1zWD8UL
X-Google-Smtp-Source: AGHT+IHZFBCYQJFhqky8VClr8SnHFwzl/K8CfsbIy37jcUuYeB36t9vSgMB3jS7bjLFN1WcoCrT2gA==
X-Received: by 2002:a5d:5d13:0:b0:3ec:db87:e5f4 with SMTP id ffacd0b85a97d-432c362817bmr8072719f8f.7.1767902261307;
        Thu, 08 Jan 2026 11:57:41 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df96asm17943736f8f.28.2026.01.08.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:57:40 -0800 (PST)
Date: Thu, 8 Jan 2026 22:57:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, Cathy Luo <cluo@marvell.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: Fix use after free in
 mwifiex_11n_dispatch_amsdu_pkt()
Message-ID: <aWAMMdynZDz1uWAi@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ieee80211_amsdu_to_8023s() function generally frees the skb, so save
the skb->len first before it's freed.

Fixes: 776f742040ca ("mwifiex: fix AMPDU not setup on TDLS link problem")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 354c5ce66045..90831a1350f5 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -25,6 +25,7 @@ static int mwifiex_11n_dispatch_amsdu_pkt(struct mwifiex_private *priv,
 
 	if (le16_to_cpu(local_rx_pd->rx_pkt_type) == PKT_TYPE_AMSDU) {
 		struct sk_buff_head list;
+		int skb_len = skb->len;
 		struct sk_buff *rx_skb;
 
 		__skb_queue_head_init(&list);
@@ -44,7 +45,7 @@ static int mwifiex_11n_dispatch_amsdu_pkt(struct mwifiex_private *priv,
 			    ntohs(rx_hdr->eth803_hdr.h_proto) == ETH_P_TDLS) {
 				mwifiex_process_tdls_action_frame(priv,
 								  (u8 *)rx_hdr,
-								  skb->len);
+								  skb_len);
 			}
 
 			if (priv->bss_role == MWIFIEX_BSS_ROLE_UAP)
-- 
2.51.0


