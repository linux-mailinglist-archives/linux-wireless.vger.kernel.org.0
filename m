Return-Path: <linux-wireless+bounces-5750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789048958F8
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 17:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4971AB21227
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51CE132C36;
	Tue,  2 Apr 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Saz4vyop"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB58132464
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073370; cv=none; b=p9nMc7E/c9PvESXLo1yRkZ/rEMzHI1ggr5lXOXT0Y8ejHi/uiFrjfOncuI3gBT3yzB/naf9Kd9jJtvEteoS9e9pR+9Y9Yg807Hhgdu+FbqlRN9+CdFJaF38vup51fCrNYCP095xi5e+HrmpYdvWLDj87+iyvJHGNHbDTnPxct38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073370; c=relaxed/simple;
	bh=oTm/Gl3Jk/d758yF/LumObe856oMF+v4ETEy6+MBZFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/tq5sUNPgUKlZ4UJwP5Bg+u+YWEZwDyswo5l4fwcrllgi7avVShSnJ3Fm9d9TPeFNn0cN20J/eHjsb9s6lG4EtT1RSUS0kxwRwkTA/BISeSk9hAZSba0Um64fvM1U2wjGJRG/verPPp4P86iZWeoClMWZ50ZDyGG39PE+6yYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Saz4vyop; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eaf1a3e917so2615268b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Apr 2024 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712073368; x=1712678168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xeV/0olw1/tQOoEzRbn7wneEZCNZI4OAG5EO13F9t/U=;
        b=Saz4vyopKElnao6iWMDuzV3npxzehxo8F8V6Q+zUXNckS2S+44BF7SamupTFiwypgv
         C59dZAAvyln8nbmbwR+aDpKUesekFE1RVx29ZqkQll3NDaWRMUuWpO4eDJZ2qGrShL3n
         0VpTCqnCsCgC7QyULEee8puShZHQ7qbe3XSUJHINizekRvkdW3XSEQqxPWeAYhmJsq59
         WFEp3NLKX1DgJIdFDH6ZtzJCa47hmeIMou2M915tsgzMl9jm2F8pL68B9oLBLnji5VRx
         vEfyCZXdlwiI/Fh+iQtR2vfZhcBPT6IGTe7dP1Rdp8zqqPVKHFj7+KRSCqNRgmoQcxt8
         Z5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712073368; x=1712678168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeV/0olw1/tQOoEzRbn7wneEZCNZI4OAG5EO13F9t/U=;
        b=WiHDGX61hyAH2vv/jQ/C7rpeMv1MxAgwRKaaAsxaDdylP6H5MjaE2NkL67T+Wg7Alk
         JyOri1CwNEQfd9nYrwj9uEXLENVSAQdhYvUQ2WcG0eHjd8NZMF88haoiRTv5g0QUG2BH
         sYWlLd++iNQeXI0vSs7LBlwl3SzQqZyRSfE0LLrLkhuWfK0D/NtF3UNKFvnS67VkXHqL
         C0pk/vy2P8HqHKnG8ZETh0W5bBDcNCs/0nlemYGJi4jtLIo5tqC0kkGdXlM55o1dDuO6
         +2H4Omykz+tjVkSzb/Fr01pc4pFg3/zm0PO4RokwW2Aj/wfYCevz2d3BkraJY5UfD3aT
         xrBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2t0qfBiTPLi7Q95j5k4BRu+5ZdjVFLw0IMul4RcW4rM4658hscn51a4pkT6LmpbBKA7GOX0T21UdoPb1k85CoyWg3JGmdpcUp9ltAoU=
X-Gm-Message-State: AOJu0YyrYslrzf9P010BJwUAdMPOVTozIpeyGH1V9e8vE0AXEnRpk1/W
	uYUghGTwhXNlKmgKaSY0WFEbYMdER/aA7/HE2NB/g4Yxxiftvwssy6XJyp4h510NqHD3p9eyPf7
	X3TKhcDPBZTkyFsoQ5ZY1nz/jicJt7csuoeOhDw==
