Return-Path: <linux-wireless+bounces-3078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35189848557
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 12:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA491F236BF
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 11:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945C5D73A;
	Sat,  3 Feb 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="tmDtj0zZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BB5D726;
	Sat,  3 Feb 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706960015; cv=none; b=XtIm+rhncmLNx5ar7Mv1Tk38fWy7/1yDucyWNIyHAjITpAm6Uq3MtO1u3Rgisa86a+XKNU7frkCzFQMHdvlDAT8RAnsyYHYfBHf5XuMmo1rkJvGaOzgB1++Gr0lVuyOMS2NPuRdP6ZGkVmiYEhN0n9OzYyrPabbw31PNt5HULBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706960015; c=relaxed/simple;
	bh=bgD8fPsD6rucRhfmj7UwDFyCl4hpGwh5qXgmHJFOZOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnSxDQonjvQLtbMd0xe9kIh6REm9J/yZkkFwCjnHvafgKfD1VB71RCx+/SNQa7xJyeGkY44JlX7f7e8Xcbq8XBWlsz/Eb3Qw86Rga9eRq4lZbJ13jo5vAJtMX2rZkEQoBTHHbPgMnIwa1Q+hr4mTXx/vC3VWsafa8VRiWaXtPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=tmDtj0zZ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706959997; x=1707564797; i=fiona.klute@gmx.de;
	bh=bgD8fPsD6rucRhfmj7UwDFyCl4hpGwh5qXgmHJFOZOk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=tmDtj0zZR9Am+r9cU3IPT9h2xGFOxfddyewiP9Gh3EGvnFB+9qz1oxj1I6QBv1Xb
	 OQVU4JHMvHMzChhkVqdErRUc3mCNNmFt28IwgpWfCeLSEGg/TP97hv5FiDwOn7v5b
	 6dL1otCpWVY5p5HSsK2xSBGiPt7LEcQFERx7bhp4HtVSAGL4oTnL0n57Z4MP7APHQ
	 u7XuKbWXoRMncyIrDfLsdZUty1gd44U5a55nDHVGXLCkI7iJiJuBmO67AJ5HOvxDv
	 UApJQHl/XaKZ2ahyne17NY3U9Es1NwSE0/hRfhvrKx498MCo4tHKWd1Kn51cjw5so
	 vSzMhHQ4HhYv43LNxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.25.120]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7i8Y-1r14YQ3sLS-014gaL; Sat, 03
 Feb 2024 12:33:17 +0100
Message-ID: <87369c01-500f-495e-9158-09578d582748@gmx.de>
Date: Sat, 3 Feb 2024 12:33:15 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rtw88: Add support for RTL8723CS/RTL8703B
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
 Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org, Ond??ej Jirman <megi@xff.cz>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <Zb1WGafVyr5cLPiH@mobian>
Content-Language: de-DE, en-US
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <Zb1WGafVyr5cLPiH@mobian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t8CugUa/4WzDhgwXa02oZXNIe9N/+qzstiyX/UZKhmqETSBKTQR
 SIlM68Tu/Jh8436fw1BF90sB5SXW5NJIcMT60ZoZuDGax9dzLaRUC/c8pRhVd5VmJEO2tb/
 Qxul/OAMLwnMoTcbwONFq5BIApnEj5ucw8z/AAuaMJsrXLVrTNQqU/y9HpWpNarI7Pv6z0C
 fPaiJWdKEznPUh8/PlxaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Jc3lH7bf/U=;ji98DuBxvgmHwnfppCGSUecl4/H
 coXwOlm8qJDbszlyy3QmGHN+o0AxAgTDKmmHNSVaXqKy222h4wTtxWcPOWiceo86a+QmnPhGC
 Xj7VwEi02/xHoYF4WtOvtuf6Brs7agoJpQhXEKgfHKSHyCzOuXZFoQr5TDrs5/q8dlap/QkYj
 gXmbnfJn1+2Rxp/xeyB2G7Tng0nByA42JY0vUOA/V8Z9yc7nY9L8PMSV1FsZkSG4X1BVokYkC
 mHYn7TUrAMEdbA7xLy/tz+KEc9i58JGfLsU0TVSpvNIZ1lo6EzAxXXP94aR/WDGHsqDcZRKmE
 jUXrOBkt08SCZHMU/3ea/sJfyzDkGw9yR4lYakwT1M0Nbh6hSuvK55U6+1CC1em7pPIIcKWx4
 nZnp+SG8ShEMQ3dVEP8xQXntnNKGSOWsAO0YjJYjtaBBFLVcYyIzRGlnk4ioadi6i6Bu8GqI+
 K39OU53JQA0bW59MY1lkhzUwRDKi5iQDr5huzSqj4BBNcNCxmXcf3tOCvWg+43YEVr7zubHWl
 NFPeNfswC4uPBLAOh40uIe/v5qqxtSkrGHHGahxrfvHcOxNz0lx/Qih/GJAYod1V/tryblpJg
 nn5/Ez83yeRJd2SJmUTSU2hOPvfUcTqVI91tsKAljwDz8NYu37Y2P6XxPoabTTdY78edW1eDg
 6wXZaR3D9jgKQlbKEL8zh2tTdXsqNHEbZeeWbu5SwG4dZPlzdqxAAyJsOHUIK+S0/dZe2lT9u
 Gdx05FcPUvIbQWyKWOZ6G6F8Y+wqG06x5cXPBQdu0PjB2Cv/OB74ghjT1sX6qbnYLOcqRldyY
 Fjt5z3PuFTABVuBcRL2ZOJOjkNCPECvqsMJ2swyBgJBUg=

Am 02.02.24 um 21:52 schrieb Pavel Machek:
> I tried compiling *23cs into kernel (not modular), but that one fails,
> with "multiple definition of rtw8723x_iqk_backup_path_ctrl" and
> similar. Sorry, can't cut&paste right now, but it should be easy to
> reproduce and fix.

The IQK helper functions need to marked as static, after that (and
adding firmware to the initramfs) the built-in driver works. Queued for
v2, thank you!

Best regards,
Fiona


