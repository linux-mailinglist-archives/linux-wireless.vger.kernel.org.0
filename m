Return-Path: <linux-wireless+bounces-19148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA4DA3C866
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 20:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF0A1886FF7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4DD22A808;
	Wed, 19 Feb 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMCRY3Oq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C722A800
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992766; cv=none; b=fyKd35BclmzqmmobX7Sps1IbOn4kpC+cfAHjii5tb6OMDPuIn7cYF7/VOU0JO4S1OLusgnpYGNUip4Q695pAk8AYX5RpDJ9ulRmDUduV+WRMSgiwogW1w8qkaYivwQ4gX1mFzM1A7bi+FLHjKlk6PizOdaqK9KWSMLQcMBH+RMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992766; c=relaxed/simple;
	bh=KOBgqs5paS2nt3Bo/Wdp2pBIjlG14I9Z1y13FJorZeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAMlSVVjOHLXHGIR1Yu/qBkxdOkxM/gLci69k9vifH2R+Vhh8vYH5GgkSf4djBU2mYLZ5NqMT6L01twa9msbd4NthEF4K3HNYjAGveQKDk9FTHt+OMD9WrpktScLTtgcytKnuD3D1icPBP5DKJMki8BemDZcZFpSqZNSGELL0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMCRY3Oq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd01781b56so1226106d6.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 11:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739992763; x=1740597563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHgCKGhRvgr46kIuBqHOa57kL1o3vnrcWGzCekOjTRM=;
        b=HMCRY3OqhWA0RmJ9KAwH1TqcnuWUhGEPRYf0k9KPfB75vjv0Mq8C2Jw6sLNqD87Rso
         9R5gVdo7O8073T3382NBvIiRTwKrOsrnzJyim1p3klcbknJ7ypFc4myJVPu3axB7nNFJ
         2urzyj+Yr47I1rJapdQ8B7EW4JIqr/PwkWb47JVTYbBhxV1SRcgZKBnH6lgE6v1HhK4o
         FPlnyBhkWV9zNdZpHZXf21IiSTTafa2/z5juRYWc9Gw/1u9dL2ko2Brn7HjH3v0yBAJY
         F1TxGIAxh0CWcRTqyh7f29ykkkGlplVcnIqnUD9VCYLge209zjzxi98m6dNQTHp9XmyD
         t8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739992763; x=1740597563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHgCKGhRvgr46kIuBqHOa57kL1o3vnrcWGzCekOjTRM=;
        b=fxuQJsbsO7dDAURmknULHMkyWXSF70UkPIPn82nBOGzpgId2TpeIrIds7HHZ769CPT
         99+zHQjdQBBLxtfUQeQfJpVCtWuccPnPuDjGd5bO1r/avxk9sXiLINMAS0LzRio+eO7u
         QdWVXYfJrkcGQlO8VAWaSJc7k2xaBzGqUDtaCKh3wkuUU0G6kpeSutwdvLhB14VBeYtY
         4OanIbFE6BLYcozsKhTRgX2l4+2D7wy90FNMJMK8zLDwt7TiWuygnUKej7jWBBsC1XKU
         /m3KVWEY1JOctydjTa+LOHaEyvGvYEx8Yq3pMh7GOYn6BKY/9eTZBKAvlzUfAEuRTcDP
         6m3g==
X-Forwarded-Encrypted: i=1; AJvYcCXhJch3xxOtN9Wz5//kwY8jSXNKjEo4G7v9hlyrJ6SwHcTJTQ31EtiKn2HfTaOHVprbWvQgWGs6ZIcup71tZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5c+x0zE27yXpB/HwUqjQHOxHa5EQanPWhOqN4pb8IlYQfhEsF
	ewcCO1o8ryh8A5P8lXf/uqnvHM/2Mb9EJv/sDmNLwWF9E8E4fQns
