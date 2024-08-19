Return-Path: <linux-wireless+bounces-11618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0AC9569DA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B92D1C224B4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720E0169382;
	Mon, 19 Aug 2024 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfbXwIZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A1167296
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068184; cv=none; b=ARPrWTTZ4fkiCQaH+KRLrZQrGeJdAKOnsnINmnvuJBG9XeAjyl7jSTxa9tFNw9J4eM3DMLnfcUICh6qNC1TZQ381iA9+E1UmskEcVxyiNHUFbyQ4tGYNpqmLbi275lZwe54uI9QlDqtAF0ga8cqhf+qVLQbTOKDsDs7mqSr5690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068184; c=relaxed/simple;
	bh=/k1Pu/xi0V25qO1/wbUmLVRkv7H6z4P/+I/Ni+5Y/n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgcx0ZVqq4brmVpMUnnAVCZIi7W2o/vev5qlfS41Hbxqe/dGdgPhm1GDgQ8VVGyP1Q2QVXLi+d+wElqjRh42TpOBsDP8NiUUSQiTgCjyafnlMylIVPZ80v7C4CZ8v/C+uUQC14CuwLTqERUcb07ytgwV7BhvnhzAwI+al5fQk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfbXwIZB; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-685cc5415e8so41505317b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724068182; x=1724672982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fkJFOFr4Pi+TqJs44xdKWi0c5WGA7D3bWDgHMSYpt4=;
        b=BfbXwIZBhC9HikonAPBvMbLAbL9XYQpI30WOsEwSKX0hKN5WpAba3TDcOIaH5Sfa9V
         mfpIA1ZObZnz8WDBg8yJk/HsbqzgXjQUZncT60NfVAcJN5yQz4wxIckoc3qdPO7ZJq4+
         PPrAn4YTJer7zifmwHRJRcDKcgWHuryftDLN9NHJKdLbuUP2PqY821aNRwUcrbNnPmcZ
         vpxuyDD5XgyfrvThs2cQhWuW2JoBL7w07+1IsxcgnYbB0hZ9ZvUYQAoG1iw/enupEX52
         a74YDzo5DgooS6lytZLAifdtFvOoRmaWoQH46omLxCAl6ucJSLM9973azedqse0c7xQR
         RTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068182; x=1724672982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fkJFOFr4Pi+TqJs44xdKWi0c5WGA7D3bWDgHMSYpt4=;
        b=JTkjg8iw4XmoheaN/bsZ2IyiYw5VzUgeHhNmH6YImBkGT5OgWm3YAbtFRzdwkwE4Qs
         9OT8q6p9AS/uIVJVX+s/dPrNDfA9k/47fL4BZfjG+exIpTPhxy8eN0/Yt6qaRnyxb3YI
         I0t2xoMalEv9Sw/bHkxHVSgqCh3PGJA/y/PvpMeF5jHIl24GjRLLvQORVsjHzI0/MXZu
         nPg72ptw+58HxI2pckRhXx73OOtivoh1oFXnuOi9MuLVCMZloK2zqHBoJ6DEQ3qB+5Gx
         RiHQFFikq/wQkpkshIfEFXy/Y5OmtTcowDco7mu3A3rAl8c3xRRTRHwdL4j02YLkOdJG
         QB3g==
X-Forwarded-Encrypted: i=1; AJvYcCXR0/tNvfldSjb1lFS369YYq7BU6jXGFuOZ47V0PyemZvUPGS7eSKhzEyCYeEWYOqnI7dFPhj0XUCfB0q7rveV3aaVjDbXZuF8MbG6gzlc=
X-Gm-Message-State: AOJu0YxK24dqAACR+7C0c+ge1BuYOOTqHgMdALY2SWIu48P7GUlm5AvH
	bofcGseY9EbZvyC+pcQs9PkWGEmOCJypOEIgRqAC+h0zxsEFeXGXad1jUg==
X-Google-Smtp-Source: AGHT+IEPF+ruZt+enu9Zc76jLGW3GhKXGX4gupbsfyR2h5pFG8ZPX6q89/VuSpV3Do5Y7u8lpghbFA==
X-Received: by 2002:a05:690c:6ac4:b0:64a:7040:2d8a with SMTP id 00721157ae682-6b1b90c5ef1mr121789817b3.23.1724068181672;
        Mon, 19 Aug 2024 04:49:41 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe3a579sm41765766d6.73.2024.08.19.04.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:49:41 -0700 (PDT)
Message-ID: <ba213369-ae0a-47ec-b5b4-31d4eeb5f404@gmail.com>
Date: Mon, 19 Aug 2024 04:49:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] wifi: ath10k: improvement on key removal failure
To: Felix Kaechele <felix@kaechele.ca>, linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org
References: <20240814164507.996303-1-prestwoj@gmail.com>
 <10435420-4f1f-4a56-aacd-41866ae7dac3@kaechele.ca>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <10435420-4f1f-4a56-aacd-41866ae7dac3@kaechele.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Felix,

On 8/16/24 5:53 PM, Felix Kaechele wrote:
> I was somewhat hoping that it could fix the issues I'm having with my 
> QCA9379 as well, but it seems that's not the case.
> Still getting
>
> [ 7660.485652] ath10k_sdio mmc1:0001:1: failed to install key for vdev 
> 0 peer 76:ac:b9:xx:xx:xx: -110
> [ 7660.485679] wlan0: failed to set key (2, ff:ff:ff:ff:ff:ff) to 
> hardware (-110)
> [ 7660.509935] wlan0: deauthenticating from 76:ac:b9:xx:xx:xx by local 
> choice (Reason: 1=UNSPECIFIED)
> [ 7661.836653] wlan0: authenticate with b2:8b:a9:xx:xx:xx (local 
> address=de:56:bb:xx:xx:xx)
> [ 7661.836685] wlan0: send auth to b2:8b:a9:xx:xx:xx (try 1/3)
> [ 7661.849449] wlan0: authenticated
> [ 7661.853884] wlan0: associate with b2:8b:a9:xx:xx:xx (try 1/3)
> [ 7661.902242] wlan0: RX AssocResp from b2:8b:a9:xx:xx:xx 
> (capab=0x1111 status=0 aid=2)
> [ 7661.913192] wlan0: associated
> [ 7662.187718] wlan0: Limiting TX power to 24 (24 - 0) dBm as 
> advertised by b2:8b:a9:xx:xx:xx
>
> once every hour.
>
> That's unfortunate.
In your case it looks like a failure on a group re-key, which makes 
sense that you would see a disconnect. Definitely unfortunate.
>
> Regards,
> Felix

