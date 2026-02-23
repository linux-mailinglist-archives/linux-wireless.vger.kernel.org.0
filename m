Return-Path: <linux-wireless+bounces-32083-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBGJIT3Am2no5gMAu9opvQ
	(envelope-from <linux-wireless+bounces-32083-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 03:49:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E62AD1717AA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 03:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A62D3008D0C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F33316918;
	Mon, 23 Feb 2026 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fngS7YgV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682C313540
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771814961; cv=none; b=rkho55O77TA//BguB1VewfLgEh77rXjC2gKKDTGEQb3R09mEMGEDPCt52AcP5Z04J+BybcX4XmLqQ6WG1cAZMyFGvrMNfZB1gubLXXa8lSyN41uYPiiLkh36e54UvxJMqW45IGNZdnaVjMnscvY+fx2BqOnXr62ss86TRpUIH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771814961; c=relaxed/simple;
	bh=0lKSPhF/aw5pCRvSgzrTVBiNHQliLH1SwcR06oDLD18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scGMI0T0R2492KWf0XLHvOVXX7qr+XMJXKNT5kInLrTxU4iyHtn5ztuuHZtnt2kZOpDuJh4VUjlLu5FUctF+O2bJ6+WsLGHMR/9xwfTDAzL9ouemlgq7lLuh26bJBKvw9Ft4RtmSZ16ao7ZZvQ6UvJP/Ee/cDDXoO/5jCXF4Nos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fngS7YgV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aae146b604so27133275ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 22 Feb 2026 18:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771814958; x=1772419758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUfZvLCxWQPo9+B+GJatrz7V0AxZAnIHeCpWnwAFuA0=;
        b=fngS7YgVO0PREpFbBr8PIiq/akg6A4t4uKMTwNv+BVSnUPbjdlRqSUdsW/3Eajq+8g
         t6nWiZd+wCPIPJGqNMWfocZWjnwtsD4xGURcoEaTuVuNmK6WcPjP77kiSwth9YqMgukI
         mqLKFYdfjENwfnYa/5zr94AYDok7N0q6VBbm9YlBqWmPs59sjJTSeimgDE0GQdldkTnC
         4hRJsvn44HUVanU3cvIaFVgMd3j5pUtUVfpAtnIUzER8F1hCPNV/Yftb8yneKlU/DFHR
         NbZcKSCPQD9MQnLcETNIV9ZFqUl452Hz421tw9BQ0rwXMwZcKW5XCDLvHuMsWR4KVPhy
         Xzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771814958; x=1772419758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUfZvLCxWQPo9+B+GJatrz7V0AxZAnIHeCpWnwAFuA0=;
        b=GFcNzVHw9Rh78KAyCX6B4fJ6dKRDHuGmMxNpBh8RvNvYKuqKWsl4RIxzI6XO7YzhjL
         YyFPUAvdl++G8bIdAARs5fURqx5e3QujmHy6bXZCKPA0uZPo3TfsueUCGOzKPnB0Xwrl
         uzfaJiIdCUp29vLobeAlJ8hq1UjZ6/IEOPg6yAJSFuJu69poIl3c18MMZzx3dquhY+en
         JCeJbljKq8ZlZ0WhObjrJfyy83ZhfAyMy2CBJ0JRueY+oeAaJIlK90efLWZsRh1WFBNd
         mNU1+wZd04I/qX6xd1gGsjCbWduGpK/Ry57glw0ooTaWp8y03ybGia6M49M4JPPF/kkK
         PLXw==
X-Gm-Message-State: AOJu0YzNa+Sdj1xhpVAcm/ikfkDbLz+KhocY//hsiv1quouBLGWDLcMy
	xCw2m8Om3wp70Ve9wACEukb5combNIESs88Edm0YoXjcvHoMkS97LWVBR5mNKbB/
X-Gm-Gg: AZuq6aIm4culu5AJU31+qV9tyx3zt4WqfFK+0oKNd+I/tpsUyWS4eciEufIq90Yi5ec
	S0fVzEdF+a0QB4fzxy5wSaSu3IlE3ZQeMCKXGLQplsZikGYBP7fhEA9qD7OVrNCAjVclS65CETS
	xWt317Gv2GqBUTNXPyJItvFiAcQ9INxuDxrl1UJyTMf+yAU83ljuKd/E8hx/abK8eeuSd8p5pH8
	vTEref8a4NhtmcQuH9TGv/mDYWxTJ88CN/IrP2pfwhU9qO07VByE9pWbVK2sKlRIlFaBnDjAmOB
	fKjkKcD1yehiXyfhweIoz4P2TTAn7SfWlTTC9UxCmdI5lJyubBPfyPB5snb9EpPxTCeYf8KzXSP
	W4h0n+0fBfDkRJGJwz6RPasbX2Edtp2QC+/KSgfVbgnJjCrm9o6e/HwchnXt9WsoV2otHaDV4h7
	SHyzu8xbEtotof1U5HvCRyZqtKadKbyjHGwHnnrXEINzQCQg7/w096iA==
X-Received: by 2002:a17:903:3b8f:b0:2aa:f2f3:bca1 with SMTP id d9443c01a7336-2ad743e304emr67075485ad.9.1771814958388;
        Sun, 22 Feb 2026 18:49:18 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e350a9sm56126785ad.15.2026.02.22.18.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 18:49:17 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath10k: use non devm for nvmem_cell_get
Date: Sun, 22 Feb 2026 18:48:54 -0800
Message-ID: <20260223024854.18910-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32083-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E62AD1717AA
X-Rspamd-Action: no action

There's absolutely no need to extend the lifetime of cell to post
removal of the driver. It's only used in this function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5c5bd5ef7175..38c5f5f95433 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1981,13 +1981,14 @@ static int ath10k_download_cal_nvmem(struct ath10k *ar, const char *cell_name)
 	size_t len;
 	int ret;

-	cell = devm_nvmem_cell_get(ar->dev, cell_name);
+	cell = nvmem_cell_get(ar->dev, cell_name);
 	if (IS_ERR(cell)) {
 		ret = PTR_ERR(cell);
 		return ret;
 	}

 	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);

--
2.53.0


