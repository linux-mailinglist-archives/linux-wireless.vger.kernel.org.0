Return-Path: <linux-wireless+bounces-25452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3452B054BF
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 10:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27311C2242F
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29552750FE;
	Tue, 15 Jul 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bspwxBR9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D525F973;
	Tue, 15 Jul 2025 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567764; cv=none; b=kRn3My/YxLs9/1UiaSAYDLIsUVrXVBvXJlUqOOM5RMQCfSrB7uxrWXJ7ak2SwmwM5ISzRtLrt7WTLM5B4LpAh4mtG+tM3ESpiWuBxZ/HVgnlINnbrhYPOuBnQVwd3joEDFU43b1niMDWSCEKxJb3GL2KG1tywHgpTFJWoxmF8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567764; c=relaxed/simple;
	bh=VjluknFr6jvR1YI6PssGkDBtJIyFCraV9vOniDFlvL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzf3/s+3j2FR2oXSl+/d32JoVm2WrHviP+rZC/yemH0iwLi5SdGBZrDm8yGT12c1w5eWjDEXjkH+cYA1A7sQzletveDe86/5jX398XhqS4NPZiXNNhABIOx4M4kjThnQ16B0rh1OC/8BJCs52t+ii/8G0QKzazu6/ClFPlGu6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bspwxBR9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31d578e774so5190513a12.1;
        Tue, 15 Jul 2025 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752567763; x=1753172563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWritYCN5g5pbGNVdS7uOitde6lUvDNW8r61mTT/h1I=;
        b=bspwxBR9d4opTLmUEFFAEqAbi2B5ZGIaAep3CyNboz871SggHtoR5gR63uUaFKUtBj
         7mv+xjmOxG6m49pz5O1I+/jQLc/PY60G9ww1f6Wzm86kftFuriN4z+4qtZVJb1qMt19j
         kwUjtKuiPjFgxjoYxnlQZS9qCDo8h3qLWbVww385crYGz2gG7atRJnEercDOAqz/8PHQ
         btqSanWnyT1hD/oWqftmjn+IiVpEKLLK/iuwMTs1mdgcfd1TmLGdeFsEyOTEGxwmpLkQ
         cbB5XE2UjTWl/cJdCzQaMtvBSFvZg8wV7AKuvPM848Yfsn2Bk4kH6nT36XE3PpPR0aM/
         WAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752567763; x=1753172563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWritYCN5g5pbGNVdS7uOitde6lUvDNW8r61mTT/h1I=;
        b=bblYw4lsHvfL/NnpsQbzxNQMJph6pIGFFqWFgFCudSOz5uWn+hbmTGHjk7o3QYXN6l
         3d2FIKpBHGfnCAUO4BkyX+INtTG4euJfbStvdSKcSCzjJMCcJEn3rHUUW/rtN8rvStLf
         YUwEWh9Vv9W8HxHMWbbD0MCk2BDhOCbtiCWdE68X4TAteRN7F0Ft/ulnbK4ai+LzoyVW
         mcxU11dua5WsgErnl+TVhqYKtBv2llb84ih0eprbkjnEhlSM2nUteMrfZsr2fa9fBXMe
         8/G6lRtdwPpB10ZTNN/cdek61ZuDimeHR3+OUdxiqSDOB2t/B00meCiSbFyVd/ocdo4/
         Ovbw==
X-Forwarded-Encrypted: i=1; AJvYcCUxkuatSRRaEK3C2MchDnTJjrQCm/A7bRU9z3FJ+Uy79OHMgGhvqJW1Y6gVJgBu4hbcgD2brCSerOyBAw==@vger.kernel.org, AJvYcCWpUjHAC7nMzAgjQbyip14BgkemgOoHYNsQvafgoFl4S1j8+y3cucVHtXfJgkGC/YETvyRhLGmKBH3b@vger.kernel.org, AJvYcCXYS5Dpf8cEZXvFAOp5svvdddh2gRa5FBJgZiV1/qyt6KttUZhPse//bkdugnKAEKG+9XBWak+QCPAODBXx@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUv2Fbf37MF8plwqThekkdo2X4GIYe9rFg7y5JeL4r1Z1jN0Z
	WemtzV8p4z4/98J8XHrtiSHSwDc15EWKL052UhbPo1dFQWkCEqIoIDXUsk80N0lVcP9vUGM9v8v
	LzmqXDAZClGZ7FQJG7CSlxbDJhp1B7rc=
X-Gm-Gg: ASbGncsWZDH5Kcid6C9h54iRuggy9FyCImEXBgaIek7yJ6qVevIe1RoG2NIUMTM5Ngf
	wvrStzESFRvsFSew0kRlOOfdDiDBz5wcH88fFJyOYilfXkCSpleizfEPSHC02FhSfWVOtA7RyXr
	eAY85xska6OIp9ImHd5Kx0/NO6f7BlfYokRYhtwF+YwFGuNoxv2nGGNx8AqWMQFRSShGHZNHn1r
	Oc/
X-Google-Smtp-Source: AGHT+IFMxGCTEEHrdB/kCBZaEP2hviqLVU3pJ2QVRJLd/x1wtIgr5OBebZnjJManRyxnm1Ft0Bmiw8ilHs47bZtO0xI=
X-Received: by 2002:a17:90b:17ca:b0:30a:3e8e:ea30 with SMTP id
 98e67ed59e1d1-31c8f9ba0f7mr4109857a91.11.1752567762558; Tue, 15 Jul 2025
 01:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712210448.429318-1-rosenp@gmail.com> <20250712210448.429318-7-rosenp@gmail.com>
In-Reply-To: <20250712210448.429318-7-rosenp@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Tue, 15 Jul 2025 10:22:31 +0200
X-Gm-Features: Ac12FXwMmQCfsqg5mbExKPqdb145bDccah5wrkdnBfsA3tKTWDoudoBn9JT36WU
Message-ID: <CAMhs-H_w9f334A-T5OfbngCZ4bgM+uJ27WAff2Q+k9dJhHr96w@mail.gmail.com>
Subject: Re: [PATCHv4 wireless-next 6/7] MIPS: dts: ralink: mt7620a: add wifi
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 11:06=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> MT7620A devices all contain a wifi device as part of the SOC. Add it
> here to get it working.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  arch/mips/boot/dts/ralink/mt7620a.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

