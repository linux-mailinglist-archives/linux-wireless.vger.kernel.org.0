Return-Path: <linux-wireless+bounces-34940-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGlhAMZO4mnx4QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34940-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:16:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9441C7AB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC112301451A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0D3C342B;
	Fri, 17 Apr 2026 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKf1V4+l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331538F64A
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438873; cv=none; b=PT/mWcsc8iq1oUgvxi7yDnvq/Uf7tDaWIzFQt6+HGyijpMO/5fD2qV0wC/x8S6zN/jNcbixBA+IMGh+aDczGxsfbT58cSRSn1XDYcAfINBEx/MUJ+rUON9PEFEpLrZNCZs6S2dgcRlERkXI4YydVhBQlw/RL1FG7FDi6wNcdmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438873; c=relaxed/simple;
	bh=0Z3M1GBvLEbKRPWlp9U6a95QLT7OChOonaFA+1TP+B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXkZEelK8i0toCOOH3LChsugvDvBHVdeEpPvBuXwiPf8ZPtpKGGpqfhfqqQreQTpXuA7HX5nRrePUEM+3N9tH+HLb7g7jahmMJZQ1MSDQrep4q/C6/jfjRIzjp1wwieOu3qk9JyzNjO6cuRPGi+hzNHamMtgpwcd1H0oh5x4kVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKf1V4+l; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d7645adbdso495335f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776438870; x=1777043670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Ri+6mMt6AMzoQFFSoHuOhO0T3lkfEQuLeVmt9aQuIU=;
        b=aKf1V4+lD2CURpNa6QG9XEqVCxbomwxNtb5EaviOs1XwJo3uKYDz/XjxfIvfCwdtwE
         5RzaxH34NIzf4I6VM90KTpNX//kmJADTIMMx4SplaWpRu2hGXc2IQ88CdYh/LfLpGcUi
         NKc3rS0LKHrq84C2u14/dciNi50abb1Vi4enFnauzAsy/vK2XnBw/1jKPxIHfZVkxh6x
         icjnql+/djDaXmg47exllAyLAOA19PwDJ3hiMBh3Hz+V5pwFL/GtNJbKJAauIBdSdzAs
         E+kplCb13tMcOSVISQIMK/d/gpE/At1dcWM3ZznyzZj/NYb400ZVQyetKHKWpdoMa3C0
         Qg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438870; x=1777043670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ri+6mMt6AMzoQFFSoHuOhO0T3lkfEQuLeVmt9aQuIU=;
        b=KC61HZGkpwyGJJ9Azf1srZ3yLVF0AjbyuBLKZLT/5afc14FQquEiLJI5aZDqU3IsUj
         V/OjK3kJnUPqmIYQZkqcZx7wniESoVF0xjNoRCpyKcAvv1Dy6HPLYJ+veP0VEFm5wSBn
         oIXxfasNDWg7+qoFJnRq+itK4kyr9Gx08JbV096EsHO0d8Szzohe9/hcjpvz0AErUC8l
         J2QN3FoEUgUaQAAAV6JYLt3HGK7N+A2usBdDl6LfJQiofZaw+GRwvLRqR4OMsDZxBHfi
         hyCgHoEUr6dviGaaNwJR6ZYxYT/HlPs0kGpwKIggQGQoKD3xA9kt1f3TCCxYe1RpU21z
         AJfw==
X-Forwarded-Encrypted: i=1; AFNElJ80snoiNXbHUg4I7mr+g+EPQn4GcsGc3oU1VNui/xc9lKDsqHQx4trlAIPnfX9KuRcwc1I1NynSAnq6FHc6BA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNp8tmSRlZp5FyP9i6K8ZHn3TmbV+WdU4OfhUazJPzm2Ou4A48
	VsNuGQjGDfu9CG+3fSUJwFmAaFIPnPN5JXxNx4IZm8k6dn2pEAUW045VntZHfg==
