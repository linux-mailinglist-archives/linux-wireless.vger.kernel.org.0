Return-Path: <linux-wireless+bounces-38105-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z09SAFjCPWry6AgAu9opvQ
	(envelope-from <linux-wireless+bounces-38105-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 02:05:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7096C9355
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 02:05:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZLTL9xeD;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38105-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38105-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2EA83023653
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 00:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E358872627;
	Fri, 26 Jun 2026 00:04:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3F11A285
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 00:04:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782432299; cv=none; b=LvZmssceEZbsQ58FWCy1SP2/Xx4tsdZfNbracVY6WmVoLQf+BMosUDkV/kIeSkSsmZkixFoM8cZTo2fgZMRUp9A5r47EHsIvXXOuldlka++ZCJ/9vh5eKTWGZFjULWUR49XQScxz2dL8RhoAZOplEkvTD4nAb/dmYxAJTvvtmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782432299; c=relaxed/simple;
	bh=ayPxqACUajzZC6lHclZxHjKQfq5zgQfhwgZV2hjKL+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kkqrHIZEhzxDbzhW2Mz61wzEpvEdsqGKC2D3egRS/XshZiuYY3h0BVpVkx9uCeLG4sZ9rrndezOpMH4NuOIBfQZIUfiVmsfDpanY2ssNbXW+MXdwDCnS1HBz1gaUbTLMDyEELojIvSRMnB+ZvUSswHtHpBeeInVyafFGRm4h6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLTL9xeD; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49241896317so1908705e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782432297; x=1783037097; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMRwNmhHD7SMAAZ/RYaSTSHS6O1acOwv+l2W4zhXZ8E=;
        b=ZLTL9xeDMb2AlgQa31ZciSFYnKh9vSEWk1ms43nUXHVAV92IzZR/xzHIlotIeyiT5m
         pQ/jmsqNvh8+BICxdAM3GF2ngTxc34bHLwEAfSmweGiGZokg+y115OL1aiOxaIYRt2FL
         zvEgdkKYsB/OWplX4tOfth3uqphtXwDZJppJdpC4G8m43hwvPgqL9xd2qZtBP37kotp3
         ohEG/dP9gKKhagvvEuDoDLTdlK3YXLkpeDgMZBqyKDukNuyezPYraKe6v9faKp0k9Fiq
         3bgv6BXzGyAJu1RLWCos3aMM+xWaeSqwHx+UsCVxIr4YojCowDs8suepaMYB5E6nFx9K
         XJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782432297; x=1783037097;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMRwNmhHD7SMAAZ/RYaSTSHS6O1acOwv+l2W4zhXZ8E=;
        b=fpbRGyzqqRYW6higgJgFyMtj503/YoeRRCyR3QXkkfiBlcIJBZ+GNSwGfthff7IKR1
         eTCvb0S+zzdDvYO0MlxRFnUl4FKA0HcFGTW4sASUeQAR+4TpRsTxhkxrtxPufAzndphH
         H/Bm8cdFhU9AgXbd/iPBo2p+BYR8g/aaMjrU4LCl7cQTl6MkgSmXdoT70nB6Ob7DJsjh
         OeHz38ZkK8WOVVymbhG4GagLvPaa60bdVte9ej57ViQEt3tfziLsm3GdA943USIs8DTP
         OPiKBCFFDHs8ae8UDKD7/7sSIgnkurIda2onk5YYpTxUiHR7j/b9xpXRoN9BsA4yCS6a
         k41A==
X-Gm-Message-State: AOJu0YzmvWTEoEwBDG2D6y8La9iuR7ZzUPSTA4k8urg895XZL5gLirz3
	rehx2YRWWtlsVwvW9IaZePRNFlesDwoWd/prNuW0wSxZ7YlyGds4mfB4OPND
X-Gm-Gg: AfdE7cmpkCH1Fm8aBu58D/BcY+e7AcMePr0ujKmkiVe3OEmRhMcb8BfCZOxV2o5YpLM
	mY2q9tz9e228Gmq4e40s+EA1m021QINM1kj364UwrkampXq3bS0480C5f8jdNxMGfgGzHbEHqjN
	ylrVHLroec4PW+RbmouxwmE+J9JRroCATY0rJ7dlY6Am+zUvH08gb99A9zcT/e2VPqUVAcc7Y6s
	ClBvSy5pOeY8DgcR1pNtZsWNkNmbJYOi0ZYZVyerlfH61w5HHNWhNffP7UAxmz0+Oz9ZIm0yiBE
	ghfA7xgooLp2cboxyxarrfPLB4v3N6rNuYcDBPwuI3QK4o8Rg7y7PiDc2fhy/AfcvUTaqWkMw28
	HAOQVB9v4hXp0c6/L604DPwZVmwrC7gK0ePVJDTwA4rjstN827eVfUZdzuqBTYi3G95pM
X-Received: by 2002:a05:600c:4e94:b0:490:c2a2:b1d4 with SMTP id 5b1f17b1804b1-492668933e5mr60482995e9.35.1782432296467;
        Thu, 25 Jun 2026 17:04:56 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e3d6ba143sm6636787f8f.33.2026.06.25.17.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 17:04:55 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Tristan Madani <tristan@talencesecurity.com>
Subject:
 [PATCH v4] wifi: ath6kl: fix OOB access from firmware ADDBA window size
Date: Fri, 26 Jun 2026 00:04:54 -0000
Message-ID: <178243229402.3653332.17576562809691611363@talencesecurity.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38105-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:jeff.johnson@oss.qualcomm.com,m:johannes@sipsolutions.net,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,talencesecurity.com:mid,talencesecurity.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F7096C9355

aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
zero-size or overflowed allocations and subsequent out-of-bounds access.

Clean up any previously active aggregation session for the TID first,
then return early when win_sz is out of the valid range, instead of
proceeding with a broken allocation size.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Suggested-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualco=
mm.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes in v4:
  - Move aggregation session cleanup before the window size check so
    that a previously active session is always torn down, even when the
    firmware sends an ADDBA event with an out-of-range window size
    (Vasanthakumar Thiagarajan).

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/ath6kl/txrx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/at=
h/ath6kl/txrx.c
index 80e66ac..a39c815 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1722,13 +1722,15 @@ void aggr_recv_addba_req_evt(struct ath6kl_vif *vif, =
u8 tid_mux, u16 seq_no,
=20
 	rxtid =3D &aggr_conn->rx_tid[tid];
=20
-	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX)
-		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
-			   __func__, win_sz, tid);
-
 	if (rxtid->aggr)
 		aggr_delete_tid_state(aggr_conn, tid);
=20
+	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX) {
+		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
+			   __func__, win_sz, tid);
+		return;
+	}
+
 	rxtid->seq_next =3D seq_no;
 	hold_q_size =3D TID_WINDOW_SZ(win_sz) * sizeof(struct skb_hold_q);
 	rxtid->hold_q =3D kzalloc(hold_q_size, GFP_KERNEL);
--=20
2.47.3


