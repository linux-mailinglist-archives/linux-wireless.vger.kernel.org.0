Return-Path: <linux-wireless+bounces-28273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435EDC0A095
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 00:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030F73B1ED3
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73C29D26E;
	Sat, 25 Oct 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="pxQMMed8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62619D092
	for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761430061; cv=none; b=GO9yFOrFMZ6naCd8JurCFXs1NFnKLAItDjCjWVfMT+uplieNgU+zIGR+OD3JbkydytHqVihdxDULdcX4mr7LVUN0NpIBllrkbxwnsuQXU7pr4lFyHZkFcWEYIlU3CoNI/vx7ffraJNfCg/lDznqST338f1TsogJ7wWeyeXA1lEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761430061; c=relaxed/simple;
	bh=Zdhr3QH96vIa8XRkOagQaFJO6zFfwsrc394cVKNh4+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X+038Nape3G4pv5FXDNB06a5Yc5vdW6pgz4dnCLie9x7aiMp8anxLtYOlUWt4fY1/GcEpqgDI9r3ou7spbIVTsBQRQ3jUIRuz7Bqs14DFjTCH5Cc1LwSdZ+7ZgESbVvRzIuRkJMMUXp4FZwovs1cSuWv9e9RxMcvezk1uoRwJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=pxQMMed8; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 39240 invoked from network); 26 Oct 2025 00:00:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1761429656; bh=eqCxPLGNk+p8qKPy3tzCrxq9AIQfMJbfl7ZnTBK0a5Q=;
          h=Subject:To:From;
          b=pxQMMed8x4AVKbBEnKdtT8wYSYfE4PNhM80Hnx9G/7c7doMtqKorFIbmOcM37/unk
           hYyWwceDi4V7xFKygQTQxbfgy+NwET2DRZapiL+cs4+pGUbleLNjw5RlTvx5gm8A4q
           vwCRZMiIl13vYPV4NAzUBTIRbsbO6LkBSjLu+PxQIfkYAnSJD6xGBeu4/5YF89zPss
           69IeUPOGO/fq2Y7QByPtxZnRfg2XZnL3L2Cak7iLD/SkquywsaeqrnWwzDH5jDhulg
           yh+K+uR5ukLIF1zZkrl83xZWUN4Kv3ylzo9389MvIPO5R8A5Yk/lMzfOlJZA8lnY79
           OQEkdmdHcf7mQ==
Received: from 83.24.132.245.ipv4.supernova.orange.pl (HELO [192.168.1.14]) (olek2@wp.pl@[83.24.132.245])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <greearb@candelatech.com>; 26 Oct 2025 00:00:56 +0200
Message-ID: <626b4034-13f2-4b09-9f48-5bed9a6c82ca@wp.pl>
Date: Sun, 26 Oct 2025 00:00:55 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: add tx checksum offload for mt7915, mt7921,
 mt7981 and mt7986
To: Ben Greear <greearb@candelatech.com>, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 howard-yh.hsu@mediatek.com, StanleyYP.Wang@mediatek.com, rosenp@gmail.com,
 luoxueqin@kylinos.cn, chad@monroe.io, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20251019155316.3537185-1-olek2@wp.pl>
 <fa7befd5-b2c7-4277-ad57-a1577216ba83@candelatech.com>
 <5a529d81-fb4e-4e7a-a132-3b76d26c3696@wp.pl>
 <4f75bb90-25ee-4312-b4b1-3faf0249b05a@candelatech.com>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <4f75bb90-25ee-4312-b4b1-3faf0249b05a@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 7bd021ef727bbcc9a938de5417393e54
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [UbDx]                               


On 10/19/25 20:18, Ben Greear wrote:
> On 10/19/25 09:43, Aleksander Jan Bajkowski wrote:
>> Hi Ben,
>>
>> On 10/19/25 18:26, Ben Greear wrote:
>>> On 10/19/25 08:51, Aleksander Jan Bajkowski wrote:
>>>> Supports IPv4 and IPv6 TCP + UDP
>>>>
>>>> In various tests between MT7986 and Intel BE200, I observed a 
>>>> performance
>>>> boost ranging from 2 to 12%, with an average of 5.5%.
>>>>
>>>> I did the tests on the MT7915, MT7981, MT7986, and MT7921 variants. 
>>>> The
>>>> MT7922, MT7925, and MT799x are untouched for now and still have
>>>> checksumming disabled.
>>>
>>> At least with  7996, tcp csum only worked on the first few vdevs
>>> created in our testing, so we had to add logic to disable that flag
>>> on subsequent vdevs.
>>>
>>> Have you tried creating a bunch of station and/or vap vdevs to see if
>>> all of them can still transmit TCP traffic?
>>>
>>>
>> Thanks for the useful information. On all tested devices, I had a single
>> AP configured per device. I will try to create several APs for each 
>> device.
>
> We can try it out as well.


I've tested multiple VAPs (15x AP + 1x station). It seems that everything
works fine on MT7915, MT7981, and MT7986. By connecting to the first
and last AP, tx checksum offload works correctly. MT7921 only supports
a single VAP, so I skipped testing it.

>
>> I also have a router with MT7996. A quick test shows that checksum
>> offload doesn't work on this router. MT7996 is visible in the system
>> as a single DBDC device. I have 3 APs configured there. Each on a
>> separate band (2.4/5/6 GHz).
>>
>> Best regards,
>> Aleksander
>
> We have it working on 7996, but the patch is tangled in some other 
> changes we made
> with how wcid and such are allocated.  We are still cleaning and 
> testing patches
> on top of Felix's tree, should have something to post sometime soon.
>

Maybe only the MT7996 is affected?

