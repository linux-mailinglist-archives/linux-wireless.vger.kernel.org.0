Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE52E6C13
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 00:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgL1Wzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 17:55:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbgL1Vgh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 16:36:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 654B621534;
        Mon, 28 Dec 2020 21:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609191356;
        bh=cSBDGSP6FgpH1UoPftfq170jJFZeOPIfbYYbyZdtnPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHO9bQFe8adqLA5kdp3klz2yQFoyoBojEU16OmJIr9u7PIPrJ0fPFdZ6vHyGQ/P0j
         xfhk+NFwEhiqwuuueMdsagNywsFs8FC+MC5OETdRBkSXLn7e+oZ6rtsyhAJJGlLYc1
         vbpcJGs4SlQ6qPHFQJj36/Kj3sYWJuE82nkFOEislXl4jRvFZ3u0/nFOxSbVXizMLi
         1HgUbBZ+4wA4Okwqpstdh7vyQ1d85p/gc86x2OuaEEYMMYItA35lYiScnZKw/nBr0q
         8QEOMec5+WkD8McasAMdaCCcPWnEx4Q1QA+k25p2an027cg4EHjyMAOsBTgY3dp0+k
         jLHSEBSG6jwig==
Received: by pali.im (Postfix)
        id EF7AAE24; Mon, 28 Dec 2020 22:35:53 +0100 (CET)
Date:   Mon, 28 Dec 2020 22:35:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/5] ath: Use safer key clearing with key cache entries
Message-ID: <20201228213553.rsc5ahiiqrb5lel2@pali>
References: <20201214172118.18100-2-jouni@codeaurora.org>
 <20201217065148.188F7C433ED@smtp.codeaurora.org>
 <20201217094059.zxyaiskfdypc7q47@pali>
 <871rfoto1o.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rfoto1o.fsf@codeaurora.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thursday 17 December 2020 18:06:27 Kalle Valo wrote:
> Pali Rohár <pali@kernel.org> writes:
> 
> > On Thursday 17 December 2020 06:51:48 Kalle Valo wrote:
> >> Jouni Malinen <jouni@codeaurora.org> wrote:
> >> 
> >> > It is possible for there to be pending frames in TXQs with a reference
> >> > to the key cache entry that is being deleted. If such a key cache entry
> >> > is cleared, those pending frame in TXQ might get transmitted without
> >> > proper encryption. It is safer to leave the previously used key into the
> >> > key cache in such cases. Instead, only clear the MAC address to prevent
> >> > RX processing from using this key cache entry.
> >> > 
> >> > This is needed in particularly in AP mode where the TXQs cannot be
> >> > flushed on station disconnection. This change alone may not be able to
> >> > address all cases where the key cache entry might get reused for other
> >> > purposes immediately (the key cache entry should be released for reuse
> >> > only once the TXQs do not have any remaining references to them), but
> >> > this makes it less likely to get unprotected frames and the more
> >> > complete changes may end up being significantly more complex.
> >> > 
> >> > Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> >> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> >> 
> >> 5 patches applied to ath-next branch of ath.git, thanks.
> >> 
> >> 56c5485c9e44 ath: Use safer key clearing with key cache entries
> >> 73488cb2fa3b ath9k: Clear key cache explicitly on disabling hardware
> >> d2d3e36498dd ath: Export ath_hw_keysetmac()
> >> 144cd24dbc36 ath: Modify ath_key_delete() to not need full key entry
> >> ca2848022c12 ath9k: Postpone key cache entry deletion for TXQ frames reference it
> >
> > Hello! Should not these patches be suitable for backporting into stable
> > kernels (via CC: stable@ commit message line) as they are related to
> > security issue CVE-2020-3702?
> 
> Yeah, but you were just a little late as I already applied them.

Ok, would you then send these patches to stable manually?

> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
