Return-Path: <linux-wireless+bounces-15611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863CE9D63BA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 19:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFA3282708
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D631DFE22;
	Fri, 22 Nov 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i622NzyH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE31DFE0A;
	Fri, 22 Nov 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298687; cv=none; b=RLkZzRztQK9m19SIfa8MOptxxcpzgeYocqY0lKv/wBbquQlgXlvfew7kOa7SOtD1CNG64qVuK3+dCi8e+podPPE3KtyL+SyOSIxf3ybfO8u+KAGPEkMuuCayPkkV3wRPUpWKoukkyUVjuY6EOs1AT+LvsZaw1IgIosvvWXTYGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298687; c=relaxed/simple;
	bh=GE9aQ4845Qpv/Mv6MUtLgA2EMelQ8RiZvoVebfNEeho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rOA2Dxfg0ORBPVITg7g2Ihn3fB8fIgIeRHx8BejyreUDddEVV74qgUVc3W+4mcQtSNF8J8y5xRv836SLb8Fq398ypUAATA7KS8yrVzBMEQTMtVQv32PCKSiyoTM03a3wivy7RyQMiv72KeEgZDcPTZTAI2qPsh/Lg5qmnrm7iGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i622NzyH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb49510250so29451781fa.0;
        Fri, 22 Nov 2024 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732298684; x=1732903484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYyJYDqDJe69p5MWqb9Lql4avTJsJYhKFAm40pVHp2o=;
        b=i622NzyHyWCzLKDPR0jZ/vGBJlkMNvIDfMDTJphQCYMvMgI7TNnH9UXCEcil2n0OWI
         dVyZolwPJCn1LKR57Zs9smkkZ/m5VilQjWP/Zj+99iO//WzeVOIyWfVIKFPd4Gigw0mp
         /4Rlm/he3eyOVH9w2HHjt6HhVuFE6zWMOaxT33bUOdOBvTQoo0QarB6HsbOyG04sfHaW
         pWjrUOuweSMGxjK9Opi0BlNu0Kg3AjcQyxLEX8arxWnOnToYj7wOJA8tIDsoLiy56w86
         67QHK3tL8bQonW3+neYeK4XPfsBaEBzOs6nIuPc+c1rR8dgcxINZEeAn+G0X9qwXlrhI
         iUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298684; x=1732903484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYyJYDqDJe69p5MWqb9Lql4avTJsJYhKFAm40pVHp2o=;
        b=fOc+oHHTJ7I9ml0YY2IwYDNrErsAUDABafNA5+I2pSBn48mBYKxibVtXtwKXNDD/hY
         JSeaD15Dyk4bgS5Zk8M4SpbGUcWqRN5P7QLJoLMkp/DtE7EjIxVx30Fx6ENF00blKvQ4
         BM6wVzbQIUQxp4ohrkfJYj4s8yJ3+J93SAsBLIt6lgEcV7RPtQt4WN7r9i9IOlCD+YF7
         tp/RPrqqCUYYqVyd+XqCiy0L9EA9oV4SKsnlp3pzoxjDUolPRPDLAl1zW7igoMfH8c9E
         4fWwXnCGVW3W6zw3KPAUYmyBgLxeeasqc+oxR9AGdcbypC8/C8aK2XJsJiS1zEEDxLa2
         cRew==
X-Forwarded-Encrypted: i=1; AJvYcCX+OtR4X9kB0k2eFVkumZl/qqnuFtDP2g6GDUJC5+VAreaVbe8qRUfRUpayga9Qa9cNoSOxYVYeg0Qd02Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwoNbxzcsx5cJz1tcjTr4Eu6GfYsJS+r+V5Fv2d1DfBE6xkoG
	F8Y9DgUja7Pxg4p6+X67ZT6dxdwB6OBlCtICnroF4LAxCu+EB89qQiJzNEoPGew=
X-Gm-Gg: ASbGncul/ciKZVWl962Vt9vbggUK1+YTmq90AOtvH1BGBf8I1C+CqvPiz70OmJII3i9
	gFZfTf3lJsKB6FRAyC7dPhvfQEuOI6GGW0RZeEzqNHOfT5FyW5B7L/a+QGsAA7QeZWQLqHreo/Z
	z2RJVoSM078cTREMzjl6vV4uN/3D3eS3gCP5Jm2iNclJEbC23RBtlbgCkiN6d9sng5RxKczXrKd
	2c/Ec5X6Rr6ErEU8ySYjZhEObaxo86oZ1yZd5vq0iKw3xbGuBgBnWgSkDY=
X-Google-Smtp-Source: AGHT+IFMT1jZ0OG+uq5izFMfMfSmIicgWhHMQIScinvKrk/fbovg8oIImmx/lrryRLrCRN/udLycOA==
X-Received: by 2002:a05:651c:98e:b0:2fb:4982:daea with SMTP id 38308e7fff4ca-2ffa718296amr27123141fa.32.1732298683522;
        Fri, 22 Nov 2024 10:04:43 -0800 (PST)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa53a112dsm4330891fa.119.2024.11.22.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 10:04:42 -0800 (PST)
From: Alex Shumsky <alexthreed@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Alex Shumsky <alexthreed@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: remove misleading log messages
Date: Fri, 22 Nov 2024 21:04:35 +0300
Message-Id: <20241122180435.1637479-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when debug info enabled, dmesg spammed every few minutes with
misleading messages like:
  brcmf_netdev_start_xmit phy0-sta0: insufficient headroom (0)

Do not log this when headroom is actually sufficient.

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
---

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index da72fd2d541f..25c77014af9c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -327,8 +327,9 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
 	if (skb_headroom(skb) < drvr->hdrlen || skb_header_cloned(skb)) {
 		head_delta = max_t(int, drvr->hdrlen - skb_headroom(skb), 0);
 
-		brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
-			  brcmf_ifname(ifp), head_delta);
+		if (head_delta > 0)
+			brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
+				  brcmf_ifname(ifp), head_delta);
 		atomic_inc(&drvr->bus_if->stats.pktcowed);
 		ret = pskb_expand_head(skb, ALIGN(head_delta, NET_SKB_PAD), 0,
 				       GFP_ATOMIC);
-- 
2.34.1


