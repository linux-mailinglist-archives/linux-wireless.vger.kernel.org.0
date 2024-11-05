Return-Path: <linux-wireless+bounces-14938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A166A9BD724
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 21:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40EB1C20F28
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E41F8183;
	Tue,  5 Nov 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkkhp4wA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B661CB9E6
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839219; cv=none; b=UZsj08K8PxVvayVyAJAaWYubkiKQbfviPMDK0MR/7jRi2RBkD7LDunuS7YTnbldgEd7l5DWDhhOvAfYZ9qzbdNb0q4xhxrgb7kfEWx89o2ucxfUWnq/JLDHhN4xp2TnDFd2z0es7mOiJGnGlErwfBxdvlJUMRIUicUwTMK1K4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839219; c=relaxed/simple;
	bh=gRX+9AKtNIGSCrLqOM8SDaBgepi/RtXUPk6cjRt0E6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNM6UbdkTqtMKP0fAn90Vr8/B6TjMuFImbOtPmk3szN1bdhB4IHAU2HEccknDH2FPWTQ7JtlTXsWxA3tRbriGTCHvjeFHehRz8VtLd2Ip4VDaMsRnEit3P66FCtSBRHkZU3OLGTtHj4suj3jBRWJ+8AK+sOvme6CkJkjm9CPtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkkhp4wA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cedea84d77so2765642a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2024 12:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730839216; x=1731444016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jn35xIkqQYJnCioVH+H86gECBogCSl/ywNlSAFiU+/s=;
        b=dkkhp4wAOtpQAUyGc+KYm0jRUjDH9Ws5j/sWcs1ktfu9ILQ15jpfhYIH1dfQ3AiieF
         rUYyvlUN3AG+23SKZiQ6PWQ009tWsueNe42m2L03PV0oN2Fbd3yikODgA9xUM+9OVvb9
         3nizL0VThKWH8OZRehhj7wp4qn2FMAzVEh/z/3fcrqfRqdoL6CDbiktpup2hMDEhg3TA
         KNpUGBHQcLt3m3Nk8df354zE93QAwjOZtKCriihgwDhj80eljLPptsw1yPcckhUfSmim
         tmxdYi32DIVf953PZJjYizDnSiPkPERIFu/oUB3tu6Xzh0cBLeNqJdYP+NQ5cuVrU4XF
         kOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730839216; x=1731444016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jn35xIkqQYJnCioVH+H86gECBogCSl/ywNlSAFiU+/s=;
        b=nK0VVub6pR/4iAVEuvNdbu1gAb7upzTRNSgHUMdhG/c1xyyVlWAtPNOz4xLqXQ+kP2
         GLnhzLJe3UFa2mC/riiO4pvDRga8Xtm6EgdqXDuXtenRjSckyYcp9tQnjnjGdzjT5Kyp
         eKkGlo7zojjgHEw07ZAS3CnSGwXWxaWG3E9xuh5tc+EifJhwyXF9s8SLijBEHnR8KVaK
         JiqVnH8mKXAG7nAsymL5CjwkM/54eLW0ZP3MTd8XfBKYHeHpqwpKv/0IhHm0Eje9+lE0
         brBMDRu6G+sEuUR+aP3o696bXcF/Sh7MV1BautLJ07bKKJE7iidsSxvoXeshMVyB7Si2
         dVWA==
X-Gm-Message-State: AOJu0YwjIMNwnI45gGXSILployz+KKjq3Yo+p3i92UL5ldroZdBnAMWm
	0kuX83K50LKG0k6OHvH0djhz5qVN19tw9ee0k3W3x8mz2dQUKWxmf3JTGCrh
X-Google-Smtp-Source: AGHT+IF5K4cum6IB4B+oiHS9McJE3l2Wqd95W1j28OQBb1NlWMFpDWk6EyKdv4n3e/TSnbEQbAnCBg==
X-Received: by 2002:a05:6402:248b:b0:5cb:6841:ec8a with SMTP id 4fb4d7f45d1cf-5cea968a150mr17682393a12.19.1730839215656;
        Tue, 05 Nov 2024 12:40:15 -0800 (PST)
Received: from wlt.home (77-165-185-46.fixed.kpn.net. [77.165.185.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6ab1a67sm1749237a12.35.2024.11.05.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:40:15 -0800 (PST)
From: Norbert van Bolhuis <nvbolhuis@gmail.com>
X-Google-Original-From: Norbert van Bolhuis <norbert.vanbolhuis@ev-box.com>
To: linux-wireless@vger.kernel.org
Cc: Norbert van Bolhuis <norbert.vanbolhuis@ev-box.com>
Subject: [PATCH] wifi: brcmfmac: Fix oops due to NULL pointer dereference in 'brcmf_sdiod_sglist_rw'
Date: Tue,  5 Nov 2024 21:40:11 +0100
Message-ID: <20241105204011.1603148-1-norbert.vanbolhuis@ev-box.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a NULL pointer dereference bug in brcmfmac that occurs
when a high 'sd_sgentry_align' value applies (e.g. 512) and a lot of queued SKBs
are sent from the pkt queue.

The problem is the number of entries in the pre-allocated sgtable, it is
nents = max(rxglom_size, txglom_size) + max(rxglom_size, txglom_size) >> 4 + 1.
Given the default [rt]xglom_size=32 it's actually 35 which is too small.
Worst case, the pkt queue can end up with 64 SKBs. This occurs when a new SKB
is added for each original SKB if tailroom isn't enough to hold tail_pad.
At least one sg entry is needed for each SKB. So, eventually the "skb_queue_walk loop"
in brcmf_sdiod_sglist_rw may run out of sg entries. This makes sg_next return
NULL and this causes the oops.

The patch sets nents to max(rxglom_size, txglom_size) * 2 to be able handle
the worst-case.
Btw. this requires only 64-35=29 * 16 (or 20 if CONFIG_NEED_SG_DMA_LENGTH) = 464
additional bytes of memory.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 17f6b33beabd..42d991d9f8cb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -770,7 +770,7 @@ void brcmf_sdiod_sgtable_alloc(struct brcmf_sdio_dev *sdiodev)
 
 	nents = max_t(uint, BRCMF_DEFAULT_RXGLOM_SIZE,
 		      sdiodev->settings->bus.sdio.txglomsz);
-	nents += (nents >> 4) + 1;
+	nents *= 2;
 
 	WARN_ON(nents > sdiodev->max_segment_count);
 
-- 
2.42.0


