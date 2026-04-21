Return-Path: <linux-wireless+bounces-35152-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGe2HLuA52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35152-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:50:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266943B8D3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A09F301EAEB
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1223D9DAE;
	Tue, 21 Apr 2026 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he8gNFv2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA653D88EA
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779385; cv=none; b=WPinv8FVwmW3iDyQgQUPTALMncVDL1e/qKsI1jOr8/9CXTna+K14bDW5sTtWe2dGe00hlLWH+AIo56dUFO/S96CnWvwEcOGyN78fSOQlDMeMiMI+aaIMK4yXY5PxmIWiEkVpwWCj2SE0A8kXWPsHPrcdCECzizfY+KAF7nQumtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779385; c=relaxed/simple;
	bh=ChiiXRmm3F/dqlY3nOdKNxEUwQSRYRdBuTJ8k4ZPxlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RU/4yd7wz6BoV32AXfP6PDUDIY93zmTgXIZxoGu4nWGCeOHAgGs/tTSr5mnhx6yE7B4Jd1dtTWKQuOsyGZvT76iZaVAnJBy+juWS2rOr9h8IkThR1DRWhPYMnezkYWkXJZYzhUlWVTc84ehtAdJhjvtk/MrWEyXYe2DxOr06em8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he8gNFv2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891cd41959so23289595e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779382; x=1777384182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8oE+GpxOD5g4BmvE4XtuDmhQWyIt8yiyOWaNPkQBJo=;
        b=he8gNFv2Vv+pmtifRFPue3hlqcY9HV3qjdZmwJbuiyUCm1Bn85Ns6jU+Ra2Ta1qTBT
         mx8RyX/BwnVXtm7BmBjKcohGmVf8cp8hFz+fWWQri3g/yRLfWD2noaI+gtniqxtSRB4M
         eXoD1XZQjkK3hO1T51+cMqxqPcXkTohJNFhhxCvkTJKCticV0w25H/I2Dw3wof8tZwLi
         s5tl3KFFV33rMpJbE6OlCN8D+0g9OYX0OM3xvB2uemmXBJfzXAbnmQZJsNzB1B1lsRxJ
         3Q19oLcBtm8ISExHGcoLyeLWd1bdg9mrA+4D1wedf3D7DNAc7l2V2k1RN1Lr6eZp6oAk
         axVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779382; x=1777384182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m8oE+GpxOD5g4BmvE4XtuDmhQWyIt8yiyOWaNPkQBJo=;
        b=DDToult/Dx1CkXW9CsrEpxYA2q1IKdz+vNlUwEVrVQpaPu6TEH1r1HGhMkhhRXaeI+
         HvKsg1+hTKTdw7xw6kfWlGKIYpRxYHZ48Cb85JC/s+3TqMSlfFxLYYQokbwNiO6oUs7A
         Mxo/5f5AEESorKA4n7uJu0grQJ76RkLa4MYMZtfYc6yEXW8HiuRl8V3jC+xzKDD48cHA
         KmgZfSrgv1hth4j0xP8f5h+4QAaZySmy1AkPx4NTnpdSgiiRjfn7MPFHOuyCru9vFYuK
         KXkfWO8xPB/5wW3rgLFR9fhxG/DT9/bLLgkt6Z1mjnITRayW0h7H6bsXRJopMP2gAIyO
         xTmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OIX1SprKfSt8v/L85X15kbWm+mhcj8P6p2XrMggbFkUXaHKOAT785+xtut8n4TTGTp+CohRVYWxdGE/McyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX84jdhvpThFKSrl5Rn3rTJX3Cjx9VrKa14syzovKhMfmS50eG
	l5376o6izXRx0+ZhGKsXpYbQMlUGmyCunSY1w41RhyHyxmUcu6bapK4=
X-Gm-Gg: AeBDieuoeQ9MW+CsTGqRfm66deDd+FW3r6+7jdF5r8SKvGbh7nkQ454XaoNdV6B/uDU
	HHYpyAF8deudDifPFAdNvUN66LTZJ2aQUFo6bn4y06VFCpBHrOuguTB5CtFRJRjTTm2GHCtOjcy
	rg0qb98x8W+f1ZCu3rP+LMZ8S2gifpjLYAMk5ZG5CUi4cbcIqzB2srVNKi6wkrWM6G0QMBXcqQR
	49e/Xf90YNITZ4/61zx9VWmirQ2+sH3ytBd3A/M88TQmITZMloOv1i0cmMdDpE2sVOjzapZIo4B
	+nEqvkZRyV49Reou+IQqro7QKyvzAIuNQQEylWyhUBZ00KhOnQL6HaUYaarV6KBkQvwY7HC0TW5
	gTyZ6Hr57vmlwfngQ2P74zNt61MtlON+2IeRDzbFfuNU9xIYghLu3Qs5hj/mLo4vdDabH+hZIY8
	w6/IE=
X-Received: by 2002:a05:600c:c090:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-488fb74e130mr187796305e9.8.1776779382390;
        Tue, 21 Apr 2026 06:49:42 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm176331185e9.5.2026.04.21.06.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:41 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/6] wifi: mwifiex: fix OOB write from firmware TID in ADDBA response handler
Date: Tue, 21 Apr 2026 13:49:34 +0000
Message-ID: <20260421134938.331334-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421134938.331334-1-tristmd@gmail.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35152-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 5266943B8D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The TID value extracted from the Block Ack parameter set is a 4-bit
field (0-15), but aggr_prio_tbl[] has only 8 entries. A TID >= 8 causes
an out-of-bounds write to adjacent struct mwifiex_private fields.

Add a bounds check after extracting the TID.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/marvell/mwifiex/11n.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index cef8a55427dd0..5d97bddc71381 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -154,6 +154,11 @@ int mwifiex_ret_11n_addba_req(struct mwifiex_private *priv,
 	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
 	       >> BLOCKACKPARAM_TID_POS;
 
+	if (tid >= MAX_NUM_TID) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "ADDBA RSP: invalid tid %d\n", tid);
+		return -EINVAL;
+	}
 	tid_down = mwifiex_wmm_downgrade_tid(priv, tid);
 	ra_list = mwifiex_wmm_get_ralist_node(priv, tid_down, add_ba_rsp->
 		peer_mac_addr);
-- 
2.47.3


