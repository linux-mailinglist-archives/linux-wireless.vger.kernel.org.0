Return-Path: <linux-wireless+bounces-10580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D393E34E
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 03:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F15C2834E5
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086121AB52B;
	Sun, 28 Jul 2024 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5U8muym"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ED61AB521;
	Sun, 28 Jul 2024 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128195; cv=none; b=XFjTf8dR/zbuj0gPmiMgt2AtDlGJ6ueFg7uo5N0wyOH76aRnehRu5DvHVoArLK1jaepNwiI8kuYWUCa2IfmobaYOrsPDYop+qDm6Zm7eKr0qjuyFZQQG2Owg9KWaNeJWog80Xrf1iEOZhZLKw0sl3DA/RZ0rceJonApZCcDRi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128195; c=relaxed/simple;
	bh=ywRTZl9PSRinZJWnNkVu+f7s6qrRzdCjNfRDYMSirAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAjbgB1PqC0RL7Pqy31h6w3svggA/gXw8veIJ4m74emDCmRVAvGJn44rD1YoB4P3OdO0rK5iw2HvN1DpqpvpKEe4fRoejseVJwu3Rx355csz4WGODbc0peO5MYneUEm9g4JMzTyZScPXvKOEGR8rqKcwWl/SWMt0kR6g32DsbWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5U8muym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB131C4AF07;
	Sun, 28 Jul 2024 00:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128195;
	bh=ywRTZl9PSRinZJWnNkVu+f7s6qrRzdCjNfRDYMSirAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5U8muymRSS++PC8viUQvv3ZWiPnOYJ0koq4lpYehSNCxOTFiiNf3E6nEimFL/JOP
	 W9bcey9NSim2Y4nsoHWIvfRsm776xMUjQV9Zj4dZpffTHRh65IqgL2vELHJV5jpBrx
	 AzscaUcemmwF6PlQCDgqscRc8wrJyWbPduDF85u7Axj7kIZE8lOGFIaif33sHk0HC5
	 ygncyrgVYSJdZDTgi3tjFEFomGRFYrBoYgU7axlT7jFjfR0ROeb+eG7YY3gqsMUw9k
	 UrPUibxbfp9ikAV38838Z2Z+aY8R9XKthXLABKEG19EJw3TW8cZliRzzLdhOKx89xu
	 rvmvs04liCFhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/6] wifi: nl80211: don't give key data to userspace
Date: Sat, 27 Jul 2024 20:56:18 -0400
Message-ID: <20240728005622.1736526-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005622.1736526-1-sashal@kernel.org>
References: <20240728005622.1736526-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a7e5793035792cc46a1a4b0a783655ffa897dfe9 ]

When a key is requested by userspace, there's really no need
to include the key data, the sequence counter is really what
userspace needs in this case. The fact that it's included is
just a historic quirk.

Remove the key data.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240627104411.b6a4f097e4ea.I7e6cc976cb9e8a80ef25a3351330f313373b4578@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0d15dd68565cb..e85e8f7b48f92 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3723,10 +3723,7 @@ static void get_key_callback(void *c, struct key_params *params)
 	struct nlattr *key;
 	struct get_key_cookie *cookie = c;
 
-	if ((params->key &&
-	     nla_put(cookie->msg, NL80211_ATTR_KEY_DATA,
-		     params->key_len, params->key)) ||
-	    (params->seq &&
+	if ((params->seq &&
 	     nla_put(cookie->msg, NL80211_ATTR_KEY_SEQ,
 		     params->seq_len, params->seq)) ||
 	    (params->cipher &&
@@ -3738,10 +3735,7 @@ static void get_key_callback(void *c, struct key_params *params)
 	if (!key)
 		goto nla_put_failure;
 
-	if ((params->key &&
-	     nla_put(cookie->msg, NL80211_KEY_DATA,
-		     params->key_len, params->key)) ||
-	    (params->seq &&
+	if ((params->seq &&
 	     nla_put(cookie->msg, NL80211_KEY_SEQ,
 		     params->seq_len, params->seq)) ||
 	    (params->cipher &&
-- 
2.43.0


