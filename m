Return-Path: <linux-wireless+bounces-36061-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GadLOBx/GkEQQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36061-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:05:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67F4E7352
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57C04300A4E9
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB1D2F8BC0;
	Thu,  7 May 2026 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTWFSqDq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4C3101D4
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151885; cv=none; b=IRSgDWedMLT64JaAIVHjD0e35r3QhIH3kewyueBmfXnXV8W/NkIowpWlQyW9XPUtEtpvhU9PoAODgoxyMdpQK0RoIKupmKkIIDOAfxnsrsE7oPDa8LQWC+93Ue6RA9uk5TEq6Z9YMUZAyKzbKifDUI7ZETPlDpYTn2hNP04AQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151885; c=relaxed/simple;
	bh=bfnro7lC0SX75RPEYNQ7AwHvI7lAtJW9SMFg33EzcZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJkrhccjKGkM+5VqgDyXxQwAA17uAOVV1pukdanNf+pn0CUR+f9P1LA+hW8dfgJ/qxC9KVn4a9bSJl+WXXLVQONjkkN8/PYI/Ppr6SZyu5s87UdEloU7FRrvaChSoiiv840qJyfdg5Me+6DHDTvBPS7vUEYp49GgCrjKVBHL5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTWFSqDq; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-364f65f6eaeso730917a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151884; x=1778756684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5t0guh4qBPWqIfqEewnhQSul9ffMeJXpGrTuXU3Dlc=;
        b=hTWFSqDqW5/WS/4ecUTWvAQHB3o7ccE51nbIPMV+kerq+4R9kBJUIkZPIyDwmhAKoO
         DdZkqxsm9SqVLzRg4GhGLiN7glpcHR/u5EA1SnLrq+qmM1qHLIslXniBe+h/aOAGUxNn
         oamuBW/rv91w/SOWiCNbppNmQqv4SAzubTsO+b7ExUijuiu+bS5e5Es99DMpupTF8NAS
         ahX/FyizCFxVa+6VU5q3A72ibCOEfFlJ2XWWpNg3RMeBiDcF8r1mgLdsjRORxyjqC2Uv
         amnAE/A7mzvrLgoQm52mV+X9XG1/M4bJDo/2WwLzWwJA3+sqJvWIno52CGc+V4JaWaJ3
         Dr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151884; x=1778756684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5t0guh4qBPWqIfqEewnhQSul9ffMeJXpGrTuXU3Dlc=;
        b=KMkD/OQEE4FU0VfGfURP2V5SqMdsAi9xenbMri/qWMpRcH6pVSRgcWrmZ3mna0PSKV
         lLMwWIZJwnMAgDLnAtr1tCRkjbW4gB5UALQhGKep5km9M5Y9dfNxglE8eLhl3bMZDyzz
         KkzOIKHr4H5yld/b3MK8tmO/dBueBy99FTVuvT8Sx5MLP3TOfEcCim6iZbH8XKd5jcWL
         CoyXlP4yB//2z8kb/sf75miO/LED4qI97zgC6ZSuqHIL0jCBP5JxsSGLc05DDSQq28jS
         BjUE8y8/haIYRP/k5EeTqCdobLOH96Ug9o2Um5nvgXXtNUc8nEV85b1J5LLNX1uWw/I4
         MGQw==
X-Forwarded-Encrypted: i=1; AFNElJ8l3JCVjdkLxYOBV8ERdG5oIv/go/97URnmUrmEOEfoQVDzSH6bWNkvhL0PD2i7ooZK1DQBrEkCbHGyBqgaXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVUF6z/9fIGygGcQe29gDzeKuUfH0Evqcn5SgQoggjQr38JbL
	xOQMZIivjTMBAr9lNkJbMtfI4PT+gc7LQAyBmQJA1xmhAI3lCYnsk5Fk
X-Gm-Gg: AeBDieu+yBkFbr7kU6tFba+lEyXRi9BJB0zBmVLLyQqcqWcquo/pE3hiwiTbn3sqcHk
	uY7DyInVyWBITGS0Qji0UaUVszh6BJiOiPaduBp4VkFhSf5trrc+XySq2WMKvlIdCwyeaKFvFpC
	EpUp+g5uyaOeOu6ub8dZ7/dj3I7IjtgSEQbrZjQqeaxLm0tIckiAdO74ImcKHn2fgarG3eA771S
	aSO7zybslqxFPd7ixToOZe/TF/2RoEDB+gPBAFyDALY4kJ4X4jKqBgCnNlYkdHV3IsWcddLf8fO
	EBuM58DrL7mVK3nm+qz+A/P+oSjhJJDgdeXHFTuep1SWJmIA/4hZUZx4IR1wJGNOPDlHkDPKqUt
	7GntAREBYyDdnmCaF57Y1RvvTk0ZPM5JFpOsLtjkPR1ODheUs80tSmrwVHrN3M2klEuorPmCfk8
	I/U22CMrDY/OLOx3gQYIZZMuLRMcDFL7xQtxz9A3gj
X-Received: by 2002:a17:90b:5403:b0:35d:9efd:7956 with SMTP id 98e67ed59e1d1-365abce1ff6mr8143531a91.11.1778151883993;
        Thu, 07 May 2026 04:04:43 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c2f5fcsm7360479a91.7.2026.05.07.04.04.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 04:04:43 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: [PATCH v3 2/3] wifi: rtw89: Make use of str_alloc_free helper
Date: Thu,  7 May 2026 19:03:40 +0800
Message-ID: <6101125fbd6f619023e270a7dfca366d2be0cc31.1778051552.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778051552.git.jqqlijiazi@gmail.com>
References: <cover.1778051552.git.jqqlijiazi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E67F4E7352
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,transsion.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36061-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jqqlijiazi@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[transsion.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mingzhu.wang:url]
X-Rspamd-Action: no action

The helper str_alloc_free is introduced to return "alloc/free"
string literal. We can simplify this format by str_alloc_free.

Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>
Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 17704f054727..6cc68494b3a1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2554,7 +2554,7 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev,
 		 */
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "failed to %s entry tid=%d for h2c ba cam\n",
-			    valid ? "alloc" : "free", params->tid);
+			    str_alloc_free(valid), params->tid);
 		return 0;
 	}
 
@@ -2690,7 +2690,7 @@ int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev,
 		 */
 		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 			    "failed to %s entry tid=%d for h2c ba cam\n",
-			    valid ? "alloc" : "free", params->tid);
+			    str_alloc_free(valid), params->tid);
 		return 0;
 	}
 
-- 
2.49.0


