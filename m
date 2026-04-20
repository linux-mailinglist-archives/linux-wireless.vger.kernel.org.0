Return-Path: <linux-wireless+bounces-35040-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF+zMZoK5mluqwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35040-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:14:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B8429D0E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 13:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C93C3013876
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1956A399350;
	Mon, 20 Apr 2026 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="IBn20ZWW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4D34844C
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683669; cv=none; b=Zkkh+eFvgS7qDOdIDfG1FOJuT5D3oTNBXam7h/RR6wOHWLiYF8TuHvYi//4X9Age3cW/EZbPYtx6hzYdSnqyZ3xFxY9J6I/yXnoMDAqrjdzAfPius2kk6xRv0o1VNB2lsRIPub+Vi+zUzHECxFshDFMS2UoGHEY0GZwhrTcrJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683669; c=relaxed/simple;
	bh=oo6sD9eeKJmgF8y+Mv9/ziuyg8LqE/RcnPFXODHSQBc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=BZpySO/qF3ClOrov74OUWKqdyvpJCeVl6NitR6Gq8M1M3caXewKTNwVUR/RUXnm6jw1ZSb5H+3pvC+JBcaTgQYleIYDumccXMgLNZZ7GDbb18AN79Lb+tqG8aozuMfQEP0E3xZMMHOtV2oKhwSda5P4afVmpo980SJt85aFerJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=IBn20ZWW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso34029395e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1776683664; x=1777288464; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dympeeiEyneZdFEwmKLL4dnrMWqI+ctP12odqcxsjA4=;
        b=IBn20ZWWmHujVbwaKsnlG6/fA6O6Z2q5Etxdiy0Rpua1Flfio5iuvHphA6Htwq45Ru
         s3mMLDbJzJitCNYGwhR3cCaaAbvB/WQVHdTXYCLx9Ml+1bXMjxqtxGNQ5GUGgh2cPEOt
         xWbSHmOvSqUrozSX3EIfXn1/Kjql5WN+xOBy+pyku4K/+NQjwg1Q+P5EfcFZYHDnpRgP
         093Q9FGcg5Ieo1vfOMYe13KsQZ+l+748XCsqGjAh7oX71k0klpCXcJNDTRHAcj6xVpKo
         JSTzSSLYe5WGW3+LEp0U6l0aG7rirexfpwixmMKCzWA4FtFNnMJOFXXYXH4foGTAh1DV
         JKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776683664; x=1777288464;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dympeeiEyneZdFEwmKLL4dnrMWqI+ctP12odqcxsjA4=;
        b=sHFE4Qrcpx/1lx/iH95RV2JnMyNU6iqxIkJTqWbMsBf+A+aQxKaBzTqQm6CDeVkvC/
         +gCuMM+XeuswUgsC/xd1Nf5t85z15q7+iQF11fFO/Q45X4Yo3yrSrO2op2ErRgeBKa3M
         ZLFwgUy93gAFzUwrByJg1gUI+WTpbRrr8Cn67yfntss6wbhmex0bBaob4OcPmax6F6C0
         ///HhJNRY/7swWbSl2KK7I8hY2BBRYNyOyMCtsZE1uUcUwbjmyg1bcMFT58jfDUko9/3
         vnkD3qcvsnSHhSZjK5Ua2XQ+7OASEgIpZOiZEWDbssoaZtGJs5k1lLyYB4UQ1yg2cLwL
         d+BQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sjGRSY8HPsRG0Tb9RPRhaL5w3Osl59TotcC9EVaeNMDIobH++yTqW/jCr3zemriMF1QLGxfX8/y5S4WxmJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2krU4QGiJqufFUa+KY90JhVBKcC1ggDgTNfCUXZIDKdnBctfx
	Gfs6TeVHHyIz4kGcoRizXaQqOAo3kvZxsGAkuq3jWhxAdhKbK9Be059R0/t58sl4REiM3y4HqWo
	n3cx0
