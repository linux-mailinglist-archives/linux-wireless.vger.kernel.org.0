Return-Path: <linux-wireless+bounces-5480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA03890734
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 18:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ECA4B23ADD
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A888004F;
	Thu, 28 Mar 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL47y5wl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B67EF00
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647032; cv=none; b=gFMPVL3RJ3iE51JoFtf1l+L0lGaFEPQaPR34X9HQo4KYkfz1Q1mUNOWkyKitJxAxxVQ64oTS5/D3zqSSt3FAHHdLPp2RGbNbLV54VJX08dJf6lDy/QIFlvnKbPjDjuCY8utamrS29+GWsFJMjVlUNClVTberek4m6pjT7gkhHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647032; c=relaxed/simple;
	bh=FT0x0ahMc6hYytVWkABLg1QurNLvt8BLJtRllKqEyJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J3xcA+Eixk5DwVJxjbXKJtn9dMWzVeLoKVy/ETNuLMbvfQpxrRxOgW9dcUgpbE1Wom3BmNjPnGNFB1CQVW9+38iZNXwyRPBAoODGKOdRmyFqQ8/pQl1Cwp2qy4amkseGzs+GjDEQWOZ4CvLx3kxFVgMykJ5wBcZRiNZMiJ7jMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL47y5wl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4317fbb669cso6951441cf.2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711647030; x=1712251830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jq4doMyKqkHlVSsevcF1dh92Xq/jgl5mE1PkvRljp5A=;
        b=fL47y5wlntmJ6mr+Uokb+Mln1qb5aNG6tRL5CTNNQrEcC9SuBssEVRbs4BjzCkHlKs
         WRnRYBfykaEKbQcRLc0DhVyDjUU0AgkOOrum0O4dDLypDsgMRC1f6ODaoureKssEcp/y
         ruzGR5igzZZEXRiF9HDHRpqndgmlGlqMr+YDrBr2nikns+BuFrvBWmR6KsSQqazN4DId
         dnYZi8XoybZjmpYydw+xUiDvwFLAtDhrGyFI/hx/VbbQjtSmHXE09MkF3/WREF2t3HZ9
         Kh6a1F9S1npTXio/oTGaKYJwrtRV0BjOkRVD9ewA7YmeC65u80P1WjEcIoAXR6ywl3gO
         bV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647030; x=1712251830;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq4doMyKqkHlVSsevcF1dh92Xq/jgl5mE1PkvRljp5A=;
        b=HLimjpsJIv77yNzkkoWsETT8m9U3S8IboITCA1olSLvTsu8Mfcwv6UL3RkUfxnQKtf
         DwO53TFQpnAZkY88LjLeizeLmajewpUr0In/v4+jN+i6pmhC7Fi1wYn+OYMzTlq/RvWw
         5T3Uh5X3T0MSSexS+lYlKI09QmG4fL/VrZiY1FEmk1D/8S2PZHZIlsDC/b6oBgEhB605
         kaaESuedCU67R4LWlh3YXE4cLxmn7N9yf9/koSFntW/XL3yQZX3XX3HEPlnNKZ5dToGs
         o08+MaqBohGEhEuV56H2gFHmryUt0oQvNMNqTIDyJc+vM59Nn/8I+VFqHQ5uckPWcgGg
         Qd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUbWlskagAB7fEGqt4H1cO4tejx3YY/Q26ZnnfzQqFwP7W4qGdC8IWlIzW7rKxLKrvYifafTVJ2VC1TzIf8JW11xD2s+i5g0xY1QfP8YM=
X-Gm-Message-State: AOJu0YwT8JwuKPuiyQ840Dh1/CTUeqL/2OHNK+kGgOgCNKDbb6JwtM/m
	xdrC5q/rlhlfaoJAjut2yX6f9fi38jrmKzMsTCAt9zfaXZ4/P3HBTPTy5cDm
X-Google-Smtp-Source: AGHT+IGrV8HQ5nkc7Da4WwS4Ve8GMDr8Ux4vaoH4e9dSqXqjLtxlYSQE3lepxl8hjUhSc/HMGf2NrQ==
X-Received: by 2002:a0c:e444:0:b0:698:e89b:6982 with SMTP id d4-20020a0ce444000000b00698e89b6982mr895246qvm.28.1711647029688;
        Thu, 28 Mar 2024 10:30:29 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id r1-20020a0562140c4100b0069183a8de64sm808032qvj.75.2024.03.28.10.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:30:29 -0700 (PDT)
Message-ID: <b650863e-10cb-4fa0-8718-bbb349415674@gmail.com>
Date: Thu, 28 Mar 2024 10:30:22 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No way to cancel SAE after CMD_AUTHENTICATE?
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
References: <055b857a-83f0-4abb-b6ff-f0eaaf572e64@gmail.com>
 <968024261cf1d4e72832451e1c4cc64922d05364.camel@sipsolutions.net>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <968024261cf1d4e72832451e1c4cc64922d05364.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 3/28/24 9:05 AM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 08:23 -0700, James Prestwood wrote:
>> Hi,
>>
>> I noticed some odd behavior where userspace is unable to cancel an SAE
>> connection until associated. If you issue a CMD_AUTHENTICATE then
>> immediately (or prior to association) send a CMD_DISCONNECT the kernel
>> will not cancel the authentication and afaict ignore the CMD_DISCONNECT.
>> The kernel will continue to send authenticate events, and even retry
>> authentication until the retry limit after CMD_DISCONNECT is issued.
>>
>> I see the checks in cfg80211_disconnect which seem to back up this
>> behavior where its essentially ignored if not "connected". I'm not sure
>> where to actually fix this since the auth retries are internal to
>> mac80211. Since the device isn't even authenticated I'm unsure what
>> value/structure to even check in order to detect this situation and
>> clean up. But there needs to be some way to cancel the authentication,
>> right?
> NL80211_CMD_DEAUTHENTICATE should do that? I'm not really surprised you
> cannot disconnet when you're not even connected yet, for the most part
> the kernel doesn't care about tracking auth state (any more, for many
> years now).

Your right, I did try that so I thought but I must have screwed up the 
test. Swapping the CMD_DISCONNECT call with CMD_DEAUTHENTICATE does stop 
the retry attempts, and in turn get an expected deauth event. Sorry for 
the noise.

Thanks,

James

>
> johannes

