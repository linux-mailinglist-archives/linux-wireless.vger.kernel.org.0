Return-Path: <linux-wireless+bounces-31123-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MTZHZiac2nNxQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31123-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:58:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A077819A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3670B300533E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 15:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6661DD877;
	Fri, 23 Jan 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2e2bQXI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000432FF155
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183891; cv=none; b=VskwKgl8aeQg/ksbm6tM4Bz53cDxlwhOwYJbXL+3YsbTKp29fg6zMyZWq0w6W3+x/MjOusB/MNNPdsLF6s7pofVzHqAr2FGVG52gd8NHh9NCo51vVLs5YUKEJ/AhPeQZbDzuONwtnhOPBhu0dPEZ1iDsdPKj0h8997xNz9sz+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183891; c=relaxed/simple;
	bh=NvLUF88YU03nZUN1GCs0DHqTe/DDw9RHqd5PxlVatB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C28Hl26+iJhIjGxooY4H3lvr2dJjO5pMnmVPYO4I4IEXzKCSaopUgPvhjKQthK56YhIrfJBw+EMlaqavYoP8127++L68LmUVvp3/PT3XxYc96omkuBwp9+1ATg1kJoNmOUvA6gqOavDQevnNoNM1zo/iwaeXFg4LVqtazSXEejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2e2bQXI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34abc7da414so1358022a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769183889; x=1769788689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vRv1BELzJOlqLUHCgkqA639wC5nhEL8ETIdNyZ1IXs=;
        b=l2e2bQXILgQWbHiz1pl0yCgXm0uuLaVIcM54KyEHa/O65vA2NZ8W9L0S1kKXvt7F/n
         2KzcXGS6cTXNBHXexnRh3dwphryqQWm5Ya3yo2Iu0xPJa3ciQ8TMu4RNhg9sgx7D7H90
         +0dWZz7ZFBQcrON1w3bcvLnLpIC2eodTkTl7UTzawcmEeJfeU9//ncwNtY+x2qe61EkJ
         4+RPABC/fLyq5wYGUz0Jx0R1AS+6w+j6Dxd1IqrQt302CjNCufRDebgaYAy2rl8P24dr
         GIawpW8st3YclZf2lOO5T7+VjqnK2e+S8763yIB5a9LU4OYzGgJIi/Nn3zPp0xXnKkr0
         rMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769183889; x=1769788689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4vRv1BELzJOlqLUHCgkqA639wC5nhEL8ETIdNyZ1IXs=;
        b=HZSMcYD8FNoaCDOHoek82q4GPmpZHxWucwUxg6rgqJMFTLWzpCW7Gsdqb5wYA3mcDs
         7ufelL5T6MOwnCXBMTtgjPXItLuk67f4O9ttQRWPNfe5X2T9xCMMID6LlNcMBIydgiQE
         dcx6UtI5cGpsyi77IvXBSuuAbXLU/wGpjhcrzpo0nitQs2lDeM7KOVNWqlFzbd1hOjAZ
         Wzf71bmw7e0mQj9YBg0Oc5vshbLmg2UVwiL6tRavLVaSpZuGM/EtiZovle/gMs74mDDX
         GKk1LOn1m0wrEzHzc1jW0jWlng433HudrmrV2uqdmY1m6LN1v46Q8Up/KBRfzj52O3r6
         QyUA==
X-Gm-Message-State: AOJu0YwuaQcftlOhg1ZWxhvczjQHXGSOKBUS8E6oBKlWb2S8JzS47vDq
	k5l6Lmp3dlbc+JYaHry+ATYeYvr1iDRECMBEwxVB3vpo5yPM0U1l9xFn
X-Gm-Gg: AZuq6aJ/BOukJzMLJQXSvQysSMYnJnhvUPUqAoILSipnL7tGD2vLq3xkHbqmkRRsjfs
	3xmnZK2W0O2b8O9WysHcbg/pfkU9cK/SaZdwe1aotEgA/wFCXyHIgWvhbeyQwu+ncMY0FOusFNw
	QdTEA4PeltIbtD98lzhDu571qNZCqI/DRC7O85yV+XpmXRvtdjNuLE1ENwgA8SYakp4wQV4poQ/
	55uVPsK4VCngY9EwFyKVGa6i7eT4DfMCE7hQtEMH5NolTE4sFfmAm6XMmp+T5NmwHSqU7Vc+rPm
	71lwwzBaTmU0jx5wJwBwtDq7X0EnMPPdCc+SyxOES2edJF9nrYsl7hCL3MEQnl0AbNvFF731xXS
	bqCvBBm3aTBCmwBXFDi2cea+a4QKTV4liN3yNq175P4oUJZpZv4xzP65t0yq9k05CwRS25anx0o
	tJ7x6Vz4uR/kJRTKPsFC3J2wDAz7Xs+JOKfZ8y
X-Received: by 2002:a17:90b:4d0b:b0:34c:3501:d118 with SMTP id 98e67ed59e1d1-35367010b69mr2822214a91.1.1769183889197;
        Fri, 23 Jan 2026 07:58:09 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:dfb6:6b31:aa17:2446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335206b23sm5489305a91.3.2026.01.23.07.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:58:08 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH] wifi: ath12k: Fix invalid frequency error in freq_to_idx
Date: Fri, 23 Jan 2026 21:27:50 +0530
Message-ID: <20260123155750.6007-6-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123155750.6007-1-bjsaikiran@gmail.com>
References: <20260123155750.6007-1-bjsaikiran@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31123-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9A077819A
X-Rspamd-Action: no action

During suspend/resume, the following error is observed in dmesg:
  ath12k_pci 0004:01:00.0: chan info: invalid frequency <freq> (idx 101 out of bounds)

This occurs because freq_to_idx() incorrectly filters channels based on
ar->freq_range.start_freq and ar->freq_range.end_freq. These values can be
temporarily zeroed out (e.g., during regulatory updates or suspend/resume
sequences) while the hardware is still operational or reporting status.

When these values are zero, the filter skips all valid channels, causing
the function to return the total channel count (e.g. 101) instead of the
actual index, triggering the out-of-bounds warning.

Remove the broken frequency range filtering from freq_to_idx(). Channel
mapping should depend only on the hardware band definition, not on the
transient regulatory frequency range. This mirrors the fix recently applied
to ath12k_reg_update_chan_list().

Tested-on: Lenovo Yoga Slim 7x

Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index be8b2943094f..bef1b324b62c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6576,11 +6576,7 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 			continue;
 
 		for (ch = 0; ch < sband->n_channels; ch++, idx++) {
-			if (sband->channels[ch].center_freq <
-			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
-			    sband->channels[ch].center_freq >
-			    KHZ_TO_MHZ(ar->freq_range.end_freq))
-				continue;
+
 
 			if (sband->channels[ch].center_freq == freq)
 				goto exit;
-- 
2.51.0


