Return-Path: <linux-wireless+bounces-35145-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMseG/GA52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35145-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:51:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E343B8FE
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D845F305D774
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC393D8121;
	Tue, 21 Apr 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsqldTQh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D93D7D82
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779367; cv=none; b=b0lxggzjEE8BTptWWHvxb0eMBLRvQYc3dVRJF1CinAzudmgqNuNvB34UBvCXaoXRK/8Y9ahA0ia10DTYae0ezPtmXRB80X/q6AmYozPTUySJmVFgoEd5hT3SF1v4dAjThGiBWFkiJ8GcXWQXHxJHLuHUBOjMUIXOAHMnbtQ7M6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779367; c=relaxed/simple;
	bh=5ttjypfUW/yIYNiq/fSatYZX9jWnYgr+8nWCI3R2eLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQzJXlCdgyN/eHfQ44o8xVs3f+Z4j4GcwxED9ebhrsxZiWd6+geQztnaaB9woQj+wMDGn8auTUg0yxg8MoUTUMchGqWbfa8dHk6hc8VUvujU22AdlABWQDXGceikJbIf2kJQN/C/ENJ4n1nyv7arkn+rlhajpPm7pmExcn2PSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsqldTQh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso58124055e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779364; x=1777384164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+jdrdYiXeUPuTZ5DOFLRLxH84TkEtywaJuhIbBzLTU=;
        b=GsqldTQhhfLZr7lzyXY0yEtqD9/oEKx/3/qqUMDOQ13Vy0RAeiN5Wk/P0BgXDqOp+O
         SbF4n8tttx4gWehBTzBp1rmevCbnTtHZ+4EIiPz+tNMGZXO9BKE8czW71IWMP/CpCS+7
         PlppQhoH1455PeVLXcge0Ef9QFB9o3zxSI8/34w0naktlD/zS7svRSIpoOyuAmyNJcVa
         /3MWRjEB4YPrVCTGnwoAmMHOshWIs67LhweFtWmpa4lDUYzc6Y0jTdx6seLLxq4fPYxZ
         sC7jk+QGgTyXZWS/sARLbjF3mjLbX7cLTzkRrmJbDiJgW7kHU2MAdoZf41H83vENgBoT
         ohPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779364; x=1777384164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+jdrdYiXeUPuTZ5DOFLRLxH84TkEtywaJuhIbBzLTU=;
        b=UKaodtTbJLaXdGvBoCijLhY2dtZATSugdESzIUB0+Voge5YcGPdobdjXwcyQge88Sf
         ebyNud00uYCFbTE1apmCqSr2FcTN0nqN2frW9Ri3lDA7ub2U1c1wnLgTb2oo7Iv90hsf
         5NKykfKlfooQidAO02O2MrGLrahScAMs7uZR1nM2v3YxZpy04sBapgrfBksYpfyWOh2h
         kJcPn5QNdOpnlcO9bkDOeMcr0rz8u1HV7AmiMHTxZh6l3wiamL88ei9SqMlFobvcrF5B
         eogOUO7E9iJNpl0gYrqsGYIB2QWqFlsCBjn2GbuFlP3SlA8KmS/DExVvHAlbhnCz5wD3
         AcHw==
X-Gm-Message-State: AOJu0Yw+wErhLBkeqdNXQzzKFH1wcvHjWhD82NFHPbbiLoKafSvdlYdZ
	qPgXjDWEFS8p/X9RR2PG1F70pfuUjw2afuL0UxZyBA/F6inHYQ8Wpeg=
X-Gm-Gg: AeBDieuyIUlNnr+qQVdAtYq6hHT/3/wM40JccSiygWhzGW4DeWnPY3W5byK+hQp9DOH
	azUaa9cfcw7yAg1aqZ3TJIxO5Kt2g3Voo13lj0JtUzVLHWVEKlaZep/+AZUB37u9bCf/yN9CAWq
	KwUQwWBUojaVVJNiNLnml43i+u1RZHA4RiYsV1C2FdOZMp4w9PAgWXsrPd9KM2JvpwB+1jeR/ko
	9y1WV4M/nmu8XugT7DEj1WOADpO0s7n2AHlx1F3E4MLrpXJx6VRt8VK7joxbayG3oC/rorWeto5
	f+to5XUbbFmpvzUTRWjGZ0O1At3LT/H7gMx2m0acjdTwLa8cHX2oQ8gy5jgvA/zUIAzpDO2gk85
	drgwA8isa6pw1oUvzQtwidtX/0pnUtD0BCfNHWLuog7CizLMKCF+B2oeNjsOcHuLarg1kZgUNLG
	ePOQQ=
X-Received: by 2002:a05:600d:8408:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-488fb74c61fmr201563545e9.13.1776779363674;
        Tue, 21 Apr 2026 06:49:23 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm134028065e9.22.2026.04.21.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:23 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 5/5] wifi: rsi: fix OOB read from firmware offset field in SDIO RX path
Date: Tue, 21 Apr 2026 13:49:16 +0000
Message-ID: <20260421134916.317971-6-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35145-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: DE3E343B8FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled offset field in rsi_read_pkt() is validated only
when rcv_pkt_len is zero (USB path). For the SDIO path, rcv_pkt_len is
always positive, so the check is skipped entirely. A crafted offset can
cause out-of-bounds reads past the 8192-byte pktbuffer when computing
queue number, length, extended descriptor, and data pointers.

Add a transport-independent bounds check to reject offset values that
exceed the frame's actual_length.

Fixes: dad0d04fa7ba ("rsi: data and management rx path")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch.

Changes in v2:
  - New patch in v2, not present in v1.

 drivers/net/wireless/rsi/rsi_91x_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index eb950e862ecf1..bc03066a240c1 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -180,6 +180,12 @@ int rsi_read_pkt(struct rsi_common *common, u8 *rx_pkt, s32 rcv_pkt_len)
 		if (!rcv_pkt_len && offset >
 			RSI_MAX_RX_USB_PKT_SIZE - FRAME_DESC_SZ)
 			goto fail;
+		if (offset > actual_length) {
+			rsi_dbg(ERR_ZONE,
+				"%s: offset %u exceeds length %u\n",
+				__func__, offset, actual_length);
+			goto fail;
+		}
 
 		queueno = rsi_get_queueno(frame_desc, offset);
 		length = rsi_get_length(frame_desc, offset);
-- 
2.47.3


