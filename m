Return-Path: <linux-wireless+bounces-17099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140DA01F2B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 07:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009A71884CAC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 06:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D022817ADF7;
	Mon,  6 Jan 2025 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DWhj12ZY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501D522A;
	Mon,  6 Jan 2025 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736144583; cv=none; b=FGYszDvc/uBF1G+dT00VKyR7t3uontuHt8GUdnFfKqx+Duk49/WukGx+HnhEqP46pAy+yGgX9GaeC1ECH/47/d233z43B3SOXksKRKviqRXuvmRSrJDcdx37pI+AzFq7T9ffE8XhtmAnMBvpSU6xzna3z3HxO3phAXvM21tYE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736144583; c=relaxed/simple;
	bh=brBb0ZI3IqNYbjSb4aNmEkOUSDGJLX5YQiSq8845WeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kbZ30o4R+CYapAiroeqtEEihSgCiSz+bvKZQWjHbxikOR7Uz2n3zkE3DQqQKwnXXZvAL0iv9IHDP4dUX80hA/6WHbJeNtg0OWbjR0QIL6TndBuePXYJJXiZV+8SMGWoInDxO6DI8oUYT7eVPWr6XqhYJ2TBuWJC2B+/TWu2HLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DWhj12ZY; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5066MIeY040239;
	Mon, 6 Jan 2025 00:22:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736144538;
	bh=VeuIzwJJmYcySFKjLhgZukJvb83Xid+pq/c4f1Rm+kA=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=DWhj12ZYQJgH+BuqkUU/MeI9n84K1lPIrV/Xe3HU8cFx9qc2BNYrX0fF9WiSuJAKN
	 gQvDIOp8Wp7lU6MCP8R2lfKXfA0IbjgYLR9V05S1WALmQQ871P7xa/iUzUPcvDbp2S
	 wu/W4geZ6gsuiRuvsx2I10b+1a4D5BJas+kMhGQ4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5066MIm8006953;
	Mon, 6 Jan 2025 00:22:18 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 00:22:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 00:22:17 -0600
Received: from [137.167.1.99] (lt5cg1094w5k.dhcp.ti.com [137.167.1.99])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5066MF3F040372;
	Mon, 6 Jan 2025 00:22:15 -0600
Message-ID: <b198db94-1857-4c2a-94d9-69dc13d7c67d@ti.com>
Date: Mon, 6 Jan 2025 08:22:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wlcore: fix unbalanced pm_runtime calls
To: <akemnade@kernel.org>, <kvalo@kernel.org>, <rmk+kernel@armlinux.org.uk>,
        <johannes.berg@intel.com>, <miriam.rachel.korenblit@intel.com>,
        <leitao@debian.org>, <andreas@kemnade.info>,
        <emmanuel.grumbach@intel.com>, <tony@atomide.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250104195507.402673-1-akemnade@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <20250104195507.402673-1-akemnade@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 1/4/2025 9:55 PM, akemnade@kernel.org wrote:
> From: Andreas Kemnade <andreas@kemnade.info>
> 
> If firmware boot failes, runtime pm is put too often:
> [12092.708099] wlcore: ERROR firmware boot failed despite 3 retries
> [12092.708099] wl18xx_driver wl18xx.1.auto: Runtime PM usage count underflow!
> Fix that by redirecting all error gotos before runtime_get so that runtime is
> not put.
> 
> Fixes: c40aad28a3cf ("wlcore: Make sure firmware is initialized in wl1271_op_add_interface()")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Michael Nemanov <michael.nemanov@ti.com>

Best regards,
Michael.

