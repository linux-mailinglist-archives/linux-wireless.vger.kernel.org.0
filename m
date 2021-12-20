Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D898E47B2D7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 19:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhLTS3P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 13:29:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46946 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhLTS3O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 13:29:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2DAFB8105D
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 18:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92642C36AEB;
        Mon, 20 Dec 2021 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640024951;
        bh=x2D/e90keyKyOypZN4KNCx5gAdnARqtaazKowqro98s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UnT1M3PF0TIz/nGR2rFLD5qHlqEFIw74L63SX7NuimIvbsQMW9MMIuRj6X9TDhcx0
         SIAdOTfgrS9OHZ2RE+32+VoUofHiEJ90LCfRLMkndi77+PZNBXcJ6V0wK+Y9q+ma6j
         xrRy98TEIAoOWDWAxgfxHkCgrIeRn7Zth1BrchNYOnMNlcwaCdJy0ju//94ZByFUlN
         +Ho0x1+/0nUIAYckpXxzBTYO3ncrmEN1f4RylwX3d/buS4A+B1clnTE1RdjtHZ6Pby
         pDRIOQqaZeWt37j/HaR1jx4KjX/5VxAgmBzjN/YLMqxY4beYh8k9jl+KoLgyaUGGa8
         MQrL+6xq8JBNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: report tx bitrate for iw wlan station dump
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211217093722.5739-1-quic_wgong@quicinc.com>
References: <20211217093722.5739-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164002494893.8180.8615133352100294578.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 18:29:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> HTT_T2H_MSG_TYPE_PPDU_STATS_IND is a message which include the ppdu
> info, currently it is not report from firmware for ath11k, then the
> tx bitrate of "iw wlan0 station dump" always show an invalid value
> "tx bitrate: 6.0 MBit/s".
> 
> To address the issue, this is to parse the info of tx complete report
> from firmware and indicate the tx rate to mac80211.
> 
> After that, "iw wlan0 station dump" show the correct tx bit rate such
> as:
> tx bitrate: 78.0 MBit/s MCS 12
> tx bitrate: 144.4 MBit/s VHT-MCS 7 short GI VHT-NSS 2
> tx bitrate: 286.7 MBit/s HE-MCS 11 HE-NSS 2 HE-GI 0 HE-DCM 0
> tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1b8bb94c0612 ath11k: report tx bitrate for iw wlan station dump

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211217093722.5739-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

