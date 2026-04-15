Return-Path: <linux-wireless+bounces-34825-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L6KCv4P4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34825-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C05340891E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC3A9303D34B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5439151D;
	Wed, 15 Apr 2026 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcnkJsOv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65D3909B6
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291805; cv=none; b=P+F0iPnWf5No7hpaxL7C9LvQ1aliCnd0PqmmgufAuhbTJAShERhi1NPdnf72vR30p3SUE/SzZbPx1dTiFtmPr19hmtW7Rc4JsmvnmuGviBetTIUx9fkkyZaWxo8PSBvO5QS1xSCBuOJ+FfPRqx/D3YK+hjGdhqaQ1ObGc7kuvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291805; c=relaxed/simple;
	bh=tGljGO9tzKW8lni6xeMPD7R0c/Mxcc3qq+fWX9qFIS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMBsIpu/72xHkdZTTUnnm+i+To1c4CaBqbjRGhPF/oaUjAOOyZANj6oA0XMJMcP0on3xtxRfQP8ZBKirzfWQvIJ9mEcBWKp7G69MGiKJRthYNJZvgk6hzAxmfMURT189lFUcI11EEzZ00PwkOc3ylS1GfrZQ01cMtoLh4hiIERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcnkJsOv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so66783325e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291801; x=1776896601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPRO7u5vAVBFmWntFw1KXmo+AzHAOpXCPHhKh6Z1jzs=;
        b=mcnkJsOvD46gyQNcdfpupUrGFqSdR3m4Q+FDSEdnUfHHyqX/7AYQ6FcHkXQVoTrslC
         jvbFeqoVq1rTYaZdwgstdMq7Sq931OHhTRNg9Az5Vl5ztXVVZb8/EvTptTy2XPps9mgJ
         5HZR4qO/bMZvjUTWrey/JoVvhhsvqZcUOIEDhI+oB96d28g0FUEAxyH7kH6Iy0BDstZ1
         tv78sRzE+zIaxmo3aXbR9/yTZdaRtjHoisCvxgim/rTK9gePOGWYJM8RppE3gePYXIn7
         e3uy6b4q/kNE135wbw3Iv+qou4vPiN0Qb21gS6Xn5uuV4wV8nO/OcmCqJkODyQN6FsuM
         1XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291801; x=1776896601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPRO7u5vAVBFmWntFw1KXmo+AzHAOpXCPHhKh6Z1jzs=;
        b=qx2na+QL6Ju+M7ixNEH8MYEcDceQ8wenb4KrhQlYTiLKu1aZ2fLEXIVE13MQiwYkEl
         bVrC0jvVit8IrmuRug+Nz5a9Vo+9wUuSwF5MAw0q1Dph/ANHMNqap279nRN6EpdZguit
         xHQ3HLKI8HSg1/oQ4VgrspWeKDRlR5zEB1E94B2awX5WDPFi36w60y6Htr45a4BTCG+M
         fAMshASOVOD2cLbr5YSag78RXabRHscYSQ/jhdA7xhB48HWnQzBpe9yx2o0QV+rYLUnF
         wL4BUuzVbUoONmX4zbQOscFrCP7i1Oj9d2+nYEEvHcJ/jUp4T4k2YaIxTS0wKu4DeD/B
         oVkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zXwmFnx8A7u8ujnjnhizUt80DH7eNagWx1HGWxG1m1hP+N6XQ6k35TCDTpw+bzgnYRh/caWJOQeygHtJIyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymmj9nWs21W6KIeoK309Yph2lLcVCRRxJuanH28U804L2P0U6q
	uAt8xk3ZaC6c2xBgbwnNTusnT46nF/HH/62p5PMksR6UW8lZmFz08nc=
X-Gm-Gg: AeBDietnOLNdSzpBGMmtBVQbK7UjY107Rfo9vCmQBtp1/b/5REFC+dhuckFez4sttul
	yT5xDf5+u3rvGhmgJq8y5YyHMmB2pYC3Lt45pW1/702IQ0vxHXx+4fP6g/GFk/POFbJj0D6YU7h
	HTYqIrxZvYUamEzm/f95p4/DCfIhUODFzRGoUCK5hlwNHb1k9aus4uKlqczL0SMq8IWJ8V7+eLs
	2a2/jLbSnWn2nzOoWS83hF12aL01yRWS0WG0Z4Yf7M0UgigmExQfNGpxltm70Kk94HY3PtJRd5Q
	AL7W7GAN9phnnSw1Z85SsdO1/ys9emJkeA8HYkmYzPrlfQs/JeOkG8mZVhEp8hBWuFZIb3l2YgZ
	3M8aI0NJTyPobyWm7CQQi0+1O5l/90DZ1lijLJlXGdp9y6zbgfGjLLsv/+kqH+qPlhyXPoSrqat
	bjZ3w=
X-Received: by 2002:a05:600c:5d4:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-488d6ebe787mr192488315e9.15.1776291801139;
        Wed, 15 Apr 2026 15:23:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9a742sm28702585e9.14.2026.04.15.15.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read
Date: Wed, 15 Apr 2026 22:23:17 +0000
Message-ID: <20260415222319.1538389-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222319.1538389-1-tristmd@gmail.com>
References: <20260415222319.1538389-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34825-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 9C05340891E
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
Changes in v2:
  - v2: bound memcpy with min_t() instead of adding early return after
    carl9170_restart(), per Christian Lamparter's feedback. The restart
    path must handle queued responses gracefully.

drivers/net/wireless/ath/carl9170/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -151,7 +151,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
 	spin_lock(&ar->cmd_lock);
 	if (ar->readbuf) {
 		if (len >= 4)
-			memcpy(ar->readbuf, buffer + 4, len - 4);
+			memcpy(ar->readbuf, buffer + 4,
+			       min_t(u32, len - 4, ar->readlen));

 		ar->readbuf = NULL;
 	}
--
2.43.0


