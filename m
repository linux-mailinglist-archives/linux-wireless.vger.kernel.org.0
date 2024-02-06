Return-Path: <linux-wireless+bounces-3221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD284B5F9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A8AB240D9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D964130AC7;
	Tue,  6 Feb 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqOVmpyS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D831EA80
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224940; cv=none; b=QLl5/5SHHN0VEs5Yv6cJ6IxFq0Al1ImxF8XkjboGtN5lgUu2C/6ZguJxXBV71LNAxJ4QM0af1+Os+vshY338wkpqyJeWNOBnfcVcoCEOyPl8Ww4S0ask16l/vRgYFd+3t54UdxPcu6Im4OPk0TO5yWUlFmxF7Tuqxld8CT/p38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224940; c=relaxed/simple;
	bh=LMvw7ZapEqNLS9EY1kyMAKXzGH0Bt6b0N6T6aTC0hjY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UAlxMj8buplWUbCtAGJS83ZiDHNKAZG3ixnKttlb4PyH8GH9AsDtTanRbcp8IP8XOIOg2+vUZH2i9pjubLk4Lt/kzlR2bBoSnC4Yjinqil1fQ0p72tbptSZcwp9qH5yz/EocIUgsd6gNs+UPuHBfV5WFMjbOqNXmf+Hv/tHdD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GqOVmpyS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511490772f6so3077975e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Feb 2024 05:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707224936; x=1707829736; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpw7KIB9SDLyg6r6DS+MT6bxeqqIfgw6wlcljwHw/7Y=;
        b=GqOVmpySBNx2/SauyhOoO08nVrWpOuaQM17SYefrxN+TBOgSI1EtW+5sSLqOlV3KdA
         RCqAZbFFFWRamj8MFp42E3GGtQ59wLmLLPgsyaHnagOEEZnBH9UFuzFR33LiwEuaEu+s
         f7jNBdK2VGMa+lefDAKMbN4uEurRF6K9Y4sVaRzO30t3nHBA0clTTjnl/EqSNF0MyT5m
         ga23vBX3hlnQKJS7b/zQpoi+vIBl16CkmjTGgxCA7iEBZx7bBDXmN8gLab4/HHTGAFSu
         SF+0bNVHdBYg3S+I946if7xAOtM9EOhZfUrAON+N2jk+HCyJIF2TzZQ64RSWqmIIoeAR
         /TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224936; x=1707829736;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpw7KIB9SDLyg6r6DS+MT6bxeqqIfgw6wlcljwHw/7Y=;
        b=lHdDlJU3qOBZI94f5o9a7QYFIcY6X2zjY7rhUrSETRfCZ6Y39ebHuopqpgv2+t+WoO
         OSlsSpB7P3+WxWrV8tGIzOasP4GEY+Y5QqQZhswp3O/5jQiBJYZL0+zW4GD54Jpt1qra
         xAQrUj7LQZjsmt9QfUSkfE9RjmR3WgrgHnErkDzWE3vIOW3hjT6LlASXcxUwQaAtzQTB
         DSLPzGtWHzTgWbzd7VqkfxH1GUT60G47nkuzIX6Wixs3rcnpqxedVJxNcFv2mATzm8Oh
         JKPvpgdrtGkVLxf1iyxkRHXLvDcPg8zQB1N2b7KRl/6Yyu/kFBCDz6WF6pq0Zwyf8ZUX
         Ny6Q==
X-Gm-Message-State: AOJu0YyIgXlLoCc/ZYU/pSvHBAjsCgetc/IcrH31m12rfX5KOJPfUUG+
	pQvqOLcZ7LSfPqMVaAXBaVag0uQnAdzfAKVXQnE/DejxPJQsL+lyfIKVyWqUZY8=
X-Google-Smtp-Source: AGHT+IHz+S0/hLkcdwKUkrMXvDZrGQi09oEgaIQ9CQreZOYPgmTZ+FJGvUC2VV65gSeMtESWDNTYlQ==
X-Received: by 2002:a05:6512:49d:b0:511:5411:1144 with SMTP id v29-20020a056512049d00b0051154111144mr1522178lfq.14.1707224936479;
        Tue, 06 Feb 2024 05:08:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV1kdRpRxa7551jyeZut7+dRRqYEjtBtwSA2JsotGvkOvTm6mCBlGpnHpehfGak1mZE8mcq6/UMldKAZztANJBjUemhrvgacLFFxwSfYqBx6Y/KMPmETVR1yalhuTtKnaSVgZ/7i5M1rgVtbTCpB0B+hirV0Rqfdrgp1Qsgbkn2Q4mBtnYJYlSF//crcBlkW7qxDpLtAs4fJ28x+UclDVIsblNMk3jaPBZpgQuBvBm9IvjCxvi/ScA/YWUSQXMEMbS+SA4vqHgPFSdSvgAdD3LdffSCSma53K2/PyLdtnF7paoT4ndU387TkTqCnZ5N8+qlR4ZQxt90RL4I7ngPqTv6oeYDY3dY+Bv0uZpQGQY=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id cu16-20020a170906ba9000b00a2a61b9c166sm1135601ejd.33.2024.02.06.05.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:08:56 -0800 (PST)
Date: Tue, 6 Feb 2024 16:08:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Alon Giladi <alon.giladi@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: return negative -EINVAL instead of positive
 EINVAL
Message-ID: <f0391316-ab30-4664-96ac-03445ab2aeba@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The '-' character is missing in -EINVAL.

Fixes: fc7214c3c986 ("wifi: iwlwifi: read DSM functions from UEFI")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index fe6d0141cd5b..3c4c99eed110 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -679,7 +679,7 @@ int iwl_uefi_get_dsm(struct iwl_fw_runtime *fwrt, enum iwl_dsm_funcs func,
 		     u32 *value)
 {
 	struct uefi_cnv_var_general_cfg *data;
-	int ret = EINVAL;
+	int ret = -EINVAL;
 
 	/* Not supported function index */
 	if (func >= DSM_FUNC_NUM_FUNCS || func == 5)
-- 
2.43.0


