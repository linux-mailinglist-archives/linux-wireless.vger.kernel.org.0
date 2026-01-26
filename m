Return-Path: <linux-wireless+bounces-31167-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAQMApY6d2mMdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31167-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:57:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59461864CF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D209304AADB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE12C08D5;
	Mon, 26 Jan 2026 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa8pIHq2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11826ED25
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421178; cv=none; b=s2kfJCALyfAPzgQ3Ib2cmEH7iMYuCrlMELfezO+0Ssvx+Rf+cXjWgUnD4dRzTHQR2sc18mznJdP5oc/wDQqaW5ZFoEV9CU8Kd/b0eQUSw3MkiorxxCEWkTYk4XEhnKUe4JnnOCIWQBgPP8ddKxorhVai0Jav2ku48UFPld768lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421178; c=relaxed/simple;
	bh=dopkMnXJrqGoMIhsIkh+lOY7q0BHSMOQp0qskBgH+u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRavi6z/epcrIVZ4+hwJm+TGWhWXgKVjyA/MMw4DSfMaKr8n6iCxQ+AmzZ+5iHW5G91elqeTRqwM7x5fW9KL0dtVhEROpY8EtuvoctXNmCX6+ofklvTvdIfFgIPvttHrTJemE7cf9md3Tw3y3CzoxoVbdUqZ+qPY5DibxD7dnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa8pIHq2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1580044a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 01:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769421176; x=1770025976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EOH7Bk3yi9Z5p2JrcjL3dwH84n/1qqnxNyvqF5np6pw=;
        b=aa8pIHq2hwg6TLYo+cY3/1MElxsDAqqA1YywFcmz8k+qegzyfy7wAIa3NAfXjOZMYV
         hI1vsK0J3vQP56Uu6CIFIVVs7p5nEXc2vt9TdcS0koDInij8ND4hrSa4iWt1u0bLABSF
         W2BxT5ycW+BBZ5qs/pJrt8Mek5fmmrvNuGuUhKYAjh6Z68dugE7c3EffmBoW223uDLUS
         8ZOASZMO0d6HnG3x8jM9kXSju/1fI0RG+GB0rnNX7mUfY8A2F/3CVIBh04+EKGauk2QK
         raQ3k2wxGdwZVKXNYDsip4UFovhMW4zbPDQz/9qqXB+7Xp6XZH2B67T15goIt4EF4DdJ
         bpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769421176; x=1770025976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOH7Bk3yi9Z5p2JrcjL3dwH84n/1qqnxNyvqF5np6pw=;
        b=S08ZQMngVPgzbAPToA/k6tWsPkjKQha1FI1RbAyw1RmfdsdsPstceaZQC03bM6TRBX
         knctMTBeqrRNDOjE6ngzrEp7/MTREFN9KV6XXE9iO4Hn1F+1bnZdHT8v2hwJ0Aomp5+M
         +xxQwLYQKVkf/npIru6xyaoks1MLeHmkLVGPPeZyitR/MoAYSIxLSDd5iSFSH/FWgHG2
         8uoWKQ7hyK/yVRV/9pXA70SgOt9NWLtAwR8XVRtJic4AkneiduHbGbZgjb9b6thTVz2V
         d4WH66I6tK3cN7/ib/pF5SIwArl+fhRQavAs0s4Ey0+Yvq4yRVMWh6z0dH3K00ISLc83
         G2aw==
X-Gm-Message-State: AOJu0YyfSdSXAF6ipjNwIAp/VD8glWp0JVdyeFATs1ETw6lMGSQHSiw4
	fF+5edVpiyA/KllJqc+piQ9eNx3aUKZCpM3Omy0OcOLhjBo6/XYZZXY4
X-Gm-Gg: AZuq6aJChOVILSlnpX9/uvlaotBjMUSQaQylrTrQnmw9dKjpSyMzX7ByARYzDXmzo4q
	LJqz4bg5LCPPD5rD1gPL8TlBrW1yEkGKHdKOsvn5doaQK/UeWf2Bgt2hFlNPuH5SnE3smE7Bl5c
	GO4yUJ2dXmlbmQwFDcx67E7sTGM5GH+ikv7WrzjKOm73gPmA8l8T6R/awKJ9/1qhGJjRU3PHoF0
	Yot+faStaHyUaGbSfUgEndRjNoeHe+Foddy58gVQq3q3DkD1zDudOUeYNPNgynVC5gXnpcsLdjL
	7P4xFkASJ0Bz78fPYIteYQBQLIwJpMv/gO69Nf2I5phsPl3DgBaEJcafKf/YxdpEXJzmbF+BkDL
	y7DRebUScFL0Wr/fRIoH3ElwsrfL97rjSLn49M6RanZnR8vN2YaudgklihMTPOexc+3yNbXyKxX
	oiKR4zIglJrk48BrgdIgTaWi0EEyg6r0NaZ32q
X-Received: by 2002:a17:90b:1b45:b0:339:eff5:ef26 with SMTP id 98e67ed59e1d1-353c41a6b36mr3065299a91.30.1769421176499;
        Mon, 26 Jan 2026 01:52:56 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:1d59:cd47:36b6:dec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536f359950sm3187627a91.10.2026.01.26.01.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:52:56 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH v2 0/2] wifi: ath12k: Fix 5GHz issues on WCN7850
Date: Mon, 26 Jan 2026 15:22:42 +0530
Message-ID: <20260126095244.113301-1-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31167-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59461864CF
X-Rspamd-Action: no action

This series addresses two critical issues affecting 5GHz WiFi functionality
on WCN7850 devices, particularly on the Lenovo Yoga Slim 7x.

Changes in v2:
- Patch 1: Simplified approach - remove frequency range filtering entirely
  instead of trying to work around race conditions. Testing confirmed the
  filtering is fundamentally incompatible with single-phy devices.
- Patch 2: Refined based on maintainer feedback - only reset stats buffer
  when pdev list is empty (not on request failure). Improved commit message
  to explain why reset is needed even with empty pdev list.
- Dropped 3 patches from v1 that were either unnecessary or already fixed
  upstream.

The first patch fixes the primary issue where all 5GHz channels were being
filtered out, making 5GHz completely unusable. The second patch addresses
a firmware stats buffer leak that could cause communication failures during
scanning operations.

Both patches have been tested on WCN7850 hw2.0 PCI with firmware
WLAN.HMT.1.1.c5-00302 on the Lenovo Yoga Slim 7x.

v1: https://lore.kernel.org/ath12k/20260123155750.6007-1-bjsaikiran@gmail.com/

Saikiran (2):
  wifi: ath12k: Remove frequency range filtering for single-phy devices
  wifi: ath12k: Fix firmware stats leak when pdev list is empty

 drivers/net/wireless/ath/ath12k/mac.c |  1 +
 drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
 2 files changed, 1 insertion(+), 13 deletions(-)

-- 
2.51.0

