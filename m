Return-Path: <linux-wireless+bounces-23431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA1AC47E7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 07:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3F6178605
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 05:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB371E1C1A;
	Tue, 27 May 2025 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ooMo/78Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B711DDC23
	for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325399; cv=none; b=on/i+dkTE61ZTSnrfHkv856f+J26Y2OOiAIWqdwv+ijN/s/jUKjAW62qjmzf7Vxs8UD+Mu7fCtW4Fnu5yaBpiQF2ffTo4vfYq1eKf9lVTYy7Zo4uRj3E0QL8tXqSLXMZVVtqXJLM6jnZFMV181mwJqJ5ZUDpy+f7bMGcpvcQSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325399; c=relaxed/simple;
	bh=S6lrD0Op5pKlWL71e8qgzke0xa2+KfIHREDTWYi7JZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Igfo6tGJ+PIXPObAJRRmMmgDvQGQxByc+szPeRFZj4LdJHCsgt2wGAxV7mtlll+6oG3elYF+Jbj+wctoNyhzdO5RJ3lpm3svv+auFT0jxyYaOUiv6luEQGh/r2mpBKKXc5iiUeRbM7G4rLPU8uC2EPBdSAJsYf8Y8gDQWN0wk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ooMo/78Q; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad52d9be53cso409074166b.2
        for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 22:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748325396; x=1748930196; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1sqY5GIDGTtXFbbXu39XJwDlCZ5xKeuav8V3AHR7Qzo=;
        b=ooMo/78QLU2KQR5tjALqxSXjmfUPnGjeDyTRyMlydIWW18ESCT2AuXgG12tTr5aDKy
         t39E3RiMPYphlhlBqdbaoWjAL2bAt64Txuj6YxNGT0gzrFVgG5+dX7hff9qpJ5aOoYUm
         qV5A5Jag9FalQUl5I6hJlH2o02Kh3ceLNz3RLD5cRhO9Inux8yW9QTgGCIhIFFaE9Kcg
         eJa+6R+LHRmgIFYy6scyzS8euox7NrSamuoHF0hXg1P5FidjMAiynSp4yhUPavzXRNGu
         gQGmXsZKrphloC4IL9uhKUHrIzTjl+1kY6SR4tSLuM0RyYYSEH4yGoM1jboK6GtHNDSM
         fMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748325396; x=1748930196;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sqY5GIDGTtXFbbXu39XJwDlCZ5xKeuav8V3AHR7Qzo=;
        b=seVdVZWFdh8VvfD7yP4S2vFIz+/1TmYYcWHgiUD/Mqpfk6DbWOx+krZIeuxZb/F+Pa
         1k4JN6Kf1HuJKXPcfJ5LUahR6oCFBfnMCuyX2PYS95EUQSTnF0FjVzXoEE+ezFiI60aL
         ysfP4748BGA+r4FRceAaU036GceKnvjBCKyh2h/8KIfJd6b6f17lng+yqfPz3l9/ggzT
         X/VYWytPEaedwSHRD1TWticf1wcMUuodKNp2sz/fxd4VnSH0xuRAwd1SfeTvObrD2kMR
         8ekJIyUDNabbFRiK3AR6KYs2nRDMf8RcFaDUKLKHMqNkDlRnqaLmyFTHwJTnPxhiX4IH
         tSxg==
X-Forwarded-Encrypted: i=1; AJvYcCU2XKNX/iCG8jaxOt1yt+BBfKm4drSIfl7VPVQhtqbNhronFngISzojXVphaPPIA/GT+zputnU+bWYEz59YoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp33Di37PayBjOHtfKvO2n49Z0sgU+iBBmAJnSxX/dE88LUFum
	y/NsIOjYvfTiSKI0K4y5GWR/MPoXrL1ykUUp03vTIVnB1xSo0nG2Tdso5CyEJwj7t8g=
X-Gm-Gg: ASbGncufucST8EgjmPgjBMwYkP/MCFj/2kQqbMnvUu2FM3DTd1XQsbUXrRAc2Sa3Tc5
	y6JtQjPZdNxcreaVEkNh+Y58+V36RwCk1iAkw8sr9sebn8RvHw69chwHVWHXvRRtgDfzcMZ5Gq8
	P69VTyCJHegsicDrRldgQj9WP0tXin+S4qEWXrsB+eI2LGWgz9M/6TRVDdgWvShh2B9verstjyO
	mAC7TCeIj9vfvSGR01bp4TzrAAH6gD9EJSVedulNJXTDuJPR5iyktDSnemAf2J64OoGpSv0czlI
	xH4sU2+w2niHicYRPDIQeBlflhc7p8U05kEhb6emYK37ouRoZWOzyJqTfI5qFUvSglCqBH3fA87
	GuUpE18mUrg==
X-Google-Smtp-Source: AGHT+IFTol4OTI7mtKP7rV/Mh6vlzvg43m7yooyV7FvKtcQVu98SoqAju8dLAhQhxa1PD6WLeSmTZg==
X-Received: by 2002:a17:907:8dcb:b0:ad2:5499:7599 with SMTP id a640c23a62f3a-ad85b0d2777mr1008212766b.18.1748325396080;
        Mon, 26 May 2025 22:56:36 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad88973815asm94306066b.129.2025.05.26.22.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:56:35 -0700 (PDT)
Date: Tue, 27 May 2025 08:56:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: rtw89: mcc: prevent shift wrapping in
 rtw89_core_mlsr_switch()
Message-ID: <aDVUEHfa9q2zBD6i@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "link_id" value comes from the user via debugfs.  If it's larger
than BITS_PER_LONG then that would result in shift wrapping and
potentially an out of bounds access later.  Fortunately, only root can
write to debugfs files so the security impact is minimal.

Fixes: 9dd85e739ce0 ("wifi: rtw89: debug: add mlo_mode dbgfs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 49447668cbf3..7e5f87700941 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5239,6 +5239,9 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	if (unlikely(!ieee80211_vif_is_mld(vif)))
 		return -EOPNOTSUPP;
 
+	if (unlikely(link_id >= BITS_PER_LONG))
+		return -EINVAL;
+
 	if (unlikely(!(usable_links & BIT(link_id)))) {
 		rtw89_warn(rtwdev, "%s: link id %u is not usable\n", __func__,
 			   link_id);
-- 
2.47.2


