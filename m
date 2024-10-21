Return-Path: <linux-wireless+bounces-14281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE079A918A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 22:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C5C282B14
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 20:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE1D1C9EDD;
	Mon, 21 Oct 2024 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk5twam3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE11A256B;
	Mon, 21 Oct 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543717; cv=none; b=FN8Iv/y/bMjVrTMm3FI+iVCv7Ij+FpeS/k9BFn3k6UFfT5wftJisDYg05KzpUi1EZOwOps5Bb3wS4vGheoiVPndlj1vPddzRWajQiS7enS4wvmw+/bv4BIptQ4ABrttwzpvfYAPKAvFjjLNnrO2CYNYI9onSO7h+4Hzw6wDapXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543717; c=relaxed/simple;
	bh=jeejQkWoFif0OIlF8LQNrN6BapSosBnxpXfYt2G+tGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kf1nP8+x2E2GyTRQkl1mpiQ4yc62Ol1pmEMt6ZWhtTZ1NE0MblooH5qixqkZLruvbwa+JDNZYFlv7vARZ8/SdhbudCcV1jkko47tb1lQ+DJ727tqbOrmrlBxHFYE4HTHdsibV+tK8VCseJloWvMFkD78hy+7E82zIhL5d2Po7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk5twam3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso729867366b.3;
        Mon, 21 Oct 2024 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729543714; x=1730148514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6F708dL/ffeOZXEz1qq/ZOCQiXeq5R//1slMVkIXf6w=;
        b=Sk5twam3w/aeyKSePbtXQLYEfSJERW2nLlVMV7RG/KTlRrQ2V9Sr+sLvk9AOEckh0q
         WbcmWYVZ0hUYqxnW1LEttOANRk+QJ774CUWE+SdW4J6hnM83ARy213A+aqkDgXsMjoml
         vvj4Y/l2gGHtLu6MtcJrFlkNiwoW+BmWzARQdKn6PlZdCsg+1lIBkLcf8fZ0DMogTTE0
         IWxctGUQZ93i5tHYUX7VZ14HNob4OwGXbHiSqE4t8t2bgaeM4AvC6rPGlcnh3eztFMaC
         eOJHqdFQMejb3ApMTam2sgINsUoFgAlh20HXB8NwkJ+jQn7Abaj5Wy9AM9Xbr5sDxPvE
         JWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543714; x=1730148514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6F708dL/ffeOZXEz1qq/ZOCQiXeq5R//1slMVkIXf6w=;
        b=cGI0nnV96oSzCJ4LzxaRkehIroIGek8IaiwJL8ACyv4BPuwYgoK5vBaC+IIA2gQKaC
         uGSdlface+tcnUn4pdCeaGdDRi1hsoIZTiBgUY08e6YuOTjixdq9gTePbuYxwSCavfFQ
         ZXRTlyarRHqyAgO0A5sxHeZsBVeiHbrJAg61iLU19BwiOCoJsk7ayRYJRX4gvvqaqNQ0
         GSkxTolbdLKXAdyrxkGUd2FVzNQgh2hu8TTibGXbLfXRcZQrCKeukAayJj/5ezgxu4Pp
         fHzZ8tF3UD+sjH2taG8vpFrtYiL2hhuRVLRJ6RsRgXCFGbhpATsRiqlBYtlPUOJBmy/p
         7rYg==
X-Forwarded-Encrypted: i=1; AJvYcCVcQynXjNKmZnQe/9Ssd7UZ69ieKk33n0y93lan4D3gG5nm9ASLcrvO3CNWHW51NctHNUywXO2mQ9ZpIOkp/us=@vger.kernel.org, AJvYcCWoaNJc9ZvssD4bmpoHho64k+RXXvv1FYPoQANrhTZLA7kShdMy1WKSRljv3s+Z+L5Jve9/f08EviRc9Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyybUdJ9UM/bjbqDi/GAk21oGgiawkFxLXiHawkiYms/4waTJj
	b5okU0a0+Z3XIshETXaagCboL4oWIcU/0CHfrpr8qccun93Bh15n7jEQaMcu
X-Google-Smtp-Source: AGHT+IGJMghbxAACpszuNPwOqK9gcryXeriFm6MLHgFVXQZJsBlGcOh5PjeUpuPY+oJxLdB6UkGpUQ==
X-Received: by 2002:a17:906:c10e:b0:a99:7bc0:bca9 with SMTP id a640c23a62f3a-a9a69a65949mr1153925266b.3.1729543713844;
        Mon, 21 Oct 2024 13:48:33 -0700 (PDT)
Received: from C-KP-LP15v.consult.red ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee59dsm252369466b.71.2024.10.21.13.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:48:33 -0700 (PDT)
From: Karol Przybylski <karprzy7@gmail.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org
Cc: Karol Przybylski <karprzy7@gmail.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2] wifi: ath12k: Fix for out-of bound access error
Date: Mon, 21 Oct 2024 22:48:14 +0200
Message-Id: <20241021204814.728090-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Size of array passed to print_array_to_buf_index is decremented by 1

Discovered in coverity scan, CID 1600742
---
Changes in v2:
- Code style: added spaces before and after '-'
- Link to v1: https://lore.kernel.org/all/8734kpq0wo.fsf@kernel.org/
---

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 799b865b89e5..8371df570c42 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1590,7 +1590,7 @@ ath12k_htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf, u16 tag_len,
 			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndp));
 	len += print_array_to_buf_index(buf, len, "ax_mu_mimo_brpollX_tried = ", 1,
 					htt_stats_buf->ax_mu_mimo_brpoll,
-					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS, "\n");
+					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS - 1, "\n");
 	len += scnprintf(buf + len, buf_len - len, "ax_basic_trigger = %u\n",
 			 le32_to_cpu(htt_stats_buf->ax_basic_trigger));
 	len += scnprintf(buf + len, buf_len - len, "ax_ulmumimo_total_trigger = %u\n",
-- 
2.34.1


