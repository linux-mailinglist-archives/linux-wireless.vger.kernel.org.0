Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621AB43A470
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 22:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhJYUZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 16:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbhJYUZ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 16:25:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A71DC04641D
        for <linux-wireless@vger.kernel.org>; Mon, 25 Oct 2021 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GpkhE+rafTAix/3cb7phz/iDwq5GT627KOA3yMMtjXk=;
        t=1635192562; x=1636402162; b=b5Pa57uYWElQdDzXxflaYGR8Hbgd9AeXamssE1MW4SxAB5+
        45E2TqkoQA7DyVjJzVQKhwSEzYlL1lINeCC87n/X0GlcVT2C7ZeotDQ6JWIsBSywXIu8yt7puD/VK
        NyFRr6Q0aJHOR1JgZ0WuZdCK211O4ptDcH7SycsRpZ11LxpgQhj+wlZnyz2ZMY54h9snwmkCq6EKR
        nLGKsO925diD8UqrrS/arGEXpodkMdjZrDq0dtP9U+//DZGF0sNqHtInoWhosCuztAeKgCeXeM79X
        MZHbtw24RRnXCkFD+2P0q278WN7rSfBgwrp+IQbTEYPBShWdP0fHTqINUxKSQSWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mf6HW-006qRd-1F;
        Mon, 25 Oct 2021 22:09:18 +0200
Message-ID: <18363bc18538ea9b7e8fe28f4c5595c54f3b93d3.camel@sipsolutions.net>
Subject: Re: [PATCH v5] cfg80211: save power spectral density(psd) of
 regulatory rule
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>,
        Venkateswara Naralasetty <vnaralas@qti.qualcomm.com>
Cc:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong=codeaurora.org@codeaurora.org
Date:   Mon, 25 Oct 2021 22:09:17 +0200
In-Reply-To: <0b05f6e555bcb89c49f56279c077ce63@codeaurora.org>
References: <20210928085211.26186-1-wgong@codeaurora.org>
         <bd649a3d2cf2ea9064d427d633055891@codeaurora.org>
         <cb20427eae96c4551084e4c899618b94@codeaurora.org>
         <2afb1bf6f06cb53f43fe0d354afa4e7c@codeaurora.org>
         <2ed76cff292dcca18326de0407a93821@codeaurora.org>
         <1222384c2bc7d80bf572b65ab17660477bb27300.camel@sipsolutions.net>
         <562080d7fc3b7568811c47a8e8e79156@codeaurora.org>
         <DM8PR02MB8154258563A4F7C805C84B4BE6B59@DM8PR02MB8154.namprd02.prod.outlook.com>
         <0b05f6e555bcb89c49f56279c077ce63@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-10-11 at 15:48 +0800, Wen Gong wrote:
> 
> > IMO, Only power rules and PSD info might vary for AP and STATION. Rest
> > of the rules will remains same right?
> > 
> The freq_range may also be different for AP and STATION.
> and reg_rules number also may also be different for AP and STATION.
> 
> for example:
> SUBORDINATE CLIENT of STANDARD POWER reg rules number 2
> reg rule 1: (5945 - 6425 @ 160) (0, 30) (FLAGS 0) (psd flag 1 EIRP 17 
> dB/MHz)
> reg rule 2: (6525 - 6885 @ 160) (0, 30) (FLAGS 0) (psd flag 1 EIRP 17 
> dB/MHz)
> 
> INDOOR AP reg rules number 1
> reg rule 1: (5945 - 7125 @ 160) (0, 24) (FLAGS 0) (psd flag 0 EIRP 0 
> dB/MHz)

That seems right, but isn't that an orthogonal question?

Here, on this patch, we're discussing what data we should have in the
channel information, and it would seem that if it's different for
AP/client, then we do need both information stored, so that we can cope
with concurrency between AP and client?

If we additionally need to have different data for the regulatory rules
for AP and client, that might mean we need to go back and actually
change the code there *as well*, and then fill in the right fields in
this patch?

Unless somehow we're convinced that for this feature we don't need to
worry about concurrently using AP and client modes?

johannes

