Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F3CA37F5
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfH3Npt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 09:45:49 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:37162 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfH3Npt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 09:45:49 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3hDn-0007re-1V; Fri, 30 Aug 2019 15:45:47 +0200
Message-ID: <a7fdd85c7150589e35ac36c7aef38cb3de63bab8.camel@sipsolutions.net>
Subject: Re: [PATCH v6] mac80211_hwsim: Register support for HE meshpoint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <j@w1.fi>
Cc:     Sven Eckelmann <sven@narfation.org>, linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 15:45:44 +0200
In-Reply-To: <20190830133737.GC21204@w1.fi>
References: <20190813063657.7544-1-sven@narfation.org>
         <20190813105549.GA26160@w1.fi> <3127506.552nsDcnha@bentobox>
         <766f6d196106fa7ca6036b2ce20243e042d9168d.camel@sipsolutions.net>
         <20190830133737.GC21204@w1.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-08-30 at 16:37 +0300, Jouni Malinen wrote:
> On Fri, Aug 30, 2019 at 12:38:20PM +0200, Johannes Berg wrote:
> > > > mesh_secure_ocv_mix_legacy
> > > > wpas_mesh_open_ht40
> > > > mesh_secure_ocv_mix_ht
> > > No, these also failed for me without the mac80211_hwsim patch [3] in a full 
> > > test run. And thus not analyzed further by me.
> > 
> > I also see these fail if (and only if) I have this patch applied.
> > 
> > I'm going to drop this patch (again) for now, even if the situation is
> > now better I still don't want to knowingly break things there.
> > 
> > Please resend once that's all sorted out.
> 
> I pushed the relevant wpa_supplicant changes into hostap.git and all the
> hwsim test cases pass now with the current snapshot when this
> mac80211_hwsim patch is included.

Great, thanks. I've resurrected the patch in patchwork, so no need to
resend.

johannes

