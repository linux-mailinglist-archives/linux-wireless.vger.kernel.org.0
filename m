Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828FF46F26A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 18:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhLIRtP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 12:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhLIRtP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 12:49:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51256C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 09:45:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D2AECE2778
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 17:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1279EC004DD;
        Thu,  9 Dec 2021 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639071937;
        bh=sOPG7Ro7hQwxUmAvR3WADdiFHvMn+PUc1oXzint7T88=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iGU1nInaquYuRSEM4IC5BZ8v+huPpxrbID07wnZplb62gzKxnakGUgkA4lhFI5VXp
         uzE8xZseVa3fcIV7m6lY006ssTsOwSr/2WqPS+k0tEyA1ryhga96ohBlzMWd26Ri2e
         mlFPmCN6gJJUQDnmLVU8n395fhS47pvtmVRmKp9l660oNMwcDDkDo9OAmzo53mQY2S
         eTuywR7UTF/4AVTZ6Xxmjf/S6UOfLZ/GL3Uz4Rkf5wuIZDgLtkCTMmal92Roh9IvoM
         bG/JF2e0hxeOU6QyVpyxgZhxATvk0EH3r9aTfOFDkBrZwwEjSQXzOg7vnvrzGlLC1d
         Bx9PStn/z6h1g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/6] ath11k: support WoW functionalities
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
Date:   Thu, 09 Dec 2021 19:45:35 +0200
In-Reply-To: <20211011193750.4891-1-cjhuang@codeaurora.org> (Carl Huang's
        message of "Mon, 11 Oct 2021 15:37:44 -0400")
Message-ID: <87h7bhvfi8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> writes:

> Ath11k WoW basic funtionalities are merged from ath10k such
> as magic-pattern, PNO, disconnect and patterns.
>
> Hw data filter and pktlog purge are required for ath11k.
>
> ARP and NS offload, GTK rekey offload are new WoW features
> implemented on ath11k. 

Had few minor comments, but this looked good. Next time remember to use
ath.git master branch as the baseline and use --base, makes it easier
for me to apply the patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
