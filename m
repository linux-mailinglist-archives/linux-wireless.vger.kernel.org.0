Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26246CF48
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 09:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhLHIqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 03:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLHIqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 03:46:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C9C061574
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 00:43:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d24so2829599wra.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Dec 2021 00:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/5TWII74Tif63PQUy1/H7f4Fm20f0g+NQNBB3rpoQ9w=;
        b=UiMls9K6+UhDetZA3NrmUhsvIE4kMO+8cbxvL9sPa/Z/Nl85HPt16GD9TYSpKZXdVf
         YytLuJWXjTyU/BpmC4mbGPRZX+4jFs20QkApHQvJyhqylm6ityASGjk8fvsAJa8U0NNk
         CrLYPK2b1LsXQfsgD46YMpZgwpISEgVQK7FRoS+VvY4badNrqsQDFmSHB9YoBKxdvCSc
         l21WC5ACPz4iCl7JeoNDCG+QAS77kqNXuar7qvO5UsbYZtNOQnF+txKKN3RSZ+7DJNVt
         8fq9OQ2Ub0OQq2zWvZLhpusVCZgbdGSHEj4RfKlSUQjp3EhKSbRa7MBT1NclU/UvTv7i
         iiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/5TWII74Tif63PQUy1/H7f4Fm20f0g+NQNBB3rpoQ9w=;
        b=nPScK8pD86wkPsOWgXAjhJGJbmkOwaxF7FaKF6RPhfPFyZ2w1lMtmglx3fAwUP0Hlz
         mWvEEZYMdpIopfz1HkNZg6FNKU66lJtoSC66FJVgfPtp1XkvEY5cfBcypL90K+fOrMj8
         2cJaqDDHnpDgliyQejiDhp64LqGElRH6OvD1lMpC1D5UoI32Foep3xaMaifEaDCSppst
         93QgA6f8q/Q5Vz+2NIxyxTT1RF0r/3+boq0eCOnh3zoNfMWk3/95z8VW4DmkdPSHWNmD
         +f2UUuv0qi7OXgbsYUl9pZwyPX22fxldsTHxyBw0wNe0WzIeWAXaPIpkTGxrngHil/cV
         1lrA==
X-Gm-Message-State: AOAM531d7ZP/+BHULAma//lPW3TNCL38zpDcMt4SRFPCPNu6y4ChUWWy
        h6eqF10GhWsGipwv690lNKbo5A==
X-Google-Smtp-Source: ABdhPJwE9LBxz9oAGuJK+hI8M/T4q+suEUkaXMwDMAYYGEJkOryaVbXs+eODngtuJYC54ShFLykQMg==
X-Received: by 2002:a5d:6d4c:: with SMTP id k12mr57497743wri.511.1638952981802;
        Wed, 08 Dec 2021 00:43:01 -0800 (PST)
Received: from localhost.localdomain ([88.160.176.23])
        by smtp.gmail.com with ESMTPSA id j17sm2409867wmq.41.2021.12.08.00.43.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 00:43:01 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] brcmfmac: Fix incorrect type assignments for keep-alive
Date:   Wed,  8 Dec 2021 09:55:08 +0100
Message-Id: <1638953708-29192-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cpu_to_le16 has been used for all keep-alive fields, but 'perdio_msec'
is a 32-bit field and 'keep_alive_id' a 8-bit one. Fix that.

Fixes: 7a6cfe28ae3e ("brcmfmac:  Configure keep-alive packet on suspend")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 1679361..ba52318 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3908,9 +3908,9 @@ static int brcmf_keepalive_start(struct brcmf_if *ifp, unsigned int interval)
 
 	/* Configure Null function/data keepalive */
 	kalive.version = cpu_to_le16(1);
-	kalive.period_msec = cpu_to_le16(interval * MSEC_PER_SEC);
+	kalive.period_msec = cpu_to_le32(interval * MSEC_PER_SEC);
 	kalive.len_bytes = cpu_to_le16(0);
-	kalive.keep_alive_id = cpu_to_le16(0);
+	kalive.keep_alive_id = 0;
 
 	ret = brcmf_fil_iovar_data_set(ifp, "mkeep_alive", &kalive, sizeof(kalive));
 	if (ret)
-- 
2.7.4

