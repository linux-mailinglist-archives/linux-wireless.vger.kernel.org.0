Return-Path: <linux-wireless+bounces-34095-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEPqFOjlxmnrPwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34095-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:17:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20FA34AC96
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89C93070AE3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80538C43E;
	Fri, 27 Mar 2026 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="MgshOUsd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604C39099C
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642314; cv=none; b=ngWKHWQAUajuQ7Jx0L27tH8bWvK7zDHkmsjqAkTXglYN1j3Y9YLNX34u/E3SKumlrvJ7h+RkEcN1LKR8M3TthE3WUUGo666+Z8QAnVDXqoMmP8j+w0B8OTtLoXRdcCwmu7v8Fv3DiX3V0S+eW8PvuvQstOmOyNQp45WbFALOCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642314; c=relaxed/simple;
	bh=0yrNCknqD2UFdtKVr8h8k+XRx/AtGwV91fa5Hfqzzc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMtgvS+aoPScDI/z4bby62ltLNcfBVdUuqI0i8LtsCye0lZtdKy+7P3PqBDjTHn9MHu/ds2hXTUAbwBFB4HC9EXdWWrQBYeuuSi7DCqoM8JaQ47hDVbbjo0vI7BZwHSw2yInBc/rAalmgN9uS+Ft1hv/CUfdp94WfuCtnaPjibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=MgshOUsd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fb14227cso32008695e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774642310; x=1775247110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6ehKm8RYls6U8TevbexzmtSEy9gHYRG4Q4GAUGYyJ0=;
        b=MgshOUsdBjO9FRO53FS09R6nmHSbUgUjUtO53hm+M8gE+MW6MgfP6XrM+1/p98rX/A
         Is9FvFdgNOB7/QZPFIRq9weGVnkRMKafMQhGvlPCqkdN9tyDWttQl8b3ak1s50dLjtNZ
         BXQnLk+kY92fsDmZ/bHkFiSnEUMt+M954dAc4HJsZBqrgBuKCbX0bUHNsb1D8zzxwI4C
         NZeVulMFuKNu1LjL73luPT+vhvz3BEab3CnVoNj70XQcAk/6IuerWgR/IT3xH/YN4L3n
         KykfbbtA2bULfp+uLcqEz0iPNQ1CLLEOZXModoTATFEINPVKfUmPNOAt7NYJCpRPgU8i
         3Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642310; x=1775247110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6ehKm8RYls6U8TevbexzmtSEy9gHYRG4Q4GAUGYyJ0=;
        b=C4+qfhygAkM+H2YBJhF7gaALZqObS3ftcAYgxguk2mrfbQJkq7rRWdqu5/UMGl0bEA
         zTdoqdhppRfsqnbJKTfZ1pP75gAxe0s20rhJNNz9mdF2Pdhd1XxzrpGo2bDwagJ7seGO
         HQ5VnvQNTP9dFfAG0gm/GDBOxPY0J8LQRYjVy7ALUTtpLBCgUYtbQGmntkkaZe3O6Q7n
         EPZoAml30eLfCehvzH4xxZin6Js6pwVtbNRn/bSNwBfMsORYI3yDAa07vfws4wzXT9ab
         Ge70byHUCpvY9f5fT/IHN/hlnk7cYjcSouA8K4G+t6NWWKsakMFLIhZ7zcRRxrFT6rcC
         5tNg==
X-Gm-Message-State: AOJu0YwV1NF9PBDzlQkX+7bRqg+29pUbJiHIJg2j9VSg9M7NdXkkU1dn
	zdYiNo6VLv+PXaj3bptnb3YzSRSgXcAvwwmvo0XwjWrUqmS0kqr9MwwTSs87iEsjUeo=
X-Gm-Gg: ATEYQzzOFOD59dctqQx14QDsLwciJKkBF5j6BweNdTbd+z3Py3retM+oYkTrK6v9bRz
	WuuxGGOC8G5QTefrChaWLx8C8/ge0mjFsrzmSPB8mqnwgAe3VwqBdq/tUgdOvIts7Kug7gyVnbW
	9q58YeAn17jfWpIHm1iUrPZCZr502lra1FPwY9tRCQuG1oY8WZwHpqz/W1CArV4+GMWHkrimU0p
	80QH1eKA9hMppzTaGmRFrFWqV5aS7jpEyNcOg7M3Y49EIO/WMY6bMzfG9Y3K2DvXwBEw2UTsiam
	UWQFf/OcAsYAxS/groCwLFudaKoT1BYeoLWNzNlYICxxpWb1SCXi2FcwCPHiLiLUbKRr2WuXk5f
	T1i5TmKo8Zh3HBE57yh+NRzHol4ToZjZ1SBjvUxQ6ofIQMsX4NJUICFuVAYjH0gU3BPStyOuzT6
	SyhIxn/BEhj++VYF0ursGeHLsG5tSo/wh/HIQ05XgE9YFgW0ldWQBk8SWS93L6OnV3Ox/2x859J
	kQCLxez6qSH
X-Received: by 2002:a05:600c:45c4:b0:486:fe45:483 with SMTP id 5b1f17b1804b1-48727efbed2mr65905825e9.22.1774642310018;
        Fri, 27 Mar 2026 13:11:50 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eb5417sm35670035e9.3.2026.03.27.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:11:49 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH 0/3] EML Capabilities compliance changes
Date: Fri, 27 Mar 2026 21:11:30 +0100
Message-ID: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34095-lists,linux-wireless=lfdr.de];
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
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox.fr:mid,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A20FA34AC96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is some discrepencies between our codebase and the final version
of 802.11be-2024 regarding the EML Capabilities field. Given that no
driver supports EMLMR or tries to use 128TUs transition timeout, those
changes should not have any real impact. 

Pablo Martin-Gomez (3):
  wifi: Transition Timeout of 128TUs is not defined
  wifi: EMLMR Delay subfield has been removed
  wifi: Transition/Padding delay subfields are for both EMLSR and EMLMR

 .../net/wireless/intel/iwlwifi/mld/iface.c    |  2 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  4 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 +--
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  4 +--
 include/linux/ieee80211-eht.h                 | 29 +++++++++++--------
 net/mac80211/eht.c                            |  4 +--
 6 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.43.0


