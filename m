Return-Path: <linux-wireless+bounces-35143-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAV1CdGA52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35143-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:51:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9043B8E1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66B723028C0F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6FB3D7D66;
	Tue, 21 Apr 2026 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNZIam2M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815773D7D77
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779365; cv=none; b=iEbzItCGIt9rwPHoDCLNAwNA8tIBnBABbjzA3lSk4YRcWEdOS2bPDIhxoSTQRGbfrzrdI4kUDPIzdB2IlLTOZsI2U7XVtxhqlUAQwizW8XnSNxGXf2tq69u33xeYr+PMf5RYJZZ6PGUBsJp5nU3vAxhTMFVKwRVD5j2snxJo4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779365; c=relaxed/simple;
	bh=FsEyNcKsmbVeitLlbdRRJsSH2nfyg+nEiUQSAafRp2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dc/Mzayyd15lFyL8cKtTwyyAT5q0vw6NtqkCdH4pyz2IC/lgLlrnxWVl/odwXQ9Pf+d0fg9hPUr4HO1wvqAw8tQWhMsM2YgXCme4Nc771jhdB84gX2v8GxbWpXvFDhzw4v5ckc5AUyoae8fbKJRE2yBdHKkIcFKfUwPBZnw3a4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNZIam2M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso43559185e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779362; x=1777384162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+urhPHXHrBrUh/OUNLHYjk/e3pQVaD+/6s/iaxBM7i4=;
        b=hNZIam2MpJ1lG8deZT13BCnRkElSpk0ciVCl+F4v6Y+vOFRtNk6hh/iEEPGDZyTJBP
         CWC31fnVMHLolXiPwqUFH2SDrxuQxWLIthxtMR/oUoy6XHm5hru+xUr6vIrZMXI4XAGm
         qzKZUHAOUpFklacOXkuGyJuJ1ufMk+877loGFBMh0wh6kB9SsRcfj0Vt4DCB9xAX1w93
         0NxKfq11I4+JLrcrrG3oWmtofZ662uysG/Ssy/An8wl3PeHBxATMOdRCwI3XGp3nqipl
         xhw3hkM5587VlHfFCp1kx8sOIXyq/zaOwHSLK40RjqIRAWl0v0uyXnL7kK9NIDywvsx8
         kxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779362; x=1777384162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+urhPHXHrBrUh/OUNLHYjk/e3pQVaD+/6s/iaxBM7i4=;
        b=qdOn+zP+61hyEBA6KGmuIV83bEwHwkmr7sytisDwea3sCkPS88iwTN1CA3vift5s6K
         rCpkEIl+V00VKYgV2KkDZ/i2siXIw6DWZET1bCDZHon99VsE67t1xU+ELnyFoXhZuB7K
         tEpeSl7HTMyD6WuGpoBUmIcQMatp1jknpNtfrhhSrE6vKubJ2bsPDnI5/cOzkg7vGw4M
         boPwzJjPpxSl/36m/4FbLEsO9u5NXbSYS6qZ0KEp/U8sdlKCapvgj6ZF6H598YZLBU0p
         1EdgOgGq/idt3ouBXuk8MxRQh0h/6N48tZ3LQ7uhXvOmY4is9KsvfeawH+HcjUSl+ZTF
         YQ7Q==
X-Gm-Message-State: AOJu0YwK9R1trWurtMvUUzwWuUnce/M9/X2numZrtEPVDlOaZoeygr1i
	1UbqgxviGav4o7g2E16I0V8ZeoHdoXhOXygzY5kc8NyuxLqX53mJLDs=
X-Gm-Gg: AeBDietC/2MH6UQryoBkhLyJysneuT9ys71FNzkJhJPd48JmD5nIakpRjfxSwHwY39b
	AbBU4IkwSawR14FVOit/At9HVt4NgxwKuJASRgejCZQRDq0MRG2xVVxgAgHGdLjLT9zR+wbfu8u
	eg82SGkZMA3spufqTCx8LGRnQhawof74qJYRDec9wGARkACqq1D8DcaEx4X6O5Ly+rNVPer9cuY
	z2aPZDNwfQemTTA9Qn2bY7gvYbbVfpKaqyBiAlOeYYM4ghPaqjNPbDJJcblRkD8JbpQB9ATbWLj
	GQvfZpG62EAohAiBm37bteWiiDRorOSHWmoIcSl4OEl/yUfdIBS/8pSQXg0NzOnel2EndvUpRUA
	xCcxre/hXpjzv+99lHSjGcoFFaJugppzEyna8CAq7TMpJz1l/8O5SDcSARgcqWbmB+1E8tk5BO2
	0W0dOdtEmoV17z7A==
X-Received: by 2002:a05:600c:3483:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488fb77d343mr244747025e9.18.1776779361615;
        Tue, 21 Apr 2026 06:49:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm134028065e9.22.2026.04.21.06.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:21 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 3/5] wifi: rsi: fix OOB read from firmware pad_bytes in management RX path
Date: Tue, 21 Apr 2026 13:49:14 +0000
Message-ID: <20260421134916.317971-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134916.317971-1-tristmd@gmail.com>
References: <20260421134916.317971-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35143-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FC9043B8E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled pad_bytes value (u8, from descriptor byte 4) is
used to shift the skb_put_data() source pointer forward in
rsi_mgmt_pkt_to_core(). While the existing msg_len -= pad_bytes check
catches the case where pad_bytes >= msg_len, it does not prevent a large
pad_bytes from shifting the read window into heap memory beyond the
actual packet data. The resulting kernel heap contents are delivered to
mac80211 as a management frame.

Add validation that pad_bytes does not exceed half of msg_len. Alignment
padding in 802.11 management frames is typically 0-3 bytes, so any
value exceeding msg_len / 2 indicates a corrupted descriptor.

Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/rsi/rsi_91x_mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index 7f2c1608f2ce3..ebbc2a43ddfa6 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -490,6 +490,12 @@ static int rsi_mgmt_pkt_to_core(struct rsi_common *common,
 	u8 pad_bytes = msg[4];
 	struct sk_buff *skb;
 
+	if (pad_bytes > msg_len / 2) {
+		rsi_dbg(MGMT_RX_ZONE,
+			"%s: pad_bytes %u too large for msg_len %d\n",
+			__func__, pad_bytes, msg_len);
+		return -EINVAL;
+	}
 	if (!adapter->sc_nvifs)
 		return -ENOLINK;
 
-- 
2.47.3


