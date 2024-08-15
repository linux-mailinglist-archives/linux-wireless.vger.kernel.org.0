Return-Path: <linux-wireless+bounces-11482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D3952D81
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 13:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303C42832A1
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E501714CE;
	Thu, 15 Aug 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuDeUI+P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D41714AA
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721376; cv=none; b=HIvBcAEUWneuY/iv5V75WIe2LiIRwWlbQi2JZEJEctZbf/2VMEP+/ilhoS2/MY325vW76d9aIB9knLSjAlFz2ShxxVKiKEc0h4LPadXQF0yaglqHQCB0vuDbmkVgqvPPoUKxoxoqSRdKT6zDCtHzjVggdVUlqlu07n4dRbfAn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721376; c=relaxed/simple;
	bh=sr7j5UxC4QXw2ypOBkx4S07fGjjwP6NxkB/0YC95P0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l5hEGVq/tzb9G80fHUDlYwqaUKZS/DiLwte4okY/I6M+YASHhFcm23nfpOxmWUehTz+kPGsqy9je1WiIJucoCchvq/xJITLKbQS91xL4CEYhebwN1X2O6Ddtv2HwE5Wf7GswgeY8afTnc55dI2Z0L6RSfqYlAKfytg2SHTXRJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GuDeUI+P; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so1057033a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723721371; x=1724326171; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JTAEGW3OQZ1pLkxp14RqDDaQpOm9zbUm4HJdeRXWAT0=;
        b=GuDeUI+PD6t2GHTXyS9clkXdr5c+3iuodVEPzDFGaNMIQdJaAH7SSLCdokYM0mHziE
         f3xmzmjqbbHnbbz8j17h/+xSxLFWVn1wyieDUbEXydIKsg8Lq6jeSQfZbHupzRHfpJ+a
         cyvqAetO1Yz3psYN9MaRJg3vuduXx2+ybclb1jwo5gy4WkQ2Hxt/slrWBeXTnjZJ1Tq7
         Q3vMmV2c1rhESMyQClBAU+RpS0ZqFAhcijQiTams4dTPAy5zl+gHgREr4/jZgm8JyASy
         SNMzEJ+Ey5Q5vi2/q/DXg0/ktaNck4x/wmhFIYMEICgWDqSb6UXaWX0HlbsEaGYIL9Yd
         MohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721371; x=1724326171;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTAEGW3OQZ1pLkxp14RqDDaQpOm9zbUm4HJdeRXWAT0=;
        b=FgaJDs4PDe9WtamnLag+qhX1qMa6Z9MQP8lekqgC2ungaIoGxZMHJhIlpZsk+mDVf9
         lxGMoKNPcIjKn3R/8ctz+Y8YCNEqnEVMdGLD8wSG+QNIiJpZ/mZjJKsPAjntFmUtVlbr
         TxUFgzkBGHKBxhOAOKsXiU0gzedJW7PxHDenaZWy5gYJcilCs+VpwowaQX2/E20JEN8R
         1F/14WDCKp1Aoi1CBbv32gl7rgwO0inAXznWziySbIrKcogELXww38n/FZelYt1gfsDo
         2pU0h4rqKey02KaQ4mx+7EbgWRnr+EhDdkBk28H5d4EYyfKIifrttTvzp7OLKiN4n2u3
         s4/A==
X-Forwarded-Encrypted: i=1; AJvYcCVMBohKhpxZI1sh2g0JQ30jPvI9y9aScqJc74Cpgh5PVmdEuuAmuEbDmWg6nov/05SLlE94av21IJcsZQgDA+s7aQ8ZNtZP6o1MzxGoYfE=
X-Gm-Message-State: AOJu0YxwSynYESrPQ5ZZmDmHs4ezjE5g/cEhVTOvZn+tGbOmuu3dtDWk
	VyVa/AABN6VUl48JMknNGpybZba0+qs2yIp96emjMuiAuhnoKq+4hLpUfMYZtbo=
X-Google-Smtp-Source: AGHT+IH9/KXxc6zq/fnEB4afFMropsvLrpcMCVRcWcQLh3uIT597PZfVNI/aJoEfYCz472UFpsw6NQ==
X-Received: by 2002:a17:907:e9e:b0:a77:c330:ad9d with SMTP id a640c23a62f3a-a836709548emr424568866b.61.1723721371552;
        Thu, 15 Aug 2024 04:29:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839356e2sm87568266b.105.2024.08.15.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:29:31 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:29:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rafael Beims <rafael.beims@toradex.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: Fix uninitialized variable in
 mwifiex_cfg80211_authenticate()
Message-ID: <d7d043b2-95d5-4e1d-b340-5d7330053ac6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that:

    drivers/net/wireless/marvell/mwifiex/cfg80211.c:4408 mwifiex_cfg80211_authenticate()
    error: uninitialized symbol 'varptr'.

It's a check for NULL, but "varptr" is either non-NULL or uninitialized.
Initialize it to NULL.

Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 722ead51e912..7505de304052 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4284,7 +4284,7 @@ mwifiex_cfg80211_authenticate(struct wiphy *wiphy,
 	struct mwifiex_txinfo *tx_info;
 	u32 tx_control = 0, pkt_type = PKT_TYPE_MGMT;
 	u8 trans = 1, status_code = 0;
-	u8 *varptr;
+	u8 *varptr = NULL;
 
 	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP) {
 		mwifiex_dbg(priv->adapter, ERROR, "Interface role is AP\n");
-- 
2.43.0


