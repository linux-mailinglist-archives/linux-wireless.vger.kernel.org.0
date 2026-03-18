Return-Path: <linux-wireless+bounces-33373-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFhoCFRKummqTwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33373-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 07:46:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB3C2B68A5
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 07:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAF31301053E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 06:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA522FF160;
	Wed, 18 Mar 2026 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAmMubZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AE4A02
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773816401; cv=none; b=Aml4EfSf6Wvj+teLq0mYm99PIs02Z9V1nNEqmYvPWs+MqAzDPfDC8ufC5MAmWnDMSue1TRZTULbfPbmk47n8+Y+TTivYUSOLc7Jv/TCnwYyoXXfgm5xf2mkFr6jkXb8GgADAA+e4XMxpgffRgHJFS+P5ET9lyB9phYLyiWGjFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773816401; c=relaxed/simple;
	bh=wvTTufyUHvLeOcDl36cL2uDZBGETrwNV+11FiFZdK3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rup+BNoXI4mBVbAF8wbV3hVqhSj+sZD5owLVjvrE2M/dazJLzHK8tjrpFS7iPMh2ifeyy0bHfEy3V8RaVvuulgoQnHB0rjjoVNVlnt4kyGsGFMv69mQHmSJJnBe298c9Jv8Y8/iwbI0e7sJ/EUwOIt2zmmS+ZCPIIoPt6llgmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAmMubZB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-829ac4670c4so5001116b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 23:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773816399; x=1774421199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=o4CbwMpn5fv86NkuOD8DdCT6N1212S5p3GRVvtF61FQ=;
        b=iAmMubZBDT989X3Pq65dMqcIFKHZkjwMIEK5qCJY1ltMMlZJejCJRGY6RQ4KLXGHrA
         +C4Q61491kqiK1cspBfZ6rrpI0d9jAUBgVdY+NCpzFUHnOT/9Y0mO16ZLIw+4MDvIH3A
         nVy8Qui5SlMa5IeFCasGcghvhUuOptXUZHmOCzLyF5YzuG/5o+33iRDVBxMWoIkqR695
         rU2JXitZft1yRoeMZUtprVrx54vzw8m8GrFBVp5JGIyppr6idtiKouh8bsaHdDW9bHfa
         0Lzxx0pxcR99U2jl0GM/1ccUChz2PeFUHvM9R8wV567Sw1VcMNCZdA8754JIcayYuEpt
         FUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773816399; x=1774421199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4CbwMpn5fv86NkuOD8DdCT6N1212S5p3GRVvtF61FQ=;
        b=G1LpCJyGxgAyH9n/dqDxtmBMIK7sc1qd0B7uqJ+PPC10jKf9Zpsxu89tIwHlJKxMwu
         TaIkaeKTM4VdmyUKkMHHV0O1yNvjP31xETC1HHkliUT1dxjY8PG7hGqQQc//JJF1vVsU
         woBySGSl3ENyxzyJ7VPuX5xf4A5GEsUSRM0hJLhsjnb/zFNWXfgpWyNMJgBQDIaa/bQh
         mq1HWor2bUM4B4+1CPyDNcFfhdp6QPG1HQ+fjG90haT0BS3ZVm39tb/BQG8JFpBR4t5r
         eUT5lqgy/h76BKoGZbdQdy+cSGHq7FS7wAyAegzaYuEnpxEIITAXMNy1EfEmYtz4fFtX
         rR3w==
X-Gm-Message-State: AOJu0Yxx9vREToh1zTC7vA5HA4EHFSlc++XhAfFXsgpzwqS6whfwIHPV
	mWUJISaqS7WW1CQwtxQS0obcBl78Nfy3DdJ8o3eBBtD7Jej7sNyfexD4
X-Gm-Gg: ATEYQzy+KvdrEViDI/ZkXFjnwaDrPvFNTF0eVCk9HVRIXV7SJx7yJKaFCvROIpynpMA
	2oKIOCa4ATRMgaq++J+JwcjBEG4uFNtPMYwwcZU6nZWnaPlROoWHCtKDefbGZN8aIqKIAitC8zC
	ijBbcuGmkkzNvEdb2x4/4KK1WdRGWQZOVPxjzaOS9eqeWkzG2+gtbTt2vRS1eV7iJs4klJahTKP
	B9Me7dFGAEHFctEEiwDhpVXeVGcSW+S/tvpaiiGQnfVVwp5uTwHGb3wpai038UlGQDJ5fBI0UC9
	LcMBatZHEKk+wJuqOz4ZYeUH26q91kptl5LEF20Jo4+RI9VkfPP9ADbmmFAV/Z6vG68rO1tGrav
	2pMDtLqOHozF6bSqcdo38SzEzdPQWGmgsClw4xDhZmLLuGs3wYNHuHpjOxAK9lNXeUqJA/f9Oas
	ALN2VsqaYyYUgxEKfWma4vLb/qQUx7BSUGBr+X
X-Received: by 2002:a05:6a00:2342:b0:823:1c3e:95cf with SMTP id d2e1a72fcca58-82a6aca9554mr2066000b3a.18.1773816399240;
        Tue, 17 Mar 2026 23:46:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6c63808fsm1688506b3a.23.2026.03.17.23.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:46:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Astrand <astrand@lysator.liu.se>
Subject: [PATCH] wifi: wlcore: Return -ENOMEM instead of -EAGAIN if there is not enough headroom
Date: Tue, 17 Mar 2026 23:46:36 -0700
Message-ID: <20260318064636.3065925-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33373-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liu.se:email]
X-Rspamd-Queue-Id: 5EB3C2B68A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since upstream commit e75665dd0968 ("wifi: wlcore: ensure skb headroom
before skb_push"), wl1271_tx_allocate() and with it
wl1271_prepare_tx_frame() returns -EAGAIN if pskb_expand_head() fails.
However, in wlcore_tx_work_locked(), a return value of -EAGAIN from
wl1271_prepare_tx_frame() is interpreted as the aggregation buffer being
full. This causes the code to flush the buffer, put the skb back at the
head of the queue, and immediately retry the same skb in a tight while
loop.

Because wlcore_tx_work_locked() holds wl->mutex, and the retry happens
immediately with GFP_ATOMIC, this will result in an infinite loop and a
CPU soft lockup. Return -ENOMEM instead so the packet is dropped and
the loop terminates.

The problem was found by an experimental code review agent based on
gemini-3.1-pro while reviewing backports into v6.18.y.

Assisted-by: Gemini:gemini-3.1-pro
Fixes: e75665dd0968 ("wifi: wlcore: ensure skb headroom before skb_push")
Cc: Peter Astrand <astrand@lysator.liu.se>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/net/wireless/ti/wlcore/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index 6241866d39df..75cfbcfb7626 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -210,7 +210,7 @@ static int wl1271_tx_allocate(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 		if (skb_headroom(skb) < (total_len - skb->len) &&
 		    pskb_expand_head(skb, (total_len - skb->len), 0, GFP_ATOMIC)) {
 			wl1271_free_tx_id(wl, id);
-			return -EAGAIN;
+			return -ENOMEM;
 		}
 		desc = skb_push(skb, total_len - skb->len);
 
-- 
2.45.2


