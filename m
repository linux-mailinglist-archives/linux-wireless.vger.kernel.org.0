Return-Path: <linux-wireless+bounces-29231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD760C787C3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 11:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DF25A2D5B0
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A5933B97F;
	Fri, 21 Nov 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="J5dU9Vq3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07030F941
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720513; cv=none; b=YfeIeCctNHmBqbUEZtH0VJThfyR1YSlThuSUmghmEmiLWqB+PkCG43eUi2Bo1PN5yrN6mKgs0QmJ07hYuPNb4xRgxwbCVInFWop5BrfcDJeUpFlcj53m04MU3m+8TjTuMTjjTX2eA8AFexeNZgcrgkaGi7xi4XSR0mQAx9PrbYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720513; c=relaxed/simple;
	bh=Hc4tJ+sIxxpJNyjCE5vy0Ac+UC4RZ/t+r0ry7v3C8XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhQq0YVr784GXl4CyHKeO0skPHowcTdMXuMj9pRzfrCyrzxfWWtXfkzDQMOTXZdWbxjfUDycGWg94hb4+6zbYuQPikf65mXRrRwffgWBkP8d32uO1WFn3+BEuuggOy+jVDgQozDqfKJn4VLvjJfXUOslp8UVUHLPXp7ackJNOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=J5dU9Vq3; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003b.ext.cloudfilter.net ([10.0.29.155])
	by cmsmtp with ESMTPS
	id MD0Wv38C6VCBNMOFTvvnUl; Fri, 21 Nov 2025 10:20:15 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id MOFSviegZ2l0kMOFTvNoM4; Fri, 21 Nov 2025 10:20:15 +0000
X-Authority-Analysis: v=2.4 cv=UfRRSLSN c=1 sm=1 tr=0 ts=69203cdf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4DtsFWJC70/ZxGj2xnZlig==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10
 a=jEDRzRcZQiSlmEJ3nGUA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1Zi2Rlboat3s++N0jwAAqz4jayQmv+NQPH4dP3X9BSc=; b=J5dU9Vq3+n7f5C0n2POtZJxyy0
	R5gtKKTbywE65sO1O6dGyL/ngu7LcW4Rtr6EqXCDcE5q+ZxN1zQ2c4U6fp5OM25mW+TzDOa8HXAk8
	08RGss8lgeCj4C8ejbkslJfQmgK+/f7zUkAKlBbx9H4a8Sga2iWiw/wSN9+VtPYBy8vAuqXo/82aG
	9fa7nA9FhMETn9uS4tNDWxNOn9l1cg7nvAXrMFnjC8X7o2/dS0/McPsS7zDs4R+j9yFe8If17h0qp
	tMHlWIS39endc8yhiYU+CjhBdM3WkWAE780zOROBIgv6xkuvVpsg4LKNF8rCAI06PNe/6DT26V0qT
	bts9O/2A==;
Received: from softbank126126126075.bbtec.net ([126.126.126.75]:57704 helo=[10.221.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vMOFR-00000001W4P-1mUC;
	Fri, 21 Nov 2025 04:20:14 -0600
Message-ID: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
Date: Fri, 21 Nov 2025 19:19:54 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
To: Zenm Chen <zenmchen@gmail.com>, gustavoars@kernel.org
Cc: Jes.Sorensen@gmail.com, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 pkshih@realtek.com, rtl8821cerfe2@gmail.com
References: <aR2I9Sere0W-4VZz@kspp> <20251121100654.9125-1-zenmchen@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251121100654.9125-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 126.126.126.75
X-Source-L: No
X-Exim-ID: 1vMOFR-00000001W4P-1mUC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: softbank126126126075.bbtec.net ([10.221.86.44]) [126.126.126.75]:57704
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJQkbqjxuSdBcqCUflaAIeLm6FjkmCBhL7JyUlqahrDVJT7ZVLjKxNNYKnOxolzzejpeyJ/5kEaaL6pYLeh79dGdG2ntDyNdR6sPHSZ9Rz5Ck1KAvev5
 oKBPbCv+mLJNk4GMzPBeXqTT16dYDgIeVulWAa/T+UKOMkM5ZDP1LXf3HFQvfBZB3wfZA09UF+PzdZWC6UoKizAkTPGWCAqC7aVnJGJepYGriXFdQX7fdPp5

Hi,

On 11/21/25 19:06, Zenm Chen wrote:
> Dear maintainers,
> 
> With this patch applied, my system always freezes right after the rtl8xxxu
> driver is loaded. is it normal?

I don't think so... It probably means that struct urb urb; cannot really be
moved to the end of struct rtl8xxxu_rx_urb or struct rtl8xxxu_tx_urb?

It'd be great if you could share a log.

Thanks for the report!
-Gustavo

> 
> OS: Arch Linux
> kernel: 6.17.8-arch1-1
> test devices: RTL8192{CU,EU,FU}
> 


