Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5112F46BCEF
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhLGNw5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 08:52:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:33422 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbhLGNw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 08:52:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39643CE1ABB
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 13:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A96C341C3;
        Tue,  7 Dec 2021 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638884963;
        bh=V8VoBJxYId+sKBjS5PF5NdRKMMlwLuxNpsGZ+XpfvIk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ALsWLY/mrBJtg/3wcN336mB8IUbHkcafF+hr2WJm56bd/LG6XkiiT6AvxhiwkCdrz
         0tWySHpP75mPLFdRRbdgD1Gq+fJIGwCQPKYaDsFdSjMHLijW6WYkJ+wM5K4pgPKINB
         QxWg703dZwlkGP9M9Mv/67AWp/YpfuX1YuWLZ/4iMVm5LqDH9VR+tQHLhTEjAhHl6e
         H+n8GPgQzsnABc5ZE63DMM61fkvtuLJ7B4wnVczAaoLFNdPwk3gc97RyYkh4CQgX3u
         EXHnlkhQOIhXEQQOxycj+VjFbb86snIqN4lerI+aaeud6l8conD95Nf3IsXOSX+crv
         HRt48GND9Zg+Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/12] iwlwifi: updates intended for v5.16 2021-12-04 part 1
References: <20211204063555.769822-1-luca@coelho.fi>
Date:   Tue, 07 Dec 2021 15:49:21 +0200
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi> (Luca Coelho's message
        of "Sat, 4 Dec 2021 08:35:43 +0200")
Message-ID: <875ys0tti6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> From: Luca Coelho <luciano.coelho@intel.com>
>
> Hi,
>
> Here's the first set of patches intended for v5.17.  It's the usual
> development, new features, cleanups and bugfixes.
>
> The changes are:
>
> * Some improvements in D3;
> * Support for new FW API commands;
> * Fixes and cleanups in device configurations;
> * Some other small fixes, clean-ups and improvements.
>
> As usual, I'm pushing this to a pending branch, for kbuild bot, and
> will send a pull-request later.
>
> Please review.

BTW, I switched my email to kvalo@kernel.org. Please update your address
book.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
