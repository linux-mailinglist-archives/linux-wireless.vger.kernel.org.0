Return-Path: <linux-wireless+bounces-24476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859D4AE7F38
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678D27A80C5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E962882CA;
	Wed, 25 Jun 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="uoFUjwJ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A52857F1;
	Wed, 25 Jun 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847140; cv=none; b=a58qvlBoKJPh2TlQB7/7G0hIk/UUwTQH5AS7qIYkHtNjMp8XHfxzMOhLQ0xgP2QJjBUXrvLB9W8BGRipVAgd2MhB6a/gdy/ePwoR+7BbVEROhDCV5uTGmxWcXUbKVCpI2KUW6EKrLwxa4/ka2t8AgTSqSGf0cIVPqQh+4VWdCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847140; c=relaxed/simple;
	bh=OT05aiHEgxlpJtauo1lOQHDjKjcVf+YutBo6Aak4sUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRNoTH60xk8kO3UpDjtLya/X2hz0M9S+ebm3cpJqv9JF2lLO5JPaNSB99+BbsEMn52FRdNuarQ2qBjyP3tlFnafxJoaVWI8iH1GHRAF2fmtrtTOzHK7NxHCdBEvpqTmli51sh3IRz2TcuawN8E/pFr9HPaO2uXne8Xr6Nv1yPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=uoFUjwJ8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vJ3mwn0o0bNWIsKKV9EgOQNug5ExZy+GsquJ5hq125c=; b=uoFUjwJ8Jh3yc0ecE27bc1VUee
	1EonnoamVyY+y7eJXmxmzochQ/PjP8cTbux05fhoXcdUGc3FgWxQTynwWLJTMVZR4ZbilwvmXcwrS
	N/tibEuTq4/LbUL9TYdQ01QGR1IHfEPmi2wKF6sSsnUuHP8GX3Zmf1CVOI4eEtdYP8UI=;
Received: from p54ae9243.dip0.t-ipconnect.de ([84.174.146.67] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uUNCi-003Twy-0A;
	Wed, 25 Jun 2025 12:18:08 +0200
Message-ID: <26e6c7f7-a35f-4ebb-a55b-ade2ac7c20bb@nbd.name>
Date: Wed, 25 Jun 2025 12:18:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 RESEND] wifi: mt76: mt7915: add wds support when wed
 is enabled
To: Shengyu Qu <wiagn233@outlook.com>, pkshih@realtek.com,
 lorenzo@kernel.org, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
 sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, johannes.berg@intel.com,
 miriam.rachel.korenblit@intel.com, christophe.jaillet@wanadoo.fr,
 greearb@candelatech.com, howard-yh.hsu@mediatek.com,
 StanleyYP.Wang@mediatek.com, deren.wu@mediatek.com,
 chui-hao.chiu@mediatek.com, quic_adisi@quicinc.com, gustavoars@kernel.org,
 razvan.grigore@vampirebyte.ro, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Sujuan Chen <sujuan.chen@mediatek.com>, Bo Jiao <bo.jiao@mediatek.com>
References: <OSZPR01MB84342A0E21AAD111ED7AF6B198B82@OSZPR01MB8434.jpnprd01.prod.outlook.com>
 <TY4PR01MB1443294C4D36DF73852B4E79B9878A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY4PR01MB1443294C4D36DF73852B4E79B9878A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.06.25 16:11, Shengyu Qu wrote:
> Hi Felix,
> 
> Please, tell me if this patch needs any polishing. I really don't know
> why this patch still not get merged after such a long time(and 2x
> resend), especially it already got a Reviewed-by and is a bugfix.

Hi Shengyu,

sorry it took such a long time for me to take a look at this patch.
I don't see how it can even work properly in its current form, because 
of at least one bug:

When switching from non-wds to wds mode, the code calls 
mt7915_mac_sta_add in order to create the new sta. However, after 
changes that I made a while back, this function does not actually upload 
the station to the MCU anymore, since it is called on the NOTEXIST->NONE 
transition before assoc. Without corresponding ASSOC/AUTHORIZE events 
(handled by mt7915_mac_sta_event), the firmware doesn't get any data for 
the new wcid.

That said, I finally got around to starting to rework your patch myself. 
I will let you know when I have something ready for testing, hopefully 
later today.

- Felix

