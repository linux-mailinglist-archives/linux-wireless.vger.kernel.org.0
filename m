Return-Path: <linux-wireless+bounces-26933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3E9B3FDCB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 13:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1034E2C2C83
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2862E92C5;
	Tue,  2 Sep 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llj/ALN5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043932F2E
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812639; cv=none; b=TRAHgrK7VLP5j1yB1h+JdbAJiLREaKcxKaTowt03n+CT+2iG8J2gF9Z9YHMJffDB6XdrBiv63i5P/qbajewX16wbOVs/AcXefgQN3sB7W5bEVSjOwLZdNyUT+ATDlKjad/AimHm6jSQX0sNNymjZUIfZ5xruFkZEsPFyVCj8FQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812639; c=relaxed/simple;
	bh=5E6jcqH0cTyrNUa1edZPPs2kKic+Y1u/MoAS6hEzav0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smMlpLs2TZuZoW0ZhO2bqZIYI+VttATCSgZ9tggLHsyuXZ4TVoJ4y9lR7znjuLTbh3WMlsWRnJxogc0gf84cDM0sxukeeMiejU4/TeDlUgVz2m/bnNtQF8aW7e/i2AAIQw2Dtj72QNZ3+Cx1Il8X6LOFUeu6B6srrqw1avwqaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llj/ALN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96182C4CEED
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 11:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756812638;
	bh=5E6jcqH0cTyrNUa1edZPPs2kKic+Y1u/MoAS6hEzav0=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=llj/ALN5Z6Kq/TVs+kiYM3782MPIOem8mncA4JLcn2dbRDQMKsZvG5gsTkk4dM60+
	 oxbMc9Qiguj7xdwfmdOlJzX1Fo6xXhj0khKt6WfPIm+sOKTndoJbw3QVNRWUOzqALk
	 mSLE87HUm2MmF2mg/nfCPjGN2iPp2cNGLEGpTt4EE9y8TCFs2UHjv+emMFf3i6Cctz
	 LlT+Yk2wqzn1EChxmZHWyc11Q4caP5pvpRHFJti9nKrA/Y5md5N3eSMkWO05QGixix
	 zu/ZMvU0Grw7pXehg8p1CL4AdM/xsR73rKFVIKMjZd1pERI5PLU1Ciqk2uEWTvlvp1
	 b+HzrWCbJdUew==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60504788so42687047b3.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 04:30:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVh6gX2ki6i8JkAJx2MRatyOTHlJiDqXUTeakc5kMpJw4fecCA9+L/jsjuK8AAeSGMyKavM/ZrShBn9ZTwxqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7LZ0MI3wM3qm670EN/4rE+1OJC1Z8gx2Hqz8mGo6zMCYJm7S
	1Udlpyy8dxQKUtlFQ9IBM8lhX2hZE+SIxrU00xLg+xX5w5uWHSirSKUdXGG7So/gI7kRC/q+S3I
	9eXjkyH4WdrbJFwjFTYE5+wRYVv/jch8=
X-Google-Smtp-Source: AGHT+IHOj1IlPVOeq0sTJ8l+WH8BLKEmsM12scHV8pjDOMwjtYkNH3fl2dxEoUy4zxRTvSOYPK2eKEFDO/npEGtOZf0=
X-Received: by 2002:a05:690c:8e07:b0:722:875f:5ba7 with SMTP id
 00721157ae682-722875f5c4amr88796167b3.39.1756812637858; Tue, 02 Sep 2025
 04:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9eb91098-48a6-420f-bb6e-e7968ab0a2e4@oss.qualcomm.com>
In-Reply-To: <9eb91098-48a6-420f-bb6e-e7968ab0a2e4@oss.qualcomm.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 2 Sep 2025 07:30:26 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6FA8jSB5BLd-iQU7yAp+xszAKh=CQwSQRYJOHcP4ns1g@mail.gmail.com>
X-Gm-Features: Ac12FXyaoKSB3T-aSqJbcUgZ6a8FIusBLZoZHTbP1HQcv74E7cPjzJnDNfKMASg
Message-ID: <CA+5PVA6FA8jSB5BLd-iQU7yAp+xszAKh=CQwSQRYJOHcP4ns1g@mail.gmail.com>
Subject: Re: [PULL linux-firmware] ath11k firmware ath-20250827
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, jjohnson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 10:36=E2=80=AFAM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> The following changes since commit f044bc789f8e7a4427593b687801644c39e3e8=
b7:
>
>   Merge branch 'amd-isp-staging' into 'main' (2025-08-25 18:22:13 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git at=
h-20250827

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/665

josh

>
> for you to fetch changes up to 0cfc1632ef7b1cc15eea36214fc67098f6d49531:
>
>   ath11k: Support WCN6855 hw2.1 with NFA firmware variant (2025-08-27 07:=
43:22 -0700)
>
> ----------------------------------------------------------------
> Jeff Johnson (1):
>       ath11k: Support WCN6855 hw2.1 with NFA firmware variant
>
>  WHENCE | 2 ++
>  1 file changed, 2 insertions(+)

