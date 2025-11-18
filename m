Return-Path: <linux-wireless+bounces-29083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C3C6887E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 672B04F034D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067D73195E5;
	Tue, 18 Nov 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dsrimPLO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982A2D47EA
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457983; cv=none; b=IdvJBacebWwqbt2HyBdzSCcJJAKwKq5LNSJlxXTDgBWEPIV72/le7BU35jl1K3VWl0Q/y5i62mJ0TaFKal+KZGUsHZbnI+62cJYzdnNxK5iWpUOOMiEgN33Xiqm94Cqv9w/RmPx8Z+9eZ/DwQyb7JAmZXDlubK6uWVLCexzSzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457983; c=relaxed/simple;
	bh=tWh6mV/zCGtgGPHhwIuig5moyWGq5DEsSgav+HI79qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJKEtjxE7hZusi6vJnS7Dnfa/EjtzNiTYD8qsnF2HWyW/7hzW1MVwP6sRHLuiQCle0rQ1YzFdX53Lm/JLoM/Lfh1zijwdzsd6eW3Lw8iwNeEbU2NBYzuKEQR/Gz65aKIxZdcYrLEvPcVzO/IIRL05BhPLQPfRGgzq/x19NbSJoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dsrimPLO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5945510fd7aso4439243e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 01:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763457979; x=1764062779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWh6mV/zCGtgGPHhwIuig5moyWGq5DEsSgav+HI79qU=;
        b=dsrimPLOfEsW0ANl+BGW1Qigyi7kljgwFIQqaPWFLQ3h3m63mxFlMvG8pwXfvHEc2g
         vVo1SdFkDqhF68Qj/9pvazDnkV4QjphDyymr+knm5FOyEYIso9Fvya5iD/ypToswmfj4
         axc0UutckPsX4vMAVNEaUlM4nbNfwTxVOTMrqKYKQjW3rpnJWLI0VW26dk3C48MYMtbc
         K0IR55eyztKRkt60mOWNEyKgs63UbAFtU3p93Hwze+B7RjoPGocrbHHu2n88m7finPZN
         SnE5orXxOiXhusQTg18P8xUYSwBzsNNkZwagBlHKdicLPGEHXVuFFWOlFC6PuklD30Pp
         9rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763457979; x=1764062779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tWh6mV/zCGtgGPHhwIuig5moyWGq5DEsSgav+HI79qU=;
        b=xNcGGehMyanCle2LBfS1Wn4MoxpHTkib8GIGcMbKO1QuCnnOOK782wHTWqc9/XP8n6
         rjtTSG5YNaoGI8PvC476JhqWyXKL6iZe69qGKpNvMgkKz6o9EGupCxuWLat+9yo/jm1d
         dXo8Da6P2OYdwjEphBAZRHsp+h6iiiEz+UAd+qBkbi8B60OFWZYATV6Kp/LEvzj1Uagt
         LRXLf7H/qcnNKbJqpd4Yz2o2Q7pZUT2Upsa6mL4AQMUIQVCLZy1DuXf/lfLOvaEsal0k
         MVXNsKUuA3DljHODmSqhcRrbh7d+bmL9yMwb2Ygxj82IjfxItjy7hwCujQQOAWKxDK13
         GgFg==
X-Forwarded-Encrypted: i=1; AJvYcCVXhz0sv1hC7Ht9Wj0UEx1t6I0Hjl1W8Wira9JrkQGXyyW6fKMz8/6HLbhOYO7zUM+4CTc/D9JRszQMUUxthA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytzkBToP6j28cN1bDaEdlV7aFhRsmvnXcP7cpapWxFjEF7e/BA
	hujxm9wv2X6WJ+oDXzGya+v5eTgaItV4UkAkPHOlUsxB1zkiRqwafK1S3wE0NPbj+ePDzyhCGt2
	tGnaoDnfahttBFyN1UAxiGMM9FPfvYWElthXYlYiUwg==
X-Gm-Gg: ASbGnct4ACcKK5tRF5/kxRLPm/Q6gquzt+h1F+oMNGnUvtDsAe3++zGxT7TA8PUwFiM
	XmmMMssiZbSZfoESHBMOv4HdAfTFyK62svW2r/m/4N0N6FAPceW30K7xPnybwzXNLYl1RXzTZJ9
	rBJ5UMfktKxEG04lRGVpdpgboLEIWM7UMtRRNODgcwea3oT+Jb5yEZUm/UKyHcSl/FuMmckLRv+
	td4HZWT3u3zBwq320zB5nxwCHHuGYDCDIVTBKSDSVDob7qGBcUDFlp63enzoYT5eb3QoaNBSQAh
	tmoXg20qfb15H8sMvJsrTN85NRflojCbSTHt/QY=
X-Google-Smtp-Source: AGHT+IHIwDJ325+bKrHoH3wON1VYmUnBcn5j0hjW9UMxvloaO2/lJh6MZKmm+mO9NKNi5epJmOuFYMcd26YKK+j9uvA=
X-Received: by 2002:a05:6512:3d25:b0:594:25c1:7fdb with SMTP id
 2adb3069b0e04-59584224b9emr5284250e87.52.1763457979023; Tue, 18 Nov 2025
 01:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113160605.381777-1-marco.crivellari@suse.com>
 <20251113160605.381777-2-marco.crivellari@suse.com> <e3b57536924b4573ac61de3f24af8a9f@realtek.com>
 <CAAofZF4RK7Dt=eJAXjn0Nbmw4rR_RJ4Nc4P3LkmRDCE_dvK6dQ@mail.gmail.com> <c27c755c188f48e8b2ab60868b0e0173@realtek.com>
In-Reply-To: <c27c755c188f48e8b2ab60868b0e0173@realtek.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 18 Nov 2025 10:26:08 +0100
X-Gm-Features: AWmQ_bm-_lzCHeU0bCiv1y6FBWJqRI26QTx5x0v--akFa_gMY7wg0LN_v_VfkEA
Message-ID: <CAAofZF5qSUS3Uy2D5EuD81NNdqibz37idHDPKeaiiYX7zYCGcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: rtlwifi: add WQ_PERCPU to alloc_workqueue users
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:41=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
> [...]
> Please send v2 with WQ_UNBOUND. Thanks.

Sure, I will do it.

Thanks!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

