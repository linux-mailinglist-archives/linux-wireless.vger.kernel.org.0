Return-Path: <linux-wireless+bounces-31176-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE2rLIJRd2lQeAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31176-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 12:35:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E7F87AF4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34F243004DB2
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2032E146;
	Mon, 26 Jan 2026 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="cR0pzmOD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F21DED57
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427324; cv=none; b=m9B/fOrYCELJHrRaRWlZr1/ZnZ+kytwTzLq6TZ8fPt3IKKXsA+N06ARPRh9FtO15AhzxvxwIKAKnunu/PodlQwQbFIYUPYP/38htBQJqU22Vkf5MDucp61zosdCpArKnBPBjmLG50GJ+zzj7LsDM7QgGjurNPc+sTLj9nInxRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427324; c=relaxed/simple;
	bh=IxYzerzjJyh9zLVcB2OhOmBPwuSIg0rUtYxqHOneNl4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cznYe/OR5/hFidWJ+1DvM8Rv+Vmf0W4gXecbyJKuzlQcpk/vw+s72wZOV0WXA+/zuMHOvv4dz7LI+X9wJ8tV68mbl3rQBpLQhDM8K+AhwOqeCDuyGE3ERsv1T+ZjWWm+Ozfafe1qa/89+VidSwzu0QjDQymEviyGPm0ZJeUxOvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=cR0pzmOD; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801bc32725so34311975e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 03:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1769427320; x=1770032120; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXjJjt/6dVBULRmQetw7Sw/hK8UIoQyy1iJNMtHwAMc=;
        b=cR0pzmOD/Xibd6t0fh9MnVYFZ2K47/9d2oPkU5RgFaTYYUpV/DKJ0bPOCLsRV/qWqW
         GY1H/EpsUo8FwhxqRPzpn/LZtF696rhN8va1NFfQ5yhtFkaa8l3pGTEnmhoNIZIc8i5f
         iXUwtxEDjyueLMnhblWdtUA1QoG/JShKdKEPK8AZVSavyo/bbL4qd7hx1Ny6F6tDuuTf
         TmifzUTDJ3jZdugi9QjH/QGP3w5Dcuk5fShmE+TtAQfmK0At8OOPJaLczIbeP4OMu6MG
         SMSm5yrGlEruZTpMY/XQN4y+VBFcKzmgoRBAZTiwfcT5bSS28i0vo6aZmsmmlDIpbWhR
         jOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769427320; x=1770032120;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXjJjt/6dVBULRmQetw7Sw/hK8UIoQyy1iJNMtHwAMc=;
        b=EDDsKbP9qmT0Jn5/K/Xo01OzNXsihc+ohxPEZv9GhLVUU6REPf3B92b8G86sSf/DSk
         is1UKGL1VWBpn6o3PKun6Ti/VCfL8WMiG7j/q+q4IZeegENab/uUHTDZJ/uQxe3VDcp6
         +UIx+yLYkanFeR8MB1PMW87BQxKfEw6IXOdPdGfiI+9nUKex608gflpHGyC3pmcm4ERQ
         dYn0HNfEY9Lh97mWRRWfFzav9h0DXxH5LVEpw7wZXSQqMwlsE78so1+Ixq8cJdOMIs+N
         7k26FrI71Rki5GIwKmpNs1xDqZkXghlODra2y1eKcGQ3K1StBxs2GoebPd1iTih7GY8q
         adcg==
X-Gm-Message-State: AOJu0Yy2ZFMpfKV9dGCprjaeJUHyBooyk2aBVegb2ki4LgoqeEa+nILx
	GNoK0Jf+ozwqjw3Wto2zw3nrJIemNELYF6AhH0AeISYqP1Q4avZ2odSuauyyWVxCcUY=
X-Gm-Gg: AZuq6aJupnEtbdVY5nT61FCUnbdoFbm4HPhRjiEnrMElPi1N7Wtaa/5yZ67Bd2+BjO9
	rtDfe2O2doNLVkF+HEvGnuPk+dTbjaYRb+P623w0tIkMQXnizHF1AvgQX8hM8zh7WK2yWFFJg7J
	vzWoqMesQQ/PBx8iDor8psxVB3eVagSoJBWPlr3HnfcGXYHEvw1HdKzGafW0djhzl0DxjVh2ukN
	zjCexdRChE9y7fktAcR1+y0I4WVJm/MWUgGHg/pM2bnMhfj7WseAGngRnDY+uv8pkpVS5kfgUQC
	CsomHMIlLtMpJF8cztJxjRS/NwtwSY/Yo2EYWqKTr9IC/PeTijwTRrPCfscgH4ItSSHauvPcGT1
	ikuwJVYb4vBWFBOuEtn7CiVEKTQ6yJl1ZjNERmHgv0+MwrXOtxPACB3PHmc5UxyPsoi1W+zW4tx
	6UUcL7vHdCiw/zHbjyQ+ix9XsiyoX/oAodZ0BD5S0w6g==
X-Received: by 2002:a05:600c:3b8e:b0:47e:e807:a05a with SMTP id 5b1f17b1804b1-4805d064497mr76579485e9.33.1769427319654;
        Mon, 26 Jan 2026 03:35:19 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470472f1sm379056065e9.7.2026.01.26.03.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 03:35:19 -0800 (PST)
Message-ID: <2633095a-9555-45bf-b143-ad2bdaa1ab01@freebox.fr>
Date: Mon, 26 Jan 2026 12:35:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ath12k@lists.infradead.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Subject: [PATCH ath-current] wifi: ath12k: fix wrong TID passed when stopping
 AMPDU session
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-31176-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2E7F87AF4
X-Rspamd-Action: no action

When handling a DELBA request, ath12k_dp_rx_ampdu_stop() calls
ath12k_peer_rx_tid_reo_update() to tear down the BA session for the
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

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
  drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c 
b/drivers/net/wireless/ath/ath12k/dp_rx.c
index d28d8ffec0f8..f2327c82953b 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1289,7 +1289,7 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
          return 0;
      }

-    ret = ath12k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, 
false);
+    ret = ath12k_peer_rx_tid_reo_update(ar, peer, 
&peer->rx_tid[params->tid], 1, 0, false);
      spin_unlock_bh(&ab->base_lock);
      if (ret) {
          ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",
-- 
2.43.0