X-Gm-Gg: ASbGnctYlzR3GZihZYbeR9IPJrsF5xGxctwri1Yn9zhWjQNroXgpZn1EU2rj4K15gOu
	b3FdEe+ZqtYE4FTxWujEOVaF3cPfAVQ3gyApOYuOdn2elugVOh1DPRESNwC8uvt5RRmPp4vnpIN
	BF/SSkHXzBX5mXIZhsJAMrsj8jVdRY69X4hdid52AXkXW8wb59G7bkhQlnNOh7HydXO9OxlFzRw
	WfMJdVEt89rTcnkT9VoJWxGZHnsno+33IWpcCnYLE41FsDPL9QUrL9hALphrSNzOGTujnt3GrDi
	Tgv5aSw7zbMB1EgF97c=
X-Google-Smtp-Source: AGHT+IE9Mg8QbzyhYEjAJEprcufd27B1cDpoyHYYGgqxwP22pmQsQ/qHFCOORKofk2sd369NYIUDAQ==
X-Received: by 2002:a05:6214:21cb:b0:6e4:6ff6:bac2 with SMTP id 6a1803df08f44-6e66ce2c480mr232972566d6.40.1739992763178;
        Wed, 19 Feb 2025 11:19:23 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848ebsm78136626d6.32.2025.02.19.11.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 11:19:22 -0800 (PST)
Message-ID: <548270b0-8267-4a94-85ab-597ade0f5082@gmail.com>
Date: Wed, 19 Feb 2025 11:19:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Convert mac80211 to TXQs only
To: Alexander Wetzel <Alexander@wetzel-home.de>,
 linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, ath10k@lists.infradead.org,
 Remi Pommarel <repk@triplefau.lt>
References: <20250217081721.45110-1-Alexander@wetzel-home.de>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20250217081721.45110-1-Alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexander,

