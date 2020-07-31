Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60C234C53
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgGaUbn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 16:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgGaUbn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 16:31:43 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C24242087C;
        Fri, 31 Jul 2020 20:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596227503;
        bh=pD3jNcmOWktiyQVUN0PpMKyCE1vag4hIA96oczwCKbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WFJ4ENaFnRtkdMD6lhFQVd4W9l4fXi0gDB+tp/GycXox16R+NuIUkWF5rKvmuEHbD
         /zJoic0DDqyezvnq2NzLZMXYi5d9LFRw3IenykNtJcpQilacnTcx4HQBF3mF0hX1Qo
         AS/Vjmc65q/XKvF4yW4iLnPMqTmGF5HaTdcqqjHo=
Date:   Fri, 31 Jul 2020 13:31:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/3]
Message-ID: <20200731133141.68d7ad81@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1596220042-2778-1-git-send-email-pillair@codeaurora.org>
References: <1596220042-2778-1-git-send-email-pillair@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 31 Jul 2020 23:57:19 +0530 Rakesh Pillai wrote:
> The history recording will be compiled only if
> ATH10K_DEBUG is enabled, and also enabled via
> the module parameter. Once the history recording
> is enabled via module parameter, it can be enabled
> or disabled runtime via debugfs.

Have you seen the trace_devlink_hwmsg() interface?
Could it be used here?
