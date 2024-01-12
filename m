Return-Path: <linux-wireless+bounces-1782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D8D82BA7E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 05:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3820287389
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 04:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516425B5AA;
	Fri, 12 Jan 2024 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0HA6ObK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7A1DDFC
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 04:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cf1f4f6c3dso1558844a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 20:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705035070; x=1705639870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZHYroGJ9+ExbnZuLkNuQfAETN3OM1LpWN4UahgxLu4=;
        b=N0HA6ObKeOmefzPrpys91+5GPFRpywO2vBSZup9IGkTcFt9Kn6PBY9m64BYgmXHdFn
         bfEtX3Oepuyka4tF2NLdJRrK6/qQvU4KvYq+pqMZx2IugcaVNz8VykNpvZ0ETe2gHLTt
         o4ARbjW0Q7oO0z7E/lMGorJVJk6rPj2OeszR4BolsroSloWj+ioQGeUBJar4PRQ975vO
         TOS9zUU3XtFnmzUc9+XwNegmd85C9eq9rxNGJIGEFSVrwC4Qci1EKs0cf63U6Eo0H5Dh
         Mem18F4glEvCrRnnCPGMHj5munpikUduIGDV9iu6zmCqlunfdUNa1m68fmo0n0BiQhLE
         JGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705035070; x=1705639870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZHYroGJ9+ExbnZuLkNuQfAETN3OM1LpWN4UahgxLu4=;
        b=V5DuRqRc8fJr+1J+ngDr8MiSfxhy9zdXrnz3dLik7bxhJ0Il/Dtpcx2kegVxcUhq1R
         1Xf2d3s7BeD9RTiGEsFcNI2Oc1d+0beeMdnjsIQ72fQga9FES2VxbH8dlimRiq20QOJZ
         Vh5t2ylnWKdbpTOzW/br3vzfA4tIUhryb1mxad02cpv11vx3FTJLFXfHTIFx4Q08pC4n
         khmH6rN4zzrLWkWPA7AZ48AjHP9086KyEQZ3oXB3ZTZTfyfAD8OVPFHTVgJasqKgAOV1
         iatjERpfj3ZDj1vU3xvKxcxD53BhR5KiTuJfuG0y/JsVRc7VFinogJp/a5vN7Clm47zy
         mgoA==
X-Gm-Message-State: AOJu0Yw1hJtTyHt5p+NmGQ7VsRnXYsiazoKY608ZKejD+lEYfvfcoQ2w
	MdB+IkQdNy8OeJOss4wOQF4=
X-Google-Smtp-Source: AGHT+IHGaHsN4HPFhYyd3PFgs+4dojJiu7fbB/XH7IFmtYVz9gGRHccF1u+gC5cXyeLVsU6s37XALA==
X-Received: by 2002:a05:6a21:32a3:b0:19a:511c:935b with SMTP id yt35-20020a056a2132a300b0019a511c935bmr318652pzb.118.1705035070071;
        Thu, 11 Jan 2024 20:51:10 -0800 (PST)
Received: from localhost.localdomain ([1.200.131.192])
        by smtp.googlemail.com with ESMTPSA id a6-20020a170902ee8600b001d04d730687sm2069751pld.103.2024.01.11.20.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 20:51:09 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: pkshih@realtek.com
Cc: martin.kaistra@linutronix.de,
	Jes.Sorensen@gmail.com,
	bigeasy@linutronix.de,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	rtl8821cerfe2@gmail.com
Subject: [PATCH v3 21/21] wifi: rtl8xxxu: declare concurrent mode support for 8188f
Date: Fri, 12 Jan 2024 12:51:04 +0800
Message-ID: <20240112045104.12282-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222101442.626837-22-martin.kaistra@linutronix.de>
References: <20231222101442.626837-22-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ping-Ke,

> Locally trying to disconnect after 30 seconds. Can you try non-secure
> connection and specify static IP to see if it can work? 

I tried using a non-secure connection and keeping the DHCP enabled and it 
can work.

> 
> I reviewed the patchset again, no obvious change if you are using a vif with
> station mode only. The only one I'm not very sure is a commit related to
> security CAM:
>     Fixes: b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP mode")

I tried applying all the patches except this one, it works as usual now. I
think we find the one which caused this issue, thank you very much! :)

> 
> Since each patch can be seen as individual one, could you help to bisect
> the cause? 
> 
> Ping-Ke

