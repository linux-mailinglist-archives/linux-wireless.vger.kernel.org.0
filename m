Return-Path: <linux-wireless+bounces-14283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DB19A9503
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 02:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34392B224A5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 00:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1393A2F5E;
	Tue, 22 Oct 2024 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMptoSda"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043481E;
	Tue, 22 Oct 2024 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557412; cv=none; b=B3jLfz8seMUYaiklkMPvjf2AwxtWBNa5Zr6+ZtkqHI7TApDFwKFVQHhfN0FBrx0yCiTVgwsMWcm6R+liJdvpcuKqWm45pu0Eq5vzIVOqFtGC2fus8WYx5XMHmxJjFM6ZgvNgGoRyWxtb7g9W1kwXW7AKWz0th4rJXROV2T3RoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557412; c=relaxed/simple;
	bh=DlvmIS0GFdouOvMkd9kxRO+6vjh3grF2nviYudtDdmc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=VNcDtahXZZU16CaLYXM4W7BPjuSS6WujgUI2mmVa1bhkdMDLw2m4TxkLMGgNGTar4DcCkiZDIPcfbYeoBgLS5g0ro66WzWDOAynQnYYTU/0x/0aaGvVVVpkTockILSpmDta4G8KAYl3xgAcLcU4QeRReTzmr5f1Eey38Q+i56cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMptoSda; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e52582cf8so3509793b3a.2;
        Mon, 21 Oct 2024 17:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729557409; x=1730162209; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzofkblKFhri+Rfh3J4/u0RRkjnhDLEA166Xs/RLWQs=;
        b=lMptoSdaovfgq0FUJo5QWHNS+94P19f8W+/1mlX52FM+P6AHwVWHRTjsWNyLTpfsOr
         HLTpZxuUSs0sSntJRTfP4qnUDVmC8cNfq3BzKC9sjC9ILDyyqSAjSFqjYvhYgyMb08cB
         KmsePPhBxhn1igXdiKaKEOKh59bngozX400uywnylJBL+1sDt6l9RsnreniZ71FhLkO6
         UyaSb8TbfIVfEmW0siUZeqZzTRiJtEmH8M3qm+OaGJwtvkB6d6u4uv/D5FXQID2hQBE7
         AOIPEWv6gULFTDAJ/T6Hv366eRKty994Z+jCQ07/zfVQxZRfrW7ey7HPAD83hE5cHrQf
         wi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729557409; x=1730162209;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzofkblKFhri+Rfh3J4/u0RRkjnhDLEA166Xs/RLWQs=;
        b=Boe8YMHDGQkj59aFI7/pCt/778Xm3ukd8V4mZbCWhp+FJjRBLcuQhydcAC8tsLcizy
         xy7NWH83QzuFkejPhEidAMkLqL4hsPYgiM6BqQtLOYmfYgGQV5TUVzrdIkMOM72a9fdw
         KSvqQS4sEAgKfw+jaEa5omaOkpOVd7mNMaGMhDzO4zlh3BPNSGuYzOYBLkWmBY7gblHU
         My91w0TGMwDAvcNbIIP3ytTFkZqCsNlBHKMT3uGpkUvpqQLWAqrkY9j54THBr8QaXrhu
         /QbENVne79bQLO7AI5e9fGMPsbq9rnBD+pyFhEeT/7OYjiTY5AIKuYkzdU6C3F1OaAtc
         ozjg==
X-Forwarded-Encrypted: i=1; AJvYcCVFmJJlTNsbgkZxyhEnCNR3OY3DquB5IZvAkSZIYWazO+xX9wYi1F8RFf0+mV1m6TrzLdI1Gx9WmGtFUgE=@vger.kernel.org, AJvYcCWwXwy5KqgwKEFf4LUfzSaYEdx0YXzOJDd2Ky8QfSEO9bOTktfPhWZjD3qGFlsdjLOzk1Kv7RcuZMlVriYpBqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6LQqAf8vTOL2Af3RSKVgxVUcCYSBgGDSxMZs9PH0u71r2Ufs
	wOHkJzBr2yfHFmWhX00qKa6ONs7loektnFdwGxgpUQtT9kcorJfzU/l76bTq
X-Google-Smtp-Source: AGHT+IF/nPjV5QSpmN+q0ML59khpHR/EVtZLnhERjhjNxgAmBM6yhRzL6e0Ly5IY3QtYiktXk+H27A==
X-Received: by 2002:a05:6a00:1a94:b0:71d:f821:1981 with SMTP id d2e1a72fcca58-71ea3126119mr16470056b3a.4.1729557409053;
        Mon, 21 Oct 2024 17:36:49 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a409:cb40:2dbb:16ed:d48d:b2b3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d76besm3520638b3a.121.2024.10.21.17.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 17:36:48 -0700 (PDT)
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
Date: Tue, 22 Oct 2024 09:36:37 +0900
Message-Id: <1D787F7E-08E2-4F21-B7D3-68A9F345E79E@gmail.com>
References: <172631439319.3042536.1475962432679276880.kvalo@kernel.org>
Cc: toke@toke.dk, Sujith.Manoharan@atheros.com, senthilkumar@atheros.com,
 vasanth@atheros.com, linville@tuxdriver.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <172631439319.3042536.1475962432679276880.kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
X-Mailer: iPhone Mail (21G93)



> Kalle Valo <kvalo@kernel.org> wrote:
>=20
> =EF=BB=BFJeongjun Park <aha310510@gmail.com> wrote:
>=20
>> I found the following bug in my fuzzer:
>>=20
>>  UBSAN: array-index-out-of-bounds in drivers/net/wireless/ath/ath9k/htc_h=
st.c:26:51
>>  index 255 is out of range for type 'htc_endpoint [22]'
>>  CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc6-dirty #14
>>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/=
01/2014
>>  Workqueue: events request_firmware_work_func
>>  Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x180/0x1b0
>>   __ubsan_handle_out_of_bounds+0xd4/0x130
>>   htc_issue_send.constprop.0+0x20c/0x230
>>   ? _raw_spin_unlock_irqrestore+0x3c/0x70
>>   ath9k_wmi_cmd+0x41d/0x610
>>   ? mark_held_locks+0x9f/0xe0
>>   ...
>>=20
>> Since this bug has been confirmed to be caused by insufficient verificati=
on
>> of conn_rsp_epid, I think it would be appropriate to add a range check fo=
r
>> conn_rsp_epid to htc_connect_service() to prevent the bug from occurring.=

>>=20
>> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>=20
> Patch applied to ath-next branch of ath.git, thanks.
>=20

I think this patch should be applied to the next rc version immediately
to fix the oob vulnerability as soon as possible, and also to the=20
stable version.

Regards,

Jeongjun Park

> 8619593634cb wifi: ath9k: add range check for conn_rsp_epid in htc_connect=
_service()
>=20
> --
> https://patchwork.kernel.org/project/linux-wireless/patch/20240909103855.6=
8006-1-aha310510@gmail.com/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpat=
ches
> https://docs.kernel.org/process/submitting-patches.html
>=20

