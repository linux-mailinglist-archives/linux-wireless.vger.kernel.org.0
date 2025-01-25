Return-Path: <linux-wireless+bounces-17926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C240A1C35A
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 13:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334EB3A4810
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FA81FC7C3;
	Sat, 25 Jan 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grQb/IVm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488AC1E505
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737809608; cv=none; b=jU+kyU9cgA04AGoZM/xaeBcAIktANhbAmW67Q9GJ+wpGfgn3byChGTlpB/3oARxJWkkpOeJTI5p5HTgekI/BkgkSMZL0nVS2kSjsE55V7ZZmI7Ahv7IB3bOfdsrGWJgSt1Bc/AEHfnEQNiEb7pyAjWuvYY/OY7Fnn/cbQnicTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737809608; c=relaxed/simple;
	bh=M61a34kKlEg5QT0HEXXhjHlURONEKRDdfiaoaXCTFo8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Y3FxN8eOdiNlI9hK0nPyQ8Q+Vu8U6ccDZuJSoh9/KF6Tu60FbIGK57fk8QGL9JzC4Bz1Y7NlsFZik92GvPRWiZWGxBNMRX16fL1X1z0OKOnH4KVe6Ir4VNTLt/dZxAPbm6cAp5YBRbHIiGMI/8Gxjdn1+09Ld4PVJrm7Ty9QnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grQb/IVm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso19717495e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 04:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737809605; x=1738414405; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oq7ctNv7WRh8aRjMa8ewGwhH8PakEiEHJeSEQxxeP0M=;
        b=grQb/IVmU1rX0oaD+vr3IBdTwxpVZXizb0bGMbaIVXIPavUXUg6QiolrsnxloHWU9P
         ov+wI1bh1/2v5wNvqnTkvUaamHABB5oQRK2MIGfO2y2Xh5/ZHD/4ouHQJRNQsOmnEGSy
         CsQNLTwEjEdwBo4gQGMuja3wsQ6zZsMX90RFCgFlad8LZmebYc/bIrOG5JC1WcMZawPk
         B5liUFtGU0aP35ei0kqNtmD3Yqg8WQwEWys/zJZZ7DMCSW3GH9Z156Qy1dlETCiPQJCM
         5R1swGajiN7HDqx2T8DKiXgXUHm7ajCJenJEseClxbpgVBvYVnEu/i/+4w20Og2ALLAe
         eEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737809605; x=1738414405;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oq7ctNv7WRh8aRjMa8ewGwhH8PakEiEHJeSEQxxeP0M=;
        b=OhKxhq3VP0RVrJHdQiHHDSCdF2TB2wl4zdyq1WZwIAu1q0L6zDFBrrJtD2igSWMDEv
         NiELcw7TWTCbxW9pu7j7AyrBqWTUq4mZGWhnLNQD2vLc3DCy00JXksFdz6gclSYjbvmP
         wqIpvQ7bAI+CEF6SpGzh7yInEHGqKVMjHH53js5LY+4gRG8H9YxzNJfUvvZpXw2+hJag
         81Nzq3eSL+Eb6mfETCvWLDcaYZpCowqPkvTtU+QpEkGGaA3Vxw5vdlQHv9O0u11IzJOB
         luImDJGO5yM7GyVGYZX4Brc7WlKM7zRztnEvZ+EIabQCQint7KKecDbfq8InCAsHBEzY
         XeWw==
X-Gm-Message-State: AOJu0YzINfI040I+3Yq7BwV28o8mGi22r9YTTTDFG+0r5B5BBWM37fHL
	VzPE9pTDBhFZvP7DKh6KWB8Cg1dH0Wj7feoIO/9/IyC2RE+xrIwQUq2lVg==
X-Gm-Gg: ASbGncsJOpXYtB2P8cjdQXIj1o7JDDdpLg3OTzAmR4SVvy8QhF9Fi/3eJIodo1AREHH
	A798+ZB9gvHbhPxxV24aMj/Ae3iVWu8bkXdwTFXauD87NRrzwlY5DLCLT1dnH/lJEEvzkZGLR/s
	EIc8pVlDtn0hdQEn+WbLuBGhi4GkCCYXr9ab2phUon56/Ik29RycFMHa7XZfV0o9zByjMmFtXTj
	IW4AfAlf/JtV2kglB4XHxD6tHIKnw7Dm3NQiN1AwT068f2MyjsyNyxHY5trDp86UhWxZQgH3htz
	C9uhz2Tu9gjnve6VZl0b0cY=
X-Google-Smtp-Source: AGHT+IGpZlYjAhnB2sYvAKX+xEq7wEQ/Ia15OynTfoYEjxUZ6U3BSuGxPYdYzjNjz4G7N3JatGX3Dg==
X-Received: by 2002:a05:600c:35cf:b0:436:1be4:c9b4 with SMTP id 5b1f17b1804b1-4389143698amr279621295e9.27.1737809605237;
        Sat, 25 Jan 2025 04:53:25 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b1da8d4asm69237805e9.3.2025.01.25.04.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 04:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jan 2025 13:53:22 +0100
Message-Id: <D7B63ACJOYD0.1XBZ5VB991KOW@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fbx: fix
 ath12k_hal_tx_cmd_ext_desc_setup() info1 override
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250124113352.93638-1-nico.escande@gmail.com>
 <a979cbc5-5cfe-160d-d5b9-9e5ed7513ed1@quicinc.com>
In-Reply-To: <a979cbc5-5cfe-160d-d5b9-9e5ed7513ed1@quicinc.com>

On Fri Jan 24, 2025 at 4:31 PM CET, Karthikeyan Periyasamy wrote:
> On 1/24/2025 5:03 PM, Nicolas Escande wrote:
>> Since inception there is an obvious typo laying around in
>> ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding
>> flags to tcl_ext_cmd->info1, we initialize + override. This is needed to
>> make broadcast frames work with ethernet encapsulation.
>>=20
>
> SUPPORTS_TX_ENCAP_OFFLOAD not yet advertised by ath12k. How it work with=
=20
> ethernet encapsulation ?

Yes indeed, I made a small patch that adds the right hw features via a modu=
le
param like one of your CLO patches did:

+       if (ath12k_frame_mode =3D=3D ATH12K_HW_TXRX_ETHERNET) {
+               ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+               ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
+       }
+

But maybe as this feature is not yet enabled upstream I need remove the fix=
es
tag ? After all It seems that in native wifi this bug causes no harm...

