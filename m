Return-Path: <linux-wireless+bounces-13836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C689980AD
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 10:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA64EB2171C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441F19E7D0;
	Thu, 10 Oct 2024 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaCwO2iO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6E1BB6BC
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549211; cv=none; b=r54DSP/1TxjBOnqS5nUVMmnM1C+A8EuOJkVbFtQ8TDnO9WNFnf3x8AxThOc+tFaaUiu/9xya8PPXE8DzqGp0iAAN0HLwKUKTHYTVI1eCMX3eqxhqNz/ZUSv+VYzmfRY8ksz3br6sxnLVuOjp39J/cKueZ1H3kYccJ3EPjrC8BD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549211; c=relaxed/simple;
	bh=XvNkbaBk9fuSrUkNDofqyfLNh6yl7vhOJSKqfqMOpdQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=RwbdURAVC5b2dWTa0I84tfj2Uv1oeqwmMVidVtQYbj9JQpQHRq/Dpj/zPJKZ97iDO47BOONnPuLbDM69Eev8aaUSXGOcRciF5/SD7RgPW+dIQe75HOPBl+Ex0lpT+nZ7qWcVbE7VeD9oT8UqbWG9k0CgsP7TAOvuGHcKnl1sCt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaCwO2iO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398e33155fso742464e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728549208; x=1729154008; darn=vger.kernel.org;
        h=user-agent:mime-version:date:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2ALuJHQTIaTyeGGIsf0qaNPHAoVHdjzrLKpjXltEptY=;
        b=ZaCwO2iOivTK96wU5lbNkiSq+2GDg/yfsJssURPX3Wk33NhlPWcpuSYXR5J6Ey6BOZ
         qsKUSpm2cVO9/Lr/zea3DLBCzfoX1tfVEDLHI98xUPsRFOhJq6V5Rro+WJ4hFvLR5oQf
         X5iiRfEkfmRBOFAX7OCg85TjsgNAkl3838cHMPnTciREE2nPNJsmEIMWbywRJhMztOpr
         MSgmcqgXeavHc8cFwrXA47u3WbWZiQvNdoyhb8eOAexaCvsB19ML8Id/cgEYmi+FJKsl
         dAqHMvHVw7XWH3Z9z+pCVK8yTOMtGmzxMhAGdY1bz6WpLTZox0k+7MmdDD0038w3ScS1
         7tvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549208; x=1729154008;
        h=user-agent:mime-version:date:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ALuJHQTIaTyeGGIsf0qaNPHAoVHdjzrLKpjXltEptY=;
        b=ERdB0USpARYf16SLI7PeaojFTUD87Oqk2DYy7+9iAYV+Hl6OZBhUIs8oLwLOWpsu7I
         GDP9qsyeDFaVdpGueZwtYntsdl2UZIYorjcy8eZVmeNIpBPvj2XAlWWNm7Oja+aS1CXo
         sn/n2+t/Jlag0luxQqy/2GaWeJ6ANgLf3g9hpkE/2ykTBlENQbUrXnvsQELkmDKZpIL6
         RBTUkzY5DwtnMoQ/2AwK8494LMnXBHNAY6is6B8Mh9n4Ta6kXa8J7WTy3YtsuepAM6vV
         dhYRROpD/p+P1m0cbjijF8zuEXAcP3+UZOdVYg4FmqcM5ujee0JZN3+3BkS81HCe61QI
         +AhA==
X-Gm-Message-State: AOJu0YwM2v+2qOlvdPJ3upSORc3pQwqw7dwqT+nzrHkhCb8zsDGYi3sm
	r1vJG02hNKXRO6/zHNbhkmEO23gu0WQt0jaEeWWzU8MbePV3Tpyj8CIr5XNsyOk=
X-Google-Smtp-Source: AGHT+IGNzMqygvX2xI9kUBdqUG+FECfKBk2luYkrbliiHxrEKSmwSn93q8Z3zclHo/NGvsnNpMpMHg==
X-Received: by 2002:a05:6512:3190:b0:536:553f:3eec with SMTP id 2adb3069b0e04-539c488d8aemr3704512e87.5.1728549207323;
        Thu, 10 Oct 2024 01:33:27 -0700 (PDT)
