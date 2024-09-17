Return-Path: <linux-wireless+bounces-12916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A423297AFFB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 14:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531102872B8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F2714831C;
	Tue, 17 Sep 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="VhpXqlr4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A915C14D
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575016; cv=none; b=LLoRMo1072shsVcN7QrPH3vK1sll/iBOaAL3sX68ipf/gTFxRSdaEHSriciSfMNkWF1ooYGR6Xj2Zf3iSKkifkISVdFpDUu7SgvcQkJdcOHEbW2aUTg2hw/E1qE5mBkYiK6jox4eHZIfdoqu4Smu6pP6o9nv9PlqZgwUOGaiGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575016; c=relaxed/simple;
	bh=nvqU5uJo+lBrktFnwu3C+mFLFRo7dsLiVB5DcZHIcY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRk5j/SSpUFXcdCl2xKkG9llycc874RZkX73SG3b8O5Hvcxz09BWdlFAQfUnj0aEq3F3ELFtsBXyrI/ybDnsqyYNZ2cY2/yW/sTyS3zu7/ebTCn1FRc/rkfqOmLCw+RSmPNf878p1nCBKxkInoQurzFbcTfLlHBC870nxCZeRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=VhpXqlr4; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BVNUFS2sXyZb3D9ESWUOwgjMai8DOWVA5uCbKXlhQxM=; b=VhpXqlr4s7JLXnpxv1G6Nq6AW+
	2sSMl5gme5lKpWHa3cuWJ8HhSohntbulx4jC6MwAEIZzvoga23/JIxbQ06N6MSJ2ZMEtrUeoSawmJ
	d+iyOFKUf3y7UAtAAvnjCnVRA2mLAC6gqGsl4z8uMx5qaeIOB6OoykhuE/Z1Ox3Dq2Ss=;
Received: from p4ff1376f.dip0.t-ipconnect.de ([79.241.55.111] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sqX23-00EM03-0J;
	Tue, 17 Sep 2024 14:10:11 +0200
Message-ID: <05dd29d6-9dcb-444b-a271-1513429f682b@nbd.name>
Date: Tue, 17 Sep 2024 14:10:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: do not increase mcu skb refcount if retry is
 not supported
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
References: <20240917110942.22077-1-nbd@nbd.name> <87v7yua5qk.fsf@kernel.org>
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
In-Reply-To: <87v7yua5qk.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.09.24 13:18, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> If mcu_skb_prepare_msg is not implemented, incrementing skb refcount does not
>> work for mcu message retry. In some cases (e.g. on SDIO), shared skbs can trigger
>> a BUG_ON, crashing the system.
>> Fix this by only incrementing refcount if retry is actually supported.
>>
>> Fixes: 3688c18b65ae ("wifi: mt76: mt7915: retry mcu messages")
>> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
>> Tested-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> I'll queue this to wireless tree and add:
> 
> Closes: https://lore.kernel.org/r/d907b13a-f8be-4cb8-a0bb-560a21278041@notapiano/
> 
> Ok?

Sure, thanks!

- Felix


