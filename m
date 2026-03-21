Return-Path: <linux-wireless+bounces-33643-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tqroDHPmvmm2igMAu9opvQ
	(envelope-from <linux-wireless+bounces-33643-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 19:41:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 841F92E6D15
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 19:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B693009CEE
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B47831E84D;
	Sat, 21 Mar 2026 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J59BvuEO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6231E84A
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118512; cv=none; b=oNQjqtmXAAtswdiH0nS0VJcFAnuG/u1WdyDsQm2or9l52E9GGfbEAdyTqW50ZkyjIDCnVxgrjTIPNoZthjT7kVIMWIyNY/fWF0yQBkzUdpojuOvWpVxDJBRQ3BpRbkNq1yi341iBwShLUPAkqccakoCZr4n2mWUtlIKh1UzCIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118512; c=relaxed/simple;
	bh=eElVcb3bLwRs4KCqkTLewk5QF46s/IihuMcZJu+2J1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKwJGKRPtvCYN8KKUA3gmQDEDBduo3LtvZGOe/ah1Q7I5OQQ/5bEadzs4zjcQgfVubLGlMcOaPA6OpnVEsbnjjeqANYUfY6AblAnciognhvZmR2B4xcZR26vLneTEyhP3R1+h+M97BBiefxY0cA6Ga6BDKTHOeASSskBMxKGsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J59BvuEO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b467dcf0bso2442626f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774118509; x=1774723309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pidlFAiMDqFMAVqCXlK5KbaIEBrq6tqrEuVeR5BNPqE=;
        b=J59BvuEOic1yy8HezVpa3DHWg2qZ7MNPE6wCRvxBj+m2iNgRdULoow0dfZR73LgFki
         FjN0R9+LqHipO52MUyk6Qz8Hr1zMuxNTDWEBBlxtMtEa9g6zwdXFX7+0soV/J+GTWgNO
         h5jKhdjejmjt1DkvzMADJwwoGLJ5idy3Pa6nsqLr58m66F5BNRYUD8ddINRbTsLdGtkr
         wJ52+vX/72vESfTxPMR+sJwEF++lf/yMPBbAAmh9RInJnDyx8lMQHCeyN54IA4S5zCbY
         SqZm31iorXNtyw1WltbuqVUxapvKyp0vlyWgYc4UszZG3NSxDkSUzuxEO2QTCsb8u792
         vS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774118509; x=1774723309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pidlFAiMDqFMAVqCXlK5KbaIEBrq6tqrEuVeR5BNPqE=;
        b=bY6nR4C/n7INYLh+9tsBLs8+oeo9Rf3sH+NHY5iO6A1WYKXJdd2eN6+peu3M/vDBqK
         PjIvItaqlv+Wgsk87k2RQfraGWErsX9b2gT0Z0D8vqC+3cUDdE6tKDcUYeTNwxEF7Fua
         5mjY4H5Gh3PXho3dlw0gFQ38CocT4rA28dWkEAYsrrvf2CIqXMiZaaQaAr4ewitJSWoM
         p+ZThCv3ug1ynibBhG/Iy4FvyVPt7YFMFSrHqcNWi2KXSzmfAR8asrdppcpzP6xWGA6s
         8w4GXHP60jKk3KDtLqBt6uQVDeLA6/zLqCnc5Jj8S5DJ7syLIQOby9fLkO1lAytDFdti
         h0MQ==
X-Gm-Message-State: AOJu0YzvUhF0Yostcg15PciiTqfCv2x7STXXP7qsWU+tIaagqOUMEyHw
	3kt4zXi+/E4L9Xw/aEuiQfOc9zqKPKgnlGPi/Yr1seLFvBEpMfmf6/dU
X-Gm-Gg: ATEYQzwr/byo7tRW6LFSTHPhshzl+dE6qjSYOv85uIRIUO5oS5tbfC7ELX0ciYzX3Hu
	OljJvHcHCjWNqZ6n/TYZSlXzDsr0S0Qd66BNVcfQv4WGSyHru40oZ38KXJY2VI3/6Pf3SchifxV
	apkmxhA9qxoFJGrimKbRxIKKIHuXTwNlIlRTPdVB4t4ZKeHcIaWnbgh+dA+R84IUOb0pSjUQof3
	eWwQZf/nhu5ovJ7vU29lJAJcIBFTxUYHniK5yKZji/Cj6txV/lheyF/n7tzfmArqZfXuc+k9S3z
	tBQnF2ikczxHyuoZfOrGQ6fyRcV8q2A9iNzrryuWIo9ntL9xkRMgmp0v+w3fvyBZdXQi6pvFzJ/
	HQs4o0XR/dN9L3BnJ5yaJ7c8R7chvDkxntBuox7Qs5x9ZG8LwxFnzO2/7UM4xLJNvYasCFtiPju
	tJHE8aAU/xv0MgSr+BQLfcUS4eaYsW63SmBBfCPBwcXx2jk0tsHyR4Mm+SZl6g3cNLPkjx37DwR
	ZY4WyT8fb3ihladGZ9cWSyZs0uAGUxYQ260OGivmUs=
X-Received: by 2002:a05:600c:8215:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-486fe8e4038mr103427705e9.11.1774118508934;
        Sat, 21 Mar 2026 11:41:48 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe967c64sm150419075e9.2.2026.03.21.11.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 11:41:47 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w41Dv-00000001KQH-3k1P;
	Sat, 21 Mar 2026 19:41:41 +0100
Message-ID: <c5176f7e-6806-4c2f-a01e-8b30d0a965d3@gmail.com>
Date: Sat, 21 Mar 2026 19:41:41 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] carl9170: mac80211: enable Short Guard Interval for
 20 MHz
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
References: <cover.1773277728.git.mas-i@hotmail.de>
 <AM7PPF5613FA0B662B9909BAEB554565F499444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B662B9909BAEB554565F499444A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33643-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 841F92E6D15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:37 AM, Masi Osmani wrote:
