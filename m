Return-Path: <linux-wireless+bounces-24910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060EAFC474
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666017A8573
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E07D517;
	Tue,  8 Jul 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDOkT4Ze"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E73FC2
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960789; cv=none; b=l46Xyz7qvLbxNgW/rgtNtKLVTx/yA1DVgUBikhQsWvPUNOwrD7FtHgjF7hCwbb3Tp4lvtS9/NrrzVlseHGFi6kDtLjPUrCo9w5J2+vEf744CuJ93BBeX2yO1iVWrWK2UAzyVurkFeRY/TRajQ3DPcj0gsu/f7/ldHT7p9dKQNps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960789; c=relaxed/simple;
	bh=DTo6M5lf619kLLoaWOPb/W1KDqfDZkScguV96S3rP6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxonZSDPZicqDX50y3WThnQtElzYBPTUIy4R+ugityXCWpNrt1DqDtYxFAzvGKLg1TILFQqagr7MAQtrSWRwMR3EGhm5Qc9iQkqQFw6uIm6uJ0fy8fD7umAeXkyh6ixOYbASur5/n9bhWB4HZTml8nJkp0O2RTHOqDTOqPlUhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDOkT4Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBEEC4CEF5
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960788;
	bh=DTo6M5lf619kLLoaWOPb/W1KDqfDZkScguV96S3rP6s=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=nDOkT4Zeb8q1NACckU99nuxMzaH61O4F3lFLl6+phk9775ZynUtjRrg/pk8E9ohHx
	 x+qz4sAMQFKmbYLfLUw89sp+1I9Ho/SViODOI3Un4sfn2iAU9jwjOT6f+lVNQ98/NS
	 /R3QwAvgxzIePijDpnRxtgP2GMGDfiqhd6SNqfF8CgwJUeFsRi4Jyb7+SJhShCmupz
	 cdPMoDtNAV3eSdlCUE6azPgAq9HeM3J77Lj33vn//f4TG4mBKJN+G9rwbzovjrJhyR
	 yQN+2RcDfARTV2hYvOG3QylE8vzriudesdzcVKvF5RGavyKbnmX+C+yAWAPfKMMUUT
	 ceqM8ir1VVRLA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b544e7b4so3965556e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 00:46:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YzV9kC4C35Dzd+PK1ALZTF5nJ5Z+BijWoE2wQJKzbPtEmyFms/L
	pkyIJIK0kbYVfK0Wo1dhxzL17U5I1wF8lgbt53M+Zci4S5K3U8OHdtQnQwZDAc/biAPkHIZ/29o
	PFZaV9COuyrqtjaeAPOSnwcykYnB0O/I=
X-Google-Smtp-Source: AGHT+IHjAE6byGQG4XVAZXRxytoDVyFw9lU38ypb3eoe2P7D/hVWUAzvISuuT41d8uX4WywBS3zaTYCK89UimOaQK48=
X-Received: by 2002:a05:6512:3192:b0:553:2f27:e96b with SMTP id
 2adb3069b0e04-557a14219abmr3880844e87.2.1751960787032; Tue, 08 Jul 2025
 00:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708015005.6470-1-pkshih@gmail.com>
In-Reply-To: <20250708015005.6470-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 8 Jul 2025 15:46:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v67YNZG_-MtJT_pncaqeQULj3FGLj7jpSUSOGTXe2ipGag@mail.gmail.com>
X-Gm-Features: Ac12FXwklBAEJJlypuFhAQb60x5EXySJCz7ifc3-PKY6mu50ahUqBM0Eq4-VWmg
Message-ID: <CAGb2v67YNZG_-MtJT_pncaqeQULj3FGLj7jpSUSOGTXe2ipGag@mail.gmail.com>
Subject: Re: [PATCH v3] wireless-regdb: Update regulatory info for CEPT
 countries for 6GHz listed by WiFi Alliance
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 9:50=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wrot=
e:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
> countries including
>  - Albania (AL)
>  - Andorra (AD)
>  - Austria (AT)
>  - Belgium (BE)
>  - Georgia (GE)
>  - Iceland (IS)
>  - Liechtenstein (LI)
>  - Macedonia, The Former Yugoslav Republic of (MK)
>  - Moldova, Republic of (MD)
>  - Monaco (MC)
>  - Montenegro (ME)
>  - Norway (NO)
>  - Switzerland (CH)
>  - T=C3=BCrky (TR)
>  - Ukraine (UA)
> Add 6 GHz frequency entry if not being added yet.
>
> The following are skipped as they do not have corresponding entries in
> the database yet. Adding an entry just for 6 GHz would cause 2.4 GHz and
> 5 GHz bands from the world domain to stop working.
>  - Faroe Islands (FO)
>  - Gibraltar (GI)
>  - Isle of Man (IM)
>  - San Marino (SM)
>  - Holy See (Vatican City State) (VA)

I also went through the whole list, and it seems "Bosnia and Herzegovina" (=
BA)
is missing a 6 GHz entry. Could you send a followup patch to add it?

Thanks
ChenYu

