Return-Path: <linux-wireless+bounces-17903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4CA1B4C4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 12:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADABC3AC2FD
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 11:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CA1D318B;
	Fri, 24 Jan 2025 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH1mjCIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CF1E495
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737718418; cv=none; b=ln5fnqTQFE6Uv/fpIpz1muplOjLsPFgrQZ6MtFFaGwJPWJPSTstNR0HwDg6M7c0j1SWveOSNgTJxJXeAqiwYtN/9hDOHdSOXdSAmeTvIn9Xe8OXlXpUgjm9ZNkgcPCcIQtSEFgM/G3n++cc8Tw/7i6h03tjd0tFxWFbQSanpbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737718418; c=relaxed/simple;
	bh=UawWp+E0S9mhIA0FKC3Hokm1QMFOGVcuJ1rOuE2NGFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmcR+PmtZOmBh2znfcs/D62URxiL+PZr91MCmMqO3Db2T20HHfSEpoM+akDmM+V51jWi9Lp/QY7YK/a1HB9DP0QEoNBXzOJUt7HwGThDn+3yNRy7lRyt6C1N0VL6PPstahVkkN9Z9RUV/PFJebh/HiIC4lff7rG/jTV1UIaX/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH1mjCIX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361c705434so13961985e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 03:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737718415; x=1738323215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J1hlt8R5MIkYuKBDFZyWOw7qVQ6zUZRXXaHPTjNJ3X4=;
        b=iH1mjCIXzWD9MK6h4y38JI/hed3kvndDuQuFvWNyIuWb5diA+M+i1TsJnttgn766cC
         wCBKtwW1D+WcoD+4RS7CJIRgSCJCp5/7hY0so2fnS4Ds3DuYbicuPu1wQeCz3k4d/zyG
         WRZX8JRC5WsrxjlWrQKvXz6MTBkNpbYCitNhP/YprsCao3alQt4YmZ4FtAnCzzcMX5ut
         JG9QW4mzE7ow1g0uuLvtaoS+DfNyB6jx4Qwn1s/D6uaYWfiunhbsSnn15E6Kg+FoSk0Z
         ODp/p5i3cmQ5Hu+3GFbvy38u45dz7LA7DmXucbuFgRx/pEyqN6EGZMpkJFDDEPD4PusL
         azCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737718415; x=1738323215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1hlt8R5MIkYuKBDFZyWOw7qVQ6zUZRXXaHPTjNJ3X4=;
        b=uQYcsGnxZ9QUjpW6zQrqVjcPTBwlX5Nn67jDZ8JgO2fnwvZQTZNqJWeeGOaI8V3VbK
         pkHSAoAwJNdcSNxx8O6zJpfhTk6J0tmf8lsO81hXqGx8cmfvOpBvQ+07FJPWr9WP7/2h
         ilOJpVlxyRLEsoVjUmI0L6N5ukVHe0W+EeLs473x4BDITH/EApfT0MkBUeMCSRQhkiPV
         FFyxCL1eansnB/VR6Xz6M2FjZcuNlYUO/kVq7eTn5/xUnypi5a3flug5b+zCLGfjfxnP
         xqjAu/LDUYeaRRE3sfeHpKeapKVl768/VPwhBBLMIcwdpOcRq5yP9ptS5KnRL2XbpLq1
         06aA==
X-Gm-Message-State: AOJu0YymjzTbOYrAuoD0Nf7eEgeo6u9SUbN/8I0SVR8kUa7uNy0H8Wzl
	QVSPqwQy+UoMStv1X30l1dYvnhqu8tEWEErrzGzL3JNjHEOGLG63
X-Gm-Gg: ASbGncvWX2RP1rs08r2O+keHSYplTgng4KJvec1P/sVa1mySo4PExni0xG0ERcJywIu
	o5vwFybIDhh+04wy6/vxOh2WT6m+1CYUg5THnP9Gdkb5beCxNUuGTezuwTp3eGTXAaJob2C5kTb
	diBv1B37uRm7/eCY1HT8JWrNzcIZ9zw64lYSZvJ0e7Rt2Dkv2wteHqsbSTanDWrZallPhZS/2Gq
	gcSqN02n4D9eNPy9S24YMCIBXmlELObLaMh3rEaKuCbY/AMRAJe/XDdRRAAPd1KouzxhPcqFJFz
	3gNcrTVbAgNBGMYL2ppf4WbX+yMcFuzOAEl+eA==
X-Google-Smtp-Source: AGHT+IEN5SA3mcTu8+dkgNi2gfN0uW281kkON4BfYZ/abceYNTwrjsaBX8FI3uSrWrYBhq1/idSU1Q==
X-Received: by 2002:a05:600c:1e1b:b0:434:f917:2b11 with SMTP id 5b1f17b1804b1-43891429682mr249292255e9.21.1737718414853;
        Fri, 24 Jan 2025 03:33:34 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd501f1esm23068835e9.12.2025.01.24.03.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:33:32 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in ath12k_dp_tx()
Date: Fri, 24 Jan 2025 12:33:31 +0100
Message-ID: <20250124113331.93476-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When AP-VLAN was added, we did not add HTT_TCL_META_DATA_VALID_HTT flag to
the tx_info's meta_data_flags . Without this flag the firmware seems to
reject all the broadcast (ap-vlan) frames. So lets add it same as ath11k
did it in commit 5e8a373c8699 ("ath11k: Add support for dynamic vlan")

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 00437736e0322..0d7a079f4c6d1 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -368,6 +368,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		add_htt_metadata = true;
 		msdu_ext_desc = true;
 		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
+		ti.meta_data_flags |= HTT_TCL_META_DATA_VALID_HTT;
 		ti.encap_type = HAL_TCL_ENCAP_TYPE_RAW;
 		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
 	}
-- 
2.48.1


