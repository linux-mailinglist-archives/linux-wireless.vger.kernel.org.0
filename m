Return-Path: <linux-wireless+bounces-24373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79354AE4DE4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 22:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006D4178CE1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 20:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B792D12F4;
	Mon, 23 Jun 2025 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqybAjod"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678A28D8CD
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709325; cv=none; b=tZmHfDip9u1ke1t8sm09D5AYeL4qNZZz3fFh9vp8HUmZzJoAT8bqJ4fXH38Pfw/RMVjIo/ub9A6wrUdPEA+dKVXrzV/WuHsZFylLcpn0aq5YVpKV6eqa681o1bnBUUdyYhr7dilVuowI7DQbUM6VNEEDlwTb7O8YnNA686jRQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709325; c=relaxed/simple;
	bh=gT6AJjP4fwyZYLktCzn4YBpsclFuzv1uhDUZQeQVE/s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rON96wSP4i+vy4crQjIztpU/c9D5KT9wP6t3z5raZWJQwVzBdKr06e11dg2pD6poDzlAECerDiStGBBehIfPP9oXH68E0eRK/76KT8J0Ew6HWsG5i1XFS5uAWaCYO7VcsQiTmyJdXItrKCp41Ap40CSzja3mGUr1gdmfY8gk3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqybAjod; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54700a46eso2592568f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750709322; x=1751314122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7NKVmiUuQV0Dw1Vw6tRW3MAOw4c13j+AOH9euCOJSZU=;
        b=KqybAjodaL16D/jZ+kWGP1f3FdaKIVXK4fq/98rIw6WdnuEB7FPozeXSg28erTkg79
         XUrON/rYuf0H3QDU/czrRjnzyP4wakRp4VL7fmaSeg5Eq+NjCXt9AnyWpE2+9EY8VVbN
         4VfsoeyrFpOO8EbxSbRAGwHebqrYwne0jDGDNmvuwkJf6UyPtmKt9UrZH4+Ip5/tr60O
         peiGqVlSINvLiv/1HXRI+eXmtjVoiwmJi280RMVpSDuBPJkrc/WFvbPnh64VVaYys6cb
         bpEUewLNbpZ8JS0kcFBGDQgbgAJYBo5HBJWRhGPcicElGUDxaw+VcjhJ5hNMHOVilTmS
         s0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750709322; x=1751314122;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NKVmiUuQV0Dw1Vw6tRW3MAOw4c13j+AOH9euCOJSZU=;
        b=HKdmydZKhKKGlIc+lZyypXX9qhCu3R2zPe52xOcPtg8WPXjZHTYkhj5lSn2Iy6e4sX
         BLUvUli7haJh50wlhiCivdwyVXZjhCCifQQGSjaZRHc8Q8kLEfsZGIprg4Y1+WS7dqa9
         z+dRs4uSmRk4CgXOpJlsVspNfr0aj4Jw68V+dmGKCW8BqsjvPtyK26qIUMTFnBBBnfJQ
         A3uTyXh7SbU5GoCDeI+akFK8Efm/t464xg8tcw/jK4NbJUVu4VNcZKXFjHozgY6ronwc
         hMkRwC1Dj8JwStN/Cj1sInxgI9bhYOTohjRUW5WiGennBzkWwQogD0/E6b8FyWN1k/W5
         imLQ==
X-Gm-Message-State: AOJu0YyQ6NQTW/8+jTYetVOqbvoZKBgHj70ZxGDof7zc83B4jxKZYhJc
	J4PtozCCLIH64VnbaqzcKqJxhNSXjhQUDeTzfFM6Owf4ui9uhi5pzzli8mBb/Q==
X-Gm-Gg: ASbGncv8rSWHnh0tgNabxLJMK2CwnMRs99kzI/fes+yAy82/SZQCUvDz2PK6Cy+rDEN
	4JWhTIqwbaEj7GbxaC9luiTnNbYRDHCYXxuL72Xb6iGC+GPizCuwZsHjl9zXbNPQ1W5KUU+/bAs
	gMkpW0/KlUD4cI9vbj2dqDu2DiDIyy2EX36dizyjh0SV5ME6HFottExm3+G9G/c47JLnqRwTBGq
	fgnBINqMOcOZX6whVObD9j0aBpk2a9fiXaEtGEfRAV10KNIsZiCyKaqp6+BHpkSLs8GjylU8aVa
	0sVABlmxiCXNQBWmxSrEssl/0JQXYjDM0nHkln7jybv19FzMPEo0pkmlRd+OcDbMGW7EgQ==
X-Google-Smtp-Source: AGHT+IFtCeUOSrvaVTZYVswtRGFZ6sqyrZ8mTcMhn0DTXbvKhjAbACVgzJHjZldDvUYC0gDB8CoZGA==
X-Received: by 2002:a05:6000:2dc4:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3a6d1322b77mr11426546f8f.34.1750709321930;
        Mon, 23 Jun 2025 13:08:41 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8062e9csm41354f8f.25.2025.06.23.13.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 13:08:41 -0700 (PDT)
Message-ID: <1e5e97d4-8267-4f77-a4bf-1fe23ea40f77@gmail.com>
Date: Mon, 23 Jun 2025 23:08:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v3 12/14] wifi: rtw89: Add usb.{c,h}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
 <4f456355-fdc5-4624-ab00-ed374f3b58a1@gmail.com>
