Return-Path: <linux-wireless+bounces-35147-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aObSEIyA52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35147-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:50:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B3243B8A1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C455301BEA6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818103D75D3;
	Tue, 21 Apr 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4jrl6sW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FE3D6682
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779374; cv=none; b=n6+AVNO3S0RQxPBhbUhhsXyKoIsaZ6XpMWI3MHTPOy420L1l3wtu5NIp9Ob76whyfNQ7trX2ShmKoEH6JGnRLo5AoQw8r033RCENz0xAuxAwgEX9kKYJZB2Q2S/dUFFEamZjMcLkD2e5PaIGCqykItF6lgnxLTFipmwvDAI3KRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779374; c=relaxed/simple;
	bh=eU2PqVajCx7C9hG12bCOjfZ2cSR8pQR5MC85pWwkEJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTk96wGk5QkHKPQl6vzYaUVOMGUsXlwJrsgzkZLdNnru8Oawb3XscGUot9X1LXZ1hPXSJIzU/wwhqL9Xjw4LOkcNyCVucsJHKtrrQzOxJ4J81qfTAnpu1fzgG72xG9EzhT+X+fue7364/LwNv2E2mXVGeMLNZjT+g1gpXfE76hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4jrl6sW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so30051935e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779371; x=1777384171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkmQzi5Gnl//BDK8FQBprWJdIzhvbcB7BpCe6DN/Jac=;
        b=M4jrl6sWmdKIycdOcrf3MkbusxYOZ3IAHQfF4ZaJEH1azu1bTU4RnuF3KoNXQNUijC
         feKee3bxVPpEW9aqGU4lwCR+AsR+/Ki9+G2xRJcyJeW4mgJLOeNhbkhmpUdeDAr5Q/eI
         Mlb359q+J6LouX3KBJE19eFxu23VTaoAr7SLDTEIIfvh3Xd9XzX4CwlyGKCl62KmZel5
         9owbh2s9i4qokv7oXxklMw8r03u1rpT8RDs08b9ZO5T9BrwTOvH5ZriN67NHq90w9QNq
         O5ak9MSGQJus/dX8KEklOURzV2jmXopCCYLZc87AtT2Faz4X0irSEstzTOo3lHA1DbBM
         aZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779371; x=1777384171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YkmQzi5Gnl//BDK8FQBprWJdIzhvbcB7BpCe6DN/Jac=;
        b=HnDQSpfz8cbmnb1lD6X1gTXrpIskiU/JiAr4Xa1/WVSLQg/OIy/dFmQuc+LULbqStC
         PoWaIyT2LOnrSALgw5tHLWJu05TtHXjbUkmczM2wMjmhPD5SGMyTg+N5HGdCjgeON83a
         jxtaGUBIrJsGJGUf1VWcW3ewHo3iaPyOlSniU748xXfJav1YNfP5A02yxaoEqKxZ+O7Y
         x91e3jXsM41m/tMI5r7SlqW6kkjpoXCFQpROV5O4whtpp4wp5yvEo6y8w0gMq85HMLJK
         Zl1/ZBq2/GhIWUDgUI1Li7hLFzUo8r+OXapiPSwiKtN8zzZug9ScRwbIK1wgIiVdSW82
         YxQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EeOVXGpowuVpbVGfob/s5oWoLbwSr7t5byb+eG4FGLalaPd+9IOuHmCsZUzJYVzz+8HthC7M28m2ywSu1MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyswfvmX/ejx2ZC5DPb2cDCH2dF2Mq+WlD0ybZXs6gi4wsyQDxW
	uc0CkXlhnIGL0fWlTIb8Kfbg3+mNq2wLJdWtf56ObwIEWV9dXeQfRD4=
X-Gm-Gg: AeBDiev9TcI9/7TZOlturY+LQotnbl0xagJb5uVQe0Iin0rksyvufXcogCXj002vr8t
	vxHeFZea4F7vqYCWyKVdL5QnaZ6BMf+EjfaSlwIv8YVReMjcMyNQZ+5C3DjtQOIvF3vsMzIMIAu
	pFhTHLW2ZXWS2JWnf2grAWqwIHJMrLT8wwQvUSmry1jcy2PvKrMuVUCleu2k4R6Qgf307xFYhet
	VHILPyU8SrYw3ZvQOQTEv8t2DPvyELrWRRQKU5vXpA6H+NsjH+v5wUqCv/Kywtcx55M4vrdKSOG
	HrDlSMzH07QodATQQMaS5uwZJ7izS2Sc0P8qmQSpG06N5VC4Y6uaIgT+BKLQsmuHd7zCG3aqJlx
	Xm4NLKYcF5ykeVD7L/3mzDQGWpepm+tAGcN/PNifWr09EPRy7wMhA0ErhQCv7Rr8JGpB5uusaWb
	yat/0=
X-Received: by 2002:a05:600c:3e05:b0:486:ffa3:594 with SMTP id 5b1f17b1804b1-488fb78049amr264260995e9.23.1776779371241;
        Tue, 21 Apr 2026 06:49:31 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c318636sm168157785e9.7.2026.04.21.06.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:30 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/3] wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read
Date: Tue, 21 Apr 2026 13:49:26 +0000
Message-ID: <20260421134929.325662-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134929.325662-1-tristmd@gmail.com>
References: <20260421134929.325662-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35147-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 04B3243B8A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

When the firmware sends a command response with a length mismatch,
carl9170_cmd_callback() logs the mismatch and calls carl9170_restart()
but then falls through to memcpy(ar->readbuf, buffer + 4, len - 4).
Since len comes from the firmware and can exceed ar->readlen, this
copies more data than the readbuf was allocated for.

Bound the memcpy to min(len - 4, ar->readlen) so that the response
is still completed -- avoiding repeated restarts from queued garbage --
while preventing an overread past the response buffer.

Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/carl9170/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 6833430130f4c..f6855efc05c0f 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -150,7 +150,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
 	spin_lock(&ar->cmd_lock);
 	if (ar->readbuf) {
 		if (len >= 4)
-			memcpy(ar->readbuf, buffer + 4, len - 4);
+			memcpy(ar->readbuf, buffer + 4,
+			       min_t(u32, len - 4, ar->readlen));
 
 		ar->readbuf = NULL;
 	}
-- 
2.47.3


