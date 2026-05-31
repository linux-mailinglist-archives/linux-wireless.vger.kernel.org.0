Return-Path: <linux-wireless+bounces-37183-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KNYEsmtG2qmFQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37183-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 05:40:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7AA6144C2
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 05:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04BA130095F1
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8E81386C9;
	Sun, 31 May 2026 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POE092SJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB923EAA0
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780198852; cv=none; b=clntV4men0eaJQQCy6U+2AE/sXoqCS2Dlwq+1xRmd4x5SD75Pu4HoDjE6Cf3Uxjbra2Dcz0zWXvBBHKyLRjIuTnki5wsTqpV2v1lvkgh0ZIEJOqAkLIXQ2Kxc7bvKK9XkJz4RK40CxlBxbTW9dUyzPc83wIRVCzvBLxMR1Lgnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780198852; c=relaxed/simple;
	bh=fg0yy3fJwqNpcCNV0dB9FU4pNtxXKLEJ22fLMwKgii8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r92HWqsVMxTGoEL0By8CxHyDnZx9T7sJBqjoHVE73n3YE+ZvJ4r0gmYt92Ipa1I0LB7L6rCvNdXwDkTNGJWhmx0p73/qu6wJEA0RzTmqBkyg0rFfuzfdB+4433iLhPFqDQndVQ4tDXtvA8deNZXA6Bg1GBHUY5zDjVTLg+A6rxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POE092SJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so728872a91.3
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 20:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780198850; x=1780803650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92oPnPEcW3jTZEwCeMryhplxtuW1iLQRa5umAUmzW1Q=;
        b=POE092SJVajk43BJsQVp0SUUE80x2wkN6QR2OO5245dNiIeGIT75jsuq1QBNGE8MEd
         p9yb8MrzA46HKIOuFb/l3MwQuXgtGh9qh83zHFxm2quUWKin8nYYqwlRvTTZ0UHRSSrn
         KPkRPVMGRzkdKag0kkvd25GOI9LVv4FwyvFtXCj/P2hOr+oPVslv1PXAvsaqnVQtbLx3
         0D3CAjiZXKcZmFvByS4CIhGKMK823sP5281MUcQgc/83ENdDSn7BoAqj9KMTTdrsbjVZ
         lkWScoTTywUxlxoUEk/eCRwY4DwfXUrhIxqDKIkzbDufngX1kMZogQ/M5mYVrAQ9vHgt
         Z7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780198850; x=1780803650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92oPnPEcW3jTZEwCeMryhplxtuW1iLQRa5umAUmzW1Q=;
        b=ZPiEig4qD4LAmPBz/0DrhRVgxHbo0egkcI0HhYNCpie1IXPC/zq5QTWhwktC/mZA7U
         13bGRRMTq71AhV2wgjTqwA93ok6AAqQnwdIvXfcwbn0Q1jt/xyyyYeiEyFKHySCvlBP9
         1Sb4H5a5dIzJA5TUncNjDm39LW8/1YGO0XLhirah2FJ6qsORKm1iqiJBT18tD8ugzYOj
         Lx05v2nAnqatSmDTMjv4Ka9PI5XkI0Gjy91k+2zowJ2GZd3BUPeQzykLDWMTkodDkl+4
         b8Qdva5sH/Fg4ToZubD0DzNwUbjeJnr32B1ynCASCknTjN6v4qclwyI0Aav7/pnhm3iK
         lMag==
X-Gm-Message-State: AOJu0YymLJ02ayeV5PAHRajnkR1bv3UuyKTVlg/xS5YwUd8sNNywzBMg
	Kmv88kFuCvd3afKwL3wKZZPb1C5TLYpLgKC4lvPkaZmYjaG60ZfX56eK
X-Gm-Gg: Acq92OEJ4MO3XEL5c/mC+QZmZHuBIQzDnEWAQelq9/pP7hM5D+e3WHaq9aDqUE3h7hX
	sqsrnHVZ7NL8A+ELhVaRnhDRHjJInL2Vad0O8NpaAMkahlS1rkZ5deHBzKl9lhNoPXQd0BUZIbW
	oudE3LKVlKHrleKkVK2iOu8c7eYfTfkweaIFtrN25lzOlppFQYVUOUSM765T2ppvDZFTXGKa6O4
	KSYiBS4OOfDnqTlhd62D93uCvYxju9EwBdk7HeGC3POBSsvrVxXXGJwcW3albLEuqAefDHyuu7w
	gHwqgcyq8x03JpHmvlFJdx9K0MJjKSe9Q77QlTi27Gcmsz1oil43bHR8jYHiXn2y6ufFTc8Y8Hl
	fVO6QnNKlDmHsjR0B9QM7Aq82dZLurEo/NvBXB9iAhMzX0wc09UNaQg2uilaWaKTj8JDE2Vw6Zs
	jTH2Kex3LoCqqURhXdBmsbcKf2MT7amx3A1diG25w8LbUg3DN1C2gveGUurNzMpZsPr3olBWNzQ
	OMLQhfrxqcan11oIxbl9loaF4TRLUZ2V5m9RpPqQQ==
X-Received: by 2002:a05:6a21:33a5:b0:3a3:a69c:214f with SMTP id adf61e73a8af0-3b427f50c2cmr6201614637.36.1780198850521;
        Sat, 30 May 2026 20:40:50 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1920:4670:4008:f5e4:8e02:25f0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772b9591sm5968282a12.22.2026.05.30.20.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 20:40:49 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	akpm@linux-foundation.org,
	axboe@kernel.dk
Cc: linux-wireless@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH 1/3] relayfs: introduce relay_subbuf_avail()
Date: Sun, 31 May 2026 11:40:08 +0800
Message-Id: <20260531034010.85002-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260531034010.85002-1-kerneljasonxing@gmail.com>
References: <20260531034010.85002-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,linux-foundation.org,kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37183-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4A7AA6144C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Add relay_subbuf_avail() which ensures the sub-buffer has room and
returns the buffer pointer without advancing the offset.

Together with __relay_write(), it lets callers emit multi-part records
where the offset only moves after each chunk is copied, closing the
stale-read window.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/relay.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index 6772a7075840..270a028586bd 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -268,6 +268,30 @@ static inline void *relay_reserve(struct rchan *chan, size_t length)
 	return reserved;
 }
 
+/**
+ *	relay_subbuf_avail - ensure @length bytes fit in current sub-buffer
+ *	@chan: relay channel
+ *	@length: total number of bytes to check
+ *
+ *	Returns the per-cpu buffer if @length bytes fit, NULL otherwise.
+ *	Switches to the next sub-buffer if necessary but does NOT advance
+ *	the write offset.  Use __relay_write() to write into the returned
+ *	buffer.
+ *
+ *	Caller must prevent preemption and serialise against other writers.
+ */
+static inline struct rchan_buf *
+relay_subbuf_avail(struct rchan *chan, size_t length)
+{
+	struct rchan_buf *buf = *this_cpu_ptr(chan->buf);
+
+	if (unlikely(buf->offset + length > buf->chan->subbuf_size)) {
+		if (!relay_switch_subbuf(buf, length))
+			return NULL;
+	}
+	return buf;
+}
+
 /**
  *	subbuf_start_reserve - reserve bytes at the start of a sub-buffer
  *	@buf: relay channel buffer
-- 
2.43.7


