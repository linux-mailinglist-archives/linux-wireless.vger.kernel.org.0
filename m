Return-Path: <linux-wireless+bounces-34963-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /RaVM6DT4mm++wAAu9opvQ
	(envelope-from <linux-wireless+bounces-34963-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 02:43:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07441F7B3
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 02:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12AB33039FD6
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2026 00:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B3023EAAB;
	Sat, 18 Apr 2026 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlNgHop2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2247231A23
	for <linux-wireless@vger.kernel.org>; Sat, 18 Apr 2026 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472987; cv=none; b=HhRg4LUXHL+LJksbC93bEn5Qzl9IdAA6AHbG4fPIFCD+2weBchwMhpsj8VAoEj0IYUZ0velK5sWkIX/UqwklYSlyeL4BJH+bPLapG8OyVbMuwdqGTn2E8C/eOU01wQyUc/4B/QnBpgdZqA/Z0u9lccZq5laNruJT5rt50GGYtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472987; c=relaxed/simple;
	bh=AJMBkoH3WQnihpq57wIE9dMpIQhQKm8cZs6NWWcEJDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtZPMIV9DwiVl2qLZYx1rHOX1lhW/xPOlkkz3n/eywCV4RwDU5SOC1QGWy3p7eVidv4LbmHbaAgz3hiZ+cIhX7v/egtPFfkrUNSxp4va/zjnYuHrJmnGmg/6yJ/xNT24XwLRBOSuRWYsyhVHVDC+MhG6GpNllZBURtoD1rUYzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlNgHop2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso11573685e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 17:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776472984; x=1777077784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Be+f4m8FGLJ7B2IMiGCObbiaQ4SmkheCMfMOaehd4dM=;
        b=ZlNgHop2rBE1UqQaBnRGrHa2NLsozS9sSvgYXoQYnUautHy3lvinJawjNs9aoGJ93Y
         J1N5qZTt1PpSquY5mhOgrSaERvelB3TZb1dx6BcZN8cJ+nR60QMUfvUw2tS94YkGZrdN
         DGvU5g9F1OI3JLs+87f+pOMexPgoOaS1WWsCSSGiMxrP9Wxsn4aIhNSx9QusinKN9ReT
         L7jc20YLwbPL7mSTbNTZvYceT01hr41yr6DQ05iLD7KvECStK6eGB6ocyYHwENW++yAC
         ZXJux51qvK+cA0MRWGwwTjxxbgVAW8sRD0KTyRJnYiBM0Z+HZvlaAThzVnL3HxczgyV3
         odJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776472984; x=1777077784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be+f4m8FGLJ7B2IMiGCObbiaQ4SmkheCMfMOaehd4dM=;
        b=hiXjFDa+tS/07l+y5hcXy6dnAZQ7pNGcsYiBkQ8Bu3jnItGNTODQQPLAOXZo6JLa/m
         uo2qrYZwLFWtiIKNCXpqn+KlSVas/VN9+5KEocz87ajNGg8aKYVjUoGtu4m50RvL17BK
         YzgTLnWzlCxGYcCYwTynHIdb4gOfPxOc/x1PSq9b88k4WfkXT9F2rw2+wMbMyZUXy4OO
         RCqYb7+YEydecg1tKnuH5XlCnWPIueTAqquiT87f9EVJ4v5u2lSvI74FPTspslu7qbUr
         SYHQyulb7cHxO/T7L0vINPLpHL7lYSwKZ9PyYYxHHkDAO5qPLVq7dB3j/8L9t2wp3Y5X
         GVFg==
X-Gm-Message-State: AOJu0Yy4vm+tXWs8dLCztC6h29qNR6OAaWiVNOCjmzwYF1NeygSBqBGv
	S1oaUf+pqCvkLgT4vklH8BcDz/QYKsWxysNQJP6UIImxsdJr53uW88SHyET4CAWgN6rD9g==
X-Gm-Gg: AeBDieuDjxv/0AevhMkd5bAusVDsqIMTi3ZkEvgtNuCNdNs6jaKf1Eam/rWZWqQV7mx
	DDAfvRPagIP/1+NollpeUs5Qy8MwfJxS89kbsnA3gcoApB+H4MgpkAOTNjw/hnaeQ6GhfcBd4Z1
	xvjkolvZA+Txgq/2U9d/37cC0GEftzJRioTtFEzfp2m8LEeK+rhIksRrvFzfZUbB9LtP4nw5VAh
	dXnl4lCTptTPf1Qq+LTvkr8VqARYyqXlTpEiTQPi3B2cWyvmsoWCiHmqkT7nwx4Wwh8Kv+Xv35t
	0Nm5FlkBAGQbWjomdVUODUfLB92KevD97UKlYpKyH5tHNb+qXFJZnC6CftmK8PlaoZbj2qKiJLO
	vvX/N1BL30LguNshIs3lurzWLZjz+7wbdEWyfLbS/DS+YcV12g2YRnNXoJlV2EGW1WT/P4i5Sjr
	4RaWnYvegSzOinOjuejAoyH4uXZEzo+fr5RNvODp+qp8BzNDLlpmvMVkPnhejc/6hMSQdAHeFKk
	cNwR3KFye+yT1JeNHMI4X8KkA==
X-Received: by 2002:a05:600c:b90:b0:488:b99b:4177 with SMTP id 5b1f17b1804b1-488fb78ee4emr67336305e9.25.1776472984028;
        Fri, 17 Apr 2026 17:43:04 -0700 (PDT)
Received: from reolab.localdomain (static.32.225.235.167.clients.your-server.de. [167.235.225.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78cddcsm39002005e9.4.2026.04.17.17.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:43:03 -0700 (PDT)
From: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
To: johannes.berg@intel.com,
	halves@igalia.com,
	johan@kernel.org,
	kees@kernel.org,
	mingo@kernel.org,
	swilczek.lx@gmail.com
Cc: linux-wireless@vger.kernel.org,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Subject: [PATCH] wifi: libertas: fix integer underflow in process_cmdrequest()
Date: Sat, 18 Apr 2026 04:12:47 +0330
Message-ID: <20260418004247.368944-1-a.jahangirzad@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-34963-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,igalia.com,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ajahangirzad@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B07441F7B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing validation only checks if recvlength exceeds
LBS_CMD_BUFFER_SIZE, but doesn't check the lower bound. When a
USB device sends a response shorter than MESSAGE_HEADER_LEN, the
subtraction (recvlength - MESSAGE_HEADER_LEN) wraps to a huge
value, causing memcpy to corrupt the heap.
Add the same lower bound check that libertas_tf already has.

Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 8a6bf1365..42d3fd32e 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -625,9 +625,10 @@ static inline void process_cmdrequest(int recvlength, uint8_t *recvbuff,
 	unsigned long flags;
 	u8 i;
 
-	if (recvlength > LBS_CMD_BUFFER_SIZE) {
+	if (recvlength < MESSAGE_HEADER_LEN ||
+	    recvlength > LBS_CMD_BUFFER_SIZE) {
 		lbs_deb_usbd(&cardp->udev->dev,
-			     "The receive buffer is too large\n");
+			     "The receive buffer is invalid: %d\n", recvlength);
 		kfree_skb(skb);
 		return;
 	}
-- 
2.53.0


