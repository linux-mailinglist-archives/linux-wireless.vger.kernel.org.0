Return-Path: <linux-wireless+bounces-12843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555D977C8A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 11:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AF71F289D8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BB11D67B0;
	Fri, 13 Sep 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZA1Jyzi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A713CABC;
	Fri, 13 Sep 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220914; cv=none; b=aRAcj+WL5eJqMTY9kNIotY8jScsrEUFVxE86o6q2afobLutWMCnWxVXwW22jG62PZJ74ZSmTBLnCOCpfmYCfaEpqc4oPBpdnylKl+/ZUaQqDMCv4+E4lxX+cXADZ8WKG5UOwUDMK04BkTLfsnyrvzY82w3a3JKSwuna/qAGA878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220914; c=relaxed/simple;
	bh=xgpGRsCTpAi5fY/qcvLV7YM6QgUN1NxtneHSZ5GnC5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kpu9iqv3IieO34S8qNQwbWeonLN9stNeK60Z+REDI+fTT9DW8/5zhLU63RnL7GrjQp6qh78dXucePnxv1SlaNKuurimHUXkO8eRAPvglunKO1sjowvnCacXX/rrEkCnz10tEL2f7Mz5oFe8tSwg4UntfiN7xzwS4vUR02bDu+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZA1Jyzi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374bd0da617so1340574f8f.3;
        Fri, 13 Sep 2024 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726220911; x=1726825711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/eKjE/ZIiv+2bvRdfHp+82zpO7/8oX80AIbfHpCg2M=;
        b=BZA1JyziZfhAEesEopFOlTktKPscz/wNlXzfC3BG0znvq5ZIOWlA5S1l6mH95zwG/y
         NAM2aSLVWt1fOzHMgO1xDn8k7ECR06Rwzb3CH2Z6+mTOIZU152n1YtQuhzD9PKPeQfpQ
         5Qfi+vZb58bvb035JFsIPa04DWPa3yeOpQqaVZbh+fi8+qmDhQ7izTzfsZaxPnv7CR7Z
         F3yMUfXu6agTz04weQhIuZQnmKNs3UvkYXqyfLv00JI3EUl9nQ5V03P63hzf1299HIRq
         FSdH7nloot3sAjnif4Mwz2xKf5GCRy8du6gIMbRqG8pGROXxUxxCNJiajjttYs2s70Fu
         NC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726220911; x=1726825711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/eKjE/ZIiv+2bvRdfHp+82zpO7/8oX80AIbfHpCg2M=;
        b=QcEHLVbDfngQHpZlM3FiXHCn3sMHW0CyNacIr8LqEYc7tzMw66VuorsLY/HhTjP+Sd
         SrPJiYoEZXasNJ/Qi2mwGuqIK9z3e2yaRg0XFmlokGI+cQG1H32t7A+ii1pDm/V/WBh+
         +8qZN4mgCbXZAR66H/stgOPRvcINOazVuAPjTX5aGta9iiqHGBsVtmIYuf+pynEp4Quv
         eamUs8B0K42dzzUKkQNejxA4O74OgOYkTPznzl4q8HAcWVt0UzWZXDsE5JiweqlbOQlT
         ll6UTK0W2e/rspeSkdDbZdfWLJm7rzaE86Axivn/+g0XHR2xocX8Wzay2jAYxFQ5yo3f
         UynQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrL/pLVY5+CbPwXHD1VeRCcIHcf1py21D4CUt9c26lE2GhgHUGstNR+m/SvlFZbrbMYaAoUW9HqQqRFdZn2RI=@vger.kernel.org, AJvYcCXkwXFfSjwWtOwXwNarCF0CAAQCpui6+IgcwRX1qMERutlPI4JTNvZ4LxGpDEtj+SeLkpWCforTUwQ380du@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVSQZbpCBDiGj4l/b77r6vPyoCqmoOVE2CYa+eA7SqiIJ15uJ
	yY1dHmBHxqwoeqxGfrMNQY5BarDgqf0nu8ZPLwNCadjGtd/IGzm5
X-Google-Smtp-Source: AGHT+IH8ykEdbL6dIm9/qmwfUe0sUH2Gi88huy6I1kPGc5tApxXUPMHDJ5VEoMIfhcjSz3r8nvkT8A==
X-Received: by 2002:a5d:6788:0:b0:371:a844:d326 with SMTP id ffacd0b85a97d-378c2d4c9bbmr3754253f8f.43.1726220910171;
        Fri, 13 Sep 2024 02:48:30 -0700 (PDT)
Received: from void.void ([141.226.9.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895676093sm16326846f8f.65.2024.09.13.02.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:48:29 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] wifi: ath6kl: fix typos
Date: Fri, 13 Sep 2024 12:48:10 +0300
Message-ID: <20240913094818.14456-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/wireless/ath/ath6kl/wmi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.h b/drivers/net/wireless/ath/ath6kl/wmi.h
index b4fcfb72991c..68384159870b 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.h
+++ b/drivers/net/wireless/ath/ath6kl/wmi.h
@@ -1249,7 +1249,7 @@ struct wmi_rssi_threshold_params_cmd {
 	/* highest of upper */
 	a_sle16 thresh_above6_val;
 
-	/* lowest of bellow */
+	/* lowest of below */
 	a_sle16 thresh_below1_val;
 
 	a_sle16 thresh_below2_val;
@@ -1257,7 +1257,7 @@ struct wmi_rssi_threshold_params_cmd {
 	a_sle16 thresh_below4_val;
 	a_sle16 thresh_below5_val;
 
-	/* highest of bellow */
+	/* highest of below */
 	a_sle16 thresh_below6_val;
 
 	/* "alpha" */
@@ -1287,13 +1287,13 @@ struct wmi_snr_threshold_params_cmd {
 	/* highest of upper */
 	u8 thresh_above4_val;
 
-	/* lowest of bellow */
+	/* lowest of below */
 	u8 thresh_below1_val;
 
 	u8 thresh_below2_val;
 	u8 thresh_below3_val;
 
-	/* highest of bellow */
+	/* highest of below */
 	u8 thresh_below4_val;
 
 	u8 reserved[3];
-- 
2.46.0


