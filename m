Return-Path: <linux-wireless+bounces-35167-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKCPOY2C52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35167-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B5743BA7F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ADCD30DAF2C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE923D7D83;
	Tue, 21 Apr 2026 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs8i07QZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7743D891A
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779416; cv=none; b=BFuCo2luwZiFvPvrg25EcqskgkAcXBjNTQRcDfUsUcxBe8rGetlPeRnMmmmjsNFILi7QcjNm7dBGNwikk21Nek2tSTdfu2ElniVPepNGqrxMqq0e2TcTKVPzQoNm1LPWTipHKfJ5IvvybukhYXWdHzG67BLMAtIhNIMvl4ejYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779416; c=relaxed/simple;
	bh=2H6hTDChOhJd681tRPs65IZJLGj7nl+VOPdTe2WBpD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAHwivatoG5udPp92URvc+gnblBbkzRmOxp5ojeIMyNpUe/V4LrErDlVd8Fiw7MMF59R7ZJBUST4CthplLeMVYiDEXqrNe3tAKdgM1MZDUyEL7/hMSAuNamM8x6icYbq3ZN96VL5m0C/z006nG7yAL2VxPR1yGqQYJTerzqdk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs8i07QZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so6801285e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779413; x=1777384213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANonBuUNxESIZLmfGSljrtPnkc+xjGhwtbNKPAr/9Es=;
        b=bs8i07QZvQWhTNwUa805r8RsA4UwxFFUPs06BpSzNOEOebyymi/TzpklBwRiJY0gkM
         HVefbOl7lbeFUu0UdtzhgvU6Ufhzfh5R+6HNpHl9QhDXI153Ld8LQig7T1lUy0i8mxth
         kOLYO29bMshZiTa1RC8MvCY8Y7EVg5xOhTknIkM4Fao3CmWWJWeDSp82HLegEOogD5L7
         CFFzqoBFkDicShUwabFAq4PNcdAd7debCFzrYDKAJ34eBnZplkTtGogDwNhk+c59Ywln
         uHdzIdTGuW8hP2HLvaAZ2SbPD63hkczT2G2pO8ecjbNCHyTgsbprmX9wAw0Ccnnqh8c8
         gbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779413; x=1777384213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANonBuUNxESIZLmfGSljrtPnkc+xjGhwtbNKPAr/9Es=;
        b=U+DADlcY62zYFtGv3pqNye3+3Vnn3btOY24b74Ru1oAysO20xyWlnXPGcplYfreGVl
         TPH9g4JWrXebHQItkZ3cOlLd0YqPHVyEopWhSw6SOrhT0Po4xEJ/arKseQpjIZdShOke
         C4uC2TDpk8zl3EqHfptlCpTJl0ZAd4SELHae1y4snOS7zSC++wN2x541E867XEAwTmnM
         XNCYmFBo+VLilV0nZnpnziLbYmh3CPqsd3l9qTDn5/3WgfwQs25RrX3uC5gIsD23p+F7
         J2DTR+rzyPe2gNxhxDngVqO1IuB6Ocz2ilPq4VI6laHQv6GSy7B3+7PLdh9NI0tfC1LW
         yiig==
X-Gm-Message-State: AOJu0YwpfSdwwEryyiSD5Y9DosGgxUws9dbUS9P02Od3oDOUgwiusq84
	Qp6SekTod/iZBRDsAN83/4+07MAFchX+h8Kgf5WiNFOUYhGXpXY7dx8=
X-Gm-Gg: AeBDies3AuRvFO+6aWoAV9JGZId1ob1ZApyHCmxkDpwWARQ2F3/7C/i9jD89Mvqk/zK
	anTKRAON8AwlkeEhQiHhiQU8PmQ8A+EiquHrpLF4kQmgSjhm5GJYGoCm3+RZP4uRerMc5d0R8Aa
	51W2SKb/iHw+9OhvXMfdEiY4OkiA+xhf6I0FSPBXqPpSO9GBazH+pDApfUNr9tad2+QG4ELO9Wt
	IIzEshRtu8AxTujM1GTNNVgvt/tbBnNWQf+3/8guEABZVbE4iIYLKqstwgpkt+cPlxjd0PG/rPB
	qIyfcL/Jp9GbqVb2ir56d3ZcpapY56koCE1dSDltrsymp4KfkdYtqVdzHw0PaiTwQp7w/d0Z2n6
	uZQq44g1ORyGp4Rz+gpxbnBDYGaAG7ilNUj0cVSw/8JUt8dagRAdiTBlxwDMH5VWot6vrRggJzU
	pCFQw=
X-Received: by 2002:a05:600c:a314:b0:48a:58aa:523 with SMTP id 5b1f17b1804b1-48a58aa059emr10285065e9.31.1776779413289;
        Tue, 21 Apr 2026 06:50:13 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74eed9sm165464395e9.1.2026.04.21.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 3/3] wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
Date: Tue, 21 Apr 2026 13:50:09 +0000
Message-ID: <20260421135009.348084-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421135009.348084-1-tristmd@gmail.com>
References: <20260421135009.348084-1-tristmd@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35167-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 53B5743BA7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled num_msg field (u8, 0-255) drives the loop in
ath6kl_wmi_tx_complete_event_rx() without validation against the buffer
length. This allows out-of-bounds reads of up to 1020 bytes past the
WMI event buffer when the firmware sends an inflated num_msg.

Add a check that the buffer is large enough to hold num_msg entries.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/ath6kl/wmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 1cafbac2938fe..f56722c5ef5f1 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -484,6 +484,12 @@ static int ath6kl_wmi_tx_complete_event_rx(u8 *datap, int len)
 
 	evt = (struct wmi_tx_complete_event *) datap;
 
+	if (len < sizeof(*evt) ||
+	    len < sizeof(*evt) + evt->num_msg * sizeof(struct tx_complete_msg_v1)) {
+		ath6kl_dbg(ATH6KL_DBG_WMI, "tx complete: invalid len %d for %u msgs\n",
+			   len, evt->num_msg);
+		return -EINVAL;
+	}
 	ath6kl_dbg(ATH6KL_DBG_WMI, "comp: %d %d %d\n",
 		   evt->num_msg, evt->msg_len, evt->msg_type);
 
-- 
2.47.3


