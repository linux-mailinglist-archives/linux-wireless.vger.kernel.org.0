Return-Path: <linux-wireless+bounces-5905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F8899D82
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC00F1F222F9
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0EF16C86F;
	Fri,  5 Apr 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rp6+rZ9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C216ABFA
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321402; cv=none; b=Ku6wN4WLJq3IosNgTeMaYyMEWoYyKe91RVy/OUkAnvKcAevXGm3MEXurVmUArXNIRiGT4chqAmf2iEpeosmTEfy7n0m4eX4XmSLALp2LuV5Kd5snsOWVhQgnOkTUBHfskmLdxbusV3jKLKLkP/oyD/bIyELXXXciHom731fKnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321402; c=relaxed/simple;
	bh=/h5ZKUyP0Cry0+mHbTzooNJMYvg5n+9KMU/0TdwKBUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRVAvS6NFVV0zGKGbLZCrRK7cXsHsSphERdEOwBtosv7P27wlwY14IAFkx2PDqpPA9DNMoHMiFIiUqT4cpBoByNzljwccYN4q3/NlnqNQBUGFqHegDjA+kzPc7cP78zG5mMo+ocNMTCB3AETyiReeNeaLuBNf32R5plseefAI+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rp6+rZ9/; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so2056923276.3
        for <linux-wireless@vger.kernel.org>; Fri, 05 Apr 2024 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712321399; x=1712926199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/h5ZKUyP0Cry0+mHbTzooNJMYvg5n+9KMU/0TdwKBUE=;
        b=rp6+rZ9/wlE3O1qClOfG0L8PLIxmbUpZOenVR/srWXYqtseT5+l/ULqHIHQRUqTg0d
         CxbC/CWYDL0m09UAH+BPoYzSeYKU4E/75//5bsPidPrNtsrJj/N5fEQki5WYTd3QFcLg
         ASZbgcUNZhu2OVD0neIgiQb0moNPJjGr8x9CFAE7tqd8BufL4M2Z5S29VMFYYxQhlfUS
         kOMHK3oB+dpM5AnUveKI+8c9QUfoeZrLOy5xxaFDDjqKRL3e0PYP6UnHFQMmJA0DrzfH
         LCEtqxiCSdlv+yXU7Qxk0QRgbIZTXaq4pPCAoWM4t20icObba1xNokmKqYrWfQJpouMM
         LWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321399; x=1712926199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/h5ZKUyP0Cry0+mHbTzooNJMYvg5n+9KMU/0TdwKBUE=;
        b=uCOpH8Qy1VUY+nfzuiOleVt+MolznYScVbY8i6tHOmg2C9lW+1S2XaTWYE0dTXNaVT
         MJ4/EXgxmgFWK7m6E4+Z65WfuvQzkRhludK/CjcSx0clLAmTSaZSL32EHpwBsIJCpNYt
         6fkNGZAcHRNecHBs3wXkFeHcU00ZzsSc2lnUQsFMfT5C61Fj81RqikDvMMYenEcOlWvv
         /HiQQHyi6IF5AnqJslRfd4tSiuur/SMrN85Y5J7BPYZ4v9peVcypva01dneie9j719Qh
         woml7ywGTGYXCkbU/mtnx146jIr/2duQsivfhTwP3zab2x961tuiSgRWOZLji9g2Pnv8
         cWQA==
X-Forwarded-Encrypted: i=1; AJvYcCVPyfXr+eJHX1xS4vAHLjh4iXrRTifOkh3BbNu/n1iMDGZd9EWOLNR9R0cxsKhDUuGGji6gYZMnmNbSgIan/hjDVSCN9wAp60i9Wqj8IVA=
X-Gm-Message-State: AOJu0YyCyKPZTDondoiDyftmc6KTEcbnLGZ9YZNhjeGD9085mb1rGQpI
	QLK9VntZzGvUDOlBPRrA9enAOcVU8/FfN2tUGyBWhRvd38pgN8kIjCnqjNTrf/ua5c0j1QQO+c3
	vX/K88LMJHjQDf2uegECzw9SraW6FXRYDhCg9Gg==
X-Google-Smtp-Source: AGHT+IF+uYN0V7kj1WIHdUIWItVzS1wQ6IV2lWWc/0drhKwFzKBD2YiWPAiRHKjXhywplhFwsAgFyDg/DQC+/Ij0EOk=
X-Received: by 2002:a5b:9c5:0:b0:dcc:4b84:67cd with SMTP id
 y5-20020a5b09c5000000b00dcc4b8467cdmr937832ybq.9.1712321399265; Fri, 05 Apr
 2024 05:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
 <87plw7hgt4.fsf@kernel.org> <CAA8EJpr6fRfY5pNz6cXVTaNashqffy5_qLv9c35nkgjaDuSgyQ@mail.gmail.com>
 <87cys7hard.fsf@kernel.org> <CAA8EJpowyEEbXQ4YK-GQ63wZSkJDy04qJsC2uuYCXt+aJ1HSOQ@mail.gmail.com>
 <87v85wg39y.fsf@kernel.org> <CAA8EJpq_XLUEMC67ck2tZRjqS0PazCkQWWMGmwydeWxTETHwcg@mail.gmail.com>
 <871q7k3tnq.fsf@kernel.org> <CAA8EJppASEmj6-Jt7OCABAeqr8umSgXaDDha9nn2nRafuZ-Gvw@mail.gmail.com>
 <87sf002d8d.fsf@kernel.org>
