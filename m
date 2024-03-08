Return-Path: <linux-wireless+bounces-4495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9B2876730
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 16:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC80A281372
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7C1DDEC;
	Fri,  8 Mar 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1a/ZMv9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8E4400;
	Fri,  8 Mar 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911151; cv=none; b=QoM5EcXd5+204dKuoiNdFp5S6SdtNEKSKEVc1ol0Ui75SJ0IXirUqzDdeMHSs2zyockH/S+eqcWAfEZwGuWYRb7b7GK69dgreFQ69zSDhzfUQvSo0HaAKti3I4dWUU1NOvF6E49GRE0vdI3f1S8T7rXil0jSruRS+7i3TDv7LWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911151; c=relaxed/simple;
	bh=2aEWrJvvukoPuyYJLD9Zn0ge1MPAdinGfbWVtaTvHp4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GlDAJt6AW+/jNWisHYnwiOJ21qpi/H5MvbAllD1mw2tIRQnvT+ZFKOyWX9BcXT7yb0ECgGDTx9RWHfKRZLeLjtMAUu8/GQxUG/IjF4eygkOcgzTLl3yieMKtGS4ec/v9masDrw3j/LfUqKGw1NfrW0QkonhH6DFi2kya+CDrAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1a/ZMv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DDDC433C7;
	Fri,  8 Mar 2024 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709911150;
	bh=2aEWrJvvukoPuyYJLD9Zn0ge1MPAdinGfbWVtaTvHp4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=e1a/ZMv9W69wCrDHRgkvlZIa4zoUJ8J8Q3ymIbKisGFKt85jmdi8rfigpLWuxyFVV
	 0NMyFXtGSPpANaWp4n+9q7gax4lJv6/l/ymG2gcd8wjKVcn2OYjQ1nlW0pHBvhwvlu
	 1WSi0bGr3izdfGytW1OtnQXfBWA/rRrzf3KgYRsKCyT9k2R1DLweSj4xcahwGjiTPS
	 LCNlE5MKl+CpM8Enh+hZWwiAnV0G67ryNjl5C8rOiWaT6dXdIidkWXKtNY5hduirgp
	 y/3xoHrWixGF2LDAur5awj7cBiaNBTUXF9V3bqbfjuerY2BtKIJku2z3U6hBDIDv92
	 lL4q8dkNZ2MbA==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  ath10k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-arm-msm@vger.kernel.org,  Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific
 firmware overrides
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
	<87plw7hgt4.fsf@kernel.org>
	<CAA8EJpr6fRfY5pNz6cXVTaNashqffy5_qLv9c35nkgjaDuSgyQ@mail.gmail.com>
	<87cys7hard.fsf@kernel.org>
	<CAA8EJpowyEEbXQ4YK-GQ63wZSkJDy04qJsC2uuYCXt+aJ1HSOQ@mail.gmail.com>
Date: Fri, 08 Mar 2024 17:19:05 +0200
In-Reply-To: <CAA8EJpowyEEbXQ4YK-GQ63wZSkJDy04qJsC2uuYCXt+aJ1HSOQ@mail.gmail.com>
	(Dmitry Baryshkov's message of "Wed, 6 Mar 2024 16:23:55 +0200")
Message-ID: <87v85wg39y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

>> To be on the safe side using 'qcom-rb1' makes sense but on the other
>> hand that means we need to update linux-firmware (basically add a new
>> symlink) everytime a new product is added. But are there going to be
>> that many new ath10k based products?
>>
>> Using 'qcm2290' is easier because for a new product then there only
>> needs to be a change in DTS and no need to change anything
>> linux-firmware. But here the risk is that if there's actually two
>> different ath10k firmware branches for 'qcm2290'. If that ever happens
>> (I hope not) I guess we could solve that by adding new 'qcm2290-foo'
>> directory?
>>
>> But I don't really know, thoughts?
>
> After some thought, I'd suggest to follow approach taken by the rest
> of qcom firmware:

Can you provide pointers to those cases?

> put a default (accepted by non-secured hardware) firmware to SoC dir
> and then put a vendor-specific firmware into subdir. If any of such
> vendors appear, we might even implement structural fallback: first
> look into sdm845/Google/blueline, then in sdm845/Google, sdm845/ and
> finally just under hw1.0.

Honestly that looks quite compilicated compared to having just one
sub-directory. How will ath10k find the directory names (or I vendor and
model names) like 'Google' or 'blueline' in this example?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

