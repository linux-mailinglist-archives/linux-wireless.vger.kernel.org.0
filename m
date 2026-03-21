Return-Path: <linux-wireless+bounces-33655-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AMGFa8Xv2kduAMAu9opvQ
	(envelope-from <linux-wireless+bounces-33655-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:11:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AF42E765D
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45A61300831D
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112991FDA61;
	Sat, 21 Mar 2026 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L56TLMMT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9B136672
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774131114; cv=none; b=aFiBhAMXbbmvXOnQhhovWkrXa8/iTwDCX+Ao/yTHXlc3DnWMNAfkgseKJYV5zb/j9J4gWaCr1dFiLsC3zohC3QitjKQSsEfxD8PJrBvmVl9tSoXYj7xw60KSvutd/PEcXB32rzoQNX6K6XS/E5vJ3yekxnj+jDcuxGaDiRJPpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774131114; c=relaxed/simple;
	bh=Pe05LUWbq1NDIkHqgh3H3itqEr2VvoD19K9RGa/TXDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3bJbzMN43qOD5CtZ/ggG0OK7rT0O+RQle242VFeACWftZW8bIKld9ynWua9HlevTYb1UMklXdqmP8mtYlpsMtFxK419Xz0d7MVJ73d7OoxQUSWcmEO4F+vHTm7714UbLTkZV4Dj4ZWl6356rZVzgiwm9ag93FDWjmEw4YctNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L56TLMMT; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso1276482f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774131112; x=1774735912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yVtmIuUF5W6UvFxyUEdv2aK4BWioE57/D+TzdEfvMM=;
        b=L56TLMMTr83ZH8A3QtTbYZPXp+zPb+quQG0KFiejj0exHyXwR29UPH26yvM2KFLc5L
         BxiKj+N/OAeWVjohunHphjzKMVsS9cpe5fxXqa5a54ptjEsVsnj943py5rWva41lbbxz
         682Ys4JaGlr3W/TBd84LWX0nHvCYIy0Q8Uk28WnNd7JSINoxTlN7zPFOBxoOJhSygIF2
         ovGsJ0OtGe5Us/wzh7sGum9AIo4v5FR1meAIR9hL3Nzao95nD5EkUFLC+senYygnk3Vv
         k+ITLbm8br3NBZtZ/hqPyyQ9+1dlYbfS+UJMZ7tkWARSR26MJ+5VeWpi1j2k187xvuGf
         H0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774131112; x=1774735912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yVtmIuUF5W6UvFxyUEdv2aK4BWioE57/D+TzdEfvMM=;
        b=YidGVguIynoXvCVcaeVwiIUAHUEo+mAvcx1otvlRc6DLtggCHKCkOYKSsjfwDKYG3d
         R/0NiKhozmBVOb/DRercsPg5uQl360Y6avwzc9cSxXofHc+VFCglE4EHZZNwO/qbezJ0
         22+sDrW/hOh03aUvVMbyp1QT8Xmpc4OPHNUqBSvYhWMVsTUBWBKrjdifXOXs37gOzVtQ
         InzxYk51PvFj3TBUHSX0AvcdZDWQkE8EmJb1ll+Uh7+dr8KTsrQCuRf1hQ2JB+uLgw0G
         r8wyVbMo7lDpsZbXTtt3D5Wn820VGE2C0ASWjCDbq5YCtLpE+UfyfkvWHVQOiF3175gv
         Gr8g==
X-Gm-Message-State: AOJu0YywR4c70+P6MHlWlr203EwtzmDhzKjKIrNWscS7pzjq+gTrUCTG
	eqcVMOlKOGPaOAIX+b9cOlvhRuNBkcBw65kisq6jGVZCRGDhd25Hp/Il
X-Gm-Gg: ATEYQzyQjrc/wKDQDKfBxeD2bi3DTW98QzpiQU1eXovLFtqrgurmsWaLF9pe6cvd4c0
	DOQOd36rEcDdTND9LqO3YM7x4n/9AceWV0RRAlLA4h9g2gm4WLtVbR3VP0hzA0Uz1NkC/iRgy/P
	eJA7eO/y6E2bwZDA0QqYuO+J2uu6xOoTnX4/BTub1y40gI8eT2o4Lnjo/o3TH3BmwqMFUnlychm
	UX2vWdOEUoiBdQyfYevUFhs3dxVSWb2OfdLTe5OyrJn2jBh2pbwP98HCbzf6GAsX4A97UkSA78X
	8xMS1gLdmGbm7LGrTe23hC185QCPEkGilcQDibAKe7xJmRHZomocG2ZK2Ld7lXaxQErhGkREPsJ
	HtWWyf2XlueMeoDNDcfMoI7OgDUd7gi34jJESbCUl2vM54Pe8HtJA8CpR92PBK9oZ0T1EwHSJWT
	WXg0/uVnK8PKWBK9sZ6Zzi6cjdzfsAOq/uPI2eh12dTfQr5Io6NoWv8I+zwTjNIjSqdz3Wm4SrA
	OyqIj/fPT91TU5h7FaftRzxS7lzZJs7
X-Received: by 2002:a05:6000:2007:b0:43b:4f7d:e08b with SMTP id ffacd0b85a97d-43b642869ecmr11797826f8f.36.1774131111691;
        Sat, 21 Mar 2026 15:11:51 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0d3dsm17482398f8f.16.2026.03.21.15.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 15:11:51 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w44VI-00000001QFA-0IWp;
	Sat, 21 Mar 2026 23:11:50 +0100
Message-ID: <6303a0c5-068d-47b5-9d65-a99fefc8f991@gmail.com>
Date: Sat, 21 Mar 2026 23:11:49 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] carlfw: wlanrx: batch RX frame upload triggers
To: iamdevnull <mas-i@hotmail.de>,
 Christian Lamparter <chunkeey@googlemail.com>
