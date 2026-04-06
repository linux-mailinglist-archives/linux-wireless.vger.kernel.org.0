Return-Path: <linux-wireless+bounces-34388-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD0pDypG1GnVsQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34388-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:47:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6AE3A84C5
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 01:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80A533025496
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 23:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9832E39E6C9;
	Mon,  6 Apr 2026 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPrGOO+S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7B39C001
	for <linux-wireless@vger.kernel.org>; Mon,  6 Apr 2026 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519271; cv=none; b=it15QIwncMpOdrhW21D1rESha5acOlOEGpNlHV4gJTLoYs8LEiPImmJggtd+WVfIFpvBBOmwlnXp4q1aqdA+kfJc4ST7nLe87lV94I0sF9opmuPW0rF6ys+zM1u3RcgzcwHtiNiI7IEQ2A10jS9z2g30qecPzVECt/ybhdQCmGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519271; c=relaxed/simple;
	bh=6H17mFYZrmCPsmJBNnOQPKRf7uEuBzEAmHWQmztxUZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmQhA1OUTXntYPWdJ4gwf2+oIpOUFfgcTAWX0mhLamJgtHZ6OkENTjEXdfOpQgmxtgoPJUqB7dHzWZIEG03N2KT+UMieWo1/WDx5oDUAPz9VANYfaJGucLyM//xmz7pEweqVTL6jUj8klNvNRS/jehGwu+O84D1jT2H56B9z7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPrGOO+S; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7a469383e0bso28487787b3.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 16:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775519269; x=1776124069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yV/b/VKSnBwSBpAIx2ix3BK0Jy+PbSVkj61ISE7XgI=;
        b=GPrGOO+SFcg2px2Y/hBtCbbN4JWap8rch86KxK6qNqdQ5fGoAmbv6C1qWSx/O1w+eD
         4F7C0SoBap267yFkgUVQF+Il1pfFr6Ekc2U8kw1Gd0qmR6tSb8yTcbdQ1Ifak8b0B96g
         BCS7tbzWR+H/2wlo8cg02nFRHUGAWvjy12PCkM6CLHXSVJSx4rNxge3X1TTb2ZzKuyaK
         Uw0TyYT85HP9eMpmjPmgz6yxEDIFeb7Aw/XMURBj0VLoht6OK2C0maHiXYPN4XnFZAcl
         HFfKLJlUFvxL8hCcw4Gy7+EMsvDErEQS2J5ZnNYmgfXTjb/SpxJ33AD0ZH8QU/wxRY/q
         X+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519269; x=1776124069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yV/b/VKSnBwSBpAIx2ix3BK0Jy+PbSVkj61ISE7XgI=;
        b=aZ+Wkm14Hn62ODi1Dg+7h1Pa9rOhAHcQYzs1/MCIAute0zeJTc1SPdUl0p4c4d3s9a
         /wN/3FoFDrxBxft8lfADs+Wo/ujGRNfPijBxtiQXsSc0Lkt/9F+PTdUqxvjusG9MYxi9
         ibCXZH98kumUEljZSTq+mJ+bl6YmCohUi9H1QfhhxZUPd5jiGyTe6Mb+Hicy3J/J16ys
         7aBbMonsQC938NUbANUlBPLsP87gmkOYp0cVVNRN2M4xfvJooo+mwvEIrisE1CnPB+I0
         iNl5XPdVTCwMNQegQycYCGJ/y07te0It4Bo8FCFQj5MBQydtWeeHOgWqG6pAbklaFj6e
         P4/A==
X-Gm-Message-State: AOJu0YyySvTk8Wflbex/Uh2VZDnBI0Dv26pErYJIYovrP0lf5uUxc8le
	pKlPTUUJ5dgMcLpTs3SX+emUTz37xWgNf1Fjft8PWwmchWiVY5reK1PxH6OS8eFn
X-Gm-Gg: AeBDieszxyN2cfXFGurU4RL5cSP8h0OKzjGFPmMCzrdyicCXDpikjHPgDVubirofo25
	/6wJuP7VLbTIqK9VptZP0XjYVL4wIGrc5v4v058FsECdSrffevJbUvJKdzU5F4eVKe/yR36l0JZ
	iFEDKY3LTZcMTfzqEi6fdQhheVl8wXUagzpUkFaM0aRFW4B0VDMA+J3YM2ZKJREO7SDJvu3xqoU
	sw0V+0l36cyeuALNiw3SaElukr/dOAJtan3YxrKCG9hvwILSbVirscVEFfFpEgncLuFXAeVxZdX
	rxLOack+lPqfPYvrjYS5VkojekcM+GoC0K3q6SbJRKQFz7/HylDSUhlKchPgB8VWLm7Guo0w5t4
	HbUgReQBHOCWDiO1sfMbi8WP/SEiV4LOs7VhVDnWEWTZ7v0sSRWEC808VdNVVYGKctC03cSinhQ
	B5T+c7wJDlZwcR4IRUYYvKfdY//KaiNpLcpuQemWyLmQhftPoHxLGsIy8MZBAq
X-Received: by 2002:a05:690c:6989:b0:79a:bc1e:a399 with SMTP id 00721157ae682-7a4d84c5acfmr145517827b3.35.1775519269260;
        Mon, 06 Apr 2026 16:47:49 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff31sm59350177b3.6.2026.04.06.16.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:47:49 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>
Subject: [PATCH wireless 0/4] wifi: mt76: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 19:47:35 -0400
Message-ID: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34388-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AD6AE3A84C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fourth receive chain RCPI extraction in sta_poll uses
GENMASK(31, 14), an 18-bit mask spanning bits 14-31. It should
be GENMASK(31, 24), an 8-bit mask for the fourth byte, consistent
with the other three chains and with the RCPI3 definitions used
elsewhere in the driver.

On devices with fewer than 4 antenna chains the corrupted value
is masked out by antenna_mask. On 4-chain devices this produces
incorrect ACK signal strength readings.

Joshua Klinesmith (4):
  wifi: mt76: mt7915: fix RCPI chain 3 mask in sta_poll RSSI extraction
  wifi: mt76: mt7996: fix RCPI chain 3 mask in sta_poll RSSI extraction
  wifi: mt76: mt7921: fix RCPI chain 3 mask in sta_poll RSSI extraction
  wifi: mt76: mt7925: fix RCPI chain 3 mask in sta_poll RSSI extraction

 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


base-commit: d863fb7a97fab243b48ce2e5e21243dee5abbcdd
-- 
2.43.0


