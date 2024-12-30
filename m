Return-Path: <linux-wireless+bounces-16910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F099FEA60
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531E51882993
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADAD19ADA2;
	Mon, 30 Dec 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="hGnzdghx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C267198A17
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587733; cv=none; b=Lggz51TJFN9UbzDZ5n0vhjGBqAHeKx03WTphxyrH4Dpe2eSYNdR7bwzAA6X+WZxTL6ZXnSet7rtEfWIJXDEPiaHXo9e85f6JjehegPMg6y99ktXZDm+b2NN8n2XaqqDQaFN7rhVE5IElk4CRGFYYzcBRWCvnNMv+HUJXglJnW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587733; c=relaxed/simple;
	bh=s9oWaN1ZwFpeFdXj4TqDX4ZwKkr1eYYMKAZq3tSENfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnZd3vNwU565mCqcvFR09T0C0PKfOeGsZywP02gTZzC+i8VWqLbe8XJAvEcgF/QyAN75blgReFhuJ55K+r8I842kBlFKkDr0XyOtygSuM9v4Qk1a27Dsqw2WFP3YKGAESpT0BHwDZbdRy6emSX3O20JW0hepj5nxeaEEGVwIdJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=hGnzdghx; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LorxDXPTWmlSCLtd+TwpWSDm1Rw+g2ZJWZl35g40vew=; b=hGnzdghxTvCIlRSF4MrWJ6KdaX
	Zujt6tOYFUVf8yeWwJRdzHqMZjFOxmiRsSlllWN9J70XQCj47LR+3VcSTCKkYvy+wbaFhdTfPW0AP
	nMjOY66xRbFDYce4Rpqhcc63x2aos4HEmzVdyIx6vuXHoZd47wWUGc51d/hvNKIcQhv4=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeU-00GKzc-0j
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:10 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 06/14] wifi: mt76: mt7915: reduce the number of command retries
Date: Mon, 30 Dec 2024 20:41:54 +0100
Message-ID: <20241230194202.95065-6-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230194202.95065-1-nbd@nbd.name>
References: <20241230194202.95065-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The need to retry a command is really uncommon. Reduce the retries to 1 to
speed up recovery from firmware issues.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 35af41b5bad6..6efa1c95e953 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2388,7 +2388,7 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 int mt7915_mcu_init(struct mt7915_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
-		.max_retry = 3,
+		.max_retry = 1,
 		.headroom = sizeof(struct mt76_connac2_mcu_txd),
 		.mcu_skb_prepare_msg = mt76_connac2_mcu_fill_message,
 		.mcu_skb_send_msg = mt7915_mcu_send_message,
-- 
2.47.1


