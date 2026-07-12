Return-Path: <linux-wireless+bounces-38919-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R5hxG6AVVGqChwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38919-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 00:30:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5B27462C5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 00:30:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=ezYdBx0y;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38919-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38919-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D6AD3001A79
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAE3378D9A;
	Sun, 12 Jul 2026 22:30:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03BC368957
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 22:30:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895449; cv=none; b=s7gGyAEbp/Fc7Ixd0jE6CkyMh7GsDiyC/GHhWHpTSO8dS0BbCeJg10uPUCBPRqucXseK3KchfWazeopHdvH8yvf6LFwObC0nnBq37X2sj2i5uEwOo2p8uZcbn95sOlXKwryfkkYz868Hs/0txDFd4J+QlvSruVY2V2jdd4uRDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895449; c=relaxed/simple;
	bh=ER8tP37lObIhQR9iMWULWXKSl19MKFjdA03HNDy5ju0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmOb9n8WE6UkorXoTLDtFun1IxVdRm/dKf5xvg9J5GVbMqW8zJyNqNPvndcVZ69A//+Q6znMTZriD50+Kv0w0HOqNu7mbWpFbLdHTOsP1n2EsbCJOp9ZcvosUTltEgP2ogAXjNd3fRBN4U9tZodC1O+ujdrzW0qgUXmySptbFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ezYdBx0y; arc=none smtp.client-ip=209.85.160.99
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-451fd21113cso786399fac.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 15:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783895447; x=1784500247;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M5Hwfd1WgOYHOQEiKGvpV7zc4NRj0z5awcHqZeRtKQY=;
        b=aIjpmCQNBFCqJuZsM+vNQ09J+IAwKBm3hv5Ixp/e0BsLpO69tyUaABn8CWuzqSNNjc
         UD8UK1CSpW25vGTFtXjaVcJlvyeSaT0nl4uoPEKfdl5FZfYaQeYJtJ5jZvFSwULMTON7
         SunvzCaVxEommvqnttKmhc8yOLXcWdQ6EkEsqcubnjgrdckXXxmBWONko6Gvze95yqEd
         WAimNM/TLRDJPy9XqeoNEetCqOoR+hZyCW48upWAfqYsQUVc5rxE4uFqDZ+6rZOpP/Dy
         zChVvqpC6brd3M+rE9TVCsP+SBYEW8q++hHBsf6HKjip8HcvGPsAq4QPUL++G9CejiQA
         sJIg==
X-Gm-Message-State: AOJu0Yxwf3YuA7ktM2vCRHM+qLivjawSvWY1lLoxvlLK8G9mU+EuOzaL
	YlQcLYoWaoRLa9Zu5irPQLlOfFoY39ApMBodAs1FjcFKezIW3+TbwiSrkmQuwJ8OxmKzlwlhAs8
	I9+rJwpdTR+jfdiQBtxZcJoLlG3j8yqebOdkk2KoNpJq+9Xnubz4Rb8m3Ip49fVlFhMaBdfNOVr
	3K4kzfN6zdtxsKixGn1Fn09qcHa2sUmr5dIVQl3qJhKl0ZyPN5fFjjehNywll4yWQZW7SM3DlZr
	t9eILWU654rauC1RRz/E8nn4smE
X-Gm-Gg: AfdE7cmuVqUH9hVSNdzrNKo/p5tTHowxSvCWRZJMlYlr4HPzBbXCqSb3/OJJLVe6LnU
	FCQ8nKmdmNiFRW0p51k80HbV6STo7Z/8uX+p8vXMUU49cZH+D3qhYXw6mJVX2/MpgobGuYL76H7
	QcWsn6aQd7jT5tQutY/gA0hM8TlG38i03P/Gn1vcHg5EGD5tybhE+Va83egNtONQLRqdAD/LA9Q
	Nn7ssOMIWBk3b2aKGSlx2niF7lYKWr8s1RNe1mGnkg4d0CM7rU548HS9SY7UPtpBq45WS0cOQVN
	j0ZvyJyBvH6nq5YJhskNp/FD8AjNkjqTb2LBATFbuE6uIar+iKn09kW4cJpmJbNQONTLoxqgS0E
	W+YjQji4U2P+OnQh2h0eC9P0PdKTv+7S9R/QkyXa+7Y2p9cJr/08q4FxkEUoa91GzTmXC+ENKrm
	RTNlKvSzeD1baNoPmVl37TdS0CMPQ2l0Z0sghRZqEHYkdm1pH1W3o1
