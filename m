Return-Path: <linux-wireless+bounces-31085-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ee+Fu1EcmnpfAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31085-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 16:40:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8DB690EF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 148BC56C9A8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F252319873;
	Thu, 22 Jan 2026 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsOOXcfG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2182EFDA2
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093785; cv=none; b=fVNthDsXxvL+6G8YK9BwweI2+ntzdHH0kI3SGEczjSQVNhs6LEEZFJxPvOnY8Kn6G26cW8ShC5CO0vWG/WtDyLCmjJtJmoJZ/t4ioDWSqkBq+KCT7/GhvmNoVlPisbOcIXIkW0x++cYdftLHwmwAunV5vYyFiAuZ8f3YjujTDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093785; c=relaxed/simple;
	bh=hVu6bPDYRu0t2DIlMecxiFle/m2sqqN/O9jIhZnd8tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SK+5cWuJM4/3SGtA7Mg81cRGfFxUlCZXFJLnuzO95QMr+/bkf4oxPESrih9SseVMu/OgQXjiy3ulTsEu4qCT+f1s/ObMZvvEDWgFkeNFOIWoYnbAMcWY1bC8taEM+mMUVX4vR+L/JNfeHzMPyV+GSRoGXlIn5vdYG06YA1TOGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsOOXcfG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee9817a35so9000925e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769093782; x=1769698582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tuSTNpaUshW5xCrl2rzoox/hvIuSJHaIBsi01xTAbpM=;
        b=lsOOXcfGSXFlNUp5ZvRhr3z2zwS0PeuhvSn/5aoFlDmfTiChGxguiVsrfXV7jvgwbR
         hKITXpPi52x1KziIK5DQWIoiVz2vSF7Xne8ypvBF6WPWUXpiyHzlzH8LvW7cR3TSkUyu
         yJ0xEKAmmj2q4/FsNhUlfR02vU2QmTDLM87v3nWZdtriA5/bHjFcHPrvk3aqnV9u6p+v
         T4r3jgn69k4N9OepJXihY+JD/CtxIXx0dRzpS+onSTMdV4Qv4l+6+vlBjkQheyoXICaH
         Jo8n6y4DqHggW7C3wdDXlofRJJlHpoWdm/tJfdxL0uGf8RGNp8QxYUOzRTAeeM2zM/+Q
         TkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769093782; x=1769698582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuSTNpaUshW5xCrl2rzoox/hvIuSJHaIBsi01xTAbpM=;
        b=GDRdof0XlqqkiR1yaAAOxseO4WBKCU75zI1muRx78llhFrAmLde/FvQCLHJgrr4m/C
         Lq4/GeGrhXwqvSPMMC5+o/9+/9RhY4wNs8QcI7xVE41fB8o6A5vT2TNoHm0yG26naDuT
         nNpyGfAF8OnT0Y6v71VItOfiA2GVDsbcenNpKuZnl75FiTesnu4hPYVf1eROssxmU6ZW
         RsrlqpUDxx8g1i028SvCUVRpaBXaTUHBA6xRd4y/VnWl8F0YEp60FojzJZw2vVqGWmjP
         Z/yD+uuK/9Ssu2n+G9QlVBMWPa4Jp0hAfh4lbHR2MwISHjsGFbe5EiYOMKELHOEtzXtn
         YsNw==
X-Gm-Message-State: AOJu0Ywhaxrfa1HInXo+KzLQ6vq3qle/APMxIXi2b3xNntzF7RwRkCC6
	5Sicpadqwz8e6yT0yXBHrIVz+89Rk4LpkR6LZJlinRpPV9eKNwb/PYRQad62NA==
X-Gm-Gg: AZuq6aL6r+gYDFlPaiXoHO4aZi/JQVu0VjV3nmziePbL6VDBeCa6mABapoPcCQGrEk0
	GuCyYhvHDg3gjpIVL/dPToGoSU9uIf/3BV6esL58ylx6RTMeKqfOWfYzX8KZx2ELZMdsxb06fiu
	9kx1KMSwtrKWw2shk7H+XyLcIFVi5l4+Vyj/0UJzBqKHY3QDRl4TZokc1XjlB0DshIG5m5mZRd4
	gh3d8f5cbi8e9amozXHpjlUgonfoworqyNNcJ9D7KOkJT5a8R9VPGh8uKluv2CHNHNVbjuyQF8R
	eBhZ0kOsCyu/0STFvl99N6fgF02n5PrCBARDJgdVA8iZ7wG6Hb88PvltD0sXvzlH7PQai+soZg3
	vpvnzLMzHEcnaUv72My7GVDQGLQ6sBvDv6UcgKpFJck4IV7yUSpVUZHdLcIpzfrPoi+bW9bxcLc
	QO3jW6JcLG0cnvxNBSTg1GDt/58h9W2q+QtRT49kYWu+mt
X-Received: by 2002:a05:600c:1c11:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-4803e7f1b57mr151727285e9.32.1769093781751;
        Thu, 22 Jan 2026 06:56:21 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804703b5b4sm72366295e9.5.2026.01.22.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:56:21 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes.berg@intel.com
Subject: [PATCH] wifi: mac80211: do not set 320MHz EHT capabilities on non 6GHz band
Date: Thu, 22 Jan 2026 15:56:20 +0100
Message-ID: <20260122145620.861355-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-31085-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F8DB690EF
X-Rspamd-Action: no action

The spec (at least 802.11-be draft7) at section 9.4.2.323.3 says we should
not set the 320MHz related fields when not operating on a 6GHz band. It's
quite explicit for most of them. For example:

Bit 0 "Support For 320 MHz In 6 GHz" says "Reserved if the EHT
      Capabilities element is indicating capabilities for the 2.4 GHz or
      5 GHz bands."

Bit 22-24 "Number Of Sounding Dimensions (= 320 MHz)" says "Reserved if
          the SU Beamformer subfield is 0 or the Support For 320 MHz In
          6 GHz subfield in EHT Capabilities Information field does not
          indicate support for a bandwidth of 320 MHz."

Bit 54 "Support Of EHT-MCS 15 In MRU" says about bit 3 "If 320 MHz is not
        supported, then B3 is set to 0."

For bit 13-15 "Beamformee SS (= 320 MHz)" it's not explicit, but it makes
little sense to special case the handling of this one.

Fixes: 6239da18d2f9 ("wifi: mac80211: adjust EHT capa when lowering bandwidth")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 net/mac80211/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..996983f6815b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4426,7 +4426,8 @@ int ieee80211_put_eht_cap(struct sk_buff *skb,
 			~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_160MHZ;
 	}
 
-	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320) {
+	if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320 ||
+	    sband->band != NL80211_BAND_6GHZ) {
 		fixed.phy_cap_info[0] &=
 			~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 		fixed.phy_cap_info[1] &=
-- 
2.52.0


