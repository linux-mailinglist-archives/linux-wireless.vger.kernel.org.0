Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27659D70
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF1OCR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 10:02:17 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:51488 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1OCR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 10:02:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgrSA-0002wn-Ct; Fri, 28 Jun 2019 16:02:14 +0200
Message-ID: <d65164da5224fd9afbbe24316fc7d5982bc625aa.camel@sipsolutions.net>
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tom Psyborg <pozega.tomislav@gmail.com>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        linux-wireless@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:02:12 +0200
In-Reply-To: <CAKR_QVJ9EkhcG893SjVMgDb5S-W2=jas5JG+VQyLDx-R5MMK5w@mail.gmail.com> (sfid-20190617_133220_109254_0361D103)
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
         <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
         <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org>
         <CAKR_QV+dVx+LK1HyCo6CQZQ7ZX_u6ON0hEH5adNiJTB+XaP3WA@mail.gmail.com>
         <dc9039be42df8d241b14d4f673f3c472dc113991.camel@sipsolutions.net>
         <20190617070747.562b9388@mir>
         <e13d86030df7a5222ee144d85bbeec400ed8fa07.camel@sipsolutions.net>
         <20190617093658.46591254@mir>
         <CAKR_QVJ9EkhcG893SjVMgDb5S-W2=jas5JG+VQyLDx-R5MMK5w@mail.gmail.com>
         (sfid-20190617_133220_109254_0361D103)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tom,

> Checked out r10011 from openwrt git on May, 15; built images and
> flashed devices; tried to set up WDS (AP) + WDS (Client); got this in
> logs: https://forum.openwrt.org/t/ath10k-wds-support-missing/30346/15?u=psyborg

I'm not sure ... this is saying -ENOENT??

> Saw this patch in my inbox and checked openwrt sources, to find out
> there was v1 used:
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=package/kernel/mac80211/patches/subsys/390-nl-mac-80211-allow-4addr-AP-operation-on-crypto-cont.patch
> 
> Reverted v1 of the patch and patched manually to v3 (double checked),
> did not help.
> 
> Found patch that fixes problem and applied;
> https://github.com/openwrt/openwrt/pull/2048

I don't see how that's related.

> Now I got this in logs:
> https://forum.openwrt.org/t/wds-client-wont-stay-connected-prev-auth-not-valid-using-recent-snapshot-builds/38194/20?u=psyborg

Again, I don't see how that's related. This is telling you something
about keys etc.

All this stuff about openwrt etc. is very confusing.

Can you at least collect some tracing (trace-cmd) to show what's going
on?

johannes

