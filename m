Return-Path: <linux-wireless+bounces-27035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66763B450CA
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 10:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2ADA1BC2674
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 08:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736D3002D5;
	Fri,  5 Sep 2025 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mrc+hBEi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F52FF168
	for <linux-wireless@vger.kernel.org>; Fri,  5 Sep 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059342; cv=none; b=sIJ5EYDD0o4ixRxdJCP08fnzwJnsxUWYeBUaiXbrJVrb6o0V0wyD7K/EHeEsLy/vUJuKr6kqblJDDOeXqWSgMLxM/wrU20KJZg+FYYn18bViPGEWHjuauaB/KzMHEPghmJcBAOUTLPVMqkrALDYJ0f+RT50i1pvdk7S9CPidewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059342; c=relaxed/simple;
	bh=tMuqMy9KNqQl8d8FLz0h9ghs2eY5SyYIDshjqoFiulg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hAdznT1oZVhoHcVk0CJJ8jwxZUKwFiNBOh4i1MUPtPKDjy+H1Hi1ObLC0KLWs47mnN4+mewp+S3BoR6GBj7Cg6g++urj5Rdh7yWLEdo4iV89sIdoxwmseqLx32cNab1gaES8AIIKjZaHWNawbyIAMVJqpe//6ypt3BEY4najGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mrc+hBEi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso20762895e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 05 Sep 2025 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757059338; x=1757664138; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o68AReBijMNMDf41J3JdN/+EDwW+zsISsfZcVm5zD3Y=;
        b=Mrc+hBEiG74vKaynjbz8krYMALHTRR60CijT/+LLbnr7QO/XrQ8LiLGjmXMc6PS2hT
         jmMkR6rc2gm5p8S/ZtIVZyFcb8UIT22QO4LK6l1iseybtCGpSc6FCeAAFkS1vP3U3t5n
         NGeaLl7jGqZHapKgTycAGx7m+baDVF5pZSLkjflaZ4JgqSDMOAyeN6A8VbOTbnEKhIKw
         615v5RXlb6yPl3hwtiKSFlDh8/OgTtgmCgZ00Htv591QlQw2Rn5FX7F+wOKtXa4eMmar
         H+l9/4z/YVJPpessGNH2kcuy+uJFZ1dMu8RstX8RxnLZhd22Q4IZLkSmTJyAJIHUfNcg
         6l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059338; x=1757664138;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o68AReBijMNMDf41J3JdN/+EDwW+zsISsfZcVm5zD3Y=;
        b=CgA0RD3hz7OeiME2PFAmFnllQLiTGHP8fMm+6NeqKWAx6b0Xm52BHnv7z4giOa+QMV
         t4e5eYDHaOt7oQXlCWzyeLVAlrChBUlFgtuand9yjGrcH+UurdM9owC7i/Md362bb9Cw
         HumDJ1paYvtlmulvHqviqUUbrwG7h2tOQwtlkoDLFlvEFdA7FsiPV8n+/CjgqrqNfCKo
         81hNXdCo1NJtx/tOygCmbuekBHGeTy5kLFa54ZU6nowOUcjLZmX+NQSxIvbBRhy4PTsd
         /iRqoXX8d2QSR/mvW9ZaXZzZgpqTGPEDRC/tD1jLI3UcrO14SbA1FTG9Z1FRw7iXgO/4
         rRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiMm07tQQeAg4Mc4QC2jnlo1Rk00LodLjxhW8AStQZ/TdPgx9R3kUxlFamh2QVYpzdCPKU5aeiOAtHbSqBYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bQ8R+8NSkfNpE28lUTTQ9Ay4pCfwbfN2GYdtcqcf4Bi6kbgn
	xBEthX0haNa08BjlcMyqRFMbuZkJDvKG4F/UPMWOVRhBYHk4guX7eWa2C5kTmgWHRpw=
X-Gm-Gg: ASbGncuqJSuvWbXLdYslh7vfwdHCJFxKy/YL9+s6SS7K0RQe/zvY4lqohhQAUaEYOEK
	gdsXg6n8yXKwLfkxqRKfQmNlXaQDOxXL+79XoMRO8WVC/3/fpkpqJ5PugQ/9lCZpne6eMvzrQMc
	7CZB3vKSqrqmALise6fv1dyDEixD6ENqwImh2Xbaa+OJAdL2INR5HHTpcR/7e2BTXGZW7Y2GEnr
	H/VBNaam4g0Zae1uLdjAu3HrAFBwvTbRuS8KnbfnWAg+Y6ddJinFzvKGoP6ru6PY6jWtd2VDcvu
	n5hkanB2710reGuwvP4g+FO44i/b7pDHDh9vNrcHQ/4APo1MHXSlKNmRyyqCtjjUTkENZaUI1aO
	PO59bRSt/jTSZOfVW+psn8z3qq3JEnR88VFYqNQ==
X-Google-Smtp-Source: AGHT+IEUmVHJbjR7C3oIB7RSAsoVRqWkfah8MYKFJmKmkTEM7dD+VYHIgQjg9wCazj41X3C/wF8/tA==
X-Received: by 2002:a05:6000:4285:b0:3d4:13c4:af73 with SMTP id ffacd0b85a97d-3e301d1807bmr1931877f8f.12.1757059338196;
        Fri, 05 Sep 2025 01:02:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf34494776sm30331604f8f.61.2025.09.05.01.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:02:17 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:02:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: mwifiex: fix double free in
 mwifiex_send_rgpower_table()
Message-ID: <aLqZBh5_dSHUb4AE@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "hostcmd" is freed using cleanup.h, so calling kfree() will lead to
a double free.  Delete the kfree().

Fixes: 7b6f16a25806 ("wifi: mwifiex: add rgpower table loading support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 6d9e2af29a69..91d5098081e8 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1521,10 +1521,8 @@ int mwifiex_send_rgpower_table(struct mwifiex_private *priv, const u8 *data,
 		return -ENOMEM;
 
 	_data = kmemdup(data, size, GFP_KERNEL);
-	if (!_data) {
-		kfree(hostcmd);
+	if (!_data)
 		return -ENOMEM;
-	}
 
 	pos = _data;
 	ptr = hostcmd->cmd;
-- 
2.47.2


