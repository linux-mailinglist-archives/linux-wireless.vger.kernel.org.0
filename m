Return-Path: <linux-wireless+bounces-37676-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cNaaESzgKmp1ygMAu9opvQ
	(envelope-from <linux-wireless+bounces-37676-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 18:19:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF171673672
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 18:19:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qBxuD9Vd;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37676-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37676-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9F58301A160
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BC329E79;
	Thu, 11 Jun 2026 16:19:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838541BD9C9
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 16:19:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194792; cv=none; b=ahGjCWAl19vQwpXsWJyvbEAZhzDt9LLn5jTNP3FM/DtS5oibk4UOIvSioejQWR4JnJs5hnUmMGUAQCDkgoR11ujYxb1GpqbA/L3PcFYK/DXeDglFNYZeQECvZuaeAagSPQN3gzObSxblp7gOcExfNzNm3xGACQf0GTfANHaZWgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194792; c=relaxed/simple;
	bh=xVCJaTuVcrtOSaRuVwAcXv0TM1mB7bmJ6+AnP6NSCVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiseBZkQVLjiw616pVeCA+7IRJPqvspYzq0OWJH0+hRu5MLaJBElE958bsB/CJ+FbTlkMsZPB0poSUXwKouqJ4rwIK5RYzraoTA9WoY9aaGDOf7r2igd7k8dFggNGChvkjqkNwNvOzzlQ1kQuHx7ZBbv0iRLyrFF0WQE/VPWGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qBxuD9Vd; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c85ba774551so3019880a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194791; x=1781799591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEBd70AzdmtVIvO4JgiP2N9y8ASTJUcNRJzVSW+CidA=;
        b=qBxuD9VdwUqMET2whBKA2l2iQhCzamr+2xMaJkpYrRQ3JK/Sk5vLtdO6w0oP/s1xRw
         9xn4I41iBm2JR2YwpKegNeDjB5PVvT5Bi9UVUU2+zaLcKys9xOSf0dL8614Jb7F1Q1xN
         IePaaJE0hXpAQrvgNHdETTmc+hPEjiUzapfZOizyZaTP4tGouMlJeN30fhSuu7ARr61f
         yaNPDlm8J89LpuhboogZE1lJdinBWCaaTIUyIOUdldEZWiYCsvCnqJLoNUoPepL5OUxl
         ckVMZM+/LR3gW665Lkf84DLPTs/B+ASiQBfhUNTF9hA7GG3lOn4qoRhwsC5RRwjM5Lvv
         ZPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194791; x=1781799591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iEBd70AzdmtVIvO4JgiP2N9y8ASTJUcNRJzVSW+CidA=;
        b=GImE1I74BpN/xilHb9l0qhDUj/i028OuaoVFkEWtBhRhfjgENeKp5k4WqixsJarBW8
         ZLKPS+qoWwuuBbmmG8nbhNnWZVGMdh2lWN0jaV3I+sIctW+mCDTHEdtrnosIacYpKcS8
         V91cnOV5QKM7rpzxVk+pSnJZ+pX3fRBXmG9OqlNT/vz65yPV/D8MYNpbIp0lYo+N/huJ
         BKcyoFNpTLNw79LSzXHuj4rnZJ2rAWDjpWixtazjbFJvmgZhabKCe2On1Sdq5kPWJbTB
         nzdv39luDdL4HnVQ1kJf0ALVLhM1qs0wFTSbClZyi3dno5LVHCD+gOa8+YZChGJzHICC
         phLg==
X-Forwarded-Encrypted: i=1; AFNElJ9x4cvSNZFt65DlhRSsfhsvUvfi2WknLjj+GxUhgsA3IK/Fjhds2UR0HHPQq47wQolIg14RMip1hIo3XfImUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd4NTv/d4zMcQ50K49SbZ2iF7QgLGwc9YB6Jlkuu7U5mc2s9CT
	64mmO9PgoL52g9sp8a2Z1LtIBaCRqLzwuMSzodjVN970GzblulmV2Mej
X-Gm-Gg: Acq92OFpS28G31eyqYLffv33vABIW6hU6AdU5iH3Tz/iFsVtqvtxMB9pLT3Mh4XbLID
	sUFqsag7tN5Q1YrjR9mg2gCRyZzK0hBO/rE70uCWrsDUjXl13XmBSHpCVDiBRluSQm9v2LrKusp
	yGiSdGWtdPSUvpTuR2Mt5VRcHhkyjrSn3Hl5UViUmrmGb1GyPHwTe2cQrnQwEDdRAiBhBjOLwp1
	6wkSlYbs8vPdo7EuwNjkW87AYpcWLJWGApmoCp8NLo9yZiqGoDNRB5WYgOBg1mY5Cy/QmAdUNhB
	8xuGpYBPzDlxW02VupXfa+EHxrOM1XIEB9wxKOBPMZ/ycNeSmNXwdfvLN1o8myio8mSBunvMMXa
	n0hkWQb2+45iYnJgn/NbxSDWbDXSSoMxD/avp1jLHrCZpkQellVziQu78wUXuDQHfsqbHUdiAwZ
	viVe4iFm5cDjXiLrE0gJBhP3ceExOBv6xt1JNvjQSv0CjAgc4B48AtFgZVAxvJVvA=
X-Received: by 2002:a05:6a20:9f43:b0:3b2:86a4:b01a with SMTP id adf61e73a8af0-3b5e339bf58mr3899101637.30.1781194790643;
        Thu, 11 Jun 2026 09:19:50 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865881640bsm2871231a12.26.2026.06.11.09.19.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 09:19:50 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Pedersen <thomas@adapt-ip.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH v2 0/2] wifi: handle S1G and extension-frame RX layout
