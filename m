Return-Path: <linux-wireless+bounces-8039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 704FC8CE1BE
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005E2B21B86
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F071292C9;
	Fri, 24 May 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xhUi4/3G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738251292C3;
	Fri, 24 May 2024 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536947; cv=none; b=bkL7A3Q9zT3HTQcl3jCIv8PO+z5mgtRAUIJonfHzTmECQlSEwDwsp1zpV1zSsqpGAz4VjzLvgW+8uCLix2HF5L6gq834e5OChVp6cAiVzuLxTGDQGqpepweGlR9xIGnPJuyRfXhf5CU9iZDxFi5eroGexPJTBUC7YexP442GUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536947; c=relaxed/simple;
	bh=FbAxsDuQqprqbZ3o1qy7Esisf/ahAAzjSyXHO2NFNc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ehN6u7gW1D4SaLdSnDIG787c/Jm06oH9wFhM/jurHVy7cH1o7VdErz01HCwH8h1o+0YDQu5lQLYrrbUkyZQBSMrm5XnGf38YimOIlTipmnhs1Y0yI2Ml3TB0f+mh4pfXwuCIa27jcwp04CSX0PV4Oer5KoS/TNxrPJfurLjDoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xhUi4/3G; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O7mpgB110057;
	Fri, 24 May 2024 02:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716536931;
	bh=LbV912eUItDCFeujcZ+K3k698C6fxl6NNH6ifgGmUWE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xhUi4/3Guvgv7deYfTV+ieGc6o4LiLwhr0YRbqoLRjcUYQHMPqp9PB1/6A32Y6a+Y
	 v4lT05hmp/OlEb99aon6if5gPgpZcX65R2qN+Zwn4v3f7kUPAy7zcUEC929nLSsjOS
	 f0whMXr20j64LTMVCiQKC8KJunrMZgC6PcKEVSQU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O7mpos042818
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 02:48:51 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 02:48:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 02:48:51 -0500
Received: from [10.250.145.232] ([10.250.145.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O7mmX2125835;
	Fri, 24 May 2024 02:48:49 -0500
Message-ID: <dd8f294b-425c-4e4a-8eaf-026138461941@ti.com>
Date: Fri, 24 May 2024 10:48:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] wifi: cc33xx: Add driver for new TI CC33xx wireless
 device family
To: Kalle Valo <kvalo@kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>, Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sabeeh Khan
	<sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <87msohatii.fsf@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <87msohatii.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 5/23/2024 10:15 AM, Kalle Valo wrote:
> The community (myself included) has been frustrated that TI has dropped
> the ball on their existing wireless drivers:
>
> https://docs.kernel.org/process/maintainers.html#ti-wilink-wireless-drivers
>
> This kind of behaviour is not exactly building trust. So how is this
> driver going to be any different?

I understand the frustration. As the engineer leading the development of 
the CC33xx driver I can say that CC3300 and CC3301 are the first in a 
family whose roadmap goes beyond 2030. I can also say that Linux driver 
support is foundational for this line of products and TI is committed to 
supporting these devices in the linux-wireless community for at least 10 
years. Unlike previous drivers, development and maintenance of CC33xx 
will be done by TI engineers and not a 3rd party. Is this acceptable?

Michael.


