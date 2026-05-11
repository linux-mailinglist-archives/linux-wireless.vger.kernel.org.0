Return-Path: <linux-wireless+bounces-36195-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB2IGgp+AWoMbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36195-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 08:58:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55754508BDF
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 08:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4CF53004056
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A22DB7A3;
	Mon, 11 May 2026 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="G7KiyDDv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DD2D5922
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482692; cv=none; b=qzbNGJPj8YOw6avV5+RlG4N9WkqlwS0i1sqDj53Fkqs2tZkHQROP79Vw2QuT0Mb97Yuy7pdoCgUuOgAACvM9bupW9y+/qLTmCkcRpWyC3fqjXwDLEhISjkFCkW3O0p44sAfMR+yUj/JJPF0QYeYwVzHKBeSV8fLCm1cCbBNBLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482692; c=relaxed/simple;
	bh=pAfSR+l7wN17yt/DIe6cWy36lj4IM5O/wJ/9Kftnl3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1WXlDjYgWgdl9ZbvPMcuqgMgETQJjG32F8NeSmgQR4RsCV2Rl0X/BSdMDNdlD4XEQMjUi1J/6QATRhpgt7RR4fBu0LlffkAwwMmKo5W9qmUnJHWXI8ZhT1BWwHvifkg8UlVn6gywQbrXkpgYGgSWL+uflQ35mJfjWaAiMSgyxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=G7KiyDDv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso3098697b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 23:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778482690; x=1779087490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4r0tJ9SsE9hnxxU34JfGu26fGcFCd7TwYQ/xqlalG2M=;
        b=G7KiyDDvFxCeMsvIKgsRcZ3MWZGAgIQBAq88EdM4FjOgvB3sDcSwxxeGufqcCGbWqn
         xpT6DLitSSDzXvMACVQLMTeahy6IlbaCoK55KvzdWd/UDZKSkEMA3qcxjPaPAVJmlVuk
         OznuusblkBXTd85G/XU4syUwUAaay9ZjpRyM9k5v9kZp75mTaqWAXBxv0fAVEZhvtCNw
         p6jaX/cwH8bdWu+2Vjnfw1m9d8ArX8D7cIHNp0F0fGWy1kiRE0veMoUb2R4v8sPAXiCH
         CLCvD9JxYhOIx2Hy4JdGeQlbdRVg8RiJiutZjQSFgoXTpVim6NezMzK1uRxjRmkAOc8i
         9ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482690; x=1779087490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r0tJ9SsE9hnxxU34JfGu26fGcFCd7TwYQ/xqlalG2M=;
        b=r3OCAFmj9hs+FxFQPlVtKScl8zUJH/TbEx0P3YlsJn329tSu5lPUNbBfGziY5cWG/F
         Jpc992NlC2yuJKhn4myu4Lt4JHllDpzNcina3W5GSYc1EH9j+ZjRd2O3p4xUQIm34zjw
         nt21tDNTC0II8Q1KskYZkyDsY/d+GzH32vp/zKAxtoBIJ8V99aZtmt2MBvWYlF9rDaBo
         NXtcbL3DUO9oRW18kVwPE376ajRJUQXBHvQrPUzZUsLSBw/B+uF3PAoEd9zW3WEwEwkK
         qr4wjcHBf8VJjTnuypocvJovdZ/KI+KhJd/8FGyY9CpdjJhHmklBO1XjObwEgaAWX9Fy
         K6fw==
X-Forwarded-Encrypted: i=1; AFNElJ/BolzKPdg7O0QNe5EN28PscakHXb2q7eHRNEksFsEdEwUxbHIE1GM1yhu1USNXd7HCe6INn/NOvvSL1b6IkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymtBlNsf3uRY6/yqo+MM8QiHkH3A2Zi7Wj1XTgFImVujtM6fj4
	u54wQwyNCvKNgI2cItQ4AwAcLVLFKTioO7qj/xlk2wcTDly3P/9XMH23EvwAr9QUN/4=
X-Gm-Gg: Acq92OGHVgq2Af1QOlWHNAojTgcb4kWMEJi5+XXDJ/b9fZxfLWdCMxRU31dxYWDcL9K
	E0ROvgmq8WymANmsjDQcpPiYL5vBhHYqIHen4hq0enkIqp4R5DZbAAf76b5xMd5qD9QpvhYENbT
	ewjlfsb1VM9UikSIGm4PvQOjMRdNiMQAdQCQvdaC2QDMHltGjkJGVx7BR5dU97IN2A/Jxuns+7E
	PLnO6Vbvd3Pj2AxFx1gHzsdHYt4TP9Pz9mKEHLiqTf69qm9zM/3b9HZ5odwP4V35S9cnPxsjOg/
	ZHRlJCY9K1JOAugZtdclooO39UlCyWMgp4yjOA+rZjZ+NZG6XaHwb35ZGaN5CDArjKNIB/VJnW3
	52Y6yQFR+Dl/0ZAgkzMkO1vrdNynAliJmZvLfwS+09/I+6uP0J2cb06b3Iek0I3b6IESVyfWJ8Y
	Y/DynGPk/w2IZZ1fcxKl5MmXIcMIsC3zdw58Cb+5Tnqnqj2SmB2zWR5cvPorImEZLslTKjV0+4i
	60R8SEcgw1eQajDhHGiQOJ2ZG+oQxeC5K0Yq1uYGlqHqJSGEEMctEdNAg==
X-Received: by 2002:a05:6a00:2d24:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-83e3afd78f8mr8387020b3a.25.1778482689898;
        Sun, 10 May 2026 23:58:09 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-839679c861esm23913907b3a.30.2026.05.10.23.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 23:58:09 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: ajay.kathat@microchip.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	claudiu.beznea@tuxon.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wilc1000: Fix memory leak in wilc_wlan_firmware_download()
Date: Mon, 11 May 2026 12:27:57 +0530
Message-ID: <20260511065759.37713-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55754508BDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36195-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iitm.ac.in:email]
X-Rspamd-Action: no action

The memory allocated for dma_buffer is not freed in the error path
following the acquire_bus() call. Fix that by jumping to the error
unwind path which frees the dma_buffer.

Fixes: 1241c5650ff7 ("wifi: wilc1000: Fill in missing error handling")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/microchip/wilc1000/wlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 3fa8592eb250..4b116fe6f9ea 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1265,7 +1265,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 
 	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	if (ret)
-		return ret;
+		goto fail;
 
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
 	reg &= ~BIT(10);
-- 
2.43.0


