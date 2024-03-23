Return-Path: <linux-wireless+bounces-5161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C4887A1C
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Mar 2024 20:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178541F217CE
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Mar 2024 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663614AA3;
	Sat, 23 Mar 2024 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="agmyMfrm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98C2E410
	for <linux-wireless@vger.kernel.org>; Sat, 23 Mar 2024 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711221058; cv=none; b=mPpaMJDOUCFyN9rjiFDaPdc88tdkbyAZuXalIZeigYJvTEXNGidh/UFz3sqZ8h+Jh7tGPL2IrDWODWJI++FMOt3tCCSIwcJoIyo/z1DoYmK50TjK105U2ZdCZcw/9E9wTdmUL1zlxIgl8b9KuGTrbjCCZZc5o4pJX0SLJksjc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711221058; c=relaxed/simple;
	bh=y57fkBM92C41hkZsz/Fwa06nhzjhhZB/e2qLuYZnyu0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=TL3sVd8vnL5CAjI9NbqgkA4yLdiB2JOiA8ZkRfvFl5OEbpd12wMCLeaLMmLELq+85y1MkuxH4Z90SyY1WYbQRGgekZ3XadqyHJ9ZlKNqn3oAUpJkvbewubgMZiMltpPI/7AfCcAObujqSubqP6+/hlh5KFk8e141B1XrbYdD4Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=agmyMfrm; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6CE0CC00075
	for <linux-wireless@vger.kernel.org>; Sat, 23 Mar 2024 19:10:48 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0DCE713C2B0
	for <linux-wireless@vger.kernel.org>; Sat, 23 Mar 2024 12:10:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0DCE713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711221048;
	bh=y57fkBM92C41hkZsz/Fwa06nhzjhhZB/e2qLuYZnyu0=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=agmyMfrmsDPXntXqtgvrWyx96H7xSnc9dG0lcyuT9hmlndnLNJhgZOtKH3Er0WnYW
	 uAjrKFpLyeKdecN2EWCUveZpUVuNlCW5jKicNBgPjYDTr1PpklXi0LBGYgPi4uuuZT
	 ruImQhXpF8GmTutaK2L5xxO7cAG/qRT98dp8micg=
Message-ID: <23a33f8e-4af0-43fe-bd26-c92aab429d3a@candelatech.com>
Date: Sat, 23 Mar 2024 12:10:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Access to ieee80211_conn_settings in the driver?
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <1df701f9-3f27-4887-a9ed-60cf2f12beb4@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <1df701f9-3f27-4887-a9ed-60cf2f12beb4@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1711221049-nhj4QbktFdwO
X-MDID-O:
 us5;ut7;1711221049;nhj4QbktFdwO;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

On 3/23/24 11:55, Ben Greear wrote:
> Hello,
> 
> I'm interested in getting access to ieee80211_conn_settings
> struct in drivers.  Specifically, so I can deal with disabling
> 160Mhz in mt76 even if peer is 160Mhz for instance, on a per-station vdev basis.

Actually, 160Mhz is bad example, but in case I want to pass other
association config info into the driver, like disabling as much of
OFDMA or MU-MIMO as possible.

Looks like maybe Johannes' existing changes already make it a lot
easier to limit bandwidth in the association path...

Thanks,
Ben

> 
> Is this of general interest, and if so, any suggestions for you
> you'd like to see it implemented?
> 
> Maybe put a copy of that struct into ieee80211_link_sta struct
> during association so that the driver can find it?
> 
> Thanks,
> Ben
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


