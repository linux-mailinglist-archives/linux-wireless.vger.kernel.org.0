Return-Path: <linux-wireless+bounces-8138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69678D0952
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A4F1F21F0B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234361FCC;
	Mon, 27 May 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/5IZP2p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D017E8FB
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716830737; cv=none; b=g5atfvIgnfzO2KSWneynLUhn9h7RUjgZtegUKQDwOyv02jyEYUZUdsXFdStSeBEI5FZxSR4OrtULdaMB/qqnsXvoJaFWrxzHI9jLSLFwoUBYtZVaBqsgYXL0n90/gE4r+OOY22JEu9/v3+SXCUCwGFmP1KBigSvq0n0vhddUsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716830737; c=relaxed/simple;
	bh=M80gnXNyU0K0H1n5gSTYhphcy8g5UqLnLOByeU9sRW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jjYX8rPGA+hnKKU6BXuZ/o4I4d2VjO8dHjJq20Y47+52lDeQKQmO8d6bkC/duyXIWZaPmnbCC08dlIdpU5lEjMucMD/jFDWPmWpMsC3n6VSC19zlYCDCKLSNL6/G+2jyKUCL+XkVxffqaHRQaD0kFjmXiu1uovmfHA/d5vb9/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/5IZP2p; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6265d47c61so3338966b.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716830735; x=1717435535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xumF45D8+wn1dC4xNeYTL4Ch7JGJzVQke69iwN7nD/w=;
        b=c/5IZP2pZ54qdA0lqMGoch0uUYUS8eCyLyghbGigEo1NBH2alrROvxdsJrLm52SMze
         e91VZuthBuG4Uzet5bFQ1f41I3scvrI71GcZf5uJgkpLMfTbopTGAd0UoC9J/3MUOhZU
         /A9wr8K6mV98mOV8xTfOai84ekIBnPl0pmwKfo/J87IUqc5Y6+fFEVCdSjhfo695CgoV
         RVJBzE6Fv9Anj9bUbzANMe/gyVYCVJtgZg0uRx4TObbD+Cp6GsT5wQtY9t549sDljb+y
         xgVexBVTpTC5SQIKEJAEMDCcy9eiT7acbAs9jxE1DfS7oQ183ClxpTLXsSdoko05bkiv
         yMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716830735; x=1717435535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xumF45D8+wn1dC4xNeYTL4Ch7JGJzVQke69iwN7nD/w=;
        b=qfIzSgwL3SaKb+TSRrcjNmzpSG/oTD1bIADOfqZJjf+aOAyZ3cJ9f+kCJfQ30SWeaQ
         TXCIV72cwoWZNPNv7FUHbxfBa+537qh9THSEyU1k8CZf0sNufhWlIGkDrXhpvjCd5zaL
         bD8Kaz6Vxl66IfkJY5cm/ol0O2xoFxa+UMxAygNuV1F58oNRSvHyyBJjsfhxa8CFSsxH
         zGlgugaOeqNKN27YPWzH+tNlHUBfTCqJFiXE+xsbJ3amsyP6Fz6B9k9ByENIfWDgdmXz
         owwI1N2jZswwD6iUhgARfw0E2IUg+/0TJ6/dODELxq6McOVdvgjnhreJCpBWNtBm50Bo
         81jw==
X-Forwarded-Encrypted: i=1; AJvYcCVz7vKXhDlu+FYMUw2Tpj7HGaYvGHi1r+8RATS0E+aEpYgrBKcqc5WccOBCcwkFlT/23D0HhleUu5t8ekSPbizGsQai6kmwVynd3peamJY=
X-Gm-Message-State: AOJu0Yz/WYPKTyuwjSbJo349HRdYH2Ecnc/w6P3Mm5D9zmVuOwSUqC3+
	iTE3m35tTjhL4HS58K/h1qVRkp8X7Jc2Qf//cJ8x5l+RzShDX9+f/KvSHA==
X-Google-Smtp-Source: AGHT+IHzXGeAuYHalkhmUI6m0Prdjz5R0L8RRz9jGaCq72p1zMkrQtmMMldAwUZtFZ8dbwQgjOrzew==
X-Received: by 2002:a17:906:a894:b0:a59:b376:87b3 with SMTP id a640c23a62f3a-a6264f15c5cmr645076866b.62.1716830734556;
        Mon, 27 May 2024 10:25:34 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c937b92sm508960866b.68.2024.05.27.10.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 10:25:34 -0700 (PDT)
Message-ID: <65f47303-3ce0-44ab-8f06-2b2008847f26@gmail.com>
Date: Mon, 27 May 2024 20:25:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] rtw88: "rfe 3 isn't supported" on rtw_8812au
To: Luis Mita <luis@luismita.com>, linux-wireless@vger.kernel.org
References: <9f4e6ffc-fd82-4404-9009-c784aa3b2ab7@luismita.com>
 <1e2b1996-26aa-426e-bece-ac74e8d47660@luismita.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <1e2b1996-26aa-426e-bece-ac74e8d47660@luismita.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/05/2024 17:33, Luis Mita wrote:
> Hi,
> 
> My adapter TP-Link Archer T4UHP doesn't work with the new rtw_8812au driver. Looks like the driver is new, and i'm happy to help testing.
> 

Hi, Luis.

The driver is so new that it's too soon to test it with
RTL8812AU. I am aware that RFE 3 is not supported yet.
It will be supported later.

