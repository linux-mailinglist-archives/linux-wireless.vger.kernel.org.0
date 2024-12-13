Return-Path: <linux-wireless+bounces-16358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3869F0625
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161EB164F02
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 08:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C591A2645;
	Fri, 13 Dec 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPvvWrIe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51F19F40E;
	Fri, 13 Dec 2024 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077652; cv=none; b=peEX2rEkkBM2Z7xDuQZLAx1kVjNXrNdMinfAZ0IRO1EgGQ+j9o7ILN75bLXHWNQZ5swtAdmaiGPP5F5YTrs2SjAKXpXxTfXQ/sDDu3ZcnMTYCYhJ/dOa4OZQR3b7eVffBNlwiTfj5XJSRZn95XezKUKww3ZIgDcX8JKacHDLchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077652; c=relaxed/simple;
	bh=DeuTWikIwBDL8XxaGJqSSaBzW8ftzrIQcnnjpV15GrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UNVyn3WON/NkR/ye+FrmnpojtPn9Sd/s8DqvsopccdKltF7MhNxyIWtwoUovh317Cy4cu3FBbDt9CNPvLTOL5MBJAmRY668WwYsUhvwvFudUVXuQ0PQ27CSiC774sZJLC43qVnVPTXbVI1mZUAW/ENf3Q4MR7Z9+xdPsXKmcJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPvvWrIe; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so1462103e87.2;
        Fri, 13 Dec 2024 00:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734077649; x=1734682449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXFXfj7o8MwwmFfKPy6HLkitXoH/KOnee4XhQ59bWDA=;
        b=VPvvWrIeilsmHAoh0XAm7j61/b9F6vdoQdGHJ6frVZl8lSaa1HJV7F3eaDrMz3YxPM
         JYxEjzJpACG27T9H5zAzDj7eKBViRjy55OwoBDo6EPSXKoJ/SuOnUSVQrMj5bijaCr4G
         KQaJYKbNLH4FVlVqU4j32AZ361W0pKLzJk/tYbzhadLCpgxBO7/BJqxv4pbuRm2hQpXm
         k6LNWZ7aFmdm+KdvUjQENATA62t2/HSEthDYy4mrlecKSfozUdKw27y1tP1yqvH0pEVZ
         BjHsINVfo8E1ymtSNo8b5pGNISgaOuCYslRMViRRyZurGUxEdCT3VGo7iA2W4fjCUf6S
         FiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077649; x=1734682449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXFXfj7o8MwwmFfKPy6HLkitXoH/KOnee4XhQ59bWDA=;
        b=uy/3T4eSQNV+RYondSdF1Tj8lSccFwYXRwswdF9oXXG7IbBtWqPCmDSSgIaPArPT29
         jTNZsJvmbn9sqeP+Gd3bX4jDvvcJ7RRxQ1snHZyAmOBXIYQVq1Z3DMIxA3NDNf97Xsvi
         dhGBqS5l/jb18SQzpzC6iTh/UpPKGhq5r7/SeCVSNgJZDUsWykXbXphtG9rBpFHvkiYQ
         gQyvfaNck5Taw0U5Wn9rckRoOBhmmI+lz8qAqreaWUWBElXzrZ5sBI/f3AZoBzIw6PRz
         AAtvcVt1e7Yv68fuJcpj94InkWA7WETpAMM4uJxoudwJt8D0Y+Xkl4oDoVugSYQKu/2+
         M8hA==
X-Forwarded-Encrypted: i=1; AJvYcCVAqwkhnfU5j5K1+OU5tIcPkwpe42BZlTqiUEHwF+emKwgmefAZdaO4JaEaWaK1uiVhKdL8kEy64RTcksE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkN8AVMHg2H4T7Xu22rN3qbvHzcaiudpIjnGUmsl7ljny9teT1
	C0i1LHtOCyzaLroBYMOgdEEGL6mG7rozf9o6OjJYGTvmgsF81r5HOZi3FbBg4dw=
X-Gm-Gg: ASbGnctksBGY9sLPvZPRKDBwFQ/ZiuEcMzprnd98RxNUlJaxZuAiZXmaFnnVgXIkQ2Y
	bEO735oZUT0hJRAzRd3LU0eIiRnhUgoftoDsAPWdoALKOYBuUGflpPHJxejqtDsv2kYDciMKsAk
	CitkwACY0oUcwz7027P9pwyAQhFHZMNoe0/SUQlpMKyJLNg7IOtkh1iYcrMumKeQVKg60xguMrN
	gXw4xs/3aH8sgq9jYRAmp4VqjMGPZ7ey0Drun5Z+iqVhsckG6U4oexBColKnC2gsA==
X-Google-Smtp-Source: AGHT+IG5nk114gmKOdKv3MZJeb4DCsyi11f7Ro9alkdACiWlDrzYvWpKnd/qR9uD5+29IvGYRN8Ldg==
X-Received: by 2002:a05:6512:3b26:b0:53e:350a:72a0 with SMTP id 2adb3069b0e04-54099b69aabmr495775e87.51.1734077648604;
        Fri, 13 Dec 2024 00:14:08 -0800 (PST)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401a3a4c24sm1822010e87.199.2024.12.13.00.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:14:07 -0800 (PST)
From: Alex Shumsky <alexthreed@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Alex Shumsky <alexthreed@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: brcmfmac: clarify unmodifiable headroom log message
Date: Fri, 13 Dec 2024 11:14:02 +0300
Message-Id: <20241213081402.625003-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace misleading log "insufficient headroom (0)" with more clear
"unmodifiable headroom".

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
---

Changes in v2:
- don't remove log completely, but reword it

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index da72fd2d541f..c3a57e30c855 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -327,8 +327,8 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
 	if (skb_headroom(skb) < drvr->hdrlen || skb_header_cloned(skb)) {
 		head_delta = max_t(int, drvr->hdrlen - skb_headroom(skb), 0);
 
-		brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
-			  brcmf_ifname(ifp), head_delta);
+		brcmf_dbg(INFO, "%s: %s headroom\n", brcmf_ifname(ifp),
+			  head_delta ? "insufficient" : "unmodifiable");
 		atomic_inc(&drvr->bus_if->stats.pktcowed);
 		ret = pskb_expand_head(skb, ALIGN(head_delta, NET_SKB_PAD), 0,
 				       GFP_ATOMIC);
-- 
2.34.1


