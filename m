Return-Path: <linux-wireless+bounces-35763-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xcNlNnOk9Wm3NgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35763-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 09:14:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE64B1412
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 09:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E99B53014C0A
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2026 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410002D7814;
	Sat,  2 May 2026 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhOoVyTa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA5E54B
	for <linux-wireless@vger.kernel.org>; Sat,  2 May 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777706097; cv=none; b=CBOQNoJAqnNuw8I43VD1hwl3CtINEuuVgVzfBZth2n2dYScPzaB6Asu6+64VP9UppylmZT6EHQofu8kkqVAm6ibmoiuBdhWokZxRv5CtCocex3RnYijUMEzNjjwm9CIriSP4y2rAH4z26WLqH4V/F3wIzfLyP8CQm8H8JrXjljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777706097; c=relaxed/simple;
	bh=7BGxycw9TD6UvArXUMhq/Yy+efsyYMcvbzGqrZ+k6yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PtXYLrJD4xcDaoTXMBFDVXayhqmvXEsbYNtcDL1qyYOKd2mP1FGL+o2DBRRNLgYcZKO+ozh8mzygYDPqdB4wfOyFCuLx8ThHL7B4gz6L4Ltj6NkjCkuGsw22tku0Jk3GfrmRE5y/rseddfjo2/QWAu2r8KNZadDEg1hqfZZkE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhOoVyTa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891f625344so26121335e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2026 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777706094; x=1778310894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXZ4zjbaOSRY7Q/S0vThNdYI3+newzohnQo/7Wbdrz8=;
        b=dhOoVyTara3ZCBxMx7ysH/rcIZEU/YSoOdio2bg0dMVK4XcV7IzWkZme5OUY0iUMXh
         NHDNKXWtfiybOKviTOgDigqh98uCf9p0w0NosTpADQbKr7mTLsFDZP8xpPYkVmhWkC03
         yYUYss5nNkquSyQ55DVJ2N4REB7uxqTP4Kv415uNanu6iQ9KSN8YZOEgpS87nCnDfPv2
         Rrz/k3UnkrodNMkyxc1cGM/I6bbOh9ONbY+ntET0/FPBlphOTO5qao4hbr0pbezYBSp7
         C8TK/fudfGdS2rz3jMvkYMvMtkB50NBk6ls8XeLEXSWjiX7a7i/9o6w9wwBuaqPHBzoB
         HsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777706094; x=1778310894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXZ4zjbaOSRY7Q/S0vThNdYI3+newzohnQo/7Wbdrz8=;
        b=mJ6IfDg0Tk7Iso/zR3V6oF21drCnmRZiV2P15Nx0MPhyoH4kp44zvZeJmeBV67wqQ4
         tNm6IaezhBEWwq/hgXDg688LYDmmhqnVGgQu3bCD4Zz3AhZZ4AVamvDH/6Ei3OrcdVlD
         /VuzUFlKvsIh4KY3ulLE1wncGU16qyfOY7AG4l7ZqS3cf02wCAFgN8qLJqZhFuLTk4Cm
         TWlvS48OYwDv870WdyfIA6OoMlbxf0i7JEshRLUpPWWAAgGWOpYTZlMdr1hX+lDWa3fm
         fPx20/8SgpBYKkXgi7+fwUMj6hxVyNWrMKRYwBHf7o+DN9qa45r4bLKq6lpKn25/RFbV
         4I3g==
X-Gm-Message-State: AOJu0YztU8mrm6CG+juAsX2Nsoulh8VsiHvm76n5LhYv2a+PHmjBrrJ6
	ppxpDqwuyiiqcZHtQK3kLRudLjI6LURO/QRX2hUSmR6MDotS9KsRKmr9M4V+jw==
X-Gm-Gg: AeBDieuZE7fxZyq9Q6XX3V8bOpI12ysQs0px6g+jWdybLzqn6Xfi0vZWe9wE+/aeCst
	XpzE3Tlf+dw5n6SdQX0j/ZJEOpm20bw+ACbRk63AJzxufbZ4XnvrhYT/K+TV2vHu0tWiLX1T29G
	0hLbjq+fdwLFPo0iLxM65u3CCjmF6sjnrEoE/HOGC1eEVSZv/39I53ICFOvUTegaN4+3wZhqvgx
	IkQiSCfSEvwOv3xakxFhntDoUoPD4kK7PVJ1+EXD3Oebl/NECReoPr/MpOsQy4Y9nzlwPiPglOf
	JNVhCC+pJMSpQwHilCKhgqdzkUGpvFKRankiUZrXfe3QvH4U46a0EaZbZb76e88RVnJo/Nq5bPO
	0Pvzg3LD9x3F86s8qVRQa8G+FHQ5cczpiwpppFgBrxrcbMTkJcFO90MphjY7q7851cMfTR2fCma
	JH9PEO5cSw6ZmAwCmi5UPb9SCoi1fnIVJ03IYD2jp1gZRutagRUKR+EpdKQm0Z2GxPat0=
X-Received: by 2002:a05:600c:1c12:b0:48a:5821:6006 with SMTP id 5b1f17b1804b1-48a970a9098mr35975045e9.4.1777706093865;
        Sat, 02 May 2026 00:14:53 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm281862135e9.9.2026.05.02.00.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 00:14:53 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath 0/2] fix leaks in some WMI error path
Date: Sat,  2 May 2026 09:14:51 +0200
Message-ID: <20260502071453.2379188-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CCE64B1412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35763-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

So this is similar work to what has been posted here [0] for ath12k.

When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
explicitly checking the return value we fail to free the allocated skb.

This has been split into 2 patches per Jeff's guidance to hopefully
ease the backporting process.

[0] https://lore.kernel.org/linux-wireless/20260422163258.3013872-1-nico.escande@gmail.com/

Nicolas Escande (2):
  wifi: ath11k: fix leak in error path of some WOW related WMI commands
  wifi: ath11k: fix error path leaks in some WMI calls

 drivers/net/wireless/ath/ath11k/wmi.c | 131 ++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 19 deletions(-)

-- 
2.53.0


