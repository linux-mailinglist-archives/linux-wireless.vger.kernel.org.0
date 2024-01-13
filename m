Return-Path: <linux-wireless+bounces-1876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4709D82CC93
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 13:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4362850DB
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 12:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA220DFF;
	Sat, 13 Jan 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI35a1KD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3D20DFE
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e6bf323b0so4708095e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 04:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705147729; x=1705752529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9HpI5hQ2clEneg+SdHX/19i0G2DQecxR+AL1tlJKZs=;
        b=TI35a1KD0eG2N+P8SmeYJi/VQXmqqFTzDzWAUAIp5Hq2SvXBYrV48m/PdCwfsf5PMN
         9jw6wU+AQLOxY3orlgldtrnfRuLajmEcIlSlBFV3PDDHnmcaXBSoivoI6ixMrMWEI683
         X1tAEVR0+CuGQmdaqsZiHf91coLb+ufaJ568h5WeexRCQkYvZS3dxf/eArY5G8nT2PB3
         +tujliGu+y8z5fmwYoEot7GCnpdv3HLo29PJJFDCZtbTVRW1DRHtXsx08L/pFQGpbpJR
         Ql1wVByZYMxY6X0fnrP4zMzgkYu9+yp7pn2WP2faYvI+xCPYMB3FBguNEqQF34QC0yeK
         hv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705147729; x=1705752529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9HpI5hQ2clEneg+SdHX/19i0G2DQecxR+AL1tlJKZs=;
        b=IFT2D4pZLRUcDy0CVKMw4LrBG3RS60WvG+0npvltnnsmZq4lHMpX/o8nn+i2OpsGst
         f687+vLVLtAmHDv9ay4Ca4QVz2G3gNwrsZzSNKcUCpJxOg735F1QXB6qN5MGn9Ohli0W
         +iVlq7bCqmBE4szADvFbY2iXLp8DsLxtw8UsaPdmRZHJ8GvlqpsgIVSUwsYXIkklAdbn
         WLJ+ejBA1hvEDWZMruyartZ7B4PZGlP5SCmpT8oC6C9wmFsJshwOkKvtzzrRXpytOkIS
         1Zy7VegTauD5XSry5lsK+TD5oB/WENg+PRAR4AA/Kq9NBnUMTrorEm4qJg1/kLEAj5bv
         x4sA==
X-Gm-Message-State: AOJu0YyVrB8IJ8mV7Jdi8J9w+tRyYnLs/9y6JcN3P5P3sandBGBdv47k
	9D0pxaS8E0FH/IrDjmDbOz3U5dyNI18=
X-Google-Smtp-Source: AGHT+IHX1n5RB/N/ZmXASpbr2vf/D3T4tuOiNwBtSZA8oxrNJdpaTjugVlXhGLb6f1LVFdrwaV1ynw==
X-Received: by 2002:a05:600c:35d0:b0:40d:5df2:a543 with SMTP id r16-20020a05600c35d000b0040d5df2a543mr1402922wmq.149.1705147728978;
        Sat, 13 Jan 2024 04:08:48 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm13007782wmq.44.2024.01.13.04.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 04:08:48 -0800 (PST)
Message-ID: <e72fdcf0-2d2c-496e-a9be-8b554dec9fd4@gmail.com>
Date: Sat, 13 Jan 2024 14:08:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: rtlwifi: Speed up firmware loading for USB
To: Kalle Valo <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>
References: <6351ca3f-6b06-4fe1-ace7-6e9d67497dce@gmail.com>
 <87o7dphha3.fsf@kernel.org>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <87o7dphha3.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/01/2024 08:35, Kalle Valo wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
> 
>> Currently it takes almost 6 seconds to upload the firmware for RTL8192CU
>> (and 11 seconds for RTL8192DU). That's because the firmware is uploaded
>> one byte at a time.
>>
>> Also, after plugging the device, the firmware gets uploaded three times
>> before a connection to the AP is established.
>>
>> Maybe this is fine for most users, but when testing changes to the
>> driver it's really annoying to wait so long.
>>
>> Speed up the firmware upload by writing chunks of 64 bytes at a time.
>> This way it takes about 110 ms for RTL8192CU (and about 210 ms for
>> RTL8192DU).
>>
>> PCI devices could upload it in chunks of 4 bytes, but I don't have any
>> to test and commit 89d32c9071aa ("rtlwifi: Download firmware as bytes
>> rather than as dwords") decided otherwise anyway.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> There's another version so I assume I can drop this one:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/0d262acd-4f94-41c2-8d15-83486aeb976b@gmail.com/
> 

Yes, you can drop this one. Sorry about that. I forgot to write
"[PATCH]" in the subject. I thought you wouldn't even notice this
one because of that.

