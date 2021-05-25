Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E15638FB7A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 09:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhEYHNN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 03:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231501AbhEYHNL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 03:13:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25CCF61284;
        Tue, 25 May 2021 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621926701;
        bh=eKM1nDPZFDHCNaNAhGa1uHAlTnXmbQ+Hzs6P7pjqfLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2aMT+YjPFm3cNA3qNYjcnPT7OvlQZRI84IrgMr2w55ydLvK5DthlVrss4MwOpT3+W
         JAP/ZSxDVoMa4ys8OheHrJnaO5iWRoHiuhxzUbu5F4OuGzMNQf0CDjXms5GJDKCyL1
         IXKVyuZ8JYRcf+QQH8RzlhjzoWFNf823uDegfhS0=
Date:   Tue, 25 May 2021 09:11:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 39/52] brcmfmac: properly check for bus
 register errors
Message-ID: <YKyjKzNZby0xg5hw@kroah.com>
References: <20210524144903.2498518-1-sashal@kernel.org>
 <20210524144903.2498518-39-sashal@kernel.org>
 <437445ee-a360-597f-f058-3b913984e064@broadcom.com>
 <YKycgrI+zh4seh7U@kroah.com>
 <81b5dc11-4dfe-76d6-f822-0adcfb3a9e30@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b5dc11-4dfe-76d6-f822-0adcfb3a9e30@broadcom.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 25, 2021 at 09:04:59AM +0200, Arend Van Spriel wrote:
> -- 
> This electronic communication and the information and any files transmitted
> with it, or attached to it, are confidential and are intended solely for the
> use of the individual or entity to whom it is addressed and may contain
> information that is confidential, legally privileged, protected by privacy
> laws, or otherwise restricted from disclosure to anyone else. If you are not
> the intended recipient or the person responsible for delivering the e-mail
> to the intended recipient, you are hereby notified that any use, copying,
> distributing, dissemination, forwarding, printing, or copying of this e-mail
> is strictly prohibited. If you received this e-mail in error, please return
> the e-mail to the sender, delete it from your computer, and destroy any
> printed copy of it.

Now deleted.

