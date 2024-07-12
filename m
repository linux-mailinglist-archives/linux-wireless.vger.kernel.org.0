Return-Path: <linux-wireless+bounces-10211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A58A92FFFC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 19:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDDD28378B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E64171085;
	Fri, 12 Jul 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="LZRXG7ny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2F143C52
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806735; cv=none; b=TpAB6aG+Y7Hjxu4ShD8EyIez6NHc0n/wvjdPZ6cBgfU+aq/QGbURthC+GxK5aejnqo91wKwuaOZQj/S7VHlN74n1oz7JmKKMv9x15a0NXAJbY6FUkizuEQlqH1xZJjPSGpaMYZfWWXX4rKcaMzqBFR2Gik4Y1AEYNQP/8QFproA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806735; c=relaxed/simple;
	bh=8qsXs6ZE1ce+btzwdS1iMl+i4IjIPuh8InyEbTrBgeg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=p2CtpS+5WYfa42xmzV1qydVL3K3QPe0/ZH0QQWyfe8lFb82LPj9p6khxoEZNgy6QXIYJa8wEEzWIQo14Y/aeWrzVA4VE+KNLsvWuO2scHMp6oUzFo0xQ+D/aHvsYaHN7+ZF6VkrZPp+J/YTDKhqLqeO+rj8+VkXPr3KrBkw3Eyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=LZRXG7ny; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ADDE9800079
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 17:52:05 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 287F413C2B1
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 10:52:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 287F413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1720806725;
	bh=8qsXs6ZE1ce+btzwdS1iMl+i4IjIPuh8InyEbTrBgeg=;
	h=Date:To:From:Subject:From;
	b=LZRXG7ny/aZtFbzLho04MifIKzmODF2TxoQBbTVv8ZYoo8NU917woGcgzX37mYoa8
	 KCXL7406s3QSykn6v/o/D4a2TQM0oKKrkgeEg2SBg8SqmFRm7f9uNX/W4w++T2OwPj
	 Aq86ySAul/X7N9/FxWbT3ur7EO2aQwTAffJ50fmc=
Message-ID: <c896c0d6-b43f-ba6d-336a-eca15c60529f@candelatech.com>
Date: Fri, 12 Jul 2024 10:52:04 -0700
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
Subject: Per MLO link TX stats
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1720806726-xsUGt0aJlP1T
X-MDID-O:
 us5;at1;1720806726;xsUGt0aJlP1T;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

Hello,

I've been trying to get better per MLO link stats.  I see that the rx path
stats are there, but in the tx path, I do not see anything other than 'deflink'
getting updated.

And, at least with iwlwifi, I cannot find any way to actually see what link-id
was used to transmit a frame in the tx status callbacks (or anywhere else I looked).

In the case where there is a single active link, then I can hack something together
that should be at least mostly right, but that won't fix any future radio that can
do 2+ active links.

Any suggestions for best path forward on this?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


