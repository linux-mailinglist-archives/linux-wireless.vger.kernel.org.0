Return-Path: <linux-wireless+bounces-9719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DF91D08C
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 10:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1607C1C20AE4
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 08:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8212C489;
	Sun, 30 Jun 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="GSCRgTX4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280E7B3FE;
	Sun, 30 Jun 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719736062; cv=none; b=CNo4MFirPY61jlzU4SE9P0kvQdIfwJ6hQZQZyVWeCTZ+i07lSzuS+q1T/gpKM+DUr22M+vs+EZl45R4Hz+DlMajVO0Ke7uxph7OZewQgx95R2psdibzF/Bg3qCnDdF7H/QfTe7tdDVjypLJk+gFNmuqwnMBVGoTXAEAnUYUSlh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719736062; c=relaxed/simple;
	bh=mEH+UpZfHB0izTrzQvX9YTRSwDv76x2qO7S3xISkzBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkOsMSLSwRXE2ij0zvXUWb4tCFOBmDt+r4L4R2Kq4zdgVe4gsFwD6yc11vhYrIRqHTiTZd2ovZnqW/vJZ+XJy9qWywySJvOpRE1A6NPReCKajIn+iB8tX9eWTI2ZS4Unbhj/8Z0ha0vjpsYtMIKVuln7oxpL9haqGPs5S5uOE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=GSCRgTX4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719736014; x=1720340814; i=wahrenst@gmx.net;
	bh=nsatQbMwWazHWjCGtPZLKlMFGJm60bL4DCX/RYQYfww=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GSCRgTX4Am+7nOm4ncdp9J/Y7GRlnUM6LXDeq2RU2gUd3caDn7gWMgXTWxb/+TD4
	 eUkrjpC8L1ttI2AFHTIUUgvoBcfIYlJWfFJwu5Jj/4xlph3YT5iou9i5p6/8IRRpJ
	 /3ct08Z0BKZz/nI7HIJoZZsQ/z+n1u/5T4JvMcaTourJFhO8jglwFhjGhqiNg/kaZ
	 ma+gtHhwgcuTsxrqO+8he4W9MUaJmR1Znq+5SPOL3sRCWA0ta7dA7Dc5+ZwnuNVVf
	 FOTR9pRkBnPaSu6+mxPHokRI1YXLLeq+dK/L/HHdg8UbLwTBTpGUrUtKwjsnT6BQ6
	 GEq6/jBpaXlRggxh2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1spQu947xU-00UhCM; Sun, 30
 Jun 2024 10:26:54 +0200
Message-ID: <c34d4c60-da28-40e9-b86e-41bf8cd71b24@gmx.net>
Date: Sun, 30 Jun 2024 10:26:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dt-bindings: net: wireless: brcm4329-fmac: add
 clock description for AP6275P Wi-Fi device
To: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org,
 krzk+dt@kernel.org, heiko@sntech.de, kvalo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, conor+dt@kernel.org
Cc: efectn@protonmail.com, dsimic@manjaro.org, jagan@edgeble.ai,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 arend@broadcom.com, linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 megi@xff.cz, duoming@zju.edu.cn, bhelgaas@google.com,
 minipli@grsecurity.net, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, nick@khadas.com
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-3-jacobe.zang@wesion.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240630073605.2164346-3-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UsRdSvMT7LvqkBgf2MMlJCt+oUY1cPrdOCam4+DWocwBgRUGkOR
 umY/KuFxXQuMBWvZsS5NdefexWZFw8/pt+cTQv67MH9xqR/BXA+SUnkmyjTihU3ZnaxAQIe
 aCIskfUAQYpGN3YLc84ogq6vAiA5whIEv1r43hSsgZzzQPr7czy5M+Y79dJ7/nBr4MXtCuw
 of0ETPM/bJYTY/pLEoljg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jLcFPFMzJLY=;HtTlBMAMOmLTFxw4iUjwe9NTF5C
 pyl7n3ID/f82VtW1rUN6slUucWjkEp3ojdLF0Tl276NFePfzUUzXnkI+oPZdGXLBQQ7lmL7gM
 ndLqvl15lozGNKqwHwcJKBU+9quLwf49NtLNKe01o/hnXOfyy8wtf7P+Eo7r/+4rdf5RCqMZL
 Po55mXOZ2dvLzO+ibimw5RIG4faUhdjYPyty8dQsGBuzKWG9Usz+QHWkTlrBPD79cJl+GSpyp
 5WQpZ/9cHqJQxxjaDZnMUYR5ihbk9Nsec0J6PeEVWSzd+UM4CACmzMkr6gTfCPnLNbpaFtZCS
 e6y8D6ahAahN12n7dyV5olua2EOuVsPEPpL0AmwvqXAxx/kb9T4ZWkjtE+IQHM0d5rYcbTvL+
 0mfd54YDYQafj7H+6EFdEDorGu9ESfLu6+Hyl/SerpmfGpLJIUl9hdmmOfLxInobmjSnpurEX
 Nbj75UWBWW4uEJfQiL0IsEPjv99wnps4yFqfvvF0pfdO2KYOZ6fsqKP29hadr03UWE+THx3Um
 /52APqAAxlJmzt07J/7tZ76xWMmXb7tasF7/1jvmKXtMAY0Afm8owjkw/do5qeHJI3IIX0BsY
 SmTCSYH1W7ZrIe/UQNEorlc6VNzQMVvZkVreOaYazC7PaqHDZQtZdnaezAhaKBy/4d2ZMRFWR
 x9OdcWCvFoPXGhIOI61Cft7K7eVMu7to5TMv1RA9nWWJyvAeUAFEOAF1moyqU6GFy/iWcszJx
 MTyAzcm4PQaz3gtTE7LzWy5X7bQvBQu0Vme/Omani5jxD0Xi1ufS85Yt2wjJbmRyVHbW6l8KO
 uduLZSY3/mOE8pffpLrVFdp2NOb9m1zPOmNnBBM/dLN+w=

Hi Jacobe,

Am 30.06.24 um 09:36 schrieb Jacobe Zang:
> Add clocks and clock-names for brcm4329-fmac.
thanks for taking care of this. According to CYW43455 datasheet which is
also covered by this binding, there are more clocks in the hardware
design, so i suggest to reword subject and commit message that this
patch only adds the low power clock.
>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>   .../bindings/net/wireless/brcm,bcm4329-fmac.yaml          | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329=
-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-f=
mac.yaml
> index 2c2093c77ec9a..f542b60e44dc4 100644
> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.y=
aml
> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.y=
aml
> @@ -122,6 +122,14 @@ properties:
>         NVRAM. This would normally be filled in by the bootloader from p=
latform
>         configuration data.
>
> +  clocks:
> +    items:
> +      - description: Wi-Fi RTC clock
> +
> +  clock-names:
> +    items:
> +      - const: lpo
> +
>   required:
>     - compatible
>     - reg


