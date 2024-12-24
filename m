Return-Path: <linux-wireless+bounces-16750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697919FBADE
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 10:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445B31624E3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E766191F6D;
	Tue, 24 Dec 2024 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Vwqmvhr2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA5EC0;
	Tue, 24 Dec 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735030944; cv=none; b=qA2QlvKr44nYal7032GMmNdvdUtC/xyP7qIfcl7m9ubfqrE2WBQ+/X7B1WCqgxlvCx2USEnETUEK4sQ1Ns0Hy1HKNvK7HHXwZE6quLmPX9QemuKCMH21QTZFGY3QgJ8SyTLlvjRaFGtBALpMD36S2Eqcp3cDA/P9Lh9hTbtl4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735030944; c=relaxed/simple;
	bh=dR3J2AO7c6sZEVZYUFLwld1S6Z3ZBTYtkfqqtrwEmb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnMG2cKD0YDZQKxoOFe5cABu72UUebcsMuuab18v+7b2rcsMA/Uu9nzVJLu1apwKjxJ+hfxdoZCRWP0KMn7qIZOJIYgU7r2Qa4bM1S2ycpaTOw3M17unbL/tmHO64x+W4t6zt0G/Vf/JOTlFAlpm4aZJPW2CEbekrplbP0d51Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Vwqmvhr2; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1735030934;
	bh=pnRVptCir55iRN6tACq8biJmBmLFjYWt0eJCtl4slZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Vwqmvhr2xJPpcZU+S+2LqoGEXFXXs34MMbBfN+BaJCSZtV/9S4wuJu7cvE4MfQnby
	 e3MHrGw/7j3aAPuUOkJpIkCdTYPTTicwc4ZZ509oxpyI6HL1Migu1aq2FLGxS4zxW0
	 y0zLab5wFQFP6KEUUSJoAsmHWpLVVJPhWTe7yL/A=
X-QQ-mid: bizesmtpip4t1735030894tk5g8f5
X-QQ-Originating-IP: 96GmDbkbkKRgISxbB+698YkwYAo3Wyh+yJTBMgPP/c4=
Received: from [IPV6:240e:668:120a::253:10f] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Dec 2024 17:01:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9337975073141793265
Message-ID: <EA91BB1E8AC92ED0+6715c92f-3b3b-4a86-82bf-4704c3b9f36a@uniontech.com>
Date: Tue, 24 Dec 2024 17:01:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error
 messages when -EPROTO
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexander.deucher@amd.com,
 gregkh@linuxfoundation.org, rodrigo.vivi@intel.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 raoxu@uniontech.com, guanwentao@uniontech.com, zhanjun@uniontech.com,
 cug_yangyuancong@hotmail.com, lorenzo.bianconi@redhat.com,
 kvalo@codeaurora.org, sidhayn@gmail.com, lorenzo.bianconi83@gmail.com,
 sgruszka@redhat.com, keescook@chromium.org, markus.theil@tu-ilmenau.de,
 gustavoars@kernel.org, stf_xl@wp.pl, romain.perier@gmail.com,
 apais@linux.microsoft.com, mrkiko.rs@gmail.com, oliver@neukum.org,
 woojung.huh@microchip.com, helmut.schaa@googlemail.com,
 mailhol.vincent@wanadoo.fr, dokyungs@yonsei.ac.kr, deren.wu@mediatek.com,
 daniel@makrotopia.org, sujuan.chen@mediatek.com,
 mikhail.v.gavrilov@gmail.com, stern@rowland.harvard.edu,
 linux-usb@vger.kernel.org, leitao@debian.org, dsahern@kernel.org,
 weiwan@google.com, netdev@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
 leit@fb.com, wang.zhao@mediatek.com, chui-hao.chiu@mediatek.com,
 lynxis@fe80.eu, mingyen.hsieh@mediatek.com, yn.chen@mediatek.com,
 quan.zhou@mediatek.com, dzm91@hust.edu.cn, gch981213@gmail.com,
 git@qrsnap.io, jiefeng_li@hust.edu.cn, nelson.yu@mediatek.com,
 rong.yan@mediatek.com, Bo.Jiao@mediatek.com, StanleyYP.Wang@mediatek.com
