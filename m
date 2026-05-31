Return-Path: <linux-wireless+bounces-37185-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KpEMtytG2qmFQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37185-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 05:41:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD86144D0
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 05:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A3B1302F721
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 03:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A2F23EAA0;
	Sun, 31 May 2026 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib4TqtGB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13121386C9
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780198862; cv=none; b=pVdq4YMvCdPUb85gRRegrBIsbE2OrvFEa1s0SEW0r3RHvuJKRmBRIn28V9DoItwVyzw9qaj5FhczLTujC+8l7gT+/CrZbb8znCJtlc+femzfhMkZdt5g6u2Q1Lj9s6d7uhIlXH9+I7zv1CVXz27wqkL136wD7BP3R3El+rJY9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780198862; c=relaxed/simple;
	bh=Sv6rq0AG3/f9GqDEjhp6qqL8zXn2MJMNhTNWumMY4I0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IhFcV0JG9N0Pv8D9UQFLCYIX+Q2wE3u8TY56bQj5Gt6lHXBnsQAw+5VPeQ/VXcnJZVXe8axiAFIbcqMquG/eouvIp/5HAwnXDF+jvF9vliO4fGl5OILfT1MykQhpDcqn30IEsMpw1zliKRPVFdkNy2BUSkCB7i1cuFj2sImC5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib4TqtGB; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8573e75425so698282a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 20:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780198860; x=1780803660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BQvtm3MVwJelwVogxVM2onwtjJe3OaA1y7rRZKEn8c=;
        b=Ib4TqtGB0wKn5yKcigZZoOulr68bCrHs2Rabu6iIs3MnBc4g8DG93wiuNJ6unDu0B2
         XhlVUTZDDE3SAQ1MM0sgNHRn6PunC7VAHJwk01cA2z7ooXBENx0RzSs6FXINBlqXTe+z
         4+Vz1G8DLLJN1ZgdXirWovrE9bb+Jz/1v14N+1oBo2oJcx8e3zki5j9iP7X2Rn+cU6OS
         bfMOm7AWBMqu5HE99bym1SiClKOwl414OkQ+nanvoph5XxsDGIJQGXumdlpSc9MFCOvm
         qYI/+zT9Foivnh4iBf+pe8vy9cmNa5aYhY27T6sIs7wVaH8SgXwZ86RqILqQPHgi74y6
         B94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780198860; x=1780803660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4BQvtm3MVwJelwVogxVM2onwtjJe3OaA1y7rRZKEn8c=;
        b=jwVEVZQqeBbM9ciqEFgzkLeaZ/LSU34nTWpZTn170YxT/KQNkYSj3AKEORtdGih0ap
         Aolbukcb7YoknkBEOwf/2mxIQ94cFuRlIjEhyNKlDA1I3+4/9f1y6kwe8Sqr9J15ckvC
         awW+8f/4jFujh72PgQx5PN9xd52VrVuGynPF4qJ2oqIHuyRmfFXg/y1l8GDIr/SljAUf
         K8brD/LxO55nUkZNZj//FYsS1pWbpALZhUUJFtCfUfeOy+2DHIoa6Yd0rgz966xv3pyi
         kfBi3aOgE5GHhWVeinLseiTyFpswOSLn0dLLZIoz5Q9XjyPwaybniDoWUQ6yQ4eW5CU+
         eA9Q==
X-Gm-Message-State: AOJu0YxiBI0rY+jHjgAn70JtvKYAqcB04qjvlZmZfZor8TNp2CGBd242
	EHA3iBqOpz4Brsk9CorN7QnxuFbNphgRpY/rPoAh5EW4ufEYM9juznWv
