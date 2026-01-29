Return-Path: <linux-wireless+bounces-31300-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AwbNAkYe2lCBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31300-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:19:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5972FAD69F
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C30A301DE2B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA137B41F;
	Thu, 29 Jan 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7vg5oTm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE3237BE6E
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674729; cv=none; b=ESemDXeQ/qQBDGvVxJFfDXRkh9BHFR9GheI0XQfZgTX/eKyk7wmRgsUXdXfNvu6U0RojvuzdSc5O8KQaFdQCxUrr/xr7dMFzhZbiun8oDxcOUhSg5+6WrQzap+FicUjhQSLppQyTFcpswAEHiMHOjFQZAnGHFdcIZrzTlfLxxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674729; c=relaxed/simple;
	bh=I9vCOKJG6Meo57LJasxm1sA13EPisDbw02n/q9hTrF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMJfEGlFrIjzUV/8VAtwxQuHduI5OrkAm7LasUsVpyBmQzekJaGPOTVontxrgKCRugajnuuhuUx+85LgQOmJm0WorUv4wQjeRTNT2x4kgaL6u+oPZbb4qO1W8ogPP8gbDHTVFqK28xm0en3AveSl9VlCSm15HdDeP0m6lx9nNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7vg5oTm; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11f1fb91996so1371315c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 00:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769674727; x=1770279527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH0KX/wkF+O7L7rR2/DvCIQEVEq5fxSeUKic9d804ME=;
        b=l7vg5oTmGEQ016/xAZsIWXxGVThONHWcciSMBaEabfMiLzuRcNewq+J169DOGgujaf
         +s2fHb3lRcr544/CDibbSo5r3S/HfddkyZI/OblINWrQc2g7i8V6YtU2jM/e5uiMfmCq
         TcP0npRz8goCr+ulz6yyIsyyl0k6/29v4xs3sOPhfSN66Km9eUbIP5ZYnQf/E3b0IQP4
         qPNp9EAH62ALM03pX689y+usmP8e6QsLOfv5goGKLnrLItoQNqE68iCF2nHvJ7bDKog2
         bz9DeH+Dg/XTzvWzH4oV8P9soF6KI+DzaWU0WFgL3V+ygm2ktIzo5v31iYGKGf3dlp0y
         jlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674727; x=1770279527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wH0KX/wkF+O7L7rR2/DvCIQEVEq5fxSeUKic9d804ME=;
        b=kCKvYAbg3I2G3xppIy+DEAXUZLV8qxEOpQm9Bu89GPzL7w5+rEsgrnx55LP7OdUmHl
         xr9CGSDICToB1XepXcJC1ZOY50sf73VAm04lYoXO4PMx5xIQJOvL6bvIFUs2HFPxtWDk
         MNVn7l3l823ni/gDfMwFqEpDjybFqUj9/VS+eYQRjBPsS4UraRzDwCfIjEIKKL6hX/+L
         jcIP/O3oN95s5Xrg4b1tOYdgvkMfjRymyT8z8GGYhrydHIUJuVgrjBR/FCWQGQay4Qmj
         jSkrDD97pH92Rs31qyNHTvi2MnTIOEqCxwiYhvun7kL82Y557H1gDV84XVGHW65JjHhG
         6p5g==
X-Forwarded-Encrypted: i=1; AJvYcCWhUF6cCDb1mVMSTjtx7Csh4Yd05GikohgRlQoplNEgSnIWzbMl1QQcjeNeeasiCLWltifYmJaV3uMwfkN2IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycPua31AB0eVUym/ouFTzD0UNw0/3So0h4/kksLGzQR5kIT8zx
	CUXNlqifUGI4uA8x4hV4h849cVTPOPzlXNYOagDDDp4ergEwvmSWxlne
X-Gm-Gg: AZuq6aLqA9KOVTD7KkqEtDkwOdCYlyghA9F0KSfyqDFjagyo/Gr0+wBHntn21LBlF1A
	6c2bafynEjXm6ton1QfrqPMfiVmYTbut6dQlWLpGYgSwvHbp0f92rkmED9yXxikxMY65ZPKR6bm
	sK6N0ks8sAifFxQDNdp3eRhDYPTBNBV3eK8d9F7fRWhCNJgEsApbtC5I7aAFEerNfqDmO4BQLwJ
	T9QUQS/kEDGtzo0vbWuBEuu/rULDAAUnz6/SYslAgJy4ABRKhHrMonj1/rFa89XaEeTZTapAvwM
	DyaFieSyB261qpRIsAQ4pXfpEqs63h6bz9J7hkog++hyoPXlNIkxxxEDSrPm8W6O2+0kjIpIWxd
	fz4ViYdF1TrEP3b05bVTPA+l/+6av5HW3jYIvC6rWrnGbU8bw4+x+OYytDYPJfngt4NRyF0FLce
	L3lrFn+OOd83Ib1d2xgQrltmvnzzRIfJlEa4kVB8MK8FT2mr+6s/433oDgyfOy
X-Received: by 2002:a05:7022:4a3:b0:11b:65e:f40 with SMTP id a92af1059eb24-124a008e6a0mr4875096c88.5.1769674726799;
        Thu, 29 Jan 2026 00:18:46 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm5483508c88.16.2026.01.29.00.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:18:46 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: nbd@nbd.name
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	sean.wang@kernel.org,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH v7 1/6] wifi: mt76: mt7925: fix double wcid initialization race condition
Date: Thu, 29 Jan 2026 00:18:34 -0800
Message-ID: <20260129081839.179709-2-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129081839.179709-1-zac@zacbowling.com>
References: <c9b81e89-cd29-44f2-b4e8-0179b2049c21@nbd.name>
 <20260129081839.179709-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31300-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,zacbowling.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zacbowling.com:mid,zacbowling.com:email]
X-Rspamd-Queue-Id: 5972FAD69F
X-Rspamd-Action: no action

Remove duplicate mt76_wcid_init() call in mt7925_mac_link_sta_add that
occurs after the wcid is already published via rcu_assign_pointer().

The wcid is correctly initialized at line 873 after allocation.
However, a second mt76_wcid_init() call at line 885 reinitializes
the wcid after it has been published to RCU readers, which can cause:

 - List head corruption (tx_list, poll_list) if concurrent code is
   already using the wcid
 - Memory leaks from reinitializing the pktid IDR
 - Race conditions where readers see partially initialized state

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index afcc0fa4aa35..fad3b1505f67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -882,7 +882,6 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	wcid = &mlink->wcid;
 	ewma_signal_init(&wcid->rssi);
 	rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
-	mt76_wcid_init(wcid, 0);
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
 	memset(mlink->airtime_ac, 0,
 	       sizeof(msta->deflink.airtime_ac));
-- 
2.52.0


