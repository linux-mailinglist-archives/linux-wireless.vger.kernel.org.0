Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4033A46F952
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 03:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhLJCuq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 21:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhLJCup (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 21:50:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364BC061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 18:47:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D004B82644
        for <linux-wireless@vger.kernel.org>; Fri, 10 Dec 2021 02:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB433C004DD;
        Fri, 10 Dec 2021 02:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639104428;
        bh=h3kRVIWb4+T1yOuMZzsrfBPcunSuv9y36YP/NSEF9Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkM0mDfslWQymBKRJqi/eHNDhuC14LLQL/Te22RnnCUh2OfNgPPSdwNcI20jTEa2O
         9dFgGsJ3zLHyPlBwoM0BBnuwp1aw5DpL0lS/MT+Glz2HxGhz+IYOrWvD5x4G2PK3S5
         yl1LxOKat//v6OrZ8cAm0Glxgr+WnrSqJb/qdZj4ZH9BwQjWRAyAvt0FQIizPBOIfW
         XrKRvF3aNymjkKoCUvyRBPWIPrFjeGjEzk02575u5ytdPMXjNmQ2tGiEuKxGAPKhF5
         IdhTzilIaFNf/Dbz4axFWRJI6Gw6nTLFPdOYUrAtNCCg+lKXrISybtCpbIjSpYyVlz
         oUW6z5x4M2mbg==
Date:   Thu, 9 Dec 2021 20:47:07 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Raise DFS TX power limit to 250 mW (24
 dBm) for the US
Message-ID: <YbK/qyUTu5Mj4nrj@ubuntu-x1>
References: <20211206064520.11305-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211206064520.11305-1-sultan@kerneltoast.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Dec 05, 2021 at 10:45:20PM -0800, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> According to 47 CFR § 15.407(a)(2), the U-NII-2A (5.25-5.35 GHz) and
> U-NII-2C (5.47-5.725 GHz) DFS bands are subject to the following [1]:
> "For the 5.25-5.35 GHz and 5.47-5.725 GHz bands, the maximum conducted
>  output power over the frequency bands of operation shall not exceed
>  the lesser of 250 mW or 11 dBm + 10 log B, where B is the 26 dB
>  emission bandwidth in megahertz."
> 
> As such, increase the TX power limit for the U-NII-2A and U-NII-2C DFS
> bands to 250 mW (24 dBm) to match the FCC's current rules. These power
> limits have remained unchanged since the § 15.407 amendment by the FCC
> in 2014 [2].
> 
> [1] https://www.ecfr.gov/current/title-47/chapter-I/subchapter-A/part-15/subpart-E/section-15.407#p-15.407(a)(2)
> [2] https://www.federalregister.gov/d/2014-09279/p-131
> 
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>

Applied, thanks!
