Return-Path: <linux-wireless+bounces-12981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BEB97C055
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 21:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D654283F00
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983151CA6AF;
	Wed, 18 Sep 2024 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XpG7PMrB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F791CA68C
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686689; cv=none; b=WG3KYVJ0/Ru7SXVvC+tYWuUvXYtg6g+JPMxPIQTZQtmNdE12thtP5zb7PjwQU5kA0r7ssjyTEsKLnPWd2iLNqCoTV+bNEXNEEYvRpqFMDBDDfXen6Xv4ia0WsTSuloiJYAVJet3dFGUkJZjgUWeo9h1QICILgZY63sHMRgi4TKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686689; c=relaxed/simple;
	bh=z1ApUq7/iTxtQ0TDsv1mvl27Cnhr5TF0C9tFP1g9YQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzwosafoCZlOMjuDnNPvyX8U7LOq4m2zCy/H+UuG3FUfrwuH+K3o8ujwasqlDZxCaE92kXXQ0V5UG3HIrJdDub4MpBhC2K00Mr9LRkAei83MKPWaICKVkbkGQJvlvYRnK+tVXRUFFWWAHxwF8pSa7C1Tuyf2Y1LQL0C9jPOTBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XpG7PMrB; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e1c65eb5bbso73165eaf.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726686687; x=1727291487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED/M16yR+lXr7ViSvhCHwCaDzEEhUxZQFCnfrZ9b5KA=;
        b=XpG7PMrBcMHWc0C+yLhW4z/3ltTXfoqR56fyjSN+/1s0N1l/Q2RrldJiUa0hKdLM2C
         8rfAAhYGcLp1q8Q8A7/uNa2/krv7lo666krDjZANtnFxG99rYsxUvyzleMqHkEjnCCOm
         OqliW8OqdyFV6eTLI7E4mOu3e1CWb09XarM3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726686687; x=1727291487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ED/M16yR+lXr7ViSvhCHwCaDzEEhUxZQFCnfrZ9b5KA=;
        b=hQcGxi5P+cRcPceCIxm/knqWK6IxOoBI5gr05DNxNp7CdDlqecO3VyBGpzrHCkamHe
         bO+AeHO5hJRfRxqWI45VMlqGSgQSBrfaesQsoabaTUFiRdsjMCQACMM/WHdULURprWT9
         NK1Irid8mOyjT3NXWP8YKyMyXeRkgye0px/6uTDvpr72AuaBFg4itPID83104rv9JjDw
         IYGZrqdmeU050sToRuxJ/gL2L2+s3B46Ijusoo0ibNiModBq6mKtAdLuNyNISSXDOoBS
         PP5J0S0JzeAjEJ2/a4wteYFi4EYfHnPOv/HjY/X7Lq2TVeHjcX0mzbH4+IMbTy0G/TOp
         uxaA==
X-Gm-Message-State: AOJu0YxyJ5DwR4Wf3xx8IPGjR4g7KJ4N8/RZULv4G6FiXI4f4iim/elS
	lq+IvkCAqmEyKik3/D+1Gm9ponZegdZ5xIzEeuhr2lOgL5gIAM3dgzfJU2w0oQ==
X-Google-Smtp-Source: AGHT+IE+wHgej1KbyWURYuoSm5uZ/KlC4kPtU3qVpyDsLJPw+v74tF00XWAGI+ZJ751C5UBt6AqVDw==
X-Received: by 2002:a05:6359:4ca8:b0:1b8:21d6:6034 with SMTP id e5c5f4694b2df-1bb14e0a0c4mr1215771955d.8.1726686686901;
        Wed, 18 Sep 2024 12:11:26 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08dae51sm2275885a.122.2024.09.18.12.11.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2024 12:11:25 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFT v2 2/3] wifi: brcmfmac: make per-vendor event map const
Date: Wed, 18 Sep 2024 21:11:08 +0200
Message-Id: <20240918191109.41960-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240918191109.41960-1-arend.vanspriel@broadcom.com>
References: <20240918191109.41960-1-arend.vanspriel@broadcom.com>
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


