Return-Path: <linux-wireless+bounces-28520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C57C30063
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 09:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 573FF4FA9BE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9D7315761;
	Tue,  4 Nov 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Moi/ybOt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299283126CD
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245601; cv=none; b=kg3teENJ64PsiEbMvLjbSuqc/cvHWt6aBk0tpsqJrI9xfgd21s893MYlYjCMcr8Nc7m5W3jFOE2LK5YtPenXzWFGzgX82IEdgR1tFqQEZN6uFOLsHKHwF6JhOp2JLRQhqjLAzLtOtKkqIdOps0fwd20jbca5KMv2BsQ82pk3f38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245601; c=relaxed/simple;
	bh=yvuevENhw1rVxJROZ9ndmL8HeS8yP0pmhzgMQK2PbS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGn3jDON0gwkLDXnsy4l3OBNhnZ6NlJcKtx8o3/xfYlEO7C9BTz3PL6wZFbOJdp2pI4OAM1uQUZNV1V9gqIL7H9hyW7KK2EL88EIUwJu3rPqWJIrDL5goqM22IWFGEOdCzV2MUYHweb7/K/BxZAiK3WoMcbVImofh8DeaLVqecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Moi/ybOt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477563bcbbcso1382085e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 00:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245598; x=1762850398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BHh6TrXAVBH0dHq7jStQLl3tqNEOJNV4+Rn4oIVUb9k=;
        b=Moi/ybOt7nAnmW37xKnt6AFoWFaG2QUKx7wpOo0+yxM7eo3YavpTRS62JUcNbhKEko
         EyOsMHc4Y7+j8mWtXD6yHFwFLKYQ14xbP7Kb+20Z8MU2eN+v69I+BTFqpRDM0pP9Qxp5
         ccikMC3aOVBvb9Q4olyUWbEUZPYS9g4d669mwxrZS4ez68h1duiFfL61VELjEtUxukj+
         IqgsSftJor+hx06AwhXRL8MvRGUw83yLEdac/dRJiG/Z58wXcHuv8fu9HgAmQOYIVnz3
         TaP9lqTGleps4umgIPd5PTPAvSwMRVcE+eger6kJbqsLe0QyWXYqPXqeJSAxzTeNO8OR
         xPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245598; x=1762850398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHh6TrXAVBH0dHq7jStQLl3tqNEOJNV4+Rn4oIVUb9k=;
        b=QJdeLG3GqpVJhmqJkXi56P6p7qp/0EUvlE+4AlcPDwGA23Y7J1bxErTSK2VdLuCQmp
         nI5lk9vp2RhFX33k5iUbNxD8kNUx8kRhf7sLak5y7PaSn+KelDv4TvwlYoJjqdo4L5Bw
         /c+CkS3aOHhBM5nTsAsgExoHa2NEQe49SP+zH6ji+gce9UYHh3JX+5VByrY21C7mdkTo
         jBIUO3kG+xAVXBUREhXotJhMrJtYXazleC0Fnh9oNag1Wire0Bye4SoBwK0sH/Q7TDdN
         Ry5OkxB1H0lHz6Rgi18wqKbBstffBmN+AMEoHs2T28pkOBVK17WaevTC0L3gP7W3gEJO
         cVog==
X-Gm-Message-State: AOJu0Yz8M2mfJI84Jgd6l37MV7BZ5e/t0y7G18qnxYyJpfKak0WkW/JG
	NpqGs/UaYo1AWbCRAH9ifF149uXF7x6FZHvMTzPY8x1A2niws2JuooRp
X-Gm-Gg: ASbGncvTLek4+OmNH2+5Z88Wt1gmqgmHe2LOm7lK5URdHxTvUdZynJ1OHWB5mgkFeyc
	9GHFBsZi17HRgKtYbdoaIwPiTf2Y4blGO+9jq15N5DMgsgQ+wef/gUZg8hnyMqu7Jm/Fqjd8KC0
	9a0Txg5ykS+XGTpeORt7B2TaqJAArbFuwpWipbgAm2lV29O3+0HSH4HwNG4YG9631obA0Aqrlh5
	PtYxa+6uNM/dXS0pWlDdM5tJtIskR0hiv2TXPkN5LdtLfMggU/GAoEXgoTVQ7XVKu9LfT5QVHq3
	qLvUMR9VAsboY+X18MOzsa/+2b4BARcMyW7yc6HmzQ0igixmwp189gKpZeLDGLmTEwVclD9fYb2
	iXgptV9tT7f+VSr8RMGgeQSpnRzafftH0JHfo8yAKbTZOeQ2tLbYkudshax7t88yK22V64tv6fJ
	QcVaDO0l9ZDzkIT2jyjP+M46MEfRQnLh1O4A==
X-Google-Smtp-Source: AGHT+IFUu2PzAgaxKOCecZ51vlKS++CtbRNf5LUtGwN15g4l+qAj8M1AOupS1tHM1aNzaJIrKXLnDg==
X-Received: by 2002:a05:600c:3acd:b0:46e:32f7:98fc with SMTP id 5b1f17b1804b1-477498de36fmr67708115e9.21.1762245598359;
        Tue, 04 Nov 2025 00:39:58 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394f0csm198047075e9.16.2025.11.04.00.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:39:57 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath11k: zero init info->status in wmi_process_mgmt_tx_comp()
Date: Tue,  4 Nov 2025 09:39:57 +0100
Message-ID: <20251104083957.717825-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reporting tx completion using ieee80211_tx_status_xxx() familly of
functions, the status part of the struct ieee80211_tx_info nested in the
skb is used to report things like transmit rates & retry count to mac80211

On the TX data path, this is correctly memset to 0 before calling
ieee80211_tx_status_ext(), but on the tx mgmt path this was not done.

This leads to mac80211 treating garbage values as valid transmit counters
(like tx retries for example) and accounting them as real statistics that
makes their way to userland via station dump.

The same issue was resolved in ath12k by commit 9903c0986f78 ("wifi:
ath12k: Add memset and update default rate value in wmi tx completion")

Tested-on: QCN9074 PCI WLAN.HK.2.9.0.1-01977-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index edff6fb61344..110035dae8a6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5967,6 +5967,9 @@ static int wmi_process_mgmt_tx_comp(struct ath11k *ar,
 	dma_unmap_single(ar->ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	info = IEEE80211_SKB_CB(msdu);
+	memset(&info->status, 0, sizeof(info->status));
+	info->status.rates[0].idx = -1;
+
 	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) &&
 	    !tx_compl_param->status) {
 		info->flags |= IEEE80211_TX_STAT_ACK;
-- 
2.51.2


