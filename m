Return-Path: <linux-wireless+bounces-34545-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALw0ALuu12kMRQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34545-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:50:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF743CB8F5
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C885E3004DF0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6AE3D3009;
	Thu,  9 Apr 2026 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="G17J70lM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7A3D2FFC
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742647; cv=none; b=Rtd5o2cVMTVoiM0CeuDPt/z9KbCuE/0M6MJ3oAiXLzd73PylWMRA7ZYPrOzL95EWMueWEsvNAZFyrPAU3vesbRYf7WZUFdHRN2QjoM9Ly0+EPDMnpl/LHryMQQ5/AZ5xplWF6iIGEQeRLsu3ECDBIg1lXvzlkukO9dQICe02tmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742647; c=relaxed/simple;
	bh=XIkGJiWCa4r1ZbYcQopgCa8jnS6tFF1rnVNmmXDKgC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGkTGt5z6Rw0i/jJt1llTQsDsSBEG6ZpvXP3CL6eoByCbm1X8fwl8khFF1QG8GRTjZwfcOPwRCZk9hUtQ/hJ9YnI2DhJlU/TbvH9DXCrR2QCXV0ADytnrfo4lqqfKmyWNm+dGIfkBimABU3rGFIiNdte2sbI9En7qb6emJ0bnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=G17J70lM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0046078so10037665e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775742642; x=1776347442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7h9p929BYl07r3Cda4pGu8KbwCVQu5+pGBlu1jL/LD0=;
        b=G17J70lM9nlGU2WAceyJXJ9XxP40c0ApPwbyW1fbudqR/r5X3TY9wgrSxczUpSwJR4
         u93Rm1vejdYDn3kpJyS/a8hdPhOx0Y3akQ32jCK/m45+7puLqU3SYyhebK9YJjdL8KjD
         Mf28zdbWt7WPQOXAkEFl3qDsmTH5gHJsBqhsYE6gXke6UqYHl1s2EMQ55JNEta0+F05R
         ZQow9nSuj6DcvS8mMsN4uaBO7Vkd2jWM/ua4FuK9l55dE41GT3sMNcTkFXjKu4oMb7Ar
         Y/jlI9lUw1glunoX3ClPKbfYImYnI1DxpDDebviJt3DYRE8VMDCUlsHvwAY36e5p9gPS
         QyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775742642; x=1776347442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h9p929BYl07r3Cda4pGu8KbwCVQu5+pGBlu1jL/LD0=;
        b=F7Fppv/If1LzQ2pCnYO9lEPOf5CVDVmF7t0AUlog82609pVGPYfH7ZcuGr+BYcOgB3
         WyfDOZkL/Sq0anA3ad8xuWSpG2N7hnlaNKg1lr/KoKGyq3SE2iUnDhsR3SrN14rqfPC+
         Jad3SM9lf1W4RnDHibSdRZ+XUCZnIupGtwg9R7hdl5Q70ikrU2ZoyNYIXzpA5T0rjEWl
         n3zd7rxSLoimtSF9Z3ZBKjHt9+HKnsFON9ksSBuU91ehORuebG/MXc/SEvaWeQ6iK2Pb
         Xk+XBW8tMQ3TGvuNF+BmgJbEdxKdSFomLkHUUwag9NVMpMlzDan1Zti+/dG1MHeSMrwg
         VQpw==
X-Gm-Message-State: AOJu0YzlDzyxV3Ujhg83bdKt/EnMNfMZ/iF2LEmDo/w0iLFDFzYJhJCo
	ytX01RrT8hphDcc9emIPY8YkJFo52RjOEKHiBJx8mkb1U+seAvUxdbwz70Kp9bYLpYw=
X-Gm-Gg: AeBDiev907P2G2MuI2k/hDhr7qlvPBUt+e7rIG5Ebop6DW6JfWeBwIoHDmFTwGe4D3b
	Joj0hriW9Rc7CVI6QNxw7DJul/Rfmz8TCN5Q6hZ/2LwTNqM6SPpm8Vbj0syWsmSgb37zVVTtc7i
	9ANyg+Phgt6Brv9v8Qc/VEL8GK+5yG7lHxq47l0D2e+HJLofV0Ilpdw3PMSjghho3awPL6Eeg9g
	f5fuhWcjrVR6YCrSUXaeyHW07EaJlBpjKPqLpf8hNNy1ktW3THbxJ0d6tW4soNv/9dAOg+Cp4n1
	sePJIHDU8zbPzPDtWDN5ERy+KW6EYYGg6stetTWh/zoBmzJjBQ1Uep+QeGBF8T8E6azKkVfJvuY
	QxXREduGlqAIsgZ+rQoqXgvpaDIBDC33j7aqblok5sRgBVItf66xXhzYxOre+S7vLQ+9IEnXsYG
	KIX0+kdxuzHyHJ84F7tuhBUd7Kf4ygsgjsl7UFzZ+BOUMnxLs+SD5FFxPI0Mw9Yg8cwNos0cOk9
	ahwACB1oTv2ivhHZ11yXko=
X-Received: by 2002:a05:600c:6488:b0:488:c51f:e04e with SMTP id 5b1f17b1804b1-488c51fe159mr108483435e9.13.1775742641600;
        Thu, 09 Apr 2026 06:50:41 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cf9e8808sm57815625e9.5.2026.04.09.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:50:40 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v2 0/4] EML Capabilities compliance changes
Date: Thu,  9 Apr 2026 15:50:28 +0200
Message-ID: <20260409135035.4018725-1-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34545-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,freebox.fr:mid]
X-Rspamd-Queue-Id: 7CF743CB8F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is some discrepencies between our codebase and the final version
of 802.11be-2024 regarding the EML Capabilities field. Given that no
driver supports EMLMR or tries to use 128TUs transition timeout, those
changes should not have any real impact. 

---
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
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |   4 +-
 include/linux/ieee80211-eht.h                 | 113 +++++++++++++++---
 net/mac80211/eht.c                            |   4 +-
 6 files changed, 103 insertions(+), 28 deletions(-)

-- 
2.43.0


