Return-Path: <linux-wireless+bounces-9762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC99591DDA9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 13:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635C32836E7
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52A412CDB0;
	Mon,  1 Jul 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knR4r2R/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE71F949;
	Mon,  1 Jul 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832597; cv=none; b=qWOwM2+swUmaKTwrqeOxRINKCsy8Splyk/MVc0OVUw6/Q/vVzf6v0FBy7Gn6bSP3d1VtNt/ZWuvn5KFXQ3l0xxvmS7opvgC7ifbyghY1t35/xzJRrAWcgyQ2Nu3bB3wGqgNoV+Xviz0eqZ6Ocq8n8koQy/O95iEMIXX+RY90bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832597; c=relaxed/simple;
	bh=TTdQIF5P3tI3CzxxZIg5F8A+9LlsQLoGgl0++LtrM5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xrf5q+xwScDBrktWazBxbwWj5qFbkkSMmQZW65Nw9RsdrpVAhCdrc2MSP+bDAnjQKLaJb815jcnvqVU3p48hHD/lIK/pIALrDpeFECeLCpl/JM51FpLb3pCGt1B3xv3Sx6AyOWJUvGF9zJU71Gg27epLsnsBwCVGPI7j6DLxNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knR4r2R/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A3AC4AF0A;
	Mon,  1 Jul 2024 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719832597;
	bh=TTdQIF5P3tI3CzxxZIg5F8A+9LlsQLoGgl0++LtrM5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=knR4r2R/ZjrqYSETXcj+DyF7JPiSC4O/Idwwdk6g96Sw5f1zYn+rz96mUUqpLxsNh
	 zDrZuvlSWJdQFAiEeFy40tr36IJWtkQjBS95nT9umS/+tsTVtGC+ocVcI2E2ltv4qv
	 utRZaTr91FCxi/01CWWnrHJJG5/PtbbmsFtaeLg29TfU7U5bSpMf4PUDRpROO9NzGC
	 wC7jYipJq3kR18B2vRlRs8DuZyK2XgeMp2GGR0W/gG40EDzUMfxpuaGgIyMFDQGdB3
	 4ELvFS5TkTls9F6Y/Zy0kqXmOnPMTlqnNKH2pOfOxmU15v7N+XW+uqkmuCj7O9OBK1
	 x4ueF/eAQnSFQ==
Message-ID: <c2febca9-59e4-4505-bbec-6e61f7d8b944@kernel.org>
Date: Mon, 1 Jul 2024 13:16:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arm64: dts: rockchip: Add AP6275P wireless support
 to Khadas Edge 2
To: Jacobe Zang <jacobe.zang@wesion.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "heiko@sntech.de" <heiko@sntech.de>, "kvalo@kernel.org" <kvalo@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "efectn@protonmail.com" <efectn@protonmail.com>,
 "dsimic@manjaro.org" <dsimic@manjaro.org>,
 "jagan@edgeble.ai" <jagan@edgeble.ai>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arend@broadcom.com" <arend@broadcom.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz"
 <megi@xff.cz>, "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "minipli@grsecurity.net" <minipli@grsecurity.net>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 Nick Xie <nick@khadas.com>
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-4-jacobe.zang@wesion.com>
 <eeeb3f1f-5c77-4ca5-b996-17b968b7c2f0@kernel.org>
 <TYZPR03MB7001FFD5180C6248F14EE48E80D32@TYZPR03MB7001.apcprd03.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <TYZPR03MB7001FFD5180C6248F14EE48E80D32@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/07/2024 12:38, Jacobe Zang wrote:
>>> +     pcie@0,0 {
>>> +             reg = <0x400000 0 0 0 0>;
>>> +             #address-cells = <3>;
>>> +             #size-cells = <2>;
>>> +             ranges;
>>> +             device_type = "pci";
>>> +             bus-range = <0x40 0x4f>;
>>> +
>>> +             wifi: wifi@0,0 {
>> Where is the compatible (again!)? Test your code - you will see your
>> binding is a no-op.
> 
> I tried to build kernel with CHECK_DTBS=1. And didn't get any message
> like 'compatible' is a required property in wifi node. But when I check
> the bindings that do required the compatible... So I will add it next time.

Yep, use different clock name and then test. You should see errors,
right? But there are not, because schema is not applied to this node at all.

Look how Apple is doing this.

I have doubts that your code works at all in the first place. If there
is no compatible, how your platform device gets of_node?

Best regards,
Krzysztof


