Return-Path: <linux-wireless+bounces-2698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A68412CE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0867E1C232C0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305C179AB;
	Mon, 29 Jan 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq4arfD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507712E47
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554500; cv=none; b=Uu20iCg7z/1kQuTrRFNitixEhTy7PYW0pvNkYYiZqRAN/rfihAgpPQile+oPipDNeZF5grdIDmDFXkbUywW22DGnBd4qrS+DxibkWVPro5R0/hQUtXMCrvIzW0w8WMPkRaqiQ2OTt17JAplAJA62/1cgBxZC8Xl99kuP88MrHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554500; c=relaxed/simple;
	bh=okNTDaAi1oU24Wv25v/AWVdvvAQwPsSE8NKB4bJHl8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhoFO8Vtzlhd4o5Y8eHpkfIMSdNDBKPaZ9BNtAJAjHwyaoiXPdnLx7wDmw/y17HAQqHFC6SiwEX/nEe1ZZDQarmi5BGp9kzPYf85icrdLbl16w0+EKyfy+LcSBqsASe6HQ1kyDbJnB4371hP82FTWBVqIjRX0enlJq2h+UNC1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pq4arfD+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68009cb4669so24936446d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 10:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706554497; x=1707159297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouOLO2+L3N6DbaX5OPZoh5ZOu4yXD4sALxVz9wwuB+k=;
        b=Pq4arfD+RYcGc9rZvdEiFuV3A2j0QuagN9/wqKwtYTQARQS3szEX3WcGNs9atlJSNH
         mNvgsA4v31rrdr2hPCaAtFv10sKx8XkVSiqzDy7DngGEFv1u5qaQd8WHeGEBRj4BzxWX
         I+u5943lR+dlHQSv4oMaI+caIekL8kvCHgVI1SXZoJHHwzX4jlp51+3F6hABedAlZ/+8
         xmrWO2wFHZKxfAw2fOHJe7MbiBBwdiE3eVAhgtFSdMUl9hEwTham9CcDbi6YBN3x2JJw
         HyJo0mj/sRzTOonhL4O2lYaSX5yS82NobqI24dfG5rSL9/KETvY0tBeZKaAo9XC7ZtRd
         2Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706554497; x=1707159297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouOLO2+L3N6DbaX5OPZoh5ZOu4yXD4sALxVz9wwuB+k=;
        b=qVyx01Bs4RErwBsC2JxrbU6ESkbQMiISjUbPkCVx5X9tNdGNKuu3Y4OPSmX3tPc0Mm
         ekj0SfYAd15t0khBO8nXaPYyAAnndc1SG316YxgumhWTVn91ptbvply2xnLNVC4tjyvV
         Mfh5KjGvllpvLTKjnvZxx/E9dnraUPvLYZl7zy1xY9PW14PpWNZt4cNjyAYkn4DfHHiJ
         riM/PuWf1N3DfqSp5eQ8LDHqGZiBm73lzb2tKjxmDIatD56lHxC5BQMTnqkCvrhlw5HG
         4cktpCFcExHdLrCN4bonyHUQwAErCj5iF4Yq1eFwwJlz4lKkM+Ss+nHrHN+6gFkeW4Wd
         YuDw==
X-Gm-Message-State: AOJu0YysS4tjHNE234XHqquLB6LGx2TPYs5XIGadwlkRTTzvgzAYUvfb
	MTW6gQY5izSUeE9/XWDHzSwyIn3NXrmFSlzaarw/bIbXCg377cam
X-Google-Smtp-Source: AGHT+IGypV+j40jEGbX3D7XA9TgFIvXIwEY4QXQ0QT/in/TAjD25yASmOFL9S5pwa4okMF02tOb9wA==
X-Received: by 2002:a05:6214:d6a:b0:685:7e91:b423 with SMTP id 10-20020a0562140d6a00b006857e91b423mr7672345qvs.11.1706554497041;
        Mon, 29 Jan 2024 10:54:57 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id nc7-20020a0562142dc700b00686ad7daabesm3678323qvb.28.2024.01.29.10.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 10:54:56 -0800 (PST)
Message-ID: <415dd799-d824-4b0d-8c9a-60f67ff3f0b8@gmail.com>
Date: Mon, 29 Jan 2024 10:54:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] wifi: ath11k: fix connection failure due to
 unexpected peer delete
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240123025700.2929-1-quic_bqiang@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240123025700.2929-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Baochen,

