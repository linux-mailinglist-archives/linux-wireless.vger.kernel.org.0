Return-Path: <linux-wireless+bounces-38747-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7jczI4blTGrbrgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38747-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 13:39:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D6971B05C
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 13:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="FL+kY/2N";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38747-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38747-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A01C303C415
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729E3F8891;
	Tue,  7 Jul 2026 11:32:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E183F8886
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 11:32:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423935; cv=none; b=f6QBmqPbvPYvY+yHAEyQEOw0HpKnFD3ifN5XCGLJeSRA7er0ur7ZDSUPVXlJMC4ak+t6JQDAkcPMPos8QChlwm0baA+R+trgAlreVbsWkbCpfYqr14oNAwxpx5fZUCnyNsFvPn37inve33kzbrgNMBn3Qle3ZiEEYBldiLZ3uSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423935; c=relaxed/simple;
	bh=nnvomAEpu0wEat20NTObqGZb5UC503NtBfolCZLb92M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AX+puzTQN8qvi/MiLyUcpFr/WHvkNf011uRBYqsjxojhecVp5Zx5hUzkuuCaqtUkXKHtx8jXOGJ49KDpsZIDab9k2XvQ7ytqqyDpl2IvWjY72Cwc1OcHibA1CZnDBmcQydaPdcatApGHL1Q1RYVL9RmIrUzWH2WL8IN/EGWhOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FL+kY/2N; arc=none smtp.client-ip=209.85.214.225
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2c7c61b5292so58113085ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 04:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783423933; x=1784028733;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YJ5QiKQH3VtcXnw6BGy4lgO2MoGjRkeKal0uvLeH+uQ=;
        b=VuTKQV1g9evsAKJ7JDnHqr03w1T+tOSJ+AmlUuiajs2Yor2CsSbwojFLBGQIiVlOPN
         ktrm3WYCDovS2VuPqFrzze8q0nmSUCFMQK1zklQsfgSQsnWrR2LbYM4EVXDmt4oGconf
         +7V5NEaw5dspDI+Jlcqo+wl2igKilmcaK3gwcmJ/UeADYR/6YQNk9+QrrOUV/UX9mXnL
         bIcnDfCHqyf+o/5lxDG1EH/4RM1qMxvWNPTlhuKbonYfzqhatOJekw1pxfoY/PEdDYX3
         nlh2iU5djO7XM2iFx6ZI+eUjNh54xfKxnTeK14BcgZ+p6wTfWHSgoJxtGfKrJo0wOqG5
         lWWg==
X-Gm-Message-State: AOJu0YyeLBuEMSmReJRRGll6n4wmf7YjbwmONLFMRm2JmV94EzQISaSJ
	R/O2XaoTM5mMzI4ItQPjEeqMqQtu+73xZJwMv8DS2ZGqfF5U44/JFZQfCxtj6pdp43U79SntZhy
	Ucwzxec/a53VkGcWi5O62iOJ80GD03lAmT6YQSt3MfS/Gk7xAoVKZ+cu8cfIGD6fZAMEFj745qp
	BwdsBbm1EQUQVpnww+uFfzDHTk/JctdklbxDzziCzQvMJ/iMlgeJARQ15U57huyGVdCy234cuXV
	C2vG8Z97jP156+8i6ZYOkMsUOU2
