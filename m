Return-Path: <linux-wireless+bounces-29303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54350C8329A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 03:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3C1B3493A4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 02:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A511DDC33;
	Tue, 25 Nov 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="proNdRg8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BB1BBBE5
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039592; cv=none; b=dnqYt2XLGt7nNQoU7NjNDRdmXcxoUZRJ9roBc2xeSC9dU5904cO/SRFH2zPUFOQQvslbLxTyqi7w7EFO/tYB3xCjx88EawFFtYlPajXZUUubpwihFKLSwGDrhGPsGlNMyt71W/GHDALrBZCn1tBMykb4nrMTwfyIO4Oi1zpzs+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039592; c=relaxed/simple;
	bh=3vTulFMti6CgTJ2gcF9s06MxrETRpLV/5x7u1etAp4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dE2nB6jrgpiiBRf0t2mUoZEbehisIkP5Lua5LaIKugAzYHnEiKSKzPElgsB4QHia88iYb/x1fgXOtRAmHKhx2NuioM5dR8IfHG/BlTtGllkYkxfnYawne/a5WH0Qi5zjSMQ0XJm8qDak1B93c/WBgJcai0Qcx9gWVbB5vDIQ3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=proNdRg8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ba55660769so4376410b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 18:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764039590; x=1764644390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmxVoifaZgy83rtdrpn+U1TmvgRTcC9coeZ8ICAQusM=;
        b=proNdRg8t+QIOHwtx3dEe4r0F9v21qWuS4hgbiv87Fb7kHlk67+1V1zfmqhS1sG69x
         ZBOIrxnJlHT/Tj908dOcGUEfyTryzLwmlL34s34bdJz692kdz6VQtyAml54+woTx67bo
         JIKaybKMh/RKdLoUXPW27Sn5zrzcSduW0ECOjFyipOWXtuZ9M3agyJpLWZaAA99yZL5J
         PO8ZX7vwO3r5xowkkCMnCkga/RycNWBWDqmcVonXrcdAiNg4z7B4e1jjGdvCMqhEIsuH
         hghbxzXInmqwNdJhI6k0pg/9j7cUL+RidAvCEF2aDjmzdEZb7mCixiP9HEVZ96Xvul0r
         6Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039590; x=1764644390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmxVoifaZgy83rtdrpn+U1TmvgRTcC9coeZ8ICAQusM=;
        b=ntVACVVcPQtE8SYxo4Q0DKpwLAz9snqzmYIuA2s9rfOLuyrUEWH1rlfUqdFJdzok7W
         JCjCWodsN5+GEFwc00aqmMnlngPqVX/vnmycchNF/cE448obALJab3fvxWnSO0FGO7SB
         UHvovcG9DgcY4H6vJY51KMYMWFNhnECF2pI+w1jY738iRR+gnpCm45WSWko61MnCF/mA
         ErDvXju6BYip6RE1/oJU70R++TR6JyzZEkqhSEIcfDrd4aoZBYpwVsfWbZ7wnJ+3mQQH
         0dAzBaC9U0z9HT11Tft/hFJPkr9VK4Hmc0sB8aXY4USNlbIrn5xQvQI0XhtSEYMMKTfu
         0Rdw==
X-Gm-Message-State: AOJu0Yxdh55tRVZhbjc7PKKYAiawoeDaueUorrFcO/oUhFzf+avPJVmi
	NzCS8JCGbone/LiI5haaMy0xgkLfQ1gXO+XbT1pASpcQPERik4GEX3vK33boJuP4QQM=
X-Gm-Gg: ASbGncssMb4nUjzt3d4PoI5U+jBQ9i5PZRdRPUulfMbWFBpnpjrFBXAGhepIPy9csx3
	ykptMAbzLkpthoonQRQP0rV83+21jRO78bjiJMU6PSxxJAtBFrpD18cYteZ9euPOYF6epcJdwot
	paxW7JV/GLy2Wp6t+XLheelLV2YyGNGqLOliutMQZhw5Lua0pF7fn/iiwRhw/ZbzH+sYc5x2pz9
	1QcbavMtYPSBBCtsu7w+9IxR/cufI9s8Kjs4chwzqa2nhMvInoWimjY2wcLWJ1w2FKnyIS0cEcL
	zxswjwqxZ5rj3lBwEpELs9RyMFvdZsoa74eGYzikPi+5zo4Usqk60PDDU5magcmAHb/VhcZbt7B
	z4ghgllE84wz948tzekjf4M2R0dQqol9l3MncVMJMoTrwbA6MC9i62Zviq/7CqqIK4kz3JoRJse
	5PFUiQZ3I4qUl48VDuJO8XhfZKqYv/BS2XQw69eLDXyl5rwB+kx/94HT8/0Dwq81M++mVMROIXn
	PJHmWXu0cX2uVMqdKY=
X-Google-Smtp-Source: AGHT+IGsRYfKIBrhxCzLsPD2OjfVNOB5w2nx6b7xXV9WYL9DbULLyB0YtFSaPGz+qxJzD0sRQuwwpA==
X-Received: by 2002:a05:6a20:3c8d:b0:2ea:41f1:d54a with SMTP id adf61e73a8af0-36150f353c9mr15793053637.55.1764039589727;
        Mon, 24 Nov 2025 18:59:49 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e9b1239sm14549915a12.15.2025.11.24.18.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 18:59:49 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 1/3] wifi: cfg80211: include s1g_primary_2mhz when sending chandef
Date: Tue, 25 Nov 2025 13:59:25 +1100
Message-ID: <20251125025927.245280-2-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125025927.245280-1-lachlan.hodges@morsemicro.com>
References: <20251125025927.245280-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chandef now includes a flag denoting the use of a 2MHz primary
channel for S1G interfaces, include this when sending the chandef.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2187e148389d..c2bb0f8f480b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4178,6 +4178,9 @@ int nl80211_send_chandef(struct sk_buff *msg, const struct cfg80211_chan_def *ch
 	if (chandef->punctured &&
 	    nla_put_u32(msg, NL80211_ATTR_PUNCT_BITMAP, chandef->punctured))
 		return -ENOBUFS;
+	if (chandef->s1g_primary_2mhz &&
+	    nla_put_flag(msg, NL80211_ATTR_S1G_PRIMARY_2MHZ))
+		return -ENOBUFS;
 
 	return 0;
 }
-- 
2.43.0


