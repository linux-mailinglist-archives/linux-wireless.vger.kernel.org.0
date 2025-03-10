Return-Path: <linux-wireless+bounces-20106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BE9A5920F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 11:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385B116DCE1
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A731226868;
	Mon, 10 Mar 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="QmqaspNY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24128EA;
	Mon, 10 Mar 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604208; cv=none; b=Br2qCREMpNqGVFqA7MCbfsoybIPv1EBwaLrK3XAg4AacDVknGDUmJSIIzA5wQ4u+pWTqWhyUxcHJZi07m9EiQN3karZd7I9Fu2K6X2avIIvelV4ubk/Rp0iC/v8yI738rpifFEOXcJy1KC+nPfKlgmWeZzOuYch+pglPs6/sCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604208; c=relaxed/simple;
	bh=ivYS0yJpeyvxoK8uCMOjDbDUT55IQfzz/a22vunLrXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iE9bVKFUXBbfxmMLCTrZVN7mQezApKNpmM4MRmsMECYisfJvY3L3OalgxzjCBOAd2ekCCHHyLCBE3+7b4k21m+s4hcy2TQT5pnTEoTsBRyto4GWT7r0xuCpyH/xQeVOBn9/2dIYzDDsKq0aeocoo5klD8Xb7FawM/vXtrrFJeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=QmqaspNY; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AKmw+VYlbnRg7vgRGNsJLfqevduWjYdjPL3zS35h19I=; b=QmqaspNYGCuZ0DeizoOna+/oF1
	icgAPSB/W8HD049qUeSYCHsBYhd4Ln1rGHBHsvy44olFRaBRqZeFHAq0dFrvIFGf+GhnA4JJEjgEw
	ANUuM63iKJtGRo+L08CSbHnxlOTX7w1cJ6ZNcRI0xrk8awhP6O66iac4guGeS2uiGaVg=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1traZH-00FdO6-1p;
	Mon, 10 Mar 2025 11:41:07 +0100
Message-ID: <71ed8398-4619-4793-804d-77cad36e7402@nbd.name>
Date: Mon, 10 Mar 2025 11:41:06 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 RESEND] wifi: mt76: mt7915: add wds support when wed is
 enabled
To: Shengyu Qu <wiagn233@outlook.com>, Ping-Ke Shih <pkshih@realtek.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
 "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
 "howard-yh.hsu@mediatek.com" <howard-yh.hsu@mediatek.com>,
 "greearb@candelatech.com" <greearb@candelatech.com>,
 "chui-hao.chiu@mediatek.com" <chui-hao.chiu@mediatek.com>,
 "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
 "quic_adisi@quicinc.com" <quic_adisi@quicinc.com>,
 "sujuan.chen@mediatek.com" <sujuan.chen@mediatek.com>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "bo.jiao@mediatek.com" <bo.jiao@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
References: <TYCPR01MB84376C7074C566865654F05098D42@TYCPR01MB8437.jpnprd01.prod.outlook.com>
 <b6b52bfcdb614137ac63fddfdaf9cb97@realtek.com>
 <OSZPR01MB843481965BA47B030566DF2698D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <OSZPR01MB843481965BA47B030566DF2698D62@OSZPR01MB8434.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.03.25 11:33, Shengyu Qu wrote:
>> if (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) ... ?
> I did a search in code about this, seems current MT76 code is using a
> mix of IS_ENABLED and ifdef. And this file already have a ifdef
> implementation. I prefer keep it as is and use another patch to convert
> the whole mt76 driver.

The driver uses #ifdef where it relies on struct members that are also 
#ifdef'd out, and using IS_ENABLED would lead do build failures.

- Felix

