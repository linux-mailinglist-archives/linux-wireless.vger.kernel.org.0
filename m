Return-Path: <linux-wireless+bounces-31118-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI/WA4qac2nNxQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31118-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:58:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC74378183
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 226C730039B7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECA91DD877;
	Fri, 23 Jan 2026 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8awhs+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81502F851
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183879; cv=none; b=G6Jsh4gisChQetP1UmYttCElQokzA+WvBSFBnYaMJzVuf9o/yJgwJX7z5vs6ynFDQd1+9sC3zkEgugxNtSiEgvXNvhPMtIY/5Yr44YusXpthHrn4KqyzZ4YANuoGVxkLenE856Ea7Gv7OxfXE2m7GnUWKcNms6GoLUt4bdO0cXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183879; c=relaxed/simple;
	bh=wP6GfRLxXEKgbutf+8H7KXxmLvUaNWerrCx5Sm1Q+xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGsjrbAuMGgo7J1nfCmSwaLkXhGJoVNb7yuqLUELumQytlDDo/maroCUaaLKZI1d+/5oEdzUFMU5Z7e+Ji4FfkvDNNZAZ7nu3mpIh9Iq/CA0mbj8HgKX/kAPTHMCH6KjLTCkzbxjyPjuaT9UDCtPzdR0KBsSVNWwQQab/KpqqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8awhs+9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0c20ee83dso24801695ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769183878; x=1769788678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/p4HVsJQTZCKI9+64i+NDhOYzKitv/nH/N7R54exfU=;
        b=F8awhs+9Z61aI/NWUPt6oPZ4HBbirxeXDCrY9BiDA3hMbEOrPzCATWGEijbO2IimYE
         96y7rhdMz6WDPAo7thKFu9T5Sgbo3ZvYY6IbIW4wdkW9wVkB0xUXlBs/ME+BtUDuzQdh
         DnZFAQTN9l5BokRIr25woZdc+LDu4sLI26K7CmMbQy4CsQkhgyFKKi0KhHPyjNKHGkMz
         eDYCCURHzy7Rks789iOH5RyMP1m+u7W1UJ7jyDWEWPGN/k48KXNhaLF+nUd+7m2AyESn
         jhAvVf3G60titFyrl4k+zyL5vOYdhd4PBJuPT7WUvXMENmnPGvohSk7ceGp4dFXeQGH/
         pCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769183878; x=1769788678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/p4HVsJQTZCKI9+64i+NDhOYzKitv/nH/N7R54exfU=;
        b=DgXEJb/8cKuVqwZKE4EW69B7ephsNJo6mTyBqQgjHuKH2vxG80iurf5YpcQZSQd+RN
         DZ/E3k4zO3oazgCgeGurnP7l753J7b/I3/Y3OpI+ktqe/9q+T+NdsfTmBA6/ou3/Y58I
         bW3dXQtdQM2ALyh5+7SXtELBqy5O8NTZuvnrpuqvP7X2Bq/GrTo2KZHh/iKfuTVGNuGB
         uQa2Jf0X/Vv3MJBAMX9OdTG/pxPF9g39nJ2Psyj3eijvUzYTmJWuILy2ehB79H8KgKDh
         LmKAlwgZhG+JiXsEcZoLWbtgHfVYrxVwdyfTFzUqKqjf6dczA4LRURAWvImqF2G6sX0D
         WEfw==
X-Gm-Message-State: AOJu0Yz+8AowbgcyAAUjRiowSYL++/1XGVJrKyzCHe/OqYcxlheBiNL7
	NMCVHqnNh4O78Jq/fs3/yQ2ZFywuADIGeLmwA5U5D9iALRleBP9g03Um
X-Gm-Gg: AZuq6aJu8Nyb2oU7FzBV/Db5t2nwYXlj95ZB+7xFtvZ5PwPX8iOtIU9740oHUVaWpEU
	mI64qNssCkNfec3mi1MrmXftlP0ZCLtOjr4vJkjgyKX2YJ1ycowSqn58imQkne2rOWaQ2CnDcrB
	cdWsP2QjuLGliTFeetxor+wqjXGHXUQMoe+7iuJqi7vAUaZHI1JkgolfwZznzEJOLH0+83dQlu9
	/BBO2kAUqSdiBazxz2JQBc03HDdVNv/BbfyHFsgbIOe/PfeF2hHtc19mw16k4W2G0nq0ELISyqf
	6HwY9KPllyk63dpYKt/0kFJKcFJ5IXWahlBhZ+S+Ipv7f9njbPTb1dMMgwX7+ferLnBxuu/veCq
	PF9sphZJ9+B1H9GOCK/Ws/4ITWnW68uT8SKo9yQr1tBQZrXrheo1Dzz/iwb937XQpOE9arAqs0H
	Klfz7bEMFFph0hdZKkTGB8RHbPL8IEJPV55CKj
X-Received: by 2002:a17:90b:564d:b0:353:c:643b with SMTP id 98e67ed59e1d1-35368c430a2mr2903556a91.27.1769183877951;
        Fri, 23 Jan 2026 07:57:57 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:dfb6:6b31:aa17:2446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335206b23sm5489305a91.3.2026.01.23.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:57:57 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH 0/5] wifi: ath12k: Fix 5 GHz Wi-Fi regression on WCN7850
Date: Fri, 23 Jan 2026 21:27:45 +0530
Message-ID: <20260123155750.6007-1-bjsaikiran@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31118-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC74378183
X-Rspamd-Action: no action

This series fixes a critical 5 GHz Wi-Fi regression affecting WCN7850 
(Snapdragon X Elite laptops) in kernel 6.17+. On affected systems, 
only 2.4 GHz networks are detected while 5 GHz networks are completely 
invisible.

The root cause is broken frequency range filtering logic introduced 
between kernel 6.16 and 6.17 that filters out all channels when 
frequency range values are reset to zero during regulatory updates.

Patch 4/5 is the primary fix that removes the broken filtering logic.
The other patches address related firmware stats handling issues and
regulatory domain initialization problems discovered during debugging.

Tested extensively on WCN7850 hw2.0 with firmware WLAN.HMT.1.1.c5-00302
on Lenovo Yoga Slim 7x (Snapdragon X Elite). Both 2.4 GHz and 5 GHz
networks now work correctly.

Saikiran (5):
  wifi: ath12k: Fix firmware stats leak on get_txpower error paths
  wifi: ath12k: Initialize regulatory frequency ranges to avoid
    filtering all channels
  wifi: ath12k: Add fallback regulatory domain for WCN7850 without
    SMBIOS
  wifi: ath12k: Remove broken frequency range filtering
  wifi: ath12k: Fix invalid frequency error in freq_to_idx

 drivers/net/wireless/ath/ath12k/core.c | 31 +++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.c  |  2 ++
 drivers/net/wireless/ath/ath12k/reg.c  | 13 ---------
 drivers/net/wireless/ath/ath12k/wmi.c  |  6 +---
 4 files changed, 33 insertions(+), 19 deletions(-)

-- 
2.51.0

