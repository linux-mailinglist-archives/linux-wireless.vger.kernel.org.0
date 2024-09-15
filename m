Return-Path: <linux-wireless+bounces-12871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA469796F4
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 16:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985B91C20CB0
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Sep 2024 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B51C6F71;
	Sun, 15 Sep 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z570z/G5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7F1C6F49
	for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408878; cv=none; b=WL3dMdzy/OI9y89gWTaH/rposDQpJOIoh40vXz/zCTfqYsU3fgRCNXZTnUsxX1c7JInrHE3oc87IJx6d7UdnHjU0pHrWTtG9UvOaF0QEGHZdXyRMevOdRxSOutcFfxi54V8Zz0mIaD6m0XndujvpCKd+20qi8+0DE33KO6Wa3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408878; c=relaxed/simple;
	bh=z1ApUq7/iTxtQ0TDsv1mvl27Cnhr5TF0C9tFP1g9YQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+YEOuqfaqpqitlLCB8T9UVFt15RkubG1Gyjql2ErQsJ/yBVbANIVw5HtH01Jp2wbbkw4p1IqUmreNDlo/kWrpgfpvctHS7QHsXcVWA5oj4R8VNOJT5ZxJDppYItmUZ2tidmR4xnx16tU6Ot0/ONmIl/mpABU2xcEbionsgEQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z570z/G5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71957eb256bso290876b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Sep 2024 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726408877; x=1727013677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED/M16yR+lXr7ViSvhCHwCaDzEEhUxZQFCnfrZ9b5KA=;
        b=Z570z/G5GBc+um/MMoPdjrg9gpRsyT7necKbsimI6b2cJCp4VXTY2IX4jzt7p+NtYl
         nZIGviefsoSYI9mtgiHT6bMfZl7p8HUh/rYYEh33yJNS6suwCmqxpdCh8bzyaV4/jNY8
         LldaCnrtv3726GhYsupvMH0GmQcsDm00MDx4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726408877; x=1727013677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ED/M16yR+lXr7ViSvhCHwCaDzEEhUxZQFCnfrZ9b5KA=;
        b=K26oDqc79bFgbhyJ7QvjvbcD4QhgAuKtYYjjNGE5psMbe6AMkPUg6eaEENpirF4Sx+
         nZEp5Q6rc1VFLb2xtIHLZMz2zduGkP41r/NiBPL/hXhr5WVtGI7N7ugxrtbfkHcRoOor
         1J1UQbkY3efu2e4xg3eHeE/YHyTg4+k8HSG6HA81mRaY3O+ggc8US9CMUG5f8BHMhRCc
         jVkbhCtoNeY7+fNLDXwxBoYl1iWH5RH2cYNHQR/Yx46HR/eqpoIqpAuysz15nOTQwoFm
         DL/uITVp9Rvsy+2kGp3/K4JoXbvnqo3aK9rLr98mCuJox/pE65eliSBPDM1PXXWXFtDR
         6mLQ==
X-Gm-Message-State: AOJu0YwC6bUfChJPC9q2vq4RV5UmdmOM0nqi5T3IkJlToIV/DWJHz7M3
	b+KByk0wGK4Hdz+XCDH1GM9mvHaJQkNcNhz8ZXvq+AyXkmSOVDKaSCwcdUegPg==
X-Google-Smtp-Source: AGHT+IEdpGkkrwoUrypbJYcUTi2/nsbLadJmyTQkulF1t9PMPhNItLGHqbvAYL36nYF1KG7HXhMmAw==
X-Received: by 2002:a05:6a20:1229:b0:1d1:19a0:d9fd with SMTP id adf61e73a8af0-1d119a0da3dmr8912022637.4.1726408876644;
        Sun, 15 Sep 2024 07:01:16 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab50d6sm2233511b3a.75.2024.09.15.07.01.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2024 07:01:16 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFT 2/3] wifi: brcmfmac: make per-vendor event map const
Date: Sun, 15 Sep 2024 16:00:48 +0200
Message-Id: <20240915140049.181380-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240915140049.181380-1-arend.vanspriel@broadcom.com>
References: <20240915140049.181380-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event map is not intended to change so make it const.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
index 9ca1b2aadcb5..b8c773db8158 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
@@ -337,7 +337,7 @@ struct brcmf_fweh_info {
 	struct list_head event_q;
 	uint event_mask_len;
 	u8 *event_mask;
-	struct brcmf_fweh_event_map *event_map;
+	const struct brcmf_fweh_event_map *event_map;
 	uint num_event_codes;
 	brcmf_fweh_handler_t evt_handler[] __counted_by(num_event_codes);
 };
-- 
2.32.0


