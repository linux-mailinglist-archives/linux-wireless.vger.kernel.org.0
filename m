Return-Path: <linux-wireless+bounces-12216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD17964EBD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 21:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE3B1F21380
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 19:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A03AC28;
	Thu, 29 Aug 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHk4R0Mc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F71B3B3B
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959438; cv=none; b=uAHMiS7WsqxsuBU4gRzYuKiSdh6R9YtPiqm1kNfwQtXNHpeHsCEJkPs1Xja1kG2UEU/hxqFmTu7mUbkTVp4rbUDgERrVeMrXvaiAMN3zWzP+pBEk6+d9rKs9aFJXXqahsWFkErEfeR2SF+LuzWU7an7kxvQEcnKiozwQbRNkUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959438; c=relaxed/simple;
	bh=u2kSpaqBhHX//FJbyTIP3K05Rb9NQAxpVzeK0AhOri8=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:To:
	 In-Reply-To:Message-Id; b=LoMbLBiSFghTeB+SUMIbqvjqWF7PtJEyLnCI69Z1CI8pnbBlJ2H6dEOxuZkwTgWu+2vO+euRV+PPtuQ2l6L2knkXm3XHNemdrjOoDFQwdraM+WtQMwxKkX4vOHIqDyt+cHeQzJ+Ry67xvzoZIuH5JxXSINGpUbRESy6Uk8CpteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHk4R0Mc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8684c31c60so127980966b.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724959435; x=1725564235; darn=vger.kernel.org;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO4tnhwrrZCUlUncuULn09iYvhoNuJlaZiOhTGhRhiM=;
        b=WHk4R0Mc4h05VMNEsKQBX1cRR5r9OjdElgDbRevw2fDrx5Sg59a3wKhtFfVYuVLUU3
         8OpKAdnN2EuzhFAVD/yLq7JArV5u04PPmIpWcJf2Zw/xmueM2Lf719j49hgWIzN3kFDD
         gF7TNz3c24144pfOT93zCLAPrvWpYxomaB217ITMMRg46Jhyk7BRhBivM0LiuHbopmM9
         q/u9vZNjhMOIrZnJG4k6H2SK/q+MtxHfzAwr26QdHTIJa1tQcFwjXF5EYzCyQAyVTKVl
         xkYWUtEKTvQ/Vomex+A8Lrkz5z9PLPH6HbeVXE/GgNSECR2Orrh7J40afbFquysnS6l2
         ZdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959435; x=1725564235;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO4tnhwrrZCUlUncuULn09iYvhoNuJlaZiOhTGhRhiM=;
        b=o0MNfm9EFCqVYcNQxF1Z+x0RjCLU/42G+ZflVrtOsYC0KYdRc44DION/VcfkE+c+5P
         u4BHuht0mfAsLLx8pWKZTegQxcaqIUItug41olPKL9NcToKBoTRLADxYq3FFZtPweQQy
         Qjru2Elr+5C43VLdI+5VDDtzRyzpTXxWPJdPST+LqmJwdR6vn12KWnf5wYYx7eu6N8b/
         6i0oZqvgcWIzs0bZfOhmiEuggyi+akheJVowAr3BpY2qL1pJCjdkXjRp1MtTFt+xm9gd
         hCr4hh5rVP5BbELozhXQqUKQNHjQf0LT4ZD+Z+h/0OBeK89KyxYC8S7DaMtGWQWn1LJh
         /iQw==
X-Gm-Message-State: AOJu0Yx3yG0P9onvE/FTQ7rTSIzjLFVvkOIBswscf8dUbmRBJ4j9/v6M
	hFUguK9lLRqRKncqs4uNrNZjRBJKS+qmCQdKIrW0qZbvrBlebQkh62/mZFvQ
X-Google-Smtp-Source: AGHT+IFrr2ntqAENac/6XVIFUU1Ud/2BKbtwczjOXD0udOpZO6Uf9qnlsIzCFoLCSw94B1geG0vhDw==
X-Received: by 2002:a17:907:ea3:b0:a86:ad4e:c468 with SMTP id a640c23a62f3a-a897fad4ee1mr368855666b.58.1724959434764;
        Thu, 29 Aug 2024 12:23:54 -0700 (PDT)
Received: from smtpclient.apple ([169.224.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb453sm111315666b.36.2024.08.29.12.23.53
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 12:23:54 -0700 (PDT)
From: MOHAMMAD RASIM <mohammad.rasim96@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [question] is it possible to enable monitor mode /packet
 injection on wcn3990
Date: Thu, 29 Aug 2024 22:23:42 +0300
References: <CACq04CG8WCGDxf6Krx3bjxHU5OtYJJNOtD77TtPQhTfdy6ey_g@mail.gmail.com>
 <56BBE89F-FF40-47C4-A4B9-F492FD8F6E2A@gmail.com>
To: linux-wireless@vger.kernel.org
In-Reply-To: <56BBE89F-FF40-47C4-A4B9-F492FD8F6E2A@gmail.com>
Message-Id: <8117B84C-5C0F-4005-9738-9F8249A0E31C@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)



> On 11 Aug 2024, at 8:30=E2=80=AFPM, MOHAMMAD RASIM =
<mohammad.rasim96@gmail.com> wrote:
>=20
> Hi,
> I have a device that has the wcn3990 wifi chip that uses the =
ath10k_snoc driver, i tried to put it in monitor mode, the "set monitor" =
mode command succeed but can't get any scanning working after that, does =
the chip support such mode?has anyone tried monitor mode with this chip =
or other snoc chips?
>=20
> Regards

 So after testing and following this: =
https://gitlab.com/sdm845-mainline/linux/-/issues/45#note_2073028221

It seems it is possible but unstable, I was able to capture some traffic =
one time only, after that every time I try to capture in raw mode the =
firmware crashes or fails to load some file like board-2.bin


[  440.761935] ath10k_snoc 18800000.wifi: failed to fetch board data for =
bus=3Dsnoc,qmi-board-id=3D0,qmi-chip-id=3D0 from =
ath10k/WCN3990/hw1.0/board-2.bin
[  440.762047] ath10k_snoc 18800000.wifi: failed to find board file fw =
entry
[  440.762059] ath10k_snoc 18800000.wifi: failed to fetch board-2.bin or =
board.bin from ath10k/WCN3990/hw1.0


