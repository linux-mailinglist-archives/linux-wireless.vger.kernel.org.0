Return-Path: <linux-wireless+bounces-9867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9B0924288
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 17:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CA91C20EBB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD191BC06B;
	Tue,  2 Jul 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIZKNsZ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CB16C69A
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934632; cv=none; b=MseIXn12fIgT44g7v7slziF/Rfo2bnup+z68tkahqotMU+QoTpO45SPOaBxXLoYEQoYwIyhteuG6NDOZc+G4o6UpWpqN2aIIBu5ZK0DxBJnHFr25qwjsCGvYSEqbhFzWb9TI8D5HRRh4eGe7HsStQza/jNOBchZ9S0W8UNxZZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934632; c=relaxed/simple;
	bh=dQc3tYew1AZurSoAlwOVz1tVJUNzfbYnzsDwt5Len+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMNQzaIJrU5h+zudWTldaU18Ehs08Sb874pD+w7Yubka/eGYltugGXshfL+T5ENCMrfhGRnje6o40HTBDw6g8t5HffZadjCJoUkDSrueDtRs8A5qNZd2InUcxH4g+Ef/Z7AaONXARhuokIZsHrh231ZQNt2Dyve4QwQQvPISeXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VIZKNsZ1; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-701f397e8ffso2437302a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719934630; x=1720539430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVSAscJsJjawbJOjNIIGYe0PRN71Kp02pqdgWCt4bXw=;
        b=VIZKNsZ1xsjPK4VukAe3sigPaTkLFT5C268zv6lIQJFXS4SDdv0V37FCrbrG7kA51p
         jc0EH5gkwdSR5uE/6TVAHUHDohDFJxxXS0yV5EvfW9vZMdt2mwtPXql8ZVLcgg1FcHtX
         x3eXpWOtGtiwcBsJcgENohfeSp8oDyXP4U34NRsu2XjUcLGnnm11FpK3fv5Qusb6tTTb
         yB8ZHQ156gJfjyC99o3MiNOkeqaNzSoTzdjj7nL4YQ+w4GL5jW0l0FbXomU4LJY1UfSj
         diZDpypyp/7LD5KJxewv9NphxT/xGLcNpRdmt2j0Fsn00KePBblAxvUDmZDnt0BxJopX
         XGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934630; x=1720539430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVSAscJsJjawbJOjNIIGYe0PRN71Kp02pqdgWCt4bXw=;
        b=QFOTIMEs9Hs0FESU24VwdHphoIcFGMAPo+RO9Q6esMO9gqBmZhJqB3wMd5IUdK3/xN
         zLcEoM1FdDvFX3H57S/ozWTCxEColZgkCMAgkXpi4HzzffGF8fN+qaaVDBspeMz2A4L3
         XfdqKsCaHe/7s9IbEh8UO5/58u2DHRUlEKByqWJQxKRkTy3gmNDyQbOf8i0WCjTHQUmb
         /zP5cuPWxsYfURuO+iUE0fyrIYRs4B5cGnDFWRYyrsDivLHWoRAZ9yYTvSQQjiVuNLMY
         EFwn8rFShqFJS+5mcNuGNITyz7yds4GCobz10UYIBDA5kK7XdAHbMRcqeP3nBX3JFZ5e
         O3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUJjixNXLZMygrTF/5Nn6gv/TnQQb1Jz2mLsGb65a/xL4htdcuVTfk5Acdg23G5WYJ5HlL8wrpBGlj1WzD915pcz30WOQUMLoCE3NrP4Ws=
X-Gm-Message-State: AOJu0YxgQVixHHNl8jPkZcluN+pSWPjsITPmXcViwSvSND3VLYuEfb/f
	b9BzbJJZcETrnzIlsV1gywON999SG+w2eP6slR5PKTt4P4PTaDEa/cQwlTnKgzU=
X-Google-Smtp-Source: AGHT+IFMIUm5t6dN9PzC0I8I0TadK3ts/fipkldg0xShDih4b+I3MtsFtps46SCU+i0L3AuqZ01sAA==
X-Received: by 2002:a05:6870:4413:b0:254:ccac:133e with SMTP id 586e51a60fabf-25db36c36f9mr7911251fac.56.1719934630414;
        Tue, 02 Jul 2024 08:37:10 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:a6f1:b7be:4c8c:bf62])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25dff4c6b11sm152928fac.5.2024.07.02.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:37:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 17:37:07 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Su Hui <suhui@nfschina.com>, johannes.berg@intel.com,
	kees@kernel.org, a@bayrepo.ru, marcan@marcan.st,
	quic_alokad@quicinc.com, zyytlz.wz@163.com,
	petr.tesarik.ext@huawei.com, duoming@zju.edu.cn,
	colin.i.king@gmail.com, frankyl@broadcom.com, meuleman@broadcom.com,
	phaber@broadcom.com, linville@tuxdriver.com,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH wireless 1/9]  wifi: cfg80211: avoid garbage value of
 'io_type' in  brcmf_cfg80211_attach()
Message-ID: <3071fd19-5cc7-440a-8184-3aeeb81c96e0@suswa.mountain>
References: <20240702122450.2213833-1-suhui@nfschina.com>
 <20240702122450.2213833-2-suhui@nfschina.com>
 <ba67020a-04bb-46b8-bc05-751684f71e8a@suswa.mountain>
 <19073fcc9e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <878qyjg6cv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qyjg6cv.fsf@kernel.org>

On Tue, Jul 02, 2024 at 06:29:20PM +0300, Kalle Valo wrote:
> Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
> 
> > On July 2, 2024 3:57:27 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> >> On Tue, Jul 02, 2024 at 08:24:44PM +0800, Su Hui wrote:
> >>> brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes it to
> >>> brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage value.
> >>
> >> Since you're going to be resending anyway, please delete the space char
> >> from the start of the line.
> >>
> >> It's weird that brcmf_fil_cmd_data_get() uses the uninitialized data.
> >> It looks like it just goes to great lengths to preserve the original
> >> data in io_type...  So it likely is harmless enough but still a strange
> >> and complicated way write a no-op.
> >
> > Not sure if it helps, but I tried to explain the reason in response to
> > patch 0 (cover letter).
> 
> Would it make more sense to have just one patch? It's the same issue
> anyway.

The Fixes tags are different though.  I'd probably leave them as
separate patches just because of that.

regards,
dan carpenter


