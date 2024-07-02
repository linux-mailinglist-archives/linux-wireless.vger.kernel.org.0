Return-Path: <linux-wireless+bounces-9868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34824924290
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56ABB1C21498
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172A1BC073;
	Tue,  2 Jul 2024 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MgfSRGxT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498841BC062
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jul 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934768; cv=none; b=uVpJgXfQkie3d2Gzozwujfno8fvzzCpcB1JiKLRbwOBCjnsa8F07R0lTjMa3sSlhwBy6CxYf7gKvaMlJuArtRR1t8Uz5ncWN08Fco4vYIL/qIphnC0Wa2ty7Wqr1qXzWqegIGR9qyukKsPMXaxyeXH+8abpEmG+6NkwRSUXqmDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934768; c=relaxed/simple;
	bh=6FFwzRxmvhaU/cc/rqv1bYocYY1MrbGaEsqX4FN8MTw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Cvu/7TwfJoKPFnvw7n860KbvJkgnTELVrETXTAvaW6g8z+q/BwEgBv7IRNaoEqoyTWDWMw5eyhdInYkxFFUbwVufsiQ3KtfteSClC4M4SMywJodqPVxxu/QgRYNHP/DnAs6cghIxVoPAAKZWA07V5m5zx3RmNwxXTL7pWn8ll+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MgfSRGxT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa3bdd91c1so33052905ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jul 2024 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719934767; x=1720539567; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lajadps+ETm+pi9fGEkKDSIqAWXEr2D+BQRpa+YRu3A=;
        b=MgfSRGxTo1JeDpxMLtpOB84nvHtMbx3yn9kJ95rQ99NClQZbJWi4YVaYzCexVr74sJ
         jCUugFI96bzQ8aszHYrWq0P23STXGEgRG+qk/JLc1UROHUuirui9wpYoH6M7LBOn+wNy
         7zDB4YuNVwEz9AGRbukqdqgys7/kb5l9Od/zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934767; x=1720539567;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lajadps+ETm+pi9fGEkKDSIqAWXEr2D+BQRpa+YRu3A=;
        b=vjas8gXT6MlqQg5ZZySik5RW5mSY3nmG0+EGtVuhZPExFWj/Vy9DzGr7IYilkSUw+F
         lSp8CnGEGqUNZ4nKNrACjBj1FofjQ3IdUaMQJ6m1bvKE+kHRiUjQ4vP+JlNqRmRTNJrA
         p4dJvtgwzSWAshAJROGsyRz84Ldd5pYb14Tz5ik05B4T/NxovH/qwFDpSlYjH7aSXUup
         dhLzkEsKWlwHGY0NwSfLiK+Dbbtakp+hk3jB3ToIoL7VwnoXM292UMOaZgey42jWSgFH
         g/tTO+vFZPDtb2dXmbAhZl+svRjbxWi5MDjragXCXOJYIh61yjtHQUh6wXigrsfvTqoN
         Kvug==
X-Forwarded-Encrypted: i=1; AJvYcCXK8+UNEedCbAdbyf/TWMbjVBOgu6GGfnyAABYGtmBKoJvItHeK0hf+rZj/ncY0eWjq0+c2eSv8GYgpvzCeyYfhwKJSr5fvL09XghIjKjc=
X-Gm-Message-State: AOJu0YyvG74VNbqbKW8so5ia7M6pLT59H9i2r9vl6UfyV/P7ScYkqfhj
	nMwki7EtE6ZJJuBeq4/Dra+Gc2sU1sDoR0Xrk6MLTs+6KjxXTKufAs96+x/tFg==
X-Google-Smtp-Source: AGHT+IHGNe88xaz9V3wl7Y0BZz+8Vp1YXhbqAgPA/0D0pXcdR5pI17FqahEDKlWelRJEO2oTR4B6Gg==
X-Received: by 2002:a17:902:bb09:b0:1f7:174d:3309 with SMTP id d9443c01a7336-1fadbc8eabbmr64859875ad.30.1719934766597;
        Tue, 02 Jul 2024 08:39:26 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1539160sm85687665ad.180.2024.07.02.08.39.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:39:26 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Su Hui <suhui@nfschina.com>, <johannes.berg@intel.com>, <kees@kernel.org>, <a@bayrepo.ru>, <marcan@marcan.st>, <quic_alokad@quicinc.com>, <zyytlz.wz@163.com>, <petr.tesarik.ext@huawei.com>, <duoming@zju.edu.cn>, <colin.i.king@gmail.com>, <frankyl@broadcom.com>, <meuleman@broadcom.com>, <phaber@broadcom.com>, <linville@tuxdriver.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Date: Tue, 02 Jul 2024 17:39:17 +0200
Message-ID: <1907419a888.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <878qyjg6cv.fsf@kernel.org>
References: <20240702122450.2213833-1-suhui@nfschina.com>
 <20240702122450.2213833-2-suhui@nfschina.com>
 <ba67020a-04bb-46b8-bc05-751684f71e8a@suswa.mountain>
 <19073fcc9e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <878qyjg6cv.fsf@kernel.org>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH wireless 1/9]  wifi: cfg80211: avoid garbage value of 'io_type' in  brcmf_cfg80211_attach()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d35965061c4584dc"

--000000000000d35965061c4584dc
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On July 2, 2024 5:29:27 PM Kalle Valo <kvalo@kernel.org> wrote:

> Arend Van Spriel <arend.vanspriel@broadcom.com> writes:
>
>> On July 2, 2024 3:57:27 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>
>>> On Tue, Jul 02, 2024 at 08:24:44PM +0800, Su Hui wrote:
>>>> brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes it to
>>>> brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage value.
>>>
>>> Since you're going to be resending anyway, please delete the space char
>>> from the start of the line.
>>>
>>> It's weird that brcmf_fil_cmd_data_get() uses the uninitialized data.
>>> It looks like it just goes to great lengths to preserve the original
>>> data in io_type...  So it likely is harmless enough but still a strange
>>> and complicated way write a no-op.
>>
>> Not sure if it helps, but I tried to explain the reason in response to
>> patch 0 (cover letter).
>
> Would it make more sense to have just one patch? It's the same issue
> anyway.

Yes, but I would solve it in brcmf_fil_* functions (fwil.[ch]).

Regards,
Arend

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches




--000000000000d35965061c4584dc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCeOi8qC29vhaKHam6V
P4dzvmzOFshznc/u5y1ytFdEeTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDA3MDIxNTM5MjdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAfrgN78bbaCqlzFzw2xUlkvSTnlOWT3C2LQ/O
molPJwy5vF9mW6ppJA6CwV0DPCTJ8EpKISOfS5Ey/V23Zzi2mujPqWlG5U9LxVPn4rrXdtrbAL0E
CX79W95tP+7+7CSHZEz3OI60sn8ZpNvEKn7IK1s7wMpK1kvrmaofHDDbAFzXWh5DJqiadUDuW4WC
hsJaef7UCeGhDCcf8k8b+UnOmq+DHioQ0ekwMcYAs8JPFASowb847C/JtqC/P3cfN8sjuMfvs0Sw
/d2DxUa7MdZyuBmm12HVGnI4qBXp2QE3u9yglDYGlCcAz9DXHPuVkRYOYAUJCzUm4Cw3Z+Zi+0rl
Bg==
--000000000000d35965061c4584dc--

