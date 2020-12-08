Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25E12D2F19
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 17:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgLHQGl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 11:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730404AbgLHQGl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 11:06:41 -0500
Date:   Tue, 8 Dec 2020 08:05:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607443561;
        bh=UsewWu3e2NfYdT6uee3XETg2KYTQq+/9pCyRHYRdTxA=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=nFDSbgThFprIC1gJKB/dVP414BflwzHxLrFqIL718b6SA5hMRdZAYNYPtIL/+Fuy1
         UhKGtgox5vJgGwP3DrzrhQY4f7espsXnxt8Co3FhN0kCffh2ttQhSDJHFZ5dKqHMF8
         nn2oCq4HEOF+xuXWSXSicSDSUAx3bH4B4toFdOOoxR0B5Q2a2eDQnra8j/fLk7U9W6
         P9BwVNFt3KkVVWhFtatcQPR1xa218S6o3zkJWO5/Adl6K7/PgalbQ2u0pEWb6bCA/A
         tl9+6eL61R5hQIZMtUPDktZYCzS5nt+HDHZiT95pFEnUFs9bPE9K/SYbydwqpnOBtO
         MkdaUOsoi5/CA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     luciano.coelho@intel.com, johannes.berg@intel.com,
        mordechay.goodstein@intel.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxwifi@intel.com
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
Message-ID: <20201208080559.6131e8da@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 8 Dec 2020 11:27:50 +0000 Rui Salvaterra wrote:
> Hi, everyone,
> 
> I'm running Linux 5.10-rc7 with this firmware/hardware:
> 
> [    1.431878] iwlwifi 0000:02:00.0: loaded firmware version
> 29.198743027.0 7265D-29.ucode op_mode iwlmvm
> [    1.431899] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band
> Wireless AC 3165, REV=0x210
> 
> Most of the time, after disabling/enabling Wi-Fi (or, say, rebooting
> the router), the card dies and only comes back after reboot. This is
> the relevant dmesg output:

Just to confirm - is this a regression in 5.10-rc? Does 5.9 work
smoothly in the problematic scenario?
