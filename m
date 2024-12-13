Return-Path: <linux-wireless+bounces-16388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A04619F154A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 19:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70EE164515
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEF91EC00E;
	Fri, 13 Dec 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Fzl6DeUN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DC1EBFEB
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115915; cv=none; b=iFi1Fg3l1xHVT4RnDjcsNyyeobqlJ8fS6Ryw384CwKPv9K/ZMp+QXnfz6D4FPxEFgSOyyu8zrBeg3jtUpk38vDNATXFsJ9M3+Fm3OF0caK3D9umHOFpOb26wF9Onz5rO2Ylq2CDrpJQ9OadGNX4tLSZi8KaQhgqytVVtWMJiKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115915; c=relaxed/simple;
	bh=NLUAsg7QArkipTxcqM6ShAj/B8hNpJnbyrELDYtnFXY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TT+uxCres6aHD/wnW6MuBEG68QQE3oGOTWvnS9niAow0uPnaxr94nGfJMGjZp1TiaC0vPdDSyfZcg1o57eXlhM6Um90skocT9B2dbgCfPiVkwrZMH93iuQ862wHaukxaRn9dPia5lIau4jTXvoszOwrIW29BgkMPpIfvhkQT7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Fzl6DeUN; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9D604C00076
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 18:51:44 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 09D8113C2B0
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 10:51:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 09D8113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1734115904;
	bh=NLUAsg7QArkipTxcqM6ShAj/B8hNpJnbyrELDYtnFXY=;
	h=Date:To:From:Subject:From;
	b=Fzl6DeUN9/aEI0frwD6pPY1p0gyVdE646uF5ugTgt+KVZbcPbB8THQxrqb/hwBoA3
	 2jppzd9kypR36aGPPmT73TZA6MIkCsQs2VYt8JY/YeS57XPfS0PWSyoMujWwOXMaaY
	 OGco4i/MvIa1YwQZon33EmjUPo7JCtCjC8WOeUfM=
Message-ID: <ffe9a994-2866-b25a-5aaf-bb5089916c7e@candelatech.com>
Date: Fri, 13 Dec 2024 10:51:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: RFC on per-link stats reporting.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1734115905-aY5d9wfdBA5f
X-MDID-O:
 us5;at1;1734115905;aY5d9wfdBA5f;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

While trying to better understand how MLO was working, I started
on some code to gather stats from the driver so that mac80211 has
visibility into it.


In particular, I added a small struct to hold per-link stats for up to 3 links
to the station_info struct.  Then in the driver, I gather the available info
when mac80211 asks for the station info.


#define IEEE80211_MAX_STA_INFO_LINK 3
/**
  * struct station_info_link -- Link info
  *
  * Same definitions as in station_info, but for links.
  */
struct station_info_link {
	u64 filled;
	s8 rx_beacon_signal_avg;
	struct rate_info txrate;
};

struct station_info {
....
	struct station_info_link link_info[IEEE80211_MAX_STA_INFO_LINK];
}

Is there any interest in this approach for the upstream kernel?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


