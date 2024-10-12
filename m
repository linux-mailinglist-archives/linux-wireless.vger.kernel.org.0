Return-Path: <linux-wireless+bounces-13927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2005F99B57F
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2024 16:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E75B225AE
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01302189905;
	Sat, 12 Oct 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="lhiS0+ic"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F51E892
	for <linux-wireless@vger.kernel.org>; Sat, 12 Oct 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728743250; cv=none; b=N4l512x303HjAiHLQkH/plFLOisCZZzuOFL/LzR2DPCyER0jpy/pJ53JLb5BI/hgQES31fa4W8dsRRkNHqMjZ2ykQpqOssnoAVjN4rkO8KG70M9L6aID34k27AJnCbe1wDANiUnfkPyxJCgTjpgbK30O/LHwb7DVAo+6rESikq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728743250; c=relaxed/simple;
	bh=I16L4XbJe3g3fUx8aW5+IazWchbdydz3HBCknQ/Ozjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXYkL0cy8bFy/l9LsO9zO8GegIo0qBpIEYqfv7rfulmvpxubodH1ScWmENCIp6iCURvlpY5fO2am7+Qz23TayNn4rDLTDNYjC++EujteZ4BlpMKjO0g1/mw1tzoIBZdPk8d0na2MdDQ7FbmMD6YJPftWjiWK2y/FjqW8cUIuEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=lhiS0+ic; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=70lw4zCxUoObVf+Tk492v3g4csCqQzYlgmQ/kWdfhkY=; b=lhiS0+iccznDwNKHRMUulSB6pb
	9W5FimSWVUdo97QXXYo7rAz61hDgBiKDixO4ndBVIx9+61JmgSg7h7gURtbgVoMiun0h1P1RL7mCF
	QWYE+SEBScja/ycB1G0GWknwj7Zc/bSoFMGtFuoXCcofTWgwebNi3PE08h9nu7JFuPr4=;
Received: from [2a01:599:10d:b131:5deb:efe3:952a:fc7e] (helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1szd5S-007l2X-21;
	Sat, 12 Oct 2024 16:27:18 +0200
Message-ID: <d7088c46-e956-4f09-9595-7bb99321d7f1@nbd.name>
Date: Sat, 12 Oct 2024 16:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: mt76: mt7915: add module param to select 5
 GHz or 6 GHz on MT7916
To: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, Steven Liu <steven.liu@mediatek.com>,
 Evelyn Tsai <Evelyn.Tsai@mediatek.com>, Paul <paul@asiarf.com>,
 Shayne Chen <Shayne.Chen@mediatek.com>
References: <20241010083816.51880-1-nbd@nbd.name>
 <b8c12251-7099-4aa1-9b8e-e709cc6eafac@candelatech.com>
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
In-Reply-To: <b8c12251-7099-4aa1-9b8e-e709cc6eafac@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.10.24 16:34, Ben Greear wrote:
> On 10/10/24 01:38, Felix Fietkau wrote:
>> From: Shayne Chen <shayne.chen@mediatek.com>
>> 
>> Due to a limitation in available memory, the MT7916 firmware can only
>> handle either 5 GHz or 6 GHz at a time. It does not support runtime
>> switching without a full restart.
> 
> Can this also be implemented so that we can change the module parameter,
> force the radio to do a hard reset, and change bands that way, without
> having to do a reboot?

It probably can be, but that requires more work and testing. I'd prefer 
to do that separately at some point in a follow-up patch.

- Felix


