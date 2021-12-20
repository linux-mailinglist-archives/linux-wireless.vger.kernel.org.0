Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65747B391
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 20:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbhLTTQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 14:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbhLTTQx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 14:16:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C772CC061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 11:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C330612C0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 19:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C642C36AE8;
        Mon, 20 Dec 2021 19:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640027812;
        bh=djGBlpOa14ExbuYSnVcKRoMovI5ZXBZfhMd0+S/onGs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ki+hJNxUfQNhxBGDYFxJxPNm2l+0NKTFMhAIeEaZdQhFhJ+QrAR2yD7CIgZLgiMNQ
         rwIUZpyweZTcAjZdhY5kMfDKgQmT+rC8uPh5GCA/0GMioNbZ722nll5st/+2TY44+C
         n9zhNPqOgej00SpD5L4B2Aq5UDSFQc+Xvz8VkdSljU4PW20AuIsyWwYxFlPlVMONbw
         1n479CDRLYFpNT3tIWuU87Syitl0jBBghFRs77vr3ZStYcourZaVno0Lp+OgHTtGDA
         CFofZY5HplT2GkVc+d0WyOsq8ccakOUHTWFCpDi4KY1PosNobOFv/opdA+Ao2lRh8H
         7go7FAQOG7sTA==
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
Message-ID: <164002780766.16553.11348226804666046524.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 19:16:51 +0000 (UTC)
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

Depends on:

57553c3a6cfe ("mac80211: fix FEC flag in radio tap header")

Currently in mac80211-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1638294648-844-3-git-send-email-quic_ppranees@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

