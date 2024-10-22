Return-Path: <linux-wireless+bounces-14284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE349A9509
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 02:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398491F239BF
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491BFDDC5;
	Tue, 22 Oct 2024 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr/G2/Zl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F64A1E;
	Tue, 22 Oct 2024 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557602; cv=none; b=kJHrv3Dgw9tjE+cY90FhNkjjJF6qcyShR4lX0Kk/0PIt6B+EFLzmdo/00v1Y4nPAlq6WD9vt5wK/REhwrNyMQLuVFIpz9zmwHHfoGbIhzAv2TO4TOOP8TOUEVKHB55nHu2bAA4KjJM4EzJD/Nx/ER1NXsphFxaRB726KFPf96iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557602; c=relaxed/simple;
	bh=ftG8XJktiJrDNHiIuR6Dr/LhGMKj7yUiktxEXg0BP+g=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=T7lV5moLqF372u8yGQbrpSZ33T217bDRmkl4BOvfvNChuPTBihRw0WDHqDkKXdrlGs1OSJYUrzxQUUsgftoz/su9tbrqGq6VERf9BQdltVmHQMyFmOS2s9qVM1HcdrF1Bqask6Ityj5wItYDygY5oqIFAaUP3r3tHEWE9W8phlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr/G2/Zl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ce5e3b116so39505245ad.1;
        Mon, 21 Oct 2024 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729557600; x=1730162400; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdbuZGrra7A3+6D+E69xeqbotHoVIk2n5QRQ0Erx25U=;
        b=Tr/G2/ZlJuA15JCnQu1BwgXDE8V3gfRaClwbzM/1Tw+VzeymbxjTacikng65THx+HR
         E1L2M1YJLUuLkvQwHiNRcweS5/e/BzvPM8IRVb0LvW5Xk0PiJXYiYH9RhVk/2XaonGED
         gaR8t3vOcfX1lVMIgGtINSRU1p9LUhSuJbgtZnYBJoBaLAqh7m50JjWrQ/Tfm/fo90v1
         QG7SvMF4M/7iMyzCOW8cqPU+wuFe5nxlOZs/JTAD6uK3RoqU70UfJCxeRaEmI5tcFqEc
         6RltXx234dUnsVtPjBSIJBXLjZIqe6CHdJPUWT786vZQNEOhv2EVbTdFWY2H8F4g6bxU
         Ah5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729557600; x=1730162400;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdbuZGrra7A3+6D+E69xeqbotHoVIk2n5QRQ0Erx25U=;
        b=hQif9empeNxPCQz/secUCarg6mNkLGzFQsbD6PkqLTpMYlSsvokkQ4f13ZiKIJPxzj
         E1V8oTtbUSh6gh3s8bIxD+pv+0btVmaDwac3ewtr3zFCZSx9idPdCstgtZU5kag3jd5b
         DWWLGw511a/3H/xoZ5WjILPQKv/SDsD9HaEqUF5yP/MoYa3RtOg6NY+crLGFjv4XMZWV
         vySWTlHsqtwhG3c+nhnJAu0Tjeye1YOAsNEqeQno08j6KJOXgignMVHaT9j+tRXkYlJ7
         Xuxs/tyxwCX0MRA79mjYUIeqSOjkjmwvA2i1PmcfJyOaz7j/8j5mwHKeTuvHYD9XSuOn
         7gjg==
X-Forwarded-Encrypted: i=1; AJvYcCW+9erQq/bain4T15ag38v7Z6isi8DMCpjvyx7UDozvJ1m8xBBCGWjLmEkXVs9gPrjh2XP1R0buOuMwqEo=@vger.kernel.org, AJvYcCX8nAzfgtpTjhML2Lm3ktlNSFledyKm2rmywwBZeo4MlyzsNHAe/nZNCKgW/oc/slo7/dmyviEYbzb1j8dB1lk=@vger.kernel.org, AJvYcCXgX3qY760mhoRYKuLRrYGFQmRaOsd9dAcsDB1FPIN3CySktVVG9qvbn10KXDpSn6QEL+Sn23Jq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27MjJZ5LO1BAJv/nw+PP/JwxQoH9R9fEvSxN6MUYEPDP2xj0P
	wa9gcVbj/8SbhQdsnp6OzrXJpyVKsEinzTHLxmBFEB+Rtb6wHQ1A4RH+NnMe
X-Google-Smtp-Source: AGHT+IGABpgowUdHxqLjCCAtRNC/zGp0XhSBCcyiWuT+FC9TgrFJv55n0y1iBhEPI1qvUL6kn74RjA==
X-Received: by 2002:a17:902:ce85:b0:206:a87c:2864 with SMTP id d9443c01a7336-20e5a9441ffmr149158125ad.42.1729557599495;
        Mon, 21 Oct 2024 17:39:59 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a409:cb40:2dbb:16ed:d48d:b2b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd5ddsm31904985ad.141.2024.10.21.17.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 17:39:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
Date: Tue, 22 Oct 2024 09:39:47 +0900
Message-Id: <311B4F6D-9D70-44A8-A367-ED2721C58AC4@gmail.com>
References: <1D787F7E-08E2-4F21-B7D3-68A9F345E79E@gmail.com>
Cc: toke@toke.dk, Sujith.Manoharan@atheros.com, senthilkumar@atheros.com,
 vasanth@atheros.com, linville@tuxdriver.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <1D787F7E-08E2-4F21-B7D3-68A9F345E79E@gmail.com>
To: Kalle Valo <kvalo@kernel.org>
X-Mailer: iPhone Mail (21G93)



> Jeongjun Park <aha310510@gmail.com> wrote:
>=20
> =EF=BB=BF
>=20
>> Kalle Valo <kvalo@kernel.org> wrote:
>>=20
>> =EF=BB=BFJeongjun Park <aha310510@gmail.com> wrote:
>>=20
>>> I found the following bug in my fuzzer:
>>>=20
>>> UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_h=
st.c:26:51
>>> index 255 is out of range for type 'htc_endpoint [22]'
>>> CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc6-dirty #14
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/=
01/2014
>>> Workqueue: events request_firmware_work_func
>>> Call Trace:
>>>  <TASK>
>>>  dump_stack_lvl+0x180/0x1b0
>>>  __ubsan_handle_out_of_bounds+0xd4/0x130
>>>  htc_issue_send.constprop.0+0x20c/0x230
>>>  ? _raw_spin_unlock_irqrestore+0x3c/0x70
>>>  ath9k_wmi_cmd+0x41d/0x610
>>>  ? mark_held_locks+0x9f/0xe0
>>>  ...
>>>=20
>>> Since this bug has been confirmed to be caused by insufficient verificat=
ion
>>> of conn_rsp_epid, I think it would be appropriate to add a range check f=
or
>>> conn_rsp_epid to htc_connect_service() to prevent the bug from occurring=
.
>>>=20
>>> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
>>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>=20
>> Patch applied to ath-next branch of ath.git, thanks.
>>=20
>=20

Cc: <stable@vger.kernel.org>

> I think this patch should be applied to the next rc version immediately
> to fix the oob vulnerability as soon as possible, and also to the
> stable version.
>=20
> Regards,
>=20
> Jeongjun Park
>=20
>> 8619593634cb wifi: ath9k: add range check for conn_rsp_epid in htc_connec=
t_service()
>>=20
>> --
>> https://patchwork.kernel.org/project/linux-wireless/patch/20240909103855.=
68006-1-aha310510@gmail.com/
>>=20
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>> https://docs.kernel.org/process/submitting-patches.html
>>=20

