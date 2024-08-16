Return-Path: <linux-wireless+bounces-11563-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBAE95500D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C194B21C25
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EEE1C2334;
	Fri, 16 Aug 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ZxaxMxG8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8931BB698
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829740; cv=none; b=imjh94jGomrVZdZSnn+qztj0gfgCpdkg5xGWzrvq3jb+TJOsZMJnXOEeoBGuF8LcdIxJAY3hHJk2S3DZ+h98pmkbsao8Pv4/VRE8O07wNEFJaOx6/DKQKEt/GSm4No08M+CZvf+DlCZYhpbyQansPJl3o9fXXroUnY2N2onKFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829740; c=relaxed/simple;
	bh=eAGZUfbQyNZkQBNb13rY4QbFut6+PDwimdIQZjqx+s4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzxufBp3gOQmZXZuizRWOniMaxt3uY+4m0gv0nTC3piLXJifzIWlqKq/Hj0S+OZM1ncn9enPgUN5XflGOM60tK9RHUaofMjuXNK3pLI0Fd4jHO/xC6v8naeKH/sNgwO8ILDK63taULICYoxwQRghD8/Ctq0CtfHn14AK9UdiUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ZxaxMxG8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xosc3+PAhfX1bqJDTF2Zyq2nof/mVX+IuIQqC1psZ1w=; b=ZxaxMxG8MTWdNgsd1B3hiRqmcB
	5uNeccJkiUxKtC8IPgtN4JZE/utHU+v2w9JPKuAhyTEhkco2/rhJg36zOsZL/hXILJmM0cHdAuxWj
	G+agvfCzyYOunsmIoQpExTANGIOsC73LmHCHNZ1sbvwt2db8/vX8cYNU6sm6XMEMtVQs=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rQ-000ObE-1Z
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 03/16] wifi: mt76: mt7603: initialize chainmask
Date: Fri, 16 Aug 2024 19:35:16 +0200
Message-ID: <20240816173529.17873-3-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816173529.17873-1-nbd@nbd.name>
References: <20240816173529.17873-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes reported tx power by accounting for the combined output

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index d951cb81df83..f5a6b03bc61d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -181,6 +181,7 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
 	    is_mt7688(dev))
 		dev->mphy.antenna_mask = 1;
 
+	dev->mphy.chainmask = dev->mphy.antenna_mask;
 	mt76_eeprom_override(&dev->mphy);
 
 	return 0;
-- 
2.44.0


