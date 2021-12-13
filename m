Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE455472630
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 10:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhLMJt0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 04:49:26 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38038 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbhLMJpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 04:45:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28CEDCE0E92
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 09:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91873C341DE;
        Mon, 13 Dec 2021 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639388707;
        bh=xJvuX1HROiNhGGrUSLW+EepdAVSlVCN2hxtVw4012Bg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gn1RdBxBkNImL9DTiE1HFOVB5yxAWzWAyXFx1/EPiD8fcN9W2Jev5Rn172j8hvC68
         0stWDkEdo+hRePg/nmZBVc2ghwpzry5s5WeOUj6uxTlaBwE9OFQHSRgnMrgm5pNXni
         TmMVFcJuFMvbr6/Iec+o+aPeo3VY04qyeuGfhR1MdbQpeE+HYZ7VdztvFWuhsQfsWI
         pD81iAQ6xzgyzwzww3TaBnKEbjhBLpmFuUHHq+YR6iOqdFCKh2ve/VdkEfctlUBs5M
         VOB9OFxDr0hgRCBswl47JvFFfkY3iL/ZqPoopJP4yxCGF9G9uu/XtNicykZVE5ddE5
         2rmmQqd5wuvQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath10k: htt: remove array of flexible structures
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211209091545.6098-1-kvalo@kernel.org>
References: <20211209091545.6098-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163938870083.20609.3005949856683385332.kvalo@kernel.org>
Date:   Mon, 13 Dec 2021 09:45:06 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> I updated to sparse v0.6.4 and it warns:
> 
> drivers/net/wireless/ath/ath10k/hw.c: note: in included file (through drivers/net/wireless/ath/ath10k/core.h):
> drivers/net/wireless/ath/ath10k/htt.h:1503:41: warning: array of flexible structures
> drivers/net/wireless/ath/ath10k/htt_rx.c: note: in included file (through drivers/net/wireless/ath/ath10k/core.h):
> drivers/net/wireless/ath/ath10k/htt.h:1503:41: warning: array of flexible structures
> 
> The structure is unused in ath10k so let's just remove it.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

56789eef894c ath10k: htt: remove array of flexible structures
5341d57bc398 ath10k: wmi: remove array of flexible structures

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211209091545.6098-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

