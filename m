Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A986F7B571F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbjJBQMc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 12:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbjJBQMb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 12:12:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B86A93
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 09:12:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949E4C433C7;
        Mon,  2 Oct 2023 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696263147;
        bh=hCn2OqcTzFqtqEAqQGkyNCHh5hZQMbM6wx1pLBkbcNA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=B/DJbAtO0VNuzlSnWjrblLfUVn6gZ2yvqAk2XsH+Qfn0YI5xvxT3UioDne8Pn7yc4
         8bTtwQnWWcKFj/hD5FEni41XhlTh9j/KpNA7z6DHoEm/uLjb3TDexulo70UeHQbFma
         AcPMQ5YLAWtKEcjL0ZQBk7k563Nyc3T9iC6CXnFr7HTdsbZ2sM08k2aMXSQyI2G/4K
         dorsYkzDJNXtdsvLt610EPoXcY3fzsq5TypDwf9vvep88r1/KOK7NFxMBwDPdNm2ct
         AvvpcPNPCjEeXj3UgpJv7D+ZN2pXLyRu1IGe5gRZCKPopzd5bZBbFkYyatkKt4D1Nx
         R7jERPeZKSAnQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: ath12k: do not drop data frames from unassociated stations
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1689749074-14676-1-git-send-email-quic_haric@quicinc.com>
References: <1689749074-14676-1-git-send-email-quic_haric@quicinc.com>
To:     Hari Chandrakanthan <quic_haric@quicinc.com>
Cc:     <quic_kvalo@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Hari Chandrakanthan <quic_haric@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169626314465.3936351.82532246234260943.kvalo@kernel.org>
Date:   Mon,  2 Oct 2023 16:12:26 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hari Chandrakanthan <quic_haric@quicinc.com> wrote:

> >From 'IEEE Std 802.11-2020 section 11.3.4.1':
> If STA A in an infrastructure BSS receives a Class 2 or Class 3 frame
> from STA B that is not authenticated with STA A
> (i.e., the state for STA B is State 1), STA A shall discard the frame.
> If the frame has an individual address in the Address 1 field,
> the MLME of STA A shall send a Deauthentication frame to STA B.
> 
> When data frames from unassociated stations are received by an AP,
> the AP is supposed to send a deauthentication/disassociation frame with
> reason code "Class 2 frame received from nonauthenticated STA" or
> "Class 3 frame received from nonassociated STA".
> 
> But ath12k AP doesn't send deauthentication/disassociation frames,
> when it receives data frames from unassociated stations.
> 
> The ath12k driver drops the data frames from unassociated
> station and the upper layer(mac80211/hostapd) is not aware of such event.
> Hence deauthentication/disassociation frame is not sent to that
> particular station by the AP.
> 
> To address this issue, allow the data frames from the
> unassociated stations to reach mac80211 so that mac80211 can send
> NL80211_CMD_UNEXPECTED_FRAME event to userspace(hostapd) and hostapd
> upon receiving the event will send the deauthentication/disassociation
> frame with proper reason code.
> 
> The data frame from unassociated stations gets dropped in mac80211.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1e55298a6394 wifi: ath12k: do not drop data frames from unassociated stations

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1689749074-14676-1-git-send-email-quic_haric@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

