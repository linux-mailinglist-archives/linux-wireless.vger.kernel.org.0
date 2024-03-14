Return-Path: <linux-wireless+bounces-4780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C43187C52A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 23:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106EC282BB7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BB6385;
	Thu, 14 Mar 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="lQkgvg/P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38F6119
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455708; cv=none; b=flqc72Icv61KE45C512XT1l4OJjDUX8gVVGX37NGCRNv/tZGM+XYtqNKwKx5z/uFsvBzEh7wMPr2fsoTq8CroN6Tmyscn6xsa/pNC9yhOYLPLERVMIzVOmbevIQtO+jkvRK+UoxyngSaTROa/KKUtFi27W1gCd20M+hS2XZtKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455708; c=relaxed/simple;
	bh=sDCkWu2hK/0cTqufm1ZNoS/GLXwKLbAXJrjz77rqnVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oltXPIJDBbBuwnBT7QeGgGQe3SPyoC1/vurkb/qHn1bJNtoZj5M1adYxzxY/14tkzlXkNvy/oZ19SQfLbHs9fep0YIVqXCRQhHtLgtUzIhdMiNZRYR+IToAppSy0T1x4HTLm4/QBPNx+nLhSeEZUPD0/vDQ9iwrCUW9/+6XUKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=lQkgvg/P; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28650C005F;
	Thu, 14 Mar 2024 18:27:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1710455262; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=l1cRCI2TQl2E06OSsyRtxrdsvwE91Cf5bQYoFPWyo4E=;
	b=lQkgvg/PB+EdEmzpxMq+fIlWl6rJ6NWKM0OPcF9Akv7UBMcfOynJhFDp52c20fMaGvAR2y
	owWLGJ6YcjOmbGhQXfuZixLWrzks2nYpNyC6/TXiFuMM4m1/bXeV7yzifrLQpxu8XEdT3g
	gQ0WqGDRmFAhvRwKcPepF1mm2mmPOhI=
Message-ID: <96597f1d-5072-4915-be5a-e685dc85614a@kaechele.ca>
Date: Thu, 14 Mar 2024 18:27:25 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New staging repos for ath1*k firmware
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Sebastian Gottschall <s.gottschall@dd-wrt.com>, Kalle Valo
 <kvalo@kernel.org>, Robert Marko <robert.marko@sartura.hr>
Cc: ath10k <ath10k@lists.infradead.org>, ath11k <ath11k@lists.infradead.org>,
 ath12k <ath12k@lists.infradead.org>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
 <CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
 <874jdigf76.fsf@kernel.org> <3b57d932-0848-40f4-ab2d-a8d4afe11df1@dd-wrt.com>
 <e1c3ba7e-b358-42a3-a8db-f9c098132350@quicinc.com>
Content-Language: en-US
From: Felix Kaechele <felix@kaechele.ca>
In-Reply-To: <e1c3ba7e-b358-42a3-a8db-f9c098132350@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jeff,

On 2024-03-13 15:32, Jeff Johnson wrote:

> Kalle & I are just the conduit, but I've relayed this thread to the folks
> responsible for feeding us the firmware releases.

Thank you for providing that service to the community. It's much 
appreciated.

Is there a chance you could ask the team for the most recent firmware 
for QCA9379 hw1.0 SDIO (Naples)? Branch name would be WLAN.NPL.
There are currently no public releases of this firmware outside of 
what's included in the vendor blobs from some Android devices.
I'm still doing some testing on the patch I sent to support this card on 
February 28 to this list and I'd like to see if some of the issues I'm 
seeing might be a firmware issue.

Thanks!

Regards,
Felix

