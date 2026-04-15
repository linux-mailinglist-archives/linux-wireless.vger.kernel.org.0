Return-Path: <linux-wireless+bounces-34799-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHVkOYeU32l9WQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34799-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:37:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABCE404E75
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA2403012E70
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965FE38C426;
	Wed, 15 Apr 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L69T1a1k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799627B340
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260227; cv=none; b=Uh5bDZeKALeI2hQTkuUo5kqJf3p5y03ZKwVOj1Y8LHAknLGdOKXba5d3V3H8/nxyqPk5f6KUPSNmskYZKPaX3faNyTzRFiu+DRzowIu+8ocCcouGFPBdfWK2aSf42xhovV3aS7PVqFlRUP4La2ZKn6tDl7H5nW33SaIPHKwEGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260227; c=relaxed/simple;
	bh=F7INEnckvJjD0F10khbGmpGo2YBACzsw6jOnVBgL5Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNHQZlG/bMt0Rsmzdmgk+e31o46j/YYOw93ZXhQPoT5t+z3IE6imMAH/C5rook86FTsrFN17NI79QhaECAbZ8tPvd6R5vE5j1Pp9OLicOa5v2Ew8em9P2Aundo2u1KuvdBw4NfPEeOOwIhgsM2X6iP3g+e7WRObkBUW3uIL1Mfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L69T1a1k; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so91024685e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776260224; x=1776865024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GQjuBoeAqKQj2cFOO5yPJrSHf6fHrn9+GEjE+vnXO4=;
        b=L69T1a1k06SuqrK7uTtASuwhM/nTxoQjI1diGZKUnKP97IWNUMTyTKtxvoiDxKCpQU
         +ViYbvLuPb1Gvmh1CJrKNKhOVyiDYAfCxjwcD/B51dXopxy+6MbRV4hxlh2CBY7A2d3i
         6wu1CHiKOFjzb8R8NW7Jknz5/DBmF2/d4HxDS7bmbJu0rJD+q8SdsjujOjUXOlVBKCD9
         ONNJg+B0/v2BvVh70W/IUZ9D4jdpqD2Z6irTx5TECEDuOrqIpwvYP4Z8rleix62qkv33
         hC3a1PHREqCHWjgO3GVqXjDEGyffrhrODrESVPqxc733AhaxfARsJhtK6j68VHpgpYC3
         sNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776260224; x=1776865024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GQjuBoeAqKQj2cFOO5yPJrSHf6fHrn9+GEjE+vnXO4=;
        b=q24qcraa3lXFy0rWU+k0ho9cwqDFmzUTxxPioLyqdkg9LBugq6ETS0n0pWvzJzIP1E
         4/wk7bZmrETCyj+5p+Z6EeWN9rX8RG+CXomhsmd+TDzyi03owFAMsTAFHOJfw4d87oAF
         4i/Ete7jf7uMp8PSkkWp2J/KdMYrQXzL0PkA3515WcbfJjCFbP7CqOBMLKqDFM+K99El
         Ex2mLjsjWLMLNrP12I+QwYMMmUDhm4i7awExXbb2qw1Y30xA4BbyYcWTcWKzMJMFdjg6
         ZjOOAqVdF/PzOQ9F2bZ3hP+4Zuo4t1huiLLc+5evKOSYpIOi4CWE4BaihrIH2uXafqxr
         0Abg==
X-Gm-Message-State: AOJu0YySjCK4AExtvEoW5Fighx3dKZlEUJm/6D9TLuwdtoEQ9MFN7f6M
	ZVvIQrdQnaCZYdu2Wo2iICDs+I+6Dj90UNjaIenLq0QEVhmr+GHIj2tOHFdqS6k=
X-Gm-Gg: AeBDiev3UJCXBuCyk0xw2ClASoB9UVas7UrPp/48YUIgtIDhBJ9/PfyXKkzuV9S0+qZ
	lvoD0asHqIGkiws8s7jN+3bwjgpa1UE27qMRNPSr4LV/99gj/EYajcb9odLcBcKoXU1p/8EreFc
	KxN+5esVof4msyG4tPnmLYIaL0R4UwfKR5pka2u2W82SkZ1rxljgSMA3dpFjXMoz4XtpnoYYE6r
	pEzFPZpzwak6GOr426mdl5KjMMXyMstwSyDCgPXbv2x4gHa9tcdW08u4DRg28/WzSYqT3gWMaK8
	Qk+1n9sCJgXRlaSDcpqCDGYyPR2G7Ax46bcksX6h+jyAPUNEWt/HzWDVLzYIE4CVH96KWviAxHr
	LyVQ9YY1cEm1svRC9/v6QwxVaoqB5BxO5gJQWgu4ArOYT+sNLSiEBisZb0s+fRVc18cn83loWw9
	HdB1yOCwgZJHgUyDFuk47ZgAHOrwQkvixVjv5zMDpkAnTJkMXms6CspGfgyu76d1n9BSGMZiBjo
	UYpj0GR3VwN+IkyOg4pgTB1I1Qx/pDyT3LFQUWVaG6QDElDPQPTOw==
X-Received: by 2002:a05:600d:d:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-488d67df531mr241412545e9.3.1776260224212;
        Wed, 15 Apr 2026 06:37:04 -0700 (PDT)
Received: from archtop.localdomain (92-242-248-33.broadband.mtnet.hr. [92.242.248.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f1d60ec2sm58105435e9.0.2026.04.15.06.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:37:03 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Szymon Wilczek <swilczek.lx@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	Dan Williams <dcbw@redhat.com>,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Jakov Novak <jakovnovak30@gmail.com>
Subject: [PATCH v2 0/1] wifi: libertas: fix bug in Marvell Libertas driver
Date: Wed, 15 Apr 2026 15:36:26 +0200
Message-ID: <20260415133626.172702-2-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,tuxdriver.com,redhat.com,lists.infradead.org,vger.kernel.org,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-34799-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakovnovak30@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ABCE404E75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Please ignore the previous email. I sent the wrong patch.

Jakov Novak (1):
  wifi: libertas: add wake_up() call to properly notify fw_wq during
    disconnect

 drivers/net/wireless/marvell/libertas/if_usb.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.53.0


