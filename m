Return-Path: <linux-wireless+bounces-31177-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEr7LDhTd2mdeAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31177-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 12:42:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C0F87BAC
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 12:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC0CF300463A
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78A932C941;
	Mon, 26 Jan 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="YdU+fu7U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A7329C6A
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427765; cv=none; b=umT+BECI21yJpXsckNYZpr6c3321H0AWnM6IMst3YzJf88jRO/kpp8J9Ek+sEa+zgsYNm5VkC5FDTaGAMtXkCQzLmZL7COJxIPeKcVJxDORdG6ckUjf9qqKdKUCjjxr+pELLnyTE2rFh8Bila17Z/vDSPLCDHOYAYXIUsqio35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427765; c=relaxed/simple;
	bh=UAXhT0x9PCs4OBpOQmI364pj4gkDbpyV7vnll+RscOw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=A97yMcn9vMH84IlXr1jkE/NWmLTX3FzQg3x59iQ1Pt7HFq7pZrcnWXTrAD0QOosZpQrwMTe7C4slwMvARnzkghIvjB6raPCvBx/Xgnv1CMlsxkAGAMkBfUHBSU9Yy8DRZHiwlpHeMeN8ZmKGvFJ1/6MboprgCbwh0vVGPrNhyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=YdU+fu7U; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fbc305882so2630089f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 03:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769427762; x=1770032562; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf1eR3D3wjW05aK+sD0oy7D2kJEgXG+NVJDJ1InbAMI=;
        b=YdU+fu7U12Jrt5Ln143hqAbSDt21wafvRJooxC5fqnKpv05PDUlaDjAw/E0+EvD7kY
         pMFi5auBMWz8MtuZM/c0SyqSsPvtDXhr5UqFKGF7nMHAzZtEBeQhLAlQFfdULy+VyT2X
         IKsv2KridJZPPfEVyDJA7xhsBkLXk+mQ5Il1jj2uJvjeBo/2iC+cDuylsESKDnkHZD36
         Gg4KgAan+HSvJD+orIZWNA8h8TtOt5354GYodo/ZS9jZJvnkj4gzPRktc0WwT5UEPLjJ
         k1cTL9Ye+R9qAFnKzF4T/yKNE+mRyoXOrneRETjTncPEy9NdRYckg/XTtKyV6CxbY6sW
         h1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769427762; x=1770032562;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yf1eR3D3wjW05aK+sD0oy7D2kJEgXG+NVJDJ1InbAMI=;
        b=JJIm9om2p6Awtk2UkvoQfTouXJLlz8bomK7z5gm7Y/lJvsHOFWPi9Cb59FM8Qv3VUN
         XDskFJ6ZqOwjlxVKGKK7KwwcQSpKgOrrdAUls6JwS7aLDruHYwEw5TILbfejY6TFjEDn
         29G70TK9sG+P1kC/tmOCB92CEMbQnwbKrMYFDlxumCpcIvGYHpESLjgJqR80wlLAbWFq
         qnORJUH7uGgALOKsbO2Mhx11EqiIR0nrTdYhP1NPDlkjz5W3nEz229q/uXqMg3dO5Gre
         CxB/Z+pnTXrQxUWpiM92+/S2vATRA/DpTBrGlcPCVjrILMKpq18Jw3sUosHJfFoXjE2L
         /A7A==
X-Gm-Message-State: AOJu0Yy3GBqM8AtKzSmBvEJgwx2cE4YJt4Jxk4quzdVB5cuDtt7Yvnkw
	intBqrZ13CpctvGBGUEybO/REn260EppBzXcoFIkZoXbRq3ey0y+LBEk7g9UywV4AEeWhaODf2p
	gOfmxDAc=
X-Gm-Gg: AZuq6aLxLr+m5ug9q3EnucjSpZFbErpLp1WbH87ZKyUtY5+4ozc2qCWnmNJJkiqSmCO
	a39/yOuOhVuhrR6ioSgYBwNomVbiy/jzqGnKgL2CxXbO/rUbOkz11qlgnzRt5NMMhL7jZ3H+BG1
	DQdkan+uYIMkLFKi7DDMBEchxFdnem/lNdmT7cLAce/ov1nz+ayyJa0G/WJBLPrRAy0otNKZ3zr
	o+L8SmB9SydXM5lUUld84vFevA2/R/AIhi504s+4SHwz1vTWR8DKlc6FEOyEkyCnaOXBJoF9f8u
	5x8P4YazEBIQtk7EzRXU+SDU916UPRV9nHnAzohASidOs4HibddeCpdjF0ZNGCZfj3FFNP+SKVD
	sBus/Bhtmi5Zk36LlxJl2CsoD0JCTSRArJf9gJBvZee0YQbYt3O+gIZjq0uIWi+LXe3ZXUKea8b
	dnWQj9AGd6S5b12tlnY2DffvulnAByJaU7xvD+yuJrNQ==
X-Received: by 2002:a05:6000:22c6:b0:435:bbde:e050 with SMTP id ffacd0b85a97d-435ca1a7979mr6735706f8f.52.1769427762416;
        Mon, 26 Jan 2026 03:42:42 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02dd4sm29259132f8f.5.2026.01.26.03.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 03:42:42 -0800 (PST)
Message-ID: <3a663eb1-2419-4289-b706-654c032512c4@freebox.fr>
Date: Mon, 26 Jan 2026 12:42:41 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ath11k@lists.infradead.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Subject: [PATCH ath-current] wifi: ath11k: fix wrong TID passed when stopping
 AMPDU session
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31177-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim,freebox.fr:mid,freebox.fr:email]
X-Rspamd-Queue-Id: 57C0F87BAC
X-Rspamd-Action: no action

When handling a DELBA request, ath11k_dp_rx_ampdu_stop() calls
ath11k_peer_rx_tid_reo_update() to tear down the BA session for the
specified TID. However, it currently passes peer->rx_tid instead of the
entry corresponding to params->tid.

Since peer->rx_tid is an array, this decays to a pointer to the first
element, effectively operating on TID 0 regardless of the TID in the
DELBA request. As a result, the BA session for TID 0 is stopped while
the intended TID remains active.

This leads to incorrect BA session state and may significantly reduce
RX throughput, as traffic that should use aggregation falls back to a
BA window size of 1 on TID 0.

Fix this by passing the correct TID entry:
   &peer->rx_tid[params->tid]

Fixes: fe201947f8bd ("ath11k: update bawindow size in delba process")
Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
  drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c 
b/drivers/net/wireless/ath/ath11k/dp_rx.c
index b9e976ddcbbf..8db04c38dfba 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1132,7 +1132,7 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
          return 0;
      }

-    ret = ath11k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, 
false);
+    ret = ath11k_peer_rx_tid_reo_update(ar, peer, 
&peer->rx_tid[params->tid], 1, 0, false);
      spin_unlock_bh(&ab->base_lock);
      if (ret) {
          ath11k_warn(ab, "failed to update reo for rx tid %d: %d\n",
-- 
2.43.0