X-Received: by 2002:a05:6870:c0cb:b0:44c:a2c5:28d0 with SMTP id 586e51a60fabf-451f24a452cmr3570601fac.1.1783895446932;
        Sun, 12 Jul 2026 15:30:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4519182d1casm1112893fac.15.2026.07.12.15.30.46
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2026 15:30:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9c26587e67so2567516a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783895445; x=1784500245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5Hwfd1WgOYHOQEiKGvpV7zc4NRj0z5awcHqZeRtKQY=;
        b=ezYdBx0ylQD2SJbb68gSWTy/hTMv6ujoZIi/mkht3ETFMEyV3+s97ybmvQ5iYE5NZB
         A6YfiH4OmGGr0XTglYTYXz7VpGQBzGl+A3FN2kdPEIqr9BHRJ4icVFUaOvuJdgg86voV
         iqeHh+J3unDL45VbnJYX29iuEWvugNNH3ArVY=
X-Received: by 2002:a05:6a21:164a:b0:3b3:3506:cf3f with SMTP id adf61e73a8af0-3c0f085cddamr12242628637.1.1783895445286;
        Sun, 12 Jul 2026 15:30:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:164a:b0:3b3:3506:cf3f with SMTP id adf61e73a8af0-3c0f085cddamr12242613637.1.1783895444870;
        Sun, 12 Jul 2026 15:30:44 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm35908753c88.1.2026.07.12.15.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 15:30:43 -0700 (PDT)
Message-ID: <99c2c345-c594-46e1-b48a-de7f6e52e1c6@broadcom.com>
Date: Mon, 13 Jul 2026 00:30:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cyw: clean up PMKID and cookie code
To: Bogdan Nicolae <bogdan.nicolae@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 Bogdan Nicolae <bogdan.nicolae@acm.org>
References: <20260709122315.11400-1-bogdan.nicolae@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260709122315.11400-1-bogdan.nicolae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38919-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bogdan.nicolae@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:bogdan.nicolae@acm.org,m:bogdannicolae@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F5B27462C5

On 09/07/2026 14:23, Bogdan Nicolae wrote:
> Avoid setting packet_id to cookie, which is always 0. Instead, use an
> increasing atomic counter. Avoids mismatches of completion events later
> in brcmf_notify_mgmt_tx_status, where packet_id != vif->mgmt_tx_id is
> checked.
> 
> Also, zero out auth_status on initialization. Otherwise, garbage will
> leak from the stack to the firmware (when bssid is less than 32 bytes
> and/or when params->pmkid is set). Then, pass the params->pmkid to the
> firmware (without it, the firmware caches a garbage PMKID on successful
> authentication and denies a subsequent association request that includes
> the PMKID).
> 
> Signed-off-by: Bogdan Nicolae <bogdan.nicolae@acm.org>

I always get a bit confused when people use different email addresses to 
send and sign-off patches.
   > ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c   | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> index ce09d44fa..cca53ff19 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> @@ -23,6 +23,8 @@
>   #define MGMT_AUTH_FRAME_DWELL_TIME	4000
>   #define MGMT_AUTH_FRAME_WAIT_TIME	(MGMT_AUTH_FRAME_DWELL_TIME + 100)
>   
> +static atomic_t brcmf_cyw_mgmt_tx_id = ATOMIC_INIT(0);
> +
>   static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
>   				 struct cfg80211_crypto_settings *crypto)
>   {
> @@ -155,7 +157,7 @@ int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   
>   	memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
>   	memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
> -	mf_params->packet_id = cpu_to_le32(*cookie);
> +	mf_params->packet_id = cpu_to_le32(atomic_inc_return(&brcmf_cyw_mgmt_tx_id));

As I understand things the cookie value here is an output parameter. The 
driver should assign it:

+	*cookie = atomic_inc_return(&brcmf_cyw_mgmt_tx_id);
	mf_params->packet_id = cpu_to_le32(*cookie);

>   	memcpy(mf_params->data, &buf[DOT11_MGMT_HDR_LEN],
>   	       le16_to_cpu(mf_params->len));
>
Regards,
Arend

