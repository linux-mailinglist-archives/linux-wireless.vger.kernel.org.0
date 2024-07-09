Return-Path: <linux-wireless+bounces-10096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BB92AEF3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 06:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC7B1F223E4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEA57333;
	Tue,  9 Jul 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGe4vxD3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C52BD05;
	Tue,  9 Jul 2024 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720498255; cv=none; b=A1L5VXFyNwNktlGU4tmLDLCYkr7aPC9H/PQNCpcWUfZWBAXmEDOolmJkJKqVnAjoCNg01Xk8/rHzM0bR9ISwo8xV6eulplJcAOP+abIYtOujsEHfuTCtQwn6jfnxi6jzMhvY9D9DT5TsitBKjtt74w/Cxm9VFFzoPWOAdRYDtAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720498255; c=relaxed/simple;
	bh=WwBa9BXZQA9Efu51eAIBLmbMfDzQGg9zvOjMoSgyZ7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MES0ELgukqGVRFqRV6STKckSC0dRvl9Vc2oAxsODtvOPS3j9JUj9pxWvDcCck9JE4FUuD0cETu+C9vdrDm1fs1diIo0PkFdV58GkxSpINyiDpgB2E0FKVbkuf7rdD5YsxxiRE8kZ6UzijxlDe9M4QK28bj/+RF9Xd9X08ZPeY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGe4vxD3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-765590154b4so2179427a12.0;
        Mon, 08 Jul 2024 21:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720498253; x=1721103053; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXx0sxLfBp39ss0ZLVw4RKIlabfntiMnDwiiVSgheOA=;
        b=LGe4vxD3l6YzliWUQ9IgiaJO8jWndL+5Zxpwu13UWl+ezOVEdinqQ/B4q1XLAN9T7C
         ufsfM6Esbg/JjGQAPLdMJ+XrtHmxsGBVxEcZ7K97prl03hN14ds6AVwfNX11BMit7kXu
         CA9ALPHOPVBl+NECCMMg+InpoyIlHO/DbcwMawPfCGQgEzV2JyEVFzF7OR9Vcnd4L4ER
         koXB8cBoyS5/4WQzgGiKPdhhvqQsPjukQjnbS7+ULaYrO68tsjEDgijm4dLCaASa45x8
         5FhS+iN3VKU3Dp9nYX57E355318NMoZc7GkirYcv+1RvZTCm0B0i9LSmSgqz4WBtvyta
         cytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720498253; x=1721103053;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXx0sxLfBp39ss0ZLVw4RKIlabfntiMnDwiiVSgheOA=;
        b=nCM9iZpTXmKxa4haCfIhKJlBTIw5fJNY33dMxO5f3cdMotJW05rMERHG2PYnNEI+Co
         VYL1syMzXRqUuRb7uSJdwzjSN/gaLbzq4bIo+LbPbv3wggW9fZuYj+dF4FpbtY/QI0l0
         cfXkxAwNpxKztpHiMHd8PSHrrJczlP64/Z9pay92LXYVG+1uO6uFAO19pS08HYRmYo//
         l/Oq0Sx9IZQKODRUyXtSK1ArSDV3SiycCv8rW3FCnjj5CirrXhyvqlwNR811kb2ZybdR
         QGNV60hQNqNL0vtcaFT36y+s3zmn0LpmmB/ziTRz9+VNfYmId1U+nze4GB17x3Wtn7I9
         Ouxw==
X-Forwarded-Encrypted: i=1; AJvYcCVTaOvmObZ43NNEttQq2j4HZeEAVtuL42O1i6t+mNg8eBVyHDSjQfIrBy+mroukChmDx+KlL+KGeDDwj4K6oABaGox5RJ3TscE=
X-Gm-Message-State: AOJu0Yz1MMJcfvRSSC6b4YBMpavbbzbtXQIOh0WO26xUvsjcOsRuoogv
	CeWSlX2epJVO1cGPJ64vBnqdnesBVVQ/r648pRoqp7TBQ5/+NP7kiBIz+qw0
X-Google-Smtp-Source: AGHT+IEwMXV0jbIqGc+PaZ6TD7061c9KxYMG2X/7h+OrJ9MVmcaDcf1X5ENn1TZN6gt9o0KGTiJXIw==
X-Received: by 2002:a05:6a21:1a7:b0:1c0:f2a5:c8f2 with SMTP id adf61e73a8af0-1c2983ba264mr1490532637.48.1720498253067;
        Mon, 08 Jul 2024 21:10:53 -0700 (PDT)
Received: from terra ([122.171.22.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6abfc56sm6183215ad.196.2024.07.08.21.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 21:10:52 -0700 (PDT)
From: Forty Five <mathewegeorge@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bernie Huang
 <phhuang@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
In-Reply-To: <6673a2dc01a941f5900da7393d160005@realtek.com>
References: <draft-87msmrdgkb.fsf@gmail.com> <87h6czdexm.fsf@gmail.com>
 <6673a2dc01a941f5900da7393d160005@realtek.com>
Date: Tue, 09 Jul 2024 09:40:43 +0530
Message-ID: <87o777tdbw.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Right. Only apply [1] in every bisection step. 

Patch fails on 57f22c8dab6b266ae. Could you send a version that succeeds?

Bisection log so far:

git bisect start
# status: waiting for both good and bad commits
# bad: [5bbd9b249880dba032bffa002dd9cd12cd5af09c] Merge tag 'v6.10-p4' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 5bbd9b249880dba032bffa002dd9cd12cd5af09c
# status: waiting for good commit(s), bad commit known
# good: [bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23] wifi: rtw89: add wait/completion for abort scan
git bisect good bcbefbd032df6bfe925e6afeca82eb9d2cc0cb23
# bad: [480e035fc4c714fb5536e64ab9db04fedc89e910] Merge tag 'drm-next-2024-03-13' of https://gitlab.freedesktop.org/drm/kernel
git bisect bad 480e035fc4c714fb5536e64ab9db04fedc89e910

