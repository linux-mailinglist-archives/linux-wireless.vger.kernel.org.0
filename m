Return-Path: <linux-wireless+bounces-35685-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLZoDJ3z8mnNvwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35685-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 08:15:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEF949DF40
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 08:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFF94300BBB8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66166375AD0;
	Thu, 30 Apr 2026 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLBQ4EmC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C33750D6
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529755; cv=none; b=kbinm2cckUR1IFY6PsRdF+VYZ67zENzW0QOXgdh9+CAOUxwbS2w81i35KHXCm9LSS9uzHXnu/Ya16IQVNXtcTLyMxdP+BppWMkJECgDCZDvVZcH029eXw/CFYZH6yRr6vg4OMVUl+yyK+VyZroxMU4+C5zOVcp5QaBTMG0QjtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529755; c=relaxed/simple;
	bh=xL42ZWKrTVrSC2jDeY0hsvPfU3p9FbDy5krFUYRLQXE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R/K2aXgwsU4X6WypIGbj+maQzhLO/+eZ0QGLq8VZ2ta9s21BCtC9CalzUf3FoPGS2Qnq3uoZBQ8JPrdgiFSbOtTYwOMEBUrGoJp7ctehGYZsMhmxiE/4YoBVoI0J0T41hPBPTu6SLY9cYxIeJ9gNUm494GAN0Npfd53KpQyaQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLBQ4EmC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso4185145e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777529752; x=1778134552; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4eBgl8Ld1ZWw/9cbt4soJzSAn0Jr0mSS+YG3PesXQEU=;
        b=TLBQ4EmCZNU1xW3xGmi0Gs4ptvMebe2b3TLJLOu8eRcyRLG+XeT9JQL1xUcxHTMFs0
         sjkg7IAMCriqxbcjaj9zBQNhptBYx8M0MladOpqvI5to3FPzvZvmbm/LIglQmUGzG0Bd
         S1WEC90IyBjZHT9QpELVEzqPi0Ya/x8oilJA5jO+nnFzpDohIzGZImyVLpyVSbvtTtVe
         lVVhFxaeGGWP9fq5SLw6rgsDCU4uOxzPBzX/+8OUhyd/0GFlhyBz8gie7j/+/H7/SsMz
         lNj04w04Hu8NCRdJ8vXV1gNmju8nc3J3fl/l9QJU6w/mlwmLbPyGNu6MU6zXdRKNCMd8
         u7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777529752; x=1778134552;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eBgl8Ld1ZWw/9cbt4soJzSAn0Jr0mSS+YG3PesXQEU=;
        b=h0nHRqLVt8xu8nqHP/wA4GLBEHEz0h3qSQ0OBeZp0a6zaHoJ4o0eQdj223ch6CEmqv
         NMnw+G8YK+wmFWojO2mTuWz48NCuOuNvQPx+rOpAhaJp9mI7a/UWXt0IyjKmo1H8v7N3
         3kOR5oMSVm4mWbAY8B1CY429PgUD8cPdknegBG1b4cHUwU26uUtbZuplbmV8gkjOh5bK
         xZu0KxorM8VfIxR6yZ+VpUxV8zcFHLBODTfgoZYHrku1uLMwAf0Kde88i6ezaHL1dJW8
         gmH35FnAzxeSFw8SCF0mJiiJqsTm7CWQGZh8CGW3MGRLwiwWrTi9uGaB/ASMbRebjizB
         GfBg==
X-Forwarded-Encrypted: i=1; AFNElJ+BbEoMyOyWUp5LOkz2M5GDfCMsVNbJOs6EOfh6W52XGdsT6jB2aQNcceklpsUii4r1c8Jn09cQdVz1Tq4TjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqPq6wfGQHjzit9G2OpQwk5FaXxH/oYvgXfaIX0W1Blb774m/
	U+jzM7CVC10+fb8JkuizX9O2sJPKhlR7WhIX2VpADLwFlH1FPi0jYSLc
X-Gm-Gg: AeBDiev1NMlzogv/qeXONsAdM5ZS7QHSMLyOjBJPhcRFRK6QhXTw4KrRxIdUHT/TnCT
	/VglBtfAYXNhGkfJjB9f8q+yxcwnxHeWyNcwF2vVFTLqacHkchRavkPbaI5nw4ad9+kBA+Gh3DN
	m/MmEMuGICKhSYQn68H98EWROYIqi6Od7V7oN2yRb4CLRKefOF8MPxSnvlZ/MrJPB2ccL97o8uo
	Vw8FGW0Zk705s7t8P3myNfypG1VXv5GjLUgNyFqzPCUjlsILqiqRhZNex/2GZkN1ASg0GcSEqJt
	qGZZQPHzz/uNoSZTJKzYH17Qdxc/WJGlmlCOOa23Rux+OmGN2QyniYxxB8qEXZDttSq05KL6lUl
	TvKYukZRnXJGjo5S8UeMsd7ugMes1x+O06lYOtCjDUbruGnofxdKcOyLXOC+9gcW4JGT9qPKW4c
	ZmNL6OUI0DydP01YSsB4Sv3qo2JvM/Jg==
X-Received: by 2002:a05:600d:6:b0:48a:7a10:4f3d with SMTP id 5b1f17b1804b1-48a83d031fbmr20499035e9.0.1777529752266;
        Wed, 29 Apr 2026 23:15:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm68748675e9.2.2026.04.29.23.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 23:15:51 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:15:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: Kalle Valo <kvalo@qca.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Raja Mani <rmani@qca.qualcomm.com>,
	Vasanthakumar Thiagarajan <vthiagar@qca.qualcomm.com>,
	Jouni Malinen <jouni@qca.qualcomm.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: don't allow negative key_len values
Message-ID: <afLzlDT5VF4D746w@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Rspamd-Queue-Id: CEEF949DF40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-35685-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The ath6kl_cfg80211_add_key() function has an upper bounds check on
params->key_len which ensures that it can't go over WLAN_MAX_KEY_LEN but
it doesn't check for negatives.  This could potentially lead to memory
corruption.

Put a bounds check on negative values in cfg80211_validate_key_settings()
to prevent this sort of bug in the future.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
This is from static analysis.  I can't think why a driver would ever
want a negative length and I think this is the safest solution.  But
I have not tested it.

 net/wireless/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index b78530c3e3f8..4552229eb2d2 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -397,6 +397,8 @@ int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
 		 * or not the driver supports this algorithm,
 		 * of course.
 		 */
+		if (params->key_len < 0)
+			return -EINVAL;
 		break;
 	}
 
-- 
2.53.0