Content-Language: en-US
In-Reply-To: <4f456355-fdc5-4624-ab00-ed374f3b58a1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2025 22:04, Bitterblue Smith wrote:
> Add very basic USB support. No TX/RX aggregation, no TX queues,
Commit 47a498b84f01 ("wifi: rtw89: TX nulldata 0 after scan complete")
exposed a problem with my lazy "no TX queues" approach:

[30316.444515] BUG: KFENCE: use-after-free write in rtw89_core_tx_kick_off_and_wait+0xed/0x1e0 [rtw89_core]
                                                                                     
[30316.444616] Use-after-free write at 0x00000000719224cd (in kfence-#231):
[30316.444623]  rtw89_core_tx_kick_off_and_wait+0xed/0x1e0 [rtw89_core]
[30316.444716]  rtw89_core_scan_complete+0x19b/0x260 [rtw89_core]
[30316.444810]  rtw89_hw_scan_complete_cb+0xbb/0x150 [rtw89_core]
[30316.444906]  rtw89_chanctx_proceed_cb+0x21/0x40 [rtw89_core]
[30316.444988]  rtw89_chanctx_proceed+0x45/0x90 [rtw89_core]
[30316.445067]  rtw89_hw_scan_complete+0x4e/0x70 [rtw89_core]
[30316.445156]  rtw89_mac_c2h_scanofld_rsp+0x33a/0x380 [rtw89_core]
[30316.445241]  rtw89_fw_c2h_cmd_handle+0x89/0x100 [rtw89_core]
[30316.445332]  rtw89_fw_c2h_work+0x3c/0x60 [rtw89_core]
[30316.445412]  cfg80211_wiphy_work+0x110/0x190 [cfg80211]
[30316.445412]  process_one_work+0x190/0x350
[30316.445412]  worker_thread+0x2d7/0x410                                                                                                                                  
[30316.445412]  kthread+0xf9/0x240                                                   
[30316.445412]  ret_from_fork+0x31/0x50                                              
[30316.445412]  ret_from_fork_asm+0x1a/0x30                            
  
[30316.445412] kfence-#231: 0x0000000049346f7c-0x000000006dacad1c, size=232, cache=skbuff_head_cache

[30316.445412] allocated by task 17836 on cpu 0 at 30316.413509s (0.031903s ago):
[30316.445412]  __alloc_skb+0x148/0x1a0
[30316.445412]  __netdev_alloc_skb+0x38/0x190
[30316.445412]  ieee80211_nullfunc_get+0x3f/0x210 [mac80211]
[30316.445412]  rtw89_core_send_nullfunc+0xd2/0x190 [rtw89_core]
[30316.445412]  rtw89_core_scan_complete+0x19b/0x260 [rtw89_core]
[30316.445412]  rtw89_hw_scan_complete_cb+0xbb/0x150 [rtw89_core]
[30316.445412]  rtw89_chanctx_proceed_cb+0x21/0x40 [rtw89_core]
[30316.445412]  rtw89_chanctx_proceed+0x45/0x90 [rtw89_core]
[30316.445412]  rtw89_hw_scan_complete+0x4e/0x70 [rtw89_core]
[30316.445412]  rtw89_mac_c2h_scanofld_rsp+0x33a/0x380 [rtw89_core]
[30316.445412]  rtw89_fw_c2h_cmd_handle+0x89/0x100 [rtw89_core]
[30316.445412]  rtw89_fw_c2h_work+0x3c/0x60 [rtw89_core]
[30316.445412]  cfg80211_wiphy_work+0x110/0x190 [cfg80211]
[30316.445412]  process_one_work+0x190/0x350
[30316.445412]  worker_thread+0x2d7/0x410
[30316.445412]  kthread+0xf9/0x240
[30316.445412]  ret_from_fork+0x31/0x50
[30316.445412]  ret_from_fork_asm+0x1a/0x30

[30316.445412] freed by task 0 on cpu 3 at 30316.413558s (0.031854s ago):
[30316.445412]  ieee80211_tx_status_skb+0x75/0xb0 [mac80211]
[30316.445412]  ieee80211_handle_queued_frames+0x9f/0xd0 [mac80211]
[30316.445412]  tasklet_action_common+0xc5/0x230
[30316.445412]  handle_softirqs+0xe3/0x2a0
[30316.445412]  __irq_exit_rcu+0xcb/0xf0
[30316.445412]  common_interrupt+0x85/0xa0
[30316.445412]  asm_common_interrupt+0x26/0x40
[30316.445412]  cpuidle_enter_state+0xbb/0x410
[30316.445412]  cpuidle_enter+0x31/0x50
[30316.445412]  do_idle+0x1b1/0x210
[30316.445412]  cpu_startup_entry+0x29/0x30
[30316.445412]  start_secondary+0x119/0x140
[30316.445412]  common_startup_64+0x13e/0x141

[30316.445412] CPU: 0 UID: 0 PID: 17836 Comm: kworker/u16:1 Tainted: G           OE       6.15.1-arch1-2 #1 PREEMPT(full)  cd63386364b969355862abafc710704c8116e874
[30316.445412] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[30316.445412] Hardware name: LENOVO 82KR/LNVNB161216, BIOS HBCN18WW 08/27/2021
[30316.445412] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]

rtw89_core_send_nullfunc() calls rtw89_core_tx_write_link().
rtw89_usb_ops_tx_write() transmits the frame immediately and
rtw89_usb_write_port_complete() hands it to
ieee80211_tx_status_irqsafe(). Then rtw89_core_send_nullfunc()
calls rtw89_core_tx_kick_off_and_wait(), but the nullfunc was
already freed by mac80211.

So I will add TX queues in v4.

