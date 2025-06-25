Return-Path: <linux-wireless+bounces-24487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC2AE87D9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43136802A6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE02652AF;
	Wed, 25 Jun 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWtTrG1k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42126B2AE
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864931; cv=none; b=YEBON/UGAE4/eId6+yC5BTj9HgTwThWxLr42tBRuSDZbZKzXYUoUDEsArJCAfKcVv1CO8/JznSz+7r1i7SitPYYXUcM/i0pNwOTbytzgN/mwzGAPfICko9tcwSspBaITECFDIvmsJ48pTwJfPDa/nyEL1N4+zdPYihqmpC7Ct00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864931; c=relaxed/simple;
	bh=T/WgMs1t2r6GpZznn+R0tQC4GQB69BnKFtR2iVgkMCQ=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=IiZNMjJYWtZ3L2ZxOmVAPRiALMsVx+FJDLu9dGKaWVXfnRTGj81dJn3XyN2hqlOXJDtFKpIBuLD7/q0Ycy2B60uRfmjSACnJ8NyPZYydL/54nBBJ30Jl3O41yC9ennYzqcQffLuvRR/oRPKS9gTF1sy9nvw848y2PUXiYjT0yg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWtTrG1k; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-40af40aef06so15908b6e.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864929; x=1751469729; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7oc7DM7sUp9Q2g/4DgfS/ixOMuqC8G8HAAnnDTr+l8=;
        b=NWtTrG1kG1OIjAVGUGyjezZPw/SzftN/pTuyohNdThOkXwWjoqtlxfZeZhaG4iEGYo
         Ff/VjDH1pue4OfewT3cg4PMhwGfJJ4WBo6oKyYrX9D7gxbaUXaBDbVufUuEpXFoKVZxM
         +qlfKUY7ymPNI6ekmnfZkV84ZLd/ZV5NgCIAnXg1cU7q89XzxuH5ptCYjrpuIWyj/NNb
         h2gSX50tAkxlFRx4jnhLglb8Es+/xQBerR9448rqpfrLrzJoxKM0kXwNn1KNwG0VlGgv
         MwKwkKyrND4DolM3yvxuHJWod4MzOlQwQf8ntSm3lralYY7wts18FnQs0W3oPi9kndY+
         XE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864929; x=1751469729;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7oc7DM7sUp9Q2g/4DgfS/ixOMuqC8G8HAAnnDTr+l8=;
        b=Bhjwpq8nLjfZWNqdIqH5n39Kv+PvyGHEyLUBZYEYLlt+9RV6lulCrQbZzJOkfDxXjC
         XR6/38w74pzoKfYUxpUvENVkg6SWz+ZiPOcQW7aWcPrdxXZI5zpfFSSsZ1TgmS1XdMUt
         Wi/1M9y6469B6d66EwqtBnA2EUiAqGZEBLDCpHCawWUqHmKJFyw2pqCd/tYk29ZgE5NG
         FrdPy1hYwKUlMPFHunOMLGuxDaflSgic/7uimLqaLZhIwCsc9ckLph909oo7KtnyxZbr
         I4JaagkpPJGQJhjfJg+O4r8Mmtm9FwJCTYUvRP6bBD7rk5GW90E0medV03OGRASqJ3g+
         uV8w==
X-Forwarded-Encrypted: i=1; AJvYcCXY/q5pKsWJTdNF8YpHpUWWYgPGM/58KCtXqvlRwEIuRCEdHx1HfCQUfx43OJ515pTltfcwx+gUKu3vf1Q3Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7R0yxgtftjmMMwhTdy3ubpdsBjIHo++LAXmEHvVSxxeigukKS
	3PjTgK6hQJpv+eWTb9q/cOgOpMxG5fbknFBPDYuUPW102nJsShbkWXC9M36wpCcG80s=
X-Gm-Gg: ASbGncvtSdpau6izg1Dx7NnnqBYOZfavZ64tN9VJPWurTKd7jSq7ABbn3gp9fRETOf9
	iveigZ83WQ53aRosWcYND9st+ICi4VLwy2RFryZINjOscgdR7V0pshPIoxqwm7e5Yit1A7iegZ0
	vASQ29lJc8rgrplRoayB6OqnOeFnnAIcv9CEty1g+6rA82EFt6zdjrXe1iDFB8mqg8L+t6zLpbW
	qdqzgyLP7Nj2F10kJrK4K1/3Sq1ABsEVXst6cxhn6W7InrwcmkkPPBr3Pew0OwrosofgKmBUuTp
	qMMq+RAkggk6ObJyPZzlSk/k1wRCMyCzQ/26ogO0wXT4uXdMUezSA/ZQhHmFE3HDR2OUTg==
X-Google-Smtp-Source: AGHT+IGcFvEYPWqui0Yt0xXJPtapA6f/IqOEU7Zk6imoU5KH28ETem8+ya9bGVLKj6PAPIC1zVqo4A==
X-Received: by 2002:a05:6808:1789:b0:407:77e9:a104 with SMTP id 5614622812f47-40b05762eb8mr3132816b6e.17.1750864928919;
        Wed, 25 Jun 2025 08:22:08 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6115b6d233bsm1689623eaf.16.2025.06.25.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:22:08 -0700 (PDT)
Message-ID: <685c1420.050a0220.ae80e.9bfa@mx.google.com>
X-Google-Original-Message-ID: <@sabinyo.mountain>
Date: Wed, 25 Jun 2025 10:22:07 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: pcie: unlock on error in
 iwl_trans_pcie_gen2_start_fw()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We need to call mutex_unlock(&trans_pcie->mutex) before returning on this
error path.

Fixes: aeee73e27f2d ("wifi: iwlwifi: pcie: move generation specific files to a folder")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index 0df8522ca410..8ff23f3931c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -546,8 +546,10 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	}
 
 	if (WARN_ON(trans->do_top_reset &&
-		    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC))
-		return -EINVAL;
+		    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* we need to wait later - set state */
 	if (trans->do_top_reset)
-- 
2.47.2