X-Gm-Gg: AeBDiesslKUleKfp7iHw1bcRHRcW8HZ6q+3OLp31Fzml+OIIdrK0cKhCMAqkm2V+Tv1
	Ftl9JQuKlxRqxXTRVEccgbDiAcZB0LUefpVL/J3jAtMz1TGFO9p7d4slCLT9SMzn8JAnVQTsnr+
	aj8eaz75k0xxZ/CmEHscCk6qcSIrH34SdE4QbnNlGoAakgX0EmcfJbHb1sSLRgpxXYGHkpIsopR
	Hnl+FgjkDn8LqceF6ZZjpSvWB48x5xiy0neNEPpPrm37SOsPjrfNMySiZlWYjsHVNcBl6BSl8i9
	6T8DAHfGHQDEPKxJmFwvwUyPaCLL1vIOU3lG2S0WcfngNSgISOvW9h96r/hHxOoMLoPOQXa7Lwt
	ZtcAHFdBm7Ku+7fzkhUlQbLXoLo/FTCA4dd/9GdJ3JHqlGccyHIhjGZAA2SuFTpbF6MxF2x8CLZ
	DZMrDwWYDygc5dDEYOs2W0TLUf9byufyxGj3fQjzPK+SElYtM5ZMU=
X-Received: by 2002:a05:6000:2508:b0:43b:8f30:39bb with SMTP id ffacd0b85a97d-43fe3df1f30mr4847167f8f.24.1776438869814;
        Fri, 17 Apr 2026 08:14:29 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm5199468f8f.27.2026.04.17.08.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:14:29 -0700 (PDT)
Message-ID: <090b3c83-e3d5-4c8d-bd46-aaff692de529@gmail.com>
Date: Fri, 17 Apr 2026 18:14:27 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtw88: fix OOB read from firmware RX descriptor
 exceeding DMA buffer
To: Tristan Madani <tristmd@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20260415222440.1545959-1-tristmd@gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20260415222440.1545959-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34940-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91B9441C7AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/04/2026 01:24, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> In rtw_pci_rx_napi(), new_len is computed as the sum of pkt_len (14-bit
> descriptor field, max 16383) and pkt_offset (drv_info_sz + shift, both
> firmware-controlled). The result can exceed RTK_PCI_RX_BUF_SIZE (11478),
> causing an out-of-bounds read from the pre-allocated DMA buffer when
> skb_put_data copies new_len bytes. The USB transport already validates
> this (rtw_usb_rx_data_put checks against RTW_USB_MAX_RECVBUF_SZ); the
> PCIe path does not.
> 
> Add a check that new_len does not exceed the DMA buffer size.
> 
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Note: v2 resubmission -- original sent via Gmail had HTML rendering
> issues. This version uses git send-email for plain-text formatting.
> 
> Changes in v2:
>   - v2: clarify field widths and maximum new_len derivation in commit
>     message, per Ping-Ke Shih's feedback.
> 
> drivers/net/wireless/realtek/rtw88/pci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
> index XXXXXXX..XXXXXXX 100644
> --- a/drivers/net/wireless/realtek/rtw88/pci.c
> +++ b/drivers/net/wireless/realtek/rtw88/pci.c
> @@ -1078,6 +1078,11 @@ static int rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
>  		new_len = pkt_stat.pkt_len + pkt_offset;
> +		if (new_len > RTK_PCI_RX_BUF_SIZE) {
> +			rtw_dbg(rtwdev, RTW_DBG_RX,
> +				"oversized RX packet: %u\n", new_len);
> +			goto next_rp;
> +		}
>  		new = dev_alloc_skb(new_len);
>  		if (WARN_ONCE(!new, "rx routine starvation\n"))
>  			goto next_rp;
> 
> 

I'm working on a patch which will implement the same validation
in rtw_rx_query_rx_desc(), along with two other checks. I got a
report about too short packets from RTL8814AU, so USB devices
can also benefit from checking pkt_len. It will make this patch
redundant.

Well, kind of. Maybe RTK_PCI_RX_BUF_SIZE is too small? 11454 + 24
doesn't take into account the PHY info size.