In-Reply-To: <87sf002d8d.fsf@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 5 Apr 2024 15:49:48 +0300
Message-ID: <CAA8EJpp4J4b1mpkkeVCsnjVw83E7jmu+3yHActTNEeGcOKHPrQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific firmware overrides
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 15:41, Kalle Valo <kvalo@kernel.org> wrote:
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
>
> > On Fri, 5 Apr 2024 at 15:01, Kalle Valo <kvalo@kernel.org> wrote:
> >
> >>
> >> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
> >>
> >> > On Fri, 8 Mar 2024 at 17:19, Kalle Valo <kvalo@kernel.org> wrote:
> >> >>
> >> >> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:
> >> >>
> >> >> >> To be on the safe side using 'qcom-rb1' makes sense but on the other
> >> >> >> hand that means we need to update linux-firmware (basically add a new
> >> >> >> symlink) everytime a new product is added. But are there going to be
> >> >> >> that many new ath10k based products?
> >> >> >>
> >> >> >> Using 'qcm2290' is easier because for a new product then there only
> >> >> >> needs to be a change in DTS and no need to change anything
> >> >> >> linux-firmware. But here the risk is that if there's actually two
> >> >> >> different ath10k firmware branches for 'qcm2290'. If that ever happens
> >> >> >> (I hope not) I guess we could solve that by adding new 'qcm2290-foo'
> >> >> >> directory?
> >> >> >>
> >> >> >> But I don't really know, thoughts?
> >> >> >
> >> >> > After some thought, I'd suggest to follow approach taken by the rest
> >> >> > of qcom firmware:
> >> >>
> >> >> Can you provide pointers to those cases?
> >> >
> >> > https://gitlab.com/kernel-firmware/linux-firmware/-/tree/main/qcom/sc8280xp/LENOVO/21BX
> >> >
> >> >>
> >> >> > put a default (accepted by non-secured hardware) firmware to SoC dir
> >> >> > and then put a vendor-specific firmware into subdir. If any of such
> >> >> > vendors appear, we might even implement structural fallback: first
> >> >> > look into sdm845/Google/blueline, then in sdm845/Google, sdm845/ and
> >> >> > finally just under hw1.0.
> >> >>
> >> >> Honestly that looks quite compilicated compared to having just one
> >> >> sub-directory. How will ath10k find the directory names (or I vendor and
> >> >> model names) like 'Google' or 'blueline' in this example?
> >> >
> >> > I was thinking about the firmware-name = "sdm845/Google/blueline". But
> >> > this can be really simpler, firmware-name = "blueline" or
> >> > "sdm845/blueline" with no need for fallbacks.
> >>
> >> I have been also thinking about this and I would prefer not to have the
> >> fallbacks. But good if you agree with that.
> >>
> >> IMHO just "sdm845-blueline" would be the most simple. I don't see the
> >> point of having a directory structure when there are not that many
> >> directories really. But this is just cosmetics.
> >
> > It is "not many directories" if we are thinking about the
> > linux-firmware or open devices. But once embedded distros start
> > picking this up for the supported devices, this can quickly become a
> > nuisance.
>
> Ok. Just out of curiosity, any ideas how many devices/products are there
> with wcn3990 who want to use ath10k?

Just for the DT in mainline I can count about 30 devices that have
ath10k WiFi node:

arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi:&wifi {
arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts:&wifi {
arch/arm64/boot/dts/qcom/msm8998-mtp.dts:&wifi {
arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi:&wifi {
arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts:&wifi {
arch/arm64/boot/dts/qcom/qcs404-evb.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts:&wifi {
arch/arm64/boot/dts/qcom/sc7180-idp.dts:&wifi {
arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts:&wifi {
arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts:&wifi {
arch/arm64/boot/dts/qcom/sc8180x-primus.dts:&wifi {
arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sdm845-db845c.dts:&wifi {
arch/arm64/boot/dts/qcom/sdm845-mtp.dts:&wifi {
arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts:&wifi {
arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts:&wifi {
arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi:&wifi {
arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts:&wifi {
arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts:&wifi {
arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts:&wifi {
arch/arm64/boot/dts/qcom/sm8150-mtp.dts:&wifi {
arch/arm64/boot/dts/qcom/qrb2210-rb1.dts:&wifi {
arch/arm64/boot/dts/qcom/qrb4210-rb2.dts:&wifi {

The list doesn't include e.g. PIxel 2-3-4-5 or some other phones which
are still on their way for the proper mainline support.
--
With best wishes
Dmitry

