Return-Path: <linux-wireless+bounces-31143-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bLjsCf4+dmmXOAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31143-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF8D81536
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 17:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 894273000B00
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Jan 2026 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDBF3195F5;
	Sun, 25 Jan 2026 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFG7P+Mq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A24A07
	for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357049; cv=none; b=bcY8hfybvu8zD7PLJazcEALDSp4AG5qY0DygOCNWgCjEHcQZ+RPknT/nutok4X3uqrihTw/tAN5JnzV0RStBLOYs37LlsqKcUCFKI6EG8oikEZkaemK/CyPJTKgHSChwcdWcicUo0Q+aOkVf84QxELVsWXVr+2aNS6cgYJa+Ojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357049; c=relaxed/simple;
	bh=dEBe04r87bG/SKCyLIpnmkV6giYqbiXdaUjTG6Sn0H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmFM8OlhHakMhlU7MXR5iO17cPa1YdYv220sB3CL8NEHM4Xh7FKpIILMHbBB7vJ7DWnNNAHgEdfWfBjNKBdWLJdNX9nw9ZWXQA3xPx1PBAWYqDH/O+7o5vlVrnx0P+WhfUuw4m9Ea7ayyKjdridmr0g9X1uxruy4FUnJ6dnSng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFG7P+Mq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-655af782859so7569112a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 08:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769357046; x=1769961846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRUNZZblmwuj3fn0YgYeZ8f6ORcBCTrCbL2EUtdu+lk=;
        b=bFG7P+MqpiR8nsxQjVEdXThNI1Z/YCvr9VHS5qLCltLlsnQCLzSSgTE5VBQwfYYZfI
         bxB16aorlkZxyqGfCsWNx3TWEpNzqVf4OsyCZC2g/K20704tGddSXOxy80ajfGL/mDNH
         Bp4VcNOfjp9+LbJIf6mlMMrUmKrISTuElQwJsWKK9ritd246S34GsV77sHlcZZX5HCgI
         7xUwnTXq+iQXRadLsf59hpfe51wmWQy8QF08HIySRPe4m17ych2KXNGzRRni1RDDazCL
         P+FuUiRZfShjTKxc8PAjtHzwSO3YK8CPsjjB58oSpXuArPGfKITw+kV6De/QhtgGkPrQ
         XqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769357046; x=1769961846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRUNZZblmwuj3fn0YgYeZ8f6ORcBCTrCbL2EUtdu+lk=;
        b=SwLUbSpV4DaJf6HYlkaRa8p+OZQA7CAqeQvDj81XP4JLiCwgv6zdAVkKlOqdWsk+XG
         TBOXNXAGl+EHZv4RoLG5K1rAeE4k93NRgTvOFKsBGcZJEeoj8cRPoizE0aI3wnMMVICz
         DbjTYR57mX1piqwXO2iR7/aTXnVvgBlrBiqn5MkIU+tKlSmkARyXPHiOAs2Sf7tR7976
         G1w0eZhP179GcMMFLeIFIyJYGomXW2CD111EVIvVxu5gE/FIhCjIq3ymlqRjVCw58FM3
         klkhEGvxkkkuDe44FSQbF2aMGwwkD292kyhuJcSWFyo2WpFFgmkzlMHlVD6r+8fH9grs
         xD2A==
X-Gm-Message-State: AOJu0Yz8WqxZdNXmvvIogk8Vs16TMHmkh4RG7H9mhLXqCfpXeDlo7C+n
	JN+k0kLFgudPFM/Tmjbwe6yb/GT1zCfNqVxJ6WwhE8ALkHnSyp5xgwIP3ora6A==
X-Gm-Gg: AZuq6aKCM5RQ9wNNEroAklUV2lWf60VAy55PuEN20xwzFMz/8EBw+1hPAFK0BGak4JK
	JMbN6qZfEtyE44mB4ind9JUQDoFuVfXKnoSmISeycv+ekN1qsIB3sWiobkSOXr68h7CvGBP/Ypz
	zXiapdieeZP6pVfQ9OsrfF13y4GacUoqL6p8Ol2zZqeJnwa+opR1xKwSnahhqzXAvixBVVay76W
	n3cK6o6MFYfSfRozZHDAOOCxmWFasY/TYEC10ytmtulPjAcB0YjTZNcok3hZ9Qosa7jxxpTy6ym
	3IEycUAFw3swxXpnNVaC75DPkzGn9mS42cNpQQprIMJz7BQegeHxEEleYur4D5T4jxutSVY1Igm
	eLuUGKP4zG6hzoE93wrnK9p2yzQtS9AOappSkMkZ02zJBxEtqyfcL3NEOrBGJD6voGu6P+k/CAq
	JdukKzhfFJluUZ3y2PLW/xc0WPl4tiSFg13ALdxOh7QXM3qsiz
X-Received: by 2002:a17:906:4fca:b0:b87:b0ba:5d2d with SMTP id a640c23a62f3a-b8d2e8553ccmr148652666b.57.1769357046093;
        Sun, 25 Jan 2026 08:04:06 -0800 (PST)
Received: from hp.. (109241135248.swidnica.vectranet.pl. [109.241.135.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b886a249e69sm408330466b.6.2026.01.25.08.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 08:04:05 -0800 (PST)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC v5 wireless-next 0/4] background CAC fixes
Date: Sun, 25 Jan 2026 17:00:28 +0100
Message-ID: <20260125160353.34102-1-janusz.dziedzic@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-31143-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[januszdziedzic@gmail.com,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9FF8D81536
X-Rspamd-Action: no action

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

 drivers/net/wireless/virtual/mac80211_hwsim.c | 64 ++++++++++++++++++-
 include/net/cfg80211.h                        |  3 +
 include/uapi/linux/nl80211.h                  |  6 ++
 net/wireless/chan.c                           | 27 ++++++++
 net/wireless/core.h                           |  4 ++
 net/wireless/mlme.c                           | 51 ++++++++-------
 net/wireless/nl80211.c                        | 14 ++++
 7 files changed, 146 insertions(+), 23 deletions(-)

-- 
2.43.0