> The AR9170 hardware supports Short Guard Interval (400ns) for both
> 20 MHz and 40 MHz channel widths.  SGI_40 was already advertised in
> the HT capabilities, but SGI_20 was missing.  This reduces the OFDM
> symbol duration from 800ns to 400ns on 20 MHz channels, increasing
> the maximum PHY rate from 130 Mbps to 144.4 Mbps (MCS 15, 2SS).
> 
> ath9k (the PCI sibling for the same AR9xxx chipset family) has
> always advertised both SGI_20 and SGI_40.
> 

Are you really, really sure about that?

Because based on what's in ath9k:
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath9k/hw.c?h=v7.0-rc4#n2622>

|        if (AR_SREV_9287_11_OR_LATER(ah) || AR_SREV_9271(ah))
|                pCap->hw_caps |= ATH9K_HW_CAP_SGI_20;

Whereas AR_SREV_9287_11_OR_LATER and AR_SREV_9271 are defined in reg.h @
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath9k/reg.h?h=v7.0-rc4#n861>

|#define AR_SREV_9287_11_OR_LATER(_ah) \
|        (((_ah)->hw_version.macVersion >= AR_SREV_VERSION_9287))
| [...]
|#define AR_SREV_9271(_ah) \
|    (((_ah))->hw_version.macVersion == AR_SREV_VERSION_9271)

What's strange here is that this isn't a PHY check, but MAC check...
And the AR9170 uses a modified ZyDAS MAC which is completely different
than what any of the ath9k siblings uses.

So based on that: No. I can't ACK that. The feature might work or not,
but that commit message is wrong.

That said, if you say have been successfully been using this and rewrite the
commit message to not include wrong information and add a module_parameter
like experimental that enables it, this would be OK!

Cheers,
Christian


> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/main.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
> index a7a9345..aa7e481 100644
> --- a/drivers/net/wireless/ath/carl9170/main.c
> +++ b/drivers/net/wireless/ath/carl9170/main.c
> @@ -154,6 +154,7 @@ static struct ieee80211_channel carl9170_5ghz_chantable[] = {
>   	.cap		= IEEE80211_HT_CAP_MAX_AMSDU |			\
>   			  IEEE80211_HT_CAP_SUP_WIDTH_20_40 |		\
>   			  IEEE80211_HT_CAP_SGI_40 |			\
> +			  IEEE80211_HT_CAP_SGI_20 |			\
>   			  IEEE80211_HT_CAP_DSSSCCK40 |			\
>   			  IEEE80211_HT_CAP_SM_PS,			\
>   	.ampdu_factor	= IEEE80211_HT_MAX_AMPDU_64K,			\


