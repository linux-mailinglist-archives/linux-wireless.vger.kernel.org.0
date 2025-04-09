Return-Path: <linux-wireless+bounces-21313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99854A82307
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 13:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FB9174154
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7A245031;
	Wed,  9 Apr 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InKwe0+Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACEB231C9F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196492; cv=none; b=s6HcyWhaH5veXsdWWlQm5qmkAarxsh/K20u73QvAzX+EkuGYn1JW5WC+L59G9aF4ap0D0DsTOx7kFLhyRcbzoOSPn+FMyDrgJ17XjSVN7YDBNthN7ak5wX3FDDbmU6x0DXr+sNMUvaK7+m7HD4H9pmvyqDt6gKjD/ZccqESDVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196492; c=relaxed/simple;
	bh=kbcnBub2qRCGOu06jo+ufjNUGTCmhyGxpUtKPPrK65k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JGqVH2m/N4/QgtXOulrcHN864XeY2TjXLEHj2PHCBJjwyx7x36m3oZKniI5VPnYphItnvuMBJXQf23tRSDhCRdJN8Fs6ObeZMpfYaP25/ybponOjwVG6YZHwiI67EqVrMk//uXQxZuBERXoc2VYrnuwGWJ26QsyBXlo3hzTY4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=InKwe0+Z; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c2688619bso4090033f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744196488; x=1744801288; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WexvrN0iRH6s5lqXIKOGOc76DID+kB8LkmF1Khh6aFg=;
        b=InKwe0+Zr4NPnAaN7KME36tJvgoUSCnXpsh+0E4c+omkT2jYPFPCi1iQaAGFxOvGr+
         8sA4AuTt5sAodApX0OwaoG1ob9tOIM66G8g13MtmdF83DmI7EA0pyeFlwAvhQ9K3zHGY
         yW7vh1M3ykS+6AGNO51Puvbd9jdMR/pEA4AUKmgMOzOTRIws9wyzqwnacYWqjU4VZ+1v
         gCINfWDzGqxeec66CHtzWePY9O7e6uaI/rL5drlzfCznIekjv4IKiWB/5SOFbFM5sYjU
         6ryevgrFMPEyQzi/tUVExaJHAhlGW9PvseXTsGoaPoOKCvfd/8lsbjlzDhdtHKV7v5zY
         DbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744196488; x=1744801288;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WexvrN0iRH6s5lqXIKOGOc76DID+kB8LkmF1Khh6aFg=;
        b=JkquXFPwFCiZ0+ZWjZ1DBX2dw25HQEDfGUIDLg5z9d29T99D4qDvqJZ7ghv/yxiW4O
         z+iSyqH9S5pd89iaja8cc2DjVmZMimc0DfO3PokuprorCEH8eZ/xB8OIDM5CM809iZit
         Ix2yP62ldL1oaP3yWxdbsdpNgBJjs+9ApW1THZaw0ApdJ1AKnsToYm/miFnsZiisJqv8
         XsKy05J+zYS9f+sMV0EcS13jPj+AwunCKAXflOch06hZKZJ0OKnFUBGP3UNiMRTAjWeU
         ofVGyqCuQLhhD5kchJKPY5TgEaBl43gea0I2xjiP9pmiboZiyONsnNefZ1NTi4RVPCsB
         CQAw==
X-Forwarded-Encrypted: i=1; AJvYcCW05YiJhSFzgo7z0i17ap7i60uPFlVcbZGM5gGXwB97zXOoUjuZtQSLBWEyyjhjw7H4gzCcjN5VZhYj2e6HnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqJNkdbZgrSN+P6PU6Q8/VmpPVxd00OEiNhi1XiFRWAY1cAMg
	kgRtAXFaKc8uXrlP/qY9KokX3i/noCDSQrlkmw+j3gueD4t9TbR6O8LNsKtgaNo=
X-Gm-Gg: ASbGnctzdLwA8+6+0LhSOVDr1p9UIRzjO/yRdSEsS15NucGDcmlfderln7H6BXEN7kV
	ztSeWN7p11GMrBxRCNP+rgpCYZ1Y8P8xL5ng89lnr+yrzgyKp8aNCGOOLx96tL0tCIer0tQBJ8l
	nrYWWS2OeDhFCUV3Q/ELNn1thzWV1Ck7fnLpOqSz/aCJp3Ox/PirQwsdAocVFnE3Yye/zaoNUS3
	VAKnaoxtUBTACmO0QEtnH55C8Pgkmr/TzqKkH6qX8rkUeNUTRpInXv8JJfEE10iypajbGpSC8Hi
	MbgkdjdfiaSFnvsAEDIjNwxm4NG7OfuMrEgmC6M6y+mo9w==
X-Google-Smtp-Source: AGHT+IF2Njmy6uDcmNjK/vqJ2HttsKJfbdo9EDMtXLQyenYtyEJxAD4fQ/53R944kzDkaZ5HLwroFA==
X-Received: by 2002:a5d:59a8:0:b0:391:31f2:b99a with SMTP id ffacd0b85a97d-39d87aa8ae0mr2409272f8f.5.1744196488617;
        Wed, 09 Apr 2025 04:01:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d8938aac2sm1307492f8f.52.2025.04.09.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 04:01:28 -0700 (PDT)
Date: Wed, 9 Apr 2025 14:01:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: ath12k: Fix buffer overflow in debugfs
Message-ID: <35daefbd-d493-41d9-b192-96177d521b40@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the user tries to write more than 32 bytes then it results in memory
corruption.  Fortunately, this is debugfs so it's limitted to root users.

Fixes: 3f73c24f28b3 ("wifi: ath12k: Add support to enable debugfs_htt_stats")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 1c0d5fa39a8d..aeaf970339d4 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -5377,6 +5377,9 @@ static ssize_t ath12k_write_htt_stats_type(struct file *file,
 	const int size = 32;
 	int num_args;
 
+	if (count > size)
+		return -EINVAL;
+
 	char *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.47.2


