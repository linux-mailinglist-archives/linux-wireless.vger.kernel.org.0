Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD174E950D
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 03:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfJ3CoG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 22:44:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39418 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfJ3CoG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 22:44:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F044260FB4; Wed, 30 Oct 2019 02:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572403446;
        bh=BHAxwq4hd0GNKQQn1DJMboluBUSn58IkgDvXlYOUIes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mLaudV2JNIS+CfuMGCAAG80UV2zSctCwaiYZua5SVvca/ZqczC3jkS3Gwt+zMbwWN
         zgHaCTthcoD3BWzhSvM/Zhqw/4IbAe3JEERwr6D5M+z0qSvgikpGmuPq5R1iQEDhWg
         GOMqTnYCrlZQncdLLhm6iFGlJ/rVBe87oSvQDZNc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8DEA960DD3;
        Wed, 30 Oct 2019 02:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572403445;
        bh=BHAxwq4hd0GNKQQn1DJMboluBUSn58IkgDvXlYOUIes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ovjdYRZydX5U8JWJh3Xd+BQxwUYdjmDAhQPFoz49C/anhLU9tLMbNQJ3bs+ZV7DZF
         Baf47mbvdl++Zf7humLlL1ZRAi1mw/q/5JCS07dzdBfTat1mXnZnhbiHnsckEMOnc2
         37kYGXsSyaJvVL3jd6DijrA6bzIe7DunKVeWM8ms=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Oct 2019 10:44:05 +0800
From:   zhichen@codeaurora.org
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
In-Reply-To: <CAKR_QVLDFBVMDDP4mPYVNdpT9TA3podNeQMpVJQwE7A5eG=0kA@mail.gmail.com>
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
 <CAKR_QVLDFBVMDDP4mPYVNdpT9TA3podNeQMpVJQwE7A5eG=0kA@mail.gmail.com>
Message-ID: <9bb484b94c43f7c9aa08345ad89d7b2c@codeaurora.org>
X-Sender: zhichen@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-22 18:07, Tom Psyborg wrote:

> What about main and 10x firmware branch?

There is no code changes in firmware. It's a configuration change of 
host memory access.

Zhi
