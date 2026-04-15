Return-Path: <linux-wireless+bounces-34838-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EORAOVcQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34838-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD2408998
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A95093086B2E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632E39EF01;
	Wed, 15 Apr 2026 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7l9/Dcg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168533939B0
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291834; cv=none; b=ImWtHDGNdjQ0/kp/QuXwkDruA9H/T+aM8FkQMmUdOeSFrg25fV0UHsf5qOf4lREukrNSPNiWYsyDMfZitdWd0UeSDO2h5quolkdkoelX9xACHMUwjcKHOZnQDVQIqwMv/DIxskPi5Z7DWKlcLPyCuFFDbZkKWhOSGCRA+S7gom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291834; c=relaxed/simple;
	bh=auTohr0SMVKyIdScr22AeWHWHZULiU0EJD6viz3l7Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEdt0kQehfsW7KLrMTYdqmw005cAf4CkctzYmbKfikZIpw2CWZ7aiaKlEiCUVRRX41mvybeKr1oDchD9Lhcs/sedltqNg99OTA9Z1gQsJQkh1EzYjqfwSfLi7RGL+S4SviKS5bkfV9vF//RQ09AXPOcXvmL6h0NM/YTbiedSnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7l9/Dcg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d77f6092eso2744320f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291831; x=1776896631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7l7g4cargiS0FGk2gT7876H80IPBqE15qVq2PFnB98=;
        b=M7l9/DcgaK4fHSkk7bz8DwEGTv8MM90b6mnO+jbF9spPCmxVA5hHJBRjEkJGheOCCK
         9dEs7iFL37pU/CRhWdnJRydsoi9LsdgB1DobrpkSIkpyj78EXoIwA0uy1G7PuJWMQ47c
         htaHW00B+V8ICNtzosUJLg0z4qlvUipK3g9ujpakXY+4zoROUTg3Wqx8psSL5qmaN46m
         5KhHV45FWSDah13t2WglNwmnMRzSiuwLXaJuGRQqGPIEASt/xX1ma0hgubWnV2mzkQye
         PZlgRxuSENbKSAkOH8UGjqTorJ4QW5tVBYshkDyN97fwGboP7m4fkH20Tg23ozlTZRCO
         9RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291831; x=1776896631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b7l7g4cargiS0FGk2gT7876H80IPBqE15qVq2PFnB98=;
        b=G+NN2IVl97UlZIj/4zMlYMVhUL7m+QByKQC/Xp8rWT7bhb4fCuRUvdyKPwp7wLkDhf
         NaEjIU70lFTLNfJ66UN+Tpf8d5+Zi9+OaAIyVmakH/uPUGTVowhUGxAC8AVwXyeSmDsE
         yTF2S/6/wt7kKGZioV12AIS7djhjXfxfKEPbUO2zMRLTfGY+CT3v/wBm115v4q7PGMDh
         BhpM5d0986qJ4I9h68FfbFtA7uQH5PTya0brTjIWPAiszmlVQ9q9vEzHLAS1QCKROyk9
         /ePHGHWsXt0MQcb9TvfemrVnJKJj7pVnPLVBiwDU+SvvAvc1EVpYQjyYKDhldxsmn7D5
         aK4g==
X-Gm-Message-State: AOJu0YxqqBFRQ6cnQoXxLLua5PWyEB5iq7BM69SUHwxGn9xnkUBbwr+t
	sAc4TsQjjR8lpzApFcG9wAQ3pRtiHJvfGJRDXAdswhyR5ctWepRqTYo=
X-Gm-Gg: AeBDiet/bdvqEBEwBHsXtBF1A99b4kfWeS066lx9BILbE7q/e1CHOdk/IEh9F2AvEoM
	Efi979sRlfAZjugkZO11OKBVgyGKKi6WUawcPM8a2kuVsYElm41oBzu9sFwq2ouVQgubvQoTZol
	Q8cd3PZASiFPZ06B96qswuN5Fw3Vqy+NJmg8TbP/zQndNO9m6w6SmgrCPRWFoJPr84SNRlFvyoS
	CRMTyc/bbHzaMUBM4PgLs0vE8RRvhIMVKGtolBGNZBlDXU2PKULVKBQeJ+r33s3EqmXqxTGnvF7
	CV6cJpcXj0Ug5203UZJVzEI7ruAvBreIXOHMknMtPeqfyouwhW8sGc8MP1Msw8kPCZndjdM8WWU
	5cDvGpYQJl0PH7xGZyZtN/vJyrCW729XqeoXqq2ukrSsGSTRPpsf/e0JLmWsQOPW51TcJkluyJs
	x7DMc=
X-Received: by 2002:a05:6000:2013:b0:43d:6fb7:fee2 with SMTP id ffacd0b85a97d-43d6fb80156mr24109192f8f.45.1776291831454;
        Wed, 15 Apr 2026 15:23:51 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead402ee8sm8339591f8f.37.2026.04.15.15.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:50 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] wifi: ath6kl: fix OOB access from firmware ADDBA window size
Date: Wed, 15 Apr 2026 22:23:47 +0000
Message-ID: <20260415222349.1541181-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222349.1541181-1-tristmd@gmail.com>
References: <20260415222349.1541181-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34838-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: CABD2408998
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
zero-size or overflowed allocations and subsequent OOB access.

Return early when win_sz is out of the valid range.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ath/ath6kl/txrx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1725,8 +1725,10 @@ void aggr_recv_addba_req_evt(struct ath6kl_vif *vif, u8 tid_mux, u16 seq_no,
-	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX)
+	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX) {
 		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
 			   __func__, win_sz, tid);
+		return;
+	}

 	if (rxtid->aggr)
 		aggr_delete_tid_state(aggr_conn, tid);
--
2.43.0


