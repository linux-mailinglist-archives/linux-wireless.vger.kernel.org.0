Return-Path: <linux-wireless+bounces-27140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A1AB4A130
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 07:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C877E3AFA5B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120F45945;
	Tue,  9 Sep 2025 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="aOBMaUep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF119A288
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757394925; cv=none; b=LEES/QNdVOLAgYmpl/ZhaJ9yU2WoSdTsYEtnsrlbLblZ1hLbC4831FgpIzUTKyf4Ceyl6iQgEYIg2AXrhqKYIGh3+0B7t3XXaaKIzAPXdog7wtJtfdFLPcxEPoTfrWB+I4Ytsfl0VzM2y+jQ0rQ2qWDX3Odlibx8oIUBneLXL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757394925; c=relaxed/simple;
	bh=DEQdKJILjGiYhOcEPBdnJo35taG9ZVjvIQrw4k++e6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn8/Pu8N4h8RnU3xSEBcEbx2TTVKW/VCw3KEOuAU8sqqzQfcplfgOUrALEk2uTJJgrZS7GgLY5PvmyQluS9Cmbfhzk3kpQrvr8AtDW198631EIJOvGK/sPexE2oJBRogziytFlhjdKRlxHowG/7/hsH6d3et4PYkdQeFlgp0phA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=aOBMaUep; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YI1lEa2m79R1su/rEIpWAFyrO+Jezkd3/oRpZDuRj5I=; b=aOBMaUepJhS809k1fkV1TvIkz3
	hv/b5KNKIldk1O0E7tHLgLCCjz1A4ECEJbU70y+UGav+EQBVgtpeikPfGS7Z+ysEi6oNUU+U6m+zQ
	koUHhtZ3ejC07JXMozHVNAJT8GSIHbwAmsWO36YayCqFE+Kzu9wfWUl2BFB/mZC92YFc=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uvqhJ-004E0x-1l;
	Tue, 09 Sep 2025 07:15:17 +0200
Message-ID: <c64c1a73-17b4-43e1-9188-03a2ce3ec8b1@nbd.name>
Date: Tue, 9 Sep 2025 07:15:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: mt76: mt792x: protect state->cc_* counters with
 cc_lock
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, lorenzo@kernel.org
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Leon.Yen@mediatek.com,
 Michael.Lo@mediatek.com, allan.wang@mediatek.com,
 Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, Quan.Zhou@mediatek.com,
 Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20250904030649.655436-1-mingyen.hsieh@mediatek.com>
 <20250904030649.655436-2-mingyen.hsieh@mediatek.com>
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
In-Reply-To: <20250904030649.655436-2-mingyen.hsieh@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.09.25 05:06, Mingyen Hsieh wrote:
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> 
> The updates to state->cc_* (cc_busy, cc_tx, etc.) lack synchronization,
> risking race conditions and inconsistent statistics.
> 
> Add cc_lock protection to ensure atomic updates.
> 
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

I don't see any race conditions here. Those counters are only updated 
and accessed with dev->mutex held.

- Felix

