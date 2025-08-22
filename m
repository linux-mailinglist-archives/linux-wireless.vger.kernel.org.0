Return-Path: <linux-wireless+bounces-26560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 764D8B322C5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 21:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFEFE4E02D5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4939A2D0608;
	Fri, 22 Aug 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="F0BNBUYT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8E233712
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890665; cv=none; b=F3q8RKkFeuPW45ErrrmNOPAwYd3c5OqQwUIUouPBz3M2a1QhfrlbssnGdZ4C/QuiZMkNr01jNbYDaFbC+cCLlDxCtebxKb384rXell9105YH2ySoJBeRj+lVT3rEyWJWmzf6EXLqt+WSoiuWh4Eu/wUNcc1/+1vVW7aurYeYcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890665; c=relaxed/simple;
	bh=rfPq/J7l2T+JDVXyO9nKv5RoHQJOiNzGNitpLYhet5k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gp/7LZzWKHoyxGyK66qjyQ8C49dOVk6AKU52FT37u188mAmM+y9SYKfY6L1eQ1ER7uAc4yFqvhfNamUmvZEer7Yeh3hE09aqZ298lNioUuTv7vIfO6/yBOwDAAdaZBVqJAyyOabosBN6/ojKOgAEJ8fiKAc/JchZWBp+ynHUoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=F0BNBUYT; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5E13C2CE7EE
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 19:16:36 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4F66BA800BD;
	Fri, 22 Aug 2025 19:16:28 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id B991F13C2B0;
	Fri, 22 Aug 2025 12:16:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B991F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1755890187;
	bh=rfPq/J7l2T+JDVXyO9nKv5RoHQJOiNzGNitpLYhet5k=;
	h=Date:To:From:Subject:From;
	b=F0BNBUYTXGM2njkomPRQuWlstBLkGXM29xwS2xnyTqilGubRH0FTqzF4S0Q+sAlcH
	 p/Dv6jY+0iqqVZlh61n6a21Z2QeKAsZSyfW7HDoqYH0Om9LhIQ7bjipOb7wACVyC6P
	 TzGojQLxDXkxANLu4m5t7G6jecOD4UQ142q1t0nE=
Message-ID: <39bf5755-254b-e7b8-cc15-500be99d0a6b@candelatech.com>
Date: Fri, 22 Aug 2025 12:16:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: VRF and UDP broadcast frames
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1755890189-baLc69HsIe27
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1755890189;baLc69HsIe27;<greearb@candelatech.com>;abcb0bc45f5ce597c813a23c027ae4ed
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

Assume I have a network interface assigned to a VRF (wifi AP interface is what I'm testing now).
I would like to have it be able to send and receive UDP broadcast frames.  I am binding the socket
to the AP netdev with SO_BINDTODEVICE.  From what I can tell, the socket at least cannot receive
UDP broadcasts sent to it.  I do see the broadcast arriving on the AP interface if I run tshark.

Is there any particular issue with UDP broadcast sockets in VRF?  Do I have to instead
bind to the vrf netdev instead of the ap netdev?

And always possible I doing something wrong in my socket code, my current test setup
is quite complicated.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


