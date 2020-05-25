Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C861C1E0898
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 10:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgEYIRr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 04:17:47 -0400
Received: from mx4.wp.pl ([212.77.101.12]:54662 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgEYIRq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 04:17:46 -0400
Received: (wp-smtpd smtp.wp.pl 10691 invoked from network); 25 May 2020 10:17:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1590394664; bh=7ctD4JdugRUvp9jjtsiLCtv/Ut71sXFnAus04xopgA8=;
          h=From:To:Cc:Subject;
          b=PIrbd8BDXZkv1Df6n08qb1uMiu7hpjmLH3bWbxCjjIUL7GWH59oW0nlJ8Hhd4Or46
           63FarSEdWg3ji5O9lCuZJuwRhyNl0xbikeFwjeASL3Rg+6VK3WuQHjd576xUeRD4Vv
           BvJni2iymy1+i+xhm5raKG65FhQha1lboarEvm3o=
Received: from unknown (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rsalvaterra@gmail.com>; 25 May 2020 10:17:44 +0200
Date:   Mon, 25 May 2020 10:17:33 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     kvalo@codeaurora.org, Larry.Finger@lwfinger.net,
        linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
Message-ID: <20200525081733.GA919245@wp.pl>
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
 <20200524111751.GA914918@wp.pl>
 <CALjTZvbHbMEWTmZk4Li5ZNAETdVd3Q_kHUS6KQw+WDS6ayE9vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvbHbMEWTmZk4Li5ZNAETdVd3Q_kHUS6KQw+WDS6ayE9vA@mail.gmail.com>
X-WP-MailID: b9c22e936d5e82e9115eb092458a2943
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [EVPk]                               
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello

On Sun, May 24, 2020 at 04:07:23PM +0100, Rui Salvaterra wrote:
> Hi, Stanislaw,
> 
> On Sun, 24 May 2020 at 12:18, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> >
> > AFICT more work need to be done to support MFP by HW encryption properly
> > on rt2x00. See this message and whole thread:
> > https://lore.kernel.org/linux-wireless/977a3cf4-3ec5-4aaa-b3d4-eea2e8593652@nbd.name/
> >
> > Stanislaw
> 
> This RT2790 has been working just fine with my patch for hours. No
> hangs at all. What additional bad behaviour should I expect?

If you use new cipher like WLAN_CIPHER_SUITE_AES_CMAC (what I think is
default for MFP setups) things will work just fine, because all
encryption will be done by software.

For older ciphers that are offloaded to hardware, namely
WLAN_CIPHER_SUITE_CCMP, management frames like Disassociate, Deauthenticate,
Action, will not be sent properly encrypted.

On quoted thread described visible problem was lag and performance drop
due to failed A-MPDU aggregation session setup.

Stanislaw
