Return-Path: <linux-wireless+bounces-24742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5AFAF0289
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 20:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535504E4A73
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3327FB0E;
	Tue,  1 Jul 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbsa18Jm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD127A47F
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393327; cv=none; b=StfwtjKXUiVzvk7leRcpKUW7o0iKj66ebmMVYLXOzsGwZHmNxwCA5vt4hJhqri7OsjvU4wV7VghuxWVOMI0KcDjZcOGFGDh8vMguoWGWU5eF3GKxedfNX8ogKBsusEB7jstashMSWVuKv0szpC4zETCNJNAxQqKxMbO2Ydqb3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393327; c=relaxed/simple;
	bh=sqEYp+GJsr3c1ZoP5ucjimUiASFNFvNEkUK9S5l3ld8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S89uVHxbArHqZHz8c7sAlkT0J0xT7jUdc1fEXXcOu4LShPjbOwIat2ue2yQe8CVttcGUTpkl6dWY9VrG0n4MnakXk3HdxwcwnQeiauDtbwqPFxXd2pZ3o75jtk8RMzxbR9EE8cgoW8lxrDQmP6hBFJkvO24foLFyw5bS0UU0SPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rbsa18Jm; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so3407633fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751393324; x=1751998124; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmBWeUFsja8XgEI6sHaSHNOJGBLbPXCjjSjO2QYqYio=;
        b=rbsa18JmMLVAQH6I2hhItZdAB37hiGg5WFfzohoehpDmRcH7khRaTH9SvhvDLv4d4x
         FULA7sfNFgykjR410b14rBRTs5Rn8Oqf1uhpBmT+z/JbSxxqERgnOYbdZboln/sDR7vw
         geoLwW8qyJqsbtww8t0xSyqFQw2FPboKiEx/wm0soH1xFTsqroAgp4gtRxtUoQzzIb8L
         Sry/FxEY86oUUyC+C5+RUD4Wu+c43s3jsD7XDyNbss0FtfdFPv9K5d6HAtIUSt1NJFUg
         X1v1uHXa3gP2z/IdR3P+jMwAh557n9zFyX0aPa3urOhSy2WY4sMh5z12edg15Vb9pfWq
         MjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751393324; x=1751998124;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmBWeUFsja8XgEI6sHaSHNOJGBLbPXCjjSjO2QYqYio=;
        b=K29AE0wduHoJvbDG9bGW6os5DX6kdNGoiBtS0PsHKOUsF8HQESWbVVbJBmvGA1ZSyb
         P430Szq041tviDIKERJPROWzKjeo7TyPOd4bGhyTR50Tjb3uYSifLS3hVXNubgTw4Jmf
         uLdIWZPrs7/dBkafF0bZ+il8rxSQNQQiQ8AduHezcFerMqzrvhR1bcvCvwppvSswrCLN
         TAg3JL0Rcq09dP0/A291VnuNrtCkrQKmAd0Gyec2TGplnbLoXc2oRlozOnrJjxfqGOLf
         E1KXE9bi73LlmalKvi7NwVB9cpXgCmM8RP41likwWQMPToVScHOns4VYh8hNXlsSokIw
         TcCg==
X-Forwarded-Encrypted: i=1; AJvYcCVGticRW15ypMraZIThREbsF1kYU6WXh4LyEZXIMyQoB/fw2nC3Tqw22e1bRMtp0jqgDs4Vp2eDsWja9ShA/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDRZC5j2d0j4k/tnvgM94//qmB5sLurMSUTTicdR2GTj+hwsN
	QFQMj/FSiJwZkYXsEdsRGEmQFQwwMkyKaVDEaCfFPuL5sX7LabdNn9bfcnNps9GtM34=
X-Gm-Gg: ASbGnct8o98HdHgJ+jOo7nCaKqj9CKR+c3GcHwKPFmL910q6MhG0lB0okqSxYJjnR8d
	UJPtGoX/fMYb/QknQ3/UVaaGz6FdmdjBmvu3Uq0vp6OCOpzzGi45OITvKiIaXzFzKLY8NGh8SaX
	yDFCyxWgk64r+Ahu6WBgCbUKOuGsbtNVRhy64Xou3mVPB2j1E5Bxi7MLcxUxPT5xApP8roPREwM
	eo/H/zj1BW6AFWExgtH+KWNCePodu7BMdi6s+8uqszJ4JA6ZDWpQE0JIL5rb6msKFonfNDxgSVV
	4LHI1CbrNve2U862OpmOgqZc97YChJDkJOrDJYtneqk/9Nq3IeH8x9J46Qykakp5ue6ihg==
X-Google-Smtp-Source: AGHT+IFUgAn7ZgG0vftEAU4ScpIylq4sfDSaoAFlTtYAYDN+URoGNI2riucbgBsxkY19iHfA6fkTRw==
X-Received: by 2002:a05:6870:479c:b0:2ef:3e4f:de9d with SMTP id 586e51a60fabf-2efed525468mr12436176fac.17.1751393324568;
        Tue, 01 Jul 2025 11:08:44 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d663:8de8:cafb:14e3])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2efd512d709sm3388146fac.43.2025.07.01.11.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:08:43 -0700 (PDT)
Date: Tue, 1 Jul 2025 13:08:42 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: iwlwifi: Fix error code in iwl_op_mode_dvm_start()
Message-ID: <a7a1cd2c-ce01-461a-9afd-dbe535f8df01@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Preserve the error code if iwl_setup_deferred_work() fails.  The current
code returns ERR_PTR(0) (which is NULL) on this path.  I believe the
missing error code potentially leads to a use after free involving
debugfs.

Fixes: 90a0d9f33996 ("iwlwifi: Add missing check for alloc_ordered_workqueue")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index e015b83bb6e9..2b4dbebc71c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1467,7 +1467,8 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	/********************
 	 * 6. Setup services
 	 ********************/
-	if (iwl_setup_deferred_work(priv))
+	err = iwl_setup_deferred_work(priv);
+	if (err)
 		goto out_uninit_drv;
 
 	iwl_setup_rx_handlers(priv);
-- 
2.47.2


