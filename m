Return-Path: <linux-wireless+bounces-33656-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uupxCV0av2kPugMAu9opvQ
	(envelope-from <linux-wireless+bounces-33656-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:23:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5D2E768F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E85573008311
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B3D242D9D;
	Sat, 21 Mar 2026 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5JV9GFX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52A53E0B
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774131800; cv=none; b=DRZKkn7Gt5sGSdldqsKIKF50Jh6/eF7ZFS/qYyYnJlozL1ou2VedAgT3ZXeDi3cIx1+Ody/LJfw+Of6KnkgZ8PHHVyyHGiW7RzxCJYXEfcxEHI4q/w+zvceaYmNb6SEARqEd9nhV66XZRAemSy/KoD65gN1RwXkkRc4C+Egk2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774131800; c=relaxed/simple;
	bh=c01jiOmrG1c8cy/VdJuGeWopyxusxfBO2ybRMNYY3ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTZVjLmW5Y5lUoRtDe4DRgzJuqTyFiClhOKEzevHEgEaouhTJtAFga/xIapoMXVswy7Ln9+Bp3o1u4cxN8SDXAL3Sk10FouLjuX4LXSL6DvspeiEfLTFo/JWnQGvX9iN1rqoHIfQGSqyNF7kNZQKhpwifAQachMz+iujDbRbGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5JV9GFX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso1814028f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774131797; x=1774736597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVe9pU0IW4S2F5pE6WIuxp7cdRW72xZGOAqcPYR4Gc4=;
        b=V5JV9GFXlqxp/usU/mUrcydbYYZYqOTH1knkRsUbtPcbYzsrrLVnG9ykJXhSTaHXGq
         yD9B+7AcrzTB2zOQC6fbPifgCIH16l0pttzEGG/EQsq88+9unZ9GPbsP3FOu5iX+yZvR
         N1Mvrftbk4j+cqy+xjTAG5hMUACzl2lBh2Plqw2OcJ15nSBiQubEWhuao3A2PXAFBXV7
         0k0TiuG8kr5t0wg1NQ9ProqWTZ83LiI5GQSJRVAV7sVvKtF8KLbyaQMlOkUVAPWhBpWo
         VjJXaFNKPPbL6mrzcZovfbRI6DDDnjhMtBQS6/7yt5+gRsseYAbIuf6IFBjVDf5lSwsr
         KBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774131797; x=1774736597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVe9pU0IW4S2F5pE6WIuxp7cdRW72xZGOAqcPYR4Gc4=;
        b=VYYDZ9GsOak3x/mrLNMXPU/YgLOVy5JlICsQvrFjDgaGkC8jDXDQKOnb4Xanj9xjZk
         oupIx90x6aRUAn+pSrnSWoxwbmKSA76WGqgk21FstsD5EIaBEoDRdD6H4bjTncMP1mAt
         gpAcWE7zRrLj9/7hnw3M30Y3bOVLBfBn00ouobeEv8MAhD4dvx10SVybBJnULWa3DBm1
         Q6/gyOUglt0we5VQMqniA4RtU7zq1yuOWGdGR6oVqF/wHw4Jna1pp1cToU1uqE3BC7ww
         358Oz7hOH4mysejln2qQ1R0/Gc//HacYIyHAVBmW1mCvzkaUoTP252vU8nudfPN5gn1F
         esWw==
X-Gm-Message-State: AOJu0YyHSjtI55rOIk1sq9L7w5/enMOEsA8rTvKY6UF0OfBg9GWp4qnw
	kIvRvKbKOPeo858CyXLBTNMGcmYeodqhTEDvwgFXZMudV898mx2plL2zouvM7Q==
X-Gm-Gg: ATEYQzzjnd4eXpHGPX+Hto+L9UknHHsNt6R9Imq1s67doCaMBm6NHxahWlbNtp2BRGd
	2oxDSVdbbbOd3RNEfs4JEFT5ZQ8OwKYIMM+o7QGM5TODZAR+yQLWstBDBpJKeEOx900svzl9Eq7
	4k66065+jElc2Dx74/SHKh7BSl4kTBnYta0KRU1Ywbl6E+f+ssNFWgQf6jH+W0a1KhGi80GT0Z0
	6SBiXCes7pf/GJXVPKIUm3ABdvWT7J+LgcHoh2WVIF+Fyskq/64wL56yyHDvRUr+EoJFW6wlTnf
	aa3toqrAfAl+Evqmcmzq2lwjNCry/ABFB6IRoLWHlaqDjf7foR1mDBgkdSi9Kabs+/82eRWo7HM
	5G5Crr7pl8wjF4fVJDAG3n7ZmDEgU5hAz8/hLdj+NYgmh8iwZoEGQ1HNiRbEn0i/odcYVEO63NF
	g6yUrMhxujKPSY55elIQsOj0GBpg4J6/vCUpQrB0IOo7/D0bC1/sN/MLQrAcrv66glyxVBc7qMV
	R1kp/LgmKbEgx5Oh4HiW5tjA767Rgx8
X-Received: by 2002:a05:6000:2502:b0:43b:4989:869d with SMTP id ffacd0b85a97d-43b64263f27mr11993260f8f.33.1774131797280;
        Sat, 21 Mar 2026 15:23:17 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd0dcsm15602800f8f.11.2026.03.21.15.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 15:23:16 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w44gL-00000001QLk-2mef;
	Sat, 21 Mar 2026 23:23:15 +0100
Message-ID: <4304625e-76fc-4570-b114-1a4f177a69f6@gmail.com>
Date: Sat, 21 Mar 2026 23:23:15 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] carlfw: disable buggy PSM to prevent USB command
 timeouts