Date: Fri, 12 Jun 2026 00:19:44 +0800
Message-ID: <20260611161943.91069-4-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260610162700.58722-1-enderaoelyther@gmail.com>
References: <20260610162700.58722-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[adapt-ip.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37676-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:thomas@adapt-ip.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:enderaoelyther@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF171673672

Hi,

v2 keeps the mac80211 RX fix focused on the extension-frame layout and
adds a small cfg80211 companion fix for S1G scan-result TSF handling.

The first patch changes the RX entry path to validate and linearize S1G
beacons before generic RX dispatch, route S1G beacons without regular
addr2 station lookup, and drop unsupported extension frames before they
can reach regular-header address handling.

The second patch keeps cfg80211's regular management-frame TSF read out
of the S1G path and derives the S1G BSS TSF from the S1G beacon timestamp
and the S1G Beacon Compatibility element.

For process clarity: I used AI-assisted tooling for data-flow tracing,
state-machine analysis, code review, security checks, side-effect review,
and patch drafting. I reviewed the result and take responsibility for the
submission.

Changes since v1:
- Linearize S1G beacon SKBs together with management frames instead of
  using a later pskb_may_pull() check.
- Keep the management-frame and S1G beacon minimum-length checks tied to
  their respective frame layouts.
- Route S1G beacons through the station/default-link RX path without
  regular addr2 station lookup.
- Avoid repeated per-sink S1G guards in the address-copy and MLO
  translation paths by invoking RX handlers directly for S1G beacons.
- Drop unsupported non-S1G extension frames before generic RX dispatch.
- Add the cfg80211 S1G TSF companion fix.

Zhao Li (2):
  wifi: mac80211: validate extension-frame layout before RX
  wifi: cfg80211: derive S1G beacon TSF from S1G fields

 net/mac80211/rx.c   | 34 ++++++++++++++++++++++++++++++++--
 net/mac80211/util.c |  3 +++
 net/wireless/scan.c |  5 +++--
 3 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.50.1 (Apple Git-155)

