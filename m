Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1142DCE91
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgLQJlo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 04:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgLQJln (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 04:41:43 -0500
Date:   Thu, 17 Dec 2020 10:40:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608198062;
        bh=k9VsqX5zgs+qa4UGHl7EKWy6DX64SQa2wvRJvdVKswg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=iv2Ke4P2qqYmxyQVijmbu2ZzpZexfRQJIOvwn4IlpFGLtTQ1PEMSLdx8fKn0MKBLo
         8fREXOwBmRJgzbKOLG1OnjUXM+aJbXJqhAxYGOekwIkRdLb/5GdSOYAStZjn8GE317
         Ttc6mK44FIEBycJ/vofDDnxHYl9oo3EVe00H0Tp5G8/4a22gz43pxfNXpaSJbwqyRN
         AEIbGFMh1PNkwctCZoFjrgPDbbweSmCvnVtvTOa2J7tz5z6ZmKae75sQ8/ObsL0maw
         uoT3bz8otEifilxSo32BF6+wDxzJl07SiL3Qhyn3XYf6WG97xpt0mcYmsp9LR+KX+z
         gNU0zG/C/MZMg==
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/5] ath: Use safer key clearing with key cache entries
Message-ID: <20201217094059.zxyaiskfdypc7q47@pali>
References: <20201214172118.18100-2-jouni@codeaurora.org>
 <20201217065148.188F7C433ED@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217065148.188F7C433ED@smtp.codeaurora.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thursday 17 December 2020 06:51:48 Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> wrote:
> 
> > It is possible for there to be pending frames in TXQs with a reference
> > to the key cache entry that is being deleted. If such a key cache entry
> > is cleared, those pending frame in TXQ might get transmitted without
> > proper encryption. It is safer to leave the previously used key into the
> > key cache in such cases. Instead, only clear the MAC address to prevent
> > RX processing from using this key cache entry.
> > 
> > This is needed in particularly in AP mode where the TXQs cannot be
> > flushed on station disconnection. This change alone may not be able to
> > address all cases where the key cache entry might get reused for other
> > purposes immediately (the key cache entry should be released for reuse
> > only once the TXQs do not have any remaining references to them), but
> > this makes it less likely to get unprotected frames and the more
> > complete changes may end up being significantly more complex.
> > 
> > Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> 
> 5 patches applied to ath-next branch of ath.git, thanks.
> 
> 56c5485c9e44 ath: Use safer key clearing with key cache entries
> 73488cb2fa3b ath9k: Clear key cache explicitly on disabling hardware
> d2d3e36498dd ath: Export ath_hw_keysetmac()
> 144cd24dbc36 ath: Modify ath_key_delete() to not need full key entry
> ca2848022c12 ath9k: Postpone key cache entry deletion for TXQ frames reference it

Hello! Should not these patches be suitable for backporting into stable
kernels (via CC: stable@ commit message line) as they are related to
security issue CVE-2020-3702?
