Return-Path: <linux-wireless+bounces-22022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8BA9B86E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 21:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEA51B81DDD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 19:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D533A2918E2;
	Thu, 24 Apr 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cit91KBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E327FD56
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523803; cv=none; b=R/6VTNl2dpjdMbBT62+KsFN1/0K5PClitSJYM/iA6jmHKWQWJ/dynoXoxXreKIM7sS2N95Ajyg3hFHdF4/QQN/hHMAAVOrGRu+3Jf8pFXpcEepCevpXhFlQldDlXKrYl/bQjZyBWHC+FLfIWiA+QtS0I0X7tSm0+jIqshbt208k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523803; c=relaxed/simple;
	bh=5p1ghz030t0rLxOmI8c5IYOtY817sRraSfxllpncENI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxvUqKVa65Y+4J6EaaIJzc4h4S1Kdwa+C3CrdcV4c0Aup4F3pjU65A54LGWdhdIKMsuW4fZIH4jP/MXt4tkkw1sThDuJT5VykDwmvAlvWvOL2pmudWxi2Z5cvkDjfjpo8jNUlUrvOzlUqZVwGARpSeljr2fYbdy2S1hrEFKypJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cit91KBm; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af6a315b491so1371289a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745523801; x=1746128601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UZxtW3kPc6nJSgpcHu4czu11dbH1HDpqjV9mIbR79E=;
        b=Cit91KBmbE0rSv+qJzuZgnGonA/t7MEzVQrTvMeIze0kQvlVSc/1sRYh7uVTsLk51A
         5w4X5KQhVHlh8DzRhU9z4TmxdTn/eKbM3Nu5Wfxswp719CmrlUBu8fAcV3rpwQUYhLIW
         66EG0kkox4ayYcYzYfb7zedy9EqAQIVrQhseY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745523801; x=1746128601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UZxtW3kPc6nJSgpcHu4czu11dbH1HDpqjV9mIbR79E=;
        b=WMfaTXhdNDYVbcf5KkeZ74WUmzgr9l3Qr82Lmwr7BPMICLDCBiegWpmWkE0wl89J1r
         52a2cddt969a6Ia+0UgDHs0MBHU53NPUL3ULVDuj7v9c7z1x+/rk1jPCOhGd2Wnq9gP3
         1eOYMm4bvGgiDrmXrPLh1rA1cD7K3weVnWoqfCCvn2KI9UqnkunsrH8fvygF4xz3vTkz
         2gmAs36rytGxu8GAlP72Nb4YykA+kDdaA25rJNWtGUXnfjZADGdqTcSf8zvnISesy7zc
         N+g1CaOxF83nycqhj91xlRXe5kZ7AA7vuvfBwAmAtISMa+G5F+8z7ulssZ+dsY16ngbI
         wxHg==
X-Gm-Message-State: AOJu0YzhHeWhclcB8AxOBgV9ozNZB+Own4P+4ZM5kvh4Othj76sfoy+X
	nIGn3bMsaS0t9bQafBw5SE0QrrUmboiUmUjhbBLq4rQserB5sRSTEI/3Hj8riw==
X-Gm-Gg: ASbGncvsOn08J0ENHtaHnjIcCkHe7T01wCn9RAOBJyW2hsdLr2SwNY3dOIm+URYmmwB
	isQ/jujC7BnWc+Fow/NI3RaSSXnp4lonwQwi/FW6n+WjzXcKeif0mNm+hcmLkvRMhKX8+MinVML
	YJtc2dD397JrLtPq++Fi1zgX2dXhq7fkr/E+11JnMYVYxz0OjPJ6vpYlJijTe5CbHlSAumWGIDB
	FBh3EMxKlPS+3FWsyawc26IWRKcxn8lkiBHQylOA7uj4LNR/m6s58ZMAnb3TAWh1DZTFNMeDGi3
	9fDar6Z4M3QW43AaPDdZ29TL43xk9IFqOEl+xLQjYVZfSeu3hkafTH8O/buMrlzs5pGG8zrKXno
	ADiz/ygt+wpqWpBzivIRj
X-Google-Smtp-Source: AGHT+IHj4pkMXkAmfOw0WGb+TKWLQzOHMU9HfinAmJwV6gaK6xC7xQI23oPWVFzELRh4N7q5scq8oQ==
X-Received: by 2002:a05:6a21:8cc6:b0:1f5:7873:304b with SMTP id adf61e73a8af0-20456715904mr698677637.26.1745523801549;
        Thu, 24 Apr 2025 12:43:21 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6aa52sm1863494b3a.94.2025.04.24.12.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:43:20 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	James Prestwood <prestwoj@gmail.com>
Subject: [PATCH wireless-next 2/4] wifi: brcmfmac: make per-vendor event map const
Date: Thu, 24 Apr 2025 21:42:37 +0200
Message-ID: <20250424194239.2825830-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
References: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event map is not intended to change so make it const.

Tested-by: James Prestwood <prestwoj@gmail.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
index eed439b84010..38a9138f1fd3 100644
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
2.43.5


