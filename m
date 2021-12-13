Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD4947345F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhLMSxM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 13:53:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38938 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhLMSxL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 13:53:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81753611C9
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 18:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6968C34600;
        Mon, 13 Dec 2021 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639421590;
        bh=D2jv1OqpIFLbDGgQ3xRcI7Opg6Y1Dse6d9xUrEjHzfM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JjH5RO2xeMavoA7dwc4PJo8IkQg0cKLVcIzWyu+baMaQOaQuaI9c95I8GFDf2tyCC
         xmNjQkDaBfj/i2Qy3KzKjSranL0H40H8xy+MQFioNe6vYQ9LkjIgFVCq09Yz762w9x
         euOBZpVc0qK8tWtw9K/q4Zyd8o13mK3Nrd2yl0YQhdyzz4dCSkMZJD5RAtV9kzND3m
         9SgUF8txRks0SLkzs8r3NoV15r0L0FVhEkjR4Iv6KNsrsgUBk9SiloSC42FILCBHgA
         YetPLyNJVrCrpQuxowWSDwqdiygmpliiihD9+U2VJOPUgZVrGEiduAzqBoSDyEsBmO
         7j/AWKhJXth8A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: iwlwifi-next 2021-12-08
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <0ee53b7977ca2cd1c1d5deb100fb9cdbfe2acd0b.camel@coelho.fi>
References: <0ee53b7977ca2cd1c1d5deb100fb9cdbfe2acd0b.camel@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        luca@coelho.fi
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163942158792.6700.2715258543960971487.kvalo@kernel.org>
Date:   Mon, 13 Dec 2021 18:53:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> Hi Kalle,
> 
> Here's my first pull request for v5.17 with the three patchsets I sent
> earlier, plus a few patches to fix small issues introduced when iwlmei
> was merged and a couple of other patches sent by the community some
> time ago that were still pending.
> 
> Otherwise this is all normal development, new features, bugfixes and
> cleanups.  More details about the contents in the tag description.
> 
> Please let me know if there are any issues.
> 
> Cheers,
> Luca.
> 
> 
> The following changes since commit fe6db7eda9306d665f7b8fc3decdb556ec10fb85:
> 
>   iwlwifi: mei: fix linking when tracing is not enabled (2021-12-05 13:55:15 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-12-08
> 
> for you to fetch changes up to 977df8bd5844c9370c26a9477418165b870da27c:
> 
>   iwlwifi: work around reverse dependency on MEI (2021-12-07 20:18:06 +0200)
> 
> ----------------------------------------------------------------
> first set of iwlwifi patches for v5.17
> 
> * A few mei fixes;
> * Some improvements in D3;
> * Support for new FW API commands;
> * Fixes and cleanups in device configurations;
> * Support some new FW API command versions;
> * Fix WGDS revision 3 reading bug;
> * Some firmware debugging improvements;
> * Fixes for in device configuration structures;
> * Improvements in the session protection code;
> * Support SAR GEO Offset Mapping (SGOM) via BIOS;
> * Continued work on the new Bz device family;
> * Some more firmware debugging improvements;
> * Support new FW API version 68;
> * Add some new device IDs;
> * Some other small fixes, clean-ups and improvements.

There's a conflict:

CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mvm/mvm.h

<<<<<<< HEAD
	IWL_MVM_STATUS_STARTING,
=======
	IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
>>>>>>> fb6b74def69548fe5854bf902108ec5e4afa9ef6

I assume both enums should be included and STATUS_STARTING should be first. Do
let me know if I should fix it somehow differently.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/0ee53b7977ca2cd1c1d5deb100fb9cdbfe2acd0b.camel@coelho.fi/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

