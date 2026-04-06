Return-Path: <linux-wireless+bounces-34393-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIadEENG1GnVsQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34393-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:48:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC62A3A84ED
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E73F53008D49
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D9396B7A;
	Mon,  6 Apr 2026 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlUgT67N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD439E6F5
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519294; cv=none; b=cSCz8BcbBUKatghu70n+0ttr2lJ9QSeZU5tNMuxrb4Goj96ACNFtif3mYIM8J/oDgjCPTyx4EgGmm6TAFl7Kp+ZjX2A800fGnP1EmC2WIhD2mbM5z5zvudygOvaaft6Zi8/2xyYuji6QlNWqM5byCBIdejy+Jx+fQ5dAHq/Rxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519294; c=relaxed/simple;
	bh=fLXk3bXpieDrwX98W47tp1OzMj6aUfhyhfq8Z/yEGV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfPbazy+iaVr4sUSNSi6hqgkrjIgQvh5WOkUu3eFR9dgwRJv2KKFuBoIaULCSjm5WiC3kb1mmU1dyUS3ZEZyLN4FRBrdwt7sjLqOWGAkxh+HTzmKJrcXJ8nqp1IN1r05mL65AtttGNUhuIaa4h4f/lYFM6HLGqQuPXcuQ9+es2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlUgT67N; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7a2b6adbfa6so41314997b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 16:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775519292; x=1776124092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pJ8bcPlQO50loL1YnrqMrLEuQiLneTFnhbIpGfz2QY=;
        b=jlUgT67N8BLwBXwVTHjUwqU7mOKygobvi2HnRLoE0OpLfhN1ozb8v6I3j9QlZarRr4
         q/GIkyTHhz781THTwLzYSqHVjc1g1/NXrIo79tEwnW4aKx8aPzQQNB50VLEqx9iGsNz9
         ScYSJ3R0upPZw5u78NDa0wahgQYyKr/RaZPBM1mRNGy1+a1nXaCkPHnqTAUTNG8HxATN
         EPhnHU8Uw3udTNJLR8dIvlqkUPnNUSnEcAz375QsaW0iEyzPEEp70Qwqw3jezsvic3c4
         OsHmUUV6RNHT6cijjBRu/EW2w3qbAkgkjMb4Ja9wJqcfEfh+fZP6OAN7S+uAAz7FzECm
         6T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519292; x=1776124092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pJ8bcPlQO50loL1YnrqMrLEuQiLneTFnhbIpGfz2QY=;
        b=HT70YiOEnKASA8cG8Oo+AcEbR30ACWBqaX2q0BDvsMztNVqg3pHWFxpIxTL3IFb9xu
         x0j4lYs366iSetD5DvfJBk7rtWL+gfQztiHFz0jSg/Mitwcz9wQPbgkz1Hg+FAOqhKqk
         bzfNdnhURHNg8N5Ch7zywjusIJnxfkdlGZoyzRo/7iPW5hUKC/MoZC9F83s+KPwdjSVC
         5T1ZAHA1FrHGYw0rvtuUyqFmXDnmRm+h2o8w4DQdExprF9CgFwJE/BjPleHg3QP0X0KH
         iMhNrJyCAvW/umwBQ2Ux6mMnYjy81xFDbEs0ouWdZleT81lUk0dMe1l0W0HDoVASeYaL
         RQNw==
X-Gm-Message-State: AOJu0YyfVv14He2LYOkiIN2p8DJ3L9quSFCie2E9wkNIdug2vnzH1PA8
	2iUTfCMl9K9mqlAxqo2ywnbQcQEJEWKY3ZvFNKI7H3EVr+rzu5aAzoPM/WJiIu4W
X-Gm-Gg: AeBDiesU5HwoH6MtW5MVtkfay4ks61BzIIoVZTnZwb8TUJntcW2ZRDsp0RZvYXIvlnU
	7Z4B1I98Pvz6Sumb4kBVkepXWbw04xrUqW7rNCr6JwctF5LMoCS1Tl9wRtXFMWVQpN+DgbCw7DT
	K3ruYnqQeTA38GiHbkJl3ft8YiWzOVnuirHfI251leDA5F4/AERDPOH1oABqo+cZyjCDIESjP6P
	GVTX/I8/l1Kr8lCiErh1pbPP7c75cd3BEwJE6w9sXEhBSjVcG6S/GpwdqRvtVNeY0MmMgQ1ae+k
	opYt7QwuUPBPqAVIqU39Q4aycgVFmPCLyRrQ+UHgK8xnb6WX06guuwPVBUF9zieiAs9cert8F7t
	1G/WlfGZJOztOg8Y6VlatfyvgXgHN3RuN0n7PHF29Ddse6KfeZpDGc8qtsMcK813HKJSmHB7aUI
	Tc82pM4j2OUxOEpx6snUVRImuCPrsnECAx/K4IkoC+ZA3Yv7iLTILt8PvIquIZ
X-Received: by 2002:a05:690c:e345:b0:79b:e24e:e2f0 with SMTP id 00721157ae682-7a4d90a2fc0mr149738807b3.47.1775519292074;
        Mon, 06 Apr 2026 16:48:12 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df19f3sm61747047b3.39.2026.04.06.16.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:48:11 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless] wifi: mt76: mt7915: set AMSDU parameters for WED v3
Date: Mon,  6 Apr 2026 19:48:06 -0400
Message-ID: <20260406234806.29957-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34393-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: DC62A3A84ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On MT7988 (WED version 3), the WED hardware unconditionally
enables the AMSDU aggregation engine. The engine uses
wlan.amsdu_max_subframes and wlan.amsdu_max_len to configure
aggregation limits. The mt7996 driver sets these to 8 and 1536
respectively, but the mt7915 driver never sets them, leaving
both at zero.

With the AMSDU engine active and zero-valued limits, the TX
path is severely throttled, capping throughput at approximately
6 Mbps on MT7916 PCIe cards attached to MT7988 SoCs.

Set amsdu_max_subframes and amsdu_max_len to the same values
used by the mt7996 driver.

Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 4a82f8e4c1..403466eca6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -719,6 +719,9 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	wed->wlan.reset = mt7915_mmio_wed_reset;
 	wed->wlan.reset_complete = mt76_wed_reset_complete;
 
+	wed->wlan.amsdu_max_subframes = 8;
+	wed->wlan.amsdu_max_len = 1536;
+
 	dev->mt76.rx_token_size = wed->wlan.rx_npkt;
 
 	if (mtk_wed_device_attach(wed))

base-commit: 316da1786e2ac103254d49c0524bdcf72a454401
-- 
2.43.0