Received: from [192.168.50.84] ([193.22.231.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8f0f7bsm157771e87.234.2024.10.10.01.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:33:26 -0700 (PDT)
Message-ID: <2c5c0d485df7b334ea0bfbb87325a5fbc7b52663.camel@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: coex: remove rf4ce unused code
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org, Dmitry
 Antipov <dmantipov@yandex.ru>
In-Reply-To: <20240820055244.128644-1-d.kandybka@gmail.com>
References: <20240820055244.128644-1-d.kandybka@gmail.com>
Disposition-Notification-To: d.kandybka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 11:19:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.0 (by Flathub.org) 

On Tue, 2024-08-20 at 08:52 +0300, Dmitry Kandybka wrote:
> In 'rtw_coex_run_coex', 'rf4ce_en' is hardcoded to false,
> so 'rtw_coex_action_rf4ce(rtwdev)' is never executed.
> Assuming that rf4ce was never fully implemented,
> remove lookalike leftovers. Compile tested only.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: a9359faaa47d ("rtw88: coex: add the mechanism for RF4CE")
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> ---
> =C2=A0drivers/net/wireless/realtek/rtw88/coex.c | 30 +-------------------=
---
> =C2=A01 file changed, 1 insertion(+), 29 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/coex.c
> b/drivers/net/wireless/realtek/rtw88/coex.c
> index de3332eb7a22..1fbcf701e7b7 100644
> --- a/drivers/net/wireless/realtek/rtw88/coex.c
> +++ b/drivers/net/wireless/realtek/rtw88/coex.c
> @@ -1591,31 +1591,6 @@ static void rtw_coex_action_freerun(struct rtw_dev
> *rtwdev)
> =C2=A0	rtw_coex_tdma(rtwdev, false, 100);
> =C2=A0}
> =C2=A0
> -static void rtw_coex_action_rf4ce(struct rtw_dev *rtwdev)
> -{
> -	const struct rtw_chip_info *chip =3D rtwdev->chip;
> -	struct rtw_efuse *efuse =3D &rtwdev->efuse;
> -	u8 table_case, tdma_case;
> -
> -	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
> -
> -	rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
> -	rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
> -
> -	if (efuse->share_ant) {
> -		/* Shared-Ant */
> -		table_case =3D 9;
> -		tdma_case =3D 16;
> -	} else {
> -		/* Non-Shared-Ant */
> -		table_case =3D 100;
> -		tdma_case =3D 100;
> -	}
> -
> -	rtw_coex_table(rtwdev, false, table_case);
> -	rtw_coex_tdma(rtwdev, false, tdma_case);
> -}
> -
> =C2=A0static void rtw_coex_action_bt_whql_test(struct rtw_dev *rtwdev)
> =C2=A0{
> =C2=A0	const struct rtw_chip_info *chip =3D rtwdev->chip;
> @@ -2531,7 +2506,6 @@ static void rtw_coex_run_coex(struct rtw_dev
> *rtwdev, u8 reason)
> =C2=A0	struct rtw_coex *coex =3D &rtwdev->coex;
> =C2=A0	struct rtw_coex_dm *coex_dm =3D &coex->dm;
> =C2=A0	struct rtw_coex_stat *coex_stat =3D &coex->stat;
> -	bool rf4ce_en =3D false;
> =C2=A0
> =C2=A0	lockdep_assert_held(&rtwdev->mutex);
> =C2=A0
> @@ -2587,9 +2561,7 @@ static void rtw_coex_run_coex(struct rtw_dev
> *rtwdev, u8 reason)
> =C2=A0	coex_stat->wl_coex_mode =3D COEX_WLINK_2G1PORT;
> =C2=A0
> =C2=A0	if (coex_stat->bt_disabled) {
> -		if (coex_stat->wl_connected && rf4ce_en)
> -			rtw_coex_action_rf4ce(rtwdev);
> -		else if (!coex_stat->wl_connected)
> +		if (!coex_stat->wl_connected)
> =C2=A0			rtw_coex_action_wl_not_connected(rtwdev);
> =C2=A0		else
> =C2=A0			rtw_coex_action_wl_only(rtwdev);
Hello Ping-Ke Shih,
This is kindly reminder. Could you pay some attention to this patch and
clarify if the rf4ce is actual for this moment and future?
--=20
Best regards,
Dmitry Kandybka

