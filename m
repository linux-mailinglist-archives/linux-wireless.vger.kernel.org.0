Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D071DFE99
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgEXLYt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 07:24:49 -0400
Received: from mx4.wp.pl ([212.77.101.11]:30796 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgEXLYt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 07:24:49 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 May 2020 07:24:48 EDT
Received: (wp-smtpd smtp.wp.pl 26069 invoked from network); 24 May 2020 13:18:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1590319086; bh=s2VlNdm/ezPLu7iqut4tcP52g6smr1pv+Z1FEsLhZnI=;
          h=From:To:Cc:Subject;
          b=DkrMgsOTu+yJ3UgdU1/8MaW42lUrKqUzeWAJfMoQ233dkjVenrOnDmutjeaXaVwSc
           ocE30CM0vI4cuB8M11etaUFv815P56V52YQow7QyLsnu67tTqdpJ/ZWpa/Y8Utwk+u
           Q7D8KjCJIsks1LKk1FkSLlsQlvzUDMiIZS/jZXvE=
Received: from unknown (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rsalvaterra@gmail.com>; 24 May 2020 13:18:06 +0200
Date:   Sun, 24 May 2020 13:17:51 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     kvalo@codeaurora.org, Larry.Finger@lwfinger.net,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
Message-ID: <20200524111751.GA914918@wp.pl>
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524094730.2684-1-rsalvaterra@gmail.com>
X-WP-MailID: 52ad4cd0aee7d5ff349556358338b65a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MbN0]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, May 24, 2020 at 10:47:31AM +0100, Rui Salvaterra wrote:
> According to Larry [1] (and successfully verified on b43) mac80211
> transparently falls back to software for unsupported hardware cyphers. Thus,
> there's no reason for not unconditionally enabling MFP. This gives us WPA3
> support out of the box, without having to manually disable hardware crypto.
> 
> Tested on an RT2790-based Wi-Fi card.
> 
> [1] https://lore.kernel.org/linux-wireless/8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net/

AFICT more work need to be done to support MFP by HW encryption properly
on rt2x00. See this message and whole thread:
https://lore.kernel.org/linux-wireless/977a3cf4-3ec5-4aaa-b3d4-eea2e8593652@nbd.name/

Stanislaw
