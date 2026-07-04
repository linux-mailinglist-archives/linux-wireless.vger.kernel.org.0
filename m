Return-Path: <linux-wireless+bounces-38625-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DcJwN3dlSWo61QAAu9opvQ
	(envelope-from <linux-wireless+bounces-38625-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:56:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FC07085FF
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 21:56:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aFBvTPCr;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38625-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38625-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C303024947
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17C0328267;
	Sat,  4 Jul 2026 19:56:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265333254BB
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 19:56:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194995; cv=none; b=silKfoZ0Nbd78cI6CGWPHRNyxjznD+3OLuew12j4A+4j1HKU2mlWdGtOMFS0q9X0M2RFv32NJTxJFNjdnntjpyuWILUIW/JLhJtBN/AqFeatHYxGwkqA+o4skNAmrM59FYf/Idw/0HIEu3tK+jwmGHmYuBJ+yYxpHn13b8YKjwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194995; c=relaxed/simple;
	bh=8QanJYHVUT34kn3QE9sGltuZP8jObTRJVRAYEc7n4so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oy/fqESsGQwbDHH/qwjrr9N9pOKYYk2elm53FRWFxSTV8fPkt6bacQHAY5F+jTLWzK9GWH4MW32Ikt5+eTF6+qz+/EIHPlo0iElDHxiBd2DMSROHDkznlwv4ruSBI8vgpQSuUZRJ6hIUHOll7n5SiGDFwKFsC8xoQs8kIAhVTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFBvTPCr; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-473dc4cf238so982765f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783194992; x=1783799792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81Ke9cmmCoYK/kTyeCdB3HD1YEG5nCK1a1GlO9Nm9w0=;
        b=aFBvTPCrWp2EXCo+TLnjJVBfB5HILsEIoK7VKP/pzpEUZAsIqYewpDPGy4Pz0esYSz
         BSrjWwNmqbOV0ClNB2ilqK6Yk3AFFB1YzonNi36StMs4d9IZzkUeLc0Z65i0z5j7LEFR
         tq+OGiKtxlyugVnptRQ7gdrH0MwI5FyTXFgPLHzazIcrr/0MH+VdKnuVQUc5TEX0XcO0
         IYehbnV6WAfnB3k3hi/2H0jV0tWSU19qbVDBxkPy5+4H7VV+DA689bjj23OQfTnW8h9s
         ZwRibA16bSBiKgDgAz9DPL6FsduM2JIw1gZehvDtqpQN6QZ8LFRG8DbKNiBNvcwzAywi
         6TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194992; x=1783799792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81Ke9cmmCoYK/kTyeCdB3HD1YEG5nCK1a1GlO9Nm9w0=;
        b=H1MCfXqVeTYP+5GHn9D59kMmoNO6O7vSHVwbVuJj4OhW49VMyFHPx5ZEdVmIEw1TNn
         HHvs+3c0STCAOczprajQyohXzRIGHTDC5MIKVEr0nFU2OeOnEReF/hENha4Swdke3H3r
         4wtEwyqK3uwhRpnN5bnIeKvr4lq6sU5VBSeXin7KMvps2iwcnAbV86yFc8XNOl0upgon
         7Vik9OSfm/hkGq3A6EbTPtEDwu38ZsE+L4aiJ/GinrgjVQHeuljNS/Q3vf21Eiv0SEIa
         Ld0pYd63I8Ve8NQ4A5DxIPqG1XXeT2eKVJArK6bCPm6/vPrcjoLZO/Av4XEbBXU88JvQ
         WGTA==
X-Gm-Message-State: AOJu0Yy5QSObmQ9IaUsSykXE3btI1cE6cK6pIFFzxRcDc5Xt0rd//Q2r
	kQK3leQ8NAP9LhuVfbGV8uC0hpT12Rkp5sZhg9sjxkrjp6J8jNCYmCvr
X-Gm-Gg: AfdE7cmdDZ5QqUtRbH99F4dfZiKiBB+TOLO0BmmQxNYEMlSyn5GOrbe3K0WvlAEp4m6
	heK94itvrcNZjTcfxfMHT08Eeq7I0CeQdChudVtUIvkh1VKwKPnBL/D+7UwdbMx7IRtmSB1K8LY
	WpIiQ0bojPqiHZE7ufeZWinNe8/JTdeOwghAWbSKhasbQyYpo3FrAaOsU5Sz3IMHj3IgYWcZVQb
	mpkC65NspEZ2jbs8hMirv24PId30uurEu8ZN2SmqwWwJkWuUriNu44spTvP4RFEwIPK2EelYi8o
	7xUUUrBTnjzPL04oDBU5MCjvXZ6lqVPHS3ZKOZq807AS2cDhaDMQiAhG4Muz99QhVugwFKbhFFH
	fNRo9HnGh97L+NmGXY0FACzEXOZBP9m+ee7FWzmRezw2nfDWCQZ7ZjMqWub0ut6YIKruOrj6J9A
	c7NEKYXGjyIe+/2lxZHlkgIx7n62dezPChiH1noSOf3Ynl+pPmj0UgX0oLvYbs/OidgSWLbO5pY
	yxqRtfbDgg=
X-Received: by 2002:a5d:5189:0:b0:472:55a:ef96 with SMTP id ffacd0b85a97d-47aacbacb97mr3807785f8f.39.1783194992448;
        Sat, 04 Jul 2026 12:56:32 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm10342826f8f.33.2026.07.04.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 12:56:32 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wg6TX-00000000K1L-0Vrs;
	Sat, 04 Jul 2026 21:56:31 +0200
Message-ID: <741085b4-3892-487d-a39e-75c62a7b6d0f@gmail.com>
Date: Sat, 4 Jul 2026 21:56:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: reject mismatched command response
 lengths
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
References: <20260628092814.40583-1-alhouseenyousef@gmail.com>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260628092814.40583-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:chunkeey@googlemail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,m:chunkeey@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,googlemail.com];
	FORGED_SENDER(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38625-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,5c1ca6ccaa1215781cac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45FC07085FF

Hi,

On 6/28/26 11:28 AM, Yousef Alhouseen wrote:
> The firmware response length is controlled by the USB device. Although
> carl9170_cmd_callback() detects when it differs from the output buffer
> length, the function falls through and copies the entire response into
> that buffer. Callers commonly provide stack objects, so a malformed
> response can overwrite the kernel stack.
> 
> Return after scheduling device recovery. This also preserves the stated
> behavior of leaving the command incomplete so that its waiter times out
> and clears the pending output buffer.
> 
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>


This was posted earlier too:
https://lore.kernel.org/linux-wireless/20260421134929.325662-1-tristmd@gmail.com/

In fact, there was even a mail before that that was sent to security@vger.kernel.org.
I told Tristan that I would much rather not return and instead fix the memcpy.
carl9170_restart can completely unbind the device, so it's unlikely that one would
see a timeout.

Cheers,
Christian


> ---
>   drivers/net/wireless/ath/carl9170/rx.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index 6833430130f4..ea3f435fb64c 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -145,6 +145,7 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
>   		 * and we get a stack trace from there.
>   		 */
>   		carl9170_restart(ar, CARL9170_RR_INVALID_RSP);
> +		return;
>   	}
>   
>   	spin_lock(&ar->cmd_lock);


