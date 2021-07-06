Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA83BD0CF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 13:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhGFLg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 07:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237556AbhGFLgO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 07:36:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F218761F74;
        Tue,  6 Jul 2021 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570918;
        bh=q40AHm9I5Lk5DXFmVPqQqxkyiDbwGY8e1r7ys0fjt1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbpmzBiHorE7XIKRDfgtDu1WYSdNeZhrMWBIR+dt13IU2j7XBOVcxNAnHiPago4/t
         G3dnzo6HHkONgwA/v5COUt1hfOeMY14El7+C7kpRCO6YsEYJpt9dS7l3QCaP/Jp5o7
         Y0PhXGJIOqLlJKFad1SSAazw8Lj0aN0ykA8caOuRAGmzL9WFeqhK98/z4ylVRZbqr2
         CS2XX75cJzu0Feo/fw7MgQmWEBS2OcLmQpqvjmqZiSjqX6AEcBmiHz3ensIEyOR5jN
         UBXoT3Il8gg/6dK8yRw24sXxzECpUQEekV0MldvLBIbAvftsoOhu4vfDAxqFILZYw8
         IeXjIPf/0/qgg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 39/45] wireless: wext-spy: Fix out-of-bounds warning
Date:   Tue,  6 Jul 2021 07:27:43 -0400
Message-Id: <20210706112749.2065541-39-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112749.2065541-1-sashal@kernel.org>
References: <20210706112749.2065541-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit e93bdd78406da9ed01554c51e38b2a02c8ef8025 ]

Fix the following out-of-bounds warning:

net/wireless/wext-spy.c:178:2: warning: 'memcpy' offset [25, 28] from the object at 'threshold' is out of the bounds of referenced subobject 'low' with type 'struct iw_quality' at offset 20 [-Warray-bounds]

The problem is that the original code is trying to copy data into a
couple of struct members adjacent to each other in a single call to
memcpy(). This causes a legitimate compiler warning because memcpy()
overruns the length of &threshold.low and &spydata->spy_thr_low. As
these are just a couple of struct members, fix this by using direct
assignments, instead of memcpy().

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/109
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210422200032.GA168995@embeddedor
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/wext-spy.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/wireless/wext-spy.c b/net/wireless/wext-spy.c
index 33bef22e44e9..b379a0371653 100644
--- a/net/wireless/wext-spy.c
+++ b/net/wireless/wext-spy.c
@@ -120,8 +120,8 @@ int iw_handler_set_thrspy(struct net_device *	dev,
 		return -EOPNOTSUPP;
 
 	/* Just do it */
-	memcpy(&(spydata->spy_thr_low), &(threshold->low),
-	       2 * sizeof(struct iw_quality));
+	spydata->spy_thr_low = threshold->low;
+	spydata->spy_thr_high = threshold->high;
 
 	/* Clear flag */
 	memset(spydata->spy_thr_under, '\0', sizeof(spydata->spy_thr_under));
@@ -147,8 +147,8 @@ int iw_handler_get_thrspy(struct net_device *	dev,
 		return -EOPNOTSUPP;
 
 	/* Just do it */
-	memcpy(&(threshold->low), &(spydata->spy_thr_low),
-	       2 * sizeof(struct iw_quality));
+	threshold->low = spydata->spy_thr_low;
+	threshold->high = spydata->spy_thr_high;
 
 	return 0;
 }
@@ -173,10 +173,10 @@ static void iw_send_thrspy_event(struct net_device *	dev,
 	memcpy(threshold.addr.sa_data, address, ETH_ALEN);
 	threshold.addr.sa_family = ARPHRD_ETHER;
 	/* Copy stats */
-	memcpy(&(threshold.qual), wstats, sizeof(struct iw_quality));
+	threshold.qual = *wstats;
 	/* Copy also thresholds */
-	memcpy(&(threshold.low), &(spydata->spy_thr_low),
-	       2 * sizeof(struct iw_quality));
+	threshold.low = spydata->spy_thr_low;
+	threshold.high = spydata->spy_thr_high;
 
 	/* Send event to user space */
 	wireless_send_event(dev, SIOCGIWTHRSPY, &wrqu, (char *) &threshold);
-- 
2.30.2

