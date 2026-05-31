Return-Path: <linux-wireless+bounces-37184-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE+JFNCtG2qmFQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37184-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 05:41:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3686144C9
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 05:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 507813007AF1
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 03:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898A223EAA0;
	Sun, 31 May 2026 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScG6aclK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC01386C9
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 03:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780198858; cv=none; b=JczQwEvFkCTJ3W1tHAMMw6ZJLAdjRHRyogYjoIJnBJG+aXCJs6rMJD2fufIAxbpi8OHslPfNKNhsxEeUa90vjZ0TQNJ2rwrmw+wn7GxICuH3tvfwr8604CYMvVi7lxcseE3M7u2y+V7kBroyh8wTepyn1U8zvIT/ZYyoegagNbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780198858; c=relaxed/simple;
	bh=5Zei0R41w/WF17KfaEoTqAP8zGUqVPeyB4fm1Y6K4sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8OYqZxYC1ofi5tw3cbwcQ7GP13HdVtmH8IkcLeDdRuKMsy2pYy7Zh5B4PcAGjq8BzDAFx2qmmJ26fogZw66ZLVsaDy2XZ8duqpvlx4qfg2mR/QeDdL0DLxD6zESPEZhrpcnnLcXvzCh0TYwEVKHJHHzAOffOmaPRZQf3jPmta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScG6aclK; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8571db044eso1416628a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 20:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780198856; x=1780803656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBR7bidanyoH2ygGMCgVXm0sY23cGadSrOzvqll/U7Q=;
        b=ScG6aclKCbCdUy73LKSUDOT7OyvPNNrDFZyTUGSgdMto/V4kP1sH1iBp6VYe458wLX
         t9pSz1NSwEZ/BKLGDZJ/0s31g74zDAuzGuRzeYiCvxFX2bBaB6Un7EUl6ucIioSawe6S
         NYHTFVbuQl+X32KJH/bAFGrlJ4esOzHw5SwxuME6jT+zIbyhAQ7pzjzu2KpZuQwlUnQT
         6eGXfXO/T8V4oRflm78lUZStoKs28hmojiu2I6LfzUFhmP7znXj93GS9tk4xW47/K7SW
         Sw600/MOjArrwFCf2FosiikFnaH0MVugCZFi/QfXx7XNzj6bXxoqMRbEvF9+NigSMasD
         1nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780198856; x=1780803656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dBR7bidanyoH2ygGMCgVXm0sY23cGadSrOzvqll/U7Q=;
        b=kN41aFcq33xx8fQprCmBNA35PPKAJqhXugoxwytXS27M/6STD2qpF1swP43S13DrlR
         6R01HisCJ7k+etWV/kzgtCMWAqOtn1M/shGDxzU1TENi0b8tcrppEW7uCgoyk78tYuyU
         sVSbD2yYeH+cna386qVw/SaULAQjZ8A3NehZXZKkrmDV977fQUbZ0CZAtsoIuAQVm6ds
         BnXA5KafWKMnitXPyNRaKBVTHquPXd0ZZ0RV+WQTFU5gR8wt6i3zP0z/kwTvajMQwJnE
         EsDWK9PAYt9QRaEGhycUKWW67O/W5sdWBeSsCaVjR7E3v+c85H10vk5O5yhfPuzRrBt/
         3MmQ==
X-Gm-Message-State: AOJu0YyVRXBL3yrcDqMsW9DK13UkGyF7iBuLMcP9U00efyDbSPckMe1J
	cyw2tQm/FIjyhQcj/jBWuZ8iyk4HfJfys3aGApOFug3BgML8HhlQ6wij
X-Gm-Gg: Acq92OFKtn+TSwUcjzBe0IYapMD7YVlVSYU+b+s1dOEqHky5yhy5ptGuH9kRH5Jsm+H
	NZ9vpni0r/SfE36yrgSgcQu6B4ncIbs1saU7oBfZZq3D7Kij3zvhHo96zFmwo3KOqKUpwjdjgpi
	lNX7F0lOaDDJ9kg+dTEpbKR+HMSDC2jokMIqkLXb0/BMQBMvW9CjmrQ4GmCL5Z3qECgtVXvu78R
	RhBztW3XV6Gv9Bbnki1TRHJer27AZpN3+LVo3BmiLStrERms2bLoHBNcjc1b1KaTYiTUNJXN9u7
	087b1uKBTn4s6soDldrgdnm+qTysrpSHVhEllST41pXVFFRwswVKZLuAyX6DqgMoZd7H6D0zHQV
	Ey3yn0eemfhXspAmuQyYeQItiDn4LZfFbDkBSE8zJYZ7sSf/LHh2JZvpgaIxZwtdJvQlAF9uhqx
	xHYpEiykj6C02G8mBHTvbh/6YLSyLOQvIs3WKqdGjarzaj7q+kM3RnxJjuiOi7JnGVr5rUbUrfb
	8i/glGLA+2Er2X/6Jm8bo0zoZVJeU1GtlyxRWvPIQ==
X-Received: by 2002:a05:6a20:ce44:b0:3b4:dd7:6304 with SMTP id adf61e73a8af0-3b427fb6867mr5921117637.8.1780198856634;
        Sat, 30 May 2026 20:40:56 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1920:4670:4008:f5e4:8e02:25f0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772b9591sm5968282a12.22.2026.05.30.20.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 20:40:54 -0700 (PDT)
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
Subject: [PATCH 2/3] wifi: mt76: mt7915: use relay_subbuf_avail() to fix stale fwlog reads
Date: Sun, 31 May 2026 11:40:09 +0800
Message-Id: <20260531034010.85002-3-kerneljasonxing@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-37184-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 7A3686144C9
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

Fixes: 988845c9361a ("mt76: mt7915: add support for passing chip/firmware debug data to user space")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 27 +++++++++----------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 26ed3745af43..d564b265dc27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1346,22 +1346,21 @@ mt7915_debugfs_write_fwlog(struct mt7915_dev *dev, const void *hdr, int hdrlen,
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
-
-		memcpy(dest, data, len);
-		relay_flush(dev->relay_fwlog);
-	}
+	if (!relay_subbuf_avail(dev->relay_fwlog, sizeof(rec_len) + rec_len))
+		goto out;
+
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


