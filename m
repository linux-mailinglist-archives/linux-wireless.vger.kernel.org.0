Return-Path: <linux-wireless+bounces-34820-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMMPCd8P4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34820-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8839B4088EC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB3B30C43EA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDA6391514;
	Wed, 15 Apr 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrs4dZUL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF033876B8
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291792; cv=none; b=NZVLet59RrVUXYIuF59U2trEs0usXi2/oxNaFGTyh16xWS0FL5Qvv0gwkgcarkvJwO1jZFhFmmnA3cjpreRiDxCfdM+Ai6G+VC6eiMsdgHr/JkWZQuO3UE8Q70xs4FkGgARsndi5TCmPQttpteqNzFMUQSs/bOQRCK6A0uWiBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291792; c=relaxed/simple;
	bh=Hl94he1fun++YWYxVogzMwsqsSbDio9MCYmizZeSo6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRMRn2EpFdm4YSXefIY8BS0ELWqr7oixbGkV5HJp64VFK/L/crHh9rkkHzSGQSTcwDpDEKQDn8ot+5gjPixLFcthADkrmTZ/MLzwpynlqQnB0Vtb7FoIW5PlzWOutP8xSHSE5urD+Smbn/BrHV4taha1edcI3CSpgUpP9JmJcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrs4dZUL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfbd17589so5199976f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291790; x=1776896590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1etLtsg1/Vn+zBkkki6OEX9FiWilfcXEV7/dAKCeTU=;
        b=jrs4dZULWVIgGYzfLKbn8VHAb9fJITiFE3kybky2/h3E6Qhv+/prqwb9UuoVzrC8H0
         4otIDNwDY0XkFcxBpdONljW00+nUKgj2wIL0qgLRTaWX1xJrhtl0EBi9fOkT9FaabG6g
         +TvM/k3X2e1UrewYET9IpTtbPEahfMnIUJgPNmi17F1BXxmYJgrCZcrSZaux/Ql4ejq4
         DgNgzOaq/gAtk0JUc2+zbVvMq/ZfkiPEE6z3uOTslg9yyciCFMgjrYpZsnlD26AR/MA4
         HNj66O+DwFCi2ncx7M7WwXfZbehTIca0cDuVeUU1/vDRjwndkHm8vMKfvk9lnYDNYM8l
         NG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291790; x=1776896590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m1etLtsg1/Vn+zBkkki6OEX9FiWilfcXEV7/dAKCeTU=;
        b=gASNsjGPs1onV2pAapBbWaZ6idOw53e71wRwa7Y1bOWaXFq4ZK+l+21dTeB0QR7dLK
         0w7evs/CNmiC0WfLcofjrJS6mezwiwsY/nDze9RU7E6BKXgq7G6B5hkTb842G0cQMKba
         cXVCrhsVdx0NK6E9pjH+TdzNSDKLDnqFlD8p93nSs0NVq3fh5bzUnEYNIGAxIMZf/SCP
         HMaW6WwsbCCCqXwzCkhu4bzGW387jYieKU36Nth2KlTMopBFi7ev9LUIOpd0+Co4hxnU
         tV8pN6CkHHBmtEpU5wdRlF6tm4eOipKOS2CKXtjW8WDTCDM4pRS1DrSNO84JilGjop1+
         0V4g==
X-Gm-Message-State: AOJu0YxR0w9dQ9PBD9sVEDgUOnGwtNKO+eJEmH1K17FLURd7cRB/kSHs
	tXGbFSGpBj81SLwk+7B9gfo8jTcDLfb4+a1ETNYJzkMO4aIajEEFa4g=
X-Gm-Gg: AeBDieuSZoilNxhZFUWHA/VlnczTWEe3zBHqX1DvxDCGW4DYPm6FvIak3h34LfOsTr+
	4ccyqHkJUeJhgPPRpAKCf2/otQqIwSLeL/fRQ2h7UrKT2BiC0VXUyWhnqqGPsCVd5jPS8FYtsZO
	7TBse+XzZtEEqXSHuwasLQQxAJFRb+juO6gi3UPY/dtCbI1mWv/nZjJ9iYzH6V+5CawYEGrZyRQ
	MzlrZbkw7WWBZlbDRXEXT6asDtjcHmglJM5Bu0ipWehzmW+6XS7Ipx/Fj8s+8q3EQMuyuHM9CGC
	a6oBTxDes5E04sq3IQmVCy1KJ9ZULNv9G/Z1+oHGiTpWD2GzHBPZ7PkNx94I0hArrHLmF4AKiXS
	ER1QFAD7BMctiCY7AzJG2G1xyz+BvcilDmLbAWbmwW40BmilQS5xlRajRKVLBZNPJ4vrdnoeEsH
	f5q2I=
X-Received: by 2002:a05:6000:220b:b0:43b:80a0:d92 with SMTP id ffacd0b85a97d-43d642bd578mr32008197f8f.45.1776291789821;
        Wed, 15 Apr 2026 15:23:09 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm8662959f8f.20.2026.04.15.15.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:09 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] wifi: rsi: fix OOB read from firmware offset field in SDIO RX path
Date: Wed, 15 Apr 2026 22:23:03 +0000
Message-ID: <20260415222307.1537309-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222307.1537309-1-tristmd@gmail.com>
References: <20260415222307.1537309-1-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34820-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 8839B4088EC
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
drivers/net/wireless/rsi/rsi_91x_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -171,6 +171,11 @@ int rsi_read_pkt(struct rsi_common *common, u8 *rx_pkt, s32 rcv_pkt_len)
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


