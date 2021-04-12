Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A335C709
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 15:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbhDLNJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 09:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241661AbhDLNJb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 09:09:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 828416128A;
        Mon, 12 Apr 2021 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618232954;
        bh=n7Gn2U7BRKssLntMokxlV9Vn+CHpzoAmyemPSQT7UyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFHPahiVexwXMh7MJoXqdnLsHWa3cjIKtmsKPr8hZZUp0AbuHyLetc0biHIeFSqPl
         g4TIbOaquxyfi73MP69pirsO6JHL58RDXni2tNr2y7Jz2VOmVK6551RKVCqbqX5YBt
         1yO/yeIBNe21jThXKQfwEhErOoaKug6TLrIYv+kE=
Date:   Mon, 12 Apr 2021 15:09:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        luca@coelho.fi, Ayala Beker <ayala.beker@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: Re: [PATCH RESEND 3/3] iwlwifi: integrate with iwlmei
Message-ID: <YHRGd5JfFeRZCwLY@kroah.com>
References: <20210412124328.24472-1-emmanuel.grumbach@intel.com>
 <20210412124328.24472-3-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412124328.24472-3-emmanuel.grumbach@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Apr 12, 2021 at 03:43:28PM +0300, Emmanuel Grumbach wrote:
> This allows to cooperate with iwlmei.

This changelog text says nothing that helps anyone reading this patch :(

