Return-Path: <linux-wireless+bounces-13625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4609935D6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA47F284C12
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E61C173C;
	Mon,  7 Oct 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sbhAmwMG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5431D7E47;
	Mon,  7 Oct 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324955; cv=none; b=Eyp4l4aSsg6LTauyrIXt92fMvPZfcq0xF0yQkDbysNxP4L031iwMtjNbEvNgnRTEwjKb0rsUFLMdOK/TIvlqQA6TqCVNtpbVjHWuoAxazftsl5E0iZ+MOhiSXAzEZqiJ8Fdo/jV1UJaJOqz8xidL65/qST4DC8GjNYSd/27yf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324955; c=relaxed/simple;
	bh=coJnbKiPl1qAg88gsg8yHg7SmLV1fAWZKmebdKeCvV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoogbQqDFro1A2JPU9wHfFNfIimic2V331d6sw7EZjmJRU0dBksHHnhqus9UhEWOgNjwLXl+gFyLqXoEQlyAfiBZfoCC4HEJyAzkNCmZENbQ3pOU2lVVw264Qx2v+ZicE2ZFOC+RR8Np7YlOpa1xwCxRAk/xZ3HAkuKhhgL3XZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sbhAmwMG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C30AJ1ltqovF7s9EAys6NRtggm2c99WHROZQk/j4jEY=;
	t=1728324954; x=1729534554; b=sbhAmwMGdvyDamz42qq1PlQbCOSoa7ihvGlaB7LQz7NuIih
	62UWjPTSymyrPAOCR/dZYe8NQW+JWTpVLWoKMZZsK3TW34tHWm5okn9/swvGcHFKuD5fHmpZ+djFl
	RPfTJjEq+RtuqtBDeyPCBTkVFgb/KyxfxVJFpQEpKJ5yV5J3BPNT0zMQkn9HnYxA5pb/J1TjdNTxO
	AMnYfyEzLbbY7ZcrHrr6UxNjW1SLkteC+6tBW8SaPHeA5Zd+yCpVLf/mV8N9iZjZFiTvqdSxFt12/
	xTCaMifg95G18vPi/jkyrGwDVObwzTm88yCG0CcNhoZkAtJ7vS9AzGeW2J5m3oFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsGt-00000003TpG-0BQU;
	Mon, 07 Oct 2024 20:15:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/5] wifi: qtnfmac: don't include lib80211.h
Date: Mon,  7 Oct 2024 20:10:51 +0200
Message-ID: <20241007201545.d92615cbf659.I2dc8ea3df0760121dc202616bdf3942caf51b232@changeid>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007181545.63207-7-johannes@sipsolutions.net>
References: <20241007181545.63207-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This driver doesn't use it, and really can't, so don't
include lib80211.h.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/quantenna/qtnfmac/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wireless/quantenna/qtnfmac/core.h
index b204a24074ab..b375a4751580 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -13,7 +13,6 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <net/sock.h>
-#include <net/lib80211.h>
 #include <net/cfg80211.h>
 #include <linux/vmalloc.h>
 #include <linux/firmware.h>
-- 
2.46.2


