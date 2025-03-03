Return-Path: <linux-wireless+bounces-19722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BCA4CA38
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 18:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B83189CCE2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7703DF9E6;
	Mon,  3 Mar 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="HOfScUYC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0086214A8B
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023660; cv=none; b=U0xnRLsyRy1gi1p6gGSG59wxLEgytzto7oc+Qic1TfZZCQ57wFcqOB9DFV7o+/LVAr3Yl3s9m1XSI/Lbq1/UEMK1ja0fujxJplwuoeziIcTuMpvl3sjhTvKRfu5fmJD+cjG90yJ57OusWlMKYHI/lEOK9LY2VMr851QbPIyN4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023660; c=relaxed/simple;
	bh=yO/Csw21Kwq7v5toIRGaMpmx4Pd/PwSMnmP5ZLTuvrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1ZKeAvBvV8ea77ltNqQACxCToXeQ6jEFr3XE1fAck3TR7Ex3b2OsPMzMpJAYX/H15ifAQVhQA5yHR84xhGRnu+FaqiVMydwHPsU0YPbdoA3rb7q8NYbLuUCyziG8ILFcJMiuGRWfgnb3qWhnmGmsbWVRUYEy7W1i7ke8uDMjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=HOfScUYC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bc38bb6baso7343055e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 09:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1741023655; x=1741628455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDR3lMogJrf4PYr/+w+695QkINLYBS4lEPuSB4vRXe0=;
        b=HOfScUYCvAu+cu0mjbMIZdDiAU0takoxy7ZSP8vQSAkgGHaRpPMUyBpCxarXSCKAZj
         OM31psdV6JV2cUioOcJ81vnRs8yrebBQf+Oqh2Ydi67UDv9paNubmXqBlBPHBvY0KGoo
         zxn7ud2PbB7E3cxTVUK+OSBdsxW2O4BC6Y9jmhnb9daNNBn+qcMj6FplFtP/UCaUJJ6u
         H30wlOFwX9iLm6zXPFDy91uNzhP7fCxt7ZNFBnnujHGZmYUd0kAuC/CisrZYusIpyyFb
         JwKeR6V0Vjx49uCM2ZHPQGxrM4Ue2LggeyQdUfsuGinone+hOlL8UKKp+PjxDZ4wqQ3B
         JoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023655; x=1741628455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDR3lMogJrf4PYr/+w+695QkINLYBS4lEPuSB4vRXe0=;
        b=HDwf2GYUAHi6TmFawQ23QjTXAnt0mZm0e3nSInbonfF4rD3KMAZv+haxoTsTUtW2Cf
         azSsEMgIRPNZ5OJ1NWgrPUNqpvlc6QQ4GZRAql++UndTJpY75P0lmQCc8aKlvOjfDjT6
         kTgFqBmUGQcNaQb/2lxIWgArM2y3vrZN/lJIZzMCn6Yvh9HNG12hSnRWGQz71QTW2Akq
         u8MQ3qqSDdL2bONGZIjRBVYrCDwUpc30KV9WV5fHRlLyIs5zXRopA2e8GiG9uqeUaV8j
         d9zEGRgvQeTldmWcXa8OlWXf3d074V6JAQWhmnHaCX7dEBgzLtAVL7k2N49/RYaMuIeT
         5Dog==
X-Gm-Message-State: AOJu0Yw4MeG6WP5447btI/tLrddv8DjyAgXx+qvwT+adXxxI56V9tfnY
	Z/85WqN4XpZUYjNR8+tSCW9IUzZFBI57Ffh1uhih3WDwaKtXCoeoZVvqe0X7PdocmCyugJNHn/p
	5
X-Gm-Gg: ASbGncsPosY0ep7SAYmXn79VVoczM8vESq8P8Y3EQ550o8uaDIRB7wHFs7eU//uFzuN
	8QKsItnHkYDlwkFJhFh0xqvU3quprAxBgEukBI7MX7PBXc0Q6OuilKaonDefWRaIoa0kISc7gdg
	mqMQW8iF/W6Je+hJIGRoAXPK9AjquHPsL8IJUgZ8assgZNGN0BQi3v4i9pqSjAaLg+WRr8cSBV2
	dO9npjuhgzo82zI4NXuBO//GKgul+Dy9jOgp6PIJm8t82RBrmx0NSxZtmNFIk3IM3BzCqtZhUPl
	+heQMkvwrP2Eg8CEzOk7mGu1gNUOJzWWC1C0/DfNERZm21NAT7dKynb7xcOhFL6EY6iif3m5CWK
	2
X-Google-Smtp-Source: AGHT+IEZXHnZUKv5riFkdBr7jaB8F76tJvfsoUYGS8tiMEZJGRySZjWIQgn8kN2pM+LM59W6HlPGwQ==
X-Received: by 2002:a05:600c:4f14:b0:43b:c034:57b1 with SMTP id 5b1f17b1804b1-43bc0345ceamr36558365e9.20.1741023654700;
        Mon, 03 Mar 2025 09:40:54 -0800 (PST)
Received: from [192.168.108.121] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703f83sm169369395e9.13.2025.03.03.09.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 09:40:54 -0800 (PST)
Message-ID: <e9b79e01-5204-4a29-ba5c-669c5908b1fd@freebox.fr>
Date: Mon, 3 Mar 2025 18:40:54 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ieee80211: fix interopt issue with MT7927 chipset
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20250120114551.1542812-1-pmartin-gomez@freebox.fr>
 <17a9044d-4bab-40df-a119-8c43ebd60bc2@freebox.fr>
 <e3b99a7bbba8b22b3ce091ad79a271c85dc261de.camel@sipsolutions.net>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <e3b99a7bbba8b22b3ce091ad79a271c85dc261de.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2025 15:33, Johannes Berg wrote:
> On Mon, 2025-02-10 at 10:48 +0100, Pablo MARTIN-GOMEZ wrote:
>> On 20/01/2025 12:45, Pablo Martin-Gomez wrote:
>> [...]
> Took me some time to look into this, but I don't think the band needs to
> be unknown. I'd still split this and use the existing version for
> *local* data, such as callers in net/wireless/nl80211.c, and have the
> band used for parsing in net/mac80211/parse.c. We already pass e.g.
> "from_ap" in the parsing context, so we can have the band too. Most
> callers aren't even affected since they don't need to parse this, it'd
> only be those in net/mac80211/mlme.c, and we can default to
> NUM_NL80211_BANDS (unknown) for ieee802_11_parse_elems_crc().
>
> Want to take a stab at that?
I'm very new at any sort of kernel development, but I'm ready to try to 
figure it out given that you pre-chewed some of the work. I'll come back 
before the end of the month either with a RFC patch or a white flag.

Pablo MG


