Return-Path: <linux-wireless+bounces-9726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E15891D0F6
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB1D1C20A47
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D808136E0E;
	Sun, 30 Jun 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Ai/47YDR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91717736;
	Sun, 30 Jun 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741308; cv=none; b=EERxSsKDly041njmuQZuhRYEtr6qUTeXeGWOpNqXF9gmVBYiHe0Pn1xV3+VeOVXKX5fs9ZTyrx3BRFOzB9/3ni6Jj1J59iVKFUXbPezG4vM/hjmvmgphXr2bgAz6ptIhvodlKQveSxljsIo3qJhG1OBYVQ9bfTLprPLu6kIU+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741308; c=relaxed/simple;
	bh=vlpdb/+H3zch9Ng49zn3tG7OaI4bM4ldo+uRPLJ3wXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXGCR9JoTOVFfZNpPV+LSS/KU/7JQM7wF/VExnTvHqTQa2MOsaDhaVKJrkYBujCIh/wZT2U6QKMVOTx8m93Y0CbDSidBRd202nI6NX21QOx0CWsrglIqXJy410YJlcKznbpQibZkMEzW460B68Q0Jfsn4r9v5u0a5xHGbOISbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Ai/47YDR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719741254; x=1720346054; i=wahrenst@gmx.net;
	bh=vlpdb/+H3zch9Ng49zn3tG7OaI4bM4ldo+uRPLJ3wXE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ai/47YDRf5utuBKzfB3ej2YKAzV+lDZYR5XR+Isvq4E0WwKo2U9sKxl6hRw5gMJA
	 6BrTlRB7cZwSYmUSGigwNkYIUj/rrf0K/P2DexizYVFa9LXwZ/CX2s+chSH4CmLYg
	 m2heyiUnmj5eqtOlWEpQfEbTGfF/MyEWn/t7Ni8j4tZB+mvX1yW1g3maPvK5LokXG
	 2lS1SumMnYNAAxkMa8mcxf5U2vh2/v8GLQBpb3wkO7wj1MOdBKtaJiV+K+T3vDAZS
	 qjG0U1eAnGKi6z3ijjV/tMxnEsGX9urMT3xEeqeMmncoHDVhGjkzHFdLfuWUqP8K6
	 mIe2NVfcuTABNojHug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowGU-1s5p8a1DIs-00ntu2; Sun, 30
 Jun 2024 11:54:14 +0200
Message-ID: <8e44631c-955f-42de-bb2f-f3a32c79f1c1@gmx.net>
Date: Sun, 30 Jun 2024 11:54:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] wifi: brcmfmac: Add optional lpo clock enable
 support
To: wens@kernel.org, Jacobe Zang <jacobe.zang@wesion.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "heiko@sntech.de"
 <heiko@sntech.de>, "kvalo@kernel.org" <kvalo@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "efectn@protonmail.com" <efectn@protonmail.com>,
 "dsimic@manjaro.org" <dsimic@manjaro.org>,
 "jagan@edgeble.ai" <jagan@edgeble.ai>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arend@broadcom.com" <arend@broadcom.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz"
 <megi@xff.cz>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "minipli@grsecurity.net" <minipli@grsecurity.net>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 Nick Xie <nick@khadas.com>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-5-jacobe.zang@wesion.com>
 <bd661690-1de8-4030-a209-ef26d3559221@gmx.net>
 <TYZPR03MB7001AC28827A86338BF2B77380D22@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <CAGb2v66Vk8SMs1TOs+80Jy5fXumuYqCx59Tzd_N7wJAfyysQcw@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CAGb2v66Vk8SMs1TOs+80Jy5fXumuYqCx59Tzd_N7wJAfyysQcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wgVhvE1mQNGeE2c7GCy2YyHYqkHv0qtOLjU7gMUJRPduSP6aA3d
 C9KM/Dt6TwOjaZ7HiyF3/nZyFDWyyWRIs+ouU39gaTmCUSj+NLjfNKaVbadSY0enNNn20Bq
 WaQNjsTAunVtOYNhLO0pmOsKbTYmidIAghz96D3nAxbl9chvh52l2B2//peoMffCZK/a+Bd
 GAcWy0CtQmHsetg6+4HvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z2UQengSf74=;8/TGaodA/VNt91yVVeHooACI4JX
 AzSwAjWjUMX6+Ac/4FM0k8j4gxdcmVxIiqpvF79mx4rXhSZUwNIjN6GV6Qx7ifdfqfErXGrxG
 WkkrxACr+fmANXQGN6Nip/TmqNAVyXbRNAZXXDEqIF2zi/rgVMZTzOIqYUyWfFcSVWMSByOiY
 VXJkX7JQmNw+PZGjSay+HsCQSLQAnHx9wmb6au+lPs31TdRdlQqJe6gw5W39XNv/UvGcwu/h3
 TozVXJipA67N829fKDVAYkH4V3OY0z1pGTdXRVaj0AjK3LRdW1QwFt0urT9RSKQX4ZufV/2Ez
 NhTpNPSg9+c0cEfYVpYQlVY+bT3AIXv5Tw3TqBVBILYYNrOdi/CVD6Eg9TqUV2SEB7Wr+FfwT
 kjDPFx6mS8fIJE/OKFBmAqbrPeo1cLxF0GDg7/DxctNutdH08J4btOKBSAMSu8WmklrKIPOcs
 MqB3PCdsaduEjMOfzDHha4tGJsHQ4x7pX1tsi1Jlmou2RaRSqc70mglwnphmOvi1viEXPWHGb
 Wfhj5MMOYuRDwi1TBdrfzCdg6Gfn7aL5cQN54KnXm7cXg/BfVGBUqm8gbeK8tIEB7vnN1CIfK
 XFUeMkxSjzp9JYUE09fTl1N9M9LHzOutBez5h7ELJEe0b2Eng5gOK1Z0HqduecgXIRHxdmNcE
 cG56KXSC4n4+QrTcH/mTC1X4kcr/04BLWokrFoxJ6jdoVNUHpepbdh0Ephgus8JmON4jPutyC
 pc2+2m8aaCqtg1XKQO0khCU3uY0S8ff1u2tYDV/e6vAdeIQO0oXvet5RYByOJKkxrVlaWRjIN
 TepscKIdm7O0fKhT7fim6wwg9Tn71VIgEdT/VQbRLAIY0=

Am 30.06.24 um 11:15 schrieb Chen-Yu Tsai:
> On Sun, Jun 30, 2024 at 5:10=E2=80=AFPM Jacobe Zang <jacobe.zang@wesion.=
com> wrote:
>> Hi Stefan,
>>
>>>> WiFi modules often require 32kHz clock to function. Add support to
>>>> enable the clock to PCIe driver.
>>> the low power clock is independent from the host interface like PCIe. =
So
>>> the clock handling should move to the common code. Sorry, not i cannot
>>> give a good suggestion, what's the best place for this.
>> I think the clock is used by the PCIe device so enable it in this file.=
 Also I checked
>> use of clock which in spi[0] or sdio[0] device was enabled similarly to=
 this.
>>
>> [0] https://lore.kernel.org/all/20210806081229.721731-4-claudiu.beznea@=
microchip.com/
> You're looking at the wrong driver. For brcmfmac, the lpo clock is toggl=
ed
> by the MMC pwrseq code. And for the Bluetooth side (where it really matt=
ers)
> for UARTs, it is in drivers/bluetooth/hci_bcm.c. and documented in the
> binding Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
Thanks for clarifying. So this change handles the PCIe case without
bluetooth. For USB the clock control doesn't make sense.

Sorry for the noise
>
>
> ChenYu