X-Gm-Gg: Acq92OEYByCk2iQhVkPg1Nj8q5ASi0nW6UZSsmKh6MQFEr/pL4wH86DZjRFAjjvyhxa
	MPE9FHifL2JlQW5So+tbeNTI5TYV9vatzMssp6fdMfMvVuYsvWIk1OZzfw2fcqEO8yM7s+NR5yi
	sc6ViBY7xPn4IyY/tbbulc6OsTKYLzyXg7o4aiRHqggayvTx9Rh4ope2dnrlH/HQhL6ymMQzooF
	QFIBvrMAQ5esbgjo8PuJVT2MDL9LYBjrFP2lDTR62jp0EgeEgc6mqbWjyAfRmrdhLGmI7kwkphS
	3fSy1qqXAop1UkzRDxYylYWyq/wetItkc4cAQJ3y8mk2YCeen3ChdyI8GNDC/pjDmXtWDOZ98ML
	Lv/zx7hXgyxQue1B2HfBAbMsHvEfXkFvgrmA7GAdeXAmW2z95O2dekFIBhIGWNmpoSlg8Lbckp/
	aM29I+ltIpdBRQwvTNISSPOu/VbSNbCSukTx5fuiFzAyd4sTMDPVU5gQw0KQ+S8qFakRogyiw2c
	0SQxIYyNivP4GWxplTm2DhlJ/vduIfua4ajKb7HoA==
X-Received: by 2002:a05:6a20:c6cd:b0:39b:edcd:d92f with SMTP id adf61e73a8af0-3b427ea8c06mr6024351637.11.1780198860119;
        Sat, 30 May 2026 20:41:00 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1920:4670:4008:f5e4:8e02:25f0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772b9591sm5968282a12.22.2026.05.30.20.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 20:40:59 -0700 (PDT)
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
Subject: [PATCH 3/3] wifi: mt76: mt7996: use relay_subbuf_avail() to fix stale fwlog reads
Date: Sun, 31 May 2026 11:40:10 +0800
Message-Id: <20260531034010.85002-4-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,linux-foundation.org,kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37185-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 29CD86144D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

relay_reserve() advances buf->offset before the caller writes data.
Since relay_file_read() uses buf->offset as the readable upper bound
of the active sub-buffer, a concurrent reader can observe the
reserved-but-not-yet-written region, resulting in stale data.

  WRITER                          READER (active sub-buf)
  ------                          ------
  relay_reserve(4+L)
    buf->offset += 4+L  ---+
  *(u32*)dest = L           |  (offset already exposes the slot)
                            +--> read(&len, 4)  => L (VALID!)
      <<preempted>>              read(buf, L)   => STALE data X
  memcpy(dest+4, ..., L)
    [payload written - too late]

The userspace reader [1] uses poll() + read(&len, 4) + read(buf, len),
which is racy against the relay_reserve() window described above.

Switch to relay_subbuf_avail() + __relay_write() so the offset only
advances after each chunk is copied.

[1] https://github.com/openwrt/mt76/blob/master/tools/fwlog.c

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 34af800964d1..82f59a7eb508 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -914,22 +914,21 @@ mt7996_debugfs_write_fwlog(struct mt7996_dev *dev, const void *hdr, int hdrlen,
 {
 	static DEFINE_SPINLOCK(lock);
 	unsigned long flags;
-	void *dest;
+	u32 rec_len = len;
+
+	if (hdr)
+		rec_len += hdrlen;
 
 	spin_lock_irqsave(&lock, flags);
-	dest = relay_reserve(dev->relay_fwlog, hdrlen + len + 4);
-	if (dest) {
-		*(u32 *)dest = hdrlen + len;
-		dest += 4;
-
-		if (hdrlen) {
-			memcpy(dest, hdr, hdrlen);
-			dest += hdrlen;
-		}
+	if (!relay_subbuf_avail(dev->relay_fwlog, sizeof(rec_len) + rec_len))
+		goto out;
 
-		memcpy(dest, data, len);
-		relay_flush(dev->relay_fwlog);
-	}
+	__relay_write(dev->relay_fwlog, &rec_len, sizeof(rec_len));
+	if (hdr)
+		__relay_write(dev->relay_fwlog, hdr, hdrlen);
+	__relay_write(dev->relay_fwlog, data, len);
+	relay_flush(dev->relay_fwlog);
+out:
 	spin_unlock_irqrestore(&lock, flags);
 }
 
-- 
2.43.7


