Return-Path: <linux-wireless+bounces-18514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D323A2879D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 11:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBF7188A572
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410B22ACCF;
	Wed,  5 Feb 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF+Qz4p4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053BD21A945;
	Wed,  5 Feb 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750199; cv=none; b=UBzzxPRcCu/jZjLVC7v+ocOG3T1Sygs18sido6YZot9Z3SIBiyOQmpPDx3197d+nqzk6z0BT8TabrJI9LE0YNNj0y90Bml0LO77fquKtjl3ENOrtkRLVejRh/k2cZ4OC6M7TeME7tr1cm89i0UVKHF+mCCVT76fkoVLyZ7ECjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750199; c=relaxed/simple;
	bh=vt9j8TC9pY29iT03X+VxKEpjegg1XM81vTdQ1NBXkMg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C/m4tTo25q5TNr/ljsT3dSxdIpyJcwJRYvoaklQQ6n7TpnZSCfkSASn441bdca61l+OlrEZfmS0Fid1RXhD36UTGTCKH3cq7FcDDVxhh3zG9c6krh2neHrFEG9sBFD0Q3/7yWvXi7owB2pfYIHVpDBgJmJN1anzKZZ6tXrH8g0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF+Qz4p4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38db8f8786fso5415f8f.1;
        Wed, 05 Feb 2025 02:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738750196; x=1739354996; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgKWsb4wd8O5NQcrXT8xnVQwH9+D70MltxfRewZxbzo=;
        b=VF+Qz4p46lJSbgrxq8dX7Aso5mKBi56MPS2egDgOz4mZcL2mft2uMhB6RDLutKu+ne
         S+NpmocZxnBs0juCZ+nA2zraU9+5C3ebggIKbo3OOacqhZ7pe7RypplIrHeCIAEiJx37
         OT5fODaTJF5UUmYH4O5itra/hw+YUrH7XNLOF+Jw8ZUvpQyQfZg77ytE7ElAIS/8mQ9i
         PYPnlapilfpIS60KF8tsPtvmZ34yoWQ8vZfCmYt/lErOS13FUhkc47E0G/4U/dtQavNO
         STi2L4h1R/AbVWnRi84jBsKFMYGY400CgewrZb5HsOqnOEs5UF9NTmjWA/KoK1ym6m8O
         VCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738750196; x=1739354996;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UgKWsb4wd8O5NQcrXT8xnVQwH9+D70MltxfRewZxbzo=;
        b=MGQOJ4OfwTONPOlLoZm0gXk/hANVVefe+zkHhivfCLg9NbqOdumg6PnAQObw6fwg6w
         8WRJeWBVmodAA+kM78maOMmmhnvboNoQax9FVo+ivf1J9GlwiRziC07ZzHJqGLnmRW53
         p+ohvcgzHiPTIsTXm5LFuWDi0TwImUsdRNISGa/nL7NccUfd06wpjkCTzvc6/w56wZck
         7pEsEGfsRZ1AztsUrSGIRy+shO43a1k0ayPfTNnB9+B4jmwHr5MRiPF+49C1WN5qYCdS
         5FqonY7LjtErDEfJaDTambsVDlKCYw9TnfOMGGhDhQxqKVW0Dn64ToQRNOUi1BKIxeBi
         AwuA==
X-Forwarded-Encrypted: i=1; AJvYcCWxmIk3j+Zrm86IFxku16CnCllOlQ1h1tP21WxVurrIFRofCbI5X/cy3MLYCNDPzq5TtwDwuTSwPkSEVec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81Frg+Kzuo/1W1+e+P2O5km9DNyfCq1gFUgVzZJa+mHswoVvq
	5Jy5RuBcgKtA3CUn1sQ8yrGjuLssy6PT9s4UuTDLqB1jRbxdF4nAtQH6PA==
X-Gm-Gg: ASbGncuGHwNiAjwcMJt2xhS++J1679E5okCRQ6l0tM1J1HOReD3mBYSmPO5r6jt3bPN
	B5/JU0dMIQYiKX+c3Fp8P63qzYFVfRGEzKuTPTWkrBbUD8c5St4Nlx9iyAtRZXRdfK5ymE1Q0Rg
	wzfuPf2WGJKdYL2JzAwFpwOzYNZ/bERYMId2D6zIPhIuQPDsQEvTMxQ0rHPDJywj5RjEapjxOmr
	Cr0nNsmFFpjG+ATXlrLce1KGVuznhlSMZptTELWUXeBugT5CwDXjyh7V0fqj+5DO/g7DSgab7vi
	hkgVFpJHcYNTnk2+V7l90+H41IyF3GkBWw==
X-Google-Smtp-Source: AGHT+IFM8JZsI4fER1QYtXtRH5Vsk9KNxGrlRwfk8xspZYy+cSpsU0f1P8CqycBiWmyK6AMn8PG+5w==
X-Received: by 2002:a05:6000:402b:b0:385:dea3:6059 with SMTP id ffacd0b85a97d-38db48dfba5mr1426073f8f.49.1738750195987;
        Wed, 05 Feb 2025 02:09:55 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d933a3esm16904435e9.5.2025.02.05.02.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 02:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Feb 2025 11:09:55 +0100
Message-Id: <D7KFI4INC6NC.3JY96TZGRJCX7@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Vasanthakumar Thiagarajan"
 <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/8] wifi: ath12k: handle change_vif_links() callback
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Aditya Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>, "Kalle Valo"
 <kvalo@kernel.org>, "Jeff Johnson" <jjohnson@kernel.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>

On Tue Feb 4, 2025 at 6:05 PM CET, Aditya Kumar Singh wrote:
> Currently, links in an interface are allocated during channel assignment
> via assign_vif_chanctx(). Conversely, links are deleted during channel
> unassignment via unassign_vif_chanctx(). However, deleting links during
> channel unassignment does not comply with mac80211 link handling.
> Therefore, this process should be managed within change_vif_links().
>
> This series aims to add support to handle links in change_vif_links()
> callback.
>
> Patches 1-2 are making debug infra to work without device info.
>
> Patches 3-8 are the ones changing the code to handle as mentioned above.
>
> NOTE:
> * A new ath12k-check warning comes which probably needs to be added to
> ignore list
>
> drivers/net/wireless/ath/ath12k/debug.c:69: Prefer [subsystem eg: netdev]=
_dbg([subsystem]dev, ... then dev_dbg(dev, ... then pr_debug(...  to printk=
(KERN_DEBUG ...
>
> This is because, since device info is not known can not use netdev_ or de=
v_
> dbg family. pr_debug() is an option but that will require DYNAMIC_DEBUG
> and then ath12k needs to be probed with dyndbg=3D+p which we don't want i=
n
> ath. Hence, only option left is to use printk() directly.
>
The issue seems to be resolved. Thanks a lot !

Tested-by: Nicolas Escande <nico.escande@gmail.com>
Tested-on: WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1.97421.5

