Return-Path: <linux-wireless+bounces-7936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C9F8CBC41
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 09:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D9D1F2181C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB957D417;
	Wed, 22 May 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="RO8WRsQN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351D1CF92
	for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363879; cv=none; b=YpsgNKPu8FWT/8oHiT40ILsc4cliCRmIYzV00q5VJpLc3qLQdqmUeP/hRN7ESosSJsnrtTKb6+zJIIw8kSDLrL37bzoEKP0eXtiajTlfTQo21tRzxPT/HVdk4NL2v3kKZk85sAL95SNgjYYhcuNndqayNCa4vuAe2gcQPcNTI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363879; c=relaxed/simple;
	bh=otFBa2fFNWj2rsUxcEHKhjVJ8IwT//GKW/sRVwfUuHo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=iZT55ZBQflua9hDyQQBbFX5N+n2fyMYF/+zczXWUxYvphBVE0e12Km9i++I1yKmc/4dLxxlVlLwkplPQU9sPuMecU6f8RTQTHvpC26IDSmdE/t/XvRdQCmcKmrbm3o3F16iMfbUxcYJ+zmv4SYNirgUo2Cz7fToduIOOdUg9MEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=RO8WRsQN; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so6848358a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 00:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1716363875; x=1716968675; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otFBa2fFNWj2rsUxcEHKhjVJ8IwT//GKW/sRVwfUuHo=;
        b=RO8WRsQNriVX2gmQW95Y6NQuuvzvIPidN9a1z42vhhMaJ0Xu73EuK6phky4FWFxPag
         SzlFlHhgm5xgVD+zwzpKo6ZCmdJ0vv3P3bxWKA9eK8mQy6iitD764n0o8XXeGnV0PoxE
         3t0XJuo1/Vh0fAxZAGiaj95dJflVh1pLkt//XBRBgMih9R8+V0WsHpq5q40gYW9T/DSx
         74duasT+pNTRHDo6DgbB3TA1hgI2MPG2roRzU+WeVMyf5vuj1jn/C+MTN+CjFQGaq7I7
         YG7iLROlGrsnjD3m3Zth+6QVVRnvLn5M/jHHTob9ofsOOnL9MILFHjPo7ULL/1ymHIZO
         90pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716363875; x=1716968675;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=otFBa2fFNWj2rsUxcEHKhjVJ8IwT//GKW/sRVwfUuHo=;
        b=BRHxPuLDXZ+TliXjXSHGvoTkJYX3EAXftGEmR28n2OSKTobnNnglJJCj8MsAQxfcA9
         izh1uqxn0SVMb/IAslr6/RBYM49O/K7TOTtZoJDZgajMdVHeYmiy4K2g3zTxrDb2p+v1
         qdmwlsYAM8ijef+bUbkrTMcc+7xCEnZk/nq9AJ6Jt0NMpkw++dycldLRPwBYW289Mzo8
         g2+X3RIUrhHhx7gTynNd9fZBJmGMLHdTMkmrqVvPLq8bMI+UeE4GOgnQ5D+ItGHxR1Kd
         uQiWRvyklHFwSU2v5al+m3YT3U7hT2d1YD4MlK8KfOu4z7cZHMIj/PiqsuZA5w1JAV22
         5u0w==
X-Forwarded-Encrypted: i=1; AJvYcCU/3ZQe7UcYiXjdLKNROReyIOMIBcmtquNZ16NSuY6L34Ckv8ApQNXCOE+DfKzmA9RJUOGryeiqp1iNtl3AbiCxDN1tQhWT+EQaiAVIt5U=
X-Gm-Message-State: AOJu0YyWqPbf5LiIGtoLgmPm6icgDhlumc0acf+euWZGvLfN4KmPcvxV
	NTwu3b2fSSWiCLCFNErutP5YzmPx4NJLoMg1JIhCZDuzJ6YrE9M4BH6WdgKMAxQh12oHc11cAuA
	u
X-Google-Smtp-Source: AGHT+IFKiy8iHMErmmG0rw3+QR/Cj47L+lxtbiDuEp4SLHGUcA6h7sx1wjpW7aUfEMIzH1dG2o8kBQ==
X-Received: by 2002:a50:d617:0:b0:56e:2f39:c5d2 with SMTP id 4fb4d7f45d1cf-57832a07d41mr651437a12.7.1716363875433;
        Wed, 22 May 2024 00:44:35 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-573413b2ac3sm17703276a12.38.2024.05.22.00.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 00:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 09:44:34 +0200
Message-Id: <D1G07QWQX2VU.15LH8QOZ3L58U@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Kalle Valo" <kvalo@kernel.org>, "Carl Huang" <quic_cjhuang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: fix WCN6750 firmware crash caused by 17
 num_vdevs
X-Mailer: aerc 0.17.0
References: <20240520030757.2209395-1-quic_cjhuang@quicinc.com>
 <171627868306.3970531.273322605619339350.kvalo@kernel.org>
In-Reply-To: <171627868306.3970531.273322605619339350.kvalo@kernel.org>

On Tue May 21, 2024 at 10:04 AM CEST, Kalle Valo wrote:
> Carl Huang <quic_cjhuang@quicinc.com> wrote:
>
> > WCN6750 firmware crashes because of num_vdevs changed from 4 to 17
> > in ath11k_init_wmi_config_qca6390() as the ab->hw_params.num_vdevs
> > is 17. This is caused by commit f019f4dff2e4("wifi: ath11k: support
> > 2 station interfaces") which assigns ab->hw_params.num_vdevs directly
> > to config->num_vdevs in ath11k_init_wmi_config_qca6390(), therefore
> > WCN6750 firmware crashes as it can't support such a big num_vdevs.
> >=20
> > Fix it by assign 3 to num_vdevs in hw_params for WCN6750 as 3 is
> > sufficient too.
> >=20
> > Fixes: f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces")
> > Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> > Closes: https://lore.kernel.org/r/D15TIIDIIESY.D1EKKJLZINMA@fairphone.c=
om/
> > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICO=
NZ_LITE-3
> > Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
> >=20
> > Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>
> This patch should go to v5.10 but I'll wait for Luca to test this first. =
No
> rush with testing, this is just a status update.

Hi Kalle & Carl,

Thanks for adding me to CC, I didn't receive the original patch (@Carl
maybe check your email setup why I didn't get that one?).

I've reverted the previous patch "fix WCN6750 firmware crash" in my
branch and applied this one and everything still looks fine. Thanks!

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

Regards
Luca