On 1/22/24 6:56 PM, Baochen Qiang wrote:
> Currently ath11k_mac_op_unassign_vif_chanctx() deletes peer but
> ath11k_mac_op_assign_vif_chanctx() doesn't create it. This results in
> connection failure if MAC80211 calls drv_unassign_vif_chanctx() and
> drv_assign_vif_chanctx() during AUTH and ASSOC, see below log:
>
> [  102.372431] wlan0: authenticated
> [  102.372585] ath11k_pci 0000:01:00.0: wlan0: disabling HT/VHT/HE as WMM/QoS is not supported by the AP
> [  102.372593] ath11k_pci 0000:01:00.0: mac chanctx unassign ptr ffff895084638598 vdev_id 0
> [  102.372808] ath11k_pci 0000:01:00.0: WMI vdev stop id 0x0
> [  102.383114] ath11k_pci 0000:01:00.0: vdev stopped for vdev id 0
> [  102.384689] ath11k_pci 0000:01:00.0: WMI peer delete vdev_id 0 peer_addr 20:e5:2a:21:c4:51
> [  102.396676] ath11k_pci 0000:01:00.0: htt peer unmap vdev 0 peer 20:e5:2a:21:c4:51 id 3
> [  102.396711] ath11k_pci 0000:01:00.0: peer delete resp for vdev id 0 addr 20:e5:2a:21:c4:51
> [  102.396722] ath11k_pci 0000:01:00.0: mac removed peer 20:e5:2a:21:c4:51  vdev 0 after vdev stop
> [  102.396780] ath11k_pci 0000:01:00.0: mac chanctx assign ptr ffff895084639c18 vdev_id 0
> [  102.400628] wlan0: associate with 20:e5:2a:21:c4:51 (try 1/3)
> [  102.508864] wlan0: associate with 20:e5:2a:21:c4:51 (try 2/3)
> [  102.612815] wlan0: associate with 20:e5:2a:21:c4:51 (try 3/3)
> [  102.720846] wlan0: association with 20:e5:2a:21:c4:51 timed out
>
> The peer delete logic in ath11k_mac_op_unassign_vif_chanctx() is
> introduced by commit b4a0f54156ac ("ath11k: move peer delete after
> vdev stop of station for QCA6390 and WCN6855") to fix firmware
> crash issue caused by unexpected vdev stop/peer delete sequence.
>
> Actually for a STA interface peer should be deleted in
> ath11k_mac_op_sta_state() when STA's state changes from
> IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST, which also coincides
> with current peer creation design that peer is created during
> IEEE80211_STA_NOTEXIST -> IEEE80211_STA_NONE transition. So move
> peer delete back to ath11k_mac_op_sta_state(), also stop vdev before
> deleting peer to fix the firmware crash issue mentioned there. In
> this way the connection failure mentioned here is also fixed.
>
> Also do some cleanups in patch "wifi: ath11k: remove invalid peer
> create logic", and refactor in patches "wifi: ath11k: rename
> ath11k_start_vdev_delay()" and "wifi: ath11k: avoid forward declaration
> of ath11k_mac_start_vdev_delay()".
>
> Tested this patch set using QCA6390 and WCN6855 on both STA and SAP
> interfaces. Basic connection and ping work well.

I wanted to let you know I'm seeing similar behavior in my own testing, 
with these patches applied. Granted I've hacked things up quite a bit 
but it appears to happen after a firmware crash. It may be related to my 
own changes of course, but I've connected and created/started a monitor 
vdev, then wait. At some point the firmware crashes likely due to my 
botched patches, but once it starts up again I see this same timeout 
behavior before a retry which connects successfully.

> Baochen Qiang (4):
>    wifi: ath11k: remove invalid peer create logic
>    wifi: ath11k: rename ath11k_start_vdev_delay()
>    wifi: ath11k: avoid forward declaration of
>      ath11k_mac_start_vdev_delay()
>    wifi: ath11k: fix connection failure due to unexpected peer delete
>
>   drivers/net/wireless/ath/ath11k/mac.c | 564 +++++++++++++-------------
>   1 file changed, 288 insertions(+), 276 deletions(-)
>
>
> base-commit: 8ff464a183f92836d7fd99edceef50a89d8ea797

