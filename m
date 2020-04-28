Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863D81BB7F7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgD1Hql (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 03:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgD1Hql (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 03:46:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D7C03C1A9;
        Tue, 28 Apr 2020 00:46:41 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jTKww-000vXm-5G; Tue, 28 Apr 2020 09:46:38 +0200
Message-ID: <40afd04ed8fb49088268e7d3316d3fef9aa8dbd9.camel@sipsolutions.net>
Subject: Re: linux-next: build failure after merge of the mac80211-next tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Apr 2020 09:46:37 +0200
In-Reply-To: <20200428074527.GA3912@curiosity> (sfid-20200428_094101_668130_D6E3CFA4)
References: <20200428122930.51b6a9c2@canb.auug.org.au>
         <c3922c972277ff627c0308a94dfe3f25ba3b333f.camel@sipsolutions.net>
         <20200428072543.GA2630@curiosity>
         <baae77876a4b73de83aa6dcc27257da231777c22.camel@sipsolutions.net>
         <20200428074527.GA3912@curiosity> (sfid-20200428_094101_668130_D6E3CFA4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-04-28 at 10:45 +0300, Sergey Matyukevich wrote:
> 
> Looks good. But I have a couple of questions:
> 
> - why cleanup vif->mgmt_frame_reg in wilc_mac_open ?

Otherwise wilc_update_mgmt_frame_registrations() will think there are no
changes whatsoever, and do nothing.

> - previously wilc_wfi_p2p_rx was called only for PROBE_REQ and ACTION,
>   now it will be called for all the other registred frames as well


Huh, good catch. How about this?

https://p.sipsolutions.net/51183f5492f05ea6.txt

johannes

