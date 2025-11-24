Return-Path: <linux-wireless+bounces-29283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06497C80901
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A7384E8B5B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1E2F83A3;
	Mon, 24 Nov 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="LyAvBneD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA03002DA
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988247; cv=none; b=q2nxD3See6T3zHTWUApqvUxVlpo9rzAZC4QbEJJlgvaUH9HPU4s6hfkFS6eeRAYQBGS61o/eY8ldJE3RljYnCVZbXmlIf+kj+EOFJbUagl3cCEi+e+/ucRVnZeZVYZLa33BuXltgdcLoVDsJBzpTCNWHxmvi2hYVf3h5ikHvPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988247; c=relaxed/simple;
	bh=O+N33EBMr9229HiVXqDyCp/rbF9mZ0cpR4Cc6sAIPGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svXI3iDrJ0XlH04LhoUykJ4mGyLGxsOoCaqTMiPvx3qsZMGrVGu4QGqfbplVwOLvdRRT8QXBqGJJGVoqrZ7Yo61AD+gHr12MMviGfjWq81suG2RQVnry1oNDqZIsLYHGESQ0+JmsDBxi6dh++7Ket/+tltc5Vz4qUsEZED+gtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=LyAvBneD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so23897085e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 04:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1763988241; x=1764593041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4N6iZeD7hTxR9PG426S9ta9/ssVDxn49716PMFXgkEA=;
        b=LyAvBneD7OcNiFBST6O6vJ8ADCCpgkO0Bksnz+s/oOBg2ztARPOPq4AwLfDhwhuOwM
         ICMDeDTa2K9d+pSGN3a7QtNeQidpzY2eLXuaO0RXNE6gMAoOS96EMuDwXj5/toq0Qscy
         p0KZxJmZO+e6DCzPJh0laHN1j8AN+WVZXjd01N2fYQlttvBtgLk9NfPNH25280TDnhch
         7VGtbxZK6OvuelYBJTJu6oyA29pAoAnY0kDlUgJYWjxjodgAbL/KwpELfD0bbgsL/Qgf
         mV00vd76wJuhYerHU9jQywb/ARuy31ey0FRbJoxd0jSwGwxNVWDG/wPZPy0ibRkjBRCr
         hHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763988241; x=1764593041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4N6iZeD7hTxR9PG426S9ta9/ssVDxn49716PMFXgkEA=;
        b=SNnMa57VqJbXvBqYIHn4M2+gLCahqAhWTVcchyzVqzrHVvdIK4i+YPxXgQUDI3IPe8
         85V2JdiGycQivXkpV/jyJj3xqRceaQwGhb84em7a0ikEUZmJ5KGgygWHBe6JVQrsxJ1N
         l9j0j0C5qxXRLt5pR1wdyGKGgMELh6CmtjY95uDmzhSE7gUuVTkYoTZjKeLpfUbRMbI+
         WC/vKXqJfjkSYkjwIxldj3O+CWjEDT1VqQtJl4vvw0jm+apcNE7Gz1/2izoIywlz0ktE
         2SfAD6X0uin2yiMeBLXnST9uYw2Wed6rCmFqR3Qg/yXAup0Xa+hLkOvxeCETm7jnThhP
         XYdQ==
X-Gm-Message-State: AOJu0YwXW3uJp01phaDLmK0G899KJCXBlTurJKHtIrWI4RWeLE4sA+Nz
	UT3WTe2I1ETXqG55jKvfScfXdqSkL/XM2sAC2/PN0YhIUG8YRRXuWwkmTj4w1mbrdqU=
X-Gm-Gg: ASbGncsalFo0zBEcf2lApKHgZmNf1ubw9HtygZI8bv+ZHVBDYPuoDcECUHna0hODlb8
	K8/cF57RVV+Vc+mRPY2RSQimNW4bUVusfyzb72IhtR6vhnxiueEfsLAN2fU6QmJvfk/WrAjjfBZ
	gBtKJ2vjRmywy/2B6ljnEULH8cXpC0sufBUghFYVtqfmQqa9ulW7Jz5XoaZudJvmWAcoZxjtWWd
	N82ZRti+UavDWkZKOJOZ8znL4MLTJ87tL25qkFLL+Tg0J5ZeKtoQZE6vN7tIAIXjUUw6OF04dPt
	8SozjtHgASjoa2r/rM/mHyp8HS8wVMDifReWRRIwU/i9CaW4X2LMjqIUL6u31XumA76plMXqbiA
	llG5f784rfdRZmTg/wC8joMKXLXBppZp6dqXCbUR2+zHdEIjHgUuXLkxALIoQoCkPTMdfFyFC/t
	9JiCuhuEnOPGwOYqzbXNE2r2aOnyNbVnA6NJ3mdMGR
X-Google-Smtp-Source: AGHT+IFyfreXQOgHxa3WMCrNpGzhI8kaEUsSR2TQ59GZbuUH6ImNvqPWKQjCLds/cze9Pt1SgdgvSw==
X-Received: by 2002:a05:600c:1381:b0:477:994b:dbb8 with SMTP id 5b1f17b1804b1-477c016e7d5mr116914655e9.11.1763988241061;
        Mon, 24 Nov 2025 04:44:01 -0800 (PST)
Received: from [192.168.108.91] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf22dfcesm196854275e9.13.2025.11.24.04.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 04:44:00 -0800 (PST)
Message-ID: <bc5a35f8-171c-4558-95f9-142e2344b02e@freebox.fr>
Date: Mon, 24 Nov 2025 13:44:00 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: mac80211: correct FILS status codes
To: Johannes Berg <johannes@sipsolutions.net>,
 Ria Thomas <ria.thomas@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com,
 pradeep.reddy@morsemicro.com, simon@morsemicro.com
References: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
 <8600724587814a992d649ce8feb72c4a3d20c8c0.camel@sipsolutions.net>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <8600724587814a992d649ce8feb72c4a3d20c8c0.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2025 12:58, Johannes Berg wrote:
> On Mon, 2025-11-24 at 11:41 +0530, Ria Thomas wrote:
>> The FILS status codes are set to 108/109, but the IEEE 802.11-2020
>> spec defines them as 112/113. Update the enum so it matches the
>> specification and keeps mac80211 consistent with standard values.
>>
>> Fixes: a3caf7440ded ("wifi: mac80211: add corrected FILS status codes")
> What?
>
> johannes
>
The SHA is correct, but the commit message should be "cfg80211: Add 
support for FILS shared key authentication offload"

Pablo MG


