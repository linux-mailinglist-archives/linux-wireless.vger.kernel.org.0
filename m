Return-Path: <linux-wireless+bounces-29398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D757C90778
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 02:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECED13AA135
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53C42192F5;
	Fri, 28 Nov 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r2uPPnlp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B551B87EB;
	Fri, 28 Nov 2025 01:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764291850; cv=none; b=C0hX2jkAA7TLrtyFvKugXteONEYK98la8kRCsSgwqOD66sbDQNrmyb+wLYtdlNn7wUkWSmWe33GtwPWQhsxSlQOMbkqwm0uQKE87pau64j9GR/rHhV20BjML3FeGTtYPvd2iM+A2kc6Y0tgn5yv/UvDSFL3LWVrsfWicRPeVWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764291850; c=relaxed/simple;
	bh=u1DLrAR42ZJoXkwxYCBzYk/hzRVwcFcfj0mxEl0ya80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jc79krp+BzFsq44bc5te5B0mpAXvwS0mpBih7uyCEyQ3NcUNUr6GTMMYlI7JWm8XtZInGxB1EhB1seGk0uaw7K2cbZ29REuBaQfGaK5+G5K0y9/2gQk3Q6xcGHawmvwWrH+dz3HnUxOGmOBLvNPlAKgOc+VPdgm+YlnZ21v8PAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r2uPPnlp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UEOCDML1vgJ6otyKocfjE2Jgo6ba+jFiMjqlYw0GOP0=; b=r2uPPnlpjMQ8lwJadGjCByKLlt
	jrhkjKRCkJoiP3y16e2WLuMNt+s5khmMYlV+KKYOyLhswONkQAzh5HNbvj2qYGUq809om0UG4V2gY
	2n9F0lAEYDmIETyvqZ7gjvJhZMfobMax7Vr5uIGOhd6HZ6yFHZgnWh6DJnT0XJr7kJSPQHKV0Mgr9
	V/QUSA/3uphNHf7Fns6UoxXvNS5OR46TBQJ3xtXQjysM+AtWho9G8PhQu5Qo+YQFbPWW9j9A/oClF
	93+uKqdeHUm/sHo2LqeOrrz+WVVShnOn2iupje7tkXPtKhpKZqLsxrjZ0B/Ry+Mm/e1eZJ5Jn7ftd
	qMCLlCDw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOmu2-0000000HNDq-17oM;
	Fri, 28 Nov 2025 01:04:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH net-next] ath5k: debug.h: fix enum ath5k_debug_level kernel-doc
Date: Thu, 27 Nov 2025 17:04:01 -0800
Message-ID: <20251128010401.546506-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a description for ATH5K_DEBUG_ANI and delete the descriptions for
3 undefined enum descriptions to prevent these warnings:

Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Enum value
 'ATH5K_DEBUG_ANI' not described in enum 'ath5k_debug_level'
Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
 '%ATH5K_DEBUG_DUMP_RX' description in 'ath5k_debug_level'
Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
 '%ATH5K_DEBUG_DUMP_TX' description in 'ath5k_debug_level'
Warning: drivers/net/wireless/ath/ath5k/debug.h:111 Excess enum value
 '%ATH5K_DEBUG_TRACE' description in 'ath5k_debug_level'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/ath5k/debug.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- linux-next-20251127.orig/drivers/net/wireless/ath/ath5k/debug.h
+++ linux-next-20251127/drivers/net/wireless/ath/ath5k/debug.h
@@ -80,11 +80,9 @@ struct ath5k_dbg_info {
  * @ATH5K_DEBUG_CALIBRATE: periodic calibration
  * @ATH5K_DEBUG_TXPOWER: transmit power setting
  * @ATH5K_DEBUG_LED: led management
- * @ATH5K_DEBUG_DUMP_RX: print received skb content
- * @ATH5K_DEBUG_DUMP_TX: print transmit skb content
  * @ATH5K_DEBUG_DUMPBANDS: dump bands
  * @ATH5K_DEBUG_DMA: debug dma start/stop
- * @ATH5K_DEBUG_TRACE: trace function calls
+ * @ATH5K_DEBUG_ANI: debug Adaptive Noise Immunity
  * @ATH5K_DEBUG_DESC: descriptor setup
  * @ATH5K_DEBUG_ANY: show at any debug level
  *

