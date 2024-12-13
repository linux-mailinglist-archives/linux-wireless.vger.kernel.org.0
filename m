Return-Path: <linux-wireless+bounces-16342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92D9F01B6
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 02:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5ACE16B3BA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 01:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332CD17BA1;
	Fri, 13 Dec 2024 01:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="iWFqqg3Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDE17BA6
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052430; cv=none; b=fiWM9vkXxV1r/CUye/K/6WT+At2rLLUMZ3fp3Jngp7ecpMY4DY4E6py9EpiWmlJLj7HE/Z1Potau9MdPjX/yIkq0KfRrkMiHi4qOeA9g8YohVX2xHPlHEPaWZ6BKdWIAIJE5tp5aRqa4bHbCau/xksLimnSSiwVnGq0RW92igV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052430; c=relaxed/simple;
	bh=XUOZTUal6ZkLK5b3XTqulSGmJCCUiAk79hgUdureQgo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dzbW9/9yPH4NOn3r79QKCEzXr59Q2jLinGdIZ12ZUtXfT4AMwRHarsWlc+HXMqCdldO4eK81nF24E01Mhr3TYhVxi0EWQcTboaAnuyCMIqt0LkLgURLwG19u7xKVoLIN8y3Zp7zAEBvKioeq4wGBhkhJHNqKQWkz6Q0CXUKDDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=iWFqqg3Q; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 500FBC00061;
	Fri, 13 Dec 2024 01:13:46 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id C499313C2B0;
	Thu, 12 Dec 2024 17:13:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C499313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1734052424;
	bh=XUOZTUal6ZkLK5b3XTqulSGmJCCUiAk79hgUdureQgo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=iWFqqg3QQ7hlsjMY3E+SCLWJcPWG47IUx31nb+kfQjSRDMEzDux2+vjcB5y4ZbN45
	 zN6e+7vR0HMDcQ1swjD9iCVzE9nBsmglT9gkZj15gQj9UmpvoBmD6E69BID+UlglJp
	 Gtya0rQMLnZtLvGICggoScjqAxzjZYTQr5Jta0GU=
Message-ID: <f7017d31-8d09-5541-6b9e-cefa07ac26bd@candelatech.com>
Date: Thu, 12 Dec 2024 17:13:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Intel be200 leaving ESR due to low RSSI
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: "Berg, Johannes" <johannes.berg@intel.com>
References: <9e15167d-d4ef-9306-d70b-94f056fec413@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <9e15167d-d4ef-9306-d70b-94f056fec413@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1734052427-pLP73GP35jbe
X-MDID-O:
 us5;ut7;1734052427;pLP73GP35jbe;<greearb@candelatech.com>;232dd55d48f96bb835b07b88a6baba61
X-PPE-TRUSTED: V=1;DIR=OUT;

On 12/12/24 12:40, Ben Greear wrote:
> Hello,
> 
> I've been testing in a chambered setup with a mesh testbed, doing eMLSR testing.
> 
> I am noticing something I cannot explain:

After poking at this rest of the day, I think possibly root cause is that I
am disabling beacon filtering, and maybe that screws up the firmware's stats
in this area.

I adjusted the driver code to calculate the ewma signal avg for beacons for each link in the
driver and that result looks as expected.

That is on top of another out-of-tree patch of mine so I will not plan to post
it unless someone is interested.

Thanks,
Ben


