Return-Path: <linux-wireless+bounces-16468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C29F494F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 11:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C2D16CC7E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0EF1EC01F;
	Tue, 17 Dec 2024 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp/mMxuR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8821DE8B9;
	Tue, 17 Dec 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432910; cv=none; b=XgFjIyct2CShE2Fa/wBN+3RLNPF+sFiHxj3rGbAGSFGRkc5y2AzoxGhUFovWHiCxox0dEyFNqoQq9zrMS9o2qP5Hvc7NbtpFXV4mM/UBbx1j57KITPyaJHQsGgoOA8zNmW3RoUdVe6kdt9gWI6g+VfbrNUkgYAdC53uCPvAxvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432910; c=relaxed/simple;
	bh=ARmUWXNjtCdLplhcw2jPmOWbt7LIjIgb2WlFDUIbPBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JoT+d4tNHK7CCfB0R+5n/K0y/qKATRO/lqE+F4EHz3Pjrk6umX/aOGq16DzgvOgonncVVKb3Xo/UV3MK9xLC9BfQZVQ2wbxeWYsOU7w+34a2Ao05ojtJ4KmUs3RN9JnX/Ca2gqdPPtXqJ3Z0GulMy+SknP6e7sC8ebnRK1/mW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp/mMxuR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso5533153f8f.2;
        Tue, 17 Dec 2024 02:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734432907; x=1735037707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1P1TqEyoALESItQY8HZIv0AXy8Gz40dHfSRpRIHYdo=;
        b=Zp/mMxuRDIR21kpknHgxiibO6EkexocqBGR6wVspQjCj9rGFzK2TacR/c5L/tYR4Pa
         5zDZKJnDCs3fYyu6PKnUrlCuYvigM+fIILn1zenlXPYg94oW110hR5TZ+rXi0RtW0fKM
         nHF70+tla5U/plejWAIxdmqaqc+uX8XD8guzr/AIz8y6z0IBzsKsHb8vB7MuS193fnKV
         j/emOwPrwMj8Izfjaz86QYeD63Z8F5CJB5LNb3VmXApnFBDIW3E6l5MhPW772EeHd7YE
         udd6x8uWXbzxJUIbwpz1JmE4F5B8o3oVO95rPK/Bl4zby6SAqRo65OZ4hqtnzjuaN7T+
         +UEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432907; x=1735037707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1P1TqEyoALESItQY8HZIv0AXy8Gz40dHfSRpRIHYdo=;
        b=HtIwSvIvmBk4B0ZDUHeK3CBGPBePD6BpbT10QQsC12CEjHj8qbFbutJNFqYv/b0FRg
         OR3WA0YyvQrCZqlg8XMpVWMXGjIStDJTOHvrxaoNKWYKgJ3TTcD8OYeNWFI64CQgl115
         0xPqaPulU1DUmH3RK1r5oHCVviiY1IzZcvPiX3UiSBsY+/bQVGE9D6VWjh0X8TmCiy0q
         c8nXOMQskj++nW4sQKGUUkmKAX6UnOoksYqNmI0aXG1VGqfl2jmyt3ZDWhHq95N6oazF
         jOgleq5JVXYXdgVPnqxnyu5KCvz6vAqTV1LK3bzoONpXj92Im10v7wuLc1lqL6W4WJbs
         MZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCVaA86TdJUVEU8RKSMKk10a0v85XfXOeQC4N4JeOqkiIQThvDWiLjRabaLAgcR2p9sqBsSSchdjY4BjxNKX560=@vger.kernel.org, AJvYcCWtkx1IHvrefHHt4zgYoXuEcIaQ7pHSIKUTq7fpgUTUZr5O6qx3E+81tPEwsBx62PZ1ZYdUidZ97Vc+64w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1pyW+9AezXDy3ej0ITVU700iMlKG4vlD+osauTUthlmOXZOZk
	Fk4qPoVKycMAwgLg+KZlkG6vR4aez8Zxe6HEhTI01GzdBlXZWaz1
X-Gm-Gg: ASbGncv0aRMUrYtWM5DMb74qsPtPoRJ2f1S5YmOPF9eZt60ijiEap4O39oau7AlFR1+
	0UR9q9vLgFMy/mLTpiIFpAhjYLgR9CgsRqGrIEtViPPEFdi7HRkVi83RWWfK0cNLsEAeWZf0JUH
	6Rv6JY8ZVbRpNkREG8qP/kiCaProDj9P4iLYq5v3kDfxFTz0Kpb0vbuN0HFUqNDKvl7S9dah+f9
	zwdNNAYkaUnxbWgfJ+0mwTSG1HSIM3nzmkMo+lmjHTJ9C510QBPBy+WZg==
X-Google-Smtp-Source: AGHT+IEh1D+hUTDqtsK6Q6FnMsXdjFA7vFWK+1wQfH24VH3oPJK5ij9/iIMEiO2NSFyK3gqfjQY0oA==
X-Received: by 2002:a5d:59a6:0:b0:386:381b:6690 with SMTP id ffacd0b85a97d-38880ae152fmr13393915f8f.31.1734432906277;
        Tue, 17 Dec 2024 02:55:06 -0800 (PST)
Received: from localhost ([194.120.133.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8046c66sm10704706f8f.69.2024.12.17.02.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:55:05 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: ath12k: Fix spelling mistake "requestted" -> "requested"
Date: Tue, 17 Dec 2024 10:55:05 +0000
Message-ID: <20241217105505.306047-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in an ath12k_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index a8ed86a294c3..5c3563383fab 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2618,7 +2618,7 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 	if (!ag->mlo_mem.mlo_mem_size) {
 		ag->mlo_mem.mlo_mem_size = mlo_size;
 	} else if (ag->mlo_mem.mlo_mem_size != mlo_size) {
-		ath12k_err(ab, "QMI MLO memory size error, expected size is %d but requestted size is %d",
+		ath12k_err(ab, "QMI MLO memory size error, expected size is %d but requested size is %d",
 			   ag->mlo_mem.mlo_mem_size, mlo_size);
 		ret = -EINVAL;
 		goto err;
-- 
2.45.2


