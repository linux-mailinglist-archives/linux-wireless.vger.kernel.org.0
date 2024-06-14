Return-Path: <linux-wireless+bounces-9015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF0B90918F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 19:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE26028D056
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2F1A01CC;
	Fri, 14 Jun 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/ng1T67"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F3383
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386347; cv=none; b=RMTtnoxGCZDcisJhyF9YcMScioKk2inFXVK50WNXRjZJ9QX8oyZT+wpbSBWs47d1cXW8kD9ptsoxo8ygNLijYy5wYdW10AnXM+HVWcLpOJ/wqLD64RW1DTay8iYsOKwJh788vNNj1teOWpgcNebPgiC5kXiLvrwDJGY6R3Qm6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386347; c=relaxed/simple;
	bh=BTDfLj4AnRVLzvSB2sl6u/qP7TFE0iMJBw7H91ZibCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T/hU/GmUQCYZT8UqWcqdjJSuTPTW+LWfzqRqtX0z7JjiRWhNTjWGQnDE4ooxnA5pA3pdRizh1TXHJD7DH9hyXhPxB6a+mxo3XjsuANbLk9wdUN2dhCbsZngn2PSStU5wXGSid06hW69pXkX9iLPqrNynJs8otJp7moNDvjz0E6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g/ng1T67; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f1c209842so1860454f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718386344; x=1718991144; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHcGiX8UBCwxh//a18tmbSzvIIZ91QoZrb+Pr6rgKAk=;
        b=g/ng1T67W+kDlprcUiw4C9+Y39g//0l3cpj/cSFFq29jpPtW6mGSYCMwvn60vBFZ25
         o43MOKo6N7MOZT4Ehc+vMhpm2IyH/ttDd9D4F3SYEjw9R9oRXx2rdJSil9FB5XUVPcvz
         6va+q3CMF4gvUzXAHWPUbZ/YPrUAIhf7dunxs9SSk5Pu5cd15KkXNjvXeQiOIMigGXzl
         Xbz3Y4WXHmkK22gayNEbIX5Ml3/MuXXp0YraotsjYKwArZ5aeAEYGxjC+ubJnRIxhDEZ
         Mf3nOgguXsmIOpDckPgJsOp8zpyvK7WSB4ruYyoZfUEjV/T57YzDJmaQTlrpvJWhxcmz
         RrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718386344; x=1718991144;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHcGiX8UBCwxh//a18tmbSzvIIZ91QoZrb+Pr6rgKAk=;
        b=P0W6/bYYwz5Cit3HLByZoOpFyvCijplRvm8VcW7T1w34yTf17ap3kn9+KWta10eYVn
         PVAIWyd4xjZwEig9QWgMEY4Fz9PrBT0qo3lWdrSWaKSkx4ZCwp53/Ct/JVDsIiOwaMR1
         vxLEMZao0FBQ1XFTblBdk0apgjnD3mw0pDxlMb1YzR+NH7h0FaCvMc9rLOZkSlArbV5I
         TqwIJ2ntyZ93xyn3UcW6RpyFae8OLFchjyIUzMOVVrKVgr+mW+ofEG1mMHRMHrtW/3Iw
         Fm5EVd6kopWOxJhIEL447A9PQbxg8QKT+znktcKMgLVycdoK+qnqtJao6pFGF8TZ2nJE
         6tIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRyaKGlymDvPUARHKpNwZX9vHLLj051ATbtHAj4egNL+J4HbmUFsZmntxQZe4xXXbUOftKtE3EvmJsXsMdW0c3WNS1WCKFrSWvXgexG4c=
X-Gm-Message-State: AOJu0Yxdu8jeJS+57t8Rx9U6mAjpn5hI7b6XJPsNMHHHM9vvb12/Ppcw
	MYmjHfOLYt1aBVj6XDon0aOXRrRtmrKpo6G2wVP6PNzJKJwIfdi8TaVDjHpeQBc=
X-Google-Smtp-Source: AGHT+IHsxqX+vfK6OLdZouSmAaBnwPbFYWG7SuDtV+LLd1ZQ2QpbCa6D9qdoNvt9IQdsKez/NQ86Ww==
X-Received: by 2002:a5d:6da6:0:b0:360:83cd:ea2d with SMTP id ffacd0b85a97d-36083cded29mr2374785f8f.24.1718386344226;
        Fri, 14 Jun 2024 10:32:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360751152d9sm5045341f8f.116.2024.06.14.10.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:32:23 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:32:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix potential NULL dereference
Message-ID: <4428a7ab-eb67-4f0e-992f-35577ea2b564@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In this condition if "sband" is NULL then it leads to a NULL dereference
on the next line when it does "idx -= sband->n_channels;".

The condition can just be deleted, because if "sband" is NULL or the
"idx" is out of bounds, then the correct thing is to at this point is to
return -ENOENT.  There are no additional sbands available to try.

Fixes: 70e3be54bbdd ("wifi: ath12k: fix survey dump collection in 6 GHz")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 509c02bffdae..e5456383dabd 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8314,11 +8314,6 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 	if (!sband)
 		sband = hw->wiphy->bands[NL80211_BAND_6GHZ];
-	if (!sband || idx >= sband->n_channels) {
-		idx -= sband->n_channels;
-		sband = NULL;
-	}
-
 	if (!sband || idx >= sband->n_channels)
 		return -ENOENT;
 
-- 
2.43.0


