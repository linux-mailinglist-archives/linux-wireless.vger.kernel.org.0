Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102652FA880
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407497AbhARSQH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 13:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406556AbhARQzk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 11:55:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55D1621D42;
        Mon, 18 Jan 2021 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610988898;
        bh=TLl6FxwDWKf2Gdil/rHoyuNyg4goiQ+B5jVtaekHe04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IWAqsNy5y09WY6x2CjOU6+Jx3kCxkMSCj1wfnynPuqf7GA6+2PPgQtz6lLfGF0w6Y
         56jx1DReuVi5fpFxiUrPkyyC6WNRpZQldWCVcOn6Uoq6PQuw7agMHzTywdLNQhYG9Q
         tyL3+FZ/GDdgN5D6V3DyQb0RN+aWoKsdpHLgucCr3TVX65Lr6Cy+o7GPPV7HkJugSE
         dkbeZIeICOsXTr0BWf2hmZTaTwLptFKmFDIB4fs5ip6WnFA5Vt4lgXWUaL+KBLxDjW
         KjFWVHrsXMJ5JWIUl/9q1MtOX8L6z8E0TiDij5dNtU6+lconV7kwO1Uck/oeWc+sVf
         IFyHZ1MUuJfag==
Date:   Mon, 18 Jan 2021 08:54:57 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        z.han@gmx.net
Subject: Re: [PATCH] mt7601u: process tx URBs with status EPROTO properly
Message-ID: <20210118085457.44341380@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <72392e8341aa8591c0b9962661a6ca26b1198f32.1610919534.git.lorenzo@kernel.org>
References: <72392e8341aa8591c0b9962661a6ca26b1198f32.1610919534.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 17 Jan 2021 22:46:56 +0100 Lorenzo Bianconi wrote:
> Similar to commit '0e40dbd56d67 ("mt7601u: process URBs in status EPROTO
> properly")', do not process tx URBs if marked with status set to EPROTO.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!
