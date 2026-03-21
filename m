Return-Path: <linux-wireless+bounces-33645-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e2+2BijqvmnzjQMAu9opvQ
	(envelope-from <linux-wireless+bounces-33645-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 19:57:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F11AB2E6E03
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 19:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9AE5300516D
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7B2DA775;
	Sat, 21 Mar 2026 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBfmAuDN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE776282F1E
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119458; cv=none; b=RQcDwVoXwRrNcLzTvelbl6vAcuW4n/W/qE/i8zUaL309axIwxOej0EbXh7+UP+W2abrYUveYfRneTHR8hM9UWU9ueUYJJTxO+lQuYkPBONKjwCbYMvwyLHwseg93WytojGFH1AqCmFQ+gLbWhhSkhcBokoiGptsVQo7R9plmcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119458; c=relaxed/simple;
	bh=4IjaJGZ74W5N+aGzArj4f1P+qZ9ZxyVpDIaBh6/xHa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlUh22dVgEVGNnqL4ADwT93CzdNbHZ8Ng29JfnDgxwEvJ5SFxlPAYWAGxZNHIOfuoHcp8BGiIyVLLOm5gwe5NJqGurJ75cfF1WD4GXOUKjSP9rkWsjjgmo8NBk1O/lFLajFmcS8jMyuxOk8V27weoRGFX24Pr2EqSI6/e1tpCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBfmAuDN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so23221285e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774119455; x=1774724255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KWPwJB6KN5IAOch8pp6QvEDjBdKNk6rUSq6diDMBwQ=;
        b=QBfmAuDNxxn+ipQ85BPnqlaflXtVPhYQLEfXjzIQXdsxDp8awh86Uaa6m2/O0WDde9
         tesFp9iuCGR/Iw+BIWK+HUhr+tHyBneC6L8HjzM4O1fHErYJavsGwQ5RQFtXb2r7d1K2
         ZINiHkPPxEnJMGR0i4Pf09tVbNiev56TbpB3rfNBhrG1b3QgLydZhRUG3p6WhDjYR5Sn
         /ANbRgTs2yt4gVB/giEEGUHHTHLiDimUwGMNDnU67w0c727FAt1wPRzdUWNyD++S605W
         q8bP6uf8Ycn7Y3imdSAmOGGu1LfdMXMg+Vm2TAi4i7axefelluhw+DzF+gIXxeRDJxf+
         bbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774119455; x=1774724255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KWPwJB6KN5IAOch8pp6QvEDjBdKNk6rUSq6diDMBwQ=;
        b=kLUqFkgqWIBcYi/O18bWCu8KohZOVMRXlSJjWN1D08HnVenivtP83SU+e2IvM+cyN6
         ah/9bc63ja7B4bETvlwvQ6bT6jIpXj/uFKG1PgilHdGrecjmwXBJJmr3GJh3ksclXjxC
         GISs0D0mskBymANaway0kJUiRSSZlW1KsfIH3Kmv6+hSOdbnFZeT5pQX/yf1Xf4rWwLi
         YiJFL89OAfry0kRsd6hpWhnPR9DKrns5cPT6AofQPdzsUaM6fTxXUyw94dpoVSuI5GRR
         Lc+kJsKuO5S+vvDdYpmO7Bu7pMUUNEFxpn7epT74ZjT7eOOTq6kUzKDql38UVYGZPjH4
         10sA==
X-Gm-Message-State: AOJu0YzGk8adryk1VVVakeDAg3YQCqhstSqublbes+QVmX0vSao3VKJE
	URlZ15wd31TzTpxEqiCQhP1BeUSUP9KjSW/5KB0kFZ3rEhKePkwxsL+K
X-Gm-Gg: ATEYQzwy/B/1mLEei9tR1KI4qhgqKE18h7b0KFAar+69JEn76jbZB341TELZ+ViHl56
	VQqFpO+PGlabDEsUqEbz3IfwJa/bn4c4aCtF7Byq3rVDshqAz79C4uGkNFwxOi3q/F6utR1g89w
	hfqTohBzfGoyE6TeWzqj/pIyVwoU+72cPWGgQXArCrIstQ3R4QQIvvVrg5KqqsSGTRTVdSis0i8
	S//4NX6ybM/aCBaUwlzlLN9gesa4sdCFkkNGqJjR6+ed0thXhn/2y9lWN2fDCyArrpIEfgF3cL5
	m3YLNik+LKIbEHVuSIAvwqH2BJCPyub+k0HTQ7gpEB6VfPtmYdLSexU2bPBp21jeWcW/lKVhIjv
	n2JsnUznUBeyzUxbcvvSSNLYXiqvDNmDsJiF+jmj02EJ0qwe/lUTKxwX+yjS7x110SHPcorH6fa
	PEUvyB5hsCqyH0DcHRoF0qGNniyYCOXA3qeOVFP1tekPs/z7Zl6WwV2zTOmQ++Hg2CNy6kP8/mM
	Yl2w03qS/NafmCXeyh5xLQtZ23N++K99CeqRkdVkb8=
X-Received: by 2002:a05:600c:8b84:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-486fe8e3facmr105469295e9.9.1774119455015;
        Sat, 21 Mar 2026 11:57:35 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8ba4baesm345244035e9.13.2026.03.21.11.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 11:57:34 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w41TD-00000001LSn-0qgv;
	Sat, 21 Mar 2026 19:57:29 +0100
Message-ID: <96b95953-48d6-40a7-9882-8e28705954bf@gmail.com>
Date: Sat, 21 Mar 2026 19:57:29 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] carl9170: mac80211: document spatial multiplexing
 power save handler
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B6B76223A73FFC756A19A99444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6B76223A73FFC756A19A99444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33645-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hotmail.de:email]
X-Rspamd-Queue-Id: F11AB2E6E03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:37 AM, Masi Osmani wrote:
> Replace the bare TODO comment in the SMPS configuration handler
> with documentation explaining why the driver accepts but does not
> act on SMPS mode changes.
> 
> The AR9170 advertises SM_PS disabled (both chains always active)
> in its HT capabilities.  While mac80211 may still send SMPS
> configuration requests, implementing static or dynamic SMPS would
> require firmware support for per-chain enable/disable that the
> AR9170 firmware (v1.9.9) does not provide.
> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>

Sure, this patch is reasonable.

Acked-by: Christian Lamparter <chunkeey@gmail.com>

> ---
>   drivers/net/wireless/ath/carl9170/main.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
> index 6324b38..d75688c 100644
> --- a/drivers/net/wireless/ath/carl9170/main.c
> +++ b/drivers/net/wireless/ath/carl9170/main.c
> @@ -910,7 +910,13 @@ static int carl9170_op_config(struct ieee80211_hw *hw, int radio_idx, u32 change
>   	}
>   
>   	if (changed & IEEE80211_CONF_CHANGE_SMPS) {
> -		/* TODO */
> +		/*
> +		 * We advertise SM_PS disabled (all chains active).
> +		 * mac80211 may still request mode changes, which we
> +		 * accept but only support OFF (both chains active).
> +		 * Static/dynamic SMPS would require firmware support
> +		 * for chain control that the AR9170 does not provide.
> +		 */
>   		err = 0;
>   	}
>   


