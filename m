Return-Path: <linux-wireless+bounces-31529-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEMXLMc2g2kwjAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31529-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:08:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB9E5953
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 13:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD14E309C383
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB93ED13E;
	Wed,  4 Feb 2026 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff98lTtb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEEC3ECBFD
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206521; cv=none; b=iKmma5NGgDapmjmWNYUOFBG86YSB7CIM7MVRoWrcHyMgBK+lbysWckqMdiE1egmazGCCyYCDSdu99n6qsRm7FRJYzvV7x/8LYNqxIEwuRWKgP2odP9rcLuWvzU/nzjr3oeO7HsFx9WNiwgoOJOqqYZUvATzMnxfc3FCz9bTUTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206521; c=relaxed/simple;
	bh=9CkRpAdmv0lF8IFcGIbPHNLlPh7hpLD03KqWjCMuaUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2NNpstIICMkb+AMfmkwf8jUe55MvM7yuRbGFGdlxJIiD9K5N/GMIj+HOIF5r/Am9BV3zhsqxBmg2HaS8D3x8/sJenkSMLUsj+03N5IVLPmrkY+a8RZcAB51ZhnmuTWbHd4Ri/cNQ2cFPYZrebq5EyIB4x+HNlvmG4ohcU6ENYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff98lTtb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a7786d7895so49706105ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Feb 2026 04:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770206520; x=1770811320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VxuZRTlFqw11MntzoL+Rim/Fs3KarxpFDjCya3TSoCw=;
        b=ff98lTtbs99JeCuskrufK0XfpIpz+UKPbmVLwt82d8BOlu4tbpIBj5LM6UcHoTdGIm
         CRvsEB3zGnf6EsTOiXYDEssmnN6UYxUyvKixEc5LvleE70vcmsKKFEeMUUUWMQi+A+0h
         CyrHCELa2juJYDvm9j/0HJ0ZQzgczyhlwkiy0QmxTC9lPD3UFCigNegulgZX0TRy1Emh
         B0cwDLye48Az7wZHC5yZmeRyTWNLQHwIqh3AR6Q6yEKNh0H3AuPsuZBbSP8UqT4IJ6Ub
         n8vuGcRse4vFh0AFrB+lOw53QgSOXKb9XgnFyBo1Y2uNIqtlKmqqoZjF9ybaox+ALERY
         JkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770206520; x=1770811320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxuZRTlFqw11MntzoL+Rim/Fs3KarxpFDjCya3TSoCw=;
        b=VC3a/mdYUEmGRvfA8El4INfKCfUJG+AdqV34mC+l4Bc7JvkM8PoUgvsG1VYjQ1BOqY
         1mvkWAe8MzV90ZNErFEXwvRiVEq6GftPrkJYZOQhVNd/d+IApFZORVHzZBbNgpVAS3We
         EQSMXiNfFNCPbhbjimtAuM0aVT4dvNHkYH54e1/fVn1DQAwKnBxxf5EY7fGzcDvlzQCE
         GZPKpsnwZBHeEia+FZvUGPUL7ZV967pjcD352ADgLvpFHG5B6jEPdyS5BJirtNaxdQCb
         kQkrNI2E3IJy3V8SfXZTYgwvHghHUL3op+v+3YwjpjFB1BOumiBwwOyuVBOfPdtQ3gpR
         JFOw==
X-Gm-Message-State: AOJu0YygtpZRZOjZabl1O3v+myKLc0Fp6HbuG58BqwNM2YNQtjmvklFn
	LAuAb/BEEPETfIVaSulUHT0zO3xn9yrUHlzGEaVCMudDKqRhdJSWb0jq
X-Gm-Gg: AZuq6aKEm9YuFgZkbE3uTMLj4AU4lPCjZiWxdtEEUX7pk5OekrnxEZ1OFPXn3uQL90m
	W3YxrHSPCKdUycafJ+8/1VCHrP7sKqNl47mYar0lwEzGWSN/ik0b/MUR3fUF2oFmR1//SxoaWZ3
	zUGwRZq6z/cPEsDC/fgggYdwH69AN+S7Zg+yBf1Whq0bBzpfltv0aFkLo1HNnpul8sA6n4dLrJW
	hA+e85st+lcYG9ztxQ1OXS0CMWEr53qRyxZyaWS45zlZPCyvVQuJzE9f2BuHenlE7jT9Hlq7rqz
	je3ite6ISx1O3B21H9TvoG+kBTrMiRFMr9IrNTiNfAnIExtWbLdexZT3hK/gX4o0nZD8HlBiVXq
	MAjRZshkg3Et3MZIPdRzfJ8sg/Da7k3/RYiut7OXLZtuCHuXcoOGxMKe+C5tLoJZUDVsFwJJbgN
	UJOTVogQu1xA==
X-Received: by 2002:a17:903:3bcc:b0:2a9:a11:59d3 with SMTP id d9443c01a7336-2a933e60cd3mr29787525ad.26.1770206520353;
        Wed, 04 Feb 2026 04:02:00 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:9794:b4e2:d5:4aa9:9038])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93386e967sm22686585ad.22.2026.02.04.04.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:01:59 -0800 (PST)
From: dhyaan19022009-hue <dhyan19022009@gmail.com>
X-Google-Original-From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
To: kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dhyan K Prajapati <dhyan19022009@gmail.com>
Subject: [PATCH] iwlwifi: dvm: fix NULL pointer dereference in rxon
Date: Wed,  4 Feb 2026 17:31:41 +0530
Message-ID: <20260204120141.2896-1-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31529-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4ACB9E5953
X-Rspamd-Action: no action

From: Dhyan K Prajapati <dhyan19022009@gmail.com>

When bringing up the wireless interface via virtual monitor mode,
iwlagn_bss_info_changed() can be called with a NULL bss_conf pointer
during ieee80211_add_virtual_monitor() -> ieee80211_do_open() sequence.

This causes a NULL pointer dereference when the function attempts to
access bss_conf fields at offset +0x10.

Crash signature:
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]
  Call Trace:
   drv_link_info_changed+0x2b5/0x2c0 [mac80211]
   ieee80211_link_info_change_notify+0x13d/0x160 [mac80211]
   ieee80211_recalc_txpower+0x5c/0x60 [mac80211]
   ieee80211_assign_link_chanctx+0x182/0x410 [mac80211]
   ieee80211_add_virtual_monitor+0x17c/0x2b0 [mac80211]
   ieee80211_do_open+0x6d8/0x740 [mac80211]

Add an early NULL check for bss_conf before accessing its members.

Hardware: Dell Latitude E6430
WiFi: Intel Centrino Advanced-N 6205 [8086:0085]
Kernel: 6.18.7-061807-generic

Signed-off-by: Dhyan K Prajapati <dhyan19022009@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
index e08e44cae..2d480b1d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
@@ -1392,6 +1392,11 @@ void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_lock(&priv->mutex);
 
+	if (!bss_conf) {
+		mutex_unlock(&priv->mutex);
+		return;
+	}
+
 	if (changes & BSS_CHANGED_IDLE && vif->cfg.idle) {
 		/*
 		 * If we go idle, then clearly no "passive-no-rx"
-- 
2.43.0

