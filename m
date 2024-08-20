Return-Path: <linux-wireless+bounces-11712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7F0958E71
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 21:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6681F1F24078
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71B1547FD;
	Tue, 20 Aug 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9hwzYKz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8A156F55
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180718; cv=none; b=jTQ+7Wk5AvHsg00iAxulxQJBXtsngIM5yJxlidtXOXPiZxQKroqwqwMl9AN3TDOKXK6Duh6xrJr/BC/DJ2vtxt5bZdd5BOqjRSVS71AjNv+XMel5mPifKUwPlgp5iZ0QNGCdekF2TiyivgFPZ+J1fmw+JZbpghcuZpq2tbvpOBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180718; c=relaxed/simple;
	bh=ZN72qZN6zR1kVXsjRVWAXIzkcrmbdnzQm6jKrs+K+Y8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=t6o2VglEmv57YOAOw6A7vLj5k7bt5FWpLQZdtzquZoW3tGB646XwZA/UE9YY7/og21f3ynWCqe5+IaFG+tY8fmoR5BBpF3SQtYMoLu7qNUqY78sddqHGZquRGebyJpUke5TYuZhzYns0owD9HCxja9dpRfdNbnbcRGXeE87tUxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9hwzYKz; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a20b8fa6dcso387104685a.3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724180716; x=1724785516; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLic+AT+//cVj0cZOJRFLjyIWDzxE52raEf6fUVZQ1U=;
        b=k9hwzYKzMC39iQ5gLBUF/el7HY6fdISc+/ty6UxX2UmpQRBzFs4NtseP8ANVgxnOtn
         rK+cIwPG/rW4tpmgi6kQ7ze1oZ8cEfdSZKrqkASz4FxBvy8Jk9oeVofS/adqWa4yepl9
         oDIkFgAB0k7J2SjXXqnd/UgUk1TOKk/0svA72JGMMhwSi68c8JBqPtb4jD9izzEv7uxI
         XWExftDfWLQyFghyNG2zjlReiKohVqk8RzSCDnuR9Ae5NCEH3FjHdOLdJYdSxXjrGp/W
         KHE2qjUSXZxRqKrZ2pnxkEUGUNlyuG2VKQTmqlrGaCPZeOukj9akXcE+OKuTMYOM42NY
         gT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724180716; x=1724785516;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iLic+AT+//cVj0cZOJRFLjyIWDzxE52raEf6fUVZQ1U=;
        b=eyb+wUUn735qnyT8b9SH6bonp1gHv6Hjc2ExkrrgjIx6LFDh2CNUfRR7JgV3qvIvo9
         b8nH70d4wFRyRy45lSMlXk9Jjv/JZIPhuhvhE5QdswEPj418C/vlHzvBgwmXsjLVoKAt
         PSJZ71gwRcL1ziCY2yF7ft/lcMdglJ7ZSSktcAIX2vEzyAOwUPhKj2uOaa03beGfoeqE
         b8wHmGS9Kiw41WYId5fl6EceEJ11IdWuQsTKtSuK4jw4uNBrBRVOTdZtGthLLT1coeGa
         brytJ+OHNjxO69c+yWtNizIp7mBLybcmYwp+1FzYauB8GwRbbkzS6FyfyyuTOA7l8EcM
         +ErQ==
X-Gm-Message-State: AOJu0Yz7rXqpN9thdjpg5UXJzDYlFPZTGNEkLaBa7f/squtulWXGyl2W
	T1XW9Qop+08Oz5EBMFCDTT2I4LFJlDBR4oZHIIcnavarTZG3M/oDo/ZXyg==
X-Google-Smtp-Source: AGHT+IE4EUSb0Q54nr+ylscpyjsdf9T/AVwpMTaCxRlWZGgJBcK/tPJJZhFk7ZB+5X9uk8/QX23xjg==
X-Received: by 2002:a05:620a:470b:b0:7a3:7889:4af0 with SMTP id af79cd13be357-7a6748f824bmr8297285a.28.1724180715517;
        Tue, 20 Aug 2024 12:05:15 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e555asm551681085a.79.2024.08.20.12.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 12:05:15 -0700 (PDT)
Message-ID: <3b8c7d73-3e2e-471a-8434-61322a5746fa@gmail.com>
Date: Tue, 20 Aug 2024 12:05:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
From: James Prestwood <prestwoj@gmail.com>
Subject: ath11k WCN6855 seems to have incorrect regulatory info for US DFS-FCC
 (no 6ghz)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I'm using the latest firmware for ath11k [1], WCN6855 hw2.1, and so far 
I guess we've been lucky that the regdom has always been set to 00, 
which apparently allows 6ghz. But recently we have seen the regdom get 
set to US and it then has 6ghz disabled:

phy#0 (self-managed)
country US: DFS-FCC
     (2402 - 2472 @ 40), (6, 30), (N/A)
     (5170 - 5250 @ 80), (6, 24), (N/A), AUTO-BW
     (5250 - 5330 @ 80), (6, 24), (0 ms), DFS, AUTO-BW
     (5490 - 5730 @ 160), (6, 24), (0 ms), DFS, AUTO-BW
     (5735 - 5855 @ 80), (6, 30), (N/A), AUTO-BW
     (5855 - 5925 @ 40), (6, 30), (N/A), NO-OUTDOOR, AUTO-BW

I have updated the regulatory.db from wireless-regdb.git as well, and 
updated all the firmware (including regdb.bin) to the latest available. 
According to the wireless-regdb tree, US: DFS-FCC _should_ allow 6ghz [2]:

Is there something I'm missing here?

Thanks,

James

[1] 
https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware/-/tree/main/WCN6855?ref_type=heads

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/wens/wireless-regdb.git/tree/db.txt#n1895


