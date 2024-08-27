Return-Path: <linux-wireless+bounces-12062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2078960679
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6151F22287
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045B19D89D;
	Tue, 27 Aug 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Rdgh++zS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7E19DF9F
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752598; cv=none; b=EEQwN4czqXVtfBh4f90FaicgUykUT/ungfQrHipRjQRxp/o8No6M5inaS2IIDDu22UDkQW5pqOr0zUiym7wDlPjKgc0T8kwd1wTL0t+NDoAKIugDgRsAVHv2YxJ7ufNKqIQRjpIhaIn+IHWg/V/B9GuDWnVf+2QUaV3zblreDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752598; c=relaxed/simple;
	bh=oQ7nKYvdS3TohUMJiGO2Bqa/zxnTUelOrqKCyDJBqcw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry9KlA/8wyd/kkQNXPhGFNEqVU/S43qXqBcvJh+GGZOMoCvjrY6HE0s5468MtpZpi6wencq+1+sP0rQKsPhh6POXf8/EbqGEBIxQ0w5+1VhyJ/0qFs15hl4Ztt4EDiNUCeicPEVjWciwGMWWJe7XBxre7lZzp4RINW9LT18RmYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Rdgh++zS; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pe9gw76OPD4BBfjic+b4xAmwBh+y/ZJVAHKhekey8/M=; b=Rdgh++zSXZob4Tt3sGZknzGyZp
	kbl+k7nKdPIGDepB6fQ/hNJWd7Orzl0+OAVjPq8k+q95LHzlps1wJIERXavpFPwrKsee9Fja+4nVZ
	hw4+MeqyHpg/NiVdy76JAxJIgwsB3prjzdHxCXiBGBA6PAhoMdqMbMG5B5OIoVN0u+fo=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWm-004Ww8-0j
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:16 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 13/24] wifi: mt76: mt7915: set MT76_MCU_RESET early in mt7915_mac_full_reset
Date: Tue, 27 Aug 2024 11:30:00 +0200
Message-ID: <20240827093011.18621-13-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoids running into unnecessary timeouts waiting for MCU responses

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 8008ce3fa6c7..dcec27be5a40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1448,6 +1448,7 @@ mt7915_mac_full_reset(struct mt7915_dev *dev)
 
 	dev->recovery.hw_full_reset = true;
 
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	ieee80211_stop_queues(mt76_hw(dev));
 	if (ext_phy)
-- 
2.46.0


