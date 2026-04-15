Return-Path: <linux-wireless+bounces-34861-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIAKMrAT4GmPcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34861-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:39:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6695B408BD2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C853159249
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BCB33D6FD;
	Wed, 15 Apr 2026 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4GoMNnN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646763115AF
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292635; cv=none; b=CPq4uxpjvfGQfqqXH692YxYOLrrqkWArjwmpyutgZrE/hm0c1x1zFTUE9jRRKoadZ26z7kCC2wH5Yd3rZzOOC/eJGLclYdBa00/vygzm2sfiWJRI1xv/KUUwppNuimfx5Smm/OsUbamwjzKNCOt0TxODGdL7sItl5w41aAk0OnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292635; c=relaxed/simple;
	bh=K5/5QhY4iA7Fokua0uIgpTteAtMxD/nGLZBdF+03f3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUR9/kdDYXUZWSNX9qbrDvpL7fKmNVngi+6eJSQFWUXNTjK04UhGb8XnCF6u3Q73lbZwz331V2+1RBJVKxHfcr8sF7KNVLBJRdH1T/cTc8zQB524Dz5B1eQrxSq1lowQOHF4bXR3yT+Z81qmXNoVYX6YUb/o/XEvYwEB8YDa3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4GoMNnN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b8efed61so491355e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776292633; x=1776897433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx4Rou8M2UzACrGE3Ykx0KL5iaINii3pzApwfXM1kO4=;
        b=M4GoMNnNFhE8BR/ETMAxswV8bIX1hL1357lRFQtT1dpgAH+IN6R8e2f6uNN/5+9xo8
         mEQDKsZxkCgeej+jBqMNr6H/xgxGideU8uU7X9gC4NM/TFQXQ6csrj892mbFEddFwDl8
         UX1rcKzbNdqpYyoZvUmeWJ3BqSwu+9ngevSWdNxrXCkfoRTJAgrkjs3gScpLmwIwD1Pd
         /55MFiKV0k9eC4Ws07VRXkgINOO0WQPd3yLzmP00WPi/HfSVFX/ZCKGca26+1BX0NZaa
         pHpKjmGFCyuwOZfmc/bgpDgeTccAVYxcq+SC4PK/lJppL7g4pvShRSLzCo0JmgMA2Yi8
         CsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292633; x=1776897433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rx4Rou8M2UzACrGE3Ykx0KL5iaINii3pzApwfXM1kO4=;
        b=fmXLNw+jAtLKjf6D97E/PEuOAMWVM36OEND7PDxGCHp+3x+OtG7k+Pv8w7TPlLRP+/
         +wQqR9Yt38kfCTpZAecHFsUE6XX7kfTtbbIYBpntubA5aOXIB1p4FD74J+Z9s+HwPssL
         Ce+JgAnFjRfz4lNqBGtLFu9938wHzY0bnNVgvHteBFM+IqzQRVzAeZZj5Ce4+RF5RCcF
         I0BElv8UcAwcbtl1sdcLg+l3sku41dUhcK1APgDDdyG502swvHv2m16mVELLUNbC+9Wl
         lpnnwxBLHFtkhCDxEoo0jJG9WyzJrjcihYbX4AOhqtWTvcSl9iQEsjgw6s8ptKiaOCrx
         GwEA==
X-Forwarded-Encrypted: i=1; AFNElJ9O9uoIKDM+E43yXbJpAVrAfEesVWaKPjc6Vxlz+nwmyLVTGQuOqRA3VDGA+DqgwqsJ8ORRqW5qXd6RMhFRiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0UDCIC0SHtWHyjt/P+OqTPvmJTK4GCClkN9sI8h/NJXaSVc3/
	QzWh9Nh4HNlTuhLQqj1Yk9G0TWZ+oEa1KUZx03bVf+DfC758FkH/QmE=
X-Gm-Gg: AeBDievkuOqbWzF9KXJAxrUsO+oCR2ixvPXI/ctiq8Wszeg6h0V1He8AOEo/mJcOuMg
	G2JyjsdTYezm8rfmAoGg0cWl/5+KVuAMWIcyJX6sku0vsuXB/dkUHwXequCBjGo+VFlJg8MFdyl
	8kL2R5/x3N1mfsPIiAQWXXOCh0dkVRobNAcd6iMgAdkQ/nA7sDFIZPAc7CvVgctJq7G35xYHA9z
	AOhp2SZJQujcuumA8ZM1d1hktBPTt3FQhzgFOKr6JrScBwLXnvvqQwiwMfRU9AzDcwAmXNF4iwf
	EtluJ4YsGpCASFjCLStYppO+Ppg4NeebrctKOBCEMSZdrOBD1naLQFTj5JyA3LGFpitKZOWBa64
	YzUegE0fWYe0PbrXte3aomsqd5aGAtYmjcAu08OH+PezETmYgirBOI+DocPer8J8y2QZYiROBKq
	tSD8Q=
X-Received: by 2002:a05:600d:13:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-488f47ce3fcmr11232265e9.6.1776292632739;
        Wed, 15 Apr 2026 15:37:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818da1sm2550345e9.6.2026.04.15.15.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:37:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/3] wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
Date: Wed, 15 Apr 2026 22:37:08 +0000
Message-ID: <20260415223710.1616925-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415223710.1616925-1-tristmd@gmail.com>
References: <20260415223710.1616925-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34861-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6695B408BD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware response dispatcher copies all synchronous HAL responses
into the 4096-byte hal_buf without validating the response length. A
response exceeding WCN36XX_HAL_BUF_SIZE causes a heap buffer overflow
with firmware-controlled content.

Add a bounds check on the response length.

Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680 hardware")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ath/wcn36xx/smd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -3296,6 +3296,11 @@ int wcn36xx_smd_rsp_process(struct rpmsg_device *rpdev,
 	case WCN36XX_HAL_ADD_BCN_FILTER_RSP:
+		if (len > WCN36XX_HAL_BUF_SIZE) {
+			wcn36xx_warn("HAL response too large: %d\n", len);
+			break;
+		}
 		memcpy(wcn->hal_buf, buf, len);
 		wcn->hal_rsp_len = len;
 		complete(&wcn->hal_rsp_compl);


