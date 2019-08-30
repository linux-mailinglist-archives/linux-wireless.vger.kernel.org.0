Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3FA37DE
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfH3Nhn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 09:37:43 -0400
Received: from mail.w1.fi ([212.71.239.96]:48838 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727434AbfH3Nhn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 09:37:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 99C8110F8C;
        Fri, 30 Aug 2019 13:37:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ysy4ALtN3t0D; Fri, 30 Aug 2019 13:37:40 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Fri, 30 Aug 2019 16:37:37 +0300
Date:   Fri, 30 Aug 2019 16:37:37 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Sven Eckelmann <sven@narfation.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6] mac80211_hwsim: Register support for HE meshpoint
Message-ID: <20190830133737.GC21204@w1.fi>
References: <20190813063657.7544-1-sven@narfation.org>
 <20190813105549.GA26160@w1.fi>
 <3127506.552nsDcnha@bentobox>
 <766f6d196106fa7ca6036b2ce20243e042d9168d.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <766f6d196106fa7ca6036b2ce20243e042d9168d.camel@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 30, 2019 at 12:38:20PM +0200, Johannes Berg wrote:
> > > mesh_secure_ocv_mix_legacy
> > > wpas_mesh_open_ht40
> > > mesh_secure_ocv_mix_ht
> 
> > No, these also failed for me without the mac80211_hwsim patch [3] in a full 
> > test run. And thus not analyzed further by me.
> 
> I also see these fail if (and only if) I have this patch applied.
> 
> I'm going to drop this patch (again) for now, even if the situation is
> now better I still don't want to knowingly break things there.
> 
> Please resend once that's all sorted out.

I pushed the relevant wpa_supplicant changes into hostap.git and all the
hwsim test cases pass now with the current snapshot when this
mac80211_hwsim patch is included.

-- 
Jouni Malinen                                            PGP id EFC895FA
