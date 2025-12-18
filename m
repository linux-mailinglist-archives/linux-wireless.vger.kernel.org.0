Return-Path: <linux-wireless+bounces-29895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A72ACCAB6E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 08:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7297300761C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9637720FAB2;
	Thu, 18 Dec 2025 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfEbjCUD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820B298CC0
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043868; cv=none; b=MpjBZqHv7QssWlfwyQi1fZwMblaoJEpstZ3jXNAe/gCxPUfn+xXpUSNYnKj5rE4mHUwa7KHE3ghTN8qoq+cUDPxDnC5HD08Hej2oHsVXZfJ3yJjjOH66DIuspMODlpElWfPIMYsJGuo0cwt79CFFO7rhsOp4tVEtAQNz6hcNYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043868; c=relaxed/simple;
	bh=XbnMB/v37ZvTMnfVrio95/zDhdVKRpunW29/ufxDUwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V0D0eEhlfqH2MnkuSdcky8y0ZYRDQ6PvPudK2ug9P7IiLbORdBP+a/48JbW/LUdRedV+bHRI18iTfAvCjwiY5rPgSupY0+Icxi84aX9u3DEuCSxsaMJaGU7Yx7itaed+v9j2cvtzB0vEATMhIO2md7lw49UYJ5vTPZ+8jOI4Nw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KfEbjCUD; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477632d9326so1815475e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 23:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766043865; x=1766648665; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmBu8zFR/klecwYr2D2QZWbIrMNrDUPX/mNk79sUoPA=;
        b=KfEbjCUDjlxbQpbNyOPUXqcyclaeCmeKPHFMJeXC9Tci9Ie5ZZtwV5u8AeaXrNjK1/
         b1Z/ZQHN6nMOGYIoCYsK19OtVUBbDq7rO70T6tEllFjqjajAipMjx7hRF0JpoWk9ahi3
         4Q//rZdrtGHF5Y2Pm0Th9Mz/t9CqglFp9GmQecKwVVNunkEf5C491U3jJv//OQfAr1rV
         3pyxzRxR9sWsOiNTA13mvHVP0rAnjfSA4t1LuDgq2mF4Cyzn8NELqKB51j9LuOQSUwqR
         4nLWYbSMOvXV2xhq9cQh4r0hdlff+LOr+J71cuSQwhtTHS3TDSxAQXsvzxlS3r9Nh99+
         98Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766043865; x=1766648665;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmBu8zFR/klecwYr2D2QZWbIrMNrDUPX/mNk79sUoPA=;
        b=Dh2rYS7fe7oeHFzvndawzBwkj6PAzuWCViGIQ1gCf4WZlWx12XGPtWyopbFixeysPC
         p1PlZ0aTDI9s7FkvpgMXmhbqdSXMO1ZNrkOemglFNghuPNAjdHqKM6zOhGrsdhlZkT+H
         D7pPx7BPQzIb0d7+Tr8LB36nLlr1fsyyr+hLns54SBhvYuK3MEdvB0L/YOFIUVEEJRav
         PecZfO+WaOinB2wX0yVMwwaTK6GtSr5/pw2xecsI50/KjAvB9j1leUpA5PN9nUAt8Ez5
         pVIo6X+iHHSjmefvH5sFNZSHOCJ3XaXCVAt6LMNkBG5MALWasBMHF25D50WBoScN6dyJ
         PQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKv7yNLdDK67LFM9jnR6mlHF9bsicQj26zhMws82Zape1aOmSzBi0Tx5GAC/TvVBr4QsaXEQKUGIjUYiu/lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKf5k99igC5nCVX7Zvprh+8vLbfWPLg3KSNlb6NisCHITlXsOO
	hqUrDfKwMK1Zas0bac1pRCLBLq5ENl9B2RSHKX2LClyI+fOEvBb7Tx3JtNrjXVcIVNU=
X-Gm-Gg: AY/fxX7l9025RlAYLXlxQvpHcpT23O1sxZZP6mK2SigjWPzb73uj9lPGAbDnUMr6GF2
	zLjDiJHoLwmq+hz7i7pg0L/qpa5ygfjm4FxoMiy2Bd2IyPpozFA86J325FHO08dMHJDi/eDCH1V
	NvZZAhlX0h3AZWuJto8mIitcFEZqLjY/WG7kcGi59N1RZIBIxdRfVDSp5VpZh3bYv/B4d3GEsUt
	VWKA8iKh+AAnMBHYMWTeHjX8Ge2Ot2VDLCZ4xjZKoZEnjkrgQkHddU08WrTaa1w/ZHMIqt2LY80
	jTeOxQxin0gmYOOBNtdAMRSC2pH9s5wEcbVJ2fV/Fyxn+S97RdbL93+YcIldPAFyMLEtlT39YOc
	Z3Dq/44L104ogHAx0xhIhauXSQJ5NcNKfRw+oM5SgahMZCDx1HwGt1xj7Yny8+1C/mOuMzgcJOD
	4UjnHIwDyt3VKUsHcX
X-Google-Smtp-Source: AGHT+IHeT5UtBHWPRMxU9FR3aTP1+g1lAhxDtBjVewu9mYYmBR2tXxoSh9w6+3wkstsmfDdqt5pgvg==
X-Received: by 2002:a05:600d:14:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-47a8f9a825amr168231755e9.1.1766043864798;
        Wed, 17 Dec 2025 23:44:24 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm29116925e9.12.2025.12.17.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:44:24 -0800 (PST)
Date: Thu, 18 Dec 2025 10:44:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Ripan Deuri <quic_rdeuri@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: ath12k: clean up on error in ath12k_dp_setup()
Message-ID: <aUOw1J0TU4VgeXj6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Destroy the rhash_tbl before returning the error code.

Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/ath/ath12k/dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 9f05eea6695a..ab54c8a84d3e 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1513,7 +1513,7 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
 					HAL_WBM_IDLE_LINK, srng, n_link_desc);
 	if (ret) {
 		ath12k_warn(ab, "failed to setup link desc: %d\n", ret);
-		return ret;
+		goto rhash_destroy;
 	}
 
 	ret = ath12k_dp_cc_init(ab);
-- 
2.51.0


