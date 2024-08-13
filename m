Return-Path: <linux-wireless+bounces-11383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278CD950F96
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 00:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77F3B24CE7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 22:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A41AAE32;
	Tue, 13 Aug 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="X31WAc5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73F56766;
	Tue, 13 Aug 2024 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587550; cv=none; b=nl/Kq5LUvnZOQi3a/TiBM23ZJhqS27zbfzPzfvncDa2H8kX8xOkHTbMg1veYn6zAE4wdVBMrqqQ5S4Dtk0rnk7HYwzwfB7PrbBtRsrAU8A5VxG1uBe+MzsE/O4FUJc1iz8bCpOGXxF451LShxZfPP7hvz503lnNW7iNV+aN+088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587550; c=relaxed/simple;
	bh=KfcmEVu+HZN3haoP5owVL/609mGFgVEiDFltnwkD3rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSsCl4bnvcA+V9yFKyJ1FGJ1wv45uZo2fKb2MWnWAykbmZdQkqqmgRa2buwhJiUgdodlKCjzq8YZaMDxo3s6PCKUVU9J5nxv7BdlOYzEY8JmNrGsV5yMG3fhTuRMjE7RPrOlAF2XiotQMyPJxHoYBa4lOKFBgKCX7gieZ+GOtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=X31WAc5P; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8089BC005F;
	Tue, 13 Aug 2024 18:12:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1723587153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=usai6GDZhtLfh8rMim+JOkJ8cOVXwNu4QF1LRoNJ7R4=;
	b=X31WAc5Pgn7ooRVy8pBWJ0IqGyZx0255faefKxRB02STw1Sr8VPWEX6v4N6BMq0sbmBOlA
	2qho/rEMCN4T9zwQBkpiflVYW4IU67Xb3bpo6ssBr+JW5qLqo5Zxild3ydI2Xx/x4IPik+
	0WwCtKmJ1JLMCatVXsDP0HfHuojO8RY=
Message-ID: <3f16cd19-7609-4f97-bacd-9ab307bd8533@kaechele.ca>
Date: Tue, 13 Aug 2024 18:11:45 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: net: bluetooth: qualcomm: add QCA9379
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-mmc@vger.kernel.org
References: <20240805040131.450412-1-felix@kaechele.ca>
 <20240805040131.450412-4-felix@kaechele.ca>
 <645ae5c7-5421-4bf2-9aac-8151b7db4e0b@kernel.org>
Content-Language: en-US
From: Felix Kaechele <felix@kaechele.ca>
In-Reply-To: <645ae5c7-5421-4bf2-9aac-8151b7db4e0b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Thanks for taking a look, Krzysztof.

In this case I think it would be easiest to just use the existing 
qca9377 fallback and drop his part of the patchset.

As for the supplies: For the particular module I am working with the 
supplies are mostly shared with the WiFi side. So it "just works" 
without taking care of supplies on the BT side.

But I agree it would be more correct to add and handle these as well. 
The documentation I have access to through the FCC filing of this module 
is not really conclusive of how to correctly name them in this context.
I would rather avoid submitting a patch with incorrect supply names.

Thanks again,
Felix

On 2024-08-05 01:31, Krzysztof Kozlowski wrote:
> On 05/08/2024 06:01, Felix Kaechele wrote:
>> Document that the QCA9379, as a member of the QCA6174 family, is
>> supported by the existing driver.
>>
>> Signed-off-by: Felix Kaechele <felix@kaechele.ca>
>> ---
>>   .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>> index 68c5ed111417..f968b0d236e0 100644
>> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>> @@ -19,6 +19,7 @@ properties:
>>         - qcom,qca2066-bt
>>         - qcom,qca6174-bt
>>         - qcom,qca9377-bt
>> +      - qcom,qca9379-bt
> 
> Then use fallback of 9377 or any other device. I still wonder why you do
> not require any supplies.
> 
> Best regards,
> Krzysztof
> 
> 

