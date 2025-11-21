Return-Path: <linux-wireless+bounces-29228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C849BC77F72
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 09:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DA0652B801
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992A253F39;
	Fri, 21 Nov 2025 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrLadyP5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457727A469
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714530; cv=none; b=SM6JkIVf27hwgfl8IrBlv9grrgdylni8OVw5CVopHwpHWi3ymTQAYLVrHLCKhiVoGeKnmIifK/hRulOKcBMOFoLKorqJJV23uLBgjE9V8/aL0kSbsufRpTNKD5VDAVx8/acg37+bB15JdY417zSw1ABMFw0d0hGyNuPvywke4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714530; c=relaxed/simple;
	bh=kMV3BBFjz8DGW7rwtYcSs0cAEMArAxtW5c8PBZhfRYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo/UZvrXDa+couIihlPkP+GsrYmiI6L38JNLDRJjy8mh/VFd8HRj9jtcqD9aDKi2hu63eFMpuyRQOzL1qyA2OAHjFmn/a3ddc1rNrQJE4Xz1nVCgmRW/rqZCbOtp6xksI2O05sJo1L4fuVge2YQmm8xaWXJXFmSvHOfvE3wgLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrLadyP5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34101107cc8so1551173a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 00:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763714528; x=1764319328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8TTlrk9jhEkZ2BRRQwFZvRKVNTvpyz9ieTO4ovRvVQ=;
        b=YrLadyP5iGOQOdMpNR/zIsrh5R+k0hq4zljAkDNhlpOXteDmRpvHMzAOzKFfWza1++
         Gfc8j1QXMP3MFEVtXnuD6V32QoX+2USrFqiiDeheBVoGn13EqWajsOt55oS3XDE3luKV
         SEh24qn2otIPz6KocTVkNmRuiy3qzmXW8JQgwj7y4cMJtBmyXcrFdu+E9nWNgcoYOOll
         TdoTNdX+ousjJ5texU7VyS0xBzPm5XpNPixYJsjbr2nJbi8P7QNX2jwuHLXNuOJg5qS8
         OVHQL2yi0Fg76PfgmTXswrB1slq57n8gE1kn/bZOd+/kAn7fVQnwqh4RkpYc2JDQDXBM
         c67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763714528; x=1764319328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8TTlrk9jhEkZ2BRRQwFZvRKVNTvpyz9ieTO4ovRvVQ=;
        b=iI06Md5n3XHBqYdKCAaEAXSZRiSh/MsujsoIm6H3kLJkDrYu+RIVeWsfawbrtkStoR
         j6GUTg0dK/3JuXGZNFElk1PXQD2BXBiBv0X9Xi1hjHBx7ZkviuFhrUhPMQyN5PtOVJH+
         yNJBXcpJV0VM516SRgZ12PHbDgJESM0UkWXZtS3gyQrA2McPw7fT8BffpbxWZTxWznAw
         bTg3i8F/WG7iTMYKSZvThKm63XwZ8ULiBOWyFB8IckBlnJtCP1u92mt7xYZsMwEZHra/
         HtD6UiUTRcqA3aUEgEA2csF+QGwdRN5ec/sWQuMtvKPx57Rmk3WaK6uLBReEAAAMU17q
         HAMw==
X-Forwarded-Encrypted: i=1; AJvYcCVDYGyrxOX9GKnhvpuTrnPMv38e6QsrY3M7GwkXd+694BciAQ1HMBEW+CTPxl3rS3ukIJbg572sqLFHqd33fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYgPrG2OIye1kDlFrPiklSI72XZM0umoEJUYX6h5EkKLBmKqd
	RfDSBeaPPgI4crbhx91GoQrzSSjHVnnnjz/+uRE+HK5w+d432Of6Zjmwj/mFB3DO65kqhUAI/CU
	cpBckRgvXMIxr3x4xa0IPJPLOG3/49A==
X-Gm-Gg: ASbGnctQglnqyR7zofGYOgXBh1qogcNy1RIBkhoijjDOo9FGQ5hsk687tVAEJbqj1FU
	Ifukl3XgWg/bna/tJUBoMyM8ohTGfwxm1lcrV7+WaJRnEgIulh9HJnUYGFJS43pEeID8R00rCVB
	1IWM+xE8TrjjcLfH8gBg78Dj0uUK0z4E3HvfGMbREVfqwrTYlHaLl0zoC3Hlp/i1984h6a7mJdT
	x7Z95BQzEWDsWuB9DgV41gpq1jGj//F3uiVi/JQcuoEh7n8WXNJNMldA6ypwV6Gy4h9mw==
X-Google-Smtp-Source: AGHT+IGXpwSBg+cnmgfT3mAH/pI9tjvarzlh6U4QCi0C2qg3LizoR8jOqripn70lrYlTiGneCh572FLui3ROUR09I3A=
X-Received: by 2002:a17:90b:5251:b0:341:8c8b:b8e6 with SMTP id
 98e67ed59e1d1-34733e7ad83mr1972483a91.16.1763714528468; Fri, 21 Nov 2025
 00:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f355c8a-5bf2-4a74-9b35-daa8ae479736@oss.qualcomm.com>
In-Reply-To: <3f355c8a-5bf2-4a74-9b35-daa8ae479736@oss.qualcomm.com>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Fri, 21 Nov 2025 09:41:57 +0100
X-Gm-Features: AWmQ_bm1mnDLYgE0TQOEDWcR3npK8zC4Q3Xo_KhVCay49lQ1oXDPp4bWCogJKLI
Message-ID: <CAKEyCaD4=qeQZYYOv4BTrqUJkZa+jnea1b3BL434X1iGMA-_xg@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: add support for MU EDCA
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	quic_yuzha@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 6:00=E2=80=AFAM Yu Zhang(Yuriy)
<yu.zhang@oss.qualcomm.com> wrote:
>
> hi,
>
>  From your log/calltrace, I didn=E2=80=99t see any errors related to MU E=
DCA;
> what I saw were related to SMPS. Did you also add changes related to SMPS=
?
>
> Yuriy

Hi Yuriy,

Thanks for your reply. The ath11k driver is version 6.14.12.
Everything works if I remove the mu_edca setting without any other changes.

The problem doesn't occur with the newer IPQ8074 firmware, version 2.12-014=
60,
which hasn't been publicly released.

More details: https://github.com/openwrt/openwrt/issues/20702

Regards,

