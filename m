Return-Path: <linux-wireless+bounces-20308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A7A5F22A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 12:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA1D3BDE4C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E431B1F03E4;
	Thu, 13 Mar 2025 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR8ao2tp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037D1D7984
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864690; cv=none; b=STYEHJJjXNO5Q5sxgZCTNcDZq9bKtXUhRKVun42fqNKmN98QWrBDtpdemprNVsOq+egxYTY4r2q8oLGbF/trhJXEGxstpwFpCza/T4ujfaSRo5SAohuC6PJbKMS09Nvn19PDgJ+4LfBR5Ay5K9P874SzvysW/M9JfOZqee3mPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864690; c=relaxed/simple;
	bh=r/VzEAcVAiBL7JVXxOI4/4crMavtIQxjA2ZRiImHWus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDu4pO6LngC4dll2V6MSJ0DAd2WIrApMyan0gBJUy3PEsWOciEpkzbWuSGuBYcX3kQYFPtWtginRBodUNcq1RHbLtBUYNahpSuRjxbRB9fgsVNWAllYyLw8lP9MN3GldpP4a+b4U5w2zjoC1GJ7N5oSU7PBOWOMEfZq9SHnzRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR8ao2tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379F2C4CEEB
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 11:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741864689;
	bh=r/VzEAcVAiBL7JVXxOI4/4crMavtIQxjA2ZRiImHWus=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=fR8ao2tp+AuU182y8einHDZbNj8/kyK6jFhc4EnsAq6x+NdvBZ4ntT7RJ3a00tbbF
	 7/kf6RjJZmoDCvA01aa4UYOx8MIFVWr5Y/9wBzHFGoNBA4/hXIfB62AXKFMup9CpVV
	 WIAix9mVUmFH64KTSQUIFe1GIA7TvDWpBHyrzyG8ia6IiWBD3Gp7q2C/Sd0SHV2urD
	 fE20V3N2V3o0PAJSKV4JZDsocxC1fo88k7vOdv8ZusPXCIzu0qsk1MdYLAK8AOh9Y2
	 2VKEX2lN1BF/V4EKw8VF/m/E1GkRl8DN/PjVHkflPIHQp8gpRQmka0JFkVxyzKzp6W
	 mqT4kTLL5PK7w==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e63c3a53a4cso718843276.2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 04:18:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvpnXUVqhoNNmjTpkE1LDIUP8l8rt4U3Jqz967DbmZVppgjT0NGGlheTkoTW5iZ+hNVoYzy8QMdiXJ03w2KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4Gv8L9w5XXZfrkCqbzlQtB58rDo3V0rIYmucUIKsBmv6GN3p
	ML+sGVlEqAg3IXXQ+0vxt3XLmjRnJ92zYKcSyU3SRJRlL8on53bKF6Cx8t/DRYnE9FR+eWj6cip
	UYCqBtbqLNffY/xXGwUprlotAEnM=
X-Google-Smtp-Source: AGHT+IELcNGATH4W9KljJxNCGKZhRTXaJoFLZsHGuh6GROhiWMIyd0J6DhkjdIN9XQfXkab3h2I4VLcHeiWJlTv6pys=
X-Received: by 2002:a05:6902:1203:b0:e60:c3a5:3bd with SMTP id
 3f1490d57ef6-e63b520942cmr12322953276.36.1741864688425; Thu, 13 Mar 2025
 04:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313051501.2519-1-zenmchen@gmail.com> <09b00f3c6d554ef0ab76065284eaf0ec@realtek.com>
In-Reply-To: <09b00f3c6d554ef0ab76065284eaf0ec@realtek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 13 Mar 2025 07:17:57 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6bLg0xHgfEca8PvwxtWNyu1+d-z_ZexXNDXGa5vARaQw@mail.gmail.com>
X-Gm-Features: AQ5f1JqUQ4upDoDd_1ANEu0K8XnYfz-Y6IN9lK2-th7ogZFIwsLx5dlUj8Nf4dM
Message-ID: <CA+5PVA6bLg0xHgfEca8PvwxtWNyu1+d-z_ZexXNDXGa5vARaQw@mail.gmail.com>
Subject: Re: [PATCH] rtw88: Add firmware v33.6.0 for RTL8814AE/RTL8814AU
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zenm Chen <zenmchen@gmail.com>, 
	"linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>, "usbwifi2024@gmail.com" <usbwifi2024@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:25=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Zenm Chen <zenmchen@gmail.com> wrote:
> > This file contains the firmware v33.6.0 for RTL8814AE/RTL8814AU and
> > was extracted from the vendor driver v5.8.5.1_35583.20191029 from
> > https://github.com/morrownr/8814au
> >
> > Signed-off-by: Zenm Chen <zenmchen@gmail.com>
>
> I have confirmed the content is identical to official release, so
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Thank you.

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/481

josh

