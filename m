Return-Path: <linux-wireless+bounces-14916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F09BCA11
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 11:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A265B20AA3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C11D150C;
	Tue,  5 Nov 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hst0ANOB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BD18F2F7;
	Tue,  5 Nov 2024 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801499; cv=none; b=ow/czIQIwzGztcSfVqhAUY4nwX7lPOeKfQUqOm8+CU+3pCEsjgiFBFPPHTPpdk44DXAR+jmPFCTZr2RytPS5xdERGDOFqkHVWc6AyMqyq7dyUSRMRjfrs+vLacrmgyQvc8BuncZFRCJTNhGxv5XLRCmTmYtPCaL87es7EHgTky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801499; c=relaxed/simple;
	bh=e7qvTXiBxF2JlvBmUYXyl7D09eINkYn6FxD4xnH0fsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LGazsGctLUvDimcRs9Jbm4gGJuxhejnsBLWrQMK6ml47M5ycZUkctNv+8T+gBGzt3YSS3bqkhYlcSZtgj9KO7xPD78dSmbH2f8eL5kxkVe+z3LmCFhinh+tBAqOvIY81U5uNMbe1QnrnWU4nTQq+SRAXrKYIwXw3Vv6rYAFUIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hst0ANOB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a628b68a7so810975066b.2;
        Tue, 05 Nov 2024 02:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730801495; x=1731406295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qso3BNgt6veXyizsNwyMPr4H1EWMOffJ4h1epwKOSNQ=;
        b=hst0ANOBh6AyxLjVKmZmQzfrZxurBT9Cf8B1Njcfv/QQ7SvsuWHYUESFiPV7HyuPMW
         UJdnjPHD/oQl7wbyLcjEwcUKOjMqwvHecocgjD5Sje7yBpPUmBxqFb5CqVywWTW/1Y2F
         jnJgC0/ZWWtZbhAOqL4/jenKu3OiJzWPiX5lg/q2EtXAIGATbXK/0Gt1R1Ta6K5y5TcP
         W77C5Tm6nZ3au5zvP8oUp627G3dgQXucCek5sntopQVJ9EBpolBa+1ywEsxjrJZlawkd
         uCVNi+hyNyqWqHsmqeks4v9DEj2puHZnMEYJDlOh+9VUP5Vcx5NaER8El/2EHsWLtDEG
         wHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730801495; x=1731406295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qso3BNgt6veXyizsNwyMPr4H1EWMOffJ4h1epwKOSNQ=;
        b=Mw4CNbUHBBr8kurp/lSpKy/ugBydKQGDKNcBuWu7Yc98Phi1xrRhtFRikyAp77nX+W
         bSQyVLEPnZgIeMFui8O/CJre44loigAKy7Cug8pP5ZCbQ5H23mtWFqojgaZi3hkAP67Z
         7YxNDJXwE63+ZganmL/RNYJoc3KDBjVq9jofc48cGH5jvprH7q8o3VSNAy5Rii8e/3mZ
         l629r2V7T2kqRJOQ7JgsM5jKwYpD5g8hRWvUOj4bKA6B9SplNoNW3RcSQa58R1fFFiRo
         jX55spx0sYF4qS2D/iAlrRcq+SavnNrz8ETNigMFddBATbqvAGl9Z9Knj2NjeIARtfhn
         w3PA==
X-Forwarded-Encrypted: i=1; AJvYcCUyojzoJM2fJTxwEzaffbkFotkMHZ7iU1qaSGH1Pu7zuiN1Brkietq7CXfvMOXYvIaqM10q+eCa41ZqCxA=@vger.kernel.org, AJvYcCX+FEvJRrzfuLeQRJuq0CK88CszZQoV0+arr6aTkWtEbvN1TMZu6p8793ORathk5KIyZ8nKEBYrpfDzJepxoAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBXAFcUZfg9kkxlr+rDTt2q6DIP2MRyE+3SE+PtTmSdb+6X/z
	DCO3yfRBsSolbzEDo66hL9kSmdQ7AvTbSVoJ7kImAHeb9wx45bWE
X-Google-Smtp-Source: AGHT+IFnWeG5l3Win9wjTzFybRiE4MG/9kCs5ddsSiKv9wYvZpxcQ5x6vD6FqymkY5FYZL7mKz7YcA==
X-Received: by 2002:a17:906:f5a5:b0:a99:8edf:a367 with SMTP id a640c23a62f3a-a9e657fd779mr1437610966b.57.1730801494703;
        Tue, 05 Nov 2024 02:11:34 -0800 (PST)
Received: from C-KP-LP15v.consult.red ([2a01:96e0:10:2:aaca:6c8f:1aec:b83f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d6714sm113494266b.64.2024.11.05.02.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 02:11:34 -0800 (PST)
From: Karol Przybylski <karprzy7@gmail.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org
Cc: Karol Przybylski <karprzy7@gmail.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v3] wifi: ath12k: Fix for out-of bound access error
Date: Tue,  5 Nov 2024 11:11:31 +0100
Message-Id: <20241105101132.374372-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Selfgen stats are placed in a buffer using print_array_to_buf_index() function.
Array length parameter passed to the function is too big, resulting in possible
out-of bound memory error.
Decreasing buffer size by one fixes faulty upper bound of passed array.

Discovered in coverity scan, CID 1600742 and CID 1600758

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
Changes in v3:
- Code style: added spaces before and after '-'
- Improved commit msg
- Fixed same error in different function
- Link to previous discussion: https://lore.kernel.org/all/08767ff7-f764-473d-a44b-c3c3b1695008@quicinc.com/
---
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 799b865b89e5..2d47aca681f4 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1562,7 +1562,7 @@ ath12k_htt_print_tx_selfgen_ac_stats_tlv(const void *tag_buf, u16 tag_len,
 			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_ndp));
 	len += print_array_to_buf_index(buf, len, "ac_mu_mimo_brpollX_tried = ", 1,
 					htt_stats_buf->ac_mu_mimo_brpoll,
-					ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS, "\n\n");
+					ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS - 1, "\n\n");
 
 	stats_req->buf_len = len;
 }
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


