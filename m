Return-Path: <linux-wireless+bounces-34524-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB6aNshm1mnIEwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34524-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 16:31:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7F3BDAE8
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 16:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F245530479CA
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A62D9787;
	Wed,  8 Apr 2026 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbCSEa8W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31473B19A8
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658405; cv=none; b=XX+McdfU4jWRkmfStr1jGK/KojvYAACtr+ZnL3Lcc4ngtxywxz1oYowLztzOhlJB/1qvkygRL7Uax5bbSefpghbfvbrSIDQqNZWxP4vybyglGTjgZvHSq25mDWWipSkRUDXw9DRgXzT7S4DYK4uS1CI7z9DME12SJmVYNY2kne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658405; c=relaxed/simple;
	bh=yZiSiWEzKNqdM0bnG/O0sLcUaN3PynC7Ok6cKY6wawY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORjsgOrJpipzb9u1ivgIXuPTWFwh7qDPC0FJtivO5cpqu57+OTzrKniaGt+fezolyvZpOa/N2ypvtOYTu4x0NG4CiRQqy7RZZaU4dbCsvNsbHIaDy692cUdrl/JMVEKGDPnbVRFDpcNZpd//btgBsEsg9aPfMOwgFYez6qNydAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbCSEa8W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887eca00c4so42746755e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775658402; x=1776263202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFIOx+MT1j+MxRcVxecY+31uacH+vOq2WOxsC6sgJJQ=;
        b=qbCSEa8WxDEJQwdH6PIWObZECee6Rum7+qSj9AwgxTe+pd+3QwdEfqX55+zYYhodWf
         q3Tv8mgIPzrOcSqodPWvRqqmD+3+bnvs1YpwgnIQy2V/T6J45o/Bi4Er3L9SUp4KXYtt
         E8N5hftch4RWfm6XvDAZaR69flzvTky+4kAo6SUSi7TCdxIHBkjlc48vdZH53lx9L8ms
         ohGg3UrDzqHrRkGjoF5WN1n71R1qouJBftDhguenNOtRwjfBM+KcBmsavLoMcBMMjD9U
         gpOyg1P490yvCHlFrxPrAT+bh0XLadNY5BEdtOhJSOTBPCuOMECTBjCe17JYth96NXo6
         noig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658402; x=1776263202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFIOx+MT1j+MxRcVxecY+31uacH+vOq2WOxsC6sgJJQ=;
        b=DfrnF/QNGNqVdMhM7/xDONGskNEJIsmh5CxmL+vD+ry1JjSeI+x2WdB82leU2h38RS
         7p3uMnlApfnXafgQlsACO1EMaVOF4w2alMrau6LuTGsNNN+zrV6Ypb2FNg0PISMu0nnN
         mkphepHzQe3UKqcWEnIN+S89jvMQoIo1QTrk837dr6hV7GGNyR++Dsm+bB3O/hkivt+n
         jdhJGYxxbzYE+uMwTd/mrB5XXkH8znRYyFB4nRa4Zy3GaN6qfr+L3UpTLPsP6Ym3+qVU
         Iz7D5LuSe+BY0WKrTJVZmoisDI1IYn81OiJKnJW8kkS9CCwc+FOjLHqQZImFQgpCG7Vt
         MCGQ==
X-Gm-Message-State: AOJu0YwlAr+ZUT103Vl4W/y1cnSQHC1XVvq23oH/avMsvdCsxnmNqZLm
	fvcTdjo5zyDovKOWiyX3w9GvhCvn1BIJS2enjGZRVc0wS2UWQmojZtpa
X-Gm-Gg: AeBDietx2YcK/nb5dW5c9TQ5lK7JQlQXKE4xwg/IR0LxFyBUtt3w/36dnWfn/Opa4S4
	6pI3oEn1Io0KLPWd+0vPmEXOeuZmKXJIFg8+4TFmj9RrbL3Etw9M1gp4pUa12RzwGF3/y3hk/Mu
	60NcDkZzUTXLQT55/u0rgGz9m/R5HBAzcOJwTN/8OE15BzHz9hGUbevibqPUejvHBRtply7Da27
	3HpHaWgfBZMg9C6bRW+7TAzXNxznpEGIU0Xj8u7bDqqjcdGy52bE80fmPN97MJR3BcUIqkE1/tF
	QmQ54Xh99I3TSG8fQUv+oCzFQ9Th5JjHm10Bxxljlq+iW4B72jfTswfUwCkPjkwUcQ+KzExzwxf
	ccvGxAERf/pg6kswAIezEqTfqQNOlv8auXkHChUecLRSwuSlAq4I9/Yj/lERXFdyH6zcFpeAHqv
	Lnlm9odbUpgL6Yplo9845oTvT8sU7gqA==
X-Received: by 2002:a05:600c:1f96:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48899753e5fmr296983695e9.9.1775658402212;
        Wed, 08 Apr 2026 07:26:42 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a72baa8sm502051215e9.15.2026.04.08.07.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 07:26:41 -0700 (PDT)
Message-ID: <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
Date: Wed, 8 Apr 2026 17:26:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>, LB F <goainwo@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com>
 <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
 <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
 <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
 <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com>
 <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com>
 <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <5fb2f699626b483b8a0a537960b274f0@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34524-lists,linux-wireless=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40C7F3BDAE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 31/03/2026 03:32, Ping-Ke Shih wrote:
> 
> LB F <goainwo@gmail.com> wrote:
>>
>> Could you advise on how to investigate this further? For example:
>>
>>   - Is there a debug flag or register dump we could capture right
>>     before the first corrupted frame in a burst?
>>   - Would it help to log C2H (chip-to-host) traffic around the
>>     time of these events?
> 
> I have never heard about this symptom from internal, so no clear
> idea for that. Sorry.
> 
>>
>> I am ready to run any specific tests you need. In the meantime,
>> I agree that filtering by DRV_INFO_SIZE is the right practical
>> solution, and I'm waiting for your official patch to test locally.
> 
> As malformed frames happen randomly, more validations like
> DRV_INFO_SIZE are needed. I think Bitterblue is working on the
> test patch. :)
> 
> Ping-Ke
> 

Yes, I am preparing a patch now.

