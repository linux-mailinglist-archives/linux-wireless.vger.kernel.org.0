Return-Path: <linux-wireless+bounces-38103-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EjAaMMq5PWru5wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38103-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 01:29:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF86C9221
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 01:29:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TaNTvXWl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38103-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38103-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFF563031FC5
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 23:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948B33ADA3;
	Thu, 25 Jun 2026 23:29:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB92F25E4
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:29:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782430152; cv=none; b=PH+FvNuJljR0IO6tb9hg8JgzwMLXQMmPOeX+WMrbT8gntCAUBapxIzXUKuc2QwVsd7mROu043FhgSLLB/38vRD8DzKQNRcdUi7TqzIykcdcfDAeL98Vemd1FxGIbeKCxsDQ7qnJaPOs3v8c+BitI4PcjuMqzwwzg//g478dbBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782430152; c=relaxed/simple;
	bh=gCg2vd6g9pefNkyTM8ycUQ29luRddCdHcfx3HAGIBTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sR0OvytX+ciy6mPKIIWmq8IaW1JX/h9hugl1MVOrklfkN9SNQKBmNf6ZlajMwiuUxJgM+j/fth+OHLF2t4MKZ8ty7eZ0x8TXc/VFqfTmnBVLqxpU8Z6lh/OPx9BhNjb9VTvS0jaHz7J0E2yKStweX42uFv5E4AWeZPQy0ROQAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaNTvXWl; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ac357c55so3228205e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 16:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782430150; x=1783034950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDZ01kcpbRXceh7FDGKsfrVh225rr07qMNEJSm9awTU=;
        b=TaNTvXWlAlGLm9rxa4nd9UQt+6AI/0x53GfZLqYJHacIPoQ5b4Nit1ps6VK7D3ptzV
         +tt6uvQeEEhqdaN+TKVAyzSJxrojyB/mpU1lPOpbd1eJsEUWzkpPMmZ2nco1E0+DBu9t
         YDZ+oGJ2bIudvW537O2CPnCfI+3+TiB9YmhXZQmosnPpmVU8rnNzAkk1zAtNCZbTAng4
         yfX4Tfh8DhAF7IeGlz/ffOUl2HblCS+pvnlh9jf75uZoalBtjLEgp/0/ptUXqwluOZUw
         Y5va23s+wByGJfmm2DjxsOE5zp339LC12JQXSblGTGV9hhwcZdsTjt1vVOBdBuqjBeI7
         SndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782430150; x=1783034950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDZ01kcpbRXceh7FDGKsfrVh225rr07qMNEJSm9awTU=;
        b=Pr3ai4XvAKgB/0KZ2awngUN49sJzOjiAZS/REEcqvLLQqurh6G4Fo0rZKPr68zPrT2
         DfyKDjaChqnSrynaxdfkPC4SoGGG8sLRGX0p00klBTpOpWqWDbXs1Tk65zLfp9rXopSh
         /6f/pBs4YoY4z9dPq/WYkYqCG+pxEkayZYTM0pzG4fdZ1+EgcDuogCS9cDw+LHDpNwk0
         BYCXQWqdA4083JRBeyftoFMWywpdj/N55GTtEkAlmRJWgNYpaAdi5lqKpP+W+8QUavHY
         uqvu4CY2akCroy6WfZxaY0d4xvtjIQpY1D8/o/CBGE3zICGVRHGg5BrPmpwTA6ryUkcd
         +zYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3SnmAIZaQkRYh0LRfwLmfIavqpmpWxVqsng6WPToYrY8aGMb3mlRn6P+ltZpkB53ofGMMaxAqZK5ewMqDCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6lNeeDSvLVEvc6pizazsVf9MOyr3wmrarYS2T8Nl88YCCJSe
	vKqy9zcic4b+m9UOeCVgmMXH8bttkABaR3v8G00fPTMzDKeiIRjxrysF1Ypp
X-Gm-Gg: AfdE7cnXNVcppnXlZShqQEB06giANHI/gAaYdFAFunxbvkLRW7vb/IW+TmTao4og/00
	2XKwIDSKv7FVeDn+JTCFFo3IYQPzIznqZmBoe70QaFibvghfp32bwGMDabPYm73MqHxn2cGVt/c
	9dmWK5rN7CW7bncg5haCzCpFR0YROglpoyY1WRErDYKle38u4vNSm0GPmUBfe1Jxk0NRKtFBQ5C
	9CylOnoDOpbxfe8jL8MuE7L23dDfb3ay5366A9pSFqTjhKFupLofQXSdLrFyOpPuul+jOdsL21s
	D268/2Lmm7R9qQhPStAJ4O9GM592fmWqTiyytutox/lJA0iWoGEBBpvJftvHUPqYfQiWQ16+y91
	0zYRE35ZvQCZNw+moxRB8FuXweXDyO1L6Z5PdRkGL903mJ9z+9rmhw4qaEQ==
X-Received: by 2002:a05:600d:6454:10b0:492:3071:1db7 with SMTP id 5b1f17b1804b1-4926689faa2mr51981055e9.28.1782430149449;
        Thu, 25 Jun 2026 16:29:09 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee018e8sm21925173f8f.11.2026.06.25.16.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 16:29:08 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH wireless v4 3/3] wifi: ath6kl: fix OOB read from firmware num_msg in TX complete handler
Date: Thu, 25 Jun 2026 23:29:07 +0000
Message-ID: <20260625232907.3620746-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38103-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:kvalo@kernel.org,m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54AF86C9221

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled num_msg field (u8, 0-255) drives the loop in
ath6kl_wmi_tx_complete_event_rx() without validation against the buffer
length. This allows out-of-bounds reads of up to 1020 bytes past the
WMI event buffer when the firmware sends an inflated num_msg.

Add a check that the buffer is large enough to hold the fixed struct
and the num_msg variable-length entries.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v4:
  - Split combined bounds check into two sequential checks to avoid
    overreading evt->num_msg in the error log when the buffer is too
    small for the fixed struct (Jeff Johnson).

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/ath6kl/wmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 3787b9f..a572952 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -484,6 +484,18 @@ static int ath6kl_wmi_tx_complete_event_rx(u8 *datap, int len)
 
 	evt = (struct wmi_tx_complete_event *) datap;
 
+	if (len < sizeof(*evt)) {
+		ath6kl_dbg(ATH6KL_DBG_WMI, "tx complete: invalid len %d\n",
+			   len);
+		return -EINVAL;
+	}
+
+	if (len < sizeof(*evt) + evt->num_msg * sizeof(struct tx_complete_msg_v1)) {
+		ath6kl_dbg(ATH6KL_DBG_WMI, "tx complete: invalid len %d for %u msgs\n",
+			   len, evt->num_msg);
+		return -EINVAL;
+	}
+
 	ath6kl_dbg(ATH6KL_DBG_WMI, "comp: %d %d %d\n",
 		   evt->num_msg, evt->msg_len, evt->msg_type);
 
-- 
2.47.3


