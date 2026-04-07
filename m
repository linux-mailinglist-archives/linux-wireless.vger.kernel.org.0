Return-Path: <linux-wireless+bounces-34395-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMpcMsRM1GnvsgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34395-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:16:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 280D13A8634
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 02:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5649D30479E0
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 00:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB51A6839;
	Tue,  7 Apr 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSVgy9ik"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3713C9C4
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520945; cv=none; b=qmb5qhQFRoxF+jbtsktaUCsw/syX/bRb8yC0yheBB1KZkI0HJxn6xDtJpJDzm+KkKt82K1GXliZo7SNP1Xh9GhczfiCW0VG8z4IXH+rPed+CfjbIFAeIQogg5WMFGp9OCzSbiqng8NZ04PWFsrm5k1OH76Vmt4ZhXPHjMzQbfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520945; c=relaxed/simple;
	bh=p+heu8oqAJ8mKuDQBckMkIu9ukpFg/92WpoiU5ZTiKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hroXKr4zU2Uf0AfnXwiPx4987AhX5jFbhsV8OYPv5sS/IYRxXhym8lje0mdkxAFARF0EpmqnT47SoU10YRoN8UZOjZTfmdi2eJHQjhVm9/Ou0APACRJss6y1WWZRmcVIEVK8QA17p69KUCJduEMlARvOklYh7GLhgHAVICAceA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSVgy9ik; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7a17bc5745eso40702507b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520943; x=1776125743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2OqRI8ckw+xa4yxPr5+ydqFc4r4rT0slahm2J/yIYk=;
        b=HSVgy9ikS/fW8GP3UzWesGj5h/RwEV3N0thLFIC27fDEU9/bzH/CwcxuonG2VT54uG
         9umgMDaXpjqR1QIeIsjy+T+dRisnNLAUO8GxEhZvZH47IciC1Df3l2jfy5iLACHg+vGH
         Ntze/COBQ+m93OubWNNPfUK3gkyGOHVq8T0Xdbv5zMeB4cQv3yxKb3ZWhwkWoPduMvvY
         vkzH636mTKenm9FBKZocCRpWX2INSdBZpYi2xi0tqYaqPJnYYgwh3PdQshtNeNWngl8x
         OMRs00d65suGDKKxlsF9+T2j/LYAYlvb7mrJArq+xOgu6X00bELlr8KqsGXVjOKnOZCj
         Y66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520943; x=1776125743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2OqRI8ckw+xa4yxPr5+ydqFc4r4rT0slahm2J/yIYk=;
        b=Pp8ZKQLBBoIG7+VY74MSc+qiuhhpEWkutzudUrI6Cv29KwjI14cWewPuiam8YxIPsl
         h2QNbh4olXf3OoVafb+B0yu2DoEWUnnEPfFvIXUBPHIulb1IEFi42fDE6+plk0LnMXQT
         pMgbrDsXG/EUE7DDYtF3JMFeZFiMS4qi2Rr7/rYtccXzKCZtKjz9nqlCS77Z8Sn08lA0
         DoTVnsXVGF8yNJt0ZRJ+dseZS7/PUap8KJowpf6pzTJnbEIv0NOZhLzrXzSfsom29ogg
         U1o78LY1kktrzjFpOamETrg/q+KW5St2cJ5/js7/XYpm1IXGhy43cPLlhZrvNtuv3ZUZ
         viEw==
X-Gm-Message-State: AOJu0Yx+/VTCWUrKVl6H1LSNXoelBi7ZvzYnN3bobXgm+e+5gDuRsZRk
	WTy7z3jh1elRQbfafGULstCARv1PPhQ8I/KbYX9xn8NO5vxcq6tS9ewd5nfqUXmr
X-Gm-Gg: AeBDieuNZGlcbMahDboWspVuNAr7upMaSMF45OjVakJw48jtIFzyerq7+tssuY7al2f
	PwFUbydaKrkOTcaFEOoBxdOALBXblmokMwGuu5ZR3WwVgJMTfKYqDS4HOArgDZd7hqTCL7ae8KK
	H2hXg/K8KaKRM9hefju3mYH54dfRUjAZsqTg5coqTBRY15j5WaVxj/+fMDvNZRMYEAzfllwH7ca
	d4TCjXp+w6hQEfFCHSbR+w3o3N3NwZ8FcyxA4NYrXzJHXIgEYCG7TOjIovZ4oeSROlZtCaNV3j3
	mLxIJPEKEWUQZ/1AMcWSFm9P+dyvBlAIABBJ0mqTZB+hCaxo32bAhvfsbwIQHOZhyoiI9HtnRLu
	015wVN4GLygUmaOa0bW4bEU07HuUYvd9fkywjDSJjtbFrUH92Nz5DztJ699OGLwmi/ugnRx7Gvn
	2+ckGBpI6lKkbfUlaHY4fo0U3lKN+eKt1d9Kcvg1aNvLfvDAe/n8mQ2opjqgci
X-Received: by 2002:a05:690c:488a:b0:798:ff2f:267a with SMTP id 00721157ae682-7a4d6546abcmr154271267b3.52.1775520943192;
        Mon, 06 Apr 2026 17:15:43 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e320670sm59858877b3.2.2026.04.06.17.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:15:43 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 1/2] wifi: mt76: mt7915: clear cipher state on key removal for WED offload
Date: Mon,  6 Apr 2026 20:15:30 -0400
Message-ID: <20260407001531.31207-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407001531.31207-1-joshuaklinesmith@gmail.com>
References: <20260407001531.31207-1-joshuaklinesmith@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34395-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 280D13A8634
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When switching from WPA-PSK/SAE to open/no encryption, the
DISABLE_KEY path never resets mvif->mt76.cipher back to zero.
The stale cipher value is sent to the WA firmware via BSS_INFO
updates, causing the firmware to keep the protection bit set on
WED-offloaded packets. The hardware then drops all plaintext
frames, resulting in zero throughput.

Reset mvif->mt76.cipher to zero and notify the firmware via
mt7915_mcu_add_bss_info() when the last group key is removed.

Fixes: 3fd2dbd6a1d3 ("mt76: mt7915: update bss_info with cipher after setting the group key")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 90d5e79fbf..6e7442cac4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -414,6 +414,12 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	} else {
 		if (idx == *wcid_keyidx)
 			*wcid_keyidx = -1;
+
+		if (!sta && mvif->mt76.cipher) {
+			mvif->mt76.cipher = 0;
+			mt7915_mcu_add_bss_info(phy, vif, true);
+		}
+
 		goto out;
 	}
 
-- 
2.43.0


