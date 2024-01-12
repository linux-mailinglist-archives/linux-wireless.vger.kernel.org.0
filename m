Return-Path: <linux-wireless+bounces-1779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742EE82BA17
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 04:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E0BB2204B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0A51B27C;
	Fri, 12 Jan 2024 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="martmq3k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93FA1B27B
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 03:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0F6C43390
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 03:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705031042;
	bh=t3yAn8l4w+vQ9K3EeylhP2ucFV6JMzdlWrJ8F/EmlS0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=martmq3kLgYWUQ9V6r6Ox6C4QPRTxoiL3d06sMu29G1jJRCD3bfvRHzr7CvLJUD1N
	 uffjvnmUYCp0XKFhABrlzqMtE432HlOpJgPxib0LjgC0J3Qppslr6aMmt+XYmOYF5N
	 7MfxNurWVmCl0YwdJH65UuT0nkChv2a4PGdqZLZq51Ba5T/YurTPlh682s7LBlo6EW
	 rgGIg8RAqsyT/gJ2MA4HhquoCvuJN65zqVNDL/trzT3Vosqy5Y0ATWyRdBEdMpmBCr
	 eC/lID0DEe6ue14WckW7vt1XtWgg+QhIyn7VQuvRUCHl8lekNeHBnMbt4Li4e4Rx3m
	 WHNY0ox2gyhxw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-595b208a050so3628052eaf.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 19:44:02 -0800 (PST)
X-Gm-Message-State: AOJu0YyF/KdOwOR2Tk4HHunUwMxiYCs4dZYsdMdoMih7mur0I5C4ljXH
	XF3HTWFn+tO8bcFrgm3FiIRv+fAWWVp8v+2cXrk=
X-Google-Smtp-Source: AGHT+IFO+KwCoCrLivVqOMe96YBLJJD0w26a0WYJrMK2FDgbNbgKsn5SWar2VgBGKLcDGUEXhApTNVFee8PBtcXqx1U=
X-Received: by 2002:a05:6358:59a7:b0:175:7a1d:e17c with SMTP id
 c39-20020a05635859a700b001757a1de17cmr1348228rwf.61.1705031041681; Thu, 11
 Jan 2024 19:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112033321.23052-2-me@ndoo.sg>
In-Reply-To: <20240112033321.23052-2-me@ndoo.sg>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 12 Jan 2024 11:43:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v647wp1fUEkY22ma+ni+kLxeWSezamsGEPUEfedUGJBOAQ@mail.gmail.com>
Message-ID: <CAGb2v647wp1fUEkY22ma+ni+kLxeWSezamsGEPUEfedUGJBOAQ@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for Singapore (SG)
To: Andrew Yong <me@ndoo.sg>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 12, 2024 at 11:35=E2=80=AFAM Andrew Yong <me@ndoo.sg> wrote:
>
> Changes since v1:
>   - Update comment about raising Tx power upon TPC implementation to spec=
ify mW values
>   - Extend (5470 - 5725 @ 160) band to adjacent 5730 MHz to enable Ch 144=
 similar to US & TW regdomain, instead of using AUTO-BW

I think we're missing the actual patch? Can you resend?

ChenYu

