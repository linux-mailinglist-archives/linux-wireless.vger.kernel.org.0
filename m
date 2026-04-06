Return-Path: <linux-wireless+bounces-34385-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOEmG1NF1GnVsQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34385-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:44:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2F3A8451
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188093042263
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 23:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443923976A0;
	Mon,  6 Apr 2026 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyCDcUBv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34752D12F3
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775518992; cv=none; b=iipOm5M+rkRJ/aUEwDcBXoQdJlDwT/UKojtR/jYYVWGzs+nLJJNDZUgncyt27etEOy8hFrqhHSVX2rr3dGepoqPnQpQ2IdOANm+yKM4sdTmuwdHs3+MQtbl26253470N90/yECpC2UG1CbtAQ+p79UW48KSN0H8uAX777LKThU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775518992; c=relaxed/simple;
	bh=syrgPsBc0vY93JNHaSusXKIRONAgGEayLWtRJL5jSGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mSgweCF7M6F5Hj7rqv5Mmhzs39UMBS7RFEk5ZlKF/Ns/X9Ti2UkjQx32htVSN+ttF90IREenWNDVVmA6qtNtgDxQFe2Q4xMUIt18zj3rz9SAe/qWxd1BmuvK72CW5mx985QimLOzOHcLW841jyZEyitteDxV5w7oCbZ1z7PNrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyCDcUBv; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a535e7c00so44627677b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 16:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775518990; x=1776123790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2USkU9Bkqu8e9ylMSWChChEpzoMYh+v9KdOxBg44gGk=;
        b=XyCDcUBvIJKZSH0Teg1tVY9eMGLHoArtePnHGV/R+cir+eBcI9MxbYaLdzBZaTrpkB
         aOY9muxBNu4dr+MQ1gda8Mx8ZTKseiDWsVKIgE13WoFT2ulGETZI6pG08g8ta6G38OUC
         VLR17fZAUkQuheir8CptD3RF1aZYXUz+Lgzcd4QRyaMHUscZTqjfxoScuzXCliBXD20d
         ZwcR4zahOXezA3OO/9s2wPO0GWq8YKEsw64SIwkFdAjJNPioM3XcCwxa/TLbJxI4bWbB
         Y9P2N3P2QM64kgTiczQksgRYHzHK0oN5wD0Q97bRBjsmGUtohbl3w6BBBIgfmQ335CXz
         mchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775518990; x=1776123790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2USkU9Bkqu8e9ylMSWChChEpzoMYh+v9KdOxBg44gGk=;
        b=M9Us16fNFG0PMZ92AgT4slG5Y+DyqObft8gMflVoRt7Of8RZ6k/wee9HktKd2rdPAs
         LaqWdS5K8ny1fpIrwwSE2HN4OZv58tgXabjoczYAu3OT4CYfwaoaqsj6UlwEl4l9GrXR
         m3IrYKNK4GRf0W4kihT3jVRY++oSNIqkCGCqSKaFBeV48gI0YgLvXTa4qqPdh0H3AhMq
         S71LLPGm+CYGQuLtaxnVL/dKF6nsAH5BW3roNvoo09jkFUEaeLI5j2d+ps/eQy0VocGp
         vzLwSzr0v2HL7xgjoIIv5/LTVEEzP+BqF4UCrrsrdDrZ6/njN1UJLbgbV44nSf6GRNe3
         +M7w==
X-Gm-Message-State: AOJu0YwNHBCeOXF4MZfwoQZyzHFl8FjQfaf3EsllALXn5fiwmMifmxUm
	hsdnNk6tA6ElorFoiBAqdCP3rJH2SQJyHkjsrjqIAKW78XH4ghp85Vz2tobxyM0h
X-Gm-Gg: AeBDiesM15RqYPAQdILe7r+M9AKwwXxhUVxutK255Upsx2M2v+jjCXRCRPZYoJYGNBl
	GwZ37uZ5LYnFYNONUfqMs8XD4EzWx/P9DExd4IPgM/P9uP/Sw8BqdOmazHDgtKaFaFX4k0r5Fx6
	EEMHfvvAR5ecuLxzEBWFqYiMX43C7l9mlR6DMmbep2y4aVDNAkpZ2LGGhsjn3p4GhfLg2aVUaD0
	FqgQb1jivgG5NY8W/uwWX7uAswikMMGA475e5vsKEERO3nr7MMdU5FtwZg5By6gonGbIC2++vQO
	4xQwAheb9AOy9mNfadmRvZOmgA3eP94l2tUDaP+BcH1IjxIX72cBqvJfSHW8PJzCRIks7lmdpu9
	N4TlCfjyd9lHSpOfVMeLerDof3N8mWyYeVmDvBfcD08JIJQmJJp1w3qHfjzHLRNlofeLtBdrsBy
	GjsSy/6e2X2/eNFX6sy7MG8Z9P95vYF6qCjB/dr80Ii9fBURp4y+WLcslQQrOB
X-Received: by 2002:a05:690c:dc9:b0:79e:9cc1:ede7 with SMTP id 00721157ae682-7a4d62545a3mr146138407b3.10.1775518989834;
        Mon, 06 Apr 2026 16:43:09 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df16aasm59144037b3.40.2026.04.06.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:43:09 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless 0/2] wifi: mt76: clear cipher state on key removal for WED offload
Date: Mon,  6 Apr 2026 19:42:02 -0400
Message-ID: <20260406234205.29857-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34385-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0BD2F3A8451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When switching WiFi encryption from WPA-PSK/SAE to open/none with
WED hardware offload enabled, throughput drops to zero. The BSS
cipher state is set when group keys are installed but never cleared
when they are removed. The WA firmware retains the stale cipher
value and keeps the protection bit set on WED-offloaded packets,
causing all plaintext frames to be dropped.

Found via reverse engineering of the vendor MediaTek SDK
mt_wifi.ko driver.

Joshua Klinesmith (2):
  wifi: mt76: mt7915: clear cipher state on key removal for WED offload
  wifi: mt76: mt7996: clear cipher state on key removal for WED offload

 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 14 +++++---------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)


base-commit: 024906a6d4d43554a0b9076dd25d8b35f5eaf0bb
-- 
2.43.0


