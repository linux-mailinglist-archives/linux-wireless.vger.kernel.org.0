Return-Path: <linux-wireless+bounces-36003-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPPTFfca+2mtWgMAu9opvQ
	(envelope-from <linux-wireless+bounces-36003-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 12:41:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08A4D96A1
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 12:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABD233016525
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E8432C8B;
	Wed,  6 May 2026 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAEb+RVC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03F368275
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063965; cv=none; b=O4cCKW6RBWN5wO4t7+K2skSIqLHcd6q4eDrdXpKtHfNlIy9pXPae/rgaYvQz4JXPxqYs1gkOxCNzb7NBFqS0d7LfC+7+qj1mjx736ETodp4zCiEyK03uXUEb9C52ywkT6+FaAy9O6OeyF1+uEZveFZCi+vX21yZyfuU0DX151XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063965; c=relaxed/simple;
	bh=XupBoArivsjxeGGRm2OUZfW/AIGfMQJ8DINGCf2u8Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgAgcsDfXy4iVgt2flTewKz0KJ0HsCj6AOv/tonW7q5fVovSE8WUD/bIP8GE5oUy9l4zBDNP7kE7n1OXxD+SifcC/pcxQbN/SmTDP1p0+G3sU0hVc19odI4ZKy7n8z3YqRr5xXgleP5BCFGTRilKvlywgVev7YkjQSUZx7u716U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAEb+RVC; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-415b23dd6e5so2128119fac.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778063963; x=1778668763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsk1ul1Oa0zrLcZxzk/m8VwtUiL0p8Vvvl1s9fMlKeY=;
        b=XAEb+RVC6rx4Ki/gfKwMA9mY923e5IZSVOc01voDWOrvDdLzT/s4eXvUXDTi9156ly
         O+3klCUs0OK4fpZnCLaLLVHzkfE5VnUuKMT7PGRQDhqVeY+oXgQWApjBp2MlFuA4gdmw
         +elsHXHKw6SEB85V9Md9IpROazF5r8Hx6HedNtMhQrvuOiul02LKPW0TbNjcyOYDiXuD
         VPpWYKjmruoHCnTBH2V9GxBo//r47mh+G5JTiaQjjw9uclCup1V6RBO9whDm3ZIFNYWS
         n/gidMwKjK60DWLp8U1nzdXVWw4AR+3kbbHJJeYmAVewD7W/SWvtbah8GNpCFH18L2ZP
         WDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778063963; x=1778668763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zsk1ul1Oa0zrLcZxzk/m8VwtUiL0p8Vvvl1s9fMlKeY=;
        b=fM5Otj6z2xgeqkh8qdsRLy8hUysQUzugr/PPmTo9WP3YG0W6MWZw/eRs+bXYHXxT6H
         FdH6yV2blU8wQlUxW1AGXYGjbBl+B4sJ1FmEpPzJD+UoOtGw0eOLHoV/f76YV0GGirVe
         xpzP/oINNdUlPlmVCl7G4j/VAL+1zQmeOohbJNCiY70ri6xeYWjqmyY8UD8I6EreDp4q
         2x4wuBhcknciUNY6y4JV97vTib+UFOWwvj1DCqdTQPi6uO641DMoaFPsUiinoiL/23c8
         3A2QD/wLRvG8hpnZeEnTZA9A68G1JCLRgeGWCgRR8J7L9XIAvRmUlHhXiDBJ6Fz3oxOR
         t/mg==
X-Gm-Message-State: AOJu0YzTvz62GCM4Y1AvqHmKHBMfJGQWo1RcACvo2Rdf9/366tNXS9NM
	jnOGwlMcE4buT6fsLJHAe7uUk8n6dng/N/rQIATLmvPrHW8UvVGkwdl/9AS37iFgy1lJgA==
X-Gm-Gg: AeBDievbm8gJIU15a3r2zW6jCxkhV3tMp4j6r8wF4HCMWanROg/FqLVroNKKsYlrUjo
	5AJAo+lKqIfpN3H25hGEUfTrlcyAoaOR3C0JJd8V+q97Zu78dCFoxtsQKSorfNPQzlclojT3jXm
	LQQZP4OnGQFd+W4l5vSPW1ngSuamvddofbihz+Re0BknS3Zxbo3s0j0DbD0bLPIrFbeoryhihOl
	YZ1zpEh6RPqJOpi291LYsqcwgTRuLAO6k1ippUEawrUiiNaO69wO9XqHz0lZRpqGPNgzcSIHD+p
	KfnVDdvm795lgSXnVajFuQf9NtIYd9Haa9QKez0dGAm6OkbPv+7LNOoP9r64Ww6DF4Uuiey/Wf1
	svDjesMjN00GQci+aWQG2Gd08LEi/m7rI1rSJenZM8TYNtXZUx0LdvDDa9LAE85P1SLRof3m6oF
	FBoOnuR2pmBLx1qbdgdTNNUQuovdBD4G4OUZIB
X-Received: by 2002:a05:6871:b23:b0:42c:81cc:6263 with SMTP id 586e51a60fabf-434f6624af5mr1695445fac.39.1778063962767;
        Wed, 06 May 2026 03:39:22 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454cbbbd7sm15307827fac.10.2026.05.06.03.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:39:22 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: cole@unwrap.rs
Cc: linux-wireless@vger.kernel.org,
	greearb@candelatech.com,
	miriam.rachel.korenblit@intel.com,
	johannes@sipsolutions.net,
	Minxi Hou <houminxi@gmail.com>
Subject: Re: [PATCH v3 3/3] wifi: iwlwifi: mld: skip TX when firmware is dead
Date: Wed,  6 May 2026 18:39:07 +0800
Message-ID: <20260506103907.1783441-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420174406.128254-4-cole@unwrap.rs>
References: <20260420174406.128254-4-cole@unwrap.rs>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE08A4D96A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,candelatech.com,intel.com,sipsolutions.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-36003-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 20 Apr 2026 10:44:06 -0700, Cole Leavitt wrote:
> When firmware encounters an error, STATUS_FW_ERROR is set but the
> mac80211 TX path continues pulling frames from TXQs. Each frame
> fails at iwl_trans_tx() which checks STATUS_FW_ERROR and returns
> -EIO, but iwl_mld_tx_from_txq() keeps looping over every queued
> frame. This burns CPU in a tight loop on dead firmware and can
> cause soft lockups during firmware error recovery.

I can confirm this on BE200 with a tproxy VPN daemon that keeps many
concurrent TCP flows open.  A firmware NMI causes 22-30 second
system-wide soft lockups affecting 11-34 CPUs.

Setup:
  Intel BE200 Wi-Fi 7 [8086:272b] rev 1a
  Firmware 101.6e695a70.0 (gl-c0-fm-c0-c101.ucode)
  Kernel 6.19.12-200.fc43.x86_64 (Fedora 43)
  Driver: iwlmld
  Workload: tproxy daemon (Go, ~50 goroutines doing TCP write())

Reproducer:
  echo 1 > /sys/kernel/debug/ieee80211/phy0/iwlwifi/iwlmld/fw_nmi

The call trace consistently shows goroutines spinning in:

  write() -> tcp_sendmsg -> __dev_queue_xmit -> ... ->
  iwl_mld_tx_from_txq -> iwl_mld_tx_skb

carrier stays 1 throughout the entire crash, so mac80211 never
stops queuing frames.  The lockup resolves only after iwlwifi
completes the firmware SW reset (~22-30s).  Firmware occasionally
crashes again within 15 seconds of restart, causing cascading
lockups.

This matches exactly what your patch addresses.

Regards,
Minxi Hou

