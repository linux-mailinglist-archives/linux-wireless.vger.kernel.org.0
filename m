Return-Path: <linux-wireless+bounces-21717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58330A936B9
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 13:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A6F467813
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08530270EAE;
	Fri, 18 Apr 2025 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzbA9TO1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A68462;
	Fri, 18 Apr 2025 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744977397; cv=none; b=ril7AWzouBgga1Anv6STlQKkCO199gHPh9+Ne8yeiMecO+lOPZ7+EZzyZ1vTXnheBuMAgrSlrI7905A5tsKUTyNTwwkXE0DLcuDzBwg3dBDTzr06nWtns84/v9jigsEDW64HNyR2R2s0VVxuPlhhYVR9TbYPkCv3eXHOtwIb24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744977397; c=relaxed/simple;
	bh=LuPOes4abOjKdXbJOQYZKyl0hIe3TfkPDZXjK0BFENk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Arg4TVLYsIGmrlkMDZdx5gpNzAEPc+Bw3lYOMfxpLdxdhxR6fV61kWU1BG9ZIFzhy8zElYrAYR+vn5nMo4h3YIqKYqknHB1xyZkJk+R3CHXKcYSaoCWP5VGZDfNnjxNQ0p1/xNoFDMpkJwzKlO6kIA+rLh3uXQKmslGfrbAJ78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzbA9TO1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0618746bso12924815e9.2;
        Fri, 18 Apr 2025 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744977394; x=1745582194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=erlZkBfBWeO6cYRlc+qHsjyCWTqA6RYSzWyCGbh+asc=;
        b=kzbA9TO1OWyf2tsNm4BlsYfSXYZH3OBg6mKvpcOK/Pl1fFXhJAB2pHcDQGbWD8mutn
         gpx0LyYlJc7eE9esEr1enKWjh2mqFUvfWtKrCC/6l1JN4/7f80jNunVaORfD7ER8A/0O
         TP8oXRfRiCy52kIHX4H6fTRMf0EyQLwKbDJXg9Xurl/nhV0rUNEvjQprz/qbGX5x57bV
         U8LXfyKsZDv+t1RJHqsce8hWy79yvfpIvC4IZTVR3YKoymKYC18uu1bJLD2EuLE2g7M6
         sSCthqey1B8uZrHQ3hoEDDV+1BwJ2zUsYSxgNSqd+qG9ANbCd79b84LLdWVNXmjyGAKa
         UTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744977394; x=1745582194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erlZkBfBWeO6cYRlc+qHsjyCWTqA6RYSzWyCGbh+asc=;
        b=lnWgq44W6eGB8awLRuVML/LXsZ1VfXuctOwJs8G1984x4HJzJXHUcckn4ZXB2QCfYW
         jl+D+lpx8iDMw7kcJnTCUoXm1L+Yj8qLFXxf+EfkLkTtzLC07x8Eauk2fuxwj+UMWY96
         VnG1GgMfPsml05UwJPREuHDQQ/sBZd08r5S+7ofi/BM2uk8elE9qGccecN7r5OzTPx9A
         Htfvcy+Ah6YnrmbOUryP/MUwQvXsIhlIhNYIOUlDEGqFmsRPuPwbUFmZ6cGMSn0287ag
         x2V23qJElMepXJXlH0ofm1FRTg1PPtU8OjUzadHGTun6ESa/7BZO7sxLAFJ+z35Xe9Uo
         NYbA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2btKy7x1MNjUl8v91ZFVev3QR/72sI3ftWwwpmRiwsfUJGPZ2sTnEd1oW1Aq2NoBOVIbMw3nuNApAkE=@vger.kernel.org, AJvYcCUJFqonlk+W8rVhWanAPUZzkJSdO/z1u4KL/mlAQL9L73AIxTyINuhLXWjsMoDJElAFDbjgAepBDtHEz4H7GhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzIwhT3ZWngZGljEYVGKWienxcwduEYItifQhuTOIiCKLBARk
	NuuBqtclp7tfUZWaBw7egzxTOSXgm7FQtKKJCI2ABUhRFEcyVffd
X-Gm-Gg: ASbGncugGQVQg4tEh73FA90hso2Adx5MJrrgUXuEKeW0bUKRaB0utDWin7dfoLYoNYx
	YwEh602YNQCXt6lsNGnZ6YYwBNNzldGOQmSXPPewHMyaVclgA6XH4rGuEfXPCxr7AduaGmfDrD5
	0LNbuxZK2stwRHiV9+D8TLFMhnKX6IsM9qEBNXWOlCSfDURa5B+oMujMpGxs0M3fAX7Y+8fAB80
	zaCZhfuYVXykJnbATTBpdz6vJ62nPblN+3ONjdYqNKHdGYv6E7d63K4+moA7RvEXZfLvmibVL/l
	KuiGDoaUbnlgWSz1RNyliIUs6eLZhtJ3TTpzKZBg5g==
X-Google-Smtp-Source: AGHT+IHEOz09b2J8Y12vKsBHy75zrVmXiI8vyJB2jeLApDk5E1XezYHipFLbWi+e73sIPaDbEpxEGw==
X-Received: by 2002:a05:600c:1c07:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-4406ab81962mr19746705e9.1.1744977394309;
        Fri, 18 Apr 2025 04:56:34 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4406d5ccd1dsm19614645e9.27.2025.04.18.04.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:56:34 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath10k: Fix spelling mistake "comple" -> "complete"
Date: Fri, 18 Apr 2025 12:56:27 +0100
Message-ID: <20250418115627.534833-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a ath10k_warn message. Fix it and
remove space before colon to tidy up message.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 7ce74b4ef201..f3212eab56a1 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1844,7 +1844,7 @@ static int ath10k_sdio_get_htt_tx_complete(struct ath10k *ar)
 	ret = ath10k_sdio_diag_read32(ar, addr, &val);
 	if (ret) {
 		ath10k_warn(ar,
-			    "unable to read hi_acs_flags for htt tx comple : %d\n", ret);
+			    "unable to read hi_acs_flags for htt tx complete: %d\n", ret);
 		return ret;
 	}
 
-- 
2.49.0