Cc: linux-wireless@vger.kernel.org
References: <20260317091102.23894-1-mas-i@hotmail.de>
 <AM7PPF5613FA0B6DF41F140DFB83D1B53649441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B6DF41F140DFB83D1B53649441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33655-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[hotmail.de,googlemail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email]
X-Rspamd-Queue-Id: E2AF42E765D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 10:11 AM, iamdevnull wrote:
> From: Masi Osmani <mas-i@hotmail.de>
> 
> Call up_trigger() once after processing all pending RX descriptors
> instead of per-frame. The PTA DMA transfers all queued descriptors
> in a single USB transaction, reducing interrupt overhead on the host
> by up to N (where N = frames per RX burst).
> 
> On a busy 2.4 GHz channel with 10+ APs visible, this reduces USB
> interrupt rate during scan sweeps from ~200/s to ~30/s.

Interesting. Are you willing to share what PC/device you connected
your Fritz!WLAN N adapter to?

Because yes, I tried this before and I didn't see such a big difference.
This was back with my AMD Athlon X2, Core2Duo T7200 and i7 2630qm, It
became irrelevant with the i7 4770 (which I still have... but with a
new 2018-ish MB).

Cheers,
Christian


> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   carlfw/src/wlanrx.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/carlfw/src/wlanrx.c b/carlfw/src/wlanrx.c
> index 1234567..abcdefg 100644
> --- a/carlfw/src/wlanrx.c
> +++ b/carlfw/src/wlanrx.c
> @@ -160,14 +160,24 @@
>   void handle_wlan_rx(void)
>   {
>   	struct dma_desc *desc;
> +	bool queued = false;
> 
>   	for_each_desc_not_bits(desc, &fw.wlan.rx_queue, AR9170_OWN_BITS_HW) {
>   		if (!(wlan_rx_filter(desc) & fw.wlan.rx_filter)) {
>   			dma_put(&fw.pta.up_queue, desc);
> -			up_trigger();
> +			queued = true;
>   		} else {
>   			dma_reclaim(&fw.wlan.rx_queue, desc);
>   			wlan_trigger(AR9170_DMA_TRIGGER_RXQ);
>   		}
>   	}
> +
> +	/*
> +	 * Trigger USB upload once for the entire batch rather than
> +	 * per frame.  The PTA DMA will transfer all queued descriptors
> +	 * in a single USB transaction, reducing interrupt overhead on
> +	 * the host by up to N (where N = frames per RX burst).
> +	 */
> +	if (queued)
> +		up_trigger();
>   }


