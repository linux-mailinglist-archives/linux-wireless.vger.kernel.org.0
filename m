Return-Path: <linux-wireless+bounces-7481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D55B8C2857
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 17:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D41C23415
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CCE172BDC;
	Fri, 10 May 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSofYpy8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDB171E6A
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715356759; cv=none; b=Byg56iNXvVewIsZydMFaGSWPLrb/KrVyRdCIVHf/58Tilblf1eApqlTCJyMk1BxDJLxfi4BoZmr84HPDfHjDeFR7dGHJptubiTzyghUV5ZR1sp4pSEDMTko6HQi1uLH7U8WoNswtgW/27yi2lp9lUgQf36gy6VgrIp60VD0zK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715356759; c=relaxed/simple;
	bh=J+92hXnaFjj8CDjvSEIof2zLpu6lXiMuInC1wXs3yNw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MQ5Qp6woTl5993GwtTzGwSZHE9sawDOF/Rj1nH33XZFp7X5NnUysT4c6GvTQKoj/d47KRLTwqfpBQmabpoZpiXO6XHVibri77jTF3KTGWc4JWn9jPj9w6OGDXj4ahjjwSxFElzndbGTkLh+d3wh+dJqigKavdXn9eC9dQEwDeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PSofYpy8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51ffff16400so3680949e87.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715356755; x=1715961555; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaC1FX9IaWOSYR6DDBjH2nZIpL4z+ve32+mPw2UdL5w=;
        b=PSofYpy8tvGE5zb3ymsZk9L69zp7ezzNQCuG7ObpKZfXzfTeldyQLCfGIuHwu9LhbK
         7coOwZ/LG5Xfuf9PE8DQOo5gjG8+YBYLR/XKYk8E+B3MbDsxGyRNWo+tgseMVlockNgw
         i2SjRnv/tU69R7Kv+s7OBUJhwQaaBjxYDM/07SR15Tp+6PevlTqsEb0RTNfNY7joTAdP
         EVF62fbV2Xnq36R6V9P1bnwgU+D50J+/9RLpn/h/KGZQ+mik1wWRRl107Jm9q2ir/xcc
         4R3jEnWP6ehvfh6JgXLdnzvIijP3DBmU/+uUJZ+H/HZV+QoNB6+dXe7d3JL+GVI1+P4Q
         YsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715356755; x=1715961555;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaC1FX9IaWOSYR6DDBjH2nZIpL4z+ve32+mPw2UdL5w=;
        b=Lmo624KA+D5xEYdHRZshBrH1DKOc79JLmzatk7jBFcx7J/FqnVkKMMWTTgRtclO0Vb
         33tFeIb02glqnatBNSfCP12zC3NBy3D4YzeVkSpqQ3NbtP/v4n4ZqMOSeRVPGfcbvE9A
         3zrlEQB4U8xmiaLQlNCJ60+K/v3SmvJ7Gd4cNNN9ou5bkUvs1DSCz5CSWY/3wFvxVYKv
         6Kl+P4KbH4mUI9dYPwoqJTXjy88BlM1TVYGjac5xXGyFiKs+Gb2aJ0+gOfAR2zsIskoA
         TzOtIM37eZak5FOkPgC/9/4NLXUQ8Rg1WdUfYBTGw04aY7PfCcKFntc7yj04mpykaKa7
         6VnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCEV29gYqXX83kmsZYIIdtjlBJOKvKv+yoL0ZNsxVZh3AkASnc67NOBxlcYhnxc128vmcxXKG37OYegMuSYJ7/ZAzwed8jt/47aBODEX4=
X-Gm-Message-State: AOJu0YwJ3MsmqLOn7BZiKZIL45/ix6ziNrsh1fPcOw18ZPzTfHasS0Dd
	P5dCVtYMVDa5SmghZfJyDrwE+cEsZjoSc6PdPgs+PaNiqAVPvkk3HwBbzVP54C4=
X-Google-Smtp-Source: AGHT+IEM5bdqaeGgx8w3nkjhWpAJfZyjTMZG+ycwOpy9UjbCyzEqZdbDt8dL5b4mlC40ps7Lrh/MMg==
X-Received: by 2002:a05:6512:4003:b0:522:221:d19d with SMTP id 2adb3069b0e04-5220fd7bfccmr3137814e87.15.1715356755115;
        Fri, 10 May 2024 08:59:15 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b0125bsm199199366b.143.2024.05.10.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:59:14 -0700 (PDT)
Date: Fri, 10 May 2024 18:59:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Avraham Stern <avraham.stern@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mvm: fix uninitialized variables in debugfs
 code
Message-ID: <466baaa2-4996-4193-b681-d847d181a961@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The sscanf() function doesn't return negatives, it returns the number
of the number of input items successfully matched.  Fix the error
checking to avoid some uninitialized variable bugs.

Fixes: e5bf75dc46e1 ("wifi: iwlwifi: mvm: add a debugfs for (un)blocking EMLSR")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 17c97dfbc62a..88e78c798017 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -762,11 +762,9 @@ static ssize_t iwl_dbgfs_esr_disable_reason_write(struct ieee80211_vif *vif,
 	struct iwl_mvm *mvm = mvmvif->mvm;
 	u32 reason;
 	u8 block;
-	int ret;
 
-	ret = sscanf(buf, "%u %hhu", &reason, &block);
-	if (ret < 0)
-		return ret;
+	if (sscanf(buf, "%u %hhu", &reason, &block) != 2)
+		return -EINVAL;
 
 	if (hweight16(reason) != 1 || !(reason & IWL_MVM_BLOCK_ESR_REASONS))
 		return -EINVAL;
-- 
2.43.0


