Return-Path: <linux-wireless+bounces-24044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE8BAD6AD3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 10:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5241BC223D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FD2147EA;
	Thu, 12 Jun 2025 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lbnTN3Uv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05E1940A2
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717066; cv=none; b=agcFd11MZhGEt3N8eelXE0jkUBmOGWWs2bJK6sAlOAxfIjS2EwHM5sWoudR9EcyzzxICDZ18BCDV/uOeyrBCrAnZB2OlCz01iZCMC/9W3tyQ8U6QHvksCvTV47Fd9tZEnAtBRWDjzxnvoquM3IVY6obgaXUJRicLVAr0GOS6SoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717066; c=relaxed/simple;
	bh=WAcZZoaVqJVBCCp/zyaxoIzZMJP035kLTOD6rXXjCZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqgVlvgg9qv40PgGl6VcYwtfyr59OiqyXx0eFKZqI1QnvA++HgLYxCEhl4st2ZfAMS/RyAJeR9QdX3Hwak8tXekAJkGOHSwvwqZDsxalUYSjixo4vHo+cLVtxYAXQtM8pbmv7taUpo3UqLwL5aPD+q+88+oGQlwdImP1Ob2hvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lbnTN3Uv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742caef5896so701369b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749717064; x=1750321864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpYtQBVzdFUn1mP60IhVAt0dlEC8nasoUhcUFbuwbTM=;
        b=lbnTN3Uvk9PM1MjBzX3+Q+Ssey5CooiixNsk+Eb5391aed9Tbi3GnPsXakMV7WN2e+
         2cZEMaM6PTtHxyCrPh4yOsZBP8p5FAn63jph77sxn2+dgxKoVumiPg6cjbTaaEj6N43V
         6tdpBaQt0ruA0fcEplkiL1//EQtaH/WYA1jL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717064; x=1750321864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpYtQBVzdFUn1mP60IhVAt0dlEC8nasoUhcUFbuwbTM=;
        b=qDNVbbLu5SR2wUcuvgqfv7ZaihM4HAujBaYyt9FLxMAM3+dZaFJvPGgy0C1/2Wo9uf
         t/LHp6aw0O+itlybsAFc/fZw9CWdxkJChnmKgqLDGpkP0acxcjGshBj+x8BG7JbLh8HY
         4Em2hPzpv81Q9f7JEtStBUyaOBgg7i4SsCT67h0S30VK47yL955NtTQ0IAnTY26ikJXL
         H8jK/ja3itYKkDc5xcnqEmaRSbkBD9B9ERWEgii05di7Ngco6qu0LRB3JxKQBQG17eEo
         6wMBaEgMt5iGc7QluVkfH8CnG3vRYtLzrvmIsj7x0Ec9AAxKHTBVNAepQ4CxLVs6pPfw
         kbHg==
X-Forwarded-Encrypted: i=1; AJvYcCUvwyD96MOBedjTK6Ve7HQVlmrFlTffzBvrraVgrkzjhuYrKrbV8KhEZkcscBv+JtjIzcthocYXjQhZAMRekg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6P46AzGJfDBNYvHrDXYi980mXiFJ1m4eLj+eyYk3piS5T4M4/
	ZkR1uHLCS6eGEoaftQIvMVnibFSOgAFLf7zF1XJ+wFlRS+5PuYgNoGRkEB2uEQN2IA==
X-Gm-Gg: ASbGncsV2cfsuh9+Fx+dUwysrJa2lSfTzpA6u/w6y9wULvjYLZOMEzHbp+fE+U/BR3F
	OMxJ3/Lb1AhGGjk4vDajQFlA5GD1gUXYYArgJl1ZhMRb3uSRuYkSsDl97+DjPk9a9I3Tzk6Z4Yf
	JZ1hI5svPXOoY+i1edSg3g3aRj4fmYL3cHyxY82ZxSAqVwGnhYTGCwgt2RJJzOaSoZiMOMuLiPz
	SBaW5MOtX6/w0dtKl+Hn33KpajDWEONELMSGUnbfqbe9g0FSyorONtRrzNxjmmmkoweSErD1Riq
	as+0hkePTZATMqkmyxnA4Xu3qYXfEm8osYzTPAqHmXVT+L26x2GYKuDhAU/be2ja
X-Google-Smtp-Source: AGHT+IFBDWKNu3QDY5x77Ut+39tjoSMCPpg9YSXyyw7wdPIMWMB03qAOxrhzC+O4LvEzlruhxyx/fg==
X-Received: by 2002:aa7:8882:0:b0:73d:ff02:8d83 with SMTP id d2e1a72fcca58-7486cb21c08mr10126036b3a.3.1749717064126;
        Thu, 12 Jun 2025 01:31:04 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fcb5:79e0:99d6:8d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488087aa41sm893458b3a.31.2025.06.12.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:31:03 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:31:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] wifi: ath11k: mark reset srng lists as uninitialized
Message-ID: <kuawjsglndjvwmq2ki2kctvgcdci6mhfp7juux7tzo3g6h5txh@hddxo4o5raea>
References: <20250529035708.3136232-1-senozhatsky@chromium.org>
 <5857380e-ced9-4118-b9a0-ce926b25c11c@quicinc.com>
 <rxaibpgtf37w3th5lnt3w574w443yononqjoglyfktlcxe26qg@jpmtkckrotzp>
 <2f77045c-6763-4fc4-bf09-50fd9b76a394@quicinc.com>
 <xr3n5pbohquhaloonctfqvpb2r3eu6fi5jly7ms4pgcotqmqzh@msrgbaawafsj>
 <ce3c0e51-4df0-4164-adcd-e98f2edee454@quicinc.com>
 <qqhs2mzhg6mgq23wej5a65iau4ysfjh2raakcsvwc4fuqtpwk2@4ouqfld6mrnd>
 <d48a228a-5f48-4732-b12d-78f03541ae9e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d48a228a-5f48-4732-b12d-78f03541ae9e@quicinc.com>

On (25/06/12 16:14), Baochen Qiang wrote:
> > <4>[23562.576034] ath11k_qmi_driver_event_work+0xbd/0x1050 [ath11k (HASH:6cea 4)]
> > <4>[23562.576058] worker_thread+0x389/0x930
> > <4>[23562.576065] kthread+0x149/0x170
> > <4>[23562.576074] ? start_flush_work+0x130/0x130
> > <4>[23562.576078] ? kthread_associate_blkcg+0xb0/0xb0
> > <4>[23562.576084] ret_from_fork+0x3b/0x50
> > <4>[23562.576090] ? kthread_associate_blkcg+0xb0/0xb0
> > <4>[23562.576096] ret_from_fork_asm+0x11/0x20
> > 
> > 
> > There are clearly two ath11k_hal_dump_srng_stats() calls, the first
> > one happens before crash recovery, the second happens right after
> > and presumably causes UAF, because ->initialized flag is not cleared.
> 
> So with above we can confirm our guess.
> 
> Could you refine your commit message with these details such that readers have a clear
> understanding of this issue?

Sure, I can do that.   I didn't want to throw my guesses into the commit
message, stale ->initialized flag looked like a good enough justification
for the patch.  But I can send out v3 with a more detailed commit message.

