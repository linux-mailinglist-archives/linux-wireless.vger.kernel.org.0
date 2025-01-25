Return-Path: <linux-wireless+bounces-17937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B36A1C52A
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA4C87A11A1
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB98635F;
	Sat, 25 Jan 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkbOelS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED49134AC
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737836473; cv=none; b=HrAv7RVhVyvWBHoU2vTSrJ6YHRHrjsGfGlTDAQUDKZm+tnTEGY1IUJM+BERsp0tnaz68IhG9OXjQBn8aTgGaD/uozb/k5DsLJ7Kp/+P6oTiXXOIdG3DjMuLa8KB+tIYrZDlrsIMpOyCh6KbFeA0euepfw0C36r+cGWru7sMZjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737836473; c=relaxed/simple;
	bh=R3BB7SnZnjySkkUw4FGVCc3SBg6cAJipSL3AjzVPU+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Mf17AmcbfUYy2t3w8DQYh4CW2AgewCXGiORKO664zkCcIOQw68VHHYSw27WBt9qJh/dBF2XLYxCR+R5rcG6/oTFrH3x/F5OwS0QPhUzm4Hr1sl/kUeBWykpUlueZTldGIObQnqJXeXpjA7L5SdkHZd1wv50l6nZzo/FHStdmWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkbOelS0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43634b570c1so22475085e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 12:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737836470; x=1738441270; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leqKbwMt0mzH1Or8tB3mPpZm5imjxV6Xh5iC17lZK8s=;
        b=DkbOelS081lxGlwNh2tTM0Hr/yZ9ZjMMKynE3h8BuxJXrT2sMIImYjurprViYXn7ZK
         OwKu1kVgpxCm0uLTDF6ytGA5NM3BCcwYhs5u5kNkYpow09GXAtnNatPC6maEO2PaibF2
         xTZtQM/ZL5sU/wppLXn7f/CVATnpfSk7v5ooIAH7DHimwxaR6lv7nzK8b93dyMM44G4a
         /ntvDkV2JvfR7pH6Fsk5yCeEjFOLZCeV6CV/3OYn2CNjBo4Fk0eDXy1UmJAiV1Ng5oJE
         wB51m6LsyDc9E968/90dPdRGX6OI2y5PDSKpVNWH526+BULeW8o/IszDX+99RjowY8ED
         aCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737836470; x=1738441270;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=leqKbwMt0mzH1Or8tB3mPpZm5imjxV6Xh5iC17lZK8s=;
        b=XSB+3PyJOoJ014u//MQ3kUGJl5XadzmKLBU01j49UZYYSSHsY4CqQggrjI1LDn3mEB
         +tiKPObH0yB7vwC66eXAFOVbN2jn2fEr+pxJiIzT+rx8chiioToixuuQaPTr/U5JmWWX
         nVX3k9Gx10NVaeVtvCAO/YswPl8FxUYzYw0FgXpEyW8ZVPK8P7i/Y4Gjy3UjtsmYMwKQ
         /lCGq8qKz+87ln4DpUHYIbseK/f6w6jTmp/INCGvo6CxVV5FwLRBUjUcVqgW6Z70aNKn
         qZUSX27iF/UIvUcAgCQLD0JdSA+F1KrMZLwO/722xvOHzDSedQ0TDtXuNFbbB645O99L
         FubA==
X-Gm-Message-State: AOJu0Yy+wJqoIcPCcQvWFy1ENzE2Kgv6xXaX+JY3+RTHHW0nZAkc7gWt
	AzLS4EEoEbskTlKgRPO6y/3lzWe7ZpzNFwLzuaQ/dooX0OiNq+XceA4kNg==
X-Gm-Gg: ASbGncunuL9ymFHbtgtnGmQfVYcnZe7+AyUH/S+yj3LpGl6DofnjDHGRSBWlTT/AdgN
	ULBT51jFp45bchPEQhE6r4R3ZAn8eY09+AZqrFqeTHUphdRXXOAv6p7Negt4+SApilcUQVX6T3Z
	FfPS96PGVZrfM73nPcJGTN9bfRwdjDSbSe8xgYevUxUNysE+QSJidtSYwVGzsDu6riV2mSRZMq/
	s5XuWBlUPk1JGaLe4jCr+bqCfTk1+f1gbpZN1fkC8DgVvU7B/TScCc4zt8W2rpvIfuZ4Amx8W/H
	uDlVI1DvqhgmPQj/6v4lGWo=
X-Google-Smtp-Source: AGHT+IE3cfWRrTDOE3p9zhRsIFujk5JuftUkB3l5GtxOWc4aOKBxs7VMtSwBIX/9UabuFTogOWYj9w==
X-Received: by 2002:a5d:4f8f:0:b0:386:4a24:18f2 with SMTP id ffacd0b85a97d-38bf566f3d7mr27789430f8f.25.1737836469783;
        Sat, 25 Jan 2025 12:21:09 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c4199sm6245615f8f.89.2025.01.25.12.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 12:21:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jan 2025 21:21:08 +0100
Message-Id: <D7BFM42HW2NL.2IZS207VTCTJN@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fbx: fix
 ath12k_hal_tx_cmd_ext_desc_setup() info1 override
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Vasanthakumar Thiagarajan" <quic_vthiagar@quicinc.com>, "Karthikeyan
 Periyasamy" <quic_periyasa@quicinc.com>, <ath12k@lists.infradead.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250124113352.93638-1-nico.escande@gmail.com>
 <a979cbc5-5cfe-160d-d5b9-9e5ed7513ed1@quicinc.com>
 <D7B63ACJOYD0.1XBZ5VB991KOW@gmail.com>
 <18b47227-6b77-a029-2e80-04a0455ac091@quicinc.com>
In-Reply-To: <18b47227-6b77-a029-2e80-04a0455ac091@quicinc.com>

On Sat Jan 25, 2025 at 3:54 PM CET, Vasanthakumar Thiagarajan wrote:
>
>
> On 1/25/2025 6:23 PM, Nicolas Escande wrote:
>> On Fri Jan 24, 2025 at 4:31 PM CET, Karthikeyan Periyasamy wrote:
>>> On 1/24/2025 5:03 PM, Nicolas Escande wrote:
>>>> Since inception there is an obvious typo laying around in
>>>> ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding
>>>> flags to tcl_ext_cmd->info1, we initialize + override. This is needed =
to
>>>> make broadcast frames work with ethernet encapsulation.
>>>>
>>>
>>> SUPPORTS_TX_ENCAP_OFFLOAD not yet advertised by ath12k. How it work wit=
h
>>> ethernet encapsulation ?
>>=20
>> Yes indeed, I made a small patch that adds the right hw features via a m=
odule
>> param like one of your CLO patches did:
>>=20
>> +       if (ath12k_frame_mode =3D=3D ATH12K_HW_TXRX_ETHERNET) {
>> +               ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
>> +               ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
>> +       }
>> +
>>=20
>> But maybe as this feature is not yet enabled upstream I need remove the =
fixes
>> tag ? After all It seems that in native wifi this bug causes no harm...
>>=20
>
> That's right, also you may want to remove fbx prefix in the patch title
> as this change has nothing to do with any particular platform/hardware.
Yep indeed that fbx thing is an oversight on my part. I'll send an updated =
v2.

So You guys prefer I remove the fixes tag then ?

>
> Vasanth

