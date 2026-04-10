Return-Path: <linux-wireless+bounces-34624-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH3eBP4u2Wl+nAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34624-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:10:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C13DAE74
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DC76300C9B0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8263DF015;
	Fri, 10 Apr 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="d0DlPukX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79530B51F
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840683; cv=none; b=YVW26kj2qVwmO1bMHJQtYHo/H/Yeo04R1VRCLXwqKED4wKHOxedCn7sT0U21FGa6WrBn/4BdxKtJoRfL8W3nHo/nMuad9hWKzKEMpYDsytwbY7dkQSGwWb/hVl+4rwZPyfxeS60cm3hTz913sw3swYONuXZnDs+6xCsq+Zenb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840683; c=relaxed/simple;
	bh=axeKuAntnPvfuRaCNYK7w4FDtjO1jNkOdlrDe/+GjZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6+772gJ+8SFAqI+csfaQpaQ4ud8lRuxF1Qalyir1Z4ComU3F1T+cBS3xbwdQUNz8pp7ODLdweavQY2bd1jH0qMSmNA5uPdAzyxQCLWPV5PudK/ZV8k+7M5bRuXRpZ7thBuZ7zXKWnpZZu+4/dS8R+sOKExtohjVVm3OfMTil5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=d0DlPukX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfac48bc7so1580159f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775840679; x=1776445479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gFjv5IWB58r9vo2KuBQnJje/iVluIgenF5wIPB9thC8=;
        b=d0DlPukX7qaVT3PTK6VOgTbU6lqYaCr3u7fL4eqOOkdirmoQkpl84fuEfEI7GkDZv0
         +fHAz1IvjuwxwRftC/8U/LwknujhTRTAE4cac83oy0ep3e9/peKe/HeA5p3S6q5Nzk3H
         o15N6eAzeSYuM0cCd76sqJxeuL5J3i0GxEMalV5CcRIr3rjevnu58Y+dAtURrgw7DofD
         9+jTKpPVXx+sBig/SyhLOWkU1gDsaP42SeEcJFqTj29VlQ/xo2jNLsVzZx+333+XiEng
         ooVB3dw+Mtv7iFvIepm9gCDKsaLp+Kn0H7Xv39ueCJusZ6JN1bFaPpcFckUTgzV2fd3m
         m6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840679; x=1776445479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFjv5IWB58r9vo2KuBQnJje/iVluIgenF5wIPB9thC8=;
        b=fcfUPSFSCJrTsepVucVYauhTu2vf0UE9GOVaUh4dHQZfFzkwKsiiZM99AbfsoFXnoa
         6fV5+x5n02rjvCNkERFy6woq6mcooCiWG3u7TTSjRS1nDeDKS5exbucHIbnxGYbU/l8Z
         /FPBokRxcRNjgT1zgxUJR8rCcwpksSpILPxnu5QO2EcGzkgREhxO6UgRVcuAP1zwsWJ/
         xDv8iLaogj0FflGmiYRaGhzaqhKoITH8WFgQ7raTS2nVD5uQpl7wddEjsdRAEXNRebWn
         j5ZvrSTIH/fbudUPO2hecO0LTrJYDTGG4G18lqRozX/jo4N0mIIlkcEDaWw2pZ5KmQpA
         7JCw==
X-Gm-Message-State: AOJu0YzLIhoCpk6vhAVyPaFQcLJkmgin0iHCtBgf1YfG+L0MLgwpaehB
	FR10TX0lchR5nNCXntT3QhHg+/Rekg1r34ijENMIepKa9m/FlQowMV3R6YtXu0yD+Jc=
X-Gm-Gg: AeBDieuriv+Yjzku5J8a3jMh3B7GJ+qbmuxfuuZAcPrU9evpVFspbhi+gPy2EM8NiEl
	WCJ+naTdYthyjpgavfMV/11kGhSm7pmPlTI2a1FtLqdPKILLaqLVyWMOd5FZNBummPhBqi1wxJs
	xumslfDMUK2BJZgDGJQi8om0ZWacBUV8LMKj1Ou0GIocdCPmlD8ARngY0vXSz//c2Zv3VmSlFe9
	3O4jGEFQGWkA2Rncn5ZUUHsH2OXZhUNHnprAIAU+9Xx3xDIbCzlMMHeIyHWs+u/N5MmEJqm41az
	8CZxp970tOxBC+ofmjgznTCFH9Ucve32e0Hu4RQ1yJc39sJ+dimdekXM18Z1JTh9r+/0GGP8Rza
	n1c/2uQmJVzVBbqRvxsZYZR9QGVbomKETqvR8fVcaWltlRYjGoC50wOUvxVyCp2FPtBhSMZnXPe
	upylJdq0RqqvOTRFeX54nUa3vgsB4KDkdxJvvhxDka+d646BbPkVVdVhJuk0YZv6mzu1vNYds/1
	nb7vDeWXa4P
X-Received: by 2002:a5d:64c7:0:b0:43c:ef70:d694 with SMTP id ffacd0b85a97d-43d642dd0f1mr6400834f8f.51.1775840678868;
        Fri, 10 Apr 2026 10:04:38 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm8847200f8f.25.2026.04.10.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:04:38 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v3 0/4] EML Capabilities compliance changes 
Date: Fri, 10 Apr 2026 19:04:22 +0200
Message-ID: <20260410170429.343617-1-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34624-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 787C13DAE74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is some discrepencies between our codebase and the final version
of 802.11be-2024 regarding the EML Capabilities field. Given that no
driver supports EMLMR or tries to use 128TUs transition timeout, those
changes should not have any real impact. 

---
v3:
- fix typos
- fix incomplete renaming

v2:
- update the commit messages to reflect the changes made
- simplify `EMLSR_EMLMR` to `EML`
- add constants and helpers to interpret delay subfield in EMLMR mode
- add a small documentation fix
---

Pablo Martin-Gomez (4):
  wifi: Remove invalid 128TU transition timeout constant
  wifi: Remove EMLMR Delay subfield definitions
  wifi: Rename EMLSR delay constants and add EMLMR helpers and
    definitions
  wifi: Update EML function documentation to remove EMLSR-specific
    references

 .../net/wireless/intel/iwlwifi/mld/iface.c    |   2 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   6 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |   4 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |   2 +-
 include/linux/ieee80211-eht.h                 | 115 +++++++++++++++---
 net/mac80211/eht.c                            |   6 +-
 7 files changed, 108 insertions(+), 33 deletions(-)

-- 
2.43.0


