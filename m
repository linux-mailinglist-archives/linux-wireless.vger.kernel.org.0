Return-Path: <linux-wireless+bounces-10116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC492B4EF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939181F21783
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFA5156236;
	Tue,  9 Jul 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="aQ8xHylU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751E155C94
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520042; cv=none; b=qhW3VVl1dOkyn1oFKtSbnvuxPuq6JB5IU5bWVbIFegA1Lxnwy+6duzOLiGy8OJXJDEsfmF51q+GmKlgTln8UIVz37RXR2OBIazMBdmBmGMJwq8xLhFPYFDZd76SG1bo65CjKLBZsyK3AmunEaUgwCQgzCeeEF78MZegwmBuKjuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520042; c=relaxed/simple;
	bh=bjBluXifPvWRvFSp/FG7ru9ScKbrn+ZytNb9IDlBLt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSL+RZBGt4wNJv4gJczfeKSZgLxdSPtmcHDf7oEaaipdfnJBzwh80TF9Jp3MkI+i/X8rfBQDfKqX4N1caSSVM93S445/ao0S5KjZKPU11w5nDEKS1VKK1brPmT+OaaOlPr2dAIKpN2JKprbyEooESSgycRkiatoXm5UihQoXZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=aQ8xHylU; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VA1WSGsaLUdqTzLpswDk7Qi2nuAy2mxeSf9nD6je938=; b=aQ8xHylUP3K8AxnQTKB2TxUloi
	rTBiUew+CBFdP3TLawnA5xL450n63ixwUEOKmTeuQFZsKiP5sy4bj4PGchb80hDDtpvxj0GMRwisB
	aOQjbQLAuYCaxws/GXYsQf4Dyf4+hzTwOfLt5w4lQHZeOp0jx/ikoEkg3dUMqwiOTQvo=;
Received: from p54ae937c.dip0.t-ipconnect.de ([84.174.147.124] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sR7rC-004NRl-2Q;
	Tue, 09 Jul 2024 12:13:58 +0200
Message-ID: <18e1705c-6d8a-44ab-927d-498dc6bba3be@nbd.name>
Date: Tue, 9 Jul 2024 12:13:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: mt76 2024-07-08
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 Kalle Valo <kvalo@kernel.org>
References: <f5e72ce2-11db-4f19-8aaf-8fd9b62e5a77@nbd.name>
 <87bk37dhpo.fsf@kernel.org>
 <CAGp9Lzp+1xoceuT3Fi=qXpgFyaQyoW_z=TSHrQepByfb6BR-Ow@mail.gmail.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
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
In-Reply-To: <CAGp9Lzp+1xoceuT3Fi=qXpgFyaQyoW_z=TSHrQepByfb6BR-Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.07.24 21:27, Sean Wang wrote:
> Hi nbd,
> 
> I have fixed the build warnings for the patchset. The entire patchset,
> including the fixes, has been pushed
> to this repository https://github.com/objelf/wireless/commits/mt76/
> 
> The specific changes to fix the warnings are included in the following patches:
> 
> "wifi: mt76: mt7925: extend mt7925_mcu_uni_roc_event"
> "wifi: mt76: mt7925: update mt7925_mcu_sta_mld_tlv for MLO"
> "wifi: mt76: mt7925: add link handling in mt7925_txwi_free"
> 
> You can cherry-pick the respective patches or pull the tree as needed.

Thanks. Sent the update as v2.

- Felix

