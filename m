Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032E147B41C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 20:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhLTT7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 14:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhLTT7V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 14:59:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CE8C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XhRlgf2a5CbbiRyXO8oZczbzc5/ynnvuggu4+2QxDG4=;
        t=1640030360; x=1641239960; b=AOWn5UoDqJ5NjbisgjktqVlKkOchyXDre+iEUznAqpiCRrf
        Mhuk4RB+1922GyPxtRWqMkuO2LysSXgAFAtv5ZfTpsaUdwrgKDWZl/3fYlxnfQMfWw7iOgzp98/U1
        tA8WhOO+GzxtdU9Qa++lKUim08sAEi4mxFu4TKvDBTp9a1FpPRYSo5zhECCIt3TC/pamaZKBXLgWN
        z8WJI1/oNmmDztm2N6z0mawcAxpmLs5Mp65rVGtut0EaECloVlC924zY9Xh1XXTfHHb5DC5rYTjZQ
        +A2f5IbwdFj++EFv3UAVPAkXLehTFIUdjfd9EJ7uoH5fIwxZFkNgHZeV0tg+wJDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mzOoQ-00EFC2-B4;
        Mon, 20 Dec 2021 20:59:10 +0100
Message-ID: <534d1f71596289581e9229c3087e2ac2f7528ebe.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] ath11k: add LDPC FEC type in 802.11 radiotap header
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Mon, 20 Dec 2021 20:59:09 +0100
In-Reply-To: <164002780766.16553.11348226804666046524.kvalo@kernel.org>
References: <1638294648-844-3-git-send-email-quic_ppranees@quicinc.com>
         <164002780766.16553.11348226804666046524.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-12-20 at 19:16 +0000, Kalle Valo wrote:
> P Praneesh <quic_ppranees@quicinc.com> wrote:
> 
> > LDPC is one the FEC type advertised in msdu_start info2 for HT packet
> > type. Hence, add hardware specific callback for fetching LDPC
> > support from msdu start and enable RX_ENC_FLAG_LDPC flag while passing
> > rx status to mac80211.
> > 
> > Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01467-QCAHKSWPL_SILICONZ-1
> > 
> > Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> 
> Depends on:
> 
> 57553c3a6cfe ("mac80211: fix FEC flag in radio tap header")
> 

Technically, you could apply it, it just won't be very useful until you
have both together.

johannes
