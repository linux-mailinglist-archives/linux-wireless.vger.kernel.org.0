Return-Path: <linux-wireless+bounces-19441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E0A45188
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 01:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E05F19C26C7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 00:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853E13D503;
	Wed, 26 Feb 2025 00:36:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86223B19A;
	Wed, 26 Feb 2025 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530184; cv=none; b=dq6LN1UEv+XxtY2pfp/kyCwWXlmKstBle8PrEgbqmmfVL9ExiP7I6K1ST4NLKP3ZSZ7eJiZQAarIrZIfgPOpHhdGAFKZ5Vml47upoPwdHbUO0JLOi5VWmmTEyYMzjMyDC9mOOpphUhtOJAshLOEuchUEKwb/6lGGfNOSITuyFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530184; c=relaxed/simple;
	bh=/Y3sOOa17Y31Db0GCSgpWG9awDyAyewC+US5XvirqzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lH7FoDF7z/YofXGRLh/4lpj1q1969s9hebm5BlcqwK76939jFVj5b0Zh6c35i/FXC+AnoQdzePfqCeJRwg4rHr0MXbfgJI3HB0TfZ5YnzZbyzLDUAVrBTEffogXnLBokvg0y48Oy5Q1FCnJmNNracWLGcL7iPqcJ8obtgm83B7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2b199bb8af9so235687fac.1;
        Tue, 25 Feb 2025 16:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530182; x=1741134982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pletKUouyioVsVZF/fqts8NACaRbQSVihtm5ubC1Lo=;
        b=eg/ZNOJSKWf6VKyGjwseq6NaS8/4TGPq05pNmZKulangUSE3eMgyKbkLQI1vNLRSi+
         K9MDnzSvMygPnKPdjrYst8NzIJihi782dBzAzKAAzaDCmnEky9CCmLEOCl4KSK0wooyh
         XSaenhOn5ve5de9BfMIFDRCm39hXHFzBLBwXPqW20LxWiTjNrCsdarufUXIvGSQT1QUq
         N9UT77BcWOA1Q5ZqIkaz0UJUOarjpAnsubEK3333NnsFgZc746MkIHdTL1GW8KO7CCkP
         HmhixIxhLFVoi6gFnyy55IFeoFQgPDNBhjWYJsFDEb3qUuEvpatI2xG9gV/oF1c++t4s
         bTsg==
X-Forwarded-Encrypted: i=1; AJvYcCUXxxDdoKy/Z93H25jsawvOvjny/tmUzSDgnahOQo7baq0hiBzb7JQ7fD9ktvunk3YUqfGGQpogQlxdIamrPA==@vger.kernel.org, AJvYcCWvVPXW/snKCjPgpFjmVESkfeaZKHurruTfXJ9vslfQET6htJQOkq+CjvpuQWWGa27hh56hvYY6@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZsuSX1Fj2cN0mPgKsqv33rCQI9eIqi/t1grWp8AVPzsCbiRY
	wZhNcWlQsfOGglkbBLc/yDVqgn3XfdpEgL4EsIG2DzHCXH9hFdzp
X-Gm-Gg: ASbGnctO5NMB0hqpE3GPzeLwLRR/7WSPwwedGMwUm45b7+eIsKGQbG6PxYwOilDHT4v
	TCLznsUV/0TyYWB9idsYdTQ3HH0PSR1bt8AUOf7F9nac1/pQO38jshfe6SSXo7knW5u0lxtoEED
	ZtT86XJ5pYHu41p+6zEToWV7w8VyC/fJBD2RzJ9tu/K5AIafF5w+XbsFYB+Ewn/tQdUoV7LZpsp
	DDIhGPSxMawbfvtMgKPcZnrwkXs4+K0LMqIK+7rmiXH0X6FDdZYswKkHSuW+DPikH4HhDnmM/VO
	qYfFOJ2YThY3iougre/4484V4CWCJNT/qHQkby5QwkU=
X-Google-Smtp-Source: AGHT+IE+KnU9djLUwIDgiUckZlw8WOzgnFVOrJr/Sv1no+MvEyc/jKn5lo75RCkmsvMmoTwWdtXnbg==
X-Received: by 2002:a05:6871:d284:b0:2b7:5726:c931 with SMTP id 586e51a60fabf-2bd50094ebamr12702438fac.5.1740530181668;
        Tue, 25 Feb 2025 16:36:21 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289dedfcd8sm507149a34.16.2025.02.25.16.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:36:21 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/6] wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
Date: Tue, 25 Feb 2025 16:35:53 -0800
Message-Id: <20250226003556.82644-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226003556.82644-1-sean.wang@kernel.org>
References: <20250226003556.82644-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The mt7925 chip is only support a single radio, so the maximum
number of simultaneous should be 0.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2, v3: generate the patch based on the latest mt76 tree
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 4f35c2f16d0d..604f771af68e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -256,7 +256,7 @@ int mt7925_init_mlo_caps(struct mt792x_phy *phy)
 
 	ext_capab[0].eml_capabilities = phy->eml_cap;
 	ext_capab[0].mld_capa_and_ops =
-		u16_encode_bits(1, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
+		u16_encode_bits(0, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
 
 	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
 	wiphy->iftype_ext_capab = ext_capab;
-- 
2.25.1


