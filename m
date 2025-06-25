Return-Path: <linux-wireless+bounces-24489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E8AE8906
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40CA176760
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37EF1CAA92;
	Wed, 25 Jun 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TycmM7vT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6A13A41F;
	Wed, 25 Jun 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867272; cv=none; b=qqsQjTybwVanLlvqTQ/YYf2NwZO0vpw1jS+M1cE9g2QV4hwWi+pH2ZvWMErL9JUGWJE3RcC40fdESFPlwTCILwb83SFoNYtVs0dfHKsUNqg5tlkmYiPVrdL0W6lDcVU2tYyhHqeb1JdZM0tpSOfMaFY1FGGnbo1X8uX94QRBXHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867272; c=relaxed/simple;
	bh=/D5rIUSTwuJl0dxAecZEAjFt2HT9/QBw7u1edislyBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cD1IqsTvb4k9kgX1oT3gWUIJjt9bVanYxAtAYnCk4MDsK3T6/8FhNkYHsRj2GUYyDGPgMPjhfBGWrpa9U/S0g+H3zQxecmUsHca4Y3ORoN8tKgqxqRtd1ebbFUMzI7yzT4yRmHuiqvCC7kh7HQ4R1Jvsi37ozIg3lzlavkFaKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TycmM7vT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so4076563f8f.3;
        Wed, 25 Jun 2025 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867268; x=1751472068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JTEGaZTnsE+6V5g7hZ/rNVi0M0+RdUO5nDCrZs9OBI=;
        b=TycmM7vTrZi7uFy6FqS1ZYyLQ66+qV2Z6A1sXieHkUf0kmXBphNfApLyJdinoArvlp
         jDudtiz+bMziCShhYvDjUk1MQoYfwtYehK2i4EifzSTk6rTe2X1+JEMKq8cXo+s7YLgn
         YcNiIj2Bx5ppiyBReq4uzpoJqKgJG3VGJERDRhdYvmlAkNQ1ukanUvnGSDmGD3CNdS/D
         ib6SuizCFOGr1edS5BAoVgjkiBL7SPfMGoqt3Iz/FY2mYyFnQeHyHcIx/1I+2vqAse7f
         Wbc28CcKAAB2GJw7uey5Jl+32veu0IetkZ6z931SyIi2929q0XytJPujekwGgQkkP6Pz
         /u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867268; x=1751472068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JTEGaZTnsE+6V5g7hZ/rNVi0M0+RdUO5nDCrZs9OBI=;
        b=hsLCCkc/o2I3/BvuyOlQZluCBhWPK66A+DRJindZ1teeFd0BFdTf/INyYuCeu4Vvdc
         1ELiDPw932pJRkUpN/qXXfX0hb+jIggSaS4kF8jePNYPS828zI9Pvzp/GovLlrZMnIwc
         G3PiX8hvgG+ZmapftmwBnDrxE9pnPh5RoF+dS1azr4hiiS3RhUu/+PtEPHn4dISyTmVe
         tTOOO1UnSZa6g6gJghtcAHzza6jhIH8UIsrCR3s3uRCsdW5eeMAwwXR3zinTQBFiXZ0Y
         ZVEw3xL++Ibjjh6jIReeYUzn1qTdl95RS9YOVxVbmsFFUraWS2Rh0xM+flCTznMtW1cR
         jiIA==
X-Forwarded-Encrypted: i=1; AJvYcCUG+LOS/o1JEpbIz8Kw86XHAOrLHgRpe8Sx2X/vKAB/0Xr07ZEPPRWvoOo5X3/5BMXfRAtO98VnIhaTAYc=@vger.kernel.org, AJvYcCVb4bWQ6L+X6I5Etqb0MU2Jx+fbx58hkEQ5HRH0ZCVHchaxXtVEc1EBzjGHWjUZ0oK3/d68H7DfDqGqruVsmaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0QxFU15MDthxQz/5FKynO7YDRimiqYP6KqO2cGlRzCNxAj49S
	FTzj8tGeEs/nITdVqUSVPyTB9vPAfEk7sFxME7llYch5w1e/gNKWygG9
X-Gm-Gg: ASbGncsOGlIlYi0rvuiNFEdlSLp9sqoc0JGBGbH+16u/d/w3Awhtgm6U9Y0TCs7Bmfn
	Vr3dm/3Wr+2+HdA/E0GmB6+3NkK2uNVh1KBvgo6Q7yfwXu6PaRpZFGswwHHQzoebp9qq75tEsp6
	Cmm1EWYq6w1RikQsSZ9HGkcBwTiG9gqjCk7bfMKgptemNokwkBeO4ebtIYQJqIHnerSpd1hFn0M
	NszaPY3RsC6AGQMWYn0cPj2PWx39U61voucH9zd6AWxqZOwzC07c4WOR0neYx6TNw8P7+LPz2n/
	e+oZ+CGjC0jUFlP5cCpGphC1IcVtapHBdLTtrjs8/Uq2fGMWjNscsSCDRXcNHXle7c+B0w==
X-Google-Smtp-Source: AGHT+IFZPzUhJC0Qx+9U9jniWlrLEFsNlaQX47WmvD0WV9aIs2PghBG71nuQG7tIO6aueQgt18LGJw==
X-Received: by 2002:a5d:5848:0:b0:3a4:cf40:ff37 with SMTP id ffacd0b85a97d-3a6ed5b87d9mr3011034f8f.6.1750867267506;
        Wed, 25 Jun 2025 09:01:07 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80695efsm4816504f8f.40.2025.06.25.09.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 09:01:06 -0700 (PDT)
Message-ID: <bde434a6-68b8-4c5f-8ec0-6c41dd1b6558@gmail.com>
Date: Wed, 25 Jun 2025 19:01:04 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 linux-kernel@vger.kernel.org
References: <20250625142541.44795-1-yakoyoku@gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20250625142541.44795-1-yakoyoku@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2025 17:25, Martin Rodriguez Reboredo wrote:
> This is a MR to see if rtl8xxxu can be made to support P2P.
> 
> Theoretically this should be handled by mac80211 but it seems that
> drivers may have to take some extra steps depending on which device we
> are talking about. I know that this patch is so basic that it might be
> missing some H2C commands or similar for this to work on Realtek chips
> but I don't have the required knowledge for me to implement it, so if
> you know a place to read about I'll be glad to hear.
> 
> As of now only rtl8192ex devices have their P2P_CLIENT and P2P_GO wiphy
> interface modes ensured because those are the only ones I can test on
> my rtl8192eu card. The rest of chips have them set from what I've seen
> in a cursory Internet search, they might or might not work.
> 
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

So... does it work with your chip? How do we test?

