Return-Path: <linux-wireless+bounces-35744-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOVmGst99GlDBwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35744-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 12:17:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C3C4AB8FE
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 12:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7859B300A11F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E674A386566;
	Fri,  1 May 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mki+X5g/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4503859E0
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777630664; cv=none; b=Zx3RyRmtGBfcfnPsmC7BHiWkx+tyFD/6+QdhX+YRMoZJozRJ79PnBi+vEP93TEA+WsUJmoiYxefq10XffOsWUUqtTy3O9znSSfzEYSlwgHw+Wo93CC+ukfTtXf/pW9y6AlrBxV45CC2F+snxe3jzkOKd/zdnxacW7940bhhSqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777630664; c=relaxed/simple;
	bh=+yeYmE6NYLRk9ifgWABsVNa2UEapjwCOUIDjJzHIIUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJWmRED9im6+JqDuaZRfGed8/FNzBfH6LzGxFm+EzpTolBOp3RC4vlpQRRKZBbfeNEd4M2z0/gPdkEsuMxv1lQv8n3zJxPR9Xzut97kmIcalOGoUP3Db04VHlYyQeMkPAqU49u7kMm/Ob0s8Hhodi7cxAxPQ3FhGXslfrzza9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mki+X5g/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so17406655e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 01 May 2026 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777630662; x=1778235462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYjyCXD0QWyyHk9mNisFX8algpLc7AwOspU1e+v3Szg=;
        b=Mki+X5g/1LV/H17crZkK2eZIb7JZtVgrGxI+lm7tG5TjLt+j1Sd91l9K1ppYpSgQCW
         uOf/S8ffKmtwZ/PdgLiANVcjxaRzY/2QZp9TastJecSfCjl1LXOh64LtY6zpbrD37Of8
         cNcVUzz63dDamdq63K5r6+PRYNUJ+1wNfhFTiC+u1rBgsMInhypYki9nZTNaURqDd7Cb
         bRB0QBNwx5qZaJaeOQxlRwX8QzenEK5aJnVlWEh3DQlFB1vuRWmDrqX7w9xeJ28jGDdo
         zBuzk+8khz7rasXq+NhdO5ZdkbwER4QPGNot71RbIIbq/Z4k/3i9WslxjNPpZyC2nwvW
         +76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777630662; x=1778235462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYjyCXD0QWyyHk9mNisFX8algpLc7AwOspU1e+v3Szg=;
        b=hGYZC6Zd5knebX3JQMPbHSdBiQlnU8dwyakMAuAkL5MvHlETJ1iTioqGn2rx/8kITO
         JFnOeZKEgxzWIQrQ4b0nNB4K7rVpKFwtGk1EQf8RFwehnp2Q+5onKRIm3aiWUGXn9C1u
         y2kxf/fdenIfhoEFFp126JfxmHUyuHUgYbajIkkEw8zn5jcqI2biIBsnBWcH97MMLR3g
         rfmWOxc7HdzCpHIxsxPPKdc5PPj15k+kgrjU+8ZDJV5Ejedh3lSpjvE8xrkPna6/Tz+l
         saK7etdvEL/OY7Ur48MlKP6t9S3Cy5dKfYjsAsBkqIl6bVd/7tPZqaJTTm9PTTgBqA3p
         vxMA==
X-Gm-Message-State: AOJu0Yz0RhR6cNodZsDOeRXb2v2JcQQDyv2KhhtZNu73YBAMuZuFGCU/
	cMeMJj80ZiGi4tjuxL6CP+9rvE74RvuK19XxNfXys9CBCoLSJw3b7NNFohk0rQ==
X-Gm-Gg: AeBDietUwGvLBVIHCAoDChStF5hzyW8hT7+TVARagcTTRK24HDKdk6uUlTBe+7I4/GP
	ykUSMYp3AITkGgxWa9mIisVJoZDiWB2SLeEgFQDAlesZC35USnIXb+VWNetseyv5ogz8S9S+iWC
	IBdz+2gF/dxJqkbY5KLiNi0+4XZ+MwjTiDr5jY8HbK3K0LqFEjrh3CoIGq/WmBXv9K/bBOTio1v
	A2Eg/AUJ15S4xjSS4kHRbhrUOZ1cdHaFRinGzG2J2Gp9znQ2qh/yK8bEU8m30vip+1OzIufYPFN
	Xboma96rqAZEX3u/tPntWhFJT/R8l9PM1Qyq/teSWuAlJahL15offSHO7w9TaPtZsWcqq+Lc2iR
	VExd/nuOQ0OkuUk8sx8jyp8ecZ65BnklyRouj3HKPxvvg6SklY3DMXtyoOhEDIM1cn/eVPaQ1h2
	fQ56uKjT4j8qUjAe5tRCeamGaE7wqPWOWkXt7SG1lBLa2Pyox0WB4z39LGZ3HEjeRvWgDRmBosR
	/7CCormd+ThaDvnsS96x952GO3YAM9b6ExGS383X/A=
