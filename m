Return-Path: <linux-wireless+bounces-13724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C580F9953D7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032B61C211A8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCA71E04AD;
	Tue,  8 Oct 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5KoS8ku"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990191E0495
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402902; cv=none; b=XJEDJsJij6A7Gulr0c7jPcEaiwMDaPw+XlbKDOwOnIVznsZgbE1TneGXdg9xFU+Yviiz2/qa8tqo2Np2T0TQx3+2OXzhDc6kNQsQpe3hqBNZP56sgVV5uWGZSppheJf+/0PAjoCs6nqDYjNmF5Pt7i7sHUFU5HaslwcJUtkAAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402902; c=relaxed/simple;
	bh=1xWwsNJSaWYU3Vwc/kd5e2S3gWaAprl5IlFQ2noiFa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVOFO1zz++BhfvGj1wISQq4P2vQQ+tBCKbs9NrInNoVY33Bbs3WdXWAg2Asyt/MGSsjqmdKT4m+8z2aVw4dYFLASpGXxMdH0r3DMIJlWVyjXDQOOIPApKSHZ3uOllwWkmDTL8GYlr40G7pITmfvOF0hchNmjbRL5k7SIT13aEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5KoS8ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE666C4CECE;
	Tue,  8 Oct 2024 15:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728402902;
	bh=1xWwsNJSaWYU3Vwc/kd5e2S3gWaAprl5IlFQ2noiFa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m5KoS8kuZJ5bARZdMTF5ZQ4tRfTqMpmNYKMlC89oYdBpmC0FjHVbpO0Gd38GhE6A2
	 BDQ1inAepvBPIVnsMG1k9NrV0O1NJd8BH8GWUjkXFbdX06z3gLlW+mqZv3GDJhn3Xd
	 uOnaAgX0C8dWksiezlIarp9wkQBUsrx8GklLhlunOtn0sLy8Xw6IURy2YPc6dJfi14
	 g+kDuv1ahcR1a5T0vRcUiNpGtEUsZvS/3Dwd7ajimR/MyKuDyh8ywcGkLhPoNRnLTv
	 UCA/L088YwI2Q6necYsginog5HABWYWLfgsnhPypcOvnNtkjNN48ToPnnR95lJHlbj
	 AYvwS2Akns3Wg==
Message-ID: <1cf6d772-e7e0-4e40-bcac-d687706f1055@kernel.org>
Date: Tue, 8 Oct 2024 17:54:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] wifi: mt76: Fix NULL Dereference caused by
 mt76_connac_get_he_phy_cap()
To: Zichen Xie <zichenxie0106@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 johannes.berg@intel.com, quic_adisi@quicinc.com, deren.wu@mediatek.com,
 chui-hao.chiu@mediatek.com, mingyen.hsieh@mediatek.com,
 howard-yh.hsu@mediatek.com, StanleyYP.Wang@mediatek.com,
 allen.ye@mediatek.com, benjamin-jw.lin@mediatek.com, Bo.Jiao@mediatek.com,
 evelyn.tsai@mediatek.com, meichia.chiu@mediatek.com,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, chenyuan0y@gmail.com, zzjas98@gmail.com
References: <20241007233501.11773-1-zichenxie0106@gmail.com>
 <cc48d505-62b0-4407-aff2-f9088170ddc2@kernel.org>
 <CANdh5G4r_WVt3ao0sFqFA7F3BUHi9wNwWENVHjPXyRGq2sotZA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CANdh5G4r_WVt3ao0sFqFA7F3BUHi9wNwWENVHjPXyRGq2sotZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2024 16:34, Zichen Xie wrote:
> Hi,
> 
> But Matthias suggested checking for NULL immediately after the declaration.

Why do you keep top-posting? Matthias also asked you to stop, so that
part you ignore? Responding to such HTML, top-post emails is a pain, so
that is the last time I am writing here. I will be NAK-ing other totally
bogus and untested patches, though.

> Re: [PATCH v5] wifi: mt76: Fix NULL Dereference caused by
> mt76_connac_get_he_phy_cap() - Matthias Brugger (kernel.org)
> <https://lore.kernel.org/all/7daf8976-91ee-4045-a9a7-d9d14d53c6dd@gmail.com/>

Don't send HTML. Anyway I do not see anything indicating that this
should be before declarations. I see clearly: "before any use of struct
vc." which is not before declarations.

Best regards,
Krzysztof


