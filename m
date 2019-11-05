Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55BDEF860
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfKEJPN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:15:13 -0500
Received: from smtp-out.xnet.cz ([178.217.244.18]:28299 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730499AbfKEJPM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:15:12 -0500
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 04:15:11 EST
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 65CA550C5;
        Tue,  5 Nov 2019 10:08:56 +0100 (CET)
Received: from localhost (meh.true.cz [local])
        by meh.true.cz (OpenSMTPD) with ESMTPA id 71f6388f;
        Tue, 5 Nov 2019 10:08:46 +0100 (CET)
Date:   Tue, 5 Nov 2019 10:08:45 +0100
From:   Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH] Revert "mt76: mt76x0e: don't use hw encryption for
 MT7630E"
Message-ID: <20191105090845.GP22393@meh.true.cz>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
References: <1572860780-2403-1-git-send-email-sgruszka@redhat.com>
 <87eeymd98m.fsf@tynnyri.adurom.net>
 <20191105090043.GB4422@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105090043.GB4422@redhat.com>
X-PGP-Key: http://ynezz.true.cz/EC796FB2DC69CEF9.asc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> [2019-11-05 10:00:44]:

Hi,

> I provided the topic in the first reference of the commit at the top.
> Should I do this anytime in the chenglog when a commit is referenced,
> even if it's done already ?

 ./scripts/checkpatch.pl 0001-Revert-mt76-mt76x0e-don-t-use-hw-encryption-for-MT76.patch
 ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")'
 #8: 
 Since 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")

 ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")'
 #14: 
 fixed by 7bd0650be63c , we can enable HW encryption back.

-- ynezz
