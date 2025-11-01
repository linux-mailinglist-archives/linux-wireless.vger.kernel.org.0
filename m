Return-Path: <linux-wireless+bounces-28453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6FC279B5
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 09:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69961A26285
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2993F22FDEA;
	Sat,  1 Nov 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2KlPE3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E0299AAC
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761986032; cv=none; b=VMFPdUi/yX6N2NLh58aAp6ejeEQh63/Md46QxfMD4teDYE2Z1V0ZQDouMKih7Q3Mcb8JZbjS0IXoAtG3aSncJwcqwZ3Z5fC6+JN8zn6UbLmXZMboGM1uu2/NmosETRIAfnaPXI36DwGXa0DoZf8dOX4de56hyMoeh8jZlL4a1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761986032; c=relaxed/simple;
	bh=T6FDRMvNjCpM5LhW8oA1BhHC3fA7lHDvd289NfjuJEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+ON7hikrCiIO3xpBbZGMYoIr+C1fqm1/CKTU67Do72ArTYMSZU3jdPcZ5/AEo1Wol/3RZeLGms3BaW2KfXuqHVtimaAcgl7IEp4YYr6AMekTJY8M3QPHW1h8DGkoft+61TXSPOzB6ig5cv+MxF9MXxwmun7j/eBrAzlKvSDzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2KlPE3T; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d83bf1077so609199166b.3
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761986029; x=1762590829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6FDRMvNjCpM5LhW8oA1BhHC3fA7lHDvd289NfjuJEk=;
        b=L2KlPE3TsUKrrJtukTI5oeCT7zoq/gnDjZ5p5MHWohZIHthwhlEE2tQ4SvCUu/1pPk
         MVdrh9+HE6i0qwVfhUvI9JdtM9Hi0yeWzb3hTQeegueqLPnq8OfMrUCQRqNQ4TicwRAS
         5kc7BVWlzGpsEETwth/uFhkIkrEesk6du1V+lA+NdiJX+Louj+Na0M9ugU3NsVfaQ7vc
         QnXFxiSX74DLa3H00xbKYFUaGZ+aBT/E9o9kUKyzy17LbwFKHCE8UXYvuL0Eh2TwAfrC
         FXjkKimN4C5CXmr+NXtL5YBzdK1Z8JpD3H4tJ7gv/3IqIP9xeSxZ9wCSqoXs/P4ZxsiS
         PbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761986029; x=1762590829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6FDRMvNjCpM5LhW8oA1BhHC3fA7lHDvd289NfjuJEk=;
        b=pOXMntuXANlUo0ZJk7QccjAs2sTrqzKNP4ZO/xKTj/+ouiAt+hCp3coq5KkhaVtVB+
         XW5xVLwmcuamNmWezHfpvJVTNLUrJXHXmyTsggP/HIvH1azNzICJot0RbhUgOU9wnCwv
         wRzC+XwHxNW/vpYkb+zpQxuGWAcj3xQtk3qpAnCjbxbxs0OZkDnNKZfOhezxrL3cj/RU
         6ufzpSz0Pi3TTYUriSGR0RCBlOPGv8LmzQX3S0JAq4vUjRddWDENqj2gH7KUvr7y6cfC
         6ALC2OFxjWbPAAFud1r9SeQfzLazFWjN+H7I4ZBrKLwKLETuPXPmcaq5cZLPFkl9YVdT
         6Irw==
X-Forwarded-Encrypted: i=1; AJvYcCVz4n4TKHhJMEbZbqYUmvmKsCMOzJvTxoh3Ho3ObaWYSjwkBIPldI1MLTLqbPif6MHcbVzvhtHXXsOhgQs52Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Bn2hXO8tVVGqs7maDKJ2wir/LDS9uaXmTnD29YYl2L6WTWTI
	bXeNiHYb8A8rr9DsbfJDURLXIjgDFwv3rGRj73IhgYx45itHlZNWRNYSh4nLR+v2kFxyYWGHETZ
	n+y7kM7VU906pnm9Mmc+oStKtzVTMcT2kfI4+GB8=
X-Gm-Gg: ASbGncvFhC6UtHy4GPxErrFrBMFVKBhshFjJInfK53lzRAIevzeiFIehj9ZOQ25SKWO
	8b/WAG9t50o47VP7ONHZ6u5p4TGYDs+FOzfW3R/Upx9r95qTS8eEPUjsmbSZvuKypEflKuGVncr
	LgVvrqKPqrselDEBwNhoU2hgMJmvSM/nKM5gK6xO8xDlirF8GbxYkEcS6iWmbv0bCZRtLkDBFvJ
	zccr6sJVYChsb4iK6gEf4bOOK8oil2+pGZX8OZ+I95JY1ERY4BupDPQ8T3ZiR3JCIV8P8U=
X-Google-Smtp-Source: AGHT+IFFNpeJR9dbHOFQiQ7dl2HrM0sefQRNzTRSLtFVnX83H6VZ3RyD1DGUtnaezdZpBQrS3kk9GBbj9+zKnfj/3K0=
X-Received: by 2002:a17:907:6d19:b0:b6d:6a35:99a0 with SMTP id
 a640c23a62f3a-b70705e3de7mr643662466b.33.1761986028413; Sat, 01 Nov 2025
 01:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031111639.406873-1-hujy652@gmail.com> <6de0a467-14f3-43e1-952c-b8cc7eb4801c@oss.qualcomm.com>
In-Reply-To: <6de0a467-14f3-43e1-952c-b8cc7eb4801c@oss.qualcomm.com>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Sat, 1 Nov 2025 16:33:37 +0800
X-Gm-Features: AWmQ_bkotIWEYeL4LFQRHlK9ja_7OBUjk7WwHRpeWL4qz8dPtvmOxKYUFA5-LAc
Message-ID: <CAHGaMk8BZiA+_ucfqZ+AnBe1ewuagADJfMK3UjECU3rutOW-kw@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: simplify ath10k_htt_tx_mgmt_inc_pending
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: jjohnson@kernel.org, ath10k@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 11:00=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 10/31/2025 4:16 AM, Zhi-Jun You wrote:
> > Remove is_mgmt from ath10k_htt_tx_mgmt_inc_pending and make sure we onl=
y
> > call it when it's a mgmt frame.
>
> This fails to describe WHY the patch is needed
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#de=
scribe-your-changes

Hi Jeff,

My apologies. I will try to describe it in this mail and update it in
v2 if it looks good to you.

ath10k_htt_tx_mgmt_inc_pending() is called in ath10k_mac_tx_push_txq()
and ath10k_mac_op_tx().
In ath10k_mac_tx_push_txq(), it checks is_mgmt before calling
ath10k_htt_tx_mgmt_inc_pending() but there's another is_mgmt check
inside which looks redundant.
The function name itself already indicates that it's for mgmt frame only.

This patch removed the is_mgmt check in
ath10k_htt_tx_mgmt_inc_pending() and add an is_mgmt check in
ath10k_mac_op_tx() to make sure it's only called for mgmt frames.

Thanks for taking your time.

Best regards,
Zhi-Jun

