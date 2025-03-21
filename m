Return-Path: <linux-wireless+bounces-20673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF02A6BD2C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 15:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED90171B20
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58176224B0B;
	Fri, 21 Mar 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzU+Lroi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342721CFF6
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567767; cv=none; b=Zcjc3svP2FnQw3clQlP4k8rpMdkqP2bMZW8/nl58pzonaD7QNfEkFHOv/zwK/GGiJ2yAgzylw3w0qqWGKmA3kw070J4IX6aOsS5DasEzKIMaRe2G0Nq5TIZWiN6IKja1td9lON2+TWO+wuDcZ2kwWyd0hJUslTQSS8TMF8QOW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567767; c=relaxed/simple;
	bh=3Jt22z68KyWgHvqCCZSGvvKTcyUcRvUGovF1IdxZ7xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aIRDLnyg4MVeqR+IK7DbGl53SDnlINolCapv2LfsxZuG35DO3LaD+iNDm2y4AYcAZEwO5O8F7pd+aE4nl4GrlUtWnLXiZ7Y7IdpdrPNOOBWNTjhW97dCvJ+EoeQrtBitcIeC6xIIQjLLR26s1GGl5xvpEchRph0jXpBijr+EJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jzU+Lroi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913fdd003bso1114965f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567763; x=1743172563; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3TRMcYPovdCcpxNpOwTnOH/MV3MA+4jBX9Ey4iK5so=;
        b=jzU+LroivtyPIYTpsTInSmhx5KVKMRWTGfqT57ULYQI7kUHv51iwhpoFMLMoL+0NJp
         ZtXtrYSlPO4lbDG7V6aw1nLJA9RHZ4KrHyvZd2j57S9ySAMrZfLjYitp8th8x8vNZC3y
         2CjzEGPwe2e5F7EklPNSYsENQjhNEWJ1W8mhZ4vJw1a/2ZTf1/jifEC/o+IhdrGUvULX
         ViH02x35qqocIPT4O954ln0J90RmtXr7GaJ1kRVbi7lKz7WdOdMiMHT3qwYoY+IpR/RQ
         OKxgQn9ftLIRG7K4u2oyCT6jr2ciOKK7sWvpHq8t83P/uTScAwX1CdSQjscinwl5A2EF
         N1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567763; x=1743172563;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3TRMcYPovdCcpxNpOwTnOH/MV3MA+4jBX9Ey4iK5so=;
        b=lbOzxKu35uwP0jDhaXSqVgLZaHBI6nlTK00px04IxGBcvPMJdf5iA+1OFVdlMUpLaE
         mSCHFweqznICzv6VrRsdK6GRgpr3SlrK37jJBAlfBCMgUqHmXiOuRYnFzLY+UJMqCV5t
         bPRKV1/55Vh1WL7ZNv6OL0Aa/SkHPSUqkos/FO5FhPuBj/kDYu1FM7LpRZDZZoKJhBxv
         YDhEoKpo3PBPgQqS2l+MFSnxuZrLeAvEJ6ldAVDQQlHQKNs1V7aILCMpCbRrkK7Z2/Q6
         ElBxA2HHZ9DO7M7fpGa0mI8NRSSC8CcRmhNxSX6QyuZ7Auk20JKVby0D+Xi81z+XdOvf
         ct7w==
X-Forwarded-Encrypted: i=1; AJvYcCVoI4/+AWwVksiUSM+JMLhjZJ/mqkbaIIab0YHn+GZjH3wRZ7z5LTQPr0TsW3e4OE307SHZ2FmOOdOi1jGIbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yM+yEpT5EvpzIaHioRXMUkhpf88lmrz6XS476/mFALkDUmNd
	BAK3uphi/ra6v5QEJZ+9YmtHWf1Hi653zcN5cLsdDLi3lzzOE+G9s6w34dG6pEL9x0YM0p3ETmp
	J
X-Gm-Gg: ASbGncsfrmIZ9Yh92DzJzgcC8yEdevMpXCF5hEBZ8ouqgvs2H8DtiWpH0XJbYcoHKBA
	RHL4+nW7u6rH7UQc+pY0OqCGb2YtvcpvSXJDq+02Sy+heC5plvxq7+ACtpbEafUiJe31/JvRGYJ
	OdHDYKJ0GnMOVUVkpCvFpEctpX87nYqHDdk2/TCwB8SREV9jrIvsalZJ0FBtZXDTK3e6WNrtgOH
	MEzgBhef7AWukHmxxgoB8IsU9fEIhb1+iQiYzzbxJbDApjZBFiSNac7ajcShIxlSW3cDF8j6nKt
	xAV0wc0OCJO6TiCLJGHxOUe5hZpAKrOUmEGHcCLIRgZL62F7sQ==
X-Google-Smtp-Source: AGHT+IHhiGmfwux5UkjuIUqxq9oi+dkK+mUOCpGIZ4do/XrfF2IaNbNhOgkz66lIuN/uqIj/iyqgng==
X-Received: by 2002:a05:6000:1cc9:b0:391:32d5:157b with SMTP id ffacd0b85a97d-3997955cc0amr5526052f8f.12.1742567762989;
        Fri, 21 Mar 2025 07:36:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f55721sm79742765e9.20.2025.03.21.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:36:02 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:36:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: iwlwifi: mld: silence uninitialized variable
 warning
Message-ID: <add9c9e2-3b44-4e0a-a4aa-7326f6425baf@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "resp_len" isn't initliazed if iwl_dhc_resp_data() fails.

Fixes: b611cf6b57a8 ("wifi: iwlwifi: mld: add support for DHC_TOOLS_UMAC_GET_TAS_STATUS command")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 453ce2ba39d1..89d95e9b4f30 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -396,8 +396,8 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct iwl_mld *mld, char *buf,
 		.data[0] = &cmd,
 	};
 	struct iwl_dhc_tas_status_resp *resp = NULL;
+	u32 resp_len = 0;
 	ssize_t pos = 0;
-	u32 resp_len;
 	u32 status;
 	int ret;
 
-- 
2.47.2


