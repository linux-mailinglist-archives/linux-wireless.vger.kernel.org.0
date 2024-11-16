Return-Path: <linux-wireless+bounces-15418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A209CFFAB
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 16:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C0F1F228BC
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C031885A5;
	Sat, 16 Nov 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm+AhIpA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148016F84F
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771662; cv=none; b=Rh8LczwXw4cZqQQiUNF0nfrZtrLA8D73/v1h5SKkd8VqyC/Tg2rIE53awY6wP/SqmuBUyysB9juYPZZh4K6De/nwdMB5/OA5m8h+BGVE+4qQwQPIykSkYTo4v60VGTM+B0AT91yISInsXHzQk0dQQJgmbS6BXEoiQUYhI8b9dJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771662; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=btISwzSQC985bsgWTqMQky2XQ0ibOEp7BBIsJMxIHi+3CDRihrEjFVwg74mNWa1penSrwGNt0SyjjJrhnOm2ic3O4mO4TJRJ1NIBLl5q0DPOnd4GwrxV9tVjcV/+nOl21PIlj7L3ccZKtIFXPG98uRcRH23uh2NJOaIXE5C3NU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm+AhIpA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e625b00bcso1456720b3a.3
        for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 07:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771660; x=1732376460; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=Lm+AhIpAiiujaNcO+1IL+1gpKBOAhJG/1CQk1Yw5Kl58ZmI37mUPF/QoEyK5v+nEOw
         SOOWCN0FM2ZqJzKfY4gZuDKG1782YCO7am4zPbkpioOKlkovnExpPxYcAEid2qPbEQ6z
         aD0UC+mh35tS0hC1v7Z4nynmPHqu2g+yUUcAwFxrbtoZujXYEwY1l2b8sRbgZPVFpA9d
         pyJajbY6v5ZATb8nujeaPXxE1p3AHJxYUbZnSu+iUf1iZe1LBZJ2pvCUt/0A90RL/dNi
         puGyo/3EcNUXTFo8oqNzL2Ih8w82swJAxZFXTDb1+8OWPE1+lJm5oECCnUYDdTRL7kTK
         qTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771660; x=1732376460;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=IdrsB+3S1gNmtEdY7jK+1FKi34DlJFjgGbIvF9CEZqYLxUbessB4F4/rBVaFIYeACu
         FW58Frd0LLhJd8Z1/Ln1E/Nq+A9hSqYcdSyPu28ChrNc554O42tguihxHkyCiMF3x5Rx
         Kw2S3jg5vkIwCUEu6OMdMBG1G1Rn3H/pAvR5uuYGw86UNZo4oXFH2D/eCzoYLtUOQNe5
         Gq507ya4OBaT5hq8rvBvd0nGkvJahrypWLd5U+KTwfq9Sb9PUNJJYPf2v/GgWO8KccJZ
         7c7tkJ9Bx6s8Boz2rkAbBjPGiJAe1fEV090SeUb14Z9K4IFqigBkXH5qknpctDDFplTS
         +Bxg==
X-Gm-Message-State: AOJu0YxtSNEn+D19kcjq3P6/U6nY9ijr4HpFOO2wLHLnVebtfoxHAxT6
	7KYEq1YP+jy3nhcpvl+9+nQ/uGfYEG+vvuwTqJr+21uAlGwn8yqzGg/d3A==
X-Google-Smtp-Source: AGHT+IHRNTFFYEQljto9KGXUFXISxdKkEQzNq/2w4NxLsf/NXxzIM1A3aOsqqkbk3ELnWbCnuj1Dmw==
X-Received: by 2002:a05:6a00:98d:b0:71e:4414:eb21 with SMTP id d2e1a72fcca58-72476cc96f4mr8287839b3a.17.1731771659889;
        Sat, 16 Nov 2024 07:40:59 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee999sm3215624b3a.3.2024.11.16.07.40.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:59 -0800 (PST)
From: "Van. HR" <carlonowell008@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <efe25f9f6962056f1dae439ee02f63bc6a0d8367213708336646e20567d70d61@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-wireless@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:56 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


