Return-Path: <linux-wireless+bounces-26314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A76EB22738
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6242A16A035
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9E221283;
	Tue, 12 Aug 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDoEwojS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8C3C2F
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002663; cv=none; b=MGNg05Om3RuRvZKta39/vVzsAy9VuSpolINyEzyizUDE6gNX1ebKA5ewyUmTDRgbzOmmYUjs/oQSisTIFlg2+DxZu9zM7+0MQ34wKlQa2i8TCxpV34riVCN0j2NKLnOWUlU2ZCzkCATHgmV2CD0aSWI0pGayjlrWO2p+BAeRVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002663; c=relaxed/simple;
	bh=70peFFMQuzBqbP1VfIvYgy7agiqxlCLmi9ehSeQESXE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lvE4mr0z/fzmv40MikcxrEVT76iP5LmGSU2CgKJKpuzQHHsu0AUyKVfLHdgZm4MPeclpRdy/2guV/vF1jf3wfyUN2E+8T+nqmseokK8B3hdgLeVHNCk4SkhThBg7Z5ShprFNHcJ8vDkGSB+TBzKM+xuZJ4mXQYZkjVFVfk/Slqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDoEwojS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b780bdda21so4444362f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755002660; x=1755607460; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70peFFMQuzBqbP1VfIvYgy7agiqxlCLmi9ehSeQESXE=;
        b=hDoEwojSfuNha8n62D1x1xENf4JzLKXOtViz7vO3K3xX5+W0qPTK7tq6chWyUKFo3I
         G+n9b46Jk9gBbHW5E3KZDi70eKwsEIn0we7N1Sqlq4BMYwLaXfLyoTKUSG+2BC1xHnm7
         pVLSGEDrmNtHAKL1YHb1LS+Tih1vrmoWwWoKTTva9du19qU9OopzVSEYYGJBBq9CKZAi
         S/ORzfksQP/ohGfIYdL4etGdaO9CkvKjls4qJjqk2suZDR7xHm1bbZd0PLQE/oV6OmlF
         NJIQvL632OwyhbKhhroRbQ3h2WBDFN/SSLB3ys12APm/J9rT2jcr9mVHYv0KMjxHE3Mr
         NxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755002660; x=1755607460;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=70peFFMQuzBqbP1VfIvYgy7agiqxlCLmi9ehSeQESXE=;
        b=NiVq2bMjwaMZTC/LViB5lVavFojVgB+iUd/fSguJk55k4SySFuOyLK6tZW8XlOrtjE
         j0dBRHKiBPg7RwDBNEj7bnXpyU6UVB7Sz2h4m8WaUadqeuVU1ed7oqJCcI6vtrKlc8oR
         gXk40jJyhw0hlKRozqGSCaqS2g7lIqvsk/xn3EVixlHEkf3mD08A4SUY2N566VCv9umQ
         Sf9WGkti0DRIxoj+76i6vMKxsLeh3oy1NhMEoWTw7FG4OKHLZTBQpQCfMDrc8ZT/y3o+
         iNDRDRd5norZLGcptWX+3ld3lOl9LnaVok+lnERoW/7Yfg8zmzFIOnTc8IctyGyThA1G
         cRaw==
X-Gm-Message-State: AOJu0YzR8bRg+HQYwmGy2oiFBHAZwfTokI+f8l46NfHeIElfL0+/dfDs
	bUCOHpgMM3htIiBNiGgnRH3isBfJtzmpzJ6J/loTEMhGJ7sb8YTnTIXB
X-Gm-Gg: ASbGnct/eUUHE7gt40zC9TmIAPFfk2yVKnC8vaKxtpJemmwJ6ttZbFru5EBAvGe1Sj2
	TZkSAixKuh525gnbonmjWR7/UUVXJxGtF/l5R6/Oo+QPtCTwhdGFbT14jG01IExqXNrhSRfcABr
	edNvbHrJP6R478DQJslXhm/mBsT9NoCRplg4S8qzL+pdCkzw8nmRgHE5PPd+YqDmmCYyHWc6dPJ
	c8Jw1wjuwpn8lxdWnMv98QRgVDHumVPhQ9xJU+sLNTVjgcWDFGrq+J0pjt2qIYTpNvakxAqw2zx
	N2Bk978CofNXIG3a6vrGs2PIWVeuPBYqWThwVwu2s8cId3368CSWapyxhD2KwOi9bpSyPIU56WR
	Di7srOc7QJYypRG8zMLFMEH+KT7gEp0rDfS5mCBmc
X-Google-Smtp-Source: AGHT+IHp1dhYfOgtsbw2XkS84nVQxVPMzwExQGHqHjdIJUuDVXuWms8PWlAK8N/vsBpCMAFIC0Khig==
X-Received: by 2002:a05:6000:26c8:b0:3b7:7898:6df5 with SMTP id ffacd0b85a97d-3b900b4da22mr12230450f8f.14.1755002660012;
        Tue, 12 Aug 2025 05:44:20 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm45019771f8f.4.2025.08.12.05.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 05:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 14:44:19 +0200
Message-Id: <DC0GIRF0TYEL.DUG78V7F6HID@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "Steffen Moser"
 <lists@steffen-moser.de>
Subject: Re: [PATCH] Revert "ath11k: clear the keys properly via
 DISABLE_KEY"
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 <ath11k@lists.infradead.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250117191455.3395145-1-nico.escande@gmail.com>
 <5b769b75-df2a-4dba-a41b-198851b61b9c@oss.qualcomm.com>
In-Reply-To: <5b769b75-df2a-4dba-a41b-198851b61b9c@oss.qualcomm.com>

On Tue Aug 12, 2025 at 1:34 AM CEST, Jeff Johnson wrote:
> On 1/17/2025 11:14 AM, Nicolas Escande wrote:
>> This reverts commit 436a4e88659842a7cf634d7cc088c8f2cc94ebf5.
>>=20
>> This as been reported by multiple people [0] that with this commit,
>> broadcast packets were not being delivered after GTK exchange.
>> Qualcomm seems to have a similar patch [1] confirming the issue.
>>=20
>> [0] https://lore.kernel.org/linux-wireless/Z2Q9POuV-6MIdzRf@pilgrim/
>> [1] https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blo=
b/win.wlan_host_opensource.3.0.r24/patches/ath11k/350-ath11k-Revert-clear-t=
he-keys-properly-when-DISABLE_K.patch
>>=20
>> Fixes: 436a4e886598 ("ath11k: clear the keys properly via DISABLE_KEY")
>> Reported-by: Steffen Moser <lists@steffen-moser.de>
>> Closes: https://lore.kernel.org/linux-wireless/c6366409-9928-4dd7-bf7b-b=
a7fcf20eabf@steffen-moser.de
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>> ---
>
> Can you please check if this alternative addresses the issue:
> [PATCH ath-current v4] wifi: ath11k: fix group data packet drops during r=
ekey
> https://msgid.link/20250810170018.1124014-1-rameshkumar.sundaram@oss.qual=
comm.com
>
> Any Tested-on/Tested-by tags would be appreciated!
>
> /jeff
Yes that was on my todo.
It seems to work fine with this patch.
Thanks for taking the time to fix this one

