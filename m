Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF133159994
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 20:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgBKTSw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 14:18:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731593AbgBKTSw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 14:18:52 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E682465D;
        Tue, 11 Feb 2020 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581448731;
        bh=uxU2G69SlfJsblD0NM3KbWn/+UtaxJOgDCSgqIzYh04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xzKBNkpl06kgI1nz698PoytpM9DVyZsB3TDwC6A9ilwBwLfMNS0dgdGor3VgWckZ0
         9cdFGx7UUPKhRBtmYA6QwZFAI6BV2vhUMxICya7dntPcdQMnS4ohGZNzlPACdzhpD0
         1/m8Wa/GM3u7/nChU7c/CjJfR3+JMNuNu6OL8dSY=
Date:   Tue, 11 Feb 2020 11:18:51 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        johannes@sipsolutions.net, Adham.Abozaeid@microchip.com
Subject: Re: [PATCH v2 3/3] staging: wilc1000: refactor p2p action frames
 handling API's
Message-ID: <20200211191851.GA1959566@kroah.com>
References: <20200211152802.6096-1-ajay.kathat@microchip.com>
 <20200211152802.6096-3-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200211152802.6096-3-ajay.kathat@microchip.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Feb 11, 2020 at 09:57:10AM +0000, Ajay.Kathat@microchip.com wrote:
> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Refactor handling of P2P specific action frames. Make use of 'struct' to
> handle the P2P frames instead of manipulating using 'buf' pointer.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  v2: corrected 'while' condition by adding 'struct' size as suggested by Dan.

This patch doesn't apply to my tree :(

