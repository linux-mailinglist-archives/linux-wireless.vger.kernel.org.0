Return-Path: <linux-wireless+bounces-35142-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC0GNLCB52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35142-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:54:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7351043B967
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C08305E333
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636EE3D75C4;
	Tue, 21 Apr 2026 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKPvu/LE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997A3D75D2
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779363; cv=none; b=d7MElq9MD+xb6I903EC1rqNrUlPxuQBoOblXuNfmIZ9n+9yBe9g1TsG6Xs/PFXWWOAxK5la576ZN42c8eEN6nR565/mPjHreC7KMcqvz+2NLjXFtEMSpCzXp5FTQtbzJHMpJgw/VbuikTCOO/1A0vJ7E+m1g5Sq27Y5Lt0lLzr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779363; c=relaxed/simple;
	bh=bM5IYU9DkvKI9rUMjJFNd4dTavPzH6oyjHIeJT7x5/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LY3SOWiSBC12K1WStb4wlr3OnU/gQcPbHje1hLMbwPWVdiv/hcsXrICregLuPNe8B7yAfvv6M0ryxskDeJ6zee92W2vAtWSDTq0PELcYWNtU4uzF7JiFTVUN/Tw50dp4Th9jfItdmvxSooEeXBgS3kUp8tfWHEwk+HSK8tfMVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKPvu/LE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so54570625e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779360; x=1777384160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlA8Sx2SvOQml+XUjijzY7lL9TvTpQThCt1oUlqqS8s=;
        b=RKPvu/LE61iB3jWduWto7JcVKQVwhLYjkvpO8s1vGQLMFL8SJK+lJNnxzpCSfv6Zlo
         rvEwGUuMUEIhsznmoKn9aJabNxGBzlTrwKCmE53gq3lDzDeQmZm0atA+1R1BKIp31WeR
         JSbqUTrqUBsd64POedD4xWKy1bRv5Bg0biEDmKufStX4zURkqd44D+TdG5dkjymQPX3D
         3hDmRh/Mz4Ge08IVZPzwFSFzvY902FDcU5frgagnKVcypnl+OJQAUGXMcznel/x3YJV6
         HwioMSW+2vDyncvXJ5Z4fkoF7vYBbWtSzJXfvOe6Ohdpl5gAdvdB2qy8Vwy1KPxnOjn/
         wgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779360; x=1777384160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XlA8Sx2SvOQml+XUjijzY7lL9TvTpQThCt1oUlqqS8s=;
        b=n6QtkMrkMbcKJn6VoQzYkiCzey97VCDg8PwTVaUcUc8eI0GbiuWd6vdTIR4C2yOyUD
         u7UEeQKguVZ3XFmrwpONgetsb157P0QnDiDlcYGbMYqoFTigjOtyDf1Tp1zM0z2EsKZ+
         1A3OUNWMD9Vt4OqOGCpGP6Zs5pgTFoBSeMzou2w1CeVolo4e6LiLK6qjPn/sCctRYFhC
         pW+ty5SCzmQBBmRGh34IPiEg3QKk7cCgs2YbR6xSoOVtvnekGAwM952pZhCGByTXTPn4
         k5PLdv54Lw1xfDREPe8qt04u9BUOftmDbFWcVIIBwqysyd64IOyTUiSmzNhe3bNQMUwq
         n2oQ==
X-Gm-Message-State: AOJu0YyW6ZtHvhQa/u0HFX6NfRqzYwQD9lN9C7XLv9pzA0d6vANy6ubl
	7IEoZOPjDTcSMOs32oq8gAvqVeaG5QhuMnT+7in8zQNY3ck219Q9vtU=
X-Gm-Gg: AeBDiesfkqa/nrZiTcijt6zpSwviVsSSVOsnbC9+poOEtGCaa63pZAj0LqnZmNPtMRF
	Le3Kg8XnZbfzTBcjFmfEJi3xMVVVjptRavzz4khQwBpZAy1fBQ/dYda9IibsvvOb/2r7099WASV
	WiMvcIu++C1fXpTNIMl2lORnI0qXH/6DHLlZU7Pi6XCZLIrso8GoNfnE0ATLl3sT8mwqFm3s442
	amMDl7Jh59VP+GdMLIjyNzwbuennwAAKmb7nR+74c+pMxY0y1uP+1IxCef4uq+gKD9+CA+V5mJB
	abohw8NASnzXtj9e6QMb9Iw5hDm0vfYomQOuX+KLibQFtzu6I6REiHE7POVuX38uTxOxKJB81cU
	5hB0Brj+uIk6PKzH2kdA92FOuYjwO3L0M4Jjkt3S7+pmTJnuX6cb9TOIXdTPN4oznIgIv19BE+g
	5gS/E=
X-Received: by 2002:a05:600c:c108:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488fb78e576mr180769885e9.27.1776779359938;
        Tue, 21 Apr 2026 06:49:19 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm134028065e9.22.2026.04.21.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:18 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 1/5] wifi: rsi: fix integer underflow from firmware extended_desc in rsi_prepare_skb()
Date: Tue, 21 Apr 2026 13:49:12 +0000
Message-ID: <20260421134916.317971-2-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35142-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 7351043B967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled extended_desc value is subtracted from pkt_len
without bounds checking. When extended_desc exceeds pkt_len, the u32
subtraction wraps, causing either a failed allocation (DoS) or an
out-of-bounds heap read via the subsequent memcpy from buffer +
payload_offset. Both SDIO and USB paths are affected.

Add a bounds check to reject packets where extended_desc exceeds
pkt_len.

Fixes: dad0d04fa7ba ("rsi: data and management rx path")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/rsi/rsi_91x_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 662e42d1e5e8d..2ff7068bad7a7 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -134,6 +134,11 @@ static struct sk_buff *rsi_prepare_skb(struct rsi_common *common,
 		pkt_len = RSI_RCV_BUFFER_LEN * 4;
 	}
 
+	if (extended_desc > pkt_len) {
+		rsi_dbg(ERR_ZONE, "%s: extended_desc %u > pkt_len %u\n",
+			__func__, extended_desc, pkt_len);
+		return NULL;
+	}
 	pkt_len -= extended_desc;
 	skb = dev_alloc_skb(pkt_len + FRAME_DESC_SZ);
 	if (skb == NULL)
-- 
2.47.3


