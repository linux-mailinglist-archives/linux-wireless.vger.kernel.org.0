Return-Path: <linux-wireless+bounces-9583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A739178E7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 08:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4D61C217D9
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 06:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B2014EC7C;
	Wed, 26 Jun 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3piVmjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF114D2A8;
	Wed, 26 Jun 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383314; cv=none; b=RDlrW9+fVJkhzaA2VHihLNlMepbxlGduFKwaVvsRVQlgHM7bgFBAQgxCqlruSodPoovaThW9vmto9lQyjS1qKXPJ81v9nM8d/dShE5MbZREDRGq83HGkxvmh+yVnNkN2yzi56L41q20FMXxChxZcT7KiGlgueknRHV1B1YtTyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383314; c=relaxed/simple;
	bh=hSJglXZYv5KAZogk1GoXR1+rsFxvyZYlzU5jgV1gLYI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c77EtoeZ+aa6Mi26VD9OzYOyhCvUv/94l9JFk6VMyjN/wuVf8eVhbm25kGfKAYRljJYs14TS5w+BPpozSx8V1v/Q9qp2ojWMsk5D1ktxybPPZ94Mm/B2CsRsfPgqnjogVpiXCQzfXzZWnYyK5dLrGSklsZCh9mIphPJUVSp62Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3piVmjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD4AC2BD10;
	Wed, 26 Jun 2024 06:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719383314;
	bh=hSJglXZYv5KAZogk1GoXR1+rsFxvyZYlzU5jgV1gLYI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=P3piVmjKn7J1QV5gzfNXeeO7wmxgfFsVN78j8VFq5jWrsV/vFQQygCKRTS1mMcrPf
	 sVWeXtl164fnP3Dj+/XFs2w0aWTvWDlcjI8DQ4pPtZVbWcJmxcJZyNJK+2mnbQrOqB
	 hBRsYxk2HBCum+obj2YF4ApHJ6/e0GwXmceBIUMNIZUXZLwBBLQ8to/R8trXoQX2ty
	 kmfIri7NNZzqghuAdvBtqpIqqJmTD+/6iqxODNLz5klJISMJs6zU8oNqt2E2BI+RAi
	 OK6itTDfwnDfo198T7sZX/j+i61lb1bnZbZUqjnZGgo0JJo52V9LWq5e/uzjTNqLaS
	 UdKyGzchhP7rA==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <aspriel@gmail.com>
Cc: Jacobe Zang <jacobe.zang@wesion.com>,  arend.vanspriel@broadcom.com,
  duoming@zju.edu.cn,  bhelgaas@google.com,  minipli@grsecurity.net,
  linux-wireless@vger.kernel.org,  brcm80211@lists.linux.dev,
  brcm80211-dev-list.pdl@broadcom.com,  megi@xff.cz,  robh@kernel.org,
  efectn@protonmail.com,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  heiko@sntech.de,  nick@khadas.com,  jagan@edgeble.ai,
  dsimic@manjaro.org,  devicetree@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-rockchip@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
References: <20240624081906.1399447-1-jacobe.zang@wesion.com>
	<20240624081906.1399447-6-jacobe.zang@wesion.com>
	<89f2564f-788e-495d-97ce-f1fa8a921d50@gmail.com>
Date: Wed, 26 Jun 2024 09:28:28 +0300
In-Reply-To: <89f2564f-788e-495d-97ce-f1fa8a921d50@gmail.com> (Arend Van
	Spriel's message of "Tue, 25 Jun 2024 20:23:09 +0200")
Message-ID: <87pls4gqur.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend Van Spriel <aspriel@gmail.com> writes:

> On 6/24/2024 10:19 AM, Jacobe Zang wrote:
>> AP6275P Wi-Fi module connected via the PCIe interface.
>
> Repeating my remark from v1 series although I gained some knowledge
> what chip it should be now ;-)
>
>> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
>> ---
>>   .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml      | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git
>> a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>> b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>> index b9e39a62c3b32..fd22ade92210c 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
>> @@ -53,6 +53,7 @@ properties:
>>             - pci14e4,4488  # BCM4377
>>             - pci14e4,4425  # BCM4378
>>             - pci14e4,4433  # BCM4387
>> +          - pci14e4,449d  # BCM4329
>
> This should BCM43752 iso BCM4329.

My simple english parser threw an exception here ;)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

