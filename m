Return-Path: <linux-wireless+bounces-24266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9723EADFFA8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 10:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5DF17FEBE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98E25C81D;
	Thu, 19 Jun 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUExpgCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432E26528B;
	Thu, 19 Jun 2025 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750321235; cv=none; b=uph66fumjhecBkYrhhfHIVgiE2i0CPjUMwBeV02MmGTb/lu50pZjnirfolw0G1OxJ1JhmfGLj2B5mdN38XIoy0A7hw8ty/mdKGeGC7rdSu/vnoXra0ZlzXcrX8kyHSaXAu91fVJP0WNQrONZepJlay3WE5NqEJNQjl5dMhqyGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750321235; c=relaxed/simple;
	bh=EgxCdCrhAJ9RY/w6TgbM74DLG5HeaAAQPQvwKpWlaLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gQTVkynQgNzscOhLZWxfMpOKqfM9w6p39dEvTJLXjxvB0tcto/XQMP/TFmbrowUGxWHtTGINWi5ulB7s3Jgm0u+BE0i/Q7Vme8pwlPlvV0in88PdENIagXkFY0Zxep6IBVcPekF4OY47kLklm95cIQHamdshNEogeifi2U0/Bc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUExpgCa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450ce671a08so2761175e9.3;
        Thu, 19 Jun 2025 01:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750321231; x=1750926031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pki03gT1X1YzuKfpbdeTT2NdVOKEL87eulb7qk78kEs=;
        b=VUExpgCaTcLdDeLYOfPDHxh9bQbq12rAQLt8CDgJiEqdvqz9ayUZGmtnBVbRejXYyZ
         H+GO2XdhH3jRpN5ODxmYJkuIKD+votu3JO5MYaCZ3KaBuCYTxiy9z8rhPwHvMobkRiBU
         SmcvlqbSpvi4Jl+kKrW4H2zQF++qFuTrBIxPV7W4k26k+mAMs2VuaoeS9T0My+wsjMSx
         iybTDP5Zf2dfeIcy32UuYXogJ59fXP7MdxmpQnwqAWogA5dn0ZNX+rT6qaUuwXykcjMS
         wMvlBY7QW7j8oNKDGPHG+7zu46MH+nJRKpDZPrm1Dn5U6QRRotCgZdCDUEssJBAz4ueQ
         cgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750321231; x=1750926031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pki03gT1X1YzuKfpbdeTT2NdVOKEL87eulb7qk78kEs=;
        b=COfLP9exkG/9LJbx1977EZaABeY5+2IZvf+xbrOW9yDtHZGPZPnHYQCXGiQCswSomF
         omNqNoVY4eHDF35vGy0qRq1fNVhHZyv3Ge76/4UkB6ZhhLISyKoK6/T6mnoyYI6OZMuU
         H4GPOegYTBJQMO1mS36xI08lo3w04lZRbKPM6Hsuez3/rZWHZBa0kaihCNBhfUP03EPI
         T5mc8tOkfHG0hzDOsHtC9JdE4iV18RXM8u8GJXHMZPvGWN9deIw7316+j5ABANnrlcIj
         CvxDs9LsB6ruuarAplj+JZDGI2XzgHMp4NnpGlG/OHekHLuEZNk8dlnETGIWp6CpKC69
         iVfw==
X-Forwarded-Encrypted: i=1; AJvYcCWCIWdN4vVwoOYhX/6EQRIzbbzIFBsrjKl+Lxpt5vuECbvlUuuOFh1N74Vw2xNI7wLMXIsP8k3CmhIan3g=@vger.kernel.org, AJvYcCXNmY8Iehrse9nFPWQq/3PFngSD57OmGVN/rSwyBNI91rn1KuvGjfz28cUlkjSCRwGyd7bV/c1GwuSFnnhwveA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdwq/9WlyiAsK7TYtUR/lDrzbeVYetGCN9Btsg4/9jGXlSGX1
	0LPkZvYH8YTjL/tbs6W34KZAOc3Xb8uUmkUSqxMDh0CQbyU6EdB9LlQ5
X-Gm-Gg: ASbGncuVU2RSgwfoxb5etRZ7m9LiGTFopsjuekAmKXORleZGNQ+anfIldNSM4nyuNUA
	yj7Hmv0JSfMWYWLxxvjC2usDzuFzEVM7mfYOr+7b/xNYjDQk6RlgaWAF0aRNrNJozUkUug265tk
	dmr0M8mfvCXNcajg0Z/OEqxGKxzygYD4SMhyzt/k/GnzUhXMezIpaC48FVeFVCvDS7d3FBVF8fI
	VKaQ/NlgFnb8MuYKTTUlmqcZJ+wVh5YVajkg1mN+wmGrL/SPWdPrdmy57X3LBRsuvTNVD7A4PWk
	rlPpQGm5WfOAdO6aS4FlvCYwMP1M9b76tnXJHlU8MDwlVulewTzAYnX7tWtf
X-Google-Smtp-Source: AGHT+IHBETxa/0ep34g4jXorSLAAvGUjs5el+pd3xXbuTb2u9h6HMFdh9M7fitPzbY3gq3z1MXzylQ==
X-Received: by 2002:a05:600c:8b2a:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-4533cb488b5mr206420795e9.17.1750321231352;
        Thu, 19 Jun 2025 01:20:31 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4535e97ac0fsm21574075e9.3.2025.06.19.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 01:20:30 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: ath11k: Make read-only const array svc_id static const
Date: Thu, 19 Jun 2025 09:20:10 +0100
Message-ID: <20250619082010.1834109-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array svc_id on the stack at run time,
instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/ath/ath11k/htc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 23054ab29a5e..4571d01cc33d 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -497,7 +497,7 @@ static u8 ath11k_htc_get_credit_allocation(struct ath11k_htc *htc,
 static int ath11k_htc_setup_target_buffer_assignments(struct ath11k_htc *htc)
 {
 	struct ath11k_htc_svc_tx_credits *serv_entry;
-	u32 svc_id[] = {
+	static const u32 svc_id[] = {
 		ATH11K_HTC_SVC_ID_WMI_CONTROL,
 		ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC1,
 		ATH11K_HTC_SVC_ID_WMI_CONTROL_MAC2,
-- 
2.49.0


