Return-Path: <linux-wireless+bounces-18082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D961A210A4
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527043A9004
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14901DE897;
	Tue, 28 Jan 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTFb/tRf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8601DE4E7
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088201; cv=none; b=CMv2/q2ZpfgOXwYvYFSe6vxL4DaevGAB8uFp7Ik+eaupVn+NiSJT4a3s1AQWwC0M7sDJnH3viCWeHfhFoI1HP2vpv9/Y1bqvssK/IqsOMZBEYgSqkiRlnFzVX/UR4UQBbo0jciklmIvgg+CVeiO6qn5fbO56Hl6fFRE28CYtT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088201; c=relaxed/simple;
	bh=/gdYxyTaY8qCOH1708oQ7YymbUCsHsfxi1qZdyn1g4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIWgzghWmMutbgR/jd6zomKHsHTCNik5lp16VfuYjEWvkwKdsHrnI9U1KyNtZhh5qmsUtMxfMG7TiYgm5BTNSk+rhQ63v8aAo8Dpxy6SrTrnFSFtWsfJ9S4jTBs1pUH9UfV6nL+fuq6TgFkLu33OFRCwrOWL8T2jR6wVnUTujBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTFb/tRf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso11378198a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 10:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738088198; x=1738692998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gdYxyTaY8qCOH1708oQ7YymbUCsHsfxi1qZdyn1g4A=;
        b=dTFb/tRfmfgcuSznGNhpYEB9UwB8riJ2m+y3rg6J3Fx+Ojd0uYstg98G8asIzoY3oF
         p9cqnhRK7sJOUtmywPOoSiYqhUUhhegP+RbR6AkE+/76ihTGtD9/zEKC10vfn9WBU7vE
         fFFFTl9K2fuiUctVRdhsyp3QO+Zne1qKNu35IMQNtgoLWj5gidX/xKGg1P50qA6JNiyL
         HID3emiri5/+jr8bWp9qQEYmRvHX+ySL7x5rwn3IOFf1r5QOhqeakCgk+n1zE5Ww29lz
         kQhVIYGIV3ngF9YJNvXG8mIMAH/AZk7cdyFwn2ctu2kEPWezuWZqJMmpAdq6bbnXodzM
         hNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738088198; x=1738692998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gdYxyTaY8qCOH1708oQ7YymbUCsHsfxi1qZdyn1g4A=;
        b=UeBt/2BQzevZO1c9ajIeo0BxbWTqqgntVuRsr7NH3fgfkjGkg/8o5kqDlcFl09SUtH
         ak4UHkcJgWtN0HvF+Fy9MrugL/siGT4c1VTioGJpTLucoFY86xYiZCcBhDXGgslVQr06
         PrN1DTxcRQOemCs49NWiuoBCwW7rbR4wY9xUaata1gL6BtHQWH/pu3U6pqso334YJpml
         8IX2x4WmikTVB8OacHuUaD2V6KXW62E59x1rPlnQ/7U5nOiWZtTf2I1syJozp5AIbf+h
         rPbKtDzcHfFZkK3ZVscPTF+Bj+u16IAhG7dVweV5MCQ7DLf5iKVKdaHsDByKYcrlVg6I
         hbXg==
X-Forwarded-Encrypted: i=1; AJvYcCWSGz9ADwtJWWxNvbztVDI7OdsaDKmF7IA4ziY2Wuhem/+YBaH7cyRMI4ETo5VYGJpvSRf2AL6dFYdLlabJCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCp1QrR6OSbs9kZMijQPzczh3zJCIF0I73THHQUYh0qikDIDZQ
	Xi9rLjoSmA/m8Q2y/KO4/vGZV6HCQQ8+z5bj8cqrnzh/jP9pjum0COvtkThKwKFDuYlJlzzfOmM
	t+pgbZoVIfUZbK9a5v4uTFC1eyDSnHptj2VOc
X-Gm-Gg: ASbGncvXOnIhdAbEfLDKmy6qg1tOZUl/HM+t3oecIANPJM3Rg4OQRG5nYP4Qm2NFFV+
	XATHLyLgNnp8lx0r+4rEZyn4nRQkDpSdgfu/ftouu/dAnkCTerQNNtayPBzoBHaY3bzAJAP21
X-Google-Smtp-Source: AGHT+IHPyj7nen7zqUYkCfQpUEFeli0xsn27CRLP/mWc7vAijDMAc5LwSGwKtfQBm9tcgaOuwxfnFvZ08xc0EKvhrF8=
X-Received: by 2002:a05:6402:218a:b0:5dc:51bd:4419 with SMTP id
 4fb4d7f45d1cf-5dc51bd44bfmr3676934a12.16.1738088198089; Tue, 28 Jan 2025
 10:16:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c1ae9e062164e101@google.com> <6789d55f.050a0220.20d369.004e.GAE@google.com>
 <CANn89iJiQeF=7g0wFVOZ=TMUnL-7U0xvw4ZQL5H5f4+ChBp__w@mail.gmail.com> <CANp29Y6MrxrKSAWx_Hqk1_mWBSWwKy39-Z_BDK09_FW3VJfF2Q@mail.gmail.com>
In-Reply-To: <CANp29Y6MrxrKSAWx_Hqk1_mWBSWwKy39-Z_BDK09_FW3VJfF2Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Jan 2025 19:16:27 +0100
X-Gm-Features: AWEUYZlupF_TGX63hSG7PsmRz41KCY_dVXk6ZEh7qUAyGy2noybsM7vvFFQMA5w
Message-ID: <CANn89iLFSb=aX1VcwfC1yPGDWRHNKVhnsdg4_rntox6ErgT2fw@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_remove_interfaces
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com>, 
	davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 7:13=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
> Hi Eric,
>
>
> Could you please share what's the current situation with the fix?
> The bug unfortunately keeps on stalling the fuzzing on syzbot by
> causing 70+% of all daily crashes.

I think I am going to send a revert for the net tree, and revisit this
stuff for the next cycle.

