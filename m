Return-Path: <linux-wireless+bounces-27138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5DB4A11A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 07:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22351640AC
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4336D221F26;
	Tue,  9 Sep 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="hdhFDgmK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21542AA9
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 05:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394358; cv=none; b=OfVZ41z5Wz4xwFYXft6VUh3FhJWLCXFNr6d4ZqzqFEQd8HRNZ2ShWqXz7OSVe8gw/qJJqYB6s6a+JlyorRDhb5wYFre9wS7Y32U4TbnoEiG/g0/h1u3NFWEFKkonv6OUaEhIX7mEd+8/YbWyrMGble8WMiWUTGjah+WswVvuGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394358; c=relaxed/simple;
	bh=oMJpy4xSmVJ7NXIqBVD8nSKacog/qQB3ae2HwSG+pjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXXsF5ZTiDlyEsv9304tp4Ciq0kVIMBqlUhBbPaMgDkTMImIGCbAE2AwN8GbHCw0DKAvgk8sLlY+ZDX2Zb5C+2eV4k7CROnVkq318cc/MnKR7ZAQVDehK01PS5JxoRuddR/CpSUELgL0O6lqj5fc1IrGpuDbmI/8Q2Ojt0TlWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=hdhFDgmK; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ghFyZUGdZ7mO0wqQ4/RAL3CXKOgBO+Pq9aSKHM71k80=; b=hdhFDgmKyMhYNyU7ekjmjMl7c8
	wmH6MibDUk8mCcbYvnIZCp4rG+clm186+LS8QwEd3pg5R4L6y99rb+oqLAXgbT6kB505Cb3dk/fzV
	VXIHfODhkQfqIBCkJvHZkuWQeyhp8vUXrGN9LcWkcCHh5peKQGvfyDDBon2l/3UagMJ4=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uvqXu-004Dp8-0Z;
	Tue, 09 Sep 2025 07:05:34 +0200
Message-ID: <71c03b80-6ea8-4393-9210-c50a6ac73323@nbd.name>
Date: Tue, 9 Sep 2025 07:05:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: mt76: connac: synchronize token_count access in
 mt76_connac_skip_fw_pmctrl
To: =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
 <Mingyen.Hsieh@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>
Cc: =?UTF-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
 =?UTF-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
 <Eric-SY.Chang@mediatek.com>, =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
 <Deren.Wu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
 =?UTF-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
 =?UTF-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
 =?UTF-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
 Sean Wang <Sean.Wang@mediatek.com>, =?UTF-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?=
 <Leon.Yen@mediatek.com>, =?UTF-8?B?S00gTGluICjmnpfmmIbmsJEp?=
 <km.lin@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20250904030649.655436-1-mingyen.hsieh@mediatek.com>
 <20250904030649.655436-5-mingyen.hsieh@mediatek.com>
 <bafba000-2488-4382-ae0c-df6195b83019@nbd.name>
 <61ad7900d5909359d8c1907b6c80db921c0da612.camel@mediatek.com>
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
In-Reply-To: <61ad7900d5909359d8c1907b6c80db921c0da612.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.09.25 04:14, Mingyen Hsieh (謝明諺) wrote:
> I haven't seen a real race so far, but during my observation, I noticed
> that some functions using token_count are protected by a lock. That's
> why i added the protection in this patch. These are just my thoughts,
> and maybe i might have missed something-perhaps the protection isn't
> needed here.

In that case, I don't think that this patch adds any extra race 
protection. Other places that take dev->token_lock typically either 
write a token related variable or interact with the idr as well and need 
locking because of that.

Thanks,

- Felix

