Return-Path: <linux-wireless+bounces-34571-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAk9KX+u2GljgwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34571-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 10:02:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A33D3B5A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31657303589C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65B3ACA48;
	Fri, 10 Apr 2026 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHvc4vRl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC13AC0EA
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808038; cv=none; b=sp3nMMp59qvUwihCQE9yOWjddL2gT2opjC+lWeEIU/XmYLHDZzyoxTu6QMHv3ED60kLylBFaQwD5bzBO4GhpCKn/ki+Jjmd6z63hi5f1w0xN5oWoSrdrXtAFP2krEkxkmIBAYwC1bg7V/vnmWI+kdpzzROQFIBpPVmQrEJvHZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808038; c=relaxed/simple;
	bh=tWS4LbU2c5nYK5YqT4Y54vhJSCXxvsPaVcg4E/6qS+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8ZoPPHqJCvUIWuw7tKe/WNz+GxkZtPvltf1ilPI8GJY3vbEF6kfskRl57OCPlj9ubipuMqHevxAKL3LA2RQNmi9+/UNQJ0tlpU8KQPQJVRRCKUy4EUbDx1VnQXAhqpcoV1BaGntfxdZkZVlPTe9sY3V06rf8gTXtlv47kk2weA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHvc4vRl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d02a71526so1021063f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 01:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808033; x=1776412833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbyuhMHJvyWon1smmc/yoTt/78UXhDJ1O5+Cuc5BjPM=;
        b=PHvc4vRlkqm/XsYsdTEdPQCuty1hokNjLsLC1B3a61tV4JtqFD7jX3BrsK/fSRW7x2
         xjHrHpqVLs3Mq2A58IVUs/xYHleib5jgmetILJzk+RWpkXWrRvFHqIl54f/e4VCbcHXw
         WGYxcvJMiuYsPrpu8uj1CR2J0GeWNAvjBZJwnQXgQ7E6VXb2FsbjPvVagDNADeuqkPsA
         L6rOqg/we0f70vuWOOG/QlDeHxX7XA8npVQxiZjYhfSZaikCrC9e8McQhyXDTFOOcGdX
         e0jcsjJI8o532B9pGTXELesT1rlFARH0uws+ld81/UzOu56Pipo19z03BckaSdfhVYWK
         f/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808033; x=1776412833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hbyuhMHJvyWon1smmc/yoTt/78UXhDJ1O5+Cuc5BjPM=;
        b=AYqVxCmJ7W154HAXog1L+JTOXd5Q8V2AMROI6MImdfYRjhVrXSN328lliqpE4nX4dk
         HJtKLuaXKfmN2Gv3bMMhmg7Ou1bwknX1iQp5u2oGZKZNJQeDq47L/pknnzVKIUuuiqgK
         xAyvmUyVo5+CIVygy7idFbj2VoOgy64TMv9drM8KuUoNCo7XeEEX0vHIqyIb9vr4oksF
         u9cBeIKCgvXXOjeOhznxavI+zksKKXoeXFSr4Q68jllqfLUaffp9rlx0+cjEbelAa2y4
         PtJK+g+mj8dfg5kQjXeAaXj865PV3cFwzdN6Mg+DoJ6stN4drAoNZJwDMsQrvSpbECEO
         mY+Q==
X-Gm-Message-State: AOJu0Yx0xy1XjTevCqrIidnSWwHmKs2nAkIoGQUFJbBs6TQ7oJboFYe+
	Gk4gUrFoe4/pyFOoULFXymCTwHiZPCFB/7W8BiAz3tC07FLUvljp7kaHOBRyZw/F2y0=
X-Gm-Gg: AeBDies2ZrUth0OLClri1h0gePJt3pdqO/RNrJlP9ou+YUoOsTbuvhteEdMERFIvzdp
	dy2gwcV9gSqe5uyj5Cc6OxUO0H02ty+AcK2AV7Pi2Q3bkRVPLZWeJn8BBdQ3r4xHk3bezChAOjf
	diNVxvpzDprNtQzaTssCbGyc9i1bd9jzzrMnc+X3/ex35pSXL9A81GHVTbB88Rt4mYdTiNkkN/+
	UKOV/pP1PEJsfBcX7W7p3v0hsYgh2HRlE1SxNKSAw2UVhCxtx9drBOVXFrEv+mo+UcLVisPWQcV
	SFTlAkU9rjem+xS29riHQlq4aRv5cM0hhzylvzoo2ztKOTR7LOCS6YuFgpFKxhCgEfj4rSgUWDw
	pqkOSfjD0ebwfyagcndgl7fQVvnyD5U7fsIaObpZG+fqv2at6n3JGGrkZw2WYl71tw+V+Z+SSLK
	6gQk/q715ffR+7oYA=
X-Received: by 2002:a05:6000:420b:b0:43c:fd18:a30e with SMTP id ffacd0b85a97d-43d642b4653mr3018128f8f.35.1775808031456;
        Fri, 10 Apr 2026 01:00:31 -0700 (PDT)
Received: from bazzite ([102.128.175.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm5891151f8f.35.2026.04.10.01.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:00:30 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	linux-kernel@vger.kernel.org,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH 0/2] wifi: rtw89: fix RF calibration for USB transport
Date: Fri, 10 Apr 2026 10:00:15 +0200
Message-ID: <20260410080017.82946-1-loukot@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <795a8567fdbe48babc5cf0f2b5e10c0a@realtek.com>
References: <795a8567fdbe48babc5cf0f2b5e10c0a@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34571-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C2A33D3B5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RF calibration on USB adapters (RTL8922AU) fails frequently because the
timeout values in rtw89_phy_rfk_report_wait() are designed for PCIe and
too tight for USB H2C/C2H round-trip latency.

Patch 1 applies a 4x timeout multiplier for USB devices, based on
measured calibration times from two independent testers across 2.4GHz,
5GHz, and 6GHz bands.

Patch 2 makes calibration timeouts non-fatal on USB, since the radio
continues to operate correctly despite occasional incomplete
calibrations. PCIe error handling is unchanged.

This is based on Ping-Ke's suggestion in the RTL8922AU support thread:
https://lore.kernel.org/linux-wireless/795a8567fdbe48babc5cf0f2b5e10c0a@realtek.com/

Louis Kotze (2):
  wifi: rtw89: phy: increase RF calibration timeouts for USB transport
  wifi: rtw89: phy: make RF calibration timeouts non-fatal on USB

 drivers/net/wireless/realtek/rtw89/phy.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.53.0


