Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4D38199A
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhEOPl7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 11:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232851AbhEOPl6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 11:41:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6786B61354;
        Sat, 15 May 2021 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621093245;
        bh=dQ1SJh6hGrnq3kLlKwCfWZn04NtjLrS8kVEH2OfiO+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PaLnOVw3V0nNIhSK1p1p1Lv8fDs69d4Wl5Jfo7BfcL4VE8+oXBrP+IFK25w3EA6b0
         DAMDqq5gMwUfx0+08eF2BK/C+Rtnjg1eLlZ1hkxG9QXt2a4zOHSLKdtAa4pbU86K1q
         mXLwJa4FTndVTcgTUzxvlyEw6GDPCCBFigwvYuPEUwf6ezUfzQzmmf2y6kHrnEhrex
         3t6YYEBqaLXw4ICVrDN7iq8+THOFrn8xA69RF7/QClkicsFXhj/SjUAw0ljjmLRxhH
         QAs3xzsF/ovmnN7Y/vhvBEnuLFeJt8yy+Z9IINo/XYYwE24hJS/L7WYX6wLy1B7cQm
         371QxRSzanw+w==
Received: by pali.im (Postfix)
        id 09D7AA3B; Sat, 15 May 2021 17:40:42 +0200 (CEST)
Date:   Sat, 15 May 2021 17:40:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dave Olsthoorn <dave@bewaar.me>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: mwifiex firmware crash (Was: Re: [PATCH 5.13] mwifiex: bring down
 link before deleting interface)
Message-ID: <20210515154042.mscvvyfapuvwdgzy@pali>
References: <20210515024227.2159311-1-briannorris@chromium.org>
 <713286ddc100bd63a9dbefdece39c935@bewaar.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713286ddc100bd63a9dbefdece39c935@bewaar.me>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Saturday 15 May 2021 17:10:31 Dave Olsthoorn wrote:
> The firmware still seems to crash quicker than previously, but that's a
> unrelated problem.

Hello! Do you have some more details (or links) about mentioned firmware crash?
