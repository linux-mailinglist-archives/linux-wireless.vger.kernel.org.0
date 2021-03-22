Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EAF343D3F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 10:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCVJwS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 05:52:18 -0400
Received: from ns.iliad.fr ([212.27.33.1]:47810 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCVJvp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 05:51:45 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2021 05:51:45 EDT
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id A589020E94;
        Mon, 22 Mar 2021 10:43:39 +0100 (CET)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 8F1E720971;
        Mon, 22 Mar 2021 10:43:39 +0100 (CET)
Message-ID: <5f037c3f8485a8c929548be6a153290ba9ae4f13.camel@freebox.fr>
Subject: Re: [PATCH] mac80211: don't apply flow control on management frames
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Date:   Mon, 22 Mar 2021 10:43:39 +0100
In-Reply-To: <20210319232800.0e876c800866.Id2b66eb5a17f3869b776c39b5ca713272ea09d5d@changeid>
References: <20210319232800.0e876c800866.Id2b66eb5a17f3869b776c39b5ca713272ea09d5d@changeid>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Mar 22 10:43:39 2021 +0100 (CET)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Fri, 2021-03-19 at 23:28 +0100, Johannes Berg wrote:

Hello Johannes,

> 
> Short-circuit the processing of management frames. To keep the
> impact minimal, only put them on the frags queue and check the
> tid == management only for doing that and to skip the airtime
> fairness checks, if applicable.

After your patch, what are the actual effects of HW_STA_MMPDU_TXQ and
HW_BUFF_MMPDU_TXQ ?

Thanks,

-- 
Maxime