On 2/17/25 12:17 AM, Alexander Wetzel wrote:
> This series switches all TX handling in mac80211 over to TXQs.
> TXQs can take over buffering in many - potentially even all - cases
> where we use separate solutions so far.
> This reduces the complexity of the TX path and making it simpler to use
> TX in mac8021.
>
> These patches continue the work to get rid of the legacy TX path we
> started drivers with
> https://lore.kernel.org/r/20221009163040.25637-1-alexander@wetzel-home.de
>
> and was inspired by this old discussion on the wireless mailing list:
> https://lore.kernel.org/r/1507217947.2387.60.camel@sipsolutions.net/
>
> Changes compared to RFC and v1 are documented in the individual patches,
> where applicable.
>
> A quick overview of the patches in the series:
>    wifi: mac80211: move rate control setup
> 	Broken off from "Add new TX queues to replace legacy TX" as
> 	requested. Moves some exiting code around.
>
>    wifi: mac80211: Always provide the MMPDU TXQ
> 	When only using TXQs for TX we akways need this.
> 	Creates and uses MMPDU TXQs even for drivers not supporting
> 	them.
>
>    wifi: mac80211: Convert vif->txq to an array
> 	We need some more TXQs for the patch below. Create them.
>
>    wifi: mac80211: Add new TX queues to replace legacy TX
> 	This starts the core of the move to TXQs.
> 	Creats all the missing TXQs and updates the support function for
> 	them. It also directly switches traffic to them, when possible.
> 	(Only offchannel is sticking to legacy TX after that.)
>
>    wifi: mac80211: Stop using legacy TX path
> 	Drop the legacy TX functions and move offchannel TX to the new
> 	alternate TXQ path named TXQ_NOQUEUE (so far).
>          With that mac80211 has two TX paths both using TXQ:
>           - The existing one, which uses the TXQ for queuing and
>           - TXQ_NOQUEUE. Which just puts frames into a TXQ and
>             immediately sends out the frame by also calling drv_tx() for
>             it. There never can be more than one frame in any of these
>             TXQs. They never see a wake_tx_queue call by the driver or
>             mac80211.
>
>    wifi: mac80211: Call ieee80211_tx_h_select_key only once
> 	A optimization which could be without the patches, too. Would
> 	just be done differently. (Not required)
>
>    wifi: mac80211: Rename IEEE80211_TX_INTFL_OFFCHAN_TX_OK
> 	Rename the flag used to select the NOQUEU TX path to make its
> 	use more obvious.
>
>    wifi: mac80211: Simplify AMPDU handling
> 	Uses TXQs to buffer frames when AMPDU is started/stopped.
>
>    wifi: mac80211: Migrate TX to kthread
> 	Moves all TX operation except TXQ_NOQUEUE to a new kthread.
>          This hooks into the existing txq scheduling and uses
> 	local->active_txqs to determine which TXQs need to run.
>
>    wifi: mac80211: Cleanup *ieee80211_wake_txq* naming
> 	Rename a few functions.
>
>   drivers/net/wireless/ath/ath10k/mac.c         |   8 +-
>   drivers/net/wireless/ath/ath9k/ath9k.h        |   2 +-
>   .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   6 +-
>   .../net/wireless/mediatek/mt76/mt7603/main.c  |   3 +-
>   .../net/wireless/mediatek/mt76/mt7615/main.c  |   5 +-
>   .../net/wireless/mediatek/mt76/mt76x02_util.c |   3 +-
>   .../net/wireless/mediatek/mt76/mt7915/main.c  |   6 +-
>   .../net/wireless/mediatek/mt76/mt7921/main.c  |   5 +-
>   .../net/wireless/mediatek/mt76/mt7925/main.c  |   5 +-
>   .../net/wireless/mediatek/mt76/mt7996/main.c  |   5 +-
>   drivers/net/wireless/realtek/rtw88/mac80211.c |   4 +-
>   drivers/net/wireless/realtek/rtw88/main.c     |   2 +-
>   drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +-
>   include/net/mac80211.h                        |  60 +-
>   net/mac80211/agg-tx.c                         | 129 +---
>   net/mac80211/cfg.c                            |   8 +-
>   net/mac80211/debugfs_netdev.c                 |  46 +-
>   net/mac80211/debugfs_sta.c                    |   2 -
>   net/mac80211/driver-ops.h                     |  28 +-
>   net/mac80211/ieee80211_i.h                    |  32 +-
>   net/mac80211/iface.c                          | 144 ++--
>   net/mac80211/main.c                           |   9 +-
>   net/mac80211/mesh.c                           |  13 +-
>   net/mac80211/mlme.c                           |   2 +-
>   net/mac80211/offchannel.c                     |   2 +-
>   net/mac80211/rx.c                             |  11 +-
>   net/mac80211/scan.c                           |   2 +-
>   net/mac80211/sta_info.c                       |   6 +-
>   net/mac80211/sta_info.h                       |  30 +-
>   net/mac80211/tx.c                             | 616 ++++--------------
>   net/mac80211/util.c                           | 162 +++--
>   31 files changed, 534 insertions(+), 824 deletions(-)
>
Trying to get some clarity if this might fix a regression [1] with 
ath10k where upon roaming the TX queue hangs on flush for ~4-10 seconds. 
I was hopeful for another set [2] but it looks like this only effected 
AP mode and with that applied I still notice the behavior.

In the worse case we see two failures, which add up to about 10 seconds 
of delays, more often its just the single "failed to flush transmit queue"

Feb 19 14:15:59 kernel: ath10k_pci 0000:02:00.0: failed to flush sta txq 
(sta 6a:3a:0e:22:45:08 skip 0 ar-state 1): 0
Feb 19 14:16:04 kernel: ath10k_pci 0000:02:00.0: failed to flush 
transmit queue (skip 0 ar-state 1): 0

Crossing my fingers this set will have some positive effect here

[1] 
https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
[2] 
https://lore.kernel.org/linux-wireless/cover.1732293922.git.repk@triplefau.lt/

Thanks,

James


