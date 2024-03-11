Return-Path: <linux-wireless+bounces-4558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A47878008
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 13:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079DF1F210EB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 12:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6D8460;
	Mon, 11 Mar 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIvkJoHv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245E22075
	for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160344; cv=none; b=d56LmzT1UEXsKyvAYHEvvE2+/mW5pOgm1A1X8B3wSiPkWdYCgpfoaId3w3eKeyKPYN9MhtzTMh35cilGy3BxDDRVpISoFUT7UxStGYNeVh8Vipl8Y5UBj07Izl3b0EeSjGNd/wnEaeESa5WtiGjTc/fpYzGOJs86+YmQBZ8SfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160344; c=relaxed/simple;
	bh=vz4OWnKV+wG8V0TUgdYoyb+MpScvALIp8Gjv8Qh36sE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=L4mzn/QZ2V2bkqSum6O7e1IcfiwaV+PsSMWGB1UJ0uwHmuSFPYO989Fo8bSE08sRIs6z+91XXrxZq5GmBf/aY6U17rUP0nBL/EqMp0Fj8lf693KzoVRs2zXNJdm3P0GfvqXekEqvZ1ll/402/O98r6Ivmqoh4d2Szaha5ulmCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIvkJoHv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7882dd2b1c9so326522785a.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 Mar 2024 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710160341; x=1710765141; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFVDgUNk2W+iqDUx7eCGMs7iHsOijEwcGaYgYxw2ycw=;
        b=iIvkJoHv652Kja/Ge8mTEyp0d8nYiHRHZW9uic/hsc5fssKZYZ+UEFrxnkaa7+1jol
         PLQxxBUYheDBvgY6TW1bnZgDq3iewyx8Ujt0kUWoxI4zbs7B+JSn8/SmpURhnNe+OTMq
         /vivt4I7P45+sssg0M4YBm+FBuCbV8XquMnH4+rUxZR49xd38eHGBXziEwL6ToJ3qouM
         A7m5JCkZp/A3gHgp/jvLyPmGLZ5xKKZGHKvpE5LOrfWse6OhuFOa9TUlIGuQy5nUY7/o
         7tDvFxfMIrB/1nHna4sT3c25RP1i7NIA5bP3ukO6Hw+uKnvGMT8efmISUiPj7sRWVKQy
         fspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710160341; x=1710765141;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EFVDgUNk2W+iqDUx7eCGMs7iHsOijEwcGaYgYxw2ycw=;
        b=gCqV0neHypeoBluBI7cLz8QVSA1HMlg6i2OmGxy3XoU2A+NIQ1b4tPmBRfKOPf2YFf
         A/bq0wCkR6mXGTEcWZaObdLRj/eQXQGrGPJYlR48bcX0UUSPdHPh/N4cYQdg5kY3idIj
         dJl3CJZqxi/YkBZZdoZ05vWtMVqf4LGioVj3Q7Neni8S0F/hHJ5XyGywA8k3byUFwvfa
         2kCebUv5uSPnXWfpLaNe7xFwN8qxVXZj20VNUpYMOEynIbCENdIFMZf5PYAR42gw+oys
         oAuQRjByZkGfyJbSYBQwNyia6QjSDmZqPwMgooPgpq3MDxjZiqxd4/8wPcZ+cC5U/iO7
         Uyqw==
X-Gm-Message-State: AOJu0YxxodbPVf5US40U1kuqQGHqAKbcVTVkF+4RltPr3IH9+NYXJEo1
	r754e9e/xKgcPp40Y6uD4m8CLs88Ysrd1DEEe7IubmjivjV+gWVXAxIdUayR
X-Google-Smtp-Source: AGHT+IGRRRJBJfHEL2gqcSWe6pnIW0FnRBy7hwKUOzTTBBOLB6WiY94EhxmI7Sq7WQl1rciUFBdOFg==
X-Received: by 2002:a05:620a:470a:b0:788:5d76:1bae with SMTP id bs10-20020a05620a470a00b007885d761baemr9724914qkb.6.1710160341467;
        Mon, 11 Mar 2024 05:32:21 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id n21-20020a05620a295500b0078870f11abasm644087qkp.81.2024.03.11.05.32.20
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 05:32:20 -0700 (PDT)
Message-ID: <e7535e82-10dc-4068-960b-bfe7c6b14aee@gmail.com>
Date: Mon, 11 Mar 2024 05:32:18 -0700
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
From: James Prestwood <prestwoj@gmail.com>
Subject: iw hex escapes SSID, but not other fields
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

It was reported to me that some of our tooling (which parses iw output) 
fails due to a network using a WPS device name with non utf-8 
characters. I see that for SSID fields there is specific handling for 
escaping non utf8 bytes, but not for the WPS Device Name (nor any other 
fields AFAICT).

Before you rip me a new one for using iw output like this I have since 
removed this and now use IWD's DBus API :) But older versions of the 
software do still parse iw output. Just wanted to report this since iw 
does print to stdout, so it does seem like it should try and escape 
those bytes when possible, like it does for SSIDs.

Side note, I see the JSON patches are progressing which is probably 
going to be the proper way to use iw as an automated tool going forward. 
I haven't looked at those in detail (maybe its already taken care of), 
but the above issue will likely need to be handled since JSON requires 
utf-8.

Thanks,

James


