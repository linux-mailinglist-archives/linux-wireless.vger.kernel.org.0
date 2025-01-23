Return-Path: <linux-wireless+bounces-17859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA39A1A0C6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 10:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7336116D281
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFFB20C01B;
	Thu, 23 Jan 2025 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/OPF+Ax"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1821537D4
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737624373; cv=none; b=POXRPVaNAuEe98qhokdVPu0VNiDZ2W/8TErRQAIOJUneG3yivKlgCLffgGzOVgCyv/JuF3/fjp1k2vFvt/LVnsGcsjgMreKd0TxN/hN/n61c2nPlU6TkiZrL7F7EjP1pDhPbOr6Q8HkT+7YZgHLkjnj2HzbL7oP4zjhjjNW8gSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737624373; c=relaxed/simple;
	bh=exlhf81r2DLo45l4osjsU8vD5u21bId9SYYdlAPYvcM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=erbP0drm1RIF2a3eeEJhVWEtITtYvp959al2p9mdauqioJPebGdNHQ1dij9REAQ7Lp/hdDYWBWiuUm8AlTU7nC00DB50PC3zb1GysZZm2FUzdN2lYd92fnYT6n1RvBahG10ViQjUzLYk3fEDnckL0+dWbVbZ82KohsAuJaMOGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/OPF+Ax; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso4214815e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 01:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737624369; x=1738229169; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exlhf81r2DLo45l4osjsU8vD5u21bId9SYYdlAPYvcM=;
        b=K/OPF+AxdkwqLJLraiIXpycmeG13bmt4ivExuZTeascvoStPeBfiC51PzDzOLy3vV4
         jgzRGKG+WBAzyIjNJzSzPiVi2smVIKDShs/vGpM5U5Y6fgy4HG/LHkIDYj+NKDFHxh0Z
         MTa71h8isFHdeQWE56sbDUlIoGlLHPig/ysXkPRN0HPZyYyXp1dtt1O7p69fiBy+j1oT
         z2EQJXjADNQOYia3dq+HyFBRb4dN4gtnMDFpKqVE8/Wy4KP3SqoYeARLQLSdNBldDxVY
         5YRunh17UjulhmsHCJXyQRIhNKcjux1Lfgd+RqdttufBia1bccpTqIaD/ua1HyZEJTYB
         psNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737624369; x=1738229169;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=exlhf81r2DLo45l4osjsU8vD5u21bId9SYYdlAPYvcM=;
        b=UqtVNtPcSbEUMH4l/0h3RiUBHSjj4E/AToWnA4xKOfeN8DxAwGkVz5XOuZF8GTgOiX
         HDQvmDsUk6FtJI3Twc9JmPCRQMxEhLjQHZqTQb9PReFG299dPBkGS2msxjwgVJ6qF5kD
         WtYTtQd6nYCj1Cwi1AaDFMDB8yDhJa9C2Jr4U0FwyNiY5eBZksfmEkNkr0ECGa3eJXff
         8jDRS3QKzxnWjv+XoKIO6QLoyPPqIy6MeBRhB8tILbxTu19BzgoVerNOKJxTzIRnNYIB
         yeNU7wT4DR7PGaWoC7Qj8IPJ9fVBg+EQmZc8DXeIzP8ckQokub0DoK1ucRAUe6z5D8oX
         Pa4g==
X-Gm-Message-State: AOJu0YzASS8hzeWbJ77jdClEBx1HsA1dctd4nX2iKtfmuhx1Pg5RFiZQ
	KsIeSWkf2MfO0BDL7NFGO4Lc8SkfoOahyJTg2Gilexv43rpVpAif
X-Gm-Gg: ASbGncs5OpsNtjEBUCAurcKoR0XWqIEwsq/U5qz3yeGFstTaOX9ztAftx9f2/5vio4N
	hyR6sm4NFr1L9MD51o45S7wW9uBtYTSzzj0kSc+mmv8y5tOBH5HXmPN0JPa44g3iC9UkuWs8AIa
	q0eYTeD9rUaCSmGac+8UCZuzxok6EI3X9gvNjp9bN+kVWbVLYH/1RtpgAcVWuD+g78LM0YVDIgZ
	qeawbNZpr1jeL4x0JkDaBXhH8844f+G7ZCBRI9lmrvCW3/yOFhuYqUJ+HeVtXskTiF9fcl/7u54
	S4HiCEiPbWRc9EYyydAqipY=
X-Google-Smtp-Source: AGHT+IEmHLIHqv7jO8I11oxrWXr69vnHLGz3wRb2PIZ5hihqMrTHq6XurJa22x+ECqzMN/Vp9iF6aQ==
X-Received: by 2002:a05:600c:1908:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-438913dbf63mr223008635e9.13.1737624368698;
        Thu, 23 Jan 2025 01:26:08 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322aa40sm18521106f8f.45.2025.01.23.01.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 01:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 10:26:07 +0100
Message-Id: <D79CFIHCW9EP.330I13I63VTFG@gmail.com>
Subject: Re: [PATCH] wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx
 error path
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>, "Aditya Kumar Singh"
 <aditya.kumar.singh@oss.qualcomm.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250122160112.3234558-1-nico.escande@gmail.com>
 <101c0824-1c0d-4e5f-bb4c-7d6ef65f1698@oss.qualcomm.com>
 <d0dfce80-3e57-4efe-8552-b18bae9e9437@oss.qualcomm.com>
 <c6b65bee-3680-4e54-9d7a-2b582461cc73@oss.qualcomm.com>
In-Reply-To: <c6b65bee-3680-4e54-9d7a-2b582461cc73@oss.qualcomm.com>

On Wed Jan 22, 2025 at 9:19 PM CET, Jeff Johnson wrote:
> On 1/22/2025 10:20 AM, Jeff Johnson wrote:
>> On 1/22/2025 8:46 AM, Aditya Kumar Singh wrote:
>>> On 1/22/25 21:31, Nicolas Escande wrote:
>>>> When vlan support was added, we missed that when
>>>> ath12k_dp_prepare_htt_metadata returns an error we also need to free t=
he
>>>
>>> nit: Always refer function name with () for clarity.
>>>
>>>> skb holding the metadata before going on with the cleanup process.
>>>> Compile tested only.
>>>>
>>>> Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
>>>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>>>> ---
>>>
>>> If there's going to be a new version please take care of above nit=20
>>> comment. Otherwise -
>>>
>>> Reviewed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
>>>
>>>
>>=20
>> I'll fixup () in both subject and description
>
> fixup in pending:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=3Dp=
ending&id=3D29d6569f323a88ccb3239abea562f6e691cfd9e4

Perfect,

Thanks a lot !

