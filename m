Return-Path: <linux-wireless+bounces-34435-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGTOIJCY1GmkvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34435-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:39:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4B03AA00A
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80169301DECA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27172617;
	Tue,  7 Apr 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y753aPiF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0223EABC
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540366; cv=none; b=mTCRw4af+r+pfuHqiTzHK21hUoZTj5GwFPhewrVV5/jWr7siv6gpCzHVa/KgHa/7VU2K7sljBCdvlx3CisY43hPjDzW9VrHENeZw7m7zU9q+i+0Y42l6cTapUeF6eDs3o5zM8a9kVc1QPfWH9aK8z1gnldXviKXWl1USKHJXLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540366; c=relaxed/simple;
	bh=I3b+qkP2geFBXE+d5XMqPo4dFkw1pk6/UpV9v12SGCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe7r+cZtGCSsq8MfkiFY0GaE8m7QlTfajeOgAFGBaJAd60zzefNalBaM3WfsIt+3nCBKM6PdE5ECMsrReCecnHpas7sfC+5bB/9Ewb9Xzr928izhEBAKBsPi4xVmAxFEJvD8UgAhFol2C9P4hS3uNewlNITrJJfBlKjRAxrt0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y753aPiF; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6505ef94043so1967475d50.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775540364; x=1776145164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hssd7DxH2TZF6NSEoR7276VG7xwQ6X6nwIDJEykRwTc=;
        b=Y753aPiFdFLT39BfiwdfF6ZPBdRMQqO4fAWvp+XCpGao4+vIe7C9nBq8D8U4c4c1bs
         XOrINEzl2cqC7JUZ6znZLUAkWJOqDTB0L9qb6E5ijytMzEke602r/u1jCzT5VBBY2sGg
         4g2NCmyMDen0/43L2v7htI1TKhFk7aJe5VGROHpY3CHYOKYhE0t3i/tK2uOV6pwPQeSW
         M+REKMlPRQxUHhg/Fh5/77Yr2PKcKkdWVYC94LrsxJOVPARXSyAJCSzVSOqPYYvAA9N3
         8FdLRaajwX9WDXCvhsIEPW0riibew4DdBKZEPBaQNv8zl+Q3MjSLe8wiNwcgXRfRZ6id
         qMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775540364; x=1776145164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hssd7DxH2TZF6NSEoR7276VG7xwQ6X6nwIDJEykRwTc=;
        b=pPnij854tZSYb56431X7M4NPbLXmablKgjyoteyXRmHAtg7U09eni9GGJ9mHrkZysj
         ME9F/WvXdskYhdLF7DtA7o4S3y88+oeB9D4UdmSQeJA1kzxN+JrleYtdu05QAuS8FvAG
         Bwmq2fpGRtW/B8Zc0LFqi+wuihxCv6g8znDUVWwbt5mnOrgtyFUpsSOFznI8RUp8nQXq
         F8A69fpw6iadaVG9f8twaqVQfnjmAr28AjGpDV5832+wQGW4DG8r14mWViWj/Rn2GP4X
         eHOqf0KMXasF5nuEiBkmFYU9MBeWDl3Y3TUy8YqVP0POwT59VPl1/sxA6B5s+8lJpIc8
         o5Gg==
X-Gm-Message-State: AOJu0YyhEBOo9bhb22+02lWZoTtbpdpD06rgJTU0QuHh2QMzFpsRZh7G
	cq5yOIUAlBi6KWrTL4WQOJy24UPZ/g/x02q+uhf7ZFz+SrYmzJzdIvGEkv77eU3K
X-Gm-Gg: AeBDiesz7UxeQdibf3LLGXXTVhWDJ5nsoavs5+T2fAhDkHiUK7Oz4DS99Pb7iieq7fu
	+ngaQCRo44PKo/Qve3gV+2HhBXwyrxNYATF2jVDxtMaYMNYU1ouAwTIZJEzdHFUlWAqvngAz+32
	4zX/Qy5gHEvofZVymdj+7vvrQeY36AXNaAj5ZJCYOxmE8Dr3YxAl8HI6zyvUjBHUHSUVZAa00xe
	kkAzChIefvwe8c5BibHdVyzhhbJxB6irCbv45/wKe6S0z1qhj90FZRif4K4Xk3TFjhhJyCanJU1
	4ki5FsIUgqGXN8gQDjZ8pHaft435N5msUkNKNibBjZskPFnTy9iW+CrCHIcqPFRTLRqdXJHwgYF
	IVn9RljCrcWxRlC5byZGpJS43k1TNMFtxycM2Sh0tHf63Ah3D3OMQwk8NStfWjm8pcbi/MIMYFA
	BwhP8UlZkRZDoqv3EQB3eV0nmnTq9Z9qYD4XX9JyNdgd7NpE/buMk8GsW98wRu
X-Received: by 2002:a05:690e:144d:b0:650:1079:2cc9 with SMTP id 956f58d0204a3-65048882eecmr14546840d50.56.1775540363758;
        Mon, 06 Apr 2026 22:39:23 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a978b7csm7217468d50.11.2026.04.06.22.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:39:23 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless v3 1/3] wifi: mt76: initialize hw_key_idx2 in mt76_wcid_init
Date: Tue,  7 Apr 2026 01:39:15 -0400
Message-ID: <20260407053917.75898-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407053917.75898-1-joshuaklinesmith@gmail.com>
References: <20260407053917.75898-1-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-34435-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF4B03AA00A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hw_key_idx is initialized to -1 (0xFF, meaning "no key") in
mt76_wcid_init(), but hw_key_idx2 (used for AES-CMAC/BIGTK key
tracking) is left at the kzalloc default of 0. This makes the
two key index slots inconsistent: code that checks whether all
group keys have been removed cannot use a uniform "== (u8)-1"
test on both slots.

Initialize hw_key_idx2 to -1 alongside hw_key_idx so both use
the same "no key installed" sentinel. This does not change
runtime behavior since all existing consumers compare
hw_key_idx2 against explicit key indices (6 or 7) which are
distinct from both 0 and 0xFF.

Fixes: 730d6d0da8d8 ("mt76: mt7615: fix key set/delete issues")
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 75772979f438..5eea3b4f27dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1690,6 +1690,7 @@ EXPORT_SYMBOL_GPL(mt76_sta_pre_rcu_remove);
 void mt76_wcid_init(struct mt76_wcid *wcid, u8 band_idx)
 {
 	wcid->hw_key_idx = -1;
+	wcid->hw_key_idx2 = -1;
 	wcid->phy_idx = band_idx;
 
 	INIT_LIST_HEAD(&wcid->tx_list);
-- 
2.43.0


