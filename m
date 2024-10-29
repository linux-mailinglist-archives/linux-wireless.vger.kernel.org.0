Return-Path: <linux-wireless+bounces-14635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0309B4A68
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 14:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B836D1F21DB1
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A2F206949;
	Tue, 29 Oct 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TasldsgS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755D205AD2;
	Tue, 29 Oct 2024 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206823; cv=none; b=entEQSIpJLbfq7nzMRxXRAybkWZ5ub9nW/UXn/afge3ay9U34YoBQfoEh/5iMQ77ydEb2moNGDgXKt7YCH2oGtjkKg7AqwZFsP1RktSLSMxEBSvuW1BSfgzMMC9wqckENsW8TjjG64lmeM4G0/Hs0q9vukFfttDOudru4G2d8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206823; c=relaxed/simple;
	bh=/HODKqyTbX8debkHRaD8QH09a9ZSaa3+QoR2gUV6EhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIdsxnEMOCt0528V6u1cMqcPgpaAfsd1rd/egM5vEMfovXOT5CFAQSSpfDpZLEenAg4Fy2Rp0Ph0JmiFzyHcUiKiiedDVBBXIg157P0oTaV9/mmMv/g15c+3mz2D/m6uOgq0iHUVmT+uorm2iRbHfZDuGNewEp2Wzenwy2CbmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TasldsgS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e7e73740so4534321e87.3;
        Tue, 29 Oct 2024 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730206816; x=1730811616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r8k08nfNU0BjonzWGfRlb9unupSG36bdp5/08Z5bcw=;
        b=TasldsgSY4rdkBSvWoXlNEmd6ZTl/CYLkeMvWM2WpNsbRRMbX5yGK92L5NZT0rFXHv
         2Si39OqQkiDHqhJpOKUw0sALe3snMF9r6FZXFoPLMZI3pXcnt0DPX8IWHGRFz9QAwFXI
         RrZ5ZrfoSSh+zHnmaM0LZlIeV5awjLPShmWRDrrihI164KyOBDx6xqEU566XW34mGAUJ
         kaJA8QPMHAk1yVjyyv5lyudfLUUpgb4TrpaujTiGQQaqy/3ayqPN93PShDgcbNEM3JqP
         rTrEG3LLEz+RFxZsQ6+k9TycjeTy48B5FIEU5B/P+Ab8Pbg+Ob2VYzzy11qmrU/C+4F/
         YmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206816; x=1730811616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6r8k08nfNU0BjonzWGfRlb9unupSG36bdp5/08Z5bcw=;
        b=LrpSGOKH9STICioTHRyx//bQnO7HZiO6xQm4lLc//0MDKaPsevE5WNy3LgdsZSRmXN
         VauCXVWwGphjcbYv7f44iWiOLi60yz4oJf7Q1Lo7xa55TEj/anvHpbNwTOF/sb1h+nQL
         bCtiSxyglcXyjnm8gra5040c1v7VXcVQBlw/DgJSWAhUP8R9wavil27FS32UryvquLrK
         Kum5KPqULv76HnwmsgOda8jWqLgxUJaEqgekT43XYhRJIguvyC7pdtD0U4z6EX5wCk0v
         mKOK7ONwmUMFw647X1ZowJ3vHma4fN8M/nKJOOSZvb5CC5SQlXGjHasJqhwYXHnIZD5L
         XNaw==
X-Forwarded-Encrypted: i=1; AJvYcCUuCKcCNHYHoQfO2+u8cpqV/4Q4qHnrxJDHtgbU0kbleDlk8CEy5ALELHb3bGUBcoIR6osfaZ8ZHwcQvj0=@vger.kernel.org, AJvYcCWndtyjFIaP46mOnyau070jAdcD2SBkjZeiI78bAbi5T2fwcyTOh27zi6nbwsVf6K7LnJRo6+TKXaIFqFp/RCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8WwnFm3iR5hpQ9tQNQJ9tDABAmtRlXtWwjzEOKg/tuKOKQ+Vi
	lwGs1FTAFIimmJGKWiFkXN/eReOy0lxXkJFwnLPl3kxbxFTaTQYq/GKbeNys6PY=
X-Google-Smtp-Source: AGHT+IH7BxiE2+elBEtNece5JanndPqtr2bn5pcJZE8uhcoVy7E9tVpE/96YpKV0V8tgZQkx03HkDQ==
X-Received: by 2002:a05:6512:3510:b0:53b:4899:9be9 with SMTP id 2adb3069b0e04-53b48999ec1mr969614e87.59.1730206815637;
        Tue, 29 Oct 2024 06:00:15 -0700 (PDT)
Received: from localhost.localdomain ([178.219.169.18])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b48999d30sm214911e87.115.2024.10.29.06.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:00:14 -0700 (PDT)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Peter Kosyh <pkosyh@yandex.ru>,
	Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 5.10/5.15/6.1 1/1] wifi: ath10k: Check return value of ath10k_get_arvif() in ath10k_wmi_event_tdls_peer()
Date: Tue, 29 Oct 2024 15:59:25 +0300
Message-ID: <20241029125929.288059-2-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029125929.288059-1-d.kandybka@gmail.com>
References: <20241029125929.288059-1-d.kandybka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Kosyh <pkosyh@yandex.ru>

commit 473118917cc33b98510880458c724bd833653db6 upstream.

Return value of a function ath10k_get_arvif() is dereferenced without
checking for null in ath10k_wmi_event_tdls_peer(), but it is usually checked
for this function.

Make ath10k_wmi_event_tdls_peer() do check retval of ath10k_get_arvif().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Peter Kosyh <pkosyh@yandex.ru>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20221003091217.322598-1-pkosyh@yandex.ru
Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 0eeb74245372..72da02fc68ea 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -584,7 +584,14 @@ static void ath10k_wmi_event_tdls_peer(struct ath10k *ar, struct sk_buff *skb)
 			ath10k_warn(ar, "did not find station from tdls peer event");
 			goto exit;
 		}
+
 		arvif = ath10k_get_arvif(ar, __le32_to_cpu(ev->vdev_id));
+		if (!arvif) {
+			ath10k_warn(ar, "no vif for vdev_id %d found",
+				    __le32_to_cpu(ev->vdev_id));
+			goto exit;
+		}
+
 		ieee80211_tdls_oper_request(
 					arvif->vif, station->addr,
 					NL80211_TDLS_TEARDOWN,
-- 
2.43.5