X-Gm-Gg: AeBDiet6w8h7SuwboQHOk5GTbajIWI+O7UrrnBITufVGg3qi2qMirvqmUhu+ZJeHSoG
	bRmi3TI92J29oUxUwl8vV4qP6S+OSALnTBZjLaBEnPm8VrjIDJIgIUCMHeXTx/B4Pb5w1kXUodN
	HF0sICZFeUn6nw9tTxx1814Xfo8QZA/Awrim8bkpLR8nQb2SuQTdQZHrPvl7CY8RsGg9ojz2HFW
	bs9f41XFiCgRLP1jqpnFC8EpHR0yvXgoEfGbzA0NYs7gLhsWbZ2niKv8qGFLo/8Zhi57rV6sjpC
	MLKsGE3GgiHKqqyf205GBZUJ1P+FUFGZAmiMNiOhzgniacMYivANJY+xWELsDKeqezXKaMWAPmQ
	aalI/ff22GV3rPYDdGJ9rHInCYwtxr7cyLMGRIFvZhId4jpJvAgw8dZTlFQdEFnCuuw+Z6Gnw4h
	sa4CFlHkZ7+f6Z3g381Y7wn9zBkrSB2Nc6mUYzm6D2pb5UfW0CncBlXOiiYonRVJgWiB8qcVWIj
	Ibx5azVfhXjxjMa3kc=
X-Received: by 2002:a05:600c:34ca:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48a07615b87mr18212465e9.8.1776683663648;
        Mon, 20 Apr 2026 04:14:23 -0700 (PDT)
Received: from localhost (84-115-213-130.cable.dynamic.surfer.at. [84.115.213.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489393ddd69sm10775525e9.10.2026.04.20.04.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 04:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 13:14:01 +0200
Message-Id: <DHXXSDE9V52E.33D6CI1LWMHFP@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>, "Marcel Holtmann"
 <marcel@holtmann.org>, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Jeff Johnson" <jjohnson@kernel.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
 "Balakrishna Godavarthi" <quic_bgodavar@quicinc.com>, "Matthias Kaehlcke"
 <mka@chromium.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-bluetooth@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath10k@lists.infradead.org>, <linux-pm@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Bartosz Golaszewski"
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the
 device via pwrseq
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
 <DHUHU7UIT487.139L3KIVRVREU@fairphone.com>
 <hdypom3nioc6tk26gh647imy5ykhcjqvknideilnbc2b5p7eo7@hm7fsscleutf>
In-Reply-To: <hdypom3nioc6tk26gh647imy5ykhcjqvknideilnbc2b5p7eo7@hm7fsscleutf>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,holtmann.org,quicinc.com,chromium.org,vger.kernel.org,lists.infradead.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35040-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fairphone.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 459B8429D0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat Apr 18, 2026 at 9:38 PM CEST, Dmitry Baryshkov wrote:
> On Thu, Apr 16, 2026 at 12:06:09PM +0200, Luca Weiss wrote:
>> Hi Dmitry,
>>=20
>> On Mon Jan 19, 2026 at 6:07 PM CET, Dmitry Baryshkov wrote:
>> > The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreadi=
ng
>> > voltages over internal rails. Implement support for using powersequenc=
er
>> > for this family of ATH10k devices in addition to using regulators.
>> >
>> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com=
>
>> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> > ---
>> >  drivers/net/wireless/ath/ath10k/snoc.c | 53 +++++++++++++++++++++++++=
+++++++--
>> >  drivers/net/wireless/ath/ath10k/snoc.h |  3 ++
>> >  2 files changed, 53 insertions(+), 3 deletions(-)
>> >
>> > +	ar_snoc->pwrseq =3D devm_pwrseq_get(&pdev->dev, "wlan");
>> > +	if (IS_ERR(ar_snoc->pwrseq)) {
>> > +		ret =3D PTR_ERR(ar_snoc->pwrseq);
>> > +		ar_snoc->pwrseq =3D NULL;
>> > +		if (ret !=3D -EPROBE_DEFER)
>> > +			goto err_free_irq;
>>=20
>> I'm fairly sure this is now broken with CONFIG_POWER_SEQUENCING=3Dn sinc=
e
>> then pwrseq_get() is returning ERR_PTR(-ENOSYS) which is not handled
>> here.
>>=20
>> I'm observing my ath10k_snoc is now failing to probe "with error -38"
>> which definitely seems to be related, but I haven't debugged it further
>> yet.
>
> Posted https://patch.msgid.link/20260418-ath10k-snoc-pwrseq-v1-1-832594ba=
3294@oss.qualcomm.com

Thanks Dmitry!

