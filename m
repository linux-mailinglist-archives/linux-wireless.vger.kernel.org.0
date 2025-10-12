Return-Path: <linux-wireless+bounces-27941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14884BCFF9E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 08:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB3344E0606
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 06:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC34D599;
	Sun, 12 Oct 2025 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iKxE0iRG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF722AD32
	for <linux-wireless@vger.kernel.org>; Sun, 12 Oct 2025 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760249238; cv=none; b=Oh/up3Kxo3Dh92gLHoF2VhTYFZXYSXyvDFk5rpeZCvrDwsaqcspz3NEjcF7Iyhu/AwiGTd7DZQpDP86nl6Wh9wTWbgb177SG6tgKQJ7kaCpmcN6NqMkXEoN53F23urTpNhFNd7lVt0wmLsL5iaWBYqscELtvRSdkbEm0CJ/lVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760249238; c=relaxed/simple;
	bh=ZhXi/B8+J2qT0zmAsJfx90DM0p9SawTy97urjDvD3qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DO/mRfE+VAaEuqoPBEACZz0LyUZBXCor1twrDaHyCTo18du6UmVon1Nod5ewsxE5S+BuRoAi30Zu7ZJSwezJt25ThDm6nMLVGUY7EcmVLbhExyP8U0YUjjHX7C7V9ShYwaVU2R8tuJ3aHorV6//5uTgmIsTwB52jWi3UOmtz+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iKxE0iRG; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-55784771e9dso1536405137.1
        for <linux-wireless@vger.kernel.org>; Sat, 11 Oct 2025 23:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760249235; x=1760854035;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+wboEOovg6MEBZq4Xq9CCnmDTpyulozEs/7GOAJliY=;
        b=PjWhXtUTHa5HZuykk6pzUTcVj/4CJBlS9XZgEJhkyjJ9cBNCfFwv77c2MmwseooLKT
         SgMxoquBZL3jyoMCN9lsp0E703odwEhVHYZA16xL77ulDJ8Y1AlPotVwPyGF9gECGkCs
         tFEF7YRdi2MOIzd9jIBqpbafoT/7cdO/c57I9Ae8EKRPwwFj6DrJCNBLgvB494nC+La4
         aX7T5BkunqHkvw22fnlCTXTYa1XQ8V4c0wqD5yp/ix9jrSexQ3Wh33+cwl7HWmsn8P/B
         O3/I2N1JWdU3H0Bv3VyeuHAAzHKw2iSDHFbAd3dm8Pj9qJVHdlLYUGTSi3S6ZdUZW/ll
         NB6g==
X-Forwarded-Encrypted: i=1; AJvYcCUeXQlcVdp0jsyAP+JwHBvY8GTowOpxOJZ57sejhtWTRnseIr4tzWC95EAAMp4uSf72XrLrCWaOeH1ehan6zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4lv5eQHsctpWyKmVv+tNbwKA3pzg4DZuISgYHboyyghLBpqq
	N7HjKNU4kLSLXdDHG5RoPHTV8KoXFC1N0GHuTNTC2AYHTDfbV1S2SpiMxXHoL8Z347g/1yXpss9
	EYx/+bJPVNvQp2csIKlplo/9pcEbdgkojL0CIfpxkgBQ5nUl8jNRZl3z5xuY52LKvvf9kOoY/5D
	hSA3NOjZbsV27iatKpB3hN8jvw+8B0tgA91fGyA+TYVLzt81czzVflcnlMJB3vvuqYb55oLLJOp
	198V5UJKGPefMCCGvzqczfNKpMV
X-Gm-Gg: ASbGnctLXopcWATa3ivxb2h9K/RMmAsdnD/3mLCtQqI2TjlZIUXw4zfDNOOYLmIn0PS
	DqX/QvgrpiUZBXyY3WGTSipkKRmGQO/fCWCSfsF79WVeVk5fPPotZQ/+l9lHVheZ/9/JISLz90C
	JZZSaFNBRUMxNJ23zY8bEF9b2Ru8p1ZkzyDf2YpvGZg4DYyLl1YHQDu8ALZ17qokytN737w1bHA
	d1NG9N+Fy+yjVj2+k7RTx6LTwKmMg12JKd7cnSjJvn+qwq8kq8P4FhjcDN6RYeDX6YEhpv2rtCj
	t2CpV9SKxFQjcB+qWqWY/xKwO2cQBSA88A1CBmoxASeyL0+1RAqfUOHUqdMOznjuj0S4oy9lG91
	GrFdfqU6A5ILacJ7C7N/dOQhDPsM4ha6qYK7QUYLgJdhsAIb/6KbxtAAuSTdlF8n4jvfyZjo226
	qNPq4=