References: <1E6ABDEA91ADAB1A+20241218090833.140045-1-wangyuli@uniontech.com>
 <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>
 <5DB5DA2260D540B9+359f8cbf-e560-495d-8afe-392573f1171b@uniontech.com>
 <531681bd-30f5-4a70-a156-bf8754b8e072@intel.com>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <531681bd-30f5-4a70-a156-bf8754b8e072@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Occa2ms7+ZuO0HEd1vEbG4OctzQaQAfe3yX6dEKSmJTPJowQRzS7t3ti
	7eaoxLRI5OFll0inSCKEwb4aH8FTxUr5tjk9S6QEyqOJLJiqydLZn0enWM17zFo9r/gvQ1t
	7+mCNk3H3GKDBmYnlR02VjxiR5hCBIyZe+eCEr/fOKOw4rv84zYEkKqdu6MDXNi/7xgZtH5
	IiwcdQkdbiDrgzUIistUq3RW6BI8/n0hNZI9cJrPe/MMSsuw5EUyviEMfGNjPJFOcAK3BkY
	BvshkB6WGv3L5+SAfR9wiWYDMXwAJxSzs6jwWIp+BGaTLkQYJUyPcO8TOOFr+zBLEHdQoNT
	XBmrGZgUqiXBeyE7XJVFdBbS9vnNzNIQtYu/jK/VuowfxMsX5HrctHJiJ/v998jEv2stn/l
	fXtmkUFCqP9ijxrSykj74/LyBuCftGzid6XvUCisk7ovg9fiHmxJnQ12phkRCmgRocI+/Ao
	4/ofH/MHGLbA73ajPSJy/vGKM7zLbcYMNoFX4ADgDIr/E/zcqn9gquY314tbEqFD9hGuakU
	6G5r3/3aDouGCiFhYnKb6EbwQUVYtqKUv4IHP8DR5xrdhyH99NJrq2d0hiPz7vzHYYXVrb4
	g9TgUCOSb2e5ZA/pSov17JrsPkXHEY7Q/Pplk/lT+igq/n5YbFCGLgNLOIEnpE7iaU68gPg
	JE5D1FWSSDPBLiA838ugWDqUbxEyV990BYIUT1vvh81tLayniw0ArgaYszcLNEXK63RTNK0
	Gd9lv4dZAvJapxynwWu+fakm8QAAJ+NzM7J7Q2QwynxwxQ0c1jFZWlvOCWFNgeFQWV22nP/
	Jsk8SSVWu3nkEiPCH0LSWa3N7r5sfYjPXX/UfQD1VAWrRkehSjg+tTEK6o8Dy9ZPSY2burG
	2H63BK1mp7tb0rhNWRu04g55TC6gKD9RCDUHWgz4m4IbdySipLVm7np4mKCB+dA5bJk3U1o
	LWz1hCOqK/zSynwqoTKOf4RBM0+C2QJwHva4cfdjUde//vyvdTsCYyx4cJYtNLnhoFFnqe3
	ZBaDA2PMoYiUm2NPdv
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0


On 2024/12/19 23:23, Alexander Lobakin wrote:
> So you need to add the correct tree and/or subject prefix and specify
> "Fixes:" tag with the commit this change fixes.
>
>> ...
> I'm not a wireless expert, from my PoV sounds good. Just describe
> everything in details in the commit message, so that it will be clear
> for everyone.

Hi, I have attached the new patch as requested for your review.

Link: 
https://lore.kernel.org/all/BA065B146422EE5B+20241224085244.629015-1-wangyuli@uniontech.com/ 


Please let me know if you have any questions.


Thanks,

-- 

WangYuli

