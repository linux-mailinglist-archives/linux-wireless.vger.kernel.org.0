Return-Path: <linux-wireless+bounces-18124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B367FA219C8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0838D188834B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575619DFB4;
	Wed, 29 Jan 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDpA+mDG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE2C19D886
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738142317; cv=none; b=p7UAf7sk7gVmdPb5Klig7XdlJBAwNiV1bTivZT0ge21Tj8zLvXDld73xRngjBAa6CqDJQ4uuY0nAmMNCyWCP4+b9v8a2ozW310iPLQS15yUBv2E/yxxCV7uTYVZI2QafAoAIGs4uMwbL+Xypq+NkpddThkI0j2axdxrdOR0IN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738142317; c=relaxed/simple;
	bh=exsChHtW69nKPxO2SwyiGN3eD6hQvwSXjAHeNS9bLyI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mchHhaDvR1+BuDptmagAgC1gp9Daqbj+/KLiUt4PbFHXb0v9OMxGzvyJoF0uYfxB+nmwPEja2HuNcqo7oPF9fUfV5Y5g/iCAQ8pmdUfo/bT8evTkb+ai9JwRB4BqwSMUJ8KmEn7k3I7wbYrLXuoktbzSIz+jDyCy6rsCF6SQsuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDpA+mDG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436341f575fso72895385e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 01:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738142314; x=1738747114; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exsChHtW69nKPxO2SwyiGN3eD6hQvwSXjAHeNS9bLyI=;
        b=YDpA+mDGW2/1q5F/Wg9PudBxTftF330g3SGK8GcobuW5yfAU9NexxGCR0p7XoRqF/X
         hXLoAw2mvd4YFeNlNjGfrFeaEE7QlHG07/M35TrYCV7HTMTNiH7AvTg+WJ+mpES80EZF
         MPBYS+PY7IhdmlFoEfuSFyKqzKAkSCKc69TgPGwBrs9oYeY9Uj7lvnLGpGt+J0QVq9z5
         eYbbK1zbsI7wU6vAOzQ1DJYFSnIWDFd76fMircQHk/RmIeg4mNIidhKzwT8+bEjYCUez
         WicMWwcOouVm+V0P0A7q1zZpsN+cBa/19CY7Ys8HjPzBInHsn8rj29gqrnjWW2loqfAw
         DXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738142314; x=1738747114;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=exsChHtW69nKPxO2SwyiGN3eD6hQvwSXjAHeNS9bLyI=;
        b=tVAt0J1D9xanNJm96U9sWJi7OrOdZB2QkA8Ikt4u1u/FZkDqbtObwfw9QEXJYLzwO2
         qIVZfcu9NXAnkGisPY9sKn+P6F54818Qwr9hqLtgeu5RHN/LtjP73W2XkLLXVacgeAq5
         s0kToTtXTBpi6E93oLKFOH7BfqfFRUeyi7YiGPHAacJriXzOvGEltzmKAebjEaMwFdfZ
         6JHViYq6nwjHcEqu2oId2yccbTqfit1PBnz7F0loC7ndMnGH0+xnlJt/pZj4mYxlFOKS
         kRrXU1K8yTMD5sPa77fXXp4onWbSBqV5UAptKLUsAQmJue/dl286zj8wB02uuHvVOuG+
         gYvw==
X-Gm-Message-State: AOJu0Yw64kBouhEzk+oITpZ8zxOSTkVZi2D4umN4n8DOh8C8B/MH8uLn
	4VGm+bioWPtyQXP/j6b0jBUzz6/rug+JHDpvjng5fj87BxofPOeI
X-Gm-Gg: ASbGncvNK5ch4Ho/2CXJYo095EtmCY3PpUvv1+/Gi0ZULqUcjICWnM2W6kU4EoxeTFH
	TYlwaue/fasc5XtWBU82oDIbPuFzRSLD6SehYLNAdN9xNf+Fxwe9uaIt6zz3LdyDU91MFADLU6G
	16H6pVed+6PJim/nHNhjXWJy0PdY75xxtsbC5jXeeatspFMvKiyAIbNl4jJPEJ4vPy25T5FVRK6
	PhTyqo/aa6wVr+xZ5jgZ66MuoASNfHaaoSgm0Oda6qZPUYV9+LvzA4KsJYcMuRn6Tfo05H9qhGr
	ohGgodKm5ubyLcWXICBqa42i+8yULS3GIA==
X-Google-Smtp-Source: AGHT+IHBGgwN2De4Zj+PbX+xrtplnjXEp3cf0p+3b/NxZHv/aU1YEPLlOQfWVSldtA32B0LzDwdT3A==
X-Received: by 2002:a05:6000:1863:b0:385:fc00:f5e1 with SMTP id ffacd0b85a97d-38c519391afmr1800291f8f.9.1738142314062;
        Wed, 29 Jan 2025 01:18:34 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bad92sm16470675f8f.61.2025.01.29.01.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 01:18:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jan 2025 10:18:32 +0100
Message-Id: <D7EG0ZAD9USJ.2UCEVJJNB45LF@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: remove peer extra rssi update
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 <ath11k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250117181953.3375273-1-nico.escande@gmail.com>
 <d5eda793-c7e9-453f-9dbc-07e5df73c47d@oss.qualcomm.com>
 <dd5d8193-3b35-4eac-b551-4dce5e82c3f9@oss.qualcomm.com>
In-Reply-To: <dd5d8193-3b35-4eac-b551-4dce5e82c3f9@oss.qualcomm.com>

On Wed Jan 29, 2025 at 1:08 AM CET, Jeff Johnson wrote:
> On 1/28/2025 2:29 PM, Jeff Johnson wrote:
>> On 1/17/2025 10:19 AM, Nicolas Escande wrote:
>>> Commit b205ce4c266c (ath11k: support avg signal in station dump) added =
an
>>=20
>> I'll fixup this reference to address the checkpatch error:
>> ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12=
+ chars of sha1> ("<title line>")' - ie: 'Commit b205ce4c266c ("ath11k: sup=
port avg signal in station dump")'
>> total: 1 errors, 0 warnings, 0 checks, 8 lines checked
>>=20
>>> extra assignment of arsta->rssi_comb in ath11k_dp_rx_update_peer_stats
>>> when it added the average rssi support. So lets keeps only one by remov=
ing
>>> the legacy assignment so the two statements about rssi stay next to eac=
h
>>> other. Compile tested only.
>
> I actually made three fixups, please check:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=3Dp=
ending&id=3D7946ec554fbea5db9a3aedb7087f0eb9e3749abc
>
> 1) commit reference
> 2) add () to function name
> 3) lets =3D> let's

Thanks, it looks perfect.

