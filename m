Return-Path: <linux-wireless+bounces-20741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021F3A6D524
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 08:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8237A361B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB3250C12;
	Mon, 24 Mar 2025 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MfUf2jm8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7A134D4;
	Mon, 24 Mar 2025 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801652; cv=none; b=rgaGpvcPYo7DKAlYPBHeOgMHeO6Z7r/aug7DAVJBXy+T2Yhbfz6otlhGH2tjOPUtw0Bg6aK3MkV2RvlgJyB7N+XuWZ6Evy2AaDuxDYrygl7mtJ0EtF9yl6efDIzsZYyjcGELyORyFI3Z+bTL7yg3KdJQ8K+rE8W2ckJ3zzyi1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801652; c=relaxed/simple;
	bh=lHCM6K2iW1+fqMDLh9KgVtF4x5CiQjRva8x012yrIyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubyXrgjz+PvFWWjF1N9TE//cantTm0riK+Nkk4G94gYMIvrRpa49JKChanJ9nGMBU5ZpJxQyFAfkFTI9ntpEUW2i0jlg4dTzUtxqjF3NyQUL17TINXZLiGofUh1tmN1NFLo46wz2rO/I0MVcRDODuPGE0GzQ0jJyrCn9Aljt9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MfUf2jm8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742801632; x=1743406432; i=markus.elfring@web.de;
	bh=lHCM6K2iW1+fqMDLh9KgVtF4x5CiQjRva8x012yrIyc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MfUf2jm8rzqT28e1mSOGEbVg8GcCrSXq2DnnZIIL6CTEKFw1O8B1YYAxVR3p93wK
	 3jSrck64eNT3wIJZpj9xLbDs2WFdV+V3BrAUGpCKr7vLfVCO58+OYnJl61DhYjIlu
	 MCzZwMljjNCF7kBE2aU4SN9wyn/V0zSZKLCt9KlPP1pneusEByXOSzQiyj2WNUyJh
	 6uEf1GcbkuX99CUJheyEtV2PWaOJiviHiqgBRX5zMNJ5OUWFWi8bZkzQhHRe4OupG
	 YPDLypzmvAauiEAh14zVPbCGoRXox3OQWwzKB4Oud7aSyFh1REI2kzew/1ph/8WXL
	 gYY3wuMLFHS7Lub3Cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ac-1tKrO21bXi-00oDxV; Mon, 24
 Mar 2025 08:33:52 +0100
Message-ID: <46a53498-6c20-48fd-b090-02163baefddd@web.de>
Date: Mon, 24 Mar 2025 08:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: mt76: mt7996: avoid potential null deref in
 mt7996_get_et_stats()
To: Dan Carpenter <dan.carpenter@linaro.org>, Qasim Ijaz
 <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 James Dutton <james.dutton@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jonas Gorski <jonas.gorski@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
