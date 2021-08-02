Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820AE3DD122
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 09:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhHBH3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 03:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232428AbhHBH3W (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 03:29:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACDD060EE8;
        Mon,  2 Aug 2021 07:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627889353;
        bh=2EumVAJzpns8NjgPCLEcuqU/wSsimGFknCM/xyfSFJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m63lA9JJ+cpMaBg4kd0gcPWennnDrkbInOoZaD0YTF3JK4ZBjrcvj9J7xcJSfFkyY
         9CK0kf7CGsAglVXKgyT6Xd1IAkG4Foc9zrmUuGOI2KxEYEb1vHY8zP9tEz1Mn0RFo2
         TkygQeRAW8fMPGqcELSbjOZMzLdTtuinrwMtq7us=
Date:   Mon, 2 Aug 2021 09:29:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Batista <batistaw082@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        trivial@kernel.org, William Batista <bootlegbilly@protonmail.ch>
Subject: Re: [PATCH] iwlwifi: renamed all occurrences of IWL_RATE_COUNT to
 IWL_RATE_INDEX_COUNT
Message-ID: <YQeex+bpU6zbVXj5@kroah.com>
References: <20210801191822.152193-1-bootlegbilly@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801191822.152193-1-bootlegbilly@protonmail.ch>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Aug 01, 2021 at 03:18:22PM -0400, William Batista wrote:
> A FIXME requested to eventaully rename IWL_RATE_COUNT to
> IWL_RATE_INDEX_COUNT, as it's a more appropriate name.
> 
> Signed-off-by: William Batista <bootlegbilly@protonmail.ch>

This address does not match your "From:" address :(

>  drivers/net/wireless/intel/iwlwifi/dvm/lib.c  |  2 +-

<snip>

These files have nothing to do with me.

Perhaps you should get experience with working with the files in
drivers/staging/* first, before trying to work on other portions of the
kernel that are more strict with their development rules.

good luck!

greg k-h
