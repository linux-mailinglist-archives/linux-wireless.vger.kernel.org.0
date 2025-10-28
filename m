Return-Path: <linux-wireless+bounces-28343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D62C16132
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 18:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564283AD220
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Oct 2025 17:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2328A3EF;
	Tue, 28 Oct 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="c4GnotxL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B99288C3D
	for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671120; cv=none; b=unqm2pqfWayHm5PvJdwmLNfGV2dDkUccqaBebWWYN/BADKiMsR93hjABW/jCK4N39hAsrrrhELSMblGjplPUPzqqUWZa/1Ff4O8RGL+FI+o4WmVH4+lspkJj8CUFr5JPbUhlhbQlySipFt99ammoj/zug0WK81wCQ1Is3fGY/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671120; c=relaxed/simple;
	bh=N0/zVLICnxNKLek4t08+XI7tTQ7F4VIB4xy8YpVu/X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abAatQSHW2rFVCBbTPYuVi492oqunCVAB21WFzOKpay0g7cGs0zxTZw1643J6VH5lAT25uixA36JqkuZObXFm8syMl6UyfVb2zXnCXHR+IbGQLz2oMr762W1IB6b5sLXzg3E1bEGH2yq1HLJRMUSGk8Hc6OGQORls49Lbcc/zL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=c4GnotxL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a2852819a8so4371907b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 Oct 2025 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761671117; x=1762275917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBmB4qbptLfyTLiupE29rEaJ57aI2ZRJhbVvsp8ICt4=;
        b=c4GnotxLcEERpWB3rJJziQb67+ooOwT+vJQuzsz1SOuEEGUpXpRKHh8kTpuid2pDYy
         OL3qe4qNpzOX06It+jQomvRqgIXkHTgwpBDwvzVzoE351MyvvQujr0ng/BbxWmlJk542
         Bxl8J8jgULU9ykuI9LfGKLyEfvStXDfqJwGs4T+eq8hD1H80HTvmZbKB5DX+XNXgxChs
         +lG2vnE8bwQP5PZi09wi8chmv0sTCmpyuVy/4yTDZY+uD5WD/My8Do/rosOzIb2Q/iJ5
         hDUhuzuOm6n/48NnzQX6tIP/AhAB4dZugVNYBpaZ4eRHQfKPSXO+vDsYQJuBRyNMsqlI
         JayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671117; x=1762275917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBmB4qbptLfyTLiupE29rEaJ57aI2ZRJhbVvsp8ICt4=;
        b=EFcb7REF7kavHmSNxR1t0l2Lr9nJj4KJgRiYVi5aCbQG7Z6IL8M8mD03BGpV+j8/N6
         1ZdMlShLFdd6805gC8WZUBrbyVecAzR1DahvcPbcsgJfZ0EtQdxCkJkGFVWsXudvtVx4
         auZsU1m5VYWSRmllynk0n/0iIT3W5KRbqS0uuqCO/UMbT7R7ZFbsX/OG487SC4ueWfLa
         QAkhASD+R+i9B9SRzdCJXElvo4hffM0J3WO42D3reJpKPtM6h0z4XiwPuSz1wLucQScQ
         Z78hN1LoO3PbOqzGGyQzu0f5cEMuvyFPNu+NxahSA35KYUknjbmRrhT1Xj2vmPvAxaiC
         9k6g==
X-Forwarded-Encrypted: i=1; AJvYcCV1ygPD8ZXJhjlFZwkIHkSS/g2JI6C0cgsfu+K3Q0m/3MBa8k67i61Xa+y+s+CbD6beOq1Uo2uRvH93KMXinQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTUqRcgGH9ysjB2+IOr3x13axqCI/W0MAqT0NhPab73LgMIIP
	AIcSHY25EhNqtgMF0ILgbadp9TV7ad7Qs2k++3AnxnifPGHU8tklEWIloPsVFXgcqvY0cNS018l
	EPqHpZDc=
X-Gm-Gg: ASbGncu43Eu/xvS3VvSmEp5o/w1apCqMgu5BnyEuR/pnEp/lt2r8a7mAPm84iZVS5Sh
	K0/5hSE/TOUirBraxF3yXdmvSSRHhOAmq5aNSAHW+TjKO92rl/FUoc69zOalXI2RXgmrSQYyZEC
	q84ktgCdmiT/uJcpALfRmw1ykV4yEi2/xsG7FF5VUl5LQNBRhLbE0W5b+E2J13eQFAgSplBSjND
	+SsPbdgszdwEpZoitaKVvAifA9HR3seUcNfjvGGNygYNymPwX2VRR9hsM+SEMtDjnO4Yy+5Mgis
	1p483dX+oCbTncjQL00HZi9Bg9vOMKVJSfIVBL+GKNz57nlmsC6XJex+Q6epjlCEa+H2dKzhZ0l
	oCaJULfT6+vGrEYfzXwwwCzyIIVcJ7ccqhmnNT0T+z6Zv5ou0MvouC7H2aishnlWeiKUGxucQGG
	woz75v7L9zc+k9
X-Google-Smtp-Source: AGHT+IHjvH8tEuZg+gXvi6IM/+7or2ktCuzjFSHVpKfrsaF2EYXSWsRTQJnVaoBW4TL1kdx24muqFQ==
X-Received: by 2002:a05:6a20:258f:b0:334:89c6:cdeb with SMTP id adf61e73a8af0-344d441fa42mr5353099637.56.1761671117283;
        Tue, 28 Oct 2025 10:05:17 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.46])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414068addsm12508862b3a.44.2025.10.28.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:05:16 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: jjohnson@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix potential memory leak in ath12k_wow_arp_ns_offload()
Date: Tue, 28 Oct 2025 22:34:55 +0530
Message-ID: <20251028170457.134608-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the call to ath12k_wmi_arp_ns_offload() fails, the temporary memory
allocation for offload is not freed before returning. Fix that by
freeing offload in the error path.

Fixes: 1666108c74c4 ("wifi: ath12k: support ARP and NS offload")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/ath/ath12k/wow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index dce9bd0bcaef..e8481626f194 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -758,6 +758,7 @@ static int ath12k_wow_arp_ns_offload(struct ath12k *ar, bool enable)
 		if (ret) {
 			ath12k_warn(ar->ab, "failed to set arp ns offload vdev %i: enable %d, ret %d\n",
 				    arvif->vdev_id, enable, ret);
+			kfree(offload);
 			return ret;
 		}
 	}
-- 
2.43.0