X-Google-Smtp-Source: AGHT+IH6biaoyoyXGVcuVSEJ64ktCWPrzGD+BguHOuhX547CoHoNCMxaDcDjufoVG68y80EXUw7JQLAEWOsngyWHeXo=
X-Received: by 2002:a05:6a21:9992:b0:1a3:6ee9:305 with SMTP id
 ve18-20020a056a21999200b001a36ee90305mr12284409pzb.2.1712073368128; Tue, 02
 Apr 2024 08:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr> <252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
 <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org> <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
In-Reply-To: <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 18:55:56 +0300
Message-ID: <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set qcom,no-msa-ready-indicator
 for wifi
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k <ath10k@lists.infradead.org>, 
	wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>, 
	MSM <linux-arm-msm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>, 
	Bjorn Andersson <andersson@kernel.org>, Jami Kettunen <jamipkettunen@gmail.com>, 
	Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 18:31, Marc Gonzalez <mgonzalez@freebox.fr> wrote:
>
> On 02/04/2024 16:34, Konrad Dybcio wrote:
>
> > On 30.03.2024 7:25 PM, Krzysztof Kozlowski wrote:
> >
> >> On 28/03/2024 18:39, Marc Gonzalez wrote:
> >>
> >>> The ath10k driver waits for an "MSA_READY" indicator
> >>> to complete initialization. If the indicator is not
> >>> received, then the device remains unusable.
> >>>
> >>> cf. ath10k_qmi_driver_event_work()
> >>>
> >>> Several msm8998-based devices are affected by this issue.
> >>> Oddly, it seems safe to NOT wait for the indicator, and
> >>> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
> >>>
> >>> Jeff Johnson wrote:
> >>>
> >>>   The feedback I received was "it might be ok to change all ath10k qmi
> >>>   to skip waiting for msa_ready", and it was pointed out that ath11k
> >>>   (and ath12k) do not wait for it.
> >>>
> >>>   However with so many deployed devices, "might be ok" isn't a strong
> >>>   argument for changing the default behavior.
> >>
> >> I think you got pretty clear comments:
> >>
> >> "This sounds more like a firmware feature, not a hardware feature."
> >>
> >> "This is why having this property in DT does not look right
> >> place for this."
> >
> > Translating from dt maintainer speak to English, a functionally-equivalent
> > resolution of adding an of_machine_is_compatible("qcom,msm8998") is more
> > in line with the guidelines of not sprinkling firmware specifics in DTs
>
> I'm not so sure about that, as I had proposed
>
> +       if (of_device_is_compatible(of_root, "qcom,msm8998")
> +               qmi->no_point_in_waiting_for_msa_ready_indicator = true;
> +
>
> To which Conor replied:
>
> > How come the root node comes into this, don't you have a soc-specific
> > compatible for the integration on this SoC?
> > (I am assuming that this is not the SDIO variant, given then it'd not be
> > fixed to this particular implementation)
>
>
> Then added:
>
> > A SoC-specific compatible sounds like it would be suitable in that case
> > then, to deal with integration quirks for that specific SoC? I usually
> > leave the ins and outs of these qcom SoCs to Krzysztof, but I can't help
> > but wanna know what the justification is here for not using one.
>
>
> Then Krzysztof added:
>
> > The WiFi+BT chips are separate products, so they are not usually
> > considered part of the SoC, even though they can be integrated into the
> > SoC like here. I guess correct approach would be to add SoC-specific
> > compatible for them.
>
>
> So, if I understand correctly, I take this to mean that I should:
>
> 1) DELETE the qcom,no-msa-ready-indicator boolean property,
> 2) ADD a "qcom,msm8998-wifi" (name OK?) compatible,

I'd say, this is not correct. There is no "msm8998-wifi".

> 3) ADD that compatible to the wifi node in msm8998.dtsi
>    compatible = "qcom,wcn3990-wifi", "qcom,msm8998-wifi";
> 4) In the driver, set qmi->fake_msa_ready_indicator to true if we detect "qcom,msm8998-wifi"
>
> And this approach would be acceptable to both ath10k & DT maintainers?

I'd say, we should take a step back and actually verify how this was
handled in the vendor kernel.

>
> Bjarne, Konrad: is it OK to apply the work-around for all msm8998 boards?


-- 
With best wishes
Dmitry

