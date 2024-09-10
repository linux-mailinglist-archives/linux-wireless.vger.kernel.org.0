Return-Path: <linux-wireless+bounces-12749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4439732CA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2F9B22750
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DB019415D;
	Tue, 10 Sep 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="r84AtY2E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6A1922F1;
	Tue, 10 Sep 2024 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963520; cv=none; b=p5JGP7+irwLf98fRKaiQRUZG+SIh6uYfvGjxUvkPFfoHoooqjRmfION0KwfAVAKraJx2t8ikZAIm4lVVESaw5jKra6kwC3LvtNfg9DXKXrc9Dq/ze357vGvQvSxL91Z55iA6RlNoShv8FwHf4kk0db8sM82Txi74T4sIrlHOxF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963520; c=relaxed/simple;
	bh=BytnPY46mnPRDlB8ROZftu1Csx92PsKunJhrjNZ8cYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoPd3YkyENJ5N5VRCIIde2atoArRvk8S7XFpZ79Q53phqKu08AgVMC/h7S+ieU4brxD/2mUXhjDCAU6w6IRka0GWLndIKjgUKyZ80L0nm7h3UfmkJYNh1Fb/L68Pso407Ve7+8FgEBHbnPH7/YAAHl3ccuAxVLzAL6m9kMV2s0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=r84AtY2E; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0468E88F5F;
	Tue, 10 Sep 2024 12:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725963512;
	bh=ziKQobiBowH8lBD7d0jJWzB9mGazXQuMiiUtscv86V4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r84AtY2EzH6Et5nkj+QJ8IikvqlGOCB7SLOFRg+dfCrFZQYyrMCRrtgU5uEcVTIxz
	 dkdePWg97mUE9VunxI65jprc6i9CLaNyxa/AlqLC0o9LA99pw9EELOEFvUvbuQJyzM
	 CAuvuCigb68XubUhGtYz4A2WQIHgVc2WtXskdSq9HfeFiINoQYjrkibbUVpserFoxc
	 lFTns48qX1JloYXOWjiW2EcbYBd8hMGh5nJaN33Jx9G9yRHn27oc2f39ajE8ynzr60
	 9/zBk/oPuEDbKbkS5mWOaKrKzK/jlDSjMvtxrtSldrl6JRUegQ6WwIdym3YZEQ3nj8
	 bEaQPq+WDeLYw==
Message-ID: <3f576f28-2ef4-4f00-9c01-38837ee6b3d6@denx.de>
Date: Tue, 10 Sep 2024 11:45:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] wifi: wilc1000: Fill in missing error handling
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240909193035.69823-1-marex@denx.de>
 <20240909193035.69823-4-marex@denx.de>
 <5ae8121f-8ead-4d7e-9fbd-417c273474e5@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <5ae8121f-8ead-4d7e-9fbd-417c273474e5@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/10/24 11:13 AM, Alexis Lothoré wrote:
> On 9/9/24 21:29, Marek Vasut wrote:
>> Add error handling to chip_wakeup() and propagate the errors throughout
>> the entire driver. Add error handling to acquire_bus()/release_bus() and
>> host_sleep_notify()/host_wakeup_notify() functions as a result as well.
>> Fill the error handling to all call sites.
> 
> Out of curiosity, what tree/branch are you using as a base for this series ? I
> wanted to pull it locally to also test it on wilc1000, but it fails to apply
> this patch, and the failure points to a conflict with one of my patch which has
> been merged quite some time ago in wireless-next:
> https://lore.kernel.org/all/20240613-wilc_suspend-v1-4-c2f766d0988c@bootlin.com/
next-20240909 with this extra patch:

wifi: wilc1000: Keep slot powered on during suspend/resume

