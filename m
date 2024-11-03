Return-Path: <linux-wireless+bounces-14845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FBF9BA579
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 13:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4171C20E35
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A45166F06;
	Sun,  3 Nov 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DxTDn6oK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36576A50;
	Sun,  3 Nov 2024 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730638584; cv=none; b=rWAMni6rConRL0XpxKjk3WW5YbyYdq2N/oi/gKoW1HwnNeqvbt0LQAaV3vipOaK7FGSaXKzBlL2abCdwcPGMdLCxmCwjikHOCKMTLqauYJztmfUu0xSSKpOHmScSFZtr848vF8DMYpHsNPgKzk1dVuMZ3HtcjsxqH7exCWwajvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730638584; c=relaxed/simple;
	bh=5BPjS0OhAOC67ybt4pGDY+igTlAREpgzNPHZfG2fOz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=muI8s4o6S5P4S6rbXE6yRMM8VqOtrkMeycSqWkRqUwb2o1sj28gz2qoG0U5vXqROxvuz79ugdUpha+rC8eIEZ5FoesuaeCH0Jo/U8orGa+eRqPOg0NhKGa5Anc1Dbb06QLZSqq0V096d+cDRJ7L5pvHmobsx+J7ix575N1a90Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DxTDn6oK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A3Cu1O3048337;
	Sun, 3 Nov 2024 06:56:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730638561;
	bh=tLvRfw/FM5dRmeV/mlHH2Fgn6SVR6Sf13E7zxcblSYw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DxTDn6oKReH3yQDRBDLyCmXmHjRtOCX87Mjiu9G/cUr6SuTppF8LUdPf+Jyz2KL3C
	 qr7eLML4ptoKOf0eG3QwTIP2wA15H06pmOuPksPCAutR9X8KbOD5cBq9CH1AopBqO5
	 BjYmIZKZo59Mw3nx+JbQGepbHHLoPDAx/dewMZz4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A3Cu1AH083882
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 3 Nov 2024 06:56:01 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Nov 2024 06:56:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Nov 2024 06:56:01 -0600
Received: from [10.250.202.81] ([10.250.202.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A3CtvF0036607;
	Sun, 3 Nov 2024 06:55:58 -0600
Message-ID: <c2fd6c15-6b30-4777-93ae-d20b0c4a76a0@ti.com>
Date: Sun, 3 Nov 2024 14:55:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] wifi: cc33xx: Add main.c
To: Simon Horman <horms@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sabeeh Khan
	<sabeeh-khan@ti.com>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
 <20241029172354.4027886-10-michael.nemanov@ti.com>
 <20241102132532.GJ1838431@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <20241102132532.GJ1838431@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/2/2024 3:25 PM, Simon Horman wrote:

...
> 
> Hi Michael,
> 
> Sparse seems a bit unhappy about this:
> 
> .../main.c:332:24: warning: incorrect type in initializer (different address spaces)
> .../main.c:332:24:    expected struct ieee80211_sband_iftype_data const [noderef] __iftype_data *iftype_data
> .../main.c:332:24:    got struct ieee80211_sband_iftype_data *
> 
> So perhaps it should be:
> 
> static const struct ieee80211_sband_iftype_data __iftd iftype_data_2ghz[] = {{
> 
> Likewise for iftype_data_5ghz.
> 

Hi Simon,

Yeah I saw that and was unsure how to properly solve it, Sparse does not 
seems to like direct use of this variable. The above is based on old 
code and I see newer implementations are using 
ieee80211_set_sband_iftype_data which has the casting that should make 
Sparse at ease. I'll try migrating the CC33xx code to this convention 
which will require moving some structs around.

Thanks and regards,
Michael.

