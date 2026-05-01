Return-Path: <linux-wireless+bounces-35738-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pnM9J2/182ne9AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35738-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 02:35:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 990784A939C
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 02:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B49B300623B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DDF22652D;
	Fri,  1 May 2026 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngcKVwr3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD68221D96
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777595753; cv=none; b=SlZtx1UE3nZ6JwYIpXsHhOJc49sAzpdgDqXRxx5oPM70JL6o3sthVtcFB/3tt1197zH+otldSXjk6wSKoajEC8pKv0ttzcTktWYtJ3dbjmsEPTnu6QZ2v/fH76gVdiCgxTzYIWFj6hmlTXX/xeAYdKZM2mBFjB1vckMXyGDlu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777595753; c=relaxed/simple;
	bh=V7lmIo6YStzuThSfi202zQSDyu+9QN/KHy4tcHqCYm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTc4gE4Vtp7EyJ2sznxA2oX0Yz2ldnbyTby1U9EL/FMPjfIDnmUz0o7CsC3mUQgFcgMDn5OaYynZ11npEE27wu4MOHqs+guL3NabUrDFRnZ4GqEAEdzIY5m/Y1KtYJnaHp8Kq92sCtwKOdAEZFzBozMsISWfmUz78maMHDp//Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngcKVwr3; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899a9f445cbso14476896d6.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777595751; x=1778200551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qVbj4iq96o7Ay2secqPEgWO1PF93KBfrCZ4Yir6DMPY=;
        b=ngcKVwr31tXg0p7GHc7K9152FTZZn9hh5PY3CODJ9Vz0GHLcyXE+EUavEAiwA5qJPI
         Yac6xKhL1tOvVZW38ezWWJxwVbjhMQcMJmPc85m6ZDop2fdkoI0wTNlRV6nfsp46fk/I
         ZmbQXex0sD9MCEaIpEQmHVWcHyddpssKLWaZcOqpnOcTTvNZOr8VfNL1fVwP40vu167R
         aPwz4jNQhlGoeWh/ky/fF0AT9tZaHYDrAUT5OUSfhCvFRjr5+8HAolv8ua/jMidmGRYA
         aOTv1uBZ8fkcp1p5iO9fGnQKwJfsvJBfXZs/WH3zjAVw+T4rsbhR7v00ahmvt9BOZse4
         9oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777595751; x=1778200551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVbj4iq96o7Ay2secqPEgWO1PF93KBfrCZ4Yir6DMPY=;
        b=ljwYDgJGMXTAT7nHNyy8yNOGxURudhPtSWn2EjDMC+C2ovAMX9JufIjRkupwMyQwbc
         OSB8v4wBVa7HSN0xozhXmGRbrPEimdisSUEwi8uxUO4gUNdrzMbpS7RKMebIH2nAhd+a
         BCww92Gzjz2v0+AY8eXtAMc8shLlE2PJj+KXozacswrGHc+6HI+I9fbD7kJd5pokMuzy
         Mifa3haSXYClMgjbE8PY7SUamXHQLb0HxSNUM3NLvGvbnlaszbB0RBngM8+FeUCM6Ji3
         NBRQxEjQcomEEPlnXOwC5dELK/3erkYfN1Njs0r2l2/qAvlz5Ln1wh/8VbK0fuRtBd8U
         tKjg==
X-Gm-Message-State: AOJu0Yz1Bf4rVviOxqRAUczBhKjfKwZVn31UXhwLJeQQ0K6Bs9mczgef
	I+BTc4LZEChCHtE78zE5Z1f6D0oRise8cCFMOyCh5VNGagU4DeYP/miS
X-Gm-Gg: AeBDieuep56AncHmdeq9LLCpotFPD3N4xsIxAiVVwrIvktR23dKezcZo81p5LNxTa1j
	CNuaWznWZjeilaOAj23U14XqV1sy7TSfascVi3N6IlYAtM6h2r6VKt0EoOl7K/sUi+H1hChII91
	ZFdKgfV0QVRhL/N3xl1EFVHKJCe7VppVRnkqgtyh0HhTDLBIY59CMylwXwz0y418baXTawZJvnN
	ByWi6Uwva2cfNzwIX+xnYXoYNF1hh41IbRrW+E46sJijPh/Df1/nck2Hge7K/pWRiKT63pHxtqQ
	h2w6xd/g6XOjmKm1DzsatLWZA3AXKfyRUtvF0mXLmRPBFRA/CaqQxfzB9ncvOqKXhQvCB/6Mdw5
	+ZF17/u8J6dstlpKGPpSMDVFHe88Td19TNN7aZVi/ic1qefpfyh2h8eJDjPGkcsAM248tePYKBz
	LCsH7twSh69Xx15eDm6eZII7llIN/DaDz6RpijvHWrlFovW98HpA==
X-Received: by 2002:a05:6214:4608:b0:8b1:f2f6:33b with SMTP id 6a1803df08f44-8b3fe7af5dbmr82344046d6.22.1777595751571;
        Thu, 30 Apr 2026 17:35:51 -0700 (PDT)
Received: from fedora-btw.hsd1.pa.comcast.net ([2601:985:4883:91d0::917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c1dca6dsm7182776d6.25.2026.04.30.17.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 17:35:51 -0700 (PDT)
From: Miles Krause <mileskrause5200@gmail.com>
To: Mark Greer <mgreer@animalcreek.com>,
	David Heidelberg <david+nfc@ixit.cz>
Cc: linux-wireless@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Miles Krause <mileskrause5200@gmail.com>
Subject: [PATCH] nfc: trf7970a: fix comment typos
Date: Thu, 30 Apr 2026 20:35:45 -0400
Message-ID: <20260501003548.6838-1-mileskrause5200@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 990784A939C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35738-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mileskrause5200@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,nfc];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

Fix a few spelling mistakes in comments.

Signed-off-by: Miles Krause <mileskrause5200@gmail.com>
---
 drivers/nfc/trf7970a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 08c27bb438b5..f22e091019de 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -61,15 +61,15 @@
  * support that.  So, if an abort is received before trf7970a_send_cmd()
  * has sent the command to the tag, it simply returns -ECANCELED.  If the
  * command has already been sent to the tag, then the driver continues
- * normally and recieves the response data (or error) but just before
+ * normally and receives the response data (or error) but just before
  * sending the data upstream, it frees the rx_skb and sends -ECANCELED
  * upstream instead.  If the command failed, that error will be sent
  * upstream.
  *
- * When recieving data from a tag and the interrupt status register has
+ * When receiving data from a tag and the interrupt status register has
  * only the SRX bit set, it means that all of the data has been received
  * (once what's in the fifo has been read).  However, depending on timing
- * an interrupt status with only the SRX bit set may not be recived.  In
+ * an interrupt status with only the SRX bit set may not be received.  In
  * those cases, the timeout mechanism is used to wait 20 ms in case more
  * data arrives.  After 20 ms, it is assumed that all of the data has been
  * received and the accumulated rx data is sent upstream.  The

base-commit: 08d0d3466664000ba0670e0ef0d447f23459e0d4
-- 
2.54.0


