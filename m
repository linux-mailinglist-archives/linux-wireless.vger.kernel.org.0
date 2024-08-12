Return-Path: <linux-wireless+bounces-11302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F9594EBC0
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 13:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91149280C4B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65416D9BE;
	Mon, 12 Aug 2024 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=up.edu.ph header.i=@up.edu.ph header.b="LIbG20E7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16616130495
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461929; cv=none; b=MxpfYA2fnloW0kn1i/H5HZjrI/9MIcweWPaYpW58dJoiYVgZlbOZTiBqBuBIg02oQSG4tMsT/OyE1lAYh48+QtneVo5MujI2ptTlzXTM841SMAEsk/MYPbXh3cew2JrG98E4YS6aRRObGkjMB1UFYR44p4qjD7RHDfbFd1z7QlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461929; c=relaxed/simple;
	bh=RbwMlkchHA0z0t8maefqSpdlphNEJ7DMeVyk4xgd3m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=XMAbq4CyKcUBiRx3evS0Ue8dHQ1CCgtIG52zYuFc7yGmNSD1BxHt2uuvTHiDhcWeDzra/wfJ1M6A8HM0WmlyCRbPvRSI8LrNQffGK6nyDVkxpd3/FFbVpCRn/d96LN5FduGXzbX/5kU+QoBdkqlf69Id2KY/HUCuBFjZD0hCbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=up.edu.ph; spf=pass smtp.mailfrom=up.edu.ph; dkim=pass (2048-bit key) header.d=up.edu.ph header.i=@up.edu.ph header.b=LIbG20E7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=up.edu.ph
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=up.edu.ph
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so5446290a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=up.edu.ph; s=up.edu.ph; t=1723461926; x=1724066726; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbwMlkchHA0z0t8maefqSpdlphNEJ7DMeVyk4xgd3m8=;
        b=LIbG20E7eqSk2FRqtBluLVJazYukc9QjDcmYfeKORLXr+Yoj3PZrWZVuD6cA/3sLiN
         H2xcHVdnns9Rme5Z4Byu5T9gkX13zStSLRPJ3lGw3YkALkMUg6aYZ6eleZlXcOMQJM9r
         DbdcgsxWNc8NVQW2OrlZ79XXjA6melxB/Y6m9BmfWTQXA9oG+PrJhEGaVRIN4JnNnDxU
         zRo9GZDzpRHgMlmBZYFl4F9gVm1uMAOtl+e0WuOf73iZspP324YaDhajmFF921bi+yWL
         sOh4+3sF92jLcFCTuxKoaykHYal+9ep3au2fD36TzrxqImV86SkOmE2DblX/PdYYYX7w
         40vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723461926; x=1724066726;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbwMlkchHA0z0t8maefqSpdlphNEJ7DMeVyk4xgd3m8=;
        b=glzYByG6LzN9vXywgIiHtxw0lgqW1TFxxqLE+hQZnpdr7D4DCPR0cjVEqJg7J9mScp
         yfWhhpgE3XwE583ZDgZWCjM5vfsZHihg/A7Mkg3/KdBu72308TSoDpTLlpKby8TB1CzU
         HoBYMpTbH6pNf8zisKLReUAE7eJz5IkYODv/8YKwhz9NmQGQ5gOT1H041XFBB3mgufvP
         g0kgzRmlTsRfWPA0VyA0mFZJG9nvqudmerpkbBr/V4Jd6LESKEpJpGZCc5FuYdT1wuXa
         bygXiJDa0VfUi8dz1/uTph0XCnT2N0HUvhj2ezgbrmctO32NOsvb5WqPBjDgEIthBnpc
         KFpA==
X-Gm-Message-State: AOJu0Yy+tB67Ypdf4HvVt1R8UMH+z98XcMjTSa+AAPzLLkTIjVbgQd4n
	3yhhOdqDVRXXpRhBkSDU9b2O//0Mln79Yx89oEKEzHJDA52JhVShi2e0s8dGwQRtH/KswpUy89p
	NNBKY/pVKPPo8uZ0tCQp2HWxrRow3Sx5FxNj7ddTupyL+2fszpwA=
X-Received: by 2002:a17:907:e6db:b0:a7d:3cf6:48d1 with SMTP id
 a640c23a62f3a-a80aa5dd57dmt589856966b.32.1723461926198; Mon, 12 Aug 2024
 04:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806061203.1839-3-gcperfinian@up.edu.ph> <CAGb2v67fQiYAq7C-eT98L-tx4DoS5AN0UyfaB+hFkpOQy4Z3vQ@mail.gmail.com>
In-Reply-To: <CAGb2v67fQiYAq7C-eT98L-tx4DoS5AN0UyfaB+hFkpOQy4Z3vQ@mail.gmail.com>
From: Gacel Perfinian <gcperfinian@up.edu.ph>
Date: Mon, 12 Aug 2024 19:25:14 +0800
Message-ID: <CAJ5pLOZ0mBWjZ2zSwwsBj1TsLXc+R__1bGsUgNUpZ8an9K8WEw@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Philippines
 (PH) on 6GHz
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> Could you use the value and unit directly given in the referenced
> document? So 250 mW.
>
> The database takes both. You don't need to convert the other ones.

Can you clarify if this is just for the new entry or for all of them?
The documents has always stated the requirements in mW eirp but the
old entries were in dBm so I thought there was a reason why these are
listed in dBm.

Gacel Perfinian