X-Received: by 2002:a05:600c:a315:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-48a83d6ec9emr84634615e9.8.1777630661417;
        Fri, 01 May 2026 03:17:41 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fede418sm12915405e9.6.2026.05.01.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 03:17:40 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.2)
	(envelope-from <chunkeey@gmail.com>)
	id 1wIkwG-000000006rJ-0kE0;
	Fri, 01 May 2026 12:17:40 +0200
Message-ID: <26e33fea-c81e-48f4-a058-4b3bf0dc95c5@gmail.com>
Date: Fri, 1 May 2026 12:17:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: fix stack-out-of-bounds in
 carl9170_cmd_callback
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,
 tristan@talencesecurity.com, TristanInSec@gmail.com
References: <20260424031711.53104-1-kartikey406@gmail.com>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260424031711.53104-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C3C3C4AB8FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35744-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,talencesecurity.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,5c1ca6ccaa1215781cac];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]

Hi,

On 4/24/26 5:17 AM, Deepanshu Kartikey wrote:
> carl9170_cmd_callback() does not return after calling
> carl9170_restart() when an invalid command response is detected.
> This causes a fall-through into the memcpy block below, where
> ar->readbuf is written with a device-controlled length (len - 4)
> instead of the expected ar->readlen bytes.
> 
> A malicious or fuzzing USB device can send an oversized response
> (e.g. 60 bytes) causing a stack-out-of-bounds write into ar->readbuf,
> as detected by KASAN.
> 
> Fix this by adding a return after carl9170_restart() to match the
> original intent stated in the comment ("Do not complete"). Also cap
> the memcpy with min_t() as defense-in-depth to prevent overflow even
> if the control flow changes in future.
> 
> The bug has been present since the initial driver submission in 2010.


I've seen this before in a mail from Tristan Madani (CC'd) on the 13th of April 2026.
Unfortunately, he didn't post this to the linux-wireless mailing-list. Instead
he went for the Security Officers <security@kernel.org> , so I can't provide any link to it.
That said, he since changed it because of the notes I had about the driver actually want to process
further so only the memcpy that caused the overflow was modified with the same
"min_t(u32, len - 4, ar->readlen)" instead of "len -4" as the length:
"[PATCH v3 1/3] wifi: carl9170: bound memcpy length in cmd callback to prevent OOB read"

https://lore.kernel.org/linux-wireless/20260421134929.325662-2-tristmd@gmail.com/

So, who should get the credit? Maybe another person will post a patch soon too? Who knows.

Note: if you used any assistents. Please also check out the (new) guide-lines:
https://docs.kernel.org/process/coding-assistants.html and give proper attributions
to the used tools.

> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac


> Tested-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>   drivers/net/wireless/ath/carl9170/rx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index 6833430130f4..6a5923495a01 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -145,12 +145,14 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
>   		 * and we get a stack trace from there.
>   		 */
>   		carl9170_restart(ar, CARL9170_RR_INVALID_RSP);
> +		return;

It does happen that the driver receives garbage from the device. To remain bug-to-bug compatible with
the rest of the driver should just handle it gracefully. (It's more like the comment above the
carl9170_restart outdated and could be removed. Because carl9170_restart can start an async process that
nukes the whole driver with a full usb_reset which will unbind the device... And if its too far gone it
won't be able to rebind - then it requires the user to either physically unplugged and reinserted the
wifi stick or reboot (only if it helps) or shutdown the machine)

>   	}
>   
>   	spin_lock(&ar->cmd_lock);
>   	if (ar->readbuf) {
>   		if (len >= 4)
> -			memcpy(ar->readbuf, buffer + 4, len - 4);
> +			memcpy(ar->readbuf, buffer + 4,
> +			       min_t(u32, len - 4, ar->readlen));

yes.

>   
>   		ar->readbuf = NULL;
>   	}


Cheers,
Christian

