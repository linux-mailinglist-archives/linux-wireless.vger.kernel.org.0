Return-Path: <linux-wireless+bounces-11639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8F9576C5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 23:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4AC284C14
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 21:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382571DF665;
	Mon, 19 Aug 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDUg9yru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C351DD3A3;
	Mon, 19 Aug 2024 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103931; cv=none; b=S9C58sHZWyflYOzZFAZRK30R+9vQZR2fnAakeko4sq2VsnUQBBiMEieUVVkK5v0Z+TWu2wnSVOyG5u/BqZgUBQSbwi2PaEWCYXeV7g8IbREOQ9RXARg42QJ4tccUXD04ROWBBGjvjAhnIDMwxLevUNVLe1Yh4VUqS3YiK3MHT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103931; c=relaxed/simple;
	bh=Oa+1kc2c4IF2nr+g9Ni3tlSFwt9ny2drF1n9mJIIwAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBQc2c3rtZZITKXGU504L/PFLp5pTSE3RhwdDdSnS/9uS+WfTwZ2/3UVTf3KtQgJ6QCwdq0IlneYMd5NliMiRTu2dGCOpaUmM0Wiu5hIGbuNmUtv6k72Am9MnyGnMH+XlXwqnw2wGsCTn99Y5uC7W0ue+QcvzcopiA7P+wP/vKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDUg9yru; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f6d01961a7so1597893e0c.2;
        Mon, 19 Aug 2024 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724103928; x=1724708728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLWgzRU2c1+iaemRuNKcFJqB7h3pyEwAcIfZNRs/RAc=;
        b=NDUg9yrue5tqal0K+UoCqUXHZT6BiiUmjsYs2lUTNYDvZI7qPV2AtnwqP4CgX2jIy9
         xgzvxzcVcEQ420U2wvysWqfneNGZXIlZZ1QWKoMMgyH6XMWnQdeUSD/jOSRDDqxgLekW
         ayfIsiPSfZ5egnH6CJZ3bGeIbRJ+nPzfZPdxvYT4ry5TbLlHsE5a9/aC8pp9nRGcwIOM
         b8571N41UdGiISIyWcmpj1v+2ePRbpnoyQunLeh8l5UUGxWENqL4JfkA03CViLQZJ09j
         UN2L+9wbHw7lvxNojUjsZQyhL88D3i4bqpbdiXMkyHd0n7EUvMmCKJ2ESWZVds/bfruO
         JJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103928; x=1724708728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLWgzRU2c1+iaemRuNKcFJqB7h3pyEwAcIfZNRs/RAc=;
        b=TxMOV4qWIC3t6kD8hTOn773I0aqqQQIWCEiPhFkpSPwDOEK5iWOkfoGboSSjH/mHEV
         2Mo48MuCoG3FxhJkGiMT8Bqy6qeSvW9P1YdGG230lYlnTmFoFThfyaPAKun+2/E6JyH+
         Zp97sik9ZKNouauEUXPqZQ/1/zisIKS9G4UnLNIKHbWe4UbhsrihJ8bSrfqEP6RoLPt4
         B4hqWTsrp1GzYma/u/LXx3Wr33D5s3IawGmfrhL6oGNskmfgnjeQgosiPYlQzKB/zNdw
         4h9rTu77lr5BtyRss2muiGjElfcx6Z+K+ttaS5nxAc9AQuuE7IRE+y9Gjc63VJRF/46t
         Vf2A==
X-Forwarded-Encrypted: i=1; AJvYcCUjTvWACCw/ELEKoByT3qFlagrHrILyHbXPY8A4b6vwQu5YSB1NmFNS0PCzVrTpqqLmfyv/gOvlYFgidWpIKFXEFdi7hS/9i3ql/ckq
X-Gm-Message-State: AOJu0Yz3vhFE5l9WJS4riMUfYE8sUClXTOgJ7/vGLIpfofqdipElzZRp
	6a5mJilklqH67CgrHVJq3PfmVcSBKgwaP9sdoQmeGhZPVXIQkVUWBIy1pjel
X-Google-Smtp-Source: AGHT+IG91aYPonuoxZkAZr4YT3abtl+VlKqqICbOlpd3gTxoG85MUKnM7/XV0ZKLcgz63N0K336rSA==
X-Received: by 2002:a05:6122:8c3:b0:4f2:ea44:fd36 with SMTP id 71dfb90a1353d-4fcd886dc3dmr722488e0c.0.1724103928462;
        Mon, 19 Aug 2024 14:45:28 -0700 (PDT)
Received: from fedora.. ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b9c872fsm1230429e0c.46.2024.08.19.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:45:28 -0700 (PDT)
From: =?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	=?UTF-8?q?Juan=20Jos=C3=A9=20Arboleda?= <soyjuanarbol@gmail.com>
Subject: [PATCH v2 2/3] iwlwifi: mvm: Enclose multi-statement macro in a do while
Date: Mon, 19 Aug 2024 16:45:19 -0500
Message-ID: <61d25f02322b875dd9eb37ea992dc62be7c75840.1724103043.git.soyjuanarbol@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724103043.git.soyjuanarbol@gmail.com>
References: <cover.1724103043.git.soyjuanarbol@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch encloses the `CHECK_BW` macro inside a do while as
preferred by the guidelines.

This change is purely stylistic and do not affect the functionality
of the code.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1a210d0c22b3..6366779ccaf2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1043,10 +1043,13 @@ iwl_mvm_decode_he_phy_ru_alloc(struct iwl_mvm_rx_phy_data *phy_data,
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_SEC);
 
 #define CHECK_BW(bw) \
-	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_ ## bw ## MHZ != \
-		     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS); \
-	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_ ## bw ## MHZ != \
-		     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS)
+	do { \
+		BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_ ## bw ## MHZ != \
+			     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS); \
+		BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_ ## bw ## MHZ != \
+			     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS); \
+	} while (0)
+
 	CHECK_BW(20);
 	CHECK_BW(40);
 	CHECK_BW(80);
-- 
2.46.0


