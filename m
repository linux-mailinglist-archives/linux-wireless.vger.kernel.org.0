Return-Path: <linux-wireless+bounces-31427-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBlyNfJ8f2nMrwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31427-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:18:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB0C669A
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1C83005E90
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Feb 2026 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32AC2441A6;
	Sun,  1 Feb 2026 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT+qtaWf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69848242D9B
	for <linux-wireless@vger.kernel.org>; Sun,  1 Feb 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962734; cv=none; b=Qg2J1g7iG+4VuuXQVOzkAN2yDOfhPgdTGsB8w6879Dyx7rDvIxKv3WxS377O6nDBPiY1ZcG7e+PHimJb7V1+6iSsy0wmW+90P0YEZrycMSQlnQfroWPWyyJxj0rans5i35NtfxxLP3vjE74vDSg0zvnJnuuRGD8wm6w7uMR/7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962734; c=relaxed/simple;
	bh=bcDCJqX4gcBXLIOqVdUJLU8+66j0r3m+sMoACIVHb5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxcVN8p2M8086LCfYovKsH8JsZqD2+cCgdDu9sf1ywxacQUWSDeFN2aB/DKXTWczPDND75toC1DzHJ9YvxNJ2A7S1CUgCe+dUwHwTKHnimei1bt4Wuhp8Zdj5HSblSo3PvI0RomhOTrD5zsgJwlRogPc0CzUL1IAcLxhD3OVyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT+qtaWf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so34960405e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769962732; x=1770567532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KBa+kVU233qEsemMMeYheyagIAAvGeyA408mHmfDV9Y=;
        b=gT+qtaWfoe3/oeDxwB2JLHRvWH8Fcoj6ZvKT8CzZAeATnJNHjhMBRM5AQOi7gC14e6
         CiQIHD061o6N2R8SoirMJY2rEuoJOLTJPNpr7XOhSYJSE5Zbnl0RH4uFEsR5f42l+aq3
         MspzMhwu6QCna5XiNIWzUrOHlDIZ6pB1z8MFqQsA+eNn4GBq/SMJiTTZgbXfWyUK4Ncq
         ut8ZCrpKLfiHczORddfczc3P+NRFnqEMr2rRnrAPkp6ttkXl0EyG9QiEDmZgnAoSsl/w
         V4KYvNZhMeW93l4nvsbQBJQKVqMjzhc1/4q12iHfogsysDUZVMXwUfJ1cgnZ6o8iKwu/
         PubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769962732; x=1770567532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBa+kVU233qEsemMMeYheyagIAAvGeyA408mHmfDV9Y=;
        b=MKSLIQeV2Vk9AcryQlbm8kBQvsZyZz3ndeLKqbvoxgKGIUK3D3IaDeANxwtelF+VlJ
         QbFKp7LkG3t1E905efwQ1rFGUS68T7uvadAzS53UXaw2KXWsy2O6xEcqrqKjnWRKsB2S
         X4SzEMGrzphllEBQgbicMq6XfKlSwMHahoPeunCBVd3rc1HKyqR+l3kBFwSg58BmMqfR
         L/RaseEWOJmF0zWFBhK0Zk3AnNSmVHvkOxIoXZg2vQ+TnrYxbGJatTDO7z78upNogLRh
         2w/holy9R3sJIrbbGTo5PTSnp73ukRlXlt4Fgh+J38tqMDToYkxN3csaPlxKEd7bBdIe
         +5zw==
X-Gm-Message-State: AOJu0Yy+dwbleRGmpie0JZ7Ea8TU0tXD32rqUhtHGr3UCsBtR9NCG5c0
	u9GRH1DpDmRp1IFKwO8YE+Wv/LTmvD7E4Q04TGLI5ppx511uqtYtPmI14vvRhw==
X-Gm-Gg: AZuq6aL+Q+FvMx/velssD31IJrN+g12Gb/xgC4WpQ2YNmPWPuYpCSYZqyCtQv5/dw/M
	suv9YxRmRB2PH3G0A9rz+JOsQh24jzydaVPUgBdnDconAyVdThzqxUIjGTgectGxUQE6stYl9TV
	t/+dpt1PjG/wfhPdip6imWfFAk2i06bNtUyDfKfPOsjClOQMyPFf+rBmx+UGO6AonzcSN0LWtcr
	coosWakc9uOgBQlzltR1T5MeVEM1iKWkqwqT7gRbsyox7TFAhqwWrMYgW85BkRifFtV++BBm12h
	8J4iwp9iDGo3cJnQ+yJbxJkpeIvFGpyykWUjhStrk+LkrmUCqOKg2KBPKmtERmEyeGNb6HqtjCV
	rQejk98wVBBSjU5Avf7XUi0DQKXOjIkq2auxNJrrMB63ZQBxjmtnOR1UcASfjCETj3Prm2C4J6f
	rbGtJjs5pH1/ZVPdZt8l5DQhjfp3jfbuuv93+P3gMzrTYoOPt2
X-Received: by 2002:a05:600c:530f:b0:47d:3690:7490 with SMTP id 5b1f17b1804b1-482db45ba1cmr116015185e9.9.1769962731510;
        Sun, 01 Feb 2026 08:18:51 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce93sm36368545f8f.24.2026.02.01.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 08:18:51 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v6 wireless-next 0/4] background CAC fixes
Date: Sun,  1 Feb 2026 17:15:38 +0100
Message-ID: <20260201161836.16506-1-janusz.dziedzic@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31427-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71BB0C669A
X-Rspamd-Action: no action

V6:
1) rename cac_ongoing_time to cac_start_time
2) hwsim add background_radar module param

V5:
1) tested with mt7915
2) fixed locking
3) rebase with latest wireless-next

V4:
1) added proper locking for work queues
2) Added Fix: description
3) checkpatch fix (--max-line-length=80)

V3:
1) extended bgCAC cancelation patch to cover more issues detected
   when tested with hwsim, like skip CAC abort event when radar
   detected, or clearing lower level bgCAC correctly
2) Set CAC ongoing, so user mode don't have to guess if CAC ongoing
   For this one also have iw patch that will extend iw phyX channels
3) For test purpose extend mac80211_hwsim and report bgCAC support
  Allow to cancel bgCAC from debugfs or simulater radar when bgCAC.

Janusz Dziedzic (4):
  wifi: cfg80211: fix background CAC
  wifi: cfg80211: set and report chandef CAC ongoing
  wifi: cfg80211: events, report background radar
  wifi: mac80211_hwsim: background CAC support

 drivers/net/wireless/virtual/mac80211_hwsim.c | 68 ++++++++++++++++++-
 include/net/cfg80211.h                        |  3 +
 include/uapi/linux/nl80211.h                  |  6 ++
 net/wireless/chan.c                           | 27 ++++++++
 net/wireless/core.h                           |  4 ++
 net/wireless/mlme.c                           | 51 ++++++++------
 net/wireless/nl80211.c                        | 14 ++++
 7 files changed, 150 insertions(+), 23 deletions(-)

-- 
2.43.0


