Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B46F48BF81
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 09:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351404AbiALIHC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 03:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351406AbiALIHA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 03:07:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90173C06173F
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 00:07:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF0BF6130D
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 08:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42148C36AE9;
        Wed, 12 Jan 2022 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641974819;
        bh=4tO9NzgmMk/Plk8GSck3d0toWnZ2wKiRlJW3h+gPbp4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Sb/6m0A9eixBUYaCEL7Bsn2lzkE8pDTZv5VCu8fSk0NfUz6GNzz5j5Z2n+s1kv6t8
         vtSw/+H8sUdC0ZfnGvFqnp0GUoR+GFaVYSlCVxofaBEZ2H+cC5BT2Ahu8za0QTvhUa
         bgtmp2ugee+MDp4zyin9Pgi+4okuc9MN7v200h4uzWs8FPZSEeqNqgBpYABsz/o8rx
         sHI6PPM2rb+fwxml+++PHt/VnsVDP1/8PaWQtZLE0MAafIrtqVoItX9n6Ajs4quH27
         48xjOafd6f1zhewMY8VwoEAYjKJYIX0XgTZROBgWXN1PhSmBdUG3Qsx7KDJIlzEe8l
         liBOYfvzEbBcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath11k: add LDPC FEC type in 802.11 radiotap header
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1638294648-844-3-git-send-email-quic_ppranees@quicinc.com>
References: <1638294648-844-3-git-send-email-quic_ppranees@quicinc.com>
To:     P Praneesh <quic_ppranees@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164197478449.14338.8479462708097638703.kvalo@kernel.org>
Date:   Wed, 12 Jan 2022 08:06:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P Praneesh <quic_ppranees@quicinc.com> wrote:

> LDPC is one the FEC type advertised in msdu_start info2 for HT packet
> type. Hence, add hardware specific callback for fetching LDPC
> support from msdu start and enable RX_ENC_FLAG_LDPC flag while passing
> rx status to mac80211.
> 
> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b3febdccde3e ath11k: add LDPC FEC type in 802.11 radiotap header

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1638294648-844-3-git-send-email-quic_ppranees@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