X-Google-Smtp-Source: AGHT+IH6FqRb4UxEry3gcqXS/ImyWvSqCYJIF503IKOJGbHWjb20SpYLTMDXsX8mb+ZCPJchhZKDygJ1954E
X-Received: by 2002:a05:6102:5a90:b0:520:a44f:3dd6 with SMTP id ada2fe7eead31-5d5e224eb70mr6160178137.8.1760249234836;
        Sat, 11 Oct 2025 23:07:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-554d803b7fcsm677987e0c.8.2025.10.11.23.07.13
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2025 23:07:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-63b9bcd8cb4so135832a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 11 Oct 2025 23:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760249232; x=1760854032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a+wboEOovg6MEBZq4Xq9CCnmDTpyulozEs/7GOAJliY=;
        b=iKxE0iRG7Eb+rlkjXEY+yFImpB9GpN2s0EW4RCAehoH1NnkWTC0XB+AnluvlFKwUmr
         W0uG98MTnHA+aqB6i4g/I7BFFzcLYmUw+3wAan3t9wdHAkhYxKM7y3y9hqZ3PURT1uPu
         Wvr9SOGwQykOCzsE7op6dqn6+aIWXaF+rFKv8=
X-Forwarded-Encrypted: i=1; AJvYcCXKZMcbfN43T79KYkE0cssY3c2QUzhqA4CHqjmtwp5ddHZmG8k2rPYnLz2AzLl24Gg1JQOHgsKRcuiT05at5A==@vger.kernel.org
X-Received: by 2002:a05:6402:210b:b0:639:ea7d:f676 with SMTP id 4fb4d7f45d1cf-639ea7e627fmr12465139a12.31.1760249232434;
        Sat, 11 Oct 2025 23:07:12 -0700 (PDT)
X-Received: by 2002:a05:6402:210b:b0:639:ea7d:f676 with SMTP id 4fb4d7f45d1cf-639ea7e627fmr12465116a12.31.1760249231937;
        Sat, 11 Oct 2025 23:07:11 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c323693sm6435302a12.43.2025.10.11.23.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 23:07:11 -0700 (PDT)
Message-ID: <08368241-6b89-49e5-81cf-8e7874c91696@broadcom.com>
Date: Sun, 12 Oct 2025 08:07:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: fix crash while sending
 Action Frames in standalone AP Mode
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 chris@streetlogic.pro, linux-wireless@vger.kernel.org, richard@govivid.ai,
 s311332@gmail.com, wahrenst@gmx.net, wlan-kernel-dev-list@infineon.com,
 johannes@sipsolutions.net
References: <9a0849d8-befd-4fca-9d5d-a24520ccfa26@broadcom.com>
 <20251009073928.6803-1-gokulkumar.sivakumar@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251009073928.6803-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/9/2025 9:39 AM, Gokul Sivakumar wrote:
> Currently, whenever there is a need to transmit an Action frame,
> the brcmfmac driver always uses the P2P vif to send the "actframe" IOVAR to
> firmware. The P2P interfaces were available when wpa_supplicant is managing
> the wlan interface.
> 
> However, the P2P interfaces are not created/initialized when only hostapd
> is managing the wlan interface. And if hostapd receives an ANQP Query REQ
> Action frame even from an un-associated STA, the brcmfmac driver tries
> to use an uninitialized P2P vif pointer for sending the IOVAR to firmware.
> This NULL pointer dereferencing triggers a driver crash.
> 
>   [ 1417.074538] Unable to handle kernel NULL pointer dereference at virtual
>   address 0000000000000000
>   [...]
>   [ 1417.075188] Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
>   [...]
>   [ 1417.075653] Call trace:
>   [ 1417.075662]  brcmf_p2p_send_action_frame+0x23c/0xc58 [brcmfmac]
>   [ 1417.075738]  brcmf_cfg80211_mgmt_tx+0x304/0x5c0 [brcmfmac]
>   [ 1417.075810]  cfg80211_mlme_mgmt_tx+0x1b0/0x428 [cfg80211]
>   [ 1417.076067]  nl80211_tx_mgmt+0x238/0x388 [cfg80211]
>   [ 1417.076281]  genl_family_rcv_msg_doit+0xe0/0x158
>   [ 1417.076302]  genl_rcv_msg+0x220/0x2a0
>   [ 1417.076317]  netlink_rcv_skb+0x68/0x140
>   [ 1417.076330]  genl_rcv+0x40/0x60
>   [ 1417.076343]  netlink_unicast+0x330/0x3b8
>   [ 1417.076357]  netlink_sendmsg+0x19c/0x3f8
>   [ 1417.076370]  __sock_sendmsg+0x64/0xc0
>   [ 1417.076391]  ____sys_sendmsg+0x268/0x2a0
>   [ 1417.076408]  ___sys_sendmsg+0xb8/0x118
>   [ 1417.076427]  __sys_sendmsg+0x90/0xf8
>   [ 1417.076445]  __arm64_sys_sendmsg+0x2c/0x40
>   [ 1417.076465]  invoke_syscall+0x50/0x120
>   [ 1417.076486]  el0_svc_common.constprop.0+0x48/0xf0
>   [ 1417.076506]  do_el0_svc+0x24/0x38
>   [ 1417.076525]  el0_svc+0x30/0x100
>   [ 1417.076548]  el0t_64_sync_handler+0x100/0x130
>   [ 1417.076569]  el0t_64_sync+0x190/0x198
>   [ 1417.076589] Code: f9401e80 aa1603e2 f9403be1 5280e483 (f9400000)
> 
> Fix this, by always using the vif corresponding to the wdev on which the
> Action frame Transmission request was initiated by the userspace. This way,
> even if P2P vif is not available, the IOVAR is sent to firmware on AP vif
> and the ANQP Query RESP Action frame is transmitted without crashing the
> driver.
> 
> Remove init_completion() for "send_af_done" from brcmf_p2p_create_p2pdev()
> and do it in brcmf_p2p_tx_action_frame() instead of reinit_completion().
> Because the formar function would not get executed when hostapd is managing
> wlan interface, and so it is not safe to do reinit_completion() without any
> prior init_completion().
> 
> And in the brcmf_p2p_tx_action_frame() function, the condition check for
> P2P Presence response frame is not needed, since the wpa_supplicant is
> properly sending the P2P Presense Response frame on the P2P-GO vif instead
> of the P2P-Device vif.

Thanks, Gokul

Looks good. Respecting the vif provided by userspace is a better 
approach. So the actual issue is that hostapd does not create the 
P2P-Device interface, which is why I suggested to fallback on the 
primary vif. Overlooked the fact that we are doing a init_completion() 
in brcmf_p2p_create_p2pdev() which is needed for the action frame 
transmit. I have some comment on theat init_completion() change you made 
(see below).

Still would prefer to move the action frame transmit (afx) functionality 
out of the p2p source file, but that can be a separate rework.

Regards,
Arend

> Fixes: 18e2f61db3b7 ("brcmfmac: P2P action frame tx.")
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  3 +-
>   .../broadcom/brcm80211/brcmfmac/p2p.c         | 28 ++++++-------------
>   .../broadcom/brcm80211/brcmfmac/p2p.h         |  3 +-
>   3 files changed, 11 insertions(+), 23 deletions(-)
[...]

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> index 0dc9d28cd77b..c7c40dc3be08 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c

[...]

> @@ -1538,28 +1539,20 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
>    * The WLC_E_ACTION_FRAME_COMPLETE event will be received when the action
>    * frame is transmitted.
>    */
> -static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
> +static s32 brcmf_p2p_tx_action_frame(struct brcmf_if *ifp,
> +				     struct brcmf_p2p_info *p2p,
>   				     struct brcmf_fil_af_params_le *af_params)
>   {
>   	struct brcmf_pub *drvr = p2p->cfg->pub;
> -	struct brcmf_cfg80211_vif *vif;
> -	struct brcmf_p2p_action_frame *p2p_af;
>   	s32 err = 0;
>   
>   	brcmf_dbg(TRACE, "Enter\n");
>   
> -	reinit_completion(&p2p->send_af_done);
> +	init_completion(&p2p->send_af_done);

I think we should not do this here. It used to be init_completion() here 
but the kernel API changed introducing the reinit_completion() to make 
explicit distinction between init and reinit. So I would suggest to do 
the init_completion() in brcmf_p2p_attach() which is always invoked and
leave the reinit_completion() here.

>   	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
>   	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);

