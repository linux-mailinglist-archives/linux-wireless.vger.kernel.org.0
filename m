Return-Path: <linux-wireless+bounces-19219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EB3A3E308
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 18:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A106175A24
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4929209F3F;
	Thu, 20 Feb 2025 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhz1TERJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682D2B9AA
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073767; cv=none; b=cdX7Qao6bKU4hsN56A0GRRvoORyJp6z/FB9bzAbel52fxvIIFJG0jQU+FCtoUVfMFWOgBatbTwaCMuWSIJFEKIPUPaEgTlISUwFw9osKhk8slCZgmWgZmhHhIy9iJ2aIUUoDZKSM7pNZH0P/Tv6ulGTGfGu5ebNgIbl7RCgc8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073767; c=relaxed/simple;
	bh=5/4QphJwG1HyrAQsp/zsKYho0nFyBSMSVlVRiCqJHo8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a+TJ7yk38kQmbdcrGz/tncCMgFDGnzpDTfvT96ScmgVmiRFB49IYhyeaJMde0fvt5jX5xaTHRY4XOX9TT4TtjqAV4mcVSvo1q7Znc2oRbMbA5Spd29w5ur6Rohsw3Bd7yuuFhBb4tMEXlBP3WHJUO4XUQvZm9AkCVm0tK7CHwrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhz1TERJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so2094231a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 09:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740073764; x=1740678564; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/4QphJwG1HyrAQsp/zsKYho0nFyBSMSVlVRiCqJHo8=;
        b=Rhz1TERJmCzCdaMDTQQIPmLx0shd2vfXa8WkfdkalIRrAdsM9yC383UEB5hf9QGZQ9
         ZCNAHYNLa4ryVxgCYSMW6HlG3CAW/daKoYa58HBW3X/OnQkcAjS034YgbejiVT3lRuxi
         mTncEgX4XUWjNa6VvAB7+8UTImHTJv0j7BPUdLBj1Te50igvc8wJPZ55N4wclj08yjlX
         GHfSJpH8Y3LRK0WYnYNt0mhygAUUiNnbDUj1ODlZsDO3Cjk0mBrlo+j1vmhHigW7d952
         hQnydb159UsssdumRRV+4siBUWC3jhQRnG2saHloVq/ifqfZ8TfMo9w5B1FeYZUCg8bE
         reKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073764; x=1740678564;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/4QphJwG1HyrAQsp/zsKYho0nFyBSMSVlVRiCqJHo8=;
        b=szOZpmTpA+h3XV5jdvbr4XfqhShUYuIUjzL+RZnUzsZT8j5Ei2eL5ryBHKw7lucBW4
         rsGnzZZnZb8u9ccE4qmZvrnha75N9fK1n1jK4jICQkJHKgM86a0gmXzXANkoIonFCZRH
         I55NX6xR9qYlO6mRsykmgkJZkM3dZtQXYj+2xgMiyKu8IKkclWaucuFzywySwL7Qemyo
         RhmKPE65t0R1fML6dnTEtB5bSMat633IEznBO7l5SHDw7gabcDJzF8GrDVFHg8LT6EZR
         ZnMGllBC5+fEJxMQWdWZllPJ/YQEWrqtWEhCDDcuX8WsXEZ7d2M4yCa2AE/eVU3ZrEJS
         UFBA==
X-Gm-Message-State: AOJu0YwN0Sk/mOEfM8tROc/j8Bj+ud83ofKWNlYdcqdd4qikeuBxQWir
	wksoGan6XT4bbzQ+BBDDna3I6fZPqyY3kDW1EnV47N8zXwZ8sANn/kgUsQ==
X-Gm-Gg: ASbGnctJt38PM8KHZjG0FVSn57nwZ3LBh5DFldoUHMLPHH+muz5K6CgDrPnc6jQZVHO
	lwcCUHjBOPZase+64MJmF6DDFf4D3eHCszNOprMiUCj+/MmMgCcPvPGSpWL6JxkEAInYyDuu2Go
	8EvCAF6o3KgYzQ1lbM6xESxLQrT0yA3gqpWCJkFoduixSxTK9cqnE2lEG96nx9LHnR03DT4BGXF
	TtyfZyu0c8MDWe7suSuKRNJWsVYUbkk31fx+ttTOQb7LvYpukxFQiiYm8zYwEwRKaooK6nah/Ss
	H9gtxbWDuxpv25Ts0KFcL9m0C+dDU1hp2Q==
X-Google-Smtp-Source: AGHT+IHBvLFV9YCRGa4EkjR9DZPJRLUAuUCeB1RKi30qwUhDu+jZCMzCdEeqctOBY/xW+LmI+p9ejQ==
X-Received: by 2002:a17:907:2d14:b0:abb:feb0:547c with SMTP id a640c23a62f3a-abc09e38f64mr24192266b.51.1740073764093;
        Thu, 20 Feb 2025 09:49:24 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322e6sm1493443966b.1.2025.02.20.09.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Feb 2025 18:49:22 +0100
Message-Id: <D7XGO35P2GEL.3PN4A2IX3LGRL@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in
 ath12k_dp_tx()
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250124113331.93476-1-nico.escande@gmail.com>
 <7e120d90-bbe6-47f5-bf72-c1ee681c97a0@oss.qualcomm.com>
 <D7WMZ4TCZKPB.2GBOWXBN8WKF9@gmail.com>
 <80a13b18-01f0-4f52-853f-bc8e3f84e91b@oss.qualcomm.com>
In-Reply-To: <80a13b18-01f0-4f52-853f-bc8e3f84e91b@oss.qualcomm.com>

On Thu Feb 20, 2025 at 4:46 PM CET, Jeff Johnson wrote:
>
> Fixed the subject and description in pending, please check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=3Dp=
ending&id=3De5c718f0c65701ec941ab3121266f33f83ee9803

Perfect, Thanks a lot Jeff

