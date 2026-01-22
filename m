Return-Path: <linux-wireless+bounces-31056-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCBlOjDecWk+MgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31056-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 09:22:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C348362FAC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 09:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8E3F569667
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17497481AB6;
	Thu, 22 Jan 2026 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjL7goHX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35230F7F2
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069696; cv=none; b=rqLILDSyN47qsLUSoegjT7fh6hPBm9Sjwz9dINpCdUaOOk+KJk4LEjtFDdeWJytW9pNIT5Pv9jZa0rc6AexqPLAGyp/q48I1lGxiEkaHX6arfwqzizQS0A+p4/yytskDvLZmTub42vOVkYWbyPBBvDcvX/Tosd+j6wOo3jTpzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069696; c=relaxed/simple;
	bh=6c9uxmBAZvLojJXj9qaALIUJxWtTB0RvappVQkzTN3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNGcXkICcpxONPCiu5i5hQsVs888FkmTDMzL1QndMLQE0EcGsGWMxVzacaT+yBaAmueFrzt2gAnnRjphxZP6KOB1YBOhb+HXOE34v6XuKF9dhS9DC/0JpTj26kfAfxAZEMyx74mVnOQAdhXov7ykfWGP8Xm+a9222IK13Jxxv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjL7goHX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48049955f7fso2844955e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 00:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769069693; x=1769674493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DAOhd4x7MHmbdXf4lk6gDlWzu2IBzRt0vhQbJQeAjnY=;
        b=QjL7goHXGwHwSjyqzGGQwEnJ+UZgOO12JLjm4mrjMikseQXMiN8ORI+LMgIRU7LUV9
         QerVZsbjFn2cMKAWQJdDbved4WQlTyuPoNxH8j6843eFRrAH1ohHrDRsLFTQg/LmkyZV
         DdWKl7YN+WDH5Ss1yEJ+xpVr3NkgIqGBqisBDbqe8Ayt0GmaWn52UlVA00mlWhtDZN00
         Dwx89KiKau5t9VFupA17eOUZbgNqxSNdTg4ke4q6/OPT8ZQelnSjzKE5LG0SYehtQiEi
         0QCtbW2Qm3YcRGGgESqebc1CVM5wbX5ve5koc6pKa7UM8LOaR+etTe0jbJPgtGPMNrg5
         aFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769069693; x=1769674493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAOhd4x7MHmbdXf4lk6gDlWzu2IBzRt0vhQbJQeAjnY=;
        b=RYu+3eZGXMjb5ij4tJ9nXCCLrbE4SGqhDyXzR+HZjsCLQfCvUXfpblzP23UeJl9h4B
         sJTsAt/9/k7Cxo8fE314R4YAv6E9PnIGHNYKYedtdcdq6IJfkgwpWny+MrkH90IT8huB
         UNlO5Jcypg4GLKOQE1H/ZH86GjR8Ou7QOuUW0Lgh7gvJTDOW/z+gUBq3Gwld45Wg4ASB
         8n2IlaIANuFMOPufRa23OICvqaItITjIUq0uOGprlo0y0aHZgnWNb8Yl9lEHGet55K41
         jVAc/A6gNjjVEE4H8D/zAl9U5QZTorjyEVloO2u015ZYsEImLmEfAaMAOCSukOF3HxwD
         Lmxg==
X-Forwarded-Encrypted: i=1; AJvYcCU1haPINcSRhG2sabjSsWHauw+7nV4pnLVRdu5dkjSjRCKq4ynWELq9OoS4UZQULJUxE1u+7OGLo15mTqCLTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzU3r3u0NiThh5sdnXpMf5ypaH22zAi61gyYCq10XKM/Xzpw5O
	ne9ZH1/ERcg9LT9f709u1BolFpIcycd45SzTM/X5EXphod6bm2kqOvq9
X-Gm-Gg: AZuq6aL2pwXSXSc2aJmkQ0xHse7MDAqHzUhu31/g7+Vy/rSm4e82q8u/5aKkDgtCdCo
	+oTsESGumE7XzSnkdOhg9z6VPV+os5glVh/DM2McLk6n3kjomfwXNX4efPMbXojY/dsATyZaVu6
	XiGFYtUZV6fMNvvYqsEJdIAFa61YeILuKuoguZWDujDTaua70w4Gpu5DBUtrnzS0ReO7zmQU6b/
	71BWG8IX61YsnMRFg286ZwWvyzh+b9VtgeBzXaAQOevLHOvi37eLdgl/b62Fv5rPZLRUEWgRzPd
	trdFgsu8Z8xgqR8IF4fPB8l4OWiC4ProfshDXdBOBgMnGd1nMKnV7bsNH/D1FSbCtq9a8yBTeSH
	v6Iq5MMZ/9K4kitL+L2wmTTqLyPCAsVF8E7/iXuAQACJk9JsPgCwHMxQpTRNIAgpUxsvAGPhtS3
	lX2+6cB92hC9L/M5J/iRMc/hSzmdlwa8+HhNUqRgrhFAczEcSjffZu2jpLUWfDguas2DV9awybL
	95QFTd/MomBqkkPcbI=
X-Received: by 2002:a05:600c:1914:b0:47e:e72b:1fce with SMTP id 5b1f17b1804b1-4801e35868emr266298495e9.37.1769069693255;
        Thu, 22 Jan 2026 00:14:53 -0800 (PST)
Received: from shift.daheim (p200300d5ff09750050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff09:7500:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c57504sm45212485e9.16.2026.01.22.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 00:14:52 -0800 (PST)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1vippJ-00000000mAt-4BD7;
	Thu, 22 Jan 2026 09:14:51 +0100
Message-ID: <819fc850-98b4-4a0c-af4d-da2cf41cfcbd@gmail.com>
Date: Thu, 22 Jan 2026 09:14:50 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: p54: Fix memory leak in p54_beacon_update()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: jianhao.xu@seu.edu.cn, johannes.berg@intel.com,
 johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, quic_rdevanat@quicinc.com
References: <71ec168e-423b-4269-88b9-56e08c1d8110@gmail.com>
 <20260121090507.3442567-1-zilin@seu.edu.cn>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260121090507.3442567-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31056-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: C348362FAC
X-Rspamd-Action: no action

Hi Zilin,

On 1/21/26 10:05 AM, Zilin Guan wrote:
> On Tue, Jan 20, 2026 at 09:25:15PM +0100, Christian Lamparter wrote:
>> Ok, from what I remember, this return basically is/was and likely will be a dead-code path.
>> So adding something there is only there to "look" good for the static analysis tools.
>> But many commits like these have been merged before. As long as it is mentioned that
>> static analysis was the reason for this. Yeah sure why not.
>>
>>
>> Reason being why this is dead-code is that in order for the path to trigger, mac80211's
>> ieee80211_beacon_get must have prepared an invalid beacon (with an invalid TIM Element)
>> to start with... And looking at ieee80211_beacon_add_tim_pvb, it still looks to me like
>> the IE length can't be less than 3 ever. But, I've been wrong before, if you do see please
>> correct me. (If not, you don't neet to really bother with the Fixes-Tag)
> 
> I agree with your analysis. I checked the code and confirmed that mac80211
> guarantees a minimum TIM length of 4 bytes for non-S1G devices.
> 
> I appreciate you accepting this patch to silence the static analysis warning.

Phew, and so far no buildbot replied with comments.

I have one last request: Can you please add a sentence about that analysis into the commit log as well?
Our future selves could maybe appreciate that one day, if this comes up again. Because then we won't have
to remember all or search/look for it again, if it's already neatly written down directly there.

Thank you,
Christian