References: <20250322141910.4461-1-qasdev00@gmail.com>
 <d1df5d97-4691-40d4-a6cc-416505f35164@web.de>
 <92d1a410788c54facedec033474046dda6a1a2cc.camel@sipsolutions.net>
 <CAAMvbhGrJ9b3Aab9+2a5zmvEgf0GZFmHLCC7Hud+egUE28voHQ@mail.gmail.com>
 <223c7280-443d-49b4-96b2-90472339dcd4@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <223c7280-443d-49b4-96b2-90472339dcd4@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hPisYZtNHtgdSzDYvkU7jZ10PJssmACwm0eKAkVLKsCDI3b7xsG
 lzCWmSJHsssVXlIH/WXbNoTQQWdL2uKRi5+cu2aBCoRq8td+NnkT20JfBooQvjsecx0XC+a
 Ml1Bx1ENSjGs/NZ8CrOU68lZCqAPXZoL5nCXm2TCFWIKoraDOy7dtISm16LVoMimIarUZ88
 wJXlpqLJg8q3B3nWr5f5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jO20oZj/TDE=;aGj7rYdAkRcQW7DeTxELt09CwZj
 IMJ4QmMwA/3OFvwsgsx+W+vN98ShDLwI66ERueilwHOK24GN90dOcZ2A1m+MUdhx2kH9EtOb8
 GpBM4wwOWefzfn5U56aJhfP1E3DwV6ungO7Vvh74LZqMJE6bGTdHJMTx6R4zKOtsb4INcAHwM
 poYPqYUg5HK0TM6npx137BrPjtnruqBeRO2GQsLqZ8FTj724duSrnDT3//T6S7aMztQUaFx6J
 SkDU9SXpaIdDOp6/YoaNw8JrB1RpTKSxNIpLOrF5wOCnormOMXjAmMM5e+vSmJ0M02DS7F1cl
 DYw5vfl/PBhGELoXNFOrMyp5oFu1x+O5E51HA22nRsGOXftFcaEWTSzdxsVEePdyG+QTWEjAJ
 wMPXa7wmzCXtohStcMSk3uRk/QbwW/PW2X6bUniVdn8oAcFwVQ+0YFGYyzEog9tasB1pHsWtw
 TYAZFhNFHl+u+CzIFI2/ozAYEtATj/tCrR0g7XUTxT6TSqB2Vdb9TjvcE+gGayNWtdXm/yM5U
 e1cCx7Q+Y2syqylyrykPExIaqEnzrFA8Lmq+eReqbjcav6EsWZUOvdSF7kwCaBefwGBvcf22f
 ROchFCHsXAhpSK9gBgrAzVxoQl4qblOrpsOENuTWx9jcHsDvv5w2vHkvW4GdpzGRPRKiq5l8j
 KbWP+xgKx1HV8FpskDsEAb7/1foieNAjOwCLRZJ7SGcoTeaVczjWxg3cTG+YulML9AmTgHBA0
 zffaTDuiMvucBG2SAj/2LloeSBPIMg0xQtjHwTWkEqGcppQN8hOYzNXKcGpJiVszgB3wnjW+0
 wIczXjNR4Z8Paj5H+g537DdGuw8lrAGoQNfWK1ScAauE2IYtJPyO+mFtEzQkmYNnyVk/ompDb
 3PnMdlmAKZpPuzRbfCT+I+Z7ty9PEExDxvkJ6b3epvlbzLVtnYfPH+XSWwXIHGP+7HEehn4/s
 Rimek8h2ei3UvTqbuJK1crjfaXpN9urR0vFRJSANz0uTwLnUxicEX+vZ9RNl0TTikF2jzECix
 a1JaA88odXlJOG/WCeqZXv6AXYa6kwUXwQkBUnz22/J5H6+p9tqWcrhfA9WdtVDg+BCeV9niA
 /bRV8bytHFiTFBvTfULpmLU8HPC+bInE8AXFA5FI4r9FYSLQxHO+HKGSeTdSbL+h4lL78WAfc
 rIIjTih9nMGSlskR2OXtFxGnuIC6pOnrvPWespFIh47fwCDCzXv7v9Mo2aT6IA5NWAgtbL3Zg
 fWofTQ/7m+MeZu9VGM1GPm2mrWkMZnuGhTOdIcweduPdrWKQ6aR/zKIdha8QxSumnsIcXC9Ro
 lKvoiXS2En6XgEWktqn+GL5Q5O9Kfj1eZKVeHoKG3V769mQmQFGUXtJchtPR9FZL1FCyjwDS9
 L8/za+xtLeL4VD37A+P28rCywVzjlh5f7uhpm9p5HX05l1OMqNr+Hck7WhI+ww7k+NBvhXglG
 lbaKo5Cuq4xGEPQlwWhoMX2SpxUnXuT/h4kczqgy9ikO/HlEg

> Also the "phy" point will never be NULL so the check should be removed.
How many tools can help to determine such a software aspect with inter-procedural analyses?

Regards,
Markus

