Return-Path: <linux-wireless+bounces-36028-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMz9Id1F+2lPYgMAu9opvQ
	(envelope-from <linux-wireless+bounces-36028-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:45:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA404DB3ED
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED773086E35
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AD47CC94;
	Wed,  6 May 2026 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkf5J6TR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9247DD5B
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074964; cv=none; b=OLo7lShiiV0bkYVAaC+aIy7mHfAQVG/USyx5qa6y2RifT8U94pFack9Q1Oy0EAi+Qxw1f3pBY8uarcwG4qp1sRUdO3RPyWHI4gU29cQAWYCQbkGic9oRvQ8YUG6nONT68JdWLyqpPx7fAwO4bO5huZLxFR6hlGBG1pjIJqrGKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074964; c=relaxed/simple;
	bh=azDSP24GwVs2NbBZbYr1HjJksnV1C4tvxOvpFQzQF0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivU1mkc2d4iFWwRqW64SpV12fXQFgAJGLj8a2U9LgxX0StdF5pcFCdiGqqSnZlpUpW4DTDXHEoAN05yPFPli70V8mVil2hy2rUlZE70ShhHDwQjEobnN8btEu0oMn05g8npc2DSnAjZwZt+hqX1TeKhYyRMeCqIAuN10ugLW/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nkf5J6TR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d734223e4so619830f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074961; x=1778679761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pexLJ9J+9YgCt2KZyZO6yiZqoTWaoO8wMjWHe+dEeI=;
        b=Nkf5J6TR3x3EBoRGpiY1t/pctCYXI+e9SGkyz1FMzWFU7CR7qNceq4i+huMxS8bObi
         /UoZb5pljHxCpt9RWImmO7qbD3Woe7acUowTg2nej903ZSidCFt9ECQd1DQmixRWMBLF
         L8tLsSJBIPrLnBc7eAOrjihsW9VlMk9jN/6mGZ6J6hIGRHiF8x8WBBfnBGPkGOrLmqHX
         i5RSPZuKOXVl6kEn84qMJqZnyW5J6x7E5tMMSj4XGffo+SfZ1Czbhpw4lJE+Vb4Wrf60
         MCx8Wa/73KVHk83v3XUyodGFNu8rrZcuxe0b9BVOrpzVN00cztBUyLXlYGa5i2ekN/BZ
         hMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074961; x=1778679761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pexLJ9J+9YgCt2KZyZO6yiZqoTWaoO8wMjWHe+dEeI=;
        b=YAO8oIdzwBF/ng78kb+8DU4yzeGcG2aEETcCAja00blNX4zHGOwc+qPUzX6/IYF0lq
         2M/XLr+oI2gkorCCVROGdKbkvK9ehYk3wbv2S2+bIiDnvBGIEiZju7UP4dwIkEcNhD3+
         RT2vf8+QhEGQlgSPfopZRO7h4sguED60TlosfOvQ6lyLIKlsyk9Hy0JNJUlb+llie/fo
         Tj4kEI6XMX5wcXw2E31vxyKSoQfayHN6YfsTtJAKDMKpgNB4uxpJ0pQxucoVVrT553UE
         aGcKVlX7NVG/cQIdp/5+LM/Co8JdrrJtlf48S80xDnRMH28ADvyAf6eQ6n+oS94BYHiS
         sb7g==
X-Gm-Message-State: AOJu0Yw+j/scv8+GJRB+1jkjjugs3p7+yDwlIaUt9XOHFg+ggGgeRPOJ
	e14pegCoRqQf0SQ9AG3t4E3HnZXz0YTY3QDZ+2KlprBSBD2/470Hw2CGE2tCBw==
X-Gm-Gg: AeBDiesxfi66UrxmxeNlBab5UoeOpPMvruLHTJXuwwhCtP4MJuxApsSYp/MZHgKPp80
	gSxLdr0CsFaHJEoXQz3TeLovSwuzE6eJOJdt11ZV6cGhbqkPZXRDd8Ka+U/terMn9hZbrs1RHzZ
	pabjUikIvIeIIWBj6UV+nnozpTXZFj8XtkpB2P+AkLJpKrqMiJoQeIYWWXj1GonOa3cGYTNvvIY
	Eh5zm49Ubv0iiuZf1DY8A1+w2kSi0iNPTr18xR/fEBehCuA8acqm9JiZlL0SEdI0CzgtBn8YSDz
	S+8t+sksemF4cd4aFcFxVVwgQkX/6cJsSgFp6vzipUFZNBuiex5ioE8kYxui0BDnsaxfQVAHOIO
	1hLS0/GNgu/gAJe5g+PIrVNgaKzQo322M+fOj0JbUaokKV/Qx7Gd+8vjhbbTUS92R+fk51OQBaS
	LG2fL+Quv9dBKTtcbFXUVCI8+D3LGHGF/84R1+jvL8Hjbdb7OXUAW8JcipLvyGNKNhDdQ=
X-Received: by 2002:a05:6000:438a:b0:43f:df55:fe5e with SMTP id ffacd0b85a97d-44fd83c7bb1mr14066953f8f.0.1778074961246;
        Wed, 06 May 2026 06:42:41 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052483166sm12542182f8f.7.2026.05.06.06.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:42:40 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/3] fix leaks in some WMI error path
Date: Wed,  6 May 2026 15:42:37 +0200
Message-ID: <20260506134240.2284016-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CA404DB3ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-36028-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

So this is similar work to what has been posted here [0] for ath12k.

When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
explicitly checking the return value we fail to free the allocated skb.

This has been split into 2 patches per Jeff's guidance to hopefully
ease the backporting process.

[0] https://lore.kernel.org/linux-wireless/20260422163258.3013872-1-nico.escande@gmail.com/

---
Changes from v1:
  - Added patch to also fix ath11k_tm_cmd_wmi_ftm() as per Rameshkumar's remark

Nicolas Escande (3):
  wifi: ath11k: fix leak in error path of some WOW related WMI commands
  wifi: ath11k: fix error path leaks in some WMI calls
  wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()

 drivers/net/wireless/ath/ath11k/testmode.c |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c      | 131 ++++++++++++++++++---
 2 files changed, 113 insertions(+), 19 deletions(-)

-- 
2.54.0


