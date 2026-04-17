Return-Path: <linux-wireless+bounces-34954-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIJqEmOH4mkU7AAAu9opvQ
	(envelope-from <linux-wireless+bounces-34954-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:17:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53DC41E2CA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D81A33068EF3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135CE3AF67C;
	Fri, 17 Apr 2026 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S6VPRlD6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24836492A
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453351; cv=none; b=Ssxthj94pMYqzneVvj3MIaGtIbADlYehcSCgfR3NBKB87sNJoeLs+632RrsX042Vj4hANSN/PMiIjZ9qIF0kkZcYccDWb7oSGBe+sWPv2zJDThnUDf/gbRAhPvKu5DJ5D0vjWVyzBmhYtReTJCZekWs0iyYyKncLQTQrjvuXKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453351; c=relaxed/simple;
	bh=onBollFxU9gWCj1/4DHA9aCn9z/xNPjGiw84XhEE+uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNyrAY6uBrvw6LqCwX1E/NpTlnOXNwHbdkUrahc83KIYtxuxxY6D5hscTfPrVZj4qJ4ygA5QTPZQUwPROYQ7n/HyC9YcTozD6OgP02w+iwF6IsSyGc625lJRt1gFqlhktD18DF+FXwdgZCarymjxMmADiN6slmpN+9dzs6fivRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S6VPRlD6; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-506a6cf8242so8268851cf.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 12:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776453349; x=1777058149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ayc3jEms9UC869Y7shBNJreWQPohHdmWhf2wEENgffM=;
        b=NPQSX4lFQWgNoCVQpHAgtwlVjAARTNFyRk7fv/jfg8jS1kNNUcePt/GdDcYFyy66cQ
         wZX/rCLsCsQX7zu/F4KC6FGT2ZUpSsDcqSBhNgGwqYSNCCIlwsIyuR+3l1+IrWILcBtc
         xExKH7L6LGby0dKEZHmi2+kA/Uf1mw9PkWOjLf0Gq0RrsqscYx0gU7SdpCXsoejVuiLT
         djIRB10sF07BE0k40f+gd9U1OVCO1JIoclW176/jwMiIETD/YDXgHekgklrNhXFT6Oie
         wI7zwUeA4RObDTHj/CTzthIija92/UahIAQi4VoQzLqxLIWMA5v0fMzPOL3AuwjAF+jt
         eqiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aI71/jZz2PGhSVmKxG7DDp3sq3znjpT9QeWeD2P3L3dZj1A8N5lCSdxszTnZCO7nrjo7qhKaSaqoxJb6HLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTCUww+DqhPAc36akyBBMzDt7cnMx/YaoWzZQ2MaZnLSTNk+4
	HdRS0B58KsPvDAkhFMWUi4VFMXQd1CtL7d7QSY9cAYd8XH+rJ5b4oU9FDfRhnooNzpHyGVCfkZX
	UQ8gHfh2hOvqy+01RejYqciPt5mBkeqpXidUP4oKj6YJFU/ISUwGZB+fuhiHcrDhC2TXoKbG19P
	vyW4KMJEM3sDIweqkHXtGalG+c5fOeHpR2riHaogQdJ/fZW908ayTjwZOrAe3LW3ZCT2G+sfKAj
	AlMGfRwOgUWiq7V6LAM2Mi0lfLN
X-Gm-Gg: AeBDieuJloyzrUTrLfSaLRqcHnyds6TuIXE/+oNC7Kd1QLhplWH8pqlL1scicYTdYe/
	ilA00spnxFrjkgQn/k4i/nejQyJ4xyafY+L+MA2vyVaHlz0QsjCeK2HKUVjcO0Z0/C9E76lK2mf
	QGci7Rb1XzR0GPsfxUMwq+rg3ic2zVIhxSI0hzoWOk0uKPoe8hZWkWphH4z9Apso2YxHkxu/nzX
	qhe7+CjFuYzUjSzzdSRhSp2vE2tOLDj1nMahrRKUrbu76pqA/c+soPyitr8MdlIjdm7Gm51s7nE
	JL1zLCawUemluT7uiYAmFa59fPg3ZW2WFROIXZFUpL9UBzvFxilP/E2E9HK+M8Vww1nLiOhd4fO
	HKLnXILQyxS33NT+UGo6VFWSGjJzfcXeAWCBt6SNmb1ZDuvAeE5jKeSiH0+kF15ELLXgZHrPlM+
	118EttDIRXWWfm+eVDXbA81NDM8gbQCgRQ6/QLq8i14MCvkL03/C+I0FIqGD7UHxQzFDuau3g=
X-Received: by 2002:a05:622a:4d06:b0:50d:c25d:517a with SMTP id d75a77b69052e-50e36821829mr66359711cf.11.1776453348617;
        Fri, 17 Apr 2026 12:15:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50e39407d71sm1816871cf.13.2026.04.17.12.15.47
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:15:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8a16036c90eso25168566d6.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776453347; x=1777058147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ayc3jEms9UC869Y7shBNJreWQPohHdmWhf2wEENgffM=;
        b=S6VPRlD6grzJcPSLC3MyHBUL+g21sc1nDcmMwKF2Fb5ZU4asU87c07wc8zvHp/xFdF
         4QhfThpzzYVenp/XczKJUaWPqZManc5HjjzF5dFGimCKOXFJI9R9KthXR4qgVH7A06Hu
         v3NY5TY81sz5tyb+Q4YcUH+s+8JdB/h2+nEHI=
X-Forwarded-Encrypted: i=1; AFNElJ/+g4YkW3QwnruXzK2hYR4DxcxvTe/ySPCSnBajhmdB0cVb4WdpSBrhkPCRy+ouUzmgVvXXAChWiVvc9alGDw==@vger.kernel.org
X-Received: by 2002:a05:6214:21e6:b0:89c:4ea7:a70f with SMTP id 6a1803df08f44-8b028047ac8mr68671786d6.14.1776453346492;
        Fri, 17 Apr 2026 12:15:46 -0700 (PDT)
X-Received: by 2002:a05:6214:21e6:b0:89c:4ea7:a70f with SMTP id 6a1803df08f44-8b028047ac8mr68670746d6.14.1776453345482;
        Fri, 17 Apr 2026 12:15:45 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac77546sm16682886d6.17.2026.04.17.12.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 12:15:44 -0700 (PDT)
Message-ID: <a612564e-7338-430a-b7d8-8276adb45b05@broadcom.com>
Date: Fri, 17 Apr 2026 21:15:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: brcm80211: change current_bss to a
 FAM
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211@lists.linux.dev>,
 "open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS"
 <brcm80211-dev-list.pdl@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260331233238.23527-1-rosenp@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260331233238.23527-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34954-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B53DC41E2CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01/04/2026 01:32, Rosen Penev wrote:
> Change to a single allocation with kzalloc_flex and remove some
> boilerplate.
> 
> Done as a FAM instead of value to keep -> usage in codebase.

I get it and it looks a bit like a trick, but....

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   .../broadcom/brcm80211/brcmsmac/main.c        | 32 ++-----------------
>   .../broadcom/brcm80211/brcmsmac/main.h        |  2 +-
>   2 files changed, 3 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> index c7eaf160e1fa..4f57d64b1dd3 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> @@ -418,21 +418,12 @@ static int brcms_chspec_bw(u16 chanspec)
>   	return BRCMS_10_MHZ;
>   }
> 
> -static void brcms_c_bsscfg_mfree(struct brcms_bss_cfg *cfg)
> -{
> -	if (cfg == NULL)
> -		return;
> -
> -	kfree(cfg->current_bss);
> -	kfree(cfg);
> -}
> -

