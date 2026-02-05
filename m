Return-Path: <linux-wireless+bounces-31594-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM+vKiSnhGmI3wMAu9opvQ
	(envelope-from <linux-wireless+bounces-31594-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 15:20:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A606F3E15
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 15:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5ED530041C3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE73D7D6C;
	Thu,  5 Feb 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb50Y0zf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B3F2AF1D
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301217; cv=none; b=uQGY/5aNID15PZAuNnU9z4ADmsMUnAwGPKcpnv/aeDTknjVm2F+SMGrIRATP11ttgG2Nv7ansVOCn3vFmQ6C0iZR3a4hoUvOzCyOF1StQ6TtfAzVZZ8MGUNTwYDshxml/SrYdNkhwcjqV5ZJz3QhtTMfOv+5WDFo4vG96E3XFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301217; c=relaxed/simple;
	bh=bxvO7xLks31ccgLWrxL/csS3qq8QxjBoiQUECaL9oNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4GDxtPKicyHVbe7J8P+9L2L3sJk6IWA3yx2T/UeY0sk5anf5mByIXsLnkEhaMXKtURGRebU0os1S6g5QFmcRynyt75BDol6gdWDZCWY5LVDRdHO7gi/o1Af2OYmQmCArmuFx8TCVkP9/o4drgf8jAJoBiUxjylXackVVLZbbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tb50Y0zf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a12ed4d205so6929795ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 06:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770301217; x=1770906017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGrqiCfLQk/di+M08s9ny+pJsjwXXHZb7ewMoKX+Y38=;
        b=Tb50Y0zfb+5qBag9BTE4r6fjPq/nbh9mi7Ub2qVdPp+oEFTdTzbH4euutq+5Spsgus
         ZaO3ceWsMvlgdlWUhRy+Jibu1hRX2Pfy5k95f+Wk7rc46SQiVG2iVCtXfa7Z8eJshe3E
         T2mgd3j18CkTeLAZL/cRfeWRWIk9sS+DSMMMPEx0wNL1DRrGWYgT0x91fvDgq14WS4O5
         8jBGivjAe5HQoE2qE6GmQafTZgMffxWqITaS/EttAd2t9LpYBfNzY9Sy/LDMYWA6BjZO
         q+pOFlQGTrXy54PHnMRExDfMZw4tuJKpAWj6ZlZbo0AagQIzr9bWYZcHfT77xhCITvbq
         KqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770301217; x=1770906017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGrqiCfLQk/di+M08s9ny+pJsjwXXHZb7ewMoKX+Y38=;
        b=mRHsIrosN0jXtTdgNKD8vNsSXpugZn4P+K6juIRgNwk76QYaRUpi+BdHqDkW9E76uy
         FtCs44UluslS7SdwO581NuQ1k6FJWA35fCDip40Ng+t646XbEY3aniXPblTgyv2DEgZM
         JtCy6JDj2Fp7MnA4/yQdanjTXUHCrDx8gasDdxLudRHc3x2jK1v7H2rHYMGexPytwbn6
         ajV4P8wPmY5bchv0gYcQye7ODacKOe6sIN6vzdgbq4NSxYPyYFhgTeFK84y9+A3hItGO
         2Jx2q66Ra+EQ+qb1mFGBFQmw39MhteeD0oO8GPPpSIdNlH/5CJ2lIOpRtWj4YwQXG432
         SOQQ==
X-Gm-Message-State: AOJu0YwUMYALVceddl8JMmuhyCk1owZpFkKPSdF4Oz4DIGy04qF20cE9
	fZGO0sci7S6SswrYGF45O397VUTBdZdyc4OtqO0vyYP+9OhrouC0l5cN
X-Gm-Gg: AZuq6aLpudipsv/+L7WGhpATj379qYbKjwzmPRdlZc88DWKmPbmUFnHf+h+yzdbdjrS
	wo3DW4O7mLKXN7BIFrR0+pl6tzTIaV+M9Q/Vrjes8HwR7vbdXU9QmZXB2E/ZA0iLUB3wvxUDTk9
	tksJzibv7Xlp/R6DubEYVdO4QCrNtMEGGK2fRLeRmlVX5NN9oJSmDel3zAwmCHMb726JWgLLjBe
	kYqyCUZvgacg5/SHRS8482hEFssERc7pp+wc80KkYesSmeSPA8frKidAPNl20xUBVFOSAfb4Uqa
	qZYajub5Kc/AaMzFxIPQYx1RrwD/w7ccpQ9n/qBpar29s8Vcfd1XpF6Ec/i4nqV9NiOhitO0ITs
	CStuWT9LMmO93VaOZFI2d092mCZ4Lsf89R78V41Rkao3d22YrQMI2vgLBgr5yprn0cpRz2IC0WT
	Qx9oOA74Q=
X-Received: by 2002:a17:902:da83:b0:2a9:43a9:d367 with SMTP id d9443c01a7336-2a943a9d4c5mr22983985ad.51.1770301216922;
        Thu, 05 Feb 2026 06:20:16 -0800 (PST)
Received: from mint.. ([27.59.86.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1c08e8sm6367697b3a.22.2026.02.05.06.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:20:15 -0800 (PST)
From: dhyaan19022009-hue <dhyan19022009@gmail.com>
X-Google-Original-From: dhyaan19022009-hue <dhyaan19022009@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dhyan K Prajapati <dhyaan19022009@gmail.com>
Subject: [PATCH v2] mac80211: fix NULL pointer dereference in monitor mode
Date: Thu,  5 Feb 2026 19:49:57 +0530
Message-ID: <20260205141957.8527-1-dhyaan19022009@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31594-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A606F3E15
X-Rspamd-Action: no action

From: Dhyan K Prajapati <dhyaan19022009@gmail.com>

When switching an interface to monitor mode on drivers that set the
IEEE80211_HW_WANT_MONITOR_VIF flag, ieee80211_link_info_change_notify()
can pass BSS change notifications to the driver callback even though
monitor interfaces have no associated BSS context (link->conf->bss is NULL)
This triggers a NULL pointer dereference in drivers like iwldvm when
they access BSS-specific fields without checking for NULL.
Example crash on Intel Centrino Advanced-N 6205 (iwldvm):
  BUG: kernel NULL pointer dereference, address: 0000000000000000 [ 5295.135825]
fixed the issue by adding a NULL check for link->conf->bss before proceeding to
driver notification
Tested on Intel Centrino Advanced-N 6205 [Taylor Peak] (rev 34)
Signed-off-by: Dhyan K Prajapati <dhyaan19022009@gmail.com>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b05e313c7..190222c26 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -416,6 +416,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_MONITOR:
 		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 			return;
+		if (!link->conf->bss)
+			return;
 		break;
 	default:
 		break;
-- 
2.43.0