To: iamdevnull <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org
References: <20260317091102.23894-1-mas-i@hotmail.de>
 <AM7PPF5613FA0B6CAD9AE8898D13A62F8CF9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6CAD9AE8898D13A62F8CF9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[hotmail.de];
	TAGGED_FROM(0.00)[bounces-33656-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email]
X-Rspamd-Queue-Id: A2D5D2E768F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 10:11 AM, iamdevnull wrote:
> From: Masi Osmani <mas-i@hotmail.de>
> 
> The carl9170 firmware power save implementation causes the SH-2
> processor to stop responding to USB commands after entering PS mode.
> Powering down the ADDAC and synthesizer via rf_psm() makes the
> device miss host command responses, triggering -ETIMEDOUT (-110)
> on the host every 45-135 seconds during normal operation.
> 
> The kernel.org driver documentation confirms:
> "Power Save Mode, It's implemented but buggy"
> 
> Three changes:
> - fw.c: remove CARL9170FW_PSM and CARL9170FW_FIXED_5GHZ_PSM from
>    firmware capability bitmask so the driver never enables PS
> - rf.c: rf_psm() early return — never power down ADDAC/synthesizer
> - hostif.c: accept but ignore CARL9170_CMD_PSM commands gracefully
> 
> With PSM disabled, the adapter stays fully responsive on USB.
> Tested: 0 crashes in 180s (previously every 45-135s). The host
> cannot force PS on even via iw set power_save on since the
> firmware no longer advertises the capability.

I have an idea here: Can you please add a new
config option (i.e. CARL9170FW_POWERSAVEMANAGEMENT),
let it depend on CARL9170FW_BROKEN_FEATURES (default n)
and then #ifdef / #endif around the feature flags and
make a rf_psm() stub when that feature isn't set?

Thanks
Christian

> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   carlfw/src/fw.c     | 6 ++++--
>   carlfw/src/hostif.c | 4 ++--
>   carlfw/src/rf.c     | 7 +++++++
>   3 files changed, 13 insertions(+), 4 deletions(-)
> 
> --- a/carlfw/src/fw.c	2026-03-16 23:38:46.184137155 +0100
> +++ b/carlfw/src/fw.c	2026-03-16 23:38:59.714232929 +0100
> @@ -48,8 +48,10 @@ const struct carl9170_firmware_descripto
>   #endif /* CONFIG_CARL9170FW_USB_DOWN_STREAM */
>   #ifdef CONFIG_CARL9170FW_RADIO_FUNCTIONS
>   					BIT(CARL9170FW_COMMAND_PHY) |
> -					BIT(CARL9170FW_PSM) |
> -					BIT(CARL9170FW_FIXED_5GHZ_PSM) |
> +					/*
> +					 * PSM capability removed — firmware
> +					 * PS causes USB command timeouts.
> +					 */
>   #endif /* CONFIG_CARL9170FW_RADIO_FUNCTIONS */
>   #ifdef CONFIG_CARL9170FW_SECURITY_ENGINE
>   					BIT(CARL9170FW_COMMAND_CAM) |
> --- a/carlfw/src/rf.c	2026-03-16 23:38:46.188101929 +0100
> +++ b/carlfw/src/rf.c	2026-03-16 23:39:12.970421845 +0100
> @@ -237,6 +237,13 @@ void rf_psm(void)
>   {
>   	u32 bank3;
>   
> +	/*
> +	 * PSM disabled — powering down ADDAC/synthesizer causes the
> +	 * SH-2 to miss USB command responses, triggering host-side
> +	 * -ETIMEDOUT and device crash. Always stay awake.
> +	 */
> +	return;
> +
>   	if (fw.phy.psm.state == CARL9170_PSM_SOFTWARE) {
>   		/* not enabled by the driver */
>   		return;
> --- a/carlfw/src/hostif.c	2026-03-16 23:38:46.192102245 +0100
> +++ b/carlfw/src/hostif.c	2026-03-16 23:39:27.262628301 +0100
> @@ -285,9 +285,9 @@ void handle_cmd(struct carl9170_rsp *res
>   		break;
>   
>   	case CARL9170_CMD_PSM:
> +		/* PSM commands accepted but ignored — PS is disabled
> +		 * to prevent USB command timeout crashes. */
>   		resp->hdr.len = 0;
> -		fw.phy.psm.state = le32_to_cpu(cmd->psm.state);
> -		rf_psm();

Hmm this removal of rf_psm() seems to be a leftover then.. since you
added the return; in the function too?

>   		break;
>   #endif /* CONFIG_CARL9170FW_RADIO_FUNCTIONS */
>   


