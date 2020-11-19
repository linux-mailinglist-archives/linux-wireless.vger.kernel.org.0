Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E127C2B8CE9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 09:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgKSILu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 03:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgKSILt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 03:11:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D262C0613CF;
        Thu, 19 Nov 2020 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jcbw/eyVfnbfdHJro1vHTXYTyRctErbkL+b276KdvN4=; b=IzeTUVpHy00R9lEekudlDEZQN7
        l76maYNe7DMK3exjc/lXmNMKHbBnJa1NQ4ndQXyljBuJNpfG8JvrymNCzwLlvc/gAG82vgstMMBX8
        RNIRnM8wfbpDTe0jvbe7ZWwf34t1Ow4NsQ9miK3RaSUwI35G83gVkq5Yog06+vEit/CFVWNc9oniX
        8CZinRo2FlWGiFEDl6WTJR6BWg/zDRnNXK1wh/xJuP5msx5A+V5aoVQg3xIWLyKNAPNbnPbsDUzR5
        JHuQXQu8EZiuvuFYYw7STBzSJA95NyZPBB26wRh98ZSUi/FCEM88V1W48fmzCtRipMG67sNCwV855
        Dh/jTnIQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kff2h-0002GY-4f; Thu, 19 Nov 2020 08:11:47 +0000
Date:   Thu, 19 Nov 2020 08:11:47 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        ath11k@lists.infradead.org, ath10k@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: Re: [PATCH 1/6] relay: allow the use of const callback structs
Message-ID: <20201119081147.GA8577@infradead.org>
References: <20201118165320.26829-1-jani.nikula@intel.com>
 <20201119081120.GA6149@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119081120.GA6149@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 19, 2020 at 08:11:20AM +0000, Christoph Hellwig wrote:
> Please also add a patch to mark all rchan_callbacks instances const
> while you're at it.

Oops, I just noticed you actually sent that one.