... it does clearly give some code reduction.

>   static void brcms_c_detach_mfree(struct brcms_c_info *wlc)
>   {
>   	if (wlc == NULL)
>   		return;
> 
> -	brcms_c_bsscfg_mfree(wlc->bsscfg);
> +	kfree(wlc->bsscfg);
>   	kfree(wlc->pub);
>   	kfree(wlc->modulecb);
>   	kfree(wlc->default_bss);

[...]

> @@ -527,7 +499,7 @@ brcms_c_attach_malloc(uint unit, uint *err, uint devid)
>   		goto fail;
>   	}
> 
> -	wlc->bsscfg = brcms_c_bsscfg_malloc(unit);
> +	wlc->bsscfg = kzalloc_flex(*wlc->bsscfg, current_bss, 1, GFP_ATOMIC);
>   	if (wlc->bsscfg == NULL) {
>   		*err = 1011;
>   		goto fail;
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
> index b7ca0d9891c4..e9cbb95a5a17 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.h
> @@ -614,7 +614,7 @@ struct brcms_bss_cfg {
>   	u8 SSID_len;
>   	u8 SSID[IEEE80211_MAX_SSID_LEN];
>   	u8 BSSID[ETH_ALEN];
> -	struct brcms_bss_info *current_bss;
> +	struct brcms_bss_info current_bss[];

It does feel icky to use a flex array for 1:1 object relation. It seems 
the lifetime of both objects is exactly the same so I would consider 
using the value instead of FAM. It would give the same code reduction, 
but making the patch slightly larger.

main.c:	kfree(cfg->current_bss);
main.c:	cfg->current_bss = kzalloc_obj(*cfg->current_bss, GFP_ATOMIC);
main.c:	if (cfg->current_bss == NULL)
main.c:			wlc->bsscfg->current_bss->chanspec = chanspec;
main.c:		rs = &wlc->bsscfg->current_bss->rateset;
main.c:			mcsset_bss = wlc->bsscfg->current_bss;
main.c:		bi = wlc->bsscfg->current_bss->beacon_period << 10;

So it is used in just 4 places not counting the first 3 hits for obvious 
reasons. Not too much effort to use value here so please do that.

Regards,
Arend

