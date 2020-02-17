Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544F716138D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2020 14:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgBQNbx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Feb 2020 08:31:53 -0500
Received: from nbd.name ([46.4.11.11]:39202 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728614AbgBQNbx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Feb 2020 08:31:53 -0500
Received: from [2a04:4540:1402:1700:ea7:b5ad:8453:f004]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1j3gV6-0006Jp-1j; Mon, 17 Feb 2020 14:31:52 +0100
Subject: Re: [RFC 0/2] add 802.11 decapsulation offload support
To:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1581942277-585-1-git-send-email-mpubbise@codeaurora.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <eb504840-dd76-5278-e2ac-973548f31ba0@phrozen.org>
Date:   Mon, 17 Feb 2020 14:31:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1581942277-585-1-git-send-email-mpubbise@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17/02/2020 13:24, Manikanta Pubbisetty wrote:
> Adding support for offloading 802.11 decapsulation to the HW.
> This reduces the CPU cycles spent on host CPU for doing the
> conversion from 802.11 format to ethernet format and thereby
> improving the performance of the device.
> 
> Note:
> Ath11k patch in this patchset depends on PN offload series
> and the multi reo patchset with the following name.
> "Support hash based reo destination ring selection"
> 

Hi,
you need to also Cc: this to linux-wireless
	John


> Manikanta Pubbisetty (2):
>    mac80211: add receive path for ethernet frame format
>    ath11k: add rx hw 802.11 decapsulation offloading support
> 
>   drivers/net/wireless/ath/ath11k/core.c     |   4 +
>   drivers/net/wireless/ath/ath11k/core.h     |   3 +
>   drivers/net/wireless/ath/ath11k/dp_rx.c    | 184 ++++++++++++++----------
>   drivers/net/wireless/ath/ath11k/hal_desc.h |   2 +
>   drivers/net/wireless/ath/ath11k/mac.c      |  21 +++
>   include/net/mac80211.h                     |  20 +++
>   net/mac80211/rx.c                          | 215 ++++++++++++++++++++++++++++-
>   7 files changed, 370 insertions(+), 79 deletions(-)
> 

