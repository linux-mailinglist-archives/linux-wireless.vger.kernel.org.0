Return-Path: <linux-wireless+bounces-22107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC9A9E24E
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 11:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529DC7A5499
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 09:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5722D7A4;
	Sun, 27 Apr 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNiC1LwM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75840204090;
	Sun, 27 Apr 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745747874; cv=none; b=lOnHXNTBTRbjEhCp3e2Mic8ov7VfBlQJ7d6J4TM9pEY/Nl6BriCMJDi6S90bt0RiF/fXk0TFZo32yhl4RIBdoxHTpDgn0ZLI7ImWmEkpNwpwMym5fTPPBYUvVz5K+10zr/GOhiU+B146CGxg9vgDNGv4IYVWfRHcJNKwLelk16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745747874; c=relaxed/simple;
	bh=TlpuGJ0bMIigOMRpg0+97w+8+BynbCFp1g2PtIdfSto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JqayrsOdCGJKe/nH++S6uN6hHPu8fzJm1iJXSbnnQ4wrfBtwTwRknX8DCEZ19lDeuIp25CPmTS0HC+h9ivqahzrqhmCXqj/TJNuavA8GATNwPoJJp993PtKY6Q0104zNvGj9P37mUKK0jNDvnUspnnUxGzx3ccTNlC8Nv2mRKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNiC1LwM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so6533519a12.0;
        Sun, 27 Apr 2025 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745747871; x=1746352671; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LxBTUJ+SNYbNqrW5ub0gWFIX7kS/soTqDckkd/+r4lM=;
        b=mNiC1LwMHl3XJJQ3nH9n+B9LMVHCdIANWi+KgW9iryp6NQ8CGRj8lamYD0le/M1kfR
         BMecm9xeUSYmr6farfQ6ISFWhrGWjsh2YPLVaQvYisS5tTRkeXIn6jNvgEgs9l9XjgbI
         sBpk5Fu9Pd81tSvapmpswyW6Wwfhff2boqdWvB8OkjjWTv3MQzXN3WRknZQKpJfb3odj
         cmIfqR2KIvv+rvl1HXv7zJnqBC9Ei26H6j5tf8CEyfsGrSPnVIJ7tvPNSTHdiV3NPNKg
         DBPzwJrhbf0LrXbuDrwa+3YCY7F3Hs4GuQJZ21cNJgEg92QiwUvKVpYOEbdobz4cbyis
         nSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745747871; x=1746352671;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxBTUJ+SNYbNqrW5ub0gWFIX7kS/soTqDckkd/+r4lM=;
        b=qjrLOxI3y040lJERH8XVcPzTXZAvaiNquLGZck3HD2BhvOMnBfW7DbsFWI29BiAy0x
         JiLr4YoCsMuB1YyLqA45W8wRq594Dcf30JGxA9Ab6cHRBO8D46ImoJYc1z6smq4Ha0Ct
         xv72ZOzOqvxGrb6CwmPTevgxgXa7sCOEybvwFfFkjlikvkHx/JvppK3ynt0LDp8pFGMG
         4uKuEy3ifSv49vzQrtlp8OTylvSgh1qpy09dLVSxTw8NVhNwKfINMk+go95sfXbXnoH8
         wOd6bollTy/1xRlEXTnku++F2i5cOnCgixvz22oqp2sqRoU/mtf0uIeBHdwlHveXBhxw
         kQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaBdRz5EX9lFVEWfIdYu64o05MpeEXsRaFUTfn9Wv4lsXD6taZ8ozM8h0JXZH1sC5Yv9C+2beBhVH5SE/x+oo=@vger.kernel.org, AJvYcCXIfgGZh6Q1fBdUpfImaGhEFwX40lQbb/vXrXZ4e1jzoA/L41phTitbA2L5gFW/qflVp03K7umv0Y5xETA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHcL4d+fVNVVC6EmPjdNy031G8EKEISM7Q7/RGNU+YVWLzNR2
	Hdlwh2RC9Va+SUUobeIglOv9y5RAjbt8n/4NF5UgvAzbaaJu4/N4Er6/ZIqJ
X-Gm-Gg: ASbGncvddT3nzyDO+100dEvrG9M28sJUZtoGg9gjvq519686nOF4FIaaWX9WT8dDDeJ
	30PotjjFuYVuv+u/1UD82g6NYvZ1Eg+wMtfGjQ3Xo59fol1bgHnMryjc7ui7pqnT97KCm0diz1y
	SUG6POpfIo/THMbDwcXp42cAfpgaJcg0Tv/zrXB8zlyx9EuXpqT48DxU4X7GsbE6kNb8qCu01gc
	QYFVTv59xphIxpEK30ay+gqAy9AZP7OCknkWB3cODd+hBLoHvGaK/nBf+jcAXWgXF++7jyUMTdm
	G67n8Gw9bc1mRtg0aQm5VxVIXEVwkUAH0KNou54=
X-Google-Smtp-Source: AGHT+IHadKh3mh3Ib3ydj4hk0Zjl9p47LcKrV35HTQdygvQwQhk2pbY9rpDdxgjEnGZDeffUrnIzCQ==
X-Received: by 2002:a05:6402:268c:b0:5f6:23b1:ab43 with SMTP id 4fb4d7f45d1cf-5f7219ade61mr7290431a12.0.1745747870585;
        Sun, 27 Apr 2025 02:57:50 -0700 (PDT)
Received: from pc ([165.51.0.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f70354638bsm3867990a12.63.2025.04.27.02.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 02:57:49 -0700 (PDT)
Date: Sun, 27 Apr 2025 10:57:45 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Srinivasan Raju <srini.raju@purelifi.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] wireless: purelifi: plfxlc: fix memory in
 plfxlc_usb_wreq_asyn()
Message-ID: <aA3_maPlEJzO7wrL@pc>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add usb_free_urb() in the error path to prevent memory leak.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/net/wireless/purelifi/plfxlc/usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 10d2e2124ff8..c2a1234b59db 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -503,8 +503,10 @@ int plfxlc_usb_wreq_async(struct plfxlc_usb *usb, const u8 *buffer,
 			  (void *)buffer, buffer_len, complete_fn, context);
 
 	r = usb_submit_urb(urb, GFP_ATOMIC);
-	if (r)
+	if (r) {
+		usb_free_urb(urb);
 		dev_err(&udev->dev, "Async write submit failed (%d)\n", r);
+	}
 
 	return r;
 }
-- 
2.43.0


