Return-Path: <linux-wireless+bounces-10432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D96938DED
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 13:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3B41F21B82
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F731EB56;
	Mon, 22 Jul 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvqvjMMs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425823DE
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646454; cv=none; b=DVzgGAB2PYc6QGEaO8dUjNbNhug1zpQAtH6WVQIpwkFfq2Z4Fu/P211R7D+juim/25dskxLVxJb7Q6fyinZW2qoJFBM2sFIlwBatQ+RQf0C4pKIs4V8z2/oP66FwTdAZ2OTjrkXJe/3KndfVAV8I0b3kxyJZ5dQUUDYdbwCEcbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646454; c=relaxed/simple;
	bh=f1pxP8nMm6dmumKDmIYGhLPcOUYKAskzzXx72HrNDPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sybrnep5VbN9t9nwar4O4WyaQBsScY03Xr2Qdc92V4xUCgJxSWo60o9vw2i/IN5Za0Oc/U1DzqRvKqbOV2cKdVhLaHeOs8t5VQjMNUEyoL+ND9QL1H+2OEKClmq16k5FXh5/vebNMdCRWS7TssIo4FL6xSs5YJiJgnkYGHp1hz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvqvjMMs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77baa87743so434979866b.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721646452; x=1722251252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMVMPyN1mrPCgy/B/XwHjm2akhZzPBYAUj6M5ftc60Y=;
        b=EvqvjMMsDDwC/xbj9ktvWm/cGC6wf8TI2aCO7cK2kkpsSw2g+aIy7vYx541qlTDHye
         vRwIEVwssMw++bsn8JljtfJbQ5tSNA1lc1Jezk5QssKnuP5hi9y/A0YURDQLo4Osiumq
         EsnaWLL7m7N5nl75Zpne9i41pl1KU8sHb00iYAANcJiwC3GFmQNaSHiWQ6fEcvNxe/rO
         zWHaJnHahWkraBMV/3hAummlVfNn3ysja6j18LImOoiZzoPHccPZEfjVx4GoD5CC4Y8p
         hT21SRDyP0tkKmnmdKqmBfLK8DfpSvgmxvveVo9ZPdXlOGRUljiOElPoytcTeuPF622x
         0NGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721646452; x=1722251252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMVMPyN1mrPCgy/B/XwHjm2akhZzPBYAUj6M5ftc60Y=;
        b=Qht7DZ0eOI1zyoqEmzpUYCQF2kA8bsrFq6iBWpAQbKkp/9N0nX8MNTBOUMt0ihjOZ0
         yUqWtheLhKVhBNdGio57y8rv4VtbZfczaiVRlTL9FxptI1Ny0I7koRrNNJ0rGiSkp4/C
         Kdu0AApmLn9ZUUijrvP2ip7yITaU6sOLkoh+Km+0Pf09789qUzveOO/YbXtSCM6eazLY
         krav4cmeVqr8yyGhEkslTrw0oRiyZgjXDIXkLtmuZGGLC4/lQvjtafc0L+DJ9Z35rPw6
         tnGfQoyQWwRA1u1jk2jnevOHuNblFJNzip1JbW/ZCekRtxO0xs+nehij2fS6ebIiwmEl
         gDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/5hvQu26kor2fSe04m8IcDrExUMcY8GnXZVH+ovTBttYXVIoy5Vz2YiFVvvWmXQr3QrMMKoMXk/AWIDiR4VnJMJukbwNfbY7m9Mv5PWs=
X-Gm-Message-State: AOJu0YyoqjcjtaRM86WwcegzUnyUMtl3nQ69CVW59D9HsDDzwa32qtyV
	ODO30zFxyHMUSOCZxsGLJolD4cAsJM1v4XvCvCjArD/7uTN7wQ79U2/85w==
X-Google-Smtp-Source: AGHT+IH8gVVldKH2Akjg//sFtRiHmDj9MlpyO+ULrPHqPB7ibt8V5UnUMr2pmdJZ7ox0sFzXebJMdw==
X-Received: by 2002:a17:907:3e1a:b0:a7a:1273:bc63 with SMTP id a640c23a62f3a-a7a4bd0a711mr499066866b.0.1721646451485;
        Mon, 22 Jul 2024 04:07:31 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c785d16sm410392266b.1.2024.07.22.04.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 04:07:31 -0700 (PDT)
Message-ID: <bb7f5d98-1b9c-4235-b3b3-1f7da36d3e8d@gmail.com>
Date: Mon, 22 Jul 2024 14:07:29 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: rtw88: 8703b: Fix reported RX band width
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Fiona Klute <fiona.klute@gmx.de>
References: <2fbacb83-3e47-4f37-a70a-fb9f4719eb26@gmail.com>
 <712d08e3-fc90-48ad-bb61-bb601b2cf953@gmail.com>
 <aac7a0fa33fc4593bc291b2c9c800519@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <aac7a0fa33fc4593bc291b2c9c800519@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 06:39, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> The definition of GET_RX_DESC_BW is incorrect. Fix it according to the
>> GET_RX_STATUS_DESC_BW_8703B macro from the official driver.
>>
>> Tested only with RTL8812AU, which uses the same bits.
>>
>> Cc: stable@vger.kernel.org
> 
> Add a Fixes tag? as well as patch 1/2. 
> Otherwise looks good to me. 
> 
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> 

Done.

By the way, there is another problem with the RX rate: rtw88
doesn't report if short guard interval was used. The older
chips like RTL8703B have the sgi_en bit in the PHY status
struct, but I couldn't find out how the newer chips do it.

