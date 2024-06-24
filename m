Return-Path: <linux-wireless+bounces-9510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EEA9156E3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 21:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437E51C23079
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31115143C42;
	Mon, 24 Jun 2024 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mmrdHLaD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83913D88B
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255804; cv=none; b=bA8VicrnVUa+wFFrJGU2Y1d4msUdepRsHqU2VBdakSGOADETEWu12kmFotRe79/vwBvJIEwplSpEJ/WH0Y+BOl9k1hDQpW+WxTMUpWCJB6U72V7A7BXMFgTa8lIjPULQc2gGrWdVM/QtplPMlR8dDAs41cRy88X5xFg4zRqq3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255804; c=relaxed/simple;
	bh=BmyF6X6TMrMjOT+TEtzSGymb+9ZyaEDx3NVysZMGJ3Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MICU0e9ouqSpj+Vr8aIcGEbpYgkEvuI6RumZUiV2DAvBwXwhBTmcYM5DAG3QdGoR1Tiwbu6UnUex6HHpVyQgphA1r2eP1+6r3sCpxNl8tVeKbe/pVK9cjNF2uXUhvWoB+LBvMV7kSaNZGO/sRdFKS0gPJItH3LjUiC4YMAqquYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mmrdHLaD; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Q74uyUcwtRDpcu2Zgpqe2KqUuJaFev3sdVMOm6XlEk8=; b=mmrdHLaDBaewrUYO22AwvAhp5r
	iifeg5y9wQjUtqT1ho55eyuPUTwNnZfs9PBTJrbuVaCqDtPHQr57fH03AqTwD1xCO58GSyG7h3xNL
	KRolRxX6MNSDBPbrKMz7YkG+llCBWUWKAQCZaGdUFBP7qzbR+NQfh5VdAcTpSp7ykMCY=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sLoyB-00GidT-02;
	Mon, 24 Jun 2024 21:03:15 +0200
Message-ID: <4c02983e-2377-4c26-bcd6-3100eea19aeb@nbd.name>
Date: Mon, 24 Jun 2024 21:03:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/47] wifi: mt76: mt762x: extend
 mt76_connac_mcu_sta_basic_tlv for per-link STA
From: Felix Fietkau <nbd@nbd.name>
To: sean.wang@kernel.org, lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com, deren.wu@mediatek.com,
 mingyen.hsieh@mediatek.com, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240613030241.5771-1-sean.wang@kernel.org>
 <20240613030241.5771-38-sean.wang@kernel.org>
 <94abc74b-dcd5-47b2-9364-cfd5d3f28846@nbd.name>
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
In-Reply-To: <94abc74b-dcd5-47b2-9364-cfd5d3f28846@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.06.24 19:44, Felix Fietkau wrote:
> On 13.06.24 05:02, sean.wang@kernel.org wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>> 
>> Extend mt76_connac_mcu_sta_basic_tlv with the per-link STA configuration.
>> 
>> The patch we created is a prerequisite to enable the MLO function in the
>> driver. It is purely a refactoring patch so the functionality should
>> remain unchanged.
>> 
>> Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
>> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> 
> This patch is broken on non-mt762x drivers, because the functions that
> call mt76_connac_mcu_sta_basic_tlv may be called with sta == NULL.
> 
> I've seen it crash on mt7996 because of that, but mt7915 and mt7615 are
> likely equally affected.

I've pushed a fixed version to my tree. Please check if it looks correct 
to you.

Thanks,

- Felix


