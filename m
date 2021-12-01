Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32875464DCC
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 13:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbhLAMZI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 07:25:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34346 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244101AbhLAMZE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 07:25:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD768B81EA9
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 12:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FDEC53FAD;
        Wed,  1 Dec 2021 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638361301;
        bh=JD+kuOA/+e5Q7h5zj3NbPewnDHMTSdASKuYbvNU4qI8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=obkhwRwSwb1e+mkAE7qkyAi4XthL4wHtGG9eZ2KwRNk20MeVlkiNzcFRddUHcOmw6
         oIBl/lvWjAZROaD321ruvCM7K12O/DHl8R2He/5zHz8T4jx0a0U7WS59gvVfK1x1rz
         QbrYM3AtXfXukT14sYNuTuCkdD64UwEHVLSBcFxB3yTcZmgSPyC8ovLeHxhA0bP1/5
         91sE1pNiHzFgLvmck0pTKQnL9JxiU28kyNa2i0Mo+Qlwc6BPSP2J7hIKLBH/FCGMql
         OvJUQVKdxAVuO9RHdqGm8UO9xhLQhtuPWywam51HEKQAlONjEA2GkctDtHB+esyWjo
         dVga7KYO45p9g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] iwlwifi: mei: fix linking when tracing is not enabled
In-Reply-To: <20211201113411.130409-1-emmanuel.grumbach@intel.com> (Emmanuel
        Grumbach's message of "Wed, 1 Dec 2021 13:34:10 +0200")
References: <20211201113411.130409-1-emmanuel.grumbach@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 01 Dec 2021 14:21:38 +0200
Message-ID: <87fsrco6r1.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:

> I forgot to add stubs in case tracing is disabled.
>
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Fixes tag? I can add that.

Luca, as this fixes a build problem I think I should take this directly
to wireless-drivers-next. Ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