X-Gm-Gg: AfdE7cnMgYbM1uo+d0y9MoZ56LxsiahoOqJYcGB6aBNcveTzvlB0NPaWtihhanW8/Zv
	ygZX8rjr1o+YpeqE2wKwaQh3zKBC+nENID5XXZHuAPtZB8bxSjgbj/Tjn/8VlsZyVVAh4fd453Z
	iNay5czOvAMr6p6X3djX8Eai9HJgbuNjf+obqUfKrX9xICJf8VNRIfKfh5+heIovLZmVMEx42m8
	r1xOa+Td6Kw8HhehuMP321t/45HnTf1pGW0zcVDVIGOuukh5VYKRcYNTr+86aGTaqjlCbcnSgHA
	tKpQlmM8kM5kndIkQEgZsmwqorsrKWcvhv3CI+v/ZDK4OEACgR1IhBeDqcS2FNEWUShD+Gg3CgE
	QQzzY3yhEn2urRD96Es3ntxZmHw6iMKqpOzaRC689jS6HF7V/fU/Scqf8WO7idntN/lgbOdlLQI
	ayVGrBXTSjAa8PqQ0QJsbJxzahFlCHIa1wYi/KAhbSRGo20TQ/e1vw
X-Received: by 2002:a17:902:e84e:b0:2c9:e5ff:995d with SMTP id d9443c01a7336-2ccbf051374mr54819715ad.31.1783423933365;
        Tue, 07 Jul 2026 04:32:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc9ccdc21sm1973015ad.28.2026.07.07.04.32.12
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2026 04:32:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c01ff996dso55535111cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783423932; x=1784028732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJ5QiKQH3VtcXnw6BGy4lgO2MoGjRkeKal0uvLeH+uQ=;
        b=FL+kY/2Ntl9zvm1VmfXY3isCz0qeaPptoayjX0QrWWgCtkwbuOccsYsG0FpDoF6Lmn
         UDMXQUvkrIgwuYjkJ2oeexzmabOcgibnfvNGpW3IWdGg074kP6oGYLIl5YzGGFHX9m6s
         b292OAmzKXfclE07K/g/5Abr8w+dPBOFanO6c=
X-Received: by 2002:a05:622a:2516:b0:51c:7b12:11fe with SMTP id d75a77b69052e-51c7b121745mr20758721cf.76.1783423931797;
        Tue, 07 Jul 2026 04:32:11 -0700 (PDT)
X-Received: by 2002:a05:622a:2516:b0:51c:7b12:11fe with SMTP id d75a77b69052e-51c7b121745mr20758181cf.76.1783423931150;
        Tue, 07 Jul 2026 04:32:11 -0700 (PDT)
Received: from [10.176.2.33] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d7eb26sm111016721cf.21.2026.07.07.04.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 04:32:09 -0700 (PDT)
Message-ID: <77dfa2f3-296f-470b-8d21-0f10a56a2a4a@broadcom.com>
Date: Tue, 7 Jul 2026 13:32:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: brcmfmac: cyw: fix heap overflow on a short auth
 frame
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
References: <20260707063155.3099999-1-maoyixie.tju@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260707063155.3099999-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38747-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0D6971B05C

On 07/07/2026 08:31, Maoyi Xie wrote:
> brcmf_notify_auth_frame_rx() takes the frame length from the firmware
> event and copies the frame body with the management header offset
> subtracted:
> 
> 	u32 mgmt_frame_len = e->datalen - sizeof(struct brcmf_rx_mgmt_data);
> 	...
> 	memcpy(&mgmt_frame->u, frame,
> 	       mgmt_frame_len - offsetof(struct ieee80211_mgmt, u));
> 
> The only length check is e->datalen >= sizeof(*rxframe), so mgmt_frame_len
> can be anything from 0 up. offsetof(struct ieee80211_mgmt, u) is 24. When
> mgmt_frame_len is below that, the subtraction wraps as an unsigned value to
> a huge length. The memcpy then runs far past the kzalloc'd buffer. A
> malicious or malfunctioning AP can make the frame short during the
> external SAE auth exchange, so this is a remotely triggered heap overflow.
> 
> Reject frames shorter than the management header offset before the copy.
> 
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Thanks. Nothing to add here.

> ---
> v2: drop the Link: tag (Arend), add Arend's Acked-by.
> 
> v1: https://lore.kernel.org/r/20260627131313.3878893-1-maoyixie.tju@gmail.com
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c | 6 ++++++
>   1 file changed, 6 insertions(+)

